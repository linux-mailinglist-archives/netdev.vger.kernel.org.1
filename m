Return-Path: <netdev+bounces-154024-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B3D9FAEEE
	for <lists+netdev@lfdr.de>; Mon, 23 Dec 2024 14:38:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D7F0188291E
	for <lists+netdev@lfdr.de>; Mon, 23 Dec 2024 13:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C606194AF9;
	Mon, 23 Dec 2024 13:38:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0EDF8BEA
	for <netdev@vger.kernel.org>; Mon, 23 Dec 2024 13:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734961105; cv=none; b=iDwvKaUI+jUp7tUS3QLlVhoCyCq1xQGMFqKDypfFu9WMayWSoGCWxNFzrb97BQjI8JshnbFqlhsgwotrQ1YlF42UvTsl+rPEoQHPjMi4JmFvQs0i/wcyJXUJOMLSz8huztgqnRGBT8vtqbitUZC51qshR4B9I/VddjEYTpCpHUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734961105; c=relaxed/simple;
	bh=YKwjGULf+DCKku+S3Wz5azWrZP/BLFDx4ZmebO9eHLs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=nCKE/tU96ir68U+y8S8NQGZKf+0vUiZ/2UBWXsG5qrVvVU40iXg48rpsSYkAv6UAzyYABXxh0rhbwBWfRipsMdTwuQVG8IUcCmdFnI8NfmblLIMyyEAbemwsMJgxcSmTCjT0C/j5FA0I+7hX04K0PWyldkfmHXlI/ZZY4HY5XTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3a9cefa1969so40643885ab.1
        for <netdev@vger.kernel.org>; Mon, 23 Dec 2024 05:38:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734961103; x=1735565903;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LIRUL1nyLCyGGsUcXpfxnJ1Leb7PKv/uIp31sy2Uxnw=;
        b=gB3H2cSl3FX7fXT+YXfE1fmxTbLsmZWxw9QtVUnUSj46btqjpvzS+gOlBByq5Atm6M
         SzUwMjYX30vo2drcaVd+8vpqWk3/77d5P64KSu9OEa4NuG0Z/16Brjk1N+mbvxzwSfH/
         tXXD/LdtkkEqaYE7l0Yrg5Vxt4erWMK4g0NptUmJb/27CVk7JvhTC7vaGD1T/a+paEjo
         dhfMk2j+fm2cIwKMNdXYZGaFahXCMTuvZdeRRGbI4xExRHHA1+I/ULIISjFFFxC8vS8L
         ILGXvVR1TO9TSC9Huwu25vVCH5BN6b+XcLbqxn4rFetFM8Q61dS63Yc9fPPTygenCmba
         utZg==
X-Forwarded-Encrypted: i=1; AJvYcCVL5FJAgfwTbChCDPYqqLmoCf9GOB/XXiB0sw+rZR97HL5sJfcOK4y2BY3umZWKb+lbOQE8YmY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJjgqL9vUSPzg3zbo6JhBhfbxSJXy4LD6PIfhv7qSM8UEQZqnE
	L25ViYaaBE1UiEMkX3KAS6AMj2HozHYfzMjS+CH+qSe6QhAzBb3j18MEZ7y1kPCmpSi/TSUL3Ak
	EYhC2GDTctvUF4K/cy8vH/ts50G3hhybrQ15CebUtaE3Lhw30qeh50KA=
X-Google-Smtp-Source: AGHT+IFFo3KOF35NvVbIm2q7w1H8veIcXArBjetVp8hGoMXG+86pf4WB9Va3FKf02Cnh10bASf2VeZ1PajHgeHirer8TyC2NlG7S
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:349c:b0:3a7:fe8c:b015 with SMTP id
 e9e14a558f8ab-3c2d581a343mr22322165ab.24.1734961102781; Mon, 23 Dec 2024
 05:38:22 -0800 (PST)
Date: Mon, 23 Dec 2024 05:38:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <676967ce.050a0220.2f3838.0097.GAE@google.com>
Subject: [syzbot] [wireguard?] WARNING: locking bug in wg_packet_decrypt_worker
 (2)
From: syzbot <syzbot+c40f14a86aa820015153@syzkaller.appspotmail.com>
To: Jason@zx2c4.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	wireguard@lists.zx2c4.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    eabcdba3ad40 Merge tag 'for-6.13-rc3-tag' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10a41f44580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6a2b862bf4a5409f
dashboard link: https://syzkaller.appspot.com/bug?extid=c40f14a86aa820015153
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2be6996abd02/disk-eabcdba3.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4e177f4e98c0/vmlinux-eabcdba3.xz
kernel image: https://storage.googleapis.com/syzbot-assets/bbf1b6ecbf58/bzImage-eabcdba3.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c40f14a86aa820015153@syzkaller.appspotmail.com

------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(1)
WARNING: CPU: 0 PID: 5889 at kernel/locking/lockdep.c:232 hlock_class kernel/locking/lockdep.c:232 [inline]
WARNING: CPU: 0 PID: 5889 at kernel/locking/lockdep.c:232 check_wait_context kernel/locking/lockdep.c:4850 [inline]
WARNING: CPU: 0 PID: 5889 at kernel/locking/lockdep.c:232 __lock_acquire+0x564/0x2100 kernel/locking/lockdep.c:5176
Modules linked in:
CPU: 0 UID: 0 PID: 5889 Comm: kworker/0:5 Not tainted 6.13.0-rc3-syzkaller-00073-geabcdba3ad40 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/25/2024
Workqueue: wg-crypt-wg2 wg_packet_decrypt_worker
RIP: 0010:hlock_class kernel/locking/lockdep.c:232 [inline]
RIP: 0010:check_wait_context kernel/locking/lockdep.c:4850 [inline]
RIP: 0010:__lock_acquire+0x564/0x2100 kernel/locking/lockdep.c:5176
Code: 00 00 83 3d 21 f4 9e 0e 00 75 23 90 48 c7 c7 00 96 0a 8c 48 c7 c6 00 99 0a 8c e8 67 5d e5 ff 48 ba 00 00 00 00 00 fc ff df 90 <0f> 0b 90 90 90 31 db 48 81 c3 c4 00 00 00 48 89 d8 48 c1 e8 03 0f
RSP: 0018:ffffc9000488f450 EFLAGS: 00010046
RAX: d0f6e83a7c789700 RBX: 0000000000001201 RCX: ffff88802ede3c00
RDX: dffffc0000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000041201 R08: ffffffff81601a42 R09: 1ffff110170c519a
R10: dffffc0000000000 R11: ffffed10170c519b R12: ffff88802ede46c4
R13: 000000000000000a R14: 1ffff11005dbc8ea R15: ffff88802ede4750
FS:  0000000000000000(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b30112ff8 CR3: 000000000e736000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
 __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
 _raw_spin_lock_bh+0x35/0x50 kernel/locking/spinlock.c:178
 spin_lock_bh include/linux/spinlock.h:356 [inline]
 ptr_ring_consume_bh include/linux/ptr_ring.h:365 [inline]
 wg_packet_decrypt_worker+0xcf/0xd80 drivers/net/wireguard/receive.c:499
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa68/0x1840 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f2/0x390 kernel/kthread.c:389
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
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

