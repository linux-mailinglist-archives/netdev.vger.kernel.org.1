Return-Path: <netdev+bounces-172434-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6ADEA549A7
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 12:40:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96B343AF01E
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 11:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874B020C479;
	Thu,  6 Mar 2025 11:32:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5E020C460;
	Thu,  6 Mar 2025 11:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741260762; cv=none; b=IxkugbYgdGK9ClOc1dOSe7IRjz2e6rpZfAMUPhpHi0ZAilkTf44zzK4lBCJdyExuQGg/XaVEoEsyYtpoiRuhmT/Kc3A7AlYnpRxzrnjzsyeAuffT4UNaJNmL+2pU4WmAWSwkHdPwyMSfRX+ymVrlIjwoi9m5ub2XUN3wi66PfMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741260762; c=relaxed/simple;
	bh=yP8VnlyKc5/15HFwlcDWLvQ6tumCdUXTiC1nNtgtuGs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=MromQd9xP4ClRX9X9Aqc12wRfte4XsqO5CWkFIjP/sxlbvQ6zc2vRbFYS7ruPcATUHKWKIFTohya4TL/5uIhde5NLaF8mF/F1Gqofxl21bLeibmLhe4eevbfxNuaT8UK8OKIeZAl/SuY2w5qzvaEN6TrZizRFtH1NiAkcGrX4Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Z7nFz5sSnzwXJs;
	Thu,  6 Mar 2025 19:27:35 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 9DD1118009E;
	Thu,  6 Mar 2025 19:32:31 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 6 Mar 2025 19:32:31 +0800
Message-ID: <ba78ff0c-ff42-4240-b318-41ef9160c3de@huawei.com>
Date: Thu, 6 Mar 2025 19:32:30 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v10 4/4] page_pool: skip dma sync operation for
 inflight pages
To: Jason Gunthorpe <jgg@ziepe.ca>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<zhangkun09@huawei.com>, <liuyonglong@huawei.com>, <fanghaiqing@huawei.com>,
	Robin Murphy <robin.murphy@arm.com>, Alexander Duyck
	<alexander.duyck@gmail.com>, IOMMU <iommu@lists.linux.dev>, Jesper Dangaard
 Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20250226110340.2671366-1-linyunsheng@huawei.com>
 <20250226110340.2671366-5-linyunsheng@huawei.com>
 <20250305172906.GG5011@ziepe.ca>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <20250305172906.GG5011@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2025/3/6 1:29, Jason Gunthorpe wrote:
> On Wed, Feb 26, 2025 at 07:03:39PM +0800, Yunsheng Lin wrote:
>> Skip dma sync operation for inflight pages before the
>> sync operation in page_pool_item_unmap() as DMA API
>> expects to be called with a valid device bound to a
>> driver as mentioned in [1].
>>
>> After page_pool_destroy() is called, the page is not
>> expected to be recycled back to pool->alloc cache and
>> dma sync operation is not needed when the page is not
>> recyclable or pool->ring is full, so only skip the dma
>> sync operation for the infilght pages by clearing the
>> pool->dma_sync, as rcu sync operation in
>> page_pool_destroy() is paired with rcu lock in
>> page_pool_recycle_in_ring() to ensure that there is no
>> dma sync operation called after rcu sync operation.
> 
> Are you guaranteeing that the cache is made consistent before freeing
> the page back to the mm? That is required..

As page_pool is only calling the sync_for_device API before the
device triggers the DMA, and the above skip is only done for the
sync_for_device API after page_pool_destroy() is called, which
means there is no DMA messing with the page before freeing the
page back to the mm if I understand the question correctly.

And the driver is supposed to call sync_for_cpu API before
passing the page to networking stack, which passes the page
back to page_pool eventually.

> 
> Jason

