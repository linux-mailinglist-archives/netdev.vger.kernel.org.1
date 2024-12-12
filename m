Return-Path: <netdev+bounces-151301-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D9E9EDE95
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 05:41:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14BC8162316
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 04:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0640A168497;
	Thu, 12 Dec 2024 04:41:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3771632DA
	for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 04:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733978485; cv=none; b=kkdb1cdIjUxRiQ9F0Zx/LLIoqz1yHZs9CCrx/V+7QYnMWPjyGAJTvoktWXwVihjE7+TkluXWT7S6jbCM5P/RbuFsyJj9DVjL/9BDKN12d0Y8ulCY5Tz565Vhn6SGxsYgqX4A05eWwSkBNvsjVxifNebd0qGSEZWi7/VtU/dAACA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733978485; c=relaxed/simple;
	bh=mRUP88o1vYUkBTOYZZUrYwZIPtL1QkuhuFKt1jdzph4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=p6Foc3jC2tr6CVymHL4qFEaJh6E6nXGPEsXNMX/eOoWtwi3zHsj5kGLcSqdtjAyqbmbg89rR36DgJe4Dl/LGhkxaRcy+bEYUbF3Xr0N/scHZvPR/1+EhaVhdTNS7BDFre2fIzbo77IaPlwPIocumMeNIhk1HPO+DspG6cKmQRZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3a9d075bdc3so4481435ab.3
        for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 20:41:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733978483; x=1734583283;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6i+UFR5QAg/htQWbJqPb5ENw5otoHq5vhy8B41aRmTk=;
        b=MEz/3VFbmeTVGXuXLIjvMJtMW+jq6Ll8WVecgID26ngbxPk+7/y4HCfkkoNUm44CyI
         HIvhCkuhlhyJnxdP58PLH0Rauv1R2TmHvIJfGynqZK4bn3+5T22HntNM0wfTwo9xuj5+
         5fqIkB+lhiwww41kV61fnpqabcebur4vR+b/UYiu742lWHn5WrEkiT/rESezy07AO81C
         e8F2AGH5CPwTSMThlZ0grHlEKutmrzOzKLCprOh5LLF8hJg+Rf5Mm2orZgsubwT3BIe5
         mC34037qlcNToT3NkHBnYwqJduvPlTYWcKrr5zjKs4Mf1ql0yteMAKyxHktz+JHz4CO4
         4dBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTp12tPUNgZ/W5RLYC6eIY4sQygdUCoJLNYtWYPIALUVYvdiq9MYCUKrgKcq8z79KvPKupzas=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1WhDCemQkSczwZD+G4dSvJSloa61HlJG6Bwi9MDm7SPAIKpy+
	1pNlQD5tbFU1kZIvArs709VmKnxljo0GSyJfqEfUNUaTB8mwiGJVTnFqE8tHmxCso5CLcoUcjDC
	4z0htDmsHw0NrwAF5rmLPFKn1DWzg3Iqijxx2LaNBBFMOhpcsVhrULac=
X-Google-Smtp-Source: AGHT+IF7hZOGQsYnWyD1jmnUwVNk6byVH4UmYE20sGt2xhakUPRENmuUv35XY2FYWd8tXd4KVyiTVLHau2gQeV+IScDc0mqeyy9j
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1486:b0:3a6:ad61:7ff8 with SMTP id
 e9e14a558f8ab-3ac48d9eb3dmr23195855ab.12.1733978483669; Wed, 11 Dec 2024
 20:41:23 -0800 (PST)
Date: Wed, 11 Dec 2024 20:41:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <675a6973.050a0220.17f54a.0050.GAE@google.com>
Subject: [syzbot] [wireless?] BUG: sleeping function called from invalid
 context in wext_netdev_notifier_call
From: syzbot <syzbot+3647b9259b77c1bb8e94@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    4c49f38e20a5 net: stmmac: fix TSO DMA API usage causing oops
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=11614820580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1362a5aee630ff34
dashboard link: https://syzkaller.appspot.com/bug?extid=3647b9259b77c1bb8e94
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/09256902989e/disk-4c49f38e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2b41c0f5233f/vmlinux-4c49f38e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7bb9fdcd5331/bzImage-4c49f38e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3647b9259b77c1bb8e94@syzkaller.appspotmail.com

BUG: sleeping function called from invalid context at kernel/locking/rwsem.c:1523
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 12894, name: kworker/u8:18
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
INFO: lockdep is turned off.
CPU: 1 UID: 0 PID: 12894 Comm: kworker/u8:18 Not tainted 6.13.0-rc1-syzkaller-00183-g4c49f38e20a5 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: bond0 bond_mii_monitor
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 __might_resched+0x5d4/0x780 kernel/sched/core.c:8758
 down_read+0x8e/0xa40 kernel/locking/rwsem.c:1523
 wireless_nlevent_flush net/wireless/wext-core.c:351 [inline]
 wext_netdev_notifier_call+0x1f/0x120 net/wireless/wext-core.c:371
 notifier_call_chain+0x1a5/0x3f0 kernel/notifier.c:85
 netdev_state_change+0x11f/0x1a0 net/core/dev.c:1378
 linkwatch_do_dev+0x112/0x170 net/core/link_watch.c:182
 ethtool_op_get_link+0x15/0x60 net/ethtool/ioctl.c:62
 bond_check_dev_link+0x1f1/0x3f0 drivers/net/bonding/bond_main.c:873
 bond_miimon_inspect drivers/net/bonding/bond_main.c:2740 [inline]
 bond_mii_monitor+0x49a/0x3170 drivers/net/bonding/bond_main.c:2962
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa66/0x1840 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
bridge0: port 2(bridge_slave_1) entered blocking state
bridge0: port 2(bridge_slave_1) entered forwarding state


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

