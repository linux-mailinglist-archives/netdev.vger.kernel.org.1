Return-Path: <netdev+bounces-158098-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA8B5A10750
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 14:04:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 731423A6D24
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 13:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C43E2361C5;
	Tue, 14 Jan 2025 13:03:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF62230272;
	Tue, 14 Jan 2025 13:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736859836; cv=none; b=hyN2UXbsaKUh05GZ8/onMqDLZqcouiI+8sYHBlXPKvy56TVwnL0xetg0uVRy4Ua/cV9CCt7c7FCl9rikSntKmS3chJKrrstws2WO94y9hoNQVoJyzgss7HrOjBMOJYOFWoPS2Eggf6xhbEZ06p1h0e4yRUyrVUf+KyVvw9d0RjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736859836; c=relaxed/simple;
	bh=+HFRCUbiPhyGEI7iFLSXTQRL82WcpVAq8LE+o9azY/0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=sVuYoeEQL89PLmd1EYn1nJK8KqVebXvVPS+OR3aiENPeTnOHCWSKv5QveDYtg2Kw5+kSNo4jo8zxZuIUkNO/tkQwVKlnEvVZt5kVXqHdg3pTShrvv6W3lOTw/80svtWkDi4SBFDHBBqv9akgN1Ihjt5FE9L1KmUWHewha07n7FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4YXTkr369Kzbk5j;
	Tue, 14 Jan 2025 21:00:36 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 5A7A2180216;
	Tue, 14 Jan 2025 21:03:44 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 14 Jan 2025 21:03:44 +0800
Message-ID: <22de6033-744e-486e-bbd9-8950249cd018@huawei.com>
Date: Tue, 14 Jan 2025 21:03:43 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 2/8] page_pool: fix timing for checking and
 disabling napi_local
To: Yunsheng Lin <yunshenglin0825@gmail.com>,
	=?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <zhangkun09@huawei.com>, <liuyonglong@huawei.com>,
	<fanghaiqing@huawei.com>, Alexander Lobakin <aleksander.lobakin@intel.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Jesper Dangaard Brouer
	<hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Eric
 Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20250110130703.3814407-1-linyunsheng@huawei.com>
 <20250110130703.3814407-3-linyunsheng@huawei.com> <87sepqhe3n.fsf@toke.dk>
 <5059df11-a85b-4404-8c24-a9ccd76924f3@gmail.com>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <5059df11-a85b-4404-8c24-a9ccd76924f3@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2025/1/11 13:24, Yunsheng Lin wrote:

...

>>>   }
>>>     void page_pool_put_unrefed_netmem(struct page_pool *pool, netmem_ref netmem,
>>> @@ -1165,6 +1172,12 @@ void page_pool_destroy(struct page_pool *pool)
>>>       if (!page_pool_release(pool))
>>>           return;
>>>   +    /* Paired with rcu lock in page_pool_napi_local() to enable clearing
>>> +     * of pool->p.napi in page_pool_disable_direct_recycling() is seen
>>> +     * before returning to driver to free the napi instance.
>>> +     */
>>> +    synchronize_rcu();
>>
>> Most drivers call page_pool_destroy() in a loop for each RX queue, so
>> now you're introducing a full synchronize_rcu() wait for each queue.
>> That can delay tearing down the device significantly, so I don't think
>> this is a good idea.
> 
> synchronize_rcu() is called after page_pool_release(pool), which means
> it is only called when there are some inflight pages, so there is not
> necessarily a full synchronize_rcu() wait for each queue.
> 
> Anyway, it seems that there are some cases that need explicit
> synchronize_rcu() and some cases depending on the other API providing
> synchronize_rcu() semantics, maybe we provide two diffferent API for
> both cases like the netif_napi_del()/__netif_napi_del() APIs do?

As the synchronize_rcu() is also needed to fix the DMA API misuse problem,
we can not really handle it like netif_napi_del()/__netif_napi_del() APIs
do, the best I can think is something like below:

bool need_sync = false;

for (each queue)
	need_sync |= page_pool_destroy_prepare(queue->pool);

if (need_sync)
	synchronize_rcu()

for (each queue)
	page_pool_destroy_commit(queue->pool);

But I am not sure if the above worth the effort or not for now as the
synchronize_rcu() is only called for the inflight page case.
Any better idea? If not, maybe we can optimize the above later if
the synchronize_rcu() does turn out to be a problem.

> 

