Return-Path: <netdev+bounces-110942-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F241392F0BC
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 23:10:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32113B22F51
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 21:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF5719FA9A;
	Thu, 11 Jul 2024 21:10:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7533B19F47A
	for <netdev@vger.kernel.org>; Thu, 11 Jul 2024 21:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720732225; cv=none; b=PlB4SumtvLkGUm9SnAjWXwQr+t8BnC/SeETDzYBSpDW7Gbqkobv8SeQGIaVwmvDnPwRj39P4o+NDl61Tu+vr6CIgqOOgoDtO5GgnokL2+bEMOWK5OGH9acmE6KmrNM/4H6WlQxMDw8rP4e6ZVhjsIbjiro4dlHHdSbMPw9RBRRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720732225; c=relaxed/simple;
	bh=9O3dktKpo78cZcAPcDoMCi1+dE25j7QtQs6O2dVg4g4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=o0V10VzFGqocOjk0OZJfAhV+4JIhuNW0lUzKdfh7q64vyleYFtCrKnKaniEUtj7PNSEvgop6eEQOkXJFpec8yTUoHrvytVDZSJFpI5oObP+bIdwRp1yDeJzcYdHPoUDxXMxgehLrmaeScRnwzkmBjHqxMZB+OHg9hI1NwtcaMD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-385872df1e8so15100945ab.0
        for <netdev@vger.kernel.org>; Thu, 11 Jul 2024 14:10:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720732222; x=1721337022;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JFtUl9rBQ7g1D4BdfUCEpKR18xXDWJqyv4KIADqXAII=;
        b=XVkX9UGBVccPH5bmNsDP/Pvqi8MnW3ffzIr8uFw9BnurKl4qdyQnqjfX0Aprte5LCN
         j/+ydTYD/qYW4HDGG9Jx0o6MoB8EJ7xyxbkzGMU6Zqk/AWhhmdK195NS8C5j9P39fpUr
         mjOox6q35/Etjiyd6zoYvJ7/zNq8KY8ArZg8MwwF9W8/rrWySRitqreK++0Qs8CxUZX7
         mQ6ycPCIVmRCeXpxmC72mOlpDjJohiCF79Rr6pWpM4EdhJpNydF0+wdl5zB3+RMx2CX7
         1/MqTmJs3xW/3BuojxCkOv7XhOr8lsaH5bLNlnnMDTd9GUKCFIdOe5ZkowUbrIejnVdy
         /tsg==
X-Forwarded-Encrypted: i=1; AJvYcCXaJTG/MeuLg7ZIMyupUXA9ADfEPorF7fWPqgcFXClOOgZArHy3xyVJZ8vNbiXjFD6xKcFwlLVeBcmQLpyuDQTdfV85PBIh
X-Gm-Message-State: AOJu0Yym3TgUGax69X9EEMXMY8J8f2AvXTqSowhEVuDn+hEyLiOFypyR
	FUpGYzfMsIEPYvwIEIDdc3X1niv3q2Cn5tUkWQUTz70LSh72f6MkB+Jht/3TbJYQq8Jz1T305WU
	50k2GnHaSRqFwzHbAM3C5lLHaZddZem0Ib5Yi+upT2yJscUq5U1L7gSA=
X-Google-Smtp-Source: AGHT+IH298BxKap/ooBpbo8rE7DVtOncXQpXRWzeKODjJprECB17vSAvX4t8pckDp43eCsZyn2ebXG2/y6uwgNJwxebnsV2Ea9cC
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:11ab:b0:376:4736:8ff5 with SMTP id
 e9e14a558f8ab-38a5417281bmr1563405ab.0.1720732222603; Thu, 11 Jul 2024
 14:10:22 -0700 (PDT)
Date: Thu, 11 Jul 2024 14:10:22 -0700
In-Reply-To: <000000000000eb54bf061cfd666a@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e1d1a2061cff308e@google.com>
Subject: Re: [syzbot] [net?] BUG: sleeping function called from invalid
 context in synchronize_net
From: syzbot <syzbot+9b277e2c2076e2661f61@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, jhs@mojatatu.com, 
	jiri@resnulli.us, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    523b23f0bee3 Add linux-next specific files for 20240710
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=11b62585980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=98dd8c4bab5cdce
dashboard link: https://syzkaller.appspot.com/bug?extid=9b277e2c2076e2661f61
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=148611e1980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10ec9585980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/345bcd25ed2f/disk-523b23f0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a4508962d345/vmlinux-523b23f0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4ba5eb555639/bzImage-523b23f0.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9b277e2c2076e2661f61@syzkaller.appspotmail.com

BUG: sleeping function called from invalid context at net/core/dev.c:11239
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 1046, name: kworker/u8:5
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
INFO: lockdep is turned off.
CPU: 0 UID: 0 PID: 1046 Comm: kworker/u8:5 Not tainted 6.10.0-rc7-next-20240710-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
Workqueue: bond0 bond_mii_monitor
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 __might_resched+0x5d4/0x780 kernel/sched/core.c:8526
 synchronize_net+0x1b/0x50 net/core/dev.c:11239
 dev_deactivate_many+0x4a7/0xb10 net/sched/sch_generic.c:1371
 dev_deactivate+0x184/0x280 net/sched/sch_generic.c:1397
 linkwatch_do_dev+0x10a/0x170 net/core/link_watch.c:175
 ethtool_op_get_link+0x15/0x60 net/ethtool/ioctl.c:62
 bond_check_dev_link+0x1f1/0x3f0 drivers/net/bonding/bond_main.c:757
 bond_miimon_inspect drivers/net/bonding/bond_main.c:2604 [inline]
 bond_mii_monitor+0x49a/0x3170 drivers/net/bonding/bond_main.c:2826
 process_one_work kernel/workqueue.c:3228 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3309
 worker_thread+0x86d/0xd40 kernel/workqueue.c:3387
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
------------[ cut here ]------------
Voluntary context switch within RCU read-side critical section!
WARNING: CPU: 1 PID: 1046 at kernel/rcu/tree_plugin.h:330 rcu_note_context_switch+0xcf4/0xff0 kernel/rcu/tree_plugin.h:330
Modules linked in:
CPU: 1 UID: 0 PID: 1046 Comm: kworker/u8:5 Tainted: G        W          6.10.0-rc7-next-20240710-syzkaller #0
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
Workqueue: bond0 bond_mii_monitor
RIP: 0010:rcu_note_context_switch+0xcf4/0xff0 kernel/rcu/tree_plugin.h:330
Code: 00 ba 02 00 00 00 e8 bb 02 fe ff 4c 8b b4 24 80 00 00 00 eb 91 c6 05 a4 4f 1f 0e 01 90 48 c7 c7 e0 2d cc 8b e8 ad c5 da ff 90 <0f> 0b 90 90 e9 3b f4 ff ff 90 0f 0b 90 45 84 ed 0f 84 00 f4 ff ff
RSP: 0018:ffffc900041cefc0 EFLAGS: 00010046
RAX: 583d87a6c7750500 RBX: ffff88802123de44 RCX: ffff88802123da00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc900041cf110 R08: ffffffff815583f2 R09: fffffbfff1c39f8c
R10: dffffc0000000000 R11: fffffbfff1c39f8c R12: ffff88802123da00
R13: 0000000000000000 R14: 1ffff92000839e10 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f5b6614bbe3 CR3: 0000000022676000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __schedule+0x348/0x4a60 kernel/sched/core.c:6491
 __schedule_loop kernel/sched/core.c:6680 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6695
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6752
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a4/0xd70 kernel/locking/mutex.c:752
 exp_funnel_lock kernel/rcu/tree_exp.h:329 [inline]
 synchronize_rcu_expedited+0x451/0x830 kernel/rcu/tree_exp.h:967
 dev_deactivate_many+0x4a7/0xb10 net/sched/sch_generic.c:1371
 dev_deactivate+0x184/0x280 net/sched/sch_generic.c:1397
 linkwatch_do_dev+0x10a/0x170 net/core/link_watch.c:175
 ethtool_op_get_link+0x15/0x60 net/ethtool/ioctl.c:62
 bond_check_dev_link+0x1f1/0x3f0 drivers/net/bonding/bond_main.c:757
 bond_miimon_inspect drivers/net/bonding/bond_main.c:2604 [inline]
 bond_mii_monitor+0x49a/0x3170 drivers/net/bonding/bond_main.c:2826
 process_one_work kernel/workqueue.c:3228 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3309
 worker_thread+0x86d/0xd40 kernel/workqueue.c:3387
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

