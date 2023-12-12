Return-Path: <netdev+bounces-56538-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 965E980F4B4
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 18:35:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 963361C20CF7
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 17:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C18887D8A3;
	Tue, 12 Dec 2023 17:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="O1wQ04m2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F1B58F
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 09:35:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1702402543; x=1702661743;
	bh=yYYyEVfceeIkJgL3YM5c5bx1Yypx0l6dB7B0gX5JUek=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=O1wQ04m2B22DpwbZ0Ob+JnayGOIUoZzHZFoMYxPxACK2RnDY72Rsw1OnMRxB0rnNf
	 dg48pgy7yhDOWS7T57JAbNm2t9KdMUEMVomuuW/SCqaJhn6OnBF0sIlQlWT9SaLvOe
	 CcZFfu9TMt15/hSlZ+y2Xabw84mB34H4q7cycZ+xFqnTlj0hVDUjj8GZgvXTRX9Z5R
	 GVStXsXxPPNV9oJIX1udLj/sNZraz+BUs25Xf4uxR8bDBW9pOIPr/fhpxb4IQI6WwU
	 RIV1Rs9gJ5zRWF1hsedWyRyBauo1mch0Qmf4Fb1jkRnREJV3nH1nE8boz7+FpJo/Z9
	 Y+UQhoasgdUAw==
Date: Tue, 12 Dec 2023 17:35:34 +0000
To: FUJITA Tomonori <fujita.tomonori@gmail.com>, boqun.feng@gmail.com
From: Benno Lossin <benno.lossin@proton.me>
Cc: alice@ryhl.io, netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch, tmgross@umich.edu, miguel.ojeda.sandonis@gmail.com, wedsonaf@gmail.com, aliceryhl@google.com
Subject: Re: [PATCH net-next v10 1/4] rust: core abstractions for network PHY drivers
Message-ID: <544015ec-52a4-4253-a064-8a2b370c06dc@proton.me>
In-Reply-To: <20231212.220216.1253919664184581703.fujita.tomonori@gmail.com>
References: <ZXfFzKYMxBt7OhrM@boqun-archlinux> <20231212.130410.1213689699686195367.fujita.tomonori@gmail.com> <ZXf5g5srNnCtgcL5@Boquns-Mac-mini.home> <20231212.220216.1253919664184581703.fujita.tomonori@gmail.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/12/23 14:02, FUJITA Tomonori wrote:
> On Mon, 11 Dec 2023 22:11:15 -0800
> Boqun Feng <boqun.feng@gmail.com> wrote:
>=20
>>>> // SAFETY: `phydev` points to valid object per the type invariant of
>>>> // `Self`, also the following just minics what `phy_read()` does in C
>>>> // side, which should be safe as long as `phydev` is valid.
>>>>
>>>> ?
>>>
>>> Looks ok to me but after a quick look at in-tree Rust code, I can't
>>> find a comment like X is valid for the first argument in this C
>>> function. What I found are comments like X points to valid memory.
>>
>> Hmm.. maybe "is valid" could be a confusing term, so the point is: if
>> `phydev` is pointing to a properly maintained struct phy_device, then an
>> open code of phy_read() should be safe. Maybe "..., which should be safe
>> as long as `phydev` points to a valid struct phy_device" ?
>=20
> As Alice suggested, I updated the comment. The current comment is:
>=20
> // SAFETY: `phydev` is pointing to a valid object by the type invariant o=
f `Self`.
> // So it's just an FFI call.
> let ret =3D unsafe {
>     bindings::mdiobus_read((*phydev).mdio.bus, (*phydev).mdio.addr, regnu=
m.into())
> };

I still think you need to justify why `mdio.bus` is a pointer that you
can give to `midobus_read`. After looking at the C code, it seems like
that the pointer needs to point to a valid `struct mii_bus`.
This *could* just be an invariant of `struct phy_device` [1], but where
do we document that?

We could make an exception here and treat this differently until bindgen
can handle the `static inline` functions, but I am not so sure if we
want to have this as a general pattern. We need to discuss this more.


[1]: Technically it is a combination of the following invariants:
- the `mdio` field of `struct phy_device` is a valid `struct mido_device`
- the `bus` field of `struct mdio_device` is a valid pointer to a valid
  `struct mii_bus`.

> If phy_read() is called here, I assume that you are happy about the
> above comment. The way to call mdiobus_read() here is safe because it
> just an open code of phy_read(). Simply adding it works for you?
>=20
> // SAFETY: `phydev` is pointing to a valid object by the type invariant o=
f `Self`.
> // So it's just an FFI call, open code of `phy_read()`.

This would be fine if we decide to go with the exception I detailed
above. Although instead of "open code" I would write "see implementation
of `phy_read()`".

--=20
Cheers,
Benno


