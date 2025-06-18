Return-Path: <netdev+bounces-199212-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DFA0ADF701
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 21:43:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E506D1BC0D95
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 19:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9985217737;
	Wed, 18 Jun 2025 19:43:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E94719DF7A
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 19:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750275808; cv=none; b=QrQg20N0q6x9C0b+ZUi2wJWHqvC7/FG6G2UFC2Fb22EPrD+QjM4m/NINXD6PDe/OMbR1EBP4egztSTWqpxbirM+2KVqFKRrISOPl59AOH803usSHEK+APt+aF6q/C/xeBlVilhezypI5qdzZS2klgMVdLtVM2pBGG6BKl3XlIeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750275808; c=relaxed/simple;
	bh=0hdwv/euFd/Y4iXpIHRj3Tu+6YUBGyv8rq1IK+j3URU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=AF5l+2LGaiCrwnnBfdqN+Eoj642COZuzUHgeHFmv6Ql1EP/76JnLMSn27fJPOog2GzVdqwtdzUa+o2f0ArmcXyZZm22MsM8Fn+V7kbr7AwFtUKAwr3HgsbsK8OME9yMkVrfUVvlhS9KEnWiWY3l41VQ2KK1NKnvHCfObOyQTZI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3ddd01c6f9bso38335ab.1
        for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 12:43:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750275806; x=1750880606;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=axmabUhoiqs18YVE/FHnztb/wpyymJLiCH+JUt0UfPE=;
        b=aV2FHxkB6FPgX5bQgkkG7nJLGsKMlTkr4mi0z1OL99T8QR0nZBuatBY7DKm0ZXxBfl
         8yzSDcy8eZ5GeTtCTEQjy0smYtIa2NaHYfn0EB2gwtPvgnY24hzzJcSBse8wb+ZCFUp0
         Sweydnov9vCQY9pQDWNKHF1sF9xVXQEf97cJSNKPucQydaiWaC0L8EqOMywhl4MzS2jz
         yMOlIF7tMrms2CR12mJExhUJN9zSaN3/wUANtehlQXWWwjAm9m0N1CF1yD9kLtYk42bf
         +pW9K5mLUWm8MjbuXIurSz5vKiG2eE/Sa5I8mbiczy+GY0/tnba5z7fCAKULCZ4f7heY
         wB2w==
X-Forwarded-Encrypted: i=1; AJvYcCWlTxsBrrt+MsrnCopNzw9a3v7G05cfJYk4Z5JwEjZsXd9LYwGaC7pPzadnM45P14/sCF/ad0U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUL50rVxqnf70XiLosvBaKE8wZmx9kwdOECrylmZh1JwLo/KzE
	HNyL+tWFGXaCqOv3sx8TC9J27replGhxNCnByc+Th8fLwktt43bPUl8kP44AcdnYttw7aNY8aDj
	4JWPGLOlS2TTRUk6xWMbRFVwEKW9SVKnWjm7vUF/qv2zJXvpxw25E7HXdvHA=
X-Google-Smtp-Source: AGHT+IEql9lsPsKlHOgXDKYOOMCT0ibVujIUcUr3ORA+g9rCFw9qxLEON+YjqDjDJrNkPZHoDQpp7gh0DXJY0xdmaNB7R33S0C+c
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:ee1:b0:3dd:a0fc:1990 with SMTP id
 e9e14a558f8ab-3de301e365dmr10073795ab.3.1750275806196; Wed, 18 Jun 2025
 12:43:26 -0700 (PDT)
Date: Wed, 18 Jun 2025 12:43:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <685316de.050a0220.216029.0087.GAE@google.com>
Subject: [syzbot] [net?] WARNING: proc registration bug in atm_dev_register
From: syzbot <syzbot+8bd335d2ad3b93e80715@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    52da431bf03b Merge tag 'libnvdimm-fixes-6.16-rc3' of git:/..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=17c7de82580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4130f4d8a06c3e71
dashboard link: https://syzkaller.appspot.com/bug?extid=8bd335d2ad3b93e80715
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=175835d4580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16a7f90c580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/876c709c1090/disk-52da431b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/05dc22ed6dd4/vmlinux-52da431b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/564136f4ae57/bzImage-52da431b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8bd335d2ad3b93e80715@syzkaller.appspotmail.com

------------[ cut here ]------------
proc_dir_entry 'atm/atmtcp:0' already registered
WARNING: CPU: 0 PID: 5919 at fs/proc/generic.c:377 proc_register+0x455/0x5f0 fs/proc/generic.c:377
Modules linked in:
CPU: 0 UID: 0 PID: 5919 Comm: syz-executor284 Not tainted 6.16.0-rc2-syzkaller-00047-g52da431bf03b #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
RIP: 0010:proc_register+0x455/0x5f0 fs/proc/generic.c:377
Code: 48 89 f9 48 c1 e9 03 80 3c 01 00 0f 85 a2 01 00 00 48 8b 44 24 10 48 c7 c7 20 c0 c2 8b 48 8b b0 d8 00 00 00 e8 0c 02 1c ff 90 <0f> 0b 90 90 48 c7 c7 80 f2 82 8e e8 0b de 23 09 48 8b 4c 24 28 48
RSP: 0018:ffffc9000466fa30 EFLAGS: 00010282
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff817ae248
RDX: ffff888026280000 RSI: ffffffff817ae255 RDI: 0000000000000001
RBP: ffff8880232bed48 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000001 R12: ffff888076ed2140
R13: dffffc0000000000 R14: ffff888078a61340 R15: ffffed100edda444
FS:  00007f38b3b0c6c0(0000) GS:ffff888124753000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f38b3bdf953 CR3: 0000000076d58000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 proc_create_data+0xbe/0x110 fs/proc/generic.c:585
 atm_proc_dev_register+0x112/0x1e0 net/atm/proc.c:361
 atm_dev_register+0x46d/0x890 net/atm/resources.c:113
 atmtcp_create+0x77/0x210 drivers/atm/atmtcp.c:369
 atmtcp_attach drivers/atm/atmtcp.c:403 [inline]
 atmtcp_ioctl+0x2f9/0xd60 drivers/atm/atmtcp.c:464
 do_vcc_ioctl+0x12c/0x930 net/atm/ioctl.c:159
 sock_do_ioctl+0x115/0x280 net/socket.c:1190
 sock_ioctl+0x227/0x6b0 net/socket.c:1311
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl fs/ioctl.c:893 [inline]
 __x64_sys_ioctl+0x18b/0x210 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x4c0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f38b3b74459
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f38b3b0c198 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f38b3bfe318 RCX: 00007f38b3b74459
RDX: 0000000000000000 RSI: 0000000000006180 RDI: 0000000000000005
RBP: 00007f38b3bfe310 R08: 65732f636f72702f R09: 65732f636f72702f
R10: 65732f636f72702f R11: 0000000000000246 R12: 00007f38b3bcb0ac
R13: 00007f38b3b0c1a0 R14: 0000200000000200 R15: 00007f38b3bcb03b
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

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

