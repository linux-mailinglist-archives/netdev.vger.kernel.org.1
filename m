Return-Path: <netdev+bounces-215430-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 336D7B2EAAD
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 03:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47D3C1881DA8
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 01:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF0C0217F29;
	Thu, 21 Aug 2025 01:29:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB24A214A97
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 01:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755739774; cv=none; b=d5zslTp/FfSjcwdbA+KHd4pLz/xn1c9v7xdZz3r9J7buXIJ1MagnHAv7+cAN6qWTD08Rofr+VugWUPt5wnsBnftgcHCoCHlDccs3Tr4i9eAkINi2zF0TPG1PtMpETQwHv+LPPf32gwDQ/gY2PUkM8mjbQwsegpPKDJyjFCpVOic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755739774; c=relaxed/simple;
	bh=2AyQe38wuFbh3oc8vBdjcieL0B9vhqrNZIJ9Jr6eZAo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=MJ075GDrkSit39/+lweovvVIo3bE6hkIoZU63YwN76Mpf1AxkdpMvKzLS2QHsNz3KHG4OsiMqtPYDZg0ZWlrj2K9KB4WhF5hnq/ATexv2DbgNPIb0QK7JPXq1DrzgKeDb7zXmYThSewajmfnDl8wclkfhszCrFtbKkwdKvtqSU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-88432dc61d9so112878739f.1
        for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 18:29:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755739772; x=1756344572;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DDDUwweEt5CCd+NSsUOZDQdN0QeGl5ZGvD33oDEbmCk=;
        b=nLuygCuP5V5h7QvMTiWGCUpentwZR2fshacVHOIo488F0igCa2u437tI6C0FrjtwUu
         jtnB3iIlbvGVndlPmqZIpF8D4nIBVmhx/Dap0x2uFxeQrDZhSE/EVzSAAKdzd+3iWCPD
         hqnn5fqv78ovwvDjYX3B/8Iel8cdygyV5vbCT12+ApM5FGjBPRshDMCN4Kzhv5WzWoVH
         H66IFKmjTWw+ph9dynyctNuZ7wKJwRuO/BlK6V1HFhP6bnQF7n0ZXwaDI0macGYF1Dl0
         elIDJmO2ZaCcRfU9bUAbNlbvSHoZVoD/1WFDT5eB3yl5pRea2AzF1SEcd/df1QSiF75L
         mF4A==
X-Forwarded-Encrypted: i=1; AJvYcCVcebgRbtvNGNeKoAOMGbeZ10UXRzyKbEFy3He10SiQv/mhM1G5ImYWTbDk4cBjwuXBlCxhHZo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyrv8GdGCSn3zwoWawFNmwWyWJbx3HPYpKwRQ7hwQ1B6LQ370zD
	O83rvsWRpNsVr04cS/CI3NgDavrbsN0jX8HsXgzHUa+cYzhgE12NcGYfMttUpalb+1LZREzaboC
	gALPIjBiWrQBeOh/wcLB/fzTnqI4OlXoRBlBFjPyMaN8+jtt6xK9t5MqWbX8=
X-Google-Smtp-Source: AGHT+IHNOwVvk2PeMAMs3bQuaVhoaGE598Sj396bxSRDOxaIyZDEgmCEXF3S/Q7rpSiveHunvxMpHFZ/UooAbyANX+X7oMs++Ab+
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3e89:b0:3e5:6313:4562 with SMTP id
 e9e14a558f8ab-3e6d69d9a48mr11042105ab.14.1755739772090; Wed, 20 Aug 2025
 18:29:32 -0700 (PDT)
Date: Wed, 20 Aug 2025 18:29:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68a6767c.050a0220.3d78fd.0011.GAE@google.com>
Subject: [syzbot] [atm?] general protection fault in atmtcp_c_send
From: syzbot <syzbot+1741b56d54536f4ec349@syzkaller.appspotmail.com>
To: 3chas3@gmail.com, bigeasy@linutronix.de, gregkh@linuxfoundation.org, 
	linux-atm-general@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    bab3ce404553 Merge branch '100GbE' of git://git.kernel.org..
git tree:       net-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=164893a2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=412ee2f8b704a5e6
dashboard link: https://syzkaller.appspot.com/bug?extid=1741b56d54536f4ec349
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1769faf0580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=100eaba2580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1d9c704d6fbe/disk-bab3ce40.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/96883727f8e4/vmlinux-bab3ce40.xz
kernel image: https://storage.googleapis.com/syzbot-assets/69625976cd6e/bzImage-bab3ce40.xz

The issue was bisected to:

commit 5b2fabf7fe8f745ff214ff003e6067b64f172271
Author: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date:   Thu Feb 13 14:50:20 2025 +0000

    kernfs: Acquire kernfs_rwsem in kernfs_node_dentry().

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=132b9234580000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=10ab9234580000
console output: https://syzkaller.appspot.com/x/log.txt?x=172b9234580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1741b56d54536f4ec349@syzkaller.appspotmail.com
Fixes: 5b2fabf7fe8f ("kernfs: Acquire kernfs_rwsem in kernfs_node_dentry().")

Oops: general protection fault, probably for non-canonical address 0xdffffc00200000ab: 0000 [#1] SMP KASAN PTI
KASAN: probably user-memory-access in range [0x0000000100000558-0x000000010000055f]
CPU: 0 UID: 0 PID: 5865 Comm: syz-executor331 Not tainted 6.17.0-rc1-syzkaller-00215-gbab3ce404553 #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
RIP: 0010:atmtcp_recv_control drivers/atm/atmtcp.c:93 [inline]
RIP: 0010:atmtcp_c_send+0x1da/0x950 drivers/atm/atmtcp.c:297
Code: 4d 8d 75 1a 4c 89 f0 48 c1 e8 03 42 0f b6 04 20 84 c0 0f 85 15 06 00 00 41 0f b7 1e 4d 8d b7 60 05 00 00 4c 89 f0 48 c1 e8 03 <42> 0f b6 04 20 84 c0 0f 85 13 06 00 00 66 41 89 1e 4d 8d 75 1c 4c
RSP: 0018:ffffc90003f5f810 EFLAGS: 00010203
RAX: 00000000200000ab RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff88802a510000 RSI: 00000000ffffffff RDI: ffff888030a6068c
RBP: ffff88802699fb40 R08: ffff888030a606eb R09: 1ffff1100614c0dd
R10: dffffc0000000000 R11: ffffffff8718fc40 R12: dffffc0000000000
R13: ffff888030a60680 R14: 000000010000055f R15: 00000000ffffffff
FS:  00007f8d7e9236c0(0000) GS:ffff888125c1c000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000045ad50 CR3: 0000000075bde000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 vcc_sendmsg+0xa10/0xc60 net/atm/common.c:645
 sock_sendmsg_nosec net/socket.c:714 [inline]
 __sock_sendmsg+0x219/0x270 net/socket.c:729
 ____sys_sendmsg+0x505/0x830 net/socket.c:2614
 ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2668
 __sys_sendmsg net/socket.c:2700 [inline]
 __do_sys_sendmsg net/socket.c:2705 [inline]
 __se_sys_sendmsg net/socket.c:2703 [inline]
 __x64_sys_sendmsg+0x19b/0x260 net/socket.c:2703
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f8d7e96a4a9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f8d7e923198 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f8d7e9f4308 RCX: 00007f8d7e96a4a9
RDX: 0000000000000000 RSI: 0000200000000240 RDI: 0000000000000005
RBP: 00007f8d7e9f4300 R08: 65732f636f72702f R09: 65732f636f72702f
R10: 65732f636f72702f R11: 0000000000000246 R12: 00007f8d7e9c10ac
R13: 00007f8d7e9231a0 R14: 0000200000000200 R15: 0000200000000250
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:atmtcp_recv_control drivers/atm/atmtcp.c:93 [inline]
RIP: 0010:atmtcp_c_send+0x1da/0x950 drivers/atm/atmtcp.c:297
Code: 4d 8d 75 1a 4c 89 f0 48 c1 e8 03 42 0f b6 04 20 84 c0 0f 85 15 06 00 00 41 0f b7 1e 4d 8d b7 60 05 00 00 4c 89 f0 48 c1 e8 03 <42> 0f b6 04 20 84 c0 0f 85 13 06 00 00 66 41 89 1e 4d 8d 75 1c 4c
RSP: 0018:ffffc90003f5f810 EFLAGS: 00010203
RAX: 00000000200000ab RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff88802a510000 RSI: 00000000ffffffff RDI: ffff888030a6068c
RBP: ffff88802699fb40 R08: ffff888030a606eb R09: 1ffff1100614c0dd
R10: dffffc0000000000 R11: ffffffff8718fc40 R12: dffffc0000000000
R13: ffff888030a60680 R14: 000000010000055f R15: 00000000ffffffff
FS:  00007f8d7e9236c0(0000) GS:ffff888125c1c000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000045ad50 CR3: 0000000075bde000 CR4: 00000000003526f0
----------------
Code disassembly (best guess):
   0:	4d 8d 75 1a          	lea    0x1a(%r13),%r14
   4:	4c 89 f0             	mov    %r14,%rax
   7:	48 c1 e8 03          	shr    $0x3,%rax
   b:	42 0f b6 04 20       	movzbl (%rax,%r12,1),%eax
  10:	84 c0                	test   %al,%al
  12:	0f 85 15 06 00 00    	jne    0x62d
  18:	41 0f b7 1e          	movzwl (%r14),%ebx
  1c:	4d 8d b7 60 05 00 00 	lea    0x560(%r15),%r14
  23:	4c 89 f0             	mov    %r14,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 0f b6 04 20       	movzbl (%rax,%r12,1),%eax <-- trapping instruction
  2f:	84 c0                	test   %al,%al
  31:	0f 85 13 06 00 00    	jne    0x64a
  37:	66 41 89 1e          	mov    %bx,(%r14)
  3b:	4d 8d 75 1c          	lea    0x1c(%r13),%r14
  3f:	4c                   	rex.WR


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

