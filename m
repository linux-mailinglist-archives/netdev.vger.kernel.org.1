Return-Path: <netdev+bounces-124542-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8081969EC7
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 15:13:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0837282A9A
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 13:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7BE21A7252;
	Tue,  3 Sep 2024 13:13:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BEBC1A7241
	for <netdev@vger.kernel.org>; Tue,  3 Sep 2024 13:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725369209; cv=none; b=SrEcOcId51q0WaiWbcNu6nfgFMhSAwG1jSj49rX8utFl2Nzxmq0LIOtGfrtF+lppERFRwzUS8TaP5TDUe1zXcY3HYffLI0dwf1sPqWQAwgtvDnf+fY0wKmRP3TsNaF7w9cGUg+QHoN9e45o6mXBn7dWOe3g+Zs18pyPLDCmJ7ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725369209; c=relaxed/simple;
	bh=Zpc+3nFvZNhC8+ppISj1MxWrUoORCFZOEitUinuAibo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=NL9k4RvGoLVNx4aI/tN0gMaBM+FoXRGqZP4Op5vwRtLJ+P9VKaJ+NWMQ5DbvVGv1/BUKet0d7GdhdHazKo60E3+aYe5N05ALMdUjiQFyMJyb8Bhse1WS9AAOnV0pmSVKbU8kzP2zXYve8sQwmcMv06xnHb1ZApyab0TZQI5SI8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-82a319f6520so419075739f.3
        for <netdev@vger.kernel.org>; Tue, 03 Sep 2024 06:13:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725369207; x=1725974007;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DWLKCsbL3e9ye7e/BGChwX2ntWvvyq3BpFhFp9Uw6Gk=;
        b=fcMdL2vHfIPyIt3G1YaR1q/pd17cb4Vuss15d67EyYGrQltGvbs5jnQ6tR6KsoZ7Ar
         Ilv3OgQOT9KRoTLh5ULyOmcgWM1u10pHazusDxRfsrfMGR0EBNg+p34YGuFLuV8p8LST
         vENjoZZ2OFcI9TPS/SYuaQTB5HPsfLJ7TEV4gtDnWYJKNc8nrmhTtjX1K8ZOc8xbO8oP
         L6FiKrOFlvSjWcbMybWUfkv7Ulap4qTvOB1FmxQLBeqvdOjx3TNktCX4CKjC382sDjnL
         hLMMu454pBbBysCg3KMma957dLqxrSowPvn6ZIixR5+6mhxip0kRo4zhR1CWeuSyT9DV
         M7tw==
X-Forwarded-Encrypted: i=1; AJvYcCVcNt4Y90u7zvdKfYxI2RmNNtz7FFjeY0HFQ84VjEzmiFM4/HLpwjYeJKXmKeUZmrIHMwxAFrw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyE3Q+ITh4FmgkU1FsHJk4qpw1kqOri6uHIX69xrRSZij/+QELY
	/NN3EOqO0RGc1ycnMf2bgPmHWmuZJsK5oLtR6ed+wEbATHqEbnk75l1v004Kb+7vJvgb2SuR2EW
	x3bIjENRiKW8I5VZPndxm+VXnjrN/1Jc8ByHy4j+NG9hiqqmjzFk84nU=
X-Google-Smtp-Source: AGHT+IEcozEOClZZgaqpFVIU7UQk9cgYqOi5JsqNkUCDP560FdwHWgwgyJkk8D/9zMCxE6n/FnruByfAH5plOP1sLzN59p6MrDRa
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8624:b0:4c0:a8a5:81f5 with SMTP id
 8926c6da1cb9f-4d017e9b260mr767715173.4.1725369207171; Tue, 03 Sep 2024
 06:13:27 -0700 (PDT)
Date: Tue, 03 Sep 2024 06:13:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b341bb062136d2d9@google.com>
Subject: [syzbot] [mptcp?] KASAN: slab-use-after-free Read in __timer_delete_sync
From: syzbot <syzbot+f3a31fb909db9b2a5c4d@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, geliang@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, martineau@kernel.org, 
	matttbe@kernel.org, mptcp@lists.linux.dev, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    1934261d8974 Merge tag 'input-for-v6.11-rc5' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=146be1db980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=996585887acdadb3
dashboard link: https://syzkaller.appspot.com/bug?extid=f3a31fb909db9b2a5c4d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11229d09980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d02c28e8dbf3/disk-1934261d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/464d0e233034/vmlinux-1934261d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8735d78fb16a/bzImage-1934261d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f3a31fb909db9b2a5c4d@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in lock_release+0x151/0xa30 kernel/locking/lockdep.c:5772
Read of size 8 at addr ffff888076a77758 by task kworker/0:0/8

CPU: 0 UID: 0 PID: 8 Comm: kworker/0:0 Not tainted 6.11.0-rc5-syzkaller-00219-g1934261d8974 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Workqueue: events mptcp_worker
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 lock_release+0x151/0xa30 kernel/locking/lockdep.c:5772
 __timer_delete_sync+0x157/0x310 kernel/time/timer.c:1648
 del_timer_sync include/linux/timer.h:185 [inline]
 sk_stop_timer_sync+0x1c/0x90 net/core/sock.c:3454
 mptcp_pm_del_add_timer+0x18d/0x250 net/mptcp/pm_netlink.c:345
 mptcp_incoming_options+0x158d/0x2570 net/mptcp/options.c:1166
 tcp_data_queue+0xf5/0x76c0 net/ipv4/tcp_input.c:5206
 tcp_rcv_established+0xfba/0x2020 net/ipv4/tcp_input.c:6230
 tcp_v4_do_rcv+0x96d/0xc70 net/ipv4/tcp_ipv4.c:1911
 tcp_v4_rcv+0x2dc0/0x37f0 net/ipv4/tcp_ipv4.c:2346
 ip_protocol_deliver_rcu+0x22e/0x440 net/ipv4/ip_input.c:205
 ip_local_deliver_finish+0x341/0x5f0 net/ipv4/ip_input.c:233
 NF_HOOK+0x3a4/0x450 include/linux/netfilter.h:314
 NF_HOOK+0x3a4/0x450 include/linux/netfilter.h:314
 __netif_receive_skb_one_core net/core/dev.c:5661 [inline]
 __netif_receive_skb+0x2bf/0x650 net/core/dev.c:5775
 process_backlog+0x662/0x15b0 net/core/dev.c:6108
 __napi_poll+0xcb/0x490 net/core/dev.c:6772
 napi_poll net/core/dev.c:6841 [inline]
 net_rx_action+0x89b/0x1240 net/core/dev.c:6963
 handle_softirqs+0x2c4/0x970 kernel/softirq.c:554
 do_softirq+0x11b/0x1e0 kernel/softirq.c:455
 </IRQ>
 <TASK>
 __local_bh_enable_ip+0x1bb/0x200 kernel/softirq.c:382
 mptcp_pm_send_ack net/mptcp/pm_netlink.c:496 [inline]
 mptcp_pm_nl_addr_send_ack+0x3ec/0x4e0 net/mptcp/pm_netlink.c:785
 mptcp_pm_nl_work+0x18e8/0x1fc0 net/mptcp/pm_netlink.c:924
 mptcp_worker+0x12f/0x1440 net/mptcp/protocol.c:2759
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
 worker_thread+0x86d/0xd10 kernel/workqueue.c:3389
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Allocated by task 5379:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:387
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 __kmalloc_cache_noprof+0x19c/0x2c0 mm/slub.c:4189
 kmalloc_noprof include/linux/slab.h:681 [inline]
 mptcp_pm_alloc_anno_list+0x14e/0x390 net/mptcp/pm_netlink.c:370
 mptcp_pm_create_subflow_or_signal_addr+0x1920/0x22c0 net/mptcp/pm_netlink.c:586
 mptcp_nl_add_subflow_or_signal_addr net/mptcp/pm_netlink.c:1356 [inline]
 mptcp_pm_nl_add_addr_doit+0x1276/0x1b80 net/mptcp/pm_netlink.c:1428
 genl_family_rcv_msg_doit net/netlink/genetlink.c:1115 [inline]
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0xb14/0xec0 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2550
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
 netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1357
 netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1901
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:745
 ____sys_sendmsg+0x525/0x7d0 net/socket.c:2597
 ___sys_sendmsg net/socket.c:2651 [inline]
 __sys_sendmsg+0x2b0/0x3a0 net/socket.c:2680
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 5379:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
 poison_slab_object+0xe0/0x150 mm/kasan/common.c:240
 __kasan_slab_free+0x37/0x60 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2252 [inline]
 slab_free mm/slub.c:4473 [inline]
 kfree+0x149/0x360 mm/slub.c:4594
 remove_anno_list_by_saddr+0x156/0x190 net/mptcp/pm_netlink.c:1466
 mptcp_pm_remove_addrs_and_subflows net/mptcp/pm_netlink.c:1687 [inline]
 mptcp_nl_remove_addrs_list net/mptcp/pm_netlink.c:1718 [inline]
 mptcp_pm_nl_flush_addrs_doit+0x664/0xd60 net/mptcp/pm_netlink.c:1759
 genl_family_rcv_msg_doit net/netlink/genetlink.c:1115 [inline]
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0xb14/0xec0 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2550
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
 netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1357
 netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1901
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:745
 ____sys_sendmsg+0x525/0x7d0 net/socket.c:2597
 ___sys_sendmsg net/socket.c:2651 [inline]
 __sys_sendmsg+0x2b0/0x3a0 net/socket.c:2680
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888076a77700
 which belongs to the cache kmalloc-192 of size 192
The buggy address is located 88 bytes inside of
 freed 192-byte region [ffff888076a77700, ffff888076a777c0)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x76a77
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xfdffffff(slab)
raw: 00fff00000000000 ffff88801ac413c0 dead000000000122 0000000000000000
raw: 0000000000000000 0000000080100010 00000001fdffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x352800(GFP_NOWAIT|__GFP_NORETRY|__GFP_COMP|__GFP_HARDWALL|__GFP_THISNODE), pid 5373, tgid 5372 (syz.0.20), ts 69219069347, free_ts 69201611728
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1493
 prep_new_page mm/page_alloc.c:1501 [inline]
 get_page_from_freelist+0x2e4c/0x2f10 mm/page_alloc.c:3439
 __alloc_pages_noprof+0x256/0x6c0 mm/page_alloc.c:4695
 __alloc_pages_node_noprof include/linux/gfp.h:269 [inline]
 alloc_pages_node_noprof include/linux/gfp.h:296 [inline]
 alloc_slab_page+0x5f/0x120 mm/slub.c:2321
 allocate_slab+0x5a/0x2f0 mm/slub.c:2484
 new_slab mm/slub.c:2537 [inline]
 ___slab_alloc+0xcd1/0x14b0 mm/slub.c:3723
 __slab_alloc+0x58/0xa0 mm/slub.c:3813
 __slab_alloc_node mm/slub.c:3866 [inline]
 slab_alloc_node mm/slub.c:4025 [inline]
 __do_kmalloc_node mm/slub.c:4157 [inline]
 __kmalloc_node_noprof+0x286/0x440 mm/slub.c:4164
 kmalloc_array_node_noprof include/linux/slab.h:788 [inline]
 alloc_slab_obj_exts mm/slub.c:1976 [inline]
 account_slab mm/slub.c:2447 [inline]
 allocate_slab+0xb6/0x2f0 mm/slub.c:2502
 new_slab mm/slub.c:2537 [inline]
 ___slab_alloc+0xcd1/0x14b0 mm/slub.c:3723
 __slab_alloc+0x58/0xa0 mm/slub.c:3813
 __slab_alloc_node mm/slub.c:3866 [inline]
 slab_alloc_node mm/slub.c:4025 [inline]
 kmem_cache_alloc_noprof+0x1c1/0x2a0 mm/slub.c:4044
 reqsk_alloc_noprof net/ipv4/inet_connection_sock.c:920 [inline]
 inet_reqsk_alloc+0xa8/0x800 net/ipv4/inet_connection_sock.c:951
 tcp_conn_request+0x252/0x34a0 net/ipv4/tcp_input.c:7179
 tcp_rcv_state_process+0x1bd7/0x4570 net/ipv4/tcp_input.c:6716
 tcp_v4_do_rcv+0x77d/0xc70 net/ipv4/tcp_ipv4.c:1934
page last free pid 5372 tgid 5372 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1094 [inline]
 free_unref_page+0xd22/0xea0 mm/page_alloc.c:2612
 __slab_free+0x31b/0x3d0 mm/slub.c:4384
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x9e/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x14f/0x170 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x23/0x80 mm/kasan/common.c:322
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3988 [inline]
 slab_alloc_node mm/slub.c:4037 [inline]
 __do_kmalloc_node mm/slub.c:4157 [inline]
 __kmalloc_noprof+0x1a6/0x400 mm/slub.c:4170
 kmalloc_noprof include/linux/slab.h:685 [inline]
 kzalloc_noprof include/linux/slab.h:807 [inline]
 tomoyo_encode2 security/tomoyo/realpath.c:45 [inline]
 tomoyo_encode+0x26f/0x540 security/tomoyo/realpath.c:80
 tomoyo_path_perm+0x3ca/0x740 security/tomoyo/file.c:831
 tomoyo_path_symlink+0xde/0x120 security/tomoyo/tomoyo.c:212
 security_path_symlink+0xe3/0x140 security/security.c:1876
 do_symlinkat+0x136/0x3a0 fs/namei.c:4592
 __do_sys_symlinkat fs/namei.c:4610 [inline]
 __se_sys_symlinkat fs/namei.c:4607 [inline]
 __x64_sys_symlinkat+0x95/0xb0 fs/namei.c:4607
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff888076a77600: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888076a77680: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
>ffff888076a77700: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                    ^
 ffff888076a77780: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
 ffff888076a77800: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
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

