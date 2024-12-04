Return-Path: <netdev+bounces-148937-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 714679E3907
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 12:40:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F8FCB3D814
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 11:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 861851B219B;
	Wed,  4 Dec 2024 11:17:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97FB16F851;
	Wed,  4 Dec 2024 11:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733311023; cv=none; b=jst8awlVBRudvruJt4cCVIBYqZC9ZvIlbnizV4Lb/Z9hKOiBrZ61WgJw+oj4cnJj4dhr77sQfrPNLF0USFOn/of4jRssrN2VOp1Ig7oT1DJ0GDxLeS5WWSb1wShJ0lqQXSLJ4Uou3JHT6ePTqwjET6IX1Ekt1PScoSDpHMokV94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733311023; c=relaxed/simple;
	bh=JE8BpRj8vQLP9mTwKpZP0vDSKHaMI6GsN+FiB7Ze/sQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WUhPpJIuZ2omlD/jNRQLBG1CNAN5NjBlJWhbn/QAY/UihkAizbPuJ7ixbSgVjbE5trTYjhsn0EqoJnsmmkVgnbAdETcfTvISNKBBB7AdmGsJrS23nB2aPU5Bmu5wW9ewAFDC8ZYDAObf9xrgM/DqJLocAl1b+KS4mVdy6BTBOWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Y3FJw02SbzPq3c;
	Wed,  4 Dec 2024 19:14:08 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id D98471800CD;
	Wed,  4 Dec 2024 19:16:57 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 4 Dec 2024 19:16:57 +0800
Message-ID: <9a4d1357-f30d-420d-a575-7ae305ca6dda@huawei.com>
Date: Wed, 4 Dec 2024 19:16:57 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v4 2/3] page_pool: fix IOMMU crash when driver has
 already unbound
To: Alexander Duyck <alexander.duyck@gmail.com>, Robin Murphy
	<robin.murphy@arm.com>
CC: Mina Almasry <almasrymina@google.com>, Jesper Dangaard Brouer
	<hawk@kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <liuyonglong@huawei.com>, <fanghaiqing@huawei.com>,
	<zhangkun09@huawei.com>, IOMMU <iommu@lists.linux.dev>, Ilias Apalodimas
	<ilias.apalodimas@linaro.org>, Eric Dumazet <edumazet@google.com>, Simon
 Horman <horms@kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20241120103456.396577-1-linyunsheng@huawei.com>
 <20241120103456.396577-3-linyunsheng@huawei.com>
 <3366bf89-4544-4b82-83ec-fd89dd009228@kernel.org>
 <27475b57-eda1-4d67-93f2-5ca443632f6b@huawei.com>
 <CAHS8izM+sK=48gfa3gRNffu=T6t6-2vaS60QvH79zFA3gSDv9g@mail.gmail.com>
 <CAKgT0Uc-SDHsGkgmLeAuo5GLE0H43i3h7mmzG88BQojfCoQGGA@mail.gmail.com>
 <8f45cc4f-f5fc-4066-9ee1-ba59bf684b07@huawei.com>
 <41dfc444-1bab-4f9d-af11-4bbd93a9fe4b@arm.com>
 <CAKgT0UfGmR9B7WBjANvZ9=dxbsWXDRgpaNAMJWGW4Uj4ueiHJg@mail.gmail.com>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <CAKgT0UfGmR9B7WBjANvZ9=dxbsWXDRgpaNAMJWGW4Uj4ueiHJg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2024/11/28 0:27, Alexander Duyck wrote:

...

> 
> My general thought would be to see if there is anything we could
> explore within the DMA API itself to optimize the handling for this
> sort of bulk unmap request. If not we could fall back to an approach
> that requires more overhead and invalidation of individual pages.
> 
> You could think of it like the approach that has been taken with
> DEFINED_DMA_UNMAP_ADDR/LEN. Basically there are cases where this can
> be done much more quickly and it is likely we can clean up large
> swaths in one go. So why not expose a function that might be able to
> take advantage of that for exception cases like this surprise device
> removal.

I am not sure if I understand the 'surprise device removal' part, it
seems to be about calling the DMA API after the driver has already
unbound, which includes the normal driver unloading too as my
understanding.

For the dma sync API, it seems there is already an existing API to
check if the dma sync API is needed for a specific device:
dma_dev_need_sync(). And it seems that the API is not really reliable
as it might return different value during the lifetime of a driver
instance, see dma_reset_need_sync() called in swiotlb_tbl_map_single().

For the dma unmap API, the below patch implemented something similar to
check if the dma unmap API is needed for a specific device, it seems
to be unreliable too as the dma_dev_need_sync() does as they both depend
on the dev->dma_skip_sync.

Even if there is a reliable way to do the checking, it seems the
complexity‌ might be still needed for the case of not being able to skip
the DMA API.
As the main concerns seems to be about supporting unlimting inflight
pages and performance overhead, if there is no other better idea of
not tracking the inflight pages, perhaps it is better to go back to
the tracking the inflight pages way by supporting unlimting inflight
page and avoiding performance overhead as much as possible.

1. https://lore.kernel.org/linux-pci/b912495d307d92ac7071553db99b3badc477fb12.1731244445.git.leon@kernel.org/

> 

