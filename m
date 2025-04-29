Return-Path: <netdev+bounces-186735-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89BE7AA0B4D
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 14:13:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4584B3A49F4
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 12:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B46C2C10B9;
	Tue, 29 Apr 2025 12:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TazUkZnT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A80021325C
	for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 12:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745928801; cv=none; b=oWqMa8aWvjSYtYy4Jup6NallBbE3EmpTreiUaWPbFL0N2d+gyMC8qnlaICig1Sr8vFb+ffq4cMU2NBwT4+3gnc3toNTKUyMxsRa5XbE2RwbMVHuXchVhzTzXepM9+CxoNDSC0lNbaeHirZZMdL4/Y3jgswLiYRDrDsIS7U4WpW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745928801; c=relaxed/simple;
	bh=GQiTk/htn7/1BJVac7ftCVKE98dbVakVfVbslKTnr/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UNr5cYvOtgGlCFV6f4kh0aHsdo6ln1WA+HVyGSjPT7prSqHBGLGryQJNwoG/rDQlcuKICuSKu3WQu4W3nG3IjJzYZLAmSqUALRfP0XRyY+kKd7ZTiS3Bd6LuK5nKanQKfWegjO6xsOsb7nMpr+UVusJ8SHiZDJIaSwjgsrsmcTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TazUkZnT; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5efe8d9eb1eso6293342a12.0
        for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 05:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1745928798; x=1746533598; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XGwtrgjfssbRJnnLGAioENkMU7oIKogOgkQ9Ev2GRas=;
        b=TazUkZnT+3u7GG3XZtebYztPDVTZ2sRpxc52gskp937d5dikBOAFCCWOU6YrS3zjqu
         gt1whZRuJOBHd9KXPCK65YkuLzcMKTh3GeC+JvTNqZMSDnG6weU1zjfmy4IQaruyOX/r
         GMxVGUpu4+uxQEQXc+R/mWlegAybsB4Wpdkbq6XEIPhLCAvVp7TPpy0obTQMRe0KK2Wm
         zARFY8dbXaib5uDeyPnzqKz57vgXxkSWGQZK+xvzBkxH3ZgccEcmJYW/XuhdHsfN2ELX
         3uB2WD3gbpNBVRrqmtvJrTezgGJJ7R/1qSy00JJOaZUFklZmra5cd/JUV2oNpRhvnOBj
         hr6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745928798; x=1746533598;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XGwtrgjfssbRJnnLGAioENkMU7oIKogOgkQ9Ev2GRas=;
        b=Y+cMrqYTHy47IBpVdLxiHVDWbDAz1uuszM703Ql5UofUZJx4bLAqJ+44JbdoqqDOWo
         MdO15dpHiCF+DpmIzVdnZ656s7CvMyKtZNBg+cuQcOTafndzjdUJqUcfyZq+iLZ51Dvd
         DjPqk5NGMpwm5M30w1iezprb/PXwpxg3Pmrq2qIy5B9iZiaTXHfoxQMxPFF/pcITINHB
         tZGFhlYN0x2KVCrSQMzaKiSwo19jdiwsLzRlucIf1IKq8rfAKX0aKjO9eLX/wiEAIo+8
         v2kQCwqmN8YPc+1TfgebBajZg8tL2FPMVmt+Ls2ty1BpmeBWkJscMeGJLF8Fs19yFW/5
         yWhA==
X-Forwarded-Encrypted: i=1; AJvYcCV/PgXh/sEC8H79JK/8rzc2BEbj642/+r5PycWelBmUD892uvS5aYJyh2OA+qYA6cb1PD077XA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5tJqL3JHzXoZKubkvpDRUMrCN3WHv3EcNhoW7WdQZDqCt3GxM
	OAz+zoL0RxC/F1wSfNWxUlVw73DEIZI2QaaBqmVfHcowp38+ot0W6ZQVPMUZ+XI=
X-Gm-Gg: ASbGnctW18WnHet71TYfzTTkpDzHAIzBHTvvD7F0ondnyXRCIAZaMDUbo4mDa3I2Ovb
	hcreFCNNPK9PAoZTQLMNNTxlkEWNJnJmj6qbecu/1U05TPaksXpP67k9qbAqwdE0Z5t/tFzofMh
	5ovtBMq463XzrgH6Xbhrk+KCFOomrpst/L6MLFUN1aclXwOthWMPLs697v2Rpvrn8QbTOiyEq0M
	yMELGGGJPFzrwhbeYKZdwG8+TotsxHs02NZc3H7yfg9K6yo7DAS7D6mp+q9g8M1+0obePxnItyw
	8uOG3MDpPF79W5azftrnL34JVN9D/ptDM1OQCbLcbesV8Er4mN6YKA==
X-Google-Smtp-Source: AGHT+IEo5qlskE04ChdYwUfeG14jGRzrfDGg7ko0hloQlCXfAEEdIv4iz53wIbhKxTpKz7/q/ZoqMg==
X-Received: by 2002:a05:6402:5112:b0:5ed:bab5:3093 with SMTP id 4fb4d7f45d1cf-5f839b24397mr2697613a12.16.1745928797630;
        Tue, 29 Apr 2025 05:13:17 -0700 (PDT)
Received: from localhost (109-81-85-148.rct.o2.cz. [109.81.85.148])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-5f7038328f1sm7319317a12.70.2025.04.29.05.13.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 05:13:17 -0700 (PDT)
Date: Tue, 29 Apr 2025 14:13:16 +0200
From: Michal Hocko <mhocko@suse.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Vlastimil Babka <vbabka@suse.cz>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Soheil Hassas Yeganeh <soheil@google.com>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH] memcg: multi-memcg percpu charge cache
Message-ID: <aBDCXB_Tb2Iaihua@tiehlicka>
References: <20250416180229.2902751-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250416180229.2902751-1-shakeel.butt@linux.dev>

On Wed 16-04-25 11:02:29, Shakeel Butt wrote:
> Memory cgroup accounting is expensive and to reduce the cost, the kernel
> maintains per-cpu charge cache for a single memcg. So, if a charge
> request comes for a different memcg, the kernel will flush the old
> memcg's charge cache and then charge the newer memcg a fixed amount (64
> pages), subtracts the charge request amount and stores the remaining in
> the per-cpu charge cache for the newer memcg.
> 
> This mechanism is based on the assumption that the kernel, for locality,
> keep a process on a CPU for long period of time and most of the charge
> requests from that process will be served by that CPU's local charge
> cache.
> 
> However this assumption breaks down for incoming network traffic in a
> multi-tenant machine. We are in the process of running multiple
> workloads on a single machine and if such workloads are network heavy,
> we are seeing very high network memory accounting cost. We have observed
> multiple CPUs spending almost 100% of their time in net_rx_action and
> almost all of that time is spent in memcg accounting of the network
> traffic.
> 
> More precisely, net_rx_action is serving packets from multiple workloads
> and is observing/serving mix of packets of these workloads. The memcg
> switch of per-cpu cache is very expensive and we are observing a lot of
> memcg switches on the machine. Almost all the time is being spent on
> charging new memcg and flushing older memcg cache. So, definitely we
> need per-cpu cache that support multiple memcgs for this scenario.
> 
> This patch implements a simple (and dumb) multiple memcg percpu charge
> cache. Actually we started with more sophisticated LRU based approach but
> the dumb one was always better than the sophisticated one by 1% to 3%,
> so going with the simple approach.

Makes sense to start simple and go for a more sophisticated (has table
appraoch maybe) later when a clear gain could be demonstrated.

> Some of the design choices are:
> 
> 1. Fit all caches memcgs in a single cacheline.

Could you be more specific about the reasoning? I suspect it is for the
network receive path you are mentioning above, right?

> 2. The cache array can be mix of empty slots or memcg charged slots, so
>    the kernel has to traverse the full array.
> 3. The cache drain from the reclaim will drain all cached memcgs to keep
>    things simple.
> 
> To evaluate the impact of this optimization, on a 72 CPUs machine, we
> ran the following workload where each netperf client runs in a different
> cgroup. The next-20250415 kernel is used as base.
> 
>  $ netserver -6
>  $ netperf -6 -H ::1 -l 60 -t TCP_SENDFILE -- -m 10K
> 
> number of clients | Without patch | With patch
>   6               | 42584.1 Mbps  | 48603.4 Mbps (14.13% improvement)
>   12              | 30617.1 Mbps  | 47919.7 Mbps (56.51% improvement)
>   18              | 25305.2 Mbps  | 45497.3 Mbps (79.79% improvement)
>   24              | 20104.1 Mbps  | 37907.7 Mbps (88.55% improvement)
>   30              | 14702.4 Mbps  | 30746.5 Mbps (109.12% improvement)
>   36              | 10801.5 Mbps  | 26476.3 Mbps (145.11% improvement)
> 
> The results show drastic improvement for network intensive workloads.
> 
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>

Just a minor suggestion below. Other than that looks good to me (with
follow up fixes) in this thread.
Acked-by: Michal Hocko <mhocko@suse.com>
Thanks!

> ---
>  mm/memcontrol.c | 128 ++++++++++++++++++++++++++++++++++--------------
>  1 file changed, 91 insertions(+), 37 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 1ad326e871c1..0a02ba07561e 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1769,10 +1769,11 @@ void mem_cgroup_print_oom_group(struct mem_cgroup *memcg)
>  	pr_cont(" are going to be killed due to memory.oom.group set\n");
>  }
>  

/* Make sure nr_pages and cached fit into a single cache line */
> +#define NR_MEMCG_STOCK 7
>  struct memcg_stock_pcp {
>  	local_trylock_t stock_lock;
> -	struct mem_cgroup *cached; /* this never be root cgroup */
> -	unsigned int nr_pages;
> +	uint8_t nr_pages[NR_MEMCG_STOCK];
> +	struct mem_cgroup *cached[NR_MEMCG_STOCK];
>  
>  	struct obj_cgroup *cached_objcg;
>  	struct pglist_data *cached_pgdat;
[...]
-- 
Michal Hocko
SUSE Labs

