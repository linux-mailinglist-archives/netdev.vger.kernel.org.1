Return-Path: <netdev+bounces-246101-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF1ECDF12F
	for <lists+netdev@lfdr.de>; Fri, 26 Dec 2025 23:11:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B7B430109AB
	for <lists+netdev@lfdr.de>; Fri, 26 Dec 2025 22:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 764052877CF;
	Fri, 26 Dec 2025 22:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NmuGXbKl";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="EidF7Ydq"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F67135A53
	for <netdev@vger.kernel.org>; Fri, 26 Dec 2025 22:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766787097; cv=none; b=k+7LZD+sPHqmGQuxO8cPyyGvH8LuyckpOOkXe394zXPUVDyOSpITv6tXX9s2n1uHu/546qQ9dpMOXBBpDXVPwV+0564xew4CNBhsfnxdMycuDZSJSDU1W0SQbRDrTikaotov6qoW+17XmHkpp2VAYBwrbBdnwI8ARZGiVth+zzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766787097; c=relaxed/simple;
	bh=R9tnImEFZzIwnpkj2WDVfVzgbrkCYG/lZwE4VsztwgI=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=hKJft+k/8ICqFTWIFxR+kyvdjUy4SfUGvSch6rJtT2do/kwyOnLOQe7B8sEOPHLsfdAyvvPcqZVHbStcPNTNcswaY7+QBttyVvBAG8tKVj6tQiv4E3GklDLSVzLf0IsjZHy3dBiUlYjiUgbRQPrm5HTtFh2ONGDl7+ESVvBXoxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NmuGXbKl; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=EidF7Ydq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766787094;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TkFBnQY3LS/CUDnrkcxR3YOk4jUDJ9IE93cEOOeBXqU=;
	b=NmuGXbKl1ddvCuhKhxYwRYtD+C4NAzkzwuBr/1DcPLAc4jjeTMZppqy2rfz5esB7I1riKM
	4m6yKfs54E9JSGnMou1Qhod0XJ2kO/y4t4L9UJImTE8DtXprSQDXMRDRykFlcHbuMiia3n
	QgFVX8jLgXZekhhbVAMjOIsqb9EbEjg=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-93-KEhJBOudPNyg5jjEj2CYRg-1; Fri, 26 Dec 2025 17:11:32 -0500
X-MC-Unique: KEhJBOudPNyg5jjEj2CYRg-1
X-Mimecast-MFC-AGG-ID: KEhJBOudPNyg5jjEj2CYRg_1766787092
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4f4ab58098eso177252901cf.1
        for <netdev@vger.kernel.org>; Fri, 26 Dec 2025 14:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766787092; x=1767391892; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TkFBnQY3LS/CUDnrkcxR3YOk4jUDJ9IE93cEOOeBXqU=;
        b=EidF7YdqfyHw2+42PNOPVaxHWa35FwPtFgE1WAbC5CTRD9tIR+8icI6UGXyvHiVPUT
         nD6mR1IcfsqKp/VfccdhNo+iY5YH3QMrnUer4n2pAEBsDrORuGEc271YQjF74sWeDfsb
         wsaAF+EjM/qf4iECJJf5YKZlH+lhhyJapXrCWE/DiKIHmyw0tw0v16nVIfXK77PJ5bMb
         l8FnU9wa8EuKRU4QMlaUkCX/ivgPGpKG3LlOr2Rh1Fl2ASVJy5bOwk7jWQrOQZgO+tdH
         mTae93qCT+F3wgXvhN4A8YD1m+ZThxKo31bEHrsMVbxOwXuwMD19eFAtcQAkqPDmrU/b
         nN4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766787092; x=1767391892;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TkFBnQY3LS/CUDnrkcxR3YOk4jUDJ9IE93cEOOeBXqU=;
        b=ej5JXpDj8hxL4vyEjvN6gT2ZKPfVRxXlaevfE207LtgAXsKVnELy2/BFoZ2gewPPQQ
         BH3xylUvflckvNW3IElKyf1Lgb7e7SHnYxbqBfhhus75WyhzEHBMMNy3vnrWz9bDhAQU
         Knxgo5X7miecoY1TzblljQ/0DC0AfNNS0c+dsXpkpRG/fQXwn0BotHlmSiLFHzszcDHW
         L4k5//DyDH4ahoN4F9bKJg7ea0KNICJBsuuAGbPvoC+Uo1SUEAuMYpPtYuLaKlS5IPFh
         OoXRntuHXHm7iYQ9abY5RxCX2G8e3WdCpd3V3Nf4qrhLGmHBSFwEMfMJsv3BkboMZ9dq
         /B/w==
X-Forwarded-Encrypted: i=1; AJvYcCU1j2POXILdlvKpXRSYyTFHPsZ2M9FFHnAy0RxNxZKtlGT+Lbr0tbK0ByLpoRwHkukF0+c+BZY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5NfUHUlIuxPOW8NmNlh2cSjB4jdkEiGtAHtROEJJ+ZCnaFh9S
	K4gCK2mVZKWn81jytgC8RQUGV6NKCDpulERcuHE/edFUcWE9+2+37zZs/h/XQ9TxqCDweJIa+2r
	S99FHCZeO4XT3STA/BaVcwYZBAnnRgU90jDn9Q3ZiNRTHVLmvx+ViUd/BGA==
X-Gm-Gg: AY/fxX4XLPDxbwhD3q6hvk09Qv7tsZcoPS8MZWmGRrV4dxW+9e+J6UlxovqGAtXaBZk
	Cl19GrOVWrOXSKbGdXL35hFNuWBA3ZOJ7BWKB0Djokh4tEMwCk6GwWsJiQAx7/rLuaTVk/3RLVI
	Rv1qaznmTfJVJNkgN4saK/CiXNeeYF2ChHka9F+TIDmenYsXkUS3heliB6PNt18IOBBesE2LQR6
	YXWSmHkhrEQap5QQ0+qJBnOuyqvXBRZvTZqytxdCfHiCNwU6x5Fhj20uJHcYRvYbLJUaoXRL4sh
	DKqpBCFYxpxMII0BqV7HnnRq+X9hMlpAxBF13ZW36+TSFJV0gtk27hUz7ROADt7GbFUEwR0wWSG
	eTCwb00pkHYaw6F76SdRsUwSKfNmVXTam65xPwWBKpBLd0DNRPPuQGgUt
X-Received: by 2002:a05:622a:4a09:b0:4ee:2510:198a with SMTP id d75a77b69052e-4f4abd75629mr345582181cf.39.1766787091849;
        Fri, 26 Dec 2025 14:11:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGfAC0mMAvBMTtIg0HnYR5V/3qz64S5XCvmCWe5yr1a0y1ZiMQUT11GI7YF+lRu7HFhzwx/CQ==
X-Received: by 2002:a05:622a:4a09:b0:4ee:2510:198a with SMTP id d75a77b69052e-4f4abd75629mr345581701cf.39.1766787091473;
        Fri, 26 Dec 2025 14:11:31 -0800 (PST)
Received: from ?IPV6:2601:600:947f:f020:85dc:d2b2:c5ee:e3c4? ([2601:600:947f:f020:85dc:d2b2:c5ee:e3c4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88d9623fd37sm176347436d6.3.2025.12.26.14.11.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Dec 2025 14:11:30 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <1e530c72-75d7-4c7e-96e7-329056d6baf5@redhat.com>
Date: Fri, 26 Dec 2025 17:11:26 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 25/33] kthread: Include unbound kthreads in the managed
 affinity list
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
 <20251224134520.33231-26-frederic@kernel.org>
Content-Language: en-US
In-Reply-To: <20251224134520.33231-26-frederic@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/24/25 8:45 AM, Frederic Weisbecker wrote:
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
>   kernel/kthread.c | 70 ++++++++++++++++++++++++++++--------------------
>   1 file changed, 41 insertions(+), 29 deletions(-)
>
> diff --git a/kernel/kthread.c b/kernel/kthread.c
> index f1e4f1f35cae..51c0908d3d02 100644
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
> @@ -919,8 +917,22 @@ static int kthreads_online_cpu(unsigned int cpu)
>   			ret = -EINVAL;
>   			continue;
>   		}
> -		kthread_fetch_affinity(k, affinity);
> -		set_cpus_allowed_ptr(k->task, affinity);
> +
> +		/*
> +		 * Unbound kthreads without preferred affinity are already affine
> +		 * to housekeeping, whether those CPUs are online or not. So no need
> +		 * to handle newly online CPUs for them.
> +		 *
> +		 * But kthreads with a preferred affinity or node are different:
> +		 * if none of their preferred CPUs are online and part of
> +		 * housekeeping at the same time, they must be affine to housekeeping.
> +		 * But as soon as one of their preferred CPU becomes online, they must
> +		 * be affine to them.
> +		 */
> +		if (k->preferred_affinity || k->node != NUMA_NO_NODE) {
> +			kthread_fetch_affinity(k, affinity);
> +			set_cpus_allowed_ptr(k->task, affinity);
> +		}
>   	}
>   
>   	free_cpumask_var(affinity);
Reviewed-by: Waiman Long <longman@redhat.com>


