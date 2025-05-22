Return-Path: <netdev+bounces-192747-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 706B7AC103C
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 17:48:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAB0C1BC3BE9
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 15:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE8A28A730;
	Thu, 22 May 2025 15:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KkhS5PYY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103362F41;
	Thu, 22 May 2025 15:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747928881; cv=none; b=JVk8uN5uAw5zOVBXhJtYfwn1axUO/Xq14Msk4xOp0qnWbJX/ansDNRYzKuDobAzaRD2KvJljNVz4//573RvvF1/3QBA5qnaEM0mBieBw+hyVPQQ0mMXUNu9EAqd5wcjR0vG/uQqrf2OQrlzcBEiu59b9yEiuUH8/OWPFj3IaipQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747928881; c=relaxed/simple;
	bh=wbxc4JwRzpP3kx5hp10mJ7GeRgcNbH5lUjtcxhlkZ0w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=laW52qVBn3JrrTv9WmnYYQwn7nXvOy/4r2t6L9oYP68bWNbtPqmMOT61inUC7eXL/6BnzUo0Poo3P7xwO9Abx5av6BWeQLaJqux+RzCwxRT00ltLa62o7m2zd8NCOR6BCMv84Cdf7xQwmvDY/87Q+YK8o/5hcxCNMI978nkw/nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KkhS5PYY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F31EC4CEE4;
	Thu, 22 May 2025 15:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747928880;
	bh=wbxc4JwRzpP3kx5hp10mJ7GeRgcNbH5lUjtcxhlkZ0w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KkhS5PYYz27fI9lOOd8NHWR9ZnWyeYmfbfNCrhulJUeDY0LREXpRPkr/NBKrhfPfz
	 paqhqkA/Zstn4KCbHxupKK3uuohpy3pY1hdNFy9kvtgxgav4HASArfLyJRyoH9lAxQ
	 52PFay8xee8FuyuM4mnKJJE3VV9XRQ6tmnGynNFGc5MI/ecfgrE6D5ShJdKW2fO+lw
	 6vOlH+//qTVoXPlhr2ehwsowng+4kxVnsf05rRTFpBl6uwMwArbHpU1oG/8BEUcPEn
	 lg9q5/WbSnjYxB6pFiGVtwSjdmOjGDvQa3ob2xKFcKVtgQy2N2Osd+zX+i9giwBR0B
	 cz9p2SSLarZqg==
Date: Thu, 22 May 2025 08:47:59 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "dongchenchen (A)" <dongchenchen2@huawei.com>
Cc: Mina Almasry <almasrymina@google.com>, <hawk@kernel.org>,
 <ilias.apalodimas@linaro.org>, <davem@davemloft.net>,
 <edumazet@google.com>, <pabeni@redhat.com>, <horms@kernel.org>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <zhangchangzhong@huawei.com>
Subject: Re: [BUG Report] KASAN: slab-use-after-free in
 page_pool_recycle_in_ring
Message-ID: <20250522084759.6cfe3f6d@kernel.org>
In-Reply-To: <29d3e8fa-8cd0-4c93-a685-619758ab5af4@huawei.com>
References: <20250513083123.3514193-1-dongchenchen2@huawei.com>
	<CAHS8izOio0bnLp3+Vzt44NVgoJpmPTJTACGjWvOXvxVqFKPSwQ@mail.gmail.com>
	<34f06847-f0d8-4ff3-b8a1-0b1484e27ba8@huawei.com>
	<CAHS8izPh5Z-CAJpQzDjhLVN5ye=5i1zaDqb2xQOU3QP08f+Y0Q@mail.gmail.com>
	<20250519154723.4b2243d2@kernel.org>
	<CAHS8izMenFPVAv=OT-PiZ-hLw899JwVpB-8xu+XF+_Onh_4KEw@mail.gmail.com>
	<20250520110625.60455f42@kernel.org>
	<29d3e8fa-8cd0-4c93-a685-619758ab5af4@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 22 May 2025 23:17:32 +0800 dongchenchen (A) wrote:
> Hi, Jakub
> Maybe we can fix the problem as follow:

Yes! a couple of minor nit picks below..

> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index 7745ad924ae2..de3fa33d6775 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -707,19 +707,18 @@ void page_pool_return_page(struct page_pool *pool, netmem_ref netmem)
>   
>   static bool page_pool_recycle_in_ring(struct page_pool *pool, netmem_ref netmem)
>   {
> +	bool in_softirq;
>   	int ret;
> -	/* BH protection not needed if current is softirq */
> -	if (in_softirq())
> -		ret = ptr_ring_produce(&pool->ring, (__force void *)netmem);
> -	else
> -		ret = ptr_ring_produce_bh(&pool->ring, (__force void *)netmem);
>   
> -	if (!ret) {
> +	/* BH protection not needed if current is softirq */
> +	in_softirq = page_pool_producer_lock(pool);
> +	ret = __ptr_ring_produce(&pool->ring, (__force void *)netmem);

Maybe we can flip the return value here we won't have to negate it below
and at return? Like this:

	ret = !__ptr_ring_produce(&pool->ring, (__force void *)netmem);

and adjust subsequent code

> +	if (!ret)
>   		recycle_stat_inc(pool, ring);
> -		return true;
> -	}
>   
> -	return false;
> +	page_pool_producer_unlock(pool, in_softirq);
> +
> +	return ret ? false : true;
>   }
>   
>   /* Only allow direct recycling in special circumstances, into the
> 
> @@ -1091,10 +1090,16 @@ static void page_pool_scrub(struct page_pool *pool)
>   
>   static int page_pool_release(struct page_pool *pool)
>   {
> +	bool in_softirq;
>   	int inflight;
>   
> +	/* Acquire producer lock to make sure we don't race with another thread
> +	 * returning a netmem to the ptr_ring.
> +	 */
> +	in_softirq = page_pool_producer_lock(pool);
>   	page_pool_scrub(pool);
>   	inflight = page_pool_inflight(pool, true);
> +	page_pool_producer_unlock(pool, in_softirq);

As I suggested earlier we don't have to lock the consumer, taking both
locks has lock ordering implications. My preference would be:

  	page_pool_scrub(pool);
  	inflight = page_pool_inflight(pool, true);
+	/* Acquire producer lock to make sure producers have exited. */
+	in_softirq = page_pool_producer_lock(pool);
+	page_pool_producer_unlock(pool, in_softirq);

