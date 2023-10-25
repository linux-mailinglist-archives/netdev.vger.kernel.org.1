Return-Path: <netdev+bounces-44107-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A43027D6432
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 09:57:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93815B210D3
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 07:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB5531C2B7;
	Wed, 25 Oct 2023 07:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FlkEd6QP"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C0B1BDF7;
	Wed, 25 Oct 2023 07:57:13 +0000 (UTC)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F9A19B;
	Wed, 25 Oct 2023 00:57:12 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1ca79b731f1so10374705ad.0;
        Wed, 25 Oct 2023 00:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698220631; x=1698825431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q7sXOhPkG0yrlbIXJ75m9LnEaT7H+cm3hu/aUOlITVU=;
        b=FlkEd6QPUJmMk/8p3zJVGYIfOAxwVfK5ENw2kSO1cJoKxKKhtMwYb2X4vkI9Xej7gs
         p85t/WGi6dx2XxF85435tvPfqpsy6/Z2iIYQOW2ODvsJWsvOKPyBTTEwCxj51tjiKZ+J
         wqySr7EIwxA2JumN7Jq8p+1PbHHhqoHS77bRHrWgJNtnucK9LhX11jHUpsRDxvb2YDrJ
         yOV06fYaeZGSCX/w1rPuXkLtVKydlSqNx6Z/Fem4pJJ1kDRVggh5Uj+AH0bMH62ZypJW
         Q03bLunucWBH9gKBLZvPWn2A7oQICC8Un52qJiZFZO8i4s1Cre4Aom8A14xOXQRg4Ay1
         kgHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698220631; x=1698825431;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Q7sXOhPkG0yrlbIXJ75m9LnEaT7H+cm3hu/aUOlITVU=;
        b=so1A+H6yH209VThqZb85sPAwexZoekHAF1HVv2icoeztsguD/ikgtBvspjD5vW+VoQ
         b3N77mdHpleTEpPPFYjmRSYTe34LRLzR5mewnKelH1w1J3C6SUsLewaPmIGBSQWzXhpR
         9YqiebsTU6Z0wETa4Sf8YCJ8UaN5bELbtzfer8tdk35YNZShxH1X0YZtrZXYr02LSXnY
         STsMngcZ3L1BSCnoCm0G1+rCoYNaWaWGk4aiWOZzz1VxsYfp5hfKWk7zRlA++/yB47QG
         b6646TfGYoAed5edgtLvSfE9ev9yk8jcZ8lKvPo828Q6BwqIaaODWi6GjtK0Z5pmwkQg
         MMvQ==
X-Gm-Message-State: AOJu0Yzw/gKTWNRkek/PSRXdBKL/OZ/z5L2+9SJyqcL2Dm4xS2BI7aIe
	KDGlFABKCK+f398cCOAGgpw=
X-Google-Smtp-Source: AGHT+IHZXZhr3LXXbFQLAssqdRBzxFH/SOju3pk0tF4SmtMFL1uRUOpuvYrFElOKeM9rW1SyXnTirQ==
X-Received: by 2002:a17:902:f945:b0:1c3:a4f2:7c99 with SMTP id kx5-20020a170902f94500b001c3a4f27c99mr13379586plb.4.1698220631201;
        Wed, 25 Oct 2023 00:57:11 -0700 (PDT)
Received: from localhost (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id k20-20020a170902ba9400b001b891259eddsm8590389pls.197.2023.10.25.00.57.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 00:57:10 -0700 (PDT)
Date: Wed, 25 Oct 2023 16:57:10 +0900 (JST)
Message-Id: <20231025.165710.1134967889825495180.fujita.tomonori@gmail.com>
To: benno.lossin@proton.me
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, andrew@lunn.ch, tmgross@umich.edu,
 miguel.ojeda.sandonis@gmail.com, wedsonaf@gmail.com, greg@kroah.com
Subject: Re: [PATCH net-next v6 2/5] rust: net::phy add module_phy_driver
 macro
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <42eeb38d-6d24-4c56-8ffd-27c48405cae9@proton.me>
References: <ca5873fb-3139-4198-8ff8-c3abc6c40347@proton.me>
	<20231025.090243.1437967503809186729.fujita.tomonori@gmail.com>
	<42eeb38d-6d24-4c56-8ffd-27c48405cae9@proton.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Wed, 25 Oct 2023 07:29:32 +0000
Benno Lossin <benno.lossin@proton.me> wrote:

> On 25.10.23 02:02, FUJITA Tomonori wrote:
>> On Tue, 24 Oct 2023 16:28:02 +0000
>> Benno Lossin <benno.lossin@proton.me> wrote:
>> 
>>> On 24.10.23 02:58, FUJITA Tomonori wrote:
>>>> This macro creates an array of kernel's `struct phy_driver` and
>>>> registers it. This also corresponds to the kernel's
>>>> `MODULE_DEVICE_TABLE` macro, which embeds the information for module
>>>> loading into the module binary file.
>>>>
>>>> A PHY driver should use this macro.
>>>>
>>>> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
>>>> ---
>>>>    rust/kernel/net/phy.rs | 129 +++++++++++++++++++++++++++++++++++++++++
>>>>    1 file changed, 129 insertions(+)
>>>>
>>>> diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
>>>> index 2d821c2475e1..f346b2b4d3cb 100644
>>>> --- a/rust/kernel/net/phy.rs
>>>> +++ b/rust/kernel/net/phy.rs
>>>> @@ -706,3 +706,132 @@ const fn as_int(&self) -> u32 {
>>>>            }
>>>>        }
>>>>    }
>>>> +
>>>> +/// Declares a kernel module for PHYs drivers.
>>>> +///
>>>> +/// This creates a static array of kernel's `struct phy_driver` and registers it.
>>>> +/// This also corresponds to the kernel's `MODULE_DEVICE_TABLE` macro, which embeds the information
>>>> +/// for module loading into the module binary file. Every driver needs an entry in `device_table`.
>>>> +///
>>>> +/// # Examples
>>>> +///
>>>> +/// ```ignore
>>>
>>> Is this example ignored, because it does not compile?
>> 
>> The old version can't be compiled but the current version can so I'll
>> drop ignore.
>> 
>> 
>>> I think Wedson was wrapping his example with `module!` inside
>>> of a module, so maybe try that?
>> 
>> I'm not sure what you mean.
> 
> Wedson did this [1], note the `# mod module_fs_sample`:
> 
> /// # Examples
> ///
> /// ```
> /// # mod module_fs_sample {
> /// use kernel::prelude::*;
> /// use kernel::{c_str, fs};
> ///
> /// kernel::module_fs! {
> ///     type: MyFs,
> ///     name: "myfs",
> ///     author: "Rust for Linux Contributors",
> ///     description: "My Rust fs",
> ///     license: "GPL",
> /// }
> ///
> /// struct MyFs;
> /// impl fs::FileSystem for MyFs {
> ///     const NAME: &'static CStr = c_str!("myfs");
> /// }
> /// # }
> /// ```
> 
> [1]: https://github.com/wedsonaf/linux/commit/e909f439481cf6a3df00c7064b0d64cee8630fe9#diff-9b893393ed2a537222d79f6e2fceffb7e9d8967791c2016962be3171c446210fR104-R124

You are suggesting like the following?

/// # Examples
///
/// ```
/// # mod module_phy_driver_sample {
...
/// # }
/// ```

What benefits?


>>>> +        const _: () = {
>>>> +            static mut DRIVERS: [
>>>> +                ::kernel::net::phy::DriverVTable;
>>>> +                $crate::module_phy_driver!(@count_devices $($driver),+)
>>>> +            ] = [
>>>> +                $(::kernel::net::phy::create_phy_driver::<$driver>()),+
>>>> +            ];
>>>> +
>>>> +            impl ::kernel::Module for Module {
>>>> +                fn init(module: &'static ThisModule) -> Result<Self> {
>>>> +                    // SAFETY: The anonymous constant guarantees that nobody else can access the `DRIVERS` static.
>>>> +                    // The array is used only in the C side.
>>>> +                    let mut reg = unsafe { ::kernel::net::phy::Registration::register(module, core::pin::Pin::static_mut(&mut DRIVERS)) }?;
>>>
>>> Can you put the safe operations outside of the `unsafe` block?
>> 
>> fn init(module: &'static ThisModule) -> Result<Self> {
>>      // SAFETY: The anonymous constant guarantees that nobody else can access
>>      // the `DRIVERS` static. The array is used only in the C side.
>>      let mut reg = ::kernel::net::phy::Registration::register(
>>          module,
>>          core::pin::Pin::static_mut(unsafe { &mut DRIVERS }),
>>      )?;
>>      Ok(Module { _reg: reg })
>> }
> 
> Here the `unsafe` block and the `SAFETY` comment are pretty far away.
> What about this?:
> 
> fn init(module: &'static ThisModule) -> Result<Self> {
>      // SAFETY: The anonymous constant guarantees that nobody else can access
>      // the `DRIVERS` static. The array is used only in the C side.
>      let drivers = unsafe { &mut DRIVERS };
>      let mut reg =
>          ::kernel::net::phy::Registration::register(module, ::core::pin::Pin::static_mut(drivers))?;
>      Ok(Module { _reg: reg })
> }
> 
> Also note that I added `::` to the front of `core`.

I see.

