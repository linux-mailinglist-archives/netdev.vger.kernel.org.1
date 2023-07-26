Return-Path: <netdev+bounces-21129-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE6EE7628B3
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 04:25:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C4D41C21026
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 02:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E811360;
	Wed, 26 Jul 2023 02:25:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990E37C
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 02:25:18 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E49D92689
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 19:25:16 -0700 (PDT)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.57])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4R9d2J3R5WztRkN;
	Wed, 26 Jul 2023 10:22:00 +0800 (CST)
Received: from [10.174.178.66] (10.174.178.66) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 26 Jul 2023 10:25:13 +0800
Message-ID: <13ab411d-32b0-b5e2-3e00-08a07e873a09@huawei.com>
Date: Wed, 26 Jul 2023 10:25:13 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
Subject: Re: [PATCH net-next] net: remove redundant NULL check in
 remove_xps_queue()
To: Simon Horman <simon.horman@corigine.com>
CC: <netdev@vger.kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <kuniyu@amazon.com>,
	<liuhangbin@gmail.com>, <jiri@resnulli.us>, <hkallweit1@gmail.com>,
	<andy.ren@getcruise.com>, <weiyongjun1@huawei.com>, <yuehaibing@huawei.com>
References: <20230724023735.2751602-1-shaozhengchao@huawei.com>
 <ZL90FnzgLUAPc1Sk@corigine.com>
From: shaozhengchao <shaozhengchao@huawei.com>
In-Reply-To: <ZL90FnzgLUAPc1Sk@corigine.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.66]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500026.china.huawei.com (7.185.36.106)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 2023/7/25 15:04, Simon Horman wrote:
> On Mon, Jul 24, 2023 at 10:37:35AM +0800, Zhengchao Shao wrote:
>> There are currently two paths that call remove_xps_queue():
>> 1. __netif_set_xps_queue -> remove_xps_queue
>> 2. clean_xps_maps -> remove_xps_queue_cpu -> remove_xps_queue
>> There is no need to check dev_maps in remove_xps_queue() because
>> dev_maps has been checked on these two paths.
>>
>> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
> 
> I have verified the reasoning above is correct.
> I am, however, slightly less sure that this is a good idea.
> 
Since commit 044ab86d431b("net: move the xps maps to an array") and
commit 867d0ad476db("net: fix XPS static_key accounting are
incorporated"), it is meaningless to reserve the null judgment. Perhaps
after removing this null check, add comment, like
/ * the caller must make sure that dev_maps != NULL */ ?
Thank you.

Zhengchao Shao
>> ---
>>   net/core/dev.c | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/net/core/dev.c b/net/core/dev.c
>> index f95e0674570f..76a91b849829 100644
>> --- a/net/core/dev.c
>> +++ b/net/core/dev.c
>> @@ -2384,8 +2384,7 @@ static bool remove_xps_queue(struct xps_dev_maps *dev_maps,
>>   	struct xps_map *map = NULL;
>>   	int pos;
>>   
>> -	if (dev_maps)
>> -		map = xmap_dereference(dev_maps->attr_map[tci]);
>> +	map = xmap_dereference(dev_maps->attr_map[tci]);
>>   	if (!map)
>>   		return false;
>>   
>> -- 
>> 2.34.1
>>

