Return-Path: <netdev+bounces-106477-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11AB69168C5
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 15:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 856C81F22EB8
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 13:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4145815A86D;
	Tue, 25 Jun 2024 13:25:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE5B158A29
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 13:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719321926; cv=none; b=eTWuvbdEdYYJYGaIR0ABOi1nLfoB7gFljq89QrlkfpSsdBwU+BqqBCVsGnxQ5ERlqyp2X4qiCbeCyIfQmeyQa2yP05M7y4uKd4HbF+G9j6YiJhWJegBqhKLseD+scYBT1zDGtxjbCJi4TRNEGDA2tYAavphWxLnt4cPc90gX4Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719321926; c=relaxed/simple;
	bh=6U31whSuSJnNotDep7x1dHncHScJnE1OHUw1sMIfvFk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=it8Zor0wzjGI1oDAmAGdeQBV6h2jIlVLuKQC8bycLL5kXvIyxFRzlP+0j09Ufee0zAfnA8y9EIOFKxv8n09v7+MLsqwE8ye++NFe6JnbXnG0fuEivCX3CVD/Kt2BC17a9sOFrmBLJ0RPuECwwtDFrBGtmIKnEVU7v3mLoIkniRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3737b3ae019so69757005ab.2
        for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 06:25:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719321923; x=1719926723;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3PO1mNNvBhxo2oetMWuNrRwE1k8E6jctD2xZFzjZ+Rc=;
        b=hQ/0lvOYnRuARQbEk8f8XtqfisicWqxnL937gWlBLYFRA7+mgfaAZpom1D3BSXM84D
         tzu5a9mZntcn4Ok+8YiEPkuAZB/+XvhTC4PSOghkHtzVc4ZWEmNkMSFS5qs4FkylghxY
         IGUA5ddVK6tN1HNBlwtkrVKZow4PO6jJOsS+LMINGQjdkfm3ZkdYOZAsD9I2bnqx5oWZ
         Ws+kYg3M9bWyMQquoAhy2dQMAvsLNQ3WS1vYvrjkkHvr8KwZKmVRZxMtPaw9SmCzoct8
         fQfrISrgHcLzg7pRglxja0GRbKJzP9t6GA5hBSQrkv5AJJS9wlm01NlVfXi7ygxlgekm
         SF1g==
X-Forwarded-Encrypted: i=1; AJvYcCVHvs7cMaU1YgaNN7R0UTXC1+ut/AXEqdplpLFbOqyjgzo0UoPQXp5uLgoii37I/RP3lJVDFBx+0JGBmciYk5jeG3Hv29Xb
X-Gm-Message-State: AOJu0YwFTLefuS8Q8q7hx6MOL5qRvx3kKTHIfX9OhXmFmn57m1dtaFIv
	QkG2mTxy6kKY+xmIsCJS0Iv+810VokydHDC5YlGCw6wl8Ms5GhT2zQPNJFNVV7CG0HW2/6DMMjH
	VazMwjRuwZt44pNOBIW95RGCUHOvZc1JYS2nX5Lgbw/lbrrk/J1Z8UHo=
X-Google-Smtp-Source: AGHT+IEgQiw7DW7e2hqSRAYroUC+zNpnPUxD1/VLypoWm6U2+BSmKjUA0TaqMB4kSwsPcGBX0mPHfMSn1qq+AwEUpcZYfTonTkpP
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1988:b0:376:4441:9 with SMTP id
 e9e14a558f8ab-376444101f9mr6761055ab.2.1719321923678; Tue, 25 Jun 2024
 06:25:23 -0700 (PDT)
Date: Tue, 25 Jun 2024 06:25:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008405e0061bb6d4d5@google.com>
Subject: [syzbot] [net?] KASAN: slab-use-after-free Write in l2tp_session_delete
From: syzbot <syzbot+c041b4ce3a6dfd1e63e2@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    185d72112b95 net: xilinx: axienet: Enable multicast by def..
git tree:       net-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=129911fa980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e78fc116033e0ab7
dashboard link: https://syzkaller.appspot.com/bug?extid=c041b4ce3a6dfd1e63e2
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12521b9c980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1062bd46980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e84f50e44254/disk-185d7211.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/df64b575cc01/vmlinux-185d7211.xz
kernel image: https://storage.googleapis.com/syzbot-assets/16ad5d1d433b/bzImage-185d7211.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c041b4ce3a6dfd1e63e2@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
BUG: KASAN: slab-use-after-free in test_and_set_bit include/asm-generic/bitops/instrumented-atomic.h:71 [inline]
BUG: KASAN: slab-use-after-free in l2tp_session_delete+0x28/0x9e0 net/l2tp/l2tp_core.c:1639
Write of size 8 at addr ffff88802aaf5808 by task kworker/u8:11/2523

CPU: 0 PID: 2523 Comm: kworker/u8:11 Not tainted 6.10.0-rc4-syzkaller-00869-g185d72112b95 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
Workqueue: l2tp l2tp_tunnel_del_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 kasan_check_range+0x282/0x290 mm/kasan/generic.c:189
 instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
 test_and_set_bit include/asm-generic/bitops/instrumented-atomic.h:71 [inline]
 l2tp_session_delete+0x28/0x9e0 net/l2tp/l2tp_core.c:1639
 l2tp_tunnel_closeall net/l2tp/l2tp_core.c:1302 [inline]
 l2tp_tunnel_del_work+0x1cb/0x330 net/l2tp/l2tp_core.c:1334
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3393
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Allocated by task 5107:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:387
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 __do_kmalloc_node mm/slub.c:4122 [inline]
 __kmalloc_noprof+0x1f9/0x400 mm/slub.c:4135
 kmalloc_noprof include/linux/slab.h:664 [inline]
 kzalloc_noprof include/linux/slab.h:778 [inline]
 l2tp_session_create+0x3b/0xc20 net/l2tp/l2tp_core.c:1675
 pppol2tp_connect+0xca3/0x17a0 net/l2tp/l2tp_ppp.c:782
 __sys_connect_file net/socket.c:2049 [inline]
 __sys_connect+0x2df/0x310 net/socket.c:2066
 __do_sys_connect net/socket.c:2076 [inline]
 __se_sys_connect net/socket.c:2073 [inline]
 __x64_sys_connect+0x7a/0x90 net/socket.c:2073
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 16:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
 poison_slab_object+0xe0/0x150 mm/kasan/common.c:240
 __kasan_slab_free+0x37/0x60 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2196 [inline]
 slab_free mm/slub.c:4437 [inline]
 kfree+0x149/0x360 mm/slub.c:4558
 __sk_destruct+0x58/0x5f0 net/core/sock.c:2191
 rcu_do_batch kernel/rcu/tree.c:2535 [inline]
 rcu_core+0xafd/0x1830 kernel/rcu/tree.c:2809
 handle_softirqs+0x2c4/0x970 kernel/softirq.c:554
 run_ksoftirqd+0xca/0x130 kernel/softirq.c:928
 smpboot_thread_fn+0x544/0xa30 kernel/smpboot.c:164
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Last potentially related work creation:
 kasan_save_stack+0x3f/0x60 mm/kasan/common.c:47
 __kasan_record_aux_stack+0xac/0xc0 mm/kasan/generic.c:541
 __call_rcu_common kernel/rcu/tree.c:3072 [inline]
 call_rcu+0x167/0xa70 kernel/rcu/tree.c:3176
 pppol2tp_release+0x24b/0x350 net/l2tp/l2tp_ppp.c:457
 __sock_release net/socket.c:659 [inline]
 sock_close+0xbc/0x240 net/socket.c:1421
 __fput+0x406/0x8b0 fs/file_table.c:422
 task_work_run+0x24f/0x310 kernel/task_work.c:180
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0xa27/0x27e0 kernel/exit.c:874
 do_group_exit+0x207/0x2c0 kernel/exit.c:1023
 get_signal+0x16a1/0x1740 kernel/signal.c:2909
 arch_do_signal_or_restart+0x96/0x860 arch/x86/kernel/signal.c:310
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0xc9/0x370 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88802aaf5800
 which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 8 bytes inside of
 freed 1024-byte region [ffff88802aaf5800, ffff88802aaf5c00)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x2aaf0
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
anon flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffefff(slab)
raw: 00fff00000000040 ffff888015041dc0 0000000000000000 dead000000000001
raw: 0000000000000000 0000000000100010 00000001ffffefff 0000000000000000
head: 00fff00000000040 ffff888015041dc0 0000000000000000 dead000000000001
head: 0000000000000000 0000000000100010 00000001ffffefff 0000000000000000
head: 00fff00000000003 ffffea0000aabc01 ffffffffffffffff 0000000000000000
head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 1, tgid 1 (swapper/0), ts 11074988535, free_ts 0
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1468
 prep_new_page mm/page_alloc.c:1476 [inline]
 get_page_from_freelist+0x2e43/0x2f00 mm/page_alloc.c:3420
 __alloc_pages_noprof+0x256/0x6c0 mm/page_alloc.c:4678
 __alloc_pages_node_noprof include/linux/gfp.h:269 [inline]
 alloc_pages_node_noprof include/linux/gfp.h:296 [inline]
 alloc_slab_page+0x5f/0x120 mm/slub.c:2265
 allocate_slab+0x5a/0x2f0 mm/slub.c:2428
 new_slab mm/slub.c:2481 [inline]
 ___slab_alloc+0xcd1/0x14b0 mm/slub.c:3667
 __slab_alloc+0x58/0xa0 mm/slub.c:3757
 __slab_alloc_node mm/slub.c:3810 [inline]
 slab_alloc_node mm/slub.c:3989 [inline]
 __do_kmalloc_node mm/slub.c:4121 [inline]
 __kmalloc_noprof+0x257/0x400 mm/slub.c:4135
 kmalloc_noprof include/linux/slab.h:664 [inline]
 kzalloc_noprof include/linux/slab.h:778 [inline]
 alloc_workqueue+0x1b0/0x2060 kernel/workqueue.c:5667
 tipc_topsrv_work_start net/tipc/topsrv.c:635 [inline]
 tipc_topsrv_start net/tipc/topsrv.c:679 [inline]
 tipc_topsrv_init_net+0x303/0x9d0 net/tipc/topsrv.c:725
 ops_init+0x359/0x610 net/core/net_namespace.c:139
 __register_pernet_operations net/core/net_namespace.c:1252 [inline]
 register_pernet_operations+0x2cb/0x660 net/core/net_namespace.c:1325
 register_pernet_device+0x33/0x80 net/core/net_namespace.c:1412
 tipc_init+0x8d/0x190 net/tipc/core.c:168
 do_one_initcall+0x248/0x880 init/main.c:1267
 do_initcall_level+0x157/0x210 init/main.c:1329
page_owner free stack trace missing

Memory state around the buggy address:
 ffff88802aaf5700: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88802aaf5780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88802aaf5800: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                      ^
 ffff88802aaf5880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88802aaf5900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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

