Return-Path: <netdev+bounces-130203-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE821989238
	for <lists+netdev@lfdr.de>; Sun, 29 Sep 2024 02:57:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B8551F238FC
	for <lists+netdev@lfdr.de>; Sun, 29 Sep 2024 00:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEE5F5661;
	Sun, 29 Sep 2024 00:57:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D78CDF71
	for <netdev@vger.kernel.org>; Sun, 29 Sep 2024 00:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727571450; cv=none; b=JYcQQ7Zn2N5wJSesdIzXA/S76el+QMjEcMA5qaS/hchxLdo8DtkdA3ekFQVC7EZn8sJcqZmFTsHQsT8Z5J2NG95dedsYbvDFicnvVdmf1wMsaOtaR2kmWpE5HxTA3RExNP0MrTLRZXz9CVLM81646JF+6VsMVf4DT7wlI6SpDWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727571450; c=relaxed/simple;
	bh=Lc+SLrsQn24h0M1JRsYpSoD8KksYE70xV6mwtP754nA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=H96OzN8ctWz820p5hMo6Yj9GhwfDIfjrs5h37/Sa+cFm+HYFjAQO51iBWUkqAH2lFU38mwujxeBTQxfa0eErCZvOFDgyzgHDZA32pPO14RkXjPBLOzz4IyfP6H7tbToT4cOLoI/qiUn/IUvJ2sB0xaxKchVmZD9V9pUfs6dh6SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-8324396d0abso301553039f.0
        for <netdev@vger.kernel.org>; Sat, 28 Sep 2024 17:57:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727571448; x=1728176248;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KxrlJcSpBKiuy6eFUK6TTJTXoFXK0vXRG0aDH5BlxfM=;
        b=JJeZCqlpUyz1rtG/hzC7kZWnos4bLK1eFsuZjHpMa65k46T1x+csLVQdw69eACm5EH
         eYYMOLqkegUhRXHrwUTMjrZ+fQdY1y85tvZVC62Rm/eIYlUcEOnwdg3RUZ4jeCDQitIp
         aE3J/QiH24yEdtGG0kKL+eMWnjGk53e0VmzpcrMJajNjnfFZZHzsFxMDRwMWLRA3JIIg
         r7I2Wd4xj6t2FRSSH6ZIxnvOKgb4W07kYfT1/JqrhHMyaVx5lQcc63EE+q8MYaSUL7yZ
         iaJtwxbaTkNV0gT2HRo+vw6CC1B7yQmd+xj8ufD4A9kAJEp5ibKkDXI/kaIiW26eVv5y
         DeAg==
X-Forwarded-Encrypted: i=1; AJvYcCXRxnEuPLWyPiJyTNENNORf7P6SjCk0WTl73TmannGCZVsgxfwn1w1Wffek6elJP1Bl7l1EEN8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTIljs95RCW+PT54yDaw4D5jZbyx7M2B7K58thNNUH2RWSF3Im
	MXN1ScKSZbP21PoqMvUPxqFiB85rXznXrP+3iR6kKTtrYhjzfv4cTxFSHlEL60J63dpXdyvVof1
	Chwy9cuztSZgoSrdIxR8dseon1nnHWtgv/Xr9jqkyk4jplS+545QCyH4=
X-Google-Smtp-Source: AGHT+IFbo5YCKNe94DEMG346dyv/Tz2upzDa0tOH8Dpcolfbxh2LrfBr3XzGvPPvPPj0SyLg6ERbgGMm4bMPOe2Dk6bidPS89Lgb
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1564:b0:3a0:4df2:52e2 with SMTP id
 e9e14a558f8ab-3a34515ca34mr64428765ab.4.1727571448338; Sat, 28 Sep 2024
 17:57:28 -0700 (PDT)
Date: Sat, 28 Sep 2024 17:57:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f8a5f8.050a0220.aab67.000d.GAE@google.com>
Subject: [syzbot] [net?] WARNING: locking bug in __task_rq_lock
From: syzbot <syzbot+bb50a872bcd6dacdf184@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    3efc57369a0c Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15dd3507980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a4fcb065287cdb84
dashboard link: https://syzkaller.appspot.com/bug?extid=bb50a872bcd6dacdf184
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c768566853d8/disk-3efc5736.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ee971b1b59e7/vmlinux-3efc5736.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ac1746db2a57/bzImage-3efc5736.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+bb50a872bcd6dacdf184@syzkaller.appspotmail.com

------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(1)
WARNING: CPU: 1 PID: 23115 at kernel/locking/lockdep.c:232 hlock_class kernel/locking/lockdep.c:232 [inline]
WARNING: CPU: 1 PID: 23115 at kernel/locking/lockdep.c:232 check_wait_context kernel/locking/lockdep.c:4823 [inline]
WARNING: CPU: 1 PID: 23115 at kernel/locking/lockdep.c:232 __lock_acquire+0x58c/0x2050 kernel/locking/lockdep.c:5149
Modules linked in:
CPU: 1 UID: 0 PID: 23115 Comm: syz.3.2691 Not tainted 6.11.0-syzkaller-11993-g3efc57369a0c #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:hlock_class kernel/locking/lockdep.c:232 [inline]
RIP: 0010:check_wait_context kernel/locking/lockdep.c:4823 [inline]
RIP: 0010:__lock_acquire+0x58c/0x2050 kernel/locking/lockdep.c:5149
Code: 00 00 83 3d 25 c6 ac 0e 00 75 23 90 48 c7 c7 60 c9 0a 8c 48 c7 c6 00 cc 0a 8c e8 df 87 e5 ff 48 ba 00 00 00 00 00 fc ff df 90 <0f> 0b 90 90 90 31 db 48 81 c3 c4 00 00 00 48 89 d8 48 c1 e8 03 0f
RSP: 0018:ffffc90003de7230 EFLAGS: 00010046
RAX: d1a9613a9312fe00 RBX: 0000000000001368 RCX: 0000000000040000
RDX: dffffc0000000000 RSI: 000000000003ffff RDI: 0000000000040000
RBP: 000000000000000f R08: ffffffff8155daa2 R09: 1ffff110170e519a
R10: dffffc0000000000 R11: ffffed10170e519b R12: ffff888030c08000
R13: 0000000000001368 R14: 1ffff1100618116f R15: ffff888030c08b78
FS:  00007fed1acf26c0(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020073030 CR3: 000000006781c000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5822
 _raw_spin_lock_nested+0x31/0x40 kernel/locking/spinlock.c:378
 raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:593
 raw_spin_rq_lock kernel/sched/sched.h:1505 [inline]
 __task_rq_lock+0xdf/0x3e0 kernel/sched/core.c:671
 ttwu_runnable kernel/sched/core.c:3732 [inline]
 try_to_wake_up+0x182/0x1480 kernel/sched/core.c:4184
 autoremove_wake_function+0x16/0x110 kernel/sched/wait.c:384
 __wake_up_common kernel/sched/wait.c:89 [inline]
 __wake_up_common_lock+0x132/0x1e0 kernel/sched/wait.c:106
 __unix_dgram_recvmsg+0x5f4/0x12f0 net/unix/af_unix.c:2462
 sock_recvmsg_nosec+0x190/0x1d0 net/socket.c:1051
 ____sys_recvmsg+0x3cd/0x480 net/socket.c:2819
 ___sys_recvmsg net/socket.c:2863 [inline]
 do_recvmmsg+0x45e/0xad0 net/socket.c:2957
 __sys_recvmmsg net/socket.c:3036 [inline]
 __do_sys_recvmmsg net/socket.c:3059 [inline]
 __se_sys_recvmmsg net/socket.c:3052 [inline]
 __x64_sys_recvmmsg+0x199/0x250 net/socket.c:3052
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fed19f7dff9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fed1acf2038 EFLAGS: 00000246 ORIG_RAX: 000000000000012b
RAX: ffffffffffffffda RBX: 00007fed1a136058 RCX: 00007fed19f7dff9
RDX: 0000000000010106 RSI: 00000000200000c0 RDI: 0000000000000004
RBP: 00007fed19ff0296 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000002 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007fed1a136058 R15: 00007fffc5862128
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

