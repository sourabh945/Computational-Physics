program main 
    implicit none

    real , allocatable :: x(:),y(:),diff(:)
    real :: val , p , result
    integer :: i , j , n ,index,row

    print*, "Enter the number of the given points : "
    read*, n

    allocate(x(n),y(n),diff(fact(n-1)))

    print*, "Enter the value of x and y : "
    print*, "x      y"
    read*, (x(i),y(i),i=1,n)

    print*, "Enter value of x (where the value of fxn is unknown) : "
    read*, val

    index = cal_x0_index(val)

    if (index == 0) stop "The value of x is lower than lower limit"

    row = 0

    do i = 1,n-index
        do j = index,n-i
            if (i==1) then
                diff(j) = y(j+1) - y(j)
            else
                diff(row+j) = diff(row-n+i+j) - diff(row-n+i+j-1)
            endif
        enddo
        row = row + n-i
    enddo

    p = (val - x(index))/(x(2) - x(1))
    result = y(index)

    row = 0

    do i = 1, n-index
        result = result + p*diff(row+index)/real(fact(i))
        p = p*(p-i)
        row = row + n-i
    enddo

    print*, "The value of f(X) at ",val," is :: ",result

    stop

contains 
    integer function fact(valu)
        integer , intent(in) :: valu
        integer :: l , res 
        res = 1
        if (valu == 1) then
            fact = 1
            return
        endif
        do l = 2, valu
            res= res*l
        enddo
        fact = res
        return 
    end function fact

    integer function cal_x0_index(value)
        real , intent(in) :: value
        integer :: k
        do k = 1,n
            if (x(k) > value) then
                cal_x0_index = k-1
                return 
            endif
        enddo
        stop "Value of x  is over the upper limit"
    end function cal_x0_index
end program    