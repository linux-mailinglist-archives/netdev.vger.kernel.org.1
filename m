Return-Path: <netdev+bounces-131390-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AE13398E68A
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 01:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 075A7B20399
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 23:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB87199929;
	Wed,  2 Oct 2024 23:00:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68A919755B
	for <netdev@vger.kernel.org>; Wed,  2 Oct 2024 23:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727910031; cv=none; b=cbu//YwppJdmeqKK+KWNWC/EEMcDDdtoSl0F2/uHpzsLyuyTqHTxjk/5llgn3tGd2i7fY3ypSXiMz0w8wXb7P1cJV4w+UA3z7pG0N4H6zMr3vzWttCdmv+9tNnn56cCtjluWF5CRjcqBa3h98q28SbnTTUvVIEprc89NSdE/U1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727910031; c=relaxed/simple;
	bh=M4RmDjq+m/AwC2RTAfAaprDmhH3oASncAeIlFuzpja8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Uw02pcoYHtxNIQOSEruBWCmn+58/ptYDgvq+Ze9G+RE2+D4ZPqgJuGNSVt6x6I/4sVlUplA4rPZV/QV0Q9IgaLBRCXJ+7qn3kKI5nXGmDuCKPLrKgy6MP39Da/LEktPatXt1Jkkg3MdAYTDu+H30ciYnK9pIGXIoIdYOWSFYlZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-82ced069d94so39686139f.0
        for <netdev@vger.kernel.org>; Wed, 02 Oct 2024 16:00:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727910029; x=1728514829;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bgdniv0HmiIr391SX+vHM3g2bHmXYw49OXhwYo8W6DI=;
        b=hsJk2493O0Rq3cued342ChWpKewc95cvnz+V5XMjQhbp3UeKyK+wxoGY2p2v89CFQB
         ZUADzVEACw6k/oQ+YJARJas3GxKb0KlNItsWPqFuCkPd8HMlS/hhubRs0B0CzNQPlxhU
         HvOyurDsvyM/WXqUmNgd72E9JQphlz5+CdLJIHclJ1J4qpbLxufQZXub8r1hdLr+7v4X
         42ktWvGzHhRlybVlXAjX6rKMUkkTOhMfTTXXQdmnqtz7Se9/dnrC7vuIHntR/0oymIjt
         TmJLmAkhyS+0XDvESVZQjXD+hqlR+x5uaQkHUZudkDOEWaBHhQZZ7CHx0ylr12Mp69E3
         8vIg==
X-Forwarded-Encrypted: i=1; AJvYcCWwDBUatFQPNd0pB20vIeUCNVSuwbJQnkoc6VBaiwk8N2JwUARApMR85v01cHb1EP1NjZHIG3A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+oE+kX7ztNK5VOA1/aqjyxnYp8/WCekVaq61aprAmgnFafq5m
	m1ZsCTVQW6TgjnQLypN0Xx1AR29WHYFSP9nGlYldSWoWBYrPtZCIdp6na7mn2RDzjMsn2B5VOsa
	JyAjQnJFR4MS926kEznEVdlBGPrS6zwGz7qavmGamPfua93GeSykXx3M=
X-Google-Smtp-Source: AGHT+IGYolaHYtqnD33cAy5da6IUOIeqaeXHdNl5I7ukLTsSdV10e9qQBKihp6cTeR8e0oIQ0XrPiGXop8q5d/9Pk3V/yIgFa/pE
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a4e:b0:3a3:41cf:f594 with SMTP id
 e9e14a558f8ab-3a36592aea4mr49580995ab.12.1727910028890; Wed, 02 Oct 2024
 16:00:28 -0700 (PDT)
Date: Wed, 02 Oct 2024 16:00:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66fdd08c.050a0220.40bef.0026.GAE@google.com>
Subject: [syzbot] [net?] INFO: task hung in genl_rcv_msg (4)
From: syzbot <syzbot+85d0bec020d805014a3a@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    e7ed34365879 Merge tag 'mailbox-v6.12' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12067d9f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c9af6222e6678002
dashboard link: https://syzkaller.appspot.com/bug?extid=85d0bec020d805014a3a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/caf1c2797333/disk-e7ed3436.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/94f2d55f85c6/vmlinux-e7ed3436.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ee9ab0ca36d2/bzImage-e7ed3436.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+85d0bec020d805014a3a@syzkaller.appspotmail.com

INFO: task syz.5.230:6022 blocked for more than 143 seconds.
      Not tainted 6.11.0-syzkaller-12113-ge7ed34365879 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.5.230       state:D stack:27136 pid:6022  tgid:6019  ppid:5225   flags:0x00000004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x1895/0x4b30 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6767
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6824
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a7/0xd70 kernel/locking/mutex.c:752
 genl_lock net/netlink/genetlink.c:35 [inline]
 genl_op_lock net/netlink/genetlink.c:60 [inline]
 genl_rcv_msg+0x121/0xec0 net/netlink/genetlink.c:1209
 netlink_rcv_skb+0x1e5/0x430 net/netlink/af_netlink.c:2550
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
 netlink_unicast+0x7f8/0x990 net/netlink/af_netlink.c:1357
 netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1901
 sock_sendmsg_nosec net/socket.c:729 [inline]
 __sock_sendmsg+0x223/0x270 net/socket.c:744
 ____sys_sendmsg+0x52a/0x7e0 net/socket.c:2602
 ___sys_sendmsg net/socket.c:2656 [inline]
 __sys_sendmsg+0x292/0x380 net/socket.c:2685
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f435577dff9
RSP: 002b:00007f43564ab038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f4355936058 RCX: 00007f435577dff9
RDX: 0000000000000000 RSI: 00000000200000c0 RDI: 0000000000000003
RBP: 00007f43557f0296 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007f4355936058 R15: 00007ffe2fc70808
 </TASK>
INFO: task syz.1.234:6050 blocked for more than 144 seconds.
      Not tainted 6.11.0-syzkaller-12113-ge7ed34365879 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.1.234       state:D stack:27392 pid:6050  tgid:6046  ppid:5226   flags:0x00000004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x1895/0x4b30 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6767
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6824
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a7/0xd70 kernel/locking/mutex.c:752
 genl_lock net/netlink/genetlink.c:35 [inline]
 genl_op_lock net/netlink/genetlink.c:60 [inline]
 genl_rcv_msg+0x121/0xec0 net/netlink/genetlink.c:1209
 netlink_rcv_skb+0x1e5/0x430 net/netlink/af_netlink.c:2550
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
 netlink_unicast+0x7f8/0x990 net/netlink/af_netlink.c:1357
 netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1901
 sock_sendmsg_nosec net/socket.c:729 [inline]
 __sock_sendmsg+0x223/0x270 net/socket.c:744
 __sys_sendto+0x39b/0x4f0 net/socket.c:2209
 __do_sys_sendto net/socket.c:2221 [inline]
 __se_sys_sendto net/socket.c:2217 [inline]
 __x64_sys_sendto+0xde/0x100 net/socket.c:2217
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fc9aab7fe8c
RSP: 002b:00007fc9ab94aec0 EFLAGS: 00000293 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00007fc9ab94afc0 RCX: 00007fc9aab7fe8c
RDX: 0000000000000020 RSI: 00007fc9ab94b010 RDI: 0000000000000003
RBP: 0000000000000000 R08: 00007fc9ab94af14 R09: 000000000000000c
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000003
R13: 00007fc9ab94af68 R14: 00007fc9ab94b010 R15: 0000000000000000
 </TASK>
INFO: task syz.3.238:6057 blocked for more than 145 seconds.
      Not tainted 6.11.0-syzkaller-12113-ge7ed34365879 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.3.238       state:D stack:27360 pid:6057  tgid:6056  ppid:5238   flags:0x00000004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x1895/0x4b30 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6767
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6824
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a7/0xd70 kernel/locking/mutex.c:752
 genl_lock net/netlink/genetlink.c:35 [inline]
 genl_op_lock net/netlink/genetlink.c:60 [inline]
 genl_rcv_msg+0x121/0xec0 net/netlink/genetlink.c:1209
 netlink_rcv_skb+0x1e5/0x430 net/netlink/af_netlink.c:2550
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
 netlink_unicast+0x7f8/0x990 net/netlink/af_netlink.c:1357
 netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1901
 sock_sendmsg_nosec net/socket.c:729 [inline]
 __sock_sendmsg+0x223/0x270 net/socket.c:744
 __sys_sendto+0x39b/0x4f0 net/socket.c:2209
 __do_sys_sendto net/socket.c:2221 [inline]
 __se_sys_sendto net/socket.c:2217 [inline]
 __x64_sys_sendto+0xde/0x100 net/socket.c:2217
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fc88857fe8c
RSP: 002b:00007fc889291ec0 EFLAGS: 00000293 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00007fc889291fc0 RCX: 00007fc88857fe8c
RDX: 0000000000000024 RSI: 00007fc889292010 RDI: 0000000000000003
RBP: 0000000000000000 R08: 00007fc889291f14 R09: 000000000000000c
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000003
R13: 00007fc889291f68 R14: 00007fc889292010 R15: 0000000000000000
 </TASK>

Showing all locks held in the system:
4 locks held by kworker/u8:1/12:
 #0: ffff88801bae5948 ((wq_completion)netns){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff88801bae5948 ((wq_completion)netns){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1850 kernel/workqueue.c:3310
 #1: ffffc90000117d00 (net_cleanup_work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc90000117d00 (net_cleanup_work){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1850 kernel/workqueue.c:3310
 #2: ffffffff8fcc4c10 (pernet_ops_rwsem){++++}-{3:3}, at: cleanup_net+0x16a/0xcc0 net/core/net_namespace.c:580
 #3: ffffffff8fcd1708 (rtnl_mutex){+.+.}-{3:3}, at: tc_action_net_exit include/net/act_api.h:173 [inline]
 #3: ffffffff8fcd1708 (rtnl_mutex){+.+.}-{3:3}, at: gate_exit_net+0x30/0x100 net/sched/act_gate.c:659
1 lock held by khungtaskd/30:
 #0: ffffffff8e937de0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #0: ffffffff8e937de0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffffffff8e937de0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x55/0x2a0 kernel/locking/lockdep.c:6720
2 locks held by kworker/u8:2/35:
3 locks held by kworker/u8:3/52:
 #0: ffff88801ac81148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff88801ac81148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1850 kernel/workqueue.c:3310
 #1: ffffc90000bc7d00 ((linkwatch_work).work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc90000bc7d00 ((linkwatch_work).work){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1850 kernel/workqueue.c:3310
 #2: ffffffff8fcd1708 (rtnl_mutex){+.+.}-{3:3}, at: linkwatch_event+0xe/0x60 net/core/link_watch.c:276
2 locks held by dhcpcd/4891:
 #0: ffff8880324c96c8 (nlk_cb_mutex-ROUTE){+.+.}-{3:3}, at: netlink_dump+0xcb/0xd80 net/netlink/af_netlink.c:2271
 #1: ffffffff8fcd1708 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #1: ffffffff8fcd1708 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_dumpit+0x99/0x200 net/core/rtnetlink.c:6505
2 locks held by getty/4979:
 #0: ffff88803249a0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc90002f062f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x6a6/0x1e00 drivers/tty/n_tty.c:2211
6 locks held by kworker/0:6/5298:
3 locks held by kworker/1:7/5403:
 #0: ffff88801ac79948 ((wq_completion)events_power_efficient){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff88801ac79948 ((wq_completion)events_power_efficient){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1850 kernel/workqueue.c:3310
 #1: ffffc9000322fd00 ((crda_timeout).work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc9000322fd00 ((crda_timeout).work){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1850 kernel/workqueue.c:3310
 #2: ffffffff8fcd1708 (rtnl_mutex){+.+.}-{3:3}, at: crda_timeout_work+0x15/0x50 net/wireless/reg.c:540
8 locks held by syz-executor/5663:
 #0: ffff8880325d2420 (sb_writers#8){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:2931 [inline]
 #0: ffff8880325d2420 (sb_writers#8){.+.+}-{0:0}, at: vfs_write+0x224/0xc90 fs/read_write.c:679
 #1: ffff88807883dc88 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_write_iter+0x1ea/0x500 fs/kernfs/file.c:325
 #2: ffff88802778c5a8 (kn->active#49){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x20e/0x500 fs/kernfs/file.c:326
 #3: ffffffff8f56f788 (nsim_bus_dev_list_lock){+.+.}-{3:3}, at: del_device_store+0xfc/0x480 drivers/net/netdevsim/bus.c:216
 #4: ffff88805afb90e8 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #4: ffff88805afb90e8 (&dev->mutex){....}-{3:3}, at: __device_driver_lock drivers/base/dd.c:1095 [inline]
 #4: ffff88805afb90e8 (&dev->mutex){....}-{3:3}, at: device_release_driver_internal+0xce/0x7c0 drivers/base/dd.c:1293
 #5: ffff88805afba250 (&devlink->lock_key#6){+.+.}-{3:3}, at: nsim_drv_remove+0x50/0x160 drivers/net/netdevsim/dev.c:1672
 #6: ffffffff8fcd1708 (rtnl_mutex){+.+.}-{3:3}, at: nsim_destroy+0x71/0x5c0 drivers/net/netdevsim/netdev.c:773
 #7: ffffffff8e7d1dd0 (cpu_hotplug_lock){++++}-{0:0}, at: flush_all_backlogs net/core/dev.c:6021 [inline]
 #7: ffffffff8e7d1dd0 (cpu_hotplug_lock){++++}-{0:0}, at: unregister_netdevice_many_notify+0x5ea/0x1da0 net/core/dev.c:11380
3 locks held by syz.5.230/6020:
 #0: ffffffff8fd37470 (cb_lock){++++}-{3:3}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1218
 #1: ffffffff8fd37328 (genl_mutex){+.+.}-{3:3}, at: genl_lock net/netlink/genetlink.c:35 [inline]
 #1: ffffffff8fd37328 (genl_mutex){+.+.}-{3:3}, at: genl_op_lock net/netlink/genetlink.c:60 [inline]
 #1: ffffffff8fd37328 (genl_mutex){+.+.}-{3:3}, at: genl_rcv_msg+0x121/0xec0 net/netlink/genetlink.c:1209
 #2: ffffffff8fcd1708 (rtnl_mutex){+.+.}-{3:3}, at: ieee80211_register_hw+0x312b/0x3e10 net/mac80211/main.c:1584
2 locks held by syz.5.230/6022:
 #0: ffffffff8fd37470 (cb_lock){++++}-{3:3}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1218
 #1: ffffffff8fd37328 (genl_mutex){+.+.}-{3:3}, at: genl_lock net/netlink/genetlink.c:35 [inline]
 #1: ffffffff8fd37328 (genl_mutex){+.+.}-{3:3}, at: genl_op_lock net/netlink/genetlink.c:60 [inline]
 #1: ffffffff8fd37328 (genl_mutex){+.+.}-{3:3}, at: genl_rcv_msg+0x121/0xec0 net/netlink/genetlink.c:1209
2 locks held by syz.1.234/6050:
 #0: ffffffff8fd37470 (cb_lock){++++}-{3:3}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1218
 #1: ffffffff8fd37328 (genl_mutex){+.+.}-{3:3}, at: genl_lock net/netlink/genetlink.c:35 [inline]
 #1: ffffffff8fd37328 (genl_mutex){+.+.}-{3:3}, at: genl_op_lock net/netlink/genetlink.c:60 [inline]
 #1: ffffffff8fd37328 (genl_mutex){+.+.}-{3:3}, at: genl_rcv_msg+0x121/0xec0 net/netlink/genetlink.c:1209
2 locks held by syz.3.238/6057:
 #0: ffffffff8fd37470 (cb_lock){++++}-{3:3}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1218
 #1: ffffffff8fd37328 (genl_mutex){+.+.}-{3:3}, at: genl_lock net/netlink/genetlink.c:35 [inline]
 #1: ffffffff8fd37328 (genl_mutex){+.+.}-{3:3}, at: genl_op_lock net/netlink/genetlink.c:60 [inline]
 #1: ffffffff8fd37328 (genl_mutex){+.+.}-{3:3}, at: genl_rcv_msg+0x121/0xec0 net/netlink/genetlink.c:1209
1 lock held by syz.0.239/6060:
 #0: ffffffff8fcd1708 (rtnl_mutex){+.+.}-{3:3}, at: tun_detach drivers/net/tun.c:698 [inline]
 #0: ffffffff8fcd1708 (rtnl_mutex){+.+.}-{3:3}, at: tun_chr_close+0x3b/0x1b0 drivers/net/tun.c:3517
1 lock held by syz-executor/6106:
 #0: ffffffff8fcd1708 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8fcd1708 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x6e6/0xcf0 net/core/rtnetlink.c:6643
2 locks held by syz-executor/6112:
 #0: ffffffff8fcc4c10 (pernet_ops_rwsem){++++}-{3:3}, at: copy_net_ns+0x328/0x570 net/core/net_namespace.c:490
 #1: ffffffff8fcd1708 (rtnl_mutex){+.+.}-{3:3}, at: ip_tunnel_init_net+0x20e/0x720 net/ipv4/ip_tunnel.c:1159
2 locks held by syz-executor/6117:
 #0: ffffffff8fcc4c10 (pernet_ops_rwsem){++++}-{3:3}, at: copy_net_ns+0x328/0x570 net/core/net_namespace.c:490
 #1: ffffffff8fcd1708 (rtnl_mutex){+.+.}-{3:3}, at: register_nexthop_notifier+0x84/0x290 net/ipv4/nexthop.c:3885
2 locks held by syz-executor/6120:
 #0: ffffffff8fcc4c10 (pernet_ops_rwsem){++++}-{3:3}, at: copy_net_ns+0x328/0x570 net/core/net_namespace.c:490
 #1: ffffffff8fcd1708 (rtnl_mutex){+.+.}-{3:3}, at: register_nexthop_notifier+0x84/0x290 net/ipv4/nexthop.c:3885
2 locks held by syz-executor/6123:
 #0: ffffffff8fcc4c10 (pernet_ops_rwsem){++++}-{3:3}, at: copy_net_ns+0x328/0x570 net/core/net_namespace.c:490
 #1: ffffffff8fcd1708 (rtnl_mutex){+.+.}-{3:3}, at: register_nexthop_notifier+0x84/0x290 net/ipv4/nexthop.c:3885
2 locks held by syz-executor/6126:
 #0: ffffffff8fcc4c10 (pernet_ops_rwsem){++++}-{3:3}, at: copy_net_ns+0x328/0x570 net/core/net_namespace.c:490
 #1: ffffffff8fcd1708 (rtnl_mutex){+.+.}-{3:3}, at: register_nexthop_notifier+0x84/0x290 net/ipv4/nexthop.c:3885

=============================================

NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 30 Comm: khungtaskd Not tainted 6.11.0-syzkaller-12113-ge7ed34365879 #0
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
 kthread+0x2f2/0x390 kernel/kthread.c:389
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 5298 Comm: kworker/0:6 Not tainted 6.11.0-syzkaller-12113-ge7ed34365879 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: events nsim_dev_trap_report_work
RIP: 0010:_raw_spin_unlock_irqrestore+0x67/0x140 kernel/locking/spinlock.c:193
Code: c7 04 24 b3 8a b5 41 48 c7 44 24 08 2a f1 08 8e 48 c7 44 24 10 20 03 cf 8b 49 89 e5 49 c1 ed 03 48 b8 f1 f1 f1 f1 00 f3 f3 f3 <4b> 89 44 25 00 48 83 c7 18 48 8b 75 08 e8 77 67 a1 f5 48 89 df e8
RSP: 0018:ffffc90000006f20 EFLAGS: 00000016
RAX: f3f3f300f1f1f1f1 RBX: ffffffff9a6128c8 RCX: 0000000000000001
RDX: dffffc0000000000 RSI: 0000000000000246 RDI: ffffffff9a6128c8
RBP: ffffc90000006fb0 R08: 0000000000000003 R09: fffff52000000dd4
R10: dffffc0000000000 R11: fffff52000000dd4 R12: dffffc0000000000
R13: 1ffff92000000de4 R14: ffffc90000006f40 R15: 0000000000000246
FS:  0000000000000000(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b3251bff8 CR3: 000000000e734000 CR4: 0000000000350ef0
Call Trace:
 <NMI>
 </NMI>
 <IRQ>
 __debug_check_no_obj_freed lib/debugobjects.c:998 [inline]
 debug_check_no_obj_freed+0x561/0x580 lib/debugobjects.c:1019
 slab_free_hook mm/slub.c:2274 [inline]
 slab_free mm/slub.c:4580 [inline]
 kmem_cache_free+0x11f/0x420 mm/slub.c:4682
 nft_synproxy_eval_v4+0x3d2/0x610 net/netfilter/nft_synproxy.c:60
 nft_synproxy_do_eval+0x362/0xa60 net/netfilter/nft_synproxy.c:141
 expr_call_ops_eval net/netfilter/nf_tables_core.c:240 [inline]
 nft_do_chain+0x4af/0x1da0 net/netfilter/nf_tables_core.c:288
 nft_do_chain_inet+0x418/0x6b0 net/netfilter/nft_chain_filter.c:161
 nf_hook_entry_hookfn include/linux/netfilter.h:154 [inline]
 nf_hook_slow+0xc5/0x220 net/netfilter/core.c:626
 nf_hook include/linux/netfilter.h:269 [inline]
 NF_HOOK+0x29e/0x450 include/linux/netfilter.h:312
 NF_HOOK+0x3a6/0x450 include/linux/netfilter.h:314
 __netif_receive_skb_one_core net/core/dev.c:5662 [inline]
 __netif_receive_skb+0x2bf/0x650 net/core/dev.c:5775
 process_backlog+0x662/0x15b0 net/core/dev.c:6107
 __napi_poll+0xcd/0x490 net/core/dev.c:6771
 napi_poll net/core/dev.c:6840 [inline]
 net_rx_action+0x89b/0x1240 net/core/dev.c:6962
 handle_softirqs+0x2c7/0x980 kernel/softirq.c:554
 do_softirq+0x11b/0x1e0 kernel/softirq.c:455
 </IRQ>
 <TASK>
 __local_bh_enable_ip+0x1bb/0x200 kernel/softirq.c:382
 spin_unlock_bh include/linux/spinlock.h:396 [inline]
 nsim_dev_trap_report drivers/net/netdevsim/dev.c:820 [inline]
 nsim_dev_trap_report_work+0x75d/0xaa0 drivers/net/netdevsim/dev.c:850
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa65/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f2/0x390 kernel/kthread.c:389
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
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

