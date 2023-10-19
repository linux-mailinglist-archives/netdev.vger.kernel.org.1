Return-Path: <netdev+bounces-42462-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 548FF7CECBD
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 02:24:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25599B20D64
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 00:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C32B217E;
	Thu, 19 Oct 2023 00:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jrOZHlNC"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB09E361;
	Thu, 19 Oct 2023 00:24:40 +0000 (UTC)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A24FA;
	Wed, 18 Oct 2023 17:24:38 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-1d542f05b9aso1333638fac.1;
        Wed, 18 Oct 2023 17:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697675078; x=1698279878; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EDUq7mobJbD8hr3xc8vUb9c0AaFgigQ8kILPINCwqcY=;
        b=jrOZHlNCPiCTdDuYP41p5dSZ29R8puovDitjHeUBs5QE6Epn5QjmAXaw1bet4v88ul
         KwtN9/LPrpvTfcyRhmOm7ZSCF/wJDDYnKAI+KP/oqvQea2Hf9pECRe6WzSMwcZ83gjpz
         pcnHNabTgsIJBf1/yLqewKXlHRrP9tvTJpj7jV9PbABEuz2wyISk3mHfLHjHPaUXxmL/
         CyZedprbKujQTb4AHOgkVu46tQiZrvs7S0aOCxqdbPUb0naammTldHlrGKZ2RoPFsJf3
         L6E3f+UsJi3nFuzvsrfkkyiQiCkUMIRoKruRrjiKUXSYum1RGbFKSreTQPRntoVw6f0o
         9tUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697675078; x=1698279878;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EDUq7mobJbD8hr3xc8vUb9c0AaFgigQ8kILPINCwqcY=;
        b=u3lEhCkhFqZ4pTV/UMw7+qesuvctV0ZRFRve8sx/3pSCQ4LvaQHyupQamUvrHt08J5
         s6d+GoONCqQk2onoXloKM2/Mt4fUSdxdjpLS9rEg2Ev1B5CVOlq8Ssf9rJ2RG7oPu/RG
         9DVnvgsAr0FBbo16HVFUYK9fAFQ5ZMyDuPmXUzCsZBEIIPFaUxS/gPQrt83GHJvCnKs7
         bxACPwhk4M7VmrV8zh5cYJNxfjY+k+RBhv1+5LgxekXySjg9InMVbbVJaDig7oLmnvNI
         7el00oi5N/AxzF46vy98pAaekXZ8AM3JM6yCng1KD3r0VHKI7j983Rqj28hRceOP5goI
         jd4g==
X-Gm-Message-State: AOJu0YyvydXdOMBEqbzFeHdNCesWotubYbVvcaqumsNj2FCuBbrvhLfc
	wmgtVw2VSCa89i420AA+uZo=
X-Google-Smtp-Source: AGHT+IGFqa/kbjd8rCoNc/Fn4pw3DnOJGHilTMlG1cLE1+GfYCalJtB+kkEMOQE7X/3ydvfSvYHJzQ==
X-Received: by 2002:a05:6358:f1c2:b0:168:a3bb:14f4 with SMTP id kr2-20020a056358f1c200b00168a3bb14f4mr169763rwb.3.1697675077852;
        Wed, 18 Oct 2023 17:24:37 -0700 (PDT)
Received: from localhost (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id w123-20020a626281000000b0068ff6d21563sm4195664pfb.148.2023.10.18.17.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 17:24:37 -0700 (PDT)
Date: Thu, 19 Oct 2023 09:24:36 +0900 (JST)
Message-Id: <20231019.092436.1433321157817125498.fujita.tomonori@gmail.com>
To: benno.lossin@proton.me
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, andrew@lunn.ch,
 miguel.ojeda.sandonis@gmail.com, tmgross@umich.edu, boqun.feng@gmail.com,
 wedsonaf@gmail.com, greg@kroah.com
Subject: Re: [PATCH net-next v5 1/5] rust: core abstractions for network
 PHY drivers
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <e361ef91-607d-400b-a721-f846c21e2400@proton.me>
References: <20231017113014.3492773-1-fujita.tomonori@gmail.com>
	<20231017113014.3492773-2-fujita.tomonori@gmail.com>
	<e361ef91-607d-400b-a721-f846c21e2400@proton.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Wed, 18 Oct 2023 15:07:52 +0000
Benno Lossin <benno.lossin@proton.me> wrote:

>> diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
>> new file mode 100644
>> index 000000000000..7d4927ece32f
>> --- /dev/null
>> +++ b/rust/kernel/net/phy.rs
>> @@ -0,0 +1,701 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +// Copyright (C) 2023 FUJITA Tomonori <fujita.tomonori@gmail.com>
>> +
>> +//! Network PHY device.
>> +//!
>> +//! C headers: [`include/linux/phy.h`](../../../../include/linux/phy.h).
>> +//!
> 
> Add a new section "# Abstraction Overview" or similar.

With the rest of comments on this secsion addressed, how about the following?

//! Network PHY device.
//!
//! C headers: [`include/linux/phy.h`](../../../../include/linux/phy.h).
//!
//! # Abstraction Overview
//!
//! "During the calls to most functions in [`Driver`], the C side (`PHYLIB`) holds a lock that is unique
//! for every instance of [`Device`]". `PHYLIB` uses a different serialization technique for
//! [`Driver::resume`] and [`Driver::suspend`]: `PHYLIB` updates `phy_device`'s state with the lock hold,
//! to guarantee that [`Driver::resume`] accesses to the instance exclusively. [`Driver::resume`] and
//! [`Driver::suspend`] also are called where only one thread can access to the instance.
//!
//! All the PHYLIB helper functions for [`Device`] modify some members in [`Device`]. Except for
//! getter functions, [`Device`] methods take `&mut self`. This also applied to `[Device::read]`,
//! which reads a hardware register and updates the stats.


>> +//! The C side (PHYLIB) guarantees that there is only one thread accessing to one `phy_device` instance
>> +//! during a callback in `phy_driver`. The callback safely accesses to the instance exclusively.
>> +//! Except for `resume()` and `suspend()`, PHYLIB holds `phy_device`'s lock during a callback.
> 
> I would start with "During the calls to most functions in [`Driver`],
> the C side (`PHYLIB`) holds a lock that is unique for every instance of
> [`Device`]". Then you can note the exception for `resume` and `suspend`
> (and also link them e.g. [`Driver::resume`]).
> 
>> +//! PHYLIB doesn't hold `phy_device`'s lock in both `resume()` and `suspend()`. Instead, PHYLIB
>> +//! updates `phy_device`'s state with `phy_device`'s lock hold, to guarantee that resume() accesses
>> +//! to the instance exclusively. Note that `resume()` and `suspend()` also are called where only
>> +//! one thread can access to the instance.
> 
> I would just write "`PHYLIB` uses a different serialization technique for
> [`Driver::resume`] and [`Driver::suspend`]: <use the above explanation>".
> 
>> +//! This abstractions creates [`Device`] instance only during a callback so it's guaranteed that
>> +//! only one reference exists. All its methods can accesses to the instance exclusively.
> 
> Not really sure if this is needed, what are you trying to explain here?

I tried to add an explanation that Device::from_raw() return &mut. But
I guess that the description of Device is enough.


>> +//! All the PHYLIB helper functions for `phy_device` modify some members in `phy_device`. Except for
>> +//! getter functions, [`Device`] methods take `&mut self`. This also applied to `read()`, which reads
>> +//! a hardware register and updates the stats.
> 
> I would use [`Device`] instead of `phy_device`, since the Rust reader
> might not be aware what wraps `phy_device`.
> 
>> +use crate::{bindings, error::*, prelude::vtable, str::CStr, types::Opaque};
>> +use core::marker::PhantomData;

(snip)


>> +/// An instance of a PHY device.
>> +///
>> +/// Wraps the kernel's `struct phy_device`.
>> +///
>> +/// # Invariants
>> +///
>> +/// `self.0` is always in a valid state.
>> +#[repr(transparent)]
>> +pub struct Device(Opaque<bindings::phy_device>);
>> +
>> +impl Device {
>> +    /// Creates a new [`Device`] instance from a raw pointer.
>> +    ///
>> +    /// # Safety
>> +    ///
>> +    /// This function must only be called from the callbacks in `phy_driver`. PHYLIB guarantees
>> +    /// the exclusive access for the duration of the lifetime `'a`.
> 
> I would not put the second sentence in the `# Safety` section. Just move it
> above. The reason behind this is the following: the second sentence is not
> a precondition needed to call the function.

Where is the `above`? You meant the following?

impl Device {
    /// Creates a new [`Device`] instance from a raw pointer.
    ///
    /// `PHYLIB` guarantees the exclusive access for the duration of the lifetime `'a`.
    ///
    /// # Safety
    ///
    /// This function must only be called from the callbacks in `phy_driver`.
    unsafe fn from_raw<'a>(ptr: *mut bindings::phy_device) -> &'a  mut Self {


>> +    unsafe fn from_raw<'a>(ptr: *mut bindings::phy_device) -> &'a mut Self {
>> +        // CAST: `Self` is a `repr(transparent)` wrapper around `bindings::phy_device`.
>> +        let ptr = ptr.cast::<Self>();
>> +        // SAFETY: by the function requirements the pointer is valid and we have unique access for
>> +        // the duration of `'a`.
>> +        unsafe { &mut *ptr }
>> +    }
>> +
>> +    /// Gets the id of the PHY.
>> +    pub fn phy_id(&self) -> u32 {
>> +        let phydev = self.0.get();
>> +        // SAFETY: `phydev` is pointing to a valid object by the type invariant of `Self`.
>> +        unsafe { (*phydev).phy_id }
>> +    }
>> +
>> +    /// Gets the state of the PHY.
>> +    pub fn state(&self) -> DeviceState {
>> +        let phydev = self.0.get();
>> +        // SAFETY: `phydev` is pointing to a valid object by the type invariant of `Self`.
>> +        let state = unsafe { (*phydev).state };
>> +        // TODO: this conversion code will be replaced with automatically generated code by bindgen
>> +        // when it becomes possible.
>> +        // better to call WARN_ONCE() when the state is out-of-range (needs to add WARN_ONCE support).
>> +        match state {
>> +            bindings::phy_state_PHY_DOWN => DeviceState::Down,
>> +            bindings::phy_state_PHY_READY => DeviceState::Ready,
>> +            bindings::phy_state_PHY_HALTED => DeviceState::Halted,
>> +            bindings::phy_state_PHY_ERROR => DeviceState::Error,
>> +            bindings::phy_state_PHY_UP => DeviceState::Up,
>> +            bindings::phy_state_PHY_RUNNING => DeviceState::Running,
>> +            bindings::phy_state_PHY_NOLINK => DeviceState::NoLink,
>> +            bindings::phy_state_PHY_CABLETEST => DeviceState::CableTest,
>> +            _ => DeviceState::Error,
>> +        }
>> +    }
>> +
>> +    /// Returns true if the link is up.
>> +    pub fn get_link(&self) -> bool {
> 
> I still think this name should be changed. My response at [1] has not yet
> been replied to. This has already been discussed before:
> - https://lore.kernel.org/rust-for-linux/2023100237-satirical-prance-bd57@gregkh/
> - https://lore.kernel.org/rust-for-linux/20231004.084644.50784533959398755.fujita.tomonori@gmail.com/
> - https://lore.kernel.org/rust-for-linux/CALNs47syMxiZBUwKLk3vKxzmCbX0FS5A37FjwUzZO9Fn-iPaoA@mail.gmail.com/
> 
> And I want to suggest to change it to `is_link_up`.
> 
> Reasons why I do not like the name:
> - `get_`/`put_` are used for ref counting on the C side, I would like to
>    avoid confusion.
> - `get` in Rust is often used to fetch a value from e.g. a datastructure
>    such as a hashmap, so I expect the call to do some computation.
> - getters in Rust usually are not prefixed with `get_`, but rather are
>    just the name of the field.
> - in this case I like the name `is_link_up` much better, since code becomes
>    a lot more readable with that.
> - I do not want this pattern as an example for other drivers.
> 
> [1]: https://lore.kernel.org/rust-for-linux/f5878806-5ba2-d932-858d-dda3f55ceb67@proton.me/

IIRC, Andrew suggested the current name. If the change is fine by him,
I'll rename.


>> +/// An instance of a PHY driver.
>> +///
>> +/// Wraps the kernel's `struct phy_driver`.
>> +///
>> +/// # Invariants
>> +///
>> +/// `self.0` is always in a valid state.
>> +#[repr(transparent)]
>> +pub struct DriverType(Opaque<bindings::phy_driver>);
> 
> I think `DriverVTable` is a better name.

Renamed.

>> +/// Creates the kernel's `phy_driver` instance.
> 
> This function returns a `DriverType`, not a `phy_driver`.

How about?

/// Creates the [`DriverVTable`] instance from [`Driver`] trait.

>> +///
>> +/// This is used by [`module_phy_driver`] macro to create a static array of `phy_driver`.
>> +///
>> +/// [`module_phy_driver`]: crate::module_phy_driver
>> +pub const fn create_phy_driver<T: Driver>() -> DriverType {
>> +    // All the fields of `struct phy_driver` are initialized properly.
>> +    // It ensures the invariants.
> 
> Use `// INVARIANT: `.

Oops,

// INVARIANT: All the fields of `struct phy_driver` are initialized properly.
DriverVTable(Opaque::new(bindings::phy_driver {
    name: T::NAME.as_char_ptr().cast_mut(),


>> +/// Registration structure for a PHY driver.
>> +///
>> +/// # Invariants
>> +///
>> +/// The `drivers` slice are currently registered to the kernel via `phy_drivers_register`.
>> +pub struct Registration {
>> +    drivers: &'static [DriverType],
>> +}
> 
> You did not reply to my suggestion [2] to remove this type,
> what do you think?
> 
> [2]: https://lore.kernel.org/rust-for-linux/85d5c498-efbc-4c1a-8d12-f1eca63c45cf@proton.me/

I tried before but I'm not sure it simplifies the implementation.

Firstly, instead of Reservation, we need a public function like

pub fn phy_drivers_register(module: &'static crate::ThisModule, drivers: &[DriverVTable]) -> Result {
    to_result(unsafe {
        bindings::phy_drivers_register(drivers[0].0.get(), drivers.len().try_into()?, module.0)
    })
}

This is because module.0 is private.

Also if we keep DriverVtable.0 private, we need another public function.

pub unsafe fn phy_drivers_unregister(drivers: &'static [DriverVTable])
{
    unsafe {
        bindings::phy_drivers_unregister(drivers[0].0.get(), drivers.len() as i32)
    };
}

DriverVTable isn't guaranteed to be registered to the kernel so needs
to be unsafe, I guesss.

Also Module trait support exit()?

