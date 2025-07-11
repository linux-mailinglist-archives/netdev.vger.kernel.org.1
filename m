Return-Path: <netdev+bounces-206195-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C086B0203B
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 17:16:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 268053ABD2A
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 15:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 050552D3A96;
	Fri, 11 Jul 2025 15:16:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f206.google.com (mail-pl1-f206.google.com [209.85.214.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001EE23BD13
	for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 15:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752246993; cv=none; b=ZKVojoWyzpX4EHXNONI7xn1BV4LrPUDrYHVC517iDHQdJ0zmlY+rLMByucT/V+xdSMX9RbL5x7gBdiF2++G24Bbh10p+T9/E7WaW8lpS/sdc2YCFUyRovlEE4cmBR0cBlyrVsKN3Ebo4RvQfouoMzk/BDWOs75FLErUqFX14JoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752246993; c=relaxed/simple;
	bh=UpvZQtXCDFz5gBW6i3A5Vt/uMDeCmwRJKT9XZytFNzg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=jFU8eiJPXFWk6Dod3JuYIW12mp0XN7aZ7Pw//snGQkLQzJnk9Yyil/wpl87A9iP9WbyLIOLOej810GpeMbLvj9b5m1Fk8hfuSLOKTme3SwV9eKTeos+C1yClsS1y/NR+qvWWbGQVpvHMXyZI6fwYARNasiDbhHqsvX/9d7ceD38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.214.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-pl1-f206.google.com with SMTP id d9443c01a7336-235e1d66fa6so20573915ad.0
        for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 08:16:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752246991; x=1752851791;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SEqtSagKnSQ3Z1AJ4nFbbLV9GTdirgxlTdtuWtdMwPQ=;
        b=pueXNWpPChPH+ONCFiI1BxmNw3D2sp0aEB+cA/PdkzWN/R/PV2SUgfALmkpr3EhG8m
         BtTeMlsO2SAH0vxkSaj8Tog2tF0AsnvFyVXJxP+6dv6myg9yomEg9UcKHW6ODmfWckhL
         uP2c3J0ajVm61Lgpp2quHqMzueoJ25uybyGQW57l3Uy3kIHEje/nvv79cjZUj39E0ApJ
         Cya6Q+fQ0i9G/+HF9QYO4DyuAHhsKHt5InK1x71nVUQTr195ZicxFVoukDy0d0r1q9PS
         4JvQkNwOQTkHXcRQokryj9zqByunQZJiFiRgmZo5K1Iv+hOEq+qbvYvLiXVRv4UIXkeR
         +ZNA==
X-Forwarded-Encrypted: i=1; AJvYcCUZnjv0KphkWzn8zZ2drVHS2IJdQ82dcgW8d7IiBekn77UTxhm4v03fXIEnIhbVtjK8SBnBncM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZYz3ObDLpg6mQCkYXgZz09lK1NMXiJPo1FssUDyHRpjNpSJaI
	BxkM0iMUF5UUW3Vn3EEcxpxZJHStr9ql1DBDEskN74otHMrrZIhrrzXGSuKy6Hi8Onhp7Mvcca8
	1/uMUzDNgjfBH431fJ/4E9LFUciJ8oZuYMTmqeP1jJGy7XFYvT6X8iyQc8ZI=
X-Google-Smtp-Source: AGHT+IExYroLLFRL63nLJP91Ex/q56BtuX/anMbWrocZ4SIP107gTNDWmGW86BCEb0/8X7dQXUOvpjQq/uNDIu3zIBXIcWXRCnW5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a17:902:d48d:b0:234:f825:b2c3 with SMTP id
 d9443c01a7336-23df082e380mr42032275ad.17.1752246991186; Fri, 11 Jul 2025
 08:16:31 -0700 (PDT)
Date: Fri, 11 Jul 2025 08:16:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68712acf.a00a0220.26a83e.0051.GAE@google.com>
Subject: [syzbot] [net?] BUG: sleeping function called from invalid context in
 team_change_rx_flags (2)
From: syzbot <syzbot+8182574047912f805d59@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    dd831ac8221e net/sched: sch_qfq: Fix null-deref in agg_deq..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=13245bd4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b29b1a0d7330d4a8
dashboard link: https://syzkaller.appspot.com/bug?extid=8182574047912f805d59
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b7b63815bf2a/disk-dd831ac8.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f857222aabbb/vmlinux-dd831ac8.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9071ec6016d0/bzImage-dd831ac8.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8182574047912f805d59@syzkaller.appspotmail.com

netlink: 8 bytes leftover after parsing attributes in process `syz.1.1814'.
macsec0: entered promiscuous mode
team0: entered promiscuous mode
BUG: sleeping function called from invalid context at kernel/locking/mutex.c:579
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 12326, name: syz.1.1814
preempt_count: 201, expected: 0
RCU nest depth: 0, expected: 0
3 locks held by syz.1.1814/12326:
 #0: ffffffff8fa21eb8 (&ops->srcu#2){.+.+}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #0: ffffffff8fa21eb8 (&ops->srcu#2){.+.+}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
 #0: ffffffff8fa21eb8 (&ops->srcu#2){.+.+}-{0:0}, at: rtnl_link_ops_get+0x23/0x250 net/core/rtnetlink.c:570
 #1: ffffffff8f51c5c8 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_lock net/core/rtnetlink.c:80 [inline]
 #1: ffffffff8f51c5c8 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_nets_lock net/core/rtnetlink.c:341 [inline]
 #1: ffffffff8f51c5c8 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_newlink+0x8db/0x1c70 net/core/rtnetlink.c:4054
 #2: ffff8880635e8368 (&macsec_netdev_addr_lock_key#2/2){+...}-{3:3}, at: netif_addr_lock_bh include/linux/netdevice.h:4805 [inline]
 #2: ffff8880635e8368 (&macsec_netdev_addr_lock_key#2/2){+...}-{3:3}, at: dev_uc_add+0x67/0x120 net/core/dev_addr_lists.c:689
Preemption disabled at:
[<ffffffff895a7d26>] local_bh_disable include/linux/bottom_half.h:20 [inline]
[<ffffffff895a7d26>] netif_addr_lock_bh include/linux/netdevice.h:4804 [inline]
[<ffffffff895a7d26>] dev_uc_add+0x56/0x120 net/core/dev_addr_lists.c:689
CPU: 0 UID: 0 PID: 12326 Comm: syz.1.1814 Not tainted 6.16.0-rc4-syzkaller-00153-gdd831ac8221e #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 __might_resched+0x495/0x610 kernel/sched/core.c:8800
 __mutex_lock_common kernel/locking/mutex.c:579 [inline]
 __mutex_lock+0x106/0xe80 kernel/locking/mutex.c:747
 team_change_rx_flags+0x38/0x220 drivers/net/team/team_core.c:1781
 dev_change_rx_flags net/core/dev.c:9241 [inline]
 __dev_set_promiscuity+0x534/0x740 net/core/dev.c:9285
 netif_set_promiscuity+0x50/0xe0 net/core/dev.c:9305
 dev_set_promiscuity+0x126/0x260 net/core/dev_api.c:287
 dev_change_rx_flags net/core/dev.c:9241 [inline]
 __dev_set_promiscuity+0x534/0x740 net/core/dev.c:9285
 __dev_set_rx_mode+0x17c/0x260 net/core/dev.c:-1
 dev_uc_add+0xc8/0x120 net/core/dev_addr_lists.c:693
 macsec_dev_open+0xd9/0x530 drivers/net/macsec.c:3634
 __dev_open+0x470/0x880 net/core/dev.c:1683
 __dev_change_flags+0x1ea/0x6d0 net/core/dev.c:9458
 rtnl_configure_link net/core/rtnetlink.c:3577 [inline]
 rtnl_newlink_create+0x555/0xb00 net/core/rtnetlink.c:3833
 __rtnl_newlink net/core/rtnetlink.c:3940 [inline]
 rtnl_newlink+0x16d6/0x1c70 net/core/rtnetlink.c:4055
 rtnetlink_rcv_msg+0x7cc/0xb70 net/core/rtnetlink.c:6944
 netlink_rcv_skb+0x208/0x470 net/netlink/af_netlink.c:2551
 netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
 netlink_unicast+0x75c/0x8e0 net/netlink/af_netlink.c:1346
 netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1896
 sock_sendmsg_nosec net/socket.c:712 [inline]
 __sock_sendmsg+0x219/0x270 net/socket.c:727
 ____sys_sendmsg+0x505/0x830 net/socket.c:2566
 ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2620
 __sys_sendmsg net/socket.c:2652 [inline]
 __do_sys_sendmsg net/socket.c:2657 [inline]
 __se_sys_sendmsg net/socket.c:2655 [inline]
 __x64_sys_sendmsg+0x19b/0x260 net/socket.c:2655
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f2785b8e929
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f27869d6038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f2785db5fa0 RCX: 00007f2785b8e929
RDX: 0000000000000800 RSI: 0000200000000280 RDI: 0000000000000009
RBP: 00007f2785c10b39 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f2785db5fa0 R15: 00007ffe1c84aa28
 </TASK>

=============================
[ BUG: Invalid wait context ]
6.16.0-rc4-syzkaller-00153-gdd831ac8221e #0 Tainted: G        W          
-----------------------------
syz.1.1814/12326 is trying to lock:
ffff88802715ce00 (team->team_lock_key#2){+.+.}-{4:4}, at: team_change_rx_flags+0x38/0x220 drivers/net/team/team_core.c:1781
other info that might help us debug this:
context-{5:5}
3 locks held by syz.1.1814/12326:
 #0: ffffffff8fa21eb8 (&ops->srcu#2){.+.+}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #0: ffffffff8fa21eb8 (&ops->srcu#2){.+.+}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
 #0: ffffffff8fa21eb8 (&ops->srcu#2){.+.+}-{0:0}, at: rtnl_link_ops_get+0x23/0x250 net/core/rtnetlink.c:570
 #1: ffffffff8f51c5c8 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_lock net/core/rtnetlink.c:80 [inline]
 #1: ffffffff8f51c5c8 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_nets_lock net/core/rtnetlink.c:341 [inline]
 #1: ffffffff8f51c5c8 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_newlink+0x8db/0x1c70 net/core/rtnetlink.c:4054
 #2: ffff8880635e8368 (&macsec_netdev_addr_lock_key#2/2){+...}-{3:3}, at: netif_addr_lock_bh include/linux/netdevice.h:4805 [inline]
 #2: ffff8880635e8368 (&macsec_netdev_addr_lock_key#2/2){+...}-{3:3}, at: dev_uc_add+0x67/0x120 net/core/dev_addr_lists.c:689
stack backtrace:
CPU: 0 UID: 0 PID: 12326 Comm: syz.1.1814 Tainted: G        W           6.16.0-rc4-syzkaller-00153-gdd831ac8221e #0 PREEMPT(full) 
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_lock_invalid_wait_context kernel/locking/lockdep.c:4833 [inline]
 check_wait_context kernel/locking/lockdep.c:4905 [inline]
 __lock_acquire+0xbcb/0xd20 kernel/locking/lockdep.c:5190
 lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5871
 __mutex_lock_common kernel/locking/mutex.c:602 [inline]
 __mutex_lock+0x182/0xe80 kernel/locking/mutex.c:747
 team_change_rx_flags+0x38/0x220 drivers/net/team/team_core.c:1781
 dev_change_rx_flags net/core/dev.c:9241 [inline]
 __dev_set_promiscuity+0x534/0x740 net/core/dev.c:9285
 netif_set_promiscuity+0x50/0xe0 net/core/dev.c:9305
 dev_set_promiscuity+0x126/0x260 net/core/dev_api.c:287
 dev_change_rx_flags net/core/dev.c:9241 [inline]
 __dev_set_promiscuity+0x534/0x740 net/core/dev.c:9285
 __dev_set_rx_mode+0x17c/0x260 net/core/dev.c:-1
 dev_uc_add+0xc8/0x120 net/core/dev_addr_lists.c:693
 macsec_dev_open+0xd9/0x530 drivers/net/macsec.c:3634
 __dev_open+0x470/0x880 net/core/dev.c:1683
 __dev_change_flags+0x1ea/0x6d0 net/core/dev.c:9458
 rtnl_configure_link net/core/rtnetlink.c:3577 [inline]
 rtnl_newlink_create+0x555/0xb00 net/core/rtnetlink.c:3833
 __rtnl_newlink net/core/rtnetlink.c:3940 [inline]
 rtnl_newlink+0x16d6/0x1c70 net/core/rtnetlink.c:4055
 rtnetlink_rcv_msg+0x7cc/0xb70 net/core/rtnetlink.c:6944
 netlink_rcv_skb+0x208/0x470 net/netlink/af_netlink.c:2551
 netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
 netlink_unicast+0x75c/0x8e0 net/netlink/af_netlink.c:1346
 netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1896
 sock_sendmsg_nosec net/socket.c:712 [inline]
 __sock_sendmsg+0x219/0x270 net/socket.c:727
 ____sys_sendmsg+0x505/0x830 net/socket.c:2566
 ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2620
 __sys_sendmsg net/socket.c:2652 [inline]
 __do_sys_sendmsg net/socket.c:2657 [inline]
 __se_sys_sendmsg net/socket.c:2655 [inline]
 __x64_sys_sendmsg+0x19b/0x260 net/socket.c:2655
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f2785b8e929
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f27869d6038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f2785db5fa0 RCX: 00007f2785b8e929
RDX: 0000000000000800 RSI: 0000200000000280 RDI: 0000000000000009
RBP: 00007f2785c10b39 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f2785db5fa0 R15: 00007ffe1c84aa28
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

