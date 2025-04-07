Return-Path: <netdev+bounces-179612-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 773DEA7DD74
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 14:15:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44E633AF3EE
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 12:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382F82459FA;
	Mon,  7 Apr 2025 12:13:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C82D2459DD
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 12:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744028007; cv=none; b=PHmnVA6icjZTlABkjnTDjXu08oT0GbPUNyFmrDnM6poYAQ7+EH1heQdSPVgAh3j6w9efc/fdHAWLMjNVWfYwHu/FYy4G7uFq9m7b+un+a5nHkxPzySjlprMjUMYeDGg9b6VMlbs5e6ZX2Xi6IjQEXriad7KKWiZDS+kzBz92cZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744028007; c=relaxed/simple;
	bh=zH7m9pTi82P9N8dbG4AppsZq3oJl+hTGiKf4nPg3oI8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=LO1wue2U4LvClx8ObwRvLe17CzRYrwmgxabVXHzZfnD6T8DYRh/fw91UwVXCLUBchEsJTHdAtqN8MKbRwJOsi/LoL750C1l6h8e2SZEV4I0w37R4BTRPaHb0o0TmG2kD9vkONbnEuK5ZuliB+54hUmRe0Hn4oe7gD1ddw3Ozg58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3ce3bbb2b9dso44999315ab.3
        for <netdev@vger.kernel.org>; Mon, 07 Apr 2025 05:13:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744028004; x=1744632804;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8sBuYwBdcimnZtn0G1ADj+iI2GJJl6vdeMkk5uNXqfg=;
        b=bTsZG+PyilKGgrUz+21TtEOPEIBLx+LxSxp9oRO5QQ7YIaIgvkO8KYnZC3r28slPRf
         6k/NzZb28Lx27UQv62mDo1WwZ8qp8o2uTEFRyGMDYqv9nTIpF8pEP71GBL4EmcBqxqbm
         s2ymwF8DDgG3DgDf5Xm1A8ket5u8vN/GNPjqwYfmBi6DUrjyJJi0l64sn9yx75wp7aYD
         iM8WxXkEXozLXOkTCSlhCDiCnKxnJrpT3GlLMw7UVLvnmcdlspvHkRxDc3QF/I65vq6T
         ra6My2Q/1FHSg7dSLzawzlK7sJLrAqXbLPsURTtlyPnSBvPp+A3TB59oPM/fcReHRO3J
         WYIQ==
X-Forwarded-Encrypted: i=1; AJvYcCW26dbcmrdfd8Xwp/Gqj5iB03ObXTl83PZ3XCxHzdG8826PNlkq+2W6ihMMUL2cWHl45p5oXI0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGpOwm85/+L5o3H61YEd3aiH0hsxJHUzPUu2G3dzjtjEZdg1uW
	fnYiNN7fYflthJGkvpmh+94JB8KCrrk6F6fv8YrG8BXymp3xh2BR3CI9mG14MFxufGpm09C2QfV
	1GgM6WbiEgNBgKfJSF/xBo17qyWhQdjgBeYR8aQDPckl7/CLBCIuPE8I=
X-Google-Smtp-Source: AGHT+IGimJBmkK9OFoPbeQlFJGlb5UIzDFO0CD55dSnX5KLZYjtw4Cm1xZ+CVaS17rC/wsPApjy7NMLHuyC1xRE6arAnOWUhHTLN
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:18cb:b0:3d5:e002:b8ac with SMTP id
 e9e14a558f8ab-3d6e3f054b0mr114806305ab.9.1744028004051; Mon, 07 Apr 2025
 05:13:24 -0700 (PDT)
Date: Mon, 07 Apr 2025 05:13:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67f3c164.050a0220.396535.054b.GAE@google.com>
Subject: [syzbot] [net?] BUG: soft lockup in wg_packet_tx_worker (3)
From: syzbot <syzbot+75bc3d000ef2479dc914@syzkaller.appspotmail.com>
To: cake@lists.bufferbloat.net, davem@davemloft.net, edumazet@google.com, 
	horms@kernel.org, jhs@mojatatu.com, jiri@resnulli.us, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, toke@toke.dk, xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    a2392f333575 drm/panthor: Clean up FW version information ..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=14a38fb0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8cceedf2e27e877d
dashboard link: https://syzkaller.appspot.com/bug?extid=75bc3d000ef2479dc914
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/7df8ceab3279/disk-a2392f33.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/42c5af403371/vmlinux-a2392f33.xz
kernel image: https://storage.googleapis.com/syzbot-assets/73599b849e20/Image-a2392f33.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+75bc3d000ef2479dc914@syzkaller.appspotmail.com

watchdog: BUG: soft lockup - CPU#1 stuck for 22s! [kworker/1:4:6520]
Modules linked in:
irq event stamp: 37763481
hardirqs last  enabled at (37763480): [<ffff80008b86338c>] __exit_to_kernel_mode arch/arm64/kernel/entry-common.c:85 [inline]
hardirqs last  enabled at (37763480): [<ffff80008b86338c>] exit_to_kernel_mode+0xdc/0x10c arch/arm64/kernel/entry-common.c:95
hardirqs last disabled at (37763481): [<ffff80008b860e04>] __el1_irq arch/arm64/kernel/entry-common.c:557 [inline]
hardirqs last disabled at (37763481): [<ffff80008b860e04>] el1_interrupt+0x24/0x68 arch/arm64/kernel/entry-common.c:575
softirqs last  enabled at (5415542): [<ffff80008576c928>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
softirqs last disabled at (5415546): [<ffff800085777e98>] wg_socket_send_skb_to_peer+0x64/0x1a8 drivers/net/wireguard/socket.c:173
CPU: 1 UID: 0 PID: 6520 Comm: kworker/1:4 Not tainted 6.14.0-rc7-syzkaller-ga2392f333575 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
Workqueue: wg-crypt-wg0 wg_packet_tx_worker
pstate: 40400005 (nZcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : get_current arch/arm64/include/asm/current.h:19 [inline]
pc : write_comp_data kernel/kcov.c:245 [inline]
pc : __sanitizer_cov_trace_const_cmp4+0x8/0xa0 kernel/kcov.c:314
lr : cake_dequeue+0x43c/0x3da0 net/sched/sch_cake.c:2010
sp : ffff8000a3ae6e50
x29: ffff8000a3ae70a0 x28: 00000000000198d0 x27: 0000000000000000
x26: 1fffe0001f489939 x25: ffff0000fa44c9cc x24: 0000000000000001
x23: 0000000000000000 x22: 0000000000000001 x21: 0000000000000000
x20: 0000000000000200 x19: ffff0000fa44c9cc x18: dfff800000000000
x17: 00000000394bfc7d x16: ffff8000806a25ac x15: 0000000000000001
x14: 1ffff00012f50b68 x13: 0000000000000000 x12: ffff0000f1bfc2f8
x11: ffff0000f1bfc2f0 x10: 0000000000ff0100 x9 : 0000000000000000
x8 : ffff0000c42cdb80 x7 : ffff800080592830 x6 : 0000000000000000
x5 : 0000000000000001 x4 : 0000000000000001 x3 : ffff80008059283c
x2 : 0000000000000000 x1 : 0000000000000200 x0 : 0000000000000000
Call trace:
 __sanitizer_cov_trace_const_cmp4+0x8/0xa0 kernel/kcov.c:313 (P)
 dequeue_skb net/sched/sch_generic.c:293 [inline]
 qdisc_restart net/sched/sch_generic.c:398 [inline]
 __qdisc_run+0x1e0/0x2378 net/sched/sch_generic.c:416
 __dev_xmit_skb net/core/dev.c:4111 [inline]
 __dev_queue_xmit+0xd58/0x35b4 net/core/dev.c:4618
 dev_queue_xmit include/linux/netdevice.h:3313 [inline]
 neigh_hh_output include/net/neighbour.h:523 [inline]
 neigh_output include/net/neighbour.h:537 [inline]
 ip6_finish_output2+0x1614/0x20f8 net/ipv6/ip6_output.c:141
 __ip6_finish_output net/ipv6/ip6_output.c:-1 [inline]
 ip6_finish_output+0x428/0x7c4 net/ipv6/ip6_output.c:226
 NF_HOOK_COND include/linux/netfilter.h:303 [inline]
 ip6_output+0x274/0x598 net/ipv6/ip6_output.c:247
 dst_output include/net/dst.h:459 [inline]
 ip6_local_out+0x120/0x160 net/ipv6/output_core.c:155
 ip6tunnel_xmit include/net/ip6_tunnel.h:161 [inline]
 udp_tunnel6_xmit_skb+0x4e8/0xa04 net/ipv6/ip6_udp_tunnel.c:111
 send6+0x578/0x940 drivers/net/wireguard/socket.c:152
 wg_socket_send_skb_to_peer+0xfc/0x1a8 drivers/net/wireguard/socket.c:178
 wg_packet_create_data_done drivers/net/wireguard/send.c:251 [inline]
 wg_packet_tx_worker+0x1a8/0x718 drivers/net/wireguard/send.c:276
 process_one_work+0x810/0x1638 kernel/workqueue.c:3238
 process_scheduled_works kernel/workqueue.c:3319 [inline]
 worker_thread+0x97c/0xeec kernel/workqueue.c:3400
 kthread+0x65c/0x7b0 kernel/kthread.c:464
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:862
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 6290 Comm: kworker/0:3 Not tainted 6.14.0-rc7-syzkaller-ga2392f333575 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
Workqueue: wg-crypt-wg0 wg_packet_tx_worker
pstate: 00400005 (nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : queued_spin_lock_slowpath+0x15c/0xd04 kernel/locking/qspinlock.c:380
lr : queued_spin_lock_slowpath+0x168/0xd04 kernel/locking/qspinlock.c:380
sp : ffff8000a5367000
x29: ffff8000a53670c0 x28: 1fffe0001e37f01e x27: dfff800000000000
x26: 1ffff00014a6ce2c x25: ffff8000a5367040 x24: dfff800000000000
x23: ffff8000a5367080 x22: ffff700014a6ce08 x21: 0000000000000001
x20: 1ffff00014a6ce10 x19: ffff0000f1bf80f0 x18: 1fffe000366e7286
x17: ffff80008fd3d000 x16: ffff800080bf9360 x15: 0000000000000001
x14: 1fffe0001e37f01e x13: 0000000000000000 x12: 0000000000000000
x11: ffff60001e37f01f x10: 1fffe0001e37f01e x9 : 0000000000000000
x8 : 0000000000000001 x7 : ffff800089986c48 x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000001 x3 : ffff80008b885908
x2 : 0000000000000000 x1 : 0000000000000001 x0 : 0000000000000001
Call trace:
 __cmpwait_case_8 arch/arm64/include/asm/cmpxchg.h:229 [inline] (P)
 __cmpwait arch/arm64/include/asm/cmpxchg.h:257 [inline] (P)
 queued_spin_lock_slowpath+0x15c/0xd04 kernel/locking/qspinlock.c:380 (P)
 queued_spin_lock include/asm-generic/qspinlock.h:114 [inline]
 do_raw_spin_lock+0x2ec/0x334 kernel/locking/spinlock_debug.c:116
 __raw_spin_lock include/linux/spinlock_api_smp.h:134 [inline]
 _raw_spin_lock+0x50/0x60 kernel/locking/spinlock.c:154
 spin_lock include/linux/spinlock.h:351 [inline]
 __dev_xmit_skb net/core/dev.c:4078 [inline]
 __dev_queue_xmit+0xb30/0x35b4 net/core/dev.c:4618
 dev_queue_xmit include/linux/netdevice.h:3313 [inline]
 neigh_hh_output include/net/neighbour.h:523 [inline]
 neigh_output include/net/neighbour.h:537 [inline]
 ip6_finish_output2+0x1614/0x20f8 net/ipv6/ip6_output.c:141
 __ip6_finish_output net/ipv6/ip6_output.c:-1 [inline]
 ip6_finish_output+0x428/0x7c4 net/ipv6/ip6_output.c:226
 NF_HOOK_COND include/linux/netfilter.h:303 [inline]
 ip6_output+0x274/0x598 net/ipv6/ip6_output.c:247
 dst_output include/net/dst.h:459 [inline]
 ip6_local_out+0x120/0x160 net/ipv6/output_core.c:155
 ip6tunnel_xmit include/net/ip6_tunnel.h:161 [inline]
 udp_tunnel6_xmit_skb+0x4e8/0xa04 net/ipv6/ip6_udp_tunnel.c:111
 send6+0x578/0x940 drivers/net/wireguard/socket.c:152
 wg_socket_send_skb_to_peer+0xfc/0x1a8 drivers/net/wireguard/socket.c:178
 wg_packet_create_data_done drivers/net/wireguard/send.c:251 [inline]
 wg_packet_tx_worker+0x1a8/0x718 drivers/net/wireguard/send.c:276
 process_one_work+0x810/0x1638 kernel/workqueue.c:3238
 process_scheduled_works kernel/workqueue.c:3319 [inline]
 worker_thread+0x97c/0xeec kernel/workqueue.c:3400
 kthread+0x65c/0x7b0 kernel/kthread.c:464
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:862


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

