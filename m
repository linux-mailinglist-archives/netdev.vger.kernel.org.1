Return-Path: <netdev+bounces-201008-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B254AAE7D7C
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 11:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25CF71702A1
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 09:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A53232D662F;
	Wed, 25 Jun 2025 09:27:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80C52D663B
	for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 09:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750843650; cv=none; b=jjwJuMsfzknhbMiRCWdI17irkdAMtMOTZhR3McJJvD5yN/oHYJZQpM/RkF4UjtGrGxjMwUWnlrZz9SZSsnGtfxx/qSOXmf9c+RkSQ2oQGoDgVOJz+AQrIa86+5y2HmhjdMiIYwB0kZI0F0ebltxX8xPSBKjbY8pXQ0pD4es0JHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750843650; c=relaxed/simple;
	bh=Y1GFk7PlOHEcJ2m/1GUfA/nDryFjwkCMIcwJyWxHb6c=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=JLz5iHXKLxJF8uzmyDFHjq0jxJ3hM1WMyKpVnNdb2weT0ojUBPdQxCWVS1Kvy9X8Nr8QWronlis6M+SD0qNjfkl7eYKD6v959BGiz5mEwDWZLnEcogmwqA27RS56oqbSWQZvMOzSAJH4waLdVd/H/pFPp1aFMoUwspY1Co5PCUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3df309d9842so25411335ab.3
        for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 02:27:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750843648; x=1751448448;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2//FEPqslWZgdnOt/F+B4Qf0RlshSMYBAitdIwd7syY=;
        b=ATquAISRlA/sHziyKxKrScEIUpLzZoWHZfKtyFzY5/XGvo8LNxuh9g0c4mjWvADpmk
         yh341vbx4QXYx1HoU4ONKZ4Sn0/6bV/h5PaVI57kUNHqE/bjSVK+eCwBR2YQpk1MS+Pu
         5xli/sNx0XFNTFczeBLiOjR8T/CzGnRYfl7AVBWvZ0ya8qdeSRlPuCtdl3vIFBUbapZm
         S4andLotq4xbAXzQaSTyf/NV/8SrVZPuBkVgBV1+wyQJ3m8Fe5Xfmq9YUQGJGJ5gTILi
         3nmm0CycNho/exJ9hzwvJG3SfXminGjPOeYEcquT30wP+B8kEaKTguQIuaLDyoT32Cb3
         +jNA==
X-Forwarded-Encrypted: i=1; AJvYcCVmWdHyF3WkPZzWxAiSSxWjVqBoztB1Y3mxDdUgsv4SRyeYABMECYazmtZr6r0oJRBn/6KH+vc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCjDd86rpZFpWZm7DowknjSTI+eSAeFIbE6+l6wlZB8lvOpt5L
	EVu7Z6ixDV92wpUIQmVlBay7fd3O50jZ4FUxjACsrGBVaGIlcH+XJoZAzmiqUNqj5QgVTFvHXNw
	53IEmlNVSJ7WEk0NbcFJpgRtuFjAq/vSagl4FzA3E1YJbnL2pX7Ni/f4wco0=
X-Google-Smtp-Source: AGHT+IGxHe+HnCO0XkYhoudVoHvfr8xfezkGjrVEFeCPQwTlmGhHMzpRtMLWiiaL9ITshEbgHFEbwZhastD95ONcYl2MatwblD88
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2181:b0:3dd:d6c2:51fb with SMTP id
 e9e14a558f8ab-3df329224b9mr25836475ab.10.1750843648019; Wed, 25 Jun 2025
 02:27:28 -0700 (PDT)
Date: Wed, 25 Jun 2025 02:27:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <685bc100.a00a0220.2e5631.00c3.GAE@google.com>
Subject: [syzbot] [bridge?] KASAN: slab-use-after-free Read in br_multicast_has_router_adjacent
From: syzbot <syzbot+f53271ac312b49be132b@syzkaller.appspotmail.com>
To: bridge@lists.linux.dev, davem@davemloft.net, edumazet@google.com, 
	horms@kernel.org, idosch@nvidia.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	razor@blackwall.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    714db279942b CREDITS: Add entry for Shannon Nelson
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=11a59b0c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d11f52d3049c3790
dashboard link: https://syzkaller.appspot.com/bug?extid=f53271ac312b49be132b
compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4af647f77fe2/disk-714db279.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/df9d2caceadd/vmlinux-714db279.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f05e60d250ae/bzImage-714db279.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f53271ac312b49be132b@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in br_multicast_has_router_adjacent+0x401/0x4e0 net/bridge/br_multicast.c:5005
Read of size 8 at addr ffff8880584e11b0 by task kworker/u8:7/3505

CPU: 0 UID: 0 PID: 3505 Comm: kworker/u8:7 Not tainted 6.16.0-rc2-syzkaller-00161-g714db279942b #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
Workqueue: bat_events batadv_mcast_mla_update
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:408 [inline]
 print_report+0xd2/0x2b0 mm/kasan/report.c:521
 kasan_report+0x118/0x150 mm/kasan/report.c:634
 br_multicast_has_router_adjacent+0x401/0x4e0 net/bridge/br_multicast.c:5005
 batadv_mcast_mla_rtr_flags_bridge_get net/batman-adv/multicast.c:203 [inline]
 batadv_mcast_mla_rtr_flags_get net/batman-adv/multicast.c:232 [inline]
 batadv_mcast_mla_flags_get net/batman-adv/multicast.c:287 [inline]
 __batadv_mcast_mla_update net/batman-adv/multicast.c:909 [inline]
 batadv_mcast_mla_update+0x598/0x3670 net/batman-adv/multicast.c:948
 process_one_work kernel/workqueue.c:3238 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3321
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3402
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3f9/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Allocated by task 5849:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __kmalloc_cache_noprof+0x230/0x3d0 mm/slub.c:4359
 kmalloc_noprof include/linux/slab.h:905 [inline]
 kzalloc_noprof include/linux/slab.h:1039 [inline]
 new_nbp+0x188/0x440 net/bridge/br_if.c:431
 br_add_if+0x28e/0xec0 net/bridge/br_if.c:599
 do_set_master+0x533/0x6d0 net/core/rtnetlink.c:2946
 do_setlink+0xcf0/0x41c0 net/core/rtnetlink.c:3148
 rtnl_changelink net/core/rtnetlink.c:3759 [inline]
 __rtnl_newlink net/core/rtnetlink.c:3918 [inline]
 rtnl_newlink+0x160b/0x1c70 net/core/rtnetlink.c:4055
 rtnetlink_rcv_msg+0x7cf/0xb70 net/core/rtnetlink.c:6944
 netlink_rcv_skb+0x205/0x470 net/netlink/af_netlink.c:2534
 netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
 netlink_unicast+0x758/0x8d0 net/netlink/af_netlink.c:1339
 netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1883
 sock_sendmsg_nosec net/socket.c:712 [inline]
 __sock_sendmsg+0x219/0x270 net/socket.c:727
 __sys_sendto+0x3bd/0x520 net/socket.c:2180
 __do_sys_sendto net/socket.c:2187 [inline]
 __se_sys_sendto net/socket.c:2183 [inline]
 __x64_sys_sendto+0xde/0x100 net/socket.c:2183
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 23:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:576
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x62/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2381 [inline]
 slab_free mm/slub.c:4643 [inline]
 kfree+0x18e/0x440 mm/slub.c:4842
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x22b/0x480 lib/kobject.c:737
 rcu_do_batch kernel/rcu/tree.c:2576 [inline]
 rcu_core+0xca5/0x1710 kernel/rcu/tree.c:2832
 handle_softirqs+0x286/0x870 kernel/softirq.c:579
 run_ksoftirqd+0x9b/0x100 kernel/softirq.c:968
 smpboot_thread_fn+0x53f/0xa60 kernel/smpboot.c:164
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3f9/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Last potentially related work creation:
 kasan_save_stack+0x3e/0x60 mm/kasan/common.c:47
 kasan_record_aux_stack+0xbd/0xd0 mm/kasan/generic.c:548
 __call_rcu_common kernel/rcu/tree.c:3090 [inline]
 call_rcu+0x142/0x990 kernel/rcu/tree.c:3210
 br_del_if+0x146/0x320 net/bridge/br_if.c:739
 do_set_master+0x30f/0x6d0 net/core/rtnetlink.c:2930
 do_setlink+0xcf0/0x41c0 net/core/rtnetlink.c:3148
 rtnl_group_changelink net/core/rtnetlink.c:3773 [inline]
 __rtnl_newlink net/core/rtnetlink.c:3927 [inline]
 rtnl_newlink+0x149f/0x1c70 net/core/rtnetlink.c:4055
 rtnetlink_rcv_msg+0x7cf/0xb70 net/core/rtnetlink.c:6944
 netlink_rcv_skb+0x205/0x470 net/netlink/af_netlink.c:2534
 netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
 netlink_unicast+0x758/0x8d0 net/netlink/af_netlink.c:1339
 netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1883
 sock_sendmsg_nosec net/socket.c:712 [inline]
 __sock_sendmsg+0x219/0x270 net/socket.c:727
 ____sys_sendmsg+0x505/0x830 net/socket.c:2566
 ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2620
 __sys_sendmsg net/socket.c:2652 [inline]
 __do_sys_sendmsg net/socket.c:2657 [inline]
 __se_sys_sendmsg net/socket.c:2655 [inline]
 __x64_sys_sendmsg+0x19b/0x260 net/socket.c:2655
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff8880584e1000
 which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 432 bytes inside of
 freed 1024-byte region [ffff8880584e1000, ffff8880584e1400)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff8880584e6800 pfn:0x584e0
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000240(workingset|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000240 ffff88801a441dc0 ffffea0001f4b610 ffffea0001f43610
raw: ffff8880584e6800 000000000010000b 00000000f5000000 0000000000000000
head: 00fff00000000240 ffff88801a441dc0 ffffea0001f4b610 ffffea0001f43610
head: ffff8880584e6800 000000000010000b 00000000f5000000 0000000000000000
head: 00fff00000000003 ffffea0001613801 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd2820(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5849, tgid 5849 (syz-executor), ts 81278653145, free_ts 27530166521
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
 __kmalloc_node_track_caller_noprof+0x2f8/0x4e0 mm/slub.c:4347
 kmalloc_reserve+0x136/0x290 net/core/skbuff.c:601
 __alloc_skb+0x142/0x2d0 net/core/skbuff.c:670
 alloc_skb include/linux/skbuff.h:1336 [inline]
 nlmsg_new include/net/netlink.h:1041 [inline]
 br_info_notify+0x105/0x260 net/bridge/br_netlink.c:647
 br_add_if+0xbd9/0xec0 net/bridge/br_if.c:690
 do_set_master+0x533/0x6d0 net/core/rtnetlink.c:2946
 do_setlink+0xcf0/0x41c0 net/core/rtnetlink.c:3148
 rtnl_changelink net/core/rtnetlink.c:3759 [inline]
 __rtnl_newlink net/core/rtnetlink.c:3918 [inline]
 rtnl_newlink+0x160b/0x1c70 net/core/rtnetlink.c:4055
 rtnetlink_rcv_msg+0x7cf/0xb70 net/core/rtnetlink.c:6944
 netlink_rcv_skb+0x205/0x470 net/netlink/af_netlink.c:2534
page last free pid 1 tgid 1 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1248 [inline]
 __free_frozen_pages+0xc71/0xe70 mm/page_alloc.c:2706
 __free_pages mm/page_alloc.c:5071 [inline]
 free_contig_range+0x1bd/0x4a0 mm/page_alloc.c:6927
 destroy_args+0x7e/0x5d0 mm/debug_vm_pgtable.c:1009
 debug_vm_pgtable+0x412/0x450 mm/debug_vm_pgtable.c:1389
 do_one_initcall+0x233/0x820 init/main.c:1274
 do_initcall_level+0x137/0x1f0 init/main.c:1336
 do_initcalls+0x69/0xd0 init/main.c:1352
 kernel_init_freeable+0x3d9/0x570 init/main.c:1584
 kernel_init+0x1d/0x1d0 init/main.c:1474
 ret_from_fork+0x3f9/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Memory state around the buggy address:
 ffff8880584e1080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880584e1100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff8880584e1180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                     ^
 ffff8880584e1200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880584e1280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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

