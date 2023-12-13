Return-Path: <netdev+bounces-56865-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C26A68110D0
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 13:15:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E0951F212A3
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 12:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7121728DD6;
	Wed, 13 Dec 2023 12:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="ZuDFQn9F"
X-Original-To: netdev@vger.kernel.org
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67E03B0
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 04:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1702469699; x=1702728899;
	bh=Zqk2zoyfaGGXrvLxTBqarsBmK9ljpHypJub7CA1ot9E=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=ZuDFQn9FjAUjVQaQ90wlvl5ZYDvoOOI1qM9FJbCRqFULjn0/4QcfqJOV8k/7mFi+F
	 3dvkxiObcUymDvHC1hKOFJamygdHe0WpwJlqNIN2ZM9AEhoVVBPP4lVUqWJeAq10i3
	 aGYuTX8MotQlkP1Vt2bnjHQzObwqhbjljNnoMQq3oU/a2+VvhrnR1fHLh1rQUhOCLt
	 WS2k64P5aJzofVgT2Oh/fzKApkv3joYyxepPNT6027Kc/a64y9tEXEgWLa3gzwmNri
	 i0DwEa5ehcTK8AVBdvlFE9SdRTe+X9s3kBtn80sLw12sAqrwxTLSoC7NRxlH6dgpft
	 xfPZoke45ajvQ==
Date: Wed, 13 Dec 2023 12:14:55 +0000
To: Andrew Lunn <andrew@lunn.ch>
From: Benno Lossin <benno.lossin@proton.me>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, boqun.feng@gmail.com, alice@ryhl.io, netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, tmgross@umich.edu, miguel.ojeda.sandonis@gmail.com, wedsonaf@gmail.com, aliceryhl@google.com
Subject: Re: [PATCH net-next v10 1/4] rust: core abstractions for network PHY drivers
Message-ID: <3d6e1af3-9d86-4058-914f-ea3d7115e0db@proton.me>
In-Reply-To: <79abc99b-a0f2-48c6-ba68-b72dcf5f7254@lunn.ch>
References: <ZXfFzKYMxBt7OhrM@boqun-archlinux> <20231212.130410.1213689699686195367.fujita.tomonori@gmail.com> <ZXf5g5srNnCtgcL5@Boquns-Mac-mini.home> <20231212.220216.1253919664184581703.fujita.tomonori@gmail.com> <544015ec-52a4-4253-a064-8a2b370c06dc@proton.me> <79abc99b-a0f2-48c6-ba68-b72dcf5f7254@lunn.ch>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/13/23 11:28, Andrew Lunn wrote:
>> I still think you need to justify why `mdio.bus` is a pointer that you
>> can give to `midobus_read`.
>=20
> Maybe a dumb question. Why are you limiting this to just a few members
> of struct phy_device? It has ~50 members, any of which can be used by
> the C side when Rust calls into C.

I limited it to those few members, because the Rust side only uses
those.
Theoretically one could specify all invariants for all members, but that
seems like a *lot* of work.

In Rust everything [1] has to be initialized with a valid value.
Contrast this with C where everything is potentially uninitialized. As
an example, let's look at the first few fields of `PhyDevice`:

    struct PhyDevice {
        mdio: MdioDevice,
        drv: Box<PhyDriver>,
        devlink: Box<DeviceLink>,
        phy_id: u32,
        c45_ids: PhyC45DeviceIds,
        // ...
    }

Note that in Rust we now do not need to write down any invariants, since
they are all implicitly encoded. For example the `drv` field is of type
`Box<PhyDriver>`, it *always* is a pointer to an allocation that
contains a valid `PhyDriver`. So while on the C side you would have to
state this, on the Rust side we get it for free.

Rust function also make use of the "everything is in a valid state"
rule, they know that the fields are valid and thus the Rust equivalent
of `phy_read` could be safe and without any comments:

    impl PhyDevice {
        fn phy_read(&self, regnum: u32) -> i32 {
            self.mdio.bus.mdiobus_read(self.mdio.addr, regnum)
        }
    }

All of this only applies to safe code, `unsafe` code is allowed to
violate all of these things temporarily. However, when it gives a value
back to safe code [2], that value needs to be valid.

I think that specifying all of these implicit invariants in C will be
extremely laborious. Especially since the usual way of doing things in C
is not considering these invariants (at least not consciously), but
rather "just do the thing".

The way we do the interoperability is to just fully trust the C side to
produce valid values that we can feed back to the C side. Of course
there are caveats, so e.g. one needs to initialize a `struct mutex`
before it can be used, but that is what we need to capture with the
safety comments.

[1]: There are exceptions for this, but for the purposes of this
     discussion, they can be ignored. If you want to know more, you can
     read this article in the nomicon:
     https://doc.rust-lang.org/nomicon/unchecked-uninit.html

[2]: There are also exceptions, but I will omit them here.

--=20
Cheers,
Benno


