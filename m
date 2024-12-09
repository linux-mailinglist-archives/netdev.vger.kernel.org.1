Return-Path: <netdev+bounces-150147-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D534F9E92A9
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 12:43:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 729B91621DA
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 11:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19EAB21D5B7;
	Mon,  9 Dec 2024 11:42:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC9F21B1A8;
	Mon,  9 Dec 2024 11:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733744577; cv=none; b=GIGo0XxBcOKJuItalhxDQrA4fVreEQKZOSDi9/y+zp1zUtoWDagsyifTrwWEK4IoRPCI2vcKO7Tr7YgRN39gDR0Hq3ebUyXD0di7KKsN027CDH8j6MBsJ1wF/s7U0Mt0Q0onDUX9K3KSf7sjNYjaSe6IzH7JGsbH6uWjygKuYs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733744577; c=relaxed/simple;
	bh=q/xw1l31pm0dg5xbojMuIT0wrI+F13QWnG9PMaA0ITY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=myC13TeHJ5lNWc5cMnvnCUh48VZFqpqXVY0ISmkD7nBzgb30XWqislrhMiZlvcy9/h41TN7TR7fMRC3zGqZdrjfLn7VUbuELdV7R9uBvj2A8B1zZH4GCMqvdHq+ZNokTuhqzqhhNmkhay14TxPBmpEJvLoox02wVneamGLLfhP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Y6Kk45b5Dz21lg5;
	Mon,  9 Dec 2024 19:43:08 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 36C2B1400F4;
	Mon,  9 Dec 2024 19:42:52 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 9 Dec 2024 19:42:51 +0800
Message-ID: <3de1b8a3-ae4f-492f-969d-bc6f2c145d09@huawei.com>
Date: Mon, 9 Dec 2024 19:42:51 +0800
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
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <CAKgT0UeXcsB-HOyeA7kYKHmEUM+d_mbTQJRhXfaiFBg_HcWV0w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2024/12/9 5:34, Alexander Duyck wrote:

...

>>
>> Performance validation for part2:
>> 1. Using micro-benchmark ko added in patch 1 to test aligned and
>>    non-aligned API performance impact for the existing users, there
>>    seems to be about 20% performance degradation for refactoring
>>    page_frag to support the new API, which seems to nullify most of
>>    the performance gain in [3] of part1.
> 
> So if I am understanding correctly then this is showing a 20%
> performance degradation with this patchset. I would argue that it is
> significant enough that it would be a blocking factor for this patch
> set. I would suggest bisecting the patch set to identify where the
> performance degradation has been added and see what we can do to
> resolve it, and if nothing else document it in that patch so we can
> identify the root cause for the slowdown.

The only patch in this patchset affecting the performance of existing API
seems to be patch 1, only including patch 1 does show ~20% performance
degradation as including the whole patchset does:
mm: page_frag: some minor refactoring before adding new API

And the cause seems to be about the binary increasing as below, as the
performance degradation didn't seems to change much when I tried inlining
the __page_frag_cache_commit_noref() by moving it to the header file:

./scripts/bloat-o-meter vmlinux_orig vmlinux
add/remove: 3/2 grow/shrink: 5/0 up/down: 920/-500 (420)
Function                                     old     new   delta
__page_frag_cache_prepare                      -     500    +500
__napi_alloc_frag_align                       68     180    +112
__netdev_alloc_skb                           488     596    +108
napi_alloc_skb                               556     624     +68
__netdev_alloc_frag_align                    196     252     +56
svc_tcp_sendmsg                              340     376     +36
__page_frag_cache_commit_noref                 -      32     +32
e843419@09a6_0000bd47_30                       -       8      +8
e843419@0369_000044ee_684                      8       -      -8
__page_frag_alloc_align                      492       -    -492
Total: Before=34719207, After=34719627, chg +0.00%

./scripts/bloat-o-meter page_frag_test_orig.ko page_frag_test.ko
add/remove: 0/0 grow/shrink: 2/0 up/down: 78/0 (78)
Function                                     old     new   delta
page_frag_push_thread                        508     580     +72
__UNIQUE_ID_vermagic367                       67      73      +6
Total: Before=4582, After=4660, chg +1.70%

Patch 1 is about refactoring common codes from __page_frag_alloc_va_align()
to __page_frag_cache_prepare() and __page_frag_cache_commit(), so that the
new API can make use of them as much as possible.

Any better idea to reuse common codes as much as possible while avoiding
the performance degradation as much as possible?

> 
>> 2. Use the below netcat test case, there seems to be some minor
>>    performance gain for replacing 'page_frag' with 'page_frag_cache'
>>    using the new page_frag API after this patchset.
>>    server: taskset -c 32 nc -l -k 1234 > /dev/null
>>    client: perf stat -r 200 -- taskset -c 0 head -c 20G /dev/zero | taskset -c 1 nc 127.0.0.1 1234
> 
> This test would barely touch the page pool. The fact is most of the

I am guessing you meant page_frag here?

> overhead for this would likely be things like TCP latency and data
> copy much more than the page allocation. As such fluctuations here are
> likely not related to your changes.

But it does tell us something that the replacing does not seems to
cause obvious regression, right?

I tried using a smaller MTU to amplify the impact of page allocation,
it seemed to have a similar result.

