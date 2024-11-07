Return-Path: <netdev+bounces-142746-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D1799C0373
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 12:10:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 290741F22762
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 11:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C26B1F427A;
	Thu,  7 Nov 2024 11:10:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474B41EE00C;
	Thu,  7 Nov 2024 11:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730977810; cv=none; b=cq8VQ+wmoRpumSZdNNkGe9R54ie8K9OTpVDuga3l0Ye8GB+Z0kr/1a/WJzgZrqkJVI/8/lvV4kjJ7+6628knW2FQ9NBDNCM6W4n3l9JzBO0EdgQwyIPZnhZYkWv9yysZctXChhQ1cARrULs0DkLrfpFXx+xs1uzkMk7AGLWwhog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730977810; c=relaxed/simple;
	bh=kKb7R5SC4UDIPDX6X16du9DvvNtKnjNrWcLF0p25FMU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Z4YM1wP0z8uKT6+/cYKPRUSUpcPX7W82jiS9V8ZkhypJ9ySJE0FzOzCe26EVS4d4f3+20O51QU9Fw0jRlD7QEkGkTVlE1EVxohxZf5JY+DBVsvi12b42eLaYDJBayB5LWYsNcrjMXL2ecWSW9VgoZ9jU2Q2a935mdn6Uz6prHZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4XkfSP4P1WzpZDy;
	Thu,  7 Nov 2024 19:08:05 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 8A293180AEA;
	Thu,  7 Nov 2024 19:09:59 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 7 Nov 2024 19:09:59 +0800
Message-ID: <30ab6359-2ad6-4be0-bf73-59ae454811a9@huawei.com>
Date: Thu, 7 Nov 2024 19:09:52 +0800
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
	<kernel-team@cloudflare.com>, Viktor Malik <vmalik@redhat.com>
References: <20241022032214.3915232-1-linyunsheng@huawei.com>
 <20241022032214.3915232-4-linyunsheng@huawei.com>
 <dbd7dca7-d144-4a0f-9261-e8373be6f8a1@kernel.org>
 <113c9835-f170-46cf-92ba-df4ca5dfab3d@huawei.com> <878qudftsn.fsf@toke.dk>
 <d8e0895b-dd37-44bf-ba19-75c93605fc5e@huawei.com> <87r084e8lc.fsf@toke.dk>
 <0c146fb8-4c95-4832-941f-dfc3a465cf91@kernel.org>
 <204272e7-82c3-4437-bb0d-2c3237275d1f@huawei.com>
 <18ba4489-ad30-423e-9c54-d4025f74c193@kernel.org>
 <b8b7818a-e44b-45f5-91c2-d5eceaa5dd5b@kernel.org>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <b8b7818a-e44b-45f5-91c2-d5eceaa5dd5b@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2024/11/6 23:57, Jesper Dangaard Brouer wrote:

...

>>
>> Some more info from production servers.
>>
>> (I'm amazed what we can do with a simple bpftrace script, Cc Viktor)
>>
>> In below bpftrace script/oneliner I'm extracting the inflight count, for
>> all page_pool's in the system, and storing that in a histogram hash.
>>
>> sudo bpftrace -e '
>>   rawtracepoint:page_pool_state_release { @cnt[probe]=count();
>>    @cnt_total[probe]=count();
>>    $pool=(struct page_pool*)arg0;
>>    $release_cnt=(uint32)arg2;
>>    $hold_cnt=$pool->pages_state_hold_cnt;
>>    $inflight_cnt=(int32)($hold_cnt - $release_cnt);
>>    @inflight=hist($inflight_cnt);
>>   }
>>   interval:s:1 {time("\n%H:%M:%S\n");
>>    print(@cnt); clear(@cnt);
>>    print(@inflight);
>>    print(@cnt_total);
>>   }'
>>
>> The page_pool behavior depend on how NIC driver use it, so I've run this on two prod servers with drivers bnxt and mlx5, on a 6.6.51 kernel.
>>
>> Driver: bnxt_en
>> - kernel 6.6.51
>>
>> @cnt[rawtracepoint:page_pool_state_release]: 8447
>> @inflight:
>> [0]             507 |                                        |
>> [1]             275 |                                        |
>> [2, 4)          261 |                                        |
>> [4, 8)          215 |                                        |
>> [8, 16)         259 |                                        |
>> [16, 32)        361 |                                        |
>> [32, 64)        933 |                                        |
>> [64, 128)      1966 |                                        |
>> [128, 256)   937052 |@@@@@@@@@                               |
>> [256, 512)  5178744 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
>> [512, 1K)     73908 |                                        |
>> [1K, 2K)    1220128 |@@@@@@@@@@@@                            |
>> [2K, 4K)    1532724 |@@@@@@@@@@@@@@@                         |
>> [4K, 8K)    1849062 |@@@@@@@@@@@@@@@@@@                      |
>> [8K, 16K)   1466424 |@@@@@@@@@@@@@@                          |
>> [16K, 32K)   858585 |@@@@@@@@                                |
>> [32K, 64K)   693893 |@@@@@@                                  |
>> [64K, 128K)  170625 |@                                       |
>>
>> Driver: mlx5_core
>>   - Kernel: 6.6.51
>>
>> @cnt[rawtracepoint:page_pool_state_release]: 1975
>> @inflight:
>> [128, 256)         28293 |@@@@                               |
>> [256, 512)        184312 |@@@@@@@@@@@@@@@@@@@@@@@@@@@        |
>> [512, 1K)              0 |                                   |
>> [1K, 2K)            4671 |                                   |
>> [2K, 4K)          342571 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
>> [4K, 8K)          180520 |@@@@@@@@@@@@@@@@@@@@@@@@@@@        |
>> [8K, 16K)          96483 |@@@@@@@@@@@@@@                     |
>> [16K, 32K)         25133 |@@@                                |
>> [32K, 64K)          8274 |@                                  |
>>
>>
>> The key thing to notice that we have up-to 128,000 pages in flight on
>> these random production servers. The NIC have 64 RX queue configured,
>> thus also 64 page_pool objects.
>>
> 
> I realized that we primarily want to know the maximum in-flight pages.
> 
> So, I modified the bpftrace oneliner to track the max for each page_pool in the system.
> 
> sudo bpftrace -e '
>  rawtracepoint:page_pool_state_release { @cnt[probe]=count();
>   @cnt_total[probe]=count();
>   $pool=(struct page_pool*)arg0;
>   $release_cnt=(uint32)arg2;
>   $hold_cnt=$pool->pages_state_hold_cnt;
>   $inflight_cnt=(int32)($hold_cnt - $release_cnt);
>   $cur=@inflight_max[$pool];
>   if ($inflight_cnt > $cur) {
>     @inflight_max[$pool]=$inflight_cnt;}
>  }
>  interval:s:1 {time("\n%H:%M:%S\n");
>   print(@cnt); clear(@cnt);
>   print(@inflight_max);
>   print(@cnt_total);
>  }'
> 
> I've attached the output from the script.
> For unknown reason this system had 199 page_pool objects.

Perhaps some of those page_pool objects are per_cpu page_pool
objects from net_page_pool_create()?

It would be good if the pool_size for those page_pool objects
is printed too.

> 
> The 20 top users:
> 
> $ cat out02.inflight-max | grep inflight_max | tail -n 20
> @inflight_max[0xffff88829133d800]: 26473
> @inflight_max[0xffff888293c3e000]: 27042
> @inflight_max[0xffff888293c3b000]: 27709
> @inflight_max[0xffff8881076f2800]: 29400
> @inflight_max[0xffff88818386e000]: 29690
> @inflight_max[0xffff8882190b1800]: 29813
> @inflight_max[0xffff88819ee83800]: 30067
> @inflight_max[0xffff8881076f4800]: 30086
> @inflight_max[0xffff88818386b000]: 31116
> @inflight_max[0xffff88816598f800]: 36970
> @inflight_max[0xffff8882190b7800]: 37336
> @inflight_max[0xffff888293c38800]: 39265
> @inflight_max[0xffff888293c3c800]: 39632
> @inflight_max[0xffff888293c3b800]: 43461
> @inflight_max[0xffff888293c3f000]: 43787
> @inflight_max[0xffff88816598f000]: 44557
> @inflight_max[0xffff888132ce9000]: 45037
> @inflight_max[0xffff888293c3f800]: 51843
> @inflight_max[0xffff888183869800]: 62612
> @inflight_max[0xffff888113d08000]: 73203
> 
> Adding all values together:
> 
>  grep inflight_max out02.inflight-max | awk 'BEGIN {tot=0} {tot+=$2; printf "total:" tot "\n"}' | tail -n 1
> 
> total:1707129
> 
> Worst case we need a data structure holding 1,707,129 pages.

For 64 bit system, that means about 54MB memory overhead for tracking those
inflight pages if 16 byte memory of metadata needed for each page, I guess
that is ok for those large systems.

> Fortunately, we don't need a single data structure as this will be split
> between 199 page_pool's.

It would be good to have an average value for the number of inflight pages,
so that we might be able to have a statically allocated memory to satisfy
the mostly used case, and use the dynamically allocated memory if/when
necessary.

> 
> --Jesper

