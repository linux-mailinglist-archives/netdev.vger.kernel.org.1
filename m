Return-Path: <netdev+bounces-110599-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63A3E92D5AD
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 18:04:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 172D728A3F0
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 16:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FAC2194A74;
	Wed, 10 Jul 2024 16:04:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2881946AD
	for <netdev@vger.kernel.org>; Wed, 10 Jul 2024 16:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720627464; cv=none; b=o71GaelMqy1hArbJyKI6TbZLFKi9paF5QvKLNCCALamrZIKEN3AhJhAvPCP7sIScxmxeyto5Im9zw1NtabBT09yA1Xo+Q7f2eDWy/Pr8RqPH1KGXNpgduOcgQB8sAFZmy4H5ySXU8Sv7oa0NyheASvdzVoQ6CBQL7io5nQpRGgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720627464; c=relaxed/simple;
	bh=LllsL5iYL2EuD5shk7/hyUf2cxUJt4WRXYOZLUohAaA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Vlv8m7SIC3/Z/O6ALrjoErG8pI61c+LnQEWpjGDYTXsXkTh/GXcP1cWzdyHMOETSQw/UKeuWpe6dcKIk2QK/55LW11gdgCuXrNOwpSrK2UIxmlPBp9B9Sh++1ONfI15ZUMsJa4d8M01CrFfWV70/u86DxA67bWb3oeNqpNZ0ccg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-80376d9cf1eso202154639f.1
        for <netdev@vger.kernel.org>; Wed, 10 Jul 2024 09:04:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720627462; x=1721232262;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/9VI5ReAEScG64yj2PchZYwPJ7ZyvHev/6hwoti15ec=;
        b=MvfJTd42jPphDoXPBRIcdeURr08olviCyz3DnAxdVuh2oWvqPEH2Cw4FAdp53gQONj
         nUT4hyBF0DIKIwCzLokUGM1bUxuidkTlufYCWeujkzoAQivZ9i13LEnhIMAChTa2SKBu
         esU0EkRMavy1tnl32BumJF3XtRpUK+VKZAS0l6leRCsqubgpoRhYCyfAD8UUt5DJWLD/
         SLje6iQ/wQpfGgYhy2o5a9a/LAfM2V3wBySAWI8FJReE8My+h5m/LrhkhuVPcLG/2S4P
         mjGgPrODibVLKFiWBIZIWpAEUMyNc1NAAbqmN3NPPUCNY1uXaCiEOrbkm12VaX+v8UvC
         9pvg==
X-Forwarded-Encrypted: i=1; AJvYcCXfOwuOs7Uo6ODiTrTS0KE6c5ywM+5xGmgCltxFYHk/cjC3qjnmh69aq1eEbgUjGm6vCae3qfU51Ha0u9Lr1VLOcLxcSMbW
X-Gm-Message-State: AOJu0YykOepjI6Dz6lojIwwDDviiq/rGmozov/LGlKidF8wyFOIbFZsm
	vmCDG53I8uZ57gbdS6M/Oo4ipbEc9P5WF7y8ypVQ+Fa9zkzu4UIvlJz0OTVMWcsr5LhziUc70R9
	ArXvHu3OskycZqJUZvO3SHLtv7f01U5N2s+6O2FVqPzfQ+RWW87+z5us=
X-Google-Smtp-Source: AGHT+IG8GZ1mBJjhadsEO7HVWPtK+WeixWhH3S7AdIRZ5AsYP0f9Q5iJj6vITVB2HJGsjJBzOV+FuIFoOjymBQy3z0NYHvsBFu7Y
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:9827:b0:4b7:c9b5:675c with SMTP id
 8926c6da1cb9f-4c0b2b907f6mr396660173.6.1720627461875; Wed, 10 Jul 2024
 09:04:21 -0700 (PDT)
Date: Wed, 10 Jul 2024 09:04:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a7fb55061ce6cc5a@google.com>
Subject: [syzbot] [net?] possible deadlock in do_ipv6_setsockopt (4)
From: syzbot <syzbot+3433b5cb8b2b70933f8d@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2f5e6395714d Merge branch 'net-pse-pd-add-new-pse-c33-feat..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=16f7e781980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=db697e01efa9d1d7
dashboard link: https://syzkaller.appspot.com/bug?extid=3433b5cb8b2b70933f8d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/44296878e8d6/disk-2f5e6395.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a3f8523e4843/vmlinux-2f5e6395.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c40a60a2869f/bzImage-2f5e6395.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3433b5cb8b2b70933f8d@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.10.0-rc6-syzkaller-01258-g2f5e6395714d #0 Not tainted
------------------------------------------------------
syz.4.1060/8537 is trying to acquire lock:
ffffffff8f5e7f48 (rtnl_mutex){+.+.}-{3:3}, at: do_ipv6_setsockopt+0x9e4/0x3630 net/ipv6/ipv6_sockglue.c:566

but task is already holding lock:
ffff88807b8c0a50 (&smc->clcsock_release_lock){+.+.}-{3:3}, at: smc_setsockopt+0x1c3/0xe50 net/smc/af_smc.c:3064

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&smc->clcsock_release_lock){+.+.}-{3:3}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
       smc_switch_to_fallback+0x35/0xd00 net/smc/af_smc.c:902
       smc_sendmsg+0x11f/0x530 net/smc/af_smc.c:2779
       sock_sendmsg_nosec net/socket.c:730 [inline]
       __sock_sendmsg+0x221/0x270 net/socket.c:745
       __sys_sendto+0x3a4/0x4f0 net/socket.c:2192
       __do_sys_sendto net/socket.c:2204 [inline]
       __se_sys_sendto net/socket.c:2200 [inline]
       __x64_sys_sendto+0xde/0x100 net/socket.c:2200
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (sk_lock-AF_INET){+.+.}-{0:0}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
       lock_sock_nested+0x48/0x100 net/core/sock.c:3543
       do_ip_setsockopt+0x1a2d/0x3cd0 net/ipv4/ip_sockglue.c:1078
       ip_setsockopt+0x63/0x100 net/ipv4/ip_sockglue.c:1417
       do_sock_setsockopt+0x3af/0x720 net/socket.c:2312
       __sys_setsockopt+0x1ae/0x250 net/socket.c:2335
       __do_sys_setsockopt net/socket.c:2344 [inline]
       __se_sys_setsockopt net/socket.c:2341 [inline]
       __x64_sys_setsockopt+0xb5/0xd0 net/socket.c:2341
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (rtnl_mutex){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain+0x18e0/0x5900 kernel/locking/lockdep.c:3869
       __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
       do_ipv6_setsockopt+0x9e4/0x3630 net/ipv6/ipv6_sockglue.c:566
       ipv6_setsockopt+0x5c/0x1a0 net/ipv6/ipv6_sockglue.c:993
       smc_setsockopt+0x275/0xe50 net/smc/af_smc.c:3072
       do_sock_setsockopt+0x3af/0x720 net/socket.c:2312
       __sys_setsockopt+0x1ae/0x250 net/socket.c:2335
       __do_sys_setsockopt net/socket.c:2344 [inline]
       __se_sys_setsockopt net/socket.c:2341 [inline]
       __x64_sys_setsockopt+0xb5/0xd0 net/socket.c:2341
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

1 lock held by syz.4.1060/8537:
 #0: ffff88807b8c0a50 (&smc->clcsock_release_lock){+.+.}-{3:3}, at: smc_setsockopt+0x1c3/0xe50 net/smc/af_smc.c:3064

stack backtrace:
CPU: 1 PID: 8537 Comm: syz.4.1060 Not tainted 6.10.0-rc6-syzkaller-01258-g2f5e6395714d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2187
 check_prev_add kernel/locking/lockdep.c:3134 [inline]
 check_prevs_add kernel/locking/lockdep.c:3253 [inline]
 validate_chain+0x18e0/0x5900 kernel/locking/lockdep.c:3869
 __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
 __mutex_lock_common kernel/locking/mutex.c:608 [inline]
 __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
 do_ipv6_setsockopt+0x9e4/0x3630 net/ipv6/ipv6_sockglue.c:566
 ipv6_setsockopt+0x5c/0x1a0 net/ipv6/ipv6_sockglue.c:993
 smc_setsockopt+0x275/0xe50 net/smc/af_smc.c:3072
 do_sock_setsockopt+0x3af/0x720 net/socket.c:2312
 __sys_setsockopt+0x1ae/0x250 net/socket.c:2335
 __do_sys_setsockopt net/socket.c:2344 [inline]
 __se_sys_setsockopt net/socket.c:2341 [inline]
 __x64_sys_setsockopt+0xb5/0xd0 net/socket.c:2341
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f0383b75bd9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f0384934048 EFLAGS: 00000246 ORIG_RAX: 0000000000000036
RAX: ffffffffffffffda RBX: 00007f0383d03f60 RCX: 00007f0383b75bd9
RDX: 0000000000000001 RSI: 0000000000000029 RDI: 0000000000000007
RBP: 00007f0383be4aa1 R08: 0000000000000004 R09: 0000000000000000
R10: 0000000020000080 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f0383d03f60 R15: 00007ffd8c5ba008
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

