Return-Path: <netdev+bounces-162386-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60411A26B89
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 06:52:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD8053A7BBC
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 05:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F00541F8918;
	Tue,  4 Feb 2025 05:52:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9DC158558
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 05:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738648349; cv=none; b=Ys2dpRhDYOgjlCOkptGBjKeWVwsU1N49MqXQDUmtOAQPxwYxODTj0zeggUERN+6zbTzXo2aRfBgBwP/qR2Jv/pOc/IO+6xhaCicWeSESUgYXM+VH9++Be1KLD/4pEzf6+7s8HcKtaIUDhPPC5fg7uiOC4Fwkck7PuDCsDBSP9sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738648349; c=relaxed/simple;
	bh=ZeonDoqXKJqphllXajH1EiFCLCqfnqQeRcLyohUevyE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=HN4QLKcquCgyim9I6Pu3f4l9eyY36ddZb8UNT8whKan2yWtlWp5EhduNCnZK9klssEjVKWVy3h2G5xsM4EPkjxJD2+aYrs3T1Ivy4Ai6kO7FIuRp76AM3sApsjhWNesRT3cyaAOr3Juo/Ll8JxC78is0Tu0xdiM8Fm1YwIfED+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3ce81a40f5cso93702225ab.1
        for <netdev@vger.kernel.org>; Mon, 03 Feb 2025 21:52:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738648347; x=1739253147;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2qazin/m+8r16/vlOKljfbgqTQeNxib9QnEDTDSqHes=;
        b=hYnyNXgR1jjaF9WccQUs80r0wC+IQICDOVoXwUZGXbvaRrJB4/04Kgu7zb5bWt2rpY
         NCVUYAZUH7t9ZHNaSab2sqFp/kSVnUWj6MGARruW8AK2/hx5WduAVX7FdeJ12WVuMjGW
         9mOnSNw5D6DO98lVtjKoMffq4hYJGhVQQIaTPItohZKfpu3SzeoRfKMvfc0Yg56+o+jL
         rNpI9QQDCsYs91s+EEvYQoZHoA6htt7c3nkr1pmLcqTnpgUl0ZlzmrLjzXMkVB6eG0wS
         mY2i3s/923zwD0onhI9VtioUCrI6lpXem9KJZJ6u6ic1vlsLZD6CDIGvsSUFdorhNQWa
         7e8A==
X-Forwarded-Encrypted: i=1; AJvYcCV69TEZES0KQ+w+ZcxPK1j6l6XTwv6dGDk0MeGaNzLY/AuU5ckiletiMvCEAueHEyf5+BD9EXc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIumBPjQzXeqrrx/c9EVkBqK89BCWbFQX4prbG8A+G0YRQD3L7
	1ktRqKEj4KofMLA4621GmiCdoOQdJx/b+JByQ33ENAD1iM5tvFw5AueaX00h0cU1aJIvGTRFxDF
	IMBuhxBwLD+cEiYPtLkXmxkClqDAO9xy02/YnvCLadJYsGDnCm6iSScA=
X-Google-Smtp-Source: AGHT+IFj9akyhlt1T+vPRqQ6b6TbwB5q1YWI8aVzg30MmGTJk8HtdCDdF74H4g9kK2Nr6blvc+VX5Mas3yF4wdNQ4GENR73PIBpq
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1ca2:b0:3d0:164e:958 with SMTP id
 e9e14a558f8ab-3d0164e0b22mr143078025ab.17.1738648347379; Mon, 03 Feb 2025
 21:52:27 -0800 (PST)
Date: Mon, 03 Feb 2025 21:52:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67a1ab1b.050a0220.163cdc.0061.GAE@google.com>
Subject: [syzbot] [net?] general protection fault in __fib6_drop_pcpu_from (6)
From: syzbot <syzbot+1e7754bbf472315fa1e2@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    21266b8df522 Merge tag 'AT_EXECVE_CHECK-v6.14-rc1' of git:..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=145d5ab0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=35d426d11e96abde
dashboard link: https://syzkaller.appspot.com/bug?extid=1e7754bbf472315fa1e2
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1ae7dbe9a3c4/disk-21266b8d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/df012528770e/vmlinux-21266b8d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b59f340ba623/bzImage-21266b8d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1e7754bbf472315fa1e2@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000013: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000098-0x000000000000009f]
CPU: 0 UID: 0 PID: 52 Comm: kworker/u8:3 Not tainted 6.13.0-syzkaller-04858-g21266b8df522 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 12/27/2024
Workqueue: netns cleanup_net
RIP: 0010:__fib6_drop_pcpu_from+0x1fd/0x3d0 net/ipv6/ip6_fib.c:980
Code: 48 c1 e8 03 42 80 3c 20 00 74 08 48 89 ef e8 ba 1d 93 f7 48 8b 6d 00 48 85 ed 74 30 48 81 c5 90 00 00 00 48 89 e8 48 c1 e8 03 <42> 80 3c 20 00 74 08 48 89 ef e8 94 1d 93 f7 48 8b 45 00 4c 39 f0
RSP: 0018:ffffc90000bc6c00 EFLAGS: 00010202
RAX: 0000000000000013 RBX: ffffffff8e2fbb50 RCX: ffff888021ac8000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000098 R08: ffffffff8a704438 R09: 1ffffffff20345d6
R10: dffffc0000000000 R11: fffffbfff20345d7 R12: dffffc0000000000
R13: ffff8880248a8510 R14: ffff8880248a8400 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000110c335fd7 CR3: 00000000118ae000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 fib6_drop_pcpu_from net/ipv6/ip6_fib.c:1024 [inline]
 fib6_purge_rt+0x193/0x890 net/ipv6/ip6_fib.c:1035
 fib6_del_route net/ipv6/ip6_fib.c:1995 [inline]
 fib6_del+0xe71/0x1600 net/ipv6/ip6_fib.c:2040
 fib6_clean_node+0x2f7/0x5e0 net/ipv6/ip6_fib.c:2202
 fib6_walk_continue+0x658/0x8f0 net/ipv6/ip6_fib.c:2124
 fib6_walk+0x168/0x2b0 net/ipv6/ip6_fib.c:2172
 fib6_clean_tree net/ipv6/ip6_fib.c:2252 [inline]
 __fib6_clean_all+0x31f/0x4b0 net/ipv6/ip6_fib.c:2268
 rt6_sync_down_dev net/ipv6/route.c:4908 [inline]
 rt6_disable_ip+0x170/0x800 net/ipv6/route.c:4913
 addrconf_ifdown+0x15d/0x1bd0 net/ipv6/addrconf.c:3849
 addrconf_notify+0x3cb/0x1020
 notifier_call_chain+0x1a5/0x3f0 kernel/notifier.c:85
 call_netdevice_notifiers_extack net/core/dev.c:2179 [inline]
 call_netdevice_notifiers net/core/dev.c:2193 [inline]
 dev_close_many+0x33c/0x4c0 net/core/dev.c:1717
 unregister_netdevice_many_notify+0x52b/0x2030 net/core/dev.c:11779
 unregister_netdevice_many net/core/dev.c:11875 [inline]
 default_device_exit_batch+0xa1f/0xaa0 net/core/dev.c:12360
 ops_exit_list net/core/net_namespace.c:177 [inline]
 cleanup_net+0x8ad/0xd60 net/core/net_namespace.c:652
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0xa66/0x1840 kernel/workqueue.c:3317
 worker_thread+0x870/0xd30 kernel/workqueue.c:3398
 kthread+0x7a9/0x920 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__fib6_drop_pcpu_from+0x1fd/0x3d0 net/ipv6/ip6_fib.c:980
Code: 48 c1 e8 03 42 80 3c 20 00 74 08 48 89 ef e8 ba 1d 93 f7 48 8b 6d 00 48 85 ed 74 30 48 81 c5 90 00 00 00 48 89 e8 48 c1 e8 03 <42> 80 3c 20 00 74 08 48 89 ef e8 94 1d 93 f7 48 8b 45 00 4c 39 f0
RSP: 0018:ffffc90000bc6c00 EFLAGS: 00010202
RAX: 0000000000000013 RBX: ffffffff8e2fbb50 RCX: ffff888021ac8000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000098 R08: ffffffff8a704438 R09: 1ffffffff20345d6
R10: dffffc0000000000 R11: fffffbfff20345d7 R12: dffffc0000000000
R13: ffff8880248a8510 R14: ffff8880248a8400 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000110c335fd7 CR3: 00000000118ae000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	48 c1 e8 03          	shr    $0x3,%rax
   4:	42 80 3c 20 00       	cmpb   $0x0,(%rax,%r12,1)
   9:	74 08                	je     0x13
   b:	48 89 ef             	mov    %rbp,%rdi
   e:	e8 ba 1d 93 f7       	call   0xf7931dcd
  13:	48 8b 6d 00          	mov    0x0(%rbp),%rbp
  17:	48 85 ed             	test   %rbp,%rbp
  1a:	74 30                	je     0x4c
  1c:	48 81 c5 90 00 00 00 	add    $0x90,%rbp
  23:	48 89 e8             	mov    %rbp,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 80 3c 20 00       	cmpb   $0x0,(%rax,%r12,1) <-- trapping instruction
  2f:	74 08                	je     0x39
  31:	48 89 ef             	mov    %rbp,%rdi
  34:	e8 94 1d 93 f7       	call   0xf7931dcd
  39:	48 8b 45 00          	mov    0x0(%rbp),%rax
  3d:	4c 39 f0             	cmp    %r14,%rax


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

