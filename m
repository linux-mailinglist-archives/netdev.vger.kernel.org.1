Return-Path: <netdev+bounces-157937-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB554A0FE09
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 02:26:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D237B166F08
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 01:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CA23224B16;
	Tue, 14 Jan 2025 01:26:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E517EC5
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 01:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736817986; cv=none; b=vClcBmOcke4pmANNv+rBq6NP07GdnOU2F7i8+/aCubaiUix+nwbIN4KKzk1eu5vE7JIUG5kYuK8FodJiJEgTiLsKI8O38kmsPxbWPlLyhrEmGpBvRJU5Y+yHpesRYb3+10gXXMGJlQlKycd43md3GOjvPFaau8UVqfiQSw9Cn3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736817986; c=relaxed/simple;
	bh=NK7wxxTK+7sbnbxQDZuHmkIHy1f4GguaNRXvDc2ipMs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=mAnYmaKXZMLiaz2CRwHk7wDR1bH/WiFGdjAEtDFREZgvQiiraVI5A+OqhMljEjTHXgARjtZsflTV9qidamWCpKGLOoFbzaXjeUgGFV5M2kk6uAlLj+M35MCgDbhvD91xPwSFBRYhxk2GU08C0p0cSn06LtMcceboB4VOPVmHYrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3cde3591dbfso39204135ab.0
        for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 17:26:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736817983; x=1737422783;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YJqJOefC0qFaZSi3sIEZD67EP6yhqRDrEHOK2s5wcV0=;
        b=oScyfiC/Dx6rwnI/kza713Wwgb7igdOTTupFrqowUVADHS/NcBilcYt+oDDUsGgoJ3
         60dOzAc4wHhZCdIbSMMYmj5q5OnJDvcashOC3PknLVWO2VJdUUqXWY4Ya263IF9MPaNx
         M53sRkkTVtqKnNTVafWQbNdy97K4jUaj1dRGRS3jwBhKn0BPsSqdKzkxU1SYdTVDhlLr
         BTgTki57iSxTLl3uqrWKtViMdcgTfgFZNdOS6nEAcpLkE/tJCxbqDJEionPDx3Ut94d+
         Or2MC9igjTrzJ6kmj4QrZSrAKWuLIdgEeRMBPiH5oJYQvej1Ooc4OE1BEY3ilnohXMlp
         PrFg==
X-Forwarded-Encrypted: i=1; AJvYcCWl/P3wIixBZ9ELHePDRHLSfXauf4NDNb60UTQsmCdmuqeFLTL+Qo92JOeIvbRn+xgHJthXVJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW7DTGI9CLPTGXTCrkL6RWYOlXjPSMGSygSfaO/kudptIXuic0
	JFGcmHVLkz5GKckfKETJunNB76hFb/HLswe4SLpe5K+hQRWTiE9pDi7mYPY1fX9VvtMWoPZhSjf
	Wni1RkB5TZzR9knNYNQSVM8cFMNbAgMcEGluwI1viPjMtcrVzKQoGExE=
X-Google-Smtp-Source: AGHT+IGTA9ibLUeGE17k9V5MOtGgUR5BaZQM9Qs3R6nGSdFI6rlz9Y+2HnKS0n2sLqKGLA619oNNDzIfbDfV0LJk1g/BaUjHdP6N
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:148a:b0:3a9:cde3:2ecc with SMTP id
 e9e14a558f8ab-3ce4757643cmr141580055ab.6.1736817983603; Mon, 13 Jan 2025
 17:26:23 -0800 (PST)
Date: Mon, 13 Jan 2025 17:26:23 -0800
In-Reply-To: <000000000000a4a7550611e234f5@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6785bd3f.050a0220.216c54.0062.GAE@google.com>
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in handle_tx (2)
From: syzbot <syzbot+827272712bd6d12c79a4@syzkaller.appspotmail.com>
To: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    c45323b7560e Merge tag 'mm-hotfixes-stable-2025-01-13-00-0..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10565cb0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d1cb4a1f148c0861
dashboard link: https://syzkaller.appspot.com/bug?extid=827272712bd6d12c79a4
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14565cb0580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-c45323b7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d162460a6713/vmlinux-c45323b7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f905e34cb8b4/bzImage-c45323b7.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+827272712bd6d12c79a4@syzkaller.appspotmail.com

ieee802154 phy0 wpan0: encryption failed: -22
ieee802154 phy1 wpan1: encryption failed: -22
==================================================================
BUG: KASAN: slab-use-after-free in handle_tx+0x5a5/0x630 drivers/net/caif/caif_serial.c:236
Read of size 8 at addr ffff88804b550020 by task aoe_tx0/1417

CPU: 2 UID: 0 PID: 1417 Comm: aoe_tx0 Not tainted 6.13.0-rc7-syzkaller-00019-gc45323b7560e #0
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

Allocated by task 6243:
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

Freed by task 9:
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
 task_work_run+0x14e/0x250 kernel/task_work.c:239
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x27b/0x2a0 kernel/entry/common.c:218
 do_syscall_64+0xda/0x250 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88804b550000
 which belongs to the cache kmalloc-cg-2k of size 2048
The buggy address is located 32 bytes inside of
 freed 2048-byte region [ffff88804b550000, ffff88804b550800)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff88804b554000 pfn:0x4b550
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
memcg:ffff8880247d5b81
flags: 0xfff00000000240(workingset|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000240 ffff88801b050140 ffffea0000d3b210 ffff88801b04e708
raw: ffff88804b554000 0000000000080005 00000001f5000000 ffff8880247d5b81
head: 00fff00000000240 ffff88801b050140 ffffea0000d3b210 ffff88801b04e708
head: ffff88804b554000 0000000000080005 00000001f5000000 ffff8880247d5b81
head: 00fff00000000003 ffffea00012d5401 ffffffffffffffff 0000000000000000
head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 6034, tgid 6034 (syz-executor), ts 81856364049, free_ts 80251618977
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
 __kmalloc_noprof+0x2ec/0x510 mm/slub.c:4310
 kmalloc_noprof include/linux/slab.h:905 [inline]
 kzalloc_noprof include/linux/slab.h:1037 [inline]
 __register_sysctl_table+0xb4/0x1910 fs/proc/proc_sysctl.c:1375
 __devinet_sysctl_register+0x1b5/0x360 net/ipv4/devinet.c:2630
 devinet_sysctl_register net/ipv4/devinet.c:2670 [inline]
 devinet_sysctl_register+0x17b/0x200 net/ipv4/devinet.c:2660
 inetdev_init+0x2b8/0x5a0 net/ipv4/devinet.c:299
 inetdev_event+0xc61/0x18a0 net/ipv4/devinet.c:1598
 notifier_call_chain+0xb7/0x410 kernel/notifier.c:85
 call_netdevice_notifiers_info+0xbe/0x140 net/core/dev.c:2026
 call_netdevice_notifiers_extack net/core/dev.c:2064 [inline]
 call_netdevice_notifiers net/core/dev.c:2078 [inline]
 register_netdevice+0x17a0/0x1e90 net/core/dev.c:10651
page last free pid 5917 tgid 5917 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1127 [inline]
 free_unref_page+0x661/0x1080 mm/page_alloc.c:2659
 kasan_depopulate_vmalloc_pte+0x63/0x80 mm/kasan/shadow.c:408
 apply_to_pte_range mm/memory.c:2831 [inline]
 apply_to_pmd_range mm/memory.c:2875 [inline]
 apply_to_pud_range mm/memory.c:2911 [inline]
 apply_to_p4d_range mm/memory.c:2947 [inline]
 __apply_to_page_range+0x5fd/0xd30 mm/memory.c:2981
 kasan_release_vmalloc+0xd1/0xe0 mm/kasan/shadow.c:529
 kasan_release_vmalloc_node mm/vmalloc.c:2196 [inline]
 purge_vmap_node+0x1d1/0xa40 mm/vmalloc.c:2213
 __purge_vmap_area_lazy+0x9bf/0xc10 mm/vmalloc.c:2304
 drain_vmap_area_work+0x27/0x40 mm/vmalloc.c:2338
 process_one_work+0x9c5/0x1ba0 kernel/workqueue.c:3236
 process_scheduled_works kernel/workqueue.c:3317 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3398
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Memory state around the buggy address:
 ffff88804b54ff00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88804b54ff80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88804b550000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                               ^
 ffff88804b550080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88804b550100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

