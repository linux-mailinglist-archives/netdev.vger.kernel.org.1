Return-Path: <netdev+bounces-106037-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA7A7914661
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 11:26:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AD6B1C208BE
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 09:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 868EF130A79;
	Mon, 24 Jun 2024 09:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QsOgBa5t"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A443813049E
	for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 09:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719221168; cv=none; b=WRQIzF3g76kItxlyUyfs3j03VX0TXbxlvrBMFI7lJg36SjjMkkPwa7E01JyzBZOhTjh1GM6107nDol25leQBQoqiz8FBsG0Jbb0zSgm3jdXfxQbrJf6MvwrvSbjNS/GAtsQP7iC/9zvMWYdyBobQRJSnLOP6DZD4Yam6hX1lz1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719221168; c=relaxed/simple;
	bh=l9yiSoP/Q6nwOKJEgVyEFVKvXqCvyhx5MJ2HAxV5ERA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=igwW/R+aVpOTMKt62BHjnKf77WiG/sYsddT+8DuYfm/AV/OK+Qrp0eqYlaeFwWrwUS5N4+JsIx+/kpaUfMfnflbJxhPj6DRWfpVia/A2/H1HW3AzdAGYZaDIIBrONhPDbYKd0/iCxEYXVImL5IyR83GwkyfR4rZHI7rNWPxppN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QsOgBa5t; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-4ef59e2c61aso585332e0c.0
        for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 02:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719221165; x=1719825965; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/E0KceMMonfCQ82WDGj/kjzMpkYRvfwxGs9DRrk6WLs=;
        b=QsOgBa5tbAxND4WH7wmi4GSwk/3aq8aT9V3l//ZR8PETbS23IrbkxZiBp0dHKlCh7I
         TwAb4ClYUnoVqC/m1hsTtpqbBAVNCfbQpmcxPJl8WgfxK6tpxz7BY/OIRbXnrtMaCfCx
         ol42Sec3HV0oTs5ujEwSjnv5Xx3ulVEd6G6WP/3b3g4QS6ww+P+/CW6YFcQ9R86O/onv
         lJ7Y3HWtMoCQ44coM1tzQrPslTW5hWIsnJRqeZlhYNs2R0YWLGvCKRqDYth+lU8LGj1t
         VAfv6BU2TZRChclyskk+WnAu+x0aTNkeLqcRTKHTkszuQPASdyci74awzbhiNQnidsJb
         s68g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719221165; x=1719825965;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/E0KceMMonfCQ82WDGj/kjzMpkYRvfwxGs9DRrk6WLs=;
        b=SD4hBt8LRuOUqa/Gp4D5Qko8hoG5kE0CJ2nYD8273z2M1fGjzrCZPWbmclYPq7KDiK
         7RhYUrSgAlVzn03IYaE7hEn1RUddX1Rkgz8ZZA/wDnHcsnssfmxpigOJ24Lp/QcERW+e
         vwqqEk/svsI1AAZEu+qRBgxXr8zk9Je1UqTWtUpWh0qee9SJqV1ZfdMMbqqG8baOwIKh
         qnAWgMts1Gfu+YNRRKeL2mjQznc4iCZKU7rBZr+Eexv+mZtCgDV8V7Akyzfb/74xQDfb
         GBDibACo7lBxgY0051pwjcYTV0s7m1fN3DTQKRN2MDQHazaRDwhtj7NSwrmhF6rIqeFz
         h3aA==
X-Gm-Message-State: AOJu0YzSQ/9P/i7wWx0v1QSXcPpjTiveYsqde5GOC6rAQwb6lzYx0hEk
	H9vSUWhg+bbq0XOYWe0ngHQoRE6e13TdJ8rwae6ZqcFiJD4T8ZdCB74U8bGcuB3a2rK8r2RFfFw
	s8NqeMBVnyUJSNDyok0owL+2EhY1gM7i0
X-Google-Smtp-Source: AGHT+IH/ufmHbrlZybDR80w6hJTvnf9PJ7RRG9AlmAk5KBnPsRdD4Z1bFbMW9Zsw9XtoMxjg8sLiTXju9QVeeD+OMgU=
X-Received: by 2002:a05:6122:20a8:b0:4ef:53ad:97ad with SMTP id
 71dfb90a1353d-4ef6d8096e5mr1691527e0c.6.1719221165286; Mon, 24 Jun 2024
 02:26:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Mon, 24 Jun 2024 10:25:38 +0100
Message-ID: <CA+V-a8s6TmgM4=J-3=zt3ZbNdLtwn5sfBP6FdZVNg09t634P_w@mail.gmail.com>
Subject: STMMAC driver CPU stall warning
To: Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>
Cc: netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Alexandre and Jose,

While integrating the STMMAC driver for the Renesas RZ/V2H SoC I am
seeing the CPU stall warning when the locking config options are
enabled. Has anyone seen this issue?

Platform and Kernel details :
-------------------------------------
- Renesas RZ/V2H(P) EVK (ARM64)
- 6.10.0-rc5
- IP version, Synopsys ID: 0x52

With the below locking configs enabled:
----------------------------------------------------
# CONFIG_PER_VMA_LOCK_STATS is not set
# CONFIG_SOFTLOCKUP_DETECTOR is not set
CONFIG_HAVE_HARDLOCKUP_DETECTOR_BUDDY=y
# CONFIG_HARDLOCKUP_DETECTOR is not set
CONFIG_LOCK_DEBUGGING_SUPPORT=y
CONFIG_PROVE_LOCKING=y
# CONFIG_PROVE_RAW_LOCK_NESTING is not set
# CONFIG_LOCK_STAT is not set
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_LOCK_ALLOC=y
CONFIG_LOCKDEP=y
CONFIG_LOCKDEP_BITS=15
CONFIG_LOCKDEP_CHAINS_BITS=16
CONFIG_LOCKDEP_STACK_TRACE_BITS=19
CONFIG_LOCKDEP_STACK_TRACE_HASH_BITS=14
CONFIG_LOCKDEP_CIRCULAR_QUEUE_BITS=12
# CONFIG_DEBUG_LOCKDEP is not set
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
# CONFIG_LOCK_TORTURE_TEST is not set
# CONFIG_CSD_LOCK_WAIT_DEBUG is not set
CONFIG_TRACE_CLOCK=y

[   33.701954] rcu: INFO: rcu_preempt self-detected stall on CPU
[   33.707776] rcu:     0-....: (1 GPs behind)
idle=7054/1/0x4000000000000000 softirq=413/414 fqs=2228
[   33.716693] rcu:     (t=6500 jiffies g=-691 q=65 ncpus=4)
[   33.721856] CPU: 0 PID: 37 Comm: kworker/u16:1 Not tainted
6.10.0-rc5-arm64-renesas-00383-g34de6e9c5801 #495
[   33.731717] Hardware name: Renesas based on r9a09g057h44 (DT)
[   33.737833] Workqueue: rpciod rpc_async_schedule
[   33.742488] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   33.749474] pc : _raw_spin_unlock_irqrestore+0x34/0x68
[   33.754640] lr : _raw_spin_unlock_irqrestore+0x64/0x68
[   33.759800] sp : ffff8000828133b0
[   33.763128] x29: ffff8000828133b0 x28: 0000000000000080 x27: 0000000000000000
[   33.770304] x26: ffff8000818faa00 x25: ffff0003ee18b200 x24: 0000000000000001
[   33.777478] x23: ffff0003ee18b180 x22: ffff0003ee18b180 x21: ffff0003ee18b180
[   33.784653] x20: ffff0003ee18b180 x19: 0000000000000000 x18: 00000000000020e8
[   33.791827] x17: 344617ab1e4d0a08 x16: 0101000003d71d0f x15: 0000000000000028
[   33.799002] x14: 000000000000000a x13: 0000000000004d7c x12: 0000000000000000
[   33.806176] x11: ffff800082540a7c x10: ffff8000814e3cd4 x9 : 0000000000000168
[   33.813351] x8 : 0000000000000001 x7 : 00000000000000c8 x6 : ffff8000821e6000
[   33.820524] x5 : 0000000000000000 x4 : 0000000000000009 x3 : 0000000000000000
[   33.827698] x2 : 0000000000000001 x1 : ffff8000814e3cd0 x0 : 0000000000009384
[   33.834872] Call trace:
[   33.837331]  _raw_spin_unlock_irqrestore+0x34/0x68
[   33.842145]  hrtimer_start_range_ns+0x138/0x314
[   33.846700]  stmmac_tx_timer_arm+0x88/0x8c
[   33.850819]  stmmac_xmit+0x778/0xac4
[   33.854413]  dev_hard_start_xmit+0xcc/0x2d0
[   33.858618]  sch_direct_xmit+0x88/0x378
[   33.862477]  __dev_queue_xmit+0x784/0xfc0
[   33.866506]  ip_finish_output2+0x794/0xac8
[   33.870627]  __ip_finish_output+0x110/0x27c
[   33.874831]  ip_output+0x6c/0x278
[   33.878165]  __ip_queue_xmit+0x194/0x5a0
[   33.882106]  ip_queue_xmit+0x10/0x18
[   33.885698]  __tcp_transmit_skb+0x4a8/0xba4
[   33.889903]  __tcp_send_ack.part.0+0xc8/0x144
[   33.894280]  tcp_release_cb+0x1ec/0x208
[   33.898133]  release_sock+0x48/0x9c
[   33.901642]  tcp_sendmsg+0x44/0x58
[   33.905063]  inet_sendmsg+0x40/0x64
[   33.908575]  sock_sendmsg+0x7c/0xe0
[   33.912085]  xprt_sock_sendmsg+0xdc/0x300
[   33.916115]  xs_tcp_send_request+0xec/0x240
[   33.920318]  xprt_transmit+0x1e4/0x5e8
[   33.924084]  call_transmit+0x7c/0x90
[   33.927680]  __rpc_execute+0xdc/0x6f8
[   33.931361]  rpc_async_schedule+0x28/0x40
[   33.935390]  process_one_work+0x21c/0x620
[   33.939422]  worker_thread+0x1a8/0x374
[   33.943190]  kthread+0x10c/0x110
[   33.946436]  ret_from_fork+0x10/0x20
[   33.950033] Sending NMI from CPU 0 to CPUs 3:
[   33.954415] NMI backtrace for cpu 3
[   33.957929] CPU: 3 PID: 67 Comm: kworker/u16:6 Not tainted
6.10.0-rc5-arm64-renesas-00383-g34de6e9c5801 #495
[   33.967788] Hardware name: Renesas based on r9a09g057h44 (DT)
[   33.973902] Workqueue: xprtiod xs_stream_data_receive_workfn
[   33.979591] pstate: 00400005 (nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   33.986576] pc : queued_spin_lock_slowpath+0x68/0x514
[   33.991650] lr : do_raw_spin_lock+0xb8/0x104
[   33.995941] sp : ffff800082fcba70
[   33.999268] x29: ffff800082fcba70 x28: 0000000000000000 x27: 0000000000000000
[   34.006441] x26: ffff0000c2966840 x25: 0000000000000000 x24: ffff800081863000
[   34.013614] x23: ffff0000c0578000 x22: 000000000000000c x21: 0000000000000040
[   34.020786] x20: ffff8000814e1008 x19: ffff0000c29f0190 x18: 0000000000093930
[   34.027958] x17: 0019001a00400009 x16: 0038004000000000 x15: 0000000000000000
[   34.035130] x14: 0000000000000001 x13: ffff0000c2a20080 x12: 0000000000000000
[   34.042302] x11: ffff800082540a7c x10: ffff8000814e3cd4 x9 : 00000000000000a0
[   34.049473] x8 : 0000000000000001 x7 : 00000000000000c8 x6 : ffff8000821e6000
[   34.056645] x5 : f647258a66f2c9bc x4 : ffff8000821ad9e0 x3 : 0000000000000000
[   34.063815] x2 : ffff80036cd00000 x1 : 0000000000000000 x0 : 0000000000000001
[   34.070987] Call trace:
[   34.073444]  queued_spin_lock_slowpath+0x68/0x514
[   34.078169]  do_raw_spin_lock+0xb8/0x104
[   34.082110]  _raw_spin_lock_bh+0x54/0x60
[   34.086051]  lock_sock_nested+0x3c/0x84
[   34.089905]  tcp_recvmsg+0x5c/0x1c0
[   34.093412]  inet_recvmsg+0x60/0x244
[   34.097007]  sock_recvmsg+0x2c/0x6c
[   34.100515]  xs_read_stream.constprop.0+0xb0/0x4e0
[   34.105327]  xs_stream_data_receive_workfn+0x54/0x1b4
[   34.110398]  process_one_work+0x21c/0x620
[   34.114427]  worker_thread+0x1a8/0x374
[   34.118194]  kthread+0x10c/0x110
[   34.121438]  ret_from_fork+0x10/0x20
[   68.470538] random: crng init done

Below is the dmesg logs for gbeth:
----------------------------------------------
[    1.611307] renesas-gbeth 15c30000.ethernet: IRQ sfty not found
[    1.626475] renesas-gbeth 15c30000.ethernet: User ID: 0x1, Synopsys ID: 0x52
[    1.633615] renesas-gbeth 15c30000.ethernet:         DWMAC4/5
[    1.638809] renesas-gbeth 15c30000.ethernet: DMA HW capability
register supported
[    1.646351] renesas-gbeth 15c30000.ethernet: RX Checksum Offload
Engine supported
[    1.653904] renesas-gbeth 15c30000.ethernet: Wake-Up On Lan supported
[    1.660516] renesas-gbeth 15c30000.ethernet: Enable RX Mitigation
via HW Watchdog Timer
[    1.668584] renesas-gbeth 15c30000.ethernet: Enabled L3L4 Flow TC (entries=8)
[    1.675782] renesas-gbeth 15c30000.ethernet: Enabled RFS Flow TC (entries=10)
[    1.682979] renesas-gbeth 15c30000.ethernet: Using 32/32 bits DMA
host/device width
[    1.698226] renesas-gbeth 15c40000.ethernet: IRQ sfty not found
[    1.713295] renesas-gbeth 15c40000.ethernet: User ID: 0x0, Synopsys ID: 0x52
[    1.720432] renesas-gbeth 15c40000.ethernet:         DWMAC4/5
[    1.725637] renesas-gbeth 15c40000.ethernet: DMA HW capability
register supported
[    1.733179] renesas-gbeth 15c40000.ethernet: RX Checksum Offload
Engine supported
[    1.740720] renesas-gbeth 15c40000.ethernet: Wake-Up On Lan supported
[    1.747327] renesas-gbeth 15c40000.ethernet: Enable RX Mitigation
via HW Watchdog Timer
[    1.755408] renesas-gbeth 15c40000.ethernet: device MAC address
ba:91:02:27:30:8f
[    1.762977] renesas-gbeth 15c40000.ethernet: Enabled L3L4 Flow TC (entries=8)
[    1.770185] renesas-gbeth 15c40000.ethernet: Enabled RFS Flow TC (entries=10)
[    1.777382] renesas-gbeth 15c40000.ethernet: Using 32/32 bits DMA
host/device width
[    2.240115] renesas-gbeth 15c30000.ethernet eth0: Register
MEM_TYPE_PAGE_POOL RxQ-0
[    2.248621] renesas-gbeth 15c30000.ethernet eth0: Register
MEM_TYPE_PAGE_POOL RxQ-1
[    2.257069] renesas-gbeth 15c30000.ethernet eth0: Register
MEM_TYPE_PAGE_POOL RxQ-2
[    2.265151] renesas-gbeth 15c30000.ethernet eth0: Register
MEM_TYPE_PAGE_POOL RxQ-3
[    2.341611] renesas-gbeth 15c30000.ethernet eth0: PHY [stmmac-0:00]
driver [Microchip KSZ9131 Gigabit PHY] (irq=POLL)
[    2.357928] renesas-gbeth 15c30000.ethernet eth0: No Safety
Features support found
[    2.365581] renesas-gbeth 15c30000.ethernet eth0: IEEE 1588-2008
Advanced Timestamp supported
[    2.375086] renesas-gbeth 15c30000.ethernet eth0: registered PTP clock
[    2.382575] renesas-gbeth 15c30000.ethernet eth0: configuring for
phy/rgmii-id link mode
[    2.400349] renesas-gbeth 15c40000.ethernet eth1: Register
MEM_TYPE_PAGE_POOL RxQ-0
[    2.409133] renesas-gbeth 15c40000.ethernet eth1: Register
MEM_TYPE_PAGE_POOL RxQ-1
[    2.417244] renesas-gbeth 15c40000.ethernet eth1: Register
MEM_TYPE_PAGE_POOL RxQ-2
[    2.425629] renesas-gbeth 15c40000.ethernet eth1: Register
MEM_TYPE_PAGE_POOL RxQ-3
[    2.466041] renesas-gbeth 15c40000.ethernet eth1: PHY [stmmac-1:00]
driver [Microchip KSZ9131 Gigabit PHY] (irq=POLL)
[    2.482310] renesas-gbeth 15c40000.ethernet eth1: No Safety
Features support found
[    2.489977] renesas-gbeth 15c40000.ethernet eth1: IEEE 1588-2008
Advanced Timestamp supported
[    2.499184] renesas-gbeth 15c40000.ethernet eth1: registered PTP clock
[    2.506662] renesas-gbeth 15c40000.ethernet eth1: configuring for
phy/rgmii-id link mode
[    6.498736] renesas-gbeth 15c30000.ethernet eth0: Link is Up -
1Gbps/Full - flow control rx/tx
[   73.941601] renesas-gbeth 15c40000.ethernet eth1: Register
MEM_TYPE_PAGE_POOL RxQ-0
[   73.954665] renesas-gbeth 15c40000.ethernet eth1: Register
MEM_TYPE_PAGE_POOL RxQ-1
[   73.963942] renesas-gbeth 15c40000.ethernet eth1: Register
MEM_TYPE_PAGE_POOL RxQ-2
[   73.976780] renesas-gbeth 15c40000.ethernet eth1: Register
MEM_TYPE_PAGE_POOL RxQ-3
[   74.066033] renesas-gbeth 15c40000.ethernet eth1: PHY [stmmac-1:00]
driver [Microchip KSZ9131 Gigabit PHY] (irq=POLL)
[   74.086068] renesas-gbeth 15c40000.ethernet eth1: No Safety
Features support found
[   74.098223] renesas-gbeth 15c40000.ethernet eth1: IEEE 1588-2008
Advanced Timestamp supported
[   74.102485] renesas-gbeth 15c40000.ethernet eth1: registered PTP clock
[   74.122445] renesas-gbeth 15c40000.ethernet eth1: configuring for
phy/rgmii-id link mode

Please let me know if you need me to try anything or provide more
debug information.

Cheers,
Prabhakar

