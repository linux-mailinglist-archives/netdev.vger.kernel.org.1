Return-Path: <netdev+bounces-166710-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E10DA37020
	for <lists+netdev@lfdr.de>; Sat, 15 Feb 2025 19:20:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AF893AD2B1
	for <lists+netdev@lfdr.de>; Sat, 15 Feb 2025 18:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9698E1EA7CC;
	Sat, 15 Feb 2025 18:20:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D8D1DB346
	for <netdev@vger.kernel.org>; Sat, 15 Feb 2025 18:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739643619; cv=none; b=OW/kfiIz/tfK/dRCaXapJia4fS9eeH+x1W8GvpzgwjZdeOvv7UVECNKBF83172p1XU4Lh/GwYeqfgvz4EGVlEeZJfs2Yp/iVHlNg8Del34GMGAhQEuaSh8ImkyZhBgZGK17yTEJlOvX+7tLSN3IAhOG6q/1wOedfKIjOwcW1LRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739643619; c=relaxed/simple;
	bh=4IZFZVwxSOzjwGdsSJltCMPC+UOXv+W9HdBfvkqeNPM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Ue6oWCRHz/y+FGsswjCLf7l1KRL2l2OXz7uAmCnoEDUgUT9NCljWdZteuz1A2mEGRtmfC8zY984WBYLxiYrc8xx5f7GFIdHZzjZqb7L5nAn5mv4oPtpxQzQqhz+IYtcwP/3c9eoXFEaNQmOB9rnhDXkIetS4lq1PjeoCZcldoXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3d197cf2ec9so17685585ab.3
        for <netdev@vger.kernel.org>; Sat, 15 Feb 2025 10:20:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739643617; x=1740248417;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6soIbLLaWqTuyjlNGLM2C7ZiMywCYPk0bzeKRcfSfCA=;
        b=DRSseQSeSNiZbi0sSU0XjR4J5ivYz6VgzEsl80poMLv4qr3X0Abc3udaYY8aNRuBx0
         jDwePi78fFpyDsIX8r6UCaZ+biSxyrhIe+P48YnXj4mIwubh1X/abU2A/u0ZqgtCY0k5
         Y1no5lBLjE0SIbYEjc5tTXzpppldmFO9NpZQesaW2b0wQ9gsnS0R0YbT8O7Iskwc5zb/
         WnsV0sxSxdItReCIBO+m7S1I7jONzJvFjjoT8KLjkU2zEUGq9BK39Ud4BiH+tvAMIitV
         P7LccRc0lwBrUePdnxDiEn4vnTphdHSURD1iA8fqJVg37elxq1Cs/mMD+HY+uE9jdBAS
         323w==
X-Forwarded-Encrypted: i=1; AJvYcCU0W/F1xTWTO6zm0q394mRwIRCY0x3LjR6Fhda2CY8FzdBpk+01OCX9LL/rdx12e3TWdwCByPM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp+bePPVT+5jTGIGtAaRQ5AliMXB6WmtByUFlac8UXa27aSiCa
	gSqooT9+JOpGDSUsGcJcSLKgytz8wT0AQZuQhK2klkidZELbw2IpkQNGHyfnr1P55ApSsLoZZ7X
	G0ZHwq38AQ2YQgLG+dHty7E6xU9/4U/O8AAs2IBMn9EAN49YJC8Adlp8=
X-Google-Smtp-Source: AGHT+IG+GvKiaFPKEPnevbx3Uw8ccSd3DdGwU4IPkKUtnrbzZi0Gb60jDgG0HhmpC1JMGCtjfxIpBoKbMcx8FyqkRpbI4zP/B/6c
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2181:b0:3d1:4b97:4f2d with SMTP id
 e9e14a558f8ab-3d280763f51mr23479835ab.5.1739643616909; Sat, 15 Feb 2025
 10:20:16 -0800 (PST)
Date: Sat, 15 Feb 2025 10:20:16 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67b0dae0.050a0220.6f0b7.0016.GAE@google.com>
Subject: [syzbot] [kernel?] INFO: task hung in hci_dev_open (2)
From: syzbot <syzbot+b3b33ad3a3e6369375a7@syzkaller.appspotmail.com>
To: anna-maria@linutronix.de, davem@davemloft.net, frederic@kernel.org, 
	jhs@mojatatu.com, jiri@resnulli.us, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com, tglx@linutronix.de, 
	vinicius.gomes@intel.com, xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    ae9b3c0e79bc Merge branch 'tcp-allow-to-reduce-max-rto'
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=11e00aa4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1909f2f0d8e641ce
dashboard link: https://syzkaller.appspot.com/bug?extid=b3b33ad3a3e6369375a7
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=161e23f8580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/93d74fa441be/disk-ae9b3c0e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e226dd1d1f06/vmlinux-ae9b3c0e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/423579a2a07e/bzImage-ae9b3c0e.xz

The issue was bisected to:

commit 5a781ccbd19e4664babcbe4b4ead7aa2b9283d22
Author: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date:   Sat Sep 29 00:59:43 2018 +0000

    tc: Add support for configuring the taprio scheduler

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=126b4718580000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=116b4718580000
console output: https://syzkaller.appspot.com/x/log.txt?x=166b4718580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b3b33ad3a3e6369375a7@syzkaller.appspotmail.com
Fixes: 5a781ccbd19e ("tc: Add support for configuring the taprio scheduler")

INFO: task syz-executor:6086 blocked for more than 178 seconds.
      Not tainted 6.14.0-rc1-syzkaller-00272-gae9b3c0e79bc #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:25984 pid:6086  tgid:6086  ppid:6085   task_flags:0x400140 flags:0x00000000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5377 [inline]
 __schedule+0x190e/0x4c90 kernel/sched/core.c:6764
 __schedule_loop kernel/sched/core.c:6841 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6856
 schedule_timeout+0xb0/0x290 kernel/time/sleep_timeout.c:75
 do_wait_for_common kernel/sched/completion.c:95 [inline]
 __wait_for_common kernel/sched/completion.c:116 [inline]
 wait_for_common kernel/sched/completion.c:127 [inline]
 wait_for_completion+0x355/0x620 kernel/sched/completion.c:148
 __flush_workqueue+0x575/0x1280 kernel/workqueue.c:3998
 hci_dev_open+0x149/0x300 net/bluetooth/hci_core.c:455
 sock_do_ioctl+0x158/0x460 net/socket.c:1194
 sock_ioctl+0x626/0x8e0 net/socket.c:1313
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:906 [inline]
 __se_sys_ioctl+0xf5/0x170 fs/ioctl.c:892
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f940718c9eb
RSP: 002b:00007fff6ef05ae0 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f940718c9eb
RDX: 0000000000000005 RSI: 00000000400448c9 RDI: 0000000000000003
RBP: 00007fff6ef05b4c R08: 0000000000000000 R09: 00007fff6ef05a57
R10: 0000000000000008 R11: 0000000000000246 R12: 0000000000000005
R13: 0000000000000005 R14: 0000000000000009 R15: 0000000000000000
 </TASK>

Showing all locks held in the system:
3 locks held by kworker/0:0/8:
3 locks held by kworker/1:0/25:
1 lock held by khungtaskd/30:
 #0: ffffffff8e9387e0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #0: ffffffff8e9387e0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffffffff8e9387e0 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x55/0x2a0 kernel/locking/lockdep.c:6746
2 locks held by kworker/u8:3/51:
 #0: ffff88801ac89148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3211 [inline]
 #0: ffff88801ac89148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1840 kernel/workqueue.c:3317
 #1: ffffc90000bc7c60 ((work_completion)(&pool->idle_cull_work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3212 [inline]
 #1: ffffc90000bc7c60 ((work_completion)(&pool->idle_cull_work)){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1840 kernel/workqueue.c:3317
3 locks held by kworker/u9:0/53:
 #0: ffff88807da56148 ((wq_completion)hci5){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3211 [inline]
 #0: ffff88807da56148 ((wq_completion)hci5){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1840 kernel/workqueue.c:3317
 #1: ffffc90000be7c60 ((work_completion)(&hdev->power_on)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3212 [inline]
 #1: ffffc90000be7c60 ((work_completion)(&hdev->power_on)){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1840 kernel/workqueue.c:3317
 #2: ffff88805a3d8d80 (&hdev->req_lock){+.+.}-{4:4}, at: hci_dev_do_open net/bluetooth/hci_core.c:409 [inline]
 #2: ffff88805a3d8d80 (&hdev->req_lock){+.+.}-{4:4}, at: hci_power_on+0x1bf/0x6b0 net/bluetooth/hci_core.c:940
3 locks held by kworker/1:2/974:
 #0: ffff88801ac81d48 ((wq_completion)events_power_efficient){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3211 [inline]
 #0: ffff88801ac81d48 ((wq_completion)events_power_efficient){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1840 kernel/workqueue.c:3317
 #1: ffffc90003a0fc60 ((crda_timeout).work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3212 [inline]
 #1: ffffc90003a0fc60 ((crda_timeout).work){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1840 kernel/workqueue.c:3317
 #2: ffffffff8fcc0208 (rtnl_mutex){+.+.}-{4:4}, at: crda_timeout_work+0x15/0x50 net/wireless/reg.c:540
5 locks held by kworker/u8:5/1025:
3 locks held by kworker/u8:8/1153:
 #0: ffff888030945148 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3211 [inline]
 #0: ffff888030945148 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1840 kernel/workqueue.c:3317
 #1: ffffc90003d0fc60 ((work_completion)(&(&ifa->dad_work)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3212 [inline]
 #1: ffffc90003d0fc60 ((work_completion)(&(&ifa->dad_work)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1840 kernel/workqueue.c:3317
 #2: ffffffff8fcc0208 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_net_lock include/linux/rtnetlink.h:130 [inline]
 #2: ffffffff8fcc0208 (rtnl_mutex){+.+.}-{4:4}, at: addrconf_dad_work+0x10e/0x16a0 net/ipv6/addrconf.c:4190
3 locks held by kworker/0:2/1165:
4 locks held by kworker/u9:1/5146:
 #0: ffff88802976d948 ((wq_completion)hci1){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3211 [inline]
 #0: ffff88802976d948 ((wq_completion)hci1){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1840 kernel/workqueue.c:3317
 #1: ffffc900106d7c60 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3212 [inline]
 #1: ffffc900106d7c60 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1840 kernel/workqueue.c:3317
 #2: ffff888025450d80 (&hdev->req_lock){+.+.}-{4:4}, at: hci_cmd_sync_work+0x1ec/0x400 net/bluetooth/hci_sync.c:331
 #3: ffff888025450078 (&hdev->lock){+.+.}-{4:4}, at: hci_abort_conn_sync+0x1e4/0x11f0 net/bluetooth/hci_sync.c:5569
2 locks held by dhcpcd/5502:
2 locks held by getty/5586:
 #0: ffff8880355800a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc90002fde2f0 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x6a6/0x1e00 drivers/tty/n_tty.c:2211
1 lock held by syz-execprog/5826:
4 locks held by kworker/u9:2/5851:
 #0: ffff88802991a148 ((wq_completion)hci3){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3211 [inline]
 #0: ffff88802991a148 ((wq_completion)hci3){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1840 kernel/workqueue.c:3317
 #1: ffffc900041bfc60 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3212 [inline]
 #1: ffffc900041bfc60 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1840 kernel/workqueue.c:3317


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

