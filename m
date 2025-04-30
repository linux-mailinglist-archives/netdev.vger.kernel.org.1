Return-Path: <netdev+bounces-187115-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C225DAA4FF5
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 17:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C1371C00A8A
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 15:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF5621C5F10;
	Wed, 30 Apr 2025 15:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tbPh85mq"
X-Original-To: netdev@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A26A18CBFB
	for <netdev@vger.kernel.org>; Wed, 30 Apr 2025 15:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746026220; cv=none; b=XdHQl3Bb9SvRKOWvi4z4XisDENtaxssfRobq7kBoxti4EGqlt5c6Kk0HtGa2rdd4i134bQLx4CbSMI+Uc8Eu5pZDqdEshVPX35cNpKzYi0O7uRMGr6Cxfh3yKHM7HP0bMkIilbL2LTrmbvxW3cmus+bE/aYpvfN84kUCLrf4w1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746026220; c=relaxed/simple;
	bh=QG8bqgr3qWo8btyscx6Pg1np246S/tBDUlpyBuH76hI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WQlpRAiWHWY7/QYSSRgYcqeX1s5jdE4XJMyPNENzgWLDBhaFxFsJBVlkVlyZWm5pFQBFHFqjylbSkEUCVMBHfqJcPX/GyRTMMCkiTVM6/xZl3skFsIhIKiRzziJ6wffuI5zopi2cQL+I4Am+75bTpbaQfcIVlOeQxpdXEAjKKT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tbPh85mq; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 30 Apr 2025 08:16:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746026206;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QuMn9HO2ylHkudtJJgWW+uAsUFq7j0ybDWnjZm1chbA=;
	b=tbPh85mqFuFE68zG9wwsyzvn0w6q9QuM+tyJK8/hQ/ZBmw8hoZyObkmHYHybSvoObi4+cv
	QGRo+e36qf+yddQwfi4mYAWAiyTM3HNdl9YrzzAL4Hs0r7nwS2o1DdyRTdYMBuCIWmCZNT
	3JvPQLMoYKh/+B36R4CstLUfTjk0YDo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Soheil Hassas Yeganeh <soheil@google.com>, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Meta kernel team <kernel-team@meta.com>, Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH] memcg: multi-memcg percpu charge cache
Message-ID: <mjmayud53r2ypus22ab75c7kfaq7izaidde2bju536e2ghifdi@lslljpj2hdtm>
References: <20250416180229.2902751-1-shakeel.butt@linux.dev>
 <as5cdsm4lraxupg3t6onep2ixql72za25hvd4x334dsoyo4apr@zyzl4vkuevuv>
 <ae4b9ac8-d67d-471f-89b9-7eeaf58dd1b8@suse.cz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae4b9ac8-d67d-471f-89b9-7eeaf58dd1b8@suse.cz>
X-Migadu-Flow: FLOW_OUT

On Wed, Apr 30, 2025 at 12:05:48PM +0200, Vlastimil Babka wrote:
> On 4/25/25 22:18, Shakeel Butt wrote:
> > Hi Andrew,
> > 
> > Another fix for this patch. Basically simplification of refill_stock and
> > avoiding multiple cached entries of a memcg.
> > 
> > From 6f6f7736799ad8ca5fee48eca7b7038f6c9bb5b9 Mon Sep 17 00:00:00 2001
> > From: Shakeel Butt <shakeel.butt@linux.dev>
> > Date: Fri, 25 Apr 2025 13:10:43 -0700
> > Subject: [PATCH] memcg: multi-memcg percpu charge cache - fix 2
> > 
> > Simplify refill_stock by avoiding goto and doing the operations inline
> > and make sure the given memcg is not cached multiple times.
> > 
> > Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> 
> It seems to me you could simplify further based on how cached/nr_pages
> arrays are filled from 0 to higher index and thus if you see a NULL it means
> all higher indices are also NULL. At least I don't think there's ever a
> drain_stock() that would "punch a NULL" in the middle? When it's done in
> refill_stock() for the random index, it's immediately reused.
> 
> Of course if that invariant was made official and relied upon, it would need
> to be documented and care taken not to break it.
> 
> But then I think:
> - refill_stock() could be further simplified
> - loops in consume_stop() and is_drain_needed() could stop on first NULL
> cached[i] encountered.
> 
> WDYT?
> 

Please see below.

> > ---
> >  mm/memcontrol.c | 27 +++++++++++++++------------
> >  1 file changed, 15 insertions(+), 12 deletions(-)
> > 
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index 997e2da5d2ca..9dfdbb2fcccc 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -1907,7 +1907,8 @@ static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
> >  	struct mem_cgroup *cached;
> >  	uint8_t stock_pages;
> >  	unsigned long flags;
> > -	bool evict = true;
> > +	bool success = false;
> > +	int empty_slot = -1;
> >  	int i;
> >  
> >  	/*
> > @@ -1931,26 +1932,28 @@ static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
> >  
> >  	stock = this_cpu_ptr(&memcg_stock);
> >  	for (i = 0; i < NR_MEMCG_STOCK; ++i) {
> > -again:
> >  		cached = READ_ONCE(stock->cached[i]);
> > -		if (!cached) {
> > -			css_get(&memcg->css);
> > -			WRITE_ONCE(stock->cached[i], memcg);
> > -		}
> > -		if (!cached || memcg == READ_ONCE(stock->cached[i])) {
> > +		if (!cached && empty_slot == -1)
> > +			empty_slot = i;
> > +		if (memcg == READ_ONCE(stock->cached[i])) {
> >  			stock_pages = READ_ONCE(stock->nr_pages[i]) + nr_pages;
> >  			WRITE_ONCE(stock->nr_pages[i], stock_pages);
> >  			if (stock_pages > MEMCG_CHARGE_BATCH)
> >  				drain_stock(stock, i);

So, this drain_stock() above can punch a NULL hole in the array but I
think I do see your point. We can fill this hole by moving the last
non-NULL here. For now I plan to keep it as is as I have some followup
plans to make this specific drain_stock() conditional on the caller
(somewhat similar to commit 5387c90490f7f) and then I will re-check if
we can eliminate this NULL hole.

Thanks a lot for the reviews and suggestions.


