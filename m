Return-Path: <netdev+bounces-147297-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E4C9D8F62
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 01:01:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 056AA28B40B
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 00:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A11137E;
	Tue, 26 Nov 2024 00:01:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768F78F54
	for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 00:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732579289; cv=none; b=sbMmISIyPXqM94tl2qQ4xupCLGFhICIV2uJpKJjNFku4XogMl/Ek5xSdbweRc0M4CjFxXpI+Ynv9y/3USYQHc/kacCR/sZvQNoYXd36sJ7EL3R+WTzQs9x6+6bBkUnes5qscXrGZJHzg/PsU5UNfoEZXRftBIv9dc6plXeANqqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732579289; c=relaxed/simple;
	bh=jOmfmEhU2//Y8plVeEljf2m1+w/1KRnjdY3TyB1zC/A=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=bGtWIZt5oCHdn2ekBd1sCeh28IOxlcekT2/81RsmHRlEGHgANbKjtBq6aNgK92kRTsDXS5jTN9qmJgM3emCIHsYvHHwq9OuOpzX4yY6ZW0SAujRsLMz8sILM21UVD3FitE/x3zaFKkCKvAhMZ2tCLyvnZMLxcoMLrZakEUBazEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a787d32003so54431965ab.0
        for <netdev@vger.kernel.org>; Mon, 25 Nov 2024 16:01:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732579286; x=1733184086;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KIimD9eD/DtDuAmM7rcqWJs5/3GgUag+Qnp8PB9ghck=;
        b=GuKWiRph58QEUff2p8pWNFQqwWyPyalTPs0kxkI4+vJNJVM+BaqX1amVEwCjLm6D/2
         ldMSdp3+J9MU2ajg/otS5GzLqLiqu0BISZofrybIxYNKV/hvCVzd6vS5xmBETA5g7ETs
         rq6Aw4FpXIkVdS1hQPKn53D8ZXK54WBmBaHFVCpIBiuwOSqBsa6hm32BDjxgczuCoJ61
         0eW0THsO4LUdLeqdTEhShabN8mhYBLDdU8aFQOVBHXNmUNKMkIfVn2o9twv2RJXbUlMk
         qDuBe68aE4BGxP9K7t2pEf5a7LAmeQYsWqvA6nraciT1L9AjPbEZjIb0FuEi/uxHDEzw
         Rvzw==
X-Forwarded-Encrypted: i=1; AJvYcCVFsOehjeFylB95aNNxfHt3EsavyQTYxc0K3B+hFUUhhI+hWaU4+LpHzd+8DBHJMiC09fPVrhc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwK0Pz0eo1h62qvocXIG4eXkpzTnx4lbU5uDKLH4ZnnVCo1ds1c
	55/+1tRIGaHgz032++SsF5jDjqq+aajJo0Mi16DSMpCogO+OYjzpkltbSLnBce6ddT5qTFcZ0w8
	A7mR4nBN2CW5yOawNBkfa1SZOIJMnXJUIzLTNPnS/rN/bPPKGuyw6+RI=
X-Google-Smtp-Source: AGHT+IHiGq+TgRoo8mnqwothkMoLrUo5dHf1Bsw2oL5U9gSmh+xSTt5gw1tqTw4WT9eSrdlT0LBE4Jyktjxrp8AtytwHcOwleDaD
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a03:b0:3a7:6f5a:e5ce with SMTP id
 e9e14a558f8ab-3a79acfd53emr181996585ab.3.1732579285237; Mon, 25 Nov 2024
 16:01:25 -0800 (PST)
Date: Mon, 25 Nov 2024 16:01:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67450fd5.050a0220.1286eb.0008.GAE@google.com>
Subject: [syzbot] [kernel?] KASAN: slab-use-after-free Read in process_scheduled_works
From: syzbot <syzbot+06abfac864b72aafabe9@syzkaller.appspotmail.com>
To: bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	linux-kernel@vger.kernel.org, mingo@redhat.com, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    66418447d27b Merge branch 'bpf-fix-recursive-lock-and-add-..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=15989930580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d2aeec8c0b2e420c
dashboard link: https://syzkaller.appspot.com/bug?extid=06abfac864b72aafabe9
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/57f5042258ca/disk-66418447.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a421e57798bb/vmlinux-66418447.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4d51a9205807/bzImage-66418447.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+06abfac864b72aafabe9@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in lock_release+0x151/0xa30 kernel/locking/lockdep.c:5838
Read of size 8 at addr ffff8880121fa338 by task kworker/1:2/972

CPU: 1 UID: 0 PID: 972 Comm: kworker/1:2 Not tainted 6.12.0-rc7-syzkaller-00144-g66418447d27b #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/30/2024
Workqueue: events l2cap_chan_timeout
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 lock_release+0x151/0xa30 kernel/locking/lockdep.c:5838
 __mutex_unlock_slowpath+0xe2/0x750 kernel/locking/mutex.c:912
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Allocated by task 15502:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:257 [inline]
 __kmalloc_cache_noprof+0x19c/0x2c0 mm/slub.c:4295
 kmalloc_noprof include/linux/slab.h:878 [inline]
 kzalloc_noprof include/linux/slab.h:1014 [inline]
 l2cap_conn_add+0xa9/0x8e0 net/bluetooth/l2cap_core.c:6860
 l2cap_chan_connect+0x623/0xeb0 net/bluetooth/l2cap_core.c:7051
 l2cap_sock_connect+0x5c9/0x800 net/bluetooth/l2cap_sock.c:256
 kernel_connect+0x10b/0x160 net/socket.c:3652
 rfcomm_session_create net/bluetooth/rfcomm/core.c:811 [inline]
 __rfcomm_dlc_open net/bluetooth/rfcomm/core.c:388 [inline]
 rfcomm_dlc_open+0x7cc/0x1270 net/bluetooth/rfcomm/core.c:431
 rfcomm_sock_connect+0x305/0x610 net/bluetooth/rfcomm/sock.c:409
 __sys_connect_file net/socket.c:2071 [inline]
 __sys_connect+0x2d1/0x300 net/socket.c:2088
 __do_sys_connect net/socket.c:2098 [inline]
 __se_sys_connect net/socket.c:2095 [inline]
 __x64_sys_connect+0x7a/0x90 net/socket.c:2095
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 15293:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x59/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:230 [inline]
 slab_free_hook mm/slub.c:2342 [inline]
 slab_free mm/slub.c:4579 [inline]
 kfree+0x1a0/0x440 mm/slub.c:4727
 hci_disconn_cfm include/net/bluetooth/hci_core.h:1975 [inline]
 hci_conn_hash_flush+0xff/0x240 net/bluetooth/hci_conn.c:2592
 hci_dev_close_sync+0xa42/0x11c0 net/bluetooth/hci_sync.c:5205
 hci_dev_do_close net/bluetooth/hci_core.c:483 [inline]
 hci_unregister_dev+0x20b/0x510 net/bluetooth/hci_core.c:2698
 vhci_release+0x80/0xd0 drivers/bluetooth/hci_vhci.c:664
 __fput+0x23f/0x880 fs/file_table.c:431
 task_work_run+0x24f/0x310 kernel/task_work.c:239
 exit_task_work include/linux/task_work.h:43 [inline]
 do_exit+0xa2f/0x28e0 kernel/exit.c:939
 do_group_exit+0x207/0x2c0 kernel/exit.c:1088
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1097
 x64_sys_call+0x2634/0x2640 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff8880121fa000
 which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 824 bytes inside of
 freed 1024-byte region [ffff8880121fa000, ffff8880121fa400)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x121f8
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88801ac41dc0 ffffea0001e84a00 dead000000000002
raw: 0000000000000000 0000000000100010 00000001f5000000 0000000000000000
head: 00fff00000000040 ffff88801ac41dc0 ffffea0001e84a00 dead000000000002
head: 0000000000000000 0000000000100010 00000001f5000000 0000000000000000
head: 00fff00000000003 ffffea0000487e01 ffffffffffffffff 0000000000000000
head: ffff888200000008 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0x52820(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 35, tgid 35 (kworker/u8:2), ts 235829839289, free_ts 225746407496
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1556
 prep_new_page mm/page_alloc.c:1564 [inline]
 get_page_from_freelist+0x3649/0x3790 mm/page_alloc.c:3474
 __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4750
 alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2265
 alloc_slab_page+0x6a/0x140 mm/slub.c:2412
 allocate_slab+0x5a/0x2f0 mm/slub.c:2578
 new_slab mm/slub.c:2631 [inline]
 ___slab_alloc+0xcd1/0x14b0 mm/slub.c:3818
 __slab_alloc+0x58/0xa0 mm/slub.c:3908
 __slab_alloc_node mm/slub.c:3961 [inline]
 slab_alloc_node mm/slub.c:4122 [inline]
 __kmalloc_cache_noprof+0x1d5/0x2c0 mm/slub.c:4290
 kmalloc_noprof include/linux/slab.h:878 [inline]
 kzalloc_noprof include/linux/slab.h:1014 [inline]
 batadv_hardif_add_interface net/batman-adv/hard-interface.c:882 [inline]
 batadv_hard_if_event+0xe7a/0x1620 net/batman-adv/hard-interface.c:970
 notifier_call_chain+0x19f/0x3e0 kernel/notifier.c:93
 call_netdevice_notifiers_extack net/core/dev.c:2034 [inline]
 call_netdevice_notifiers net/core/dev.c:2048 [inline]
 register_netdevice+0x167f/0x1b00 net/core/dev.c:10528
 nsim_init_netdevsim drivers/net/netdevsim/netdev.c:690 [inline]
 nsim_create+0x647/0x890 drivers/net/netdevsim/netdev.c:750
 __nsim_dev_port_add+0x6c0/0xae0 drivers/net/netdevsim/dev.c:1393
 nsim_dev_port_add_all drivers/net/netdevsim/dev.c:1449 [inline]
 nsim_dev_reload_create drivers/net/netdevsim/dev.c:1501 [inline]
 nsim_dev_reload_up+0x69b/0x8e0 drivers/net/netdevsim/dev.c:988
 devlink_reload+0x478/0x870 net/devlink/dev.c:474
page last free pid 5848 tgid 5848 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1127 [inline]
 free_unref_page+0xdf9/0x1140 mm/page_alloc.c:2657
 __slab_free+0x31b/0x3d0 mm/slub.c:4490
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x9a/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x14f/0x170 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x23/0x80 mm/kasan/common.c:329
 kasan_slab_alloc include/linux/kasan.h:247 [inline]
 slab_post_alloc_hook mm/slub.c:4085 [inline]
 slab_alloc_node mm/slub.c:4134 [inline]
 kmem_cache_alloc_noprof+0x135/0x2a0 mm/slub.c:4141
 skb_clone+0x20c/0x390 net/core/skbuff.c:2084
 hci_send_cmd_sync net/bluetooth/hci_core.c:4078 [inline]
 hci_cmd_work+0x2ca/0x6c0 net/bluetooth/hci_core.c:4098
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Memory state around the buggy address:
 ffff8880121fa200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880121fa280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff8880121fa300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                        ^
 ffff8880121fa380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880121fa400: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
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

