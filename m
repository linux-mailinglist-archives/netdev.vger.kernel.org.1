Return-Path: <netdev+bounces-194761-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 798B4ACC503
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 13:10:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2057C3A54B3
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 11:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9751322F76E;
	Tue,  3 Jun 2025 11:09:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9BC22F14D
	for <netdev@vger.kernel.org>; Tue,  3 Jun 2025 11:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748948969; cv=none; b=bKNTsaEHtKNLnyXSJ0ICT9/jCw4U4tTfXPYWX+EHNnfnASJk6rXU2h3ge4h3/x1J+FQmHcVK8c5e4Xn3qkxnPim8R/h00MNkSPylfh833GpDZ2vsma/amYMnS/aNGyTOF/fidkRoGpC/mnrHADNO8rre8JiPQZWs3a0NvFgcvIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748948969; c=relaxed/simple;
	bh=bRRbDQ+4ZhmycwjErcXkl0zWNrdTOxiYwsQISZdjWos=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=PHzSO5vPUg2UzdBvHny2grCBaVp7DXuiZCJjGWVlPT23TWiVwtiXnv69+WCF1hWCu9rqhgdMidXcLgLNRz9/hWo599vLrBt2/7hqy3xaZU1r3jXtULZoWyA8DA0yYoTYo7iCUnPPCa85vvf6ZbWvKkCH7ZcXlELGJQeDS7cAPL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3ddb4ed2dcbso23836665ab.3
        for <netdev@vger.kernel.org>; Tue, 03 Jun 2025 04:09:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748948966; x=1749553766;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2t8NbF0cc7mbm80orZzaxVktqgbw5Hhzfs6ssklJEXo=;
        b=ZQNdiqSqu4yBUl0nUx3dge6/tnNVXAZJRLPQXU2zrIdu10B6SusRz3pjSnO27Shcyn
         IU/+7LHdwPOeDYWHKfUyfbcGRZceojbOVXJZTBJODwz5gkNXdvnoR2E846B9hqmPr7Cu
         bWy3cMS0SQCVF0/YAODtmSWMwBARTv5ilm1xLhF7aeNXvgr1YvQBTnw7C1hqGRHJF+gA
         1xccPGKj/Kq1xDWzZ6mSR+P+rcVJZYwoxb5l812+2fT5Uil9CDl7w2Qh/lKh06MbwP+X
         Q+to8NHeQ/W2GgD/BhUR4zshi3mbkwBK5H5IwkVQPvOtExSgpAR8Bl9EA5hR5aq7sIRa
         SXzQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7NnGYAFL/b5dAS0fLpsD6Nenb1vpweM30fOM0ICOaAbTRPX93y1zTLE8ILGDlRcBVcPDYY+s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNpVaZKUnFWfGHqm20ULYvXJ3r01xwVC5PWBPSs2Acf93lJoVF
	OjBze3Oa7UU8d5QoDym4CFYCypztw8k88vsrwGHYczT4rvhH9Mccwzuu6smwQXJA6QDoAexgws2
	ag4ucH7mIgoog1XbWhmws6/6fAkLLVO2JSAz26wTcG4MPJAV1t1u7Wi3bMT4=
X-Google-Smtp-Source: AGHT+IHvRO1HLwYZ55EW8z8DwnWgFuEPCveSbh2VnhylFPfl1e8q8LeW2e2aCVyy3S/gzwfglBOTdWZYjXH2IsI5UygrzWsq2B6j
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1b08:b0:3dc:8423:543e with SMTP id
 e9e14a558f8ab-3dd99c2c2b3mr194171885ab.17.1748948966431; Tue, 03 Jun 2025
 04:09:26 -0700 (PDT)
Date: Tue, 03 Jun 2025 04:09:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <683ed7e6.a00a0220.d8eae.0069.GAE@google.com>
Subject: [syzbot] [net?] KASAN: slab-out-of-bounds Write in mini_qdisc_pair_swap
From: syzbot <syzbot+c5690f59dae698a60ee4@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	jhs@mojatatu.com, jiri@resnulli.us, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    3d413f0cfd7e Merge tag 'audit-pr-20250527' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=178a0970580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e1b98eec58835d70
dashboard link: https://syzkaller.appspot.com/bug?extid=c5690f59dae698a60ee4
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/769646f88496/disk-3d413f0c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8dedfd2f0c29/vmlinux-3d413f0c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/cf7e1dfcc579/bzImage-3d413f0c.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c5690f59dae698a60ee4@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in mini_qdisc_pair_swap+0x1c2/0x1f0 net/sched/sch_generic.c:1597
Write of size 8 at addr ffff888035143380 by task kworker/u8:5/315

CPU: 0 UID: 0 PID: 315 Comm: kworker/u8:5 Not tainted 6.15.0-syzkaller-03645-g3d413f0cfd7e #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
Workqueue: netns cleanup_net
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:408 [inline]
 print_report+0xcd/0x680 mm/kasan/report.c:521
 kasan_report+0xe0/0x110 mm/kasan/report.c:634
 mini_qdisc_pair_swap+0x1c2/0x1f0 net/sched/sch_generic.c:1597
 tcf_chain_head_change_item net/sched/cls_api.c:522 [inline]
 tcf_chain0_head_change_cb_del+0x1a5/0x3e0 net/sched/cls_api.c:969
 tcf_block_put_ext+0xb4/0x1c0 net/sched/cls_api.c:1559
 clsact_destroy+0x2c0/0x9b0 net/sched/sch_ingress.c:302
 __qdisc_destroy+0x106/0x4a0 net/sched/sch_generic.c:1078
 qdisc_put+0xab/0xe0 net/sched/sch_generic.c:1106
 shutdown_scheduler_queue+0xa5/0x160 net/sched/sch_generic.c:1159
 dev_shutdown+0x180/0x430 net/sched/sch_generic.c:1493
 unregister_netdevice_many_notify+0xb39/0x26f0 net/core/dev.c:11960
 unregister_netdevice_many net/core/dev.c:12036 [inline]
 unregister_netdevice_queue+0x305/0x3f0 net/core/dev.c:11879
 unregister_netdevice include/linux/netdevice.h:3374 [inline]
 nsim_destroy+0x197/0x5d0 drivers/net/netdevsim/netdev.c:1064
 __nsim_dev_port_del+0x189/0x240 drivers/net/netdevsim/dev.c:1428
 nsim_dev_port_del_all drivers/net/netdevsim/dev.c:1440 [inline]
 nsim_dev_reload_destroy+0x10a/0x4d0 drivers/net/netdevsim/dev.c:1661
 nsim_dev_reload_down+0x6e/0xd0 drivers/net/netdevsim/dev.c:968
 devlink_reload+0x19e/0x7c0 net/devlink/dev.c:461
 devlink_pernet_pre_exit+0x1a0/0x2b0 net/devlink/core.c:509
 ops_pre_exit_list net/core/net_namespace.c:162 [inline]
 cleanup_net+0x494/0xb30 net/core/net_namespace.c:634
 process_one_work+0x9cf/0x1b70 kernel/workqueue.c:3238
 process_scheduled_works kernel/workqueue.c:3321 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3402
 kthread+0x3c5/0x780 kernel/kthread.c:464
 ret_from_fork+0x5d4/0x6f0 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Allocated by task 27376:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __do_kmalloc_node mm/slub.c:4327 [inline]
 __kmalloc_node_track_caller_noprof+0x221/0x510 mm/slub.c:4346
 kvasprintf+0xbc/0x160 lib/kasprintf.c:25
 kvasprintf_const+0x66/0x1a0 lib/kasprintf.c:49
 kobject_set_name_vargs+0x5a/0x140 lib/kobject.c:274
 kobject_add_varg lib/kobject.c:368 [inline]
 kobject_init_and_add+0xe7/0x190 lib/kobject.c:457
 netdev_queue_add_kobject net/core/net-sysfs.c:1976 [inline]
 netdev_queue_update_kobjects+0x32d/0x720 net/core/net-sysfs.c:2035
 register_queue_kobjects net/core/net-sysfs.c:2098 [inline]
 netdev_register_kobject+0x28c/0x3a0 net/core/net-sysfs.c:2340
 register_netdevice+0x13dc/0x2270 net/core/dev.c:10999
 geneve_configure+0x785/0xaf0 drivers/net/geneve.c:1404
 geneve_newlink+0x1af/0x3a0 drivers/net/geneve.c:1672
 rtnl_newlink_create net/core/rtnetlink.c:3833 [inline]
 __rtnl_newlink net/core/rtnetlink.c:3950 [inline]
 rtnl_newlink+0xc42/0x2000 net/core/rtnetlink.c:4065
 rtnetlink_rcv_msg+0x95b/0xe90 net/core/rtnetlink.c:6955
 netlink_rcv_skb+0x16a/0x440 net/netlink/af_netlink.c:2534
 netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
 netlink_unicast+0x53d/0x7f0 net/netlink/af_netlink.c:1339
 netlink_sendmsg+0x8d1/0xdd0 net/netlink/af_netlink.c:1883
 sock_sendmsg_nosec net/socket.c:712 [inline]
 __sock_sendmsg net/socket.c:727 [inline]
 ____sys_sendmsg+0xa95/0xc70 net/socket.c:2566
 ___sys_sendmsg+0x134/0x1d0 net/socket.c:2620
 __sys_sendmsg+0x16d/0x220 net/socket.c:2652
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x4c0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888035143380
 which belongs to the cache kmalloc-8 of size 8
The buggy address is located 0 bytes inside of
 allocated 7-byte region [ffff888035143380, ffff888035143387)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x35143
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000000 ffff88801b441500 dead000000000100 dead000000000122
raw: 0000000000000000 0000000000800080 00000000f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x152cc0(GFP_USER|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 13340, tgid 13303 (syz.2.1998), ts 653747172757, free_ts 649672758691
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1c0/0x230 mm/page_alloc.c:1714
 prep_new_page mm/page_alloc.c:1722 [inline]
 get_page_from_freelist+0x135c/0x3950 mm/page_alloc.c:3684
 __alloc_frozen_pages_noprof+0x261/0x23f0 mm/page_alloc.c:4974
 alloc_pages_mpol+0x1fb/0x550 mm/mempolicy.c:2301
 alloc_slab_page mm/slub.c:2450 [inline]
 allocate_slab mm/slub.c:2618 [inline]
 new_slab+0x23b/0x330 mm/slub.c:2672
 ___slab_alloc+0xd9c/0x1940 mm/slub.c:3858
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3948
 __slab_alloc_node mm/slub.c:4023 [inline]
 slab_alloc_node mm/slub.c:4184 [inline]
 __do_kmalloc_node mm/slub.c:4326 [inline]
 __kmalloc_node_track_caller_noprof+0x2ee/0x510 mm/slub.c:4346
 __kmemdup_nul mm/util.c:63 [inline]
 kstrdup+0x53/0x100 mm/util.c:83
 kstrdup_const+0x63/0x80 mm/util.c:103
 __kernfs_new_node+0x9b/0x8a0 fs/kernfs/dir.c:633
 kernfs_new_node+0x13c/0x1e0 fs/kernfs/dir.c:713
 __kernfs_create_file+0x53/0x350 fs/kernfs/file.c:1038
 sysfs_add_file_mode_ns+0x207/0x3c0 fs/sysfs/file.c:319
 create_files fs/sysfs/group.c:76 [inline]
 internal_create_group+0x578/0xf30 fs/sysfs/group.c:183
 internal_create_groups+0x9d/0x150 fs/sysfs/group.c:223
page last free pid 13358 tgid 13354 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1258 [inline]
 free_unref_folios+0xa5f/0x17f0 mm/page_alloc.c:2778
 folios_put_refs+0x56f/0x740 mm/swap.c:992
 folio_batch_release include/linux/pagevec.h:101 [inline]
 truncate_inode_pages_range+0x311/0xe30 mm/truncate.c:383
 kill_bdev block/bdev.c:91 [inline]
 blkdev_flush_mapping+0xfb/0x290 block/bdev.c:712
 blkdev_put_whole+0xc4/0xf0 block/bdev.c:719
 bdev_release+0x47e/0x6d0 block/bdev.c:1144
 blkdev_release+0x15/0x20 block/fops.c:684
 __fput+0x402/0xb70 fs/file_table.c:465
 task_work_run+0x14d/0x240 kernel/task_work.c:227
 exit_task_work include/linux/task_work.h:40 [inline]
 do_exit+0xae2/0x2c70 kernel/exit.c:959
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1108
 get_signal+0x2673/0x26d0 kernel/signal.c:3034
 arch_do_signal_or_restart+0x8f/0x7d0 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop+0x84/0x110 kernel/entry/common.c:111
 exit_to_user_mode_prepare include/linux/entry-common.h:330 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:414 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:449 [inline]
 do_syscall_64+0x3f6/0x4c0 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff888035143280: 07 fc fc fc 07 fc fc fc 06 fc fc fc 07 fc fc fc
 ffff888035143300: 06 fc fc fc 05 fc fc fc 07 fc fc fc 07 fc fc fc
>ffff888035143380: 07 fc fc fc 06 fc fc fc 05 fc fc fc 07 fc fc fc
                   ^
 ffff888035143400: 07 fc fc fc 05 fc fc fc 07 fc fc fc 05 fc fc fc
 ffff888035143480: 07 fc fc fc 05 fc fc fc 07 fc fc fc 07 fc fc fc
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

