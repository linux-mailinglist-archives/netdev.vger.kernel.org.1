Return-Path: <netdev+bounces-132384-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21AB3991789
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 16:57:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA691282DC7
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 14:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C59B6154C14;
	Sat,  5 Oct 2024 14:57:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB8114EC62
	for <netdev@vger.kernel.org>; Sat,  5 Oct 2024 14:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728140243; cv=none; b=kCBGsPddytSpqXjrKKW1l5JU+Gl51nwdreIPYkWTGV5z8XY+thnfvvw0kspOEUQk0kBS1jvFIk/tJpY3h2YZpMhHXKG+G0Mx6a4Ccjr+KSGdvun7k15IVghygc7VjrNFWiDytx0zdoXvXudb/vsj19xFo8wlVCmCnHGBs6w95ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728140243; c=relaxed/simple;
	bh=Amn1d89GWrx13G/qoOYFEWLp0Dxb65nxSVBtRXL/Nlo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=kSE0PEhlHbVHNxnK2BWSAk25o3v/jAX9go2caXCdaF5exLEinG1oA7i/zS1deTEqsv2rHZWr7tYqKKjBPs3stUmAkUipDi99BPDLtjw39zcrmTwRTGV/4ucPZ7yF2iaLNhz8Ig0TfV4dEVAwAfaQaQfM6ajRFq2O6uImAjQsGYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a34988d6b4so52548985ab.2
        for <netdev@vger.kernel.org>; Sat, 05 Oct 2024 07:57:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728140241; x=1728745041;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qHTRIFu/8IE1/DOA3Dwldh1JTRSYUehSo6tALYa8XlA=;
        b=tAtNssiQOJx31PQ8FWHoLNoEQw3eGT8V2CEbC7m2wvQUV/mEHIUvQTmZVJDRVZVIr8
         JfAAUk2SP3PaW5tm40k1x0ivMovxYmoGknxASfPj5gGNg6bUMXEcn+7mf6Pl8tTFBCNH
         WM68tWAPdJnxtFeMqQow9fiZVcX4dFbkfcXt6zPKkw0XcPwkRVBw25m/O6Jc3NsYVYpw
         HDd122NPuf68L2ZgzL/4BjQK6QSPYKSrf57MlwmamoAcIKbk5W5rjxgsbgAlbju+bE2O
         AeyLARX19Jm76K+FuJ4PLEZEiSNKxnPc+72pqyA5ng784u0cU08JzfYiwZzzkm+YhwkK
         Fptg==
X-Forwarded-Encrypted: i=1; AJvYcCUzw3PG0G76aa7H4IsvPzJKBUU9XeJf2Gwd31UxIRiaMH+doDU2B37fZDu1+4mzi4N5pbLo+P0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ0CuBn7S0Y0bzWhUlaO9piHQiVAtJCg9qmhK0uJgFQfZknPRJ
	CnP//GWiFzyx7V+r1Ln/KvnnQs5iipywQgM+eCaMSFznpWIBBfldl9lCRdJFenQ8gexRK33t8g0
	cE9+3dwJTK8/5n41UB6hzZhDdNhA5K4OmOJ8ANIWwZ2HmwUkyKRhwODo=
X-Google-Smtp-Source: AGHT+IF0tbXa2agtJzVoMSAtlIzufX9iOlrlfl4FljVQ2G+CcTyW5QcF0mbaeDcJk/f2CR1yyNJkLNjOr17P1vGR+gQ6/Mm/vze7
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c541:0:b0:3a0:9cd5:931c with SMTP id
 e9e14a558f8ab-3a375bb32acmr64371745ab.20.1728140240925; Sat, 05 Oct 2024
 07:57:20 -0700 (PDT)
Date: Sat, 05 Oct 2024 07:57:20 -0700
In-Reply-To: <000000000000aefb4d061e34a346@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <670153d0.050a0220.49194.04c2.GAE@google.com>
Subject: Re: [syzbot] [net?] INFO: task hung in linkwatch_event (4)
From: syzbot <syzbot+2ba2d70f288cf61174e4@syzkaller.appspotmail.com>
To: bsegall@google.com, davem@davemloft.net, dietmar.eggemann@arm.com, 
	edumazet@google.com, jiri@resnulli.us, johannes.berg@intel.com, 
	juri.lelli@redhat.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	mgorman@suse.de, mingo@redhat.com, netdev@vger.kernel.org, pabeni@redhat.com, 
	peterz@infradead.org, rostedt@goodmis.org, syzkaller-bugs@googlegroups.com, 
	vincent.guittot@linaro.org, vschneid@redhat.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    27cc6fdf7201 Merge tag 'linux_kselftest-fixes-6.12-rc2' of..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14c83307980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f95955e3f7b5790c
dashboard link: https://syzkaller.appspot.com/bug?extid=2ba2d70f288cf61174e4
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17363380580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12c83307980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/37ef4deba944/disk-27cc6fdf.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/14e65e12654f/vmlinux-27cc6fdf.xz
kernel image: https://storage.googleapis.com/syzbot-assets/94a9c04c636a/bzImage-27cc6fdf.xz

The issue was bisected to:

commit e8901061ca0cd9acbd3d29d41d16c69c2bfff9f0
Author: Peter Zijlstra <peterz@infradead.org>
Date:   Thu May 23 08:48:09 2024 +0000

    sched: Split DEQUEUE_SLEEP from deactivate_task()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13ce9e80580000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=102e9e80580000
console output: https://syzkaller.appspot.com/x/log.txt?x=17ce9e80580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2ba2d70f288cf61174e4@syzkaller.appspotmail.com
Fixes: e8901061ca0c ("sched: Split DEQUEUE_SLEEP from deactivate_task()")

INFO: task kworker/u8:6:1043 blocked for more than 150 seconds.
      Not tainted 6.12.0-rc1-syzkaller-00306-g27cc6fdf7201 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u8:6    state:D stack:23280 pid:1043  tgid:1043  ppid:2      flags:0x00004000
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
INFO: task syz-executor316:5253 blocked for more than 151 seconds.
      Not tainted 6.12.0-rc1-syzkaller-00306-g27cc6fdf7201 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor316 state:D stack:19120 pid:5253  tgid:5253  ppid:5226   flags:0x00000002
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
RIP: 0033:0x7fb099e0764c
RSP: 002b:00007fb099faf680 EFLAGS: 00000293 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00007fb099fb1080 RCX: 00007fb099e0764c
RDX: 0000000000000028 RSI: 00007fb099fb10d0 RDI: 0000000000000003
RBP: 0000000000000000 R08: 00007fb099faf6d4 R09: 000000000000000c
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000001
R13: 0000000000000000 R14: 00007fb099fb10d0 R15: 0000000000000000
 </TASK>

Showing all locks held in the system:
3 locks held by kworker/0:0/8:
 #0: ffff88801ac80948 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff88801ac80948 ((wq_completion)events){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1850 kernel/workqueue.c:3310
 #1: ffffc900000d7d00 ((work_completion)(&fw_work->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc900000d7d00 ((work_completion)(&fw_work->work)){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1850 kernel/workqueue.c:3310
 #2: ffffffff8fcd1a48 (rtnl_mutex){+.+.}-{3:3}, at: regdb_fw_cb+0x82/0x1c0 net/wireless/reg.c:1017
3 locks held by kworker/u8:0/11:
 #0: ffff88802dba7148 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff88802dba7148 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1850 kernel/workqueue.c:3310
 #1: ffffc90000107d00 ((work_completion)(&(&ifa->dad_work)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc90000107d00 ((work_completion)(&(&ifa->dad_work)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1850 kernel/workqueue.c:3310
 #2: ffffffff8fcd1a48 (rtnl_mutex){+.+.}-{3:3}, at: addrconf_dad_work+0xd0/0x16f0 net/ipv6/addrconf.c:4196
3 locks held by kworker/1:0/25:
 #0: ffff88801ac81948 ((wq_completion)events_power_efficient){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff88801ac81948 ((wq_completion)events_power_efficient){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1850 kernel/workqueue.c:3310
 #1: ffffc900001f7d00 ((reg_check_chans).work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc900001f7d00 ((reg_check_chans).work){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1850 kernel/workqueue.c:3310
 #2: ffffffff8fcd1a48 (rtnl_mutex){+.+.}-{3:3}, at: reg_check_chans_work+0x99/0xfd0 net/wireless/reg.c:2480
1 lock held by khungtaskd/30:
 #0: ffffffff8e937de0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #0: ffffffff8e937de0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffffffff8e937de0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x55/0x2a0 kernel/locking/lockdep.c:6720
6 locks held by kworker/u8:3/52:
6 locks held by kworker/u9:0/54:
 #0: ffff88801eac0948 ((wq_completion)hci0){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff88801eac0948 ((wq_completion)hci0){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1850 kernel/workqueue.c:3310
 #1: ffffc90000bf7d00 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc90000bf7d00 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1850 kernel/workqueue.c:3310
 #2: ffff888073350d80 (&hdev->req_lock){+.+.}-{3:3}, at: hci_cmd_sync_work+0x1ec/0x400 net/bluetooth/hci_sync.c:327
 #3: ffff888073350078 (&hdev->lock){+.+.}-{3:3}, at: hci_abort_conn_sync+0x1ea/0xde0 net/bluetooth/hci_sync.c:5567
 #4: ffffffff8fe3e2e8 (hci_cb_list_lock){+.+.}-{3:3}, at: hci_connect_cfm include/net/bluetooth/hci_core.h:1957 [inline]
 #4: ffffffff8fe3e2e8 (hci_cb_list_lock){+.+.}-{3:3}, at: hci_conn_failed+0x15d/0x300 net/bluetooth/hci_conn.c:1262
 #5: ffffffff8e93d378 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_lock kernel/rcu/tree_exp.h:329 [inline]
 #5: ffffffff8e93d378 (rcu_state.exp_mutex){+.+.}-{3:3}, at: synchronize_rcu_expedited+0x451/0x830 kernel/rcu/tree_exp.h:976
6 locks held by kworker/u8:4/76:
 #0: ffff888020ab3948 ((wq_completion)writeback){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff888020ab3948 ((wq_completion)writeback){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1850 kernel/workqueue.c:3310
 #1: ffffc900020ffd00 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc900020ffd00 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1850 kernel/workqueue.c:3310
 #2: ffff88814cbba0e0 (&type->s_umount_key#33){++++}-{3:3}, at: super_trylock_shared+0x22/0xf0 fs/super.c:562
 #3: ffff88814cbbcb98 (&sbi->s_writepages_rwsem){++++}-{0:0}, at: ext4_writepages_down_read fs/ext4/ext4.h:1772 [inline]
 #3: ffff88814cbbcb98 (&sbi->s_writepages_rwsem){++++}-{0:0}, at: ext4_writepages+0x1bf/0x3c0 fs/ext4/inode.c:2812
 #4: ffff88814cbbe958 (jbd2_handle){++++}-{0:0}, at: start_this_handle+0x1e94/0x2110 fs/jbd2/transaction.c:448
 #5: ffff88807e3c6598 (&ei->i_data_sem){++++}-{3:3}, at: ext4_map_blocks+0x7a3/0x1960 fs/ext4/inode.c:701
3 locks held by kworker/u8:6/1043:
 #0: ffff88801ac89148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff88801ac89148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1850 kernel/workqueue.c:3310
 #1: ffffc90003ee7d00 ((linkwatch_work).work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc90003ee7d00 ((linkwatch_work).work){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1850 kernel/workqueue.c:3310
 #2: ffffffff8fcd1a48 (rtnl_mutex){+.+.}-{3:3}, at: linkwatch_event+0xe/0x60 net/core/link_watch.c:276
2 locks held by syslogd/4668:
4 locks held by udevd/4686:
3 locks held by dhcpcd/4899:
4 locks held by dhcpcd/4900:
2 locks held by getty/4984:
 #0: ffff88802e6e90a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc90002f062f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x6a6/0x1e00 drivers/tty/n_tty.c:2211
5 locks held by kworker/u9:2/5232:
 #0: ffff888027330948 ((wq_completion)hci1){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff888027330948 ((wq_completion)hci1){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1850 kernel/workqueue.c:3310
 #1: ffffc900039efd00 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc900039efd00 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1850 kernel/workqueue.c:3310
 #2: ffff888074f40d80 (&hdev->req_lock){+.+.}-{3:3}, at: hci_cmd_sync_work+0x1ec/0x400 net/bluetooth/hci_sync.c:327
 #3: ffff888074f40078 (&hdev->lock){+.+.}-{3:3}, at: hci_abort_conn_sync+0x1ea/0xde0 net/bluetooth/hci_sync.c:5567
 #4: ffffffff8fe3e2e8 (hci_cb_list_lock){+.+.}-{3:3}, at: hci_connect_cfm include/net/bluetooth/hci_core.h:1957 [inline]
 #4: ffffffff8fe3e2e8 (hci_cb_list_lock){+.+.}-{3:3}, at: hci_conn_failed+0x15d/0x300 net/bluetooth/hci_conn.c:1262
5 locks held by kworker/u9:8/5247:
 #0: ffff88803094c948 ((wq_completion)hci3){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff88803094c948 ((wq_completion)hci3){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1850 kernel/workqueue.c:3310
 #1: ffffc90003be7d00 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc90003be7d00 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1850 kernel/workqueue.c:3310
 #2: ffff888029fd8d80 (&hdev->req_lock){+.+.}-{3:3}, at: hci_cmd_sync_work+0x1ec/0x400 net/bluetooth/hci_sync.c:327
 #3: ffff888029fd8078 (&hdev->lock){+.+.}-{3:3}, at: hci_abort_conn_sync+0x1ea/0xde0 net/bluetooth/hci_sync.c:5567
 #4: ffffffff8fe3e2e8 (hci_cb_list_lock){+.+.}-{3:3}, at: hci_connect_cfm include/net/bluetooth/hci_core.h:1957 [inline]
 #4: ffffffff8fe3e2e8 (hci_cb_list_lock){+.+.}-{3:3}, at: hci_conn_failed+0x15d/0x300 net/bluetooth/hci_conn.c:1262
1 lock held by syz-executor316/5249:
1 lock held by syz-executor316/5250:
 #0: ffffffff8fcd1a48 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8fcd1a48 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x6e6/0xcf0 net/core/rtnetlink.c:6643
1 lock held by syz-executor316/5251:
 #0: ffffffff8fcd1a48 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8fcd1a48 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x6e6/0xcf0 net/core/rtnetlink.c:6643
1 lock held by syz-executor316/5252:
 #0: ffffffff8fcd1a48 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8fcd1a48 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x6e6/0xcf0 net/core/rtnetlink.c:6643
2 locks held by syz-executor316/5253:
4 locks held by udevd/5286:

=============================================

NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 30 Comm: khungtaskd Not tainted 6.12.0-rc1-syzkaller-00306-g27cc6fdf7201 #0
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
CPU: 1 UID: 0 PID: 54 Comm: kworker/u9:0 Not tainted 6.12.0-rc1-syzkaller-00306-g27cc6fdf7201 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: hci0 hci_cmd_sync_work
RIP: 0010:check_preemption_disabled+0xb/0x120 lib/smp_processor_id.c:13
Code: 8c eb 1c 66 2e 0f 1f 84 00 00 00 00 00 66 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 41 57 41 56 41 54 53 48 83 ec 10 <65> 48 8b 04 25 28 00 00 00 48 89 44 24 08 65 8b 1d ac 62 3e 74 65
RSP: 0018:ffffc90000bf72b8 EFLAGS: 00000286
RAX: 0000000000000001 RBX: 0000000000000000 RCX: ffff888020ad5a00
RDX: 0000000000000000 RSI: ffffffff8c60f900 RDI: ffffffff8c60f8c0
RBP: 0000000000000660 R08: ffffffff820b564e R09: 1ffffffff2858b00
R10: dffffc0000000000 R11: fffffbfff2858b01 R12: 000000000019b859
R13: ffffea00066e1648 R14: ffffffff820b5580 R15: ffff88813b080000
FS:  0000000000000000(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000056517d3de72e CR3: 000000007295c000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 rcu_is_watching_curr_cpu include/linux/context_tracking.h:128 [inline]
 rcu_is_watching+0x15/0xb0 kernel/rcu/tree.c:737
 rcu_read_lock_held_common kernel/rcu/update.c:109 [inline]
 rcu_read_lock_held+0x15/0x50 kernel/rcu/update.c:349
 lookup_page_ext mm/page_ext.c:254 [inline]
 page_ext_get+0x192/0x2a0 mm/page_ext.c:526
 __reset_page_owner+0x30/0x430 mm/page_owner.c:290
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1108 [inline]
 free_unref_page+0xcfb/0xf20 mm/page_alloc.c:2638
 discard_slab mm/slub.c:2677 [inline]
 __put_partials+0xeb/0x130 mm/slub.c:3145
 put_cpu_partial+0x17c/0x250 mm/slub.c:3220
 __slab_free+0x2ea/0x3d0 mm/slub.c:4449
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x9a/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x14f/0x170 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x23/0x80 mm/kasan/common.c:329
 kasan_slab_alloc include/linux/kasan.h:247 [inline]
 slab_post_alloc_hook mm/slub.c:4085 [inline]
 slab_alloc_node mm/slub.c:4134 [inline]
 kmem_cache_alloc_node_noprof+0x16b/0x320 mm/slub.c:4186
 __alloc_skb+0x1c3/0x440 net/core/skbuff.c:668
 alloc_skb include/linux/skbuff.h:1322 [inline]
 alloc_uevent_skb+0x74/0x230 lib/kobject_uevent.c:289
 uevent_net_broadcast_untagged lib/kobject_uevent.c:326 [inline]
 kobject_uevent_net_broadcast+0x2fd/0x580 lib/kobject_uevent.c:410
 kobject_uevent_env+0x57d/0x8e0 lib/kobject_uevent.c:608
 device_del+0x7db/0x9b0 drivers/base/core.c:3882
 device_unregister+0x20/0xc0 drivers/base/core.c:3905
 hci_conn_cleanup net/bluetooth/hci_conn.c:174 [inline]
 hci_conn_del+0x8c4/0xc40 net/bluetooth/hci_conn.c:1160
 hci_abort_conn_sync+0x583/0xde0 net/bluetooth/hci_sync.c:5586
 hci_cmd_sync_work+0x22b/0x400 net/bluetooth/hci_sync.c:328
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

