Return-Path: <netdev+bounces-202618-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30037AEE597
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 19:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75EF3441141
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 17:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAB02295DBD;
	Mon, 30 Jun 2025 17:18:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59362293462
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 17:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751303915; cv=none; b=d7MXlz1KCIijPwJqCfpu4ZZlChKBo0/q2ODnBGBaf+IBYd9Ktc6/xsPqLJ9jKGpkZ2TeVF+WGC+PGzybpDxyR0iLsav0GehCWciy13u73FvN79FwobjpJmUe8rrIakuhVD2XgQGBtppf9nrv/FCHrqf50XhADBPHcDDFgPc55TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751303915; c=relaxed/simple;
	bh=TWyQaN2iVUz94ynFB7bJuwDtzl/3YSHG8D7YpIvNZ+E=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ARzSEc91/HGfFdhNMhDQ77U+L7rlNhI3ox8ntXqrTj8fP+YvIHmTbdn387vNQFOAB5J4kI8fNyqz0H5VgbYEdqFrE5Nyjm1oNWkNSQ3/yrqoqDq8ZQ+JJJ3SS5+GP+4C3Fc1UCTkeCBfLObGrgUon7Xh1Z0XgeolrKCNpQQzu18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3df393bf5f2so25422425ab.1
        for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 10:18:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751303912; x=1751908712;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kicb8xShHO5+Li5xCZS/gmc1HOZdXG+zKN5b5MtgnoA=;
        b=WBg4mKdQ9GRJuwfSuxBOERUIqt7SDCF+dFTjWIFH0muwRD3AfzsELxkxLCj0+g5TwE
         7+e3QBzkAUoaxYptdxKyTRgH74HK4iywGQJ+MEp1kqGSDe8l3BtbabIp5u4lSf3u/h1g
         GGf1tZaInIOpUDMY3NpzLvSOeCluiHxJlRyzZFbarVkNJvIRWoGZpgN1a85mXKfOcv0i
         qD3R3h9EaRrqHIi/tsaOqFrSKEzZxs1dND74Aczk/XpudCeITLNSa3vmDP63RVvhE5Jy
         6+a3Uzq5Q1v6Q1R82CIRFoIdgwYORaROLMgoTjbS1iR0wquFiV9QQV4cHgZp4Rnn6+QP
         CHdA==
X-Forwarded-Encrypted: i=1; AJvYcCXrVo4U4vtVxwsy+0Y+15HX6mDvQc2qS0I+D9pRRbJihtu2KpST+YsCWaj+3NA8QKq5u427TZw=@vger.kernel.org
X-Gm-Message-State: AOJu0YylygIo1hY2t2A6FSvdkOl9yKBrmpEQEJyOtOPetF/u4rWZAQh+
	Jjr1rCrQq9kZKOt2jPgiAaoF7Sh/rLgPn8KkDWxu0sytU00VX5bAnu+1cdrIet1LryLn5GkOg1t
	ic5phyzQIyjH4DIfUcKIE1H9o4vqTNd2RjGXaxaZ3zyHUzpdPHl8Lsz7PJbo=
X-Google-Smtp-Source: AGHT+IFaFcDOZuSSEO9gIqU4iFZ3sGjFDoZQM+sL6YMceFgKbB/4lI2U7VN2n7n1ygQx4B0vLF/m2nz8luC1HuO+nnymnZ3bfvDf
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c245:0:b0:3df:4159:8fe5 with SMTP id
 e9e14a558f8ab-3df4ab55b4bmr165596905ab.4.1751303912481; Mon, 30 Jun 2025
 10:18:32 -0700 (PDT)
Date: Mon, 30 Jun 2025 10:18:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6862c6e8.a70a0220.3b7e22.10ad.GAE@google.com>
Subject: [syzbot] [net?] possible deadlock in br_forward_delay_timer_expired (4)
From: syzbot <syzbot+33d7a8d74e3e3439ef76@syzkaller.appspotmail.com>
To: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	jv@jvosburgh.net, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    ee88bddf7f2f Merge tag 'bpf-fixes' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=133b03d4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=641bc01f4fbdccd4
dashboard link: https://syzkaller.appspot.com/bug?extid=33d7a8d74e3e3439ef76
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-ee88bddf.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4d5b7a3f640a/vmlinux-ee88bddf.xz
kernel image: https://storage.googleapis.com/syzbot-assets/99b76e194ba7/bzImage-ee88bddf.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+33d7a8d74e3e3439ef76@syzkaller.appspotmail.com

bond_slave_0: left promiscuous mode
bond_slave_1: left promiscuous mode
bond2: left promiscuous mode
=====================================================
WARNING: SOFTIRQ-safe -> SOFTIRQ-unsafe lock order detected
6.16.0-rc3-syzkaller-00072-gee88bddf7f2f #0 Not tainted
-----------------------------------------------------
syz.4.769/9186 [HC0[0]:SC0[2]:HE1:SE0] is trying to acquire:
ffff888059d58e18 (&bond->stats_lock){+.+.}-{3:3}
, at: bond_get_stats+0x115/0x550 drivers/net/bonding/bond_main.c:4579

and this task is already holding:
ffff888033900d98 (&br->lock){+.-.}-{3:3}, at: spin_lock_bh include/linux/spinlock.h:356 [inline]
ffff888033900d98 (&br->lock){+.-.}-{3:3}, at: br_port_slave_changelink net/bridge/br_netlink.c:1212 [inline]
ffff888033900d98 (&br->lock){+.-.}-{3:3}, at: br_port_slave_changelink+0x3e/0x190 net/bridge/br_netlink.c:1200
which would create a new lock dependency:
 (&br->lock){+.-.}-{3:3} -> (&bond->stats_lock){+.+.}-{3:3}

but this new dependency connects a SOFTIRQ-irq-safe lock:
 (&br->lock){+.-.}-{3:3}

... which became SOFTIRQ-irq-safe at:
  lock_acquire kernel/locking/lockdep.c:5871 [inline]
  lock_acquire+0x179/0x350 kernel/locking/lockdep.c:5828
  __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
  _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
  spin_lock include/linux/spinlock.h:351 [inline]
  br_forward_delay_timer_expired+0x4f/0x560 net/bridge/br_stp_timer.c:88
  call_timer_fn+0x19a/0x620 kernel/time/timer.c:1747
  expire_timers kernel/time/timer.c:1798 [inline]
  __run_timers+0x6ef/0x960 kernel/time/timer.c:2372
  __run_timer_base kernel/time/timer.c:2384 [inline]
  __run_timer_base kernel/time/timer.c:2376 [inline]
  run_timer_base+0x114/0x190 kernel/time/timer.c:2393
  run_timer_softirq+0x1a/0x40 kernel/time/timer.c:2403
  handle_softirqs+0x216/0x8e0 kernel/softirq.c:579
  __do_softirq kernel/softirq.c:613 [inline]
  invoke_softirq kernel/softirq.c:453 [inline]
  __irq_exit_rcu+0x109/0x170 kernel/softirq.c:680
  irq_exit_rcu+0x9/0x30 kernel/softirq.c:696
  instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1050 [inline]
  sysvec_apic_timer_interrupt+0xa4/0xc0 arch/x86/kernel/apic/apic.c:1050
  asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
  native_safe_halt arch/x86/include/asm/irqflags.h:48 [inline]
  pv_native_safe_halt+0xf/0x20 arch/x86/kernel/paravirt.c:81
  arch_safe_halt arch/x86/include/asm/paravirt.h:107 [inline]
  default_idle+0x13/0x20 arch/x86/kernel/process.c:749
  default_idle_call+0x6d/0xb0 kernel/sched/idle.c:117
  cpuidle_idle_call kernel/sched/idle.c:185 [inline]
  do_idle+0x391/0x510 kernel/sched/idle.c:325
  cpu_startup_entry+0x4f/0x60 kernel/sched/idle.c:423
  start_secondary+0x21d/0x2b0 arch/x86/kernel/smpboot.c:315
  common_startup_64+0x13e/0x148

to a SOFTIRQ-irq-unsafe lock:
 (&bond->stats_lock){+.+.}-{3:3}

... which became SOFTIRQ-irq-unsafe at:
...
  lock_acquire kernel/locking/lockdep.c:5871 [inline]
  lock_acquire+0x179/0x350 kernel/locking/lockdep.c:5828
  _raw_spin_lock_nested+0x31/0x40 kernel/locking/spinlock.c:378
  bond_get_stats+0x115/0x550 drivers/net/bonding/bond_main.c:4579
  dev_get_stats+0xb0/0xa40 net/core/dev.c:11551
  rtnl_fill_stats+0x48/0xa90 net/core/rtnetlink.c:1474
  rtnl_fill_ifinfo.constprop.0+0x167d/0x4ca0 net/core/rtnetlink.c:2118
  rtmsg_ifinfo_build_skb+0x151/0x280 net/core/rtnetlink.c:4399
  rtmsg_ifinfo_event net/core/rtnetlink.c:4432 [inline]
  rtmsg_ifinfo_event net/core/rtnetlink.c:4422 [inline]
  rtmsg_ifinfo+0x9f/0x1a0 net/core/rtnetlink.c:4441
  register_netdevice+0x1bd9/0x2270 net/core/dev.c:11157
  bond_create+0xb9/0x120 drivers/net/bonding/bond_main.c:6541
  bonding_init+0xc1/0x140 drivers/net/bonding/bond_main.c:6635
  do_one_initcall+0x120/0x6e0 init/main.c:1274
  do_initcall_level init/main.c:1336 [inline]
  do_initcalls init/main.c:1352 [inline]
  do_basic_setup init/main.c:1371 [inline]
  kernel_init_freeable+0x5c2/0x900 init/main.c:1584
  kernel_init+0x1c/0x2b0 init/main.c:1474
  ret_from_fork+0x5d4/0x6f0 arch/x86/kernel/process.c:148
  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

other info that might help us debug this:

 Possible interrupt unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&bond->stats_lock);
                               local_irq_disable();
                               lock(&br->lock);
                               lock(&bond->stats_lock);
  <Interrupt>
    lock(&br->lock);

 *** DEADLOCK ***

3 locks held by syz.4.769/9186:
 #0: ffffffff9034cbe8 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_lock net/core/rtnetlink.c:80 [inline]
 #0: ffffffff9034cbe8 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_nets_lock net/core/rtnetlink.c:341 [inline]
 #0: ffffffff9034cbe8 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_newlink+0x600/0x2000 net/core/rtnetlink.c:4054
 #1: ffff888033900d98 (&br->lock){+.-.}-{3:3}, at: spin_lock_bh include/linux/spinlock.h:356 [inline]
 #1: ffff888033900d98 (&br->lock){+.-.}-{3:3}, at: br_port_slave_changelink net/bridge/br_netlink.c:1212 [inline]
 #1: ffff888033900d98 (&br->lock){+.-.}-{3:3}, at: br_port_slave_changelink+0x3e/0x190 net/bridge/br_netlink.c:1200
 #2: ffffffff8e5c4940 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #2: ffffffff8e5c4940 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
 #2: ffffffff8e5c4940 (rcu_read_lock){....}-{1:3}, at: bond_get_stats+0xc8/0x550 drivers/net/bonding/bond_main.c:4574

the dependencies between SOFTIRQ-irq-safe lock and the holding lock:
-> (&br->lock){+.-.}-{3:3} {
   HARDIRQ-ON-W at:
                    lock_acquire kernel/locking/lockdep.c:5871 [inline]
                    lock_acquire+0x179/0x350 kernel/locking/lockdep.c:5828
                    __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
                    _raw_spin_lock_bh+0x33/0x40 kernel/locking/spinlock.c:178
                    spin_lock_bh include/linux/spinlock.h:356 [inline]
                    br_add_if+0xff1/0x1b70 net/bridge/br_if.c:682
                    do_set_master+0x40f/0x730 net/core/rtnetlink.c:2946
                    do_setlink.constprop.0+0xbd8/0x4380 net/core/rtnetlink.c:3148
                    rtnl_changelink net/core/rtnetlink.c:3759 [inline]
                    __rtnl_newlink net/core/rtnetlink.c:3918 [inline]
                    rtnl_newlink+0x1446/0x2000 net/core/rtnetlink.c:4055
                    rtnetlink_rcv_msg+0x95e/0xe90 net/core/rtnetlink.c:6944
                    netlink_rcv_skb+0x158/0x420 net/netlink/af_netlink.c:2534
                    netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
                    netlink_unicast+0x53a/0x7f0 net/netlink/af_netlink.c:1339
                    netlink_sendmsg+0x8d1/0xdd0 net/netlink/af_netlink.c:1883
                    sock_sendmsg_nosec net/socket.c:712 [inline]
                    __sock_sendmsg net/socket.c:727 [inline]
                    __sys_sendto+0x4a0/0x520 net/socket.c:2180
                    __do_sys_sendto net/socket.c:2187 [inline]
                    __se_sys_sendto net/socket.c:2183 [inline]
                    __x64_sys_sendto+0xe0/0x1c0 net/socket.c:2183
                    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
                    do_syscall_64+0xcd/0x4c0 arch/x86/entry/syscall_64.c:94
                    entry_SYSCALL_64_after_hwframe+0x77/0x7f
   IN-SOFTIRQ-W at:
                    lock_acquire kernel/locking/lockdep.c:5871 [inline]
                    lock_acquire+0x179/0x350 kernel/locking/lockdep.c:5828
                    __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
                    _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
                    spin_lock include/linux/spinlock.h:351 [inline]
                    br_forward_delay_timer_expired+0x4f/0x560 net/bridge/br_stp_timer.c:88
                    call_timer_fn+0x19a/0x620 kernel/time/timer.c:1747
                    expire_timers kernel/time/timer.c:1798 [inline]
                    __run_timers+0x6ef/0x960 kernel/time/timer.c:2372
                    __run_timer_base kernel/time/timer.c:2384 [inline]
                    __run_timer_base kernel/time/timer.c:2376 [inline]
                    run_timer_base+0x114/0x190 kernel/time/timer.c:2393
                    run_timer_softirq+0x1a/0x40 kernel/time/timer.c:2403
                    handle_softirqs+0x216/0x8e0 kernel/softirq.c:579
                    __do_softirq kernel/softirq.c:613 [inline]
                    invoke_softirq kernel/softirq.c:453 [inline]
                    __irq_exit_rcu+0x109/0x170 kernel/softirq.c:680
                    irq_exit_rcu+0x9/0x30 kernel/softirq.c:696
                    instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1050 [inline]
                    sysvec_apic_timer_interrupt+0xa4/0xc0 arch/x86/kernel/apic/apic.c:1050
                    asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
                    native_safe_halt arch/x86/include/asm/irqflags.h:48 [inline]
                    pv_native_safe_halt+0xf/0x20 arch/x86/kernel/paravirt.c:81
                    arch_safe_halt arch/x86/include/asm/paravirt.h:107 [inline]
                    default_idle+0x13/0x20 arch/x86/kernel/process.c:749
                    default_idle_call+0x6d/0xb0 kernel/sched/idle.c:117
                    cpuidle_idle_call kernel/sched/idle.c:185 [inline]
                    do_idle+0x391/0x510 kernel/sched/idle.c:325
                    cpu_startup_entry+0x4f/0x60 kernel/sched/idle.c:423
                    start_secondary+0x21d/0x2b0 arch/x86/kernel/smpboot.c:315
                    common_startup_64+0x13e/0x148
   INITIAL USE at:
                   lock_acquire kernel/locking/lockdep.c:5871 [inline]
                   lock_acquire+0x179/0x350 kernel/locking/lockdep.c:5828
                   __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
                   _raw_spin_lock_bh+0x33/0x40 kernel/locking/spinlock.c:178
                   spin_lock_bh include/linux/spinlock.h:356 [inline]
                   br_add_if+0xff1/0x1b70 net/bridge/br_if.c:682
                   do_set_master+0x40f/0x730 net/core/rtnetlink.c:2946
                   do_setlink.constprop.0+0xbd8/0x4380 net/core/rtnetlink.c:3148
                   rtnl_changelink net/core/rtnetlink.c:3759 [inline]
                   __rtnl_newlink net/core/rtnetlink.c:3918 [inline]
                   rtnl_newlink+0x1446/0x2000 net/core/rtnetlink.c:4055
                   rtnetlink_rcv_msg+0x95e/0xe90 net/core/rtnetlink.c:6944
                   netlink_rcv_skb+0x158/0x420 net/netlink/af_netlink.c:2534
                   netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
                   netlink_unicast+0x53a/0x7f0 net/netlink/af_netlink.c:1339
                   netlink_sendmsg+0x8d1/0xdd0 net/netlink/af_netlink.c:1883
                   sock_sendmsg_nosec net/socket.c:712 [inline]
                   __sock_sendmsg net/socket.c:727 [inline]
                   __sys_sendto+0x4a0/0x520 net/socket.c:2180
                   __do_sys_sendto net/socket.c:2187 [inline]
                   __se_sys_sendto net/socket.c:2183 [inline]
                   __x64_sys_sendto+0xe0/0x1c0 net/socket.c:2183
                   do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
                   do_syscall_64+0xcd/0x4c0 arch/x86/entry/syscall_64.c:94
                   entry_SYSCALL_64_after_hwframe+0x77/0x7f
 }
 ... key      at: [<ffffffff9b267040>] __key.7+0x0/0x40

the dependencies between the lock to be acquired
 and SOFTIRQ-irq-unsafe lock:
-> (&bond->stats_lock){+.+.}-{3:3} {
   HARDIRQ-ON-W at:
                    lock_acquire kernel/locking/lockdep.c:5871 [inline]
                    lock_acquire+0x179/0x350 kernel/locking/lockdep.c:5828
                    _raw_spin_lock_nested+0x31/0x40 kernel/locking/spinlock.c:378
                    bond_get_stats+0x115/0x550 drivers/net/bonding/bond_main.c:4579
                    dev_get_stats+0xb0/0xa40 net/core/dev.c:11551
                    rtnl_fill_stats+0x48/0xa90 net/core/rtnetlink.c:1474
                    rtnl_fill_ifinfo.constprop.0+0x167d/0x4ca0 net/core/rtnetlink.c:2118
                    rtmsg_ifinfo_build_skb+0x151/0x280 net/core/rtnetlink.c:4399
                    rtmsg_ifinfo_event net/core/rtnetlink.c:4432 [inline]
                    rtmsg_ifinfo_event net/core/rtnetlink.c:4422 [inline]
                    rtmsg_ifinfo+0x9f/0x1a0 net/core/rtnetlink.c:4441
                    register_netdevice+0x1bd9/0x2270 net/core/dev.c:11157
                    bond_create+0xb9/0x120 drivers/net/bonding/bond_main.c:6541
                    bonding_init+0xc1/0x140 drivers/net/bonding/bond_main.c:6635
                    do_one_initcall+0x120/0x6e0 init/main.c:1274
                    do_initcall_level init/main.c:1336 [inline]
                    do_initcalls init/main.c:1352 [inline]
                    do_basic_setup init/main.c:1371 [inline]
                    kernel_init_freeable+0x5c2/0x900 init/main.c:1584
                    kernel_init+0x1c/0x2b0 init/main.c:1474
                    ret_from_fork+0x5d4/0x6f0 arch/x86/kernel/process.c:148
                    ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
   SOFTIRQ-ON-W at:
                    lock_acquire kernel/locking/lockdep.c:5871 [inline]
                    lock_acquire+0x179/0x350 kernel/locking/lockdep.c:5828
                    _raw_spin_lock_nested+0x31/0x40 kernel/locking/spinlock.c:378
                    bond_get_stats+0x115/0x550 drivers/net/bonding/bond_main.c:4579
                    dev_get_stats+0xb0/0xa40 net/core/dev.c:11551
                    rtnl_fill_stats+0x48/0xa90 net/core/rtnetlink.c:1474
                    rtnl_fill_ifinfo.constprop.0+0x167d/0x4ca0 net/core/rtnetlink.c:2118
                    rtmsg_ifinfo_build_skb+0x151/0x280 net/core/rtnetlink.c:4399
                    rtmsg_ifinfo_event net/core/rtnetlink.c:4432 [inline]
                    rtmsg_ifinfo_event net/core/rtnetlink.c:4422 [inline]
                    rtmsg_ifinfo+0x9f/0x1a0 net/core/rtnetlink.c:4441
                    register_netdevice+0x1bd9/0x2270 net/core/dev.c:11157
                    bond_create+0xb9/0x120 drivers/net/bonding/bond_main.c:6541
                    bonding_init+0xc1/0x140 drivers/net/bonding/bond_main.c:6635
                    do_one_initcall+0x120/0x6e0 init/main.c:1274
                    do_initcall_level init/main.c:1336 [inline]
                    do_initcalls init/main.c:1352 [inline]
                    do_basic_setup init/main.c:1371 [inline]
                    kernel_init_freeable+0x5c2/0x900 init/main.c:1584
                    kernel_init+0x1c/0x2b0 init/main.c:1474
                    ret_from_fork+0x5d4/0x6f0 arch/x86/kernel/process.c:148
                    ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
   INITIAL USE at:
                   lock_acquire kernel/locking/lockdep.c:5871 [inline]
                   lock_acquire+0x179/0x350 kernel/locking/lockdep.c:5828
                   _raw_spin_lock_nested+0x31/0x40 kernel/locking/spinlock.c:378
                   bond_get_stats+0x115/0x550 drivers/net/bonding/bond_main.c:4579
                   dev_get_stats+0xb0/0xa40 net/core/dev.c:11551
                   rtnl_fill_stats+0x48/0xa90 net/core/rtnetlink.c:1474
                   rtnl_fill_ifinfo.constprop.0+0x167d/0x4ca0 net/core/rtnetlink.c:2118
                   rtmsg_ifinfo_build_skb+0x151/0x280 net/core/rtnetlink.c:4399
                   rtmsg_ifinfo_event net/core/rtnetlink.c:4432 [inline]
                   rtmsg_ifinfo_event net/core/rtnetlink.c:4422 [inline]
                   rtmsg_ifinfo+0x9f/0x1a0 net/core/rtnetlink.c:4441
                   register_netdevice+0x1bd9/0x2270 net/core/dev.c:11157
                   bond_create+0xb9/0x120 drivers/net/bonding/bond_main.c:6541
                   bonding_init+0xc1/0x140 drivers/net/bonding/bond_main.c:6635
                   do_one_initcall+0x120/0x6e0 init/main.c:1274
                   do_initcall_level init/main.c:1336 [inline]
                   do_initcalls init/main.c:1352 [inline]
                   do_basic_setup init/main.c:1371 [inline]
                   kernel_init_freeable+0x5c2/0x900 init/main.c:1584
                   kernel_init+0x1c/0x2b0 init/main.c:1474
                   ret_from_fork+0x5d4/0x6f0 arch/x86/kernel/process.c:148
                   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 }
 ... key      at: [<ffffffff9b0ae6a0>] __key.9+0x0/0x40
 ... acquired at:
   lock_acquire kernel/locking/lockdep.c:5871 [inline]
   lock_acquire+0x179/0x350 kernel/locking/lockdep.c:5828
   _raw_spin_lock_nested+0x31/0x40 kernel/locking/spinlock.c:378
   bond_get_stats+0x115/0x550 drivers/net/bonding/bond_main.c:4579
   dev_get_stats+0xb0/0xa40 net/core/dev.c:11551
   rtnl_fill_stats+0x48/0xa90 net/core/rtnetlink.c:1474
   rtnl_fill_ifinfo.constprop.0+0x167d/0x4ca0 net/core/rtnetlink.c:2118
   rtmsg_ifinfo_build_skb+0x151/0x280 net/core/rtnetlink.c:4399
   rtmsg_ifinfo_event net/core/rtnetlink.c:4432 [inline]
   rtmsg_ifinfo_event net/core/rtnetlink.c:4422 [inline]
   rtmsg_ifinfo+0x9f/0x1a0 net/core/rtnetlink.c:4441
   __dev_notify_flags+0x24c/0x2e0 net/core/dev.c:9493
   __dev_set_promiscuity+0x26b/0x590 net/core/dev.c:9295
   netif_set_promiscuity+0x52/0x150 net/core/dev.c:9305
   dev_set_promiscuity+0xb2/0x260 net/core/dev_api.c:287
   bond_set_promiscuity drivers/net/bonding/bond_main.c:919 [inline]
   bond_change_rx_flags+0x22b/0x740 drivers/net/bonding/bond_main.c:4738
   dev_change_rx_flags net/core/dev.c:9241 [inline]
   __dev_set_promiscuity+0x214/0x590 net/core/dev.c:9285
   netif_set_promiscuity+0x52/0x150 net/core/dev.c:9305
   dev_set_promiscuity+0xb2/0x260 net/core/dev_api.c:287
   vlan_dev_change_rx_flags+0x123/0x150 net/8021q/vlan_dev.c:474
   dev_change_rx_flags net/core/dev.c:9241 [inline]
   __dev_set_promiscuity+0x214/0x590 net/core/dev.c:9285
   netif_set_promiscuity+0x52/0x150 net/core/dev.c:9305
   dev_set_promiscuity+0xb2/0x260 net/core/dev_api.c:287
   br_port_clear_promisc net/bridge/br_if.c:135 [inline]
   br_manage_promisc+0x3da/0x4f0 net/bridge/br_if.c:172
   nbp_update_port_count net/bridge/br_if.c:242 [inline]
   br_port_flags_change+0x184/0x1d0 net/bridge/br_if.c:761
   br_setport+0xb7d/0x17d0 net/bridge/br_netlink.c:1000
   br_port_slave_changelink net/bridge/br_netlink.c:1213 [inline]
   br_port_slave_changelink+0xcf/0x190 net/bridge/br_netlink.c:1200
   rtnl_changelink net/core/rtnetlink.c:3752 [inline]
   __rtnl_newlink net/core/rtnetlink.c:3918 [inline]
   rtnl_newlink+0x1409/0x2000 net/core/rtnetlink.c:4055
   rtnetlink_rcv_msg+0x95e/0xe90 net/core/rtnetlink.c:6944
   netlink_rcv_skb+0x158/0x420 net/netlink/af_netlink.c:2534
   netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
   netlink_unicast+0x53a/0x7f0 net/netlink/af_netlink.c:1339
   netlink_sendmsg+0x8d1/0xdd0 net/netlink/af_netlink.c:1883
   sock_sendmsg_nosec net/socket.c:712 [inline]
   __sock_sendmsg net/socket.c:727 [inline]
   ____sys_sendmsg+0xa95/0xc70 net/socket.c:2566
   ___sys_sendmsg+0x134/0x1d0 net/socket.c:2620
   __sys_sendmsg+0x16d/0x220 net/socket.c:2652
   do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
   do_syscall_64+0xcd/0x4c0 arch/x86/entry/syscall_64.c:94
   entry_SYSCALL_64_after_hwframe+0x77/0x7f


stack backtrace:
CPU: 1 UID: 0 PID: 9186 Comm: syz.4.769 Not tainted 6.16.0-rc3-syzkaller-00072-gee88bddf7f2f #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_bad_irq_dependency kernel/locking/lockdep.c:2619 [inline]
 check_irq_usage+0x7dc/0x920 kernel/locking/lockdep.c:2860
 check_prev_add kernel/locking/lockdep.c:3172 [inline]
 check_prevs_add kernel/locking/lockdep.c:3287 [inline]
 validate_chain kernel/locking/lockdep.c:3911 [inline]
 __lock_acquire+0x1285/0x1c90 kernel/locking/lockdep.c:5240
 lock_acquire kernel/locking/lockdep.c:5871 [inline]
 lock_acquire+0x179/0x350 kernel/locking/lockdep.c:5828
 _raw_spin_lock_nested+0x31/0x40 kernel/locking/spinlock.c:378
 bond_get_stats+0x115/0x550 drivers/net/bonding/bond_main.c:4579
 dev_get_stats+0xb0/0xa40 net/core/dev.c:11551
 rtnl_fill_stats+0x48/0xa90 net/core/rtnetlink.c:1474
 rtnl_fill_ifinfo.constprop.0+0x167d/0x4ca0 net/core/rtnetlink.c:2118
 rtmsg_ifinfo_build_skb+0x151/0x280 net/core/rtnetlink.c:4399
 rtmsg_ifinfo_event net/core/rtnetlink.c:4432 [inline]
 rtmsg_ifinfo_event net/core/rtnetlink.c:4422 [inline]
 rtmsg_ifinfo+0x9f/0x1a0 net/core/rtnetlink.c:4441
 __dev_notify_flags+0x24c/0x2e0 net/core/dev.c:9493
 __dev_set_promiscuity+0x26b/0x590 net/core/dev.c:9295
 netif_set_promiscuity+0x52/0x150 net/core/dev.c:9305
 dev_set_promiscuity+0xb2/0x260 net/core/dev_api.c:287
 bond_set_promiscuity drivers/net/bonding/bond_main.c:919 [inline]
 bond_change_rx_flags+0x22b/0x740 drivers/net/bonding/bond_main.c:4738
 dev_change_rx_flags net/core/dev.c:9241 [inline]
 __dev_set_promiscuity+0x214/0x590 net/core/dev.c:9285
 netif_set_promiscuity+0x52/0x150 net/core/dev.c:9305
 dev_set_promiscuity+0xb2/0x260 net/core/dev_api.c:287
 vlan_dev_change_rx_flags+0x123/0x150 net/8021q/vlan_dev.c:474
 dev_change_rx_flags net/core/dev.c:9241 [inline]
 __dev_set_promiscuity+0x214/0x590 net/core/dev.c:9285
 netif_set_promiscuity+0x52/0x150 net/core/dev.c:9305
 dev_set_promiscuity+0xb2/0x260 net/core/dev_api.c:287
 br_port_clear_promisc net/bridge/br_if.c:135 [inline]
 br_manage_promisc+0x3da/0x4f0 net/bridge/br_if.c:172
 nbp_update_port_count net/bridge/br_if.c:242 [inline]
 br_port_flags_change+0x184/0x1d0 net/bridge/br_if.c:761
 br_setport+0xb7d/0x17d0 net/bridge/br_netlink.c:1000
 br_port_slave_changelink net/bridge/br_netlink.c:1213 [inline]
 br_port_slave_changelink+0xcf/0x190 net/bridge/br_netlink.c:1200
 rtnl_changelink net/core/rtnetlink.c:3752 [inline]
 __rtnl_newlink net/core/rtnetlink.c:3918 [inline]
 rtnl_newlink+0x1409/0x2000 net/core/rtnetlink.c:4055
 rtnetlink_rcv_msg+0x95e/0xe90 net/core/rtnetlink.c:6944
 netlink_rcv_skb+0x158/0x420 net/netlink/af_netlink.c:2534
 netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
 netlink_unicast+0x53a/0x7f0 net/netlink/af_netlink.c:1339
 netlink_sendmsg+0x8d1/0xdd0 net/netlink/af_netlink.c:1883
 sock_sendmsg_nosec net/socket.c:712 [inline]
 __sock_sendmsg net/socket.c:727 [inline]
 ____sys_sendmsg+0xa95/0xc70 net/socket.c:2566
 ___sys_sendmsg+0x134/0x1d0 net/socket.c:2620
 __sys_sendmsg+0x16d/0x220 net/socket.c:2652
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x4c0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f280f18e929
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f280ffed038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f280f3b5fa0 RCX: 00007f280f18e929
RDX: 0000000000000000 RSI: 0000200000000000 RDI: 000000000000000e
RBP: 00007f280f210b39 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f280f3b5fa0 R15: 00007ffd37a1aac8
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

