Return-Path: <netdev+bounces-30121-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 874097860E5
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 21:45:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F5252813E2
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 19:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61A861FB46;
	Wed, 23 Aug 2023 19:45:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9201FB45
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 19:45:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 798CBC433C9;
	Wed, 23 Aug 2023 19:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692819911;
	bh=mVfYjfAer7LGb5obJ89lMIm5KMc02IYUnhx8PdVsGNE=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=et+Bzz/F9mxExjLRmSYRl/hkjiavTSsD7i8rcfzHNWpdfAIIgJ4HLOIEflfLtYSVO
	 11MhtzxJavZfFfTlr+b6G9WePIrSaagwRvyQFvu2oTKtXiIK9VJgMslS0p99pw49K/
	 KnegU50coXMGCDd5bKFlPZqTEf8Ft9ACd5fbrpzTRpMaEI9OMhafGdrffulxgWaYGV
	 BxmLTYRlo3q5kwJgYN7jIjqzoHIsvEI7phX5EwY5Kkdxi26JO9U+3DretSiB+CIrjb
	 97ZgDI5ksilFI37S3V4v85IaJ55Dyy6LvwgHxXXIQ0xQHKGYq558q+sx7sk7yySEdU
	 DZYdzxtK0V7aA==
Message-ID: <d34d4c1c-2436-3d4c-268c-b971c9cc473f@kernel.org>
Date: Wed, 23 Aug 2023 21:45:04 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Geetha sowjanya <gakula@marvell.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Subbaraya Sundeep <sbhatta@marvell.com>,
 Sunil Goutham <sgoutham@marvell.com>, Thomas Gleixner <tglx@linutronix.de>,
 hariprasad <hkelam@marvell.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Qingfang DENG <qingfang.deng@siflower.com.cn>
Subject: Re: [BUG] Possible unsafe page_pool usage in octeontx2
Content-Language: en-US
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 netdev@vger.kernel.org, Ratheesh Kannoth <rkannoth@marvell.com>
References: <20230823094757.gxvCEOBi@linutronix.de>
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20230823094757.gxvCEOBi@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

(Cc Olek as he have changes in this code path)

On 23/08/2023 11.47, Sebastian Andrzej Siewior wrote:
> Hi,
> 
> I've been looking at the page_pool locking.
> 
> page_pool_alloc_frag() -> page_pool_alloc_pages() ->
> __page_pool_get_cached():
> 
> There core of the allocation is:
> |         /* Caller MUST guarantee safe non-concurrent access, e.g. softirq */
> |         if (likely(pool->alloc.count)) {
> |                 /* Fast-path */
> |                 page = pool->alloc.cache[--pool->alloc.count];
> 
> The access to the `cache' array and the `count' variable is not locked.
> This is fine as long as there only one consumer per pool. In my
> understanding the intention is to have one page_pool per NAPI callback
> to ensure this.
> 

Yes, the intention is a single PP instance is "bound" to one RX-NAPI.


> The pool can be filled in the same context (within allocation if the
> pool is empty). There is also page_pool_recycle_in_cache() which fills
> the pool from within skb free, for instance:
>   napi_consume_skb() -> skb_release_all() -> skb_release_data() ->
>   napi_frag_unref() -> page_pool_return_skb_page().
> 
> The last one has the following check here:
> |         napi = READ_ONCE(pp->p.napi);
> |         allow_direct = napi_safe && napi &&
> |                 READ_ONCE(napi->list_owner) == smp_processor_id();
> 
> This eventually ends in page_pool_recycle_in_cache() where it adds the
> page to the cache buffer if the check above is true (and BH is disabled).
> 
> napi->list_owner is set once NAPI is scheduled until the poll callback
> completed. It is safe to add items to list because only one of the two
> can run on a single CPU and the completion of them ensured by having BH
> disabled the whole time.
> 
> This breaks in octeontx2 where a worker is used to fill the buffer:
>    otx2_pool_refill_task() -> otx2_alloc_rbuf() -> __otx2_alloc_rbuf() ->
>    otx2_alloc_pool_buf() -> page_pool_alloc_frag().
> 

This seems problematic! - this is NOT allowed.

But otx2_pool_refill_task() is a work-queue, and I though it runs in
process-context.  This WQ process is not allowed to use the lockless PP
cache.  This seems to be a bug!

The problematic part is otx2_alloc_rbuf() that disables BH:

  int otx2_alloc_rbuf(struct otx2_nic *pfvf, struct otx2_pool *pool,
		    dma_addr_t *dma)
  {
	int ret;

	local_bh_disable();
	ret = __otx2_alloc_rbuf(pfvf, pool, dma);
	local_bh_enable();
	return ret;
  }

The fix, can be to not do this local_bh_disable() in this driver?

> BH is disabled but the add of a page can still happen while NAPI
> callback runs on a remote CPU and so corrupting the index/ array.
> 
> API wise I would suggest to
> 
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index 7ff80b80a6f9f..b50e219470a36 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -612,7 +612,7 @@ __page_pool_put_page(struct page_pool *pool, struct page *page,
>   			page_pool_dma_sync_for_device(pool, page,
>   						      dma_sync_size);
>   
> -		if (allow_direct && in_softirq() &&
> +		if (allow_direct && in_serving_softirq() &&

This is the "return/free/put" code path, where we have "allow_direct" as
a protection in the API.  API users are suppose to use
page_pool_recycle_direct() to indicate this, but as some point we
allowed APIs to expose 'allow_direct'.

The PP-alloc side is more fragile, and maybe the in_serving_softirq()
belongs there.

>   		    page_pool_recycle_in_cache(page, pool))
>   			return NULL;
>   
> because the intention (as I understand it) is to be invoked from within
> the NAPI callback (while softirq is served) and not if BH is just
> disabled due to a lock or so.
>

True, and it used-to-be like this (in_serving_softirq), but as Ilias
wrote it was changed recently.  This was to support threaded-NAPI (in
542bcea4be866b ("net: page_pool: use in_softirq() instead")), which
I understood was one of your (Sebastian's) use-cases.


> It would also make sense to a add WARN_ON_ONCE(!in_serving_softirq()) to
> page_pool_alloc_pages() to spot usage outside of softirq. But this will
> trigger in every driver since the same function is used in the open
> callback to initially setup the HW.
> 

I'm very open to ideas of detecting this.  Since mentioned commit PP is
open to these kind of miss-uses of the API.

One idea would be to leverage that NAPI napi->list_owner will have been
set to something else than -1, when this is NAPI context.  Getting hold
of napi object, could be done via pp->p.napi (but as Jakub wrote this is
opt-in ATM).

--Jesper

