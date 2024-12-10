Return-Path: <netdev+bounces-150640-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E06AF9EB0C6
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 13:28:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E667D169B43
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 12:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6046F1A2860;
	Tue, 10 Dec 2024 12:27:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818AC1A0B13;
	Tue, 10 Dec 2024 12:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733833677; cv=none; b=M9mMhPLdExODHGcBifp1LHvJl2T/SxRm3SiHT9QRRx4DDEhaAvmYvDfY1xuu5Ls/cB2s/8OxWsJKLEpW8ONlvgv+8WCQxIKYKV4pJpONtjvQrxfOjbhtV9Hm9P+2L4Pq9WJq2TKv/qf+UxZiSq3J9ng3/3hgikVQjHLgO50c3+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733833677; c=relaxed/simple;
	bh=ganln+D4xNzlwYh7D2OC/peE/u4j3wR2w+MYlnF4skw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jPvNcrHLWV8LyOYKsWW/RGGZclVgSNrwTg06Vn/dF7C98YmXe4DoAFxQiVbjb7/BqGH8jXS0p33xBn2o7Ne/3OZTryVnZGe1XJIcdKAGJ2slQM7hdfHghD0HtR+krsja5PXGchQu7F1fgD5to6wg8pPqDXy95Fn4nTkrQs9WZpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Y6ygQ4JgHz27gDx;
	Tue, 10 Dec 2024 20:28:02 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id CC5F9140136;
	Tue, 10 Dec 2024 20:27:45 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 10 Dec 2024 20:27:45 +0800
Message-ID: <15723762-7800-4498-845e-7383a88f147b@huawei.com>
Date: Tue, 10 Dec 2024 20:27:45 +0800
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
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <CAKgT0Uc5A_mtN_qxR6w5zqDbx87SUdCTFOBxVWCarnryRvhqHA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2024/12/10 0:03, Alexander Duyck wrote:

...

> 
> Other than code size have you tried using perf to profile the
> benchmark before and after. I suspect that would be telling about
> which code changes are the most likely to be causing the issues.
> Overall I don't think the size has increased all that much. I suspect
> most of this is the fact that you are inlining more of the
> functionality.

It seems the testing result is very sensitive to code changing and
reorganizing, as using the patch at the end to avoid the problem of
'perf stat' not including data from the kernel thread seems to provide
more reasonable performance data.

It seems the most obvious difference is 'insn per cycle' and I am not
sure how to interpret the difference of below data for the performance
degradation yet.

With patch 1:
 Performance counter stats for 'taskset -c 0 insmod ./page_frag_test.ko test_push_cpu=-1 test_pop_cpu=1 test_alloc_len=12 nr_test=51200000':

       5473.815250      task-clock (msec)         #    0.984 CPUs utilized
                18      context-switches          #    0.003 K/sec
                 1      cpu-migrations            #    0.000 K/sec
               122      page-faults               #    0.022 K/sec
       14210894727      cycles                    #    2.596 GHz                      (92.78%)
       18903171767      instructions              #    1.33  insn per cycle           (92.82%)
        2997494420      branches                  #  547.606 M/sec                    (92.84%)
           7539978      branch-misses             #    0.25% of all branches          (92.84%)
        6291190031      L1-dcache-loads           # 1149.325 M/sec                    (92.78%)
          29874701      L1-dcache-load-misses     #    0.47% of all L1-dcache hits    (92.82%)
          57979668      LLC-loads                 #   10.592 M/sec                    (92.79%)
            347822      LLC-load-misses           #    0.01% of all LL-cache hits     (92.90%)
        5946042629      L1-icache-loads           # 1086.270 M/sec                    (92.91%)
            193877      L1-icache-load-misses                                         (92.91%)
        6820220221      dTLB-loads                # 1245.972 M/sec                    (92.91%)
            137999      dTLB-load-misses          #    0.00% of all dTLB cache hits   (92.91%)
        5947607438      iTLB-loads                # 1086.556 M/sec                    (92.91%)
               210      iTLB-load-misses          #    0.00% of all iTLB cache hits   (85.66%)
   <not supported>      L1-dcache-prefetches
   <not supported>      L1-dcache-prefetch-misses

       5.563068950 seconds time elapsed

Without patch 1:
root@(none):/home# perf stat -d -d -d taskset -c 0 insmod ./page_frag_test.ko test_push_cpu=-1 test_pop_cpu=1 test_alloc_len=12 nr_test=51200000
insmod: can't insert './page_frag_test.ko': Resource temporarily unavailable

 Performance counter stats for 'taskset -c 0 insmod ./page_frag_test.ko test_push_cpu=-1 test_pop_cpu=1 test_alloc_len=12 nr_test=51200000':

       5306.644600      task-clock (msec)         #    0.984 CPUs utilized
                15      context-switches          #    0.003 K/sec
                 1      cpu-migrations            #    0.000 K/sec
               122      page-faults               #    0.023 K/sec
       13776872322      cycles                    #    2.596 GHz                      (92.84%)
       13257649773      instructions              #    0.96  insn per cycle           (92.82%)
        2446901087      branches                  #  461.101 M/sec                    (92.91%)
           7172751      branch-misses             #    0.29% of all branches          (92.84%)
        5041456343      L1-dcache-loads           #  950.027 M/sec                    (92.84%)
          38418414      L1-dcache-load-misses     #    0.76% of all L1-dcache hits    (92.76%)
          65486400      LLC-loads                 #   12.340 M/sec                    (92.82%)
            191497      LLC-load-misses           #    0.01% of all LL-cache hits     (92.79%)
        4906456833      L1-icache-loads           #  924.587 M/sec                    (92.90%)
            175208      L1-icache-load-misses                                         (92.91%)
        5539879607      dTLB-loads                # 1043.952 M/sec                    (92.91%)
            140166      dTLB-load-misses          #    0.00% of all dTLB cache hits   (92.91%)
        4906685698      iTLB-loads                #  924.631 M/sec                    (92.91%)
               170      iTLB-load-misses          #    0.00% of all iTLB cache hits   (85.66%)
   <not supported>      L1-dcache-prefetches
   <not supported>      L1-dcache-prefetch-misses

       5.395104330 seconds time elapsed


Below is perf data for aligned API without patch 1, as above non-aligned
API also use test_alloc_len as 12, theoretically the performance data
should not be better than the non-aligned API as the aligned API will do
the aligning of fragsz basing on SMP_CACHE_BYTES, but the testing seems
to show otherwise and I am not sure how to interpret that too:
perf stat -d -d -d taskset -c 0 insmod ./page_frag_test.ko test_push_cpu=-1 test_pop_cpu=1 test_alloc_len=12 nr_test=51200000 test_align=1
insmod: can't insert './page_frag_test.ko': Resource temporarily unavailable

 Performance counter stats for 'taskset -c 0 insmod ./page_frag_test.ko test_push_cpu=-1 test_pop_cpu=1 test_alloc_len=12 nr_test=51200000 test_align=1':

       2447.553100      task-clock (msec)         #    0.965 CPUs utilized
                 9      context-switches          #    0.004 K/sec
                 1      cpu-migrations            #    0.000 K/sec
               122      page-faults               #    0.050 K/sec
        6354149177      cycles                    #    2.596 GHz                      (92.81%)
        6467793726      instructions              #    1.02  insn per cycle           (92.76%)
        1120749183      branches                  #  457.906 M/sec                    (92.81%)
           7370402      branch-misses             #    0.66% of all branches          (92.81%)
        2847963759      L1-dcache-loads           # 1163.596 M/sec                    (92.76%)
          39439592      L1-dcache-load-misses     #    1.38% of all L1-dcache hits    (92.77%)
          42553468      LLC-loads                 #   17.386 M/sec                    (92.71%)
             95960      LLC-load-misses           #    0.01% of all LL-cache hits     (92.94%)
        2554887203      L1-icache-loads           # 1043.854 M/sec                    (92.97%)
            118902      L1-icache-load-misses                                         (92.97%)
        3365755289      dTLB-loads                # 1375.151 M/sec                    (92.97%)
             81401      dTLB-load-misses          #    0.00% of all dTLB cache hits   (92.97%)
        2554882937      iTLB-loads                # 1043.852 M/sec                    (92.97%)
               159      iTLB-load-misses          #    0.00% of all iTLB cache hits   (85.58%)
   <not supported>      L1-dcache-prefetches
   <not supported>      L1-dcache-prefetch-misses

       2.535085780 seconds time elapsed


> 
>> Patch 1 is about refactoring common codes from __page_frag_alloc_va_align()
>> to __page_frag_cache_prepare() and __page_frag_cache_commit(), so that the
>> new API can make use of them as much as possible.
>>
>> Any better idea to reuse common codes as much as possible while avoiding
>> the performance degradation as much as possible?
>>
>>>
>>>> 2. Use the below netcat test case, there seems to be some minor
>>>>    performance gain for replacing 'page_frag' with 'page_frag_cache'
>>>>    using the new page_frag API after this patchset.
>>>>    server: taskset -c 32 nc -l -k 1234 > /dev/null
>>>>    client: perf stat -r 200 -- taskset -c 0 head -c 20G /dev/zero | taskset -c 1 nc 127.0.0.1 1234
>>>
>>> This test would barely touch the page pool. The fact is most of the
>>
>> I am guessing you meant page_frag here?
>>
>>> overhead for this would likely be things like TCP latency and data
>>> copy much more than the page allocation. As such fluctuations here are
>>> likely not related to your changes.
>>
>> But it does tell us something that the replacing does not seems to
>> cause obvious regression, right?
> 
> Not really. The fragment allocator is such a small portion of this
> test that we could probably double the cost for it and it would still
> be negligible.

The most beneficial thing for replacing of the old API seems to be about
batching of page->_refcount updating and avoid some page_address(), but
may have overhead from unifying of page_frag API.

> 
>> I tried using a smaller MTU to amplify the impact of page allocation,
>> it seemed to have a similar result.
> 
> Not surprising. However the network is likely only a small part of
> this. I suspect if you ran a profile it would likely show the same.
> 

patch for doing the push operation in the insmod process instead of
in the kernel thread as 'perf stat' does not seem to include the data
of kernel thread:
diff --git a/tools/testing/selftests/mm/page_frag/page_frag_test.c b/tools/testing/selftests/mm/page_frag/page_frag_test.c
index e806c1866e36..a818431c38b8 100644
--- a/tools/testing/selftests/mm/page_frag/page_frag_test.c
+++ b/tools/testing/selftests/mm/page_frag/page_frag_test.c
@@ -131,30 +131,39 @@ static int __init page_frag_test_init(void)
        init_completion(&wait);

        if (test_alloc_len > PAGE_SIZE || test_alloc_len <= 0 ||
-           !cpu_active(test_push_cpu) || !cpu_active(test_pop_cpu))
+           !cpu_active(test_pop_cpu))
                return -EINVAL;

        ret = ptr_ring_init(&ptr_ring, nr_objs, GFP_KERNEL);
        if (ret)
                return ret;

-       tsk_push = kthread_create_on_cpu(page_frag_push_thread, &ptr_ring,
-                                        test_push_cpu, "page_frag_push");
-       if (IS_ERR(tsk_push))
-               return PTR_ERR(tsk_push);
-
        tsk_pop = kthread_create_on_cpu(page_frag_pop_thread, &ptr_ring,
                                        test_pop_cpu, "page_frag_pop");
-       if (IS_ERR(tsk_pop)) {
-               kthread_stop(tsk_push);
+       if (IS_ERR(tsk_pop))
                return PTR_ERR(tsk_pop);
+
+       pr_info("test_push_cpu = %d\n", test_push_cpu);
+
+       if (test_push_cpu < 0)
+               goto skip_push_thread;
+
+       tsk_push = kthread_create_on_cpu(page_frag_push_thread, &ptr_ring,
+                                        test_push_cpu, "page_frag_push");
+       if (IS_ERR(tsk_push)) {
+               kthread_stop(tsk_pop);
+               return PTR_ERR(tsk_push);
        }

+skip_push_thread:
        start = ktime_get();
-       wake_up_process(tsk_push);
+       pr_info("waiting for test to complete\n");
        wake_up_process(tsk_pop);

-       pr_info("waiting for test to complete\n");
+       if (test_push_cpu < 0)
+               page_frag_push_thread(&ptr_ring);
+       else
+               wake_up_process(tsk_push);

        while (!wait_for_completion_timeout(&wait, msecs_to_jiffies(10000))) {
                /* exit if there is no progress for push or pop size */

