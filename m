Return-Path: <netdev+bounces-196797-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1296AD6648
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 05:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C78A11BC1658
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 03:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9D91C7013;
	Thu, 12 Jun 2025 03:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fANYywxY"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3E51A5B92
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 03:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749700414; cv=none; b=pWsYp2w3ZhiVnH37VgtPF7397fhuxhTCJc5ILCIzTNw/Ne5I37ZLxz7KDxoy0jsaCfcW33ISFzlWuzeVbvw1mJSpLj1/8lQ7XIZGagLX+xkXLFnNlx5v+tc9GM5XfelzXmYqoIIpNZ94CT+VFoy/XSUPfwyW75zStTOgqadgM90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749700414; c=relaxed/simple;
	bh=UQFPhwA2CE4EPLQFJPF4JdVZ3+XmTw0MlNKRG5V6wVQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hhwOrOI2/pYverljZyWTWay98XX9ChnCvgPOU3m3911Gs6DvOLT9GsVq5Lo1wbrTVXCcCuI9ZmU+jWnracStpeuHcx29TnupegHFN9dBvGARy7RUOsbuQdG6sEsVnPJdHTuYEcJBlGndP8LT+Yjy+IL7hCkrWRBvGWhrbUPPm5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fANYywxY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749700410;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zIp4YbG4cKC+G2TakTUGZ0yJXKU0O/Km/eaocaG8ISQ=;
	b=fANYywxYjF2JtZef7rKUcBi0xZ/IhPYXnDHLjVa9QZg0ekgDKfBiEZNNVL3A5qFOJyyvjr
	lfFkyj8gIhT8OI3azmlm1H1YH4vd3bjv412m1rc/sPMCVT3q6VxRM3d/ZY3RnxHerwlCYb
	ljqk46loO9XppgXcuEVryEwocS015Zk=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-328-n_F2WPlpOfGcmHTj7B_MaA-1; Wed, 11 Jun 2025 23:53:28 -0400
X-MC-Unique: n_F2WPlpOfGcmHTj7B_MaA-1
X-Mimecast-MFC-AGG-ID: n_F2WPlpOfGcmHTj7B_MaA_1749700407
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2358430be61so4241855ad.2
        for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 20:53:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749700407; x=1750305207;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zIp4YbG4cKC+G2TakTUGZ0yJXKU0O/Km/eaocaG8ISQ=;
        b=t++k7/fChX6LRDU0/74tMoog7TfFliiZ3b4L+cnziNhmzrAjojAzT2N1ESFC29vB/O
         d8UAPbb308IERVyG16nIuJkiZFzhZPpeDWKhiGSNZScMcUIV5DBhYuWmOhMYzOWb9EYy
         awGoNJlwUAyyQ7Se+6T/AbVp37fevJcVITDwpgaZ7sXHPq4ntzOj9eZeZFypNwmWzC5p
         CV6QeskHcF6z4fQdbMMQv0p045i5kyORIaIilonf8IB/H6Q9GRKzcMrlvqIqK+KUqMKD
         fH9YWXNNWiHcboYfy6R+RqkPxhOpWm/otpJgXXgcnWjk3iA/TJa+gD6cTabIq/8pIBsO
         Ao3Q==
X-Gm-Message-State: AOJu0YzvyyxWTj9DNQ03I/qg01acaVHCTdxMYDL/ZbVF4/R4X25DiFUM
	76oqkyfZpL828IAhJiX+pLQZ/ftYNB5y7ybLn74GgaJ4nlTNH3wiSPTAiBrZS5cHnOO3DcflEB8
	P2Tz76xujyFeHmGn9ZuplEg9vE3G0Y94dXs9dhLaaL5NuesKQert7h3FCl010/O66X76mfJoacu
	qkX85zqhsnl9DJIoJZWkU8pJB+WpuoPYW4
X-Gm-Gg: ASbGncvZHqPy4rA3Aupl8rcr5uOoN6Lj3b7w+wPWfe+AvpTmXS75xGE+0yNcWPsn2IO
	2abw8KpdQsAV+sroUBJpHf+UydEDHKqIP1NkCX8N3YLafvGHt3VNRFR4Exzem2mJk142RQ7AgvK
	hR
X-Received: by 2002:a17:903:3c4c:b0:235:f55d:99cd with SMTP id d9443c01a7336-2364c8e1ac5mr25555175ad.9.1749700406856;
        Wed, 11 Jun 2025 20:53:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwncgZZsuruWEg2h9hk0mkZbHi/ALpe4DBj/Mwxo2uBEMgxm4KcNRgDFAVIEyETjJWCRi1F5OVB0RIlP5Oy+E=
X-Received: by 2002:a17:903:3c4c:b0:235:f55d:99cd with SMTP id
 d9443c01a7336-2364c8e1ac5mr25554805ad.9.1749700406400; Wed, 11 Jun 2025
 20:53:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1749210083.git.pabeni@redhat.com> <fa6c0bbe268dfdd6981741580efc084d101c1e7d.1749210083.git.pabeni@redhat.com>
In-Reply-To: <fa6c0bbe268dfdd6981741580efc084d101c1e7d.1749210083.git.pabeni@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 12 Jun 2025 11:53:15 +0800
X-Gm-Features: AX0GCFtpuVFR75LJLaAaeUKkWrUzUTPmnQ9w-3WN7MLNmtGVfVCciG5_y5AKaXY
Message-ID: <CACGkMEsBsX-3ztNkQTH+J_32LcFaMwv-pOpTX0rXdLMmCj+JAA@mail.gmail.com>
Subject: Re: [PATCH RFC v3 5/8] net: implement virtio helpers to handle UDP
 GSO tunneling.
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
>  include/linux/virtio_net.h      | 191 ++++++++++++++++++++++++++++++--
>  include/uapi/linux/virtio_net.h |  43 +++++++
>  2 files changed, 226 insertions(+), 8 deletions(-)
>
> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index 02a9f4dc594d..bcf80534a739 100644
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
> @@ -242,4 +249,172 @@ static inline int virtio_net_hdr_from_skb(const str=
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
> +{
> +       u8 gso_tunnel_type =3D hdr->gso_type & VIRTIO_NET_HDR_GSO_UDP_TUN=
NEL;
> +       unsigned int inner_nh, outer_th, inner_th;
> +       unsigned int inner_l3min, outer_l3min;
> +       struct virtio_net_hdr_tunnel *tnl;
> +       bool outer_isv6, inner_isv6;
> +       u8 gso_inner_type;
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
> +       tnl =3D ((void *)hdr) + tnl_hdr_offset;
> +       inner_th =3D __virtio16_to_cpu(little_endian, hdr->csum_start);
> +       inner_nh =3D le16_to_cpu(tnl->inner_nh_offset);
> +       outer_th =3D le16_to_cpu(tnl->outer_th_offset);
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
> +static inline int virtio_net_chk_data_valid(struct sk_buff *skb,
> +                                           struct virtio_net_hdr *hdr,
> +                                           bool tnl_csum_negotiated)
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

So tun_vnet_hdr_from_skb() has

        int vlan_hlen =3D skb_vlan_tag_present(skb) ? VLAN_HLEN : 0;
        int tnl_offset =3D tun_vnet_tnl_offset(flags);

        if (virtio_net_hdr_tnl_from_skb(skb, hdr, tnl_offset,
                                        tun_vnet_is_little_endian(flags),
                                        vlan_hlen)) {


It looks like the outer vlan_hlen is used for the inner here?

> +
> +       /* Tunnel support not negotiated but skb ask for it. */
> +       if (!tnl_offset)
> +               return -EINVAL;
> +
> +       /* Let the basic parsing deal with plain GSO features. */
> +       skb_shinfo(skb)->gso_type &=3D ~tnl_gso_type;
> +       ret =3D virtio_net_hdr_from_skb(skb, hdr, true, false, vlan_hlen)=
;
> +       skb_shinfo(skb)->gso_type |=3D tnl_gso_type;
> +       if (ret)
> +               return ret;
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
> +       tnl->inner_nh_offset =3D cpu_to_le16(inner_nh);
> +       tnl->outer_th_offset =3D cpu_to_le16(outer_th);
> +       return 0;
> +}
> +
>  #endif /* _LINUX_VIRTIO_NET_H */
> diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_=
net.h
> index 963540deae66..313761be99b2 100644
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
> @@ -181,6 +208,22 @@ struct virtio_net_hdr_v1_hash {
>         __le16 padding;
>  };
>
> +/* This header after hashing information */
> +struct virtio_net_hdr_tunnel {
> +       __le16 outer_th_offset;
> +       __le16 inner_nh_offset;
> +};
> +
> +struct virtio_net_hdr_v1_tunnel {
> +       struct virtio_net_hdr_v1 hdr;
> +       struct virtio_net_hdr_tunnel tnl;
> +};
> +
> +struct virtio_net_hdr_v1_hash_tunnel {
> +       struct virtio_net_hdr_v1_hash hdr;
> +       struct virtio_net_hdr_tunnel tnl;
> +};

Not a native speaker but I realize there's probably an issue:

        le32 hash_value;        (Only if VIRTIO_NET_F_HASH_REPORT negotiate=
d)
        le16 hash_report;       (Only if VIRTIO_NET_F_HASH_REPORT negotiate=
d)
        le16 padding_reserved;  (Only if VIRTIO_NET_F_HASH_REPORT negotiate=
d)
        le16 outer_th_offset    (Only if
VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO or VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO
negotiated)
        le16 inner_nh_offset;   (Only if
VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO or VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO
negotiated)
        le16 outer_nh_offset;   /* Only if VIRTIO_NET_F_OUT_NET_HEADER
negotiated */
        /* Only if VIRTIO_NET_F_OUT_NET_HEADER or VIRTIO_NET_F_IPSEC
negotiated */
        union {
                u8 padding_reserved_2[6];
                struct ipsec_resource_hdr {
                        le32 resource_id;
                        le16 resource_type;
                } ipsec_resource_hdr;
        };

I thought e.g outer_th_offset should have a fixed offset then
everything is simplified but it looks not the case here. If we decide
to do things like this, we will end up with a very huge uAPI
definition for different features combinations. This doesn't follow
the existing headers for example num_buffers exist no matter if
MRG_RXBUF is negotiated.

At least, if we decide to go with the dynamic offset, it seems less
valuable to define those headers with different combinations if both
device and driver process the vnet header piece wisely

> +
>  #ifndef VIRTIO_NET_NO_LEGACY
>  /* This header comes first in the scatter-gather list.
>   * For legacy virtio, if VIRTIO_F_ANY_LAYOUT is not negotiated, it must
> --
> 2.49.0
>

Thanks


