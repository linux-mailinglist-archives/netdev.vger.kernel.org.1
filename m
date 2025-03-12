Return-Path: <netdev+bounces-174178-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D9BA5DC2D
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 13:04:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83CE11882906
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 12:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA4EA22A4DA;
	Wed, 12 Mar 2025 12:04:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427EA1DB124
	for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 12:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741781073; cv=none; b=Yrtnyi9cOMmpLdwb8JUsVSjecz/Vj5qKJdmndOIyIaY82h63mw/uU6TvhAxl4pwOme6KYib4noSvuSfOMYnRhKcICulYucGeUGQsxcF7iUD1PZB5dMo9h0MFLfi+Ras/REq6YccwK677/5/cFnd2j7i+lp2le+CdmHdmFGnDnWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741781073; c=relaxed/simple;
	bh=DtmUpRug21o+2mYUSU9J+26kw6wyal/hRT2esOhLIZw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NyaCw8maKQVOP6s7eN6velVl8CLDBvbD7OB5RK1dVT8q20qqtcaWMXVGwNAcmbDS/sIyXIWtxE/dsjmZfKTMXfp0ohsErMKr9HhkEWk57VCAHtmAjZ7sh5ZeqH57TYS6NBjDESJKEdCfSZFeY3pfmk80AvNmm1+fbGNRTc/FRpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4ZCTm21LV3zqVWK;
	Wed, 12 Mar 2025 20:02:58 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 70CF01401F1;
	Wed, 12 Mar 2025 20:04:27 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 12 Mar 2025 20:04:27 +0800
Message-ID: <ae07144c-9295-4c9d-a400-153bb689fe9e@huawei.com>
Date: Wed, 12 Mar 2025 20:04:26 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next] page_pool: Track DMA-mapped pages and unmap
 them when destroying the pool
To: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>, Yunsheng
 Lin <yunshenglin0825@gmail.com>, Andrew Morton <akpm@linux-foundation.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas
	<ilias.apalodimas@linaro.org>, "David S. Miller" <davem@davemloft.net>
CC: Yonglong Liu <liuyonglong@huawei.com>, Mina Almasry
	<almasrymina@google.com>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, <linux-mm@kvack.org>, <netdev@vger.kernel.org>
References: <20250308145500.14046-1-toke@redhat.com>
 <d84e19c9-be0c-4d23-908b-f5e5ab6f3f3f@gmail.com> <87cyepxn7n.fsf@toke.dk>
 <2c363f6a-f9e4-4dd2-941d-db446c501885@huawei.com> <875xkgykmi.fsf@toke.dk>
 <136f1d94-2cdd-43f6-a195-b87c55df2110@huawei.com> <87wmcvitq8.fsf@toke.dk>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <87wmcvitq8.fsf@toke.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2025/3/11 21:26, Toke Høiland-Jørgensen wrote:
> Yunsheng Lin <linyunsheng@huawei.com> writes:
> 
>> On 2025/3/10 23:24, Toke Høiland-Jørgensen wrote:
>>
>>>>
>>>> I guess that is one of the disadvantages that an advanced struct like
>>>> Xarray is used:(
>>>
>>> Sure, there will be some overhead from using xarray, but I think the
>>> simplicity makes up for it; especially since we can limit this to the
>>
>> As my understanding, it is more complicated, it is just that
>> complexity is hidden before xarray now.
> 
> Yes, which encapsulates the complexity into a shared abstraction that is
> widely used in the kernel, so it does not add new complexity to the
> kernel as a whole. Whereas your series adds a whole bunch of new
> complexity to the kernel in the form of a new slab allocator.
> 
>> Even if there is no space in 'struct page' to store the id, the
>> 'struct page' pointer itself can be used as id if the xarray can
>> use pointer as id. But it might mean the memory utilization might
>> not be as efficient as it should be, and performance hurts too if
>> there is more memory to be allocated and freed.
> 
> I don't think it can. But sure, there can be other ways around this.
> 
> FWIW, I don't think your idea of allocating page_pool_items to use as an
> indirection is totally crazy, but all the complexity around it (the
> custom slab allocator etc) is way too much. And if we can avoid the item
> indirection that is obviously better.
> 
>> It seems it is just a matter of choices between using tailor-made
>> page_pool specific optimization and using some generic advanced
>> struct like xarray.
> 
> Yup, basically.
> 
>> I chose the tailor-made one because it ensure least overhead as
>> much as possibe from performance and memory utilization perspective,
>> for example, the 'single producer, multiple consumer' guarantee
>> offered by NAPI context can avoid some lock and atomic operation.
> 
> Right, and my main point is that the complexity of this is not worth it :)

Without the complexity, there is about 400ns performance overhead
for Xarray compared to about 10ns performance overhead for the
tailor-made one, which means there is about more than 200% performance
degradation for page_pool03_slow test case:

[ 9190.217338] bench_page_pool_simple: Loaded
[ 9190.298495] time_bench: Type:for_loop Per elem: 0 cycles(tsc) 0.770 ns (step:0) - (measurement period time:0.077040570 sec time_interval:77040570) - (invoke count:100000000 tsc_interval:7704049)
[ 9190.893294] time_bench: Type:atomic_inc Per elem: 0 cycles(tsc) 5.775 ns (step:0) - (measurement period time:0.577582060 sec time_interval:577582060) - (invoke count:100000000 tsc_interval:57758202)
[ 9191.061026] time_bench: Type:lock Per elem: 1 cycles(tsc) 15.017 ns (step:0) - (measurement period time:0.150170250 sec time_interval:150170250) - (invoke count:10000000 tsc_interval:15017020)
[ 9191.771113] time_bench: Type:rcu Per elem: 0 cycles(tsc) 6.930 ns (step:0) - (measurement period time:0.693045930 sec time_interval:693045930) - (invoke count:100000000 tsc_interval:69304585)
[ 9231.309907] time_bench: Type:xarray Per elem: 39 cycles(tsc) 395.218 ns (step:0) - (measurement period time:39.521827650 sec time_interval:39521827650) - (invoke count:100000000 tsc_interval:3952182703)
[ 9231.327827] bench_page_pool_simple: time_bench_page_pool01_fast_path(): Cannot use page_pool fast-path
[ 9231.640260] time_bench: Type:no-softirq-page_pool01 Per elem: 3 cycles(tsc) 30.316 ns (step:0) - (measurement period time:0.303162870 sec time_interval:303162870) - (invoke count:10000000 tsc_interval:30316281)
[ 9231.658866] bench_page_pool_simple: time_bench_page_pool02_ptr_ring(): Cannot use page_pool fast-path
[ 9232.244955] time_bench: Type:no-softirq-page_pool02 Per elem: 5 cycles(tsc) 57.691 ns (step:0) - (measurement period time:0.576910280 sec time_interval:576910280) - (invoke count:10000000 tsc_interval:57691015)
[ 9232.263567] bench_page_pool_simple: time_bench_page_pool03_slow(): Cannot use page_pool fast-path
[ 9233.990491] time_bench: Type:no-softirq-page_pool03 Per elem: 17 cycles(tsc) 171.809 ns (step:0) - (measurement period time:1.718090950 sec time_interval:1718090950) - (invoke count:10000000 tsc_interval:171809088)
[ 9234.011402] bench_page_pool_simple: pp_tasklet_handler(): in_serving_softirq fast-path
[ 9234.019286] bench_page_pool_simple: time_bench_page_pool01_fast_path(): in_serving_softirq fast-path
[ 9234.328952] time_bench: Type:tasklet_page_pool01_fast_path Per elem: 3 cycles(tsc) 30.057 ns (step:0) - (measurement period time:0.300574060 sec time_interval:300574060) - (invoke count:10000000 tsc_interval:30057400)
[ 9234.348155] bench_page_pool_simple: time_bench_page_pool02_ptr_ring(): in_serving_softirq fast-path
[ 9234.898627] time_bench: Type:tasklet_page_pool02_ptr_ring Per elem: 5 cycles(tsc) 54.146 ns (step:0) - (measurement period time:0.541466850 sec time_interval:541466850) - (invoke count:10000000 tsc_interval:54146680)
[ 9234.917742] bench_page_pool_simple: time_bench_page_pool03_slow(): in_serving_softirq fast-path
[ 9236.691076] time_bench: Type:tasklet_page_pool03_slow Per elem: 17 cycles(tsc) 176.467 ns (step:0) - (measurement period time:1.764675290 sec time_interval:1764675290) - (invoke count:10000000 tsc_interval:176467523)

Tested using the below diff:
+++ b/kernel/lib/bench_page_pool_simple.c
@@ -149,6 +149,48 @@ static int time_bench_rcu(
        return loops_cnt;
 }

+static int time_bench_xarray(
+       struct time_bench_record *rec, void *data)
+{
+       uint64_t loops_cnt = 0;
+       struct xarray dma_mapped;
+       int i, err;
+       u32 id;
+       void *old;
+
+       xa_init_flags(&dma_mapped, XA_FLAGS_ALLOC1);
+
+       time_bench_start(rec);
+       /** Loop to measure **/
+       for (i = 0; i < rec->loops; i++) {
+
+               if (in_softirq())
+                       err = xa_alloc(&dma_mapped, &id, &dma_mapped,
+                                      XA_LIMIT(1, UINT_MAX), GFP_ATOMIC);
+               else
+                       err = xa_alloc_bh(&dma_mapped, &id, &dma_mapped,
+                                         XA_LIMIT(1, UINT_MAX), GFP_KERNEL);
+
+               if (err)
+                       break;
+
+               loops_cnt++;
+               barrier(); /* avoid compiler to optimize this loop */
+
+               if (in_softirq())
+                       old = xa_cmpxchg(&dma_mapped, id, &dma_mapped, NULL, 0);
+               else
+                       old = xa_cmpxchg_bh(&dma_mapped, id, &dma_mapped, NULL, 0);
+
+               if (old != &dma_mapped)
+                       break;
+       }
+       time_bench_stop(rec, loops_cnt);
+
+       xa_destroy(&dma_mapped);
+       return loops_cnt;
+}
+
 /* Helper for filling some page's into ptr_ring */
 static void pp_fill_ptr_ring(struct page_pool *pp, int elems)
 {
@@ -334,6 +376,8 @@ static int run_benchmark_tests(void)
                                "lock", NULL, time_bench_lock);
                time_bench_loop(nr_loops*10, 0,
                                "rcu", NULL, time_bench_rcu);
+               time_bench_loop(nr_loops*10, 0,
+                               "xarray", NULL, time_bench_xarray);
        }

        /* This test cannot activate correct code path, due to no-softirq ctx */


> 
>>> cases where it's absolutely needed.
>>
>> The above can also be done for using page_pool_item too as the
>> lower 2 bits can be used to indicate the pointer in 'struct page'
>> is 'page_pool_item' or 'page_pool', I just don't think it is
>> necessary yet as it might add more checking in the fast path.
> 
> Yup, did think about using the lower bits to distinguish if it does turn
> out that we can't avoid an indirection. See above; it's not actually the

The 'memdesc' seems like an indirection to me when using that to shrink
'struct page' to a smaller size.

> page_pool_item concept that is my main issue with your series.
> 
> -Toke
> 
> 

