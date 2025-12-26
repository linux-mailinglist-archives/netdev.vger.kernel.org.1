Return-Path: <netdev+bounces-246107-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 14392CDF25E
	for <lists+netdev@lfdr.de>; Sat, 27 Dec 2025 01:00:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 24F5E301584D
	for <lists+netdev@lfdr.de>; Fri, 26 Dec 2025 23:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DACE9290D81;
	Fri, 26 Dec 2025 23:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fQbVclIZ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="hX8/lhjU"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4DAA296BAB
	for <netdev@vger.kernel.org>; Fri, 26 Dec 2025 23:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766793589; cv=none; b=ULfRwI+WUC7qxpt9VHB2sACmxAiobFDUWzox005HFpcMOSzcENzdWSvViS9yn9X2e4/Tjq5vl/gxb7f2MSTL0quKC+Ibkm85vhkf3lQwWucspAiSXnxbXRTRKwZGtUoc0Lif4BVKTP9wtyDOWKR0/RExx/PcTLeR91q9p6W8MGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766793589; c=relaxed/simple;
	bh=0WgtEyyghiej13OjppeGfPv7cq7v3kU/ZW6GrWWjF1I=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ns9JmsxpaaMPtl63z55LIqeSiawgsggjnRBAFZYxxKAurRzvWGdfpg8XGhOojqdV1HrBMBf+xGUmPJeSEjNXtrHGeLQ1ybjf+Mz/XpHsinAo6+mliPJECKcx+Jvc5u6/P1yiR+wsFtMJcjInCebqM6Xk8hmwRYUmuBQVX4SutIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fQbVclIZ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=hX8/lhjU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766793586;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=865A7519wiN2/j/d36TzZexT5dCdrH361yDIN6aF4EQ=;
	b=fQbVclIZo19ltUGahP/PkkpOiREPm+5nd7zkjqh9FQFDPcQLywqOqwXCiR8zTzkWsr/scO
	ZOlH9Cwr6xzkxxntD2JdD4Cm5idduX/7DMeIZzN6JlMyzEAhxNAgmUvunrCqRJCY8SO8M9
	8Z7820E6su1ycSvWe+gvf6vGoLBfMPs=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-iyLULBF5PvaWBn6kvtdgjg-1; Fri, 26 Dec 2025 18:59:40 -0500
X-MC-Unique: iyLULBF5PvaWBn6kvtdgjg-1
X-Mimecast-MFC-AGG-ID: iyLULBF5PvaWBn6kvtdgjg_1766793580
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4ed6ff3de05so209670041cf.3
        for <netdev@vger.kernel.org>; Fri, 26 Dec 2025 15:59:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766793580; x=1767398380; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=865A7519wiN2/j/d36TzZexT5dCdrH361yDIN6aF4EQ=;
        b=hX8/lhjU69EsMzJ45goSg9ZefRLPOdWtjnXVTnr6qD9njIgew8fbvDeFi97WODJtF0
         ZakysNxmxlrjAvuQ4MKMKhwndrpeL+LjgmB45/MMqnhoNACBeIWVr8JrqSgxlELxBF4Y
         UZGh+lC76YD68d4ayoUBdOFySRWeGVv8757imn579Qki4ZPumKhtxkUCjASdmKf5SiZ1
         mZd05s87jG8HOkqiRlo6G4mS+vkfvTm/ZSczPTYFi3CVjJoZm5yM9c2tqwfHMwpJvPpq
         cTVT88b52JMEu2N9s999y13SN6NDrrxG3Lz1dB/2jDjk+4MjZ3rd0DM/puoTtOrJv67F
         PpeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766793580; x=1767398380;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=865A7519wiN2/j/d36TzZexT5dCdrH361yDIN6aF4EQ=;
        b=dceuSI/HRYwEQYU2I3p5j5m7mvQ/Do8SFpZOlBEA8eZCjX0UKWSQDBn7z4dgJaDoiq
         nC2v7iHHyWMGcKZlxje0GB1a/KurWxwgDByIexnN9THaYY33w9FJ+Vl3wFoCi1E+N/9B
         C6Rf2kFO68V1tftGa/wNELV+3ZgGIC6osFEgtXQHS3ggqtom4N4ia/RR4y9H6OwcM3mD
         FqJKOlghVG6JzannnNGEKf1kkiR90rW1wQsI1Hc8duTGwpeTErjzI6tR7jJEWwPjPrNu
         38A8nV7oPu4fXRXJSG5X5AmYP7SF5MK7zL5xIY0RNuG4879nI2mIWv7APuflHhOzKN5K
         /fIA==
X-Forwarded-Encrypted: i=1; AJvYcCUhuk6ynHYtP3DCyLsvjkldIv/sd9CEiUO9ug/pJggibx9tRzLHQF0i1fvZ7iUht4duqeGcdLE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjhFXY1zyMxTez5GzkaKOAxHwnmnY/YjPbeBIU5TgAN3cEgTC7
	ggAVfK8oYR430sSQFigto3d+Ej5+XdWkSH3rbptdNoQk75AT3gd2O9HOBduiRmLNIGd/5M3oqbK
	hwjqq4qi2psyYwzLQxNqaN5cIPOEe+tuqFYPyO/YvRUF9tOiLB9VckKRBNw==
X-Gm-Gg: AY/fxX7QT4yt9r42CHoJttE/4u54IJ3A378a1cq6lnZyGDEyX2tklYmo7wHLUhnbRV1
	GCJee/eVW1gUOglTfHeUs8qdT32YyDiLZc1zQuE4USlMLDvo6Fdp3NitLUaZVroe8SdtThkgBvO
	Yx50lDMAr329wjuPjjW4NVYbecwySvLHvybCRYGkBQVw1Ys7B/YY1hdtukNw+Beiy839UeUeVhM
	cuL/XH1qCP8Fj06stgbdv5vzpEEbMle/mK/QUaZZVC51BolbxCkOfMQSvsxZy+HyJPz+fGdbDSQ
	4JFkhuJ/WFhNXHPr/ONhs8Cz/qFjyNqlt4a9t6bsIMHk6lVN0Rm9oe6FwZGWDd/Hyjap6gDpkqZ
	mB9XW3QWmBE4mlq/HDDCJieQ6MjwJ5g4fAi4gxbX7wkW/ll6EKQ4TysVc
X-Received: by 2002:a05:622a:198b:b0:4ee:1bc7:9d7b with SMTP id d75a77b69052e-4f4abd8cc1fmr323812881cf.39.1766793580140;
        Fri, 26 Dec 2025 15:59:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IERH4Oby4w37LQow9PPp6jIctRZ9vYsC7ux3H2yEqxLfgye1sWzIlcBk2jF/qfYV4D0shjHTw==
X-Received: by 2002:a05:622a:198b:b0:4ee:1bc7:9d7b with SMTP id d75a77b69052e-4f4abd8cc1fmr323812481cf.39.1766793579691;
        Fri, 26 Dec 2025 15:59:39 -0800 (PST)
Received: from ?IPV6:2601:600:947f:f020:85dc:d2b2:c5ee:e3c4? ([2601:600:947f:f020:85dc:d2b2:c5ee:e3c4])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4f4ac55fde7sm165334981cf.12.2025.12.26.15.59.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Dec 2025 15:59:38 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <a8968902-7fc3-4dec-9a53-e9685a5705b9@redhat.com>
Date: Fri, 26 Dec 2025 18:59:34 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 30/33] kthread: Honour kthreads preferred affinity after
 cpuset changes
To: Frederic Weisbecker <frederic@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
Cc: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Chen Ridong <chenridong@huawei.com>, Danilo Krummrich <dakr@kernel.org>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Gabriele Monaco <gmonaco@redhat.com>,
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
References: <20251224134520.33231-1-frederic@kernel.org>
 <20251224134520.33231-31-frederic@kernel.org>
Content-Language: en-US
In-Reply-To: <20251224134520.33231-31-frederic@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/24/25 8:45 AM, Frederic Weisbecker wrote:
> When cpuset isolated partitions get updated, unbound kthreads get
> indifferently affine to all non isolated CPUs, regardless of their
> individual affinity preferences.
>
> For example kswapd is a per-node kthread that prefers to be affine to
> the node it refers to. Whenever an isolated partition is created,
> updated or deleted, kswapd's node affinity is going to be broken if any
> CPU in the related node is not isolated because kswapd will be affine
> globally.
>
> Fix this with letting the consolidated kthread managed affinity code do
> the affinity update on behalf of cpuset.
>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>   include/linux/kthread.h  |  1 +
>   kernel/cgroup/cpuset.c   |  5 ++---
>   kernel/kthread.c         | 41 ++++++++++++++++++++++++++++++----------
>   kernel/sched/isolation.c |  3 +++
>   4 files changed, 37 insertions(+), 13 deletions(-)
>
> diff --git a/include/linux/kthread.h b/include/linux/kthread.h
> index 8d27403888ce..c92c1149ee6e 100644
> --- a/include/linux/kthread.h
> +++ b/include/linux/kthread.h
> @@ -100,6 +100,7 @@ void kthread_unpark(struct task_struct *k);
>   void kthread_parkme(void);
>   void kthread_exit(long result) __noreturn;
>   void kthread_complete_and_exit(struct completion *, long) __noreturn;
> +int kthreads_update_housekeeping(void);
>   
>   int kthreadd(void *unused);
>   extern struct task_struct *kthreadd_task;
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 1cc83a3c25f6..c8cfaf5cd4a1 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -1208,11 +1208,10 @@ void cpuset_update_tasks_cpumask(struct cpuset *cs, struct cpumask *new_cpus)
>   
>   		if (top_cs) {
>   			/*
> +			 * PF_KTHREAD tasks are handled by housekeeping.
>   			 * PF_NO_SETAFFINITY tasks are ignored.
> -			 * All per cpu kthreads should have PF_NO_SETAFFINITY
> -			 * flag set, see kthread_set_per_cpu().
>   			 */
> -			if (task->flags & PF_NO_SETAFFINITY)
> +			if (task->flags & (PF_KTHREAD | PF_NO_SETAFFINITY))
>   				continue;
>   			cpumask_andnot(new_cpus, possible_mask, subpartitions_cpus);
>   		} else {
> diff --git a/kernel/kthread.c b/kernel/kthread.c
> index 968fa5868d21..03008154249c 100644
> --- a/kernel/kthread.c
> +++ b/kernel/kthread.c
> @@ -891,14 +891,7 @@ int kthread_affine_preferred(struct task_struct *p, const struct cpumask *mask)
>   }
>   EXPORT_SYMBOL_GPL(kthread_affine_preferred);
>   
> -/*
> - * Re-affine kthreads according to their preferences
> - * and the newly online CPU. The CPU down part is handled
> - * by select_fallback_rq() which default re-affines to
> - * housekeepers from other nodes in case the preferred
> - * affinity doesn't apply anymore.
> - */
> -static int kthreads_online_cpu(unsigned int cpu)
> +static int kthreads_update_affinity(bool force)
>   {
>   	cpumask_var_t affinity;
>   	struct kthread *k;
> @@ -924,7 +917,8 @@ static int kthreads_online_cpu(unsigned int cpu)
>   		/*
>   		 * Unbound kthreads without preferred affinity are already affine
>   		 * to housekeeping, whether those CPUs are online or not. So no need
> -		 * to handle newly online CPUs for them.
> +		 * to handle newly online CPUs for them. However housekeeping changes
> +		 * have to be applied.
>   		 *
>   		 * But kthreads with a preferred affinity or node are different:
>   		 * if none of their preferred CPUs are online and part of
> @@ -932,7 +926,7 @@ static int kthreads_online_cpu(unsigned int cpu)
>   		 * But as soon as one of their preferred CPU becomes online, they must
>   		 * be affine to them.
>   		 */
> -		if (k->preferred_affinity || k->node != NUMA_NO_NODE) {
> +		if (force || k->preferred_affinity || k->node != NUMA_NO_NODE) {
>   			kthread_fetch_affinity(k, affinity);
>   			set_cpus_allowed_ptr(k->task, affinity);
>   		}
> @@ -943,6 +937,33 @@ static int kthreads_online_cpu(unsigned int cpu)
>   	return ret;
>   }
>   
> +/**
> + * kthreads_update_housekeeping - Update kthreads affinity on cpuset change
> + *
> + * When cpuset changes a partition type to/from "isolated" or updates related
> + * cpumasks, propagate the housekeeping cpumask change to preferred kthreads
> + * affinity.
> + *
> + * Returns 0 if successful, -ENOMEM if temporary mask couldn't
> + * be allocated or -EINVAL in case of internal error.
> + */
> +int kthreads_update_housekeeping(void)
> +{
> +	return kthreads_update_affinity(true);
> +}
> +
> +/*
> + * Re-affine kthreads according to their preferences
> + * and the newly online CPU. The CPU down part is handled
> + * by select_fallback_rq() which default re-affines to
> + * housekeepers from other nodes in case the preferred
> + * affinity doesn't apply anymore.
> + */
> +static int kthreads_online_cpu(unsigned int cpu)
> +{
> +	return kthreads_update_affinity(false);
> +}
> +
>   static int kthreads_init(void)
>   {
>   	return cpuhp_setup_state(CPUHP_AP_KTHREADS_ONLINE, "kthreads:online",
> diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
> index 84a257d05918..c499474866b8 100644
> --- a/kernel/sched/isolation.c
> +++ b/kernel/sched/isolation.c
> @@ -157,6 +157,9 @@ int housekeeping_update(struct cpumask *isol_mask, enum hk_type type)
>   	err = tmigr_isolated_exclude_cpumask(isol_mask);
>   	WARN_ON_ONCE(err < 0);
>   
> +	err = kthreads_update_housekeeping();
> +	WARN_ON_ONCE(err < 0);
> +
>   	kfree(old);
>   
>   	return err;
Reviewed-by: Waiman Long <longman@redhat.com>


