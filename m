Return-Path: <netdev+bounces-149762-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E7B9E7500
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 16:59:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B46C4161C70
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 15:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E9F207E1A;
	Fri,  6 Dec 2024 15:59:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC96E1494D9
	for <netdev@vger.kernel.org>; Fri,  6 Dec 2024 15:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733500767; cv=none; b=IyHcvqdjrEVgQ7hzBZg/75uGnSeTGVi8cW3YVfEBHfvUZlRotflVOqLlhtzb6kp9ymg4XRb9f+ZiVjbRMlBZ0D5R1ULtJme3CGClU0fZnF/QB6TBGiQH8f4lNC2ZpeVCoSvouwo2HVNW9AlvJH54h2uYop4y6+Ex0BJkjIWUavk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733500767; c=relaxed/simple;
	bh=/ky0yQHz4SU4tu9jIR+3/ZPIPyavBxPgu30lBIA8gNQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=RHV82s6VtxZCY5InaxxGs9SzR7pQpNzIA81iZRSd2ca9aPNbWMG8gz1n6df2DvmKL4iaoLyAT5MEo6dwNFk3oluALJ/e2iagkpCTv/i9XIIapq5fBh/gBy3H3Pl6Gq9upT8yxQ8NhZEZUKRu1S6xDGBsMoNoiHl2F4fkjsau4WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3a7d87dfd9bso27440005ab.0
        for <netdev@vger.kernel.org>; Fri, 06 Dec 2024 07:59:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733500765; x=1734105565;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GSrOX4CYYlKSnuwvmJskYznO3/ixgiDxGUOpNg1PDWk=;
        b=YOV/WdHdhEVoATaIXXVHAC8O/FiMNe5UL+pjpqq2ECg51lTkgggzZ6c4/cjA7GWxcV
         VgMX2sIHOB1E00fcwb5w3ParlCBFmMoizWX23eZeAWgbP2JAbRaBzB1GHWFptaXObdNh
         ttpGixhKq8k9ta8ugO1co9WdSBdnVtRhiiFDwHHGKDKjwj6H8HzUDbVKWk9W1XG8kf39
         DlngtlpywA1RDvpyx9s6LlNFZeUD9G25BkZcl2t/8iWNBaatn3lSOed7Bm71MzYRiIAr
         o+Tho7SXLvnCIbp3mBR33DSfRX4qbmSTxEW4Np2mGN0xtGGK+QJ1ZyPRoFvWXBKVFWCY
         9Zpg==
X-Forwarded-Encrypted: i=1; AJvYcCUjPJMRaXisbStc2lg+1uSCUs8911hXl2beApDcCdRzIAzDvEsoYIW2yaav5o45PVze6RWtxVg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyZ0tQBSgE8b9IwfXV733PIwIEcufmtlih9SDSbsmeOLXjunKV
	g4c1qQjDKBW3uBfTWbGU98ePSDIR0J8howUJyH5U5mCc1ODomONxmfjlfn7Z4d7oVVTl5sG/hjI
	vzxBY4N2o/dTlWLVX+KpeRpB03dS+SIzFnOP5SRQ0OeY11POBWM2a8jI=
X-Google-Smtp-Source: AGHT+IFtpxgiyX8T0QqwW9z+5T8W/6nq5tUg8v6j42sx5oXZubLJ2J2Ac0P/KbiL0fz3SQfAj79coxdDKXTgstbYaiEFzgwGzm4m
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:19ca:b0:3a7:6c6a:e2a2 with SMTP id
 e9e14a558f8ab-3a811d7812cmr47653305ab.9.1733500765192; Fri, 06 Dec 2024
 07:59:25 -0800 (PST)
Date: Fri, 06 Dec 2024 07:59:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67531f5d.050a0220.2477f.0006.GAE@google.com>
Subject: [syzbot] [net?] [s390?] KASAN: slab-use-after-free Read in netdev_walk_all_lower_dev
From: syzbot <syzbot+2eab87cf3100f45423ec@syzkaller.appspotmail.com>
To: agordeev@linux.ibm.com, alibuda@linux.alibaba.com, davem@davemloft.net, 
	edumazet@google.com, guwen@linux.alibaba.com, horms@kernel.org, 
	jaka@linux.ibm.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	tonylu@linux.alibaba.com, wenjia@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    896d8946da97 Merge tag 'net-6.13-rc2' of git://git.kernel...
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=176a18df980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1362a5aee630ff34
dashboard link: https://syzkaller.appspot.com/bug?extid=2eab87cf3100f45423ec
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10de5330580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d9f3eeec9a50/disk-896d8946.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4d3aee65183c/vmlinux-896d8946.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b0806603e601/bzImage-896d8946.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2eab87cf3100f45423ec@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in netdev_next_lower_dev net/core/dev.c:7522 [inline]
BUG: KASAN: slab-use-after-free in netdev_walk_all_lower_dev+0x131/0x390 net/core/dev.c:7570
Read of size 8 at addr ffff88805f8b81b8 by task syz.0.15/6035

CPU: 0 UID: 0 PID: 6035 Comm: syz.0.15 Not tainted 6.13.0-rc1-syzkaller-00170-g896d8946da97 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:489
 kasan_report+0x143/0x180 mm/kasan/report.c:602
 netdev_next_lower_dev net/core/dev.c:7522 [inline]
 netdev_walk_all_lower_dev+0x131/0x390 net/core/dev.c:7570
 smc_vlan_by_tcpsk+0x3ab/0x4e0 net/smc/smc_core.c:1899
 __smc_connect+0x292/0x1850 net/smc/af_smc.c:1517
 smc_connect+0x868/0xde0 net/smc/af_smc.c:1693
 __sys_connect_file net/socket.c:2055 [inline]
 __sys_connect+0x288/0x2d0 net/socket.c:2074
 __do_sys_connect net/socket.c:2080 [inline]
 __se_sys_connect net/socket.c:2077 [inline]
 __x64_sys_connect+0x7a/0x90 net/socket.c:2077
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f7f29d7ff19
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f7f2ab9b058 EFLAGS: 00000246 ORIG_RAX: 000000000000002a
RAX: ffffffffffffffda RBX: 00007f7f29f46240 RCX: 00007f7f29d7ff19
RDX: 000000000000001c RSI: 0000000020000080 RDI: 000000000000000c
RBP: 00007f7f29df3986 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f7f29f46240 R15: 00007ffe913e1c98
 </TASK>

Allocated by task 5919:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __do_kmalloc_node mm/slub.c:4283 [inline]
 __kmalloc_node_noprof+0x290/0x4d0 mm/slub.c:4289
 __kvmalloc_node_noprof+0x72/0x190 mm/util.c:650
 alloc_netdev_mqs+0xa4/0x1080 net/core/dev.c:11209
 rtnl_create_link+0x2f9/0xc20 net/core/rtnetlink.c:3595
 rtnl_newlink_create+0x210/0xa40 net/core/rtnetlink.c:3771
 __rtnl_newlink net/core/rtnetlink.c:3896 [inline]
 rtnl_newlink+0x1b40/0x20e0 net/core/rtnetlink.c:4009
 rtnetlink_rcv_msg+0x791/0xcf0 net/core/rtnetlink.c:6919
 netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2542
 netlink_unicast_kernel net/netlink/af_netlink.c:1321 [inline]
 netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1347
 netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1891
 sock_sendmsg_nosec net/socket.c:711 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:726
 __sys_sendto+0x363/0x4c0 net/socket.c:2197
 __do_sys_sendto net/socket.c:2204 [inline]
 __se_sys_sendto net/socket.c:2200 [inline]
 __x64_sys_sendto+0xde/0x100 net/socket.c:2200
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 6033:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:582
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x59/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2338 [inline]
 slab_free mm/slub.c:4598 [inline]
 kfree+0x196/0x430 mm/slub.c:4746
 device_release+0x99/0x1c0
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x22f/0x480 lib/kobject.c:737
 netdev_run_todo+0xe79/0x1000 net/core/dev.c:10924
 rtnl_unlock net/core/rtnetlink.c:152 [inline]
 rtnl_net_unlock include/linux/rtnetlink.h:133 [inline]
 rtnl_dellink+0x760/0x8d0 net/core/rtnetlink.c:3526
 rtnetlink_rcv_msg+0x791/0xcf0 net/core/rtnetlink.c:6919
 netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2542
 netlink_unicast_kernel net/netlink/af_netlink.c:1321 [inline]
 netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1347
 netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1891
 sock_sendmsg_nosec net/socket.c:711 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:726
 sock_write_iter+0x2d7/0x3f0 net/socket.c:1147
 new_sync_write fs/read_write.c:586 [inline]
 vfs_write+0xaeb/0xd30 fs/read_write.c:679
 ksys_write+0x18f/0x2b0 fs/read_write.c:731
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Last potentially related work creation:
 kasan_save_stack+0x3f/0x60 mm/kasan/common.c:47
 __kasan_record_aux_stack+0xac/0xc0 mm/kasan/generic.c:544
 insert_work+0x3e/0x330 kernel/workqueue.c:2183
 __queue_work+0xc8b/0xf50 kernel/workqueue.c:2339
 queue_work_on+0x1c2/0x380 kernel/workqueue.c:2390
 queue_work include/linux/workqueue.h:662 [inline]
 schedule_work include/linux/workqueue.h:723 [inline]
 __rhashtable_remove_fast_one include/linux/rhashtable.h:1069 [inline]
 __rhashtable_remove_fast include/linux/rhashtable.h:1093 [inline]
 rhashtable_remove_fast+0xd63/0xe20 include/linux/rhashtable.h:1122
 br_multicast_del_mdb_entry net/bridge/br_multicast.c:642 [inline]
 br_multicast_dev_del+0x157/0x5e0 net/bridge/br_multicast.c:4366
 br_dev_uninit+0x1c/0x40 net/bridge/br_device.c:155
 unregister_netdevice_many_notify+0x1735/0x1da0 net/core/dev.c:11548
 rtnl_delete_link net/core/rtnetlink.c:3476 [inline]
 rtnl_dellink+0x52b/0x8d0 net/core/rtnetlink.c:3518
 rtnetlink_rcv_msg+0x791/0xcf0 net/core/rtnetlink.c:6919
 netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2542
 netlink_unicast_kernel net/netlink/af_netlink.c:1321 [inline]
 netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1347
 netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1891
 sock_sendmsg_nosec net/socket.c:711 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:726
 sock_write_iter+0x2d7/0x3f0 net/socket.c:1147
 new_sync_write fs/read_write.c:586 [inline]
 vfs_write+0xaeb/0xd30 fs/read_write.c:679
 ksys_write+0x18f/0x2b0 fs/read_write.c:731
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Second to last potentially related work creation:
 kasan_save_stack+0x3f/0x60 mm/kasan/common.c:47
 __kasan_record_aux_stack+0xac/0xc0 mm/kasan/generic.c:544
 insert_work+0x3e/0x330 kernel/workqueue.c:2183
 __queue_work+0xc8b/0xf50 kernel/workqueue.c:2339
 queue_work_on+0x1c2/0x380 kernel/workqueue.c:2390
 queue_work include/linux/workqueue.h:662 [inline]
 br_multicast_del_mdb_entry net/bridge/br_multicast.c:646 [inline]
 br_multicast_dev_del+0x342/0x5e0 net/bridge/br_multicast.c:4366
 br_dev_uninit+0x1c/0x40 net/bridge/br_device.c:155
 unregister_netdevice_many_notify+0x1735/0x1da0 net/core/dev.c:11548
 rtnl_delete_link net/core/rtnetlink.c:3476 [inline]
 rtnl_dellink+0x52b/0x8d0 net/core/rtnetlink.c:3518
 rtnetlink_rcv_msg+0x791/0xcf0 net/core/rtnetlink.c:6919
 netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2542
 netlink_unicast_kernel net/netlink/af_netlink.c:1321 [inline]
 netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1347
 netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1891
 sock_sendmsg_nosec net/socket.c:711 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:726
 sock_write_iter+0x2d7/0x3f0 net/socket.c:1147
 new_sync_write fs/read_write.c:586 [inline]
 vfs_write+0xaeb/0xd30 fs/read_write.c:679
 ksys_write+0x18f/0x2b0 fs/read_write.c:731
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88805f8b8000
 which belongs to the cache kmalloc-cg-8k of size 8192
The buggy address is located 440 bytes inside of
 freed 8192-byte region [ffff88805f8b8000, ffff88805f8ba000)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x5f8b8
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
memcg:ffff888030fab001
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88801ac4f640 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000020002 00000001f5000000 ffff888030fab001
head: 00fff00000000040 ffff88801ac4f640 dead000000000122 0000000000000000
head: 0000000000000000 0000000000020002 00000001f5000000 ffff888030fab001
head: 00fff00000000003 ffffea00017e2e01 ffffffffffffffff 0000000000000000
head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd60c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_RETRY_MAYFAIL|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5919, tgid 5919 (syz-executor), ts 71968276413, free_ts 71704730558
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1556
 prep_new_page mm/page_alloc.c:1564 [inline]
 get_page_from_freelist+0x365c/0x37a0 mm/page_alloc.c:3474
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
 __kmalloc_node_noprof+0x2ee/0x4d0 mm/slub.c:4289
 __kvmalloc_node_noprof+0x72/0x190 mm/util.c:650
 alloc_netdev_mqs+0xa4/0x1080 net/core/dev.c:11209
 rtnl_create_link+0x2f9/0xc20 net/core/rtnetlink.c:3595
 rtnl_newlink_create+0x210/0xa40 net/core/rtnetlink.c:3771
 __rtnl_newlink net/core/rtnetlink.c:3896 [inline]
 rtnl_newlink+0x1b40/0x20e0 net/core/rtnetlink.c:4009
 rtnetlink_rcv_msg+0x791/0xcf0 net/core/rtnetlink.c:6919
 netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2542
page last free pid 5866 tgid 5866 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1127 [inline]
 free_unref_page+0xdef/0x1130 mm/page_alloc.c:2657
 vfree+0x186/0x2e0 mm/vmalloc.c:3382
 kcov_put kernel/kcov.c:439 [inline]
 kcov_close+0x28/0x50 kernel/kcov.c:535
 __fput+0x23c/0xa50 fs/file_table.c:450
 task_work_run+0x24f/0x310 kernel/task_work.c:239
 exit_task_work include/linux/task_work.h:43 [inline]
 do_exit+0xa2f/0x28e0 kernel/exit.c:938
 do_group_exit+0x207/0x2c0 kernel/exit.c:1087
 get_signal+0x16b2/0x1750 kernel/signal.c:3017
 arch_do_signal_or_restart+0x96/0x860 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0xce/0x340 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff88805f8b8080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88805f8b8100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88805f8b8180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                        ^
 ffff88805f8b8200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88805f8b8280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

