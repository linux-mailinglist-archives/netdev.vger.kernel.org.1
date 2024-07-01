Return-Path: <netdev+bounces-107991-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A041F91D687
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 05:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20A631F2173C
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 03:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF4AEF9CF;
	Mon,  1 Jul 2024 03:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cPyVlw/e"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3368EAD2
	for <netdev@vger.kernel.org>; Mon,  1 Jul 2024 03:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719804051; cv=none; b=R8muOMc4upUr1tybQr2YkeeQWn3obA5XksCepuOkrNy5fV0U8vVzsGDApgd4IDsn7agzz2qT6nslOHyFBIvOBbaIWWQwF7fG6ynp4C7tvniZR/SiU3EoqGU5jXnosGSKXZkPO35BD6YmZmtvANMbNiS+scQ0YbKJ2Gg/uHVa0HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719804051; c=relaxed/simple;
	bh=E4Mf6iVEA8VfuL7Vb1xUQ1Eh0HjyaNt8nfu5xLHIIhU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hPXlbsvASp24oSp9ptVXubEbTACgXT2LacYdbd4w4E9ZydbZwJZb6aQp3sXwPQfV2iTFCdvP8CKRSeyLI2vsFOk9wneD15rkBrYvN4fWqJWDBzhXSbYQ5KeV9obER3vbEH829FZz7XMX8AX72csVOIhKKWLYt9QM3x3X29Rql8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cPyVlw/e; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719804048;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6ZXTY1wJcGvF13UpHvfL9hMZFIOxvf2RhVoNAZG0tZk=;
	b=cPyVlw/e3hFNKh8xBTiAI8wZbHmVnM7TEOE+uykUTfShPZciEdzWwc8c0+8oxBFz8NE5qI
	FVM7RQgQpQQ17WuYCpX+Qzy3huK2XoeJjcDdyBi6F5hgNzchKhc51QIsLVnhknvypQLPY8
	6Kw7j01vBmcrturBUoz/TtIsAXeKLOk=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-546-55osJcOcNvGjKA1tKxhc5w-1; Sun, 30 Jun 2024 23:20:46 -0400
X-MC-Unique: 55osJcOcNvGjKA1tKxhc5w-1
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-5c44c86c4a8so598869eaf.0
        for <netdev@vger.kernel.org>; Sun, 30 Jun 2024 20:20:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719804045; x=1720408845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6ZXTY1wJcGvF13UpHvfL9hMZFIOxvf2RhVoNAZG0tZk=;
        b=xKeC04b/suTjlBoVj0Jb5Cy2IUkvoAWqywgyPMu28dW1dZaeJS0RZSVROfKni1aCh4
         HMWCDGRxoAbMXLCBf2zrVtAQunD2v47mqR933gansEj5x0KRNbFATOBjpei5PM3PhDQ6
         7bz0h+ebLm3Fi4r1DPF8P8q9NL5tgFqW4A+UnHbH6vM+R52eSYcvhrLRupGgOQCN4r5a
         mWolP6QSN/67WjjINCU9loSwTaZ3RjHuV7z9AkKA5e4n+TOi8qk5I5usFACA+sot5pCB
         vVh9fLGLJjCVUaoA4az/+Jy107uzpEeFZmsVBhHelveUAd9i6fLlTCjJ+3Exi8CpBCpH
         XCXQ==
X-Gm-Message-State: AOJu0YxyU3fsDavK4GHi4Zaf93cH4XbTGAQyAS6zopsfEkduSifCpBbh
	BRtRNLMDL3FMwkrgIBdzz3D3AFThI+MT4BMP9KfmzL/p0lhHskMPhi7QUaFw162t8Cms6Kq19jp
	8eLMtri0kR9qhb1FEjB/iPrL0oPdk/WMZ7dVZgMm7X/yq8VaT1ORReQlitt+4WunqANaY8HQjIr
	LKbcJZpRR9a3Oxh+dXX6UjIDPv6pS8
X-Received: by 2002:a05:6358:2c93:b0:1a3:69b:9bba with SMTP id e5c5f4694b2df-1a6acec70e1mr430488655d.20.1719804045192;
        Sun, 30 Jun 2024 20:20:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2K0Wr1DmUzswAYlt6iQmGgUqjMA1uKesP4JQbqrBd/y7hvoS2V3r4I1L7Fc4TQz6vTBszgPCn6bpPuw6ODdM=
X-Received: by 2002:a05:6358:2c93:b0:1a3:69b:9bba with SMTP id
 e5c5f4694b2df-1a6acec70e1mr430486355d.20.1719804044761; Sun, 30 Jun 2024
 20:20:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240618075643.24867-1-xuanzhuo@linux.alibaba.com>
 <20240618075643.24867-9-xuanzhuo@linux.alibaba.com> <CACGkMEuPB=We-pnj8QH9Oiv4F=XHTcrRsHVVmOnUn9H7+Nrihw@mail.gmail.com>
 <1719553452.932589-3-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1719553452.932589-3-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 1 Jul 2024 11:20:33 +0800
Message-ID: <CACGkMEv_MOMHz1U48aVPXSj9gVJqA_h-UDt+oNgVgCQww4Jbdg@mail.gmail.com>
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

On Fri, Jun 28, 2024 at 1:48=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> On Fri, 28 Jun 2024 10:19:41 +0800, Jason Wang <jasowang@redhat.com> wrot=
e:
> > On Tue, Jun 18, 2024 at 3:57=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.aliba=
ba.com> wrote:
> > >
> > > In the process:
> > > 1. We may need to copy data to create skb for XDP_PASS.
> > > 2. We may need to call xsk_buff_free() to release the buffer.
> > > 3. The handle for xdp_buff is difference from the buffer.
> > >
> > > If we pushed this logic into existing receive handle(merge and small)=
,
> > > we would have to maintain code scattered inside merge and small (and =
big).
> > > So I think it is a good choice for us to put the xsk code into an
> > > independent function.
> >
> > I think it's better to try to reuse the existing functions.
> >
> > More below:
> >
> > >
> > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > ---
> > >  drivers/net/virtio_net.c | 135 +++++++++++++++++++++++++++++++++++++=
+-
> > >  1 file changed, 133 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index 2ac5668a94ce..06608d696e2e 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -500,6 +500,10 @@ struct virtio_net_common_hdr {
> > >  };
> > >
> > >  static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *b=
uf);
> > > +static int virtnet_xdp_handler(struct bpf_prog *xdp_prog, struct xdp=
_buff *xdp,
> > > +                              struct net_device *dev,
> > > +                              unsigned int *xdp_xmit,
> > > +                              struct virtnet_rq_stats *stats);
> > >
> > >  static bool is_xdp_frame(void *ptr)
> > >  {
> > > @@ -1040,6 +1044,120 @@ static void sg_fill_dma(struct scatterlist *s=
g, dma_addr_t addr, u32 len)
> > >         sg->length =3D len;
> > >  }
> > >
> > > +static struct xdp_buff *buf_to_xdp(struct virtnet_info *vi,
> > > +                                  struct receive_queue *rq, void *bu=
f, u32 len)
> > > +{
> > > +       struct xdp_buff *xdp;
> > > +       u32 bufsize;
> > > +
> > > +       xdp =3D (struct xdp_buff *)buf;
> > > +
> > > +       bufsize =3D xsk_pool_get_rx_frame_size(rq->xsk.pool) + vi->hd=
r_len;
> > > +
> > > +       if (unlikely(len > bufsize)) {
> > > +               pr_debug("%s: rx error: len %u exceeds truesize %u\n"=
,
> > > +                        vi->dev->name, len, bufsize);
> > > +               DEV_STATS_INC(vi->dev, rx_length_errors);
> > > +               xsk_buff_free(xdp);
> > > +               return NULL;
> > > +       }
> > > +
> > > +       xsk_buff_set_size(xdp, len);
> > > +       xsk_buff_dma_sync_for_cpu(xdp);
> > > +
> > > +       return xdp;
> > > +}
> > > +
> > > +static struct sk_buff *xdp_construct_skb(struct receive_queue *rq,
> > > +                                        struct xdp_buff *xdp)
> > > +{
> >
> > So we have a similar caller which is receive_small_build_skb(). Any
> > chance to reuse that?
>
> receive_small_build_skb works with build_skb.

RIght.

>
> Here we need to copy the packet from the xsk buffer to the skb buffer.
> So I do not think we can reuse it.
>

Let's rename this to xsk_construct_skb() ?

>
> >
> > > +       unsigned int metasize =3D xdp->data - xdp->data_meta;
> > > +       struct sk_buff *skb;
> > > +       unsigned int size;
> > > +
> > > +       size =3D xdp->data_end - xdp->data_hard_start;
> > > +       skb =3D napi_alloc_skb(&rq->napi, size);
> > > +       if (unlikely(!skb)) {
> > > +               xsk_buff_free(xdp);
> > > +               return NULL;
> > > +       }
> > > +
> > > +       skb_reserve(skb, xdp->data_meta - xdp->data_hard_start);
> > > +
> > > +       size =3D xdp->data_end - xdp->data_meta;
> > > +       memcpy(__skb_put(skb, size), xdp->data_meta, size);
> > > +
> > > +       if (metasize) {
> > > +               __skb_pull(skb, metasize);
> > > +               skb_metadata_set(skb, metasize);
> > > +       }
> > > +
> > > +       xsk_buff_free(xdp);
> > > +
> > > +       return skb;
> > > +}
> > > +
> > > +static struct sk_buff *virtnet_receive_xsk_small(struct net_device *=
dev, struct virtnet_info *vi,
> > > +                                                struct receive_queue=
 *rq, struct xdp_buff *xdp,
> > > +                                                unsigned int *xdp_xm=
it,
> > > +                                                struct virtnet_rq_st=
ats *stats)
> > > +{
> > > +       struct bpf_prog *prog;
> > > +       u32 ret;
> > > +
> > > +       ret =3D XDP_PASS;
> > > +       rcu_read_lock();
> > > +       prog =3D rcu_dereference(rq->xdp_prog);
> > > +       if (prog)
> > > +               ret =3D virtnet_xdp_handler(prog, xdp, dev, xdp_xmit,=
 stats);
> > > +       rcu_read_unlock();
> > > +
> > > +       switch (ret) {
> > > +       case XDP_PASS:
> > > +               return xdp_construct_skb(rq, xdp);
> > > +
> > > +       case XDP_TX:
> > > +       case XDP_REDIRECT:
> > > +               return NULL;
> > > +
> > > +       default:
> > > +               /* drop packet */
> > > +               xsk_buff_free(xdp);
> > > +               u64_stats_inc(&stats->drops);
> > > +               return NULL;
> > > +       }
> > > +}
> > > +
> > > +static struct sk_buff *virtnet_receive_xsk_buf(struct virtnet_info *=
vi, struct receive_queue *rq,
> > > +                                              void *buf, u32 len,
> > > +                                              unsigned int *xdp_xmit=
,
> > > +                                              struct virtnet_rq_stat=
s *stats)
> > > +{
> > > +       struct net_device *dev =3D vi->dev;
> > > +       struct sk_buff *skb =3D NULL;
> > > +       struct xdp_buff *xdp;
> > > +
> > > +       len -=3D vi->hdr_len;
> > > +
> > > +       u64_stats_add(&stats->bytes, len);
> > > +
> > > +       xdp =3D buf_to_xdp(vi, rq, buf, len);
> > > +       if (!xdp)
> > > +               return NULL;
> > > +
> > > +       if (unlikely(len < ETH_HLEN)) {
> > > +               pr_debug("%s: short packet %i\n", dev->name, len);
> > > +               DEV_STATS_INC(dev, rx_length_errors);
> > > +               xsk_buff_free(xdp);
> > > +               return NULL;
> > > +       }
> > > +
> > > +       if (!vi->mergeable_rx_bufs)
> > > +               skb =3D virtnet_receive_xsk_small(dev, vi, rq, xdp, x=
dp_xmit, stats);
> > > +
> > > +       return skb;
> > > +}
> > > +
> > >  static int virtnet_add_recvbuf_xsk(struct virtnet_info *vi, struct r=
eceive_queue *rq,
> > >                                    struct xsk_buff_pool *pool, gfp_t =
gfp)
> > >  {
> > > @@ -2363,9 +2481,22 @@ static int virtnet_receive(struct receive_queu=
e *rq, int budget,
> > >         void *buf;
> > >         int i;
> > >
> > > -       if (!vi->big_packets || vi->mergeable_rx_bufs) {
> > > -               void *ctx;
> > > +       if (rq->xsk.pool) {
> > > +               struct sk_buff *skb;
> > > +
> > > +               while (packets < budget) {
> > > +                       buf =3D virtqueue_get_buf(rq->vq, &len);
> > > +                       if (!buf)
> > > +                               break;
> > >
> > > +                       skb =3D virtnet_receive_xsk_buf(vi, rq, buf, =
len, xdp_xmit, &stats);
> > > +                       if (skb)
> > > +                               virtnet_receive_done(vi, rq, skb);
> > > +
> > > +                       packets++;
> > > +               }
> >
> > If reusing turns out to be hard, I'd rather add new paths in receive_sm=
all().
>
> The exist function is called after virtnet_rq_get_buf(), that will do dma=
 unmap.
> But for xsk, the dma unmap is not need. So xsk receive handle should use
> virtqueue_get_buf directly.

Probably but if it's just virtnet_rq_get_buf() we can simply did:

static void *virtnet_rq_get_buf(struct receive_queue *rq, u32 *len, void **=
ctx)
{
        void *buf;

        buf =3D virtqueue_get_buf_ctx(rq->vq, len, ctx);
        if (buf && rq->xsk.pool)
                virtnet_rq_unmap(rq, buf, *len);

        return buf;
}

Thanks

>
> Thanks.
>
> >
> > > +       } else if (!vi->big_packets || vi->mergeable_rx_bufs) {
> > > +               void *ctx;
> > >                 while (packets < budget &&
> > >                        (buf =3D virtnet_rq_get_buf(rq, &len, &ctx))) =
{
> > >                         receive_buf(vi, rq, buf, len, ctx, xdp_xmit, =
&stats);
> > > --
> > > 2.32.0.3.g01195cf9f
> > >
> >
> > Thanks
> >
>


