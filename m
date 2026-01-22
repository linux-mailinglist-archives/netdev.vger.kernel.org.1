Return-Path: <netdev+bounces-252337-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QC6lLasbcmnrbwAAu9opvQ
	(envelope-from <netdev+bounces-252337-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 13:44:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C65AD66C88
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 13:44:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B0D2D4F18C7
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 12:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1BFD3101C2;
	Thu, 22 Jan 2026 12:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="k9TQhFgZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="XPtQ1P88";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="k9TQhFgZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="XPtQ1P88"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC6A3EFD1B
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 12:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769084551; cv=none; b=elcnJ5OVYyLen+F/taFxTuPSN9oOmzVzxn0u/K8zXxyj/7pmvSmYeQwD2UnwHuYRe+JN9VRhp0EAd6dnqmTHlyjz8cXqa8xj6wW/hmA3dc87Vfy9jEBmJyq/cz54iGN8DEssAcFFaPcIiZHo6jFFqI33Qea2xdIBfOV+AbifIWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769084551; c=relaxed/simple;
	bh=y8hzTT455HYk+1720jHQBtvMudFAdDUuJ5NpgQT/G+0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TgHAZnc2mzuEwMX8sJvdq6WZ0VB2IgPkJdaNn+TtNNs4Qy1wJYNyH27IPnl2ygky5/NchtpTgQi4XWpxWpmrfoTaMthzvu53mPIJRxJgarHdQobAl+23WgtJlZJT/MwTyvX5bZCoa0JA77PsZLAYZKMYPF58anNQLx50FE/mB3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=k9TQhFgZ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=XPtQ1P88; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=k9TQhFgZ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=XPtQ1P88; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6EEDC33700;
	Thu, 22 Jan 2026 12:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1769084547; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=R6hAPsj+NLwtF41nywMmwEDmVvrQvw3fqSAvHGFPS1U=;
	b=k9TQhFgZ5c2BamhxOnh7Bk8q0No5vaCvYpfe4+Gbgwm0NeuoY3AHVcomUR1/FDAeYJgvGn
	P0jy3pjRiW78oUgkPlSE+Y3vT/EdfCXX1tp1pv6pI5XmCz3+G4mQl2rEhmlHg9nbiiTUYG
	Nrqv/xva9bZhCSxegHLq0rPA0MoOn7c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1769084547;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=R6hAPsj+NLwtF41nywMmwEDmVvrQvw3fqSAvHGFPS1U=;
	b=XPtQ1P88wnPQkQ95I0U7USA/LYirfGKp0FabMshNGhQBwyaNAe0Oq2ecIbanfU1HN4SUe9
	jm0ReZg/fGxUy5Ag==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1769084547; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=R6hAPsj+NLwtF41nywMmwEDmVvrQvw3fqSAvHGFPS1U=;
	b=k9TQhFgZ5c2BamhxOnh7Bk8q0No5vaCvYpfe4+Gbgwm0NeuoY3AHVcomUR1/FDAeYJgvGn
	P0jy3pjRiW78oUgkPlSE+Y3vT/EdfCXX1tp1pv6pI5XmCz3+G4mQl2rEhmlHg9nbiiTUYG
	Nrqv/xva9bZhCSxegHLq0rPA0MoOn7c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1769084547;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=R6hAPsj+NLwtF41nywMmwEDmVvrQvw3fqSAvHGFPS1U=;
	b=XPtQ1P88wnPQkQ95I0U7USA/LYirfGKp0FabMshNGhQBwyaNAe0Oq2ecIbanfU1HN4SUe9
	jm0ReZg/fGxUy5Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2DDDB13533;
	Thu, 22 Jan 2026 12:22:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LfTiCoMWcmm6fwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 22 Jan 2026 12:22:27 +0000
Message-ID: <dfdd0648-a7da-4e8e-8781-cf094da4844f@suse.cz>
Date: Thu, 22 Jan 2026 13:22:26 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] mm/page_alloc: boost watermarks on atomic allocation
 failure
Content-Language: en-US
To: Qiliang Yuan <realwujing@gmail.com>, akpm@linux-foundation.org
Cc: david@kernel.org, mhocko@suse.com, willy@infradead.org,
 lance.yang@linux.dev, hannes@cmpxchg.org, surenb@google.com,
 jackmanb@google.com, ziy@nvidia.com, weixugc@google.com, rppt@kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 edumazet@google.com, jis1@chinatelecom.cn, wangh13@chinatelecom.cn,
 liyi1@chinatelecom.cn, sunshx@chinatelecom.cn, zhangzq20@chinatelecom.cn,
 zhangjn11@chinatelecom.cn, Qiliang Yuan <yuanql9@chinatelecom.cn>
References: <20260121125603.47b204cc8fbe9466b25cce16@linux-foundation.org>
 <20260122020742.230219-1-realwujing@gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <20260122020742.230219-1-realwujing@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[suse.cz];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,linux-foundation.org];
	RCPT_COUNT_TWELVE(0.00)[23];
	TAGGED_FROM(0.00)[bounces-252337-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vbabka@suse.cz,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:dkim,dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns,chinatelecom.cn:email]
X-Rspamd-Queue-Id: C65AD66C88
X-Rspamd-Action: no action

On 1/22/26 03:07, Qiliang Yuan wrote:
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
> 
> Signed-off-by: Qiliang Yuan <realwujing@gmail.com>
> Signed-off-by: Qiliang Yuan <yuanql9@chinatelecom.cn>
> ---
> v6:
>   - Replace magic number ">> 10" with ATOMIC_BOOST_SCALE_SHIFT define
>   - Add documentation explaining 0.1% zone size boost rationale
> v5:
>   - Simplify to use native boost_watermark() instead of custom logic
> v4:
>   - Add watermark_scale_boost and gradual decay via balance_pgdat
> v3:
>   - Move debounce timer to per-zone; optimize zone selection
> v2:
>   - Add debounce logic and zone-proportional boosting
> v1:
>   - Initial: boost min_free_kbytes on GFP_ATOMIC failure
> ---
>  include/linux/mmzone.h |  1 +
>  mm/page_alloc.c        | 36 +++++++++++++++++++++++++++++++++++-
>  2 files changed, 36 insertions(+), 1 deletion(-)
> ---
>  include/linux/mmzone.h |  1 +
>  mm/page_alloc.c        | 36 +++++++++++++++++++++++++++++++++++-
>  2 files changed, 36 insertions(+), 1 deletion(-)
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
> index c380f063e8b7..8ea2435125d5 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -218,6 +218,13 @@ unsigned int pageblock_order __read_mostly;
>  static void __free_pages_ok(struct page *page, unsigned int order,
>  			    fpi_t fpi_flags);
>  
> +/*
> + * Boost watermarks by ~0.1% of zone size on atomic allocation pressure.
> + * This provides zone-proportional safety buffers: ~1MB per 1GB of zone size.
> + * Larger zones under GFP_ATOMIC pressure need proportionally larger reserves.
> + */
> +#define ATOMIC_BOOST_SCALE_SHIFT 10
> +
>  /*
>   * results with 256, 32 in the lowmem_reserve sysctl:
>   *	1G machine -> (16M dma, 800M-16M normal, 1G-800M high)
> @@ -2189,12 +2196,31 @@ static inline bool boost_watermark(struct zone *zone)
>  
>  	max_boost = max(pageblock_nr_pages, max_boost);
>  
> -	zone->watermark_boost = min(zone->watermark_boost + pageblock_nr_pages,
> +	zone->watermark_boost = min(zone->watermark_boost +
> +		max(pageblock_nr_pages, zone_managed_pages(zone) >> ATOMIC_BOOST_SCALE_SHIFT),

So IIUC you are not changing (increasing) the maximum boost, but the amount
in one step. It would be more descriptive to first set a local variable with
this amount and then use it for the boosting.

This change also affects the original boost_watermark() caller. Maybe it's
fine, can't say without any measurements.

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

The other caller of boost_watermark() is under zone->lock and it makes those
zone->watermark_boost increments safe, and balance_pgdat() takes it for the
decrements too with "/* Increments are under the zone lock */ " comment,
otherwise I wouldn't realize this.

It probably wouldn't hurt to add a lockdep assert into boost_watermark() to
prevent mistakes.

But the other caller also takes care not to call wakeup_kswapd() under the
zone lock so I would not do it as well - see commit 73444bc4d8f92

> +			/* Only boost the preferred zone to be precise */
> +			break;
> +		}
> +	}
> +}
> +
>  /*
>   * When we are falling back to another migratetype during allocation, should we
>   * try to claim an entire block to satisfy further allocations, instead of
> @@ -4742,6 +4768,10 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
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
> @@ -4947,6 +4977,10 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
>  		goto retry;
>  	}
>  fail:
> +	/* Boost watermarks on atomic allocation failure to trigger kswapd */
> +	if (unlikely(page == NULL && (gfp_mask & GFP_ATOMIC) && order == 0))
> +		boost_zones_for_atomic(ac, gfp_mask);

We already did the boosting when entering slowpath, there's 1 second
debounce and GFP_ATOMIC can't really do anything in the slowpath to spend 1
second, so I think this is redundant.

> +
>  	warn_alloc(gfp_mask, ac->nodemask,
>  			"page allocation failure: order:%u", order);
>  got_pg:


