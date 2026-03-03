Return-Path: <netdev+bounces-263084-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aO5ZHcqlpmkTSQAAu9opvQ
	(envelope-from <netdev+bounces-263084-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 10:11:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE3F1EBACE
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 10:11:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EA592302E861
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 09:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1ADF385536;
	Tue,  3 Mar 2026 09:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="MuUv7pYq"
X-Original-To: netdev@vger.kernel.org
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5FA37DE9E
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 09:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772529093; cv=none; b=dZYaIsSwwo8C8xGnJ3HVeNZyF8Ob/9qlHpWoQ5SRUmDsT5/gTE8PPtyCt3kM7E+ZB8Q2Ky2Jk20wfa60IXiI4FSGqYD696oVI0s18VXqUj4Yxls9eMrG8XayNlHMX6IbYrZU8VgduWX0gWnv/GkMd2N8AuVyA/pAE+opFIB7oI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772529093; c=relaxed/simple;
	bh=N7SOyaIUOsm7bAK7nYazlnDpLAKZSobncGpLE5zx/f0=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=t2KrDDY13c59YOdob8i9F7yKNrHc64pa/fTXBZO5shWCsZiDJNsPmt2TnercJUpw3hkcZj4Igno4gUzqim28Qf6/RaNhM5U1hKurNCY2Rcdc5tfNE80Jhh1NfjL+KjQnxfVAdgK7HweUInteD7vxlxvNgU7ozrb9a3OQPIYK+3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=MuUv7pYq; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1772529083; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=D1gM7kdl6gyn4o0hTcULotM2mOKx+BpDApMrZ/EeYew=;
	b=MuUv7pYqOxeZpdLC2jPUMBoPAJVaWT5DcDKrP7OcRxpoOO5GI3bEiG07h1P1N4BRmuU1Viekd/4gME+giZbttEB5JdgWDVmmhg5TI6jtz651jlo7iEcXvA6l8Jqm9OHjZyWMBMuyo0odGnN0drVhef2hnAOLUTlRyrbAFVTXLjI=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0X-9LDCP_1772529081 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 03 Mar 2026 17:11:21 +0800
Message-ID: <1772528953.3431165-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net v7 1/2] virtio-net: correct hdr_len handling for VIRTIO_NET_F_GUEST_HDRLEN
Date: Tue, 3 Mar 2026 17:09:13 +0800
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
References: <20260302090413.86471-1-xuanzhuo@linux.alibaba.com>
 <20260302090413.86471-2-xuanzhuo@linux.alibaba.com>
 <CACGkMEtnOKxJVY2qrbFsTwR9c=e34HU7z6Mdhyj3kPGf867F-g@mail.gmail.com>
In-Reply-To: <CACGkMEtnOKxJVY2qrbFsTwR9c=e34HU7z6Mdhyj3kPGf867F-g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: BCE3F1EBACE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	MISSING_MIME_VERSION(2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263084-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.991];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,alibaba.com:email,linux.alibaba.com:dkim,linux.alibaba.com:mid]
X-Rspamd-Action: no action

On Tue, 3 Mar 2026 11:15:16 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Mon, Mar 2, 2026 at 5:04=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.=
com> wrote:
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
> >  drivers/net/tun_vnet.h     |  2 +-
> >  drivers/net/virtio_net.c   |  8 +++--
> >  include/linux/virtio_net.h | 61 ++++++++++++++++++++++++++++++--------
> >  3 files changed, 56 insertions(+), 15 deletions(-)
> >
> > diff --git a/drivers/net/tun_vnet.h b/drivers/net/tun_vnet.h
> > index a5f93b6c4482..fa5cab9d3e55 100644
> > --- a/drivers/net/tun_vnet.h
> > +++ b/drivers/net/tun_vnet.h
> > @@ -244,7 +244,7 @@ tun_vnet_hdr_tnl_from_skb(unsigned int flags,
> >
> >         if (virtio_net_hdr_tnl_from_skb(skb, tnl_hdr, has_tnl_offload,
> >                                         tun_vnet_is_little_endian(flags=
),
> > -                                       vlan_hlen, true)) {
> > +                                       vlan_hlen, true, false)) {
> >                 struct virtio_net_hdr_v1 *hdr =3D &tnl_hdr->hash_hdr.hd=
r;
> >                 struct skb_shared_info *sinfo =3D skb_shinfo(skb);
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 72d6a9c6a5a2..1800058c8072 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -3265,9 +3265,13 @@ static int xmit_skb(struct send_queue *sq, struc=
t sk_buff *skb, bool orphan)
> >         const unsigned char *dest =3D ((struct ethhdr *)skb->data)->h_d=
est;
> >         struct virtnet_info *vi =3D sq->vq->vdev->priv;
> >         struct virtio_net_hdr_v1_hash_tunnel *hdr;
> > -       int num_sg;
> >         unsigned hdr_len =3D vi->hdr_len;
> > +       bool feature_hdrlen;
> >         bool can_push;
> > +       int num_sg;
>
> nit: the change to num_sg seems to be unnecessary.
>
> > +
> > +       feature_hdrlen =3D virtio_has_feature(vi->vdev,
> > +                                           VIRTIO_NET_F_GUEST_HDRLEN);
> >
> >         pr_debug("%s: xmit %p %pM\n", vi->dev->name, skb, dest);
> >
> > @@ -3288,7 +3292,7 @@ static int xmit_skb(struct send_queue *sq, struct=
 sk_buff *skb, bool orphan)
> >
> >         if (virtio_net_hdr_tnl_from_skb(skb, hdr, vi->tx_tnl,
> >                                         virtio_is_little_endian(vi->vde=
v), 0,
> > -                                       false))
> > +                                       false, feature_hdrlen))
> >                 return -EPROTO;
> >
> >         if (vi->mergeable_rx_bufs)
> > diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> > index 75dabb763c65..d31c9af1f3d6 100644
> > --- a/include/linux/virtio_net.h
> > +++ b/include/linux/virtio_net.h
> > @@ -207,20 +207,40 @@ static inline int virtio_net_hdr_to_skb(struct sk=
_buff *skb,
> >         return __virtio_net_hdr_to_skb(skb, hdr, little_endian, hdr->gs=
o_type);
> >  }
> >
> > -static inline int virtio_net_hdr_from_skb(const struct sk_buff *skb,
> > -                                         struct virtio_net_hdr *hdr,
> > -                                         bool little_endian,
> > -                                         bool has_data_valid,
> > -                                         int vlan_hlen)
> > +static inline void virtio_net_set_hdrlen(const struct sk_buff *skb,
> > +                                        struct virtio_net_hdr *hdr,
> > +                                        bool little_endian,
> > +                                        bool feature_hdrlen)
> > +{
> > +       u16 hdr_len;
> > +
> > +       if (feature_hdrlen) {
> > +               hdr_len =3D skb_transport_offset(skb);
> > +
> > +               if (hdr->gso_type =3D=3D VIRTIO_NET_HDR_GSO_UDP_L4)
> > +                       hdr_len +=3D sizeof(struct udphdr);
> > +               else
> > +                       hdr_len +=3D tcp_hdrlen(skb);
> > +       } else {
> > +               /* This is a hint as to how much should be linear. */
> > +               hdr_len =3D skb_headlen(skb);
> > +       }
> > +
> > +       hdr->hdr_len =3D __cpu_to_virtio16(little_endian, hdr_len);
> > +}
> > +
> > +static inline int __virtio_net_hdr_from_skb(const struct sk_buff *skb,
> > +                                           struct virtio_net_hdr *hdr,
> > +                                           bool little_endian,
> > +                                           bool has_data_valid,
> > +                                           bool feature_hdrlen,
> > +                                           int vlan_hlen)
> >  {
> >         memset(hdr, 0, sizeof(*hdr));   /* no info leak */
> >
> >         if (skb_is_gso(skb)) {
> >                 struct skb_shared_info *sinfo =3D skb_shinfo(skb);
> >
> > -               /* This is a hint as to how much should be linear. */
> > -               hdr->hdr_len =3D __cpu_to_virtio16(little_endian,
> > -                                                skb_headlen(skb));
> >                 hdr->gso_size =3D __cpu_to_virtio16(little_endian,
> >                                                   sinfo->gso_size);
> >                 if (sinfo->gso_type & SKB_GSO_TCPV4)
> > @@ -231,6 +251,10 @@ static inline int virtio_net_hdr_from_skb(const st=
ruct sk_buff *skb,
> >                         hdr->gso_type =3D VIRTIO_NET_HDR_GSO_UDP_L4;
> >                 else
> >                         return -EINVAL;
> > +
> > +               virtio_net_set_hdrlen(skb, hdr, little_endian,
> > +                                     feature_hdrlen);
> > +
> >                 if (sinfo->gso_type & SKB_GSO_TCP_ECN)
> >                         hdr->gso_type |=3D VIRTIO_NET_HDR_GSO_ECN;
> >         } else
> > @@ -250,6 +274,16 @@ static inline int virtio_net_hdr_from_skb(const st=
ruct sk_buff *skb,
> >         return 0;
> >  }
> >
> > +static inline int virtio_net_hdr_from_skb(const struct sk_buff *skb,
> > +                                         struct virtio_net_hdr *hdr,
> > +                                         bool little_endian,
> > +                                         bool has_data_valid,
> > +                                         int vlan_hlen)
> > +{
> > +       return __virtio_net_hdr_from_skb(skb, hdr, little_endian,
> > +                                        has_data_valid, false, vlan_hl=
en);
> > +}
> > +
> >  static inline unsigned int virtio_l3min(bool is_ipv6)
> >  {
> >         return is_ipv6 ? sizeof(struct ipv6hdr) : sizeof(struct iphdr);
> > @@ -385,7 +419,8 @@ virtio_net_hdr_tnl_from_skb(const struct sk_buff *s=
kb,
> >                             bool tnl_hdr_negotiated,
> >                             bool little_endian,
> >                             int vlan_hlen,
> > -                           bool has_data_valid)
> > +                           bool has_data_valid,
> > +                           bool feature_hdrlen)
> >  {
> >         struct virtio_net_hdr *hdr =3D (struct virtio_net_hdr *)vhdr;
> >         unsigned int inner_nh, outer_th;
> > @@ -395,8 +430,9 @@ virtio_net_hdr_tnl_from_skb(const struct sk_buff *s=
kb,
> >         tnl_gso_type =3D skb_shinfo(skb)->gso_type & (SKB_GSO_UDP_TUNNE=
L |
> >                                                     SKB_GSO_UDP_TUNNEL_=
CSUM);
> >         if (!tnl_gso_type)
> > -               return virtio_net_hdr_from_skb(skb, hdr, little_endian,
> > -                                              has_data_valid, vlan_hle=
n);
> > +               return __virtio_net_hdr_from_skb(skb, hdr, little_endia=
n,
> > +                                                has_data_valid,
> > +                                                feature_hdrlen, vlan_h=
len);
> >
> >         /* Tunnel support not negotiated but skb ask for it. */
> >         if (!tnl_hdr_negotiated)
> > @@ -409,7 +445,8 @@ virtio_net_hdr_tnl_from_skb(const struct sk_buff *s=
kb,
> >
> >         /* Let the basic parsing deal with plain GSO features. */
> >         skb_shinfo(skb)->gso_type &=3D ~tnl_gso_type;
> > -       ret =3D virtio_net_hdr_from_skb(skb, hdr, true, false, vlan_hle=
n);
> > +       ret =3D __virtio_net_hdr_from_skb(skb, hdr, true, false,
> > +                                       feature_hdrlen, vlan_hlen);
>
> This seems to be incorrect as tnl_gso_type is masked so
> __virtio_net_hdr_from_skb() can only see UDP packet for tunnel gso
> packet?

Yes, moving to next patch maybe more suitable.

>
> (And it seems to be fixed in next patch, could we simply squash them)

As the issues fixed originate from different commits.
This separation makes it easier to selectively revert to
previous versions.

Thanks.

>
> Thanks
>
>
> >         skb_shinfo(skb)->gso_type |=3D tnl_gso_type;
> >         if (ret)
> >                 return ret;
> > --
> > 2.32.0.3.g01195cf9f
> >
>

