Return-Path: <netdev+bounces-120561-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E9E959C6A
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 14:54:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BDDCB20B65
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 12:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F0319047D;
	Wed, 21 Aug 2024 12:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wq4SmHNR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f194.google.com (mail-yb1-f194.google.com [209.85.219.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39279155307;
	Wed, 21 Aug 2024 12:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724244851; cv=none; b=S7YBVXjs85vZ9nBZBwIDbo3HU6ohP+AIALPzdJ36HWZcYsTLwMEwQQRklr3P7QpH10NMb2Ihfh/cZE2pAlhuzcktJ+4b+yiROPRo6LlB8Cyflu8fJi0gdNzOUAj/RQmaYEvdO2phmfaZetGQegvwg1MsV2RRAop5bd1ynP6fb5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724244851; c=relaxed/simple;
	bh=uag6oJKSLNc4EyiZyQBEDxAqh87/Vb4AfusOoq2BVZQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IBgi1K4v9+wFGzp8igg5ePfyUk0uiCWUJ57sg4jcrR6VOGNssmewf7IwNiZhCGhk2Htgbbntlw3wJ0nb3TFU3WlU/FOkpYRzk1eUF1D/PsXeNHqvSFZHbqCxYxw9vvpaXkIFRcYedys7JJJFNn7PiAJN7pWul+kl2d2I2ih2hps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wq4SmHNR; arc=none smtp.client-ip=209.85.219.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f194.google.com with SMTP id 3f1490d57ef6-e04196b7603so7206427276.0;
        Wed, 21 Aug 2024 05:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724244849; x=1724849649; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+gwLIf+raghtd0edZ/Li2oik0sJVO4IXfSVabsLb2pQ=;
        b=Wq4SmHNREKdK1/GB4Zu9OSO9NmZaivwpkrYpz0V2WVOzaTdtolkRKODb65F1txO9VI
         WguZsov6/zLXY94lOgZU5rO/pDNffa8cXzuoYDz1avB7yiJ1NV9VJV7/ucYGTCh2t+Ed
         luMnAz6V/1pmgIkg6g1Y/UREZQVE1rOB9zPmbu5t1F0+6rwdDg3bY8d7+N27ioNlXjLx
         sEdCG5lzZ27yrkOQ/k2quBZZRW2H7fPx+H7oSJ5i1A3uXAAcjoOVX57lT6FE+/BLbrds
         CLgonO2LZzkDqRpzeT34nDgGCrhXTHmie6mKOVtGXjFbt+wR9I7Xsm+L3rwt+hDjUGy9
         xTZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724244849; x=1724849649;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+gwLIf+raghtd0edZ/Li2oik0sJVO4IXfSVabsLb2pQ=;
        b=XhGwjxI4MqbcELWt2sHgqfxDeTXHdblNLd8qL7NZ5PuLCqCcRCJrBp3fL0Ysd6gazb
         hN3jP1VLWL+OS7p1dxIk8x3ckK1Haai6fVqi1U7IKo272gfjlE0FvlHnoZwHOTgfJTGv
         9FqIdh3tEDwf5FjIKwBEQfWiZbLCrzffVptRHA/MbEtTqE1rFtU64gVsunOT+eNh3Tdy
         QdddJPSXtnZX+J2CMVc5YrWttD67nRur5esbxKH3FO2hdW1NbKqiW3DWF+XL8g1Gr/qQ
         aIzrguLZnmS/P8eqoE2wWSxaPWxnnTmevsDFh4nh3PhO9WSdv/C0a/D0mibEog+DpmhA
         xO1w==
X-Forwarded-Encrypted: i=1; AJvYcCXTEtIetLg6oWlJljKng0cfT8dPrm3U3oADmIvEfni8v/OVXexwkXaJFFradXQL3IycVE28PWyFytIxZhc=@vger.kernel.org, AJvYcCXblG9KrjfgDXCJsnw+/HIXSU59aVh8GYwgKpsmZzJcNpe1Iom84dOcIX+cn7M/m718AeJVS+8q@vger.kernel.org
X-Gm-Message-State: AOJu0YyRWKgSbU2dHRAaF5x12JZFcb4H7wZXczZ3RbFMTTzyV9Rq57Y8
	kcg51J/YITQmRB5uhnvnzTJR4sA+NhQinMHaM2q2K+b9xabuCwd0pQFZTydGK3DAtZRsW8hVVV0
	ec/jP/OkuI55mhZB21GzDZT9jfOk=
X-Google-Smtp-Source: AGHT+IED4ENiYUTdnfoXg7IWoAZlsrqRtK8Kyl6f0GghpjDYhQSB4986z40o+E5mjnaHeqjNodPxZOXIjOa7+mY4HCA=
X-Received: by 2002:a05:6902:1005:b0:e0e:4171:aee6 with SMTP id
 3f1490d57ef6-e1665539587mr2740330276.42.1724244848985; Wed, 21 Aug 2024
 05:54:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815124302.982711-1-dongml2@chinatelecom.cn>
 <20240815124302.982711-7-dongml2@chinatelecom.cn> <ZsSLj-fI5Hiy9aV-@shredder.mtl.com>
In-Reply-To: <ZsSLj-fI5Hiy9aV-@shredder.mtl.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Wed, 21 Aug 2024 20:54:05 +0800
Message-ID: <CADxym3YK4_8VCYgzsW_o0Cc3CXZMV8tUVb1Mq2RhH4=VoecPLQ@mail.gmail.com>
Subject: Re: [PATCH net-next 06/10] net: vxlan: add skb drop reasons to vxlan_rcv()
To: Ido Schimmel <idosch@nvidia.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, dsahern@kernel.org, dongml2@chinatelecom.cn, 
	amcohen@nvidia.com, gnault@redhat.com, bpoirier@nvidia.com, 
	b.galvani@gmail.com, razor@blackwall.org, petrm@nvidia.com, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 20, 2024 at 8:27=E2=80=AFPM Ido Schimmel <idosch@nvidia.com> wr=
ote:
>
> On Thu, Aug 15, 2024 at 08:42:58PM +0800, Menglong Dong wrote:
> > diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_c=
ore.c
> > index e971c4785962..9a61f04bb95d 100644
> > --- a/drivers/net/vxlan/vxlan_core.c
> > +++ b/drivers/net/vxlan/vxlan_core.c
> > @@ -1668,6 +1668,7 @@ static bool vxlan_ecn_decapsulate(struct vxlan_so=
ck *vs, void *oiph,
> >  /* Callback from net/ipv4/udp.c to receive packets */
> >  static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
> >  {
> > +     enum skb_drop_reason reason =3D pskb_may_pull_reason(skb, VXLAN_H=
LEN);
> >       struct vxlan_vni_node *vninode =3D NULL;
> >       struct vxlan_dev *vxlan;
> >       struct vxlan_sock *vs;
> > @@ -1681,7 +1682,7 @@ static int vxlan_rcv(struct sock *sk, struct sk_b=
uff *skb)
> >       int nh;
> >
> >       /* Need UDP and VXLAN header to be present */
> > -     if (!pskb_may_pull(skb, VXLAN_HLEN))
> > +     if (reason !=3D SKB_NOT_DROPPED_YET)
> >               goto drop;
> >
> >       unparsed =3D *vxlan_hdr(skb);
> > @@ -1690,6 +1691,7 @@ static int vxlan_rcv(struct sock *sk, struct sk_b=
uff *skb)
> >               netdev_dbg(skb->dev, "invalid vxlan flags=3D%#x vni=3D%#x=
\n",
> >                          ntohl(vxlan_hdr(skb)->vx_flags),
> >                          ntohl(vxlan_hdr(skb)->vx_vni));
> > +             reason =3D (u32)VXLAN_DROP_FLAGS;
>
> I don't find "FLAGS" very descriptive. AFAICT the reason is used in
> these two cases:
>
> 1. "I flag" is not set
> 2. The reserved fields are not zero
>
> Maybe call it VXLAN_DROP_INVALID_HDR ?
>

Yeah, that makes sense.

> And I agree with the comment about documenting these drop reasons like
> in include/net/dropreason-core.h
>

Okay, I'm planning to do it this way.

> >               /* Return non vxlan pkt */
> >               goto drop;
> >       }
> > @@ -1703,8 +1705,10 @@ static int vxlan_rcv(struct sock *sk, struct sk_=
buff *skb)
> >       vni =3D vxlan_vni(vxlan_hdr(skb)->vx_vni);
> >
> >       vxlan =3D vxlan_vs_find_vni(vs, skb->dev->ifindex, vni, &vninode)=
;
> > -     if (!vxlan)
> > +     if (!vxlan) {
> > +             reason =3D (u32)VXLAN_DROP_VNI;
>
> Same comment here. Maybe VXLAN_DROP_VNI_NOT_FOUND ?
>

Yeah, sounds nice.

> >               goto drop;
> > +     }
> >
> >       /* For backwards compatibility, only allow reserved fields to be
> >        * used by VXLAN extensions if explicitly requested.
> > @@ -1717,12 +1721,16 @@ static int vxlan_rcv(struct sock *sk, struct sk=
_buff *skb)
> >       }
> >
> >       if (__iptunnel_pull_header(skb, VXLAN_HLEN, protocol, raw_proto,
> > -                                !net_eq(vxlan->net, dev_net(vxlan->dev=
))))
> > +                                !net_eq(vxlan->net, dev_net(vxlan->dev=
)))) {
> > +             reason =3D SKB_DROP_REASON_NOMEM;
> >               goto drop;
> > +     }
> >
> > -     if (vs->flags & VXLAN_F_REMCSUM_RX)
> > -             if (unlikely(!vxlan_remcsum(&unparsed, skb, vs->flags)))
> > +     if (vs->flags & VXLAN_F_REMCSUM_RX) {
> > +             reason =3D vxlan_remcsum(&unparsed, skb, vs->flags);
> > +             if (unlikely(reason !=3D SKB_NOT_DROPPED_YET))
> >                       goto drop;
> > +     }
> >
> >       if (vxlan_collect_metadata(vs)) {
> >               IP_TUNNEL_DECLARE_FLAGS(flags) =3D { };
> > @@ -1732,8 +1740,10 @@ static int vxlan_rcv(struct sock *sk, struct sk_=
buff *skb)
> >               tun_dst =3D udp_tun_rx_dst(skb, vxlan_get_sk_family(vs), =
flags,
> >                                        key32_to_tunnel_id(vni), sizeof(=
*md));
> >
> > -             if (!tun_dst)
> > +             if (!tun_dst) {
> > +                     reason =3D SKB_DROP_REASON_NOMEM;
> >                       goto drop;
> > +             }
> >
> >               md =3D ip_tunnel_info_opts(&tun_dst->u.tun_info);
> >
> > @@ -1757,12 +1767,15 @@ static int vxlan_rcv(struct sock *sk, struct sk=
_buff *skb)
> >                * is more robust and provides a little more security in
> >                * adding extensions to VXLAN.
> >                */
> > +             reason =3D (u32)VXLAN_DROP_FLAGS;
> >               goto drop;
> >       }
> >
> >       if (!raw_proto) {
> > -             if (!vxlan_set_mac(vxlan, vs, skb, vni))
> > +             if (!vxlan_set_mac(vxlan, vs, skb, vni)) {
> > +                     reason =3D (u32)VXLAN_DROP_MAC;
>
> The function drops the packet for various reasons:
>
> 1. Source MAC is equal to the VXLAN device's MAC
> 2. Source MAC is invalid (all zeroes or multicast)
> 3. Trying to migrate a static entry or one pointing to a nexthop
>
> They are all quite obscure so it might be fine to fold them under the
> same reason, but I can't find a descriptive name.
>
> If you split 1-2 to one reason and 3 to another, then they can become
> VXLAN_DROP_INVALID_SMAC and VXLAN_DROP_ENTRY_EXISTS
>

Sounds great! Thanks for creating these names for me,
I'm really not good at naming :/

> >                       goto drop;
> > +             }

