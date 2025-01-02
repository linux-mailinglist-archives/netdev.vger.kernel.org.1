Return-Path: <netdev+bounces-154742-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F019FFA6C
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 15:22:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E8AF1604A4
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 14:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F17E51B4247;
	Thu,  2 Jan 2025 14:21:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D631AC43A
	for <netdev@vger.kernel.org>; Thu,  2 Jan 2025 14:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735827692; cv=none; b=iS53JIawGu/kbmeyvTKcWdMn5aGvOdxYMSYKBco0BSR3j47mnn9/2RkZm6aic5ViGfuzKFP8mvMSQEdx6JB0LGHTsRkLgvNrdTEhM+84ZeP02btbmqjRRHX+2KmIDOJwPkeLZy5CCDmrmc1ThG/txu+5gyQiJoiIGu8FrQQpfPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735827692; c=relaxed/simple;
	bh=wAgJluZV/Uz96G/jZ/4x6OEMweoT0/V68M6xV7lDjwM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Fmc2W18eRtgJbYEZjjLzmvb6Elbu4Fj/ICe6gzdy9iDZb8RJfVRYtOSe2p5hTXTrt9FP0N9NQI19wFGMcehsOP9ol4QoyzqAGEfGqQlBJTdSiyqn8WKT0qsE5/XO56e2EblRRIj4178UgktwKezQkzqwf+Uo0+OkZIVEZpC/xx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3a78c40fa96so89462795ab.3
        for <netdev@vger.kernel.org>; Thu, 02 Jan 2025 06:21:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735827684; x=1736432484;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=peqcDb960nbFKFSbmKubX7LUXVPNPeMRWFbkIsGc1rQ=;
        b=ImtOE5XzhEVBgftplbXuAC8i+N8go+ZUCDZHF0tzwI7kvS/LOBnETyLcjEMqNLqAaO
         rmVoMUsn9y5XQgrS2nT70KTyzboiBXVJBUJne05YIoZ33Fc5ayx0qS4IR5Ac5qZYT8bJ
         J/j9nZxtdXXSZfrOiBdtVDXc81tCDbhRIhv94KC4pGMPhOjfT0SmHvvokeKmq79+PU+g
         iYVUMjVQ4yKvZoshtX32BPXmTfodEehq2GeHROQDJVQSmIU08llVq2oGPbpp6KUXWklI
         6CaB2iNJ+kY9P1idoU2fPhR2lVDDo2oTZ5VNLuC7cg4GMYnCYuBGNVM50PkCBHASB32N
         fPXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWaF9tQhKeOzomTY959zopar1/uqQc+VmuAfP12319tb5zPCTWrx80ttLgg5xjNyLFKQacwBYw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLVPSgcekAxrNoufhIT9jY0L+Ecm8QN+SwV4Ved+x+YRVl5iIc
	f+Fr5TxOoEUQvfW1lYVOL1y6tvYNHQiH2MULYg0HsA90hlV+Eb/mwCKpi/IE3XtZPlLPZXKlVUB
	35q85dlUdzTxSbOZ8GD4Cx3byo/o9rCuA89wLK2W6mL7cd80E4yQzk8A=
X-Google-Smtp-Source: AGHT+IFUSq2KaCvzG1Yl1gsJ0DPoSOTVer8SsVauxiC2Tvum/x0Di4TQ2C+jVhmVq6+j9l5cQtstSII1E5TqmWMl9tQpwAkWFvxr
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d02:b0:3a6:b445:dc92 with SMTP id
 e9e14a558f8ab-3c2d2568b0emr375936745ab.10.1735827684515; Thu, 02 Jan 2025
 06:21:24 -0800 (PST)
Date: Thu, 02 Jan 2025 06:21:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6776a0e4.050a0220.3a8527.0041.GAE@google.com>
Subject: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in
 mgmt_remove_adv_monitor_complete (2)
From: syzbot <syzbot+427032ea7979b6db0ffa@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    9268abe611b0 Merge branch 'net-lan969x-add-rgmii-support'
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=153c2af8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b087c24b921cdc16
dashboard link: https://syzkaller.appspot.com/bug?extid=427032ea7979b6db0ffa
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8274f60b0163/disk-9268abe6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f7b3fde537e7/vmlinux-9268abe6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/db4cccf7caae/bzImage-9268abe6.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+427032ea7979b6db0ffa@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in mgmt_remove_adv_monitor_complete+0x3b6/0x550 net/bluetooth/mgmt.c:5526
Read of size 2 at addr ffff88802a3507c0 by task kworker/u9:4/5847

CPU: 1 UID: 0 PID: 5847 Comm: kworker/u9:4 Not tainted 6.13.0-rc3-syzkaller-00762-g9268abe611b0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: hci0 hci_cmd_sync_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:489
 kasan_report+0x143/0x180 mm/kasan/report.c:602
 mgmt_remove_adv_monitor_complete+0x3b6/0x550 net/bluetooth/mgmt.c:5526
 hci_cmd_sync_work+0x280/0x400 net/bluetooth/hci_sync.c:334
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa66/0x1840 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Allocated by task 6895:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __do_kmalloc_node mm/slub.c:4298 [inline]
 __kmalloc_node_track_caller_noprof+0x28b/0x4c0 mm/slub.c:4317
 kmemdup_noprof+0x2a/0x60 mm/util.c:135
 mgmt_pending_new+0xf0/0x250 net/bluetooth/mgmt_util.c:276
 mgmt_pending_add+0x36/0x120 net/bluetooth/mgmt_util.c:296
 remove_adv_monitor+0x102/0x1b0 net/bluetooth/mgmt.c:5568
 hci_mgmt_cmd+0xc47/0x11d0 net/bluetooth/hci_sock.c:1712
 hci_sock_sendmsg+0x7b8/0x11c0 net/bluetooth/hci_sock.c:1832
 sock_sendmsg_nosec net/socket.c:711 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:726
 sock_write_iter+0x2d7/0x3f0 net/socket.c:1158
 new_sync_write fs/read_write.c:586 [inline]
 vfs_write+0xaeb/0xd30 fs/read_write.c:679
 ksys_write+0x18f/0x2b0 fs/read_write.c:731
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 6894:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:582
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x59/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2353 [inline]
 slab_free mm/slub.c:4613 [inline]
 kfree+0x196/0x430 mm/slub.c:4761
 mgmt_pending_free net/bluetooth/mgmt_util.c:308 [inline]
 mgmt_pending_remove+0x175/0x1a0 net/bluetooth/mgmt_util.c:315
 mgmt_pending_foreach+0xd1/0x130 net/bluetooth/mgmt_util.c:259
 mgmt_index_removed+0x133/0x390 net/bluetooth/mgmt.c:9483
 hci_sock_bind+0xcce/0x1150 net/bluetooth/hci_sock.c:1307
 __sys_bind_socket net/socket.c:1838 [inline]
 __sys_bind+0x1e4/0x290 net/socket.c:1869
 __do_sys_bind net/socket.c:1874 [inline]
 __se_sys_bind net/socket.c:1872 [inline]
 __x64_sys_bind+0x7a/0x90 net/socket.c:1872
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88802a3507c0
 which belongs to the cache kmalloc-8 of size 8
The buggy address is located 0 bytes inside of
 freed 8-byte region [ffff88802a3507c0, ffff88802a3507c8)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x2a350
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000000 ffff88801ac41500 ffffea0001e80e80 dead000000000002
raw: 0000000000000000 0000000080800080 00000001f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 5840, tgid 5840 (syz-executor), ts 98630915179, free_ts 98583109001
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1556
 prep_new_page mm/page_alloc.c:1564 [inline]
 get_page_from_freelist+0x365c/0x37a0 mm/page_alloc.c:3474
 __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4751
 alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2269
 alloc_slab_page+0x6a/0x110 mm/slub.c:2423
 allocate_slab+0x5a/0x2b0 mm/slub.c:2589
 new_slab mm/slub.c:2642 [inline]
 ___slab_alloc+0xc27/0x14a0 mm/slub.c:3830
 __slab_alloc+0x58/0xa0 mm/slub.c:3920
 __slab_alloc_node mm/slub.c:3995 [inline]
 slab_alloc_node mm/slub.c:4156 [inline]
 __do_kmalloc_node mm/slub.c:4297 [inline]
 __kmalloc_node_track_caller_noprof+0x2e9/0x4c0 mm/slub.c:4317
 __kmemdup_nul mm/util.c:61 [inline]
 kstrdup+0x39/0xb0 mm/util.c:81
 __kernfs_new_node+0x9d/0x870 fs/kernfs/dir.c:620
 kernfs_new_node+0x137/0x240 fs/kernfs/dir.c:700
 kernfs_create_dir_ns+0x43/0x120 fs/kernfs/dir.c:1061
 sysfs_create_dir_ns+0x189/0x3a0 fs/sysfs/dir.c:59
 create_dir lib/kobject.c:73 [inline]
 kobject_add_internal+0x435/0x8d0 lib/kobject.c:240
 kobject_add_varg lib/kobject.c:374 [inline]
 kobject_add+0x152/0x220 lib/kobject.c:426
page last free pid 1107 tgid 1107 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1127 [inline]
 free_unref_page+0xd3f/0x1010 mm/page_alloc.c:2657
 rcu_do_batch kernel/rcu/tree.c:2567 [inline]
 rcu_core+0xaaa/0x17a0 kernel/rcu/tree.c:2823
 handle_softirqs+0x2d4/0x9b0 kernel/softirq.c:561
 __do_softirq kernel/softirq.c:595 [inline]
 invoke_softirq kernel/softirq.c:435 [inline]
 __irq_exit_rcu+0xf7/0x220 kernel/softirq.c:662
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:678
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1049 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1049
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702

Memory state around the buggy address:
 ffff88802a350680: fa fc fc fc 00 fc fc fc fa fc fc fc fa fc fc fc
 ffff88802a350700: fa fc fc fc fa fc fc fc fa fc fc fc fa fc fc fc
>ffff88802a350780: fa fc fc fc fa fc fc fc fa fc fc fc fa fc fc fc
                                           ^
 ffff88802a350800: fa fc fc fc fa fc fc fc fa fc fc fc fa fc fc fc
 ffff88802a350880: fa fc fc fc fa fc fc fc fa fc fc fc fa fc fc fc
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

