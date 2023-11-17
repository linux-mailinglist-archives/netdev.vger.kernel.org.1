Return-Path: <netdev+bounces-48851-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2DE87EFBFB
	for <lists+netdev@lfdr.de>; Sat, 18 Nov 2023 00:02:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94908281346
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 23:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ABE13C495;
	Fri, 17 Nov 2023 23:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="bkFXJPiL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3EB6D7A
	for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 15:02:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1700262136; x=1700521336;
	bh=QpLVWMWs/2zmybTKrpIy5utNGzrfobxSGTUacwigwjU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=bkFXJPiLiOv/UgV6PC4rATOWwxNCna+cnPvLo6tW1e86o1SY/hewxpf7OiPRSG7Ud
	 92mW5QZhonBYFQZatAtDMQ62sxx5MvGPypylzv4xThAOs2rir9gdEfOUOw9BYpdz34
	 PxZKQT4ENOP1qyH5qiGdFRPpF46+nMRKc/s4BZDbH8ZSk3Rck+PGitIfaK/kIPVgon
	 j2JeoXa1DXzuyYvmBe4tBwG/HhLHD5sRqJcGuvc12EEr2WxnYh6X8O1rzVQykoi7k1
	 2Xjxjo6oqL3/TZzLcMnHfulQZUZ5LEGuGwUW1SOxcLuBvOXfUqrkZwTzT0qb+7efrf
	 byCikftZ0amRw==
Date: Fri, 17 Nov 2023 23:01:58 +0000
To: Andrew Lunn <andrew@lunn.ch>, Boqun Feng <boqun.feng@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, tmgross@umich.edu, miguel.ojeda.sandonis@gmail.com, wedsonaf@gmail.com
Subject: Re: [PATCH net-next v7 2/5] rust: net::phy add module_phy_driver macro
Message-ID: <7f300ba1-44e1-4a98-9289-a53928204aa7@proton.me>
In-Reply-To: <66455d50-9a3c-4b5c-ba2c-5188dae247a9@lunn.ch>
References: <20231026001050.1720612-1-fujita.tomonori@gmail.com> <20231026001050.1720612-3-fujita.tomonori@gmail.com> <ZVfncj5R9-8aU7vB@boqun-archlinux> <66455d50-9a3c-4b5c-ba2c-5188dae247a9@lunn.ch>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/17/23 23:54, Andrew Lunn wrote:
> Each kernel module should be in its own symbol name space. The only
> symbols which are visible outside of the module are those exported
> using EXPORT_SYMBOL_GPL() or EXPORT_SYMBOL(). A PHY driver does not
> export anything, in general.
>=20
> Being built in also does not change this.
>=20
> Neither drivers/net/phy/ax88796b_rust.o nor
> rust/doctests_kernel_generated.o should have exported this symbol.
>=20
> I've no idea how this actually works, i guess there are multiple
> passes through the linker? Maybe once to resolve symbols across object
> files within a module. Normal global symbols are then made local,
> leaving only those exported with EXPORT_SYMBOL_GPL() or
> EXPORT_SYMBOL()? A second pass through linker then links all the
> exported symbols thorough the kernel?

I brought this issue up in [1], but I was a bit confused by your last
reply there, as I have no idea how the `EXPORT_SYMBOL` macros work.

IIRC on the Rust side all public items are automatically GPL exported.
But `#[no_mangle]` is probably a special case, since in userspace it
is usually used to do interop with C (and therefore the symbol is always
exported with the name not mangled).

One fix would be to make the name unique by using the type name supplied
in the macro.

[1]: https://lore.kernel.org/rust-for-linux/1aea7ddb-73b7-8228-161e-e2e4ff5=
bc98d@proton.me/

--=20
Cheers,
Benno


