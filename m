Return-Path: <netdev+bounces-193459-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA412AC4200
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 17:03:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAE623A9EB4
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 15:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE028248C;
	Mon, 26 May 2025 15:02:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02B43A1BA;
	Mon, 26 May 2025 15:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748271751; cv=none; b=oQ7gBwg6IiPS/DHTyZY5vux7gHamlDC2x6gKxAYpkG0ymiaRa5E0Ljl4Cpmam85A8mPtbnUYGe3XL5x1zosnB9bQ1aO9C9xG+MkQsJfN9N6WqZ1Raz7yFfn5WhRTftRdNyure4Zm3CPcNfRBITQqBEkNLNhuNaaasa9GsIOHxSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748271751; c=relaxed/simple;
	bh=uV9HuOSDtAY9Z+lGW1n6jg1EdBI5E33YVHDoJQ8iefY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=i3nMxFuLNC89O2FbhxN85+anwC24VDAlOZhwsMjx9OSEWEEubjE/bnkXOMWr19McKwyVLG5d+ar5CBU25XLbG2jfEYEmpIipsgRLi0sfWjmJVaOhUtjnAVgmbxV8pkiRDUR6MFK1X9IEQJ6b7KJ5acoFef5eeCzMowgnWArEZXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4b5f8X1cQnz13LxB;
	Mon, 26 May 2025 23:00:44 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 46E2F1401E9;
	Mon, 26 May 2025 23:02:26 +0800 (CST)
Received: from kwepemq200002.china.huawei.com (7.202.195.90) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 26 May 2025 23:02:26 +0800
Received: from [10.174.177.223] (10.174.177.223) by
 kwepemq200002.china.huawei.com (7.202.195.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 26 May 2025 23:02:25 +0800
Message-ID: <7d632b35-2a37-452f-9604-848d4145eab6@huawei.com>
Date: Mon, 26 May 2025 23:02:24 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] page_pool: Fix use-after-free in
 page_pool_recycle_in_ring
To: Paolo Abeni <pabeni@redhat.com>, <hawk@kernel.org>,
	<ilias.apalodimas@linaro.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <horms@kernel.org>, <almasrymina@google.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<zhangchangzhong@huawei.com>,
	<syzbot+204a4382fcb3311f3858@syzkaller.appspotmail.com>
References: <20250523064524.3035067-1-dongchenchen2@huawei.com>
 <af41c789-9e0d-4310-ae28-055beef73f10@redhat.com>
From: "dongchenchen (A)" <dongchenchen2@huawei.com>
In-Reply-To: <af41c789-9e0d-4310-ae28-055beef73f10@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemq200002.china.huawei.com (7.202.195.90)


在 2025/5/23 21:31, Paolo Abeni 写道:
> On 5/23/25 8:45 AM, Dong Chenchen wrote:
>> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
>> index 7745ad924ae2..08f1b000ebc1 100644
>> --- a/net/core/page_pool.c
>> +++ b/net/core/page_pool.c
>> @@ -707,19 +707,16 @@ void page_pool_return_page(struct page_pool *pool, netmem_ref netmem)
>>   
>>   static bool page_pool_recycle_in_ring(struct page_pool *pool, netmem_ref netmem)
>>   {
>> +	bool in_softirq;
>>   	int ret;
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
> Does not build in our CI:
>
> net/core/page_pool.c: In function ‘page_pool_recycle_in_ring’:
> net/core/page_pool.c:750:45: error: suggest braces around empty body in
> an ‘if’ statement [-Werror=empty-body]
>    750 |                 recycle_stat_inc(pool, ring);
>        |                                             ^
>
> /P
>
I am sorry for this mistake.
recycle_stat_inc() is empty when CONFIG_PAGE_POOL_STATS is not enabled.
Maybe we can fix it as:

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 08f1b000ebc1..19c1505ec40f 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -154,8 +154,8 @@ EXPORT_SYMBOL(page_pool_ethtool_stats_get);
  
  #else
  #define alloc_stat_inc(pool, __stat)
-#define recycle_stat_inc(pool, __stat)
-#define recycle_stat_add(pool, __stat, val)
+#define recycle_stat_inc(pool, __stat)         do { } while (0)
+#define recycle_stat_add(pool, __stat, val)    do { } while (0)
  #endif

Thanks a lot!

Dong Chenchen


