Return-Path: <netdev+bounces-106821-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC2F3917CED
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 11:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BE581C210A7
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 09:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41B2516CD1F;
	Wed, 26 Jun 2024 09:50:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C73316CD2D
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 09:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719395422; cv=none; b=G54BuEU9xZGy1mrSYEFN3bcumq6eiLTQB90QuflMFcUEqYd+gwIC5oFE9mf583zKdEvN8BNtMNBkODXWchoUvTdGRJZ1DAFHcu+/EHOtDMhxsNxpmx9YQkrTSLsSgyQWWOzVvunzS0P6NvCRS83bw5O2Z3Oa0F6unbv/UTcnuYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719395422; c=relaxed/simple;
	bh=FdwIYfJMuRgpRF3HEdFn+ppVvG8cymDZxdWC8pVYh8U=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=nuYODlLCGlFmTcH4OFVxyfqsA7fKzX1TsOUzaZHWSujOVdJO0fdZu+wU49AoZWulK/WLdA7S6whAVrNFPTFIoqauNJARcFTvIutL28ykj4rg+irm0BdUQsmSZIitbhlL7sgfM5t0fB1LnaBb9sbqDsQ/fFW6+6M4vL+mSUWyd9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-7f3c81ae072so172638239f.3
        for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 02:50:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719395420; x=1720000220;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TTKE9mfMOdpWSVVFAZbkXWyMcJ107p9GYE63ltOmdxI=;
        b=omC52KpSDu8rka39IPATK9/rxbjrcqw6lQXFsC9oNvj4mIf+rzmaz2l/oF6/to1RQj
         tpOxRce1keGdQZR3Et7OjNAPEuNTfLkBelNHY79/xy2SUmxFCnYS30kRNjWcd10hfmvz
         U6Qcgc3kWYA+Q/omJD+H7GsgNLCrUcPhIiiOsRP9o4yNrMHojY3ghbyIM51tJLfV+COb
         iIQmjgcRMWJ96TGIMXxfQsi6eb/teu61KQFkAE+aFpvMIpFtEXOdNBEmXutm8G4jB7zP
         8cLDLN0p6LiHtTvZeaw0HYJMnBvV3F71cI7ofQmvYfYZEJwwNY1obVcpB1gTSOtDVV90
         mFaA==
X-Forwarded-Encrypted: i=1; AJvYcCUxMpd+OBIyKNWf0soEaAi+RzF6FJNgSs8MjdZ1hLOxsfXbvbTFSX3Y8MUY40VkcXDT8+nWBesF5hu6bzgaGLKro9fcnfmX
X-Gm-Message-State: AOJu0YzB0XqsS0K/c+ZcD33yyTdJ2+wl0gcovvMnaIiZjoQr8xPnNFqV
	WqJu/fAR6NWW3lQO/2vl7gXfUP62kks3Y/4Gpl7CglFZgPrnyNUPAo60FAvPoSlMV27HRdg842W
	WrAbuGBr1c3DXSzAB6jRmC/S9Q4xuMGnh6E4KT5I5frW3YsXKqmyX+Y0=
X-Google-Smtp-Source: AGHT+IGfvDWqTDnsvKtr9DH6aYvG6H5PE5xEQXwTDbnt1dVe8eMVbHUjgpfbA+DJbH4nWwrGp6jZaF76p5vL7J3BmA+679mKVjug
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:641f:b0:7eb:b22f:b7a8 with SMTP id
 ca18e2360f4ac-7f3a74be81emr39177339f.1.1719395419804; Wed, 26 Jun 2024
 02:50:19 -0700 (PDT)
Date: Wed, 26 Jun 2024 02:50:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000039e8e1061bc7f16f@google.com>
Subject: [syzbot] [net?] possible deadlock in do_ip_setsockopt (4)
From: syzbot <syzbot+e4c27043b9315839452d@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    73cfd947dbdb net: ethernet: mtk_eth_soc: ppe: prevent ppe ..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=139ee301980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e78fc116033e0ab7
dashboard link: https://syzkaller.appspot.com/bug?extid=e4c27043b9315839452d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f7f95ead320b/disk-73cfd947.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2bb36264003f/vmlinux-73cfd947.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d854697a8694/bzImage-73cfd947.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e4c27043b9315839452d@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.10.0-rc4-syzkaller-00909-g73cfd947dbdb #0 Not tainted
------------------------------------------------------
syz.2.3207/15261 is trying to acquire lock:
ffffffff8f5e7288 (rtnl_mutex){+.+.}-{3:3}, at: do_ip_setsockopt+0x127d/0x3cd0 net/ipv4/ip_sockglue.c:1077

but task is already holding lock:
ffff88804708c150 (&smc->clcsock_release_lock){+.+.}-{3:3}, at: smc_setsockopt+0x1c3/0xe50 net/smc/af_smc.c:3064

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
       do_ip_setsockopt+0x127d/0x3cd0 net/ipv4/ip_sockglue.c:1077
       ip_setsockopt+0x63/0x100 net/ipv4/ip_sockglue.c:1417
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

1 lock held by syz.2.3207/15261:
 #0: ffff88804708c150 (&smc->clcsock_release_lock){+.+.}-{3:3}, at: smc_setsockopt+0x1c3/0xe50 net/smc/af_smc.c:3064

stack backtrace:
CPU: 0 PID: 15261 Comm: syz.2.3207 Not tainted 6.10.0-rc4-syzkaller-00909-g73cfd947dbdb #0
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
 do_ip_setsockopt+0x127d/0x3cd0 net/ipv4/ip_sockglue.c:1077
 ip_setsockopt+0x63/0x100 net/ipv4/ip_sockglue.c:1417
 smc_setsockopt+0x275/0xe50 net/smc/af_smc.c:3072
 do_sock_setsockopt+0x3af/0x720 net/socket.c:2312
 __sys_setsockopt+0x1ae/0x250 net/socket.c:2335
 __do_sys_setsockopt net/socket.c:2344 [inline]
 __se_sys_setsockopt net/socket.c:2341 [inline]
 __x64_sys_setsockopt+0xb5/0xd0 net/socket.c:2341
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fec50775ae9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fec514fe048 EFLAGS: 00000246 ORIG_RAX: 0000000000000036
RAX: ffffffffffffffda RBX: 00007fec50903fa0 RCX: 00007fec50775ae9
RDX: 0000000000000023 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 00007fec507f6746 R08: 000000000000000c R09: 0000000000000000
R10: 000000002000e040 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007fec50903fa0 R15: 00007fff4616c208
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

