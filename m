Return-Path: <netdev+bounces-132259-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA85F991237
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 00:17:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E42E28400C
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 22:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8336E1AE01F;
	Fri,  4 Oct 2024 22:17:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFBB13212A
	for <netdev@vger.kernel.org>; Fri,  4 Oct 2024 22:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728080251; cv=none; b=mRURzn8BDMr36DMh1IgyHewZP6Ges5SGyUjk9xNH9fAq17R1A3l5YwHhq1N7xCAZHRYKkR7LAMlY7gzX+oZGobHa6WdTbcJfKqvbxKKUiwZBnyd2hF2i4TIur9CZEGX+ArLzLD2A7IkbG/16KZdQ2R5JVcT8eSY2F11eW8KwDk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728080251; c=relaxed/simple;
	bh=8ApdvibrOfhjMsi0kc+b8OM5BnCMxfKMWWVyXEXLK+0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Kd2orn3k65wZsqcaDT0H96ReCQsZJoFY4UBLtmWJxfv5tAEl4q928fROS6wjvgGkqRuNZSRSH3PRgSiWoqPozI2+lNKdvCNTHtgo54bbCSK8FNA9b5BZuItu1guahycso/ZBkradGLvC4MeZX/albQOj5Ju+WsErK+NweozIqqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a343c444afso30758645ab.1
        for <netdev@vger.kernel.org>; Fri, 04 Oct 2024 15:17:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728080248; x=1728685048;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4HYpIWqyRfdPOuwxcLnDAJBos/7M4JvCWNa4QLCYOP0=;
        b=VzqY9VDfrpqMNIEWadyaWmhZzcNBYLxx87iVeySJ+/SRVT1VGvCj8mfECD3cvHUKtb
         R7vgXZrmFYmoYQUgz4RAzICZEZmPz0Ie6U7pu84wzm34kMn7zH3Cld9R1+dy4laGdMOC
         zSqhMNgLZvKkCW8zqXEoldkSuCdnRA+XfigqktwwfwzztYZWzaCDQclk19LEJT1ew0lh
         tQm2AvRhYzK+tWhS5rmOuucF6IvsLFdKF/XnZWgTEdOztY9P0LRKTUGDyCHUlPOn/33B
         Sfjrbu6rikUvCHb0zmBw3rlqyuiUEpuGqqW1ovnb4nqotC4nWTJLU3yOGEndl+A7xQBH
         a5BQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYEv9VTOo6hvteaNRp/xiEZ+F5o4q3JpGcMgcAVP4eHwOFFEP3UTmDKj69wpXTpfQKn5LrgUk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoI6nIJR9kXmmXUyH0qMu+mGpis79219jrcmNWIhjYKdNGfpau
	ijFxbBDmKBYfY0LDh+rv6CTCN7PQNxQWwCMJ1l8T0ZnixH8CXwAy+dC8/gzPZvOvsfhOa3bIpWj
	sYwtQWL8Sz/RN3NYwzY0M+Z+IhjRiNXACggEZ/Y04XUWY/ER3fQkN0T0=
X-Google-Smtp-Source: AGHT+IFRAz6Runj/tIkJx1o2cg1yObaaLUyiRLr0hAjQnpr208UIqF6IcZPT5AfY0/5y3zQvk0R4ClQAzqFWqua5kowXv+p4EN4R
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1749:b0:3a0:9159:1561 with SMTP id
 e9e14a558f8ab-3a375976f16mr44458945ab.2.1728080248633; Fri, 04 Oct 2024
 15:17:28 -0700 (PDT)
Date: Fri, 04 Oct 2024 15:17:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67006978.050a0220.49194.04a4.GAE@google.com>
Subject: [syzbot] [net?] INFO: task hung in nsim_dev_hwstats_exit
From: syzbot <syzbot+d383dc9579a76f56c251@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7ec462100ef9 Merge tag 'pull-work.unaligned' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17174b9f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f95955e3f7b5790c
dashboard link: https://syzkaller.appspot.com/bug?extid=d383dc9579a76f56c251
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/26c0a2e75a06/disk-7ec46210.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b2f7877871ae/vmlinux-7ec46210.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6a1172adb73c/bzImage-7ec46210.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d383dc9579a76f56c251@syzkaller.appspotmail.com

INFO: task kworker/u8:2:35 blocked for more than 143 seconds.
      Not tainted 6.12.0-rc1-syzkaller-00046-g7ec462100ef9 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u8:2    state:D stack:20024 pid:35    tgid:35    ppid:2      flags:0x00004000
Workqueue: netns cleanup_net
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x1895/0x4b30 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6767
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6824
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a7/0xd70 kernel/locking/mutex.c:752
 unregister_netdevice_notifier_net+0x89/0x3a0 net/core/dev.c:1917
 nsim_dev_hwstats_exit+0x81/0x290 drivers/net/netdevsim/hwstats.c:483
 nsim_dev_reload_destroy+0x2ad/0x490 drivers/net/netdevsim/dev.c:1659
 nsim_dev_reload_down+0x98/0xd0 drivers/net/netdevsim/dev.c:965
 devlink_reload+0x18d/0x870 net/devlink/dev.c:461
 devlink_pernet_pre_exit+0x1f3/0x440 net/devlink/core.c:509
 ops_pre_exit_list net/core/net_namespace.c:163 [inline]
 cleanup_net+0x617/0xcc0 net/core/net_namespace.c:606
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa65/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f2/0x390 kernel/kthread.c:389
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
INFO: task kworker/u8:4:62 blocked for more than 144 seconds.
      Not tainted 6.12.0-rc1-syzkaller-00046-g7ec462100ef9 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u8:4    state:D stack:20496 pid:62    tgid:62    ppid:2      flags:0x00004000
Workqueue: events_unbound linkwatch_event
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x1895/0x4b30 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6767
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6824
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a7/0xd70 kernel/locking/mutex.c:752
 linkwatch_event+0xe/0x60 net/core/link_watch.c:276
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa65/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f2/0x390 kernel/kthread.c:389
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
INFO: task syz-executor:16297 blocked for more than 145 seconds.
      Not tainted 6.12.0-rc1-syzkaller-00046-g7ec462100ef9 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:21728 pid:16297 tgid:16297 ppid:1      flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x1895/0x4b30 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6767
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6824
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a7/0xd70 kernel/locking/mutex.c:752
 tun_detach drivers/net/tun.c:698 [inline]
 tun_chr_close+0x3b/0x1b0 drivers/net/tun.c:3517
 __fput+0x241/0x880 fs/file_table.c:431
 task_work_run+0x251/0x310 kernel/task_work.c:228
 exit_task_work include/linux/task_work.h:40 [inline]
 do_exit+0xa2f/0x28e0 kernel/exit.c:939
 do_group_exit+0x207/0x2c0 kernel/exit.c:1088
 get_signal+0x16a3/0x1740 kernel/signal.c:2917
 arch_do_signal_or_restart+0x96/0x860 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0xc9/0x370 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f6c3077fe8c
RSP: 002b:00007fffea2bfc30 EFLAGS: 00000293 ORIG_RAX: 000000000000002c
RAX: 0000000000000068 RBX: 00007f6c31464620 RCX: 00007f6c3077fe8c
RDX: 0000000000000068 RSI: 00007f6c31464670 RDI: 0000000000000003
RBP: 0000000000000000 R08: 00007fffea2bfc84 R09: 000000000000000c
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000003
R13: 0000000000000000 R14: 00007f6c31464670 R15: 0000000000000000
 </TASK>
INFO: task syz-executor:16474 blocked for more than 146 seconds.
      Not tainted 6.12.0-rc1-syzkaller-00046-g7ec462100ef9 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:22672 pid:16474 tgid:16474 ppid:1      flags:0x00000004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x1895/0x4b30 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6767
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6824
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a7/0xd70 kernel/locking/mutex.c:752
 __tun_chr_ioctl+0x48c/0x2400 drivers/net/tun.c:3121
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xfb/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f373cb7dbfb
RSP: 002b:00007fff3d141dc0 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f373cd35f40 RCX: 00007f373cb7dbfb
RDX: 00007fff3d141e40 RSI: 00000000400454ca RDI: 00000000000000c8
RBP: 00007f373cd36a38 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000000000c
R13: 0000000000000003 R14: 0000000000000009 R15: 0000000000000000
 </TASK>
INFO: task syz.2.4951:16500 blocked for more than 146 seconds.
      Not tainted 6.12.0-rc1-syzkaller-00046-g7ec462100ef9 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.2.4951      state:D stack:25472 pid:16500 tgid:16499 ppid:15939  flags:0x00004002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x1895/0x4b30 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6767
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6824
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a7/0xd70 kernel/locking/mutex.c:752
 tun_detach drivers/net/tun.c:698 [inline]
 tun_chr_close+0x3b/0x1b0 drivers/net/tun.c:3517
 __fput+0x241/0x880 fs/file_table.c:431
 task_work_run+0x251/0x310 kernel/task_work.c:228
 exit_task_work include/linux/task_work.h:40 [inline]
 do_exit+0xa2f/0x28e0 kernel/exit.c:939
 do_group_exit+0x207/0x2c0 kernel/exit.c:1088
 get_signal+0x16a3/0x1740 kernel/signal.c:2917
 arch_do_signal_or_restart+0x96/0x860 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0xc9/0x370 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe17a17dff9
RSP: 002b:00007fe17aed8038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: 0000000000000034 RBX: 00007fe17a335f80 RCX: 00007fe17a17dff9
RDX: 0000000000000000 RSI: 0000000020000500 RDI: 0000000000000003
RBP: 00007fe17a1f0296 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fe17a335f80 R15: 00007fffa80173a8
 </TASK>
INFO: task syz.0.4954:16504 blocked for more than 147 seconds.
      Not tainted 6.12.0-rc1-syzkaller-00046-g7ec462100ef9 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.0.4954      state:D stack:23808 pid:16504 tgid:16502 ppid:5226   flags:0x00004002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x1895/0x4b30 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6767
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6824
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a7/0xd70 kernel/locking/mutex.c:752
 tun_detach drivers/net/tun.c:698 [inline]
 tun_chr_close+0x3b/0x1b0 drivers/net/tun.c:3517
 __fput+0x241/0x880 fs/file_table.c:431
 task_work_run+0x251/0x310 kernel/task_work.c:228
 exit_task_work include/linux/task_work.h:40 [inline]
 do_exit+0xa2f/0x28e0 kernel/exit.c:939
 do_group_exit+0x207/0x2c0 kernel/exit.c:1088
 get_signal+0x16a3/0x1740 kernel/signal.c:2917
 arch_do_signal_or_restart+0x96/0x860 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0xc9/0x370 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f5e9dd7dff9
RSP: 002b:00007f5e9ebee038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: 000000000000008c RBX: 00007f5e9df35f80 RCX: 00007f5e9dd7dff9
RDX: 0000000000000000 RSI: 0000000020000000 RDI: 0000000000000003
RBP: 00007f5e9ddf0296 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f5e9df35f80 R15: 00007ffdf96cac68
 </TASK>
INFO: task syz.3.4965:16529 blocked for more than 148 seconds.
      Not tainted 6.12.0-rc1-syzkaller-00046-g7ec462100ef9 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.3.4965      state:D stack:25808 pid:16529 tgid:16528 ppid:5233   flags:0x00004002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x1895/0x4b30 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6767
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6824
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a7/0xd70 kernel/locking/mutex.c:752
 tun_detach drivers/net/tun.c:698 [inline]
 tun_chr_close+0x3b/0x1b0 drivers/net/tun.c:3517
 __fput+0x241/0x880 fs/file_table.c:431
 task_work_run+0x251/0x310 kernel/task_work.c:228
 exit_task_work include/linux/task_work.h:40 [inline]
 do_exit+0xa2f/0x28e0 kernel/exit.c:939
 do_group_exit+0x207/0x2c0 kernel/exit.c:1088
 get_signal+0x16a3/0x1740 kernel/signal.c:2917
 arch_do_signal_or_restart+0x96/0x860 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0xc9/0x370 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb85897dff9
RSP: 002b:00007fb8583ff038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: 000000000000003c RBX: 00007fb858b35f80 RCX: 00007fb85897dff9
RDX: 0000000020000004 RSI: 0000000020000540 RDI: 0000000000000003
RBP: 00007fb8589f0296 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fb858b35f80 R15: 00007fffcfc6e4d8
 </TASK>
INFO: task syz.1.4971:16546 blocked for more than 149 seconds.
      Not tainted 6.12.0-rc1-syzkaller-00046-g7ec462100ef9 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.1.4971      state:D stack:24016 pid:16546 tgid:16545 ppid:5228   flags:0x00004002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x1895/0x4b30 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6767
 schedule_timeout+0xb0/0x310 kernel/time/timer.c:2591
 do_wait_for_common kernel/sched/completion.c:95 [inline]
 __wait_for_common kernel/sched/completion.c:116 [inline]
 wait_for_common kernel/sched/completion.c:127 [inline]
 wait_for_completion+0x355/0x620 kernel/sched/completion.c:148
 __flush_work+0xa37/0xc50 kernel/workqueue.c:4217
 flush_all_backlogs net/core/dev.c:6037 [inline]
 unregister_netdevice_many_notify+0x87b/0x1da0 net/core/dev.c:11380
 unregister_netdevice_many net/core/dev.c:11461 [inline]
 unregister_netdevice_queue+0x303/0x370 net/core/dev.c:11335
 unregister_netdevice include/linux/netdevice.h:3118 [inline]
 __tun_detach+0x6b9/0x1600 drivers/net/tun.c:685
 tun_detach drivers/net/tun.c:701 [inline]
 tun_chr_close+0x105/0x1b0 drivers/net/tun.c:3517
 __fput+0x241/0x880 fs/file_table.c:431
 task_work_run+0x251/0x310 kernel/task_work.c:228
 exit_task_work include/linux/task_work.h:40 [inline]
 do_exit+0xa2f/0x28e0 kernel/exit.c:939
 do_group_exit+0x207/0x2c0 kernel/exit.c:1088
 get_signal+0x16a3/0x1740 kernel/signal.c:2917
 arch_do_signal_or_restart+0x96/0x860 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0xc9/0x370 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ffb24b7dff9
RSP: 002b:00007ffb25890038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: 0000000000000000 RBX: 00007ffb24d35f80 RCX: 00007ffb24b7dff9
RDX: 0000000020000900 RSI: 00000000000089f1 RDI: 0000000000000004
RBP: 00007ffb24bf0296 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007ffb24d35f80 R15: 00007ffcd0a96e58
 </TASK>
INFO: task syz-executor:16549 blocked for more than 151 seconds.
      Not tainted 6.12.0-rc1-syzkaller-00046-g7ec462100ef9 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:24128 pid:16549 tgid:16549 ppid:1      flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x1895/0x4b30 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6767
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6824
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a7/0xd70 kernel/locking/mutex.c:752
 add_one_compat_dev+0x10d/0x710 drivers/infiniband/core/device.c:949
 rdma_dev_init_net+0x1f1/0x280 drivers/infiniband/core/device.c:1191
 ops_init+0x320/0x590 net/core/net_namespace.c:139
 setup_net+0x287/0x9e0 net/core/net_namespace.c:356
 copy_net_ns+0x33f/0x570 net/core/net_namespace.c:494
 create_new_namespaces+0x425/0x7b0 kernel/nsproxy.c:110
 unshare_nsproxy_namespaces+0x124/0x180 kernel/nsproxy.c:228
 ksys_unshare+0x619/0xc10 kernel/fork.c:3315
 __do_sys_unshare kernel/fork.c:3386 [inline]
 __se_sys_unshare kernel/fork.c:3384 [inline]
 __x64_sys_unshare+0x38/0x40 kernel/fork.c:3384
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f0ca777f7f7
RSP: 002b:00007fffe72935f8 EFLAGS: 00000202 ORIG_RAX: 0000000000000110
RAX: ffffffffffffffda RBX: 00007f0ca7935f40 RCX: 00007f0ca777f7f7
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000040000000
RBP: 00007f0ca7936a38 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000202 R12: 000000000000000c
R13: 0000000000000003 R14: 0000000000000009 R15: 0000000000000000
 </TASK>
INFO: task syz-executor:16553 blocked for more than 151 seconds.
      Not tainted 6.12.0-rc1-syzkaller-00046-g7ec462100ef9 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:24128 pid:16553 tgid:16553 ppid:1      flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x1895/0x4b30 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6767
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6824
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a7/0xd70 kernel/locking/mutex.c:752
 add_one_compat_dev+0x10d/0x710 drivers/infiniband/core/device.c:949
 rdma_dev_init_net+0x1f1/0x280 drivers/infiniband/core/device.c:1191
 ops_init+0x320/0x590 net/core/net_namespace.c:139
 setup_net+0x287/0x9e0 net/core/net_namespace.c:356
 copy_net_ns+0x33f/0x570 net/core/net_namespace.c:494
 create_new_namespaces+0x425/0x7b0 kernel/nsproxy.c:110
 unshare_nsproxy_namespaces+0x124/0x180 kernel/nsproxy.c:228
 ksys_unshare+0x619/0xc10 kernel/fork.c:3315
 __do_sys_unshare kernel/fork.c:3386 [inline]
 __se_sys_unshare kernel/fork.c:3384 [inline]
 __x64_sys_unshare+0x38/0x40 kernel/fork.c:3384
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f9b9877f7f7
RSP: 002b:00007ffe09125df8 EFLAGS: 00000202 ORIG_RAX: 0000000000000110
RAX: ffffffffffffffda RBX: 00007f9b98935f40 RCX: 00007f9b9877f7f7


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

