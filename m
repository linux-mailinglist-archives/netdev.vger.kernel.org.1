Return-Path: <netdev+bounces-187271-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F075AA601F
	for <lists+netdev@lfdr.de>; Thu,  1 May 2025 16:38:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EFC01BC5C70
	for <lists+netdev@lfdr.de>; Thu,  1 May 2025 14:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992831F4706;
	Thu,  1 May 2025 14:38:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E171EBA1E
	for <netdev@vger.kernel.org>; Thu,  1 May 2025 14:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746110318; cv=none; b=d8BIxeAKPQbHmESf9RO5tJT6DC9yj5vvGvhv1Q0m17w7W9IgJ366O5UKA9wOYrYiuQsRzjpyczPg9HL2XbN7lMbp2D+4iK32ozYMiomMF8z25yHgXyUAEJeq4t8PYOmYQjruKArRNk8TZah5fdRfYmKraFwDibyz9/jRrfUgx1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746110318; c=relaxed/simple;
	bh=KCkjp+EpuR8S9I6wB/cD5poo1xuHeOtCrvFhXFMGsGc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=p39c3U7/zDN8ZzYmylU9zrq6GFwi8s6nTxA7vFZ2IeYA+L1cOaUPiF7lBhxCiPEi344WBt28zfmSzfvon2YINKI5sZ3a3UR/9fPjSMH9za1DZ6nlHdUSzusvZs4ZWohaOxVl+g1uHPEd0VapJ1Ub7KF/IGPO8oGchLUNgnBtRr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3d458e61faaso11419605ab.0
        for <netdev@vger.kernel.org>; Thu, 01 May 2025 07:38:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746110316; x=1746715116;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bKT3CYx5Pp/t3vJLkcUCm39fapLPEuWc8A4ri9U3ddY=;
        b=XiVWwlzsiNHMwqitqFlPbjcsAtY4jdZwSxALlWDV2yt5yu7RUbjcl9d4PdiUuLIBrN
         JaakEUQWKos5QEek4/27vDaPMC/cdLKWgBf1ZYEIhufYNGyyL9A7Gad20TQs/33S81K/
         T65dfpahEV3hjtPHmIywQEFWbLKhJw/3AoyhUEIxr2awskNdsad2Tg2UQuSDPVtyZ1lc
         kgc3hOzSwORBOhoK9chQ0wmFb+YElZPmqMzlSYgWVYEzpTDYrDysTF5dS9m1Q9u806a0
         uUmwx0nb7kOPdo7bok8hKMX6KXpG1iv99fW/dTdq4Dw+CpNurUmxCYNvCiii6fjs7UvA
         Iusg==
X-Forwarded-Encrypted: i=1; AJvYcCWVE+Hbrybw3M7RWFikPouIREV7tSI9SPyGTxM8tkWW0wrUdgvQKTT+AT+nxxCZ6/ebRp6XWvg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLFA2V3RxJuUW5U0wgtMsaSpOHR++8JJmMqJ7KUsAH+AZpE8mw
	ivdAiHcPGWsB5uFUeiEtSNf7fMiIh3jQ7yCRaRjnGLPN1ZNIE7YeJS6EtecCM7+mraSXrNWOQA+
	lcj7COyRR94gYLK4uYM7VTntQthPiCOWT+ILavXi20k2reNAMYboxZig=
X-Google-Smtp-Source: AGHT+IFW1RvcxF1W+8esYW4nnWpbjFRstR87BcxGy+Vj6deAijA+e1yU/Ssn1eDn0QZXOUSVDHXBBs/RCbKLqlT/X66vvcgUrgZa
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ce4d:0:b0:3d8:122f:9f07 with SMTP id
 e9e14a558f8ab-3d970babe0fmr26951955ab.10.1746110315769; Thu, 01 May 2025
 07:38:35 -0700 (PDT)
Date: Thu, 01 May 2025 07:38:35 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6813876b.050a0220.14dd7d.0011.GAE@google.com>
Subject: [syzbot] [batman?] KASAN: slab-use-after-free Write in batadv_forw_packet_queue
From: syzbot <syzbot+4a354e37723883878eed@syzkaller.appspotmail.com>
To: antonio@mandelbit.com, b.a.t.m.a.n@lists.open-mesh.org, 
	davem@davemloft.net, edumazet@google.com, horms@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, marek.lindner@mailbox.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, sven@narfation.org, 
	sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    4f79eaa2ceac kbuild: Properly disable -Wunterminated-strin..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11996f74580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a42a9d552788177b
dashboard link: https://syzkaller.appspot.com/bug?extid=4a354e37723883878eed
compiler:       Debian clang version 20.1.2 (++20250402124445+58df0ef89dd6-1~exp1~20250402004600.97), Debian LLD 20.1.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/822d3af2e031/disk-4f79eaa2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1a60cd781b04/vmlinux-4f79eaa2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/37d5d556e0a9/bzImage-4f79eaa2.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4a354e37723883878eed@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in hlist_add_head include/linux/list.h:1026 [inline]
BUG: KASAN: slab-use-after-free in batadv_forw_packet_queue+0x187/0x260 net/batman-adv/send.c:688
Write of size 8 at addr ffff888026fc7c08 by task kworker/u8:2/21326

CPU: 1 UID: 0 PID: 21326 Comm: kworker/u8:2 Not tainted 6.15.0-rc4-syzkaller-00052-g4f79eaa2ceac #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/19/2025
Workqueue: bat_events batadv_iv_send_outstanding_bat_ogm_packet
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:408 [inline]
 print_report+0xb4/0x290 mm/kasan/report.c:521
 kasan_report+0x118/0x150 mm/kasan/report.c:634
 hlist_add_head include/linux/list.h:1026 [inline]
 batadv_forw_packet_queue+0x187/0x260 net/batman-adv/send.c:688
 batadv_iv_ogm_schedule_buff net/batman-adv/bat_iv_ogm.c:857 [inline]
 batadv_iv_ogm_schedule+0xabd/0xea0 net/batman-adv/bat_iv_ogm.c:876
 batadv_iv_send_outstanding_bat_ogm_packet+0x6c6/0x7e0 net/batman-adv/bat_iv_ogm.c:1720
 process_one_work kernel/workqueue.c:3238 [inline]
 process_scheduled_works+0xadb/0x17a0 kernel/workqueue.c:3319
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3400
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:153
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Allocated by task 21326:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __kmalloc_cache_noprof+0x230/0x3d0 mm/slub.c:4372
 kmalloc_noprof include/linux/slab.h:905 [inline]
 batadv_forw_packet_alloc+0x1e9/0x390 net/batman-adv/send.c:519
 batadv_iv_ogm_aggregate_new net/batman-adv/bat_iv_ogm.c:571 [inline]
 batadv_iv_ogm_queue_add+0x85f/0xd30 net/batman-adv/bat_iv_ogm.c:678
 batadv_iv_ogm_schedule_buff net/batman-adv/bat_iv_ogm.c:857 [inline]
 batadv_iv_ogm_schedule+0xabd/0xea0 net/batman-adv/bat_iv_ogm.c:876
 batadv_iv_send_outstanding_bat_ogm_packet+0x6c6/0x7e0 net/batman-adv/bat_iv_ogm.c:1720
 process_one_work kernel/workqueue.c:3238 [inline]
 process_scheduled_works+0xadb/0x17a0 kernel/workqueue.c:3319
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3400
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:153
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Freed by task 21326:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:576
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x62/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2398 [inline]
 slab_free mm/slub.c:4656 [inline]
 kfree+0x193/0x440 mm/slub.c:4855
 process_one_work kernel/workqueue.c:3238 [inline]
 process_scheduled_works+0xadb/0x17a0 kernel/workqueue.c:3319
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3400
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:153
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Last potentially related work creation:
 kasan_save_stack+0x3e/0x60 mm/kasan/common.c:47
 kasan_record_aux_stack+0xbc/0xd0 mm/kasan/generic.c:548
 insert_work+0x3d/0x330 kernel/workqueue.c:2183
 __queue_work+0xbd9/0xfe0 kernel/workqueue.c:2345
 call_timer_fn+0x17b/0x5f0 kernel/time/timer.c:1789
 expire_timers kernel/time/timer.c:1835 [inline]
 __run_timers kernel/time/timer.c:2414 [inline]
 __run_timer_base+0x646/0x860 kernel/time/timer.c:2426
 run_timer_base kernel/time/timer.c:2435 [inline]
 run_timer_softirq+0xb7/0x180 kernel/time/timer.c:2445
 handle_softirqs+0x283/0x870 kernel/softirq.c:579
 __do_softirq kernel/softirq.c:613 [inline]
 invoke_softirq kernel/softirq.c:453 [inline]
 __irq_exit_rcu+0xca/0x1f0 kernel/softirq.c:680
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:696
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1049 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1049
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702

The buggy address belongs to the object at ffff888026fc7c00
 which belongs to the cache kmalloc-512 of size 512
The buggy address is located 8 bytes inside of
 freed 512-byte region [ffff888026fc7c00, ffff888026fc7e00)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x26fc4
head: order:2 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88801a041c80 dead000000000100 dead000000000122
raw: 0000000000000000 0000000000100010 00000000f5000000 0000000000000000
head: 00fff00000000040 ffff88801a041c80 dead000000000100 dead000000000122
head: 0000000000000000 0000000000100010 00000000f5000000 0000000000000000
head: 00fff00000000002 ffffea00009bf101 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000004
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 2, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 3510, tgid 3510 (kworker/u8:7), ts 186249926857, free_ts 186186911857
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1d8/0x230 mm/page_alloc.c:1718
 prep_new_page mm/page_alloc.c:1726 [inline]
 get_page_from_freelist+0x21c7/0x22a0 mm/page_alloc.c:3688
 __alloc_frozen_pages_noprof+0x181/0x370 mm/page_alloc.c:4970
 alloc_pages_mpol+0x232/0x4a0 mm/mempolicy.c:2301
 alloc_slab_page mm/slub.c:2468 [inline]
 allocate_slab+0x8a/0x3b0 mm/slub.c:2632
 new_slab mm/slub.c:2686 [inline]
 ___slab_alloc+0xbfc/0x1480 mm/slub.c:3872
 __slab_alloc mm/slub.c:3962 [inline]
 __slab_alloc_node mm/slub.c:4037 [inline]
 slab_alloc_node mm/slub.c:4198 [inline]
 __kmalloc_cache_noprof+0x296/0x3d0 mm/slub.c:4367
 kmalloc_noprof include/linux/slab.h:905 [inline]
 kzalloc_noprof include/linux/slab.h:1039 [inline]
 device_private_init drivers/base/core.c:3537 [inline]
 device_add+0xbe/0xb50 drivers/base/core.c:3588
 netdev_register_kobject+0x156/0x2f0 net/core/net-sysfs.c:2336
 register_netdevice+0x126c/0x1af0 net/core/dev.c:11009
 nsim_init_netdevsim drivers/net/netdevsim/netdev.c:960 [inline]
 nsim_create+0xb19/0xef0 drivers/net/netdevsim/netdev.c:1028
 __nsim_dev_port_add+0x70a/0xb20 drivers/net/netdevsim/dev.c:1393
 nsim_dev_port_add_all+0x35/0xe0 drivers/net/netdevsim/dev.c:1449
 nsim_dev_reload_create drivers/net/netdevsim/dev.c:1501 [inline]
 nsim_dev_reload_up+0x451/0x780 drivers/net/netdevsim/dev.c:988
 devlink_reload+0x4e9/0x8d0 net/devlink/dev.c:474
 devlink_pernet_pre_exit+0x1d9/0x3d0 net/devlink/core.c:509
page last free pid 5188 tgid 5188 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1262 [inline]
 __free_frozen_pages+0xb05/0xcd0 mm/page_alloc.c:2725
 discard_slab mm/slub.c:2730 [inline]
 __put_partials+0x161/0x1c0 mm/slub.c:3199
 put_cpu_partial+0x17c/0x250 mm/slub.c:3274
 __slab_free+0x2f7/0x400 mm/slub.c:4526
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x9a/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x148/0x160 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x22/0x80 mm/kasan/common.c:329
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4161 [inline]
 slab_alloc_node mm/slub.c:4210 [inline]
 kmem_cache_alloc_noprof+0x1c1/0x3c0 mm/slub.c:4217
 vm_area_dup+0x2b/0x5c0 kernel/fork.c:488
 dup_mmap kernel/fork.c:672 [inline]
 dup_mm kernel/fork.c:1734 [inline]
 copy_mm+0xbe1/0x2100 kernel/fork.c:1786
 copy_process+0x16d3/0x3b80 kernel/fork.c:2429
 kernel_clone+0x224/0x7f0 kernel/fork.c:2844
 __do_sys_clone kernel/fork.c:2987 [inline]
 __se_sys_clone kernel/fork.c:2971 [inline]
 __x64_sys_clone+0x18b/0x1e0 kernel/fork.c:2971
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf6/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff888026fc7b00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888026fc7b80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff888026fc7c00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                      ^
 ffff888026fc7c80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888026fc7d00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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

