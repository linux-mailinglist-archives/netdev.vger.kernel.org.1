Return-Path: <netdev+bounces-17945-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3927753B75
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 15:05:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 786A4282253
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 13:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0CF13731;
	Fri, 14 Jul 2023 13:05:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB0B20E8
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 13:05:16 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC68630CA
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 06:05:13 -0700 (PDT)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.56])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4R2WsG2kyLz18Lq3;
	Fri, 14 Jul 2023 21:04:34 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 14 Jul
 2023 21:05:11 +0800
Subject: Re: [RFC 00/12] net: huge page backed page_pool
To: Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer
	<jbrouer@redhat.com>
CC: <brouer@redhat.com>, <netdev@vger.kernel.org>, <almasrymina@google.com>,
	<hawk@kernel.org>, <ilias.apalodimas@linaro.org>, <edumazet@google.com>,
	<dsahern@gmail.com>, <michael.chan@broadcom.com>, <willemb@google.com>
References: <20230707183935.997267-1-kuba@kernel.org>
 <1721282f-7ec8-68bd-6d52-b4ef209f047b@redhat.com>
 <20230711170838.08adef4c@kernel.org>
 <edf4f724-0c0e-c6ae-ffcb-ec1336448e59@huawei.com>
 <8b50a49e-5df8-dccd-154e-4423f0e8eda5@redhat.com>
 <20230712100108.00bee44f@kernel.org>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <74430f6d-b253-989c-4a31-059ffbe83063@huawei.com>
Date: Fri, 14 Jul 2023 21:05:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230712100108.00bee44f@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.30.204]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023/7/13 1:01, Jakub Kicinski wrote:
> On Wed, 12 Jul 2023 14:43:32 +0200 Jesper Dangaard Brouer wrote:
>> On 12/07/2023 13.47, Yunsheng Lin wrote:
>>> On 2023/7/12 8:08, Jakub Kicinski wrote:  
>>>> Oh, I split the page into individual 4k pages after DMA mapping.
>>>> There's no need for the host memory to be a huge page. I mean,
>>>> the actual kernel identity mapping is a huge page AFAIU, and the
>>>> struct pages are allocated, anyway. We just need it to be a huge
>>>> page at DMA mapping time.
>>>>
>>>> So the pages from the huge page provider only differ from normal
>>>> alloc_page() pages by the fact that they are a part of a 1G DMA
>>>> mapping.  
>>
>> So, Jakub you are saying the PP refcnt's are still done "as usual" on 
>> individual pages.
> 
> Yes - other than coming from a specific 1G of physical memory 
> the resulting pages are really pretty ordinary 4k pages.
> 
>>> If it is about DMA mapping, is it possible to use dma_map_sg()
>>> to enable a big continuous dma map for a lot of discontinuous
>>> 4k pages to avoid allocating big huge page?
>>>
>>> As the comment:
>>> "The scatter gather list elements are merged together (if possible)
>>> and tagged with the appropriate dma address and length."
>>>
>>> https://elixir.free-electrons.com/linux/v4.16.18/source/arch/arm/mm/dma-mapping.c#L1805
>>>   
>>
>> This is interesting for two reasons.
>>
>> (1) if this DMA merging helps IOTLB misses (?)
> 
> Maybe I misunderstand how IOMMU / virtual addressing works, but I don't
> see how one can merge mappings from physically non-contiguous pages.
> IOW we can't get 1G-worth of random 4k pages and hope that thru some
> magic they get strung together and share an IOTLB entry (if that's
> where Yunsheng's suggestion was going..)

From __arm_lpae_map(), it does seems that smmu in arm can install
pte in different level to point to page of different size.

> 
>> (2) PP could use dma_map_sg() to amortize dma_map call cost.
>>
>> For case (2) __page_pool_alloc_pages_slow() already does bulk allocation
>> of pages (alloc_pages_bulk_array_node()), and then loops over the pages
>> to DMA map them individually.  It seems like an obvious win to use
>> dma_map_sg() here?

For mapping, the above should work, the tricky problem is we need to ensure
all pages belonging to the same big dma mapping is released before we can do
the dma unmapping.

> 
> That could well be worth investigating!
> .
> 

