Return-Path: <netdev+bounces-159380-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3043BA1557B
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 18:12:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71304188B587
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 17:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21FE21A23AE;
	Fri, 17 Jan 2025 17:11:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367F31A0711
	for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 17:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737133888; cv=none; b=c4xE1SPwJE6nTDWUU860ssqgPAjQxnOHIqcukKTxWQk82+qAQqETfpP0kj+7X8wmakeJC8obtbk5HbrgKp4EZBPSWZ0bNAfkvNNBB5Iu6WaK5VBSQ6c1aW0QMJ/kIk3/37qHSLcLadpXgbq5XHbJ324fxlRm59khSJMOyPfnZjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737133888; c=relaxed/simple;
	bh=Qrq8BD7JaUXf06PyAFn7svOSVVGYCKGvO/fkFQVZTiM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=KqN6IXZbRsQzrRER+UVpVwFueOJh5ipRJixLpbO5KxYWcXC7RPbVJHYoB3+q55nQDtWn9VHbWGPxOJ2cAUjAjD3fqfGdUJ3pQsXMONe/8fRzX535UilD8DhDzmglSvqSQOL95/d+55PQqOrAFlRdP+2cvKqMfHjysUA3PqV7VvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3cca581135dso35450445ab.3
        for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 09:11:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737133885; x=1737738685;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xCWd7FDsSO2NhebTopf6A9YY2ozYshVvujEbGm9jpzo=;
        b=pcQQvpbwnSyRWnb+zKMfF08FX1hdwrpe6TxeYKI2YBCB5G393n3e0vROWUEymY5vXE
         iC1BEet/5pNdtmdZh/7RZDZPE3IdBLgNA1W98uKDqveE1O4edXCPOAoAEzpmJXJBm2pU
         HiqD49leY0PvAlOGQ2r0eOWdu943GUM+RiKMQu7QD/ePbv3s/DhvbomWYQm8+el5isAG
         hhmcSFTIhFPQqJRMNmpbvOiiA4102WuZlVlrgrSHFOzKYSKm/qPiVtnbijvU2ktTH2IL
         ny+NpYM1p/EL7OcKFmTqtQKw2jKqGiS7H/Efjnv/d/FOewrp6VQt1a2uxpAJaiFLVbi7
         +Y3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUGlDem/Q2f/nKjuYrDtuzkfloGbbslModcepFYGd+3vGvhPkvjvm/BNfAKJHyrH/KfgTkHSIE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzzrl//feq3TytRqlpnLMMZEAfDkkW/DlTyg45GjSICPkUnrDqN
	TuJkTxk9UJUqzPEH87T5ZZE4GyGS3fTZk4jOGkgeOuT+EnT8/DTOgE0rXby489XT0jJMkC3Q3XN
	zdZpav0EOsJUKMUk+6Orrr39gkeut7nMo/mJilFl1GxkoGKoBaQtPZRU=
X-Google-Smtp-Source: AGHT+IHCo3RUQoQW5DbZvos6Ik7lhffXGw9pY1ANsCQQoLOB9sLKHsZCZo4OmqYucEMGBIfvcLRgwiG3VNC/j7gMtGEPLozM66sD
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:160c:b0:3ce:88b1:7f21 with SMTP id
 e9e14a558f8ab-3cf7449070emr29027315ab.15.1737133885397; Fri, 17 Jan 2025
 09:11:25 -0800 (PST)
Date: Fri, 17 Jan 2025 09:11:25 -0800
In-Reply-To: <000000000000a4a7550611e234f5@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <678a8f3d.050a0220.303755.000f.GAE@google.com>
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in handle_tx (2)
From: syzbot <syzbot+827272712bd6d12c79a4@syzkaller.appspotmail.com>
To: andrew+netdev@lunn.ch, andrew@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    9bffa1ad25b8 Merge tag 'drm-fixes-2025-01-17' of https://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=107a69df980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d1cb4a1f148c0861
dashboard link: https://syzkaller.appspot.com/bug?extid=827272712bd6d12c79a4
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15783a18580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17d6c2b0580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-9bffa1ad.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0c65d8091a25/vmlinux-9bffa1ad.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1d98f79a18b7/bzImage-9bffa1ad.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+827272712bd6d12c79a4@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in handle_tx+0x5a5/0x630 drivers/net/caif/caif_serial.c:236
Read of size 8 at addr ffff888027ef3020 by task aoe_tx0/1417

CPU: 3 UID: 0 PID: 1417 Comm: aoe_tx0 Not tainted 6.13.0-rc7-syzkaller-00149-g9bffa1ad25b8 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xc3/0x620 mm/kasan/report.c:489
 kasan_report+0xd9/0x110 mm/kasan/report.c:602
 handle_tx+0x5a5/0x630 drivers/net/caif/caif_serial.c:236
 __netdev_start_xmit include/linux/netdevice.h:5002 [inline]
 netdev_start_xmit include/linux/netdevice.h:5011 [inline]
 xmit_one net/core/dev.c:3620 [inline]
 dev_hard_start_xmit+0x9a/0x7b0 net/core/dev.c:3636
 __dev_queue_xmit+0x7f0/0x43e0 net/core/dev.c:4466
 dev_queue_xmit include/linux/netdevice.h:3168 [inline]
 tx+0xcc/0x190 drivers/block/aoe/aoenet.c:62
 kthread+0x1e7/0x3c0 drivers/block/aoe/aoecmd.c:1237
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Allocated by task 9336:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:394
 kmalloc_noprof include/linux/slab.h:901 [inline]
 kzalloc_noprof include/linux/slab.h:1037 [inline]
 alloc_tty_struct+0x98/0x8d0 drivers/tty/tty_io.c:3116
 tty_init_dev.part.0+0x1e/0x660 drivers/tty/tty_io.c:1409
 tty_init_dev include/linux/err.h:67 [inline]
 tty_open_by_driver drivers/tty/tty_io.c:2082 [inline]
 tty_open+0xac1/0xf80 drivers/tty/tty_io.c:2129
 chrdev_open+0x237/0x6a0 fs/char_dev.c:414
 do_dentry_open+0xf59/0x1ea0 fs/open.c:945
 vfs_open+0x82/0x3f0 fs/open.c:1075
 do_open fs/namei.c:3828 [inline]
 path_openat+0x1e6a/0x2d60 fs/namei.c:3987
 do_filp_open+0x20c/0x470 fs/namei.c:4014
 do_sys_openat2+0x17a/0x1e0 fs/open.c:1402
 do_sys_open fs/open.c:1417 [inline]
 __do_sys_openat fs/open.c:1433 [inline]
 __se_sys_openat fs/open.c:1428 [inline]
 __x64_sys_openat+0x175/0x210 fs/open.c:1428
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 3233:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:582
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x51/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2353 [inline]
 slab_free mm/slub.c:4613 [inline]
 kfree+0x14f/0x4b0 mm/slub.c:4761
 process_one_work+0x9c5/0x1ba0 kernel/workqueue.c:3236
 process_scheduled_works kernel/workqueue.c:3317 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3398
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Last potentially related work creation:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 __kasan_record_aux_stack+0xba/0xd0 mm/kasan/generic.c:544
 insert_work+0x36/0x230 kernel/workqueue.c:2183
 __queue_work+0x97e/0x1080 kernel/workqueue.c:2339
 queue_work_on+0x11a/0x140 kernel/workqueue.c:2390
 kref_put include/linux/kref.h:65 [inline]
 tty_kref_put drivers/tty/tty_io.c:1566 [inline]
 tty_kref_put drivers/tty/tty_io.c:1563 [inline]
 release_tty+0x4de/0x5d0 drivers/tty/tty_io.c:1602
 tty_release_struct+0xb7/0xe0 drivers/tty/tty_io.c:1701
 tty_release+0xe25/0x1410 drivers/tty/tty_io.c:1861
 __fput+0x3f8/0xb60 fs/file_table.c:450
 __fput_sync+0xa1/0xc0 fs/file_table.c:535
 __do_sys_close fs/open.c:1554 [inline]
 __se_sys_close fs/open.c:1539 [inline]
 __x64_sys_close+0x86/0x100 fs/open.c:1539
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888027ef3000
 which belongs to the cache kmalloc-cg-2k of size 2048
The buggy address is located 32 bytes inside of
 freed 2048-byte region [ffff888027ef3000, ffff888027ef3800)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x27ef0
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
memcg:ffff88802da23f81
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88801b050140 dead000000000100 dead000000000122
raw: 0000000000000000 0000000000080008 00000001f5000000 ffff88802da23f81
head: 00fff00000000040 ffff88801b050140 dead000000000100 dead000000000122
head: 0000000000000000 0000000000080008 00000001f5000000 ffff88802da23f81
head: 00fff00000000003 ffffea00009fbc01 ffffffffffffffff 0000000000000000
head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5950, tgid 5950 (syz-executor374), ts 92233424258, free_ts 92129665975
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x2d1/0x350 mm/page_alloc.c:1558
 prep_new_page mm/page_alloc.c:1566 [inline]
 get_page_from_freelist+0xfce/0x2f80 mm/page_alloc.c:3476
 __alloc_pages_noprof+0x223/0x25b0 mm/page_alloc.c:4753
 alloc_pages_mpol_noprof+0x2c8/0x620 mm/mempolicy.c:2269
 alloc_slab_page mm/slub.c:2423 [inline]
 allocate_slab mm/slub.c:2589 [inline]
 new_slab+0x2c9/0x410 mm/slub.c:2642
 ___slab_alloc+0xd7d/0x17a0 mm/slub.c:3830
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3920
 __slab_alloc_node mm/slub.c:3995 [inline]
 slab_alloc_node mm/slub.c:4156 [inline]
 __do_kmalloc_node mm/slub.c:4297 [inline]
 __kmalloc_node_noprof+0x2f0/0x510 mm/slub.c:4304
 __kvmalloc_node_noprof+0xad/0x1a0 mm/util.c:645
 kvmalloc_array_node_noprof include/linux/slab.h:1063 [inline]
 alloc_fdtable+0xee/0x2b0 fs/file.c:199
 dup_fd+0x83b/0xb90 fs/file.c:400
 copy_files kernel/fork.c:1797 [inline]
 copy_process+0x25d2/0x8e50 kernel/fork.c:2382
 kernel_clone+0xfd/0x960 kernel/fork.c:2806
 __do_sys_clone+0xba/0x100 kernel/fork.c:2949
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 6083 tgid 6083 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1127 [inline]
 free_unref_page+0x661/0x1080 mm/page_alloc.c:2659
 __put_partials+0x14c/0x170 mm/slub.c:3157
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x4e/0x120 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x195/0x1e0 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x69/0x90 mm/kasan/common.c:329
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4119 [inline]
 slab_alloc_node mm/slub.c:4168 [inline]
 kmem_cache_alloc_noprof+0x226/0x3d0 mm/slub.c:4175
 getname_flags.part.0+0x4c/0x550 fs/namei.c:139
 getname_flags include/linux/audit.h:322 [inline]
 getname+0x8d/0xe0 fs/namei.c:223
 getname_maybe_null include/linux/fs.h:2796 [inline]
 vfs_fstatat+0xdf/0xf0 fs/stat.c:361
 __do_sys_newfstatat+0xa2/0x130 fs/stat.c:530
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff888027ef2f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888027ef2f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff888027ef3000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                               ^
 ffff888027ef3080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888027ef3100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

