Return-Path: <netdev+bounces-110664-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8868092DA9E
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 23:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC0BB1C2107A
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 21:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8886384D04;
	Wed, 10 Jul 2024 21:17:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED10839F3
	for <netdev@vger.kernel.org>; Wed, 10 Jul 2024 21:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720646244; cv=none; b=csMCABmehhkZQqfMaXRN+l1w9ndIzR36slkrAYJ1lMO4ARJUOstYocDKpb0njSQYR/thBBmVE7E1j0c3SBUqStER/+Zm9QpxNzu//4FKthttvLGhNqjDD5ntxWDCoI6CVNIZ6eyxv3Z+kJwA4WRwc7lYd3alWTFImy1g3B9urVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720646244; c=relaxed/simple;
	bh=gJYJBB0NsyzzqMUK7KfgIhOcbcB8cneMSWttlzudC2Q=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=A6fPyL3xXSzW4nlFL/x4UnnOhZl1RiDtW4S4rDWt++dkLBTpQxboPOyGo/xVm88dMc3jLMTgB5ikvVw71J6eXDEnRC5wA9jyMB5WtVTXVeH6hNhniqBXKs5i7m+bhyu7KVxgEQu8hK4L8wcWa8F9boGzzs/5oSTTL+nUODbZmJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7f92912a614so21256639f.2
        for <netdev@vger.kernel.org>; Wed, 10 Jul 2024 14:17:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720646242; x=1721251042;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7CMc7XLzacg8kfKZlW0Mj3vytwn0Qj3S+42+6j7j+dE=;
        b=ifECBbRPiWo100otqoAlhzv6MrXsshsLInQZGpNhfQWITub4hIybUoj7L61EVbM0AI
         Q37mHVzr9f3XAOHRFZ57R79NS/+d2cBkNVSUlFYiBaQipxvSxgzAuR5xn6jAKKnK4z2+
         aJlxOk1xbdFBW8LXU2ken+PYdmZBYQxjznLbyPlIrWjjNHq/aGSVJAnFsrnbOoARq7Wo
         3mkybqIj0TuA0Nnnm/qW0LX8gj6oKJsaE6kdzDhljJm0yd2KV7IQjnynoCXkZnZ++0YF
         xvIkn0a+V8EmIOUvwGrCTXXcJ9RH4YbSV0KYRxXUQYD3D3kQKnI521w25Yg4OZ0rHpnp
         V4MA==
X-Forwarded-Encrypted: i=1; AJvYcCXviECpuHMp+0+cEmmEXJTMEzIrtvuEWfzWSXx9WEnYeDhkocWNGospqUQHoObp55BSZ7OkWFB80gi/WglXqEGi962Ewjed
X-Gm-Message-State: AOJu0YzA7nqc9vrQ44PYzXopX16wZ0tbmCjVGkQ3/ee5TqbvDXaq/k1E
	1pNZu6ROQAV3iy13QmF7aExUuzHCDKTg14WytPZ1nOlCt4CzgIP4Fom3qM7CkE+mLX61bP0JVwz
	a1EL8q79oCzan5nLrQpz/Q+aNYvXWV/8SwgowOBhfj3NaEpQrlDAy5KY=
X-Google-Smtp-Source: AGHT+IFt9WpGMIVtdYuPIEYdZiSbqTU9SeqhxXTf69jeA/Soe1gQamKv+CmmpopZeIVr1MOyLppV4+AGD65aDUwcf0IGoTJSzAXm
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:831e:b0:4c0:73d0:3d77 with SMTP id
 8926c6da1cb9f-4c0b2b6b9damr514464173.5.1720646241959; Wed, 10 Jul 2024
 14:17:21 -0700 (PDT)
Date: Wed, 10 Jul 2024 14:17:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000955a0061ceb2c38@google.com>
Subject: [syzbot] [net?] possible deadlock in do_ip_getsockopt (3)
From: syzbot <syzbot+aa5e39930997b0fe3dba@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    0b58e108042b Add linux-next specific files for 20240703
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=171d06e1980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ed034204f2e40e53
dashboard link: https://syzkaller.appspot.com/bug?extid=aa5e39930997b0fe3dba
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1d079762feae/disk-0b58e108.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e53996c8d8c2/vmlinux-0b58e108.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a0bf21cdd844/bzImage-0b58e108.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+aa5e39930997b0fe3dba@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.10.0-rc6-next-20240703-syzkaller #0 Not tainted
------------------------------------------------------
syz.4.2164/18168 is trying to acquire lock:
ffffffff8f5ff788 (rtnl_mutex){+.+.}-{3:3}, at: do_ip_getsockopt+0x10f5/0x2940 net/ipv4/ip_sockglue.c:1702

but task is already holding lock:
ffff88807ce84c50 (&smc->clcsock_release_lock){+.+.}-{3:3}, at: smc_getsockopt+0x144/0x3e0 net/smc/af_smc.c:3144

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&smc->clcsock_release_lock){+.+.}-{3:3}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5816
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
       smc_switch_to_fallback+0x35/0xd00 net/smc/af_smc.c:902
       smc_sendmsg+0x11f/0x530 net/smc/af_smc.c:2779
       sock_sendmsg_nosec net/socket.c:730 [inline]
       __sock_sendmsg+0x221/0x270 net/socket.c:745
       __sys_sendto+0x3a4/0x4f0 net/socket.c:2204
       __do_sys_sendto net/socket.c:2216 [inline]
       __se_sys_sendto net/socket.c:2212 [inline]
       __x64_sys_sendto+0xde/0x100 net/socket.c:2212
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (sk_lock-AF_INET){+.+.}-{0:0}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5816
       lock_sock_nested+0x48/0x100 net/core/sock.c:3543
       do_ip_setsockopt+0x1a2d/0x3cd0 net/ipv4/ip_sockglue.c:1078
       ip_setsockopt+0x63/0x100 net/ipv4/ip_sockglue.c:1417
       do_sock_setsockopt+0x3af/0x720 net/socket.c:2324
       __sys_setsockopt+0x1ae/0x250 net/socket.c:2347
       __do_sys_setsockopt net/socket.c:2356 [inline]
       __se_sys_setsockopt net/socket.c:2353 [inline]
       __x64_sys_setsockopt+0xb5/0xd0 net/socket.c:2353
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (rtnl_mutex){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3158 [inline]
       check_prevs_add kernel/locking/lockdep.c:3277 [inline]
       validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3901
       __lock_acquire+0x1359/0x2000 kernel/locking/lockdep.c:5193
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5816
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
       do_ip_getsockopt+0x10f5/0x2940 net/ipv4/ip_sockglue.c:1702
       ip_getsockopt+0xed/0x2e0 net/ipv4/ip_sockglue.c:1765
       tcp_getsockopt+0x163/0x1c0 net/ipv4/tcp.c:4409
       smc_getsockopt+0x1d9/0x3e0 net/smc/af_smc.c:3154
       do_sock_getsockopt+0x373/0x850 net/socket.c:2386
       __sys_getsockopt+0x271/0x330 net/socket.c:2415
       __do_sys_getsockopt net/socket.c:2425 [inline]
       __se_sys_getsockopt net/socket.c:2422 [inline]
       __x64_sys_getsockopt+0xb5/0xd0 net/socket.c:2422
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  rtnl_mutex --> sk_lock-AF_INET --> &smc->clcsock_release_lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&smc->clcsock_release_lock);
                               lock(sk_lock-AF_INET);
                               lock(&smc->clcsock_release_lock);
  lock(rtnl_mutex);

 *** DEADLOCK ***

1 lock held by syz.4.2164/18168:
 #0: ffff88807ce84c50 (&smc->clcsock_release_lock){+.+.}-{3:3}, at: smc_getsockopt+0x144/0x3e0 net/smc/af_smc.c:3144

stack backtrace:
CPU: 0 UID: 0 PID: 18168 Comm: syz.4.2164 Not tainted 6.10.0-rc6-next-20240703-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_circular_bug+0x13a/0x1b0 kernel/locking/lockdep.c:2074
 check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2203
 check_prev_add kernel/locking/lockdep.c:3158 [inline]
 check_prevs_add kernel/locking/lockdep.c:3277 [inline]
 validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3901
 __lock_acquire+0x1359/0x2000 kernel/locking/lockdep.c:5193
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5816
 __mutex_lock_common kernel/locking/mutex.c:608 [inline]
 __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
 do_ip_getsockopt+0x10f5/0x2940 net/ipv4/ip_sockglue.c:1702
 ip_getsockopt+0xed/0x2e0 net/ipv4/ip_sockglue.c:1765
 tcp_getsockopt+0x163/0x1c0 net/ipv4/tcp.c:4409
 smc_getsockopt+0x1d9/0x3e0 net/smc/af_smc.c:3154
 do_sock_getsockopt+0x373/0x850 net/socket.c:2386
 __sys_getsockopt+0x271/0x330 net/socket.c:2415
 __do_sys_getsockopt net/socket.c:2425 [inline]
 __se_sys_getsockopt net/socket.c:2422 [inline]
 __x64_sys_getsockopt+0xb5/0xd0 net/socket.c:2422
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa7f3175bd9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fa7f2bff048 EFLAGS: 00000246 ORIG_RAX: 0000000000000037
RAX: ffffffffffffffda RBX: 00007fa7f3303f60 RCX: 00007fa7f3175bd9
RDX: 0000000000000029 RSI: 0000000000000000 RDI: 0000000000000005
RBP: 00007fa7f31e4aa1 R08: 00000000200000c0 R09: 0000000000000000
R10: 0000000020000080 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007fa7f3303f60 R15: 00007fffb5a9a058
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

