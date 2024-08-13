Return-Path: <netdev+bounces-117949-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D76A95005D
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 10:52:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F08C1C20F5D
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 08:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BCEB137C2A;
	Tue, 13 Aug 2024 08:51:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A1A13C3CD
	for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 08:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723539085; cv=none; b=QN84O4s/nIFvn57XMjH7uc7R3d5D5EvyER3so6CQLUYQenGKfATtBO115qkkp6nPCKdahVrO/P5JTnitNrDZKjZJpl5RIJTgZuyv1XiS/oBeK4RJ4LSc9vX+5DeTngwNFmfGUXKejoyJubzb5T9/7OLYAWnvV/AuF3GIae7Vy8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723539085; c=relaxed/simple;
	bh=WznQwjGPxvTmclHnZKSzEGIKkIHdlFNXItITSQ+WJUE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=tTntwjjt09QjqLEW3SP6XFxfMWAzLdHO9Oaoh55f5E4vFR2KAIFHUEY3vH58oBe2FUTrP6fU6dFy7Ltz+tTQn6wzSNyUdPiHwzBq0i1KXVK3a6Q79KhwC52RVsi5eo1ahkKpu4ok532EcHWsm7MCmRxGX2YP7455rmadDxwIAjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-81f901cd3b5so705242239f.1
        for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 01:51:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723539082; x=1724143882;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AK0nuk42RhiF1PKAdJxUgR6W8c2KHHAZqJGbPQdKTuY=;
        b=cWjQgNV+7Z85ZjMH/3AObZ+QMXtGnTiHfWVfRMDfZeFW5UorS3L3CS5nBqaU9muqIR
         36BZp0EDW5hr4gdNJkbupcaiZvzfWetpAUNsfpzf7T7ESlcIALjvtGxeVqecg8KbsL2f
         BUJCgdJO/apCYeNXabA2PvfNbGel3EkzNq9ljGCDIZDnwHW3ZtBgVFW3u4AFALp3UKUv
         fhcUtLbyAgTkPYRLFwlBSkXvSkyAiKGXTRrG4YiepiyJB+FcyyhbqQGoZcL91iRXcVu7
         UPQZvrAyhni41yhNQ+e2S+I02RzIOkc93E2hQP9ilWo9mVAR25qIcC2+rx9QKWrOTXok
         2T4A==
X-Forwarded-Encrypted: i=1; AJvYcCViH919DwVsgyp0D9ejngumWp1NBxJMJ7oxPuu3K7kGk75J+o6+HFI9YLzm/JYoOJfZ0032kOVZUbDXaAg7AH+eG6wdoheI
X-Gm-Message-State: AOJu0YyZpsBltlCEZtAJBDp5l0XTf1QQw0mGouGqBTj1ay4xkpPh/dn4
	+kZ6nGWm1iCB9rLT/SVS00xVZCtiVu8TZDUdffzGDjxjX9x3kqSVxQNZkqBJ5ngjTLycLNFX6nd
	aZYqhwK0iIyy8FU4PKVXcqBnfq/75ZJG9AmkpXW9tynqlX5WGoGf2qiI=
X-Google-Smtp-Source: AGHT+IHQY5SluLnhYxGLOsHMMW5Nj6F26EvqyJ41AJ2zLzLj5NXpsJczd14b4EwfLr0MBk0Rs+4QLAPwlZfJqk7WAun2c2ThN7+W
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:410c:b0:4c0:9a3e:c263 with SMTP id
 8926c6da1cb9f-4ca9f44e7d3mr150180173.0.1723539082567; Tue, 13 Aug 2024
 01:51:22 -0700 (PDT)
Date: Tue, 13 Aug 2024 01:51:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c5f090061f8cb618@google.com>
Subject: [syzbot] [net?] KASAN: slab-use-after-free Read in team_dummy_transmit
From: syzbot <syzbot+82be73e8a10acaf29122@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, jiri@resnulli.us, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d0d0cd380055 Merge tag '6.10-rc7-smb3-client-fix' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14cbb8f6980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3456bae478301dc8
dashboard link: https://syzkaller.appspot.com/bug?extid=82be73e8a10acaf29122
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-d0d0cd38.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f66b25353da2/vmlinux-d0d0cd38.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f0742b62ea1e/bzImage-d0d0cd38.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+82be73e8a10acaf29122@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in instrument_atomic_read include/linux/instrumented.h:68 [inline]
BUG: KASAN: slab-use-after-free in atomic_read include/linux/atomic/atomic-instrumented.h:32 [inline]
BUG: KASAN: slab-use-after-free in refcount_read include/linux/refcount.h:136 [inline]
BUG: KASAN: slab-use-after-free in skb_unref include/linux/skbuff.h:1222 [inline]
BUG: KASAN: slab-use-after-free in __kfree_skb_reason net/core/skbuff.c:1195 [inline]
BUG: KASAN: slab-use-after-free in kfree_skb_reason+0x36/0x210 net/core/skbuff.c:1222
Read of size 4 at addr ffff88802cdde364 by task syz.2.1851/10652

CPU: 3 PID: 10652 Comm: syz.2.1851 Not tainted 6.10.0-rc7-syzkaller-00256-gd0d0cd380055 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:114
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0xc3/0x620 mm/kasan/report.c:488
 kasan_report+0xd9/0x110 mm/kasan/report.c:601
 check_region_inline mm/kasan/generic.c:183 [inline]
 kasan_check_range+0xef/0x1a0 mm/kasan/generic.c:189
 instrument_atomic_read include/linux/instrumented.h:68 [inline]
 atomic_read include/linux/atomic/atomic-instrumented.h:32 [inline]
 refcount_read include/linux/refcount.h:136 [inline]
 skb_unref include/linux/skbuff.h:1222 [inline]
 __kfree_skb_reason net/core/skbuff.c:1195 [inline]
 kfree_skb_reason+0x36/0x210 net/core/skbuff.c:1222
 dev_kfree_skb_any_reason+0x72/0x80 net/core/dev.c:3199
 dev_kfree_skb_any include/linux/netdevice.h:3854 [inline]
 team_dummy_transmit+0x1a/0x30 drivers/net/team/team_core.c:502
 team_xmit+0x34f/0x470 drivers/net/team/team_core.c:1721
 __netdev_start_xmit include/linux/netdevice.h:4882 [inline]
 netdev_start_xmit include/linux/netdevice.h:4896 [inline]
 __dev_direct_xmit+0x59e/0x740 net/core/dev.c:4449
 dev_direct_xmit include/linux/netdevice.h:3108 [inline]
 packet_xmit+0x1e4/0x360 net/packet/af_packet.c:285
 packet_snd net/packet/af_packet.c:3080 [inline]
 packet_sendmsg+0x24a5/0x51e0 net/packet/af_packet.c:3112
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg net/socket.c:745 [inline]
 __sys_sendto+0x47f/0x4e0 net/socket.c:2192
 __do_sys_sendto net/socket.c:2204 [inline]
 __se_sys_sendto net/socket.c:2200 [inline]
 __x64_sys_sendto+0xe0/0x1c0 net/socket.c:2200
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fc803d75bd9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fc804c20048 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00007fc803f03f60 RCX: 00007fc803d75bd9
RDX: 000000000000fc13 RSI: 0000000020000280 RDI: 000000000000000d
RBP: 00007fc803de4e60 R08: 0000000000000000 R09: 000000000000002f
R10: 0000000000000800 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007fc803f03f60 R15: 00007ffd23ee3e88
 </TASK>

Allocated by task 10652:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:312 [inline]
 __kasan_slab_alloc+0x89/0x90 mm/kasan/common.c:338
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3940 [inline]
 slab_alloc_node mm/slub.c:4002 [inline]
 kmem_cache_alloc_node_noprof+0x153/0x310 mm/slub.c:4045
 __alloc_skb+0x2b1/0x380 net/core/skbuff.c:656
 alloc_skb include/linux/skbuff.h:1308 [inline]
 alloc_skb_with_frags+0xe4/0x710 net/core/skbuff.c:6504
 sock_alloc_send_pskb+0x7f1/0x980 net/core/sock.c:2794
 packet_alloc_skb net/packet/af_packet.c:2929 [inline]
 packet_snd net/packet/af_packet.c:3023 [inline]
 packet_sendmsg+0x1e25/0x51e0 net/packet/af_packet.c:3112
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg net/socket.c:745 [inline]
 __sys_sendto+0x47f/0x4e0 net/socket.c:2192
 __do_sys_sendto net/socket.c:2204 [inline]
 __se_sys_sendto net/socket.c:2200 [inline]
 __x64_sys_sendto+0xe0/0x1c0 net/socket.c:2200
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 10652:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:579
 poison_slab_object+0xf7/0x160 mm/kasan/common.c:240
 __kasan_slab_free+0x32/0x50 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2196 [inline]
 slab_free mm/slub.c:4438 [inline]
 kmem_cache_free+0x12f/0x3a0 mm/slub.c:4513
 kfree_skbmem+0x10e/0x200 net/core/skbuff.c:1131
 __kfree_skb net/core/skbuff.c:1188 [inline]
 kfree_skb_reason+0x138/0x210 net/core/skbuff.c:1223
 kfree_skb include/linux/skbuff.h:1257 [inline]
 ____dev_forward_skb include/linux/netdevice.h:3999 [inline]
 __dev_forward_skb2+0x2d7/0x750 net/core/dev.c:2183
 veth_forward_skb drivers/net/veth.c:320 [inline]
 veth_xmit+0x2ac/0xad0 drivers/net/veth.c:375
 __netdev_start_xmit include/linux/netdevice.h:4882 [inline]
 netdev_start_xmit include/linux/netdevice.h:4896 [inline]
 xmit_one net/core/dev.c:3578 [inline]
 dev_hard_start_xmit+0x143/0x790 net/core/dev.c:3594
 __dev_queue_xmit+0x7ba/0x4130 net/core/dev.c:4393
 dev_queue_xmit include/linux/netdevice.h:3095 [inline]
 team_dev_queue_xmit include/linux/if_team.h:242 [inline]
 team_queue_override_transmit drivers/net/team/team_core.c:814 [inline]
 team_xmit+0x194/0x470 drivers/net/team/team_core.c:1719
 __netdev_start_xmit include/linux/netdevice.h:4882 [inline]
 netdev_start_xmit include/linux/netdevice.h:4896 [inline]
 __dev_direct_xmit+0x59e/0x740 net/core/dev.c:4449
 dev_direct_xmit include/linux/netdevice.h:3108 [inline]
 packet_xmit+0x1e4/0x360 net/packet/af_packet.c:285
 packet_snd net/packet/af_packet.c:3080 [inline]
 packet_sendmsg+0x24a5/0x51e0 net/packet/af_packet.c:3112
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg net/socket.c:745 [inline]
 __sys_sendto+0x47f/0x4e0 net/socket.c:2192
 __do_sys_sendto net/socket.c:2204 [inline]
 __se_sys_sendto net/socket.c:2200 [inline]
 __x64_sys_sendto+0xe0/0x1c0 net/socket.c:2200
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88802cdde280
 which belongs to the cache skbuff_head_cache of size 240
The buggy address is located 228 bytes inside of
 freed 240-byte region [ffff88802cdde280, ffff88802cdde370)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x2cdde
head: order:1 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
memcg:ffff88803f831801
anon flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffefff(slab)
raw: 00fff00000000040 ffff888019298780 0000000000000000 dead000000000001
raw: 0000000000000000 0000000080190019 00000001ffffefff ffff88803f831801
head: 00fff00000000040 ffff888019298780 0000000000000000 dead000000000001
head: 0000000000000000 0000000080190019 00000001ffffefff ffff88803f831801
head: 00fff00000000001 ffffea0000b37781 ffffffffffffffff 0000000000000000
head: 0000000000000002 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 1, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 4913, tgid 4913 (dhcpcd), ts 35329000207, free_ts 32097151920
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x2d1/0x350 mm/page_alloc.c:1473
 prep_new_page mm/page_alloc.c:1481 [inline]
 get_page_from_freelist+0x1353/0x2e50 mm/page_alloc.c:3425
 __alloc_pages_noprof+0x22b/0x2460 mm/page_alloc.c:4683
 __alloc_pages_node_noprof include/linux/gfp.h:269 [inline]
 alloc_pages_node_noprof include/linux/gfp.h:296 [inline]
 alloc_slab_page+0x56/0x110 mm/slub.c:2265
 allocate_slab mm/slub.c:2428 [inline]
 new_slab+0x84/0x260 mm/slub.c:2481
 ___slab_alloc+0xdac/0x1870 mm/slub.c:3667
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3757
 __slab_alloc_node mm/slub.c:3810 [inline]
 slab_alloc_node mm/slub.c:3990 [inline]
 kmem_cache_alloc_node_noprof+0xed/0x310 mm/slub.c:4045
 __alloc_skb+0x2b1/0x380 net/core/skbuff.c:656
 alloc_skb include/linux/skbuff.h:1308 [inline]
 alloc_skb_with_frags+0xe4/0x710 net/core/skbuff.c:6504
 sock_alloc_send_pskb+0x7f1/0x980 net/core/sock.c:2794
 unix_dgram_sendmsg+0x4b8/0x1a60 net/unix/af_unix.c:1976
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg net/socket.c:745 [inline]
 sock_write_iter+0x50a/0x5c0 net/socket.c:1160
 do_iter_readv_writev+0x504/0x780 fs/read_write.c:741
 vfs_writev+0x36f/0xde0 fs/read_write.c:971
 do_writev+0x287/0x370 fs/read_write.c:1018
page last free pid 4857 tgid 4857 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1093 [inline]
 free_unref_page+0x64a/0xe40 mm/page_alloc.c:2588
 rcu_do_batch kernel/rcu/tree.c:2535 [inline]
 rcu_core+0x828/0x16b0 kernel/rcu/tree.c:2809
 handle_softirqs+0x216/0x8f0 kernel/softirq.c:554
 __do_softirq kernel/softirq.c:588 [inline]
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu kernel/softirq.c:637 [inline]
 irq_exit_rcu+0xbb/0x120 kernel/softirq.c:649
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
 sysvec_apic_timer_interrupt+0x95/0xb0 arch/x86/kernel/apic/apic.c:1043
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702

Memory state around the buggy address:
 ffff88802cdde200: fb fb fb fb fb fb fc fc fc fc fc fc fc fc fc fc
 ffff88802cdde280: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88802cdde300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fc fc
                                                       ^
 ffff88802cdde380: fc fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb
 ffff88802cdde400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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

