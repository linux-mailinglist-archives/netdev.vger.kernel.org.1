Return-Path: <netdev+bounces-44903-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF3617DA3BF
	for <lists+netdev@lfdr.de>; Sat, 28 Oct 2023 00:51:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D0C8B21203
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 22:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26AC938BAC;
	Fri, 27 Oct 2023 22:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="dIWh6OY6"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13FC8F69;
	Fri, 27 Oct 2023 22:51:11 +0000 (UTC)
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B19181BB;
	Fri, 27 Oct 2023 15:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1698447065; x=1698706265;
	bh=57A1OC/G5Zl+f08EZwfZIsus+/iLHZOLLcTxGGCO4P4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=dIWh6OY6ekP5Jt5b2OcGGEcgf8ESQHXBXV+yjadCsqbTKVyVzbUQIB8gmg3A3dYir
	 mguM1p81ra6Ql+JC0gk9jXE66qqIojwFEqzXHfNxVV/292suqEaDPnuGbHtg4nf3RL
	 Pf8Sp9kDLK6IjfBy2P2hod29h/hfdl+4UoWxUi4v38jAyUxSeedzmYa8zAy2+mD5Hv
	 gDFJReoNbp5M2SlbyMMtXDEBQZUHjV4eRAIhFka4Q8wOP2g+EBhq6A/BHV8d7ahpA4
	 5UnJDutxs6xQnvrqWaNd3SGZ8kKuZMjemeukvGzKhCXbL9MTiY9s2Z9vKgjdLTO3Eu
	 m9/2yeDoR9BLw==
Date: Fri, 27 Oct 2023 22:50:45 +0000
To: Boqun Feng <boqun.feng@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch, tmgross@umich.edu, miguel.ojeda.sandonis@gmail.com, wedsonaf@gmail.com
Subject: Re: [PATCH net-next v7 1/5] rust: core abstractions for network PHY drivers
Message-ID: <77c78010-781e-4eb4-a7ba-3e9f9a07bf67@proton.me>
In-Reply-To: <ZTw3_--yDkJ9ZwIP@boqun-archlinux>
References: <20231026001050.1720612-1-fujita.tomonori@gmail.com> <20231026001050.1720612-2-fujita.tomonori@gmail.com> <ZTwWse0COE3w6_US@boqun-archlinux> <ba9614cf-bff6-4617-99cb-311fe40288c1@proton.me> <ZTw3_--yDkJ9ZwIP@boqun-archlinux>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/28/23 00:21, Boqun Feng wrote:
> On Fri, Oct 27, 2023 at 09:19:38PM +0000, Benno Lossin wrote:
>> We need to be careful here, since doing this creates a reference
>> `&bindings::phy_device` which asserts that it is immutable. That is not
>> the case, since the C side might change it at any point (this is the
>> reason we wrap things in `Opaque`, since that allows mutatation even
>> through sharde references).
>>
>> I did not notice this before, but this means we cannot use the `link`
>> function from bindgen, since that takes `&self`. We would need a
>> function that takes `*const Self` instead.
>>
>=20
> Hmm... but does it mean even `set_speed()` has the similar issue?
>=20
> =09let phydev: *mut phy_device =3D self.0.get();
> =09unsafe { (*phydev).speed =3D ...; }

No that should be fine, take a look at the MIR output of the following=20
code [1]:

    struct Foo {
        a: usize,
        b: usize,
    }
   =20
    fn foo(ptr: *mut Foo) {
        unsafe { (*ptr).b =3D 0; }
    }
   =20
    fn bar(ptr: *mut Foo) {
        unsafe { (&mut *ptr).b =3D 0; }
    }

Aside from some alignment checking, foo's MIR looks like this:

    bb1: {
        ((*_1).1: usize) =3D const 0_usize;
        return;
    }

And bar's MIR like this:

    bb1: {
        _2 =3D &mut (*_1);
        ((*_2).1: usize) =3D const 0_usize;
        return;
    }

[1]: https://play.rust-lang.org/?version=3Dstable&mode=3Ddebug&edition=3D20=
21&gist=3Df7c4d87bf29a64af0acc09ff75d3716d

So I think that is fine, but maybe Gary has something else to say about it.

> The `(*phydev)` creates a `&mut` IIUC. So we need the following maybe?
>=20
> =09let phydev: *mut phy_device =3D self.0.get();
> =09unsafe { *addr_mut_of!((*phydev).speed) =3D ...; }
>=20
> because at least from phylib core guarantee, we know no one accessing
> `speed` in the same time. However, yes, bit fields are tricky...

--=20
Cheers,
Benno


