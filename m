Return-Path: <netdev+bounces-268882-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eDqrCwI+umlbTQIAu9opvQ
	(envelope-from <netdev+bounces-268882-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 06:54:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C20572B60A1
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 06:54:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 34C7930162B0
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 05:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF635362154;
	Wed, 18 Mar 2026 05:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="j3r1vcl8"
X-Original-To: netdev@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B3035F5FE
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 05:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773813246; cv=none; b=tS1WFtOJY2yuAwVWFComFSttZYG6294feYv1NGt9gpwENamSZIIPhxq8Gscs6ZCHyno48TNwLo13XTYmvAocJXdI44BJCdMmjQPusuaHZQOXfLIeVeYsR35PGNX5AXdjjF4FuPEj9U2wvGY8T4qGWuEGYzhrOf9UYnjRs1q2c0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773813246; c=relaxed/simple;
	bh=WX7uZK2CJ4YxHZOaIcKL8sJJHesbz5H1HQ1Huvqf97M=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=k6gOieERICWxHSTrXO7yyDLxWYsWuHRWF61qzeqt5X3f5P/ofwEWxgCApS21SmpPlxcCFYujmvByfObE6esgZBEnU8+dyNQmuM0N2A1CjoS0cBirAG117IiRmGDSyAr2I2EMrRT4P6g1LxGDnOKnvHjo4m4SXVk7DTZphY7F3kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=j3r1vcl8; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1773813236; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=kmW00vS+w8W9x/NlsOYGEbffnX1UiRasXT5v5JvEMK0=;
	b=j3r1vcl8ci4irCdulTdnmgUxv8/Kw8wdxjxCE5IzatWDnmAuWJYxgdX3Rl7nxkV/Ea3uP+77lKoFqLCu3dWuIzCtQbuU1aw/uq3uP1WxdiOcDp9evvsb2D3WLOqaPba/088CZylU0QGZyNd6xneInp0T8bnaa+mHLOubGuMFHeU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R541e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0X.DKlTn_1773813234;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0X.DKlTn_1773813234 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 18 Mar 2026 13:53:54 +0800
Message-ID: <1773813163.6639304-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net v10 1/2] virtio-net: correct hdr_len handling for VIRTIO_NET_F_GUEST_HDRLEN
Date: Wed, 18 Mar 2026 13:52:43 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Jiri Pirko <jiri@resnulli.us>,
 Alvaro Karsz <alvaro.karsz@solid-run.com>,
 virtualization@lists.linux.dev
References: <20260313075930.105466-1-xuanzhuo@linux.alibaba.com>
 <20260313075930.105466-2-xuanzhuo@linux.alibaba.com>
 <CACGkMEv_Fu5wsS3DKuOn3pLjqAssPEV7GXn0702t2pOLYHfwHA@mail.gmail.com>
 <CACGkMEutuueTx_QhEa9gV72NYTqaGD=69YvMKG=RcmEfdrJKhQ@mail.gmail.com>
In-Reply-To: <CACGkMEutuueTx_QhEa9gV72NYTqaGD=69YvMKG=RcmEfdrJKhQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	MISSING_MIME_VERSION(2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268882-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,resnulli.us,solid-run.com,lists.linux.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xuanzhuo@linux.alibaba.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,alibaba.com:email,linux.alibaba.com:dkim,linux.alibaba.com:mid]
X-Rspamd-Queue-Id: C20572B60A1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 18 Mar 2026 12:11:15 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Wed, Mar 18, 2026 at 12:07=E2=80=AFPM Jason Wang <jasowang@redhat.com>=
 wrote:
> >
> > On Fri, Mar 13, 2026 at 3:59=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.aliba=
ba.com> wrote:
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
> > >  drivers/net/tun_vnet.h     |  2 +-
> > >  drivers/net/virtio_net.c   |  6 +++++-
> > >  include/linux/virtio_net.h | 33 +++++++++++++++++++++++++++++----
> > >  3 files changed, 35 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/drivers/net/tun_vnet.h b/drivers/net/tun_vnet.h
> > > index a5f93b6c4482..fa5cab9d3e55 100644
> > > --- a/drivers/net/tun_vnet.h
> > > +++ b/drivers/net/tun_vnet.h
> > > @@ -244,7 +244,7 @@ tun_vnet_hdr_tnl_from_skb(unsigned int flags,
> > >
> > >         if (virtio_net_hdr_tnl_from_skb(skb, tnl_hdr, has_tnl_offload,
> > >                                         tun_vnet_is_little_endian(fla=
gs),
> > > -                                       vlan_hlen, true)) {
> > > +                                       vlan_hlen, true, false)) {
> > >                 struct virtio_net_hdr_v1 *hdr =3D &tnl_hdr->hash_hdr.=
hdr;
> > >                 struct skb_shared_info *sinfo =3D skb_shinfo(skb);
> > >
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index 72d6a9c6a5a2..7106333ef904 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -3267,8 +3267,12 @@ static int xmit_skb(struct send_queue *sq, str=
uct sk_buff *skb, bool orphan)
> > >         struct virtio_net_hdr_v1_hash_tunnel *hdr;
> > >         int num_sg;
> > >         unsigned hdr_len =3D vi->hdr_len;
> > > +       bool feature_hdrlen;
> > >         bool can_push;
> > >
> > > +       feature_hdrlen =3D virtio_has_feature(vi->vdev,
> > > +                                           VIRTIO_NET_F_GUEST_HDRLEN=
);
> > > +
> > >         pr_debug("%s: xmit %p %pM\n", vi->dev->name, skb, dest);
> > >
> > >         /* Make sure it's safe to cast between formats */
> > > @@ -3288,7 +3292,7 @@ static int xmit_skb(struct send_queue *sq, stru=
ct sk_buff *skb, bool orphan)
> > >
> > >         if (virtio_net_hdr_tnl_from_skb(skb, hdr, vi->tx_tnl,
> > >                                         virtio_is_little_endian(vi->v=
dev), 0,
> > > -                                       false))
> > > +                                       false, feature_hdrlen))
> > >                 return -EPROTO;
> > >
> > >         if (vi->mergeable_rx_bufs)
> > > diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> > > index 75dabb763c65..48de4a16a96a 100644
> > > --- a/include/linux/virtio_net.h
> > > +++ b/include/linux/virtio_net.h
> > > @@ -207,6 +207,22 @@ static inline int virtio_net_hdr_to_skb(struct s=
k_buff *skb,
> > >         return __virtio_net_hdr_to_skb(skb, hdr, little_endian, hdr->=
gso_type);
> > >  }
> > >
> > > +static inline void virtio_net_set_hdrlen(const struct sk_buff *skb,
> > > +                                        struct virtio_net_hdr *hdr,
> > > +                                        bool little_endian)
> > > +{
> > > +       u16 hdr_len;
> > > +
> > > +       hdr_len =3D skb_transport_offset(skb);
> > > +
> > > +       if (hdr->gso_type =3D=3D VIRTIO_NET_HDR_GSO_UDP_L4)
> > > +               hdr_len +=3D sizeof(struct udphdr);
> > > +       else
> > > +               hdr_len +=3D tcp_hdrlen(skb);
> >
> > Ok, I think this depends on the logic inside virtio_net_hdr_from_skb()
> >
> >                 if (sinfo->gso_type & SKB_GSO_TCPV4)
> >                         hdr->gso_type =3D VIRTIO_NET_HDR_GSO_TCPV4;
> >                 else if (sinfo->gso_type & SKB_GSO_TCPV6)
> >                         hdr->gso_type =3D VIRTIO_NET_HDR_GSO_TCPV6;
> >                 else if (sinfo->gso_type & SKB_GSO_UDP_L4)
> >                         hdr->gso_type =3D VIRTIO_NET_HDR_GSO_UDP_L4;
> >         else
> >                         return -EINVAL;
> >
> > To be more robust, I'd suggest moving it there.
> >
> > But I have another question, the logic above depends on the headlen is
> > correctly set:
> >
> >                 /* This is a hint as to how much should be linear. */
> >                 hdr->hdr_len =3D __cpu_to_virtio16(little_endian,
> >                                                  skb_headlen(skb));
> >
> > Is the headlen guaranteed to be correct in all cases (e.g for nested
> > setups or dodgy packets?)
>
> Speak too fast, I miss
>
> hdr_len =3D skb_transport_offset(skb);
>
> This is probably another call to
>
> 1) Move virtio_net_set_hdrlen() inside virtio_net_hdr_from_skb() or
> 2) call virtio_net_set_hdrlen() inside virtio_net_hdr_from_skb().


Do you more like v8?

If so, please reivew this:

http://lore.kernel.org/all/20260305031938.24518-1-xuanzhuo@linux.alibaba.com

Thanks


>
> Thanks
>
> >
> > Thanks
> >
> > > +
> > > +       hdr->hdr_len =3D __cpu_to_virtio16(little_endian, hdr_len);
> > > +}
> > > +
> > >  static inline int virtio_net_hdr_from_skb(const struct sk_buff *skb,
> > >                                           struct virtio_net_hdr *hdr,
> > >                                           bool little_endian,
> > > @@ -385,7 +401,8 @@ virtio_net_hdr_tnl_from_skb(const struct sk_buff =
*skb,
> > >                             bool tnl_hdr_negotiated,
> > >                             bool little_endian,
> > >                             int vlan_hlen,
> > > -                           bool has_data_valid)
> > > +                           bool has_data_valid,
> > > +                           bool feature_hdrlen)
> > >  {
> > >         struct virtio_net_hdr *hdr =3D (struct virtio_net_hdr *)vhdr;
> > >         unsigned int inner_nh, outer_th;
> > > @@ -394,9 +411,17 @@ virtio_net_hdr_tnl_from_skb(const struct sk_buff=
 *skb,
> > >
> > >         tnl_gso_type =3D skb_shinfo(skb)->gso_type & (SKB_GSO_UDP_TUN=
NEL |
> > >                                                     SKB_GSO_UDP_TUNNE=
L_CSUM);
> > > -       if (!tnl_gso_type)
> > > -               return virtio_net_hdr_from_skb(skb, hdr, little_endia=
n,
> > > -                                              has_data_valid, vlan_h=
len);
> > > +       if (!tnl_gso_type) {
> > > +               ret =3D virtio_net_hdr_from_skb(skb, hdr, little_endi=
an,
> > > +                                             has_data_valid, vlan_hl=
en);
> > > +               if (ret)
> > > +                       return ret;
> > > +
> > > +               if (feature_hdrlen && hdr->hdr_len)
> > > +                       virtio_net_set_hdrlen(skb, hdr, little_endian=
);
> > > +
> > > +               return ret;
> > > +       }
> > >
> > >         /* Tunnel support not negotiated but skb ask for it. */
> > >         if (!tnl_hdr_negotiated)
> > > --
> > > 2.32.0.3.g01195cf9f
> > >
>

