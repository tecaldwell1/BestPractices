include(scalapackfx.m4)

!> High level Fortran wrappers for the SCALAPACK library.
module scalapackfx_module
  use scalapackfx_common_module
  use blacsfx_module
  use scalapack_module
  implicit none
  private

  public :: DLEN_, DT_, CTXT_, M_, N_, MB_, NB_, RSRC_, CSRC_, LLD_
  public :: scalafx_ppotrf
  public :: scalafx_psygst
  public :: scalafx_phegst
  public :: scalafx_psyev
  public :: scalafx_psygv
  public :: scalafx_pheev
  public :: scalafx_phegv
  public :: scalafx_psyevd
  public :: scalafx_psygvd
  public :: scalafx_pheevd
  public :: scalafx_phegvd
  public :: scalafx_ptrsm
  public :: scalafx_getdescriptor
  public :: scalafx_getlocalshape
  public :: scalafx_infog2l
  public :: scalafx_creatematrix


  !> Cholesky factorization of a symmetric/Hermitian positive definite matrix.
  interface scalafx_ppotrf
    module procedure scalafx_ppotrf_real, scalafx_ppotrf_dreal
    module procedure scalafx_ppotrf_complex, scalafx_ppotrf_dcomplex
  end interface scalafx_ppotrf
  
  !> Reduces symmetric definite generalized eigenvalue problem to standard form.
  interface scalafx_psygst
    module procedure scalafx_psygst_real, scalafx_psygst_dreal
  end interface scalafx_psygst

  !> Reduces Hermitian definite generalized eigenvalue problem to standard form.
  interface scalafx_phegst
    module procedure scalafx_phegst_complex, scalafx_phegst_dcomplex
  end interface scalafx_phegst

  !> Solves symmetric eigenvalue problem by the QR algorithm.
  interface scalafx_psyev
    module procedure scalafx_psyev_real, scalafx_psyev_dreal
  end interface scalafx_psyev

  !> Solves Hermitian eigenvalue problem by the QR algorithm.
  interface scalafx_pheev
    module procedure scalafx_pheev_complex, scalafx_pheev_dcomplex
  end interface scalafx_pheev

  !> Solves generalized symmetric eigenvalue problem by the QR algorithm.
  interface scalafx_psygv
    module procedure scalafx_psygv_real, scalafx_psygv_dreal
  end interface scalafx_psygv

  !> Solves generalized Hermitian eigenvalue problem by the QR algorithm.
  interface scalafx_phegv
    module procedure scalafx_phegv_complex, scalafx_phegv_dcomplex
  end interface scalafx_phegv

  !> Solves symmetric eigenvalue problem by the divide and conquer algorithm.
  interface scalafx_psyevd
    module procedure scalafx_psyevd_real, scalafx_psyevd_dreal
  end interface scalafx_psyevd

  !> Solves Hermitian eigenvalue problem by the divide and conquer algorithm.
  interface scalafx_pheevd
    module procedure scalafx_pheevd_complex, scalafx_pheevd_dcomplex
  end interface scalafx_pheevd

  !> Solves generalized symmetric eigenvalue problem by the divide and conquer
  !! algorithm.
  interface scalafx_psygvd
    module procedure scalafx_psygvd_real, scalafx_psygvd_dreal
  end interface scalafx_psygvd

  !> Solves generalized Hermitian eigenvalue problem by the divide and conquer
  !! algorithm.
  interface scalafx_phegvd
    module procedure scalafx_phegvd_complex, scalafx_phegvd_dcomplex
  end interface scalafx_phegvd

  !> Solves triangular matrix equation.
  interface scalafx_ptrsm
    module procedure scalafx_ptrsm_real, scalafx_ptrsm_dreal
    module procedure scalafx_ptrsm_complex, scalafx_ptrsm_dcomplex
  end interface scalafx_ptrsm

  !> Creates a distributed matrix and allocates local storage.
  interface scalafx_creatematrix
    module procedure scalafx_creatematrix_int
    module procedure scalafx_creatematrix_real, scalafx_creatematrix_dreal
    module procedure scalafx_creatematrix_complex, scalafx_creatematrix_dcomplex
  end interface scalafx_creatematrix

contains

  _subroutine_scalafx_ppotrf(real, real(sp))
  _subroutine_scalafx_ppotrf(dreal, real(dp))
  _subroutine_scalafx_ppotrf(complex, complex(sp))
  _subroutine_scalafx_ppotrf(dcomplex, complex(dp))

  _subroutine_scalafx_psygst_phegst(real, real(sp), real(sp), psygst)
  _subroutine_scalafx_psygst_phegst(dreal, real(dp), real(dp), psygst)
  _subroutine_scalafx_psygst_phegst(complex, complex(sp), real(sp), phegst)
  _subroutine_scalafx_psygst_phegst(dcomplex, complex(dp), real(dp), phegst)

  _subroutine_scalafx_psyev(real, sp)
  _subroutine_scalafx_psyev(dreal, dp)
  _subroutine_scalafx_pheev(complex, sp)
  _subroutine_scalafx_pheev(dcomplex, dp)

  _subroutine_scalafx_psygv(real, sp)
  _subroutine_scalafx_psygv(dreal, dp)
  _subroutine_scalafx_phegv(complex, sp)
  _subroutine_scalafx_phegv(dcomplex, dp)

  _subroutine_scalafx_psyevd(real, sp)
  _subroutine_scalafx_psyevd(dreal, dp)
  _subroutine_scalafx_pheevd(complex, sp)
  _subroutine_scalafx_pheevd(dcomplex, dp)

  _subroutine_scalafx_psygvd(real, sp)
  _subroutine_scalafx_psygvd(dreal, dp)
  _subroutine_scalafx_phegvd(complex, sp)
  _subroutine_scalafx_phegvd(dcomplex, dp)

  _subroutine_scalafx_ptrsm(real, real(sp), real(1.0, sp))
  _subroutine_scalafx_ptrsm(dreal, real(dp), real(1.0, dp))
  _subroutine_scalafx_ptrsm(complex, complex(sp), cmplx(1, 0, sp))
  _subroutine_scalafx_ptrsm(dcomplex, complex(dp), cmplx(1, 0, dp))

  _subroutine_scalafx_creatematrix(int, integer)
  _subroutine_scalafx_creatematrix(real, real(sp))
  _subroutine_scalafx_creatematrix(dreal, real(dp))
  _subroutine_scalafx_creatematrix(complex, complex(sp))
  _subroutine_scalafx_creatematrix(dcomplex, complex(dp))


  !> Returns descriptor and size for the local part of a distributed matrix.
  !! \param mygrid  BLACS descriptor.
  !! \param mm  Number of rows of global matrix.
  !! \param nn  Number of columns of global matrix.
  !! \param mb  Row block size.
  !! \param nb  Column block size.
  !! \param desc  Matrix descriptor on exit.
  !! \param nrowloc  Number of rows for local matrix.
  !! \param ncolloc  Number of columns for local matrix.
  !! \param rsrc  Process row, over which first row is distributed
  !!     (default: master row).
  !! \param csrc  Process column, over which first column is distributed
  !!     (default: master column).
  !! \param info  Info flag.
  subroutine scalafx_getdescriptor(mygrid, mm, nn, mb, nb, desc, rsrc, csrc, &
      & info)
    type(blacsgrid), intent(in) :: mygrid
    integer, intent(in) :: mm, nn, mb, nb
    integer, intent(out) :: desc(DLEN_)
    integer, intent(in), optional :: rsrc, csrc
    integer, intent(out), optional :: info

    integer :: rsrc0, csrc0, info0
    integer :: nrowloc

    _handle_inoptflag(rsrc0, rsrc, mygrid%masterrow)
    _handle_inoptflag(csrc0, csrc, mygrid%mastercol)
    ! At least one local row, as per definition LLD >= 1 in the descriptor.
    nrowloc = max(1, numroc(mm, mb, mygrid%myrow, rsrc0, mygrid%nrow))
    call descinit(desc, mm, nn, mb, nb, rsrc0, csrc0, mygrid%ctxt, nrowloc, &
        & info0)
    call handle_infoflag(info0, "descinit in scalafx_getdescriptor", info)

  end subroutine scalafx_getdescriptor


  !> Returns the shape of the local part of a distributed array.
  !!
  !! \param mygrid  BLACS grid descriptor.
  !! \param desc  Global matrix descriptor.
  !! \param nrowloc  Nr. of local rows.
  !! \param ncolloc  Nr. of local columns.
  !!
  subroutine scalafx_getlocalshape(mygrid, desc, nrowloc, ncolloc)
    type(blacsgrid), intent(in) :: mygrid
    integer, intent(in) :: desc(DLEN_)
    integer, intent(out) :: nrowloc, ncolloc

    nrowloc = max(1, numroc(desc(M_), desc(MB_), mygrid%myrow, desc(RSRC_), &
        & mygrid%nrow))
    ncolloc = numroc(desc(N_), desc(NB_), mygrid%mycol, desc(CSRC_), &
        & mygrid%ncol)

  end subroutine scalafx_getlocalshape


  !> Maps global position in a distributed matrix to local one.
  !! \param mygrid  BLACS descriptor.
  !! \param desc  Descriptor of the distributed matrix.
  !! \param grow  Global row index.
  !! \param gcol  Global column index.
  !! \param lrow  Local row index on output.
  !! \param lcol  Local column index on output.
  !! \param rsrc  Row of the process owning the local matrix.
  !! \param csrc  Column of the process owning the local matrix.
  subroutine scalafx_infog2l(mygrid, desc, grow, gcol, lrow, lcol, rsrc, csrc)
    type(blacsgrid), intent(in) :: mygrid
    integer, intent(in) :: desc(DLEN_)
    integer, intent(in) :: grow, gcol
    integer, intent(out) :: lrow, lcol
    integer, intent(out) :: rsrc, csrc

    call infog2l(grow, gcol, desc, mygrid%nrow, mygrid%ncol, mygrid%myrow,&
        & mygrid%mycol, lrow, lcol, rsrc, csrc)

  end subroutine scalafx_infog2l


end module scalapackfx_module
