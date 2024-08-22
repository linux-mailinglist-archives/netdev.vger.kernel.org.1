Return-Path: <netdev+bounces-120993-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF7495B5D4
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 15:01:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E341AB250F8
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 13:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 108D715F41F;
	Thu, 22 Aug 2024 13:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kVdpistj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027C51E87B
	for <netdev@vger.kernel.org>; Thu, 22 Aug 2024 13:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724331688; cv=none; b=imQeVs/tXQ4nuwxHPGuRsvRRPLmbwEL59Auzxst44KZdD/lEO0Yb/sfIAthg29jj/SARgyHD47t4G+HU1i39+6YEtqzKBHxGtNlcqx82U7PbIxd31SttebrcqgTeNY/f2urFOZQASJu3xOhvHoaohmklyfT8ThSPR8ursE2Lm4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724331688; c=relaxed/simple;
	bh=owZmZ7SsMzo6HvJw3pjeT1sL82SMFrYVE8Xm+FXng3A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZFUbIqWsu+kbRUCuxSCe3+rrcJF2bXPSphMCwYj7hpsTA7WZPtPnAFAc8CouMnYr2Zk9IES+Kvtmu9n67jN999gyfcxVGyL9ojS9QWo2MPlAXt1CBq42sdHB6BKEbTj9zwQlXXRxRzrKIwfWbBGIPSKrnxgagLOGkPTlFdt4dBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kVdpistj; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a8677ae5a35so96169866b.0
        for <netdev@vger.kernel.org>; Thu, 22 Aug 2024 06:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724331684; x=1724936484; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VKrLJYBCeSt+5JS6KiSrzcIQGoXQRdGQJhvseDyr6cc=;
        b=kVdpistjh0byld6bvVEbeIcHN7iWxseZLhYH9ws5+i6Um+s3jziA8Gvhza7uVJVjz5
         f5rmRpNKml6CqSwOv55Uvf1W7iQJU3vST5NdeuXjPi/pR056tUn5pTBE39E2kc8EOm+G
         Z8xYvR2s1w62AmNKpbma1RgYYxUJs5O6W+snYhB+ZBBOasPgMvuqGapp4lQLaRFi+oHc
         EX2IrTFa/mTzc2MN7qqHt02f3f7WvaR/pU3wZWWtMbk2V7Gl+lqjLejIXfmJ8v3jzy1V
         rBbT/6ShR2fXOxDpMwlJq8o1tL7qU/Mcro2ajnoM5fi00ssceWFmjkWzn3s5lm20150f
         a6RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724331684; x=1724936484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VKrLJYBCeSt+5JS6KiSrzcIQGoXQRdGQJhvseDyr6cc=;
        b=qc3cJZIIUVEIFc9NetN6qagcA4vM4j0Rg0+wvsML29G0HrWedqCXPzcsBy5j+3Mm1D
         tZUC8yu3zzL4mEF39JsmuklAKRIuNCTY+gFN++QYMaI8mMZTMkfDE5CHr2MMXPHCgSuV
         ipcLQ4r7CNu6b16DEIVehgN6vdQiyyjGguEA2hTXWAQyZrkWRiPT5dO2u2UCumNDB4KY
         CzvAYH6hNnghE5f9rtfX5/BNunHCfwST8gOcR6IwdsuQTH0rdblWpSclVLwjOCtUT7HS
         VjGYDqXxCEn72ucKBPNOQyhIHk3Z87r2au3eivjB7FC/erFS9nsWL1OpCPRLjPAAcj+z
         VVLA==
X-Forwarded-Encrypted: i=1; AJvYcCWS7Ed0yabBSiJVnmxdlpyh/zn2tzQhHVZPOz6H4pbEZwt7SWmKhuawim/l/8koKWK57x44O8U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpTISivgQAAZwcNhWnrykTOg4uuEnJ2ztMNolx3KTwIAzKADoj
	633+umrFI6iIF8U753aUA0Mvamw566T2onBGonhNoYhToVMPemwhlUg0Ihd2dObLMWi53KoQD51
	ku0+HkKsdGSxJpPWzRGxgXlNFW/q2MPqVZHZiwdKrP2msvLPaNQEq
X-Google-Smtp-Source: AGHT+IEjHXq/ezJxdmtpF0kqpvK1c0szuFu3H/nYnMaoLhZ6aQB145dUjxf788a65z5zTwBUQOsdW8Dw9BypPl0NCCo=
X-Received: by 2002:a17:907:d88:b0:a86:9cff:6798 with SMTP id
 a640c23a62f3a-a869cff6865mr7091366b.30.1724331681764; Thu, 22 Aug 2024
 06:01:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0000000000006bc6d20620023a14@google.com> <00000000000090974a0620398254@google.com>
 <CANn89iKkFB3iLbqq=a0RXEygKq8wYY1uiSWpWQu7zaYUEQeJYQ@mail.gmail.com> <20240822110942.990-1-hdanton@sina.com>
In-Reply-To: <20240822110942.990-1-hdanton@sina.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 22 Aug 2024 15:01:07 +0200
Message-ID: <CANn89iK7gLjcnMOAvFnz2zpnEHgk_v-b65ExpL8ayHmP68HP=g@mail.gmail.com>
Subject: Re: [syzbot] [ppp?] inconsistent lock state in valid_state (4)
To: Hillf Danton <hdanton@sina.com>
Cc: syzbot <syzbot+d43eb079c2addf2439c3@syzkaller.appspotmail.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2024 at 1:10=E2=80=AFPM Hillf Danton <hdanton@sina.com> wro=
te:
>
> On Thu, 22 Aug 2024 08:29:35 +0200 Eric Dumazet <edumazet@google.com>
> > On Thu, Aug 22, 2024 at 1:00=3DE2=3D80=3DAFAM syzbot
> > <syzbot+d43eb079c2addf2439c3@syzkaller.appspotmail.com> wrote:
> > >
> > > syzbot has found a reproducer for the following issue on:
> > >
> > > HEAD commit:    b311c1b497e5 Merge tag '6.11-rc4-server-fixes' of git=
://g=3D
> > i..
> > > git tree:       upstream
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=3D3D12dccc7=
b98000=3D
> > 0
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D3Ddf2f0ed=
7e30a6=3D
> > 39d
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=3D3Dd43eb079c=
2addf2=3D
> > 439c3
> > > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for=
 Deb=3D
> > ian) 2.40
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D3D17cf9=
3d5980=3D
> > 000
> > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D3D101bb69=
398000=3D
> > 0
> > >
> > > Downloadable assets:
> > > disk image (non-bootable): https://storage.googleapis.com/syzbot-asse=
ts/7=3D
> > bc7510fe41f/non_bootable_disk-b311c1b4.raw.xz
> > > vmlinux: https://storage.googleapis.com/syzbot-assets/1c99fa48192f/vm=
linu=3D
> > x-b311c1b4.xz
> > > kernel image: https://storage.googleapis.com/syzbot-assets/16d5710a01=
2a/b=3D
> > zImage-b311c1b4.xz
> > >
> > > IMPORTANT: if you fix the issue, please add the following tag to the =
comm=3D
> > it:
> > > Reported-by: syzbot+d43eb079c2addf2439c3@syzkaller.appspotmail.com
> > >
> > > =3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3=
D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D
> > =3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D
> > > WARNING: inconsistent lock state
> > > 6.11.0-rc4-syzkaller-00019-gb311c1b497e5 #0 Not tainted
> > > --------------------------------
> > > inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage.
> > > ksoftirqd/0/16 [HC0[0]:SC1[1]:HE1:SE0] takes:
> > > ffff888039c531e0 (&pch->downl){+.?.}-{2:2}, at: spin_lock include/lin=
ux/s=3D
> > pinlock.h:351 [inline]
> > > ffff888039c531e0 (&pch->downl){+.?.}-{2:2}, at: ppp_channel_bridge_in=
put =3D
> > drivers/net/ppp/ppp_generic.c:2272 [inline]
> > > ffff888039c531e0 (&pch->downl){+.?.}-{2:2}, at: ppp_input+0x18b/0xa10=
 dri=3D
> > vers/net/ppp/ppp_generic.c:2304
> > > {SOFTIRQ-ON-W} state was registered at:
> > >   lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5759
> > >   __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
> > >   _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
> > >   spin_lock include/linux/spinlock.h:351 [inline]
> > >   ppp_channel_bridge_input drivers/net/ppp/ppp_generic.c:2272 [inline=
]
> > >   ppp_input+0x18b/0xa10 drivers/net/ppp/ppp_generic.c:2304
> > >   pppoe_rcv_core+0x117/0x310 drivers/net/ppp/pppoe.c:379
> > >   sk_backlog_rcv include/net/sock.h:1111 [inline]
> > >   __release_sock+0x243/0x350 net/core/sock.c:3004
> > >   release_sock+0x61/0x1f0 net/core/sock.c:3558
> > >   pppoe_sendmsg+0xd5/0x750 drivers/net/ppp/pppoe.c:903
> > >   sock_sendmsg_nosec net/socket.c:730 [inline]
> > >   __sock_sendmsg+0x221/0x270 net/socket.c:745
> > >   ____sys_sendmsg+0x525/0x7d0 net/socket.c:2597
> > >   ___sys_sendmsg net/socket.c:2651 [inline]
> > >   __sys_sendmmsg+0x3b2/0x740 net/socket.c:2737
> > >   __do_sys_sendmmsg net/socket.c:2766 [inline]
> > >   __se_sys_sendmmsg net/socket.c:2763 [inline]
> > >   __x64_sys_sendmmsg+0xa0/0xb0 net/socket.c:2763
> > >   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> > >   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
> > >   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > > irq event stamp: 1309336
> > > hardirqs last  enabled at (1309336): [<ffffffff8bc0d5ff>] __raw_spin_=
unlo=3D
> > ck_irqrestore include/linux/spinlock_api_smp.h:151 [inline]
> > > hardirqs last  enabled at (1309336): [<ffffffff8bc0d5ff>] _raw_spin_u=
nloc=3D
> > k_irqrestore+0x8f/0x140 kernel/locking/spinlock.c:194
> > > hardirqs last disabled at (1309335): [<ffffffff8bc0d300>] __raw_spin_=
lock=3D
> > _irqsave include/linux/spinlock_api_smp.h:108 [inline]
> > > hardirqs last disabled at (1309335): [<ffffffff8bc0d300>] _raw_spin_l=
ock_=3D
> > irqsave+0xb0/0x120 kernel/locking/spinlock.c:162
> > > softirqs last  enabled at (1309326): [<ffffffff81578ffa>] run_ksoftir=
qd+0=3D
> > xca/0x130 kernel/softirq.c:928
> > > softirqs last disabled at (1309331): [<ffffffff81578ffa>] run_ksoftir=
qd+0=3D
> > xca/0x130 kernel/softirq.c:928
> > >
> > > other info that might help us debug this:
> > >  Possible unsafe locking scenario:
> > >
> > >        CPU0
> > >        ----
> > >   lock(&pch->downl);
> > >   <Interrupt>
> > >     lock(&pch->downl);
> > >
> > >  *** DEADLOCK ***
> > >
> > > 1 lock held by ksoftirqd/0/16:
> > >  #0: ffffffff8e938320 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acqui=
re i=3D
> > nclude/linux/rcupdate.h:326 [inline]
> > >  #0: ffffffff8e938320 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock =
incl=3D
> > ude/linux/rcupdate.h:838 [inline]
> > >  #0: ffffffff8e938320 (rcu_read_lock){....}-{1:2}, at: ppp_channel_br=
idge=3D
> > _input drivers/net/ppp/ppp_generic.c:2267 [inline]
> > >  #0: ffffffff8e938320 (rcu_read_lock){....}-{1:2}, at: ppp_input+0x55=
/0xa=3D
> > 10 drivers/net/ppp/ppp_generic.c:2304
> > >
> > > stack backtrace:
> > > CPU: 0 UID: 0 PID: 16 Comm: ksoftirqd/0 Not tainted 6.11.0-rc4-syzkal=
ler-=3D
> > 00019-gb311c1b497e5 #0
>
> This report looks bogus to me given that kthread is unable to preempt a
> userspace task with spinlock held.


This report is absolutely legit.

User space might be interrupted by a softirq.

Issue here is that ppp_channel_bridge_input() can either be run
directly from BH context, or process context.

Therefore it needs to make sure BH are blocked. I will submit the
patch formally.

>
> > > Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debia=
n-1.=3D
> > 16.3-2~bpo12+1 04/01/2014
> > > Call Trace:
> > >  <TASK>
> > >  __dump_stack lib/dump_stack.c:93 [inline]
> > >  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
> > >  valid_state+0x13a/0x1c0 kernel/locking/lockdep.c:4012
> > >  mark_lock_irq+0xbb/0xc20 kernel/locking/lockdep.c:4215
> > >  mark_lock+0x223/0x350 kernel/locking/lockdep.c:4677
> > >  __lock_acquire+0xbf9/0x2040 kernel/locking/lockdep.c:5096
> > >  lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5759
> > >  __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
> > >  _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
> > >  spin_lock include/linux/spinlock.h:351 [inline]
> > >  ppp_channel_bridge_input drivers/net/ppp/ppp_generic.c:2272 [inline]
> > >  ppp_input+0x18b/0xa10 drivers/net/ppp/ppp_generic.c:2304
> > >  ppp_sync_process+0x71/0x160 drivers/net/ppp/ppp_synctty.c:490
> > >  tasklet_action_common+0x321/0x4d0 kernel/softirq.c:785
> > >  handle_softirqs+0x2c4/0x970 kernel/softirq.c:554
> > >  run_ksoftirqd+0xca/0x130 kernel/softirq.c:928
> > >  smpboot_thread_fn+0x544/0xa30 kernel/smpboot.c:164
> > >  kthread+0x2f0/0x390 kernel/kthread.c:389
> > >  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
> > >  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
> > >  </TASK>
> > >
> > >
> > > ---
> > > If you want syzbot to run the reproducer, reply with:
> > > #syz test: git://repo/address.git branch-or-commit-hash
> > > If you attach or paste a git patch, syzbot will apply it before testi=
ng.
> >
> > Bug probably added in
> >
> > commit 4cf476ced45d7f12df30a68e833b263e7a2202d1
> > Author: Tom Parkin <tparkin@katalix.com>
> > Date:   Thu Dec 10 15:50:57 2020 +0000
> >
> >     ppp: add PPPIOCBRIDGECHAN and PPPIOCUNBRIDGECHAN ioctls
> >
> >
> >
> > sk_backlog_rcv() is called without BH being blocked.
> >
> > Fx would be :
> >
> > diff --git a/drivers/net/ppp/ppp_generic.c b/drivers/net/ppp/ppp_generi=
c.c
> > index eb9acfcaeb097496b5e28c87af13f5b4091a9bed..9d2656afba660a1a0eda5a5=
3903=3D
> > b0f668a11abc9
> > 100644
> > --- a/drivers/net/ppp/ppp_generic.c
> > +++ b/drivers/net/ppp/ppp_generic.c
> > @@ -2269,7 +2269,7 @@ static bool ppp_channel_bridge_input(struct
> > channel *pch, struct sk_buff *skb)
> >         if (!pchb)
> >                 goto out_rcu;
> >
> > -       spin_lock(&pchb->downl);
> > +       spin_lock_bh(&pchb->downl);
> >         if (!pchb->chan) {
> >                 /* channel got unregistered */
> >                 kfree_skb(skb);
> > @@ -2281,7 +2281,7 @@ static bool ppp_channel_bridge_input(struct
> > channel *pch, struct sk_buff *skb)
> >                 kfree_skb(skb);
> >
> >  outl:
> > -       spin_unlock(&pchb->downl);
> > +       spin_unlock_bh(&pchb->downl);
> >  out_rcu:
> >         rcu_read_unlock();
> >

