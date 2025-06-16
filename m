Return-Path: <netdev+bounces-197992-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F83ADAC7D
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 11:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43C673B0937
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 09:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC35B273D95;
	Mon, 16 Jun 2025 09:57:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE762202961
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 09:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750067851; cv=none; b=lQui2X8U/pWvhPUQ0bFXYduRs71S1fPXdJlt3Mt2/nCZ4X/RKTCMSSf3gSR+NjX0iVf4Qw4Rbns/4CjqsGVSJpdOZtOj4JJMwL+6Yu6bNA2Q2CY4w8hmZH8muyIJVucSjzyNdfKue2RXAcbPIzDNmQf9+wsVAbd2CWqx7JTR41I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750067851; c=relaxed/simple;
	bh=9pvxKlJRuGuaJzigV3UiU+cRstKh92rE+en4Aj87FoE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=lrCwsAkNtomNZVmGVh614cG0kYZC13jZDEJt+RFAHjwBnmIgsf61HsJDSd4UeMcA3+WmKegX2dubpMJb2taAcMhw+wpBwWDQTQ/tsoc9TixIVf+tOrwa7u93GamFtfIAjMRPVMXw6+aNzbgrdDE0zXuDW0K73o4ZA4pokVFPCu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3ddafe52d04so119309545ab.1
        for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 02:57:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750067849; x=1750672649;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zqzi930/Af/A1FQIznieoXrwo29r+MkTDB1beLWH8Q8=;
        b=I9rrr0UMKPYoV5GUN0P3oWvbjx0R42Dw1O0zEBV2dFXpXiDCFpTindlYxwg6B3EooN
         fW8ota24IwI8eDGjBYbpo4ZPVFaxbQqt3nxCxLKADYnoXQ86HS4HmMGY8uN6TqPR0SBb
         Kl9tCN8aeyfXrUT/r6YD7rYoEauU4hpAW8Jwp/OP+qvGlLGN3OgvDONKnkD2kRTQEClW
         OCQWryaNwJ43Wv4g3hv8jDYbzO95TrYmBrtPx98bFoClLeKqDLsP9rT2UUh9FICLycwu
         8DX+2Qkl0JCoHdve61ga4zh5JrbpNSlIwhvgzkkEA+sOgbm9q5qXnvjJskzFdjBFQp7E
         6gJg==
X-Forwarded-Encrypted: i=1; AJvYcCUiE87WS7iIlR54ku+SlErjHkqXeVvGqE7MR2miXrF82GFovve8NmqPUsEKaii4fIGIQ+EelC8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/e77PFYRuNtZZCy8shdWbu8SNs7mhlIGaKjlLO2ehp7L9NkSP
	KzzL+ljCDxABxLGZAqH4qDks6IbWAw1+9M8Vu0vTNOCL7l4r7xfr10Q/3cS3QyUyJO44v5QEKmQ
	wc4B6YCX+lV6jpevebv/B1Kz7H6y5hngYcYKJrHHl8JzMZyGEWGJ6wQFJdEg=
X-Google-Smtp-Source: AGHT+IGu/Aqe+eMdCWcu2/Rn//7T/txmoZo1sMmYZuiz8Ib2lo+QCre2yTpeOnjNx7qeaImVgOAjkytjhAzrmqQtnG0isoABmaB1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12c2:b0:3dd:9164:906a with SMTP id
 e9e14a558f8ab-3de07cc2091mr85224305ab.13.1750067849054; Mon, 16 Jun 2025
 02:57:29 -0700 (PDT)
Date: Mon, 16 Jun 2025 02:57:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <684fea89.a00a0220.c6bd7.0016.GAE@google.com>
Subject: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in
 skb_queue_purge_reason (3)
From: syzbot <syzbot+ae5aca352a4531aa0b80@syzkaller.appspotmail.com>
To: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, marcel@holtmann.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    08207f42d3ff Merge branch 'ionic-cleanups' into main
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=16ea310c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c07f08ee4bcfb276
dashboard link: https://syzkaller.appspot.com/bug?extid=ae5aca352a4531aa0b80
compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6303da5c48e1/disk-08207f42.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9a4d9da7f446/vmlinux-08207f42.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f47d82134c95/bzImage-08207f42.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ae5aca352a4531aa0b80@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in skb_queue_empty_lockless include/linux/skbuff.h:1891 [inline]
BUG: KASAN: slab-use-after-free in skb_queue_purge_reason+0x99/0x360 net/core/skbuff.c:3937
Read of size 8 at addr ffff88807cb8d858 by task syz.1.219/6718

CPU: 1 UID: 0 PID: 6718 Comm: syz.1.219 Not tainted 6.16.0-rc1-syzkaller-00196-g08207f42d3ff #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:408 [inline]
 print_report+0xd2/0x2b0 mm/kasan/report.c:521
 kasan_report+0x118/0x150 mm/kasan/report.c:634
 skb_queue_empty_lockless include/linux/skbuff.h:1891 [inline]
 skb_queue_purge_reason+0x99/0x360 net/core/skbuff.c:3937
 skb_queue_purge include/linux/skbuff.h:3368 [inline]
 vhci_flush+0x44/0x50 drivers/bluetooth/hci_vhci.c:69
 hci_dev_do_reset net/bluetooth/hci_core.c:552 [inline]
 hci_dev_reset+0x420/0x5c0 net/bluetooth/hci_core.c:592
 sock_do_ioctl+0xd9/0x300 net/socket.c:1190
 sock_ioctl+0x576/0x790 net/socket.c:1311
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xf9/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fcf5b98e929
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fcf5c7b9038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fcf5bbb6160 RCX: 00007fcf5b98e929
RDX: 0000000000000000 RSI: 00000000400448cb RDI: 0000000000000009
RBP: 00007fcf5ba10b39 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fcf5bbb6160 R15: 00007ffd6353d528
 </TASK>

Allocated by task 6535:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __kmalloc_cache_noprof+0x230/0x3d0 mm/slub.c:4359
 kmalloc_noprof include/linux/slab.h:905 [inline]
 kzalloc_noprof include/linux/slab.h:1039 [inline]
 vhci_open+0x57/0x360 drivers/bluetooth/hci_vhci.c:635
 misc_open+0x2bc/0x330 drivers/char/misc.c:161
 chrdev_open+0x4c9/0x5e0 fs/char_dev.c:414
 do_dentry_open+0xdf0/0x1970 fs/open.c:964
 vfs_open+0x3b/0x340 fs/open.c:1094
 do_open fs/namei.c:3887 [inline]
 path_openat+0x2ee5/0x3830 fs/namei.c:4046
 do_filp_open+0x1fa/0x410 fs/namei.c:4073
 do_sys_openat2+0x121/0x1c0 fs/open.c:1437
 do_sys_open fs/open.c:1452 [inline]
 __do_sys_openat fs/open.c:1468 [inline]
 __se_sys_openat fs/open.c:1463 [inline]
 __x64_sys_openat+0x138/0x170 fs/open.c:1463
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 6535:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:576
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x62/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2381 [inline]
 slab_free mm/slub.c:4643 [inline]
 kfree+0x18e/0x440 mm/slub.c:4842
 vhci_release+0xbc/0xd0 drivers/bluetooth/hci_vhci.c:671
 __fput+0x44c/0xa70 fs/file_table.c:465
 task_work_run+0x1d1/0x260 kernel/task_work.c:227
 exit_task_work include/linux/task_work.h:40 [inline]
 do_exit+0x6ad/0x22e0 kernel/exit.c:955
 do_group_exit+0x21c/0x2d0 kernel/exit.c:1104
 __do_sys_exit_group kernel/exit.c:1115 [inline]
 __se_sys_exit_group kernel/exit.c:1113 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1113
 x64_sys_call+0x21ba/0x21c0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88807cb8d800
 which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 88 bytes inside of
 freed 1024-byte region [ffff88807cb8d800, ffff88807cb8dc00)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x7cb88
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
anon flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88801a441dc0 0000000000000000 dead000000000001
raw: 0000000000000000 0000000000100010 00000000f5000000 0000000000000000
head: 00fff00000000040 ffff88801a441dc0 0000000000000000 dead000000000001
head: 0000000000000000 0000000000100010 00000000f5000000 0000000000000000
head: 00fff00000000003 ffffea0001f2e201 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5851, tgid 5851 (syz-executor), ts 94364184033, free_ts 94332513750
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x240/0x2a0 mm/page_alloc.c:1704
 prep_new_page mm/page_alloc.c:1712 [inline]
 get_page_from_freelist+0x21e4/0x22c0 mm/page_alloc.c:3669
 __alloc_frozen_pages_noprof+0x181/0x370 mm/page_alloc.c:4959
 alloc_pages_mpol+0x232/0x4a0 mm/mempolicy.c:2419
 alloc_slab_page mm/slub.c:2451 [inline]
 allocate_slab+0x8a/0x3b0 mm/slub.c:2619
 new_slab mm/slub.c:2673 [inline]
 ___slab_alloc+0xbfc/0x1480 mm/slub.c:3859
 __slab_alloc mm/slub.c:3949 [inline]
 __slab_alloc_node mm/slub.c:4024 [inline]
 slab_alloc_node mm/slub.c:4185 [inline]
 __do_kmalloc_node mm/slub.c:4327 [inline]
 __kmalloc_node_noprof+0x2fd/0x4e0 mm/slub.c:4334
 kmalloc_node_noprof include/linux/slab.h:932 [inline]
 qdisc_alloc+0x97/0xaa0 net/sched/sch_generic.c:948
 qdisc_create_dflt+0x8e/0x4e0 net/sched/sch_generic.c:1010
 attach_one_default_qdisc net/sched/sch_generic.c:1176 [inline]
 netdev_for_each_tx_queue include/linux/netdevice.h:2655 [inline]
 attach_default_qdiscs net/sched/sch_generic.c:1194 [inline]
 dev_activate+0x378/0x1150 net/sched/sch_generic.c:1253
 __dev_open+0x69c/0x880 net/core/dev.c:1692
 __dev_change_flags+0x1ea/0x6d0 net/core/dev.c:9499
 netif_change_flags+0x88/0x1a0 net/core/dev.c:9562
 do_setlink+0xc55/0x41c0 net/core/rtnetlink.c:3141
 rtnl_changelink net/core/rtnetlink.c:3759 [inline]
 __rtnl_newlink net/core/rtnetlink.c:3918 [inline]
 rtnl_newlink+0x160b/0x1c70 net/core/rtnetlink.c:4055
 rtnetlink_rcv_msg+0x7cf/0xb70 net/core/rtnetlink.c:6944
page last free pid 5934 tgid 5934 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1248 [inline]
 __free_frozen_pages+0xc71/0xe70 mm/page_alloc.c:2706
 discard_slab mm/slub.c:2717 [inline]
 __put_partials+0x161/0x1c0 mm/slub.c:3186
 put_cpu_partial+0x17c/0x250 mm/slub.c:3261
 __slab_free+0x2f7/0x400 mm/slub.c:4513
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x97/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x148/0x160 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x22/0x80 mm/kasan/common.c:329
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4148 [inline]
 slab_alloc_node mm/slub.c:4197 [inline]
 kmem_cache_alloc_noprof+0x1c1/0x3c0 mm/slub.c:4204
 getname_flags+0xb8/0x540 fs/namei.c:146
 getname include/linux/fs.h:2903 [inline]
 do_sys_openat2+0xbc/0x1c0 fs/open.c:1431
 do_sys_open fs/open.c:1452 [inline]
 __do_sys_openat fs/open.c:1468 [inline]
 __se_sys_openat fs/open.c:1463 [inline]
 __x64_sys_openat+0x138/0x170 fs/open.c:1463
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff88807cb8d700: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88807cb8d780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88807cb8d800: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                    ^
 ffff88807cb8d880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88807cb8d900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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

