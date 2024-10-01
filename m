Return-Path: <netdev+bounces-130830-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF1A98BB10
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 13:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5196D282639
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 11:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AAC7198A1B;
	Tue,  1 Oct 2024 11:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QEdy2Djt"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19A43201
	for <netdev@vger.kernel.org>; Tue,  1 Oct 2024 11:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727782227; cv=none; b=N+ikuPTSWEmNnq5z9Ypp7G2LlO4Zskcdg+0lm3jHGMCM2OWw8cxAVmEK7sgG233TfdxS030FD51XRj5HuMOvXdC7X8UhRUxtM66Jwb45MSHynk2q0srE0Efon8JAbulXXxgdhWZDdTkiJmDV90jMliSLCpeIUp8I/qzMyn+m//Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727782227; c=relaxed/simple;
	bh=Ys9Sd2aPKxkYKrGlFqCt6TVaVUyI2s8ItMM+HGrJFTY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ee8zRoiQ+PxKUYuIb9bB/eH/bmXzMgt+pMcTRmTcn/aOHXROc6lu6xD/VMq339f1Zud0n7qLIB5ntpg17mRzqMZnL6cYe3zN5fMfVjqrlC5Gnrnb5UIpwLIdr8A/M/It2Mk7sIgiaRv9QaBWrxvB2jfRG8tRuYwSxS8wIwATtVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QEdy2Djt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727782224;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O2mDsXREzXzYDDrxWWDdEz3C0mgnK+3AvJmlok3UtE4=;
	b=QEdy2DjtjXTasHKO8yuYTyGvrMN1U8dtawrHs7+uQJWaFU57mvXoPrMdRYfoaLb7J/it0N
	dnbIxCjA8hypYr3L000dqs8yfMqyC/Vsh6BPhyQrL9ZlTCUtRw84Kr0y2pDvS92gAK7/uP
	m3kXjK/e7p5zcVAmeQIiwamz7/YXbIk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-47-A7TrjLqzN_SYRI1_uYJZ6w-1; Tue, 01 Oct 2024 07:30:23 -0400
X-MC-Unique: A7TrjLqzN_SYRI1_uYJZ6w-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42cb998fd32so35663735e9.1
        for <netdev@vger.kernel.org>; Tue, 01 Oct 2024 04:30:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727782222; x=1728387022;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O2mDsXREzXzYDDrxWWDdEz3C0mgnK+3AvJmlok3UtE4=;
        b=kHCOfchCfg9jhfjx8nj0PCfXiAMuwVPqHrF9SbhDQfzhqrgHmiWDVhzxLYr58E4P4Y
         2SiWVKDUg2bkx4X/DEHG+n7Bt/U19Ik5WYw+W8YRo65uejXQu4gTOFtvQQdw6gfsiiUv
         MtrXtbDWnEzIgnh5Tcj0scHwyz8dpxb6TGpd6GPLJdv9O3rxtyN56G39FrjvVObQzjZx
         tp4/vT4r79GRWCjWvqFHk4u5ZnZYXoedtO8nOOgM0+zZV2WMWXPhdKeakruKqOff5s8M
         SwTf/SOxYaaEEcXsMNn5eSnBtVzKVf7NHSbwdMt/z9napKLnlCanCcdsr8mf5aSgxNQK
         HlwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHGQoMsmtIzU97skfjCiqTRAzP0FV0uv5i8IHVlGnmIVAQSfDDGpgB/KjwgbahLn5/V9UWJ0k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yws6b+Rzq1XG3LqmYAWB5TB0uO/TSddH/rAgqpPooNDmWFilvJy
	eemPwaxM5zCV4zFL7e3fi1DSnQSqfLdtXStYECX2nkUfLApsECLv01F/CKmUCaGU5MvU1BHmaEc
	6rPeyFaKrq9pJlgvw8NhYyxI6BLOpda+FZ1VOc1ASIdqw6IR8W/sZTQ==
X-Received: by 2002:a05:600c:4f43:b0:42c:b1f0:f67 with SMTP id 5b1f17b1804b1-42f5847e2admr98374895e9.27.1727782221940;
        Tue, 01 Oct 2024 04:30:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGckLGqK0+s8AtVOIG0zFH9HXz2DiAI/CofuS4IpUg1+KNNYDro8uDWJgWW2VGjuNu0CPYCrg==
X-Received: by 2002:a05:600c:4f43:b0:42c:b1f0:f67 with SMTP id 5b1f17b1804b1-42f5847e2admr98374695e9.27.1727782221472;
        Tue, 01 Oct 2024 04:30:21 -0700 (PDT)
Received: from ?IPV6:2a0d:3341:b088:b810:c085:e1b4:9ce7:bb1c? ([2a0d:3341:b088:b810:c085:e1b4:9ce7:bb1c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e96a36244sm179379295e9.38.2024.10.01.04.30.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Oct 2024 04:30:21 -0700 (PDT)
Message-ID: <d123d288-4215-4a8c-9689-bbfe24c24b08@redhat.com>
Date: Tue, 1 Oct 2024 13:30:19 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 1/2] page_pool: fix timing for checking and
 disabling napi_local
To: Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net,
 kuba@kernel.org
Cc: liuyonglong@huawei.com, fanghaiqing@huawei.com, zhangkun09@huawei.com,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240925075707.3970187-1-linyunsheng@huawei.com>
 <20240925075707.3970187-2-linyunsheng@huawei.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240925075707.3970187-2-linyunsheng@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/25/24 09:57, Yunsheng Lin wrote:
> page_pool page may be freed from skb_defer_free_flush() to
> softirq context, it may cause concurrent access problem for
> pool->alloc cache due to the below time window, as below,
> both CPU0 and CPU1 may access the pool->alloc cache
> concurrently in page_pool_empty_alloc_cache_once() and
> page_pool_recycle_in_cache():
> 
>            CPU 0                           CPU1
>      page_pool_destroy()          skb_defer_free_flush()
>             .                               .
>             .                   page_pool_put_unrefed_page()
>             .                               .
>             .               allow_direct = page_pool_napi_local()
>             .                               .
> page_pool_disable_direct_recycling()       .
>             .                               .
> page_pool_empty_alloc_cache_once() page_pool_recycle_in_cache()
> 
> Use rcu mechanism to avoid the above concurrent access problem.
> 
> Note, the above was found during code reviewing on how to fix
> the problem in [1].
> 
> 1. https://lore.kernel.org/lkml/8067f204-1380-4d37-8ffd-007fc6f26738@kernel.org/T/
> 
> Fixes: dd64b232deb8 ("page_pool: unlink from napi during destroy")
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> CC: Alexander Lobakin <aleksander.lobakin@intel.com>
> ---
>   net/core/page_pool.c | 31 ++++++++++++++++++++++++++++---
>   1 file changed, 28 insertions(+), 3 deletions(-)
> 
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index a813d30d2135..bec6e717cd22 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -818,8 +818,17 @@ static bool page_pool_napi_local(const struct page_pool *pool)
>   void page_pool_put_unrefed_netmem(struct page_pool *pool, netmem_ref netmem,
>   				  unsigned int dma_sync_size, bool allow_direct)
>   {
> -	if (!allow_direct)
> +	bool allow_direct_orig = allow_direct;
> +
> +	/* page_pool_put_unrefed_netmem() is not supposed to be called with
> +	 * allow_direct being true after page_pool_destroy() is called, so
> +	 * the allow_direct being true case doesn't need synchronization.
> +	 */
> +	DEBUG_NET_WARN_ON_ONCE(allow_direct && pool->destroy_cnt);
> +	if (!allow_direct_orig) {
> +		rcu_read_lock();
>   		allow_direct = page_pool_napi_local(pool);
> +	}
>   
>   	netmem =
>   		__page_pool_put_page(pool, netmem, dma_sync_size, allow_direct);
> @@ -828,6 +837,9 @@ void page_pool_put_unrefed_netmem(struct page_pool *pool, netmem_ref netmem,
>   		recycle_stat_inc(pool, ring_full);
>   		page_pool_return_page(pool, netmem);
>   	}
> +
> +	if (!allow_direct_orig)
> +		rcu_read_unlock();

What about always acquiring the rcu lock? would that impact performances 
negatively?

If not, I think it's preferable, as it would make static checker happy.

>   }
>   EXPORT_SYMBOL(page_pool_put_unrefed_netmem);
>   

[...]

> @@ -1121,6 +1140,12 @@ void page_pool_destroy(struct page_pool *pool)
>   		return;
>   
>   	page_pool_disable_direct_recycling(pool);
> +
> +	/* Wait for the freeing side see the disabling direct recycling setting
> +	 * to avoid the concurrent access to the pool->alloc cache.
> +	 */
> +	synchronize_rcu();

When turning on/off a device with a lot of queues, the above could 
introduce a lot of long waits under the RTNL lock, right?

What about moving the trailing of this function in a separate helper and 
use call_rcu() instead?

Thanks!

Paolo


> +
>   	page_pool_free_frag(pool);
>   
>   	if (!page_pool_release(pool))


