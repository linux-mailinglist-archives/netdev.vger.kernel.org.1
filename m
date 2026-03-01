Return-Path: <netdev+bounces-262390-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id X/A/LgIipGmMYAUAu9opvQ
	(envelope-from <netdev+bounces-262390-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 12:24:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A1B1CF4E1
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 12:24:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CCBCD3013EFB
	for <lists+netdev@lfdr.de>; Sun,  1 Mar 2026 11:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12AA92D738A;
	Sun,  1 Mar 2026 11:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TfJ3eAq/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A7919EED3
	for <netdev@vger.kernel.org>; Sun,  1 Mar 2026 11:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772364286; cv=none; b=kW+cdQ4rwQT7AZz4FK18YU69XbIabufPnJtF69u4sb6aluqFZXGgVdFLqZpxFQtzOdnF60BpcF2SYQ1dDNGiJ1Qx3BpzaD3f+p7mUavzDUzRhqnpywtXalInQLHMkvoT2+bHSSiMG4WYj3fqmmG9eBvhbLM5BReZUk/sd981NJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772364286; c=relaxed/simple;
	bh=rw8fm1QBFBlYpvs0lvKeEaHr3iU1o700icBZixujDgs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LrZQhKL5fxPLpXBci7w6sfWn6cKQULNRGSrUZWVg0WwTVKDbiX5IU2wvgjnnLnZSJ63lHrjDr5acXZmOuNCKfZicIEjSWk8cUEh5kpAxmk9+e72+wFAM0jc30yWJ+SHJzndNFMh+xaTAa0WEJNxMGEwgDxKpHiyTczqFHhpRcY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TfJ3eAq/; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-483708b697cso4053735e9.3
        for <netdev@vger.kernel.org>; Sun, 01 Mar 2026 03:24:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1772364283; x=1772969083; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bl4aZfTNKgTxCzAwFVHIT8LFNEV2L78bSM6cZ8P+v2s=;
        b=TfJ3eAq/wmzDnkgXFgRKIeH2DbByxjkq0JPNGhOWMnbZpgtqK8dK+woDUWURVnF82f
         DMvxI7ESmDsbsYW8Vh7wizFuQisvhWNpczCgcnOUqIIzhGr7qapT5pvPmwUVVkavuyuS
         U6G61hk11N9eK+I4Lj5KJRPHbuc57iEZx8Nmypnc1KL1Si0vIYBwSjptw0k0AIexRtgi
         4eIhmgZpuB82ALMP0Las7OieWMCmzkkAQj4PDJG61YPjrDmxPpx0l6D0KUXxMTIny5YX
         O8aUrm9WjskgI/JHyi3Un+IPCwXx7+CDr/kur5b61N9I6zln2bL5xyj+Kw5QyNwuvSWK
         BVtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772364283; x=1772969083;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bl4aZfTNKgTxCzAwFVHIT8LFNEV2L78bSM6cZ8P+v2s=;
        b=Ot0MtqPKL12HG4aDACNUwtx2bUaz51VqHvL84IYFs3AmtHYbVWEZehvhFRh1NpQsEm
         cKTfR6AqWMcCb9FZXsjZnI2GsOmhRzE1WHAqKDmmIY+eZcmo83MNArg7Zv4gM3E3mFEF
         YpiYEwTSVKW8I5yBtUEeVCkJgDShZ+ZAC0UhgSYdJxZl583Jgspj7wDHqpI0wwPJQqK6
         v/V3ckLWxDbWN4VojabGrBXaq416Awt+xF2+jt4zKbE8gxV1mUptd6YHE6bbDN6dlmZw
         KCGZnkTOoqZMCXFpeW95AN491ExNl+Dd5cmEgnWxBHnF0YeTrrbNmgWOHk6OnyAInWQ5
         cu1g==
X-Forwarded-Encrypted: i=1; AJvYcCWzvaJWyABkOZ7EFP0/IefXn44cW0+B4a2nLR6llpaYMSAdr6aHWvr9nP7OMNHG+babU6vB4ng=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxwYfTH0ILaiPwMqJA6TxI955caLek1cQo1bQerX9zMH2XgmVc
	6qbZZZnPreObUKDyBRGDEeUyvhedJLg4MpILt03E1L3rJaGYglgW6nLjS+i1YynbkFA=
X-Gm-Gg: ATEYQzz1FldA/1O4rSZt7gseNBa6QG+d8/LPMOIxC4hpsI5ZWbJRphvQZoRtUBKBzpN
	9KNPmreU8Uzr18MfrF2JrnDdy4IM8+KMn8cnyr8Doj3ZjHlqi8JY0GfjmXnAxwUMUeQf5Lot6eB
	ynxZQDVHIiySycwDRShPYghQwMWBYGaRf0wXxn8HdtqYkTty/ESHdAGcVamOEWpL5g+XB0IvZKc
	0RpGZ3cang2bXLdCHstZ+GTIiiYCw/mvp4SaIpnEs3OvSZoJAzspmgldVXxZdUUSNGVrXcosX6H
	tm6LwigyO2/OSfmS3zKpevg12b0n7yTucbf5FYYJjv7XGT4oCNGOs4TlBxQieibPIejbcOfR1bu
	kAreMRUU+l7flcs+3YVpHDJ0qirzhQVXRVtDRmZ2smqZO2Wu6UvQ3f77pa1XXci6r/WDuQNKt9i
	cZg1F2GpivvS4kJB3IOuGSczICe2tM1LmBF0DFTTy4m7z6AkA289HcZOSonQ==
X-Received: by 2002:a05:600c:1d1a:b0:480:1f6b:d4a2 with SMTP id 5b1f17b1804b1-483c9c32c36mr87984125e9.7.1772364282573;
        Sun, 01 Mar 2026 03:24:42 -0800 (PST)
Received: from ?IPV6:2001:1a48:8:903:1ed6:4f73:ce38:f9d4? ([2001:1a48:8:903:1ed6:4f73:ce38:f9d4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bfcb4f8bsm257802705e9.4.2026.03.01.03.24.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Mar 2026 03:24:42 -0800 (PST)
Message-ID: <31a14f1c-7d20-4b0f-a039-9e034762ed98@suse.com>
Date: Sun, 1 Mar 2026 12:24:41 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: adopt SLUB sheaves for skbuff_small_head
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com,
 Vlastimil Babka <vbabka@suse.cz>, David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>,
 Hao Li <hao.li@linux.dev>
References: <20260228141252.435509-1-edumazet@google.com>
From: Vlastimil Babka <vbabka@suse.com>
In-Reply-To: <20260228141252.435509-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com,suse.cz,linux.dev,oracle.com];
	TAGGED_FROM(0.00)[bounces-262390-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vbabka@suse.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:email]
X-Rspamd-Queue-Id: 24A1B1CF4E1
X-Rspamd-Action: no action

On 2/28/26 15:12, Eric Dumazet wrote:
> skbuff_small_head is used both on receive and send paths,
> serving potentially 80 million allocations and frees per second.
> 
> Tuning it on large servers has been problematic, especially
> on AMD Turins platforms, where "lock cmpxch16b" latency can
> be over 30,000 cycles.

Huh, really? That sounds insane. Any pointers about that?

> Switching to SLUB sheaves fixes the issue nicely.
> 
> tcp_rr benchmark with 10,000 flows goes from 25 Mpps to 40 Mpps
> on AMD Turin.
> 
> Other platforms show benefits with tcp_rr with more than 30,000
> flows.

That's nice, thanks!

However I must point out some caveates. I assume you did this on 6.19, where
sheaves are still opt-in. But also, when you opt-in, the pre-existing
per-cpu caching layer of percpu slab and percpu partial slabs is also still
there, so effectively the amount of percpu cached slab objects increase,
which can be the main performance difference for some workloads, and not the
difference between sheaves and percpu (partial) slabs implementation.

Note: but hopefully for your workload it's really the implementation.
"(lock) cmpxch16b" should be avoided, until you start freeing NUMA-remote
(to the freeing cpu) objects in significant volumes.

In 7.0-rc1 sheaves are enabled for every cache automatically, and cpu
(partial) caches are gone completely. Their size is calculated to roughly
match the average amount of percpu caching the old scheme achieved (but that
effectively depended on the workload too, so can't be exactly translated)
and the result is visible in /sys/kernel/slab/$cache/sheaf_capacity
the args.sheaf_capacity can override that automatic sizing, if the specified
one is larger.

So what I would suggest is checking the performance betwen 6.19 and 7.0-rc1
without this patch (hope there won't be any other factors in the upgrade
influencing this much), noting the auto-calculated capacity. If it still
looks good, you don't need to do anything, otherwise you can try making the
capacity larger and see what happens.

> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Roman Gushchin <roman.gushchin@linux.dev>
> ---
>  net/core/skbuff.c | 31 ++++++++++++++++++++-----------
>  1 file changed, 20 insertions(+), 11 deletions(-)
> 
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 513cbfed19bc34bbb6767cdd7a50dad68be430fb..79eb7eb6eea9aa4a76c555e6ddd33bf0bc84c921 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -5174,6 +5174,19 @@ static void skb_extensions_init(void) {}
>  
>  void __init skb_init(void)
>  {
> +	struct kmem_cache_args kmem_args_small_head = {
> +		.align		= 0,
> +		.ctor		= NULL,
> +		/* usercopy should only access first SKB_SMALL_HEAD_HEADROOM
> +		 * bytes.
> +		 * struct skb_shared_info is located at the end of skb->head,
> +		 * and should not be copied to/from user.
> +		 */
> +		.useroffset	= 0,
> +		.usersize	= SKB_SMALL_HEAD_HEADROOM,
> +		.sheaf_capacity = 32,
> +	};
> +
>  	net_hotdata.skbuff_cache = kmem_cache_create_usercopy("skbuff_head_cache",
>  					      sizeof(struct sk_buff),
>  					      0,
> @@ -5189,17 +5202,13 @@ void __init skb_init(void)
>  						0,
>  						SLAB_HWCACHE_ALIGN|SLAB_PANIC,
>  						NULL);
> -	/* usercopy should only access first SKB_SMALL_HEAD_HEADROOM bytes.
> -	 * struct skb_shared_info is located at the end of skb->head,
> -	 * and should not be copied to/from user.
> -	 */
> -	net_hotdata.skb_small_head_cache = kmem_cache_create_usercopy("skbuff_small_head",
> -						SKB_SMALL_HEAD_CACHE_SIZE,
> -						0,
> -						SLAB_HWCACHE_ALIGN | SLAB_PANIC,
> -						0,
> -						SKB_SMALL_HEAD_HEADROOM,
> -						NULL);
> +
> +	net_hotdata.skb_small_head_cache = kmem_cache_create(
> +			"skbuff_small_head",
> +			SKB_SMALL_HEAD_CACHE_SIZE,
> +			&kmem_args_small_head,
> +			SLAB_HWCACHE_ALIGN | SLAB_PANIC);
> +
>  	skb_extensions_init();
>  }
>  


