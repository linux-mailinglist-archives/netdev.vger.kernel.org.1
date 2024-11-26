Return-Path: <netdev+bounces-147397-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2ED49D966C
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 12:46:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E006CB22866
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 11:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C44A193064;
	Tue, 26 Nov 2024 11:46:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D034811185;
	Tue, 26 Nov 2024 11:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732621599; cv=none; b=FxZxeHDcUPxxq+NjtclWYLJJJneEv91GqHMAKDFAqZ/qaj3WpOSBtk/DT70F6m2UlPOqbFxcDOgZDzk1ZmE+QYvE86AIMNHimu/NaB3XeuTGk3LmW/AI061BXtufeSL/jWiUQMk/dZix1jrEg3+RfnQjcSvywGwwD4qDz3VubJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732621599; c=relaxed/simple;
	bh=PZlwZxdHF7frqU3MGDyp+2mGn8PBWwE2iXqb6SNufIM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=s8JEIzUNvzLlujtfrdb1vj+4UqfYrngkUALOXnkimL4GSPd4n4X/1JlnHSwyYqrQ06hjavWZPtbG3OVKuSaADqR3V5ekgXdjQt2XG6KOI6QTMxLF4d2fo//IxSKM1bNFgLlJ6LCynDivYmCa/TZEx/FJzL6fNbGUrS6noFp24Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4XyLLq74MwzxVZX;
	Tue, 26 Nov 2024 19:43:47 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 6CABD180105;
	Tue, 26 Nov 2024 19:46:34 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 26 Nov 2024 19:46:34 +0800
Message-ID: <caabd226-e80b-4cd7-acdf-0f1355e04b4f@huawei.com>
Date: Tue, 26 Nov 2024 19:46:33 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v4 2/3] page_pool: fix IOMMU crash when driver has
 already unbound
To: Jesper Dangaard Brouer <hawk@kernel.org>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <liuyonglong@huawei.com>, <fanghaiqing@huawei.com>,
	<zhangkun09@huawei.com>, Robin Murphy <robin.murphy@arm.com>, Alexander Duyck
	<alexander.duyck@gmail.com>, IOMMU <iommu@lists.linux.dev>, Ilias Apalodimas
	<ilias.apalodimas@linaro.org>, Eric Dumazet <edumazet@google.com>, Simon
 Horman <horms@kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20241120103456.396577-1-linyunsheng@huawei.com>
 <20241120103456.396577-3-linyunsheng@huawei.com>
 <3366bf89-4544-4b82-83ec-fd89dd009228@kernel.org>
 <27475b57-eda1-4d67-93f2-5ca443632f6b@huawei.com>
 <ac728cc1-2ccb-4207-ae11-527a3ed8fbb6@kernel.org>
 <6233e2c3-3fea-4ed0-bdcc-9a625270da37@huawei.com>
 <554e768b-e990-49ff-bad4-805ee931597f@kernel.org>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <554e768b-e990-49ff-bad4-805ee931597f@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2024/11/26 18:22, Jesper Dangaard Brouer wrote:

...

>>>
>>> Once the a page is release from a page pool it becomes a normal page,
>>> that adhere to normal page refcnt'ing. That is how it worked before with
>>> page_pool_release_page().
>>> The later extensions with page fragment support and devmem might have
>>> complicated this code path.
>>
>> As page_pool_return_page() and page_pool_destroy() both try to "release"
>> the page concurrently for a specific page, I am not sure how using some
>> simple *atomic* can avoid this kind of concurrency even before page
>> fragment and devmem are supported, it would be good to be more specific
>> about that by using some pseudocode.
>>
> 
> Okay, some my simple atomic idea will not work.
> 
> NEW IDEA:
> 
> So, the my concern in this patchset is that BH-disabling spin_lock pool->destroy_lock is held in the outer loop of page_pool_inflight_unmap() that scans all pages.  Disabling BH for this long have nasty side-effects.
> 
> Will it be enough to grab the pool->destroy_lock only when we detect a page that belongs to our page pool?  Of-cause after obtaining the lock. the code need to recheck if the page still belongs to the pool.
> 

That means there will be page_pool_return_page() called between the scanning,
it seems like a lot like the idea of 'page_pool_get_dma_addr() need to be
checked to decide if the mapping is already done or not for each page.' as
there are two cases when page_pool_return_page() is called during scanning:
1. page_pool_get_dma_addr() returns non-zero dma address, which means the dma
   unmapping is not done by scanning yet, page_pool_return_page() need to do
   the dma unmapping before calling put_page()
2. page_pool_get_dma_addr() returns zero dma address, which means the dma
   unmapping is done by scanning, page_pool_return_page() just skip the dma
   unmapping and only call put_page().

It seems there is only one case for scanning:
1. page_pool_get_dma_addr() for a page_pool owned page returns non-zero dma
   address, which means page_pool_return_page() is not called for that page yet,
   scanning will the do the mapping for page_pool_return_page() and reset the
   dma address of the page to indicate the dma unmapping is done for that page.

It seems there is no case of page_pool owned page having zero dma address during
scanning, as both page->pp_magic is cleared and dma unmapping is already done in
page_pool_return_page().

