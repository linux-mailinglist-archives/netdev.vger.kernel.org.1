Return-Path: <netdev+bounces-142659-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5BD79BFE5C
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 07:18:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F692B22CE6
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 06:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 889B3193071;
	Thu,  7 Nov 2024 06:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="U4m49iHM"
X-Original-To: netdev@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E31F193064;
	Thu,  7 Nov 2024 06:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730960287; cv=none; b=tszUEjrxK1e4FUcpJHY1hbL8a05bt6OTyTPwSbpqX3MZOQWOUaZsx3NPTH9gdR+kmftk5oKQkRKlDkik+xBm76hfI1/Z95J88T+5YEwqWkS4uoT0Kz641hEG3fN9YzU2IVOloDP0AoyxG0zupwdm/QoTy96ysJfvYhu/PToxIg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730960287; c=relaxed/simple;
	bh=pbOy6B0zVXHQyppymn+TRtOJRIrbaMtDXrTEp01RmMs=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=lxrl8GT0Zs3A1cGhHavOKcFunbbhF4wTlV8YxK9EGg2Hnnf4CT2xF4ChmP9Hm9iSzBmdFfTSNuEvkgmNwdcKZgv74rRy8FtTLm+eSEnXEV6kZzCcWhviyktwdWLO2+n6QkbqscHBAt5bd9AFmUn8Z+FFHWB05cNCoEnOpVV2WxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=U4m49iHM; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730960280; h=Message-ID:Subject:Date:From:To;
	bh=Z/W8cDmcOSrXBQmIaTgj/+sEv3NHtLilDqKw6Sftrg0=;
	b=U4m49iHMR2d2aw11FJsQm6rle1m9VfZcCVZufz8QqdOig7+jwVKTKPjLmzgspMZ53q47pOyAo1e8VK27A/ZUOZibLdgST/hpnEZ0ygkWRDpcbbNPfYphrlXW84toJyoc25/kJb6vFlsNtHM4cP+GWaniKBnqyi3dE18MRhskVuo=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WIuPSSH_1730960279 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 07 Nov 2024 14:18:00 +0800
Message-ID: <1730960271.064656-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v3 2/3] page_pool: fix timing for checking and disabling napi_local
Date: Thu, 7 Nov 2024 14:17:51 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: <zhangkun09@huawei.com>,
 <fanghaiqing@huawei.com>,
 <liuyonglong@huawei.com>,
 Yunsheng Lin <linyunsheng@huawei.com>,
 Alexander  Lobakin <aleksander.lobakin@intel.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Eric  Dumazet <edumazet@google.com>,
 <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>,
 <davem@davemloft.net>,
 <kuba@kernel.org>,
 <pabeni@redhat.com>
References: <20241022032214.3915232-1-linyunsheng@huawei.com>
 <20241022032214.3915232-3-linyunsheng@huawei.com>
In-Reply-To: <20241022032214.3915232-3-linyunsheng@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Tue, 22 Oct 2024 11:22:12 +0800, Yunsheng Lin <linyunsheng@huawei.com> wrote:
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
>
> Use rcu mechanism to avoid the above problem.
>
> Note, the above was found during code reviewing on how to fix
> the problem in [1].
>
> 1. https://lore.kernel.org/lkml/8067f204-1380-4d37-8ffd-007fc6f26738@kernel.org/T/
>
> Fixes: dd64b232deb8 ("page_pool: unlink from napi during destroy")
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>


Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

> CC: Alexander Lobakin <aleksander.lobakin@intel.com>
> ---
> As the IOMMU fix patch depends on synchronize_rcu() added in this
> patch and the time window is so small that it doesn't seem to be
> an urgent fix, so target the net-next as the IOMMU fix patch does.
> ---
>  net/core/page_pool.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index a813d30d2135..dd497f5c927d 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -795,6 +795,7 @@ __page_pool_put_page(struct page_pool *pool, netmem_ref netmem,
>  static bool page_pool_napi_local(const struct page_pool *pool)
>  {
>  	const struct napi_struct *napi;
> +	bool napi_local;
>  	u32 cpuid;
>
>  	if (unlikely(!in_softirq()))
> @@ -810,9 +811,15 @@ static bool page_pool_napi_local(const struct page_pool *pool)
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
>
> -	return napi && READ_ONCE(napi->list_owner) == cpuid;
> +	return napi_local;
>  }
>
>  void page_pool_put_unrefed_netmem(struct page_pool *pool, netmem_ref netmem,
> @@ -1126,6 +1133,12 @@ void page_pool_destroy(struct page_pool *pool)
>  	if (!page_pool_release(pool))
>  		return;
>
> +	/* Paired with rcu lock in page_pool_napi_local() to enable clearing
> +	 * of pool->p.napi in page_pool_disable_direct_recycling() is seen
> +	 * before returning to driver to free the napi instance.
> +	 */
> +	synchronize_rcu();
> +
>  	page_pool_detached(pool);
>  	pool->defer_start = jiffies;
>  	pool->defer_warn  = jiffies + DEFER_WARN_INTERVAL;
> --
> 2.33.0
>
>

