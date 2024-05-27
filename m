Return-Path: <netdev+bounces-98150-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 919F48CFC39
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 10:53:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48D1028113D
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 08:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5932260B96;
	Mon, 27 May 2024 08:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K/C75Flh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682E860DCF
	for <netdev@vger.kernel.org>; Mon, 27 May 2024 08:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716800025; cv=none; b=BsIbqRAisostxMA+gtn/M+or2u46eiCzedQy1xJU/kpT5a05FTAjAbZN653foncFDIvDg9+7UMr5BD7dtO/gYrn2j6X5hHEsk5p/nf6diyhCM0Y7mc5Xi2pfhTVx4G19sUVyqMOvxABM1jSnP0xY/iXXM0mTTW6fbwnj28emCZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716800025; c=relaxed/simple;
	bh=VEClKjd9QLAp6gAUj8CuiUt1cmavAiYfHqWKBAGa2Us=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lje0iFj15Tlibukaw9ayUcPd4Fr0GYx2Ob4O3s3i3wJeYqgcqfRcqeTX0BcQlDLZLwCJbKJ9i8G6MgeCyZL257jPksn/h92VmrLd1j1hvD9jSa1KP/Nnc0vGXPPKrr/2pOOJgHR6ZmdH727p1onjKUM4tzZjx5Hy5CeNHQpC6Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K/C75Flh; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-41ff3a5af40so64855e9.1
        for <netdev@vger.kernel.org>; Mon, 27 May 2024 01:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716800022; x=1717404822; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O1WX9sXaPJC9C/ZWSsW0qb4NKG8vOFx8VEZWQAK2qFg=;
        b=K/C75FlhUxUIj7EqMv9b3M40ITxT+RR5ano9T1LlgqIfHIuixUHwsBJcus5gouylfi
         3b0J5cM8McgGHN0iA1gmBCAR7rCrj4ejr1Dol6ANjpH+CBEg9pZHcKmbc+lhHPtLL3H+
         f2394dqXb914DrIiq19Ht0syuPci52WOOYlQL/AcrG/gwz066aYTco2HHgPTO2Asn4wx
         YV4u/clcg+B018mfdhImRM5ln2YM9nwdugLwax47jlcErf7ON2++X4hB6DdWewhLa69w
         mQCuHWY3Juno7KAagKozs5VfvK8edyLYjkVsI8u0FGT3kgMM6pu6/N779VeAtJko5MkB
         YJ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716800022; x=1717404822;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O1WX9sXaPJC9C/ZWSsW0qb4NKG8vOFx8VEZWQAK2qFg=;
        b=b9xv/B6IhVIEX7EWuk9/3snZW8Qh6sBkdLyAuVsargkty3Gt4vOJ9x/GjF86RThFUO
         vuEOvDd9gzmB7yGfxJ4h15OOdMIlDrnJNjwVZaW5jv0Hd40uLU7xTtr9+uOCehm3uKcu
         QPlqgmDOK2huETDIbtRzBVRRLR8XvbiHVhETBjsuSM4dRUAAwfKH7tWlj8Csfb7lPdVu
         rQIRaNNQ0NiLg6eafdSTk1RTHcg+NMhrDRV4iYZIWgKifTFNX4W/NSFYa5wd1T5kjjr7
         cWPP1HnFKuSTB+W4ZTDRZfBWLoljt20gdn11NIh5dAVfJIXcKSrTSo0f3fws8a6IcO05
         Fb7w==
X-Forwarded-Encrypted: i=1; AJvYcCWJw8ykULr5pmhKXFRQhypyrtS82b9SD6Yyb6yqrJ1S3IxT7s4YUVIpHUqzwomU6I63qtJ4L/90ALtwZl4q6QMpnNY7szrt
X-Gm-Message-State: AOJu0Yyf/4Ycc8x35sIVEUep4/dq9A3bKVos/pX/G9LyJL9AaCP6CGV1
	/JLYYFBjXbemWGcByVtOlbWedXz/Yj3X5nHpANdbCH1cI/twO+3S48yO/Dm6BXl/nAowa9WRj1g
	sQh9Usg4T6+gXoFbuzrsh8kOFKjxRX7ikT4JW
X-Google-Smtp-Source: AGHT+IF1EIVKt2f/Wz2K1yRDH6zsDKu3FWO6ie0DXJOyZ+GPAvufdEbmlKsOiANfLOKUpASSLfUxXpuZzATCJkvB2PM=
X-Received: by 2002:a05:600c:474e:b0:41b:e416:1073 with SMTP id
 5b1f17b1804b1-4210d905e40mr2994115e9.0.1716800021290; Mon, 27 May 2024
 01:53:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240524193630.2007563-1-edumazet@google.com> <20240524193630.2007563-2-edumazet@google.com>
 <CADVnQyk6CkWU-mETm9yM65Me91aVRr5ngXi2hkD6aETakB+c2w@mail.gmail.com>
In-Reply-To: <CADVnQyk6CkWU-mETm9yM65Me91aVRr5ngXi2hkD6aETakB+c2w@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 27 May 2024 10:53:26 +0200
Message-ID: <CANn89i+ZMf8-9989owQSmk_LM7BJavdg7eApJ1nTG6pGwvLFHA@mail.gmail.com>
Subject: Re: [PATCH net 1/4] tcp: add tcp_done_with_error() helper
To: Neal Cardwell <ncardwell@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 25, 2024 at 4:14=E2=80=AFPM Neal Cardwell <ncardwell@google.com=
> wrote:
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
>
> So AFAICT  maybe we need two changes?

This seems orthogonal, and should be discussed in a different patch series =
?
I am afraid of the additional implications of your proposal.

Applications react to EPOLLERR by getting the (termination) error
code, they don't really _need_ EPOLLHUP at this stage to behave
correctly.

And EPOLLERR got a fix  more than a decade ago, nobody complained
there was an issue with sk_shutdown.

commit a4d258036ed9b2a1811c3670c6099203a0f284a0
Author: Tom Marshall <tdm.code@gmail.com>
Date:   Mon Sep 20 15:42:05 2010 -0700

    tcp: Fix race in tcp_poll

Notice how Tom moved sk_err read to the end of tcp_poll().
It is not possible with extra smp_wmb() and smp_wmb() alone to make
sure tcp_poll() gets a consistent view.
There are too many variables to snapshot in a consistent way.

Only packetdrill has an issue here, because it expects a precise
combination of flags.

Would you prefer to change packetdrill to accept both possible values ?

   +0 epoll_ctl(5, EPOLL_CTL_ADD, 4, {events=3DEPOLLERR, fd=3D4}) =3D 0

// This is the part that would need a change:
// something like +0...11 epoll_wait(5, {events=3DEPOLLERR [| EPOLLHUP],
fd=3D4}, 1, 15000) =3D 1   ??
  +0...11 epoll_wait(5, {events=3DEPOLLERR|EPOLLHUP, fd=3D4}, 1, 15000) =3D=
 1
// Verify keepalive behavior looks correct, given the parameters above:
// Start sending keepalive probes after 3 seconds of idle.
   +3 > . 0:0(0) ack 1
// Send keepalive probes every 2 seconds.
   +2 > . 0:0(0) ack 1
   +2 > . 0:0(0) ack 1
   +2 > . 0:0(0) ack 1
   +2 > R. 1:1(0) ack 1
// Sent 4 keepalive probes and then gave up and reset the connection.
// Verify that we get the expected error when we try to use the socket:
   +0 read(4, ..., 1000) =3D -1 ETIMEDOUT (Connection timed out)

In 100 runs, I get 1 flake only (but I probably could get more if I
added an ndelay(1000) before tcp_done() in unpatched kernel)
keepalive-with-ts.pkt:44: runtime error in epoll_wait call:
epoll_event->events does not match script: expected: 0x18 actual: 0x8


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

Not adding an smp_wmb() _right_ after the write to sk_err
might bring back the race that Tom wanted to fix in 2010.

(This was a poll() system call, not a callback initiated from TCP
stack itself with sk_error_report(), this one does not need barriers,
because sock_def_error_report() implies a lot of barriers before the
user thread can call tcp_poll())




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

