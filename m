Return-Path: <netdev+bounces-210725-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE263B148F1
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 09:08:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4481B18A04E6
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 07:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5561D262FFF;
	Tue, 29 Jul 2025 07:08:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E24125D216
	for <netdev@vger.kernel.org>; Tue, 29 Jul 2025 07:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753772915; cv=none; b=f0m0A9LwhkQSQBjcsmcUBE/u2C3217eWbi5FZJ7ewfSITkQm2f/1aSFdQ4BYsHu2tFCMoLKQMTSHTfocZvjlP1QGUSCnLeGN1X2do19Rh1SbjWPGy03fuJRuaO4/WZJQiAJ4AhtGK2Fn7uPx6NHPzzvb7FPyhQzcryXUTNuUGJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753772915; c=relaxed/simple;
	bh=q4EqZKS4vflGMPdTxyUCd7wRr67+i0q4BSLKbuKvoQ0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=hzfIxe3kEl5D7pLhlF1nlbd3knxRC2utM3EeGfPx89rTLVsJysALhP4zFCFQeT0qtGxuwQSMC9IVqDGtJh5W9ki91DANPJbC7KzBkcwQO2Y418gmhThdfh8jWiOAguoZBJIvu8DLQRFaiZUOw/o36hlnQ2wA5InmByK2YBXvkNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-869e9667f58so1106803339f.3
        for <netdev@vger.kernel.org>; Tue, 29 Jul 2025 00:08:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753772912; x=1754377712;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U3Hn0PoX/MSRr4uXBak/xLMFvhovrq8gZVYaYFNh0+o=;
        b=V7snTd+AsG7TLpDn/R3gzdo9Ii9hrAZhA9IAoxtHQuDR7IfosN4f0WyYNIpcDpQ2yv
         bgm+WfxXSEN0dl1PNVDquTz1efcWSwhtbifSDbllCX89yvlQamNmx2ZSdHPhfzP9rcHL
         f7xXsM9DEbCnscilfejR0Al6NIdHfkv8hS2NqbBhWiK2lEiBspYXL4jXoFAWpLNZwQeh
         /mq6GjvKcj1H284RgXjSVsmkAeoOu/H7bctPB4PSvY4+21JIrMeBqzATGuKJGuAV1SvG
         DUQxnGXadlYxRfkJpc1ZDYq71NcuvblCUMTvSjNNKm/MrqUNpJ/B0+sL0ncDGZud4Uk0
         QZpQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYMEvCu/bPY0M+IMDbKjG/vhqXG+5aIn1xjvVLmfKObboEfKXcwY4B88bAJT5kqqykYiab+Nw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMORN2AvUa3UlFkM8q0K88X6i4o6eWiz0Hb8N4e4vtVQAosxFl
	3+dRBuND5qTSzt+fPv/kSvSwidk/HjRuffdYf5yJjO6nmoMKKqkgEyAd9nHvYJpCtRSqutCllN5
	5jQNu0CWHndsutibaAA4hLFl9Mmq3Ged3G/CxSFnvCrmvWcfiIeBaYCA73xI=
X-Google-Smtp-Source: AGHT+IEQMEwASTmAKGhiV5HnYf5vCPsUXfocQYM+cSFiV81sjCNm2Fh0jn2bnhEnAC6b8WeVrAOxzS7x2rJX3iGaQAKUB/RnlWyq
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:13d5:b0:876:b8a0:6a16 with SMTP id
 ca18e2360f4ac-880229dd81emr2744062239f.13.1753772912535; Tue, 29 Jul 2025
 00:08:32 -0700 (PDT)
Date: Tue, 29 Jul 2025 00:08:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68887370.a00a0220.b12ec.00cc.GAE@google.com>
Subject: [syzbot] [net?] KASAN: use-after-free Read in __xfrm_state_insert
From: syzbot <syzbot+409c1e76795047429447@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, herbert@gondor.apana.org.au, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, steffen.klassert@secunet.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    9312ee76490d octeontx2-af: use unsigned int as iterator fo..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=150688a2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4b71a7f00d74e4f3
dashboard link: https://syzkaller.appspot.com/bug?extid=409c1e76795047429447
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b381ecf9ad30/disk-9312ee76.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ebd0e7846e92/vmlinux-9312ee76.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b9c68d721e9c/bzImage-9312ee76.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+409c1e76795047429447@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in __xfrm_state_insert+0x8af/0x1450 net/xfrm/xfrm_state.c:1743
Read of size 1 at addr ffff888056ba8bb0 by task syz.2.2485/14095

CPU: 0 UID: 0 PID: 14095 Comm: syz.2.2485 Not tainted 6.16.0-rc7-syzkaller-01904-g9312ee76490d #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xca/0x230 mm/kasan/report.c:480
 kasan_report+0x118/0x150 mm/kasan/report.c:593
 __xfrm_state_insert+0x8af/0x1450 net/xfrm/xfrm_state.c:1743
 xfrm_state_insert+0x54/0x60 net/xfrm/xfrm_state.c:1795
 ipcomp6_tunnel_attach net/ipv6/ipcomp6.c:131 [inline]
 ipcomp6_init_state+0x655/0x900 net/ipv6/ipcomp6.c:163
 __xfrm_init_state+0xa73/0x13f0 net/xfrm/xfrm_state.c:3188
 xfrm_init_state+0x18/0xa0 net/xfrm/xfrm_state.c:3231
 pfkey_msg2xfrm_state net/key/af_key.c:1286 [inline]
 pfkey_add+0x1d38/0x2e00 net/key/af_key.c:1504
 pfkey_process net/key/af_key.c:2848 [inline]
 pfkey_sendmsg+0xbfe/0x1090 net/key/af_key.c:3699
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
RIP: 0033:0x7f91e0d8e9a9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f91e1bc9038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f91e0fb5fa0 RCX: 00007f91e0d8e9a9
RDX: 0000000000000000 RSI: 00002000000001c0 RDI: 0000000000000004
RBP: 00007f91e0e10d69 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f91e0fb5fa0 R15: 00007ffd4df147d8
 </TASK>

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff888056babc00 pfn:0x56ba8
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000000 ffffea0000c65608 ffffea0001b7c408 0000000000000000
raw: ffff888056babc00 0000000000100000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as freed
page last allocated via order 2, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 13250, tgid 13248 (syz.1.2213), ts 301636788674, free_ts 323874401753
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
 __do_kmalloc_node mm/slub.c:4327 [inline]
 __kmalloc_noprof+0x305/0x4f0 mm/slub.c:4340
 kmalloc_noprof include/linux/slab.h:909 [inline]
 kzalloc_noprof include/linux/slab.h:1039 [inline]
 copy_splice_read+0x143/0x9b0 fs/splice.c:337
 do_splice_read fs/splice.c:978 [inline]
 splice_direct_to_actor+0x4d0/0xcc0 fs/splice.c:1083
 do_splice_direct_actor fs/splice.c:1201 [inline]
 do_splice_direct+0x181/0x270 fs/splice.c:1227
 do_sendfile+0x4da/0x7e0 fs/read_write.c:1370
 __do_sys_sendfile64 fs/read_write.c:1431 [inline]
 __se_sys_sendfile64+0x13e/0x190 fs/read_write.c:1417
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 5853 tgid 5853 stack trace:
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
 __do_kmalloc_node mm/slub.c:4327 [inline]
 __kmalloc_node_noprof+0x21b/0x4e0 mm/slub.c:4334
 kmalloc_node_noprof include/linux/slab.h:932 [inline]
 __vmalloc_area_node mm/vmalloc.c:3698 [inline]
 __vmalloc_node_range_noprof+0x5a9/0x12f0 mm/vmalloc.c:3893
 __vmalloc_node_noprof mm/vmalloc.c:3956 [inline]
 vzalloc_noprof+0xb2/0xf0 mm/vmalloc.c:4030
 alloc_counters+0xd3/0x6d0 net/ipv4/netfilter/ip_tables.c:799
 copy_entries_to_user net/ipv6/netfilter/ip6_tables.c:837 [inline]
 get_entries net/ipv6/netfilter/ip6_tables.c:1039 [inline]
 do_ip6t_get_ctl+0xa94/0x1180 net/ipv6/netfilter/ip6_tables.c:1677
 nf_getsockopt+0x26b/0x290 net/netfilter/nf_sockopt.c:116
 ipv6_getsockopt+0x1ed/0x290 net/ipv6/ipv6_sockglue.c:1469
 do_sock_getsockopt+0x36f/0x450 net/socket.c:2405
 __sys_getsockopt net/socket.c:2434 [inline]
 __do_sys_getsockopt net/socket.c:2441 [inline]
 __se_sys_getsockopt net/socket.c:2438 [inline]
 __x64_sys_getsockopt+0x1a5/0x250 net/socket.c:2438

Memory state around the buggy address:
 ffff888056ba8a80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff888056ba8b00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>ffff888056ba8b80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                                     ^
 ffff888056ba8c00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff888056ba8c80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
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

