Return-Path: <netdev+bounces-170378-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 161B5A48617
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 18:04:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B1231881C45
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 16:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA7E1D4335;
	Thu, 27 Feb 2025 16:59:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8440A1B4F04
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 16:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740675566; cv=none; b=HySb+7Tjhh2H83qT8Nhep1CXP2npxO2CJ9wZLGbkkj2zUPz9t/9JogEYhWrNI9QvrMOgCbwtViCnIuT/b5Otat8bioxGOXpQPR0mA3UAh5+ySGDLYU56rKfLwajYg4Q8moROMkYATiA7CPZLxCEbq5fI793aAeEEWDKFka9cN+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740675566; c=relaxed/simple;
	bh=DBrCCfmbbgOYEaHaOkBZdTP2NcHYf6u/yYmTSzwGcPw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=fZ7bBcw7NHyPNRMlp02kPk6zCglxhfHX7Fja6RwBUsL8iOSbgoreXaLBtYN21dnbqgP6qzVov2ZJee9iVJRUZQgVlJpjxiNxuhuTfljKWxgsY+Owq/PWwcf8nq/yZpcQb401V4z7ETpTCy2IOYjVwb8FiXOurRr/0/5RFUIG4DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3d2b6d933a5so10669365ab.0
        for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 08:59:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740675563; x=1741280363;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BpJtKMbB0T7y5gCWnMdvQODk6uraPTxV8/on6Hpe2hs=;
        b=k/Opk9GHZfHDgU8jc1+rj1WNZ5eUjdOGFd9fGSkxMvO4BkCOHEXMdY0lfqOi5DSqZ6
         y4V5poYEl3Nu/Mb+sKYMuZ+GF4cvX2b5AQw5ZuakQqsbvhTs271gCeML6OCU6NXNDcPL
         lWZ6hQTkqDGNSyZe4oP2ZpSMyHJWskwCbohg40fCXOvuWmgfwL0t1KeN/ycUAYdwkF0w
         HgiPFZDFx0kwt4ex6V7IJVI5oY/+8CIhrJJFQdz2Wyg97o20/h036cEvm5FcjDmOvtXf
         szxnO+J0U3DSW8jGBU2DZOeI52m4mTCVSTSoBayOX+1d68wt7BWQeLa0VHIK+84+c1b/
         QvMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUd1W8+9FBmuHW3G+68zsYaYyW10TFxt3OwSdtvype7w5mOQbDoEpYMn9tXCs0XoLkzbX5WCZA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrIJGSpk88GUzIbdcZfc81Rzvc1pqlVjen+cuFNY9H5eAyAOda
	WhGC0t92hmLy1kF6JqwsVmZuOX8Q1yClt+VX3DFTRZLKEzG1wDpDEFr4JgTI+FvKWuTVdKTTQgQ
	h4nKHHtx1/JGeM1+ZW+guO1s4koNHLW05tb+w9Ec5qCp6l/IP7zjJ+84=
X-Google-Smtp-Source: AGHT+IEHrpXbbqqqHe68AmD6V4I/G+zPsckNGkICOcFty187OMcieLTFwJH1asRqFQs8f91Xudgwv5sQH4Evnf8EQEAghHZvj/jr
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cda6:0:b0:3d3:e34b:daa0 with SMTP id
 e9e14a558f8ab-3d3e6e21079mr481485ab.1.1740675563657; Thu, 27 Feb 2025
 08:59:23 -0800 (PST)
Date: Thu, 27 Feb 2025 08:59:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67c099eb.050a0220.222324.026a.GAE@google.com>
Subject: [syzbot] [kernel?] KASAN: slab-use-after-free Read in task_work_run
From: syzbot <syzbot+aef8e425f1a85ee5ef1c@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, luto@kernel.org, netdev@vger.kernel.org, 
	peterz@infradead.org, syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    63817c771194 selftests/bpf: Test struct_ops program with _..
git tree:       bpf-next
console output: https://syzkaller.appspot.com/x/log.txt?x=13ccf498580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b7bde34acd8f53b1
dashboard link: https://syzkaller.appspot.com/bug?extid=aef8e425f1a85ee5ef1c
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12d306e4580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b31ec77253e7/disk-63817c77.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/07bea500bd9d/vmlinux-63817c77.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7a0b65578ed5/bzImage-63817c77.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+aef8e425f1a85ee5ef1c@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in task_work_run+0x22b/0x310 kernel/task_work.c:226
Read of size 8 at addr ffff888028b97a18 by task syz.4.416/7301

CPU: 1 UID: 0 PID: 7301 Comm: syz.4.416 Not tainted 6.14.0-rc3-syzkaller-g63817c771194 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:408 [inline]
 print_report+0x16e/0x5b0 mm/kasan/report.c:521
 kasan_report+0x143/0x180 mm/kasan/report.c:634
 task_work_run+0x22b/0x310 kernel/task_work.c:226
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x13f/0x340 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f489a58d169
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f489b4cf038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: fffffffffffffff2 RBX: 00007f489a7a5fa0 RCX: 00007f489a58d169
RDX: 000000110e22fff6 RSI: 00000000c004743e RDI: 0000000000000003
RBP: 00007f489a60e2a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f489a7a5fa0 R15: 00007ffe5af01388
 </TASK>

Allocated by task 7301:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:319 [inline]
 __kasan_slab_alloc+0x66/0x80 mm/kasan/common.c:345
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4115 [inline]
 slab_alloc_node mm/slub.c:4164 [inline]
 kmem_cache_alloc_node_noprof+0x1d9/0x380 mm/slub.c:4216
 perf_event_alloc+0x157/0x1e40 kernel/events/core.c:12240
 __do_sys_perf_event_open kernel/events/core.c:12875 [inline]
 __se_sys_perf_event_open+0xa5d/0x34b0 kernel/events/core.c:12765
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 24:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:576
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x59/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2353 [inline]
 slab_free mm/slub.c:4609 [inline]
 kmem_cache_free+0x195/0x410 mm/slub.c:4711
 rcu_do_batch kernel/rcu/tree.c:2546 [inline]
 rcu_core+0xaaa/0x17a0 kernel/rcu/tree.c:2802
 handle_softirqs+0x2d4/0x9b0 kernel/softirq.c:561
 run_ksoftirqd+0xca/0x130 kernel/softirq.c:950
 smpboot_thread_fn+0x544/0xa30 kernel/smpboot.c:164
 kthread+0x7a9/0x920 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Last potentially related work creation:
 kasan_save_stack+0x3f/0x60 mm/kasan/common.c:47
 kasan_record_aux_stack+0xaa/0xc0 mm/kasan/generic.c:548
 task_work_add+0xb8/0x450 kernel/task_work.c:65
 __perf_event_overflow+0x78d/0xdc0 kernel/events/core.c:9945
 perf_swevent_event+0x317/0x680
 do_perf_sw_event kernel/events/core.c:10185 [inline]
 ___perf_sw_event+0x4f3/0x730 kernel/events/core.c:10212
 __perf_sw_event+0xff/0x1b0 kernel/events/core.c:10224
 perf_sw_event include/linux/perf_event.h:1503 [inline]
 do_user_addr_fault arch/x86/mm/fault.c:1284 [inline]
 handle_page_fault arch/x86/mm/fault.c:1480 [inline]
 exc_page_fault+0x710/0x8b0 arch/x86/mm/fault.c:1538
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623

The buggy address belongs to the object at ffff888028b97590
 which belongs to the cache perf_event of size 1456
The buggy address is located 1160 bytes inside of
 freed 1456-byte region [ffff888028b97590, ffff888028b97b40)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x28b90
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88801b091500 ffffea0001f63400 dead000000000002
raw: 0000000000000000 0000000080140014 00000000f5000000 0000000000000000
head: 00fff00000000040 ffff88801b091500 ffffea0001f63400 dead000000000002
head: 0000000000000000 0000000080140014 00000000f5000000 0000000000000000
head: 00fff00000000003 ffffea0000a2e401 ffffffffffffffff 0000000000000000
head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 6118, tgid 6115 (syz.1.31), ts 147556510632, free_ts 147513456959
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f4/0x240 mm/page_alloc.c:1551
 prep_new_page mm/page_alloc.c:1559 [inline]
 get_page_from_freelist+0x365c/0x37a0 mm/page_alloc.c:3477
 __alloc_frozen_pages_noprof+0x292/0x710 mm/page_alloc.c:4739
 alloc_pages_mpol+0x311/0x660 mm/mempolicy.c:2270
 alloc_slab_page mm/slub.c:2423 [inline]
 allocate_slab+0x8f/0x3a0 mm/slub.c:2587
 new_slab mm/slub.c:2640 [inline]
 ___slab_alloc+0xc27/0x14a0 mm/slub.c:3826
 __slab_alloc+0x58/0xa0 mm/slub.c:3916
 __slab_alloc_node mm/slub.c:3991 [inline]
 slab_alloc_node mm/slub.c:4152 [inline]
 kmem_cache_alloc_node_noprof+0x269/0x380 mm/slub.c:4216
 perf_event_alloc+0x157/0x1e40 kernel/events/core.c:12240
 __do_sys_perf_event_open kernel/events/core.c:12875 [inline]
 __se_sys_perf_event_open+0xa5d/0x34b0 kernel/events/core.c:12765
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 5968 tgid 5968 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1127 [inline]
 free_frozen_pages+0xe0d/0x10e0 mm/page_alloc.c:2660
 discard_slab mm/slub.c:2684 [inline]
 __put_partials+0x160/0x1c0 mm/slub.c:3153
 put_cpu_partial+0x17c/0x250 mm/slub.c:3228
 __slab_free+0x290/0x380 mm/slub.c:4479
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x9a/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x14f/0x170 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x23/0x80 mm/kasan/common.c:329
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4115 [inline]
 slab_alloc_node mm/slub.c:4164 [inline]
 kmem_cache_alloc_noprof+0x1d9/0x380 mm/slub.c:4171
 getname_kernel+0x59/0x2f0 fs/namei.c:250
 kern_path+0x1d/0x50 fs/namei.c:2772
 do_loopback+0xc9/0x4f0 fs/namespace.c:2817
 do_mount fs/namespace.c:3900 [inline]
 __do_sys_mount fs/namespace.c:4111 [inline]
 __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:4088
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff888028b97900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888028b97980: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888028b97a00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                            ^
 ffff888028b97a80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888028b97b00: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
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

