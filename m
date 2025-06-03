Return-Path: <netdev+bounces-194685-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 349AFACBE68
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 04:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A9311890791
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 02:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5762D156C69;
	Tue,  3 Jun 2025 02:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A1FaJRhb"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F91D156236
	for <netdev@vger.kernel.org>; Tue,  3 Jun 2025 02:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748916705; cv=none; b=sWyDButHYmVp17+1yJfoyb16vu5IXpSkgdTwU6wWERptb87R7s7ThMUJ9L2Tn5zEF9UOG8LQjFKOvqjZt0EeSX2K032LuP6xUuddySEjoMLqgJDqLsXChJ+xQPjj2GOLVVt1+Jy6BlMxtCG9JVSy1NWRoUiejljGvfStKhP/CxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748916705; c=relaxed/simple;
	bh=RCuJUDntUcdPB0EecGEkoZ+o+xF+bWibCYcsjW+x5dk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=exnafmBouq0I5nC6oR6NDFeQWBB15/AfthLgssZjA/nxcGlyAgkicPj8vHddtFeJvf4FKfKOTcVg6JRLiJWfiwLHPDN/xsqkoN/HuyLXgm3WCno9zSZHMzk7d/AfZR0eG7Z7D1AmQrP8kldIiC0R9lDt2QioIJ2lvjTlPUTGchQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A1FaJRhb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748916702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tPc9hdSIPxvCtPoo6ppSHHF9P6uU1YmHz5aVIXx8XN8=;
	b=A1FaJRhbsNWpx4PUA3/ncXDVo3ho8zBnfTPG72xxBukCkz9lf14Bp6T1/khM1eOUL2PWzb
	U+LtUp6GeoDnbauj1iooq76Mqj2hWPQnrzt5WtRYzYhAtJ5vh+bpIojytq29rdmsgLj7C/
	rRpi0Nsktb4DW6SYFVJJL6zzoA2LqRM=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-201-azk-qMTZMVmiQGFZEbGGgw-1; Mon, 02 Jun 2025 22:11:40 -0400
X-MC-Unique: azk-qMTZMVmiQGFZEbGGgw-1
X-Mimecast-MFC-AGG-ID: azk-qMTZMVmiQGFZEbGGgw_1748916700
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-31215238683so4184601a91.2
        for <netdev@vger.kernel.org>; Mon, 02 Jun 2025 19:11:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748916699; x=1749521499;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tPc9hdSIPxvCtPoo6ppSHHF9P6uU1YmHz5aVIXx8XN8=;
        b=eGncMPocEySH4zZHK7zFj8fkOn4s5+clntNd3e4xPRYhaNYbLF+/wiyl1pK7KgTmPG
         GLDKkGM6hM8sdEBIDjKO8lgoDPmbbfj+8nLSu6mgZZSVzL5HOr2S48jlwHCIKx+tNPJ6
         lCbLr5pJLqKWLxNKbC0YRSMWfMquxMCiULExYtwrBlDmJt9GrTgw+IpyNXDTTRZvPnZV
         gGw6U5uCwzBUPpPUT27qu5T660955bIe0jYcQMvGNYgUPcURsJ+Yzvxq9XS7ALfsT8br
         WSYA0+IvS4/WnZcJmIU+pENZXwjmJnd8PHzjqXGW/Vt2+OGq+4byq5IbdYWhV5s/MRs1
         ecCQ==
X-Gm-Message-State: AOJu0YyMkHlCl2scHrnv+dN3rNDgzsYCg546HfweQAckiSzqXcgLPVb5
	cQd4L/ie5Jrdfkno6jrn068kIDtrkwGVneoIB2ycjx8jNDGexL/VLlMd1LOS2QmZCKkQOheVuA6
	tv5fDfhk6T/bkEzUdjbv/8uN7wwOZn5+FfKQXiTfftXaoicrt0FfSWFID55Ckd3150wgq/5Lq+f
	L3Q/GzgXAASunncP6mrh07pRVhM/kNnx8Q
X-Gm-Gg: ASbGncuklBMLv56NGH8LfPU5eLz90YaYZqvKFvOkCABEsgqXONEGcobIzQSLmD4Ls6h
	fIoUsnycRXHPCZjGXcA0GN+Q7rqRIejsr4d+jDRRmxg/UtfrfcV1G00cO7/g1W9dSYJAkhna3FP
	Jkw2qy
X-Received: by 2002:a17:90a:c2cc:b0:311:ea13:2e6d with SMTP id 98e67ed59e1d1-3127c736520mr15718862a91.29.1748916699550;
        Mon, 02 Jun 2025 19:11:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNm0g2jAiqQspGndCkO3l+UhiAcOPF/SDhZigAuqb5NIXOst6FBs/MnZxxkvG8gG3ZUvBUipGq+E8K2DMdNOs=
X-Received: by 2002:a17:90a:c2cc:b0:311:ea13:2e6d with SMTP id
 98e67ed59e1d1-3127c736520mr15718831a91.29.1748916699091; Mon, 02 Jun 2025
 19:11:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1747822866.git.pabeni@redhat.com> <6e001d160707e1cf87870acee5adc302f8cb39b6.1747822866.git.pabeni@redhat.com>
 <CACGkMEtkbx8VZ2HAuDUbO9LStzoM6JQVcmA+6e+jM1o=r9wKow@mail.gmail.com> <3c2290f1-827c-452d-a818-bd89f4cbbcba@redhat.com>
In-Reply-To: <3c2290f1-827c-452d-a818-bd89f4cbbcba@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 3 Jun 2025 10:11:27 +0800
X-Gm-Features: AX0GCFvqpE3WhMIDkG0rEAAEdhtaKsDjrZZryK1ZOmObgQh0rmtrYuESgr4crUw
Message-ID: <CACGkMEu40tJYBuXmkEzJ5MeYHQcZBri2e7iKq9RiU20bSk9T-Q@mail.gmail.com>
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

On Thu, May 29, 2025 at 7:55=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 5/26/25 6:40 AM, Jason Wang wrote:
> > On Wed, May 21, 2025 at 6:34=E2=80=AFPM Paolo Abeni <pabeni@redhat.com>=
 wrote:
> >> +       if (!gso_inner_type || gso_inner_type =3D=3D VIRTIO_NET_HDR_GS=
O_UDP)
> >> +               return -EINVAL;
> >> +
> >> +       /* Relay on csum being present. */
> >> +       if (!(hdr->flags & VIRTIO_NET_HDR_F_NEEDS_CSUM))
> >> +               return -EINVAL;
> >> +
> >> +       /* Validate offsets. */
> >> +       outer_isv6 =3D gso_tunnel_type & VIRTIO_NET_HDR_GSO_UDP_TUNNEL=
_IPV6;
> >> +       inner_l3min =3D virtio_l3min(gso_inner_type =3D=3D VIRTIO_NET_=
HDR_GSO_TCPV6);
> >> +       outer_l3min =3D ETH_HLEN + virtio_l3min(outer_isv6);
> >> +
> >> +       tnl =3D ((void *)hdr) + tnl_hdr_offset;
> >> +       inner_th =3D __virtio16_to_cpu(little_endian, hdr->csum_start)=
;
> >> +       inner_nh =3D __virtio16_to_cpu(little_endian, tnl->inner_nh_of=
fset);
> >> +       outer_th =3D __virtio16_to_cpu(little_endian, tnl->outer_th_of=
fset);
> >> +       if (outer_th < outer_l3min ||
> >> +           inner_nh < outer_th + sizeof(struct udphdr) ||
> >> +           inner_th < inner_nh + inner_l3min)
> >> +               return -EINVAL;
> >
> > I wonder if kernel has already had helpers to validate the tunnel
> > headers
>
> Not that I know of.
>
> > or if the above check is sufficient here.
>
> AFAICS yes. Syzkaller is out there just to prove me wrong...
>
>
> >> +
> >> +       /* Let the basic parsing deal with plain GSO features. */
> >> +       ret =3D __virtio_net_hdr_to_skb(skb, hdr, little_endian,
> >> +                                     hdr->gso_type & ~gso_tunnel_type=
);
> >> +       if (ret)
> >> +               return ret;
> >> +
> >> +       skb_set_inner_protocol(skb, outer_isv6 ? htons(ETH_P_IPV6) :
> >> +                                                htons(ETH_P_IP));
> >
> > The outer_isv6 is somehow misleading here, I think we'd better rename
> > it as inner_isv6?
>
> There is bug above, thanks for spotting it. I should not use the
> `outer_isv6` variable, instead I should compute separately `inner_isv6`
>
> >> +       if (hdr->flags & VIRTIO_NET_HDR_F_UDP_TUNNEL_CSUM) {
> >> +               if (!tnl_csum_negotiated)
> >> +                       return -EINVAL;
> >> +
> >> +               skb_shinfo(skb)->gso_type |=3D SKB_GSO_UDP_TUNNEL_CSUM=
;
> >> +       } else {
> >> +               skb_shinfo(skb)->gso_type |=3D SKB_GSO_UDP_TUNNEL;
> >> +       }
> >> +
> >> +       skb->inner_transport_header =3D inner_th + skb_headroom(skb);
> >
> > I may miss something but using skb_headroom() means the value depends
> > on the geometry of the skb and the headroom might vary depending on
> > the size of the packet and other factors.  (see receive_buf())
>
> Yes, that is correct: the actual inner_transport_header value depends on
> the skb geometry, because the (inner) transport header is located at
> skb->head + skb->inner_transport_header.


Right, I see. Btw, is skb_set_inner_transport_header() considered to
be better here?

>
> >> +       skb->inner_network_header =3D inner_nh + skb_headroom(skb);
> >> +       skb->inner_mac_header =3D inner_nh + skb_headroom(skb);
> >
> > This actually equals to inner_network_header, is this intended?
>
> Yes. AFAICS the inner mac header field is used only for GSO/TSO.
>
> At this point we don't know if the inner mac header is actually present
> nor it's len (could include vlan tag).
>
> Still the above allows correct segmentation by the GSO stage because the
> inner mac header is not copied verbatim in the segmented packets, alike
> the tunnel header.
>
> With the above code, the inner mac header if really present will be
> logically considered part of the tunnel header by the GSO stage.
>
> Note that some devices restrict the TSO capability to some fixed values
> of the UDP tunnel sizes and inner mac header. In such cases, they will
> fallback to S/W GSO.

Ok.

>
> >> +       skb->transport_header =3D outer_th + skb_headroom(skb);
> >> +       skb->encapsulation =3D 1;
> >> +       return 0;
> >> +}
> >> +
> >> +static inline int virtio_net_chk_data_valid(struct sk_buff *skb,
> >> +                                           struct virtio_net_hdr *hdr=
,
> >> +                                           bool tun_csum_negotiated)
> >
> > This is virtio_net.h so it's better to avoid using "tun". Btw, I
> > wonder why this needs to be called by the virtio-net instead of being
> > called by hdr_to_skb helpers.
>
> I can squash into virtio_net_hdr_tnl_to_skb(), I kept them separated to
> avoid extra long argument lists, but we are dropping an argument from
> virtio_net_hdr_tnl_to_skb(), so should be ok.
>
> >> +{
> >> +       if (!(hdr->gso_type & VIRTIO_NET_HDR_GSO_UDP_TUNNEL)) {
> >> +               if (!(hdr->flags & VIRTIO_NET_HDR_F_DATA_VALID))
> >> +                       return 0;
> >> +
> >> +               skb->ip_summed =3D CHECKSUM_UNNECESSARY;
> >> +               if (!(hdr->flags & VIRTIO_NET_HDR_F_UDP_TUNNEL_CSUM))
> >> +                       return 0;
> >> +
> >> +               /* tunnel csum packets are invalid when the related
> >> +                * feature has not been negotiated
> >> +                */
> >> +               if (!tun_csum_negotiated)
> >> +                       return -EINVAL;
> >
> > Should we move this check above VIRTIO_NET_HDR_F_DATA_VALID check?
>
> It could break existing setups. We can safely do extra validation only
> when we know that the UDP tunnel features have been negotiated.

You are right.

>
> >> +               skb->csum_level =3D 1;
> >> +               return 0;
> >> +       }
> >> +
> >> +       /* DATA_VALID is mutually exclusive with NEEDS_CSUM,
> >
> > I may miss something but I think we had a discussion about this, and
> > the conclusion is it's too late to fix as it may break some legacy
> > devices?
>
> I'm not sure what should be fixed here? This check implements exactly
> restriction you asked for while discussing the spec. We can't have a
> similar check for non UDP tunneled packets, because it could break
> existing setup.

Right.

>
> >
> >> and GSO
> >> +        * over UDP tunnel requires the latter
> >> +        */
> >> +       if (hdr->flags & VIRTIO_NET_HDR_F_DATA_VALID)
> >> +               return -EINVAL;
> >> +       return 0;
> >> +}
> >> +
> >> +static inline int virtio_net_hdr_tnl_from_skb(const struct sk_buff *s=
kb,
> >> +                                             struct virtio_net_hdr *h=
dr,
> >> +                                             unsigned int tnl_offset,
> >> +                                             bool little_endian,
> >> +                                             int vlan_hlen)
> >> +{
> >> +       struct virtio_net_hdr_tunnel *tnl;
> >> +       unsigned int inner_nh, outer_th;
> >> +       int tnl_gso_type;
> >> +       int ret;
> >> +
> >> +       tnl_gso_type =3D skb_shinfo(skb)->gso_type & (SKB_GSO_UDP_TUNN=
EL |
> >> +                                                   SKB_GSO_UDP_TUNNEL=
_CSUM);
> >> +       if (!tnl_gso_type)
> >> +               return virtio_net_hdr_from_skb(skb, hdr, little_endian=
, false,
> >> +                                              vlan_hlen);
> >> +
> >> +       /* Tunnel support not negotiated but skb ask for it. */
> >> +       if (!tnl_offset)
> >> +               return -EINVAL;
> >
> > Should we do BUG_ON here?
>
> I don't think so. BUG_ON()s are explicitly discouraged to avoid crashing
> the kernel on exceptional/unexpected situation.
>
> The caller will emit rate limited warns with the relevant info, if this
> is hit. The BUG_ON() stack trace will add little value.

Ok.

>
> >> +
> >> +       /* Let the basic parsing deal with plain GSO features. */
> >> +       skb_shinfo(skb)->gso_type &=3D ~tnl_gso_type;
> >> +       ret =3D virtio_net_hdr_from_skb(skb, hdr, little_endian, false=
,
> >> +                                     vlan_hlen);
> >> +       skb_shinfo(skb)->gso_type |=3D tnl_gso_type;
> >> +       if (ret)
> >> +               return ret;
> >
> > Could we do the plain GSO after setting inner flags below to avoid
> > masking and unmasking tnl_gso_type?
>
> virtio_net_hdr_from_skb() will still receive a skb with UDP tunnel GSO
> type and will error out.
>
> The masking coudl be avoided factoring out a __virtio_net_hdr_from_skb()
> helper receiving an explicit gso_type argument. I can do that if it's
> preferred.

That would be fine.

Thanks

>
> /P
>


