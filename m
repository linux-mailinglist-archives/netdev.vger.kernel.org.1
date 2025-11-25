Return-Path: <netdev+bounces-241617-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2FE5C86DCE
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 20:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 508D83B3CC1
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 19:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D2E22528FD;
	Tue, 25 Nov 2025 19:50:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D151433AD85
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 19:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764100229; cv=none; b=hN7L9snlDXeTYYE1Ua123PXMnVKuRt2ScoZYt5+2fU7GkjNByONWKwfgijWEe3dj0w2F8x0IHczRbRKsMLxz31+9DdoEn2S1DZKnrrez0UnR5oZZCgfqhGUj+tJ2U3AP6J4PBKfjtNeLsbiG35wDovPACpGymB9bWIyPgU2LMeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764100229; c=relaxed/simple;
	bh=fl5l8k2ZZtIkMqIumx38NaO5Y8WM+0hdDm7vW12RQ7w=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=PDOkLxw1W/Q+5Ovg32Y9UzGOL61+ff3GGpeghqf9fzAuypcWMz6hPrvOCrkObf1ZrA2I5vLARvQnm4WsxMseEybh/27wFaEnDTwq3qpiW8uOtIZk10YE/C2Xu/nmAI0C2sRYSmOEWnkuSfwFoe8p+U+ZW+NNOZoihF1VnNakhsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-93bc56ebb0aso439746239f.0
        for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 11:50:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764100227; x=1764705027;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ppBFuX/0ILqZWhl2srv5dJ6jYles2CmNqIe9VLWtPDw=;
        b=OqkGPZxfhVbVD1nGwZ1OpHOgIG1VZyZFq4gX0lnQOiAdw8LjeEbvmtrPbtrF7kMAFg
         coWVOcE7Kuo1kdXWktsSXWq/m+gj0vFX8RwcqIeNRoUALlT/isTzSs6/0FAmOkfrR6G8
         gNw7OBGZK4VwKx5VKwKkuQUGMPqrPniviozrzDiLvEqHr++5kLUsdrZsE9Li4fmqnIX7
         3cAQ3RfAk4/tpI51bGewh0WQSt4Gu6m/lDPS4P2N+K3oscpkAfZxBSLkpBcg8MJApd1b
         1C19sKRF3oNsu5B2rYoNasUjPcS/hsyXxwj96ecJdpNvS3sof8ZtwkL85FALb0Gqavrm
         KmWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJgcDl5twV0e7LjMtre3DlLnA/7TzP7Hxj0ClMhhASKBJ5QyEIQZuFWT4VpkwHK3VHdof4E2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI3Pl2k2ZSrsyu9xfBy95tHSv5Li0t4Is3JEgcYlhlOAX3wxh1
	Hj4fTpVaAlzsk7bXJCRlRqz3q2CEX2XJQx0ncCR4TmL7ZpyTh5axMbWY+rhfXwfaSMzOVsIzalu
	Yor+Q2eCnti2N5K+vXXnRXVA8UBZDPhXXSpRzw6f3itzN/g6WKEMSMRQiPlI=
X-Google-Smtp-Source: AGHT+IHzCCZn4DHCqnfmi+U4VllXcpVuUMBWBdVv8Qsaflu5EVJ791HjHIgGRCRum4zF/g1vqd0SjUPVN3uBOkCdEfkkuSqlAXtj
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:156a:b0:434:96ea:ff6e with SMTP id
 e9e14a558f8ab-435dd13b1e8mr36028035ab.39.1764100226986; Tue, 25 Nov 2025
 11:50:26 -0800 (PST)
Date: Tue, 25 Nov 2025 11:50:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69260882.a70a0220.d98e3.00b4.GAE@google.com>
Subject: [syzbot] [net?] divide error in __tcp_select_window (4)
From: syzbot <syzbot+3a92d359bc2ec6255a33@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	geliang@kernel.org, horms@kernel.org, kuba@kernel.org, kuniyu@google.com, 
	linux-kernel@vger.kernel.org, matttbe@kernel.org, ncardwell@google.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    e2c20036a887 Merge branch 'devlink-net-mlx5-implement-swp_..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1164c484580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a881ccda32df4e75
dashboard link: https://syzkaller.appspot.com/bug?extid=3a92d359bc2ec6255a33
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13f8fa12580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=113a5a12580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/07279e689a07/disk-e2c20036.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b13e2e59c1ed/vmlinux-e2c20036.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f6f519394597/bzImage-e2c20036.xz

The issue was bisected to:

commit ae155060247be8dcae3802a95bd1bdf93ab3215d
Author: Paolo Abeni <pabeni@redhat.com>
Date:   Tue Nov 18 07:20:24 2025 +0000

    mptcp: fix duplicate reset on fastclose

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11f698b4580000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=13f698b4580000
console output: https://syzkaller.appspot.com/x/log.txt?x=15f698b4580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3a92d359bc2ec6255a33@syzkaller.appspotmail.com
Fixes: ae155060247b ("mptcp: fix duplicate reset on fastclose")

RBP: 00007ffff9acee10 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007f66e9be5fa0 R14: 00007f66e9be5fa0 R15: 0000000000000006
 </TASK>
Oops: divide error: 0000 [#1] SMP KASAN PTI
CPU: 0 UID: 0 PID: 6068 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
RIP: 0010:__tcp_select_window+0x824/0x1320 net/ipv4/tcp_output.c:3336
Code: ff ff ff 44 89 f1 d3 e0 89 c1 f7 d1 41 01 cc 41 21 c4 e9 a9 00 00 00 e8 ca 49 01 f8 e9 9c 00 00 00 e8 c0 49 01 f8 44 89 e0 99 <f7> 7c 24 1c 41 29 d4 48 bb 00 00 00 00 00 fc ff df e9 80 00 00 00
RSP: 0018:ffffc90003017640 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff88807b469e40
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc90003017730 R08: ffff888033268143 R09: 1ffff1100664d028
R10: dffffc0000000000 R11: ffffed100664d029 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
FS:  000055557faa0500(0000) GS:ffff888126135000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f64a1912ff8 CR3: 0000000072122000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 tcp_select_window net/ipv4/tcp_output.c:281 [inline]
 __tcp_transmit_skb+0xbc7/0x3aa0 net/ipv4/tcp_output.c:1568
 tcp_transmit_skb net/ipv4/tcp_output.c:1649 [inline]
 tcp_send_active_reset+0x2d1/0x5b0 net/ipv4/tcp_output.c:3836
 mptcp_do_fastclose+0x27e/0x380 net/mptcp/protocol.c:2793
 mptcp_disconnect+0x238/0x710 net/mptcp/protocol.c:3253
 mptcp_sendmsg_fastopen+0x2f8/0x580 net/mptcp/protocol.c:1776
 mptcp_sendmsg+0x1774/0x1980 net/mptcp/protocol.c:1855
 sock_sendmsg_nosec net/socket.c:727 [inline]
 __sock_sendmsg+0xe5/0x270 net/socket.c:742
 __sys_sendto+0x3bd/0x520 net/socket.c:2244
 __do_sys_sendto net/socket.c:2251 [inline]
 __se_sys_sendto net/socket.c:2247 [inline]
 __x64_sys_sendto+0xde/0x100 net/socket.c:2247
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f66e998f749
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffff9acedb8 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00007f66e9be5fa0 RCX: 00007f66e998f749
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 00007ffff9acee10 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007f66e9be5fa0 R14: 00007f66e9be5fa0 R15: 0000000000000006
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__tcp_select_window+0x824/0x1320 net/ipv4/tcp_output.c:3336
Code: ff ff ff 44 89 f1 d3 e0 89 c1 f7 d1 41 01 cc 41 21 c4 e9 a9 00 00 00 e8 ca 49 01 f8 e9 9c 00 00 00 e8 c0 49 01 f8 44 89 e0 99 <f7> 7c 24 1c 41 29 d4 48 bb 00 00 00 00 00 fc ff df e9 80 00 00 00
RSP: 0018:ffffc90003017640 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff88807b469e40
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc90003017730 R08: ffff888033268143 R09: 1ffff1100664d028
R10: dffffc0000000000 R11: ffffed100664d029 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
FS:  000055557faa0500(0000) GS:ffff888126135000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f64a1912ff8 CR3: 0000000072122000 CR4: 00000000003526f0
----------------
Code disassembly (best guess), 2 bytes skipped:
   0:	ff 44 89 f1          	incl   -0xf(%rcx,%rcx,4)
   4:	d3 e0                	shl    %cl,%eax
   6:	89 c1                	mov    %eax,%ecx
   8:	f7 d1                	not    %ecx
   a:	41 01 cc             	add    %ecx,%r12d
   d:	41 21 c4             	and    %eax,%r12d
  10:	e9 a9 00 00 00       	jmp    0xbe
  15:	e8 ca 49 01 f8       	call   0xf80149e4
  1a:	e9 9c 00 00 00       	jmp    0xbb
  1f:	e8 c0 49 01 f8       	call   0xf80149e4
  24:	44 89 e0             	mov    %r12d,%eax
  27:	99                   	cltd
* 28:	f7 7c 24 1c          	idivl  0x1c(%rsp) <-- trapping instruction
  2c:	41 29 d4             	sub    %edx,%r12d
  2f:	48 bb 00 00 00 00 00 	movabs $0xdffffc0000000000,%rbx
  36:	fc ff df
  39:	e9 80 00 00 00       	jmp    0xbe


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

