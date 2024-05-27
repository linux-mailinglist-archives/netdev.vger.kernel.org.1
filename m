Return-Path: <netdev+bounces-98151-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B0B08CFC3F
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 10:56:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D6011C21823
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 08:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 096F969953;
	Mon, 27 May 2024 08:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ta3mN27P"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CFB44C68
	for <netdev@vger.kernel.org>; Mon, 27 May 2024 08:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716800186; cv=none; b=cqJq609weem22lM0VVKwktrH+nuR1894iOxnMUTgZMNZhpk0ZhUTGsTQOos5vZQCxV3vrGnwukTbJTcxPvyaIvEkeou3w3KbwsF6OjdyyuU3NwXJ+aEgxcnCK0pwZ9WQK8KdHR1UnvgECp41pXqyRDNoN79zMcjmuy2R0vhDIjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716800186; c=relaxed/simple;
	bh=CQ4dVtJiEqmi1AtZ9jRpPIaUmF2zzpX8vKDkr0nxPwk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I9tuprQp7B4VmGd/OjP1pTPCc3XQMoHQkXjNq+F1DnlGZ0x9foetWAr5obERbZngLk9FZfe0QVXM3hRbeMaqi7JDxBaodZJk2ZtCYgesFn1KFCFJjwIAHIHiMU29TYbzm0KWvpuARH02jDl0WMuoqpoO7M8JGaper1VWDFspJ1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ta3mN27P; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5750a8737e5so13256a12.0
        for <netdev@vger.kernel.org>; Mon, 27 May 2024 01:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716800183; x=1717404983; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=laaN59m1dCaBjkd8cuIwRQ2bvmrHIxVQwGOs4NuJ++g=;
        b=Ta3mN27PY2gZlxREoscDlWjYz6BYyax2SBg5Ckp5eyfhNv7uAW8VnEz8W6r0azHBDO
         b2Qe78P6K4GJfQKlaiQpTNcPpigf8pLKScrbtQPrvI2hpNOD02ng7iOVXIESFL/ClPf9
         HXUVcs0dZ4ojnlkXZmKAsPeccyAgsRm4smXpT0eLtjVvDrzexpe8AsRK5skn88pBHtpR
         iMn1xaJXi83MOpUjOLrzdJJTMdrYmyRMWNaxBGAyfTu1qopUhdzoZLohf+Vbs1GcQ511
         xLkjmp1Q82NAGqL5oX/HCb0HTUArcFiLC6BCEYmH1XeSu+QkApQ4MNYdJaPRIruXKlcb
         viqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716800183; x=1717404983;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=laaN59m1dCaBjkd8cuIwRQ2bvmrHIxVQwGOs4NuJ++g=;
        b=s89TrEosIBAF2DxrK9nLLissdMAc3ujfLF1qo7aV0k3G1nel3ah1jLOqrCRLxNe2Ik
         rwRvChH2NRgm5ctXhu3TjSJVcILkcfQ0hFSVq64BlIOPowPMzCD6ifkFaUvGUidDnOVW
         wb4b/uK+zFtHAYQc6DKkXitV9HLlkTFuRql1dcePkzfyn+C7gFiTzi/QimipV3mcSbH2
         jHjcDNAO7uYenmETIYzxcnL2ufTBWWYf3QyCYcGpEQQOjEGmv1/U5Q+wjDlQ3BzRDFh1
         lhjlw03ldmq82GzWVLTPHTwoy5w782Qg+fNIyUMrQCERtBpEJ6dbWtOOeNxB4nSJYxrt
         nAlA==
X-Forwarded-Encrypted: i=1; AJvYcCXrfCnyDIR4j9Zic6GiPPKpnXpvZTCW6jkyal5UU0lrh/MF4Icq0vMET9gGzLDzM4g8yNxdJW5CzEj+2JVZD3WH6HesYa2B
X-Gm-Message-State: AOJu0YxwEZ53fhbn3l3bXTd4TL0buzKnP3mqW/uNrEotOlQ964XgLWY9
	4wCDGrol9GsPFTbbQ3+Vj/YiiNfFLUS/4O08gpFOl39DokgjQN4UZm7sQAk0qMrZE1tH0/LxBDQ
	T7faa8LprusrWud1PYzvUXARCMJdmRcBqPKgg
X-Google-Smtp-Source: AGHT+IEnfD+XusTMBMOjMzMuy11H8H9KGKpXjHeJcLLB7kxvsvzpb0EVB2mneRYROtJoRTgnGSR4A6M1nDL1hSpehLs=
X-Received: by 2002:a05:6402:1803:b0:574:e7e1:35bf with SMTP id
 4fb4d7f45d1cf-57869bd661cmr178977a12.7.1716800183125; Mon, 27 May 2024
 01:56:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240524193630.2007563-1-edumazet@google.com> <20240524193630.2007563-2-edumazet@google.com>
 <CADVnQyk6CkWU-mETm9yM65Me91aVRr5ngXi2hkD6aETakB+c2w@mail.gmail.com> <CAL+tcoDq5G_KU3jJ2=kedHz9OvmLRD5sKf_KLrw3mg-yKrhtkw@mail.gmail.com>
In-Reply-To: <CAL+tcoDq5G_KU3jJ2=kedHz9OvmLRD5sKf_KLrw3mg-yKrhtkw@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 27 May 2024 10:56:12 +0200
Message-ID: <CANn89iL_OL4RpLdg7GwWJt0jgMaW0jCHUKEHjxpydf-Dx2Zzcw@mail.gmail.com>
Subject: Re: [PATCH net 1/4] tcp: add tcp_done_with_error() helper
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: Neal Cardwell <ncardwell@google.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 27, 2024 at 10:07=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.=
com> wrote:
>
> Hi Neal,
>
> On Sat, May 25, 2024 at 10:14=E2=80=AFPM Neal Cardwell <ncardwell@google.=
com> wrote:
> >
> > On Fri, May 24, 2024 at 3:36=E2=80=AFPM Eric Dumazet <edumazet@google.c=
om> wrote:
> > >
> > > tcp_reset() ends with a sequence that is carefuly ordered.
> > >
> > > We need to fix [e]poll bugs in the following patches,
> > > it makes sense to use a common helper.
> > >
> > > Suggested-by: Neal Cardwell <ncardwell@google.com>
> > > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > > ---
> > >  include/net/tcp.h    |  1 +
> > >  net/ipv4/tcp.c       |  2 +-
> > >  net/ipv4/tcp_input.c | 25 +++++++++++++++++--------
> > >  3 files changed, 19 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/include/net/tcp.h b/include/net/tcp.h
> > > index 060e95b331a286ad7c355be11dc03250d2944920..2e7150f6755a5f5bf7b45=
454da0b33c5fac78183 100644
> > > --- a/include/net/tcp.h
> > > +++ b/include/net/tcp.h
> > > @@ -677,6 +677,7 @@ void tcp_skb_collapse_tstamp(struct sk_buff *skb,
> > >  /* tcp_input.c */
> > >  void tcp_rearm_rto(struct sock *sk);
> > >  void tcp_synack_rtt_meas(struct sock *sk, struct request_sock *req);
> > > +void tcp_done_with_error(struct sock *sk);
> > >  void tcp_reset(struct sock *sk, struct sk_buff *skb);
> > >  void tcp_fin(struct sock *sk);
> > >  void tcp_check_space(struct sock *sk);
> > > diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> > > index 681b54e1f3a64387787738ab6495531b8abe1771..2a8f8d8676ff1d30ea9f8=
cd47ccf9236940eb299 100644
> > > --- a/net/ipv4/tcp.c
> > > +++ b/net/ipv4/tcp.c
> > > @@ -598,7 +598,7 @@ __poll_t tcp_poll(struct file *file, struct socke=
t *sock, poll_table *wait)
> > >                  */
> > >                 mask |=3D EPOLLOUT | EPOLLWRNORM;
> > >         }
> > > -       /* This barrier is coupled with smp_wmb() in tcp_reset() */
> > > +       /* This barrier is coupled with smp_wmb() in tcp_done_with_er=
ror() */
> > >         smp_rmb();
> > >         if (READ_ONCE(sk->sk_err) ||
> > >             !skb_queue_empty_lockless(&sk->sk_error_queue))
> > > diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> > > index 9c04a9c8be9dfaa0ec2437b3748284e57588b216..5af716f1bc74e095d22f6=
4d605624decfe27cefe 100644
> > > --- a/net/ipv4/tcp_input.c
> > > +++ b/net/ipv4/tcp_input.c
> > > @@ -4436,6 +4436,22 @@ static enum skb_drop_reason tcp_sequence(const=
 struct tcp_sock *tp,
> > >         return SKB_NOT_DROPPED_YET;
> > >  }
> > >
> > > +
> > > +void tcp_done_with_error(struct sock *sk)
> > > +{
> > > +       /* Our caller wrote a value into sk->sk_err.
> > > +        * This barrier is coupled with smp_rmb() in tcp_poll()
> > > +        */
> > > +       smp_wmb();
> > > +
> > > +       tcp_write_queue_purge(sk);
> > > +       tcp_done(sk);
> > > +
> > > +       if (!sock_flag(sk, SOCK_DEAD))
> > > +               sk_error_report(sk);
> > > +}
> > > +EXPORT_SYMBOL(tcp_done_with_error);
> > > +
> > >  /* When we get a reset we do this. */
> > >  void tcp_reset(struct sock *sk, struct sk_buff *skb)
> > >  {
> > > @@ -4460,14 +4476,7 @@ void tcp_reset(struct sock *sk, struct sk_buff=
 *skb)
> > >         default:
> > >                 WRITE_ONCE(sk->sk_err, ECONNRESET);
> > >         }
> > > -       /* This barrier is coupled with smp_rmb() in tcp_poll() */
> > > -       smp_wmb();
> > > -
> > > -       tcp_write_queue_purge(sk);
> > > -       tcp_done(sk);
> > > -
> > > -       if (!sock_flag(sk, SOCK_DEAD))
> > > -               sk_error_report(sk);
> > > +       tcp_done_with_error(sk);
> > >  }
> > >
> > >  /*
> > > --
> >
> > Thanks, Eric!
> >
> > Thinking about this more, I wonder if there is another aspect to this i=
ssue.
> >
> > I am thinking about this part of tcp_done():
> >
> > void tcp_done(struct sock *sk)
> > {
> > ...
> >         sk->sk_shutdown =3D SHUTDOWN_MASK;
> >
> >         if (!sock_flag(sk, SOCK_DEAD))
> >                 sk->sk_state_change(sk);
> >
> > The tcp_poll() code reads sk->sk_shutdown to decide whether to set
> > EPOLLHUP and other bits. However, sk->sk_shutdown is not set until
> > here in tcp_done(). And in the tcp_done() code there is no smp_wmb()
> > to ensure that the sk->sk_shutdown is visible to other CPUs before
> > tcp_done() calls sk->sk_state_change() to wake up threads sleeping on
> > sk->sk_wq.
> >
> > So AFAICT we could have cases where this sk->sk_state_change() (or the
> > later sk_error_report()?) wakes a thread doing a tcp_poll() on another
> > CPU, and the tcp_poll() code may correctly see the sk->sk_err because
> > it was updated before the smp_wmb() in tcp_done_with_error(), but may
> > fail to see the "sk->sk_shutdown =3D SHUTDOWN_MASK" write because that
> > happened after the smp_wmb() in tcp_done_with_error().
>
> I agree. Accessing sk_shutdown with a pair of smp operations makes
> sure that another cpu can see the consistency of both sk_shutdown and
> sk_err in tcp_poll().
>
> >
> > So AFAICT  maybe we need two changes?
> >
> > (1) AFAICT the call to smp_wmb() should actually instead be inside
> > tcp_done(), after we set sk->sk_shutdown?
> >
> > void tcp_done(struct sock *sk)
> > {
> >         ...
> >         sk->sk_shutdown =3D SHUTDOWN_MASK;
> >
> >         /* Ensure previous writes to sk->sk_err, sk->sk_state,
> >          * sk->sk_shutdown are visible to others.
> >          * This barrier is coupled with smp_rmb() in tcp_poll()
> >          */
> >         smp_wmb();
>
> I wonder if it would affect those callers who have no interest in
> pairing smp operations, like tcp_v4_syn_recv_sock()? For those
> callers, WRITE_ONCE/READ_ONCE() is enough to protect itself only.

WRITE_ONCE()/READ_ONCE() and smp_rmb()/smp_wmb() have different purposes.

smp_rmb()/smp_wmb() are order of magnitude more expensive than
WRITE_ONCE()/READ_ONCE()

You should use them only when absolutely needed.

