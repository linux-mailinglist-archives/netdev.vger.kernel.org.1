Return-Path: <netdev+bounces-180067-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B12BAA7F6AF
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 09:44:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4547318900C5
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 07:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F850264620;
	Tue,  8 Apr 2025 07:41:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B506B26461D
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 07:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744098088; cv=none; b=udPLtNjExqS4USPY4puxyG8XF+NJkq2ZLEZI4+U3x8p7z9ESz509WcLGUKy43oQ+jaSxSqQz2RMGFs8evmVngGRETparl/5DlHyi8Gx9a2/ibvJFwd3e3xo6V2MemcM5qahCNJdIQKFYxgT6J9ZuGfQF/FiEbtata/cKmBkBa3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744098088; c=relaxed/simple;
	bh=c7DCdLXbOqDr50W9/qA7Md2fmFxz0hPGsDzruBo5d3U=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Awh9bam9rkgD2u62ozElskXD0txOO2EsS3UJHIByiWKpND/pY/pP3ZLFpRjnsxg+SOIrU5tFAIy62UY3WSsWXtPSV97Tom2a+fIYWXfYW42jcfHTMOsZOZKOghJGb2lnnT3MQ/ni3ejOfshWNskZBnrBz3P5HD7GoNQxl4qSX5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3d44ba1c2b5so57446305ab.2
        for <netdev@vger.kernel.org>; Tue, 08 Apr 2025 00:41:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744098086; x=1744702886;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D9nvmIGS/pjAS2D5FId0VkYzyKtpxKn9WhfgUHy7ueM=;
        b=DihE8KlD15aptsMkxvgksvss5rUQQL03mn///aLoiJHlBEOuNpWZfToOFtKWN1lhvn
         LjTvKl1G3czFNWYwYDK3/R//sh3+dF2oV2pKV3IRiYC4YWG6BPIBStX3+lQUhq4ZgnSt
         36EqVc+AXu4uvkU74lZvjtOWRijRebf5FcTy05XWEyKL0vpi6LV7N2rSWz63iaETikps
         P9i0gdGebKLcahgwk/qT4mzS/aOzxyoECwf+tNOHEb86xuzeNYaB0i+rTZO+7GT3E7Ds
         i7UX/NAUELTMP5ujcO+x+F07Emvuy2bpL1zfJO064PrzUdH8jX3T/UCmO91pIgoULIrm
         dY6A==
X-Forwarded-Encrypted: i=1; AJvYcCX2qyhELp4zxC7Zy3FHWPbT+urAziS+Q26eBzwJb+H3yBqI30BVe7KCr8x41gzZE0NxcXRHzvU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAizvk/BWEOrKDQ/4loCjxqJCo+zHRYfaFSnUdyABBfVswesl8
	sBNi48jieJQ0+b1+zC6WTkve8rL1fUjZ8nlw4iYPI9UHW2RCQqkHoAmWAFlQ0jxGiR2RrrnKiWp
	CRmXPN/4nuI3Wl8HEgiN75H6MvD7CjN5ar8DIfzf7NM6dE8SrmyVI+7g=
X-Google-Smtp-Source: AGHT+IFZ2eHvFY/2Wu1GWjf1i7Xo7TQNwvjqzZ1pDdaqmGpIuMTl8L+5R8VHp4cPz1mlzRR1Q3tpXamKc3qegXbFgf9LLqtrtjyb
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2602:b0:3d3:fa0a:7242 with SMTP id
 e9e14a558f8ab-3d6e53473acmr150443345ab.9.1744098085699; Tue, 08 Apr 2025
 00:41:25 -0700 (PDT)
Date: Tue, 08 Apr 2025 00:41:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67f4d325.050a0220.396535.0558.GAE@google.com>
Subject: [syzbot] [net?] WARNING in __linkwatch_sync_dev
From: syzbot <syzbot+48c14f61594bdfadb086@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7702d0130dc0 Add linux-next specific files for 20250408
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=15fe8070580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=91edf513888f57d7
dashboard link: https://syzkaller.appspot.com/bug?extid=48c14f61594bdfadb086
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0603dd3556b9/disk-7702d013.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d384baaee881/vmlinux-7702d013.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1ac172735b6c/bzImage-7702d013.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+48c14f61594bdfadb086@syzkaller.appspotmail.com

------------[ cut here ]------------
RTNL: assertion failed at ./include/net/netdev_lock.h (56)
WARNING: CPU: 1 PID: 2971 at ./include/net/netdev_lock.h:56 netdev_ops_assert_locked include/net/netdev_lock.h:56 [inline]
WARNING: CPU: 1 PID: 2971 at ./include/net/netdev_lock.h:56 __linkwatch_sync_dev+0x30d/0x360 net/core/link_watch.c:279
Modules linked in:
CPU: 1 UID: 0 PID: 2971 Comm: kworker/u8:8 Not tainted 6.15.0-rc1-next-20250408-syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
Workqueue: bond0 bond_mii_monitor
RIP: 0010:netdev_ops_assert_locked include/net/netdev_lock.h:56 [inline]
RIP: 0010:__linkwatch_sync_dev+0x30d/0x360 net/core/link_watch.c:279
Code: 7c fe ff ff e8 f4 63 cc f7 c6 05 83 28 53 06 01 90 48 c7 c7 60 5c 51 8d 48 c7 c6 8a 9b 67 8e ba 38 00 00 00 e8 04 6b 8b f7 90 <0f> 0b 90 90 e9 4d fe ff ff 89 d9 80 e1 07 38 c1 0f 8c 19 fd ff ff
RSP: 0018:ffffc9000b767710 EFLAGS: 00010246
RAX: bb6ea754fa006300 RBX: 0000000000000000 RCX: ffff888030979e00
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff81824ed2 R09: 1ffffffff20c01c6
R10: dffffc0000000000 R11: fffffbfff20c01c7 R12: 0000000000000000
R13: dffffc0000000000 R14: ffff88805d768008 R15: ffff88805d768000
FS:  0000000000000000(0000) GS:ffff888125089000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f85e8c4df98 CR3: 000000006a050000 CR4: 00000000003526f0
DR0: 0000000000000099 DR1: 0000000000000000 DR2: 000000000000000b
DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ethtool_op_get_link+0x15/0x60 net/ethtool/ioctl.c:63
 bond_check_dev_link+0x1fb/0x4b0 drivers/net/bonding/bond_main.c:864
 bond_miimon_inspect drivers/net/bonding/bond_main.c:2734 [inline]
 bond_mii_monitor+0x49d/0x3170 drivers/net/bonding/bond_main.c:2956
 process_one_work kernel/workqueue.c:3238 [inline]
 process_scheduled_works+0xac3/0x18e0 kernel/workqueue.c:3319
 worker_thread+0x870/0xd50 kernel/workqueue.c:3400
 kthread+0x7b7/0x940 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:153
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

