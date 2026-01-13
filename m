Return-Path: <netdev+bounces-249233-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0006AD16197
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 01:59:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E9E893016FA1
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 00:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B79223D7CD;
	Tue, 13 Jan 2026 00:59:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f77.google.com (mail-ot1-f77.google.com [209.85.210.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C65CE55A
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 00:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768265964; cv=none; b=l3X5Ep8sh03yWFQKBn9lHy1xvTfY8yDzYfMwYo+F+TgG1YRhhnqi0NvQfxpgg678HZrvPcvbgYfuDsB2b3ClynkfHCnkj1wWne2EysIPDKNoBxAiEGAC/Gr5dMEz4aiTVNLGO8RIlYmj4BD15ul3JeU/kDtxQ1g13w8S6cMTrH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768265964; c=relaxed/simple;
	bh=QB5OxD4Akw6T2JMYtdZ2pT+s1Afel+hjScw04arwe4I=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=blc5lYMMFJIjt34CO8bxtVBVFIpAnq7hJFqrR9tj2KbN4AUtF7efYWlG7Nr5Q9+o+swjo02fFzUXjwrvi5KmTo2p+XTBbxCj53SjVrqr6I8px0/NijNrrKIT1QcwHHkxte0xZDBpOjJcWeXmyKifc/ihN4qqhtNDlClqSQfixZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f77.google.com with SMTP id 46e09a7af769-7c7599a6f1fso23111954a34.1
        for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 16:59:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768265961; x=1768870761;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=No6JZShL+wn3k0b2/K63dz48Tc13vc4J68M+7YWX+Ro=;
        b=JUYZ55mgIqKoQrc6SaUnUTkolplEbukOqE7tlJKYBc/98dQ2nvlGLIZVH94tMTfUYS
         mftN1MNuH13+J6CbKPzDQem2nKFE38OjCBdxkL3iju8esOr8N/8vLDZbUAbkQq1aaX5H
         3cCkdJBp7kOSaOKXhqiiokSh/4IttemR19+nB/gWqtGZpneM2V51JCaTAPvWS0RkiryC
         yUGzIzBevcrv0sI19Bvm3UJlieE16fPpEixITgExe7CQKxe7TLvqmADMbLKrpNNNXGq8
         NMT0jQw9jgYbp129Tq13cCPaYp/Gply9MCegl94BaskOehBO74mc1dCyBPdBynUwliV1
         oekg==
X-Forwarded-Encrypted: i=1; AJvYcCWETtq1yvKI2eDbg3kS1QJQRm33lCxW8OgtfESA2AXPK28sdkCDWEPUT1XIo4je8kzI42ZT4Yc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiAYng1W+QbmRTGvF2IGnkz5PtT48IMwMTy1vmeguVxJC0I7Ke
	qz1xwZE+Ctit/66HIsbOAHfkkuNkxiIYFvlz4ssSDL3OVvqek5h62+VpoJiv2Qoy+63evOCd07j
	pxGIwbslfUX+611dVp0a7aQGgwkQMGUMNslEz0kQstsGk1LLPhWqPPZ+M4ko=
X-Google-Smtp-Source: AGHT+IHc0bDDVHtFUHn/crFtJd33NcQUtfNR/SEAdafxpUdeFkbX8HeGrtLxu4ZYEhcPu+JOJRHP63kXgt7Te35Wm02S1sQwG+NE
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:f002:b0:659:9a49:8f50 with SMTP id
 006d021491bc7-65f54ee5e8amr9737666eaf.21.1768265961291; Mon, 12 Jan 2026
 16:59:21 -0800 (PST)
Date: Mon, 12 Jan 2026 16:59:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <696598e9.050a0220.3be5c5.0009.GAE@google.com>
Subject: [syzbot] [net?] KASAN: slab-use-after-free Read in inet6_addr_del (2)
From: syzbot <syzbot+72e610f4f1a930ca9d8a@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    a110f942672c Merge tag 'pinctrl-v6.19-1' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14169992580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dbcb767d1e1208ac
dashboard link: https://syzkaller.appspot.com/bug?extid=72e610f4f1a930ca9d8a
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ae0838f12db5/disk-a110f942.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1f4b92355ba4/vmlinux-a110f942.xz
kernel image: https://storage.googleapis.com/syzbot-assets/76fe2a95853e/bzImage-a110f942.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+72e610f4f1a930ca9d8a@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in inet6_addr_del.constprop.0+0x67a/0x6b0 net/ipv6/addrconf.c:3117
Read of size 4 at addr ffff88807b89c86c by task syz.3.1618/9593

CPU: 0 UID: 0 PID: 9593 Comm: syz.3.1618 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xcd/0x630 mm/kasan/report.c:482
 kasan_report+0xe0/0x110 mm/kasan/report.c:595
 inet6_addr_del.constprop.0+0x67a/0x6b0 net/ipv6/addrconf.c:3117
 addrconf_del_ifaddr+0x11e/0x190 net/ipv6/addrconf.c:3181
 inet6_ioctl+0x1e5/0x2b0 net/ipv6/af_inet6.c:582
 sock_do_ioctl+0x118/0x280 net/socket.c:1254
 sock_ioctl+0x227/0x6b0 net/socket.c:1375
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl fs/ioctl.c:583 [inline]
 __x64_sys_ioctl+0x18e/0x210 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f164cf8f749
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f164de64038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f164d1e5fa0 RCX: 00007f164cf8f749
RDX: 0000200000000000 RSI: 0000000000008936 RDI: 0000000000000003
RBP: 00007f164d013f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f164d1e6038 R14: 00007f164d1e5fa0 R15: 00007ffde15c8288
 </TASK>

Allocated by task 9593:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:56
 kasan_save_track+0x14/0x30 mm/kasan/common.c:77
 poison_kmalloc_redzone mm/kasan/common.c:397 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:414
 kmalloc_noprof include/linux/slab.h:957 [inline]
 kzalloc_noprof include/linux/slab.h:1094 [inline]
 ipv6_add_addr+0x4e3/0x2010 net/ipv6/addrconf.c:1120
 inet6_addr_add+0x256/0x9b0 net/ipv6/addrconf.c:3050
 addrconf_add_ifaddr+0x1fc/0x450 net/ipv6/addrconf.c:3160
 inet6_ioctl+0x103/0x2b0 net/ipv6/af_inet6.c:580
 sock_do_ioctl+0x118/0x280 net/socket.c:1254
 sock_ioctl+0x227/0x6b0 net/socket.c:1375
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl fs/ioctl.c:583 [inline]
 __x64_sys_ioctl+0x18e/0x210 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 6099:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:56
 kasan_save_track+0x14/0x30 mm/kasan/common.c:77
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:252 [inline]
 __kasan_slab_free+0x5f/0x80 mm/kasan/common.c:284
 kasan_slab_free include/linux/kasan.h:234 [inline]
 slab_free_hook mm/slub.c:2540 [inline]
 slab_free_freelist_hook mm/slub.c:2569 [inline]
 slab_free_bulk mm/slub.c:6696 [inline]
 kmem_cache_free_bulk mm/slub.c:7383 [inline]
 kmem_cache_free_bulk+0x2bf/0x680 mm/slub.c:7362
 kfree_bulk include/linux/slab.h:830 [inline]
 kvfree_rcu_bulk+0x1b7/0x1e0 mm/slab_common.c:1523
 kvfree_rcu_drain_ready mm/slab_common.c:1728 [inline]
 kfree_rcu_monitor+0x1d0/0x2f0 mm/slab_common.c:1801
 process_one_work+0x9ba/0x1b20 kernel/workqueue.c:3257
 process_scheduled_works kernel/workqueue.c:3340 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3421
 kthread+0x3c5/0x780 kernel/kthread.c:463
 ret_from_fork+0x983/0xb10 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246

Last potentially related work creation:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:56
 kasan_record_aux_stack+0xa7/0xc0 mm/kasan/generic.c:556
 kvfree_call_rcu+0x6a/0x4e0 mm/slab_common.c:1994
 inet6_ifa_finish_destroy+0x140/0x1e0 net/ipv6/addrconf.c:1000
 in6_ifa_put include/net/addrconf.h:461 [inline]
 ipv6_del_addr+0x896/0xb30 net/ipv6/addrconf.c:1349
 inet6_addr_del.constprop.0+0x282/0x6b0 net/ipv6/addrconf.c:3115
 addrconf_del_ifaddr+0x11e/0x190 net/ipv6/addrconf.c:3181
 inet6_ioctl+0x1e5/0x2b0 net/ipv6/af_inet6.c:582
 sock_do_ioctl+0x118/0x280 net/socket.c:1254
 sock_ioctl+0x227/0x6b0 net/socket.c:1375
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl fs/ioctl.c:583 [inline]
 __x64_sys_ioctl+0x18e/0x210 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Second to last potentially related work creation:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:56
 kasan_record_aux_stack+0xa7/0xc0 mm/kasan/generic.c:556
 insert_work+0x36/0x230 kernel/workqueue.c:2180
 __queue_work+0x94f/0x10e0 kernel/workqueue.c:2335
 __queue_delayed_work+0x35b/0x460 kernel/workqueue.c:2503
 mod_delayed_work_on+0x198/0x1c0 kernel/workqueue.c:2591
 mod_delayed_work include/linux/workqueue.h:699 [inline]
 addrconf_mod_dad_work+0x8c/0x150 net/ipv6/addrconf.c:339
 addrconf_dad_start net/ipv6/addrconf.c:4173 [inline]
 addrconf_dad_start net/ipv6/addrconf.c:4161 [inline]
 inet6_addr_add+0x383/0x9b0 net/ipv6/addrconf.c:3068
 addrconf_add_ifaddr+0x1fc/0x450 net/ipv6/addrconf.c:3160
 inet6_ioctl+0x103/0x2b0 net/ipv6/af_inet6.c:580
 sock_do_ioctl+0x118/0x280 net/socket.c:1254
 sock_ioctl+0x227/0x6b0 net/socket.c:1375
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl fs/ioctl.c:583 [inline]
 __x64_sys_ioctl+0x18e/0x210 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88807b89c800
 which belongs to the cache kmalloc-cg-512 of size 512
The buggy address is located 108 bytes inside of
 freed 512-byte region [ffff88807b89c800, ffff88807b89ca00)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x7b89c
head: order:2 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
memcg:ffff88805559fe01
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88813ff30140 ffffea0000c49900 dead000000000002
raw: 0000000000000000 0000000080100010 00000000f5000000 ffff88805559fe01
head: 00fff00000000040 ffff88813ff30140 ffffea0000c49900 dead000000000002
head: 0000000000000000 0000000080100010 00000000f5000000 ffff88805559fe01
head: 00fff00000000002 ffffea0001ee2701 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000004
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 2, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5189, tgid 5189 (udevd), ts 20059180632, free_ts 16612593231
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1af/0x220 mm/page_alloc.c:1846
 prep_new_page mm/page_alloc.c:1854 [inline]
 get_page_from_freelist+0xd0b/0x31a0 mm/page_alloc.c:3915
 __alloc_frozen_pages_noprof+0x25f/0x2430 mm/page_alloc.c:5210
 alloc_pages_mpol+0x1fb/0x550 mm/mempolicy.c:2486
 alloc_slab_page mm/slub.c:3075 [inline]
 allocate_slab mm/slub.c:3248 [inline]
 new_slab+0x2c3/0x430 mm/slub.c:3302
 ___slab_alloc+0xe18/0x1c90 mm/slub.c:4651
 __slab_alloc.constprop.0+0x63/0x110 mm/slub.c:4774
 __slab_alloc_node mm/slub.c:4850 [inline]
 slab_alloc_node mm/slub.c:5246 [inline]
 __do_kmalloc_node mm/slub.c:5651 [inline]
 __kmalloc_node_track_caller_noprof+0x4d6/0x930 mm/slub.c:5759
 kmalloc_reserve+0xef/0x2c0 net/core/skbuff.c:608
 __alloc_skb+0x186/0x410 net/core/skbuff.c:690
 alloc_skb include/linux/skbuff.h:1383 [inline]
 alloc_skb_with_frags+0xe0/0x860 net/core/skbuff.c:6712
 sock_alloc_send_pskb+0x7f9/0x980 net/core/sock.c:2995
 unix_dgram_sendmsg+0x3bc/0x1830 net/unix/af_unix.c:2130
 sock_sendmsg_nosec net/socket.c:727 [inline]
 __sock_sendmsg net/socket.c:742 [inline]
 sock_write_iter+0x566/0x610 net/socket.c:1195
 new_sync_write fs/read_write.c:593 [inline]
 vfs_write+0x7d3/0x11d0 fs/read_write.c:686
 ksys_write+0x1f8/0x250 fs/read_write.c:738
page last free pid 1 tgid 1 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1395 [inline]
 __free_frozen_pages+0x7df/0x1170 mm/page_alloc.c:2943
 __free_pages mm/page_alloc.c:5329 [inline]
 free_contig_range+0x183/0x4a0 mm/page_alloc.c:7197
 destroy_args+0xb95/0x14e0 mm/debug_vm_pgtable.c:983
 debug_vm_pgtable+0x2220/0x38d0 mm/debug_vm_pgtable.c:1372
 do_one_initcall+0x123/0x680 init/main.c:1378
 do_initcall_level init/main.c:1440 [inline]
 do_initcalls init/main.c:1456 [inline]
 do_basic_setup init/main.c:1475 [inline]
 kernel_init_freeable+0x5c8/0x920 init/main.c:1688
 kernel_init+0x1c/0x2b0 init/main.c:1578
 ret_from_fork+0x983/0xb10 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246

Memory state around the buggy address:
 ffff88807b89c700: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88807b89c780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88807b89c800: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                          ^
 ffff88807b89c880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88807b89c900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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

