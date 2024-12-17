Return-Path: <netdev+bounces-152659-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C15949F5168
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 17:51:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDE9616865F
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 16:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F4971F755F;
	Tue, 17 Dec 2024 16:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EN7e+VZp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3587A1F63F5;
	Tue, 17 Dec 2024 16:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734454287; cv=none; b=PrAdTVSl0KHy6aCkp3Xe0oWi3hqXU/xEfh53d7aw2vJj9t3AT/Gj9IiwMuUx60YMJGDb6jAC3imVIaxCS2Xu/O1V4LFQKGWjMbJ0jvz7ibSCdJmC6IMcnMo19bTlEIQjvWeN4a/15WxOTfpaKvP0YGDWKd169lub5B/hYigAryo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734454287; c=relaxed/simple;
	bh=qZFpOgP5/6spM96WI2xB2e2pOfMi+pkng5CKvSLZhM8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OxXYNgIGKBEVJdd3GB7uG3iU5GtsnP1bAw+5UhGzM6r023egUiUNZs8Juzpt+q3qTAArNCWM5mY8JdGtokJYDsEjgt+fYPSwaA6Pyyi3u5g26GrNFswPbRf77TAJpdmZ/sG3W1+PtfFFtKOpknqWdnq4m/3k3m+2GYfyah6carE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EN7e+VZp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D0FDC4CED7;
	Tue, 17 Dec 2024 16:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734454286;
	bh=qZFpOgP5/6spM96WI2xB2e2pOfMi+pkng5CKvSLZhM8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EN7e+VZp2/39muEltrzuvD31GKVQJr5MSH/QpjbQIOoi+46PFSL2Vq7jcPf5XvtXD
	 ORz1YYM5YBw4YmotdfR4aJAl+pp+HnV8QXh+6CXfbp+wCJuWwT3mO3xQMIZWmvQ+R2
	 h/Hd7Fk9/4x8OG7GVKWwpUI5RvVn8cChUpsKKtTZtxzo9hzDUZlOWH6D7QCG3+kQBw
	 kYD4uyxZMK90TyLY74fEt1xC3iBXqDWpN18TSMzXMc/3V4IMoTC9WuqZfnKMODnF0P
	 BLj9FuZIc42h8h5/B7Mk44uPzgN1i3TY/EeNaA9OdySS5X6dEkFx8EFsuSCxONY5jC
	 JD16bHV6LXTTA==
Date: Tue, 17 Dec 2024 08:51:24 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, davem@davemloft.net,
 edumazet@google.com, rust-for-linux@vger.kernel.org, andrew@lunn.ch,
 hkallweit1@gmail.com, tmgross@umich.edu, aliceryhl@google.com,
 boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
 benno.lossin@proton.me, a.hindborg@kernel.org, ojeda@kernel.org,
 alex.gaynor@gmail.com, netdev@vger.kernel.org
Subject: Re: [PATCH net v2] rust: net::phy fix module autoloading
Message-ID: <20241217085124.761566e6@kernel.org>
In-Reply-To: <20241217074400.13c21e22@kernel.org>
References: <20241212130015.238863-1-fujita.tomonori@gmail.com>
	<778db676-9719-4139-a9e3-8b64ffa87fd2@redhat.com>
	<20241217065439.25e383fe@kernel.org>
	<b701482d-760a-437b-b3fb-915dc3fc2296@redhat.com>
	<20241217074400.13c21e22@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Dec 2024 07:44:00 -0800 Jakub Kicinski wrote:
> On Tue, 17 Dec 2024 16:11:29 +0100 Paolo Abeni wrote:
> > > I'll look into it. Just in case you already investigated the same thing
> > > I would - have you tried the rust build script from NIPA or just to
> > > build manually?     
> > 
> > I tried both (I changed the build dir in the script to fit my setup). I
> > could not see the failure in any case - on top of RHEL 9.  
> 
> I think I figured it out, you must have old clang. On Fedora 41
> CFI_CLANG defaults to y and prevents RUST from getting enabled.

Still hitting a problem in module signing. 
Rust folks does this ring a bell?

make[4]: *** Deleting file 'certs/signing_key.pem'
  GENKEY  certs/signing_key.pem
....+.........+++++
-----
80728E46C07F0000:error:03000098:digital envelope routines:do_sigver_init:invalid digest:crypto/evp/m_sigver.c:342:
make[4]: *** [../certs/Makefile:53: certs/signing_key.pem] Error 1
make[4]: *** Waiting for unfinished jobs....

allmodconfig without Rust builds fine with both GCC and clang.

build flags: LLVM=1
config: https://paste.centos.org/view/0555e9dd
OS: Fedora 41

