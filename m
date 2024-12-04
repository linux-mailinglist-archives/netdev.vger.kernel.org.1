Return-Path: <netdev+bounces-148934-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED23E9E3822
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 12:01:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1A7C285FEA
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 11:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F901B2182;
	Wed,  4 Dec 2024 11:01:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921761AF0AE;
	Wed,  4 Dec 2024 11:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733310080; cv=none; b=anb2AbjQf62nBkvp+Zjmw9jlM9kmZTykCPf69FCTwQaxbKtBc9LIQIOtZ52ONuCzaFxfGvZ9HINSMHZ/IE7R/SNlZw/5KwRCPlaUQo9Y1gyjkcnBEipq8P4I6IYagmxFa4PpTG+YuTNz4Flp9zqATfGyE6xmsCj9MwxHcfpR9+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733310080; c=relaxed/simple;
	bh=c2NvD8YPqwoJEBvfGdqJXIumIQ7XNQdIdtsGxgK/kP4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GZ1MFoCH5/jgKSNArckPolUvnBu9X2uhhcvk64MNbW9Rv98Xb2Zc0e6vO6eK5OHL7hIhF5JqcAL20PX9ObF099HspSHmeDsvnyIpqPqA+rZUTVnenR+vdkbocxkUOcRsUszfnIEWZhC/hCXNpQrZPU5E172ND9c7FozxdBtK1h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Y3DzP6TNzz2GcVp;
	Wed,  4 Dec 2024 18:58:57 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id C003714011B;
	Wed,  4 Dec 2024 19:01:14 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 4 Dec 2024 19:01:14 +0800
Message-ID: <e053e75a-bde1-4e69-9a8d-d1f54be06bdb@huawei.com>
Date: Wed, 4 Dec 2024 19:01:14 +0800
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
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <20241202184954.3a4095e3@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2024/12/3 10:49, Jakub Kicinski wrote:
> On Wed, 20 Nov 2024 18:34:53 +0800 Yunsheng Lin wrote:
>> page_pool page may be freed from skb_defer_free_flush() in
>> softirq context without binding to any specific napi, it
>> may cause use-after-free problem due to the below time window,
>> as below, CPU1 may still access napi->list_owner after CPU0
>> free the napi memory:
>>
>>             CPU 0                           CPU1
>>       page_pool_destroy()          skb_defer_free_flush()
>>              .                               .
>>              .                napi = READ_ONCE(pool->p.napi);
>>              .                               .
>> page_pool_disable_direct_recycling()         .
>>    driver free napi memory                   .
>>              .                               .
>>              .       napi && READ_ONCE(napi->list_owner) == cpuid
>>              .                               .
>>
>> Use rcu mechanism to avoid the above problem.
>>
>> Note, the above was found during code reviewing on how to fix
>> the problem in [1].
>>
>> 1. https://lore.kernel.org/lkml/8067f204-1380-4d37-8ffd-007fc6f26738@kernel.org/T/
> 
> Please split it from the rest of the series, it's related but not
> really logically connected (dma mappings and NAPI recycling are 
> different features of page pool).
> 
>> @@ -1126,6 +1133,12 @@ void page_pool_destroy(struct page_pool *pool)
>>  	if (!page_pool_release(pool))
>>  		return;
>>  
>> +	/* Paired with rcu lock in page_pool_napi_local() to enable clearing
>> +	 * of pool->p.napi in page_pool_disable_direct_recycling() is seen
>> +	 * before returning to driver to free the napi instance.
>> +	 */
>> +	synchronize_rcu();
> 
> I don't think this is in the right place.
> Why not inside page_pool_disable_direct_recycling() ?

It is in page_pool_destroy() mostly because:
1. Only call synchronize_rcu() when there is inflight pages, which should
   be an unlikely case, and  synchronize_rcu() might need to be called at
   least for the case of pool->p.napi not being NULL if it is called inside
   page_pool_disable_direct_recycling().
2. the above synchronize_rcu() in page_pool_destroy() is also reused
   for the fixing of dma unmappings.

> 
> Hopefully this doesn't cause long stalls during reconfig, normally
> NAPIs and page pools are freed together, and NAPI removal implies
> synchronize_rcu(). That's why it's not really a problem for majority
> of drivers. You should perhaps make a note of this in the commit
> message.
> 

