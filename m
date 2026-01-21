Return-Path: <netdev+bounces-252054-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oPA2EHZAcWn2fgAAu9opvQ
	(envelope-from <netdev+bounces-252054-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 22:09:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C32115DD2C
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 22:09:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E30DDB2C1CC
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 20:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85725423A83;
	Wed, 21 Jan 2026 20:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="wgJ4vhPI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299D742317A;
	Wed, 21 Jan 2026 20:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769028967; cv=none; b=sYSgwBZui8a/2zLzWbR36sZYSrw9WkvR10zBI3sLXinXLI8mC55Q27Eqc2WXeZalXVRZ5yQErowBHUWz7X9Ukz/SlUqPsRFF6OCZjGkENJQD5sOIt91G4ilK7K/6yKN9/ZQIDGksMd/DfiuAD2I21oTaA1h3YtZWJc62H6UjUoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769028967; c=relaxed/simple;
	bh=9c2aN3sKqlycUaVBM4faJ8YchGyPwKANJZQK2n0ZgGc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=tPQNkAH1UhawuX7Df2SKtAOoG7t95NLz6wCvXqF0O2wKpf3fMs6c54HTy6JQ6XIUaf9A61UMbnif5PKeN7qGC8K1WxaT4PVCcHhsYWKS95gKKouCK2qSdpZPj38t2rK6AaD3Tmdea4wDAUs7abG39O2m9worevkUQZa6O61zTnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=wgJ4vhPI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02E9BC4CEF1;
	Wed, 21 Jan 2026 20:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1769028964;
	bh=9c2aN3sKqlycUaVBM4faJ8YchGyPwKANJZQK2n0ZgGc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=wgJ4vhPI4ZuqWfn5f95uSj9dcbjm5PvLaRj/uNLJy8MsMCRAGP/H9odeyQh8OkRvr
	 W6zEckqL7UziwR+RJeDyL2a9c8Sftac9KGA6sYqApr5cfLlo8NeNkb2Bx/Ngdej61M
	 7ftnd3/LypZLRJ4URK54hnSZKToFndBEmpeSxsA8=
Date: Wed, 21 Jan 2026 12:56:03 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Qiliang Yuan <realwujing@gmail.com>
Cc: david@kernel.org, mhocko@suse.com, vbabka@suse.cz, willy@infradead.org,
 lance.yang@linux.dev, hannes@cmpxchg.org, surenb@google.com,
 jackmanb@google.com, ziy@nvidia.com, weixugc@google.com, rppt@kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH v5] mm/page_alloc: boost watermarks on atomic allocation
 failure
Message-Id: <20260121125603.47b204cc8fbe9466b25cce16@linux-foundation.org>
In-Reply-To: <20260121065740.35616-1-realwujing@gmail.com>
References: <20260121065740.35616-1-realwujing@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[linux-foundation.org];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-252054-lists,netdev=lfdr.de];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,linux-foundation.org:mid,linux-foundation.org:dkim]
X-Rspamd-Queue-Id: C32115DD2C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 21 Jan 2026 01:57:40 -0500 Qiliang Yuan <realwujing@gmail.com> wrote:

> Atomic allocations (GFP_ATOMIC) are prone to failure under heavy memory
> pressure as they cannot enter direct reclaim. This patch introduces a
> 'Soft Boost' mechanism to mitigate this.
> 
> When a GFP_ATOMIC request fails or enters the slowpath, the preferred
> zone's watermark_boost is increased. This triggers kswapd to proactively
> reclaim memory, creating a safety buffer for future atomic bursts.
> 
> To prevent excessive reclaim during packet storms, a 1-second debounce
> timer (last_boost_jiffies) is added to each zone to rate-limit boosts.
> 
> This approach reuses existing watermark_boost infrastructure, ensuring
> minimal overhead and asynchronous background reclaim via kswapd.
> 
> Allocation failure logs:
> [38535644.718700] node 0: slabs: 1031, objs: 43328, free: 0
> [38535644.725059] node 1: slabs: 339, objs: 17616, free: 317
> [38535645.428345] SLUB: Unable to allocate memory on node -1, gfp=0x480020(GFP_ATOMIC)
> [38535645.436888] cache: skbuff_head_cache, object size: 232, buffer size: 256, default order: 2, min order: 0
> [38535645.447664] node 0: slabs: 940, objs: 40864, free: 144
> [38535645.454026] node 1: slabs: 322, objs: 19168, free: 383
> [38535645.556122] SLUB: Unable to allocate memory on node -1, gfp=0x480020(GFP_ATOMIC)
> [38535645.564576] cache: skbuff_head_cache, object size: 232, buffer size: 256, default order: 2, min order: 0
> [38535649.655523] warn_alloc: 59 callbacks suppressed
> [38535649.655527] swapper/100: page allocation failure: order:0, mode:0x480020(GFP_ATOMIC), nodemask=(null)
> [38535649.671692] swapper/100 cpuset=/ mems_allowed=0-1

This seems sensible to me - dynamically boost reserves in response to
sustained GFP_ATOMIC allocation failures.

It's very much a networking thing and I expect the networking people
have been looking at these issues for years.  So let's start by cc'ing
them!

Obvious question, which I think was asked before: what about gradually
decreasing those reserves when the packet storm has subsided?

> v4:
>   - Introduced watermark_scale_boost and gradual decay via balance_pgdat.

And there it is, but v5 removed this.  Why?

Or perhaps I'm misreading the implementation.

>   - Added proactive soft-boosting when entering slowpath.
> v3:
>   - Moved debounce timer to per-zone to avoid cross-node interference.
>   - Optimized candidate zone selection to reduce global reclaim pressure.
> v2:
>   - Added basic debounce logic and scaled boosting strength based on zone size.
> v1:
>   - Initial proposal: Basic watermark boost on atomic allocation failure.
> ---
>  include/linux/mmzone.h |  1 +
>  mm/page_alloc.c        | 29 ++++++++++++++++++++++++++++-
>  2 files changed, 29 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 75ef7c9f9307..8e37e4e6765b 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -882,6 +882,7 @@ struct zone {
>  	/* zone watermarks, access with *_wmark_pages(zone) macros */
>  	unsigned long _watermark[NR_WMARK];
>  	unsigned long watermark_boost;
> +	unsigned long last_boost_jiffies;
>  
>  	unsigned long nr_reserved_highatomic;
>  	unsigned long nr_free_highatomic;
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index c380f063e8b7..1faace9e2dc5 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -2189,12 +2189,31 @@ static inline bool boost_watermark(struct zone *zone)
>  
>  	max_boost = max(pageblock_nr_pages, max_boost);
>  
> -	zone->watermark_boost = min(zone->watermark_boost + pageblock_nr_pages,
> +	zone->watermark_boost = min(zone->watermark_boost +
> +		max(pageblock_nr_pages, zone_managed_pages(zone) >> 10),

">> 10" is a magic number.  What is the reasoning behind choosing this
value?

>  		max_boost);
>  
>  	return true;
>  }
>  
> +static void boost_zones_for_atomic(struct alloc_context *ac, gfp_t gfp_mask)
> +{
> +	struct zoneref *z;
> +	struct zone *zone;
> +	unsigned long now = jiffies;
> +
> +	for_each_zone_zonelist(zone, z, ac->zonelist, ac->highest_zoneidx) {
> +		/* 1 second debounce to avoid spamming boosts in a burst */
> +		if (time_after(now, zone->last_boost_jiffies + HZ)) {
> +			zone->last_boost_jiffies = now;
> +			if (boost_watermark(zone))
> +				wakeup_kswapd(zone, gfp_mask, 0, ac->highest_zoneidx);
> +			/* Only boost the preferred zone to be precise */
> +			break;
> +		}
> +	}
> +}
> +
>  /*
>   * When we are falling back to another migratetype during allocation, should we
>   * try to claim an entire block to satisfy further allocations, instead of
> @@ -4742,6 +4761,10 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
>  	if (page)
>  		goto got_pg;
>  
> +	/* Proactively boost for atomic requests entering slowpath */
> +	if ((gfp_mask & GFP_ATOMIC) && order == 0)
> +		boost_zones_for_atomic(ac, gfp_mask);
> +
>  	/*
>  	 * For costly allocations, try direct compaction first, as it's likely
>  	 * that we have enough base pages and don't need to reclaim. For non-
> @@ -4947,6 +4970,10 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
>  		goto retry;
>  	}
>  fail:
> +	/* Boost watermarks on atomic allocation failure to trigger kswapd */
> +	if (unlikely(page == NULL && (gfp_mask & GFP_ATOMIC) && order == 0))
> +		boost_zones_for_atomic(ac, gfp_mask);
> +
>  	warn_alloc(gfp_mask, ac->nodemask,
>  			"page allocation failure: order:%u", order);
>  got_pg:
> -- 
> 2.51.0

