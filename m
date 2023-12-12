Return-Path: <netdev+bounces-56640-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C16A680FB1C
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 00:15:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58D2B281210
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 23:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8271064715;
	Tue, 12 Dec 2023 23:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="gHSZkiWQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C79AAF
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 15:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1702422942; x=1702682142;
	bh=pLT5hzHn5ZzL4/fZP4CDa+l2XypCXo79rYBHGVix6oE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=gHSZkiWQHKT/y5gIyNVDweEPtXMR9PNpUb9peLPbI2uKycjHXfRJP/m0YAMs9suv1
	 am98KShtvc8Opb/x/i7P0jvSYFGrOzd0bkHkhS+Sp+lpvrCo720VgoWExvyN24hXu7
	 NSC6KXUCgtWMNuXG2GGI33wxhi51XTZG2AttBYgjxUmi4zoyQv0PnPyT9iUPoCKSRo
	 Y3EfN6RKq/pdJZU3XDlzVQnBk6TrhL/6Z7qA1F1GHmaNx/KgA22Ck2MGK2PHnce/hZ
	 RA8WO/FELjrkGN/D4+9CM0XnNKw192UivJ1iuCCdYr0FXaHN4cjgJKzPdBWVYlBT7b
	 o+1yJCYTsxkkQ==
Date: Tue, 12 Dec 2023 23:15:34 +0000
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: boqun.feng@gmail.com, alice@ryhl.io, netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch, tmgross@umich.edu, miguel.ojeda.sandonis@gmail.com, wedsonaf@gmail.com, aliceryhl@google.com
Subject: Re: [PATCH net-next v10 1/4] rust: core abstractions for network PHY drivers
Message-ID: <b997194f-f9fa-4397-806d-65436ed83d07@proton.me>
In-Reply-To: <20231213.080132.1176561831114639778.fujita.tomonori@gmail.com>
References: <ZXf5g5srNnCtgcL5@Boquns-Mac-mini.home> <20231212.220216.1253919664184581703.fujita.tomonori@gmail.com> <544015ec-52a4-4253-a064-8a2b370c06dc@proton.me> <20231213.080132.1176561831114639778.fujita.tomonori@gmail.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/13/23 00:01, FUJITA Tomonori wrote:
> On Tue, 12 Dec 2023 17:35:34 +0000
> Benno Lossin <benno.lossin@proton.me> wrote:
>=20
>> On 12/12/23 14:02, FUJITA Tomonori wrote:
>>> On Mon, 11 Dec 2023 22:11:15 -0800
>>> Boqun Feng <boqun.feng@gmail.com> wrote:
>>>
>>>>>> // SAFETY: `phydev` points to valid object per the type invariant of
>>>>>> // `Self`, also the following just minics what `phy_read()` does in =
C
>>>>>> // side, which should be safe as long as `phydev` is valid.
>>>>>>
>>>>>> ?
>>>>>
>>>>> Looks ok to me but after a quick look at in-tree Rust code, I can't
>>>>> find a comment like X is valid for the first argument in this C
>>>>> function. What I found are comments like X points to valid memory.
>>>>
>>>> Hmm.. maybe "is valid" could be a confusing term, so the point is: if
>>>> `phydev` is pointing to a properly maintained struct phy_device, then =
an
>>>> open code of phy_read() should be safe. Maybe "..., which should be sa=
fe
>>>> as long as `phydev` points to a valid struct phy_device" ?
>>>
>>> As Alice suggested, I updated the comment. The current comment is:
>>>
>>> // SAFETY: `phydev` is pointing to a valid object by the type invariant=
 of `Self`.
>>> // So it's just an FFI call.
>>> let ret =3D unsafe {
>>>     bindings::mdiobus_read((*phydev).mdio.bus, (*phydev).mdio.addr, reg=
num.into())
>>> };
>>
>> I still think you need to justify why `mdio.bus` is a pointer that you
>> can give to `midobus_read`. After looking at the C code, it seems like
>> that the pointer needs to point to a valid `struct mii_bus`.
>> This *could* just be an invariant of `struct phy_device` [1], but where
>> do we document that?
>=20
> If phy_device points to a valid object, phy_device.mdio is valid.

Where is this documented?

> A mii_bus must exist before a phy device. A bus is scanned and then a
> phy device is found (so phy_device object is crated).
>=20
> https://elixir.bootlin.com/linux/v6.6.5/source/drivers/net/phy/phy_device=
.c#L634

I know that this is the status. But for this to be useful as a
justification it must be written down somewhere where you can expect to
find it. Not some knowledge that "everyone just knows".
I would prefer to use the solution that I detailed in the other thread.

--=20
Cheers,
Benno


