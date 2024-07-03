Return-Path: <netdev+bounces-108854-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A79229260A5
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 14:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47266288340
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 12:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 769C217625D;
	Wed,  3 Jul 2024 12:40:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46CE316DEAC;
	Wed,  3 Jul 2024 12:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720010422; cv=none; b=Yp3RbKkUaVhmP/7tAG7eOJwBp9lXgc0zbhxpVtspx1C7qX5ZREbPrsCfCZRzy1w9N4+0IgXUUsvWcyGIoUurAYW87t8k2DHQ79FLSjK6ndrGrqYnp6bvB5fydB1YL/KAoPXuLMfxugTjhHZtQzSUFq4Ym6zzHPPM10cRiHmwi9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720010422; c=relaxed/simple;
	bh=e5UzmP6jWjPo5yQW7Z1/Zwlv4Kk6YHUFqfos7e+dpME=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Cg2LckjTiM2ldLM0/6IpeQwtIUCfv85ZInwMcbQpFk3ymr7TH10lHvCxPQqDNxyb04yXFy94rX5P0s+j/w0bipU/6MBnkPfihEawlRRzZqPGIQZQpJddqTdeaCuCX0uueB6zuDK/3EudgfucqVxaNL4Hj5obSxoK/Kcid5otEdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WDfQ81s21zZhG9;
	Wed,  3 Jul 2024 20:35:44 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id D6C6B180087;
	Wed,  3 Jul 2024 20:40:17 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemf200006.china.huawei.com
 (7.185.36.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 3 Jul
 2024 20:40:17 +0800
Subject: Re: [PATCH net-next v9 10/13] mm: page_frag: introduce
 prepare/probe/commit API
To: Yunsheng Lin <yunshenglin0825@gmail.com>, Alexander Duyck
	<alexander.duyck@gmail.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>, <linux-mm@kvack.org>
References: <20240625135216.47007-1-linyunsheng@huawei.com>
 <20240625135216.47007-11-linyunsheng@huawei.com>
 <33c3c7fc00d2385e741dc6c9be0eade26c30bd12.camel@gmail.com>
 <38da183b-92ba-ce9d-5472-def199854563@huawei.com>
 <CAKgT0Ueg1u2S5LJuo0Ecs9dAPPDujtJ0GLcm8BTsfDx9LpJZVg@mail.gmail.com>
 <0a80e362-1eb7-40b0-b1b9-07ec5a6506ea@gmail.com>
 <CAKgT0UcRbpT6UFCSq0Wd9OHrCqOGR=BQ063-zNBZ4cVNmduZGw@mail.gmail.com>
 <15623dac-9358-4597-b3ee-3694a5956920@gmail.com>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <200ee8ff-557f-e17b-e71f-645267a49831@huawei.com>
Date: Wed, 3 Jul 2024 20:40:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <15623dac-9358-4597-b3ee-3694a5956920@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2024/6/30 23:05, Yunsheng Lin wrote:
> On 6/30/2024 10:35 PM, Alexander Duyck wrote:
>> On Sun, Jun 30, 2024 at 7:05 AM Yunsheng Lin <yunshenglin0825@gmail.com> wrote:
>>>
>>> On 6/30/2024 1:37 AM, Alexander Duyck wrote:
>>>> On Sat, Jun 29, 2024 at 4:15 AM Yunsheng Lin <linyunsheng@huawei.com> wrote:
>>>
>>> ...
>>>
>>>>>>
>>>>>> Why is this a macro instead of just being an inline? Are you trying to
>>>>>> avoid having to include a header due to the virt_to_page?
>>>>>
>>>>> Yes, you are right.
>>
>> ...
>>
>>>> I am pretty sure you just need to add:
>>>> #include <asm/page.h>
>>>
>>> I am supposing you mean adding the above to page_frag_cache.h, right?
>>>
>>> It seems thing is more complicated for SPARSEMEM_VMEMMAP case, as it
>>> needs the declaration of 'vmemmap'(some arch defines it as a pointer
>>> variable while some arch defines it as a macro) and the definition of
>>> 'struct page' for '(vmemmap + (pfn))' operation.
>>>
>>> Adding below for 'vmemmap' and 'struct page' seems to have some compiler
>>> error caused by interdependence between linux/mm_types.h and asm/pgtable.h:
>>> #include <asm/pgtable.h>
>>> #include <linux/mm_types.h>
>>>
>>
>> Maybe you should just include linux/mm.h as that should have all the
>> necessary includes to handle these cases. In any case though it
> 
> Including linux/mm.h seems to have similar compiler error, just the
> interdependence is between linux/mm_types.h and linux/mm.h now.

How about splitting page_frag_cache.h into page_frag_types.h and
page_frag_cache.h mirroring the above linux/mm_types.h and linux/mm.h
to fix the compiler error?

> 
> As below, linux/mmap_lock.h obviously need the definition of
> 'struct mm_struct' from linux/mm_types.h, and linux/mm_types.h
> has some a long dependency of linux/mm.h starting from
> linux/uprobes.h if we add '#include <linux/mm.h>' in linux/page_frag_cache.h:
> 
> In file included from ./include/linux/mm.h:16,
>                  from ./include/linux/page_frag_cache.h:6,
>                  from ./include/linux/sched.h:49,
>                  from ./include/linux/percpu.h:13,
>                  from ./arch/x86/include/asm/msr.h:15,
>                  from ./arch/x86/include/asm/tsc.h:10,
>                  from ./arch/x86/include/asm/timex.h:6,
>                  from ./include/linux/timex.h:67,
>                  from ./include/linux/time32.h:13,
>                  from ./include/linux/time.h:60,
>                  from ./include/linux/jiffies.h:10,
>                  from ./include/linux/ktime.h:25,
>                  from ./include/linux/timer.h:6,
>                  from ./include/linux/workqueue.h:9,
>                  from ./include/linux/srcu.h:21,
>                  from ./include/linux/notifier.h:16,
>                  from ./arch/x86/include/asm/uprobes.h:13,
>                  from ./include/linux/uprobes.h:49,
>                  from ./include/linux/mm_types.h:16,
>                  from ./include/linux/mmzone.h:22,
>                  from ./include/linux/gfp.h:7,
>                  from ./include/linux/slab.h:16,
>                  from ./include/linux/crypto.h:17,
>                  from arch/x86/kernel/asm-offsets.c:9:
> ./include/linux/mmap_lock.h: In function ‘mmap_assert_locked’:
> ./include/linux/mmap_lock.h:65:30: error: invalid use of undefined type ‘const struct mm_struct’
>    65 |         rwsem_assert_held(&mm->mmap_lock);
>       |                              ^~
> 
>> doesn't make any sense to have a define in one include that expects
>> the user to then figure out what other headers to include in order to
>> make the define work they should be included in the header itself to
>> avoid any sort of weird dependencies.
> 
> Perhaps there are some season why there are two headers for the mm subsystem, linux/mm_types.h and linux/mm.h?
> And .h file is supposed to include the linux/mm_types.h while .c file
> is supposed to include the linux/mm.h?
> If the above is correct, it seems the above rule is broked by including linux/mm.h in linux/page_frag_cache.h.
> .
> 

