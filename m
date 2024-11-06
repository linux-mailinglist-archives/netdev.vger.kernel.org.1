Return-Path: <netdev+bounces-142260-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8AF49BE103
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 09:33:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 798011F24A74
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 08:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF3F01D435F;
	Wed,  6 Nov 2024 08:33:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D0E1D3566
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 08:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730882005; cv=none; b=pN1uG5CsmAILgr6aP6YQ4fesrrJbH6Wmoye/JNfHIh0xePT3kHh7QeIZCNoZTJdJ6hntbhQlLPibHTQDXXLjZvM3yv5AUrjYKjlL6PZ7Fb6jEW01LIBGjPxtiJSQfagLWxlMbzOdyeXgvZ9wv+HopMPWvj/vr6bR64ph0yduvCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730882005; c=relaxed/simple;
	bh=m8bnTsTPqJviiQECkUoTT8xUhsn7JSQSuxRjjjARPO8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=LjdKSm86hFlPeTrWDXlj5TyPUUOIv1dXFcoe+HaTs7YAhafB7sDdipc828nccBOwa2L8jAPVj5OoLo+XY/G9adARQxxf5jfIrn9NLXLmlVJhmxI5hcWDilPXIymmTTsmiuJSCg4xfCptzu1aAk65QSQ9wu/bgerPioNA4N/dq0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a3da2d46b9so70545635ab.0
        for <netdev@vger.kernel.org>; Wed, 06 Nov 2024 00:33:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730882003; x=1731486803;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Xwe7d85z9yu9fMsBQFKmwJXBjirfc7dw3u+31EyReGs=;
        b=NuaRQRMIP5stOeK816rqRzKSaijq2D8lmqRInWLSAAHJBwg2J1wsBQQmw6oMg+L5Q5
         csdgdO73jowFUg01S1JDiOpBHWasA8UWeWQn7Ri0FhoN8lCJXM+pxgA6FkhNg4/OjKzV
         iZMsLlhtn4hFhLqjSMjqOl5W6D0XZo8c+P2H/TTfwoFfpmbj+WA9y0EFTtO6MKVmNH3F
         utNTfE6K8eUmPIOSoB5n6eddVedgb0FokTJmUaCxH8gErEs6MueiNozNix6cK02nuiqs
         Wow9IFe1V+mgcpj7O+e0SGeik5PMOPz6hZXVxVKX1gFoYFa54gZp3u7rhcK+ep8MfGhR
         nbdg==
X-Forwarded-Encrypted: i=1; AJvYcCWRyb15qbtO0+9JE/atc7qP0txqoHZ3j3GReNxzfAcjRzJLG+qvJcDNrfBqrhGWfM8J5D1QHYU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiEiEometuYohUv+NYFiIb3JLJFqzpOscXQ1sucGwLZPQKKiuG
	HZApqcJA4pQAF5GZNd6TUyi4TgWpptbB2gLaq10S/DblXFawoFSNZCV1cZ7qKqNJGDpMpXHIrkN
	a6tGkcs8ySchBde4ZfQ3LvNIUoaZRWqqLIy1J39hR78dp2xFDGcTJUR0=
X-Google-Smtp-Source: AGHT+IFPQ+Unv2bUB6f79APCgJwLAdWln6ixBHv1HBdGhCf7x5UEl16LpfAceGx4qy3L7++7NwPxp/juBISFXUmu1XkyBz3fcj5Z
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1746:b0:3a6:c724:2ec with SMTP id
 e9e14a558f8ab-3a6c724041emr134185465ab.2.1730882002972; Wed, 06 Nov 2024
 00:33:22 -0800 (PST)
Date: Wed, 06 Nov 2024 00:33:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <672b29d2.050a0220.2a847.1ba4.GAE@google.com>
Subject: [syzbot] [net?] KASAN: slab-use-after-free Read in cfusbl_device_notify
From: syzbot <syzbot+e944aefa061beaa1acc8@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    59b723cd2adb Linux 6.12-rc6
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1517c740580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c0b2fb415081f288
dashboard link: https://syzkaller.appspot.com/bug?extid=e944aefa061beaa1acc8
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-59b723cd.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/88b661caee4f/vmlinux-59b723cd.xz
kernel image: https://storage.googleapis.com/syzbot-assets/89f67095b467/bzImage-59b723cd.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e944aefa061beaa1acc8@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in cfusbl_device_notify+0x885/0x910 net/caif/caif_usb.c:142
Read of size 8 at addr ffff8880581dcbd0 by task syz.6.1413/11521

CPU: 2 UID: 0 PID: 11521 Comm: syz.6.1413 Not tainted 6.12.0-rc6-syzkaller #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0xc3/0x620 mm/kasan/report.c:488
 kasan_report+0xd9/0x110 mm/kasan/report.c:601
 cfusbl_device_notify+0x885/0x910 net/caif/caif_usb.c:142
 notifier_call_chain+0xb9/0x410 kernel/notifier.c:93
 call_netdevice_notifiers_info+0xbe/0x140 net/core/dev.c:1996
 call_netdevice_notifiers_extack net/core/dev.c:2034 [inline]
 call_netdevice_notifiers net/core/dev.c:2048 [inline]
 register_netdevice+0xe6c/0x1e90 net/core/dev.c:10490
 register_netdev+0x2f/0x50 net/core/dev.c:10632
 bnep_add_connection+0x71e/0xd20 net/bluetooth/bnep/core.c:624
 do_bnep_sock_ioctl.constprop.0+0x498/0x590 net/bluetooth/bnep/sock.c:83
 sock_do_ioctl+0x116/0x280 net/socket.c:1227
 sock_ioctl+0x228/0x6c0 net/socket.c:1346
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl fs/ioctl.c:893 [inline]
 __x64_sys_ioctl+0x18f/0x220 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb1f857e719
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fb1f944a038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fb1f8735f80 RCX: 00007fb1f857e719
RDX: 00000000200000c0 RSI: 00000000400442c8 RDI: 000000000000002a
RBP: 00007fb1f85f139e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fb1f8735f80 R15: 00007ffe84929a88
 </TASK>

Allocated by task 5304:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:394
 kmalloc_noprof include/linux/slab.h:878 [inline]
 kzalloc_noprof include/linux/slab.h:1014 [inline]
 __hci_conn_add+0x131/0x1a50 net/bluetooth/hci_conn.c:935
 hci_conn_add_unset+0x6d/0x100 net/bluetooth/hci_conn.c:1044
 hci_conn_request_evt+0x8c4/0xb40 net/bluetooth/hci_event.c:3288
 hci_event_func net/bluetooth/hci_event.c:7443 [inline]
 hci_event_packet+0x9eb/0x1180 net/bluetooth/hci_event.c:7495
 hci_rx_work+0x2c6/0x16c0 net/bluetooth/hci_core.c:4031
 process_one_work+0x9c5/0x1ba0 kernel/workqueue.c:3229
 process_scheduled_works kernel/workqueue.c:3310 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Freed by task 11302:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:579
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x51/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:230 [inline]
 slab_free_hook mm/slub.c:2342 [inline]
 slab_free mm/slub.c:4579 [inline]
 kfree+0x14f/0x4b0 mm/slub.c:4727
 device_release+0xa1/0x240 drivers/base/core.c:2574
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x1e4/0x5a0 lib/kobject.c:737
 put_device drivers/base/core.c:3780 [inline]
 device_unregister+0x2f/0xc0 drivers/base/core.c:3903
 hci_conn_del_sysfs+0xb4/0x180 net/bluetooth/hci_sysfs.c:86
 hci_conn_cleanup net/bluetooth/hci_conn.c:174 [inline]
 hci_conn_del+0x54e/0xdb0 net/bluetooth/hci_conn.c:1163
 hci_conn_hash_flush+0x18f/0x260 net/bluetooth/hci_conn.c:2593
 hci_dev_close_sync+0x603/0x11b0 net/bluetooth/hci_sync.c:5205
 hci_dev_do_close+0x2e/0x90 net/bluetooth/hci_core.c:483
 hci_unregister_dev+0x213/0x620 net/bluetooth/hci_core.c:2698
 vhci_release+0x79/0xf0 drivers/bluetooth/hci_vhci.c:664
 __fput+0x3f6/0xb60 fs/file_table.c:431
 task_work_run+0x14e/0x250 kernel/task_work.c:239
 exit_task_work include/linux/task_work.h:43 [inline]
 do_exit+0xadd/0x2d70 kernel/exit.c:939
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1088
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1097
 x64_sys_call+0x14a9/0x16a0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Last potentially related work creation:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 __kasan_record_aux_stack+0xba/0xd0 mm/kasan/generic.c:541
 insert_work+0x36/0x230 kernel/workqueue.c:2183
 __queue_work+0x97e/0x1080 kernel/workqueue.c:2339
 __queue_delayed_work+0x21b/0x2e0 kernel/workqueue.c:2507
 queue_delayed_work_on+0x12a/0x150 kernel/workqueue.c:2552
 queue_delayed_work include/linux/workqueue.h:677 [inline]
 hci_conn_drop include/net/bluetooth/hci_core.h:1570 [inline]
 hci_conn_drop include/net/bluetooth/hci_core.h:1544 [inline]
 l2cap_chan_del+0x5a0/0x900 net/bluetooth/l2cap_core.c:674
 l2cap_conn_del+0x37c/0x730 net/bluetooth/l2cap_core.c:1785
 l2cap_disconn_cfm net/bluetooth/l2cap_core.c:7299 [inline]
 l2cap_disconn_cfm+0x96/0xd0 net/bluetooth/l2cap_core.c:7292
 hci_disconn_cfm include/net/bluetooth/hci_core.h:1975 [inline]
 hci_conn_hash_flush+0x114/0x260 net/bluetooth/hci_conn.c:2592
 hci_dev_close_sync+0x603/0x11b0 net/bluetooth/hci_sync.c:5205
 hci_dev_do_close+0x2e/0x90 net/bluetooth/hci_core.c:483
 hci_unregister_dev+0x213/0x620 net/bluetooth/hci_core.c:2698
 vhci_release+0x79/0xf0 drivers/bluetooth/hci_vhci.c:664
 __fput+0x3f6/0xb60 fs/file_table.c:431
 task_work_run+0x14e/0x250 kernel/task_work.c:239
 exit_task_work include/linux/task_work.h:43 [inline]
 do_exit+0xadd/0x2d70 kernel/exit.c:939
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1088
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1097
 x64_sys_call+0x14a9/0x16a0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff8880581dc000
 which belongs to the cache kmalloc-8k of size 8192
The buggy address is located 3024 bytes inside of
 freed 8192-byte region [ffff8880581dc000, ffff8880581de000)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x581d8
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
anon flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88801b043180 0000000000000000 dead000000000001
raw: 0000000000000000 0000000000020002 00000001f5000000 0000000000000000
head: 00fff00000000040 ffff88801b043180 0000000000000000 dead000000000001
head: 0000000000000000 0000000000020002 00000001f5000000 0000000000000000
head: 00fff00000000003 ffffea0001607601 ffffffffffffffff 0000000000000000
head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 11260, tgid 11259 (syz.4.1354), ts 175969153353, free_ts 175968727495
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x2d1/0x350 mm/page_alloc.c:1537
 prep_new_page mm/page_alloc.c:1545 [inline]
 get_page_from_freelist+0xf7d/0x2d10 mm/page_alloc.c:3457
 __alloc_pages_noprof+0x223/0x25a0 mm/page_alloc.c:4733
 alloc_pages_mpol_noprof+0x2c9/0x610 mm/mempolicy.c:2265
 alloc_slab_page mm/slub.c:2412 [inline]
 allocate_slab mm/slub.c:2578 [inline]
 new_slab+0x2c9/0x410 mm/slub.c:2631
 ___slab_alloc+0xdac/0x1880 mm/slub.c:3818
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3908
 __slab_alloc_node mm/slub.c:3961 [inline]
 slab_alloc_node mm/slub.c:4122 [inline]
 __do_kmalloc_node mm/slub.c:4263 [inline]
 __kmalloc_node_noprof+0x357/0x430 mm/slub.c:4270
 __kvmalloc_node_noprof+0x6f/0x1a0 mm/util.c:658
 kvmalloc_array_node_noprof include/linux/slab.h:1040 [inline]
 __ptr_ring_init_queue_alloc_noprof include/linux/ptr_ring.h:471 [inline]
 ptr_ring_init_noprof include/linux/ptr_ring.h:489 [inline]
 skb_array_init_noprof include/linux/skb_array.h:182 [inline]
 pfifo_fast_init+0x125/0x3b0 net/sched/sch_generic.c:871
 qdisc_create_dflt+0x101/0x440 net/sched/sch_generic.c:1021
 mq_init+0x329/0x470 net/sched/sch_mq.c:90
 qdisc_create_dflt+0x101/0x440 net/sched/sch_generic.c:1021
 attach_default_qdiscs net/sched/sch_generic.c:1203 [inline]
 dev_activate+0xaa1/0x12b0 net/sched/sch_generic.c:1257
 __dev_open+0x396/0x4e0 net/core/dev.c:1485
 __dev_change_flags+0x561/0x720 net/core/dev.c:8845
page last free pid 11260 tgid 11259 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1108 [inline]
 free_unref_page+0x5f4/0xdc0 mm/page_alloc.c:2638
 __put_partials+0x14c/0x170 mm/slub.c:3145
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x4e/0x120 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x192/0x1e0 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x69/0x90 mm/kasan/common.c:329
 kasan_slab_alloc include/linux/kasan.h:247 [inline]
 slab_post_alloc_hook mm/slub.c:4085 [inline]
 slab_alloc_node mm/slub.c:4134 [inline]
 __kmalloc_cache_noprof+0x11e/0x300 mm/slub.c:4290
 kmalloc_noprof include/linux/slab.h:878 [inline]
 kzalloc_noprof include/linux/slab.h:1014 [inline]
 ref_tracker_alloc+0x17c/0x5b0 lib/ref_tracker.c:203
 __netdev_tracker_alloc include/linux/netdevice.h:4062 [inline]
 netdev_hold include/linux/netdevice.h:4091 [inline]
 netdev_hold include/linux/netdevice.h:4086 [inline]
 qdisc_alloc+0x901/0xc50 net/sched/sch_generic.c:991
 qdisc_create_dflt+0x73/0x440 net/sched/sch_generic.c:1014
 mq_init+0x329/0x470 net/sched/sch_mq.c:90
 qdisc_create_dflt+0x101/0x440 net/sched/sch_generic.c:1021
 attach_default_qdiscs net/sched/sch_generic.c:1203 [inline]
 dev_activate+0xaa1/0x12b0 net/sched/sch_generic.c:1257
 __dev_open+0x396/0x4e0 net/core/dev.c:1485
 __dev_change_flags+0x561/0x720 net/core/dev.c:8845
 dev_change_flags+0x8f/0x160 net/core/dev.c:8917
 dev_ifsioc+0x9c8/0x10b0 net/core/dev_ioctl.c:526

Memory state around the buggy address:
 ffff8880581dca80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880581dcb00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff8880581dcb80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                 ^
 ffff8880581dcc00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880581dcc80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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

