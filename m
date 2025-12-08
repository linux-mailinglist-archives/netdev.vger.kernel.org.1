Return-Path: <netdev+bounces-244009-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 07811CAD3F7
	for <lists+netdev@lfdr.de>; Mon, 08 Dec 2025 14:25:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B8D90303C9FE
	for <lists+netdev@lfdr.de>; Mon,  8 Dec 2025 13:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 944D9314A9E;
	Mon,  8 Dec 2025 13:22:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f77.google.com (mail-ot1-f77.google.com [209.85.210.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47FC31064B
	for <netdev@vger.kernel.org>; Mon,  8 Dec 2025 13:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765200149; cv=none; b=dlGPIQ8zhcaQeh3lxpZbm23BIo+XK+j5RS4EYPG9GeF+bd1q8/UROBYXxDJpkA76Zy66Y15LrCm2R0uziU1U5ma1vpedVfRcyau3xuS8DvhU4gQGa38E6jvzhxFS0b4KOOu94v6ZqRmsMmW2S+FwqPdY+6dtS5HkA7HH6JMv5s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765200149; c=relaxed/simple;
	bh=LwvNHlEEbzly2jfsw9wvqvyYl9aUC9zjVNPd+NjuRjI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=PdF52wcRAiFrrbxhGJwXSxeVXPSL2RBtzWogg/L0TGa5A3ungz4jH33fFpaIoYSSv1Q9bxxn4iJkjzAzP/CagwKRnBwCWKrsuTOLbNVNXlm2u5gMtzMoB3h8xdjcXNqIiF9a0Yiu4G9v9VxWS2c3qX3Lz/fwfFCr2Rmg7szwBZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f77.google.com with SMTP id 46e09a7af769-7c705ffd76fso4549835a34.3
        for <netdev@vger.kernel.org>; Mon, 08 Dec 2025 05:22:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765200147; x=1765804947;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rqHx3EFjzs+QFhnUVxrsH5bfDA142Rrdc6lwfSdaLhI=;
        b=ZjR6GZ1ajxFEtF6+PsbcVaAOQ3LTWyoJRd6bSbFFJVwSvaC22XbFXAbax/ZU/rCtWX
         w/49/XHdE84fkviw9KV2kHfEMrCMmAqDL6TpXdXEFRD3tv5x/34LH927HgMnU3wS5rb2
         3HEVK22Yat3tCPbLs2Kes1ntjyqhEAhMpgtdnNg9SYkBMDawnV/e8lB+aUTIVULbarGT
         lmVq7zltqKaIq2Yevd5IhdvdXhV8j+MiCQPxhPeL8B+waUpOf3vJsAkvWZ1ojpWodSMu
         Pkod27a6VrAkWLpx9944Gv/zTN72RKjuFjZs658NqT//L2xjx/4VIgUT2ZXaUNiNG+p9
         vPzA==
X-Forwarded-Encrypted: i=1; AJvYcCVeec+WRR1veO0OgbhV4XaUUksfy+MFW3d5kwvHkiWKzcM7p2I/AQj7NxkqBbwsj4DGXHVkAFA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzgv8iNE+U+Y0EJcYG7bBNuZvxoM/1ZQ9Ch/wfGrUoZ4fAssWBH
	IKemsfp04ZIaV4Wcc/Q2tBBH9306m0j6r0z9oOEHUDhJvOcWIj9tdps3Rc2D+ZANh2BSb+EoMvH
	0w5w/aIsJLAOlOYO8thzSj1Lcyw+V0HU7/RX7eKcvKtV+9IsCVnPrKyjYA3Y=
X-Google-Smtp-Source: AGHT+IHHyUxNrk92oPa4wWF+2Sh28qaqJApED9KIhhjSTxHp7P6loeCFBfwEfhvqJQldaV+qE+E77rhjsEWkvbfAaBOMD0QRLf13
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:180f:b0:659:9a49:8de4 with SMTP id
 006d021491bc7-6599a95cc08mr2864268eaf.38.1765200146847; Mon, 08 Dec 2025
 05:22:26 -0800 (PST)
Date: Mon, 08 Dec 2025 05:22:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6936d112.a70a0220.38f243.00a8.GAE@google.com>
Subject: [syzbot] [net?] KASAN: invalid-free in inet_sock_destruct
From: syzbot <syzbot+ec33a1a006ed5abe7309@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    a0c3aefb08cd Merge branch '40GbE' of git://git.kernel.org/..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=104c5a58580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3c2e630e5d8a0109
dashboard link: https://syzkaller.appspot.com/bug?extid=ec33a1a006ed5abe7309
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=153eb412580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12fc317c580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0cc70b728a24/disk-a0c3aefb.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/566c56cd7834/vmlinux-a0c3aefb.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a0c05f9d1386/bzImage-a0c3aefb.xz

Bisection is inconclusive: the first bad commit could be any of:

151b98d10ef7 net: Add sk_clone().
16942cf4d3e3 sctp: Use sk_clone() in sctp_accept().

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=134067cd980000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ec33a1a006ed5abe7309@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: double-free in inet_sock_destruct+0x538/0x740 net/ipv4/af_inet.c:159
Free of addr ffff88801f3430c0 by task ksoftirqd/1/23

CPU: 1 UID: 0 PID: 23 Comm: ksoftirqd/1 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xca/0x240 mm/kasan/report.c:482
 kasan_report_invalid_free+0xea/0x110 mm/kasan/report.c:557
 check_slab_allocation+0xe1/0x130 include/linux/page-flags.h:-1
 kasan_slab_pre_free include/linux/kasan.h:198 [inline]
 slab_free_hook mm/slub.c:2484 [inline]
 slab_free mm/slub.c:6630 [inline]
 kfree+0x148/0x6d0 mm/slub.c:6837
 inet_sock_destruct+0x538/0x740 net/ipv4/af_inet.c:159
 __sk_destruct+0x89/0x660 net/core/sock.c:2350
 sock_put include/net/sock.h:1991 [inline]
 sctp_endpoint_destroy_rcu+0xa1/0xf0 net/sctp/endpointola.c:197
 rcu_do_batch kernel/rcu/tree.c:2605 [inline]
 rcu_core+0xcab/0x1770 kernel/rcu/tree.c:2861
 handle_softirqs+0x286/0x870 kernel/softirq.c:622
 run_ksoftirqd+0x9b/0x100 kernel/softirq.c:1063
 smpboot_thread_fn+0x542/0xa60 kernel/smpboot.c:160
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Allocated by task 6015:
 kasan_save_stack mm/kasan/common.c:56 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:77
 poison_kmalloc_redzone mm/kasan/common.c:400 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:417
 kasan_kmalloc include/linux/kasan.h:262 [inline]
 __do_kmalloc_node mm/slub.c:5642 [inline]
 __kmalloc_noprof+0x411/0x7f0 mm/slub.c:5654
 kmalloc_noprof include/linux/slab.h:961 [inline]
 kzalloc_noprof include/linux/slab.h:1094 [inline]
 ip_options_get+0x51/0x4c0 net/ipv4/ip_options.c:517
 do_ip_setsockopt+0x1d9b/0x2d00 net/ipv4/ip_sockglue.c:1087
 ip_setsockopt+0x66/0x110 net/ipv4/ip_sockglue.c:1417
 do_sock_setsockopt+0x17c/0x1b0 net/socket.c:2360
 __sys_setsockopt net/socket.c:2385 [inline]
 __do_sys_setsockopt net/socket.c:2391 [inline]
 __se_sys_setsockopt net/socket.c:2388 [inline]
 __x64_sys_setsockopt+0x13f/0x1b0 net/socket.c:2388
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 23:
 kasan_save_stack mm/kasan/common.c:56 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:77
 __kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:587
 kasan_save_free_info mm/kasan/kasan.h:406 [inline]
 poison_slab_object mm/kasan/common.c:252 [inline]
 __kasan_slab_free+0x5c/0x80 mm/kasan/common.c:284
 kasan_slab_free include/linux/kasan.h:234 [inline]
 slab_free_hook mm/slub.c:2539 [inline]
 slab_free mm/slub.c:6630 [inline]
 kfree+0x19a/0x6d0 mm/slub.c:6837
 inet_sock_destruct+0x538/0x740 net/ipv4/af_inet.c:159
 __sk_destruct+0x89/0x660 net/core/sock.c:2350
 sock_put include/net/sock.h:1991 [inline]
 sctp_endpoint_destroy_rcu+0xa1/0xf0 net/sctp/endpointola.c:197
 rcu_do_batch kernel/rcu/tree.c:2605 [inline]
 rcu_core+0xcab/0x1770 kernel/rcu/tree.c:2861
 handle_softirqs+0x286/0x870 kernel/softirq.c:622
 run_ksoftirqd+0x9b/0x100 kernel/softirq.c:1063
 smpboot_thread_fn+0x542/0xa60 kernel/smpboot.c:160
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

The buggy address belongs to the object at ffff88801f3430c0
 which belongs to the cache kmalloc-32 of size 32
The buggy address is located 0 bytes inside of
 32-byte region [ffff88801f3430c0, ffff88801f3430e0)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1f343
anon flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000000 ffff88801a026780 0000000000000000 dead000000000001
raw: 0000000000000000 0000000000400040 00000000f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52800(GFP_NOWAIT|__GFP_NORETRY|__GFP_COMP), pid 184, tgid 184 (kworker/u8:6), ts 6625749703, free_ts 6600992626
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x240/0x2a0 mm/page_alloc.c:1850
 prep_new_page mm/page_alloc.c:1858 [inline]
 get_page_from_freelist+0x2365/0x2440 mm/page_alloc.c:3884
 __alloc_frozen_pages_noprof+0x181/0x370 mm/page_alloc.c:5183
 alloc_pages_mpol+0x232/0x4a0 mm/mempolicy.c:2416
 alloc_slab_page mm/slub.c:3055 [inline]
 allocate_slab+0x96/0x350 mm/slub.c:3228
 new_slab mm/slub.c:3282 [inline]
 ___slab_alloc+0xe94/0x18a0 mm/slub.c:4651
 __slab_alloc+0x65/0x100 mm/slub.c:4770
 __slab_alloc_node mm/slub.c:4846 [inline]
 slab_alloc_node mm/slub.c:5268 [inline]
 __kmalloc_cache_noprof+0x411/0x6f0 mm/slub.c:5758
 kmalloc_noprof include/linux/slab.h:957 [inline]
 slab_free_hook mm/slub.c:2491 [inline]
 slab_free mm/slub.c:6630 [inline]
 kmem_cache_free+0x16f/0x690 mm/slub.c:6740
 __fput_deferred+0x227/0x390 fs/file_table.c:523
 fput_close+0x119/0x200 fs/file_table.c:585
 path_openat+0x313c/0x3830 fs/namei.c:4143
 do_filp_open+0x1fa/0x410 fs/namei.c:4161
 do_open_execat+0x135/0x560 fs/exec.c:783
 alloc_bprm+0x28/0x5c0 fs/exec.c:1410
 kernel_execve+0x9b/0x9f0 fs/exec.c:1885
page last free pid 10 tgid 10 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1394 [inline]
 __free_frozen_pages+0xbc4/0xd30 mm/page_alloc.c:2906
 vfree+0x25a/0x400 mm/vmalloc.c:3440
 delayed_vfree_work+0x55/0x80 mm/vmalloc.c:3359
 process_one_work kernel/workqueue.c:3263 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3346
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3427
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Memory state around the buggy address:
 ffff88801f342f80: 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fc fc
 ffff88801f343000: 00 00 00 fc fc fc fc fc 00 00 00 fc fc fc fc fc
>ffff88801f343080: fa fb fb fb fc fc fc fc fa fb fb fb fc fc fc fc
                                           ^
 ffff88801f343100: fa fb fb fb fc fc fc fc fa fb fb fb fc fc fc fc
 ffff88801f343180: fa fb fb fb fc fc fc fc fa fb fb fb fc fc fc fc
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

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

