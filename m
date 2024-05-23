Return-Path: <netdev+bounces-97777-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4615B8CD220
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 14:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51E821C211C4
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 12:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CAC113EFFB;
	Thu, 23 May 2024 12:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CndjYg6Q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167A813D88A
	for <netdev@vger.kernel.org>; Thu, 23 May 2024 12:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716466593; cv=none; b=jdn7FzyfaZMOeshXKJ26VsCjH4yjhHZLHC/Is4NXYm+6H6xLbrGRctm8s1bCFf/Xcu6S/4fqmQ9PxJVWpwHkFOzRtHfBi9fUNIvq5GGBTzWE9af+r+GLChc5n4y/Fjcvn5Dr2FncUQlhr9nkC2rFrS9thmCf6a9e67sgbZA7UkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716466593; c=relaxed/simple;
	bh=RA+ZczmwmUJ7QRLN0WEUWjnOIc5tRiw58jdxJN22/k4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uO3i9ZNiR/ExNK7OBkAxF7y7e94jH1mcvCGxe8Z+8V3uZGkh7DKJGcAZLTTuXsmf6i3z74XDQjzT7ag7PNajowUhWhFNJg9Ae/W4pn6hJLUTyhvXs68JXpvzVec06N988Ncz9SzLcboDaAO67z3IvdHu534Y8Lmbkf1WjmF32f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CndjYg6Q; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2e6f51f9de4so85512251fa.3
        for <netdev@vger.kernel.org>; Thu, 23 May 2024 05:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716466589; x=1717071389; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sL3qiDNqfXosv5hSOK79x4Ke167gqNv3f8NJy+JOcL0=;
        b=CndjYg6Qc3hsrP9NOBWTTCPO6SghPVcAu8XcVsle5YTQnLkjk7eZFuncEy3LTAn4Dc
         a2q4ifNltLVVYEF0oKeT8AUjoYHagNmE56fRLxjH9YNBQptYRl7+L4py4Ifk6fBlKga9
         YUqGzHkq0dF9vK77ZE0vu6kLjd9JSze/3wTOsNeSaCedmiK4eEqu71FUDjVGshVzG4yk
         oBAVvpuGp2zuX4TMZXgiXX5i7STFsXMtmj2rEM4y9x4O4wDgZedbAu3EmQGuZFUyuPdY
         aa49s7YMia/HRhV5uxVqKGU6v1k1xk0cVfakBKxvRa3F3bRGPy2LeMbIJJWrpoKwJri2
         lTBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716466589; x=1717071389;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sL3qiDNqfXosv5hSOK79x4Ke167gqNv3f8NJy+JOcL0=;
        b=suwEc76suvP6RpZpO1xOjC04+A0RKj9aS3p/G9Ps+EEfcwSVNndI16LWsEXPu7zTTD
         34BoZVpEfSBxGy7BCN5Tem0k12r2eT6pzgOGt+jD8JIaC0GnYVeqC7fGgvdbrat4wGF3
         VjZ3/xQC15/ogFN12Iqn2BtyfyWNoDGeUjuVm3qX+HAhf5/hAY98J18r4RoJQqZrWXsQ
         LmcNXVRrBVyP/MQxYurnU3F8Ciumv/f/VREBPs4TIqnQvFuoWYCrmAGhlCuR94Mi9u4j
         k4D6jX9JOng2bZvKKRZf4yPCiVQVDPmc+YkBywvsXhQbJY4F2bgGn1kQ/YxHpna6dQQS
         qOGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjVnvEiyzAemHvigQBskXAzbtqNp6NqjmFOWazvGPEmcXp1tt2VQ8k+bs579UP9VM7p657kNkyuhFgttX58oKH76m9uLVK
X-Gm-Message-State: AOJu0Yz6jgl5x4Xbch+1BkACw2qtAf0u6BvRb4+MbiHuC8Cb33RLtJgE
	kJvCmVVUGTaEC45RorbIG0WZjuH5Ok+MlYDXgMJ+2+CbSsMZTR/QArw8Ja6Oarcetbl0u56PLkI
	5VXXBJwAm7whjb3faaony6BkamLg=
X-Google-Smtp-Source: AGHT+IFai1PcnAMcikKnMGpslRYljepalX3zWp1sY0lnkAifAtcolFwjep/ywhKg5iagQRCZalGSX93NbtN+SRe+ILE=
X-Received: by 2002:a2e:9ad6:0:b0:2e2:72a7:8440 with SMTP id
 38308e7fff4ca-2e9495404c1mr40262751fa.41.1716466588960; Thu, 23 May 2024
 05:16:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240523050357.43941-1-kerneljasonxing@gmail.com>
 <CANn89i+y32YsDyUSyAvVswZTUaYTNjA=zGYmV5JXrCqa5EEHJA@mail.gmail.com>
 <CAL+tcoD--Zb-1Qd1suMmP1yqRj879W67s0XEx2GLx-orBpZn_g@mail.gmail.com> <CANn89i+vQKAwhZQMLMJO_ziR5gcsDTbhf91-k0aYNg4exTDHVg@mail.gmail.com>
In-Reply-To: <CANn89i+vQKAwhZQMLMJO_ziR5gcsDTbhf91-k0aYNg4exTDHVg@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 23 May 2024 20:15:52 +0800
Message-ID: <CAL+tcoC0wHy=qRgNd8bpRNff1gA6eZ_Mv0ba9b2Ce9hhVOqN_g@mail.gmail.com>
Subject: Re: [PATCH v2 net] tcp: fix a race when purging the netns and
 allocating tw socket
To: Eric Dumazet <edumazet@google.com>
Cc: dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	davem@davemloft.net, kuniyu@amazon.com, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>, 
	syzbot+2eca27bdcb48ed330251@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 23, 2024 at 5:37=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Thu, May 23, 2024 at 11:24=E2=80=AFAM Jason Xing <kerneljasonxing@gmai=
l.com> wrote:
> >
> > On Thu, May 23, 2024 at 3:19=E2=80=AFPM Eric Dumazet <edumazet@google.c=
om> wrote:
> > >
> > > On Thu, May 23, 2024 at 7:04=E2=80=AFAM Jason Xing <kerneljasonxing@g=
mail.com> wrote:
> > > >
> > > > From: Jason Xing <kernelxing@tencent.com>
> > > >
> > > > Syzbot[1] reported the drecrement of reference count hits leaking m=
emory.
> > > >
> > > > Race condition:
> > > >    CPU 0                      CPU 1
> > > >    -----                      -----
> > > > inet_twsk_purge            tcp_time_wait
> > > > inet_twsk_deschedule_put   __inet_twsk_schedule
> > > >                            mod_timer(tw_timer...
> > > > del_timer_sync
> > > > inet_twsk_kill
> > > > refcount_dec(tw_refcount)[1]
> > > >                            refcount_inc(tw_refcount)[2]
> > > >
> > > > Race case happens because [1] decrements refcount first before [2].
> > > >
> > > > After we reorder the mod_timer() and refcount_inc() in the initiali=
zation
> > > > phase, we can use the status of timer as an indicator to test if we=
 want
> > > > to destroy the tw socket in inet_twsk_purge() or postpone it to
> > > > tw_timer_handler().
> > > >
> > > > After this patch applied, we get four possible cases:
> > > > 1) if we can see the armed timer during the initialization phase
> > > >    CPU 0                      CPU 1
> > > >    -----                      -----
> > > > inet_twsk_purge            tcp_time_wait
> > > > inet_twsk_deschedule_put   __inet_twsk_schedule
> > > >                            refcount_inc(tw_refcount)
> > > >                            mod_timer(tw_timer...
> > > > test if the timer is queued
> > > > //timer is queued
> > > > del_timer_sync
> > > > inet_twsk_kill
> > > > refcount_dec(tw_refcount)
> > > > Note: we finish it up in the purge process.
> > > >
> > > > 2) if we fail to see the armed timer during the initialization phas=
e
> > > >    CPU 0                      CPU 1
> > > >    -----                      -----
> > > > inet_twsk_purge            tcp_time_wait
> > > > inet_twsk_deschedule_put   __inet_twsk_schedule
> > > >                            refcount_inc(tw_refcount)
> > > > test if the timer is queued
> > > > //timer isn't queued
> > > > postpone
> > > >                            mod_timer(tw_timer...
> > > > Note: later, in another context, expired timer will finish up tw so=
cket
> > > >
> > > > 3) if we're seeing a running timer after the initialization phase
> > > >    CPU 0                      CPU 1                    CPU 2
> > > >    -----                      -----                    -----
> > > >                            tcp_time_wait
> > > >                            __inet_twsk_schedule
> > > >                            refcount_inc(tw_refcount)
> > > >                            mod_timer(tw_timer...
> > > >                            ...(around 1 min)...
> > > > inet_twsk_purge
> > > > inet_twsk_deschedule_put
> > > > test if the timer is queued
> > > > // timer is running
> > > > skip                                              tw_timer_handler
> > > > Note: CPU 2 is destroying the timewait socket
> > > >
> > > > 4) if we're seeing a pending timer after the initialization phase
> > > >    CPU 0                      CPU 1
> > > >    -----                      -----
> > > >                            tcp_time_wait
> > > >                            __inet_twsk_schedule
> > > >                            refcount_inc(tw_refcount)
> > > >                            mod_timer(tw_timer...
> > > >                            ...(< 1 min)...
> > > > inet_twsk_purge
> > > > inet_twsk_deschedule_put
> > > > test if the timer is queued
> > > > // timer is queued
> > > > del_timer_sync
> > > > inet_twsk_kill
> > > >
> > > > Therefore, only making sure that we either call inet_twsk_purge() o=
r
> > > > call tw_timer_handler() to destroy the timewait socket, we can
> > > > handle all the cases as above.
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
> > > > v2
> > > > Link: https://lore.kernel.org/all/20240521144930.23805-1-kerneljaso=
nxing@gmail.com/
> > > > 1. Use timer as a flag to test if we can safely destroy the timewai=
t socket
> > > > based on top of the patch Eric wrote.
> > > > 2. change the title and add more explanation into body message.
> > > > ---
> > > >  net/ipv4/inet_timewait_sock.c | 11 +++++++++--
> > > >  1 file changed, 9 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/net/ipv4/inet_timewait_sock.c b/net/ipv4/inet_timewait=
_sock.c
> > > > index e28075f0006e..b890d1c280a1 100644
> > > > --- a/net/ipv4/inet_timewait_sock.c
> > > > +++ b/net/ipv4/inet_timewait_sock.c
> > > > @@ -255,8 +255,8 @@ void __inet_twsk_schedule(struct inet_timewait_=
sock *tw, int timeo, bool rearm)
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
> > > > @@ -301,7 +301,14 @@ void inet_twsk_purge(struct inet_hashinfo *has=
hinfo)
> > > >                         rcu_read_unlock();
> > > >                         local_bh_disable();
> > > >                         if (state =3D=3D TCP_TIME_WAIT) {
> > > > -                               inet_twsk_deschedule_put(inet_twsk(=
sk));
> > > > +                               struct inet_timewait_sock *tw =3D i=
net_twsk(sk);
> > > > +
> > > > +                               /* If the timer is armed, we can sa=
fely destroy
> > > > +                                * it, or else we postpone the proc=
ess of destruction
> > > > +                                * to tw_timer_handler().
> > > > +                                */
> > > > +                               if (timer_pending(&tw->tw_timer))
> > > > +                                       inet_twsk_deschedule_put(tw=
);
> > >
> > >
> > > This patch is not needed, and a timer_pending() would be racy anywau.
> > >
> > > As already explained, del_timer_sync() takes care of this with proper=
 locking.
> > >
> > > inet_twsk_deschedule_put(struct inet_timewait_sock *tw)
> > > {
> > >   if (del_timer_sync(&tw->tw_timer))
> > >      inet_twsk_kill(tw);
> > >   inet_twsk_put(tw);
> > > }
> >
> > Sorry, I'm lost. But now I understand what I wrote in the morning is
> > not correct...
> >
> > After rethinking about this, only reordering the mod_timer() and
> > refcount_inc() in the initialization phase (just like the patch you
> > wrote) can ensure safety.
> >
> > CPU 0 uses del_timer_sync() to detect if the timer is running while
> > CPU 1 mod_timer() and then increments the refcount.
> >
> > 1) If CPU 0 sees the queued timer which means the tw socket has done
> > incrementing refcount, then CPU 0 can kill (inet_twsk_kill()) the
> > socket.
> >
> > 2) If CPU 0 cannot see the queued timer (and will not kill the
> > socket), then CPU 1 will call mod_timer() and expire in one minute.
> > Another cpu will call inet_twsk_kill() to clear tw socket at last.
> >
> > The patch you provided seems to solve the race issue in the right
> > way... I cannot see the problem of it :(
> >
> > So what is the problem to be solved with your patch? Thanks for your
> > patience and help.
>
> I already explained that when we do the mod_timer() and
> refcount_inc(&tw->tw_dr->tw_refcount),
> the tw refcount is 0, and no other cpu can possibly use the tw.
>
> So the order of these operations seems not really relevant.
>
> Another cpu, before trying to use it would have first to acquire a
> reference on tw refcount,
> and this is not allowed/possible.
>
> inet_twsk_purge() would hit this at this failed attempt.
>
> if (unlikely(!refcount_inc_not_zero(&sk->sk_refcnt)))
>      continue;
>
> I think we should wait for more syzbot occurrences before spending
> more time on this.
>
> It is possible the single report was caused by unrelated memory
> mangling in the kernel,
> or some more fundamental issues caused by kernel listeners and sockets.

Thank you so much, Eric!! I learn a lot.

