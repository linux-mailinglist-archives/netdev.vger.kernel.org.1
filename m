Return-Path: <netdev+bounces-223216-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08EE6B585A5
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 21:57:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E1C31883164
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 19:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F15627E074;
	Mon, 15 Sep 2025 19:57:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5AF6279DC8
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 19:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757966252; cv=none; b=oQ3bUD5Ws07rChCAE16sSsHQ+q3Gu0EEaBSTYYwNyLCUBaF9F2cfWvhooliH2mrf0nK1bKZPJHMxRmcvcbTlwst7VMhqcqUUBqrpS+cvSJuo0QwaUZqCvW03xlfnPNBBGl6GT54lKCkrVY7RXzqErwHDoaabaRH7X5GkeJxABlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757966252; c=relaxed/simple;
	bh=VWgGilGF/rjd71gdgLN4FzRihvvihonjoWSLYGIKoDE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=jTMnw7ZEq6kcRIqjl5/iJNcK7kGsw5e0TCD8Bms4vfpO8AwXR5dJGj9ctJQ/69glotRZKpM4VaWBPAVDCXm6irZSf6MHoH+qIwqgcf4ZEULfppC/Ox3ONgG7TGA+awm/otxh0x187y8617+nvgl815ur1/Y5gjDPipIOcDmm9QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-4240c9b72e8so8887415ab.1
        for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 12:57:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757966250; x=1758571050;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u7u677u+FRX2HTabBo3vsuCN2+Wdc3q65kRzXTtKfSg=;
        b=YVV/pb0kEEMT4SsLLil2HnhbsHB3kQaKnHpIrwSIAbIQ4Q2oji+HD7HXttxFURUz+A
         MMuYFJbN6A6gr3SrV+jrRREBTepScC8FwtV/85BTRDcUY3HxvKgUPvvtEQVEJN7JfYmf
         c8Z0Pqffn1Dfl92necB1gwtJ7Q1hn4jaS3uqj5+DaCd8gBObYZsr4GPS7q3ysF79yDmV
         EOGovZRWXOv0Pgzc6YG0dB7u3+m71PvEif1EXqqoYKG7fww2/EEekLPdtnv8WuBOK+1g
         Y3SwsCCPUWYcSNd2CN4AW3uboAftDU130Kg+7kRLA4VSe0zv2QYS+HOjmmI/QjMsmy9Z
         LNqA==
X-Forwarded-Encrypted: i=1; AJvYcCW/eEIPfNizI/7A8jmGAMgymcZBB/JrvCjjtplmziLLgx/tXoXT9QHpdymBGD8yqSjk2lEet9E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSp83VQ18QeN7AMlmQn18p26cl7usAMBKN85Kx36Qa1PXH2tf7
	QsHD7ZuRGLGd7PRcL6UzComxGNiyrTaa0v1SyAO108CjM3NFm29aE9rEpmELnNSOJFypTWD9ntm
	foJp+pdSNxpNkwLrN9zdos6nGOAERIvtUB4LM5mxkP43GrlBpuNBgvp7Tv7w=
X-Google-Smtp-Source: AGHT+IEfW6NwqGU1Snh4ZVpBc4AtlgMUTmqs/A7vV7cjMiciIcZxMmgNB6nJ/Y1zq86wHuMMLHk0dkHwGb1E20or0kvVnM1b8i6g
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:19cf:b0:412:fa25:dd54 with SMTP id
 e9e14a558f8ab-4209e36cf49mr163685275ab.14.1757966249805; Mon, 15 Sep 2025
 12:57:29 -0700 (PDT)
Date: Mon, 15 Sep 2025 12:57:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68c86fa9.050a0220.2ff435.03ac.GAE@google.com>
Subject: [syzbot] [net?] WARNING in add_timer
From: syzbot <syzbot+07b635b9c111c566af8b@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    63a796558bc2 Revert "net: usb: asix: ax88772: drop phylink..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=11906b12580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9c302bcfb26a48af
dashboard link: https://syzkaller.appspot.com/bug?extid=07b635b9c111c566af8b
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2ee11780421b/disk-63a79655.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ea93cc1dbd6d/vmlinux-63a79655.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1ca443049a6a/bzImage-63a79655.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+07b635b9c111c566af8b@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 6273 at kernel/time/timer.c:1247 add_timer+0x73/0x90 kernel/time/timer.c:1247
Modules linked in:
CPU: 1 UID: 0 PID: 6273 Comm: syz.4.86 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
RIP: 0010:add_timer+0x73/0x90 kernel/time/timer.c:1247
Code: e8 03 42 80 3c 38 00 74 05 e8 69 1d 76 00 48 8b 73 10 48 89 df ba 04 00 00 00 5b 41 5e 41 5f e9 d3 ef ff ff e8 ee ab 12 00 90 <0f> 0b 90 5b 41 5e 41 5f c3 cc cc cc cc cc 66 66 66 66 66 66 2e 0f
RSP: 0018:ffffc9000b847980 EFLAGS: 00010293
RAX: ffffffff81ad0262 RBX: ffffffff8f742880 RCX: ffff88802e6e9e00
RDX: 0000000000000000 RSI: 00000000000061d8 RDI: ffffffff8f742880
RBP: ffffc9000b847ac8 R08: ffff88801b68f8fb R09: 1ffff110036d1f1f
R10: dffffc0000000000 R11: ffffed10036d1f20 R12: 00000000000061d8
R13: ffff88807e627000 R14: ffffffff8f742888 R15: dffffc0000000000
FS:  00007fdd1c7e46c0(0000) GS:ffff888125d18000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000056332c8bc2b8 CR3: 0000000028848000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 mpc_timer_refresh net/atm/mpc.c:1419 [inline]
 atm_mpoa_mpoad_attach net/atm/mpc.c:802 [inline]
 atm_mpoa_ioctl+0x2c3/0xca0 net/atm/mpc.c:1460
 do_vcc_ioctl+0x36d/0x9e0 net/atm/ioctl.c:159
 svc_ioctl+0x1ee/0x770 net/atm/svc.c:611
 sock_do_ioctl+0xdc/0x300 net/socket.c:1238
 sock_ioctl+0x576/0x790 net/socket.c:1359
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:598 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:584
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fdd1b98eba9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fdd1c7e4038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fdd1bbd5fa0 RCX: 00007fdd1b98eba9
RDX: 0000000000000000 RSI: 00000000000061d8 RDI: 0000000000000004
RBP: 00007fdd1c7e4090 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007fdd1bbd6038 R14: 00007fdd1bbd5fa0 R15: 00007fffd3ee7758
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

