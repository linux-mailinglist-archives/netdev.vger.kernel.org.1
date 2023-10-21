Return-Path: <netdev+bounces-43206-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DC6E7D1B80
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 09:21:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F274DB2141E
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 07:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A586ADB;
	Sat, 21 Oct 2023 07:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="R4VlTAzM"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F124D186F
	for <netdev@vger.kernel.org>; Sat, 21 Oct 2023 07:21:29 +0000 (UTC)
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A0BD65
	for <netdev@vger.kernel.org>; Sat, 21 Oct 2023 00:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1697872880; x=1698132080;
	bh=oZ51bXZnucMgUGKZr/Gf//4zUxvdPjcWcZzOiOcUei0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=R4VlTAzMqbZAsWRYiYqRjs2QZ34row2911hSGcRZtDIfg+AolECppZRinLkQ7194O
	 X9vuvEXHDtNquHH3JuQKdbIAsjFAZqlOO1ElWwB0M2RI4l+MI4pii+H4AiOzbtlIlU
	 CDeEuVJiqsLTKDbi4tw+3Ndozwjk5VH7ycdRLr3M7gdts986eeWIpXoF6v0TBm8spA
	 uM6xn7I0CBqCsQk4mRMdeE81ZELdqiWuGq8smIm9qmj6KF+R2i5J0e6xZZMlRIbyRm
	 LPnHx4HinLhuuENmxnW1pw+/9kK3i2rnkulo7g4i/3ni5X3o4bB/N4FD+hFp1yvaGT
	 eYW9isPTwjo6g==
Date: Sat, 21 Oct 2023 07:21:07 +0000
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch, miguel.ojeda.sandonis@gmail.com, tmgross@umich.edu, boqun.feng@gmail.com, wedsonaf@gmail.com, greg@kroah.com
Subject: Re: [PATCH net-next v5 1/5] rust: core abstractions for network PHY drivers
Message-ID: <f7b625af-64aa-42db-9b9c-95c0125564ee@proton.me>
In-Reply-To: <20231020.065103.1042445600809743171.fujita.tomonori@gmail.com>
References: <64db34c0-a50a-4321-a3d8-b692e26899d9@proton.me> <20231020.003219.1788909848908453261.fujita.tomonori@gmail.com> <398ec812-3dce-40b1-b4eb-bfff7e3feb6a@proton.me> <20231020.065103.1042445600809743171.fujita.tomonori@gmail.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 19.10.23 23:51, FUJITA Tomonori wrote:
> On Thu, 19 Oct 2023 16:37:46 +0000
> Benno Lossin <benno.lossin@proton.me> wrote:
>=20
>> On 19.10.23 17:32, FUJITA Tomonori wrote:
>>>> You can just do this (I omitted the `::kernel::` prefix for
>>>> readability, if you add this in the macro, please include it):
>>>>
>>>>        // CAST: `DriverVTable` is `repr(transparent)` and wrapping `bi=
ndings::phy_driver`.
>>>>        let ptr =3D drv.as_mut_ptr().cast::<bindings::phy_driver>();
>>>>        let len =3D drv.len().try_into()?;
>>>>        // SAFETY: ...
>>>>        to_result(unsafe { bindings::phy_drivers_register(ptr, len, mod=
ule.0) })?;
>>>>
>>>>>                    })?;
>>>
>>> The above solves DriverVTable.0 but still the macro can't access to
>>> kernel::ThisModule.0. I got the following error:
>>
>> I think we could just provide an `as_ptr` getter function
>> for `ThisModule`. But need to check with the others.
>>
>=20
> ThisModule.0 is *mut bindings::module. Drivers should not use
> bindings?

This is a special case, since it `module` is used on a lot of functions
(and it does not make sense to provide abstractions for those on
`ThisModule`). Additionally, `ThisModule` already has a public `from_raw`
function that takes a `*mut bindings::module`.

If you add a `as_ptr` function, please create a separate patch for it.

--=20
Cheers,
Benno


