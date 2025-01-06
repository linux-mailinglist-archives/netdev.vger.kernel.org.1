Return-Path: <netdev+bounces-155341-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AB4CA0202F
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 09:05:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 691B7163836
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 08:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28421A8F61;
	Mon,  6 Jan 2025 08:05:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366261A2631
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 08:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736150723; cv=none; b=Cj6aAdk1uUIkC1X02NS2rO5vd1p7udvJzkPSMrLGGNXipSnkP8TUFUAU8MIXrtXl9lZYkQDBxROdwTi7FI7qwISepPAncd8SwVLofzX6u2DxPskbA6lj/oRpOQWWIDeCbFYgft72l4Lza+LCxFqnW70jwxbEs4CoW8Ez6z8WrAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736150723; c=relaxed/simple;
	bh=+yEenEnJtLvheuZG8JZf0feiKgoRjwaiQwqGTifbvLY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=BQcALn51xFFlqZxU7j2nSklghu2elyz1M+JQSfhBy0uWZDu5WLqOS+4CWfyjCgRKKr1DtOQLkP07YDufw9l/xje0LFvTZs4pHZ7B1noAPEFP35s2b4rT6ZprA2FRE5XD5krYGXhOtMzk1FZndnV1UBjV/Dqqk5DaeysJnLNcRTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3a817e4aa67so138469475ab.2
        for <netdev@vger.kernel.org>; Mon, 06 Jan 2025 00:05:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736150721; x=1736755521;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rWnSjippfjCwamChnzU1OkyO4ljKRl/VTRyayhOx+VQ=;
        b=aEihZkX88iJyWl0GQhDfkv8KJqAYFw3bT+5yIMzctfE68pJoQHTo+5dlcuWZsm7XeU
         O5sPVml6I1oIYWviPvxqQ8p2NE5BbFTesPmD9Ip1pM2DSIjB6CEZqQmvXUJVHghEbj8g
         6d4WzJ1GTpEcQcLLmpfjBFyhVM0NLvBK89xL8BS4nz6rgKwp8XqJHmvTKFJDUdksW663
         +axY6tPRJdm16RPw5EjXM4gA22MK1TzBHGqWi0ridsCdzatjYJEdClmjBHUjOIhYsAc0
         4+AW+vJyjRwM1N0pOwN/mIen+MbXeBkoVIJ0tBQvLcHAPayCBjHKVOmYqIH++EzWjTs5
         OvHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFhMk2pat9rJQdcLLpd6G5WdsYWyasCe+DLSicnIJMI2EEfc4Zo6PS3e0ISuz9CUSe5xUKwYI=@vger.kernel.org
X-Gm-Message-State: AOJu0YySSXR2zdEpSVPA1Bb+/UcKcDdYPD40Ml31qKNiWpSjbjkLMVc1
	1hDKqZXM3fcYOprMM+lFX6OXduBdqA/3Tqp6y729BjZUAl7ZBx6XKf6VSOf/NDzyQiLKAy875Ap
	pwDwHOaZrP7RJlpmRYlnHqG54cW82Nk7T7UFSg+4+nyG7lSeQP1EMbM4=
X-Google-Smtp-Source: AGHT+IF/LmzNImSm3itCdllZF0YLd6lkVN4K1PYreAq4cqWs1k2SZUtBl4gHlinrtIuoEiXbAhjPZNmCElZ9TnZJIUrwlpTpY/JV
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1ca5:b0:3a7:a29b:c181 with SMTP id
 e9e14a558f8ab-3c2d2d4f1e4mr434284735ab.13.1736150721338; Mon, 06 Jan 2025
 00:05:21 -0800 (PST)
Date: Mon, 06 Jan 2025 00:05:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <677b8ec1.050a0220.a40f5.0002.GAE@google.com>
Subject: [syzbot] [net?] possible deadlock in ipv6_sock_mc_close (3)
From: syzbot <syzbot+9fb9097b40bf7ca5172c@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    56e6a3499e14 Merge tag 'trace-v6.13-rc5' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1170b6df980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dc863cc90857c683
dashboard link: https://syzkaller.appspot.com/bug?extid=9fb9097b40bf7ca5172c
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-56e6a349.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d952d2570d98/vmlinux-56e6a349.xz
kernel image: https://storage.googleapis.com/syzbot-assets/36778b1be0b7/bzImage-56e6a349.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9fb9097b40bf7ca5172c@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.13.0-rc5-syzkaller-00006-g56e6a3499e14 #0 Not tainted
------------------------------------------------------
syz.2.174/6655 is trying to acquire lock:
ffffffff8fedc988 (rtnl_mutex){+.+.}-{4:4}, at: ipv6_sock_mc_close+0xdb/0x120 net/ipv6/mcast.c:354

but task is already holding lock:
ffff888051730aa8 (&smc->clcsock_release_lock){+.+.}-{4:4}, at: smc_clcsock_release+0x75/0xe0 net/smc/smc_close.c:30

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&smc->clcsock_release_lock){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:585 [inline]
       __mutex_lock+0x19b/0xa60 kernel/locking/mutex.c:735
       smc_switch_to_fallback+0x2d/0xa00 net/smc/af_smc.c:903
       smc_sendmsg+0x13d/0x520 net/smc/af_smc.c:2778
       sock_sendmsg_nosec net/socket.c:711 [inline]
       __sock_sendmsg net/socket.c:726 [inline]
       ____sys_sendmsg+0xaaf/0xc90 net/socket.c:2583
       ___sys_sendmsg+0x135/0x1e0 net/socket.c:2637
       __sys_sendmsg+0x16e/0x220 net/socket.c:2669
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (sk_lock-AF_INET6){+.+.}-{0:0}:
       lock_sock_nested+0x3a/0xf0 net/core/sock.c:3622
       lock_sock include/net/sock.h:1623 [inline]
       sockopt_lock_sock net/core/sock.c:1126 [inline]
       sockopt_lock_sock+0x54/0x70 net/core/sock.c:1117
       do_ipv6_setsockopt+0x2160/0x4520 net/ipv6/ipv6_sockglue.c:567
       ipv6_setsockopt+0xcb/0x170 net/ipv6/ipv6_sockglue.c:993
       rawv6_setsockopt+0xd7/0x680 net/ipv6/raw.c:1054
       do_sock_setsockopt+0x222/0x480 net/socket.c:2313
       __sys_setsockopt+0x1a0/0x230 net/socket.c:2338
       __do_sys_setsockopt net/socket.c:2344 [inline]
       __se_sys_setsockopt net/socket.c:2341 [inline]
       __x64_sys_setsockopt+0xbd/0x160 net/socket.c:2341
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (rtnl_mutex){+.+.}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3161 [inline]
       check_prevs_add kernel/locking/lockdep.c:3280 [inline]
       validate_chain kernel/locking/lockdep.c:3904 [inline]
       __lock_acquire+0x249e/0x3c40 kernel/locking/lockdep.c:5226
       lock_acquire.part.0+0x11b/0x380 kernel/locking/lockdep.c:5849
       __mutex_lock_common kernel/locking/mutex.c:585 [inline]
       __mutex_lock+0x19b/0xa60 kernel/locking/mutex.c:735
       ipv6_sock_mc_close+0xdb/0x120 net/ipv6/mcast.c:354
       inet6_release+0x3f/0x70 net/ipv6/af_inet6.c:482
       __sock_release net/socket.c:640 [inline]
       sock_release+0x8e/0x1d0 net/socket.c:668
       smc_clcsock_release+0xb7/0xe0 net/smc/smc_close.c:34
       __smc_release+0x5c2/0x880 net/smc/af_smc.c:301
       smc_release+0x1fc/0x5f0 net/smc/af_smc.c:344
       __sock_release+0xb0/0x270 net/socket.c:640
       sock_close+0x1c/0x30 net/socket.c:1408
       __fput+0x3f8/0xb60 fs/file_table.c:450
       task_work_run+0x14e/0x250 kernel/task_work.c:239
       resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
       exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
       exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]
       __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
       syscall_exit_to_user_mode+0x27b/0x2a0 kernel/entry/common.c:218
       do_syscall_64+0xda/0x250 arch/x86/entry/common.c:89
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  rtnl_mutex --> sk_lock-AF_INET6 --> 
&smc->clcsock_release_lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&smc->clcsock_release_lock);
                               lock(sk_lock-AF_INET6);
                               lock(&smc->clcsock_release_lock);
  lock(rtnl_mutex);

 *** DEADLOCK ***

2 locks held by syz.2.174/6655:
 #0: ffff88804b71be08 (&sb->s_type->i_mutex_key#10){+.+.}-{4:4}, at: inode_lock include/linux/fs.h:818 [inline]
 #0: ffff88804b71be08 (&sb->s_type->i_mutex_key#10){+.+.}-{4:4}, at: __sock_release+0x86/0x270 net/socket.c:639
 #1: ffff888051730aa8 (&smc->clcsock_release_lock){+.+.}-{4:4}, at: smc_clcsock_release+0x75/0xe0 net/smc/smc_close.c:30

stack backtrace:
CPU: 3 UID: 0 PID: 6655 Comm: syz.2.174 Not tainted 6.13.0-rc5-syzkaller-00006-g56e6a3499e14 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_circular_bug+0x419/0x5d0 kernel/locking/lockdep.c:2074
 check_noncircular+0x31a/0x400 kernel/locking/lockdep.c:2206
 check_prev_add kernel/locking/lockdep.c:3161 [inline]
 check_prevs_add kernel/locking/lockdep.c:3280 [inline]
 validate_chain kernel/locking/lockdep.c:3904 [inline]
 __lock_acquire+0x249e/0x3c40 kernel/locking/lockdep.c:5226
 lock_acquire.part.0+0x11b/0x380 kernel/locking/lockdep.c:5849
 __mutex_lock_common kernel/locking/mutex.c:585 [inline]
 __mutex_lock+0x19b/0xa60 kernel/locking/mutex.c:735
 ipv6_sock_mc_close+0xdb/0x120 net/ipv6/mcast.c:354
 inet6_release+0x3f/0x70 net/ipv6/af_inet6.c:482
 __sock_release net/socket.c:640 [inline]
 sock_release+0x8e/0x1d0 net/socket.c:668
 smc_clcsock_release+0xb7/0xe0 net/smc/smc_close.c:34
 __smc_release+0x5c2/0x880 net/smc/af_smc.c:301
 smc_release+0x1fc/0x5f0 net/smc/af_smc.c:344
 __sock_release+0xb0/0x270 net/socket.c:640
 sock_close+0x1c/0x30 net/socket.c:1408
 __fput+0x3f8/0xb60 fs/file_table.c:450
 task_work_run+0x14e/0x250 kernel/task_work.c:239
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x27b/0x2a0 kernel/entry/common.c:218
 do_syscall_64+0xda/0x250 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe2ec385d29
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc27879538 EFLAGS: 00000246 ORIG_RAX: 00000000000001b4
RAX: 0000000000000000 RBX: 000000000000e61f RCX: 00007fe2ec385d29
RDX: 0000000000000000 RSI: 000000000000001e RDI: 0000000000000003
RBP: 00007fe2ec577ba0 R08: 0000000000000001 R09: 00007ffc2787982f
R10: 00007fe2ec200000 R11: 0000000000000246 R12: 000000000000e688
R13: 00007fe2ec575fa0 R14: 0000000000000032 R15: ffffffffffffffff
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

