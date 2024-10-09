Return-Path: <netdev+bounces-133683-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F394996ACF
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 14:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4196D1C22A7D
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 12:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76CCD1D4176;
	Wed,  9 Oct 2024 12:50:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8514419994B
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 12:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728478227; cv=none; b=uXyNkcCx0s+BYSqNS0C9qUFvcyyLxJbJng9LSZCkzGY3jDTkq6Y4G0UmXk9MG4bVn7meEVd6H7zYTQj7BrvcbK/lFLxeHUHyOTrpYShffs+KOnOAIx6h4ITkxZKiydgCV+3rdVpxwK2t68uLvU9LBhEEj3URjtC4PdDvnX07ur0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728478227; c=relaxed/simple;
	bh=ICm2uHdQ3kDjv8Ltj7st6Ws2oDMXIqM+aJOryiWOs7s=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=SKhna7GCqcUPwosjx4tttZJnR0Y1ULkm5UcnUHlMdM1BBDo1rEDIyCyRaEFjqdQOz2tDIHSzSexNONPZZZG488oXP+EP0AOVCkmUECr6KSjDvlFvfLDBwTIXq7OQPFthIlztJQ0ibq9RhuS91omvtZctvxH9XOXPQ92Vh+/goNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a345a02c23so65505465ab.1
        for <netdev@vger.kernel.org>; Wed, 09 Oct 2024 05:50:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728478224; x=1729083024;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8piFzQkyTykKl8ho9obTGN0QxNR9MS4SVVuKY4+FZhs=;
        b=KvFFbtLir+xGHL3imKS438c8lpeBqOJ4wkUIzfOcbjwDY2YoTPKq7dn2fIh1+V21ak
         3rxdTrj76VyrlZWsUw7qYl8EH6BZHxmh8ZNa+vSAaF5OOqmKcRLycQbF8M0EttYrMCiL
         MEPw6jVLJnQ+hxi9U901NENHhm48b7eB8XNrKGKgxwMZqo5acKdLA4W5JF6aaDcAq7GQ
         v4FammFZqlx5tGR4C9YYWhiKjaXvzSzaCJ4/wA8kr2sI5LoHBDAOwlzYR9Sipimq6W9X
         PP4JP3j5CDQEOgGq3AaN+kZqSwTUuYPyz5pkzCux9/YIHGzacmR8Djm4h5/2AUccqAY9
         cfqw==
X-Forwarded-Encrypted: i=1; AJvYcCUXZbVeG+2IsrETq803MVjm7tdIWcnFKZCZCW5qCf2+MlByyNifhEEvBWnx20A+8dtv7Wb9H9M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMkb2ZVNTPsW8wno6Rc/DfxpR+mn027QnnX3GzVuo1y+aiQ3Ua
	6JRxlQmOQzDIFGHWpkJYM+7tTJ+XektZlgAGPyBONJTS8g99JacKUpowG/XNxEb7OafRvefMxvQ
	BwfGPh/ttWAEz7IQMpYWn4w3rHQPvLANOwpr9LGvoVfuzcQsjoZO5h5g=
X-Google-Smtp-Source: AGHT+IGenw9fLYq+whpJBkbwo31pHCLWbtEIP6oQpDq/gRJERx9xlvEDA/caYmw8G93+qVq6j5gMi060zCSWiIDHcunxDceQ/Tda
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:158b:b0:399:4535:b66e with SMTP id
 e9e14a558f8ab-3a397ce5711mr17043955ab.9.1728478224618; Wed, 09 Oct 2024
 05:50:24 -0700 (PDT)
Date: Wed, 09 Oct 2024 05:50:24 -0700
In-Reply-To: <000000000000d1e06d061fb617c3@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67067c10.050a0220.4029f.0001.GAE@google.com>
Subject: Re: [syzbot] [net?] possible deadlock in sockopt_lock_sock
From: syzbot <syzbot+819a360379cf16b5f0d3@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    75b607fab38d Merge tag 'sched_ext-for-6.12-rc2-fixes' of g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13fbd7d0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=667b897270c8ae6
dashboard link: https://syzkaller.appspot.com/bug?extid=819a360379cf16b5f0d3
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=176c0f07980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14af1327980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a7759a7b0126/disk-75b607fa.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/734e9758ae9d/vmlinux-75b607fa.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e23bee69aa18/bzImage-75b607fa.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+819a360379cf16b5f0d3@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.12.0-rc2-syzkaller-00058-g75b607fab38d #0 Not tainted
------------------------------------------------------
syz-executor308/20073 is trying to acquire lock:
ffff88807c488a98 (sk_lock-AF_INET6){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1609 [inline]
ffff88807c488a98 (sk_lock-AF_INET6){+.+.}-{0:0}, at: sockopt_lock_sock net/core/sock.c:1125 [inline]
ffff88807c488a98 (sk_lock-AF_INET6){+.+.}-{0:0}, at: sockopt_lock_sock+0x54/0x70 net/core/sock.c:1116

but task is already holding lock:
ffffffff8fac31e8 (rtnl_mutex){+.+.}-{3:3}, at: do_ipv6_setsockopt+0x1f4d/0x4800 net/ipv6/ipv6_sockglue.c:566

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (rtnl_mutex){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x175/0x9c0 kernel/locking/mutex.c:752
       do_ipv6_setsockopt+0x1f4d/0x4800 net/ipv6/ipv6_sockglue.c:566
       ipv6_setsockopt+0xcb/0x170 net/ipv6/ipv6_sockglue.c:993
       tcp_setsockopt+0xa4/0x100 net/ipv4/tcp.c:4029
       smc_setsockopt+0x1b4/0xc00 net/smc/af_smc.c:3064
       do_sock_setsockopt+0x222/0x480 net/socket.c:2329
       __sys_setsockopt+0x1a4/0x270 net/socket.c:2352
       __do_sys_setsockopt net/socket.c:2361 [inline]
       __se_sys_setsockopt net/socket.c:2358 [inline]
       __x64_sys_setsockopt+0xbd/0x160 net/socket.c:2358
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (&smc->clcsock_release_lock){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x175/0x9c0 kernel/locking/mutex.c:752
       smc_switch_to_fallback+0x2d/0xa00 net/smc/af_smc.c:902
       smc_setsockopt+0xa7b/0xc00 net/smc/af_smc.c:3087
       do_sock_setsockopt+0x222/0x480 net/socket.c:2329
       __sys_setsockopt+0x1a4/0x270 net/socket.c:2352
       __do_sys_setsockopt net/socket.c:2361 [inline]
       __se_sys_setsockopt net/socket.c:2358 [inline]
       __x64_sys_setsockopt+0xbd/0x160 net/socket.c:2358
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (sk_lock-AF_INET6){+.+.}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3161 [inline]
       check_prevs_add kernel/locking/lockdep.c:3280 [inline]
       validate_chain kernel/locking/lockdep.c:3904 [inline]
       __lock_acquire+0x250b/0x3ce0 kernel/locking/lockdep.c:5202
       lock_acquire.part.0+0x11b/0x380 kernel/locking/lockdep.c:5825
       lock_sock_nested+0x3a/0xf0 net/core/sock.c:3611
       lock_sock include/net/sock.h:1609 [inline]
       sockopt_lock_sock net/core/sock.c:1125 [inline]
       sockopt_lock_sock+0x54/0x70 net/core/sock.c:1116
       do_ipv6_setsockopt+0x1f55/0x4800 net/ipv6/ipv6_sockglue.c:567
       ipv6_setsockopt+0xcb/0x170 net/ipv6/ipv6_sockglue.c:993
       udpv6_setsockopt+0x7d/0xd0 net/ipv6/udp.c:1702
       do_sock_setsockopt+0x222/0x480 net/socket.c:2329
       __sys_setsockopt+0x1a4/0x270 net/socket.c:2352
       __do_sys_setsockopt net/socket.c:2361 [inline]
       __se_sys_setsockopt net/socket.c:2358 [inline]
       __x64_sys_setsockopt+0xbd/0x160 net/socket.c:2358
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  sk_lock-AF_INET6 --> &smc->clcsock_release_lock --> rtnl_mutex

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(rtnl_mutex);
                               lock(&smc->clcsock_release_lock);
                               lock(rtnl_mutex);
  lock(sk_lock-AF_INET6);

 *** DEADLOCK ***

1 lock held by syz-executor308/20073:
 #0: ffffffff8fac31e8 (rtnl_mutex){+.+.}-{3:3}, at: do_ipv6_setsockopt+0x1f4d/0x4800 net/ipv6/ipv6_sockglue.c:566

stack backtrace:
CPU: 1 UID: 0 PID: 20073 Comm: syz-executor308 Not tainted 6.12.0-rc2-syzkaller-00058-g75b607fab38d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_circular_bug+0x419/0x5d0 kernel/locking/lockdep.c:2074
 check_noncircular+0x31a/0x400 kernel/locking/lockdep.c:2206
 check_prev_add kernel/locking/lockdep.c:3161 [inline]
 check_prevs_add kernel/locking/lockdep.c:3280 [inline]
 validate_chain kernel/locking/lockdep.c:3904 [inline]
 __lock_acquire+0x250b/0x3ce0 kernel/locking/lockdep.c:5202
 lock_acquire.part.0+0x11b/0x380 kernel/locking/lockdep.c:5825
 lock_sock_nested+0x3a/0xf0 net/core/sock.c:3611
 lock_sock include/net/sock.h:1609 [inline]
 sockopt_lock_sock net/core/sock.c:1125 [inline]
 sockopt_lock_sock+0x54/0x70 net/core/sock.c:1116
 do_ipv6_setsockopt+0x1f55/0x4800 net/ipv6/ipv6_sockglue.c:567
 ipv6_setsockopt+0xcb/0x170 net/ipv6/ipv6_sockglue.c:993
 udpv6_setsockopt+0x7d/0xd0 net/ipv6/udp.c:1702
 do_sock_setsockopt+0x222/0x480 net/socket.c:2329
 __sys_setsockopt+0x1a4/0x270 net/socket.c:2352
 __do_sys_setsockopt net/socket.c:2361 [inline]
 __se_sys_setsockopt net/socket.c:2358 [inline]
 __x64_sys_setsockopt+0xbd/0x160 net/socket.c:2358
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f3b71d4e8a9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f3b71ce7198 EFLAGS: 00000246 ORIG_RAX: 0000000000000036
RAX: ffffffffffffffda RBX: 00007f3b71dd93d8 RCX: 00007f3b71d4e8a9
RDX: 000000000000001b RSI: 0000000000000029 RDI: 0000000000000003
RBP: 00007f3b71dd93d0 R08: 000000000000056b R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f3b71da6410
R13: 00007f3b71ce71a0 R14: 80000000000000df R15: 00007f3b71da601d
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

