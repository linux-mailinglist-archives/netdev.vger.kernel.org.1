Return-Path: <netdev+bounces-16822-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8837C74ED29
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 13:47:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 713DA1C20E4F
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 11:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0884918B08;
	Tue, 11 Jul 2023 11:47:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F1918AEE
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 11:47:52 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A71AD136;
	Tue, 11 Jul 2023 04:47:51 -0700 (PDT)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.54])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4R0fDf5Rx4ztR7x;
	Tue, 11 Jul 2023 19:44:50 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 11 Jul
 2023 19:47:48 +0800
Subject: Re: [PATCH v5 RFC 2/6] page_pool: unify frag_count handling in
 page_pool_is_last_frag()
To: Alexander Lobakin <aleksander.lobakin@intel.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Lorenzo Bianconi
	<lorenzo@kernel.org>, Alexander Duyck <alexander.duyck@gmail.com>, Liang Chen
	<liangchen.linux@gmail.com>, Jesper Dangaard Brouer <hawk@kernel.org>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, Eric Dumazet <edumazet@google.com>
References: <20230629120226.14854-1-linyunsheng@huawei.com>
 <20230629120226.14854-3-linyunsheng@huawei.com>
 <e201644d-c9bd-52d9-9d26-a18bc4def21f@intel.com>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <c9be2d69-450e-5e01-5884-0516a56f4c7c@huawei.com>
Date: Tue, 11 Jul 2023 19:47:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <e201644d-c9bd-52d9-9d26-a18bc4def21f@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.30.204]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023/7/10 22:39, Alexander Lobakin wrote:
> From: Yunsheng Lin <linyunsheng@huawei.com>
> Date: Thu, 29 Jun 2023 20:02:22 +0800
> 
>> Currently when page_pool_create() is called with
>> PP_FLAG_PAGE_FRAG flag, page_pool_alloc_pages() is only
>> allowed to be called under the below constraints:
>> 1. page_pool_fragment_page() need to be called to setup
>>    page->pp_frag_count immediately.
>> 2. page_pool_defrag_page() often need to be called to drain
>>    the page->pp_frag_count when there is no more user will
>>    be holding on to that page.
> 
> [...]
> 
>> @@ -352,12 +377,10 @@ static inline bool page_pool_is_last_frag(struct page_pool *pool,
>>  {
>>  	/* We assume we are the last frag user that is still holding
>>  	 * on to the page if:
>> -	 * 1. Fragments aren't enabled.
>> -	 * 2. We are running in 32-bit arch with 64-bit DMA.
>> -	 * 3. page_pool_defrag_page() indicate we are the last user.
>> +	 * 1. We are running in 32-bit arch with 64-bit DMA.
>> +	 * 2. page_pool_defrag_page() indicate we are the last user.
>>  	 */
>> -	return !(pool->p.flags & PP_FLAG_PAGE_FRAG) ||
>> -	       PAGE_POOL_DMA_USE_PP_FRAG_COUNT ||
>> +	return PAGE_POOL_DMA_USE_PP_FRAG_COUNT ||
>>  	       (page_pool_defrag_page(page, 1) == 0);
> 
> Just noticed while developing: after this change, the first function
> argument, i.e. @pool, is not needed anymore and can be removed.

Yes, thanks.

> 


