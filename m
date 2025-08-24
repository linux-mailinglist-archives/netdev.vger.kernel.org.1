Return-Path: <netdev+bounces-216331-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 058E1B33257
	for <lists+netdev@lfdr.de>; Sun, 24 Aug 2025 21:21:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92D5644756A
	for <lists+netdev@lfdr.de>; Sun, 24 Aug 2025 19:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39496219319;
	Sun, 24 Aug 2025 19:21:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9181F09A3
	for <netdev@vger.kernel.org>; Sun, 24 Aug 2025 19:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756063286; cv=none; b=so6AAJIMYe4+NS6kr4L2821yxjncRAJPlCNMHZ9UGvhrV0boqP8JoRS0k+V/4JrqcngBe2xMKW7HhhNGWjFKrNfrJkPYgLHEYHlsmFHx1ptUNL4aVyWtidjtMh26kNTXV8UCsA620YIW3oP3dJXDRAO4d0wrxmNzv32e4HXdyE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756063286; c=relaxed/simple;
	bh=DDZVK/fbhS5PPF5Pro92XtxUL1NDuRiSYSVvG78Kcu8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=KHDe+IXJuMbSjOWHbakgf9v6VMdXLdInpw1vPwP00nIFNMcGBJNduLqYnXsbQ/7Rjibk4iW4udF0VJqlp24dyqii1UvmK1PIkBuGvzgsHGc9WmHTKpe39aU5QaWvTEMOrIjsq2elwPtWSp8yDLSOhcPjhf9Lv7dMi25jT4ynR24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-88432a2583bso442952039f.1
        for <netdev@vger.kernel.org>; Sun, 24 Aug 2025 12:21:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756063283; x=1756668083;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E55sr+LUKIqvrZsW0KN+7bJUGL9PpW/3YlCadbUSlH4=;
        b=bJRSgWYEnT8JGTijRcO6fkXdg7aJehOsOMrQHb26E3y54wkkR3AxmEO9r7LxvmACoZ
         OaNotGUyGfMFDYFHIU9A8RVe2esYOqdSdNRGJPLOnk3aftVCOpI/ElH3Sce3OcJ/+cUR
         dJo4HtX1UsAg+D8iygTM/kIUJ+bGQrVX0hsL3ZCcV2dRs31JAcPhr7GKbx2i98+pp6Tx
         nwCFZAlFIWPFxnKibtPIXFIBDve2x+8aDZvvo4cAGq4LBZyzaxZ2bsG/ljJZR0LTsG/N
         HZTBCN7UAUvVH+PLuTwmFqOLZ5bqP5G4tu+mIOFtZKIRR2NTtHStmiY4blcXyn9GXYaL
         flaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdQnfTBWhGeUP2Xx81GTgkYwLoW/lyH1tg1P00NupdSiLUKUpY+U6aersSOD6UPZYBYZo4Ivs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX/DOhGKH6hodl95GDK3YaSW/NSZpJXHetoJDF0TuTAQL6ZPEs
	nCMi7dLb78RTHZFSWfPVzSs/+jr+hm4DOlhHqu+aIUv6Qiup58/d4TGnBWWv/KSJgLuvQLmzbD5
	KeAt/dKec5vv1McKVqweH6lBHuuXXFz5luG489hXpuII/3bOTb5XqdgwSn0w=
X-Google-Smtp-Source: AGHT+IH9gQIjNIuV/YBxtbf/ds+DHnBMLPJr8LRw3LQz89iRKVwD+lBd2ju6UB2dOn6kIBIbuXN7N01Dk56mCmyLJMqlkyODDBSG
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:a019:b0:884:b65:c3f1 with SMTP id
 ca18e2360f4ac-886b52578c6mr1926207339f.5.1756063283559; Sun, 24 Aug 2025
 12:21:23 -0700 (PDT)
Date: Sun, 24 Aug 2025 12:21:23 -0700
In-Reply-To: <68887370.a00a0220.b12ec.00cb.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ab6633.050a0220.37038e.0079.GAE@google.com>
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Write in __xfrm_state_delete
From: syzbot <syzbot+a25ee9d20d31e483ba7b@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, herbert@gondor.apana.org.au, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, steffen.klassert@secunet.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    b1c92cdf5af3 Merge branch 'net-wangxun-complete-ethtool-co..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1411b062580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=67b99ceb67d33475
dashboard link: https://syzkaller.appspot.com/bug?extid=a25ee9d20d31e483ba7b
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14221862580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=159fba34580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a4625f767959/disk-b1c92cdf.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/badbbc9af277/vmlinux-b1c92cdf.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d4420eb2b894/bzImage-b1c92cdf.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a25ee9d20d31e483ba7b@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in __hlist_del include/linux/list.h:980 [inline]
BUG: KASAN: slab-use-after-free in hlist_del_rcu include/linux/rculist.h:560 [inline]
BUG: KASAN: slab-use-after-free in __xfrm_state_delete+0x666/0xca0 net/xfrm/xfrm_state.c:830
Write of size 8 at addr ffff88802e995568 by task kworker/u8:1/13

CPU: 0 UID: 0 PID: 13 Comm: kworker/u8:1 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
Workqueue: netns cleanup_net
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xca/0x240 mm/kasan/report.c:482
 kasan_report+0x118/0x150 mm/kasan/report.c:595
 __hlist_del include/linux/list.h:980 [inline]
 hlist_del_rcu include/linux/rculist.h:560 [inline]
 __xfrm_state_delete+0x666/0xca0 net/xfrm/xfrm_state.c:830
 xfrm_state_delete net/xfrm/xfrm_state.c:856 [inline]
 xfrm_state_flush+0x45f/0x770 net/xfrm/xfrm_state.c:939
 xfrm6_tunnel_net_exit+0x3c/0x100 net/ipv6/xfrm6_tunnel.c:337
 ops_exit_list net/core/net_namespace.c:198 [inline]
 ops_undo_list+0x497/0x990 net/core/net_namespace.c:251
 cleanup_net+0x4c5/0x800 net/core/net_namespace.c:682
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3319
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3400
 kthread+0x70e/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x3f9/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Allocated by task 7220:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:330 [inline]
 __kasan_slab_alloc+0x6c/0x80 mm/kasan/common.c:356
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4180 [inline]
 slab_alloc_node mm/slub.c:4229 [inline]
 kmem_cache_alloc_noprof+0x1c1/0x3c0 mm/slub.c:4236
 xfrm_state_alloc+0x24/0x2f0 net/xfrm/xfrm_state.c:733
 __find_acq_core+0x8a7/0x1c00 net/xfrm/xfrm_state.c:1833
 xfrm_find_acq+0x78/0xa0 net/xfrm/xfrm_state.c:2353
 xfrm_alloc_userspi+0x6b3/0xc90 net/xfrm/xfrm_user.c:1863
 xfrm_user_rcv_msg+0x7a0/0xab0 net/xfrm/xfrm_user.c:3501
 netlink_rcv_skb+0x205/0x470 net/netlink/af_netlink.c:2552
 xfrm_netlink_rcv+0x79/0x90 net/xfrm/xfrm_user.c:3523
 netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
 netlink_unicast+0x82c/0x9e0 net/netlink/af_netlink.c:1346
 netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1896
 sock_sendmsg_nosec net/socket.c:714 [inline]
 __sock_sendmsg+0x21c/0x270 net/socket.c:729
 ____sys_sendmsg+0x505/0x830 net/socket.c:2614
 ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2668
 __sys_sendmsg net/socket.c:2700 [inline]
 __do_sys_sendmsg net/socket.c:2705 [inline]
 __se_sys_sendmsg net/socket.c:2703 [inline]
 __x64_sys_sendmsg+0x19b/0x260 net/socket.c:2703
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 121:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:576
 poison_slab_object mm/kasan/common.c:243 [inline]
 __kasan_slab_free+0x5b/0x80 mm/kasan/common.c:275
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2417 [inline]
 slab_free mm/slub.c:4680 [inline]
 kmem_cache_free+0x18f/0x400 mm/slub.c:4782
 xfrm_state_free net/xfrm/xfrm_state.c:591 [inline]
 xfrm_state_gc_destroy net/xfrm/xfrm_state.c:618 [inline]
 xfrm_state_gc_task+0x52d/0x6b0 net/xfrm/xfrm_state.c:634
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3319
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3400
 kthread+0x70e/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x3f9/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

The buggy address belongs to the object at ffff88802e995540
 which belongs to the cache xfrm_state of size 928
The buggy address is located 40 bytes inside of
 freed 928-byte region [ffff88802e995540, ffff88802e9958e0)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x2e994
head: order:2 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88801af8b500 ffffea0000c0bb00 0000000000000004
raw: 0000000000000000 00000000000f000f 00000000f5000000 0000000000000000
head: 00fff00000000040 ffff88801af8b500 ffffea0000c0bb00 0000000000000004
head: 0000000000000000 00000000000f000f 00000000f5000000 0000000000000000
head: 00fff00000000002 ffffea0000ba6501 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000004
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 2, migratetype Unmovable, gfp_mask 0x52820(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 6643, tgid 6643 (syz.0.607), ts 322721257081, free_ts 315414996241
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x240/0x2a0 mm/page_alloc.c:1851
 prep_new_page mm/page_alloc.c:1859 [inline]
 get_page_from_freelist+0x21e4/0x22c0 mm/page_alloc.c:3858
 __alloc_frozen_pages_noprof+0x181/0x370 mm/page_alloc.c:5148
 alloc_pages_mpol+0x232/0x4a0 mm/mempolicy.c:2416
 alloc_slab_page mm/slub.c:2487 [inline]
 allocate_slab+0x8a/0x370 mm/slub.c:2655
 new_slab mm/slub.c:2709 [inline]
 ___slab_alloc+0xbeb/0x1410 mm/slub.c:3891
 __slab_alloc mm/slub.c:3981 [inline]
 __slab_alloc_node mm/slub.c:4056 [inline]
 slab_alloc_node mm/slub.c:4217 [inline]
 kmem_cache_alloc_noprof+0x283/0x3c0 mm/slub.c:4236
 xfrm_state_alloc+0x24/0x2f0 net/xfrm/xfrm_state.c:733
 __find_acq_core+0x8a7/0x1c00 net/xfrm/xfrm_state.c:1833
 xfrm_find_acq+0x78/0xa0 net/xfrm/xfrm_state.c:2353
 xfrm_alloc_userspi+0x6b3/0xc90 net/xfrm/xfrm_user.c:1863
 xfrm_user_rcv_msg+0x7a0/0xab0 net/xfrm/xfrm_user.c:3501
 netlink_rcv_skb+0x205/0x470 net/netlink/af_netlink.c:2552
 xfrm_netlink_rcv+0x79/0x90 net/xfrm/xfrm_user.c:3523
 netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
 netlink_unicast+0x82c/0x9e0 net/netlink/af_netlink.c:1346
 netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1896
page last free pid 6006 tgid 6006 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1395 [inline]
 __free_frozen_pages+0xbc4/0xd30 mm/page_alloc.c:2895
 __slab_free+0x303/0x3c0 mm/slub.c:4591
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x97/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x148/0x160 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x22/0x80 mm/kasan/common.c:340
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4180 [inline]
 slab_alloc_node mm/slub.c:4229 [inline]
 kmem_cache_alloc_lru_noprof+0x1c6/0x3d0 mm/slub.c:4248
 sock_alloc_inode+0x28/0xc0 net/socket.c:309
 alloc_inode+0x6a/0x1b0 fs/inode.c:346
 new_inode_pseudo include/linux/fs.h:3391 [inline]
 sock_alloc net/socket.c:624 [inline]
 __sock_create+0x12d/0x9f0 net/socket.c:1553
 sock_create net/socket.c:1647 [inline]
 __sys_socket_create net/socket.c:1684 [inline]
 __sys_socket+0xd7/0x1b0 net/socket.c:1731
 __do_sys_socket net/socket.c:1745 [inline]
 __se_sys_socket net/socket.c:1743 [inline]
 __x64_sys_socket+0x7a/0x90 net/socket.c:1743
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff88802e995400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88802e995480: fb fb fb fb fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88802e995500: fc fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb
                                                          ^
 ffff88802e995580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88802e995600: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

