Return-Path: <netdev+bounces-198881-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A36AAADE200
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 06:08:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 720AB3B37DB
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 04:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8F301E1E1C;
	Wed, 18 Jun 2025 04:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LWpYJPg5"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6549443
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 04:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750219720; cv=none; b=EzjxhsUASbXg3lXotrFjEVHd1SycOvIFBnLYjPA8XZgAMIpbXb1X/VwVG2xmCwWxN24mjXtBY5OYVKxdzik+N/Q8fG1mx17SbbYiNBZZYttJIQLTw1bGehOTOktKXyu/YY9iQ0EWAgGUorTySeX34aSuD0IxtPBRm9lR1AbuY0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750219720; c=relaxed/simple;
	bh=tn/TdDXPi2al9D390UfpiitwUmNbEGwyZdXh8zW6K8M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a7QBBSFMZ7OpXee0iTOCXT1vW9y7PdbIVpxzHeFD6wUmYIK8u+32vic0u6yeGj2oykbdqTPNf8lGYCVbFmgFb0mMJkwd4XzNKkZDn+FwA+oiRzEsKTVXUv++9XqAtx75A9P3lE4eTFVUYXJG1aPLIZehPgLjNAGOJyoD6/Zsm7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LWpYJPg5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750219717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mtt2cOVxjAFmRWRVU9+CcWDTLQU+MQ3stdwXHiJD/nw=;
	b=LWpYJPg5UYBmqEwhv0d0bPr23mGYcHlD4I3ZqYljUNghQejkMpEO1Vim84AMKpKHKHq1Iw
	uH1WKX5Fvz3/uen6QB5fB4DCQqQkQXSk5B3E3kjzfjwAnhQY/DeGG022z8oGqje7dM1aNP
	PoaYSU/aQpfgnPjIcxBhUsqo0z5PuVE=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-572-5_jTi8BqPvWexjXpDAfaag-1; Wed, 18 Jun 2025 00:08:35 -0400
X-MC-Unique: 5_jTi8BqPvWexjXpDAfaag-1
X-Mimecast-MFC-AGG-ID: 5_jTi8BqPvWexjXpDAfaag_1750219714
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3141a9a6888so2625646a91.3
        for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 21:08:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750219714; x=1750824514;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mtt2cOVxjAFmRWRVU9+CcWDTLQU+MQ3stdwXHiJD/nw=;
        b=NFYQp1q9FmOiXm29ddqTho6IBYJAEPIQYgpud9hiyZLdMng9ZV+UfhLVDcmhowpyOH
         PcxwzIkB9+tXTpebZ2Tb6Ve6qZ+YE+hEJwMTUxine2R6SHceAhLkRs4jqYBIhai7CMdh
         DPaWPlmy5b5ivIkFxR6zrAU0AcgWlvwoTxtQ+84tBIwF6FfrAit4jXXBaOS7O7ljAbXq
         bF/dlxl1EtKPmn2JXqSHwtGd2HGlBXxdQcDl9rLLgqHklrzXUqQYqMuF/X35yEN3vtjk
         XZRIsgmW21AFFpN1/pEMGoXBlEPMOjZVtsZhrWdDL0VhVkcokTw02lyQDz6cTsXZJwNz
         W0Qg==
X-Gm-Message-State: AOJu0Yw3pQHfP0ITILjd/SwVOHVDOqzmj2HRyEkXmicAYEE1tHrK8J6N
	R4kCjd2o7ePu+Txxcjj/YOUl1oQgCiUg/2J0x+R9GFuQ6bK+jRaKZB9La650IbtU7ED/tO7flZm
	azmEeBiRYxBHbSwuvK0bwNcEfjLGybASbp6yVcLdn+ltsfnGHeIXNIN6iYHoRr921Nd4ftV7EXr
	jOZVQqZnxJO+5da6oSqowiuC25B0uZ064PIi10EuVactJsLZJ5IBA=
X-Gm-Gg: ASbGncsB5sMaegILyq2EjpVVGnrS21o3Bdgu4mYuKEN2WTm3qq3VvDxQ7B6EhrqB2Ns
	8D/ibmiW6HD9pd5n7Jq5P1rab7zmEYeSazDocAJLGBcmpGGj1RaO13aeHfvWs3P+catpii0TAE3
	GRbw==
X-Received: by 2002:a17:90b:540e:b0:311:ed2:b758 with SMTP id 98e67ed59e1d1-313f1c7d714mr20163416a91.3.1750219713985;
        Tue, 17 Jun 2025 21:08:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEa2/1PdLUIf4h1Rlj/M6ElO1/mH9EJyXR7wmTVi2lKwTUNmQdqNSU5N2GsI7IzTdd/noqx3Wy9mt3KKPbMeEw=
X-Received: by 2002:a17:90b:540e:b0:311:ed2:b758 with SMTP id
 98e67ed59e1d1-313f1c7d714mr20163363a91.3.1750219713420; Tue, 17 Jun 2025
 21:08:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1750176076.git.pabeni@redhat.com> <5385db79f3fdb59c8cbf235ef4453122ef19ae7e.1750176076.git.pabeni@redhat.com>
In-Reply-To: <5385db79f3fdb59c8cbf235ef4453122ef19ae7e.1750176076.git.pabeni@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 18 Jun 2025 12:08:22 +0800
X-Gm-Features: AX0GCFvgJ389CNybsy-Dxvb3-L-kxxF25p6HZmf86adSbavIKD9VmokLiy0UViI
Message-ID: <CACGkMEsx-pcwC=_-cMMMdGZ=E5P-5W=4YoivMQiy=FB1W7GKog@mail.gmail.com>
Subject: Re: [PATCH v4 net-next 5/8] net: implement virtio helpers to handle
 UDP GSO tunneling.
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Yuri Benditovich <yuri.benditovich@daynix.com>, Akihiko Odaki <akihiko.odaki@daynix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 18, 2025 at 12:13=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wr=
ote:
>
> The virtio specification are introducing support for GSO over UDP
> tunnel.
>
> This patch brings in the needed defines and the additional virtio hdr
> parsing/building helpers.
>
> The UDP tunnel support uses additional fields in the virtio hdr, and such
> fields location can change depending on other negotiated features -
> specifically VIRTIO_NET_F_HASH_REPORT.
>
> Try to be as conservative as possible with the new field validation.
>
> Existing implementation for plain GSO offloads allow for invalid/
> self-contradictory values of such fields. With GSO over UDP tunnel we can
> be more strict, with no need to deal with legacy implementation.
>
> Since the checksum-related field validation is asymmetric in the driver
> and in the device, introduce a separate helper to implement the new check=
s
> (to be used only on the driver side).
>
> Note that while the feature space exceeds the 64-bit boundaries, the
> guest offload space is fixed by the specification of the
> VIRTIO_NET_CTRL_GUEST_OFFLOADS_SET command to a 64-bit size.
>
> Prior to the UDP tunnel GSO support, each guest offload bit corresponded
> to the feature bit with the same value and vice versa.
>
> Due to the limited 'guest offload' space, relevant features in the high
> 64 bits are 'mapped' to free bits in the lower range. That is simpler
> than defining a new command (and associated features) to exchange an
> extended guest offloads set.
>
> As a consequence, the uAPIs also specify the mapped guest offload value
> corresponding to the UDP tunnel GSO features.
>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> --
> v3 -> v4:
>   - fixed offset for UDP GSO tunnel, update accordingly the helpers
>   - tried to clarified vlan_hlen semantic
>   - virtio_net_chk_data_valid() -> virtio_net_handle_csum_offload()
>
> v2 -> v3:
>   - add definitions for possible vnet hdr layouts with tunnel support
>
> v1 -> v2:
>   - 'relay' -> 'rely' typo
>   - less unclear comment WRT enforced inner GSO checks
>   - inner header fields are allowed only with 'modern' virtio,
>     thus are always le
>   - clarified in the commit message the need for 'mapped features'
>     defines
>   - assume little_endian is true when UDP GSO is enabled.
>   - fix inner proto type value
> ---
>  include/linux/virtio_net.h      | 196 ++++++++++++++++++++++++++++++--
>  include/uapi/linux/virtio_net.h |  33 ++++++
>  2 files changed, 221 insertions(+), 8 deletions(-)
>
> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index 02a9f4dc594d..449487c914a8 100644
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
> @@ -242,4 +249,177 @@ static inline int virtio_net_hdr_from_skb(const str=
uct sk_buff *skb,
>         return 0;
>  }
>
> +static inline unsigned int virtio_l3min(bool is_ipv6)
> +{
> +       return is_ipv6 ? sizeof(struct ipv6hdr) : sizeof(struct iphdr);
> +}
> +
> +static inline int
> +virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
> +                         const struct virtio_net_hdr_v1_hash_tunnel *vhd=
r,
> +                         bool tnl_hdr_negotiated,
> +                         bool tnl_csum_negotiated,
> +                         bool little_endian)
> +{
> +       const struct virtio_net_hdr *hdr =3D (const struct virtio_net_hdr=
 *)vhdr;
> +       unsigned int inner_nh, outer_th, inner_th;
> +       unsigned int inner_l3min, outer_l3min;
> +       u8 gso_inner_type, gso_tunnel_type;
> +       bool outer_isv6, inner_isv6;
> +       int ret;
> +
> +       gso_tunnel_type =3D hdr->gso_type & VIRTIO_NET_HDR_GSO_UDP_TUNNEL=
;
> +       if (!gso_tunnel_type)
> +               return virtio_net_hdr_to_skb(skb, hdr, little_endian);
> +
> +       /* Tunnel not supported/negotiated, but the hdr asks for it. */
> +       if (!tnl_hdr_negotiated)
> +               return -EINVAL;
> +
> +       /* Either ipv4 or ipv6. */
> +       if (gso_tunnel_type =3D=3D VIRTIO_NET_HDR_GSO_UDP_TUNNEL)
> +               return -EINVAL;
> +
> +       /* The UDP tunnel must carry a GSO packet, but no UFO. */
> +       gso_inner_type =3D hdr->gso_type & ~(VIRTIO_NET_HDR_GSO_ECN |
> +                                          VIRTIO_NET_HDR_GSO_UDP_TUNNEL)=
;
> +       if (!gso_inner_type || gso_inner_type =3D=3D VIRTIO_NET_HDR_GSO_U=
DP)
> +               return -EINVAL;
> +
> +       /* Rely on csum being present. */
> +       if (!(hdr->flags & VIRTIO_NET_HDR_F_NEEDS_CSUM))
> +               return -EINVAL;
> +
> +       /* Validate offsets. */
> +       outer_isv6 =3D gso_tunnel_type & VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IP=
V6;
> +       inner_isv6 =3D gso_inner_type =3D=3D VIRTIO_NET_HDR_GSO_TCPV6;
> +       inner_l3min =3D virtio_l3min(inner_isv6);
> +       outer_l3min =3D ETH_HLEN + virtio_l3min(outer_isv6);
> +
> +       inner_th =3D __virtio16_to_cpu(little_endian, hdr->csum_start);
> +       inner_nh =3D le16_to_cpu(vhdr->inner_nh_offset);
> +       outer_th =3D le16_to_cpu(vhdr->outer_th_offset);
> +       if (outer_th < outer_l3min ||
> +           inner_nh < outer_th + sizeof(struct udphdr) ||
> +           inner_th < inner_nh + inner_l3min)
> +               return -EINVAL;
> +
> +       /* Let the basic parsing deal with plain GSO features. */
> +       ret =3D __virtio_net_hdr_to_skb(skb, hdr, true,
> +                                     hdr->gso_type & ~gso_tunnel_type);
> +       if (ret)
> +               return ret;
> +
> +       /* In case of USO, the inner protocol is still unknown and
> +        * `inner_isv6` is just a guess, additional parsing is needed.
> +        * The previous validation ensures that accessing an ipv4 inner
> +        * network header is safe.
> +        */
> +       if (gso_inner_type =3D=3D VIRTIO_NET_HDR_GSO_UDP_L4) {
> +               struct iphdr *iphdr =3D (struct iphdr *)(skb->data + inne=
r_nh);
> +
> +               inner_isv6 =3D iphdr->version =3D=3D 6;
> +               inner_l3min =3D virtio_l3min(inner_isv6);
> +               if (inner_th < inner_nh + inner_l3min)
> +                       return -EINVAL;
> +       }
> +
> +       skb_set_inner_protocol(skb, inner_isv6 ? htons(ETH_P_IPV6) :
> +                                                htons(ETH_P_IP));
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
> +       skb->inner_network_header =3D inner_nh + skb_headroom(skb);
> +       skb->inner_mac_header =3D inner_nh + skb_headroom(skb);
> +       skb->transport_header =3D outer_th + skb_headroom(skb);
> +       skb->encapsulation =3D 1;
> +       return 0;
> +}
> +
> +/* Checksum-related fields validation for the driver */
> +static inline int virtio_net_handle_csum_offload(struct sk_buff *skb,
> +                                                struct virtio_net_hdr *h=
dr,
> +                                                bool tnl_csum_negotiated=
)
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
> +               if (!tnl_csum_negotiated)
> +                       return -EINVAL;
> +               skb->csum_level =3D 1;
> +               return 0;
> +       }
> +
> +       /* DATA_VALID is mutually exclusive with NEEDS_CSUM, and GSO
> +        * over UDP tunnel requires the latter
> +        */
> +       if (hdr->flags & VIRTIO_NET_HDR_F_DATA_VALID)
> +               return -EINVAL;
> +       return 0;
> +}
> +
> +/*
> + * vlan_hlen always refers to the outermost MAC header. That also
> + * means it refers to the only MAC header, if the packet does not carry
> + * any encapsulation.
> + */
> +static inline int
> +virtio_net_hdr_tnl_from_skb(const struct sk_buff *skb,
> +                           struct virtio_net_hdr_v1_hash_tunnel *vhdr,
> +                           bool tnl_hdr_negotiated,
> +                           bool little_endian,

Nit: it looks to me we can just accept netdev_features_t here.

Others look good.

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


