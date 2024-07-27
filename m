Return-Path: <netdev+bounces-113338-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BAF993DD7D
	for <lists+netdev@lfdr.de>; Sat, 27 Jul 2024 08:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9815B1C228D1
	for <lists+netdev@lfdr.de>; Sat, 27 Jul 2024 06:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028C31BF37;
	Sat, 27 Jul 2024 06:21:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1341864C
	for <netdev@vger.kernel.org>; Sat, 27 Jul 2024 06:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722061296; cv=none; b=FhxS/KBb4dHORhJR+8lTlxa7a1Yyj0deZT4kSJZDC4428zApuUuvp7CGjopiYJkfT63OUftGF0tdARWA2XKP/MMCx4t7YrIzXNtSywY302IrVsMM6tV4++wT3SWde3Bp05WM14MeOuY/kme636hiuq6Gxuw2VBOsWsLMOicqYns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722061296; c=relaxed/simple;
	bh=uuvrHWgl8y/xhNiUDDgoG6HCnJJLgrnWnJwDxqvH1ME=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=E79mv/2DU92+xaEl2rnfjyMwn8h7qysst2kFzdjenOsYXttvxyiJpcjbhHgb28cM8SmfA4qA6uCH4iNglPFah7IpBCWijqj7XGPoqx6JE3LUw25vMoRFEFeNMhQqwpYHJWRlWQ4bhoIiC0fSOH5rO3BbhBxYzP1tiAJk7BZGTUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-37642e69d7eso31660175ab.3
        for <netdev@vger.kernel.org>; Fri, 26 Jul 2024 23:21:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722061293; x=1722666093;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X7RsyS3VHyBCFMsky3QWGsBqiLCeRQRryyYO50mYw8Y=;
        b=iSwsnlruPBn8GGsWthToRn2bLHzs0dcRj950Y9aFryM8eM995n2/FVkONSCBYjhALq
         fwmvaaSj6TIuW5U7dGjKy3xGFMdqi801EKUdcR14lcNbXjwmJGMfYk8vMztPD+XABFcK
         oVGLG5zgYg+pGMFTkFTyaFmbqGVe318msKX3CPy+VTLhGjTD2I1Dn2O6WEEgvwdhc31M
         TtNbYUOPlXbea54zXZR7jeCIBXGJnx8KykOkf5RjV+MjOWtJ6hGM6AlsBhOiR0k64VE0
         6dcsBGWrydjYQaa/aTCbWhQDZyI2g17GaCs44PINqrnCuVlbGmujADci+NEDtL5EQ1aZ
         a8Zw==
X-Forwarded-Encrypted: i=1; AJvYcCWtEplYRYftrWYxM66nu3V1pveJ3uSinpHYgNsBc1+OE6lSWrmsLmhg498+ApgbOh/3UOkr2lZPE/7LYrmMGFjQCIwGpf0n
X-Gm-Message-State: AOJu0YyCMteBWJz8x6g7Fcxi58R7CR8Aca3db65Jn+0zpyGxtQ2Kk/Xe
	oZ2UEgGNt0bUtRFTbOI6+tcdCKiGNG0GxszaX8TE18J4qqT6/AxohgCa1/NFRUFx+rj7DCV4xni
	U7H6vlp5U9+pJX7ShElVbERJcy/wQFMgSXSS7rUbUsr++8kJbIfWANLA=
X-Google-Smtp-Source: AGHT+IFo+TdTEPPug3P+1OsMmCZog368k3M9W1bDMfh8PpH7FAbwe6MQFMUP/RSCWGxJqGdyWtkwf4WS7cq3zYz8vTdloY0UV7Om
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c245:0:b0:381:24e:7a8c with SMTP id
 e9e14a558f8ab-39aec2ca2bemr1398415ab.1.1722061293545; Fri, 26 Jul 2024
 23:21:33 -0700 (PDT)
Date: Fri, 26 Jul 2024 23:21:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000aefb4d061e34a346@google.com>
Subject: [syzbot] [net?] INFO: task hung in linkwatch_event (4)
From: syzbot <syzbot+2ba2d70f288cf61174e4@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    786c8248dbd3 Merge tag 'perf-tools-fixes-for-v6.11-2024-07..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17af5455980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=47beaba1a1054668
dashboard link: https://syzkaller.appspot.com/bug?extid=2ba2d70f288cf61174e4
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e4bf4a8f547d/disk-786c8248.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9b69a5fd8929/vmlinux-786c8248.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e0060dfb7885/bzImage-786c8248.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2ba2d70f288cf61174e4@syzkaller.appspotmail.com

INFO: task kworker/1:1:50 blocked for more than 143 seconds.
      Not tainted 6.10.0-syzkaller-12246-g786c8248dbd3 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/1:1     state:D stack:23120 pid:50    tgid:50    ppid:2      flags:0x00004000
Workqueue: events linkwatch_event
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5188 [inline]
 __schedule+0xe37/0x5490 kernel/sched/core.c:6529
 __schedule_loop kernel/sched/core.c:6606 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6621
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6678
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x5b8/0x9c0 kernel/locking/mutex.c:752
 linkwatch_event+0x51/0xc0 net/core/link_watch.c:276
 process_one_work+0x9c5/0x1b40 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xf20 kernel/workqueue.c:3390
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
INFO: task kworker/u8:8:2831 blocked for more than 144 seconds.
      Not tainted 6.10.0-syzkaller-12246-g786c8248dbd3 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u8:8    state:D stack:23440 pid:2831  tgid:2831  ppid:2      flags:0x00004000
Workqueue: events_unbound fsnotify_connector_destroy_workfn
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5188 [inline]
 __schedule+0xe37/0x5490 kernel/sched/core.c:6529
 __schedule_loop kernel/sched/core.c:6606 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6621
 schedule_timeout+0x258/0x2a0 kernel/time/timer.c:2557
 do_wait_for_common kernel/sched/completion.c:95 [inline]
 __wait_for_common+0x3de/0x5f0 kernel/sched/completion.c:116
 __synchronize_srcu+0x1bd/0x2a0 kernel/rcu/srcutree.c:1398
 fsnotify_connector_destroy_workfn+0x4d/0xa0 fs/notify/mark.c:308
 process_one_work+0x9c5/0x1b40 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xf20 kernel/workqueue.c:3390
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
INFO: task kworker/u8:9:4201 blocked for more than 144 seconds.
      Not tainted 6.10.0-syzkaller-12246-g786c8248dbd3 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u8:9    state:D stack:23264 pid:4201  tgid:4201  ppid:2      flags:0x00004000
Workqueue: events_unbound fsnotify_mark_destroy_workfn
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5188 [inline]
 __schedule+0xe37/0x5490 kernel/sched/core.c:6529
 __schedule_loop kernel/sched/core.c:6606 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6621
 schedule_timeout+0x258/0x2a0 kernel/time/timer.c:2557
 do_wait_for_common kernel/sched/completion.c:95 [inline]
 __wait_for_common+0x3de/0x5f0 kernel/sched/completion.c:116
 __synchronize_srcu+0x1bd/0x2a0 kernel/rcu/srcutree.c:1398
 fsnotify_mark_destroy_workfn+0x113/0x360 fs/notify/mark.c:978
 process_one_work+0x9c5/0x1b40 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xf20 kernel/workqueue.c:3390
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
INFO: task kworker/u8:12:5334 blocked for more than 145 seconds.
      Not tainted 6.10.0-syzkaller-12246-g786c8248dbd3 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u8:12   state:D stack:24000 pid:5334  tgid:5334  ppid:2      flags:0x00004000
Workqueue: ipv6_addrconf addrconf_verify_work
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5188 [inline]
 __schedule+0xe37/0x5490 kernel/sched/core.c:6529
 __schedule_loop kernel/sched/core.c:6606 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6621
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6678
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x5b8/0x9c0 kernel/locking/mutex.c:752
 addrconf_verify_work+0x12/0x30 net/ipv6/addrconf.c:4734
 process_one_work+0x9c5/0x1b40 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xf20 kernel/workqueue.c:3390
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
INFO: task syz-executor:6300 blocked for more than 145 seconds.
      Not tainted 6.10.0-syzkaller-12246-g786c8248dbd3 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:24272 pid:6300  tgid:6300  ppid:1      flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5188 [inline]
 __schedule+0xe37/0x5490 kernel/sched/core.c:6529
 __schedule_loop kernel/sched/core.c:6606 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6621
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6678
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x5b8/0x9c0 kernel/locking/mutex.c:752
 tun_detach drivers/net/tun.c:698 [inline]
 tun_chr_close+0x3e/0x250 drivers/net/tun.c:3507
 __fput+0x408/0xbb0 fs/file_table.c:422
 task_work_run+0x14e/0x250 kernel/task_work.c:222
 exit_task_work include/linux/task_work.h:40 [inline]
 do_exit+0xaa3/0x2bb0 kernel/exit.c:882
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1031
 get_signal+0x25fd/0x2770 kernel/signal.c:2917
 arch_do_signal_or_restart+0x90/0x7e0 arch/x86/kernel/signal.c:310
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x150/0x2a0 kernel/entry/common.c:218
 do_syscall_64+0xda/0x250 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa988f6c217
RSP: 002b:00007ffd5cfac690 EFLAGS: 00000293 ORIG_RAX: 000000000000003d
RAX: fffffffffffffe00 RBX: 00000000000000d4 RCX: 00007fa988f6c217
RDX: 0000000040000000 RSI: 00007ffd5cfac70c RDI: 00000000ffffffff
RBP: 00007ffd5cfac70c R08: 0000000000000000 R09: 00007fa989d77080
R10: 0000000000000000 R11: 0000000000000293 R12: 00007ffd5cfac780
R13: 00005555558955eb R14: 0000555555895590 R15: 00000000000713e0
 </TASK>
INFO: task syz-executor:6764 blocked for more than 146 seconds.
      Not tainted 6.10.0-syzkaller-12246-g786c8248dbd3 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:23744 pid:6764  tgid:6764  ppid:1      flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5188 [inline]
 __schedule+0xe37/0x5490 kernel/sched/core.c:6529
 __schedule_loop kernel/sched/core.c:6606 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6621
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6678
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x5b8/0x9c0 kernel/locking/mutex.c:752
 tun_detach drivers/net/tun.c:698 [inline]
 tun_chr_close+0x3e/0x250 drivers/net/tun.c:3507
 __fput+0x408/0xbb0 fs/file_table.c:422
 task_work_run+0x14e/0x250 kernel/task_work.c:222
 exit_task_work include/linux/task_work.h:40 [inline]
 do_exit+0xaa3/0x2bb0 kernel/exit.c:882
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1031
 get_signal+0x25fd/0x2770 kernel/signal.c:2917
 arch_do_signal_or_restart+0x90/0x7e0 arch/x86/kernel/signal.c:310
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x150/0x2a0 kernel/entry/common.c:218
 do_syscall_64+0xda/0x250 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f942556c217
RSP: 002b:00007ffdda9daac0 EFLAGS: 00000293 ORIG_RAX: 000000000000003d
RAX: fffffffffffffe00 RBX: 000000000000009e RCX: 00007f942556c217
RDX: 0000000040000000 RSI: 00007ffdda9dab3c RDI: 00000000ffffffff
RBP: 00007ffdda9dab3c R08: 0000000000000000 R09: 00007f94262c2080
R10: 0000000000000000 R11: 0000000000000293 R12: 00007ffdda9dabb0
R13: 000055558fc0f5eb R14: 000055558fc0f590 R15: 00000000000712f9
 </TASK>
INFO: task syz.3.519:7745 blocked for more than 146 seconds.
      Not tainted 6.10.0-syzkaller-12246-g786c8248dbd3 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.3.519       state:D stack:25072 pid:7745  tgid:7745  ppid:6300   flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5188 [inline]
 __schedule+0xe37/0x5490 kernel/sched/core.c:6529
 __schedule_loop kernel/sched/core.c:6606 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6621
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6678
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x5b8/0x9c0 kernel/locking/mutex.c:752
 tun_detach drivers/net/tun.c:698 [inline]
 tun_chr_close+0x3e/0x250 drivers/net/tun.c:3507
 __fput+0x408/0xbb0 fs/file_table.c:422
 task_work_run+0x14e/0x250 kernel/task_work.c:222
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x27b/0x2a0 kernel/entry/common.c:218
 do_syscall_64+0xda/0x250 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa988f75f19
RSP: 002b:00007ffd5cfac498 EFLAGS: 00000246 ORIG_RAX: 00000000000001b4
RAX: 0000000000000000 RBX: 00007fa989107a60 RCX: 00007fa988f75f19
RDX: 0000000000000000 RSI: 000000000000001e RDI: 0000000000000003
RBP: 00007fa989107a60 R08: 0000000000000006 R09: 0000001e5cfac7bf
R10: 00000000005d5988 R11: 0000000000000246 R12: 0000000000071726
R13: 0000000000000032 R14: 00007fa989107a60 R15: 00007fa989105f60
 </TASK>
INFO: task syz.0.521:7758 blocked for more than 147 seconds.
      Not tainted 6.10.0-syzkaller-12246-g786c8248dbd3 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.0.521       state:D stack:28384 pid:7758  tgid:7757  ppid:5589   flags:0x00000004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5188 [inline]
 __schedule+0xe37/0x5490 kernel/sched/core.c:6529
 __schedule_loop kernel/sched/core.c:6606 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6621
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6678
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x5b8/0x9c0 kernel/locking/mutex.c:752
 rtnl_lock net/core/rtnetlink.c:79 [inline]
 rtnetlink_rcv_msg+0x372/0xea0 net/core/rtnetlink.c:6644
 netlink_rcv_skb+0x16b/0x440 net/netlink/af_netlink.c:2550
 netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
 netlink_unicast+0x544/0x830 net/netlink/af_netlink.c:1357
 netlink_sendmsg+0x8b8/0xd70 net/netlink/af_netlink.c:1901
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg net/socket.c:745 [inline]
 ____sys_sendmsg+0xab5/0xc90 net/socket.c:2597
 ___sys_sendmsg+0x135/0x1e0 net/socket.c:2651
 __sys_sendmsg+0x117/0x1f0 net/socket.c:2680
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f9897f75f19
RSP: 002b:00007f9898d50048 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f9898105f60 RCX: 00007f9897f75f19
RDX: 0000000000000000 RSI: 0000000020000180 RDI: 0000000000000003
RBP: 00007f9897fe4e68 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f9898105f60 R15: 00007ffff5cc5098
 </TASK>
INFO: task syz-executor:7761 blocked for more than 148 seconds.
      Not tainted 6.10.0-syzkaller-12246-g786c8248dbd3 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:27552 pid:7761  tgid:7761  ppid:1      flags:0x00000004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5188 [inline]
 __schedule+0xe37/0x5490 kernel/sched/core.c:6529
 __schedule_loop kernel/sched/core.c:6606 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6621
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6678
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x5b8/0x9c0 kernel/locking/mutex.c:752
 rtnl_lock net/core/rtnetlink.c:79 [inline]
 rtnetlink_rcv_msg+0x372/0xea0 net/core/rtnetlink.c:6644
 netlink_rcv_skb+0x16b/0x440 net/netlink/af_netlink.c:2550
 netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
 netlink_unicast+0x544/0x830 net/netlink/af_netlink.c:1357
 netlink_sendmsg+0x8b8/0xd70 net/netlink/af_netlink.c:1901
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg net/socket.c:745 [inline]
 __sys_sendto+0x47f/0x4e0 net/socket.c:2204
 __do_sys_sendto net/socket.c:2216 [inline]
 __se_sys_sendto net/socket.c:2212 [inline]
 __x64_sys_sendto+0xe0/0x1c0 net/socket.c:2212
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f7491377cac
RSP: 002b:00007ffee4ac2ac0 EFLAGS: 00000293 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00007f7492034620 RCX: 00007f7491377cac
RDX: 0000000000000028 RSI: 00007f7492034670 RDI: 0000000000000003
RBP: 0000000000000000 R08: 00007ffee4ac2b14 R09: 000000000000000c
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000003
R13: 0000000000000000 R14: 00007f7492034670 R15: 0000000000000000
 </TASK>
INFO: task syz-executor:7765 blocked for more than 148 seconds.
      Not tainted 6.10.0-syzkaller-12246-g786c8248dbd3 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:27552 pid:7765  tgid:7765  ppid:1      flags:0x00000004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5188 [inline]
 __schedule+0xe37/0x5490 kernel/sched/core.c:6529
 __schedule_loop kernel/sched/core.c:6606 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6621
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6678
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x5b8/0x9c0 kernel/locking/mutex.c:752
 rtnl_lock net/core/rtnetlink.c:79 [inline]
 rtnetlink_rcv_msg+0x372/0xea0 net/core/rtnetlink.c:6644
 netlink_rcv_skb+0x16b/0x440 net/netlink/af_netlink.c:2550
 netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
 netlink_unicast+0x544/0x830 net/netlink/af_netlink.c:1357
 netlink_sendmsg+0x8b8/0xd70 net/netlink/af_netlink.c:1901
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg net/socket.c:745 [inline]
 __sys_sendto+0x47f/0x4e0 net/socket.c:2204
 __do_sys_sendto net/socket.c:2216 [inline]
 __se_sys_sendto net/socket.c:2212 [inline]
 __x64_sys_sendto+0xe0/0x1c0 net/socket.c:2212
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f195c177cac
RSP: 002b:00007ffc6aefe1f0 EFLAGS: 00000293 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00007f195ce34620 RCX: 00007f195c177cac
RDX: 0000000000000028 RSI: 00007f195ce34670 RDI: 0000000000000003
RBP: 0000000000000000 R08: 00007ffc6aefe244 R09: 000000000000000c
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000003
R13: 0000000000000000 R14: 00007f195ce34670 R15: 0000000000000000
 </TASK>
Future hung task reports are suppressed, see sysctl kernel.hung_task_warnings
INFO: task syz-executor:7768 blocked for more than 149 seconds.
      Not tainted 6.10.0-syzkaller-12246-g786c8248dbd3 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:27552 pid:7768  tgid:7768  ppid:1      flags:0x00000004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5188 [inline]
 __schedule+0xe37/0x5490 kernel/sched/core.c:6529
 __schedule_loop kernel/sched/core.c:6606 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6621
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6678
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x5b8/0x9c0 kernel/locking/mutex.c:752
 rtnl_lock net/core/rtnetlink.c:79 [inline]
 rtnetlink_rcv_msg+0x372/0xea0 net/core/rtnetlink.c:6644
 netlink_rcv_skb+0x16b/0x440 net/netlink/af_netlink.c:2550
 netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
 netlink_unicast+0x544/0x830 net/netlink/af_netlink.c:1357
 netlink_sendmsg+0x8b8/0xd70 net/netlink/af_netlink.c:1901
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg net/socket.c:745 [inline]
 __sys_sendto+0x47f/0x4e0 net/socket.c:2204
 __do_sys_sendto net/socket.c:2216 [inline]
 __se_sys_sendto net/socket.c:2212 [inline]
 __x64_sys_sendto+0xe0/0x1c0 net/socket.c:2212
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fef76b77cac
RSP: 002b:00007fffd06fcf70 EFLAGS: 00000293 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00007fef77834620 RCX: 00007fef76b77cac
RDX: 0000000000000028 RSI: 00007fef77834670 RDI: 0000000000000003
RBP: 0000000000000000 R08: 00007fffd06fcfc4 R09: 000000000000000c
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000003
R13: 0000000000000000 R14: 00007fef77834670 R15: 0000000000000000
 </TASK>
Future hung task reports are suppressed, see sysctl kernel.hung_task_warnings

Showing all locks held in the system:
1 lock held by khungtaskd/30:
 #0: ffffffff8dbb5220 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:326 [inline]
 #0: ffffffff8dbb5220 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:838 [inline]
 #0: ffffffff8dbb5220 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x75/0x340 kernel/locking/lockdep.c:6620
3 locks held by kworker/1:1/50:
 #0: ffff888015480948 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x1277/0x1b40 kernel/workqueue.c:3206
 #1: ffffc90000ba7d80 ((linkwatch_work).work){+.+.}-{0:0}, at: process_one_work+0x921/0x1b40 kernel/workqueue.c:3207
 #2: ffffffff8f7723a8 (rtnl_mutex){+.+.}-{3:3}, at: linkwatch_event+0x51/0xc0 net/core/link_watch.c:276
3 locks held by kworker/0:2/928:
2 locks held by kworker/u8:8/2831:
 #0: ffff888015489148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x1277/0x1b40 kernel/workqueue.c:3206
 #1: ffffc90009bffd80 (connector_reaper_work){+.+.}-{0:0}, at: process_one_work+0x921/0x1b40 kernel/workqueue.c:3207
2 locks held by kworker/u8:9/4201:
 #0: ffff888015489148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x1277/0x1b40 kernel/workqueue.c:3206
 #1: ffffc9000c73fd80 ((reaper_work).work){+.+.}-{0:0}, at: process_one_work+0x921/0x1b40 kernel/workqueue.c:3207
1 lock held by dhcpcd/4756:
 #0: ffffffff8f7723a8 (rtnl_mutex){+.+.}-{3:3}, at: devinet_ioctl+0x26e/0x1f10 net/ipv4/devinet.c:1101
2 locks held by getty/4851:
 #0: ffff88802ecb80a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x24/0x80 drivers/tty/tty_ldisc.c:243
 #1: ffffc9000311b2f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xfc8/0x1490 drivers/tty/n_tty.c:2211
5 locks held by kworker/0:3/5101:
3 locks held by kworker/1:4/5148:
 #0: ffff888015481948 ((wq_completion)events_power_efficient){+.+.}-{0:0}, at: process_one_work+0x1277/0x1b40 kernel/workqueue.c:3206
 #1: ffffc90003127d80 ((reg_check_chans).work){+.+.}-{0:0}, at: process_one_work+0x921/0x1b40 kernel/workqueue.c:3207
 #2: ffffffff8f7723a8 (rtnl_mutex){+.+.}-{3:3}, at: reg_check_chans_work+0x84/0x1140 net/wireless/reg.c:2480
2 locks held by kworker/0:4/5152:
4 locks held by kworker/u8:10/5331:
 #0: ffff8880162db148 ((wq_completion)netns){+.+.}-{0:0}, at: process_one_work+0x1277/0x1b40 kernel/workqueue.c:3206
 #1: ffffc90003da7d80 (net_cleanup_work){+.+.}-{0:0}, at: process_one_work+0x921/0x1b40 kernel/workqueue.c:3207
 #2: ffffffff8f75cc50 (pernet_ops_rwsem){++++}-{3:3}, at: cleanup_net+0xbb/0xbf0 net/core/net_namespace.c:594
 #3: ffffffff8f7723a8 (rtnl_mutex){+.+.}-{3:3}, at: ieee80211_unregister_hw+0x4d/0x3a0 net/mac80211/main.c:1662
3 locks held by kworker/u8:12/5334:
 #0: ffff8880292bf148 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_one_work+0x1277/0x1b40 kernel/workqueue.c:3206
 #1: ffffc900032afd80 ((work_completion)(&(&net->ipv6.addr_chk_work)->work)){+.+.}-{0:0}, at: process_one_work+0x921/0x1b40 kernel/workqueue.c:3207
 #2: ffffffff8f7723a8 (rtnl_mutex){+.+.}-{3:3}, at: addrconf_verify_work+0x12/0x30 net/ipv6/addrconf.c:4734
1 lock held by syz-executor/6300:
 #0: ffffffff8f7723a8 (rtnl_mutex){+.+.}-{3:3}, at: tun_detach drivers/net/tun.c:698 [inline]
 #0: ffffffff8f7723a8 (rtnl_mutex){+.+.}-{3:3}, at: tun_chr_close+0x3e/0x250 drivers/net/tun.c:3507
1 lock held by syz-executor/6764:
 #0: ffffffff8f7723a8 (rtnl_mutex){+.+.}-{3:3}, at: tun_detach drivers/net/tun.c:698 [inline]
 #0: ffffffff8f7723a8 (rtnl_mutex){+.+.}-{3:3}, at: tun_chr_close+0x3e/0x250 drivers/net/tun.c:3507
8 locks held by syz-executor/7699:
 #0: ffff88802ef18420 (sb_writers#9){.+.+}-{0:0}, at: ksys_write+0x12f/0x260 fs/read_write.c:643
 #1: ffff888018ab2488 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_write_iter+0x281/0x500 fs/kernfs/file.c:325
 #2: ffff888022a91e18 (kn->active#49){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x2a4/0x500 fs/kernfs/file.c:326
 #3: ffffffff8ed9c2e8 (nsim_bus_dev_list_lock){+.+.}-{3:3}, at: del_device_store+0xd2/0x4b0 drivers/net/netdevsim/bus.c:216
 #4: ffff88802b3820e8 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1009 [inline]
 #4: ffff88802b3820e8 (&dev->mutex){....}-{3:3}, at: __device_driver_lock drivers/base/dd.c:1093 [inline]
 #4: ffff88802b3820e8 (&dev->mutex){....}-{3:3}, at: device_release_driver_internal+0xa4/0x610 drivers/base/dd.c:1290
 #5: ffff888012116250 (&devlink->lock_key#7){+.+.}-{3:3}, at: nsim_drv_remove+0x4a/0x1d0 drivers/net/netdevsim/dev.c:1672
 #6: ffffffff8f7723a8 (rtnl_mutex){+.+.}-{3:3}, at: nsim_destroy+0x6f/0x6a0 drivers/net/netdevsim/netdev.c:773
 #7: ffffffff8da59230 (cpu_hotplug_lock){++++}-{0:0}, at: flush_all_backlogs net/core/dev.c:6021 [inline]
 #7: ffffffff8da59230 (cpu_hotplug_lock){++++}-{0:0}, at: unregister_netdevice_many_notify+0x53b/0x1e40 net/core/dev.c:11325
3 locks held by syz.1.518/7756:
1 lock held by syz.3.519/7745:
 #0: ffffffff8f7723a8 (rtnl_mutex){+.+.}-{3:3}, at: tun_detach drivers/net/tun.c:698 [inline]
 #0: ffffffff8f7723a8 (rtnl_mutex){+.+.}-{3:3}, at: tun_chr_close+0x3e/0x250 drivers/net/tun.c:3507
2 locks held by syz-executor/7752:
 #0: ffffffff8f75cc50 (pernet_ops_rwsem){++++}-{3:3}, at: copy_net_ns+0x2cb/0x670 net/core/net_namespace.c:504
 #1: ffffffff8f7723a8 (rtnl_mutex){+.+.}-{3:3}, at: register_nexthop_notifier+0x1b/0x70 net/ipv4/nexthop.c:3871
1 lock held by syz.0.521/7758:
 #0: ffffffff8f7723a8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8f7723a8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x372/0xea0 net/core/rtnetlink.c:6644
1 lock held by syz-executor/7761:
 #0: ffffffff8f7723a8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8f7723a8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x372/0xea0 net/core/rtnetlink.c:6644
1 lock held by syz-executor/7765:
 #0: ffffffff8f7723a8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8f7723a8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x372/0xea0 net/core/rtnetlink.c:6644
1 lock held by syz-executor/7768:
 #0: ffffffff8f7723a8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8f7723a8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x372/0xea0 net/core/rtnetlink.c:6644
1 lock held by syz-executor/7789:
 #0: ffffffff8f7723a8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8f7723a8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x372/0xea0 net/core/rtnetlink.c:6644
1 lock held by syz-executor/7795:
 #0: ffffffff8f7723a8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8f7723a8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x372/0xea0 net/core/rtnetlink.c:6644
1 lock held by syz-executor/7802:
 #0: ffffffff8f7723a8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8f7723a8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x372/0xea0 net/core/rtnetlink.c:6644
1 lock held by syz-executor/7803:
 #0: ffffffff8f7723a8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8f7723a8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x372/0xea0 net/core/rtnetlink.c:6644
1 lock held by syz-executor/7805:
 #0: ffffffff8f7723a8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8f7723a8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x372/0xea0 net/core/rtnetlink.c:6644
1 lock held by syz-executor/7815:
 #0: ffffffff8f7723a8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8f7723a8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x372/0xea0 net/core/rtnetlink.c:6644
1 lock held by syz-executor/7822:
 #0: ffffffff8f7723a8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8f7723a8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x372/0xea0 net/core/rtnetlink.c:6644
1 lock held by syz-executor/7830:
 #0: ffffffff8f7723a8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8f7723a8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x372/0xea0 net/core/rtnetlink.c:6644
1 lock held by syz-executor/7834:
 #0: ffffffff8f7723a8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8f7723a8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x372/0xea0 net/core/rtnetlink.c:6644
1 lock held by syz-executor/7837:
 #0: ffffffff8f7723a8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8f7723a8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x372/0xea0 net/core/rtnetlink.c:6644

=============================================

NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 30 Comm: khungtaskd Not tainted 6.10.0-syzkaller-12246-g786c8248dbd3 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:119
 nmi_cpu_backtrace+0x27b/0x390 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x29c/0x300 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:162 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:223 [inline]
 watchdog+0xf4e/0x1280 kernel/hung_task.c:379
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 7756 Comm: syz.1.518 Not tainted 6.10.0-syzkaller-12246-g786c8248dbd3 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
RIP: 0010:__sanitizer_cov_trace_pc+0x0/0x60 kernel/kcov.c:200
Code: be b0 01 00 00 e8 a0 ff ff ff 31 c0 c3 cc cc cc cc 66 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 <f3> 0f 1e fa 65 48 8b 15 94 54 79 7e 65 8b 05 95 54 79 7e a9 00 01
RSP: 0018:ffffc90000006da8 EFLAGS: 00000006
RAX: 0000000000000000 RBX: ffffffff900017f0 RCX: ffffffff813cd395
RDX: ffff888021a31e00 RSI: ffffffff813cd3a2 RDI: 0000000000000005
RBP: ffffffff90001834 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000012 R11: 0000000000000000 R12: ffffffff81e7b3da
R13: ffffffff9083172c R14: dffffc0000000000 R15: ffffc90000006eb5
FS:  0000000000000000(0000) GS:ffff8880b9200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f46a2500c0c CR3: 000000000d97c000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <IRQ>
 __orc_find+0x7a/0x130 arch/x86/kernel/unwind_orc.c:100
 orc_find arch/x86/kernel/unwind_orc.c:227 [inline]
 unwind_next_frame+0x335/0x23a0 arch/x86/kernel/unwind_orc.c:494
 arch_stack_walk+0x100/0x170 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0x95/0xd0 kernel/stacktrace.c:122
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:579
 poison_slab_object+0xf7/0x160 mm/kasan/common.c:240
 __kasan_slab_free+0x32/0x50 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2252 [inline]
 slab_free mm/slub.c:4473 [inline]
 kfree+0x12a/0x3b0 mm/slub.c:4594
 dummy_timer+0x1750/0x38d0 drivers/usb/gadget/udc/dummy_hcd.c:1981
 __run_hrtimer kernel/time/hrtimer.c:1689 [inline]
 __hrtimer_run_queues+0x20c/0xcc0 kernel/time/hrtimer.c:1753
 hrtimer_interrupt+0x31b/0x800 kernel/time/hrtimer.c:1815
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1032 [inline]
 __sysvec_apic_timer_interrupt+0x10f/0x450 arch/x86/kernel/apic/apic.c:1049
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
 sysvec_apic_timer_interrupt+0x43/0xb0 arch/x86/kernel/apic/apic.c:1043
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:unwind_next_frame+0x771/0x23a0 arch/x86/kernel/unwind_orc.c:581
Code: 84 ce 0f 85 9b 18 00 00 83 e0 07 38 c2 0f 9e c1 84 d2 0f 95 c0 84 c1 0f 85 86 18 00 00 4d 0f bf 2c 24 4d 01 fd e8 2f a0 4d 00 <41> 0f b6 7c 24 05 48 c7 c6 e0 d6 29 8b 41 89 ff 83 e7 07 e8 77 9b
RSP: 0018:ffffc90000007720 EFLAGS: 00000246
RAX: 0000000000000000 RBX: ffffc900000077a0 RCX: 0000000000000001
RDX: ffff888021a31e00 RSI: ffffffff813ce671 RDI: ffffc900000077e0
RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000000000009
R10: 0000000000000004 R11: 0000000000000000 R12: ffffffff9080a7c8
R13: ffffc9000313f988 R14: ffffffff9080a7cc R15: ffffc9000313f978
 arch_stack_walk+0x100/0x170 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0x95/0xd0 kernel/stacktrace.c:122
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:579
 poison_slab_object+0xf7/0x160 mm/kasan/common.c:240
 __kasan_slab_free+0x32/0x50 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2252 [inline]
 slab_free mm/slub.c:4473 [inline]
 kmem_cache_free+0x12f/0x3a0 mm/slub.c:4548
 skb_kfree_head net/core/skbuff.c:1082 [inline]
 skb_kfree_head net/core/skbuff.c:1079 [inline]
 skb_free_head+0x18a/0x1d0 net/core/skbuff.c:1096
 skb_release_data+0x75c/0x980 net/core/skbuff.c:1123
 skb_release_all net/core/skbuff.c:1188 [inline]
 __kfree_skb net/core/skbuff.c:1202 [inline]
 consume_skb net/core/skbuff.c:1426 [inline]
 consume_skb+0xd0/0x170 net/core/skbuff.c:1420
 mac80211_hwsim_tx_frame+0x1f3/0x2a0 drivers/net/wireless/virtual/mac80211_hwsim.c:2216
 __mac80211_hwsim_beacon_tx drivers/net/wireless/virtual/mac80211_hwsim.c:2232 [inline]
 mac80211_hwsim_beacon_tx+0x592/0xa00 drivers/net/wireless/virtual/mac80211_hwsim.c:2315
 __iterate_interfaces+0x2d2/0x580 net/mac80211/util.c:772
 ieee80211_iterate_active_interfaces_atomic+0x71/0x1b0 net/mac80211/util.c:808
 mac80211_hwsim_beacon+0x105/0x200 drivers/net/wireless/virtual/mac80211_hwsim.c:2345
 __run_hrtimer kernel/time/hrtimer.c:1689 [inline]
 __hrtimer_run_queues+0x20c/0xcc0 kernel/time/hrtimer.c:1753
 hrtimer_run_softirq+0x17d/0x350 kernel/time/hrtimer.c:1770
 handle_softirqs+0x216/0x8f0 kernel/softirq.c:554
 __do_softirq kernel/softirq.c:588 [inline]
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu kernel/softirq.c:637 [inline]
 irq_exit_rcu+0xbb/0x120 kernel/softirq.c:649
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
 sysvec_apic_timer_interrupt+0x95/0xb0 arch/x86/kernel/apic/apic.c:1043
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:unwind_next_frame+0x5ea/0x23a0 arch/x86/kernel/unwind_orc.c:505
Code: df 4c 89 ea 48 c1 ea 03 0f b6 04 02 4c 89 ea 83 e2 07 38 d0 7f 08 84 c0 0f 85 71 18 00 00 45 0f b6 74 24 05 31 ff 41 83 e6 07 <44> 89 f6 e8 4e 9c 4d 00 45 84 f6 0f 84 ec fd ff ff e8 a0 a1 4d 00
RSP: 0018:ffffc9000313f000 EFLAGS: 00000202
RAX: 0000000000000000 RBX: ffffc9000313f080 RCX: ffffffff813cd424
RDX: 0000000000000007 RSI: ffffffff813ce4b2 RDI: 0000000000000000
RBP: 0000000000000001 R08: 0000000000000006 R09: ffffffff81fe7f20
R10: ffffffff81fe7b53 R11: 0000000000000000 R12: ffffffff9085004a
R13: ffffffff9085004f R14: 0000000000000002 R15: ffffc9000313f0b5
 arch_stack_walk+0x100/0x170 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0x95/0xd0 kernel/stacktrace.c:122
 save_stack+0x162/0x1f0 mm/page_owner.c:156
 __reset_page_owner+0x8d/0x400 mm/page_owner.c:297
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1094 [inline]
 free_unref_folios+0x9e9/0x1390 mm/page_alloc.c:2656
 folios_put_refs+0x560/0x760 mm/swap.c:1039
 folio_batch_release include/linux/pagevec.h:101 [inline]
 shmem_undo_range+0x5a1/0x1160 mm/shmem.c:1023
 shmem_truncate_range mm/shmem.c:1132 [inline]
 shmem_evict_inode+0x3a3/0xba0 mm/shmem.c:1260
 evict+0x2ed/0x6c0 fs/inode.c:669
 iput_final fs/inode.c:1793 [inline]
 iput.part.0+0x5a8/0x7f0 fs/inode.c:1819
 iput+0x5c/0x80 fs/inode.c:1809
 dentry_unlink_inode+0x29c/0x480 fs/dcache.c:407
 __dentry_kill+0x1d0/0x600 fs/dcache.c:610
 dput.part.0+0x4b1/0x9b0 fs/dcache.c:852
 dput+0x1f/0x30 fs/dcache.c:842
 __fput+0x54e/0xbb0 fs/file_table.c:430
 task_work_run+0x14e/0x250 kernel/task_work.c:222
 exit_task_work include/linux/task_work.h:40 [inline]
 do_exit+0xaa3/0x2bb0 kernel/exit.c:882
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1031
 get_signal+0x25fd/0x2770 kernel/signal.c:2917
 arch_do_signal_or_restart+0x90/0x7e0 arch/x86/kernel/signal.c:310
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x150/0x2a0 kernel/entry/common.c:218
 do_syscall_64+0xda/0x250 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f9425575f19
Code: Unable to access opcode bytes at 0x7f9425575eef.
RSP: 002b:00007f942627f0f8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: fffffffffffffe00 RBX: 00007f9425706118 RCX: 00007f9425575f19
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00007f9425706118
RBP: 00007f9425706110 R08: 00007f942627f6c0 R09: 00007f942627f6c0
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f942570611c
R13: 000000000000006e R14: 00007ffdda9da700 R15: 00007ffdda9da7e8
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

