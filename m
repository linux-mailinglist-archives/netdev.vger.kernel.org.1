Return-Path: <netdev+bounces-43207-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 141D27D1B83
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 09:25:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92BCD282749
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 07:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72DAD270;
	Sat, 21 Oct 2023 07:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="bHoK6P9x"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736AC8BF0
	for <netdev@vger.kernel.org>; Sat, 21 Oct 2023 07:25:38 +0000 (UTC)
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDC16D7D
	for <netdev@vger.kernel.org>; Sat, 21 Oct 2023 00:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1697873130; x=1698132330;
	bh=f9wr7mZkBF8WY7lzCPRnAh0rU/gISs3zka4QrYHnsSQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=bHoK6P9x4s/NEci4S1k+0dm1BmxRyfT6cWo1Fw3XkG4vnWqvtY+hkXRqhG3z7Dzey
	 gGcCjzYpndn45WKyzV+1sfda1hHD4gzxNNmSKC7XYn1HHFf7rYmXsGm/oorc9oktB4
	 4DuAU3kS+sK23+HmrzQ1S9bUTC3nXAYnUOoUr19s6gzu7B24CWmtw6odkXuEEQnBST
	 HKWRS5SqxpR68D72v7SbM/0zT3vzLde2FRL/ZR8PTpxBdXAEkiY5JPTu+2AsWxO2BV
	 +IJZok7evZovsl+hxO5sE4HiVm3jBNChiHARb52qYAcnoGGE0VsbABU+V66Xn50MPS
	 Oa6mFS9XSCcdQ==
Date: Sat, 21 Oct 2023 07:25:17 +0000
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch, miguel.ojeda.sandonis@gmail.com, tmgross@umich.edu, boqun.feng@gmail.com, wedsonaf@gmail.com, greg@kroah.com
Subject: Re: [PATCH net-next v5 1/5] rust: core abstractions for network PHY drivers
Message-ID: <b218e543-d61c-4317-9b19-05ac6ce47d15@proton.me>
In-Reply-To: <20231020.215448.1421599168007259810.fujita.tomonori@gmail.com>
References: <20231019.234210.1772681043146865420.fujita.tomonori@gmail.com> <64db34c0-a50a-4321-a3d8-b692e26899d9@proton.me> <20231020.093446.482864708938996774.fujita.tomonori@gmail.com> <20231020.215448.1421599168007259810.fujita.tomonori@gmail.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 20.10.23 14:54, FUJITA Tomonori wrote:
> On Fri, 20 Oct 2023 09:34:46 +0900 (JST)
> FUJITA Tomonori <fujita.tomonori@gmail.com> wrote:
>=20
>> On Thu, 19 Oct 2023 15:20:51 +0000
>> Benno Lossin <benno.lossin@proton.me> wrote:
>>
>>> I would like to remove the mutable static variable and simplify
>>> the macro.
>>
>> How about adding DriverVTable array to Registration?
>>
>> /// Registration structure for a PHY driver.
>> ///
>> /// # Invariants
>> ///
>> /// The `drivers` slice are currently registered to the kernel via `phy_=
drivers_register`.
>> pub struct Registration<const N: usize> {
>>      drivers: [DriverVTable; N],
>> }
>>
>> impl<const N: usize> Registration<{ N }> {
>>      /// Registers a PHY driver.
>>      pub fn register(
>>          module: &'static crate::ThisModule,
>>          drivers: [DriverVTable; N],
>>      ) -> Result<Self> {
>>          let mut reg =3D Registration { drivers };
>>          let ptr =3D reg.drivers.as_mut_ptr().cast::<bindings::phy_drive=
r>();
>>          // SAFETY: The type invariants of [`DriverVTable`] ensure that =
all elements of the `drivers` slice
>>          // are initialized properly. So an FFI call with a valid pointe=
r.
>>          to_result(unsafe {
>>              bindings::phy_drivers_register(ptr, reg.drivers.len().try_i=
nto()?, module.0)
>>          })?;
>>          // INVARIANT: The `drivers` slice is successfully registered to=
 the kernel via `phy_drivers_register`.
>>          Ok(reg)
>>      }
>> }
>=20
> Scratch this.
>=20
> This doesn't work. Also simply putting slice of DriverVTable into
> Module strcut doesn't work.

Why does it not work? I tried it and it compiled fine for me.

> We cannot move a slice of DriverVTable. Except for static allocation,
> is there a simple way?

I do not know what you are referring to, you can certainly move an array
of `DriverVTable`s.

--=20
Cheers,
Benno



