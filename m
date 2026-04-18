Return-Path: <netdev+bounces-279470-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CKUFKioX42nxBwEAu9opvQ
	(envelope-from <netdev+bounces-279470-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 07:31:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C3FC542003C
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 07:31:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 55A4A3020AB2
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 05:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAAF33242B8;
	Sat, 18 Apr 2026 05:30:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f80.google.com (mail-oo1-f80.google.com [209.85.161.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4FB622339
	for <netdev@vger.kernel.org>; Sat, 18 Apr 2026 05:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776490238; cv=none; b=CEwMulCmk+ACVvDm/MFtfJb/bFRVa4s0rklU3Y3dORSMKBkQrE59f6WLNzve9TsbFCCuukcY++7qeVvuhz+g0RHVcXMXOCtLaTHQYbVJYT+8k/WvJd4J9Zjm5Fge7SvLVLTfTsPc7KMkCCjZq1aKoCOV8Qs6dLsr35H1Tj7zZ9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776490238; c=relaxed/simple;
	bh=0GJS3Tzc3VrtqqfFuHY5lRHoF372cRbgzeWzv7NkjRg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Oa+4zdn7u6GpmA4twrB8O3MO1eIpB2N3KSwor/DslR4ig4ShP+1BFmXBhcqKpvyOuhyk/8hMwlGVP5KJtiL6VbJ3qIRulolKNjNLj/WTmH8ihWhBeIJIAY6rTHpjV7lWTPGiykv5Hpn5u6h86g59zI9faRbVtBr7othx9BTHPho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f80.google.com with SMTP id 006d021491bc7-69271008251so2889447eaf.2
        for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 22:30:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776490236; x=1777095036;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nYgmh/7LDT/TbwgvkZjFczAw3raj9fAsqxlCOOFcvJc=;
        b=obnUeifQiLJPdLgJK4rUGFYh5EE/EYv1QvREQUZcSn21h3b/QBpjJ7DNnmusSa3MaN
         1ZNynR6lckE6/aeiOzZuZgzSlJpLcRIMdWjqQV5gNsfwtMpbv5cjo3q36F9HatGh5xxM
         VjwL9BRe2ndc1Vb+C8w4eaqo0PH+vcwC/RKom8fCbDbo97ZXnKkj9FnfBWAdkljKBEDo
         7xHNoNeeymwvlhZXTnsX3NiEu96lKLzr6vbOcNnzohj4ks1l2WJXznxCyDC9n7AzEvi4
         QP0BgLchSM4I/jkQS30qbbqtdSHOJt3D6VpcZ66tXGj+KFz8GUdb+BQI5Sgp60lt3/Tz
         xKjw==
X-Forwarded-Encrypted: i=1; AFNElJ8t0sWMT2VIMc1wZzdN4oM28534hgb46YZ5qZSrqszVFazHtHM32xv46tHTZilkMOlxS00J+Kc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrEb5DVqcUyViuUpQfX4xzrEzwJ8nadtPvp1zxp1TNCm3kToS3
	PF3AUjhBgVqkKpPzq81l4cqE/HQbDOZrgIeoSom5hLIDBSKKuO6iwn0iJfPuF8SdlGSUNnNrs8L
	puXfMIPOGdLW2ecF3H1k6JxQXg1G/tvJ/77GY5XNZTyxyAubVXBjmVKy5psk=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:4b89:b0:684:6be1:ed83 with SMTP id
 006d021491bc7-69462f0f2cdmr3405397eaf.40.1776490235724; Fri, 17 Apr 2026
 22:30:35 -0700 (PDT)
Date: Fri, 17 Apr 2026 22:30:35 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69e316fb.a00a0220.1bd0ca.0038.GAE@google.com>
Subject: [syzbot] [net?] possible deadlock in br_forward_delay_timer_expired (5)
From: syzbot <syzbot+a7f25fd06ad99e9379e4@syzkaller.appspotmail.com>
To: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	jv@jvosburgh.net, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=8195c5b22e79c2cf];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_FROM(0.00)[bounces-279470-lists,netdev=lfdr.de,a7f25fd06ad99e9379e4];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[storage.googleapis.com:url,syzkaller.appspot.com:url,appspotmail.com:email,googlegroups.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	REDIRECTOR_URL(0.00)[goo.gl];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: C3FC542003C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

syzbot found the following issue on:

HEAD commit:    43cfbdda5af6 Merge tag 'for-linus-iommufd' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=100a4702580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8195c5b22e79c2cf
dashboard link: https://syzkaller.appspot.com/bug?extid=a7f25fd06ad99e9379e4
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/848e46852283/disk-43cfbdda.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/24283dbdc318/vmlinux-43cfbdda.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f91b3fadd31d/bzImage-43cfbdda.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a7f25fd06ad99e9379e4@syzkaller.appspotmail.com

netlink: 16 bytes leftover after parsing attributes in process `syz.3.6945'.
=====================================================
WARNING: SOFTIRQ-safe -> SOFTIRQ-unsafe lock order detected
syzkaller #0 Tainted: G             L     
-----------------------------------------------------
syz.3.6945/21491 [HC0[0]:SC0[2]:HE1:SE0] is trying to acquire:
ffff888035200e98 (&bond->stats_lock/2){+.+.}-{3:3}, at: bond_get_stats+0x458/0x740 drivers/net/bonding/bond_main.c:4514

and this task is already holding:
ffff888036758e18 (&br->lock){+.-.}-{3:3}, at: spin_lock_bh include/linux/spinlock.h:348 [inline]
ffff888036758e18 (&br->lock){+.-.}-{3:3}, at: br_port_slave_changelink+0x3d/0x150 net/bridge/br_netlink.c:1212
which would create a new lock dependency:
 (&br->lock){+.-.}-{3:3} -> (&bond->stats_lock/2){+.+.}-{3:3}

but this new dependency connects a SOFTIRQ-irq-safe lock:
 (&br->lock){+.-.}-{3:3}

... which became SOFTIRQ-irq-safe at:
  lock_acquire+0x106/0x350 kernel/locking/lockdep.c:5868
  __raw_spin_lock include/linux/spinlock_api_smp.h:158 [inline]
  _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:158
  spin_lock include/linux/spinlock.h:342 [inline]
  br_forward_delay_timer_expired+0x4f/0x460 net/bridge/br_stp_timer.c:88
  call_timer_fn+0x192/0x5e0 kernel/time/timer.c:1748
  expire_timers kernel/time/timer.c:1799 [inline]
  __run_timers kernel/time/timer.c:2374 [inline]
  __run_timer_base+0x652/0x8b0 kernel/time/timer.c:2386
  run_timer_base kernel/time/timer.c:2395 [inline]
  run_timer_softirq+0xb7/0x170 kernel/time/timer.c:2405
  handle_softirqs+0x22a/0x840 kernel/softirq.c:622
  __do_softirq kernel/softirq.c:656 [inline]
  invoke_softirq kernel/softirq.c:496 [inline]
  __irq_exit_rcu+0xca/0x220 kernel/softirq.c:735
  irq_exit_rcu+0x9/0x30 kernel/softirq.c:752
  common_interrupt+0xbb/0xe0 arch/x86/kernel/irq.c:326
  asm_common_interrupt+0x26/0x40 arch/x86/include/asm/idtentry.h:688
  finish_task_switch+0x427/0xbe0 kernel/sched/core.c:5244
  context_switch kernel/sched/core.c:5390 [inline]
  __schedule+0x17bc/0x5680 kernel/sched/core.c:7188
  __schedule_loop kernel/sched/core.c:7267 [inline]
  schedule+0x164/0x360 kernel/sched/core.c:7282
  smpboot_thread_fn+0x5bc/0xa50 kernel/smpboot.c:156
  kthread+0x388/0x470 kernel/kthread.c:436
  ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

to a SOFTIRQ-irq-unsafe lock:
 (&bond->stats_lock/2){+.+.}-{3:3}

... which became SOFTIRQ-irq-unsafe at:
...
  lock_acquire+0x106/0x350 kernel/locking/lockdep.c:5868
  _raw_spin_lock_nested+0x32/0x50 kernel/locking/spinlock.c:382
  bond_get_stats+0x458/0x740 drivers/net/bonding/bond_main.c:4514
  dev_get_stats+0xb4/0xa50 net/core/dev.c:11916
  rtnl_fill_stats+0x47/0x8c0 net/core/rtnetlink.c:1506
  rtnl_fill_ifinfo+0x1840/0x20f0 net/core/rtnetlink.c:2155
  rtmsg_ifinfo_build_skb+0x17d/0x260 net/core/rtnetlink.c:4452
  rtmsg_ifinfo_event net/core/rtnetlink.c:4485 [inline]
  rtnetlink_event+0x1b7/0x270 net/core/rtnetlink.c:7054
  notifier_call_chain+0x1ad/0x3d0 kernel/notifier.c:85
  call_netdevice_notifiers_extack net/core/dev.c:2287 [inline]
  call_netdevice_notifiers net/core/dev.c:2301 [inline]
  netdev_features_change net/core/dev.c:1590 [inline]
  netdev_change_features net/core/dev.c:11155 [inline]
  netdev_compute_master_upper_features+0x91e/0xac0 net/core/dev.c:12913
  bond_enslave+0x21cc/0x3c10 drivers/net/bonding/bond_main.c:2276
  do_set_master+0x533/0x6d0 net/core/rtnetlink.c:2985
  do_setlink+0x1018/0x4590 net/core/rtnetlink.c:3187
  rtnl_changelink net/core/rtnetlink.c:3798 [inline]
  __rtnl_newlink net/core/rtnetlink.c:3971 [inline]
  rtnl_newlink+0x15ad/0x1bb0 net/core/rtnetlink.c:4108
  rtnetlink_rcv_msg+0x7d5/0xbe0 net/core/rtnetlink.c:6994
  netlink_rcv_skb+0x232/0x4b0 net/netlink/af_netlink.c:2550
  netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
  netlink_unicast+0x75c/0x8e0 net/netlink/af_netlink.c:1344
  netlink_sendmsg+0x813/0xb40 net/netlink/af_netlink.c:1894
  sock_sendmsg_nosec net/socket.c:787 [inline]
  __sock_sendmsg net/socket.c:802 [inline]
  ____sys_sendmsg+0x972/0x9f0 net/socket.c:2698
  ___sys_sendmsg+0x2a5/0x360 net/socket.c:2752
  __sys_sendmsg net/socket.c:2784 [inline]
  __do_sys_sendmsg net/socket.c:2789 [inline]
  __se_sys_sendmsg net/socket.c:2787 [inline]
  __x64_sys_sendmsg+0x1bd/0x2a0 net/socket.c:2787
  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
  do_syscall_64+0x15f/0xf80 arch/x86/entry/syscall_64.c:94
  entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

 Possible interrupt unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&bond->stats_lock/2);
                               local_irq_disable();
                               lock(&br->lock);
                               lock(&bond->stats_lock/2);
  <Interrupt>
    lock(&br->lock);

 *** DEADLOCK ***

3 locks held by syz.3.6945/21491:
 #0: ffffffff8fdddc80 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_lock net/core/rtnetlink.c:80 [inline]
 #0: ffffffff8fdddc80 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_nets_lock net/core/rtnetlink.c:341 [inline]
 #0: ffffffff8fdddc80 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_newlink+0x883/0x1bb0 net/core/rtnetlink.c:4107
 #1: ffff888036758e18 (&br->lock){+.-.}-{3:3}, at: spin_lock_bh include/linux/spinlock.h:348 [inline]
 #1: ffff888036758e18 (&br->lock){+.-.}-{3:3}, at: br_port_slave_changelink+0x3d/0x150 net/bridge/br_netlink.c:1212
 #2: ffffffff8e95cb20 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:300 [inline]
 #2: ffffffff8e95cb20 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:838 [inline]
 #2: ffffffff8e95cb20 (rcu_read_lock){....}-{1:3}, at: bond_get_stats+0x11a/0x740 drivers/net/bonding/bond_main.c:4509

the dependencies between SOFTIRQ-irq-safe lock and the holding lock:
-> (&br->lock){+.-.}-{3:3} {
   HARDIRQ-ON-W at:
                    lock_acquire+0x106/0x350 kernel/locking/lockdep.c:5868
                    __raw_spin_lock_bh include/linux/spinlock_api_smp.h:150 [inline]
                    _raw_spin_lock_bh+0x36/0x50 kernel/locking/spinlock.c:182
                    spin_lock_bh include/linux/spinlock.h:348 [inline]
                    br_add_if+0xa99/0xeb0 net/bridge/br_if.c:668
                    do_set_master+0x533/0x6d0 net/core/rtnetlink.c:2985
                    do_setlink+0x1018/0x4590 net/core/rtnetlink.c:3187
                    rtnl_changelink net/core/rtnetlink.c:3798 [inline]
                    __rtnl_newlink net/core/rtnetlink.c:3971 [inline]
                    rtnl_newlink+0x15ad/0x1bb0 net/core/rtnetlink.c:4108
                    rtnetlink_rcv_msg+0x7d5/0xbe0 net/core/rtnetlink.c:6994
                    netlink_rcv_skb+0x232/0x4b0 net/netlink/af_netlink.c:2550
                    netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
                    netlink_unicast+0x75c/0x8e0 net/netlink/af_netlink.c:1344
                    netlink_sendmsg+0x813/0xb40 net/netlink/af_netlink.c:1894
                    sock_sendmsg_nosec net/socket.c:787 [inline]
                    __sock_sendmsg net/socket.c:802 [inline]
                    __sys_sendto+0x672/0x710 net/socket.c:2265
                    __do_sys_sendto net/socket.c:2272 [inline]
                    __se_sys_sendto net/socket.c:2268 [inline]
                    __x64_sys_sendto+0xde/0x100 net/socket.c:2268
                    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
                    do_syscall_64+0x15f/0xf80 arch/x86/entry/syscall_64.c:94
                    entry_SYSCALL_64_after_hwframe+0x77/0x7f
   IN-SOFTIRQ-W at:
                    lock_acquire+0x106/0x350 kernel/locking/lockdep.c:5868
                    __raw_spin_lock include/linux/spinlock_api_smp.h:158 [inline]
                    _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:158
                    spin_lock include/linux/spinlock.h:342 [inline]
                    br_forward_delay_timer_expired+0x4f/0x460 net/bridge/br_stp_timer.c:88
                    call_timer_fn+0x192/0x5e0 kernel/time/timer.c:1748
                    expire_timers kernel/time/timer.c:1799 [inline]
                    __run_timers kernel/time/timer.c:2374 [inline]
                    __run_timer_base+0x652/0x8b0 kernel/time/timer.c:2386
                    run_timer_base kernel/time/timer.c:2395 [inline]
                    run_timer_softirq+0xb7/0x170 kernel/time/timer.c:2405
                    handle_softirqs+0x22a/0x840 kernel/softirq.c:622
                    __do_softirq kernel/softirq.c:656 [inline]
                    invoke_softirq kernel/softirq.c:496 [inline]
                    __irq_exit_rcu+0xca/0x220 kernel/softirq.c:735
                    irq_exit_rcu+0x9/0x30 kernel/softirq.c:752
                    common_interrupt+0xbb/0xe0 arch/x86/kernel/irq.c:326
                    asm_common_interrupt+0x26/0x40 arch/x86/include/asm/idtentry.h:688
                    finish_task_switch+0x427/0xbe0 kernel/sched/core.c:5244
                    context_switch kernel/sched/core.c:5390 [inline]
                    __schedule+0x17bc/0x5680 kernel/sched/core.c:7188
                    __schedule_loop kernel/sched/core.c:7267 [inline]
                    schedule+0x164/0x360 kernel/sched/core.c:7282
                    smpboot_thread_fn+0x5bc/0xa50 kernel/smpboot.c:156
                    kthread+0x388/0x470 kernel/kthread.c:436
                    ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
                    ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
   INITIAL USE at:
                   lock_acquire+0x106/0x350 kernel/locking/lockdep.c:5868
                   __raw_spin_lock_bh include/linux/spinlock_api_smp.h:150 [inline]
                   _raw_spin_lock_bh+0x36/0x50 kernel/locking/spinlock.c:182
                   spin_lock_bh include/linux/spinlock.h:348 [inline]
                   br_add_if+0xa99/0xeb0 net/bridge/br_if.c:668
                   do_set_master+0x533/0x6d0 net/core/rtnetlink.c:2985
                   do_setlink+0x1018/0x4590 net/core/rtnetlink.c:3187
                   rtnl_changelink net/core/rtnetlink.c:3798 [inline]
                   __rtnl_newlink net/core/rtnetlink.c:3971 [inline]
                   rtnl_newlink+0x15ad/0x1bb0 net/core/rtnetlink.c:4108
                   rtnetlink_rcv_msg+0x7d5/0xbe0 net/core/rtnetlink.c:6994
                   netlink_rcv_skb+0x232/0x4b0 net/netlink/af_netlink.c:2550
                   netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
                   netlink_unicast+0x75c/0x8e0 net/netlink/af_netlink.c:1344
                   netlink_sendmsg+0x813/0xb40 net/netlink/af_netlink.c:1894
                   sock_sendmsg_nosec net/socket.c:787 [inline]
                   __sock_sendmsg net/socket.c:802 [inline]
                   __sys_sendto+0x672/0x710 net/socket.c:2265
                   __do_sys_sendto net/socket.c:2272 [inline]
                   __se_sys_sendto net/socket.c:2268 [inline]
                   __x64_sys_sendto+0xde/0x100 net/socket.c:2268
                   do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
                   do_syscall_64+0x15f/0xf80 arch/x86/entry/syscall_64.c:94
                   entry_SYSCALL_64_after_hwframe+0x77/0x7f
 }
 ... key      at: [<ffffffff9aa0b240>] br_dev_setup.__key+0x0/0x20

the dependencies between the lock to be acquired
 and SOFTIRQ-irq-unsafe lock:
-> (&bond->stats_lock/2){+.+.}-{3:3} {
   HARDIRQ-ON-W at:
                    lock_acquire+0x106/0x350 kernel/locking/lockdep.c:5868
                    _raw_spin_lock_nested+0x32/0x50 kernel/locking/spinlock.c:382
                    bond_get_stats+0x458/0x740 drivers/net/bonding/bond_main.c:4514
                    dev_get_stats+0xb4/0xa50 net/core/dev.c:11916
                    rtnl_fill_stats+0x47/0x8c0 net/core/rtnetlink.c:1506
                    rtnl_fill_ifinfo+0x1840/0x20f0 net/core/rtnetlink.c:2155
                    rtmsg_ifinfo_build_skb+0x17d/0x260 net/core/rtnetlink.c:4452
                    rtmsg_ifinfo_event net/core/rtnetlink.c:4485 [inline]
                    rtnetlink_event+0x1b7/0x270 net/core/rtnetlink.c:7054
                    notifier_call_chain+0x1ad/0x3d0 kernel/notifier.c:85
                    call_netdevice_notifiers_extack net/core/dev.c:2287 [inline]
                    call_netdevice_notifiers net/core/dev.c:2301 [inline]
                    netdev_features_change net/core/dev.c:1590 [inline]
                    netdev_change_features net/core/dev.c:11155 [inline]
                    netdev_compute_master_upper_features+0x91e/0xac0 net/core/dev.c:12913
                    bond_enslave+0x21cc/0x3c10 drivers/net/bonding/bond_main.c:2276
                    do_set_master+0x533/0x6d0 net/core/rtnetlink.c:2985
                    do_setlink+0x1018/0x4590 net/core/rtnetlink.c:3187
                    rtnl_changelink net/core/rtnetlink.c:3798 [inline]
                    __rtnl_newlink net/core/rtnetlink.c:3971 [inline]
                    rtnl_newlink+0x15ad/0x1bb0 net/core/rtnetlink.c:4108
                    rtnetlink_rcv_msg+0x7d5/0xbe0 net/core/rtnetlink.c:6994
                    netlink_rcv_skb+0x232/0x4b0 net/netlink/af_netlink.c:2550
                    netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
                    netlink_unicast+0x75c/0x8e0 net/netlink/af_netlink.c:1344
                    netlink_sendmsg+0x813/0xb40 net/netlink/af_netlink.c:1894
                    sock_sendmsg_nosec net/socket.c:787 [inline]
                    __sock_sendmsg net/socket.c:802 [inline]
                    ____sys_sendmsg+0x972/0x9f0 net/socket.c:2698
                    ___sys_sendmsg+0x2a5/0x360 net/socket.c:2752
                    __sys_sendmsg net/socket.c:2784 [inline]
                    __do_sys_sendmsg net/socket.c:2789 [inline]
                    __se_sys_sendmsg net/socket.c:2787 [inline]
                    __x64_sys_sendmsg+0x1bd/0x2a0 net/socket.c:2787
                    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
                    do_syscall_64+0x15f/0xf80 arch/x86/entry/syscall_64.c:94
                    entry_SYSCALL_64_after_hwframe+0x77/0x7f
   SOFTIRQ-ON-W at:
                    lock_acquire+0x106/0x350 kernel/locking/lockdep.c:5868
                    _raw_spin_lock_nested+0x32/0x50 kernel/locking/spinlock.c:382
                    bond_get_stats+0x458/0x740 drivers/net/bonding/bond_main.c:4514
                    dev_get_stats+0xb4/0xa50 net/core/dev.c:11916
                    rtnl_fill_stats+0x47/0x8c0 net/core/rtnetlink.c:1506
                    rtnl_fill_ifinfo+0x1840/0x20f0 net/core/rtnetlink.c:2155
                    rtmsg_ifinfo_build_skb+0x17d/0x260 net/core/rtnetlink.c:4452
                    rtmsg_ifinfo_event net/core/rtnetlink.c:4485 [inline]
                    rtnetlink_event+0x1b7/0x270 net/core/rtnetlink.c:7054
                    notifier_call_chain+0x1ad/0x3d0 kernel/notifier.c:85
                    call_netdevice_notifiers_extack net/core/dev.c:2287 [inline]
                    call_netdevice_notifiers net/core/dev.c:2301 [inline]
                    netdev_features_change net/core/dev.c:1590 [inline]
                    netdev_change_features net/core/dev.c:11155 [inline]
                    netdev_compute_master_upper_features+0x91e/0xac0 net/core/dev.c:12913
                    bond_enslave+0x21cc/0x3c10 drivers/net/bonding/bond_main.c:2276
                    do_set_master+0x533/0x6d0 net/core/rtnetlink.c:2985
                    do_setlink+0x1018/0x4590 net/core/rtnetlink.c:3187
                    rtnl_changelink net/core/rtnetlink.c:3798 [inline]
                    __rtnl_newlink net/core/rtnetlink.c:3971 [inline]
                    rtnl_newlink+0x15ad/0x1bb0 net/core/rtnetlink.c:4108
                    rtnetlink_rcv_msg+0x7d5/0xbe0 net/core/rtnetlink.c:6994
                    netlink_rcv_skb+0x232/0x4b0 net/netlink/af_netlink.c:2550
                    netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
                    netlink_unicast+0x75c/0x8e0 net/netlink/af_netlink.c:1344
                    netlink_sendmsg+0x813/0xb40 net/netlink/af_netlink.c:1894
                    sock_sendmsg_nosec net/socket.c:787 [inline]
                    __sock_sendmsg net/socket.c:802 [inline]
                    ____sys_sendmsg+0x972/0x9f0 net/socket.c:2698
                    ___sys_sendmsg+0x2a5/0x360 net/socket.c:2752
                    __sys_sendmsg net/socket.c:2784 [inline]
                    __do_sys_sendmsg net/socket.c:2789 [inline]
                    __se_sys_sendmsg net/socket.c:2787 [inline]
                    __x64_sys_sendmsg+0x1bd/0x2a0 net/socket.c:2787
                    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
                    do_syscall_64+0x15f/0xf80 arch/x86/entry/syscall_64.c:94
                    entry_SYSCALL_64_after_hwframe+0x77/0x7f
   INITIAL USE at:
                   lock_acquire+0x106/0x350 kernel/locking/lockdep.c:5868
                   _raw_spin_lock_nested+0x32/0x50 kernel/locking/spinlock.c:382
                   bond_get_stats+0x458/0x740 drivers/net/bonding/bond_main.c:4514
                   dev_get_stats+0xb4/0xa50 net/core/dev.c:11916
                   rtnl_fill_stats+0x47/0x8c0 net/core/rtnetlink.c:1506
                   rtnl_fill_ifinfo+0x1840/0x20f0 net/core/rtnetlink.c:2155
                   rtmsg_ifinfo_build_skb+0x17d/0x260 net/core/rtnetlink.c:4452
                   rtmsg_ifinfo_event net/core/rtnetlink.c:4485 [inline]
                   rtnetlink_event+0x1b7/0x270 net/core/rtnetlink.c:7054
                   notifier_call_chain+0x1ad/0x3d0 kernel/notifier.c:85
                   call_netdevice_notifiers_extack net/core/dev.c:2287 [inline]
                   call_netdevice_notifiers net/core/dev.c:2301 [inline]
                   netdev_features_change net/core/dev.c:1590 [inline]
                   netdev_change_features net/core/dev.c:11155 [inline]
                   netdev_compute_master_upper_features+0x91e/0xac0 net/core/dev.c:12913
                   bond_enslave+0x21cc/0x3c10 drivers/net/bonding/bond_main.c:2276
                   do_set_master+0x533/0x6d0 net/core/rtnetlink.c:2985
                   do_setlink+0x1018/0x4590 net/core/rtnetlink.c:3187
                   rtnl_changelink net/core/rtnetlink.c:3798 [inline]
                   __rtnl_newlink net/core/rtnetlink.c:3971 [inline]
                   rtnl_newlink+0x15ad/0x1bb0 net/core/rtnetlink.c:4108
                   rtnetlink_rcv_msg+0x7d5/0xbe0 net/core/rtnetlink.c:6994
                   netlink_rcv_skb+0x232/0x4b0 net/netlink/af_netlink.c:2550
                   netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
                   netlink_unicast+0x75c/0x8e0 net/netlink/af_netlink.c:1344
                   netlink_sendmsg+0x813/0xb40 net/netlink/af_netlink.c:1894
                   sock_sendmsg_nosec net/socket.c:787 [inline]
                   __sock_sendmsg net/socket.c:802 [inline]
                   ____sys_sendmsg+0x972/0x9f0 net/socket.c:2698
                   ___sys_sendmsg+0x2a5/0x360 net/socket.c:2752
                   __sys_sendmsg net/socket.c:2784 [inline]
                   __do_sys_sendmsg net/socket.c:2789 [inline]
                   __se_sys_sendmsg net/socket.c:2787 [inline]
                   __x64_sys_sendmsg+0x1bd/0x2a0 net/socket.c:2787
                   do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
                   do_syscall_64+0x15f/0xf80 arch/x86/entry/syscall_64.c:94
                   entry_SYSCALL_64_after_hwframe+0x77/0x7f
 }
 ... key      at: [<ffffffff9a825582>] bond_init.__key+0x2/0x20
 ... acquired at:
   _raw_spin_lock_nested+0x32/0x50 kernel/locking/spinlock.c:382
   bond_get_stats+0x458/0x740 drivers/net/bonding/bond_main.c:4514
   dev_get_stats+0xb4/0xa50 net/core/dev.c:11916
   rtnl_fill_stats+0x47/0x8c0 net/core/rtnetlink.c:1506
   rtnl_fill_ifinfo+0x1840/0x20f0 net/core/rtnetlink.c:2155
   rtmsg_ifinfo_build_skb+0x17d/0x260 net/core/rtnetlink.c:4452
   rtmsg_ifinfo_event net/core/rtnetlink.c:4485 [inline]
   rtmsg_ifinfo+0x8c/0x1a0 net/core/rtnetlink.c:4494
   __dev_notify_flags+0xf2/0x310 net/core/dev.c:9845
   __dev_set_promiscuity+0x27f/0x710 net/core/dev.c:9647
   netif_set_promiscuity+0x50/0xe0 net/core/dev.c:9657
   dev_set_promiscuity+0x126/0x260 net/core/dev_api.c:287
   br_port_clear_promisc net/bridge/br_if.c:135 [inline]
   br_manage_promisc+0x4db/0x560 net/bridge/br_if.c:172
   nbp_update_port_count net/bridge/br_if.c:242 [inline]
   br_port_flags_change+0x160/0x1f0 net/bridge/br_if.c:747
   br_setport+0xc0a/0x1680 net/bridge/br_netlink.c:1000
   br_port_slave_changelink+0x12f/0x150 net/bridge/br_netlink.c:1213
   rtnl_changelink net/core/rtnetlink.c:3791 [inline]
   __rtnl_newlink net/core/rtnetlink.c:3971 [inline]
   rtnl_newlink+0x191b/0x1bb0 net/core/rtnetlink.c:4108
   rtnetlink_rcv_msg+0x7d5/0xbe0 net/core/rtnetlink.c:6994
   netlink_rcv_skb+0x232/0x4b0 net/netlink/af_netlink.c:2550
   netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
   netlink_unicast+0x75c/0x8e0 net/netlink/af_netlink.c:1344
   netlink_sendmsg+0x813/0xb40 net/netlink/af_netlink.c:1894
   sock_sendmsg_nosec net/socket.c:787 [inline]
   __sock_sendmsg net/socket.c:802 [inline]
   ____sys_sendmsg+0x972/0x9f0 net/socket.c:2698
   ___sys_sendmsg+0x2a5/0x360 net/socket.c:2752
   __sys_sendmsg net/socket.c:2784 [inline]
   __do_sys_sendmsg net/socket.c:2789 [inline]
   __se_sys_sendmsg net/socket.c:2787 [inline]
   __x64_sys_sendmsg+0x1bd/0x2a0 net/socket.c:2787
   do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
   do_syscall_64+0x15f/0xf80 arch/x86/entry/syscall_64.c:94
   entry_SYSCALL_64_after_hwframe+0x77/0x7f


stack backtrace:
CPU: 0 UID: 0 PID: 21491 Comm: syz.3.6945 Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/18/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_bad_irq_dependency kernel/locking/lockdep.c:2616 [inline]
 check_irq_usage kernel/locking/lockdep.c:2857 [inline]
 check_prev_add kernel/locking/lockdep.c:3169 [inline]
 check_prevs_add kernel/locking/lockdep.c:3284 [inline]
 validate_chain kernel/locking/lockdep.c:3908 [inline]
 __lock_acquire+0x2a94/0x2cf0 kernel/locking/lockdep.c:5237
 lock_acquire+0x106/0x350 kernel/locking/lockdep.c:5868
 _raw_spin_lock_nested+0x32/0x50 kernel/locking/spinlock.c:382
 bond_get_stats+0x458/0x740 drivers/net/bonding/bond_main.c:4514
 dev_get_stats+0xb4/0xa50 net/core/dev.c:11916
 rtnl_fill_stats+0x47/0x8c0 net/core/rtnetlink.c:1506
 rtnl_fill_ifinfo+0x1840/0x20f0 net/core/rtnetlink.c:2155
 rtmsg_ifinfo_build_skb+0x17d/0x260 net/core/rtnetlink.c:4452
 rtmsg_ifinfo_event net/core/rtnetlink.c:4485 [inline]
 rtmsg_ifinfo+0x8c/0x1a0 net/core/rtnetlink.c:4494
 __dev_notify_flags+0xf2/0x310 net/core/dev.c:9845
 __dev_set_promiscuity+0x27f/0x710 net/core/dev.c:9647
 netif_set_promiscuity+0x50/0xe0 net/core/dev.c:9657
 dev_set_promiscuity+0x126/0x260 net/core/dev_api.c:287
 br_port_clear_promisc net/bridge/br_if.c:135 [inline]
 br_manage_promisc+0x4db/0x560 net/bridge/br_if.c:172
 nbp_update_port_count net/bridge/br_if.c:242 [inline]
 br_port_flags_change+0x160/0x1f0 net/bridge/br_if.c:747
 br_setport+0xc0a/0x1680 net/bridge/br_netlink.c:1000
 br_port_slave_changelink+0x12f/0x150 net/bridge/br_netlink.c:1213
 rtnl_changelink net/core/rtnetlink.c:3791 [inline]
 __rtnl_newlink net/core/rtnetlink.c:3971 [inline]
 rtnl_newlink+0x191b/0x1bb0 net/core/rtnetlink.c:4108
 rtnetlink_rcv_msg+0x7d5/0xbe0 net/core/rtnetlink.c:6994
 netlink_rcv_skb+0x232/0x4b0 net/netlink/af_netlink.c:2550
 netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
 netlink_unicast+0x75c/0x8e0 net/netlink/af_netlink.c:1344
 netlink_sendmsg+0x813/0xb40 net/netlink/af_netlink.c:1894
 sock_sendmsg_nosec net/socket.c:787 [inline]
 __sock_sendmsg net/socket.c:802 [inline]
 ____sys_sendmsg+0x972/0x9f0 net/socket.c:2698
 ___sys_sendmsg+0x2a5/0x360 net/socket.c:2752
 __sys_sendmsg net/socket.c:2784 [inline]
 __do_sys_sendmsg net/socket.c:2789 [inline]
 __se_sys_sendmsg net/socket.c:2787 [inline]
 __x64_sys_sendmsg+0x1bd/0x2a0 net/socket.c:2787
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x15f/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f779019c819
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f7791124028 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f7790415fa0 RCX: 00007f779019c819
RDX: 0000000000008002 RSI: 0000200000000340 RDI: 0000000000000003
RBP: 00007f7790232c91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f7790416038 R14: 00007f7790415fa0 R15: 00007f779053fa48
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

