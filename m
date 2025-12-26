Return-Path: <netdev+bounces-246100-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D2C73CDF0FC
	for <lists+netdev@lfdr.de>; Fri, 26 Dec 2025 22:37:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 59DD83005483
	for <lists+netdev@lfdr.de>; Fri, 26 Dec 2025 21:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D79F1F4615;
	Fri, 26 Dec 2025 21:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="My1Mx4Xt";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="bAkWmCra"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF8919CD03
	for <netdev@vger.kernel.org>; Fri, 26 Dec 2025 21:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766785061; cv=none; b=MproKSBzVaIR8wopFv8ucdU+RL4nYXCLNyoE9LO0P3T1VE7ccKBxfsvuQNNFSIzoHvMKW0FUZGplZfZ+w0N3OwqOJH6oJzb+Dl4jJFU5h9H/wkNbAplxB2OIJlVIrPD0RgrlMh/HFiKUq/p3b+IHoggG/F/QCzBKrLNCLvEy86M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766785061; c=relaxed/simple;
	bh=X+mEgsNRkXIT4lMXTBvZoqKWijU0MQoRTGT0mUCNFi4=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=WiLrM1CA894BVwhWvuzfjaOEXq4pWy0m5YxsTZFwouMXru2QOvalQgTrXqqFpNeBDEQoPup0DRHRQj9z7vIVqJC5SvpyTFZ5QL0illuwzf5s88jkrz2oDmOKbfByX0wSj8mdWy4+ZpzHvB/T2NpHfyuFG2qurBxHMVTsWjoXA9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=My1Mx4Xt; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=bAkWmCra; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766785058;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=asBMqPMMlBYgauRrbMzCES/5E7Ini+6B8CJ6RNaEzp0=;
	b=My1Mx4Xtk+XD1ZIYtOKdpgUl82RTW3LP7ChK3Cq973arZcbQw5zJKP3lT7dbZYIINAXhgl
	N3AHiu8PGVIkn9hp0F/mDE2qcz/csh5B7pmdWdCqo4/7xxzsBp0ABHSZBcroj2BI3TfdDS
	h/fwHu5Eo3WxcR8bnKZkMnlO7xg4Ke4=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-78-gwW5fIuzOrKlYpTOLt2lUQ-1; Fri, 26 Dec 2025 16:37:37 -0500
X-MC-Unique: gwW5fIuzOrKlYpTOLt2lUQ-1
X-Mimecast-MFC-AGG-ID: gwW5fIuzOrKlYpTOLt2lUQ_1766785057
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8888a6cb328so192079016d6.0
        for <netdev@vger.kernel.org>; Fri, 26 Dec 2025 13:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766785057; x=1767389857; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=asBMqPMMlBYgauRrbMzCES/5E7Ini+6B8CJ6RNaEzp0=;
        b=bAkWmCraMlcyr8+zppyAcC7lcIsamdF3Y8M2E1CqbMwz0EQsJUweGErLixi7chn3EO
         sUMlrqI1F4/e0/7pMYrF8yBEm1HMBkFrirSUT7oxVhBwWzzESXxhylJCgVccpFNyFyGx
         jTK747AAFFvLTtP5drSmSSts2a/DCZbJNKcBkpHSxKKiix8ya/VWE/HWJRMLx+1Ff3Nt
         2YCa/ckbNbiZndFaoAzHHiDcdnV5Ng+Z4Xi/t+YSzPStA8vfMD1aCOTsI7n02XEHmmdJ
         mPO3uxVCPxrKGpHqO+/wWr+0MAQHWAhHxVW8x5AcQBD4A7a26OgdZiFLsYe3PpFAi2ts
         NLsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766785057; x=1767389857;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=asBMqPMMlBYgauRrbMzCES/5E7Ini+6B8CJ6RNaEzp0=;
        b=Lhk0KT8By8mry8U7Vqgf0oae0ShZqDQPZECB2RqKQVMCw3egHVMYpj816Cfh/wOqBe
         MouFgU6C4izHlga+1EX1RElwaiuPnUNiQ1F7l7yeciJ416BgGHum84tTdsGj7wifKRgB
         WGkN+RqKVGfaB/tIajuxSz5hZ9hbI6wR7r34pTKdLgXU+LyagEyRbLSiSfhXkAMaWKtS
         vSTTBHRzk5TNrYaL/Xtr5i5nrn/dkf/7pik5/M6tjhKXBywUCd6lJrgI5caWOc4SkwvE
         SQTAT/8yw1lTkcT2XOYmNsOW6RftF413JQSsc/YTjUquYfeHVZVhIJptJkHiXoKmA7tp
         u1Ow==
X-Forwarded-Encrypted: i=1; AJvYcCWxMn0dg2wyf3tb1NzuU8XdpUg0YgwUK+UAN3e6B+xBxdoTA1/qQt7Vub6hGOwUnMZXCnOM89Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLdx8zJW7eCa6nq8DVwnavWZCbRO7d4vZ5Yirq7EOmUW6dfI/f
	U5GpM+wR3iW/zUuzIu7SVjVr+VDp1cjocpCzfvwSyg9juaiNYG5zlP8pXrLLT9pIXpPhfUeIEon
	VRyxCfTCdMrp/LfHIGBXwf+mcUWzj5P754BvfPHR1MnKtKXwj9OiT9Tstzw==
X-Gm-Gg: AY/fxX7fg6o3NbHlF1UlGxncSTsgO9HZH16QXBi2lSM0wIJqS71kT+Nved2ASk+3mw3
	sIDRmYRSZtlKZIihR6FcdqoZdZeVYINumyg3332jM5f9kcRrKnWPkgVblVhOzTbI6weVuhVtUYz
	D7yevp+9EJU1UPISxn2bZ7uw8SSJVkD7TXVKqZZGXsK8WYW77vcBqmBsb3uijieY7nIIfzj343G
	qSP//EI53q/1dCv3Zng1fC0fV71xT265o3NntbmrGty3zWKnDR0HZuDqzI+mtTFXD7Pfn9uxAxq
	EmzAL4mX23+FKlVG7ztsQRlxEZ5XQb/tR6PmFuT95wMede8YF19WHU7CWEYr/9CHDpEw2RWVm2I
	VNus4ks+NvVs3VF9LklWDpshWGzA1NSo5hPylR1o5n94FP3cQzUcefsWk
X-Received: by 2002:a05:6214:1ccf:b0:786:8f81:42f with SMTP id 6a1803df08f44-88d8369eac6mr381481996d6.39.1766785056798;
        Fri, 26 Dec 2025 13:37:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF/UszSTKNZq6JUtpfA708/ibPfYyEh5wUQDx/+llWKoJlmPrhzPZqD/XUz+CjETOu+z3XbwQ==
X-Received: by 2002:a05:6214:1ccf:b0:786:8f81:42f with SMTP id 6a1803df08f44-88d8369eac6mr381481746d6.39.1766785056354;
        Fri, 26 Dec 2025 13:37:36 -0800 (PST)
Received: from ?IPV6:2601:600:947f:f020:85dc:d2b2:c5ee:e3c4? ([2601:600:947f:f020:85dc:d2b2:c5ee:e3c4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88d9680c323sm170712766d6.13.2025.12.26.13.37.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Dec 2025 13:37:35 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <af440ae9-e6ee-4cc8-a2d6-2178d9c80a50@redhat.com>
Date: Fri, 26 Dec 2025 16:37:31 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 24/33] kthread: Refine naming of affinity related fields
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
 <20251224134520.33231-25-frederic@kernel.org>
Content-Language: en-US
In-Reply-To: <20251224134520.33231-25-frederic@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/24/25 8:45 AM, Frederic Weisbecker wrote:
> The kthreads preferred affinity related fields use "hotplug" as the base
> of their naming because the affinity management was initially deemed to
> deal with CPU hotplug.
>
> The scope of this role is going to broaden now and also deal with
> cpuset isolated partition updates.
>
> Switch the naming accordingly.
>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>   kernel/kthread.c | 38 +++++++++++++++++++-------------------
>   1 file changed, 19 insertions(+), 19 deletions(-)
>
> diff --git a/kernel/kthread.c b/kernel/kthread.c
> index 99a3808d086f..f1e4f1f35cae 100644
> --- a/kernel/kthread.c
> +++ b/kernel/kthread.c
> @@ -35,8 +35,8 @@ static DEFINE_SPINLOCK(kthread_create_lock);
>   static LIST_HEAD(kthread_create_list);
>   struct task_struct *kthreadd_task;
>   
> -static LIST_HEAD(kthreads_hotplug);
> -static DEFINE_MUTEX(kthreads_hotplug_lock);
> +static LIST_HEAD(kthread_affinity_list);
> +static DEFINE_MUTEX(kthread_affinity_lock);
>   
>   struct kthread_create_info
>   {
> @@ -69,7 +69,7 @@ struct kthread {
>   	/* To store the full name if task comm is truncated. */
>   	char *full_name;
>   	struct task_struct *task;
> -	struct list_head hotplug_node;
> +	struct list_head affinity_node;
>   	struct cpumask *preferred_affinity;
>   };
>   
> @@ -128,7 +128,7 @@ bool set_kthread_struct(struct task_struct *p)
>   
>   	init_completion(&kthread->exited);
>   	init_completion(&kthread->parked);
> -	INIT_LIST_HEAD(&kthread->hotplug_node);
> +	INIT_LIST_HEAD(&kthread->affinity_node);
>   	p->vfork_done = &kthread->exited;
>   
>   	kthread->task = p;
> @@ -323,10 +323,10 @@ void __noreturn kthread_exit(long result)
>   {
>   	struct kthread *kthread = to_kthread(current);
>   	kthread->result = result;
> -	if (!list_empty(&kthread->hotplug_node)) {
> -		mutex_lock(&kthreads_hotplug_lock);
> -		list_del(&kthread->hotplug_node);
> -		mutex_unlock(&kthreads_hotplug_lock);
> +	if (!list_empty(&kthread->affinity_node)) {
> +		mutex_lock(&kthread_affinity_lock);
> +		list_del(&kthread->affinity_node);
> +		mutex_unlock(&kthread_affinity_lock);
>   
>   		if (kthread->preferred_affinity) {
>   			kfree(kthread->preferred_affinity);
> @@ -390,9 +390,9 @@ static void kthread_affine_node(void)
>   			return;
>   		}
>   
> -		mutex_lock(&kthreads_hotplug_lock);
> -		WARN_ON_ONCE(!list_empty(&kthread->hotplug_node));
> -		list_add_tail(&kthread->hotplug_node, &kthreads_hotplug);
> +		mutex_lock(&kthread_affinity_lock);
> +		WARN_ON_ONCE(!list_empty(&kthread->affinity_node));
> +		list_add_tail(&kthread->affinity_node, &kthread_affinity_list);
>   		/*
>   		 * The node cpumask is racy when read from kthread() but:
>   		 * - a racing CPU going down will either fail on the subsequent
> @@ -402,7 +402,7 @@ static void kthread_affine_node(void)
>   		 */
>   		kthread_fetch_affinity(kthread, affinity);
>   		set_cpus_allowed_ptr(current, affinity);
> -		mutex_unlock(&kthreads_hotplug_lock);
> +		mutex_unlock(&kthread_affinity_lock);
>   
>   		free_cpumask_var(affinity);
>   	}
> @@ -873,16 +873,16 @@ int kthread_affine_preferred(struct task_struct *p, const struct cpumask *mask)
>   		goto out;
>   	}
>   
> -	mutex_lock(&kthreads_hotplug_lock);
> +	mutex_lock(&kthread_affinity_lock);
>   	cpumask_copy(kthread->preferred_affinity, mask);
> -	WARN_ON_ONCE(!list_empty(&kthread->hotplug_node));
> -	list_add_tail(&kthread->hotplug_node, &kthreads_hotplug);
> +	WARN_ON_ONCE(!list_empty(&kthread->affinity_node));
> +	list_add_tail(&kthread->affinity_node, &kthread_affinity_list);
>   	kthread_fetch_affinity(kthread, affinity);
>   
>   	scoped_guard (raw_spinlock_irqsave, &p->pi_lock)
>   		set_cpus_allowed_force(p, affinity);
>   
> -	mutex_unlock(&kthreads_hotplug_lock);
> +	mutex_unlock(&kthread_affinity_lock);
>   out:
>   	free_cpumask_var(affinity);
>   
> @@ -903,9 +903,9 @@ static int kthreads_online_cpu(unsigned int cpu)
>   	struct kthread *k;
>   	int ret;
>   
> -	guard(mutex)(&kthreads_hotplug_lock);
> +	guard(mutex)(&kthread_affinity_lock);
>   
> -	if (list_empty(&kthreads_hotplug))
> +	if (list_empty(&kthread_affinity_list))
>   		return 0;
>   
>   	if (!zalloc_cpumask_var(&affinity, GFP_KERNEL))
> @@ -913,7 +913,7 @@ static int kthreads_online_cpu(unsigned int cpu)
>   
>   	ret = 0;
>   
> -	list_for_each_entry(k, &kthreads_hotplug, hotplug_node) {
> +	list_for_each_entry(k, &kthread_affinity_list, affinity_node) {
>   		if (WARN_ON_ONCE((k->task->flags & PF_NO_SETAFFINITY) ||
>   				 kthread_is_per_cpu(k->task))) {
>   			ret = -EINVAL;
Acked-by: Waiman Long <longman@redhat.com>


