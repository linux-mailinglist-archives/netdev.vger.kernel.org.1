Return-Path: <netdev+bounces-197936-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33851ADA6BE
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 05:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42C143A2FF0
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 03:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B722986329;
	Mon, 16 Jun 2025 03:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fUoAy+1n"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4C878F45
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 03:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750043878; cv=none; b=TRxTcACYwESZRJxLXNvQhCix9YnWvDrDK0WH9nIb6IdBHN9S6/r7vT8MrkC1gDFs7EL0opAWISlrrpDKLW/weRGI6fSnbjlFPz4mfyc9rxi7nGxJ26hMSWNKlaBRLH135RjLTz0AdLnSmMXTM3c8FAAqgM3K2L6VtfLRBC+2jg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750043878; c=relaxed/simple;
	bh=bcO49NRSg6tayxVkmPp6mFUy0319Yj6GtYa/L4MfNo4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EW70woT75F3VStkChg3AE7DhLWkuU6UkgL4Iwpcq1Ejdj8e+ymTxb69qP3lBfbXQegnkxRlCy+vdwhO1CnxEjb9DyvBpJIkaQdIfN+NSwxK1iiWGRAH8fcSVYAko0PsNEyC0JUNfT64e/nhZ8fiH7G6SsasebgVKuwlTfuBBfT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fUoAy+1n; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750043875;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QPNoVJ8bO6WJupVjhGNwIWzjAtlK/86/qpWF1MKm7pU=;
	b=fUoAy+1nwIot63etluApWbyDXvkxpwOP1GwZqkSNkb7hDtltiJS6QR3cCYfxVtMRi2X1LO
	JZRsvjjimIE8G9zf0eSLgYPFaiT8AoYbpADECNee80ee93tT/R37DZzK+/O6B+8B9RWoyk
	mJp757dtrTn6VfrUOsJDpWIregbvtIg=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-152-eI8bffH7OvSzDIeG9gdSsg-1; Sun, 15 Jun 2025 23:17:53 -0400
X-MC-Unique: eI8bffH7OvSzDIeG9gdSsg-1
X-Mimecast-MFC-AGG-ID: eI8bffH7OvSzDIeG9gdSsg_1750043873
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b2eb60594e8so2484966a12.1
        for <netdev@vger.kernel.org>; Sun, 15 Jun 2025 20:17:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750043873; x=1750648673;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QPNoVJ8bO6WJupVjhGNwIWzjAtlK/86/qpWF1MKm7pU=;
        b=quXnHC6S3s0ouDRaWkxz77uqRZOpOaPyvFVjRxFUJNHKmkGGXy8BhuDjVnkwSW2vNb
         AoGwy37QVMovYRZ6gq+ZwisR+pFjB8G8Okb6myP99XMW1peeVHcsN3pKnwgf4DjWM7rw
         0Glh2t1+db5q0i6temXVo3FqpnSGbxRuiUqQZZUILC0E4NdCTTVaYHGvIGNvidgcXux9
         L3Iar/a2UImRSLeceALEgWdIhgTd7baE8sKg3mvSPK9BOcY0NKhGFxcgiEkXBH0iv1Ro
         S+D8oVCtt+nXeXvyk6GwzjGu9eXJS9tGPTHsBjfWgckbXfUlXg/92KMslIZZsT+xwPnE
         xt/w==
X-Gm-Message-State: AOJu0YxAsk9jVheAGmqx0uL8+P/mFZzwP6Li0ebwG+XtCTxEBpQCYvLW
	dwpl/iooyE6byHEhZ/fItbE0AetezhoyCGL51THHJ/r+41Ad+KjI6eJJF3oRtaqieNwWmVIvBzd
	c/h2h+zuFspJYV/dWDYv9+5ZHUXgIU/strMC1EBQWLIleF/Hh83YlxOTwNh5w0KqgsVO7731DUO
	bKOhHVA4htmLAYsAwfvYmPheMGWTS73LLo
X-Gm-Gg: ASbGncveBPzbX5jv5lvPzeF7sBc7WTDum3/gdqbk/PYQlyzJLq224uxmVn7AL+4Y+vb
	MfOpf01VTDOtQuYkldpeXuLeSEF6Bi7IHNDLgHPQlZiFkPjIBm7oITHwu0yBAHeqcsvVVmbPWnP
	FMng==
X-Received: by 2002:a05:6a21:689:b0:21a:b9d4:ad73 with SMTP id adf61e73a8af0-21fbd8003damr12523901637.40.1750043872783;
        Sun, 15 Jun 2025 20:17:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHtA26azy+rcHKI0Qtl5DW8Roq6gyXWaJIx1jz/wEUb7xn8qIhk0BwSmqVYLqwifxsZKQpYRC0oi9MG6GqtkYg=
X-Received: by 2002:a05:6a21:689:b0:21a:b9d4:ad73 with SMTP id
 adf61e73a8af0-21fbd8003damr12523861637.40.1750043872355; Sun, 15 Jun 2025
 20:17:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1749210083.git.pabeni@redhat.com> <fa6c0bbe268dfdd6981741580efc084d101c1e7d.1749210083.git.pabeni@redhat.com>
 <CACGkMEsBsX-3ztNkQTH+J_32LcFaMwv-pOpTX0rXdLMmCj+JAA@mail.gmail.com> <e0e6139b-8afd-45ea-8396-b872245d398c@redhat.com>
In-Reply-To: <e0e6139b-8afd-45ea-8396-b872245d398c@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 16 Jun 2025 11:17:41 +0800
X-Gm-Features: AX0GCFuT8DpWw_WIYKxQkTkmyaah4Mqvan6saWvQOeaRYRw4Rdd5G0IVX0S1jlM
Message-ID: <CACGkMEvQ0XKR8P_XVt=GU8n=_0_ugVDw1bmm-xqAJsKfDZ-3xw@mail.gmail.com>
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

On Thu, Jun 12, 2025 at 6:10=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 6/12/25 5:53 AM, Jason Wang wrote:
> > On Fri, Jun 6, 2025 at 7:46=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> =
wrote:
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
> >> +
> SKB_GSO_UDP_TUNNEL_CSUM);
> >> +       if (!tnl_gso_type)
> >> +               return virtio_net_hdr_from_skb(skb, hdr,
> little_endian, false,
> >> +                                              vlan_hlen);
> >
> > So tun_vnet_hdr_from_skb() has
> >
> >         int vlan_hlen =3D skb_vlan_tag_present(skb) ? VLAN_HLEN : 0;
> >         int tnl_offset =3D tun_vnet_tnl_offset(flags);
> >
> >         if (virtio_net_hdr_tnl_from_skb(skb, hdr, tnl_offset,
> >                                         tun_vnet_is_little_endian(flags=
),
> >                                         vlan_hlen)) {
> >
> >
> > It looks like the outer vlan_hlen is used for the inner here?
> vlan_hlen always refers to the outer vlan tag (if present), as it moves
> the (inner) transport csum offset accordingly.
>
> I can a comment to clarify the parsing.
>
> Note that in the above call there is a single set of headers (no
> encapsulation) so the vlan_hlen should be unambigous.

I see.

> >> +
> >> +       /* Tunnel support not negotiated but skb ask for it. */
> >> +       if (!tnl_offset)
> >> +               return -EINVAL;
> >> +
> >> +       /* Let the basic parsing deal with plain GSO features. */
> >> +       skb_shinfo(skb)->gso_type &=3D ~tnl_gso_type;
> >> +       ret =3D virtio_net_hdr_from_skb(skb, hdr, true, false, vlan_hl=
en);
>
> Here I'll add:
>
>         Here vlan_hlen refers to the outer headers set, but still affect
>         the inner transport header offset.

Thanks, then I want to know if we need to care about the inner vlan or
it is something that is not supported by the kernel right now.

>
> >> @@ -181,6 +208,22 @@ struct virtio_net_hdr_v1_hash {
> >>         __le16 padding;
> >>  };
> >>
> >> +/* This header after hashing information */
> >> +struct virtio_net_hdr_tunnel {
> >> +       __le16 outer_th_offset;
> >> +       __le16 inner_nh_offset;
> >> +};
> >> +
> >> +struct virtio_net_hdr_v1_tunnel {
> >> +       struct virtio_net_hdr_v1 hdr;
> >> +       struct virtio_net_hdr_tunnel tnl;
> >> +};
> >> +
> >> +struct virtio_net_hdr_v1_hash_tunnel {
> >> +       struct virtio_net_hdr_v1_hash hdr;
> >> +       struct virtio_net_hdr_tunnel tnl;
> >> +};
> >
> > Not a native speaker but I realize there's probably an issue:
> >
> >         le32 hash_value;        (Only if VIRTIO_NET_F_HASH_REPORT
> negotiated)
> >         le16 hash_report;       (Only if VIRTIO_NET_F_HASH_REPORT
> negotiated)
> >         le16 padding_reserved;  (Only if VIRTIO_NET_F_HASH_REPORT
> negotiated)
> >         le16 outer_th_offset    (Only if
> > VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO or VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO
> > negotiated)
> >         le16 inner_nh_offset;   (Only if
> > VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO or VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO
> > negotiated)
> >         le16 outer_nh_offset;   /* Only if VIRTIO_NET_F_OUT_NET_HEADER
> > negotiated */
> >         /* Only if VIRTIO_NET_F_OUT_NET_HEADER or VIRTIO_NET_F_IPSEC
> > negotiated */
> >         union {
> >                 u8 padding_reserved_2[6];
> >                 struct ipsec_resource_hdr {
> >                         le32 resource_id;
> >                         le16 resource_type;
> >                 } ipsec_resource_hdr;
> >         };
> >
> > I thought e.g outer_th_offset should have a fixed offset then
> > everything is simplified but it looks not the case here. If we decide
> > to do things like this, we will end up with a very huge uAPI
> > definition for different features combinations. This doesn't follow
> > the existing headers for example num_buffers exist no matter if
> > MRG_RXBUF is negotiated.>> At least, if we decide to go with the
> dynamic offset, it seems less
> > valuable to define those headers with different combinations if both
> > device and driver process the vnet header piece wisely
>
> I'm a little confused here. AFAICT the dynamic offset is
> requested/mandated by the specifications: if the hash related fields are
> not present, they are actually non existing and everything below moves
> upward.  I think we spent together quite some time to agree on this.

I'm sorry if I lose some context there.

>
> If you want/intend the tunnel header to be at fixed offset inside the
> virtio_hdr regardless of the negotiated features? That would yield to
> slightly simpler but also slightly less efficient implementation.

Yes. I feel it's probably too late to fix the spec. But I meant if the
header offset of tunnel gso stuff is dynamic, it's probably not need
to define:

virtio_net_hdr_v1_tunnel and virtio_net_hdr_v1_hash_tunnel

in the uAPI.

>
> Also I guess (fear mostly) some specification clarification would be need=
ed.
>
> /P
>

Thanks


