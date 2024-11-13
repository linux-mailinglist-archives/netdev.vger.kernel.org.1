Return-Path: <netdev+bounces-144394-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 481069C6EF5
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 13:22:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8C371F21970
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 12:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D2F2010EB;
	Wed, 13 Nov 2024 12:21:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58938200C85;
	Wed, 13 Nov 2024 12:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731500491; cv=none; b=tpG2CSd5srywgpXsOWdYqssQ1MsvOvnny0HpIwv7Qag7bxqOoFfTKWn1MDEQ3U7QwEombzsbmzgBHJiJOTWRwjVBWtZVM+Yj/f873q6i2KEsEzBYL/2FbRfPAYhteJLaO/ARxNpTkv2l/S4q+sK8PpsRQXe2e3al6N2XNFDfcXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731500491; c=relaxed/simple;
	bh=VbF/dsN12M7jjWNXzrN3hOzknHuriciZPRN8to0/gxw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tsVIdd9EUEzg4zYmA2oPtivvUhUFzOMhIB7DMwHY++HnlcpxMl2mCq7U2tjNbjZlOm12CVEkJtGeu+UspbzounBNj1POOlzAxWIHeKWxoruh+N75zi0E1Ho9Hrc/491PjZaoTXOTPLIiBH2dcHSsE6KeHU1DS5vcaXQEIzQ2xgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4XpMmq0RqXz21kGy;
	Wed, 13 Nov 2024 20:20:11 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id A4F681401F2;
	Wed, 13 Nov 2024 20:21:25 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 13 Nov 2024 20:21:25 +0800
Message-ID: <59675831-d52e-47c0-85ca-5d3bf4d44917@huawei.com>
Date: Wed, 13 Nov 2024 20:21:25 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 3/3] page_pool: fix IOMMU crash when driver
 has already unbound
To: Jesper Dangaard Brouer <hawk@kernel.org>,
	=?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <zhangkun09@huawei.com>, <fanghaiqing@huawei.com>,
	<liuyonglong@huawei.com>, Robin Murphy <robin.murphy@arm.com>, Alexander
 Duyck <alexander.duyck@gmail.com>, IOMMU <iommu@lists.linux.dev>, Andrew
 Morton <akpm@linux-foundation.org>, Eric Dumazet <edumazet@google.com>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>, kernel-team
	<kernel-team@cloudflare.com>
References: <20241022032214.3915232-1-linyunsheng@huawei.com>
 <20241022032214.3915232-4-linyunsheng@huawei.com>
 <dbd7dca7-d144-4a0f-9261-e8373be6f8a1@kernel.org>
 <113c9835-f170-46cf-92ba-df4ca5dfab3d@huawei.com> <878qudftsn.fsf@toke.dk>
 <d8e0895b-dd37-44bf-ba19-75c93605fc5e@huawei.com> <87r084e8lc.fsf@toke.dk>
 <0c146fb8-4c95-4832-941f-dfc3a465cf91@kernel.org>
 <204272e7-82c3-4437-bb0d-2c3237275d1f@huawei.com>
 <4564c77b-a54d-4307-b043-d08e314c4c5f@huawei.com> <87ldxp4n9v.fsf@toke.dk>
 <eab44c89-5ada-48b6-b880-65967c0f3b49@huawei.com>
 <be049c33-936a-4c93-94ff-69cd51b5de8e@kernel.org>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <be049c33-936a-4c93-94ff-69cd51b5de8e@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2024/11/12 22:19, Jesper Dangaard Brouer wrote:

...

>>>
>>> In any case, we'll need some numbers to really judge the overhead in
>>> practice. So benchmarking would be the logical next step in any case :)
>>
>> Using POC code show that using the dynamic memory allocation does not
>> seems to be adding much overhead than the pre-allocated memory allocation
>> in this patch, the overhead is about 10~20ns, which seems to be similar to
>> the overhead of added overhead in the patch.
>>
> 
> Overhead around 10~20ns is too large for page_pool, because XDP DDoS
> use-case have a very small time budget (which is what page_pool was
> designed for).

I should have mentioned that the above 10~20ns overhead is from the
test case of time_bench_page_pool03_slow() in bench_page_pool_simple.

More detailed test result as below:

After:
root@(none)$ taskset -c 0 insmod bench_page_pool_simple.ko
[   50.359865] bench_page_pool_simple: Loaded
[   50.440982] time_bench: Type:for_loop Per elem: 0 cycles(tsc) 0.769 ns (step:0) - (measurement period time:0.076980410 sec time_interval:76980410) - (invoke count:100000000 tsc_interval:7698030)
[   52.497915] time_bench: Type:atomic_inc Per elem: 2 cycles(tsc) 20.396 ns (step:0) - (measurement period time:2.039650210 sec time_interval:2039650210) - (invoke count:100000000 tsc_interval:203965016)
[   52.665872] time_bench: Type:lock Per elem: 1 cycles(tsc) 15.006 ns (step:0) - (measurement period time:0.150067780 sec time_interval:150067780) - (invoke count:10000000 tsc_interval:15006773)
[   53.337133] time_bench: Type:rcu Per elem: 0 cycles(tsc) 6.541 ns (step:0) - (measurement period time:0.654153620 sec time_interval:654153620) - (invoke count:100000000 tsc_interval:65415355)
[   53.354152] bench_page_pool_simple: time_bench_page_pool01_fast_path(): Cannot use page_pool fast-path
[   53.647814] time_bench: Type:no-softirq-page_pool01 Per elem: 2 cycles(tsc) 28.436 ns (step:0) - (measurement period time:0.284369800 sec time_interval:284369800) - (invoke count:10000000 tsc_interval:28436974)
[   53.666482] bench_page_pool_simple: time_bench_page_pool02_ptr_ring(): Cannot use page_pool fast-path
[   54.264789] time_bench: Type:no-softirq-page_pool02 Per elem: 5 cycles(tsc) 58.910 ns (step:0) - (measurement period time:0.589102240 sec time_interval:589102240) - (invoke count:10000000 tsc_interval:58910216)
[   54.283459] bench_page_pool_simple: time_bench_page_pool03_slow(): Cannot use page_pool fast-path
[   56.202440] time_bench: Type:no-softirq-page_pool03 Per elem: 19 cycles(tsc) 191.012 ns (step:0) - (measurement period time:1.910122260 sec time_interval:1910122260) - (invoke count:10000000 tsc_interval:191012216)
[   56.221463] bench_page_pool_simple: pp_tasklet_handler(): in_serving_softirq fast-path
[   56.229367] bench_page_pool_simple: time_bench_page_pool01_fast_path(): in_serving_softirq fast-path
[   56.521551] time_bench: Type:tasklet_page_pool01_fast_path Per elem: 2 cycles(tsc) 28.306 ns (step:0) - (measurement period time:0.283066000 sec time_interval:283066000) - (invoke count:10000000 tsc_interval:28306590)
[   56.540827] bench_page_pool_simple: time_bench_page_pool02_ptr_ring(): in_serving_softirq fast-path
[   57.203988] time_bench: Type:tasklet_page_pool02_ptr_ring Per elem: 6 cycles(tsc) 65.412 ns (step:0) - (measurement period time:0.654129240 sec time_interval:654129240) - (invoke count:10000000 tsc_interval:65412917)
[   57.223177] bench_page_pool_simple: time_bench_page_pool03_slow(): in_serving_softirq fast-path
[   59.297677] time_bench: Type:tasklet_page_pool03_slow Per elem: 20 cycles(tsc) 206.581 ns (step:0) - (measurement period time:2.065816850 sec time_interval:2065816850) - (invoke count:10000000 tsc_interval:206581679)


Before:
root@(none)$ taskset -c 0 insmod bench_page_pool_simple.ko
[  519.020980] bench_page_pool_simple: Loaded
[  519.102080] time_bench: Type:for_loop Per elem: 0 cycles(tsc) 0.769 ns (step:0) - (measurement period time:0.076979320 sec time_interval:76979320) - (invoke count:100000000 tsc_interval:7697917)
[  520.466133] time_bench: Type:atomic_inc Per elem: 1 cycles(tsc) 13.467 ns (step:0) - (measurement period time:1.346763300 sec time_interval:1346763300) - (invoke count:100000000 tsc_interval:134676325)
[  520.634079] time_bench: Type:lock Per elem: 1 cycles(tsc) 15.005 ns (step:0) - (measurement period time:0.150054340 sec time_interval:150054340) - (invoke count:10000000 tsc_interval:15005430)
[  521.190881] time_bench: Type:rcu Per elem: 0 cycles(tsc) 5.396 ns (step:0) - (measurement period time:0.539696370 sec time_interval:539696370) - (invoke count:100000000 tsc_interval:53969632)
[  521.207901] bench_page_pool_simple: time_bench_page_pool01_fast_path(): Cannot use page_pool fast-path
[  521.514478] time_bench: Type:no-softirq-page_pool01 Per elem: 2 cycles(tsc) 29.728 ns (step:0) - (measurement period time:0.297282500 sec time_interval:297282500) - (invoke count:10000000 tsc_interval:29728246)
[  521.533148] bench_page_pool_simple: time_bench_page_pool02_ptr_ring(): Cannot use page_pool fast-path
[  522.117048] time_bench: Type:no-softirq-page_pool02 Per elem: 5 cycles(tsc) 57.469 ns (step:0) - (measurement period time:0.574694970 sec time_interval:574694970) - (invoke count:10000000 tsc_interval:57469491)
[  522.135717] bench_page_pool_simple: time_bench_page_pool03_slow(): Cannot use page_pool fast-path
[  523.962813] time_bench: Type:no-softirq-page_pool03 Per elem: 18 cycles(tsc) 181.823 ns (step:0) - (measurement period time:1.818238850 sec time_interval:1818238850) - (invoke count:10000000 tsc_interval:181823878)
[  523.981837] bench_page_pool_simple: pp_tasklet_handler(): in_serving_softirq fast-path
[  523.989742] bench_page_pool_simple: time_bench_page_pool01_fast_path(): in_serving_softirq fast-path
[  524.296961] time_bench: Type:tasklet_page_pool01_fast_path Per elem: 2 cycles(tsc) 29.810 ns (step:0) - (measurement period time:0.298100890 sec time_interval:298100890) - (invoke count:10000000 tsc_interval:29810083)
[  524.316236] bench_page_pool_simple: time_bench_page_pool02_ptr_ring(): in_serving_softirq fast-path
[  524.852783] time_bench: Type:tasklet_page_pool02_ptr_ring Per elem: 5 cycles(tsc) 52.751 ns (step:0) - (measurement period time:0.527516430 sec time_interval:527516430) - (invoke count:10000000 tsc_interval:52751638)
[  524.871972] bench_page_pool_simple: time_bench_page_pool03_slow(): in_serving_softirq fast-path
[  526.710040] time_bench: Type:tasklet_page_pool03_slow Per elem: 18 cycles(tsc) 182.938 ns (step:0) - (measurement period time:1.829384610 sec time_interval:1829384610) - (invoke count:10000000 tsc_interval:182938456)


> 
> [1] https://github.com/xdp-project/xdp-project/blob/master/areas/hints/traits01_bench_kmod.org#benchmark-basics
> 
>  | Link speed | Packet rate           | Time-budget   |
>  |            | at smallest pkts size | per packet    |
>  |------------+-----------------------+---------------|
>  |  10 Gbit/s |  14,880,952 pps       | 67.2 nanosec  |
>  |  25 Gbit/s |  37,202,381 pps       | 26.88 nanosec |
>  | 100 Gbit/s | 148,809,523 pps       |  6.72 nanosec |
> 
> 
> --Jesper

