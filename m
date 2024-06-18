Return-Path: <netdev+bounces-104609-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F9FA90D9F6
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 18:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CBB6B2C4AC
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 16:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23CBF143C4D;
	Tue, 18 Jun 2024 16:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yf6HOU8I"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB7B4DA0C;
	Tue, 18 Jun 2024 16:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718727436; cv=none; b=eNSn78icOM5DSAjTVuHz4UMa6gRuSq75af4ohJEvZUFtx42aHdNxdr3e7IMHzY6dp0TEEdW8a1rRE3otSV6WajthmpCRYYRRslTDSk7FbMvwPdeCJPBM+pO8Nz0o6XqZMh+L4IxQ992jdb1j+hle9zOney6DLwU44CC6Xdg7F8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718727436; c=relaxed/simple;
	bh=J8CJg3AQX6/+YCMM4VPINTXSUq4309ev+F5vJuFFj4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KDTkpByxgHC9RGkDu2xg7xkuIWN52YojrhzEIiVK7UBlTUFW/2e1H0ugTWbX+CtHXUAhF4NODF9NRWIFy4ml0fGsNI6Z288S+wyIUynPu9ADVR3umQY9qrYv6kiFIj+F6Dg3S6sxZKzKhowLtnN18PlVgEONiMeVe7C2p2um348=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yf6HOU8I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DC0AC3277B;
	Tue, 18 Jun 2024 16:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718727435;
	bh=J8CJg3AQX6/+YCMM4VPINTXSUq4309ev+F5vJuFFj4c=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=Yf6HOU8IlMW3bD0MaM/hC7BYy/LaSdzLASP0RGrZA2aMsc7ZWivuz/fvXReJidzlK
	 4rNwMHSsLLfCZzy1cRDnJyKlnw2gIgkSZSmDkTVnT2mRDBJ/8DMZO0fJTtoqhza4be
	 GWCYhXALsi/9vp356LOL4Q7L6jaSg2sFk6A266lOKjp3A6O/OMmjiZYyEJ9TrsScRZ
	 EHFj4GZAPcxGJ8qaS65NqLhLvON5+DaqHUMjtz84htRVdViis17eVnK2NFdqTOJgL4
	 2JtErY8e3iurCtVGRVTr7XvUJNQVeWtmTAwZivnefa/VB6UDF62HYGPLunSyRXs8Qj
	 48xuHiwJ/v8gg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 34CB2CE04AF; Tue, 18 Jun 2024 09:17:15 -0700 (PDT)
Date: Tue, 18 Jun 2024 09:17:15 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Dmitry Safonov <0x7f454c46@gmail.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	rcu@vger.kernel.org
Subject: Re: [TEST] TCP MD5 vs kmemleak
Message-ID: <ccd20867-1688-40f3-a5f4-b5c5ac50719a@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240617072451.1403e1d2@kernel.org>
 <CAJwJo6ZjhLLSiBUntdGT8a6-d5pjdXyVv9AAQ3Yx1W01Nq=dwg@mail.gmail.com>
 <20240618074037.66789717@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618074037.66789717@kernel.org>

On Tue, Jun 18, 2024 at 07:40:37AM -0700, Jakub Kicinski wrote:
> On Tue, 18 Jun 2024 04:24:08 +0100 Dmitry Safonov wrote:
> > Hi Jakub,
> > 
> > thanks for pinging,
> > 
> > On Mon, 17 Jun 2024 at 15:24, Jakub Kicinski <kuba@kernel.org> wrote:
> > >
> > > Hi Dmitry!
> > >
> > > We added kmemleak checks to the selftest runners, TCP AO/MD5 tests seem
> > > to trip it:
> > >
> > > https://netdev-3.bots.linux.dev/vmksft-tcp-ao-dbg/results/643761/4-unsigned-md5-ipv6/stdout
> > >
> > > Could you take a look? kmemleak is not infallible, it could be a false
> > > positive.  
> > 
> > Sure, that seems somewhat interesting, albeit at this moment not from
> > the TCP side :D
> > 
> > There is some pre-history to the related issue here:
> > https://lore.kernel.org/lkml/0000000000004d83170605e16003@google.com/
> > 
> > Which I was quite sure being addressed with what now is
> > https://git.kernel.org/linus/5f98fd034ca6
> > 
> > But now that I look at that commit, I see that kvfree_call_rcu() is
> > defined to __kvfree_call_rcu() under CONFIG_KASAN_GENERIC=n. And I
> > don't see the same kmemleak_ignore() on that path.
> > 
> > To double-check, you don't have kasan enabled on netdev runners, right?
> 
> We do:
> 
> CONFIG_KASAN=y
> CONFIG_KASAN_GENERIC=y
> 
> here's the full config:
> https://netdev-3.bots.linux.dev/vmksft-tcp-ao-dbg/results/645202/config
> 
> > And then straight away to another thought: the leak-report that you
> > get currently is ao_info, which should not happen if kfree_rcu() is
> > properly fixed.
> > But I'd expect kmemleak to be unhappy with ao keys freeing as well:
> > they are currently released with call_rcu(&key->rcu,
> > tcp_ao_key_free_rcu), which doesn't have a hint for kmemleak, too.
> > 
> > I'm going to take a look at it this week. Just to let you know, I'm
> > also looking at fixing those somewhat rare flakes on tcp-ao counters
> > checks (but that may be net-next material together with tracepoint
> > selftests).
> 
> Let me add rcu@ to CC, perhaps folks there can guide us on known false
> positives with KASAN + kmemleak?

I myself don't run KASAN with kmemleak, but maybe some of the others
on this list do.

What sort of hint should be we add to call_rcu()?  The memory is still
reachable in the garbage-collector sense.

							Thanx, Paul

