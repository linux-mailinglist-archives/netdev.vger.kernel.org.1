Return-Path: <netdev+bounces-135293-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB8B99D792
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 21:38:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E172B1C2271E
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 19:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD6D1CC168;
	Mon, 14 Oct 2024 19:38:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D57B3A1B6
	for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 19:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728934714; cv=none; b=GvbkZ0/me2DkiVffEgxR47QACIWHiMVR6SRfzQGi+Cx8RRVpRMKhJhpVcBT4G/Ena1BpHgztYVjXK/mJi3/nDlcfj3Ur/x9KkFwc5v+/rfLeN8W8sadacA/4XumaWqfh8DbiqhEl2WCEs2BpmmPnXjqUCk/bUXoMpvVID5swclw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728934714; c=relaxed/simple;
	bh=0WQF7lisMpeQoZ6Vzt20eNEXwYlvyd0XXwW36bK6458=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Jj15suaizRzYqGA+Nc4dBOnknulB7ajZzNps2/TXZ3TJ/OnH0b0ox+VwMv1fzuVWDAfWOzM5ofSZaxn0M1gKrtAq3b9ET3A5cM9tmrT58mbRLx5sWbXx6gzcLRp9fXgvFweOUcuZx2dJD3CqKZxK4NAiA9NYjGmVbqoelCgsvd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a3466d220dso44533285ab.3
        for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 12:38:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728934711; x=1729539511;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QRMDhsZaxmGq8pjOwXYAE71BATwJ2LteU/iuCYeFH5A=;
        b=aFJGsquxEhA2hUkHPJmaZ2mq1u9FrDMO7tNOUVyJJYwBiOuPXZ8PDeusct7NAMXHqh
         Wc/kIp8bDTKMdtOAaO1ArQ8EP9eotyDFe+Yid09Isiwe14KdZN9B48ko6D8mA03BV867
         W7MdjINa3cPUv1l24KJ2LI+Eovzx8pjfV6/xcyjQzo5k6mu6lbVpqJv7rLNQXANEArnu
         gw3uAY/ea66N7S/0BLrhleNPb7ZBvWHLlZB0yKXGxalpxFeYAU7ovbTDB7AUQQpITa6V
         2vAu5QkdBk/ngZX2tgkRKKpyDY7kG+1gFpp/YJYaMABBKvoMycnDT62ImHl7L30SSvZc
         7lIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFEPlpCZ19+ty2B/SwWopeWDTDjDgO1hjB/J6DvxZavbX9fK4nsd21h8djGHKFt9BOD6yCh4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgA2zJ85mXx8YzBKiB2KabBM8rWicOvoHgwdIDHNOMkkznC/d6
	doHlUHBiAJyGyvOYog2+vY6hgPj5Mj+tMPBjZH6dp6zVfRfjIgkJHJbBZ20eABiNlISBor1QzNP
	5ahYTwpzzHlkRWDrL3wNJaHssosLqSTCioy6UpgccdRx5EOcYA1vv3pQ=
X-Google-Smtp-Source: AGHT+IExGDDXrGa9w84iUxruMsqt6v7Gh7hUudajp1YFSVs5PI5FTeXqMAy2vDvwJ1xdKYAWen3X5WJPf/Xo7PgOF4/9YGvhIrkp
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a6d:b0:3a3:a3a9:c1ae with SMTP id
 e9e14a558f8ab-3a3b6020fbcmr94640155ab.20.1728934711400; Mon, 14 Oct 2024
 12:38:31 -0700 (PDT)
Date: Mon, 14 Oct 2024 12:38:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <670d7337.050a0220.4cbc0.004f.GAE@google.com>
Subject: [syzbot] [mptcp?] KASAN: slab-use-after-free Read in mptcp_pm_nl_rm_addr_or_subflow
From: syzbot <syzbot+3c8b7a8e7df6a2a226ca@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, geliang@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, martineau@kernel.org, 
	matttbe@kernel.org, mptcp@lists.linux.dev, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    36c254515dc6 Merge tag 'powerpc-6.12-4' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11831440580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=667b897270c8ae6
dashboard link: https://syzkaller.appspot.com/bug?extid=3c8b7a8e7df6a2a226ca
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-36c25451.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0a357f9d2448/vmlinux-36c25451.xz
kernel image: https://storage.googleapis.com/syzbot-assets/fba8311d450b/bzImage-36c25451.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3c8b7a8e7df6a2a226ca@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in mptcp_pm_nl_rm_addr_or_subflow+0xb44/0xcc0 net/mptcp/pm_netlink.c:881
Read of size 4 at addr ffff8880569ac858 by task syz.1.2799/14662

CPU: 0 UID: 0 PID: 14662 Comm: syz.1.2799 Not tainted 6.12.0-rc2-syzkaller-00307-g36c254515dc6 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0xc3/0x620 mm/kasan/report.c:488
 kasan_report+0xd9/0x110 mm/kasan/report.c:601
 mptcp_pm_nl_rm_addr_or_subflow+0xb44/0xcc0 net/mptcp/pm_netlink.c:881
 mptcp_pm_nl_rm_subflow_received net/mptcp/pm_netlink.c:914 [inline]
 mptcp_nl_remove_id_zero_address+0x305/0x4a0 net/mptcp/pm_netlink.c:1572
 mptcp_pm_nl_del_addr_doit+0x5c9/0x770 net/mptcp/pm_netlink.c:1603
 genl_family_rcv_msg_doit+0x202/0x2f0 net/netlink/genetlink.c:1115
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0x565/0x800 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x165/0x410 net/netlink/af_netlink.c:2551
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
 netlink_unicast+0x53c/0x7f0 net/netlink/af_netlink.c:1357
 netlink_sendmsg+0x8b8/0xd70 net/netlink/af_netlink.c:1901
 sock_sendmsg_nosec net/socket.c:729 [inline]
 __sock_sendmsg net/socket.c:744 [inline]
 ____sys_sendmsg+0x9ae/0xb40 net/socket.c:2607
 ___sys_sendmsg+0x135/0x1e0 net/socket.c:2661
 __sys_sendmsg+0x117/0x1f0 net/socket.c:2690
 do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
 __do_fast_syscall_32+0x73/0x120 arch/x86/entry/common.c:386
 do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e
RIP: 0023:0xf7fe4579
Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000f574556c EFLAGS: 00000296 ORIG_RAX: 0000000000000172
RAX: ffffffffffffffda RBX: 000000000000000b RCX: 0000000020000140
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000296 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>

Allocated by task 5387:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:394
 kmalloc_noprof include/linux/slab.h:878 [inline]
 kzalloc_noprof include/linux/slab.h:1014 [inline]
 subflow_create_ctx+0x87/0x2a0 net/mptcp/subflow.c:1803
 subflow_ulp_init+0xc3/0x4d0 net/mptcp/subflow.c:1956
 __tcp_set_ulp net/ipv4/tcp_ulp.c:146 [inline]
 tcp_set_ulp+0x326/0x7f0 net/ipv4/tcp_ulp.c:167
 mptcp_subflow_create_socket+0x4ae/0x10a0 net/mptcp/subflow.c:1764
 __mptcp_subflow_connect+0x3cc/0x1490 net/mptcp/subflow.c:1592
 mptcp_pm_create_subflow_or_signal_addr+0xbda/0x23a0 net/mptcp/pm_netlink.c:642
 mptcp_pm_nl_fully_established net/mptcp/pm_netlink.c:650 [inline]
 mptcp_pm_nl_work+0x3a1/0x4f0 net/mptcp/pm_netlink.c:943
 mptcp_worker+0x15a/0x1240 net/mptcp/protocol.c:2777
 process_one_work+0x958/0x1b30 kernel/workqueue.c:3229
 process_scheduled_works kernel/workqueue.c:3310 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Freed by task 113:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:579
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x51/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:230 [inline]
 slab_free_hook mm/slub.c:2342 [inline]
 slab_free mm/slub.c:4579 [inline]
 kfree+0x14f/0x4b0 mm/slub.c:4727
 kvfree+0x47/0x50 mm/util.c:701
 kvfree_rcu_list+0xf5/0x2c0 kernel/rcu/tree.c:3423
 kvfree_rcu_drain_ready kernel/rcu/tree.c:3563 [inline]
 kfree_rcu_monitor+0x503/0x8b0 kernel/rcu/tree.c:3632
 kfree_rcu_shrink_scan+0x245/0x3a0 kernel/rcu/tree.c:3966
 do_shrink_slab+0x44f/0x11c0 mm/shrinker.c:435
 shrink_slab+0x32b/0x12a0 mm/shrinker.c:662
 shrink_one+0x47e/0x7b0 mm/vmscan.c:4818
 shrink_many mm/vmscan.c:4879 [inline]
 lru_gen_shrink_node mm/vmscan.c:4957 [inline]
 shrink_node+0x2452/0x39d0 mm/vmscan.c:5937
 kswapd_shrink_node mm/vmscan.c:6765 [inline]
 balance_pgdat+0xc19/0x18f0 mm/vmscan.c:6957
 kswapd+0x5ea/0xbf0 mm/vmscan.c:7226
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Last potentially related work creation:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 __kasan_record_aux_stack+0xba/0xd0 mm/kasan/generic.c:541
 kvfree_call_rcu+0x74/0xbe0 kernel/rcu/tree.c:3810
 subflow_ulp_release+0x2ae/0x350 net/mptcp/subflow.c:2009
 tcp_cleanup_ulp+0x7c/0x130 net/ipv4/tcp_ulp.c:124
 tcp_v4_destroy_sock+0x1c5/0x6a0 net/ipv4/tcp_ipv4.c:2541
 inet_csk_destroy_sock+0x1a3/0x440 net/ipv4/inet_connection_sock.c:1293
 tcp_done+0x252/0x350 net/ipv4/tcp.c:4870
 tcp_rcv_state_process+0x379b/0x4f30 net/ipv4/tcp_input.c:6933
 tcp_v4_do_rcv+0x1ad/0xa90 net/ipv4/tcp_ipv4.c:1938
 sk_backlog_rcv include/net/sock.h:1115 [inline]
 __release_sock+0x31b/0x400 net/core/sock.c:3072
 __tcp_close+0x4f3/0xff0 net/ipv4/tcp.c:3142
 __mptcp_close_ssk+0x331/0x14d0 net/mptcp/protocol.c:2489
 mptcp_close_ssk net/mptcp/protocol.c:2543 [inline]
 mptcp_close_ssk+0x150/0x220 net/mptcp/protocol.c:2526
 mptcp_pm_nl_rm_addr_or_subflow+0x2be/0xcc0 net/mptcp/pm_netlink.c:878
 mptcp_pm_nl_rm_subflow_received net/mptcp/pm_netlink.c:914 [inline]
 mptcp_nl_remove_id_zero_address+0x305/0x4a0 net/mptcp/pm_netlink.c:1572
 mptcp_pm_nl_del_addr_doit+0x5c9/0x770 net/mptcp/pm_netlink.c:1603
 genl_family_rcv_msg_doit+0x202/0x2f0 net/netlink/genetlink.c:1115
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0x565/0x800 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x165/0x410 net/netlink/af_netlink.c:2551
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
 netlink_unicast+0x53c/0x7f0 net/netlink/af_netlink.c:1357
 netlink_sendmsg+0x8b8/0xd70 net/netlink/af_netlink.c:1901
 sock_sendmsg_nosec net/socket.c:729 [inline]
 __sock_sendmsg net/socket.c:744 [inline]
 ____sys_sendmsg+0x9ae/0xb40 net/socket.c:2607
 ___sys_sendmsg+0x135/0x1e0 net/socket.c:2661
 __sys_sendmsg+0x117/0x1f0 net/socket.c:2690
 do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
 __do_fast_syscall_32+0x73/0x120 arch/x86/entry/common.c:386
 do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e

The buggy address belongs to the object at ffff8880569ac800
 which belongs to the cache kmalloc-512 of size 512
The buggy address is located 88 bytes inside of
 freed 512-byte region [ffff8880569ac800, ffff8880569aca00)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x569ac
head: order:2 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0x4fff00000000040(head|node=1|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 04fff00000000040 ffff88801ac42c80 dead000000000100 dead000000000122
raw: 0000000000000000 0000000080100010 00000001f5000000 0000000000000000
head: 04fff00000000040 ffff88801ac42c80 dead000000000100 dead000000000122
head: 0000000000000000 0000000080100010 00000001f5000000 0000000000000000
head: 04fff00000000002 ffffea00015a6b01 ffffffffffffffff 0000000000000000
head: 0000000000000004 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 2, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 10238, tgid 10238 (kworker/u32:6), ts 597403252405, free_ts 597177952947
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x2d1/0x350 mm/page_alloc.c:1537
 prep_new_page mm/page_alloc.c:1545 [inline]
 get_page_from_freelist+0x101e/0x3070 mm/page_alloc.c:3457
 __alloc_pages_noprof+0x223/0x25a0 mm/page_alloc.c:4733
 alloc_pages_mpol_noprof+0x2c9/0x610 mm/mempolicy.c:2265
 alloc_slab_page mm/slub.c:2412 [inline]
 allocate_slab mm/slub.c:2578 [inline]
 new_slab+0x2ba/0x3f0 mm/slub.c:2631
 ___slab_alloc+0xd1d/0x16f0 mm/slub.c:3818
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3908
 __slab_alloc_node mm/slub.c:3961 [inline]
 slab_alloc_node mm/slub.c:4122 [inline]
 __kmalloc_cache_noprof+0x2c5/0x310 mm/slub.c:4290
 kmalloc_noprof include/linux/slab.h:878 [inline]
 kzalloc_noprof include/linux/slab.h:1014 [inline]
 mld_add_delrec net/ipv6/mcast.c:743 [inline]
 igmp6_leave_group net/ipv6/mcast.c:2625 [inline]
 igmp6_group_dropped+0x4ab/0xe40 net/ipv6/mcast.c:723
 __ipv6_dev_mc_dec+0x281/0x360 net/ipv6/mcast.c:979
 addrconf_leave_solict net/ipv6/addrconf.c:2253 [inline]
 __ipv6_ifa_notify+0x3f6/0xc30 net/ipv6/addrconf.c:6283
 addrconf_ifdown.isra.0+0xef9/0x1a20 net/ipv6/addrconf.c:3982
 addrconf_notify+0x220/0x19c0 net/ipv6/addrconf.c:3781
 notifier_call_chain+0xb9/0x410 kernel/notifier.c:93
 call_netdevice_notifiers_info+0xbe/0x140 net/core/dev.c:1996
 call_netdevice_notifiers_extack net/core/dev.c:2034 [inline]
 call_netdevice_notifiers net/core/dev.c:2048 [inline]
 dev_close_many+0x333/0x6a0 net/core/dev.c:1589
page last free pid 13136 tgid 13136 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1108 [inline]
 free_unref_page+0x5f4/0xdc0 mm/page_alloc.c:2638
 stack_depot_save_flags+0x2da/0x900 lib/stackdepot.c:666
 kasan_save_stack+0x42/0x60 mm/kasan/common.c:48
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:319 [inline]
 __kasan_slab_alloc+0x89/0x90 mm/kasan/common.c:345
 kasan_slab_alloc include/linux/kasan.h:247 [inline]
 slab_post_alloc_hook mm/slub.c:4085 [inline]
 slab_alloc_node mm/slub.c:4134 [inline]
 kmem_cache_alloc_noprof+0x121/0x2f0 mm/slub.c:4141
 skb_clone+0x190/0x3f0 net/core/skbuff.c:2084
 do_one_broadcast net/netlink/af_netlink.c:1462 [inline]
 netlink_broadcast_filtered+0xb11/0xef0 net/netlink/af_netlink.c:1540
 netlink_broadcast+0x39/0x50 net/netlink/af_netlink.c:1564
 uevent_net_broadcast_untagged lib/kobject_uevent.c:331 [inline]
 kobject_uevent_net_broadcast lib/kobject_uevent.c:410 [inline]
 kobject_uevent_env+0xacd/0x1670 lib/kobject_uevent.c:608
 device_del+0x623/0x9f0 drivers/base/core.c:3882
 snd_card_disconnect.part.0+0x58a/0x7c0 sound/core/init.c:546
 snd_card_disconnect+0x1f/0x30 sound/core/init.c:495
 snd_usx2y_disconnect+0xe9/0x1f0 sound/usb/usx2y/usbusx2y.c:417
 usb_unbind_interface+0x1e8/0x970 drivers/usb/core/driver.c:461
 device_remove drivers/base/dd.c:569 [inline]
 device_remove+0x122/0x170 drivers/base/dd.c:561

Memory state around the buggy address:
 ffff8880569ac700: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff8880569ac780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff8880569ac800: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                    ^
 ffff8880569ac880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880569ac900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================
----------------
Code disassembly (best guess), 2 bytes skipped:
   0:	10 06                	adc    %al,(%rsi)
   2:	03 74 b4 01          	add    0x1(%rsp,%rsi,4),%esi
   6:	10 07                	adc    %al,(%rdi)
   8:	03 74 b0 01          	add    0x1(%rax,%rsi,4),%esi
   c:	10 08                	adc    %cl,(%rax)
   e:	03 74 d8 01          	add    0x1(%rax,%rbx,8),%esi
  1e:	00 51 52             	add    %dl,0x52(%rcx)
  21:	55                   	push   %rbp
  22:	89 e5                	mov    %esp,%ebp
  24:	0f 34                	sysenter
  26:	cd 80                	int    $0x80
* 28:	5d                   	pop    %rbp <-- trapping instruction
  29:	5a                   	pop    %rdx
  2a:	59                   	pop    %rcx
  2b:	c3                   	ret
  2c:	90                   	nop
  2d:	90                   	nop
  2e:	90                   	nop
  2f:	90                   	nop
  30:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  37:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi


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

