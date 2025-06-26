Return-Path: <netdev+bounces-201696-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1FE9AEA9C3
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 00:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49B6E7B4585
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 22:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB96D21B185;
	Thu, 26 Jun 2025 22:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wtrn5f+6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9663F20487E
	for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 22:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750977632; cv=none; b=ntT93IIVoPyfsEQlpVyvpJ79A/yN5U5NqJjvigteA7AmbWzGmYLgsXYVufPBKdG6sw413HNOOn1w2ZYBa3fEeoQBorfIcfHZKib72V97YY18KSj3O3L4Va6/1SUGNx6rQDLXjn6zxNRPdyt7+hyaoKih/rIBqVX4jAhhmVhXwgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750977632; c=relaxed/simple;
	bh=j7uYJ1pElujrp7N56zWS/7ITpLB4RK9IiUiH4U7WhJM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UiKXEzWNlTr8twJ3DadT9+O/M68e0YXXp31CO2YEK0sOii6lmejCCiAhUGmUss1+rNdyZRDI3fR/dzgUFvFAeVdhmce35ESkfV/1Clc2NkRVuVhwZUE2+DN5mbuenDXhdr1blvU3ByE87T2YZpNwkMzlVFYRupkqmkp5BwEMXPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wtrn5f+6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B34FCC4CEEB;
	Thu, 26 Jun 2025 22:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750977631;
	bh=j7uYJ1pElujrp7N56zWS/7ITpLB4RK9IiUiH4U7WhJM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Wtrn5f+6epUkq3UYZ+xIlR3o8KVWKThoBOhEN3thApBn6ruMmUQcsLAyEyqrUYF91
	 fyJS1LiF9COt18gxk3B+P78wG51smAhPjgC/nJq78unnC4M/awknCjkoEWdvnj7uwN
	 UuPpxeVLrJGo25QsJdVx5/aTX2037LEdHNH1heniaVYh+MQ4zacDP57RMqM5/Cieiu
	 6fpdivR5jgQau1Cpr9Z6ZgG+zBL8vlq+k6+olS2tJWXnEaPkoqmiYwC3qc00rMHk0l
	 nDbvVdUnxK9EAWlX454AgnUnkrPA9Nk85c6z+b/zKkvlVjAu+rw96Ntnnlw69xWq7w
	 vSheCqSwKewzA==
Date: Thu, 26 Jun 2025 15:40:29 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 pavan.chebbi@broadcom.com
Subject: Re: [PATCH net-next] eth: bnxt: take page size into account for
 page pool recycling rings
Message-ID: <20250626154029.22cd5d2d@kernel.org>
In-Reply-To: <CACKFLin2y=Y1s3ge8kfdi-qHGfoQr9S3BwOUCSKTCu6q8Y6D1Q@mail.gmail.com>
References: <20250626165441.4125047-1-kuba@kernel.org>
	<CACKFLin2y=Y1s3ge8kfdi-qHGfoQr9S3BwOUCSKTCu6q8Y6D1Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 26 Jun 2025 14:52:17 -0700 Michael Chan wrote:
> >  {
> > +       const unsigned int agg_size_fac = PAGE_SIZE / BNXT_RX_PAGE_SIZE;
> > +       const unsigned int rx_size_fac = PAGE_SIZE / SZ_4K;
> >         struct page_pool_params pp = { 0 };
> >         struct page_pool *pool;
> >
> > -       pp.pool_size = bp->rx_agg_ring_size;
> > +       pp.pool_size = bp->rx_agg_ring_size / agg_size_fac;  
> 
> The bp->rx_agg_ring_size has already taken the system PAGE_SIZE into
> consideration to some extent in bnxt_set_ring_params().  The
> jumbo_factor and agg_factor will be smaller when PAGE_SIZE is larger.
> Will this overcompensate?

My understanding is basically that bnxt_set_ring_params() operates
on BNXT_RX_PAGE_SIZE so it takes care of 4k .. 32k range pretty well.
But for 64k pages we will use 32k buffers, so 2 agg ring entries
per system page. If our heuristic is that we want the same number
of pages on the device ring as in the pp cache we should divide 
the cache size by two. Hope that makes sense.

My initial temptation was to say that agg ring is always shown to 
the user in 4kB units, regardless of system page. The driver would
divide and multiply the parameter in the ethtool callbacks. Otherwise
even with this patch existing configs for bnxt have to be adjusted
based on system page size :( But I suspect you may have existing users
on systems with 64kB pages, so this would be too risky? WDYT?

