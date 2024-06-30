Return-Path: <netdev+bounces-107945-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CA5F91D1F2
	for <lists+netdev@lfdr.de>; Sun, 30 Jun 2024 16:05:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AF64281BE5
	for <lists+netdev@lfdr.de>; Sun, 30 Jun 2024 14:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E744A14532C;
	Sun, 30 Jun 2024 14:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="COhNXR4s"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464147E572;
	Sun, 30 Jun 2024 14:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719756311; cv=none; b=D+NsXsG1N72zA9L99qmzhB5ReG6Nmkdwhl/Ybq21mjyIPfXLcwvVgB8lqaYRil8YYfdxxrDnuwcHUdbzUnMtc0a3Q+gqvPfjot0frH0PmPamaxO2/U3nbtvjkaikb8WGME1qfz7N5QlLttM3xB5udNMfsggayRGvf0n7XKMJ934=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719756311; c=relaxed/simple;
	bh=JCX9RfkKcMe+viiahsmPNFHNBoULkMPfhabNd7u8+bc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MFCiPZHOPRut6FbmIZZ7ezZGGN4tC5dTqSYAVEQvfHwEZGZaUs8Jc4v51eYZlQ2ictX5gbEkoqeb++aHpT2rrlZwZCIM00cwVNSVW0IzNf2NzBmaQFNUJMI6w9ReHkNCQ/r3/dI1lO7ouqholtUIfVvpQNLjVQTi/yaV1RNWiWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=COhNXR4s; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-7066463c841so1202943b3a.1;
        Sun, 30 Jun 2024 07:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719756308; x=1720361108; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3DMYWxVOVrbNinxcGttYFC0mIp7rbZQcJJC99krmUaA=;
        b=COhNXR4sv+RgWoYqZSuZl+uXM+UHLNASbgDtXbkskijNi0vnEOWvOGA5lTERShg70n
         NqdjfeGtNzTmmro/pome+0X0fZBe2+ibvGJHcxw81PuUvkeKZAvCzC1WStuc7gunA4tZ
         AK5qx4of+LNBnLNV/hafVPPF4z/DTf2vA8+yMFHqaU/giurnlMtxxROA+9dhnrb3hxed
         a+krIuz0A/rGn96iSPcQX/lkyEwRZJCgc34iDG2MivzDik5WIIAo3A3PDLj5T+XqVZsO
         MlRmQUAOshWT7uk0AYYJ46NywBkIpX4dCnUrwh5DHPcqvzgQ8b+RAl0RL/SPeUkbR3FK
         vfKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719756308; x=1720361108;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3DMYWxVOVrbNinxcGttYFC0mIp7rbZQcJJC99krmUaA=;
        b=N+JM2jU47SHUlOjb9BZMSkmSkOXJayHJZABqt/dvdtCNL3/5B8ltQKAY/4eWLgBokS
         pLgjZSQJsvsRV9MwNayFFQNu0s9r48ZBUkJMN03+Svlkqc8/lN0Ve8qkAgYP6WL1N+wu
         Ux0miRYcLde4eCE1FLMRl+1sOyVkPvyufPguQiQQafgLzb1ytvvcIrH7fn5VVpuvVsnm
         HRVtqC/gBdvl5PymkyOPC3LmpEEHmny7K1hqZlBu2YWurFtiL2QS15fb0LZRKGbO37Ri
         X3bZAFVjJ4AagFELnf0XWjjxyX0U6P45aLckpw6eEVYJdBsZTuE7QCLyEDuxCZ1eYnx7
         s+wg==
X-Forwarded-Encrypted: i=1; AJvYcCUpdl3VB9oh96s/36RdpT5HxByicXlI3EmXFjEYzr0w166sc2BXW+e4I8gcxDSpj4XebScPVHfbIcpfI0yozjbFynoFyS/OFCV7UsxlGvYypXK799Hr4GvR1Xy/d7asmQCKBrVd
X-Gm-Message-State: AOJu0YwbJhwhlCwWV/xJGV/6W9O84/PkyIk8GFokU6VMeb83YiHWWYMU
	YWkAozveWlpNiiUwZ41X/G7mH3fPvHeXgMbXdrqbd6kZ22lWMP/t
X-Google-Smtp-Source: AGHT+IErdZVHdJ/n/+BICGWyxIK1iehPhM3FHCl6vnJuEVkPFljF68IEBchgBhk61MJ9O5d8qzA4Ig==
X-Received: by 2002:a05:6a20:748a:b0:1be:cf09:4f0 with SMTP id adf61e73a8af0-1bef61ff386mr2330753637.44.1719756308256;
        Sun, 30 Jun 2024 07:05:08 -0700 (PDT)
Received: from ?IPV6:2409:8a55:301b:e120:19b7:87b2:860d:6c8d? ([2409:8a55:301b:e120:19b7:87b2:860d:6c8d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac1598cfbsm46583435ad.250.2024.06.30.07.05.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Jun 2024 07:05:07 -0700 (PDT)
Message-ID: <0a80e362-1eb7-40b0-b1b9-07ec5a6506ea@gmail.com>
Date: Sun, 30 Jun 2024 22:05:01 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 10/13] mm: page_frag: introduce
 prepare/probe/commit API
To: Alexander Duyck <alexander.duyck@gmail.com>,
 Yunsheng Lin <linyunsheng@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
References: <20240625135216.47007-1-linyunsheng@huawei.com>
 <20240625135216.47007-11-linyunsheng@huawei.com>
 <33c3c7fc00d2385e741dc6c9be0eade26c30bd12.camel@gmail.com>
 <38da183b-92ba-ce9d-5472-def199854563@huawei.com>
 <CAKgT0Ueg1u2S5LJuo0Ecs9dAPPDujtJ0GLcm8BTsfDx9LpJZVg@mail.gmail.com>
From: Yunsheng Lin <yunshenglin0825@gmail.com>
In-Reply-To: <CAKgT0Ueg1u2S5LJuo0Ecs9dAPPDujtJ0GLcm8BTsfDx9LpJZVg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/30/2024 1:37 AM, Alexander Duyck wrote:
> On Sat, Jun 29, 2024 at 4:15 AM Yunsheng Lin <linyunsheng@huawei.com> wrote:

...

>>>
>>> Why is this a macro instead of just being an inline? Are you trying to
>>> avoid having to include a header due to the virt_to_page?
>>
>> Yes, you are right.
>> I tried including different headers for virt_to_page(), and it did not
>> work for arch/x86/kernel/asm-offsets.s, which has included linux/sched.h,
>> and linux/sched.h need 'struct page_frag_cache' for 'struct task_struct'
>> after this patchset, including page_frag_cache.h for sched.h causes the
>> below compiler error:
>>
>>    CC      arch/x86/kernel/asm-offsets.s
>> In file included from ./arch/x86/include/asm/page.h:89,
>>                   from ./arch/x86/include/asm/thread_info.h:12,
>>                   from ./include/linux/thread_info.h:60,
>>                   from ./include/linux/spinlock.h:60,
>>                   from ./include/linux/swait.h:7,
>>                   from ./include/linux/completion.h:12,
>>                   from ./include/linux/crypto.h:15,
>>                   from arch/x86/kernel/asm-offsets.c:9:
>> ./include/linux/page_frag_cache.h: In function ‘page_frag_alloc_align’:
>> ./include/asm-generic/memory_model.h:37:34: error: ‘vmemmap’ undeclared (first use in this function); did you mean ‘mem_map’?
>>     37 | #define __pfn_to_page(pfn)      (vmemmap + (pfn))
>>        |                                  ^~~~~~~
>> ./include/asm-generic/memory_model.h:65:21: note: in expansion of macro ‘__pfn_to_page’
>>     65 | #define pfn_to_page __pfn_to_page
>>        |                     ^~~~~~~~~~~~~
>> ./arch/x86/include/asm/page.h:68:33: note: in expansion of macro ‘pfn_to_page’
>>     68 | #define virt_to_page(kaddr)     pfn_to_page(__pa(kaddr) >> PAGE_SHIFT)
>>        |                                 ^~~~~~~~~~~
>> ./include/linux/page_frag_cache.h:151:16: note: in expansion of macro ‘virt_to_page’
>>    151 |         return virt_to_page(va);
>>        |                ^~~~~~~~~~~~
>> ./include/asm-generic/memory_model.h:37:34: note: each undeclared identifier is reported only once for each function it appears in
>>     37 | #define __pfn_to_page(pfn)      (vmemmap + (pfn))
>>        |                                  ^~~~~~~
>> ./include/asm-generic/memory_model.h:65:21: note: in expansion of macro ‘__pfn_to_page’
>>     65 | #define pfn_to_page __pfn_to_page
>>        |                     ^~~~~~~~~~~~~
>> ./arch/x86/include/asm/page.h:68:33: note: in expansion of macro ‘pfn_to_page’
>>     68 | #define virt_to_page(kaddr)     pfn_to_page(__pa(kaddr) >> PAGE_SHIFT)
>>        |                                 ^~~~~~~~~~~
>> ./include/linux/page_frag_cache.h:151:16: note: in expansion of macro ‘virt_to_page’
>>    151 |         return virt_to_page(va);
>>
>>
> 
> I am pretty sure you just need to add:
> #include <asm/page.h>

I am supposing you mean adding the above to page_frag_cache.h, right?

It seems thing is more complicated for SPARSEMEM_VMEMMAP case, as it 
needs the declaration of 'vmemmap'(some arch defines it as a pointer 
variable while some arch defines it as a macro) and the definition of 
'struct page' for '(vmemmap + (pfn))' operation.

Adding below for 'vmemmap' and 'struct page' seems to have some compiler 
error caused by interdependence between linux/mm_types.h and asm/pgtable.h:
#include <asm/pgtable.h>
#include <linux/mm_types.h>

As below, asm/pgtable.h obviously need the definition of 'struct 
mm_struct' from linux/mm_types.h, and linux/mm_types.h has some
a long dependency of asm/pgtable.h starting from linux/uprobes.h
if we add '#include <asm/pgtable.h>' in linux/page_frag_cache.h:

In file included from ./include/linux/page_frag_cache.h:8,
                  from ./include/linux/sched.h:49,
                  from ./include/linux/percpu.h:13,
                  from ./arch/x86/include/asm/msr.h:15,
                  from ./arch/x86/include/asm/tsc.h:10,
                  from ./arch/x86/include/asm/timex.h:6,
                  from ./include/linux/timex.h:67,
                  from ./include/linux/time32.h:13,
                  from ./include/linux/time.h:60,
                  from ./include/linux/jiffies.h:10,
                  from ./include/linux/ktime.h:25,
                  from ./include/linux/timer.h:6,
                  from ./include/linux/workqueue.h:9,
                  from ./include/linux/srcu.h:21,
                  from ./include/linux/notifier.h:16,
                  from ./arch/x86/include/asm/uprobes.h:13,
                  from ./include/linux/uprobes.h:49,
                  from ./include/linux/mm_types.h:16,
                  from ./include/linux/mmzone.h:22,
                  from ./include/linux/gfp.h:7,
                  from ./include/linux/slab.h:16,
                  from ./include/linux/crypto.h:17,
                  from arch/x86/kernel/asm-offsets.c:9:
./arch/x86/include/asm/pgtable.h: In function ‘pte_accessible’:
./arch/x86/include/asm/pgtable.h:970:40: error: invalid use of undefined 
type ‘struct mm_struct’
   970 |                         atomic_read(&mm->tlb_flush_pending))
       |                                        ^~
./arch/x86/include/asm/pgtable.h: In function ‘pmdp_establish’:
./arch/x86/include/asm/pgtable.h:1370:37: error: invalid use of 
undefined type ‘struct vm_area_struct’
  1370 |         page_table_check_pmd_set(vma->vm_mm, pmdp, pmd);
       |                                     ^~
./arch/x86/include/asm/pgtable.h: At top level:
./arch/x86/include/asm/pgtable.h:1495:50: error: ‘struct vm_fault’ 
declared inside parameter list will not be visible outside of this 
definition or declaration [-Werror]
  1495 | static inline void update_mmu_cache_range(struct vm_fault *vmf,
       |                                                  ^~~~~~~~
In file included from ./arch/x86/include/asm/page.h:89,
                  from ./arch/x86/include/asm/thread_info.h:12,
                  from ./include/linux/thread_info.h:60,
                  from ./include/linux/spinlock.h:60,
                  from ./include/linux/swait.h:7,
                  from ./include/linux/completion.h:12,
                  from ./include/linux/crypto.h:15,
                  from arch/x86/kernel/asm-offsets.c:9:
./include/linux/page_frag_cache.h: In function ‘page_frag_alloc_probe’:
./include/asm-generic/memory_model.h:37:42: error: invalid use of 
undefined type ‘struct page’
    37 | #define __pfn_to_page(pfn)      (vmemmap + (pfn))
       |                                          ^
./include/asm-generic/memory_model.h:65:21: note: in expansion of macro 
‘__pfn_to_page’
    65 | #define pfn_to_page __pfn_to_page
       |                     ^~~~~~~~~~~~~
./arch/x86/include/asm/page.h:68:33: note: in expansion of macro 
‘pfn_to_page’
    68 | #define virt_to_page(kaddr)     pfn_to_page(__pa(kaddr) >> 
PAGE_SHIFT)
       |                                 ^~~~~~~~~~~
./include/linux/page_frag_cache.h:225:16: note: in expansion of macro 
‘virt_to_page’
   225 |         return virt_to_page(encoded_va);
       |                ^~~~~~~~~~~~
cc1: all warnings being treated as errors

> 

