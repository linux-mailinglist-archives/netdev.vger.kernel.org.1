Return-Path: <netdev+bounces-196799-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B191DAD66A3
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 06:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 880651884A1E
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 04:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E78A81D47AD;
	Thu, 12 Jun 2025 04:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UrsXYqKT"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6B2143736
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 04:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749701168; cv=none; b=ZP0sDubmCP/O2ZHb/qxrO3q9SfCpuww/wyNXrI9U7Ky0b1BakyMoVJOzg1u+Noa+zwdrIP4M37jCRowKxMvRdlvlRl2SibMhnGqqDPDtvFbALnBCIUskHxu9QGvXvb+5oZvGxIkJrDEkK4fK6syaLPykkfpLkizJ/CEbuBRufFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749701168; c=relaxed/simple;
	bh=+N1ksv4vO25Cb6n4YMggLroYEhRlm5m6PqLDWQs89RQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iXMokX35DV00ty7yTy7IE5qa46dor7/Upd5y/1zx0wrTgdj4ToZFBA0fRfOiZH/sq5wKcTt9T7EgJ5sWxDXdt+wSI768nwohdMex1RE3G0UZb7ryw92vbH0SSja+TbvktQG6orS9mWawf04yDbEWjOUjCpq/wRxXupqeMIvYXaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UrsXYqKT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749701162;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T65sUjR3HR7dbObyU/jmpAIxTgUdKCVjfwuyrdaN1q8=;
	b=UrsXYqKTn4l8EPrmpYe6aMh1mH+q95wFLizUlr+MljVw5LOuqxzn9p/uDp/JM8vydyzF+0
	6bYm3MF9uqoK0CJ7tbjBNlMsuuc1DZsYvril+0/Es0Qr/XPUF6AanC7CxHGUcUGgAdYYsj
	r3XD9SLEPLHzx8GegWawsYUhIv4b5hY=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-258-cCt4d3uKOaCnLKAlIAD8ig-1; Thu, 12 Jun 2025 00:05:59 -0400
X-MC-Unique: cCt4d3uKOaCnLKAlIAD8ig-1
X-Mimecast-MFC-AGG-ID: cCt4d3uKOaCnLKAlIAD8ig_1749701158
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b2f5a5da5efso157587a12.2
        for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 21:05:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749701158; x=1750305958;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T65sUjR3HR7dbObyU/jmpAIxTgUdKCVjfwuyrdaN1q8=;
        b=QWMtHNc3NE3d7M+sL29Rylpw/vLqWlOqpGyXo2fUJXslL7UQOadae3qtlPp9DeWmFQ
         kfXXdOKo3CsmJU4mewDMg1s7lPP/3pv+r+G46RrXFIwsQZ6F3XUlBBD9HYbKN4DYOz0S
         f/bYl9hhKVWCGt/cv+0Ex1+TxbSOwBAoHqxuiWVlWGk06LVzE7UOJcoNrocKBH5cq45b
         EBuvsISlAgsnESWtaKW04HZ6FotV0Wjy/bJXtNVtot/ujzsK35qK2vVAKfocGFbbiZni
         +0oD4G6oVG+zlht610fJemi1BowD6M9GLRv7isIgqv+VMuuuVeRSXJqaHMR3akUeoYSf
         m6Nw==
X-Gm-Message-State: AOJu0YwH2Yyjd0YpUJuXO6xtXFMPY3ecd2lNJNSS72z1T+xk6odfYSmE
	jAQBQ+5pPj1k31KSzXe8nnC3UFAwQ9eH8UO25YfagOUKxoZnAVjm8s8VAqIOm0OTi6ITyXmpKEs
	V1VlIBRtr23qSWeBBYAHMiPk4q3umUjLY17+s8Iks6xm8GdRemzUMtQSNgynBAbIyoZruRVsUgs
	ktfN9hN1jbRiKdP7NtkHaK5OCCiT6ovAfJ
X-Gm-Gg: ASbGncuEnqL661wiaEFo/c10K1RmCNETJ0sEl/REBFJ3uQJrIdf87x3WGRB/craMOAV
	F1CFZ/MisMZTg4hVpA6oO/5emXuyAcLPXDLBvSM5bxXP9pPip0aHlsCkbUu738DeLH/pBef11CZ
	oa
X-Received: by 2002:a17:902:cec6:b0:234:8e78:ce8a with SMTP id d9443c01a7336-2364d90f8c2mr27308265ad.48.1749701157854;
        Wed, 11 Jun 2025 21:05:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOmg710jvQ78lI39avdQ2zjx2ATEuohjBtO4fhEA2ayVcOWNA4p4Xg3yIYMCRSFiY0qj+QyflzOkUJJijh/9Y=
X-Received: by 2002:a17:902:cec6:b0:234:8e78:ce8a with SMTP id
 d9443c01a7336-2364d90f8c2mr27307815ad.48.1749701157392; Wed, 11 Jun 2025
 21:05:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1749210083.git.pabeni@redhat.com> <d10b01bd14473ad95fb8d7f83ab1cd7c40c2a10e.1749210083.git.pabeni@redhat.com>
In-Reply-To: <d10b01bd14473ad95fb8d7f83ab1cd7c40c2a10e.1749210083.git.pabeni@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 12 Jun 2025 12:05:46 +0800
X-Gm-Features: AX0GCFtqHPSgC4aWZMutEe8BbaaVme7JhiWJYEfoeJQnVxos6IpLMij6Jhp88sE
Message-ID: <CACGkMEtP5PoxS+=veyQimHB+Mui2+71tpJUYg5UcQCw9BR8yrg@mail.gmail.com>
Subject: Re: [PATCH RFC v3 6/8] virtio_net: enable gso over UDP tunnel support.
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Yuri Benditovich <yuri.benditovich@daynix.com>, Akihiko Odaki <akihiko.odaki@daynix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 6, 2025 at 7:46=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
> If the related virtio feature is set, enable transmission and reception
> of gso over UDP tunnel packets.
>
> Most of the work is done by the previously introduced helper, just need
> to determine the UDP tunnel features inside the virtio_net_hdr and
> update accordingly the virtio net hdr size.
>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> v2 -> v3:
>   - drop the VIRTIO_HAS_EXTENDED_FEATURES conditionals
>
> v1 -> v2:
>   - test for UDP_TUNNEL_GSO* only on builds with extended features suppor=
t
>   - comment indentation cleanup
>   - rebased on top of virtio helpers changes
>   - dump more information in case of bad offloads
> ---
>  drivers/net/virtio_net.c | 70 +++++++++++++++++++++++++++++++---------
>  1 file changed, 54 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 18ad50de4928..0b234f318e39 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -78,15 +78,19 @@ static const unsigned long guest_offloads[] =3D {
>         VIRTIO_NET_F_GUEST_CSUM,
>         VIRTIO_NET_F_GUEST_USO4,
>         VIRTIO_NET_F_GUEST_USO6,
> -       VIRTIO_NET_F_GUEST_HDRLEN
> +       VIRTIO_NET_F_GUEST_HDRLEN,
> +       VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_MAPPED,
> +       VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_CSUM_MAPPED,
>  };
>
>  #define GUEST_OFFLOAD_GRO_HW_MASK ((1ULL << VIRTIO_NET_F_GUEST_TSO4) | \
> -                               (1ULL << VIRTIO_NET_F_GUEST_TSO6) | \
> -                               (1ULL << VIRTIO_NET_F_GUEST_ECN)  | \
> -                               (1ULL << VIRTIO_NET_F_GUEST_UFO)  | \
> -                               (1ULL << VIRTIO_NET_F_GUEST_USO4) | \
> -                               (1ULL << VIRTIO_NET_F_GUEST_USO6))
> +                       (1ULL << VIRTIO_NET_F_GUEST_TSO6) | \
> +                       (1ULL << VIRTIO_NET_F_GUEST_ECN)  | \
> +                       (1ULL << VIRTIO_NET_F_GUEST_UFO)  | \
> +                       (1ULL << VIRTIO_NET_F_GUEST_USO4) | \
> +                       (1ULL << VIRTIO_NET_F_GUEST_USO6) | \
> +                       (1ULL << VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_MAPPED=
) | \
> +                       (1ULL << VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_CSUM_M=
APPED))
>
>  struct virtnet_stat_desc {
>         char desc[ETH_GSTRING_LEN];
> @@ -436,9 +440,14 @@ struct virtnet_info {
>         /* Packet virtio header size */
>         u8 hdr_len;
>
> +       /* UDP tunnel support */
> +       u8 tnl_offset;
> +
>         /* Work struct for delayed refilling if we run low on memory. */
>         struct delayed_work refill;
>
> +       bool rx_tnl_csum;
> +
>         /* Is delayed refill enabled? */
>         bool refill_enabled;
>
> @@ -2531,14 +2540,22 @@ static void virtnet_receive_done(struct virtnet_i=
nfo *vi, struct receive_queue *
>         if (dev->features & NETIF_F_RXHASH && vi->has_rss_hash_report)
>                 virtio_skb_set_hash(&hdr->hash_v1_hdr, skb);
>
> -       if (flags & VIRTIO_NET_HDR_F_DATA_VALID)
> -               skb->ip_summed =3D CHECKSUM_UNNECESSARY;
> +       /* restore the received value */

Nit: this comment seems to be redundant

> +       hdr->hdr.flags =3D flags;
> +       if (virtio_net_chk_data_valid(skb, &hdr->hdr, vi->rx_tnl_csum)) {

Nit: this function did more than just check DATA_VALID, we probably
need a better name.

> +               net_warn_ratelimited("%s: bad csum: flags: %x, gso_type: =
%x rx_tnl_csum %d\n",
> +                                    dev->name, hdr->hdr.flags,
> +                                    hdr->hdr.gso_type, vi->rx_tnl_csum);
> +               goto frame_err;
> +       }
>
> -       if (virtio_net_hdr_to_skb(skb, &hdr->hdr,
> -                                 virtio_is_little_endian(vi->vdev))) {
> -               net_warn_ratelimited("%s: bad gso: type: %u, size: %u\n",
> +       if (virtio_net_hdr_tnl_to_skb(skb, &hdr->hdr, vi->tnl_offset,

I wonder why virtio_net_chk_data_valid() is not part of the
virtio_net_hdr_tnl_to_skb().

> +                                     vi->rx_tnl_csum,
> +                                     virtio_is_little_endian(vi->vdev)))=
 {
> +               net_warn_ratelimited("%s: bad gso: type: %x, size: %u, fl=
ags %x tunnel %d tnl csum %d\n",
>                                      dev->name, hdr->hdr.gso_type,
> -                                    hdr->hdr.gso_size);
> +                                    hdr->hdr.gso_size, hdr->hdr.flags,
> +                                    vi->tnl_offset, vi->rx_tnl_csum);
>                 goto frame_err;
>         }
>
> @@ -3269,9 +3286,8 @@ static int xmit_skb(struct send_queue *sq, struct s=
k_buff *skb, bool orphan)
>         else
>                 hdr =3D &skb_vnet_common_hdr(skb)->mrg_hdr;
>
> -       if (virtio_net_hdr_from_skb(skb, &hdr->hdr,
> -                                   virtio_is_little_endian(vi->vdev), fa=
lse,
> -                                   0))
> +       if (virtio_net_hdr_tnl_from_skb(skb, &hdr->hdr, vi->tnl_offset,
> +                                       virtio_is_little_endian(vi->vdev)=
, 0))
>                 return -EPROTO;
>
>         if (vi->mergeable_rx_bufs)
> @@ -6775,10 +6791,20 @@ static int virtnet_probe(struct virtio_device *vd=
ev)
>                 if (virtio_has_feature(vdev, VIRTIO_NET_F_HOST_USO))
>                         dev->hw_features |=3D NETIF_F_GSO_UDP_L4;
>
> +               if (virtio_has_feature(vdev, VIRTIO_NET_F_HOST_UDP_TUNNEL=
_GSO)) {
> +                       dev->hw_features |=3D NETIF_F_GSO_UDP_TUNNEL;
> +                       dev->hw_enc_features =3D dev->hw_features;
> +               }
> +               if (dev->hw_features & NETIF_F_GSO_UDP_TUNNEL &&
> +                   virtio_has_feature(vdev, VIRTIO_NET_F_HOST_UDP_TUNNEL=
_GSO_CSUM)) {
> +                       dev->hw_features |=3D NETIF_F_GSO_UDP_TUNNEL_CSUM=
;
> +                       dev->hw_enc_features |=3D NETIF_F_GSO_UDP_TUNNEL_=
CSUM;
> +               }
> +
>                 dev->features |=3D NETIF_F_GSO_ROBUST;
>
>                 if (gso)
> -                       dev->features |=3D dev->hw_features & NETIF_F_ALL=
_TSO;
> +                       dev->features |=3D dev->hw_features;
>                 /* (!csum && gso) case will be fixed by register_netdev()=
 */
>         }
>
> @@ -6879,6 +6905,14 @@ static int virtnet_probe(struct virtio_device *vde=
v)
>         else
>                 vi->hdr_len =3D sizeof(struct virtio_net_hdr);
>
> +       if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO) |=
|
> +           virtio_has_feature(vdev, VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO))
> +               vi->tnl_offset =3D vi->hdr_len;
> +       if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_CS=
UM))
> +               vi->rx_tnl_csum =3D true;
> +       if (vi->tnl_offset)
> +               vi->hdr_len +=3D sizeof(struct virtio_net_hdr_tunnel);
> +
>         if (virtio_has_feature(vdev, VIRTIO_F_ANY_LAYOUT) ||
>             virtio_has_feature(vdev, VIRTIO_F_VERSION_1))
>                 vi->any_header_sg =3D true;
> @@ -7189,6 +7223,10 @@ static struct virtio_device_id id_table[] =3D {
>
>  static unsigned int features[] =3D {
>         VIRTNET_FEATURES,
> +       VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO,
> +       VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_CSUM,
> +       VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO,
> +       VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO_CSUM,
>  };
>
>  static unsigned int features_legacy[] =3D {
> --
> 2.49.0
>

Thanks


