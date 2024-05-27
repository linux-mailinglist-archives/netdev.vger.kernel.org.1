Return-Path: <netdev+bounces-98186-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 662018D006E
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 14:50:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89BD71C222C2
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 12:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60B615E5C8;
	Mon, 27 May 2024 12:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mCI2GK0w"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C7215E5C4
	for <netdev@vger.kernel.org>; Mon, 27 May 2024 12:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716814245; cv=none; b=pvNka7+ipz8096AKRIrzTfbO42ayGCwznEhx514kBdU2q1xioiaxkpQEk+2Z73XPa2sDDt9jGL3J8LCB49Kk3MlxCwaF6pWtruR0a0hpD7PRMBTZSiCDbTRM71fKwmqT7grqaqtlvXPSxe34BZRvV2qUDzS7XRotpERYzwg3o10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716814245; c=relaxed/simple;
	bh=vIMNeX9GKFvbyS4rTW4bLJO5HoE5A/V6ecUXqz77XTg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QjaqS9YAia/Vsbd9LsbTdhE4hRwQmsgJTKa89A5P3RBvYwXqt4n7P+LURBg8e8iV/Rk8G7bbpNiubFPDqYxI8vtO30ed2sZNZsREty7JR8OhmQLE+vkLhDEb5J4XmSFicIrxn5W1NtPH8AWAqnm/1W7Gh2WwvJ5nb0TC//RNhZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mCI2GK0w; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a5dcb5a0db4so1074556466b.2
        for <netdev@vger.kernel.org>; Mon, 27 May 2024 05:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716814242; x=1717419042; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DFEFo3GrC1jzPN7J07FVdwJDcVI8JBxo+Phwdhu9yYk=;
        b=mCI2GK0wpnKj4f0Pu4GjnUFm34yA9FWVHLFvs9M43TzopjFggpjXltmqwLE2UOmk1i
         +/NkM2ORzE2tC6udzRZsO7ly+KqM/HC/X4kkUk2hyFaptHfpPRGDGDIKMaxijZpnK7rt
         jSdoT0fHkQRPkc4vVGaTUCNQPMYy8t/prEWY6zriRoG/Zl/cyqwbBrCUb63ByKquhcJ/
         QfgNZfcYwtXHxAslhsZKseRq3tbo+XDajBb8Nol0jZUGrJwJyEt2HMQm2G8MzK7a+sXU
         Ut2CFZUfgBJp+0tTeXUUNipmDbrCQpHwtWerSSSDrWaunWmgBEmvkusVFw7WyimdJZsm
         hWSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716814242; x=1717419042;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DFEFo3GrC1jzPN7J07FVdwJDcVI8JBxo+Phwdhu9yYk=;
        b=Q3JwdOnFuWXaDlAIUxR8EaXZuCqKACOcB4NHr1L+rO6wiuk3aFdVzQRbh5LD1f7v0P
         4KN+s2nRujgThmcyoBX4ZIpskp414vEQa+qklBJ+20HuhWYdkOs8ef6KJegzr/mhcJNI
         +h2ok2sp3zPEg11RdWMpE+JqN4jqN2posRUeZel4TvocrMoHWg5/Zb8kd4g0dqYDvtcP
         AsKjF90ns5BvjZX7uvmCXPQpCcq8j4rzT+wigTzGSxrBD67tf2fDxWKXTwkFtHv0jbfs
         uSD2SL3BEw9EaSuaSIxhPcxow4i1a2ljCW9pkO2DFrnfjgeililo9O+XsJSBBoqYSTtr
         MLNA==
X-Forwarded-Encrypted: i=1; AJvYcCWj2Yst3HnBTPqJpHTocSVAs2RiQGcfqaNFsAWnEd9fnx9y2DGKaVfirfRtzepWc7HwCDatJwJ+gWP7Sh8WAlShYXZjGt3s
X-Gm-Message-State: AOJu0YzQ0tc+gEb6SjTA8I+1172B4MZM/wAjnn9Dr5ttMiuq/zEQe0eE
	evY47OeqYXQSYb0W4uI6UWXqH//EOBisTniw/8hhvK4pRhYLl/XhdKofy4zLN3NixLwO6LEs4Dg
	NHblIKuEQaqmFSCaAUZBXT9mdQk4=
X-Google-Smtp-Source: AGHT+IH7JZVkLaY4LSELkGX0lEEz4bZ+5smrFkM3hN2TOky0izW8uLX+ncdU8VVmMKIVyZPL+lZd0mh8qNPLNhpyUcw=
X-Received: by 2002:a17:906:c110:b0:a62:c500:50ba with SMTP id
 a640c23a62f3a-a62c5005179mr410270866b.75.1716814241886; Mon, 27 May 2024
 05:50:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240524193630.2007563-1-edumazet@google.com> <20240524193630.2007563-2-edumazet@google.com>
 <CADVnQyk6CkWU-mETm9yM65Me91aVRr5ngXi2hkD6aETakB+c2w@mail.gmail.com>
 <CAL+tcoDq5G_KU3jJ2=kedHz9OvmLRD5sKf_KLrw3mg-yKrhtkw@mail.gmail.com> <CANn89iL_OL4RpLdg7GwWJt0jgMaW0jCHUKEHjxpydf-Dx2Zzcw@mail.gmail.com>
In-Reply-To: <CANn89iL_OL4RpLdg7GwWJt0jgMaW0jCHUKEHjxpydf-Dx2Zzcw@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 27 May 2024 20:50:05 +0800
Message-ID: <CAL+tcoAo3vW0mTJkxKfTYa=EJgiE1Qr=4GDCqtDPd5FCQAr1QA@mail.gmail.com>
Subject: Re: [PATCH net 1/4] tcp: add tcp_done_with_error() helper
To: Eric Dumazet <edumazet@google.com>
Cc: Neal Cardwell <ncardwell@google.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 27, 2024 at 4:56=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Mon, May 27, 2024 at 10:07=E2=80=AFAM Jason Xing <kerneljasonxing@gmai=
l.com> wrote:
> >
> > Hi Neal,
> >
> > On Sat, May 25, 2024 at 10:14=E2=80=AFPM Neal Cardwell <ncardwell@googl=
e.com> wrote:
> > >
> > > On Fri, May 24, 2024 at 3:36=E2=80=AFPM Eric Dumazet <edumazet@google=
.com> wrote:
> > > >
> > > > tcp_reset() ends with a sequence that is carefuly ordered.
> > > >
> > > > We need to fix [e]poll bugs in the following patches,
> > > > it makes sense to use a common helper.
> > > >
> > > > Suggested-by: Neal Cardwell <ncardwell@google.com>
> > > > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > > > ---
> > > >  include/net/tcp.h    |  1 +
> > > >  net/ipv4/tcp.c       |  2 +-
> > > >  net/ipv4/tcp_input.c | 25 +++++++++++++++++--------
> > > >  3 files changed, 19 insertions(+), 9 deletions(-)
> > > >
> > > > diff --git a/include/net/tcp.h b/include/net/tcp.h
> > > > index 060e95b331a286ad7c355be11dc03250d2944920..2e7150f6755a5f5bf7b=
45454da0b33c5fac78183 100644
> > > > --- a/include/net/tcp.h
> > > > +++ b/include/net/tcp.h
> > > > @@ -677,6 +677,7 @@ void tcp_skb_collapse_tstamp(struct sk_buff *sk=
b,
> > > >  /* tcp_input.c */
> > > >  void tcp_rearm_rto(struct sock *sk);
> > > >  void tcp_synack_rtt_meas(struct sock *sk, struct request_sock *req=
);
> > > > +void tcp_done_with_error(struct sock *sk);
> > > >  void tcp_reset(struct sock *sk, struct sk_buff *skb);
> > > >  void tcp_fin(struct sock *sk);
> > > >  void tcp_check_space(struct sock *sk);
> > > > diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> > > > index 681b54e1f3a64387787738ab6495531b8abe1771..2a8f8d8676ff1d30ea9=
f8cd47ccf9236940eb299 100644
> > > > --- a/net/ipv4/tcp.c
> > > > +++ b/net/ipv4/tcp.c
> > > > @@ -598,7 +598,7 @@ __poll_t tcp_poll(struct file *file, struct soc=
ket *sock, poll_table *wait)
> > > >                  */
> > > >                 mask |=3D EPOLLOUT | EPOLLWRNORM;
> > > >         }
> > > > -       /* This barrier is coupled with smp_wmb() in tcp_reset() */
> > > > +       /* This barrier is coupled with smp_wmb() in tcp_done_with_=
error() */
> > > >         smp_rmb();
> > > >         if (READ_ONCE(sk->sk_err) ||
> > > >             !skb_queue_empty_lockless(&sk->sk_error_queue))
> > > > diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> > > > index 9c04a9c8be9dfaa0ec2437b3748284e57588b216..5af716f1bc74e095d22=
f64d605624decfe27cefe 100644
> > > > --- a/net/ipv4/tcp_input.c
> > > > +++ b/net/ipv4/tcp_input.c
> > > > @@ -4436,6 +4436,22 @@ static enum skb_drop_reason tcp_sequence(con=
st struct tcp_sock *tp,
> > > >         return SKB_NOT_DROPPED_YET;
> > > >  }
> > > >
> > > > +
> > > > +void tcp_done_with_error(struct sock *sk)
> > > > +{
> > > > +       /* Our caller wrote a value into sk->sk_err.
> > > > +        * This barrier is coupled with smp_rmb() in tcp_poll()
> > > > +        */
> > > > +       smp_wmb();
> > > > +
> > > > +       tcp_write_queue_purge(sk);
> > > > +       tcp_done(sk);
> > > > +
> > > > +       if (!sock_flag(sk, SOCK_DEAD))
> > > > +               sk_error_report(sk);
> > > > +}
> > > > +EXPORT_SYMBOL(tcp_done_with_error);
> > > > +
> > > >  /* When we get a reset we do this. */
> > > >  void tcp_reset(struct sock *sk, struct sk_buff *skb)
> > > >  {
> > > > @@ -4460,14 +4476,7 @@ void tcp_reset(struct sock *sk, struct sk_bu=
ff *skb)
> > > >         default:
> > > >                 WRITE_ONCE(sk->sk_err, ECONNRESET);
> > > >         }
> > > > -       /* This barrier is coupled with smp_rmb() in tcp_poll() */
> > > > -       smp_wmb();
> > > > -
> > > > -       tcp_write_queue_purge(sk);
> > > > -       tcp_done(sk);
> > > > -
> > > > -       if (!sock_flag(sk, SOCK_DEAD))
> > > > -               sk_error_report(sk);
> > > > +       tcp_done_with_error(sk);
> > > >  }
> > > >
> > > >  /*
> > > > --
> > >
> > > Thanks, Eric!
> > >
> > > Thinking about this more, I wonder if there is another aspect to this=
 issue.
> > >
> > > I am thinking about this part of tcp_done():
> > >
> > > void tcp_done(struct sock *sk)
> > > {
> > > ...
> > >         sk->sk_shutdown =3D SHUTDOWN_MASK;
> > >
> > >         if (!sock_flag(sk, SOCK_DEAD))
> > >                 sk->sk_state_change(sk);
> > >
> > > The tcp_poll() code reads sk->sk_shutdown to decide whether to set
> > > EPOLLHUP and other bits. However, sk->sk_shutdown is not set until
> > > here in tcp_done(). And in the tcp_done() code there is no smp_wmb()
> > > to ensure that the sk->sk_shutdown is visible to other CPUs before
> > > tcp_done() calls sk->sk_state_change() to wake up threads sleeping on
> > > sk->sk_wq.
> > >
> > > So AFAICT we could have cases where this sk->sk_state_change() (or th=
e
> > > later sk_error_report()?) wakes a thread doing a tcp_poll() on anothe=
r
> > > CPU, and the tcp_poll() code may correctly see the sk->sk_err because
> > > it was updated before the smp_wmb() in tcp_done_with_error(), but may
> > > fail to see the "sk->sk_shutdown =3D SHUTDOWN_MASK" write because tha=
t
> > > happened after the smp_wmb() in tcp_done_with_error().
> >
> > I agree. Accessing sk_shutdown with a pair of smp operations makes
> > sure that another cpu can see the consistency of both sk_shutdown and
> > sk_err in tcp_poll().
> >
> > >
> > > So AFAICT  maybe we need two changes?
> > >
> > > (1) AFAICT the call to smp_wmb() should actually instead be inside
> > > tcp_done(), after we set sk->sk_shutdown?
> > >
> > > void tcp_done(struct sock *sk)
> > > {
> > >         ...
> > >         sk->sk_shutdown =3D SHUTDOWN_MASK;
> > >
> > >         /* Ensure previous writes to sk->sk_err, sk->sk_state,
> > >          * sk->sk_shutdown are visible to others.
> > >          * This barrier is coupled with smp_rmb() in tcp_poll()
> > >          */
> > >         smp_wmb();
> >
> > I wonder if it would affect those callers who have no interest in
> > pairing smp operations, like tcp_v4_syn_recv_sock()? For those
> > callers, WRITE_ONCE/READ_ONCE() is enough to protect itself only.
>
> WRITE_ONCE()/READ_ONCE() and smp_rmb()/smp_wmb() have different purposes.
>
> smp_rmb()/smp_wmb() are order of magnitude more expensive than
> WRITE_ONCE()/READ_ONCE()
>
> You should use them only when absolutely needed.

Sure, I know them. What I was trying to say is putting a smp_wmb()
into tcp_done() is not appropriate because other callers don't want
this expansive protection for sk_shutdown which can be protected with
WRITE/READ_ONCE.

Thanks,
Jason

