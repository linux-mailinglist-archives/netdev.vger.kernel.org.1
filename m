Return-Path: <netdev+bounces-87768-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02AA48A484E
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 08:46:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0544C1C210A1
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 06:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5273E1CFB9;
	Mon, 15 Apr 2024 06:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SzXoV61Q"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A25210FB
	for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 06:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713163554; cv=none; b=lBVbaPOzg651CVhJWWD/Qc4vcpCPju8zfn8WMF2E8/O5m2ERDciEJrDwbLk67iYB+Sg91rnx3Uc/qH5pbeRJA4RR9MPVImzAdFFZ/q4OOl3riPzQQjbhjjqQEQGCWI+x/I47gxhIdla5NRlLbs2VoSzfanyN5t+2s+k1RoLP1Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713163554; c=relaxed/simple;
	bh=aK3Bjc84XQ2H7tYG7F3tleBd2ohfWRoIIBj3ruxtivA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f2s/Q723AzgrysQxmh5QQBy2qBdFmesGKL2b77XXIMQKNCXYu6HIPwyg65Ogho5M07rYyFEmA9MAHj+E3KK08OztXvrD7RMhV0MHDGnwbpfPc1g+pLxzD+gSBGjxHxHHUUVy9fP9eImsJ+g85jBfvPRcyJrdlVkM1Z+2in7yZsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SzXoV61Q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713163551;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5L287S5aWP8W7IobbeQ4Ncs4Snay4WFb68+4we1zxhc=;
	b=SzXoV61QS3o9fOp7POmztvAcz1Zxnqf0u4FlDtfUP9fgR0mS8GsvVGNBHpBIeOei1Eu9xh
	7Jr5BxNhzAfWy0uWYgJe05rvzZuD+WjreKAt6ETs7FNjXhMGz7tvwv08vxYIauyTzxZMiP
	w4FDNbi/Lhz1wyteZVZWrsiC/9ToOWE=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-Y9Ksek4yP3G4LobJi3aoTQ-1; Mon, 15 Apr 2024 02:45:48 -0400
X-MC-Unique: Y9Ksek4yP3G4LobJi3aoTQ-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2a2e6197371so3053435a91.3
        for <netdev@vger.kernel.org>; Sun, 14 Apr 2024 23:45:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713163548; x=1713768348;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5L287S5aWP8W7IobbeQ4Ncs4Snay4WFb68+4we1zxhc=;
        b=oqbgcZp4kI/QC4s+hbgeTL+tdGLWyV3fZR385GLuE6lDs9aMCxN6sITGn32b05TMwj
         0J8ZhbGfB682hSgQJ3p1ET/H8Wr1vUtxWnNBYimBiZCCbNE5zly9oE9WYYgipRZLrYAL
         qV7tpztKynfN5i4UuYYH2wmaRGCwP4Jlp5Kkp5Iy76ChrzIqY+uUeTy/3SeVrMmX6C2P
         7pwwCz+6MGl0ik5M/JlUWN8hmgSUImVBOb60NQTmbEdVXPX+SYqQnp37RYdFUIXIx+gO
         6VvFieCIbdrAWE/MwhCFMWi8ruwyfuVMIcDwCcpf7CTWdsvvHmRiUWzncDSE/2TFmF52
         Cjgw==
X-Gm-Message-State: AOJu0YwJSrh9/hAPK8T37DdH/7cqu7IBzO83Tct8bC8LxKCzTVUWtwVv
	jKPiS9cL38O3vbo8jn9yLhwpyXJgDD6Q08vA4glk9eRwJq3u5ORdKRXKL29k1dDVCIsQdC9cAN+
	Bx5RmyrER0mUXzMPGwn8g6ZL4/DP0pbHLh6qYQkxmI2t8E9Oe0GM2yWM/m6U0NImtNwunqgGIf0
	1Gzwf81F7BAaH+vWDeM8aSH5YV1LB3
X-Received: by 2002:a17:90a:4605:b0:2a5:3753:6050 with SMTP id w5-20020a17090a460500b002a537536050mr7421504pjg.46.1713163547930;
        Sun, 14 Apr 2024 23:45:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDeLMWpPOyySPiUb06db6AIvzCgw/6awX0B80M3M5PpFS4myrUX1UZ+G70Vxn4NGsYJyR8qHlLLkOWdfzAKuY=
X-Received: by 2002:a17:90a:4605:b0:2a5:3753:6050 with SMTP id
 w5-20020a17090a460500b002a537536050mr7421491pjg.46.1713163547579; Sun, 14 Apr
 2024 23:45:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240318110602.37166-1-xuanzhuo@linux.alibaba.com>
 <20240318110602.37166-5-xuanzhuo@linux.alibaba.com> <CACGkMEujuYh+Ups9jx5jEwe7bydtgCyurG5bPLe3X8jpSJhqvA@mail.gmail.com>
 <1712746366.8053942-2-xuanzhuo@linux.alibaba.com> <CACGkMEsvAUyk+h3e5SO5T4L8HuSGcViKj2WM2J33JOb7KTKjUw@mail.gmail.com>
 <1713148927.6675713-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1713148927.6675713-2-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 15 Apr 2024 14:45:36 +0800
Message-ID: <CACGkMEvbLvQUppO6nnp0DCxACco7S=2QLgge4ZhARo9Ov_fJKQ@mail.gmail.com>
Subject: Re: [PATCH net-next v5 4/9] virtio_net: support device stats
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@google.com>, Amritha Nambiar <amritha.nambiar@intel.com>, 
	Larysa Zaremba <larysa.zaremba@intel.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, virtualization@lists.linux.dev, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 10:51=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibaba.=
com> wrote:
>
> On Thu, 11 Apr 2024 14:09:24 +0800, Jason Wang <jasowang@redhat.com> wrot=
e:
> > On Wed, Apr 10, 2024 at 6:55=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.aliba=
ba.com> wrote:
> > >
> > > On Wed, 10 Apr 2024 14:09:23 +0800, Jason Wang <jasowang@redhat.com> =
wrote:
> > > > On Mon, Mar 18, 2024 at 7:06=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.a=
libaba.com> wrote:
> > > > >
> > > > > As the spec https://github.com/oasis-tcs/virtio-spec/commit/42f38=
9989823039724f95bbbd243291ab0064f82
> > > > >
> > > > > make virtio-net support getting the stats from the device by etht=
ool -S
> > > > > <eth0>.
> > > > >
> > > > > Due to the numerous descriptors stats, an organization method is
> > > > > required. For this purpose, I have introduced the "virtnet_stats_=
map".
> > > > > Utilizing this array simplifies coding tasks such as generating f=
ield
> > > > > names, calculating buffer sizes for requests and responses, and p=
arsing
> > > > > replies from the device. By iterating over the "virtnet_stats_map=
,"
> > > > > these operations become more streamlined and efficient.
> > > > >
> > > > > NIC statistics:
> > > > >      rx0_packets: 582951
> > > > >      rx0_bytes: 155307077
> > > > >      rx0_drops: 0
> > > > >      rx0_xdp_packets: 0
> > > > >      rx0_xdp_tx: 0
> > > > >      rx0_xdp_redirects: 0
> > > > >      rx0_xdp_drops: 0
> > > > >      rx0_kicks: 17007
> > > > >      rx0_hw_packets: 2179409
> > > > >      rx0_hw_bytes: 510015040
> > > > >      rx0_hw_notifications: 0
> > > > >      rx0_hw_interrupts: 0
> > > > >      rx0_hw_drops: 12964
> > > > >      rx0_hw_drop_overruns: 0
> > > > >      rx0_hw_csum_valid: 2179409
> > > > >      rx0_hw_csum_none: 0
> > > > >      rx0_hw_csum_bad: 0
> > > > >      rx0_hw_needs_csum: 2179409
> > > > >      rx0_hw_ratelimit_packets: 0
> > > > >      rx0_hw_ratelimit_bytes: 0
> > > > >      tx0_packets: 15361
> > > > >      tx0_bytes: 1918970
> > > > >      tx0_xdp_tx: 0
> > > > >      tx0_xdp_tx_drops: 0
> > > > >      tx0_kicks: 15361
> > > > >      tx0_timeouts: 0
> > > > >      tx0_hw_packets: 32272
> > > > >      tx0_hw_bytes: 4311698
> > > > >      tx0_hw_notifications: 0
> > > > >      tx0_hw_interrupts: 0
> > > > >      tx0_hw_drops: 0
> > > > >      tx0_hw_drop_malformed: 0
> > > > >      tx0_hw_csum_none: 0
> > > > >      tx0_hw_needs_csum: 32272
> > > > >      tx0_hw_ratelimit_packets: 0
> > > > >      tx0_hw_ratelimit_bytes: 0
> > > > >
> > > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > ---
> > > > >  drivers/net/virtio_net.c | 401 +++++++++++++++++++++++++++++++++=
+++++-
> > > > >  1 file changed, 397 insertions(+), 4 deletions(-)
> > > > >
> > > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > > index 8cb5bdd7ad91..70c1d4e850e0 100644
> > > > > --- a/drivers/net/virtio_net.c
> > > > > +++ b/drivers/net/virtio_net.c
> > > > > @@ -128,6 +128,129 @@ static const struct virtnet_stat_desc virtn=
et_rq_stats_desc[] =3D {
> > > > >  #define VIRTNET_SQ_STATS_LEN   ARRAY_SIZE(virtnet_sq_stats_desc)
> > > > >  #define VIRTNET_RQ_STATS_LEN   ARRAY_SIZE(virtnet_rq_stats_desc)
> > > > >
> > > > > +#define VIRTNET_STATS_DESC_CQ(name) \
> > > > > +       {#name, offsetof(struct virtio_net_stats_cvq, name)}
> > > > > +
> > > > > +#define VIRTNET_STATS_DESC_RX(class, name) \
> > > > > +       {#name, offsetof(struct virtio_net_stats_rx_ ## class, rx=
_ ## name)}
> > > > > +
> > > > > +#define VIRTNET_STATS_DESC_TX(class, name) \
> > > > > +       {#name, offsetof(struct virtio_net_stats_tx_ ## class, tx=
_ ## name)}
> > > > > +
> > > > > +static const struct virtnet_stat_desc virtnet_stats_cvq_desc[] =
=3D {
> > > > > +       VIRTNET_STATS_DESC_CQ(command_num),
> > > > > +       VIRTNET_STATS_DESC_CQ(ok_num),
> > > > > +};
> > > > > +
> > > > > +static const struct virtnet_stat_desc virtnet_stats_rx_basic_des=
c[] =3D {
> > > > > +       VIRTNET_STATS_DESC_RX(basic, packets),
> > > > > +       VIRTNET_STATS_DESC_RX(basic, bytes),
> > > > > +
> > > > > +       VIRTNET_STATS_DESC_RX(basic, notifications),
> > > > > +       VIRTNET_STATS_DESC_RX(basic, interrupts),
> > > > > +
> > > > > +       VIRTNET_STATS_DESC_RX(basic, drops),
> > > > > +       VIRTNET_STATS_DESC_RX(basic, drop_overruns),
> > > > > +};
> > > > > +
> > > > > +static const struct virtnet_stat_desc virtnet_stats_tx_basic_des=
c[] =3D {
> > > > > +       VIRTNET_STATS_DESC_TX(basic, packets),
> > > > > +       VIRTNET_STATS_DESC_TX(basic, bytes),
> > > > > +
> > > > > +       VIRTNET_STATS_DESC_TX(basic, notifications),
> > > > > +       VIRTNET_STATS_DESC_TX(basic, interrupts),
> > > > > +
> > > > > +       VIRTNET_STATS_DESC_TX(basic, drops),
> > > > > +       VIRTNET_STATS_DESC_TX(basic, drop_malformed),
> > > > > +};
> > > > > +
> > > > > +static const struct virtnet_stat_desc virtnet_stats_rx_csum_desc=
[] =3D {
> > > > > +       VIRTNET_STATS_DESC_RX(csum, csum_valid),
> > > > > +       VIRTNET_STATS_DESC_RX(csum, needs_csum),
> > > > > +
> > > > > +       VIRTNET_STATS_DESC_RX(csum, csum_none),
> > > > > +       VIRTNET_STATS_DESC_RX(csum, csum_bad),
> > > > > +};
> > > > > +
> > > > > +static const struct virtnet_stat_desc virtnet_stats_tx_csum_desc=
[] =3D {
> > > > > +       VIRTNET_STATS_DESC_TX(csum, needs_csum),
> > > > > +       VIRTNET_STATS_DESC_TX(csum, csum_none),
> > > > > +};
> > > > > +
> > > > > +static const struct virtnet_stat_desc virtnet_stats_rx_gso_desc[=
] =3D {
> > > > > +       VIRTNET_STATS_DESC_RX(gso, gso_packets),
> > > > > +       VIRTNET_STATS_DESC_RX(gso, gso_bytes),
> > > > > +       VIRTNET_STATS_DESC_RX(gso, gso_packets_coalesced),
> > > > > +       VIRTNET_STATS_DESC_RX(gso, gso_bytes_coalesced),
> > > > > +};
> > > > > +
> > > > > +static const struct virtnet_stat_desc virtnet_stats_tx_gso_desc[=
] =3D {
> > > > > +       VIRTNET_STATS_DESC_TX(gso, gso_packets),
> > > > > +       VIRTNET_STATS_DESC_TX(gso, gso_bytes),
> > > > > +       VIRTNET_STATS_DESC_TX(gso, gso_segments),
> > > > > +       VIRTNET_STATS_DESC_TX(gso, gso_segments_bytes),
> > > > > +       VIRTNET_STATS_DESC_TX(gso, gso_packets_noseg),
> > > > > +       VIRTNET_STATS_DESC_TX(gso, gso_bytes_noseg),
> > > > > +};
> > > > > +
> > > > > +static const struct virtnet_stat_desc virtnet_stats_rx_speed_des=
c[] =3D {
> > > > > +       VIRTNET_STATS_DESC_RX(speed, ratelimit_packets),
> > > > > +       VIRTNET_STATS_DESC_RX(speed, ratelimit_bytes),
> > > > > +};
> > > > > +
> > > > > +static const struct virtnet_stat_desc virtnet_stats_tx_speed_des=
c[] =3D {
> > > > > +       VIRTNET_STATS_DESC_TX(speed, ratelimit_packets),
> > > > > +       VIRTNET_STATS_DESC_TX(speed, ratelimit_bytes),
> > > > > +};
> > > > > +
> > > > > +#define VIRTNET_Q_TYPE_RX 0
> > > > > +#define VIRTNET_Q_TYPE_TX 1
> > > > > +#define VIRTNET_Q_TYPE_CQ 2
> > > > > +
> > > > > +struct virtnet_stats_map {
> > > > > +       /* The stat type in bitmap. */
> > > > > +       u64 stat_type;
> > > > > +
> > > > > +       /* The bytes of the response for the stat. */
> > > > > +       u32 len;
> > > > > +
> > > > > +       /* The num of the response fields for the stat. */
> > > > > +       u32 num;
> > > > > +
> > > > > +       /* The type of queue corresponding to the statistics. (cq=
, rq, sq) */
> > > > > +       u32 queue_type;
> > > > > +
> > > > > +       /* The reply type of the stat. */
> > > > > +       u8 reply_type;
> > > > > +
> > > > > +       /* Describe the name and the offset in the response. */
> > > > > +       const struct virtnet_stat_desc *desc;
> > > > > +};
> > > > > +
> > > > > +#define VIRTNET_DEVICE_STATS_MAP_ITEM(TYPE, type, queue_type)  \
> > > > > +       {                                                       \
> > > > > +               VIRTIO_NET_STATS_TYPE_##TYPE,                   \
> > > > > +               sizeof(struct virtio_net_stats_ ## type),       \
> > > > > +               ARRAY_SIZE(virtnet_stats_ ## type ##_desc),     \
> > > > > +               VIRTNET_Q_TYPE_##queue_type,                    \
> > > > > +               VIRTIO_NET_STATS_TYPE_REPLY_##TYPE,             \
> > > > > +               &virtnet_stats_##type##_desc[0]                 \
> > > > > +       }
> > > > > +
> > > > > +static struct virtnet_stats_map virtio_net_stats_map[] =3D {
> > > > > +       VIRTNET_DEVICE_STATS_MAP_ITEM(CVQ, cvq, CQ),
> > > > > +
> > > > > +       VIRTNET_DEVICE_STATS_MAP_ITEM(RX_BASIC, rx_basic, RX),
> > > > > +       VIRTNET_DEVICE_STATS_MAP_ITEM(RX_CSUM,  rx_csum,  RX),
> > > > > +       VIRTNET_DEVICE_STATS_MAP_ITEM(RX_GSO,   rx_gso,   RX),
> > > > > +       VIRTNET_DEVICE_STATS_MAP_ITEM(RX_SPEED, rx_speed, RX),
> > > > > +
> > > > > +       VIRTNET_DEVICE_STATS_MAP_ITEM(TX_BASIC, tx_basic, TX),
> > > > > +       VIRTNET_DEVICE_STATS_MAP_ITEM(TX_CSUM,  tx_csum,  TX),
> > > > > +       VIRTNET_DEVICE_STATS_MAP_ITEM(TX_GSO,   tx_gso,   TX),
> > > > > +       VIRTNET_DEVICE_STATS_MAP_ITEM(TX_SPEED, tx_speed, TX),
> > > > > +};
> > > >
> > > > I think the reason you did this is to ease the future extensions bu=
t
> > > > multiple levels of nested macros makes the code hard to review. Any
> > > > way to eliminate this?
> > >
> > >
> > > NOT only for the future extensions.
> > >
> > > When we parse the reply from the device, we need to check the reply s=
tats
> > > one by one, we need the stats info to help parse the stats.
> >
> > Yes, but I meant for example any reason why it can't be done by
> > extending virtnet_stat_desc ?
>
>
>
> You know, virtio_net_stats_map is way to organize the descs.
>
> This is used to avoid the big if-else when parsing the replys from the de=
vice.
>
> If no this map, we will have a big if-else like:
>
>  if (reply.type =3D=3D rx_basic) {
>          /* do the same something */
>  }
>  if (reply.type =3D=3D tx_basic) {
>          /* do the same something */
>  }
>  if (reply.type =3D=3D rx_csum) {
>          /* do the same something */
>  }
>  if (reply.type =3D=3D tx_csum) {
>          /* do the same something */
>  }
>  if (reply.type =3D=3D rx_gso) {
>          /* do the same something */
>  }
>  if (reply.type =3D=3D tx_gso) {
>          /* do the same something */
>  }
>  if (reply.type =3D=3D rx_speed) {
>          /* do the same something */
>  }
>  if (reply.type =3D=3D tx_speed) {
>          /* do the same something */
>  }
>
> I want to avoid this, so introducing this map.

Could we have a function pointers array indexed by the type?

Thanks

>
> YES. I noticed other comments, but I think we should
> fix this problem firstly.
>
> Thanks.
>
>
> >
> > >
> > >         static void virtnet_fill_stats(struct virtnet_info *vi, u32 q=
id,
> > >                                       struct virtnet_stats_ctx *ctx,
> > >                                       const u8 *base, u8 type)
> > >         {
> > >                u32 queue_type, num_rx, num_tx, num_cq;
> > >                struct virtnet_stats_map *m;
> > >                u64 offset, bitmap;
> > >                const __le64 *v;
> > >                int i, j;
> > >
> > >                num_rx =3D VIRTNET_RQ_STATS_LEN + ctx->desc_num[VIRTNE=
T_Q_TYPE_RX];
> > >                num_tx =3D VIRTNET_SQ_STATS_LEN + ctx->desc_num[VIRTNE=
T_Q_TYPE_TX];
> > >                num_cq =3D ctx->desc_num[VIRTNET_Q_TYPE_CQ];
> > >
> > >                queue_type =3D vq_type(vi, qid);
> > >                bitmap =3D ctx->bitmap[queue_type];
> > >                offset =3D 0;
> > >
> > >                if (queue_type =3D=3D VIRTNET_Q_TYPE_TX) {
> > >                        offset =3D num_cq + num_rx * vi->curr_queue_pa=
irs + num_tx * (qid / 2);
> > >                        offset +=3D VIRTNET_SQ_STATS_LEN;
> > >                } else if (queue_type =3D=3D VIRTNET_Q_TYPE_RX) {
> > >                        offset =3D num_cq + num_rx * (qid / 2) + VIRTN=
ET_RQ_STATS_LEN;
> > >                }
> > >
> > >                for (i =3D 0; i < ARRAY_SIZE(virtio_net_stats_map); ++=
i) {
> > >                        m =3D &virtio_net_stats_map[i];
> > >
> > > ->                     if (m->stat_type & bitmap)
> > >                                offset +=3D m->num;
> > >
> > > ->                     if (type !=3D m->reply_type)
> > >                                continue;
> > >
> > >                        for (j =3D 0; j < m->num; ++j) {
> > >                                v =3D (const __le64 *)(base + m->desc[=
j].offset);
> > >                                ctx->data[offset + j] =3D le64_to_cpu(=
*v);
> > >                        }
> > >
> > >                        break;
> > >                }
> > >         }
> > >
> > > Thanks.
> >
> > Btw, just a reminder, there are other comments for this patch.
> >
> > Thanks
> >
>


