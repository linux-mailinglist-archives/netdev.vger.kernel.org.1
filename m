Return-Path: <netdev+bounces-118788-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F657952CBA
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 12:47:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E281B24DF8
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 10:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B5AD1D47B5;
	Thu, 15 Aug 2024 10:13:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470091D4179
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 10:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723716806; cv=none; b=hcQKhawy6ccf8sbPS6at7KpPLegGjoNtwDB9xN7UcDLxFbIpRpEQkDRmVW3utJwWh2YcxNr5TpN9EcjVjKMe62sbKTvVlJF89jJ8eH87XktGmmMulgKG6qx5vUrQdtokhUdX7vKfXPwl06ZXNhoBqIY6DJCueo16Xo3IxrUmJ/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723716806; c=relaxed/simple;
	bh=H/runk4ETBl5ZTVZiBK2gCURQ7Jhw492KtHsDi334w0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ryJ4H9367PlUAjLbKKTABtlXxrbb+2x9F8I7v6eHkvYXfVc3sLTLZJMW20RdShOIW3poPHdgcr3kBDej1POEilTR0LGVWn6UyVhkBc7O7F0548LgJ8GRH6Ba8Sr5Uir6iwBQYH/3MNWNgHJvepdPddAKHn/8hTM9PmJCPvIFoIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-81f7fb0103fso175154739f.0
        for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 03:13:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723716804; x=1724321604;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kBi5rH5/kA9YYQAY6DHuhxmUe6UoZqyUDWh4SRjWXXc=;
        b=j2JOB5a6XM4ZT1y+gOg7W00WTr4+TpVNvfAo1gdEIBaU4sw3v/yWynPdzz6UJnAdHb
         qknN0Ot5MbpEYvCKKQQJI1ex23uv+gSyG2Q7du1c/E7DYNGuKN2/BmD4fMdfU5G8q7K7
         sSsdRNMjqHtJgtuUua5mNTzRZqdq/i5JC/u8Sadb2PDMXpgD+O7cghC2msHeqkf3opWQ
         qOE4ibNx9Uqquzyv2TZniehEhDmh9VT7HpjgF60uOwbY6vlu++u8evvK7o3DMmqFFzpq
         XRRTV3Ax56Sbv1jdTLNzATa7Uw/IOSuNBiAHDBjk9lny+qOGGgfQ3ELhSs4SXeU1gEQ0
         5gtQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNbfLMS6aA0I6jQYXdH7pFsOmtjvVS3vhuc4Bw8CoiluWhRqvDxu3gtXRxWXU2rzFNvh9FOpi3qNnVsQvd4OBp63J7gPJ8
X-Gm-Message-State: AOJu0YxipFTZU2WpPJtILyxioZN0cWrJlCOWJrInFoXFQU8sdCO8Q5M9
	wP+M6Oh6/1TdP1LYV+LTn/ujP0E40uAd39kDg+MJvaC6S9eaop+ehhOQr8yJt3YqpuTiwQ3qFj5
	3td6Lpy7fog8GY8a9r015mFgRKsi2WP7GOYe1aY4FqgAW63w1DfXqtJA=
X-Google-Smtp-Source: AGHT+IHkq3oKA9nCRY6YANq6cUPri7km0dAMK4znjzzMpL6JsfB6sDq2nZMVZ4at/yopWzj1tYdyFayW6Fkuu+tKt+62NbEoLJk/
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1381:b0:396:256a:2e01 with SMTP id
 e9e14a558f8ab-39d1be363d2mr1436935ab.1.1723716804394; Thu, 15 Aug 2024
 03:13:24 -0700 (PDT)
Date: Thu, 15 Aug 2024 03:13:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d1e06d061fb617c3@google.com>
Subject: [syzbot] [net?] possible deadlock in sockopt_lock_sock
From: syzbot <syzbot+819a360379cf16b5f0d3@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    cb2e5ee8e7a0 Merge tag 'usb-6.11-rc3' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=117b42f5980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=505ed4a1dd93463a
dashboard link: https://syzkaller.appspot.com/bug?extid=819a360379cf16b5f0d3
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b9161dd413ff/disk-cb2e5ee8.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a97ba0acb899/vmlinux-cb2e5ee8.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e959393b6d23/bzImage-cb2e5ee8.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+819a360379cf16b5f0d3@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.11.0-rc2-syzkaller-00302-gcb2e5ee8e7a0 #0 Not tainted
------------------------------------------------------
syz.0.601/6825 is trying to acquire lock:
ffff888016f53518 (sk_lock-AF_INET){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1607 [inline]
ffff888016f53518 (sk_lock-AF_INET){+.+.}-{0:0}, at: sockopt_lock_sock net/core/sock.c:1061 [inline]
ffff888016f53518 (sk_lock-AF_INET){+.+.}-{0:0}, at: sockopt_lock_sock+0x54/0x70 net/core/sock.c:1052

but task is already holding lock:
ffffffff8fa21de8 (rtnl_mutex){+.+.}-{3:3}, at: do_ip_setsockopt+0xf9/0x38b0 net/ipv4/ip_sockglue.c:1077

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (rtnl_mutex){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x175/0x9c0 kernel/locking/mutex.c:752
       ip_mroute_setsockopt+0x121/0x1440 net/ipv4/ipmr.c:1369
       do_ip_setsockopt+0x2e8/0x38b0 net/ipv4/ip_sockglue.c:948
       ip_setsockopt+0x59/0xf0 net/ipv4/ip_sockglue.c:1417
       udp_setsockopt+0x7d/0xd0 net/ipv4/udp.c:2806
       ipv6_setsockopt+0x175/0x1a0 net/ipv6/ipv6_sockglue.c:988
       tcp_setsockopt+0xa4/0x100 net/ipv4/tcp.c:3768
       smc_setsockopt+0x1b4/0xa00 net/smc/af_smc.c:3072
       do_sock_setsockopt+0x222/0x480 net/socket.c:2324
       __sys_setsockopt+0x1a4/0x270 net/socket.c:2347
       __do_sys_setsockopt net/socket.c:2356 [inline]
       __se_sys_setsockopt net/socket.c:2353 [inline]
       __x64_sys_setsockopt+0xbd/0x160 net/socket.c:2353
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (&smc->clcsock_release_lock){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x175/0x9c0 kernel/locking/mutex.c:752
       smc_switch_to_fallback+0x2d/0xa00 net/smc/af_smc.c:902
       smc_sendmsg+0x13d/0x520 net/smc/af_smc.c:2779
       sock_sendmsg_nosec net/socket.c:730 [inline]
       __sock_sendmsg net/socket.c:745 [inline]
       __sys_sendto+0x47f/0x4e0 net/socket.c:2204
       __do_sys_sendto net/socket.c:2216 [inline]
       __se_sys_sendto net/socket.c:2212 [inline]
       __x64_sys_sendto+0xe0/0x1c0 net/socket.c:2212
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (sk_lock-AF_INET){+.+.}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3133 [inline]
       check_prevs_add kernel/locking/lockdep.c:3252 [inline]
       validate_chain kernel/locking/lockdep.c:3868 [inline]
       __lock_acquire+0x24ed/0x3cb0 kernel/locking/lockdep.c:5142
       lock_acquire kernel/locking/lockdep.c:5759 [inline]
       lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5724
       lock_sock_nested+0x3a/0xf0 net/core/sock.c:3543
       lock_sock include/net/sock.h:1607 [inline]
       sockopt_lock_sock net/core/sock.c:1061 [inline]
       sockopt_lock_sock+0x54/0x70 net/core/sock.c:1052
       do_ip_setsockopt+0x101/0x38b0 net/ipv4/ip_sockglue.c:1078
       ip_setsockopt+0x59/0xf0 net/ipv4/ip_sockglue.c:1417
       udp_setsockopt+0x7d/0xd0 net/ipv4/udp.c:2806
       do_sock_setsockopt+0x222/0x480 net/socket.c:2324
       __sys_setsockopt+0x1a4/0x270 net/socket.c:2347
       __do_sys_setsockopt net/socket.c:2356 [inline]
       __se_sys_setsockopt net/socket.c:2353 [inline]
       __x64_sys_setsockopt+0xbd/0x160 net/socket.c:2353
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  sk_lock-AF_INET --> &smc->clcsock_release_lock --> rtnl_mutex

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(rtnl_mutex);
                               lock(&smc->clcsock_release_lock);
                               lock(rtnl_mutex);
  lock(sk_lock-AF_INET);

 *** DEADLOCK ***

1 lock held by syz.0.601/6825:
 #0: ffffffff8fa21de8 (rtnl_mutex){+.+.}-{3:3}, at: do_ip_setsockopt+0xf9/0x38b0 net/ipv4/ip_sockglue.c:1077

stack backtrace:
CPU: 1 UID: 0 PID: 6825 Comm: syz.0.601 Not tainted 6.11.0-rc2-syzkaller-00302-gcb2e5ee8e7a0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:119
 check_noncircular+0x31a/0x400 kernel/locking/lockdep.c:2186
 check_prev_add kernel/locking/lockdep.c:3133 [inline]
 check_prevs_add kernel/locking/lockdep.c:3252 [inline]
 validate_chain kernel/locking/lockdep.c:3868 [inline]
 __lock_acquire+0x24ed/0x3cb0 kernel/locking/lockdep.c:5142
 lock_acquire kernel/locking/lockdep.c:5759 [inline]
 lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5724
 lock_sock_nested+0x3a/0xf0 net/core/sock.c:3543
 lock_sock include/net/sock.h:1607 [inline]
 sockopt_lock_sock net/core/sock.c:1061 [inline]
 sockopt_lock_sock+0x54/0x70 net/core/sock.c:1052
 do_ip_setsockopt+0x101/0x38b0 net/ipv4/ip_sockglue.c:1078
 ip_setsockopt+0x59/0xf0 net/ipv4/ip_sockglue.c:1417
 udp_setsockopt+0x7d/0xd0 net/ipv4/udp.c:2806
 do_sock_setsockopt+0x222/0x480 net/socket.c:2324
 __sys_setsockopt+0x1a4/0x270 net/socket.c:2347
 __do_sys_setsockopt net/socket.c:2356 [inline]
 __se_sys_setsockopt net/socket.c:2353 [inline]
 __x64_sys_setsockopt+0xbd/0x160 net/socket.c:2353
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7feebe5779f9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007feebf2de038 EFLAGS: 00000246 ORIG_RAX: 0000000000000036
RAX: ffffffffffffffda RBX: 00007feebe706058 RCX: 00007feebe5779f9
RDX: 0000000000000030 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 00007feebe5e58ee R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007feebe706058 R15: 00007ffefa35bcf8
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

