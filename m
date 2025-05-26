Return-Path: <netdev+bounces-193333-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 776A1AC38BE
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 06:41:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F66B3B17E0
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 04:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0682B1A5BB7;
	Mon, 26 May 2025 04:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YhDDdtd0"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687F614D29B
	for <netdev@vger.kernel.org>; Mon, 26 May 2025 04:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748234459; cv=none; b=I1CGcKeU8sQjBuU3PD8GM6kdt2YZNGjp/Xay0cmj7ebxjN1133bIz5R/CitpygnfKrJ+h/AA2Mm/lhlQWebjSZ4/H2OJzLbzdP8Od/Uqj4HLivTmBkKz46h2WxVmQ9npYJvrzjD5NDV2x3rDPea4F4I+9giHA3qypRmaCLM5zEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748234459; c=relaxed/simple;
	bh=C2q8h+rr3C0oRJMzQB3fdIta/rDhiaRDzXcrPbplg2I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r645Jtbh7CMF7iv+Iim2jtwZcqBnABp6AWJnvdNRteMFW9BMG+e7uAEewuv0TGj62aVjZsVMyllDe9pD51KqnYYy46UHfxCjtVCgR2ajKQNFxdGMmRxOArCUogZMvIFCbnGhn8O7qDXY6gjSt+0Q2GsiE5fwqDMuwrVyOTYBKcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YhDDdtd0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748234456;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WKrHx2sM5Bet3Dh+BkBxUJV/tpQGPVsD4b0txH5VkD8=;
	b=YhDDdtd07uiEs6bSa0rHLEJr2Unx2bUY3BPDA2CAlkQhiqh3wo7Hp7m6TXIA02ekrVsetb
	fmmuSN33ZtussoZiYAHXkCZakeLsJwZx5xzJVr3af7wXVOVT/7QT3FCo5akg0WrM6f4JkS
	e4gWvPKgolZKdTochdEUh8pPpOgTKu0=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-387-f3XoESRdNu66bUMDomrM8Q-1; Mon, 26 May 2025 00:40:54 -0400
X-MC-Unique: f3XoESRdNu66bUMDomrM8Q-1
X-Mimecast-MFC-AGG-ID: f3XoESRdNu66bUMDomrM8Q_1748234454
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-742a969a4d0so1327941b3a.2
        for <netdev@vger.kernel.org>; Sun, 25 May 2025 21:40:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748234453; x=1748839253;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WKrHx2sM5Bet3Dh+BkBxUJV/tpQGPVsD4b0txH5VkD8=;
        b=cS3tZp7LeU1N3ZQiPQxSCOZhxs/njWx0FAIpYaxRDgv07awy/TYZlFKXLC+M5cp9Ro
         bTVayKeJfz2fQtVeOS79eDPcqmwU2rdLHo+lyMGSWxeyrU2g5wqh0Fy1CTxjw0z6GQTo
         oy2j9+kZy3fxjqrEP9u4nUWSYyRM3SuEgaCAWz3KiYrOFG4H3N4ZAWKYt9qeLUPgS4ey
         XFlo/7zrHWJ4yaCncOno9Trsj9ONWYuR5wdWb9QBjAEsn8GEguISgR/xyAvTUP7xpHT3
         eSPWX8/3XmvWll8g0ao2uHsqCBB9SXt0ZS2hgbcT/i3pDGT98Vhbm8SUn35+YFdoGj33
         L0jg==
X-Gm-Message-State: AOJu0Yy/7nIzTsv0XaI6NglD/piF9dA0kJUVvoifLO3hKDdGl3MeBNjB
	ijPEfiF7ibZXhtn3xHL08MiCfCrc1Tv0UeXgW8c0SVDT3YNnKVSGXdkFgXH+4MRapoG2BWkq+F2
	hn3WZF+51sa/YGacWHoEtRFIgpzFFIlFIfA4fnP5GJuMGFyntJT4OE0I/E4DYpnjuv0gxjJBmIQ
	sBw4c0VeZfVSLscj8Mve7H2CWkJ3M5kwWY
X-Gm-Gg: ASbGncs0OnJo/o2LU7jYSKEhteBwOKv7yi12kf4UQwET62cJYMmZXAisKBVKM+tKVk5
	HveGvLgi8Mh5rDMjuuikTvrLZ2PNV2io1ZCvW2x+tQD/Ut0P6ysyrdrtQl+k9t80VHg/OQg==
X-Received: by 2002:a05:6a00:4651:b0:742:a91d:b2f6 with SMTP id d2e1a72fcca58-745fdf513b9mr10235373b3a.13.1748234453354;
        Sun, 25 May 2025 21:40:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGlORRQN9pQ000/cQ2Q5ZoARLmriTOaQv5qb9gYb60jLVduWdV941EeZzdUCB+zwjc0G14QX9VHN3+dawST0Ss=
X-Received: by 2002:a05:6a00:4651:b0:742:a91d:b2f6 with SMTP id
 d2e1a72fcca58-745fdf513b9mr10235343b3a.13.1748234452878; Sun, 25 May 2025
 21:40:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1747822866.git.pabeni@redhat.com> <6e001d160707e1cf87870acee5adc302f8cb39b6.1747822866.git.pabeni@redhat.com>
In-Reply-To: <6e001d160707e1cf87870acee5adc302f8cb39b6.1747822866.git.pabeni@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 26 May 2025 12:40:41 +0800
X-Gm-Features: AX0GCFuwHtCpbOdTRlK_CqB19qd19xf2nHm5yTE2ynlJK7Dlyv8K1yinnTfD4zQ
Message-ID: <CACGkMEtkbx8VZ2HAuDUbO9LStzoM6JQVcmA+6e+jM1o=r9wKow@mail.gmail.com>
Subject: Re: [PATCH net-next 5/8] net: implement virtio helpers to handle UDP
 GSO tunneling.
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 21, 2025 at 6:34=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> The virtio specification are introducing support for GSO over
> UDP tunnel.
>
> This patch brings in the needed defines and the additional
> virtio hdr parsing/building helpers.
>
> The UDP tunnel support uses additional fields in the virtio hdr,
> and such fields location can change depending on other negotiated
> features - specifically VIRTIO_NET_F_HASH_REPORT.
>
> Try to be as conservative as possible with the new field validation.
>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
>  include/linux/virtio_net.h      | 177 ++++++++++++++++++++++++++++++--
>  include/uapi/linux/virtio_net.h |  33 ++++++
>  2 files changed, 202 insertions(+), 8 deletions(-)
>
> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index 02a9f4dc594d0..cf9c712a67cd4 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h
> @@ -47,9 +47,9 @@ static inline int virtio_net_hdr_set_proto(struct sk_bu=
ff *skb,
>         return 0;
>  }
>
> -static inline int virtio_net_hdr_to_skb(struct sk_buff *skb,
> -                                       const struct virtio_net_hdr *hdr,
> -                                       bool little_endian)
> +static inline int __virtio_net_hdr_to_skb(struct sk_buff *skb,
> +                                         const struct virtio_net_hdr *hd=
r,
> +                                         bool little_endian, u8 hdr_gso_=
type)
>  {
>         unsigned int nh_min_len =3D sizeof(struct iphdr);
>         unsigned int gso_type =3D 0;
> @@ -57,8 +57,8 @@ static inline int virtio_net_hdr_to_skb(struct sk_buff =
*skb,
>         unsigned int p_off =3D 0;
>         unsigned int ip_proto;
>
> -       if (hdr->gso_type !=3D VIRTIO_NET_HDR_GSO_NONE) {
> -               switch (hdr->gso_type & ~VIRTIO_NET_HDR_GSO_ECN) {
> +       if (hdr_gso_type !=3D VIRTIO_NET_HDR_GSO_NONE) {
> +               switch (hdr_gso_type & ~VIRTIO_NET_HDR_GSO_ECN) {
>                 case VIRTIO_NET_HDR_GSO_TCPV4:
>                         gso_type =3D SKB_GSO_TCPV4;
>                         ip_proto =3D IPPROTO_TCP;
> @@ -84,7 +84,7 @@ static inline int virtio_net_hdr_to_skb(struct sk_buff =
*skb,
>                         return -EINVAL;
>                 }
>
> -               if (hdr->gso_type & VIRTIO_NET_HDR_GSO_ECN)
> +               if (hdr_gso_type & VIRTIO_NET_HDR_GSO_ECN)
>                         gso_type |=3D SKB_GSO_TCP_ECN;
>
>                 if (hdr->gso_size =3D=3D 0)
> @@ -122,7 +122,7 @@ static inline int virtio_net_hdr_to_skb(struct sk_buf=
f *skb,
>
>                                 if (!protocol)
>                                         virtio_net_hdr_set_proto(skb, hdr=
);
> -                               else if (!virtio_net_hdr_match_proto(prot=
ocol, hdr->gso_type))
> +                               else if (!virtio_net_hdr_match_proto(prot=
ocol, hdr_gso_type))
>                                         return -EINVAL;
>                                 else
>                                         skb->protocol =3D protocol;
> @@ -153,7 +153,7 @@ static inline int virtio_net_hdr_to_skb(struct sk_buf=
f *skb,
>                 }
>         }
>
> -       if (hdr->gso_type !=3D VIRTIO_NET_HDR_GSO_NONE) {
> +       if (hdr_gso_type !=3D VIRTIO_NET_HDR_GSO_NONE) {
>                 u16 gso_size =3D __virtio16_to_cpu(little_endian, hdr->gs=
o_size);
>                 unsigned int nh_off =3D p_off;
>                 struct skb_shared_info *shinfo =3D skb_shinfo(skb);
> @@ -199,6 +199,13 @@ static inline int virtio_net_hdr_to_skb(struct sk_bu=
ff *skb,
>         return 0;
>  }
>
> +static inline int virtio_net_hdr_to_skb(struct sk_buff *skb,
> +                                       const struct virtio_net_hdr *hdr,
> +                                       bool little_endian)
> +{
> +       return __virtio_net_hdr_to_skb(skb, hdr, little_endian, hdr->gso_=
type);
> +}
> +
>  static inline int virtio_net_hdr_from_skb(const struct sk_buff *skb,
>                                           struct virtio_net_hdr *hdr,
>                                           bool little_endian,
> @@ -242,4 +249,158 @@ static inline int virtio_net_hdr_from_skb(const str=
uct sk_buff *skb,
>         return 0;
>  }
>
> +static inline unsigned int virtio_l3min(bool is_ipv6)
> +{
> +       return is_ipv6 ? sizeof(struct ipv6hdr) : sizeof(struct iphdr);
> +}
> +
> +static inline int virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
> +                                           const struct virtio_net_hdr *=
hdr,
> +                                           unsigned int tnl_hdr_offset,
> +                                           bool tnl_csum_negotiated,
> +                                           bool little_endian)

Considering tunnel gso requires VERSION_1, I think there's no chance
for little_endian to be false here.

> +{
> +       u8 gso_tunnel_type =3D hdr->gso_type & VIRTIO_NET_HDR_GSO_UDP_TUN=
NEL;
> +       unsigned int inner_nh, outer_th, inner_th;
> +       unsigned int inner_l3min, outer_l3min;
> +       struct virtio_net_hdr_tunnel *tnl;
> +       u8 gso_inner_type;
> +       bool outer_isv6;
> +       int ret;
> +
> +       if (!gso_tunnel_type)
> +               return virtio_net_hdr_to_skb(skb, hdr, little_endian);
> +
> +       /* Tunnel not supported/negotiated, but the hdr asks for it. */
> +       if (!tnl_hdr_offset)
> +               return -EINVAL;
> +
> +       /* Either ipv4 or ipv6. */
> +       if (gso_tunnel_type & VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV4 &&
> +           gso_tunnel_type & VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV6)
> +               return -EINVAL;

Could be simplified with gso_tunnel_type =3D=3D VIRTIO_NET_HDR_GSO_UDP_TUNN=
EL ?

> +
> +       /* No UDP fragments over UDP tunnel. */
> +       gso_inner_type =3D hdr->gso_type & ~(VIRTIO_NET_HDR_GSO_ECN |
> +                                          gso_tunnel_type);

VIRTIO_NET_HDR_GSO_UDP_TUNNEL seems to be better than gso_tunnel_type here.

> +       if (!gso_inner_type || gso_inner_type =3D=3D VIRTIO_NET_HDR_GSO_U=
DP)
> +               return -EINVAL;
> +
> +       /* Relay on csum being present. */
> +       if (!(hdr->flags & VIRTIO_NET_HDR_F_NEEDS_CSUM))
> +               return -EINVAL;
> +
> +       /* Validate offsets. */
> +       outer_isv6 =3D gso_tunnel_type & VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IP=
V6;
> +       inner_l3min =3D virtio_l3min(gso_inner_type =3D=3D VIRTIO_NET_HDR=
_GSO_TCPV6);
> +       outer_l3min =3D ETH_HLEN + virtio_l3min(outer_isv6);
> +
> +       tnl =3D ((void *)hdr) + tnl_hdr_offset;
> +       inner_th =3D __virtio16_to_cpu(little_endian, hdr->csum_start);
> +       inner_nh =3D __virtio16_to_cpu(little_endian, tnl->inner_nh_offse=
t);
> +       outer_th =3D __virtio16_to_cpu(little_endian, tnl->outer_th_offse=
t);
> +       if (outer_th < outer_l3min ||
> +           inner_nh < outer_th + sizeof(struct udphdr) ||
> +           inner_th < inner_nh + inner_l3min)
> +               return -EINVAL;

I wonder if kernel has already had helpers to validate the tunnel
headers or if the above check is sufficient here.

> +
> +       /* Let the basic parsing deal with plain GSO features. */
> +       ret =3D __virtio_net_hdr_to_skb(skb, hdr, little_endian,
> +                                     hdr->gso_type & ~gso_tunnel_type);
> +       if (ret)
> +               return ret;
> +
> +       skb_set_inner_protocol(skb, outer_isv6 ? htons(ETH_P_IPV6) :
> +                                                htons(ETH_P_IP));

The outer_isv6 is somehow misleading here, I think we'd better rename
it as inner_isv6?

> +       if (hdr->flags & VIRTIO_NET_HDR_F_UDP_TUNNEL_CSUM) {
> +               if (!tnl_csum_negotiated)
> +                       return -EINVAL;
> +
> +               skb_shinfo(skb)->gso_type |=3D SKB_GSO_UDP_TUNNEL_CSUM;
> +       } else {
> +               skb_shinfo(skb)->gso_type |=3D SKB_GSO_UDP_TUNNEL;
> +       }
> +
> +       skb->inner_transport_header =3D inner_th + skb_headroom(skb);

I may miss something but using skb_headroom() means the value depends
on the geometry of the skb and the headroom might vary depending on
the size of the packet and other factors.  (see receive_buf())

> +       skb->inner_network_header =3D inner_nh + skb_headroom(skb);
> +       skb->inner_mac_header =3D inner_nh + skb_headroom(skb);

This actually equals to inner_network_header, is this intended?

> +       skb->transport_header =3D outer_th + skb_headroom(skb);
> +       skb->encapsulation =3D 1;
> +       return 0;
> +}
> +
> +static inline int virtio_net_chk_data_valid(struct sk_buff *skb,
> +                                           struct virtio_net_hdr *hdr,
> +                                           bool tun_csum_negotiated)

This is virtio_net.h so it's better to avoid using "tun". Btw, I
wonder why this needs to be called by the virtio-net instead of being
called by hdr_to_skb helpers.

> +{
> +       if (!(hdr->gso_type & VIRTIO_NET_HDR_GSO_UDP_TUNNEL)) {
> +               if (!(hdr->flags & VIRTIO_NET_HDR_F_DATA_VALID))
> +                       return 0;
> +
> +               skb->ip_summed =3D CHECKSUM_UNNECESSARY;
> +               if (!(hdr->flags & VIRTIO_NET_HDR_F_UDP_TUNNEL_CSUM))
> +                       return 0;
> +
> +               /* tunnel csum packets are invalid when the related
> +                * feature has not been negotiated
> +                */
> +               if (!tun_csum_negotiated)
> +                       return -EINVAL;

Should we move this check above VIRTIO_NET_HDR_F_DATA_VALID check?

> +               skb->csum_level =3D 1;
> +               return 0;
> +       }
> +
> +       /* DATA_VALID is mutually exclusive with NEEDS_CSUM,

I may miss something but I think we had a discussion about this, and
the conclusion is it's too late to fix as it may break some legacy
devices?

> and GSO
> +        * over UDP tunnel requires the latter
> +        */
> +       if (hdr->flags & VIRTIO_NET_HDR_F_DATA_VALID)
> +               return -EINVAL;
> +       return 0;
> +}
> +
> +static inline int virtio_net_hdr_tnl_from_skb(const struct sk_buff *skb,
> +                                             struct virtio_net_hdr *hdr,
> +                                             unsigned int tnl_offset,
> +                                             bool little_endian,
> +                                             int vlan_hlen)
> +{
> +       struct virtio_net_hdr_tunnel *tnl;
> +       unsigned int inner_nh, outer_th;
> +       int tnl_gso_type;
> +       int ret;
> +
> +       tnl_gso_type =3D skb_shinfo(skb)->gso_type & (SKB_GSO_UDP_TUNNEL =
|
> +                                                   SKB_GSO_UDP_TUNNEL_CS=
UM);
> +       if (!tnl_gso_type)
> +               return virtio_net_hdr_from_skb(skb, hdr, little_endian, f=
alse,
> +                                              vlan_hlen);
> +
> +       /* Tunnel support not negotiated but skb ask for it. */
> +       if (!tnl_offset)
> +               return -EINVAL;

Should we do BUG_ON here?

> +
> +       /* Let the basic parsing deal with plain GSO features. */
> +       skb_shinfo(skb)->gso_type &=3D ~tnl_gso_type;
> +       ret =3D virtio_net_hdr_from_skb(skb, hdr, little_endian, false,
> +                                     vlan_hlen);
> +       skb_shinfo(skb)->gso_type |=3D tnl_gso_type;
> +       if (ret)
> +               return ret;

Could we do the plain GSO after setting inner flags below to avoid
masking and unmasking tnl_gso_type?

> +
> +       if (skb->protocol =3D=3D htons(ETH_P_IPV6))
> +               hdr->gso_type |=3D VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV6;
> +       else
> +               hdr->gso_type |=3D VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV4;
> +
> +       if (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_TUNNEL_CSUM)
> +               hdr->flags |=3D VIRTIO_NET_HDR_F_UDP_TUNNEL_CSUM;
> +
> +       tnl =3D ((void *)hdr) + tnl_offset;
> +       inner_nh =3D skb->inner_network_header - skb_headroom(skb);
> +       outer_th =3D skb->transport_header - skb_headroom(skb);
> +       tnl->inner_nh_offset =3D  __cpu_to_virtio16(little_endian, inner_=
nh);
> +       tnl->outer_th_offset =3D  __cpu_to_virtio16(little_endian, outer_=
th);

little_endian should be true here as it depends on version 1.

> +       return 0;
> +}
> +
>  #endif /* _LINUX_VIRTIO_NET_H */
> diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_=
net.h
> index 963540deae66a..1f1ff88a5749f 100644
> --- a/include/uapi/linux/virtio_net.h
> +++ b/include/uapi/linux/virtio_net.h
> @@ -70,6 +70,28 @@
>                                          * with the same MAC.
>                                          */
>  #define VIRTIO_NET_F_SPEED_DUPLEX 63   /* Device set linkspeed and duple=
x */
> +#define VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO 65 /* Driver can receive
> +                                             * GSO-over-UDP-tunnel packe=
ts
> +                                             */
> +#define VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_CSUM 66 /* Driver handles
> +                                                  * GSO-over-UDP-tunnel
> +                                                  * packets with partial=
 csum
> +                                                  * for the outer header
> +                                                  */
> +#define VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO 67 /* Device can receive
> +                                            * GSO-over-UDP-tunnel packet=
s
> +                                            */
> +#define VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO_CSUM 68 /* Device handles
> +                                                 * GSO-over-UDP-tunnel
> +                                                 * packets with partial =
csum
> +                                                 * for the outer header
> +                                                 */
> +
> +/* Offloads bits corresponding to VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO{,_CSU=
M}
> + * features
> + */
> +#define VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_MAPPED       46
> +#define VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_CSUM_MAPPED  47
>
>  #ifndef VIRTIO_NET_NO_LEGACY
>  #define VIRTIO_NET_F_GSO       6       /* Host handles pkts w/ any GSO t=
ype */
> @@ -131,12 +153,17 @@ struct virtio_net_hdr_v1 {
>  #define VIRTIO_NET_HDR_F_NEEDS_CSUM    1       /* Use csum_start, csum_o=
ffset */
>  #define VIRTIO_NET_HDR_F_DATA_VALID    2       /* Csum is valid */
>  #define VIRTIO_NET_HDR_F_RSC_INFO      4       /* rsc info in csum_ fiel=
ds */
> +#define VIRTIO_NET_HDR_F_UDP_TUNNEL_CSUM 8     /* UDP tunnel requires cs=
um offload */
>         __u8 flags;
>  #define VIRTIO_NET_HDR_GSO_NONE                0       /* Not a GSO fram=
e */
>  #define VIRTIO_NET_HDR_GSO_TCPV4       1       /* GSO frame, IPv4 TCP (T=
SO) */
>  #define VIRTIO_NET_HDR_GSO_UDP         3       /* GSO frame, IPv4 UDP (U=
FO) */
>  #define VIRTIO_NET_HDR_GSO_TCPV6       4       /* GSO frame, IPv6 TCP */
>  #define VIRTIO_NET_HDR_GSO_UDP_L4      5       /* GSO frame, IPv4& IPv6 =
UDP (USO) */
> +#define VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV4 0x20 /* UDP over IPv4 tunnel =
present */
> +#define VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV6 0x40 /* UDP over IPv6 tunnel =
present */
> +#define VIRTIO_NET_HDR_GSO_UDP_TUNNEL (VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV=
4 | \
> +                                      VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV6=
)
>  #define VIRTIO_NET_HDR_GSO_ECN         0x80    /* TCP has ECN set */
>         __u8 gso_type;
>         __virtio16 hdr_len;     /* Ethernet + IP + tcp/udp hdrs */
> @@ -181,6 +208,12 @@ struct virtio_net_hdr_v1_hash {
>         __le16 padding;
>  };
>
> +/* This header after hashing information */
> +struct virtio_net_hdr_tunnel {
> +       __virtio16 outer_th_offset;
> +       __virtio16 inner_nh_offset;
> +};
> +
>  #ifndef VIRTIO_NET_NO_LEGACY
>  /* This header comes first in the scatter-gather list.
>   * For legacy virtio, if VIRTIO_F_ANY_LAYOUT is not negotiated, it must
> --
> 2.49.0
>

Thanks


