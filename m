Return-Path: <netdev+bounces-98476-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E038D18C9
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 12:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE9BE1C22C2C
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 10:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7422816B72D;
	Tue, 28 May 2024 10:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dWSMTsq9"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B1F139D11
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 10:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716892912; cv=none; b=MD3yI31GgiZXsxZ06LubNmPhP4oQMj7eCeZkIYGI7q/qku3aYnAUvkrfIXxZBF/AnXlM9b+4dWX4lBMZi2WUpZpSyj2ejYstSz7Ku1ypRmtGDv3BLlIayJWvbHPEBWkm5gDBfDZvDLLHdKdQPsFomynJF7NeNYpHtidBVTt5NB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716892912; c=relaxed/simple;
	bh=/Vs5q8Xl81BPOxg3w1S02hFvfrXJ1Z0npFuBhOj22DU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QS5nb7nOuVFPJdgbiiYX2O/2bkRg1eJq+1TpVjeKm+p/E+vB/Umcmjou7AC+pDHNwVhjQPLoMxu2i6lKit+8R6CdzMqZN2zcuLMNqC3gX9G/UuqdBI615ER3hbBn5vHyCdwU1mXkOcAw5ytZbrln3NhCz7da/jOpwK7gY3gonOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dWSMTsq9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716892909;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Se/EfveClNpkgo9XNUbzVkLTzPX5BWuXjDkZ3fbJQ6k=;
	b=dWSMTsq9iIVRAh0QAeEEUJeWTo2e6cZLTRgMgixtO/i4L+bo+GTzmDXVQBsS4Y4lUnOMA5
	m1s0To1ZoMC2jZW9LkJjYkJLUskviDOmDfoja4LXR4VWWyY2IGrM2oVvfsvd3Pkj6SKS/9
	XEaScfaNGFSi9XidVgrbvmdhwgjEJ3A=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-5VETSFlNMBS5YHpFj9gLiQ-1; Tue, 28 May 2024 06:41:47 -0400
X-MC-Unique: 5VETSFlNMBS5YHpFj9gLiQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-421110ba697so726185e9.0
        for <netdev@vger.kernel.org>; Tue, 28 May 2024 03:41:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716892907; x=1717497707;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Se/EfveClNpkgo9XNUbzVkLTzPX5BWuXjDkZ3fbJQ6k=;
        b=qeGXOUPz5OsSFcx5vO1X+CprkldDQzHdW4/ePrLMKhiG2feWfub3v3AXs7cqcx/qy3
         m6/thQvq7fySq7goX2m+sNeQL20qumdDEjHyfzr+44DfkKFg9OjL59Fk0QITG/ie624S
         Xb1hWYu0Y8mkD0i+0V3D2jqmzHOFLMJdUmmqg7d5gF6rUmH9+YQCarKRxXucGnWjbcLL
         NzB6OQ7FUH1LCYWSXE4edrevcCw9q4sY0ejoqFRTwZVoZGbpWpQRtBYgFbfCDA6nd6sl
         IPqTU0g7Bd71WBKpKHY0V8u9TGb3ALIoFQ8U0JraqSk006HbUSj0hrpQqs8to6/JDwtR
         YDhg==
X-Forwarded-Encrypted: i=1; AJvYcCWWy9QVXbQ9tSWM6i+ltdYEW+JaxyMyPfN0Km/jOduHepvy6zVFvM409sKhv/WWi58fs/SQucdOOaeLSpeq2r5/Ji0KgVbu
X-Gm-Message-State: AOJu0YzpxTHVXo48g8WzXzdo+NugPxT1qzmCB05JG/8Ene5pWBu7oZQD
	zBFvlwGgzIfx8M89b4bU1i3Lam3hh3fW+/Br/HbMIn0yzCg+d1+5GzuT7rtUQAp7cAKu1SCvK/a
	G3i94YlrSfZGkbXzkhXW4GkuIHJhwmccOd98n6ROyrKKLnjWhGADazQ==
X-Received: by 2002:a05:600c:1c1a:b0:41a:c04a:8021 with SMTP id 5b1f17b1804b1-421089a0b0fmr88602505e9.0.1716892906731;
        Tue, 28 May 2024 03:41:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHN4eAbLntYNN8KVW2p+oytW+9nDwcaBh4tJAZy7o48UGM18hdxekfkmaPJaQP5ReUePfDgEQ==
X-Received: by 2002:a05:600c:1c1a:b0:41a:c04a:8021 with SMTP id 5b1f17b1804b1-421089a0b0fmr88602305e9.0.1716892905986;
        Tue, 28 May 2024 03:41:45 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3341:b094:ab10:29ae:cdc:4db4:a22a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-420fc82c43csm153206405e9.0.2024.05.28.03.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 03:41:45 -0700 (PDT)
Message-ID: <cace7de5c60b1bc963326524b986c720369b0f1d.camel@redhat.com>
Subject: Re: [PATCH net 1/4] tcp: add tcp_done_with_error() helper
From: Paolo Abeni <pabeni@redhat.com>
To: Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>,  netdev@vger.kernel.org, eric.dumazet@gmail.com
Date: Tue, 28 May 2024 12:41:44 +0200
In-Reply-To: <CANn89i+ZMf8-9989owQSmk_LM7BJavdg7eApJ1nTG6pGwvLFHA@mail.gmail.com>
References: <20240524193630.2007563-1-edumazet@google.com>
	 <20240524193630.2007563-2-edumazet@google.com>
	 <CADVnQyk6CkWU-mETm9yM65Me91aVRr5ngXi2hkD6aETakB+c2w@mail.gmail.com>
	 <CANn89i+ZMf8-9989owQSmk_LM7BJavdg7eApJ1nTG6pGwvLFHA@mail.gmail.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-05-27 at 10:53 +0200, Eric Dumazet wrote:
> On Sat, May 25, 2024 at 4:14=E2=80=AFPM Neal Cardwell <ncardwell@google.c=
om> wrote:
> >=20
> > On Fri, May 24, 2024 at 3:36=E2=80=AFPM Eric Dumazet <edumazet@google.c=
om> wrote:
> > >=20
> > > tcp_reset() ends with a sequence that is carefuly ordered.
> > >=20
> > > We need to fix [e]poll bugs in the following patches,
> > > it makes sense to use a common helper.
> > >=20
> > > Suggested-by: Neal Cardwell <ncardwell@google.com>
> > > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > > ---
> > >  include/net/tcp.h    |  1 +
> > >  net/ipv4/tcp.c       |  2 +-
> > >  net/ipv4/tcp_input.c | 25 +++++++++++++++++--------
> > >  3 files changed, 19 insertions(+), 9 deletions(-)
> > >=20
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
> > >=20
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
> > >=20
> > >  /*
> > > --
> >=20
> > Thanks, Eric!
> >=20
> > Thinking about this more, I wonder if there is another aspect to this i=
ssue.
> >=20
> > I am thinking about this part of tcp_done():
> >=20
> > void tcp_done(struct sock *sk)
> > {
> > ...
> >         sk->sk_shutdown =3D SHUTDOWN_MASK;
> >=20
> >         if (!sock_flag(sk, SOCK_DEAD))
> >                 sk->sk_state_change(sk);
> >=20
> > The tcp_poll() code reads sk->sk_shutdown to decide whether to set
> > EPOLLHUP and other bits. However, sk->sk_shutdown is not set until
> > here in tcp_done(). And in the tcp_done() code there is no smp_wmb()
> > to ensure that the sk->sk_shutdown is visible to other CPUs before
> > tcp_done() calls sk->sk_state_change() to wake up threads sleeping on
> > sk->sk_wq.
> >=20
> > So AFAICT we could have cases where this sk->sk_state_change() (or the
> > later sk_error_report()?) wakes a thread doing a tcp_poll() on another
> > CPU, and the tcp_poll() code may correctly see the sk->sk_err because
> > it was updated before the smp_wmb() in tcp_done_with_error(), but may
> > fail to see the "sk->sk_shutdown =3D SHUTDOWN_MASK" write because that
> > happened after the smp_wmb() in tcp_done_with_error().
> >=20
> > So AFAICT  maybe we need two changes?
>=20
> This seems orthogonal, and should be discussed in a different patch serie=
s ?
> I am afraid of the additional implications of your proposal.
>=20
> Applications react to EPOLLERR by getting the (termination) error
> code, they don't really _need_ EPOLLHUP at this stage to behave
> correctly.
>=20
> And EPOLLERR got a fix  more than a decade ago, nobody complained
> there was an issue with sk_shutdown.
>=20
> commit a4d258036ed9b2a1811c3670c6099203a0f284a0
> Author: Tom Marshall <tdm.code@gmail.com>
> Date:   Mon Sep 20 15:42:05 2010 -0700
>=20
>     tcp: Fix race in tcp_poll
>=20
> Notice how Tom moved sk_err read to the end of tcp_poll().
> It is not possible with extra smp_wmb() and smp_wmb() alone to make
> sure tcp_poll() gets a consistent view.
> There are too many variables to snapshot in a consistent way.
>=20
> Only packetdrill has an issue here, because it expects a precise
> combination of flags.
>=20
> Would you prefer to change packetdrill to accept both possible values ?
>=20
>    +0 epoll_ctl(5, EPOLL_CTL_ADD, 4, {events=3DEPOLLERR, fd=3D4}) =3D 0
>=20
> // This is the part that would need a change:
> // something like +0...11 epoll_wait(5, {events=3DEPOLLERR [| EPOLLHUP],
> fd=3D4}, 1, 15000) =3D 1   ??
>   +0...11 epoll_wait(5, {events=3DEPOLLERR|EPOLLHUP, fd=3D4}, 1, 15000) =
=3D 1
> // Verify keepalive behavior looks correct, given the parameters above:
> // Start sending keepalive probes after 3 seconds of idle.
>    +3 > . 0:0(0) ack 1
> // Send keepalive probes every 2 seconds.
>    +2 > . 0:0(0) ack 1
>    +2 > . 0:0(0) ack 1
>    +2 > . 0:0(0) ack 1
>    +2 > R. 1:1(0) ack 1
> // Sent 4 keepalive probes and then gave up and reset the connection.
> // Verify that we get the expected error when we try to use the socket:
>    +0 read(4, ..., 1000) =3D -1 ETIMEDOUT (Connection timed out)
>=20
> In 100 runs, I get 1 flake only (but I probably could get more if I
> added an ndelay(1000) before tcp_done() in unpatched kernel)
> keepalive-with-ts.pkt:44: runtime error in epoll_wait call:
> epoll_event->events does not match script: expected: 0x18 actual: 0x8
>=20
>=20
> >=20
> > (1) AFAICT the call to smp_wmb() should actually instead be inside
> > tcp_done(), after we set sk->sk_shutdown?
> >=20
> > void tcp_done(struct sock *sk)
> > {
> >         ...
> >         sk->sk_shutdown =3D SHUTDOWN_MASK;
> >=20
> >         /* Ensure previous writes to sk->sk_err, sk->sk_state,
> >          * sk->sk_shutdown are visible to others.
> >          * This barrier is coupled with smp_rmb() in tcp_poll()
> >          */
> >         smp_wmb();
>=20
> Not adding an smp_wmb() _right_ after the write to sk_err
> might bring back the race that Tom wanted to fix in 2010.
>=20
> (This was a poll() system call, not a callback initiated from TCP
> stack itself with sk_error_report(), this one does not need barriers,
> because sock_def_error_report() implies a lot of barriers before the
> user thread can call tcp_poll())

Waiting for Neal's ack.

FTR I think the new helper introduction is worthy even just for the
consistency it brings.

IIRC there is some extra complexity in the MPTCP code to handle
correctly receiving the sk_error_report sk_state_change cb pair in both
possible orders.

Cheers,

Paolo


