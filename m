Return-Path: <netdev+bounces-212077-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 923CFB1DC4F
	for <lists+netdev@lfdr.de>; Thu,  7 Aug 2025 19:06:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 638307B2461
	for <lists+netdev@lfdr.de>; Thu,  7 Aug 2025 17:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38AA5272E6B;
	Thu,  7 Aug 2025 17:05:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54BD813E02D
	for <netdev@vger.kernel.org>; Thu,  7 Aug 2025 17:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754586341; cv=none; b=GgXmsOjK3YW+BeLdvh1xrV8jcxhQlvAeGv5CygIEYLE+A4VQNMbL+VQ89NyhNxLwdusShoCPAfY0ykPbaWjUKgIIZxZ6U4BuKXnnxESMzVKsa1mV9o2jBV2bOyxDi1que7T+TdgwsrFS7WTSrBgn6k9vqWme37ydMDnJ5OvlVrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754586341; c=relaxed/simple;
	bh=OpH+VmOWTeWlhHyubUOQO8A9ywraJL0gvONVJ6EW2QU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ZnCTok20to2MWgqkudLo4Db1U5UAj7ynorfSmE5TN4ZGlG0KVVUG3v2xhapCnCkeixoft7Ed84Rwv9sDs/8NzFrWRwpZ8Xwp1+D7d0Z20/kUkyaF7UPEBk4yDr97KpD3XnmcPYhsP5kAFbLgMX2skoPEWQwAkurfv/QnpFx7hgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-88177c70d63so122894539f.1
        for <netdev@vger.kernel.org>; Thu, 07 Aug 2025 10:05:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754586338; x=1755191138;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3hbCc7AtsWdvPIjN+0jmVfB8z9Bo/thEn64rIMH7468=;
        b=woA80bQ/FsiK+YjbK0Ly8cTbBZoyrcgS1/4b9A69JK/nKgdO7DKlZOspbatO4Tz7/M
         RNHVLc3EdDnazV49osuescuHqhfwPGlJmIUiM2wEuZVVjLdJpU21OhV18cWc0wzL83I0
         vk9G8KExLuqji57EyKm25K9+8UAvfN+HVN1qWpg6THs/9sH8poBMagiejuO3KgXkMtaF
         qv5KsohNd4G6f6SmCOUzizkWEXtBSoYexq0lf5xiKWfZBHwz3jyYaeT8hg/zu2E8hCxh
         OfaSwzaiHKQQslzxD2Zut+FsxCRwNKincMPOFV7ryq9UnSLMH8gsulq9BVlpSHUdCeCa
         HONA==
X-Forwarded-Encrypted: i=1; AJvYcCV4ZMW8ONj7LufnybhTsuQizQK4nY9CS25StsHe/7ztTeSuDuOqH9qo79uah9iV4gCRji5qSF0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj02hbPzA5z+82cGaSWknEAeSW3NgJ8zHlwY3zg3CgCrOTXcvW
	YznBdt4+igz3RfCwOV62PX7yvCvkT2pYs9tx8DrZqEAui3JonOrRAOZcNPpuvbfP8VXLdCDuMyn
	1KiuXXxPRAGh9x5fqSAU+2lu/wNKdlnMEfIycob1DlbQdFQp8XKzy3QL997k=
X-Google-Smtp-Source: AGHT+IH1KGwvGGy0CInwIkKFH4HCXYyl4wJsDnDAR5a7oRQ30bh0MGlNXDCmFVS59wvwzE54ujQ4e9nvwiJ8BfG3cCIVq2C2Gn9b
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1589:b0:87c:72f3:d5d7 with SMTP id
 ca18e2360f4ac-8819f193dcemr1537872439f.13.1754586338204; Thu, 07 Aug 2025
 10:05:38 -0700 (PDT)
Date: Thu, 07 Aug 2025 10:05:38 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6894dce2.050a0220.7f033.0049.GAE@google.com>
Subject: [syzbot] [net?] [nfc?] KMSAN: uninit-value in nci_dev_up (2)
From: syzbot <syzbot+740e04c2a93467a0f8c8@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	krzk@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    89748acdf226 Merge tag 'drm-next-2025-08-01' of https://gi..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=165cfcf0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7ff65239b4835001
dashboard link: https://syzkaller.appspot.com/bug?extid=740e04c2a93467a0f8c8
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10b88042580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=115cfcf0580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ce090dd92dc2/disk-89748acd.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/32b5903a7759/vmlinux-89748acd.xz
kernel image: https://storage.googleapis.com/syzbot-assets/dc68a867773d/bzImage-89748acd.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+740e04c2a93467a0f8c8@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in nci_init_req net/nfc/nci/core.c:177 [inline]
BUG: KMSAN: uninit-value in __nci_request net/nfc/nci/core.c:108 [inline]
BUG: KMSAN: uninit-value in nci_open_device net/nfc/nci/core.c:521 [inline]
BUG: KMSAN: uninit-value in nci_dev_up+0x13a2/0x1ba0 net/nfc/nci/core.c:632
 nci_init_req net/nfc/nci/core.c:177 [inline]
 __nci_request net/nfc/nci/core.c:108 [inline]
 nci_open_device net/nfc/nci/core.c:521 [inline]
 nci_dev_up+0x13a2/0x1ba0 net/nfc/nci/core.c:632
 nfc_dev_up+0x201/0x3d0 net/nfc/core.c:118
 nfc_genl_dev_up+0xe9/0x1c0 net/nfc/netlink.c:775
 genl_family_rcv_msg_doit+0x335/0x3f0 net/netlink/genetlink.c:1115
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0xacf/0xc10 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x54a/0x680 net/netlink/af_netlink.c:2552
 genl_rcv+0x41/0x60 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
 netlink_unicast+0xf04/0x12b0 net/netlink/af_netlink.c:1346
 netlink_sendmsg+0x10b3/0x1250 net/netlink/af_netlink.c:1896
 sock_sendmsg_nosec net/socket.c:714 [inline]
 __sock_sendmsg+0x333/0x3d0 net/socket.c:729
 ____sys_sendmsg+0x7e0/0xd80 net/socket.c:2614
 ___sys_sendmsg+0x271/0x3b0 net/socket.c:2668
 __sys_sendmsg net/socket.c:2700 [inline]
 __do_sys_sendmsg net/socket.c:2705 [inline]
 __se_sys_sendmsg net/socket.c:2703 [inline]
 __x64_sys_sendmsg+0x211/0x3e0 net/socket.c:2703
 x64_sys_call+0x1dfd/0x3e20 arch/x86/include/generated/asm/syscalls_64.h:47
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xd9/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was stored to memory at:
------------[ cut here ]------------
WARNING: CPU: 1 PID: 6169 at kernel/stacktrace.c:29 stack_trace_print+0xd4/0xf0 kernel/stacktrace.c:29
Modules linked in:
CPU: 1 UID: 0 PID: 6169 Comm: syz-executor421 Not tainted 6.16.0-syzkaller-10499-g89748acdf226 #0 PREEMPT(none) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
RIP: 0010:stack_trace_print+0xd4/0xf0 kernel/stacktrace.c:29
Code: 8f bc 03 92 89 de ba 20 00 00 00 4c 89 e1 e8 c3 5d 4d ff 49 83 c6 08 49 ff cd 0f 85 6e ff ff ff eb 0b e8 ff 26 c3 00 eb d4 90 <0f> 0b 90 5b 41 5c 41 5d 41 5e 41 5f 5d e9 9a 33 07 0f cc 66 0f 1f
RSP: 0018:ffff8881343b31c8 EFLAGS: 00010246
RAX: ffff888114afac20 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffff8881343b31f0 R08: 0000000000000000 R09: 0000000000000000
R10: ffff888133bb3208 R11: 0000000000000001 R12: 0000000000000000
R13: 00000000abcd0100 R14: 0000000000000000 R15: 0000000000000000
FS:  00007f0c264ae6c0(0000) GS:ffff8881aa9a5000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f0c26531650 CR3: 00000001193c6000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 kmsan_print_origin+0xb0/0x340 mm/kmsan/report.c:133
 kmsan_report+0x1d3/0x320 mm/kmsan/report.c:196
 __msan_warning+0x1b/0x30 mm/kmsan/instrumentation.c:315
 nci_init_req net/nfc/nci/core.c:177 [inline]
 __nci_request net/nfc/nci/core.c:108 [inline]
 nci_open_device net/nfc/nci/core.c:521 [inline]
 nci_dev_up+0x13a2/0x1ba0 net/nfc/nci/core.c:632
 nfc_dev_up+0x201/0x3d0 net/nfc/core.c:118
 nfc_genl_dev_up+0xe9/0x1c0 net/nfc/netlink.c:775
 genl_family_rcv_msg_doit+0x335/0x3f0 net/netlink/genetlink.c:1115
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0xacf/0xc10 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x54a/0x680 net/netlink/af_netlink.c:2552
 genl_rcv+0x41/0x60 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
 netlink_unicast+0xf04/0x12b0 net/netlink/af_netlink.c:1346
 netlink_sendmsg+0x10b3/0x1250 net/netlink/af_netlink.c:1896
 sock_sendmsg_nosec net/socket.c:714 [inline]
 __sock_sendmsg+0x333/0x3d0 net/socket.c:729
 ____sys_sendmsg+0x7e0/0xd80 net/socket.c:2614
 ___sys_sendmsg+0x271/0x3b0 net/socket.c:2668
 __sys_sendmsg net/socket.c:2700 [inline]
 __do_sys_sendmsg net/socket.c:2705 [inline]
 __se_sys_sendmsg net/socket.c:2703 [inline]
 __x64_sys_sendmsg+0x211/0x3e0 net/socket.c:2703
 x64_sys_call+0x1dfd/0x3e20 arch/x86/include/generated/asm/syscalls_64.h:47
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xd9/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f0c264f62c9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 01 1a 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f0c264ae218 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f0c2657f368 RCX: 00007f0c264f62c9
RDX: 0000000000000000 RSI: 0000200000000140 RDI: 0000000000000004
RBP: 00007f0c2657f360 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f0c2654c074
R13: 0000200000000150 R14: 00002000000000c0 R15: 0000200000000300
 </TASK>
---[ end trace 0000000000000000 ]---

Uninit was stored to memory at:
 nci_core_reset_ntf_packet net/nfc/nci/ntf.c:36 [inline]
 nci_ntf_packet+0x179d/0x42b0 net/nfc/nci/ntf.c:812
 nci_rx_work+0x403/0x750 net/nfc/nci/core.c:1555
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0xb8e/0x1d80 kernel/workqueue.c:3319
 worker_thread+0xedf/0x1590 kernel/workqueue.c:3400
 kthread+0xd5c/0xf00 kernel/kthread.c:464
 ret_from_fork+0x1e0/0x310 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:4186 [inline]
 slab_alloc_node mm/slub.c:4229 [inline]
 kmem_cache_alloc_node_noprof+0x818/0xf00 mm/slub.c:4281
 kmalloc_reserve+0x13c/0x4b0 net/core/skbuff.c:578
 __alloc_skb+0x347/0x7d0 net/core/skbuff.c:669
 alloc_skb include/linux/skbuff.h:1336 [inline]
 virtual_ncidev_write+0x6b/0x430 drivers/nfc/virtual_ncidev.c:120
 vfs_write+0x463/0x1580 fs/read_write.c:684
 ksys_write fs/read_write.c:738 [inline]
 __do_sys_write fs/read_write.c:749 [inline]
 __se_sys_write fs/read_write.c:746 [inline]
 __x64_sys_write+0x1fb/0x4d0 fs/read_write.c:746
 x64_sys_call+0x3014/0x3e20 arch/x86/include/generated/asm/syscalls_64.h:2
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xd9/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 1 UID: 0 PID: 6169 Comm: syz-executor421 Tainted: G        W           6.16.0-syzkaller-10499-g89748acdf226 #0 PREEMPT(none) 
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
=====================================================


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

