Return-Path: <netdev+bounces-148204-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E329E0CDE
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 21:16:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA9E4165705
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 20:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5DAC1DE4E6;
	Mon,  2 Dec 2024 20:16:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26ED1D5CF1;
	Mon,  2 Dec 2024 20:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733170568; cv=none; b=WYhlD7P6WNrMvpOdHcVZmOKRJxhVTd/vTESx5sL8B75RxvILJkNMd+KQo4gm6YLL29pdLPa2gqlbzIPEvj3xC5vwrXU9LgzrnlNNGSZAfrkyA3JhD1km2FHq/VZ6PEgXUSOvFnO8xr+yP2qNHlwEk5GLqpxKoorAg78IfQDdS0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733170568; c=relaxed/simple;
	bh=TMV/+O0cAwDA04iphALHpPhxO/Itj+IVgAoLRHKWHiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WM7S7ongM8g1uCn9NNnZoN2j4o+Pb9wxV/Wh0ReehNL1YfFazSRvxef7z5KqzFyH2U4vwPBtqfC9vErjz/LaMS3q+y9h1OMaH/HNP0dNhBaXUX1VIWCnqROHutYpHAQfHlH4/2M64Ww43savH8/sfjwmt9/BuuqeklQ/eusGQ+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-aa52bb7beceso544929266b.3;
        Mon, 02 Dec 2024 12:16:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733170565; x=1733775365;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CCyLf6bfx3k0JHZbRShg5cX+IhMCY4TrfzkoI8zng30=;
        b=FfoZPxH5sKoqtuiuzSz+Wiu9pj7t5c3wZq5vjwkCGupDFBORle/JBNFI53KzkwN2lr
         oPZlkx9+XkStMMLMX6zk8K04+kM+qKIeRX6nZN0VoW4HV4yntyfqsO6pfoxondMWSZLs
         ngHgdMZA+o57Ou47T7t4LTUoHbitslcM/y9NRfehBFbufmtIzemLdTck9zpdbngK0KzQ
         Bv7yYlrQK6uAIDbh2vuW5zmpKi2SOCZ4mPzOsCQJWR6uQE8El9t5MdXIzCYSdLNt9JC9
         jmq6E6p0RLhV1P5+XWrTSk4umoKjWD0riQUdFRmLPQxgtTWye+rMCA4bYlfqVzJOlgYi
         f0dA==
X-Forwarded-Encrypted: i=1; AJvYcCUi/M/h+pKGj9lQxXqjqsXMu2sSQtfPdiqhUwlDwNcTwAiF0DGrcqq/M4vxEZOTIGgNxj+uLgfb@vger.kernel.org, AJvYcCVH+P9DIrcgwEXzlJFjnJMnUulI+c0p9mZwzod5k5nYZeHenwY1BwBEWoojU7W+C8nqj7iNMEUAN4aaSOY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyspmOvvS0TdpMDsEUKipliiPNDFYmGlfOIMKzdBNFZeSI4g5xG
	ALiX4njzcGKO5kdpSgXVIy1loPK74pYhMXzFfJAy+K5z+PE8T0nptlsJog==
X-Gm-Gg: ASbGncuuaqnTtfTzqkP3sFCtJ54XS+7Bw3mdIII26heTlQHvmrDrJrEk/NruxrEcxGD
	85QWQynaY+c4sqsYwrHC35jHaL49Jm5LX0uARpnptcAO67vUT3oNm52TDc2f/olQaqg6Kzrutjm
	6eApoP5uOxa/O6mAbEciVaiBFEUnxrKyE3BQX4qdYDjS13I6dg1YbHTNBaLX3KAV/LiJfJ9o3+V
	pu8PDRlk5d762I21I/K7+LIWwioPG2Z1QNulUaBQfYw1884ydCkkWvWE+hKZiY5aw1T7ZyB73Pf
	dQ==
X-Google-Smtp-Source: AGHT+IEFaS9kN3DfjwPQXg2byiuEjMe+eb5z9xgNjg+c/qP6MXFk7z/7iNDd3aIhoD4JlEwzGFrhlA==
X-Received: by 2002:a17:906:32c2:b0:aa5:1d68:1ed4 with SMTP id a640c23a62f3a-aa580ecf6b4mr2318908166b.3.1733170564694;
        Mon, 02 Dec 2024 12:16:04 -0800 (PST)
Received: from gmail.com (fwdproxy-lla-008.fbsv.net. [2a03:2880:30ff:8::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa5996dbf54sm543085766b.44.2024.12.02.12.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 12:16:03 -0800 (PST)
Date: Mon, 2 Dec 2024 12:16:01 -0800
From: Breno Leitao <leitao@debian.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Andrew Morton <akpm@linux-foundation.org>, Thomas Graf <tgraf@suug.ch>,
	Tejun Heo <tj@kernel.org>, Hao Luo <haoluo@google.com>,
	Josh Don <joshdon@google.com>, Barret Rhoden <brho@google.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rhashtable: Fix potential deadlock by moving
 schedule_work outside lock
Message-ID: <20241202-solemn-beneficial-dinosaur-7e3e4e@leitao>
References: <20241128-scx_lockdep-v1-1-2315b813b36b@debian.org>
 <Z0lVftsFRSSkPkld@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z0lVftsFRSSkPkld@gondor.apana.org.au>

Hello Herbert,

On Fri, Nov 29, 2024 at 01:47:42PM +0800, Herbert Xu wrote:
> On Thu, Nov 28, 2024 at 04:16:25AM -0800, Breno Leitao wrote:
> > Move the hash table growth check and work scheduling outside the
> > rht lock to prevent a possible circular locking dependency.
> > 
> > The original implementation could trigger a lockdep warning due to
> > a potential deadlock scenario involving nested locks between
> > rhashtable bucket, rq lock, and dsq lock. By relocating the
> > growth check and work scheduling after releasing the rth lock, we break
> > this potential deadlock chain.
> > 
> > This change expands the flexibility of rhashtable by removing
> > restrictive locking that previously limited its use in scheduler
> > and workqueue contexts.
> 
> Could you please explain the deadlock?

I understand that there is a locking order inversion here:

A possible code flow can hold the rhashtable_bucket, and then can get
the dqs->lock, as shown int eh following snippet:

         Chain exists of:
           rhashtable_bucket --> &rq->__lock --> &dsq->lock

The same is true, when sched_ext holds rthe dsq->lock and try to get
hold of rhashtable lock.

This could be seen in the following snippers:

                rht_lock+0x69/0xd0
                destroy_dsq+0x22d/0x790
                scx_ops_disable_workfn+0x9d2/0xaf0

> Is the workqueue system actually using rhashtable?

It seems so when using sched_ext scheduler class. For instance, lockdep
got it in scx_ops_disable_workfn().

                rht_lock+0x69/0xd0
                destroy_dsq+0x22d/0x790
                scx_ops_disable_workfn+0x9d2/0xaf0
                kthread_worker_fn+0x137/0x350


This is the full lockdep splat, if it helps. Sorry it is not decoded,
but this can give you the code-flow.

	 ======================================================
	 WARNING: possible circular locking dependency detected

	 hardirqs last  enabled at (2088145): [<ffffffff822ab674>] _raw_spin_unlock_irq+0x24/0x50
	 hardirqs last disabled at (2088144): [<ffffffff822ab4bf>] _raw_spin_lock_irq+0x2f/0x80
	 ------------------------------------------------------
	 softirqs last  enabled at (2088116): [<ffffffff810f7294>] __irq_exit_rcu+0x74/0x100
	 sched_ext_ops_h/10451 is trying to acquire lock:
	 softirqs last disabled at (2088111): [<ffffffff810f7294>] __irq_exit_rcu+0x74/0x100
	 ffff888288059038 (rhashtable_bucket){....}-{0:0}, at: rht_lock+0x51/0xd0

	 but task is already holding lock:
	 ffff888470645698 (&dsq->lock){-.-.}-{2:2}, at: destroy_dsq+0xaf/0x790

	 which lock already depends on the new lock.


	 the existing dependency chain (in reverse order) is:

	 -> #4 (&dsq->lock){-.-.}-{2:2}:
		_raw_spin_lock+0x2f/0x40
		dispatch_enqueue+0x7c/0x3e0
		enqueue_task_scx.llvm.3416789782249720787+0x1ae/0x250
		sched_enq_and_set_task+0x5f/0xb0
		bpf_scx_reg+0xf21/0x11b0
		bpf_struct_ops_link_create+0xec/0x160
		__sys_bpf+0x34d/0x3b0
		__x64_sys_bpf+0x18/0x20
		do_syscall_64+0x7e/0x150
		entry_SYSCALL_64_after_hwframe+0x4b/0x53

	 -> #3 (&rq->__lock){-.-.}-{2:2}:
		_raw_spin_lock_nested+0x32/0x40
		raw_spin_rq_lock_nested+0x20/0x30
		task_fork_fair.llvm.5382994275699419189+0x3b/0x110
		sched_cgroup_fork+0xe3/0x100
		copy_process+0xc3c/0x14a0
		kernel_clone+0x90/0x360
		user_mode_thread+0xbc/0xe0
		rest_init+0x1f/0x1f0
		start_kernel+0x41b/0x470
		x86_64_start_reservations+0x26/0x30
		x86_64_start_kernel+0x9b/0xa0
		common_startup_64+0x13e/0x140

	 -> #2 (&p->pi_lock){-.-.}-{2:2}:
		_raw_spin_lock_irqsave+0x5a/0x90
		try_to_wake_up+0x58/0x730
		create_worker+0x1d6/0x240

		workqueue_init+0x2c0/0x390
		kernel_init_freeable+0x147/0x200
		kernel_init+0x16/0x1c0
		ret_from_fork+0x2f/0x40
		ret_from_fork_asm+0x11/0x20

	 -> #1 (&pool->lock){-.-.}-{2:2}:
		_raw_spin_lock+0x2f/0x40
		__queue_work+0x24b/0x610
		queue_work_on+0xa5/0xf0
		rhashtable_insert_slow+0x524/0x970
		__xdp_reg_mem_model+0x181/0x240
		xdp_rxq_info_reg_mem_model+0x19/0xf0
		bnxt_alloc_mem+0x1178/0x1c80
		__bnxt_open_nic+0x1bb/0xe20
		bnxt_open_nic+0x26/0x60
		ethtool_set_channels+0x1b7/0x1f0
		dev_ethtool+0x555/0x740
		dev_ioctl+0x2ac/0x3f0
		sock_do_ioctl+0x111/0x180
		sock_ioctl+0x1fb/0x2e0
		__se_sys_ioctl+0x72/0xc0
		do_syscall_64+0x7e/0x150
		entry_SYSCALL_64_after_hwframe+0x4b/0x53

	 -> #0 (rhashtable_bucket){....}-{0:0}:
		__lock_acquire+0x1742/0x3470
		lock_acquire+0xf0/0x290
		rht_lock+0x69/0xd0
		destroy_dsq+0x22d/0x790
		scx_ops_disable_workfn+0x9d2/0xaf0
		kthread_worker_fn+0x137/0x350
		kthread+0x102/0x120
		ret_from_fork+0x2f/0x40
		ret_from_fork_asm+0x11/0x20

	 other info that might help us debug this:

	 Chain exists of:
	   rhashtable_bucket --> &rq->__lock --> &dsq->lock

	  Possible unsafe locking scenario:

		CPU0                    CPU1
		----                    ----
	   lock(&dsq->lock);
					lock(&rq->__lock);
					lock(&dsq->lock);
	   lock(rhashtable_bucket);

	  *** DEADLOCK ***

	 5 locks held by sched_ext_ops_h/10451:
	  #0: ffffffff83695ad0 (scx_ops_enable_mutex){+.+.}-{3:3}, at: scx_ops_disable_workfn+0x111/0xaf0
	  #1: ffffffff83da13d8 (rcu_read_lock){....}-{1:2}, at: rhashtable_walk_start_check+0x1f/0x3e0
	  #2: ffffffff83da13d8 (rcu_read_lock){....}-{1:2}, at: destroy_dsq+0x30/0x790
	  #3: ffff888470645698 (&dsq->lock){-.-.}-{2:2}, at: destroy_dsq+0xaf/0x790
	  #4: ffffffff83da13d8 (rcu_read_lock){....}-{1:2}, at: destroy_dsq+0x30/0x790

