Return-Path: <netdev+bounces-194195-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE71AC7BCD
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 12:32:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58B3C1736F3
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 10:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B07B4278744;
	Thu, 29 May 2025 10:32:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8BB274FC8
	for <netdev@vger.kernel.org>; Thu, 29 May 2025 10:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748514754; cv=none; b=XnfQZPZHtVF1XiRktJxGbj8ENzSD9CcjyRw2B5rsdh3O9Fb6Rb1WTDEMsKAUAEk5WSm4uX02fPethLmKtdlIaNrfi4ZhlVSt0NLatsRWIr8iSht2ncGqYmuvfADjqYnRkqugzt2OQsT3pZOwxWFtduGcqjOVSRZsmkWX5c4xi/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748514754; c=relaxed/simple;
	bh=B9cHShXgTKU6W0nG6CDZEJA9cXRMAnzuf5P0DjJj/6w=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=K1JYD8110yglX0Dv8DRqOd2F1H+50N/Gs8Az5r0YbxFXicEb8CJIfFhdtFWXR/lfppfjUYOqz9iaDHWNhik290XbgybtRWRhuMX6YPKpYEcuBSFlEea5+r02hpHcZgPWaJKtiXkqsLgPeeCpKzGM0VuRE8oXVIDIxl19sDsEymM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-85e7551197bso78911339f.0
        for <netdev@vger.kernel.org>; Thu, 29 May 2025 03:32:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748514752; x=1749119552;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SIB75AphkviE4DdAXUe35d5ziOwxwbvCLCqMyrSlpqo=;
        b=oo7Rmc+sXY6L0FeRHhZ1kEK8w8RnfOVR/i2sUE+clM6UL34kjhVQGqzLwNg+B6H7b6
         L6nfHJ9kPQKGcqq4//p2ohEdgxNw2w3NiKcvqaqHtRJUIO3GJUrLhTLEMKt5KA2jNUSF
         hMXJVEmjCORK1QxmYPxPYQwxO90+9Ww2n2Ijn6so3pXou4jb6acsRAvOiJHjd/73SHzb
         9rMmWj6IjOq4ulvG7Y7ETYL79inVw/68WpUU2hmuIolig89Ar6XS0dy78PpB4Jt3c1di
         byI7kwP4y4BOc5qKmw/eL43Yhx7lHBYlGevMHzYcxt0mwrGEIoBPwN03paWY40XKnUqI
         s7bQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0MT29v8DcasYhyyDWmeme5vEcw6gQ6MXlER/fsKmCOa1dINEQdBa/+Q4h6HWchpVLKYziujw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6qUEkvHLyUN3zIHzUWXb+ygMZIbGIb0pUYnbm3Kc96l5d9mOH
	71H401TYdjfp1D3mDFc9vghkcIySdMwMOnhkGGXXPg5tSDI26KJ0AqnKzDHrIQan+WEXR9qmb9V
	m437wG4t75aebaL/DiZ+2TeXjW5L039mSe12RcdAqDBDr747EhqobMp72T6A=
X-Google-Smtp-Source: AGHT+IGXxtIeqVwOswUJKw1+GWS5rvNxkG4J3O3TS+MOrp5YJsQ1rqKnkOnc2FEbzSej+wMOYhe2h5HivfFegxlQ6NJCRixwiE5h
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:f0e:b0:86c:f0b1:8dd7 with SMTP id
 ca18e2360f4ac-86cf240edc5mr288801039f.0.1748514751924; Thu, 29 May 2025
 03:32:31 -0700 (PDT)
Date: Thu, 29 May 2025 03:32:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <683837bf.a00a0220.52848.0003.GAE@google.com>
Subject: [syzbot] [net?] possible deadlock in rtnl_newlink
From: syzbot <syzbot+846bb38dc67fe62cc733@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    b1427432d3b6 Merge tag 'iommu-fixes-v6.15-rc7' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=161ef5f4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9fd1c9848687d742
dashboard link: https://syzkaller.appspot.com/bug?extid=846bb38dc67fe62cc733
compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12d21170580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17d9a8e8580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-b1427432.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/47b0c66c70d9/vmlinux-b1427432.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a2df6bfabd3c/bzImage-b1427432.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+846bb38dc67fe62cc733@syzkaller.appspotmail.com

ifb0: entered allmulticast mode
ifb1: entered allmulticast mode
======================================================
WARNING: possible circular locking dependency detected
6.15.0-rc7-syzkaller-00144-gb1427432d3b6 #0 Not tainted
------------------------------------------------------
syz-executor216/5313 is trying to acquire lock:
ffff888033f496f0 ((work_completion)(&adapter->reset_task)){+.+.}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
ffff888033f496f0 ((work_completion)(&adapter->reset_task)){+.+.}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
ffff888033f496f0 ((work_completion)(&adapter->reset_task)){+.+.}-{0:0}, at: start_flush_work kernel/workqueue.c:4150 [inline]
ffff888033f496f0 ((work_completion)(&adapter->reset_task)){+.+.}-{0:0}, at: __flush_work+0xd2/0xbc0 kernel/workqueue.c:4208

but task is already holding lock:
ffffffff8f2fab48 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_lock net/core/rtnetlink.c:80 [inline]
ffffffff8f2fab48 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_nets_lock net/core/rtnetlink.c:341 [inline]
ffffffff8f2fab48 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_newlink+0x8db/0x1c70 net/core/rtnetlink.c:4064

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (rtnl_mutex){+.+.}-{4:4}:
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5866
       __mutex_lock_common kernel/locking/mutex.c:601 [inline]
       __mutex_lock+0x182/0xe80 kernel/locking/mutex.c:746
       e1000_reset_task+0x56/0xc0 drivers/net/ethernet/intel/e1000/e1000_main.c:3512
       process_one_work kernel/workqueue.c:3238 [inline]
       process_scheduled_works+0xadb/0x17a0 kernel/workqueue.c:3319
       worker_thread+0x8a0/0xda0 kernel/workqueue.c:3400
       kthread+0x70e/0x8a0 kernel/kthread.c:464
       ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:153
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #0 ((work_completion)(&adapter->reset_task)){+.+.}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3166 [inline]
       check_prevs_add kernel/locking/lockdep.c:3285 [inline]
       validate_chain+0xb9b/0x2140 kernel/locking/lockdep.c:3909
       __lock_acquire+0xaac/0xd20 kernel/locking/lockdep.c:5235
       lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5866
       touch_work_lockdep_map kernel/workqueue.c:3922 [inline]
       start_flush_work kernel/workqueue.c:4176 [inline]
       __flush_work+0x6b8/0xbc0 kernel/workqueue.c:4208
       __cancel_work_sync+0xbe/0x110 kernel/workqueue.c:4364
       e1000_down+0x402/0x6b0 drivers/net/ethernet/intel/e1000/e1000_main.c:526
       e1000_close+0x17b/0xa10 drivers/net/ethernet/intel/e1000/e1000_main.c:1448
       __dev_close_many+0x361/0x6f0 net/core/dev.c:1702
       __dev_close net/core/dev.c:1714 [inline]
       __dev_change_flags+0x2c7/0x6d0 net/core/dev.c:9352
       netif_change_flags+0x88/0x1a0 net/core/dev.c:9417
       do_setlink+0xcb9/0x40d0 net/core/rtnetlink.c:3152
       rtnl_group_changelink net/core/rtnetlink.c:3783 [inline]
       __rtnl_newlink net/core/rtnetlink.c:3937 [inline]
       rtnl_newlink+0x149f/0x1c70 net/core/rtnetlink.c:4065
       rtnetlink_rcv_msg+0x7cc/0xb70 net/core/rtnetlink.c:6955
       netlink_rcv_skb+0x219/0x490 net/netlink/af_netlink.c:2534
       netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
       netlink_unicast+0x75b/0x8d0 net/netlink/af_netlink.c:1339
       netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1883
       sock_sendmsg_nosec net/socket.c:712 [inline]
       __sock_sendmsg+0x21c/0x270 net/socket.c:727
       ____sys_sendmsg+0x505/0x830 net/socket.c:2566
       ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2620
       __sys_sendmsg net/socket.c:2652 [inline]
       __do_sys_sendmsg net/socket.c:2657 [inline]
       __se_sys_sendmsg net/socket.c:2655 [inline]
       __x64_sys_sendmsg+0x19b/0x260 net/socket.c:2655
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xf6/0x210 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(rtnl_mutex);
                               lock((work_completion)(&adapter->reset_task));
                               lock(rtnl_mutex);
  lock((work_completion)(&adapter->reset_task));

 *** DEADLOCK ***

2 locks held by syz-executor216/5313:
 #0: ffffffff8f2fab48 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_lock net/core/rtnetlink.c:80 [inline]
 #0: ffffffff8f2fab48 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_nets_lock net/core/rtnetlink.c:341 [inline]
 #0: ffffffff8f2fab48 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_newlink+0x8db/0x1c70 net/core/rtnetlink.c:4064
 #1: ffffffff8df3dee0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #1: ffffffff8df3dee0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
 #1: ffffffff8df3dee0 (rcu_read_lock){....}-{1:3}, at: start_flush_work kernel/workqueue.c:4150 [inline]
 #1: ffffffff8df3dee0 (rcu_read_lock){....}-{1:3}, at: __flush_work+0xd2/0xbc0 kernel/workqueue.c:4208

stack backtrace:
CPU: 0 UID: 0 PID: 5313 Comm: syz-executor216 Not tainted 6.15.0-rc7-syzkaller-00144-gb1427432d3b6 #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_circular_bug+0x2ee/0x310 kernel/locking/lockdep.c:2079
 check_noncircular+0x134/0x160 kernel/locking/lockdep.c:2211
 check_prev_add kernel/locking/lockdep.c:3166 [inline]
 check_prevs_add kernel/locking/lockdep.c:3285 [inline]
 validate_chain+0xb9b/0x2140 kernel/locking/lockdep.c:3909
 __lock_acquire+0xaac/0xd20 kernel/locking/lockdep.c:5235
 lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5866
 touch_work_lockdep_map kernel/workqueue.c:3922 [inline]
 start_flush_work kernel/workqueue.c:4176 [inline]
 __flush_work+0x6b8/0xbc0 kernel/workqueue.c:4208
 __cancel_work_sync+0xbe/0x110 kernel/workqueue.c:4364
 e1000_down+0x402/0x6b0 drivers/net/ethernet/intel/e1000/e1000_main.c:526
 e1000_close+0x17b/0xa10 drivers/net/ethernet/intel/e1000/e1000_main.c:1448
 __dev_close_many+0x361/0x6f0 net/core/dev.c:1702
 __dev_close net/core/dev.c:1714 [inline]
 __dev_change_flags+0x2c7/0x6d0 net/core/dev.c:9352
 netif_change_flags+0x88/0x1a0 net/core/dev.c:9417
 do_setlink+0xcb9/0x40d0 net/core/rtnetlink.c:3152
 rtnl_group_changelink net/core/rtnetlink.c:3783 [inline]
 __rtnl_newlink net/core/rtnetlink.c:3937 [inline]
 rtnl_newlink+0x149f/0x1c70 net/core/rtnetlink.c:4065
 rtnetlink_rcv_msg+0x7cc/0xb70 net/core/rtnetlink.c:6955
 netlink_rcv_skb+0x219/0x490 net/netlink/af_netlink.c:2534
 netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
 netlink_unicast+0x75b/0x8d0 net/netlink/af_netlink.c:1339
 netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1883
 sock_sendmsg_nosec net/socket.c:712 [inline]
 __sock_sendmsg+0x21c/0x270 net/socket.c:727
 ____sys_sendmsg+0x505/0x830 net/socket.c:2566
 ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2620
 __sys_sendmsg net/socket.c:2652 [inline]
 __do_sys_sendmsg net/socket.c:2657 [inline]
 __se_sys_sendmsg net/socket.c:2655 [inline]
 __x64_sys_sendmsg+0x19b/0x260 net/socket.c:2655
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf6/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f09c1caf4a9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f09c1c47198 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f09c1d39318 RCX: 00007f09c1caf4a9
RDX: 0000000000000000 RSI: 0000200000000140 RDI: 0000000000000005
RBP: 00007f09c1d39310 R08: 0000000000000008 R09: 0000000000000000
R10: 0000000000000004 R11: 0000000000000246 R12: 00007f09c1d060ac
R13: 000000000000006e R14: 0000200000000080 R15: 0000200000000150
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

