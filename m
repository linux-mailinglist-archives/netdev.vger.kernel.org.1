Return-Path: <netdev+bounces-111636-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 235F9931E6E
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 03:23:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2A241F21C13
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 01:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6039D1876;
	Tue, 16 Jul 2024 01:23:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984BC4428
	for <netdev@vger.kernel.org>; Tue, 16 Jul 2024 01:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721093002; cv=none; b=ddp8TpWUsp71Esf/DKtE4rcU7svWWSkdENXP7BziMvp2so5PXYqViFchtJqJ2Rxk5MrXnyIS8ItLNo6lT2ZDCBarNMza8Wjae0pIXJGR/NkVL79dTFEr8Tz99I5zRL92EMdPamA/VGWT9h6/XqTkjdyECioQ4JD/sjMgGpvhn08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721093002; c=relaxed/simple;
	bh=fnxTyEqfqdQiYt2zAm7DIjm4KB8FKt0/kFs8ODxb9sQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ks0cLThU99KL/OxIsjkMY2azSoMRpK5553pd2HMHTekQx9qd12CAlGGFq2W1BJieltDAe8OtdHUfhApBYc1y+LfXIAMc2L1NivJbadaMKs10+kxHmgVpppwjFRzWXzVNCa+xqbC9MuGc/wvWVW0thazmi7RpVfUrGYTaAq5m2LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7f61da4d7beso591154639f.2
        for <netdev@vger.kernel.org>; Mon, 15 Jul 2024 18:23:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721093000; x=1721697800;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VX5ie3LpoTnCmaAoYfXKDiRh9qsGBUI3lTqEmo+rDn8=;
        b=ImsJow7g+2yPKPU3ag0UVUPh1MV5KwWAb4LJE4tfFOetkLt0wvPcdlmtrqwdbA8I0Y
         YjIumX2mmadDJ3eq4IIzuDjsPTswHZn6XnxGU8/azNFphL/gX5yrDcR2eu1amg9RVa+B
         2OU/ghi9vP2w2lL8EbopffcxNQbO+uwln4bqxkq8gXhD/pfY2u+1niu5+XNFMlrY6xwH
         B6mHpMONhwmJs1VLJpc3DdcT0DGo96McfhZEHB1QqR4y2CxJ8/Rr4edeKvOe6Bo9prYr
         s4JqY3uFk1MOLMwTfQDsEmdWDo4xA6t4s1n5fXgJLLP/Fxj51cmkCbCWdHYlIE6NlkwN
         gEvg==
X-Forwarded-Encrypted: i=1; AJvYcCXqK6mw9gtRjH067DORCEZNrqx0LHVb1j7toKqJi/stIHGKWdGYeBXeUkbJR2+L9wqQX1apRX9Wn/8ra/7aBi3yrbLv0Oh1
X-Gm-Message-State: AOJu0Yypw7YwkFk3Srt3aH3hgE9Sh9wv2vgg8hnYlldDJLLs2XmuCp27
	/XPzKzcnwr92QN0DuNTS8D9Aiqo6GUsY6P4J2k+BRiJ8gb6Z4NLnaSYHCyBgPUV5hIXBV+6tnvC
	6C3CSB6AQx7QG5uUrVidc3UpgUHJOlmWdNleleclpSBBpdFQB+fLy8So=
X-Google-Smtp-Source: AGHT+IECwzZhpYPm6rr51Z7VUrSfGP9/xHHw2aKwZ9MdX/g8msw9lbJ1P6V/CNEdVmRwWwktYQjVO1QpJcX6zaOvAiO0QvJ8MtDo
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3006:b0:4c0:a8a5:81cc with SMTP id
 8926c6da1cb9f-4c20484b512mr56051173.3.1721092999825; Mon, 15 Jul 2024
 18:23:19 -0700 (PDT)
Date: Mon, 15 Jul 2024 18:23:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e1609a061d5330ce@google.com>
Subject: [syzbot] [net?] WARNING in skb_warn_bad_offload (5)
From: syzbot <syzbot+e15b7e15b8a751a91d9a@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	jakub@cloudflare.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, soheil@google.com, 
	syzkaller-bugs@googlegroups.com, willemb@google.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    80ab5445da62 Merge tag 'wireless-next-2024-07-11' of git:/..
git tree:       net-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=175fb821980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2dbcdd8641c4638f
dashboard link: https://syzkaller.appspot.com/bug?extid=e15b7e15b8a751a91d9a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=172bf566980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12fff535980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/184da3869c30/disk-80ab5445.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/85bfe9b60f21/vmlinux-80ab5445.xz
kernel image: https://storage.googleapis.com/syzbot-assets/06064623a948/bzImage-80ab5445.xz

The issue was bisected to:

commit 10154dbded6d6a2fecaebdfda206609de0f121a9
Author: Jakub Sitnicki <jakub@cloudflare.com>
Date:   Wed Jun 26 17:51:26 2024 +0000

    udp: Allow GSO transmit from devices with no checksum offload

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=142ccbed980000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=162ccbed980000
console output: https://syzkaller.appspot.com/x/log.txt?x=122ccbed980000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e15b7e15b8a751a91d9a@syzkaller.appspotmail.com
Fixes: 10154dbded6d ("udp: Allow GSO transmit from devices with no checksum offload")

skb frag:     00000080: 62 3f 77 e4 0e 82 0d 2f 85 cc 44 ea 25 5a 99 76
skb frag:     00000090: f2 53
------------[ cut here ]------------
ip6tnl0: caps=(0x00000006401d7869, 0x00000006401d7869)
WARNING: CPU: 0 PID: 5112 at net/core/dev.c:3293 skb_warn_bad_offload+0x166/0x1a0 net/core/dev.c:3291
Modules linked in:
CPU: 0 PID: 5112 Comm: syz-executor391 Not tainted 6.10.0-rc7-syzkaller-01603-g80ab5445da62 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
RIP: 0010:skb_warn_bad_offload+0x166/0x1a0 net/core/dev.c:3291
Code: e8 5f 94 a3 f8 49 8b 04 24 48 8d 88 a0 03 00 00 48 85 c0 48 0f 44 cd 48 c7 c7 00 cc c5 8c 4c 89 f6 48 89 da e8 fb 92 ff f7 90 <0f> 0b 90 90 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc 44 89 f9
RSP: 0018:ffffc900034bedc8 EFLAGS: 00010246
RAX: 7d287cad4185da00 RBX: ffff888040cdc0b8 RCX: ffff888023d1bc00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffffff8cc5cbc0 R08: ffffffff815857b2 R09: fffffbfff1c39994
R10: dffffc0000000000 R11: fffffbfff1c39994 R12: ffff888022880518
R13: dffffc0000000000 R14: ffff888040cdc130 R15: ffff888040cdc130
FS:  000055556e9e9380(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020001180 CR3: 000000007c876000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __skb_gso_segment+0x3be/0x4c0 net/core/gso.c:127
 skb_gso_segment include/net/gso.h:83 [inline]
 validate_xmit_skb+0x585/0x1120 net/core/dev.c:3661
 __dev_queue_xmit+0x17a4/0x3e90 net/core/dev.c:4415
 neigh_output include/net/neighbour.h:542 [inline]
 ip6_finish_output2+0xffa/0x1680 net/ipv6/ip6_output.c:137
 ip6_finish_output+0x41e/0x810 net/ipv6/ip6_output.c:222
 ip6_send_skb+0x112/0x230 net/ipv6/ip6_output.c:1958
 udp_v6_send_skb+0xbf5/0x1870 net/ipv6/udp.c:1292
 udpv6_sendmsg+0x23b3/0x3270 net/ipv6/udp.c:1588
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0xef/0x270 net/socket.c:745
 ____sys_sendmsg+0x525/0x7d0 net/socket.c:2585
 ___sys_sendmsg net/socket.c:2639 [inline]
 __sys_sendmmsg+0x3b2/0x740 net/socket.c:2725
 __do_sys_sendmmsg net/socket.c:2754 [inline]
 __se_sys_sendmmsg net/socket.c:2751 [inline]
 __x64_sys_sendmmsg+0xa0/0xb0 net/socket.c:2751
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f04f688fe89
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 01 1a 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffeebc526e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000133
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f04f688fe89
RDX: 0000000000000001 RSI: 0000000020003cc0 RDI: 0000000000000003
RBP: 00000000000f4240 R08: 0000000000000000 R09: 0000000000000001
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffeebc52740
R13: 00007f04f68dd406 R14: 0000000000000003 R15: 00007ffeebc52720
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

