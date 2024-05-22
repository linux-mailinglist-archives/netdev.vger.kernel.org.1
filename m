Return-Path: <netdev+bounces-97537-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 120DF8CBFBD
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 12:55:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC606283AC1
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 10:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56B6F8248D;
	Wed, 22 May 2024 10:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R0mmt+YM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5869280C15
	for <netdev@vger.kernel.org>; Wed, 22 May 2024 10:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716375261; cv=none; b=tiwVUXgwVvM5mwQjSbXvHeFKJshN3oIfNUWWjmbZkiJEhcfTAM66HTXmeaTcexBJw/DNAmwx/V72S6opnXEtUwWxo8GALgYD1dpvxQY14Z2F60Nny4GBdg2jxDilwZg0Js6SQh296QqkjjUMblD3Ln9uciEtX2xCQ2StF3IN+mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716375261; c=relaxed/simple;
	bh=qHm3lFVwqXW1+cMSW5B8x6VuK0Y84P2PEnAzXkO4keM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=krWxa9JjuN0Wr4oLV/LuKWQJEaDsfAnNilaDXuxzPT98i9eZ70s5VopeGhkZB/YHYdfzGA11m7+sdmcUFV4942kVKLQ91BRnedWbPY2Ey0609ZOOwEPo7mzvHbMllLW1TMpr8e8WGvPFR3vpBMVg+tntYzCLUQlrvDt6ypmd4eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R0mmt+YM; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5724736770cso10168a12.1
        for <netdev@vger.kernel.org>; Wed, 22 May 2024 03:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716375258; x=1716980058; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PuEVJnC0J0HPuTrxv7IQQZ00dFVjxx8LoRr0T6vmq7E=;
        b=R0mmt+YM2ekajsubNB7Ap6MdVNiSIl8MO+j3SyVlv8KfOHmI1qD5gV//99mB/aaAjq
         kkOJu0+miCoiu3evJEiUPFOp2yl5r+aPFTQavIZFBXzX08dhvV8/yfI5fEhXrRFmn6Y3
         dtg9RtkJuYtBifWpBzpl8mrgtzpiC6Rmr6xXUu65yhUkDyZaq6HpZ5np8RyaH49XJKas
         0B4eD7HevxBCcQi8MJjDRdEMLDeN5jOJ1yyNJjmXH3KEjMvqjRNQJlAv+mbb6av0//Ca
         BodPW5y00ZFkwz+tVDK+hxF4w7UrIALggNwL4NXLN04Gf857V/cSVqqVlQW7+FttBQ2t
         mhoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716375258; x=1716980058;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PuEVJnC0J0HPuTrxv7IQQZ00dFVjxx8LoRr0T6vmq7E=;
        b=ZTkQvcq5NyTABagD9J5iMtr+eUtBLXfnFF/JoXdzHKfExRjo8ZWyggmOjPo4Xf0taC
         ef0eeskRnqeXCT7IQQ4VLnk4UOAqs8HoIyPPJ13+G6uFlNZvZ7V1mXXQtWYHBBImNnd1
         DEsU2XVy+m+QUNEw5cg6vPv0j3NezxvtL5DW3QGZeUQ6OvdnkgNILA0sKZJUUkW03BXr
         +Rd4SVSj9gtq2NRDIEkWB3zJA/RUGb5kFNJCPCfbSWLGxfX+X2RdFmsZego+aK4HTzBs
         RQecUEH1WSka9pSyEpef6ahwvJsnMIPXpolpDYrURvEwDIVrBiwjcIz3YkaMIrkqtOXa
         FE/w==
X-Forwarded-Encrypted: i=1; AJvYcCWR4kxpLwyl0HDoCHSgGJAlZxM19BG40UmVzUQQrpxmCt6UgjRm5qEPIUHsKwSWLOujQNY7v8WNvM+arpS8W37xlwDGzPBk
X-Gm-Message-State: AOJu0Yyf68FtkL6PLXsVWmL8PomyOA95eRtrC2vAF22wex8Rgenf5fwp
	HsaiyKYhqt13jUyDVmJ7Sd+2sJFlA9NlwXX9+dhhC4mQR/Ek82vbBeGV+Tp6aIYh6twqS2FjlYv
	2fKmuNjoN/Gk8ZnJWt3y6sRvO7+/V9OzAON6p
X-Google-Smtp-Source: AGHT+IEHEJ0JJpcb0VQj9J4tv4oIFDWGXRxfXVjKgfhYcYqJJrS6EkIKr9FTkW0va5uK2BfAQ+XlkklgC4D28GTFBbI=
X-Received: by 2002:a05:6402:2904:b0:578:33c0:f00e with SMTP id
 4fb4d7f45d1cf-57833c0f3a4mr83098a12.0.1716375257097; Wed, 22 May 2024
 03:54:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240521144930.23805-1-kerneljasonxing@gmail.com>
 <CANn89iLL+DZA=CyPG+1Lcu1XRcPkc3pHKKQ4X9tm9MoeF7FPYQ@mail.gmail.com>
 <CAL+tcoAKEv2WOV-4k5kDa2EJMGp_h0bW3jhYZrQ9aiK+s4AcOQ@mail.gmail.com>
 <CANn89iKAGeR9CX1cOSXFK8CH-d9bS_sHvU1DhGvhvt7CmCSsAg@mail.gmail.com> <CAL+tcoBWna3J80Kx5=R4khOgvG8Dcyb22nf3wx_dW+5Jcz+AMA@mail.gmail.com>
In-Reply-To: <CAL+tcoBWna3J80Kx5=R4khOgvG8Dcyb22nf3wx_dW+5Jcz+AMA@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 22 May 2024 12:53:24 +0200
Message-ID: <CANn89iLyvjv+q9iYQVbZt6yY8eWXUULBFVs7DAZG2DWs+3nQ1A@mail.gmail.com>
Subject: Re: [PATCH net] Revert "rds: tcp: Fix use-after-free of net in reqsk_timer_handler()."
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	davem@davemloft.net, kuniyu@amazon.com, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>, 
	syzbot+2eca27bdcb48ed330251@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 22, 2024 at 12:42=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.=
com> wrote:
>
> On Wed, May 22, 2024 at 2:51=E2=80=AFPM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > On Wed, May 22, 2024 at 8:28=E2=80=AFAM Jason Xing <kerneljasonxing@gma=
il.com> wrote:
> > >
> > > Hello Eric,
> > >
> > > On Tue, May 21, 2024 at 11:49=E2=80=AFPM Eric Dumazet <edumazet@googl=
e.com> wrote:
> > > >
> > > > On Tue, May 21, 2024 at 4:49=E2=80=AFPM Jason Xing <kerneljasonxing=
@gmail.com> wrote:
> > > > >
> > > > > From: Jason Xing <kernelxing@tencent.com>
> > > > >
> > > > > This reverts commit 2a750d6a5b365265dbda33330a6188547ddb5c24.
> > > > >
> > > > > Syzbot[1] reported the drecrement of reference count hits leaking=
 memory.
> > > > >
> > > > > If we failed in setup_net() and try to undo the setup process, th=
e
> > > > > reference now is 1 which shouldn't be decremented. However, it ha=
ppened
> > > > > actually.
> > > > >
> > > > > After applying this patch which allows us to check the reference =
first,
> > > > > it will not hit zero anymore in tcp_twsk_purge() without calling
> > > > > inet_twsk_purge() one more time.
> > > > >
> > > > > [1]
> > > > > refcount_t: decrement hit 0; leaking memory.
> > > > > WARNING: CPU: 3 PID: 1396 at lib/refcount.c:31 refcount_warn_satu=
rate+0x1ed/0x210 lib/refcount.c:31
> > > > > Modules linked in:
> > > > > CPU: 3 PID: 1396 Comm: syz-executor.3 Not tainted 6.9.0-syzkaller=
-07370-g33e02dc69afb #0
> > > > > Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-d=
ebian-1.16.2-1 04/01/2014
> > > > > RIP: 0010:refcount_warn_saturate+0x1ed/0x210 lib/refcount.c:31
> > > > > RSP: 0018:ffffc9000480fa70 EFLAGS: 00010282
> > > > > RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffc9002ce28000
> > > > > RDX: 0000000000040000 RSI: ffffffff81505406 RDI: 0000000000000001
> > > > > RBP: ffff88804d8b3f80 R08: 0000000000000001 R09: 0000000000000000
> > > > > R10: 0000000000000000 R11: 0000000000000002 R12: ffff88804d8b3f80
> > > > > R13: ffff888031c601c0 R14: ffffc900013c04f8 R15: 000000002a3e5567
> > > > > FS:  00007f56d897c6c0(0000) GS:ffff88806b300000(0000) knlGS:00000=
00000000000
> > > > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > > CR2: 0000001b3182b000 CR3: 0000000034ed6000 CR4: 0000000000350ef0
> > > > > Call Trace:
> > > > >  <TASK>
> > > > >  __refcount_dec include/linux/refcount.h:336 [inline]
> > > > >  refcount_dec include/linux/refcount.h:351 [inline]
> > > > >  inet_twsk_kill+0x758/0x9c0 net/ipv4/inet_timewait_sock.c:70
> > > > >  inet_twsk_deschedule_put net/ipv4/inet_timewait_sock.c:221 [inli=
ne]
> > > > >  inet_twsk_purge+0x725/0x890 net/ipv4/inet_timewait_sock.c:304
> > > > >  tcp_twsk_purge+0x115/0x150 net/ipv4/tcp_minisocks.c:402
> > > > >  tcp_sk_exit_batch+0x1c/0x170 net/ipv4/tcp_ipv4.c:3522
> > > > >  ops_exit_list+0x128/0x180 net/core/net_namespace.c:178
> > > > >  setup_net+0x714/0xb40 net/core/net_namespace.c:375
> > > > >  copy_net_ns+0x2f0/0x670 net/core/net_namespace.c:508
> > > > >  create_new_namespaces+0x3ea/0xb10 kernel/nsproxy.c:110
> > > > >  unshare_nsproxy_namespaces+0xc0/0x1f0 kernel/nsproxy.c:228
> > > > >  ksys_unshare+0x419/0x970 kernel/fork.c:3323
> > > > >  __do_sys_unshare kernel/fork.c:3394 [inline]
> > > > >  __se_sys_unshare kernel/fork.c:3392 [inline]
> > > > >  __x64_sys_unshare+0x31/0x40 kernel/fork.c:3392
> > > > >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> > > > >  do_syscall_64+0xcf/0x260 arch/x86/entry/common.c:83
> > > > >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > > > > RIP: 0033:0x7f56d7c7cee9
> > > > >
> > > > > Fixes: 2a750d6a5b36 ("rds: tcp: Fix use-after-free of net in reqs=
k_timer_handler().")
> > > > > Reported-by: syzbot+2eca27bdcb48ed330251@syzkaller.appspotmail.co=
m
> > > > > Closes: https://syzkaller.appspot.com/bug?extid=3D2eca27bdcb48ed3=
30251
> > > > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > > > ---
> > > > > The reverted patch trying to solve another issue causes unexpecte=
d error as above. I
> > > > > think that issue can be properly analyzed and handled later. So c=
an we revert it first?
> > > > > ---
> > > > >  net/ipv4/tcp_minisocks.c | 4 ++++
> > > > >  1 file changed, 4 insertions(+)
> > > > >
> > > > > diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
> > > > > index b93619b2384b..46e6f9db4227 100644
> > > > > --- a/net/ipv4/tcp_minisocks.c
> > > > > +++ b/net/ipv4/tcp_minisocks.c
> > > > > @@ -399,6 +399,10 @@ void tcp_twsk_purge(struct list_head *net_ex=
it_list)
> > > > >                         /* Even if tw_refcount =3D=3D 1, we must =
clean up kernel reqsk */
> > > > >                         inet_twsk_purge(net->ipv4.tcp_death_row.h=
ashinfo);
> > > > >                 } else if (!purged_once) {
> > > > > +                       /* The last refcount is decremented in tc=
p_sk_exit_batch() */
> > > > > +                       if (refcount_read(&net->ipv4.tcp_death_ro=
w.tw_refcount) =3D=3D 1)
> > > > > +                               continue;
> > > > > +
> > > > >                         inet_twsk_purge(&tcp_hashinfo);
> > > > >                         purged_once =3D true;
> > > > >                 }
> > > > > --
> > > >
> > > > This can not be a fix for a race condition.
> > > >
> > > > By definition a TW has a refcount on tcp_death_row.tw_refcount   on=
ly
> > > > if its timer is armed.
> > > >
> > > > And inet_twsk_deschedule_put() does
> > > >
> > > > if (del_timer_sync(&tw->tw_timer))
> > > >     inet_twsk_kill(tw);
> > > >
> > > > I think you need to provide a full explanation, instead of a shot i=
n the dark.
> > > >
> > > > Before releasing this syzbot, I thought that maybe the refcount_inc=
()
> > > > was done too late,
> > > > but considering other invariants, this should not matter.
> > > >
> > > > diff --git a/net/ipv4/inet_timewait_sock.c b/net/ipv4/inet_timewait=
_sock.c
> > > > index e28075f0006e333897ad379ebc8c87fc3f9643bd..d8f4d93c45331be64d7=
0af96de33f783870e1dcc
> > > > 100644
> > > > --- a/net/ipv4/inet_timewait_sock.c
> > > > +++ b/net/ipv4/inet_timewait_sock.c
> > > > @@ -255,8 +255,8 @@ void __inet_twsk_schedule(struct
> > > > inet_timewait_sock *tw, int timeo, bool rearm)
> > > >
> > > >                 __NET_INC_STATS(twsk_net(tw), kill ? LINUX_MIB_TIME=
WAITKILLED :
> > > >                                                      LINUX_MIB_TIME=
WAITED);
> > > > -               BUG_ON(mod_timer(&tw->tw_timer, jiffies + timeo));
> > > >                 refcount_inc(&tw->tw_dr->tw_refcount);
> > > > +               BUG_ON(mod_timer(&tw->tw_timer, jiffies + timeo));
> > > >         } else {
> > > >                 mod_timer_pending(&tw->tw_timer, jiffies + timeo);
> > > >         }
> > >
> > > Thanks for your information.
> > >
> > > What you wrote is right, I think for a while. In
> > > inet_twsk_deschedule_put(), there are two possible cases:
> > > 1) if it finds the timer is armed, then it can kill the tw socket by
> > > decrementing the refcount in the right way. So it's a good/lucky thin=
g
> > > for us.
> > > or
> > > 2) if it misses the point, then the tw socket arms the timer which
> > > will expire in 60 seconds in the initialization phase. The tw socket
> > > would have a chance to be destroyed when the timer expires.
> > >
> > > It seems that you don't think your code could solve the race issue?
> >
> > inet_twsk_schedule(tw) is called while the tw refcount is still 0, so
> > this tw can be be found in  inet_twsk_purge()
> > at the same time. Look at inet_twsk_hashdance() for details.
>
> Yes, after inet_twsk_purge() finds the tw, there are two cases like my
> previous email said after applying your code.
>
> For 1) case, everything is good. inet_twsk_purge() will finish it up
> because it can decrement the refcount safely.
>
> For 2) case, even though inet_twsk_purge() finds it, it's not the time
> to destroy it until the expired tw timer will finally handle the
> process of destruction by calling inet_twsk_kill(), right? Let the
> timer handle the destruction until its end of life, which I think is a
> normal process for all the timewait sockets.
>
> The only difference in 2) case is that inet_twsk_purge() calls
> inet_twsk_put() twice while tw_timer_handler() only calls it one time.
>
> Am I missing something?

You are missing that inet_twsk_deschedule_put() is doing :

if (del_timer_sync(&tw->tw_timer))
    inet_twsk_kill(tw);

You can not have both tw_timer_handler() and
inet_twsk_deschedule_put() calling inet_twsk_kill(tw);

Take a look at del_timer_sync()

