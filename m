Return-Path: <netdev+bounces-126007-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 277A296F8F9
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 18:04:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1E102849A3
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 16:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF001D31BA;
	Fri,  6 Sep 2024 16:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="slP+PObl"
X-Original-To: netdev@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2647D374F1
	for <netdev@vger.kernel.org>; Fri,  6 Sep 2024 16:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725638643; cv=none; b=K7pCkfzcoQe2ztdDsbQY3bV+czU2VujipL5V051c3iCeIaFUNzpl+zvtHN02z0JxdB8o1coy8qEFjIOUF8+LfL+/QI59X/xqGnyu1lWREhE06SB3+8qe1uGuppHUHQn/agJh4VP7BWQYpovCfNbUH4u6VUcmyilyzAA44KtpEZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725638643; c=relaxed/simple;
	bh=mQDpTkFyLm0odGX34YBM4aZGYFXqn5aH5odSUk4C1WI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SDQSvF18GJIp+4XQ+v1amLpYARzCH70vjPsMIMbg/j9Qoe8VzzyIEinM35eMTYcIVGVVqVnjc1mRAgtNBTXD0iujDU6rf4p4uCnckSzaR10G06meoZxz8zfEqYJDJ75n1Yr5aKoB0v637/slTNYZ5iGNXzKVJ0PnEYmxEV5rV/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=slP+PObl; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 6 Sep 2024 09:03:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725638638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dTskArZncKt0pUKIN2dkR1HoLoe1rwj7R2FFyS66ktk=;
	b=slP+POblHpDGNl8D9VDtMWVWaV/xvR+Dsps19NpRz/soVWgyQss3p3S+poZsrB5Mq5O75K
	nzlMpEl2iuMDlnz8pwrf3rlgy4j2ffh0DLTD3MmD2nOuFVeDm0XwUtc4Pb2HFX4xo4bgSB
	75tZ+or1hIcU9ftkSGJOxEqfK9sqXdg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Yosry Ahmed <yosryahmed@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, David Rientjes <rientjes@google.com>, 
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, Eric Dumazet <edumazet@google.com>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Meta kernel team <kernel-team@meta.com>, cgroups@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v4] memcg: add charging of already allocated slab objects
Message-ID: <oe6avn6iiksrhpon3c7igplcooorjpypaqytppfbu2y4aryz5j@vx727pvwi35n>
References: <20240905173422.1565480-1-shakeel.butt@linux.dev>
 <CAJD7tkbWLYG7-G9G7MNkcA98gmGDHd3DgS38uF6r5o60H293rQ@mail.gmail.com>
 <qk3437v2as6pz2zxu4uaniqfhpxqd3qzop52zkbxwbnzgssi5v@br2hglnirrgx>
 <572688a7-8719-4f94-a5cd-e726486c757d@suse.cz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <572688a7-8719-4f94-a5cd-e726486c757d@suse.cz>
X-Migadu-Flow: FLOW_OUT

On Fri, Sep 06, 2024 at 10:52:04AM GMT, Vlastimil Babka wrote:
> On 9/5/24 20:48, Shakeel Butt wrote:
> >> > ---
> >> > v3: https://lore.kernel.org/all/20240829175339.2424521-1-shakeel.butt@linux.dev/
> >> > Changes since v3:
> >> > - Add kernel doc for kmem_cache_charge.
> >> >
> >> > v2: https://lore.kernel.org/all/20240827235228.1591842-1-shakeel.butt@linux.dev/
> >> > Change since v2:
> >> > - Add handling of already charged large kmalloc objects.
> >> > - Move the normal kmalloc cache check into a function.
> >> >
> >> > v1: https://lore.kernel.org/all/20240826232908.4076417-1-shakeel.butt@linux.dev/
> >> > Changes since v1:
> >> > - Correctly handle large allocations which bypass slab
> >> > - Rearrange code to avoid compilation errors for !CONFIG_MEMCG builds
> >> >
> >> > RFC: https://lore.kernel.org/all/20240824010139.1293051-1-shakeel.butt@linux.dev/
> >> > Changes since the RFC:
> >> > - Added check for already charged slab objects.
> >> > - Added performance results from neper's tcp_crr
> >> >
> >> >
> >> >  include/linux/slab.h            | 20 ++++++++++++++
> >> >  mm/slab.h                       |  7 +++++
> >> >  mm/slub.c                       | 49 +++++++++++++++++++++++++++++++++
> >> >  net/ipv4/inet_connection_sock.c |  5 ++--
> >> >  4 files changed, 79 insertions(+), 2 deletions(-)
> >> >
> >> > diff --git a/include/linux/slab.h b/include/linux/slab.h
> >> > index eb2bf4629157..68789c79a530 100644
> >> > --- a/include/linux/slab.h
> >> > +++ b/include/linux/slab.h
> >> > @@ -547,6 +547,26 @@ void *kmem_cache_alloc_lru_noprof(struct kmem_cache *s, struct list_lru *lru,
> >> >                             gfp_t gfpflags) __assume_slab_alignment __malloc;
> >> >  #define kmem_cache_alloc_lru(...)      alloc_hooks(kmem_cache_alloc_lru_noprof(__VA_ARGS__))
> >> >
> >> > +/**
> >> > + * kmem_cache_charge - memcg charge an already allocated slab memory
> >> > + * @objp: address of the slab object to memcg charge.
> >> > + * @gfpflags: describe the allocation context
> >> > + *
> >> > + * kmem_cache_charge is the normal method to charge a slab object to the current
> 
> what is "normal method"? 

This is just a copy-paste from kmalloc() documentation.

> 
> >> > + * memcg. The objp should be pointer returned by the slab allocator functions
> >> > + * like kmalloc or kmem_cache_alloc. The memcg charge behavior can be controller
> >> 
> >> s/controller/controlled
> > 
> > Thanks. Vlastimil please fix this when you pick this up.
> 
> I felt it could be improved more, so ended up with this. Thoughts?
> 
> /**
>  * kmem_cache_charge - memcg charge an already allocated slab memory
>  * @objp: address of the slab object to memcg charge
>  * @gfpflags: describe the allocation context
>  *
>  * kmem_cache_charge allows charging a slab object to the current memcg,
>  * primarily in cases where charging at allocation time might not be possible
>  * because the target memcg is not known (i.e. softirq context)
>  *
>  * The objp should be pointer returned by the slab allocator functions like
>  * kmalloc (with __GFP_ACCOUNT in flags) or kmem_cache_alloc. The memcg charge
>  * behavior can be controlled through gfpflags parameter, which affects how the
>  * necessary internal metadata can be allocated. Including __GFP_NOFAIL denotes
>  * that overcharging is requested instead of failure, but is not applied for the
>  * internal metadata allocation.
>  *
>  * There are several cases where it will return true even if the charging was
>  * not done:
>  * More specifically:
>  *
>  * 1. For !CONFIG_MEMCG or cgroup_disable=memory systems.
>  * 2. Already charged slab objects.
>  * 3. For slab objects from KMALLOC_NORMAL caches - allocated by kmalloc()
>  *    without __GFP_ACCOUNT
>  * 4. Allocating internal metadata has failed
>  *
>  * Return: true if charge was successful otherwise false.
>  */
>  

Yes, this is much better.

> >> > +
> >> > +       /* Ignore KMALLOC_NORMAL cache to avoid circular dependency. */
> >> 
> >> Is it possible to point to the commit that has the explanation here?
> >> The one you pointed me to before? Otherwise it's not really obvious
> >> where the circular dependency comes from (at least to me).
> >> 
> > 
> > Not sure about the commit reference. We can add more text here.
> > Vlastimil, how much detail do you prefer?
> 
> What about:
> 
>         /*
>          * Ignore KMALLOC_NORMAL cache to avoid possible circular dependency
>          * of slab_obj_exts being allocated from the same slab and thus the slab
>          * becoming effectively unfreeable.
>          */
> 

Looks great to me.

thanks,
Shakeel

