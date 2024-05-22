Return-Path: <netdev+bounces-97496-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D06F78CBB48
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 08:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E15FAB209F8
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 06:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3728E78C97;
	Wed, 22 May 2024 06:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W2AR2jAg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A8478C6E
	for <netdev@vger.kernel.org>; Wed, 22 May 2024 06:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716359291; cv=none; b=OzVNPwZtRZf9X6Y5zwdOK9HvYRlbH3Ps5Hk8cTTeL5jIuD9A2jGW8C7mVAqEdGm8fNRzeNDjFJifkHgQKVbMkKe+KnhIW/McPKJkNG2OIW2jL0tcZ2ocqea8LDsuSyVn4U99yaXgM0j1XY9u8OIPlYlGL5sRVou83Tn8vAt0HiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716359291; c=relaxed/simple;
	bh=dsCt5/5yQePxtjl9uHoAb0zzy6lYXjn5SP1Ji4IOdiY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ukTF7+CYh/4j0u800Ui1jwIzRBRSYEYT22Q2/OlJFpgvyx9Qv70VFUn1uaQzXWSGy8DgupO0r48v/97ZBxYK7DeXLb+EmOELS6XkSYklkx1BoV/oSUdbRgX9EqmYAwO1rCW+wpd6jhHy0d0s64V4lDZ5mlxFsGp1ilvEubFx5tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W2AR2jAg; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a5a5cb0e6b7so969601766b.1
        for <netdev@vger.kernel.org>; Tue, 21 May 2024 23:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716359287; x=1716964087; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xlGJVc0DRbTbhvDUDIPCn1K0nizslwA4a/LA9ioUES0=;
        b=W2AR2jAgNbZrzjMPHAkD1lk1LQsm2z+uf3H0oPSg7MLKU9U+Djg29ju+2+SOaRF3og
         YvpzPrUZifPfHL/KU1wcjo7c6DDyr6EsCZE1RjqsHNiHXufS6kr/5tFJz3Wc0WRQimMR
         24jefWM2XoUT2xYrqNpLBnN1toV4XTBRduBI7N58tHTxX7opDDnAZyZ5kpZDrK+xY7jZ
         3wLq7gRzhI4CHpB7Ts32bpYPbNJtwbqnJn4oyHpRRoDBNDDWbGGiWNiB54O5lV6KfC9b
         ORokn2FMdNfExXpCOwaiUWuyhbzzY5nKw9107pXVmJPSnW1j1MjjkzQZPl6PomtnIZAr
         9qIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716359287; x=1716964087;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xlGJVc0DRbTbhvDUDIPCn1K0nizslwA4a/LA9ioUES0=;
        b=uTK5FpNwpC/Xs+ojMU95jPwho7wOWf3Dy8oqTOwD0cwknXUBfD1z/ANkOjX/HBDGvg
         HJJzGbSMCoU5HpwB87xwDY6gajsw+OEmWqiFJCQSBcSkXsEPlJ/xUwzDTBE7VYqxgnWI
         O1VGplUjLzhHeUSy62znC6Ua4KBIzq9IDfp6Qkt6z4dCX6UeWFEFlGFK97v+P+VervtQ
         eIjSkGIoCjRrUG9bGkaPy1mHQ7syYyMonv3swHnq8nemWUNYHMwQav+rzdSlB4wdByTf
         UvJ8T8B1DUUt2DxTLNK/4YTzc/WpPrghhObCo2lSYjhAzzJWuAFrB2neVLXJiuQIuv5f
         303Q==
X-Forwarded-Encrypted: i=1; AJvYcCVU4Y1uS6jG7F2+ZvgJNRpL1av+n0pFGutJkV7xV6oSNIsrkaHGnGM89GcaHb7jPRucKwh5tgG1Bs4ygwaZobm1X4Tsdr+w
X-Gm-Message-State: AOJu0Yy64LM1F+220t0dfiwd9+vBNTxB+exk7AUxVtNmun4sxis3hGMp
	j44BGaA2/Bp6W/23FmFAsJL1y2nkNGRAkcw5Mra+N9rqHkW2BCl1F9HHs9lpZVvnV0NrJ/XsaTt
	hXemDut1VnxrogUM77M8G8X74HeI=
X-Google-Smtp-Source: AGHT+IGQ9l8HPH1+RkyBhwpAoP/+z2thtmFf4Wbwd/LTrqaiys79rsiKVmntu/xIxZMybzXF++bPWViA9TBOIHEEpuY=
X-Received: by 2002:a17:906:5a91:b0:a5a:51dc:d14 with SMTP id
 a640c23a62f3a-a622806b6f6mr59342866b.14.1716359287341; Tue, 21 May 2024
 23:28:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240521144930.23805-1-kerneljasonxing@gmail.com> <CANn89iLL+DZA=CyPG+1Lcu1XRcPkc3pHKKQ4X9tm9MoeF7FPYQ@mail.gmail.com>
In-Reply-To: <CANn89iLL+DZA=CyPG+1Lcu1XRcPkc3pHKKQ4X9tm9MoeF7FPYQ@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 22 May 2024 14:27:30 +0800
Message-ID: <CAL+tcoAKEv2WOV-4k5kDa2EJMGp_h0bW3jhYZrQ9aiK+s4AcOQ@mail.gmail.com>
Subject: Re: [PATCH net] Revert "rds: tcp: Fix use-after-free of net in reqsk_timer_handler()."
To: Eric Dumazet <edumazet@google.com>
Cc: dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	davem@davemloft.net, kuniyu@amazon.com, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>, 
	syzbot+2eca27bdcb48ed330251@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Eric,

On Tue, May 21, 2024 at 11:49=E2=80=AFPM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Tue, May 21, 2024 at 4:49=E2=80=AFPM Jason Xing <kerneljasonxing@gmail=
.com> wrote:
> >
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > This reverts commit 2a750d6a5b365265dbda33330a6188547ddb5c24.
> >
> > Syzbot[1] reported the drecrement of reference count hits leaking memor=
y.
> >
> > If we failed in setup_net() and try to undo the setup process, the
> > reference now is 1 which shouldn't be decremented. However, it happened
> > actually.
> >
> > After applying this patch which allows us to check the reference first,
> > it will not hit zero anymore in tcp_twsk_purge() without calling
> > inet_twsk_purge() one more time.
> >
> > [1]
> > refcount_t: decrement hit 0; leaking memory.
> > WARNING: CPU: 3 PID: 1396 at lib/refcount.c:31 refcount_warn_saturate+0=
x1ed/0x210 lib/refcount.c:31
> > Modules linked in:
> > CPU: 3 PID: 1396 Comm: syz-executor.3 Not tainted 6.9.0-syzkaller-07370=
-g33e02dc69afb #0
> > Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-=
1.16.2-1 04/01/2014
> > RIP: 0010:refcount_warn_saturate+0x1ed/0x210 lib/refcount.c:31
> > RSP: 0018:ffffc9000480fa70 EFLAGS: 00010282
> > RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffc9002ce28000
> > RDX: 0000000000040000 RSI: ffffffff81505406 RDI: 0000000000000001
> > RBP: ffff88804d8b3f80 R08: 0000000000000001 R09: 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000002 R12: ffff88804d8b3f80
> > R13: ffff888031c601c0 R14: ffffc900013c04f8 R15: 000000002a3e5567
> > FS:  00007f56d897c6c0(0000) GS:ffff88806b300000(0000) knlGS:00000000000=
00000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 0000001b3182b000 CR3: 0000000034ed6000 CR4: 0000000000350ef0
> > Call Trace:
> >  <TASK>
> >  __refcount_dec include/linux/refcount.h:336 [inline]
> >  refcount_dec include/linux/refcount.h:351 [inline]
> >  inet_twsk_kill+0x758/0x9c0 net/ipv4/inet_timewait_sock.c:70
> >  inet_twsk_deschedule_put net/ipv4/inet_timewait_sock.c:221 [inline]
> >  inet_twsk_purge+0x725/0x890 net/ipv4/inet_timewait_sock.c:304
> >  tcp_twsk_purge+0x115/0x150 net/ipv4/tcp_minisocks.c:402
> >  tcp_sk_exit_batch+0x1c/0x170 net/ipv4/tcp_ipv4.c:3522
> >  ops_exit_list+0x128/0x180 net/core/net_namespace.c:178
> >  setup_net+0x714/0xb40 net/core/net_namespace.c:375
> >  copy_net_ns+0x2f0/0x670 net/core/net_namespace.c:508
> >  create_new_namespaces+0x3ea/0xb10 kernel/nsproxy.c:110
> >  unshare_nsproxy_namespaces+0xc0/0x1f0 kernel/nsproxy.c:228
> >  ksys_unshare+0x419/0x970 kernel/fork.c:3323
> >  __do_sys_unshare kernel/fork.c:3394 [inline]
> >  __se_sys_unshare kernel/fork.c:3392 [inline]
> >  __x64_sys_unshare+0x31/0x40 kernel/fork.c:3392
> >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >  do_syscall_64+0xcf/0x260 arch/x86/entry/common.c:83
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > RIP: 0033:0x7f56d7c7cee9
> >
> > Fixes: 2a750d6a5b36 ("rds: tcp: Fix use-after-free of net in reqsk_time=
r_handler().")
> > Reported-by: syzbot+2eca27bdcb48ed330251@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=3D2eca27bdcb48ed330251
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > ---
> > The reverted patch trying to solve another issue causes unexpected erro=
r as above. I
> > think that issue can be properly analyzed and handled later. So can we =
revert it first?
> > ---
> >  net/ipv4/tcp_minisocks.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
> > index b93619b2384b..46e6f9db4227 100644
> > --- a/net/ipv4/tcp_minisocks.c
> > +++ b/net/ipv4/tcp_minisocks.c
> > @@ -399,6 +399,10 @@ void tcp_twsk_purge(struct list_head *net_exit_lis=
t)
> >                         /* Even if tw_refcount =3D=3D 1, we must clean =
up kernel reqsk */
> >                         inet_twsk_purge(net->ipv4.tcp_death_row.hashinf=
o);
> >                 } else if (!purged_once) {
> > +                       /* The last refcount is decremented in tcp_sk_e=
xit_batch() */
> > +                       if (refcount_read(&net->ipv4.tcp_death_row.tw_r=
efcount) =3D=3D 1)
> > +                               continue;
> > +
> >                         inet_twsk_purge(&tcp_hashinfo);
> >                         purged_once =3D true;
> >                 }
> > --
>
> This can not be a fix for a race condition.
>
> By definition a TW has a refcount on tcp_death_row.tw_refcount   only
> if its timer is armed.
>
> And inet_twsk_deschedule_put() does
>
> if (del_timer_sync(&tw->tw_timer))
>     inet_twsk_kill(tw);
>
> I think you need to provide a full explanation, instead of a shot in the =
dark.
>
> Before releasing this syzbot, I thought that maybe the refcount_inc()
> was done too late,
> but considering other invariants, this should not matter.
>
> diff --git a/net/ipv4/inet_timewait_sock.c b/net/ipv4/inet_timewait_sock.=
c
> index e28075f0006e333897ad379ebc8c87fc3f9643bd..d8f4d93c45331be64d70af96d=
e33f783870e1dcc
> 100644
> --- a/net/ipv4/inet_timewait_sock.c
> +++ b/net/ipv4/inet_timewait_sock.c
> @@ -255,8 +255,8 @@ void __inet_twsk_schedule(struct
> inet_timewait_sock *tw, int timeo, bool rearm)
>
>                 __NET_INC_STATS(twsk_net(tw), kill ? LINUX_MIB_TIMEWAITKI=
LLED :
>                                                      LINUX_MIB_TIMEWAITED=
);
> -               BUG_ON(mod_timer(&tw->tw_timer, jiffies + timeo));
>                 refcount_inc(&tw->tw_dr->tw_refcount);
> +               BUG_ON(mod_timer(&tw->tw_timer, jiffies + timeo));
>         } else {
>                 mod_timer_pending(&tw->tw_timer, jiffies + timeo);
>         }

Thanks for your information.

What you wrote is right, I think for a while. In
inet_twsk_deschedule_put(), there are two possible cases:
1) if it finds the timer is armed, then it can kill the tw socket by
decrementing the refcount in the right way. So it's a good/lucky thing
for us.
or
2) if it misses the point, then the tw socket arms the timer which
will expire in 60 seconds in the initialization phase. The tw socket
would have a chance to be destroyed when the timer expires.

It seems that you don't think your code could solve the race issue?

Thanks,
Jason

