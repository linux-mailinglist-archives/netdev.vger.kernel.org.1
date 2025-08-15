Return-Path: <netdev+bounces-214096-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33D0AB2842D
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 18:47:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C18B81B62638
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 16:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 096CF30F805;
	Fri, 15 Aug 2025 16:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VzNG3Efl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D492D30EF69;
	Fri, 15 Aug 2025 16:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755276138; cv=none; b=qVupQk88FT584R8t9zZkBEVv6Mt1hnQpo5imSjVJ6Eit/7cVsN0zfmsjSgO9ODZCSGO9u/QDs2Nl7cahF+s156ur/7lZuwSC2nwxRhFIVggLS/CYm5ggu8WWzmuKw8KmVxwGp5ep3+WagSC4FRWgeAY11YS7QIurwzE8C85Ku5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755276138; c=relaxed/simple;
	bh=fFth/dz/MaNpJqkuv1JoCoVaICV+R6UfG3yK1b1QAHA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dt7p3Or0UbZ/P73T8Mugydg7tD3+bn0dcVKY3+6+Ae3ayKU7apG1XqbdzuDmIUjLjp5C1XF5lwIv7Yl8Ul6CAF2em+quNZC9sljYW5jRHH+hf6XLZVLf7uBnB+49crVRUr/zPnh4g8B7LOGU7r3dzHtHlrRU61mCFC6l+NC3eiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VzNG3Efl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68FD9C4CEEB;
	Fri, 15 Aug 2025 16:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755276138;
	bh=fFth/dz/MaNpJqkuv1JoCoVaICV+R6UfG3yK1b1QAHA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VzNG3EflMcW2o9zwQ7oJFDSUEp/gVswaz1p8izpCC9cdOgEuaSgQayPE1w1GhedT0
	 z+DyL27MN8mmNm8qP5ayhN4HVFHJDk+t+nn5ljXJg5KukzuDBpbRE6OUD3tUIE5SST
	 r14DZ0P8Q+r5jiRuxAyizW/ePGZX5hhSrRaUpYzI2TB/IGzs+Ikr0l4JGCxtOYfwaN
	 YUNAqpU6ZdoEdWeB7BnFKCIRziE0F2PA/9DlijOMbeRVPRmrSvKAYdIGYU82A2Bg8q
	 6EyGcv+tqn/QvvDNECg/3T9DLi/gLUWdvisTmnQbu0BfpcUZRQA2vW9Fn6fMlP94eG
	 g4+gB0C0m1uPg==
Date: Fri, 15 Aug 2025 09:42:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Pavel Begunkov <asml.silence@gmail.com>, Johannes Berg
 <johannes@sipsolutions.net>
Cc: Breno Leitao <leitao@debian.org>, Mike Galbraith <efault@gmx.de>,
 paulmck@kernel.org, LKML <linux-kernel@vger.kernel.org>,
 netdev@vger.kernel.org, boqun.feng@gmail.com
Subject: Re: netconsole: HARDIRQ-safe -> HARDIRQ-unsafe lock order warning
Message-ID: <20250815094217.1cce7116@kernel.org>
In-Reply-To: <3d20ce1b-7a9b-4545-a4a9-23822b675e0c@gmail.com>
References: <fb38cfe5153fd67f540e6e8aff814c60b7129480.camel@gmx.de>
	<oth5t27z6acp7qxut7u45ekyil7djirg2ny3bnsvnzeqasavxb@nhwdxahvcosh>
	<20250814172326.18cf2d72@kernel.org>
	<3d20ce1b-7a9b-4545-a4a9-23822b675e0c@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 Aug 2025 11:44:45 +0100 Pavel Begunkov wrote:
> On 8/15/25 01:23, Jakub Kicinski wrote:
> > On Thu, 14 Aug 2025 03:16:11 -0700 Breno Leitao wrote:  
> >>   2.2) netpoll 				// net poll will call the network subsystem to send the packet
> >>   2.3) lock(&fq->lock);			// Try to get the lock while the lock was already held  
> 
> The report for reference:
> 
> https://lore.kernel.org/all/fb38cfe5153fd67f540e6e8aff814c60b7129480.camel@gmx.de/> 
> > Where does netpoll take fq->lock ?  
> 
> the dependencies between the lock to be acquired
> [  107.985514]  and HARDIRQ-irq-unsafe lock:
> [  107.985531] -> (&fq->lock){+.-.}-{3:3} {
> ...
> [  107.988053]  ... acquired at:
> [  107.988054]    check_prev_add+0xfb/0xca0
> [  107.988058]    validate_chain+0x48c/0x530
> [  107.988061]    __lock_acquire+0x550/0xbc0
> [  107.988064]    lock_acquire.part.0+0xa1/0x210
> [  107.988068]    _raw_spin_lock_bh+0x38/0x50
> [  107.988070]    ieee80211_queue_skb+0xfd/0x350 [mac80211]
> [  107.988198]    __ieee80211_xmit_fast+0x202/0x360 [mac80211]
> [  107.988314]    ieee80211_xmit_fast+0xfb/0x1f0 [mac80211]
> [  107.988424]    __ieee80211_subif_start_xmit+0x14e/0x3d0 [mac80211]
> [  107.988530]    ieee80211_subif_start_xmit+0x46/0x230 [mac80211]

Ah, that's WiFi's stack queuing. Dunno whether we expect netpoll to 
work over WiFi. I suspect disabling netconsole over WiFi may be the 
most sensible way out. Johannes, do you expect mac80211 Tx to be IRQ-safe?

