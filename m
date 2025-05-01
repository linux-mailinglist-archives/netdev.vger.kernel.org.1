Return-Path: <netdev+bounces-187223-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3256AAA5DA5
	for <lists+netdev@lfdr.de>; Thu,  1 May 2025 13:15:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3D0B7A948A
	for <lists+netdev@lfdr.de>; Thu,  1 May 2025 11:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A612206B6;
	Thu,  1 May 2025 11:15:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4496033086
	for <netdev@vger.kernel.org>; Thu,  1 May 2025 11:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746098136; cv=none; b=SASrRC3I/Tzz7lTNRbGZw/UKAg2ddwTppfpTaQoMWe3S2JOlcMU4Q7TeOGOdrF/1ygFrTwn7fMMHe/cC/tiNouMDrf4eoPn1hSJgsmKh3bRR9jmZGMM+FmBIXLwJA1CQsU8Fd+Xee2iC6jJPZ49aqXARDizcEW+jw+515ZUo4/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746098136; c=relaxed/simple;
	bh=6si4bwMTyNg9XFuzkNj4+7zAaldEWCOxtzHwQDH4rdM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=NujOX2WbXHhCLYZN1VavCqXIJbjgCqGljZibn0Va+136h5LwikkIu0pscCVOk05715BupALO0Q+YQl49MJAiHT5I0nfTRPuMJwEaJhbCN7YjCbOJZr6ae1HZS1fcgdZU2iGPR2qXzYNi1bjbcgQ9HqhvqfH9B6dB4KrQPpMa+WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-86195b64df7so159247539f.2
        for <netdev@vger.kernel.org>; Thu, 01 May 2025 04:15:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746098134; x=1746702934;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LoUmlDq7AI/086IvXltVC6q/6CNGeKisLsJdMYbrqng=;
        b=G4JwMceOe0wdBxG9m8M+t1ptYG6PFSkg7RKz6NrlZ4UTMFwIOVJEVAGmdwEwe3XpRl
         3s4hx4+zt6LIDzZTkMF1fK8RoPPaePRrZoP3OFc6+HYCTAop98iOnb0SB8yCWEcQHCdy
         xnCR4DFFjHHka8JVvMjd4Nuq+H+NSTbW35/J6aeWqPw3SEHiymKxWtl8jOZoMjMrt7Dw
         6gq6wJN2Ii9x0GgPI87PppQjg6/d+AgBw543Ivg1pVNID7/6pWGlm1wMFbDUSwXmbs/k
         Q9xsoBr63z3Bl94srsFFqxAgYMuY2HwdhSDEGdztpT5AGM7o3YFBtSEPb8eRlSsqxX0I
         xb/g==
X-Forwarded-Encrypted: i=1; AJvYcCXvraEZhJq495lvmloRNj1G+2/iErYJVOCJOmiMrlH2vPHIo7ajAPBUHJcBSOKOsDObyM/Qhoc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1geTioswwf3RLvETf6C2VKRirWyNDVhxgm+KlS++XnCyIxs0F
	aJTNfMh+7p/NU8WeSm1MMinJ5+/Eep1suki23BqSPevY3xphcNp8dGkKTyvIgFimL5V2X3L42TW
	06jTicyZCs9POO8TGQbzTLgLewI/mJ+r0rCH2wQLhGnxjX/a7eXxAsIM=
X-Google-Smtp-Source: AGHT+IEA5wrX/+eXqQmZ008i0MpjHTrbzUPmpKrPPgBEHz1xEZ+mosVEXCLIeY+0jx5fWJ/K/6gKAREH9dZ2krJUqT4NpO+Fb5T1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1f05:b0:3d8:1cba:1854 with SMTP id
 e9e14a558f8ab-3d970198c59mr31300525ab.1.1746098134443; Thu, 01 May 2025
 04:15:34 -0700 (PDT)
Date: Thu, 01 May 2025 04:15:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <681357d6.050a0220.14dd7d.000c.GAE@google.com>
Subject: [syzbot] [net?] UBSAN: array-index-out-of-bounds in ipv6_addr_prefix
From: syzbot <syzbot+e4eec4b8584ac3f936e5@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    5565acd1e6c4 Merge git://git.kernel.org/pub/scm/linux/kern..
git tree:       net-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=12f19574580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2e3745cb659ef5d9
dashboard link: https://syzkaller.appspot.com/bug?extid=e4eec4b8584ac3f936e5
compiler:       Debian clang version 20.1.2 (++20250402124445+58df0ef89dd6-1~exp1~20250402004600.97), Debian LLD 20.1.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10207fcf980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16f19574580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/80798769614c/disk-5565acd1.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/435ecb0f1371/vmlinux-5565acd1.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7790d5f923b6/bzImage-5565acd1.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e4eec4b8584ac3f936e5@syzkaller.appspotmail.com

------------[ cut here ]------------
UBSAN: array-index-out-of-bounds in ./include/net/ipv6.h:616:21
index 16 is out of range for type 'const __u8[16]' (aka 'const unsigned char[16]')
CPU: 0 UID: 0 PID: 5837 Comm: syz-executor401 Not tainted 6.15.0-rc3-syzkaller-00557-g5565acd1e6c4 #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 ubsan_epilogue+0xa/0x40 lib/ubsan.c:231
 __ubsan_handle_out_of_bounds+0xe9/0xf0 lib/ubsan.c:453
 ipv6_addr_prefix+0x145/0x1d0 include/net/ipv6.h:616
 ip6_route_info_create+0x629/0xa70 net/ipv6/route.c:3814
 ip6_route_mpath_info_create net/ipv6/route.c:5393 [inline]
 ip6_route_multipath_add net/ipv6/route.c:5519 [inline]
 inet6_rtm_newroute+0x578/0x1c70 net/ipv6/route.c:5710
 rtnetlink_rcv_msg+0x7cc/0xb70 net/core/rtnetlink.c:6955
 netlink_rcv_skb+0x219/0x490 net/netlink/af_netlink.c:2534
 netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
 netlink_unicast+0x758/0x8d0 net/netlink/af_netlink.c:1339
 netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1883
 sock_sendmsg_nosec net/socket.c:712 [inline]
 __sock_sendmsg+0x219/0x270 net/socket.c:727
 ____sys_sendmsg+0x505/0x830 net/socket.c:2566
 ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2620
 __sys_sendmsg net/socket.c:2652 [inline]
 __do_sys_sendmsg net/socket.c:2657 [inline]
 __se_sys_sendmsg net/socket.c:2655 [inline]
 __x64_sys_sendmsg+0x19b/0x260 net/socket.c:2655
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf6/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fc65575d369
Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff8937e028 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007fff8937e1f8 RCX: 00007fc65575d369
RDX: 0000000000000000 RSI: 0000200000000000 RDI: 0000000000000003
RBP: 00007fc6557d0610 R08: 0000000000000000 R09: 00007fff8937e1f8
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007fff8937e1e8 R14: 0000000000000001 R15: 0000000000000001
 </TASK>
---[ end trace ]---


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

