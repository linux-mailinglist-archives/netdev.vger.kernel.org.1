Return-Path: <netdev+bounces-192738-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC16DAC0FB9
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 17:17:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20D661BC50A4
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 15:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19E4A8634F;
	Thu, 22 May 2025 15:17:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400C12980A8;
	Thu, 22 May 2025 15:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747927066; cv=none; b=I/GUuOnZyvm2/JcXa0hVHW4brOwHMN/HEPmBW5EY97Ce7g8J6Q92vMu44Ehw6bAflYGz6JrX7+zAT5KYjy8nW/ZAUWjYjHi0aRADx5KgpFiWgh1xfNlo08uIxZM19oqnyToNLor92TUl9cJDO5pD8cfr2IQ1NjC26lWIP/tOCm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747927066; c=relaxed/simple;
	bh=Hk/4aw3TnbHARX0fqegYUGU2nCn30vgBEqTred1rBFI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=eESH1pP0q8mhu7g+gSwTsLSD2OcYRIz7xlSABBtIgBgSyZ+wzB2NAQJfXjpskQZfDf/0yxXprh72jOfLzmuu1NJnylJpHT72Hiowq0mOK0xd1/nuViuyXYkcil9THJAyIhI44uB8JM+Pz4whznxh5+ovJ5mqHmPQrykP5CKpHlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4b3Bcl6GhxzvWm2;
	Thu, 22 May 2025 23:13:11 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 1B9D3180B42;
	Thu, 22 May 2025 23:17:34 +0800 (CST)
Received: from kwepemq200002.china.huawei.com (7.202.195.90) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 22 May 2025 23:17:33 +0800
Received: from [10.174.177.223] (10.174.177.223) by
 kwepemq200002.china.huawei.com (7.202.195.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 22 May 2025 23:17:32 +0800
Message-ID: <29d3e8fa-8cd0-4c93-a685-619758ab5af4@huawei.com>
Date: Thu, 22 May 2025 23:17:32 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG Report] KASAN: slab-use-after-free in
 page_pool_recycle_in_ring
To: Jakub Kicinski <kuba@kernel.org>, Mina Almasry <almasrymina@google.com>
CC: <hawk@kernel.org>, <ilias.apalodimas@linaro.org>, <davem@davemloft.net>,
	<edumazet@google.com>, <pabeni@redhat.com>, <horms@kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<zhangchangzhong@huawei.com>
References: <20250513083123.3514193-1-dongchenchen2@huawei.com>
 <CAHS8izOio0bnLp3+Vzt44NVgoJpmPTJTACGjWvOXvxVqFKPSwQ@mail.gmail.com>
 <34f06847-f0d8-4ff3-b8a1-0b1484e27ba8@huawei.com>
 <CAHS8izPh5Z-CAJpQzDjhLVN5ye=5i1zaDqb2xQOU3QP08f+Y0Q@mail.gmail.com>
 <20250519154723.4b2243d2@kernel.org>
 <CAHS8izMenFPVAv=OT-PiZ-hLw899JwVpB-8xu+XF+_Onh_4KEw@mail.gmail.com>
 <20250520110625.60455f42@kernel.org>
From: "dongchenchen (A)" <dongchenchen2@huawei.com>
In-Reply-To: <20250520110625.60455f42@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemq200002.china.huawei.com (7.202.195.90)


> On Mon, 19 May 2025 17:53:08 -0700 Mina Almasry wrote:
>> On Mon, May 19, 2025 at 3:47 PM Jakub Kicinski <kuba@kernel.org> wrote:
>>> On Mon, 19 May 2025 12:20:59 -0700 Mina Almasry wrote:
>>>> Clearly this is not working, but I can't tell why.
>>> I think your fix works but for the one line that collects recycling
>>> stats. If we put recycling stats under the producer lock we should
>>> be safe.
>> What are you referring to as recycle stats? Because I don't think
>> pool->recycle_stats have anything to do with freeing the page_pool.
>>
>> Or do you mean that we should put all the call sites that increment
>> and decrement pool->pages_state_release_cnt and
>> pool->pages_state_hold_cnt under the producer lock?
> No, just the "informational" recycling stats. Looking at what Dong
> Chenchen has shared:
>
> page_pool_recycle_in_ring
>     ptr_ring_produce
>       spin_lock(&r->producer_lock);
>       WRITE_ONCE(r->queue[r->producer++], ptr)
>       spin_unlock(&r->producer_lock);
>         //recycle last page to pool
>                                   page_pool_release
>                                     page_pool_scrub
>                                       page_pool_empty_ring
>                                         ptr_ring_consume
>                                         page_pool_return_page //release
> all page
>                                     __page_pool_destroy
> free_percpu(pool->recycle_stats);
>                                        kfree(pool) //free
>     recycle_stat_inc(pool, ring); //uaf read
>
>
> The thread which put the last page into the ring has released the
> producer lock and now it's trying to increment the recycling stats.
> Which is invalid, the page it put into the right was de facto the
> reference it held. So once it put that page in the ring it should
> no longer touch the page pool.
>
> It's not really related to the refcounting itself, the recycling
> stats don't control the lifetime of the object. With your patch
> to turn the producer lock into a proper barrier, the remaining
> issue feels to me like a basic UAF?

Hi, Jakub
Maybe we can fix the problem as follow:

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 7745ad924ae2..de3fa33d6775 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -707,19 +707,18 @@ void page_pool_return_page(struct page_pool *pool, netmem_ref netmem)
  
  static bool page_pool_recycle_in_ring(struct page_pool *pool, netmem_ref netmem)
  {
+	bool in_softirq;
  	int ret;
-	/* BH protection not needed if current is softirq */
-	if (in_softirq())
-		ret = ptr_ring_produce(&pool->ring, (__force void *)netmem);
-	else
-		ret = ptr_ring_produce_bh(&pool->ring, (__force void *)netmem);
  
-	if (!ret) {
+	/* BH protection not needed if current is softirq */
+	in_softirq = page_pool_producer_lock(pool);
+	ret = __ptr_ring_produce(&pool->ring, (__force void *)netmem);
+	if (!ret)
  		recycle_stat_inc(pool, ring);
-		return true;
-	}
  
-	return false;
+	page_pool_producer_unlock(pool, in_softirq);
+
+	return ret ? false : true;
  }
  
  /* Only allow direct recycling in special circumstances, into the

@@ -1091,10 +1090,16 @@ static void page_pool_scrub(struct page_pool *pool)
  
  static int page_pool_release(struct page_pool *pool)
  {
+	bool in_softirq;
  	int inflight;
  
+	/* Acquire producer lock to make sure we don't race with another thread
+	 * returning a netmem to the ptr_ring.
+	 */
+	in_softirq = page_pool_producer_lock(pool);
  	page_pool_scrub(pool);
  	inflight = page_pool_inflight(pool, true);
+	page_pool_producer_unlock(pool, in_softirq);
  	if (!inflight)
  		__page_pool_destroy(pool);
  
I have tested this patch.
-----
Best Regards,
Dong Chenchen


