Return-Path: <netdev+bounces-188927-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9DCBAAF6B1
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 11:24:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 689093AF7D3
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 09:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A03265CAD;
	Thu,  8 May 2025 09:23:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE92263C6A
	for <netdev@vger.kernel.org>; Thu,  8 May 2025 09:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746696217; cv=none; b=oVVffIc218W96rxFGLf+4dfzwjKh6XP+xi2rBpn4Jt7UUYbwzwtgTEHUXwIsy8lS19nDj6M9qSbMdH9kQUSEkoT6baHYpoFL5HAjsNAsBW3AyzKvVAzdiFpSSXF482gM7Dq3ojsyD3IEdcIEpyXfDCySinuop8tsqRxBjk0XWk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746696217; c=relaxed/simple;
	bh=2NYtZ6iKykthO3Q3ruUW98DyFpzJcQMHG0vXAHbCYNg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=FnlGAdMP4jbc4LZtM2f7IVx71ivZDZhow8GLkQQg6l0uEDwxLeGUdiTkLG+BUPfKcU4cZwb70RsuhHzmbZ+8yEItVdHw32516XUwkLxOMWQDcU+j8NfGwxHznqns7IOQUU+lup/ktuFmfW2yi9Tc4hODIzaWYxEfCPhwcWwfsmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-85b402f69d4so66406939f.3
        for <netdev@vger.kernel.org>; Thu, 08 May 2025 02:23:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746696215; x=1747301015;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JYEXWX6MRhhWhREYCAKn0bDJMC/FKnQyCMlch9PdfDw=;
        b=wgOS1gF4pXFaicW2PnaT6Vofy9AI5Nkj+oQwf2tUeLDZRKCfRzuc8dm+TF0uUcVQm3
         ZcKoqmcgOYKk6WkKpzrZW3lzWed8eKlMP7HXGkH+4TnnrzPEmsVhlFkZh3sfgDmbsjOd
         wtJNoUyzs8DR+7NOwYYUA/7+Obz9Lx6G2xTYmXlLYXKaAOd5VXuOn/K/k+1UbT+Rxhjs
         oIriThue/iKJHsd5NYFTCeJAs0lAu+RHnC3y5BUEujNbI0Rjcu4IAnO8anyUVVb1ay4P
         a6hHk/NmC51Lw/aqwJv98iYzuEDlyL13atF74xPUfDrnbpshHUKvtavmoqbHZD7R3scx
         aCgA==
X-Forwarded-Encrypted: i=1; AJvYcCUwgZZpDGXWU2ZjgXljGBxd9abbAQJugZZrowHciYk7sfAq3+L97TaXK8bGNTUfV2lXxGUzXmw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJba9YoaisrFkydeJodMIarrUdg2jPUCBif0AhE2E6QXYJ70I6
	DY+NN46ut+c0OsXE9fWVYHsGuMfwDRyRN9VozzSx+PT4XCOmiQPurSXw/P5trMTXn8RSgLg0bMA
	eHu8ebzwUxO+ftz24g0issecRtZQ1BcNh7vrA2Sej6EWK+ng0T+oDsJQ=
X-Google-Smtp-Source: AGHT+IG/l+5GX6itIPSidA3DYgMYQI5PVFztsjCqDmvT5Ws68/CkUn2XL8Gkp2QMeYwjbkf3+FcUKqBU8OeqZ3ezkEl+4IMCxECg
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1486:b0:861:6f49:626 with SMTP id
 ca18e2360f4ac-8674784110fmr823887239f.6.1746696214939; Thu, 08 May 2025
 02:23:34 -0700 (PDT)
Date: Thu, 08 May 2025 02:23:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <681c7816.050a0220.a19a9.00cd.GAE@google.com>
Subject: [syzbot] [net?] WARNING in nla_get_range_unsigned (3)
From: syzbot <syzbot+01eb26848144516e7f0a@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	jiri@nvidia.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, saeedm@nvidia.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    a7371be8c8f5 Merge branch 'devlink-sanitize-variable-typed..
git tree:       net-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=10e284d4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=734b5f968169d82b
dashboard link: https://syzkaller.appspot.com/bug?extid=01eb26848144516e7f0a
compiler:       Debian clang version 20.1.2 (++20250402124445+58df0ef89dd6-1~exp1~20250402004600.97), Debian LLD 20.1.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16c9fa70580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14e284d4580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/fc18e3222982/disk-a7371be8.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/990dc6466006/vmlinux-a7371be8.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d35dc62f5d06/bzImage-a7371be8.xz

The issue was bisected to:

commit 429ac6211494c12b668dac59811ea8a96db6d757
Author: Jiri Pirko <jiri@nvidia.com>
Date:   Mon May 5 11:45:11 2025 +0000

    devlink: define enum for attr types of dynamic attributes

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=116cb2bc580000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=136cb2bc580000
console output: https://syzkaller.appspot.com/x/log.txt?x=156cb2bc580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+01eb26848144516e7f0a@syzkaller.appspotmail.com
Fixes: 429ac6211494 ("devlink: define enum for attr types of dynamic attributes")

------------[ cut here ]------------
WARNING: CPU: 0 PID: 5836 at lib/nlattr.c:123 nla_get_range_unsigned+0xc8/0x4b0 lib/nlattr.c:122
Modules linked in:
CPU: 0 UID: 0 PID: 5836 Comm: syz-executor416 Not tainted 6.15.0-rc4-syzkaller-00808-ga7371be8c8f5 #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/29/2025
RIP: 0010:nla_get_range_unsigned+0xc8/0x4b0 lib/nlattr.c:122
Code: 0f 85 71 03 00 00 41 0f b7 2c 24 31 ff 89 ee e8 4e a8 d3 fc 66 85 ed 0f 88 df 02 00 00 e8 a0 a4 d3 fc eb 09 e8 99 a4 d3 fc 90 <0f> 0b 90 4c 89 ed 48 c1 ed 03 42 80 7c 35 00 00 74 08 4c 89 ef e8
RSP: 0018:ffffc900043073d0 EFLAGS: 00010293
RAX: ffffffff84ec1e8f RBX: ffffffff8c808eb0 RCX: ffff88802da1bc00
RDX: 0000000000000000 RSI: 0000000000008a3e RDI: 0000000000000000
RBP: 0000000000008a3e R08: ffff88802da1bc00 R09: 0000000000000004
R10: 0000000000000004 R11: 0000000000000000 R12: ffffffff8c808eba
R13: ffffc900043075b0 R14: dffffc0000000000 R15: 1ffffffff19011d6
FS:  0000555581b32380(0000) GS:ffff8881260c1000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000005b1e008 CR3: 000000007888a000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __netlink_policy_dump_write_attr+0x565/0xdc0 net/netlink/policy.c:316
 netlink_policy_dump_write+0x1e1/0x6e0 net/netlink/policy.c:447
 ctrl_dumppolicy+0x6f4/0xb90 net/netlink/genetlink.c:1743
 genl_dumpit+0x108/0x1b0 net/netlink/genetlink.c:1027
 netlink_dump+0x64e/0xe70 net/netlink/af_netlink.c:2309
 netlink_recvmsg+0x67b/0xe00 net/netlink/af_netlink.c:1965
 sock_recvmsg_nosec net/socket.c:1017 [inline]
 sock_recvmsg+0x229/0x270 net/socket.c:1039
 __sys_recvfrom+0x1f6/0x340 net/socket.c:2230
 __do_sys_recvfrom net/socket.c:2245 [inline]
 __se_sys_recvfrom net/socket.c:2241 [inline]
 __x64_sys_recvfrom+0xde/0x100 net/socket.c:2241
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf6/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f082f5e79b9
Code: ff e8 cb 01 00 00 66 2e 0f 1f 84 00 00 00 00 00 90 80 3d d1 56 07 00 00 41 89 ca 74 1c 45 31 c9 45 31 c0 b8 2d 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 67 c3 66 0f 1f 44 00 00 55 48 83 ec 20 48 89
RSP: 002b:00007ffd83e65928 EFLAGS: 00000246 ORIG_RAX: 000000000000002d
RAX: ffffffffffffffda RBX: 00007ffd83e659b4 RCX: 00007f082f5e79b9
RDX: 0000000000001000 RSI: 00007ffd83e659a0 RDI: 0000000000000003
RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffd83e659a0
R13: 0000000000000010 R14: 0000200000000048 R15: 0000000000000001
 </TASK>


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

