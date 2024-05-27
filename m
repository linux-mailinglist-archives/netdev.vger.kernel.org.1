Return-Path: <netdev+bounces-98143-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 546678CFAF2
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 10:07:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76F3E1C20F58
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 08:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FFD83A1B6;
	Mon, 27 May 2024 08:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R+kOLCYt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BEC22301
	for <netdev@vger.kernel.org>; Mon, 27 May 2024 08:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716797232; cv=none; b=o6TTXSJXdcLc/qexLoOTwH/qFm4eCdROLdwbUo9fcKvOzW7WyCG0Lm7dRoqAWXxvtL2rbxV1d1PRQcuX/nzsCurk1udJGOhN/0+Z56/ZeNlw+GbInisVlXGRdXzgvToaKjzgZP1+ofF1xwojzN4R5Wgp9a4fdlqlONDF+OHUvn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716797232; c=relaxed/simple;
	bh=O3MIPz71hUlQLEH+w8v4nxSGZ2eKJtzIWjBuDtBpkcY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tw+3/idTR3KouD8TDz4Wje/qbLM9j3tHShKVsZPjUxxuup+d2Ak/hSf7dYEl6dxDwVMuUU0npjto2xCJKvL40i1FId5Z2ojjKZejyO2eGZionsVADuRJxejxa6YG3+5hjFp3y0bgI8PgaQqxDrFm40G5Xi+d7+NUIPN+VcmedsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R+kOLCYt; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5295dadce7fso3744510e87.1
        for <netdev@vger.kernel.org>; Mon, 27 May 2024 01:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716797229; x=1717402029; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hJavN+S5S/6YFUyMSLd696VRxZVmXte+AYUxUAxlLk8=;
        b=R+kOLCYtC0aaQU7volljjQ5fa1JG+v3aPa4qweAAw5nOoihth0HoYmo8emcwh1DUOq
         uKOMQiIqdXzu2Rw9Zudrd4I3yuawzgTxUtJSF3GdJLpVpmphD3+6cU5wM/D+hlX0qe5n
         666WxicHYqESpXclslg0502ivf2urdneuYgTz06a37bwarewGK/03vxfAAA7wdt+djLQ
         JbjgK352JSiCYIU3GobTiRmjIMxYV1aLwYKBoWPkVGBmuy+sxltHInb5q09v+5XMDGxp
         1BAc0DhFvm/1lZ+uVamH155WR5DHuJLUtW0xB5a2R4wR8JsYN35lLrLTvjX6hzqYCBOF
         78Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716797229; x=1717402029;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hJavN+S5S/6YFUyMSLd696VRxZVmXte+AYUxUAxlLk8=;
        b=s0+rC+upHutVBxYamm+kc/ZH6JxTdltZh6nmaegepZcRZ/R2tIJq1XHFaDh9EXtHnt
         28LjSQZp5OgoTJ+wmfYtVISwf0kzvVsW+w9XM5b4Clqysjn0pZHDc7I9OYiGZepyTyO8
         FF4iArpVVmYfLCHNgv4BwHDeDG3tnA0H4fjaR/0vmIaJCU4SBEAkOCTPYwlA8KftMcTo
         t3TBxDthmWzX1DD5a0PCJ/5Nt6vrHnHxkNGBVyE3l7A6rypaz/mAhb2d8CEVxVHLY1ev
         1js3//nXccMmeaxY6Qf1IvLZnN3DEhcNFli0HR8EqBBXSk1vBropzGaXbMq+qy2IZp5W
         mdyg==
X-Forwarded-Encrypted: i=1; AJvYcCXVgiqAspO0TnFcPnKMfgXhQOoDI8p3wqgG//DsrH/4SPQZ/KDbFY2XQsILcdmcyuKLeH3rILYpvCqf7DWiGiV3GN3dmEpU
X-Gm-Message-State: AOJu0YxHVdk70JEFnKSuPnK/4+kjzbDP1FZdGtRFuRHpq26QM7mETjhN
	phPTQiw0zRlJys+T050USPGVz2U7fFC4Tpg9f0Xh8UnIDQ6ZP3LN2fwv/bZnuXiFSxg3DC7EuAc
	M4erC+KzwmpiPdJ27xcHSQYE4zjU=
X-Google-Smtp-Source: AGHT+IG0lS5r6TPFMWIsa7ABH29qzUT61oUBkUfWUaMSzcvOkDUH8B2Z4BEbgtsT4ZrsA8YeEs0YEKdIAJnd1SdwB+w=
X-Received: by 2002:a05:6512:328e:b0:51c:5171:bbed with SMTP id
 2adb3069b0e04-529649c5d97mr5380342e87.15.1716797228306; Mon, 27 May 2024
 01:07:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240524193630.2007563-1-edumazet@google.com> <20240524193630.2007563-2-edumazet@google.com>
 <CADVnQyk6CkWU-mETm9yM65Me91aVRr5ngXi2hkD6aETakB+c2w@mail.gmail.com>
In-Reply-To: <CADVnQyk6CkWU-mETm9yM65Me91aVRr5ngXi2hkD6aETakB+c2w@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 27 May 2024 16:06:31 +0800
Message-ID: <CAL+tcoDq5G_KU3jJ2=kedHz9OvmLRD5sKf_KLrw3mg-yKrhtkw@mail.gmail.com>
Subject: Re: [PATCH net 1/4] tcp: add tcp_done_with_error() helper
To: Neal Cardwell <ncardwell@google.com>
Cc: Eric Dumazet <edumazet@google.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Neal,

On Sat, May 25, 2024 at 10:14=E2=80=AFPM Neal Cardwell <ncardwell@google.co=
m> wrote:
>
> On Fri, May 24, 2024 at 3:36=E2=80=AFPM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > tcp_reset() ends with a sequence that is carefuly ordered.
> >
> > We need to fix [e]poll bugs in the following patches,
> > it makes sense to use a common helper.
> >
> > Suggested-by: Neal Cardwell <ncardwell@google.com>
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > ---
> >  include/net/tcp.h    |  1 +
> >  net/ipv4/tcp.c       |  2 +-
> >  net/ipv4/tcp_input.c | 25 +++++++++++++++++--------
> >  3 files changed, 19 insertions(+), 9 deletions(-)
> >
> > diff --git a/include/net/tcp.h b/include/net/tcp.h
> > index 060e95b331a286ad7c355be11dc03250d2944920..2e7150f6755a5f5bf7b4545=
4da0b33c5fac78183 100644
> > --- a/include/net/tcp.h
> > +++ b/include/net/tcp.h
> > @@ -677,6 +677,7 @@ void tcp_skb_collapse_tstamp(struct sk_buff *skb,
> >  /* tcp_input.c */
> >  void tcp_rearm_rto(struct sock *sk);
> >  void tcp_synack_rtt_meas(struct sock *sk, struct request_sock *req);
> > +void tcp_done_with_error(struct sock *sk);
> >  void tcp_reset(struct sock *sk, struct sk_buff *skb);
> >  void tcp_fin(struct sock *sk);
> >  void tcp_check_space(struct sock *sk);
> > diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> > index 681b54e1f3a64387787738ab6495531b8abe1771..2a8f8d8676ff1d30ea9f8cd=
47ccf9236940eb299 100644
> > --- a/net/ipv4/tcp.c
> > +++ b/net/ipv4/tcp.c
> > @@ -598,7 +598,7 @@ __poll_t tcp_poll(struct file *file, struct socket =
*sock, poll_table *wait)
> >                  */
> >                 mask |=3D EPOLLOUT | EPOLLWRNORM;
> >         }
> > -       /* This barrier is coupled with smp_wmb() in tcp_reset() */
> > +       /* This barrier is coupled with smp_wmb() in tcp_done_with_erro=
r() */
> >         smp_rmb();
> >         if (READ_ONCE(sk->sk_err) ||
> >             !skb_queue_empty_lockless(&sk->sk_error_queue))
> > diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> > index 9c04a9c8be9dfaa0ec2437b3748284e57588b216..5af716f1bc74e095d22f64d=
605624decfe27cefe 100644
> > --- a/net/ipv4/tcp_input.c
> > +++ b/net/ipv4/tcp_input.c
> > @@ -4436,6 +4436,22 @@ static enum skb_drop_reason tcp_sequence(const s=
truct tcp_sock *tp,
> >         return SKB_NOT_DROPPED_YET;
> >  }
> >
> > +
> > +void tcp_done_with_error(struct sock *sk)
> > +{
> > +       /* Our caller wrote a value into sk->sk_err.
> > +        * This barrier is coupled with smp_rmb() in tcp_poll()
> > +        */
> > +       smp_wmb();
> > +
> > +       tcp_write_queue_purge(sk);
> > +       tcp_done(sk);
> > +
> > +       if (!sock_flag(sk, SOCK_DEAD))
> > +               sk_error_report(sk);
> > +}
> > +EXPORT_SYMBOL(tcp_done_with_error);
> > +
> >  /* When we get a reset we do this. */
> >  void tcp_reset(struct sock *sk, struct sk_buff *skb)
> >  {
> > @@ -4460,14 +4476,7 @@ void tcp_reset(struct sock *sk, struct sk_buff *=
skb)
> >         default:
> >                 WRITE_ONCE(sk->sk_err, ECONNRESET);
> >         }
> > -       /* This barrier is coupled with smp_rmb() in tcp_poll() */
> > -       smp_wmb();
> > -
> > -       tcp_write_queue_purge(sk);
> > -       tcp_done(sk);
> > -
> > -       if (!sock_flag(sk, SOCK_DEAD))
> > -               sk_error_report(sk);
> > +       tcp_done_with_error(sk);
> >  }
> >
> >  /*
> > --
>
> Thanks, Eric!
>
> Thinking about this more, I wonder if there is another aspect to this iss=
ue.
>
> I am thinking about this part of tcp_done():
>
> void tcp_done(struct sock *sk)
> {
> ...
>         sk->sk_shutdown =3D SHUTDOWN_MASK;
>
>         if (!sock_flag(sk, SOCK_DEAD))
>                 sk->sk_state_change(sk);
>
> The tcp_poll() code reads sk->sk_shutdown to decide whether to set
> EPOLLHUP and other bits. However, sk->sk_shutdown is not set until
> here in tcp_done(). And in the tcp_done() code there is no smp_wmb()
> to ensure that the sk->sk_shutdown is visible to other CPUs before
> tcp_done() calls sk->sk_state_change() to wake up threads sleeping on
> sk->sk_wq.
>
> So AFAICT we could have cases where this sk->sk_state_change() (or the
> later sk_error_report()?) wakes a thread doing a tcp_poll() on another
> CPU, and the tcp_poll() code may correctly see the sk->sk_err because
> it was updated before the smp_wmb() in tcp_done_with_error(), but may
> fail to see the "sk->sk_shutdown =3D SHUTDOWN_MASK" write because that
> happened after the smp_wmb() in tcp_done_with_error().

I agree. Accessing sk_shutdown with a pair of smp operations makes
sure that another cpu can see the consistency of both sk_shutdown and
sk_err in tcp_poll().

>
> So AFAICT  maybe we need two changes?
>
> (1) AFAICT the call to smp_wmb() should actually instead be inside
> tcp_done(), after we set sk->sk_shutdown?
>
> void tcp_done(struct sock *sk)
> {
>         ...
>         sk->sk_shutdown =3D SHUTDOWN_MASK;
>
>         /* Ensure previous writes to sk->sk_err, sk->sk_state,
>          * sk->sk_shutdown are visible to others.
>          * This barrier is coupled with smp_rmb() in tcp_poll()
>          */
>         smp_wmb();

I wonder if it would affect those callers who have no interest in
pairing smp operations, like tcp_v4_syn_recv_sock()? For those
callers, WRITE_ONCE/READ_ONCE() is enough to protect itself only.

Thanks,
Jason

>
>         if (!sock_flag(sk, SOCK_DEAD))
>                 sk->sk_state_change(sk);
>
> (2) Correspondingly, AFAICT the tcp_poll() call to smp_rmb() should be
> before tcp_poll() first reads sk->sk_shutdown, rather than right
> before it reads sk->sk_err?
>
> thanks,
> neal
>

