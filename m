Return-Path: <netdev+bounces-97737-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F8508CCF67
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 11:37:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31BB81C2110F
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 09:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C846A13D260;
	Thu, 23 May 2024 09:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ogB4tJmP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C878A78C8B
	for <netdev@vger.kernel.org>; Thu, 23 May 2024 09:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716457032; cv=none; b=W5HHgrdUNCE1nOjPr9p5Y69xFf55618aothvVCP0XcAGKM4/Rzur2CYIcanE4Eq6ivd5yHi3NVYYgvo5gvzefZrhTzxdWTC4lZbGus70KEJRn9mGyQio/vt9n3QHs0E2HAgjpQu+sDQ04rvZNY1gRatUZif0fOacczJZGuQm6uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716457032; c=relaxed/simple;
	bh=J9FrKCmjhnRTQ6oQFaMlIa0iU4H3b5j8xBlUQHJYGXo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cr1bSy8vjsW6vuebeT0l7vIStcYNOGTEZ9e7Ty6lH/6YRXGkW+BywKiT7WgF0PN+hmbwzc9dPHKaMB50N6lCW6Ay2K7zHRsCAxyb8SKeb3QQDZI9XEQu1PA5/5HUYMYXc1Z5O3Dw3rdwzDifjpSTTwGxpjIq5HyDQhO5QIszwDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ogB4tJmP; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-572a1b3d6baso8658a12.1
        for <netdev@vger.kernel.org>; Thu, 23 May 2024 02:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716457029; x=1717061829; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ztiZJfm+GBt+m+E7HyCPqMz/eTBN7FOM0ZPs50pBXNY=;
        b=ogB4tJmPJJhL16bLkyBfBf13/4iqbr7l7i9Nbek8DrBC2YW19+ZQRzmdcNAWdV0AjH
         mAJF+MZKfcQtRpPAnQhlHkp/6pCOrlNPE2CKBXPCUdoPH1NhcgKiQXd4u4pu5vBUStWq
         6yp1Q9KQrm+sRHBMbEL64FGFGAg8Gm6IRtmXWxoMlxf222ab0fthr3UFghEdGdRuuuJ9
         fnfOoltTx9WXZO8OKgMVAGloLlXX8E2+QNcCMBNMFa1LuFNH23nP8frGnPNEc8w32HgH
         row22y4LJX6CB9XkXgl+XEX7lwWAbTc1WT3Lh1gndUdFgOz6YsW4s1GD+DarIqrht8Zk
         VhKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716457029; x=1717061829;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ztiZJfm+GBt+m+E7HyCPqMz/eTBN7FOM0ZPs50pBXNY=;
        b=DAYVSUy9/NllgFNrjdzI4nLFrCHxU90+dCeonfEoS9kIEP+9GC7PwHslhF+Clg3Q16
         KhfN8wfrpxc+sduEw4AQLJgj2F1hBP3gFFfzz18/2WzdGo82YLXKICZxJuSaaPmVzomX
         wUkxZ4pEJWB4ARyUrakuIERTpDAyU+E/mN0FMUcfTtKwyLu5ndWakYYTkIaNuDMkmVT0
         dVg6cuyJwx22s2aDdyZl81QLyWZpIqKRF1XhifJcZy8OcFlPjiUvBcus//xpF1eqWlK1
         7hQMDi8wh7BsGeFjQUqbL1ReTHfvWYXluYnjvhBFzxwiif0HATCzELTdNRfzhXZpWoWi
         azpw==
X-Forwarded-Encrypted: i=1; AJvYcCX+9STa3AQI5UNqBSrDyoFs/x2brVKVKpgRwcY55OGkIAwssNe6HAlzHjS0HcTorUiEOlyglqxRhC+ul2cPv2RQprqHCW3w
X-Gm-Message-State: AOJu0Yxdq1nYLhISQELNl1cVeXqX2re2tdOWhifaC2zGGmS9O2r5GNsQ
	E/ScgrDzZSs/L2pr34w01H5utFVbL6RjzmTNvYiBY2LtlRZezuYxdcNBIykiJ2xOx/icPDNe1qa
	Hd30nhe4Ou9jH7KQ2X3r5vVVRRnonFHotmtaH
X-Google-Smtp-Source: AGHT+IFf8Vab3cq4idQD+Wk1RVFTsb8urzBMfQn0+K5JjF03lVbFeOdS3Yf/fvXIRku7xRhfCfUrZ20lndXKKbOEWjs=
X-Received: by 2002:a50:d6c2:0:b0:573:8b4:a0a6 with SMTP id
 4fb4d7f45d1cf-57845a5f91dmr96982a12.5.1716457028740; Thu, 23 May 2024
 02:37:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240523050357.43941-1-kerneljasonxing@gmail.com>
 <CANn89i+y32YsDyUSyAvVswZTUaYTNjA=zGYmV5JXrCqa5EEHJA@mail.gmail.com> <CAL+tcoD--Zb-1Qd1suMmP1yqRj879W67s0XEx2GLx-orBpZn_g@mail.gmail.com>
In-Reply-To: <CAL+tcoD--Zb-1Qd1suMmP1yqRj879W67s0XEx2GLx-orBpZn_g@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 23 May 2024 11:36:54 +0200
Message-ID: <CANn89i+vQKAwhZQMLMJO_ziR5gcsDTbhf91-k0aYNg4exTDHVg@mail.gmail.com>
Subject: Re: [PATCH v2 net] tcp: fix a race when purging the netns and
 allocating tw socket
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	davem@davemloft.net, kuniyu@amazon.com, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>, 
	syzbot+2eca27bdcb48ed330251@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 23, 2024 at 11:24=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.=
com> wrote:
>
> On Thu, May 23, 2024 at 3:19=E2=80=AFPM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > On Thu, May 23, 2024 at 7:04=E2=80=AFAM Jason Xing <kerneljasonxing@gma=
il.com> wrote:
> > >
> > > From: Jason Xing <kernelxing@tencent.com>
> > >
> > > Syzbot[1] reported the drecrement of reference count hits leaking mem=
ory.
> > >
> > > Race condition:
> > >    CPU 0                      CPU 1
> > >    -----                      -----
> > > inet_twsk_purge            tcp_time_wait
> > > inet_twsk_deschedule_put   __inet_twsk_schedule
> > >                            mod_timer(tw_timer...
> > > del_timer_sync
> > > inet_twsk_kill
> > > refcount_dec(tw_refcount)[1]
> > >                            refcount_inc(tw_refcount)[2]
> > >
> > > Race case happens because [1] decrements refcount first before [2].
> > >
> > > After we reorder the mod_timer() and refcount_inc() in the initializa=
tion
> > > phase, we can use the status of timer as an indicator to test if we w=
ant
> > > to destroy the tw socket in inet_twsk_purge() or postpone it to
> > > tw_timer_handler().
> > >
> > > After this patch applied, we get four possible cases:
> > > 1) if we can see the armed timer during the initialization phase
> > >    CPU 0                      CPU 1
> > >    -----                      -----
> > > inet_twsk_purge            tcp_time_wait
> > > inet_twsk_deschedule_put   __inet_twsk_schedule
> > >                            refcount_inc(tw_refcount)
> > >                            mod_timer(tw_timer...
> > > test if the timer is queued
> > > //timer is queued
> > > del_timer_sync
> > > inet_twsk_kill
> > > refcount_dec(tw_refcount)
> > > Note: we finish it up in the purge process.
> > >
> > > 2) if we fail to see the armed timer during the initialization phase
> > >    CPU 0                      CPU 1
> > >    -----                      -----
> > > inet_twsk_purge            tcp_time_wait
> > > inet_twsk_deschedule_put   __inet_twsk_schedule
> > >                            refcount_inc(tw_refcount)
> > > test if the timer is queued
> > > //timer isn't queued
> > > postpone
> > >                            mod_timer(tw_timer...
> > > Note: later, in another context, expired timer will finish up tw sock=
et
> > >
> > > 3) if we're seeing a running timer after the initialization phase
> > >    CPU 0                      CPU 1                    CPU 2
> > >    -----                      -----                    -----
> > >                            tcp_time_wait
> > >                            __inet_twsk_schedule
> > >                            refcount_inc(tw_refcount)
> > >                            mod_timer(tw_timer...
> > >                            ...(around 1 min)...
> > > inet_twsk_purge
> > > inet_twsk_deschedule_put
> > > test if the timer is queued
> > > // timer is running
> > > skip                                              tw_timer_handler
> > > Note: CPU 2 is destroying the timewait socket
> > >
> > > 4) if we're seeing a pending timer after the initialization phase
> > >    CPU 0                      CPU 1
> > >    -----                      -----
> > >                            tcp_time_wait
> > >                            __inet_twsk_schedule
> > >                            refcount_inc(tw_refcount)
> > >                            mod_timer(tw_timer...
> > >                            ...(< 1 min)...
> > > inet_twsk_purge
> > > inet_twsk_deschedule_put
> > > test if the timer is queued
> > > // timer is queued
> > > del_timer_sync
> > > inet_twsk_kill
> > >
> > > Therefore, only making sure that we either call inet_twsk_purge() or
> > > call tw_timer_handler() to destroy the timewait socket, we can
> > > handle all the cases as above.
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
> > > v2
> > > Link: https://lore.kernel.org/all/20240521144930.23805-1-kerneljasonx=
ing@gmail.com/
> > > 1. Use timer as a flag to test if we can safely destroy the timewait =
socket
> > > based on top of the patch Eric wrote.
> > > 2. change the title and add more explanation into body message.
> > > ---
> > >  net/ipv4/inet_timewait_sock.c | 11 +++++++++--
> > >  1 file changed, 9 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/net/ipv4/inet_timewait_sock.c b/net/ipv4/inet_timewait_s=
ock.c
> > > index e28075f0006e..b890d1c280a1 100644
> > > --- a/net/ipv4/inet_timewait_sock.c
> > > +++ b/net/ipv4/inet_timewait_sock.c
> > > @@ -255,8 +255,8 @@ void __inet_twsk_schedule(struct inet_timewait_so=
ck *tw, int timeo, bool rearm)
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
> > > @@ -301,7 +301,14 @@ void inet_twsk_purge(struct inet_hashinfo *hashi=
nfo)
> > >                         rcu_read_unlock();
> > >                         local_bh_disable();
> > >                         if (state =3D=3D TCP_TIME_WAIT) {
> > > -                               inet_twsk_deschedule_put(inet_twsk(sk=
));
> > > +                               struct inet_timewait_sock *tw =3D ine=
t_twsk(sk);
> > > +
> > > +                               /* If the timer is armed, we can safe=
ly destroy
> > > +                                * it, or else we postpone the proces=
s of destruction
> > > +                                * to tw_timer_handler().
> > > +                                */
> > > +                               if (timer_pending(&tw->tw_timer))
> > > +                                       inet_twsk_deschedule_put(tw);
> >
> >
> > This patch is not needed, and a timer_pending() would be racy anywau.
> >
> > As already explained, del_timer_sync() takes care of this with proper l=
ocking.
> >
> > inet_twsk_deschedule_put(struct inet_timewait_sock *tw)
> > {
> >   if (del_timer_sync(&tw->tw_timer))
> >      inet_twsk_kill(tw);
> >   inet_twsk_put(tw);
> > }
>
> Sorry, I'm lost. But now I understand what I wrote in the morning is
> not correct...
>
> After rethinking about this, only reordering the mod_timer() and
> refcount_inc() in the initialization phase (just like the patch you
> wrote) can ensure safety.
>
> CPU 0 uses del_timer_sync() to detect if the timer is running while
> CPU 1 mod_timer() and then increments the refcount.
>
> 1) If CPU 0 sees the queued timer which means the tw socket has done
> incrementing refcount, then CPU 0 can kill (inet_twsk_kill()) the
> socket.
>
> 2) If CPU 0 cannot see the queued timer (and will not kill the
> socket), then CPU 1 will call mod_timer() and expire in one minute.
> Another cpu will call inet_twsk_kill() to clear tw socket at last.
>
> The patch you provided seems to solve the race issue in the right
> way... I cannot see the problem of it :(
>
> So what is the problem to be solved with your patch? Thanks for your
> patience and help.

I already explained that when we do the mod_timer() and
refcount_inc(&tw->tw_dr->tw_refcount),
the tw refcount is 0, and no other cpu can possibly use the tw.

So the order of these operations seems not really relevant.

Another cpu, before trying to use it would have first to acquire a
reference on tw refcount,
and this is not allowed/possible.

inet_twsk_purge() would hit this at this failed attempt.

if (unlikely(!refcount_inc_not_zero(&sk->sk_refcnt)))
     continue;

I think we should wait for more syzbot occurrences before spending
more time on this.

It is possible the single report was caused by unrelated memory
mangling in the kernel,
or some more fundamental issues caused by kernel listeners and sockets.

