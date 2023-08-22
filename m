Return-Path: <netdev+bounces-29557-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EB87783CC6
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 11:21:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F92D1C20A81
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 09:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 714A08F55;
	Tue, 22 Aug 2023 09:21:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612BA6FA2
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 09:21:40 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78882189;
	Tue, 22 Aug 2023 02:21:38 -0700 (PDT)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.57])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RVP1P5CJWzVkpj;
	Tue, 22 Aug 2023 17:19:21 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 22 Aug
 2023 17:21:35 +0800
Subject: Re: [PATCH net-next v7 1/6] page_pool: frag API support for 32-bit
 arch with 64-bit DMA
To: Jakub Kicinski <kuba@kernel.org>
CC: Ilias Apalodimas <ilias.apalodimas@linaro.org>, Mina Almasry
	<almasrymina@google.com>, <davem@davemloft.net>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Lorenzo Bianconi
	<lorenzo@kernel.org>, Alexander Duyck <alexander.duyck@gmail.com>, Liang Chen
	<liangchen.linux@gmail.com>, Alexander Lobakin
	<aleksander.lobakin@intel.com>, Saeed Mahameed <saeedm@nvidia.com>, Leon
 Romanovsky <leon@kernel.org>, Eric Dumazet <edumazet@google.com>, Jesper
 Dangaard Brouer <hawk@kernel.org>
References: <20230816100113.41034-1-linyunsheng@huawei.com>
 <20230816100113.41034-2-linyunsheng@huawei.com>
 <CAC_iWjJd8Td_uAonvq_89WquX9wpAx0EYYxYMbm3TTxb2+trYg@mail.gmail.com>
 <20230817091554.31bb3600@kernel.org>
 <CAC_iWjJQepZWVrY8BHgGgRVS1V_fTtGe-i=r8X5z465td3TvbA@mail.gmail.com>
 <20230817165744.73d61fb6@kernel.org>
 <CAC_iWjL4YfCOffAZPUun5wggxrqAanjd+8SgmJQN0yyWsvb3sg@mail.gmail.com>
 <20230818145145.4b357c89@kernel.org>
 <1b8e2681-ccd6-81e0-b696-8b6c26e31f26@huawei.com>
 <20230821113543.536b7375@kernel.org>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <5bd4ba5d-c364-f3f6-bbeb-903d71102ea2@huawei.com>
Date: Tue, 22 Aug 2023 17:21:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230821113543.536b7375@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.30.204]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023/8/22 2:35, Jakub Kicinski wrote:
> On Mon, 21 Aug 2023 20:18:55 +0800 Yunsheng Lin wrote:
>>> -	page_pool_set_dma_addr(page, dma);
>>> +	if (page_pool_set_dma_addr(page, dma))
>>> +		goto unmap_failed;  
>>
>> What does the driver do when the above fails?
>> Does the driver still need to implement a fallback for 32 bit arch with
>> dma addr with more than 32 + 12 bits?
>> If yes, it does not seems to be very helpful from driver's point of view
>> as the driver might still need to call page allocator API directly when
>> the above fails.
> 
> I'd expect the driver to do nothing, we are operating under 
> the assumption that "this will never happen". If it does 
> the user should report it back to us. So maybe..

Digging a litte deeper:
From CPU's point of views, up to 40 bits is supported for LPAE.
From device's point of view, it seems up to 48-bits is supported
when iommu is enabled, see below:
https://elixir.free-electrons.com/linux/v6.5-rc7/source/drivers/iommu/Kconfig#L28

> 
>>>  	if (pool->p.flags & PP_FLAG_DMA_SYNC_DEV)
>>>  		page_pool_dma_sync_for_device(pool, page, pool->p.max_len);
>>>  
>>>  	return true;
>>> +
>>> +unmap_failed:
> 
> .. we should also add a:
> 
> 	WARN_ONCE(1, "misaligned DMA address, please report to netdev@");

As the CONFIG_PHYS_ADDR_T_64BIT seems to used widely in x86/arm/mips/powerpc,
I am not sure if we can really make the above assumption.

https://elixir.free-electrons.com/linux/v6.4-rc6/K/ident/CONFIG_PHYS_ADDR_T_64BIT

> 
> here?
> 
>>> +	dma_unmap_page_attrs(pool->p.dev, dma,
>>> +			     PAGE_SIZE << pool->p.order, pool->p.dma_dir,
>>> +			     DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_WEAK_ORDERING);
>>> +	return false;
> .
> 

