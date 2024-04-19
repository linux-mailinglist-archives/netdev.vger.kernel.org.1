Return-Path: <netdev+bounces-89527-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E918AA973
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 09:45:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4580F2846F3
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 07:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D8847F5F;
	Fri, 19 Apr 2024 07:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VsJ+tm0W"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42FCBE4B
	for <netdev@vger.kernel.org>; Fri, 19 Apr 2024 07:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713512668; cv=none; b=eDbFg1+BMaqDt+15KljbYrS0Y/UB2XKhMxRGviK24tvKB/yapCPVPPvBXMzp6AJqXfW+E0dwvzYoJyRTDjQV3G4Q0waAJ805e8XbCCLUlIhof3oF2XDRuoNzshO5jfeGclS9u+NU8GpqvE6NCEe3SeMeUf6Vocri1qDcoZfxA00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713512668; c=relaxed/simple;
	bh=e/DvZWvOjb0JOnalFfM70R734OGAUWjKB9RnZANnd3c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g5+DqaVd3iqxrLgOFndb4/eaWex+wN+tV6R9sUaUniGzIno+Izb+Ghu55h9O64uVMutLKQG4EMonei/m+gvcdIsw9f1ppQkqBCWdGRBYQO9v6aHfnN5fOKsdyKZ9KPzfu2XmXw8JezptlXvRm4hS+QZjmU/lFWtDhtXSw3eOiWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VsJ+tm0W; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-418820e6effso36455e9.0
        for <netdev@vger.kernel.org>; Fri, 19 Apr 2024 00:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713512665; x=1714117465; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ASrRKKlJfjvhALvh+lswlaFCRhW8Q2YKgf0CCEi8m40=;
        b=VsJ+tm0WLwJhvQ4Im6jTWuhK2SEGiw7fR0yXzppUIyh85HbvslMS5OYbpJSnpsBcFh
         +F3FvHE4Ae/96t8xIWHCvzDSZn4oJ+PGMIm+ClrVrlSpqAD+W1f0A0Xd+liItjWbqsGv
         IKpWUyL7qtrwixSDb1wyR/ZZe1gQ9FiseFBX3RkVdcD5NzcSICsPtXtU/hz54eXljlbA
         FJ693mtKgiSfe/QjJ8pn8+Oyh0zpQYkcdLzcC4QRyLeCw14kQ4XSJh7ihyz7Ja6acMfu
         fKexIhpxP2KwmIgMmrDiCYkoGCNYbcreWudxj31cc+AgQXn/XAUuLyy1J627H8uM3oWN
         zPaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713512665; x=1714117465;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ASrRKKlJfjvhALvh+lswlaFCRhW8Q2YKgf0CCEi8m40=;
        b=WQObM/6c0XoeE6LHq90UT6IFAb04nzIfw7KVAUG+l59n4ijmC6LDS88eAfQMTei7xe
         lYQUINpiTESKG8lwRZ8ti7+ShRIOkietiiWMOkaewmWF80bMNQKCJPnTSFOEZ3fY+RV/
         SCQdg8nRBTcSp92/bxE19TWmDfOUJFjSu52iuDEn/FvU0BnWR8fpYMDeuNimapNB0c3b
         RZcFFKgzYMiNEb700oO2NbvRjg+3dI2h0iqGzqQ08lLCruTJWk4txfUop6NoQvKmBQZv
         6vgCCz7C8TT41yb4/REH/tJ+ZfTHFMh6Q0D47fj11AkbQ2qtw9mwemtTaDRYaQoFq3RZ
         h7sQ==
X-Forwarded-Encrypted: i=1; AJvYcCXINtqsGTjaiDkt79+VRAeIED0iNdNm5ROQBMZacgu0uowVOHjYeXj+OwOQbP7ot1bz//vYAmN7O9Zdv7rwWmGpCxW3pDPn
X-Gm-Message-State: AOJu0Yy9b4SNf9eIu9mLaW3HLYrilJCC5CPKaVQ6kAWbqLhgjpTvOXZU
	4V5z2z9Vgc5I0p4IF57cktxyvNz022Gpt3u+/E8IfUbR92z46n5j/ZWugqq5Gm4Pqu6AoV3OtL0
	6J/RIb2JmBRAICQHKWZx3rozuEzb1Td7SVCFv
X-Google-Smtp-Source: AGHT+IHHazdTlBrY4//nCbRr1Okkrz7QudXZ58oKgYKMNTpOAzqru6/aok2jfl8sNpR3NG/RLlGTWppMTDqpyh1IpXQ=
X-Received: by 2002:a05:600c:1c09:b0:418:97c6:188d with SMTP id
 j9-20020a05600c1c0900b0041897c6188dmr95526wms.7.1713512664820; Fri, 19 Apr
 2024 00:44:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417085143.69578-1-kerneljasonxing@gmail.com>
 <CAL+tcoDJZe9pxjmVfgnq8z_sp6Zqe-jhWqoRnyuNwKXuPLGzVQ@mail.gmail.com>
 <20240418084646.68713c42@kernel.org> <CAL+tcoD4hyfBz4LrOOh6q6OO=6G7zpdXBQgR2k4rH3FwXsY3XA@mail.gmail.com>
 <CANn89iJ4pW7OFQ59RRHMimdYdN9PZ=D+vEq0je877s0ijH=xeg@mail.gmail.com>
 <CAL+tcoBV77KmL8_d1PTk8muA6Gg3hPYb99BpAXD9W1RcFsg7Bw@mail.gmail.com>
 <CAL+tcoAEN-OQeqn3m3zLGUiPZEaoTjz0WHaNL-xm702aot_m-g@mail.gmail.com>
 <CANn89iL9OzD5+Y56F_8Jqyxwa5eDQPaPjhX9Y-Y_b9+bcQE08Q@mail.gmail.com> <CAL+tcoBn8RHm8AbwMBJ6FM6PMLLotCwTxSgPS1ABd-_D7uBSxw@mail.gmail.com>
In-Reply-To: <CAL+tcoBn8RHm8AbwMBJ6FM6PMLLotCwTxSgPS1ABd-_D7uBSxw@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 19 Apr 2024 09:44:13 +0200
Message-ID: <CANn89iJ4a5VE-_AV-wVrh9Zpu0yS=jtwJaR_s2cBX7pP_QGQXQ@mail.gmail.com>
Subject: Re: [PATCH net-next v6 0/7] Implement reset reason mechanism to detect
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, dsahern@kernel.org, matttbe@kernel.org, 
	martineau@kernel.org, geliang@kernel.org, pabeni@redhat.com, 
	davem@davemloft.net, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, atenart@kernel.org, mptcp@lists.linux.dev, 
	netdev@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 19, 2024 at 9:29=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> On Fri, Apr 19, 2024 at 3:02=E2=80=AFPM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > On Fri, Apr 19, 2024 at 4:31=E2=80=AFAM Jason Xing <kerneljasonxing@gma=
il.com> wrote:
> > >
> > > On Fri, Apr 19, 2024 at 7:26=E2=80=AFAM Jason Xing <kerneljasonxing@g=
mail.com> wrote:
> > > >
> > > > > When I said "If you feel the need to put them in a special group,=
 this
> > > > > is fine by me.",
> > > > > this was really about partitioning the existing enum into groups,=
 if
> > > > > you prefer having a group of 'RES reasons'
> > > >
> > > > Are you suggesting copying what we need from enum skb_drop_reason{}=
 to
> > > > enum sk_rst_reason{}? Why not reusing them directly. I have no idea
> > > > what the side effect of cast conversion itself is?
> > >
> > > Sorry that I'm writing this email. I'm worried my statement is not
> > > that clear, so I write one simple snippet which can help me explain
> > > well :)
> > >
> > > Allow me give NO_SOCKET as an example:
> > > diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
> > > index e63a3bf99617..2c9f7364de45 100644
> > > --- a/net/ipv4/icmp.c
> > > +++ b/net/ipv4/icmp.c
> > > @@ -767,6 +767,7 @@ void __icmp_send(struct sk_buff *skb_in, int type=
,
> > > int code, __be32 info,
> > >         if (!fl4.saddr)
> > >                 fl4.saddr =3D htonl(INADDR_DUMMY);
> > >
> > > +       trace_icmp_send(skb_in, type, code);
> > >         icmp_push_reply(sk, &icmp_param, &fl4, &ipc, &rt);
> > >  ende:
> > >         ip_rt_put(rt);
> > > diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> > > index 1e650ec71d2f..d5963831280f 100644
> > > --- a/net/ipv4/tcp_ipv4.c
> > > +++ b/net/ipv4/tcp_ipv4.c
> > > @@ -2160,6 +2160,7 @@ int tcp_v4_rcv(struct sk_buff *skb)
> > >  {
> > >         struct net *net =3D dev_net(skb->dev);
> > >         enum skb_drop_reason drop_reason;
> > > +       enum sk_rst_reason rst_reason;
> > >         int sdif =3D inet_sdif(skb);
> > >         int dif =3D inet_iif(skb);
> > >         const struct iphdr *iph;
> > > @@ -2355,7 +2356,8 @@ int tcp_v4_rcv(struct sk_buff *skb)
> > >  bad_packet:
> > >                 __TCP_INC_STATS(net, TCP_MIB_INERRS);
> > >         } else {
> > > -               tcp_v4_send_reset(NULL, skb);
> > > +               rst_reason =3D RST_REASON_NO_SOCKET;
> > > +               tcp_v4_send_reset(NULL, skb, rst_reason);
> > >         }
> > >
> > >  discard_it:
> > >
> > > As you can see, we need to add a new 'rst_reason' variable which
> > > actually is the same as drop reason. They are the same except for the
> > > enum type... Such rst_reasons/drop_reasons are all over the place.
> > >
> > > Eric, if you have a strong preference, I can do it as you said.
> > >
> > > Well, how about explicitly casting them like this based on the curren=
t
> > > series. It looks better and clearer and more helpful to people who is
> > > reading codes to understand:
> > > diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> > > index 461b4d2b7cfe..eb125163d819 100644
> > > --- a/net/ipv4/tcp_ipv4.c
> > > +++ b/net/ipv4/tcp_ipv4.c
> > > @@ -1936,7 +1936,7 @@ int tcp_v4_do_rcv(struct sock *sk, struct sk_bu=
ff *skb)
> > >         return 0;
> > >
> > >  reset:
> > > -       tcp_v4_send_reset(rsk, skb, (u32)reason);
> > > +       tcp_v4_send_reset(rsk, skb, (enum sk_rst_reason)reason);
> > >  discard:
> > >         kfree_skb_reason(skb, reason);
> > >         /* Be careful here. If this function gets more complicated an=
d
> >
> > It makes no sense to declare an enum sk_rst_reason and then convert it
> > to drop_reason
> > or vice versa.
> >
> > Next thing you know, compiler guys will add a new -Woption that will
> > forbid such conversions.
> >
> > Please add to tcp_v4_send_reset() an skb_drop_reason, not a new enum.
>
> Ah... It looks like I didn't make myself clear again. Sorry...
> Actually I wrote this part many times. My conclusion is that It's not
> feasible to do this.
>
> REASONS:
> If we __only__ need to deal with this passive reset in TCP, it's fine.
> We pass a skb_drop_reason which should also be converted to u32 type
> in tcp_v4_send_reset() as you said, it can work. People who use the
> trace will see the reason with the 'SKB_DROP_REASON' prefix stripped.
>
> But we have to deal with other cases. A few questions are listed here:
> 1) What about tcp_send_active_reset() in TCP/MPTCP? Passing weird drop
> reasons? There is no drop reason at all. I think people will get
> confused. So I believe we should invent new definitions to cope with
> it.
> 2) What about the .send_reset callback in the subflow_syn_recv_sock()
> in MPTCP? The reasons in MPTCP are only definitions (such as
> MPTCP_RST_EUNSPEC). I don't think we can convert them into the enum
> skb_drop_reason type.
>
> So where should we group those various reasons?
>
> Introducing a new enum is for extension and compatibility for all
> kinds of reset reasons.
>
> What do you think?

I will stop repeating myself.

enums are not what you think.

type safety is there for a reason.

Can you show me another place in networking stacks where we cast enums
to others ?

