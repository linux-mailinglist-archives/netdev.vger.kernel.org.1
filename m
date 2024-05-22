Return-Path: <netdev+bounces-97600-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ADFF8CC43A
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 17:38:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E5341C21510
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 15:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43BDA770F1;
	Wed, 22 May 2024 15:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hOkIgo2L"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F621171C
	for <netdev@vger.kernel.org>; Wed, 22 May 2024 15:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716392287; cv=none; b=bX+A2sBoHcO/779M+BFHBM4B/Snwr3EQ8K9A5bkg4PsR3EK3WQyxLfj1Um9GSQffuYTYJHe9FSjU1o5A0INAlmgyOmIL5vOZis5/uqnayf5bF9WUjmfIYRZW6XtRh3NcO2CSKB2ysL2kP5EDFnTTycAY2SaLfrNbFZuPeAf8GXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716392287; c=relaxed/simple;
	bh=sP5W7MgGGTa+UCbVcjz0Hfb/tSqr2hoyyNukSlA1yMs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UWRfMQkaBRBvOgOz/mug4OkbTxQp7LeNTXrVN5ObYPV5ZJsT1rQSjWDBRFdVaDvQ1XXikXU+861bFqxFu9EfaY6UEqEP4Erx6+JSvWMs+fMIqWYvTcLNifY4/C1l8Bwhk9IPUaj9twcDgn5t23hjHENR0nNB/dsq9Cmzm7RZ4C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hOkIgo2L; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-574d1a1c36aso10180077a12.3
        for <netdev@vger.kernel.org>; Wed, 22 May 2024 08:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716392283; x=1716997083; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XgflnjdlRaGltfaZbivBgRMS0XjhmxdaW244MMwdzNw=;
        b=hOkIgo2LpwUm8edXNDFt/KE6xDXzgw/6pjF4RtD+ZSP4dSKRxgNQ7+ujNO3CxhEhE7
         mUwuE7yPQebrNEPwj1i7qHPITaOQiCAXqF/BSCZdUXawSfq3+FplG2Snh3B49oDBKydN
         jwBdAAaf71BNOKib+sWIMHT4vBQbEDWivJxOAuzLZBCDYaYvyJw7EsflEOqSa2Cs8hsG
         Z32aXmogOBla7xo2zTl2zInpo1JBiDHpu1YEfn3lHwbg5zzQN4Y1R+XezczDtuxnudkG
         DAb5RhyJjUKbp+yRI2bXpYHLH98RkEiHQynTx93sLqwdGjjrpffwKjiYBpzzjXpB1/V7
         kjYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716392283; x=1716997083;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XgflnjdlRaGltfaZbivBgRMS0XjhmxdaW244MMwdzNw=;
        b=Q60jaff/w3VZJHDtQ50wOc791+2j+CABHhYIuQUHjf0xaUQSKD7StXawFzDglq0DZ1
         LqYxM6VJO2aNpzDBa8W+0EX4QUgZGWgLmBgoxtgMkvRaTcpVcLVWppXUbAzTDzibi028
         iFO3ouzVX7iyOuNwwim4u+onwrDfHFKEKICPe3yFp1Z+BtJ/kzmsb+bDbG6KC3khNQTg
         lAfOhDcE0SOwG2abpYf7fp0T3PaiY4t3gfHJJjQJ4+RNnZD1sxCEKqalSEG3Ms2JUtfI
         Amo89osrLshJym2E+Si7T8Sg9xrbCXtR9ECORq3YqRiMtsQh07GfHv9IGv1sV9WxBj3x
         +LCw==
X-Forwarded-Encrypted: i=1; AJvYcCXp3DSUsh33L5JgzLuIagElYBOFUu3By39HWHvLZZ8LBvlvyxhjDCtxdezbuJ8CO0AWf6PlsQUwWeo2YqsTUGUNFfx4ZxVE
X-Gm-Message-State: AOJu0YzxX/lznh/rVP3TctByRqU1gxM2BdnvyniinVzaxChD6JFZbgQe
	DEcaNh6HZQBjvF0NwilBucE5w6cHgHtxXyB9vumTunvV2xjSKVnrSIk6snyckbZmaSux7glTirq
	6VvnVc/T6kUEmWkzdqaBW+n2yVUk=
X-Google-Smtp-Source: AGHT+IEC0sZnejXa30IrXa57mdxfoSk5NblNISTHINhjIqb9+ZoTA+3ZNXZllUN28wbV7dOHAmq9KziBaNhiv+GDzBo=
X-Received: by 2002:a17:906:6c4:b0:a59:f380:1821 with SMTP id
 a640c23a62f3a-a622819182cmr165006466b.69.1716392283391; Wed, 22 May 2024
 08:38:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240521144930.23805-1-kerneljasonxing@gmail.com>
 <CANn89iLL+DZA=CyPG+1Lcu1XRcPkc3pHKKQ4X9tm9MoeF7FPYQ@mail.gmail.com>
 <CAL+tcoAKEv2WOV-4k5kDa2EJMGp_h0bW3jhYZrQ9aiK+s4AcOQ@mail.gmail.com>
 <CANn89iKAGeR9CX1cOSXFK8CH-d9bS_sHvU1DhGvhvt7CmCSsAg@mail.gmail.com>
 <CAL+tcoBWna3J80Kx5=R4khOgvG8Dcyb22nf3wx_dW+5Jcz+AMA@mail.gmail.com> <CANn89iLyvjv+q9iYQVbZt6yY8eWXUULBFVs7DAZG2DWs+3nQ1A@mail.gmail.com>
In-Reply-To: <CANn89iLyvjv+q9iYQVbZt6yY8eWXUULBFVs7DAZG2DWs+3nQ1A@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 22 May 2024 23:37:26 +0800
Message-ID: <CAL+tcoC+QhOcZjADhLjhdHoQczLTbruefAevy1+d8Tp+xMvi0Q@mail.gmail.com>
Subject: Re: [PATCH net] Revert "rds: tcp: Fix use-after-free of net in reqsk_timer_handler()."
To: Eric Dumazet <edumazet@google.com>
Cc: dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	davem@davemloft.net, kuniyu@amazon.com, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>, 
	syzbot+2eca27bdcb48ed330251@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 22, 2024 at 6:54=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Wed, May 22, 2024 at 12:42=E2=80=AFPM Jason Xing <kerneljasonxing@gmai=
l.com> wrote:
> >
> > On Wed, May 22, 2024 at 2:51=E2=80=AFPM Eric Dumazet <edumazet@google.c=
om> wrote:
> > >
> > > On Wed, May 22, 2024 at 8:28=E2=80=AFAM Jason Xing <kerneljasonxing@g=
mail.com> wrote:
> > > >
> > > > Hello Eric,
> > > >
> > > > On Tue, May 21, 2024 at 11:49=E2=80=AFPM Eric Dumazet <edumazet@goo=
gle.com> wrote:
> > > > >
> > > > > On Tue, May 21, 2024 at 4:49=E2=80=AFPM Jason Xing <kerneljasonxi=
ng@gmail.com> wrote:
> > > > > >
> > > > > > From: Jason Xing <kernelxing@tencent.com>
> > > > > >
> > > > > > This reverts commit 2a750d6a5b365265dbda33330a6188547ddb5c24.
> > > > > >
> > > > > > Syzbot[1] reported the drecrement of reference count hits leaki=
ng memory.
> > > > > >
> > > > > > If we failed in setup_net() and try to undo the setup process, =
the
> > > > > > reference now is 1 which shouldn't be decremented. However, it =
happened
> > > > > > actually.
> > > > > >
> > > > > > After applying this patch which allows us to check the referenc=
e first,
> > > > > > it will not hit zero anymore in tcp_twsk_purge() without callin=
g
> > > > > > inet_twsk_purge() one more time.
> > > > > >
> > > > > > [1]
> > > > > > refcount_t: decrement hit 0; leaking memory.
> > > > > > WARNING: CPU: 3 PID: 1396 at lib/refcount.c:31 refcount_warn_sa=
turate+0x1ed/0x210 lib/refcount.c:31
> > > > > > Modules linked in:
> > > > > > CPU: 3 PID: 1396 Comm: syz-executor.3 Not tainted 6.9.0-syzkall=
er-07370-g33e02dc69afb #0
> > > > > > Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2=
-debian-1.16.2-1 04/01/2014
> > > > > > RIP: 0010:refcount_warn_saturate+0x1ed/0x210 lib/refcount.c:31
> > > > > > RSP: 0018:ffffc9000480fa70 EFLAGS: 00010282
> > > > > > RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffc9002ce280=
00
> > > > > > RDX: 0000000000040000 RSI: ffffffff81505406 RDI: 00000000000000=
01
> > > > > > RBP: ffff88804d8b3f80 R08: 0000000000000001 R09: 00000000000000=
00
> > > > > > R10: 0000000000000000 R11: 0000000000000002 R12: ffff88804d8b3f=
80
> > > > > > R13: ffff888031c601c0 R14: ffffc900013c04f8 R15: 000000002a3e55=
67
> > > > > > FS:  00007f56d897c6c0(0000) GS:ffff88806b300000(0000) knlGS:000=
0000000000000
> > > > > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > > > CR2: 0000001b3182b000 CR3: 0000000034ed6000 CR4: 0000000000350e=
f0
> > > > > > Call Trace:
> > > > > >  <TASK>
> > > > > >  __refcount_dec include/linux/refcount.h:336 [inline]
> > > > > >  refcount_dec include/linux/refcount.h:351 [inline]
> > > > > >  inet_twsk_kill+0x758/0x9c0 net/ipv4/inet_timewait_sock.c:70
> > > > > >  inet_twsk_deschedule_put net/ipv4/inet_timewait_sock.c:221 [in=
line]
> > > > > >  inet_twsk_purge+0x725/0x890 net/ipv4/inet_timewait_sock.c:304
> > > > > >  tcp_twsk_purge+0x115/0x150 net/ipv4/tcp_minisocks.c:402
> > > > > >  tcp_sk_exit_batch+0x1c/0x170 net/ipv4/tcp_ipv4.c:3522
> > > > > >  ops_exit_list+0x128/0x180 net/core/net_namespace.c:178
> > > > > >  setup_net+0x714/0xb40 net/core/net_namespace.c:375
> > > > > >  copy_net_ns+0x2f0/0x670 net/core/net_namespace.c:508
> > > > > >  create_new_namespaces+0x3ea/0xb10 kernel/nsproxy.c:110
> > > > > >  unshare_nsproxy_namespaces+0xc0/0x1f0 kernel/nsproxy.c:228
> > > > > >  ksys_unshare+0x419/0x970 kernel/fork.c:3323
> > > > > >  __do_sys_unshare kernel/fork.c:3394 [inline]
> > > > > >  __se_sys_unshare kernel/fork.c:3392 [inline]
> > > > > >  __x64_sys_unshare+0x31/0x40 kernel/fork.c:3392
> > > > > >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> > > > > >  do_syscall_64+0xcf/0x260 arch/x86/entry/common.c:83
> > > > > >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > > > > > RIP: 0033:0x7f56d7c7cee9
> > > > > >
> > > > > > Fixes: 2a750d6a5b36 ("rds: tcp: Fix use-after-free of net in re=
qsk_timer_handler().")
> > > > > > Reported-by: syzbot+2eca27bdcb48ed330251@syzkaller.appspotmail.=
com
> > > > > > Closes: https://syzkaller.appspot.com/bug?extid=3D2eca27bdcb48e=
d330251
> > > > > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > > > > ---
> > > > > > The reverted patch trying to solve another issue causes unexpec=
ted error as above. I
> > > > > > think that issue can be properly analyzed and handled later. So=
 can we revert it first?
> > > > > > ---
> > > > > >  net/ipv4/tcp_minisocks.c | 4 ++++
> > > > > >  1 file changed, 4 insertions(+)
> > > > > >
> > > > > > diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.=
c
> > > > > > index b93619b2384b..46e6f9db4227 100644
> > > > > > --- a/net/ipv4/tcp_minisocks.c
> > > > > > +++ b/net/ipv4/tcp_minisocks.c
> > > > > > @@ -399,6 +399,10 @@ void tcp_twsk_purge(struct list_head *net_=
exit_list)
> > > > > >                         /* Even if tw_refcount =3D=3D 1, we mus=
t clean up kernel reqsk */
> > > > > >                         inet_twsk_purge(net->ipv4.tcp_death_row=
.hashinfo);
> > > > > >                 } else if (!purged_once) {
> > > > > > +                       /* The last refcount is decremented in =
tcp_sk_exit_batch() */
> > > > > > +                       if (refcount_read(&net->ipv4.tcp_death_=
row.tw_refcount) =3D=3D 1)
> > > > > > +                               continue;
> > > > > > +
> > > > > >                         inet_twsk_purge(&tcp_hashinfo);
> > > > > >                         purged_once =3D true;
> > > > > >                 }
> > > > > > --
> > > > >
> > > > > This can not be a fix for a race condition.
> > > > >
> > > > > By definition a TW has a refcount on tcp_death_row.tw_refcount   =
only
> > > > > if its timer is armed.
> > > > >
> > > > > And inet_twsk_deschedule_put() does
> > > > >
> > > > > if (del_timer_sync(&tw->tw_timer))
> > > > >     inet_twsk_kill(tw);
> > > > >
> > > > > I think you need to provide a full explanation, instead of a shot=
 in the dark.
> > > > >
> > > > > Before releasing this syzbot, I thought that maybe the refcount_i=
nc()
> > > > > was done too late,
> > > > > but considering other invariants, this should not matter.
> > > > >
> > > > > diff --git a/net/ipv4/inet_timewait_sock.c b/net/ipv4/inet_timewa=
it_sock.c
> > > > > index e28075f0006e333897ad379ebc8c87fc3f9643bd..d8f4d93c45331be64=
d70af96de33f783870e1dcc
> > > > > 100644
> > > > > --- a/net/ipv4/inet_timewait_sock.c
> > > > > +++ b/net/ipv4/inet_timewait_sock.c
> > > > > @@ -255,8 +255,8 @@ void __inet_twsk_schedule(struct
> > > > > inet_timewait_sock *tw, int timeo, bool rearm)
> > > > >
> > > > >                 __NET_INC_STATS(twsk_net(tw), kill ? LINUX_MIB_TI=
MEWAITKILLED :
> > > > >                                                      LINUX_MIB_TI=
MEWAITED);
> > > > > -               BUG_ON(mod_timer(&tw->tw_timer, jiffies + timeo))=
;
> > > > >                 refcount_inc(&tw->tw_dr->tw_refcount);
> > > > > +               BUG_ON(mod_timer(&tw->tw_timer, jiffies + timeo))=
;
> > > > >         } else {
> > > > >                 mod_timer_pending(&tw->tw_timer, jiffies + timeo)=
;
> > > > >         }
> > > >
> > > > Thanks for your information.
> > > >
> > > > What you wrote is right, I think for a while. In
> > > > inet_twsk_deschedule_put(), there are two possible cases:
> > > > 1) if it finds the timer is armed, then it can kill the tw socket b=
y
> > > > decrementing the refcount in the right way. So it's a good/lucky th=
ing
> > > > for us.
> > > > or
> > > > 2) if it misses the point, then the tw socket arms the timer which
> > > > will expire in 60 seconds in the initialization phase. The tw socke=
t
> > > > would have a chance to be destroyed when the timer expires.
> > > >
> > > > It seems that you don't think your code could solve the race issue?
> > >
> > > inet_twsk_schedule(tw) is called while the tw refcount is still 0, so
> > > this tw can be be found in  inet_twsk_purge()
> > > at the same time. Look at inet_twsk_hashdance() for details.
> >
> > Yes, after inet_twsk_purge() finds the tw, there are two cases like my
> > previous email said after applying your code.
> >
> > For 1) case, everything is good. inet_twsk_purge() will finish it up
> > because it can decrement the refcount safely.
> >
> > For 2) case, even though inet_twsk_purge() finds it, it's not the time
> > to destroy it until the expired tw timer will finally handle the
> > process of destruction by calling inet_twsk_kill(), right? Let the
> > timer handle the destruction until its end of life, which I think is a
> > normal process for all the timewait sockets.
> >
> > The only difference in 2) case is that inet_twsk_purge() calls
> > inet_twsk_put() twice while tw_timer_handler() only calls it one time.
> >
> > Am I missing something?
>
> You are missing that inet_twsk_deschedule_put() is doing :
>
> if (del_timer_sync(&tw->tw_timer))
>     inet_twsk_kill(tw);
>
> You can not have both tw_timer_handler() and
> inet_twsk_deschedule_put() calling inet_twsk_kill(tw);
[...]
>
> Take a look at del_timer_sync()

Oops, I missed this function...Thanks for pointing it out.

I can test if the timer is active or queued before we can delete, like
this on top of your patch:
diff --git a/net/ipv4/inet_timewait_sock.c b/net/ipv4/inet_timewait_sock.c
index e28075f0006e..b890d1c280a1 100644
--- a/net/ipv4/inet_timewait_sock.c
+++ b/net/ipv4/inet_timewait_sock.c
@@ -255,8 +255,8 @@ void __inet_twsk_schedule(struct
inet_timewait_sock *tw, int timeo, bool rearm)

                __NET_INC_STATS(twsk_net(tw), kill ? LINUX_MIB_TIMEWAITKILL=
ED :
                                                     LINUX_MIB_TIMEWAITED);
-               BUG_ON(mod_timer(&tw->tw_timer, jiffies + timeo));
                refcount_inc(&tw->tw_dr->tw_refcount);
+               BUG_ON(mod_timer(&tw->tw_timer, jiffies + timeo));
        } else {
                mod_timer_pending(&tw->tw_timer, jiffies + timeo);
        }
@@ -301,7 +301,14 @@ void inet_twsk_purge(struct inet_hashinfo *hashinfo)
                        rcu_read_unlock();
                        local_bh_disable();
                        if (state =3D=3D TCP_TIME_WAIT) {
-                               inet_twsk_deschedule_put(inet_twsk(sk));
+                               struct inet_timewait_sock *tw =3D inet_twsk=
(sk);
+
+                               /* If the timer is armed, we can safely des=
troy
+                                * it, or else we postpone the process
of destruction
+                                * to tw_timer_handler().
+                                */
+                               if (timer_pending(&tw->tw_timer))
+                                       inet_twsk_deschedule_put(tw);
                        } else {
                                struct request_sock *req =3D inet_reqsk(sk)=
;

As above, if we find the timer is armed, then we can destroy it
naturally in inet_twsk_deschedule_put(). If not, we can skip it in the
inet_twsk_purge() and then postpone the destruction process in the
timer handler.

I think I need to add another test about whether the timer is running or no=
t.

If testing the status of timer is not a good way to go, perhaps I
would like to introduce a new flag to indicate whether the tw socket
still exists in the initialization phase.

Sorry, It's __not__ tested because it's too late for me, I will spend
more time taking care of this race condition tomorrow.

Thanks,
Jason

