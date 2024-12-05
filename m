Return-Path: <netdev+bounces-149362-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFBAB9E543E
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 12:43:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D048818832F6
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 11:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA0220CCC8;
	Thu,  5 Dec 2024 11:43:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC44220B7E4;
	Thu,  5 Dec 2024 11:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733399011; cv=none; b=PYGOvPPfZNcMb1/piWBW7mF2in91V/6/apwMhvQ3haeFW3MUUIrVurR16tH1LNWiLL/Zmqhc/0atsnZ6X/5EYuZcnIl7wPa/svcTrpg8V0Tdx9npe03dwszveDfkK5tIWoK7eoOQ2q2f8VIX2VLqdKMjszKhqx9itA5p0sKUW9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733399011; c=relaxed/simple;
	bh=KvQRWLsup4OMLK/V+HPoYCMUgmDbNgo8ZVUt7YlTwrY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=lZMtt16G+hW0WntyI5vOUxrxzuloEjTxyN2/RCCF+7oxHNbCJmd83A9BLWRlB1l9/p+skgSfcw/+qQJs2buG6qUeh6fsmX0A1WjtpiiLrEpOcrwefgeeKEMKPuH+VHeQ8p4nKRwWoUpjVixwM5x70HaOFIWRyJbm+bYxEsfsGPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Y3st92JBWzqTVc;
	Thu,  5 Dec 2024 19:41:37 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id BA712140391;
	Thu,  5 Dec 2024 19:43:25 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 5 Dec 2024 19:43:25 +0800
Message-ID: <70aefeb1-6a78-494c-9d5b-e03696948d11@huawei.com>
Date: Thu, 5 Dec 2024 19:43:25 +0800
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
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <20241204172846.5b360d32@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2024/12/5 9:28, Jakub Kicinski wrote:
> On Wed, 4 Dec 2024 19:01:14 +0800 Yunsheng Lin wrote:
>>> I don't think this is in the right place.
>>> Why not inside page_pool_disable_direct_recycling() ?  
>>
>> It is in page_pool_destroy() mostly because:
>> 1. Only call synchronize_rcu() when there is inflight pages, which should
>>    be an unlikely case, and  synchronize_rcu() might need to be called at
>>    least for the case of pool->p.napi not being NULL if it is called inside
>>    page_pool_disable_direct_recycling().
> 
> Right, my point was that page_pool_disable_direct_recycling() 
> is an exported function, its callers also need to be protected.

It depends on what is the callers is trying to protect by calling
page_pool_disable_direct_recycling().

It seems the use case for the only user of the API in bnxt driver
is about reuseing the same NAPI for different page_pool instances.

According to the steps in netdev_rx_queue.c:
1. allocate new queue memory & create page_pool
2. stop old rx queue.
3. start new rx queue with new page_pool
4. free old queue memory + destroy page_pool.

The page_pool_disable_direct_recycling() is called in step 2, I am
not sure how napi_enable() & napi_disable() are called in the above
flow, but it seems there is no use-after-free problem this patch is
trying to fix for the above flow.

It doesn't seems to have any concurrent access problem if napi->list_owner
is set to -1 before napi_disable() returns and the napi_enable() for the
new queue is called after page_pool_disable_direct_recycling() is called
in step 2.

