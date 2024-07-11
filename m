Return-Path: <netdev+bounces-110964-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C845192F23A
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 00:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F257B20C2B
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 22:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 123B519EEA8;
	Thu, 11 Jul 2024 22:48:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060E314C596
	for <netdev@vger.kernel.org>; Thu, 11 Jul 2024 22:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720738104; cv=none; b=AdHXDlRUzCBtcTPEtEXKnIRXTelQGQDRX2Cupwd1QUfb36fRS9iY1aRzF/bS9u60OP3SxIf72zLJ6ih8Bc7Ywee4dfBJMWLQfP8/A3ITilJL7Q7gbo6FQtiZHH0MD44RJFl0KCEKbpvkgkdJedBkOqiLlac1kzH5G4C0PoxThvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720738104; c=relaxed/simple;
	bh=XaG/9uIDsbKCKW28ID0XVFdhixA/ARTIJWXk14Wwnio=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=c1idyb98E3MXr6bsQJRgEI6pMJGhde7VE62n8l0g+G6oafoFob3701puI0zqdv+1ZukXmxR1b+mwwh+VCFDvHnIobZ8H3J+C3VL8EhM92Nwl936ZVEtrkfiFr8OY0p4iibNprQ1/9kC4SATww2B62sJ4BKEUQjiGcxhn3v0or8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7fc9fc043eeso141051739f.3
        for <netdev@vger.kernel.org>; Thu, 11 Jul 2024 15:48:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720738101; x=1721342901;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kUq4mFKYDUuOJA1So/dtgBjRUV3ymcjMLfVqKXZl6wE=;
        b=rXcj23cIWnWRBxbcTG5P1pA7LwTDcYjUgA7yDCme5zTH6WEYeMmx0ZzZN10aqCdalB
         naiOXVFTmVbE/HRVxwozFBdmgqzHpD//Y8KehRTMoa0bAibl2hz2SZZPGTR+O/NHVUqE
         PxccYwB6ffnnRXw4IHmHeoKfzcKcsNSgkCHx8l8CwitnJEZ22wjdg0bl7pDMpZdG9O4X
         6pHQpTnw+A8FaagdUpJ9ixRMmY1pa8NZq9EzibJ1aMYoQl6IYZE8dy3ORUlMzkKkh80+
         nF0E4IW8mW0WLOrdfHvK39njEw7Pn3H+MEe4uWCiFIeP8TtH18YboCaQr3DJPBM9A0UW
         9XEA==
X-Forwarded-Encrypted: i=1; AJvYcCV6cLkO5Kf7h2FkW7e0w44kUx8qU/dz6WzKLvwAyDSyzRevk2XPCKet2gj6XCW0EEwYQKDRQkP0wArz1Ir4zRxnGqv3yvL4
X-Gm-Message-State: AOJu0YyoSxXeYTf6rH2pVPr5pkNK0VDpQ4GcYvhA8Uqy8QD3D2TyJWYz
	YsHLWzllMVViUxVekqUqPN8bqY2KLE74svWkqH/rSrc0/Mt/RYv2fJAE+ykqlzhYsDW+rlhX16p
	oi2NhHGj34APihdNsNmJ2yPKcyMmHjvyhUohQHcWkRqrrM++sp8GvtHw=
X-Google-Smtp-Source: AGHT+IEGY5HGsKCLCrGxeW/vnGc1Gjxmoz4d0jso6m89axV4BRpLjEuLu5o+X05VTUEG92vLDeh3Us4hhN+zvpd9+Z/1f/bVTFjc
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:150d:b0:4b9:13c9:b0fb with SMTP id
 8926c6da1cb9f-4c0b2b78063mr598164173.5.1720738101184; Thu, 11 Jul 2024
 15:48:21 -0700 (PDT)
Date: Thu, 11 Jul 2024 15:48:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000045dc6e061d008fff@google.com>
Subject: [syzbot] [net?] INFO: task hung in cleanup_net (7)
From: syzbot <syzbot+09e91cb5dd034b2d3ad4@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c6653f49e4fd Merge tag 'powerpc-6.10-4' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16e85369980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=864caee5f78cab51
dashboard link: https://syzkaller.appspot.com/bug?extid=09e91cb5dd034b2d3ad4
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/883870bfa71b/disk-c6653f49.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f2d0f532ed6a/vmlinux-c6653f49.xz
kernel image: https://storage.googleapis.com/syzbot-assets/14f12438424f/bzImage-c6653f49.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+09e91cb5dd034b2d3ad4@syzkaller.appspotmail.com

INFO: task kworker/u8:6:1040 blocked for more than 143 seconds.
      Not tainted 6.10.0-rc6-syzkaller-00223-gc6653f49e4fd #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u8:6    state:D stack:22248 pid:1040  tgid:1040  ppid:2      flags:0x00004000
Workqueue: netns cleanup_net
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5408 [inline]
 __schedule+0x17e8/0x4a20 kernel/sched/core.c:6745
 __schedule_loop kernel/sched/core.c:6822 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6837
 schedule_timeout+0xb0/0x310 kernel/time/timer.c:2557
 do_wait_for_common kernel/sched/completion.c:95 [inline]
 __wait_for_common kernel/sched/completion.c:116 [inline]
 wait_for_common kernel/sched/completion.c:127 [inline]
 wait_for_completion+0x355/0x620 kernel/sched/completion.c:148
 __flush_work+0xaa9/0xd00 kernel/workqueue.c:4227
 flush_all_backlogs net/core/dev.c:6000 [inline]
 unregister_netdevice_many_notify+0x8a0/0x16b0 net/core/dev.c:11201
 cleanup_net+0x75d/0xcc0 net/core/net_namespace.c:635
 process_one_work kernel/workqueue.c:3248 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3329
 worker_thread+0x86d/0xd50 kernel/workqueue.c:3409
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
INFO: task kworker/u8:9:2843 blocked for more than 144 seconds.
      Not tainted 6.10.0-rc6-syzkaller-00223-gc6653f49e4fd #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u8:9    state:D
 stack:23640 pid:2843  tgid:2843  ppid:2      flags:0x00004000
Workqueue: ipv6_addrconf addrconf_dad_work

Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5408 [inline]
 __schedule+0x17e8/0x4a20 kernel/sched/core.c:6745
 __schedule_loop kernel/sched/core.c:6822 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6837
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6894
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a4/0xd70 kernel/locking/mutex.c:752
 addrconf_dad_work+0xd0/0x16f0 net/ipv6/addrconf.c:4193
 process_one_work kernel/workqueue.c:3248 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3329
 worker_thread+0x86d/0xd50 kernel/workqueue.c:3409
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
INFO: task kworker/1:2:2932 blocked for more than 145 seconds.
      Not tainted 6.10.0-rc6-syzkaller-00223-gc6653f49e4fd #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/1:2     state:D stack:25272 pid:2932  tgid:2932  ppid:2      flags:0x00004000
Workqueue: events request_firmware_work_func
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5408 [inline]
 __schedule+0x17e8/0x4a20 kernel/sched/core.c:6745
 __schedule_loop kernel/sched/core.c:6822 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6837
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6894
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a4/0xd70 kernel/locking/mutex.c:752
 regdb_fw_cb+0x82/0x1c0 net/wireless/reg.c:1017
 request_firmware_work_func+0x1a4/0x280 drivers/base/firmware_loader/main.c:1167
 process_one_work kernel/workqueue.c:3248 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3329
 worker_thread+0x86d/0xd50 kernel/workqueue.c:3409
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
INFO: task dhcpcd:4760 blocked for more than 146 seconds.
      Not tainted 6.10.0-rc6-syzkaller-00223-gc6653f49e4fd #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:dhcpcd          state:D stack:20384 pid:4760  tgid:4760  ppid:4759   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5408 [inline]
 __schedule+0x17e8/0x4a20 kernel/sched/core.c:6745
 __schedule_loop kernel/sched/core.c:6822 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6837
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6894
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a4/0xd70 kernel/locking/mutex.c:752
 rtnl_lock net/core/rtnetlink.c:79 [inline]
 rtnetlink_rcv_msg+0x842/0x1180 net/core/rtnetlink.c:6632
 netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2564
 netlink_unicast_kernel net/netlink/af_netlink.c:1335 [inline]
 netlink_unicast+0x7ea/0x980 net/netlink/af_netlink.c:1361
 netlink_sendmsg+0x8db/0xcb0 net/netlink/af_netlink.c:1905
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:745
 ____sys_sendmsg+0x525/0x7d0 net/socket.c:2585
 ___sys_sendmsg net/socket.c:2639 [inline]
 __sys_sendmsg+0x2b0/0x3a0 net/socket.c:2668
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fbaa016fa4b
RSP: 002b:00007ffecf670818 EFLAGS: 00000246
 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007fbaa00976c0 RCX: 00007fbaa016fa4b
RDX: 0000000000000000 RSI: 00007ffecf6849c8 RDI: 0000000000000010
RBP: 0000000000000010 R08: 0000000000000000 R09: 00007ffecf6849c8
R10: 0000000000000000 R11: 0000000000000246 R12: ffffffffffffffff
R13: 00007ffecf6849c8 R14: 0000000000000030 R15: 0000000000000001
 </TASK>
INFO: task kworker/1:4:5146 blocked for more than 147 seconds.
      Not tainted 6.10.0-rc6-syzkaller-00223-gc6653f49e4fd #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/1:4     state:D
 stack:24872 pid:5146  tgid:5146  ppid:2      flags:0x00004000
Workqueue: events linkwatch_event

Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5408 [inline]
 __schedule+0x17e8/0x4a20 kernel/sched/core.c:6745
 __schedule_loop kernel/sched/core.c:6822 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6837
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6894
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a4/0xd70 kernel/locking/mutex.c:752
 linkwatch_event+0xe/0x60 net/core/link_watch.c:276
 process_one_work kernel/workqueue.c:3248 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3329
 worker_thread+0x86d/0xd50 kernel/workqueue.c:3409
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
INFO: task udevd:5147 blocked for more than 148 seconds.
      Not tainted 6.10.0-rc6-syzkaller-00223-gc6653f49e4fd #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:udevd           state:D
 stack:24864 pid:5147  tgid:5147  ppid:4546   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5408 [inline]
 __schedule+0x17e8/0x4a20 kernel/sched/core.c:6745
 __schedule_loop kernel/sched/core.c:6822 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6837
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6894
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a4/0xd70 kernel/locking/mutex.c:752
 device_lock include/linux/device.h:1009 [inline]
 uevent_show+0x17d/0x340 drivers/base/core.c:2743
 dev_attr_show+0x55/0xc0 drivers/base/core.c:2437
 sysfs_kf_seq_show+0x331/0x4c0 fs/sysfs/file.c:59
 seq_read_iter+0x445/0xd60 fs/seq_file.c:230
 new_sync_read fs/read_write.c:395 [inline]
 vfs_read+0x9bd/0xbc0 fs/read_write.c:476
 ksys_read+0x1a0/0x2c0 fs/read_write.c:619
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f8f25168b6a
RSP: 002b:00007ffcd09cdd58 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 0000557c6193d2c0 RCX: 00007f8f25168b6a
RDX: 0000000000001000 RSI: 0000557c6192d930 RDI: 0000000000000008
RBP: 0000557c6193d2c0 R08: 0000000000000008 R09: 0000000000000008
R10: 000000000000010f R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000003fff R14: 00007ffcd09ce238 R15: 000000000000000a
 </TASK>
INFO: task kworker/1:6:5153 blocked for more than 148 seconds.
      Not tainted 6.10.0-rc6-syzkaller-00223-gc6653f49e4fd #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/1:6     state:D stack:20976 pid:5153  tgid:5153  ppid:2      flags:0x00004000
Workqueue: events switchdev_deferred_process_work
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5408 [inline]
 __schedule+0x17e8/0x4a20 kernel/sched/core.c:6745
 __schedule_loop kernel/sched/core.c:6822 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6837
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6894
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a4/0xd70 kernel/locking/mutex.c:752
 switchdev_deferred_process_work+0xe/0x20 net/switchdev/switchdev.c:104
 process_one_work kernel/workqueue.c:3248 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3329
 worker_thread+0x86d/0xd50 kernel/workqueue.c:3409
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
INFO: task syz.3.10:5176 blocked for more than 149 seconds.
      Not tainted 6.10.0-rc6-syzkaller-00223-gc6653f49e4fd #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.3.10        state:D
 stack:23776 pid:5176  tgid:5175  ppid:5109   flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5408 [inline]
 __schedule+0x17e8/0x4a20 kernel/sched/core.c:6745
 __schedule_loop kernel/sched/core.c:6822 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6837
 schedule_timeout+0xb0/0x310 kernel/time/timer.c:2557
 do_wait_for_common kernel/sched/completion.c:95 [inline]
 __wait_for_common kernel/sched/completion.c:116 [inline]
 wait_for_common kernel/sched/completion.c:127 [inline]
 wait_for_completion+0x355/0x620 kernel/sched/completion.c:148
 __flush_work+0xaa9/0xd00 kernel/workqueue.c:4227
 __lru_add_drain_all+0x4f6/0x560 mm/swap.c:902
 madvise_collapse+0x24b/0xcf0 mm/khugepaged.c:2712
 madvise_vma_behavior mm/madvise.c:1094 [inline]
 madvise_walk_vmas mm/madvise.c:1268 [inline]
 do_madvise+0xc5f/0x4590 mm/madvise.c:1464
 __do_sys_madvise mm/madvise.c:1481 [inline]
 __se_sys_madvise mm/madvise.c:1479 [inline]
 __x64_sys_madvise+0xa6/0xc0 mm/madvise.c:1479
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd40bb75bd9
RSP: 002b:00007fd40c8d1048 EFLAGS: 00000246
 ORIG_RAX: 000000000000001c
RAX: ffffffffffffffda RBX: 00007fd40bd03f60 RCX: 00007fd40bb75bd9
RDX: 0000000000000019 RSI: 0000000000600003 RDI: 0000000020000000
RBP: 00007fd40bbe4aa1 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007fd40bd03f60 R15: 00007fd40be2fa68
 </TASK>
INFO: task syz-executor:5178 blocked for more than 150 seconds.
      Not tainted 6.10.0-rc6-syzkaller-00223-gc6653f49e4fd #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:25840 pid:5178  tgid:5178  ppid:1      flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5408 [inline]
 __schedule+0x17e8/0x4a20 kernel/sched/core.c:6745
 __schedule_loop kernel/sched/core.c:6822 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6837
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6894
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a4/0xd70 kernel/locking/mutex.c:752
 ip_tunnel_init_net+0x20e/0x710 net/ipv4/ip_tunnel.c:1159
 ops_init+0x359/0x610 net/core/net_namespace.c:139
 setup_net+0x515/0xca0 net/core/net_namespace.c:343
 copy_net_ns+0x4e2/0x7b0 net/core/net_namespace.c:508
 create_new_namespaces+0x425/0x7b0 kernel/nsproxy.c:110
 unshare_nsproxy_namespaces+0x124/0x180 kernel/nsproxy.c:228
 ksys_unshare+0x619/0xc10 kernel/fork.c:3323
 __do_sys_unshare kernel/fork.c:3394 [inline]
 __se_sys_unshare kernel/fork.c:3392 [inline]
 __x64_sys_unshare+0x38/0x40 kernel/fork.c:3392
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb0b9177337
RSP: 002b:00007fb0b942ffa8 EFLAGS: 00000206 ORIG_RAX: 0000000000000110
RAX: ffffffffffffffda RBX: 00007fb0b91e4be6 RCX: 00007fb0b9177337
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000040000000
RBP: 0000000000000000 R08: 00007fb0b9e37d60 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000206 R12: 000000000000000c
R13: 0000000000000003 R14: 0000000000000009 R15: 0000000000000009
 </TASK>
INFO: task syz.0.11:5180 blocked for more than 151 seconds.
      Not tainted 6.10.0-rc6-syzkaller-00223-gc6653f49e4fd #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.0.11        state:D stack:24912 pid:5180  tgid:5180  ppid:5111   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5408 [inline]
 __schedule+0x17e8/0x4a20 kernel/sched/core.c:6745
 __schedule_loop kernel/sched/core.c:6822 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6837
 schedule_timeout+0xb0/0x310 kernel/time/timer.c:2557
 do_wait_for_common kernel/sched/completion.c:95 [inline]
 __wait_for_common kernel/sched/completion.c:116 [inline]
 wait_for_common kernel/sched/completion.c:127 [inline]
 wait_for_completion+0x355/0x620 kernel/sched/completion.c:148
 __synchronize_srcu+0x357/0x400 kernel/rcu/srcutree.c:1396
 nbd_clear_que drivers/block/nbd.c:960 [inline]
 nbd_clear_sock drivers/block/nbd.c:1335 [inline]
 nbd_config_put+0x3d2/0x7e0 drivers/block/nbd.c:1358
 nbd_release+0x10b/0x130 drivers/block/nbd.c:1653
 bdev_release+0x5e3/0x700
 blkdev_release+0x15/0x20 block/fops.c:623
 __fput+0x24a/0x8a0 fs/file_table.c:422
 task_work_run+0x24f/0x310 kernel/task_work.c:180
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0xa27/0x27e0 kernel/exit.c:876
 do_group_exit+0x207/0x2c0 kernel/exit.c:1025
 get_signal+0x16a1/0x1740 kernel/signal.c:2909
 arch_do_signal_or_restart+0x96/0x860 arch/x86/kernel/signal.c:310
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0xc9/0x360 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f492bfa7bc5
RSP: 002b:00007f492c22fae0 EFLAGS: 00000293 ORIG_RAX: 00000000000000e6
RAX: 0000000000000000 RBX: 00007f492c103f60 RCX: 00007f492bfa7bc5
RDX: 00007f492c22fb20 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 00007f492c105a60 R08: 0000000000000000 R09: 7fffffffffffffff
R10: 0000000000000000 R11: 0000000000000293 R12: 000000000001769b
R13: 000000000000015e R14: 00007f492c105a60 R15: 00007f492c22fc30
 </TASK>
Future hung task reports are suppressed, see sysctl kernel.hung_task_warnings

Showing all locks held in the system:
2 locks held by kworker/0:1/9:
5 locks held by kworker/u8:0/11:
 #0: ffff8880b953e798 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:559
 #1: 
ffff8880b9528948
 (


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

