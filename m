Return-Path: <netdev+bounces-172109-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4437DA50424
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 17:08:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4D70173F66
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 16:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CADB3250C1C;
	Wed,  5 Mar 2025 16:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bfq2xiVe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCC024DFEB;
	Wed,  5 Mar 2025 16:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741190861; cv=none; b=arb/X1sey+A6/8cjxXfiqrtNd6axZBmU7sfGnF9nfNywydpNswDorhdSeGs2pwOM39oTh32Jny+ZmT5zm2fBs1Wqo5SzFC30AxZGNOPSwfgztTKo2Y5SE2F38x0OgbFzyF0vbrcCsrMasjydckQUMCm9h9eC5lNjZFbl7q+dZDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741190861; c=relaxed/simple;
	bh=emBW38wWtDL/t2xJoZdgV8JTXN56OwGFKlh27l9aGHg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=THcbNxCXnP7JwmJzVJixMsplRk1kjRJ7zrV1VLRiLF/A6+MAI/jLwbFYl6/CsGijY7BZDGEqqNfG34ihSYetSnCiG8BS7CSdQkxtd8PybnDIIfAUHyPNJjc38dfj1azon+9Qf+9QKvhI0S3pNYx3CPjChu+qBsBFOvT9hFw2JMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bfq2xiVe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B221BC4CED1;
	Wed,  5 Mar 2025 16:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741190861;
	bh=emBW38wWtDL/t2xJoZdgV8JTXN56OwGFKlh27l9aGHg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bfq2xiVe8OQHXcskcir/pjBGyzpCZQNetxsz5dMM3oBLLsjgAu5JYtPKrtg1m9J1b
	 9Okk3CRnWshYAWjyd1mnjrLDOk2xztioeOvMTupmshxo9gLjGG6klenyr6c4/QQqJa
	 8VAUPU22pxxpRxEDh+7zzjXZChNjY+nS+he5OAHV6aulgaQMP6cakvTsloWl6Bv8C4
	 tfjfiNu9YyayDm0f2E9miOE3opilc8lwV7LoNMdD5EPHfo0r5GtVlrvL0G6WPB1jUa
	 RlJ/5e/AF6ZVsQvHI/t8nsquVt+2MCotm29rVjHgnpudp6qMbbxazesTKMtuZt0asd
	 ZEeKdXhLEKDBA==
Date: Wed, 5 Mar 2025 08:07:40 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Amerigo Wang <amwang@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH net] netpoll: guard __netpoll_send_skb() with RCU read
 lock
Message-ID: <20250305080740.68749058@kernel.org>
In-Reply-To: <20250305-tamarin-of-amusing-luck-b9c84f@leitao>
References: <20250303-netpoll_rcu_v2-v1-1-6b34d8a01fa2@debian.org>
	<20250304174732.2a1f2cb5@kernel.org>
	<20250305-tamarin-of-amusing-luck-b9c84f@leitao>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 5 Mar 2025 01:09:49 -0800 Breno Leitao wrote:
> On Tue, Mar 04, 2025 at 05:47:32PM -0800, Jakub Kicinski wrote:
> > On Mon, 03 Mar 2025 03:44:12 -0800 Breno Leitao wrote:  
> > > +	guard(rcu)();  
> > 
> > Scoped guards if you have to.
> > Preferably just lock/unlock like a normal person..  
> 
> Sure, I thought that we would be moving to scoped guards all across the
> board, at least that was my reading for a similar patch I sent a while
> ago:
> 
> 	https://lore.kernel.org/all/20250224123016.GA17456@noisy.programming.kicks-ass.net/
> 
> Anyway, in which case should I use scoped guard instead 

We are certainly not moving to guards in networking. Too C++-sy.
Just lock / unlock please, correctly around the variable you actually
intend to protect.

Quoting documentation:

  Using device-managed and cleanup.h constructs
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  
  Netdev remains skeptical about promises of all "auto-cleanup" APIs,
  including even ``devm_`` helpers, historically. They are not the preferred
  style of implementation, merely an acceptable one.
  
  Use of ``guard()`` is discouraged within any function longer than 20 lines,
  ``scoped_guard()`` is considered more readable. Using normal lock/unlock is
  still (weakly) preferred.
  
  Low level cleanup constructs (such as ``__free()``) can be used when building
  APIs and helpers, especially scoped iterators. However, direct use of
  ``__free()`` within networking core and drivers is discouraged.
  Similar guidance applies to declaring variables mid-function.
  
See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#using-device-managed-and-cleanup-h-constructs

