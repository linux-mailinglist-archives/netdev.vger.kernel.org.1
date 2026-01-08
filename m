Return-Path: <netdev+bounces-248084-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C926CD03533
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 15:25:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 10B473053310
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 13:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DBC637E30B;
	Thu,  8 Jan 2026 13:32:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f79.google.com (mail-ot1-f79.google.com [209.85.210.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11410364038
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 13:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767879152; cv=none; b=mK9izhIIoDLVOJhaqT7c0lV1deHHmB8sex0o1BaCpip2c/87kpr7aGA3ucjz9BjsKe4gN2lAAkDyhyHXtx4XSdsUMVx65tmVA+JPWPxRkymJCB2ofl9EslDWm5hRQIbHquyvBfEYnxehM4g1BX5/fQ0XkppbwY0I6LOyV7Z0q0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767879152; c=relaxed/simple;
	bh=IzERxyI58mINJBE87cDhWytaD0t+dMWpNNhRp/6aIS4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=HhiMsvtreo0ahQubLXhMq4NZYL7ZWP4J74v994SnyruLcLlYmzsgJXfvf+cpHj/2weUoqgpNiDAFi+1u30dvsHqkBZ+ZrJ8aqnl2OWU7kJ8OmOCXJ2HOtMfwvYlU7niNYorIgjBDDr18ru8tblLXNjCNhgqMOUn4t6dANjlTOFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f79.google.com with SMTP id 46e09a7af769-7c701a712ecso5582340a34.0
        for <netdev@vger.kernel.org>; Thu, 08 Jan 2026 05:32:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767879145; x=1768483945;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yxOPx77ojQHMZTvwuZnC5Mc8hnjGrzkIOk9cOBdfj8s=;
        b=WtizRmkr/O6qCQIMrTjHzMlRd0XX8Tu5L64HcGY3vupIG8pPqBepomo3mtyUhV7URH
         60YdhouK4aiJBc+uMmztK9jKWf8KUlAUo0pfvpd+IXT8atQisS66gBRZbuOaQoWGHmmP
         kNtCJTVVmwYQ7KwXutBW4P2oQP8xixAduE5EmalV+lM9wdt/c0u059TIqbA7YPMLrIue
         02eXH37WTHGPkZVibJ/gqkKxQk4iCvbtDkaO7ei+vXs/b5YwRr7cjTKeN5GChN7Hxdk8
         vc8EkVGItGjR3cIdJKohNj5wAQ19tewUXOW7Uhlo/iZC9oQQu2S7W/N79ocQzDuU15Db
         Ksmw==
X-Forwarded-Encrypted: i=1; AJvYcCUo1ju50HaBWmlBrkUOZnJW5bKLX29lXY/Nblwb2N9AD4DpmXIXtTNGo2W5uucuBpBDc/a9MK8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0x86mkL2tiZ8tq3rqzk3/fqGHVB1Pzl8gWLPIgz4KgT355nK6
	7kCMRTIbH0jUtlaWvo3uYwBLVntCOnShuv/hFSaAyI1+TuHoa4PH/KCyCO4jflXpIjLOneYSkwf
	F20mHiRG1XUf9mCqQYg+BFPujzQ6grBWQ83D1T2BqyPZepF7XuDM16YlwWfk=
X-Google-Smtp-Source: AGHT+IGaYnIptaDpPlurtpgRwve0LGNo1fZhlNLnl6aSSQsrmE0G02DPXQcZWnQpnudigoz7Dfgk3Y8sGcurbms5da+P6AgIs88R
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a4a:db5a:0:b0:659:9a49:8e17 with SMTP id
 006d021491bc7-65f481ba4demr4416699eaf.9.1767879144827; Thu, 08 Jan 2026
 05:32:24 -0800 (PST)
Date: Thu, 08 Jan 2026 05:32:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <695fb1e8.050a0220.1c677c.039f.GAE@google.com>
Subject: [syzbot] [net?] KASAN: slab-use-after-free Read in macvlan_forward_source
From: syzbot <syzbot+7182fbe91e58602ec1fe@syzkaller.appspotmail.com>
To: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    94909c53e442 Merge branch 'hsr-send-correct-hsrv0-supervis..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=14e1c914580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e46b8a1c645465a9
dashboard link: https://syzkaller.appspot.com/bug?extid=7182fbe91e58602ec1fe
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a204397b7264/disk-94909c53.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8433b628eb0c/vmlinux-94909c53.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8c6d98cf6bab/bzImage-94909c53.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7182fbe91e58602ec1fe@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in macvlan_forward_source+0x512/0x630 drivers/net/macvlan.c:436
Read of size 2 at addr ffff888030edadfc by task ksoftirqd/0/15

CPU: 0 UID: 0 PID: 15 Comm: ksoftirqd/0 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xca/0x240 mm/kasan/report.c:482
 kasan_report+0x118/0x150 mm/kasan/report.c:595
 macvlan_forward_source+0x512/0x630 drivers/net/macvlan.c:436
 macvlan_handle_frame+0x2e2/0x12e0 drivers/net/macvlan.c:471
 __netif_receive_skb_core+0x10b9/0x4380 net/core/dev.c:5966
 __netif_receive_skb_one_core net/core/dev.c:6077 [inline]
 __netif_receive_skb+0x72/0x380 net/core/dev.c:6192
 process_backlog+0x60e/0x14f0 net/core/dev.c:6544
 __napi_poll+0xc7/0x360 net/core/dev.c:7594
 napi_poll net/core/dev.c:7657 [inline]
 net_rx_action+0x5f7/0xdf0 net/core/dev.c:7784
 handle_softirqs+0x286/0x870 kernel/softirq.c:622
 run_ksoftirqd+0x9b/0x100 kernel/softirq.c:1063
 smpboot_thread_fn+0x542/0xa60 kernel/smpboot.c:160
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Allocated by task 8954:
 kasan_save_stack mm/kasan/common.c:56 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:77
 poison_kmalloc_redzone mm/kasan/common.c:400 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:417
 kasan_kmalloc include/linux/kasan.h:262 [inline]
 __do_kmalloc_node mm/slub.c:5642 [inline]
 __kvmalloc_node_noprof+0x5cd/0x910 mm/slub.c:7100
 alloc_netdev_mqs+0xa6/0x11b0 net/core/dev.c:11900
 rtnl_create_link+0x31f/0xd10 net/core/rtnetlink.c:3641
 rtnl_newlink_create+0x25c/0xb00 net/core/rtnetlink.c:3823
 __rtnl_newlink net/core/rtnetlink.c:3950 [inline]
 rtnl_newlink+0x16e4/0x1c80 net/core/rtnetlink.c:4065
 rtnetlink_rcv_msg+0x7cf/0xb70 net/core/rtnetlink.c:6951
 netlink_rcv_skb+0x208/0x470 net/netlink/af_netlink.c:2552
 netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
 netlink_unicast+0x82f/0x9e0 net/netlink/af_netlink.c:1346
 netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1896
 sock_sendmsg_nosec net/socket.c:727 [inline]
 __sock_sendmsg+0x21c/0x270 net/socket.c:742
 ____sys_sendmsg+0x505/0x830 net/socket.c:2630
 ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2684
 __sys_sendmsg net/socket.c:2716 [inline]
 __do_sys_sendmsg net/socket.c:2721 [inline]
 __se_sys_sendmsg net/socket.c:2719 [inline]
 __x64_sys_sendmsg+0x19b/0x260 net/socket.c:2719
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 8954:
 kasan_save_stack mm/kasan/common.c:56 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:77
 __kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:587
 kasan_save_free_info mm/kasan/kasan.h:406 [inline]
 poison_slab_object mm/kasan/common.c:252 [inline]
 __kasan_slab_free+0x5c/0x80 mm/kasan/common.c:284
 kasan_slab_free include/linux/kasan.h:234 [inline]
 slab_free_hook mm/slub.c:2539 [inline]
 slab_free mm/slub.c:6630 [inline]
 kfree+0x19a/0x6d0 mm/slub.c:6837
 rtnl_newlink_create+0x373/0xb00 net/core/rtnetlink.c:3837
 __rtnl_newlink net/core/rtnetlink.c:3950 [inline]
 rtnl_newlink+0x16e4/0x1c80 net/core/rtnetlink.c:4065
 rtnetlink_rcv_msg+0x7cf/0xb70 net/core/rtnetlink.c:6951
 netlink_rcv_skb+0x208/0x470 net/netlink/af_netlink.c:2552
 netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
 netlink_unicast+0x82f/0x9e0 net/netlink/af_netlink.c:1346
 netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1896
 sock_sendmsg_nosec net/socket.c:727 [inline]
 __sock_sendmsg+0x21c/0x270 net/socket.c:742
 ____sys_sendmsg+0x505/0x830 net/socket.c:2630
 ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2684
 __sys_sendmsg net/socket.c:2716 [inline]
 __do_sys_sendmsg net/socket.c:2721 [inline]
 __se_sys_sendmsg net/socket.c:2719 [inline]
 __x64_sys_sendmsg+0x19b/0x260 net/socket.c:2719
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888030eda000
 which belongs to the cache kmalloc-cg-4k of size 4096
The buggy address is located 3580 bytes inside of
 freed 4096-byte region [ffff888030eda000, ffff888030edb000)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x30ed8
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
memcg:ffff88807bdef5c1
anon flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88801a030500 0000000000000000 dead000000000001
raw: 0000000000000000 0000000000040004 00000000f5000000 ffff88807bdef5c1
head: 00fff00000000040 ffff88801a030500 0000000000000000 dead000000000001
head: 0000000000000000 0000000000040004 00000000f5000000 ffff88807bdef5c1
head: 00fff00000000003 ffffea0000c3b601 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 7588, tgid 7586 (syz.3.619), ts 114560949545, free_ts 114289273993
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x240/0x2a0 mm/page_alloc.c:1850
 prep_new_page mm/page_alloc.c:1858 [inline]
 get_page_from_freelist+0x2365/0x2440 mm/page_alloc.c:3884
 __alloc_frozen_pages_noprof+0x181/0x370 mm/page_alloc.c:5183
 alloc_pages_mpol+0x232/0x4a0 mm/mempolicy.c:2416
 alloc_slab_page mm/slub.c:3055 [inline]
 allocate_slab+0x96/0x350 mm/slub.c:3228
 new_slab mm/slub.c:3282 [inline]
 ___slab_alloc+0xe94/0x18a0 mm/slub.c:4651
 __slab_alloc+0x65/0x100 mm/slub.c:4770
 __slab_alloc_node mm/slub.c:4846 [inline]
 slab_alloc_node mm/slub.c:5268 [inline]
 __do_kmalloc_node mm/slub.c:5641 [inline]
 __kmalloc_noprof+0x471/0x7f0 mm/slub.c:5654
 kmalloc_noprof include/linux/slab.h:961 [inline]
 kzalloc_noprof include/linux/slab.h:1094 [inline]
 __register_sysctl_table+0x72/0x1340 fs/proc/proc_sysctl.c:1379
 __addrconf_sysctl_register+0x328/0x4c0 net/ipv6/addrconf.c:7323
 addrconf_sysctl_register+0x168/0x1c0 net/ipv6/addrconf.c:7371
 ipv6_add_dev+0xd46/0x1370 net/ipv6/addrconf.c:460
 addrconf_notify+0x794/0x1010 net/ipv6/addrconf.c:3650
 notifier_call_chain+0x1b6/0x3e0 kernel/notifier.c:85
 call_netdevice_notifiers_extack net/core/dev.c:2267 [inline]
 call_netdevice_notifiers net/core/dev.c:2281 [inline]
 register_netdevice+0x1608/0x1ae0 net/core/dev.c:11332
 register_vlan_dev+0x39e/0x820 net/8021q/vlan.c:179
page last free pid 89 tgid 89 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1394 [inline]
 __free_frozen_pages+0xbc4/0xd30 mm/page_alloc.c:2906
 discard_slab mm/slub.c:3326 [inline]
 __put_partials+0x146/0x170 mm/slub.c:3872
 put_cpu_partial+0x1f2/0x2e0 mm/slub.c:3947
 __slab_free+0x2b9/0x390 mm/slub.c:5921
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x97/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x148/0x160 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x22/0x80 mm/kasan/common.c:352
 kasan_slab_alloc include/linux/kasan.h:252 [inline]
 slab_post_alloc_hook mm/slub.c:4970 [inline]
 slab_alloc_node mm/slub.c:5280 [inline]
 __kmalloc_cache_noprof+0x36f/0x6f0 mm/slub.c:5758
 kmalloc_noprof include/linux/slab.h:957 [inline]
 kzalloc_noprof include/linux/slab.h:1094 [inline]
 nsim_fib6_rt_create drivers/net/netdevsim/fib.c:547 [inline]
 nsim_fib6_rt_insert drivers/net/netdevsim/fib.c:752 [inline]
 nsim_fib6_event drivers/net/netdevsim/fib.c:856 [inline]
 nsim_fib_event+0xca1/0x8a30 drivers/net/netdevsim/fib.c:889
 nsim_fib_event_work+0x249/0x3b0 drivers/net/netdevsim/fib.c:1493
 process_one_work kernel/workqueue.c:3263 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3346
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3427
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Memory state around the buggy address:
 ffff888030edac80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888030edad00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888030edad80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                                ^
 ffff888030edae00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888030edae80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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

