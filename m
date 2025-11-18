Return-Path: <netdev+bounces-239625-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A9130C6A858
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 17:10:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 5F8E62BCEE
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 16:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE9435BDAF;
	Tue, 18 Nov 2025 16:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RhPifpLs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFEBA35BDBF
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 16:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763482224; cv=none; b=ggSY5L7ntAffQGSqiiWimeNJcavtJhSr1o5hkIWYN4Cc4eP7OqQWBoByCPo0bBKd8OOdQ9+DT66AU06Q6XVp4gg+OWzizukH+qJPFKfSBNsGh2tj4o9weWjvY8fZZTEY/7dKT0ACCe7rajzFjzCqEAKQEtiKVF6iJ3rM4ELncAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763482224; c=relaxed/simple;
	bh=NUvh3oFwvucPFBaKyU9+vVR5CpjTos+GGBfwyWNSCuw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MSxcKdl3HvYk7nycTGEw0f72NcA/uIyq0xKrIA5606PaDdXP3usWpb3FvW+xFprQrYiHsOASV+Z9cdDe4LBCmtVkWgBkSRYNT+dVtqvUEkMV5SVF9AEBCI+sOVzG1Ijo7oZvyNiT1DSfeu/EoaXYyBUL3ISr+fjSnrJnHVjah9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RhPifpLs; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-63fca769163so5299593d50.2
        for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 08:10:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763482222; x=1764087022; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sbGxx0sFlChPxrlyhelcyJ5YeacIctogxYVAUQD99jQ=;
        b=RhPifpLsRcHfiNGxYyEJAZO6yQz9mJUHYfxVXrGVIDzM1ocXuG5gzQn9spijd5RQD0
         gZ7KR4Vf4LUk5r6jHWoo/Iqo+OHAfdjrC41HSMOkAn3zbgNAyP4YMwwOZXzYn301TzZ9
         dSOiIVp6T38aqU9cHTW2Hc9hILq/dRnpgbfG6Z9JTx4wK+G+UengBsGlwRfaeg1bFQLL
         6n4GDmMTUTMZ3D3dloZ/LeF5ppAGv0wNfTT4bovxZl7Qvyk0fxviuNKdG4XAcVWquUoE
         1Epxoa+vVthd0/2XxdcruMQyOIg/G0cK49vCPyqV5kyeXv0JtjKkfjMiuPmOi8Jl/ShM
         JMWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763482222; x=1764087022;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sbGxx0sFlChPxrlyhelcyJ5YeacIctogxYVAUQD99jQ=;
        b=btmNxyyyE9i/Mb8hExrzw7lPaFIjRP90oX8NW2qyypfWAQTzDe/qvNFp5TXi2pSFWj
         m+U2NAwLayZG2SOb/fssLy2ANkK6u494XxHZJOePgvojWUrzsUMJ+lJIrb0sg5dCItJJ
         KDka2dgUr2ATXgSljG4q5HlCcyPKQEBmv5fWWOzUg1RX/zQQ0wlP2etJPuHpjSSjBNM1
         zAr3IYDsLHfXVgMLF7hbqcinPAZgYzpkwvGLM2H0+bxoYO8QDJHuNFH9AGbSqSyOp3cQ
         kNx8b7Y1jkPPvt9E1/SPoJLWDZbRir1N6jkdhLZdzjkBaq8rq/D0idzpCWS922SK0uNl
         JcYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJ+DKdfsR0H++aVB2XdFpEUWOwGvcFZHg82jCUEawMKZAMcMeE5FW4FbD4GTPqDbs7TZnEjrk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeO5dPrdw/rATtndK5JAiwbf426n8mLdl3HwJCMdpvjagcZPqB
	LDrusbo9wNzjpuxiHmwTaG1YFrsZ66FkBFfBCTkuW7pDIDShcilWWA/ITxRQWpN0Y65r4nHkjSh
	LvsOiXuUIpuS2X5LW24f5QraXQdfW/t7dXv6jFC2V
X-Gm-Gg: ASbGnctjNHp+sNLAKcfWDobCtz6mVl2/WZTO5oe7bWcBMBkYiaiDvbeCSma2fb5D5ry
	Bn9EpWTV81BcLSQzInJuGgBOGFvKo8MoRvfMnM/1nYX79EpFl/DyKkXvpmVgVwV0E9ltbrqiEsv
	olrcYhBXVpk0LoUR/KyjOK2VDoWx0nAiOKnf1EQNwBeOUHSvqBFulKhkUud/TI/kx0SUIJgmbX5
	ehZC5IMxf+8BGqtqd5LdvMs5M518euMv+rjE9igGkASjwU8JoHCTsuCXAFY6C0kRaSj9rA=
X-Google-Smtp-Source: AGHT+IGffyRS/PzBKS9OrEGqMXRLcwzJpDJZOHxS6An3s5Y7qg7GTAP7CGrgLXj8OzqD42jv0oAe8zimZjDRVj9OyCQ=
X-Received: by 2002:a05:690e:1583:20b0:63f:b4d8:1f4b with SMTP id
 956f58d0204a3-641e75e61a0mr11388755d50.33.1763482221444; Tue, 18 Nov 2025
 08:10:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251117132802.2083206-1-edumazet@google.com> <20251117132802.2083206-3-edumazet@google.com>
 <CADVnQyk4=w-Qbw24na3_09SRfbP3w+W9trzhd2vOLfeVui8-BA@mail.gmail.com>
In-Reply-To: <CADVnQyk4=w-Qbw24na3_09SRfbP3w+W9trzhd2vOLfeVui8-BA@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 18 Nov 2025 08:10:10 -0800
X-Gm-Features: AWmQ_bmf7lrO2xE3phzvNKKNoYUv8YKmDhAtaEwm118XnmDNCQwFdPiU2FlQvQk
Message-ID: <CANn89iLeRbVWxBOXRRmLNqiF8Lz3-iykCzkVE=_JR7GEycyhSw@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] tcp: add net.ipv4.tcp_rtt_threshold sysctl
To: Neal Cardwell <ncardwell@google.com>, Rick Jones <jonesrick@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 18, 2025 at 6:04=E2=80=AFAM Neal Cardwell <ncardwell@google.com=
> wrote:
>
> On Mon, Nov 17, 2025 at 8:28=E2=80=AFAM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > This is a follow up of commit aa251c84636c ("tcp: fix too slow
> > tcp_rcvbuf_grow() action") which brought again the issue that I tried
> > to fix in commit 65c5287892e9 ("tcp: fix sk_rcvbuf overshoot")
> >
> > We also recently increased tcp_rmem[2] to 32 MB in commit 572be9bf9d0d
> > ("tcp: increase tcp_rmem[2] to 32 MB")
> >
> > Idea of this patch is to not let tcp_rcvbuf_grow() grow sk->sk_rcvbuf
> > too fast for small RTT flows. If sk->sk_rcvbuf is too big, this can
> > force NIC driver to not recycle pages from the page pool, and also
> > can cause cache evictions for DDIO enabled cpus/NIC, as receivers
> > are usually slower than senders.
> >
> > Add net.ipv4.tcp_rtt_threshold sysctl, set by default to 1000 usec (1 m=
s)
> > If RTT if smaller than the sysctl value, use the RTT/tcp_rtt_threshold
> > ratio to control sk_rcvbuf inflation.
> >
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > ---
> >  Documentation/networking/ip-sysctl.rst         | 10 ++++++++++
> >  .../net_cachelines/netns_ipv4_sysctl.rst       |  1 +
> >  include/net/netns/ipv4.h                       |  1 +
> >  net/core/net_namespace.c                       |  2 ++
> >  net/ipv4/sysctl_net_ipv4.c                     |  9 +++++++++
> >  net/ipv4/tcp_input.c                           | 18 ++++++++++++++----
> >  net/ipv4/tcp_ipv4.c                            |  1 +
> >  7 files changed, 38 insertions(+), 4 deletions(-)
> >
> > diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/net=
working/ip-sysctl.rst
> > index 2bae61be18593a8111a83d9f034517e4646eb653..ce2a223e17a61b40fc35b25=
28c8ee4cf8f750993 100644
> > --- a/Documentation/networking/ip-sysctl.rst
> > +++ b/Documentation/networking/ip-sysctl.rst
> > @@ -673,6 +673,16 @@ tcp_moderate_rcvbuf - BOOLEAN
> >
> >         Default: 1 (enabled)
> >
> > +tcp_rtt_threshold - INTEGER
> > +       rcvbuf autotuning can over estimate final socket rcvbuf, which
> > +       can lead to cache trashing for high throughput flows.
> > +
> > +       For small RTT flows (below tcp_rtt_threshold usecs), we can rel=
ax
> > +       rcvbuf growth: Few additional ms to reach the final (and smalle=
r)
> > +       rcvbuf is a good tradeoff.
> > +
> > +       Default : 1000 (1 ms)
>
> Thanks, Eric! The logic of this code looks good to me.
>
> For the name of the sysctl, perhaps we can pick something more
> specific than "tcp_rtt_threshold", to clarify to the reader what the
> RTT threshold is used for?

I forgot Rick Jones suggested   tcp_autotune_rtt_threshold .

>
> And if the name is more specific about what the threshold is for, then
> in the future if we want RTT thresholds for other behavior (e.g.,
> tuning the tcp_tso_rtt_log code or other future RTT-based
> mechanisms?), then it will be easier to add those future RTT
> thresholds without the names seeming confusing and error-prone?
>
> With the existing "tcp_moderate_rcvbuf" sysctl in mind, how about a
> name like "tcp_rcvbuf_low_rtt"?

I am not good at names, maybe we should reconcile RIck suggestion with your=
s ?


>
> Then the description in ip-sysctl.rst could read as something like:
> "We can relax rcvbuf growth for low RTT flows (with RTT below
> tcp_rcvbuf_low_rtt usecs):".
>
> WDYT?
> neal

