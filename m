Return-Path: <netdev+bounces-228954-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4820BD660B
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 23:35:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88E11402CE2
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 21:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F10B02DE1F0;
	Mon, 13 Oct 2025 21:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iuiHMEGI"
X-Original-To: netdev@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02EAD2D9EF8;
	Mon, 13 Oct 2025 21:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760391341; cv=none; b=ODNiPl2lpWG3g9sm2DVXY3nSEiusWfawc/98krp0sbAU+J44Q3948YKNu0HB2DRqw6oH+ox3rHWiNje2fHllmBDM2znK6YrtwhKVjm1S+RSudPkijKRwrO9NTl1bOvoMVKp8wJ+rH28kyTrRORvDWjd4JihrQo4BR/5oFTAdjec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760391341; c=relaxed/simple;
	bh=jqPWipQvwEI0426R6a2KF+Ie8Wc+CqVLazRzissvs9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HDYmGvvqFm8clE7k7rAaZQokHzfjGHtOGUQ0mH0oPzoWeCZ6fXsAbrmeizLqnA2aKnV4ngOygMuPVcbWMPwHEM/2WN5KlUvFXdOYGnU76fXavbqBuOTl1aOvf1otjxbUsXUD93SENJfCjZ65zuVBky3yhjXLes+2hwESz5z/x7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iuiHMEGI; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 13 Oct 2025 14:35:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760391336;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JPYBsz9pGkaccZ8zsTc8dJhQOz3Z69EhCvUXsfnXcEw=;
	b=iuiHMEGIr7qkZSeMQxTocOUmuJoL5V6SAxdiC/mkgSEnLO13/XyNWsDjIL5aO/NABfVdmM
	sR9PlyajnkGBvkhbHlCOkLasA30uo8fMIDqpstbEdlm6aKyk2pCFeecAKGU6WqGTMh9UGu
	NxoDle17IfphqPCP6oz4WG36+11j/3k=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Barry Song <21cnbao@gmail.com>, netdev@vger.kernel.org, 
	linux-mm@kvack.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Barry Song <v-songbaohua@oppo.com>, Jonathan Corbet <corbet@lwn.net>, 
	Eric Dumazet <edumazet@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Simon Horman <horms@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Brendan Jackman <jackmanb@google.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, Yunsheng Lin <linyunsheng@huawei.com>, 
	Huacai Zhou <zhouhuacai@oppo.com>, Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	Harry Yoo <harry.yoo@oracle.com>, David Hildenbrand <david@redhat.com>, 
	Matthew Wilcox <willy@infradead.org>, Roman Gushchin <roman.gushchin@linux.dev>
Subject: Re: [RFC PATCH] mm: net: disable kswapd for high-order network
 buffer allocation
Message-ID: <dhmafwxu2jj4lu6acoqdhqh46k33sbsj5jvepcfzly4c7dn2t7@ln5dgubll4ac>
References: <20251013101636.69220-1-21cnbao@gmail.com>
 <927bcdf7-1283-4ddd-bd5e-d2e399b26f7d@suse.cz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <927bcdf7-1283-4ddd-bd5e-d2e399b26f7d@suse.cz>
X-Migadu-Flow: FLOW_OUT

On Mon, Oct 13, 2025 at 08:30:13PM +0200, Vlastimil Babka wrote:
> On 10/13/25 12:16, Barry Song wrote:
> > From: Barry Song <v-songbaohua@oppo.com>
> > 
> > On phones, we have observed significant phone heating when running apps
> > with high network bandwidth. This is caused by the network stack frequently
> > waking kswapd for order-3 allocations. As a result, memory reclamation becomes
> > constantly active, even though plenty of memory is still available for network
> > allocations which can fall back to order-0.
> > 
> > Commit ce27ec60648d ("net: add high_order_alloc_disable sysctl/static key")
> > introduced high_order_alloc_disable for the transmit (TX) path
> > (skb_page_frag_refill()) to mitigate some memory reclamation issues,
> > allowing the TX path to fall back to order-0 immediately, while leaving the
> > receive (RX) path (__page_frag_cache_refill()) unaffected. Users are
> > generally unaware of the sysctl and cannot easily adjust it for specific use
> > cases. Enabling high_order_alloc_disable also completely disables the
> > benefit of order-3 allocations. Additionally, the sysctl does not apply to the
> > RX path.
> > 
> > An alternative approach is to disable kswapd for these frequent
> > allocations and provide best-effort order-3 service for both TX and RX paths,
> > while removing the sysctl entirely.
> > 
> > Cc: Jonathan Corbet <corbet@lwn.net>
> > Cc: Eric Dumazet <edumazet@google.com>
> > Cc: Kuniyuki Iwashima <kuniyu@google.com>
> > Cc: Paolo Abeni <pabeni@redhat.com>
> > Cc: Willem de Bruijn <willemb@google.com>
> > Cc: "David S. Miller" <davem@davemloft.net>
> > Cc: Jakub Kicinski <kuba@kernel.org>
> > Cc: Simon Horman <horms@kernel.org>
> > Cc: Vlastimil Babka <vbabka@suse.cz>
> > Cc: Suren Baghdasaryan <surenb@google.com>
> > Cc: Michal Hocko <mhocko@suse.com>
> > Cc: Brendan Jackman <jackmanb@google.com>
> > Cc: Johannes Weiner <hannes@cmpxchg.org>
> > Cc: Zi Yan <ziy@nvidia.com>
> > Cc: Yunsheng Lin <linyunsheng@huawei.com>
> > Cc: Huacai Zhou <zhouhuacai@oppo.com>
> > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> > ---
> >  Documentation/admin-guide/sysctl/net.rst | 12 ------------
> >  include/net/sock.h                       |  1 -
> >  mm/page_frag_cache.c                     |  2 +-
> >  net/core/sock.c                          |  8 ++------
> >  net/core/sysctl_net_core.c               |  7 -------
> >  5 files changed, 3 insertions(+), 27 deletions(-)
> > 
> > diff --git a/Documentation/admin-guide/sysctl/net.rst b/Documentation/admin-guide/sysctl/net.rst
> > index 2ef50828aff1..b903bbae239c 100644
> > --- a/Documentation/admin-guide/sysctl/net.rst
> > +++ b/Documentation/admin-guide/sysctl/net.rst
> > @@ -415,18 +415,6 @@ GRO has decided not to coalesce, it is placed on a per-NAPI list. This
> >  list is then passed to the stack when the number of segments reaches the
> >  gro_normal_batch limit.
> >  
> > -high_order_alloc_disable
> > -------------------------
> > -
> > -By default the allocator for page frags tries to use high order pages (order-3
> > -on x86). While the default behavior gives good results in most cases, some users
> > -might have hit a contention in page allocations/freeing. This was especially
> > -true on older kernels (< 5.14) when high-order pages were not stored on per-cpu
> > -lists. This allows to opt-in for order-0 allocation instead but is now mostly of
> > -historical importance.
> > -
> > -Default: 0
> > -
> >  2. /proc/sys/net/unix - Parameters for Unix domain sockets
> >  ----------------------------------------------------------
> >  
> > diff --git a/include/net/sock.h b/include/net/sock.h
> > index 60bcb13f045c..62306c1095d5 100644
> > --- a/include/net/sock.h
> > +++ b/include/net/sock.h
> > @@ -3011,7 +3011,6 @@ extern __u32 sysctl_wmem_default;
> >  extern __u32 sysctl_rmem_default;
> >  
> >  #define SKB_FRAG_PAGE_ORDER	get_order(32768)
> > -DECLARE_STATIC_KEY_FALSE(net_high_order_alloc_disable_key);
> >  
> >  static inline int sk_get_wmem0(const struct sock *sk, const struct proto *proto)
> >  {
> > diff --git a/mm/page_frag_cache.c b/mm/page_frag_cache.c
> > index d2423f30577e..dd36114dd16f 100644
> > --- a/mm/page_frag_cache.c
> > +++ b/mm/page_frag_cache.c
> > @@ -54,7 +54,7 @@ static struct page *__page_frag_cache_refill(struct page_frag_cache *nc,
> >  	gfp_t gfp = gfp_mask;
> >  
> >  #if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
> > -	gfp_mask = (gfp_mask & ~__GFP_DIRECT_RECLAIM) |  __GFP_COMP |
> > +	gfp_mask = (gfp_mask & ~__GFP_RECLAIM) |  __GFP_COMP |
> >  		   __GFP_NOWARN | __GFP_NORETRY | __GFP_NOMEMALLOC;
> 
> I'm a bit worried about proliferating "~__GFP_RECLAIM" allocations now that
> we introduced alloc_pages_nolock() and kmalloc_nolock() where it's
> interpreted as "cannot spin" - see gfpflags_allow_spinning(). Currently it's
> fine for the page allocator itself where we have a different entry point
> that uses ALLOC_TRYLOCK, but it can affect nested allocations of all kinds
> of debugging and accounting metadata (page_owner, memcg, alloc tags for slab
> objects etc). kmalloc_nolock() relies on gfpflags_allow_spinning() fully
> 
> I wonder if we should either:
> 
> 1) sacrifice a new __GFP flag specifically for "!allow_spin" case to
> determine it precisely.
> 
> 2) keep __GFP_KSWAPD_RECLAIM for allocations that remove it for purposes of
> not being disturbing (like proposed here), but that can in fact allow
> spinning. Instead, decide to not wake up kswapd by those when other
> information indicates it's an opportunistic allocation
> (~__GFP_DIRECT_RECLAIM, _GFP_NOWARN | __GFP_NORETRY | __GFP_NOMEMALLOC,
> order > 0...)
> 
> 3) something better?
> 

For the !allow_spin allocations, I think we should just add a new __GFP
flag instead of adding more complexity to other allocators which may or
may not want kswapd wakeup for many different reasons.




