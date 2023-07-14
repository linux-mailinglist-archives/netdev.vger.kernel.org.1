Return-Path: <netdev+bounces-18019-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D67D7542F3
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 20:59:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 695B41C215FC
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 18:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BEF915ADA;
	Fri, 14 Jul 2023 18:59:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D2E13715
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 18:59:50 +0000 (UTC)
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B2243599;
	Fri, 14 Jul 2023 11:59:45 -0700 (PDT)
Date: Fri, 14 Jul 2023 18:59:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1689361182; x=1689620382;
	bh=vTEXQsy5I1sAwpBFHoMArrcKh16g62bYZtrFncdMnrY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=d+yzh4UQFCP2Cbr3cvI3IQcfnWwuTKYapbrk7GNMQVRQcpwjkuOtLWkzPr0FXGAtJ
	 z+TCH4r8y4gt88kSzn1rtlWUWuScjygI+Kq9j8K0BGeYDF2n3lbZTV/riCP55ymqsz
	 6aTIyzJTcOFP/E13u3TyDhI5BOLuwiC0FTvYUsQVguvkqdxQ8y28bTYvBgznQOSzFz
	 tMjQjRVYZldX0bSeYd87dA2JRArZJoaITICrUA0GcfUmifHqLffIK6hHpmr1rm+pF8
	 cfiEdp14EKZKXiUDdneP047RAwohaH5cYGUfyWM2tIkli578tegiPHRtQ4xmUJ8BBq
	 zzPHkwbbjLkfw==
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, netdev@vger.kernel.org, kuba@kernel.org, andrew@lunn.ch, aliceryhl@google.com, miguel.ojeda.sandonis@gmail.com
Subject: Re: [PATCH v2 1/5] rust: core abstractions for network device drivers
Message-ID: <vHyrvfxpxBUo9f7TLe77RGwwkia9YYYxlLATrsRj9f-dPmiHw40yLdinqc9eGG4J2RE51hq1yukOOyF8FX0y93dAPQ6XWyjpNlRCPZNSAuI=@proton.me>
In-Reply-To: <20230710073703.147351-2-fujita.tomonori@gmail.com>
References: <20230710073703.147351-1-fujita.tomonori@gmail.com> <20230710073703.147351-2-fujita.tomonori@gmail.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> This patch adds very basic abstractions to implement network device
> drivers, corresponds to the kernel's net_device and net_device_ops
> structs with support for register_netdev/unregister_netdev functions.
>=20
> allows the const_maybe_uninit_zeroed feature for
> core::mem::MaybeUinit::<T>::zeroed() in const function.
>=20
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> ---
>  rust/bindings/bindings_helper.h |   2 +
>  rust/helpers.c                  |  16 ++
>  rust/kernel/lib.rs              |   3 +
>  rust/kernel/net.rs              |   5 +
>  rust/kernel/net/dev.rs          | 330 ++++++++++++++++++++++++++++++++
>  5 files changed, 356 insertions(+)
>  create mode 100644 rust/kernel/net.rs
>  create mode 100644 rust/kernel/net/dev.rs
>=20
> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_hel=
per.h
> index 3e601ce2548d..468bf606f174 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -7,6 +7,8 @@
>   */
>=20
>  #include <linux/errname.h>
> +#include <linux/etherdevice.h>
> +#include <linux/netdevice.h>
>  #include <linux/slab.h>
>  #include <linux/refcount.h>
>  #include <linux/wait.h>
> diff --git a/rust/helpers.c b/rust/helpers.c
> index bb594da56137..70d50767ff4e 100644
> --- a/rust/helpers.c
> +++ b/rust/helpers.c
> @@ -24,10 +24,26 @@
>  #include <linux/errname.h>
>  #include <linux/refcount.h>
>  #include <linux/mutex.h>
> +#include <linux/netdevice.h>
> +#include <linux/skbuff.h>
>  #include <linux/spinlock.h>
>  #include <linux/sched/signal.h>
>  #include <linux/wait.h>
>=20
> +#ifdef CONFIG_NET
> +void *rust_helper_netdev_priv(const struct net_device *dev)
> +{
> +=09return netdev_priv(dev);
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_netdev_priv);
> +
> +void rust_helper_skb_tx_timestamp(struct sk_buff *skb)
> +{
> +=09skb_tx_timestamp(skb);
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_skb_tx_timestamp);
> +#endif
> +
>  __noreturn void rust_helper_BUG(void)
>  {
>  =09BUG();
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index 85b261209977..fc7d048d359d 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -13,6 +13,7 @@
>=20
>  #![no_std]
>  #![feature(allocator_api)]
> +#![feature(const_maybe_uninit_zeroed)]
>  #![feature(coerce_unsized)]
>  #![feature(dispatch_from_dyn)]
>  #![feature(new_uninit)]
> @@ -34,6 +35,8 @@
>  pub mod error;
>  pub mod init;
>  pub mod ioctl;
> +#[cfg(CONFIG_NET)]
> +pub mod net;
>  pub mod prelude;
>  pub mod print;
>  mod static_assert;
> diff --git a/rust/kernel/net.rs b/rust/kernel/net.rs
> new file mode 100644
> index 000000000000..28fe8f398463
> --- /dev/null
> +++ b/rust/kernel/net.rs
> @@ -0,0 +1,5 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Networking core.
> +
> +pub mod dev;
> diff --git a/rust/kernel/net/dev.rs b/rust/kernel/net/dev.rs
> new file mode 100644
> index 000000000000..fe20616668a9
> --- /dev/null
> +++ b/rust/kernel/net/dev.rs
> @@ -0,0 +1,330 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Network device.
> +//!
> +//! C headers: [`include/linux/etherdevice.h`](../../../../include/linux=
/etherdevice.h),
> +//! [`include/linux/ethtool.h`](../../../../include/linux/ethtool.h),
> +//! [`include/linux/netdevice.h`](../../../../include/linux/netdevice.h)=
,
> +//! [`include/linux/skbuff.h`](../../../../include/linux/skbuff.h),
> +//! [`include/uapi/linux/if_link.h`](../../../../include/uapi/linux/if_l=
ink.h).
> +
> +use crate::{bindings, build_error, error::*, prelude::vtable, types::For=
eignOwnable};
> +use {core::ffi::c_void, core::marker::PhantomData};
> +
> +/// Corresponds to the kernel's `struct net_device`.
> +///
> +/// # Invariants
> +///
> +/// The `ptr` points to the contiguous memory for `struct net_device` an=
d a pointer,
> +/// which stores an address returned by `ForeignOwnable::into_foreign()`=
.
> +pub struct Device<D: ForeignOwnable + Send + Sync> {
> +    ptr: *mut bindings::net_device,
> +    _p: PhantomData<D>,
> +}
> +
> +impl<D: ForeignOwnable + Send + Sync> Device<D> {
> +    /// Creates a new [`Device`] instance.
> +    ///
> +    /// # Safety
> +    ///
> +    /// Callers must ensure that `ptr` must point to the contiguous memo=
ry
> +    /// for `struct net_device` and a pointer, which stores an address r=
eturned
> +    /// by `ForeignOwnable::into_foreign()`.
> +    unsafe fn from_ptr(ptr: *mut bindings::net_device) -> Self {
> +        // INVARIANT: The safety requirements ensure the invariant.
> +        Self {
> +            ptr,
> +            _p: PhantomData,
> +        }
> +    }
> +
> +    /// Gets the private data of a device driver.
> +    pub fn drv_priv_data(&self) -> D::Borrowed<'_> {
> +        // SAFETY: The type invariants guarantee that self.ptr is valid =
and
> +        // bindings::netdev_priv(self.ptr) returns a pointer that stores=
 an address
> +        // returned by `ForeignOwnable::into_foreign()`.
> +        unsafe {
> +            D::borrow(core::ptr::read(
> +                bindings::netdev_priv(self.ptr) as *const *const c_void
> +            ))
> +        }
> +    }
> +}
> +
> +// SAFETY: `Device` is just a wrapper for the kernel`s `struct net_devic=
e`, which can be used
> +// from any thread. `struct net_device` stores a pointer to an object, w=
hich is `Sync`
> +// so it's safe to sharing its pointer.
> +unsafe impl<D: ForeignOwnable + Send + Sync> Send for Device<D> {}
> +// SAFETY: `Device` is just a wrapper for the kernel`s `struct net_devic=
e`, which can be used
> +// from any thread. `struct net_device` stores a pointer to an object, w=
hich is `Sync`,
> +// can be used from any thread too.
> +unsafe impl<D: ForeignOwnable + Send + Sync> Sync for Device<D> {}
> +
> +/// Registration structure for a network device driver.
> +///
> +/// This allocates and owns a `struct net_device` object.
> +/// Once the `net_device` object is registered via `register_netdev` fun=
ction,
> +/// the kernel calls various functions such as `struct net_device_ops` o=
perations with
> +/// the `net_device` object.
> +///
> +/// A driver must implement `struct net_device_ops` so the trait for it =
is tied.
> +/// Other operations like `struct ethtool_ops` are optional.
> +pub struct Registration<T: DeviceOperations> {
> +    dev: Device<T>,
> +    is_registered: bool,
> +    _p: PhantomData<T>,
> +}
> +
> +impl<T: DeviceOperations> Drop for Registration<T> {
> +    fn drop(&mut self) {
> +        // SAFETY: The type invariants of `Device` guarantee that `self.=
dev.ptr` is valid and
> +        // bindings::netdev_priv(self.ptr) returns a pointer that stores=
 an address
> +        // returned by `ForeignOwnable::into_foreign()`.
> +        unsafe {
> +            let _ =3D T::from_foreign(core::ptr::read(
> +                bindings::netdev_priv(self.dev.ptr) as *const *const c_v=
oid
> +            ));
> +        }
> +        // SAFETY: The type invariants of `Device` guarantee that `self.=
dev.ptr` is valid.
> +        unsafe {
> +            if self.is_registered {
> +                bindings::unregister_netdev(self.dev.ptr);
> +            }
> +            bindings::free_netdev(self.dev.ptr);
> +        }
> +    }
> +}
> +
> +impl<T: DeviceOperations> Registration<T> {
> +    /// Creates a new [`Registration`] instance for ethernet device.
> +    ///
> +    /// A device driver can pass private data.
> +    pub fn try_new_ether(tx_queue_size: u32, rx_queue_size: u32, data: T=
) -> Result<Self> {
> +        // SAFETY: Just an FFI call with no additional safety requiremen=
ts.
> +        let ptr =3D unsafe {
> +            bindings::alloc_etherdev_mqs(
> +                core::mem::size_of::<*const c_void>() as i32,
> +                tx_queue_size,
> +                rx_queue_size,
> +            )
> +        };
> +        if ptr.is_null() {
> +            return Err(code::ENOMEM);
> +        }
> +
> +        // SAFETY: It's safe to write an address returned pointer
> +        // from `netdev_priv()` because `alloc_etherdev_mqs()` allocates
> +        // contiguous memory for `struct net_device` and a pointer.
> +        unsafe {
> +            let priv_ptr =3D bindings::netdev_priv(ptr) as *mut *const c=
_void;
> +            core::ptr::write(priv_ptr, data.into_foreign());
> +        }
> +
> +        // SAFETY: `ptr` points to contiguous memory for `struct net_dev=
ice` and a pointer,
> +        // which stores an address returned by `ForeignOwnable::into_for=
eign()`.
> +        let dev =3D unsafe { Device::from_ptr(ptr) };
> +        Ok(Registration {
> +            dev,
> +            is_registered: false,
> +            _p: PhantomData,
> +        })
> +    }
> +
> +    /// Returns a network device.
> +    ///
> +    /// A device driver normally configures the device before registrati=
on.
> +    pub fn dev_get(&mut self) -> &mut Device<T> {
> +        &mut self.dev
> +    }

I think you could instead implement `AsMut`.

> +
> +    /// Registers a network device.
> +    pub fn register(&mut self) -> Result {
> +        if self.is_registered {
> +            return Err(code::EINVAL);
> +        }
> +        // SAFETY: The type invariants guarantee that `self.dev.ptr` is =
valid.
> +        let ret =3D unsafe {
> +            (*self.dev.ptr).netdev_ops =3D &Self::DEVICE_OPS;
> +            bindings::register_netdev(self.dev.ptr)
> +        };
> +        if ret !=3D 0 {
> +            Err(Error::from_errno(ret))
> +        } else {
> +            self.is_registered =3D true;
> +            Ok(())
> +        }
> +    }
> +
> +    const DEVICE_OPS: bindings::net_device_ops =3D bindings::net_device_=
ops {
> +        ndo_init: if <T>::HAS_INIT {
> +            Some(Self::init_callback)
> +        } else {
> +            None
> +        },
> +        ndo_uninit: if <T>::HAS_UNINIT {
> +            Some(Self::uninit_callback)
> +        } else {
> +            None
> +        },
> +        ndo_open: if <T>::HAS_OPEN {
> +            Some(Self::open_callback)
> +        } else {
> +            None
> +        },
> +        ndo_stop: if <T>::HAS_STOP {
> +            Some(Self::stop_callback)
> +        } else {
> +            None
> +        },
> +        ndo_start_xmit: if <T>::HAS_START_XMIT {
> +            Some(Self::start_xmit_callback)
> +        } else {
> +            None
> +        },
> +        // SAFETY: The rest is zeroed out to initialize `struct net_devi=
ce_ops`,
> +        // set `Option<&F>` to be `None`.
> +        ..unsafe { core::mem::MaybeUninit::<bindings::net_device_ops>::z=
eroed().assume_init() }
> +    };
> +
> +    unsafe extern "C" fn init_callback(netdev: *mut bindings::net_device=
) -> core::ffi::c_int {
> +        from_result(|| {
> +            // SAFETY: The C API guarantees that `netdev` is valid while=
 this function is running.
> +            let dev =3D unsafe { Device::from_ptr(netdev) };
> +            T::init(dev)?;
> +            Ok(0)
> +        })
> +    }
> +
> +    unsafe extern "C" fn uninit_callback(netdev: *mut bindings::net_devi=
ce) {
> +        // SAFETY: The C API guarantees that `netdev` is valid while thi=
s function is running.
> +        let dev =3D unsafe { Device::from_ptr(netdev) };
> +        T::uninit(dev);
> +    }
> +
> +    unsafe extern "C" fn open_callback(netdev: *mut bindings::net_device=
) -> core::ffi::c_int {
> +        from_result(|| {
> +            // SAFETY: The C API guarantees that `netdev` is valid while=
 this function is running.
> +            let dev =3D unsafe { Device::from_ptr(netdev) };
> +            T::open(dev)?;
> +            Ok(0)
> +        })
> +    }
> +
> +    unsafe extern "C" fn stop_callback(netdev: *mut bindings::net_device=
) -> core::ffi::c_int {
> +        from_result(|| {
> +            // SAFETY: The C API guarantees that `netdev` is valid while=
 this function is running.
> +            let dev =3D unsafe { Device::from_ptr(netdev) };
> +            T::stop(dev)?;
> +            Ok(0)
> +        })
> +    }
> +
> +    unsafe extern "C" fn start_xmit_callback(
> +        skb: *mut bindings::sk_buff,
> +        netdev: *mut bindings::net_device,
> +    ) -> bindings::netdev_tx_t {
> +        // SAFETY: The C API guarantees that `netdev` is valid while thi=
s function is running.
> +        let dev =3D unsafe { Device::from_ptr(netdev) };
> +        // SAFETY: The C API guarantees that `skb` is valid until a driv=
er releases the skb.
> +        let skb =3D unsafe { SkBuff::from_ptr(skb) };
> +        T::start_xmit(dev, skb) as bindings::netdev_tx_t
> +    }
> +}
> +
> +// SAFETY: `Registration` exposes only `Device` object which can be used=
 from any thread.
> +unsafe impl<T: DeviceOperations> Send for Registration<T> {}
> +// SAFETY: `Registration` exposes only `Device` object which can be used=
 from any thread.
> +unsafe impl<T: DeviceOperations> Sync for Registration<T> {}
> +
> +/// Corresponds to the kernel's `enum netdev_tx`.
> +#[repr(i32)]
> +pub enum TxCode {
> +    /// Driver took care of packet.
> +    Ok =3D bindings::netdev_tx_NETDEV_TX_OK,
> +    /// Driver tx path was busy.
> +    Busy =3D bindings::netdev_tx_NETDEV_TX_BUSY,
> +}

Is it really necessary that this has the same representation as the
C constants? Would a function that converts be sufficient? I think we
should let the compiler decide the layout when we have no concrete
requirements.

> +
> +/// Corresponds to the kernel's `struct net_device_ops`.
> +///
> +/// A device driver must implement this. Only very basic operations are =
supported for now.
> +#[vtable]
> +pub trait DeviceOperations: ForeignOwnable + Send + Sync {
> +    /// Corresponds to `ndo_init` in `struct net_device_ops`.
> +    fn init(_dev: Device<Self>) -> Result {
> +        Ok(())
> +    }
> +
> +    /// Corresponds to `ndo_uninit` in `struct net_device_ops`.
> +    fn uninit(_dev: Device<Self>) {}
> +
> +    /// Corresponds to `ndo_open` in `struct net_device_ops`.
> +    fn open(_dev: Device<Self>) -> Result {
> +        Ok(())
> +    }
> +
> +    /// Corresponds to `ndo_stop` in `struct net_device_ops`.
> +    fn stop(_dev: Device<Self>) -> Result {
> +        Ok(())
> +    }
> +
> +    /// Corresponds to `ndo_start_xmit` in `struct net_device_ops`.
> +    fn start_xmit(_dev: Device<Self>, _skb: SkBuff) -> TxCode {
> +        TxCode::Busy
> +    }
> +}
> +
> +/// Corresponds to the kernel's `struct sk_buff`.
> +///
> +/// A driver manages `struct sk_buff` in two ways. In both ways, the own=
ership is transferred
> +/// between C and Rust. The allocation and release are done asymmetrical=
ly.
> +///
> +/// On the tx side (`ndo_start_xmit` operation in `struct net_device_ops=
`), the kernel allocates
> +/// a `sk_buff' object and passes it to the driver. The driver is respon=
sible for the release
> +/// after transmission.
> +/// On the rx side, the driver allocates a `sk_buff` object then passes =
it to the kernel
> +/// after receiving data.
> +///
> +/// A driver must explicitly call a function to drop a `sk_buff` object.
> +/// The code to let a `SkBuff` object go out of scope can't be compiled.
> +///
> +/// # Invariants
> +///
> +/// The pointer is valid.
> +pub struct SkBuff(*mut bindings::sk_buff);
> +
> +impl SkBuff {
> +    /// Creates a new [`SkBuff`] instance.
> +    ///
> +    /// # Safety
> +    ///
> +    /// Callers must ensure that `ptr` must be valid.
> +    unsafe fn from_ptr(ptr: *mut bindings::sk_buff) -> Self {
> +        // INVARIANT: The safety requirements ensure the invariant.
> +        Self(ptr)
> +    }
> +
> +    /// Provides a time stamp.
> +    pub fn tx_timestamp(&mut self) {
> +        // SAFETY: The type invariants guarantee that `self.0` is valid.
> +        unsafe {
> +            bindings::skb_tx_timestamp(self.0);
> +        }
> +    }
> +
> +    /// Consumes a [`sk_buff`] object.
> +    pub fn consume(self) {
> +        // SAFETY: The type invariants guarantee that `self.0` is valid.
> +        unsafe {
> +            bindings::kfree_skb_reason(self.0, bindings::skb_drop_reason=
_SKB_CONSUMED);
> +        }
> +        core::mem::forget(self);

I read the prior discussion and I just wanted to make one thing sure:
dropping the `sk_buff` is not required for the safety of a program (of cour=
se
it still is a leak and that is not good), so it does not mean UB can occur
at some later point.

If leaking a `sk_buff` is fine, then I have no complaints, but we need to
keep this in mind when reviewing code that uses `sk_buff`, since there
using `forget` or other ways of leaking objects should not happen.

--
Cheers,
Benno

> +    }
> +}
> +
> +impl Drop for SkBuff {
> +    #[inline(always)]
> +    fn drop(&mut self) {
> +        build_error!("skb must be released explicitly");
> +    }
> +}
> --
> 2.34.1
>=20


