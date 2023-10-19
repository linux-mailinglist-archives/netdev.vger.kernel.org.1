Return-Path: <netdev+bounces-42731-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C368A7CFFBA
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 18:38:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51C3EB2118A
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 16:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B71727466;
	Thu, 19 Oct 2023 16:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="cnxw4E/P"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8C032C73
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 16:38:00 +0000 (UTC)
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EECBB132
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 09:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1697733474; x=1697992674;
	bh=Fuy5J52TyHo0W8QuUdMldiH4VtV/X5O0X6u7+caa8Po=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=cnxw4E/PYdjRxO1JSLIuKXxj2yiGW9Qd1LLqJ8wP5cjp73MffoNGR8Jw9Q1HBuztB
	 yvovZHUCK9FHzCpOvGICd9AW7LX/gEM5ifN2MOkHcFOTNYsjg0mk27ZNGVN53wp47G
	 jEVjVxKZ5jpgbFDeNHS0pGT3w6ioEaZHuA8xPsXvbq2+T6lsx724EeaoZFV9/Xhgua
	 bOK4NYKesQbHYcKb3jq/nNJBMfxD2I6znwe7LH9Qh2mX9kVA2K1PFrPJURv31Io2XO
	 1uKWSVUrRscssHyDWGUv7JDuq5kCh4Zf6uDk7Y30StqHioHTC8SiEk1efnta28Vpj+
	 2jQgtuXla403g==
Date: Thu, 19 Oct 2023 16:37:46 +0000
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch, miguel.ojeda.sandonis@gmail.com, tmgross@umich.edu, boqun.feng@gmail.com, wedsonaf@gmail.com, greg@kroah.com
Subject: Re: [PATCH net-next v5 1/5] rust: core abstractions for network PHY drivers
Message-ID: <398ec812-3dce-40b1-b4eb-bfff7e3feb6a@proton.me>
In-Reply-To: <20231020.003219.1788909848908453261.fujita.tomonori@gmail.com>
References: <0e8d2538-284b-4811-a2e7-99151338c255@proton.me> <20231019.234210.1772681043146865420.fujita.tomonori@gmail.com> <64db34c0-a50a-4321-a3d8-b692e26899d9@proton.me> <20231020.003219.1788909848908453261.fujita.tomonori@gmail.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 19.10.23 17:32, FUJITA Tomonori wrote:
>> You can just do this (I omitted the `::kernel::` prefix for
>> readability, if you add this in the macro, please include it):
>>
>>       // CAST: `DriverVTable` is `repr(transparent)` and wrapping `bindi=
ngs::phy_driver`.
>>       let ptr =3D drv.as_mut_ptr().cast::<bindings::phy_driver>();
>>       let len =3D drv.len().try_into()?;
>>       // SAFETY: ...
>>       to_result(unsafe { bindings::phy_drivers_register(ptr, len, module=
.0) })?;
>>
>>>                   })?;
>=20
> The above solves DriverVTable.0 but still the macro can't access to
> kernel::ThisModule.0. I got the following error:

I think we could just provide an `as_ptr` getter function
for `ThisModule`. But need to check with the others.

[...]

>>>> I suppose that it would be ok to call the register function multiple
>>>> times, since it only is on module startup/shutdown and it is not
>>>> performance critical.
>>>
>>> I think that we can use the current implantation using Reservation
>>> struct until someone requests manual creation. I doubt that we will
>>> need to support such.
>>
>> I would like to remove the mutable static variable and simplify
>> the macro.
>=20
> It's worse than having public unsafe function (phy_drivers_unregister)?

Why would that function have to be public?

--=20
Cheers,
Benno



