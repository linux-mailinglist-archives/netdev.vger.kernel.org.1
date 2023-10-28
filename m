Return-Path: <netdev+bounces-44973-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D2EC7DA5D3
	for <lists+netdev@lfdr.de>; Sat, 28 Oct 2023 10:36:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22B67B212A8
	for <lists+netdev@lfdr.de>; Sat, 28 Oct 2023 08:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C22A64427;
	Sat, 28 Oct 2023 08:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="ke9uTE4l"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCB4257B
	for <netdev@vger.kernel.org>; Sat, 28 Oct 2023 08:35:55 +0000 (UTC)
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D319121
	for <netdev@vger.kernel.org>; Sat, 28 Oct 2023 01:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1698482150; x=1698741350;
	bh=CCUKTpfWXiqM0w1ZeBbNt5hS5uZwregLAu471m/tXFI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=ke9uTE4l9iPeaiolP+Rl9Ag5lYgxoUWhiUw2J8CwD6/681ijxc+dPHhFoOa+JZt/I
	 qVjYwX7tZZYS5SZ8gm9VTO25CsQQngcR0+V6soc2grx4kQFS2+VgRFUtsFQFcEOY1v
	 /haWUFHzsDrFq10PQ2mTv0KtLJ1cSm+wIEWrzQ9yxJe5aA4SyB1IbjrtL5YdkthRmN
	 aY5JDatBSHGPwGj1t0FlATtDXp5+QYWZgTz12LQ+2nhe5PE0HDgqCwER3fByp8EPHb
	 ngkJJt1YnOP7N7Z/0k0HWbFKfKkl/2YMBAHJUg1yjkAOCvhvSmrddgcQqI5Vld1QkO
	 lCb03e8Abqx1Q==
Date: Sat, 28 Oct 2023 08:35:38 +0000
To: Boqun Feng <boqun.feng@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch, tmgross@umich.edu, miguel.ojeda.sandonis@gmail.com, wedsonaf@gmail.com
Subject: Re: [PATCH net-next v7 1/5] rust: core abstractions for network PHY drivers
Message-ID: <e7da93d6-b938-4558-95b2-e9d2e0194621@proton.me>
In-Reply-To: <ZTxHKCWTAA7T-MJd@boqun-archlinux>
References: <20231026001050.1720612-1-fujita.tomonori@gmail.com> <20231026001050.1720612-2-fujita.tomonori@gmail.com> <ZTwWse0COE3w6_US@boqun-archlinux> <ba9614cf-bff6-4617-99cb-311fe40288c1@proton.me> <ZTw3_--yDkJ9ZwIP@boqun-archlinux> <77c78010-781e-4eb4-a7ba-3e9f9a07bf67@proton.me> <ZTxHKCWTAA7T-MJd@boqun-archlinux>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 28.10.23 01:26, Boqun Feng wrote:
> On Fri, Oct 27, 2023 at 10:50:45PM +0000, Benno Lossin wrote:
> [...]
>>>
>>> Hmm... but does it mean even `set_speed()` has the similar issue?
>>>
>>> =09let phydev: *mut phy_device =3D self.0.get();
>>> =09unsafe { (*phydev).speed =3D ...; }
>>
>> No that should be fine, take a look at the MIR output of the following
>> code [1]:
>>
>>      struct Foo {
>>          a: usize,
>>          b: usize,
>>      }
>>
>>      fn foo(ptr: *mut Foo) {
>>          unsafe { (*ptr).b =3D 0; }
>>      }
>>
>>      fn bar(ptr: *mut Foo) {
>>          unsafe { (&mut *ptr).b =3D 0; }
>>      }
>>
>> Aside from some alignment checking, foo's MIR looks like this:
>>
>>      bb1: {
>>          ((*_1).1: usize) =3D const 0_usize;
>>          return;
>>      }
>>
>> And bar's MIR like this:
>>
>>      bb1: {
>>          _2 =3D &mut (*_1);
>>          ((*_2).1: usize) =3D const 0_usize;
>>          return;
>>      }
>>
>> [1]: https://play.rust-lang.org/?version=3Dstable&mode=3Ddebug&edition=
=3D2021&gist=3Df7c4d87bf29a64af0acc09ff75d3716d
>>
>> So I think that is fine, but maybe Gary has something else to say about =
it.
>>
>=20
> Well when `-C opt-level=3D2`, they are the same:
>=20
> =09https://godbolt.org/z/hxxo75YYh

It doesn't matter what the optimizer does, `bar` is unsound in our use-case
and `foo` is fine (I think).

--=20
Cheers,
Benno



