Return-Path: <netdev+bounces-188513-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF88DAAD26F
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 02:51:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D99F91B629B8
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 00:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C09BA94A;
	Wed,  7 May 2025 00:51:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CACEAF1
	for <netdev@vger.kernel.org>; Wed,  7 May 2025 00:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746579088; cv=none; b=L/dEbx+9Wo2rUA8ARO6IFpU70bb36oDzIqtmovj8rF21miSaHIaqKtgjs9zQkyqApwW7H3X9mRtbixzdED2RrmI2vOwpU9eiA3tVnJoPfUDvPthiaqkuQmwnL9A5hlrR+mwepUTfMW7h7eIX9uQ20Fwybs0G8mll7u14CeIKa90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746579088; c=relaxed/simple;
	bh=+n7BLbn2ptFLmjJapcF7sG1/fwuqDq+wwGBd5iLh3GA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=WOcadi5WrDHwL2LvCSoEFdVoD56mNnL+E4SvL8PfiFpAZSrTjZJ9RgMs96hB30e5PehmF4kWWpUtaRP3ItELKTy7LtjfhJzQXHT+8Gk2G1x5oneV713L46sdjVsEUr91Fe6BmXMBHSaLtGJSokiaGb++EVVEEjDWnvVcmLKT/5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3d83124c000so104460155ab.1
        for <netdev@vger.kernel.org>; Tue, 06 May 2025 17:51:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746579085; x=1747183885;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=snlOmYc9GT0G7ViuqOxb4q3+tOmRsRDISQ2me6OFseg=;
        b=Od92+b/P+4wGH2xzl6Q06/JMUaZWiVirohz3be+uecqBTNaNrXDDo4EZvT/x+CDtIx
         EIJZYUCC3b5VwlSwa2W6Pmqnew9tDgNL6P9wvayTfShRzYQFksn2J+8yt0q782MsC9Sx
         iEtSe2z+WCXJcvTPqNpI58A6WKCVwwm9q8eTvHdIBk7QBZKALMyZJlsLw/KLJRHD3O8W
         MDamfw3SPqSnk35XNuzKOgTSkk3QnM4KqLOp7qKNIJ9ehNVd50IdqXJFJl/P6joGteyX
         VjkPOVYx79bd79aRWVA3CNbot807ZrEkHImRLl7D/isrlOZVMunMI86b3NY5wGhrYWkq
         +b/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUJjB3IZub4iBrK/HXAcyaL/hocRzN+NGlVnxeAEbyddD4yQma7d5TusUuJ+BuFet4a94PLj8U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyG6Eu/AHcX0aoy6cViNBHKpOLVImoCPvjZ0iJOD7sfM1uq+1cz
	v26N4uHuNDzEU8ZWPFIRqSGIIv2YwzptSKHTiYKI1hRUF1IZy51KehlzaaTZgIoAs6v7n6Aruz6
	DvYvHTc36Ond5F9UDFYWEBJ2LuGubd7fIUTyu9cghSRaElVReEmWV6mk=
X-Google-Smtp-Source: AGHT+IHuieqrpRyIukG/VEnttGfvSHdqGhO5irKuLfa2q2wUDQRcGi7wzi32OEi0s/mufYleXH1iaNKMZySFeuuqRToAIlY8Itx2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:258f:b0:3d6:d162:be54 with SMTP id
 e9e14a558f8ab-3da73930313mr12427765ab.14.1746579085492; Tue, 06 May 2025
 17:51:25 -0700 (PDT)
Date: Tue, 06 May 2025 17:51:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <681aae8d.050a0220.a19a9.0018.GAE@google.com>
Subject: [syzbot] [bluetooth?] INFO: task hung in hci_remote_features_evt (2)
From: syzbot <syzbot+547f5c9fd46cba52fbbf@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    ebd297a2affa Merge tag 'net-6.15-rc5' of git://git.kernel...
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=14ec539b980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a9a25b7a36123454
dashboard link: https://syzkaller.appspot.com/bug?extid=547f5c9fd46cba52fbbf
compiler:       Debian clang version 20.1.2 (++20250402124445+58df0ef89dd6-1~exp1~20250402004600.97), Debian LLD 20.1.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=126ebf74580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f47c8f69bf24/disk-ebd297a2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/34c92acc0f27/vmlinux-ebd297a2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4c13962a94ad/bzImage-ebd297a2.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+547f5c9fd46cba52fbbf@syzkaller.appspotmail.com

INFO: task kworker/u9:1:5138 blocked for more than 143 seconds.
      Not tainted 6.15.0-rc4-syzkaller-00147-gebd297a2affa #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u9:1    state:D stack:25808 pid:5138  tgid:5138  ppid:2      task_flags:0x4208060 flags:0x00004000
Workqueue: hci1 hci_rx_work

Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5382 [inline]
 __schedule+0x16e2/0x4cd0 kernel/sched/core.c:6767
 __schedule_loop kernel/sched/core.c:6845 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6860
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6917
 __mutex_lock_common kernel/locking/mutex.c:678 [inline]
 __mutex_lock+0x724/0xe80 kernel/locking/mutex.c:746
 hci_connect_cfm include/net/bluetooth/hci_core.h:2049 [inline]
 hci_remote_features_evt+0x516/0x8e0 net/bluetooth/hci_event.c:3736
 hci_event_func net/bluetooth/hci_event.c:7486 [inline]
 hci_event_packet+0x7fb/0x1270 net/bluetooth/hci_event.c:7538
 hci_rx_work+0x46a/0xe80 net/bluetooth/hci_core.c:4020
 process_one_work kernel/workqueue.c:3238 [inline]
 process_scheduled_works+0xadb/0x17a0 kernel/workqueue.c:3319
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3400
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:153
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
INFO: task syz-executor:5939 blocked for more than 144 seconds.
      Not tainted 6.15.0-rc4-syzkaller-00147-gebd297a2affa #0
      Blocked by coredump.
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D
 stack:21192 pid:5939  tgid:5939  ppid:1      task_flags:0x40054c flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5382 [inline]
 __schedule+0x16e2/0x4cd0 kernel/sched/core.c:6767
 __schedule_loop kernel/sched/core.c:6845 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6860
 schedule_timeout+0x9a/0x270 kernel/time/sleep_timeout.c:75
 do_wait_for_common kernel/sched/completion.c:95 [inline]
 __wait_for_common kernel/sched/completion.c:116 [inline]
 wait_for_common kernel/sched/completion.c:127 [inline]
 wait_for_completion+0x2bf/0x5d0 kernel/sched/completion.c:148
 __flush_work+0x9b9/0xbc0 kernel/workqueue.c:4244
 __cancel_work_sync+0xbe/0x110 kernel/workqueue.c:4364
 hidp_session_remove+0x62/0x260 net/bluetooth/hidp/core.c:1169
 l2cap_unregister_all_users net/bluetooth/l2cap_core.c:1747 [inline]
 l2cap_conn_del+0x23a/0x680 net/bluetooth/l2cap_core.c:1776
 hci_disconn_cfm include/net/bluetooth/hci_core.h:2067 [inline]
 hci_conn_hash_flush+0x10a/0x230 net/bluetooth/hci_conn.c:2534
 hci_dev_close_sync+0xaef/0x1330 net/bluetooth/hci_sync.c:5225
 hci_dev_do_close net/bluetooth/hci_core.c:483 [inline]
 hci_unregister_dev+0x206/0x500 net/bluetooth/hci_core.c:2678
 vhci_release+0x80/0xd0 drivers/bluetooth/hci_vhci.c:665
 __fput+0x449/0xa70 fs/file_table.c:465
 task_work_run+0x1d1/0x260 kernel/task_work.c:227
 exit_task_work include/linux/task_work.h:40 [inline]
 do_exit+0x8d6/0x2550 kernel/exit.c:953
 do_group_exit+0x21c/0x2d0 kernel/exit.c:1102
 get_signal+0x125e/0x1310 kernel/signal.c:3034
 arch_do_signal_or_restart+0x95/0x780 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x8b/0x120 kernel/entry/common.c:218
 do_syscall_64+0x103/0x210 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa39118d5ca
RSP: 002b:00007ffebcef3640 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 0000000000000003 RCX: 00007fa39118d5ca
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 00007ffebcef369c R08: 00007ffebcef2f9c R09: 00007ffebcef33a7
R10: 00007ffebcef3020 R11: 0000000000000293 R12: 0000000000000258
R13: 00000000000927c0 R14: 0000000000044f5f R15: 00007ffebcef36f0
 </TASK>
INFO: task khidpd_699e5505:5983 blocked for more than 145 seconds.
      Not tainted 6.15.0-rc4-syzkaller-00147-gebd297a2affa #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:khidpd_699e5505 state:D stack:29576 pid:5983  tgid:5983  ppid:2      task_flags:0x208040 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5382 [inline]
 __schedule+0x16e2/0x4cd0 kernel/sched/core.c:6767
 __schedule_loop kernel/sched/core.c:6845 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6860
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6917
 __mutex_lock_common kernel/locking/mutex.c:678 [inline]
 __mutex_lock+0x724/0xe80 kernel/locking/mutex.c:746
 l2cap_unregister_user+0x6a/0x1b0 net/bluetooth/l2cap_core.c:1727
 hidp_session_thread+0x3c9/0x410 net/bluetooth/hidp/core.c:1304
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:153
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
INFO: task syz.0.616:6598 blocked for more than 145 seconds.
      Not tainted 6.15.0-rc4-syzkaller-00147-gebd297a2affa #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.0.616       state:D
 stack:27288 pid:6598  tgid:6598  ppid:6585   task_flags:0x400140 flags:0x00000004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5382 [inline]
 __schedule+0x16e2/0x4cd0 kernel/sched/core.c:6767
 __schedule_loop kernel/sched/core.c:6845 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6860
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6917
 __mutex_lock_common kernel/locking/mutex.c:678 [inline]
 __mutex_lock+0x724/0xe80 kernel/locking/mutex.c:746
 l2cap_chan_connect+0x102/0xe30 net/bluetooth/l2cap_core.c:6955
 l2cap_sock_connect+0x5c5/0x7a0 net/bluetooth/l2cap_sock.c:256
 __sys_connect_file net/socket.c:2038 [inline]
 __sys_connect+0x313/0x440 net/socket.c:2057
 __do_sys_connect net/socket.c:2063 [inline]
 __se_sys_connect net/socket.c:2060 [inline]
 __x64_sys_connect+0x7a/0x90 net/socket.c:2060
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf6/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fcdca38e969
RSP: 002b:00007ffc640a4188 EFLAGS: 00000246
 ORIG_RAX: 000000000000002a
RAX: ffffffffffffffda RBX: 00007fcdca5b5fa0 RCX: 00007fcdca38e969
RDX: 000000000000000e RSI: 0000200000000100 RDI: 0000000000000005
RBP: 00007fcdca410ab1 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fcdca5b5fa0 R14: 00007fcdca5b5fa0 R15: 0000000000000003
 </TASK>

Showing all locks held in the system:
8 locks held by kworker/0:0/9:
1 lock held by khungtaskd/32:
 #0: ffffffff8df3b860 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #0: ffffffff8df3b860 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
 #0: ffffffff8df3b860 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x2e/0x180 kernel/locking/lockdep.c:6764
4 locks held by kworker/u9:0/56:
 #0: ffff88807b843948 ((wq_completion)hci8#2){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3213 [inline]
 #0: ffff88807b843948 ((wq_completion)hci8#2){+.+.}-{0:0}, at: process_scheduled_works+0x9b1/0x17a0 kernel/workqueue.c:3319
 #1: 
ffffc9000122fc60
 (
(work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3214 [inline]
(work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0x9ec/0x17a0 kernel/workqueue.c:3319
 #2: ffff88806f800078 (&hdev->lock){+.+.}-{4:4}, at: hci_remote_features_evt+0x9b/0x8e0 net/bluetooth/hci_event.c:3702
 #3: ffffffff8f45a448 (hci_cb_list_lock){+.+.}-{4:4}, at: hci_connect_cfm include/net/bluetooth/hci_core.h:2049 [inline]
 #3: ffffffff8f45a448 (hci_cb_list_lock){+.+.}-{4:4}, at: hci_remote_features_evt+0x516/0x8e0 net/bluetooth/hci_event.c:3736
4 locks held by kworker/u9:1/5138:
 #0: ffff88807b8de148 ((wq_completion)hci1#2){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3213 [inline]
 #0: ffff88807b8de148 ((wq_completion)hci1#2){+.+.}-{0:0}, at: process_scheduled_works+0x9b1/0x17a0 kernel/workqueue.c:3319
 #1: ffffc9000e5d7c60 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3214 [inline]
 #1: ffffc9000e5d7c60 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0x9ec/0x17a0 kernel/workqueue.c:3319
 #2: ffff88802ff5c078
 (
&hdev->lock
){+.+.}-{4:4}
, at: hci_remote_features_evt+0x9b/0x8e0 net/bluetooth/hci_event.c:3702
 #3: 
ffffffff8f45a448
 (
hci_cb_list_lock
){+.+.}-{4:4}
, at: hci_connect_cfm include/net/bluetooth/hci_core.h:2049 [inline]
, at: hci_remote_features_evt+0x516/0x8e0 net/bluetooth/hci_event.c:3736
2 locks held by getty/5583:
 #0: ffff8880342fa0a0 (&tty->ldisc_sem
){++++}-{0:0}
, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: 
ffffc90002ffe2f0
 (
&ldata->atomic_read_lock
){+.+.}-{4:4}, at: n_tty_read+0x43e/0x1400 drivers/tty/n_tty.c:2222
4 locks held by kworker/u9:2/5884:
 #0: ffff88807f519948 ((wq_completion)hci2#2){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3213 [inline]
 #0: ffff88807f519948 ((wq_completion)hci2#2){+.+.}-{0:0}, at: process_scheduled_works+0x9b1/0x17a0 kernel/workqueue.c:3319
 #1: ffffc900042dfc60 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3214 [inline]
 #1: ffffc900042dfc60 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0x9ec/0x17a0 kernel/workqueue.c:3319
 #2: ffff8880767e8078 (&hdev->lock){+.+.}-{4:4}, at: hci_remote_features_evt+0x9b/0x8e0 net/bluetooth/hci_event.c:3702
 #3: ffffffff8f45a448 (hci_cb_list_lock){+.+.}-{4:4}, at: hci_connect_cfm include/net/bluetooth/hci_core.h:2049 [inline]
 #3: ffffffff8f45a448 (hci_cb_list_lock){+.+.}-{4:4}, at: hci_remote_features_evt+0x516/0x8e0 net/bluetooth/hci_event.c:3736
5 locks held by syz-executor/5939:
 #0: 
ffff88807b378d80
 (
&hdev->req_lock){+.+.}-{4:4}, at: hci_dev_do_close net/bluetooth/hci_core.c:481 [inline]
&hdev->req_lock){+.+.}-{4:4}, at: hci_unregister_dev+0x1fe/0x500 net/bluetooth/hci_core.c:2678
 #1: ffff88807b378078 (&hdev->lock){+.+.}-{4:4}
, at: hci_dev_close_sync+0x66a/0x1330 net/bluetooth/hci_sync.c:5213
 #2: 
ffffffff8f45a448
 (
hci_cb_list_lock
){+.+.}-{4:4}
, at: hci_disconn_cfm include/net/bluetooth/hci_core.h:2064 [inline]
, at: hci_conn_hash_flush+0xa1/0x230 net/bluetooth/hci_conn.c:2534
 #3: 
ffff88807ba5ab38
 (
&conn->lock
#2
){+.+.}-{4:4}
, at: l2cap_conn_del+0x70/0x680 net/bluetooth/l2cap_core.c:1761
 #4: 
ffffffff8f483070
 (
hidp_session_sem
){++++}-{4:4}
, at: hidp_session_remove+0x2c/0x260 net/bluetooth/hidp/core.c:1165
1 lock held by khidpd_699e5505/5983:
 #0: 
ffff88807b378078
 (
&hdev->lock
){+.+.}-{4:4}, at: l2cap_unregister_user+0x6a/0x1b0 net/bluetooth/l2cap_core.c:1727
1 lock held by syz.0.616/6598:
 #0: ffff88802ff5c078 (&hdev->lock){+.+.}-{4:4}, at: l2cap_chan_connect+0x102/0xe30 net/bluetooth/l2cap_core.c:6955
4 locks held by kworker/u9:3/6603:
 #0: ffff88807d86f948 ((wq_completion)hci3#2){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3213 [inline]
 #0: ffff88807d86f948 ((wq_completion)hci3#2){+.+.}-{0:0}, at: process_scheduled_works+0x9b1/0x17a0 kernel/workqueue.c:3319
 #1: ffffc90003357c60 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}
, at: process_one_work kernel/workqueue.c:3214 [inline]
, at: process_scheduled_works+0x9ec/0x17a0 kernel/workqueue.c:3319
 #2: 
ffff88806cdb8078
 (
&hdev->lock
){+.+.}-{4:4}
, at: hci_remote_features_evt+0x9b/0x8e0 net/bluetooth/hci_event.c:3702
 #3: 
ffffffff8f45a448
 (
hci_cb_list_lock
){+.+.}-{4:4}
, at: hci_connect_cfm include/net/bluetooth/hci_core.h:2049 [inline]
, at: hci_remote_features_evt+0x516/0x8e0 net/bluetooth/hci_event.c:3736
1 lock held by syz.1.617/6615:
 #0: 
ffff8880767e8078
 (
&hdev->lock
){+.+.}-{4:4}
, at: l2cap_chan_connect+0x102/0xe30 net/bluetooth/l2cap_core.c:6955
4 locks held by kworker/u9:4/6620:
 #0: 
ffff88802f890948
 ((wq_completion)hci4#2){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3213 [inline]
 ((wq_completion)hci4#2){+.+.}-{0:0}, at: process_scheduled_works+0x9b1/0x17a0 kernel/workqueue.c:3319
 #1: 
ffffc900033f7c60
 (
(work_completion)(&hdev->rx_work)
){+.+.}-{0:0}
, at: process_one_work kernel/workqueue.c:3214 [inline]
, at: process_scheduled_works+0x9ec/0x17a0 kernel/workqueue.c:3319
 #2: 
ffff88806c944078
 (
&hdev->lock
){+.+.}-{4:4}
, at: hci_remote_features_evt+0x9b/0x8e0 net/bluetooth/hci_event.c:3702
 #3: 
ffffffff8f45a448
 (
hci_cb_list_lock
){+.+.}-{4:4}, at: hci_connect_cfm include/net/bluetooth/hci_core.h:2049 [inline]
){+.+.}-{4:4}, at: hci_remote_features_evt+0x516/0x8e0 net/bluetooth/hci_event.c:3736
1 lock held by syz.2.618/6631:
 #0: ffff88806cdb8078 (&hdev->lock){+.+.}-{4:4}, at: l2cap_chan_connect+0x102/0xe30 net/bluetooth/l2cap_core.c:6955
4 locks held by kworker/u9:5/6635:
 #0: ffff88806117f148 ((wq_completion)hci5#2){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3213 [inline]
 #0: ffff88806117f148 ((wq_completion)hci5#2){+.+.}-{0:0}, at: process_scheduled_works+0x9b1/0x17a0 kernel/workqueue.c:3319
 #1: 
ffffc900042bfc60
 (
(work_completion)(&hdev->rx_work)
){+.+.}-{0:0}
, at: process_one_work kernel/workqueue.c:3214 [inline]
, at: process_scheduled_works+0x9ec/0x17a0 kernel/workqueue.c:3319
 #2: 
ffff888024344078
 (
&hdev->lock){+.+.}-{4:4}, at: hci_remote_features_evt+0x9b/0x8e0 net/bluetooth/hci_event.c:3702
 #3: 
ffffffff8f45a448
 (
hci_cb_list_lock
){+.+.}-{4:4}
, at: hci_connect_cfm include/net/bluetooth/hci_core.h:2049 [inline]
, at: hci_remote_features_evt+0x516/0x8e0 net/bluetooth/hci_event.c:3736
1 lock held by syz.3.619/6648:
 #0: 
ffff88806c944078
 (
&hdev->lock
){+.+.}-{4:4}
, at: l2cap_chan_connect+0x102/0xe30 net/bluetooth/l2cap_core.c:6955
1 lock held by syz.4.620/6670:
 #0: 
ffff888024344078
 (&hdev->lock){+.+.}-{4:4}, at: l2cap_chan_connect+0x102/0xe30 net/bluetooth/l2cap_core.c:6955
4 locks held by kworker/u9:7/6674:
 #0: ffff88807768d148 ((wq_completion)hci6#2){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3213 [inline]
 #0: ffff88807768d148 ((wq_completion)hci6#2){+.+.}-{0:0}, at: process_scheduled_works+0x9b1/0x17a0 kernel/workqueue.c:3319
 #1: ffffc90002ed7c60
 (
(work_completion)(&hdev->rx_work)
){+.+.}-{0:0}
, at: process_one_work kernel/workqueue.c:3214 [inline]
, at: process_scheduled_works+0x9ec/0x17a0 kernel/workqueue.c:3319
 #2: 
ffff88807bef8078
 (
&hdev->lock
){+.+.}-{4:4}
, at: hci_remote_features_evt+0x9b/0x8e0 net/bluetooth/hci_event.c:3702
 #3: 
ffffffff8f45a448 (hci_cb_list_lock){+.+.}-{4:4}, at: hci_connect_cfm include/net/bluetooth/hci_core.h:2049 [inline]
ffffffff8f45a448 (hci_cb_list_lock){+.+.}-{4:4}, at: hci_remote_features_evt+0x516/0x8e0 net/bluetooth/hci_event.c:3736
1 lock held by syz.5.621/6692:
 #0: ffff88807bef8078 (&hdev->lock){+.+.}-{4:4}, at: l2cap_chan_connect+0x102/0xe30 net/bluetooth/l2cap_core.c:6955
4 locks held by kworker/u9:8/6702:
 #0: ffff888032e8e148 ((wq_completion)hci7#2){+.+.}-{0:0}
, at: process_one_work kernel/workqueue.c:3213 [inline]
, at: process_scheduled_works+0x9b1/0x17a0 kernel/workqueue.c:3319
 #1: ffffc9000d097c60 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}
, at: process_one_work kernel/workqueue.c:3214 [inline]
, at: process_scheduled_works+0x9ec/0x17a0 kernel/workqueue.c:3319
 #2: ffff888026bd4078 (&hdev->lock){+.+.}-{4:4}, at: hci_remote_features_evt+0x9b/0x8e0 net/bluetooth/hci_event.c:3702
 #3: 
ffffffff8f45a448
 (
hci_cb_list_lock
){+.+.}-{4:4}
, at: hci_connect_cfm include/net/bluetooth/hci_core.h:2049 [inline]
, at: hci_remote_features_evt+0x516/0x8e0 net/bluetooth/hci_event.c:3736
1 lock held by syz.6.622/6721:
 #0: ffff888026bd4078
 (
&hdev->lock
){+.+.}-{4:4}
, at: l2cap_chan_connect+0x102/0xe30 net/bluetooth/l2cap_core.c:6955
4 locks held by kworker/u9:9/6724:
 #0: 
ffff888011644948
 (
(wq_completion)hci9
#2
){+.+.}-{0:0}
, at: process_one_work kernel/workqueue.c:3213 [inline]
, at: process_scheduled_works+0x9b1/0x17a0 kernel/workqueue.c:3319
 #1: 
ffffc9000d107c60
 (
(work_completion)(&hdev->rx_work)
){+.+.}-{0:0}
, at: process_one_work kernel/workqueue.c:3214 [inline]
, at: process_scheduled_works+0x9ec/0x17a0 kernel/workqueue.c:3319
 #2: 
ffff88807befc078
 (
&hdev->lock
){+.+.}-{4:4}
, at: hci_remote_features_evt+0x9b/0x8e0 net/bluetooth/hci_event.c:3702
 #3: 
ffffffff8f45a448
 (
hci_cb_list_lock
){+.+.}-{4:4}
, at: hci_connect_cfm include/net/bluetooth/hci_core.h:2049 [inline]
, at: hci_remote_features_evt+0x516/0x8e0 net/bluetooth/hci_event.c:3736
1 lock held by syz.7.623/6743:
 #0: 
ffff88806f800078
 (
&hdev->lock
){+.+.}-{4:4}
, at: l2cap_chan_connect+0x102/0xe30 net/bluetooth/l2cap_core.c:6955
2 locks held by kworker/u8:2/6744:
 #0: ffff8880b8939b58 (
&rq->__lock
){-.-.}-{2:2}
, at: raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:605
 #1: 
ffff8880b8923b08
 (
&per_cpu_ptr(group->pcpu, cpu)->seq
){-.-.}-{0:0}
, at: psi_task_switch+0x39e/0x6d0 kernel/sched/psi.c:987
3 locks held by syz-executor/6746:
 #0: ffffffff8ea8dfe0 (&ops->srcu#2){.+.+}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #0: ffffffff8ea8dfe0 (&ops->srcu#2){.+.+}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
 #0: ffffffff8ea8dfe0 (&ops->srcu#2){.+.+}-{0:0}, at: rtnl_link_ops_get+0x23/0x250 net/core/rtnetlink.c:570
 #1: ffffffff8f2f4248 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_lock net/core/rtnetlink.c:80 [inline]
 #1: ffffffff8f2f4248 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_nets_lock net/core/rtnetlink.c:341 [inline]
 #1: ffffffff8f2f4248 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_newlink+0x8db/0x1c70 net/core/rtnetlink.c:4064
 #2: ffffffff8df41338 (rcu_state.exp_mutex){+.+.}-{4:4}, at: exp_funnel_lock kernel/rcu/tree_exp.h:304 [inline]
 #2: ffffffff8df41338 (rcu_state.exp_mutex){+.+.}-{4:4}, at: synchronize_rcu_expedited+0x2f4/0x730 kernel/rcu/tree_exp.h:998

=============================================

NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 32 Comm: khungtaskd Not tainted 6.15.0-rc4-syzkaller-00147-gebd297a2affa #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/19/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120


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

