Return-Path: <netdev+bounces-43211-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A83B7D1BC4
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 10:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B64C28263D
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 08:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C334C1110;
	Sat, 21 Oct 2023 08:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="NNpfMn0H"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFD2ECB;
	Sat, 21 Oct 2023 08:37:26 +0000 (UTC)
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D97F6D41;
	Sat, 21 Oct 2023 01:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=7oaxramkdzhmthip2otxkhsjwe.protonmail; t=1697877439; x=1698136639;
	bh=Y/X2uQ1TS5PSlfnefO+l81KvFhzKGzXxmTQaYzYiZLs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=NNpfMn0HUjyvym2UpbIazFLwUVpyxfdIC+BMVMbjFCBtdIORvdPju609hG+0JD2Lx
	 Ku1R82dbgG55hY9D0eZ5HxesK+VK/RGCmxupFnD2IQ43MF3PqiwOSe8D9kE1mfLtXL
	 RYvwEs7TM8N+7WdsRlWw/gGoF16yE0NZp1i2SXoOTjAS0iJABEjZCShCUFUqOkHQ25
	 w/3o2C0qo0/rgP4zU0/izONVy7hOC/NvG1sHBUggCd5JlZ2kQXY0EvoSLCKXztAAFf
	 wrPHTmJ68Iukd7kR8f02Xt30ta04JsC7BSKs9B0+Wz2IsgW45iHXANM4jxM5l88WId
	 enWSinsC7KJdg==
Date: Sat, 21 Oct 2023 08:37:08 +0000
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch, miguel.ojeda.sandonis@gmail.com, tmgross@umich.edu, boqun.feng@gmail.com, wedsonaf@gmail.com, greg@kroah.com
Subject: Re: [PATCH net-next v5 1/5] rust: core abstractions for network PHY drivers
Message-ID: <4e3e0801-b8b2-457b-aee1-086d20365890@proton.me>
In-Reply-To: <20231021.163015.27220410326177568.fujita.tomonori@gmail.com>
References: <20231020.093446.482864708938996774.fujita.tomonori@gmail.com> <20231020.215448.1421599168007259810.fujita.tomonori@gmail.com> <b218e543-d61c-4317-9b19-05ac6ce47d15@proton.me> <20231021.163015.27220410326177568.fujita.tomonori@gmail.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 21.10.23 09:30, FUJITA Tomonori wrote:
> On Sat, 21 Oct 2023 07:25:17 +0000
> Benno Lossin <benno.lossin@proton.me> wrote:
>=20
>> On 20.10.23 14:54, FUJITA Tomonori wrote:
>>> On Fri, 20 Oct 2023 09:34:46 +0900 (JST)
>>> FUJITA Tomonori <fujita.tomonori@gmail.com> wrote:
>>>
>>>> On Thu, 19 Oct 2023 15:20:51 +0000
>>>> Benno Lossin <benno.lossin@proton.me> wrote:
>>>>
>>>>> I would like to remove the mutable static variable and simplify
>>>>> the macro.
>>>>
>>>> How about adding DriverVTable array to Registration?
>>>>
>>>> /// Registration structure for a PHY driver.
>>>> ///
>>>> /// # Invariants
>>>> ///
>>>> /// The `drivers` slice are currently registered to the kernel via `ph=
y_drivers_register`.
>>>> pub struct Registration<const N: usize> {
>>>>       drivers: [DriverVTable; N],
>>>> }
>>>>
>>>> impl<const N: usize> Registration<{ N }> {
>>>>       /// Registers a PHY driver.
>>>>       pub fn register(
>>>>           module: &'static crate::ThisModule,
>>>>           drivers: [DriverVTable; N],
>>>>       ) -> Result<Self> {
>>>>           let mut reg =3D Registration { drivers };
>>>>           let ptr =3D reg.drivers.as_mut_ptr().cast::<bindings::phy_dr=
iver>();
>>>>           // SAFETY: The type invariants of [`DriverVTable`] ensure th=
at all elements of the `drivers` slice
>>>>           // are initialized properly. So an FFI call with a valid poi=
nter.
>>>>           to_result(unsafe {
>>>>               bindings::phy_drivers_register(ptr, reg.drivers.len().tr=
y_into()?, module.0)
>>>>           })?;
>>>>           // INVARIANT: The `drivers` slice is successfully registered=
 to the kernel via `phy_drivers_register`.
>>>>           Ok(reg)
>>>>       }
>>>> }
>>>
>>> Scratch this.
>>>
>>> This doesn't work. Also simply putting slice of DriverVTable into
>>> Module strcut doesn't work.
>>
>> Why does it not work? I tried it and it compiled fine for me.
>=20
> You can compile but the kernel crashes. The addresses of the callback
> functions are invalid.

Can you please share your setup and the error? For me it booted fine.

--=20
Cheers,
Benno



