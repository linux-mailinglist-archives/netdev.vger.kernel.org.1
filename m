Return-Path: <netdev+bounces-107251-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D815091A706
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 14:55:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06CE81C23EA6
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 12:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3BFA178CC4;
	Thu, 27 Jun 2024 12:55:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E632E178389
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 12:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719492927; cv=none; b=IrkHbN1g/cLKOq4hIPrmClMEVzJSAFZ7DA5+w8zwpJAhIm+0mTnN2QbuUd/aS+chjwZiWbUZ5HqixJ7l+4aoeslwIRLRRepHkchFuTcLbGVLiMmeDOcJ07zQCZFsmwGAc5o235wqudFFWhQlLZd4BO3TDpCoC5lsoNJdMBndR5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719492927; c=relaxed/simple;
	bh=pWUx2lEla5reQsU30GNKqo65AV64f1OPnSP0I7sqmfs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Zf/C6/WJ/1M/dlyYBeqSw9uwCCpCF/9Y/0ouCzZ6HcUIysQWE8TZpmhXjWw0RcaNBia510wSFvTuq+D+0+0K0Ws9FPR/kxgw/3BCoZiacnAVM5bBYIPMU04Wr0qYOmYIwidW5KGEXPM/MBuq6r1lwZ3A8UW2aoW0ODMmHs2Ol+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-376117f5fcfso98028865ab.0
        for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 05:55:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719492925; x=1720097725;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MLfLig21hPpUcoUqIX2R2S1pxNLsLHoSwCpHn6fdUgc=;
        b=jTg6OYJ7/FZpHYoFuN7orwUiWG/FmN3cBrnEZfYwzs0LTx/N4PjpGoQPlP7JtPG12X
         e1GPHD87hDtoMlH8c+LYtil2+Uobf8r3aKA//4nnLQQ5BXV9pnSm+72PvJW9k/ntC0aE
         0ggBrBvKUdl7STz7dtqTKABy1j4mBoqOBC+/3F54mBcagaS19n5PndrNJ0iVB7lI6jL0
         f2uDhjTJ5Hhp8mR+WFIcDwE1YXNvGBgPOCUmOJmzfoDyorPo4ymcFY9e58u7TZCaYscD
         16TZFqnupFvQY9FwSim2jeeqQLuKGCJieaebM78PCkn/Mj5UufNBnwDIdsa9BLOn4O9u
         HAJg==
X-Forwarded-Encrypted: i=1; AJvYcCXGsGh/C4WWDoHi0+7HAyAM0uEocmOhM9xpPKGiPk2WBcXUkuh5TAp5HcpKswWdXNz5+UbMGK+ddei1taAtTXnMeqajjzrA
X-Gm-Message-State: AOJu0YyI7smS1E3V5UP5NjHYufWn56nPWGG3pGTHEt2n8kvmIkCHZcT1
	eS88/tE+EoiujhlBs2Y2dQxeYsM1KVVzhfGnaOncUzjDNtwkMbHDZkN0I6BEMlljKDmDBOtTO2w
	BSzbSmAr0mNezixutZcuJL9wmrWGuKjAG8/L6flZddk97MfTEsHdsGI0=
X-Google-Smtp-Source: AGHT+IHSgpjKqlmXzztg2YUshuyNEzNNv4+uBJDQ35+YnwjSAw1FQtddqNmwKyMpIhdEM9OMN+6TjuB3/rca8yJ6D2xcNellYLoG
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20cf:b0:375:ac5d:d5c6 with SMTP id
 e9e14a558f8ab-3763df3cb9amr14154745ab.2.1719492925025; Thu, 27 Jun 2024
 05:55:25 -0700 (PDT)
Date: Thu, 27 Jun 2024 05:55:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fd833a061bdea45a@google.com>
Subject: [syzbot] [bridge?] KASAN: slab-use-after-free Read in br_multicast_port_group_expired
From: syzbot <syzbot+263426984509be19c9a0@syzkaller.appspotmail.com>
To: bridge@lists.linux.dev, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, razor@blackwall.org, roopa@nvidia.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    24ca36a562d6 Merge tag 'wq-for-6.10-rc5-fixes' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1253533e980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=68f694eee402f940
dashboard link: https://syzkaller.appspot.com/bug?extid=263426984509be19c9a0
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/47d6afa6532e/disk-24ca36a5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f72fd72615a8/vmlinux-24ca36a5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/01d7fd05f768/bzImage-24ca36a5.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+263426984509be19c9a0@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in br_multicast_port_group_expired+0x4c0/0x550 net/bridge/br_multicast.c:861
Read of size 8 at addr ffff888071d6d000 by task syz.5.1232/9699

CPU: 1 PID: 9699 Comm: syz.5.1232 Not tainted 6.10.0-rc5-syzkaller-00021-g24ca36a562d6 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:114
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0xc3/0x620 mm/kasan/report.c:488
 kasan_report+0xd9/0x110 mm/kasan/report.c:601
 br_multicast_port_group_expired+0x4c0/0x550 net/bridge/br_multicast.c:861
 call_timer_fn+0x1a3/0x610 kernel/time/timer.c:1792
 expire_timers kernel/time/timer.c:1843 [inline]
 __run_timers+0x74b/0xaf0 kernel/time/timer.c:2417
 __run_timer_base kernel/time/timer.c:2428 [inline]
 __run_timer_base kernel/time/timer.c:2421 [inline]
 run_timer_base+0x111/0x190 kernel/time/timer.c:2437
 run_timer_softirq+0x1a/0x40 kernel/time/timer.c:2447
 handle_softirqs+0x219/0x8f0 kernel/softirq.c:554
 __do_softirq kernel/softirq.c:588 [inline]
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu kernel/softirq.c:637 [inline]
 irq_exit_rcu+0xbb/0x120 kernel/softirq.c:649
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
 sysvec_apic_timer_interrupt+0x95/0xb0 arch/x86/kernel/apic/apic.c:1043
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:finish_task_switch.isra.0+0x220/0xcc0 kernel/sched/core.c:5282
Code: a9 0a 00 00 44 8b 0d 17 b0 85 0e 45 85 c9 0f 85 c0 01 00 00 48 89 df e8 ae f8 ff ff e8 b9 da 36 00 fb 65 48 8b 1d a0 3d a4 7e <48> 8d bb f8 15 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1
RSP: 0018:ffffc90004177d18 EFLAGS: 00000206
RAX: 00000000000085f5 RBX: ffff888028bf8000 RCX: 1ffffffff1fc9ac1
RDX: 0000000000000000 RSI: ffffffff8b2cc140 RDI: ffffffff8b9024c0
RBP: ffffc90004177d60 R08: 0000000000000001 R09: 0000000000000001
R10: ffffffff8fe51897 R11: 0000000000000000 R12: ffff8880b933f938
R13: ffff888028bf9e00 R14: 0000000000000000 R15: ffff8880b933ebc0
 context_switch kernel/sched/core.c:5411 [inline]
 __schedule+0xf1d/0x5d00 kernel/sched/core.c:6745
 __schedule_loop kernel/sched/core.c:6822 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6837
 exit_to_user_mode_loop kernel/entry/common.c:102 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 irqentry_exit_to_user_mode+0xde/0x280 kernel/entry/common.c:231
 asm_sysvec_reschedule_ipi+0x1a/0x20 arch/x86/include/asm/idtentry.h:707
RIP: 0033:0x7fd43064cb94
Code: 0f 82 b9 00 00 00 48 39 f2 72 6e 41 0f 11 0c 24 48 8b 77 f8 48 89 f8 48 89 eb eb 12 66 2e 0f 1f 84 00 00 00 00 00 48 8b 4b 08 <48> 83 c3 08 48 39 d1 72 f3 48 83 e8 08 48 39 f2 73 17 66 2e 0f 1f
RSP: 002b:00007ffc97d21a80 EFLAGS: 00000293
RAX: 00007fd42fab7e40 RBX: 00007fd42fa86f98 RCX: ffffffff88b96ebe
RDX: ffffffff88b9717d RSI: ffffffff88b97253 RDI: 00007fd42fac5e28
RBP: 00007fd42fa7b318 R08: 00007fd42faa0898 R09: 0000000000000008
R10: 0000000088ba1cfe R11: 0000000088ba1d02 R12: 00007fd42fa7b310
R13: 000000000000001f R14: 00007fd42fa01008 R15: 00007fd430904140
 </TASK>

Allocated by task 6702:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:387
 kmalloc_noprof include/linux/slab.h:660 [inline]
 kzalloc_noprof include/linux/slab.h:778 [inline]
 new_nbp net/bridge/br_if.c:431 [inline]
 br_add_if+0x427/0x1b80 net/bridge/br_if.c:599
 do_set_master+0x1bf/0x230 net/core/rtnetlink.c:2701
 do_setlink+0xcaf/0x3ff0 net/core/rtnetlink.c:2907
 __rtnl_newlink+0xc35/0x1960 net/core/rtnetlink.c:3696
 rtnl_newlink+0x67/0xa0 net/core/rtnetlink.c:3743
 rtnetlink_rcv_msg+0x3ca/0xea0 net/core/rtnetlink.c:6635
 netlink_rcv_skb+0x16e/0x440 net/netlink/af_netlink.c:2564
 netlink_unicast_kernel net/netlink/af_netlink.c:1335 [inline]
 netlink_unicast+0x545/0x820 net/netlink/af_netlink.c:1361
 netlink_sendmsg+0x8b8/0xd70 net/netlink/af_netlink.c:1905
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg net/socket.c:745 [inline]
 __sys_sendto+0x482/0x4e0 net/socket.c:2192
 __do_sys_sendto net/socket.c:2204 [inline]
 __se_sys_sendto net/socket.c:2200 [inline]
 __x64_sys_sendto+0xe0/0x1c0 net/socket.c:2200
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 9700:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:579
 poison_slab_object+0xf7/0x160 mm/kasan/common.c:240
 __kasan_slab_free+0x32/0x50 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2196 [inline]
 slab_free mm/slub.c:4437 [inline]
 kfree+0x12a/0x3b0 mm/slub.c:4558
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x1fd/0x5b0 lib/kobject.c:737
 rcu_do_batch kernel/rcu/tree.c:2535 [inline]
 rcu_core+0x82b/0x16b0 kernel/rcu/tree.c:2809
 handle_softirqs+0x219/0x8f0 kernel/softirq.c:554
 __do_softirq kernel/softirq.c:588 [inline]
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu kernel/softirq.c:637 [inline]
 irq_exit_rcu+0xbb/0x120 kernel/softirq.c:649
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
 sysvec_apic_timer_interrupt+0x95/0xb0 arch/x86/kernel/apic/apic.c:1043
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702

Last potentially related work creation:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 __kasan_record_aux_stack+0xba/0xd0 mm/kasan/generic.c:541
 __call_rcu_common.constprop.0+0x9a/0x790 kernel/rcu/tree.c:3072
 br_dev_delete+0x99/0x1a0 net/bridge/br_if.c:386
 br_net_exit_batch_rtnl+0x116/0x1f0 net/bridge/br.c:369
 cleanup_net+0x54b/0xbf0 net/core/net_namespace.c:633
 process_one_work+0x9c8/0x1b40 kernel/workqueue.c:3248
 process_scheduled_works kernel/workqueue.c:3329 [inline]
 worker_thread+0x6c8/0xf30 kernel/workqueue.c:3409
 kthread+0x2c4/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

The buggy address belongs to the object at ffff888071d6d000
 which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 0 bytes inside of
 freed 1024-byte region [ffff888071d6d000, ffff888071d6d400)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x71d68
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
anon flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffefff(slab)
raw: 00fff00000000040 ffff888015441dc0 0000000000000000 dead000000000001
raw: 0000000000000000 0000000080100010 00000001ffffefff 0000000000000000
head: 00fff00000000040 ffff888015441dc0 0000000000000000 dead000000000001
head: 0000000000000000 0000000080100010 00000001ffffefff 0000000000000000
head: 00fff00000000003 ffffea0001c75a01 ffffffffffffffff 0000000000000000
head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0x1d2820(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL), pid 1096, tgid 1096 (kworker/u8:8), ts 118658703752, free_ts 118015241497
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x2d1/0x350 mm/page_alloc.c:1468
 prep_new_page mm/page_alloc.c:1476 [inline]
 get_page_from_freelist+0x136a/0x2e50 mm/page_alloc.c:3420
 __alloc_pages_noprof+0x22b/0x2460 mm/page_alloc.c:4678
 __alloc_pages_node_noprof include/linux/gfp.h:269 [inline]
 alloc_pages_node_noprof include/linux/gfp.h:296 [inline]
 alloc_slab_page+0x56/0x110 mm/slub.c:2265
 allocate_slab mm/slub.c:2428 [inline]
 new_slab+0x84/0x260 mm/slub.c:2481
 ___slab_alloc+0xdac/0x1870 mm/slub.c:3667
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3757
 __slab_alloc_node mm/slub.c:3810 [inline]
 slab_alloc_node mm/slub.c:3989 [inline]
 __do_kmalloc_node mm/slub.c:4121 [inline]
 kmalloc_node_track_caller_noprof+0x355/0x430 mm/slub.c:4142
 kmalloc_reserve+0xef/0x2c0 net/core/skbuff.c:597
 __alloc_skb+0x164/0x380 net/core/skbuff.c:666
 alloc_skb include/linux/skbuff.h:1308 [inline]
 nlmsg_new include/net/netlink.h:1015 [inline]
 inet6_rt_notify+0xf0/0x2b0 net/ipv6/route.c:6182
 fib6_del_route net/ipv6/ip6_fib.c:2012 [inline]
 fib6_del+0xf08/0x17b0 net/ipv6/ip6_fib.c:2047
 fib6_clean_node+0x426/0x5b0 net/ipv6/ip6_fib.c:2209
 fib6_walk_continue+0x452/0x8d0 net/ipv6/ip6_fib.c:2131
 fib6_walk+0x182/0x370 net/ipv6/ip6_fib.c:2179
 fib6_clean_tree+0xd7/0x120 net/ipv6/ip6_fib.c:2259
page last free pid 5094 tgid 5094 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1088 [inline]
 free_unref_page+0x64a/0xe40 mm/page_alloc.c:2583
 __put_partials+0x14c/0x170 mm/slub.c:2995
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x4e/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x192/0x1e0 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x69/0x90 mm/kasan/common.c:322
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3941 [inline]
 slab_alloc_node mm/slub.c:4001 [inline]
 __do_kmalloc_node mm/slub.c:4121 [inline]
 __kmalloc_node_noprof+0x1c7/0x440 mm/slub.c:4129
 kmalloc_node_noprof include/linux/slab.h:681 [inline]
 __vmalloc_area_node mm/vmalloc.c:3628 [inline]
 __vmalloc_node_range_noprof+0x401/0x1520 mm/vmalloc.c:3823
 __vmalloc_node_noprof mm/vmalloc.c:3888 [inline]
 vzalloc_noprof+0x6b/0x90 mm/vmalloc.c:3961
 alloc_counters net/ipv6/netfilter/ip6_tables.c:815 [inline]
 copy_entries_to_user net/ipv6/netfilter/ip6_tables.c:837 [inline]
 get_entries net/ipv6/netfilter/ip6_tables.c:1039 [inline]
 do_ip6t_get_ctl+0x6ba/0xaf0 net/ipv6/netfilter/ip6_tables.c:1677
 nf_getsockopt+0x7c/0xe0 net/netfilter/nf_sockopt.c:116
 ipv6_getsockopt+0x1fd/0x2c0 net/ipv6/ipv6_sockglue.c:1494
 tcp_getsockopt+0xa1/0x100 net/ipv4/tcp.c:4406
 do_sock_getsockopt+0x2e8/0x760 net/socket.c:2374
 __sys_getsockopt+0x1a1/0x270 net/socket.c:2403
 __do_sys_getsockopt net/socket.c:2413 [inline]
 __se_sys_getsockopt net/socket.c:2410 [inline]
 __x64_sys_getsockopt+0xbd/0x160 net/socket.c:2410
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83

Memory state around the buggy address:
 ffff888071d6cf00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888071d6cf80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff888071d6d000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff888071d6d080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888071d6d100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================
------------[ cut here ]------------
UBSAN: array-index-out-of-bounds in kernel/locking/qspinlock.c:131:9
index 15933 is out of range for type 'long unsigned int [8]'
CPU: 1 PID: 9699 Comm: syz.5.1232 Tainted: G    B              6.10.0-rc5-syzkaller-00021-g24ca36a562d6 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x16c/0x1f0 lib/dump_stack.c:114
 ubsan_epilogue lib/ubsan.c:231 [inline]
 __ubsan_handle_out_of_bounds+0x110/0x150 lib/ubsan.c:429
 decode_tail kernel/locking/qspinlock.c:131 [inline]
 __pv_queued_spin_lock_slowpath+0xcb2/0xcc0 kernel/locking/qspinlock.c:468
 pv_queued_spin_lock_slowpath arch/x86/include/asm/paravirt.h:584 [inline]
 queued_spin_lock_slowpath arch/x86/include/asm/qspinlock.h:51 [inline]
 queued_spin_lock include/asm-generic/qspinlock.h:114 [inline]
 do_raw_spin_lock+0x210/0x2c0 kernel/locking/spinlock_debug.c:116
 spin_lock include/linux/spinlock.h:351 [inline]
 br_multicast_port_group_expired+0x70/0x550 net/bridge/br_multicast.c:865
 call_timer_fn+0x1a3/0x610 kernel/time/timer.c:1792
 expire_timers kernel/time/timer.c:1843 [inline]
 __run_timers+0x74b/0xaf0 kernel/time/timer.c:2417
 __run_timer_base kernel/time/timer.c:2428 [inline]
 __run_timer_base kernel/time/timer.c:2421 [inline]
 run_timer_base+0x111/0x190 kernel/time/timer.c:2437
 run_timer_softirq+0x1a/0x40 kernel/time/timer.c:2447
 handle_softirqs+0x219/0x8f0 kernel/softirq.c:554
 __do_softirq kernel/softirq.c:588 [inline]
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu kernel/softirq.c:637 [inline]
 irq_exit_rcu+0xbb/0x120 kernel/softirq.c:649
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
 sysvec_apic_timer_interrupt+0x95/0xb0 arch/x86/kernel/apic/apic.c:1043
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:finish_task_switch.isra.0+0x220/0xcc0 kernel/sched/core.c:5282
Code: a9 0a 00 00 44 8b 0d 17 b0 85 0e 45 85 c9 0f 85 c0 01 00 00 48 89 df e8 ae f
----------------
Code disassembly (best guess):
   0:	a9 0a 00 00 44       	test   $0x4400000a,%eax
   5:	8b 0d 17 b0 85 0e    	mov    0xe85b017(%rip),%ecx        # 0xe85b022
   b:	45 85 c9             	test   %r9d,%r9d
   e:	0f 85 c0 01 00 00    	jne    0x1d4
  14:	48 89 df             	mov    %rbx,%rdi
  17:	e8 ae f8 ff ff       	call   0xfffff8ca
  1c:	e8 b9 da 36 00       	call   0x36dada
  21:	fb                   	sti
  22:	65 48 8b 1d a0 3d a4 	mov    %gs:0x7ea43da0(%rip),%rbx        # 0x7ea43dca
  29:	7e
* 2a:	48 8d bb f8 15 00 00 	lea    0x15f8(%rbx),%rdi <-- trapping instruction
  31:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  38:	fc ff df
  3b:	48 89 fa             	mov    %rdi,%rdx
  3e:	48                   	rex.W
  3f:	c1                   	.byte 0xc1


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

