Return-Path: <netdev+bounces-105183-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B141C91006F
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 11:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B889A1C212C2
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 09:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 194201A3BC9;
	Thu, 20 Jun 2024 09:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="b6INL0O2"
X-Original-To: netdev@vger.kernel.org
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61561802E
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 09:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718876010; cv=none; b=KtvMRe+EffrEGHjyt7d9Dcm4eVimJoD2Ibg89ypBzA73q3+CK/vPNjjk1ew3uYy0TlXl2vbKEOS0ZYNZV0RZc+qZRDHEt9Jz5XZ1y5yoejgrfTbR4kbcAeF5tkZ3wcqk6WnMrt5oiu1bCgeDt9zEMKl6+JkOx3XKPuCSG+cf8YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718876010; c=relaxed/simple;
	bh=oUBFct/LIBRpqcM7auYsJFFFVAmZqu6a6RM3fRAZf+Q=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=R3D9AE7bUyHtd8gkSxkF3dLuHMMHLFJ3SiR0ef2noScWey7PV04ryZ51lHBJWgDabKsh1Gy/razSRGGkLJFt60eyvhS5CQTj+M3d0tS8ukoUzHTQcND7c2a1mPU4YbJd2giEZIQgX8gxMh7cSA/0p2kCrpEjC8jzIDCXImtlyg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=b6INL0O2; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718876004; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=qXHDeZZNMWTK5Swh7Jgnx53swgXS/B/SgWsa4Tne8q4=;
	b=b6INL0O260VmO9kEldHaLzWAgPsnUugvFHx1yka9ppJcm87d/U6ODasOIQzprDlHURALBHn8odMYKKc4R8JFnpZs/mjc/h2TJEXmJ6sh9OZhI4p0Bic4N7KAjPOTjFNWnMESin7vHuP2LwvwDL2kpaWKN1SS93igglW9PmK2bgY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067110;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0W8rHBJ-_1718876003;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W8rHBJ-_1718876003)
          by smtp.aliyun-inc.com;
          Thu, 20 Jun 2024 17:33:23 +0800
Message-ID: <1718875728.9338605-7-hengqi@linux.alibaba.com>
Subject: Re: [PATCH 2/2] virtio_net: fixing XDP for fully checksummed packets handling
Date: Thu, 20 Jun 2024 17:28:48 +0800
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
 <1718680517.8370645-12-hengqi@linux.alibaba.com>
 <CACGkMEsa3AsPkweqS0-BEjSw5sKW_XM669HVSN_eX7-8KVG8tQ@mail.gmail.com>
In-Reply-To: <CACGkMEsa3AsPkweqS0-BEjSw5sKW_XM669HVSN_eX7-8KVG8tQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Thu, 20 Jun 2024 16:33:35 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Tue, Jun 18, 2024 at 11:17=E2=80=AFAM Heng Qi <hengqi@linux.alibaba.co=
m> wrote:
> >
> > On Tue, 18 Jun 2024 11:10:26 +0800, Jason Wang <jasowang@redhat.com> wr=
ote:
> > > On Mon, Jun 17, 2024 at 9:15=E2=80=AFPM Heng Qi <hengqi@linux.alibaba=
.com> wrote:
> > > >
> > > > The XDP program can't correctly handle partially checksummed
> > > > packets, but works fine with fully checksummed packets.
> > >
> > > Not sure this is ture, if I was not wrong, XDP can try to calculate c=
hecksum.
> >
> > XDP's interface serves a full checksum,
>=20
> What do you mean by "serve" here? I mean, XDP can calculate the
> checksum and fill it in the packet by itself.
>=20

Yes, XDP can parse and calculate checksums for all packets.
However, the bpf_csum_diff and bpf_l4_csum_replace APIs provided by XDP ass=
ume
that the packets being processed are fully checksumed packets. That is,
after the XDP program modified the packets, the incremental checksum can be
calculated (for example, samples/bpf/tcbpf1_kern.c, samples/bpf/test_lwt_bp=
f.c).

Therefore, partially checksummed packets cannot be processed normally in th=
ese
examples and need to be discarded.

> > and this is why we disabled the
> > offloading of VIRTIO_NET_F_GUEST_CSUM when loading XDP.
>=20
> If we trust the device to disable VIRTIO_NET_F_GUEST_CSUM, any reason
> to check VIRTIO_NET_HDR_F_NEEDS_CSUM again in the receive path?

There doesn't seem to be a mandatory constraint in the spec that devices th=
at
haven't negotiated VIRTIO_NET_F_GUEST_CSUM cannot set NEEDS_CSUM bit, so I =
check this.

Thanks.

>=20
> >
> > Thanks.
>=20
> Thanks
>=20
> >
> > >
> > > Thanks
> > >
> > > > If the
> > > > device has already validated fully checksummed packets, then
> > > > the driver doesn't need to re-validate them, saving CPU resources.
> > > >
> > > > Additionally, the driver does not drop all partially checksummed
> > > > packets when VIRTIO_NET_F_GUEST_CSUM is not negotiated. This is
> > > > not a bug, as the driver has always done this.
> > > >
> > > > Fixes: 436c9453a1ac ("virtio-net: keep vnet header zeroed after pro=
cessing XDP")
> > > > Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> > > > ---
> > > >  drivers/net/virtio_net.c | 20 +++++++++++++++++++-
> > > >  1 file changed, 19 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > index aa70a7ed8072..ea10db9a09fa 100644
> > > > --- a/drivers/net/virtio_net.c
> > > > +++ b/drivers/net/virtio_net.c
> > > > @@ -1360,6 +1360,10 @@ static struct sk_buff *receive_small_xdp(str=
uct net_device *dev,
> > > >         if (unlikely(hdr->hdr.gso_type))
> > > >                 goto err_xdp;
> > > >
> > > > +       /* Partially checksummed packets must be dropped. */
> > > > +       if (unlikely(hdr->hdr.flags & VIRTIO_NET_HDR_F_NEEDS_CSUM))
> > > > +               goto err_xdp;
> > > > +
> > > >         buflen =3D SKB_DATA_ALIGN(GOOD_PACKET_LEN + headroom) +
> > > >                 SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
> > > >
> > > > @@ -1677,6 +1681,10 @@ static void *mergeable_xdp_get_buf(struct vi=
rtnet_info *vi,
> > > >         if (unlikely(hdr->hdr.gso_type))
> > > >                 return NULL;
> > > >
> > > > +       /* Partially checksummed packets must be dropped. */
> > > > +       if (unlikely(hdr->hdr.flags & VIRTIO_NET_HDR_F_NEEDS_CSUM))
> > > > +               return NULL;
> > > > +
> > > >         /* Now XDP core assumes frag size is PAGE_SIZE, but buffers
> > > >          * with headroom may add hole in truesize, which
> > > >          * make their length exceed PAGE_SIZE. So we disabled the
> > > > @@ -1943,6 +1951,7 @@ static void receive_buf(struct virtnet_info *=
vi, struct receive_queue *rq,
> > > >         struct net_device *dev =3D vi->dev;
> > > >         struct sk_buff *skb;
> > > >         struct virtio_net_common_hdr *hdr;
> > > > +       u8 flags;
> > > >
> > > >         if (unlikely(len < vi->hdr_len + ETH_HLEN)) {
> > > >                 pr_debug("%s: short packet %i\n", dev->name, len);
> > > > @@ -1951,6 +1960,15 @@ static void receive_buf(struct virtnet_info =
*vi, struct receive_queue *rq,
> > > >                 return;
> > > >         }
> > > >
> > > > +       /* 1. Save the flags early, as the XDP program might overwr=
ite them.
> > > > +        * These flags ensure packets marked as VIRTIO_NET_HDR_F_DA=
TA_VALID
> > > > +        * stay valid after XDP processing.
> > > > +        * 2. XDP doesn't work with partially checksummed packets (=
refer to
> > > > +        * virtnet_xdp_set()), so packets marked as
> > > > +        * VIRTIO_NET_HDR_F_NEEDS_CSUM get dropped during XDP proce=
ssing.
> > > > +        */
> > > > +       flags =3D ((struct virtio_net_common_hdr *)buf)->hdr.flags;
> > > > +
> > > >         if (vi->mergeable_rx_bufs)
> > > >                 skb =3D receive_mergeable(dev, vi, rq, buf, ctx, le=
n, xdp_xmit,
> > > >                                         stats);
> > > > @@ -1966,7 +1984,7 @@ static void receive_buf(struct virtnet_info *=
vi, struct receive_queue *rq,
> > > >         if (dev->features & NETIF_F_RXHASH && vi->has_rss_hash_repo=
rt)
> > > >                 virtio_skb_set_hash(&hdr->hash_v1_hdr, skb);
> > > >
> > > > -       if (hdr->hdr.flags & VIRTIO_NET_HDR_F_DATA_VALID)
> > > > +       if (flags & VIRTIO_NET_HDR_F_DATA_VALID)
> > > >                 skb->ip_summed =3D CHECKSUM_UNNECESSARY;
> > > >
> > > >         if (virtio_net_hdr_to_skb(skb, &hdr->hdr,
> > > > --
> > > > 2.32.0.3.g01195cf9f
> > > >
> > >
> >
>=20

