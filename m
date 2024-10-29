Return-Path: <netdev+bounces-139835-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B4229B45D0
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 10:37:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D208B21C30
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 09:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C6C202F64;
	Tue, 29 Oct 2024 09:36:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30FAF7DA82;
	Tue, 29 Oct 2024 09:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730194611; cv=none; b=odLsNzGz4hRWYfUo0JHc5ZQLEQeTHV2pTrQPaBRx2glC3N8PfC6gIA8MMkKL6aManv8oTaAl8cEcQbw5j0wmVAP6D9zxW7bR1I6SyQqXJBViF01cZz2O9Aqd7VEntXAvH1+g3Wh5lsAfK7KYS3EOma9BFf7Xc/y6xRcWw9SGsMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730194611; c=relaxed/simple;
	bh=G+VUmWxJciLVhx0T+swPAwlELVHZLFqMyobDNS0zU3Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=upnVSHx3rIQ+RGTkRFnsUlsu3Pw4aCxzDMiraKFytwaTgqq56VInMtBvcYicXJZ8xdljRxJcgUHeM3eEP9D8hLVWNvgckGMcm1UMvgfrOkvr+RIiN+DbbPvyrwhGPjK06AGhY8n2KYfoeLzLga9wPJqvycuMvoqc2RlVdk4mtRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Xd4r20kl5z20r6G;
	Tue, 29 Oct 2024 17:35:46 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 4F030180019;
	Tue, 29 Oct 2024 17:36:44 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 29 Oct 2024 17:36:44 +0800
Message-ID: <472a7a09-387f-480d-b66c-761e0b6192ef@huawei.com>
Date: Tue, 29 Oct 2024 17:36:43 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v23 0/7] Replace page_frag with page_frag_cache
 (Part-1)
To: Alexander Duyck <alexander.duyck@gmail.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Shuah Khan
	<skhan@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>,
	Linux-MM <linux-mm@kvack.org>
References: <20241028115343.3405838-1-linyunsheng@huawei.com>
 <CAKgT0UdUVo6ujupoo-hdrW95XOGQLCDzd+rHGUVB6_SEmvqFHg@mail.gmail.com>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <CAKgT0UdUVo6ujupoo-hdrW95XOGQLCDzd+rHGUVB6_SEmvqFHg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2024/10/28 23:30, Alexander Duyck wrote:

...

>>
>>
> 
> Is this actually the numbers for this patch set? Seems like you have
> been using the same numbers for the last several releases. I can

Yes, as recent refactoring doesn't seems big enough that the perf data is
reused for the last several releases.

> understand the "before" being mostly the same, but since we have

As there is rebasing for the latest net-next tree, even the 'before'
might not be the same as the testing seems sensitive to other changing,
like binary size changing and page allocator changing during different
version.

So it might need both the same kernel and config for 'before' and 'after'.

> factored out the refactor portion of it the numbers for the "after"
> should have deviated as I find it highly unlikely the numbers are
> exactly the same down to the nanosecond. from the previous patch set.
Below is the the performance data for Part-1 with the latest net-next:

Before this patchset:
 Performance counter stats for 'insmod ./page_frag_test.ko test_push_cpu=16 test_pop_cpu=17 test_alloc_len=12 nr_test=51200000' (200 runs):

         17.990790      task-clock (msec)         #    0.003 CPUs utilized            ( +-  0.19% )
                 8      context-switches          #    0.444 K/sec                    ( +-  0.09% )
                 0      cpu-migrations            #    0.000 K/sec                    ( +-100.00% )
                81      page-faults               #    0.004 M/sec                    ( +-  0.09% )
          46712295      cycles                    #    2.596 GHz                      ( +-  0.19% )
          34466157      instructions              #    0.74  insn per cycle           ( +-  0.01% )
           8011755      branches                  #  445.325 M/sec                    ( +-  0.01% )
             39913      branch-misses             #    0.50% of all branches          ( +-  0.07% )

       6.382252558 seconds time elapsed                                          ( +-  0.07% )

 Performance counter stats for 'insmod ./page_frag_test.ko test_push_cpu=16 test_pop_cpu=17 test_alloc_len=12 nr_test=51200000 test_align=1' (200 runs):

         17.638466      task-clock (msec)         #    0.003 CPUs utilized            ( +-  0.01% )
                 8      context-switches          #    0.451 K/sec                    ( +-  0.20% )
                 0      cpu-migrations            #    0.001 K/sec                    ( +- 70.53% )
                81      page-faults               #    0.005 M/sec                    ( +-  0.08% )
          45794305      cycles                    #    2.596 GHz                      ( +-  0.01% )
          34435077      instructions              #    0.75  insn per cycle           ( +-  0.00% )
           8004416      branches                  #  453.805 M/sec                    ( +-  0.00% )
             39758      branch-misses             #    0.50% of all branches          ( +-  0.06% )

       5.328976590 seconds time elapsed                                          ( +-  0.60% )


After this patchset:
Performance counter stats for 'insmod ./page_frag_test.ko test_push_cpu=16 test_pop_cpu=17 test_alloc_len=12 nr_test=51200000' (200 runs):

         18.647432      task-clock (msec)         #    0.003 CPUs utilized            ( +-  1.11% )
                 8      context-switches          #    0.422 K/sec                    ( +-  0.36% )
                 0      cpu-migrations            #    0.005 K/sec                    ( +- 22.54% )
                81      page-faults               #    0.004 M/sec                    ( +-  0.08% )
          48418108      cycles                    #    2.597 GHz                      ( +-  1.11% )
          35889299      instructions              #    0.74  insn per cycle           ( +-  0.11% )
           8318363      branches                  #  446.086 M/sec                    ( +-  0.11% )
             19263      branch-misses             #    0.23% of all branches          ( +-  0.13% )

       5.624666079 seconds time elapsed                                          ( +-  0.07% )


 Performance counter stats for 'insmod ./page_frag_test.ko test_push_cpu=16 test_pop_cpu=17 test_alloc_len=12 nr_test=51200000 test_align=1' (200 runs):

         18.466768      task-clock (msec)         #    0.007 CPUs utilized            ( +-  1.23% )
                 8      context-switches          #    0.428 K/sec                    ( +-  0.26% )
                 0      cpu-migrations            #    0.002 K/sec                    ( +- 34.73% )
                81      page-faults               #    0.004 M/sec                    ( +-  0.09% )
          47949220      cycles                    #    2.597 GHz                      ( +-  1.23% )
          35859039      instructions              #    0.75  insn per cycle           ( +-  0.12% )
           8309086      branches                  #  449.948 M/sec                    ( +-  0.11% )
             19246      branch-misses             #    0.23% of all branches          ( +-  0.08% )

       2.573546035 seconds time elapsed                                          ( +-  0.04% )

> 
> Also it wouldn't hurt to have an explanation for the 3.4->0.9 second
> performance change as it seems like the samples don't seem to match up
> with the elapsed time data.

As there is also a 4.6->3.4 second performance change for the 'before'
part, I am not really thinking much at that.

I am guessing some timing for implementation of ptr_ring or cpu cache
cause the above performance change?

I used the same cpu for both pop and push thread, the performance change
doesn't seems to exist anymore, and the performance improvement doesn't
seems to exist anymore either:

After this patchset:
 Performance counter stats for 'insmod ./page_frag_test.ko test_push_cpu=0 test_pop_cpu=0 test_alloc_len=12 nr_test=512000' (10 runs):

         13.293402      task-clock (msec)         #    0.002 CPUs utilized            ( +-  5.05% )
                 7      context-switches          #    0.534 K/sec                    ( +-  1.41% )
                 0      cpu-migrations            #    0.015 K/sec                    ( +-100.00% )
                80      page-faults               #    0.006 M/sec                    ( +-  0.38% )
          34494793      cycles                    #    2.595 GHz                      ( +-  5.05% )
           9663299      instructions              #    0.28  insn per cycle           ( +-  1.45% )
           1767284      branches                  #  132.944 M/sec                    ( +-  1.70% )
             19798      branch-misses             #    1.12% of all branches          ( +-  1.18% )

       8.119681413 seconds time elapsed                                          ( +-  0.01% )

 Performance counter stats for 'insmod ./page_frag_test.ko test_push_cpu=0 test_pop_cpu=0 test_alloc_len=12 nr_test=512000 test_align=1' (10 runs):

         12.289096      task-clock (msec)         #    0.002 CPUs utilized            ( +-  0.07% )
                 7      context-switches          #    0.570 K/sec                    ( +-  2.13% )
                 0      cpu-migrations            #    0.033 K/sec                    ( +- 66.67% )
                81      page-faults               #    0.007 M/sec                    ( +-  0.43% )
          31886319      cycles                    #    2.595 GHz                      ( +-  0.07% )
           9468850      instructions              #    0.30  insn per cycle           ( +-  0.06% )
           1723487      branches                  #  140.245 M/sec                    ( +-  0.05% )
             19263      branch-misses             #    1.12% of all branches          ( +-  0.47% )

       8.119686950 seconds time elapsed                                          ( +-  0.01% )

Before this patchset:
 Performance counter stats for 'insmod ./page_frag_test.ko test_push_cpu=0 test_pop_cpu=0 test_alloc_len=12 nr_test=512000' (10 runs):

         13.320328      task-clock (msec)         #    0.002 CPUs utilized            ( +-  5.00% )
                 7      context-switches          #    0.541 K/sec                    ( +-  1.85% )
                 0      cpu-migrations            #    0.008 K/sec                    ( +-100.00% )
                80      page-faults               #    0.006 M/sec                    ( +-  0.36% )
          34572091      cycles                    #    2.595 GHz                      ( +-  5.01% )
           9664910      instructions              #    0.28  insn per cycle           ( +-  1.51% )
           1768276      branches                  #  132.750 M/sec                    ( +-  1.80% )
             19592      branch-misses             #    1.11% of all branches          ( +-  1.33% )

       8.119686381 seconds time elapsed                                          ( +-  0.01% )

 Performance counter stats for 'insmod ./page_frag_test.ko test_push_cpu=0 test_pop_cpu=0 test_alloc_len=12 nr_test=512000 test_align=1' (10 runs):

         12.306471      task-clock (msec)         #    0.002 CPUs utilized            ( +-  0.08% )
                 7      context-switches          #    0.585 K/sec                    ( +-  1.85% )
                 0      cpu-migrations            #    0.000 K/sec
                80      page-faults               #    0.007 M/sec                    ( +-  0.28% )
          31937686      cycles                    #    2.595 GHz                      ( +-  0.08% )
           9462218      instructions              #    0.30  insn per cycle           ( +-  0.08% )
           1721989      branches                  #  139.925 M/sec                    ( +-  0.07% )
             19114      branch-misses             #    1.11% of all branches          ( +-  0.31% )

       8.118897296 seconds time elapsed                                          ( +-  0.00% )

