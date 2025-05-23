Return-Path: <netdev+bounces-192909-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B26C8AC19D2
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 03:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4367C16EE6A
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 01:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2731D1F4171;
	Fri, 23 May 2025 01:52:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9B0202C3E;
	Fri, 23 May 2025 01:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747965146; cv=none; b=l1GqPmAcqIHY6zEhHjx7m6nI3q3eQmAs7x7OjVUNVgbYobpXVc9N/L+wIrGwN7MSLDj8Gr/3JfjVxus/SlSmSMYWtHLX8LGRixLQB7PzrFAw9DeXiz76TwFXcZ5P4blj66G+jdsjbZ59xgD+dNYtH8Ax3VUumERQfNjPh1FsK7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747965146; c=relaxed/simple;
	bh=uouMkHQJEv9eK/Egv5tzPhNwrlsLTqqkNAi24xHuPlc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=iBtnC12rEILquEFov3HmCz47K7uS5/3dgaV/NMDcW1taBFyc0uZ0x5qdXmjRG3xk2uXdewq76k5yjLd+DrZighq1UYEQLNvwJzb9kLf+acDx/w/F+3hCW/O6I7ESkYjRJ9vqDU2+iaM4cMQPXh9+uJfO04DlInL4Bporvr3ndHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4b3SmL4bFmz13LFD;
	Fri, 23 May 2025 09:50:42 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 1B6721400E3;
	Fri, 23 May 2025 09:52:20 +0800 (CST)
Received: from kwepemq200002.china.huawei.com (7.202.195.90) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 23 May 2025 09:52:19 +0800
Received: from [10.174.177.223] (10.174.177.223) by
 kwepemq200002.china.huawei.com (7.202.195.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 23 May 2025 09:52:19 +0800
Message-ID: <722186ce-174e-4201-acdf-ebf731fff7a3@huawei.com>
Date: Fri, 23 May 2025 09:52:18 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG Report] KASAN: slab-use-after-free in
 page_pool_recycle_in_ring
To: Jakub Kicinski <kuba@kernel.org>
CC: Mina Almasry <almasrymina@google.com>, <hawk@kernel.org>,
	<ilias.apalodimas@linaro.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, <horms@kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <zhangchangzhong@huawei.com>
References: <20250513083123.3514193-1-dongchenchen2@huawei.com>
 <CAHS8izOio0bnLp3+Vzt44NVgoJpmPTJTACGjWvOXvxVqFKPSwQ@mail.gmail.com>
 <34f06847-f0d8-4ff3-b8a1-0b1484e27ba8@huawei.com>
 <CAHS8izPh5Z-CAJpQzDjhLVN5ye=5i1zaDqb2xQOU3QP08f+Y0Q@mail.gmail.com>
 <20250519154723.4b2243d2@kernel.org>
 <CAHS8izMenFPVAv=OT-PiZ-hLw899JwVpB-8xu+XF+_Onh_4KEw@mail.gmail.com>
 <20250520110625.60455f42@kernel.org>
 <29d3e8fa-8cd0-4c93-a685-619758ab5af4@huawei.com>
 <20250522084759.6cfe3f6d@kernel.org>
From: "dongchenchen (A)" <dongchenchen2@huawei.com>
In-Reply-To: <20250522084759.6cfe3f6d@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemq200002.china.huawei.com (7.202.195.90)


> On Thu, 22 May 2025 23:17:32 +0800 dongchenchen (A) wrote:
>> Hi, Jakub
>> Maybe we can fix the problem as follow:
> Yes! a couple of minor nit picks below..
>
>> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
>> index 7745ad924ae2..de3fa33d6775 100644
>> --- a/net/core/page_pool.c
>> +++ b/net/core/page_pool.c
>> @@ -707,19 +707,18 @@ void page_pool_return_page(struct page_pool *pool, netmem_ref netmem)
>>    
>>    static bool page_pool_recycle_in_ring(struct page_pool *pool, netmem_ref netmem)
>>    {
>> +	bool in_softirq;
>>    	int ret;
>> -	/* BH protection not needed if current is softirq */
>> -	if (in_softirq())
>> -		ret = ptr_ring_produce(&pool->ring, (__force void *)netmem);
>> -	else
>> -		ret = ptr_ring_produce_bh(&pool->ring, (__force void *)netmem);
>>    
>> -	if (!ret) {
>> +	/* BH protection not needed if current is softirq */
>> +	in_softirq = page_pool_producer_lock(pool);
>> +	ret = __ptr_ring_produce(&pool->ring, (__force void *)netmem);
> Maybe we can flip the return value here we won't have to negate it below
> and at return? Like this:
>
> 	ret = !__ptr_ring_produce(&pool->ring, (__force void *)netmem);
>
> and adjust subsequent code

Hi,Jakub
Thanks for your suggestions!

>> +	if (!ret)
>>    		recycle_stat_inc(pool, ring);
>> -		return true;
>> -	}
>>    
>> -	return false;
>> +	page_pool_producer_unlock(pool, in_softirq);
>> +
>> +	return ret ? false : true;
>>    }
>>    
>>    /* Only allow direct recycling in special circumstances, into the
>>
>> @@ -1091,10 +1090,16 @@ static void page_pool_scrub(struct page_pool *pool)
>>    
>>    static int page_pool_release(struct page_pool *pool)
>>    {
>> +	bool in_softirq;
>>    	int inflight;
>>    
>> +	/* Acquire producer lock to make sure we don't race with another thread
>> +	 * returning a netmem to the ptr_ring.
>> +	 */
>> +	in_softirq = page_pool_producer_lock(pool);
>>    	page_pool_scrub(pool);
>>    	inflight = page_pool_inflight(pool, true);
>> +	page_pool_producer_unlock(pool, in_softirq);
> As I suggested earlier we don't have to lock the consumer, taking both
> locks has lock ordering implications. My preference would be:
>
>    	page_pool_scrub(pool);
>    	inflight = page_pool_inflight(pool, true);
> +	/* Acquire producer lock to make sure producers have exited. */
> +	in_softirq = page_pool_producer_lock(pool);
> +	page_pool_producer_unlock(pool, in_softirq);

Yes! there is no need to hold lock for page_pool_inflight(). The lock can
be used as a barrier for the completion of the recycle process.
I have tested this patch. The patch will be sent later.
----- Best Regards,
Dong Chenchen


