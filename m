Return-Path: <netdev+bounces-231414-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EADBBF91C0
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 00:45:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BDA3D4FC08F
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 22:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EECCA2ECEA8;
	Tue, 21 Oct 2025 22:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GWWqnetq"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB3B2D061C
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 22:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761086590; cv=none; b=ZYB41ZIlyIdQnIY5Fg2h0TVkfcMNJ0K9OdqIOOLqps4bkok8V/mIuRtFLSyGCPkLrYpYdfQtZD7oIo+LZXWsiRTrgKStrUuOC29Vh7oLqDkRjTg0tzZi3U7KUooClgQi7cpd5Cojllkt15saS2bcXQkHV+DEMeAnPMHfd7kvoLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761086590; c=relaxed/simple;
	bh=jS5ISZwEtvLLzIR+81DH+JOC73WFTyMLIhKyND3d1RY=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=HKu6h2SJfWA+TxcY64sUHaCJur4AV/xQ/lCBTPvP546+n4HlBaxRmLHRBzpjzyMIC21RsOVoqARm0ikNTimn3YIiJH5Mqi/9W8Qsz5EIVTKrmGgwKyR0ruzkMOxDtieBLba5YNqLJKLgqD2RWfhmIYwXWdY8N0z9vZn5IYJJ1s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GWWqnetq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761086586;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J1ufi8hzAWdR5ZvtubHPkIBiveTzx8KWYjOx6TAX45A=;
	b=GWWqnetqwfnAMuYbv5aI8RZ4FMT+Uz8nv4rFYSBrkiFvT+6KGQELiVgAO2Z0IWiPgeLlrK
	Wrv7UNaJ3na6xCs4wNATZUUhqqhrUQe9w9qFR8yOgFI8h5FIbW+8lP6X32fd+qnY0JI0J8
	AbgPV+3vwou+ahbAl+qeZ1rZFU2JHCE=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-Rqeo7FvYMb6DJUVkuP9N9w-1; Tue, 21 Oct 2025 18:43:05 -0400
X-MC-Unique: Rqeo7FvYMb6DJUVkuP9N9w-1
X-Mimecast-MFC-AGG-ID: Rqeo7FvYMb6DJUVkuP9N9w_1761086585
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-892637a3736so1790099185a.1
        for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 15:43:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761086585; x=1761691385;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J1ufi8hzAWdR5ZvtubHPkIBiveTzx8KWYjOx6TAX45A=;
        b=DcPIN7DGUa1LjrCDFiF+C1fQbBhllC5x2Ykj6NaCaamTXFpWKUVJ8zGw0hxIj9lDhn
         44NGPg3fPlLwRtT6cMg7dgaQFCvGS5W8nsaOCBJQioxxpUdlvKbYI2wzGhW7VHj5eKEs
         XnTmIcm4GTJb402Ojfz3cGiNKkTJr0sitCDg+QB/STGoNRTSR9fHGdYtWxFMOLLkLqlt
         JB1UZMjdkxWikUbFMN6ibvyKdgCdVytyw+0g+foeqlHAXDiA+NTnrMNc+6S/eSRrFSDh
         Z31KkdcDipWiLbncgd14VgF4Gy4Y3oup4GJ3VPlFo/oKksXG/uiv87jZRCg0KlYqPBdw
         U3rw==
X-Forwarded-Encrypted: i=1; AJvYcCUENi1pTmi3yOy/1cWaKQCQux84ZffetbJEHvu3EIC0P39ix4qo/Lt3Z13fwYYdzKWKZIUUXaI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDYVb8At+0w9e4GUU0mmRy1MfvVtWtZ05Uts32XJb0DfrNU66K
	/WlLwIaI+BbQS4yuxzPnlJsLBxOBjna9PMrmiBQU9PI7J1tMzPup3E2q64qTZviHKzsl8kKhLpw
	2cHlvaelvMrjF8N/5HKEQxxdcGUYZnsoh6w9LbXgUnZrADw8A0iXTkZogag==
X-Gm-Gg: ASbGnctKko2PZLvDoEIkMlXMz2Bm2FTGHk2Y/+SDlli8kuHuUcTTDjXNwNaomT/fmM1
	GPu2Ec2xh9YEg/OuQ+dXH8VgjfOycPeKc5cKy6a52HfWH1mj5BGarIoaByYsQmUD4eDBf0BqpKM
	6Q/p4LTvZKqce4f1yTVut5Bx1P8EMJugCOp2Znrl2QUtaSWbWPheg2hfudvu2sfywnYcfO15lMj
	k9RmMWs8nNWHronaY2RDwUhapCRdkIP+DttYqNDFdrITN7MEDeWQJB+IsEmM4iLthDgKDQJO8o/
	QIlV9hVx0t2jH1ORzZNMfOR5tsmjwb/sIFemBqcrOE2Q3mugiVEJ/w6XtvPLQ6TeFJD/zXCTZl/
	Xm83QtlbUw1jEAozXyWxj+lLK5hFrNdwK7ygMyQhRuBf4iA==
X-Received: by 2002:a05:620a:2892:b0:886:ea5d:9273 with SMTP id af79cd13be357-8906e6ba4b1mr2387618885a.28.1761086585038;
        Tue, 21 Oct 2025 15:43:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKKo/21Swm4z17XlE0/ydMbQxCAbbChu7Z8fNIxB6CZQJ6hcePBsIiw2WUviotKsZ3CeiiMA==
X-Received: by 2002:a05:620a:2892:b0:886:ea5d:9273 with SMTP id af79cd13be357-8906e6ba4b1mr2387614585a.28.1761086584536;
        Tue, 21 Oct 2025 15:43:04 -0700 (PDT)
Received: from ?IPV6:2601:600:947f:f020:85dc:d2b2:c5ee:e3c4? ([2601:600:947f:f020:85dc:d2b2:c5ee:e3c4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-891cefba728sm848019085a.38.2025.10.21.15.43.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 15:43:03 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <ba437129-062a-4a2f-a753-64945e9a13ff@redhat.com>
Date: Tue, 21 Oct 2025 18:42:59 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 22/33] kthread: Include unbound kthreads in the managed
 affinity list
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
 <20251013203146.10162-23-frederic@kernel.org>
Content-Language: en-US
In-Reply-To: <20251013203146.10162-23-frederic@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 10/13/25 4:31 PM, Frederic Weisbecker wrote:
> The managed affinity list currently contains only unbound kthreads that
> have affinity preferences. Unbound kthreads globally affine by default
> are outside of the list because their affinity is automatically managed
> by the scheduler (through the fallback housekeeping mask) and by cpuset.
>
> However in order to preserve the preferred affinity of kthreads, cpuset
> will delegate the isolated partition update propagation to the
> housekeeping and kthread code.
>
> Prepare for that with including all unbound kthreads in the managed
> affinity list.
>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>   kernel/kthread.c | 59 ++++++++++++++++++++++++------------------------
>   1 file changed, 30 insertions(+), 29 deletions(-)
>
> diff --git a/kernel/kthread.c b/kernel/kthread.c
> index c4dd967e9e9c..cba3d297f267 100644
> --- a/kernel/kthread.c
> +++ b/kernel/kthread.c
> @@ -365,9 +365,10 @@ static void kthread_fetch_affinity(struct kthread *kthread, struct cpumask *cpum
>   	if (kthread->preferred_affinity) {
>   		pref = kthread->preferred_affinity;
>   	} else {
> -		if (WARN_ON_ONCE(kthread->node == NUMA_NO_NODE))
> -			return;
> -		pref = cpumask_of_node(kthread->node);
> +		if (kthread->node == NUMA_NO_NODE)
> +			pref = housekeeping_cpumask(HK_TYPE_KTHREAD);
> +		else
> +			pref = cpumask_of_node(kthread->node);
>   	}
>   
>   	cpumask_and(cpumask, pref, housekeeping_cpumask(HK_TYPE_KTHREAD));
> @@ -380,32 +381,29 @@ static void kthread_affine_node(void)
>   	struct kthread *kthread = to_kthread(current);
>   	cpumask_var_t affinity;
>   
> -	WARN_ON_ONCE(kthread_is_per_cpu(current));
> +	if (WARN_ON_ONCE(kthread_is_per_cpu(current)))
> +		return;
>   
> -	if (kthread->node == NUMA_NO_NODE) {
> -		housekeeping_affine(current, HK_TYPE_KTHREAD);
> -	} else {
> -		if (!zalloc_cpumask_var(&affinity, GFP_KERNEL)) {
> -			WARN_ON_ONCE(1);
> -			return;
> -		}
> -
> -		mutex_lock(&kthread_affinity_lock);
> -		WARN_ON_ONCE(!list_empty(&kthread->affinity_node));
> -		list_add_tail(&kthread->affinity_node, &kthread_affinity_list);
> -		/*
> -		 * The node cpumask is racy when read from kthread() but:
> -		 * - a racing CPU going down will either fail on the subsequent
> -		 *   call to set_cpus_allowed_ptr() or be migrated to housekeepers
> -		 *   afterwards by the scheduler.
> -		 * - a racing CPU going up will be handled by kthreads_online_cpu()
> -		 */
> -		kthread_fetch_affinity(kthread, affinity);
> -		set_cpus_allowed_ptr(current, affinity);
> -		mutex_unlock(&kthread_affinity_lock);
> -
> -		free_cpumask_var(affinity);
> +	if (!zalloc_cpumask_var(&affinity, GFP_KERNEL)) {
> +		WARN_ON_ONCE(1);
> +		return;
>   	}
> +
> +	mutex_lock(&kthread_affinity_lock);
> +	WARN_ON_ONCE(!list_empty(&kthread->affinity_node));
> +	list_add_tail(&kthread->affinity_node, &kthread_affinity_list);
> +	/*
> +	 * The node cpumask is racy when read from kthread() but:
> +	 * - a racing CPU going down will either fail on the subsequent
> +	 *   call to set_cpus_allowed_ptr() or be migrated to housekeepers
> +	 *   afterwards by the scheduler.
> +	 * - a racing CPU going up will be handled by kthreads_online_cpu()
> +	 */
> +	kthread_fetch_affinity(kthread, affinity);
> +	set_cpus_allowed_ptr(current, affinity);
> +	mutex_unlock(&kthread_affinity_lock);
> +
> +	free_cpumask_var(affinity);
>   }
>   
>   static int kthread(void *_create)
> @@ -924,8 +922,11 @@ static int kthreads_online_cpu(unsigned int cpu)
>   			ret = -EINVAL;
>   			continue;
>   		}
> -		kthread_fetch_affinity(k, affinity);
> -		set_cpus_allowed_ptr(k->task, affinity);
> +
> +		if (k->preferred_affinity || k->node != NUMA_NO_NODE) {
> +			kthread_fetch_affinity(k, affinity);
> +			set_cpus_allowed_ptr(k->task, affinity);
> +		}
>   	}

My understanding of kthreads_online_cpu() is that hotplug won't affect 
the affinity returned from kthread_fetch_affinity(). However, 
set_cpus_allowed_ptr() will mask out all the offline CPUs. So if the 
given "cpu" to be brought online is in the returned affinity, we should 
call set_cpus_allowed_ptr() to add this cpu into its affinity mask 
though the current code will call it even it is not strictly necessary. 
This change will not do this update to NUMA_NO_NODE kthread with no 
preferred_affinity, is this a problem?

Cheers,
Longman


