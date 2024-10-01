Return-Path: <netdev+bounces-130763-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8354598B6A5
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 10:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3670B21F1A
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 08:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE32199FAB;
	Tue,  1 Oct 2024 08:20:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF80199384
	for <netdev@vger.kernel.org>; Tue,  1 Oct 2024 08:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727770830; cv=none; b=uhClotBVsOqTKDrZTd91BhZBpw67FRHClx472JQpWPI/t0DCbcNaJdkmmjLHYYCN5dVJK5h6lPwFJYBEmDYxOdjlhp7UeZBRN65Ob45eePFS7cCusXcRsnKTMDxxwWHsg0F5UYIKO9Gzf+Myeeg19ioAddYUqdoRfsT0GvzWXkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727770830; c=relaxed/simple;
	bh=6pccea5tGEEMoh3spQvBUQEtEzYzcwqRA6Z/ZGP9RKk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=OqppNgEEWwBDsZDnKFNhGnbyYceCxYHtLM8C5xLpMJck1IVjieGmYEKifcbX1cTxrCK3FeLFDbITBcouSiX/iy9vP23M1AXZRChEm4HMjkJo5BjImY8gtC9lcmUYdwPyPUfPQNhhFGiHmxBmmQf3odx9EKalsiueHT9u+gkoaWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a343860e72so47952065ab.0
        for <netdev@vger.kernel.org>; Tue, 01 Oct 2024 01:20:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727770828; x=1728375628;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XzCgJbhZEo7QF3CkxDHvrR5nHprz6iyBHM/+W9hffDo=;
        b=cySFQlFLbfMqkJLN9Pxv/UfWjXlwc2UW12MFQa7EPGyxPbm7ORzp2w0pDKJSwZos85
         8fHoNsXOmD+wYqRAqPeYjyv01hsYynUIKJ6endGuv4iBdQ7/yrv+d5K2VX1mGPnpLRNv
         mHu6gkNakjBYr0lNCpXZ9M8cNoI5/Ftb6iUdO9s7Zgh/U2t7risACGSNEaqnpfscTxTE
         1E+i+PpfNVeGfRevzlztOJllixCGHJGGMC4V1b5ZHmbzV0f5x4TDqEulNQcVYLrtJZYE
         g6xWg0rrQPvDIho/VjWbDbm4tlg4dNONawGN5jt0ReOMdS1jP1ZVMDVJLTwrO5gIEeGJ
         Yung==
X-Forwarded-Encrypted: i=1; AJvYcCX+swXS23nBwNrIARMVQuipvjVmutzYfJ4p2aTy6VoiznQF9+bFaJrUlNIQkyDy7KR1V2vL6ck=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBbL31JVEr/u/e6empAvwGhdRP8vxqSq3hsVh0ds8KCXMJuRr1
	eFfF6bYMLnWGevmYWYpGHUQqPWmgO4Fo5AVzQGZHhUzQ2mxUQDpG/gsNmUHRzR3ZaDmG86BWc0T
	TgkQ4UwVQPxnVleaELsXPBbaR9z++LdDuf0dtbQbES/cNxY0bqa4OdSg=
X-Google-Smtp-Source: AGHT+IH9kLLuspOitkF2xZ/LEoC1u4qY0tmQq+S7KgYremKIr+bAOydQHtSNGEoGPvo3znh4NaRIFhM1MIbgyty9bjIM+sssIfTc
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fe7:b0:3a2:e9ff:255a with SMTP id
 e9e14a558f8ab-3a3451b4b6emr121435845ab.22.1727770828367; Tue, 01 Oct 2024
 01:20:28 -0700 (PDT)
Date: Tue, 01 Oct 2024 01:20:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66fbb0cc.050a0220.6bad9.0054.GAE@google.com>
Subject: [syzbot] [net?] WARNING in xfrm_state_migrate
From: syzbot <syzbot+e6afe0936b6cb8fae996@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, herbert@gondor.apana.org.au, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, steffen.klassert@secunet.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d505d3593b52 net: wwan: qcom_bam_dmux: Fix missing pm_runt..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=168e7e27980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b2d4fdf18a83ec0b
dashboard link: https://syzkaller.appspot.com/bug?extid=e6afe0936b6cb8fae996
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0286a1cf90df/disk-d505d359.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b573fa96ab33/vmlinux-d505d359.xz
kernel image: https://storage.googleapis.com/syzbot-assets/cdd9993102ed/bzImage-d505d359.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e6afe0936b6cb8fae996@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 10812 at net/xfrm/xfrm_state.c:725 __xfrm_state_destroy net/xfrm/xfrm_state.c:725 [inline]
WARNING: CPU: 1 PID: 10812 at net/xfrm/xfrm_state.c:725 xfrm_state_put include/net/xfrm.h:854 [inline]
WARNING: CPU: 1 PID: 10812 at net/xfrm/xfrm_state.c:725 xfrm_state_migrate+0x130e/0x1870 net/xfrm/xfrm_state.c:1899
Modules linked in:
CPU: 1 UID: 0 PID: 10812 Comm: syz.3.1647 Not tainted 6.11.0-syzkaller-11503-gd505d3593b52 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:__xfrm_state_destroy net/xfrm/xfrm_state.c:725 [inline]
RIP: 0010:xfrm_state_put include/net/xfrm.h:854 [inline]
RIP: 0010:xfrm_state_migrate+0x130e/0x1870 net/xfrm/xfrm_state.c:1899
Code: e8 d7 76 a4 f7 e9 c4 ef ff ff 89 f9 80 e1 07 80 c1 03 38 c1 0f 8c 1f ef ff ff e8 2d 76 a4 f7 e9 15 ef ff ff e8 73 c4 3a f7 90 <0f> 0b 90 e9 cb fd ff ff e8 65 c4 3a f7 e9 ad fe ff ff 89 f9 80 e1
RSP: 0018:ffffc900044d6db8 EFLAGS: 00010283
RAX: ffffffff8a59f0cd RBX: 0000000000000001 RCX: 0000000000040000
RDX: ffffc90009781000 RSI: 000000000000027e RDI: 000000000000027f
RBP: 0000000000000001 R08: ffffffff8a59ee93 R09: 1ffff1100c09ea89
R10: dffffc0000000000 R11: ffffed100c09ea8a R12: dffffc0000000000
R13: ffff8880604f5400 R14: ffffc900044d7236 R15: ffff8880604f5800
FS:  00007fdba7a3b6c0(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000100 CR3: 000000001b7c2000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 xfrm_migrate+0x102c/0x25e0 net/xfrm/xfrm_policy.c:4623
 xfrm_do_migrate+0x9c8/0xba0 net/xfrm/xfrm_user.c:2979
 xfrm_user_rcv_msg+0x75b/0xa80 net/xfrm/xfrm_user.c:3315
 netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2550
 xfrm_netlink_rcv+0x79/0x90 net/xfrm/xfrm_user.c:3337
 netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
 netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1357
 netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1901
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:745
 ____sys_sendmsg+0x52a/0x7e0 net/socket.c:2603
 ___sys_sendmsg net/socket.c:2657 [inline]
 __sys_sendmsg+0x292/0x380 net/socket.c:2686
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fdba6b7dff9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fdba7a3b038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007fdba6d35f80 RCX: 00007fdba6b7dff9
RDX: 0000000000000000 RSI: 0000000020000100 RDI: 0000000000000005
RBP: 00007fdba6bf0296 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fdba6d35f80 R15: 00007ffe98336f48
 </TASK>


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

