Return-Path: <netdev+bounces-120925-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3520C95B37F
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 13:10:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7782281C62
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 11:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44AF6183063;
	Thu, 22 Aug 2024 11:10:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp134-24.sina.com.cn (smtp134-24.sina.com.cn [180.149.134.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25E817DE16
	for <netdev@vger.kernel.org>; Thu, 22 Aug 2024 11:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.149.134.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724325019; cv=none; b=qA9Z9r34Ie5eFVVLO6+alPYhRBWEcsK0Sws0Vsxots+NLwumhaCmr3z5jfHkevqUluYNSzcKNsHMWhbPixJjA8tdS85bpDDmfBW2iajnr9kq1WPy8l+x+HrXzWgkMprc3PpMt3suj3KKL2xOOzWa1dA5N6JViC9dVGyF9QRpMcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724325019; c=relaxed/simple;
	bh=cVonlDf518R9W99vlFafETTN4AeZ2PDgl49JvHxrq/E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Dw6rln1Fg3MiiE/Elh0uaqfxTFnwMakVSI8fTmeQ+Kk3vN//6Pbs6wuxf4r7u4NjyUNvhTX8ejKWN6oRqLGgc+plDH3HRwBf7M9z/JOiCozepHWIAfpVzc62TcbNQ2xpnq2jiEirSU29zUaNbX5AkbLr64ceQErAZPFWAFBYuEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=180.149.134.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.64.241])
	by sina.com (10.185.250.21) with ESMTP
	id 66C71C800000392B; Thu, 22 Aug 2024 19:09:57 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 972803408420
X-SMAIL-UIID: 1A1223967B2848F995C89EDA66E6078D-20240822-190957-1
From: Hillf Danton <hdanton@sina.com>
To: Eric Dumazet <edumazet@google.com>
Cc: syzbot <syzbot+d43eb079c2addf2439c3@syzkaller.appspotmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [ppp?] inconsistent lock state in valid_state (4)
Date: Thu, 22 Aug 2024 19:09:42 +0800
Message-Id: <20240822110942.990-1-hdanton@sina.com>
In-Reply-To: <CANn89iKkFB3iLbqq=a0RXEygKq8wYY1uiSWpWQu7zaYUEQeJYQ@mail.gmail.com>
References: <0000000000006bc6d20620023a14@google.com> <00000000000090974a0620398254@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 22 Aug 2024 08:29:35 +0200 Eric Dumazet <edumazet@google.com>
> On Thu, Aug 22, 2024 at 1:00=E2=80=AFAM syzbot
> <syzbot+d43eb079c2addf2439c3@syzkaller.appspotmail.com> wrote:
> >
> > syzbot has found a reproducer for the following issue on:
> >
> > HEAD commit:    b311c1b497e5 Merge tag '6.11-rc4-server-fixes' of git://g=
> i..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D12dccc7b98000=
> 0
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3Ddf2f0ed7e30a6=
> 39d
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3Dd43eb079c2addf2=
> 439c3
> > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Deb=
> ian) 2.40
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D17cf93d5980=
> 000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D101bb69398000=
> 0
> >
> > Downloadable assets:
> > disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7=
> bc7510fe41f/non_bootable_disk-b311c1b4.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/1c99fa48192f/vmlinu=
> x-b311c1b4.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/16d5710a012a/b=
> zImage-b311c1b4.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the comm=
> it:
> > Reported-by: syzbot+d43eb079c2addf2439c3@syzkaller.appspotmail.com
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
> =3D=3D=3D=3D=3D=3D=3D=3D
> > WARNING: inconsistent lock state
> > 6.11.0-rc4-syzkaller-00019-gb311c1b497e5 #0 Not tainted
> > --------------------------------
> > inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage.
> > ksoftirqd/0/16 [HC0[0]:SC1[1]:HE1:SE0] takes:
> > ffff888039c531e0 (&pch->downl){+.?.}-{2:2}, at: spin_lock include/linux/s=
> pinlock.h:351 [inline]
> > ffff888039c531e0 (&pch->downl){+.?.}-{2:2}, at: ppp_channel_bridge_input =
> drivers/net/ppp/ppp_generic.c:2272 [inline]
> > ffff888039c531e0 (&pch->downl){+.?.}-{2:2}, at: ppp_input+0x18b/0xa10 dri=
> vers/net/ppp/ppp_generic.c:2304
> > {SOFTIRQ-ON-W} state was registered at:
> >   lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5759
> >   __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
> >   _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
> >   spin_lock include/linux/spinlock.h:351 [inline]
> >   ppp_channel_bridge_input drivers/net/ppp/ppp_generic.c:2272 [inline]
> >   ppp_input+0x18b/0xa10 drivers/net/ppp/ppp_generic.c:2304
> >   pppoe_rcv_core+0x117/0x310 drivers/net/ppp/pppoe.c:379
> >   sk_backlog_rcv include/net/sock.h:1111 [inline]
> >   __release_sock+0x243/0x350 net/core/sock.c:3004
> >   release_sock+0x61/0x1f0 net/core/sock.c:3558
> >   pppoe_sendmsg+0xd5/0x750 drivers/net/ppp/pppoe.c:903
> >   sock_sendmsg_nosec net/socket.c:730 [inline]
> >   __sock_sendmsg+0x221/0x270 net/socket.c:745
> >   ____sys_sendmsg+0x525/0x7d0 net/socket.c:2597
> >   ___sys_sendmsg net/socket.c:2651 [inline]
> >   __sys_sendmmsg+0x3b2/0x740 net/socket.c:2737
> >   __do_sys_sendmmsg net/socket.c:2766 [inline]
> >   __se_sys_sendmmsg net/socket.c:2763 [inline]
> >   __x64_sys_sendmmsg+0xa0/0xb0 net/socket.c:2763
> >   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
> >   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > irq event stamp: 1309336
> > hardirqs last  enabled at (1309336): [<ffffffff8bc0d5ff>] __raw_spin_unlo=
> ck_irqrestore include/linux/spinlock_api_smp.h:151 [inline]
> > hardirqs last  enabled at (1309336): [<ffffffff8bc0d5ff>] _raw_spin_unloc=
> k_irqrestore+0x8f/0x140 kernel/locking/spinlock.c:194
> > hardirqs last disabled at (1309335): [<ffffffff8bc0d300>] __raw_spin_lock=
> _irqsave include/linux/spinlock_api_smp.h:108 [inline]
> > hardirqs last disabled at (1309335): [<ffffffff8bc0d300>] _raw_spin_lock_=
> irqsave+0xb0/0x120 kernel/locking/spinlock.c:162
> > softirqs last  enabled at (1309326): [<ffffffff81578ffa>] run_ksoftirqd+0=
> xca/0x130 kernel/softirq.c:928
> > softirqs last disabled at (1309331): [<ffffffff81578ffa>] run_ksoftirqd+0=
> xca/0x130 kernel/softirq.c:928
> >
> > other info that might help us debug this:
> >  Possible unsafe locking scenario:
> >
> >        CPU0
> >        ----
> >   lock(&pch->downl);
> >   <Interrupt>
> >     lock(&pch->downl);
> >
> >  *** DEADLOCK ***
> >
> > 1 lock held by ksoftirqd/0/16:
> >  #0: ffffffff8e938320 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire i=
> nclude/linux/rcupdate.h:326 [inline]
> >  #0: ffffffff8e938320 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock incl=
> ude/linux/rcupdate.h:838 [inline]
> >  #0: ffffffff8e938320 (rcu_read_lock){....}-{1:2}, at: ppp_channel_bridge=
> _input drivers/net/ppp/ppp_generic.c:2267 [inline]
> >  #0: ffffffff8e938320 (rcu_read_lock){....}-{1:2}, at: ppp_input+0x55/0xa=
> 10 drivers/net/ppp/ppp_generic.c:2304
> >
> > stack backtrace:
> > CPU: 0 UID: 0 PID: 16 Comm: ksoftirqd/0 Not tainted 6.11.0-rc4-syzkaller-=
> 00019-gb311c1b497e5 #0

This report looks bogus to me given that kthread is unable to preempt a
userspace task with spinlock held. 

> > Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.=
> 16.3-2~bpo12+1 04/01/2014
> > Call Trace:
> >  <TASK>
> >  __dump_stack lib/dump_stack.c:93 [inline]
> >  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
> >  valid_state+0x13a/0x1c0 kernel/locking/lockdep.c:4012
> >  mark_lock_irq+0xbb/0xc20 kernel/locking/lockdep.c:4215
> >  mark_lock+0x223/0x350 kernel/locking/lockdep.c:4677
> >  __lock_acquire+0xbf9/0x2040 kernel/locking/lockdep.c:5096
> >  lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5759
> >  __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
> >  _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
> >  spin_lock include/linux/spinlock.h:351 [inline]
> >  ppp_channel_bridge_input drivers/net/ppp/ppp_generic.c:2272 [inline]
> >  ppp_input+0x18b/0xa10 drivers/net/ppp/ppp_generic.c:2304
> >  ppp_sync_process+0x71/0x160 drivers/net/ppp/ppp_synctty.c:490
> >  tasklet_action_common+0x321/0x4d0 kernel/softirq.c:785
> >  handle_softirqs+0x2c4/0x970 kernel/softirq.c:554
> >  run_ksoftirqd+0xca/0x130 kernel/softirq.c:928
> >  smpboot_thread_fn+0x544/0xa30 kernel/smpboot.c:164
> >  kthread+0x2f0/0x390 kernel/kthread.c:389
> >  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
> >  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
> >  </TASK>
> >
> >
> > ---
> > If you want syzbot to run the reproducer, reply with:
> > #syz test: git://repo/address.git branch-or-commit-hash
> > If you attach or paste a git patch, syzbot will apply it before testing.
> 
> Bug probably added in
> 
> commit 4cf476ced45d7f12df30a68e833b263e7a2202d1
> Author: Tom Parkin <tparkin@katalix.com>
> Date:   Thu Dec 10 15:50:57 2020 +0000
> 
>     ppp: add PPPIOCBRIDGECHAN and PPPIOCUNBRIDGECHAN ioctls
> 
> 
> 
> sk_backlog_rcv() is called without BH being blocked.
> 
> Fx would be :
> 
> diff --git a/drivers/net/ppp/ppp_generic.c b/drivers/net/ppp/ppp_generic.c
> index eb9acfcaeb097496b5e28c87af13f5b4091a9bed..9d2656afba660a1a0eda5a53903=
> b0f668a11abc9
> 100644
> --- a/drivers/net/ppp/ppp_generic.c
> +++ b/drivers/net/ppp/ppp_generic.c
> @@ -2269,7 +2269,7 @@ static bool ppp_channel_bridge_input(struct
> channel *pch, struct sk_buff *skb)
>         if (!pchb)
>                 goto out_rcu;
> 
> -       spin_lock(&pchb->downl);
> +       spin_lock_bh(&pchb->downl);
>         if (!pchb->chan) {
>                 /* channel got unregistered */
>                 kfree_skb(skb);
> @@ -2281,7 +2281,7 @@ static bool ppp_channel_bridge_input(struct
> channel *pch, struct sk_buff *skb)
>                 kfree_skb(skb);
> 
>  outl:
> -       spin_unlock(&pchb->downl);
> +       spin_unlock_bh(&pchb->downl);
>  out_rcu:
>         rcu_read_unlock();
> 

