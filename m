Return-Path: <netdev+bounces-42696-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB3D7CFDE1
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 17:32:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0ADD41C20BB9
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 15:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91BCA30F82;
	Thu, 19 Oct 2023 15:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E0SCgWZs"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9822FE13;
	Thu, 19 Oct 2023 15:32:22 +0000 (UTC)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30AE6CF;
	Thu, 19 Oct 2023 08:32:21 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1c9ba72f6a1so17187995ad.1;
        Thu, 19 Oct 2023 08:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697729540; x=1698334340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZLV9wzASWRyU6HzDxs4AfroURzmGIMRDucVF5MhGgYE=;
        b=E0SCgWZs70xUCXa8215ZPBtDR9LmWvBH9rBmAF3bfcsApWRukjmBYJnuNtFnE8MAfP
         iiDz4QVW1f5xbZMyvMWw6wwFfZylcyCoSkRqRQpJMhL7FSd7oEPijEe20FfP5MfB7n+b
         6LAOxPajOZX2ba1Z129S6KVB0UkvW3DY5eHb9fn8Fb+6Zxccvj6Dykyh4f6GcT/uDmrw
         dZf2XDVC9sX6aiRwEHWJrodiC9zUG7Z0RjmH6M8C+ihF1Ts2opTBqfAXkVY0/ETjCln4
         3rTxOKdTNuUFwseP2RSnajhj7MWd5vhX2tVMvoPAT7r5kVqmCdQVZ9Y5kLMM1NUNQgpb
         iS1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697729540; x=1698334340;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZLV9wzASWRyU6HzDxs4AfroURzmGIMRDucVF5MhGgYE=;
        b=OMWug3fMomO/9fTQTjuNplMKTfwKrDhOSB1pq0831iTAT7kU0LccnhE7w/qFHFnNRy
         gtVdkDee6OYoxS9rZhxRICtUd1QQv2D5BP+W1f+UOKCdlgvsYv0SU5GF4C3c8I/BYWLU
         ypFVufsqIfIMn+PSf2Vm7YoKRqpN2toNPBCuTL52YeYCH5TlXdv6Yj7F/wan/YLISBjf
         AkYjrmnImXBnhqTWiiWTi9WQnWO3TsuoOpyp7UyouEdSvMla9d7mFt8Vl890fJMnOeiP
         lBS8m1GOmisHICuITjgncZbQkMxNcC7vvWUJjHKxRE/OaGIFiGS1FgQJ295PB4+WKEcd
         k/5A==
X-Gm-Message-State: AOJu0Yzmt2zrKmOjqLdECaIfsAmU2ZxAL+kVZ1qwQPnCyZTzMArXc1Os
	lDdqfnE7fa9HbU4o7q8+uWI=
X-Google-Smtp-Source: AGHT+IEaV9JiaMeNcqn7ZDN5n/GknnW7dZbn6QtiRLVfLpSWHihFVGOOhd2lvSk4jdX5o2qW3eCTwA==
X-Received: by 2002:a17:902:db0c:b0:1c3:a4f2:7c99 with SMTP id m12-20020a170902db0c00b001c3a4f27c99mr2601780plx.4.1697729540466;
        Thu, 19 Oct 2023 08:32:20 -0700 (PDT)
Received: from localhost (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id p4-20020a170902e74400b001a98f844e60sm2077698plf.263.2023.10.19.08.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 08:32:19 -0700 (PDT)
Date: Fri, 20 Oct 2023 00:32:19 +0900 (JST)
Message-Id: <20231020.003219.1788909848908453261.fujita.tomonori@gmail.com>
To: benno.lossin@proton.me
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, andrew@lunn.ch,
 miguel.ojeda.sandonis@gmail.com, tmgross@umich.edu, boqun.feng@gmail.com,
 wedsonaf@gmail.com, greg@kroah.com
Subject: Re: [PATCH net-next v5 1/5] rust: core abstractions for network
 PHY drivers
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <64db34c0-a50a-4321-a3d8-b692e26899d9@proton.me>
References: <0e8d2538-284b-4811-a2e7-99151338c255@proton.me>
	<20231019.234210.1772681043146865420.fujita.tomonori@gmail.com>
	<64db34c0-a50a-4321-a3d8-b692e26899d9@proton.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Thu, 19 Oct 2023 15:20:51 +0000
Benno Lossin <benno.lossin@proton.me> wrote:

> On 19.10.23 16:42, FUJITA Tomonori wrote:
>>>>>> +/// Registration structure for a PHY driver.
>>>>>> +///
>>>>>> +/// # Invariants
>>>>>> +///
>>>>>> +/// The `drivers` slice are currently registered to the kernel via `phy_drivers_register`.
>>>>>> +pub struct Registration {
>>>>>> +    drivers: &'static [DriverType],
>>>>>> +}
>>>>>
>>>>> You did not reply to my suggestion [2] to remove this type,
>>>>> what do you think?
>>>>>
>>>>> [2]: https://lore.kernel.org/rust-for-linux/85d5c498-efbc-4c1a-8d12-f1eca63c45cf@proton.me/
>>>>
>>>> I tried before but I'm not sure it simplifies the implementation.
>>>>
>>>> Firstly, instead of Reservation, we need a public function like
>>>>
>>>> pub fn phy_drivers_register(module: &'static crate::ThisModule, drivers: &[DriverVTable]) -> Result {
>>>>       to_result(unsafe {
>>>>           bindings::phy_drivers_register(drivers[0].0.get(), drivers.len().try_into()?, module.0)
>>>>       })
>>>> }
>>>>
>>>> This is because module.0 is private.
>>>
>>> Why can't this be part of the macro?
>> 
>> I'm not sure I correctly understand what you suggest so you meant the following?
>> 
>>      (drivers: [$($driver:ident),+], device_table: [$($dev:expr),+], $($f:tt)*) => {
>>          struct Module {
>>               _drv:  [
>>                  ::kernel::net::phy::DriverVTable;
>>                  $crate::module_phy_driver!(@count_devices $($driver),+)
>>              ],
>>          }
>>          unsafe impl Sync for Module {}
>> 
>>          $crate::prelude::module! {
>>              type: Module,
>>              $($f)*
>>          }
>> 
>>          impl ::kernel::Module for Module {
>>              fn init(module: &'static ThisModule) -> Result<Self> {
>>                  let drv = [
>>                      $(::kernel::net::phy::create_phy_driver::<$driver>()),+
>>                  ];
>>                  ::kernel::error::to_result(unsafe {
>>                      ::kernel::bindings::phy_drivers_register(drv[0].0.get(), drv.len().try_into()?, module.0)
> 
> You can just do this (I omitted the `::kernel::` prefix for
> readability, if you add this in the macro, please include it):
> 
>      // CAST: `DriverVTable` is `repr(transparent)` and wrapping `bindings::phy_driver`.
>      let ptr = drv.as_mut_ptr().cast::<bindings::phy_driver>();
>      let len = drv.len().try_into()?;
>      // SAFETY: ...
>      to_result(unsafe { bindings::phy_drivers_register(ptr, len, module.0) })?;
> 
>>                  })?;

The above solves DriverVTable.0 but still the macro can't access to
kernel::ThisModule.0. I got the following error:

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
	   |
	      = note: this error originates in the macro
	      `kernel::module_phy_driver` (in Nightly builds, run with
	      -Z macro-backtrace for more info)


>>                  Ok(Module {
>>                      _drv: drv,
>>                  })
>>              }
>>          }
>> 
>> Then we got the following error:
>> 
>> error[E0616]: field `0` of struct `DriverVTable` is private
>>    --> drivers/net/phy/ax88796b_rust.rs:12:1
>>       |
>>       12 | / kernel::module_phy_driver! {
>>       13 | |     drivers: [PhyAX88772A, PhyAX88772C, PhyAX88796B],
>>       14 | |     device_table: [
>>       15 | |         DeviceId::new_with_driver::<PhyAX88772A>(),
>>       ...  |
>>       22 | |     license: "GPL",
>>       23 | | }
>>          | |_^ private field
>> 	   |
>> 	      = note: this error originates in the macro
>> 	      `kernel::module_phy_driver` (in Nightly builds, run with
>> 	      -Z macro-backtrace for more info)
>> 
>> error[E0616]: field `0` of struct `kernel::ThisModule` is private
>>    --> drivers/net/phy/ax88796b_rust.rs:12:1
>>       |
>>       12 | / kernel::module_phy_driver! {
>>       13 | |     drivers: [PhyAX88772A, PhyAX88772C, PhyAX88796B],
>>       14 | |     device_table: [
>>       15 | |         DeviceId::new_with_driver::<PhyAX88772A>(),
>>       ...  |
>>       22 | |     license: "GPL",
>>       23 | | }
>>          | |_^ private field
>> 
>> 
>>>> Also if we keep DriverVtable.0 private, we need another public function.
>>>>
>>>> pub unsafe fn phy_drivers_unregister(drivers: &'static [DriverVTable])
>>>> {
>>>>       unsafe {
>>>>           bindings::phy_drivers_unregister(drivers[0].0.get(), drivers.len() as i32)
>>>>       };
>>>> }
>>>>
>>>> DriverVTable isn't guaranteed to be registered to the kernel so needs
>>>> to be unsafe, I guesss.
>>>
>>> In one of the options I suggest to make that an invariant of `DriverVTable`.
>>>
>>>>
>>>> Also Module trait support exit()?
>>>
>>> Yes, just implement `Drop` and do the cleanup there.
>>>
>>> In the two options that I suggested there is a trade off. I do not know
>>> which option is better, I hoped that you or Andrew would know more:
>>> Option 1:
>>> * advantages:
>>>     - manual creation of a phy driver module becomes possible.
>>>     - less complex `module_phy_driver` macro.
>>>     - no static variable needed.
>>> * disadvantages:
>>>     - calls `phy_drivers_register` for every driver on module
>>>       initialization.
>>>     - calls `phy_drivers_unregister` for every driver on module
>>>       exit.
>>>
>>> Option 2:
>>> * advantages:
>>>     - less complex `module_phy_driver` macro.
>>>     - no static variable needed.
>>>     - only a single call to
>>>       `phy_drivers_register`/`phy_drivers_unregister`.
>>> * disadvantages:
>>>     - no safe manual creation of phy drivers possible, the only safe
>>>       way is to use the `module_phy_driver` macro.
>>>
>>> I suppose that it would be ok to call the register function multiple
>>> times, since it only is on module startup/shutdown and it is not
>>> performance critical.
>> 
>> I think that we can use the current implantation using Reservation
>> struct until someone requests manual creation. I doubt that we will
>> need to support such.
> 
> I would like to remove the mutable static variable and simplify
> the macro.

It's worse than having public unsafe function (phy_drivers_unregister)?

