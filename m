Return-Path: <netdev+bounces-211663-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E344B1B08C
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 10:58:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EEB33A3DFE
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 08:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC242258CF0;
	Tue,  5 Aug 2025 08:58:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D08F257AC6
	for <netdev@vger.kernel.org>; Tue,  5 Aug 2025 08:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754384315; cv=none; b=C4cEAgdnNw6JlMUHgfRU+zp8zklB8tHr+q5D+uF+qkUuikWzWLpdXY1lsQB5OxkrPSiKMlm/A02X38UMfLcpJ/QSqG8mhWmI2ys7N/57KKSBsDk2n/t2b9I9EoV1RDivrYBRhrdM3VFw5gq4pwPVxkFgS/cMqVJVrt0sgycu0dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754384315; c=relaxed/simple;
	bh=ROU4usAY7FLO4IEUuf/j0jcf3HhoyxppnIrnbW9Gg4E=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=dtb7xe2//8V3dXfqaDBHdSkRXbhPj33/H+pmOJYx2X++diYW74UoZQ2hOPnJoqcdYs/BqPXiP6idFCaZQH7CuRzqzBhQpJQsXehJUnQmfmZ+lDHC/NCqNhJ1g07WVHextlPzyoZA9X5//1P9UIUE6vUi6Heu2O+qxMubyUMmsm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-87c1c2a4f9dso946871439f.2
        for <netdev@vger.kernel.org>; Tue, 05 Aug 2025 01:58:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754384312; x=1754989112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l1WNoAj0DpZzqc24ya6V8dghZm6KdpNb3dMMcndP+Qo=;
        b=aCoTG4lHReTGphfyQlQmChwKhrtpt0RfKKXiyscuJcbi770iD63apVrpSNHDeeNrbP
         W0n1096JzBkD+k9i5stvtmfMGDLup36+zRd/HCBPNL0+fF/tb0fZnbqV2fA8yqRjSLY5
         MYMUCx50REQ5/oAPXmfAIMJQFoyEBA9CHfGnruITWUBUR+CteuOQ77+dSh1VxlS0Iqed
         gOb224kE7FZtuRFT944sRODipr+YM9jJv/WDq2EPrczJV+tEHDupDWSVaUoo5vdfmTMx
         ny5LWs/lAcIQHYutgiaAcK1J/7KhEyp4gYbEVRGPYVkfOJAmibKCz7gMhjEomQRanoqw
         cg8A==
X-Forwarded-Encrypted: i=1; AJvYcCVeQhwCo47CGSI/CT52vz1sbxMSk8dQxORt1a5RwY8+njxu55JLD8YyGHgnIB46KWgszbET9Ck=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJbDZSKF9058PXTRdiRbblNK4cfAY7gDEGNMypuhg1EI1Ok3XE
	g5BsqJINLVW+BXfMKil6Mbsq6FNHz07HF+e+PgS1hQVIvUl4Ev/iDlUhFneVXnwmPnuZui47/Bh
	0btoJw8F48IETLm4pgDi2yN7Hp5v8vKhLhQjakP8UoGSGw28/RRveCbwn958=
X-Google-Smtp-Source: AGHT+IFodmuJvtVjyVs52g4C10q8nTRHjv7OPiVkaIHbKXtYdeEhfRV8PP5epOXl5W2U5ZYRS4Pif1KtqJX7qOnNnnccBhtH8Peu
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2b89:b0:881:7c17:ef2b with SMTP id
 ca18e2360f4ac-8817c17f0abmr1355865739f.6.1754384312221; Tue, 05 Aug 2025
 01:58:32 -0700 (PDT)
Date: Tue, 05 Aug 2025 01:58:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6891c7b8.050a0220.7f033.001f.GAE@google.com>
Subject: [syzbot] [perf?] KASAN: slab-use-after-free Read in __task_pid_nr_ns
From: syzbot <syzbot+e0378d4f4fe57aa2bdd0@syzkaller.appspotmail.com>
To: acme@kernel.org, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, irogers@google.com, jolsa@kernel.org, 
	kan.liang@linux.intel.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mark.rutland@arm.com, mingo@redhat.com, 
	namhyung@kernel.org, netdev@vger.kernel.org, peterz@infradead.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    e8d780dcd957 Merge tag 'slab-for-6.17' of git://git.kernel..
git tree:       bpf-next
console output: https://syzkaller.appspot.com/x/log.txt?x=12392f82580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=287afdea79829fda
dashboard link: https://syzkaller.appspot.com/bug?extid=e0378d4f4fe57aa2bdd0
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5aa4922d60a2/disk-e8d780dc.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f92a03738fad/vmlinux-e8d780dc.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ac22ca9f709f/bzImage-e8d780dc.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e0378d4f4fe57aa2bdd0@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in __task_pid_nr_ns+0x1da/0x470 kernel/pid.c:517
Read of size 8 at addr ffff888066bbaa28 by task syz.5.936/10344

CPU: 0 UID: 0 PID: 10344 Comm: syz.5.936 Not tainted 6.16.0-syzkaller-ge8d780dcd957 #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xca/0x240 mm/kasan/report.c:482
 kasan_report+0x118/0x150 mm/kasan/report.c:595
 __task_pid_nr_ns+0x1da/0x470 kernel/pid.c:517
 perf_event_pid_type kernel/events/core.c:1431 [inline]
 perf_event_pid kernel/events/core.c:1440 [inline]
 perf_event_read_event kernel/events/core.c:8519 [inline]
 sync_child_event kernel/events/core.c:13962 [inline]
 perf_child_detach kernel/events/core.c:2339 [inline]
 __perf_remove_from_context+0x22e5/0x2a80 kernel/events/core.c:2510
 perf_remove_from_context+0x152/0x1d0 kernel/events/core.c:2559
 perf_event_release_kernel+0x2dd/0x510 kernel/events/core.c:5837
 perf_release+0x38/0x50 kernel/events/core.c:5870
 __fput+0x449/0xa70 fs/file_table.c:468
 task_work_run+0x1d1/0x260 kernel/task_work.c:227
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop+0xec/0x110 kernel/entry/common.c:43
 exit_to_user_mode_prepare include/linux/irq-entry-common.h:208 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:175 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:210 [inline]
 do_syscall_64+0x2bd/0x3b0 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f1fae18eb69
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff16a52328 EFLAGS: 00000246 ORIG_RAX: 00000000000001b4
RAX: 0000000000000000 RBX: 00007f1fae3b7ba0 RCX: 00007f1fae18eb69
RDX: 0000000000000000 RSI: 000000000000001e RDI: 0000000000000003
RBP: 00007f1fae3b7ba0 R08: 0000000000000200 R09: 0000001d16a5261f
R10: 00007f1fae3b7ac0 R11: 0000000000000246 R12: 000000000005b884
R13: 00007f1fae3b6320 R14: ffffffffffffffff R15: 00007fff16a52440
 </TASK>

Allocated by task 10345:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:319 [inline]
 __kasan_slab_alloc+0x6c/0x80 mm/kasan/common.c:345
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4179 [inline]
 slab_alloc_node mm/slub.c:4228 [inline]
 kmem_cache_alloc_noprof+0x1c1/0x3c0 mm/slub.c:4235
 copy_signal+0x50/0x630 kernel/fork.c:1651
 copy_process+0x16a6/0x3c00 kernel/fork.c:2169
 kernel_clone+0x21e/0x840 kernel/fork.c:2602
 __do_sys_clone kernel/fork.c:2745 [inline]
 __se_sys_clone kernel/fork.c:2729 [inline]
 __x64_sys_clone+0x18b/0x1e0 kernel/fork.c:2729
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 10345:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:576
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x62/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2416 [inline]
 slab_free mm/slub.c:4679 [inline]
 kmem_cache_free+0x18f/0x400 mm/slub.c:4781
 copy_process+0x2953/0x3c00 kernel/fork.c:2455
 kernel_clone+0x21e/0x840 kernel/fork.c:2602
 __do_sys_clone kernel/fork.c:2745 [inline]
 __se_sys_clone kernel/fork.c:2729 [inline]
 __x64_sys_clone+0x18b/0x1e0 kernel/fork.c:2729
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888066bba880
 which belongs to the cache signal_cache of size 1544
The buggy address is located 424 bytes inside of
 freed 1544-byte region [ffff888066bba880, ffff888066bbae88)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x66bb8
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
memcg:ffff88807df50c01
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88801b6dd780 ffffea00009cb000 dead000000000002
raw: 0000000000000000 0000000080120012 00000000f5000000 ffff88807df50c01
head: 00fff00000000040 ffff88801b6dd780 ffffea00009cb000 dead000000000002
head: 0000000000000000 0000000080120012 00000000f5000000 ffff88807df50c01
head: 00fff00000000003 ffffea00019aee01 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5203, tgid 5203 (S02sysctl), ts 31817104133, free_ts 28252177307
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x240/0x2a0 mm/page_alloc.c:1704
 prep_new_page mm/page_alloc.c:1712 [inline]
 get_page_from_freelist+0x21e4/0x22c0 mm/page_alloc.c:3669
 __alloc_frozen_pages_noprof+0x181/0x370 mm/page_alloc.c:4959
 alloc_pages_mpol+0x232/0x4a0 mm/mempolicy.c:2419
 alloc_slab_page mm/slub.c:2486 [inline]
 allocate_slab+0x8a/0x370 mm/slub.c:2654
 new_slab mm/slub.c:2708 [inline]
 ___slab_alloc+0xbeb/0x1410 mm/slub.c:3890
 __slab_alloc mm/slub.c:3980 [inline]
 __slab_alloc_node mm/slub.c:4055 [inline]
 slab_alloc_node mm/slub.c:4216 [inline]
 kmem_cache_alloc_noprof+0x283/0x3c0 mm/slub.c:4235
 copy_signal+0x50/0x630 kernel/fork.c:1651
 copy_process+0x16a6/0x3c00 kernel/fork.c:2169
 kernel_clone+0x21e/0x840 kernel/fork.c:2602
 __do_sys_clone kernel/fork.c:2745 [inline]
 __se_sys_clone kernel/fork.c:2729 [inline]
 __x64_sys_clone+0x18b/0x1e0 kernel/fork.c:2729
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 1 tgid 1 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1248 [inline]
 __free_frozen_pages+0xc71/0xe70 mm/page_alloc.c:2706
 __free_pages mm/page_alloc.c:5071 [inline]
 free_contig_range+0x1bd/0x4a0 mm/page_alloc.c:6927
 destroy_args+0x64/0x4a0 mm/debug_vm_pgtable.c:1009
 debug_vm_pgtable+0x3a7/0x3e0 mm/debug_vm_pgtable.c:1389
 do_one_initcall+0x233/0x820 init/main.c:1269
 do_initcall_level+0x104/0x190 init/main.c:1331
 do_initcalls+0x59/0xa0 init/main.c:1347
 kernel_init_freeable+0x334/0x4a0 init/main.c:1579
 kernel_init+0x1d/0x1d0 init/main.c:1469
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Memory state around the buggy address:
 ffff888066bba900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888066bba980: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888066bbaa00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                  ^
 ffff888066bbaa80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888066bbab00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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

