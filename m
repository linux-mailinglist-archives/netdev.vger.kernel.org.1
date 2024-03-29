Return-Path: <netdev+bounces-83243-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F1FC891715
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 11:53:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC0D8B22200
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 10:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C340F4C3CD;
	Fri, 29 Mar 2024 10:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AvtvplQ5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067F617F0
	for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 10:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711709589; cv=none; b=Mzf03OcBKgbGKivhFKFyCdy/SkR7uaaZq8+NFCZC1/EfEGHKAU8SCZ711z7TjnKBXI7dtVVXJlKrZMxp2lbylYiBD1FcsA3UWIceC7rPHpXz7j4GkggHeacYxHObR4Q1MeUqCLKbLjady77lFjgmrgX8JX9LqtkNcDIwCOp1Vdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711709589; c=relaxed/simple;
	bh=VU0Yupg0yApo+kqvd4PzeY3QeyzJTraxoolhxCwVSYA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NMEbsc8WER5ZguZ+s3GLZ3iBESA7RKUyreVZeKj2OKD1J8YGvQe6WklMYBEIJS2Dcw4EIjT1iAhq86OFwsNPtXzRSfz9x5FUpZvbg7F0WCvvUP1U9CZW8/x7bLkSrrrZCpOzBwceA+c/XsTDVoq9kkVNNOS7cMGnn1TRagc1PSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AvtvplQ5; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-56c2cfdd728so6801a12.1
        for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 03:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711709586; x=1712314386; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DF0auwpM1BrmwQRQmQ55+xh3fsiwGFy8c+FiYwCotRs=;
        b=AvtvplQ5TLKbaBoVjC04LfXuPJS55mJRmBCqusCktdyj/PBH8ZW+ZunrVDTBgteWZQ
         mrKTVDwX+ib7Ic81epzRkpawi5ncdSGCct9+G1cP5F8Fg3zw/2SQVunB/INKYC/OTd/v
         KQjdxiZ4EIPP5nuQ4Yc5POIJdjZen/BvGE/9dOMI8CCnNg8j+WZKFSLnUTqs2MDlXN3h
         cL4hMdWF4pacZV6m0txSLcZn+H83Wu3+q3uy4Tkj/eF5GjYoXCmiJHk2z2YindrOWr1Q
         ipnnVNTxJn13t4m4pbp1+GKNYuIMo/Tof7D1SDQjdB650wSAHvyXGFezHxj5kEDBIBCm
         5HFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711709586; x=1712314386;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DF0auwpM1BrmwQRQmQ55+xh3fsiwGFy8c+FiYwCotRs=;
        b=sQ7rjVVaoM9NWUkfXidvpQ1Uqe2EzqXr1GrBHiMJbIH1G2jiE1KemjDJ29KnM+QkyY
         FlX197Z2OTeI2lANfdE5oPvYvOvsvM4dy749zTqivDcb4ZzF17SO7RcVlvsgvuONVPOb
         9HXe63JCk8B/jVSwB7F9uF8NZV/ca3AObjBrqxM2DqAqJFI+JWlCBHnSIpGt6bbLyh1L
         kAYBX54bBDFx/V7s1I2TsZmdT1IerDVdBTHLB6JOMEnpda0eDntOQHIpxVzcPYmicr3a
         5sQn55E99ycpdrzkmTu+sgmCRnrSjDIHIu8IV07RNAISnMPP1OF828O2p1fa5asA0Zv5
         xnEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIrTLT3u4FaDV8YOJCjHHgm2hJs4ix3YhO7h//JgNrvgClB6Tx3tkz2qUHwakwQrkIbBdwq1wqOTJPXsBkkTXvDKl/a0zN
X-Gm-Message-State: AOJu0Yw3Nut+DICduLEKWvYoNvUHqzro7C+KghPkis28u2OErC3zmOxK
	n1nxbjuVVendHjSbVciVGDG1hw/JmS9TIjXNaRhq0GHvC4EnmWMI/M1dedsdvGOd206aX51KRtH
	k1sDer/J/ckg38kaka9dcHTq8R6Ne3RZx762qs/nUxKDjpEuvwTmI
X-Google-Smtp-Source: AGHT+IH8A29at7FVotyo+IQwZzndPtEiYwxuY4TKzgUhTnF9MSgU3eynx1rhcZcxEYmTcJoP2XTT9uAOl2ncTn1y//4=
X-Received: by 2002:aa7:dc17:0:b0:56c:303b:f4d4 with SMTP id
 b23-20020aa7dc17000000b0056c303bf4d4mr90874edu.1.1711709586140; Fri, 29 Mar
 2024 03:53:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240328144032.1864988-1-edumazet@google.com> <20240328144032.1864988-4-edumazet@google.com>
 <db5a01a1256d4cc5cf418cd6cb5b076fc959ae21.camel@redhat.com>
In-Reply-To: <db5a01a1256d4cc5cf418cd6cb5b076fc959ae21.camel@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 29 Mar 2024 11:52:55 +0100
Message-ID: <CANn89iKexr_2Ept9kAmfib6p3-UcrnqhUf=TFq1Mrug6P+Kg_Q@mail.gmail.com>
Subject: Re: [PATCH net-next 3/4] udp: avoid calling sock_def_readable() if possible
To: Paolo Abeni <pabeni@redhat.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 29, 2024 at 11:22=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wr=
ote:
>
> On Thu, 2024-03-28 at 14:40 +0000, Eric Dumazet wrote:
> > sock_def_readable() is quite expensive (particularly
> > when ep_poll_callback() is in the picture).
> >
> > We must call sk->sk_data_ready() when :
> >
> > - receive queue was empty, or
> > - SO_PEEK_OFF is enabled on the socket, or
> > - sk->sk_data_ready is not sock_def_readable.
> >
> > We still need to call sk_wake_async().
> >
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > ---
> >  net/ipv4/udp.c | 14 +++++++++++---
> >  1 file changed, 11 insertions(+), 3 deletions(-)
> >
> > diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> > index d2fa9755727ce034c2b4bca82bd9e72130d588e6..5dfbe4499c0f89f94af9ee1=
fb64559dd672c1439 100644
> > --- a/net/ipv4/udp.c
> > +++ b/net/ipv4/udp.c
> > @@ -1492,6 +1492,7 @@ int __udp_enqueue_schedule_skb(struct sock *sk, s=
truct sk_buff *skb)
> >       struct sk_buff_head *list =3D &sk->sk_receive_queue;
> >       int rmem, err =3D -ENOMEM;
> >       spinlock_t *busy =3D NULL;
> > +     bool becomes_readable;
> >       int size, rcvbuf;
> >
> >       /* Immediately drop when the receive queue is full.
> > @@ -1532,12 +1533,19 @@ int __udp_enqueue_schedule_skb(struct sock *sk,=
 struct sk_buff *skb)
> >        */
> >       sock_skb_set_dropcount(sk, skb);
> >
> > +     becomes_readable =3D skb_queue_empty(list);
> >       __skb_queue_tail(list, skb);
> >       spin_unlock(&list->lock);
> >
> > -     if (!sock_flag(sk, SOCK_DEAD))
> > -             INDIRECT_CALL_1(sk->sk_data_ready, sock_def_readable, sk)=
;
> > -
> > +     if (!sock_flag(sk, SOCK_DEAD)) {
> > +             if (becomes_readable ||
> > +                 sk->sk_data_ready !=3D sock_def_readable ||
> > +                 READ_ONCE(sk->sk_peek_off) >=3D 0)
> > +                     INDIRECT_CALL_1(sk->sk_data_ready,
> > +                                     sock_def_readable, sk);
> > +             else
> > +                     sk_wake_async(sk, SOCK_WAKE_WAITD, POLL_IN);
> > +     }
>
> I understood this change showed no performances benefit???
>
> I guess the atomic_add_return() MB was hiding some/most of
> sock_def_readable() cost?

It did show benefits in the epoll case, because ep_poll_callback() is
very expensive.

I think you are referring to a prior discussion we had while still
using netperf tests, which do not use epoll.

Eliminating sock_def_readable() was avoiding the smp_mb() we have in
wq_has_sleeper()
and this was not a convincing win : The apparent cost of this smp_mb()
was high in moderate traffic,
but gradually became small if the cpu was fully utilized.

The atomic_add_return() cost is orthogonal (I see it mostly on ARM64 platfo=
rms)

