Return-Path: <netdev+bounces-228563-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BAC0BCE310
	for <lists+netdev@lfdr.de>; Fri, 10 Oct 2025 20:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6908F4E84FF
	for <lists+netdev@lfdr.de>; Fri, 10 Oct 2025 18:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D402F3633;
	Fri, 10 Oct 2025 18:11:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1152ED854
	for <netdev@vger.kernel.org>; Fri, 10 Oct 2025 18:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760119891; cv=none; b=fVVhemxXoR4TifwZr1fiFMJhu7wh7gZoctRrd6xQ7c4HdhYTciBICEyYh8MdM5PhVL47cHpuIoBXWIb941DSaUPmwGZud4CbcuDpUIePoHYxZYp4Or2oIleAtEfDjYBPpiBkLUlYqa59uJELH7udacXzD+0AkOkA7/eSNYRRMb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760119891; c=relaxed/simple;
	bh=jroSb0GeuwaUWWYpr919dUviQieVv2crGZ0pB5X99iU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Qjb9sNaIzDAK5Hz0jwnDyFEHGS7fxa47pRO1y2btxSYFhUg8G7Ok3vYfiHR4LFRq+9tov0nIi1bAz+75hWSCWThgueR6VcYGMXMSujSrLyaTHFAlxXJO8uKwXLIW+aXnyRVcj5a7nauqb6pWeLQ7SH8caEAOtkx+1+wb7ZW3WvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-937ce715b90so992847839f.0
        for <netdev@vger.kernel.org>; Fri, 10 Oct 2025 11:11:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760119889; x=1760724689;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A4ZPfdM/tOvI57tbUB064ewdT3F0ExQQ9e7VQddRHIo=;
        b=pREBIltia428D3N9VZYq+N+vInAezoqgqzLv+uScLdCzvO9mlfx/47+RYuAgxffvbr
         5zBEwpFAxm9p8Ge41frMCGdjXGbTDZHtMlVhwrS1rYvDKGvLi1MO/Ia728U74MPLmlls
         IAEor17fl7yjP1Va4pNJG77t9dN2QQaw3DxU6CCcw6hcbpD5/pI2B0HusOYKoLSdhgZv
         wO5Hk2AwpQ8CJksAnMXyScZSIowbKeivzsvZTFkHTOVYd+higPtQgYj0+5abNRJ77VrU
         jMo4qy93PSNjH/1zRqd+rBNUvcbEvdgkhDINdmE+g+7E0AaE6+fg7J9mcIsjNlxEuRzO
         BZ9w==
X-Forwarded-Encrypted: i=1; AJvYcCXolcRyOfLjiGO7CnI2YZSaj0ceEcKJeYJcZ/2xjQ8gF+A6ehErwsEJU5xBUgfd4shCQg0MjDo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEbMn5Rn0yeYqrTzD91BlKWzhuoWobviIQ7WEkzghIPq+N6S4K
	lNnuJ6nZkm+Mnkwg4IFeH0g2J5x1BtcKbw+QcLJ3IKTBqA15lBu+OoH00TuDaiZj3f/WooqANvD
	zhkebT3WIESCOJ2zZGgeRKkzYgb5xhDF+wBmAJwEeveGQDuoyabVGKKSN75s=
X-Google-Smtp-Source: AGHT+IEegEZG5KH1gQP89itIXU3fJWAIIJprLAOgbNp6UunfEp6ZOBfBJMZabT0qKdB5mLU3o+d1+/XWAcC8pexompf7EURWCIgT
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3425:b0:8f6:8812:ef66 with SMTP id
 ca18e2360f4ac-93bd1776ad9mr1743686739f.4.1760119888756; Fri, 10 Oct 2025
 11:11:28 -0700 (PDT)
Date: Fri, 10 Oct 2025 11:11:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68e94c50.a70a0220.b3ac9.0000.GAE@google.com>
Subject: [syzbot] [bridge?] KASAN: slab-use-after-free Read in
 br_switchdev_fdb_notify (2)
From: syzbot <syzbot+8a7f78e2f99977bb8765@syzkaller.appspotmail.com>
To: bridge@lists.linux.dev, davem@davemloft.net, edumazet@google.com, 
	horms@kernel.org, idosch@nvidia.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	razor@blackwall.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    1b54b0756f05 net: doc: Fix typos in docs
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=15412304580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7a57b6f4ce559d7f
dashboard link: https://syzkaller.appspot.com/bug?extid=8a7f78e2f99977bb8765
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/32476f0f6d41/disk-1b54b075.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f74e972d1c5e/vmlinux-1b54b075.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a3d8ae0b9753/bzImage-1b54b075.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8a7f78e2f99977bb8765@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in br_switchdev_fdb_populate net/bridge/br_switchdev.c:141 [inline]
BUG: KASAN: slab-use-after-free in br_switchdev_fdb_notify+0x30b/0x3e0 net/bridge/br_switchdev.c:165
Read of size 8 at addr ffff8880558bd808 by task kworker/0:4/5896

CPU: 0 UID: 0 PID: 5896 Comm: kworker/0:4 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
Workqueue: events_long br_fdb_cleanup
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xca/0x240 mm/kasan/report.c:482
 kasan_report+0x118/0x150 mm/kasan/report.c:595
 br_switchdev_fdb_populate net/bridge/br_switchdev.c:141 [inline]
 br_switchdev_fdb_notify+0x30b/0x3e0 net/bridge/br_switchdev.c:165
 fdb_notify+0x89/0x160 net/bridge/br_fdb.c:186
 fdb_delete+0xec4/0x1160 net/bridge/br_fdb.c:324
 br_fdb_cleanup+0x2aa/0x4d0 net/bridge/br_fdb.c:574
 process_one_work kernel/workqueue.c:3263 [inline]
 process_scheduled_works+0xade/0x17b0 kernel/workqueue.c:3346
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3427
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x436/0x7d0 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Allocated by task 14184:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:388 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:405
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __do_kmalloc_node mm/slub.c:4376 [inline]
 __kmalloc_node_noprof+0x276/0x4e0 mm/slub.c:4382
 kmalloc_node_noprof include/linux/slab.h:932 [inline]
 crypto_alloc_tfmmem crypto/api.c:514 [inline]
 crypto_create_tfm_node+0x83/0x3f0 crypto/api.c:534
 crypto_alloc_tfm_node+0x172/0x3f0 crypto/api.c:642
 tls_set_sw_offload+0xa37/0x17d0 net/tls/tls_sw.c:2820
 do_tls_setsockopt_conf net/tls/tls_main.c:698 [inline]
 do_tls_setsockopt net/tls/tls_main.c:824 [inline]
 tls_setsockopt+0xc40/0x1340 net/tls/tls_main.c:852
 do_sock_setsockopt+0x17c/0x1b0 net/socket.c:2360
 __sys_setsockopt net/socket.c:2385 [inline]
 __do_sys_setsockopt net/socket.c:2391 [inline]
 __se_sys_setsockopt net/socket.c:2388 [inline]
 __x64_sys_setsockopt+0x13f/0x1b0 net/socket.c:2388
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 14179:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:576
 poison_slab_object mm/kasan/common.c:243 [inline]
 __kasan_slab_free+0x5b/0x80 mm/kasan/common.c:275
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2422 [inline]
 slab_free mm/slub.c:4695 [inline]
 kfree+0x18e/0x440 mm/slub.c:4894
 crypto_free_aead include/crypto/aead.h:196 [inline]
 tls_sw_release_resources_tx+0x403/0x4f0 net/tls/tls_sw.c:2550
 tls_sk_proto_cleanup net/tls/tls_main.c:352 [inline]
 tls_sk_proto_close+0x24a/0x8c0 net/tls/tls_main.c:382
 inet_release+0x144/0x190 net/ipv4/af_inet.c:437
 __sock_release net/socket.c:662 [inline]
 sock_close+0xc3/0x240 net/socket.c:1455
 __fput+0x44c/0xa70 fs/file_table.c:468
 task_work_run+0x1d1/0x260 kernel/task_work.c:227
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop+0xe9/0x110 kernel/entry/common.c:43
 exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:175 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:210 [inline]
 do_syscall_64+0x2bd/0x3b0 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff8880558bd800
 which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 8 bytes inside of
 freed 1024-byte region [ffff8880558bd800, ffff8880558bdc00)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff8880558bf800 pfn:0x558b8
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000240(workingset|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000240 ffff88801a041dc0 ffffea000084cc10 ffffea00009f7c10
raw: ffff8880558bf800 000000000010000f 00000000f5000000 0000000000000000
head: 00fff00000000240 ffff88801a041dc0 ffffea000084cc10 ffffea00009f7c10
head: ffff8880558bf800 000000000010000f 00000000f5000000 0000000000000000
head: 00fff00000000003 ffffea0001562e01 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5846, tgid 5846 (syz-executor), ts 78915902371, free_ts 23055932464
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x240/0x2a0 mm/page_alloc.c:1851
 prep_new_page mm/page_alloc.c:1859 [inline]
 get_page_from_freelist+0x21e4/0x22c0 mm/page_alloc.c:3858
 __alloc_frozen_pages_noprof+0x181/0x370 mm/page_alloc.c:5148
 alloc_pages_mpol+0x232/0x4a0 mm/mempolicy.c:2416
 alloc_slab_page mm/slub.c:2492 [inline]
 allocate_slab+0x8a/0x370 mm/slub.c:2660
 new_slab mm/slub.c:2714 [inline]
 ___slab_alloc+0xbeb/0x1420 mm/slub.c:3901
 __slab_alloc mm/slub.c:3992 [inline]
 __slab_alloc_node mm/slub.c:4067 [inline]
 slab_alloc_node mm/slub.c:4228 [inline]
 __do_kmalloc_node mm/slub.c:4375 [inline]
 __kmalloc_noprof+0x305/0x4f0 mm/slub.c:4388
 kmalloc_noprof include/linux/slab.h:909 [inline]
 kzalloc_noprof include/linux/slab.h:1039 [inline]
 __alloc_workqueue+0x108/0x1b80 kernel/workqueue.c:5715
 alloc_workqueue_noprof+0xd4/0x210 kernel/workqueue.c:5818
 wg_newlink+0x246/0x640 drivers/net/wireguard/device.c:341
 rtnl_newlink_create+0x30d/0xb00 net/core/rtnetlink.c:3833
 __rtnl_newlink net/core/rtnetlink.c:3950 [inline]
 rtnl_newlink+0x16e4/0x1c80 net/core/rtnetlink.c:4065
 rtnetlink_rcv_msg+0x7cc/0xb70 net/core/rtnetlink.c:6954
 netlink_rcv_skb+0x205/0x470 net/netlink/af_netlink.c:2552
 netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
 netlink_unicast+0x82c/0x9e0 net/netlink/af_netlink.c:1346
 netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1896
page last free pid 1 tgid 1 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1395 [inline]
 __free_frozen_pages+0xbc4/0xd30 mm/page_alloc.c:2895
 __free_pages mm/page_alloc.c:5260 [inline]
 free_contig_range+0x1bd/0x4a0 mm/page_alloc.c:7091
 destroy_args+0x69/0x660 mm/debug_vm_pgtable.c:958
 debug_vm_pgtable+0x39f/0x3b0 mm/debug_vm_pgtable.c:1345
 do_one_initcall+0x233/0x820 init/main.c:1271
 do_initcall_level+0x104/0x190 init/main.c:1333
 do_initcalls+0x59/0xa0 init/main.c:1349
 kernel_init_freeable+0x334/0x4b0 init/main.c:1581
 kernel_init+0x1d/0x1d0 init/main.c:1471
 ret_from_fork+0x436/0x7d0 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Memory state around the buggy address:
 ffff8880558bd700: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff8880558bd780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff8880558bd800: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                      ^
 ffff8880558bd880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880558bd900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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

