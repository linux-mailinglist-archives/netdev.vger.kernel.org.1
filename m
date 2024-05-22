Return-Path: <netdev+bounces-97533-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C2388CBF5D
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 12:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F6FF1C2105B
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 10:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C40BA81AD0;
	Wed, 22 May 2024 10:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iHUZxJqs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA77280035
	for <netdev@vger.kernel.org>; Wed, 22 May 2024 10:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716374548; cv=none; b=MFf/nQuaPApYF+7L3ztGHokWfBx6tuLLKNakEE0bh56IJbrrQKstO9Fqir/m3zVrlv1Oi45IXrLLVXARSoY1smI/ccDmfb1zUcLRONrgLAeeGPJejzei7mKOkOLD7wQtDVTuYx0AAXl+C427xyn9cowxx6YxGvWjaeuXumt/DvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716374548; c=relaxed/simple;
	bh=m1Rir/AToSXwe/d6UU+3SA+T5rmXG144bCfwV38XPh8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IMI466VY2i27dIgc5BjXCM2o4Xd2yIXHDE15Z1tg24iy6924RWfcyomkC3iAiUTjgPJdrEUAQ58oZMV99XzjGJpV5a5L3yewjV+vNX7iZwsMw8T8K8oDTRChr5r6jbzQMlFAej3PLjMM5Xxzvkmq2af8VQxRL8DwsI6y94XHTAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iHUZxJqs; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a59c448b44aso971250566b.2
        for <netdev@vger.kernel.org>; Wed, 22 May 2024 03:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716374545; x=1716979345; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cpE0+ZTuQ0Fj7iHax0+bSuSPRHUyYWSfp35HiiMQR9E=;
        b=iHUZxJqs4ssZjxX7AhrgMyP2Po2RCUipsLgvAKCnpLqNiMIkv5EnONiYkj6NkGVozX
         d31zZ9rbnt4yQ6vUMIzcxX/hgjxKdyrv2T5caFDqDKlWQvKciHMBfMXhaPmo6430uJn/
         tsVdOWdmFBBMlgrNBz/82CiuMkTeXLrIJEbeBukNnLNL4LNY/oBxuvNXpGQVagVsC88B
         hdcSkfDR0CIVMyniw8eJ5v1Memrb2bUAj/YAKhM8Acky9fuPtJc/qzfQa92rV9+T7BSj
         zyBsycJLEiYgoYliSoGHtJ9jXr7xVuAZwECIdfzWaO+YRCmQPFai5ForeTv6PxIgFiJN
         bkMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716374545; x=1716979345;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cpE0+ZTuQ0Fj7iHax0+bSuSPRHUyYWSfp35HiiMQR9E=;
        b=buHgCxc27mua3XH51cd6FlBG0g7kbbzcQsGAv7azUHh8mrlPPgyav3XE4JlSup5AND
         YAaToKJZnl1PGfHsUt4UdgOzDHHCffiB11fbhqt2rcTaXSzTkptFgFxCzlCxFRnzFtnM
         rDtRa6MzzOHrqN6ebXFeI7VTRj63pNrjz6kLONrk55dnMNNY8QjBbcteZ8u2khqI+Er+
         wePFk6Sfcfirl82B6twcnHMZRUfM/oYrZnAgxuxU8FGLPCbCdLpzNHfqSBQdqqL1iEt3
         flDHJrHA1ipQsP2BHHJMA30OUFW4QerxC4i/97TpvqSJl1YroU/jFkIBlQ9Pk4GLKYA5
         XkRw==
X-Forwarded-Encrypted: i=1; AJvYcCVLnV3F7PSBkJbZWZocNbxGInlqXfhPQnGTRyWIHBzRDriSdz6AhZsnTeTwvQzwJtm9ijPc1376lGHRogXJutwly4lSB47N
X-Gm-Message-State: AOJu0YzpIM9vIm7gFr59h+HWJdzfTVlq7Q00eA1bM+jiEWmueT0FozCW
	EVhEEmpXMs1IgLY3wdf/3WfZxLbVAvwcan2bmNpOOMald+tv90WkAOrrawIQHdF5rd47wAJi1zg
	2lEYuA5TUGhqvzrFloFcgVLpe6lgkMvwIOcQ=
X-Google-Smtp-Source: AGHT+IGu//gSsx0QnG9MuzFgmIfq5hDOTky+/xWrhTIOynh86SMXU1mfhW8li4azOTZtOM3k+cPe9sk8HAKUox47i+M=
X-Received: by 2002:a17:907:7847:b0:a5c:e2ea:ba59 with SMTP id
 a640c23a62f3a-a622807cb10mr81638266b.29.1716374544897; Wed, 22 May 2024
 03:42:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240521144930.23805-1-kerneljasonxing@gmail.com>
 <CANn89iLL+DZA=CyPG+1Lcu1XRcPkc3pHKKQ4X9tm9MoeF7FPYQ@mail.gmail.com>
 <CAL+tcoAKEv2WOV-4k5kDa2EJMGp_h0bW3jhYZrQ9aiK+s4AcOQ@mail.gmail.com> <CANn89iKAGeR9CX1cOSXFK8CH-d9bS_sHvU1DhGvhvt7CmCSsAg@mail.gmail.com>
In-Reply-To: <CANn89iKAGeR9CX1cOSXFK8CH-d9bS_sHvU1DhGvhvt7CmCSsAg@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 22 May 2024 18:41:48 +0800
Message-ID: <CAL+tcoBWna3J80Kx5=R4khOgvG8Dcyb22nf3wx_dW+5Jcz+AMA@mail.gmail.com>
Subject: Re: [PATCH net] Revert "rds: tcp: Fix use-after-free of net in reqsk_timer_handler()."
To: Eric Dumazet <edumazet@google.com>
Cc: dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	davem@davemloft.net, kuniyu@amazon.com, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>, 
	syzbot+2eca27bdcb48ed330251@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 22, 2024 at 2:51=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Wed, May 22, 2024 at 8:28=E2=80=AFAM Jason Xing <kerneljasonxing@gmail=
.com> wrote:
> >
> > Hello Eric,
> >
> > On Tue, May 21, 2024 at 11:49=E2=80=AFPM Eric Dumazet <edumazet@google.=
com> wrote:
> > >
> > > On Tue, May 21, 2024 at 4:49=E2=80=AFPM Jason Xing <kerneljasonxing@g=
mail.com> wrote:
> > > >
> > > > From: Jason Xing <kernelxing@tencent.com>
> > > >
> > > > This reverts commit 2a750d6a5b365265dbda33330a6188547ddb5c24.
> > > >
> > > > Syzbot[1] reported the drecrement of reference count hits leaking m=
emory.
> > > >
> > > > If we failed in setup_net() and try to undo the setup process, the
> > > > reference now is 1 which shouldn't be decremented. However, it happ=
ened
> > > > actually.
> > > >
> > > > After applying this patch which allows us to check the reference fi=
rst,
> > > > it will not hit zero anymore in tcp_twsk_purge() without calling
> > > > inet_twsk_purge() one more time.
> > > >
> > > > [1]
> > > > refcount_t: decrement hit 0; leaking memory.
> > > > WARNING: CPU: 3 PID: 1396 at lib/refcount.c:31 refcount_warn_satura=
te+0x1ed/0x210 lib/refcount.c:31
> > > > Modules linked in:
> > > > CPU: 3 PID: 1396 Comm: syz-executor.3 Not tainted 6.9.0-syzkaller-0=
7370-g33e02dc69afb #0
> > > > Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-deb=
ian-1.16.2-1 04/01/2014
> > > > RIP: 0010:refcount_warn_saturate+0x1ed/0x210 lib/refcount.c:31
> > > > RSP: 0018:ffffc9000480fa70 EFLAGS: 00010282
> > > > RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffc9002ce28000
> > > > RDX: 0000000000040000 RSI: ffffffff81505406 RDI: 0000000000000001
> > > > RBP: ffff88804d8b3f80 R08: 0000000000000001 R09: 0000000000000000
> > > > R10: 0000000000000000 R11: 0000000000000002 R12: ffff88804d8b3f80
> > > > R13: ffff888031c601c0 R14: ffffc900013c04f8 R15: 000000002a3e5567
> > > > FS:  00007f56d897c6c0(0000) GS:ffff88806b300000(0000) knlGS:0000000=
000000000
> > > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > CR2: 0000001b3182b000 CR3: 0000000034ed6000 CR4: 0000000000350ef0
> > > > Call Trace:
> > > >  <TASK>
> > > >  __refcount_dec include/linux/refcount.h:336 [inline]
> > > >  refcount_dec include/linux/refcount.h:351 [inline]
> > > >  inet_twsk_kill+0x758/0x9c0 net/ipv4/inet_timewait_sock.c:70
> > > >  inet_twsk_deschedule_put net/ipv4/inet_timewait_sock.c:221 [inline=
]
> > > >  inet_twsk_purge+0x725/0x890 net/ipv4/inet_timewait_sock.c:304
> > > >  tcp_twsk_purge+0x115/0x150 net/ipv4/tcp_minisocks.c:402
> > > >  tcp_sk_exit_batch+0x1c/0x170 net/ipv4/tcp_ipv4.c:3522
> > > >  ops_exit_list+0x128/0x180 net/core/net_namespace.c:178
> > > >  setup_net+0x714/0xb40 net/core/net_namespace.c:375
> > > >  copy_net_ns+0x2f0/0x670 net/core/net_namespace.c:508
> > > >  create_new_namespaces+0x3ea/0xb10 kernel/nsproxy.c:110
> > > >  unshare_nsproxy_namespaces+0xc0/0x1f0 kernel/nsproxy.c:228
> > > >  ksys_unshare+0x419/0x970 kernel/fork.c:3323
> > > >  __do_sys_unshare kernel/fork.c:3394 [inline]
> > > >  __se_sys_unshare kernel/fork.c:3392 [inline]
> > > >  __x64_sys_unshare+0x31/0x40 kernel/fork.c:3392
> > > >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> > > >  do_syscall_64+0xcf/0x260 arch/x86/entry/common.c:83
> > > >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > > > RIP: 0033:0x7f56d7c7cee9
> > > >
> > > > Fixes: 2a750d6a5b36 ("rds: tcp: Fix use-after-free of net in reqsk_=
timer_handler().")
> > > > Reported-by: syzbot+2eca27bdcb48ed330251@syzkaller.appspotmail.com
> > > > Closes: https://syzkaller.appspot.com/bug?extid=3D2eca27bdcb48ed330=
251
> > > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > > ---
> > > > The reverted patch trying to solve another issue causes unexpected =
error as above. I
> > > > think that issue can be properly analyzed and handled later. So can=
 we revert it first?
> > > > ---
> > > >  net/ipv4/tcp_minisocks.c | 4 ++++
> > > >  1 file changed, 4 insertions(+)
> > > >
> > > > diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
> > > > index b93619b2384b..46e6f9db4227 100644
> > > > --- a/net/ipv4/tcp_minisocks.c
> > > > +++ b/net/ipv4/tcp_minisocks.c
> > > > @@ -399,6 +399,10 @@ void tcp_twsk_purge(struct list_head *net_exit=
_list)
> > > >                         /* Even if tw_refcount =3D=3D 1, we must cl=
ean up kernel reqsk */
> > > >                         inet_twsk_purge(net->ipv4.tcp_death_row.has=
hinfo);
> > > >                 } else if (!purged_once) {
> > > > +                       /* The last refcount is decremented in tcp_=
sk_exit_batch() */
> > > > +                       if (refcount_read(&net->ipv4.tcp_death_row.=
tw_refcount) =3D=3D 1)
> > > > +                               continue;
> > > > +
> > > >                         inet_twsk_purge(&tcp_hashinfo);
> > > >                         purged_once =3D true;
> > > >                 }
> > > > --
> > >
> > > This can not be a fix for a race condition.
> > >
> > > By definition a TW has a refcount on tcp_death_row.tw_refcount   only
> > > if its timer is armed.
> > >
> > > And inet_twsk_deschedule_put() does
> > >
> > > if (del_timer_sync(&tw->tw_timer))
> > >     inet_twsk_kill(tw);
> > >
> > > I think you need to provide a full explanation, instead of a shot in =
the dark.
> > >
> > > Before releasing this syzbot, I thought that maybe the refcount_inc()
> > > was done too late,
> > > but considering other invariants, this should not matter.
> > >
> > > diff --git a/net/ipv4/inet_timewait_sock.c b/net/ipv4/inet_timewait_s=
ock.c
> > > index e28075f0006e333897ad379ebc8c87fc3f9643bd..d8f4d93c45331be64d70a=
f96de33f783870e1dcc
> > > 100644
> > > --- a/net/ipv4/inet_timewait_sock.c
> > > +++ b/net/ipv4/inet_timewait_sock.c
> > > @@ -255,8 +255,8 @@ void __inet_twsk_schedule(struct
> > > inet_timewait_sock *tw, int timeo, bool rearm)
> > >
> > >                 __NET_INC_STATS(twsk_net(tw), kill ? LINUX_MIB_TIMEWA=
ITKILLED :
> > >                                                      LINUX_MIB_TIMEWA=
ITED);
> > > -               BUG_ON(mod_timer(&tw->tw_timer, jiffies + timeo));
> > >                 refcount_inc(&tw->tw_dr->tw_refcount);
> > > +               BUG_ON(mod_timer(&tw->tw_timer, jiffies + timeo));
> > >         } else {
> > >                 mod_timer_pending(&tw->tw_timer, jiffies + timeo);
> > >         }
> >
> > Thanks for your information.
> >
> > What you wrote is right, I think for a while. In
> > inet_twsk_deschedule_put(), there are two possible cases:
> > 1) if it finds the timer is armed, then it can kill the tw socket by
> > decrementing the refcount in the right way. So it's a good/lucky thing
> > for us.
> > or
> > 2) if it misses the point, then the tw socket arms the timer which
> > will expire in 60 seconds in the initialization phase. The tw socket
> > would have a chance to be destroyed when the timer expires.
> >
> > It seems that you don't think your code could solve the race issue?
>
> inet_twsk_schedule(tw) is called while the tw refcount is still 0, so
> this tw can be be found in  inet_twsk_purge()
> at the same time. Look at inet_twsk_hashdance() for details.

Yes, after inet_twsk_purge() finds the tw, there are two cases like my
previous email said after applying your code.

For 1) case, everything is good. inet_twsk_purge() will finish it up
because it can decrement the refcount safely.

For 2) case, even though inet_twsk_purge() finds it, it's not the time
to destroy it until the expired tw timer will finally handle the
process of destruction by calling inet_twsk_kill(), right? Let the
timer handle the destruction until its end of life, which I think is a
normal process for all the timewait sockets.

The only difference in 2) case is that inet_twsk_purge() calls
inet_twsk_put() twice while tw_timer_handler() only calls it one time.

Am I missing something?

Thanks,
Jason

