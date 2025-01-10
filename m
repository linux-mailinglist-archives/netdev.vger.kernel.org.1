Return-Path: <netdev+bounces-157199-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 778D4A09601
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 16:40:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BA30188BC36
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 15:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 315F3211A00;
	Fri, 10 Jan 2025 15:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V1BNEYYH"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E88D2116F2
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 15:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736523620; cv=none; b=B6E/Q1ehnzggJ44c+VqH7Zx7VPaSuWXRah6lwlsi1KmOs5/JdwXaMIfBbgXIa2o/AaaYKrKWqpwyGCjlbiqrCEjm6PntL9qCMTfFBhUpg5qxUzq+HB0Rf43ZEyDtV58yB54t/A9C2IP9AVm/7bnAoqUnHHxLEMjpOf4Aq/+LX3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736523620; c=relaxed/simple;
	bh=RnO19E44g6ReuoZLCuQDTZH0FF8D/2faSTxLXlhboBg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=G9dG7BzdRo47kAtghQgTaw07/bPtHLm3JnRoQqIuSPVlJTjHuwjWiydMOjJ6A3AZnmeLiaHIXTry1ZfO33aZGa7DldpwO+XyTsllAGO7kH58wPzvlij1+RvRtS1FmGQSsWXuMwIcTg21oXkd1ojBSESc1bO1yzHD7lXc7j40eS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V1BNEYYH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736523617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nETjC03y6wayA3yWw5iErcD39pSYx6Us9DJRThxGd9Y=;
	b=V1BNEYYHOpINijojgAQIH+3/KdOqH1yQNJjObi34iFCjW4hf5HW9qYFw1fHay/BiM5gor4
	4bvDvttaFHD3ulnAPcg9P16ql9sKGhKwjfAjAV5jNJbr97fJ50tsZtfqauBImBrkiMJxAr
	ppHiXf8w9B3qmY0x7tvMPim3QfZtqBw=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-150-m1ouuzs7MiqSkrDKww7ASQ-1; Fri, 10 Jan 2025 10:40:15 -0500
X-MC-Unique: m1ouuzs7MiqSkrDKww7ASQ-1
X-Mimecast-MFC-AGG-ID: m1ouuzs7MiqSkrDKww7ASQ
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-aa6704ffcaeso211369066b.2
        for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 07:40:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736523615; x=1737128415;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nETjC03y6wayA3yWw5iErcD39pSYx6Us9DJRThxGd9Y=;
        b=I9ScGNqCibsfL/U4s5HwIsBWMCW9EA64MBuwhlgp6FDJjfZq/RHYdRrwBDebkG2Dum
         EZv3pF1GHQsm473pwCchQiNVGpuG3J6O1GnkY0j/GfOZrCiwbNzSGbC0t9zUoJGcr08a
         1wN2Qqoi0uK6NIu4IheYjcDegFD9Fpt0ci+NZLyYkgwpR7gomR5rI+TTUn1pILQsbFON
         kS8by8kGoVAK8LCBstKMcSUVdHKzt7l1BW1w5VrgdANwv4YJE1iPDBx7GerRd7qwhRZb
         TdmOJfDsEGhCEsJSbRpVays4NJ5Oe5IT1Z/Zkonm0v/QHzv4URxwgxLjmDq4kvJJ1dQv
         BpPw==
X-Forwarded-Encrypted: i=1; AJvYcCU8QiVyCnFFba6qUNu1cufJjXg8knqwT65hQ7dEC40C5gLoo52EUjkfne6TR+qNPoeeWygle48=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUalYPqK+5jgnD1m9Vt+BEbUHRIzYlaZndRAXsrF7l9M6g3MNg
	fsvO4Sx2W2uHiN14z9R5T7x2U7zWcnm0ij0cefugR597kRopWfAg+lI7urBg9eaMH8u6iTxlgji
	tPXOBw/HOOIhm25d/flMWc7fkXyTb81ce1ngDPvoN0L0noZlCF4lZQw==
X-Gm-Gg: ASbGncuJUfylnDUOaTiAvXjVWepIGlC09yG7Rfv524rNtAM06pelf700tVwnz1hhY9/
	CRf6RM2kiv9SdNBHZxSFBRJtHl7CB7u8JEpedKrypahfoyZqgGQwZX+ZOToE+iOkb59Eg/oTBYq
	516rlLFxuQlceiEHfxUW2YJ6RJ6TDW0AywXRqc5WyLq3kp9PCC3RpW+AgZdUf/eHSio2ZtTN1v5
	kTWwGSfDfApuqPjQrkm7pemrosGHi/amuV1Pzff7ZQOTZTjXczNZQ==
X-Received: by 2002:a17:906:6a15:b0:aae:8843:9029 with SMTP id a640c23a62f3a-ab2abc91605mr1142808466b.48.1736523614601;
        Fri, 10 Jan 2025 07:40:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFs1/ueFD8EoexRv69giGnGN+RNp3T1zDLuGccw7GnPFeANKb7YqUEpX/Rt22NPWnaMxnEhXg==
X-Received: by 2002:a17:906:6a15:b0:aae:8843:9029 with SMTP id a640c23a62f3a-ab2abc91605mr1142804866b.48.1736523614128;
        Fri, 10 Jan 2025 07:40:14 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c9136045sm176602266b.89.2025.01.10.07.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 07:40:13 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id AD6F8177E56C; Fri, 10 Jan 2025 16:40:12 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com
Cc: zhangkun09@huawei.com, liuyonglong@huawei.com, fanghaiqing@huawei.com,
 Yunsheng Lin <linyunsheng@huawei.com>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Eric Dumazet <edumazet@google.com>, Simon
 Horman <horms@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v7 2/8] page_pool: fix timing for checking and
 disabling napi_local
In-Reply-To: <20250110130703.3814407-3-linyunsheng@huawei.com>
References: <20250110130703.3814407-1-linyunsheng@huawei.com>
 <20250110130703.3814407-3-linyunsheng@huawei.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 10 Jan 2025 16:40:12 +0100
Message-ID: <87sepqhe3n.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Yunsheng Lin <linyunsheng@huawei.com> writes:

> page_pool page may be freed from skb_defer_free_flush() in
> softirq context without binding to any specific napi, it
> may cause use-after-free problem due to the below time window,
> as below, CPU1 may still access napi->list_owner after CPU0
> free the napi memory:
>
>             CPU 0                           CPU1
>       page_pool_destroy()          skb_defer_free_flush()
>              .                               .
>              .                napi = READ_ONCE(pool->p.napi);
>              .                               .
> page_pool_disable_direct_recycling()         .
>    driver free napi memory                   .
>              .                               .
>              .       napi && READ_ONCE(napi->list_owner) == cpuid
>              .                               .

Have you actually observed this happen, or are you just speculating?
Because I don't think it can; deleting a NAPI instance already requires
observing an RCU grace period, cf netdevice.h:

/**
 *  __netif_napi_del - remove a NAPI context
 *  @napi: NAPI context
 *
 * Warning: caller must observe RCU grace period before freeing memory
 * containing @napi. Drivers might want to call this helper to combine
 * all the needed RCU grace periods into a single one.
 */
void __netif_napi_del(struct napi_struct *napi);

/**
 *  netif_napi_del - remove a NAPI context
 *  @napi: NAPI context
 *
 *  netif_napi_del() removes a NAPI context from the network device NAPI list
 */
static inline void netif_napi_del(struct napi_struct *napi)
{
	__netif_napi_del(napi);
	synchronize_net();
}


> Use rcu mechanism to avoid the above problem.
>
> Note, the above was found during code reviewing on how to fix
> the problem in [1].
>
> As the following IOMMU fix patch depends on synchronize_rcu()
> added in this patch and the time window is so small that it
> doesn't seem to be an urgent fix, so target the net-next as
> the IOMMU fix patch does.
>
> 1. https://lore.kernel.org/lkml/8067f204-1380-4d37-8ffd-007fc6f26738@kernel.org/T/
>
> Fixes: dd64b232deb8 ("page_pool: unlink from napi during destroy")
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> CC: Alexander Lobakin <aleksander.lobakin@intel.com>
> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  net/core/page_pool.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index 9733206d6406..1aa7b93bdcc8 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -799,6 +799,7 @@ __page_pool_put_page(struct page_pool *pool, netmem_ref netmem,
>  static bool page_pool_napi_local(const struct page_pool *pool)
>  {
>  	const struct napi_struct *napi;
> +	bool napi_local;
>  	u32 cpuid;
>  
>  	if (unlikely(!in_softirq()))
> @@ -814,9 +815,15 @@ static bool page_pool_napi_local(const struct page_pool *pool)
>  	if (READ_ONCE(pool->cpuid) == cpuid)
>  		return true;
>  
> +	/* Synchronizated with page_pool_destory() to avoid use-after-free
> +	 * for 'napi'.
> +	 */
> +	rcu_read_lock();
>  	napi = READ_ONCE(pool->p.napi);
> +	napi_local = napi && READ_ONCE(napi->list_owner) == cpuid;
> +	rcu_read_unlock();

This rcu_read_lock/unlock() pair is redundant in the context you mention
above, since skb_defer_free_flush() is only ever called from softirq
context (within local_bh_disable()), which already function as an RCU
read lock.

> -	return napi && READ_ONCE(napi->list_owner) == cpuid;
> +	return napi_local;
>  }
>  
>  void page_pool_put_unrefed_netmem(struct page_pool *pool, netmem_ref netmem,
> @@ -1165,6 +1172,12 @@ void page_pool_destroy(struct page_pool *pool)
>  	if (!page_pool_release(pool))
>  		return;
>  
> +	/* Paired with rcu lock in page_pool_napi_local() to enable clearing
> +	 * of pool->p.napi in page_pool_disable_direct_recycling() is seen
> +	 * before returning to driver to free the napi instance.
> +	 */
> +	synchronize_rcu();

Most drivers call page_pool_destroy() in a loop for each RX queue, so
now you're introducing a full synchronize_rcu() wait for each queue.
That can delay tearing down the device significantly, so I don't think
this is a good idea.

-Toke


