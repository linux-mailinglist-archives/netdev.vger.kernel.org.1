Return-Path: <netdev+bounces-130031-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F5E7987A06
	for <lists+netdev@lfdr.de>; Thu, 26 Sep 2024 22:14:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B6A81C23459
	for <lists+netdev@lfdr.de>; Thu, 26 Sep 2024 20:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA52417C9E7;
	Thu, 26 Sep 2024 20:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P57nIskz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF969156F20
	for <netdev@vger.kernel.org>; Thu, 26 Sep 2024 20:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727381674; cv=none; b=R6z57VFP0ejAnA7AkIiRAYQs91h8lXrJWH/cwRHNXf70ukbjdnBhfjk6MnLJ6YmLMMm02r+xHyLZbND4pscqm4BrvkkR06H1r9AUUCOGskKw4+cCrl0+an3nq4TQBOcvbsSlWXoy19tHD9Gh6+VUBAaMDhob6rJ0tGIPIK5K4I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727381674; c=relaxed/simple;
	bh=nqcSGmuoT/7iCNZuicbzu9vkIhUd++TYI1YEM7uGLkw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E/n7wA/R92QLA6+hj8cQCue2OvIfBCPjqU7HMyDJlKgE7fKtVWUGluxrCz4jcoPmPqJkhsiTocc8PGo8uzuSuGw/kEphfftptH0e254d/TJcc4SKJVWBJEDatX26yjn1ddLRduPQDjLToqL5pXpOvd3WRrPTWhjAnKUhCGV/yZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P57nIskz; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-83255877364so47257339f.1
        for <netdev@vger.kernel.org>; Thu, 26 Sep 2024 13:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727381670; x=1727986470; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T3T5NWUT2PzKSukS1j5jILxa78BV7hTIMMQzKIqGaPc=;
        b=P57nIskzD08uFg8X9//7XaNc6GZGdeYdPaTmbKBYE8hOIBK3aJZTzyDG0AgxPbwhyp
         0v7r+loJX9rE0WSqbYzORxTNIjbeM5SaxclAMAbsgTXxYQ5nlJLPhlmNbxoqmrI0ibI9
         dI6i3FWsEg8mmAHVkCMkCIwCaA8bwKCNgE+yJjhM/rwrWHcKBBSXTNM/Nqm0XtzYMJCa
         TEbP/guxLKNpud7F6AOJ1YkwfDfReDNXf0/S8liffkW44lmR6rEE8fpjtI4qlRxxkUgW
         E8lSlG5P2pA3QxA/m0ku713PrO5GKR32Guv5LIyIw0o0DOGwnamrvOjIrdB0w5suRMHi
         2ISQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727381670; x=1727986470;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T3T5NWUT2PzKSukS1j5jILxa78BV7hTIMMQzKIqGaPc=;
        b=wHQjhrX6RYj42g+XWOhoybT6MO44LUUOLc05pay1Zc9EAuRbTkTuJzTZkLWhwkTToL
         yc4DCDh7349Tt48sGMUPn65LBv+yBJNfMjMMFZVygiuggd+VJYPCGRumSJBucKMdEXnA
         GkudOFjEF638FyKDIwlYml50Z5FK6Kusgpji2fW3cRCJoXhW6UptAIMVWZtHNceDD9dk
         1JWq2rynl0pj254PttuFD5Wnn5AGd9JK9O/uMprhFn/q90HEHAtWReIDTlSexxnEDSDj
         WocphGWv/a1wFscMNY4EHEce0V/LoZVAulrn3R4za9qR8hZUlhf0//b5NLSU+A+++3It
         4CAw==
X-Forwarded-Encrypted: i=1; AJvYcCUUWx5IzS+Mckfr7oULRaOZToz09Z3azFevq8PHxve2M5vI+ahwXyRhIgLoLhcB+a5Mpu+OpzQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3UsgvCtfbVLWJnPsSVHkvacRJC7S9vmPAGbT1vZfXhD26HVDZ
	4YOnBJVoyvD3XxC+dK0+YGHiu2vg1PvQNGvYXFBPDC9kzJdkQKDu/KUg7N1pvfW1D5gBW8MxH0I
	sCs73McvOzp3RJSRfIFReftUTCFCEKETWBsn5
X-Google-Smtp-Source: AGHT+IF3MZMw0Cl0kuGsQ+xkSaHWh9hO6huR2jQ7mzx+/tvQGXYjv3vAhEn6Q3OFoklUbLhfD3juGBeiPwkgp8sFQJg=
X-Received: by 2002:a05:6602:1493:b0:82a:2791:28e with SMTP id
 ca18e2360f4ac-834931d11b0mr106297639f.7.1727381669484; Thu, 26 Sep 2024
 13:14:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <66f5a0ca.050a0220.46d20.0002.GAE@google.com>
In-Reply-To: <66f5a0ca.050a0220.46d20.0002.GAE@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 26 Sep 2024 22:14:14 +0200
Message-ID: <CANn89iKLTNs5LAuSz6xeKB39hQ2FOEJNmffZsv1F3iNHqXe0tQ@mail.gmail.com>
Subject: Re: [syzbot] [net?] INFO: task hung in new_device_store (5)
To: syzbot <syzbot+05f9cecd28e356241aba@syzkaller.appspotmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 26, 2024 at 7:58=E2=80=AFPM syzbot
<syzbot+05f9cecd28e356241aba@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    97d8894b6f4c Merge tag 'riscv-for-linus-6.12-mw1' of git:=
/..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D12416a2798000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dbc30a30374b07=
53
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D05f9cecd28e3562=
41aba
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Deb=
ian) 2.40
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/bd119f4fdc08/dis=
k-97d8894b.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/4d0bfed66f93/vmlinu=
x-97d8894b.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/0f9223ac9bfb/b=
zImage-97d8894b.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+05f9cecd28e356241aba@syzkaller.appspotmail.com
>
> INFO: task syz-executor:9916 blocked for more than 143 seconds.
>       Not tainted 6.11.0-syzkaller-10045-g97d8894b6f4c #0
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:syz-executor    state:D stack:21104 pid:9916  tgid:9916  ppid:1     =
 flags:0x00000004
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5315 [inline]
>  __schedule+0x1895/0x4b30 kernel/sched/core.c:6674
>  __schedule_loop kernel/sched/core.c:6751 [inline]
>  schedule+0x14b/0x320 kernel/sched/core.c:6766
>  schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6823
>  __mutex_lock_common kernel/locking/mutex.c:684 [inline]
>  __mutex_lock+0x6a7/0xd70 kernel/locking/mutex.c:752
>  new_device_store+0x1b4/0x890 :166
>  kernfs_fop_write_iter+0x3a2/0x500 fs/kernfs/file.c:334
>  new_sync_write fs/read_write.c:590 [inline]
>  vfs_write+0xa6f/0xc90 fs/read_write.c:683
>  ksys_write+0x183/0x2b0 fs/read_write.c:736
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f8310d7c9df
> RSP: 002b:00007ffe830a52e0 EFLAGS: 00000293 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 00007f8310d7c9df
> RDX: 0000000000000003 RSI: 00007ffe830a5330 RDI: 0000000000000005
> RBP: 00007f8310df1c39 R08: 0000000000000000 R09: 00007ffe830a5137
> R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000003
> R13: 00007ffe830a5330 R14: 00007f8311a64620 R15: 0000000000000003
>  </TASK>

typical sysfs deadlock ?

diff --git a/drivers/net/netdevsim/bus.c b/drivers/net/netdevsim/bus.c
index 64c0cdd31bf85468ce4fa2b2af5c8aff4cfba897..3bf0ce52d71653fd9b8c752d52d=
0b5b7e19042d8
100644
--- a/drivers/net/netdevsim/bus.c
+++ b/drivers/net/netdevsim/bus.c
@@ -163,7 +163,9 @@ new_device_store(const struct bus_type *bus, const
char *buf, size_t count)
                return -EINVAL;
        }

-       mutex_lock(&nsim_bus_dev_list_lock);
+       if (!mutex_trylock(&nsim_bus_dev_list_lock))
+               return restart_syscall();
+
        /* Prevent to use resource before initialization. */
        if (!smp_load_acquire(&nsim_bus_enable)) {
                err =3D -EBUSY;


>
> Showing all locks held in the system:
> 1 lock held by khungtaskd/30:
>  #0: ffffffff8e937ee0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire i=
nclude/linux/rcupdate.h:337 [inline]
>  #0: ffffffff8e937ee0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock incl=
ude/linux/rcupdate.h:849 [inline]
>  #0: ffffffff8e937ee0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_loc=
ks+0x55/0x2a0 kernel/locking/lockdep.c:6701
> 2 locks held by dhcpcd/4889:
>  #0: ffffffff8fcb2768 (vlan_ioctl_mutex){+.+.}-{3:3}, at: sock_ioctl+0x66=
1/0x8e0 net/socket.c:1309
>  #1: ffffffff8fccdc48 (rtnl_mutex){+.+.}-{3:3}, at: vlan_ioctl_handler+0x=
112/0x9d0 net/8021q/vlan.c:553
> 2 locks held by getty/4987:
>  #0: ffff88802e9670a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wa=
it+0x25/0x70 drivers/tty/tty_ldisc.c:243
>  #1: ffffc90002f062f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_r=
ead+0x6a6/0x1e00 drivers/tty/n_tty.c:2211
> 3 locks held by kworker/u9:3/5233:
>  #0: ffff888056ad8948 ((wq_completion)hci11){+.+.}-{0:0}, at: process_one=
_work kernel/workqueue.c:3204 [inline]
>  #0: ffff888056ad8948 ((wq_completion)hci11){+.+.}-{0:0}, at: process_sch=
eduled_works+0x93b/0x1850 kernel/workqueue.c:3310
>  #1: ffffc90003ea7d00 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:=
0}, at: process_one_work kernel/workqueue.c:3205 [inline]
>  #1: ffffc90003ea7d00 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:=
0}, at: process_scheduled_works+0x976/0x1850 kernel/workqueue.c:3310
>  #2: ffff88807d3c8d80 (&hdev->req_lock){+.+.}-{3:3}, at: hci_cmd_sync_wor=
k+0x1ec/0x400 net/bluetooth/hci_sync.c:327
> 3 locks held by kworker/u9:7/5244:
>  #0: ffff88806a282148 ((wq_completion)hci8){+.+.}-{0:0}, at: process_one_=
work kernel/workqueue.c:3204 [inline]
>  #0: ffff88806a282148 ((wq_completion)hci8){+.+.}-{0:0}, at: process_sche=
duled_works+0x93b/0x1850 kernel/workqueue.c:3310
>  #1: ffffc90003dd7d00 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:=
0}, at: process_one_work kernel/workqueue.c:3205 [inline]
>  #1: ffffc90003dd7d00 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:=
0}, at: process_scheduled_works+0x976/0x1850 kernel/workqueue.c:3310
>  #2: ffff88807da48d80 (&hdev->req_lock){+.+.}-{3:3}, at: hci_cmd_sync_wor=
k+0x1ec/0x400 net/bluetooth/hci_sync.c:327
> 3 locks held by kworker/0:5/5288:
> 5 locks held by kworker/u8:22/5927:
>  #0: ffff88801bae5948 ((wq_completion)netns){+.+.}-{0:0}, at: process_one=
_work kernel/workqueue.c:3204 [inline]
>  #0: ffff88801bae5948 ((wq_completion)netns){+.+.}-{0:0}, at: process_sch=
eduled_works+0x93b/0x1850 kernel/workqueue.c:3310
>  #1: ffffc90003f87d00 (net_cleanup_work){+.+.}-{0:0}, at: process_one_wor=
k kernel/workqueue.c:3205 [inline]
>  #1: ffffc90003f87d00 (net_cleanup_work){+.+.}-{0:0}, at: process_schedul=
ed_works+0x976/0x1850 kernel/workqueue.c:3310
>  #2: ffffffff8fcc1150 (pernet_ops_rwsem){++++}-{3:3}, at: cleanup_net+0x1=
6a/0xcc0 net/core/net_namespace.c:580
>  #3: ffff88805dd75428 (&wg->device_update_lock){+.+.}-{3:3}, at: wg_destr=
uct+0x110/0x2e0 drivers/net/wireguard/device.c:249
>  #4: ffffffff8e93d478 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_l=
ock kernel/rcu/tree_exp.h:329 [inline]
>  #4: ffffffff8e93d478 (rcu_state.exp_mutex){+.+.}-{3:3}, at: synchronize_=
rcu_expedited+0x451/0x830 kernel/rcu/tree_exp.h:976
> 2 locks held by kworker/u8:25/6021:
> 2 locks held by syz.1.563/8002:
> 4 locks held by syz-executor/9916:
>  #0: ffff88807ca86420 (sb_writers#8){.+.+}-{0:0}, at: file_start_write in=
clude/linux/fs.h:2930 [inline]
>  #0: ffff88807ca86420 (sb_writers#8){.+.+}-{0:0}, at: vfs_write+0x224/0xc=
90 fs/read_write.c:679
>  #1: ffff88802e71e488 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_write_iter=
+0x1ea/0x500 fs/kernfs/file.c:325
>  #2: ffff888144ff5968 (kn->active#50){.+.+}-{0:0}, at: kernfs_fop_write_i=
ter+0x20e/0x500 fs/kernfs/file.c:326
>  #3: ffffffff8f56d3e8 (nsim_bus_dev_list_lock){+.+.}-{3:3}, at: new_devic=
e_store+0x1b4/0x890 drivers/net/netdevsim/bus.c:166
> 7 locks held by syz-executor/9976:
>  #0: ffff88807ca86420 (sb_writers#8){.+.+}-{0:0}, at: file_start_write in=
clude/linux/fs.h:2930 [inline]
>  #0: ffff88807ca86420 (sb_writers#8){.+.+}-{0:0}, at: vfs_write+0x224/0xc=
90 fs/read_write.c:679
>  #1: ffff88807abc2888 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_write_iter=
+0x1ea/0x500 fs/kernfs/file.c:325
>  #2: ffff888144ff5a58 (kn->active#49){.+.+}-{0:0}, at: kernfs_fop_write_i=
ter+0x20e/0x500 fs/kernfs/file.c:326
>  #3: ffffffff8f56d3e8 (nsim_bus_dev_list_lock){+.+.}-{3:3}, at: del_devic=
e_store+0xfc/0x480 drivers/net/netdevsim/bus.c:216
>  #4: ffff888060f5a0e8 (&dev->mutex){....}-{3:3}, at: device_lock include/=
linux/device.h:1014 [inline]
>  #4: ffff888060f5a0e8 (&dev->mutex){....}-{3:3}, at: __device_driver_lock=
 drivers/base/dd.c:1095 [inline]
>  #4: ffff888060f5a0e8 (&dev->mutex){....}-{3:3}, at: device_release_drive=
r_internal+0xce/0x7c0 drivers/base/dd.c:1293
>  #5: ffff888060f5b250 (&devlink->lock_key#40){+.+.}-{3:3}, at: nsim_drv_r=
emove+0x50/0x160 drivers/net/netdevsim/dev.c:1672
>  #6: ffffffff8fccdc48 (rtnl_mutex){+.+.}-{3:3}, at: nsim_destroy+0x71/0x5=
c0 drivers/net/netdevsim/netdev.c:773
> 2 locks held by syz-executor/10321:
>  #0: ffffffff8fcc1150 (pernet_ops_rwsem){++++}-{3:3}, at: copy_net_ns+0x3=
28/0x570 net/core/net_namespace.c:490
>  #1: ffffffff8fccdc48 (rtnl_mutex){+.+.}-{3:3}, at: cangw_pernet_exit_bat=
ch+0x20/0x90 net/can/gw.c:1257
> 2 locks held by syz-executor/10324:
>  #0: ffffffff8fcc1150 (pernet_ops_rwsem){++++}-{3:3}, at: copy_net_ns+0x3=
28/0x570 net/core/net_namespace.c:490
>  #1: ffffffff8fccdc48 (rtnl_mutex){+.+.}-{3:3}, at: mpls_net_exit+0x7d/0x=
2a0 net/mpls/af_mpls.c:2706
> 2 locks held by syz-executor/10327:
>  #0: ffffffff8fcc1150 (pernet_ops_rwsem){++++}-{3:3}, at: copy_net_ns+0x3=
28/0x570 net/core/net_namespace.c:490
>  #1: ffffffff8fccdc48 (rtnl_mutex){+.+.}-{3:3}, at: mpls_net_exit+0x7d/0x=
2a0 net/mpls/af_mpls.c:2706
> 2 locks held by syz-executor/10333:
>  #0: ffffffff8fcc1150 (pernet_ops_rwsem){++++}-{3:3}, at: copy_net_ns+0x3=
28/0x570 net/core/net_namespace.c:490
>  #1: ffffffff8fccdc48 (rtnl_mutex){+.+.}-{3:3}, at: default_device_exit_b=
atch+0xe9/0xaa0 net/core/dev.c:11930
> 2 locks held by syz-executor/10354:
>  #0: ffffffff8fcc1150 (pernet_ops_rwsem){++++}-{3:3}, at: copy_net_ns+0x3=
28/0x570 net/core/net_namespace.c:490
>  #1: ffffffff8fccdc48 (rtnl_mutex){+.+.}-{3:3}, at: ppp_exit_net+0xe3/0x3=
d0 drivers/net/ppp/ppp_generic.c:1146
> 1 lock held by syz-executor/10357:
>  #0: ffffffff8fccdc48 (rtnl_mutex){+.+.}-{3:3}, at: __tun_chr_ioctl+0x48c=
/0x2400 drivers/net/tun.c:3121
> 2 locks held by syz-executor/10362:
>  #0: ffffffff8fcc1150 (pernet_ops_rwsem){++++}-{3:3}, at: copy_net_ns+0x3=
28/0x570 net/core/net_namespace.c:490
>  #1: ffffffff8fccdc48 (rtnl_mutex){+.+.}-{3:3}, at: wg_netns_pre_exit+0x1=
f/0x1e0 drivers/net/wireguard/device.c:414
> 2 locks held by syz-executor/10366:
>  #0: ffffffff8fcc1150 (pernet_ops_rwsem){++++}-{3:3}, at: copy_net_ns+0x3=
28/0x570 net/core/net_namespace.c:490
>  #1: ffffffff8fccdc48 (rtnl_mutex){+.+.}-{3:3}, at: wg_netns_pre_exit+0x1=
f/0x1e0 drivers/net/wireguard/device.c:414
> 2 locks held by syz-executor/10368:
>  #0: ffffffff8fcc1150 (pernet_ops_rwsem){++++}-{3:3}, at: copy_net_ns+0x3=
28/0x570 net/core/net_namespace.c:490
>  #1: ffffffff8fccdc48 (rtnl_mutex){+.+.}-{3:3}, at: wg_netns_pre_exit+0x1=
f/0x1e0 drivers/net/wireguard/device.c:414
> 2 locks held by syz-executor/10371:
>  #0: ffffffff8fcc1150 (pernet_ops_rwsem){++++}-{3:3}, at: copy_net_ns+0x3=
28/0x570 net/core/net_namespace.c:490
>  #1: ffffffff8fccdc48 (rtnl_mutex){+.+.}-{3:3}, at: wg_netns_pre_exit+0x1=
f/0x1e0 drivers/net/wireguard/device.c:414
> 5 locks held by kworker/u9:0/10373:
>  #0: ffff888056f3b948 ((wq_completion)hci9){+.+.}-{0:0}, at: process_one_=
work kernel/workqueue.c:3204 [inline]
>  #0: ffff888056f3b948 ((wq_completion)hci9){+.+.}-{0:0}, at: process_sche=
duled_works+0x93b/0x1850 kernel/workqueue.c:3310
>  #1: ffffc90004127d00 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:=
0}, at: process_one_work kernel/workqueue.c:3205 [inline]
>  #1: ffffc90004127d00 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:=
0}, at: process_scheduled_works+0x976/0x1850 kernel/workqueue.c:3310
>  #2: ffff88806eb10d80 (&hdev->req_lock){+.+.}-{3:3}, at: hci_cmd_sync_wor=
k+0x1ec/0x400 net/bluetooth/hci_sync.c:327
>  #3: ffff88806eb10078 (&hdev->lock){+.+.}-{3:3}, at: hci_abort_conn_sync+=
0x1ea/0xde0 net/bluetooth/hci_sync.c:5567
>  #4: ffffffff8fe3a428 (hci_cb_list_lock){+.+.}-{3:3}, at: hci_connect_cfm=
 include/net/bluetooth/hci_core.h:1957 [inline]
>  #4: ffffffff8fe3a428 (hci_cb_list_lock){+.+.}-{3:3}, at: hci_conn_failed=
+0x15d/0x300 net/bluetooth/hci_conn.c:1262
> 2 locks held by syz-executor/10378:
>  #0: ffffffff8fcc1150 (pernet_ops_rwsem){++++}-{3:3}, at: copy_net_ns+0x3=
28/0x570 net/core/net_namespace.c:490
>  #1: ffffffff8fccdc48 (rtnl_mutex){+.+.}-{3:3}, at: ip_tunnel_init_net+0x=
20e/0x720 net/ipv4/ip_tunnel.c:1159
> 1 lock held by syz-executor/10386:
>  #0: ffffffff8fccdc48 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rt=
netlink.c:79 [inline]
>  #0: ffffffff8fccdc48 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x6=
e6/0xcf0 net/core/rtnetlink.c:6643
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> NMI backtrace for cpu 1
> CPU: 1 UID: 0 PID: 30 Comm: khungtaskd Not tainted 6.11.0-syzkaller-10045=
-g97d8894b6f4c #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 08/06/2024
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
>  nmi_cpu_backtrace+0x49c/0x4d0 lib/nmi_backtrace.c:113
>  nmi_trigger_cpumask_backtrace+0x198/0x320 lib/nmi_backtrace.c:62
>  trigger_all_cpu_backtrace include/linux/nmi.h:162 [inline]
>  check_hung_uninterruptible_tasks kernel/hung_task.c:223 [inline]
>  watchdog+0xff4/0x1040 kernel/hung_task.c:379
>  kthread+0x2f2/0x390 kernel/kthread.c:389
>  ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>  </TASK>
> Sending NMI from CPU 1 to CPUs 0:
> NMI backtrace for cpu 0
> CPU: 0 UID: 0 PID: 5288 Comm: kworker/0:5 Not tainted 6.11.0-syzkaller-10=
045-g97d8894b6f4c #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 08/06/2024
> Workqueue: events_power_efficient neigh_periodic_work
> RIP: 0010:check_preemption_disabled+0x19/0x120 lib/smp_processor_id.c:14
> Code: 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 41 57 41 56 41 5=
4 53 48 83 ec 10 65 48 8b 04 25 28 00 00 00 48 89 44 24 08 <65> 8b 1d 4c 35=
 40 74 65 8b 05 41 35 40 74 a9 ff ff ff 7f 74 26 65
> RSP: 0018:ffffc90000007948 EFLAGS: 00000086
> RAX: 8ad5e30e88cbef00 RBX: 0000000000000000 RCX: ffffffff81701614
> RDX: 0000000000000000 RSI: ffffffff8c60efa0 RDI: ffffffff8c60ef60
> RBP: ffffc90000007ae8 R08: ffffffff901ca4af R09: 1ffffffff2039495
> R10: dffffc0000000000 R11: fffffbfff2039496 R12: 1ffff92000000f3c
> R13: dffffc0000000000 R14: 0000000000000000 R15: dffffc0000000000
> FS:  0000000000000000(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000001b2fb1bff8 CR3: 000000000e734000 CR4: 0000000000350ef0
> Call Trace:
>  <NMI>
>  </NMI>
>  <IRQ>
>  rcu_is_watching_curr_cpu include/linux/context_tracking.h:128 [inline]
>  rcu_is_watching+0x15/0xb0 kernel/rcu/tree.c:737
>  trace_lock_acquire include/trace/events/lock.h:24 [inline]
>  lock_acquire+0xe3/0x550 kernel/locking/lockdep.c:5793
>  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
>  _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
>  debug_object_active_state+0x15d/0x360 lib/debugobjects.c:936
>  debug_rcu_head_unqueue kernel/rcu/rcu.h:233 [inline]
>  rcu_do_batch kernel/rcu/tree.c:2559 [inline]
>  rcu_core+0xa21/0x17a0 kernel/rcu/tree.c:2823
>  handle_softirqs+0x2c7/0x980 kernel/softirq.c:554
>  do_softirq+0x11b/0x1e0 kernel/softirq.c:455
>  </IRQ>
>  <TASK>
>  __local_bh_enable_ip+0x1bb/0x200 kernel/softirq.c:382
>  neigh_periodic_work+0xb35/0xd50 net/core/neighbour.c:1019
>  process_one_work kernel/workqueue.c:3229 [inline]
>  process_scheduled_works+0xa65/0x1850 kernel/workqueue.c:3310
>  worker_thread+0x870/0xd30 kernel/workqueue.c:3391
>  kthread+0x2f2/0x390 kernel/kthread.c:389
>  ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>  </TASK>
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

