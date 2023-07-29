Return-Path: <netdev+bounces-22531-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA92767EC5
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 13:40:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45C6328251E
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 11:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 197DD14AAB;
	Sat, 29 Jul 2023 11:40:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFE7156D1
	for <netdev@vger.kernel.org>; Sat, 29 Jul 2023 11:40:37 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5811198C;
	Sat, 29 Jul 2023 04:40:35 -0700 (PDT)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.56])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RCjGH4R5LzrRx1;
	Sat, 29 Jul 2023 19:39:35 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sat, 29 Jul
 2023 19:40:32 +0800
Subject: Re: [PATCH net-next 5/9] page_pool: don't use driver-set flags field
 directly
To: Alexander Lobakin <aleksander.lobakin@intel.com>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Larysa Zaremba <larysa.zaremba@intel.com>, Alexander Duyck
	<alexanderduyck@fb.com>, Jesper Dangaard Brouer <hawk@kernel.org>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, Simon Horman
	<simon.horman@corigine.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20230727144336.1646454-1-aleksander.lobakin@intel.com>
 <20230727144336.1646454-6-aleksander.lobakin@intel.com>
 <a0be882e-558a-9b1d-7514-0aad0080e08c@huawei.com>
 <6f8147ec-b8ad-3905-5279-16817ed6f5ae@intel.com>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <a7782cf1-e04a-e274-6a87-4952008bcc0c@huawei.com>
Date: Sat, 29 Jul 2023 19:40:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <6f8147ec-b8ad-3905-5279-16817ed6f5ae@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.30.204]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023/7/28 22:03, Alexander Lobakin wrote:
> From: Yunsheng Lin <linyunsheng@huawei.com>
> Date: Fri, 28 Jul 2023 20:36:50 +0800
> 
>> On 2023/7/27 22:43, Alexander Lobakin wrote:
>>
>>>  
>>>  struct page_pool {
>>>  	struct page_pool_params p;
>>> -	long pad;
>>> +
>>> +	bool dma_map:1;				/* Perform DMA mapping */
>>> +	enum {
>>> +		PP_DMA_SYNC_ACT_DISABLED = 0,	/* Driver didn't ask to sync */
>>> +		PP_DMA_SYNC_ACT_DO,		/* Perform DMA sync ops */
>>> +	} dma_sync_act:1;
>>> +	bool page_frag:1;			/* Allow page fragments */
>>>  
>>
>> Isn't it more common or better to just remove the flags field in
>> 'struct page_pool_params' and pass the flags by parameter like
>> below, so that patch 4 is not needed?
>>
>> struct page_pool *page_pool_create(const struct page_pool_params *params,
>> 				   unsigned int	flags);
> 
> You would need a separate patch to convert all the page_pool_create()
> users then either way.
> And it doesn't look really natural to me to pass both driver-set params
> and driver-set flags as separate function arguments. Someone may then
> think "why aren't flags just put in the params itself". The fact that
> Page Pool copies the whole params in the page_pool struct after
> allocating it is internals, page_pool_create() prototype however isn't.
> Thoughts?

It just seems odd to me that dma_map and page_frag is duplicated as we
seems to have the same info in the page_pool->p.flags.

What about:
In [PATCH net-next 4/9] page_pool: shrink &page_pool_params a tiny bit,
'flags' is bit-field'ed with 'dma_dir', what about changing 'dma_dir'
to be bit-field'ed with 'dma_sync_act', so that page_pool->p.flags stays
the same as before, and 'dma_map' & 'page_frag' do not seems be really
needed as we have the same info in page_pool->p.flags?


> 
> Thanks,
> Olek
> 
> .
> 

