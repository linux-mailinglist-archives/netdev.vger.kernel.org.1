Return-Path: <netdev+bounces-250922-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E560D399F7
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 22:26:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C86AF30084E9
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 21:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1239F27055D;
	Sun, 18 Jan 2026 21:26:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f80.google.com (mail-oo1-f80.google.com [209.85.161.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7488E18FC97
	for <netdev@vger.kernel.org>; Sun, 18 Jan 2026 21:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768771584; cv=none; b=SoeI+ak7NwR+u+GtTkBz8q905DY0ntYByrcI0dqPTIAlcuqQ3eH82qFc/4C7P4vkGm/mA/J8BYzmp8pO116wFKmndXLM4UWLbDGBx3b8jkTIdryGuJiaLfstMKfKp+Xgdkty2ogpTeKaNWyVgu+rzeN83OT3NR1XjUEPqajRCRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768771584; c=relaxed/simple;
	bh=44TcUuCEwKNZrwVl4/DjYq4Oszf2ixV1SquL1TI+Pag=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=DeWkxzWBlCewlbtGWjIxUPSpvPK3ib+asSfKleepylUsAV9UBj99bJxJ6iEXkOBkI3dlO06g5XymaJUi4BT1n6suU9U9oGkO1cnF9UAfNShUChPbde+T6Y7bkwU9cpRLQOYZEiILQ4Iy1OvCs9qRhEFxFKo1crOr9krZk1Ouuuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f80.google.com with SMTP id 006d021491bc7-65f6e15ad5bso10064727eaf.1
        for <netdev@vger.kernel.org>; Sun, 18 Jan 2026 13:26:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768771581; x=1769376381;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j2gGqcI5BaLIbeTWTPgPo69X7fp4dB/w8/15RdBjX0E=;
        b=ub3iCvOS0e9rrjZ309/ck/Xh/qCsxOVtZbjc+ddLlxvosp9zUt698lEE631cDHr4Um
         rIyn1XsaU+57pXz7RPvUtTEXAKZ0rtoccsjU8Idt0Cgpa4dxUrH07G58jk4vas+FSxcA
         FRV7UaS2HFqvWfBudHxGl/ImfFa2FJuNOPuZ8Nwpsfg+HLIna4dzGbq3AkRQOtkwAtnE
         9ciL7v7G8V6SHUIGAgdFo2p5vWc2KplLpKsGz0ARH8BCkHBlJ4cMjdjAbNZMil7Yslo+
         yUNYsf6Z0t4RC0oa+zFfUwKPnqI37aF99s56Nyk0An2qwIK4vAHQXCPfkuLNvmJt4EIJ
         pZqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXb1bB/laSgY7bjI63QhcmL85u1h7NRGpuJfmnubGbiBljaBXPZNM//oUgqUqWpSHsRxW2qMHo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCpl+N9j/NZU2yFXWUxMkBGcRPFjhin4V42ZwDwy6Occ7NT5xh
	FYcaOgGBV4HNHIPGUoPpLHaWSPzFbX0vtawIwCRRByaMiOChfwF5f4Yjji3Ka7oDbMlH742UT5P
	7Fma+5pBQrcup8QAtuoPsfj8XMpjfBL5Da4MyFvmX3HgGHWsKbjgiJe13iBY=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:490f:b0:65c:f821:9dd3 with SMTP id
 006d021491bc7-661179f9e7bmr3731725eaf.70.1768771581462; Sun, 18 Jan 2026
 13:26:21 -0800 (PST)
Date: Sun, 18 Jan 2026 13:26:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <696d4ffd.050a0220.3390f1.0024.GAE@google.com>
Subject: [syzbot] [wireless?] WARNING in drv_get_tsf (2)
From: syzbot <syzbot+2cecf0e829ae2219d419@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    944aacb68baf Merge tag 'scsi-fixes' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15f88dfa580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ae589cd0a6acd9be
dashboard link: https://syzkaller.appspot.com/bug?extid=2cecf0e829ae2219d419
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16259d9a580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1971a9dd2936/disk-944aacb6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/cf50ec150c97/vmlinux-944aacb6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/eee3d7722c03/bzImage-944aacb6.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2cecf0e829ae2219d419@syzkaller.appspotmail.com

------------[ cut here ]------------
wlan1: Failed check-sdata-in-driver check, flags: 0x0
WARNING: net/mac80211/driver-ops.c:255 at drv_get_tsf+0x187/0x6f0 net/mac80211/driver-ops.c:255, CPU#0: kworker/u8:11/3538
Modules linked in:
CPU: 0 UID: 0 PID: 3538 Comm: kworker/u8:11 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
Workqueue: events_unbound cfg80211_wiphy_work
RIP: 0010:drv_get_tsf+0x18d/0x6f0 net/mac80211/driver-ops.c:255
Code: 0a 00 00 4d 85 e4 0f 84 95 04 00 00 e8 8c 9a dc f6 49 81 c4 20 01 00 00 e8 80 9a dc f6 48 8d 3d 49 e9 b6 05 44 89 f2 4c 89 e6 <67> 48 0f b9 3a e8 69 9a dc f6 4c 89 ea 48 b8 00 00 00 00 00 fc ff
RSP: 0018:ffffc9000c49fb08 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff88805c0c4d80 RCX: ffffffff8ae1c32f
RDX: 0000000000000000 RSI: ffff88805c0c4120 RDI: ffffffff9098acd0
RBP: ffff888031cc8e80 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: ffff88803190c830 R12: ffff88805c0c4120
R13: ffff88805c0c57b8 R14: 0000000000000000 R15: ffff888031cc86d0
FS:  0000000000000000(0000) GS:ffff8881248f9000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f239b3156c0 CR3: 0000000075ed0000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 ieee80211_if_fmt_tsf+0x42/0x70 net/mac80211/debugfs_netdev.c:659
 wiphy_locked_debugfs_read_work+0xe6/0x1c0 net/wireless/debugfs.c:168
 cfg80211_wiphy_work+0x3fb/0x560 net/wireless/core.c:438
 process_one_work+0x9ba/0x1b20 kernel/workqueue.c:3257
 process_scheduled_works kernel/workqueue.c:3340 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3421
 kthread+0x3c5/0x780 kernel/kthread.c:463
 ret_from_fork+0x983/0xb10 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
 </TASK>
----------------
Code disassembly (best guess), 1 bytes skipped:
   0:	00 00                	add    %al,(%rax)
   2:	4d 85 e4             	test   %r12,%r12
   5:	0f 84 95 04 00 00    	je     0x4a0
   b:	e8 8c 9a dc f6       	call   0xf6dc9a9c
  10:	49 81 c4 20 01 00 00 	add    $0x120,%r12
  17:	e8 80 9a dc f6       	call   0xf6dc9a9c
  1c:	48 8d 3d 49 e9 b6 05 	lea    0x5b6e949(%rip),%rdi        # 0x5b6e96c
  23:	44 89 f2             	mov    %r14d,%edx
  26:	4c 89 e6             	mov    %r12,%rsi
* 29:	67 48 0f b9 3a       	ud1    (%edx),%rdi <-- trapping instruction
  2e:	e8 69 9a dc f6       	call   0xf6dc9a9c
  33:	4c 89 ea             	mov    %r13,%rdx
  36:	48                   	rex.W
  37:	b8 00 00 00 00       	mov    $0x0,%eax
  3c:	00 fc                	add    %bh,%ah
  3e:	ff                   	.byte 0xff


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

