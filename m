Return-Path: <netdev+bounces-107523-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF08491B505
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 04:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D087B1C21A51
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 02:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B9F679D1;
	Fri, 28 Jun 2024 02:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ygybw7wv"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508711CD11
	for <netdev@vger.kernel.org>; Fri, 28 Jun 2024 02:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719541199; cv=none; b=sJdJVNcs4IkXGmCeCLvpiLa61pKtE9SRWa++ucmRQgX7e5stoF7GRoqB9OCz7zROQ+lT3kYvpfDxbKJomp5QGOsQicam0UeK7cZJ3vjHSRUFstZxpgr52epFPrOTPxW01v/cy9GaBhWPGl17J4QgBQnO2xqmwL3CHWXl/b/XxB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719541199; c=relaxed/simple;
	bh=MgGwKaANsk5mfwhfaaw/sdKfdp0CGdGGAr9DJbfsLmk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NXMtw8LMOyCHiRUxuDpp95wl0/685ci+B+6x6WsbZZv1t0RoYqrmRyQQ7Ey73KvXLQ3nX2diWNFEjIgSa4f8A34ttboJUXk97+9S1+n6AyyW/+3sprQ8xD+YMiN6/36f8AQziFwNqLii4ntqrhZxwilta1D3d4BBzXszZxxqmNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ygybw7wv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719541196;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cPS4D9/vUoPFj3acCd5UWkIGnlENK5VcJTZYSj+fqAk=;
	b=Ygybw7wvuORyUBwgmQaKOONiEdLOFWCnDdcXAhxL+nYYDm8d0CUYHU8AxggRDPXLelsYXK
	e8xoCovEfAHOX4ZQouDni6Tri90zNrwcczfXJOXn1qtCg6UgHCx3KemfFOiqOuDCvqy1Zq
	8K2BDjX57eHKv+kztOYp6hBJWRfXGGo=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-l96oVRS2ON-PEQumSl5UXQ-1; Thu, 27 Jun 2024 22:19:54 -0400
X-MC-Unique: l96oVRS2ON-PEQumSl5UXQ-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2c7a8dc68aeso213247a91.0
        for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 19:19:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719541194; x=1720145994;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cPS4D9/vUoPFj3acCd5UWkIGnlENK5VcJTZYSj+fqAk=;
        b=TWjD2FL8FrwREbd0uq47JApDaGXOKBxvpJxKTUg+CgaPG2ylvC0PHpP8ejX1jnr9Yk
         NFSM13PaR5jSEbziAhxPsoKxG3TjOOgz2aH0FOypw9PbSPQVONQG4BEFD/b0wdbxsDaI
         frkecjioP2Wbh3LwkASPE6tYlZ5JJZmALzP01tOVYqqTePaYjAPyctDR4CsiJgk0GtK9
         xxO2SHcYTqoQFL8UoGssc/q8yBMUjkIKFRJSgE1SeynQEFbH4MbyAM6bD2HkTaYD17n1
         Y4XjHXt9FokDAjkMOOxk+Y2+PCC1puAxXw4ZGdnlgOAE1VAK2BMxNPwTLk2mfZtjEd9H
         IVAQ==
X-Gm-Message-State: AOJu0YwpBT3keY3p6PnSGiIrOzTTcCZVHfH4Z2u5oTojbnNFszXre4Ja
	P7o3mWaSSrGVBPx5h+EaAvt2RieOHXIgz2v+n3929RtvkbYRKSZ6uJVicTz+rLkwtU0kr0ChqYh
	91DF0N4R+3dFDQZ5qaInC1Bwpu59F6E+3byTEV9gLJBZr9WqeuAobeV+H+LellvSdtkWArVMe1L
	oHvR7+hmtCe9kbBHyw1i3XvICUZT2G
X-Received: by 2002:a17:90b:38c3:b0:2c2:f2d6:60d4 with SMTP id 98e67ed59e1d1-2c861298618mr13082283a91.8.1719541193860;
        Thu, 27 Jun 2024 19:19:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHURCOmJPf/rKVFBRXpZ5dWN1xCkUozWlvj898GlgbcTMenZ3TeZInaAei9KprZMj00HqGPxNLVD8AQGFxQBfo=
X-Received: by 2002:a17:90b:38c3:b0:2c2:f2d6:60d4 with SMTP id
 98e67ed59e1d1-2c861298618mr13082262a91.8.1719541193235; Thu, 27 Jun 2024
 19:19:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240618075643.24867-1-xuanzhuo@linux.alibaba.com> <20240618075643.24867-9-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240618075643.24867-9-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 28 Jun 2024 10:19:41 +0800
Message-ID: <CACGkMEuPB=We-pnj8QH9Oiv4F=XHTcrRsHVVmOnUn9H7+Nrihw@mail.gmail.com>
Subject: Re: [PATCH net-next v6 08/10] virtio_net: xsk: rx: support recv small mode
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, virtualization@lists.linux.dev, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2024 at 3:57=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> In the process:
> 1. We may need to copy data to create skb for XDP_PASS.
> 2. We may need to call xsk_buff_free() to release the buffer.
> 3. The handle for xdp_buff is difference from the buffer.
>
> If we pushed this logic into existing receive handle(merge and small),
> we would have to maintain code scattered inside merge and small (and big)=
.
> So I think it is a good choice for us to put the xsk code into an
> independent function.

I think it's better to try to reuse the existing functions.

More below:

>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/net/virtio_net.c | 135 ++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 133 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 2ac5668a94ce..06608d696e2e 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -500,6 +500,10 @@ struct virtio_net_common_hdr {
>  };
>
>  static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf);
> +static int virtnet_xdp_handler(struct bpf_prog *xdp_prog, struct xdp_buf=
f *xdp,
> +                              struct net_device *dev,
> +                              unsigned int *xdp_xmit,
> +                              struct virtnet_rq_stats *stats);
>
>  static bool is_xdp_frame(void *ptr)
>  {
> @@ -1040,6 +1044,120 @@ static void sg_fill_dma(struct scatterlist *sg, d=
ma_addr_t addr, u32 len)
>         sg->length =3D len;
>  }
>
> +static struct xdp_buff *buf_to_xdp(struct virtnet_info *vi,
> +                                  struct receive_queue *rq, void *buf, u=
32 len)
> +{
> +       struct xdp_buff *xdp;
> +       u32 bufsize;
> +
> +       xdp =3D (struct xdp_buff *)buf;
> +
> +       bufsize =3D xsk_pool_get_rx_frame_size(rq->xsk.pool) + vi->hdr_le=
n;
> +
> +       if (unlikely(len > bufsize)) {
> +               pr_debug("%s: rx error: len %u exceeds truesize %u\n",
> +                        vi->dev->name, len, bufsize);
> +               DEV_STATS_INC(vi->dev, rx_length_errors);
> +               xsk_buff_free(xdp);
> +               return NULL;
> +       }
> +
> +       xsk_buff_set_size(xdp, len);
> +       xsk_buff_dma_sync_for_cpu(xdp);
> +
> +       return xdp;
> +}
> +
> +static struct sk_buff *xdp_construct_skb(struct receive_queue *rq,
> +                                        struct xdp_buff *xdp)
> +{

So we have a similar caller which is receive_small_build_skb(). Any
chance to reuse that?

> +       unsigned int metasize =3D xdp->data - xdp->data_meta;
> +       struct sk_buff *skb;
> +       unsigned int size;
> +
> +       size =3D xdp->data_end - xdp->data_hard_start;
> +       skb =3D napi_alloc_skb(&rq->napi, size);
> +       if (unlikely(!skb)) {
> +               xsk_buff_free(xdp);
> +               return NULL;
> +       }
> +
> +       skb_reserve(skb, xdp->data_meta - xdp->data_hard_start);
> +
> +       size =3D xdp->data_end - xdp->data_meta;
> +       memcpy(__skb_put(skb, size), xdp->data_meta, size);
> +
> +       if (metasize) {
> +               __skb_pull(skb, metasize);
> +               skb_metadata_set(skb, metasize);
> +       }
> +
> +       xsk_buff_free(xdp);
> +
> +       return skb;
> +}
> +
> +static struct sk_buff *virtnet_receive_xsk_small(struct net_device *dev,=
 struct virtnet_info *vi,
> +                                                struct receive_queue *rq=
, struct xdp_buff *xdp,
> +                                                unsigned int *xdp_xmit,
> +                                                struct virtnet_rq_stats =
*stats)
> +{
> +       struct bpf_prog *prog;
> +       u32 ret;
> +
> +       ret =3D XDP_PASS;
> +       rcu_read_lock();
> +       prog =3D rcu_dereference(rq->xdp_prog);
> +       if (prog)
> +               ret =3D virtnet_xdp_handler(prog, xdp, dev, xdp_xmit, sta=
ts);
> +       rcu_read_unlock();
> +
> +       switch (ret) {
> +       case XDP_PASS:
> +               return xdp_construct_skb(rq, xdp);
> +
> +       case XDP_TX:
> +       case XDP_REDIRECT:
> +               return NULL;
> +
> +       default:
> +               /* drop packet */
> +               xsk_buff_free(xdp);
> +               u64_stats_inc(&stats->drops);
> +               return NULL;
> +       }
> +}
> +
> +static struct sk_buff *virtnet_receive_xsk_buf(struct virtnet_info *vi, =
struct receive_queue *rq,
> +                                              void *buf, u32 len,
> +                                              unsigned int *xdp_xmit,
> +                                              struct virtnet_rq_stats *s=
tats)
> +{
> +       struct net_device *dev =3D vi->dev;
> +       struct sk_buff *skb =3D NULL;
> +       struct xdp_buff *xdp;
> +
> +       len -=3D vi->hdr_len;
> +
> +       u64_stats_add(&stats->bytes, len);
> +
> +       xdp =3D buf_to_xdp(vi, rq, buf, len);
> +       if (!xdp)
> +               return NULL;
> +
> +       if (unlikely(len < ETH_HLEN)) {
> +               pr_debug("%s: short packet %i\n", dev->name, len);
> +               DEV_STATS_INC(dev, rx_length_errors);
> +               xsk_buff_free(xdp);
> +               return NULL;
> +       }
> +
> +       if (!vi->mergeable_rx_bufs)
> +               skb =3D virtnet_receive_xsk_small(dev, vi, rq, xdp, xdp_x=
mit, stats);
> +
> +       return skb;
> +}
> +
>  static int virtnet_add_recvbuf_xsk(struct virtnet_info *vi, struct recei=
ve_queue *rq,
>                                    struct xsk_buff_pool *pool, gfp_t gfp)
>  {
> @@ -2363,9 +2481,22 @@ static int virtnet_receive(struct receive_queue *r=
q, int budget,
>         void *buf;
>         int i;
>
> -       if (!vi->big_packets || vi->mergeable_rx_bufs) {
> -               void *ctx;
> +       if (rq->xsk.pool) {
> +               struct sk_buff *skb;
> +
> +               while (packets < budget) {
> +                       buf =3D virtqueue_get_buf(rq->vq, &len);
> +                       if (!buf)
> +                               break;
>
> +                       skb =3D virtnet_receive_xsk_buf(vi, rq, buf, len,=
 xdp_xmit, &stats);
> +                       if (skb)
> +                               virtnet_receive_done(vi, rq, skb);
> +
> +                       packets++;
> +               }

If reusing turns out to be hard, I'd rather add new paths in receive_small(=
).

> +       } else if (!vi->big_packets || vi->mergeable_rx_bufs) {
> +               void *ctx;
>                 while (packets < budget &&
>                        (buf =3D virtnet_rq_get_buf(rq, &len, &ctx))) {
>                         receive_buf(vi, rq, buf, len, ctx, xdp_xmit, &sta=
ts);
> --
> 2.32.0.3.g01195cf9f
>

Thanks


