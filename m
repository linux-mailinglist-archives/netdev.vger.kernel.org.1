Return-Path: <netdev+bounces-106439-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 996FC916562
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 12:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F35D281073
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 10:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B705E14A0BC;
	Tue, 25 Jun 2024 10:40:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFCD91474D0
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 10:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719312025; cv=none; b=rBWvKuvM7NuIZos5MiY+gqEJilZSU7IytpNE/r7FdesdmTzgW8FYSPLfF4VizlTZpujJIX5rZ8jE8OfwIUU503WTPOSES0n/EyhFUAF/ylgmKcOdTDCTX8gPOyIz9i1AWFek9GGkk07pi54mMsjfNERIzPaNpSbODODv/T+Vdko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719312025; c=relaxed/simple;
	bh=jjhsMyjBLNs167Af6fVDgk/N3EnAWClOVNHl0njYCVI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=pjzcKxgk5h0GYW+FPKy0doQwKkXK4zxCGqPGL3CKLH8tELWnqs69aIBj8SZxVJkFSivXqIshCLIePd5KnY51bE8PTYTK7FcEjeRoJHqSWx7aL3wnq37/iuA+BaH/ATfDvbBroZHk9+3aNQ2HGZyRwC6RXWGJZxL1iFqgYKEOySU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-7eb7c3b8cf8so756882839f.0
        for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 03:40:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719312023; x=1719916823;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kgK1UFS4la58AQXniOmAAEiQhzWNq/pJ7+mm67p0TCE=;
        b=UYCGCu19JK6TRWcqxyvW0BPS+xNBEY/SeFg/l/kIghzb0Wu/PSN2VwrCyLgQQHOp/y
         XxtP2FQBXftFmX8Iin8HI3C9yOJx8ZYOBkSb7FQpa+57OK+5w82nWCYWSI5eckaOZ1oy
         jqTud1AQJR7590Yd3VvpWhDnUM2rHfT1Co7cKco7MsZeMbDAg3NGqRLOSl2dNXtySPuG
         ksks9/JRbjFiKzxfILXG/0sq40EIWilum40Hc0daKkoRkKIAhxGFRuPlYy8yC0yvixtd
         l/YP5Pt5KwGTTtZfMIQzmK8sBVqcgjJXoQT8ALAf2Q9wpa263+HnEQM+/FssBEFAVU3A
         BY/A==
X-Forwarded-Encrypted: i=1; AJvYcCWnI8BEkveJvISD8cqcaUhtzk1vfP1qKHhJJ+95IjXx6BYcrG+e4ymoAhEHgYcharHItb361KgOz3gGZn0dwz5PuKochNSU
X-Gm-Message-State: AOJu0YxgXg6pg5hiWoh1oWdWDTAe3QNWldFOJE36WUKge87UfUpT25LC
	LZHCqGmmMReItcAr2AdbP21t84Vk0F+mpm5Kx6OXy/iof9cHS7cBf19HoSXwXk4PEnW05QViky1
	AFGJnDzFOrycmu2u+H8EPKUlzNDdM7yYuMu4CrynFn1ThiYagTvKo0Xc=
X-Google-Smtp-Source: AGHT+IFvedSYlmHHh9pZoEksqt4QcM/uvNnSwmGL5ce63/aO/e9CtJ2kwNTf+XxzmK7vF9QZVtnhqfwK4nCjNMf9/iXXo7jFDlyk
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8906:b0:4b9:b122:d08f with SMTP id
 8926c6da1cb9f-4b9efbea327mr234949173.6.1719312021006; Tue, 25 Jun 2024
 03:40:21 -0700 (PDT)
Date: Tue, 25 Jun 2024 03:40:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000454110061bb48619@google.com>
Subject: [syzbot] [net?] KASAN: slab-use-after-free Read in l2tp_tunnel_del_work
From: syzbot <syzbot+b471b7c936301a59745b@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    b0d3969d2b4d net: ethernet: rtsn: Add support for Renesas ..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1790b32e980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e78fc116033e0ab7
dashboard link: https://syzkaller.appspot.com/bug?extid=b471b7c936301a59745b
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14a90fb1980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/7aada183897f/disk-b0d3969d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9518258e6c30/vmlinux-b0d3969d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9d4a19845f65/bzImage-b0d3969d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b471b7c936301a59745b@syzkaller.appspotmail.com

wlan1: Created IBSS using preconfigured BSSID 50:50:50:50:50:50
wlan1: Creating new IBSS network, BSSID 50:50:50:50:50:50
==================================================================
BUG: KASAN: slab-use-after-free in l2tp_tunnel_del_work+0xe5/0x330 net/l2tp/l2tp_core.c:1334
Read of size 8 at addr ffff88801ff3c0b8 by task kworker/u8:0/11

CPU: 0 PID: 11 Comm: kworker/u8:0 Not tainted 6.10.0-rc4-syzkaller-00836-gb0d3969d2b4d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
Workqueue: l2tp l2tp_tunnel_del_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 l2tp_tunnel_del_work+0xe5/0x330 net/l2tp/l2tp_core.c:1334
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3393
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Allocated by task 5308:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:387
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 __do_kmalloc_node mm/slub.c:4122 [inline]
 __kmalloc_noprof+0x1f9/0x400 mm/slub.c:4135
 kmalloc_noprof include/linux/slab.h:664 [inline]
 kzalloc_noprof include/linux/slab.h:778 [inline]
 l2tp_session_create+0x3b/0xc20 net/l2tp/l2tp_core.c:1675
 pppol2tp_connect+0xca3/0x17a0 net/l2tp/l2tp_ppp.c:782
 __sys_connect_file net/socket.c:2049 [inline]
 __sys_connect+0x2df/0x310 net/socket.c:2066
 __do_sys_connect net/socket.c:2076 [inline]
 __se_sys_connect net/socket.c:2073 [inline]
 __x64_sys_connect+0x7a/0x90 net/socket.c:2073
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 24:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
 poison_slab_object+0xe0/0x150 mm/kasan/common.c:240
 __kasan_slab_free+0x37/0x60 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2196 [inline]
 slab_free mm/slub.c:4437 [inline]
 kfree+0x149/0x360 mm/slub.c:4558
 __sk_destruct+0x58/0x5f0 net/core/sock.c:2191
 rcu_do_batch kernel/rcu/tree.c:2535 [inline]
 rcu_core+0xafd/0x1830 kernel/rcu/tree.c:2809
 handle_softirqs+0x2c4/0x970 kernel/softirq.c:554
 run_ksoftirqd+0xca/0x130 kernel/softirq.c:928
 smpboot_thread_fn+0x544/0xa30 kernel/smpboot.c:164
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Last potentially related work creation:
 kasan_save_stack+0x3f/0x60 mm/kasan/common.c:47
 __kasan_record_aux_stack+0xac/0xc0 mm/kasan/generic.c:541
 __call_rcu_common kernel/rcu/tree.c:3072 [inline]
 call_rcu+0x167/0xa70 kernel/rcu/tree.c:3176
 pppol2tp_release+0x24b/0x350 net/l2tp/l2tp_ppp.c:457
 __sock_release net/socket.c:659 [inline]
 sock_close+0xbc/0x240 net/socket.c:1421
 __fput+0x406/0x8b0 fs/file_table.c:422
 task_work_run+0x24f/0x310 kernel/task_work.c:180
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x168/0x370 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88801ff3c000
 which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 184 bytes inside of
 freed 1024-byte region [ffff88801ff3c000, ffff88801ff3c400)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1ff38
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffefff(slab)
raw: 00fff00000000040 ffff888015041dc0 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000100010 00000001ffffefff 0000000000000000
head: 00fff00000000040 ffff888015041dc0 dead000000000122 0000000000000000
head: 0000000000000000 0000000000100010 00000001ffffefff 0000000000000000
head: 00fff00000000003 ffffea00007fce01 ffffffffffffffff 0000000000000000
head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0x1d2820(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL), pid 62, tgid 62 (kworker/u8:4), ts 170500836332, free_ts 170485857715
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1468
 prep_new_page mm/page_alloc.c:1476 [inline]
 get_page_from_freelist+0x2e43/0x2f00 mm/page_alloc.c:3420
 __alloc_pages_noprof+0x256/0x6c0 mm/page_alloc.c:4678
 __alloc_pages_node_noprof include/linux/gfp.h:269 [inline]
 alloc_pages_node_noprof include/linux/gfp.h:296 [inline]
 alloc_slab_page+0x5f/0x120 mm/slub.c:2265
 allocate_slab+0x5a/0x2f0 mm/slub.c:2428
 new_slab mm/slub.c:2481 [inline]
 ___slab_alloc+0xcd1/0x14b0 mm/slub.c:3667
 __slab_alloc+0x58/0xa0 mm/slub.c:3757
 __slab_alloc_node mm/slub.c:3810 [inline]
 slab_alloc_node mm/slub.c:3989 [inline]
 __do_kmalloc_node mm/slub.c:4121 [inline]
 kmalloc_node_track_caller_noprof+0x281/0x440 mm/slub.c:4142
 kmalloc_reserve+0x111/0x2a0 net/core/skbuff.c:597
 __alloc_skb+0x1f3/0x440 net/core/skbuff.c:666
 alloc_skb include/linux/skbuff.h:1320 [inline]
 nlmsg_new include/net/netlink.h:1015 [inline]
 inet6_rt_notify+0xdf/0x290 net/ipv6/route.c:6180
 fib6_add_rt2node net/ipv6/ip6_fib.c:1266 [inline]
 fib6_add+0x1e33/0x4430 net/ipv6/ip6_fib.c:1495
 __ip6_ins_rt net/ipv6/route.c:1314 [inline]
 ip6_ins_rt+0x106/0x170 net/ipv6/route.c:1324
 __ipv6_ifa_notify+0x5d2/0x1230 net/ipv6/addrconf.c:6267
 ipv6_ifa_notify net/ipv6/addrconf.c:6306 [inline]
 addrconf_dad_completed+0x181/0xcd0 net/ipv6/addrconf.c:4319
 addrconf_dad_work+0xdc2/0x16f0
page last free pid 5306 tgid 5306 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1088 [inline]
 free_unref_page+0xd22/0xea0 mm/page_alloc.c:2583
 discard_slab mm/slub.c:2527 [inline]
 __put_partials+0xeb/0x130 mm/slub.c:2995
 put_cpu_partial+0x17c/0x250 mm/slub.c:3070
 __slab_free+0x2ea/0x3d0 mm/slub.c:4307
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x9e/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x14f/0x170 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x23/0x80 mm/kasan/common.c:322
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3941 [inline]
 slab_alloc_node mm/slub.c:4001 [inline]
 kmem_cache_alloc_noprof+0x135/0x2a0 mm/slub.c:4008
 ptlock_alloc mm/memory.c:6444 [inline]
 ptlock_init include/linux/mm.h:2968 [inline]
 pmd_ptlock_init include/linux/mm.h:3068 [inline]
 pagetable_pmd_ctor include/linux/mm.h:3106 [inline]
 pmd_alloc_one_noprof include/asm-generic/pgalloc.h:141 [inline]
 __pmd_alloc+0x110/0x630 mm/memory.c:5925
 pmd_alloc include/linux/mm.h:2866 [inline]
 __handle_mm_fault mm/memory.c:5483 [inline]
 handle_mm_fault+0xf4c/0x1ba0 mm/memory.c:5688
 do_user_addr_fault arch/x86/mm/fault.c:1338 [inline]
 handle_page_fault arch/x86/mm/fault.c:1481 [inline]
 exc_page_fault+0x459/0x8c0 arch/x86/mm/fault.c:1539
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623

Memory state around the buggy address:
 ffff88801ff3bf80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88801ff3c000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88801ff3c080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                        ^
 ffff88801ff3c100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88801ff3c180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


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

