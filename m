Return-Path: <netdev+bounces-125164-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0330F96C1EB
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 17:13:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 760BE1F23933
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 15:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E670B1DCB26;
	Wed,  4 Sep 2024 15:13:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E211DCB10
	for <netdev@vger.kernel.org>; Wed,  4 Sep 2024 15:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725462806; cv=none; b=XDhK062myE8oI/aPvNxEAKNDvU6m2Xae88r6zBzdykyo22kBSQaqqEr3eaW/C8l0JybDq0zD8wb1ZxowVHaS5MAr9+n2IjPrZKPRibjkPWqdySYcqNuX2F2MD5mIPOvs530hgOVuVMrrv7qeOCPVNay3rBadUwlRD9ZSpSz7Vu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725462806; c=relaxed/simple;
	bh=1lgbOpfRbLm6x+d8PuX9YDcItb+bWKp3MZ1Tbp8qRcw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=TZAe/wXjtde0gJRYgHR8C9NeRqJ1PDVYR0aFezhuOpE8Q2bDXrwAQkI/cKZf6/BQBtawWESxGiiOp6GzugCpJlaT7wszeKXAnZ0KJBLSvKRrK3ZzHah7QT3kRerUQIh2ea5qbhPMTYPgHTkagMKPnY2ymR9ZJQZLkcHPYAiJPHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-39f5328fd5eso51869275ab.2
        for <netdev@vger.kernel.org>; Wed, 04 Sep 2024 08:13:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725462804; x=1726067604;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pBQA4JKaDTbgLhsl+0urfxf4WJTVWLgyH0K5I4j2wRU=;
        b=JIL53JmDCkTuZJ+eXRO4r0RrG4xTzgzr2LhYUgS/+jilka1feXQMyu5qpOTzzH7stR
         LC6Grwo7N3leROSK4Pu+t9ClHVxFaA/3se/EIv7asEO5xt+ny4aFGMwTMZj4ZW45C4KU
         EtpBjJkXmjvONyrmp9IEZe80c/UyH83bnC0pTLEcjDbsRwJxaVyrxfHdNQupdx31bOA/
         LvXmATQ3RIzXJxk5SgaloLwpwC+Jt67IFJxMDBowd9FAA16cNvoc11gwZ3AodEdQ1Hmo
         ZzX2UAIRFk4ab01u/c1qs15cil6h0yG0xzdoBIjfl5jyd7kulKHgf9ANWOTPwmmz2d57
         X1rQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlTuEvquIx2Lhu5chj/+gz3O61Y3gvjn34TR36Eh12JD2TaAVikE3wv/jNuWIF3Gmj+AKRZQo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwE8/fFgxcLnjRkxsOjZuy5xKJCFkZ7QH+rvhG0IW2WTseO9R+9
	whIjn0+AI+ch3mMqRaJZWkXvMc6JyYoKo9HrdEqisYzsoBqQ0iO32oJ0RalP2Ea0PKRVSMRQPCK
	mI677AOyloEPgQS6Ox+r0o5ekeZRNrdxJXlGnGDBm5H2F7evYek1Kxr8=
X-Google-Smtp-Source: AGHT+IGBJ34H/8eTSzW72G+eBGzISgB397RANbXZArwcWceqrj/8tb7MqN8KM1H4xT5l6pbmJ5v6Lif+Zl/jKWutUpfQnrrVx94Y
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:40a3:b0:4b9:ad96:2adc with SMTP id
 8926c6da1cb9f-4d017e9afc4mr1059990173.4.1725462804144; Wed, 04 Sep 2024
 08:13:24 -0700 (PDT)
Date: Wed, 04 Sep 2024 08:13:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000083b05a06214c9ddc@google.com>
Subject: [syzbot] [net?] KASAN: slab-use-after-free Read in
 unix_stream_read_actor (2)
From: syzbot <syzbot+8811381d455e3e9ec788@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    fbdaffe41adc Merge branch 'am-qt2025-phy-rust'
git tree:       net-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=13d7c44d980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=996585887acdadb3
dashboard link: https://syzkaller.appspot.com/bug?extid=8811381d455e3e9ec788
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14b395db980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16d3fc53980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/feaa1b13b490/disk-fbdaffe4.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8e5dccd0377a/vmlinux-fbdaffe4.xz
kernel image: https://storage.googleapis.com/syzbot-assets/75151f74f4c9/bzImage-fbdaffe4.xz

Bisection is inconclusive: the first bad commit could be any of:

06ab21c3cb6e dt-bindings: net: mediatek,net: add top-level constraints
70d16e13368c dt-bindings: net: renesas,etheravb: add top-level constraints

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11d42e63980000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8811381d455e3e9ec788@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in unix_stream_read_actor+0xa6/0xb0 net/unix/af_unix.c:2959
Read of size 4 at addr ffff8880326abcc4 by task syz-executor178/5235

CPU: 0 UID: 0 PID: 5235 Comm: syz-executor178 Not tainted 6.11.0-rc5-syzkaller-00742-gfbdaffe41adc #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 unix_stream_read_actor+0xa6/0xb0 net/unix/af_unix.c:2959
 unix_stream_recv_urg+0x1df/0x320 net/unix/af_unix.c:2640
 unix_stream_read_generic+0x2456/0x2520 net/unix/af_unix.c:2778
 unix_stream_recvmsg+0x22b/0x2c0 net/unix/af_unix.c:2996
 sock_recvmsg_nosec net/socket.c:1046 [inline]
 sock_recvmsg+0x22f/0x280 net/socket.c:1068
 ____sys_recvmsg+0x1db/0x470 net/socket.c:2816
 ___sys_recvmsg net/socket.c:2858 [inline]
 __sys_recvmsg+0x2f0/0x3e0 net/socket.c:2888
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f5360d6b4e9
Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff29b3a458 EFLAGS: 00000246 ORIG_RAX: 000000000000002f
RAX: ffffffffffffffda RBX: 00007fff29b3a638 RCX: 00007f5360d6b4e9
RDX: 0000000000002001 RSI: 0000000020000640 RDI: 0000000000000003
RBP: 00007f5360dde610 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007fff29b3a628 R14: 0000000000000001 R15: 0000000000000001
 </TASK>

Allocated by task 5235:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:312 [inline]
 __kasan_slab_alloc+0x66/0x80 mm/kasan/common.c:338
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3988 [inline]
 slab_alloc_node mm/slub.c:4037 [inline]
 kmem_cache_alloc_node_noprof+0x16b/0x320 mm/slub.c:4080
 __alloc_skb+0x1c3/0x440 net/core/skbuff.c:667
 alloc_skb include/linux/skbuff.h:1320 [inline]
 alloc_skb_with_frags+0xc3/0x770 net/core/skbuff.c:6528
 sock_alloc_send_pskb+0x91a/0xa60 net/core/sock.c:2815
 sock_alloc_send_skb include/net/sock.h:1778 [inline]
 queue_oob+0x108/0x680 net/unix/af_unix.c:2198
 unix_stream_sendmsg+0xd24/0xf80 net/unix/af_unix.c:2351
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:745
 ____sys_sendmsg+0x525/0x7d0 net/socket.c:2597
 ___sys_sendmsg net/socket.c:2651 [inline]
 __sys_sendmsg+0x2b0/0x3a0 net/socket.c:2680
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 5235:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
 poison_slab_object+0xe0/0x150 mm/kasan/common.c:240
 __kasan_slab_free+0x37/0x60 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2252 [inline]
 slab_free mm/slub.c:4473 [inline]
 kmem_cache_free+0x145/0x350 mm/slub.c:4548
 unix_stream_read_generic+0x1ef6/0x2520 net/unix/af_unix.c:2917
 unix_stream_recvmsg+0x22b/0x2c0 net/unix/af_unix.c:2996
 sock_recvmsg_nosec net/socket.c:1046 [inline]
 sock_recvmsg+0x22f/0x280 net/socket.c:1068
 __sys_recvfrom+0x256/0x3e0 net/socket.c:2255
 __do_sys_recvfrom net/socket.c:2273 [inline]
 __se_sys_recvfrom net/socket.c:2269 [inline]
 __x64_sys_recvfrom+0xde/0x100 net/socket.c:2269
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff8880326abc80
 which belongs to the cache skbuff_head_cache of size 240
The buggy address is located 68 bytes inside of
 freed 240-byte region [ffff8880326abc80, ffff8880326abd70)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x326ab
ksm flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xfdffffff(slab)
raw: 00fff00000000000 ffff88801eaee780 ffffea0000b7dc80 dead000000000003
raw: 0000000000000000 00000000800c000c 00000001fdffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 4686, tgid 4686 (udevadm), ts 32357469485, free_ts 28829011109
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
 kmem_cache_alloc_node_noprof+0x1fe/0x320 mm/slub.c:4080
 __alloc_skb+0x1c3/0x440 net/core/skbuff.c:667
 alloc_skb include/linux/skbuff.h:1320 [inline]
 alloc_uevent_skb+0x74/0x230 lib/kobject_uevent.c:289
 uevent_net_broadcast_untagged lib/kobject_uevent.c:326 [inline]
 kobject_uevent_net_broadcast+0x2fd/0x580 lib/kobject_uevent.c:410
 kobject_uevent_env+0x57d/0x8e0 lib/kobject_uevent.c:608
 kobject_synth_uevent+0x4ef/0xae0 lib/kobject_uevent.c:207
 uevent_store+0x4b/0x70 drivers/base/bus.c:633
 kernfs_fop_write_iter+0x3a1/0x500 fs/kernfs/file.c:334
 new_sync_write fs/read_write.c:497 [inline]
 vfs_write+0xa72/0xc90 fs/read_write.c:590
page last free pid 1 tgid 1 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1094 [inline]
 free_unref_page+0xd22/0xea0 mm/page_alloc.c:2612
 kasan_depopulate_vmalloc_pte+0x74/0x90 mm/kasan/shadow.c:408
 apply_to_pte_range mm/memory.c:2797 [inline]
 apply_to_pmd_range mm/memory.c:2841 [inline]
 apply_to_pud_range mm/memory.c:2877 [inline]
 apply_to_p4d_range mm/memory.c:2913 [inline]
 __apply_to_page_range+0x8a8/0xe50 mm/memory.c:2947
 kasan_release_vmalloc+0x9a/0xb0 mm/kasan/shadow.c:525
 purge_vmap_node+0x3e3/0x770 mm/vmalloc.c:2208
 __purge_vmap_area_lazy+0x708/0xae0 mm/vmalloc.c:2290
 _vm_unmap_aliases+0x79d/0x840 mm/vmalloc.c:2885
 change_page_attr_set_clr+0x2fe/0xdb0 arch/x86/mm/pat/set_memory.c:1881
 change_page_attr_set arch/x86/mm/pat/set_memory.c:1922 [inline]
 set_memory_nx+0xf2/0x130 arch/x86/mm/pat/set_memory.c:2110
 free_init_pages arch/x86/mm/init.c:924 [inline]
 free_kernel_image_pages arch/x86/mm/init.c:943 [inline]
 free_initmem+0x79/0x110 arch/x86/mm/init.c:970
 kernel_init+0x31/0x2b0 init/main.c:1476
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Memory state around the buggy address:
 ffff8880326abb80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880326abc00: fb fb fb fb fb fb fc fc fc fc fc fc fc fc fc fc
>ffff8880326abc80: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                           ^
 ffff8880326abd00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fc fc
 ffff8880326abd80: fc fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

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

