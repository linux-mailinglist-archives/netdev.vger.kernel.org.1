Return-Path: <netdev+bounces-42686-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D58B37CFD1E
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 16:42:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 886A5281FDE
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 14:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8AB7CA48;
	Thu, 19 Oct 2023 14:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dJDpgLIe"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086A119460;
	Thu, 19 Oct 2023 14:42:25 +0000 (UTC)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 872E91FD7;
	Thu, 19 Oct 2023 07:42:12 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6bb744262caso1268462b3a.0;
        Thu, 19 Oct 2023 07:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697726532; x=1698331332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SV9hZ5ARlQWTiD8qYwSFapkfV8Uc5WLPVLIDWVMRcrQ=;
        b=dJDpgLIe3kE9VOyMCujYW+JOFAC5cinJ8gdtFRuEz048hQX0JBGOtoMgru3vyZFujW
         pqBFOQPiKnCnTgzg1E2i1Yp7jhxKtkzf/SJW5mC+PJLpR0KPcqJsJLmA5ft78qmt0yFJ
         ttlIh0eoCJrfVAy0oZAPT4LelMwybAZo5kDCS+dfinMOptFhoZEvSa6DpGkmF1MzIRfe
         hhjKWOwr4nBeuuM/cm01gJ40N+nUQoQ/qUW/8X3I4EkG83An386FwaEGLs8iXTl3WyZ7
         yQL0cs4QS5TECnxJJmlWBjiFDe0YjvGh8dysC9QFoX3BH0v0I6p1yROkFzeqCrWR0An8
         oYWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697726532; x=1698331332;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SV9hZ5ARlQWTiD8qYwSFapkfV8Uc5WLPVLIDWVMRcrQ=;
        b=vMZ0YhKxipe5W9OyKqjTs5Cne8xDEA+9eMiEwreCbEcPFuIlZa78wGTM8V7CZzbAHo
         lODVPnKNA8dG2mLktb0MQxPu3HFSUSAxk5sxPo5zd8KBpDct2lg3hWD2Iez9NjKT2vLJ
         kxhPEnWmcg46lUJxxZqaTeqD9LVIi8sB/AjeDkx6XOlGPtxm8K6G0/1UW1GdUgR4jYy6
         fDOxtnVaNPKNyLllOc0tolU6PVea2S1JuW5kGTjZoA7LiI68D33Wnm+Tmr/2e4rclO/i
         Tc8JCFFkNN2Wx1noANyck/o8l6ZHK/ruKW2ZXRnw0KfipoqkK3aqEnw7MfpxI1inrAUR
         /qvA==
X-Gm-Message-State: AOJu0Yy+ONG9RPdmNl0adCJw4w4rO/vkLr5Wb/Y9aND5+rblpqLX7oLw
	khYvsvtn750YFmY1j5AUcyA=
X-Google-Smtp-Source: AGHT+IF13T+FCl/9rMKFsXqsUDUjf575OQhdOKP5k8I28gRxFhYR3BvorqSM2wzI+/1lgNrOK1mYgA==
X-Received: by 2002:a05:6a20:7d8c:b0:133:6e3d:68cd with SMTP id v12-20020a056a207d8c00b001336e3d68cdmr2796391pzj.3.1697726531581;
        Thu, 19 Oct 2023 07:42:11 -0700 (PDT)
Received: from localhost (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id kg14-20020a170903060e00b001c74718f2f3sm2027994plb.119.2023.10.19.07.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 07:42:11 -0700 (PDT)
Date: Thu, 19 Oct 2023 23:42:10 +0900 (JST)
Message-Id: <20231019.234210.1772681043146865420.fujita.tomonori@gmail.com>
To: benno.lossin@proton.me
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, andrew@lunn.ch,
 miguel.ojeda.sandonis@gmail.com, tmgross@umich.edu, boqun.feng@gmail.com,
 wedsonaf@gmail.com, greg@kroah.com
Subject: Re: [PATCH net-next v5 1/5] rust: core abstractions for network
 PHY drivers
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <0e8d2538-284b-4811-a2e7-99151338c255@proton.me>
References: <e361ef91-607d-400b-a721-f846c21e2400@proton.me>
	<20231019.092436.1433321157817125498.fujita.tomonori@gmail.com>
	<0e8d2538-284b-4811-a2e7-99151338c255@proton.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Thu, 19 Oct 2023 13:45:27 +0000
Benno Lossin <benno.lossin@proton.me> wrote:

> On 19.10.23 02:24, FUJITA Tomonori wrote:
>> On Wed, 18 Oct 2023 15:07:52 +0000
>> Benno Lossin <benno.lossin@proton.me> wrote:
>> 
>>>> diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
>>>> new file mode 100644
>>>> index 000000000000..7d4927ece32f
>>>> --- /dev/null
>>>> +++ b/rust/kernel/net/phy.rs
>>>> @@ -0,0 +1,701 @@
>>>> +// SPDX-License-Identifier: GPL-2.0
>>>> +
>>>> +// Copyright (C) 2023 FUJITA Tomonori <fujita.tomonori@gmail.com>
>>>> +
>>>> +//! Network PHY device.
>>>> +//!
>>>> +//! C headers: [`include/linux/phy.h`](../../../../include/linux/phy.h).
>>>> +//!
>>>
>>> Add a new section "# Abstraction Overview" or similar.
>> 
>> With the rest of comments on this secsion addressed, how about the following?
>> 
>> //! Network PHY device.
>> //!
>> //! C headers: [`include/linux/phy.h`](../../../../include/linux/phy.h).
>> //!
>> //! # Abstraction Overview
>> //!
>> //! "During the calls to most functions in [`Driver`], the C side (`PHYLIB`) holds a lock that is unique
> 
> Please remove the quotes ", they were intended to separate my comments
> from my suggestion.
> 
>> //! for every instance of [`Device`]". `PHYLIB` uses a different serialization technique for
>> //! [`Driver::resume`] and [`Driver::suspend`]: `PHYLIB` updates `phy_device`'s state with the lock hold,
> 
> hold -> held
> 
>> //! to guarantee that [`Driver::resume`] accesses to the instance exclusively. [`Driver::resume`] and
> 
> to guarantee -> thus guaranteeing
> accesses to the instance exclusively. -> has exclusive access to the instance.
> 
>> //! [`Driver::suspend`] also are called where only one thread can access to the instance.
>> //!
>> //! All the PHYLIB helper functions for [`Device`] modify some members in [`Device`]. Except for
> 
> PHYLIB -> `PHYLIB`
> 
>> //! getter functions, [`Device`] methods take `&mut self`. This also applied to `[Device::read]`,
> 
> `[Device::read]` -> [`Device::read`]
> 
>> //! which reads a hardware register and updates the stats.
> 
> Otherwise this looks good.

Thanks, I fixed the comment accordingly.


> [...]
> 
>>>> +impl Device {
>>>> +    /// Creates a new [`Device`] instance from a raw pointer.
>>>> +    ///
>>>> +    /// # Safety
>>>> +    ///
>>>> +    /// This function must only be called from the callbacks in `phy_driver`. PHYLIB guarantees
>>>> +    /// the exclusive access for the duration of the lifetime `'a`.
>>>
>>> I would not put the second sentence in the `# Safety` section. Just move it
>>> above. The reason behind this is the following: the second sentence is not
>>> a precondition needed to call the function.
>> 
>> Where is the `above`? You meant the following?
>> 
>> impl Device {
>>      /// Creates a new [`Device`] instance from a raw pointer.
>>      ///
>>      /// `PHYLIB` guarantees the exclusive access for the duration of the lifetime `'a`.
>>      ///
>>      /// # Safety
>>      ///
>>      /// This function must only be called from the callbacks in `phy_driver`.
>>      unsafe fn from_raw<'a>(ptr: *mut bindings::phy_device) -> &'a  mut Self {
> 
> Yes this is what I had in mind. Although now that I see it in code,
> I am not so sure that this comment is needed. If you feel the same
> way, just remove it.

Then let me drop it.

> That being said, I am not too happy with the safety requirement of this
> function. It does not really match with the safety comment in the function
> body. Since I have not yet finished my safety standardization, I think we
> can defer that problem until it is finished. Unless some other reviewer
> wants to change this, you can keep it as is.

Understood. 


>> /// Creates the [`DriverVTable`] instance from [`Driver`] trait.
> 
> Sounds good, but to this sounds a bit more natural:
> 
>      /// Creates a [`DriverVTable`] instance from a [`Driver`].

Oops, fixed.


>>>> +/// Registration structure for a PHY driver.
>>>> +///
>>>> +/// # Invariants
>>>> +///
>>>> +/// The `drivers` slice are currently registered to the kernel via `phy_drivers_register`.
>>>> +pub struct Registration {
>>>> +    drivers: &'static [DriverType],
>>>> +}
>>>
>>> You did not reply to my suggestion [2] to remove this type,
>>> what do you think?
>>>
>>> [2]: https://lore.kernel.org/rust-for-linux/85d5c498-efbc-4c1a-8d12-f1eca63c45cf@proton.me/
>> 
>> I tried before but I'm not sure it simplifies the implementation.
>> 
>> Firstly, instead of Reservation, we need a public function like
>> 
>> pub fn phy_drivers_register(module: &'static crate::ThisModule, drivers: &[DriverVTable]) -> Result {
>>      to_result(unsafe {
>>          bindings::phy_drivers_register(drivers[0].0.get(), drivers.len().try_into()?, module.0)
>>      })
>> }
>> 
>> This is because module.0 is private.
> 
> Why can't this be part of the macro?

I'm not sure I correctly understand what you suggest so you meant the following?

    (drivers: [$($driver:ident),+], device_table: [$($dev:expr),+], $($f:tt)*) => {
        struct Module {
             _drv:  [
                ::kernel::net::phy::DriverVTable;
                $crate::module_phy_driver!(@count_devices $($driver),+)
            ],
        }
        unsafe impl Sync for Module {}

        $crate::prelude::module! {
            type: Module,
            $($f)*
        }

        impl ::kernel::Module for Module {
            fn init(module: &'static ThisModule) -> Result<Self> {
                let drv = [
                    $(::kernel::net::phy::create_phy_driver::<$driver>()),+
                ];
                ::kernel::error::to_result(unsafe {
                    ::kernel::bindings::phy_drivers_register(drv[0].0.get(), drv.len().try_into()?, module.0)
                })?;

                Ok(Module {
                    _drv: drv,
                })
            }
        }

Then we got the following error:

error[E0616]: field `0` of struct `DriverVTable` is private
  --> drivers/net/phy/ax88796b_rust.rs:12:1
     |
     12 | / kernel::module_phy_driver! {
     13 | |     drivers: [PhyAX88772A, PhyAX88772C, PhyAX88796B],
     14 | |     device_table: [
     15 | |         DeviceId::new_with_driver::<PhyAX88772A>(),
     ...  |
     22 | |     license: "GPL",
     23 | | }
        | |_^ private field
	   |
	      = note: this error originates in the macro
	      `kernel::module_phy_driver` (in Nightly builds, run with
	      -Z macro-backtrace for more info)

error[E0616]: field `0` of struct `kernel::ThisModule` is private
  --> drivers/net/phy/ax88796b_rust.rs:12:1
     |
     12 | / kernel::module_phy_driver! {
     13 | |     drivers: [PhyAX88772A, PhyAX88772C, PhyAX88796B],
     14 | |     device_table: [
     15 | |         DeviceId::new_with_driver::<PhyAX88772A>(),
     ...  |
     22 | |     license: "GPL",
     23 | | }
        | |_^ private field


>> Also if we keep DriverVtable.0 private, we need another public function.
>> 
>> pub unsafe fn phy_drivers_unregister(drivers: &'static [DriverVTable])
>> {
>>      unsafe {
>>          bindings::phy_drivers_unregister(drivers[0].0.get(), drivers.len() as i32)
>>      };
>> }
>> 
>> DriverVTable isn't guaranteed to be registered to the kernel so needs
>> to be unsafe, I guesss.
> 
> In one of the options I suggest to make that an invariant of `DriverVTable`.
> 
>> 
>> Also Module trait support exit()?
> 
> Yes, just implement `Drop` and do the cleanup there.
> 
> In the two options that I suggested there is a trade off. I do not know
> which option is better, I hoped that you or Andrew would know more:
> Option 1:
> * advantages:
>    - manual creation of a phy driver module becomes possible.
>    - less complex `module_phy_driver` macro.
>    - no static variable needed.
> * disadvantages:
>    - calls `phy_drivers_register` for every driver on module
>      initialization.
>    - calls `phy_drivers_unregister` for every driver on module
>      exit.
> 
> Option 2:
> * advantages:
>    - less complex `module_phy_driver` macro.
>    - no static variable needed.
>    - only a single call to
>      `phy_drivers_register`/`phy_drivers_unregister`.
> * disadvantages:
>    - no safe manual creation of phy drivers possible, the only safe
>      way is to use the `module_phy_driver` macro.
> 
> I suppose that it would be ok to call the register function multiple
> times, since it only is on module startup/shutdown and it is not
> performance critical.

I think that we can use the current implantation using Reservation
struct until someone requests manual creation. I doubt that we will
need to support such.

