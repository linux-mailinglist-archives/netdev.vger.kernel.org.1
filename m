Return-Path: <netdev+bounces-128739-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0BBF97B52A
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 23:28:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EB48282197
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 21:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22524190675;
	Tue, 17 Sep 2024 21:28:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940E418950D
	for <netdev@vger.kernel.org>; Tue, 17 Sep 2024 21:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726608486; cv=none; b=nObQubbOV7GSfaskRNCuYFiBwXqZNI1uhBEXp9VvPHzRaU+lhrIjHZNVYIrkjBXGEvb8lf6EDPZTZBEYTRzPHlHMJeSZKJ84RzBrjMSL/qf6XN5rqWjii/+JTZEe4q5lAGwS6ruYTmCbb2nin4k0eLiB7kF5vGpO7qtpiufKF64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726608486; c=relaxed/simple;
	bh=FFms0JSvc6Z0q5c1Qi9WXKX5XoFu2RsClrHkYr07ICY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=DLY3UJVVlF9XxYumZr4+lKKJu9O0E6+gS0eIgzf546OiuNnttyxhoDukNDV/rvflbnXDCvOkl/6xvvNFZc2isbv7L10CLuUxGsWp5CxlbQCoBa5pFNuZi9k7ZGNA6CrrIk+qDt2PZaR+WVneo7DQLvOJl8liMcDHJPFw3bPh7po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-82aa94d4683so1104206439f.3
        for <netdev@vger.kernel.org>; Tue, 17 Sep 2024 14:28:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726608483; x=1727213283;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7bDAHX/2HpeG8O0GYsUySOvXaZHBEvJDh7x2fWTnQJ0=;
        b=wUNXK1POYIZVp6lRdLwjJTy+2fiaKil2bTLkebT9cZaSOAbpMHc8zwXOMhh+eLFFgI
         nAA9gj+fYFnAIbI2ol3H0BgUDmb2arApQ7UVPyyoeXORRRkD1YQyncj3OIfTOsqlHoin
         F1JZZhfl5NpZc5okbirzd/fHKnnRHbCRyoKALKE+jFPiyE9a8UkMzf8D2g84KHGYNKTw
         zln4L6wSysX6uupf7vQ6FaZRAmvLEr/9gEPcu4mZH3SsjKjFi35fUvrMUtoOL3KRwbAN
         aq+J6nA34uzIcxywIDqnKkp6uoZvC3peFw5aq/9k914XFfVdHJc15tf3TJi15IlOP7aM
         4iRg==
X-Forwarded-Encrypted: i=1; AJvYcCXB6iYbgNtHSCPnHw/fZIZ6r7ceg+xA56UGQuIlqFAbIwkkj1L8yLsPOHmT1dR2iCOpUHlgKQE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRSm9GVd+G79N/GHKymKN0ILYVa32tYHx+UuJt6OuMNwSaxac/
	dM+xwgvzq/I7WFQTl8PYr5B/Ru0TZK1kO0KzoUyNcmk/iOiGtLnN8MOTaCRqSeTDMQyDQkedblx
	wbKzJMV70smuQCczTSI1vXonZiXOGFBtg9ZCFah4GzyYRU9UN2oPuzP4=
X-Google-Smtp-Source: AGHT+IFReLZrO4jwJzW8veawI7UH1yi9eJ8Twhb48vdnrlkmvEiNi2VB2VoI+z2BXtT5KR1MzxA5IUKoZqccQvSaeUy9x0PwHbo8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1e0a:b0:3a0:4d6b:42f7 with SMTP id
 e9e14a558f8ab-3a08b79a1a2mr148103725ab.22.1726608483655; Tue, 17 Sep 2024
 14:28:03 -0700 (PDT)
Date: Tue, 17 Sep 2024 14:28:03 -0700
In-Reply-To: <fc79c53e-a5a7-4ae2-a579-83fefea772c4@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000055b6570622575dba@google.com>
Subject: Re: [syzbot] [net?] possible deadlock in do_ip_setsockopt (4)
From: syzbot <syzbot+e4c27043b9315839452d@syzkaller.appspotmail.com>
To: alibuda@linux.alibaba.com, davem@davemloft.net, dsahern@kernel.org, 
	dust.li@linux.alibaba.com, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	schnelle@linux.ibm.com, srikarananta01@gmail.com, 
	syzkaller-bugs@googlegroups.com, wenjia@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
possible deadlock in do_ip_setsockopt

======================================================
WARNING: possible circular locking dependency detected
6.11.0-syzkaller-04557-g2f27fce67173-dirty #0 Not tainted
------------------------------------------------------
syz.0.15/6023 is trying to acquire lock:
ffff888025c40918 (sk_lock-AF_INET){+.+.}-{0:0}, at: do_ip_setsockopt+0x1a2d/0x3cd0 net/ipv4/ip_sockglue.c:1078

but task is already holding lock:
ffffffff8faa9708 (rtnl_mutex){+.+.}-{3:3}, at: do_ip_setsockopt+0x127d/0x3cd0 net/ipv4/ip_sockglue.c:1077

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (rtnl_mutex){+.+.}-{3:3}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5822
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
       smc_vlan_by_tcpsk+0x399/0x4e0 net/smc/smc_core.c:1898
       __smc_connect+0x292/0x1850 net/smc/af_smc.c:1518
       smc_connect+0x868/0xde0 net/smc/af_smc.c:1694
       __sys_connect_file net/socket.c:2067 [inline]
       __sys_connect+0x2d1/0x300 net/socket.c:2084
       __do_sys_connect net/socket.c:2094 [inline]
       __se_sys_connect net/socket.c:2091 [inline]
       __x64_sys_connect+0x7a/0x90 net/socket.c:2091
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (sk_lock-AF_INET){+.+.}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3158 [inline]
       check_prevs_add kernel/locking/lockdep.c:3277 [inline]
       validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3901
       __lock_acquire+0x1384/0x2050 kernel/locking/lockdep.c:5199
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5822
       lock_sock_nested+0x48/0x100 net/core/sock.c:3611
       do_ip_setsockopt+0x1a2d/0x3cd0 net/ipv4/ip_sockglue.c:1078
       ip_setsockopt+0x63/0x100 net/ipv4/ip_sockglue.c:1417
       do_sock_setsockopt+0x3af/0x720 net/socket.c:2330
       __sys_setsockopt+0x1a8/0x250 net/socket.c:2353
       __do_sys_setsockopt net/socket.c:2362 [inline]
       __se_sys_setsockopt net/socket.c:2359 [inline]
       __x64_sys_setsockopt+0xb5/0xd0 net/socket.c:2359
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(rtnl_mutex);
                               lock(sk_lock-AF_INET);
                               lock(rtnl_mutex);
  lock(sk_lock-AF_INET);

 *** DEADLOCK ***

1 lock held by syz.0.15/6023:
 #0: ffffffff8faa9708 (rtnl_mutex){+.+.}-{3:3}, at: do_ip_setsockopt+0x127d/0x3cd0 net/ipv4/ip_sockglue.c:1077

stack backtrace:
CPU: 0 UID: 0 PID: 6023 Comm: syz.0.15 Not tainted 6.11.0-syzkaller-04557-g2f27fce67173-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
 print_circular_bug+0x13a/0x1b0 kernel/locking/lockdep.c:2074
 check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2203
 check_prev_add kernel/locking/lockdep.c:3158 [inline]
 check_prevs_add kernel/locking/lockdep.c:3277 [inline]
 validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3901
 __lock_acquire+0x1384/0x2050 kernel/locking/lockdep.c:5199
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5822
 lock_sock_nested+0x48/0x100 net/core/sock.c:3611
 do_ip_setsockopt+0x1a2d/0x3cd0 net/ipv4/ip_sockglue.c:1078
 ip_setsockopt+0x63/0x100 net/ipv4/ip_sockglue.c:1417
 do_sock_setsockopt+0x3af/0x720 net/socket.c:2330
 __sys_setsockopt+0x1a8/0x250 net/socket.c:2353
 __do_sys_setsockopt net/socket.c:2362 [inline]
 __se_sys_setsockopt net/socket.c:2359 [inline]
 __x64_sys_setsockopt+0xb5/0xd0 net/socket.c:2359
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f34b9b79e79
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f34b95ff038 EFLAGS: 00000246 ORIG_RAX: 0000000000000036
RAX: ffffffffffffffda RBX: 00007f34b9d15f80 RCX: 00007f34b9b79e79
RDX: 0000000000000023 RSI: 0000000000000000 RDI: 0000000000000004
RBP: 00007f34b9be793e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f34b9d15f80 R15: 00007ffd22175db8
 </TASK>


Tested on:

commit:         2f27fce6 Merge tag 'sound-6.12-rc1' of git://git.kerne..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=104cb500580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c7e7e5a089fe8488
dashboard link: https://syzkaller.appspot.com/bug?extid=e4c27043b9315839452d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.

