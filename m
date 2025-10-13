Return-Path: <netdev+bounces-228900-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5E7BD5B85
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 20:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14C53420FF4
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 18:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13A762D47E1;
	Mon, 13 Oct 2025 18:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="v/BfMoyN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="EJD4haWl";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="v/BfMoyN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="EJD4haWl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72AB927464F
	for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 18:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760380220; cv=none; b=WzBGTcp9XQxMjbLBMMXAMWpC9p5EItQ6ftVrk6tFyk+NaR06UpT0BcpMqffAVfCM7+ZadKm+oGjgvB00fObpgtygAIBcESypZQi8Naj6hPxF/VW85qf6WKPkB1LWZ1MmUvyemHTyStCPazZTmCGtiAGXXONx9qAzBCpoG80Grfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760380220; c=relaxed/simple;
	bh=IkNAXexDut1qf0EmtYqLNpzFEGTU7yU44exO3kSi3RQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KmlRYT2paTrVDR+mKDxiHXCNLewODcOW2vhBGQ8RRSuGDpXQE/xztCHhtbx9orwH74YfgVevo5p+2tcCzorMv3VndTuSAegepebx6i/9eGAmaIYKzbL7/yFoJQY7dsPbKG/lLGqmpCX2LHNQdeY0JL1Pmg2WJnBI6ZdSVsKCO0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=v/BfMoyN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=EJD4haWl; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=v/BfMoyN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=EJD4haWl; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 68D291F393;
	Mon, 13 Oct 2025 18:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760380214; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=eCORyVE8664QNw67kIxLlSqS7K6mwn4csjydy4owqs0=;
	b=v/BfMoyNDRNDuZGCYnH+/tqK+u0nj83QSa39ZpyNVSj65vevA/GUDXF6YnzaBgh5o+l6nk
	mZp9EBxCsS96CjzPiGqp5Ubk8X10sYVAy1S8VL3g8+zHyu6UHkQrItqAKOts3RWx/guv9X
	8vqI0kefX0z3sT+VvXmM6tIfS86gMoI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760380214;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=eCORyVE8664QNw67kIxLlSqS7K6mwn4csjydy4owqs0=;
	b=EJD4haWl7bR71UAmKZvmtuez6jRUvd7ngtpn/qHmgijW+fgp3FIRsVrz8z04AKYfKMMGF7
	AmbNU1NsMBHeOFDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="v/BfMoyN";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=EJD4haWl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760380214; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=eCORyVE8664QNw67kIxLlSqS7K6mwn4csjydy4owqs0=;
	b=v/BfMoyNDRNDuZGCYnH+/tqK+u0nj83QSa39ZpyNVSj65vevA/GUDXF6YnzaBgh5o+l6nk
	mZp9EBxCsS96CjzPiGqp5Ubk8X10sYVAy1S8VL3g8+zHyu6UHkQrItqAKOts3RWx/guv9X
	8vqI0kefX0z3sT+VvXmM6tIfS86gMoI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760380214;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=eCORyVE8664QNw67kIxLlSqS7K6mwn4csjydy4owqs0=;
	b=EJD4haWl7bR71UAmKZvmtuez6jRUvd7ngtpn/qHmgijW+fgp3FIRsVrz8z04AKYfKMMGF7
	AmbNU1NsMBHeOFDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 39E9613874;
	Mon, 13 Oct 2025 18:30:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IAy4DTZF7WiVBQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 13 Oct 2025 18:30:14 +0000
Message-ID: <927bcdf7-1283-4ddd-bd5e-d2e399b26f7d@suse.cz>
Date: Mon, 13 Oct 2025 20:30:13 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] mm: net: disable kswapd for high-order network buffer
 allocation
Content-Language: en-US
To: Barry Song <21cnbao@gmail.com>, netdev@vger.kernel.org,
 linux-mm@kvack.org, linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>,
 Jonathan Corbet <corbet@lwn.net>, Eric Dumazet <edumazet@google.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Willem de Bruijn <willemb@google.com>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Brendan Jackman <jackmanb@google.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
 Yunsheng Lin <linyunsheng@huawei.com>, Huacai Zhou <zhouhuacai@oppo.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Harry Yoo <harry.yoo@oracle.com>, David Hildenbrand <david@redhat.com>,
 Matthew Wilcox <willy@infradead.org>,
 Roman Gushchin <roman.gushchin@linux.dev>
References: <20251013101636.69220-1-21cnbao@gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <20251013101636.69220-1-21cnbao@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 68D291F393
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[26];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org,kvack.org];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,oppo.com,lwn.net,google.com,redhat.com,davemloft.net,kernel.org,suse.com,cmpxchg.org,nvidia.com,huawei.com,gmail.com,oracle.com,infradead.org,linux.dev];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	R_RATELIMIT(0.00)[to_ip_from(RLduzbn1medsdpg3i8igc4rk67)];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Score: -3.01

On 10/13/25 12:16, Barry Song wrote:
> From: Barry Song <v-songbaohua@oppo.com>
> 
> On phones, we have observed significant phone heating when running apps
> with high network bandwidth. This is caused by the network stack frequently
> waking kswapd for order-3 allocations. As a result, memory reclamation becomes
> constantly active, even though plenty of memory is still available for network
> allocations which can fall back to order-0.
> 
> Commit ce27ec60648d ("net: add high_order_alloc_disable sysctl/static key")
> introduced high_order_alloc_disable for the transmit (TX) path
> (skb_page_frag_refill()) to mitigate some memory reclamation issues,
> allowing the TX path to fall back to order-0 immediately, while leaving the
> receive (RX) path (__page_frag_cache_refill()) unaffected. Users are
> generally unaware of the sysctl and cannot easily adjust it for specific use
> cases. Enabling high_order_alloc_disable also completely disables the
> benefit of order-3 allocations. Additionally, the sysctl does not apply to the
> RX path.
> 
> An alternative approach is to disable kswapd for these frequent
> allocations and provide best-effort order-3 service for both TX and RX paths,
> while removing the sysctl entirely.
> 
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Kuniyuki Iwashima <kuniyu@google.com>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Willem de Bruijn <willemb@google.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Simon Horman <horms@kernel.org>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Brendan Jackman <jackmanb@google.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Yunsheng Lin <linyunsheng@huawei.com>
> Cc: Huacai Zhou <zhouhuacai@oppo.com>
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> ---
>  Documentation/admin-guide/sysctl/net.rst | 12 ------------
>  include/net/sock.h                       |  1 -
>  mm/page_frag_cache.c                     |  2 +-
>  net/core/sock.c                          |  8 ++------
>  net/core/sysctl_net_core.c               |  7 -------
>  5 files changed, 3 insertions(+), 27 deletions(-)
> 
> diff --git a/Documentation/admin-guide/sysctl/net.rst b/Documentation/admin-guide/sysctl/net.rst
> index 2ef50828aff1..b903bbae239c 100644
> --- a/Documentation/admin-guide/sysctl/net.rst
> +++ b/Documentation/admin-guide/sysctl/net.rst
> @@ -415,18 +415,6 @@ GRO has decided not to coalesce, it is placed on a per-NAPI list. This
>  list is then passed to the stack when the number of segments reaches the
>  gro_normal_batch limit.
>  
> -high_order_alloc_disable
> -------------------------
> -
> -By default the allocator for page frags tries to use high order pages (order-3
> -on x86). While the default behavior gives good results in most cases, some users
> -might have hit a contention in page allocations/freeing. This was especially
> -true on older kernels (< 5.14) when high-order pages were not stored on per-cpu
> -lists. This allows to opt-in for order-0 allocation instead but is now mostly of
> -historical importance.
> -
> -Default: 0
> -
>  2. /proc/sys/net/unix - Parameters for Unix domain sockets
>  ----------------------------------------------------------
>  
> diff --git a/include/net/sock.h b/include/net/sock.h
> index 60bcb13f045c..62306c1095d5 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -3011,7 +3011,6 @@ extern __u32 sysctl_wmem_default;
>  extern __u32 sysctl_rmem_default;
>  
>  #define SKB_FRAG_PAGE_ORDER	get_order(32768)
> -DECLARE_STATIC_KEY_FALSE(net_high_order_alloc_disable_key);
>  
>  static inline int sk_get_wmem0(const struct sock *sk, const struct proto *proto)
>  {
> diff --git a/mm/page_frag_cache.c b/mm/page_frag_cache.c
> index d2423f30577e..dd36114dd16f 100644
> --- a/mm/page_frag_cache.c
> +++ b/mm/page_frag_cache.c
> @@ -54,7 +54,7 @@ static struct page *__page_frag_cache_refill(struct page_frag_cache *nc,
>  	gfp_t gfp = gfp_mask;
>  
>  #if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
> -	gfp_mask = (gfp_mask & ~__GFP_DIRECT_RECLAIM) |  __GFP_COMP |
> +	gfp_mask = (gfp_mask & ~__GFP_RECLAIM) |  __GFP_COMP |
>  		   __GFP_NOWARN | __GFP_NORETRY | __GFP_NOMEMALLOC;

I'm a bit worried about proliferating "~__GFP_RECLAIM" allocations now that
we introduced alloc_pages_nolock() and kmalloc_nolock() where it's
interpreted as "cannot spin" - see gfpflags_allow_spinning(). Currently it's
fine for the page allocator itself where we have a different entry point
that uses ALLOC_TRYLOCK, but it can affect nested allocations of all kinds
of debugging and accounting metadata (page_owner, memcg, alloc tags for slab
objects etc). kmalloc_nolock() relies on gfpflags_allow_spinning() fully

I wonder if we should either:

1) sacrifice a new __GFP flag specifically for "!allow_spin" case to
determine it precisely.

2) keep __GFP_KSWAPD_RECLAIM for allocations that remove it for purposes of
not being disturbing (like proposed here), but that can in fact allow
spinning. Instead, decide to not wake up kswapd by those when other
information indicates it's an opportunistic allocation
(~__GFP_DIRECT_RECLAIM, _GFP_NOWARN | __GFP_NORETRY | __GFP_NOMEMALLOC,
order > 0...)

3) something better?

Vlastimil

>  	page = __alloc_pages(gfp_mask, PAGE_FRAG_CACHE_MAX_ORDER,
>  			     numa_mem_id(), NULL);
> diff --git a/net/core/sock.c b/net/core/sock.c
> index dc03d4b5909a..1fa1e9177d86 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -3085,8 +3085,6 @@ static void sk_leave_memory_pressure(struct sock *sk)
>  	}
>  }
>  
> -DEFINE_STATIC_KEY_FALSE(net_high_order_alloc_disable_key);
> -
>  /**
>   * skb_page_frag_refill - check that a page_frag contains enough room
>   * @sz: minimum size of the fragment we want to get
> @@ -3110,10 +3108,8 @@ bool skb_page_frag_refill(unsigned int sz, struct page_frag *pfrag, gfp_t gfp)
>  	}
>  
>  	pfrag->offset = 0;
> -	if (SKB_FRAG_PAGE_ORDER &&
> -	    !static_branch_unlikely(&net_high_order_alloc_disable_key)) {
> -		/* Avoid direct reclaim but allow kswapd to wake */
> -		pfrag->page = alloc_pages((gfp & ~__GFP_DIRECT_RECLAIM) |
> +	if (SKB_FRAG_PAGE_ORDER) {
> +		pfrag->page = alloc_pages((gfp & ~__GFP_RECLAIM) |
>  					  __GFP_COMP | __GFP_NOWARN |
>  					  __GFP_NORETRY,
>  					  SKB_FRAG_PAGE_ORDER);
> diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
> index 8cf04b57ade1..181f6532beb8 100644
> --- a/net/core/sysctl_net_core.c
> +++ b/net/core/sysctl_net_core.c
> @@ -599,13 +599,6 @@ static struct ctl_table net_core_table[] = {
>  		.extra1		= SYSCTL_ZERO,
>  		.extra2		= SYSCTL_THREE,
>  	},
> -	{
> -		.procname	= "high_order_alloc_disable",
> -		.data		= &net_high_order_alloc_disable_key.key,
> -		.maxlen         = sizeof(net_high_order_alloc_disable_key),
> -		.mode		= 0644,
> -		.proc_handler	= proc_do_static_key,
> -	},
>  	{
>  		.procname	= "gro_normal_batch",
>  		.data		= &net_hotdata.gro_normal_batch,


