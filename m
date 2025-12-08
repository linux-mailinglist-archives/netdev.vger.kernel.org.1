Return-Path: <netdev+bounces-244008-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 88BC7CAD3F4
	for <lists+netdev@lfdr.de>; Mon, 08 Dec 2025 14:25:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C73253027E08
	for <lists+netdev@lfdr.de>; Mon,  8 Dec 2025 13:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BFEB3148B6;
	Mon,  8 Dec 2025 13:22:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f78.google.com (mail-ot1-f78.google.com [209.85.210.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ACA21F75A6
	for <netdev@vger.kernel.org>; Mon,  8 Dec 2025 13:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765200149; cv=none; b=ExJMIo8D4jIA3sXaWksxhIZU1M9d/qqz3b5pCzqGamfpIZMbUZScr+WJE6HYFmq6XgY9HsFlJew072VJoDkv2KqODAzkR+zAMdc+NyvOUQlfK8Cul5zbm1d6wBjcfTacvYcDvj7CKFf+01vQD6No9XNQvKjIFhUrG/kO/27c4r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765200149; c=relaxed/simple;
	bh=mJKIlv7pwHQdgbWSJxLQBCyOYSGQFFmf+5ffStpuDjI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=IXWIhgsdQxZ0TwLaaCj4a+J753lLcMbgOCFWg/1Iln+2p1nJezeVzF/QDsnqZWmS47mK+9/zn4rE73MT8Evh9CR6+NRVmzuLWdKyLI9PSZ2jcLZMyUtpteYQOFNLoViA476HiHjVCEYEAHcHn2FdB6vZMTgXO8M9ch3QVCVTrsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f78.google.com with SMTP id 46e09a7af769-7cab970818eso1196786a34.1
        for <netdev@vger.kernel.org>; Mon, 08 Dec 2025 05:22:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765200146; x=1765804946;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fccV9RKqyfgst002uxpcAJoMOGcXBOw38BoM6RFgrRI=;
        b=ZKc4rrXWSsNJyVwiVCjb2pLo11H/4a/n8CnrLLUPqIM2OM8Q4ld3l+fYzmBDQbDNxX
         KwWofptjX9Yz+H4fnZzkr4ZnuuUPBPCo2Hn53hQ8rCjBUjdZPTApZuDvL9f3dKcReXCf
         D1vyGDl+LfDF9PxbC9sLPLmvkAVtB8IYG5Z411SfN9mN0jDkcKdKpakrPp7X3Ye7E/+L
         172ZlIlDyMEeMwlBQC9gAYzAWLyCD4E8P6Mn/Xf2hsazN+oTA1OzXv3quQrTWOxRcIM4
         rZDTGef+GPWj67ogmB/Tj8bvlTkTX33ZgGWvKrMtAlEteDnCZP352NgyD8GF/NpNwQJ9
         ezyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFFJZHGA0/7uD8vkeR1bcxik26JdIlbvu3x13XLecS1Go8+D1z9+doO+UqONN/oC0Jaa7iezY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSfm8FrATaFMHb4hXkP4l1rV7cfZkt1ibLl3uk0S33KEipaYzl
	QqGr7B5hObF9c+6IGE6efameqKuLIJTcnLm0O4ADTXqEuGy/XvBQLdSiRqDmH6lxiAtbFm4/bIA
	ySeO7epELF4zgCDjTsTfM2dZkJjGZR0nerI66+tRTjqvj8BKwivLctCoXYs8=
X-Google-Smtp-Source: AGHT+IGDVML1NYMfVqSYdhcdpc9xcQHWjloVEML4QXkiG+02PaSmZ13z3yTBKFuOzRP6MTtYDWTV8MJC6Ld9zv0JxfzazQFo08r6
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:62a:b0:659:9a49:9069 with SMTP id
 006d021491bc7-6599a95e8c6mr3041769eaf.52.1765200146611; Mon, 08 Dec 2025
 05:22:26 -0800 (PST)
Date: Mon, 08 Dec 2025 05:22:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6936d112.a70a0220.38f243.00a7.GAE@google.com>
Subject: [syzbot] [net?] possible deadlock in ipv6_sock_mc_close (4)
From: syzbot <syzbot+c59e6bb54e7620495725@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, kuniyu@google.com, 
	linux-kernel@vger.kernel.org, lucien.xin@gmail.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8f7aa3d3c732 Merge tag 'net-next-6.19' of git://git.kernel..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1564201a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9e5198eaf003f1d1
dashboard link: https://syzkaller.appspot.com/bug?extid=c59e6bb54e7620495725
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17a53192580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13f3301a580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5fe312c4cf90/disk-8f7aa3d3.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c7a1f54ef730/vmlinux-8f7aa3d3.xz
kernel image: https://storage.googleapis.com/syzbot-assets/64a3779458bb/bzImage-8f7aa3d3.xz

The issue was bisected to:

commit b7ddb55f31279f4e59acde3395fc03c3d94b6e5f
Author: Kuniyuki Iwashima <kuniyu@google.com>
Date:   Thu Oct 23 23:16:56 2025 +0000

    sctp: Use sctp_clone_sock() in sctp_do_peeloff().

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=105db01a580000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=125db01a580000
console output: https://syzkaller.appspot.com/x/log.txt?x=145db01a580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c59e6bb54e7620495725@syzkaller.appspotmail.com
Fixes: b7ddb55f3127 ("sctp: Use sctp_clone_sock() in sctp_do_peeloff().")

============================================
WARNING: possible recursive locking detected
syzkaller #0 Not tainted
--------------------------------------------
syz.0.17/5997 is trying to acquire lock:
ffff88803021dee0 (sk_lock-AF_INET6){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1700 [inline]
ffff88803021dee0 (sk_lock-AF_INET6){+.+.}-{0:0}, at: ipv6_sock_mc_close+0xd3/0x140 net/ipv6/mcast.c:348

but task is already holding lock:
ffff88803021d5a0 (sk_lock-AF_INET6){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1700 [inline]
ffff88803021d5a0 (sk_lock-AF_INET6){+.+.}-{0:0}, at: sctp_getsockopt+0x135/0xb60 net/sctp/socket.c:8131

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(sk_lock-AF_INET6);
  lock(sk_lock-AF_INET6);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

1 lock held by syz.0.17/5997:
 #0: ffff88803021d5a0 (sk_lock-AF_INET6){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1700 [inline]
 #0: ffff88803021d5a0 (sk_lock-AF_INET6){+.+.}-{0:0}, at: sctp_getsockopt+0x135/0xb60 net/sctp/socket.c:8131

stack backtrace:
CPU: 1 UID: 0 PID: 5997 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_deadlock_bug+0x279/0x290 kernel/locking/lockdep.c:3041
 check_deadlock kernel/locking/lockdep.c:3093 [inline]
 validate_chain kernel/locking/lockdep.c:3895 [inline]
 __lock_acquire+0x2540/0x2cf0 kernel/locking/lockdep.c:5237
 lock_acquire+0x117/0x340 kernel/locking/lockdep.c:5868
 lock_sock_nested+0x48/0x100 net/core/sock.c:3780
 lock_sock include/net/sock.h:1700 [inline]
 ipv6_sock_mc_close+0xd3/0x140 net/ipv6/mcast.c:348
 inet6_release+0x47/0x70 net/ipv6/af_inet6.c:482
 __sock_release net/socket.c:653 [inline]
 sock_release+0x85/0x150 net/socket.c:681
 sctp_getsockopt_peeloff_common+0x56b/0x770 net/sctp/socket.c:5732
 sctp_getsockopt_peeloff_flags+0x13b/0x230 net/sctp/socket.c:5801
 sctp_getsockopt+0x3ab/0xb60 net/sctp/socket.c:8151
 do_sock_getsockopt+0x2b4/0x3d0 net/socket.c:2399
 __sys_getsockopt net/socket.c:2428 [inline]
 __do_sys_getsockopt net/socket.c:2435 [inline]
 __se_sys_getsockopt net/socket.c:2432 [inline]
 __x64_sys_getsockopt+0x1a5/0x250 net/socket.c:2432
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f8a4018f749
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc8290fbe8 EFLAGS: 00000246 ORIG_RAX: 0000000000000037
RAX: ffffffffffffffda RBX: 00007f8a403e5fa0 RCX: 00007f8a4018f749
RDX: 000000000000007a RSI: 0000000000000084 RDI: 0000000000000003
RBP: 00007f8a40213f91 R08: 0000200000000040 R09: 0000000000000000
R10: 0000200000000340 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f8a403e5fa0 R14: 00007f8a403e5fa0 R15: 0000000000000005
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

