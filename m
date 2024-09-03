Return-Path: <netdev+bounces-124578-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 883A896A0B1
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 16:31:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF53CB221A8
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 14:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D150D6F2E3;
	Tue,  3 Sep 2024 14:31:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C273A8E4
	for <netdev@vger.kernel.org>; Tue,  3 Sep 2024 14:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725373890; cv=none; b=qBRRFZbZPjpX/Aiur71Zq02mHGci7G6I8m4rT+jGyc0stz03JHoc92PlWuqU+OftsyB3gLhuw4MJij+eG9iKcE406L/fEyNM/ScH6wgXbD4Z0+GUdpypo9jCji/bb7mYbqP8MJvHsgzAXApUUxcKwEsvFRDwQ7APajrvAaJpQfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725373890; c=relaxed/simple;
	bh=zEUm9AaNThG+jYCKuF0BFMD5ADqJIYWP2BC68zjK5aI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=REvvuA1QQ1CHcSQzza2dGD01gt5JxA/6M6MGd+PNIZ/huoiY53lCMGBiZVpbmtbdSdnbMRgNbhmSiQH3X6yBlbKsNMR+lGvDnJFNjNA/lIIOKlsE80w8DB0jDFW6DcnT7BKS37jm/1cTG6eQm0qJsGnuXSuqg5i0qpJcB+OMQGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-82a21f28d87so536886739f.3
        for <netdev@vger.kernel.org>; Tue, 03 Sep 2024 07:31:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725373888; x=1725978688;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1EbJpVxHqat1UqmPe/uZ+jTDsqkBPiDfTHBTiUm+X5o=;
        b=LlCLTD6l/bgIm4pdCbFVbpJG119d7tIYH7QY9qcC5W/Ag7Qpf6liHA6wevTqTgrMcb
         1/22USAATJvQzUAMTgtyHIURBqxk2dhZx4EbSx/oImbhpFrsSMmipLUQIkyNiDuHHDjf
         4+2v/STcCkAeqJkVQDApYf76QmcNNiHEcOF4EXr1hvAe6j13HMG0XTFGv9FA+iugByCN
         eRoOWHiLLupdzJX8Lm9PwrlIEY8Pg51chADiyTizBnXd3esoFalFZqh7cdlsQba3chfS
         gWDhnnZsDCLt1Hv7MwWkmS7WRQ5LIGf7ieNKihV8xY4iPnOesreIVtVQgLfBrJE7uxWE
         eKyA==
X-Forwarded-Encrypted: i=1; AJvYcCWa1UoJoe3FGAhtrO7kw1Fqsua540hp7T2jIwS8+bvbZ4Yge+WfuiezxSzUEreI2LXgGXSIN2o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3/Eyf/sSPar6fpjYfDGdY2jUs2ZqeLtMKpdP85QTB7BXSYTp/
	lOb+As1aTJxFAxt0EQGFPKtw8v92l/cZjJOZ8hdzcpLBl34R6hYCQnZbJNPYHCgzxWgG6LF7Iyk
	7xAlClxKS1WXX1ZsqCNxbmUAjTLQvottaMFY1cs2AOBhb8kEk90JmI0U=
X-Google-Smtp-Source: AGHT+IEsIlgzktiiL7nJ1Xk9TPXhHKwHsc5K8dw7PG4X5ADysc1lffUcblXURb1MIwlDl091Qi2SjRe0Ls9AKrwCq+NhCwISQ57l
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6413:b0:81f:c103:3e5f with SMTP id
 ca18e2360f4ac-82a262e2377mr56173139f.3.1725373887915; Tue, 03 Sep 2024
 07:31:27 -0700 (PDT)
Date: Tue, 03 Sep 2024 07:31:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b1b939062137e978@google.com>
Subject: [syzbot] [mptcp?] KASAN: slab-use-after-free Read in lock_timer_base
From: syzbot <syzbot+3a98aec25a4ab6a4d963@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, geliang@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, martineau@kernel.org, 
	matttbe@kernel.org, mptcp@lists.linux.dev, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    1934261d8974 Merge tag 'input-for-v6.11-rc5' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10bf9943980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=996585887acdadb3
dashboard link: https://syzkaller.appspot.com/bug?extid=3a98aec25a4ab6a4d963
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d02c28e8dbf3/disk-1934261d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/464d0e233034/vmlinux-1934261d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8735d78fb16a/bzImage-1934261d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3a98aec25a4ab6a4d963@syzkaller.appspotmail.com

TCP: request_sock_subflow_v4: Possible SYN flooding on port [::]:20002. Sending cookies.
==================================================================
BUG: KASAN: slab-use-after-free in lock_timer_base+0x1a7/0x240 kernel/time/timer.c:1052
Read of size 4 at addr ffff888029b38e50 by task kworker/0:2/940

CPU: 0 UID: 0 PID: 940 Comm: kworker/0:2 Not tainted 6.11.0-rc5-syzkaller-00219-g1934261d8974 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Workqueue: events mptcp_worker
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 lock_timer_base+0x1a7/0x240 kernel/time/timer.c:1052
 __try_to_del_timer_sync+0xb5/0x340 kernel/time/timer.c:1506
 __timer_delete_sync+0x245/0x310 kernel/time/timer.c:1665
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

Allocated by task 940:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:387
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 __kmalloc_cache_noprof+0x19c/0x2c0 mm/slub.c:4189
 kmalloc_noprof include/linux/slab.h:681 [inline]
 mptcp_pm_alloc_anno_list+0x14e/0x390 net/mptcp/pm_netlink.c:370
 mptcp_pm_create_subflow_or_signal_addr+0x1920/0x22c0 net/mptcp/pm_netlink.c:586
 mptcp_pm_nl_fully_established net/mptcp/pm_netlink.c:640 [inline]
 mptcp_pm_nl_work+0x19ae/0x1fc0 net/mptcp/pm_netlink.c:932
 mptcp_worker+0x12f/0x1440 net/mptcp/protocol.c:2759
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
 worker_thread+0x86d/0xd10 kernel/workqueue.c:3389
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Freed by task 12966:
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

The buggy address belongs to the object at ffff888029b38e00
 which belongs to the cache kmalloc-192 of size 192
The buggy address is located 80 bytes inside of
 freed 192-byte region [ffff888029b38e00, ffff888029b38ec0)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x29b38
ksm flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xfdffffff(slab)
raw: 00fff00000000000 ffff88801ac413c0 ffffea0000bd3380 dead000000000003
raw: 0000000000000000 0000000080100010 00000001fdffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x352800(GFP_NOWAIT|__GFP_NORETRY|__GFP_COMP|__GFP_HARDWALL|__GFP_THISNODE), pid 5573, tgid 5573 (cmp), ts 78576722831, free_ts 78537901249
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
 vma_lock_alloc kernel/fork.c:445 [inline]
 vm_area_dup+0x61/0x290 kernel/fork.c:498
 __split_vma+0x1a9/0xc30 mm/mmap.c:2465
 do_vmi_align_munmap+0x433/0x18c0 mm/mmap.c:2676
 do_vmi_munmap+0x261/0x2f0 mm/mmap.c:2830
page last free pid 5572 tgid 5572 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1094 [inline]
 free_unref_folios+0x103a/0x1b00 mm/page_alloc.c:2660
 folios_put_refs+0x76e/0x860 mm/swap.c:1039
 free_pages_and_swap_cache+0x5c8/0x690 mm/swap_state.c:335
 __tlb_batch_free_encoded_pages mm/mmu_gather.c:136 [inline]
 tlb_batch_pages_flush mm/mmu_gather.c:149 [inline]
 tlb_flush_mmu_free mm/mmu_gather.c:366 [inline]
 tlb_flush_mmu+0x3a3/0x680 mm/mmu_gather.c:373
 tlb_finish_mmu+0xd4/0x200 mm/mmu_gather.c:465
 exit_mmap+0x44f/0xc80 mm/mmap.c:3425
 __mmput+0x115/0x390 kernel/fork.c:1345
 exit_mm+0x220/0x310 kernel/exit.c:571
 do_exit+0x9b2/0x27f0 kernel/exit.c:869
 do_group_exit+0x207/0x2c0 kernel/exit.c:1031
 __do_sys_exit_group kernel/exit.c:1042 [inline]
 __se_sys_exit_group kernel/exit.c:1040 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1040
 x64_sys_call+0x2634/0x2640 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff888029b38d00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888029b38d80: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
>ffff888029b38e00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                 ^
 ffff888029b38e80: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
 ffff888029b38f00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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

