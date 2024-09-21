Return-Path: <netdev+bounces-129146-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3370597DDC7
	for <lists+netdev@lfdr.de>; Sat, 21 Sep 2024 18:08:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D782B281F64
	for <lists+netdev@lfdr.de>; Sat, 21 Sep 2024 16:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D213175D36;
	Sat, 21 Sep 2024 16:08:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9591741D1
	for <netdev@vger.kernel.org>; Sat, 21 Sep 2024 16:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726934898; cv=none; b=rDwmf3LKbarH/0Xe9RYwPEA6vHwgJDpSDH75l+LVmCDQ6zrXgsFsz83VZqxsdIj4pgvaXCIV129gQ8fGq5c9uDSDCvoSEIi9lm5+qt44Tal3D5BaTEyW4J5X8bak6drq5fVnZEd9Dlf+4+fO75g62xYySh9xfYJdlZTvYCMemnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726934898; c=relaxed/simple;
	bh=rwQDDvK1aYbAWQyf+pxmQ1YXtNpGbqz6+F9QlqHHIoU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=GP8NKGpudpRaealSbT5BKLT3pa0MAADcKrq99XxaWspOrHmq065tc6AeIuIZe6d3uZqku/u0GwgJpGgKKLZfsrpbgHNUa2bp+uFPMSsk3VN6MhF93OZcSwCqbUuWaxD+Ds9jlFN8c+pUSIc+FgnxorGlxXlzPSF2aQQwgV6YJM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-82ad9fca5fcso307573639f.0
        for <netdev@vger.kernel.org>; Sat, 21 Sep 2024 09:08:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726934896; x=1727539696;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TMPzEZA+jiiFNWv6oTQDqyO2iJBBSOEv+R8OJTOWkE0=;
        b=MHoEzMuH2z6Oeu6K/va2JcZYI+tazJ1ehLt/NEZEhcxIN7VxSVFvStl+trlpTjMYVA
         9JaN1M9yMHAFehHasW2bX2vLygJmNve+O3VC5+TXefeJ1Ly0gKwPzYn4oucnbQZdQkcI
         Yj4RtnNYWi+cQipumScMSHZZHYSmrFGPhgnXoHE+T1irpYbUR9tON2EqiB7hmbCkYYjU
         8glDKlKpSxX51mQqZvOafGsvE3NqHmdHW4sFiex2VYerEXRITIl8RFwJ+HyRwdaC5ipj
         xaQ4iQQAA0wY+wN75BzU5l5BCarUd9b4H4l1QhdSx1pF7995vXkJey2zaoB0Ga6p8OPw
         Nr0w==
X-Forwarded-Encrypted: i=1; AJvYcCUVeCY2CTo/ayvBEBsdx5T8Veq8RPAKaRbLXcgJRq22GlbWTjeu/aH66geHtpe1J78HglNjka4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+XlOwx0zC4vNhGbwy5M7VcCikOtagVIiDppgNuTbQVo+tB5ib
	xwXD3B/jSrHSOLuJ/mqJZCIJ41218SBIhI/mr1LAMiWAMj72UxtvclkXcGD4RKUNPMcU6cK66Tq
	GFoAGsApKJXi54AYeGWRCw29AM+ozYOrroIlEoKd/mb1H5wf1gALLfEA=
X-Google-Smtp-Source: AGHT+IHl/3F+fxm9CYu6LftPEpZDf6aSjAgl3kKbSSiAH3rhMb9OKSpXbgD4iOxTd08zSr5D2+GSzFoja79rWIDr6hHGeQTebK3S
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1383:b0:3a0:92e5:af68 with SMTP id
 e9e14a558f8ab-3a0c8cc9ef9mr52598595ab.15.1726934895866; Sat, 21 Sep 2024
 09:08:15 -0700 (PDT)
Date: Sat, 21 Sep 2024 09:08:15 -0700
In-Reply-To: <00000000000020c8d0061e647124@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66eeef6f.050a0220.3195df.0060.GAE@google.com>
Subject: Re: [syzbot] [net?] INFO: task hung in addrconf_dad_work (5)
From: syzbot <syzbot+82ccd564344eeaa5427d@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    1868f9d0260e Merge tag 'for-linux-6.12-ofs1' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17a5ac27980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d0b35925215243c6
dashboard link: https://syzkaller.appspot.com/bug?extid=82ccd564344eeaa5427d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=123c0e07980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2cce96fb4fa1/disk-1868f9d0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5f44d73b8595/vmlinux-1868f9d0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/460a6d450269/bzImage-1868f9d0.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+82ccd564344eeaa5427d@syzkaller.appspotmail.com

INFO: task kworker/u8:3:53 blocked for more than 147 seconds.
      Not tainted 6.11.0-syzkaller-07462-g1868f9d0260e #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u8:3    state:D stack:19824 pid:53    tgid:53    ppid:2      flags:0x00004000
Workqueue: ipv6_addrconf addrconf_dad_work
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5264 [inline]
 __schedule+0x1893/0x4b50 kernel/sched/core.c:6607
 __schedule_loop kernel/sched/core.c:6684 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6699
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6756
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a7/0xd70 kernel/locking/mutex.c:752
 addrconf_dad_work+0xd0/0x16f0 net/ipv6/addrconf.c:4196
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
INFO: task kworker/0:2:940 blocked for more than 152 seconds.
      Not tainted 6.11.0-syzkaller-07462-g1868f9d0260e #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:2     state:D stack:23248 pid:940   tgid:940   ppid:2      flags:0x00004000
Workqueue: events_power_efficient crda_timeout_work
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5264 [inline]
 __schedule+0x1893/0x4b50 kernel/sched/core.c:6607
 __schedule_loop kernel/sched/core.c:6684 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6699
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6756
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a7/0xd70 kernel/locking/mutex.c:752
 crda_timeout_work+0x15/0x50 net/wireless/reg.c:540
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
INFO: task syz-executor:5330 blocked for more than 153 seconds.
      Not tainted 6.11.0-syzkaller-07462-g1868f9d0260e #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:20608 pid:5330  tgid:5330  ppid:5316   flags:0x00004002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5264 [inline]
 __schedule+0x1893/0x4b50 kernel/sched/core.c:6607
 __schedule_loop kernel/sched/core.c:6684 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6699
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6756
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a7/0xd70 kernel/locking/mutex.c:752
 rtnl_lock net/core/rtnetlink.c:79 [inline]
 rtnetlink_rcv_msg+0x6e6/0xcf0 net/core/rtnetlink.c:6643
 netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2550
 netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
 netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1357
 netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1901
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:745
 __sys_sendto+0x398/0x4f0 net/socket.c:2210
 __do_sys_sendto net/socket.c:2222 [inline]
 __se_sys_sendto net/socket.c:2218 [inline]
 __x64_sys_sendto+0xde/0x100 net/socket.c:2218
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe89757fd8c
RSP: 002b:00007fe89785f670 EFLAGS: 00000293 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00007fe898264620 RCX: 00007fe89757fd8c
RDX: 0000000000000028 RSI: 00007fe898264670 RDI: 0000000000000003
RBP: 0000000000000000 R08: 00007fe89785f6c4 R09: 000000000000000c
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000003
R13: 0000000000000000 R14: 00007fe898264670 R15: 0000000000000000
 </TASK>

Showing all locks held in the system:
2 locks held by kthreadd/2:
3 locks held by kworker/u8:0/11:
2 locks held by kworker/u8:1/12:
1 lock held by khungtaskd/30:
 #0: ffffffff8e9389e0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #0: ffffffff8e9389e0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffffffff8e9389e0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x55/0x2a0 kernel/locking/lockdep.c:6701
3 locks held by kworker/u8:3/53:
 #0: ffff88814b8d5148 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff88814b8d5148 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1850 kernel/workqueue.c:3310
 #1: ffffc90000bd7d00 ((work_completion)(&(&ifa->dad_work)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc90000bd7d00 ((work_completion)(&(&ifa->dad_work)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1850 kernel/workqueue.c:3310
 #2: ffffffff8fcc9888 (rtnl_mutex){+.+.}-{3:3}, at: addrconf_dad_work+0xd0/0x16f0 net/ipv6/addrconf.c:4196
5 locks held by kworker/u9:0/55:
 #0: ffff88807e36b948 ((wq_completion)hci0){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff88807e36b948 ((wq_completion)hci0){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1850 kernel/workqueue.c:3310
 #1: ffffc90000bf7d00 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc90000bf7d00 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1850 kernel/workqueue.c:3310
 #2: ffff88807e5d0d80 (&hdev->req_lock){+.+.}-{3:3}, at: hci_cmd_sync_work+0x1ec/0x400 net/bluetooth/hci_sync.c:327
 #3: ffff88807e5d0078 (&hdev->lock){+.+.}-{3:3}, at: hci_abort_conn_sync+0x1ea/0xde0 net/bluetooth/hci_sync.c:5567
 #4: ffffffff8fe36028 (hci_cb_list_lock){+.+.}-{3:3}, at: hci_connect_cfm include/net/bluetooth/hci_core.h:1957 [inline]
 #4: ffffffff8fe36028 (hci_cb_list_lock){+.+.}-{3:3}, at: hci_conn_failed+0x15d/0x300 net/bluetooth/hci_conn.c:1262
3 locks held by kworker/0:2/940:
2 locks held by kworker/u8:5/1058:
5 locks held by kworker/u9:1/4617:
 #0: ffff88804bc63948 ((wq_completion)hci3){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff88804bc63948 ((wq_completion)hci3){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1850 kernel/workqueue.c:3310
 #1: ffffc9000d1ffd00 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc9000d1ffd00 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1850 kernel/workqueue.c:3310
 #2: ffff88807b11cd80 (&hdev->req_lock){+.+.}-{3:3}, at: hci_cmd_sync_work+0x1ec/0x400 net/bluetooth/hci_sync.c:327
 #3: ffff88807b11c078 (&hdev->lock){+.+.}-{3:3}, at: hci_abort_conn_sync+0x1ea/0xde0 net/bluetooth/hci_sync.c:5567
 #4: ffffffff8e93df78 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_lock kernel/rcu/tree_exp.h:329 [inline]
 #4: ffffffff8e93df78 (rcu_state.exp_mutex){+.+.}-{3:3}, at: synchronize_rcu_expedited+0x451/0x830 kernel/rcu/tree_exp.h:976
4 locks held by dhcpcd/4893:
2 locks held by getty/4978:
 #0: ffff88802d3b80a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc90002f062f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x6a6/0x1e00 drivers/tty/n_tty.c:2211
2 locks held by kworker/1:3/5255:
5 locks held by kworker/u9:3/5259:
 #0: ffff88804bc65148 ((wq_completion)hci4){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff88804bc65148 ((wq_completion)hci4){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1850 kernel/workqueue.c:3310
 #1: ffffc90003a77d00 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc90003a77d00 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1850 kernel/workqueue.c:3310
 #2: ffff88807b118d80 (&hdev->req_lock){+.+.}-{3:3}, at: hci_cmd_sync_work+0x1ec/0x400 net/bluetooth/hci_sync.c:327
 #3: ffff88807b118078 (&hdev->lock){+.+.}-{3:3}, at: hci_abort_conn_sync+0x1ea/0xde0 net/bluetooth/hci_sync.c:5567
 #4: ffffffff8fe36028 (hci_cb_list_lock){+.+.}-{3:3}, at: hci_connect_cfm include/net/bluetooth/hci_core.h:1957 [inline]
 #4: ffffffff8fe36028 (hci_cb_list_lock){+.+.}-{3:3}, at: hci_conn_failed+0x15d/0x300 net/bluetooth/hci_conn.c:1262
2 locks held by udevd/5265:
3 locks held by kworker/1:4/5317:
 #0: ffff88801ac81948 ((wq_completion)events_power_efficient){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff88801ac81948 ((wq_completion)events_power_efficient){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1850 kernel/workqueue.c:3310
 #1: ffffc9000d21fd00 ((reg_check_chans).work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc9000d21fd00 ((reg_check_chans).work){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1850 kernel/workqueue.c:3310
 #2: ffffffff8fcc9888 (rtnl_mutex){+.+.}-{3:3}, at: reg_check_chans_work+0x99/0xfd0 net/wireless/reg.c:2480
1 lock held by syz-executor/5318:
 #0: ffffffff8e93df78 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_lock kernel/rcu/tree_exp.h:329 [inline]
 #0: ffffffff8e93df78 (rcu_state.exp_mutex){+.+.}-{3:3}, at: synchronize_rcu_expedited+0x451/0x830 kernel/rcu/tree_exp.h:976
5 locks held by kworker/u9:4/5323:
 #0: ffff88804bc62148 ((wq_completion)hci2){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff88804bc62148 ((wq_completion)hci2){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1850 kernel/workqueue.c:3310


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

