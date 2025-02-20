Return-Path: <netdev+bounces-168027-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD12DA3D26C
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 08:37:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F7E2173AB3
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 07:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91201E98F3;
	Thu, 20 Feb 2025 07:37:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C7C1B4236
	for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 07:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740037048; cv=none; b=YdElohFo3u5X0pQw/Vbk9j9+XxlGsJGaTP3riYbrxzwfWjbFwjXyLMJ1RnlQGqK2vs/pKvWZAPkvwl4J/vtiu7YfTIuAqkEJveJLCwtisFuVXh6uD0CZcVQszJ9fcTv1OZ+FJBPwo+qGjDl0wvVESyd84mlldNkFJ3b5Z3/X1gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740037048; c=relaxed/simple;
	bh=mF2eEzANmYMhTUgAZ4KFEM4NDh8r/vDaxSktQf2ABpA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Qh7SfkppXh/6ujhzlpIL2ter/J6olq9rphuXSRqfidDG4f29Krr1VLk1nfgj+Ztxuxy9paRkZj7oOrhvd1B80j+TEUW8T+P7X/y0DULvUJnoHrsonFdOsV1I9NKEFvaDORp6NIQxS0F9WDMDleFKX2BPTYsf4uROA+rKBumJDdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3d2a6b4b2dbso11303095ab.2
        for <netdev@vger.kernel.org>; Wed, 19 Feb 2025 23:37:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740037046; x=1740641846;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WMYI6ti4AQSr1Rxyf3QXt1wFZpcNduqxnseU/edZOhw=;
        b=hQ/22g/PD5ZY8MK3uBrDjJiOocmlLkzUZU/W3RLmN9OoVN+0vfgLTwCuCMEJbbGxS2
         heAdgVLgW+unnncG5s2LLDVaCTDm/O4stN0XnwphUERbJV25HDGKvYrmL5fEpayqPLTB
         6bQmBS47axj1qrQoH3SFchnsdEQTxXAkxAmFWrEG/tG2zLbwzf3OmB4F5CsnsSmKrJ84
         oG4/x/Bg98+bqnTNbf1FlUqvGJ8TtJsNZMeP8thpR833RPuiVAGRZEQ/NxUsBRbdUhWH
         Ld14YuWi60cz3IIW+pBAyLN67lF+wzHEaaBiW4owj2VCW85usOdMHdrGsCyuow9viZiC
         u7AA==
X-Forwarded-Encrypted: i=1; AJvYcCVCBTaJO4fA7xmFUCnHTQ8ZGKAxYDRXgUEvE/y19vENpgLbSe3vdnjT6REthQ3PawOXK/p3POc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yybo5we2WYUXdkNEpxXxNmKMCatO9qa8lU9VsWPYPdXef1r7aMX
	kiLM/TLruDasownRp6sQMs8OwGpz3ArqPUaIXkYcc48BYOBTppnbKNDfIUxmcDh4sa/OWEwfD/m
	wZkZgV94PLTZvxj4nbyRrpndeaTCP+aH57Pzy+mZw4/NuxM0aKbWmi/Q=
X-Google-Smtp-Source: AGHT+IF0Z3TX34vBZ+BlW3GZaFJWOTucxOlZhnRdPfNomVepqDqDXro1IV2A7WQVaWRgT5OB4eVNObGrUDKvA4vj3PgO3eyavQjv
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12ed:b0:3d0:123e:fbdd with SMTP id
 e9e14a558f8ab-3d2b52de02dmr68301295ab.11.1740037046331; Wed, 19 Feb 2025
 23:37:26 -0800 (PST)
Date: Wed, 19 Feb 2025 23:37:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67b6dbb6.050a0220.14d86d.015d.GAE@google.com>
Subject: [syzbot] [batman?] WARNING: locking bug in batadv_nc_purge_paths
From: syzbot <syzbot+0fcf6f9bc18978d651d4@syzkaller.appspotmail.com>
To: a@unstable.cc, antonio@mandelbit.com, b.a.t.m.a.n@lists.open-mesh.org, 
	davem@davemloft.net, edumazet@google.com, horms@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, marek.lindner@mailbox.org, 
	mareklindner@neomailbox.ch, netdev@vger.kernel.org, pabeni@redhat.com, 
	sven@narfation.org, sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    ad1b832bf1cf Merge tag 'devicetree-fixes-for-6.14-1' of gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13cf0898580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c776e555cfbdb82d
dashboard link: https://syzkaller.appspot.com/bug?extid=0fcf6f9bc18978d651d4
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-ad1b832b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/64103cb6fc45/vmlinux-ad1b832b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9bc34ac014d0/bzImage-ad1b832b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0fcf6f9bc18978d651d4@syzkaller.appspotmail.com

------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(!test_bit(class_idx, lock_classes_in_use))
WARNING: CPU: 0 PID: 3034 at kernel/locking/lockdep.c:5198 __lock_acquire+0x165b/0x2100 kernel/locking/lockdep.c:5198
Modules linked in:
CPU: 0 UID: 0 PID: 3034 Comm: kworker/u4:11 Not tainted 6.14.0-rc2-syzkaller-00303-gad1b832bf1cf #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: bat_events batadv_nc_worker
RIP: 0010:__lock_acquire+0x165b/0x2100 kernel/locking/lockdep.c:5198
Code: 0f b6 04 08 84 c0 0f 85 31 0a 00 00 83 3d 20 46 a0 0e 00 75 19 90 48 c7 c7 e0 a2 2a 8c 48 c7 c6 20 cc 2a 8c e8 96 b1 e4 ff 90 <0f> 0b 90 90 90 e9 be fd ff ff 90 0f 0b 90 e9 16 fd ff ff 90 e8 ec
RSP: 0018:ffffc9000db2f7b0 EFLAGS: 00010046
RAX: fa1dc7e27e145700 RBX: 000000000ac7c7f7 RCX: ffff88804021a440
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffff88804021af80 R08: ffffffff81817e32 R09: 1ffff11003f8519a
R10: dffffc0000000000 R11: ffffed1003f8519b R12: ffff88804021af14
R13: ffff88804021a440 R14: 0000000000000000 R15: ffff88804021afa0
FS:  0000000000000000(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055aa7d195048 CR3: 000000001f62c000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5851
 __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
 _raw_spin_lock_bh+0x35/0x50 kernel/locking/spinlock.c:178
 spin_lock_bh include/linux/spinlock.h:356 [inline]
 batadv_nc_purge_paths+0xe8/0x3b0 net/batman-adv/network-coding.c:442
 batadv_nc_worker+0x328/0x610 net/batman-adv/network-coding.c:720
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0xabe/0x18e0 kernel/workqueue.c:3317
 worker_thread+0x870/0xd30 kernel/workqueue.c:3398
 kthread+0x7a9/0x920 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
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

