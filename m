Return-Path: <netdev+bounces-84070-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 492B489572D
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 16:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31F671C22829
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 14:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E63C12C539;
	Tue,  2 Apr 2024 14:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="I2TDLWiX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAED12BF31
	for <netdev@vger.kernel.org>; Tue,  2 Apr 2024 14:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712068788; cv=none; b=d+pglnL74DbktJ9Q432ewP5bU7XBSOiQiqcCm4nBUXOh8yUzUUDq7F1RdiPkjP4fU5+tCx2tYy8VsHFn1TxElYZwDOlZy7aFOn7x4S11Jo5z/6fasEjH8JnynHarDkFzoLpsxnq8X7dKyIa1QvjCo06KP4R4vNq+ND8hE4CFVdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712068788; c=relaxed/simple;
	bh=DVBbP8D58BN+4NppbKP+CQbEIpch/dbZF/ayNq59vV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r+7jvy5n9qR2AWzN4LLuKf2M1sM8P4zEBWp/8QMWAQYR6ddEvKMuiQJBVt2lDQy21Q5VkvO9kUrnsZNanWVXuwy7GztcUqiXuzURDywENMqTYTRh1zfxamJBrIAEZIgtGq6MxN+RJmjomXhbOFuySDmDTXwrFD85t9MDrhtJ3f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=I2TDLWiX; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4161ea9bfd8so2029025e9.1
        for <netdev@vger.kernel.org>; Tue, 02 Apr 2024 07:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1712068785; x=1712673585; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z5s8sWjNpa8q7qXUfd2dtqRQ2xjj4kS/742z5+T/Gow=;
        b=I2TDLWiXDREIXwOqRoB4ZxxkGdEgB6yvEKHYa3IhcixrshJW4WHV5u1wTzXAah8Llq
         lxBkTXcKRuCfrhSvj0yauwfX/Nv6CFivn6SZnpYtdTRkMolnORR+LaT6bt/FN5nPFXEj
         /CbwJhdukR4+wT5BFHN33N+4B1gnqK75LTSj8p9dWqCzV8OkvZiZs5Q0bUyiFzalgkWx
         jjGhTQlDXEkAlXsGLy9p4ZGg5snoP8ZFI07/LIJAJcimwVnjOYwpG2ybEHXDyEK3DZaU
         yXhTMDewtOnlhHRZyUWsrshg3EzNamNpnFED2VBXr2sPkeufmADybuTleY5mEFVURJEc
         Uanw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712068785; x=1712673585;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z5s8sWjNpa8q7qXUfd2dtqRQ2xjj4kS/742z5+T/Gow=;
        b=dIGx1nVroNQ3ck+ev+DRIamDTIfKv6U/HgA8Zzs2TKLO0pLyjO4e66OTZmDZB72GSd
         ScW+G8I87d1zUn7tY5i+Ogt60zFcaYLFJ1UfYvxNaA9tEW0B7JOWNgjA6HMW0ntcOZPQ
         3j0GHLaxHuDV2zgM+o3dYcxzmNoY8EurJrkTbjIKQ1mDErIzZPZTTaVFTc7tkcit+D6H
         JekbGh0sOcZN3IyDyxaf48fc47qt7g9gqbcpYOgIY7q1v0YZs0wKa9m8Uc3hvuZSKqzs
         XTj+CUHeyxwdor5b1jrreGn9j/mhXULwc55GYisRK8XnuJsy4yCIaA1e62+SghSBnrP8
         3agg==
X-Forwarded-Encrypted: i=1; AJvYcCWnW1lwpst2ojUVBEamVfVDUqsyAF1J7fWSuha2G0egwQmoHudccbM1GDUNML2mAP+WxHY+f7rFa736ifCckmUg2BYmvE5Y
X-Gm-Message-State: AOJu0Yz0bxEVRNzfV2YsOzwTb4BjS5CXt/mugi08Ji92XPCW7dBBV1qh
	3cylaz6lHjDZCt6km+PzOFPGmJcoX9m+reI0ukdMiav4ZHAgtSEOIQ0uOUa+ti4=
X-Google-Smtp-Source: AGHT+IE3ByQU0tJIe2fRuwIzCsykyuE2fupaehTS5kDL38vNlJzHwqg4Btu1/Yc4tw7xQBz7txUEfA==
X-Received: by 2002:a7b:c851:0:b0:413:ef97:45e5 with SMTP id c17-20020a7bc851000000b00413ef9745e5mr10096wml.21.1712068784474;
        Tue, 02 Apr 2024 07:39:44 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id hg8-20020a05600c538800b0041565d750e1sm6640466wmb.2.2024.04.02.07.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 07:39:43 -0700 (PDT)
Date: Tue, 2 Apr 2024 16:39:41 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com, syzbot <syzkaller@googlegroups.com>
Subject: Re: [PATCH net] net/sched: fix lockdep splat in
 qdisc_tree_reduce_backlog()
Message-ID: <ZgwYrRv3IIcN00u9@nanopsycho>
References: <20240402134133.2352776-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402134133.2352776-1-edumazet@google.com>

Tue, Apr 02, 2024 at 03:41:33PM CEST, edumazet@google.com wrote:
>qdisc_tree_reduce_backlog() is called with the qdisc lock held,
>not RTNL.
>
>We must use qdisc_lookup_rcu() instead of qdisc_lookup()
>
>syzbot reported:
>
>WARNING: suspicious RCU usage
>6.1.74-syzkaller #0 Not tainted
>-----------------------------
>net/sched/sch_api.c:305 suspicious rcu_dereference_protected() usage!
>
>other info that might help us debug this:
>
>rcu_scheduler_active = 2, debug_locks = 1
>3 locks held by udevd/1142:
>  #0: ffffffff87c729a0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:306 [inline]
>  #0: ffffffff87c729a0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:747 [inline]
>  #0: ffffffff87c729a0 (rcu_read_lock){....}-{1:2}, at: net_tx_action+0x64a/0x970 net/core/dev.c:5282
>  #1: ffff888171861108 (&sch->q.lock){+.-.}-{2:2}, at: spin_lock include/linux/spinlock.h:350 [inline]
>  #1: ffff888171861108 (&sch->q.lock){+.-.}-{2:2}, at: net_tx_action+0x754/0x970 net/core/dev.c:5297
>  #2: ffffffff87c729a0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:306 [inline]
>  #2: ffffffff87c729a0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:747 [inline]
>  #2: ffffffff87c729a0 (rcu_read_lock){....}-{1:2}, at: qdisc_tree_reduce_backlog+0x84/0x580 net/sched/sch_api.c:792
>
>stack backtrace:
>CPU: 1 PID: 1142 Comm: udevd Not tainted 6.1.74-syzkaller #0
>Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
>Call Trace:
> <TASK>
>  [<ffffffff85b85f14>] __dump_stack lib/dump_stack.c:88 [inline]
>  [<ffffffff85b85f14>] dump_stack_lvl+0x1b1/0x28f lib/dump_stack.c:106
>  [<ffffffff85b86007>] dump_stack+0x15/0x1e lib/dump_stack.c:113
>  [<ffffffff81802299>] lockdep_rcu_suspicious+0x1b9/0x260 kernel/locking/lockdep.c:6592
>  [<ffffffff84f0054c>] qdisc_lookup+0xac/0x6f0 net/sched/sch_api.c:305
>  [<ffffffff84f037c3>] qdisc_tree_reduce_backlog+0x243/0x580 net/sched/sch_api.c:811
>  [<ffffffff84f5b78c>] pfifo_tail_enqueue+0x32c/0x4b0 net/sched/sch_fifo.c:51
>  [<ffffffff84fbcf63>] qdisc_enqueue include/net/sch_generic.h:833 [inline]
>  [<ffffffff84fbcf63>] netem_dequeue+0xeb3/0x15d0 net/sched/sch_netem.c:723
>  [<ffffffff84eecab9>] dequeue_skb net/sched/sch_generic.c:292 [inline]
>  [<ffffffff84eecab9>] qdisc_restart net/sched/sch_generic.c:397 [inline]
>  [<ffffffff84eecab9>] __qdisc_run+0x249/0x1e60 net/sched/sch_generic.c:415
>  [<ffffffff84d7aa96>] qdisc_run+0xd6/0x260 include/net/pkt_sched.h:125
>  [<ffffffff84d85d29>] net_tx_action+0x7c9/0x970 net/core/dev.c:5313
>  [<ffffffff85e002bd>] __do_softirq+0x2bd/0x9bd kernel/softirq.c:616
>  [<ffffffff81568bca>] invoke_softirq kernel/softirq.c:447 [inline]
>  [<ffffffff81568bca>] __irq_exit_rcu+0xca/0x230 kernel/softirq.c:700
>  [<ffffffff81568ae9>] irq_exit_rcu+0x9/0x20 kernel/softirq.c:712
>  [<ffffffff85b89f52>] sysvec_apic_timer_interrupt+0x42/0x90 arch/x86/kernel/apic/apic.c:1107
>  [<ffffffff85c00ccb>] asm_sysvec_apic_timer_interrupt+0x1b/0x20 arch/x86/include/asm/idtentry.h:656
>
>Fixes: d636fc5dd692 ("net: sched: add rcu annotations around qdisc->qdisc_sleeping")
>Reported-by: syzbot <syzkaller@googlegroups.com>
>Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

