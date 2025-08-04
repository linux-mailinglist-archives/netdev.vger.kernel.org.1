Return-Path: <netdev+bounces-211623-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4AABB1A8EC
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 20:08:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B74562367E
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 18:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3868A225A39;
	Mon,  4 Aug 2025 18:08:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6F52040A8
	for <netdev@vger.kernel.org>; Mon,  4 Aug 2025 18:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754330909; cv=none; b=lD+qNCRLYtQ9bs3W/aGlIQzEW5s0eSqrHetm7F2GKPQ8s2WbM1sKBrpovw7pUPFdXx1qbR1QRWRf3CVOSmJkmV517g17zfbuMJsr0lgI1xfgUCxoAGwZy9+P+lsi/q5gK9XCifGnGkKQF+W1hM/vu6gGfVxboSsCkDMngmjkd7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754330909; c=relaxed/simple;
	bh=66ysC9Q4nIQYXFuIW76nqfbK8r/cKR2ULeQMMla+bRY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=PPqUW1NGOWKiuxib+OGe2yAcJBjyDoKr5HNg9jZuSPWqHyRliXDZ1MxrjAC6jazxB0TjLQ7S5rcBwwy82BouAgPY8ynfnPCbzfhuz3FlBbdqH+dm62Kvxtpv2Oiv1K+0Ic+pbSshmy2rqXFLICvE4aO6wYnboaIppmJ3wCuxK1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-881776a2c22so368316839f.3
        for <netdev@vger.kernel.org>; Mon, 04 Aug 2025 11:08:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754330906; x=1754935706;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pbsA9PsCbbivSzqVX8APYuvJOH1Czyx0s6poCZ4JrCo=;
        b=plwDsZ9hvbUl96ygQ0z3zUXjgHgywdMWWmxoAYLdOvLu0QCua63pb+NKV/Y1VUMJH0
         9gCEvaJcs48skwXP5mj1MB0c35yaVy6AEYh3JEPP0L1gSPBaXEtYIcx98AlJHXFnrDEz
         dUxq3V30H9+6IDBYJPrJOg5Ni8i8BbMJpKZqXCfJdpqCYvVBv28pVkgEWOpBjZ4U34iR
         4qrtwBj9FnTR6GOF5kIsaGrAvCwTdVpFeUSg0NH04cBaoLRogXGiabKOD3w8UOmJGnU+
         09ezYRx258nU26kJjiI7b2poxQ2ecEsOPgE9Doqof/9AqW5MdRQpz218grk87+UWV8m7
         drDA==
X-Forwarded-Encrypted: i=1; AJvYcCW1lmWxkEK0Mi0PBgsHqwZxSgHmsEYJLBpsulo6rIpyy2qBKp3u3STVTcUV26S4oOahIQWZXLM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+zrzblHJuNa/lM5jSb5HmgBr7uAcLRoRGGTZh9i6Nq1ZIXF0o
	RVAqiD8N87N7AqRUG3iKA32BUogaeEfcgWHtZAKBcAm2BxQTOR6zFhCE44GO9xD9fLDWLqJIfXg
	nE/4iQ/QZjoBlI6ofQy3dyku/hgs++ONk3RbDy8BfJwv/cOJDR12dydqMBMo=
X-Google-Smtp-Source: AGHT+IEto+7Sh8FVausKzc0M6Rfz7inS8Wp0KgIF2Zc9nKqmGtaCby/L63klpJU9T0FMmjSZ/YVoWOtop0xR3myOrw2DMRynEMiZ
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6b07:b0:881:7a10:80dd with SMTP id
 ca18e2360f4ac-8817a108a51mr940495439f.5.1754330906497; Mon, 04 Aug 2025
 11:08:26 -0700 (PDT)
Date: Mon, 04 Aug 2025 11:08:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6890f71a.050a0220.7f033.0010.GAE@google.com>
Subject: [syzbot] [kernfs?] possible deadlock in kernfs_remove
From: syzbot <syzbot+2d7d0fbb5fb979113ff3@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    759dfc7d04ba netlink: avoid infinite retry looping in netl..
git tree:       net
console+strace: https://syzkaller.appspot.com/x/log.txt?x=11332f82580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ac0888b9ad46cd69
dashboard link: https://syzkaller.appspot.com/bug?extid=2d7d0fbb5fb979113ff3
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1136d9bc580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1536d9bc580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/19f96268d2a7/disk-759dfc7d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/231a4e67d668/vmlinux-759dfc7d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/166f12d38b7a/bzImage-759dfc7d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2d7d0fbb5fb979113ff3@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.16.0-syzkaller-06588-g759dfc7d04ba #0 Not tainted
------------------------------------------------------
syz-executor258/5840 is trying to acquire lock:
ffff88801b2ff188 (&root->kernfs_rwsem){++++}-{4:4}, at: kernfs_remove+0x30/0x60 fs/kernfs/dir.c:1549

but task is already holding lock:
ffff8881433a4558 (&q->q_usage_counter(io)#49){++++}-{0:0}, at: nbd_start_device+0x17f/0xb10 drivers/block/nbd.c:1478

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&q->q_usage_counter(io)#49){++++}-{0:0}:
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
       blk_alloc_queue+0x538/0x620 block/blk-core.c:461
       blk_mq_alloc_queue block/blk-mq.c:4400 [inline]
       __blk_mq_alloc_disk+0x15c/0x340 block/blk-mq.c:4447
       nbd_dev_add+0x46c/0xae0 drivers/block/nbd.c:1943
       nbd_init+0x168/0x1f0 drivers/block/nbd.c:2680
       do_one_initcall+0x233/0x820 init/main.c:1269
       do_initcall_level+0x104/0x190 init/main.c:1331
       do_initcalls+0x59/0xa0 init/main.c:1347
       kernel_init_freeable+0x334/0x4a0 init/main.c:1579
       kernel_init+0x1d/0x1d0 init/main.c:1469
       ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #1 (fs_reclaim){+.+.}-{0:0}:
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
       __fs_reclaim_acquire mm/page_alloc.c:4045 [inline]
       fs_reclaim_acquire+0x72/0x100 mm/page_alloc.c:4059
       might_alloc include/linux/sched/mm.h:318 [inline]
       slab_pre_alloc_hook mm/slub.c:4099 [inline]
       slab_alloc_node mm/slub.c:4177 [inline]
       kmem_cache_alloc_lru_noprof+0x49/0x3d0 mm/slub.c:4216
       alloc_inode+0xb8/0x1b0 fs/inode.c:348
       iget_locked+0xf0/0x570 fs/inode.c:1438
       kernfs_get_inode+0x4f/0x780 fs/kernfs/inode.c:253
       kernfs_fill_super fs/kernfs/mount.c:307 [inline]
       kernfs_get_tree+0x5a9/0x920 fs/kernfs/mount.c:391
       sysfs_get_tree+0x46/0x110 fs/sysfs/mount.c:31
       vfs_get_tree+0x8f/0x2b0 fs/super.c:1815
       do_new_mount+0x2a2/0x9e0 fs/namespace.c:3805
       do_mount fs/namespace.c:4133 [inline]
       __do_sys_mount fs/namespace.c:4344 [inline]
       __se_sys_mount+0x317/0x410 fs/namespace.c:4321
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&root->kernfs_rwsem){++++}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3165 [inline]
       check_prevs_add kernel/locking/lockdep.c:3284 [inline]
       validate_chain+0xb9b/0x2140 kernel/locking/lockdep.c:3908
       __lock_acquire+0xab9/0xd20 kernel/locking/lockdep.c:5237
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
       down_write+0x96/0x1f0 kernel/locking/rwsem.c:1575
       kernfs_remove+0x30/0x60 fs/kernfs/dir.c:1549
       __kobject_del+0xe1/0x300 lib/kobject.c:604
       kobject_del+0x45/0x60 lib/kobject.c:627
       elv_unregister_queue block/elevator.c:502 [inline]
       elevator_change_done+0xf2/0x470 block/elevator.c:643
       elevator_set_none+0x42/0xb0 block/elevator.c:757
       blk_mq_elv_switch_none block/blk-mq.c:5022 [inline]
       __blk_mq_update_nr_hw_queues block/blk-mq.c:5063 [inline]
       blk_mq_update_nr_hw_queues+0x68f/0x1890 block/blk-mq.c:5113
       nbd_start_device+0x17f/0xb10 drivers/block/nbd.c:1478
       nbd_genl_connect+0x135b/0x18f0 drivers/block/nbd.c:2228
       genl_family_rcv_msg_doit+0x215/0x300 net/netlink/genetlink.c:1115
       genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
       genl_rcv_msg+0x60e/0x790 net/netlink/genetlink.c:1210
       netlink_rcv_skb+0x208/0x470 net/netlink/af_netlink.c:2552
       genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
       netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
       netlink_unicast+0x82c/0x9e0 net/netlink/af_netlink.c:1346
       netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1896
       sock_sendmsg_nosec net/socket.c:714 [inline]
       __sock_sendmsg+0x21c/0x270 net/socket.c:729
       ____sys_sendmsg+0x505/0x830 net/socket.c:2614
       ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2668
       __sys_sendmsg net/socket.c:2700 [inline]
       __do_sys_sendmsg net/socket.c:2705 [inline]
       __se_sys_sendmsg net/socket.c:2703 [inline]
       __x64_sys_sendmsg+0x19b/0x260 net/socket.c:2703
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  &root->kernfs_rwsem --> fs_reclaim --> &q->q_usage_counter(io)#49

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&q->q_usage_counter(io)#49);
                               lock(fs_reclaim);
                               lock(&q->q_usage_counter(io)#49);
  lock(&root->kernfs_rwsem);

 *** DEADLOCK ***

6 locks held by syz-executor258/5840:
 #0: ffffffff8f56e3f0 (cb_lock){++++}-{4:4}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1218
 #1: ffffffff8f56e208 (genl_mutex){+.+.}-{4:4}, at: genl_lock net/netlink/genetlink.c:35 [inline]
 #1: ffffffff8f56e208 (genl_mutex){+.+.}-{4:4}, at: genl_op_lock net/netlink/genetlink.c:60 [inline]
 #1: ffffffff8f56e208 (genl_mutex){+.+.}-{4:4}, at: genl_rcv_msg+0x10d/0x790 net/netlink/genetlink.c:1209
 #2: ffff888025120988 (&set->update_nr_hwq_lock){++++}-{4:4}, at: blk_mq_update_nr_hw_queues+0xa6/0x1890 block/blk-mq.c:5111
 #3: ffff8880251208d8 (&set->tag_list_lock){+.+.}-{4:4}, at: blk_mq_update_nr_hw_queues+0xb9/0x1890 block/blk-mq.c:5112
 #4: ffff8881433a4558 (&q->q_usage_counter(io)#49){++++}-{0:0}, at: nbd_start_device+0x17f/0xb10 drivers/block/nbd.c:1478
 #5: ffff8881433a4590 (&q->q_usage_counter(queue)){+.+.}-{0:0}, at: nbd_start_device+0x17f/0xb10 drivers/block/nbd.c:1478

stack backtrace:
CPU: 0 UID: 0 PID: 5840 Comm: syz-executor258 Not tainted 6.16.0-syzkaller-06588-g759dfc7d04ba #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_circular_bug+0x2ee/0x310 kernel/locking/lockdep.c:2043
 check_noncircular+0x134/0x160 kernel/locking/lockdep.c:2175
 check_prev_add kernel/locking/lockdep.c:3165 [inline]
 check_prevs_add kernel/locking/lockdep.c:3284 [inline]
 validate_chain+0xb9b/0x2140 kernel/locking/lockdep.c:3908
 __lock_acquire+0xab9/0xd20 kernel/locking/lockdep.c:5237
 lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
 down_write+0x96/0x1f0 kernel/locking/rwsem.c:1575
 kernfs_remove+0x30/0x60 fs/kernfs/dir.c:1549
 __kobject_del+0xe1/0x300 lib/kobject.c:604
 kobject_del+0x45/0x60 lib/kobject.c:627
 elv_unregister_queue block/elevator.c:502 [inline]
 elevator_change_done+0xf2/0x470 block/elevator.c:643
 elevator_set_none+0x42/0xb0 block/elevator.c:757
 blk_mq_elv_switch_none block/blk-mq.c:5022 [inline]
 __blk_mq_update_nr_hw_queues block/blk-mq.c:5063 [inline]
 blk_mq_update_nr_hw_queues+0x68f/0x1890 block/blk-mq.c:5113
 nbd_start_device+0x17f/0xb10 drivers/block/nbd.c:1478
 nbd_genl_connect+0x135b/0x18f0 drivers/block/nbd.c:2228
 genl_family_rcv_msg_doit+0x215/0x300 net/netlink/genetlink.c:1115
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0x60e/0x790 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x208/0x470 net/netlink/af_netlink.c:2552
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
 netlink_unicast+0x82c/0x9e0 net/netlink/af_netlink.c:1346
 netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1896
 sock_sendmsg_nosec net/socket.c:714 [inline]
 __sock_sendmsg+0x21c/0x270 net/socket.c:729
 ____sys_sendmsg+0x505/0x830 net/socket.c:2614
 ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2668
 __sys_sendmsg net/socket.c:2700 [inline]
 __do_sys_sendmsg net/socket.c:2705 [inline]
 __se_sys_sendmsg net/socket.c:2703 [inline]
 __x64_sys_sendmsg+0x19b/0x260 net/socket.c:2703
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f773fc67419
Code: 48 83 c4 28 c3 e8 e7 18 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc34589e38 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007ffc3458a008 RCX: 00007f773fc67419
RDX: 0000000020000000 RSI: 0000200000001ac0 RDI: 0000000000000003
RBP: 00007f773fcda610 R08: 0000000000000008 R09: 00007ffc3458a008
R10: 000000000000000c R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffc34589ff8 R14: 0000000000000001 R15: 0000000000000001
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

