Return-Path: <netdev+bounces-200862-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E48FCAE720D
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 00:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48D90179267
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 22:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F7E231845;
	Tue, 24 Jun 2025 22:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nuh5cRnm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EFEB307483
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 22:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750802639; cv=none; b=Kg1TXFO+8YVIptFpmb7jheSVbwdATUZUmofOL41gCCsHiPcAnJ5j0bxY2STBBLxgEoKoWqrE6glN8HEVN2io9fk612MVIlIxYmPE1PBjuLkOC0J/HMHTZ17WD4O+/rmyGRsvKHu4E8wHPd1TDtTAmMYA4MPlOuLpfzPoKCgwW+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750802639; c=relaxed/simple;
	bh=JcyN+dOO3U86zBwgqX+VBYpD1tZR7Nr4t74Fex4Tsjo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cY0NHnE3j76MGXaDFKOpkBER2+P1fJDxFqx3IcEubDjP/GREmIr5pFXYeStIuhHBv9iV4bGjIzQEjGuOggufxiVFtLiNHqna8sQM1+6b4zJRNWG+prAbZUQGWNxg+uiHEV5pVah/LbBtOXRPhBBZOWO/ihyFuz0D5Uc2ChPZdjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nuh5cRnm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 981CFC4CEE3;
	Tue, 24 Jun 2025 22:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750802639;
	bh=JcyN+dOO3U86zBwgqX+VBYpD1tZR7Nr4t74Fex4Tsjo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Nuh5cRnm1VdyrznKyHsUBHsPi8tguTa4uGl8uUENLRK5WHFfKifDItjx3M3x3cNAT
	 DzEubywx++Y7VzkR6WtjN8sCfg+jOTRQMCsltJxhJJqt1dZIYu6qM8Jt/wAEfnxLvw
	 lEqbmFl4xsg9KIyetij1Ke15nTkyGnBaPfeCD4U+Ix2AqsNBHqifQDc0R1u5Gx7yP4
	 Hhexn353Wk3N07UQhTezJfFhb/aSMRHMkDXBqB1WEUNV4PN9oOhWM4oQ0mok2B4Eeg
	 pmr9Yiq2TaU0dJJtEtd/wBF2HjFzXbhQD8bZxcHubN6mFVZhuCsKfOKeGR75yOfaLn
	 a2h3MzRKgnmrA==
Date: Tue, 24 Jun 2025 15:03:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kuniyuki Iwashima <kuni1840@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, horms@kernel.org,
 jbaron@akamai.com, kuniyu@google.com, netdev@vger.kernel.org,
 pabeni@redhat.com
Subject: Re: [PATCH net-next v2 3/3] netlink: Fix wraparound of
 sk->sk_rmem_alloc
Message-ID: <20250624150357.247c9468@kernel.org>
In-Reply-To: <20250624170933.419907-1-kuni1840@gmail.com>
References: <20250624071157.3cbb1265@kernel.org>
	<20250624170933.419907-1-kuni1840@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 24 Jun 2025 10:08:41 -0700 Kuniyuki Iwashima wrote:
> Date: Tue, 24 Jun 2025 07:11:57 -0700
> From: Jakub Kicinski <kuba@kernel.org>
> > On Tue, 24 Jun 2025 09:55:15 +0200 Paolo Abeni wrote:  
> > > > To be clear -- are you saying we should fix this differently?
> > > > Or perhaps that the problem doesn't exist? The change doesn't
> > > > seem very intrusive..    
> > > 
> > > AFAICS the race is possible even with netlink as netlink_unicast() runs
> > > without the socket lock, too.
> > > 
> > > The point is that for UDP the scenario with multiple threads enqueuing a
> > > packet into the same socket is a critical path, optimizing for
> > > performances and allowing some memory accounting inaccuracy makes sense.
> > > 
> > > For netlink socket, that scenario looks a patological one and I think we
> > > should prefer accuracy instead of optimization.  
> > 
> > Could you ELI5 what you mean? Are you suggesting a lock around every
> > sk_rmem write for netlink sockets? 
> > If we think this is an attack vector the attacker can simply use a UDP
> > socket instead. Or do you think it'd lead to simpler code?  
> 
> I was wondering if atomic_add_return() is expensive for netlink,
> and if not, we could use it like below. 

Ah, got it. That does look simpler. 

nit: Please don't hide the atomic_add_return() in local variable init,
as it need validation and error handling.

> I'm also not sure we want to keep the allow-at-least-one-skb rule for
> netlink though, which comes from the first condition in
> __sock_queue_rcv_skb() for UDP in the past, IIRC.


