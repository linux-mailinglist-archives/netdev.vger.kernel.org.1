Return-Path: <netdev+bounces-207278-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F19B068C9
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 23:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2747564AFA
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 21:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 381E026E70A;
	Tue, 15 Jul 2025 21:46:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512B326AD9
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 21:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752616000; cv=none; b=Jc2e3xnSYJaskuLwuw7IdOhCbUpWc/7xMJBbAJBKSwXqSB5V9IHWXPY8Tq1xtP1jAzZvoS1rOt6IWyqbHJQiih8oSI1A3tM4BU5wxwbviCFTiW+oq03nOl5/Zlxg52nNdfm6RnXQAwV9WuL9sv3VIb0T413svYT9NIBnpXg5KTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752616000; c=relaxed/simple;
	bh=28EReSvGS1OItsACOO4DEOJ1gayPQUbawRXXaoL0ZwA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Mfdt19an4ONGxZg3Q614XyyuTNLzLRHA+/tYmHNiJ8EUuIZZYUQ6X5P4tgpJEniLhChtD+dcKXGXv7zWR8hWBGeVXayuMd9JQaBazgWvUeE4zCMQeU/VqZb1jiTnNPbiMu//Fjt2bObwf18jBZwl/hQ7wADpym1cI7COZYl6w6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-875bd5522e9so543562539f.2
        for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 14:46:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752615996; x=1753220796;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AId4z9LKnoVcY1CXC3qGXxmwEHZRzOiob7S94pb47JE=;
        b=XeYWC2BuHYBeFXHZ1Xt2rjTkUwaxdEYPEMAd4cEhD2o/KkPmQV9rl0GyM/bzZioV1/
         oIRVSWBmZpr+ZBkUIG1kc0YT0IQyLTbU/BLqQVNycqVPC4fPbjV4UG3VwDqGn6kScb1I
         wzK9KMxugIchJdYQCzLzWbxDvGQHD+D9z/iBcFCE/iQ0aQtAR37ucPvSq+0yMqxQjhgg
         vUqT7/sLD47/H9KFxt3xkX9oV82cEuNdqZG5Z3K1xyzieZcpYD9yLm3ogkaGLkSXLiGK
         d6CaQ2q38QWIXW6o8tZfXFkr50wkAWKCzTRtghvYD1sfutA6lYszmhxURO/NAkmQ1KCc
         U8Og==
X-Forwarded-Encrypted: i=1; AJvYcCUNtShBztX+sx3iHjWi6Ce9QLv8EniAAYrfY5y8yWLxPq75TxatU1Sbyb5qWVL6fC6da2W4qXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx07amef1CiWMGCbJ6HiFjD8IDSN15vd0LwKEz9voLhZpkC0LPF
	OCwSRyEoa7RGDbQUg72GtKfXddpz3SK9n/KrwC3cT3tqeFWZB0DeB23STmOoGgb6KoUKbF6z+9F
	gCWiXpnqHpzeUod7FCIsPAGYAvkbTl34OtVrghS53MUreIOVSAQw+OT/ff1k=
X-Google-Smtp-Source: AGHT+IHW9Lpgr6Feda5JTj9qhw6aNsQ4x/BLMCrd7u/XWYjhPNuPaokHHTd4UZ/BvdUiHxulMbh0FwJC1fbqCHjhfW1O6UsQ+H/D
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3d1:b0:875:d675:55f2 with SMTP id
 ca18e2360f4ac-879c28caec0mr13346039f.7.1752615996309; Tue, 15 Jul 2025
 14:46:36 -0700 (PDT)
Date: Tue, 15 Jul 2025 14:46:36 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6876cc3c.a00a0220.3af5df.000a.GAE@google.com>
Subject: [syzbot] [net?] KASAN: slab-use-after-free Read in tcp_prune_ofo_queue
From: syzbot <syzbot+9d2a6ef56c3805144bf0@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, kuniyu@google.com, 
	linux-kernel@vger.kernel.org, ncardwell@google.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    55e8757c6962 Merge branch 'net-mctp-improved-bind-handling'
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=15834382580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f8235fb7e74dd7f6
dashboard link: https://syzkaller.appspot.com/bug?extid=9d2a6ef56c3805144bf0
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1445058c580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=148e098c580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6c4b54c5d7b6/disk-55e8757c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3885c5b76f45/vmlinux-55e8757c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f16a3c7b11be/bzImage-55e8757c.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9d2a6ef56c3805144bf0@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in tcp_can_ingest net/ipv4/tcp_input.c:4896 [inline]
BUG: KASAN: slab-use-after-free in tcp_prune_ofo_queue+0x37e/0x6e0 net/ipv4/tcp_input.c:5520
Read of size 4 at addr ffff88802779f350 by task syz.2.45/6135

CPU: 1 UID: 0 PID: 6135 Comm: syz.2.45 Not tainted 6.16.0-rc5-syzkaller-01444-g55e8757c6962 #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:408 [inline]
 print_report+0xd2/0x2b0 mm/kasan/report.c:521
 kasan_report+0x118/0x150 mm/kasan/report.c:634
 tcp_can_ingest net/ipv4/tcp_input.c:4896 [inline]
 tcp_prune_ofo_queue+0x37e/0x6e0 net/ipv4/tcp_input.c:5520
 tcp_prune_queue net/ipv4/tcp_input.c:5575 [inline]
 tcp_try_rmem_schedule+0xb6b/0x1830 net/ipv4/tcp_input.c:4907
 tcp_data_queue+0x4e3/0x6380 net/ipv4/tcp_input.c:5192
 tcp_rcv_established+0xf9e/0x1eb0 net/ipv4/tcp_input.c:6208
 tcp_v4_do_rcv+0xa23/0xce0 net/ipv4/tcp_ipv4.c:1925
 sk_backlog_rcv include/net/sock.h:1148 [inline]
 __release_sock+0x21c/0x350 net/core/sock.c:3188
 release_sock+0x5f/0x1f0 net/core/sock.c:3742
 tcp_sendmsg+0x39/0x50 net/ipv4/tcp.c:1394
 sock_sendmsg_nosec net/socket.c:714 [inline]
 __sock_sendmsg+0x19c/0x270 net/socket.c:729
 __sys_sendto+0x3bd/0x520 net/socket.c:2228
 __do_sys_sendto net/socket.c:2235 [inline]
 __se_sys_sendto net/socket.c:2231 [inline]
 __x64_sys_sendto+0xde/0x100 net/socket.c:2231
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa36638e929
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffdf475f108 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00007fa3665b5fa0 RCX: 00007fa36638e929
RDX: 000000000000059a RSI: 0000200000000580 RDI: 0000000000000003
RBP: 00007fa366410b39 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000010008095 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fa3665b5fa0 R14: 00007fa3665b5fa0 R15: 0000000000000006
 </TASK>

Allocated by task 6135:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:319 [inline]
 __kasan_slab_alloc+0x6c/0x80 mm/kasan/common.c:345
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4148 [inline]
 slab_alloc_node mm/slub.c:4197 [inline]
 kmem_cache_alloc_node_noprof+0x1bb/0x3c0 mm/slub.c:4249
 __alloc_skb+0x112/0x2d0 net/core/skbuff.c:659
 alloc_skb_fclone include/linux/skbuff.h:1386 [inline]
 tcp_stream_alloc_skb+0x3d/0x340 net/ipv4/tcp.c:892
 tso_fragment net/ipv4/tcp_output.c:2174 [inline]
 tcp_write_xmit+0xeec/0x67f0 net/ipv4/tcp_output.c:2819
 __tcp_push_pending_frames+0x97/0x360 net/ipv4/tcp_output.c:3016
 tcp_sendmsg_locked+0x483c/0x56d0 net/ipv4/tcp.c:1356
 tcp_sendmsg+0x2f/0x50 net/ipv4/tcp.c:1393
 sock_sendmsg_nosec net/socket.c:714 [inline]
 __sock_sendmsg+0x19c/0x270 net/socket.c:729
 __sys_sendto+0x3bd/0x520 net/socket.c:2228
 __do_sys_sendto net/socket.c:2235 [inline]
 __se_sys_sendto net/socket.c:2231 [inline]
 __x64_sys_sendto+0xde/0x100 net/socket.c:2231
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 6135:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:576
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x62/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2381 [inline]
 slab_free mm/slub.c:4643 [inline]
 kmem_cache_free+0x18f/0x400 mm/slub.c:4745
 tcp_prune_ofo_queue+0x198/0x6e0 net/ipv4/tcp_input.c:5517
 tcp_prune_queue net/ipv4/tcp_input.c:5575 [inline]
 tcp_try_rmem_schedule+0xb6b/0x1830 net/ipv4/tcp_input.c:4907
 tcp_data_queue+0x4e3/0x6380 net/ipv4/tcp_input.c:5192
 tcp_rcv_established+0xf9e/0x1eb0 net/ipv4/tcp_input.c:6208
 tcp_v4_do_rcv+0xa23/0xce0 net/ipv4/tcp_ipv4.c:1925
 sk_backlog_rcv include/net/sock.h:1148 [inline]
 __release_sock+0x21c/0x350 net/core/sock.c:3188
 release_sock+0x5f/0x1f0 net/core/sock.c:3742
 tcp_sendmsg+0x39/0x50 net/ipv4/tcp.c:1394
 sock_sendmsg_nosec net/socket.c:714 [inline]
 __sock_sendmsg+0x19c/0x270 net/socket.c:729
 __sys_sendto+0x3bd/0x520 net/socket.c:2228
 __do_sys_sendto net/socket.c:2235 [inline]
 __se_sys_sendto net/socket.c:2231 [inline]
 __x64_sys_sendto+0xde/0x100 net/socket.c:2231
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88802779f180
 which belongs to the cache skbuff_fclone_cache of size 488
The buggy address is located 464 bytes inside of
 freed 488-byte region [ffff88802779f180, ffff88802779f368)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x2779e
head: order:1 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff8881416b9a00 dead000000000122 0000000000000000
raw: 0000000000000000 00000000000c000c 00000000f5000000 0000000000000000
head: 00fff00000000040 ffff8881416b9a00 dead000000000122 0000000000000000
head: 0000000000000000 00000000000c000c 00000000f5000000 0000000000000000
head: 00fff00000000001 ffffea00009de781 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000002
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 1, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 6135, tgid 6135 (syz.2.45), ts 109281901479, free_ts 109187086002
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
 kmem_cache_alloc_node_noprof+0x280/0x3c0 mm/slub.c:4249
 __alloc_skb+0x112/0x2d0 net/core/skbuff.c:659
 alloc_skb_fclone include/linux/skbuff.h:1386 [inline]
 tcp_stream_alloc_skb+0x3d/0x340 net/ipv4/tcp.c:892
 tcp_sendmsg_locked+0xefc/0x56d0 net/ipv4/tcp.c:1198
 tcp_sendmsg+0x2f/0x50 net/ipv4/tcp.c:1393
 sock_sendmsg_nosec net/socket.c:714 [inline]
 __sock_sendmsg+0x19c/0x270 net/socket.c:729
 __sys_sendto+0x3bd/0x520 net/socket.c:2228
 __do_sys_sendto net/socket.c:2235 [inline]
 __se_sys_sendto net/socket.c:2231 [inline]
 __x64_sys_sendto+0xde/0x100 net/socket.c:2231
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 5216 tgid 5216 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1248 [inline]
 __free_frozen_pages+0xc71/0xe70 mm/page_alloc.c:2706
 __slab_free+0x326/0x400 mm/slub.c:4554
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x97/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x148/0x160 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x22/0x80 mm/kasan/common.c:329
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4148 [inline]
 slab_alloc_node mm/slub.c:4197 [inline]
 kmem_cache_alloc_noprof+0x1c1/0x3c0 mm/slub.c:4204
 getname_flags+0xb8/0x540 fs/namei.c:146
 do_readlinkat+0xbc/0x500 fs/stat.c:575
 __do_sys_readlink fs/stat.c:613 [inline]
 __se_sys_readlink fs/stat.c:610 [inline]
 __x64_sys_readlink+0x7f/0x90 fs/stat.c:610
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff88802779f200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88802779f280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88802779f300: fb fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc
                                                 ^
 ffff88802779f380: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88802779f400: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
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

