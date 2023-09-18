Return-Path: <netdev+bounces-34535-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CECB7A482D
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 13:16:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06CC5281D24
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 11:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0BE7154A0;
	Mon, 18 Sep 2023 11:16:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E91338FB3
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 11:16:12 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B5FA115;
	Mon, 18 Sep 2023 04:15:18 -0700 (PDT)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.54])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Rq2FJ6jwxzVl00;
	Mon, 18 Sep 2023 19:12:20 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 18 Sep
 2023 19:15:15 +0800
Subject: Re: [PATCH net-next v8 2/6] page_pool: unify frag_count handling in
 page_pool_is_last_frag()
To: Paolo Abeni <pabeni@redhat.com>, <davem@davemloft.net>, <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Lorenzo Bianconi
	<lorenzo@kernel.org>, Alexander Duyck <alexander.duyck@gmail.com>, Liang Chen
	<liangchen.linux@gmail.com>, Alexander Lobakin
	<aleksander.lobakin@intel.com>, Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Eric Dumazet
	<edumazet@google.com>
References: <20230912083126.65484-1-linyunsheng@huawei.com>
 <20230912083126.65484-3-linyunsheng@huawei.com>
 <9e53ca46be34f3c393861b7a645bb25f0b03f1d2.camel@redhat.com>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <e7f2d1b1-49fe-cf8d-eb96-c5ddf52903a0@huawei.com>
Date: Mon, 18 Sep 2023 19:15:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <9e53ca46be34f3c393861b7a645bb25f0b03f1d2.camel@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.30.204]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023/9/14 23:17, Paolo Abeni wrote:
>> --- a/net/core/page_pool.c
>> +++ b/net/core/page_pool.c
>> @@ -376,6 +376,14 @@ static void page_pool_set_pp_info(struct page_pool *pool,
>>  {
>>  	page->pp = pool;
>>  	page->pp_magic |= PP_SIGNATURE;
>> +
>> +	/* Ensuring all pages have been split into one big frag initially:
>> +	 * page_pool_set_pp_info() is only called once for every page when it
>> +	 * is allocated from the page allocator and page_pool_fragment_page()
>> +	 * is dirtying the same cache line as the page->pp_magic above, so
>> +	 * the overhead is negligible.
>> +	 */
>> +	page_pool_fragment_page(page, 1);
>>  	if (pool->p.init_callback)
>>  		pool->p.init_callback(page, pool->p.init_arg);
>>  }
> 
> I think it would be nice backing the above claim with some benchmarks.
> (possibly even just a micro-benchmark around the relevant APIs)
> and include such info into the changelog message.

Sure, will adjust Jesper's below micro-benchmark to test it:
https://github.com/netoptimizer/prototype-kernel/blob/master/kernel/lib/bench_page_pool_simple.c

Please let me know if there is other better idea to do the
micro-benchmark in your mind, thanks.

> 
> Cheers,
> 
> Paolo
> 
> .
> 

