Return-Path: <netdev+bounces-151086-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C49839ECC9C
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 13:52:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 073C81888C6B
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 12:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF5E623FD04;
	Wed, 11 Dec 2024 12:52:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9630A23FD00;
	Wed, 11 Dec 2024 12:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733921548; cv=none; b=Ne9De027iXuwO02CCpXNhPT/IM/HRaXd1mhHCriGXVIri7NGQ7+ETGwR6Oa4vT791YwQN3ncgWRe7ch7dF9m/hoia9WUYxAMUExaiCyLa9NY15a2iGyLO+3aB9JZsvTFH3HjWaqMw4JuZNBeQKNPV4Qd0ndkk7saindN2X7ddvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733921548; c=relaxed/simple;
	bh=1607GGABTEokozmx5ur7ARJ/8i0OR0tZHAUiMLWMWZs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=IcR12d98+jWYljYS8DDIJedYXZFX9JCHLVZ3hO4oJnFqjT+VY1e1MIwkPKlaUKTlAmpRrEB41kkGudus7fTTAxLyrSV6gbJ8zB2f9peoo6ZJ6WCoH8wLLxkWsCEFrzEO1kreccqf0xxMRwO3Fl8ng5ZvFeCo1LM2a4O0BlFbkvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Y7b9F2b2nz20ldZ;
	Wed, 11 Dec 2024 20:52:33 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 5F780140120;
	Wed, 11 Dec 2024 20:52:16 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 11 Dec 2024 20:52:16 +0800
Message-ID: <389876b8-e565-4dc9-bc87-d97a639ff585@huawei.com>
Date: Wed, 11 Dec 2024 20:52:15 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 00/10] Replace page_frag with page_frag_cache
 (Part-2)
To: Alexander Duyck <alexander.duyck@gmail.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Shuah Khan
	<skhan@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>,
	Linux-MM <linux-mm@kvack.org>
References: <20241206122533.3589947-1-linyunsheng@huawei.com>
 <CAKgT0UeXcsB-HOyeA7kYKHmEUM+d_mbTQJRhXfaiFBg_HcWV0w@mail.gmail.com>
 <3de1b8a3-ae4f-492f-969d-bc6f2c145d09@huawei.com>
 <CAKgT0Uc5A_mtN_qxR6w5zqDbx87SUdCTFOBxVWCarnryRvhqHA@mail.gmail.com>
 <15723762-7800-4498-845e-7383a88f147b@huawei.com>
 <CAKgT0Uf7V+wMa7zz+9j9gwHC+hia3OwL_bo_O-yhn4=Xh0WadA@mail.gmail.com>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <CAKgT0Uf7V+wMa7zz+9j9gwHC+hia3OwL_bo_O-yhn4=Xh0WadA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2024/12/10 23:58, Alexander Duyck wrote:

> 
> I'm not sure perf stat will tell us much as it is really too high
> level to give us much in the way of details. I would be more
> interested in the output from perf record -g followed by a perf
> report, or maybe even just a snapshot from perf top while the test is
> running. That should show us where the CPU is spending most of its
> time and what areas are hot in the before and after graphs.

It seems the bottleneck is in the freeing side that page_frag_free()
function took up to about 50% cpu for non-aligned API and 16% cpu
for aligned API in the push CPU using 'perf top'.

Using the below patch cause the page_frag_free() to disappear in the
push CPU  of 'perf top', new performance data is below:
Without patch 1:
 Performance counter stats for 'insmod ./page_frag_test.ko test_push_cpu=0 test_pop_cpu=1 test_alloc_len=12 nr_test=51200000' (20 runs):

         21.084113      task-clock (msec)         #    0.008 CPUs utilized            ( +-  1.59% )
                 7      context-switches          #    0.334 K/sec                    ( +-  1.25% )
                 1      cpu-migrations            #    0.031 K/sec                    ( +- 20.20% )
                78      page-faults               #    0.004 M/sec                    ( +-  0.26% )
          54748233      cycles                    #    2.597 GHz                      ( +-  1.59% )
          61637051      instructions              #    1.13  insn per cycle           ( +-  0.13% )
          14727268      branches                  #  698.501 M/sec                    ( +-  0.11% )
             20178      branch-misses             #    0.14% of all branches          ( +-  0.94% )

       2.637345524 seconds time elapsed                                          ( +-  0.19% )

 Performance counter stats for 'insmod ./page_frag_test.ko test_push_cpu=0 test_pop_cpu=1 test_alloc_len=12 nr_test=51200000 test_align=1' (20 runs):

         19.669259      task-clock (msec)         #    0.009 CPUs utilized            ( +-  2.91% )
                 7      context-switches          #    0.356 K/sec                    ( +-  1.04% )
                 0      cpu-migrations            #    0.005 K/sec                    ( +- 68.82% )
                77      page-faults               #    0.004 M/sec                    ( +-  0.27% )
          51077447      cycles                    #    2.597 GHz                      ( +-  2.91% )
          58875368      instructions              #    1.15  insn per cycle           ( +-  4.47% )
          14040015      branches                  #  713.805 M/sec                    ( +-  4.68% )
             20150      branch-misses             #    0.14% of all branches          ( +-  0.64% )

       2.226539190 seconds time elapsed                                          ( +-  0.12% )

With patch 1:
 Performance counter stats for 'insmod ./page_frag_test.ko test_push_cpu=0 test_pop_cpu=1 test_alloc_len=12 nr_test=51200000' (20 runs):

         20.782788      task-clock (msec)         #    0.008 CPUs utilized            ( +-  0.09% )
                 7      context-switches          #    0.342 K/sec                    ( +-  0.97% )
                 1      cpu-migrations            #    0.031 K/sec                    ( +- 16.83% )
                78      page-faults               #    0.004 M/sec                    ( +-  0.31% )
          53967333      cycles                    #    2.597 GHz                      ( +-  0.08% )
          61577257      instructions              #    1.14  insn per cycle           ( +-  0.02% )
          14712140      branches                  #  707.900 M/sec                    ( +-  0.02% )
             20234      branch-misses             #    0.14% of all branches          ( +-  0.55% )

       2.677974457 seconds time elapsed                                          ( +-  0.15% )

root@(none):/home# perf stat -r 20 insmod ./page_frag_test.ko test_push_cpu=0 test_pop_cpu=1 test_alloc_len=12 nr_test=51200000 test_align=1

insmod: can't insert './page_frag_test.ko': Resource temporarily unavailable

 Performance counter stats for 'insmod ./page_frag_test.ko test_push_cpu=0 test_pop_cpu=1 test_alloc_len=12 nr_test=51200000 test_align=1' (20 runs):

         20.420537      task-clock (msec)         #    0.009 CPUs utilized            ( +-  0.05% )
                 7      context-switches          #    0.345 K/sec                    ( +-  0.71% )
                 0      cpu-migrations            #    0.005 K/sec                    ( +-100.00% )
                77      page-faults               #    0.004 M/sec                    ( +-  0.23% )
          53038942      cycles                    #    2.597 GHz                      ( +-  0.05% )
          59965712      instructions              #    1.13  insn per cycle           ( +-  0.03% )
          14372507      branches                  #  703.826 M/sec                    ( +-  0.03% )
             20580      branch-misses             #    0.14% of all branches          ( +-  0.56% )

       2.287783171 seconds time elapsed                                          ( +-  0.12% )

It seems that bottleneck is still the freeing side that the above
result might not be as meaningful as it should be.

As we can't use more than one cpu for the free side without some
lock using a single ptr_ring, it seems something more complicated
might need to be done in order to support more than one CPU for the
freeing side?

Before patch 1, __page_frag_alloc_align took up to 3.62% percent of
CPU using 'perf top'.
After patch 1, __page_frag_cache_prepare() and __page_frag_cache_commit_noref()
took up to 4.67% + 1.01% = 5.68%.
Having a similar result, I am not sure if the CPU usages is able tell us
the performance degradation here as it seems to be quite large?

@@ -100,13 +100,20 @@ static int page_frag_push_thread(void *arg)
                if (!va)
                        continue;

-               ret = __ptr_ring_produce(ring, va);
-               if (ret) {
+               do {
+                       ret = __ptr_ring_produce(ring, va);
+                       if (!ret) {
+                               va = NULL;
+                               break;
+                       } else {
+                               cond_resched();
+                       }
+               } while (!force_exit);
+
+               if (va)
                        page_frag_free(va);
-                       cond_resched();
-               } else {
+               else
                        test_pushed++;
-               }
        }

        pr_info("page_frag push test thread exits on cpu %d\n",


