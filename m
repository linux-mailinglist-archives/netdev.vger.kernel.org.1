Return-Path: <netdev+bounces-112734-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A0D93AE36
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 10:59:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A5B81F22B68
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 08:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B89D414F9E6;
	Wed, 24 Jul 2024 08:59:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F005414F11E
	for <netdev@vger.kernel.org>; Wed, 24 Jul 2024 08:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721811562; cv=none; b=I2FYog7rQBY9e+XLKdWluNAOTMo4ll+CcpR2EH2LMrpT1GOheRNbxj7FlAg5oVauzNw33oZU0KruzYdceR+rU338GC2tQTHZiqNfIGgYS7Ux6N+OhoRfeClugjfMOYwGtovc2ylVojiH1RUtewBz1siBBpDjn8/B3vVFONPEu1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721811562; c=relaxed/simple;
	bh=GLVAF4ULstnW84fgSz/a5YmLZn8B2hFhVEbftkKjmLY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=CYyLxkaDytqfKra/+GfxK0Hy4LHiWQJ0sbl3+tJHj7DQIn9TSBIu2h+OZqy20eswJxxLVcjBdS9UkSgjmPpMLGnV6bsif4s6JCfpaFccVUkD37Ty+vTD4pE7sIbK2DP/pbap4G5fFHRQ7MWlMj51el98+uWLrVmP4/XlkvsYv+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7fba8d323f9so1072945339f.3
        for <netdev@vger.kernel.org>; Wed, 24 Jul 2024 01:59:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721811560; x=1722416360;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t1Fhw1S5C/O8PQznzsd5xFoGs3e7zPVK3lIN9xy59Gg=;
        b=OWJ8vblvs0IwPZHQNiqXjcKIj81cHEe3CavEJQvK0ZnsKmhWbhPcDN+D3mNvSkne1T
         TXbxeXtaLwF0ccpzSb+Mir51uhZgzrUt0pa1ACd7Nu9K3XBiq+SSjcSrK0w28l3iwFVh
         aWota08/i7hBB3IeQxxSaWUEHeL5pFfP+VHO4q96q2fwu51Qe8vJ3A/l0ATXZITsFo6b
         dZuINCQ7V7UkGF0nLRxgk3DHSPzc6VfGOU0+tN0FfF5QRfMt2ImkKOcw0gqjwYgIb3zq
         SOMN0FWNHsL4KTA1OM2qQih417nVsLby7oHqaEvNYJ2tF9JjJm8ZHsukn52t/V6yBRU0
         fwjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQqDOnRWx3f3edL7NHZfeHJ/uRnxpBbH8Cw7mycOqV7DTSfmU/JdsgnkSmxAcPiede8x43AusNxxjeccgQo8WH0hZueRrh
X-Gm-Message-State: AOJu0Yxkp4QBpG1U/13rLCHH/Ab0q691IoIE2oMc0yYaHTYUha3MQjQu
	0G4buT0m3lidbcIVXkq2KUgfAjHZdEeeLZU9+alji8pb4OILYT4pJr2Wnabi2JHlZIl1bxE71i8
	O27d3+ssDxAGYIYxUypnHy/kI2Iwz4c5OsYze0O1MFnBzau+6LbdL4Jg=
X-Google-Smtp-Source: AGHT+IGS95Of6P/5SNVM7r/fixVYTKcZ0WZU0y3HY5v/j+f/3C8HApgdJ72qGOjIYs4vAegOfPuSfiOXh+BSgKA6ekJ7DFVu2Isk
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8412:b0:4c1:4388:46bb with SMTP id
 8926c6da1cb9f-4c289e08bd8mr160215173.0.1721811560133; Wed, 24 Jul 2024
 01:59:20 -0700 (PDT)
Date: Wed, 24 Jul 2024 01:59:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000069859c061dfa7e91@google.com>
Subject: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in mgmt_remove_adv_monitor_sync
From: syzbot <syzbot+479aff51bb361ef5aa18@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d7e78951a8b8 Merge tag 'net-6.11-rc0' of git://git.kernel...
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=126a9fc3980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8d1cf7c29e32ce12
dashboard link: https://syzkaller.appspot.com/bug?extid=479aff51bb361ef5aa18
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3c208b51873e/disk-d7e78951.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/adec146cf41c/vmlinux-d7e78951.xz
kernel image: https://storage.googleapis.com/syzbot-assets/52f09b8f7356/bzImage-d7e78951.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+479aff51bb361ef5aa18@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in mgmt_remove_adv_monitor_sync+0x3a/0xd0 net/bluetooth/mgmt.c:5444
Read of size 8 at addr ffff88802aac0f18 by task kworker/u9:0/54

CPU: 0 PID: 54 Comm: kworker/u9:0 Not tainted 6.10.0-syzkaller-09703-gd7e78951a8b8 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
Workqueue: hci0 hci_cmd_sync_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 mgmt_remove_adv_monitor_sync+0x3a/0xd0 net/bluetooth/mgmt.c:5444
 hci_cmd_sync_work+0x22b/0x400 net/bluetooth/hci_sync.c:328
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
 worker_thread+0x86d/0xd40 kernel/workqueue.c:3390
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Allocated by task 7112:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:387
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 __kmalloc_cache_noprof+0x19c/0x2c0 mm/slub.c:4180
 kmalloc_noprof include/linux/slab.h:681 [inline]
 kzalloc_noprof include/linux/slab.h:807 [inline]
 mgmt_pending_new+0x65/0x250 net/bluetooth/mgmt_util.c:269
 mgmt_pending_add+0x36/0x120 net/bluetooth/mgmt_util.c:296
 remove_adv_monitor+0x102/0x1b0 net/bluetooth/mgmt.c:5469
 hci_mgmt_cmd+0xc47/0x11d0 net/bluetooth/hci_sock.c:1712
 hci_sock_sendmsg+0x7b8/0x11c0 net/bluetooth/hci_sock.c:1832
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:745
 sock_write_iter+0x2dd/0x400 net/socket.c:1160
 new_sync_write fs/read_write.c:497 [inline]
 vfs_write+0xa72/0xc90 fs/read_write.c:590
 ksys_write+0x1a0/0x2c0 fs/read_write.c:643
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 7179:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
 poison_slab_object+0xe0/0x150 mm/kasan/common.c:240
 __kasan_slab_free+0x37/0x60 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2235 [inline]
 slab_free mm/slub.c:4464 [inline]
 kfree+0x149/0x360 mm/slub.c:4585
 mgmt_pending_foreach+0xd1/0x130 net/bluetooth/mgmt_util.c:259
 __mgmt_power_off+0x187/0x420 net/bluetooth/mgmt.c:9458
 hci_dev_close_sync+0x665/0x11a0 net/bluetooth/hci_sync.c:5118
 hci_dev_do_close net/bluetooth/hci_core.c:490 [inline]
 hci_dev_close+0x112/0x210 net/bluetooth/hci_core.c:515
 sock_do_ioctl+0x158/0x460 net/socket.c:1222
 sock_ioctl+0x629/0x8e0 net/socket.c:1341
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88802aac0f00
 which belongs to the cache kmalloc-96 of size 96
The buggy address is located 24 bytes inside of
 freed 96-byte region [ffff88802aac0f00, ffff88802aac0f60)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff88802aac0b80 pfn:0x2aac0
flags: 0xfff00000000200(workingset|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffefff(slab)
raw: 00fff00000000200 ffff888015041280 ffffea00007c85d0 ffffea0001a17590
raw: ffff88802aac0b80 000000000020000a 00000001ffffefff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x352800(GFP_NOWAIT|__GFP_NORETRY|__GFP_COMP|__GFP_HARDWALL|__GFP_THISNODE), pid 5330, tgid 5329 (syz.3.37), ts 87033405855, free_ts 86894920419
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1473
 prep_new_page mm/page_alloc.c:1481 [inline]
 get_page_from_freelist+0x2e4c/0x2f10 mm/page_alloc.c:3425
 __alloc_pages_noprof+0x256/0x6c0 mm/page_alloc.c:4683
 __alloc_pages_node_noprof include/linux/gfp.h:269 [inline]
 alloc_pages_node_noprof include/linux/gfp.h:296 [inline]
 alloc_slab_page+0x5f/0x120 mm/slub.c:2304
 allocate_slab+0x5a/0x2f0 mm/slub.c:2467
 new_slab mm/slub.c:2520 [inline]
 ___slab_alloc+0xcd1/0x14b0 mm/slub.c:3706
 __slab_alloc+0x58/0xa0 mm/slub.c:3796
 __slab_alloc_node mm/slub.c:3849 [inline]
 slab_alloc_node mm/slub.c:4016 [inline]
 __do_kmalloc_node mm/slub.c:4148 [inline]
 __kmalloc_node_noprof+0x286/0x440 mm/slub.c:4155
 kmalloc_array_node_noprof include/linux/slab.h:788 [inline]
 alloc_slab_obj_exts mm/slub.c:1959 [inline]
 account_slab mm/slub.c:2430 [inline]
 allocate_slab+0xb6/0x2f0 mm/slub.c:2485
 new_slab mm/slub.c:2520 [inline]
 ___slab_alloc+0xcd1/0x14b0 mm/slub.c:3706
 __slab_alloc+0x58/0xa0 mm/slub.c:3796
 __slab_alloc_node mm/slub.c:3849 [inline]
 slab_alloc_node mm/slub.c:4016 [inline]
 kmem_cache_alloc_noprof+0x1c1/0x2a0 mm/slub.c:4035
 sk_prot_alloc+0x58/0x210 net/core/sock.c:2090
 sk_alloc+0x38/0x370 net/core/sock.c:2149
 inet_create+0x652/0xe70 net/ipv4/af_inet.c:326
 __sock_create+0x490/0x920 net/socket.c:1571
page last free pid 5318 tgid 5318 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1093 [inline]
 free_unref_folios+0xf23/0x19e0 mm/page_alloc.c:2637
 folios_put_refs+0x93a/0xa60 mm/swap.c:1024
 free_pages_and_swap_cache+0x5c8/0x690 mm/swap_state.c:332
 __tlb_batch_free_encoded_pages mm/mmu_gather.c:136 [inline]
 tlb_batch_pages_flush mm/mmu_gather.c:149 [inline]
 tlb_flush_mmu_free mm/mmu_gather.c:366 [inline]
 tlb_flush_mmu+0x3a3/0x680 mm/mmu_gather.c:373
 tlb_finish_mmu+0xd4/0x200 mm/mmu_gather.c:465
 exit_mmap+0x44f/0xc80 mm/mmap.c:3354
 __mmput+0x115/0x390 kernel/fork.c:1343
 exit_mm+0x220/0x310 kernel/exit.c:566
 do_exit+0x9b2/0x27f0 kernel/exit.c:864
 do_group_exit+0x207/0x2c0 kernel/exit.c:1026
 __do_sys_exit_group kernel/exit.c:1037 [inline]
 __se_sys_exit_group kernel/exit.c:1035 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1035
 x64_sys_call+0x26c3/0x26d0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff88802aac0e00: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
 ffff88802aac0e80: 00 00 00 00 00 00 00 00 00 00 00 00 fc fc fc fc
>ffff88802aac0f00: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
                            ^
 ffff88802aac0f80: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
 ffff88802aac1000: 04 fc fc fc 04 fc fc fc 04 fc fc fc 04 fc fc fc
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

