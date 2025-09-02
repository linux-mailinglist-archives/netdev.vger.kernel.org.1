Return-Path: <netdev+bounces-219102-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40237B3FD34
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 12:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DE151A81E26
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 10:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E002FB60C;
	Tue,  2 Sep 2025 10:57:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCE72FABEB
	for <netdev@vger.kernel.org>; Tue,  2 Sep 2025 10:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756810657; cv=none; b=okg5UauA2un2bvy6UlLEx5BEuJelgcdZ1WvNyQNAEN81uY9+w2XGySLX9lp6/7MjO3wW7IyS5iuFzPjBdfVfSBBLAw8UTURTNzs/pYhnc5gD5T+ZkGzKSQFwu9NsR6zG0Ev0ptaz7qkNVYQ3UWQWeIpSvtWammDTYoQpQVwIaKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756810657; c=relaxed/simple;
	bh=02bqSLH5snvFIuTAfjnSjUTyGnNRNOCwDktCVSkyxv0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=fsw8k4Dk+tSbnZdM4qLXXS7fgmWxXtsgcEbMA1JmmYZP2eTlxLHVN//pdRgOC/jnGcdPzaqnXaBZ5q1KacTYKrCC1OYtdQshZZ4YiBwSo28uPIuYaJscvz30KXn0Q2spqzpP2LKhaqHcwehJEc7WNTVm4/bqvz6ugFFfqD+N8YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3f12be6bc4aso64669535ab.1
        for <netdev@vger.kernel.org>; Tue, 02 Sep 2025 03:57:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756810654; x=1757415454;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lf29l4FRYB0JVqObQGZT/OWJAFO5URTdmbt2xpOx0aw=;
        b=sZYf1+A95cMkEQuyT6giz58HJU5ml63dkcGICtA2wqfZGafqXiMT3CTd/AFjpUNrzu
         RHoDiR3kBR4hBfB2/Kqk9pFtP+HZ6tJgAr+zgDEo8Gqr1YPUlZBznljy/IM4nRmhTS1N
         64we+7AsJ9JyFSJcCaaPguDKWqSmCsDpwvaCfblN9WbyS77fVTAvre68oAQ6AMPZnOc6
         m8Ie6T/vkqF3tODwZ51hKEss7PrlUIP/TCeSsahVQOwb+ZVx1/G8k2eKsmJ+sa11xVAq
         fjZ5C7zx2PDB61bkVRh24bOLv1MQPN5uBozDcf6VxQ1QVHd2I9x3GKLPr/PN1ZswRs/V
         cruA==
X-Forwarded-Encrypted: i=1; AJvYcCXdappK8zQGkMiOSiYoOhKYwrxQuxgQ1515yOAvM5Pz7SgPwvQwPn0+VFQwrNqE29nAMxjWMqg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYuqm/86afm5h8/twdkCg8kqgrFwjfuCelxt4eCFIKQyLo4J3O
	JZvG+mNy/9Vf0R+zBDS/Ktfu5PZhJ/lTUFfbK0Anry6aywsPvJSs2VQO156EEh08f31FDBscVOD
	G0Hk/QZNGdoGODHSu6UU/Z4CQx3seZVi38gdrVKvV0a9BqN9H3G3ECSv0Mhc=
X-Google-Smtp-Source: AGHT+IEm77atnM7mgNQozcd8YtkBsXkAYVOpMTcrFiW2sSp9Faq029WxDhSVQIhFCj3AUZ7rlk0GKUfaUULUaFrJjpkBEiuTd7GI
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2302:b0:3f0:62bf:f23 with SMTP id
 e9e14a558f8ab-3f401aee1b6mr208811135ab.15.1756810654514; Tue, 02 Sep 2025
 03:57:34 -0700 (PDT)
Date: Tue, 02 Sep 2025 03:57:34 -0700
In-Reply-To: <000000000000ef73a7061f328276@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68b6cd9e.a70a0220.1c57d1.0598.GAE@google.com>
Subject: Re: [syzbot] [net?] INFO: task hung in switchdev_deferred_process_work
 (3)
From: syzbot <syzbot+d6bbe0f5705cb8a5aa2b@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	ivecera@redhat.com, jiri@resnulli.us, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

syzbot has found a reproducer for the following issue on:

HEAD commit:    b320789d6883 Linux 6.17-rc4
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=3D16395e34580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dbd9738e00c1bbfb=
4
dashboard link: https://syzkaller.appspot.com/bug?extid=3Dd6bbe0f5705cb8a5a=
a2b
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-=
1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D10ba166258000=
0
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D121a8312580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/dc96f2e9db93/disk-=
b320789d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/fcbc622fd55c/vmlinux-=
b320789d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c309f0747b00/bzI=
mage-b320789d.xz

Bisection is inconclusive: the first bad commit could be any of:

781773e3b680 sched/fair: Implement ENQUEUE_DELAYED
a1c446611e31 sched,freezer: Mark TASK_FROZEN special
e1459a50ba31 sched: Teach dequeue_task() about special task states
f12e148892ed sched/fair: Prepare pick_next_task() for delayed dequeue
152e11f6df29 sched/fair: Implement delayed dequeue
2e0199df252a sched/fair: Prepare exit/cleanup paths for delayed_dequeue
54a58a787791 sched/fair: Implement DELAY_ZERO

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D1358d7805800=
00

IMPORTANT: if you fix the issue, please add the following tag to the commit=
:
Reported-by: syzbot+d6bbe0f5705cb8a5aa2b@syzkaller.appspotmail.com

INFO: task kworker/0:0:9 blocked for more than 144 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:0     state:D stack:19144 pid:9     tgid:9     ppid:2      t=
ask_flags:0x4208060 flags:0x00004000
Workqueue: events switchdev_deferred_process_work
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5357 [inline]
 __schedule+0x16f3/0x4c20 kernel/sched/core.c:6961
 __schedule_loop kernel/sched/core.c:7043 [inline]
 rt_mutex_schedule+0x77/0xf0 kernel/sched/core.c:7339
 rt_mutex_slowlock_block+0x5ba/0x6d0 kernel/locking/rtmutex.c:1647
 __rt_mutex_slowlock kernel/locking/rtmutex.c:1721 [inline]
 __rt_mutex_slowlock_locked kernel/locking/rtmutex.c:1760 [inline]
 rt_mutex_slowlock+0x2b1/0x6e0 kernel/locking/rtmutex.c:1800
 __rt_mutex_lock kernel/locking/rtmutex.c:1815 [inline]
 __mutex_lock_common kernel/locking/rtmutex_api.c:536 [inline]
 mutex_lock_nested+0x16a/0x1d0 kernel/locking/rtmutex_api.c:547
 switchdev_deferred_process_work+0xe/0x20 net/switchdev/switchdev.c:104
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0xade/0x17b0 kernel/workqueue.c:3319
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3400
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x3f9/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
INFO: task kworker/u8:5:160 blocked for more than 144 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u8:5    state:D stack:20072 pid:160   tgid:160   ppid:2      t=
ask_flags:0x4208060 flags:0x00004000
Workqueue: ipv6_addrconf addrconf_dad_work
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5357 [inline]
 __schedule+0x16f3/0x4c20 kernel/sched/core.c:6961
 __schedule_loop kernel/sched/core.c:7043 [inline]
 rt_mutex_schedule+0x77/0xf0 kernel/sched/core.c:7339
 rt_mutex_slowlock_block+0x5ba/0x6d0 kernel/locking/rtmutex.c:1647
 __rt_mutex_slowlock kernel/locking/rtmutex.c:1721 [inline]
 __rt_mutex_slowlock_locked kernel/locking/rtmutex.c:1760 [inline]
 rt_mutex_slowlock+0x2b1/0x6e0 kernel/locking/rtmutex.c:1800
 __rt_mutex_lock kernel/locking/rtmutex.c:1815 [inline]
 __mutex_lock_common kernel/locking/rtmutex_api.c:536 [inline]
 mutex_lock_nested+0x16a/0x1d0 kernel/locking/rtmutex_api.c:547
 rtnl_net_lock include/linux/rtnetlink.h:130 [inline]
 addrconf_dad_work+0x119/0x15a0 net/ipv6/addrconf.c:4194
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0xade/0x17b0 kernel/workqueue.c:3319
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3400
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x3f9/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
INFO: task kworker/1:2:994 blocked for more than 144 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/1:2     state:D stack:20680 pid:994   tgid:994   ppid:2      t=
ask_flags:0x4208060 flags:0x00004000
Workqueue: events_power_efficient reg_check_chans_work
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5357 [inline]
 __schedule+0x16f3/0x4c20 kernel/sched/core.c:6961
 __schedule_loop kernel/sched/core.c:7043 [inline]
 rt_mutex_schedule+0x77/0xf0 kernel/sched/core.c:7339
 rt_mutex_slowlock_block+0x5ba/0x6d0 kernel/locking/rtmutex.c:1647
 __rt_mutex_slowlock kernel/locking/rtmutex.c:1721 [inline]
 __rt_mutex_slowlock_locked kernel/locking/rtmutex.c:1760 [inline]
 rt_mutex_slowlock+0x2b1/0x6e0 kernel/locking/rtmutex.c:1800
 __rt_mutex_lock kernel/locking/rtmutex.c:1815 [inline]
 __mutex_lock_common kernel/locking/rtmutex_api.c:536 [inline]
 mutex_lock_nested+0x16a/0x1d0 kernel/locking/rtmutex_api.c:547
 class_wiphy_constructor include/net/cfg80211.h:6212 [inline]
 reg_leave_invalid_chans net/wireless/reg.c:2471 [inline]
 reg_check_chans_work+0x164/0xf30 net/wireless/reg.c:2486
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0xade/0x17b0 kernel/workqueue.c:3319
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3400
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x3f9/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
INFO: task syz-executor:6125 blocked for more than 144 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:18568 pid:6125  tgid:6125  ppid:1      t=
ask_flags:0x400140 flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5357 [inline]
 __schedule+0x16f3/0x4c20 kernel/sched/core.c:6961
 __schedule_loop kernel/sched/core.c:7043 [inline]
 rt_mutex_schedule+0x77/0xf0 kernel/sched/core.c:7339
 rt_mutex_slowlock_block+0x5ba/0x6d0 kernel/locking/rtmutex.c:1647
 __rt_mutex_slowlock kernel/locking/rtmutex.c:1721 [inline]
 __rt_mutex_slowlock_locked kernel/locking/rtmutex.c:1760 [inline]
 rt_mutex_slowlock+0x2b1/0x6e0 kernel/locking/rtmutex.c:1800
 __rt_mutex_lock kernel/locking/rtmutex.c:1815 [inline]
 __mutex_lock_common kernel/locking/rtmutex_api.c:536 [inline]
 mutex_lock_nested+0x16a/0x1d0 kernel/locking/rtmutex_api.c:547
 rtnl_net_lock include/linux/rtnetlink.h:130 [inline]
 inet_rtm_newaddr+0x3b0/0x18b0 net/ipv4/devinet.c:979
 rtnetlink_rcv_msg+0x7cc/0xb70 net/core/rtnetlink.c:6946
 netlink_rcv_skb+0x205/0x470 net/netlink/af_netlink.c:2552
 netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
 netlink_unicast+0x843/0xa10 net/netlink/af_netlink.c:1346
 netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1896
 sock_sendmsg_nosec net/socket.c:714 [inline]
 __sock_sendmsg+0x219/0x270 net/socket.c:729
 __sys_sendto+0x3c7/0x520 net/socket.c:2228
 __do_sys_sendto net/socket.c:2235 [inline]
 __se_sys_sendto net/socket.c:2231 [inline]
 __x64_sys_sendto+0xde/0x100 net/socket.c:2231
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe6932a0a7c
RSP: 002b:00007ffd4d6cceb0 EFLAGS: 00000293 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00007fe694004620 RCX: 00007fe6932a0a7c
RDX: 0000000000000028 RSI: 00007fe694004670 RDI: 0000000000000003
RBP: 0000000000000000 R08: 00007ffd4d6ccf04 R09: 000000000000000c
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000003
R13: 0000000000000000 R14: 00007fe694004670 R15: 0000000000000000
 </TASK>

Showing all locks held in the system:
3 locks held by kworker/0:0/9:
 #0: ffff888019898538 ((wq_completion)events){+.+.}-{0:0}, at: process_one_=
work kernel/workqueue.c:3211 [inline]
 #0: ffff888019898538 ((wq_completion)events){+.+.}-{0:0}, at: process_sche=
duled_works+0x9b4/0x17b0 kernel/workqueue.c:3319
 #1: ffffc900000e7bc0 (deferred_process_work){+.+.}-{0:0}, at: process_one_=
work kernel/workqueue.c:3212 [inline]
 #1: ffffc900000e7bc0 (deferred_process_work){+.+.}-{0:0}, at: process_sche=
duled_works+0x9ef/0x17b0 kernel/workqueue.c:3319
 #2: ffffffff8ecd22f8 (rtnl_mutex){+.+.}-{4:4}, at: switchdev_deferred_proc=
ess_work+0xe/0x20 net/switchdev/switchdev.c:104
3 locks held by kworker/0:1/10:
3 locks held by kworker/u8:1/13:
5 locks held by ktimers/0/16:
2 locks held by rcuc/0/20:
 #0: ffffffff8d84a7a0 (local_bh){.+.+}-{1:3}, at: __local_bh_disable_ip+0xa=
1/0x400 kernel/softirq.c:163
 #1: ffff8880b8823d90 ((softirq_ctrl.lock)){+.+.}-{3:3}, at: spin_lock incl=
ude/linux/spinlock_rt.h:44 [inline]
 #1: ffff8880b8823d90 ((softirq_ctrl.lock)){+.+.}-{3:3}, at: __local_bh_dis=
able_ip+0x264/0x400 kernel/softirq.c:168
1 lock held by khungtaskd/38:
 #0: ffffffff8d9a8bc0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire inc=
lude/linux/rcupdate.h:331 [inline]
 #0: ffffffff8d9a8bc0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock includ=
e/linux/rcupdate.h:841 [inline]
 #0: ffffffff8d9a8bc0 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks=
+0x2e/0x180 kernel/locking/lockdep.c:6775
4 locks held by kworker/u8:2/43:
 #0: ffff888030bdb938 ((wq_completion)bat_events){+.+.}-{0:0}, at: process_=
one_work kernel/workqueue.c:3211 [inline]
 #0: ffff888030bdb938 ((wq_completion)bat_events){+.+.}-{0:0}, at: process_=
scheduled_works+0x9b4/0x17b0 kernel/workqueue.c:3319
 #1: ffffc90000b47bc0 ((work_completion)(&(&bat_priv->tt.work)->work)){+.+.=
}-{0:0}, at: process_one_work kernel/workqueue.c:3212 [inline]
 #1: ffffc90000b47bc0 ((work_completion)(&(&bat_priv->tt.work)->work)){+.+.=
}-{0:0}, at: process_scheduled_works+0x9ef/0x17b0 kernel/workqueue.c:3319
 #2: ffffffff8d84a7a0 (local_bh){.+.+}-{1:3}, at: __local_bh_disable_ip+0xa=
1/0x400 kernel/softirq.c:163
 #3: ffff8880b8823d90 ((softirq_ctrl.lock)){+.+.}-{3:3}, at: spin_lock incl=
ude/linux/spinlock_rt.h:44 [inline]
 #3: ffff8880b8823d90 ((softirq_ctrl.lock)){+.+.}-{3:3}, at: __local_bh_dis=
able_ip+0x264/0x400 kernel/softirq.c:168
5 locks held by kworker/u8:3/44:
 #0: ffff888019881138 ((wq_completion)events_unbound){+.+.}-{0:0}, at: proc=
ess_one_work kernel/workqueue.c:3211 [inline]
 #0: ffff888019881138 ((wq_completion)events_unbound){+.+.}-{0:0}, at: proc=
ess_scheduled_works+0x9b4/0x17b0 kernel/workqueue.c:3319
 #1: ffffc90000b57bc0 ((work_completion)(&rdev->wiphy_work)){+.+.}-{0:0}, a=
t: process_one_work kernel/workqueue.c:3212 [inline]
 #1: ffffc90000b57bc0 ((work_completion)(&rdev->wiphy_work)){+.+.}-{0:0}, a=
t: process_scheduled_works+0x9ef/0x17b0 kernel/workqueue.c:3319
 #2: ffff888053980898 (&rdev->wiphy.mtx){+.+.}-{4:4}, at: class_wiphy_const=
ructor include/net/cfg80211.h:6212 [inline]
 #2: ffff888053980898 (&rdev->wiphy.mtx){+.+.}-{4:4}, at: cfg80211_wiphy_wo=
rk+0xc4/0x470 net/wireless/core.c:421
 #3: ffffffff8d84a7a0 (local_bh){.+.+}-{1:3}, at: __local_bh_disable_ip+0xa=
1/0x400 kernel/softirq.c:163
 #4: ffff8880b8823d90 ((softirq_ctrl.lock)){+.+.}-{3:3}, at: spin_lock incl=
ude/linux/spinlock_rt.h:44 [inline]
 #4: ffff8880b8823d90 ((softirq_ctrl.lock)){+.+.}-{3:3}, at: __local_bh_dis=
able_ip+0x264/0x400 kernel/softirq.c:168
3 locks held by kworker/u8:5/160:
 #0: ffff88802feff938 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: proce=
ss_one_work kernel/workqueue.c:3211 [inline]
 #0: ffff88802feff938 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: proce=
ss_scheduled_works+0x9b4/0x17b0 kernel/workqueue.c:3319
 #1: ffffc90003b3fbc0 ((work_completion)(&(&ifa->dad_work)->work)){+.+.}-{0=
:0}, at: process_one_work kernel/workqueue.c:3212 [inline]
 #1: ffffc90003b3fbc0 ((work_completion)(&(&ifa->dad_work)->work)){+.+.}-{0=
:0}, at: process_scheduled_works+0x9ef/0x17b0 kernel/workqueue.c:3319
 #2: ffffffff8ecd22f8 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_net_lock include/l=
inux/rtnetlink.h:130 [inline]
 #2: ffffffff8ecd22f8 (rtnl_mutex){+.+.}-{4:4}, at: addrconf_dad_work+0x119=
/0x15a0 net/ipv6/addrconf.c:4194
4 locks held by kworker/1:2/994:
 #0: ffff888019899938 ((wq_completion)events_power_efficient){+.+.}-{0:0}, =
at: process_one_work kernel/workqueue.c:3211 [inline]
 #0: ffff888019899938 ((wq_completion)events_power_efficient){+.+.}-{0:0}, =
at: process_scheduled_works+0x9b4/0x17b0 kernel/workqueue.c:3319
 #1: ffffc900047e7bc0 ((reg_check_chans).work){+.+.}-{0:0}, at: process_one=
_work kernel/workqueue.c:3212 [inline]
 #1: ffffc900047e7bc0 ((reg_check_chans).work){+.+.}-{0:0}, at: process_sch=
eduled_works+0x9ef/0x17b0 kernel/workqueue.c:3319
 #2: ffffffff8ecd22f8 (rtnl_mutex){+.+.}-{4:4}, at: reg_check_chans_work+0x=
95/0xf30 net/wireless/reg.c:2483
 #3: ffff88803d4d0898 (&rdev->wiphy.mtx){+.+.}-{4:4}, at: class_wiphy_const=
ructor include/net/cfg80211.h:6212 [inline]
 #3: ffff88803d4d0898 (&rdev->wiphy.mtx){+.+.}-{4:4}, at: reg_leave_invalid=
_chans net/wireless/reg.c:2471 [inline]
 #3: ffff88803d4d0898 (&rdev->wiphy.mtx){+.+.}-{4:4}, at: reg_check_chans_w=
ork+0x164/0xf30 net/wireless/reg.c:2486
5 locks held by kworker/u8:8/1148:
2 locks held by aoe_tx0/1323:
 #0: ffffffff8d84a7a0 (local_bh){.+.+}-{1:3}, at: __local_bh_disable_ip+0xa=
1/0x400 kernel/softirq.c:163
 #1: ffff8880b8823d90 ((softirq_ctrl.lock)){+.+.}-{3:3}, at: spin_lock incl=
ude/linux/spinlock_rt.h:44 [inline]
 #1: ffff8880b8823d90 ((softirq_ctrl.lock)){+.+.}-{3:3}, at: __local_bh_dis=
able_ip+0x264/0x400 kernel/softirq.c:168
6 locks held by kworker/u9:1/5153:
 #0: ffff888033652938 ((wq_completion)hci1){+.+.}-{0:0}, at: process_one_wo=
rk kernel/workqueue.c:3211 [inline]
 #0: ffff888033652938 ((wq_completion)hci1){+.+.}-{0:0}, at: process_schedu=
led_works+0x9b4/0x17b0 kernel/workqueue.c:3319
 #1: ffffc9000fca7bc0 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}=
, at: process_one_work kernel/workqueue.c:3212 [inline]
 #1: ffffc9000fca7bc0 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}=
, at: process_scheduled_works+0x9ef/0x17b0 kernel/workqueue.c:3319
 #2: ffff888034614e80 (&hdev->req_lock){+.+.}-{4:4}, at: hci_cmd_sync_work+=
0x1d4/0x3a0 net/bluetooth/hci_sync.c:331
 #3: ffff8880346140a8 (&hdev->lock){+.+.}-{4:4}, at: hci_abort_conn_sync+0x=
242/0xe30 net/bluetooth/hci_sync.c:5670
 #4: ffffffff8ee39c78 (hci_cb_list_lock){+.+.}-{4:4}, at: hci_connect_cfm i=
nclude/net/bluetooth/hci_core.h:2079 [inline]
 #4: ffffffff8ee39c78 (hci_cb_list_lock){+.+.}-{4:4}, at: hci_conn_failed+0=
x165/0x310 net/bluetooth/hci_conn.c:1313
 #5: ffff888037b98358 (&conn->lock#2){+.+.}-{4:4}, at: l2cap_conn_del+0x70/=
0x680 net/bluetooth/l2cap_core.c:1762
2 locks held by klogd/5193:
3 locks held by udevd/5204:
 #0: ffff88802675e350 (sk_lock-AF_NETLINK){+.+.}-{0:0}, at: lock_sock inclu=
de/net/sock.h:1667 [inline]
 #0: ffff88802675e350 (sk_lock-AF_NETLINK){+.+.}-{0:0}, at: netlink_insert+=
0xd3/0x1370 net/netlink/af_netlink.c:557
 #1: ffffffff8d84a7a0 (local_bh){.+.+}-{1:3}, at: __local_bh_disable_ip+0xa=
1/0x400 kernel/softirq.c:163
 #2: ffff8880b8823d90 ((softirq_ctrl.lock)){+.+.}-{3:3}, at: spin_lock incl=
ude/linux/spinlock_rt.h:44 [inline]
 #2: ffff8880b8823d90 ((softirq_ctrl.lock)){+.+.}-{3:3}, at: __local_bh_dis=
able_ip+0x264/0x400 kernel/softirq.c:168
3 locks held by dhcpcd/5499:
2 locks held by getty/5594:
 #0: ffff88823bf808a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait=
+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc90003e832e0 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_rea=
d+0x444/0x1410 drivers/tty/n_tty.c:2222
2 locks held by dhcpcd/5640:
 #0: ffffffff8d84a7a0 (local_bh){.+.+}-{1:3}, at: __local_bh_disable_ip+0xa=
1/0x400 kernel/softirq.c:163
 #1: ffff8880b8823d90 ((softirq_ctrl.lock)){+.+.}-{3:3}, at: spin_lock incl=
ude/linux/spinlock_rt.h:44 [inline]
 #1: ffff8880b8823d90 ((softirq_ctrl.lock)){+.+.}-{3:3}, at: __local_bh_dis=
able_ip+0x264/0x400 kernel/softirq.c:168
2 locks held by kworker/1:3/5891:
2 locks held by syz-executor/5979:
 #0: ffff88803a1dce80 (&hdev->req_lock){+.+.}-{4:4}, at: hci_dev_do_close n=
et/bluetooth/hci_core.c:499 [inline]
 #0: ffff88803a1dce80 (&hdev->req_lock){+.+.}-{4:4}, at: hci_unregister_dev=
+0x212/0x510 net/bluetooth/hci_core.c:2715
 #1: ffff88803a1dc0a8 (&hdev->lock){+.+.}-{4:4}, at: hci_dev_close_sync+0x6=
6a/0x1330 net/bluetooth/hci_sync.c:5282
5 locks held by napi/wg2-0/6063:
1 lock held by syz-executor/6125:
 #0: ffffffff8ecd22f8 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_net_lock include/l=
inux/rtnetlink.h:130 [inline]
 #0: ffffffff8ecd22f8 (rtnl_mutex){+.+.}-{4:4}, at: inet_rtm_newaddr+0x3b0/=
0x18b0 net/ipv4/devinet.c:979
4 locks held by kworker/0:9/6133:
 #0: ffff888033d0ed38 ((wq_completion)wg-crypt-wg1){+.+.}-{0:0}, at: proces=
s_one_work kernel/workqueue.c:3211 [inline]
 #0: ffff888033d0ed38 ((wq_completion)wg-crypt-wg1){+.+.}-{0:0}, at: proces=
s_scheduled_works+0x9b4/0x17b0 kernel/workqueue.c:3319
 #1: ffffc900040bfbc0 ((work_completion)(&({ do { const void *__vpp_verify =
=3D (typeof((worker) + 0))((void *)0); (void)__vpp_verify; } while (0); ({ =
unsigned long __ptr; __ptr =3D (unsigned long) ((__typeof_unqual__(*((worke=
r))) *)(( unsigned long)((worker)))); (typeof((__typeof_unqual__(*((worker)=
)) *)(( unsigned long)((worker))))) (__ptr + (((__per_cpu_offset[(cpu)]))))=
; }); })->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3212 =
[inline]
 #1: ffffc900040bfbc0 ((work_completion)(&({ do { const void *__vpp_verify =
=3D (typeof((worker) + 0))((void *)0); (void)__vpp_verify; } while (0); ({ =
unsigned long __ptr; __ptr =3D (unsigned long) ((__typeof_unqual__(*((worke=
r))) *)(( unsigned long)((worker)))); (typeof((__typeof_unqual__(*((worker)=
)) *)(( unsigned long)((worker))))) (__ptr + (((__per_cpu_offset[(cpu)]))))=
; }); })->work)){+.+.}-{0:0}, at: process_scheduled_works+0x9ef/0x17b0 kern=
el/workqueue.c:3319
 #2: ffffffff8d84a7a0 (local_bh){.+.+}-{1:3}, at: __local_bh_disable_ip+0xa=
1/0x400 kernel/softirq.c:163
 #3: ffff8880b8823d90 ((softirq_ctrl.lock)){+.+.}-{3:3}, at: spin_lock incl=
ude/linux/spinlock_rt.h:44 [inline]
 #3: ffff8880b8823d90 ((softirq_ctrl.lock)){+.+.}-{3:3}, at: __local_bh_dis=
able_ip+0x264/0x400 kernel/softirq.c:168
3 locks held by kworker/0:10/6136:
3 locks held by kworker/1:6/6137:
3 locks held by kworker/u9:3/6141:
 #0: ffff888027b71138 ((wq_completion)hci2#6){+.+.}-{0:0}, at: process_one_=
work kernel/workqueue.c:3211 [inline]
 #0: ffff888027b71138 ((wq_completion)hci2#6){+.+.}-{0:0}, at: process_sche=
duled_works+0x9b4/0x17b0 kernel/workqueue.c:3319
 #1: ffffc900040cfbc0 ((work_completion)(&hdev->power_on)){+.+.}-{0:0}, at:=
 process_one_work kernel/workqueue.c:3212 [inline]
 #1: ffffc900040cfbc0 ((work_completion)(&hdev->power_on)){+.+.}-{0:0}, at:=
 process_scheduled_works+0x9ef/0x17b0 kernel/workqueue.c:3319
 #2: ffff888030f30e80 (&hdev->req_lock){+.+.}-{4:4}, at: hci_dev_do_open ne=
t/bluetooth/hci_core.c:428 [inline]
 #2: ffff888030f30e80 (&hdev->req_lock){+.+.}-{4:4}, at: hci_power_on+0x1ac=
/0x680 net/bluetooth/hci_core.c:959
3 locks held by syz-executor/6151:
 #0: ffff888024388350 (sk_lock-AF_BLUETOOTH-BTPROTO_HCI){+.+.}-{0:0}, at: l=
ock_sock include/net/sock.h:1667 [inline]
 #0: ffff888024388350 (sk_lock-AF_BLUETOOTH-BTPROTO_HCI){+.+.}-{0:0}, at: h=
ci_sock_ioctl+0x247/0x910 net/bluetooth/hci_sock.c:1080
 #1: ffffffff8d84a7a0 (local_bh){.+.+}-{1:3}, at: __local_bh_disable_ip+0xa=
1/0x400 kernel/softirq.c:163
 #2: ffff8880b8823d90 ((softirq_ctrl.lock)){+.+.}-{3:3}, at: spin_lock incl=
ude/linux/spinlock_rt.h:44 [inline]
 #2: ffff8880b8823d90 ((softirq_ctrl.lock)){+.+.}-{3:3}, at: __local_bh_dis=
able_ip+0x264/0x400 kernel/softirq.c:168
2 locks held by syz-executor/6152:

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 38 Comm: khungtaskd Not tainted syzkaller #0 PREEMPT_{RT=
,(full)}=20
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Goo=
gle 07/12/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x39e/0x3d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x17a/0x300 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:160 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:328 [inline]
 watchdog+0xf93/0xfe0 kernel/hung_task.c:491
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x3f9/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 6063 Comm: napi/wg2-0 Not tainted syzkaller #0 PREEMPT_{=
RT,(full)}=20
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Goo=
gle 07/12/2025
RIP: 0010:rcu_lock_release include/linux/rcupdate.h:341 [inline]
RIP: 0010:rcu_read_unlock include/linux/rcupdate.h:871 [inline]
RIP: 0010:class_rcu_destructor include/linux/rcupdate.h:1155 [inline]
RIP: 0010:unwind_next_frame+0x199a/0x2390 arch/x86/kernel/unwind_orc.c:680
Code: 74 28 80 3d 50 68 94 0d 00 75 1f c6 05 47 68 94 0d 01 48 c7 c7 a0 45 =
08 8b be 66 03 00 00 48 c7 c2 40 46 08 8b e8 36 53 29 00 <48> c7 c7 c0 8b 9=
a 8d 4c 89 fe e8 17 39 29 00 e8 c2 f7 32 00 89 d8
RSP: 0018:ffffc9000412e4f8 EFLAGS: 00000202
RAX: 0000000000000001 RBX: ffffffff90256d01 RCX: 91a909d43edeb500
RDX: ffffc9000412e601 RSI: ffffffff8b620e60 RDI: ffffffff8b620e20
RBP: dffffc0000000000 R08: ffffc9000412f9b0 R09: 0000000000000000
R10: ffffc9000412e618 R11: fffff52000825cc5 R12: ffffc9000412f9c0
R13: ffffc90004128000 R14: ffffc9000412e5c8 R15: ffffffff8172b165
FS:  0000000000000000(0000) GS:ffff8881269c2000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fde6497d008 CR3: 000000000d7a6000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 arch_stack_walk+0x11c/0x150 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0x9c/0xe0 kernel/stacktrace.c:122
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:330 [inline]
 __kasan_slab_alloc+0x6c/0x80 mm/kasan/common.c:356
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4180 [inline]
 slab_alloc_node mm/slub.c:4229 [inline]
 kmem_cache_alloc_noprof+0x143/0x310 mm/slub.c:4236
 skb_ext_maybe_cow net/core/skbuff.c:6994 [inline]
 skb_ext_add+0x1b6/0x8f0 net/core/skbuff.c:7068
 nf_bridge_unshare net/bridge/br_netfilter_hooks.c:169 [inline]
 br_nf_forward_ip+0xc6/0x7e0 net/bridge/br_netfilter_hooks.c:684
 nf_hook_entry_hookfn include/linux/netfilter.h:158 [inline]
 nf_hook_slow+0xc5/0x220 net/netfilter/core.c:623
 nf_hook include/linux/netfilter.h:273 [inline]
 NF_HOOK+0x215/0x3c0 include/linux/netfilter.h:316
 __br_forward+0x41e/0x600 net/bridge/br_forward.c:115
 deliver_clone net/bridge/br_forward.c:131 [inline]
 maybe_deliver+0xb5/0x160 net/bridge/br_forward.c:190
 br_flood+0x31a/0x6a0 net/bridge/br_forward.c:237
 br_handle_frame_finish+0x14b4/0x19b0 net/bridge/br_input.c:221
 br_nf_hook_thresh+0x3c6/0x4a0 net/bridge/br_netfilter_hooks.c:-1
 br_nf_pre_routing_finish_ipv6+0x948/0xd00 net/bridge/br_netfilter_ipv6.c:-=
1
 NF_HOOK include/linux/netfilter.h:318 [inline]
 br_nf_pre_routing_ipv6+0x37e/0x6b0 net/bridge/br_netfilter_ipv6.c:184
 nf_hook_entry_hookfn include/linux/netfilter.h:158 [inline]
 nf_hook_bridge_pre net/bridge/br_input.c:283 [inline]
 br_handle_frame+0x982/0x14d0 net/bridge/br_input.c:434
 __netif_receive_skb_core+0x10b6/0x4020 net/core/dev.c:5878
 __netif_receive_skb_one_core net/core/dev.c:5989 [inline]
 __netif_receive_skb+0x72/0x380 net/core/dev.c:6104
 process_backlog+0x31e/0x900 net/core/dev.c:6456
 __napi_poll+0xb6/0x540 net/core/dev.c:7506
 napi_poll net/core/dev.c:7569 [inline]
 net_rx_action+0x707/0xe00 net/core/dev.c:7696
 handle_softirqs+0x22c/0x710 kernel/softirq.c:579
 __do_softirq kernel/softirq.c:613 [inline]
 __local_bh_enable_ip+0x179/0x270 kernel/softirq.c:259
 local_bh_enable include/linux/bottom_half.h:33 [inline]
 napi_threaded_poll_loop+0x450/0x570 net/core/dev.c:7637
 napi_threaded_poll+0x1be/0x2b0 net/core/dev.c:7652
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x3f9/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

