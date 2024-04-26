Return-Path: <netdev+bounces-91737-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BEBB8B3B12
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 17:21:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E58711F21CCE
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 15:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3894E152DEA;
	Fri, 26 Apr 2024 15:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XpGQ68Oh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB47152DE6
	for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 15:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714144605; cv=none; b=QGpSDjjZWydieyu7S+DjHST2NhS/n/45vt2nR1LqlZ6Z4YKt7ZIL25KOn13nMb0VbpH5I9cJ4jMVLp0s9hrpTAVSV8+kb1RR8wBaDsKq40MoFuksdB4a4yzdlsR+5J3ciG77pU7Pqtr85uihzfg4cF3xqEwHaGJC49jSeL58QFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714144605; c=relaxed/simple;
	bh=52NS2g1KD8hJOKVFf0MsuYdBtEwXJu4rqvGFyLuj0OI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EAEc6d7DD+CeyEHWd/Uk+ITZBS84X15evZe9uA1wV/iFS714I5FQx3m53kj+dFNtJqK5cQPZNW8B+vbHzD+4aU0ClhpXRlXO60wiC1zwgQ+NI3f5RrdDZTJgWg+sZd5QAsLzVjuXq6xjFkifqI5zUJTXYRan4PTu+gWkIlb/f0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XpGQ68Oh; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5722eb4f852so13655a12.0
        for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 08:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714144602; x=1714749402; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NOnIr4UfbNTpfA2ZOEzid7tljIfUuB2BE2DAQjNPAXY=;
        b=XpGQ68OhQSpVN3+isebv98HZmoNpWLk1G0BmywdJcaNUXP8BiH1gLyvQGgSBqDL7nl
         mdgse5DSiEUVP2zehXETMZgv8ob76I/8phbuq86OyrA+fxfV2xJQOJG/YyW8Yv2eg6sS
         pGsCIvifVeSbAlkz4KP1IvYUgdKloC8xue4Ip9SvqHSif7gEs5ov+YUmHCAXkZO/LtGE
         8FMtmbHmOgg8wnCdhyZv81GZT7XHPQEUsQPJ2KxmMEnD6DoSKrJ0SA1E25nSBYuZ5DRZ
         7Z9jvHt/LefFASckMvC7f6nTw7M8saU6dPt1kfJ0G+TC+4q/VNkmXDvFtUWbLKSKvnYD
         0C7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714144602; x=1714749402;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NOnIr4UfbNTpfA2ZOEzid7tljIfUuB2BE2DAQjNPAXY=;
        b=sMIQ7KW4pU7imefyZGupvbIq6ev62sD+k3WCu2zr6WLB9fvEwGssoPk0AirUmicUUQ
         vvHu6P6qygX+2+wOpns7lcwahCJFP3xBif9Agt1WOdRZA47JK+JnPuMMYRTxntAFFhm2
         3BfwHQS2Oc0uWh6KuFITWIy85ziNlc+4GjXvN/Hzchf53/0/5JT68a6jWqhJ1Pvx8OjW
         5RXRrkSXg4dnJ9PP00nEEtpYh1qlOjyFDS1QDpjk961d2oeCn6JmP6E+NQ9C8S1X8mOj
         g2OQcMmiv0GSRIfokg8VdWYhl0eH8te97WS6chxQHpMCp1cgiYE4G+PqUghRqM8xFpc7
         LhEQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9XFoTopUb/Y9NrMb1S21r6CU+LoMapSDIYKBZ9/3TEr+pL+QaDIjts8dTfndhnBJyRXl6JvD/znY72qxy7OA2hzLzcn1e
X-Gm-Message-State: AOJu0YwrktPKIh8DKu+ecv2s1mpv8qs/V95Fo0jpyHl5o3Ahs5IrPsDb
	4dCtjqm6IddrYiZDZJd4/35QWWTyJ7lV3De0LZ8HrnT9Yt/Thx2E3hcz8K/vrywbhQf//Hxy48O
	AMJf9yxGmzRdermlf7Zdk+qcUX8UvgLxw+VKt+ps/D0gD3UTQ6rLg
X-Google-Smtp-Source: AGHT+IHSqE0vqq5ym6FYPWPkFlLSvzXKQJRQ+SXij6mTLU7Y1injxlicwdQQFQbDxP2b5HeUrYBBfAalP3PCHoLFPG8=
X-Received: by 2002:a05:6402:f93:b0:572:6012:551 with SMTP id
 eh19-20020a0564020f9300b0057260120551mr39491edb.0.1714144601427; Fri, 26 Apr
 2024 08:16:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240425165757.90458-1-edumazet@google.com> <9fa615a8-3b5e-4cd2-ba76-f72d908c32b7@kernel.org>
In-Reply-To: <9fa615a8-3b5e-4cd2-ba76-f72d908c32b7@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 26 Apr 2024 17:16:27 +0200
Message-ID: <CANn89iJmmxOfgJAz=COR8-PLEFarogLs1H2vjp0tWLf0R=dxxg@mail.gmail.com>
Subject: Re: [PATCH net-next] ipv6: introduce dst_rt6_info() helper
To: David Ahern <dsahern@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2024 at 5:09=E2=80=AFPM David Ahern <dsahern@kernel.org> wr=
ote:
>
> On 4/25/24 10:57 AM, Eric Dumazet wrote:
> > Instead of (struct rt6_info *)dst casts, we can use :
> >
> >  #define dst_rt6_info(_ptr) \
> >          container_of_const(_ptr, struct rt6_info, dst)
> >
> > Some places needed missing const qualifiers :
> >
> > ip6_confirm_neigh(), ipv6_anycast_destination(),
> > ipv6_unicast_destination(), has_gateway()
> >
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > ---
> >  drivers/infiniband/core/addr.c                |  6 ++--
> >  .../ethernet/mellanox/mlxsw/spectrum_span.c   |  2 +-
> >  drivers/net/vrf.c                             |  2 +-
>
> missing drivers/net/vxlan/vxlan_core.c, vxlan_xmit_one

Thanks, I will squash in v2 the following:

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.=
c
index 4bbfb516ac05bc8fd86177851bf29b98d48fa164..a9a85d0f5a5d8b07dc24bbe6ebc=
84e68b8d604d4
100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -2513,7 +2513,7 @@ void vxlan_xmit_one(struct sk_buff *skb, struct
net_device *dev,
                }

                if (!info) {
-                       u32 rt6i_flags =3D ((struct rt6_info *)ndst)->rt6i_=
flags;
+                       u32 rt6i_flags =3D dst_rt6_info(ndst)->rt6i_flags;

                        err =3D encap_bypass_if_local(skb, dev, vxlan, AF_I=
NET6,
                                                    dst_port, ifindex, vni,
diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index 1de942d7abc70d66c31023657c3a1745e5cdbb20..5f17a2a5d0e33780f59d85238b1=
4b971b5ab0eda
100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -956,7 +956,7 @@ static inline struct dst_entry
*qeth_dst_check_rcu(struct sk_buff *skb,
        struct dst_entry *dst =3D skb_dst(skb);
        struct rt6_info *rt;

-       rt =3D (struct rt6_info *) dst;
+       rt =3D dst_rt6_info(dst);
        if (dst) {
                if (proto =3D=3D htons(ETH_P_IPV6))
                        dst =3D dst_check(dst, rt6_get_cookie(rt));

