Return-Path: <netdev+bounces-192138-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC00ABEA0F
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 04:51:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DA403A9C8E
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 02:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7212019ABC2;
	Wed, 21 May 2025 02:51:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CBF7081C
	for <netdev@vger.kernel.org>; Wed, 21 May 2025 02:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747795893; cv=none; b=UYTggQijfGzEDlIOulRtlOSwt8ym8rUY2fSCoSB2qf1o6sHXcYsaen6KCRg/iBjuHNiBVHrouzLgiqaaVHoHwJef+2BgPEQg59BVqgqn28cu73gYTaI3ewSyExQ+TKRAYvRqYMavtniT8p+Nhhcijpb4se7dLjuq146PkhSxsHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747795893; c=relaxed/simple;
	bh=zwDJLSdTjkXprq4UBNOutFcmfKQp0+IETudRvIPLjs4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=poHZUAs/LAfQUlxer1PTB8BSlQaZmDZL0VFvURX5YIna+cqXTazpN2XK+WtW5BE/lGUSEDfRtBRDrPvyGSecAtnXvoyqjEjG1og4V8zAIRc7Zrj7zzBtjyf23a+YK2h8kQIXJZHBJ2sQbg+ieovdofQEbFrQoaduF7pPOxWHxbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3da707dea42so118449985ab.3
        for <netdev@vger.kernel.org>; Tue, 20 May 2025 19:51:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747795890; x=1748400690;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mU6y9WVRkPwIeGBnRe8ZUcYpEknIdUQ2q6lANUIPsj4=;
        b=P0bT2zGmWmUMw/KvqKWQ4pAER6GhRQ4c02iRIqTFSO19PxQZZ8nxs9HRpuQU54wDcL
         a/WIG2I+F0jEx5iqs/yT4/OXu+1SjPjhSLe5xThXpKIPY+EdZjwIFCwyI3sVzeWgF5wC
         KVlbIbvaEObXYeBTqKlKEiSE61pauGgojg9BsgqxsPqrmWKE731ldtBi2OU/xAKLvx8a
         5PA/se6U/jD0ko9UwuHMbtZSCpRkfLeFNfS2XI/VBvk28NYSMCqPc7sjG7dhiv17CnDN
         xpp1JF/F5Kvt3G8Yo6UkrTrXtfNC40hKTlMAC7N5oXBesCPrfnsJoM6IjndEuPosyMZp
         sIxA==
X-Forwarded-Encrypted: i=1; AJvYcCVi5sVfrTN0zynEHgJP6l5pX3lP5qXs44lTELp360ifDAfRBnRdN90P0VjsaKvIXYCQjp19fbo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3RSOr5UbKw2FNycUBn8BfTp1w+7nrRg/ucHdJgbiodSdpu+4y
	ktaJYPjTe+OP96RQ54SE+mJIuKhHFyebSzllGu2CJdU31+q2yne0iBouRMt7EhwiFfEmxRfiCy1
	tQWU75dkSoTfXQkZkPdKov1h2GxVa0z2doonEBLfMiVdPCQudFjmARkH9aHE=
X-Google-Smtp-Source: AGHT+IH9WE8fElrJ6N1JCTJojW7wWOqdirVg+rozrdGkS5Qm0JI4wNNs+NIFDgjEQOvz+Kd66i+4KGFlR6zSQBVBJYiJ3f84C65c
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2187:b0:3dc:79e5:e6a3 with SMTP id
 e9e14a558f8ab-3dc79e5e8d3mr66360785ab.4.1747795890573; Tue, 20 May 2025
 19:51:30 -0700 (PDT)
Date: Tue, 20 May 2025 19:51:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <682d3fb2.a00a0220.29bc26.0288.GAE@google.com>
Subject: [syzbot] [net?] KASAN: slab-use-after-free Read in fib6_add
From: syzbot <syzbot+7962cbe5cc23ff924bef@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    ebd297a2affa Merge tag 'net-6.15-rc5' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=135989b3980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4d6290f49c6ebe48
dashboard link: https://syzkaller.appspot.com/bug?extid=7962cbe5cc23ff924bef
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-ebd297a2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/562e92866c39/vmlinux-ebd297a2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/91b4520e4a8d/bzImage-ebd297a2.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7962cbe5cc23ff924bef@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in fib6_add_rt2node net/ipv6/ip6_fib.c:1102 [inline]
BUG: KASAN: slab-use-after-free in fib6_add+0x3ced/0x4b60 net/ipv6/ip6_fib.c:1488
Read of size 4 at addr ffff88804f774090 by task syz.5.2065/11622

CPU: 3 UID: 0 PID: 11622 Comm: syz.5.2065 Not tainted 6.15.0-rc4-syzkaller-00147-gebd297a2affa #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:408 [inline]
 print_report+0xc3/0x670 mm/kasan/report.c:521
 kasan_report+0xe0/0x110 mm/kasan/report.c:634
 fib6_add_rt2node net/ipv6/ip6_fib.c:1102 [inline]
 fib6_add+0x3ced/0x4b60 net/ipv6/ip6_fib.c:1488
 __ip6_ins_rt net/ipv6/route.c:1351 [inline]
 ip6_route_add+0x8d/0x1c0 net/ipv6/route.c:3900
 addrconf_add_mroute+0x1dd/0x350 net/ipv6/addrconf.c:2551
 addrconf_add_dev+0x14e/0x1c0 net/ipv6/addrconf.c:2569
 addrconf_dev_config net/ipv6/addrconf.c:3480 [inline]
 addrconf_init_auto_addrs+0x380/0x820 net/ipv6/addrconf.c:3568
 addrconf_notify+0xe93/0x19e0 net/ipv6/addrconf.c:3741
 notifier_call_chain+0xb9/0x410 kernel/notifier.c:85
 call_netdevice_notifiers_info+0xbe/0x140 net/core/dev.c:2176
 call_netdevice_notifiers_extack net/core/dev.c:2214 [inline]
 call_netdevice_notifiers net/core/dev.c:2228 [inline]
 __dev_notify_flags+0x12c/0x2e0 net/core/dev.c:9405
 netif_change_flags+0x108/0x160 net/core/dev.c:9434
 dev_change_flags+0xba/0x250 net/core/dev_api.c:68
 dev_ifsioc+0x148f/0x1ee0 net/core/dev_ioctl.c:565
 dev_ioctl+0x223/0x1060 net/core/dev_ioctl.c:821
 sock_do_ioctl+0x19d/0x280 net/socket.c:1204
 compat_sock_ioctl_trans net/socket.c:3481 [inline]
 compat_sock_ioctl+0x301/0x730 net/socket.c:3507
 __do_compat_sys_ioctl fs/ioctl.c:1004 [inline]
 __se_compat_sys_ioctl fs/ioctl.c:947 [inline]
 __ia32_compat_sys_ioctl+0x24c/0x360 fs/ioctl.c:947
 do_syscall_32_irqs_on arch/x86/entry/syscall_32.c:83 [inline]
 __do_fast_syscall_32+0x73/0x120 arch/x86/entry/syscall_32.c:306
 do_fast_syscall_32+0x32/0x80 arch/x86/entry/syscall_32.c:331
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e
RIP: 0023:0xf710e579
Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000f50dd55c EFLAGS: 00000296 ORIG_RAX: 0000000000000036
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000008914
RDX: 0000000080002280 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000292 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>

Allocated by task 5352:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:394
 kmalloc_noprof include/linux/slab.h:905 [inline]
 kzalloc_noprof include/linux/slab.h:1039 [inline]
 kernfs_fop_open+0x244/0xda0 fs/kernfs/file.c:623
 do_dentry_open+0x741/0x1c10 fs/open.c:956
 vfs_open+0x82/0x3f0 fs/open.c:1086
 do_open fs/namei.c:3880 [inline]
 path_openat+0x1e5e/0x2d40 fs/namei.c:4039
 do_filp_open+0x20b/0x470 fs/namei.c:4066
 do_sys_openat2+0x11b/0x1d0 fs/open.c:1429
 do_sys_open fs/open.c:1444 [inline]
 __do_sys_openat fs/open.c:1460 [inline]
 __se_sys_openat fs/open.c:1455 [inline]
 __x64_sys_openat+0x174/0x210 fs/open.c:1455
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x230 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 5352:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:576
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x51/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2398 [inline]
 slab_free mm/slub.c:4656 [inline]
 kfree+0x2b6/0x4d0 mm/slub.c:4855
 kernfs_fop_release+0x12c/0x1e0 fs/kernfs/file.c:768
 __fput+0x3ff/0xb70 fs/file_table.c:465
 fput_close_sync+0x118/0x260 fs/file_table.c:570
 __do_sys_close fs/open.c:1581 [inline]
 __se_sys_close fs/open.c:1566 [inline]
 __x64_sys_close+0x8b/0x120 fs/open.c:1566
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x230 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88804f774000
 which belongs to the cache kmalloc-512 of size 512
The buggy address is located 144 bytes inside of
 freed 512-byte region [ffff88804f774000, ffff88804f774200)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x4f774
head: order:2 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0x4fff00000000040(head|node=1|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 04fff00000000040 ffff88801b442c80 dead000000000100 dead000000000122
raw: 0000000000000000 0000000000100010 00000000f5000000 0000000000000000
head: 04fff00000000040 ffff88801b442c80 dead000000000100 dead000000000122
head: 0000000000000000 0000000000100010 00000000f5000000 0000000000000000
head: 04fff00000000002 ffffea00013ddd01 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000004
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 2, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5942, tgid 5942 (syz-executor), ts 46379795258, free_ts 46302032095
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x181/0x1b0 mm/page_alloc.c:1718
 prep_new_page mm/page_alloc.c:1726 [inline]
 get_page_from_freelist+0x135c/0x3920 mm/page_alloc.c:3688
 __alloc_frozen_pages_noprof+0x263/0x23a0 mm/page_alloc.c:4970
 alloc_pages_mpol+0x1fb/0x550 mm/mempolicy.c:2301
 alloc_slab_page mm/slub.c:2468 [inline]
 allocate_slab mm/slub.c:2632 [inline]
 new_slab+0x244/0x340 mm/slub.c:2686
 ___slab_alloc+0xd9c/0x1940 mm/slub.c:3872
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3962
 __slab_alloc_node mm/slub.c:4037 [inline]
 slab_alloc_node mm/slub.c:4198 [inline]
 __kmalloc_cache_noprof+0xfb/0x3e0 mm/slub.c:4367
 kmalloc_noprof include/linux/slab.h:905 [inline]
 kzalloc_noprof include/linux/slab.h:1039 [inline]
 device_private_init drivers/base/core.c:3537 [inline]
 device_add+0xccc/0x1a70 drivers/base/core.c:3588
 netdev_register_kobject+0x182/0x3a0 net/core/net-sysfs.c:2336
 register_netdevice+0x13dc/0x2270 net/core/dev.c:11009
 veth_newlink+0x30f/0xa00 drivers/net/veth.c:1818
 rtnl_newlink_create net/core/rtnetlink.c:3833 [inline]
 __rtnl_newlink net/core/rtnetlink.c:3950 [inline]
 rtnl_newlink+0xc42/0x2000 net/core/rtnetlink.c:4065
 rtnetlink_rcv_msg+0x95b/0xe90 net/core/rtnetlink.c:6955
 netlink_rcv_skb+0x16a/0x440 net/netlink/af_netlink.c:2534
 netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
 netlink_unicast+0x53a/0x7f0 net/netlink/af_netlink.c:1339
page last free pid 5949 tgid 5949 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1262 [inline]
 __free_frozen_pages+0x69d/0xff0 mm/page_alloc.c:2725
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x4e/0x120 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x195/0x1e0 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x69/0x90 mm/kasan/common.c:329
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4161 [inline]
 slab_alloc_node mm/slub.c:4210 [inline]
 kmem_cache_alloc_node_noprof+0x1d5/0x3b0 mm/slub.c:4262
 __alloc_skb+0x2b2/0x380 net/core/skbuff.c:658
 alloc_skb include/linux/skbuff.h:1340 [inline]
 nlmsg_new include/net/netlink.h:1019 [inline]
 netlink_ack+0x15d/0xb80 net/netlink/af_netlink.c:2471
 netlink_rcv_skb+0x347/0x440 net/netlink/af_netlink.c:2540
 netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
 netlink_unicast+0x53a/0x7f0 net/netlink/af_netlink.c:1339
 netlink_sendmsg+0x8d1/0xdd0 net/netlink/af_netlink.c:1883
 sock_sendmsg_nosec net/socket.c:712 [inline]
 __sock_sendmsg net/socket.c:727 [inline]
 __sys_sendto+0x495/0x510 net/socket.c:2180
 __do_compat_sys_socketcall net/compat.c:475 [inline]
 __se_compat_sys_socketcall net/compat.c:423 [inline]
 __ia32_compat_sys_socketcall+0x625/0x770 net/compat.c:423
 do_syscall_32_irqs_on arch/x86/entry/syscall_32.c:83 [inline]
 __do_fast_syscall_32+0x73/0x120 arch/x86/entry/syscall_32.c:306
 do_fast_syscall_32+0x32/0x80 arch/x86/entry/syscall_32.c:331
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e

Memory state around the buggy address:
 ffff88804f773f80: 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fc fc
 ffff88804f774000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88804f774080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                         ^
 ffff88804f774100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88804f774180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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

