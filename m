Return-Path: <netdev+bounces-134189-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06FB399855D
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 13:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35BA11C23206
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 11:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF6751C2DD0;
	Thu, 10 Oct 2024 11:53:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058811BE23D;
	Thu, 10 Oct 2024 11:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728561225; cv=none; b=AVUpZ3eenSlZf4AL4NnNKFKyXq4FU1lkQHR/7PuBPqGvFKI1HnG7tPW1np6kBPTng7GDdIh3Jifa5LKv5Feyj19JEf66HWTpWmo94GIy+NxWUDCtfSjPnFwYs+Mwg1irdXgNE68v4HqzHS0LSlvNJslQwjFUqBblARzFtucMrQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728561225; c=relaxed/simple;
	bh=2jUyUz82EUmgHXC7DdO/UyMt9a5PwBEohkkcpg5BRdY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=FSzTI/4SgoMiNEukARnE9yfU9o4ibTTrDSIz8KpNPGwIDM0BipugATnjeRgrJH4yfRad6j07gY4/DmR4eAxguF+ggrwPBOcXYHY7KHU2vqTTXpnczyAjw4zWmYtcQUakSL+aJIE1v9ZQll78nVFcXNeio7VY/igYT+rmuHLVa2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4XPSmQ43jGzyT1j;
	Thu, 10 Oct 2024 19:52:22 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 0760018010F;
	Thu, 10 Oct 2024 19:53:40 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 10 Oct 2024 19:53:39 +0800
Message-ID: <601d59f4-d554-4431-81ca-32bb02fb541f@huawei.com>
Date: Thu, 10 Oct 2024 19:53:39 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1] page_pool: check for dma_sync_size earlier
To: Furong Xu <0x1207@gmail.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas
	<ilias.apalodimas@linaro.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <xfr@outlook.com>
References: <20241010114019.1734573-1-0x1207@gmail.com>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <20241010114019.1734573-1-0x1207@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2024/10/10 19:40, Furong Xu wrote:
> Setting dma_sync_size to 0 is not illegal, and several drivers already did.
> We can save a couple of function calls if check for dma_sync_size earlier.
> 
> Signed-off-by: Furong Xu <0x1207@gmail.com>
> ---
>  net/core/page_pool.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index a813d30d2135..fac52ba3f7c4 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -454,7 +454,7 @@ page_pool_dma_sync_for_device(const struct page_pool *pool,
>  			      netmem_ref netmem,
>  			      u32 dma_sync_size)
>  {
> -	if (pool->dma_sync && dma_dev_need_sync(pool->p.dev))
> +	if (dma_sync_size && pool->dma_sync && dma_dev_need_sync(pool->p.dev))
>  		__page_pool_dma_sync_for_device(pool, netmem, dma_sync_size);

Is there any reason that those drivers not to unset the PP_FLAG_DMA_SYNC_DEV
when calling page_pool_create()?
Does it only need dma sync for some cases and not need dma sync for other
cases? if so, why not do the dma sync in the driver instead?

>  }
>  

