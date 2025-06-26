Return-Path: <netdev+bounces-201671-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B57CAEA667
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 21:25:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5471F3A9C2F
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 19:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57CB82ECE8C;
	Thu, 26 Jun 2025 19:25:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3D52F1FF9
	for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 19:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750965941; cv=none; b=GvGAyMCBzp9O8RbVZgkxSSh8CxqXPgfpl9bYPyacX8fIyhjR/8N9t/SNxrwSYp17s16UwC9Ob/wZkhxuENCFaTmIyXC1IFoRE5HmQBNkQoIPiKY8KvSwfKazKy44vmHmEspDRaPmsIjhjZRN5/ub73YyAKYpA+eJDVpB9nETv20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750965941; c=relaxed/simple;
	bh=Umg9+xD0kUpefrULO9831amcm/kvWphY/2gpXmp9WX8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=A8NHiPnEnPU2QY7xU3bQXd0zA2HWrUpN8FPqYBZtOBcs862PB4pSgT/Qp0+QyWFL91LfyZdqRMtaZdonDfdUqvCM8s16NFoE0eGOTzdbBsurPvHIAmtclE8nL8HTB7Th0JDSf7fe1behbe99RwHsEGIeSKC07MNa/tpVOZLTWg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3ddc1af1e5bso32500095ab.0
        for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 12:25:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750965937; x=1751570737;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3ITL/fXLs649CrWs1OxmddlKSg0ISConOPnCKE3Uc0g=;
        b=apj70UjPlFrJXKJ3fqE+5BZ0uV45GVTQfwVX8r7FlK3+1SK3YdsCYmupN+Yvwx/diX
         RYAytyP3YlSj8Ywio+jhIhKBtJIAC2PGAE6PyMLU8+jRHcoyU9L+ixmgqYvtZpCUTF6Q
         y2mxBt5n7cSbSmEAmXCB2vNlZwxBLULAj1lNnyem9FcU/keAG0SmNP8C99z9Lt8eSWap
         OGKCHa+2JmdOchoXVfR4yXI3vCUgK9bu9LHfHvWdbUBXhiBFOxvAB0wLz4mbgEHCsSME
         DqhTVTW4mUuEHyrEuiZOevjYmzJD2L0mIRtZe+VBl20qbbR7Q2oZ1pdlm44PDH4LLeWr
         Cq5w==
X-Forwarded-Encrypted: i=1; AJvYcCWfuu+EVoq0DnYYWKeftLc3lBsEpSD40GjRoNRDf7r17oe4GOCoJp51/44Y3LlIchUFdkg9gcI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFr/BXLzl1P9VAsJPDeatZDc9IUY1k1+gVPE0xQK6dZ31+T0Cs
	l/ewzVeP8HPy/6gaIAoCzEK5cBuWslQiDTrs8RWwnK8HHzsYEH5pSveiGcMzqAXN4hKR4KKi9+G
	G4gklVzoWeAdiPxhePYejUcF4PR6I5TrS2MySz1tUqa41aIZGQwX3ZWt7smA=
X-Google-Smtp-Source: AGHT+IEJN4dCnr7Yao52pOFWF+7HitZJ86CXiJ62npUrAP/MiC1G18NaAytAFBNKFR5Jb9TrredgrLEYmVQn9OY/eEzaevPxhIdj
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:318f:b0:3dc:7d57:30a8 with SMTP id
 e9e14a558f8ab-3df4aba4e14mr8321715ab.10.1750965937642; Thu, 26 Jun 2025
 12:25:37 -0700 (PDT)
Date: Thu, 26 Jun 2025 12:25:37 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <685d9eb1.050a0220.2303ee.02a7.GAE@google.com>
Subject: [syzbot] [net?] KASAN: slab-out-of-bounds Read in pause_parse_request
From: syzbot <syzbot+430f9f76633641a62217@syzkaller.appspotmail.com>
To: andrew@lunn.ch, danieller@nvidia.com, davem@davemloft.net, 
	edumazet@google.com, horms@kernel.org, kory.maincent@bootlin.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, maxime.chevallier@bootlin.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    a9b24b3583ae net: phy: realtek: add error handling to rtl8..
git tree:       net-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=15d50f0c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fab0bcec5be1995b
dashboard link: https://syzkaller.appspot.com/bug?extid=430f9f76633641a62217
compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17d1b182580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=120bff0c580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9205e4571dc2/disk-a9b24b35.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9a698a98f3a1/vmlinux-a9b24b35.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5964c8e14f44/bzImage-a9b24b35.xz

The issue was bisected to:

commit 963781bdfe2007e062e05b6b8a263ae9340bd523
Author: Jakub Kicinski <kuba@kernel.org>
Date:   Mon Jun 23 23:17:15 2025 +0000

    net: ethtool: call .parse_request for SET handlers

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=101f208c580000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=121f208c580000
console output: https://syzkaller.appspot.com/x/log.txt?x=141f208c580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+430f9f76633641a62217@syzkaller.appspotmail.com
Fixes: 963781bdfe20 ("net: ethtool: call .parse_request for SET handlers")

==================================================================
BUG: KASAN: slab-out-of-bounds in pause_parse_request+0x40/0x160 net/ethtool/pause.c:37
Read of size 8 at addr ffff888034301530 by task syz-executor369/5848

CPU: 1 UID: 0 PID: 5848 Comm: syz-executor369 Not tainted 6.16.0-rc2-syzkaller-00867-ga9b24b3583ae #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:408 [inline]
 print_report+0xd2/0x2b0 mm/kasan/report.c:521
 kasan_report+0x118/0x150 mm/kasan/report.c:634
 pause_parse_request+0x40/0x160 net/ethtool/pause.c:37
 ethnl_default_parse net/ethtool/netlink.c:456 [inline]
 ethnl_default_set_doit+0x2c1/0xa40 net/ethtool/netlink.c:881
 genl_family_rcv_msg_doit+0x215/0x300 net/netlink/genetlink.c:1115
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0x60e/0x790 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x205/0x470 net/netlink/af_netlink.c:2534
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
 netlink_unicast+0x758/0x8d0 net/netlink/af_netlink.c:1339
 netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1883
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
RIP: 0033:0x7f99cc8969d9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffdf8e93908 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f99cc8e44ad RCX: 00007f99cc8969d9
RDX: 0000000000000040 RSI: 0000200000000000 RDI: 0000000000000003
RBP: 00007f99cc8e447d R08: 0000000000000000 R09: 0000555500000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f99cc8e43e5
R13: 0000000000000001 R14: 00007ffdf8e93950 R15: 0000000000000003
 </TASK>

Allocated by task 5848:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __do_kmalloc_node mm/slub.c:4328 [inline]
 __kmalloc_noprof+0x27a/0x4f0 mm/slub.c:4340
 kmalloc_noprof include/linux/slab.h:909 [inline]
 kmalloc_array_noprof include/linux/slab.h:948 [inline]
 genl_family_rcv_msg_attrs_parse+0xa3/0x2a0 net/netlink/genetlink.c:940
 genl_family_rcv_msg_doit+0xb8/0x300 net/netlink/genetlink.c:1093
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0x60e/0x790 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x205/0x470 net/netlink/af_netlink.c:2534
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
 netlink_unicast+0x758/0x8d0 net/netlink/af_netlink.c:1339
 netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1883
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

The buggy address belongs to the object at ffff888034301500
 which belongs to the cache kmalloc-64 of size 64
The buggy address is located 8 bytes to the right of
 allocated 40-byte region [ffff888034301500, ffff888034301528)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x34301
ksm flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000000 ffff88801a4418c0 ffffea00009e8e40 dead000000000003
raw: 0000000000000000 0000000080200020 00000000f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 1153, tgid 1153 (kworker/u8:6), ts 27371323863, free_ts 0
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
 lsm_blob_alloc security/security.c:684 [inline]
 lsm_task_alloc security/security.c:771 [inline]
 security_task_alloc+0x4d/0x360 security/security.c:3160
 copy_process+0x1530/0x3c00 kernel/fork.c:2151
 kernel_clone+0x21e/0x870 kernel/fork.c:2599
 user_mode_thread+0xdd/0x140 kernel/fork.c:2677
 call_usermodehelper_exec_work+0x5c/0x230 kernel/umh.c:171
 process_one_work kernel/workqueue.c:3238 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3321
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3402
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3f9/0x770 arch/x86/kernel/process.c:148
page_owner free stack trace missing

Memory state around the buggy address:
 ffff888034301400: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
 ffff888034301480: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
>ffff888034301500: 00 00 00 00 00 fc fc fc fc fc fc fc fc fc fc fc
                                     ^
 ffff888034301580: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
 ffff888034301600: 00 00 00 00 00 00 05 fc fc fc fc fc fc fc fc fc
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

