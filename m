Return-Path: <netdev+bounces-176038-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C6DA686D9
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 09:33:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C03BC3B7CA7
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 08:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F512505D3;
	Wed, 19 Mar 2025 08:33:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0BA24F5A9
	for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 08:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742373210; cv=none; b=q/GRBFqZRaxD9YZJtG1W5ZdbtZ3Jh+RMOitEZpx3hesyV/PJiWJiIwaewjjN/5O/pyio4ayq8cCpF6Z1XlfNqYoxeK/QYCyBGqXm5VCiarG5aIl0Hn2Mv0bQTE5VEZmrqsCuDLS/EiXMrOjVfL+tOfUVDbRgI0NvtjhXtR7+PBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742373210; c=relaxed/simple;
	bh=sEuh+9fqfXIUEjULY76hQ6olq8pINeHBNElZHVITuvo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=OsxI2jvRCxQYi6/jPM9WF0Q2CNEpnwNpd31n3w0ULPshlT4fNzEy1TF+YKkJdaKvuuyd7ZuKNmMijn9n0OhnsyX+JC56YqS1BK1tIPXvd2wx3WRWGumEBriNXpfpJL76zqe71g/9zlCD8oNNbTOCqJTN6NYz8BhAI12JKAxGXOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-85db4460f5dso1135831339f.0
        for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 01:33:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742373208; x=1742978008;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vWwXBWpOg1/Y9YZJqbWSjKAG4AyrbwafZOaf/QVDhgo=;
        b=tBNyS9hCrQuF5/pDuyMXq9D2+q3r/YF4O5ojVUN38Tqgirfqm9wf9NEG8/vQeABhGu
         HkxiS1WzEeEiY6Yb+wd1vydrHYwA/r6igzo4U/z7MOn+c1VYlWNPIRKU6QMx0A4l9tLj
         O11yoFc+UXfkXzRFfMo4fZV4SS700gPUDvbFj4Zm9ZS5rD6QaM47Fs42cJ8J1HMGGOBW
         Yiu9kvMutBChzuGuvChkg8wdC1kYqrWz9jKxzp3hNkptLkRJjv9RW5L4IIwslSzZBdRS
         HHYcPTmSMFDZ25GXCH5j5Bu/LgQWHGkR+/3szzNSUda3bgvdSh5SJgef3F7umpMgR6nZ
         cYIw==
X-Forwarded-Encrypted: i=1; AJvYcCWXVNyK4uDcnIFpdPJ1eIrR96RlGo4Ot+H4VV21wsm7WdmDb5QCfVXA0ojfYnhimTev8zlB9ww=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzhmv1ki1znv39NCCbUVOawX+J6IOWLnwnHJkr/yg4xrffa/n+w
	MoyiHJS3hJ82z5XIkhIQ7n2WQx1FjJwf29Hm7x64H1qg1FUvgMGQUAFe/edNChVMzOTUdRaG6yJ
	/zCh4FcHZVKaC3mR4C394wQhEkgR60q1IindDOJjWc/zX24hge731sOM=
X-Google-Smtp-Source: AGHT+IFn1Vdy6oqDrjJMRqymg8tAzqOGVySi6u7trGQRYh3VJAbRKzjN8Y49v/lUa+UbAY2K3RKSBNApn4ER0EeOYLPa4sb/J8Et
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1908:b0:3d4:341a:441d with SMTP id
 e9e14a558f8ab-3d586b30608mr19152105ab.10.1742373208242; Wed, 19 Mar 2025
 01:33:28 -0700 (PDT)
Date: Wed, 19 Mar 2025 01:33:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67da8158.050a0220.3657bb.013f.GAE@google.com>
Subject: [syzbot] [net?] KASAN: slab-use-after-free Read in udp_tunnel_update_gro_lookup
From: syzbot <syzbot+1fb3291cc1beeb3c315a@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    23c9ff659140 Merge branch 'net-stmmac-remove-unnecessary-o..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=109925e4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=aeeec842a6bdc8b9
dashboard link: https://syzkaller.appspot.com/bug?extid=1fb3291cc1beeb3c315a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c325a67439ff/disk-23c9ff65.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7fdb9709d1a6/vmlinux-23c9ff65.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e7d7be5c9841/bzImage-23c9ff65.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1fb3291cc1beeb3c315a@syzkaller.appspotmail.com

netlink: 'syz.2.655': attribute type 39 has an invalid length.
==================================================================
BUG: KASAN: slab-use-after-free in udp_tunnel_update_gro_lookup+0x23c/0x2c0 net/ipv4/udp_offload.c:65
Read of size 8 at addr ffff88801235ebe8 by task syz.2.655/7921

CPU: 1 UID: 0 PID: 7921 Comm: syz.2.655 Not tainted 6.14.0-rc6-syzkaller-01313-g23c9ff659140 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:408 [inline]
 print_report+0x16e/0x5b0 mm/kasan/report.c:521
 kasan_report+0x143/0x180 mm/kasan/report.c:634
 udp_tunnel_update_gro_lookup+0x23c/0x2c0 net/ipv4/udp_offload.c:65
 sk_common_release+0x71/0x2e0 net/core/sock.c:3896
 inet_release+0x17d/0x200 net/ipv4/af_inet.c:435
 __sock_release net/socket.c:647 [inline]
 sock_release+0x82/0x150 net/socket.c:675
 sock_free drivers/net/wireguard/socket.c:339 [inline]
 wg_socket_reinit+0x215/0x380 drivers/net/wireguard/socket.c:435
 wg_stop+0x59f/0x600 drivers/net/wireguard/device.c:133
 __dev_close_many+0x3a6/0x700 net/core/dev.c:1717
 dev_close_many+0x24e/0x4c0 net/core/dev.c:1742
 unregister_netdevice_many_notify+0x629/0x24f0 net/core/dev.c:11923
 rtnl_delete_link net/core/rtnetlink.c:3512 [inline]
 rtnl_dellink+0x526/0x8c0 net/core/rtnetlink.c:3554
 rtnetlink_rcv_msg+0x791/0xcf0 net/core/rtnetlink.c:6945
 netlink_rcv_skb+0x206/0x480 net/netlink/af_netlink.c:2534
 netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
 netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1339
 netlink_sendmsg+0x8de/0xcb0 net/netlink/af_netlink.c:1883
 sock_sendmsg_nosec net/socket.c:709 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:724
 ____sys_sendmsg+0x53a/0x860 net/socket.c:2564
 ___sys_sendmsg net/socket.c:2618 [inline]
 __sys_sendmsg+0x269/0x350 net/socket.c:2650
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f35ab38d169
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f35ac28f038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f35ab5a6160 RCX: 00007f35ab38d169
RDX: 0000000000000000 RSI: 0000400000000000 RDI: 0000000000000004
RBP: 00007f35ab40e2a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007f35ab5a6160 R15: 00007ffdddd781b8
 </TASK>

Allocated by task 7770:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:319 [inline]
 __kasan_slab_alloc+0x66/0x80 mm/kasan/common.c:345
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4115 [inline]
 slab_alloc_node mm/slub.c:4164 [inline]
 kmem_cache_alloc_noprof+0x1d9/0x380 mm/slub.c:4171
 sk_prot_alloc+0x58/0x210 net/core/sock.c:2190
 sk_alloc+0x3e/0x370 net/core/sock.c:2249
 inet_create+0x648/0xea0 net/ipv4/af_inet.c:326
 __sock_create+0x4c0/0xa30 net/socket.c:1539
 sock_create net/socket.c:1597 [inline]
 __sys_socket_create net/socket.c:1634 [inline]
 __sys_socket+0x150/0x3c0 net/socket.c:1681
 __do_sys_socket net/socket.c:1695 [inline]
 __se_sys_socket net/socket.c:1693 [inline]
 __x64_sys_socket+0x7a/0x90 net/socket.c:1693
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 7768:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:576
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x59/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2353 [inline]
 slab_free mm/slub.c:4609 [inline]
 kmem_cache_free+0x195/0x410 mm/slub.c:4711
 sk_prot_free net/core/sock.c:2230 [inline]
 __sk_destruct+0x4fd/0x690 net/core/sock.c:2327
 inet_release+0x17d/0x200 net/ipv4/af_inet.c:435
 __sock_release net/socket.c:647 [inline]
 sock_close+0xbc/0x240 net/socket.c:1389
 __fput+0x3e9/0x9f0 fs/file_table.c:464
 task_work_run+0x24f/0x310 kernel/task_work.c:227
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x13f/0x340 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88801235e4c0
 which belongs to the cache UDP of size 1856
The buggy address is located 1832 bytes inside of
 freed 1856-byte region [ffff88801235e4c0, ffff88801235ec00)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff88801235be00 pfn:0x12358
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
memcg:ffff88802f542d01
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff888023294780 dead000000000122 0000000000000000
raw: ffff88801235be00 000000008010000c 00000000f5000000 ffff88802f542d01
head: 00fff00000000040 ffff888023294780 dead000000000122 0000000000000000
head: ffff88801235be00 000000008010000c 00000000f5000000 ffff88802f542d01
head: 00fff00000000003 ffffea000048d601 ffffffffffffffff 0000000000000000
head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5831, tgid 5831 (syz-executor), ts 69973022954, free_ts 69950034125
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f4/0x240 mm/page_alloc.c:1551
 prep_new_page mm/page_alloc.c:1559 [inline]
 get_page_from_freelist+0x365c/0x37a0 mm/page_alloc.c:3477
 __alloc_frozen_pages_noprof+0x292/0x710 mm/page_alloc.c:4740
 alloc_pages_mpol+0x311/0x660 mm/mempolicy.c:2270
 alloc_slab_page mm/slub.c:2423 [inline]
 allocate_slab+0x8f/0x3a0 mm/slub.c:2587
 new_slab mm/slub.c:2640 [inline]
 ___slab_alloc+0xc27/0x14a0 mm/slub.c:3826
 __slab_alloc+0x58/0xa0 mm/slub.c:3916
 __slab_alloc_node mm/slub.c:3991 [inline]
 slab_alloc_node mm/slub.c:4152 [inline]
 kmem_cache_alloc_noprof+0x268/0x380 mm/slub.c:4171
 sk_prot_alloc+0x58/0x210 net/core/sock.c:2190
 sk_alloc+0x3e/0x370 net/core/sock.c:2249
 inet_create+0x648/0xea0 net/ipv4/af_inet.c:326
 __sock_create+0x4c0/0xa30 net/socket.c:1539
 udp_sock_create4+0xda/0x670 net/ipv4/udp_tunnel_core.c:18
 udp_sock_create include/net/udp_tunnel.h:59 [inline]
 geneve_create_sock drivers/net/geneve.c:487 [inline]
 geneve_socket_create drivers/net/geneve.c:600 [inline]
 geneve_sock_add+0x469/0xc40 drivers/net/geneve.c:687
 geneve_open+0xe3/0x160 drivers/net/geneve.c:729
 __dev_open+0x45a/0x8a0 net/core/dev.c:1644
page last free pid 5832 tgid 5832 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1127 [inline]
 free_frozen_pages+0xe0d/0x10e0 mm/page_alloc.c:2660
 discard_slab mm/slub.c:2684 [inline]
 __put_partials+0x160/0x1c0 mm/slub.c:3153
 put_cpu_partial+0x17c/0x250 mm/slub.c:3228
 __slab_free+0x290/0x380 mm/slub.c:4479
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x9a/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x14f/0x170 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x23/0x80 mm/kasan/common.c:329
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4115 [inline]
 slab_alloc_node mm/slub.c:4164 [inline]
 kmem_cache_alloc_noprof+0x1d9/0x380 mm/slub.c:4171
 getname_kernel+0x59/0x2f0 fs/namei.c:250
 kern_path+0x1d/0x50 fs/namei.c:2772
 do_loopback+0xc9/0x4f0 fs/namespace.c:2817
 do_mount fs/namespace.c:3900 [inline]
 __do_sys_mount fs/namespace.c:4111 [inline]
 __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:4088
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff88801235ea80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88801235eb00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88801235eb80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                          ^
 ffff88801235ec00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88801235ec80: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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

