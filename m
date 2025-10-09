Return-Path: <netdev+bounces-228357-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCDFFBC8B3E
	for <lists+netdev@lfdr.de>; Thu, 09 Oct 2025 13:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80E213A28A1
	for <lists+netdev@lfdr.de>; Thu,  9 Oct 2025 11:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B44EC2DD5EB;
	Thu,  9 Oct 2025 11:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="OaEjCJas"
X-Original-To: netdev@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8A119E967
	for <netdev@vger.kernel.org>; Thu,  9 Oct 2025 11:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760008224; cv=none; b=HMyRTx7QZih0I08oRPAVDZG3NE73ADdfMfCffn17jxZav1gAc/Jq+CXshtx41G3XW3xUae71xstnbwV9oac4ddG8x/WwSklt9nQvkqjNtk8atdX8BkFWYnAP8+E+rMFZ1luQX0j3NeDjoxnttXq9P9naoF6KbC+eWAzbpZ+mBWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760008224; c=relaxed/simple;
	bh=s8tPhfl6hg5iWVo36nUILps2QIqu5ZPUwcH/FH/mBhQ=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=ft35zeMckjXjrZti5dyq3z+hcqkniZKkyi/MyCd6mULDToRJfdf1a4h4lWxzZRdFX7hrodowSXIatrc50QzdOA5awUK6Nn/z2M/p+Ol0rMzxsA0bSbJUGAK3RyswUDN2XOyafcMHv4XIc1BogceDqE7Ddylk+FaYL7qeRSIjkeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=OaEjCJas; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1760008219; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=EIZSpyLf0xPGj6v5S3kPgXN9LUWMdJHWkiRHbuHdF6I=;
	b=OaEjCJaslRON3EOhlH12CA1DJ7/KfgS+dgucXcQIgTwYkBZe6Svv0sDDhwVhdqeUH35ed3Y1rAGA34XfZkmnCptDT4yP1vwPu5F8DBeTvT7ZTnVrEEgXB+iYM7x1feNboEJqrN8+uLFNrlE164h/4bFJxTxo3EL0exbGpTQqrB0=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0Wplv.cc_1760008218 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 09 Oct 2025 19:10:18 +0800
Message-ID: <1760008083.6644826-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net 2/2] virtio-net: correct hdr_len handling for VIRTIO_NET_F_GUEST_HDRLEN
Date: Thu, 9 Oct 2025 19:08:03 +0800
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

I checked the new code, VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV6
and VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV4 are not supported, so the next versi=
on
will not include these feature.

Thanks.


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
>
> >                 if (sinfo->gso_type & SKB_GSO_TCP_ECN)
> >                         hdr->gso_type |=3D VIRTIO_NET_HDR_GSO_ECN;
> >         } else
> > --
> > 2.32.0.3.g01195cf9f
> >
>

