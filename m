Return-Path: <netdev+bounces-301070-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id s0x/GxIeOWppnAcAu9opvQ
	(envelope-from <netdev+bounces-301070-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 13:35:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C10A6AF223
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 13:35:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=appspotmail.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301070-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301070-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CF963300E920
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 11:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE26C28F949;
	Mon, 22 Jun 2026 11:32:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f207.google.com (mail-oi1-f207.google.com [209.85.167.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A462741A0
	for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 11:32:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782127943; cv=none; b=dEL/hd9Id5K8t4g2hRJVZHZxQwvI7SHea54rrshZiDfgS4VUDvgKqWIBssfwyXheLK4MpLFS+HY5AFQJHPSc4Z3ZxBEbGtUf0+5Wn652T0/7JXLB3qa61lZ1eT7LY7k4bf+KyF/LYHBw+QFvRHvPq3I6MarAkh18kqjBmXWooAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782127943; c=relaxed/simple;
	bh=iB6gU+t/ZR5ROCYFdFomyKEM7HE+2ZmLQaJsS7tz2Gg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=nAMGNcRZUrslUzn2dHqHY9D7iX/udP/gguBq84WpFr/4FBW/sBxcVCIlwOZ5jwwEwiIK2D9UV8MsM/VTyKgFIu64G8jzTgxOdWagQ6qfBuflKgkF1FVcHKXiMopqP5ahRo1zNK/EroWPrw9gAArsgVHyU5Q52HB3lHtBnlF+BA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.207
Received: by mail-oi1-f207.google.com with SMTP id 5614622812f47-48b61eabb4cso4671308b6e.1
        for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 04:32:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782127941; x=1782732741;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7YBmVR1EGeoxNwnsfxfhW+EYa5OhyYlo+vO0G4BaAlc=;
        b=bzXi2MomCp3neELJMol0oNkLoVyY/mtoLU7VHDn6GTfqIu3Ltiy0U9p9i4XGWuh8SG
         xkYbq8da9X1+GcLhg5ue6sCV8mbgZVehgl/T5/O+d9mt6lFqUZfpKroC7AcQyJY+yF2A
         XGZOkx7XkL0Vum9zcPG8symzMA5bMtWClsKwpjm3qkAAeoWrlFbjgcSZrD4meGd+Noz6
         L9gdC3n8lJ5S5MnjrJe38uo36V/q8iFR4UYdaUDvvhKTaCu+1Ibd3pEm7k5dzjK67ezX
         4Au2p/ll16hzSWZ2XGJxYVRYw+/kAW2bLK8k8sMsSKLwPgGL6J4QsRxUh0ZCm4ThKuaL
         Easg==
X-Forwarded-Encrypted: i=1; AFNElJ/llMkuVblNUpY7zChDayFuehmLw/chqjgqSLvC/4PognSeHx+7OhG/ZmVhsUmP5Bf+zrOLNY0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVedVF57RjN5JDXG/yVkK+xxrmfO2qpiNsTR4wqFPFdz1Yy8u6
	DoIr3nh9rOTCv+iknANShn7F4PzVs51LqP1rZgdZ7LZwhW2VUG5ljKZg/BFdZXrc6alKuH2ce4e
	pfmcnS6korq1cJO7qC3LtXimOhcnt83Cx2qi36QFGt+JWBOZlbXOsdrCycbU=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:6f90:b0:48c:c121:b0a9 with SMTP id
 5614622812f47-48cc121b775mr4313667b6e.14.1782127941029; Mon, 22 Jun 2026
 04:32:21 -0700 (PDT)
Date: Mon, 22 Jun 2026 04:32:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a391d45.a48cb56a.bc3d6.0001.GAE@google.com>
Subject: [syzbot] [net?] INFO: task hung in netdev_rx_mode_work
From: syzbot <syzbot+cb67c392b0b8f0fd0fc1@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=bef29eb7c0231032];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:horms@kernel.org,m:kuba@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:syzkaller-bugs@googlegroups.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301070-lists,netdev=lfdr.de,cb67c392b0b8f0fd0fc1];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[googlegroups.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,storage.googleapis.com:url,goo.gl:url];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5C10A6AF223

Hello,

syzbot found the following issue on:

HEAD commit:    390d73adf896 Merge tag 'for-v7.2' of git://git.kernel.org/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12fad766580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bef29eb7c0231032
dashboard link: https://syzkaller.appspot.com/bug?extid=cb67c392b0b8f0fd0fc1
compiler:       Debian clang version 22.1.6 (++20260514074242+fc4aad7b5db3-1~exp1~20260514074407.73), Debian LLD 22.1.6

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5511a10e958e/disk-390d73ad.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/bbdc93bd1239/vmlinux-390d73ad.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7d72a4665dd8/bzImage-390d73ad.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+cb67c392b0b8f0fd0fc1@syzkaller.appspotmail.com

INFO: task kworker/0:5:5689 blocked for more than 143 seconds.
      Tainted: G             L      syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:5     state:D stack:21448 pid:5689  tgid:5689  ppid:2      task_flags:0x4208060 flags:0x00080000
Workqueue: events netdev_rx_mode_work
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5504 [inline]
 __schedule+0x17d9/0x56c0 kernel/sched/core.c:7228
 __schedule_loop kernel/sched/core.c:7307 [inline]
 schedule+0x164/0x360 kernel/sched/core.c:7322
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7379
 __mutex_lock_common kernel/locking/mutex.c:726 [inline]
 __mutex_lock+0x7bf/0x1550 kernel/locking/mutex.c:821
 netdev_rx_mode_work+0x18/0x3c0 net/core/dev_addr_lists.c:1346
 process_one_work kernel/workqueue.c:3322 [inline]
 process_scheduled_works+0xa8e/0x14e0 kernel/workqueue.c:3405
 worker_thread+0xa47/0xfb0 kernel/workqueue.c:3486
 kthread+0x388/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
INFO: task kworker/u8:45:10240 blocked for more than 143 seconds.
      Tainted: G             L      syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u8:45   state:D stack:22648 pid:10240 tgid:10240 ppid:2      task_flags:0x4208060 flags:0x00080000
Workqueue: events_unbound linkwatch_event
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5504 [inline]
 __schedule+0x17d9/0x56c0 kernel/sched/core.c:7228
 __schedule_loop kernel/sched/core.c:7307 [inline]
 schedule+0x164/0x360 kernel/sched/core.c:7322
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7379
 __mutex_lock_common kernel/locking/mutex.c:726 [inline]
 __mutex_lock+0x7bf/0x1550 kernel/locking/mutex.c:821
 linkwatch_event+0xe/0x60 net/core/link_watch.c:313
 process_one_work kernel/workqueue.c:3322 [inline]
 process_scheduled_works+0xa8e/0x14e0 kernel/workqueue.c:3405
 worker_thread+0xa47/0xfb0 kernel/workqueue.c:3486
 kthread+0x388/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
INFO: task syz.2.4918:21109 blocked for more than 143 seconds.
      Tainted: G             L      syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.2.4918      state:D stack:22328 pid:21109 tgid:21108 ppid:14919  task_flags:0x400140 flags:0x00080002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5504 [inline]
 __schedule+0x17d9/0x56c0 kernel/sched/core.c:7228
 __schedule_loop kernel/sched/core.c:7307 [inline]
 schedule+0x164/0x360 kernel/sched/core.c:7322
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7379
 __mutex_lock_common kernel/locking/mutex.c:726 [inline]
 __mutex_lock+0x7bf/0x1550 kernel/locking/mutex.c:821
 netdev_lock include/linux/netdevice.h:2837 [inline]
 netdev_lock_ops include/net/netdev_lock.h:42 [inline]
 __ethtool_get_link_ksettings+0x109/0x250 net/ethtool/ioctl.c:463
 bond_update_speed_duplex drivers/net/bonding/bond_main.c:801 [inline]
 bond_slave_netdev_event drivers/net/bonding/bond_main.c:3982 [inline]
 bond_netdev_event+0x643/0xf80 drivers/net/bonding/bond_main.c:4089
 notifier_call_chain+0x1a5/0x3d0 kernel/notifier.c:85
 call_netdevice_notifiers_extack net/core/dev.c:2288 [inline]
 call_netdevice_notifiers net/core/dev.c:2302 [inline]
 __dev_notify_flags+0x1aa/0x310 net/core/dev.c:9793
 netif_change_flags+0xde/0x1b0 net/core/dev.c:9822
 dev_change_flags+0x128/0x260 net/core/dev_api.c:68
 vlan_device_event+0x1b4e/0x1f00 net/8021q/vlan.c:494
 notifier_call_chain+0x1a5/0x3d0 kernel/notifier.c:85
 call_netdevice_notifiers_extack net/core/dev.c:2288 [inline]
 call_netdevice_notifiers net/core/dev.c:2302 [inline]
 __dev_notify_flags+0x1aa/0x310 net/core/dev.c:9793
 netif_change_flags+0xde/0x1b0 net/core/dev.c:9822
 do_setlink+0xdd6/0x4670 net/core/rtnetlink.c:3207
 rtnl_changelink net/core/rtnetlink.c:3841 [inline]
 __rtnl_newlink net/core/rtnetlink.c:4014 [inline]
 rtnl_newlink+0x15c2/0x1bd0 net/core/rtnetlink.c:4151
 rtnetlink_rcv_msg+0x802/0xc00 net/core/rtnetlink.c:7068
 netlink_rcv_skb+0x226/0x4a0 net/netlink/af_netlink.c:2556
 netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
 netlink_unicast+0x7bb/0x940 net/netlink/af_netlink.c:1345
 netlink_sendmsg+0x813/0xb40 net/netlink/af_netlink.c:1900
 sock_sendmsg_nosec+0x13a/0x180 net/socket.c:775
 __sock_sendmsg net/socket.c:790 [inline]
 ____sys_sendmsg+0x54e/0x850 net/socket.c:2684
 ___sys_sendmsg+0x2a5/0x360 net/socket.c:2738
 __sys_sendmsg net/socket.c:2770 [inline]
 __do_sys_sendmsg net/socket.c:2775 [inline]
 __se_sys_sendmsg net/socket.c:2773 [inline]
 __x64_sys_sendmsg+0x1b1/0x290 net/socket.c:2773
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fdcc019ce59
RSP: 002b:00007fdcc1070028 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007fdcc0415fa0 RCX: 00007fdcc019ce59
RDX: 0000000000000000 RSI: 0000200000000340 RDI: 0000000000000004
RBP: 00007fdcc0232e6f R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fdcc0416038 R14: 00007fdcc0415fa0 R15: 00007fdcc053fa48
 </TASK>
INFO: task syz.3.4923:21119 blocked for more than 144 seconds.
      Tainted: G             L      syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.3.4923      state:D stack:25976 pid:21119 tgid:21119 ppid:14189  task_flags:0x400040 flags:0x00080002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5504 [inline]
 __schedule+0x17d9/0x56c0 kernel/sched/core.c:7228
 __schedule_loop kernel/sched/core.c:7307 [inline]
 schedule+0x164/0x360 kernel/sched/core.c:7322
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7379
 __mutex_lock_common kernel/locking/mutex.c:726 [inline]
 __mutex_lock+0x7bf/0x1550 kernel/locking/mutex.c:821
 tun_detach drivers/net/tun.c:641 [inline]
 tun_chr_close+0x3e/0x1c0 drivers/net/tun.c:3506
 __fput+0x418/0xa50 fs/file_table.c:512
 task_work_run+0x1d9/0x270 kernel/task_work.c:233
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 __exit_to_user_mode_loop kernel/entry/common.c:70 [inline]
 exit_to_user_mode_loop+0x1fa/0x730 kernel/entry/common.c:101
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:207 [inline]
 syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:230 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:318 [inline]
 do_syscall_64+0x353/0x580 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fc966b9ce59
RSP: 002b:00007fc966f3fba8 EFLAGS: 00000246 ORIG_RAX: 00000000000001b4
RAX: 0000000000000000 RBX: 00007fc966e17da0 RCX: 00007fc966b9ce59
RDX: 0000000000000000 RSI: 000000000000001e RDI: 0000000000000003
RBP: 00007fc966e17da0 R08: 0000000000000006 R09: 0000000000000000
R10: 00007fc966e17cb0 R11: 0000000000000246 R12: 00000000000b3ba4
R13: 00007fc966e1609c R14: 00000000000b38d2 R15: 00007fc966e16090
 </TASK>
INFO: task syz.3.4923:21121 blocked for more than 144 seconds.
      Tainted: G             L      syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.3.4923      state:D stack:28792 pid:21121 tgid:21119 ppid:14189  task_flags:0x400140 flags:0x00080002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5504 [inline]
 __schedule+0x17d9/0x56c0 kernel/sched/core.c:7228
 __schedule_loop kernel/sched/core.c:7307 [inline]
 schedule+0x164/0x360 kernel/sched/core.c:7322
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7379
 __mutex_lock_common kernel/locking/mutex.c:726 [inline]
 __mutex_lock+0x7bf/0x1550 kernel/locking/mutex.c:821
 rtnl_net_lock include/linux/rtnetlink.h:130 [inline]
 devinet_ioctl+0x2fb/0x1c50 net/ipv4/devinet.c:1120
 inet_ioctl+0x42a/0x560 net/ipv4/af_inet.c:1009
 sock_do_ioctl+0x101/0x320 net/socket.c:1300
 sock_ioctl+0x57a/0x7e0 net/socket.c:1421
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fc966b9ce59
RSP: 002b:00007fc9679b8028 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fc966e15fa0 RCX: 00007fc966b9ce59
RDX: 0000200000000040 RSI: 0000000000008914 RDI: 0000000000000004
RBP: 00007fc966c32e6f R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fc966e16038 R14: 00007fc966e15fa0 R15: 00007fc966f3fa48
 </TASK>
INFO: task syz.5.4925:21126 blocked for more than 145 seconds.
      Tainted: G             L      syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.5.4925      state:D stack:26936 pid:21126 tgid:21125 ppid:20740  task_flags:0x400140 flags:0x00080002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5504 [inline]
 __schedule+0x17d9/0x56c0 kernel/sched/core.c:7228
 __schedule_loop kernel/sched/core.c:7307 [inline]
 schedule+0x164/0x360 kernel/sched/core.c:7322
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7379
 __mutex_lock_common kernel/locking/mutex.c:726 [inline]
 __mutex_lock+0x7bf/0x1550 kernel/locking/mutex.c:821
 rtnl_lock net/core/rtnetlink.c:80 [inline]
 rtnl_nets_lock net/core/rtnetlink.c:341 [inline]
 rtnl_newlink+0x8a3/0x1bd0 net/core/rtnetlink.c:4150
 rtnetlink_rcv_msg+0x802/0xc00 net/core/rtnetlink.c:7068
 netlink_rcv_skb+0x226/0x4a0 net/netlink/af_netlink.c:2556
 netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
 netlink_unicast+0x7bb/0x940 net/netlink/af_netlink.c:1345
 netlink_sendmsg+0x813/0xb40 net/netlink/af_netlink.c:1900
 sock_sendmsg_nosec+0x13a/0x180 net/socket.c:775
 __sock_sendmsg net/socket.c:790 [inline]
 ____sys_sendmsg+0x54e/0x850 net/socket.c:2684
 ___sys_sendmsg+0x2a5/0x360 net/socket.c:2738
 __sys_sendmsg net/socket.c:2770 [inline]
 __do_sys_sendmsg net/socket.c:2775 [inline]
 __se_sys_sendmsg net/socket.c:2773 [inline]
 __x64_sys_sendmsg+0x1b1/0x290 net/socket.c:2773
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f1b77d9ce59
RSP: 002b:00007f1b78c2d028 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f1b78015fa0 RCX: 00007f1b77d9ce59
RDX: 0000000000000000 RSI: 0000200000000040 RDI: 0000000000000008
RBP: 00007f1b77e32e6f R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f1b78016038 R14: 00007f1b78015fa0 R15: 00007f1b7813fa48
 </TASK>
INFO: task syz.1.4926:21132 blocked for more than 145 seconds.
      Tainted: G             L      syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.1.4926      state:D stack:25448 pid:21132 tgid:21129 ppid:14306  task_flags:0x400140 flags:0x00080002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5504 [inline]
 __schedule+0x17d9/0x56c0 kernel/sched/core.c:7228
 __schedule_loop kernel/sched/core.c:7307 [inline]
 schedule+0x164/0x360 kernel/sched/core.c:7322
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7379
 __mutex_lock_common kernel/locking/mutex.c:726 [inline]
 __mutex_lock+0x7bf/0x1550 kernel/locking/mutex.c:821
 rtnl_net_lock include/linux/rtnetlink.h:130 [inline]
 dev_ioctl+0x7a4/0x1150 net/core/dev_ioctl.c:815
 sock_do_ioctl+0x23e/0x320 net/socket.c:1314
 sock_ioctl+0x57a/0x7e0 net/socket.c:1421
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f41c799ce59
RSP: 002b:00007f41c5bb4028 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f41c7c16180 RCX: 00007f41c799ce59
RDX: 0000200000000080 RSI: 0000000000008993 RDI: 000000000000000b
RBP: 00007f41c7a32e6f R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f41c7c16218 R14: 00007f41c7c16180 R15: 00007f41c7d3fa48
 </TASK>
INFO: lockdep is turned off.
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 30 Comm: khungtaskd Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/09/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x274/0x2d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x17a/0x300 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:162 [inline]
 __sys_info lib/sys_info.c:157 [inline]
 sys_info+0x135/0x170 lib/sys_info.c:165
 check_hung_uninterruptible_tasks kernel/hung_task.c:353 [inline]
 watchdog+0xfd7/0x1030 kernel/hung_task.c:561
 kthread+0x388/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/09/2026
RIP: 0010:pv_native_safe_halt+0xf/0x20 arch/x86/kernel/paravirt.c:64
Code: bc 7a 02 e9 13 05 03 00 cc cc cc 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 66 90 0f 00 2d 33 28 1b 00 fb f4 <c3> cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc 90 90 90 90 90
RSP: 0018:ffffffff8e607de0 EFLAGS: 00000246
RAX: ffff888125253000 RBX: ffffffff819a72e0 RCX: 0000000080000001
RDX: 0000000000000001 RSI: ffffffff8c295400 RDI: ffffffff819a72e0
RBP: ffffffff8e607eb8 R08: ffff8880b86338db R09: 1ffff110170c671b
R10: dffffc0000000000 R11: ffffed10170c671c R12: 0000000000000000
R13: 1ffffffff1cd1de8 R14: 1ffffffff1cc0fc4 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff888125253000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000563c978b0ee8 CR3: 000000000e746000 CR4: 00000000003526f0
DR0: ffffffffffffffff DR1: 8000000000000000 DR2: 00000000000003ff
DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 arch_safe_halt arch/x86/kernel/process.c:766 [inline]
 default_idle+0x9/0x20 arch/x86/kernel/process.c:767
 default_idle_call+0x72/0xb0 kernel/sched/idle.c:122
 cpuidle_idle_call kernel/sched/idle.c:199 [inline]
 do_idle+0x2e0/0x540 kernel/sched/idle.c:355
 cpu_startup_entry+0x43/0x60 kernel/sched/idle.c:454
 rest_init+0x2de/0x300 init/main.c:717
 start_kernel+0x38a/0x3e0 init/main.c:1175
 x86_64_start_reservations+0x24/0x30 arch/x86/kernel/head64.c:310
 x86_64_start_kernel+0x137/0x1b0 arch/x86/kernel/head64.c:291
 common_startup_64+0x13e/0x157
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

