Return-Path: <netdev+bounces-231081-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F00CBF490C
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 06:03:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECDB346287C
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 04:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 051F32367CF;
	Tue, 21 Oct 2025 04:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dMMZ7uHD"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3115B22370D
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 04:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761019397; cv=none; b=txlS1riEOd7xnQtOB1KYspV201EK3YLkm4a4B8G5bhD6OgJ2i7jLVsRF2zL7JCumxZe0Hf87jc2uqugEHEwg4G4wXngt12ZPuhE4ZUC8JeQVGTLlmncUm0Erwir+kSmLrR9FON6cqe0TqONdjlZ1eggCuiA4hXj6LLrOWwZDmKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761019397; c=relaxed/simple;
	bh=YLsWcUl/1MmhWdChdiTvb0MKT/YV6jwpBU0EMyPvK58=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=LwsuVlg3od7SNlw1aS4mVv1gHhc4gluLL9Zq0FOVSWdCGqWHahcY1VZyOk/k2jCedw9dJSXtVPXGbS1zslkkYfmEuMMIOaetrE8OmA8S9izG9zmfb5vQsnOGNDFgbQ/8oioKFTE2Uz2S9H7YctctaMd4B1rfqtyVa3mCcHfip18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dMMZ7uHD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761019395;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ypGPB2dMjd5AmXxY6vdW8x1rXEojijwfr4yyazjH+Dk=;
	b=dMMZ7uHDHXRPNU0DsFqlsRdzCkuNvQ9bLXeHQQZ/BtW2UQ54/YJiSHmXmK3DMY8/wV2hvq
	4H+mA/uzGM5jMUXv8JP1lPaKTl4s85LledVU7+NLtk4ubrZ85QIwUVeGtP3iQXNOEKLHa1
	MEEfyqdWT6jNYEQhXdgzTituLCue7VM=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-351-YinliUNUMNKVob-itdHYow-1; Tue, 21 Oct 2025 00:03:13 -0400
X-MC-Unique: YinliUNUMNKVob-itdHYow-1
X-Mimecast-MFC-AGG-ID: YinliUNUMNKVob-itdHYow_1761019393
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-892637a3736so1399801485a.1
        for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 21:03:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761019393; x=1761624193;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ypGPB2dMjd5AmXxY6vdW8x1rXEojijwfr4yyazjH+Dk=;
        b=v7DNIRU4/ecREtB8phojR7VAN0+4GQ9Nats5pBjNtysaqidJCvVcyn/JNrHJJeugst
         +lO99Nrl0OJzYMdy+pdThxxi5/GWZc9sLLiyrXfpPfeu52bf2zpL0Ey2xxxXoP3hPiqM
         5/WJWQhNf/yQuQhwcuLxC+MKEnnaHN/66PX1jYe9v0flUnUA4S1MPlmAYaGFY8+uORoz
         lePm0CPLh6fJWIj7JmT/L8KXieYfaomGfYMEEs3rDEBcxSXIjJ8nuIBS32f+Lkd8WJYf
         HnZpJ8eOowBHNKfl5H70ogIhgb6KMGAbihrLyWAsN/NcxB+kwdHk42744y2ZDbag6qeD
         qyEg==
X-Forwarded-Encrypted: i=1; AJvYcCV/dir95CGUMjHvv9uP+btZUs+2xCHt9XzGBRILubHg3O+dzq94zZHquM98/fkygvAgI5Qt3X4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrAzwKSnggQeHtaFFE8yGRYvnRBa9d3uvdPj0lFUmocLHqpdt4
	3iga+ugXvv9rXABxm0q1NZB18oQmFgXnCpWgN5qvZz37z2qv49mSlLDDHcHr5IwuyIl3pGGQoH6
	/WoBBUmEvpyvVMJgxooO+CUzH2RCrj/oOK/37ZJhCizgETtJ+JKWmGFgjdQ==
X-Gm-Gg: ASbGncuzOFotYU1Pr3h2n8mpW92Diu0mgE6c4msEM9av6xZZ1kgTyosjLS1CzD+zXXM
	KPnCGFTmT1l0k+R/V59F2vuSQaLbqR4hdAHaBA3E6AuEUYXNuLyUQ/Lc+iYgQaarVWIz38SEwvR
	6KHQCksf8/iL3zqqKBUsi2aSLgd6MxoT4YzSlm/WU1W6LxphVJct6x4E2k2w2itAi69mXLYlnEZ
	QxUgYijJrSIJv/eSw/wDszCY9Pyx5Ko9CChUhETZSN9elloQAM819W0x1H4K5d3qwg5qOnzUA9i
	TyowAkzYiBbwSuYCQMq7txa0SICJfMOVGnqqQpvpx3IuRM/ACUgh+wlELWDhJlawrM6yV4quGnO
	xhOngV4qQwig0Ywtjgn/Xk3Y30q+4qmtlXlYotblANcyR/g==
X-Received: by 2002:a05:620a:199c:b0:7e8:3fbd:4190 with SMTP id af79cd13be357-8906e0da740mr1877058885a.2.1761019392946;
        Mon, 20 Oct 2025 21:03:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH3urjAuZAgtdR076zL6t7beitaw+yMAlWxDfIl37cvi1zbenzxv5j5J3/VNyalxK0zDSKr8w==
X-Received: by 2002:a05:620a:199c:b0:7e8:3fbd:4190 with SMTP id af79cd13be357-8906e0da740mr1877055485a.2.1761019392392;
        Mon, 20 Oct 2025 21:03:12 -0700 (PDT)
Received: from ?IPV6:2601:600:947f:f020:85dc:d2b2:c5ee:e3c4? ([2601:600:947f:f020:85dc:d2b2:c5ee:e3c4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-891cf58e67esm686026885a.47.2025.10.20.21.03.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 21:03:11 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <510b0185-51d6-44e6-8c39-dfc4c1721e03@redhat.com>
Date: Tue, 21 Oct 2025 00:03:05 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/33] sched/isolation: Convert housekeeping cpumasks to
 rcu pointers
To: Chen Ridong <chenridong@huaweicloud.com>,
 Frederic Weisbecker <frederic@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
Cc: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Danilo Krummrich
 <dakr@kernel.org>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Gabriele Monaco <gmonaco@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Ingo Molnar <mingo@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>,
 Lai Jiangshan <jiangshanlai@gmail.com>,
 Marco Crivellari <marco.crivellari@suse.com>, Michal Hocko
 <mhocko@suse.com>, Muchun Song <muchun.song@linux.dev>,
 Paolo Abeni <pabeni@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Phil Auld <pauld@redhat.com>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Simon Horman <horms@kernel.org>,
 Tejun Heo <tj@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will@kernel.org>,
 cgroups@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-block@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org,
 netdev@vger.kernel.org
References: <20251013203146.10162-1-frederic@kernel.org>
 <20251013203146.10162-13-frederic@kernel.org>
 <bb9a75dc-8c34-41da-b064-e31bf5fe6cb2@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <bb9a75dc-8c34-41da-b064-e31bf5fe6cb2@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/20/25 9:46 PM, Chen Ridong wrote:
>
> On 2025/10/14 4:31, Frederic Weisbecker wrote:
>> HK_TYPE_DOMAIN's cpumask will soon be made modifyable by cpuset.
>> A synchronization mechanism is then needed to synchronize the updates
>> with the housekeeping cpumask readers.
>>
>> Turn the housekeeping cpumasks into RCU pointers. Once a housekeeping
>> cpumask will be modified, the update side will wait for an RCU grace
>> period and propagate the change to interested subsystem when deemed
>> necessary.
>>
>> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
>> ---
>>   kernel/sched/isolation.c | 58 +++++++++++++++++++++++++---------------
>>   kernel/sched/sched.h     |  1 +
>>   2 files changed, 37 insertions(+), 22 deletions(-)
>>
>> diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
>> index 8690fb705089..b46c20b5437f 100644
>> --- a/kernel/sched/isolation.c
>> +++ b/kernel/sched/isolation.c
>> @@ -21,7 +21,7 @@ DEFINE_STATIC_KEY_FALSE(housekeeping_overridden);
>>   EXPORT_SYMBOL_GPL(housekeeping_overridden);
>>   
>>   struct housekeeping {
>> -	cpumask_var_t cpumasks[HK_TYPE_MAX];
>> +	struct cpumask __rcu *cpumasks[HK_TYPE_MAX];
>>   	unsigned long flags;
>>   };
>>   
>> @@ -33,17 +33,28 @@ bool housekeeping_enabled(enum hk_type type)
>>   }
>>   EXPORT_SYMBOL_GPL(housekeeping_enabled);
>>   
>> +const struct cpumask *housekeeping_cpumask(enum hk_type type)
>> +{
>> +	if (static_branch_unlikely(&housekeeping_overridden)) {
>> +		if (housekeeping.flags & BIT(type)) {
>> +			return rcu_dereference_check(housekeeping.cpumasks[type], 1);
>> +		}
>> +	}
>> +	return cpu_possible_mask;
>> +}
>> +EXPORT_SYMBOL_GPL(housekeeping_cpumask);
>> +
>>   int housekeeping_any_cpu(enum hk_type type)
>>   {
>>   	int cpu;
>>   
>>   	if (static_branch_unlikely(&housekeeping_overridden)) {
>>   		if (housekeeping.flags & BIT(type)) {
>> -			cpu = sched_numa_find_closest(housekeeping.cpumasks[type], smp_processor_id());
>> +			cpu = sched_numa_find_closest(housekeeping_cpumask(type), smp_processor_id());
>>   			if (cpu < nr_cpu_ids)
>>   				return cpu;
>>   
>> -			cpu = cpumask_any_and_distribute(housekeeping.cpumasks[type], cpu_online_mask);
>> +			cpu = cpumask_any_and_distribute(housekeeping_cpumask(type), cpu_online_mask);
>>   			if (likely(cpu < nr_cpu_ids))
>>   				return cpu;
>>   			/*
>> @@ -59,28 +70,18 @@ int housekeeping_any_cpu(enum hk_type type)
>>   }
>>   EXPORT_SYMBOL_GPL(housekeeping_any_cpu);
>>   
>> -const struct cpumask *housekeeping_cpumask(enum hk_type type)
>> -{
>> -	if (static_branch_unlikely(&housekeeping_overridden))
>> -		if (housekeeping.flags & BIT(type))
>> -			return housekeeping.cpumasks[type];
>> -	return cpu_possible_mask;
>> -}
>> -EXPORT_SYMBOL_GPL(housekeeping_cpumask);
>> -
>>   void housekeeping_affine(struct task_struct *t, enum hk_type type)
>>   {
>>   	if (static_branch_unlikely(&housekeeping_overridden))
>>   		if (housekeeping.flags & BIT(type))
>> -			set_cpus_allowed_ptr(t, housekeeping.cpumasks[type]);
>> +			set_cpus_allowed_ptr(t, housekeeping_cpumask(type));
>>   }
>>   EXPORT_SYMBOL_GPL(housekeeping_affine);
>>   
>>   bool housekeeping_test_cpu(int cpu, enum hk_type type)
>>   {
>> -	if (static_branch_unlikely(&housekeeping_overridden))
>> -		if (housekeeping.flags & BIT(type))
>> -			return cpumask_test_cpu(cpu, housekeeping.cpumasks[type]);
>> +	if (housekeeping.flags & BIT(type))
>> +		return cpumask_test_cpu(cpu, housekeeping_cpumask(type));
>>   	return true;
>>   }
>>   EXPORT_SYMBOL_GPL(housekeeping_test_cpu);
>> @@ -96,20 +97,33 @@ void __init housekeeping_init(void)
>>   
>>   	if (housekeeping.flags & HK_FLAG_KERNEL_NOISE)
>>   		sched_tick_offload_init();
>> -
>> +	/*
>> +	 * Realloc with a proper allocator so that any cpumask update
>> +	 * can indifferently free the old version with kfree().
>> +	 */
>>   	for_each_set_bit(type, &housekeeping.flags, HK_TYPE_MAX) {
>> +		struct cpumask *omask, *nmask = kmalloc(cpumask_size(), GFP_KERNEL);
>> +
>> +		if (WARN_ON_ONCE(!nmask))
>> +			return;
>> +
>> +		omask = rcu_dereference(housekeeping.cpumasks[type]);
>> +
>>   		/* We need at least one CPU to handle housekeeping work */
>> -		WARN_ON_ONCE(cpumask_empty(housekeeping.cpumasks[type]));
>> +		WARN_ON_ONCE(cpumask_empty(omask));
>> +		cpumask_copy(nmask, omask);
>> +		RCU_INIT_POINTER(housekeeping.cpumasks[type], nmask);
>> +		memblock_free(omask, cpumask_size());
>>   	}
>>   }
>>   
>>   static void __init housekeeping_setup_type(enum hk_type type,
>>   					   cpumask_var_t housekeeping_staging)
>>   {
>> +	struct cpumask *mask = memblock_alloc_or_panic(cpumask_size(), SMP_CACHE_BYTES);
>>   
>> -	alloc_bootmem_cpumask_var(&housekeeping.cpumasks[type]);
>> -	cpumask_copy(housekeeping.cpumasks[type],
>> -		     housekeeping_staging);
>> +	cpumask_copy(mask, housekeeping_staging);
>> +	RCU_INIT_POINTER(housekeeping.cpumasks[type], mask);
>>   }
>>   
>>   static int __init housekeeping_setup(char *str, unsigned long flags)
>> @@ -162,7 +176,7 @@ static int __init housekeeping_setup(char *str, unsigned long flags)
>>   
>>   		for_each_set_bit(type, &iter_flags, HK_TYPE_MAX) {
>>   			if (!cpumask_equal(housekeeping_staging,
>> -					   housekeeping.cpumasks[type])) {
>> +					   housekeeping_cpumask(type))) {
>>   				pr_warn("Housekeeping: nohz_full= must match isolcpus=\n");
>>   				goto free_housekeeping_staging;
>>   			}
>> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
>> index 1f5d07067f60..0c0ef8999fd6 100644
>> --- a/kernel/sched/sched.h
>> +++ b/kernel/sched/sched.h
>> @@ -42,6 +42,7 @@
>>   #include <linux/ktime_api.h>
>>   #include <linux/lockdep_api.h>
>>   #include <linux/lockdep.h>
>> +#include <linux/memblock.h>
>>   #include <linux/minmax.h>
>>   #include <linux/mm.h>
>>   #include <linux/module.h>
> A warning was detected:
>
> =============================
> WARNING: suspicious RCU usage
> 6.17.0-next-20251009-00033-g4444da88969b #808 Not tainted
> -----------------------------
> kernel/sched/isolation.c:60 suspicious rcu_dereference_check() usage!
>
> other info that might help us debug this:
>
>
> rcu_scheduler_active = 2, debug_locks = 1
> 1 lock held by swapper/0/1:
>   #0: ffff888100600ce0 (&type->i_mutex_dir_key#3){++++}-{4:4}, at: walk_compone
>
> stack backtrace:
> CPU: 3 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.17.0-next-20251009-00033-g4
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239
> Call Trace:
>   <TASK>
>   dump_stack_lvl+0x68/0xa0
>   lockdep_rcu_suspicious+0x148/0x1b0
>   housekeeping_cpumask+0xaa/0xb0
>   housekeeping_test_cpu+0x25/0x40
>   find_get_block_common+0x41/0x3e0
>   bdev_getblk+0x28/0xa0
>   ext4_getblk+0xba/0x2d0
>   ext4_bread_batch+0x56/0x170
>   __ext4_find_entry+0x17c/0x410
>   ? lock_release+0xc6/0x290
>   ext4_lookup+0x7a/0x1d0
>   __lookup_slow+0xf9/0x1b0
>   walk_component+0xe0/0x150
>   link_path_walk+0x201/0x3e0
>   path_openat+0xb1/0xb30
>   ? stack_depot_save_flags+0x41e/0xa00
>   do_filp_open+0xbc/0x170
>   ? _raw_spin_unlock_irqrestore+0x2c/0x50
>   ? __create_object+0x59/0x80
>   ? trace_kmem_cache_alloc+0x1d/0xa0
>   ? vprintk_emit+0x2b2/0x360
>   do_open_execat+0x56/0x100
>   alloc_bprm+0x1a/0x200
>   ? __pfx_kernel_init+0x10/0x10
>   kernel_execve+0x4b/0x160
>   kernel_init+0xe5/0x1c0
>   ret_from_fork+0x185/0x1d0
>   ? __pfx_kernel_init+0x10/0x10
>   ret_from_fork_asm+0x1a/0x30
>   </TASK>
> random: crng init done
>
It is because bh_lru_install() of fs/buffer.c calls cpu_is_isolated() 
without holding a rcu_read_lock. Will need to add a rcu_read_lock() there.

Cheers,
Longman


