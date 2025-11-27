Return-Path: <netdev+bounces-242296-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06582C8E770
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 14:30:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2873A3B152C
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 13:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D02526ED4F;
	Thu, 27 Nov 2025 13:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CiOB2sSe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011FF269AE9
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 13:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764250180; cv=none; b=HKyJH1FKxcbA5rj6vPQkmAH/Ay4VhQZg/Fo42pwFLF5FAEei0AS3VLDjceBLCFV16W1g6Yos0wEXWQhK/ZkANggzH4IbyGfx6ldHACjoIQxeshFaDKQTJN18ycB5zFT4NO8V+QRQgvISj/bEgX4aIWyu6sT/vyuZAHIZ+C47XaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764250180; c=relaxed/simple;
	bh=T0k6LeJ5oLeqXJ8ppKB2TmvacdWxh0+b9xsZkfWINxg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N3WsQYYyAl1+djl/aZRtqfxJk4TW0IjPSlQJpmqGLQiwepX47QRg/KTHCqpaZG8IIk2Wb66RnoWLiRSEOmX4rf1cCeqnLMvmFDjFYy5crfCOtYeVOm1WTfbCCinAJp4mVfmnvsRsXKIqXx/I9ifIndUP9cjatONu31vkVzEXdS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CiOB2sSe; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-78ab03c30ceso7978717b3.2
        for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 05:29:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764250178; x=1764854978; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CCG84odQYbmqLqvf+/rxN52Xhfd3eI4U/Ar5xvc78lQ=;
        b=CiOB2sSeqAzs0EZiweC+JE2cWJhO3u8xf7fK2pn/Yp5vnnRHodmo1C3+RXxlQStcKK
         L1d9GybFVhFoIEF8ooVn0xGICKagF4qWvPR5o2bX3GhzvPttsuWQBGtsEo60eP2k2dyR
         KH0RWDGvwHCk2Lwxr5BzKm1FyZhZoZmqJFJP9aEu0Q7XpJ/8jTJ+IlZQYC+prfesJPZk
         l0zjeLC8af+APw9l8U2YSnrnks9D0NBnbTAR73xIS/PzNdDimRrZiFPG8stB9WtqmShx
         wKHrxxQjcwE79NzePbMBaeJwc8pCs+skCZ4g6cuGKtsU/KCV1PYMARBklz0IYk03FIae
         rLJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764250178; x=1764854978;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CCG84odQYbmqLqvf+/rxN52Xhfd3eI4U/Ar5xvc78lQ=;
        b=J5iWHcNZEP7IuPiuQAVrDjo+oqI03pbPj+EkkUhmeQLp5pL8XB2LLslTi9zUEaAj06
         y+gGXguRA95VWRI2zBlZqApMwig0SAQbwEorjkVIEax8sAkIuEChbOCO+KJc/VGqHhOL
         jREcy8bytaQU/cDyvSdg33RyLJrVFZI3QRoiJ1xzU6FOXXd3JSQKmu+MjjvZlq79JAhL
         djLTpXUZpeILSS1dy6TTKL4N+bDAgawwBOnsgVoG+jXKVyU46IOMYzD+Ws1Nmf7YWWtI
         SxILDbhhJMYedIB0/Oi0RLF+Ccggs07frTUhxcMFKogGqkOAjMebaXQj569E6BBOYqKu
         pHpg==
X-Gm-Message-State: AOJu0YwDeAiteSDc9IAdMvLyI41GE0HXjPn/1zNdSomxPLnLz0dzBuMR
	6XadeWqJRJAlfdt4H6mbriCXrZdOsfe52ul27wXs4EROeXGE2vQ4sEWLUxbm8ReUKExpBVSDNav
	xM0aW4RA+/fyzvSrkK4Bw/xHsuocRMtk=
X-Gm-Gg: ASbGncvxXSe1svyFFEGaPGMGWht8gULqBn6yObKAsk3vXZz98GeEgsXDRb/910+Xiv8
	32KA7WvaZqjS4JIxaENYVH+WeGyNOx9SomWusc/5JN8900x/zHwRKCgPZej5k+WqeGJVnC0SMdL
	VgwIUF52G3oSipnICB9VfVH349nIJiYs41pgnq4AA/KYMulFhjgzNBnDjqmED2rmqkNXiowqb9t
	7YOficcg9Zs/Cm7JFHwCQjltTP68IJrtQ6j7ymd/RzTo86ehdiS3OicfUnxb4lveAicyQt4Quwa
	nCuG
X-Google-Smtp-Source: AGHT+IHpTUa2hqHESyAtNwL998ANNhr9hkzafHdwjgOrlK+xkRt/nphLe+rAq5wP0pUgv4QW71MAHijRtBHDq6YGp1o=
X-Received: by 2002:a05:690c:9c01:b0:788:763:17c5 with SMTP id
 00721157ae682-78a8b47a778mr198344097b3.12.1764250177889; Thu, 27 Nov 2025
 05:29:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251127120902.292555-1-vladimir.oltean@nxp.com> <20251127120902.292555-3-vladimir.oltean@nxp.com>
In-Reply-To: <20251127120902.292555-3-vladimir.oltean@nxp.com>
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Thu, 27 Nov 2025 14:29:27 +0100
X-Gm-Features: AWmQ_bmB5J_RQTCPPSgUUrXYs-CXaJ8DU1cXNXQ_EBeTsKzMtWtmjgKRtGanjXQ
Message-ID: <CAOiHx=miR4JAbnYeRJwcHowgBUmvCn4X19syCxuwk8N7=xAXRQ@mail.gmail.com>
Subject: Re: [PATCH net-next 02/15] net: dsa: tag_brcm: use the
 dsa_xmit_port_mask() helper
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 27, 2025 at 1:09=E2=80=AFPM Vladimir Oltean <vladimir.oltean@nx=
p.com> wrote:
>
> The "brcm" and "brcm-prepend" tagging protocols populate a bit mask for
> the TX ports, so we can use dsa_xmit_port_mask() to centralize the
> decision of how to set that field. The port mask is written u8 by u8,
> first the high octet and then the low octet.
>
> Cc: Florian Fainelli <florian.fainelli@broadcom.com>
> Cc: Jonas Gorski <jonas.gorski@gmail.com>
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
>  net/dsa/tag_brcm.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/net/dsa/tag_brcm.c b/net/dsa/tag_brcm.c
> index eadb358179ce..cf9420439054 100644
> --- a/net/dsa/tag_brcm.c
> +++ b/net/dsa/tag_brcm.c
> @@ -92,6 +92,7 @@ static struct sk_buff *brcm_tag_xmit_ll(struct sk_buff =
*skb,
>  {
>         struct dsa_port *dp =3D dsa_user_to_port(dev);
>         u16 queue =3D skb_get_queue_mapping(skb);
> +       u16 port_mask;
>         u8 *brcm_tag;
>
>         /* The Ethernet switch we are interfaced with needs packets to be=
 at
> @@ -119,10 +120,9 @@ static struct sk_buff *brcm_tag_xmit_ll(struct sk_bu=
ff *skb,
>         brcm_tag[0] =3D (1 << BRCM_OPCODE_SHIFT) |
>                        ((queue & BRCM_IG_TC_MASK) << BRCM_IG_TC_SHIFT);
>         brcm_tag[1] =3D 0;
> -       brcm_tag[2] =3D 0;
> -       if (dp->index =3D=3D 8)
> -               brcm_tag[2] =3D BRCM_IG_DSTMAP2_MASK;
> -       brcm_tag[3] =3D (1 << dp->index) & BRCM_IG_DSTMAP1_MASK;
> +       port_mask =3D dsa_xmit_port_mask(skb, dev);
> +       brcm_tag[2] =3D (port_mask >> 8) & BRCM_IG_DSTMAP2_MASK;
> +       brcm_tag[3] =3D port_mask & BRCM_IG_DSTMAP1_MASK;

Since this is a consecutive bitmask (actually [22:0]), I wonder if doing

put_unaligned_be16(port_mask, &brcm_tag[2]);

would be a bit more readable.

Or even more correct put_unaligned_be24(port_mask, &brcm_tag[1]), but
we don't support any switches with that many ports.

Best regards,
Jonas

