Return-Path: <netdev+bounces-83240-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 904C8891701
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 11:43:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 464CE28775F
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 10:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 863DE664A4;
	Fri, 29 Mar 2024 10:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KZ0OL3Zr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99484524C6
	for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 10:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711709031; cv=none; b=rabYcn5F6Yjiy9nLTouDm56BtB7kEU8l9BFpZOPvjx1NRvsaoajheJHBBlFty7R2TvAD+XpNmxNqE9Eg61xQJGxvdJkfwMIujmeHJ13eZREwrQmWpFMKWJkGiJXCk/hlRgT/64rxrUquhmWpm/AeTJH2W9TLnRlgdIqs1EAB1OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711709031; c=relaxed/simple;
	bh=kANklVzcWLeV7GfBdlIVGJwRz/5Ghl5l8FZ9KpprDXo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I3Ugx0TYmOvjIekGZz+VE/SePSLgY9lVhZUFohPDSmWPLbii2ofB4Qd/aPWuMYfd/hi0pxULR41rYRnNkZ+83LTqZiq4HjhbzFbhT8WoBVeaVM2phw6wvbvrKqEDWdwJu3PqL6oV/miVbr3D3nfcO/KLo/aYdDarQ0JhT95BvaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KZ0OL3Zr; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4148c09ec6bso43675e9.1
        for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 03:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711709028; x=1712313828; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BswVeo27Oh7dAc/LOhv6CTMo7+P1mAzw3bzPOA93dfE=;
        b=KZ0OL3ZrrftA44suzZ0ULr7Wl4K5lwwF/9FQOnNJMskpZcGm6KB4sg9my6shS2XekH
         EetmR64Y3824Hlp4wJDKmAHm/TqwywNeyADRtd6OJRHCVuUWNv2RiYIZClxHALfgSMDg
         6PvwVQST2a3yRnAM3A+89epkBLNNoYjkRQmf/0g2uLDvmEgTv9995Enl9mumU9iABoKx
         HMmZTLse38zbPltukXFUCx6B10dIktsGTRLv343yEoFFG36W3gnnuN0Skcco/NPgGI79
         dW8ynBf+JR2DCJlgQZ015w2spG01ucqfSTT/3F1z2viucmkbJOXx5DEoCO2KwFMwTMCr
         /ESw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711709028; x=1712313828;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BswVeo27Oh7dAc/LOhv6CTMo7+P1mAzw3bzPOA93dfE=;
        b=of1U9haY35nyYnC8fH2/siFdvVA6rrWQsh5pJSVJbHzRnIZoY0tiR3R+iUD8fTiH1i
         j0j81gkcklxi3Poy3D7JjblMQueyz3nVYhixUos40MZDhj1dKBcnvXC3OPDXBQAYedlV
         rbyRWj3Jddx6JFQgaMNs7caduq4A1nAS8aZwGnbCjv0mO25oKYC9Hg4ExAvpsroIn3N3
         JgyMcfuThb8LWsq1JERsYrZ7PqwUnCDcfh6t4XcdBkfgr5e0QFlN8XMkoM3Zz0S4Va8P
         5716DcmckxXCEojVPeogzupk4w7f0Un0BtA/W2dNdFyd7U4UnhE2KXUtYy3GAkbCVqL3
         kZLA==
X-Forwarded-Encrypted: i=1; AJvYcCVvgVSO2ub/nRNjmByZ9hQhZRTZY2L8EJ2Y7t+vInlXxSwBLLV32q0Lg7zx7lNn5whZp2zWoZ1Py+SxZOi/l+6EVqsCp16a
X-Gm-Message-State: AOJu0Yz5SzZPBSw+mHI4iZVVzuP0pWef1tH00SeL0fiWzOWVUD2f8GkJ
	2u1Cqa5/W5LNXfM3luEZ/K5glTmiF1qUJ1V7RneVf/ikejh7gFniN3VTyzlyVGRXWOcqzfh0CpD
	khAMhOYaR94MCdAOnE1W9nV4Lq6d7rruCxz9g
X-Google-Smtp-Source: AGHT+IE5Na0j/pWpWqmyvzu2Nq1znLyYvblamVutWAXAwm52wP8cG6MFjnGxm4bTZfdfKqaf4u1flVZLHd/Sr5pBzLI=
X-Received: by 2002:a05:600c:47cf:b0:414:908c:460d with SMTP id
 l15-20020a05600c47cf00b00414908c460dmr108625wmo.7.1711709027784; Fri, 29 Mar
 2024 03:43:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240329034243.7929-1-kerneljasonxing@gmail.com>
 <20240329034243.7929-3-kerneljasonxing@gmail.com> <CANn89iK35sZ7yYLfRb+m475b7kg+LHw4nV9qHWP7aQtLvBoeMA@mail.gmail.com>
 <CAL+tcoBt0DxdSbb5PES8uYgeyBqThUyS_J4d3hUuxZv8=J0H9A@mail.gmail.com>
In-Reply-To: <CAL+tcoBt0DxdSbb5PES8uYgeyBqThUyS_J4d3hUuxZv8=J0H9A@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 29 Mar 2024 11:43:34 +0100
Message-ID: <CANn89iJ1c2efW94sxdsiCqir=twc+Yam2KCgcGK8-oNM26nifw@mail.gmail.com>
Subject: Re: [PATCH net-next v3 2/3] trace: tcp: fully support trace_tcp_send_reset
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com, rostedt@goodmis.org, 
	kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net, 
	netdev@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 29, 2024 at 11:23=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.=
com> wrote:
>
> On Fri, Mar 29, 2024 at 5:07=E2=80=AFPM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > On Fri, Mar 29, 2024 at 4:43=E2=80=AFAM Jason Xing <kerneljasonxing@gma=
il.com> wrote:
> > >
> > > From: Jason Xing <kernelxing@tencent.com>
> > >
> > > Prior to this patch, what we can see by enabling trace_tcp_send is
> > > only happening under two circumstances:
> > > 1) active rst mode
> > > 2) non-active rst mode and based on the full socket
> > >
> > > That means the inconsistency occurs if we use tcpdump and trace
> > > simultaneously to see how rst happens.
> > >
> > > It's necessary that we should take into other cases into consideratio=
ns,
> > > say:
> > > 1) time-wait socket
> > > 2) no socket
> > > ...
> > >
> > > By parsing the incoming skb and reversing its 4-tuple can
> > > we know the exact 'flow' which might not exist.
> > >
> > > Samples after applied this patch:
> > > 1. tcp_send_reset: skbaddr=3DXXX skaddr=3DXXX src=3Dip:port dest=3Dip=
:port
> > > state=3DTCP_ESTABLISHED
> > > 2. tcp_send_reset: skbaddr=3D000...000 skaddr=3DXXX src=3Dip:port des=
t=3Dip:port
> > > state=3DUNKNOWN
> > > Note:
> > > 1) UNKNOWN means we cannot extract the right information from skb.
> > > 2) skbaddr/skaddr could be 0
> > >
> > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > ---
> > >  include/trace/events/tcp.h | 39 ++++++++++++++++++++++++++++++++++++=
--
> > >  net/ipv4/tcp_ipv4.c        |  4 ++--
> > >  net/ipv6/tcp_ipv6.c        |  3 ++-
> > >  3 files changed, 41 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/include/trace/events/tcp.h b/include/trace/events/tcp.h
> > > index 194425f69642..289438c54227 100644
> > > --- a/include/trace/events/tcp.h
> > > +++ b/include/trace/events/tcp.h
> > > @@ -78,11 +78,46 @@ DEFINE_EVENT(tcp_event_sk_skb, tcp_retransmit_skb=
,
> > >   * skb of trace_tcp_send_reset is the skb that caused RST. In case o=
f
> > >   * active reset, skb should be NULL
> > >   */
> > > -DEFINE_EVENT(tcp_event_sk_skb, tcp_send_reset,
> > > +TRACE_EVENT(tcp_send_reset,
> > >
> > >         TP_PROTO(const struct sock *sk, const struct sk_buff *skb),
> > >
> > > -       TP_ARGS(sk, skb)
> > > +       TP_ARGS(sk, skb),
> > > +
> > > +       TP_STRUCT__entry(
> > > +               __field(const void *, skbaddr)
> > > +               __field(const void *, skaddr)
> > > +               __field(int, state)
> > > +               __array(__u8, saddr, sizeof(struct sockaddr_in6))
> > > +               __array(__u8, daddr, sizeof(struct sockaddr_in6))
> > > +       ),
> > > +
> > > +       TP_fast_assign(
> > > +               __entry->skbaddr =3D skb;
> > > +               __entry->skaddr =3D sk;
> > > +               /* Zero means unknown state. */
> > > +               __entry->state =3D sk ? sk->sk_state : 0;
> > > +
> > > +               memset(__entry->saddr, 0, sizeof(struct sockaddr_in6)=
);
> > > +               memset(__entry->daddr, 0, sizeof(struct sockaddr_in6)=
);
> > > +
> > > +               if (sk && sk_fullsock(sk)) {
> > > +                       const struct inet_sock *inet =3D inet_sk(sk);
> > > +
> > > +                       TP_STORE_ADDR_PORTS(__entry, inet, sk);
> > > +               } else {
> >
> > To be on the safe side, I would test if (skb) here.
> > We have one caller with skb =3D=3D NULL, we might have more in the futu=
re.
>
> Thanks for the review.
>
> How about changing '} else {' to '} else if (skb) {', then if we go
> into this else-if branch, we will print nothing, right? I'll test it
> in this case.

Right, the fields are cleared before this else

+               memset(__entry->saddr, 0, sizeof(struct sockaddr_in6));
+               memset(__entry->daddr, 0, sizeof(struct sockaddr_in6));

>
> >
> > > +                       /*
> > > +                        * We should reverse the 4-tuple of skb, so l=
ater
> > > +                        * it can print the right flow direction of r=
st.
> > > +                        */
> > > +                       TP_STORE_ADDR_PORTS_SKB(skb, entry->daddr, en=
try->saddr);
> > > +               }
> > > +       ),
> > > +
> > > +       TP_printk("skbaddr=3D%p skaddr=3D%p src=3D%pISpc dest=3D%pISp=
c state=3D%s",
> > > +                 __entry->skbaddr, __entry->skaddr,
> > > +                 __entry->saddr, __entry->daddr,
> > > +                 __entry->state ? show_tcp_state_name(__entry->state=
) : "UNKNOWN")
> > >  );
> > >
> > >  /*
> > > diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> > > index a22ee5838751..d5c4a969c066 100644
> > > --- a/net/ipv4/tcp_ipv4.c
> > > +++ b/net/ipv4/tcp_ipv4.c
> > > @@ -868,10 +868,10 @@ static void tcp_v4_send_reset(const struct sock=
 *sk, struct sk_buff *skb)
> > >          */
> > >         if (sk) {
> > >                 arg.bound_dev_if =3D sk->sk_bound_dev_if;
> > > -               if (sk_fullsock(sk))
> > > -                       trace_tcp_send_reset(sk, skb);
> > >         }
> >
> > Remove the { } ?
>
> Yes, I forgot to remove them.

No problem.

