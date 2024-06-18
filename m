Return-Path: <netdev+bounces-104619-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 271D090D988
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 18:42:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D457E1F2459F
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 16:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D7F74070;
	Tue, 18 Jun 2024 16:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zr0oCoMx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3275D757E5;
	Tue, 18 Jun 2024 16:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718728956; cv=none; b=JXVzeA68ot4SvFLcBJZjU1TkgoKOnQV9Hl7j9BpamzanFHv19icAzYZUH3d7tjyKdcxTKVZaGsLz0pHAYDj0TvnjeXI4jn0+aqY7UKI5t/ZsR9lYK8LOTkGMk6aOx69vbcMYDFBspjr+ZsyRKQC1WDCNG+XLHm6WPQm49PS36kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718728956; c=relaxed/simple;
	bh=mtVK6eSre9GW2gaqB4POUYzCRvUDB0j92XgonU/mZic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=avI/M9Q5VHeAscLeStoSm8TqwTTkm8Epky1H44QZGNHXGLaHE8Ti05wsHMThMVuN4LvLINA0jAPd1aNLrMefIB0E7SG57DDtmNEfYTGw6dmEnZTkQ3p5vkXcIW9vyzu/3eHEuRi9QhbBMNYdOey+xwfngUi/wnIelMdaPMCTQXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zr0oCoMx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9334BC3277B;
	Tue, 18 Jun 2024 16:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718728955;
	bh=mtVK6eSre9GW2gaqB4POUYzCRvUDB0j92XgonU/mZic=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=Zr0oCoMx8BEH/SizUXmhKsbGbH8F4KWZo7VAhfzJXKBS20iON4O3PBRguQxb1e3Mn
	 DcKadlzqZvqX0mOc+Hnsm3L0lTwOpuBWaRVnLF7HOrqTHUBwxYQ9KJZ9NZ/FU+PB7L
	 sGxcW0NmK8Y3q3OcetyX67SyhEiLV08PfRNEDtzvce521LrLKJs+EdEDN/7bOM08Vb
	 xxBt0/jqQ9SD3qzE9Ejcf6j7AYWUvznxhEkHp7URrTlndvuru2iBnA6kw5hk9ny1p9
	 tLQnAK0a5pueoKGSB00k+xkP503Ab1tj5TTxPXwYIsMibjgVHUrId7EKxF4/RtrV6R
	 50z9CjXQuCnvg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 30C3DCE05B6; Tue, 18 Jun 2024 09:42:35 -0700 (PDT)
Date: Tue, 18 Jun 2024 09:42:35 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Dmitry Safonov <0x7f454c46@gmail.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	rcu@vger.kernel.org
Subject: Re: [TEST] TCP MD5 vs kmemleak
Message-ID: <ee5a9d15-deaf-40c9-a559-bbc0f11fbe76@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240617072451.1403e1d2@kernel.org>
 <CAJwJo6ZjhLLSiBUntdGT8a6-d5pjdXyVv9AAQ3Yx1W01Nq=dwg@mail.gmail.com>
 <20240618074037.66789717@kernel.org>
 <fae8f7191d50797a435936d41f08df9c83a9d092.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fae8f7191d50797a435936d41f08df9c83a9d092.camel@redhat.com>

On Tue, Jun 18, 2024 at 06:30:59PM +0200, Paolo Abeni wrote:
> On Tue, 2024-06-18 at 07:40 -0700, Jakub Kicinski wrote:
> > On Tue, 18 Jun 2024 04:24:08 +0100 Dmitry Safonov wrote:
> > > Hi Jakub,
> > > 
> > > thanks for pinging,
> > > 
> > > On Mon, 17 Jun 2024 at 15:24, Jakub Kicinski <kuba@kernel.org> wrote:
> > > > 
> > > > Hi Dmitry!
> > > > 
> > > > We added kmemleak checks to the selftest runners, TCP AO/MD5 tests seem
> > > > to trip it:
> > > > 
> > > > https://netdev-3.bots.linux.dev/vmksft-tcp-ao-dbg/results/643761/4-unsigned-md5-ipv6/stdout
> > > > 
> > > > Could you take a look? kmemleak is not infallible, it could be a false
> > > > positive.  
> > > 
> > > Sure, that seems somewhat interesting, albeit at this moment not from
> > > the TCP side :D
> > > 
> > > There is some pre-history to the related issue here:
> > > https://lore.kernel.org/lkml/0000000000004d83170605e16003@google.com/
> > > 
> > > Which I was quite sure being addressed with what now is
> > > https://git.kernel.org/linus/5f98fd034ca6
> > > 
> > > But now that I look at that commit, I see that kvfree_call_rcu() is
> > > defined to __kvfree_call_rcu() under CONFIG_KASAN_GENERIC=n. And I
> > > don't see the same kmemleak_ignore() on that path.
> > > 
> > > To double-check, you don't have kasan enabled on netdev runners, right?
> > 
> > We do:
> > 
> > CONFIG_KASAN=y
> > CONFIG_KASAN_GENERIC=y
> > 
> > here's the full config:
> > https://netdev-3.bots.linux.dev/vmksft-tcp-ao-dbg/results/645202/config
> > 
> > > And then straight away to another thought: the leak-report that you
> > > get currently is ao_info, which should not happen if kfree_rcu() is
> > > properly fixed.
> > > But I'd expect kmemleak to be unhappy with ao keys freeing as well:
> > > they are currently released with call_rcu(&key->rcu,
> > > tcp_ao_key_free_rcu), which doesn't have a hint for kmemleak, too.
> > > 
> > > I'm going to take a look at it this week. Just to let you know, I'm
> > > also looking at fixing those somewhat rare flakes on tcp-ao counters
> > > checks (but that may be net-next material together with tracepoint
> > > selftests).
> > 
> > Let me add rcu@ to CC, perhaps folks there can guide us on known false
> > positives with KASAN + kmemleak?
> 
> FTR, with mptcp self-tests we hit a few kmemleak false positive on RCU
> freed pointers, that where addressed by to this patch:
> 
> commit 5f98fd034ca6fd1ab8c91a3488968a0e9caaabf6
> Author: Catalin Marinas <catalin.marinas@arm.com>
> Date:   Sat Sep 30 17:46:56 2023 +0000
> 
>     rcu: kmemleak: Ignore kmemleak false positives when RCU-freeing objects
> 
> I'm wondering if this is hitting something similar? Possibly due to
> lazy RCU callbacks invoked after MSECS_MIN_AGE???

Fun!  ;-)

This commit handles memory passed to kfree_rcu() and friends, but
not memory passed to call_rcu() and friends.  Of course, call_rcu()
does not necessarily know the full extent of the memory passed to it,
for example, if passed a linked list, call_rcu() will know only about
the head of that list.

There are similar challenges with synchronize_rcu() and friends.

							Thanx, Paul

