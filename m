Return-Path: <netdev+bounces-130091-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A9ED988300
	for <lists+netdev@lfdr.de>; Fri, 27 Sep 2024 13:07:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D0571C21F80
	for <lists+netdev@lfdr.de>; Fri, 27 Sep 2024 11:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08AB8189BB2;
	Fri, 27 Sep 2024 11:07:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail115-100.sinamail.sina.com.cn (mail115-100.sinamail.sina.com.cn [218.30.115.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2490C18870A
	for <netdev@vger.kernel.org>; Fri, 27 Sep 2024 11:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727435229; cv=none; b=ea07RtHrEAAzWMYzl6E4cy4k+AYOANi/1mkY6/9MXlhx3HaUTB9Cd3kQpytTsg5QFtownc46mCcZ1IUuvYbrq7BEBoL5H/6brBXFnrd2zuxoMTEVyIcZas0TZhVOKggAAIluVY7O/arOO2UElvDIGygUJvunrw4JtRtxXkmycIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727435229; c=relaxed/simple;
	bh=2tSp+dNwcQEwowgMcQOt+6/Tf3SFxGTWuF1blVlLegM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZViEYgfsIphPs20zP8E64Be17l90j6lgZl43GeEiK9SnMw+oLl5ou8arFESpa8YKrpV45/J333WSdL8OwGiqKAcOrD5s5duFira3/12q+ZqK7bTeBJOMAQ/OFfl0XL+ydoKSY+cCoF3izxrGq7nnVMMKgEWqWedItugWRAtobOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.71.54])
	by sina.com (10.185.250.23) with ESMTP
	id 66F6913C00004461; Fri, 27 Sep 2024 19:04:32 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 4710658913404
X-SMAIL-UIID: FFEC4222DA184718A802C62B5670DD0B-20240927-190432-1
From: Hillf Danton <hdanton@sina.com>
To: Eric Dumazet <edumazet@google.com>
Cc: syzbot <syzbot+05f9cecd28e356241aba@syzkaller.appspotmail.com>,
	linux-kernel@vger.kernel.org,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Boqun Feng <boqun.feng@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	netdev@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] INFO: task hung in new_device_store (5)
Date: Fri, 27 Sep 2024 19:04:22 +0800
Message-Id: <20240927110422.1084-1-hdanton@sina.com>
In-Reply-To: <CANn89iKLTNs5LAuSz6xeKB39hQ2FOEJNmffZsv1F3iNHqXe0tQ@mail.gmail.com>
References: <66f5a0ca.050a0220.46d20.0002.GAE@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 26 Sep 2024 22:14:14 +0200 Eric Dumazet <edumazet@google.com>
> On Thu, Sep 26, 2024 at 7:58 PM syzbot wrote:
> >
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    97d8894b6f4c Merge tag 'riscv-for-linus-6.12-mw1' of git:/..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=12416a27980000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=bc30a30374b0753
> > dashboard link: https://syzkaller.appspot.com/bug?extid=05f9cecd28e356241aba
> > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> >
> > Unfortunately, I don't have any reproducer for this issue yet.
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/bd119f4fdc08/disk-97d8894b.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/4d0bfed66f93/vmlinux-97d8894b.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/0f9223ac9bfb/bzImage-97d8894b.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+05f9cecd28e356241aba@syzkaller.appspotmail.com
> >
> > INFO: task syz-executor:9916 blocked for more than 143 seconds.
> >       Not tainted 6.11.0-syzkaller-10045-g97d8894b6f4c #0
> > "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> > task:syz-executor    state:D stack:21104 pid:9916  tgid:9916  ppid:1      flags:0x00000004
> > Call Trace:
> >  <TASK>
> >  context_switch kernel/sched/core.c:5315 [inline]
> >  __schedule+0x1895/0x4b30 kernel/sched/core.c:6674
> >  __schedule_loop kernel/sched/core.c:6751 [inline]
> >  schedule+0x14b/0x320 kernel/sched/core.c:6766
> >  schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6823
> >  __mutex_lock_common kernel/locking/mutex.c:684 [inline]
> >  __mutex_lock+0x6a7/0xd70 kernel/locking/mutex.c:752
> >  new_device_store+0x1b4/0x890 :166
> >  kernfs_fop_write_iter+0x3a2/0x500 fs/kernfs/file.c:334
> >  new_sync_write fs/read_write.c:590 [inline]
> >  vfs_write+0xa6f/0xc90 fs/read_write.c:683
> >  ksys_write+0x183/0x2b0 fs/read_write.c:736
> >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > RIP: 0033:0x7f8310d7c9df
> > RSP: 002b:00007ffe830a52e0 EFLAGS: 00000293 ORIG_RAX: 0000000000000001
> > RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 00007f8310d7c9df
> > RDX: 0000000000000003 RSI: 00007ffe830a5330 RDI: 0000000000000005
> > RBP: 00007f8310df1c39 R08: 0000000000000000 R09: 00007ffe830a5137
> > R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000003
> > R13: 00007ffe830a5330 R14: 00007f8311a64620 R15: 0000000000000003
> >  </TASK>
> 
> typical sysfs deadlock ?
> 
> diff --git a/drivers/net/netdevsim/bus.c b/drivers/net/netdevsim/bus.c
> index 64c0cdd31bf85468ce4fa2b2af5c8aff4cfba897..3bf0ce52d71653fd9b8c752d52d0b5b7e19042d8
> 100644
> --- a/drivers/net/netdevsim/bus.c
> +++ b/drivers/net/netdevsim/bus.c
> @@ -163,7 +163,9 @@ new_device_store(const struct bus_type *bus, const
> char *buf, size_t count)
>                 return -EINVAL;
>         }
> 
> -       mutex_lock(&nsim_bus_dev_list_lock);
> +       if (!mutex_trylock(&nsim_bus_dev_list_lock))
> +               return restart_syscall();
> +
>         /* Prevent to use resource before initialization. */
>         if (!smp_load_acquire(&nsim_bus_enable)) {
>                 err = -EBUSY;
> 
> 
> >
> > Showing all locks held in the system:
...
> > 4 locks held by syz-executor/9916:
> >  #0: ffff88807ca86420 (sb_writers#8){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:2930 [inline]
> >  #0: ffff88807ca86420 (sb_writers#8){.+.+}-{0:0}, at: vfs_write+0x224/0xc90 fs/read_write.c:679
> >  #1: ffff88802e71e488 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_write_iter+0x1ea/0x500 fs/kernfs/file.c:325
> >  #2: ffff888144ff5968 (kn->active#50){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x20e/0x500 fs/kernfs/file.c:326
> >  #3: ffffffff8f56d3e8 (nsim_bus_dev_list_lock){+.+.}-{3:3}, at: new_device_store+0x1b4/0x890 drivers/net/netdevsim/bus.c:166

syz-executor/9916 is lock waiter, and

> > 7 locks held by syz-executor/9976:
> >  #0: ffff88807ca86420 (sb_writers#8){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:2930 [inline]
> >  #0: ffff88807ca86420 (sb_writers#8){.+.+}-{0:0}, at: vfs_write+0x224/0xc90 fs/read_write.c:679
> >  #1: ffff88807abc2888 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_write_iter+0x1ea/0x500 fs/kernfs/file.c:325
> >  #2: ffff888144ff5a58 (kn->active#49){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x20e/0x500 fs/kernfs/file.c:326
> >  #3: ffffffff8f56d3e8 (nsim_bus_dev_list_lock){+.+.}-{3:3}, at: del_device_store+0xfc/0x480 drivers/net/netdevsim/bus.c:216
> >  #4: ffff888060f5a0e8 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
> >  #4: ffff888060f5a0e8 (&dev->mutex){....}-{3:3}, at: __device_driver_lock drivers/base/dd.c:1095 [inline]
> >  #4: ffff888060f5a0e8 (&dev->mutex){....}-{3:3}, at: device_release_driver_internal+0xce/0x7c0 drivers/base/dd.c:1293
> >  #5: ffff888060f5b250 (&devlink->lock_key#40){+.+.}-{3:3}, at: nsim_drv_remove+0x50/0x160 drivers/net/netdevsim/dev.c:1672
> >  #6: ffffffff8fccdc48 (rtnl_mutex){+.+.}-{3:3}, at: nsim_destroy+0x71/0x5c0 drivers/net/netdevsim/netdev.c:773

syz-executor/9976 is lock owner. Given both waiter and owner printed,
the proposed trylock looks like the typical paperover at least from a
hoofed skull because of no real deadlock detected.

