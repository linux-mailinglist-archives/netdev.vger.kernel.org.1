Return-Path: <netdev+bounces-44075-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B7797D5FF4
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 04:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56766281C09
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 02:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8F161FB7;
	Wed, 25 Oct 2023 02:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9344B1C14
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 02:28:50 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 181CB10E7
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 19:28:47 -0700 (PDT)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.56])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4SFXng2DPwzVmGK;
	Wed, 25 Oct 2023 10:24:55 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 25 Oct
 2023 10:28:45 +0800
Subject: Re: [PATCH v3 1/2] net: page_pool: check page pool ethtool stats
To: Sven Auhagen <sven.auhagen@voleatech.de>, Leon Romanovsky
	<leon@kernel.org>
CC: <netdev@vger.kernel.org>, <thomas.petazzoni@bootlin.com>,
	<brouer@redhat.com>, <lorenzo@kernel.org>, <Paulo.DaSilva@kyberna.com>,
	<ilias.apalodimas@linaro.org>, <mcroce@microsoft.com>
References: <be2yyb4ksuzj2d4yhvfzj43fswdtqmcqxv5dplmi6qy7vr4don@ksativ2xr33e>
 <20231015172710.GA223096@unreal>
 <fusfdpsgmo5cc55mokt2wasdx6flbgczho7yntj7fmiwchenft@luglcjwvedsq>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <6673bfb6-c046-47f6-811c-b39f992196ee@huawei.com>
Date: Wed, 25 Oct 2023 10:28:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <fusfdpsgmo5cc55mokt2wasdx6flbgczho7yntj7fmiwchenft@luglcjwvedsq>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.30.204]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected

On 2023/10/25 10:12, Sven Auhagen wrote:
> On Sun, Oct 15, 2023 at 08:27:10PM +0300, Leon Romanovsky wrote:
>> On Sun, Oct 15, 2023 at 02:37:27PM +0200, Sven Auhagen wrote:
>>> If the page_pool variable is null while passing it to
>>> the page_pool_get_stats function we receive a kernel error.
>>>
>>> Check if the page_pool variable is at least valid.
>>>
>>> Signed-off-by: Sven Auhagen <sven.auhagen@voleatech.de>
>>> Reported-by: Paulo Da Silva <Paulo.DaSilva@kyberna.com>
>>> ---
>>>  net/core/page_pool.c | 3 +++
>>>  1 file changed, 3 insertions(+)
>>>
>>> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
>>> index 2396c99bedea..4c5dca6b4a16 100644
>>> --- a/net/core/page_pool.c
>>> +++ b/net/core/page_pool.c
>>> @@ -65,6 +65,9 @@ bool page_pool_get_stats(struct page_pool *pool,
>>>  	if (!stats)
>>>  		return false;
>>>  
>>> +	if (!pool)
>>> +		return false;
>>> +
>>
>> I would argue that both pool and stats shouldn't be NULL and must be
>> checked by caller. This API call named get-stats-from-pool.
>>
>> Thanks
> 
> I can do it either way, I only need to know which version to send.
> Can someone let me know how to proceed with the patch?

From the message in v1, it seems more appropriate to check it in
the driver, because:
1. if the driver only support page pool, then the check is not
   really necessary.
2. if the driver support both page_pool API and alloc_pages()
   API, then a check is already needed in the driver to switch
   between those two API, it might be better to reuse that check.

"First the page pool is only available if the bm is not used.
The page pool is also not allocated when the port is stopped.
It can also be not allocated in case of errors."

> 
> Best
> Sven
> 
>>
>>>  	/* The caller is responsible to initialize stats. */
>>>  	stats->alloc_stats.fast += pool->alloc_stats.fast;
>>>  	stats->alloc_stats.slow += pool->alloc_stats.slow;
>>> -- 
>>> 2.42.0
>>>
>>>
> 
> .
> 

