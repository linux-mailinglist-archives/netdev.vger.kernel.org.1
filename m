Return-Path: <netdev+bounces-187092-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0223AA4E56
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 16:20:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 216804E8028
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 14:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC2211DD889;
	Wed, 30 Apr 2025 14:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kIHwdswV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C075925A2AF;
	Wed, 30 Apr 2025 14:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746022855; cv=none; b=aYE9pfprv8wsXa24CybCeEeRGxDPljBZYeWEvrkiTEWVzpXLKIc/M9BQXcT6ad40yP9JGD5tcAZMevDCHC01Lg/Q3KYnYPq1/UzdUE40JgSCx7C6ZFSHW978aP8CuD1m23JKvz4wfz+M2AuyxLO+y0BB+oMAJiTbpyF8e8bYohA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746022855; c=relaxed/simple;
	bh=SNye59+q6J7dszg3XbC1nFoBaJJWL336n0A0UOKURjM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ct8ZvKxhkgaEcFbpjiL4oRxPKcSobdiG6SiKd1a4GXkXcdKLuDlU2syLMVzsNmuiBSJUUWFKleiQVJTOSgW+A7vGzTZ5ez4RvDTzMB7IUAf77noAFo0HjRo7nqCsv7bITxwjTBKUHuj4wWzOgWHsP7QIpQAeGiYjq/7yznjU6Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kIHwdswV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B0F7C4CEE7;
	Wed, 30 Apr 2025 14:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746022855;
	bh=SNye59+q6J7dszg3XbC1nFoBaJJWL336n0A0UOKURjM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kIHwdswVPesfFoZt7A0WWlk9I1Cfp+Sppm8022OzrdPVB0syvoZw9xc0lamgq19rA
	 8eBQqXptgLGdmUXDJZstNp6NYDI3mpiXHmebIMLoFeybxyi+IZzY9wSzS0W7AmxHPg
	 IIM9wNkUL8f/RgS9Z+xWUOD2C48S+ptDY5hU2LZf3Sdl4y6kDnO0iywD463n+UdrTs
	 tl7iPULdin+la5ubX2zpjMHo+cHZNJ4Wt2vzXlytwkb0YJb4dzjeqH16eloTpqavt2
	 xgXObB1dE8NvnBn9qaw94hGqhUdcxxYW2h0sZhgSSxXm46dqqlHJoGgqFAyzb5RH3k
	 QfFnHX8SrzI7w==
Message-ID: <b57160d1-e370-43ff-a7ea-cb548e19843c@kernel.org>
Date: Wed, 30 Apr 2025 16:20:49 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 05/18] xdp: Use nested-BH locking for
 system_page_pool
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 netdev@vger.kernel.org, linux-rt-devel@lists.linux.dev
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
 Toke Hoiland Jorgensen <toke@redhat.com>
References: <20250430124758.1159480-1-bigeasy@linutronix.de>
 <20250430124758.1159480-6-bigeasy@linutronix.de>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20250430124758.1159480-6-bigeasy@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Cc. Toke

On 30/04/2025 14.47, Sebastian Andrzej Siewior wrote:
> system_page_pool is a per-CPU variable and relies on disabled BH for its
> locking. Without per-CPU locking in local_bh_disable() on PREEMPT_RT
> this data structure requires explicit locking.
> 
> Make a struct with a page_pool member (original system_page_pool) and a
> local_lock_t and use local_lock_nested_bh() for locking. This change
> adds only lockdep coverage and does not alter the functional behaviour
> for !PREEMPT_RT.
> 
> Cc: Andrew Lunn <andrew+netdev@lunn.ch>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Jesper Dangaard Brouer <hawk@kernel.org>
> Cc: John Fastabend <john.fastabend@gmail.com>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>   include/linux/netdevice.h |  7 ++++++-
>   net/core/dev.c            | 15 ++++++++++-----
>   net/core/xdp.c            | 11 +++++++++--
>   3 files changed, 25 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 2d11d013cabed..2018e2432cb56 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -3502,7 +3502,12 @@ struct softnet_data {
>   };
>   
>   DECLARE_PER_CPU_ALIGNED(struct softnet_data, softnet_data);
> -DECLARE_PER_CPU(struct page_pool *, system_page_pool);
> +
> +struct page_pool_bh {
> +	struct page_pool *pool;
> +	local_lock_t bh_lock;
> +};
> +DECLARE_PER_CPU(struct page_pool_bh, system_page_pool);
>   
>   #ifndef CONFIG_PREEMPT_RT
>   static inline int dev_recursion_level(void)
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 1be7cb73a6024..b56becd070bc7 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -462,7 +462,9 @@ EXPORT_PER_CPU_SYMBOL(softnet_data);
>    * PP consumers must pay attention to run APIs in the appropriate context
>    * (e.g. NAPI context).
>    */
> -DEFINE_PER_CPU(struct page_pool *, system_page_pool);
> +DEFINE_PER_CPU(struct page_pool_bh, system_page_pool) = {
> +	.bh_lock = INIT_LOCAL_LOCK(bh_lock),
> +};
>   
>   #ifdef CONFIG_LOCKDEP
>   /*
> @@ -5238,7 +5240,10 @@ netif_skb_check_for_xdp(struct sk_buff **pskb, const struct bpf_prog *prog)
>   	struct sk_buff *skb = *pskb;
>   	int err, hroom, troom;
>   
> -	if (!skb_cow_data_for_xdp(this_cpu_read(system_page_pool), pskb, prog))
> +	local_lock_nested_bh(&system_page_pool.bh_lock);
> +	err = skb_cow_data_for_xdp(this_cpu_read(system_page_pool.pool), pskb, prog);
> +	local_unlock_nested_bh(&system_page_pool.bh_lock);
> +	if (!err)
>   		return 0;
>   
>   	/* In case we have to go down the path and also linearize,
> @@ -12629,7 +12634,7 @@ static int net_page_pool_create(int cpuid)
>   		return err;
>   	}
>   
> -	per_cpu(system_page_pool, cpuid) = pp_ptr;
> +	per_cpu(system_page_pool.pool, cpuid) = pp_ptr;
>   #endif
>   	return 0;
>   }
> @@ -12759,13 +12764,13 @@ static int __init net_dev_init(void)
>   		for_each_possible_cpu(i) {
>   			struct page_pool *pp_ptr;
>   
> -			pp_ptr = per_cpu(system_page_pool, i);
> +			pp_ptr = per_cpu(system_page_pool.pool, i);
>   			if (!pp_ptr)
>   				continue;
>   
>   			xdp_unreg_page_pool(pp_ptr);
>   			page_pool_destroy(pp_ptr);
> -			per_cpu(system_page_pool, i) = NULL;
> +			per_cpu(system_page_pool.pool, i) = NULL;
>   		}
>   	}
>   
> diff --git a/net/core/xdp.c b/net/core/xdp.c
> index f86eedad586a7..b2a5c934fe7b7 100644
> --- a/net/core/xdp.c
> +++ b/net/core/xdp.c
> @@ -737,10 +737,10 @@ static noinline bool xdp_copy_frags_from_zc(struct sk_buff *skb,
>    */
>   struct sk_buff *xdp_build_skb_from_zc(struct xdp_buff *xdp)
>   {
> -	struct page_pool *pp = this_cpu_read(system_page_pool);
>   	const struct xdp_rxq_info *rxq = xdp->rxq;
>   	u32 len = xdp->data_end - xdp->data_meta;
>   	u32 truesize = xdp->frame_sz;
> +	struct page_pool *pp;
>   	struct sk_buff *skb;
>   	int metalen;
>   	void *data;
> @@ -748,13 +748,18 @@ struct sk_buff *xdp_build_skb_from_zc(struct xdp_buff *xdp)
>   	if (!IS_ENABLED(CONFIG_PAGE_POOL))
>   		return NULL;
>   
> +	local_lock_nested_bh(&system_page_pool.bh_lock);
> +	pp = this_cpu_read(system_page_pool.pool);
>   	data = page_pool_dev_alloc_va(pp, &truesize);
> -	if (unlikely(!data))
> +	if (unlikely(!data)) {
> +		local_unlock_nested_bh(&system_page_pool.bh_lock);
>   		return NULL;
> +	}
>   
>   	skb = napi_build_skb(data, truesize);
>   	if (unlikely(!skb)) {
>   		page_pool_free_va(pp, data, true);
> +		local_unlock_nested_bh(&system_page_pool.bh_lock);
>   		return NULL;
>   	}
>   
> @@ -773,9 +778,11 @@ struct sk_buff *xdp_build_skb_from_zc(struct xdp_buff *xdp)
>   
>   	if (unlikely(xdp_buff_has_frags(xdp)) &&
>   	    unlikely(!xdp_copy_frags_from_zc(skb, xdp, pp))) {
> +		local_unlock_nested_bh(&system_page_pool.bh_lock);
>   		napi_consume_skb(skb, true);
>   		return NULL;
>   	}
> +	local_unlock_nested_bh(&system_page_pool.bh_lock);
>   
>   	xsk_buff_free(xdp);
>   

