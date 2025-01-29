Return-Path: <netdev+bounces-161484-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C57FA21CF2
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 13:07:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBE771883CF1
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 12:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDDE71B87FD;
	Wed, 29 Jan 2025 12:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IDV8yEUF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BE41B4257
	for <netdev@vger.kernel.org>; Wed, 29 Jan 2025 12:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738152425; cv=none; b=gkxW4EWldawr7K0mYl4z2soHow3m0fEfolhC00915VJytykDkO1gjc/Z8AeUQF8BNIuN/0j2xVA1TaX6Cm7fbJzGHfD98PpG/ncVSEbKP2ZsEB39udF6/0K7VNnpia1FOsK81qQ5wQd4L8Jou9dJx0/XQfMjnHcGcOW+5RaxooU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738152425; c=relaxed/simple;
	bh=ggOb6/bUg+LMTkchnpi/WaHmb/7Q+k9Unz/QsB8pkeY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QQvwdWKcRtYTDLhqV1en31o7eKOEKn1Qc+1lR4dWyzwm0MOMYGSvtwvEq2k4tgSzoR6BTvmqndCBQ0KdAKRD3xBoO9fcJWG6CY4YGmSf7OnE6Jogt7uXf82ojngnPJACMR4iwHsDOzckC81qrUnCn7xFBPxsycGuOBrM7der9EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IDV8yEUF; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5d982de9547so12839380a12.2
        for <netdev@vger.kernel.org>; Wed, 29 Jan 2025 04:07:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738152422; x=1738757222; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NebxqF6KGxF658993D454WxvQzrkg33HnseQyQvF1d4=;
        b=IDV8yEUFfIbDwcAZnPG6kVL1ZifAHzIde8mZC3b2a0w/07UEyVDDbOoHOic541rJyH
         TEMbEcanLeYco7PkozF+XgeBOrdnDmCfjwGt4YzjzhNCmLFKIno+GVHYGQCGrVarPbxX
         gjTWS7PguLGmKykXPQMSfAX9OlJDOXMUMPCX/Wy70gyuPw/UpGn4r5v2PNYeRJz8UbCb
         B6cTFWfgqIGZzo5lFK/Y2XH1fYmhWwGjha3j26xUxAnifjvpHBIkk0uJWRa817RAGjSr
         qtaLbpE/EIFxuF/aQVvtHoyhcqmuAjduUtIknSuNYu/bIkKpLx2GP7DzfIPG5jXeIxIX
         DBXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738152422; x=1738757222;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NebxqF6KGxF658993D454WxvQzrkg33HnseQyQvF1d4=;
        b=gD1vPtb0R45WpK81LH6Yq0qz3CmFlB/Mt3bK65BEH9eX+LDgrx6WntPoqJBFtOCV/Z
         IeMPyuYA6HLiGchgQ3r1MvGvRE+RzXaqIfNXHoDvRNGXRWQP8kXCakVwix2BUPL2/eOv
         ORB8ACWd/GJGwIhK4HZ0P1vYdqMVX6PWVvDyuK9yG2rBf7RS4gYDKW/+llJCFijEhJCy
         F9PQ/i4jLVDUlEIXFOOBZGyLNTCZzEJ6V8llDd4HS5HCgesauuvDpvSCnxMxgndpl1QE
         mtT37FQRnp4NRsAYDbP39UIlZKsM+nWCncu61PZgTGxCinwqsOlKWKUgPb5KldrR0fSd
         lxtg==
X-Forwarded-Encrypted: i=1; AJvYcCX5vS/jp8Wsd5XpfimyscO2QgOXDOjsC5J1l/uOmEIlI24uGBMN5L5G2RFai8EgsW4eq3qb0gA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/tLkO1eKfN7osFvtrXut3kRthxTp6ekWuymRpelsx/1t8DBEX
	j7HKUR5o8Kw+f669xJCmBp8loz2RH17t0m9h49Nd14m1xlErZyhX/A8eXGCBUigKbfNw0m/5F77
	HFBogEFs8dU/ViBONTLBQVI863QzOctBG4NGr
X-Gm-Gg: ASbGncvxDJoBuHJxrRNTeCu/GgXYJEUtIBrAVdQHTrnvXGwwn1MK17A3hvvwHECjUzG
	qxoIBDnws+pgEzXuG3OBkrJ9Kc1EmSoSQzTMQMGP2YhyzteYGmJ+TSRadXV1jOitVYsDBD3Slmg
	==
X-Google-Smtp-Source: AGHT+IEct2Sbjfz/YjmA2VqJVZp/+8WKqCF6kTdBLC3ruDlfqbhwLy++YOYPf+Y4reX3DUIz1TVNHTvsY+ba13Jhnic=
X-Received: by 2002:a05:6402:2683:b0:5dc:5743:5923 with SMTP id
 4fb4d7f45d1cf-5dc5efbd474mr2636818a12.3.1738152420518; Wed, 29 Jan 2025
 04:07:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250121115010.110053-1-tbogendoerfer@suse.de>
 <3fe1299c-9aea-4d6a-b65b-6ac050769d6e@redhat.com> <CANn89iLwOWvzZqN2VpUQ74a5BXRgvZH4_D2iesQBdnGWmZodcg@mail.gmail.com>
 <de2d5f6e-9913-44c1-9f4e-3e274b215ebf@redhat.com> <CANn89iJODT0+qe678jOfs4ssy10cNXg5ZsYbvgHKDYyZ6q_rgg@mail.gmail.com>
 <20250129123129.0c102586@samweis> <20250129125700.2337ecdb@samweis>
In-Reply-To: <20250129125700.2337ecdb@samweis>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 29 Jan 2025 13:06:49 +0100
X-Gm-Features: AWEUYZkT7_oOcIjlT-gANFIRGY6p6JSCNmW9QWucqiP6653Unlk6DXnMAIry1SQ
Message-ID: <CANn89iKSrG40FKLpE3-qbftdXs9Goo61JfkmfXX_1=R5XV-=eQ@mail.gmail.com>
Subject: Re: [PATCH v2 net] gro_cells: Avoid packet re-ordering for cloned skbs
To: Thomas Bogendoerfer <tbogendoerfer@suse.de>
Cc: Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 29, 2025 at 12:57=E2=80=AFPM Thomas Bogendoerfer
<tbogendoerfer@suse.de> wrote:
>
> On Wed, 29 Jan 2025 12:31:29 +0100
> Thomas Bogendoerfer <tbogendoerfer@suse.de> wrote:
>
> > My test scenario is simple:
> >
> > TCP Sender in namespace A -> ip6_tunnel -> ipvlan -> ipvlan -> ip6_tunn=
el -> TCP receiver
>
> sorry, messed it up. It looks like this
>
> <-        Namespace A           ->    <-        Namespace b             -=
>
> TCP Sender -> ip6_tunnel -> ipvlan -> ipvlan -> ip6_tunnel -> TCP Receive=
r
>


We are trying to avoid adding costs in GRO layer (a critical piece of
software for high speed flows), for a doubtful use case,
possibly obsolete.

BTW I am still unsure about the skb_cloned() test vs
skb_header_cloned() which would solve this case just  fine.
Because TCP sender is ok if some layer wants to change the headers,
thanks to __skb_header_release() call
from tcp_skb_entail()

"TCP Sender in namespace A -> ip6_tunnel -> ipvlan -> ipvlan ->
ip6_tunnel -> TCP receiver"
or
" TCP Sender -> ip6_tunnel -> ipvlan -> ipvlan -> ip6_tunnel -> TCP Receive=
r"

In this case, GRO in ip6_tunnel is not needed at all, since proper TSO
packets should already be cooked by TCP sender and be carried
to the receiver as plain GRO packets.

gro_cells was added at a time GRO layer was only  supporting native
encapsulations : IPv4 + TCP or IPv6 + TCP.

Nowadays, GRO supports encapsulated traffic just fine, same for TSO
packets encapsulated in ip6_tunnel

Maybe it is time to remove gro_cells from net/ipv6/ip6_tunnel.c

diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index 48fd53b9897265338086136e96ea8e8c6ec3cac..b91c253dc4f1998f8df74251a93e=
29d00c03db5
100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -246,7 +246,6 @@ static void ip6_dev_free(struct net_device *dev)
 {
        struct ip6_tnl *t =3D netdev_priv(dev);

-       gro_cells_destroy(&t->gro_cells);
        dst_cache_destroy(&t->dst_cache);
 }

@@ -877,7 +876,7 @@ static int __ip6_tnl_rcv(struct ip6_tnl *tunnel,
struct sk_buff *skb,
        if (tun_dst)
                skb_dst_set(skb, (struct dst_entry *)tun_dst);

-       gro_cells_receive(&tunnel->gro_cells, skb);
+       netif_rx(skb);
        return 0;

 drop:
@@ -1884,10 +1883,6 @@ ip6_tnl_dev_init_gen(struct net_device *dev)
        if (ret)
                return ret;

-       ret =3D gro_cells_init(&t->gro_cells, dev);
-       if (ret)
-               goto destroy_dst;
-
        t->tun_hlen =3D 0;
        t->hlen =3D t->encap_hlen + t->tun_hlen;
        t_hlen =3D t->hlen + sizeof(struct ipv6hdr);
@@ -1902,11 +1897,6 @@ ip6_tnl_dev_init_gen(struct net_device *dev)
        netdev_hold(dev, &t->dev_tracker, GFP_KERNEL);
        netdev_lockdep_set_classes(dev);
        return 0;
-
-destroy_dst:
-       dst_cache_destroy(&t->dst_cache);
-
-       return ret;
 }

 /**

