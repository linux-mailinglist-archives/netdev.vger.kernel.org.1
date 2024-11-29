Return-Path: <netdev+bounces-147828-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB899DC25E
	for <lists+netdev@lfdr.de>; Fri, 29 Nov 2024 11:47:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91716282221
	for <lists+netdev@lfdr.de>; Fri, 29 Nov 2024 10:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F01D15AD9C;
	Fri, 29 Nov 2024 10:47:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6AD9463;
	Fri, 29 Nov 2024 10:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732877238; cv=none; b=W3JU+Xp16nR8hgMD70Y9us9K8xPU/HAP05CH/ZJ4/HGnTkIURRht9kMxiQDjXm70Cm/RLSOBzv6Vve3xAmHac5FCzkcLFLP506jH4ZJwmL/QA3JcrAyq/STj8g/iRmg7IQ7xIU55zlfknzKQZ7P0Jp71U71Q7c4JxJAx7/LtUFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732877238; c=relaxed/simple;
	bh=4WMeVmyZh/xaTk4c9lk/9N3vb2+jYhNFxwugKhmez4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=up80KH4jmYclHuS9xor5KV7SbOWl3eT/+TeOxRsFovNFJ/Df4+hueNsYHkQGBoRLaKRyGdjsZ6NvyhXfjgHy8M5+0so40cW4UCE6zbZOaeDf7ZkFXF6pJJjA3Eb5cvg07sC16E26S4YLPF4gVmjIvnOh4aJrnsriyV4pp8MdzaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1tGyWl-0008M7-Q5; Fri, 29 Nov 2024 11:47:11 +0100
Date: Fri, 29 Nov 2024 11:47:11 +0100
From: Florian Westphal <fw@strlen.de>
To: syzbot <syzbot+b26935466701e56cfdc2@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	peterz@infradead.org, syzkaller-bugs@googlegroups.com,
	tglx@linutronix.de
Subject: Re: [syzbot] [kernel?] BUG: sleeping function called from invalid
 context in static_key_slow_dec
Message-ID: <20241129104711.GA32039@breakpoint.cc>
References: <67478d92.050a0220.253251.0062.GAE@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67478d92.050a0220.253251.0062.GAE@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

syzbot <syzbot+b26935466701e56cfdc2@syzkaller.appspotmail.com> wrote:
> BUG: sleeping function called from invalid context at include/linux/percpu-rwsem.h:49
> in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 16, name: ksoftirqd/0
> preempt_count: 100, expected: 0
> RCU nest depth: 0, expected: 0
> 1 lock held by ksoftirqd/0/16:
>  #0: ffffffff8e937e60 (rcu_callback){....}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
>  #0: ffffffff8e937e60 (rcu_callback){....}-{0:0}, at: rcu_do_batch kernel/rcu/tree.c:2561 [inline]
>  #0: ffffffff8e937e60 (rcu_callback){....}-{0:0}, at: rcu_core+0xa37/0x17a0 kernel/rcu/tree.c:2823
> Preemption disabled at:
> [<ffffffff81578192>] softirq_handle_begin kernel/softirq.c:395 [inline]
> [<ffffffff81578192>] handle_softirqs+0x122/0x980 kernel/softirq.c:530
> CPU: 0 UID: 0 PID: 16 Comm: ksoftirqd/0 Not tainted 6.12.0-rc6-syzkaller-00203-g5b366eae7193 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/30/2024
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
>  __might_resched+0x5d4/0x780 kernel/sched/core.c:8653
>  percpu_down_read include/linux/percpu-rwsem.h:49 [inline]
>  cpus_read_lock+0x1b/0x150 kernel/cpu.c:490
>  __static_key_slow_dec kernel/jump_label.c:320 [inline]
>  static_key_slow_dec+0x49/0xa0 kernel/jump_label.c:336
>  nf_tables_chain_destroy+0x3c4/0x4f0 net/netfilter/nf_tables_api.c:2160
>  __nft_release_basechain_now net/netfilter/nf_tables_api.c:11442 [inline]
>  nft_release_basechain_rcu+0x3fc/0x550 net/netfilter/nf_tables_api.c:11454

nf_tables_chain_destroy can sleep via the static key.

I suggest to remove the basechain stats, this was a mistake all along.

Alternative is to defer to work queue or see if replacing the static key
with a deferred static key, that should place the problematic jump
patching to work queue too.

But I'd rather axe all of the basechain stat stuff.

