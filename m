Return-Path: <netdev+bounces-121914-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A0395F36A
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 16:00:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 949BC1F22E00
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 14:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AB7E18859D;
	Mon, 26 Aug 2024 13:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V7gh+Al/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f66.google.com (mail-ua1-f66.google.com [209.85.222.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11A1FC08;
	Mon, 26 Aug 2024 13:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724680799; cv=none; b=TuGdhYcC6Jb0yuMJjjwzJcV4hhcMvpQr1Sg18bZPFBjbi8OfVGgtmxqXhpEBp3QybduLcBAVJX4qr98zQBZ812SqFerPM2IcWkc6I5esK/g45/Y21EM8eRfqc0gJG7cwu7lBx/6zN2jGkme+gCIVshCfqEqHUCIzYt2A2CTHgBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724680799; c=relaxed/simple;
	bh=VUqL4zc+RBqFe3BgHruFlsL0A9wV4xBtpmmmNbCG4+g=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=nwsG5azPQaPMJYiqTdACPuFpvm2g9Fj74k3HzIS1EtZAwcGBoqk6g/bq105+33TyznofGXCizyyS9Q4Gz7p4nZum/EiB4RJw8Wysb/PFvsHUdEXGtXSPn3D8dqpSNxeegceN2XVDqM41Q8QJJYse5gpKIPDy7HItKsaeNL8dW6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V7gh+Al/; arc=none smtp.client-ip=209.85.222.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f66.google.com with SMTP id a1e0cc1a2514c-8430670f247so1300917241.0;
        Mon, 26 Aug 2024 06:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724680795; x=1725285595; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VUqL4zc+RBqFe3BgHruFlsL0A9wV4xBtpmmmNbCG4+g=;
        b=V7gh+Al/h3nJRI8pjp4f+/dDEOruQBjiM0YLBnYRtLNxLo9RgPGEUtEPDAu9QHPWPc
         RYZ2JUruqIAIkuBYTK8H8O8f0ctZM/zcWdFV9phz43y5opsjm5v8iId1LCwwz9xCZOZx
         wRTNN7swzmYKQjqzNeE+Fx5p2G+X51Q/tlEyyEzWzRcrZL2caJQsmgrAoyD9f0/T5Mz6
         LtNt6HYc+KFyOq9Ik/3RO0Z6RhqS4TyIBnQKfdgFNoWktrHp4tlngzxXCSkExtvdKW/9
         FF3oNfujgmPc7waL7yKjYYPyYfTnXrMKUqUlxEAKNP+/u2XB+W9HoFIqctaBUZQj8v0/
         eV7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724680795; x=1725285595;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VUqL4zc+RBqFe3BgHruFlsL0A9wV4xBtpmmmNbCG4+g=;
        b=oOhxafv2uB1zvAaNNZiAu0oq//N83Dg/6p0jMd4cPssEm8ny6tDbGN/Ne/Az42mm/W
         YBLOWwg65Cn/+6tocaYDky8OdnablyXOThJeaXoIKB0NL5jmOhZhmRJ7F2gjmyk6v8Pp
         ZKY6vSoxKEe2flesMqliGc0vNcw1+hSUMsmTC+0bd5hL5Ds1xPYNLkxvnQjZrqZLo6wu
         BYlXfqFk0k55q9O5y+CZmmIibLpGnBDGSdmT/gSz9gnVHoCDUmfiluDP7G80qjNg6NfN
         2MdKzDBqZj2SyOaIq/gZs8sM/uPfkZ2XbtqQUhabrI2kRFIt9uNU3FqSeXGEi9h6nJkq
         rYgg==
X-Forwarded-Encrypted: i=1; AJvYcCV20Cfh3naxCqNvpctid5B1qpOVgTt5mKUccQyQr6AMeUD5XBZMcW305ft8uwkTZxU6HEWvHt8k@vger.kernel.org, AJvYcCVHsUACW2O3n/Hk12tI+I4GR075EgyXhdKLWvsgHckQCoZIVfb+dB5IrgIz1weDLGowAcDH9yDuB21TWrk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKy/JLNCYoVx1o2G+aUH89JOa34HEN0Gx+A5dVzBxAZQvtPNc7
	hKOUsEK9+hmZ8L1VWxsNao+QIEFYZcDDzapZhWJSRm1foLZfTOdP8tLnQHfduq74d2yyKfRVX4H
	anHeHnXvbBTZ5W3KzzeZMHPO1Zbo=
X-Google-Smtp-Source: AGHT+IEk0M0EMP20UkLJcmOOu56+vijZhYerH7AAKXmN5gmq3wwd7ZR9r1VILRlwQKTLSQmMiZrssnasDBfyWo8Doog=
X-Received: by 2002:a05:6122:1688:b0:4f5:23e4:b7c with SMTP id
 71dfb90a1353d-4fd1a894d0bmr12055382e0c.0.1724680795155; Mon, 26 Aug 2024
 06:59:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Hui Guo <guohui.study@gmail.com>
Date: Mon, 26 Aug 2024 21:59:44 +0800
Message-ID: <CAHOo4gLqEcjRFRVLw9bLVVtu8yizmQpab-Qge-zs9rTFhd1Gng@mail.gmail.com>
Subject: INFO: task hung in dev_ioctl
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Kory Maincent <kory.maincent@bootlin.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, 
	Stephen Hemminger <stephen@networkplumber.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hi Kernel Maintainers,
Our tool found the following kernel bug INFO: task hung in dev_ioctl on:
HEAD Commit: 6e4436539ae182dc86d57d13849862bcafaa4709 Merge tag
'execve-v6.11-rc4' of
git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux
console output:
https://github.com/androidAppGuard/KernelBugs/blob/main/6e4436539ae182dc86d57d13849862bcafaa4709/0d0049d3716f322084940a1d76d1d1b243c3afef/log0
kernel config: https://github.com/androidAppGuard/KernelBugs/blob/main/6b0f8db921abf0520081d779876d3a41069dab95/.config
repro log: https://github.com/androidAppGuard/KernelBugs/blob/main/6e4436539ae182dc86d57d13849862bcafaa4709/0d0049d3716f322084940a1d76d1d1b243c3afef/repro0

Unfortunately, I don't have any reproducer for this issue yet.

Please let me know if there is anything I can help.

Best,
HuiGuo

====================================[cut
here]===========================================
INFO: task syz-executor.5:17228 blocked for more than 143 seconds.
Not tainted 6.11.0-rc4-00008-g6e4436539ae1 #2
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.5 state:D stack:28368 pid:17228 tgid:17221 ppid:8441
flags:0x00100006
Call Trace:
<TASK>
context_switch data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/sched/core.c:5188
[inline]
__schedule+0xc3f/0x5390
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/sched/core.c:6529
__schedule_loop
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/sched/core.c:6606
[inline]
schedule+0xe7/0x350
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/sched/core.c:6621
schedule_preempt_disabled+0x13/0x30
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/sched/core.c:6678
__mutex_lock_common
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/locking/mutex.c:684
[inline]
__mutex_lock+0x508/0x930
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/locking/mutex.c:752
dev_ioctl+0x1c8/0x10c0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/core/dev_ioctl.c:808
sock_ioctl+0x5d3/0x6d0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/socket.c:1268
vfs_ioctl data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/fs/ioctl.c:51
[inline]
__do_sys_ioctl data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/fs/ioctl.c:907
[inline]
__se_sys_ioctl data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/fs/ioctl.c:893
[inline]
__x64_sys_ioctl+0x1a4/0x210
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/fs/ioctl.c:893
do_syscall_x64 data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/arch/x86/entry/common.c:52
[inline]
do_syscall_64+0xcb/0x250
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/arch/x86/entry/common.c:83
entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa4740afb2d
RSP: 002b:00007fa474ed0028 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fa4741ece80 RCX: 00007fa4740afb2d
RDX: 00000000200006c0 RSI: 00000000000089f0 RDI: 0000000000000006
RBP: 00007fa47410b4a1 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007fa4741ece80 R15: 00007fa474eb0000
</TASK>
INFO: task syz-executor.5:17290 blocked for more than 143 seconds.
Not tainted 6.11.0-rc4-00008-g6e4436539ae1 #2
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.5 state:D stack:27840 pid:17290 tgid:17221 ppid:8441
flags:0x00000006
Call Trace:
<TASK>
context_switch data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/sched/core.c:5188
[inline]
__schedule+0xc3f/0x5390
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/sched/core.c:6529
__schedule_loop
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/sched/core.c:6606
[inline]
schedule+0xe7/0x350
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/sched/core.c:6621
schedule_preempt_disabled+0x13/0x30
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/sched/core.c:6678
__mutex_lock_common
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/locking/mutex.c:684
[inline]
__mutex_lock+0x508/0x930
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/locking/mutex.c:752
do_ip_setsockopt+0x18a1/0x3780
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/ipv4/ip_sockglue.c:1077
ip_setsockopt+0x59/0xf0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/ipv4/ip_sockglue.c:1417
udp_setsockopt+0x84/0xd0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/ipv4/udp.c:2806
ipv6_setsockopt+0x178/0x1a0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/ipv6/ipv6_sockglue.c:988
do_sock_setsockopt+0x227/0x480
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/socket.c:2324
__sys_setsockopt+0x1a6/0x270
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/socket.c:2347
__do_sys_setsockopt
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/socket.c:2356
[inline]
__se_sys_setsockopt
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/socket.c:2353
[inline]
__x64_sys_setsockopt+0xbd/0x160
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/socket.c:2353
do_syscall_x64 data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/arch/x86/entry/common.c:52
[inline]
do_syscall_64+0xcb/0x250
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/arch/x86/entry/common.c:83
entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa4740afb2d
RSP: 002b:00007fa474eaf028 EFLAGS: 00000246 ORIG_RAX: 0000000000000036
RAX: ffffffffffffffda RBX: 00007fa4741ecf50 RCX: 00007fa4740afb2d
RDX: 0000000000000030 RSI: 0000000000000000 RDI: 0000000000000006
RBP: 00007fa47410b4a1 R08: 0000000000000190 R09: 0000000000000000
R10: 0000000020000bc0 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007fa4741ecf50 R15: 00007fa474e8f000
</TASK>

Showing all locks held in the system:
2 locks held by systemd/1:
1 lock held by khungtaskd/30:
#0: ffffffff8dbb8c60 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/./include/linux/rcupdate.h:326
[inline]
#0: ffffffff8dbb8c60 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/./include/linux/rcupdate.h:838
[inline]
#0: ffffffff8dbb8c60 (rcu_read_lock){....}-{1:2}, at:
debug_show_all_locks+0x75/0x340
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/locking/lockdep.c:6626
6 locks held by kworker/u8:2/35:
#0: ffff8880162de148 ((wq_completion)netns){+.+.}-{0:0}, at:
process_one_work+0x11ec/0x1ad0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/workqueue.c:3206
#1: ffffc90000577d88 (net_cleanup_work){+.+.}-{0:0}, at:
process_one_work+0x8ba/0x1ad0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/workqueue.c:3207
#2: ffffffff8f7f70d0 (pernet_ops_rwsem){++++}-{3:3}, at:
cleanup_net+0xbb/0xbb0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/core/net_namespace.c:594
#3: ffff88806a7300e8 (&dev->mutex){....}-{3:3}, at: device_lock
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/./include/linux/device.h:1009
[inline]
#3: ffff88806a7300e8 (&dev->mutex){....}-{3:3}, at: devl_dev_lock
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/devlink/devl_internal.h:108
[inline]
#3: ffff88806a7300e8 (&dev->mutex){....}-{3:3}, at:
devlink_pernet_pre_exit+0x120/0x2a0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/devlink/core.c:506
#4: ffff88806a733250 (&devlink->lock_key#15){+.+.}-{3:3}, at:
devl_lock data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/devlink/core.c:276
[inline]
#4: ffff88806a733250 (&devlink->lock_key#15){+.+.}-{3:3}, at:
devl_dev_lock data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/devlink/devl_internal.h:109
[inline]
#4: ffff88806a733250 (&devlink->lock_key#15){+.+.}-{3:3}, at:
devlink_pernet_pre_exit+0x12a/0x2a0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/devlink/core.c:506
#5: ffffffff8f80c968 (rtnl_mutex){+.+.}-{3:3}, at:
nsim_destroy+0x6b/0x6a0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/drivers/net/netdevsim/netdev.c:773
3 locks held by kworker/u8:4/62:
3 locks held by kswapd0/89:
2 locks held by kswapd1/90:
3 locks held by kworker/u8:7/1107:
#0: ffff88801adcb948 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at:
process_one_work+0x11ec/0x1ad0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/workqueue.c:3206
#1: ffffc90002f4fd88
((work_completion)(&(&net->ipv6.addr_chk_work)->work)){+.+.}-{0:0},
at: process_one_work+0x8ba/0x1ad0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/workqueue.c:3207
#2: ffffffff8f80c968 (rtnl_mutex){+.+.}-{3:3}, at:
addrconf_verify_work+0x12/0x30
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/ipv6/addrconf.c:4734
3 locks held by kworker/u8:8/1121:
#0: ffff888015481148 ((wq_completion)events_unbound){+.+.}-{0:0}, at:
process_one_work+0x11ec/0x1ad0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/workqueue.c:3206
#1: ffffc9000407fd88 ((linkwatch_work).work){+.+.}-{0:0}, at:
process_one_work+0x8ba/0x1ad0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/workqueue.c:3207
#2: ffffffff8f80c968 (rtnl_mutex){+.+.}-{3:3}, at:
linkwatch_event+0xf/0x70
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/core/link_watch.c:276
2 locks held by systemd-journal/4676:
#0: ffff8880239e2d78 (mapping.invalidate_lock){++++}-{3:3}, at:
filemap_invalidate_lock_shared
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/./include/linux/fs.h:854
[inline]
#0: ffff8880239e2d78 (mapping.invalidate_lock){++++}-{3:3}, at:
filemap_fault+0x13ad/0x2510
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/filemap.c:3321
#1: ffffffff8dd3cc80 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/page_alloc.c:3891
[inline]
#1: ffffffff8dd3cc80 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_direct_reclaim
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/page_alloc.c:3916
[inline]
#1: ffffffff8dd3cc80 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_slowpath
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/page_alloc.c:4322
[inline]
#1: ffffffff8dd3cc80 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_noprof+0xa51/0x21e0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/page_alloc.c:4708
2 locks held by systemd-udevd/4689:
#0: ffff8880239d4168 (mapping.invalidate_lock){++++}-{3:3}, at:
filemap_invalidate_lock_shared
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/./include/linux/fs.h:854
[inline]
#0: ffff8880239d4168 (mapping.invalidate_lock){++++}-{3:3}, at:
filemap_fault+0x13ad/0x2510
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/filemap.c:3321
#1: ffffffff8dd3cc80 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/page_alloc.c:3891
[inline]
#1: ffffffff8dd3cc80 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_direct_reclaim
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/page_alloc.c:3916
[inline]
#1: ffffffff8dd3cc80 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_slowpath
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/page_alloc.c:4322
[inline]
#1: ffffffff8dd3cc80 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_noprof+0xa51/0x21e0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/page_alloc.c:4708
2 locks held by cron/7826:
#0: ffff8880239d4168 (mapping.invalidate_lock){++++}-{3:3}, at:
filemap_invalidate_lock_shared
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/./include/linux/fs.h:854
[inline]
#0: ffff8880239d4168 (mapping.invalidate_lock){++++}-{3:3}, at:
filemap_fault+0x13ad/0x2510
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/filemap.c:3321
#1: ffffffff8dd3cc80 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/page_alloc.c:3891
[inline]
#1: ffffffff8dd3cc80 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_direct_reclaim
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/page_alloc.c:3916
[inline]
#1: ffffffff8dd3cc80 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_slowpath
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/page_alloc.c:4322
[inline]
#1: ffffffff8dd3cc80 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_noprof+0xa51/0x21e0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/page_alloc.c:4708
2 locks held by in:imklog/7890:
#0: ffff88802385ad78 (mapping.invalidate_lock){++++}-{3:3}, at:
filemap_invalidate_lock_shared
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/./include/linux/fs.h:854
[inline]
#0: ffff88802385ad78 (mapping.invalidate_lock){++++}-{3:3}, at:
filemap_fault+0x13ad/0x2510
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/filemap.c:3321
#1: ffffffff8dd3cc80 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/page_alloc.c:3891
[inline]
#1: ffffffff8dd3cc80 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_direct_reclaim
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/page_alloc.c:3916
[inline]
#1: ffffffff8dd3cc80 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_slowpath
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/page_alloc.c:4322
[inline]
#1: ffffffff8dd3cc80 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_noprof+0xa51/0x21e0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/page_alloc.c:4708
2 locks held by syz-fuzzer/8340:
#0: ffff888000e25558 (mapping.invalidate_lock){++++}-{3:3}, at:
filemap_invalidate_lock_shared
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/./include/linux/fs.h:854
[inline]
#0: ffff888000e25558 (mapping.invalidate_lock){++++}-{3:3}, at:
filemap_fault+0x13ad/0x2510
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/filemap.c:3321
#1: ffffffff8dd3cc80 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/page_alloc.c:3891
[inline]
#1: ffffffff8dd3cc80 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_direct_reclaim
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/page_alloc.c:3916
[inline]
#1: ffffffff8dd3cc80 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_slowpath
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/page_alloc.c:4322
[inline]
#1: ffffffff8dd3cc80 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_noprof+0xa51/0x21e0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/page_alloc.c:4708
2 locks held by syz-fuzzer/8344:
#0: ffff888000e25558 (mapping.invalidate_lock){++++}-{3:3}, at:
filemap_invalidate_lock_shared
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/./include/linux/fs.h:854
[inline]
#0: ffff888000e25558 (mapping.invalidate_lock){++++}-{3:3}, at:
filemap_fault+0x13ad/0x2510
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/filemap.c:3321
#1: ffffffff8dd3cc80 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/page_alloc.c:3891
[inline]
#1: ffffffff8dd3cc80 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_direct_reclaim
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/page_alloc.c:3916
[inline]
#1: ffffffff8dd3cc80 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_slowpath
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/page_alloc.c:4322
[inline]
#1: ffffffff8dd3cc80 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_noprof+0xa51/0x21e0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/page_alloc.c:4708
2 locks held by syz-fuzzer/15739:
#0: ffff888000e25558 (mapping.invalidate_lock){++++}-{3:3}, at:
filemap_invalidate_lock_shared
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/./include/linux/fs.h:854
[inline]
#0: ffff888000e25558 (mapping.invalidate_lock){++++}-{3:3}, at:
filemap_fault+0x13ad/0x2510
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/filemap.c:3321
#1: ffffffff8dd3cc80 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/page_alloc.c:3891
[inline]
#1: ffffffff8dd3cc80 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_direct_reclaim
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/page_alloc.c:3916
[inline]
#1: ffffffff8dd3cc80 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_slowpath
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/page_alloc.c:4322
[inline]
#1: ffffffff8dd3cc80 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_noprof+0xa51/0x21e0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/page_alloc.c:4708
3 locks held by kworker/1:5/13570:
#0: ffff888015478948 ((wq_completion)events){+.+.}-{0:0}, at:
process_one_work+0x11ec/0x1ad0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/workqueue.c:3206
#1: ffffc9002a537d88 (deferred_process_work){+.+.}-{0:0}, at:
process_one_work+0x8ba/0x1ad0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/workqueue.c:3207
#2: ffffffff8f80c968 (rtnl_mutex){+.+.}-{3:3}, at:
switchdev_deferred_process_work+0xe/0x20
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/switchdev/switchdev.c:104
3 locks held by kworker/1:9/14729:
1 lock held by syz-executor.4/14843:
#0: ffffffff8f80c968 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/core/rtnetlink.c:79
[inline]
#0: ffffffff8f80c968 (rtnl_mutex){+.+.}-{3:3}, at:
rtnetlink_rcv_msg+0x376/0xfb0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/core/rtnetlink.c:6644
1 lock held by syz-executor.10/15197:
#0: ffffffff8f80c968 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/core/rtnetlink.c:79
[inline]
#0: ffffffff8f80c968 (rtnl_mutex){+.+.}-{3:3}, at:
rtnetlink_rcv_msg+0x376/0xfb0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/core/rtnetlink.c:6644
2 locks held by syz-executor.13/15233:
#0: ffff88802b6f0598 (mapping.invalidate_lock){++++}-{3:3}, at:
filemap_invalidate_lock_shared
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/./include/linux/fs.h:854
[inline]
#0: ffff88802b6f0598 (mapping.invalidate_lock){++++}-{3:3}, at:
filemap_fault+0x13ad/0x2510
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/filemap.c:3321
#1: ffffffff8dd3cc80 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/page_alloc.c:3891
[inline]
#1: ffffffff8dd3cc80 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_direct_reclaim
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/page_alloc.c:3916
[inline]
#1: ffffffff8dd3cc80 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_slowpath
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/page_alloc.c:4322
[inline]
#1: ffffffff8dd3cc80 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_noprof+0xa51/0x21e0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/page_alloc.c:4708
1 lock held by syz-executor.12/15240:
#0: ffffffff8f80c968 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/core/rtnetlink.c:79
[inline]
#0: ffffffff8f80c968 (rtnl_mutex){+.+.}-{3:3}, at:
rtnetlink_rcv_msg+0x376/0xfb0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/core/rtnetlink.c:6644
1 lock held by syz-executor.1/15254:
#0: ffffffff8f80c968 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/core/rtnetlink.c:79
[inline]
#0: ffffffff8f80c968 (rtnl_mutex){+.+.}-{3:3}, at:
rtnetlink_rcv_msg+0x376/0xfb0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/core/rtnetlink.c:6644
2 locks held by syz-executor.9/15269:
#0: ffffffff8f80c968 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/core/rtnetlink.c:79
[inline]
#0: ffffffff8f80c968 (rtnl_mutex){+.+.}-{3:3}, at:
rtnetlink_rcv_msg+0x376/0xfb0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/core/rtnetlink.c:6644
#1: ffffffff8dd3cc80 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/page_alloc.c:3891
[inline]
#1: ffffffff8dd3cc80 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_direct_reclaim
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/page_alloc.c:3916
[inline]
#1: ffffffff8dd3cc80 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_slowpath
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/page_alloc.c:4322
[inline]
#1: ffffffff8dd3cc80 (fs_reclaim){+.+.}-{0:0}, at:
__alloc_pages_noprof+0xa51/0x21e0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/page_alloc.c:4708
1 lock held by syz-executor.14/15271:
#0: ffffffff8f80c968 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/core/rtnetlink.c:79
[inline]
#0: ffffffff8f80c968 (rtnl_mutex){+.+.}-{3:3}, at:
rtnetlink_rcv_msg+0x376/0xfb0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/core/rtnetlink.c:6644
1 lock held by syz-executor.8/15270:
#0: ffffffff8f80c968 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/core/rtnetlink.c:79
[inline]
#0: ffffffff8f80c968 (rtnl_mutex){+.+.}-{3:3}, at:
rtnetlink_rcv_msg+0x376/0xfb0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/core/rtnetlink.c:6644
1 lock held by syz-executor.15/15282:
#0: ffffffff8f80c968 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/core/rtnetlink.c:79
[inline]
#0: ffffffff8f80c968 (rtnl_mutex){+.+.}-{3:3}, at:
rtnetlink_rcv_msg+0x376/0xfb0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/core/rtnetlink.c:6644
1 lock held by syz-executor.7/15280:
#0: ffffffff8f80c968 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/core/rtnetlink.c:79
[inline]
#0: ffffffff8f80c968 (rtnl_mutex){+.+.}-{3:3}, at:
rtnetlink_rcv_msg+0x376/0xfb0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/core/rtnetlink.c:6644
1 lock held by syz-executor.5/17228:
#0: ffffffff8f80c968 (rtnl_mutex){+.+.}-{3:3}, at:
dev_ioctl+0x1c8/0x10c0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/core/dev_ioctl.c:808
1 lock held by syz-executor.5/17290:
#0: ffffffff8f80c968 (rtnl_mutex){+.+.}-{3:3}, at:
do_ip_setsockopt+0x18a1/0x3780
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/ipv4/ip_sockglue.c:1077

=============================================

NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 30 Comm: khungtaskd Not tainted
6.11.0-rc4-00008-g6e4436539ae1 #2
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
Call Trace:
<TASK>
__dump_stack data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/lib/dump_stack.c:93
[inline]
dump_stack_lvl+0x116/0x1b0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/lib/dump_stack.c:119
nmi_cpu_backtrace+0x2a0/0x350
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/lib/nmi_backtrace.c:113
nmi_trigger_cpumask_backtrace+0x29c/0x300
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/lib/nmi_backtrace.c:62
trigger_all_cpu_backtrace
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/./include/linux/nmi.h:162
[inline]
check_hung_uninterruptible_tasks
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/hung_task.c:223
[inline]
watchdog+0xe5b/0x1180
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/hung_task.c:379
kthread+0x2ca/0x3b0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/kthread.c:389
ret_from_fork+0x48/0x80
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/arch/x86/kernel/process.c:147
ret_from_fork_asm+0x1a/0x30
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/arch/x86/entry/entry_64.S:244
</TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 62 Comm: kworker/u8:4 Not tainted
6.11.0-rc4-00008-g6e4436539ae1 #2
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
Workqueue: bat_events batadv_nc_worker
RIP: 0010:__local_bh_enable_ip+0xac/0x120
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/softirq.c:389
Code: 1d 01 8b b4 7e 65 8b 05 fa 8a b4 7e a9 00 ff ff 00 74 4d bf 01
00 00 00 e8 e1 5a 0b 00 e8 1c e8 41 00 fb 65 8b 05 dc 8a b4 7e <85> c0
74 52 5b 5d e9 69 ee a6 09 65 8b 05 1e 38 b3 7e 85 c0 75 9e
RSP: 0018:ffffc90000eb7bb8 EFLAGS: 00000206
RAX: 0000000080000000 RBX: 00000000fffffe00 RCX: 1ffffffff287cf87
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffffff8ab8cbc8 R08: 0000000000000001 R09: fffffbfff2870efe
R10: 0000000000000001 R11: 0000000000000000 R12: dffffc0000000000
R13: ffffffff8ab8c890 R14: 000000000000006c R15: ffff88807c308cc0
FS: 0000000000000000(0000) GS:ffff88802c400000(0000) knlGS:0000000000000000
CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f4d1fd7b08c CR3: 000000000d97c000 CR4: 0000000000350ef0
Call Trace:
<NMI>
</NMI>
<TASK>
spin_unlock_bh data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/./include/linux/spinlock.h:396
[inline]
batadv_nc_purge_paths+0x1c8/0x3b0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/batman-adv/network-coding.c:471
batadv_nc_worker+0x88c/0xf90
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/batman-adv/network-coding.c:720
process_one_work+0x95a/0x1ad0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/workqueue.c:3231
process_scheduled_works
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/workqueue.c:3312
[inline]
worker_thread+0x680/0xeb0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/workqueue.c:3390
kthread+0x2ca/0x3b0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/kthread.c:389
ret_from_fork+0x48/0x80
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/arch/x86/kernel/process.c:147
ret_from_fork_asm+0x1a/0x30
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/arch/x86/entry/entry_64.S:244
</TASK>

==========================================================================================
This report is generated by reproducing the syz repro. It may contain errors.

