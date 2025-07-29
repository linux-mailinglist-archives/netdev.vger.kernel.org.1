Return-Path: <netdev+bounces-210724-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2FEAB148F0
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 09:08:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64FB218A04CF
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 07:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02410261593;
	Tue, 29 Jul 2025 07:08:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223FB256C9B
	for <netdev@vger.kernel.org>; Tue, 29 Jul 2025 07:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753772914; cv=none; b=htufIxOqukarW/F3TBR+TLAQXEZfpIF2jsK2PponbxK1IUJdhBE/2wQw/FbmhW7oxnxbKqvYixQZX4HlWGwZzllrmiQ3QIqykmOQfzoDa0JHmUfw9eTVYD/e628BykYQ1tQ+I23BAekLiW7cBZdQx6HwKeNiG16v0gs1XcZclEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753772914; c=relaxed/simple;
	bh=CfLgqD9hu9Z4LaCDGWfOhatpxMLBITlYooUSO9SaSto=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=H/3Rgc5nzWC9micEe2GWH9JMhortKzys8sM6wJeRv7xw4QY166/yu8E9W20XhbzMndxYBrPwUyf5yYFPs5Kl3RAnScB3waVMsn+dkl+7H8/qI6cvuOWbaRkN/hdjOgw5nNMskeAVaHlcoUqHCAezw7+ApcMsivdrCQHMisbtIas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3ddbec809acso62080605ab.2
        for <netdev@vger.kernel.org>; Tue, 29 Jul 2025 00:08:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753772912; x=1754377712;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BVzJVgZwKF1sjTmbJN2XhPxfWnGZdwivZhSevSCKNOg=;
        b=kdNvG+xcNXqt7aLW5BLedWr5LtZk3xmjVGh4YR1JQZeR9AEYdsU11CfnaOu8BqI42e
         oXs96oiDk9ZnMsv7xLpwZ4WCa0gNVoxX+li8TACFOm5NZETUYGLHuClE0TuJMNvhx9Tp
         g7LEYofmGuTp6hA906UjrsyAkpqlZCeiXkktZxK6DImw88suT9vr3WYNZFT9v1C4CiKB
         mKPZ7WM8FAx+bvlUZ5cBQoyFwVESPFQ+t4K1gu5DdCOHgPAxeDM5GsILkzhKjprnyfmX
         P8VGok8EV65r1YQbT0DyPzMs4VE3K5SW1x+nKegSBRj0VmWz2NZ9ka3qFgtjBLugcWkE
         SKog==
X-Forwarded-Encrypted: i=1; AJvYcCWnRROhp9QxAlQirdcNSCFn42OLHJ26yCHAvdm5Urb8UF31WgBvtHpR/mczCodP8ZW+uMD9E3A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo9yiUapNKdqzWkgW1EWMY5Mn0QiECF6rD7h25ENV5AnrrrYoL
	1Q1divzBkewZrMfjxguNx0kIPtk7prDnCxbgtqx8JP+It0Q17f0pgA79W85XZ2wYpGo9oIbxT5W
	F0q2zex4Y6t3GOxv1f2gxuPPrif1SJw03LH9E5E5OHds/N5YhSAYlZhCFqPk=
X-Google-Smtp-Source: AGHT+IGFlPHj+lug04XmHUogvGHgs0cLVmpuZfJToxoL0W/LSrgxsEIT0zC1nd2AkzE7Bxtkb+UZUjeqZuDdAl31MejDsFLZlUOc
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:19ce:b0:3df:3bc5:bac1 with SMTP id
 e9e14a558f8ab-3e3c5250ebdmr246179725ab.5.1753772912289; Tue, 29 Jul 2025
 00:08:32 -0700 (PDT)
Date: Tue, 29 Jul 2025 00:08:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68887370.a00a0220.b12ec.00cb.GAE@google.com>
Subject: [syzbot] [net?] KASAN: slab-use-after-free Write in __xfrm_state_delete
From: syzbot <syzbot+a25ee9d20d31e483ba7b@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, herbert@gondor.apana.org.au, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, steffen.klassert@secunet.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    fa582ca7e187 dpll: zl3073x: Fix build failure
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=146f9034580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=eaf2a9cf21578aa9
dashboard link: https://syzkaller.appspot.com/bug?extid=a25ee9d20d31e483ba7b
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a704dcfc1b79/disk-fa582ca7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b47b9b6cceb4/vmlinux-fa582ca7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/adcc93889faf/bzImage-fa582ca7.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a25ee9d20d31e483ba7b@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in __hlist_del include/linux/list.h:982 [inline]
BUG: KASAN: slab-use-after-free in hlist_del_rcu include/linux/rculist.h:560 [inline]
BUG: KASAN: slab-use-after-free in __xfrm_state_delete+0x696/0xca0 net/xfrm/xfrm_state.c:830
Write of size 8 at addr ffff888040300470 by task kworker/0:4/5933

CPU: 0 UID: 0 PID: 5933 Comm: kworker/0:4 Not tainted 6.16.0-rc7-syzkaller-02024-gfa582ca7e187 #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
Workqueue: events xfrm_state_gc_task
Call Trace:
 <IRQ>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xca/0x230 mm/kasan/report.c:480
 kasan_report+0x118/0x150 mm/kasan/report.c:593
 __hlist_del include/linux/list.h:982 [inline]
 hlist_del_rcu include/linux/rculist.h:560 [inline]
 __xfrm_state_delete+0x696/0xca0 net/xfrm/xfrm_state.c:830
 xfrm_timer_handler+0x18f/0xa00 net/xfrm/xfrm_state.c:716
 __run_hrtimer kernel/time/hrtimer.c:1761 [inline]
 __hrtimer_run_queues+0x52c/0xc60 kernel/time/hrtimer.c:1825
 hrtimer_run_softirq+0x187/0x2b0 kernel/time/hrtimer.c:1842
 handle_softirqs+0x286/0x870 kernel/softirq.c:579
 do_softirq+0xec/0x180 kernel/softirq.c:480
 </IRQ>
 <TASK>
 __local_bh_enable_ip+0x17d/0x1c0 kernel/softirq.c:407
 spin_unlock_bh include/linux/spinlock.h:396 [inline]
 xfrm_state_gc_task+0xd1/0x6a0 net/xfrm/xfrm_state.c:629
 process_one_work kernel/workqueue.c:3238 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3321
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3402
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Allocated by task 13089:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:319 [inline]
 __kasan_slab_alloc+0x6c/0x80 mm/kasan/common.c:345
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4148 [inline]
 slab_alloc_node mm/slub.c:4197 [inline]
 kmem_cache_alloc_noprof+0x1c1/0x3c0 mm/slub.c:4204
 xfrm_state_alloc+0x24/0x2f0 net/xfrm/xfrm_state.c:733
 pfkey_msg2xfrm_state net/key/af_key.c:1122 [inline]
 pfkey_add+0x6e4/0x2e00 net/key/af_key.c:1504
 pfkey_process net/key/af_key.c:2848 [inline]
 pfkey_sendmsg+0xbfe/0x1090 net/key/af_key.c:3699
 sock_sendmsg_nosec net/socket.c:714 [inline]
 __sock_sendmsg+0x219/0x270 net/socket.c:729
 ____sys_sendmsg+0x505/0x830 net/socket.c:2614
 ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2668
 __sys_sendmsg net/socket.c:2700 [inline]
 __do_sys_sendmsg net/socket.c:2705 [inline]
 __se_sys_sendmsg net/socket.c:2703 [inline]
 __x64_sys_sendmsg+0x19b/0x260 net/socket.c:2703
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 5934:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:576
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x62/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2381 [inline]
 slab_free mm/slub.c:4643 [inline]
 kmem_cache_free+0x18f/0x400 mm/slub.c:4745
 xfrm_state_free net/xfrm/xfrm_state.c:591 [inline]
 xfrm_state_gc_destroy net/xfrm/xfrm_state.c:618 [inline]
 xfrm_state_gc_task+0x518/0x6a0 net/xfrm/xfrm_state.c:634
 process_one_work kernel/workqueue.c:3238 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3321
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3402
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

The buggy address belongs to the object at ffff888040300440
 which belongs to the cache xfrm_state of size 928
The buggy address is located 48 bytes inside of
 freed 928-byte region [ffff888040300440, ffff8880403007e0)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff888040302a80 pfn:0x40300
head: order:2 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88801cae7dc0 dead000000000122 0000000000000000
raw: ffff888040302a80 00000000800f000b 00000000f5000000 0000000000000000
head: 00fff00000000040 ffff88801cae7dc0 dead000000000122 0000000000000000
head: ffff888040302a80 00000000800f000b 00000000f5000000 0000000000000000
head: 00fff00000000002 ffffea000100c001 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000004
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 2, migratetype Unmovable, gfp_mask 0x52820(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 7981, tgid 7977 (syz.1.516), ts 145890504879, free_ts 145801949982
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
 kmem_cache_alloc_noprof+0x283/0x3c0 mm/slub.c:4204
 xfrm_state_alloc+0x24/0x2f0 net/xfrm/xfrm_state.c:733
 xfrm_state_construct net/xfrm/xfrm_user.c:889 [inline]
 xfrm_add_sa+0x17d1/0x4070 net/xfrm/xfrm_user.c:1019
 xfrm_user_rcv_msg+0x7a3/0xab0 net/xfrm/xfrm_user.c:3501
 netlink_rcv_skb+0x205/0x470 net/netlink/af_netlink.c:2552
 xfrm_netlink_rcv+0x79/0x90 net/xfrm/xfrm_user.c:3523
 netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
 netlink_unicast+0x82f/0x9e0 net/netlink/af_netlink.c:1346
 netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1896
 sock_sendmsg_nosec net/socket.c:714 [inline]
 __sock_sendmsg+0x219/0x270 net/socket.c:729
 ____sys_sendmsg+0x505/0x830 net/socket.c:2614
page last free pid 7991 tgid 7989 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1248 [inline]
 __free_frozen_pages+0xc71/0xe70 mm/page_alloc.c:2706
 discard_slab mm/slub.c:2717 [inline]
 __put_partials+0x161/0x1c0 mm/slub.c:3186
 put_cpu_partial+0x17c/0x250 mm/slub.c:3261
 __slab_free+0x2f7/0x400 mm/slub.c:4513
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x97/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x148/0x160 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x22/0x80 mm/kasan/common.c:329
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4148 [inline]
 slab_alloc_node mm/slub.c:4197 [inline]
 kmem_cache_alloc_lru_noprof+0x1c6/0x3d0 mm/slub.c:4216
 shmem_alloc_inode+0x28/0x40 mm/shmem.c:5150
 alloc_inode+0x67/0x1b0 fs/inode.c:346
 new_inode+0x22/0x170 fs/inode.c:1145
 __shmem_get_inode mm/shmem.c:3049 [inline]
 shmem_get_inode+0x346/0xe90 mm/shmem.c:3123
 shmem_mknod+0x18c/0x3e0 mm/shmem.c:3844
 lookup_open fs/namei.c:3717 [inline]
 open_last_lookups fs/namei.c:3816 [inline]
 path_openat+0x14f4/0x3830 fs/namei.c:4052
 do_filp_open+0x1fa/0x410 fs/namei.c:4082
 do_sys_openat2+0x121/0x1c0 fs/open.c:1437

Memory state around the buggy address:
 ffff888040300300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888040300380: fb fb fb fb fc fc fc fc fc fc fc fc fc fc fc fc
>ffff888040300400: fc fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb
                                                             ^
 ffff888040300480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888040300500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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

