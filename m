Return-Path: <netdev+bounces-234480-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B451C2150B
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 17:54:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CA10534FD1B
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 16:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E8DC2F60A3;
	Thu, 30 Oct 2025 16:54:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6152F2EDD50
	for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 16:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761843283; cv=none; b=THsUN4oYyOhE8pkDm1Ief1nhV3yb1+1fNTPZE6ijt+7q+Thp3LzwZhKbRgD415dR4OJQxijrqYWzyF3pU6iEVVeWMQqNk7FL5qzTU5fRoOe1Vlr+yDoDOKVi1y4T9VXAWpwU8EmPerSqJ/8ukvVntsKUTpsJbEKNNe4ZbYFVS48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761843283; c=relaxed/simple;
	bh=BsaXkMj+xln/qGjXUxP5AS7ycYfC+pHEVXqI+8CSe4Q=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ofOOmR/0eiXWn8+FEszz47f7culYqFMA7ZusiltdmYXRKHVYtPggb238kVWffIPtYdv1LpS/hmcstf6COUfPgR/8N1215qHD6NjvRCRZlkyq0nttZg/eM2dwTL2f57Bd89KOVrxHJgEyVXH6Fn995FGQSTZSBuXSA2WYjHEG1pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-431d8643856so46429275ab.2
        for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 09:54:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761843280; x=1762448080;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U6o5u1AM5MLHRzuDRmnUOR5MULo47cdMuAbGe04ff5E=;
        b=t/5zmFT4BloJukKjiIZoF5iwAkzMqVybRYUOFaAtAgsrwoInLR72pXq9NXC9IJiP8Y
         ci41OkGFdugJ4+vOQu9bGrXP5Vv4Dmz8DxH1OHr8ArCR1ezQBGI03WupdLiKQVzwXek4
         XeoPY1xfIl7rCL9OOw6K3ktkb8Ub29zf6usKZ1QNmfh22dT4/eZY1XsXfYX/+vgzK+CE
         9ivcBgyAGBi99C/yamdqpvy0D6/h5zDRrGSkJ5JsQGY/QSuvm7RnvPinel1EvbPyO1Gt
         qWvYonr7FHDkBJRdLxMoAXOVBJnrBaQ6rhkfy1E2SDiGrty7jC2iDuYi3CuuRXKROZXi
         iJBA==
X-Forwarded-Encrypted: i=1; AJvYcCU90O9YhWC6i4F8gBiW7JKl6ibeOEXzI9JiMSMDvf4I6SFbGODpMQMqDsoX9V9D/LmvWN1DCPg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+eEtrOzzHnw/AQPs5GOnwkiXQI38f3iwPkjEt2bt8JT/iSR6l
	d45cNWf5OTdbVRtB9Q7gia1jHhSlHvmbfHpilU7fNHXphnKfCzwByOkOzseLU1WnvKIW2eNmSY2
	uVYesEBPbU2urWn5MXLxSOk4+eXaRKNOMIMA4CwhRI7ITEEuiXm8eYT5lnsg=
X-Google-Smtp-Source: AGHT+IEgYVbPVLvVTNDSUV+PLUrLDoZlBMGTonkJ47N/w5rQOExWRbU2wRSlxWV1xE8HZJni3lyVhat+pn7CB6hDRBtzFxUdmLFc
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3b86:b0:430:e9e7:8660 with SMTP id
 e9e14a558f8ab-4330d125c32mr6854725ab.5.1761843280352; Thu, 30 Oct 2025
 09:54:40 -0700 (PDT)
Date: Thu, 30 Oct 2025 09:54:40 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69039850.a70a0220.5b2ed.005d.GAE@google.com>
Subject: [syzbot] [net?] general protection fault in sigd_send
From: syzbot <syzbot+1f22cb1769f249df9fa0@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    84a905290cb4 net: phy: dp83867: Disable EEE support as not..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=113d2932580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=67b63a24f3c26fca
dashboard link: https://syzkaller.appspot.com/bug?extid=1f22cb1769f249df9fa0
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=119627e2580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16bc6f34580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/833b328a19a9/disk-84a90529.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1d97a2ab2baf/vmlinux-84a90529.xz
kernel image: https://storage.googleapis.com/syzbot-assets/cb504e793493/bzImage-84a90529.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1f22cb1769f249df9fa0@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc0000008034: 0000 [#1] SMP KASAN PTI
KASAN: probably user-memory-access in range [0x00000000000401a0-0x00000000000401a7]
CPU: 1 UID: 0 PID: 6129 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
RIP: 0010:sigd_send+0x48d/0xf90 net/atm/signaling.c:78
Code: 8d 67 14 4c 89 e0 48 c1 e8 03 0f b6 04 18 84 c0 0f 85 91 07 00 00 31 ed 41 2b 2c 24 49 8d be 9c 01 00 00 48 89 f8 48 c1 e8 03 <0f> b6 04 18 84 c0 0f 85 8f 07 00 00 41 89 ae 9c 01 00 00 49 8d be
RSP: 0018:ffffc90003737820 EFLAGS: 00010202
RAX: 0000000000008034 RBX: dffffc0000000000 RCX: 0000000000000005
RDX: ffffffff8a75f9af RSI: ffffffff8f4cf240 RDI: 00000000000401a0
RBP: 0000000000000000 R08: ffff88802cf50000 R09: 0000000000000007
R10: 000000000000000f R11: 0000000000000000 R12: ffff888058c8ea54
R13: 1ffff1100b191d48 R14: 0000000000040004 R15: ffff888058c8ea40
FS:  00007f9e83ba46c0(0000) GS:ffff88812623e000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f91aa192e9c CR3: 000000003195e000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 vcc_sendmsg+0xb2e/0xd70 net/atm/common.c:650
 sock_sendmsg_nosec net/socket.c:727 [inline]
 __sock_sendmsg+0x21c/0x270 net/socket.c:742
 ____sys_sendmsg+0x505/0x830 net/socket.c:2630
 ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2684
 __sys_sendmsg net/socket.c:2716 [inline]
 __do_sys_sendmsg net/socket.c:2721 [inline]
 __se_sys_sendmsg net/socket.c:2719 [inline]
 __x64_sys_sendmsg+0x19b/0x260 net/socket.c:2719
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f9e82d8efc9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f9e83ba4038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f9e82fe5fa0 RCX: 00007f9e82d8efc9
RDX: 0000000000000000 RSI: 0000200000000500 RDI: 0000000000000004
RBP: 00007f9e82e11f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f9e82fe6038 R14: 00007f9e82fe5fa0 R15: 00007fffa761f4e8
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:sigd_send+0x48d/0xf90 net/atm/signaling.c:78
Code: 8d 67 14 4c 89 e0 48 c1 e8 03 0f b6 04 18 84 c0 0f 85 91 07 00 00 31 ed 41 2b 2c 24 49 8d be 9c 01 00 00 48 89 f8 48 c1 e8 03 <0f> b6 04 18 84 c0 0f 85 8f 07 00 00 41 89 ae 9c 01 00 00 49 8d be
RSP: 0018:ffffc90003737820 EFLAGS: 00010202
RAX: 0000000000008034 RBX: dffffc0000000000 RCX: 0000000000000005
RDX: ffffffff8a75f9af RSI: ffffffff8f4cf240 RDI: 00000000000401a0
RBP: 0000000000000000 R08: ffff88802cf50000 R09: 0000000000000007
R10: 000000000000000f R11: 0000000000000000 R12: ffff888058c8ea54
R13: 1ffff1100b191d48 R14: 0000000000040004 R15: ffff888058c8ea40
FS:  00007f9e83ba46c0(0000) GS:ffff88812623e000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f91aa192e9c CR3: 000000003195e000 CR4: 00000000003526f0
----------------
Code disassembly (best guess):
   0:	8d 67 14             	lea    0x14(%rdi),%esp
   3:	4c 89 e0             	mov    %r12,%rax
   6:	48 c1 e8 03          	shr    $0x3,%rax
   a:	0f b6 04 18          	movzbl (%rax,%rbx,1),%eax
   e:	84 c0                	test   %al,%al
  10:	0f 85 91 07 00 00    	jne    0x7a7
  16:	31 ed                	xor    %ebp,%ebp
  18:	41 2b 2c 24          	sub    (%r12),%ebp
  1c:	49 8d be 9c 01 00 00 	lea    0x19c(%r14),%rdi
  23:	48 89 f8             	mov    %rdi,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	0f b6 04 18          	movzbl (%rax,%rbx,1),%eax <-- trapping instruction
  2e:	84 c0                	test   %al,%al
  30:	0f 85 8f 07 00 00    	jne    0x7c5
  36:	41 89 ae 9c 01 00 00 	mov    %ebp,0x19c(%r14)
  3d:	49                   	rex.WB
  3e:	8d                   	.byte 0x8d
  3f:	be                   	.byte 0xbe


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

