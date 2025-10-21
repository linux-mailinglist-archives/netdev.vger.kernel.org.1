Return-Path: <netdev+bounces-231078-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA7CBF489F
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 05:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2F3324E4B22
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 03:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 799EE1F8691;
	Tue, 21 Oct 2025 03:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KDyR+eJ2"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB9B1DE3A4
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 03:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761018603; cv=none; b=bhu1H1tzH/J2I1QB/Jmdf2NStmOpm3aetxxdr8YJcruA5LygXWuw4Uo3sPLgsuzkwA/8WZCYLMU4/WKHOjcMACsA5PEGS7e+QRmXQA65wMWyjsNLpR85e3h4rkScI8EhAk5zqo6bjCHAFqSwEjd9iBdfuo+S0PiBLICUaK4jNWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761018603; c=relaxed/simple;
	bh=5wHRWII5YqV0H1234MXs40PJ+FJPQo2Fuwf1/Zu6dL8=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Zk7K0Gb633FywPnyCUwLlWpZo7H4Dbteoi2c1xoRccZdHzGnGRC60d4T/L/KNXnIpFBJ0NV5UWzFFgOq018yUWfd+qhW2aluFdtmzvPc6OggWZMj3VupKoZmwERVv7zV1l1/uvxF/1DSMqul+0u323U7KZRnYNBu6TrcOkFk0KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KDyR+eJ2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761018600;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YvtwqFSdwBIJ1DhFupvj6yUOG7znXFLvI8hL6gZ8038=;
	b=KDyR+eJ2rhOTOchKz7I7aEDorXv55lHU/eaMIuGZ+MVI45M2Kfxv+fCYj4FcL1/agyEKNo
	XIFVxxogyDdEuDaNMUWpm++ayP+MOnOQaBKj3Cq3rChFm4/tXTQ0q871yzyd3plppn2rUM
	4c/bOFk3KAtvnXknyIjX4CRTsVpN9ZU=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-387-wOOS4BknOTeiEUQH8n3EUw-1; Mon, 20 Oct 2025 23:49:59 -0400
X-MC-Unique: wOOS4BknOTeiEUQH8n3EUw-1
X-Mimecast-MFC-AGG-ID: wOOS4BknOTeiEUQH8n3EUw_1761018599
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-81d800259e3so82202966d6.3
        for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 20:49:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761018599; x=1761623399;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YvtwqFSdwBIJ1DhFupvj6yUOG7znXFLvI8hL6gZ8038=;
        b=fn7s6wV5AwEfVJFnMLYY6+lI6XibA+ECsqcvnGFxZKBWGk3qCehxkYzlqU21k0QVGc
         Yj9O9BWeaSf894YQ8TAe9fsP4UBPN6vZYOh/sbH9Xc2GdjAi4Jjy3pXP/tu/gFBaQzsg
         Rb4DWc5KODmXDMzjLqrsw9jTMjK0PvTNgK+3cwtZcXyDyw/sct6nNG2DZ9aobD8phGGW
         Uf6yJVkhTVTtIqL5E08L9yro9UyDSOFiHjXhl4ghszpXR/jg9k40GGR0encjyUuKqgAb
         iS+oFkPeN/Um4gSf0a1pInjA8GETRflrxAXBHHZEYRcK5rfgbx5dokh7XJhju6+8VFYR
         BPbA==
X-Forwarded-Encrypted: i=1; AJvYcCWSxCeeDhx4Ptg/7+2MYvjhKlS/pHjpdNyt6o/RXmQP6NCWnBp/Tnzo/9BJS51tRZ9Kjmjlbj0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4DN5dV/oMZZQJuBW4eepd3ovFjGAxdZ1iZbWH5orCZxp+Nsa9
	9/zMXuJKbbPnEay/VF5zp5hv9zEcxYhwAyH5i21fm0f3LfK9VuUHOhBJsUG6iP4oxV2QZNdY/fC
	sKKrTk49TY9MlX4gX1AybGSHq1sfrCln/r1KAVkNxOpfzZ4wShhriGlHmiQ==
X-Gm-Gg: ASbGncvItptAo5jl47hhX+EGXHdB7+xFRiH2F+RxxdCUpps+aYa18BLd5OXeluC1t8Z
	bmBzIYMDsAhH1Im1JIOiN111EODdSH6f7k08xkBBCNZnQ3Z+PpxGAATJa4URl4qoGJdeUu3zWYN
	j/u767Ysf1GVmfIrS7V3RKEQOvH8UoRwJgI6NmVJ/EZ++e43bY+znpwn3aSmTON5TpwqWPrvMq1
	Q6rugm73RrBLihuWKBWbyY4gest3Ph3mozVreOJ63M7ZBtg5kI0ZKTP0Hgb/JWdBVttgoiwlN5C
	VS+N8Eb38d3GePGsMqSPQNbP6EDT0SgSCS6Ehh4yQrqUSvP8EpOXGkLezgoQ/Vhno6sXPT0ElKc
	tKW2mCpEHf6BrYpq+n840r7o0O6+GBal61i+hWos7t16heg==
X-Received: by 2002:a05:622a:14d1:b0:4e8:ac66:ee45 with SMTP id d75a77b69052e-4e8ac66f422mr138856341cf.43.1761018598786;
        Mon, 20 Oct 2025 20:49:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzYxTQpPj871EoIMw1y246oGNNWS2hGT92x0DCSyPVsnjuqhhKKjEAvaY7EAUAoH4h5eayPQ==
X-Received: by 2002:a05:622a:14d1:b0:4e8:ac66:ee45 with SMTP id d75a77b69052e-4e8ac66f422mr138856231cf.43.1761018598358;
        Mon, 20 Oct 2025 20:49:58 -0700 (PDT)
Received: from ?IPV6:2601:600:947f:f020:85dc:d2b2:c5ee:e3c4? ([2601:600:947f:f020:85dc:d2b2:c5ee:e3c4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-891cd6717desm684147885a.26.2025.10.20.20.49.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 20:49:57 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <083388fb-3240-4329-ad49-b81cd89acffd@redhat.com>
Date: Mon, 20 Oct 2025 23:49:53 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/33] sched/isolation: Convert housekeeping cpumasks to
 rcu pointers
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
 <20251013203146.10162-13-frederic@kernel.org>
Content-Language: en-US
In-Reply-To: <20251013203146.10162-13-frederic@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 10/13/25 4:31 PM, Frederic Weisbecker wrote:
> HK_TYPE_DOMAIN's cpumask will soon be made modifyable by cpuset.
> A synchronization mechanism is then needed to synchronize the updates
> with the housekeeping cpumask readers.
>
> Turn the housekeeping cpumasks into RCU pointers. Once a housekeeping
> cpumask will be modified, the update side will wait for an RCU grace
> period and propagate the change to interested subsystem when deemed
> necessary.
>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>   kernel/sched/isolation.c | 58 +++++++++++++++++++++++++---------------
>   kernel/sched/sched.h     |  1 +
>   2 files changed, 37 insertions(+), 22 deletions(-)
>
> diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
> index 8690fb705089..b46c20b5437f 100644
> --- a/kernel/sched/isolation.c
> +++ b/kernel/sched/isolation.c
> @@ -21,7 +21,7 @@ DEFINE_STATIC_KEY_FALSE(housekeeping_overridden);
>   EXPORT_SYMBOL_GPL(housekeeping_overridden);
>   
>   struct housekeeping {
> -	cpumask_var_t cpumasks[HK_TYPE_MAX];
> +	struct cpumask __rcu *cpumasks[HK_TYPE_MAX];
>   	unsigned long flags;
>   };
>   
> @@ -33,17 +33,28 @@ bool housekeeping_enabled(enum hk_type type)
>   }
>   EXPORT_SYMBOL_GPL(housekeeping_enabled);
>   
> +const struct cpumask *housekeeping_cpumask(enum hk_type type)
> +{
> +	if (static_branch_unlikely(&housekeeping_overridden)) {
> +		if (housekeeping.flags & BIT(type)) {
> +			return rcu_dereference_check(housekeeping.cpumasks[type], 1);
> +		}
> +	}
> +	return cpu_possible_mask;
> +}
> +EXPORT_SYMBOL_GPL(housekeeping_cpumask);
> +
>   int housekeeping_any_cpu(enum hk_type type)
>   {
>   	int cpu;
>   
>   	if (static_branch_unlikely(&housekeeping_overridden)) {
>   		if (housekeeping.flags & BIT(type)) {
> -			cpu = sched_numa_find_closest(housekeeping.cpumasks[type], smp_processor_id());
> +			cpu = sched_numa_find_closest(housekeeping_cpumask(type), smp_processor_id());
>   			if (cpu < nr_cpu_ids)
>   				return cpu;
>   
> -			cpu = cpumask_any_and_distribute(housekeeping.cpumasks[type], cpu_online_mask);
> +			cpu = cpumask_any_and_distribute(housekeeping_cpumask(type), cpu_online_mask);
>   			if (likely(cpu < nr_cpu_ids))
>   				return cpu;
>   			/*
> @@ -59,28 +70,18 @@ int housekeeping_any_cpu(enum hk_type type)
>   }
>   EXPORT_SYMBOL_GPL(housekeeping_any_cpu);
>   
> -const struct cpumask *housekeeping_cpumask(enum hk_type type)
> -{
> -	if (static_branch_unlikely(&housekeeping_overridden))
> -		if (housekeeping.flags & BIT(type))
> -			return housekeeping.cpumasks[type];
> -	return cpu_possible_mask;
> -}
> -EXPORT_SYMBOL_GPL(housekeeping_cpumask);
> -
>   void housekeeping_affine(struct task_struct *t, enum hk_type type)
>   {
>   	if (static_branch_unlikely(&housekeeping_overridden))
>   		if (housekeeping.flags & BIT(type))
> -			set_cpus_allowed_ptr(t, housekeeping.cpumasks[type]);
> +			set_cpus_allowed_ptr(t, housekeeping_cpumask(type));
>   }
>   EXPORT_SYMBOL_GPL(housekeeping_affine);
>   
>   bool housekeeping_test_cpu(int cpu, enum hk_type type)
>   {
> -	if (static_branch_unlikely(&housekeeping_overridden))
> -		if (housekeeping.flags & BIT(type))
> -			return cpumask_test_cpu(cpu, housekeeping.cpumasks[type]);
> +	if (housekeeping.flags & BIT(type))
> +		return cpumask_test_cpu(cpu, housekeeping_cpumask(type));
>   	return true;
>   }

The housekeeping_overridden static key check is kept in other places 
except this one. Should we keep it for consistency?

Cheers,
Longman


