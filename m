Return-Path: <netdev+bounces-246962-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AF52BCF2E2D
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 11:00:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 54DD33033D72
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 09:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A80B93168E6;
	Mon,  5 Jan 2026 09:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="E7i5Fpwq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yEIVvlmN";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="R/ywBHxS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="I5nxatXx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7F82D9EFF
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 09:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767606975; cv=none; b=W8x6nDzTYZZjo9CzSXwauVEDkyK8nCCwxSpq/qVfV97qmlMvAILPHgZrrr69pQHY5se+XI3FSZrzLth4RSmDFBebpdaJMdrii17BMBrg6oYSmRVAhUwOsUS0+KDEZBI0uy8RYBH3qexS1Bq0mBAFFEr/JDbVbm+TDUAZEr9OlLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767606975; c=relaxed/simple;
	bh=IJhUu+L32rG0mD3Ah7c80MyOt16qj2qEMOEGUxwOMzk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ogFnv5gpA4aFKpDZ6KqY7soJ2Cp8Q8HIAFOqoX069DudUopir7In4/IUg5cR3FPsLzrchRs04vkuuoPl+dNqnb9s+A/Vw0FaXzc1ibDRHaSyBNQCdmXVACxhUV3vF0Gvlth78CoYs/tNPuyPPYhvy98wNIW3lef2abxtMePyvP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=E7i5Fpwq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=yEIVvlmN; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=R/ywBHxS; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=I5nxatXx; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CDC695BE34;
	Mon,  5 Jan 2026 09:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1767606970; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=tyzvGt7ijyC3iXfUIAbqPhVhe1mSFkUEVg0NYFf04bY=;
	b=E7i5FpwqEfF3sSQzIGa7nSu9OuUjOpt2iscA238PoyrAhEf0SP/BNkLbXTdbL8pSyzkLne
	VnSoyAfskyeFAygapvCLDTZGiEUvlx4V2/N5ue3AJ4YbQKnT6ZC42LKkdF9RjbNdFepuDO
	/8A5WvlsBta30yu04B8EYRX0V9WTpXA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1767606970;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=tyzvGt7ijyC3iXfUIAbqPhVhe1mSFkUEVg0NYFf04bY=;
	b=yEIVvlmNnvo18hfLm2a3k4uNcVJEXakgPgy1H7UCpIiiUq/3b9uV+jrxvt1j3caDxM6K9h
	kS+FGMxVmsFz7ACQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1767606969; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=tyzvGt7ijyC3iXfUIAbqPhVhe1mSFkUEVg0NYFf04bY=;
	b=R/ywBHxSUrbqAa6LMzFpOwqn7ztTjlGhqqXaBOCRfjzBE72tHH5F35oeu951VGzup7HtQH
	7s28lP+KUyZ/fFTO1ff84LyHDm9pkuvPLsSL3bMXjNVkPP5t0pVnLEgh7RYNua7M1EkVJY
	dKmriE83g57xtywbiXkyquxoM5uAHoI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1767606969;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=tyzvGt7ijyC3iXfUIAbqPhVhe1mSFkUEVg0NYFf04bY=;
	b=I5nxatXxr3jOMvQJ250fW1nLDZvTWQvOtiXKQ19T/YG9ClyH/d5YiuzJLkEb5IPgTLA9RB
	RT8kX7b9rAxMqhDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B27F03EA63;
	Mon,  5 Jan 2026 09:56:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jc9CK7mKW2l0SwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 05 Jan 2026 09:56:09 +0000
Message-ID: <ccee668c-88b1-4b06-ba33-1cde63c61ade@suse.cz>
Date: Mon, 5 Jan 2026 10:56:09 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] mm/page_alloc: auto-tune min_free_kbytes on atomic
 allocation failure
To: wujing <realwujing@qq.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>, Lance Yang <lance.yang@linux.dev>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, Qiliang Yuan <yuanql9@chinatelecom.cn>
References: <20260105081720.1308764-1-realwujing@qq.com>
 <tencent_6FE67BA7BE8376AB038A71ACAD4FF8A90006@qq.com>
From: Vlastimil Babka <vbabka@suse.cz>
Content-Language: en-US
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <tencent_6FE67BA7BE8376AB038A71ACAD4FF8A90006@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Score: -4.29
X-Spam-Level: 
X-Spamd-Result: default: False [-4.29 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.19)[-0.963];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_TO(0.00)[qq.com,linux-foundation.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[qq.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid]

On 1/5/26 09:21, wujing wrote:
> Introduce a mechanism to dynamically increase vm.min_free_kbytes when
> critical atomic allocations (GFP_ATOMIC, order-0) fail. This prevents
> recurring network packet drops or other atomic failures by proactively
> reserving more memory.

Were they really packet drops observed? AFAIK the receive is deferred to
non-irq context if those atomic allocations fail, it shouldn't mean a drop.
I also recall the main source of these GFP_ATOMIC failure warnings was
finally silenced some time ago? Maybe we just need more silencing.

Thus I'd be reluctant to proceed unless there's confirmed benefit and
interest from netdev.

As for the implementation I'd rather not be changing min_free_kbytes
directly as that could interact with admin changing that in unpredictable
ways. We already have watermark_boost to dynamically change watermarks (for
other reasons) and seems it would be better to expand that.

> The system increases min_free_kbytes by 50% upon failure, capped at 1%
> of total RAM. To prevent repeated adjustments during burst traffic, a
> 10-second debounce window is enforced.
> 
> After traffic subsides, min_free_kbytes automatically decays by 5% every
> 5 minutes. However, decay stops at 1.2x the initial value rather than
> returning to baseline. This ensures the system "remembers" previous
> pressure patterns and avoids repeated failures under similar load.
> 
> Observed failure logs:
> [38535641.026406] node 0: slabs: 941, objs: 54656, free: 0
> [38535641.037711] node 1: slabs: 349, objs: 22096, free: 272
> [38535641.049025] node 1: slabs: 349, objs: 22096, free: 272
> [38535642.795972] SLUB: Unable to allocate memory on node -1, gfp=0x480020(GFP_ATOMIC)
> [38535642.805017] cache: skbuff_head_cache, object size: 232, buffer size: 256, default order: 2, min order: 0
> [38535642.816311] node 0: slabs: 854, objs: 42320, free: 0
> [38535642.823066] node 1: slabs: 400, objs: 25360, free: 294
> [38535643.070199] SLUB: Unable to allocate memory on node -1, gfp=0x480020(GFP_ATOMIC)
> [38535643.078861] cache: skbuff_head_cache, object size: 232, buffer size: 256, default order: 2, min order: 0
> [38535643.089719] node 0: slabs: 841, objs: 41824, free: 0
> [38535643.096513] node 1: slabs: 393, objs: 24480, free: 272
> [38535643.484149] SLUB: Unable to allocate memory on node -1, gfp=0x480020(GFP_ATOMIC)
> [38535643.492831] cache: skbuff_head_cache, object size: 232, buffer size: 256, default order: 2, min order: 0
> [38535643.503666] node 0: slabs: 898, objs: 43120, free: 159
> [38535643.510140] node 1: slabs: 404, objs: 25424, free: 319
> [38535644.699224] SLUB: Unable to allocate memory on node -1, gfp=0x480020(GFP_ATOMIC)
> [38535644.707911] cache: skbuff_head_cache, object size: 232, buffer size: 256, default order: 2, min order: 0
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
> Signed-off-by: wujing <realwujing@qq.com>
> Signed-off-by: Qiliang Yuan <yuanql9@chinatelecom.cn>
> ---
>  mm/page_alloc.c | 85 +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 85 insertions(+)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index c380f063e8b7..2f12d7a9ecbc 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -30,6 +30,7 @@
>  #include <linux/oom.h>
>  #include <linux/topology.h>
>  #include <linux/sysctl.h>
> +#include <linux/workqueue.h>
>  #include <linux/cpu.h>
>  #include <linux/cpuset.h>
>  #include <linux/pagevec.h>
> @@ -3975,6 +3976,16 @@ static void warn_alloc_show_mem(gfp_t gfp_mask, nodemask_t *nodemask)
>  	mem_cgroup_show_protected_memory(NULL);
>  }
>  
> +/* Auto-tuning min_free_kbytes on atomic allocation failures (v2) */
> +static void decay_min_free_kbytes_workfn(struct work_struct *work);
> +static void boost_min_free_kbytes_workfn(struct work_struct *work);
> +static DECLARE_WORK(boost_min_free_kbytes_work, boost_min_free_kbytes_workfn);
> +static DECLARE_DELAYED_WORK(decay_min_free_kbytes_work, decay_min_free_kbytes_workfn);
> +static unsigned long last_boost_jiffies = 0;
> +static int initial_min_free_kbytes = 0;
> +#define BOOST_DEBOUNCE_MS 10000  /* 10 seconds debounce */
> +
> +
>  void warn_alloc(gfp_t gfp_mask, nodemask_t *nodemask, const char *fmt, ...)
>  {
>  	struct va_format vaf;
> @@ -4947,6 +4958,17 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
>  		goto retry;
>  	}
>  fail:
> +	/* Auto-tuning: trigger boost if atomic allocation fails */
> +	if ((gfp_mask & GFP_ATOMIC) && order == 0) {
> +		unsigned long now = jiffies;
> +		
> +		/* Debounce: only boost once every 10 seconds */
> +		if (time_after(now, last_boost_jiffies + msecs_to_jiffies(BOOST_DEBOUNCE_MS))) {
> +			last_boost_jiffies = now;
> +			schedule_work(&boost_min_free_kbytes_work);
> +		}
> +	}
> +
>  	warn_alloc(gfp_mask, ac->nodemask,
>  			"page allocation failure: order:%u", order);
>  got_pg:
> @@ -6526,6 +6548,10 @@ int __meminit init_per_zone_wmark_min(void)
>  	refresh_zone_stat_thresholds();
>  	setup_per_zone_lowmem_reserve();
>  
> +	/* Save initial value for auto-tuning decay mechanism */
> +	if (initial_min_free_kbytes == 0)
> +		initial_min_free_kbytes = min_free_kbytes;
> +
>  #ifdef CONFIG_NUMA
>  	setup_min_unmapped_ratio();
>  	setup_min_slab_ratio();
> @@ -7682,3 +7708,62 @@ struct page *alloc_pages_nolock_noprof(gfp_t gfp_flags, int nid, unsigned int or
>  	return page;
>  }
>  EXPORT_SYMBOL_GPL(alloc_pages_nolock_noprof);
> +
> +static void boost_min_free_kbytes_workfn(struct work_struct *work)
> +{
> +	int new_min;
> +
> +	/* Cap at 1% of total RAM for safety */
> +	unsigned long total_kbytes = totalram_pages() << (PAGE_SHIFT - 10);
> +	int max_limit = total_kbytes / 100;
> +
> +	/* Responsive increase: 50% instead of doubling */
> +	new_min = min_free_kbytes + (min_free_kbytes / 2);
> +
> +	if (new_min > max_limit)
> +		new_min = max_limit;
> +
> +	if (new_min > min_free_kbytes) {
> +		min_free_kbytes = new_min;
> +		/* Update user_min_free_kbytes so it persists through recalculations */
> +		if (new_min > user_min_free_kbytes)
> +			user_min_free_kbytes = new_min;
> +		
> +		setup_per_zone_wmarks();
> +		
> +		/* Schedule decay after 5 minutes */
> +		schedule_delayed_work(&decay_min_free_kbytes_work, 
> +				      msecs_to_jiffies(300000));
> +		
> +		pr_info("Auto-tuning: atomic failure, increasing min_free_kbytes to %d\n", 
> +			min_free_kbytes);
> +	}
> +}
> +
> +static void decay_min_free_kbytes_workfn(struct work_struct *work)
> +{
> +	int new_min;
> +	int decay_floor;
> +	
> +	/* Decay by 5% */
> +	new_min = min_free_kbytes - (min_free_kbytes / 20);
> +	
> +	/* Don't go below 1.2x initial value (preserve learning effect) */
> +	decay_floor = initial_min_free_kbytes + (initial_min_free_kbytes / 5);
> +	if (new_min < decay_floor)
> +		new_min = decay_floor;
> +	
> +	if (new_min < min_free_kbytes) {
> +		min_free_kbytes = new_min;
> +		user_min_free_kbytes = new_min;
> +		setup_per_zone_wmarks();
> +		
> +		/* Schedule next decay if still above floor */
> +		if (new_min > decay_floor) {
> +			schedule_delayed_work(&decay_min_free_kbytes_work,
> +					      msecs_to_jiffies(300000));
> +		}
> +		
> +		pr_info("Auto-tuning: decaying min_free_kbytes to %d\n", min_free_kbytes);
> +	}
> +}


