Return-Path: <netdev+bounces-130092-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F3C988344
	for <lists+netdev@lfdr.de>; Fri, 27 Sep 2024 13:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44CB41F2507A
	for <lists+netdev@lfdr.de>; Fri, 27 Sep 2024 11:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 653A81898E6;
	Fri, 27 Sep 2024 11:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tuLULkpy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE5F17B515
	for <netdev@vger.kernel.org>; Fri, 27 Sep 2024 11:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727436311; cv=none; b=WKXa20ULbBvbAV/vtVmeeoARUbGKJME8wr+YeHa1xpC2nsdfPXdeZSAxCYHMndY4eDa4Rz/KaFNQyU8EIXhOSuKHn3lLn/Ct2kVMi3q2us1j3MbewyS6PLHunPz0LW/ZoE5JclTCx1sNk328V9hlT502mRjkQmQDNICbtFbxKrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727436311; c=relaxed/simple;
	bh=Pyo4ShvfSGQCaDlC/z4SPAmIEZcdkzIchePWiiGF3N0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qu+Kw3QnbIR0JbnhsA0u3PSY0C4Ujd+fxJc6vY5CHBpVycohOu2FBYGm7KIek6qDCoUNgOE69yukkUV8k5aUuf8CSHCuc5boplIgNANbvudKSQuV8XQAXhxOIABx4Fg3QHqsMz988dZxuRuRM5tLOzCLeWkGsudn0c5z1M119CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tuLULkpy; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5c3d20eed0bso2278306a12.0
        for <netdev@vger.kernel.org>; Fri, 27 Sep 2024 04:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727436308; x=1728041108; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=msqY5dy4DxIyURKz+dsMSY9QfUnLL8zjPqH4AzBVAXA=;
        b=tuLULkpy6bIaqAD69787MsLQK4TkQpRLtSBveLVjxT4n0e2tO/Wb93XEOG101HlfHt
         EzwlPPDdSWMPcx9wqiwi31ZDDeDenqyUW3HAThFkCKGPYwSIEySYf508iIaRIzO0xr8C
         8J9kha5Qx4p6PCNscpHkOUa9eNmqzqweJDjbMLBryjpNh+dFvcmgaO9AnehM/cwTESoj
         95eShxDYDLo0sIx8ZdzTJGJhsUILRDONS3O4GV7ETPHKxbIGHCYhvaDtx8oCzQP7J26y
         6QjQxt1t0C+TkJ69NaA73iUHdnrO2mi1qc+Qex1F5x9xuANTq4g/PH80BhQOmx3CPpLn
         FiJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727436308; x=1728041108;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=msqY5dy4DxIyURKz+dsMSY9QfUnLL8zjPqH4AzBVAXA=;
        b=BcqSpiD170hamoZmLKysSLc0dJ1Ts5+nkwOCXdoLdjGfX7aQAnrBsCGiPuazvDzzSb
         7JZxQ273nOaY18Dpkfw9hbnPfaeyqmdIBl7jutlthDQEA9pJO9hflGhSU0QldDDrxBkm
         O2UsYDCQkNYuedV3YxmZjzK1yjWgmF2MFSfR03eG65eDrUeeSv/pKQE+3c0LlWtpxKHc
         MS63cCnVUl6NchAknA7DM6emsoDizJpy9DVqcE7yWOT0XgZL4QrkTray2zG6hqnOwzLB
         bUtmIdQlxIiWMinIQ/AoeOaEuSCouncqjxCGJ8qYC7RsuZCpR+LlEbpvzCKvcGyW8Wwz
         IhBA==
X-Forwarded-Encrypted: i=1; AJvYcCUd3rw99UD84k6IgbtwiguQj9IB0sA1Na5jQsph9g4esrFJhJ6FWSzweWVdleUu7Xx9Znob9/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUEY9P27cDKDeHM2qroiDbscnVKzJ+zf1pi2nqcozVvHll5LPQ
	SRP633FYIkuNNARWL9Gf07FhbRkI/oKSFjzAdAXjwMUxqbt/cSRCRi8cQlEVD0+pcp+T5WUe1Jo
	AXaa3aFlXV6ezs7SGt7K3gQaGyrZiGCvuoEDe
X-Google-Smtp-Source: AGHT+IHRI0mulCCmfoQUAyz+uxyJDHnr/83/ajvcpAuMMZB3pRpvHrVosxysbDvBg/f5CixFyygzNZ0g4CaHdxU8PEc=
X-Received: by 2002:a17:906:478c:b0:a8a:86a9:d6e2 with SMTP id
 a640c23a62f3a-a93c497029bmr257915366b.37.1727436307491; Fri, 27 Sep 2024
 04:25:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <66f5a0ca.050a0220.46d20.0002.GAE@google.com> <CANn89iKLTNs5LAuSz6xeKB39hQ2FOEJNmffZsv1F3iNHqXe0tQ@mail.gmail.com>
 <20240927110422.1084-1-hdanton@sina.com>
In-Reply-To: <20240927110422.1084-1-hdanton@sina.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 27 Sep 2024 13:24:54 +0200
Message-ID: <CANn89iLKhw-X-gzCJHgpEXe-1WuqTmSWLGOPf5oy1ZMkWyW9_w@mail.gmail.com>
Subject: Re: [syzbot] [net?] INFO: task hung in new_device_store (5)
To: Hillf Danton <hdanton@sina.com>
Cc: syzbot <syzbot+05f9cecd28e356241aba@syzkaller.appspotmail.com>, 
	linux-kernel@vger.kernel.org, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Boqun Feng <boqun.feng@gmail.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2024 at 1:05=E2=80=AFPM Hillf Danton <hdanton@sina.com> wro=
te:
>
> On Thu, 26 Sep 2024 22:14:14 +0200 Eric Dumazet <edumazet@google.com>
> > On Thu, Sep 26, 2024 at 7:58=E2=80=AFPM syzbot wrote:
> > >
> > > Hello,
> > >
> > > syzbot found the following issue on:
> > >
> > > HEAD commit:    97d8894b6f4c Merge tag 'riscv-for-linus-6.12-mw1' of =
git:/..
> > > git tree:       upstream
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=3D12416a279=
80000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dbc30a3037=
4b0753
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=3D05f9cecd28e=
356241aba
> > > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for=
 Debian) 2.40
> > >
> > > Unfortunately, I don't have any reproducer for this issue yet.
> > >
> > > Downloadable assets:
> > > disk image: https://storage.googleapis.com/syzbot-assets/bd119f4fdc08=
/disk-97d8894b.raw.xz
> > > vmlinux: https://storage.googleapis.com/syzbot-assets/4d0bfed66f93/vm=
linux-97d8894b.xz
> > > kernel image: https://storage.googleapis.com/syzbot-assets/0f9223ac9b=
fb/bzImage-97d8894b.xz
> > >
> > > IMPORTANT: if you fix the issue, please add the following tag to the =
commit:
> > > Reported-by: syzbot+05f9cecd28e356241aba@syzkaller.appspotmail.com
> > >
> > > INFO: task syz-executor:9916 blocked for more than 143 seconds.
> > >       Not tainted 6.11.0-syzkaller-10045-g97d8894b6f4c #0
> > > "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this mess=
age.
> > > task:syz-executor    state:D stack:21104 pid:9916  tgid:9916  ppid:1 =
     flags:0x00000004
> > > Call Trace:
> > >  <TASK>
> > >  context_switch kernel/sched/core.c:5315 [inline]
> > >  __schedule+0x1895/0x4b30 kernel/sched/core.c:6674
> > >  __schedule_loop kernel/sched/core.c:6751 [inline]
> > >  schedule+0x14b/0x320 kernel/sched/core.c:6766
> > >  schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6823
> > >  __mutex_lock_common kernel/locking/mutex.c:684 [inline]
> > >  __mutex_lock+0x6a7/0xd70 kernel/locking/mutex.c:752
> > >  new_device_store+0x1b4/0x890 :166
> > >  kernfs_fop_write_iter+0x3a2/0x500 fs/kernfs/file.c:334
> > >  new_sync_write fs/read_write.c:590 [inline]
> > >  vfs_write+0xa6f/0xc90 fs/read_write.c:683
> > >  ksys_write+0x183/0x2b0 fs/read_write.c:736
> > >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> > >  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
> > >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > > RIP: 0033:0x7f8310d7c9df
> > > RSP: 002b:00007ffe830a52e0 EFLAGS: 00000293 ORIG_RAX: 000000000000000=
1
> > > RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 00007f8310d7c9df
> > > RDX: 0000000000000003 RSI: 00007ffe830a5330 RDI: 0000000000000005
> > > RBP: 00007f8310df1c39 R08: 0000000000000000 R09: 00007ffe830a5137
> > > R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000003
> > > R13: 00007ffe830a5330 R14: 00007f8311a64620 R15: 0000000000000003
> > >  </TASK>
> >
> > typical sysfs deadlock ?
> >
> > diff --git a/drivers/net/netdevsim/bus.c b/drivers/net/netdevsim/bus.c
> > index 64c0cdd31bf85468ce4fa2b2af5c8aff4cfba897..3bf0ce52d71653fd9b8c752=
d52d0b5b7e19042d8
> > 100644
> > --- a/drivers/net/netdevsim/bus.c
> > +++ b/drivers/net/netdevsim/bus.c
> > @@ -163,7 +163,9 @@ new_device_store(const struct bus_type *bus, const
> > char *buf, size_t count)
> >                 return -EINVAL;
> >         }
> >
> > -       mutex_lock(&nsim_bus_dev_list_lock);
> > +       if (!mutex_trylock(&nsim_bus_dev_list_lock))
> > +               return restart_syscall();
> > +
> >         /* Prevent to use resource before initialization. */
> >         if (!smp_load_acquire(&nsim_bus_enable)) {
> >                 err =3D -EBUSY;
> >
> >
> > >
> > > Showing all locks held in the system:
> ...
> > > 4 locks held by syz-executor/9916:
> > >  #0: ffff88807ca86420 (sb_writers#8){.+.+}-{0:0}, at: file_start_writ=
e include/linux/fs.h:2930 [inline]
> > >  #0: ffff88807ca86420 (sb_writers#8){.+.+}-{0:0}, at: vfs_write+0x224=
/0xc90 fs/read_write.c:679
> > >  #1: ffff88802e71e488 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_write_=
iter+0x1ea/0x500 fs/kernfs/file.c:325
> > >  #2: ffff888144ff5968 (kn->active#50){.+.+}-{0:0}, at: kernfs_fop_wri=
te_iter+0x20e/0x500 fs/kernfs/file.c:326
> > >  #3: ffffffff8f56d3e8 (nsim_bus_dev_list_lock){+.+.}-{3:3}, at: new_d=
evice_store+0x1b4/0x890 drivers/net/netdevsim/bus.c:166
>
> syz-executor/9916 is lock waiter, and
>
> > > 7 locks held by syz-executor/9976:
> > >  #0: ffff88807ca86420 (sb_writers#8){.+.+}-{0:0}, at: file_start_writ=
e include/linux/fs.h:2930 [inline]
> > >  #0: ffff88807ca86420 (sb_writers#8){.+.+}-{0:0}, at: vfs_write+0x224=
/0xc90 fs/read_write.c:679
> > >  #1: ffff88807abc2888 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_write_=
iter+0x1ea/0x500 fs/kernfs/file.c:325
> > >  #2: ffff888144ff5a58 (kn->active#49){.+.+}-{0:0}, at: kernfs_fop_wri=
te_iter+0x20e/0x500 fs/kernfs/file.c:326
> > >  #3: ffffffff8f56d3e8 (nsim_bus_dev_list_lock){+.+.}-{3:3}, at: del_d=
evice_store+0xfc/0x480 drivers/net/netdevsim/bus.c:216
> > >  #4: ffff888060f5a0e8 (&dev->mutex){....}-{3:3}, at: device_lock incl=
ude/linux/device.h:1014 [inline]
> > >  #4: ffff888060f5a0e8 (&dev->mutex){....}-{3:3}, at: __device_driver_=
lock drivers/base/dd.c:1095 [inline]
> > >  #4: ffff888060f5a0e8 (&dev->mutex){....}-{3:3}, at: device_release_d=
river_internal+0xce/0x7c0 drivers/base/dd.c:1293
> > >  #5: ffff888060f5b250 (&devlink->lock_key#40){+.+.}-{3:3}, at: nsim_d=
rv_remove+0x50/0x160 drivers/net/netdevsim/dev.c:1672
> > >  #6: ffffffff8fccdc48 (rtnl_mutex){+.+.}-{3:3}, at: nsim_destroy+0x71=
/0x5c0 drivers/net/netdevsim/netdev.c:773
>
> syz-executor/9976 is lock owner. Given both waiter and owner printed,
> the proposed trylock looks like the typical paperover at least from a
> hoofed skull because of no real deadlock detected.

I suggest you look at why we have to use rtnl_trylock()

If you know better, please send patches to remove all instances.

