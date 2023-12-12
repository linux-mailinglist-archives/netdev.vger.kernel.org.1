Return-Path: <netdev+bounces-56632-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E892A80FA7B
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 23:40:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 186061C20DE1
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 22:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C76ABC2EE;
	Tue, 12 Dec 2023 22:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="fhjqgjQD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1655CB2
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 14:40:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1702420818; x=1702680018;
	bh=ykaoMZQh8JhRUub7yjof2pF9x4HUjbMvHg7m4xyvkF4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=fhjqgjQD5sBx6/a8k/qX4MOOi7Nbac6W7jdmT46JZAxUVg5p1f5XaliHGQxMEGZ+G
	 sZEr69TiO9mnbTsRa68LpuV8suonJH//nm20uYee3hclRNOKtubCmvT0j1v6V/WUT9
	 dnuC2B3ecsbm/KSAp5clqveJpj2lBN02QH6y5Z76rIa6C6DaWi+PqwhPJGyw0vuAQ5
	 FnZzYPCPJCSJJI9G4x8727JwEsrBQy6+jId2Eex8YZEXsqwjcv6vJonxnMAs04V9Gn
	 lRROhAFS4wbJLi69MAKLkZLFUU7qnHk6S5tMj2+mRnD6TRzqH68eVirOVtbuQRRJf1
	 fdP0DOHcQqo4Q==
Date: Tue, 12 Dec 2023 22:40:01 +0000
To: Boqun Feng <boqun.feng@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, alice@ryhl.io, netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch, tmgross@umich.edu, miguel.ojeda.sandonis@gmail.com, wedsonaf@gmail.com, aliceryhl@google.com
Subject: Re: [PATCH net-next v10 1/4] rust: core abstractions for network PHY drivers
Message-ID: <e9997f99-7261-4e9e-b465-e3869b6f4a6f@proton.me>
In-Reply-To: <ZXjBKEBUrisSJ7Gx@boqun-archlinux>
References: <ZXfFzKYMxBt7OhrM@boqun-archlinux> <20231212.130410.1213689699686195367.fujita.tomonori@gmail.com> <ZXf5g5srNnCtgcL5@Boquns-Mac-mini.home> <20231212.220216.1253919664184581703.fujita.tomonori@gmail.com> <544015ec-52a4-4253-a064-8a2b370c06dc@proton.me> <ZXjBKEBUrisSJ7Gx@boqun-archlinux>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/12/23 21:23, Boqun Feng wrote:
> On Tue, Dec 12, 2023 at 05:35:34PM +0000, Benno Lossin wrote:
>> [1]: Technically it is a combination of the following invariants:
>> - the `mdio` field of `struct phy_device` is a valid `struct mido_device=
`
>> - the `bus` field of `struct mdio_device` is a valid pointer to a valid
>>   `struct mii_bus`.
>>
>>> If phy_read() is called here, I assume that you are happy about the
>>> above comment. The way to call mdiobus_read() here is safe because it
>>> just an open code of phy_read(). Simply adding it works for you?
>>>
>>> // SAFETY: `phydev` is pointing to a valid object by the type invariant=
 of `Self`.
>>> // So it's just an FFI call, open code of `phy_read()`.
>>
>> This would be fine if we decide to go with the exception I detailed
>> above. Although instead of "open code" I would write "see implementation
>> of `phy_read()`".
>>
>=20
> So the rationale here is the callsite of mdiobus_read() is just a
> open-code version of phy_read(), so if we meet the same requirement of
> phy_read(), we should be safe here. Maybe:
>=20
> =09"... open code of `phy_read()` with a valid phy_device pointer
> =09`phydev`"
>=20
> ?

Hmm that might be OK if we add "TODO: replace this with `phy_read` once
bindgen can handle static inline functions.".

Actually, why can't we just use the normal `rust_helper_*` approach? So
just create a `rust_helper_phy_read` that calls `phy_read`. Then call
that from the rust side. Doing this means that we can just keep the
invariants of `struct phy_device` opaque to the Rust side.
That would probably be preferable to adding the `TODO`, since when
bindgen has this feature available, we will automatically handle this
and not forget it. Also we have no issue with diverging code.

--=20
Cheers,
Benno


