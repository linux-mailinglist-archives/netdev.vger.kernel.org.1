Return-Path: <netdev+bounces-49785-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05DFB7F37AF
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 21:46:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36B601C20848
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 20:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A054F3D972;
	Tue, 21 Nov 2023 20:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fErFud09"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8481F55768
	for <netdev@vger.kernel.org>; Tue, 21 Nov 2023 20:46:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FA2CC433C7;
	Tue, 21 Nov 2023 20:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700599562;
	bh=a1sQtVgiN34uaDlR/eNDPVdjc4FwWW9xIzBiVVc4bdg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fErFud099Ewsx8jV+F88xrhcKpuwv1lcSJG9l8hVbGpG1AOdHA/oAnyXjPKMEUP4H
	 t3m0+Mn1KP+GWreB/tA7jtp51D0oqbZOmwTThNaLZ8I2Y/Ups6+9yaRm8hgXUywxrs
	 JsrnSiC6aDT67ZhiGwvdyyl6QnDOD40p6am6ptbV2Le0Gf2HzbYDsIgF71oMXA6vXh
	 7NsNXeAv9VWcs6FLCyDHXTiyb2oSxK1qVYTQfrHCPHpHfp0U9vNBljiQWTTS6Kd93b
	 4e+Ytov5r5EfZldN4sPdPshMSDGN++Jjmoy+bDzzKeauYGBfuB5JdUaivg7VrBp+TP
	 MtbuuOoD6CDJw==
Message-ID: <e64de1a2-a9c6-43e0-8036-7be7fbf18d52@kernel.org>
Date: Tue, 21 Nov 2023 21:45:57 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 12/15] net: page_pool: report when page pool
 was destroyed
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 almasrymina@google.com, ilias.apalodimas@linaro.org, dsahern@gmail.com,
 dtatulea@nvidia.com, kernel-team <kernel-team@cloudflare.com>
References: <20231121000048.789613-1-kuba@kernel.org>
 <20231121000048.789613-13-kuba@kernel.org>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20231121000048.789613-13-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/21/23 01:00, Jakub Kicinski wrote:

> Report when page pool was destroyed. Together with the inflight
> / memory use reporting this can serve as a replacement for the
> warning about leaked page pools we currently print to dmesg.
>
> Example output for a fake leaked page pool using some hacks
> in netdevsim (one "live" pool, and one "leaked" on the same dev):
>
> $ ./cli.py --no-schema --spec netlink/specs/netdev.yaml \
>             --dump page-pool-get
> [{'id': 2, 'ifindex': 3},
>   {'id': 1, 'ifindex': 3, 'destroyed': 133, 'inflight': 1}]
>
> Tested-by: Dragos Tatulea <dtatulea@nvidia.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>   Documentation/netlink/specs/netdev.yaml |  9 +++++++++
>   include/net/page_pool/types.h           |  1 +
>   include/uapi/linux/netdev.h             |  1 +
>   net/core/page_pool.c                    |  1 +
>   net/core/page_pool_priv.h               |  1 +
>   net/core/page_pool_user.c               | 12 ++++++++++++
>   6 files changed, 25 insertions(+)
>
> diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
> index 85209e19dca9..8dafa2a8a4dd 100644
> --- a/Documentation/netlink/specs/netdev.yaml
> +++ b/Documentation/netlink/specs/netdev.yaml
> @@ -125,6 +125,14 @@ name: netdev
>           type: uint
>           doc: |
>             Amount of memory held by inflight pages.
> +      -
> +        name: destroyed
> +        type: uint
> +        doc: |
> +          Seconds in CLOCK_BOOTTIME of when Page Pool was destroyed.
> +          Page Pools wait for all the memory allocated from them to be freed
> +          before truly disappearing.
> +          Absent if Page Pool hasn't been destroyed.
>   
>   operations:
>     list:
> @@ -176,6 +184,7 @@ name: netdev
>               - napi-id
>               - inflight
>               - inflight-mem
> +            - destroyed
>         dump:
>           reply: *pp-reply
>         config-cond: page-pool
> diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
> index 7e47d7bb2c1e..f0c51ef5e345 100644
> --- a/include/net/page_pool/types.h
> +++ b/include/net/page_pool/types.h
> @@ -193,6 +193,7 @@ struct page_pool {
>   	/* User-facing fields, protected by page_pools_lock */
>   	struct {
>   		struct hlist_node list;
> +		u64 destroyed;
>   		u32 napi_id;
>   		u32 id;
>   	} user;
> diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
> index 26ae5bdd3187..e5bf66d2aa31 100644
> --- a/include/uapi/linux/netdev.h
> +++ b/include/uapi/linux/netdev.h
> @@ -70,6 +70,7 @@ enum {
>   	NETDEV_A_PAGE_POOL_NAPI_ID,
>   	NETDEV_A_PAGE_POOL_INFLIGHT,
>   	NETDEV_A_PAGE_POOL_INFLIGHT_MEM,
> +	NETDEV_A_PAGE_POOL_DESTROYED,
>   
>   	__NETDEV_A_PAGE_POOL_MAX,
>   	NETDEV_A_PAGE_POOL_MAX = (__NETDEV_A_PAGE_POOL_MAX - 1)
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index 566390759294..0f3f525c457a 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -953,6 +953,7 @@ void page_pool_destroy(struct page_pool *pool)
>   	if (!page_pool_release(pool))
>   		return;
>   
> +	page_pool_destroyed(pool);
Hmm, this is called when kernel could *NOT* destroy the PP, but have to 
start a work-queue that will retry deleting this. Thus, I think naming 
this "destroyed" is confusing as I then assumed was successfully 
destroyed, but it is not, instead it is on "deathrow".


>   	pool->defer_start = jiffies;
>   	pool->defer_warn  = jiffies + DEFER_WARN_INTERVAL;
>   
> diff --git a/net/core/page_pool_priv.h b/net/core/page_pool_priv.h
> index 72fb21ea1ddc..7fe6f842a270 100644
> --- a/net/core/page_pool_priv.h
> +++ b/net/core/page_pool_priv.h
> @@ -6,6 +6,7 @@
>   s32 page_pool_inflight(const struct page_pool *pool, bool strict);
>   
>   int page_pool_list(struct page_pool *pool);
> +void page_pool_destroyed(struct page_pool *pool);
>   void page_pool_unlist(struct page_pool *pool);
>   
>   #endif
> diff --git a/net/core/page_pool_user.c b/net/core/page_pool_user.c
> index d889b347f8f4..d0f778f358fc 100644
> --- a/net/core/page_pool_user.c
> +++ b/net/core/page_pool_user.c
> @@ -134,6 +134,10 @@ page_pool_nl_fill(struct sk_buff *rsp, const struct page_pool *pool,
>   	    nla_put_uint(rsp, NETDEV_A_PAGE_POOL_INFLIGHT_MEM,
>   			 inflight * refsz))
>   		goto err_cancel;
> +	if (pool->user.destroyed &&
> +	    nla_put_uint(rsp, NETDEV_A_PAGE_POOL_DESTROYED,
> +			 pool->user.destroyed))
> +		goto err_cancel;
>   
>   	genlmsg_end(rsp, hdr);
>   
> @@ -219,6 +223,14 @@ int page_pool_list(struct page_pool *pool)
>   	return err;
>   }
>   
> +void page_pool_destroyed(struct page_pool *pool)
> +{
> +	mutex_lock(&page_pools_lock);
> +	pool->user.destroyed = ktime_get_boottime_seconds();
> +	netdev_nl_page_pool_event(pool, NETDEV_CMD_PAGE_POOL_CHANGE_NTF);

Could we place this PP instance on another list of PP instances about to 
be deleted?

(e.g. a deathrow or sched_destroy list)


Perhaps this could also allow us to list those PP instances that 
no-longer have a netdev associated?


> +	mutex_unlock(&page_pools_lock);
> +}


