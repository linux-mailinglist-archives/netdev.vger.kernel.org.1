Return-Path: <netdev+bounces-45187-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD237DB531
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 09:35:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D3C9B20C99
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 08:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F9AF3D9E;
	Mon, 30 Oct 2023 08:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="j1QpPpKz"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E174BD2F8;
	Mon, 30 Oct 2023 08:35:08 +0000 (UTC)
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12515A7;
	Mon, 30 Oct 2023 01:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1698654905; x=1698914105;
	bh=BVHa12NNwhvoHATpYYKQ2nf2GNNOt16CBd5GvICmLvc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=j1QpPpKzhxpgt3iVbdeVdT9BqA7UGmkbAnfvBrpvSB6RjDJr3qPCi/8yoMJnI44mJ
	 5hFj0mh93NxMSUF/9fFvLSdXMd9a1Y1F9qtZoXu2LymwCsdJQ/xIfmRahwBjmSXywS
	 FO+PBm315CB+pDomNGAkQPuDH82QRaULiB0XQlv69wBSD4rpB0eVryn5NcK4Qkm/XD
	 qtQGtdxbMGKhbh/21VJOMvpEakHmS0F00jVetB0sIIeBkn7xwTjJWM8T8vh18DmCVQ
	 h/4IwwdNWsJPEpXIbzqIhqiRN0YNCZf1G5/TV02G4pQcJ7m172wIkbzqP+OQYpB6w+
	 V1iQ6SM0WDCQg==
Date: Mon, 30 Oct 2023 08:34:46 +0000
To: Boqun Feng <boqun.feng@gmail.com>, FUJITA Tomonori <fujita.tomonori@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: andrew@lunn.ch, netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, tmgross@umich.edu, miguel.ojeda.sandonis@gmail.com, wedsonaf@gmail.com
Subject: Re: [PATCH net-next v7 1/5] rust: core abstractions for network PHY drivers
Message-ID: <41e9ec99-6993-4bb4-a5e5-ade7cf4927a4@proton.me>
In-Reply-To: <ZT72no2gdASP0STS@boqun-archlinux>
References: <0e858596-51b7-458c-a4eb-fa1e192e1ab3@proton.me> <20231029.132112.1989077223203124314.fujita.tomonori@gmail.com> <ZT6M6WPrCaLb-0QO@Boquns-Mac-mini.home> <20231030.075852.213658405543618455.fujita.tomonori@gmail.com> <ZT72no2gdASP0STS@boqun-archlinux>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 30.10.23 01:19, Boqun Feng wrote:
> On Mon, Oct 30, 2023 at 07:58:52AM +0900, FUJITA Tomonori wrote:
>> if you read partially, the part might be modified by the C side during
>> reading.
>=20
> If you read the part protected by phy_device->lock, C side shouldn't
> modify it, but the case here is not all fields in phy_device stay
> unchanged when phy_device->lock (and Rust side doesn't mark them
> interior mutable), see the discussion drom Andrew and me.
>=20
>>
>> For me, the issue is that creating &T for an object that might be
>> modified.
>=20
> The reason a `&phy_device` cannot be created here is because concurrent
> writes may cause a invalid phy_device (i.e. data race), the same applies
> to a copy.

Both comments by Boqun above are correct. Additionally even if the write
would not have a data race with the read, it would still be UB. (For exampl=
e
when the write is by the same thread)

If you just read the field itself then it should be fine, since it is
protected by a lock, see Boqun's patch for manually accessing the bitfields=
.

But I would wait until we see a response from the bindgen devs on the issue=
.

--=20
Cheers,
Benno



