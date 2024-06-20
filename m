Return-Path: <netdev+bounces-105301-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C57D8910635
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 15:36:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD9EE1C20D5B
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 13:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B071AD9F5;
	Thu, 20 Jun 2024 13:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p0/Zyzir"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926001E497
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 13:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718890283; cv=none; b=rANCoz5/IkyyZ/GDqHOkagX5LakiBtAtkKAUXFUUVvB+C72MMVzEz8rFSJjZ4rvNqw6nXMIeVmZAQQS/8U/hyt1rbBn57Sg07STp43pLHFh4yj9HdtGPwlsikRp6npYthdc28rcyhVtIomimR3zPM5lbzs6l4vPmciWwtey0Lo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718890283; c=relaxed/simple;
	bh=6VmpnvL0/ohfbDBAX7ntxbzzFiUeWLIwdoJPtDsPfQw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=EBYSXl9/+6kjVdO5IPZaOZZ+xNKFptVYNTud3lcv0VI0d7S26gJFO9QfQOM7T1ioyM338IPflL5jjR3uy3V+4FFNBAhdT6XWZXKUOmbu2SWB096TxCq052xxcCtCyTw3Fyr9Y21luIyVthC3cZzPzDA86YlZyfON+Jcluv62DbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p0/Zyzir; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-63bca8ce79eso16442607b3.1
        for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 06:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718890280; x=1719495080; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BF6mfPQgMF5skiqBu7yX3OE2aqzzYHL7TJmPvnxCx0s=;
        b=p0/ZyzirVsHftcX3s2q/ExtR12GAGLoh9vaWR0gHIXkj90OkBT1AMOSvSY9BarPbRG
         kVddt1sxCG9aFNRMVJBcY9EO06BpUUyTj1Awb0yqnAfOpWYIuWBv5qJTO6XD0Bty32LV
         cspFnPGC9cGHFPKWs4PxKVg+cv0QLZsQByTr0FZWLP0WjqHAdF7GfgWjazLbbQv/bVvJ
         U7SEx0cR0TG/HrKQeOxi9aVAcqUmiaGwnhOJTwPD2EbW33b7ax4ELvNgX7lofX6bzNzU
         h5D6PMH77wjfdREO4FtlVPMcplHaXtxUs3eUtHVMkivMajklvJPQSjxUNWesqoxra/Oh
         koFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718890280; x=1719495080;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BF6mfPQgMF5skiqBu7yX3OE2aqzzYHL7TJmPvnxCx0s=;
        b=sNgtHdxbsKcuER5wOqTI3sQCBfxkxsyMCC4yK0BOEdrudEHnRCDSZaK3QDdAnnT7Rv
         0lnzqlZvelfVflM65jlYU70+TO8LQukZ5EH4gNLNaypMFxepIrFWLoxXinB4KzDi8Klb
         G128T8qfpfVbvVZ+f0nQ7sfJOxpE9428+w7SGJ/hpV8K+kpnZ6mnzp9CLfI4IX3Hdh3q
         YnKJT+q60wYnNg+bLXDEMNtbiYqoziLF7AR16Dc0Bk/N0+A+HGxrZFyPjg6dor/v1t2H
         nYQDC4A6RXjUJgQduoyjZPKPJ2bzXheotnHmFoJtL/IrsyTG8CUrQMCDmJp3ynRBMFsP
         pcwA==
X-Gm-Message-State: AOJu0YxG/tMp8u5WHV6Ejw5FkpRx+Cbc6WgqXQIy6YE8dhqcXGtr2EBO
	m+xWruTVDcRWEpXRu0UAnneVCc1coEEXpj3efDrhqEXlDf61YxCvvtzRUUUmjh1i6jDVfyU+f5Q
	WS32xljZbrw==
X-Google-Smtp-Source: AGHT+IGkTMENeYph+gj9eUAlcT1dsWCX3EKKAYYuuJvVZsqqrpF4wj5HRzS4GYR+jtnjrAekMWDlGKN2CISZsw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:690c:46c1:b0:622:d03f:ebf with SMTP
 id 00721157ae682-63a8dc07489mr12132547b3.3.1718890280595; Thu, 20 Jun 2024
 06:31:20 -0700 (PDT)
Date: Thu, 20 Jun 2024 13:31:19 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.627.g7a2c4fd464-goog
Message-ID: <20240620133119.1135480-1-edumazet@google.com>
Subject: [PATCH net] net: add softirq safety to netdev_rename_lock
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot <syzkaller@googlegroups.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>
Content-Type: text/plain; charset="UTF-8"

syzbot reported a lockdep violation involving bridge driver [1]

Make sure netdev_rename_lock is softirq safe to fix this issue.

[1]
WARNING: SOFTIRQ-safe -> SOFTIRQ-unsafe lock order detected
6.10.0-rc2-syzkaller-00249-gbe27b8965297 #0 Not tainted
   -----------------------------------------------------
syz-executor.2/9449 [HC0[0]:SC0[2]:HE0:SE0] is trying to acquire:
 ffffffff8f5de668 (netdev_rename_lock.seqcount){+.+.}-{0:0}, at: rtnl_fill_ifinfo+0x38e/0x2270 net/core/rtnetlink.c:1839

and this task is already holding:
 ffff888060c64cb8 (&br->lock){+.-.}-{2:2}, at: spin_lock_bh include/linux/spinlock.h:356 [inline]
 ffff888060c64cb8 (&br->lock){+.-.}-{2:2}, at: br_port_slave_changelink+0x3d/0x150 net/bridge/br_netlink.c:1212
which would create a new lock dependency:
 (&br->lock){+.-.}-{2:2} -> (netdev_rename_lock.seqcount){+.+.}-{0:0}

but this new dependency connects a SOFTIRQ-irq-safe lock:
 (&br->lock){+.-.}-{2:2}

... which became SOFTIRQ-irq-safe at:
   lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
   __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
   _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
   spin_lock include/linux/spinlock.h:351 [inline]
   br_forward_delay_timer_expired+0x50/0x440 net/bridge/br_stp_timer.c:86
   call_timer_fn+0x18e/0x650 kernel/time/timer.c:1792
   expire_timers kernel/time/timer.c:1843 [inline]
   __run_timers kernel/time/timer.c:2417 [inline]
   __run_timer_base+0x66a/0x8e0 kernel/time/timer.c:2428
   run_timer_base kernel/time/timer.c:2437 [inline]
   run_timer_softirq+0xb7/0x170 kernel/time/timer.c:2447
   handle_softirqs+0x2c4/0x970 kernel/softirq.c:554
   __do_softirq kernel/softirq.c:588 [inline]
   invoke_softirq kernel/softirq.c:428 [inline]
   __irq_exit_rcu+0xf4/0x1c0 kernel/softirq.c:637
   irq_exit_rcu+0x9/0x30 kernel/softirq.c:649
   instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
   sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1043
   asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
   lock_acquire+0x264/0x550 kernel/locking/lockdep.c:5758
   fs_reclaim_acquire+0xaf/0x140 mm/page_alloc.c:3800
   might_alloc include/linux/sched/mm.h:334 [inline]
   slab_pre_alloc_hook mm/slub.c:3890 [inline]
   slab_alloc_node mm/slub.c:3980 [inline]
   kmalloc_trace_noprof+0x3d/0x2c0 mm/slub.c:4147
   kmalloc_noprof include/linux/slab.h:660 [inline]
   kzalloc_noprof include/linux/slab.h:778 [inline]
   class_dir_create_and_add drivers/base/core.c:3255 [inline]
   get_device_parent+0x2a7/0x410 drivers/base/core.c:3315
   device_add+0x325/0xbf0 drivers/base/core.c:3645
   netdev_register_kobject+0x17e/0x320 net/core/net-sysfs.c:2136
   register_netdevice+0x11d5/0x19e0 net/core/dev.c:10375
   nsim_init_netdevsim drivers/net/netdevsim/netdev.c:690 [inline]
   nsim_create+0x647/0x890 drivers/net/netdevsim/netdev.c:750
   __nsim_dev_port_add+0x6c0/0xae0 drivers/net/netdevsim/dev.c:1390
   nsim_dev_port_add_all drivers/net/netdevsim/dev.c:1446 [inline]
   nsim_dev_reload_create drivers/net/netdevsim/dev.c:1498 [inline]
   nsim_dev_reload_up+0x69b/0x8e0 drivers/net/netdevsim/dev.c:985
   devlink_reload+0x478/0x870 net/devlink/dev.c:474
   devlink_nl_reload_doit+0xbd6/0xe50 net/devlink/dev.c:586
   genl_family_rcv_msg_doit net/netlink/genetlink.c:1115 [inline]
   genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
   genl_rcv_msg+0xb14/0xec0 net/netlink/genetlink.c:1210
   netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2564
   genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
   netlink_unicast_kernel net/netlink/af_netlink.c:1335 [inline]
   netlink_unicast+0x7ea/0x980 net/netlink/af_netlink.c:1361
   netlink_sendmsg+0x8db/0xcb0 net/netlink/af_netlink.c:1905
   sock_sendmsg_nosec net/socket.c:730 [inline]
   __sock_sendmsg+0x221/0x270 net/socket.c:745
   ____sys_sendmsg+0x525/0x7d0 net/socket.c:2585
   ___sys_sendmsg net/socket.c:2639 [inline]
   __sys_sendmsg+0x2b0/0x3a0 net/socket.c:2668
   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
  entry_SYSCALL_64_after_hwframe+0x77/0x7f

to a SOFTIRQ-irq-unsafe lock:
 (netdev_rename_lock.seqcount){+.+.}-{0:0}

... which became SOFTIRQ-irq-unsafe at:
...
   lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
   do_write_seqcount_begin_nested include/linux/seqlock.h:469 [inline]
   do_write_seqcount_begin include/linux/seqlock.h:495 [inline]
   write_seqlock include/linux/seqlock.h:823 [inline]
   dev_change_name+0x184/0x920 net/core/dev.c:1229
   do_setlink+0xa4b/0x41f0 net/core/rtnetlink.c:2880
   __rtnl_newlink net/core/rtnetlink.c:3696 [inline]
   rtnl_newlink+0x180b/0x20a0 net/core/rtnetlink.c:3743
   rtnetlink_rcv_msg+0x89b/0x1180 net/core/rtnetlink.c:6635
   netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2564
   netlink_unicast_kernel net/netlink/af_netlink.c:1335 [inline]
   netlink_unicast+0x7ea/0x980 net/netlink/af_netlink.c:1361
   netlink_sendmsg+0x8db/0xcb0 net/netlink/af_netlink.c:1905
   sock_sendmsg_nosec net/socket.c:730 [inline]
   __sock_sendmsg+0x221/0x270 net/socket.c:745
   __sys_sendto+0x3a4/0x4f0 net/socket.c:2192
   __do_sys_sendto net/socket.c:2204 [inline]
   __se_sys_sendto net/socket.c:2200 [inline]
   __x64_sys_sendto+0xde/0x100 net/socket.c:2200
   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
  entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

 Possible interrupt unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(netdev_rename_lock.seqcount);
                               local_irq_disable();
                               lock(&br->lock);
                               lock(netdev_rename_lock.seqcount);
  <Interrupt>
    lock(&br->lock);

 *** DEADLOCK ***

3 locks held by syz-executor.2/9449:
  #0: ffffffff8f5e7448 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
  #0: ffffffff8f5e7448 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x842/0x1180 net/core/rtnetlink.c:6632
  #1: ffff888060c64cb8 (&br->lock){+.-.}-{2:2}, at: spin_lock_bh include/linux/spinlock.h:356 [inline]
  #1: ffff888060c64cb8 (&br->lock){+.-.}-{2:2}, at: br_port_slave_changelink+0x3d/0x150 net/bridge/br_netlink.c:1212
  #2: ffffffff8e333fa0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
  #2: ffffffff8e333fa0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:781 [inline]
  #2: ffffffff8e333fa0 (rcu_read_lock){....}-{1:2}, at: team_change_rx_flags+0x29/0x330 drivers/net/team/team_core.c:1767

the dependencies between SOFTIRQ-irq-safe lock and the holding lock:
-> (&br->lock){+.-.}-{2:2} {
   HARDIRQ-ON-W at:
                     lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
                     __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
                     _raw_spin_lock_bh+0x35/0x50 kernel/locking/spinlock.c:178
                     spin_lock_bh include/linux/spinlock.h:356 [inline]
                     br_add_if+0xb34/0xef0 net/bridge/br_if.c:682
                     do_set_master net/core/rtnetlink.c:2701 [inline]
                     do_setlink+0xe70/0x41f0 net/core/rtnetlink.c:2907
                     __rtnl_newlink net/core/rtnetlink.c:3696 [inline]
                     rtnl_newlink+0x180b/0x20a0 net/core/rtnetlink.c:3743
                     rtnetlink_rcv_msg+0x89b/0x1180 net/core/rtnetlink.c:6635
                     netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2564
                     netlink_unicast_kernel net/netlink/af_netlink.c:1335 [inline]
                     netlink_unicast+0x7ea/0x980 net/netlink/af_netlink.c:1361
                     netlink_sendmsg+0x8db/0xcb0 net/netlink/af_netlink.c:1905
                     sock_sendmsg_nosec net/socket.c:730 [inline]
                     __sock_sendmsg+0x221/0x270 net/socket.c:745
                     __sys_sendto+0x3a4/0x4f0 net/socket.c:2192
                     __do_sys_sendto net/socket.c:2204 [inline]
                     __se_sys_sendto net/socket.c:2200 [inline]
                     __x64_sys_sendto+0xde/0x100 net/socket.c:2200
                     do_syscall_x64 arch/x86/entry/common.c:52 [inline]
                     do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
                    entry_SYSCALL_64_after_hwframe+0x77/0x7f
   IN-SOFTIRQ-W at:
                     lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
                     __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
                     _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
                     spin_lock include/linux/spinlock.h:351 [inline]
                     br_forward_delay_timer_expired+0x50/0x440 net/bridge/br_stp_timer.c:86
                     call_timer_fn+0x18e/0x650 kernel/time/timer.c:1792
                     expire_timers kernel/time/timer.c:1843 [inline]
                     __run_timers kernel/time/timer.c:2417 [inline]
                     __run_timer_base+0x66a/0x8e0 kernel/time/timer.c:2428
                     run_timer_base kernel/time/timer.c:2437 [inline]
                     run_timer_softirq+0xb7/0x170 kernel/time/timer.c:2447
                     handle_softirqs+0x2c4/0x970 kernel/softirq.c:554
                     __do_softirq kernel/softirq.c:588 [inline]
                     invoke_softirq kernel/softirq.c:428 [inline]
                     __irq_exit_rcu+0xf4/0x1c0 kernel/softirq.c:637
                     irq_exit_rcu+0x9/0x30 kernel/softirq.c:649
                     instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
                     sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1043
                     asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
                     lock_acquire+0x264/0x550 kernel/locking/lockdep.c:5758
                     fs_reclaim_acquire+0xaf/0x140 mm/page_alloc.c:3800
                     might_alloc include/linux/sched/mm.h:334 [inline]
                     slab_pre_alloc_hook mm/slub.c:3890 [inline]
                     slab_alloc_node mm/slub.c:3980 [inline]
                     kmalloc_trace_noprof+0x3d/0x2c0 mm/slub.c:4147
                     kmalloc_noprof include/linux/slab.h:660 [inline]
                     kzalloc_noprof include/linux/slab.h:778 [inline]
                     class_dir_create_and_add drivers/base/core.c:3255 [inline]
                     get_device_parent+0x2a7/0x410 drivers/base/core.c:3315
                     device_add+0x325/0xbf0 drivers/base/core.c:3645
                     netdev_register_kobject+0x17e/0x320 net/core/net-sysfs.c:2136
                     register_netdevice+0x11d5/0x19e0 net/core/dev.c:10375
                     nsim_init_netdevsim drivers/net/netdevsim/netdev.c:690 [inline]
                     nsim_create+0x647/0x890 drivers/net/netdevsim/netdev.c:750
                     __nsim_dev_port_add+0x6c0/0xae0 drivers/net/netdevsim/dev.c:1390
                     nsim_dev_port_add_all drivers/net/netdevsim/dev.c:1446 [inline]
                     nsim_dev_reload_create drivers/net/netdevsim/dev.c:1498 [inline]
                     nsim_dev_reload_up+0x69b/0x8e0 drivers/net/netdevsim/dev.c:985
                     devlink_reload+0x478/0x870 net/devlink/dev.c:474
                     devlink_nl_reload_doit+0xbd6/0xe50 net/devlink/dev.c:586
                     genl_family_rcv_msg_doit net/netlink/genetlink.c:1115 [inline]
                     genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
                     genl_rcv_msg+0xb14/0xec0 net/netlink/genetlink.c:1210
                     netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2564
                     genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
                     netlink_unicast_kernel net/netlink/af_netlink.c:1335 [inline]
                     netlink_unicast+0x7ea/0x980 net/netlink/af_netlink.c:1361
                     netlink_sendmsg+0x8db/0xcb0 net/netlink/af_netlink.c:1905
                     sock_sendmsg_nosec net/socket.c:730 [inline]
                     __sock_sendmsg+0x221/0x270 net/socket.c:745
                     ____sys_sendmsg+0x525/0x7d0 net/socket.c:2585
                     ___sys_sendmsg net/socket.c:2639 [inline]
                     __sys_sendmsg+0x2b0/0x3a0 net/socket.c:2668
                     do_syscall_x64 arch/x86/entry/common.c:52 [inline]
                     do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
                    entry_SYSCALL_64_after_hwframe+0x77/0x7f
   INITIAL USE at:
                    lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
                    __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
                    _raw_spin_lock_bh+0x35/0x50 kernel/locking/spinlock.c:178
                    spin_lock_bh include/linux/spinlock.h:356 [inline]
                    br_add_if+0xb34/0xef0 net/bridge/br_if.c:682
                    do_set_master net/core/rtnetlink.c:2701 [inline]
                    do_setlink+0xe70/0x41f0 net/core/rtnetlink.c:2907
                    __rtnl_newlink net/core/rtnetlink.c:3696 [inline]
                    rtnl_newlink+0x180b/0x20a0 net/core/rtnetlink.c:3743
                    rtnetlink_rcv_msg+0x89b/0x1180 net/core/rtnetlink.c:6635
                    netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2564
                    netlink_unicast_kernel net/netlink/af_netlink.c:1335 [inline]
                    netlink_unicast+0x7ea/0x980 net/netlink/af_netlink.c:1361
                    netlink_sendmsg+0x8db/0xcb0 net/netlink/af_netlink.c:1905
                    sock_sendmsg_nosec net/socket.c:730 [inline]
                    __sock_sendmsg+0x221/0x270 net/socket.c:745
                    __sys_sendto+0x3a4/0x4f0 net/socket.c:2192
                    __do_sys_sendto net/socket.c:2204 [inline]
                    __se_sys_sendto net/socket.c:2200 [inline]
                    __x64_sys_sendto+0xde/0x100 net/socket.c:2200
                    do_syscall_x64 arch/x86/entry/common.c:52 [inline]
                    do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
                   entry_SYSCALL_64_after_hwframe+0x77/0x7f
 }
 ... key      at: [<ffffffff94b9a1a0>] br_dev_setup.__key+0x0/0x20

the dependencies between the lock to be acquired
 and SOFTIRQ-irq-unsafe lock:
-> (netdev_rename_lock.seqcount){+.+.}-{0:0} {
   HARDIRQ-ON-W at:
                     lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
                     do_write_seqcount_begin_nested include/linux/seqlock.h:469 [inline]
                     do_write_seqcount_begin include/linux/seqlock.h:495 [inline]
                     write_seqlock include/linux/seqlock.h:823 [inline]
                     dev_change_name+0x184/0x920 net/core/dev.c:1229
                     do_setlink+0xa4b/0x41f0 net/core/rtnetlink.c:2880
                     __rtnl_newlink net/core/rtnetlink.c:3696 [inline]
                     rtnl_newlink+0x180b/0x20a0 net/core/rtnetlink.c:3743
                     rtnetlink_rcv_msg+0x89b/0x1180 net/core/rtnetlink.c:6635
                     netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2564
                     netlink_unicast_kernel net/netlink/af_netlink.c:1335 [inline]
                     netlink_unicast+0x7ea/0x980 net/netlink/af_netlink.c:1361
                     netlink_sendmsg+0x8db/0xcb0 net/netlink/af_netlink.c:1905
                     sock_sendmsg_nosec net/socket.c:730 [inline]
                     __sock_sendmsg+0x221/0x270 net/socket.c:745
                     __sys_sendto+0x3a4/0x4f0 net/socket.c:2192
                     __do_sys_sendto net/socket.c:2204 [inline]
                     __se_sys_sendto net/socket.c:2200 [inline]
                     __x64_sys_sendto+0xde/0x100 net/socket.c:2200
                     do_syscall_x64 arch/x86/entry/common.c:52 [inline]
                     do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
                    entry_SYSCALL_64_after_hwframe+0x77/0x7f
   SOFTIRQ-ON-W at:
                     lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
                     do_write_seqcount_begin_nested include/linux/seqlock.h:469 [inline]
                     do_write_seqcount_begin include/linux/seqlock.h:495 [inline]
                     write_seqlock include/linux/seqlock.h:823 [inline]
                     dev_change_name+0x184/0x920 net/core/dev.c:1229
                     do_setlink+0xa4b/0x41f0 net/core/rtnetlink.c:2880
                     __rtnl_newlink net/core/rtnetlink.c:3696 [inline]
                     rtnl_newlink+0x180b/0x20a0 net/core/rtnetlink.c:3743
                     rtnetlink_rcv_msg+0x89b/0x1180 net/core/rtnetlink.c:6635
                     netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2564
                     netlink_unicast_kernel net/netlink/af_netlink.c:1335 [inline]
                     netlink_unicast+0x7ea/0x980 net/netlink/af_netlink.c:1361
                     netlink_sendmsg+0x8db/0xcb0 net/netlink/af_netlink.c:1905
                     sock_sendmsg_nosec net/socket.c:730 [inline]
                     __sock_sendmsg+0x221/0x270 net/socket.c:745
                     __sys_sendto+0x3a4/0x4f0 net/socket.c:2192
                     __do_sys_sendto net/socket.c:2204 [inline]
                     __se_sys_sendto net/socket.c:2200 [inline]
                     __x64_sys_sendto+0xde/0x100 net/socket.c:2200
                     do_syscall_x64 arch/x86/entry/common.c:52 [inline]
                     do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
                    entry_SYSCALL_64_after_hwframe+0x77/0x7f
   INITIAL USE at:
                    lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
                    do_write_seqcount_begin_nested include/linux/seqlock.h:469 [inline]
                    do_write_seqcount_begin include/linux/seqlock.h:495 [inline]
                    write_seqlock include/linux/seqlock.h:823 [inline]
                    dev_change_name+0x184/0x920 net/core/dev.c:1229
                    do_setlink+0xa4b/0x41f0 net/core/rtnetlink.c:2880
                    __rtnl_newlink net/core/rtnetlink.c:3696 [inline]
                    rtnl_newlink+0x180b/0x20a0 net/core/rtnetlink.c:3743
                    rtnetlink_rcv_msg+0x89b/0x1180 net/core/rtnetlink.c:6635
                    netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2564
                    netlink_unicast_kernel net/netlink/af_netlink.c:1335 [inline]
                    netlink_unicast+0x7ea/0x980 net/netlink/af_netlink.c:1361
                    netlink_sendmsg+0x8db/0xcb0 net/netlink/af_netlink.c:1905
                    sock_sendmsg_nosec net/socket.c:730 [inline]
                    __sock_sendmsg+0x221/0x270 net/socket.c:745
                    __sys_sendto+0x3a4/0x4f0 net/socket.c:2192
                    __do_sys_sendto net/socket.c:2204 [inline]
                    __se_sys_sendto net/socket.c:2200 [inline]
                    __x64_sys_sendto+0xde/0x100 net/socket.c:2200
                    do_syscall_x64 arch/x86/entry/common.c:52 [inline]
                    do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
                   entry_SYSCALL_64_after_hwframe+0x77/0x7f
   INITIAL READ USE at:
                         lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
                         seqcount_lockdep_reader_access include/linux/seqlock.h:72 [inline]
                         read_seqbegin include/linux/seqlock.h:772 [inline]
                         netdev_copy_name+0x168/0x2c0 net/core/dev.c:949
                         rtnl_fill_ifinfo+0x38e/0x2270 net/core/rtnetlink.c:1839
                         rtmsg_ifinfo_build_skb+0x18a/0x260 net/core/rtnetlink.c:4073
                         rtmsg_ifinfo_event net/core/rtnetlink.c:4107 [inline]
                         rtmsg_ifinfo+0x91/0x1b0 net/core/rtnetlink.c:4116
                         register_netdevice+0x1665/0x19e0 net/core/dev.c:10422
                         register_netdev+0x3b/0x50 net/core/dev.c:10512
                         loopback_net_init+0x73/0x150 drivers/net/loopback.c:217
                         ops_init+0x359/0x610 net/core/net_namespace.c:139
                         __register_pernet_operations net/core/net_namespace.c:1247 [inline]
                         register_pernet_operations+0x2cb/0x660 net/core/net_namespace.c:1320
                         register_pernet_device+0x33/0x80 net/core/net_namespace.c:1407
                         net_dev_init+0xfcd/0x10d0 net/core/dev.c:11956
                         do_one_initcall+0x248/0x880 init/main.c:1267
                         do_initcall_level+0x157/0x210 init/main.c:1329
                         do_initcalls+0x3f/0x80 init/main.c:1345
                         kernel_init_freeable+0x435/0x5d0 init/main.c:1578
                         kernel_init+0x1d/0x2b0 init/main.c:1467
                         ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
                         ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 }
 ... key      at: [<ffffffff8f5de668>] netdev_rename_lock+0x8/0xa0
 ... acquired at:
    lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
    seqcount_lockdep_reader_access include/linux/seqlock.h:72 [inline]
    read_seqbegin include/linux/seqlock.h:772 [inline]
    netdev_copy_name+0x168/0x2c0 net/core/dev.c:949
    rtnl_fill_ifinfo+0x38e/0x2270 net/core/rtnetlink.c:1839
    rtmsg_ifinfo_build_skb+0x18a/0x260 net/core/rtnetlink.c:4073
    rtmsg_ifinfo_event net/core/rtnetlink.c:4107 [inline]
    rtmsg_ifinfo+0x91/0x1b0 net/core/rtnetlink.c:4116
    __dev_notify_flags+0xf7/0x400 net/core/dev.c:8816
    __dev_set_promiscuity+0x152/0x5a0 net/core/dev.c:8588
    dev_set_promiscuity+0x51/0xe0 net/core/dev.c:8608
    team_change_rx_flags+0x203/0x330 drivers/net/team/team_core.c:1771
    dev_change_rx_flags net/core/dev.c:8541 [inline]
    __dev_set_promiscuity+0x406/0x5a0 net/core/dev.c:8585
    dev_set_promiscuity+0x51/0xe0 net/core/dev.c:8608
    br_port_clear_promisc net/bridge/br_if.c:135 [inline]
    br_manage_promisc+0x505/0x590 net/bridge/br_if.c:172
    nbp_update_port_count net/bridge/br_if.c:242 [inline]
    br_port_flags_change+0x161/0x1f0 net/bridge/br_if.c:761
    br_setport+0xcb5/0x16d0 net/bridge/br_netlink.c:1000
    br_port_slave_changelink+0x135/0x150 net/bridge/br_netlink.c:1213
    __rtnl_newlink net/core/rtnetlink.c:3689 [inline]
    rtnl_newlink+0x169f/0x20a0 net/core/rtnetlink.c:3743
    rtnetlink_rcv_msg+0x89b/0x1180 net/core/rtnetlink.c:6635
    netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2564
    netlink_unicast_kernel net/netlink/af_netlink.c:1335 [inline]
    netlink_unicast+0x7ea/0x980 net/netlink/af_netlink.c:1361
    netlink_sendmsg+0x8db/0xcb0 net/netlink/af_netlink.c:1905
    sock_sendmsg_nosec net/socket.c:730 [inline]
    __sock_sendmsg+0x221/0x270 net/socket.c:745
    ____sys_sendmsg+0x525/0x7d0 net/socket.c:2585
    ___sys_sendmsg net/socket.c:2639 [inline]
    __sys_sendmsg+0x2b0/0x3a0 net/socket.c:2668
    do_syscall_x64 arch/x86/entry/common.c:52 [inline]
    do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
   entry_SYSCALL_64_after_hwframe+0x77/0x7f

stack backtrace:
CPU: 0 PID: 9449 Comm: syz-executor.2 Not tainted 6.10.0-rc2-syzkaller-00249-gbe27b8965297 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
Call Trace:
 <TASK>
  __dump_stack lib/dump_stack.c:88 [inline]
  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
  print_bad_irq_dependency kernel/locking/lockdep.c:2626 [inline]
  check_irq_usage kernel/locking/lockdep.c:2865 [inline]
  check_prev_add kernel/locking/lockdep.c:3138 [inline]
  check_prevs_add kernel/locking/lockdep.c:3253 [inline]
  validate_chain+0x4de0/0x5900 kernel/locking/lockdep.c:3869
  __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
  lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
  seqcount_lockdep_reader_access include/linux/seqlock.h:72 [inline]
  read_seqbegin include/linux/seqlock.h:772 [inline]
  netdev_copy_name+0x168/0x2c0 net/core/dev.c:949
  rtnl_fill_ifinfo+0x38e/0x2270 net/core/rtnetlink.c:1839
  rtmsg_ifinfo_build_skb+0x18a/0x260 net/core/rtnetlink.c:4073
  rtmsg_ifinfo_event net/core/rtnetlink.c:4107 [inline]
  rtmsg_ifinfo+0x91/0x1b0 net/core/rtnetlink.c:4116
  __dev_notify_flags+0xf7/0x400 net/core/dev.c:8816
  __dev_set_promiscuity+0x152/0x5a0 net/core/dev.c:8588
  dev_set_promiscuity+0x51/0xe0 net/core/dev.c:8608
  team_change_rx_flags+0x203/0x330 drivers/net/team/team_core.c:1771
  dev_change_rx_flags net/core/dev.c:8541 [inline]
  __dev_set_promiscuity+0x406/0x5a0 net/core/dev.c:8585
  dev_set_promiscuity+0x51/0xe0 net/core/dev.c:8608
  br_port_clear_promisc net/bridge/br_if.c:135 [inline]
  br_manage_promisc+0x505/0x590 net/bridge/br_if.c:172
  nbp_update_port_count net/bridge/br_if.c:242 [inline]
  br_port_flags_change+0x161/0x1f0 net/bridge/br_if.c:761
  br_setport+0xcb5/0x16d0 net/bridge/br_netlink.c:1000
  br_port_slave_changelink+0x135/0x150 net/bridge/br_netlink.c:1213
  __rtnl_newlink net/core/rtnetlink.c:3689 [inline]
  rtnl_newlink+0x169f/0x20a0 net/core/rtnetlink.c:3743
  rtnetlink_rcv_msg+0x89b/0x1180 net/core/rtnetlink.c:6635
  netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2564
  netlink_unicast_kernel net/netlink/af_netlink.c:1335 [inline]
  netlink_unicast+0x7ea/0x980 net/netlink/af_netlink.c:1361
  netlink_sendmsg+0x8db/0xcb0 net/netlink/af_netlink.c:1905
  sock_sendmsg_nosec net/socket.c:730 [inline]
  __sock_sendmsg+0x221/0x270 net/socket.c:745
  ____sys_sendmsg+0x525/0x7d0 net/socket.c:2585
  ___sys_sendmsg net/socket.c:2639 [inline]
  __sys_sendmsg+0x2b0/0x3a0 net/socket.c:2668
  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f3b3047cf29
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f3b311740c8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f3b305b4050 RCX: 00007f3b3047cf29
RDX: 0000000000000000 RSI: 0000000020000000 RDI: 0000000000000008
RBP: 00007f3b304ec074 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007f3b305b4050 R15: 00007ffca2f3dc68
 </TASK>

Fixes: 0840556e5a3a ("net: Protect dev->name by seqlock.")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/core/dev.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 4d4de9008f6f3bd4e96b15fda5a2350d9d5efe10..2b4819b610b8a13e2bf355ef8c8b3a59f5e7497c 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1226,9 +1226,9 @@ int dev_change_name(struct net_device *dev, const char *newname)
 
 	memcpy(oldname, dev->name, IFNAMSIZ);
 
-	write_seqlock(&netdev_rename_lock);
+	write_seqlock_bh(&netdev_rename_lock);
 	err = dev_get_valid_name(net, dev, newname);
-	write_sequnlock(&netdev_rename_lock);
+	write_sequnlock_bh(&netdev_rename_lock);
 
 	if (err < 0) {
 		up_write(&devnet_rename_sem);
@@ -1269,9 +1269,9 @@ int dev_change_name(struct net_device *dev, const char *newname)
 		if (err >= 0) {
 			err = ret;
 			down_write(&devnet_rename_sem);
-			write_seqlock(&netdev_rename_lock);
+			write_seqlock_bh(&netdev_rename_lock);
 			memcpy(dev->name, oldname, IFNAMSIZ);
-			write_sequnlock(&netdev_rename_lock);
+			write_sequnlock_bh(&netdev_rename_lock);
 			memcpy(oldname, newname, IFNAMSIZ);
 			WRITE_ONCE(dev->name_assign_type, old_assign_type);
 			old_assign_type = NET_NAME_RENAMED;
@@ -11419,9 +11419,9 @@ int __dev_change_net_namespace(struct net_device *dev, struct net *net,
 
 	if (new_name[0]) {
 		/* Rename the netdev to prepared name */
-		write_seqlock(&netdev_rename_lock);
+		write_seqlock_bh(&netdev_rename_lock);
 		strscpy(dev->name, new_name, IFNAMSIZ);
-		write_sequnlock(&netdev_rename_lock);
+		write_sequnlock_bh(&netdev_rename_lock);
 	}
 
 	/* Fixup kobjects */
-- 
2.45.2.627.g7a2c4fd464-goog


