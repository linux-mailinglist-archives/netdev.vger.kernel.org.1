Return-Path: <netdev+bounces-154283-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 601A99FC9F5
	for <lists+netdev@lfdr.de>; Thu, 26 Dec 2024 10:34:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 721BB7A14A3
	for <lists+netdev@lfdr.de>; Thu, 26 Dec 2024 09:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D87A41B412A;
	Thu, 26 Dec 2024 09:34:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F175314A609
	for <netdev@vger.kernel.org>; Thu, 26 Dec 2024 09:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735205661; cv=none; b=CqBRVgy1qEGaWdbM8rAj737TMFZdt2yxb7KVjrWmFlOoqwiuCwK7VvOato/U6q1X7Kkv4Fiq5UT7s/rNtmB/+Q5puLPzVNQ83Gv6+5Keyu/tw6MQGuSAS1vDVIrq47uXtXss/7AQFJ2atr7H9t6FOQZTqhO/0IgA3GJ5ISzBkjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735205661; c=relaxed/simple;
	bh=gFfUvaRVld8uYZ0dTZOyHx7wCAtqLo0nnuvaR3D2PW4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=W2sc/Gq6R5oDdPX3HgmrogD5XriEE5JWpD9Q6e2kaeeffoUnrima2R9IxlxlWDNJ7X8QJ/euSu3GjJsspc/uqEnKvxV15X5gzOaoUeZNv731fmV1qBiJvJgpzdT9YnbBz98/KeXtpn2Un8I+VL+34fku3TSb/djvLhP1Avxm8AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3a819a4e83dso67849185ab.1
        for <netdev@vger.kernel.org>; Thu, 26 Dec 2024 01:34:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735205659; x=1735810459;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3gjJ2QZw+GbxH4wnXccbKsjuxiOWvyR2BCJd7KMG1QU=;
        b=xD5H8KqQjnKgcz/LvdZ1Z4rcI7+rK9uMeUr+0R+D/hMFNQXgNayJc+iPEVQdlPaZ5z
         a01u2RN8WpU5MV7IPB0NyyBpVcYb953WpmDXa8ID9Ic2/JCvMbtThiLQCtGGTOatzmf+
         m5zn3qs+vJNNpz6zx4eMUHcLMrHK/HrtVauDQOwpTQ0hLs+4/18UrJ+PjfIFCbjV6H/z
         Y8rh0FpkmlnXAJl8J3/ob+zUMTvIVaGN8w0J+9O9b29m1w/1/Nuv/1+PBuPpkienwszz
         9tFFSdGZxC5kc9lzUBwJaNxXthu0sbAEdF0t5tcXuc7M6PEKAlkfuBwhzAXhW6I+i1iU
         UjWA==
X-Forwarded-Encrypted: i=1; AJvYcCUJctwYVrcUMMTDveYk/wHU10wO7UJBRO5vxzNiPWmI9XkpaKZiEdbKJuYe2XL32tpWKtgoy/k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWYL4kxOFEAB+AFtzXl4xrm7lTP+hYkKgSKI+Y5Bzovllp46YA
	3fXtElUUU0PWReCrhmkYVdjDfvdENBTntuAwfA1RaU428maSNpRqEHIiGDf1w6GyobvEwBFDjPa
	ihRIriSz1ox4qW6wUh2i2xKwcWTsPSVC5YDW7fvhIneCFfXsUPu4HfhM=
X-Google-Smtp-Source: AGHT+IH2JGz6zMCsjB8yNcW292U7het1atzGt31jrG27q519eU9MdoItwDUXVurfmlxmum82foPuiarQOl+DAhLX65NMIRkjiau+
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3201:b0:3a7:e286:a560 with SMTP id
 e9e14a558f8ab-3c2d1aa30b7mr175254905ab.2.1735205659100; Thu, 26 Dec 2024
 01:34:19 -0800 (PST)
Date: Thu, 26 Dec 2024 01:34:19 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <676d231b.050a0220.2f3838.0461.GAE@google.com>
Subject: [syzbot] [net?] INFO: task hung in lock_sock_nested (5)
From: syzbot <syzbot+6ac73b3abf1b598863fa@syzkaller.appspotmail.com>
To: borisp@nvidia.com, davem@davemloft.net, edumazet@google.com, 
	horms@kernel.org, john.fastabend@gmail.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	sd@queasysnail.net, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    9268abe611b0 Merge branch 'net-lan969x-add-rgmii-support'
git tree:       net-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1760eadf980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b087c24b921cdc16
dashboard link: https://syzkaller.appspot.com/bug?extid=6ac73b3abf1b598863fa
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=122f74c4580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=155c0018580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8274f60b0163/disk-9268abe6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f7b3fde537e7/vmlinux-9268abe6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/db4cccf7caae/bzImage-9268abe6.xz

The issue was bisected to:

commit 47069594e67e882ec5c1d8d374f6aab037511509
Author: Sabrina Dubroca <sd@queasysnail.net>
Date:   Thu Dec 12 15:36:05 2024 +0000

    tls: implement rekey for TLS1.3

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13da8018580000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=103a8018580000
console output: https://syzkaller.appspot.com/x/log.txt?x=17da8018580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6ac73b3abf1b598863fa@syzkaller.appspotmail.com
Fixes: 47069594e67e ("tls: implement rekey for TLS1.3")

INFO: task syz-executor309:5851 blocked for more than 143 seconds.
      Not tainted 6.13.0-rc3-syzkaller-00762-g9268abe611b0 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor309 state:D stack:28496 pid:5851  tgid:5846  ppid:5845   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5369 [inline]
 __schedule+0x1850/0x4c30 kernel/sched/core.c:6756
 __schedule_loop kernel/sched/core.c:6833 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6848
 __lock_sock+0x1cd/0x330 net/core/sock.c:3079
 lock_sock_nested+0x9e/0x100 net/core/sock.c:3647
 lock_sock include/net/sock.h:1618 [inline]
 sockopt_lock_sock net/core/sock.c:1133 [inline]
 sk_setsockopt+0xebc/0x3290 net/core/sock.c:1290
 do_sock_setsockopt+0x2fb/0x720 net/socket.c:2320
 __sys_setsockopt net/socket.c:2349 [inline]
 __do_sys_setsockopt net/socket.c:2355 [inline]
 __se_sys_setsockopt net/socket.c:2352 [inline]
 __x64_sys_setsockopt+0x1ee/0x280 net/socket.c:2352
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f75d98ee4a9
RSP: 002b:00007f75d9888218 EFLAGS: 00000246 ORIG_RAX: 0000000000000036
RAX: ffffffffffffffda RBX: 00007f75d9978318 RCX: 00007f75d98ee4a9
RDX: 0000000000000007 RSI: 0000000000000001 RDI: 0000000000000003
RBP: 00007f75d9978310 R08: 0000000000000004 R09: 0000000000000000
R10: 0000000020000040 R11: 0000000000000246 R12: 00007f75d997831c
R13: 00007f75d9945074 R14: 506710fe2170a2df R15: bad24a4ac38a3241
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/30:
 #0: ffffffff8e937ae0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #0: ffffffff8e937ae0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffffffff8e937ae0 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x55/0x2a0 kernel/locking/lockdep.c:6744
2 locks held by getty/5592:
 #0: ffff888031a650a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc900032fb2f0 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x6a6/0x1e00 drivers/tty/n_tty.c:2211
1 lock held by syz-executor309/5847:
1 lock held by syz-executor309/5851:
 #0: ffff888025a18fd8 (sk_lock-AF_INET6){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1618 [inline]
 #0: ffff888025a18fd8 (sk_lock-AF_INET6){+.+.}-{0:0}, at: sockopt_lock_sock net/core/sock.c:1133 [inline]
 #0: ffff888025a18fd8 (sk_lock-AF_INET6){+.+.}-{0:0}, at: sk_setsockopt+0xebc/0x3290 net/core/sock.c:1290

=============================================

NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 30 Comm: khungtaskd Not tainted 6.13.0-rc3-syzkaller-00762-g9268abe611b0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x49c/0x4d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x198/0x320 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:162 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:234 [inline]
 watchdog+0xff6/0x1040 kernel/hung_task.c:397
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 5847 Comm: syz-executor309 Not tainted 6.13.0-rc3-syzkaller-00762-g9268abe611b0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:check_kcov_mode kernel/kcov.c:185 [inline]
RIP: 0010:write_comp_data kernel/kcov.c:246 [inline]
RIP: 0010:__sanitizer_cov_trace_const_cmp1+0x2f/0x90 kernel/kcov.c:300
Code: 8b 04 24 65 48 8b 14 25 00 d6 03 00 65 8b 05 00 5f 64 7e 25 00 01 ff 00 74 10 3d 00 01 00 00 75 5b 83 ba 1c 16 00 00 00 74 52 <8b> 82 f8 15 00 00 83 f8 03 75 47 48 8b 8a 00 16 00 00 44 8b 8a fc
RSP: 0018:ffffc9000404fb50 EFLAGS: 00000246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff88807eeb3c00
RDX: ffff88807eeb3c00 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc9000404fd70 R08: ffffffff8a5765c4 R09: ffffffff898aa128
R10: 000000000000002e R11: ffffffff8a576560 R12: dffffc0000000000
R13: ffff888025a18d80 R14: ffff888025a18d80 R15: ffff888027ebac00
FS:  00007f75d98a96c0(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055831e406600 CR3: 0000000031a76000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 tls_write_space+0x64/0x120 net/tls/tls_main.c:305
 sk_setsockopt+0x2142/0x3290 net/core/sock.c:1328
 do_sock_setsockopt+0x2fb/0x720 net/socket.c:2320
 __sys_setsockopt net/socket.c:2349 [inline]
 __do_sys_setsockopt net/socket.c:2355 [inline]
 __se_sys_setsockopt net/socket.c:2352 [inline]
 __x64_sys_setsockopt+0x1ee/0x280 net/socket.c:2352
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f75d98ee4a9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f75d98a9218 EFLAGS: 00000246 ORIG_RAX: 0000000000000036
RAX: ffffffffffffffda RBX: 00007f75d9978308 RCX: 00007f75d98ee4a9
RDX: 0000000000000007 RSI: 0000000000000001 RDI: 0000000000000003
RBP: 00007f75d9978300 R08: 0000000000000004 R09: 0000000000000000
R10: 0000000020000040 R11: 0000000000000246 R12: 00007f75d997830c
R13: 00007f75d9945074 R14: 506710fe2170a2df R15: bad24a4ac38a3241
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

