Return-Path: <netdev+bounces-149697-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE2969E6E20
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 13:29:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3B82188340B
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 12:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0549520124E;
	Fri,  6 Dec 2024 12:29:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40163201113;
	Fri,  6 Dec 2024 12:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733488188; cv=none; b=thODb/fcRs5hNE5JR9FZM+mbmnoWzen/58TlapY6nfvH+2yjciWUpySnmhiAQlSGA8k1MxI2WMDSxKVnmIP/hfDOV0PrIjnYxdekrn8XsNLW7qjrmwPQPuXT6kPtBhurlezLUISF2CVUQNPwzpQZZLH2QPbIiTBIXZ+BcTakVXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733488188; c=relaxed/simple;
	bh=Sn0W2n3Nmn4M+B+vsFN5ieoRowmKkyBRsaa5O53+g6o=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=LkGhavO5JG9ScOUgo44mxi/2sPvOzJIgIWB7Rz1kokTudfNFxnQLnt1pxtyurB0PFiXs9vAFaZ5MrBsuZTxF/GNbdw215kfONKEmFvseRwVcyJftZHzw9kw2mXbWIrVR933t4+LVFcrcazuSt6XmKl75QMoPizm76hWbSgXyy1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Y4VrT2SPBz1T6VK;
	Fri,  6 Dec 2024 20:27:21 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 69E3C1402C4;
	Fri,  6 Dec 2024 20:29:41 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 6 Dec 2024 20:29:41 +0800
Message-ID: <c2b306af-4817-4169-814b-adbf25803919@huawei.com>
Date: Fri, 6 Dec 2024 20:29:40 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v4 1/3] page_pool: fix timing for checking and
 disabling napi_local
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <pabeni@redhat.com>, <liuyonglong@huawei.com>,
	<fanghaiqing@huawei.com>, <zhangkun09@huawei.com>, Alexander Lobakin
	<aleksander.lobakin@intel.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas
	<ilias.apalodimas@linaro.org>, Eric Dumazet <edumazet@google.com>, Simon
 Horman <horms@kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20241120103456.396577-1-linyunsheng@huawei.com>
 <20241120103456.396577-2-linyunsheng@huawei.com>
 <20241202184954.3a4095e3@kernel.org>
 <e053e75a-bde1-4e69-9a8d-d1f54be06bdb@huawei.com>
 <20241204172846.5b360d32@kernel.org>
 <70aefeb1-6a78-494c-9d5b-e03696948d11@huawei.com>
 <20241205164233.64512141@kernel.org>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <20241205164233.64512141@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2024/12/6 8:42, Jakub Kicinski wrote:
> On Thu, 5 Dec 2024 19:43:25 +0800 Yunsheng Lin wrote:
>> It depends on what is the callers is trying to protect by calling
>> page_pool_disable_direct_recycling().
>>
>> It seems the use case for the only user of the API in bnxt driver
>> is about reuseing the same NAPI for different page_pool instances.
>>
>> According to the steps in netdev_rx_queue.c:
>> 1. allocate new queue memory & create page_pool
>> 2. stop old rx queue.
>> 3. start new rx queue with new page_pool
>> 4. free old queue memory + destroy page_pool.
>>
>> The page_pool_disable_direct_recycling() is called in step 2, I am
>> not sure how napi_enable() & napi_disable() are called in the above
>> flow, but it seems there is no use-after-free problem this patch is
>> trying to fix for the above flow.
>>
>> It doesn't seems to have any concurrent access problem if napi->list_owner
>> is set to -1 before napi_disable() returns and the napi_enable() for the
>> new queue is called after page_pool_disable_direct_recycling() is called
>> in step 2.
> 
> The fix is presupposing there is long delay between fetching of
> the NAPI pointer and its access. The concern is that NAPI gets
> restarted in step 3 after we already READ_ONCE()'ed the pointer,
> then we access it and judge it to be running on the same core.
> Then we put the page into the fast cache which will never get
> flushed.

It seems the napi_disable() is called before netdev_rx_queue_restart()
and napi_enable() and ____napi_schedule() are called after
netdev_rx_queue_restart() as there is no napi API called in the
implementation of 'netdev_queue_mgmt_ops' for bnxt driver?

If yes, napi->list_owner is set to -1 before step 1 and only set to
a valid cpu in step 6 as below:
1. napi_disable()
2. allocate new queue memory & create new page_pool.
3. stop old rx queue.
4. start new rx queue with new page_pool.
5. free old queue memory + destroy old page_pool.
6. napi_enable() & ____napi_schedule()

And there are at least three flows involved here:
flow 1: calling napi_complete_done() and set napi->list_owner to -1.
flow 2: calling netdev_rx_queue_restart().
flow 3: calling skb_defer_free_flush() with the page belonging to the old
       page_pool.

The only case of page_pool_napi_local() returning true in flow 3 I can
think of is that flow 1 and flow 3 might need to be called in the softirq
of the same CPU and flow 3 might need to be called before flow 1.

It seems impossible that page_pool_napi_local() will return true between
step 1 and step 6 as updated napi->list_owner is always seen by flow 3
when they are both called in the softirq context of the same CPU or
napi->list_owner != CPU that calling flow 3, which seems like an implicit
assumption for the case of napi scheduling between different cpus too.

And old page_pool is destroyed in step 5, I am not sure if it is necessary
to call page_pool_disable_direct_recycling() in step 3 if page_pool_destroy()
already have the synchronize_rcu() in step 5 before enabling napi.

If not, maybe I am missing something here. It would be good to be more specific
about the timing window that page_pool_napi_local() returning true for the old
page_pool.

> 

