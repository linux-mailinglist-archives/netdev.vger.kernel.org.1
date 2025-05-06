Return-Path: <netdev+bounces-188420-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D8ADAACCD0
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 20:08:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F1733BE2BF
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 18:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3702C2857F0;
	Tue,  6 May 2025 18:08:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0472857F2
	for <netdev@vger.kernel.org>; Tue,  6 May 2025 18:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746554914; cv=none; b=cegJJk8U7x9UusVOj6m5QlRrfZyNE5PGh/TGI3iFmogK8VnUuNuRFxbfpBfo28ysDdaaxo3CZVxK08uV7iNuuhZVdJWq65CjlmpACJdNZI+nQOAMDdFH3CUWG9FW0I4cLBo3oA7BShzVOnL3c/4G/+7WTobreWgqoDH7w3qYyjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746554914; c=relaxed/simple;
	bh=8+m+Av9/SRnoAzCh6pw3UDvsgdb4FCTciqUbzKakhMk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=KORf0sKpsN9Zb2IrWMWB2nWN7839AhFL6TAuccumGnEqvyfLdrWRq3eVuEcpNp+VAEp+ftUTjdntqvokmSBmTZPp0jjm0r2ZTULpnWswuuMwUK+UmLhZd8weixuJodgCMhPISij1ye8MslL9r1Ryz5D9Dlauef5k0QlrqSxgfGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3da6f284ca5so16356555ab.1
        for <netdev@vger.kernel.org>; Tue, 06 May 2025 11:08:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746554911; x=1747159711;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tgw8YxSg6JUbCUD4cGRPk7UkrP9KAsdDGR4J2IN9dl0=;
        b=M3QVnhpkkVDSijYwaUfQ2Txq94YVifre52/7pGn6tA6LvRP8V63i9dLP1ss+uzRpeV
         txjP6HuAue+WRapSVTbc/xQQJTamWOCwMDIr752uddsJ78q+eEvrz1gQQaoOXgD7nMjJ
         Ype8W5dL2xufZawRw8xG4p2KsPN261cdHC1pGsn8PkGAltf1EzD0eKZErQF9ADYdiOWm
         83T6h+WN9JLfgC3P6Iw3hU/RxXGsQaNUvPBeGddJ6lPmgJx6N3ZGs+vwrseRpSphutCR
         mhy0DnvjggB00yOEGekXxigqJCuyDVmbvrbrs04gKoEijmw0zF46fRyHsO3FDqW2l0Xx
         l/mQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxJOvdZKeI1euLqwi3F8rNg1KozRouLgOP7uAL5YtGiDeCD6uDCAX5238BuIMxnpOTe/JdtOc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtxXoc1ZAO6O7Ub50RN1tCef+/Ufynl9KbL9E0CwCbsjrVa9aM
	S5ClhdVcPcImdmoxQqKa/dAp5I4PnMMc1ehCT7yWqRvd1wqenLYCkw6EqjxdL+pyzwjXAl1AGu3
	6LeuojwWzqYn9ID1/hti7S1iUkUJ5trH78bAIqKOxCwhNsE5x44oo1/4=
X-Google-Smtp-Source: AGHT+IFKeo6UbXLzMauLCXjki7AKOhVqLryhCxoD0W1YRoFCT9cMQs65TYwWVfMfulCsm6j3gyk91P8Q0lynvTe05cnMdclHqQGb
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1707:b0:3d4:244b:db20 with SMTP id
 e9e14a558f8ab-3da7392cb48mr363665ab.16.1746554911410; Tue, 06 May 2025
 11:08:31 -0700 (PDT)
Date: Tue, 06 May 2025 11:08:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <681a501f.050a0220.a19a9.0012.GAE@google.com>
Subject: [syzbot] [net?] KASAN: slab-out-of-bounds Read in arp_mc_map
From: syzbot <syzbot+8cf46b8f1b3551e6b561@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    e0f4c8dd9d2d Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=11cfe8d4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=868079b7b8989c3c
dashboard link: https://syzkaller.appspot.com/bug?extid=8cf46b8f1b3551e6b561
compiler:       Debian clang version 20.1.2 (++20250402124445+58df0ef89dd6-1~exp1~20250402004600.97), Debian LLD 20.1.2
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/463c704c2ee6/disk-e0f4c8dd.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1bb99dd967d9/vmlinux-e0f4c8dd.xz
kernel image: https://storage.googleapis.com/syzbot-assets/505fe552b9a8/Image-e0f4c8dd.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8cf46b8f1b3551e6b561@syzkaller.appspotmail.com

veth1_vlan: left promiscuous mode
veth0_vlan: left promiscuous mode
==================================================================
BUG: KASAN: slab-out-of-bounds in arp_mc_map+0x418/0x668 net/ipv4/arp.c:189
Read of size 2 at addr ffff0000c86e7618 by task kworker/u8:12/7248

CPU: 0 UID: 0 PID: 7248 Comm: kworker/u8:12 Not tainted 6.15.0-rc4-syzkaller-ge0f4c8dd9d2d #0 PREEMPT 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
Workqueue: netns cleanup_net
Call trace:
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:466 (C)
 __dump_stack+0x30/0x40 lib/dump_stack.c:94
 dump_stack_lvl+0xd8/0x12c lib/dump_stack.c:120
 print_address_description+0xa8/0x254 mm/kasan/report.c:408
 print_report+0x68/0x84 mm/kasan/report.c:521
 kasan_report+0xb0/0x110 mm/kasan/report.c:634
 __asan_report_load2_noabort+0x20/0x2c mm/kasan/report_generic.c:379
 arp_mc_map+0x418/0x668 net/ipv4/arp.c:189
 ip_mc_filter_del net/ipv4/igmp.c:1170 [inline]
 __igmp_group_dropped+0x14c/0x658 net/ipv4/igmp.c:1304
 igmp_group_dropped net/ipv4/igmp.c:1335 [inline]
 ip_mc_down+0x130/0x3b8 net/ipv4/igmp.c:1829
 inetdev_event+0x228/0x13dc net/ipv4/devinet.c:1642
 notifier_call_chain+0x1b8/0x4e4 kernel/notifier.c:85
 raw_notifier_call_chain+0x3c/0x50 kernel/notifier.c:453
 call_netdevice_notifiers_info net/core/dev.c:2176 [inline]
 call_netdevice_notifiers_extack net/core/dev.c:2214 [inline]
 call_netdevice_notifiers net/core/dev.c:2228 [inline]
 dev_close_many+0x2d4/0x448 net/core/dev.c:1731
 unregister_netdevice_many_notify+0x664/0x1fbc net/core/dev.c:11952
 unregister_netdevice_many net/core/dev.c:12046 [inline]
 default_device_exit_batch+0x838/0x8b4 net/core/dev.c:12538
 ops_exit_list net/core/net_namespace.c:177 [inline]
 cleanup_net+0x650/0x9c0 net/core/net_namespace.c:654
 process_one_work+0x7e8/0x156c kernel/workqueue.c:3238
 process_scheduled_works kernel/workqueue.c:3319 [inline]
 worker_thread+0x958/0xed8 kernel/workqueue.c:3400
 kthread+0x5fc/0x75c kernel/kthread.c:464
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:862

Allocated by task 6490:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x40/0x78 mm/kasan/common.c:68
 kasan_save_alloc_info+0x44/0x54 mm/kasan/generic.c:562
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0x9c/0xb4 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __kmalloc_cache_noprof+0x2a4/0x3fc mm/slub.c:4372
 kmalloc_noprof include/linux/slab.h:905 [inline]
 kzalloc_noprof include/linux/slab.h:1039 [inline]
 binderfs_binder_device_create+0x174/0x9d0 drivers/android/binderfs.c:147
 binderfs_fill_super+0x7c8/0xc54 drivers/android/binderfs.c:730
 vfs_get_super fs/super.c:1280 [inline]
 get_tree_nodev+0xb4/0x144 fs/super.c:1299
 binderfs_fs_context_get_tree+0x28/0x38 drivers/android/binderfs.c:750
 vfs_get_tree+0x90/0x28c fs/super.c:1759
 do_new_mount+0x228/0x814 fs/namespace.c:3884
 path_mount+0x5b4/0xde0 fs/namespace.c:4211
 do_mount fs/namespace.c:4224 [inline]
 __do_sys_mount fs/namespace.c:4435 [inline]
 __se_sys_mount fs/namespace.c:4412 [inline]
 __arm64_sys_mount+0x3e8/0x468 fs/namespace.c:4412
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:744
 el0t_64_sync_handler+0x78/0x108 arch/arm64/kernel/entry-common.c:762
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600

The buggy address belongs to the object at ffff0000c86e7400
 which belongs to the cache kmalloc-512 of size 512
The buggy address is located 256 bytes to the right of
 allocated 280-byte region [ffff0000c86e7400, ffff0000c86e7518)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1086e4
head: order:2 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
anon flags: 0x5ffc00000000040(head|node=0|zone=2|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 05ffc00000000040 ffff0000c0001c80 0000000000000000 dead000000000001
raw: 0000000000000000 0000000000100010 00000000f5000000 0000000000000000
head: 05ffc00000000040 ffff0000c0001c80 0000000000000000 dead000000000001
head: 0000000000000000 0000000000100010 00000000f5000000 0000000000000000
head: 05ffc00000000002 fffffdffc321b901 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000004
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff0000c86e7500: 00 00 00 fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff0000c86e7580: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff0000c86e7600: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                            ^
 ffff0000c86e7680: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff0000c86e7700: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================
Unable to handle kernel paging request at virtual address dfff800000000006
KASAN: null-ptr-deref in range [0x0000000000000030-0x0000000000000037]
Mem abort info:
  ESR = 0x0000000096000005
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x05: level 1 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000005, ISS2 = 0x00000000
  CM = 0, WnR = 0, TnD = 0, TagAccess = 0
  GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[dfff800000000006] address between user and kernel address ranges
Internal error: Oops: 0000000096000005 [#1]  SMP
Modules linked in:
CPU: 0 UID: 0 PID: 7248 Comm: kworker/u8:12 Tainted: G    B               6.15.0-rc4-syzkaller-ge0f4c8dd9d2d #0 PREEMPT 
Tainted: [B]=BAD_PAGE
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
Workqueue: netns cleanup_net
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : read_pnet include/net/net_namespace.h:409 [inline]
pc : sock_net include/net/sock.h:664 [inline]
pc : netlink_broadcast_filtered+0x58/0x10c4 net/netlink/af_netlink.c:1497
lr : read_pnet include/net/net_namespace.h:409 [inline]
lr : sock_net include/net/sock.h:664 [inline]
lr : netlink_broadcast_filtered+0x54/0x10c4 net/netlink/af_netlink.c:1497
sp : ffff8000a0a67100
x29: ffff8000a0a671a0 x28: 1fffe00018d17a04 x27: 0000000000000000
x26: dfff800000000000 x25: 0000000000000cc0 x24: 0000000000000000
x23: 0000000000000000 x22: 0000000000000025 x21: 0000000000000000
x20: ffff0000ce0d7a00 x19: 0000000000000030 x18: 1fffe0003670d276
x17: 0000000000000000 x16: ffff80008ad0f308 x15: 0000000000000003
x14: 1fffe0001f36c47c x13: 0000153c0000153c x12: ffffffffffffffff
x11: ffff60001f36c47f x10: 0000000000ff0100 x9 : 0000000000000000
x8 : 0000000000000006 x7 : 0000153c0000153c x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000cc0 x3 : 0000000000000025
x2 : 0000000000000000 x1 : ffff0000ce0d7a00 x0 : 0000000000000000
Call trace:
 read_pnet include/net/net_namespace.h:409 [inline] (P)
 sock_net include/net/sock.h:664 [inline] (P)
 netlink_broadcast_filtered+0x58/0x10c4 net/netlink/af_netlink.c:1497 (P)
 nlmsg_multicast_filtered include/net/netlink.h:1129 [inline]
 nlmsg_multicast include/net/netlink.h:1148 [inline]
 nlmsg_notify+0xfc/0x1e0 net/netlink/af_netlink.c:2577
 rtnl_notify+0xa0/0xd8 net/core/rtnetlink.c:958
 inet_ifmcaddr_notify+0xd0/0x154 net/ipv4/igmp.c:1495
 __ip_mc_dec_group+0x3f8/0x624 net/ipv4/igmp.c:1778
 ip_mc_dec_group include/linux/igmp.h:138 [inline]
 ip_mc_down+0x2d4/0x3b8 net/ipv4/igmp.c:1840
 inetdev_event+0x228/0x13dc net/ipv4/devinet.c:1642
 notifier_call_chain+0x1b8/0x4e4 kernel/notifier.c:85
 raw_notifier_call_chain+0x3c/0x50 kernel/notifier.c:453
 call_netdevice_notifiers_info net/core/dev.c:2176 [inline]
 call_netdevice_notifiers_extack net/core/dev.c:2214 [inline]
 call_netdevice_notifiers net/core/dev.c:2228 [inline]
 dev_close_many+0x2d4/0x448 net/core/dev.c:1731
 unregister_netdevice_many_notify+0x664/0x1fbc net/core/dev.c:11952
 unregister_netdevice_many net/core/dev.c:12046 [inline]
 default_device_exit_batch+0x838/0x8b4 net/core/dev.c:12538
 ops_exit_list net/core/net_namespace.c:177 [inline]
 cleanup_net+0x650/0x9c0 net/core/net_namespace.c:654
 process_one_work+0x7e8/0x156c kernel/workqueue.c:3238
 process_scheduled_works kernel/workqueue.c:3319 [inline]
 worker_thread+0x958/0xed8 kernel/workqueue.c:3400
 kthread+0x5fc/0x75c kernel/kthread.c:464
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:862
Code: 97b74254 9100c313 9466d945 d343fe68 (387a6908) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	97b74254 	bl	0xfffffffffedd0950
   4:	9100c313 	add	x19, x24, #0x30
   8:	9466d945 	bl	0x19b651c
   c:	d343fe68 	lsr	x8, x19, #3
* 10:	387a6908 	ldrb	w8, [x8, x26] <-- trapping instruction


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

