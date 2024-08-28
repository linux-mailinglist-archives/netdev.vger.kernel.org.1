Return-Path: <netdev+bounces-122745-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D97962699
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 14:11:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 902152841F3
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 12:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D94E16D4C4;
	Wed, 28 Aug 2024 12:11:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53E115B119;
	Wed, 28 Aug 2024 12:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724847105; cv=none; b=GHr6JgnhnIYAo2CexincYxF0UfB0PRRbjNbrrFc1o8vQdcrd7AaUpzg5jcDZMgqXu4D9/wYDfrKKPDbtEk8rkmIcGq3FHMjmqinLRQdFnAXPlbPT2c0A1mtSHynsBEdFvBPjgc4RrdDdGIRAuhLgRxoGO9ZHk2pXCDGGuBQ4YrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724847105; c=relaxed/simple;
	bh=brvSlVRQUtSQzpnupfzaGuH7iENC8NYAFLZWH5pm/RY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GZrHJSzrmZCSp+/sL9uOpE6BC4Tsa687SIS4uafcJhuNTIm0qZfAp2mIbNgckFCp1CrGuOE8NQcxRtTztD9Yk07bYMk7DuKKssesW+Fntu0axLfaeX9xwVKpvMdEZ58tFIHoxqTEw5utFmLmnK6IZt5nWjePS+EQBUZ306c38TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Wv3DJ4T87z2DbZ4;
	Wed, 28 Aug 2024 20:11:28 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 0A5D31402CD;
	Wed, 28 Aug 2024 20:11:40 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 28 Aug 2024 20:11:39 +0800
Message-ID: <1c342d98-11d5-444c-825a-6af716d1dce8@huawei.com>
Date: Wed, 28 Aug 2024 20:11:39 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v15 06/13] mm: page_frag: reuse existing space
 for 'size' and 'pfmemalloc'
To: Alexander Duyck <alexander.duyck@gmail.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>, <linux-mm@kvack.org>
References: <20240826124021.2635705-1-linyunsheng@huawei.com>
 <20240826124021.2635705-7-linyunsheng@huawei.com>
 <CAKgT0Uc7tRi6uGTpx2n9_JAK+sbPg7QcOOOSLK+a41cFMcqCWg@mail.gmail.com>
 <82be328d-8f04-417f-bdf2-e8c0f6f58057@huawei.com>
 <CAKgT0UcEuYanVEaRViuJ5v8F7EXKJLr4_yP=ZkiMdamznt0FoQ@mail.gmail.com>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <CAKgT0UcEuYanVEaRViuJ5v8F7EXKJLr4_yP=ZkiMdamznt0FoQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2024/8/28 2:16, Alexander Duyck wrote:
> On Tue, Aug 27, 2024 at 5:06 AM Yunsheng Lin <linyunsheng@huawei.com> wrote:
>>
>> On 2024/8/27 0:46, Alexander Duyck wrote:
>>> On Mon, Aug 26, 2024 at 5:46 AM Yunsheng Lin <linyunsheng@huawei.com> wrote:
>>>>
>>>> Currently there is one 'struct page_frag' for every 'struct
>>>> sock' and 'struct task_struct', we are about to replace the
>>>> 'struct page_frag' with 'struct page_frag_cache' for them.
>>>> Before begin the replacing, we need to ensure the size of
>>>> 'struct page_frag_cache' is not bigger than the size of
>>>> 'struct page_frag', as there may be tens of thousands of
>>>> 'struct sock' and 'struct task_struct' instances in the
>>>> system.
>>>>
>>>> By or'ing the page order & pfmemalloc with lower bits of
>>>> 'va' instead of using 'u16' or 'u32' for page size and 'u8'
>>>> for pfmemalloc, we are able to avoid 3 or 5 bytes space waste.
>>>> And page address & pfmemalloc & order is unchanged for the
>>>> same page in the same 'page_frag_cache' instance, it makes
>>>> sense to fit them together.
>>>>
>>>> After this patch, the size of 'struct page_frag_cache' should be
>>>> the same as the size of 'struct page_frag'.
>>>>
>>>> CC: Alexander Duyck <alexander.duyck@gmail.com>
>>>> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
>>>> ---
>>>>  include/linux/mm_types_task.h   | 19 ++++++-----
>>>>  include/linux/page_frag_cache.h | 60 +++++++++++++++++++++++++++++++--
>>>>  mm/page_frag_cache.c            | 51 +++++++++++++++-------------
>>>>  3 files changed, 97 insertions(+), 33 deletions(-)
>>>>
> 
> ...
> 
>>>>  void page_frag_cache_drain(struct page_frag_cache *nc);
>>>
>>> So how many of these additions are actually needed outside of the
>>> page_frag_cache.c file? I'm just wondering if we could look at moving
>>
>> At least page_frag_cache_is_pfmemalloc(), page_frag_encoded_page_order(),
>> page_frag_encoded_page_ptr(), page_frag_encoded_page_address() are needed
>> out of the page_frag_cache.c file for now, which are used mostly in
>> __page_frag_cache_commit() and __page_frag_alloc_refill_probe_align() for
>> debugging and performance reason, see patch 7 & 10.
> 
> As far as the __page_frag_cache_commit I might say that could be moved
> to page_frag_cache.c, but admittedly I don't know how much that would
> impact the performance.

The performance impact seems large enough that it does not seem to justify
the moving to page_frag_cache.c,

Before the moving:
 Performance counter stats for 'insmod page_frag_test.ko test_push_cpu=16 test_pop_cpu=17 test_alloc_len=256 nr_test=512000000 test_align=0 test_prepare=0' (20 runs):

         17.749582      task-clock (msec)         #    0.002 CPUs utilized            ( +-  0.15% )
                 5      context-switches          #    0.304 K/sec                    ( +-  2.48% )
                 0      cpu-migrations            #    0.017 K/sec                    ( +- 35.04% )
                76      page-faults               #    0.004 M/sec                    ( +-  0.45% )
          46103462      cycles                    #    2.597 GHz                      ( +-  0.14% )
          60692196      instructions              #    1.32  insn per cycle           ( +-  0.12% )
          14734050      branches                  #  830.107 M/sec                    ( +-  0.12% )
             19792      branch-misses             #    0.13% of all branches          ( +-  0.75% )

       9.837758611 seconds time elapsed                                          ( +-  0.38% )


After the moving:

 Performance counter stats for 'insmod page_frag_test.ko test_push_cpu=16 test_pop_cpu=17 test_alloc_len=256 nr_test=512000000 test_align=0 test_prepare=0' (20 runs):

         19.682296      task-clock (msec)         #    0.002 CPUs utilized            ( +-  4.08% )
                 6      context-switches          #    0.305 K/sec                    ( +-  3.42% )
                 0      cpu-migrations            #    0.000 K/sec
                76      page-faults               #    0.004 M/sec                    ( +-  0.44% )
          51128091      cycles                    #    2.598 GHz                      ( +-  4.08% )
          58833583      instructions              #    1.15  insn per cycle           ( +-  4.50% )
          14260855      branches                  #  724.552 M/sec                    ( +-  4.63% )
             20120      branch-misses             #    0.14% of all branches          ( +-  0.92% )

      12.318770150 seconds time elapsed                                          ( +-  0.15% )

> 
>> The only left one is page_frag_encode_page(), I am not sure if it makes
>> much sense to move it to page_frag_cache.c while the rest of them are in
>> .h file.
> 
> I would move it. There is no point in exposing internals more than
> necessary. Also since you are carrying a BUILD_BUG_ON it would make
> sense to keep that internal to your implementation.

