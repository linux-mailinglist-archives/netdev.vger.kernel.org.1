Return-Path: <netdev+bounces-228465-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3204BCB770
	for <lists+netdev@lfdr.de>; Fri, 10 Oct 2025 05:04:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 835FF3C7803
	for <lists+netdev@lfdr.de>; Fri, 10 Oct 2025 03:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8995819F40A;
	Fri, 10 Oct 2025 03:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="BKzzu/5p"
X-Original-To: netdev@vger.kernel.org
Received: from out199-1.us.a.mail.aliyun.com (out199-1.us.a.mail.aliyun.com [47.90.199.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CA413C3CD
	for <netdev@vger.kernel.org>; Fri, 10 Oct 2025 03:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.199.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760065437; cv=none; b=WchnXQm7+Gi/cOfcOr2K3pFS1KwQ4JA8I4KcZmvjVRT9t76NCg/SIRxm8u1maVrxb4nP4QdFC9lpUYZYLbWWLlA96Czzhp3k0BPVOhbvbUEa9xny2iBV7aV/6MdW4aIuVna4ywAukBSp1mWXBLcu8tqs5VZK8goPLdZap2cBEPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760065437; c=relaxed/simple;
	bh=GX0mg0xpt7EZCg4fkdETlJt1/nQX9Pu8PP2Dau1dWq0=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=lOflCP7FbhFGWtpSP5zZoVXGnyJYTMH/2o77j/fUt28By5DlAtYdoh8NfjzujoYyJxuKfXQy02qCY1rsjidYPNnOT1l44yL6Vu5gXwv1lTGfV0QBeTt0Jmsw7cSNTtn7msbmb+oxwWVfdEP+HtRESf7SWHRpOrPCwoztzZr022g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=BKzzu/5p; arc=none smtp.client-ip=47.90.199.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1760065417; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=R4cAPoAdXkkU88RkjiP9GvzHcpepBPFLdxx40qwQve0=;
	b=BKzzu/5px8ECR2rgJFiv/K/fcXCgmgXohsN4ZDXmO4sKjJVUXjv3TXZ1qbRrsycqK1+Em0jy+4k7+sEj/Kf9WS1H5Gmq3Zdk/s6lLc2QEGORGDTTXweNVbkU1upWcMHvBdj81yaY3HMcc+vteBtZ8SC0j5o+tClqUF/IdQO347A=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WpraS8E_1760065416 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 10 Oct 2025 11:03:36 +0800
Message-ID: <1760065279.5030267-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net 2/2] virtio-net: correct hdr_len handling for VIRTIO_NET_F_GUEST_HDRLEN
Date: Fri, 10 Oct 2025 11:01:19 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Willem de Bruijn <willemb@google.com>,
 Jiri Pirko <jiri@resnulli.us>,
 Alvaro Karsz <alvaro.karsz@solid-run.com>,
 Heng Qi <hengqi@linux.alibaba.com>,
 virtualization@lists.linux.dev
References: <20250925022537.91774-1-xuanzhuo@linux.alibaba.com>
 <20250925022537.91774-3-xuanzhuo@linux.alibaba.com>
 <CACGkMEvhABOtHTCVW9sX7p0wo1QCMXMvOAD+u4pzBueoU=MCpg@mail.gmail.com>
 <1760008083.6644826-2-xuanzhuo@linux.alibaba.com>
 <CACGkMEuYTgK2CVGPTJrAdcJ=GxuhFTSfAc0KGU9=yRHX-7f8-Q@mail.gmail.com>
In-Reply-To: <CACGkMEuYTgK2CVGPTJrAdcJ=GxuhFTSfAc0KGU9=yRHX-7f8-Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Fri, 10 Oct 2025 08:36:33 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Thu, Oct 9, 2025 at 7:10=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.=
com> wrote:
> >
> > On Fri, 26 Sep 2025 12:52:53 +0800, Jason Wang <jasowang@redhat.com> wr=
ote:
> > > On Thu, Sep 25, 2025 at 10:25=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.al=
ibaba.com> wrote:
> > > >
> > > > The commit be50da3e9d4a ("net: virtio_net: implement exact header l=
ength
> > > > guest feature") introduces support for the VIRTIO_NET_F_GUEST_HDRLEN
> > > > feature in virtio-net.
> > > >
> > > > This feature requires virtio-net to set hdr_len to the actual header
> > > > length of the packet when transmitting, the number of
> > > > bytes from the start of the packet to the beginning of the
> > > > transport-layer payload.
> > > >
> > > > However, in practice, hdr_len was being set using skb_headlen(skb),
> > > > which is clearly incorrect. This commit fixes that issue.
> > > >
> > > > Fixes: be50da3e9d4a ("net: virtio_net: implement exact header lengt=
h guest feature")
> > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > ---
> > > >  include/linux/virtio_net.h | 19 ++++++++++++-------
> > > >  1 file changed, 12 insertions(+), 7 deletions(-)
> > > >
> > > > diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> > > > index 20e0584db1dd..4273420a9ff9 100644
> > > > --- a/include/linux/virtio_net.h
> > > > +++ b/include/linux/virtio_net.h
> > > > @@ -217,20 +217,25 @@ static inline int virtio_net_hdr_from_skb(con=
st struct sk_buff *skb,
> > > >
> > > >         if (skb_is_gso(skb)) {
> > > >                 struct skb_shared_info *sinfo =3D skb_shinfo(skb);
> > > > +               u16 hdr_len;
> > > >
> > > > -               /* This is a hint as to how much should be linear. =
*/
> > > > -               hdr->hdr_len =3D __cpu_to_virtio16(little_endian,
> > > > -                                                skb_headlen(skb));
> > > > +               hdr_len =3D skb_transport_offset(skb);
> > > >                 hdr->gso_size =3D __cpu_to_virtio16(little_endian,
> > > >                                                   sinfo->gso_size);
> > > > -               if (sinfo->gso_type & SKB_GSO_TCPV4)
> > > > +               if (sinfo->gso_type & SKB_GSO_TCPV4) {
> > > >                         hdr->gso_type =3D VIRTIO_NET_HDR_GSO_TCPV4;
> > > > -               else if (sinfo->gso_type & SKB_GSO_TCPV6)
> > > > +                       hdr_len +=3D tcp_hdrlen(skb);
> > > > +               } else if (sinfo->gso_type & SKB_GSO_TCPV6) {
> > > >                         hdr->gso_type =3D VIRTIO_NET_HDR_GSO_TCPV6;
> > > > -               else if (sinfo->gso_type & SKB_GSO_UDP_L4)
> > > > +                       hdr_len +=3D tcp_hdrlen(skb);
> > > > +               } else if (sinfo->gso_type & SKB_GSO_UDP_L4) {
> > > >                         hdr->gso_type =3D VIRTIO_NET_HDR_GSO_UDP_L4;
> > > > -               else
> > >
> > > I think we need to deal with the GSO tunnel as well?
> > >
> > > """
> > >     If the \field{gso_type} has the VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV=
4 bit or
> > >     VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV6 bit set, \field{hdr_len} accou=
nts for
> > >     all the headers up to and including the inner transport.
> > > """
> >
> > I checked the new code, VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV6
> > and VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV4 are not supported, so the next v=
ersion
> > will not include these feature.
> >
> > Thanks.
>
> I may miss something but we had:
>
>         if (skb->protocol =3D=3D htons(ETH_P_IPV6))
>                 hdr->gso_type |=3D VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV6;
>         else
>                 hdr->gso_type |=3D VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV4;
>
> in virtio_net_hdr_tnl_from_skb() now.

I checked the *.c files only, so I missed it.

And I found that skb_headroom is used here, that should be a error.


	if (skb->protocol =3D=3D htons(ETH_P_IPV6))
		hdr->gso_type |=3D VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV6;
	else
		hdr->gso_type |=3D VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV4;

	if (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_TUNNEL_CSUM)
		hdr->flags |=3D VIRTIO_NET_HDR_F_UDP_TUNNEL_CSUM;

	inner_nh =3D skb->inner_network_header - skb_headroom(skb);
	outer_th =3D skb->transport_header - skb_headroom(skb);

Thanks

>
> Thanks
>
> >
> >
> > >
> > > > +                       hdr_len +=3D sizeof(struct udphdr);
> > > > +               } else {
> > > >                         return -EINVAL;
> > > > +               }
> > > > +
> > > > +               hdr->hdr_len =3D __cpu_to_virtio16(little_endian, h=
dr_len);
> > >
> > > Should we at least check against the feature of VIRTIO_NET_F_GUEST_HD=
RLEN?
> > >
> > > >                 if (sinfo->gso_type & SKB_GSO_TCP_ECN)
> > > >                         hdr->gso_type |=3D VIRTIO_NET_HDR_GSO_ECN;
> > > >         } else
> > > > --
> > > > 2.32.0.3.g01195cf9f
> > > >
> > >
> >
>

