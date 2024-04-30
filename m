Return-Path: <netdev+bounces-92596-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A758F8B8033
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 20:58:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3476E1F23BEC
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 18:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06616194C7E;
	Tue, 30 Apr 2024 18:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HejenleR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687F319066F
	for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 18:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714503524; cv=none; b=GnsR+uqoySxBk7xqTATaoWsradTrrsOjJByRlVT91+8pVNu0EK1nuNORIv1l/vJkJOk6GGJD89cwAQNz8nTc7kiC6/Tta1MyllrlXIS7b/kDYUMAB3jIRfvpgESw6yEtx5BUOlvx+HaXuE9gGz5NwJCAsLiJVxzr7hRHTa+B9FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714503524; c=relaxed/simple;
	bh=OuZ+vJrLbeGtYxOSB8ljS2lb4omaQekHf/bf+zJRpuk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kISubeXVpxsY3Zw5+LdEhtdwE20HwHG/Zi2NDLgdZabvFKSO5M7BIcp/cO2pafhqHs9pu31hL5E2J3p0nBCA+WQQ0XFY9sB40qfpZbE3DTAaZExNxZL0lu8h1/x2jxZy2+Oqe3/777uIViaaNn67MoSxDr0p4FSl7tteVLy4la4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HejenleR; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-43ae23431fbso29641cf.0
        for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 11:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714503522; x=1715108322; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nQ+rZ7ZZR8BByTwd7Bt59ftccOpBwpO38HxauKI7qbE=;
        b=HejenleR/P2fHumpq1yiqIVSMOhehPQhzV5o015c3672zb4uV02vSIReqP79qBrtls
         uqLZKMk1sLn1w2UHmW7dmHkwj/o2fTsRdmgOyEV4U8BfHXDdIT1qsOZSWUvZyZvCzJ20
         jhtFK5KBXbyzQ6Sh4jZzixyT1IFIqMwcwhQVBJ1YSpxDfztzREPA8aRQGTz8Ab7A10FK
         L2RwMDxi0IxcupXZgZviPZR2SqOf44r+Ww6jQxRV0AZK+YSifvKkH9S3tb+7zILoFHAt
         6TwI72Yrzg5ZrYRzpktR0B0gub02i3xM1MgRa+AIyXWslv6u5ffFwiSqlZ3b3p44btbz
         gz/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714503522; x=1715108322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nQ+rZ7ZZR8BByTwd7Bt59ftccOpBwpO38HxauKI7qbE=;
        b=aoZM/rl4XRRGQ86mJT+LVOX/7ZDfmcupv7fVFOjYFUBN3trng1EvUnOa6QlEIlU1eE
         E1A+2u7pfLjwhi02E+UiGZ9si8H5BqOu+zJED7UAlikN938E458BJLzSyU057eVXUSSm
         /x9kQLiAn1NXUxI3UowqC1fzL2UVlXL3iCrlwSCpLSHirIAiF8obRGn4SvhunyYzch/6
         /cuU+Ohgf8NH5cJelYINJJjkjuhcIyu4N2moZoeXmbaujJ0TNkQScV3Xkp+42JVjkpbP
         r756wGjvVlsgiN3kCdb6JBdNfP+F2IQJFS5dT7QLhlyRxgUyQqjAAo/YXTWgSJ3PvbZM
         Jm+g==
X-Forwarded-Encrypted: i=1; AJvYcCVvgjItzwJj+WEWmxLIep4KmBYSwp/BCeWAg35dSIOUDGHx7vnUR5Uzx6LeIY4yZxjZyFDlhWVlQvum9xETomXziEkBh6vl
X-Gm-Message-State: AOJu0YxCpusdvTPGqLat+yaF+SLj8K5+TmOPPbrdSqchdvXZLtgHA1AY
	0dZTkBJlDxb5L9tA1sRq6w1PoURS9NhYkkKkMC8zQkJXDcITPSYNTf/UjvwnNsWRZC4FHShuBHQ
	PgUDl7ueDAMNQNZNJfk1JJtrphPs551i5bVIX
X-Google-Smtp-Source: AGHT+IFPjSmF1WmEcQHf3qwZ+quaZxS0pAZOiwfgm1e3V9HZ0INhyR3DGp8DSW5umGiczxdRVyo0Pno2t21S77GJz1U=
X-Received: by 2002:ac8:5782:0:b0:43a:b208:7cd9 with SMTP id
 v2-20020ac85782000000b0043ab2087cd9mr41214qta.0.1714503522109; Tue, 30 Apr
 2024 11:58:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202404032311454058957@163.com> <CA+FuTScLvHFVqC-kqWdR9fWaLc_S=7SGMEhq09kKgZDQ0AtAfg@mail.gmail.com>
 <202404302224033314733@163.com>
In-Reply-To: <202404302224033314733@163.com>
From: Willem de Bruijn <willemb@google.com>
Date: Tue, 30 Apr 2024 14:58:04 -0400
Message-ID: <CA+FuTScLNosPjZvo4vPaq1A7ZJGdA1svc+hhxz25g=uwQxWgGg@mail.gmail.com>
Subject: Re: Why not replace NETIF_F_UDP_GRO_FWD and NETIF_F_GRO_FRAGLIST with
 the same trick used by NETIF_F_UDP_GRO_FWD and rename it NETIF_F_UDP_GRO?
To: Shi Xudong <shixudong@163.com>
Cc: "alobakin@pm.me" <alobakin@pm.me>, "kuba@kernel.org" <kuba@kernel.org>, netdev <netdev@vger.kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2024 at 10:24=E2=80=AFAM Shi Xudong <shixudong@163.com> wro=
te:
>
> i understand:
> - both NETIF_F_UDP_GRO_FWD and NETIF_F_GRO_FRAGLIST is off - no UDP GRO;
>  - NETIF_F_UDP_GRO_FWD is on, NETIF_F_GRO_FRAGLIST is off - classic GRO;
>  - both NETIF_F_UDP_GRO_FWD and NETIF_F_GRO_FRAGLIST is on - fraglisted U=
DP GRO.
> and
> Plain UDP GRO forwarding even shows better performance than fraglisted UD=
P GRO in some cases due to not wasting one skbuff_head per every segment.
> but i have a question?
> Why not replace NETIF_F_UDP_GRO_FWD and NETIF_F_GRO_FRAGLIST with the sam=
e trick used by NETIF_F_UDP_GRO_FWD and rename it NETIF_F_UDP_GRO,

What trick are you referring to?

> implement local input and forward using plain UDP GRO packets, because "C=
lassic" UDP GRO shows better performance when forwarding to a NIC
> that supports GSO UDP L4.

There are three targets for UDP GRO
1. local sockets
2. forwarding without hardware offload
3. forwarding with hardware offload

Non-fraglist is preferable for 1 and 3. But at GRO time it is not
possible to distinguish between 2 and 3.

This discussion is largely independent from the below bug report.
Those need a narrow fix, not a feature change.

>
> ________________________________
> shixudong@163.com
>
>
> From: Willem de Bruijn
> Date: 2024-04-07 06:35
> To: Shi Xudong
> CC: alobakin@pm.me; kuba@kernel.org
> Subject: Re: fix bridge,bonding,team: advertise NETIF_F_GSO_SOFTWARE and =
extend NETIF_F_GSO_SOFTWARE include NETIF_F_SG,NETIF_F_FRAGLIST
> On Wed, Apr 3, 2024 at 11:11=E2=80=AFAM Shi Xudong <shixudong@163.com> wr=
ote:
> >
> >
> > According to https://github.com/torvalds/linux/commit/2e4ef10f58502323e=
a470bc30ba84d5ddd4e77f0
> >
> > bridge,bonding,team  seem to  use netdev_increment_features to fix logi=
cal netdevs'feature,cause them to lose the NETIF_F_GSO_SOFTWARE feature (un=
less the real netdevs have the NETIF_F_GSO_SOFTWARE feature).In addition, p=
lain UDP GSO/GRO, like TSO,  also relies on NETIF_F_SG.
> > UDP fraglist GRO/GSO also depends on NETIF_F_FRAGLIST.
> > Therefore, the following two modifications are recommended for bridge,b=
onding, and team:
> > 1.netdev_features.h
> > #define NETIF_F_GSO_SOFTWARE (NETIF_F_ALL_TSO | NETIF_F_GSO_SCTP |     =
 \
> > +                                 NETIF_F_SG | NETIF_F_FRAGLIST | \
> > NETIF_F_GSO_UDP_L4 | NETIF_F_GSO_FRAGLIST)
> >
> > 2.netdevice.h
> > -/* Allow TSO being used on stacked device :
> > +/* Allow TSO/USO being used on stacked device :
> >  * Performing the GSO segmentation before last device
> >  * is a performance improvement.
> >  */
> > static inline netdev_features_t netdev_add_tso_features(netdev_features=
_t features,
> >                                                         netdev_features=
_t mask)
> > {
> > - return netdev_increment_features(features, NETIF_F_ALL_TSO, mask);
> > +      return netdev_increment_features(features, NETIF_F_ALL_TSO|NETIF=
_F_GSO_SOFTWARE, mask);
> > }
>
> Thanks for the report.
>
> Happy to respond, if you don't mind me cc:ing the public
> netdev@vger.kernel.org list.
>
> The list has more experts on this code, and such discussions are
> better public and archived for later understanding.

