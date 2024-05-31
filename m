Return-Path: <netdev+bounces-99715-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 218088D6071
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 13:16:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CA5B1F23B7D
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 11:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 420E115746F;
	Fri, 31 May 2024 11:16:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9B61E488
	for <netdev@vger.kernel.org>; Fri, 31 May 2024 11:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717154183; cv=none; b=lxHC07PcnZePFN7k1Z/OhizsG41yqPn4/l4vw17fAK4qWdmWd+mzyNmYARAI9gShvWywh3M+9kvK7dwo7kvM9Wcg4EwW2wN+OzueDhjGXFRVyjoMaxBLLXbvJ9VfJQyl8hSt7G/1pkmgbU1K+6X49p3TXtD2xYuVBiZdqfFTVbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717154183; c=relaxed/simple;
	bh=vaJO+t7UBfSCG7w9kImcmmbHgMk84WfMTKgO0x2bVbs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=bvIDQof+quTfhVirzKtBU5JNUtzb67bcsq/nhmvDua17Iul2T0lE3txCuX+kjXr5rmgiXHbCVxIFwZRwU6hpfiBbwsUEEhQ/WyGq1/LEAxiRPPk6MzgThRdJXMxqLb3rYfVNcWsPq7jfkIzNwlaIAKTNM8QTnBKsGrVpxZrqBzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3737b4129deso15863555ab.3
        for <netdev@vger.kernel.org>; Fri, 31 May 2024 04:16:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717154181; x=1717758981;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4OINMwCS5WTA/HKJpYzdnumeRE5CjfGe5ajny/7xJwc=;
        b=rKyjS07RZXjuPmNYwj1EavqhAS1rOMI844HJ5YffanItznIA43wpNUJPHGazc0NfSc
         +GjXR65Q24+VRnl9s91TcFuIl70xzZCPT44NTpF2Q8I4YBt/H0PW16J9IqKDQCXQGHIU
         0KneQtOdjoz12hGGYqFQjSxAhufiesFBfEajftaBmV2hne2Ls1Azhu3BQYOnpA8rP5pX
         7dvHybWvYWjdQY7h/bHflEUmejLnRcfHl8MjxBuPgNUos6Xb4VnpmjM5aLACVefB+9//
         bXMUddbl3//Uv+yGktc7F+N/r97R3e/dO5cZ2wlIXQBP8EdeQxTTIhoX65KNFxTcI6wO
         8/oQ==
X-Forwarded-Encrypted: i=1; AJvYcCUyMET99DJ78+rTQXMh/tvQ0c/icedxdnArJ5t6GixBbVRTFoGh+37I41YctVacBOftoXro8AW8oOwX3jatpZUGNhC3toWf
X-Gm-Message-State: AOJu0YzIZnBoQUxsHWMSiViX2kLF9T2Gl7sF6Tag04cBB5mapBJ2YxvB
	ODU4z0qEfoepiVw3+4PZlI4P/OMVMquCUtIuLzFVNHUgGHyIFF4eHjqqh7WRN3NYA/Q/QIxoeXo
	8C2yum62uNKZdAGoHPZbh5qoT0aU0w1Z49rbKZtnm4Cti3ZTTFo2ugn8=
X-Google-Smtp-Source: AGHT+IErOzCfAQfYVmXMBaHESrfjtlXqikm3OiIgkpEXhJxyh95piNezFP9946a+qaD4PZ+KAZGNTiIP7toNpNY9n1CyM67mmt/h
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a69:b0:36c:4cc9:5923 with SMTP id
 e9e14a558f8ab-3748b979347mr983575ab.2.1717154180868; Fri, 31 May 2024
 04:16:20 -0700 (PDT)
Date: Fri, 31 May 2024 04:16:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f9be320619be1c0a@google.com>
Subject: [syzbot] [net?] INFO: task hung in nsim_destroy (4)
From: syzbot <syzbot+8141dcbd23a8f857798a@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    4a4be1ad3a6e Revert "vfs: Delete the associated dentry whe..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14e37be6980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=238430243a58f702
dashboard link: https://syzkaller.appspot.com/bug?extid=8141dcbd23a8f857798a
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b1ea85ab1f5b/disk-4a4be1ad.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/681d06438c4b/vmlinux-4a4be1ad.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9f422d33e089/bzImage-4a4be1ad.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8141dcbd23a8f857798a@syzkaller.appspotmail.com

INFO: task kworker/u8:10:2466 blocked for more than 143 seconds.
      Not tainted 6.10.0-rc1-syzkaller-00027-g4a4be1ad3a6e #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u8:10   state:D stack:24624 pid:2466  tgid:2466  ppid:2      flags:0x00004000
Workqueue: netns cleanup_net
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5408 [inline]
 __schedule+0xf15/0x5d00 kernel/sched/core.c:6745
 __schedule_loop kernel/sched/core.c:6822 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6837
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6894
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x5b8/0x9c0 kernel/locking/mutex.c:752
 nsim_destroy+0x6f/0x6a0 drivers/net/netdevsim/netdev.c:772
 __nsim_dev_port_del+0x189/0x240 drivers/net/netdevsim/dev.c:1425
 nsim_dev_port_del_all drivers/net/netdevsim/dev.c:1437 [inline]
 nsim_dev_reload_destroy+0x108/0x4d0 drivers/net/netdevsim/dev.c:1658
 nsim_dev_reload_down+0x6e/0xd0 drivers/net/netdevsim/dev.c:965
 devlink_reload+0x19a/0x7c0 net/devlink/dev.c:461
 devlink_pernet_pre_exit+0x1a1/0x2b0 net/devlink/core.c:509
 ops_pre_exit_list net/core/net_namespace.c:163 [inline]
 cleanup_net+0x488/0xbf0 net/core/net_namespace.c:620
 process_one_work+0x9fb/0x1b60 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xf70 kernel/workqueue.c:3393
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
INFO: task kworker/1:4:5158 blocked for more than 143 seconds.
      Not tainted 6.10.0-rc1-syzkaller-00027-g4a4be1ad3a6e #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/1:4     state:D stack:24768 pid:5158  tgid:5158  ppid:2      flags:0x00004000
Workqueue: events linkwatch_event
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5408 [inline]
 __schedule+0xf15/0x5d00 kernel/sched/core.c:6745
 __schedule_loop kernel/sched/core.c:6822 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6837
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6894
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x5b8/0x9c0 kernel/locking/mutex.c:752
 linkwatch_event+0x51/0xc0 net/core/link_watch.c:276
 process_one_work+0x9fb/0x1b60 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xf70 kernel/workqueue.c:3393
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/30:
 #0: ffffffff8dbb18e0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
 #0: ffffffff8dbb18e0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:781 [inline]
 #0: ffffffff8dbb18e0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x75/0x340 kernel/locking/lockdep.c:6614


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

