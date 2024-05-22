Return-Path: <netdev+bounces-97497-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CF0E8CBB96
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 08:51:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D5591C21536
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 06:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23AB674BED;
	Wed, 22 May 2024 06:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p2ib9z3b"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424642033A
	for <netdev@vger.kernel.org>; Wed, 22 May 2024 06:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716360715; cv=none; b=Vl9CCNgqMme+Mh8Vc4BPuBEgB3GFPvRri3DZckm7Ra92SEZPpTC4hTqbRvtY2RX4YcTDl8Ambn1l5ea5F5nJQUDBKF7nfQOdHediu034XO7/2E7D1O21bsugKTP3CueqTruFSbJQwy93+CFsAbzFv2X9Wkd0OHJHgjM2aizn2fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716360715; c=relaxed/simple;
	bh=dDhb/6cgAuxgFT9vjbQ899LtYeXPdJ49ICeLA0wM5CA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kRLbAEF/IeADiCbne2622WU6RDE+hPD9c77eqGR0/I4tM6I6qjNtpu3gQrKMc5zIBXrCC21dOfnXSFvHPzCYJzNjkukIv2dmaqVamqY90awo6PXzxurjaFcunxKU22MKb+My0gW/dRFxiHGjbmvEkwcNKGzXYaCSepFkf0Qe2s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p2ib9z3b; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-572f6c56cdaso10410a12.0
        for <netdev@vger.kernel.org>; Tue, 21 May 2024 23:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716360711; x=1716965511; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RmVPcMvIetcnOM14xG+wIadzvOXGp8xmJiCyGYZX00o=;
        b=p2ib9z3bWyn6XvJdcczZ9a3jWTGS7DzTTZKc9hJHJAQ/SpQm04deCRjt825WzAU32j
         LZQ+7hwBT9bYxmI+hu392lrZbQuNNVjWHs0Yuv+95QkHpd8TVX9SG8EYUQQmhppDwwIP
         cVOgcxAZjFn2k1TOy3Nv6PaiW9nolt6fReXk4dMM2VHRGBeNv9H4hjFkjc7NUiLb+O1y
         gR2oWxDTT81GHTIPkorTmrJ1Pc3QeccMbVqnFsf4FD42X3bNEAfL77VvC6gJ+J3wm9oc
         zLl+sTPdVmHW2RSEMroOozhNiknvHfu8WdJ6Ox5RQ5puDVW0SlwFr2++fniIoOF18DPJ
         AnKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716360711; x=1716965511;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RmVPcMvIetcnOM14xG+wIadzvOXGp8xmJiCyGYZX00o=;
        b=E1+4tLXEt0f2LCScK3rdJoEbPcuTmxY7rrZq1EYUfHIFLSwSTjkKm+GloVJtaUaAKy
         59Zg/FqGYQx1QNLgZhS9k4c1ToOKanDEs57xDUvTBNiKFXlO0FMElDSIk3miPB1dgpQP
         Dk34Zrnwp9WiZmEJn8w109cwvI+bhBvfYK4RlahSM1cXLdhSnOSTYkjgUtv/5/cf21qo
         cVTk1Ih3UE8E984jch7JS2AMIiM964w08XiU35ojDrm+V7deyZDVAJyergzuJkIj0h+K
         DAL18Rj/IqhBdbsV4NlYs9ycDAgqcROfeBw4FYa84HFRP/JouVEXIF7bjJKnJskB6IXF
         0ZSg==
X-Forwarded-Encrypted: i=1; AJvYcCUBRPJdbeJRQMuYr5Z2M8cCFxQpdhnJpM9JeZ3YVro9mvi3HOVWW8meYowmMU6RmzH91hlAx7twznXhr684/QaQiH3ZIv1f
X-Gm-Message-State: AOJu0Yy8XRdImSLnZ+XcmPHRQYA7lHyg1nyrHZyILNmkSRD0EG2fDTEG
	1NIBQ/MseDXJ6zQxSYor0nD1HGKJ4vtDUkNACIOd/k9zxrFye+FJ3K28t+aHcR9I7f5nUcwWbUd
	zCD/7yYnKuaqaKWKCZDLc6mm4snQzFVAu6Qwk9qE+UxpSxqAXOoZ2
X-Google-Smtp-Source: AGHT+IGfk2qOp+4huw8al1QwC1MccdnIPELRXoBfzpYxeeUgc9uxG8HjsloMBHb0eJsznI/i6YlE/wzzKyypfneY6GE=
X-Received: by 2002:aa7:c589:0:b0:576:68c7:f211 with SMTP id
 4fb4d7f45d1cf-5782fc2c437mr117251a12.6.1716360711197; Tue, 21 May 2024
 23:51:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240521144930.23805-1-kerneljasonxing@gmail.com>
 <CANn89iLL+DZA=CyPG+1Lcu1XRcPkc3pHKKQ4X9tm9MoeF7FPYQ@mail.gmail.com> <CAL+tcoAKEv2WOV-4k5kDa2EJMGp_h0bW3jhYZrQ9aiK+s4AcOQ@mail.gmail.com>
In-Reply-To: <CAL+tcoAKEv2WOV-4k5kDa2EJMGp_h0bW3jhYZrQ9aiK+s4AcOQ@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 22 May 2024 08:51:37 +0200
Message-ID: <CANn89iKAGeR9CX1cOSXFK8CH-d9bS_sHvU1DhGvhvt7CmCSsAg@mail.gmail.com>
Subject: Re: [PATCH net] Revert "rds: tcp: Fix use-after-free of net in reqsk_timer_handler()."
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	davem@davemloft.net, kuniyu@amazon.com, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>, 
	syzbot+2eca27bdcb48ed330251@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 22, 2024 at 8:28=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> Hello Eric,
>
> On Tue, May 21, 2024 at 11:49=E2=80=AFPM Eric Dumazet <edumazet@google.co=
m> wrote:
> >
> > On Tue, May 21, 2024 at 4:49=E2=80=AFPM Jason Xing <kerneljasonxing@gma=
il.com> wrote:
> > >
> > > From: Jason Xing <kernelxing@tencent.com>
> > >
> > > This reverts commit 2a750d6a5b365265dbda33330a6188547ddb5c24.
> > >
> > > Syzbot[1] reported the drecrement of reference count hits leaking mem=
ory.
> > >
> > > If we failed in setup_net() and try to undo the setup process, the
> > > reference now is 1 which shouldn't be decremented. However, it happen=
ed
> > > actually.
> > >
> > > After applying this patch which allows us to check the reference firs=
t,
> > > it will not hit zero anymore in tcp_twsk_purge() without calling
> > > inet_twsk_purge() one more time.
> > >
> > > [1]
> > > refcount_t: decrement hit 0; leaking memory.
> > > WARNING: CPU: 3 PID: 1396 at lib/refcount.c:31 refcount_warn_saturate=
+0x1ed/0x210 lib/refcount.c:31
> > > Modules linked in:
> > > CPU: 3 PID: 1396 Comm: syz-executor.3 Not tainted 6.9.0-syzkaller-073=
70-g33e02dc69afb #0
> > > Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debia=
n-1.16.2-1 04/01/2014
> > > RIP: 0010:refcount_warn_saturate+0x1ed/0x210 lib/refcount.c:31
> > > RSP: 0018:ffffc9000480fa70 EFLAGS: 00010282
> > > RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffc9002ce28000
> > > RDX: 0000000000040000 RSI: ffffffff81505406 RDI: 0000000000000001
> > > RBP: ffff88804d8b3f80 R08: 0000000000000001 R09: 0000000000000000
> > > R10: 0000000000000000 R11: 0000000000000002 R12: ffff88804d8b3f80
> > > R13: ffff888031c601c0 R14: ffffc900013c04f8 R15: 000000002a3e5567
> > > FS:  00007f56d897c6c0(0000) GS:ffff88806b300000(0000) knlGS:000000000=
0000000
> > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > CR2: 0000001b3182b000 CR3: 0000000034ed6000 CR4: 0000000000350ef0
> > > Call Trace:
> > >  <TASK>
> > >  __refcount_dec include/linux/refcount.h:336 [inline]
> > >  refcount_dec include/linux/refcount.h:351 [inline]
> > >  inet_twsk_kill+0x758/0x9c0 net/ipv4/inet_timewait_sock.c:70
> > >  inet_twsk_deschedule_put net/ipv4/inet_timewait_sock.c:221 [inline]
> > >  inet_twsk_purge+0x725/0x890 net/ipv4/inet_timewait_sock.c:304
> > >  tcp_twsk_purge+0x115/0x150 net/ipv4/tcp_minisocks.c:402
> > >  tcp_sk_exit_batch+0x1c/0x170 net/ipv4/tcp_ipv4.c:3522
> > >  ops_exit_list+0x128/0x180 net/core/net_namespace.c:178
> > >  setup_net+0x714/0xb40 net/core/net_namespace.c:375
> > >  copy_net_ns+0x2f0/0x670 net/core/net_namespace.c:508
> > >  create_new_namespaces+0x3ea/0xb10 kernel/nsproxy.c:110
> > >  unshare_nsproxy_namespaces+0xc0/0x1f0 kernel/nsproxy.c:228
> > >  ksys_unshare+0x419/0x970 kernel/fork.c:3323
> > >  __do_sys_unshare kernel/fork.c:3394 [inline]
> > >  __se_sys_unshare kernel/fork.c:3392 [inline]
> > >  __x64_sys_unshare+0x31/0x40 kernel/fork.c:3392
> > >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> > >  do_syscall_64+0xcf/0x260 arch/x86/entry/common.c:83
> > >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > > RIP: 0033:0x7f56d7c7cee9
> > >
> > > Fixes: 2a750d6a5b36 ("rds: tcp: Fix use-after-free of net in reqsk_ti=
mer_handler().")
> > > Reported-by: syzbot+2eca27bdcb48ed330251@syzkaller.appspotmail.com
> > > Closes: https://syzkaller.appspot.com/bug?extid=3D2eca27bdcb48ed33025=
1
> > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > ---
> > > The reverted patch trying to solve another issue causes unexpected er=
ror as above. I
> > > think that issue can be properly analyzed and handled later. So can w=
e revert it first?
> > > ---
> > >  net/ipv4/tcp_minisocks.c | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > >
> > > diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
> > > index b93619b2384b..46e6f9db4227 100644
> > > --- a/net/ipv4/tcp_minisocks.c
> > > +++ b/net/ipv4/tcp_minisocks.c
> > > @@ -399,6 +399,10 @@ void tcp_twsk_purge(struct list_head *net_exit_l=
ist)
> > >                         /* Even if tw_refcount =3D=3D 1, we must clea=
n up kernel reqsk */
> > >                         inet_twsk_purge(net->ipv4.tcp_death_row.hashi=
nfo);
> > >                 } else if (!purged_once) {
> > > +                       /* The last refcount is decremented in tcp_sk=
_exit_batch() */
> > > +                       if (refcount_read(&net->ipv4.tcp_death_row.tw=
_refcount) =3D=3D 1)
> > > +                               continue;
> > > +
> > >                         inet_twsk_purge(&tcp_hashinfo);
> > >                         purged_once =3D true;
> > >                 }
> > > --
> >
> > This can not be a fix for a race condition.
> >
> > By definition a TW has a refcount on tcp_death_row.tw_refcount   only
> > if its timer is armed.
> >
> > And inet_twsk_deschedule_put() does
> >
> > if (del_timer_sync(&tw->tw_timer))
> >     inet_twsk_kill(tw);
> >
> > I think you need to provide a full explanation, instead of a shot in th=
e dark.
> >
> > Before releasing this syzbot, I thought that maybe the refcount_inc()
> > was done too late,
> > but considering other invariants, this should not matter.
> >
> > diff --git a/net/ipv4/inet_timewait_sock.c b/net/ipv4/inet_timewait_soc=
k.c
> > index e28075f0006e333897ad379ebc8c87fc3f9643bd..d8f4d93c45331be64d70af9=
6de33f783870e1dcc
> > 100644
> > --- a/net/ipv4/inet_timewait_sock.c
> > +++ b/net/ipv4/inet_timewait_sock.c
> > @@ -255,8 +255,8 @@ void __inet_twsk_schedule(struct
> > inet_timewait_sock *tw, int timeo, bool rearm)
> >
> >                 __NET_INC_STATS(twsk_net(tw), kill ? LINUX_MIB_TIMEWAIT=
KILLED :
> >                                                      LINUX_MIB_TIMEWAIT=
ED);
> > -               BUG_ON(mod_timer(&tw->tw_timer, jiffies + timeo));
> >                 refcount_inc(&tw->tw_dr->tw_refcount);
> > +               BUG_ON(mod_timer(&tw->tw_timer, jiffies + timeo));
> >         } else {
> >                 mod_timer_pending(&tw->tw_timer, jiffies + timeo);
> >         }
>
> Thanks for your information.
>
> What you wrote is right, I think for a while. In
> inet_twsk_deschedule_put(), there are two possible cases:
> 1) if it finds the timer is armed, then it can kill the tw socket by
> decrementing the refcount in the right way. So it's a good/lucky thing
> for us.
> or
> 2) if it misses the point, then the tw socket arms the timer which
> will expire in 60 seconds in the initialization phase. The tw socket
> would have a chance to be destroyed when the timer expires.
>
> It seems that you don't think your code could solve the race issue?

inet_twsk_schedule(tw) is called while the tw refcount is still 0, so
this tw can be be found in  inet_twsk_purge()
at the same time. Look at inet_twsk_hashdance() for details.

