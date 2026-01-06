Return-Path: <netdev+bounces-247416-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 62B6CCF9A95
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 18:25:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 055F230C9019
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 17:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8414033B97F;
	Tue,  6 Jan 2026 17:17:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f78.google.com (mail-ot1-f78.google.com [209.85.210.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8538633A71A
	for <netdev@vger.kernel.org>; Tue,  6 Jan 2026 17:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767719842; cv=none; b=PapNkW7Gf2kM/91dSgH4l9EDci+D0i2H9ba8b/04x3V3WSwKSFVRkR3qyBNlEcgaAjWxZUI6BUfA+uarwfTZbepGgh9FMFj+X917dSo1ojUfuc/t6n6k6snHZG6BDdlaTvugdVzFep226yCEksb/cP/RiqaSeL9V1kqeVtd3NfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767719842; c=relaxed/simple;
	bh=SyKTxziXINkqDY6EGLB6a7h/LYkeE55+ykwcvnsBud0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=A4z6XbEbkN7VmJefxBJaMnlbod+Xh+tBVnRSYvI3qmT4Wy8IUeUqunoV8TbMKPo1ZngLtN3l60SqgsaSu2LPJqaIrpkuDx5kAoMUbEr3TsxYpYbjRSORK7mXZE8MmFevlboUOPbKqQqCKNA3AbzMkab9bvGFsuDWCLzmEk9ix90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f78.google.com with SMTP id 46e09a7af769-7c6ce3b9fa0so1977497a34.0
        for <netdev@vger.kernel.org>; Tue, 06 Jan 2026 09:17:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767719839; x=1768324639;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jm8yNAlKu7VH2E2l51BOu8CoL70R28ASDalw1g7qkCM=;
        b=nEGDe9TwHzg4jgD2p0Ykjn5TIsBQKOI4e3wsLLLggEFFehoWoG2T40sJgLOLVjROSY
         GOW6lHkR8kZaGKDeZ70vrEmbM6hibdeKIfPaEZXWXH6G66bn58/8IgmjI6klyOLwnnJQ
         qEcw0FRueRR22Gs/qqFbJndL93hrY3Ucio82mHxGn9HvJRPq84/1Psz4NCCbVSDW/t8e
         qg95LtMeYJz+rrEv5DpQPoGR6lvVUb24I3qotTvb86OQxME3mWAjVtmiay7IsyFb9ueq
         +9mklUUGxTvFYBZXLyuNRXa1+blHsPI8xviLR0KCzvuK1uvnw6ACKqvj/L2g9Mglbreo
         +iWA==
X-Forwarded-Encrypted: i=1; AJvYcCXu0B87wL0jxhhfQcdbf+LMBF1gfjubgpsGmYQu+lhwQyxjJwggOeI22INc1pv2tX5GXiAiJlE=@vger.kernel.org
X-Gm-Message-State: AOJu0YypY+sHeWiGygWZMQYGHVBF8OewQCoh456x2cqfS57rPDsbrgeq
	wXTWHDdrHlLkrn+BTAM02xJ1OU+q1s2eK5EVWJjDGPn7zncoHVgPA9lXDFT3cHN79TORD3AMiUr
	NSczN4uH4h6y6O0L5TKL6OqxnTSxn5CD/msGW0+I9a0nUPtJ7dzyh3sPQtN8=
X-Google-Smtp-Source: AGHT+IEL1/7yIfN9Zy/2mMts49PjFqKqheDGsO3sk8OhiM6EP3OwcgEO66gqyquqLx0STswmUYqqXQEbeRFmixHKpTovkmn36jIv
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:8410:b0:65d:ba7:f671 with SMTP id
 006d021491bc7-65f4799cd5dmr1189202eaf.11.1767719839108; Tue, 06 Jan 2026
 09:17:19 -0800 (PST)
Date: Tue, 06 Jan 2026 09:17:19 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <695d439f.050a0220.1c677c.0347.GAE@google.com>
Subject: [syzbot] [net?] possible deadlock in sch_direct_xmit (5)
From: syzbot <syzbot+1240b33467289f5ab50b@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	jhs@mojatatu.com, jiri@resnulli.us, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d4b779985a6c Merge tag 'for-6.17/dm-fixes' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13644f62580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4d8792ecb6308d0f
dashboard link: https://syzkaller.appspot.com/bug?extid=1240b33467289f5ab50b
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17644f62580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=130d8712580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8c0e2ca1cac7/disk-d4b77998.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ff3a75e765b0/vmlinux-d4b77998.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f043b7730989/bzImage-d4b77998.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1240b33467289f5ab50b@syzkaller.appspotmail.com

============================================
WARNING: possible recursive locking detected
syzkaller #0 Not tainted
--------------------------------------------
kworker/0:1/10 is trying to acquire lock:
ffff888079139d58 (&qdisc_xmit_lock_key#3){+...}-{3:3}, at: spin_lock include/linux/spinlock.h:351 [inline]
ffff888079139d58 (&qdisc_xmit_lock_key#3){+...}-{3:3}, at: __netif_tx_lock include/linux/netdevice.h:4659 [inline]
ffff888079139d58 (&qdisc_xmit_lock_key#3){+...}-{3:3}, at: sch_direct_xmit+0x153/0x4b0 net/sched/sch_generic.c:342

but task is already holding lock:
ffff88807de56158 (&qdisc_xmit_lock_key#3){+...}-{3:3}, at: spin_lock include/linux/spinlock.h:351 [inline]
ffff88807de56158 (&qdisc_xmit_lock_key#3){+...}-{3:3}, at: __netif_tx_lock include/linux/netdevice.h:4659 [inline]
ffff88807de56158 (&qdisc_xmit_lock_key#3){+...}-{3:3}, at: __dev_queue_xmit+0x1676/0x3b50 net/core/dev.c:4721

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&qdisc_xmit_lock_key#3);
  lock(&qdisc_xmit_lock_key#3);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

12 locks held by kworker/0:1/10:
 #0: ffff88802f2e1548 ((wq_completion)mld){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3211 [inline]
 #0: ffff88802f2e1548 ((wq_completion)mld){+.+.}-{0:0}, at: process_scheduled_works+0x9b4/0x17b0 kernel/workqueue.c:3319
 #1: ffffc900000f7bc0 ((work_completion)(&(&idev->mc_ifc_work)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3212 [inline]
 #1: ffffc900000f7bc0 ((work_completion)(&(&idev->mc_ifc_work)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x9ef/0x17b0 kernel/workqueue.c:3319
 #2: ffff888079a43538 (&idev->mc_lock){+.+.}-{4:4}, at: mld_ifc_work+0x2d/0xd60 net/ipv6/mcast.c:2697
 #3: ffffffff8e13a0e0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #3: ffffffff8e13a0e0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
 #3: ffffffff8e13a0e0 (rcu_read_lock){....}-{1:3}, at: mld_sendpack+0x1de/0xd80 net/ipv6/mcast.c:1832
 #4: ffffffff8e13a0e0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #4: ffffffff8e13a0e0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
 #4: ffffffff8e13a0e0 (rcu_read_lock){....}-{1:3}, at: ip6_finish_output2+0x701/0x16a0 net/ipv6/ip6_output.c:126
 #5: ffffffff8e13a140 (rcu_read_lock_bh){....}-{1:3}, at: local_bh_disable include/linux/bottom_half.h:20 [inline]
 #5: ffffffff8e13a140 (rcu_read_lock_bh){....}-{1:3}, at: rcu_read_lock_bh include/linux/rcupdate.h:892 [inline]
 #5: ffffffff8e13a140 (rcu_read_lock_bh){....}-{1:3}, at: __dev_queue_xmit+0x27b/0x3b50 net/core/dev.c:4650
 #6: ffff88807de56158 (&qdisc_xmit_lock_key#3){+...}-{3:3}, at: spin_lock include/linux/spinlock.h:351 [inline]
 #6: ffff88807de56158 (&qdisc_xmit_lock_key#3){+...}-{3:3}, at: __netif_tx_lock include/linux/netdevice.h:4659 [inline]
 #6: ffff88807de56158 (&qdisc_xmit_lock_key#3){+...}-{3:3}, at: __dev_queue_xmit+0x1676/0x3b50 net/core/dev.c:4721
 #7: ffffffff8e13a0e0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #7: ffffffff8e13a0e0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
 #7: ffffffff8e13a0e0 (rcu_read_lock){....}-{1:3}, at: ip_output+0x60/0x3c0 net/ipv4/ip_output.c:431
 #8: ffffffff8e13a0e0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #8: ffffffff8e13a0e0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
 #8: ffffffff8e13a0e0 (rcu_read_lock){....}-{1:3}, at: ip_finish_output2+0x452/0x1160 net/ipv4/ip_output.c:228
 #9: ffffffff8e13a0e0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #9: ffffffff8e13a0e0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
 #9: ffffffff8e13a0e0 (rcu_read_lock){....}-{1:3}, at: arp_xmit+0x23/0x270 net/ipv4/arp.c:662
 #10: ffffffff8e13a140 (rcu_read_lock_bh){....}-{1:3}, at: local_bh_disable include/linux/bottom_half.h:20 [inline]
 #10: ffffffff8e13a140 (rcu_read_lock_bh){....}-{1:3}, at: rcu_read_lock_bh include/linux/rcupdate.h:892 [inline]
 #10: ffffffff8e13a140 (rcu_read_lock_bh){....}-{1:3}, at: __dev_queue_xmit+0x27b/0x3b50 net/core/dev.c:4650
 #11: ffff88807ec9a258 (dev->qdisc_tx_busylock ?: &qdisc_tx_busylock#3){+...}-{3:3}, at: spin_trylock include/linux/spinlock.h:361 [inline]
 #11: ffff88807ec9a258 (dev->qdisc_tx_busylock ?: &qdisc_tx_busylock#3){+...}-{3:3}, at: qdisc_run_begin include/net/sch_generic.h:197 [inline]
 #11: ffff88807ec9a258 (dev->qdisc_tx_busylock ?: &qdisc_tx_busylock#3){+...}-{3:3}, at: __dev_xmit_skb net/core/dev.c:4101 [inline]
 #11: ffff88807ec9a258 (dev->qdisc_tx_busylock ?: &qdisc_tx_busylock#3){+...}-{3:3}, at: __dev_queue_xmit+0x138a/0x3b50 net/core/dev.c:4691

stack backtrace:
CPU: 0 UID: 0 PID: 10 Comm: kworker/0:1 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
Workqueue: mld mld_ifc_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_deadlock_bug+0x28b/0x2a0 kernel/locking/lockdep.c:3041
 check_deadlock kernel/locking/lockdep.c:3093 [inline]
 validate_chain+0x1a3f/0x2140 kernel/locking/lockdep.c:3895
 __lock_acquire+0xab9/0xd20 kernel/locking/lockdep.c:5237
 lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
 spin_lock include/linux/spinlock.h:351 [inline]
 __netif_tx_lock include/linux/netdevice.h:4659 [inline]
 sch_direct_xmit+0x153/0x4b0 net/sched/sch_generic.c:342
 __dev_xmit_skb net/core/dev.c:4114 [inline]
 __dev_queue_xmit+0x1857/0x3b50 net/core/dev.c:4691
 NF_HOOK+0x310/0x3a0 include/linux/netfilter.h:-1
 arp_xmit+0x16c/0x270 net/ipv4/arp.c:664
 arp_solicit+0xc1d/0xe60 net/ipv4/arp.c:392
 neigh_probe net/core/neighbour.c:1098 [inline]
 __neigh_event_send+0xf6d/0x1560 net/core/neighbour.c:1271
 neigh_event_send_probe include/net/neighbour.h:471 [inline]
 neigh_event_send include/net/neighbour.h:477 [inline]
 neigh_resolve_output+0x198/0x750 net/core/neighbour.c:1579
 neigh_output include/net/neighbour.h:547 [inline]
 ip_finish_output2+0xd3d/0x1160 net/ipv4/ip_output.c:235
 NF_HOOK_COND include/linux/netfilter.h:307 [inline]
 ip_output+0x2a1/0x3c0 net/ipv4/ip_output.c:436
 iptunnel_xmit+0x592/0xa40 net/ipv4/ip_tunnel_core.c:84
 ip_tunnel_xmit+0x1c41/0x2390 net/ipv4/ip_tunnel.c:859
 __gre_xmit net/ipv4/ip_gre.c:488 [inline]
 ipgre_xmit+0x89e/0xc50 net/ipv4/ip_gre.c:692
 __netdev_start_xmit include/linux/netdevice.h:5222 [inline]
 netdev_start_xmit include/linux/netdevice.h:5231 [inline]
 xmit_one net/core/dev.c:3839 [inline]
 dev_hard_start_xmit+0x2d7/0x830 net/core/dev.c:3855
 __dev_queue_xmit+0x1b8d/0x3b50 net/core/dev.c:4725
 neigh_output include/net/neighbour.h:547 [inline]
 ip6_finish_output2+0x11fb/0x16a0 net/ipv6/ip6_output.c:141
 NF_HOOK+0x9e/0x380 include/linux/netfilter.h:318
 mld_sendpack+0x800/0xd80 net/ipv6/mcast.c:1860
 mld_send_cr net/ipv6/mcast.c:2159 [inline]
 mld_ifc_work+0x83e/0xd60 net/ipv6/mcast.c:2698
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3319
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3400
 kthread+0x70e/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x436/0x7d0 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

