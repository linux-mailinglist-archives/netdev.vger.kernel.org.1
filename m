Return-Path: <netdev+bounces-235016-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A86F9C2B48F
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 12:20:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 35A814EAAC3
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 11:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 826CF3016E4;
	Mon,  3 Nov 2025 11:20:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19EF2FF15D
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 11:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762168842; cv=none; b=iE5UZ01KqYNAyBn1VB3WztUe2BIXYlvUW70wGaicXRdlsnV4ETIBpqgA4fjWb9cJhZrXnO8fo7Sza19UzAGLc6DBvvJ04uHi0g0euPNmya4Z1UbWCcNnNvQwZyYAu4QEyGQRzr7eG+bwoBvtVjvLz4xxoUxpHNZPeh/PmgwMYmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762168842; c=relaxed/simple;
	bh=S/yG6gRhhhzJqWkyNQd+B10jsk7xx+8CBhb9ERcRTOg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=JppF8nxXUsLBWsoio189f3XfWmkNSCTRcfNigJSVRdKmotRA9IOk5RTBToe2WT3ntG8IFI0VyMMoGHoVYoV8mFegysquBkjTOGaHxjYTGuK7R/TB2MluqSwvSOZ9mvk6k8I/rJksGQ4cs6bQaaMX96q6rS7t/hMCV6rM3ZbmqHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-94389ae547cso385381339f.2
        for <netdev@vger.kernel.org>; Mon, 03 Nov 2025 03:20:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762168839; x=1762773639;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qGgUjc8bnDbgLFKyRYg+F31Jn5Kljp1psn7vtHVfqXI=;
        b=wjrdQUMjklfo8DYOWZkqPgRbE+OB+rCaj2ob51+u7gaqd+zSbwA83avLfeZHZqV++e
         Q5+FtcjYU5gXjaWc5yZznSUBc41Z9W8TfvL1v6fg8Nq6C+le4y/Pm6/WSCMSdmUSE700
         nWRQmhJjnMpbVb838AwyhL91LWsQ6JD28UE8/9IKVkuuqJ8JgNShIvPkYXzDgJZUoy2c
         NcSE5FAxjhXS8UXtr6BVEctavRzX/hmSV4ZMV4MsXxdk4+jQPix/vmWdAioiPc53ujXV
         0Srum+4L/tXtz9+4Vpe/q97DU+3UTHNJtDtDj6NDczlQg1hbcQVnk1Qa7ktB4niPpwo+
         rd3w==
X-Forwarded-Encrypted: i=1; AJvYcCXKc8t6+pmZVy9+3dPH0X0ovccrqXUBU6zsd67MlYxM+eIVgOwII2G2ZFt1sq12XqGm5Ugcj8U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIQhEtj4C4o0PtB7FfmbpL9f3z4IzcOH1LlG4kBWaNMNGPNl5H
	uns4nbz8lU+GJkdA2em0xlG3Ogdw48hz3Gx2rKIl6lgkM3I1WLAU/8T1KD7D+JoC+JOiIh70tcW
	zi7M7yzkf4lW1erkExuL1iQDyW6zuEQW+78/ntaFxC/Y45q9TYbVrKQ9LKaM=
X-Google-Smtp-Source: AGHT+IHTTV/oRqrke/u+oYUWpA+4nE2Nbx5045bcGXRvYb9BEdcZG4INAr4DD7lQCIeyaa/6agoYGZNb82U5KHaGOxrjQVB9YYj4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3f81:b0:93e:7f36:a90f with SMTP id
 ca18e2360f4ac-9482291deefmr1880496439f.3.1762168826765; Mon, 03 Nov 2025
 03:20:26 -0800 (PST)
Date: Mon, 03 Nov 2025 03:20:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69088ffa.050a0220.29fc44.003d.GAE@google.com>
Subject: [syzbot] [bridge?] KASAN: slab-use-after-free Read in br_switchdev_fdb_populate
From: syzbot <syzbot+dd280197f0f7ab3917be@syzkaller.appspotmail.com>
To: bridge@lists.linux.dev, davem@davemloft.net, edumazet@google.com, 
	horms@kernel.org, idosch@nvidia.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	razor@blackwall.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    fd57572253bc Merge tag 'sched_ext-for-6.18-rc3-fixes' of g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13f957e2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=609c87dcb0628493
dashboard link: https://syzkaller.appspot.com/bug?extid=dd280197f0f7ab3917be
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a4541b741dd8/disk-fd575722.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/eae4ddf523dd/vmlinux-fd575722.xz
kernel image: https://storage.googleapis.com/syzbot-assets/28e03b35c3fc/bzImage-fd575722.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+dd280197f0f7ab3917be@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in br_switchdev_fdb_populate+0x390/0x3a0 net/bridge/br_switchdev.c:141
Read of size 8 at addr ffff888025122808 by task kworker/0:2/977

CPU: 0 UID: 0 PID: 977 Comm: kworker/0:2 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
Workqueue: events_long br_fdb_cleanup
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xcd/0x630 mm/kasan/report.c:482
 kasan_report+0xe0/0x110 mm/kasan/report.c:595
 br_switchdev_fdb_populate+0x390/0x3a0 net/bridge/br_switchdev.c:141
 br_switchdev_fdb_notify+0x1df/0x2c0 net/bridge/br_switchdev.c:165
 fdb_notify+0x16c/0x1a0 net/bridge/br_fdb.c:186
 fdb_delete+0x76e/0x12a0 net/bridge/br_fdb.c:324
 br_fdb_cleanup+0x43e/0x600 net/bridge/br_fdb.c:574
 process_one_work+0x9cf/0x1b70 kernel/workqueue.c:3263
 process_scheduled_works kernel/workqueue.c:3346 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3427
 kthread+0x3c5/0x780 kernel/kthread.c:463
 ret_from_fork+0x675/0x7d0 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Allocated by task 5810:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:56
 kasan_save_track+0x14/0x30 mm/kasan/common.c:77
 poison_kmalloc_redzone mm/kasan/common.c:400 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:417
 kmalloc_noprof include/linux/slab.h:957 [inline]
 kzalloc_noprof include/linux/slab.h:1094 [inline]
 new_nbp net/bridge/br_if.c:431 [inline]
 br_add_if+0x41d/0x1b70 net/bridge/br_if.c:599
 do_set_master+0x40f/0x730 net/core/rtnetlink.c:2956
 do_setlink.constprop.0+0xbd8/0x4380 net/core/rtnetlink.c:3158
 rtnl_changelink net/core/rtnetlink.c:3769 [inline]
 __rtnl_newlink net/core/rtnetlink.c:3928 [inline]
 rtnl_newlink+0x1446/0x2000 net/core/rtnetlink.c:4065
 rtnetlink_rcv_msg+0x95e/0xe90 net/core/rtnetlink.c:6951
 netlink_rcv_skb+0x158/0x420 net/netlink/af_netlink.c:2552
 netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
 netlink_unicast+0x5aa/0x870 net/netlink/af_netlink.c:1346
 netlink_sendmsg+0x8c8/0xdd0 net/netlink/af_netlink.c:1896
 sock_sendmsg_nosec net/socket.c:727 [inline]
 __sock_sendmsg net/socket.c:742 [inline]
 __sys_sendto+0x4a3/0x520 net/socket.c:2244
 __do_sys_sendto net/socket.c:2251 [inline]
 __se_sys_sendto net/socket.c:2247 [inline]
 __x64_sys_sendto+0xe0/0x1c0 net/socket.c:2247
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 15061:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:56
 kasan_save_track+0x14/0x30 mm/kasan/common.c:77
 __kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:587
 kasan_save_free_info mm/kasan/kasan.h:406 [inline]
 poison_slab_object mm/kasan/common.c:252 [inline]
 __kasan_slab_free+0x5f/0x80 mm/kasan/common.c:284
 kasan_slab_free include/linux/kasan.h:234 [inline]
 slab_free_hook mm/slub.c:2539 [inline]
 slab_free mm/slub.c:6630 [inline]
 kfree+0x2b8/0x6d0 mm/slub.c:6837
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x1e7/0x5a0 lib/kobject.c:737
 rcu_do_batch kernel/rcu/tree.c:2605 [inline]
 rcu_core+0x79c/0x1530 kernel/rcu/tree.c:2861
 handle_softirqs+0x219/0x8e0 kernel/softirq.c:622
 __do_softirq kernel/softirq.c:656 [inline]
 invoke_softirq kernel/softirq.c:496 [inline]
 __irq_exit_rcu+0x109/0x170 kernel/softirq.c:723
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:739
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1052 [inline]
 sysvec_apic_timer_interrupt+0xa4/0xc0 arch/x86/kernel/apic/apic.c:1052
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:697

Last potentially related work creation:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:56
 kasan_record_aux_stack+0xa7/0xc0 mm/kasan/generic.c:559
 __call_rcu_common.constprop.0+0xa5/0xa10 kernel/rcu/tree.c:3123
 br_del_if+0xe0/0x270 net/bridge/br_if.c:740
 do_set_master+0x172/0x730 net/core/rtnetlink.c:2940
 do_setlink.constprop.0+0xbd8/0x4380 net/core/rtnetlink.c:3158
 rtnl_group_changelink net/core/rtnetlink.c:3783 [inline]
 __rtnl_newlink net/core/rtnetlink.c:3937 [inline]
 rtnl_newlink+0x18e0/0x2000 net/core/rtnetlink.c:4065
 rtnetlink_rcv_msg+0x95e/0xe90 net/core/rtnetlink.c:6951
 netlink_rcv_skb+0x158/0x420 net/netlink/af_netlink.c:2552
 netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
 netlink_unicast+0x5aa/0x870 net/netlink/af_netlink.c:1346
 netlink_sendmsg+0x8c8/0xdd0 net/netlink/af_netlink.c:1896
 sock_sendmsg_nosec net/socket.c:727 [inline]
 __sock_sendmsg net/socket.c:742 [inline]
 ____sys_sendmsg+0xa98/0xc70 net/socket.c:2630
 ___sys_sendmsg+0x134/0x1d0 net/socket.c:2684
 __sys_sendmsg+0x16d/0x220 net/socket.c:2716
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888025122800
 which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 8 bytes inside of
 freed 1024-byte region [ffff888025122800, ffff888025122c00)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff888025125800 pfn:0x25120
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000240(workingset|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000240 ffff88813ffa6dc0 ffffea0001ee1810 ffffea0000c8c210
raw: ffff888025125800 000000000010000e 00000000f5000000 0000000000000000
head: 00fff00000000240 ffff88813ffa6dc0 ffffea0001ee1810 ffffea0000c8c210
head: ffff888025125800 000000000010000e 00000000f5000000 0000000000000000
head: 00fff00000000003 ffffea0000944801 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5807, tgid 5807 (syz-executor), ts 72613372336, free_ts 72596370994
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1c0/0x230 mm/page_alloc.c:1850
 prep_new_page mm/page_alloc.c:1858 [inline]
 get_page_from_freelist+0x10a3/0x3a30 mm/page_alloc.c:3884
 __alloc_frozen_pages_noprof+0x25f/0x2470 mm/page_alloc.c:5183
 alloc_pages_mpol+0x1fb/0x550 mm/mempolicy.c:2416
 alloc_slab_page mm/slub.c:3055 [inline]
 allocate_slab mm/slub.c:3228 [inline]
 new_slab+0x24a/0x360 mm/slub.c:3282
 ___slab_alloc+0xdae/0x1a60 mm/slub.c:4651
 __slab_alloc.constprop.0+0x63/0x110 mm/slub.c:4770
 __slab_alloc_node mm/slub.c:4846 [inline]
 slab_alloc_node mm/slub.c:5268 [inline]
 __do_kmalloc_node mm/slub.c:5641 [inline]
 __kmalloc_noprof+0x501/0x880 mm/slub.c:5654
 kmalloc_noprof include/linux/slab.h:961 [inline]
 kzalloc_noprof include/linux/slab.h:1094 [inline]
 __alloc_workqueue+0x112/0x1810 kernel/workqueue.c:5715
 alloc_workqueue_noprof+0xd2/0x200 kernel/workqueue.c:5818
 wg_newlink+0x24d/0x780 drivers/net/wireguard/device.c:341
 rtnl_newlink_create net/core/rtnetlink.c:3833 [inline]
 __rtnl_newlink net/core/rtnetlink.c:3950 [inline]
 rtnl_newlink+0xc45/0x2000 net/core/rtnetlink.c:4065
 rtnetlink_rcv_msg+0x95e/0xe90 net/core/rtnetlink.c:6951
 netlink_rcv_skb+0x158/0x420 net/netlink/af_netlink.c:2552
 netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
 netlink_unicast+0x5aa/0x870 net/netlink/af_netlink.c:1346
 netlink_sendmsg+0x8c8/0xdd0 net/netlink/af_netlink.c:1896
page last free pid 5809 tgid 5809 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1394 [inline]
 __free_frozen_pages+0x7df/0x1160 mm/page_alloc.c:2906
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x4d/0x120 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x195/0x1e0 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x69/0x90 mm/kasan/common.c:352
 kasan_slab_alloc include/linux/kasan.h:252 [inline]
 slab_post_alloc_hook mm/slub.c:4970 [inline]
 slab_alloc_node mm/slub.c:5280 [inline]
 __kmalloc_cache_noprof+0x274/0x780 mm/slub.c:5758
 kmalloc_noprof include/linux/slab.h:957 [inline]
 kzalloc_noprof include/linux/slab.h:1094 [inline]
 kset_create lib/kobject.c:965 [inline]
 kset_create_and_add+0x4d/0x190 lib/kobject.c:1008
 register_queue_kobjects net/core/net-sysfs.c:2106 [inline]
 netdev_register_kobject+0x1ef/0x3d0 net/core/net-sysfs.c:2362
 register_netdevice+0x13dc/0x2270 net/core/dev.c:11294
 ipcaif_newlink+0x73/0x2c0 net/caif/chnl_net.c:452
 rtnl_newlink_create net/core/rtnetlink.c:3833 [inline]
 __rtnl_newlink net/core/rtnetlink.c:3950 [inline]
 rtnl_newlink+0xc45/0x2000 net/core/rtnetlink.c:4065
 rtnetlink_rcv_msg+0x95e/0xe90 net/core/rtnetlink.c:6951
 netlink_rcv_skb+0x158/0x420 net/netlink/af_netlink.c:2552
 netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
 netlink_unicast+0x5aa/0x870 net/netlink/af_netlink.c:1346
 netlink_sendmsg+0x8c8/0xdd0 net/netlink/af_netlink.c:1896
 sock_sendmsg_nosec net/socket.c:727 [inline]
 __sock_sendmsg net/socket.c:742 [inline]
 __sys_sendto+0x4a3/0x520 net/socket.c:2244
 __do_sys_sendto net/socket.c:2251 [inline]
 __se_sys_sendto net/socket.c:2247 [inline]
 __x64_sys_sendto+0xe0/0x1c0 net/socket.c:2247

Memory state around the buggy address:
 ffff888025122700: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888025122780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff888025122800: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                      ^
 ffff888025122880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888025122900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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

