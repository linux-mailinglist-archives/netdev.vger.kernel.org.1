Return-Path: <netdev+bounces-248963-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 72378D11EBA
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 11:35:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 498363011FB4
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 10:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF9542C032E;
	Mon, 12 Jan 2026 10:33:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f77.google.com (mail-oo1-f77.google.com [209.85.161.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE84630FC10
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 10:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768214011; cv=none; b=Mb/RgRadO2C3VM1IcFo2b42dIxz7n5KaKIFB2rCDj85YUoH6HMt0DMS4EPuJmiAK3OgOKpmeBKU5QDSdKUw9G4enQBQh+Knku6LBo1Rn77hslzvTORlUbr/5kzByOwiV13OxgItuqUpcM3DTNtU9ADsKuHuGWWDqAibxG9k7CDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768214011; c=relaxed/simple;
	bh=AdQ1vcr0a0HhhRwHjA6Cdt5HXPJ+Rqg1jP6d+MBtbgc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=nYw5vRYxwy/OTqQKqdUDtV7zGgxvx9BS571ZAckfz7LEavbpvQnFiUpfPkm/htLM0av2H0go8u+Qt1V5vAY/HSCx/dDLrEAjiect6A0IxL56mub3oceZV7ZNw1+nuPH4m342giEojQpHrUoaq0NsniKFgz2VOx7WqV6dPoMpz9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f77.google.com with SMTP id 006d021491bc7-65b31ec93e7so15139638eaf.3
        for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 02:33:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768214003; x=1768818803;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iMInbmv/+JUY2Ulf5FmNm8zowIGIcYbX925n6yQdQ+4=;
        b=ZmtIIgtWBp9hccbaSvk8rKgvh28S7rIKaxLwWu7x3aFKRolufkO4jPvuTlBymJ6JYq
         uJBCrZyV4TjZrEcbA1f7A1fHXNj7EREfFJkiktAw2pQCVMWt787rK69kwC5PKDlqq1w6
         XNewpEOJIeYeikJnXHw2V0TdEkpv8aLR2VwYLMLR1DppTJ4kqoVveSmL70V/12yk+ht3
         uHKbR8iLClrhrKgo3TWNPGULLMlJyjqRN6BL77k9mu3CmP7fygCwUFNQV94simGi9izd
         U9iUzSnJi5FKyi/rOkCfqQnHQGmRbLwHM9Mk8ICrig2O3BdwWskATJEHR961fJHKsrWX
         50/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVZMNP2+5WC8PKC37UsJ663Lio5+sA6UUJtIiitUA2XSqG3MFL1ypC8fHkC0Y7JE5WJsfzvIAw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsP0guaUzdF1qPh4EI1FiZhDyNvMia1YJFmkQ/t3lxbC/EdNDe
	k2cNKsJ61ABpvi74CsmSi2mKETSDwgSQygBOgvVn2txEQlsl+mS7gj8asKrTGKAKHxLUdMWnwBV
	WZONmKerytLyRRbrcnJ4WO3f52jTXX1ZOv1tBLYVaOFi8+pmWZxBuVwbQq98=
X-Google-Smtp-Source: AGHT+IFjRRVUyWUMCEwNiNvAezsr5v9+jv5k7TYfVcbPnQ9kOsz+LUu0G3G342lb8DNNBg1A3jLnwKCATP3lqhg1gabNVWR02f+Z
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:22a7:b0:65b:3bd8:a75b with SMTP id
 006d021491bc7-65f550bc142mr8395415eaf.72.1768214002938; Mon, 12 Jan 2026
 02:33:22 -0800 (PST)
Date: Mon, 12 Jan 2026 02:33:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6964cdf2.050a0220.eaf7.009d.GAE@google.com>
Subject: [syzbot] [net?] KASAN: slab-use-after-free Write in rt6_disable_ip
From: syzbot <syzbot+179fc225724092b8b2b2@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    dbf8fe85a16a Merge tag 'net-6.19-rc4' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12fea422580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1f2b6fe1fdf1a00b
dashboard link: https://syzkaller.appspot.com/bug?extid=179fc225724092b8b2b2
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0dd7e28ff535/disk-dbf8fe85.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/415f6be702d3/vmlinux-dbf8fe85.xz
kernel image: https://storage.googleapis.com/syzbot-assets/29dd7d9cf7a8/bzImage-dbf8fe85.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+179fc225724092b8b2b2@syzkaller.appspotmail.com

bridge0: port 2(bridge_slave_1) entered disabled state
bridge_slave_0: left allmulticast mode
bridge_slave_0: left promiscuous mode
bridge0: port 1(bridge_slave_0) entered disabled state
==================================================================
BUG: KASAN: slab-use-after-free in INIT_LIST_HEAD include/linux/list.h:46 [inline]
BUG: KASAN: slab-use-after-free in list_del_init include/linux/list.h:296 [inline]
BUG: KASAN: slab-use-after-free in rt6_uncached_list_flush_dev net/ipv6/route.c:191 [inline]
BUG: KASAN: slab-use-after-free in rt6_disable_ip+0x633/0x730 net/ipv6/route.c:5020
Write of size 8 at addr ffff8880294cfa78 by task kworker/u8:14/3450

CPU: 0 UID: 0 PID: 3450 Comm: kworker/u8:14 Tainted: G             L      syzkaller #0 PREEMPT_{RT,(full)} 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
Workqueue: netns cleanup_net
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xca/0x240 mm/kasan/report.c:482
 kasan_report+0x118/0x150 mm/kasan/report.c:595
 INIT_LIST_HEAD include/linux/list.h:46 [inline]
 list_del_init include/linux/list.h:296 [inline]
 rt6_uncached_list_flush_dev net/ipv6/route.c:191 [inline]
 rt6_disable_ip+0x633/0x730 net/ipv6/route.c:5020
 addrconf_ifdown+0x143/0x18a0 net/ipv6/addrconf.c:3853
 addrconf_notify+0x1bc/0x1050 net/ipv6/addrconf.c:-1
 notifier_call_chain+0x19d/0x3a0 kernel/notifier.c:85
 call_netdevice_notifiers_extack net/core/dev.c:2268 [inline]
 call_netdevice_notifiers net/core/dev.c:2282 [inline]
 netif_close_many+0x29c/0x410 net/core/dev.c:1785
 unregister_netdevice_many_notify+0xb50/0x2330 net/core/dev.c:12353
 ops_exit_rtnl_list net/core/net_namespace.c:187 [inline]
 ops_undo_list+0x3dc/0x990 net/core/net_namespace.c:248
 cleanup_net+0x4de/0x7b0 net/core/net_namespace.c:696
 process_one_work kernel/workqueue.c:3257 [inline]
 process_scheduled_works+0xad1/0x1770 kernel/workqueue.c:3340
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3421
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x510/0xa50 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
 </TASK>

Allocated by task 803:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 unpoison_slab_object mm/kasan/common.c:340 [inline]
 __kasan_slab_alloc+0x6c/0x80 mm/kasan/common.c:366
 kasan_slab_alloc include/linux/kasan.h:253 [inline]
 slab_post_alloc_hook mm/slub.c:4953 [inline]
 slab_alloc_node mm/slub.c:5263 [inline]
 kmem_cache_alloc_noprof+0x18d/0x6c0 mm/slub.c:5270
 dst_alloc+0x105/0x170 net/core/dst.c:89
 ip6_dst_alloc net/ipv6/route.c:342 [inline]
 icmp6_dst_alloc+0x75/0x460 net/ipv6/route.c:3333
 mld_sendpack+0x683/0xe60 net/ipv6/mcast.c:1844
 mld_send_cr net/ipv6/mcast.c:2154 [inline]
 mld_ifc_work+0x83e/0xd60 net/ipv6/mcast.c:2693
 process_one_work kernel/workqueue.c:3257 [inline]
 process_scheduled_works+0xad1/0x1770 kernel/workqueue.c:3340
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3421
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x510/0xa50 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246

Freed by task 20:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x5c/0x80 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2540 [inline]
 slab_free mm/slub.c:6670 [inline]
 kmem_cache_free+0x18f/0x8d0 mm/slub.c:6781
 dst_destroy+0x235/0x350 net/core/dst.c:121
 rcu_do_batch kernel/rcu/tree.c:2605 [inline]
 rcu_core kernel/rcu/tree.c:2857 [inline]
 rcu_cpu_kthread+0xba5/0x1af0 kernel/rcu/tree.c:2945
 smpboot_thread_fn+0x542/0xa60 kernel/smpboot.c:160
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x510/0xa50 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246

Last potentially related work creation:
 kasan_save_stack+0x3e/0x60 mm/kasan/common.c:57
 kasan_record_aux_stack+0xbd/0xd0 mm/kasan/generic.c:556
 __call_rcu_common kernel/rcu/tree.c:3119 [inline]
 call_rcu+0xee/0x890 kernel/rcu/tree.c:3239
 refdst_drop include/net/dst.h:266 [inline]
 skb_dst_drop include/net/dst.h:278 [inline]
 skb_release_head_state+0x71/0x360 net/core/skbuff.c:1156
 skb_release_all net/core/skbuff.c:1180 [inline]
 __kfree_skb net/core/skbuff.c:1196 [inline]
 sk_skb_reason_drop+0xe9/0x170 net/core/skbuff.c:1234
 kfree_skb_reason include/linux/skbuff.h:1322 [inline]
 tcf_kfree_skb_list include/net/sch_generic.h:1127 [inline]
 __dev_xmit_skb net/core/dev.c:4260 [inline]
 __dev_queue_xmit+0x26aa/0x3210 net/core/dev.c:4785
 NF_HOOK_COND include/linux/netfilter.h:307 [inline]
 ip6_output+0x340/0x550 net/ipv6/ip6_output.c:247
 NF_HOOK+0x9e/0x380 include/linux/netfilter.h:318
 mld_sendpack+0x8d4/0xe60 net/ipv6/mcast.c:1855
 mld_send_cr net/ipv6/mcast.c:2154 [inline]
 mld_ifc_work+0x83e/0xd60 net/ipv6/mcast.c:2693
 process_one_work kernel/workqueue.c:3257 [inline]
 process_scheduled_works+0xad1/0x1770 kernel/workqueue.c:3340
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3421
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x510/0xa50 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246

The buggy address belongs to the object at ffff8880294cfa00
 which belongs to the cache ip6_dst_cache of size 232
The buggy address is located 120 bytes inside of
 freed 232-byte region [ffff8880294cfa00, ffff8880294cfae8)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x294cf
memcg:ffff88803536b781
flags: 0x80000000000000(node=0|zone=1)
page_type: f5(slab)
raw: 0080000000000000 ffff88802ff1c8c0 ffffea0000bf2bc0 dead000000000006
raw: 0000000000000000 00000000800c000c 00000000f5000000 ffff88803536b781
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52820(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 9, tgid 9 (kworker/0:0), ts 91119585830, free_ts 91088628818
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x234/0x290 mm/page_alloc.c:1857
 prep_new_page mm/page_alloc.c:1865 [inline]
 get_page_from_freelist+0x28c0/0x2960 mm/page_alloc.c:3915
 __alloc_frozen_pages_noprof+0x181/0x370 mm/page_alloc.c:5210
 alloc_pages_mpol+0xd1/0x380 mm/mempolicy.c:2486
 alloc_slab_page mm/slub.c:3075 [inline]
 allocate_slab+0x86/0x3b0 mm/slub.c:3248
 new_slab mm/slub.c:3302 [inline]
 ___slab_alloc+0xb10/0x13e0 mm/slub.c:4656
 __slab_alloc+0xc6/0x1f0 mm/slub.c:4779
 __slab_alloc_node mm/slub.c:4855 [inline]
 slab_alloc_node mm/slub.c:5251 [inline]
 kmem_cache_alloc_noprof+0x101/0x6c0 mm/slub.c:5270
 dst_alloc+0x105/0x170 net/core/dst.c:89
 ip6_dst_alloc net/ipv6/route.c:342 [inline]
 icmp6_dst_alloc+0x75/0x460 net/ipv6/route.c:3333
 mld_sendpack+0x683/0xe60 net/ipv6/mcast.c:1844
 mld_send_cr net/ipv6/mcast.c:2154 [inline]
 mld_ifc_work+0x83e/0xd60 net/ipv6/mcast.c:2693
 process_one_work kernel/workqueue.c:3257 [inline]
 process_scheduled_works+0xad1/0x1770 kernel/workqueue.c:3340
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3421
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x510/0xa50 arch/x86/kernel/process.c:158
page last free pid 5859 tgid 5859 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1406 [inline]
 __free_frozen_pages+0xfe1/0x1170 mm/page_alloc.c:2943
 discard_slab mm/slub.c:3346 [inline]
 __put_partials+0x149/0x170 mm/slub.c:3886
 __slab_free+0x2af/0x330 mm/slub.c:5952
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x97/0x100 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x148/0x160 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x22/0x80 mm/kasan/common.c:350
 kasan_slab_alloc include/linux/kasan.h:253 [inline]
 slab_post_alloc_hook mm/slub.c:4953 [inline]
 slab_alloc_node mm/slub.c:5263 [inline]
 kmem_cache_alloc_noprof+0x18d/0x6c0 mm/slub.c:5270
 getname_flags+0xb8/0x540 fs/namei.c:146
 getname include/linux/fs.h:2498 [inline]
 do_sys_openat2+0xbc/0x200 fs/open.c:1426
 do_sys_open fs/open.c:1436 [inline]
 __do_sys_openat fs/open.c:1452 [inline]
 __se_sys_openat fs/open.c:1447 [inline]
 __x64_sys_openat+0x138/0x170 fs/open.c:1447
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xec/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff8880294cf900: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff8880294cf980: 00 00 00 00 00 fc fc fc fc fc fc fc fc fc fc fc
>ffff8880294cfa00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                                ^
 ffff8880294cfa80: fb fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc
 ffff8880294cfb00: fc fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb
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

