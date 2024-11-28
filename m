Return-Path: <netdev+bounces-147683-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8E89DB2EE
	for <lists+netdev@lfdr.de>; Thu, 28 Nov 2024 07:53:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9BEA1621B2
	for <lists+netdev@lfdr.de>; Thu, 28 Nov 2024 06:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCBD1146000;
	Thu, 28 Nov 2024 06:53:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22496145A09
	for <netdev@vger.kernel.org>; Thu, 28 Nov 2024 06:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732776806; cv=none; b=S80/4m6wEhxnbIPIoGTexYRDS8QwXLconmYIfT93h7lNo65XSfOnLmQ+t5K+eWKlcKechfTEas0NQ/HDtHSbC1uIMrV1g9lMJ4BYhM0WVhVlFgnuOBQs7YKAe7CI9rEPLdGG+vJ92zKj1jtEbxqQoi2UYSQWVlAqEMiItAtW11o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732776806; c=relaxed/simple;
	bh=cHDFkKvSJUscEYHuTrSLyHkv8Ms7P9PdZlxNSR9ABZ8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=GhvxgsXd9gzSmizn30AQMpiLeZBK+hq12J4awO9hmr7aC9kDgk+4trTEQsr5a9Nj4lPQfDjuLXaOXJuBb+waulYX9ti4DGduA8DdmjmGdkXb1IzIjGlYJoulqTWZ61pEnNI7sHb+FMoXdo51M93ggIJukwdwwvvCR2MXWNHN3WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-841896ec108so44975539f.1
        for <netdev@vger.kernel.org>; Wed, 27 Nov 2024 22:53:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732776804; x=1733381604;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZwH3LaQjZEGUcCoUPc0HwLttjQVoZ4TuaKtivSUPAaM=;
        b=vrRmrU3n35EAevn/jxETSNxYBCFMWHcC2jjjFmGPGJELPa7zrm7i1dVQMj8IrQgBKl
         Ied4YJbHOBkt3lLmAWNQibWZRMUGxJR00MT6S6pEPLVzt7d/NVVeHlSVIf2E//UI6LPT
         qXiy/2slmo4z/wgVViKEXPXhegu9gcmbRhYfH4yUV2Eff0QoHzni7rFRhxSCFvcRE4I5
         LBEG9dPG3Qtazp25hsOP6CbSCqkemWOt4bfoPmfwXPUmxRu9kT1Z/qcQdeYJlbs1VpfM
         MCKD82eCKaZ5yiqbgqTXZeuh73vT3lli/ZWTYumMG3MdH0zUa6h+UuRD7q9YfSsm5NZz
         1vVA==
X-Forwarded-Encrypted: i=1; AJvYcCVcAm/6byK6GQMtoM96yRWLlA+hlW41iT6EYvKMGoKgmJQS2HSHKFbp+C9uAagailLg446mEa8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5OTJn7m7DayG5OidEh/Embvodxf02srNZRBqmTnaFdfGW879D
	1642hBaK656hm80UsuYNDVa6Y8xCUuK1ZUiYPhBo2aL3lyRQHJZgY+YvhGTkH2AV6oe23XtRdGd
	IZVkG3BMFkrvZ9YP5hXnfdZQVjPGTmBhMb+XmCKt8bN48Jdqw5KliAKY=
X-Google-Smtp-Source: AGHT+IGp5YBHZCt93Hz1WTmdDwObL1bx8jOib/qsrmXMWKLxxofYIElgPBynkIEhqGbkTl9jvT9CZs7Abjewi9oGnAMJiDA9yYKJ
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cdab:0:b0:3a7:c32f:be58 with SMTP id
 e9e14a558f8ab-3a7c557c7d1mr70401395ab.13.1732776804342; Wed, 27 Nov 2024
 22:53:24 -0800 (PST)
Date: Wed, 27 Nov 2024 22:53:24 -0800
In-Reply-To: <00000000000069859c061dfa7e91@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67481364.050a0220.253251.0073.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in mgmt_remove_adv_monitor_sync
From: syzbot <syzbot+479aff51bb361ef5aa18@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    5dfd7d940094 Merge branch 'bnxt_en-bug-fixes'
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=1264a3c0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=83e9a7f9e94ea674
dashboard link: https://syzkaller.appspot.com/bug?extid=479aff51bb361ef5aa18
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16348f78580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f4aa5ee37bd1/disk-5dfd7d94.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d403277896b8/vmlinux-5dfd7d94.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8ac17fc5f4ae/bzImage-5dfd7d94.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+479aff51bb361ef5aa18@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in mgmt_remove_adv_monitor_sync+0x3a/0xd0 net/bluetooth/mgmt.c:5532
Read of size 8 at addr ffff8881446ec698 by task kworker/u9:6/5957

CPU: 1 UID: 0 PID: 5957 Comm: kworker/u9:6 Not tainted 6.12.0-syzkaller-05517-g5dfd7d940094 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: hci0 hci_cmd_sync_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 mgmt_remove_adv_monitor_sync+0x3a/0xd0 net/bluetooth/mgmt.c:5532
 hci_cmd_sync_work+0x22b/0x400 net/bluetooth/hci_sync.c:332
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Allocated by task 14866:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:257 [inline]
 __kmalloc_cache_noprof+0x19c/0x2c0 mm/slub.c:4295
 kmalloc_noprof include/linux/slab.h:879 [inline]
 kzalloc_noprof include/linux/slab.h:1015 [inline]
 mgmt_pending_new+0x65/0x250 net/bluetooth/mgmt_util.c:269
 mgmt_pending_add+0x36/0x120 net/bluetooth/mgmt_util.c:296
 remove_adv_monitor+0x102/0x1b0 net/bluetooth/mgmt.c:5557
 hci_mgmt_cmd+0xc47/0x11d0 net/bluetooth/hci_sock.c:1712
 hci_sock_sendmsg+0x7b8/0x11c0 net/bluetooth/hci_sock.c:1832
 sock_sendmsg_nosec net/socket.c:711 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:726
 sock_write_iter+0x2d7/0x3f0 net/socket.c:1147
 new_sync_write fs/read_write.c:586 [inline]
 vfs_write+0xaeb/0xd30 fs/read_write.c:679
 ksys_write+0x18f/0x2b0 fs/read_write.c:731
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 14863:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x59/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:230 [inline]
 slab_free_hook mm/slub.c:2342 [inline]
 slab_free mm/slub.c:4579 [inline]
 kfree+0x1a0/0x440 mm/slub.c:4727
 mgmt_pending_foreach+0xd1/0x130 net/bluetooth/mgmt_util.c:259
 __mgmt_power_off+0x183/0x430 net/bluetooth/mgmt.c:9534
 hci_dev_close_sync+0x6c4/0x11c0 net/bluetooth/hci_sync.c:5208
 hci_dev_do_close net/bluetooth/hci_core.c:483 [inline]
 hci_dev_close+0x112/0x210 net/bluetooth/hci_core.c:508
 sock_do_ioctl+0x158/0x460 net/socket.c:1209
 sock_ioctl+0x626/0x8e0 net/socket.c:1328
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:906 [inline]
 __se_sys_ioctl+0xf5/0x170 fs/ioctl.c:892
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff8881446ec680
 which belongs to the cache kmalloc-96 of size 96
The buggy address is located 24 bytes inside of
 freed 96-byte region [ffff8881446ec680, ffff8881446ec6e0)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1446ec
anon flags: 0x57ff00000000000(node=1|zone=2|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 057ff00000000000 ffff88801b041280 0000000000000000 dead000000000001
raw: 0000000000000000 0000000000200020 00000001f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 1, tgid 1 (swapper/0), ts 3620866436, free_ts 0
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1556
 prep_new_page mm/page_alloc.c:1564 [inline]
 get_page_from_freelist+0x3649/0x3790 mm/page_alloc.c:3474
 __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4751
 alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2265
 alloc_slab_page+0x6a/0x140 mm/slub.c:2412
 allocate_slab+0x5a/0x2f0 mm/slub.c:2578
 new_slab mm/slub.c:2631 [inline]
 ___slab_alloc+0xcd1/0x14b0 mm/slub.c:3818
 __slab_alloc+0x58/0xa0 mm/slub.c:3908
 __slab_alloc_node mm/slub.c:3961 [inline]
 slab_alloc_node mm/slub.c:4122 [inline]
 __kmalloc_cache_noprof+0x1d5/0x2c0 mm/slub.c:4290
 kmalloc_noprof include/linux/slab.h:879 [inline]
 kzalloc_noprof include/linux/slab.h:1015 [inline]
 acpi_ut_evaluate_object+0x108/0x4a0 drivers/acpi/acpica/uteval.c:50
 acpi_ut_execute_power_methods+0x112/0x270 drivers/acpi/acpica/uteval.c:288
 acpi_get_object_info+0x629/0x1220 drivers/acpi/acpica/nsxfname.c:356
 acpi_set_pnp_ids drivers/acpi/scan.c:1410 [inline]
 acpi_init_device_object+0xbeb/0x31a0 drivers/acpi/scan.c:1829
 acpi_add_single_object+0x106/0x1e00 drivers/acpi/scan.c:1880
 acpi_bus_check_add+0x32b/0x980 drivers/acpi/scan.c:2181
 acpi_ns_walk_namespace+0x294/0x4f0
page_owner free stack trace missing

Memory state around the buggy address:
 ffff8881446ec580: 00 00 00 00 00 00 00 00 00 00 00 fc fc fc fc fc
 ffff8881446ec600: 00 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc
>ffff8881446ec680: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
                            ^
 ffff8881446ec700: 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc
 ffff8881446ec780: 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc
==================================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

