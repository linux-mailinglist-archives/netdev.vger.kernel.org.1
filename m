Return-Path: <netdev+bounces-193450-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 746EDAC4159
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 16:27:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10C0A3A9AB7
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 14:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31360201261;
	Mon, 26 May 2025 14:27:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6908213AA27;
	Mon, 26 May 2025 14:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748269644; cv=none; b=cJS9FMHfRDcqJEl5kndJBYxGWHO8sSe2OLovR13HA9t582dhVrMXpnAi9nqNW+UknnJhG4bz+T2OVV2RV0UGRWeDw5AKfON5uf+LwIYUPI3YtkUldGiC3+CgVctEjHCtIuLrKWIk6/HiLciSGQ4qH2WGDlpW6chVBzz1CivbPrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748269644; c=relaxed/simple;
	bh=tMySMh7fSjlVmPWIompo773sVXwgdTssh0oKTI+pz/w=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=O08dbe/RRwN8FoT4Dz7HL3chLgtbUlXAKyH71hWqiIBfXzmozSGTCIThd/mMoIJA0oCAtiK8XkuM6RQZjF+ebUjx2H6oMbkp6n55rvH75v4vFxXfEct+hsP3wFcdDZl4VXvUPFzzkKh7NzWUiCu3jAcPH22CHimnIa8J2oETJmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4b5dNP23lXztRxC;
	Mon, 26 May 2025 22:25:57 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id EB137180B51;
	Mon, 26 May 2025 22:27:11 +0800 (CST)
Received: from kwepemq200002.china.huawei.com (7.202.195.90) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 26 May 2025 22:27:11 +0800
Received: from [10.174.177.223] (10.174.177.223) by
 kwepemq200002.china.huawei.com (7.202.195.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 26 May 2025 22:27:10 +0800
Message-ID: <2c4a2655-2e0d-4c16-82e6-2d9d33d5a276@huawei.com>
Date: Mon, 26 May 2025 22:27:10 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] page_pool: Fix use-after-free in
 page_pool_recycle_in_ring
To: Yunsheng Lin <linyunsheng@huawei.com>, <hawk@kernel.org>,
	<ilias.apalodimas@linaro.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
	<almasrymina@google.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<zhangchangzhong@huawei.com>,
	<syzbot+204a4382fcb3311f3858@syzkaller.appspotmail.com>
References: <20250523064524.3035067-1-dongchenchen2@huawei.com>
 <a5cc7765-0de2-47ca-99c4-a48aaf6384d2@huawei.com>
From: "dongchenchen (A)" <dongchenchen2@huawei.com>
In-Reply-To: <a5cc7765-0de2-47ca-99c4-a48aaf6384d2@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemq200002.china.huawei.com (7.202.195.90)


> On 2025/5/23 14:45, Dong Chenchen wrote:
>
>>   
>>   static bool page_pool_recycle_in_ring(struct page_pool *pool, netmem_ref netmem)
>>   {
>> +	bool in_softirq;
>>   	int ret;
> int -> bool?

Thanks for your review!

v2 will fix it.

>>   	/* BH protection not needed if current is softirq */
>> -	if (in_softirq())
>> -		ret = ptr_ring_produce(&pool->ring, (__force void *)netmem);
>> -	else
>> -		ret = ptr_ring_produce_bh(&pool->ring, (__force void *)netmem);
>> -
>> -	if (!ret) {
>> +	in_softirq = page_pool_producer_lock(pool);
>> +	ret = !__ptr_ring_produce(&pool->ring, (__force void *)netmem);
>> +	if (ret)
>>   		recycle_stat_inc(pool, ring);
>> -		return true;
>> -	}
>> +	page_pool_producer_unlock(pool, in_softirq);
>>   
>> -	return false;
>> +	return ret;
>>   }
>>   
>>   /* Only allow direct recycling in special circumstances, into the
>> @@ -1091,10 +1088,14 @@ static void page_pool_scrub(struct page_pool *pool)
>>   
>>   static int page_pool_release(struct page_pool *pool)
>>   {
>> +	bool in_softirq;
>>   	int inflight;
>>   
>>   	page_pool_scrub(pool);
>>   	inflight = page_pool_inflight(pool, true);
>> +	/* Acquire producer lock to make sure producers have exited. */
>> +	in_softirq = page_pool_producer_lock(pool);
>> +	page_pool_producer_unlock(pool, in_softirq);
> Is a compiler barrier needed to ensure compiler doesn't optimize away
> the above code?

All the code logic of this function accesses the pool. Do we need to
add a compiler barrier for it?

Best Regards,
Dong Chenchen

>>   	if (!inflight)
>>   		__page_pool_destroy(pool);
>>   

