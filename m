Return-Path: <netdev+bounces-88625-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3AAB8A7EC9
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 10:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C01A281169
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 08:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55319139597;
	Wed, 17 Apr 2024 08:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jkK+xK75"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6231413281B
	for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 08:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713344085; cv=none; b=DtdXSBus/6QkG2fpj7UXZBvz/j+t1aEuTmjkKWa4ybRD2z+L92ypxzLYyuYs1VjKnsc0qOc8cAPYD8QlCfB6mx8TWxbSyEsEbUZZ/7UZqihGWgQSkEXlIaI6p56OtFOQEL+FJgUhvA0ofZxDK8/VSvP0Gc0fAfIfbPooo0Qf+O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713344085; c=relaxed/simple;
	bh=F3UkGWYq6jTK3782/r+V8BWDp047R59Pl/TTt2ozVvs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=icNNQBdvLNPe4KsvKB2IzScZ/uftpqTyLrUDqrdzQaxvjAOxSCbo/H3AnLprUGOT3vGH6YFowrcKTMLEuJVgYo2WzHs3DRS8HPJZGGgJbY4HQfwwYW7qGEipgu0JK52tFLQLIKbIl4qY2UUYej/2oPo3De7lR2XJ3z048pdiXsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jkK+xK75; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-41881bd2ea7so45285e9.1
        for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 01:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713344082; x=1713948882; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D2Q0qgouMY0HxajVxeo2A2P9aG8P/wFEHGo3jktH7h0=;
        b=jkK+xK75Z75rmQiUVgjLSvgUayiPHrQlrPbaDRukIynir9qUzMSXAYc0DDHPPymwt6
         5xRRTv4yZ6cRCMfPfr5d2vyU5FI633sx8pfqDX0wE9v0V4RBK3XatI+1oRzK1+jUbMj/
         bVK/xvhVEX4YmH3VllUgS6GLz273ZVsJFOx8TTRGTgn2Uk0uljEHkHzQxPdXkOUEVOQa
         HjdhJWBi47JUMw6LIBym3dvF1Vut8H0AVA5wfX+Hvpi4e6l4wLgbzHBIFaWf+1DLP1vO
         1sLC3ymbdRZWHaenRZ37dPe/5doK0ZXnV/8qetqQXHnwNbDtl5jBtv5DJXnFKs5oD8Om
         Kxnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713344082; x=1713948882;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D2Q0qgouMY0HxajVxeo2A2P9aG8P/wFEHGo3jktH7h0=;
        b=HOxrfSCMaGcFidqEQPZr+mRR0XJ5CbVOYO4Pyf/FS90aaTEc9Gydgsrq6ZICrbyYAA
         PxGSKR+n8QSzBu57zNCzW3w65iuz+bbkWWm4vNMLc9LEaRMaTo5nQUSU4SOL6PLKDI1N
         eeBaLm7hqGtvQyzb3xH6B32y+SfSSG2ZkPVAQmVJ/cT/EoKjgrSR2mtFWf9RwVW3iEjt
         6c3LWjO7IZe/vrnCzAeh2Bf0WHcjPdcXouH8QyUIug56CTKEaQUQ4kjIbc1aqT2/BnY4
         GuR1YUNk1V08Wz61b26fdaZJZczVyT0WBG7wMg8vbO4qJaVz89rueWLs9wYdGD9T2LSD
         Rdpg==
X-Forwarded-Encrypted: i=1; AJvYcCW8oJJ5Uf/jBkP87NtBOruG8CwjJDNj1alCIZJiuRTMmdvuhzVDyH5djXkPGbpo7tFqjimwPFQ9RfHe5xMgMEFiOyIImd4q
X-Gm-Message-State: AOJu0YzzPZmzuscRcWbpJ8Y+Le9dvnBrx6ISdx4zRMgf9VAkGehJxnPq
	5oTTF3uV1gIRVBojcwT0ZnpCB/dkLSa6T63jOv8n9SkFTOOon/aq/dj+BufQUoICnlzU/4lCNPD
	YiQo5fbFUxsSEm9k3ySgs/+AX7dvbcqZM7s5x
X-Google-Smtp-Source: AGHT+IGmZMmrMNfHNZNI0CE9mmS9XBy4pTP277sxXwhsYJGqIlMVTOzbwRfRxIrQ0gVvHZ+nTB9CIRDpfvo42LwGJjE=
X-Received: by 2002:a05:600c:1d28:b0:418:138e:f27c with SMTP id
 l40-20020a05600c1d2800b00418138ef27cmr150776wms.6.1713344081402; Wed, 17 Apr
 2024 01:54:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415132054.3822230-1-edumazet@google.com> <20240415132054.3822230-3-edumazet@google.com>
 <20240417083549.GA3846178@kernel.org>
In-Reply-To: <20240417083549.GA3846178@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 17 Apr 2024 10:54:30 +0200
Message-ID: <CANn89i+MF3F8Q063USmLYvyrffBKQRvb3ZM2c1MhAbFOwk9B-A@mail.gmail.com>
Subject: Re: [PATCH net-next 02/14] net_sched: cake: implement lockless cake_dump()
To: Simon Horman <horms@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>, 
	cake@lists.bufferbloat.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 10:35=E2=80=AFAM Simon Horman <horms@kernel.org> wr=
ote:
>
> + Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>
>   cake@lists.bufferbloat.net
>
> On Mon, Apr 15, 2024 at 01:20:42PM +0000, Eric Dumazet wrote:
> > Instead of relying on RTNL, cake_dump() can use READ_ONCE()
> > annotations, paired with WRITE_ONCE() ones in cake_change().
> >
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
>
> ...
>
> > @@ -2774,68 +2783,71 @@ static int cake_dump(struct Qdisc *sch, struct =
sk_buff *skb)
> >  {
> >       struct cake_sched_data *q =3D qdisc_priv(sch);
> >       struct nlattr *opts;
> > +     u16 rate_flags;
> >
> >       opts =3D nla_nest_start_noflag(skb, TCA_OPTIONS);
> >       if (!opts)
> >               goto nla_put_failure;
> >
> > -     if (nla_put_u64_64bit(skb, TCA_CAKE_BASE_RATE64, q->rate_bps,
> > -                           TCA_CAKE_PAD))
> > +     if (nla_put_u64_64bit(skb, TCA_CAKE_BASE_RATE64,
> > +                           READ_ONCE(q->rate_bps), TCA_CAKE_PAD))
> >               goto nla_put_failure;
> >
> >       if (nla_put_u32(skb, TCA_CAKE_FLOW_MODE,
> > -                     q->flow_mode & CAKE_FLOW_MASK))
> > +                     READ_ONCE(q->flow_mode) & CAKE_FLOW_MASK))
> >               goto nla_put_failure;
>
> Hi Eric,
>
> q->flow_mode is read twice in this function. Once here...
>
> >
> > -     if (nla_put_u32(skb, TCA_CAKE_RTT, q->interval))
> > +     if (nla_put_u32(skb, TCA_CAKE_RTT, READ_ONCE(q->interval)))
> >               goto nla_put_failure;
> >
> > -     if (nla_put_u32(skb, TCA_CAKE_TARGET, q->target))
> > +     if (nla_put_u32(skb, TCA_CAKE_TARGET, READ_ONCE(q->target)))
> >               goto nla_put_failure;
> >
> > -     if (nla_put_u32(skb, TCA_CAKE_MEMORY, q->buffer_config_limit))
> > +     if (nla_put_u32(skb, TCA_CAKE_MEMORY,
> > +                     READ_ONCE(q->buffer_config_limit)))
> >               goto nla_put_failure;
> >
> > +     rate_flags =3D READ_ONCE(q->rate_flags);
> >       if (nla_put_u32(skb, TCA_CAKE_AUTORATE,
> > -                     !!(q->rate_flags & CAKE_FLAG_AUTORATE_INGRESS)))
> > +                     !!(rate_flags & CAKE_FLAG_AUTORATE_INGRESS)))
> >               goto nla_put_failure;
> >
> >       if (nla_put_u32(skb, TCA_CAKE_INGRESS,
> > -                     !!(q->rate_flags & CAKE_FLAG_INGRESS)))
> > +                     !!(rate_flags & CAKE_FLAG_INGRESS)))
> >               goto nla_put_failure;
> >
> > -     if (nla_put_u32(skb, TCA_CAKE_ACK_FILTER, q->ack_filter))
> > +     if (nla_put_u32(skb, TCA_CAKE_ACK_FILTER, READ_ONCE(q->ack_filter=
)))
> >               goto nla_put_failure;
> >
> >       if (nla_put_u32(skb, TCA_CAKE_NAT,
> > -                     !!(q->flow_mode & CAKE_FLOW_NAT_FLAG)))
> > +                     !!(READ_ONCE(q->flow_mode) & CAKE_FLOW_NAT_FLAG))=
)
> >               goto nla_put_failure;
>
> ... and once here.
>
> I am assuming that it isn't a big deal, but perhaps it is better to save
> q->flow_mode into a local variable.
>
> Also, more importantly, q->flow_mode does not seem to be handled
> using WRITE_ONCE() in cake_change(). It's a non-trivial case,
> which I guess is well served by a mechanism built around a local variable=
.

Thanks !

I will squash in v2:

diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index bb37a0dedcc1e4b3418f6681d87108aad7ea066f..9602dafe32e61d38dc00b0a35e1=
ee3f530989610
100644
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -2573,6 +2573,7 @@ static int cake_change(struct Qdisc *sch, struct
nlattr *opt,
        struct cake_sched_data *q =3D qdisc_priv(sch);
        struct nlattr *tb[TCA_CAKE_MAX + 1];
        u16 rate_flags;
+       u8 flow_mode;
        int err;

        err =3D nla_parse_nested_deprecated(tb, TCA_CAKE_MAX, opt, cake_pol=
icy,
@@ -2580,10 +2581,11 @@ static int cake_change(struct Qdisc *sch,
struct nlattr *opt,
        if (err < 0)
                return err;

+       flow_mode =3D q->flow_mode;
        if (tb[TCA_CAKE_NAT]) {
 #if IS_ENABLED(CONFIG_NF_CONNTRACK)
-               q->flow_mode &=3D ~CAKE_FLOW_NAT_FLAG;
-               q->flow_mode |=3D CAKE_FLOW_NAT_FLAG *
+               flow_mode &=3D ~CAKE_FLOW_NAT_FLAG;
+               flow_mode |=3D CAKE_FLOW_NAT_FLAG *
                        !!nla_get_u32(tb[TCA_CAKE_NAT]);
 #else
                NL_SET_ERR_MSG_ATTR(extack, tb[TCA_CAKE_NAT],
@@ -2609,7 +2611,7 @@ static int cake_change(struct Qdisc *sch, struct
nlattr *opt,
        }

        if (tb[TCA_CAKE_FLOW_MODE])
-               q->flow_mode =3D ((q->flow_mode & CAKE_FLOW_NAT_FLAG) |
+               flow_mode =3D ((flow_mode & CAKE_FLOW_NAT_FLAG) |
                                (nla_get_u32(tb[TCA_CAKE_FLOW_MODE]) &
                                        CAKE_FLOW_MASK));

@@ -2689,6 +2691,7 @@ static int cake_change(struct Qdisc *sch, struct
nlattr *opt,
        }

        WRITE_ONCE(q->rate_flags, rate_flags);
+       WRITE_ONCE(q->flow_mode, flow_mode);
        if (q->tins) {
                sch_tree_lock(sch);
                cake_reconfigure(sch);
@@ -2784,6 +2787,7 @@ static int cake_dump(struct Qdisc *sch, struct
sk_buff *skb)
        struct cake_sched_data *q =3D qdisc_priv(sch);
        struct nlattr *opts;
        u16 rate_flags;
+       u8 flow_mode;

        opts =3D nla_nest_start_noflag(skb, TCA_OPTIONS);
        if (!opts)
@@ -2793,8 +2797,8 @@ static int cake_dump(struct Qdisc *sch, struct
sk_buff *skb)
                              READ_ONCE(q->rate_bps), TCA_CAKE_PAD))
                goto nla_put_failure;

-       if (nla_put_u32(skb, TCA_CAKE_FLOW_MODE,
-                       READ_ONCE(q->flow_mode) & CAKE_FLOW_MASK))
+       flow_mode =3D READ_ONCE(q->flow_mode);
+       if (nla_put_u32(skb, TCA_CAKE_FLOW_MODE, flow_mode & CAKE_FLOW_MASK=
))
                goto nla_put_failure;

        if (nla_put_u32(skb, TCA_CAKE_RTT, READ_ONCE(q->interval)))
@@ -2820,7 +2824,7 @@ static int cake_dump(struct Qdisc *sch, struct
sk_buff *skb)
                goto nla_put_failure;

        if (nla_put_u32(skb, TCA_CAKE_NAT,
-                       !!(READ_ONCE(q->flow_mode) & CAKE_FLOW_NAT_FLAG)))
+                       !!(flow_mode & CAKE_FLOW_NAT_FLAG)))
                goto nla_put_failure;

        if (nla_put_u32(skb, TCA_CAKE_DIFFSERV_MODE, READ_ONCE(q->tin_mode)=
))

