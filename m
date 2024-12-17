Return-Path: <netdev+bounces-152647-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E8759F4FDD
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 16:46:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4B24188CAA4
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 15:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 479971F8AEC;
	Tue, 17 Dec 2024 15:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J7rxIs3p"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDDF1F8AE4;
	Tue, 17 Dec 2024 15:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734450242; cv=none; b=rNrUzHwDJP160gCeQ8OSmYSSwUlWt6XK1hN3fuKswytzBRi9o8Vqj7H6VsZgyhiE/jDM0CkeuQRVuitt+nWAyFykcLYjiuqZFb+VnUXmaoht6n22UImzv0alUBnTvPQSWWVHxEQici4JYMixvzf4t5bRrn6oN6MjXTJXxj1P0XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734450242; c=relaxed/simple;
	bh=Rpjil9Mg5b6vhNFv4W6hMJCdoyfdY2ZYQVd4kz3jn5g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tu1KdAMz3kHM/SWGZlvgXzFqOMqlJtm8yxTRv7fQepl2wFHGT4PaPW+LT+n9WL1oiGkjdB/+iYgJml4m5Mwheic8M9K+aHOETToVO/7/bjenRM4rbZeAVEgYBPbV/CkYpqWevPtRie5aOpKlmCe5rPIn+70eUMqEoWYzidgcCn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J7rxIs3p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F05E4C4CED6;
	Tue, 17 Dec 2024 15:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734450241;
	bh=Rpjil9Mg5b6vhNFv4W6hMJCdoyfdY2ZYQVd4kz3jn5g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=J7rxIs3pfyB3Hphd+Tw45umF5KsD0/796HErDiPhcb+o50uL2slndnqVfKlx+8cB7
	 TEkjNSKbz3JONAYNJcEah2K0qCFsFzArW0IH3lDSUGFE0RyrDpW04HB73JmFF8wwip
	 TEVBlZi5cEnUEkln/RLXuQvi6m9KgQnemaEiVPHdMZ2/VPRVZSt6vTSGXTt9WsWz4q
	 x2rKo2QN/ySDiTaDLCOj1Ct1NnErrK+PlgvVjgsD7d2s43gxKTIp997YS5TXRsku6b
	 bMuSUG1m7OnLWW6Ep+cEO6AcGkAxWCWJ51ZzpRnQuzmQs1Zm0sWPcHrLe19Dd3Jjjt
	 GwSAV4P9gQ/Hw==
Date: Tue, 17 Dec 2024 07:44:00 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, davem@davemloft.net,
 edumazet@google.com, rust-for-linux@vger.kernel.org, andrew@lunn.ch,
 hkallweit1@gmail.com, tmgross@umich.edu, aliceryhl@google.com,
 boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
 benno.lossin@proton.me, a.hindborg@kernel.org, ojeda@kernel.org,
 alex.gaynor@gmail.com, netdev@vger.kernel.org
Subject: Re: [PATCH net v2] rust: net::phy fix module autoloading
Message-ID: <20241217074400.13c21e22@kernel.org>
In-Reply-To: <b701482d-760a-437b-b3fb-915dc3fc2296@redhat.com>
References: <20241212130015.238863-1-fujita.tomonori@gmail.com>
	<778db676-9719-4139-a9e3-8b64ffa87fd2@redhat.com>
	<20241217065439.25e383fe@kernel.org>
	<b701482d-760a-437b-b3fb-915dc3fc2296@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Dec 2024 16:11:29 +0100 Paolo Abeni wrote:
> On 12/17/24 15:54, Jakub Kicinski wrote:
> > On Tue, 17 Dec 2024 09:54:11 +0100 Paolo Abeni wrote:  
> >> @Jakub: I still can't reproduce the nipa (rust) build failures locally.  
> > 
> > I'll look into it. Just in case you already investigated the same thing
> > I would - have you tried the rust build script from NIPA or just to
> > build manually?   
> 
> I tried both (I changed the build dir in the script to fit my setup). I
> could not see the failure in any case - on top of RHEL 9.

I think I figured it out, you must have old clang. On Fedora 41
CFI_CLANG defaults to y and prevents RUST from getting enabled.

