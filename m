Return-Path: <netdev+bounces-153372-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CAE79F7C8E
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 14:42:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 638BA1642DA
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 13:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF4FE221447;
	Thu, 19 Dec 2024 13:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SbC7YkqV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1901617836B
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 13:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734615736; cv=none; b=I7VtyW/zA7U4AaSLT9eTEalQelCDkCUGdBTQxAgj1d42y1NQHRfS5fj/RCyzDk+imj26zde3C0HwFfWm7Ck+drJJpvGdCOrbBypNPTnYr+3AcEeM5veS07l2faJUtzraJpxLt9GhDf5Ni/n6abj9XTYTvpdxMARw64pvc6Z1olI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734615736; c=relaxed/simple;
	bh=VjsGmRW5o8SCoKTqlgc7YTpmtyrBEZbOY7HzFaTq9rQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QeDqr7brtNd2UaUFT9TCe+59WqwmgCUZ5gz+w15+vuSbF1TxHx6WmTXDa0DhTKUD2gVDTO7vvvf+6lnBNSznXBRqFsLbGOWxZnxNuuYl8Wkqbz6nfSiJlgeVofUdOklWZjkBr4KLNtnTylMx3Abp39ars3C6HPcNJUQnC3RyqIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SbC7YkqV; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aa6c0dbce1fso118680766b.2
        for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 05:42:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734615733; x=1735220533; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Js3Or7Y4AT5mIO1ZpHrDZfYf3Pu10TvWpxBmXNRsJcE=;
        b=SbC7YkqVckyi7ZjtVhqroKcqdeuWEHrvggfbBRCFI5R3X8Nsgt4lijSKBOY5+o9REA
         KofiP6RC/puanI5RZdXKDSQfnhw8VrIDj8RZ54LHZVrMu4JuhtcPbqRLa+Ze4izBdrnV
         IvYc6o9XEDAnd5TdwrCbNLMO2Owo0OwJO7NFefttlkU1Y4HlR++uOgymg6snS/0L3iVu
         lHEr95lbUo2S2cENxwCRD30kvxcCQ3EGoAEiSHtsUVRewhLfhsKrif+f7UO/R+WTV+h6
         gUFO7RixU7PdzSx5W0ICIAPZUFBB3wXpDCGLyoieBHs1g0oVs4T0QVq3yff/dlYGiANm
         hzqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734615733; x=1735220533;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Js3Or7Y4AT5mIO1ZpHrDZfYf3Pu10TvWpxBmXNRsJcE=;
        b=huko2421JHPIGNhVCxAOlK6AYBYe91jDQypqigeGhHk2OWR1ODBCh4Yt0+sPySwRqr
         76CyucMgU3OnBQ4EclE2uU9ffGh1cosDG7u2eNd9drmEKb1cL6KrL+N72TLae/EhWLeG
         qmhnU/ibZU3QHYtPxGHDLodZmt06p/7IAGJjQrEYVGNBCKG6RcQ3E7+nFLse0XjLq1nk
         gdzMdfHWqr6RMceNnPC7LKdiCBUwCKVhugSM107xhsDV65v5hd1K+ndnIBeP58eQIU8o
         8f/HNcyulWFK8s6Rl4engVW0TGumLpuE/IzrJ/Z59f4guvX135TjCENAOZZrkJ0VPJ8n
         vrLA==
X-Forwarded-Encrypted: i=1; AJvYcCXphHFcRTNBO5CG78yY+6aSvHP/MlUYlbI/yH547gq8gQwBUpYpWjzWD2jhsY8WYswPDP1ifmQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBvPBFZ+M1sme90raBbuK0Y72L2VJTSy9FeafpcB7uhLL7orhP
	E2HC+qqGTuui6Y1PSYhb/gF0zu9W7TyotDr+F3yUiAA3um1x4h5Z5kq+EZYVHVpJEGrMnPiPBkR
	knPKNtcduiPRN2/MtVQgnvkz/ALgUTz+KjgCx
X-Gm-Gg: ASbGncv8b5/i8c76qsRAXogal/eHtIjhswFACGMc+gVFjJCNDqr9ZDy6ZWAt6Gm+OK7
	dyiY+vwnqBTlRsMI6yCt2cEUN/uAWHHS9qzr5A59mXT0viJ+MBexe0xW9c3Bx7pBEvlE/DHfa
X-Google-Smtp-Source: AGHT+IE1W5u/+Nu5prrardWyjBgew5IvPzTsJYKtnJWM46Vp+Xx846bdejQtJJdgORN3nByJEF42UCXpZ4jnf7pZzfk=
X-Received: by 2002:a05:6402:354c:b0:5d0:cfad:f71 with SMTP id
 4fb4d7f45d1cf-5d802642c1fmr6358212a12.32.1734615733069; Thu, 19 Dec 2024
 05:42:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241219132644.725161-1-yuyanghuang@google.com>
In-Reply-To: <20241219132644.725161-1-yuyanghuang@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 19 Dec 2024 14:42:02 +0100
Message-ID: <CANn89iKcVDM-na-kF+o3octj16K-8ZRLFZvShTR_rLAKb-CSoA@mail.gmail.com>
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

On Thu, Dec 19, 2024 at 2:27=E2=80=AFPM Yuyang Huang <yuyanghuang@google.co=
m> wrote:
>
> Corrected the netlink message size calculation for multicast group
> join/leave notifications. The previous calculation did not account for
> the inclusion of both IPv4/IPv6 addresses and ifa_cacheinfo in the
> payload. This fix ensures that the allocated message size is
> sufficient to hold all necessary information.
>
> Fixes: 2c2b61d2138f ("netlink: add IGMP/MLD join/leave notifications")
> Cc: Maciej =C5=BBenczykowski <maze@google.com>
> Cc: Lorenzo Colitti <lorenzo@google.com>
> Signed-off-by: Yuyang Huang <yuyanghuang@google.com>
> ---
>  net/ipv4/igmp.c  | 4 +++-
>  net/ipv6/mcast.c | 4 +++-
>  2 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/net/ipv4/igmp.c b/net/ipv4/igmp.c
> index 8a370ef37d3f..4e2f1497f320 100644
> --- a/net/ipv4/igmp.c
> +++ b/net/ipv4/igmp.c
> @@ -1473,7 +1473,9 @@ static void inet_ifmcaddr_notify(struct net_device =
*dev,
>         int err =3D -ENOMEM;
>
>         skb =3D nlmsg_new(NLMSG_ALIGN(sizeof(struct ifaddrmsg)) +
> -                       nla_total_size(sizeof(__be32)), GFP_ATOMIC);
> +                       nla_total_size(sizeof(__be32)) +
> +                       nla_total_size(sizeof(struct ifa_cacheinfo)),
> +                       GFP_ATOMIC);
>         if (!skb)
>                 goto error;
>
> diff --git a/net/ipv6/mcast.c b/net/ipv6/mcast.c
> index 587831c148de..b7430f15d1fc 100644
> --- a/net/ipv6/mcast.c
> +++ b/net/ipv6/mcast.c
> @@ -920,7 +920,9 @@ static void inet6_ifmcaddr_notify(struct net_device *=
dev,
>         int err =3D -ENOMEM;
>
>         skb =3D nlmsg_new(NLMSG_ALIGN(sizeof(struct ifaddrmsg)) +
> -                       nla_total_size(16), GFP_ATOMIC);
> +                       nla_total_size(16) +

While we are at it , can you use nla_total_size(sizeof(struct in6_addr))

inet6_fill_ifmcaddr() got  an EXPORT_SYMBOL() for no good reason,
please remove it.
Squash the following in v2, thanks !

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 2e2684886953d55140cd3d4a1e024b5218331a49..4da409bc45777f60fd37bdee541=
c61165a51d22c
100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -5239,7 +5239,6 @@ int inet6_fill_ifmcaddr(struct sk_buff *skb,
        nlmsg_end(skb, nlh);
        return 0;
 }
-EXPORT_SYMBOL(inet6_fill_ifmcaddr);

 static int inet6_fill_ifacaddr(struct sk_buff *skb,
                               const struct ifacaddr6 *ifaca,

