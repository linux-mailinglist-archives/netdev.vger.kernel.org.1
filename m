Return-Path: <netdev+bounces-112829-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7968293B6B3
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 20:28:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE0CD1F21388
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 18:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB4E16A37C;
	Wed, 24 Jul 2024 18:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uPJwAQ4J"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A0915F316
	for <netdev@vger.kernel.org>; Wed, 24 Jul 2024 18:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721845707; cv=none; b=qXOHRtjlp20JnuarDwlVaqWOa7ZLi5Yn54b/rmrGPakAYNQNBa+zn0GJNgwQYxG//QoF0JrpB3QIz/LBJGYYozrBg64g8Uv4r79t2jsdwkWHJQZfnvf49YnFkmiY47yDo7w4PTB28m6ACa0gy2CBRHWRBG6TQmswe0FX/JeKzKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721845707; c=relaxed/simple;
	bh=S4UuPaOeQegpcux1vdA8ck7I5j9oS8niiT0wiJJfVtM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hDt5T2EKf6jdurqWKGJOg+UOYWgsWP+eGa6+GMtWtV4xdQ4d94DJWIDB7JRGpP1efXpprdLbFjDGyJTsCNT3Cd4I9fc+Gzw7MoGFO2lzaPkSPHBGujTLexeF9QqX/qSK6lt1XCkHfQT7m7RTqC0yhsKb5/ppjpHdy+pTVYUr8j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uPJwAQ4J; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5a1b073d7cdso2772a12.0
        for <netdev@vger.kernel.org>; Wed, 24 Jul 2024 11:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721845704; x=1722450504; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wMh0TnqzA9zHl181eCCj30xXLhPmTG5NZ0Fu6v3Zwos=;
        b=uPJwAQ4JRkfwcZPEbGhKeCMbE8sblmSbK9DKdR+khUKEVe3iwflDRJWy+v/FIjWx8x
         e0XGFvLXS11xs/5Z2EHI0jYDo6LrMo3SinI7XJn4J/F3NdKf+Lq0zZTJeSBgTaJeTSrq
         2K0Fe8e6F/B2ZSGbOGTe6mWw6IbzJMbKhDoUgpD8LZaJr8Kt31HqOROKcsMmdUJPQuB1
         LMFteAEpA3H9211e1oMkUEFLLOyjUkFhL8d6Su0yrzNOMvnw1+/vf4ndWJBXh+n85eTn
         zZo0VwZD1OxjmWI2XSSCgw42+xwrrYuQlfX3MX3Xa4Ui0TaBEqEea/RNjTV8sw3Ef2XV
         ZtEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721845704; x=1722450504;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wMh0TnqzA9zHl181eCCj30xXLhPmTG5NZ0Fu6v3Zwos=;
        b=qui3uoLA7JVHn7raz/rMlsXyhgwhYnjy3nXYcA+pDxig9kclgScHieAbljVyqb1CCB
         RqxCXek2p0jbquz4lTqGPA1SPrz/yc4EHmAuNvZ4g8sdv4OQythtsowu8YKAegFjpWX3
         yo2Xq0dFRi6dYj4WY6yqLyiRTr5gHdUHiuaMJ4jVcjbladlUaEVs6a7YR+ZJHKXMUAA/
         315UhTQevkXzhoE9wD0adkGSuT4g4gb7z0fJD1JG2O9i44V1vyTkVTtrof0i1gcPfCBp
         2XRUlkn9lZYjbfFneIRm16IVugXeShr6bIrum3mcB4MlwDod4nM17CZawyMwvcD6y7T2
         pJvg==
X-Forwarded-Encrypted: i=1; AJvYcCXacKHiNOLD7FV3EDvA6tFX1/0VTr50jaokXb5oNRgAEVjuS3jkqsEBP0mZZe4ABZFNvjz9i/Kw76kIs7VNnX6deiezRWE1
X-Gm-Message-State: AOJu0Yw8haYZ/vrvSbiox3fL9uiE7AhToycBEsZaV3b8Y5NlmIfdNQcb
	pdnQ471g1EtkagSUxem8vPRn/GUJ7wohnLClcstwqjbBqmcJjphRITOOQFkvjwhW4UXpfSL6BHY
	uJQfFPU5Fbf4zGGT79bUbtm3vjYNUgqG05smkcdDk5bva6Rmmg5AZ
X-Google-Smtp-Source: AGHT+IGijS5gHIVjnX9tsuJCD+rrP6DCwLUr4GswhEu7V419kX/pyZdzpIVEo8hL8jpdobrXD4yUkhzhTz85IY+JQ+s=
X-Received: by 2002:a05:6402:40c3:b0:58b:93:b624 with SMTP id
 4fb4d7f45d1cf-5ac2a3d8998mr25856a12.1.1721845703482; Wed, 24 Jul 2024
 11:28:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <00000000000027b189061e021f49@google.com>
In-Reply-To: <00000000000027b189061e021f49@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 24 Jul 2024 20:28:09 +0200
Message-ID: <CANn89iK3061x4Q9XA_uUHvTsfeVXSOFVpFBNh1jG8=ZSG+1eag@mail.gmail.com>
Subject: Re: [syzbot] [net?] INFO: task hung in nsim_create (2)
To: syzbot <syzbot+90fd70a665715bd10258@syzkaller.appspotmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 24, 2024 at 8:05=E2=80=AFPM syzbot
<syzbot+90fd70a665715bd10258@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    68b59730459e Merge tag 'perf-tools-for-v6.11-2024-07-16' =
o..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D13e0a19598000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Db6230d83d52af=
231
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D90fd70a665715bd=
10258
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Deb=
ian) 2.40
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/2ed0d621f118/dis=
k-68b59730.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/36b453c7acac/vmlinu=
x-68b59730.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/069a896ef41a/b=
zImage-68b59730.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+90fd70a665715bd10258@syzkaller.appspotmail.com
>
> INFO: task kworker/u8:5:570 blocked for more than 143 seconds.
>       Not tainted 6.10.0-syzkaller-08280-g68b59730459e #0
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:kworker/u8:5    state:D stack:20528 pid:570   tgid:570   ppid:2     =
 flags:0x00004000
> Workqueue: netns cleanup_net
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5188 [inline]
>  __schedule+0x1800/0x4a60 kernel/sched/core.c:6529
>  __schedule_loop kernel/sched/core.c:6606 [inline]
>  schedule+0x14b/0x320 kernel/sched/core.c:6621
>  schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6678
>  __mutex_lock_common kernel/locking/mutex.c:684 [inline]
>  __mutex_lock+0x6a4/0xd70 kernel/locking/mutex.c:752
>  nsim_init_netdevsim drivers/net/netdevsim/netdev.c:678 [inline]
>  nsim_create+0x408/0x890 drivers/net/netdevsim/netdev.c:750
>  __nsim_dev_port_add+0x6c0/0xae0 drivers/net/netdevsim/dev.c:1390
>  nsim_dev_port_add_all drivers/net/netdevsim/dev.c:1446 [inline]
>  nsim_dev_reload_create drivers/net/netdevsim/dev.c:1498 [inline]
>  nsim_dev_reload_up+0x69b/0x8e0 drivers/net/netdevsim/dev.c:985
>  devlink_reload+0x478/0x870 net/devlink/dev.c:474
>  devlink_pernet_pre_exit+0x1f3/0x440 net/devlink/core.c:509
>  ops_pre_exit_list net/core/net_namespace.c:163 [inline]
>  cleanup_net+0x615/0xcc0 net/core/net_namespace.c:620
>  process_one_work kernel/workqueue.c:3231 [inline]
>  process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
>  worker_thread+0x86d/0xd40 kernel/workqueue.c:3390
>  kthread+0x2f0/0x390 kernel/kthread.c:389
>  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>  </TASK>
> INFO: task kworker/u8:7:2410 blocked for more than 144 seconds.
>       Not tainted 6.10.0-syzkaller-08280-g68b59730459e #0
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:kworker/u8:7    state:D stack:23312 pid:2410  tgid:2410  ppid:2     =
 flags:0x00004000
> Workqueue: ipv6_addrconf addrconf_dad_work
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5188 [inline]
>  __schedule+0x1800/0x4a60 kernel/sched/core.c:6529
>  __schedule_loop kernel/sched/core.c:6606 [inline]
>  schedule+0x14b/0x320 kernel/sched/core.c:6621
>  schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6678
>  __mutex_lock_common kernel/locking/mutex.c:684 [inline]
>  __mutex_lock+0x6a4/0xd70 kernel/locking/mutex.c:752
>  addrconf_dad_work+0xd0/0x16f0 net/ipv6/addrconf.c:4194
>  process_one_work kernel/workqueue.c:3231 [inline]
>  process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
>  worker_thread+0x86d/0xd40 kernel/workqueue.c:3390
>  kthread+0x2f0/0x390 kernel/kthread.c:389
>  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>  </TASK>
> INFO: task dhcpcd:4769 blocked for more than 145 seconds.
>       Not tainted 6.10.0-syzkaller-08280-g68b59730459e #0
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:dhcpcd          state:D
>  stack:20384 pid:4769  tgid:4769  ppid:4768   flags:0x00000002
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5188 [inline]
>  __schedule+0x1800/0x4a60 kernel/sched/core.c:6529
>  __schedule_loop kernel/sched/core.c:6606 [inline]
>  schedule+0x14b/0x320 kernel/sched/core.c:6621
>  schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6678
>  __mutex_lock_common kernel/locking/mutex.c:684 [inline]
>  __mutex_lock+0x6a4/0xd70 kernel/locking/mutex.c:752
>  rtnl_lock net/core/rtnetlink.c:79 [inline]
>  rtnetlink_rcv_msg+0x6e6/0xcf0 net/core/rtnetlink.c:6644
>  netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2550
>  netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
>  netlink_unicast+0x7f0/0x990 net/netlink/af_netlink.c:1357
>  netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1901
>  sock_sendmsg_nosec net/socket.c:730 [inline]
>  __sock_sendmsg+0x221/0x270 net/socket.c:745
>  ____sys_sendmsg+0x525/0x7d0 net/socket.c:2597
>  ___sys_sendmsg net/socket.c:2651 [inline]
>  __sys_sendmsg+0x2b0/0x3a0 net/socket.c:2680
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f9d6db7da4b
> RSP: 002b:00007ffd2f22e8c8 EFLAGS: 00000246
>  ORIG_RAX: 000000000000002e
> RAX: ffffffffffffffda RBX: 00007f9d6daa56c0 RCX: 00007f9d6db7da4b
> RDX: 0000000000000000 RSI: 00007ffd2f242a78 RDI: 0000000000000005
> RBP: 0000000000000005 R08: 0000000000000000 R09: 00007ffd2f242a78
> R10: 0000000000000000 R11: 0000000000000246 R12: ffffffffffffffff
> R13: 00007ffd2f242a78 R14: 0000000000000030 R15: 0000000000000001
>  </TASK>
> INFO: task udevd:5105 blocked for more than 146 seconds.
>       Not tainted 6.10.0-syzkaller-08280-g68b59730459e #0
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:udevd           state:D
>  stack:24864 pid:5105  tgid:5105  ppid:4555   flags:0x00000002
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5188 [inline]
>  __schedule+0x1800/0x4a60 kernel/sched/core.c:6529
>  __schedule_loop kernel/sched/core.c:6606 [inline]
>  schedule+0x14b/0x320 kernel/sched/core.c:6621
>  schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6678
>  __mutex_lock_common kernel/locking/mutex.c:684 [inline]
>  __mutex_lock+0x6a4/0xd70 kernel/locking/mutex.c:752
>  device_lock include/linux/device.h:1009 [inline]
>  uevent_show+0x17d/0x340 drivers/base/core.c:2743
>  dev_attr_show+0x55/0xc0 drivers/base/core.c:2437
>  sysfs_kf_seq_show+0x331/0x4c0 fs/sysfs/file.c:59
>  seq_read_iter+0x445/0xd60 fs/seq_file.c:230
>  new_sync_read fs/read_write.c:395 [inline]
>  vfs_read+0x9bd/0xbc0 fs/read_write.c:476
>  ksys_read+0x1a0/0x2c0 fs/read_write.c:619
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7fda18b16b6a
> RSP: 002b:00007ffcf336bed8 EFLAGS: 00000246
>  ORIG_RAX: 0000000000000000
> RAX: ffffffffffffffda RBX: 00005588202d8730 RCX: 00007fda18b16b6a
> RDX: 0000000000001000 RSI: 0000558820307980 RDI: 0000000000000008
> RBP: 00005588202d8730 R08: 0000000000000008 R09: 0000000000000008
> R10: 000000000000010f R11: 0000000000000246 R12: 0000000000000000
> R13: 0000000000003fff R14: 00007ffcf336c3b8 R15: 000000000000000a
>  </TASK>
> INFO: task syz-executor:5304 blocked for more than 147 seconds.
>       Not tainted 6.10.0-syzkaller-08280-g68b59730459e #0
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:syz-executor    state:D stack:20216 pid:5304  tgid:5304  ppid:1     =
 flags:0x00004006
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5188 [inline]
>  __schedule+0x1800/0x4a60 kernel/sched/core.c:6529
>  __schedule_loop kernel/sched/core.c:6606 [inline]
>  schedule+0x14b/0x320 kernel/sched/core.c:6621
>  schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6678
>  __mutex_lock_common kernel/locking/mutex.c:684 [inline]
>  __mutex_lock+0x6a4/0xd70 kernel/locking/mutex.c:752
>  nsim_destroy+0x71/0x5c0 drivers/net/netdevsim/netdev.c:773
>  __nsim_dev_port_del+0x14b/0x1b0 drivers/net/netdevsim/dev.c:1425
>  nsim_dev_port_del_all drivers/net/netdevsim/dev.c:1437 [inline]
>  nsim_dev_reload_destroy+0x28a/0x490 drivers/net/netdevsim/dev.c:1658
>  nsim_drv_remove+0x58/0x160 drivers/net/netdevsim/dev.c:1673
>  device_remove drivers/base/dd.c:566 [inline]
>  __device_release_driver drivers/base/dd.c:1270 [inline]
>  device_release_driver_internal+0x4a9/0x7c0 drivers/base/dd.c:1293
>  bus_remove_device+0x34f/0x420 drivers/base/bus.c:574
>  device_del+0x57a/0x9b0 drivers/base/core.c:3868
>  device_unregister+0x20/0xc0 drivers/base/core.c:3909
>  nsim_bus_dev_del drivers/net/netdevsim/bus.c:462 [inline]
>  del_device_store+0x363/0x480 drivers/net/netdevsim/bus.c:226
>  kernfs_fop_write_iter+0x3a1/0x500 fs/kernfs/file.c:334
>  new_sync_write fs/read_write.c:497 [inline]
>  vfs_write+0xa72/0xc90 fs/read_write.c:590
>  ksys_write+0x1a0/0x2c0 fs/read_write.c:643
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f9e2b3746df
> RSP: 002b:00007f9e2b62f220 EFLAGS: 00000293
>  ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 00007f9e2b3746df
> RDX: 0000000000000001 RSI: 00007f9e2b62f270 RDI: 0000000000000005
> RBP: 00007f9e2b3e45b2 R08: 0000000000000000 R09: 00007f9e2b62f077
> R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000001
> R13: 00007f9e2b62f270 R14: 00007f9e2c034620 R15: 0000000000000003
>  </TASK>
> INFO: task syz-executor:5325 blocked for more than 148 seconds.
>       Not tainted 6.10.0-syzkaller-08280-g68b59730459e #0
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:syz-executor    state:D
>  stack:21104 pid:5325  tgid:5325  ppid:1      flags:0x00000004
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5188 [inline]
>  __schedule+0x1800/0x4a60 kernel/sched/core.c:6529
>  __schedule_loop kernel/sched/core.c:6606 [inline]
>  schedule+0x14b/0x320 kernel/sched/core.c:6621
>  schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6678
>  __mutex_lock_common kernel/locking/mutex.c:684 [inline]
>  __mutex_lock+0x6a4/0xd70 kernel/locking/mutex.c:752
>  rtnl_lock net/core/rtnetlink.c:79 [inline]
>  rtnetlink_rcv_msg+0x6e6/0xcf0 net/core/rtnetlink.c:6644
>  netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2550
>  netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
>  netlink_unicast+0x7f0/0x990 net/netlink/af_netlink.c:1357
>  netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1901
>  sock_sendmsg_nosec net/socket.c:730 [inline]
>  __sock_sendmsg+0x221/0x270 net/socket.c:745
>  __sys_sendto+0x3a4/0x4f0 net/socket.c:2204
>  __do_sys_sendto net/socket.c:2216 [inline]
>  __se_sys_sendto net/socket.c:2212 [inline]
>  __x64_sys_sendto+0xde/0x100 net/socket.c:2212
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f1d9e3778ec
> RSP: 002b:00007f1d9e62f630 EFLAGS: 00000293
>  ORIG_RAX: 000000000000002c
> RAX: ffffffffffffffda RBX: 00007f1d9f034620 RCX: 00007f1d9e3778ec
> RDX: 0000000000000020 RSI: 00007f1d9f034670 RDI: 0000000000000003
> RBP: 0000000000000000 R08: 00007f1d9e62f684 R09: 000000000000000c
> R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000003
> R13: 0000000000000000 R14: 00007f1d9f034670 R15: 0000000000000000
>  </TASK>
> INFO: task syz-executor:5383 blocked for more than 149 seconds.
>       Not tainted 6.10.0-syzkaller-08280-g68b59730459e #0
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:syz-executor    state:D
>  stack:21728 pid:5383  tgid:5383  ppid:1      flags:0x00000004
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5188 [inline]
>  __schedule+0x1800/0x4a60 kernel/sched/core.c:6529
>  __schedule_loop kernel/sched/core.c:6606 [inline]
>  schedule+0x14b/0x320 kernel/sched/core.c:6621
>  schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6678
>  __mutex_lock_common kernel/locking/mutex.c:684 [inline]
>  __mutex_lock+0x6a4/0xd70 kernel/locking/mutex.c:752
>  rtnl_lock net/core/rtnetlink.c:79 [inline]
>  rtnetlink_rcv_msg+0x6e6/0xcf0 net/core/rtnetlink.c:6644
>  netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2550
>  netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
>  netlink_unicast+0x7f0/0x990 net/netlink/af_netlink.c:1357
>  netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1901
>  sock_sendmsg_nosec net/socket.c:730 [inline]
>  __sock_sendmsg+0x221/0x270 net/socket.c:745
>  __sys_sendto+0x3a4/0x4f0 net/socket.c:2204
>  __do_sys_sendto net/socket.c:2216 [inline]
>  __se_sys_sendto net/socket.c:2212 [inline]
>  __x64_sys_sendto+0xde/0x100 net/socket.c:2212
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f4baeb778ec
> RSP: 002b:00007f4baee2f6b0 EFLAGS: 00000293 ORIG_RAX: 000000000000002c
> RAX: ffffffffffffffda RBX: 00007f4baf834620 RCX: 00007f4baeb778ec
> RDX: 000000000000003c RSI: 00007f4baf834670 RDI: 0000000000000003
> RBP: 0000000000000000 R08: 00007f4baee2f704 R09: 000000000000000c
> R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000003
> R13: 0000000000000000 R14: 00007f4baf834670 R15: 0000000000000000
>  </TASK>
> INFO: task syz.3.62:5420 blocked for more than 150 seconds.
>       Not tainted 6.10.0-syzkaller-08280-g68b59730459e #0
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:syz.3.62        state:D stack:22288 pid:5420  tgid:5419  ppid:5118  =
 flags:0x00004006
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5188 [inline]
>  __schedule+0x1800/0x4a60 kernel/sched/core.c:6529
>  __schedule_loop kernel/sched/core.c:6606 [inline]
>  schedule+0x14b/0x320 kernel/sched/core.c:6621
>  schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6678
>  __mutex_lock_common kernel/locking/mutex.c:684 [inline]
>  __mutex_lock+0x6a4/0xd70 kernel/locking/mutex.c:752
>  netdev_wait_allrefs_any net/core/dev.c:10622 [inline]
>  netdev_run_todo+0x7b2/0x1000 net/core/dev.c:10741
>  rtnl_unlock net/core/rtnetlink.c:152 [inline]
>  rtnetlink_rcv_msg+0x748/0xcf0 net/core/rtnetlink.c:6648
>  netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2550
>  netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
>  netlink_unicast+0x7f0/0x990 net/netlink/af_netlink.c:1357
>  netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1901
>  sock_sendmsg_nosec net/socket.c:730 [inline]
>  __sock_sendmsg+0x221/0x270 net/socket.c:745
>  ____sys_sendmsg+0x525/0x7d0 net/socket.c:2597
>  ___sys_sendmsg net/socket.c:2651 [inline]
>  __sys_sendmsg+0x2b0/0x3a0 net/socket.c:2680
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f5b41f75b59
> RSP: 002b:00007f5b42cf2048 EFLAGS: 00000246
>  ORIG_RAX: 000000000000002e
> RAX: ffffffffffffffda RBX: 00007f5b42105f60 RCX: 00007f5b41f75b59
> RDX: 0000000000000000 RSI: 0000000020000140 RDI: 0000000000000006
> RBP: 00007f5b41fe4e5d R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 000000000000000b R14: 00007f5b42105f60 R15: 00007f5b4222fa78
>  </TASK>
> INFO: task syz-executor:5430 blocked for more than 151 seconds.
>       Not tainted 6.10.0-syzkaller-08280-g68b59730459e #0
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:syz-executor    state:D
>  stack:25264 pid:5430  tgid:5430  ppid:1      flags:0x00004004
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5188 [inline]
>  __schedule+0x1800/0x4a60 kernel/sched/core.c:6529
>  __schedule_loop kernel/sched/core.c:6606 [inline]
>  schedule+0x14b/0x320 kernel/sched/core.c:6621
>  schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6678
>  __mutex_lock_common kernel/locking/mutex.c:684 [inline]
>  __mutex_lock+0x6a4/0xd70 kernel/locking/mutex.c:752
>  register_nexthop_notifier+0x84/0x290 net/ipv4/nexthop.c:3871
>  ops_init+0x359/0x610 net/core/net_namespace.c:139
>  setup_net+0x515/0xca0 net/core/net_namespace.c:343
>  copy_net_ns+0x4e2/0x7b0 net/core/net_namespace.c:508
>  create_new_namespaces+0x425/0x7b0 kernel/nsproxy.c:110
>  unshare_nsproxy_namespaces+0x124/0x180 kernel/nsproxy.c:228
>  ksys_unshare+0x619/0xc10 kernel/fork.c:3308
>  __do_sys_unshare kernel/fork.c:3379 [inline]
>  __se_sys_unshare kernel/fork.c:3377 [inline]
>  __x64_sys_unshare+0x38/0x40 kernel/fork.c:3377
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f61f45772b7
> RSP: 002b:00007f61f482ffa8 EFLAGS: 00000206 ORIG_RAX: 0000000000000110
> RAX: ffffffffffffffda RBX: 00007f61f45e4bd1 RCX: 00007f61f45772b7
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000040000000
> RBP: 0000000000000000 R08: 00007f61f5237d60 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000206 R12: 000000000000000c
> R13: 0000000000000003 R14: 0000000000000009 R15: 0000000000000009
>  </TASK>
> INFO: task syz-executor:5432 blocked for more than 152 seconds.
>       Not tainted 6.10.0-syzkaller-08280-g68b59730459e #0
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:syz-executor    state:D
>  stack:25712 pid:5432  tgid:5432  ppid:1      flags:0x00004006
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5188 [inline]
>  __schedule+0x1800/0x4a60 kernel/sched/core.c:6529
>  __schedule_loop kernel/sched/core.c:6606 [inline]
>  schedule+0x14b/0x320 kernel/sched/core.c:6621
>  schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6678
>  __mutex_lock_common kernel/locking/mutex.c:684 [inline]
>  __mutex_lock+0x6a4/0xd70 kernel/locking/mutex.c:752
>  register_nexthop_notifier+0x84/0x290 net/ipv4/nexthop.c:3871
>  ops_init+0x359/0x610 net/core/net_namespace.c:139
>  setup_net+0x515/0xca0 net/core/net_namespace.c:343
>  copy_net_ns+0x4e2/0x7b0 net/core/net_namespace.c:508
>  create_new_namespaces+0x425/0x7b0 kernel/nsproxy.c:110
>  unshare_nsproxy_namespaces+0x124/0x180 kernel/nsproxy.c:228
>  ksys_unshare+0x619/0xc10 kernel/fork.c:3308
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>
> If you want to undo deduplication, reply with:
> #syz undup

The fact that netdevsim uses a sysfs file to add/delete netdevice
seems unfortunate,
because of the classical sysfs vs rtnl issue (see rtnl_trylock() calls
in net/core/net-sysfs.c for reference)

