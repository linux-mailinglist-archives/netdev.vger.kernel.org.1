Return-Path: <netdev+bounces-13818-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E91E473D174
	for <lists+netdev@lfdr.de>; Sun, 25 Jun 2023 16:27:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDD761C208D4
	for <lists+netdev@lfdr.de>; Sun, 25 Jun 2023 14:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8FD6613E;
	Sun, 25 Jun 2023 14:27:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964161FCB
	for <netdev@vger.kernel.org>; Sun, 25 Jun 2023 14:27:43 +0000 (UTC)
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 374EEC6;
	Sun, 25 Jun 2023 07:27:38 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-54f85f968a0so248887a12.1;
        Sun, 25 Jun 2023 07:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687703257; x=1690295257;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aULwL/LJJ4eU0UOAddS927hL1AwSCDydj7bd2EhU7vc=;
        b=HetoUZJKJS4mfVnq+3aOsCiarqqbyfUAlEncYvSxzHLKlPYbmgopL1H2Q8J87/VX7u
         mIAJQF020jcwSEjCGyqRK83xiiG16bCXLcKKktjnO61tr1krBwApyUCOXycuNKBe/9bd
         OknEa3+x7DEhwjTzZtoT4/Jg0fTB/CEfMnlzIHaOdtGANhCyXsmkhm7cgB7Y8/IvsOAs
         z0USHaooa8NvnQECpjW4j2PRE1lHOR64Abj5/0blrOY4vy+fnjzVXBXF+6SjeIJ7rcjv
         Cyqcur3GePoG16c+aXLUDMM8HYem9SJvkCzIMuBMzOzdyUWINLpc6rrcI+pECKOgtHlq
         yhPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687703257; x=1690295257;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aULwL/LJJ4eU0UOAddS927hL1AwSCDydj7bd2EhU7vc=;
        b=WxaFZjBmUPu5uExdhzhK4ZWonWD0Sy7Sp/g8XMK4IBUKxOJL8CvpvS1Wy+XPj7Mkxt
         wlI6kE1k/NItHjNkAIYAOvwqGptNh/+/ZwtrzHySUoloiV8PsksE1Ul8Z/JKGE4e0SmW
         CH9ZoevibkhxesNRN2GaUROjdmKwXS8Aq32wZAeqCcc9hvgMBrXv/XNQDCrnysI5kBU6
         ifVYbkAEcZrUYA1s1RZp5jBAAwrDR8Ecz38beoSZBwYQ2JR3ihYHG4cOnV0RcFU0I7Se
         Ne5liLTf91yXneUEIo0obneEYTczrnaMWYxa2YnCEJ/rnq1kAdSLzjaPmKo3DslDds5c
         yVtw==
X-Gm-Message-State: AC+VfDwHNixUgmp95zySDP2qyIwz75tIoRcArBhKsvqEW/4yFqamtJJQ
	UpHawiripCxbCwB9eMdJ6LY=
X-Google-Smtp-Source: ACHHUZ4FJ1goYXuIvZYHIiNvTCuIwseo8NGm9hCwGagKemaUJm2NoXSDi1x8LBjLlGIEoHYSGBDaHA==
X-Received: by 2002:a17:902:c945:b0:1ae:3ff8:7fa7 with SMTP id i5-20020a170902c94500b001ae3ff87fa7mr33034660pla.4.1687703257322;
        Sun, 25 Jun 2023 07:27:37 -0700 (PDT)
Received: from localhost (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id r4-20020a170902be0400b001b02713a301sm2521978pls.181.2023.06.25.07.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jun 2023 07:27:36 -0700 (PDT)
Date: Sun, 25 Jun 2023 23:27:36 +0900 (JST)
Message-Id: <20230625.232736.235121744769257487.ubuntu@gmail.com>
To: benno.lossin@proton.me
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, aliceryhl@google.com, andrew@lunn.ch,
 miguel.ojeda.sandonis@gmail.com
Subject: Re: [PATCH 1/5] rust: core abstractions for network device drivers
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <3ff6edec-c083-9294-d2df-01be983cd293@proton.me>
References: <_kID50ojyLurmrpIpn_kNxCRqo5MAaqm9pE47mhFcLops8yDhSqmbkhJiUuHlAFSdgqX1dHdZGxUa95ZSHAPHesIKLci1J21cu6nmdQ3ZGg=@proton.me>
	<20230621.221349.1237576739913195911.ubuntu@gmail.com>
	<3ff6edec-c083-9294-d2df-01be983cd293@proton.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

On Sun, 25 Jun 2023 09:52:53 +0000
Benno Lossin <benno.lossin@proton.me> wrote:

> On 6/21/23 15:13, FUJITA Tomonori wrote:
>> Hi,
>> Thanks for reviewing.
>> 
>> On Thu, 15 Jun 2023 13:01:50 +0000
>> Benno Lossin <benno.lossin@proton.me> wrote:
>> 
>>> On 6/13/23 06:53, FUJITA Tomonori wrote:
>>>> This patch adds very basic abstractions to implement network device
>>>> drivers, corresponds to the kernel's net_device and net_device_ops
>>>> structs with support for register_netdev/unregister_netdev functions.
>>>>
>>>> allows the const_maybe_uninit_zeroed feature for
>>>> core::mem::MaybeUinit::<T>::zeroed() in const function.
>>>>
>>>> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
>>>> ---
>>>>   rust/bindings/bindings_helper.h |   2 +
>>>>   rust/helpers.c                  |  16 ++
>>>>   rust/kernel/lib.rs              |   3 +
>>>>   rust/kernel/net.rs              |   5 +
>>>>   rust/kernel/net/dev.rs          | 344 ++++++++++++++++++++++++++++++++
>>>>   5 files changed, 370 insertions(+)
>>>>   create mode 100644 rust/kernel/net.rs
>>>>   create mode 100644 rust/kernel/net/dev.rs
>>>>
>>>> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
>>>> index 3e601ce2548d..468bf606f174 100644
>>>> --- a/rust/bindings/bindings_helper.h
>>>> +++ b/rust/bindings/bindings_helper.h
>>>> @@ -7,6 +7,8 @@
>>>>    */
>>>>
>>>>   #include <linux/errname.h>
>>>> +#include <linux/etherdevice.h>
>>>> +#include <linux/netdevice.h>
>>>>   #include <linux/slab.h>
>>>>   #include <linux/refcount.h>
>>>>   #include <linux/wait.h>
>>>> diff --git a/rust/helpers.c b/rust/helpers.c
>>>> index bb594da56137..70d50767ff4e 100644
>>>> --- a/rust/helpers.c
>>>> +++ b/rust/helpers.c
>>>> @@ -24,10 +24,26 @@
>>>>   #include <linux/errname.h>
>>>>   #include <linux/refcount.h>
>>>>   #include <linux/mutex.h>
>>>> +#include <linux/netdevice.h>
>>>> +#include <linux/skbuff.h>
>>>>   #include <linux/spinlock.h>
>>>>   #include <linux/sched/signal.h>
>>>>   #include <linux/wait.h>
>>>>
>>>> +#ifdef CONFIG_NET
>>>> +void *rust_helper_netdev_priv(const struct net_device *dev)
>>>> +{
>>>> +	return netdev_priv(dev);
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(rust_helper_netdev_priv);
>>>> +
>>>> +void rust_helper_skb_tx_timestamp(struct sk_buff *skb)
>>>> +{
>>>> +	skb_tx_timestamp(skb);
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(rust_helper_skb_tx_timestamp);
>>>> +#endif
>>>> +
>>>>   __noreturn void rust_helper_BUG(void)
>>>>   {
>>>>   	BUG();
>>>> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
>>>> index 85b261209977..fc7d048d359d 100644
>>>> --- a/rust/kernel/lib.rs
>>>> +++ b/rust/kernel/lib.rs
>>>> @@ -13,6 +13,7 @@
>>>>
>>>>   #![no_std]
>>>>   #![feature(allocator_api)]
>>>> +#![feature(const_maybe_uninit_zeroed)]
>>>>   #![feature(coerce_unsized)]
>>>>   #![feature(dispatch_from_dyn)]
>>>>   #![feature(new_uninit)]
>>>> @@ -34,6 +35,8 @@
>>>>   pub mod error;
>>>>   pub mod init;
>>>>   pub mod ioctl;
>>>> +#[cfg(CONFIG_NET)]
>>>> +pub mod net;
>>>>   pub mod prelude;
>>>>   pub mod print;
>>>>   mod static_assert;
>>>> diff --git a/rust/kernel/net.rs b/rust/kernel/net.rs
>>>> new file mode 100644
>>>> index 000000000000..28fe8f398463
>>>> --- /dev/null
>>>> +++ b/rust/kernel/net.rs
>>>> @@ -0,0 +1,5 @@
>>>> +// SPDX-License-Identifier: GPL-2.0
>>>> +
>>>> +//! Networking core.
>>>> +
>>>> +pub mod dev;
>>>> diff --git a/rust/kernel/net/dev.rs b/rust/kernel/net/dev.rs
>>>> new file mode 100644
>>>> index 000000000000..d072c81f99ce
>>>> --- /dev/null
>>>> +++ b/rust/kernel/net/dev.rs
>>>> @@ -0,0 +1,344 @@
>>>> +// SPDX-License-Identifier: GPL-2.0
>>>> +
>>>> +//! Network device.
>>>> +//!
>>>> +//! C headers: [`include/linux/etherdevice.h`](../../../../include/linux/etherdevice.h),
>>>> +//! [`include/linux/ethtool.h`](../../../../include/linux/ethtool.h),
>>>> +//! [`include/linux/netdevice.h`](../../../../include/linux/netdevice.h),
>>>> +//! [`include/linux/skbuff.h`](../../../../include/linux/skbuff.h),
>>>> +//! [`include/uapi/linux/if_link.h`](../../../../include/uapi/linux/if_link.h).
>>>> +
>>>> +use crate::{bindings, error::*, prelude::vtable, types::ForeignOwnable};
>>>> +use {core::ffi::c_void, core::marker::PhantomData};
>>>> +
>>>> +/// Corresponds to the kernel's `struct net_device`.
>>>> +///
>>>> +/// # Invariants
>>>> +///
>>>> +/// The pointer is valid.
>>>> +pub struct Device(*mut bindings::net_device);
>>>> +
>>>> +impl Device {
>>>> +    /// Creates a new [`Device`] instance.
>>>> +    ///
>>>> +    /// # Safety
>>>> +    ///
>>>> +    /// Callers must ensure that `ptr` must be valid.
>>>> +    unsafe fn from_ptr(ptr: *mut bindings::net_device) -> Self {
>>>> +        // INVARIANT: The safety requirements ensure the invariant.
>>>> +        Self(ptr)
>>>> +    }
>>>> +
>>>> +    /// Gets a pointer to network device private data.
>>>> +    fn priv_data_ptr(&self) -> *const c_void {
>>>> +        // SAFETY: The type invariants guarantee that `self.0` is valid.
>>>> +        // During the initialization of `Registration` instance, the kernel allocates
>>>> +        // contiguous memory for `struct net_device` and a pointer to its private data.
>>>> +        // So it's safe to read an address from the returned address from `netdev_priv()`.
>>>> +        unsafe { core::ptr::read(bindings::netdev_priv(self.0) as *const *const c_void) }
>>>
>>> Why are at least `size_of::<*const c_void>` bytes allocated? Why is it a
>>> `*const c_void` pointer? This function does not give any guarantees about
>>> this pointer, is it valid?
>> 
>> The reason is a device driver needs its data structure. It needs to
>> access to it via a pointer to bindings::net_device struct. The space
>> for the pointer is allocated during initialization of Registration and
>> it's valid until the Registration object is dropped.
> 
> I think this should be encoded in the type invariants of `Device`. 
> Because the safety comment needs some justification.
> 
>> 
>>> I know that you are allocating exactly this amount in `Registration`, but
>>> `Device` does not know about that. Should this be a type invariant?
>>> It might be a good idea to make `Driver` generic over `D`, the data that is
>>> stored behind this pointer. You could then return `D::Borrowed` instead.
>> 
>> We could do:
>> 
>> impl<D: DriverData> Device<D> {
>> ...
>>      /// Gets the private data of a device driver.
>>      pub fn drv_priv_data(&self) -> <D::Data as ForeignOwnable>::Borrowed<'_> {
>>          unsafe {
>>              D::Data::borrow(core::ptr::read(
>>                  bindings::netdev_priv(self.ptr) as *const *const c_void
>>              ))
>>          }
>>      }
>> }
> 
> LGTM (+ adding a Safety comment).
> 
>> 
>> 
>>>> +// SAFETY: `Device` is just a wrapper for the kernel`s `struct net_device`, which can be used
>>>> +// from any thread. `struct net_device` stores a pointer to `DriverData::Data`, which is `Sync`
>>>> +// so it's safe to sharing its pointer.
>>>> +unsafe impl Send for Device {}
>>>> +// SAFETY: `Device` is just a wrapper for the kernel`s `struct net_device`, which can be used
>>>> +// from any thread. `struct net_device` stores a pointer to `DriverData::Data`, which is `Sync`,
>>>> +// can be used from any thread too.
>>>> +unsafe impl Sync for Device {}
>>>> +
>>>> +/// Trait for device driver specific information.
>>>> +///
>>>> +/// This data structure is passed to a driver with the operations for `struct net_device`
>>>> +/// like `struct net_device_ops`, `struct ethtool_ops`, `struct rtnl_link_ops`, etc.
>>>> +pub trait DriverData {
>>>> +    /// The object are stored in C object, `struct net_device`.
>>>> +    type Data: ForeignOwnable + Send + Sync;
>>>
>>> Why is this an associated type? Could you not use
>>> `D: ForeignOwnable + Send + Sync` everywhere instead?
>>> I think this should be possible, since `DriverData` does not define
>>> anything else.
>> 
>> With that approach, is it possible to allow a device driver to define
>> own data structure and functions taking the structure as aurgument
>> (like DevOps structutre in the 5th patch)
>> 
> 
> In the example both structs are empty so I am not really sure why it has 
> to be two types. Can't we do this:
> ```
> pub struct MyDriver {
>      // Just some random fields...
>      pub access_count: Cell<usize>,
> }
> 
> 
> impl DriverData for Box<MyDriver> {}
> 
> // And then we could make `DeviceOperations: DriverData`.
> // Users would then do this:
> 
> #[vtable]
> impl DeviceOperations for Box<MyDriver> {
>      fn init(_dev: Device, data: &MyDriver) -> Result {
>          data.access_count.set(0);
>          Ok(())
>      }
> 
>      fn open(_dev: Device, data: &MyDriver) -> Result {
>          data.access_count.set(data.access_count.get() + 1);
>          Ok(())
>      }
> }
> ```
> 
> I think this would simplify things, because you do not have to carry the 
> extra associated type around (and have to spell out
> `<D::Data as ForeignOwnable>` everywhere).

I'm still not sure if I correctly understand what you try to do.

If I define DeviceOperations in dev.rs like the following:

#[vtable]
pub trait DeviceOperations<D: ForeignOwnable + Send + Sync> {
    /// Corresponds to `ndo_init` in `struct net_device_ops`.
        fn init(_dev: &mut Device, _data: D::Borrowed<'_>) -> Result {
	        Ok(())
        }
}

And the driver implmeents DeviceOperations like the folloing: 

#[vtable]
impl<D: ForeignOwnable + Send + Sync> DeviceOperations<D> for Box<DriverData> {
    fn init(_dev: &mut Device, _data: &DriverData) -> Result {
            Ok(())
    }
}

I got the following error:

error[E0053]: method `init` has an incompatible type for trait
  --> samples/rust/rust_net_dummy.rs:24:39
   |
24 |     fn init(_dev: &mut Device, _data: &DriverData) -> Result {
   |                                       ^^^^^^^^^^^
   |                                       |
   |                                       expected associated type, found `&DriverData`
   |                                       help: change the parameter type to match the trait: `<D as ForeignOwnable>::Borrowed<'_>`
   |
   = note: expected signature `fn(&mut Device, <D as ForeignOwnable>::Borrowed<'_>) -> core::result::Result<_, _>`
              found signature `fn(&mut Device, &DriverData) -> core::result::Result<_, _>`


>>>> +/// Registration structure for a network device driver.
>>>> +///
>>>> +/// This allocates and owns a `struct net_device` object.
>>>> +/// Once the `net_device` object is registered via `register_netdev` function,
>>>> +/// the kernel calls various functions such as `struct net_device_ops` operations with
>>>> +/// the `net_device` object.
>>>> +///
>>>> +/// A driver must implement `struct net_device_ops` so the trait for it is tied.
>>>> +/// Other operations like `struct ethtool_ops` are optional.
>>>> +pub struct Registration<T: DeviceOperations<D>, D: DriverData> {
>>>> +    dev: Device,
>>>> +    is_registered: bool,
>>>> +    _p: PhantomData<(D, T)>,
>>>> +}
>>>> +
>>>> +impl<D: DriverData, T: DeviceOperations<D>> Drop for Registration<T, D> {
>>>> +    fn drop(&mut self) {
>>>> +        // SAFETY: The type invariants guarantee that `self.dev.0` is valid.
>>>> +        unsafe {
>>>> +            let _ = D::Data::from_foreign(self.dev.priv_data_ptr());
>>>
>>> Why is `self.dev.priv_data_ptr()` a valid pointer?
>>> This `unsafe` block should be split to better explain the different safety
>>> requirements.
>> 
>> Explained above.
>> 
>>>> +            if self.is_registered {
>>>> +                bindings::unregister_netdev(self.dev.0);
>>>> +            }
>>>> +            bindings::free_netdev(self.dev.0);
>>>> +        }
>>>> +    }
>>>> +}
>>>> +
>>>> +impl<D: DriverData, T: DeviceOperations<D>> Registration<T, D> {
>>>> +    /// Creates a new [`Registration`] instance for ethernet device.
>>>> +    ///
>>>> +    /// A device driver can pass private data.
>>>> +    pub fn try_new_ether(tx_queue_size: u32, rx_queue_size: u32, data: D::Data) -> Result<Self> {
>>>> +        // SAFETY: FFI call.
>>>
>>> If this FFI call has no safety requirements then say so.
>> 
>> SAFETY: FFI call has no safety requirements.
>> 
>> ?
> 
> Yes you should just write that.
> 
>> 
>>>> +    const DEVICE_OPS: bindings::net_device_ops = bindings::net_device_ops {
>>>> +        ndo_init: if <T>::HAS_INIT {
>>>> +            Some(Self::init_callback)
>>>> +        } else {
>>>> +            None
>>>> +        },
>>>> +        ndo_uninit: if <T>::HAS_UNINIT {
>>>> +            Some(Self::uninit_callback)
>>>> +        } else {
>>>> +            None
>>>> +        },
>>>> +        ndo_open: if <T>::HAS_OPEN {
>>>> +            Some(Self::open_callback)
>>>> +        } else {
>>>> +            None
>>>> +        },
>>>> +        ndo_stop: if <T>::HAS_STOP {
>>>> +            Some(Self::stop_callback)
>>>> +        } else {
>>>> +            None
>>>> +        },
>>>> +        ndo_start_xmit: if <T>::HAS_START_XMIT {
>>>> +            Some(Self::start_xmit_callback)
>>>> +        } else {
>>>> +            None
>>>> +        },
>>>> +        // SAFETY: The rest is zeroed out to initialize `struct net_device_ops`,
>>>> +        // set `Option<&F>` to be `None`.
>>>> +        ..unsafe { core::mem::MaybeUninit::<bindings::net_device_ops>::zeroed().assume_init() }
>>>> +    };
>>>> +
>>>> +    const fn build_device_ops() -> &'static bindings::net_device_ops {
>>>> +        &Self::DEVICE_OPS
>>>> +    }
>>>
>>> Why does this function exist?
>> 
>> To get const struct net_device_ops *netdev_ops.
> 
> Can't you just use `&Self::DEVICE_OPS`?

I think that it didn't work in the past but seems that it works
now. I'll fix.


>>>> +
>>>> +    unsafe extern "C" fn init_callback(netdev: *mut bindings::net_device) -> core::ffi::c_int {
>>>> +        from_result(|| {
>>>
>>> Since you are the first user of `from_result`, you can remove the
>>> `#[allow(dead_code)]` attribute.
>>>
>>> @Reviewers/Maintainers: Or would we prefer to make that change ourselves?
>> 
>> Ah, either is fine by me.
>> 
>>>> +            // SAFETY: The C API guarantees that `netdev` is valid while this function is running.
>>>> +            let mut dev = unsafe { Device::from_ptr(netdev) };
>>>> +            // SAFETY: The returned pointer was initialized by `D::Data::into_foreign` when
>>>> +            // `Registration` object was created.
>>>> +            // `D::Data::from_foreign` is only called by the object was released.
>>>> +            // So we know `data` is valid while this function is running.
>>>
>>> This should be a type invariant of `Registration`.
>> 
>> Understood.
>> 
>>>> +            let data = unsafe { D::Data::borrow(dev.priv_data_ptr()) };
>>>> +            T::init(&mut dev, data)?;
>>>> +            Ok(0)
>>>> +        })
>>>> +    }
>>>> +
>>>> +    unsafe extern "C" fn uninit_callback(netdev: *mut bindings::net_device) {
>>>> +        // SAFETY: The C API guarantees that `netdev` is valid while this function is running.
>>>> +        let mut dev = unsafe { Device::from_ptr(netdev) };
>>>> +        // SAFETY: The returned pointer was initialized by `D::Data::into_foreign` when
>>>> +        // `Registration` object was created.
>>>> +        // `D::Data::from_foreign` is only called by the object was released.
>>>> +        // So we know `data` is valid while this function is running.
>>>> +        let data = unsafe { D::Data::borrow(dev.priv_data_ptr()) };
>>>> +        T::uninit(&mut dev, data);
>>>> +    }
>>>> +
>>>> +    unsafe extern "C" fn open_callback(netdev: *mut bindings::net_device) -> core::ffi::c_int {
>>>> +        from_result(|| {
>>>> +            // SAFETY: The C API guarantees that `netdev` is valid while this function is running.
>>>> +            let mut dev = unsafe { Device::from_ptr(netdev) };
>>>> +            // SAFETY: The returned pointer was initialized by `D::Data::into_foreign` when
>>>> +            // `Registration` object was created.
>>>> +            // `D::Data::from_foreign` is only called by the object was released.
>>>> +            // So we know `data` is valid while this function is running.
>>>> +            let data = unsafe { D::Data::borrow(dev.priv_data_ptr()) };
>>>> +            T::open(&mut dev, data)?;
>>>> +            Ok(0)
>>>> +        })
>>>> +    }
>>>> +
>>>> +    unsafe extern "C" fn stop_callback(netdev: *mut bindings::net_device) -> core::ffi::c_int {
>>>> +        from_result(|| {
>>>> +            // SAFETY: The C API guarantees that `netdev` is valid while this function is running.
>>>> +            let mut dev = unsafe { Device::from_ptr(netdev) };
>>>> +            // SAFETY: The returned pointer was initialized by `D::Data::into_foreign` when
>>>> +            // `Registration` object was created.
>>>> +            // `D::Data::from_foreign` is only called by the object was released.
>>>> +            // So we know `data` is valid while this function is running.
>>>> +            let data = unsafe { D::Data::borrow(dev.priv_data_ptr()) };
>>>> +            T::stop(&mut dev, data)?;
>>>> +            Ok(0)
>>>> +        })
>>>> +    }
>>>> +
>>>> +    unsafe extern "C" fn start_xmit_callback(
>>>> +        skb: *mut bindings::sk_buff,
>>>> +        netdev: *mut bindings::net_device,
>>>> +    ) -> bindings::netdev_tx_t {
>>>> +        // SAFETY: The C API guarantees that `netdev` is valid while this function is running.
>>>> +        let mut dev = unsafe { Device::from_ptr(netdev) };
>>>> +        // SAFETY: The returned pointer was initialized by `D::Data::into_foreign` when
>>>> +        // `Registration` object was created.
>>>> +        // `D::Data::from_foreign` is only called by the object was released.
>>>> +        // So we know `data` is valid while this function is running.
>>>> +        let data = unsafe { D::Data::borrow(dev.priv_data_ptr()) };
>>>> +        // SAFETY: The C API guarantees that `skb` is valid while this function is running.
>>>> +        let skb = unsafe { SkBuff::from_ptr(skb) };
>>>> +        T::start_xmit(&mut dev, data, skb) as bindings::netdev_tx_t
>>>> +    }
>>>> +}
>>>> +
>>>> +// SAFETY: `Registration` exposes only `Device` object which can be used from
>>>> +// any thread.
>>>> +unsafe impl<D: DriverData, T: DeviceOperations<D>> Send for Registration<T, D> {}
>>>> +// SAFETY: `Registration` exposes only `Device` object which can be used from
>>>> +// any thread.
>>>> +unsafe impl<D: DriverData, T: DeviceOperations<D>> Sync for Registration<T, D> {}
>>>> +
>>>> +/// Corresponds to the kernel's `enum netdev_tx`.
>>>> +#[repr(i32)]
>>>> +pub enum TxCode {
>>>> +    /// Driver took care of packet.
>>>> +    Ok = bindings::netdev_tx_NETDEV_TX_OK,
>>>> +    /// Driver tx path was busy.
>>>> +    Busy = bindings::netdev_tx_NETDEV_TX_BUSY,
>>>> +}
>>>> +
>>>> +/// Corresponds to the kernel's `struct net_device_ops`.
>>>> +///
>>>> +/// A device driver must implement this. Only very basic operations are supported for now.
>>>> +#[vtable]
>>>> +pub trait DeviceOperations<D: DriverData> {
>>>
>>> Why is this trait generic over `D`? Why is this not `Self` or an associated
>>> type?
>> 
>> DriverData also used in EtherOperationsAdapter (the second patch) and
>> there are other operations that uses DriverData (not in this patchset).
> 
> Could you point me to those other things that use `DriverData`?

net_device struct has some like tlsdev_ops, rtnl_link_ops.. A device
driver might need to access to the private data via net_device in
these operations.


thanks,

