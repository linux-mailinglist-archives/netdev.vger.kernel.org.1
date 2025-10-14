Return-Path: <netdev+bounces-229318-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EB4D3BDA954
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 18:13:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7017934C7FF
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 16:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA8D92C1786;
	Tue, 14 Oct 2025 16:13:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D519B2877E3
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 16:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760458404; cv=none; b=L+OJVfxb5qpmlNJHfE+PalshrZYQFlZei/ShNUZgM8kO52V3gPQ+SdKEjxXR4I4omjCSYme8GrcY7gdT+HmulLCGFTRnd16bSRetbuxgQkS7jVROSVopM60lSfC1SIEO/6yGe+2w1Wkt6OC2dn9xmkO+4rei11Xjxgux4wD3pDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760458404; c=relaxed/simple;
	bh=IpYLzozxxWXdKbnKBRbJDIidyOlsjMCeODX5hcLA5wk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZyLoTXciOQGD2nYgJnOqlqy9UupqzAG1O3yYjpzC+wHBNfHhcxlsRg+YCg0DyJdUazpXWnHn3rBT0GK5wmIpHsHRlCOFBSy+dpNDnQfkhje7B+UjDRVeLcHtOrTQbCXoV6EUteaboKHg6g+vdqGadFMugXVqEIAGCQJlWf7SzY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6394938e0ecso9164247a12.1
        for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 09:13:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760458401; x=1761063201;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=//02jhzybzRTsAQwMmWpsv3xhS89bxRH7c2a1Fq5ApA=;
        b=OGXK1HGTmeSWPI+N8uMFftwl0zEUob0AawF/APFfB76ZD2nAoM0qxT1sb1H2MAPmdH
         SK8Hxi9pxT6F9RTmo9Tuy4amrdVncgRZT1lxwn49xo7lhn/+i1IcB0GM6Y/3eM+0Jl7B
         mMaL+1f5XiDNZtBSGpFehiAvX/oUK5t6xUWu2YQMGs0CTZqnWOyuqpoW70BH6/8QwGvC
         Bd1oD6xHween8QhdkD67EDu7MhBB/rO/4HEjsmgXO3sArVyDmNJqC+873S1z+XGJalrw
         6Erneg4odl27TP2g30ZI2Dck/sY+k+rOyOyBPLECQu1BsX7AwUnxlPnT/FphYh/1aZIX
         tpmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHclyK2mYIbv666QeT6TQz8NpZs1h3crHgD/Glul5mAagpEDwOn/dj0AoEXhRCT5NBmCNqAoc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwevC6MwN/rmSs2F52JqcMc3O+iY/upkVyfiMsq6XfHj4R461lT
	FG3lJQ6ZPnKE4uiWer9qxsplhF84NmddYswfKXiIIJiYSzQJ7pvY3+Hk
X-Gm-Gg: ASbGncuCmk5YVywf/jDhy4AsiS2RnjTgdAe6jBA5ZuM96cvh4lqypH95y5Su6O/UJWa
	UzyN0xBQI2Vd9qGQhS4lU5rqABsUrP3OqhyTA762Uk1zops/9YD8oTqhJRREr0yaeRk61l2a5+j
	77L4SH8J7BBJLGstGHMF5fXIgc9CvQSSGKxhpWAnY3QrsbtBkghM1oHhc2rMVB70pRjX7ujOL6U
	zRIDhXcebN5HGA01Bp0XJ9T/cKeOOwjCwF0SXV1Nt4+Nm8fr1luMHtY+G3BxxE27qahJ1zbKA2T
	xHN0vurRCyHttW7Q/xDvLshQxm6aXSi+Vabbw17ByXnh7pYgDWA03UQBGUzc49lSSQ8mlVTlu2b
	NU5PFwiTFVp/jyrCYStK1ZzI9BalnNH9ViMo=
X-Google-Smtp-Source: AGHT+IGhu0gykfSr0z1wu2B7v62jrwI1vVub/7qRRjCr3AoBJQe1ZVnEw6PtLOxEN5FHwzaoj867DQ==
X-Received: by 2002:a05:6402:278b:b0:63b:dc7d:72f2 with SMTP id 4fb4d7f45d1cf-63bdc7d7e38mr1695096a12.19.1760458401023;
        Tue, 14 Oct 2025 09:13:21 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:3::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63a52b0f39esm11314435a12.11.2025.10.14.09.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 09:13:20 -0700 (PDT)
Date: Tue, 14 Oct 2025 09:13:18 -0700
From: Breno Leitao <leitao@debian.org>
To: Simon Horman <horms@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	usamaarif642@gmail.com, riel@surriel.com, kernel-team@meta.com
Subject: Re: [PATCH net v2] netpoll: Fix deadlock in memory allocation under
 spinlock
Message-ID: <53jkbptcchxc2sxho56rrj7bcwizpd536bsox45hw75uk2fydg@k33edbzrjdvr>
References: <20251014-fix_netpoll_aa-v2-1-dafa6a378649@debian.org>
 <aO5aJ9dN5xIIdmNE@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aO5aJ9dN5xIIdmNE@horms.kernel.org>

On Tue, Oct 14, 2025 at 03:11:51PM +0100, Simon Horman wrote:
> On Tue, Oct 14, 2025 at 03:10:51AM -0700, Breno Leitao wrote:
> > Fix a AA deadlock in refill_skbs() where memory allocation while holding
> > skb_pool->lock can trigger a recursive lock acquisition attempt.
> > 
> > The deadlock scenario occurs when the system is under severe memory
> > pressure:
> > 
> > 1. refill_skbs() acquires skb_pool->lock (spinlock)
> > 2. alloc_skb() is called while holding the lock
> > 3. Memory allocator fails and calls slab_out_of_memory()
> > 4. This triggers printk() for the OOM warning
> > 5. The console output path calls netpoll_send_udp()
> > 6. netpoll_send_udp() attempts to acquire the same skb_pool->lock
> > 7. Deadlock: the lock is already held by the same CPU
> > 
> > Call stack:
> >   refill_skbs()
> >     spin_lock_irqsave(&skb_pool->lock)    <- lock acquired
> >     __alloc_skb()
> >       kmem_cache_alloc_node_noprof()
> >         slab_out_of_memory()
> >           printk()
> >             console_flush_all()
> >               netpoll_send_udp()
> >                 skb_dequeue()
> >                   spin_lock_irqsave(&skb_pool->lock)     <- deadlock attempt
> > 
> > This bug was exposed by commit 248f6571fd4c51 ("netpoll: Optimize skb
> > refilling on critical path") which removed refill_skbs() from the
> > critical path (where nested printk was being deferred), letting nested
> > printk being calld form inside refill_skbs()
> > 
> > Refactor refill_skbs() to never allocate memory while holding
> > the spinlock.
> > 
> > Another possible solution to fix this problem is protecting the
> > refill_skbs() from nested printks, basically calling
> > printk_deferred_{enter,exit}() in refill_skbs(), then, any nested
> > pr_warn() would be deferred.
> > 
> > I prefer tthis approach, given I _think_ it might be a good idea to move
> > the alloc_skb() from GFP_ATOMIC to GFP_KERNEL in the future, so, having
> > the alloc_skb() outside of the lock will be necessary step.
> > 
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> > Fixes: 248f6571fd4c51 ("netpoll: Optimize skb refilling on critical path")
> > ---
> > Changes in v2:
> > - Added a return after the successful path (Rik van Riel)
> > - Changed the Fixes tag to point to the commit that exposed the problem.
> > - Link to v1: https://lore.kernel.org/r/20251013-fix_netpoll_aa-v1-1-94a1091f92f0@debian.org
> > ---
> >  net/core/netpoll.c | 20 +++++++++++++++++---
> >  1 file changed, 17 insertions(+), 3 deletions(-)
> > 
> > diff --git a/net/core/netpoll.c b/net/core/netpoll.c
> > index 60a05d3b7c249..c19dada9283ce 100644
> > --- a/net/core/netpoll.c
> > +++ b/net/core/netpoll.c
> > @@ -232,14 +232,28 @@ static void refill_skbs(struct netpoll *np)
> >  
> >  	skb_pool = &np->skb_pool;
> >  
> > -	spin_lock_irqsave(&skb_pool->lock, flags);
> > -	while (skb_pool->qlen < MAX_SKBS) {
> > +	while (1) {
> > +		spin_lock_irqsave(&skb_pool->lock, flags);
> > +		if (skb_pool->qlen >= MAX_SKBS)
> > +			goto unlock;
> > +		spin_unlock_irqrestore(&skb_pool->lock, flags);
> > +
> >  		skb = alloc_skb(MAX_SKB_SIZE, GFP_ATOMIC);
> >  		if (!skb)
> > -			break;
> > +			return;
> >  
> > +		spin_lock_irqsave(&skb_pool->lock, flags);
> > +		if (skb_pool->qlen >= MAX_SKBS)
> > +			/* Discard if len got increased (TOCTOU) */
> > +			goto discard;
> >  		__skb_queue_tail(skb_pool, skb);
> > +		spin_unlock_irqrestore(&skb_pool->lock, flags);
> >  	}
> > +
> > +	return;
> 
> Maybe it is worth leaving alone for clarity.
> And certainly it does no harm.
> But the line above is never reached.

Thanks for the catch. I will remove it since it is useless and respin.

