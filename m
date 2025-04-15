Return-Path: <netdev+bounces-182954-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABB05A8A6EC
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 20:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D52F3B3C72
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 18:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28147227E88;
	Tue, 15 Apr 2025 18:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iGOIK7Kc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039C022686F
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 18:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744742330; cv=none; b=jC4sq6ploASG/bWn3N8P1M+ZTtJmHmfsymtdN2TjZEc09agSGR63D49PesuQ0pl0wNN+6qWVT2Z1mhyFPXMJRzY0xoBBA1WVdDg4gC42m/oS2MjEAgzR1ywKt1yyUDSpMMYRL2OQGo+n8BHA5v0+NmIE/hZNwi6RIGAcMAI+Vzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744742330; c=relaxed/simple;
	bh=KXYG3aLp4qNjOAqZH+1CN+KW/wpjTnPGV8mc8o/xZZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hPVJB+wG7IgRpiKcU56pSGGwHFDimJEW5lAMxADfdlcdIYs+9dSmrttFOugetvwaQCLlQOfL1lR6HMpRvbzStWEvgbWHRkCR0ZbrZF/YNaH7V0adLYBgmPgF6Gq5sLLyWii93cQPC13fTMv7Vp9D1OyIXXAKXAZPrOJ/6Ju0XpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iGOIK7Kc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5E24C4CEE9;
	Tue, 15 Apr 2025 18:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744742329;
	bh=KXYG3aLp4qNjOAqZH+1CN+KW/wpjTnPGV8mc8o/xZZQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iGOIK7KcOi2l66QEhR2CkOzSYZqOcJt7x3VuMtYbujKpQaLOPsM254tlBIdARSTRc
	 zMAEjYJO3s+tatB0oeYYm/o6ZxGwCcyR9GRQmNF7+C+gdST2dKMmD4c1k+go5juLwQ
	 pdMWtyYuw5zD93zArEvfsnSTPiMxNlfbV/kz24u3Y5st7MIpoMM1f6Ud/lzBhhA2HZ
	 21DodljzAVaLObVdf1VN5/vR+Zt2KLVmlsRED649hYPGHo4/ohmCG9mmbqPFr81OT5
	 sZGDQaEmdGWfWR/QJ2pOgQnpjN0VvbSIGklubJABBv6oV2ymkpW8pg/Ehs2T5uI920
	 Dfds8yC0xRClA==
Date: Tue, 15 Apr 2025 19:38:45 +0100
From: Simon Horman <horms@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
	kuba@kernel.org, kuni1840@gmail.com, netdev@vger.kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH v2 net-next 10/14] ipv6: Factorise
 ip6_route_multipath_add().
Message-ID: <20250415183845.GE395307@horms.kernel.org>
References: <20250414145226.GS395307@horms.kernel.org>
 <20250414180731.26130-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250414180731.26130-1-kuniyu@amazon.com>

On Mon, Apr 14, 2025 at 11:06:58AM -0700, Kuniyuki Iwashima wrote:
> From: Simon Horman <horms@kernel.org>
> Date: Mon, 14 Apr 2025 15:52:26 +0100
> > On Fri, Apr 11, 2025 at 12:33:46PM -0700, Kuniyuki Iwashima wrote:
> > > From: Simon Horman <horms@kernel.org>
> > > Date: Fri, 11 Apr 2025 11:34:04 +0100

...

> > > > Hi Kuniyuki-san,
> > > > 
> > > > Perhaps it can't happen in practice,
> > > 
> > > Yes, it never happens by patch 1 as rtm_to_fib6_multipath_config()
> > > returns an error in such a case.
> > > 
> > > 
> > > > but if the loop above iterates zero
> > > > times then err will be used uninitialised. As it's expected that err is 0
> > > > here, perhaps it would be simplest to just:
> > > > 
> > > > 	return 0;
> > > 
> > > If we want to return 0 above, we need to duplicate list_splice() at
> > > err: and return err; there.  Or initialise err = 0, but this looks
> > > worse to me.
> > 
> > Thanks. I should have dug a bit deeper to determine that this
> > is a false-positive.
> > 
> > > Btw, was this caught by Smatch, Coverity, or something ?  I don't
> > > see such a report at CI.
> > > https://patchwork.kernel.org/project/netdevbpf/patch/20250409011243.26195-11-kuniyu@amazon.com/
> > 
> > Sorry for not mentioning that it was flagged by Smatch,
> > I certainly should have done so.
> 
> Thanks for confirming!
> 
> > 
> > 
> > > 
> > > If so, I'm just curious if we have an official guideline for
> > > false-positives flagged by such tools, like we should care about it
> > > while writing a code and should try to be safer to make it happy.
> > > 
> > > We are also running Coverity for the mainline kernel and have tons
> > > of false-positive reports due to lack of contexts.
> > 
> > I think that the current non-guideline is that we don't change
> > code just to keep the tools happy. Perhaps we should add something
> > about that to the process document?
> 
> Makes sense.
> 
> But looks like the series was marked Changes Requested, not sure
> if it's accidental or intentional, so I'll resend v2 to see others'
> opinion.

I'm not sure either.
But I agree that a v2 is a good way forward.

