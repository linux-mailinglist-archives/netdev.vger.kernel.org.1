Return-Path: <netdev+bounces-153375-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11DD89F7C97
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 14:47:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AB0E16C666
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 13:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 167F1221D8D;
	Thu, 19 Dec 2024 13:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Tq+vmf2U"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413861F8682
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 13:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734616075; cv=none; b=LeV45eDTNlkge+fPYMAdGSUFlo7poB9H3dNgE+OFNKg2r2mNTlonFxI3FQKz9vqLy4AP6vnTaYrS4rn2v2GDBsYKwZKhdb5foJqq8syN/UmjndaXBLyEG0D/6QZD0uJYiI2Kglil4FiDR9vwGcMHO15FANPJsQPUz1neePLIyzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734616075; c=relaxed/simple;
	bh=MT8x/bYQZO82HuqmkMLgIMy7IxdqzcbSIUulit+imdQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JIvX9Q1CLyiJE6gBh8g4fCDtlR3Bx3ZLoPqo2xjaYLgnUmXqgvuTVljPXyogjspOzXOu8Xfza0HUzEoGW1gawtIw68B9QaLgl6hibVfuAhD6aZezLyVd7f61hHCkA4AfxxpbJ0LPiGSAV1wo8y0Lg0AvsKWpPbdsQ7ePiH+1IpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Tq+vmf2U; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5d41848901bso1544551a12.0
        for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 05:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734616071; x=1735220871; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fZ9CV1/wp6JoubQpi0lWxwAIel7kXdfkiQxhD+fZamw=;
        b=Tq+vmf2UTszcQmfx8Y0S3HbdAutJpQ7w3Bc2Hxg7LFqHNyF0H0+SWdmRMbxbU26afc
         o4J+pGenslFO6nTbWFcEeeRFuUPZwXKIjK/nn0Q0mB8ZBGmxcU+iszI5lHlreW3LBEWU
         gFLN7gaokgoDyyUv0XYcCuZK3O9NOpTsr2M9qcKvYmEOvFJXZClmZD40asb4siYzG50R
         i9Da7HprnE3tC/RUZP5fNA/DBsHWJ2omvriSn6OqInm6aOi2Cuo6gpgjP4zuElBrfNGu
         lybH5OlfIqkARPOYzoHRTO6R7SzBnmz/83kjHohjHjJg8BpTHyY3evjDQNwCGIztFOWY
         YPQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734616071; x=1735220871;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fZ9CV1/wp6JoubQpi0lWxwAIel7kXdfkiQxhD+fZamw=;
        b=f6wPaDNNSo3Q81S2VpQ1vLv0AuYdKgNrV2eE51e+PxH48uZHHpQGevVAFymThCWXpp
         hCxrnkF9CXmN+VQsi4Ggu5l8ySoSr7Akur8vDfXy6+j9rr20CBcss22rDK5jSZzGelDz
         vHII6+6ITHGaauzIlmWIONc8R91N3dgK62pJ1ZGP/WzZlj4ct09T7Bf/GK8pHT2DD5EP
         20c1li079cT58M9DR/FDetU4sSlYtaLFQXsCjRMV0C3q7SerEyPhVywdW8A3d0BBg5n8
         zAVVDDbCnGJbaYrtVnQ4KsXKapCovKgYqKgDKpAHF0IxK8Bw4ngh8CtSojbe8ensIbod
         xAyA==
X-Forwarded-Encrypted: i=1; AJvYcCVUrCFz4GkDhnebyoSDzMbt7AwTYf1YuKhr9kmd4KZ8WQmIdfKnx28RT76WnbgwJU7+AT7dg6A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7066kRqIgX9itdXkgIlOgK6F0ewfOEVIrqvNTWYp95dbY/rrA
	JUJlbGBODq9jsCD2aW6Id9SqpfjIky/5cgPO5AIlzhn4LCPTRmKvV7o6PwMcWBofCTUT4tzZxVV
	EIM0ityOfmY/6Ebkt5zHhtd7Xq0fJWoEUjuCW
X-Gm-Gg: ASbGnctRqJDqC477FhQXPWvFWygws2bspPB+2ncW6SANI5d4fRliE4fQvSSBZPEXqet
	SEFE9m+2jwcBCOPxYsO1zdk/kJ/TwIPeGJhYYOyE0KVssXgOtUgGEWtjR89Rq7ZQVtVY1JzHx
X-Google-Smtp-Source: AGHT+IFMGODU4cPPeDG4CLRC0gGyCbte+OmoaJP3KyYW5zw1XeQKKg+h8vJoKiuSWNL6TDk3Bx8KI277vvnmYJ9H3A0=
X-Received: by 2002:a05:6402:4315:b0:5d0:f6ed:4cd1 with SMTP id
 4fb4d7f45d1cf-5d8023c7f97mr3082053a12.10.1734616069971; Thu, 19 Dec 2024
 05:47:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241219132644.725161-1-yuyanghuang@google.com> <CANn89iKcVDM-na-kF+o3octj16K-8ZRLFZvShTR_rLAKb-CSoA@mail.gmail.com>
In-Reply-To: <CANn89iKcVDM-na-kF+o3octj16K-8ZRLFZvShTR_rLAKb-CSoA@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 19 Dec 2024 14:47:38 +0100
Message-ID: <CANn89i+SMrCH1XqL8Q9-rr7k2bez1DNqeQNhO0rBrrHiyOrFXw@mail.gmail.com>
Subject: Re: [PATCH net-next] netlink: correct nlmsg size for multicast notifications
To: Yuyang Huang <yuyanghuang@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	roopa@cumulusnetworks.com, jiri@resnulli.us, stephen@networkplumber.org, 
	jimictw@google.com, prohr@google.com, liuhangbin@gmail.com, 
	nicolas.dichtel@6wind.com, andrew@lunn.ch, pruddy@vyatta.att-mail.com, 
	netdev@vger.kernel.org, =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>, 
	Lorenzo Colitti <lorenzo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 19, 2024 at 2:42=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Thu, Dec 19, 2024 at 2:27=E2=80=AFPM Yuyang Huang <yuyanghuang@google.=
com> wrote:
> >
> > Corrected the netlink message size calculation for multicast group
> > join/leave notifications. The previous calculation did not account for
> > the inclusion of both IPv4/IPv6 addresses and ifa_cacheinfo in the
> > payload. This fix ensures that the allocated message size is
> > sufficient to hold all necessary information.
> >
> > Fixes: 2c2b61d2138f ("netlink: add IGMP/MLD join/leave notifications")
> > Cc: Maciej =C5=BBenczykowski <maze@google.com>
> > Cc: Lorenzo Colitti <lorenzo@google.com>
> > Signed-off-by: Yuyang Huang <yuyanghuang@google.com>
> > ---
> >  net/ipv4/igmp.c  | 4 +++-
> >  net/ipv6/mcast.c | 4 +++-
> >  2 files changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/net/ipv4/igmp.c b/net/ipv4/igmp.c
> > index 8a370ef37d3f..4e2f1497f320 100644
> > --- a/net/ipv4/igmp.c
> > +++ b/net/ipv4/igmp.c
> > @@ -1473,7 +1473,9 @@ static void inet_ifmcaddr_notify(struct net_devic=
e *dev,
> >         int err =3D -ENOMEM;
> >
> >         skb =3D nlmsg_new(NLMSG_ALIGN(sizeof(struct ifaddrmsg)) +
> > -                       nla_total_size(sizeof(__be32)), GFP_ATOMIC);
> > +                       nla_total_size(sizeof(__be32)) +
> > +                       nla_total_size(sizeof(struct ifa_cacheinfo)),
> > +                       GFP_ATOMIC);
> >         if (!skb)
> >                 goto error;
> >
> > diff --git a/net/ipv6/mcast.c b/net/ipv6/mcast.c
> > index 587831c148de..b7430f15d1fc 100644
> > --- a/net/ipv6/mcast.c
> > +++ b/net/ipv6/mcast.c
> > @@ -920,7 +920,9 @@ static void inet6_ifmcaddr_notify(struct net_device=
 *dev,
> >         int err =3D -ENOMEM;
> >
> >         skb =3D nlmsg_new(NLMSG_ALIGN(sizeof(struct ifaddrmsg)) +
> > -                       nla_total_size(16), GFP_ATOMIC);
> > +                       nla_total_size(16) +
>
> While we are at it , can you use nla_total_size(sizeof(struct in6_addr))
>
> inet6_fill_ifmcaddr() got  an EXPORT_SYMBOL() for no good reason,
> please remove it.
> Squash the following in v2, thanks !
>
> diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
> index 2e2684886953d55140cd3d4a1e024b5218331a49..4da409bc45777f60fd37bdee5=
41c61165a51d22c
> 100644
> --- a/net/ipv6/addrconf.c
> +++ b/net/ipv6/addrconf.c
> @@ -5239,7 +5239,6 @@ int inet6_fill_ifmcaddr(struct sk_buff *skb,
>         nlmsg_end(skb, nlh);
>         return 0;
>  }
> -EXPORT_SYMBOL(inet6_fill_ifmcaddr);
>
>  static int inet6_fill_ifacaddr(struct sk_buff *skb,
>                                const struct ifacaddr6 *ifaca,

Also GFP_ATOMIC should probably be replaced by GFP_KERNEL.

All inet6_ifmcaddr_notify() callers are in process context, hold RTNL,
thus can sleep under memory pressure.

Same remark for inet_ifmcaddr_notify()

