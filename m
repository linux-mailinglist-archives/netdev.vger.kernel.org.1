Return-Path: <netdev+bounces-128000-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FEC1977748
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 05:21:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0C391C242F9
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 03:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50DD913B280;
	Fri, 13 Sep 2024 03:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bvsaJy8D"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F76C7E782
	for <netdev@vger.kernel.org>; Fri, 13 Sep 2024 03:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726197701; cv=none; b=jRuUqGh5hAtPaLsjWJXewRDnkWoGtm7K/1t+DVwSCrgPD6kMUQ06GQMnFHx/9fg2SjVlHC8ZXrENZyrDWORjW/xxTtvqV8TZaPvPmOf1vpzp0u8UiBO5jRfeDIlkupETBUBKMQ4JebGGf3XJLGFE3hwv1Lt4q2ooX9rKHRL0/Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726197701; c=relaxed/simple;
	bh=Uf8pz8GZZOrJfqVyY2w8iaFekkV4JJlgwu8AIVoKy9M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OmuuYJw7F2OZR89A2sSItbZ8TMbrXXTqqNp/oTMQFglhYWzrMpBrr2RyBsDtmEDoxa2NGoVhh6Z8n9av+jrwXjVtX1NuLbL/LFzmCV12KDZZLXSLW3suv7CFYSOf5ZbgYXCTUJ4yDHmlywIC8fhn4nP3/9sZSKUMmstUR/ZSiSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bvsaJy8D; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726197698;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SBmazPo7oDZzY5LkfEPsqnAnQz8NHw4FFkvvHEVzrBM=;
	b=bvsaJy8DHikGoWm3qDy44eGX2hx/kyPzIWaFoN7jov5M+f7eFVA7pkPSrbBw8jBQAh8ifC
	ATRKRLHqSV4TUii1bNIddPLR5eqQFDTbXiNmpohTRuJzKVNngSZD3NKYvMLPGw59ZHv75T
	zxGqQkv451xJXHEbP8XMMqQBEaaef+o=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-197-PJYKfkumPFKhje8u0h7GCw-1; Thu, 12 Sep 2024 23:21:36 -0400
X-MC-Unique: PJYKfkumPFKhje8u0h7GCw-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2d86e9da90cso1627473a91.2
        for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 20:21:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726197695; x=1726802495;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SBmazPo7oDZzY5LkfEPsqnAnQz8NHw4FFkvvHEVzrBM=;
        b=vQEdsHSktcQawEVGL7hvxZAgrOnGdDF6UH9wQMnlr7GYjdq4WGEdyndR9EDjr92dBt
         0BE8NNvSNmXHDrClcql2LmJ1wOIJYkpmP3qaq9G9fduqFjzDVpT/Z4xeRkHK1dO6vzEU
         qes8mWOynq+lCZC/hNd0JOIWvbCB4sqfMnVettL75dqZujIlq0qRCeepwqIa7mZMYCN9
         BPwi3Zuk5EfXE4ht4lXQpuvy0oiDCJJeYra319ZuzNQx0iI+sbO+QgCMQ/o/Qv+GwyjI
         vFka8IeH3A5b9ZbzR/CSNTWXT5KRKQzV/Rzb2YVhq0mjBQ6QezgNu7UbAndsg7hl3VV2
         Vo4A==
X-Gm-Message-State: AOJu0Ywx5d56uJSMH5DR43aPuhE/DxbyXrTQMefQSEml5yGe9fWW/k00
	Zcgv5MJdpRTFRyy3T1dz5w0rgBTxLU2A/XnPxl26My2oh2+shsDLnVLNf7s3KfEY5cx6IuwTqJX
	BD7l/quGFNIu7+V7bclERm6q8j+D6P8MCTJWtx0ro9rYtEE+v/PoRSeCbGGH+TIbEf9RNnXRQo2
	htJ0oOL//yDPaFV/z3+NzJBOXTHoEc
X-Received: by 2002:a17:90a:c915:b0:2d3:d063:bdb6 with SMTP id 98e67ed59e1d1-2db9ffa1624mr5959719a91.4.1726197695525;
        Thu, 12 Sep 2024 20:21:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUzkOSDTB5L8PdzNmSnOyQ4G7HAHJ9LPtYXF+5ar6cK9jEe4+yKgNBgFe5Lt1usc2izXTKaE7mLIr1bBjXIak=
X-Received: by 2002:a17:90a:c915:b0:2d3:d063:bdb6 with SMTP id
 98e67ed59e1d1-2db9ffa1624mr5959678a91.4.1726197694804; Thu, 12 Sep 2024
 20:21:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240820073330.9161-1-xuanzhuo@linux.alibaba.com>
 <20240820073330.9161-11-xuanzhuo@linux.alibaba.com> <CACGkMEv5DZgm1B5CXeHnP4ZPmZzQv7zWHT5=D1oH-h_bin2p7w@mail.gmail.com>
 <1726130924.279801-7-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1726130924.279801-7-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 13 Sep 2024 11:21:21 +0800
Message-ID: <CACGkMEtgWw9J4Y8fQCWY4ED_=Bdi6ArmOMMA2OjyGbOOu90OTg@mail.gmail.com>
Subject: Re: [PATCH net-next 10/13] virtio_net: xsk: tx: support xmit xsk buffer
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

On Thu, Sep 12, 2024 at 4:50=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> On Wed, 11 Sep 2024 12:31:32 +0800, Jason Wang <jasowang@redhat.com> wrot=
e:
> > On Tue, Aug 20, 2024 at 3:33=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.aliba=
ba.com> wrote:
> > >
> > > The driver's tx napi is very important for XSK. It is responsible for
> > > obtaining data from the XSK queue and sending it out.
> > >
> > > At the beginning, we need to trigger tx napi.
> > >
> > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > ---
> > >  drivers/net/virtio_net.c | 127 +++++++++++++++++++++++++++++++++++++=
+-
> > >  1 file changed, 125 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index 221681926d23..3743694d3c3b 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -516,10 +516,13 @@ enum virtnet_xmit_type {
> > >         VIRTNET_XMIT_TYPE_SKB,
> > >         VIRTNET_XMIT_TYPE_ORPHAN,
> > >         VIRTNET_XMIT_TYPE_XDP,
> > > +       VIRTNET_XMIT_TYPE_XSK,
> > >  };
> > >
> > >  #define VIRTNET_XMIT_TYPE_MASK (VIRTNET_XMIT_TYPE_SKB | VIRTNET_XMIT=
_TYPE_ORPHAN \
> > > -                               | VIRTNET_XMIT_TYPE_XDP)
> > > +                               | VIRTNET_XMIT_TYPE_XDP | VIRTNET_XMI=
T_TYPE_XSK)
> > > +
> > > +#define VIRTIO_XSK_FLAG_OFFSET 4
> > >
> > >  static enum virtnet_xmit_type virtnet_xmit_ptr_strip(void **ptr)
> > >  {
> > > @@ -543,6 +546,11 @@ static int virtnet_add_outbuf(struct send_queue =
*sq, int num, void *data,
> > >                                     GFP_ATOMIC);
> > >  }
> > >
> > > +static u32 virtnet_ptr_to_xsk(void *ptr)
> > > +{
> > > +       return ((unsigned long)ptr) >> VIRTIO_XSK_FLAG_OFFSET;
> > > +}
> > > +
> >
> > This needs a better name, otherwise readers might be confused.
> >
> > E.g something like virtnet_ptr_to_xsk_buff_len()?
> >
> > >  static void sg_fill_dma(struct scatterlist *sg, dma_addr_t addr, u32=
 len)
> > >  {
> > >         sg_assign_page(sg, NULL);
> > > @@ -584,6 +592,10 @@ static void __free_old_xmit(struct send_queue *s=
q, struct netdev_queue *txq,
> > >                         stats->bytes +=3D xdp_get_frame_len(frame);
> > >                         xdp_return_frame(frame);
> > >                         break;
> > > +
> > > +               case VIRTNET_XMIT_TYPE_XSK:
> > > +                       stats->bytes +=3D virtnet_ptr_to_xsk(ptr);
> > > +                       break;
> >
> > Do we miss xsk_tx_completed() here?
> >
> > >                 }
> > >         }
> > >         netdev_tx_completed_queue(txq, stats->napi_packets, stats->na=
pi_bytes);
> > > @@ -1393,6 +1405,97 @@ static int virtnet_xsk_wakeup(struct net_devic=
e *dev, u32 qid, u32 flag)
> > >         return 0;
> > >  }
> > >
> > > +static void *virtnet_xsk_to_ptr(u32 len)
> > > +{
> > > +       unsigned long p;
> > > +
> > > +       p =3D len << VIRTIO_XSK_FLAG_OFFSET;
> > > +
> > > +       return virtnet_xmit_ptr_mix((void *)p, VIRTNET_XMIT_TYPE_XSK)=
;
> > > +}
> > > +
> > > +static int virtnet_xsk_xmit_one(struct send_queue *sq,
> > > +                               struct xsk_buff_pool *pool,
> > > +                               struct xdp_desc *desc)
> > > +{
> > > +       struct virtnet_info *vi;
> > > +       dma_addr_t addr;
> > > +
> > > +       vi =3D sq->vq->vdev->priv;
> > > +
> > > +       addr =3D xsk_buff_raw_get_dma(pool, desc->addr);
> > > +       xsk_buff_raw_dma_sync_for_device(pool, addr, desc->len);
> > > +
> > > +       sg_init_table(sq->sg, 2);
> > > +
> > > +       sg_fill_dma(sq->sg, sq->xsk_hdr_dma_addr, vi->hdr_len);
> > > +       sg_fill_dma(sq->sg + 1, addr, desc->len);
> > > +
> > > +       return virtqueue_add_outbuf(sq->vq, sq->sg, 2,
> > > +                                   virtnet_xsk_to_ptr(desc->len), GF=
P_ATOMIC);
> > > +}
> > > +
> > > +static int virtnet_xsk_xmit_batch(struct send_queue *sq,
> > > +                                 struct xsk_buff_pool *pool,
> > > +                                 unsigned int budget,
> > > +                                 u64 *kicks)
> > > +{
> > > +       struct xdp_desc *descs =3D pool->tx_descs;
> > > +       bool kick =3D false;
> > > +       u32 nb_pkts, i;
> > > +       int err;
> > > +
> > > +       budget =3D min_t(u32, budget, sq->vq->num_free);
> > > +
> > > +       nb_pkts =3D xsk_tx_peek_release_desc_batch(pool, budget);
> > > +       if (!nb_pkts)
> > > +               return 0;
> > > +
> > > +       for (i =3D 0; i < nb_pkts; i++) {
> > > +               err =3D virtnet_xsk_xmit_one(sq, pool, &descs[i]);
> > > +               if (unlikely(err)) {
> > > +                       xsk_tx_completed(sq->xsk_pool, nb_pkts - i);
> >
> > Should we kick in this condition?
> >
> > > +                       break;
> > > +               }
> > > +
> > > +               kick =3D true;
> > > +       }
> > > +
> > > +       if (kick && virtqueue_kick_prepare(sq->vq) && virtqueue_notif=
y(sq->vq))
> >
> > Can we simply use virtqueue_kick() here?
> >
> > > +               (*kicks)++;
> > > +
> > > +       return i;
> > > +}
> > > +
> > > +static bool virtnet_xsk_xmit(struct send_queue *sq, struct xsk_buff_=
pool *pool,
> > > +                            int budget)
> > > +{
> > > +       struct virtnet_info *vi =3D sq->vq->vdev->priv;
> > > +       struct virtnet_sq_free_stats stats =3D {};
> > > +       struct net_device *dev =3D vi->dev;
> > > +       u64 kicks =3D 0;
> > > +       int sent;
> > > +
> > > +       __free_old_xmit(sq, netdev_get_tx_queue(dev, sq - vi->sq), tr=
ue, &stats);
> >
> > I haven't checked in depth, but I wonder if we have some side effects
> > when using non NAPI tx mode:
> >
> >         if (napi->weight)
> >                 virtqueue_napi_schedule(napi, vq);
> >         else
> >                 /* We were probably waiting for more output buffers. */
> >                 netif_wake_subqueue(vi->dev, vq2txq(vq));
> >
> > Does this mean xsk will suffer the same issue like when there's no xsk
> > xmit request, we could end up with no way to reclaim xmitted xsk
> > buffers? (Or should we disallow AF_XDP to be used for non TX-NAPI
> > mode?)
>
> Disallow AF_XDP to be used for non TX-NAPI mode.
>
> The last patch #9 does this.
>
> #9 [PATCH net-next 09/13] virtio_net: xsk: prevent disable tx napi

Great, for some reason I miss that.

Thanks

>
> Thanks.
> >
> > > +
> > > +       sent =3D virtnet_xsk_xmit_batch(sq, pool, budget, &kicks);
> > > +
> > > +       if (!is_xdp_raw_buffer_queue(vi, sq - vi->sq))
> > > +               check_sq_full_and_disable(vi, vi->dev, sq);
> > > +
> > > +       u64_stats_update_begin(&sq->stats.syncp);
> > > +       u64_stats_add(&sq->stats.packets, stats.packets);
> > > +       u64_stats_add(&sq->stats.bytes,   stats.bytes);
> > > +       u64_stats_add(&sq->stats.kicks,   kicks);
> > > +       u64_stats_add(&sq->stats.xdp_tx,  sent);
> > > +       u64_stats_update_end(&sq->stats.syncp);
> > > +
> > > +       if (xsk_uses_need_wakeup(pool))
> > > +               xsk_set_tx_need_wakeup(pool);
> > > +
> > > +       return sent =3D=3D budget;
> > > +}
> > > +
> > >  static int __virtnet_xdp_xmit_one(struct virtnet_info *vi,
> > >                                    struct send_queue *sq,
> > >                                    struct xdp_frame *xdpf)
> > > @@ -2949,6 +3052,7 @@ static int virtnet_poll_tx(struct napi_struct *=
napi, int budget)
> > >         struct virtnet_info *vi =3D sq->vq->vdev->priv;
> > >         unsigned int index =3D vq2txq(sq->vq);
> > >         struct netdev_queue *txq;
> > > +       bool xsk_busy =3D false;
> > >         int opaque;
> > >         bool done;
> > >
> > > @@ -2961,7 +3065,11 @@ static int virtnet_poll_tx(struct napi_struct =
*napi, int budget)
> > >         txq =3D netdev_get_tx_queue(vi->dev, index);
> > >         __netif_tx_lock(txq, raw_smp_processor_id());
> > >         virtqueue_disable_cb(sq->vq);
> > > -       free_old_xmit(sq, txq, !!budget);
> > > +
> > > +       if (sq->xsk_pool)
> > > +               xsk_busy =3D virtnet_xsk_xmit(sq, sq->xsk_pool, budge=
t);
> > > +       else
> > > +               free_old_xmit(sq, txq, !!budget);
> > >
> > >         if (sq->vq->num_free >=3D 2 + MAX_SKB_FRAGS) {
> > >                 if (netif_tx_queue_stopped(txq)) {
> > > @@ -2972,6 +3080,11 @@ static int virtnet_poll_tx(struct napi_struct =
*napi, int budget)
> > >                 netif_tx_wake_queue(txq);
> > >         }
> > >
> > > +       if (xsk_busy) {
> > > +               __netif_tx_unlock(txq);
> > > +               return budget;
> > > +       }
> > > +
> > >         opaque =3D virtqueue_enable_cb_prepare(sq->vq);
> > >
> > >         done =3D napi_complete_done(napi, 0);
> > > @@ -5974,6 +6087,12 @@ static void free_receive_page_frags(struct vir=
tnet_info *vi)
> > >
> > >  static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *b=
uf)
> > >  {
> > > +       struct virtnet_info *vi =3D vq->vdev->priv;
> > > +       struct send_queue *sq;
> > > +       int i =3D vq2rxq(vq);
> > > +
> > > +       sq =3D &vi->sq[i];
> > > +
> > >         switch (virtnet_xmit_ptr_strip(&buf)) {
> > >         case VIRTNET_XMIT_TYPE_SKB:
> > >         case VIRTNET_XMIT_TYPE_ORPHAN:
> > > @@ -5983,6 +6102,10 @@ static void virtnet_sq_free_unused_buf(struct =
virtqueue *vq, void *buf)
> > >         case VIRTNET_XMIT_TYPE_XDP:
> > >                 xdp_return_frame(buf);
> > >                 break;
> > > +
> > > +       case VIRTNET_XMIT_TYPE_XSK:
> > > +               xsk_tx_completed(sq->xsk_pool, 1);
> > > +               break;
> > >         }
> > >  }
> > >
> > > --
> > > 2.32.0.3.g01195cf9f
> > >
> >
> > Thanks
> >
>


