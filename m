Return-Path: <netdev+bounces-130263-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FDC49899B9
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 06:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F12CB1F2174E
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 04:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E2741C65;
	Mon, 30 Sep 2024 04:20:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76C23209
	for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 04:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727670028; cv=none; b=q2mW4HYBQcO/AB325Ndi59rvz7hiChUNNyJBQpGxw5svPG2ccUfjDjwvby3lCDzWu62YL/KKd40V96htmbntOI8KQq9AXByJ4AqVwuGuottK80eqSTuBvdXu4iTZGTuTAsU2YyFAF3Exq4Exy2mvMlWNCO1lgEAnG8yKDDzhuuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727670028; c=relaxed/simple;
	bh=sBnQxQ2Gtk2J3sFtJOpQYMQUmNBoBzya6rECTS4Eqa0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=bVWFwO3iaqaa6pkCyXF/Iyq9OqLZyRADaAVAJyJGzyKu1fPtNCvpQ5XZ6/Pc7t1sEFOYK3w+1ZoZ1yAGDQlMF/YwZ3mByZtZETP1KlYU+ZT/nnrowM2LtEe7XoGBQN/Xyxaucn4pxv2V+nBIaljhWuzJ0Vruyn9rzJ4KfXUAtn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a34988d6b4so40901495ab.2
        for <netdev@vger.kernel.org>; Sun, 29 Sep 2024 21:20:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727670025; x=1728274825;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k3yWMnkOjQBDB6EZkswPXLOPm5wSRMVRyL5GByvxsh0=;
        b=XdtKzR/R+yn2BsUKNjVN+ptlMj4NuEjGNXzVh8NQ2OJbV8BwfhgTAcHf0qAg3Vp7uU
         qsXYwF3KC+VscGEqUemMcVmErHQiOod5dg9/fts6/RK9ezyngPMUPuqqDHfiWyXBsdoZ
         Q3Q5wuohzgENfWmrYawnmttj0U6KHUQx3pgkPl9yR4EEnsB6TJ7EufhS/OW1YqNT5WJ/
         cgbeOoTFuLwEu2SyfiKyDM8tHPFlC8oPQ0q/BrJzzFEV02QnxOguIczUdB5cvYWmlu2+
         zlv6nxBplJot1iYiKjguESit6Ry98FQ8mWvX/q4cZxjidb8eBbmT4GHC9I7DKoHjY//e
         U/tQ==
X-Forwarded-Encrypted: i=1; AJvYcCXetQvvcOe8pXvaMLS8joE/btXT8T+dn0NJerfPqsz8Tql4qy91X8tS/U6YbPeB+ii5RFRWjPY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9MusMziDOoXxBBpmL0O3AyAsb2TqjcCFKlGpq1YaEgKQTLBHl
	GP2PpffjEpdn8AFecT4csqQbyRa8vDa1IzDpXujIXNhX+eS6GhDiBCIBj29xQ4wDXeuljeg87++
	oz5GIgDVZNshP2WsZlIgfpe5xZbedyD12H4vgnsIZx8uZ96Ik88nbsyw=
X-Google-Smtp-Source: AGHT+IExfr8r+9hDmL0LH94wFZZPTjnnDBmFRxy89DIAbrfxZRqQnFiSurPxR+GsnSHtRol8262Ad0ZcrEPgDNy5HMIbSWBw7i+p
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a4b:b0:3a0:bd91:3842 with SMTP id
 e9e14a558f8ab-3a3452b8bc8mr75375815ab.24.1727670025000; Sun, 29 Sep 2024
 21:20:25 -0700 (PDT)
Date: Sun, 29 Sep 2024 21:20:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66fa2708.050a0220.aab67.0025.GAE@google.com>
Subject: [syzbot] [wireguard?] INFO: task hung in wg_destruct (2)
From: syzbot <syzbot+7da6c19dc528c2ebc612@syzkaller.appspotmail.com>
To: Jason@zx2c4.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, wireguard@lists.zx2c4.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    3efc57369a0c Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17590ea9980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a4fcb065287cdb84
dashboard link: https://syzkaller.appspot.com/bug?extid=7da6c19dc528c2ebc612
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b5a4faec7a99/disk-3efc5736.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/971adf9a5295/vmlinux-3efc5736.xz
kernel image: https://storage.googleapis.com/syzbot-assets/49516da34e16/bzImage-3efc5736.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7da6c19dc528c2ebc612@syzkaller.appspotmail.com

INFO: task kworker/u8:3:52 blocked for more than 143 seconds.
      Not tainted 6.11.0-syzkaller-11993-g3efc57369a0c #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u8:3    state:D stack:20048 pid:52    tgid:52    ppid:2      flags:0x00004000
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
 wg_destruct+0x25/0x2e0 drivers/net/wireguard/device.c:246
 netdev_run_todo+0xe1a/0x1000 net/core/dev.c:10805
 default_device_exit_batch+0xa24/0xaa0 net/core/dev.c:11945
 ops_exit_list net/core/net_namespace.c:178 [inline]
 cleanup_net+0x89d/0xcc0 net/core/net_namespace.c:626
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
INFO: task dhcpcd:4897 blocked for more than 144 seconds.
      Not tainted 6.11.0-syzkaller-11993-g3efc57369a0c #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:dhcpcd          state:D stack:23632 pid:4897  tgid:4897  ppid:1      flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x1895/0x4b30 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6767
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6824
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a7/0xd70 kernel/locking/mutex.c:752
 nl80211_pre_doit+0x5f/0x8b0 net/wireless/nl80211.c:16580
 genl_family_rcv_msg_doit net/netlink/genetlink.c:1110 [inline]
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0xaaa/0xec0 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2550
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
 netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1357
 netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1901
 sock_sendmsg_nosec net/socket.c:729 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:744
 ____sys_sendmsg+0x52a/0x7e0 net/socket.c:2602
 ___sys_sendmsg net/socket.c:2656 [inline]
 __sys_sendmsg+0x292/0x380 net/socket.c:2685
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fcb51a89a4b
RSP: 002b:00007ffd30a99618 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fcb51a89a4b
RDX: 0000000000000000 RSI: 00007ffd30a99660 RDI: 0000000000000010
RBP: 00007ffd30aadb28 R08: 0000000000000000 R09: 0000000000000000
R10: 00007ffd30aadd70 R11: 0000000000000246 R12: 0000000000000010
R13: 00007ffd30a9d6c0 R14: 0000000000000000 R15: 000055706c260780
 </TASK>
INFO: task kworker/u8:12:5817 blocked for more than 145 seconds.
      Not tainted 6.11.0-syzkaller-11993-g3efc57369a0c #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u8:12   state:D stack:20048 pid:5817  tgid:5817  ppid:2      flags:0x00004000
Workqueue: cfg80211 cfg80211_dfs_channels_update_work
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x1895/0x4b30 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6767
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6824
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a7/0xd70 kernel/locking/mutex.c:752
 cfg80211_dfs_channels_update_work+0xbf/0x610 net/wireless/mlme.c:1021
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
INFO: task kworker/u8:13:5818 blocked for more than 145 seconds.
      Not tainted 6.11.0-syzkaller-11993-g3efc57369a0c #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u8:13   state:D stack:20496 pid:5818  tgid:5818  ppid:2      flags:0x00004000
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
 process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
INFO: task syz-executor:11463 blocked for more than 145 seconds.
      Not tainted 6.11.0-syzkaller-11993-g3efc57369a0c #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:21728 pid:11463 tgid:11463 ppid:1      flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x1895/0x4b30 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6767
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6824
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a7/0xd70 kernel/locking/mutex.c:752
 rtnl_lock net/core/rtnetlink.c:79 [inline]
 rtnetlink_rcv_msg+0x6e6/0xcf0 net/core/rtnetlink.c:6643
 netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2550
 netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
 netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1357
 netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1901
 sock_sendmsg_nosec net/socket.c:729 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:744
 __sys_sendto+0x39b/0x4f0 net/socket.c:2209
 __do_sys_sendto net/socket.c:2221 [inline]
 __se_sys_sendto net/socket.c:2217 [inline]
 __x64_sys_sendto+0xde/0x100 net/socket.c:2217
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f7a4d17fe8c
RSP: 002b:00007f7a4d45f6b0 EFLAGS: 00000293 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00007f7a4de64620 RCX: 00007f7a4d17fe8c
RDX: 000000000000003c RSI: 00007f7a4de64670 RDI: 0000000000000003
RBP: 0000000000000000 R08: 00007f7a4d45f704 R09: 000000000000000c
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000003
R13: 0000000000000000 R14: 00007f7a4de64670 R15: 0000000000000000
 </TASK>
INFO: task syz.2.1136:11518 blocked for more than 146 seconds.
      Not tainted 6.11.0-syzkaller-11993-g3efc57369a0c #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.2.1136      state:D stack:23520 pid:11518 tgid:11512 ppid:10259  flags:0x00004002
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
 __fput+0x23f/0x880 fs/file_table.c:431
 task_work_run+0x24f/0x310 kernel/task_work.c:228
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
RIP: 0033:0x7f6d0817dff9
RSP: 002b:00007f6d08fea038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: 0000000000000000 RBX: 00007f6d08336058 RCX: 00007f6d0817dff9
RDX: 0000000020000040 RSI: 0000000000008983 RDI: 000000000000000b
RBP: 00007f6d081f0296 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f6d08336058 R15: 00007f6d0845fa28
 </TASK>
INFO: task syz.4.1142:11533 blocked for more than 147 seconds.
      Not tainted 6.11.0-syzkaller-11993-g3efc57369a0c #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.4.1142      state:D stack:22320 pid:11533 tgid:11532 ppid:10623  flags:0x00004002
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
 __fput+0x23f/0x880 fs/file_table.c:431
 task_work_run+0x24f/0x310 kernel/task_work.c:228
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
RIP: 0033:0x7fbf3577dff9
RSP: 002b:00007fbf3659a038 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: 0000000000000024 RBX: 00007fbf35935f80 RCX: 00007fbf3577dff9
RDX: 0000000000000024 RSI: 0000000020000000 RDI: 0000000000000009
RBP: 00007fbf357f0296 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fbf35935f80 R15: 00007fbf35a5fa28
 </TASK>
INFO: task syz-executor:11545 blocked for more than 147 seconds.
      Not tainted 6.11.0-syzkaller-11993-g3efc57369a0c #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:26464 pid:11545 tgid:11545 ppid:1      flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x1895/0x4b30 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6767
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6824
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a7/0xd70 kernel/locking/mutex.c:752
 ip_tunnel_init_net+0x20e/0x720 net/ipv4/ip_tunnel.c:1159
 ops_init+0x31e/0x590 net/core/net_namespace.c:139
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
RIP: 0033:0x7f2a6637f7f7
RSP: 002b:00007f2a6665ffa8 EFLAGS: 00000206 ORIG_RAX: 0000000000000110
RAX: ffffffffffffffda RBX: 00007f2a663f1a85 RCX: 00007f2a6637f7f7
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000040000000
RBP: 0000000000000000 R08: 00007f2a67067d60 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000206 R12: 000000000000000c
R13: 0000000000000003 R14: 0000000000000009 R15: 0000000000000000
 </TASK>
INFO: task syz-executor:11548 blocked for more than 148 seconds.
      Not tainted 6.11.0-syzkaller-11993-g3efc57369a0c #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:26016 pid:11548 tgid:11548 ppid:1      flags:0x00000004
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
 __se_sys_ioctl+0xf9/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ff6c897dbfb
RSP: 002b:00007ff6c8c5fe90 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007ff6c89f1a85 RCX: 00007ff6c897dbfb
RDX: 00007ff6c8c5ff10 RSI: 00000000400454ca RDI: 00000000000000c8
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000000000c
R13: 0000000000000003 R14: 0000000000000009 R15: 0000000000000000
 </TASK>
INFO: task syz-executor:11554 blocked for more than 148 seconds.
      Not tainted 6.11.0-syzkaller-11993-g3efc57369a0c #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:24784 pid:11554 tgid:11554 ppid:1      flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x1895/0x4b30 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6767
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6824
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a7/0xd70 kernel/locking/mutex.c:752
 register_nexthop_notifier+0x84/0x290 net/ipv4/nexthop.c:3885
 ops_init+0x31e/0x590 net/core/net_namespace.c:139
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
RIP: 0033:0x7fb620b7f7f7
RSP: 002b:00007fb620e5ffa8 EFLAGS: 00000206 ORIG_RAX: 0000000000000110
RAX: ffffffffffffffda RBX: 00007fb620bf1a85 RCX: 00007fb620b7f7f7
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000040000000
RBP: 0000000000000000 R08: 00007fb621867d60 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000206 R12: 000000000000000c
R13: 0000000000000003 R14: 0000000000000009 R15: 0000000000000000
 </TASK>
Future hung task reports are suppressed, see sysctl kernel.hung_task_warnings

Showing all locks held in the system:
1 lock held by khungtaskd/30:
 #0: ffffffff8e937da0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #0: ffffffff8e937da0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffffffff8e937da0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x55/0x2a0 kernel/locking/lockdep.c:6701
2 locks held by kworker/u8:2/35:
 #0: ffff8880b863ea98 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:593
 #1: ffff8880b8628948 (&per_cpu_ptr(group->pcpu, cpu)->seq){-.-.}-{0:0}, at: psi_task_switch+0x441/0x770 kernel/sched/psi.c:989
4 locks held by kworker/1:1/51:
4 locks held by kworker/u8:3/52:
 #0: ffff88801baed948 ((wq_completion)netns){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff88801baed948 ((wq_completion)netns){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1850 kernel/workqueue.c:3310
 #1: ffffc90000bd7d00 (net_cleanup_work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc90000bd7d00 (net_cleanup_work){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1850 kernel/workqueue.c:3310
 #2: ffffffff8fcc49d0 (pernet_ops_rwsem){++++}-{3:3}, at: cleanup_net+0x16a/0xcc0 net/core/net_namespace.c:580
 #3: ffffffff8fcd14c8 (rtnl_mutex){+.+.}-{3:3}, at: wg_destruct+0x25/0x2e0 drivers/net/wireguard/device.c:246
2 locks held by dhcpcd/4897:
 #0: ffffffff8fd37230 (cb_lock){++++}-{3:3}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1218
 #1: ffffffff8fcd14c8 (rtnl_mutex){+.+.}-{3:3}, at: nl80211_pre_doit+0x5f/0x8b0 net/wireless/nl80211.c:16580
2 locks held by getty/4986:
 #0: ffff888031b7a0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc90002f062f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x6a6/0x1e00 drivers/tty/n_tty.c:2211
3 locks held by kworker/1:5/5283:
3 locks held by kworker/u8:8/5692:
 #0: ffff88814c309148 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff88814c309148 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1850 kernel/workqueue.c:3310
 #1: ffffc9000cf87d00 ((work_completion)(&(&net->ipv6.addr_chk_work)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc9000cf87d00 ((work_completion)(&(&net->ipv6.addr_chk_work)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1850 kernel/workqueue.c:3310
 #2: ffffffff8fcd14c8 (rtnl_mutex){+.+.}-{3:3}, at: addrconf_verify_work+0x19/0x30 net/ipv6/addrconf.c:4736
3 locks held by kworker/u8:12/5817:
 #0: ffff8881462a8948 ((wq_completion)cfg80211){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff8881462a8948 ((wq_completion)cfg80211){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1850 kernel/workqueue.c:3310
 #1: ffffc9000343fd00 ((work_completion)(&(&rdev->dfs_update_channels_wk)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc9000343fd00 ((work_completion)(&(&rdev->dfs_update_channels_wk)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1850 kernel/workqueue.c:3310
 #2: ffffffff8fcd14c8 (rtnl_mutex){+.+.}-{3:3}, at: cfg80211_dfs_channels_update_work+0xbf/0x610 net/wireless/mlme.c:1021
3 locks held by kworker/u8:13/5818:
 #0: ffff88801ac89148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff88801ac89148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1850 kernel/workqueue.c:3310
 #1: ffffc9000342fd00 ((linkwatch_work).work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc9000342fd00 ((linkwatch_work).work){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1850 kernel/workqueue.c:3310
 #2: ffffffff8fcd14c8 (rtnl_mutex){+.+.}-{3:3}, at: linkwatch_event+0xe/0x60 net/core/link_watch.c:276
1 lock held by syz-executor/11463:
 #0: ffffffff8fcd14c8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8fcd14c8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x6e6/0xcf0 net/core/rtnetlink.c:6643
1 lock held by syz.2.1136/11518:
 #0: ffffffff8fcd14c8 (rtnl_mutex){+.+.}-{3:3}, at: tun_detach drivers/net/tun.c:698 [inline]
 #0: ffffffff8fcd14c8 (rtnl_mutex){+.+.}-{3:3}, at: tun_chr_close+0x3b/0x1b0 drivers/net/tun.c:3517
1 lock held by syz.4.1142/11533:
 #0: ffffffff8fcd14c8 (rtnl_mutex){+.+.}-{3:3}, at: tun_detach drivers/net/tun.c:698 [inline]
 #0: ffffffff8fcd14c8 (rtnl_mutex){+.+.}-{3:3}, at: tun_chr_close+0x3b/0x1b0 drivers/net/tun.c:3517
2 locks held by syz-executor/11540:
 #0: ffffffff8fcc49d0 (pernet_ops_rwsem){++++}-{3:3}, at: copy_net_ns+0x328/0x570 net/core/net_namespace.c:490
 #1: ffffffff8fcd14c8 (rtnl_mutex){+.+.}-{3:3}, at: setup_net+0x602/0x9e0 net/core/net_namespace.c:378
2 locks held by syz-executor/11542:
 #0: ffffffff8fcc49d0 (pernet_ops_rwsem){++++}-{3:3}, at: copy_net_ns+0x328/0x570 net/core/net_namespace.c:490
 #1: ffffffff8fcd14c8 (rtnl_mutex){+.+.}-{3:3}, at: setup_net+0x602/0x9e0 net/core/net_namespace.c:378
2 locks held by syz-executor/11545:
 #0: ffffffff8fcc49d0 (pernet_ops_rwsem){++++}-{3:3}, at: copy_net_ns+0x328/0x570 net/core/net_namespace.c:490
 #1: ffffffff8fcd14c8 (rtnl_mutex){+.+.}-{3:3}, at: ip_tunnel_init_net+0x20e/0x720 net/ipv4/ip_tunnel.c:1159
1 lock held by syz-executor/11548:
 #0: ffffffff8fcd14c8 (rtnl_mutex){+.+.}-{3:3}, at: __tun_chr_ioctl+0x48c/0x2400 drivers/net/tun.c:3121
2 locks held by syz-executor/11554:
 #0: ffffffff8fcc49d0 (pernet_ops_rwsem){++++}-{3:3}, at: copy_net_ns+0x328/0x570 net/core/net_namespace.c:490
 #1: ffffffff8fcd14c8 (rtnl_mutex){+.+.}-{3:3}, at: register_nexthop_notifier+0x84/0x290 net/ipv4/nexthop.c:3885
2 locks held by syz-executor/11558:
 #0: ffffffff8fcc49d0 (pernet_ops_rwsem){++++}-{3:3}, at: copy_net_ns+0x328/0x570 net/core/net_namespace.c:490
 #1: ffffffff8fcd14c8 (rtnl_mutex){+.+.}-{3:3}, at: register_nexthop_notifier+0x84/0x290 net/ipv4/nexthop.c:3885
2 locks held by syz-executor/11564:
 #0: ffffffff8fcc49d0 (pernet_ops_rwsem){++++}-{3:3}, at: copy_net_ns+0x328/0x570 net/core/net_namespace.c:490
 #1: ffffffff8fcd14c8 (rtnl_mutex){+.+.}-{3:3}, at: register_nexthop_notifier+0x84/0x290 net/ipv4/nexthop.c:3885
2 locks held by syz-executor/11566:
 #0: ffffffff8fcc49d0 (pernet_ops_rwsem){++++}-{3:3}, at: copy_net_ns+0x328/0x570 net/core/net_namespace.c:490
 #1: ffffffff8fcd14c8 (rtnl_mutex){+.+.}-{3:3}, at: register_nexthop_notifier+0x84/0x290 net/ipv4/nexthop.c:3885
2 locks held by syz-executor/11569:
 #0: ffffffff8fcc49d0 (pernet_ops_rwsem){++++}-{3:3}, at: copy_net_ns+0x328/0x570 net/core/net_namespace.c:490
 #1: ffffffff8fcd14c8 (rtnl_mutex){+.+.}-{3:3}, at: register_nexthop_notifier+0x84/0x290 net/ipv4/nexthop.c:3885
2 locks held by syz-executor/11574:
 #0: ffffffff8fcc49d0 (pernet_ops_rwsem){++++}-{3:3}, at: copy_net_ns+0x328/0x570 net/core/net_namespace.c:490
 #1: ffffffff8fcd14c8 (rtnl_mutex){+.+.}-{3:3}, at: register_nexthop_notifier+0x84/0x290 net/ipv4/nexthop.c:3885
2 locks held by syz-executor/11581:
 #0: ffffffff8fcc49d0 (pernet_ops_rwsem){++++}-{3:3}, at: copy_net_ns+0x328/0x570 net/core/net_namespace.c:490
 #1: ffffffff8fcd14c8 (rtnl_mutex){+.+.}-{3:3}, at: register_nexthop_notifier+0x84/0x290 net/ipv4/nexthop.c:3885
2 locks held by syz-executor/11586:
 #0: ffffffff8fcc49d0 (pernet_ops_rwsem){++++}-{3:3}, at: copy_net_ns+0x328/0x570 net/core/net_namespace.c:490
 #1: ffffffff8fcd14c8 (rtnl_mutex){+.+.}-{3:3}, at: register_nexthop_notifier+0x84/0x290 net/ipv4/nexthop.c:3885
2 locks held by syz-executor/11588:
 #0: ffffffff8fcc49d0 (pernet_ops_rwsem){++++}-{3:3}, at: copy_net_ns+0x328/0x570 net/core/net_namespace.c:490
 #1: ffffffff8fcd14c8 (rtnl_mutex){+.+.}-{3:3}, at: register_nexthop_notifier+0x84/0x290 net/ipv4/nexthop.c:3885
2 locks held by syz-executor/11595:
 #0: ffffffff8fcc49d0 (pernet_ops_rwsem){++++}-{3:3}, at: copy_net_ns+0x328/0x570 net/core/net_namespace.c:490
 #1: ffffffff8fcd14c8 (rtnl_mutex){+.+.}-{3:3}, at: register_nexthop_notifier+0x84/0x290 net/ipv4/nexthop.c:3885
2 locks held by syz-executor/11600:
 #0: ffffffff8fcc49d0 (pernet_ops_rwsem){++++}-{3:3}, at: copy_net_ns+0x328/0x570 net/core/net_namespace.c:490
 #1: ffffffff8fcd14c8 (rtnl_mutex){+.+.}-{3:3}, at: register_nexthop_notifier+0x84/0x290 net/ipv4/nexthop.c:3885
2 locks held by syz-executor/11605:
 #0: ffffffff8fcc49d0 (pernet_ops_rwsem){++++}-{3:3}, at: copy_net_ns+0x328/0x570 net/core/net_namespace.c:490
 #1: ffffffff8fcd14c8 (rtnl_mutex){+.+.}-{3:3}, at: register_nexthop_notifier+0x84/0x290 net/ipv4/nexthop.c:3885
2 locks held by syz-executor/11611:
 #0: ffffffff8fcc49d0 (pernet_ops_rwsem){++++}-{3:3}, at: copy_net_ns+0x328/0x570 net/core/net_namespace.c:490
 #1: ffffffff8fcd14c8 (rtnl_mutex){+.+.}-{3:3}, at: register_nexthop_notifier+0x84/0x290 net/ipv4/nexthop.c:3885
2 locks held by syz-executor/11613:
 #0: ffffffff8fcc49d0 (pernet_ops_rwsem){++++}-{3:3}, at: copy_net_ns+0x328/0x570 net/core/net_namespace.c:490
 #1: ffffffff8fcd14c8 (rtnl_mutex){+.+.}-{3:3}, at: register_nexthop_notifier+0x84/0x290 net/ipv4/nexthop.c:3885
2 locks held by syz-executor/11616:
 #0: ffffffff8fcc49d0 (pernet_ops_rwsem){++++}-{3:3}, at: copy_net_ns+0x328/0x570 net/core/net_namespace.c:490
 #1: ffffffff8fcd14c8 (rtnl_mutex){+.+.}-{3:3}, at: register_nexthop_notifier+0x84/0x290 net/ipv4/nexthop.c:3885

=============================================

NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 30 Comm: khungtaskd Not tainted 6.11.0-syzkaller-11993-g3efc57369a0c #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x49c/0x4d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x198/0x320 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:162 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:223 [inline]
 watchdog+0xff4/0x1040 kernel/hung_task.c:379
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 51 Comm: kworker/1:1 Not tainted 6.11.0-syzkaller-11993-g3efc57369a0c #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: events_power_efficient neigh_periodic_work
RIP: 0010:__lock_acquire+0xe9b/0x2050
Code: 81 e3 00 60 00 00 09 c3 4c 89 f0 48 c1 e8 20 29 c3 89 c1 c1 c1 04 31 d9 44 01 f0 41 29 ce 89 ca c1 c2 06 44 31 f2 01 c1 29 d0 <89> d6 c1 c6 08 31 c6 01 ca 29 f1 89 f3 c1 c3 10 31 cb 01 d6 29 da
RSP: 0018:ffffc90000a17430 EFLAGS: 00000087
RAX: 00000000e98ab003 RBX: 000000006b5f6680 RCX: 000000003db26586
RDX: 0000000032d4b8da RSI: 0000000000000008 RDI: dffffc0000000000
RBP: ffff888020eac780 R08: ffffffff942757c7 R09: 1ffffffff284eaf8
R10: dffffc0000000000 R11: fffffbfff284eaf9 R12: 0000000000000000
R13: ffff888020eac6d8 R14: 00000000666b9292 R15: ffff888020eac7a0
FS:  0000000000000000(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020001000 CR3: 000000000e734000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000004000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <IRQ>
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5822
 rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 rcu_read_lock include/linux/rcupdate.h:849 [inline]
 __skb_flow_dissect+0x50e/0x7d00 net/core/flow_dissector.c:1125
 __xfrm_decode_session+0xc2/0xf70 net/xfrm/xfrm_policy.c:3461
 xfrm_decode_session include/net/xfrm.h:1258 [inline]
 ip_route_me_harder+0xa5c/0x1300 net/ipv4/netfilter.c:66
 synproxy_send_tcp+0x356/0x6c0 net/netfilter/nf_synproxy_core.c:431
 synproxy_send_client_synack+0x8b8/0xf30 net/netfilter/nf_synproxy_core.c:484
 nft_synproxy_eval_v4+0x3ca/0x610 net/netfilter/nft_synproxy.c:59
 nft_synproxy_do_eval+0x362/0xa60 net/netfilter/nft_synproxy.c:141
 expr_call_ops_eval net/netfilter/nf_tables_core.c:240 [inline]
 nft_do_chain+0x4ad/0x1da0 net/netfilter/nf_tables_core.c:288
 nft_do_chain_inet+0x418/0x6b0 net/netfilter/nft_chain_filter.c:161
 nf_hook_entry_hookfn include/linux/netfilter.h:154 [inline]
 nf_hook_slow+0xc3/0x220 net/netfilter/core.c:626
 nf_hook include/linux/netfilter.h:269 [inline]
 NF_HOOK+0x29e/0x450 include/linux/netfilter.h:312
 NF_HOOK+0x3a4/0x450 include/linux/netfilter.h:314
 __netif_receive_skb_one_core net/core/dev.c:5662 [inline]
 __netif_receive_skb+0x2bf/0x650 net/core/dev.c:5775
 process_backlog+0x662/0x15b0 net/core/dev.c:6107
 __napi_poll+0xcb/0x490 net/core/dev.c:6771
 napi_poll net/core/dev.c:6840 [inline]
 net_rx_action+0x89b/0x1240 net/core/dev.c:6962
 handle_softirqs+0x2c5/0x980 kernel/softirq.c:554
 do_softirq+0x11b/0x1e0 kernel/softirq.c:455
 </IRQ>
 <TASK>
 __local_bh_enable_ip+0x1bb/0x200 kernel/softirq.c:382
 neigh_periodic_work+0xb35/0xd50 net/core/neighbour.c:1019
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
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

