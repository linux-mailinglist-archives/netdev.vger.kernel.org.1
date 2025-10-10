Return-Path: <netdev+bounces-228462-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AFE9BCB4BD
	for <lists+netdev@lfdr.de>; Fri, 10 Oct 2025 02:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F38D9407E87
	for <lists+netdev@lfdr.de>; Fri, 10 Oct 2025 00:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 648B22045B7;
	Fri, 10 Oct 2025 00:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gj3NAgwb"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA171EDA3C
	for <netdev@vger.kernel.org>; Fri, 10 Oct 2025 00:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760056611; cv=none; b=urRly8PDlTOkusYbjyxKY+a3EMYmw6SH1aSapBMIpzhQUDPTw9/DM7NvtGcwfbYvmsFMNThQ5ptOSor65cc7EevFbvfyXgXrrNa/9cpDvgkiMRGE3LiidHkEvAFjBaYFDlfoJEbqvgffCBv0V4F6q8Ej1IZRAttcyl84tbaciUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760056611; c=relaxed/simple;
	bh=mquOhkT2CfnmNOef1BxykItMFTKI6V/1qexnndUEsRM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MBbj+YhpYb1qpjFN6yqwmLOXaDhn80mkq80ku1So0Rb2jeyA2Rvc6G/6vgHjGo0vMHDgjXdzSq7rquYl5WSP+dSLNMwRApG2vAulxgFDZx3QeYOrpIZAr5ah3geAAIU2MD9QfHN6LxR0fR/yh1SVWErzjH+/0S60UR0E6P5WHZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gj3NAgwb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760056608;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kz1dV5dl2eLpvICKmSYU7u5EoVk0dbKJcfh5LF+pC6s=;
	b=gj3NAgwb5Yp1D4uzEeuLiv0LfRfFb0kNtRJWZSLq8RFrJOryrsJIYGSk7Qe13fR5+KBkNl
	A2wr6oeL8VT/6OESvUGB1/MyMLdIc0HUt3JyBDGoC7ICwTNHveyracjdc9xweQulLN/2Ql
	avPD+kxyfextW6yPM1JEdTWi+PUszeg=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-133-URIVlbq2ODWcut3yexd6Qw-1; Thu, 09 Oct 2025 20:36:47 -0400
X-MC-Unique: URIVlbq2ODWcut3yexd6Qw-1
X-Mimecast-MFC-AGG-ID: URIVlbq2ODWcut3yexd6Qw_1760056606
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-33428befc5bso3792614a91.0
        for <netdev@vger.kernel.org>; Thu, 09 Oct 2025 17:36:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760056606; x=1760661406;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kz1dV5dl2eLpvICKmSYU7u5EoVk0dbKJcfh5LF+pC6s=;
        b=b7xFeFpALKddGRF3EzFmR+xHx+wFGbTmggCg3sOwjr/wzAXBsO9fTLyZgmkJssBk3k
         SD/KNsaiaaC37x8kV1oSqJErYDObrSm8d60RMOi3X20gA2+0ZNjRRyF8FI0ByLZlS2LW
         P3792oWWsA5gBEWxZQ1/scSbPhPI2hkhUgg2d6Hxu70vtWVOtaAmqibHGeL5nuVIRfhM
         ybNCVHf3hJ48YWvQ1+UdLi/Qa4GTSvLKMoxPPkYw4FX4GJLu3cWWjRguvpNluIfNrdV/
         D1wt+7F19YO6Ayhf+0WeXxlv8C9mUo3LGVqQ3bQcGQnZesPl+a+WR0dcpc023zqvbsWX
         95hg==
X-Gm-Message-State: AOJu0YzLHTv2Ve6rVWzICuT1RsHklkewdGI62ALfe8erXecpgM3ZqYtS
	K1rFzdv3GcTEpuTzzJcr21Nr7Gvxu5LAgg/fgVre7w7q9Wq58YjSwp3Qy0EO/U8dntGtHRNIA/A
	9GT+WSY5SiTq7356F+H3fx0IAoBoHB5ytXLUseEG0l9PdyyZgBxhNdFQyfbAlF4hWpHI8p0Pmjz
	u5HbtdsIqfsDfllW+pqSLJN4xJtb3tw3k8
X-Gm-Gg: ASbGncvHfR7yeRhqouXCjkKOeBu0lWZni4/MBOMW1J7JBB7N2FW6mjpyHNgMeUyVec1
	7P7ie3oiWgPNx0tI8py7aX2pGTyeO804RS2VRnu4/qX0nipTEhix2J4dDYotwZVYMhOaw1fIfFS
	xYIcmJGtzzwTWXKN3a4MSe4UM=
X-Received: by 2002:a17:90b:4a45:b0:329:cb75:fef2 with SMTP id 98e67ed59e1d1-33b5111731amr12392901a91.3.1760056605872;
        Thu, 09 Oct 2025 17:36:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQhXUYwK3GbRej1U2f24HeIucxQ+cXP/hWDuKOjy8hVQBFUR/n4+32ZNLmo6zlNXL1VfPIJ/3ifyvYGMwXAOc=
X-Received: by 2002:a17:90b:4a45:b0:329:cb75:fef2 with SMTP id
 98e67ed59e1d1-33b5111731amr12392868a91.3.1760056605242; Thu, 09 Oct 2025
 17:36:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925022537.91774-1-xuanzhuo@linux.alibaba.com>
 <20250925022537.91774-3-xuanzhuo@linux.alibaba.com> <CACGkMEvhABOtHTCVW9sX7p0wo1QCMXMvOAD+u4pzBueoU=MCpg@mail.gmail.com>
 <1760008083.6644826-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1760008083.6644826-2-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 10 Oct 2025 08:36:33 +0800
X-Gm-Features: AS18NWDzP344ThhtzISVDUM3jQH0MsG8FSH6w2nI936vgrRw3xVrYKPvtz35OMY
Message-ID: <CACGkMEuYTgK2CVGPTJrAdcJ=GxuhFTSfAc0KGU9=yRHX-7f8-Q@mail.gmail.com>
Subject: Re: [PATCH net 2/2] virtio-net: correct hdr_len handling for VIRTIO_NET_F_GUEST_HDRLEN
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Jiri Pirko <jiri@resnulli.us>, 
	Alvaro Karsz <alvaro.karsz@solid-run.com>, Heng Qi <hengqi@linux.alibaba.com>, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 9, 2025 at 7:10=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.co=
m> wrote:
>
> On Fri, 26 Sep 2025 12:52:53 +0800, Jason Wang <jasowang@redhat.com> wrot=
e:
> > On Thu, Sep 25, 2025 at 10:25=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alib=
aba.com> wrote:
> > >
> > > The commit be50da3e9d4a ("net: virtio_net: implement exact header len=
gth
> > > guest feature") introduces support for the VIRTIO_NET_F_GUEST_HDRLEN
> > > feature in virtio-net.
> > >
> > > This feature requires virtio-net to set hdr_len to the actual header
> > > length of the packet when transmitting, the number of
> > > bytes from the start of the packet to the beginning of the
> > > transport-layer payload.
> > >
> > > However, in practice, hdr_len was being set using skb_headlen(skb),
> > > which is clearly incorrect. This commit fixes that issue.
> > >
> > > Fixes: be50da3e9d4a ("net: virtio_net: implement exact header length =
guest feature")
> > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > ---
> > >  include/linux/virtio_net.h | 19 ++++++++++++-------
> > >  1 file changed, 12 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> > > index 20e0584db1dd..4273420a9ff9 100644
> > > --- a/include/linux/virtio_net.h
> > > +++ b/include/linux/virtio_net.h
> > > @@ -217,20 +217,25 @@ static inline int virtio_net_hdr_from_skb(const=
 struct sk_buff *skb,
> > >
> > >         if (skb_is_gso(skb)) {
> > >                 struct skb_shared_info *sinfo =3D skb_shinfo(skb);
> > > +               u16 hdr_len;
> > >
> > > -               /* This is a hint as to how much should be linear. */
> > > -               hdr->hdr_len =3D __cpu_to_virtio16(little_endian,
> > > -                                                skb_headlen(skb));
> > > +               hdr_len =3D skb_transport_offset(skb);
> > >                 hdr->gso_size =3D __cpu_to_virtio16(little_endian,
> > >                                                   sinfo->gso_size);
> > > -               if (sinfo->gso_type & SKB_GSO_TCPV4)
> > > +               if (sinfo->gso_type & SKB_GSO_TCPV4) {
> > >                         hdr->gso_type =3D VIRTIO_NET_HDR_GSO_TCPV4;
> > > -               else if (sinfo->gso_type & SKB_GSO_TCPV6)
> > > +                       hdr_len +=3D tcp_hdrlen(skb);
> > > +               } else if (sinfo->gso_type & SKB_GSO_TCPV6) {
> > >                         hdr->gso_type =3D VIRTIO_NET_HDR_GSO_TCPV6;
> > > -               else if (sinfo->gso_type & SKB_GSO_UDP_L4)
> > > +                       hdr_len +=3D tcp_hdrlen(skb);
> > > +               } else if (sinfo->gso_type & SKB_GSO_UDP_L4) {
> > >                         hdr->gso_type =3D VIRTIO_NET_HDR_GSO_UDP_L4;
> > > -               else
> >
> > I think we need to deal with the GSO tunnel as well?
> >
> > """
> >     If the \field{gso_type} has the VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV4 =
bit or
> >     VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV6 bit set, \field{hdr_len} account=
s for
> >     all the headers up to and including the inner transport.
> > """
>
> I checked the new code, VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV6
> and VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV4 are not supported, so the next ver=
sion
> will not include these feature.
>
> Thanks.

I may miss something but we had:

        if (skb->protocol =3D=3D htons(ETH_P_IPV6))
                hdr->gso_type |=3D VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV6;
        else
                hdr->gso_type |=3D VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV4;

in virtio_net_hdr_tnl_from_skb() now.

Thanks

>
>
> >
> > > +                       hdr_len +=3D sizeof(struct udphdr);
> > > +               } else {
> > >                         return -EINVAL;
> > > +               }
> > > +
> > > +               hdr->hdr_len =3D __cpu_to_virtio16(little_endian, hdr=
_len);
> >
> > Should we at least check against the feature of VIRTIO_NET_F_GUEST_HDRL=
EN?
> >
> > >                 if (sinfo->gso_type & SKB_GSO_TCP_ECN)
> > >                         hdr->gso_type |=3D VIRTIO_NET_HDR_GSO_ECN;
> > >         } else
> > > --
> > > 2.32.0.3.g01195cf9f
> > >
> >
>


