Return-Path: <netdev+bounces-125106-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D2896BF33
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 15:56:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12D261C2439F
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 13:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D201DA609;
	Wed,  4 Sep 2024 13:56:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406961D88BF
	for <netdev@vger.kernel.org>; Wed,  4 Sep 2024 13:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725458185; cv=none; b=t9lYJ5Qz2aZKTVtvXKM9cpwwdaBY9vGP7CpVVUfy/swXEiUtSg06vA0i1h56BrlIa2fFK5l/7BFODdBm1BURXpLRI+bJku2z7iqFEs0R+fUUcuLHIhS1Nc62xaPtAPxJUuuY0OgBevkDZQq1prigI8hPeuKiyb8dx8iazZpwguY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725458185; c=relaxed/simple;
	bh=GnJ3J4LB9h3i3mrMXvLyRaIBcF3AkHF0QK2TBpFXWbU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=raL7LuZ0rtkoB4wRnZItte/UczOLrVvW/dgzd1kj08UmpLXDP3Lla+ejWSvX1vXRqGIsoovODD2VlfJN8zHlTBmJIRUi17k3vBjWOjnVw1rBGpvZ0lY+qgQOMkXf5itMBG2eCac6+E3Phpxe2fbPRJF/2hH7CZc4nodA/Z6E3KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-82a4f65fa5aso102443339f.1
        for <netdev@vger.kernel.org>; Wed, 04 Sep 2024 06:56:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725458183; x=1726062983;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SrzSFGTCyr4+MMyyh7GqVNUCiLJr5fc0UW/sfiKd6Ek=;
        b=fKrLDhjRDKAOaUAvVfH2eDkZ2xw7KnvysGXoK+G/Esr/iqxkC2va5G5cdkjsnROcGx
         UYyo8DLyQMv76S9uWP5wLp8dhBsWw9tIpYBDfi+3Fb84oi7/AO9UxTesS1g78zWT2rW+
         SEkDjTxctDFe5Fo79xSbg0OXn9MxGCa4lzYMab6vrxjp+YKEs8mP61WXCOeAPyRC1Bv8
         JtIiONPzKFOBx51fIVKFp0DinImt1lj1KdwowufhXr54k32ENxEnuwdqoDYt2xQmpZ+L
         PqyUB6LWRlC8X/I2a+6bkxTOjVbxnZCEdsZdjRD5Byipyw3rYPGbcg0Qm4q8EwPzCSPQ
         kZ3A==
X-Forwarded-Encrypted: i=1; AJvYcCUPgqVm6L8z+nApcr44Smp9kAaLB7ke7ow0KrV7BdeFScNWMhetw2vTJVSgYQ7xma2pFiXz/Q8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwckSYBDnDof87srnONrKGOnLSYvJ6BaGFY5QSf3ZtonHd0t4fQ
	mnTc96DrwuHdlqT2u1d0+BFCTmMR/DKQvGe1GzPb2b1h4wSpMEZMSwewgKS0pYHEOqtuPRUGDgl
	MeEliKpz/M7UmtMTbAbNBdrlE1+pWUWkRfDjRDNCKNPN+oMjMKhwBDlA=
X-Google-Smtp-Source: AGHT+IGSyNQ8Rtx94SawzEyABtvJRvCxW1pAg//QKH+j9QjhQO9b+/yGXAYCwPX22wqil4YEJFRC6aAefEOcIxCBRrMlZdBKD1Gi
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1491:b0:4ce:928f:ad9a with SMTP id
 8926c6da1cb9f-4d0600aa00dmr109910173.1.1725458183431; Wed, 04 Sep 2024
 06:56:23 -0700 (PDT)
Date: Wed, 04 Sep 2024 06:56:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001934d306214b8aa9@google.com>
Subject: [syzbot] [can?] WARNING in remove_proc_entry (6)
From: syzbot <syzbot+0532ac7a06fb1a03187e@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, kuniyu@amazon.com, linux-can@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mkl@pengutronix.de, netdev@vger.kernel.org, 
	pabeni@redhat.com, socketcan@hartkopp.net, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    5517ae241919 Merge tag 'for-net-2024-08-30' of git://git.k..
git tree:       net
console+strace: https://syzkaller.appspot.com/x/log.txt?x=111adcfb980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=996585887acdadb3
dashboard link: https://syzkaller.appspot.com/bug?extid=0532ac7a06fb1a03187e
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=138d43db980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11fe3d43980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ddded5c54678/disk-5517ae24.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ce0dfe9dbb55/vmlinux-5517ae24.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ca81d6e3361d/bzImage-5517ae24.xz

The issue was bisected to:

commit 76fe372ccb81b0c89b6cd2fec26e2f38c958be85
Author: Kuniyuki Iwashima <kuniyu@amazon.com>
Date:   Mon Jul 22 19:28:42 2024 +0000

    can: bcm: Remove proc entry when dev is unregistered.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=116f8e8f980000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=136f8e8f980000
console output: https://syzkaller.appspot.com/x/log.txt?x=156f8e8f980000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0532ac7a06fb1a03187e@syzkaller.appspotmail.com
Fixes: 76fe372ccb81 ("can: bcm: Remove proc entry when dev is unregistered.")

------------[ cut here ]------------
name '4986'
WARNING: CPU: 0 PID: 5234 at fs/proc/generic.c:711 remove_proc_entry+0x2e7/0x5d0 fs/proc/generic.c:711
Modules linked in:
CPU: 0 UID: 0 PID: 5234 Comm: syz-executor606 Not tainted 6.11.0-rc5-syzkaller-00178-g5517ae241919 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
RIP: 0010:remove_proc_entry+0x2e7/0x5d0 fs/proc/generic.c:711
Code: ff eb 05 e8 cb 1e 5e ff 48 8b 5c 24 10 48 c7 c7 e0 f7 aa 8e e8 2a 38 8e 09 90 48 c7 c7 60 3a 1b 8c 48 89 de e8 da 42 20 ff 90 <0f> 0b 90 90 48 8b 44 24 18 48 c7 44 24 40 0e 36 e0 45 49 c7 04 07
RSP: 0018:ffffc9000345fa20 EFLAGS: 00010246
RAX: 2a2d0aee2eb64600 RBX: ffff888032f1f548 RCX: ffff888029431e00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc9000345fb08 R08: ffffffff8155b2f2 R09: 1ffff1101710519a
R10: dffffc0000000000 R11: ffffed101710519b R12: ffff888011d38640
R13: 0000000000000004 R14: 0000000000000000 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8880b8800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fcfb52722f0 CR3: 000000000e734000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 bcm_release+0x250/0x880 net/can/bcm.c:1578
 __sock_release net/socket.c:659 [inline]
 sock_close+0xbc/0x240 net/socket.c:1421
 __fput+0x24a/0x8a0 fs/file_table.c:422
 task_work_run+0x24f/0x310 kernel/task_work.c:228
 exit_task_work include/linux/task_work.h:40 [inline]
 do_exit+0xa2f/0x27f0 kernel/exit.c:882
 do_group_exit+0x207/0x2c0 kernel/exit.c:1031
 __do_sys_exit_group kernel/exit.c:1042 [inline]
 __se_sys_exit_group kernel/exit.c:1040 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1040
 x64_sys_call+0x2634/0x2640 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fcfb51ee969
Code: Unable to access opcode bytes at 0x7fcfb51ee93f.
RSP: 002b:00007ffce0109ca8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007fcfb51ee969
RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000001
RBP: 00007fcfb526f3b0 R08: ffffffffffffffb8 R09: 0000555500000000
R10: 0000555500000000 R11: 0000000000000246 R12: 00007fcfb526f3b0
R13: 0000000000000000 R14: 00007fcfb5271ee0 R15: 00007fcfb51bf160
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

