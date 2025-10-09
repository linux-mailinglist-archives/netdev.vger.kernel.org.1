Return-Path: <netdev+bounces-228356-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E257BC8B16
	for <lists+netdev@lfdr.de>; Thu, 09 Oct 2025 13:06:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C50513BBD03
	for <lists+netdev@lfdr.de>; Thu,  9 Oct 2025 11:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C0B2DD5EB;
	Thu,  9 Oct 2025 11:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="tG8RGNQI"
X-Original-To: netdev@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5487F1E503D
	for <netdev@vger.kernel.org>; Thu,  9 Oct 2025 11:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760007859; cv=none; b=l03dBAbcrW8HiuWmC6Z4cXtW8jXK/LMpn2bR00ilP0WHNudAbeI/HMfcsk4Uef6NwLeMr6Jo71F3zwdR0AgdN7hmSPAMllUvYg0R0fIYLnLCgMJF+8GPGNx4IuRAQJr7wlRzhitPWLfrC7cMizYLvmUunSA5kYPzrwMOSkMOPWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760007859; c=relaxed/simple;
	bh=iJ4zznhUQGKrFCqKoKDAq6BrsfV2762JIMD55qTSfOU=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=SQxw94KlFIMumabJVM93VbP9V1j1RY2UDh7P2t+xTlQ6kW98/2zZcAmbB+emm146W7C0qWDOVD8jng6EiyzwZFg/ACuYW6wXaZE3WeC3s8lgeyfyM2oF+6iue5srrQgYgrbWe5yHSTc5kfncPEUU5QyPGLTLUtKBmUdy3Y3ch4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=tG8RGNQI; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1760007853; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=44e1lH7CB/uDQFY83UsNxWUC7U6/pKA1atcIn06ec3E=;
	b=tG8RGNQIQCY+ubudDHEPC5ZrLh8Gc7rUv9gCAO/VdLkubAsTVc28w3eWgmtIHNvkA/p7po1/gp5MZM7UrvrRGPKN63W8lRKKuxHSwUr03kPLoH0bFrzj0QfNXdlQ73w5AMXh4V40oqXVcbh2irGTrKC1FhpaU3rRVgNwL1tCA3g=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WpmbiKw_1760007852 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 09 Oct 2025 19:04:12 +0800
Message-ID: <1760007608.9282165-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net 2/2] virtio-net: correct hdr_len handling for VIRTIO_NET_F_GUEST_HDRLEN
Date: Thu, 9 Oct 2025 19:00:08 +0800
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
In-Reply-To: <CACGkMEvhABOtHTCVW9sX7p0wo1QCMXMvOAD+u4pzBueoU=MCpg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Fri, 26 Sep 2025 12:52:53 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Thu, Sep 25, 2025 at 10:25=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibab=
a.com> wrote:
> >
> > The commit be50da3e9d4a ("net: virtio_net: implement exact header length
> > guest feature") introduces support for the VIRTIO_NET_F_GUEST_HDRLEN
> > feature in virtio-net.
> >
> > This feature requires virtio-net to set hdr_len to the actual header
> > length of the packet when transmitting, the number of
> > bytes from the start of the packet to the beginning of the
> > transport-layer payload.
> >
> > However, in practice, hdr_len was being set using skb_headlen(skb),
> > which is clearly incorrect. This commit fixes that issue.
> >
> > Fixes: be50da3e9d4a ("net: virtio_net: implement exact header length gu=
est feature")
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >  include/linux/virtio_net.h | 19 ++++++++++++-------
> >  1 file changed, 12 insertions(+), 7 deletions(-)
> >
> > diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> > index 20e0584db1dd..4273420a9ff9 100644
> > --- a/include/linux/virtio_net.h
> > +++ b/include/linux/virtio_net.h
> > @@ -217,20 +217,25 @@ static inline int virtio_net_hdr_from_skb(const s=
truct sk_buff *skb,
> >
> >         if (skb_is_gso(skb)) {
> >                 struct skb_shared_info *sinfo =3D skb_shinfo(skb);
> > +               u16 hdr_len;
> >
> > -               /* This is a hint as to how much should be linear. */
> > -               hdr->hdr_len =3D __cpu_to_virtio16(little_endian,
> > -                                                skb_headlen(skb));
> > +               hdr_len =3D skb_transport_offset(skb);
> >                 hdr->gso_size =3D __cpu_to_virtio16(little_endian,
> >                                                   sinfo->gso_size);
> > -               if (sinfo->gso_type & SKB_GSO_TCPV4)
> > +               if (sinfo->gso_type & SKB_GSO_TCPV4) {
> >                         hdr->gso_type =3D VIRTIO_NET_HDR_GSO_TCPV4;
> > -               else if (sinfo->gso_type & SKB_GSO_TCPV6)
> > +                       hdr_len +=3D tcp_hdrlen(skb);
> > +               } else if (sinfo->gso_type & SKB_GSO_TCPV6) {
> >                         hdr->gso_type =3D VIRTIO_NET_HDR_GSO_TCPV6;
> > -               else if (sinfo->gso_type & SKB_GSO_UDP_L4)
> > +                       hdr_len +=3D tcp_hdrlen(skb);
> > +               } else if (sinfo->gso_type & SKB_GSO_UDP_L4) {
> >                         hdr->gso_type =3D VIRTIO_NET_HDR_GSO_UDP_L4;
> > -               else
>
> I think we need to deal with the GSO tunnel as well?
>
> """
>     If the \field{gso_type} has the VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV4 bi=
t or
>     VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV6 bit set, \field{hdr_len} accounts =
for
>     all the headers up to and including the inner transport.
> """

Sorry, I referred to the old spec. According to the latest spec, this case =
should indeed be considered.


>
> > +                       hdr_len +=3D sizeof(struct udphdr);
> > +               } else {
> >                         return -EINVAL;
> > +               }
> > +
> > +               hdr->hdr_len =3D __cpu_to_virtio16(little_endian, hdr_l=
en);
>
> Should we at least check against the feature of VIRTIO_NET_F_GUEST_HDRLEN?

I think we don't need to check for VIRTIO_NET_F_GUEST_HDRLEN, because regar=
dless
of whether this feature has been negotiated or not, we always pass this val=
ue
hdr_len.

Previously, the value might have been incorrect but still acceptable; howev=
er,
once VIRTIO_NET_F_GUEST_HDRLEN is negotiated, incorrect values must no
longer be accepted. Therefore, we don't need to check VIRTIO_NET_F_GUEST_HD=
RLEN.
On the other hand, VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV4 should be checked.

Thanks.

>
> >                 if (sinfo->gso_type & SKB_GSO_TCP_ECN)
> >                         hdr->gso_type |=3D VIRTIO_NET_HDR_GSO_ECN;
> >         } else
> > --
> > 2.32.0.3.g01195cf9f
> >
>

