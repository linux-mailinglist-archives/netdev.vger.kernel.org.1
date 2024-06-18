Return-Path: <netdev+bounces-104322-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5605C90C248
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 05:16:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD097283BC2
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 03:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2D021C69D;
	Tue, 18 Jun 2024 03:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Moesvo4P"
X-Original-To: netdev@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895CC290F
	for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 03:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718680614; cv=none; b=t4hT3E7acI0cNfMe2MvBfwloRblJV+cYOeOJ5zZrlhgg/cR8vk+vLAVAUuUxu0QNK7BYINDH7DfPKWErigpcoACTNRQjwKVaMZKNSlZBlESHHgZa51zKA36x/LJWioyLTbD0tWqgwaOfgJuFFWv+pMQsx+DwHh4fEMRaq3u71yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718680614; c=relaxed/simple;
	bh=IagB8ZoNTLvzyiUvAYVqJozZo4VQNO8R9dBxM0kINlg=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=KirbZ7DZyfQeUwTU7FCqd17Jnpor29kkrPKQUDGDHk3A7YNgEk8rCUqXAORmeo0yfhnKajOBDF8gsSzCTrhrP/jJbwRBHS69PouKuQgTtwbtxqCHd3kaX3AVEaipadFVsZIhxqGDVqbsmkza3jWgXzn54mlX326zDB1+ieGbxnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Moesvo4P; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718680610; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=v7l8gIqWliDfiVq9+JL459SRyKwvcCNwJkluASg0o/4=;
	b=Moesvo4PFWhA6ZX5dnAZmS/bHsOaLpW8ZAQbAt8dRv2BDn62cSS9XdtQxU8fjxIrKBzArK7FA+eJsoPn8j04knIyb/cyE/PFSbuqtFErMIcGV1mx/X+BZUX6lMid9qoc/Y3RpoWIP0oBw/YdVrCID4Rtnb/TkZAXmNInaYIh1eg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R501e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067109;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0W8iTXHC_1718680608;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W8iTXHC_1718680608)
          by smtp.aliyun-inc.com;
          Tue, 18 Jun 2024 11:16:49 +0800
Message-ID: <1718680517.8370645-12-hengqi@linux.alibaba.com>
Subject: Re: [PATCH 2/2] virtio_net: fixing XDP for fully checksummed packets handling
Date: Tue, 18 Jun 2024 11:15:17 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org,
 virtualization@lists.linux.dev,
 Thomas Huth <thuth@linux.vnet.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Eric Dumazet <edumazet@google.com>,
 "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>
References: <20240617131524.63662-1-hengqi@linux.alibaba.com>
 <20240617131524.63662-3-hengqi@linux.alibaba.com>
 <CACGkMEvj8fvXkCxDFQ1-Cyq5DL=axEf1Ch1zVnuQUNQy6Wjn+g@mail.gmail.com>
In-Reply-To: <CACGkMEvj8fvXkCxDFQ1-Cyq5DL=axEf1Ch1zVnuQUNQy6Wjn+g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Tue, 18 Jun 2024 11:10:26 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Mon, Jun 17, 2024 at 9:15=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.com=
> wrote:
> >
> > The XDP program can't correctly handle partially checksummed
> > packets, but works fine with fully checksummed packets.
>=20
> Not sure this is ture, if I was not wrong, XDP can try to calculate check=
sum.

XDP's interface serves a full checksum, and this is why we disabled the
offloading of VIRTIO_NET_F_GUEST_CSUM when loading XDP.

Thanks.

>=20
> Thanks
>=20
> > If the
> > device has already validated fully checksummed packets, then
> > the driver doesn't need to re-validate them, saving CPU resources.
> >
> > Additionally, the driver does not drop all partially checksummed
> > packets when VIRTIO_NET_F_GUEST_CSUM is not negotiated. This is
> > not a bug, as the driver has always done this.
> >
> > Fixes: 436c9453a1ac ("virtio-net: keep vnet header zeroed after process=
ing XDP")
> > Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> > ---
> >  drivers/net/virtio_net.c | 20 +++++++++++++++++++-
> >  1 file changed, 19 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index aa70a7ed8072..ea10db9a09fa 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -1360,6 +1360,10 @@ static struct sk_buff *receive_small_xdp(struct =
net_device *dev,
> >         if (unlikely(hdr->hdr.gso_type))
> >                 goto err_xdp;
> >
> > +       /* Partially checksummed packets must be dropped. */
> > +       if (unlikely(hdr->hdr.flags & VIRTIO_NET_HDR_F_NEEDS_CSUM))
> > +               goto err_xdp;
> > +
> >         buflen =3D SKB_DATA_ALIGN(GOOD_PACKET_LEN + headroom) +
> >                 SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
> >
> > @@ -1677,6 +1681,10 @@ static void *mergeable_xdp_get_buf(struct virtne=
t_info *vi,
> >         if (unlikely(hdr->hdr.gso_type))
> >                 return NULL;
> >
> > +       /* Partially checksummed packets must be dropped. */
> > +       if (unlikely(hdr->hdr.flags & VIRTIO_NET_HDR_F_NEEDS_CSUM))
> > +               return NULL;
> > +
> >         /* Now XDP core assumes frag size is PAGE_SIZE, but buffers
> >          * with headroom may add hole in truesize, which
> >          * make their length exceed PAGE_SIZE. So we disabled the
> > @@ -1943,6 +1951,7 @@ static void receive_buf(struct virtnet_info *vi, =
struct receive_queue *rq,
> >         struct net_device *dev =3D vi->dev;
> >         struct sk_buff *skb;
> >         struct virtio_net_common_hdr *hdr;
> > +       u8 flags;
> >
> >         if (unlikely(len < vi->hdr_len + ETH_HLEN)) {
> >                 pr_debug("%s: short packet %i\n", dev->name, len);
> > @@ -1951,6 +1960,15 @@ static void receive_buf(struct virtnet_info *vi,=
 struct receive_queue *rq,
> >                 return;
> >         }
> >
> > +       /* 1. Save the flags early, as the XDP program might overwrite =
them.
> > +        * These flags ensure packets marked as VIRTIO_NET_HDR_F_DATA_V=
ALID
> > +        * stay valid after XDP processing.
> > +        * 2. XDP doesn't work with partially checksummed packets (refe=
r to
> > +        * virtnet_xdp_set()), so packets marked as
> > +        * VIRTIO_NET_HDR_F_NEEDS_CSUM get dropped during XDP processin=
g.
> > +        */
> > +       flags =3D ((struct virtio_net_common_hdr *)buf)->hdr.flags;
> > +
> >         if (vi->mergeable_rx_bufs)
> >                 skb =3D receive_mergeable(dev, vi, rq, buf, ctx, len, x=
dp_xmit,
> >                                         stats);
> > @@ -1966,7 +1984,7 @@ static void receive_buf(struct virtnet_info *vi, =
struct receive_queue *rq,
> >         if (dev->features & NETIF_F_RXHASH && vi->has_rss_hash_report)
> >                 virtio_skb_set_hash(&hdr->hash_v1_hdr, skb);
> >
> > -       if (hdr->hdr.flags & VIRTIO_NET_HDR_F_DATA_VALID)
> > +       if (flags & VIRTIO_NET_HDR_F_DATA_VALID)
> >                 skb->ip_summed =3D CHECKSUM_UNNECESSARY;
> >
> >         if (virtio_net_hdr_to_skb(skb, &hdr->hdr,
> > --
> > 2.32.0.3.g01195cf9f
> >
>=20

