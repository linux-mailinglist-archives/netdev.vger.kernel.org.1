Return-Path: <netdev+bounces-234117-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2DF2C1CBA8
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 19:16:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A36B2567374
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 18:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85CD5246BB9;
	Wed, 29 Oct 2025 18:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fccf3tKi"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8CE261588
	for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 18:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761761140; cv=none; b=oOXqYSZaMu6K0dsShiOAFXdNKaROB+DaJe+TwZBXugxotOXDcs0cBF2Lo3F0i983REaSiHCZxcQUiYtus0E/6EWXRDDZ4y18/UqMEXBWle3wIxBYEfyhqkMsV6QPQ5Qd/xwe6XZr+djt0j1SR8kBM8jP8ApipfiFxIq53RdykNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761761140; c=relaxed/simple;
	bh=aab43vnKM1ss0I9X3ZkZ8BKt0Ft4cLo8wB19nB+wzAE=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=rl6u69nWaSbcZ2H5z3fwVmGX1QV7N0NIQU8E62TLlhDVfpeVqRcH/pwrUrvaikfehAtYLnI9qYZQWdrEdlC6cfsV9OgcWTaoCqXJGhsMQgCAAio/hdDu2oZT6vPLGurBb9bOsZI9nRDZj1sZpuSm/tdcz403ih5SSUFNC76LAqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fccf3tKi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761761137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lNxXxUzXoqQQT9w5Yf9S20ddLNixsnFzdxWTN/CN8Uk=;
	b=Fccf3tKiWG9S52afAyAOsWCc4QU6A56y6UCDpk60MyHGQIaHU0IKyvj+mHvvFHxlqUsjh7
	vPp6eleLSPVdKsfRVqWM1B1p87L2aYcc6jSpnU+zj/5QfS7JjJxhWDw8DhJFWBgRrYilPN
	nkCApV1e5vz/J7206NtptugLwusvACw=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-463-INfZKbnaOAmxQppONxiugQ-1; Wed, 29 Oct 2025 14:05:36 -0400
X-MC-Unique: INfZKbnaOAmxQppONxiugQ-1
X-Mimecast-MFC-AGG-ID: INfZKbnaOAmxQppONxiugQ_1761761136
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8a4ef35cc93so35227785a.3
        for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 11:05:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761761136; x=1762365936;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lNxXxUzXoqQQT9w5Yf9S20ddLNixsnFzdxWTN/CN8Uk=;
        b=O9y+3FWQSGERSs41B2yD5DUQw/x+Al2mh+6yKJS3iYkpjebg+2ZgSCNTLD2/AzKBMg
         0LfrXDXkpLY+bFHyChI3l4+nufG3D19FZ+DIFKpNg5InZhPwET/fefCBlNCA/M3PjqK+
         zXEhQiKRhn+1L5KiiscerMZizzvfgPtgvovwQDrsD/QKWJahqqwI5t9ne5ysPx2OwjlG
         f3KncyzjEQ1MJOuYHykocE1l6Dwvcb/vJYu6LD/Wf3YiKQZJlk4vnOiVWM7N0acvjHrg
         OVXxCI6mfZa8sGP3i8xlGRUK1KUpWuWHi5F9gLR0SjZJAFhScskMgao90ZDRykA4Y22H
         mUhA==
X-Forwarded-Encrypted: i=1; AJvYcCU3rmWTXdlhZdJMp+KF6uT30QFPAD4n2llj0ccqmAIt5JcuAv6fAUb9WKKF+qTHy76tg6OTxHI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYvK5N7ZiEvxh1LjtjdS4NgWNmh0PSB9G2Uo9An/pzp3d2q2ow
	FKJRnl0S+FOzxwJEEHrgus2fnXWDqZxPJ3oxO5Kq3UK3M2inXiTntZ87dOztZpnfuaGq07tAaOg
	LRWJ9AraCyT4Bv1Mjd0C+w9NTlke73HgSvhJ3OTHGPs8L3sbWwQD/mul5sg==
X-Gm-Gg: ASbGnctn2tY7PQIeMNV/29NhAONcnSS23FOxr93OpXoi1ZVzgWBZRMHffBxi6wUSkqw
	UywNcnDqM3C174n3TQK4EGjX0yOHViNzRRYCN+dxJv0BUn2/M+eXE4PRaqL7S4dvmY25chFY9uU
	pU0zOunVECtAwvb12tkfwExvmRwYS6y191fO3kK/pHOU6e1z8HUGjKTmUu9hFROm4Tt4cWO+A5B
	Dr1U7IIrpj+qHBIc0xP3jAclZMHp+/uT4CEiT/yjh7+tjCV+qXfRAxsPZZqhuVVBSNqO5hP4aRQ
	qZlO+8xKU85JLUL/OSLm90wz49yGpIu5q3PbU5qT5DNTDzP0ARSqkkyO58mlF7zMLgtqHBS1YeT
	/PqQnGNLNI5MoHmt8hlpGTR5Eqojdx8CshlXNua4IhY3dlQ==
X-Received: by 2002:a05:620a:29cd:b0:8a6:92d1:2db5 with SMTP id af79cd13be357-8a8e473a6e6mr573643785a.24.1761761120462;
        Wed, 29 Oct 2025 11:05:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEE6iTF4BqCkm725oJpB//2W/KjYfs5LBPrMdbtexGrXjP/dhJ17Z6sn/BKCKYXRH3K32fmkA==
X-Received: by 2002:a05:620a:29cd:b0:8a6:92d1:2db5 with SMTP id af79cd13be357-8a8e473a6e6mr573635985a.24.1761761119960;
        Wed, 29 Oct 2025 11:05:19 -0700 (PDT)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-89f2421f6a5sm1111574885a.5.2025.10.29.11.05.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 11:05:19 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <7821fb40-5082-4d11-b539-4c5abc2e572c@redhat.com>
Date: Wed, 29 Oct 2025 14:05:17 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/33] cpuset: Remove cpuset_cpu_is_isolated()
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
 <20251013203146.10162-19-frederic@kernel.org>
Content-Language: en-US
In-Reply-To: <20251013203146.10162-19-frederic@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/13/25 4:31 PM, Frederic Weisbecker wrote:
> The set of cpuset isolated CPUs is now included in HK_TYPE_DOMAIN
> housekeeping cpumask. There is no usecase left interested in just
> checking what is isolated by cpuset and not by the isolcpus= kernel
> boot parameter.
>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>   include/linux/cpuset.h          |  6 ------
>   include/linux/sched/isolation.h |  3 +--
>   kernel/cgroup/cpuset.c          | 12 ------------
>   3 files changed, 1 insertion(+), 20 deletions(-)
>
> diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
> index 051d36fec578..a10775a4f702 100644
> --- a/include/linux/cpuset.h
> +++ b/include/linux/cpuset.h
> @@ -78,7 +78,6 @@ extern void cpuset_lock(void);
>   extern void cpuset_unlock(void);
>   extern void cpuset_cpus_allowed(struct task_struct *p, struct cpumask *mask);
>   extern bool cpuset_cpus_allowed_fallback(struct task_struct *p);
> -extern bool cpuset_cpu_is_isolated(int cpu);
>   extern nodemask_t cpuset_mems_allowed(struct task_struct *p);
>   #define cpuset_current_mems_allowed (current->mems_allowed)
>   void cpuset_init_current_mems_allowed(void);
> @@ -208,11 +207,6 @@ static inline bool cpuset_cpus_allowed_fallback(struct task_struct *p)
>   	return false;
>   }
>   
> -static inline bool cpuset_cpu_is_isolated(int cpu)
> -{
> -	return false;
> -}
> -
>   static inline nodemask_t cpuset_mems_allowed(struct task_struct *p)
>   {
>   	return node_possible_map;
> diff --git a/include/linux/sched/isolation.h b/include/linux/sched/isolation.h
> index 94d5c835121b..0f50c152cf68 100644
> --- a/include/linux/sched/isolation.h
> +++ b/include/linux/sched/isolation.h
> @@ -76,8 +76,7 @@ static inline bool housekeeping_cpu(int cpu, enum hk_type type)
>   static inline bool cpu_is_isolated(int cpu)
>   {
>   	return !housekeeping_test_cpu(cpu, HK_TYPE_DOMAIN) ||
> -	       !housekeeping_test_cpu(cpu, HK_TYPE_TICK) ||
> -	       cpuset_cpu_is_isolated(cpu);
> +	       !housekeeping_test_cpu(cpu, HK_TYPE_TICK);
>   }
>   

You can also remove the "<linux/cpuset.h>" include from isolation.h 
which was added by commit 3232e7aad11e5 ("cgroup/cpuset: Include 
isolated cpuset CPUs in cpu_is_isolated() check") which introduces 
cpuset_cpu_is_isolated().

Cheers,
Longman



