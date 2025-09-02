Return-Path: <netdev+bounces-219296-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C0BB40EBB
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 22:47:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1C871B656CE
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 20:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0888A253F2B;
	Tue,  2 Sep 2025 20:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xT4F4/mG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708AC2253EB
	for <netdev@vger.kernel.org>; Tue,  2 Sep 2025 20:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756845974; cv=none; b=LCYdjnp/iG9Z0XLH5N9fsL+L3K2dHMzoP9J0qIxfCYXDrvIVgEuf0aOdXbP+aPnmzAha1ezUsRHlbE0htP128DBR2FdMk68cTViBhHAdgkk+N7eVXq0smur9/JbeZ58QD6vOyKoGFUSYx1H5q13Lqvrdr13Ri6+iffexyjRMbTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756845974; c=relaxed/simple;
	bh=MoKvuoV994xpyClECQK7AzVdCQxgT/CjSBm4UEsY9Dc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tFQFHzOEIolg9LSe/JkFRPYZzuktJ2hYYF0KW/f0xUE21BUvIVie2dZ085wC+c+cv1y8Os8y3XR8nSeXvAn7wYFTTnzxz61MMuyRBxXUpjg/u4BgEg/LTIcBt9KZw5APljbBmd1y+QA5m2D/e2GWmgN3bkKeHGzhsduf264HTJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xT4F4/mG; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-248d5074ff7so2297985ad.0
        for <netdev@vger.kernel.org>; Tue, 02 Sep 2025 13:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756845972; x=1757450772; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q08TyIut9dm+xELvPQIMTkd2TmfIIb+xZ+XCxWQOLOc=;
        b=xT4F4/mGczkiY+CeWCybD+13BCq9e5Fv7s3DTsnGSUnn/fW+BtR1fW/wPFNIfEFYy0
         PPwSLHeZDgl3CGsj/uSuKHobsJZnyRTDCxwBF9sdqr113Pz85HTxnPaOlqRaQHej7OA2
         b4dTjfm0MZByjFhikMujywzXEoGMYzvTQUtGsVG0g2SFahvwHMMOAQdTtI+sbqFNJkzM
         G9c3L/7BTIbuiszXmlpaeMtTHMZ1ZgyeJhqFcwp9qk9PmQ1eMIB4VI86g3b7lH/s4L++
         dAv5HW/5s5htVu0228upO6GfZE0i5nt0gdAsus8rjENu8zqsY9zcxFMQ/B94gRCNxzZJ
         +gEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756845972; x=1757450772;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q08TyIut9dm+xELvPQIMTkd2TmfIIb+xZ+XCxWQOLOc=;
        b=h3BqnYQVsn74z+mgjd8NsW9fqegoWbJLgWq0VBUywdE1PDjrYEgANmo3X/wuG38YYc
         IYxCiq6rz61SHTydZHPdZyr8KtR3b/2osiGWr3JxIdKIo96HHo3KEVhadiS7+gJf8410
         leSu+cpj+XnlWjfhwncJJs845wE/GQONIQx4H47NxqOYu4eDpfAeFH+Tmn7YEGHczWyg
         HBuyt3LN1RwIzYM5uOhgMUa4qkZQ1Y/3oREnePUR0x2xGWwsiD5ZyKNJcQuL1Ecgoxgx
         H2V2RXvl2xAJxxWKrmYa6T7SGFi84HaaBbP5MItwR+m8foQ8U4u00OSy6JOo+HThRNH9
         qmTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLnNsqzbWtmZsDGqYWPg69XYYkatJobCISKuJEVpVF9GAGbMiUvgF2uo4/L5I2ILoOm8VwD7U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyT8N1Y6uFc2IejN++EqqPEzPGOEAb2B1m/SFl1fAgR178lMlTc
	neJqmkwaBAb19sobMS0Cz+0cbpuzchQ6aatWNwAnkwU3I4ei4d2Y9tMgIRopLUOXhcFmAT4Iy9M
	olfTVUbf4i8gSa6dFXV+yYaamGHHqJCUlCkOCs0GU
X-Gm-Gg: ASbGncvvwkNNY+DqyOqAkUxN0Y/enxTtWgOvcYhOuhEhCFQCj+kOjYcMjFpdlFLs30t
	XnMUWL7aZePZPnmMoY2IiZtMXGskF6QU/8gTFy4I7iFxhSOWNYllO44eGvPMRWmH7Y4JnqhRowK
	3eT1VfK8+QlZOb3z6mrLSQpn+6iMrA9OO1GbQQZH0A1zlUPn/UCGmy87b82O6yty2I7oL8Dcm/J
	KOifxWMxfJs54WDUTTvKGIDD0EHJvOtehDMjAsqONXKkeWiQN0couqm3ipvfWMjzFEKjwl5/J6S
	mw==
X-Google-Smtp-Source: AGHT+IGv1tEkpI0Ipz6B/OKk8d17BVJiPdbD/i+LdBvURGy8fHGkZZlgbhRqABCAKLKjS+Pcz3jJke/9zkeAhUuHU0I=
X-Received: by 2002:a17:903:2b8f:b0:246:e235:49d7 with SMTP id
 d9443c01a7336-24944ac2518mr118431055ad.15.1756845970857; Tue, 02 Sep 2025
 13:46:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829010026.347440-1-kuniyu@google.com> <20250829010026.347440-5-kuniyu@google.com>
 <4334e29b-1cd0-48ba-9afa-54d01b1b7143@linux.dev>
In-Reply-To: <4334e29b-1cd0-48ba-9afa-54d01b1b7143@linux.dev>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 2 Sep 2025 13:45:59 -0700
X-Gm-Features: Ac12FXzssOMNg3ot4aB-drIIH7wvvzsyyy2W23cFszc0gJNhvYno7vmjPVYVb4o
Message-ID: <CAAVpQUAAVF==Db=1xj7bbrbiu-tPNxt3Y43CPhy6=X7-+huc7A@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next/net 4/5] net-memcg: Allow decoupling memcg
 from global protocol memory accounting.
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Mina Almasry <almasrymina@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 1:17=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.d=
ev> wrote:
>
> On 8/28/25 6:00 PM, Kuniyuki Iwashima wrote:
> > +static inline bool sk_should_enter_memory_pressure(struct sock *sk)
> > +{
> > +     return !mem_cgroup_sk_enabled(sk) || !mem_cgroup_sk_isolated(sk);
> > +}
> > +
> >   static inline long
> >   proto_memory_allocated(const struct proto *prot)
> >   {
>
> > @@ -3154,8 +3158,11 @@ bool sk_page_frag_refill(struct sock *sk, struct=
 page_frag *pfrag)
> >       if (likely(skb_page_frag_refill(32U, pfrag, sk->sk_allocation)))
> >               return true;
> >
> > -     sk_enter_memory_pressure(sk);
> > +     if (sk_should_enter_memory_pressure(sk))
> > +             sk_enter_memory_pressure(sk);
> > +
> >       sk_stream_moderate_sndbuf(sk);
> > +
> >       return false;
> >   }
>
> > diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> > index 71a956fbfc55..dcbd49e2f8af 100644
> > --- a/net/ipv4/tcp.c
> > +++ b/net/ipv4/tcp.c
> > @@ -908,7 +908,8 @@ struct sk_buff *tcp_stream_alloc_skb(struct sock *s=
k, gfp_t gfp,
> >               }
> >               __kfree_skb(skb);
> >       } else {
> > -             sk->sk_prot->enter_memory_pressure(sk);
> > +             if (sk_should_enter_memory_pressure(sk))
> > +                     tcp_enter_memory_pressure(sk);
>
> This change from sk_prot->enter_memory_pressure to tcp_enter_memory_press=
ure
> looks fine. A qq / nit, have you thought about checking
> sk_should_enter_memory_pressure inside the tcp_enter_memory_pressure(sk) =
/
> sk_enter_memory_pressure(sk) ?

Yes, I wanted to centralise the check to sk_enter_memory_pressure(),
but it calls tcp_enter_memory_pressure() (or sctp one) and they are also
called directly, so I finally placed the check outside of the functions.




>
> Other changes of patch 4 lgtm.
>
> Shakeel, you have ack-ed patch 1. Will you take a look at patch 3 and pat=
ch 4 also?
>
> >               sk_stream_moderate_sndbuf(sk);
> >       }
>
> > @@ -1016,7 +1017,7 @@ static void mptcp_enter_memory_pressure(struct so=
ck *sk)
> >       mptcp_for_each_subflow(msk, subflow) {
> >               struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
> >
> > -             if (first)
> > +             if (first && sk_should_enter_memory_pressure(ssk))
> >                       tcp_enter_memory_pressure(ssk);
> >               sk_stream_moderate_sndbuf(ssk);
> >
> > diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
> > index f672a62a9a52..6696ef837116 100644
> > --- a/net/tls/tls_device.c
> > +++ b/net/tls/tls_device.c
> > @@ -35,6 +35,7 @@
> >   #include <linux/netdevice.h>
> >   #include <net/dst.h>
> >   #include <net/inet_connection_sock.h>
> > +#include <net/proto_memory.h>
> >   #include <net/tcp.h>
> >   #include <net/tls.h>
> >   #include <linux/skbuff_ref.h>
> > @@ -371,7 +372,8 @@ static int tls_do_allocation(struct sock *sk,
> >       if (!offload_ctx->open_record) {
> >               if (unlikely(!skb_page_frag_refill(prepend_size, pfrag,
> >                                                  sk->sk_allocation))) {
> > -                     READ_ONCE(sk->sk_prot)->enter_memory_pressure(sk)=
;
> > +                     if (sk_should_enter_memory_pressure(sk))
> > +                             READ_ONCE(sk->sk_prot)->enter_memory_pres=
sure(sk);
> >                       sk_stream_moderate_sndbuf(sk);
> >                       return -ENOMEM;
> >               }
>

