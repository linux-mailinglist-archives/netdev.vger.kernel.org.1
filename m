Return-Path: <netdev+bounces-231379-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E0FBBF8427
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 21:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 394205456D3
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 19:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0067350A12;
	Tue, 21 Oct 2025 19:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BoB3rluM"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212EA350A0A
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 19:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761074931; cv=none; b=pro8wEz7zKumkP5zEOztrKHwXyqTecVzxX+Pbqrf4Xdbd/9AQF3cHTBv5hj7VII7QE9+Y+P7epgbcVbjjIg0v/dY5WHCVxA7I2YXZDS2vZFBBdHIpkisSvvB71lE0Y/bOWMwl1s67ghaTo4zJqLjvmxzxMJxkfSfpRTc4T3r+Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761074931; c=relaxed/simple;
	bh=5BCq9RRv7KamLtUB79/4SrvmAL0LwrRQ7PGI4CZ2MM8=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=grWrX2sD7UeMUMcRlM6hN+nWxtU6xvNg2KQ8ni/vMeB97fW6GgF60Y2M3yBjtZSIPjsQRSsGyrbw1ILTYYQqX/EcZmxFkfQ5DQr6LgzpB5MVoa+apKWY2YZM70UsozIp58ajDq6G2ZRhyk/Paja2M4pdsTqVu2/ycfdsMW72a/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BoB3rluM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761074929;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OAcllF9nVIfCniwCIoLGKjAXFJuJdiDQqFfGC/k/Yfk=;
	b=BoB3rluMPOKjB4rHdV4VZTxG6jSvCCtj4bApw1ckBTPdZFe8zJIFQzjNs1uGgcy0SBQTNm
	Q7F17s5CAGOM9b1evWq/BPA0q9B48fea2rTPB1xLb9jeE4DTW/XW7GqsnnpDJ9xAdVPQtE
	Qchu0Ys9WMUyWZBJzoaJ/dODMCqcQfM=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-Vt9tII4BOYaY-01O3AXFBQ-1; Tue, 21 Oct 2025 15:28:48 -0400
X-MC-Unique: Vt9tII4BOYaY-01O3AXFBQ-1
X-Mimecast-MFC-AGG-ID: Vt9tII4BOYaY-01O3AXFBQ_1761074927
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-88d842aa73aso272791385a.0
        for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 12:28:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761074927; x=1761679727;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OAcllF9nVIfCniwCIoLGKjAXFJuJdiDQqFfGC/k/Yfk=;
        b=HX/QTX9X2Jl9Gab8KsCdvTRUe83tMhsclUPFnAwxPHmagrrgHp9VhNa4YXnzxdFowY
         BVeZv6vlmkD29IyPjzkIOuIUQLkVjZT51+3UnD2fH1ousa4FoAJ6XV4i99nv9g6Nsc/L
         sWvF/NKdfInXqUT9y4W1KN5BgkVCSPqx+vJx20XbpuDsgfKMgbvXO4v0zESQhMz7JdG4
         THO/UbdaJOxe8/hUcvmCM0SzCW9iqOy72Cd+h2CJCin79POXZDXi1Eyu3zMvkjtwrpRg
         4gxtVKq37jVO36KDdbUmEA33UurBTtZnrEqpa/b2TidNBBzZL1cQmH0shkN3j12t2Jva
         n2FA==
X-Forwarded-Encrypted: i=1; AJvYcCWXV330kEJSUDDv8yEyLcbaQwakMRxPJMxA87XRDNHPFOhN2NBho0Rc/e5xZC6USArc7TzgqbU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh28PgGmnIc3KHD2KxwbiRCQLQ+CNzDzLNJIpFF6VJuQ6qupFZ
	B1RhCfdaSKS0OrWLyjJbeWJPm0kbPl+v+0fSZbO+LFGDXbj1GG0G5/0kBJ1L6R5t9k4APj/SxeG
	ZZmzuZzjdv/iKcJWGSZSoLd4YdnWkW2zNKBbGzEHOXG/eJp8jbl4PCdxrZg==
X-Gm-Gg: ASbGnctLElKobHG1BmN2jDak9NcTxpTU5IaXEz78fEA6cXZXXYxsEZYOJWq9U+kdOjx
	OoxzOJWGCwD5fNdZFd4pPNisYRtm3BcOJ9NsSDL1kfXnGjJEdsQGLcyHO5L+65kliH4k2XuhXdk
	o0AQjOhCrcD39tXobZvv2gOuQKhnEcTwFEgh5kFBA1+2d3KIl/DyuJFhhgDqedz4gQB5bOH6Bg8
	lYYzFDIbQ4FdFW7EeHpPXtyprfJS2TYf/HIi8W+SUEaeJTKmP32gTXyMvVrjY6zKpThlW0+N9+a
	P49ZfY64ZMmmRkxUgdd5nS18GZz8ildhTefGX7Tq9SFVcYca2kXsEBS8dWqFfYFQomSQ0yUhW0w
	hCH9RVD9ki0c4a29hPpyjsJVK8ei43uaE+SjgP2nkt4BKLw==
X-Received: by 2002:a05:620a:488e:b0:7e8:67b8:476 with SMTP id af79cd13be357-89070114f94mr2346437485a.57.1761074927221;
        Tue, 21 Oct 2025 12:28:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+u+8bH+lrXiYca/LtZ13ni/QSfiNRKtdF54+j0jtBiSwDvm50yRps0a3A4dxIJsM4iefKKw==
X-Received: by 2002:a05:620a:488e:b0:7e8:67b8:476 with SMTP id af79cd13be357-89070114f94mr2346432285a.57.1761074926666;
        Tue, 21 Oct 2025 12:28:46 -0700 (PDT)
Received: from ?IPV6:2601:600:947f:f020:85dc:d2b2:c5ee:e3c4? ([2601:600:947f:f020:85dc:d2b2:c5ee:e3c4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-891cefba8f0sm817018785a.40.2025.10.21.12.28.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 12:28:46 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <a01172d1-d902-4d55-bc1e-c8234985e65a@redhat.com>
Date: Tue, 21 Oct 2025 15:28:42 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/33] sched/isolation: Flush memcg workqueues on cpuset
 isolated partition change
To: Frederic Weisbecker <frederic@kernel.org>,
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
 <20251013203146.10162-15-frederic@kernel.org>
 <364e084a-ef37-42ab-a2ae-5f103f1eb212@redhat.com>
Content-Language: en-US
In-Reply-To: <364e084a-ef37-42ab-a2ae-5f103f1eb212@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/21/25 3:16 PM, Waiman Long wrote:
> On 10/13/25 4:31 PM, Frederic Weisbecker wrote:
>> The HK_TYPE_DOMAIN housekeeping cpumask is now modifyable at runtime. In
>> order to synchronize against memcg workqueue to make sure that no
>> asynchronous draining is still pending or executing on a newly made
>> isolated CPU, the housekeeping susbsystem must flush the memcg
>> workqueues.
>>
>> However the memcg workqueues can't be flushed easily since they are
>> queued to the main per-CPU workqueue pool.
>>
>> Solve this with creating a memcg specific pool and provide and use the
>> appropriate flushing API.
>>
>> Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
>> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
>> ---
>>   include/linux/memcontrol.h |  4 ++++
>>   kernel/sched/isolation.c   |  2 ++
>>   kernel/sched/sched.h       |  1 +
>>   mm/memcontrol.c            | 12 +++++++++++-
>>   4 files changed, 18 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
>> index 873e510d6f8d..001200df63cf 100644
>> --- a/include/linux/memcontrol.h
>> +++ b/include/linux/memcontrol.h
>> @@ -1074,6 +1074,8 @@ static inline u64 cgroup_id_from_mm(struct 
>> mm_struct *mm)
>>       return id;
>>   }
>>   +void mem_cgroup_flush_workqueue(void);
>> +
>>   extern int mem_cgroup_init(void);
>>   #else /* CONFIG_MEMCG */
>>   @@ -1481,6 +1483,8 @@ static inline u64 cgroup_id_from_mm(struct 
>> mm_struct *mm)
>>       return 0;
>>   }
>>   +static inline void mem_cgroup_flush_workqueue(void) { }
>> +
>>   static inline int mem_cgroup_init(void) { return 0; }
>>   #endif /* CONFIG_MEMCG */
>>   diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
>> index 95d69c2102f6..9ec365dea921 100644
>> --- a/kernel/sched/isolation.c
>> +++ b/kernel/sched/isolation.c
>> @@ -144,6 +144,8 @@ int housekeeping_update(struct cpumask *mask, 
>> enum hk_type type)
>>         synchronize_rcu();
>>   +    mem_cgroup_flush_workqueue();
>> +
>>       kfree(old);
>>         return 0;
>> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
>> index 8fac8aa451c6..8bfc0b4b133f 100644
>> --- a/kernel/sched/sched.h
>> +++ b/kernel/sched/sched.h
>> @@ -44,6 +44,7 @@
>>   #include <linux/lockdep_api.h>
>>   #include <linux/lockdep.h>
>>   #include <linux/memblock.h>
>> +#include <linux/memcontrol.h>
>>   #include <linux/minmax.h>
>>   #include <linux/mm.h>
>>   #include <linux/module.h>
>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>> index 1033e52ab6cf..1aa14e543f35 100644
>> --- a/mm/memcontrol.c
>> +++ b/mm/memcontrol.c
>> @@ -95,6 +95,8 @@ static bool cgroup_memory_nokmem __ro_after_init;
>>   /* BPF memory accounting disabled? */
>>   static bool cgroup_memory_nobpf __ro_after_init;
>>   +static struct workqueue_struct *memcg_wq __ro_after_init;
>> +
>>   static struct kmem_cache *memcg_cachep;
>>   static struct kmem_cache *memcg_pn_cachep;
>>   @@ -1975,7 +1977,7 @@ static void schedule_drain_work(int cpu, 
>> struct work_struct *work)
>>   {
>>       guard(rcu)();
>>       if (!cpu_is_isolated(cpu))
>> -        schedule_work_on(cpu, work);
>> +        queue_work_on(cpu, memcg_wq, work);
>>   }
>>     /*
>> @@ -5092,6 +5094,11 @@ void mem_cgroup_sk_uncharge(const struct sock 
>> *sk, unsigned int nr_pages)
>>       refill_stock(memcg, nr_pages);
>>   }
>>   +void mem_cgroup_flush_workqueue(void)
>> +{
>> +    flush_workqueue(memcg_wq);
>> +}
>> +
>>   static int __init cgroup_memory(char *s)
>>   {
>>       char *token;
>> @@ -5134,6 +5141,9 @@ int __init mem_cgroup_init(void)
>>       cpuhp_setup_state_nocalls(CPUHP_MM_MEMCQ_DEAD, 
>> "mm/memctrl:dead", NULL,
>>                     memcg_hotplug_cpu_dead);
>>   +    memcg_wq = alloc_workqueue("memcg", 0, 0);
>
> Should we explicitly mark the memcg_wq as WQ_PERCPU even though I 
> think percpu is the default. The schedule_work_on() schedules work on 
> the system_percpu_wq. 

According to commit dadb3ebcf39 ("workqueue: WQ_PERCPU added to 
alloc_workqueue users"), the default may be changed to WQ_UNBOUND in the 
future.

Cheers,
Longman


