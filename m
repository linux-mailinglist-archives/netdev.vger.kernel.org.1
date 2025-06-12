Return-Path: <netdev+bounces-196787-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05833AD658F
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 04:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 757403AEA09
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 02:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B9D15278E;
	Thu, 12 Jun 2025 02:21:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B8A1C861B
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 02:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749694893; cv=none; b=BN9566ZzDSXyvxG+DQongb7COq1reqCpV3C6AF9P8JGWaufohkVgxzdI5YelhWrgjbM0bgbNprtWFsaynWsnMZYIjsa+ZjGrkYZKQd+L3/LLvpK5XZMoK3tCoczGOZl67ondcKsiX0H6OJdhvLQTpPLmhfHAzNbzaR+O/KfQlDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749694893; c=relaxed/simple;
	bh=I0wIafBmjgY/k++GKwdSN60MB3WCviwy1xi0jvUyrgE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ugJZOcQNCLzJQ4nqQo2IJWdJCRcg2pVqkf6ecLk+oUX1qxa5wur6mGLVSAjZFmxSSiYI2dBO1lDNHIhg9/3wkKOOFpmfTbuNZfuwHXEnGmozd+CVy77msJEwUeRL9iRJIzZUJ4Qn93POpxaTvK4Mc777P4aRxuB450GW+1U81MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3ddb9c3b6edso6600035ab.3
        for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 19:21:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749694890; x=1750299690;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=euGFcYxwvILslc6mSywz+MxOLipSHXfa2whFFIad6xc=;
        b=kOYuae5lXvNRdsi3mGfXlOjeVt/hQKTtkyR3ir9/51tazmXUYzT72upgHyG/voblH0
         hKJmEm/mCk6xRztV3rz1NxsiH741f/hFg5iN+3wFDvgzZT22rKwGOAOFF0qbpPF36HH6
         sJHQheIGcn7ejfTVccU6qy6kDH50nJA/eiEF/4hfJKpkXGey+KAyElYj0VtH+6aTxWcy
         CDFoQGLUIIHQ94zUQsjgDt4WsLCK850mBvKJ8jrOHcLOeruyr2DxN4Dm3DLPGMtRRcoG
         5kdezqbfspt3zGec/XmIwg14Bo0q7Yi36+1iBEzRjTzYbJ4gD9/Hk9NwHpIcS6Y9yZI7
         Ndew==
X-Forwarded-Encrypted: i=1; AJvYcCVWdV3mZvLIXv25L1UDDE5eiYuC5DBPeqMa54KIYV9qwfDQH7hgIjsyY6Dd1hKG60S8VRT4CpQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqLdT+GzJzegSVYH3ToPj2O0YRQRS6QhR0MGqyzfPTgOERpnbt
	ByA+cY6ghOGNh3yybiuVM+QzTCoMS6bGAqDO0vg8szcRumlhaBLmRsPxRO7mtc9KgQzVClMt8Nc
	kCtPONhjUi8pWKWeXlCN4n4Lla6zvAOseftrV+FHv5cSVaFv8sBMG/b2AJqE=
X-Google-Smtp-Source: AGHT+IHWtScErTlqhBbkgjND+64RgLdoX6HSAte0j6KpDkhoCjdTs0FCtfafDfD5kLkhCLtKFv9Lys3rFKoXwrmisRp5fC28Htl1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2588:b0:3dd:a13c:603e with SMTP id
 e9e14a558f8ab-3ddfb65a883mr9947575ab.14.1749694890642; Wed, 11 Jun 2025
 19:21:30 -0700 (PDT)
Date: Wed, 11 Jun 2025 19:21:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <684a39aa.a00a0220.1eb5f5.00fa.GAE@google.com>
Subject: [syzbot] [net?] WARNING in __linkwatch_sync_dev (2)
From: syzbot <syzbot+b8c48ea38ca27d150063@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f09079bd04a9 Merge tag 'powerpc-6.16-2' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16e9260c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e24211089078d6c6
dashboard link: https://syzkaller.appspot.com/bug?extid=b8c48ea38ca27d150063
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-f09079bd.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ef68cb3d29a3/vmlinux-f09079bd.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1cc9431b9a15/bzImage-f09079bd.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b8c48ea38ca27d150063@syzkaller.appspotmail.com

------------[ cut here ]------------
RTNL: assertion failed at ./include/net/netdev_lock.h (72)
WARNING: CPU: 0 PID: 1141 at ./include/net/netdev_lock.h:72 netdev_ops_assert_locked include/net/netdev_lock.h:72 [inline]
WARNING: CPU: 0 PID: 1141 at ./include/net/netdev_lock.h:72 __linkwatch_sync_dev+0x1ed/0x230 net/core/link_watch.c:279
Modules linked in:
CPU: 0 UID: 0 PID: 1141 Comm: kworker/u32:5 Not tainted 6.16.0-rc1-syzkaller-00003-gf09079bd04a9 #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: bond0 bond_mii_monitor
RIP: 0010:netdev_ops_assert_locked include/net/netdev_lock.h:72 [inline]
RIP: 0010:__linkwatch_sync_dev+0x1ed/0x230 net/core/link_watch.c:279
Code: 05 ff ff ff e8 64 d1 59 f8 c6 05 76 2e 2e 07 01 90 ba 48 00 00 00 48 c7 c6 c0 88 e3 8c 48 c7 c7 60 88 e3 8c e8 64 96 18 f8 90 <0f> 0b 90 90 e9 d6 fe ff ff 48 c7 c7 44 3e a8 90 e8 fe 8e c0 f8 e9
RSP: 0018:ffffc900064a79f0 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffff8880368fc000 RCX: ffffffff817ae368
RDX: ffff88802990a440 RSI: ffffffff817ae375 RDI: 0000000000000001
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000001 R12: 1ffff92000c94f48
R13: ffff8880368fccc5 R14: ffffffff8c5909c0 R15: ffffffff899b8950
FS:  0000000000000000(0000) GS:ffff8880d6754000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555560fdf808 CR3: 000000000e382000 CR4: 0000000000352ef0
DR0: 0000000010000007 DR1: 400000000000000c DR2: 0000000000000000
DR3: 0000000000000005 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ethtool_op_get_link+0x1d/0x70 net/ethtool/ioctl.c:63
 bond_check_dev_link+0x3f9/0x710 drivers/net/bonding/bond_main.c:863
 bond_miimon_inspect drivers/net/bonding/bond_main.c:2745 [inline]
 bond_mii_monitor+0x3c0/0x2dc0 drivers/net/bonding/bond_main.c:2967
 process_one_work+0x9cf/0x1b70 kernel/workqueue.c:3238
 process_scheduled_works kernel/workqueue.c:3321 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3402
 kthread+0x3c5/0x780 kernel/kthread.c:464
 ret_from_fork+0x5d4/0x6f0 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
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

