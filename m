Return-Path: <netdev+bounces-105203-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63AB591019E
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 12:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 427C4283794
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 10:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1FFD1AAE18;
	Thu, 20 Jun 2024 10:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="qZH43+Yy"
X-Original-To: netdev@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C747D1A8C09
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 10:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718880008; cv=none; b=ZvxFkYPIttcmODNQ4VRD36XappiAZ8dOwzl/nt/YAS8wgaQPmgC8NKzXlvjaB+VoCI+i07xlouP5KXc+Lr9xL1Q52r6YspneOEL/YdFikLI2iKMUDATQvfRLte83mcZOqAoxWifxNtZ4duxuQRrAwyVgR2e83Y338jgAc6Z0fVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718880008; c=relaxed/simple;
	bh=Zw9qpO+r1nzf+ORBN6hO/Oqm1MuBeBSQsnFcVxfvzmk=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=r1UYCE8w0D5dbq6KXbA09topejfILHyH+JYbwrgUnAJf2hBcyql8CPmBpvW1BLdS5bSNqzadv1PFCOru31+LDyxxYTo4JivrG6MQ9leP1yjyEnZjPqOE6N7V+G2r75VO0MxkZwepGB2cV0UDwwbzs5hDZ8nqoD8vJgMjJxx9ox4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=qZH43+Yy; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718880003; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=d9K68yXD0uUIPSuPzoHQIO6969QfhsA4Fem+RZyg2dM=;
	b=qZH43+YynphvetbbUwKMjhnz3TrC1livzteqAgYuloHW1vT6oj8BiOI30lqiDEVLiMFcB3ERw8TtPU4aThAOE95JUIh8SGTzh5FquqlTPEsQCXINSSL9HFh8Ryx8h/YhQzgdYFvbN/wnvBM0U9h8JyrukgKVowc3pRP/smGvWFI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045075189;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0W8s9bm8_1718880002;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W8s9bm8_1718880002)
          by smtp.aliyun-inc.com;
          Thu, 20 Jun 2024 18:40:03 +0800
Message-ID: <1718879929.7095907-12-hengqi@linux.alibaba.com>
Subject: Re: [PATCH 2/2] virtio_net: fixing XDP for fully checksummed packets handling
Date: Thu, 20 Jun 2024 18:38:49 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: Jason Wang <jasowang@redhat.com>,
 netdev@vger.kernel.org,
 virtualization@lists.linux.dev,
 Thomas Huth <thuth@linux.vnet.ibm.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Eric Dumazet <edumazet@google.com>,
 "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20240617131524.63662-1-hengqi@linux.alibaba.com>
 <20240617131524.63662-3-hengqi@linux.alibaba.com>
 <CACGkMEvj8fvXkCxDFQ1-Cyq5DL=axEf1Ch1zVnuQUNQy6Wjn+g@mail.gmail.com>
 <1718680517.8370645-12-hengqi@linux.alibaba.com>
 <CACGkMEsa3AsPkweqS0-BEjSw5sKW_XM669HVSN_eX7-8KVG8tQ@mail.gmail.com>
 <1718875728.9338605-7-hengqi@linux.alibaba.com>
 <20240620061710-mutt-send-email-mst@kernel.org>
 <1718879236.1007793-10-hengqi@linux.alibaba.com>
In-Reply-To: <1718879236.1007793-10-hengqi@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Thu, 20 Jun 2024 18:27:16 +0800, Heng Qi <hengqi@linux.alibaba.com> wrot=
e:
> On Thu, 20 Jun 2024 06:19:01 -0400, "Michael S. Tsirkin" <mst@redhat.com>=
 wrote:
> > On Thu, Jun 20, 2024 at 05:28:48PM +0800, Heng Qi wrote:
> > > On Thu, 20 Jun 2024 16:33:35 +0800, Jason Wang <jasowang@redhat.com> =
wrote:
> > > > On Tue, Jun 18, 2024 at 11:17=E2=80=AFAM Heng Qi <hengqi@linux.alib=
aba.com> wrote:
> > > > >
> > > > > On Tue, 18 Jun 2024 11:10:26 +0800, Jason Wang <jasowang@redhat.c=
om> wrote:
> > > > > > On Mon, Jun 17, 2024 at 9:15=E2=80=AFPM Heng Qi <hengqi@linux.a=
libaba.com> wrote:
> > > > > > >
> > > > > > > The XDP program can't correctly handle partially checksummed
> > > > > > > packets, but works fine with fully checksummed packets.
> > > > > >
> > > > > > Not sure this is ture, if I was not wrong, XDP can try to calcu=
late checksum.
> > > > >
> > > > > XDP's interface serves a full checksum,
> > > >=20
> > > > What do you mean by "serve" here? I mean, XDP can calculate the
> > > > checksum and fill it in the packet by itself.
> > > >=20
> > >=20
> > > Yes, XDP can parse and calculate checksums for all packets.
> > > However, the bpf_csum_diff and bpf_l4_csum_replace APIs provided by X=
DP assume
> > > that the packets being processed are fully checksumed packets. That i=
s,
> > > after the XDP program modified the packets, the incremental checksum =
can be
> > > calculated (for example, samples/bpf/tcbpf1_kern.c, samples/bpf/test_=
lwt_bpf.c).
> > >=20
> > > Therefore, partially checksummed packets cannot be processed normally=
 in these
> > > examples and need to be discarded.
> > >=20
> > > > > and this is why we disabled the
> > > > > offloading of VIRTIO_NET_F_GUEST_CSUM when loading XDP.
> > > >=20
> > > > If we trust the device to disable VIRTIO_NET_F_GUEST_CSUM, any reas=
on
> > > > to check VIRTIO_NET_HDR_F_NEEDS_CSUM again in the receive path?
> > >=20
> > > There doesn't seem to be a mandatory constraint in the spec that devi=
ces that
> > > haven't negotiated VIRTIO_NET_F_GUEST_CSUM cannot set NEEDS_CSUM bit,=
 so I check this.
> > >=20
> > > Thanks.
> >=20
> > The spec says:
> >=20
> > \item If the VIRTIO_NET_F_GUEST_CSUM feature was negotiated, the
> >   VIRTIO_NET_HDR_F_NEEDS_CSUM bit in \field{flags} can be
> >   set: if so, the packet checksum at offset \field{csum_offset}=20
> >   from \field{csum_start} and any preceding checksums
> >   have been validated.  The checksum on the packet is incomplete and
> >   if bit VIRTIO_NET_HDR_F_RSC_INFO is not set in \field{flags},
> >   then \field{csum_start} and \field{csum_offset} indicate how to calcu=
late it
> >   (see Packet Transmission point 1).
> >=20
> >=20
> > So yes, NEEDS_CSUM without VIRTIO_NET_F_GUEST_CSUM is at best undefined.
> > Please do not try to use it unless VIRTIO_NET_F_GUEST_CSUM is set.
>=20
> I've seen it before, but thought something like
>  "The device MUST NOT set the NEEDS_CSUM bit if GUEST_CSUM has not been n=
egotiated"
> would be clearer.
>=20
> Furthermore, it is still possible for a malicious device to set the bit.

Hint:
We previously checked and used DATA_VALID and NEEDS_CSUM bits, but never ch=
ecked
to see if GUEST_CSUM was negotiated.

>=20
> Thanks.
>=20
> >=20
> > And if you want to be flexible, ignore it unless VIRTIO_NET_F_GUEST_CSUM
> > has been negotiated.
> >=20
> >=20
> >=20
> >=20
> >=20
> > > >=20
> > > > >
> > > > > Thanks.
> > > >=20
> > > > Thanks
> > > >=20
> > > > >
> > > > > >
> > > > > > Thanks
> > > > > >
> > > > > > > If the
> > > > > > > device has already validated fully checksummed packets, then
> > > > > > > the driver doesn't need to re-validate them, saving CPU resou=
rces.
> > > > > > >
> > > > > > > Additionally, the driver does not drop all partially checksum=
med
> > > > > > > packets when VIRTIO_NET_F_GUEST_CSUM is not negotiated. This =
is
> > > > > > > not a bug, as the driver has always done this.
> > > > > > >
> > > > > > > Fixes: 436c9453a1ac ("virtio-net: keep vnet header zeroed aft=
er processing XDP")
> > > > > > > Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> > > > > > > ---
> > > > > > >  drivers/net/virtio_net.c | 20 +++++++++++++++++++-
> > > > > > >  1 file changed, 19 insertions(+), 1 deletion(-)
> > > > > > >
> > > > > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_ne=
t.c
> > > > > > > index aa70a7ed8072..ea10db9a09fa 100644
> > > > > > > --- a/drivers/net/virtio_net.c
> > > > > > > +++ b/drivers/net/virtio_net.c
> > > > > > > @@ -1360,6 +1360,10 @@ static struct sk_buff *receive_small_x=
dp(struct net_device *dev,
> > > > > > >         if (unlikely(hdr->hdr.gso_type))
> > > > > > >                 goto err_xdp;
> > > > > > >
> > > > > > > +       /* Partially checksummed packets must be dropped. */
> > > > > > > +       if (unlikely(hdr->hdr.flags & VIRTIO_NET_HDR_F_NEEDS_=
CSUM))
> > > > > > > +               goto err_xdp;
> > > > > > > +
> > > > > > >         buflen =3D SKB_DATA_ALIGN(GOOD_PACKET_LEN + headroom)=
 +
> > > > > > >                 SKB_DATA_ALIGN(sizeof(struct skb_shared_info)=
);
> > > > > > >
> > > > > > > @@ -1677,6 +1681,10 @@ static void *mergeable_xdp_get_buf(str=
uct virtnet_info *vi,
> > > > > > >         if (unlikely(hdr->hdr.gso_type))
> > > > > > >                 return NULL;
> > > > > > >
> > > > > > > +       /* Partially checksummed packets must be dropped. */
> > > > > > > +       if (unlikely(hdr->hdr.flags & VIRTIO_NET_HDR_F_NEEDS_=
CSUM))
> > > > > > > +               return NULL;
> > > > > > > +
> > > > > > >         /* Now XDP core assumes frag size is PAGE_SIZE, but b=
uffers
> > > > > > >          * with headroom may add hole in truesize, which
> > > > > > >          * make their length exceed PAGE_SIZE. So we disabled=
 the
> > > > > > > @@ -1943,6 +1951,7 @@ static void receive_buf(struct virtnet_=
info *vi, struct receive_queue *rq,
> > > > > > >         struct net_device *dev =3D vi->dev;
> > > > > > >         struct sk_buff *skb;
> > > > > > >         struct virtio_net_common_hdr *hdr;
> > > > > > > +       u8 flags;
> > > > > > >
> > > > > > >         if (unlikely(len < vi->hdr_len + ETH_HLEN)) {
> > > > > > >                 pr_debug("%s: short packet %i\n", dev->name, =
len);
> > > > > > > @@ -1951,6 +1960,15 @@ static void receive_buf(struct virtnet=
_info *vi, struct receive_queue *rq,
> > > > > > >                 return;
> > > > > > >         }
> > > > > > >
> > > > > > > +       /* 1. Save the flags early, as the XDP program might =
overwrite them.
> > > > > > > +        * These flags ensure packets marked as VIRTIO_NET_HD=
R_F_DATA_VALID
> > > > > > > +        * stay valid after XDP processing.
> > > > > > > +        * 2. XDP doesn't work with partially checksummed pac=
kets (refer to
> > > > > > > +        * virtnet_xdp_set()), so packets marked as
> > > > > > > +        * VIRTIO_NET_HDR_F_NEEDS_CSUM get dropped during XDP=
 processing.
> > > > > > > +        */
> > > > > > > +       flags =3D ((struct virtio_net_common_hdr *)buf)->hdr.=
flags;
> > > > > > > +
> > > > > > >         if (vi->mergeable_rx_bufs)
> > > > > > >                 skb =3D receive_mergeable(dev, vi, rq, buf, c=
tx, len, xdp_xmit,
> > > > > > >                                         stats);
> > > > > > > @@ -1966,7 +1984,7 @@ static void receive_buf(struct virtnet_=
info *vi, struct receive_queue *rq,
> > > > > > >         if (dev->features & NETIF_F_RXHASH && vi->has_rss_has=
h_report)
> > > > > > >                 virtio_skb_set_hash(&hdr->hash_v1_hdr, skb);
> > > > > > >
> > > > > > > -       if (hdr->hdr.flags & VIRTIO_NET_HDR_F_DATA_VALID)
> > > > > > > +       if (flags & VIRTIO_NET_HDR_F_DATA_VALID)
> > > > > > >                 skb->ip_summed =3D CHECKSUM_UNNECESSARY;
> > > > > > >
> > > > > > >         if (virtio_net_hdr_to_skb(skb, &hdr->hdr,
> > > > > > > --
> > > > > > > 2.32.0.3.g01195cf9f
> > > > > > >
> > > > > >
> > > > >
> > > >=20
> >=20
>=20

