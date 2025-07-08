Return-Path: <netdev+bounces-205095-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84B33AFD558
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 19:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DE6F1BC316B
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 17:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C17992066F7;
	Tue,  8 Jul 2025 17:30:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80551F0E55
	for <netdev@vger.kernel.org>; Tue,  8 Jul 2025 17:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751995831; cv=none; b=cWnldXyuS9xjhp6cBh/ZosWkqBJVozcNnpT53fwQsyzyxPoIOufZv7LNvFYYWXeUX8W/6++sUQXgoNAvBL5XDXbz8NWaCqaq/Jb6+IzSeQfdvXtcfISxWiYIQ+9yJUHWTBvSOYS3C4I8r0Yd7URBJCqnO9nn3+Mtsm18225JHmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751995831; c=relaxed/simple;
	bh=Ft+juv58VLMvhRWzX4+AKCs9fl31lVonbN0VUF9WHSw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=nQB3TsQUOf7sEo4ulmQTd/8W+b9NqEQPbjvWvRImymz18xOhfw+JdX4kcRXQWgEusVwQUdMNOTdV8lb3lVy84qaynPI9t2T2eb3AKFecTeXKJvP7YaMVU/08OM9YHnuRuEZ6TxsdfqeZx2hybQ/EG3+anauDrnW77kPBix8J8Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3df2e89fc8aso38392125ab.2
        for <netdev@vger.kernel.org>; Tue, 08 Jul 2025 10:30:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751995829; x=1752600629;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D0QuI5r6lOBDwHqNaBIJpOmCjV4Gimqib0l4a1lugcA=;
        b=ltwYeOiheH8f+PFcE4a59zC+RdLYJRkymScnjoqBxrGQTx+QZFYh1bXuOom6zydW4A
         XRSxOC1mYSLBRt5R3Me9N588uIzTURtVgUmOGWzRMnKEZjf2l9MPtf60DHsBPYz2zkHW
         1O36NopBiWBa65bFtji08e2wowzzORkp4OTfZWPB/MzlHA5QcbkA7P2DPwE8IZDM+HMm
         EtV/CykMpcyLocDPKl7nuZ3sAEURpA6KWg6FNNXc7fK/jlOBk4AGEolC2jrWV4QxFr0n
         R1Bl+PgPd6zIDvufWx2RdMtZksa+IroICsM+X7ER9MehVXyrzaktChGJEgtka/RNDzfN
         mojQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2jUxcb/bIPn48T7MnxzAla2aLrvxkVH4QQUQRO15Ffv5jqaoQ9BFr75kwWPHn/3JCiHw/VAg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxshg7fd5pbgF7pnxOX6RQRmdFQlR4pOn8TfMKZukVuVudf11tL
	EQpuNYSOyyfBMNQ0/x4Klqlrahse1PVJkA3/v5vP4ehBImS8cEudNCHiiHqtc/QoprhE9YQLMRX
	f+SIv3R4XnqLxn/oHzPU2qW2q7yiyUJbOBUjFdOHcOex4wCk3chILCdDnCpg=
X-Google-Smtp-Source: AGHT+IHwWtsSgL0GJcdWkOdN5/BrkJoD0QCrKgk/qkbW9WoCKBcWpzNKkGoRDqWXxtAxauH6Qcy66WxBabaA1VjuDdxZQeAIRh5t
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b2d:b0:3df:34b4:1db8 with SMTP id
 e9e14a558f8ab-3e1637eaaf1mr6875425ab.4.1751995828881; Tue, 08 Jul 2025
 10:30:28 -0700 (PDT)
Date: Tue, 08 Jul 2025 10:30:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <686d55b4.050a0220.1ffab7.0014.GAE@google.com>
Subject: [syzbot] [net?] BUG: sleeping function called from invalid context in
 dev_set_promiscuity (2)
From: syzbot <syzbot+6e619ff6dd4c8618a635@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    1e3b66e32601 vsock: fix `vsock_proto` declaration
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=16cbf28c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b29b1a0d7330d4a8
dashboard link: https://syzkaller.appspot.com/bug?extid=6e619ff6dd4c8618a635
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/11faaf1afe22/disk-1e3b66e3.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ba355ce28c50/vmlinux-1e3b66e3.xz
kernel image: https://storage.googleapis.com/syzbot-assets/018f94fd1327/bzImage-1e3b66e3.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6e619ff6dd4c8618a635@syzkaller.appspotmail.com

netlink: 8 bytes leftover after parsing attributes in process `syz.3.2844'.
macsec0: entered promiscuous mode
BUG: sleeping function called from invalid context at kernel/locking/mutex.c:579
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 15744, name: syz.3.2844
preempt_count: 201, expected: 0
RCU nest depth: 0, expected: 0
3 locks held by syz.3.2844/15744:
 #0: ffffffff8fa219b8 (&ops->srcu#2){.+.+}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #0: ffffffff8fa219b8 (&ops->srcu#2){.+.+}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
 #0: ffffffff8fa219b8 (&ops->srcu#2){.+.+}-{0:0}, at: rtnl_link_ops_get+0x23/0x250 net/core/rtnetlink.c:570
 #1: ffffffff8f51c5c8 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_lock net/core/rtnetlink.c:80 [inline]
 #1: ffffffff8f51c5c8 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_nets_lock net/core/rtnetlink.c:341 [inline]
 #1: ffffffff8f51c5c8 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_newlink+0x8db/0x1c70 net/core/rtnetlink.c:4054
 #2: ffff88802cb3a368 (&macsec_netdev_addr_lock_key/1){+...}-{3:3}, at: netif_addr_lock_bh include/linux/netdevice.h:4805 [inline]
 #2: ffff88802cb3a368 (&macsec_netdev_addr_lock_key/1){+...}-{3:3}, at: dev_uc_add+0x67/0x120 net/core/dev_addr_lists.c:689
Preemption disabled at:
[<ffffffff895a79e6>] local_bh_disable include/linux/bottom_half.h:20 [inline]
[<ffffffff895a79e6>] netif_addr_lock_bh include/linux/netdevice.h:4804 [inline]
[<ffffffff895a79e6>] dev_uc_add+0x56/0x120 net/core/dev_addr_lists.c:689
CPU: 1 UID: 0 PID: 15744 Comm: syz.3.2844 Not tainted 6.16.0-rc4-syzkaller-00114-g1e3b66e32601 #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 __might_resched+0x495/0x610 kernel/sched/core.c:8800
 __mutex_lock_common kernel/locking/mutex.c:579 [inline]
 __mutex_lock+0x106/0xe80 kernel/locking/mutex.c:747
 netdev_lock include/linux/netdevice.h:2756 [inline]
 netdev_lock_ops include/net/netdev_lock.h:42 [inline]
 dev_set_promiscuity+0x10e/0x260 net/core/dev_api.c:286
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
 netlink_rcv_skb+0x205/0x470 net/netlink/af_netlink.c:2551
 netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
 netlink_unicast+0x759/0x8e0 net/netlink/af_netlink.c:1346
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
RIP: 0033:0x7f64fc18e929
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f64fd052038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f64fc3b5fa0 RCX: 00007f64fc18e929
RDX: 0000000000000800 RSI: 0000200000000280 RDI: 0000000000000004
RBP: 00007f64fc210b39 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f64fc3b5fa0 R15: 00007ffd8fec8448
 </TASK>

=============================
[ BUG: Invalid wait context ]
6.16.0-rc4-syzkaller-00114-g1e3b66e32601 #0 Tainted: G        W          
-----------------------------
syz.3.2844/15744 is trying to lock:
ffff888077de0d30 (&dev_instance_lock_key#20){+.+.}-{4:4}, at: netdev_lock include/linux/netdevice.h:2756 [inline]
ffff888077de0d30 (&dev_instance_lock_key#20){+.+.}-{4:4}, at: netdev_lock_ops include/net/netdev_lock.h:42 [inline]
ffff888077de0d30 (&dev_instance_lock_key#20){+.+.}-{4:4}, at: dev_set_promiscuity+0x10e/0x260 net/core/dev_api.c:286
other info that might help us debug this:
context-{5:5}
3 locks held by syz.3.2844/15744:
 #0: ffffffff8fa219b8 (&ops->srcu#2){.+.+}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #0: ffffffff8fa219b8 (&ops->srcu#2){.+.+}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
 #0: ffffffff8fa219b8 (&ops->srcu#2){.+.+}-{0:0}, at: rtnl_link_ops_get+0x23/0x250 net/core/rtnetlink.c:570
 #1: ffffffff8f51c5c8 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_lock net/core/rtnetlink.c:80 [inline]
 #1: ffffffff8f51c5c8 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_nets_lock net/core/rtnetlink.c:341 [inline]
 #1: ffffffff8f51c5c8 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_newlink+0x8db/0x1c70 net/core/rtnetlink.c:4054
 #2: ffff88802cb3a368 (&macsec_netdev_addr_lock_key/1){+...}-{3:3}, at: netif_addr_lock_bh include/linux/netdevice.h:4805 [inline]
 #2: ffff88802cb3a368 (&macsec_netdev_addr_lock_key/1){+...}-{3:3}, at: dev_uc_add+0x67/0x120 net/core/dev_addr_lists.c:689
stack backtrace:
CPU: 1 UID: 0 PID: 15744 Comm: syz.3.2844 Tainted: G        W           6.16.0-rc4-syzkaller-00114-g1e3b66e32601 #0 PREEMPT(full) 
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
 netdev_lock include/linux/netdevice.h:2756 [inline]
 netdev_lock_ops include/net/netdev_lock.h:42 [inline]
 dev_set_promiscuity+0x10e/0x260 net/core/dev_api.c:286
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
 netlink_rcv_skb+0x205/0x470 net/netlink/af_netlink.c:2551
 netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
 netlink_unicast+0x759/0x8e0 net/netlink/af_netlink.c:1346
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
RIP: 0033:0x7f64fc18e929
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f64fd052038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f64fc3b5fa0 RCX: 00007f64fc18e929
RDX: 0000000000000800 RSI: 0000200000000280 RDI: 0000000000000004
RBP: 00007f64fc210b39 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f64fc3b5fa0 R15: 00007ffd8fec8448
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

