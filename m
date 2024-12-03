Return-Path: <netdev+bounces-148597-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF1C49E2898
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 18:04:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CEC4167D3E
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 17:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50CF01F76C6;
	Tue,  3 Dec 2024 17:04:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574951FA150
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 17:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733245467; cv=none; b=I/aA2KuOq2yh9NmnoD7UVKd25yWaHdcfkTh37zSAkvIsQSEg92U49/dBSYeAfuZKxQrESiUJedRlJFVMtDNAwP/2JiUKCntRuhctFg2xwDx6JQp2dvepAz5CKjhosj1ZzLzUwReMM24zV7olGWPdfroF/gbSEOxFaaLww7N/GTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733245467; c=relaxed/simple;
	bh=OKmnXUqKtF9Xdqfkgx5y1x32aDqrELEBT7GJVVhiOBY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ll6fR48Nml71bOK1LR1Vp1Syw9jY4iJILXbrVc5gcQOpxIQObzNrB1tcuOHY8xQhL2UIP5jb9/YnxfnjA6RCQPgAbcbuoV7IIOl314MhMiLZerTKMsjWAeCCJxrHZKqDJaoykfHlPuJBCP0awnhQ3GcNVtFBfP4NRmryH6V9rj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-8418f68672eso491914639f.3
        for <netdev@vger.kernel.org>; Tue, 03 Dec 2024 09:04:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733245464; x=1733850264;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tIR9od3dmuyNEsLQHnGE8rzp5fwCpo+QDmeVsuttIU8=;
        b=FyHA/7sNzE8k6pM0EyeowbMNdb6wY7WNVrbSmK6rUm8u7qqmFo/5p1FKehf8EOZlIO
         yX5jPGxWDgLwPn2r0WPmva75rGJ4pNn0kTQEfj/LY8wft9nt934zrzbKRWMNk0hZxjdY
         jh+Y5RQiUB9qe/E+wlQX0oAunJlCS7BXgq33Fq6O1La1b29icGEC2/Qox/th1Y+CaitW
         /XwttX40B500Xht2+rIN+h88qrNf9k0mCrYc3EVnxMk4YqFxPKXJX+iQxcu1Y7CBe0If
         /bbcenF/69Ti5zXadKom35ke0Ax6U44gBRpZWNy+7PR1LJidjWBlc4j1qOanEle6ifim
         OTdA==
X-Forwarded-Encrypted: i=1; AJvYcCU9JK8oMD0rGpoaIcX5wp/riANXLsqvU/3TdH9ul3lDfKF+0TCNUjwn4oPTpLNK1dRmitsRPmg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8RodfOqL5ZI6vIFkQ2T8lO3q+7VBvE1Ntxo4iGSlFD4BzS/n5
	3z6MBfMPz6zozlLtM7feOVQrtVqfLB724D6hAmiRTy7Gz500vxW56tBMGxS+VQmig7PWuMqEgr5
	C3ZaJm4AtJ1AxRpByBiJT7m081R0/wj7/2TRgJg0Nb6yKNIb/DnB7vy8=
X-Google-Smtp-Source: AGHT+IFdRxypN4dxC4Bi/eh1NLri+mq5yGGLlyiny6BzU0tcHmvSHkpLpB39I4i5kYEF0bp5kH9hCqG/W26lc4wT/U7ZA5x9jXVH
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1529:b0:3a7:81c6:be7e with SMTP id
 e9e14a558f8ab-3a7f9a55b85mr45537505ab.13.1733245464360; Tue, 03 Dec 2024
 09:04:24 -0800 (PST)
Date: Tue, 03 Dec 2024 09:04:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <674f3a18.050a0220.48a03.0041.GAE@google.com>
Subject: [syzbot] [net?] KASAN: slab-use-after-free Read in __dev_get_by_index
From: syzbot <syzbot+1939f24bdb783e9e43d9@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    aaf20f870da0 Merge tag 'rpmsg-v6.13' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1733c3c0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=493f836b3188006b
dashboard link: https://syzkaller.appspot.com/bug?extid=1939f24bdb783e9e43d9
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-aaf20f87.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/88e73480de10/vmlinux-aaf20f87.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2ce03c25cff1/bzImage-aaf20f87.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1939f24bdb783e9e43d9@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 512
=======================================================
WARNING: The mand mount option has been deprecated and
         and is ignored by this kernel. Remove the mand
         option from the mount to silence this warning.
=======================================================
EXT4-fs (loop0): ext4_check_descriptors: Checksum for group 0 failed (17031!=33349)
[EXT4 FS bs=1024, gc=1, bpg=8192, ipg=32, mo=c842e12c, mo2=0002]
EXT4-fs (loop0): orphan cleanup on readonly fs
EXT4-fs error (device loop0): ext4_validate_block_bitmap:441: comm syz.0.0: bg 0: block 361: padding at end of block bitmap is not set
EXT4-fs (loop0): Remounting filesystem read-only
EXT4-fs (loop0): 1 truncate cleaned up
EXT4-fs (loop0): mounted filesystem 00000000-0000-0000-0000-000000000007 ro without journal. Quota mode: none.
netlink: 'syz.0.0': attribute type 10 has an invalid length.
netlink: 55 bytes leftover after parsing attributes in process `syz.0.0'.
==================================================================
BUG: KASAN: slab-use-after-free in __dev_get_by_index+0x5d/0x110 net/core/dev.c:852
Read of size 8 at addr ffff888043eba1b0 by task syz.0.0/5339

CPU: 0 UID: 0 PID: 5339 Comm: syz.0.0 Not tainted 6.12.0-syzkaller-10296-gaaf20f870da0 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:489
 kasan_report+0x143/0x180 mm/kasan/report.c:602
 __dev_get_by_index+0x5d/0x110 net/core/dev.c:852
 default_operstate net/core/link_watch.c:51 [inline]
 rfc2863_policy+0x224/0x300 net/core/link_watch.c:67
 linkwatch_do_dev+0x3e/0x170 net/core/link_watch.c:170
 netdev_run_todo+0x461/0x1000 net/core/dev.c:10894
 rtnl_unlock net/core/rtnetlink.c:152 [inline]
 rtnl_net_unlock include/linux/rtnetlink.h:133 [inline]
 rtnl_dellink+0x760/0x8d0 net/core/rtnetlink.c:3520
 rtnetlink_rcv_msg+0x791/0xcf0 net/core/rtnetlink.c:6911
 netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2541
 netlink_unicast_kernel net/netlink/af_netlink.c:1321 [inline]
 netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1347
 netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1891
 sock_sendmsg_nosec net/socket.c:711 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:726
 ____sys_sendmsg+0x52a/0x7e0 net/socket.c:2583
 ___sys_sendmsg net/socket.c:2637 [inline]
 __sys_sendmsg+0x269/0x350 net/socket.c:2669
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f2a3cb80809
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f2a3d9cd058 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f2a3cd45fa0 RCX: 00007f2a3cb80809
RDX: 0000000000000000 RSI: 0000000020000000 RDI: 0000000000000008
RBP: 00007f2a3cbf393e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f2a3cd45fa0 R15: 00007ffd03bc65c8
 </TASK>

Allocated by task 5339:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __kmalloc_cache_noprof+0x243/0x390 mm/slub.c:4314
 kmalloc_noprof include/linux/slab.h:901 [inline]
 kmalloc_array_noprof include/linux/slab.h:945 [inline]
 netdev_create_hash net/core/dev.c:11870 [inline]
 netdev_init+0x10c/0x250 net/core/dev.c:11890
 ops_init+0x31e/0x590 net/core/net_namespace.c:138
 setup_net+0x287/0x9e0 net/core/net_namespace.c:362
 copy_net_ns+0x33f/0x570 net/core/net_namespace.c:500
 create_new_namespaces+0x425/0x7b0 kernel/nsproxy.c:110
 unshare_nsproxy_namespaces+0x124/0x180 kernel/nsproxy.c:228
 ksys_unshare+0x57d/0xa70 kernel/fork.c:3314
 __do_sys_unshare kernel/fork.c:3385 [inline]
 __se_sys_unshare kernel/fork.c:3383 [inline]
 __x64_sys_unshare+0x38/0x40 kernel/fork.c:3383
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 12:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:582
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x59/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2338 [inline]
 slab_free mm/slub.c:4598 [inline]
 kfree+0x196/0x420 mm/slub.c:4746
 netdev_exit+0x65/0xd0 net/core/dev.c:11992
 ops_exit_list net/core/net_namespace.c:172 [inline]
 cleanup_net+0x802/0xcc0 net/core/net_namespace.c:632
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

The buggy address belongs to the object at ffff888043eba000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 432 bytes inside of
 freed 2048-byte region [ffff888043eba000, ffff888043eba800)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x43eb8
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0x4fff00000000040(head|node=1|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 04fff00000000040 ffff88801ac42000 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000080008 00000001f5000000 0000000000000000
head: 04fff00000000040 ffff88801ac42000 dead000000000122 0000000000000000
head: 0000000000000000 0000000000080008 00000001f5000000 0000000000000000
head: 04fff00000000003 ffffea00010fae01 ffffffffffffffff 0000000000000000
head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5339, tgid 5338 (syz.0.0), ts 69674195892, free_ts 69663220888
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1556
 prep_new_page mm/page_alloc.c:1564 [inline]
 get_page_from_freelist+0x3649/0x3790 mm/page_alloc.c:3474
 __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4751
 alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2265
 alloc_slab_page+0x6a/0x140 mm/slub.c:2408
 allocate_slab+0x5a/0x2f0 mm/slub.c:2574
 new_slab mm/slub.c:2627 [inline]
 ___slab_alloc+0xcd1/0x14b0 mm/slub.c:3815
 __slab_alloc+0x58/0xa0 mm/slub.c:3905
 __slab_alloc_node mm/slub.c:3980 [inline]
 slab_alloc_node mm/slub.c:4141 [inline]
 __do_kmalloc_node mm/slub.c:4282 [inline]
 __kmalloc_noprof+0x2e6/0x4c0 mm/slub.c:4295
 kmalloc_noprof include/linux/slab.h:905 [inline]
 sk_prot_alloc+0xe0/0x210 net/core/sock.c:2165
 sk_alloc+0x38/0x370 net/core/sock.c:2218
 __netlink_create+0x65/0x260 net/netlink/af_netlink.c:629
 __netlink_kernel_create+0x174/0x6f0 net/netlink/af_netlink.c:2015
 netlink_kernel_create include/linux/netlink.h:62 [inline]
 uevent_net_init+0xed/0x2d0 lib/kobject_uevent.c:783
 ops_init+0x31e/0x590 net/core/net_namespace.c:138
 setup_net+0x287/0x9e0 net/core/net_namespace.c:362
page last free pid 1032 tgid 1032 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1127 [inline]
 free_unref_page+0xdf9/0x1140 mm/page_alloc.c:2657
 __slab_free+0x31b/0x3d0 mm/slub.c:4509
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x9a/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x14f/0x170 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x23/0x80 mm/kasan/common.c:329
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4104 [inline]
 slab_alloc_node mm/slub.c:4153 [inline]
 kmem_cache_alloc_node_noprof+0x1d9/0x380 mm/slub.c:4205
 __alloc_skb+0x1c3/0x440 net/core/skbuff.c:668
 alloc_skb include/linux/skbuff.h:1323 [inline]
 alloc_skb_with_frags+0xc3/0x820 net/core/skbuff.c:6612
 sock_alloc_send_pskb+0x91a/0xa60 net/core/sock.c:2881
 sock_alloc_send_skb include/net/sock.h:1797 [inline]
 mld_newpack+0x1c3/0xaf0 net/ipv6/mcast.c:1747
 add_grhead net/ipv6/mcast.c:1850 [inline]
 add_grec+0x1492/0x19a0 net/ipv6/mcast.c:1988
 mld_send_initial_cr+0x228/0x4b0 net/ipv6/mcast.c:2234
 ipv6_mc_dad_complete+0x88/0x490 net/ipv6/mcast.c:2245
 addrconf_dad_completed+0x712/0xcd0 net/ipv6/addrconf.c:4342
 addrconf_dad_work+0xdc2/0x16f0
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310

Memory state around the buggy address:
 ffff888043eba080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888043eba100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888043eba180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                     ^
 ffff888043eba200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888043eba280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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

