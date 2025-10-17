Return-Path: <netdev+bounces-230305-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85657BE67DE
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 07:53:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C17F51898A4C
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 05:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80EF030C61F;
	Fri, 17 Oct 2025 05:53:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C835926F44C
	for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 05:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760680409; cv=none; b=UQ2FZiDExv0fhP7yYNl3NQTPcvRMw8Bw0BilfR+4VHKssc/ID1JWDX/zAsDojvvbGmNx0MX/NcGIib8IGdVMnjTkz3J4l64/mzyyjhzetSbxdFkfKOQo7fpoLZecGIye0iNuHFVG7tkM6DWLo25XFiKO5pKvjB3wD07YtkYkI/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760680409; c=relaxed/simple;
	bh=XetiEnBf6fhhagJkwInR6Z0Mdxufvs+PlRyxkO18LR0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ned079UgSfvtBFz9gSnxDroYc/qTM5iwsR0iNmaIsfRLD4n3x3Mx318z78hiG5EGkJkkrK/nlq3BaMQqI4orW4X8MtiNgcW0D5gM4Wu0klO5n4nX+mp8vw1U4A2PrYyjHmYqUGuHIxJjkCxD9uqHiAgY/IhOw3dF/P+gYw4IdGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-93e7f4f7bb1so5178539f.3
        for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 22:53:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760680407; x=1761285207;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PxeGq6LImWjZn8Rv+eZo9WLRVgXI9gsmZFj3ZL46tDE=;
        b=C5u+OlJ/hWRdem4dgFDPqT/5YicH0No8RlYhTbGhzf1PmlPAxLtnY2cGYR09w26lP0
         r6Vp3vlvzkQLpwtDsENHVH2BkS8XazO8GNbOISTvUKKHWpG4oFmzkPmrprUpAOrWzfDY
         Ck+XdudbTR+Sig/n/t1aTbm3XgXfQfFN40fF8Ss88naF7nD1n5w4/+fi4M26Tv8qlwAF
         IqSU8Wg7SkNZ96pfoum+YHHxHR7U8p6L4P4CPWKNrErpLG9wNPSngmPW0+SdJEhjDdGI
         jtIqbo4BSZfxE5kF/WNJBkWgz+3xiJKBWPi5FOuvLxQMGIy17pkwX0eGuSTA1Vpb72u6
         7skg==
X-Forwarded-Encrypted: i=1; AJvYcCUmqQF1giSB7QZYWVfUn72zVoiyBNwoDRAWZTy/gxgpgJyC1v+bsyM4yDzOZNFSj3xaOHfZ0Ec=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0c/7xyFzx0DNC9t7sXjRwzCnG6sBPiMnkBt+SAcqYL4wLbaBE
	wIpYGEDURQuaziuWz/ukhUSDGYXBjUN9f2sgvmhc4xpD62iasTcurCHzCgdi3vn5UO2fQC0jU0g
	Xb6WPmh9/g/Y+oPl0n+KaSB/qODIT9aZXAJBq9K9CvCBN5WHHpxQt9w1imQI=
X-Google-Smtp-Source: AGHT+IGJmyPULx3aTsyStsmiq1s0hxUzH97HI/YcyFpd5i4Jys2HYqfvI0Nmb67N2PbR5ffOCiCJ0quIm25eQ85d9wqSSBs2/8kW
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2702:b0:42f:9574:7c1e with SMTP id
 e9e14a558f8ab-430c52a253amr38189605ab.27.1760680406896; Thu, 16 Oct 2025
 22:53:26 -0700 (PDT)
Date: Thu, 16 Oct 2025 22:53:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f1d9d6.050a0220.91a22.0419.GAE@google.com>
Subject: [syzbot] [net?] kernel BUG in set_ipsecrequest
From: syzbot <syzbot+be97dd4da14ae88b6ba4@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, herbert@gondor.apana.org.au, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, steffen.klassert@secunet.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    48a97ffc6c82 bpf: Consistently use bpf_rcu_lock_held() eve..
git tree:       bpf-next
console output: https://syzkaller.appspot.com/x/log.txt?x=144d0734580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9ad7b090a18654a7
dashboard link: https://syzkaller.appspot.com/bug?extid=be97dd4da14ae88b6ba4
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16f7e5e2580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11ecec58580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/87ffd600eff3/disk-48a97ffc.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/aa84f0e32430/vmlinux-48a97ffc.xz
kernel image: https://storage.googleapis.com/syzbot-assets/16498048e16c/bzImage-48a97ffc.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+be97dd4da14ae88b6ba4@syzkaller.appspotmail.com

skbuff: skb_over_panic: text:ffffffff8a1fdd63 len:392 put:16 head:ffff888073664d00 data:ffff888073664d00 tail:0x188 end:0x180 dev:<NULL>
------------[ cut here ]------------
kernel BUG at net/core/skbuff.c:212!
Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
CPU: 1 UID: 0 PID: 6012 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
RIP: 0010:skb_panic+0x157/0x160 net/core/skbuff.c:212
Code: c7 60 10 6e 8c 48 8b 74 24 08 48 8b 54 24 10 8b 0c 24 44 8b 44 24 04 4d 89 e9 50 55 41 57 41 56 e8 6e 54 f5 ff 48 83 c4 20 90 <0f> 0b cc cc cc cc cc cc cc 90 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc90003d5eb68 EFLAGS: 00010282
RAX: 0000000000000088 RBX: dffffc0000000000 RCX: bc84b821dc35fd00
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: 0000000000000180 R08: ffffc90003d5e867 R09: 1ffff920007abd0c
R10: dffffc0000000000 R11: fffff520007abd0d R12: ffff8880720b7b50
R13: ffff888073664d00 R14: ffff888073664d00 R15: 0000000000000188
FS:  000055555b9e7500(0000) GS:ffff888125e0c000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055555b9e7808 CR3: 000000007ead6000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 skb_over_panic net/core/skbuff.c:217 [inline]
 skb_put+0x159/0x210 net/core/skbuff.c:2583
 skb_put_zero include/linux/skbuff.h:2788 [inline]
 set_ipsecrequest+0x73/0x680 net/key/af_key.c:3532
 pfkey_send_migrate+0x11f2/0x1de0 net/key/af_key.c:3636
 km_migrate+0x155/0x260 net/xfrm/xfrm_state.c:2838
 xfrm_migrate+0x2020/0x2330 net/xfrm/xfrm_policy.c:4698
 xfrm_do_migrate+0x796/0x900 net/xfrm/xfrm_user.c:3144
 xfrm_user_rcv_msg+0x7a3/0xab0 net/xfrm/xfrm_user.c:3501
 netlink_rcv_skb+0x208/0x470 net/netlink/af_netlink.c:2552
 xfrm_netlink_rcv+0x79/0x90 net/xfrm/xfrm_user.c:3523
 netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
 netlink_unicast+0x82f/0x9e0 net/netlink/af_netlink.c:1346
 netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1896
 sock_sendmsg_nosec net/socket.c:727 [inline]
 __sock_sendmsg+0x21c/0x270 net/socket.c:742
 ____sys_sendmsg+0x505/0x830 net/socket.c:2630
 ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2684
 __sys_sendmsg net/socket.c:2716 [inline]
 __do_sys_sendmsg net/socket.c:2721 [inline]
 __se_sys_sendmsg net/socket.c:2719 [inline]
 __x64_sys_sendmsg+0x19b/0x260 net/socket.c:2719
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f5fcd58eec9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe59dd1ab8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f5fcd7e5fa0 RCX: 00007f5fcd58eec9
RDX: 0000000000000000 RSI: 0000200000000380 RDI: 0000000000000004
RBP: 00007f5fcd611f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f5fcd7e5fa0 R14: 00007f5fcd7e5fa0 R15: 0000000000000003
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:skb_panic+0x157/0x160 net/core/skbuff.c:212
Code: c7 60 10 6e 8c 48 8b 74 24 08 48 8b 54 24 10 8b 0c 24 44 8b 44 24 04 4d 89 e9 50 55 41 57 41 56 e8 6e 54 f5 ff 48 83 c4 20 90 <0f> 0b cc cc cc cc cc cc cc 90 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc90003d5eb68 EFLAGS: 00010282
RAX: 0000000000000088 RBX: dffffc0000000000 RCX: bc84b821dc35fd00
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: 0000000000000180 R08: ffffc90003d5e867 R09: 1ffff920007abd0c
R10: dffffc0000000000 R11: fffff520007abd0d R12: ffff8880720b7b50
R13: ffff888073664d00 R14: ffff888073664d00 R15: 0000000000000188
FS:  000055555b9e7500(0000) GS:ffff888125e0c000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055555b9e7808 CR3: 000000007ead6000 CR4: 00000000003526f0


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

