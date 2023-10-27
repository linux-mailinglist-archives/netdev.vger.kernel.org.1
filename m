Return-Path: <netdev+bounces-44861-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 355747DA255
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 23:20:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECD001C2109B
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 21:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8F6C3FB20;
	Fri, 27 Oct 2023 21:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="QMcX1j5T"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702713AC1D;
	Fri, 27 Oct 2023 21:20:00 +0000 (UTC)
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EDC81B4;
	Fri, 27 Oct 2023 14:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1698441595; x=1698700795;
	bh=spuJpitIyTBSXss8DKFWhKAAVlsHhcnFwqRBEpKCbgE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=QMcX1j5TstWd6jXfLGDmUD4iUYsgGLojqZPCOECbdmxv+WGPqG4Xs2XcP5xt2cAUG
	 Mjq265n9SIQ5ILglcCBUQAVygDOZ8HS1x6pbj04NR9i2ZnXZ2P+vviJEt2saa5Qday
	 CEDyJ0kVwC7n41oeMhv1ES9jBziDRn7f4cCqMKfTdTysC5/5ekC2WQYMUFP22jjdSH
	 v1JZVbryZXu4LlYVYf0x0vyMPd8AEG152AAnBeRqoa3FTla9050QqVIaVo/aCUnj5R
	 3MJSk1V9s1YXrvtqfgISrmL0Uw7QscRMGi41/STq5y9sjlXP1HjEdc0uxD4a+pIKyn
	 mitC5MTCLFkcQ==
Date: Fri, 27 Oct 2023 21:19:38 +0000
To: Boqun Feng <boqun.feng@gmail.com>, FUJITA Tomonori <fujita.tomonori@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch, tmgross@umich.edu, miguel.ojeda.sandonis@gmail.com, wedsonaf@gmail.com
Subject: Re: [PATCH net-next v7 1/5] rust: core abstractions for network PHY drivers
Message-ID: <ba9614cf-bff6-4617-99cb-311fe40288c1@proton.me>
In-Reply-To: <ZTwWse0COE3w6_US@boqun-archlinux>
References: <20231026001050.1720612-1-fujita.tomonori@gmail.com> <20231026001050.1720612-2-fujita.tomonori@gmail.com> <ZTwWse0COE3w6_US@boqun-archlinux>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/27/23 21:59, Boqun Feng wrote:
> On Thu, Oct 26, 2023 at 09:10:46AM +0900, FUJITA Tomonori wrote:
> [...]
>> +    /// Gets the current link state.
>> +    ///
>> +    /// It returns true if the link is up.
>> +    pub fn is_link_up(&self) -> bool {
>> +        const LINK_IS_UP: u32 =3D 1;
>> +        // SAFETY: `phydev` is pointing to a valid object by the type i=
nvariant of `Self`.
>> +        let phydev =3D unsafe { *self.0.get() };
>=20
> Tomo, FWIW, the above line means *copying* the content pointed by
> `self.0.get()` into `phydev`, i.e. `phydev` is the semantically a copy
> of the `phy_device` instead of an alias. In C code, it means you did:

Good catch. `phy_device` is rather large (did not look at the exact
size) and this will not be optimized on debug builds, so it could lead
to stackoverflows.

> =09struct phy_device phydev =3D *ptr;
>=20
> Sure, both compilers can figure this out, therefore no extra copy is
> done, but still it's better to avoid this copy semantics by doing:
>=20
> =09let phydev =3D unsafe { &*self.0.get() };

We need to be careful here, since doing this creates a reference
`&bindings::phy_device` which asserts that it is immutable. That is not
the case, since the C side might change it at any point (this is the
reason we wrap things in `Opaque`, since that allows mutatation even
through sharde references).

I did not notice this before, but this means we cannot use the `link`
function from bindgen, since that takes `&self`. We would need a
function that takes `*const Self` instead.

--=20
Cheers,
Benno


