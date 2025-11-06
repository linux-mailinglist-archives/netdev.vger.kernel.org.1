Return-Path: <netdev+bounces-236170-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13888C392A1
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 06:30:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62B033BB2BE
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 05:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 176022D876C;
	Thu,  6 Nov 2025 05:29:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE6E7E0E8
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 05:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762406973; cv=none; b=EwMhNslNs0+PZKmtCV0IP9XjxnhUR/a8VivKOB1SS+GGdO4FIz1OF2gYqU9SjdQDIKTViVE0FUqXGaPOY/fBo7DkYFC7yWfHHW19cAhZ1aMC28sa0nOebztloc3bVyfFA3YtuINMn+vQKxL+0cklnn6rc82burLU5cZoWbyr2oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762406973; c=relaxed/simple;
	bh=q4N/TvbmKbH4/pSotBQ6PGQkxOJDpiHPCrddPFtgQBk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=giPn6NUGQ0C8elRZkXWYtQ3exgQo8ln0PmxhmQet6HUUYMksHQxOX2+gWKWcDPM/wcQGO9yofiHjbUxPt8mtEzyf8hSyqGcl121LXiOG09vV3bR5QTltL5FTMiDMMfV5sqcRQyIFG1wQ4AbiDjTZAisnYC5xmwKD/vMsoo1JWSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-43335646758so12975ab.3
        for <netdev@vger.kernel.org>; Wed, 05 Nov 2025 21:29:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762406970; x=1763011770;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ziOa5I4IMDASLfdKdmP9rsl5ZAcwBOFR9REggp6pSwM=;
        b=DYPVtGUUMe6Lft3mlErbDznzp/fD2PT+LhnylJZYMgV6vJPBETVNDAVLdrF4bbjP0g
         2sEbVnkb4GuhS4IEge4uNrgSpLIuGmHKTNYXCenkd9x+xs2+0nyvXzZyQ/nswvaZpxBN
         S931y3RX86wicJMJFEuDY/Ua2alQWTvELqu/jiKhK+LdaINC3aEnNpkLFtig7YZYbMBk
         GJwl3rcPFkVTvJ2f44PiAMVq3An8vNDJ+R2nVOii/FyQZKEGCFYFApmpAysC4eTdgnss
         iEEIx+k8vWylbzT7Gc168wskxrMBJga9zX8BfkTlXTxq4N21xTNaC+PjEaEIDMlSzJFf
         1c9g==
X-Forwarded-Encrypted: i=1; AJvYcCXZvH9aeJRpe7gV7xSl8MsN9EMdN9IU8tupGtYqwB81RUEx8lUolw0eo8qsX0/FzMu03ANdLs0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTsrTeokpUBxmRTNHx+ujko7+c7FhmvvG/bpICf+5coc569dEY
	gZD8AQBd3uXj7kF4CLr1fS1uo+cjeUJifBPB/jiTFcJDLkUyihg9nhLsx1BVzr2+vr+gt4Pa6Fi
	Z6G5EkP0myxSt0xAYVHNTN/FgDosnZownYJQMju2ORcabZPxZc5B7rPXCAYY=
X-Google-Smtp-Source: AGHT+IHiVZiUW4vywrfksHhhgTN+pdJDs+qJGjlHsOPJ1Khc7PavjHHIkOE/DUCkURY9C70o66V1cSkCXo1ze9SGJTO0UR1s1F+z
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:178a:b0:433:3487:ea1c with SMTP id
 e9e14a558f8ab-433407e2607mr80836845ab.21.1762406970423; Wed, 05 Nov 2025
 21:29:30 -0800 (PST)
Date: Wed, 05 Nov 2025 21:29:30 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690c323a.050a0220.baf87.007f.GAE@google.com>
Subject: [syzbot] [tipc?] KASAN: slab-use-after-free Read in tipc_mon_reinit_self
From: syzbot <syzbot+d7dad7fd4b3921104957@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	jmaloy@redhat.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	tipc-discussion@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    22f20375f5b7 Merge tag 'pci-v6.17-fixes-3' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16799b12580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f5b21423ca3f0a96
dashboard link: https://syzkaller.appspot.com/bug?extid=d7dad7fd4b3921104957
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6ce5c32a21e3/disk-22f20375.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a84573ca71a7/vmlinux-22f20375.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4d073bc5b8a5/bzImage-22f20375.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d7dad7fd4b3921104957@syzkaller.appspotmail.com

tipc: Node number set to 1331188531
==================================================================
BUG: KASAN: slab-use-after-free in __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
BUG: KASAN: slab-use-after-free in _raw_spin_lock_irqsave+0xa7/0xf0 kernel/locking/spinlock.c:162
Read of size 1 at addr ffff88805eae1030 by task kworker/0:7/5989

CPU: 0 UID: 0 PID: 5989 Comm: kworker/0:7 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
Workqueue: events tipc_net_finalize_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xca/0x240 mm/kasan/report.c:482
 kasan_report+0x118/0x150 mm/kasan/report.c:595
 __kasan_check_byte+0x2a/0x40 mm/kasan/common.c:568
 kasan_check_byte include/linux/kasan.h:399 [inline]
 lock_acquire+0x8d/0x360 kernel/locking/lockdep.c:5842
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0xa7/0xf0 kernel/locking/spinlock.c:162
 rtlock_slowlock kernel/locking/rtmutex.c:1894 [inline]
 rwbase_rtmutex_lock_state kernel/locking/spinlock_rt.c:160 [inline]
 rwbase_write_lock+0xd3/0x7e0 kernel/locking/rwbase_rt.c:244
 rt_write_lock+0x76/0x110 kernel/locking/spinlock_rt.c:243
 write_lock_bh include/linux/rwlock_rt.h:99 [inline]
 tipc_mon_reinit_self+0x79/0x430 net/tipc/monitor.c:718
 tipc_net_finalize+0x115/0x190 net/tipc/net.c:140
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0xade/0x17b0 kernel/workqueue.c:3319
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3400
 kthread+0x70e/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x439/0x7d0 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Allocated by task 6089:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:388 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:405
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __kmalloc_cache_noprof+0x1a8/0x320 mm/slub.c:4407
 kmalloc_noprof include/linux/slab.h:905 [inline]
 kzalloc_noprof include/linux/slab.h:1039 [inline]
 tipc_mon_create+0xc3/0x4d0 net/tipc/monitor.c:657
 tipc_enable_bearer net/tipc/bearer.c:357 [inline]
 __tipc_nl_bearer_enable+0xe16/0x13f0 net/tipc/bearer.c:1047
 __tipc_nl_compat_doit net/tipc/netlink_compat.c:371 [inline]
 tipc_nl_compat_doit+0x3bc/0x5f0 net/tipc/netlink_compat.c:393
 tipc_nl_compat_handle net/tipc/netlink_compat.c:-1 [inline]
 tipc_nl_compat_recv+0x83c/0xbe0 net/tipc/netlink_compat.c:1321
 genl_family_rcv_msg_doit+0x215/0x300 net/netlink/genetlink.c:1115
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0x60e/0x790 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x208/0x470 net/netlink/af_netlink.c:2552
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
 netlink_unicast+0x846/0xa10 net/netlink/af_netlink.c:1346
 netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1896
 sock_sendmsg_nosec net/socket.c:714 [inline]
 __sock_sendmsg+0x21c/0x270 net/socket.c:729
 ____sys_sendmsg+0x508/0x820 net/socket.c:2614
 ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2668
 __sys_sendmsg net/socket.c:2700 [inline]
 __do_sys_sendmsg net/socket.c:2705 [inline]
 __se_sys_sendmsg net/socket.c:2703 [inline]
 __x64_sys_sendmsg+0x1a1/0x260 net/socket.c:2703
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 6088:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:576
 poison_slab_object mm/kasan/common.c:243 [inline]
 __kasan_slab_free+0x5b/0x80 mm/kasan/common.c:275
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2422 [inline]
 slab_free mm/slub.c:4695 [inline]
 kfree+0x195/0x550 mm/slub.c:4894
 tipc_l2_device_event+0x380/0x650 net/tipc/bearer.c:-1
 notifier_call_chain+0x1b3/0x3e0 kernel/notifier.c:85
 call_netdevice_notifiers_extack net/core/dev.c:2267 [inline]
 call_netdevice_notifiers net/core/dev.c:2281 [inline]
 unregister_netdevice_many_notify+0x14d7/0x1fe0 net/core/dev.c:12166
 unregister_netdevice_many net/core/dev.c:12229 [inline]
 unregister_netdevice_queue+0x33c/0x380 net/core/dev.c:12073
 unregister_netdevice include/linux/netdevice.h:3385 [inline]
 __tun_detach+0xe4d/0x1620 drivers/net/tun.c:621
 tun_detach drivers/net/tun.c:637 [inline]
 tun_chr_close+0x10d/0x1c0 drivers/net/tun.c:3433
 __fput+0x458/0xa80 fs/file_table.c:468
 task_work_run+0x1d4/0x260 kernel/task_work.c:227
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop+0xec/0x110 kernel/entry/common.c:43
 exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:175 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:210 [inline]
 do_syscall_64+0x2bd/0x3b0 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88805eae0000
 which belongs to the cache kmalloc-8k of size 8192
The buggy address is located 4144 bytes inside of
 freed 8192-byte region [ffff88805eae0000, ffff88805eae2000)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x5eae0
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0x80000000000040(head|node=0|zone=1)
page_type: f5(slab)
raw: 0080000000000040 ffff888019842280 ffffea0000f4c000 0000000000000004
raw: 0000000000000000 0000000000020002 00000000f5000000 0000000000000000
head: 0080000000000040 ffff888019842280 ffffea0000f4c000 0000000000000004
head: 0000000000000000 0000000000020002 00000000f5000000 0000000000000000
head: 0080000000000003 ffffea00017ab801 00000000ffffffff 00000000ffffffff
head: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd28c0(GFP_NOWAIT|__GFP_IO|__GFP_FS|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5852, tgid 5852 (syz-executor), ts 97738776876, free_ts 0
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x240/0x2a0 mm/page_alloc.c:1851
 prep_new_page mm/page_alloc.c:1859 [inline]
 get_page_from_freelist+0x2119/0x21b0 mm/page_alloc.c:3858
 __alloc_frozen_pages_noprof+0x181/0x370 mm/page_alloc.c:5148
 alloc_pages_mpol+0xd1/0x380 mm/mempolicy.c:2416
 alloc_slab_page mm/slub.c:2492 [inline]
 allocate_slab+0x8a/0x370 mm/slub.c:2660
 new_slab mm/slub.c:2714 [inline]
 ___slab_alloc+0x8d1/0xdc0 mm/slub.c:3901
 __slab_alloc mm/slub.c:3992 [inline]
 __slab_alloc_node mm/slub.c:4067 [inline]
 slab_alloc_node mm/slub.c:4228 [inline]
 __do_kmalloc_node mm/slub.c:4375 [inline]
 __kmalloc_node_track_caller_noprof+0x14c/0x450 mm/slub.c:4395
 kmalloc_reserve+0x136/0x290 net/core/skbuff.c:600
 __alloc_skb+0x142/0x2d0 net/core/skbuff.c:669
 alloc_skb include/linux/skbuff.h:1336 [inline]
 netlink_dump+0x167/0xe90 net/netlink/af_netlink.c:2286
 __netlink_dump_start+0x5cb/0x7e0 net/netlink/af_netlink.c:2442
 genl_family_rcv_msg_dumpit+0x1e7/0x2c0 net/netlink/genetlink.c:1076
 genl_family_rcv_msg net/netlink/genetlink.c:1192 [inline]
 genl_rcv_msg+0x5da/0x790 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x208/0x470 net/netlink/af_netlink.c:2552
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
 netlink_unicast+0x846/0xa10 net/netlink/af_netlink.c:1346
page_owner free stack trace missing

Memory state around the buggy address:
 ffff88805eae0f00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88805eae0f80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88805eae1000: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                     ^
 ffff88805eae1080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88805eae1100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


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

