Return-Path: <netdev+bounces-201571-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05F21AE9ED5
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 15:33:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8236A3ACA29
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 13:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 667252E6133;
	Thu, 26 Jun 2025 13:33:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4752E54BB
	for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 13:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750944813; cv=none; b=LFrPDwbUQV+0Z3LABy3IM1fGj6VUXy2CH1c09sBnv4royZLPZdGSIqhN/oYRq8D5VseUupni1F0ovE6/HPB97aQKdwwTSniDf9Py2CXmICEdz9fdYhpLLOsDOHDGJ8JcCD48GIRX0Tz3ntF/Mv0qoO2g2l5hux6QdXNgkvZ+gbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750944813; c=relaxed/simple;
	bh=v01uEnPZNFuwIhQpYvDDHT0RyQYE6ARQrYMccQw3PeU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=MMIkgj6SbA+MtBRmkEzIKH1TJEpjKH53PQwYmCQLGDJ5AVvkxkun9rr2fKZV4N3pLMoOvD7htozj+ZJxyKYKHkvC1oAcGvDANEYRWvkGplbxf0zCz1FewVCdHXN2T/P8f6hNLU38rTxKGysSP8uqz5McaGFFsQFda3CnGtNnkvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3df300ab18eso18258035ab.3
        for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 06:33:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750944811; x=1751549611;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZcGrDK8kr1Uh+Iy3TORmHc3k2JAnLxWd/SYreTk4gvU=;
        b=PPv3p977zPSPI3KzUKyslDK+YkSDv+5MhHqR0SCO5hBSv9jrkP5eWNRoQLUqUEhdKs
         tWoyinCb9GEQl8+BZntMW5mjBAAaUtJsDJaEmTRifjnPA6VBXYg6+VJ6Nj4u0XX2vcuv
         oVdEEKdJTGH8V5HU1yAbzfg4DVgHm205QiOi/p+v4kMhm/NkNBPGft9AWIdqPjBoVmhI
         SdCkdFK7mCX5zEBjTAiuekUa6dzTGNWDYvXuTvdcMNiahMVH4LZ+a/PkiO0LKX5MWdSo
         VrX6BYg3Id1JYKeDdiRgt/0eMEtGjZWLfZm925+V3tpJ4vCuckpTlkWEgVRKp5igmq+4
         uvFg==
X-Forwarded-Encrypted: i=1; AJvYcCUz0sbm1YLmeJ7aziIfbyHqdfqjQovWHei3rxLjrKrgDGjo4hXy2Wu/cOySNIu89AE/2tOyA1s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtHZRF6GyH4jzN7tGw/3DoCVoAgnfckRld8DQie/rykNj/OvMR
	UcKgrM4Osvad7Oyi6FFno6rfVm1Zrr1ljH8Tn7jJBgJKu/FyNVFYU1tt6uYhLkCs6J0zL4dMtcF
	ux8DAGTRvKCqWnvwLvQEkUvkKnejeaH2MEeO9MxElqnH2ziwokI06ohJRjCk=
X-Google-Smtp-Source: AGHT+IHyMyilehOJv29/LoTNchEqwPGWT6vNOXljXaNhAtvIDikBotXU4vJDPGa2QYN8+qFKpUJrOk6PHggw/klNbksElNfhF//U
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:248a:b0:3dd:ce9b:aa17 with SMTP id
 e9e14a558f8ab-3df3292bebfmr99052815ab.20.1750944810724; Thu, 26 Jun 2025
 06:33:30 -0700 (PDT)
Date: Thu, 26 Jun 2025 06:33:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <685d4c2a.a00a0220.2e5631.028c.GAE@google.com>
Subject: [syzbot] [hams?] possible deadlock in nr_rt_ioctl (2)
From: syzbot <syzbot+14afda08dc3484d5db82@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-hams@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    09a0fa92e5b4 Merge tag 'selinux-pr-20250107' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=122714b0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7bdfbaac3fbb90d6
dashboard link: https://syzkaller.appspot.com/bug?extid=14afda08dc3484d5db82
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17b8db0f980000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-09a0fa92.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/38215ac79538/vmlinux-09a0fa92.xz
kernel image: https://storage.googleapis.com/syzbot-assets/117da94a1c81/bzImage-09a0fa92.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+14afda08dc3484d5db82@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.13.0-rc6-syzkaller-00038-g09a0fa92e5b4 #0 Not tainted
------------------------------------------------------
syz.3.32/6172 is trying to acquire lock:
ffffffff9012a4f8 (nr_neigh_list_lock){+...}-{3:3}, at: spin_lock_bh include/linux/spinlock.h:356 [inline]
ffffffff9012a4f8 (nr_neigh_list_lock){+...}-{3:3}, at: nr_remove_neigh net/netrom/nr_route.c:307 [inline]
ffffffff9012a4f8 (nr_neigh_list_lock){+...}-{3:3}, at: nr_del_node net/netrom/nr_route.c:342 [inline]
ffffffff9012a4f8 (nr_neigh_list_lock){+...}-{3:3}, at: nr_rt_ioctl+0x207f/0x29e0 net/netrom/nr_route.c:678

but task is already holding lock:
ffff88810370fa70 (&nr_node->node_lock){+...}-{3:3}, at: spin_lock_bh include/linux/spinlock.h:356 [inline]
ffff88810370fa70 (&nr_node->node_lock){+...}-{3:3}, at: nr_node_lock include/net/netrom.h:152 [inline]
ffff88810370fa70 (&nr_node->node_lock){+...}-{3:3}, at: nr_del_node net/netrom/nr_route.c:335 [inline]
ffff88810370fa70 (&nr_node->node_lock){+...}-{3:3}, at: nr_rt_ioctl+0x2aa/0x29e0 net/netrom/nr_route.c:678

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&nr_node->node_lock){+...}-{3:3}:
       __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
       _raw_spin_lock_bh+0x33/0x40 kernel/locking/spinlock.c:178
       spin_lock_bh include/linux/spinlock.h:356 [inline]
       nr_node_lock include/net/netrom.h:152 [inline]
       nr_rt_device_down+0x188/0x7f0 net/netrom/nr_route.c:519
       nr_device_event+0x126/0x170 net/netrom/af_netrom.c:126
       notifier_call_chain+0xb7/0x410 kernel/notifier.c:85
       call_netdevice_notifiers_info+0xbe/0x140 net/core/dev.c:1996
       call_netdevice_notifiers_extack net/core/dev.c:2034 [inline]
       call_netdevice_notifiers net/core/dev.c:2048 [inline]
       __dev_notify_flags+0x1f9/0x2e0 net/core/dev.c:8992
       dev_change_flags+0x10c/0x160 net/core/dev.c:9028
       dev_ifsioc+0x9c8/0x10b0 net/core/dev_ioctl.c:526
       dev_ioctl+0x224/0x10c0 net/core/dev_ioctl.c:783
       sock_do_ioctl+0x19e/0x280 net/socket.c:1223
       sock_ioctl+0x228/0x6c0 net/socket.c:1328
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:906 [inline]
       __se_sys_ioctl fs/ioctl.c:892 [inline]
       __x64_sys_ioctl+0x190/0x200 fs/ioctl.c:892
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (nr_node_list_lock){+...}-{3:3}:
       __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
       _raw_spin_lock_bh+0x33/0x40 kernel/locking/spinlock.c:178
       spin_lock_bh include/linux/spinlock.h:356 [inline]
       nr_rt_device_down+0xd5/0x7f0 net/netrom/nr_route.c:517
       nr_device_event+0x126/0x170 net/netrom/af_netrom.c:126
       notifier_call_chain+0xb7/0x410 kernel/notifier.c:85
       call_netdevice_notifiers_info+0xbe/0x140 net/core/dev.c:1996
       call_netdevice_notifiers_extack net/core/dev.c:2034 [inline]
       call_netdevice_notifiers net/core/dev.c:2048 [inline]
       __dev_notify_flags+0x1f9/0x2e0 net/core/dev.c:8992
       dev_change_flags+0x10c/0x160 net/core/dev.c:9028
       dev_ifsioc+0x9c8/0x10b0 net/core/dev_ioctl.c:526
       dev_ioctl+0x224/0x10c0 net/core/dev_ioctl.c:783
       sock_do_ioctl+0x19e/0x280 net/socket.c:1223
       sock_ioctl+0x228/0x6c0 net/socket.c:1328
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:906 [inline]
       __se_sys_ioctl fs/ioctl.c:892 [inline]
       __x64_sys_ioctl+0x190/0x200 fs/ioctl.c:892
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (nr_neigh_list_lock){+...}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3161 [inline]
       check_prevs_add kernel/locking/lockdep.c:3280 [inline]
       validate_chain kernel/locking/lockdep.c:3904 [inline]
       __lock_acquire+0x249e/0x3c40 kernel/locking/lockdep.c:5226
       lock_acquire.part.0+0x11b/0x380 kernel/locking/lockdep.c:5849
       __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
       _raw_spin_lock_bh+0x33/0x40 kernel/locking/spinlock.c:178
       spin_lock_bh include/linux/spinlock.h:356 [inline]
       nr_remove_neigh net/netrom/nr_route.c:307 [inline]
       nr_del_node net/netrom/nr_route.c:342 [inline]
       nr_rt_ioctl+0x207f/0x29e0 net/netrom/nr_route.c:678
       nr_ioctl+0x19a/0x2e0 net/netrom/af_netrom.c:1254
       sock_do_ioctl+0x116/0x280 net/socket.c:1209
       sock_ioctl+0x228/0x6c0 net/socket.c:1328
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:906 [inline]
       __se_sys_ioctl fs/ioctl.c:892 [inline]
       __x64_sys_ioctl+0x190/0x200 fs/ioctl.c:892
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  nr_neigh_list_lock --> nr_node_list_lock --> &nr_node->node_lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&nr_node->node_lock);
                               lock(nr_node_list_lock);
                               lock(&nr_node->node_lock);
  lock(nr_neigh_list_lock);

 *** DEADLOCK ***

2 locks held by syz.3.32/6172:
 #0: ffffffff9012a558 (nr_node_list_lock){+...}-{3:3}, at: spin_lock_bh include/linux/spinlock.h:356 [inline]
 #0: ffffffff9012a558 (nr_node_list_lock){+...}-{3:3}, at: nr_del_node net/netrom/nr_route.c:334 [inline]
 #0: ffffffff9012a558 (nr_node_list_lock){+...}-{3:3}, at: nr_rt_ioctl+0x22e/0x29e0 net/netrom/nr_route.c:678
 #1: ffff88810370fa70 (&nr_node->node_lock){+...}-{3:3}, at: spin_lock_bh include/linux/spinlock.h:356 [inline]
 #1: ffff88810370fa70 (&nr_node->node_lock){+...}-{3:3}, at: nr_node_lock include/net/netrom.h:152 [inline]
 #1: ffff88810370fa70 (&nr_node->node_lock){+...}-{3:3}, at: nr_del_node net/netrom/nr_route.c:335 [inline]
 #1: ffff88810370fa70 (&nr_node->node_lock){+...}-{3:3}, at: nr_rt_ioctl+0x2aa/0x29e0 net/netrom/nr_route.c:678

stack backtrace:
CPU: 3 UID: 0 PID: 6172 Comm: syz.3.32 Not tainted 6.13.0-rc6-syzkaller-00038-g09a0fa92e5b4 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_circular_bug+0x419/0x5d0 kernel/locking/lockdep.c:2074
 check_noncircular+0x31a/0x400 kernel/locking/lockdep.c:2206
 check_prev_add kernel/locking/lockdep.c:3161 [inline]
 check_prevs_add kernel/locking/lockdep.c:3280 [inline]
 validate_chain kernel/locking/lockdep.c:3904 [inline]
 __lock_acquire+0x249e/0x3c40 kernel/locking/lockdep.c:5226
 lock_acquire.part.0+0x11b/0x380 kernel/locking/lockdep.c:5849
 __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
 _raw_spin_lock_bh+0x33/0x40 kernel/locking/spinlock.c:178
 spin_lock_bh include/linux/spinlock.h:356 [inline]
 nr_remove_neigh net/netrom/nr_route.c:307 [inline]
 nr_del_node net/netrom/nr_route.c:342 [inline]
 nr_rt_ioctl+0x207f/0x29e0 net/netrom/nr_route.c:678
 nr_ioctl+0x19a/0x2e0 net/netrom/af_netrom.c:1254
 sock_do_ioctl+0x116/0x280 net/socket.c:1209
 sock_ioctl+0x228/0x6c0 net/socket.c:1328
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:906 [inline]
 __se_sys_ioctl fs/ioctl.c:892 [inline]
 __x64_sys_ioctl+0x190/0x200 fs/ioctl.c:892
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fbff7985d29
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fbff8769038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fbff7b75fa0 RCX: 00007fbff7985d29
RDX: 0000000020000180 RSI: 000000000000890c RDI: 0000000000000005
RBP: 00007fbff7a01b08 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fbff7b75fa0 R15: 00007ffd23708838
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

