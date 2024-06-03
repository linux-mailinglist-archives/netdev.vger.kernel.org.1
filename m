Return-Path: <netdev+bounces-100199-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA6C28D81F3
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 14:10:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71D591F26006
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 12:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 310D812836D;
	Mon,  3 Jun 2024 12:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Xa5L2wLU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Lboy+w6n"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6AD0128360
	for <netdev@vger.kernel.org>; Mon,  3 Jun 2024 12:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717416648; cv=none; b=D0Fz3zHyKdeU4iXjE8aJr4aMcqxdPoB+2aHlVSorAxhvbPUQZYHKgQNmPzthc24IwBM4+fhtqr29WxhzCo9PeQuqDP/qSrUba99rY9jlyTvdXQzpTa84UMl52NFerQBP7kQXOKyhK3LRpnDHaV6dtd6DJekF1T38BEEgTNmccn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717416648; c=relaxed/simple;
	bh=ujwzAD2dpUbLOunIZAP0y/gmi9pLWnsgsF5kV9hgrhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JQpzVtSoB0p8UkSzlTQfIfkdljXsBxO7kRx8D7QBLCWgqkh2Cjn4Caq1FrwKwnNckD3LICKzCRPKBNI1kstLvsQhDtmnh5fgNF0Cg1zRyAK4h3dkU1K7DDzK8RMZRzTivJY7Q1glMsAS6gppDjHCP7AHKwg8vaNevvRP3tkb0WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Xa5L2wLU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Lboy+w6n; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 3 Jun 2024 14:10:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717416644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jBBPhIc+pcmGd1ZFfwW5szBVa3ojItcGOkxYDM7x/iQ=;
	b=Xa5L2wLUkW5kKtUjp/Iuwm6sjiJ9GF8WTtHYQ1R1ySkfllk+SHDL7B3JL/9t4KOYYPiPOd
	Oa+XT8MOaiCV+PZzenl5yzhebAO2eote0B4gPnKPcVcGm9O2obk5GJcSl3N/T4H7SjkCnp
	nPTPywvnIIhsB2vlBAwI0YR5k+e9mB3G3b/RZlwsBPTb91FuwE5Kya0pbmFtJfw4zZWOph
	y2pGkCBPN+dVeu9Ve3yQsTjFrHDbwklaJnYZvtJpPA/pEKevG/NmlaGyrM3PJQzaFbt0eD
	y363KBJv/W78bGmJGUsFcCbo9rvFB38mRD23suQpqN2bx5ppMKtvVdEzUNzSdA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717416644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jBBPhIc+pcmGd1ZFfwW5szBVa3ojItcGOkxYDM7x/iQ=;
	b=Lboy+w6nKYy1A/73l6cWi7PHNQYoIpk8++xAV/0p7PQBVNHV1+akwFjitGPo6Luq9jwkL0
	l13mYWPjjkXE9MBw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Florian Westphal <fw@strlen.de>
Cc: Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, mleitner@redhat.com,
	juri.lelli@redhat.com, vschneid@redhat.com, tglozar@redhat.com,
	dsahern@kernel.org, tglx@linutronix.de
Subject: Re: [PATCH net-next v6 1/3] net: tcp/dcpp: prepare for tw_timer
 un-pinning
Message-ID: <20240603121043.4LIAz2Hm@linutronix.de>
References: <20240603093625.4055-1-fw@strlen.de>
 <20240603093625.4055-2-fw@strlen.de>
 <CANn89i+Zp=_F0tHTgQKuk1+5MV8MU+N=JV35vSTwKLFmi_5dNg@mail.gmail.com>
 <20240603112152.GB8496@breakpoint.cc>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240603112152.GB8496@breakpoint.cc>

On 2024-06-03 13:21:52 [+0200], Florian Westphal wrote:
> Theoretically the tw socket can be unlinked from the tw hash already
> (inet_twsk_purge won't encounter it), but timer is still running.
> 
> Only solution I see is to schedule() in tcp_sk_exit_batch() until
> tw_refcount has dropped to the expected value, i.e. something like
> 
> static void tcp_wait_for_tw_timers(struct net *n)
> {
> 	while (refcount_read(&n->ipv4.tcp_death_row.tw_refcount) > 1))
> 		schedule();
> }
> 
> Any better idea?

I need to read the thread but from the context, couldn't you
- grab a refcount
- timer_shutdown_sync() on it
?

Sebastian

