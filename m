Return-Path: <netdev+bounces-239041-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 197C3C62CBC
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 08:50:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id BAD7424241
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 07:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B92362F6184;
	Mon, 17 Nov 2025 07:50:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACBE7267B92
	for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 07:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763365830; cv=none; b=AN7VKEBDYnxIJo+q328LeIzBMkt+trLLPYFYOCsuDjpaxA2RjXdrDd+RfHop6VWToi/uZcSd8aCF3w+enU3MovmVjx3eiFLLlB0Bg03JAUHiTj3bQfsbjIelsOmiKr35mHqfx55Mc1bZouTw7W3A00ulN1h13fEEemuvBQDS8NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763365830; c=relaxed/simple;
	bh=fyv8Tw1lT47IXGG0zH/8JBH66A640H5gzWsNKy+mm+Y=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=uQFXQwskXc4I57ZVAh6Tf6dIPGYm82TlRa0GKgx2b1meMJweMMG0oPLR1SMJkyxGYL/o8GOfH7Lh3CnYj/XemQSmHrkry2nmso5TWFVy4gufUlqEaYM78qrKRTz8NiUCxNW11O7QLXHWPGRD68/LqOcDXC369HMVXUCd8UMWKY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-43373024b5eso44355615ab.1
        for <netdev@vger.kernel.org>; Sun, 16 Nov 2025 23:50:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763365828; x=1763970628;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l6/TbSrkr4zDJJCyMBLL6uCe6ZYiDDdqBbWagbSeP44=;
        b=msbdIBdIt22LFBVMzDWqzXvG7+IFxGIG32AS51PoHwWR+xLEXHNXUQUvip40jrMOwj
         anOYpEA3MzEFy21gRp9lQry23THA5odYCTn2+C+zbcBT0f0t/LEAZB03PC/EkD6XPykk
         MLsaEGloNpjs/gySbS5ZJTnE1EJddSVJlw8SiBELmMPdqfDJWlMZzIhURM90LKkg5oxY
         fECPDDrEj6kmK46R6qB8nnu7Ow+QPStFVSZR+qB9la7dCvC0B+1zU7KrFS1lKsIP+E1I
         Yf4bXsg1sQSj9WQrYRl5bBWZ2iUHg0s9KM3WEzgZRILh+N8RHbqX/6YQIVFYKCiHu5nZ
         +0yA==
X-Forwarded-Encrypted: i=1; AJvYcCWHnEn6Vbp6dKww2bQnN0WSkPTAUszeTAcjzS0obA/wPk021CfODllf5zZglvfEr+xcwB5yN0E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxta/B0zeR9yCylLifBAOcmTh3Cy4mQdB9f1apk1ntpWWbIbjKQ
	vu3HoxlzJQ/8CGaAvvCm0o0+xJNstHMZAvKHfqsjCXg6vjsDWoswp7tgRRxaSpZ1ZSnFCnjuCBH
	YcSsIDRk8PDhDL3cugr1jvjLKJtXj55PuLq9Y+IfkdF9+2iw+WhHhH9iHDiI=
X-Google-Smtp-Source: AGHT+IHQasjwkGY8eE2+Q7KkRWtGGeGU1a3mIwfBshOsRIcWj7hcUtwqj8jhePFLTcYWSDL2edKD7zSY/PvTcoSFlgVNdkx7XUFK
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1b0e:b0:434:96ea:ff73 with SMTP id
 e9e14a558f8ab-43496eb02acmr103520745ab.35.1763365827787; Sun, 16 Nov 2025
 23:50:27 -0800 (PST)
Date: Sun, 16 Nov 2025 23:50:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <691ad3c3.a70a0220.f6df1.0004.GAE@google.com>
Subject: [syzbot] [mptcp?] KASAN: slab-use-after-free Read in mptcp_pm_del_add_timer
From: syzbot <syzbot+2a6fbf0f0530375968df@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, geliang@kernel.org, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	martineau@kernel.org, matttbe@kernel.org, mptcp@lists.linux.dev, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    98ac9cc4b445 Merge tag 'f2fs-fix-6.18-rc2' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1712bdcd980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=af9170887d81dea1
dashboard link: https://syzkaller.appspot.com/bug?extid=2a6fbf0f0530375968df
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/aa708867a71c/disk-98ac9cc4.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5d853b65c8dc/vmlinux-98ac9cc4.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f0f012153d60/bzImage-98ac9cc4.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2a6fbf0f0530375968df@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in __timer_delete_sync+0x372/0x3f0 kernel/time/timer.c:1616
Read of size 4 at addr ffff8880311e4150 by task kworker/1:1/44

CPU: 1 UID: 0 PID: 44 Comm: kworker/1:1 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
Workqueue: events mptcp_worker
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xca/0x240 mm/kasan/report.c:482
 kasan_report+0x118/0x150 mm/kasan/report.c:595
 __timer_delete_sync+0x372/0x3f0 kernel/time/timer.c:1616
 sk_stop_timer_sync+0x1b/0x90 net/core/sock.c:3631
 mptcp_pm_del_add_timer+0x283/0x310 net/mptcp/pm.c:362
 mptcp_incoming_options+0x1357/0x1f60 net/mptcp/options.c:1174
 tcp_data_queue+0xca/0x6450 net/ipv4/tcp_input.c:5361
 tcp_rcv_established+0x1335/0x2670 net/ipv4/tcp_input.c:6441
 tcp_v4_do_rcv+0x98b/0xbf0 net/ipv4/tcp_ipv4.c:1931
 tcp_v4_rcv+0x252a/0x2dc0 net/ipv4/tcp_ipv4.c:2374
 ip_protocol_deliver_rcu+0x221/0x440 net/ipv4/ip_input.c:205
 ip_local_deliver_finish+0x3bb/0x6f0 net/ipv4/ip_input.c:239
 NF_HOOK+0x30c/0x3a0 include/linux/netfilter.h:318
 NF_HOOK+0x30c/0x3a0 include/linux/netfilter.h:318
 __netif_receive_skb_one_core net/core/dev.c:6079 [inline]
 __netif_receive_skb+0x143/0x380 net/core/dev.c:6192
 process_backlog+0x31e/0x900 net/core/dev.c:6544
 __napi_poll+0xb6/0x540 net/core/dev.c:7594
 napi_poll net/core/dev.c:7657 [inline]
 net_rx_action+0x5f7/0xda0 net/core/dev.c:7784
 handle_softirqs+0x22f/0x710 kernel/softirq.c:622
 __do_softirq kernel/softirq.c:656 [inline]
 __local_bh_enable_ip+0x1a0/0x2e0 kernel/softirq.c:302
 mptcp_pm_send_ack net/mptcp/pm.c:210 [inline]
 mptcp_pm_addr_send_ack+0x41f/0x500 net/mptcp/pm.c:-1
 mptcp_pm_worker+0x174/0x320 net/mptcp/pm.c:1002
 mptcp_worker+0xd5/0x1170 net/mptcp/protocol.c:2762
 process_one_work kernel/workqueue.c:3263 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3346
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3427
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Allocated by task 44:
 kasan_save_stack mm/kasan/common.c:56 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:77
 poison_kmalloc_redzone mm/kasan/common.c:400 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:417
 kasan_kmalloc include/linux/kasan.h:262 [inline]
 __kmalloc_cache_noprof+0x1ef/0x6c0 mm/slub.c:5748
 kmalloc_noprof include/linux/slab.h:957 [inline]
 mptcp_pm_alloc_anno_list+0x104/0x460 net/mptcp/pm.c:385
 mptcp_pm_create_subflow_or_signal_addr+0xf9d/0x1360 net/mptcp/pm_kernel.c:355
 mptcp_pm_nl_fully_established net/mptcp/pm_kernel.c:409 [inline]
 __mptcp_pm_kernel_worker+0x417/0x1ef0 net/mptcp/pm_kernel.c:1529
 mptcp_pm_worker+0x1ee/0x320 net/mptcp/pm.c:1008
 mptcp_worker+0xd5/0x1170 net/mptcp/protocol.c:2762
 process_one_work kernel/workqueue.c:3263 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3346
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3427
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Freed by task 6630:
 kasan_save_stack mm/kasan/common.c:56 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:77
 __kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:587
 kasan_save_free_info mm/kasan/kasan.h:406 [inline]
 poison_slab_object mm/kasan/common.c:252 [inline]
 __kasan_slab_free+0x5c/0x80 mm/kasan/common.c:284
 kasan_slab_free include/linux/kasan.h:234 [inline]
 slab_free_hook mm/slub.c:2523 [inline]
 slab_free mm/slub.c:6611 [inline]
 kfree+0x197/0x950 mm/slub.c:6818
 mptcp_remove_anno_list_by_saddr+0x2d/0x40 net/mptcp/pm.c:158
 mptcp_pm_flush_addrs_and_subflows net/mptcp/pm_kernel.c:1209 [inline]
 mptcp_nl_flush_addrs_list net/mptcp/pm_kernel.c:1240 [inline]
 mptcp_pm_nl_flush_addrs_doit+0x593/0xbb0 net/mptcp/pm_kernel.c:1281
 genl_family_rcv_msg_doit+0x215/0x300 net/netlink/genetlink.c:1115
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0x60e/0x790 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x208/0x470 net/netlink/af_netlink.c:2552
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
 netlink_unicast+0x846/0xa10 net/netlink/af_netlink.c:1346
 netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1896
 sock_sendmsg_nosec net/socket.c:727 [inline]
 __sock_sendmsg+0x21c/0x270 net/socket.c:742
 ____sys_sendmsg+0x508/0x820 net/socket.c:2630
 ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2684
 __sys_sendmsg net/socket.c:2716 [inline]
 __do_sys_sendmsg net/socket.c:2721 [inline]
 __se_sys_sendmsg net/socket.c:2719 [inline]
 __x64_sys_sendmsg+0x1a1/0x260 net/socket.c:2719
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff8880311e4100
 which belongs to the cache kmalloc-192 of size 192
The buggy address is located 80 bytes inside of
 freed 192-byte region [ffff8880311e4100, ffff8880311e41c0)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x311e4
flags: 0x80000000000000(node=0|zone=1)
page_type: f5(slab)
raw: 0080000000000000 ffff88813ff263c0 ffffea0000c42a00 dead000000000004
raw: 0000000000000000 0000000080100010 00000000f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52820(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 5806, tgid 5806 (syz-executor), ts 106874965631, free_ts 106848734160
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x240/0x2a0 mm/page_alloc.c:1850
 prep_new_page mm/page_alloc.c:1858 [inline]
 get_page_from_freelist+0x28c0/0x2960 mm/page_alloc.c:3884
 __alloc_frozen_pages_noprof+0x181/0x370 mm/page_alloc.c:5183
 alloc_pages_mpol+0xd1/0x380 mm/mempolicy.c:2416
 alloc_slab_page mm/slub.c:3039 [inline]
 allocate_slab+0x96/0x3a0 mm/slub.c:3212
 new_slab mm/slub.c:3266 [inline]
 ___slab_alloc+0xb12/0x13f0 mm/slub.c:4636
 __slab_alloc+0xc6/0x1f0 mm/slub.c:4755
 __slab_alloc_node mm/slub.c:4831 [inline]
 slab_alloc_node mm/slub.c:5253 [inline]
 __kmalloc_cache_noprof+0xec/0x6c0 mm/slub.c:5743
 kmalloc_noprof include/linux/slab.h:957 [inline]
 addr_event+0xc3/0x470 drivers/infiniband/core/roce_gid_mgmt.c:861
 inet6addr_event+0x9f/0xd0 drivers/infiniband/core/roce_gid_mgmt.c:904
 notifier_call_chain+0x1b6/0x3e0 kernel/notifier.c:85
 atomic_notifier_call_chain+0xda/0x180 kernel/notifier.c:223
 ipv6_add_addr+0xdf1/0x10e0 net/ipv6/addrconf.c:1186
 inet6_addr_add+0x393/0xb40 net/ipv6/addrconf.c:3050
 inet6_rtm_newaddr+0x93d/0xd20 net/ipv6/addrconf.c:5059
 rtnetlink_rcv_msg+0x7cf/0xb70 net/core/rtnetlink.c:6954
page last free pid 28 tgid 28 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1394 [inline]
 __free_frozen_pages+0xfb6/0x1140 mm/page_alloc.c:2906
 rcu_do_batch kernel/rcu/tree.c:2605 [inline]
 rcu_core kernel/rcu/tree.c:2861 [inline]
 rcu_cpu_kthread+0xbf6/0x1b50 kernel/rcu/tree.c:2949
 smpboot_thread_fn+0x542/0xa60 kernel/smpboot.c:160
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Memory state around the buggy address:
 ffff8880311e4000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880311e4080: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
>ffff8880311e4100: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                 ^
 ffff8880311e4180: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
 ffff8880311e4200: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
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

