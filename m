Return-Path: <netdev+bounces-85843-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2947E89C88F
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 17:41:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 966C91F22AA8
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 15:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F59E1411DC;
	Mon,  8 Apr 2024 15:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qjypb048"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A87C140397
	for <netdev@vger.kernel.org>; Mon,  8 Apr 2024 15:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712590890; cv=none; b=qzq4Ruf9xyz/qNaj8yy6C4eElGuAXkQ6I3AdiGh9VUVMIRpkra4WGOT+zF5zKRJPpRkjRu1SrA6oGC5/5387EwaAoKfNSAhDJEWV7oYz8AEhh2qwnUY3pPQEVuGB7RNocZon3lexRFIYV9TDMicpGeg7DESXWZgzeTHjy32O3Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712590890; c=relaxed/simple;
	bh=D3PbVJvm979q3w4tHYroApm4q4tNgSz8oq/V9TMJkbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ou/7+9RJjIMNdUh71NQEqvjEItt9WzWIEnC4MHvdNvzK4aVvVMVyHFisde/0TapSoobTYf+LqBABr2ZoiMq9MZ3I2fy6fVKrL/gpIh3DKJfZaLMK46PLjiUf94eXMQcyHxuBP/y28NeH3MjtsmzDiHcgDvIZBddTRYb7Wkf8JlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qjypb048; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A8AAC433F1;
	Mon,  8 Apr 2024 15:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712590889;
	bh=D3PbVJvm979q3w4tHYroApm4q4tNgSz8oq/V9TMJkbk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qjypb048ZqE+l45tCwluhgdcRE2rZXs0Ewe7KcaevVtHi6ZrW/q+DCfh3KEa/LZ+i
	 HWr6dbL3ZE/WkdLbc4VGjUaspLjKm6YrYHkHDVitRp6rNPDva6TAEQXnLHuD1taXy2
	 VWDvuhFS87knjrJkc7D6BCv/KPCjzHSN3bbTyzkZ8y9w+HQEt4s0PhCezw9X/SzCsn
	 vrewavZ0yRfNzEKKAL1wnhRkrS6LfZuDcoRKCc3bNRFcJEuS63W4sMQQZqWg0wZCRl
	 G9srpVLVy/Usdydnn0z6mIcvL8Dnw5BjAY9XqdqUFBXU+sk8quHxDT3Hu1eNLN/qUk
	 DQmzGSErG8jqQ==
Date: Mon, 8 Apr 2024 16:41:24 +0100
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com,
	Marek Lindner <mareklindner@neomailbox.ch>,
	Simon Wunderlich <sw@simonwunderlich.de>,
	Antonio Quartulli <a@unstable.cc>,
	Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH net-next] batman-adv: bypass empty buckets in
 batadv_purge_orig_ref()
Message-ID: <20240408154124.GJ26556@kernel.org>
References: <20240330155438.2462326-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240330155438.2462326-1-edumazet@google.com>

On Sat, Mar 30, 2024 at 03:54:38PM +0000, Eric Dumazet wrote:
> Many syzbot reports are pointing to soft lockups in
> batadv_purge_orig_ref() [1]
> 
> Root cause is unknown, but we can avoid spending too much
> time there and perhaps get more interesting reports.
> 
> [1]
> 
> watchdog: BUG: soft lockup - CPU#0 stuck for 27s! [kworker/u4:6:621]
> Modules linked in:
> irq event stamp: 6182794
>  hardirqs last  enabled at (6182793): [<ffff8000801dae10>] __local_bh_enable_ip+0x224/0x44c kernel/softirq.c:386
>  hardirqs last disabled at (6182794): [<ffff80008ad66a78>] __el1_irq arch/arm64/kernel/entry-common.c:533 [inline]
>  hardirqs last disabled at (6182794): [<ffff80008ad66a78>] el1_interrupt+0x24/0x68 arch/arm64/kernel/entry-common.c:551
>  softirqs last  enabled at (6182792): [<ffff80008aab71c4>] spin_unlock_bh include/linux/spinlock.h:396 [inline]
>  softirqs last  enabled at (6182792): [<ffff80008aab71c4>] batadv_purge_orig_ref+0x114c/0x1228 net/batman-adv/originator.c:1287
>  softirqs last disabled at (6182790): [<ffff80008aab61dc>] spin_lock_bh include/linux/spinlock.h:356 [inline]
>  softirqs last disabled at (6182790): [<ffff80008aab61dc>] batadv_purge_orig_ref+0x164/0x1228 net/batman-adv/originator.c:1271
> CPU: 0 PID: 621 Comm: kworker/u4:6 Not tainted 6.8.0-rc7-syzkaller-g707081b61156 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
> Workqueue: bat_events batadv_purge_orig
> pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>  pc : should_resched arch/arm64/include/asm/preempt.h:79 [inline]
>  pc : __local_bh_enable_ip+0x228/0x44c kernel/softirq.c:388
>  lr : __local_bh_enable_ip+0x224/0x44c kernel/softirq.c:386
> sp : ffff800099007970
> x29: ffff800099007980 x28: 1fffe00018fce1bd x27: dfff800000000000
> x26: ffff0000d2620008 x25: ffff0000c7e70de8 x24: 0000000000000001
> x23: 1fffe00018e57781 x22: dfff800000000000 x21: ffff80008aab71c4
> x20: ffff0001b40136c0 x19: ffff0000c72bbc08 x18: 1fffe0001a817bb0
> x17: ffff800125414000 x16: ffff80008032116c x15: 0000000000000001
> x14: 1fffe0001ee9d610 x13: 0000000000000000 x12: 0000000000000003
> x11: 0000000000000000 x10: 0000000000ff0100 x9 : 0000000000000000
> x8 : 00000000005e5789 x7 : ffff80008aab61dc x6 : 0000000000000000
> x5 : 0000000000000000 x4 : 0000000000000001 x3 : 0000000000000000
> x2 : 0000000000000006 x1 : 0000000000000080 x0 : ffff800125414000
> Call trace:
>   __daif_local_irq_enable arch/arm64/include/asm/irqflags.h:27 [inline]
>   arch_local_irq_enable arch/arm64/include/asm/irqflags.h:49 [inline]
>   __local_bh_enable_ip+0x228/0x44c kernel/softirq.c:386
>   __raw_spin_unlock_bh include/linux/spinlock_api_smp.h:167 [inline]
>   _raw_spin_unlock_bh+0x3c/0x4c kernel/locking/spinlock.c:210
>   spin_unlock_bh include/linux/spinlock.h:396 [inline]
>   batadv_purge_orig_ref+0x114c/0x1228 net/batman-adv/originator.c:1287
>   batadv_purge_orig+0x20/0x70 net/batman-adv/originator.c:1300
>   process_one_work+0x694/0x1204 kernel/workqueue.c:2633
>   process_scheduled_works kernel/workqueue.c:2706 [inline]
>   worker_thread+0x938/0xef4 kernel/workqueue.c:2787
>   kthread+0x288/0x310 kernel/kthread.c:388
>   ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:860
> Sending NMI from CPU 0 to CPUs 1:
> NMI backtrace for cpu 1
> CPU: 1 PID: 0 Comm: swapper/1 Not tainted 6.8.0-rc7-syzkaller-g707081b61156 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
> pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>  pc : arch_local_irq_enable+0x8/0xc arch/arm64/include/asm/irqflags.h:51
>  lr : default_idle_call+0xf8/0x128 kernel/sched/idle.c:103
> sp : ffff800093a17d30
> x29: ffff800093a17d30 x28: dfff800000000000 x27: 1ffff00012742fb4
> x26: ffff80008ec9d000 x25: 0000000000000000 x24: 0000000000000002
> x23: 1ffff00011d93a74 x22: ffff80008ec9d3a0 x21: 0000000000000000
> x20: ffff0000c19dbc00 x19: ffff8000802d0fd8 x18: 1fffe00036804396
> x17: ffff80008ec9d000 x16: ffff8000802d089c x15: 0000000000000001
> x14: 1fffe00036805f10 x13: 0000000000000000 x12: 0000000000000003
> x11: 0000000000000001 x10: 0000000000000003 x9 : 0000000000000000
> x8 : 00000000000ce8d1 x7 : ffff8000804609e4 x6 : 0000000000000000
> x5 : 0000000000000001 x4 : 0000000000000001 x3 : ffff80008ad6aac0
> x2 : 0000000000000000 x1 : ffff80008aedea60 x0 : ffff800125436000
> Call trace:
>   __daif_local_irq_enable arch/arm64/include/asm/irqflags.h:27 [inline]
>   arch_local_irq_enable+0x8/0xc arch/arm64/include/asm/irqflags.h:49
>   cpuidle_idle_call kernel/sched/idle.c:170 [inline]
>   do_idle+0x1f0/0x4e8 kernel/sched/idle.c:312
>   cpu_startup_entry+0x5c/0x74 kernel/sched/idle.c:410
>   secondary_start_kernel+0x198/0x1c0 arch/arm64/kernel/smp.c:272
>   __secondary_switched+0xb8/0xbc arch/arm64/kernel/head.S:404
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Marek Lindner <mareklindner@neomailbox.ch>
> Cc: Simon Wunderlich <sw@simonwunderlich.de>
> Cc: Antonio Quartulli <a@unstable.cc>
> Cc: Sven Eckelmann <sven@narfation.org>

Reviewed-by: Simon Horman <horms@kernel.org>


