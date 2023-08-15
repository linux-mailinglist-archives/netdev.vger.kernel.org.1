Return-Path: <netdev+bounces-27674-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D57B377CCA6
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 14:31:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E5F7281502
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 12:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B1F8CA5B;
	Tue, 15 Aug 2023 12:31:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90AAABA22
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 12:31:05 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D544D1;
	Tue, 15 Aug 2023 05:31:04 -0700 (PDT)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.55])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RQ9ZG3FwtzrSgW;
	Tue, 15 Aug 2023 20:29:42 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 15 Aug
 2023 20:31:02 +0800
Subject: Re: [PATCH net-next v6 1/6] page_pool: frag API support for 32-bit
 arch with 64-bit DMA
To: Simon Horman <horms@kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Lorenzo Bianconi
	<lorenzo@kernel.org>, Alexander Duyck <alexander.duyck@gmail.com>, Liang Chen
	<liangchen.linux@gmail.com>, Alexander Lobakin
	<aleksander.lobakin@intel.com>, Saeed Mahameed <saeedm@nvidia.com>, Leon
 Romanovsky <leon@kernel.org>, Eric Dumazet <edumazet@google.com>, Jesper
 Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas
	<ilias.apalodimas@linaro.org>, <linux-rdma@vger.kernel.org>
References: <20230814125643.59334-1-linyunsheng@huawei.com>
 <20230814125643.59334-2-linyunsheng@huawei.com>
 <ZNtgfy9KPUclHnLE@vergenet.net>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <b497faa8-2e57-a060-1105-24ea6bad0051@huawei.com>
Date: Tue, 15 Aug 2023 20:31:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZNtgfy9KPUclHnLE@vergenet.net>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.30.204]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023/8/15 19:24, Simon Horman wrote:
> On Mon, Aug 14, 2023 at 08:56:38PM +0800, Yunsheng Lin wrote:
> 
> ...
> 
>> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
>> index 77cb75e63aca..d62c11aaea9a 100644
>> --- a/net/core/page_pool.c
>> +++ b/net/core/page_pool.c
> 
> ...
> 
>> @@ -737,18 +736,16 @@ static void page_pool_free_frag(struct page_pool *pool)
>>  	page_pool_return_page(pool, page);
>>  }
>>  
>> -struct page *page_pool_alloc_frag(struct page_pool *pool,
>> -				  unsigned int *offset,
>> -				  unsigned int size, gfp_t gfp)
>> +struct page *__page_pool_alloc_frag(struct page_pool *pool,
>> +				    unsigned int *offset,
>> +				    unsigned int size, gfp_t gfp)
>>  {
>>  	unsigned int max_size = PAGE_SIZE << pool->p.order;
>>  	struct page *page = pool->frag_page;
>>  
>> -	if (WARN_ON(!(pool->p.flags & PP_FLAG_PAGE_FRAG) ||
>> -		    size > max_size))
>> +	if (WARN_ON(!(pool->p.flags & PP_FLAG_PAGE_FRAG))
> 
> Hi Yunsheng Lin,
> 
> There is a ')' missing on the line above, which results in a build failure.

Yes, thanks for noticing.
As the above checking is removed in patch 3, so it is not noticeable in testing
when the whole patchset is applied.

> 

