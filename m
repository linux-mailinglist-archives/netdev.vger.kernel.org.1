Return-Path: <netdev+bounces-66564-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 760CF83FC97
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 04:08:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFA711F223A0
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 03:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E06C2EADC;
	Mon, 29 Jan 2024 03:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LuQkThuq"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F465FC00
	for <netdev@vger.kernel.org>; Mon, 29 Jan 2024 03:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706497687; cv=none; b=uQaeiDloex7egAbm/5ybbrtm/aEOEcdmb6o/7GxPp1nL9fE5Xkytv/E4OqhyDjYbDVrNKdT4j/OnBNPCB4d60ISRzxZb+SYCMg9DguOesWiy3GyvhWPGW5JUBZREVhn/1vhC0u/j1MnbCwsgPU6FSEEEAhqZEAEAo/JfX7hij+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706497687; c=relaxed/simple;
	bh=iCs1WHpzollZFQrjxHtvP9o5b+PRRgaNIpLMdX9ff3M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VSSdIIld8+7s259wKKR8GEAF9eORKdrJ7Lo96/w8zy2ggZnL05uEBqZhxLXHjQi8Euljt0Jgbmfi+sMooYq6LkhQNKPQWzTzBAJQV5Q/ifwOUOi3AkWTJl6s83CS+xCWbvQ8SX/eXHMCJSZmPcUZedW7awJUFExTOVtAPNHf8FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LuQkThuq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706497685;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YX2CdNy8jx84pqfuHEOADLuqPvCDMcp27gdPNkYFGvY=;
	b=LuQkThuqbt32gEBNJZd3jQH19OGK+zN6nfiXTT7U2BrW2V8VeDKqTv884O7l5KG1LmmsGk
	aBko+NGven5rLO2xlucVRXlnY58jWnrd2fuPOBwv6SIzHVL/kICNHRwnECoTthp/kRSFoA
	79oVxdkuIlWRkD3UvjwraFDHfRYrqx8=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-113-sGtIbuMCOAywJdo_N3tQOA-1; Sun, 28 Jan 2024 22:08:03 -0500
X-MC-Unique: sGtIbuMCOAywJdo_N3tQOA-1
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-598fdf35732so1084757eaf.1
        for <netdev@vger.kernel.org>; Sun, 28 Jan 2024 19:08:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706497682; x=1707102482;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YX2CdNy8jx84pqfuHEOADLuqPvCDMcp27gdPNkYFGvY=;
        b=ac5gcIHfgl3Rbu+vitYvIREWuD1BD/4tUxIAekyplOmIZit22MtcvhuvCaQOogKn1u
         lHZIMvFuquhMTaifoq/bDRTVpBsitm8UrRsAm9amVKGrLCM2odtKKt0TPAIM9JV119R8
         3enLWZJVDeIFcB+h7VptfDwWygv6BIWiw6nGN5s1GBpOnVifMpxgbDFEk0c46o3JoLM7
         gXcfBQRWAs6iw284zVtHcjdakH9hpodZvrO0O7kEcFy99taun+ftv5ZQfDxsTEEjemck
         9fTRyyWXO/yhDdY2qZrgzKgNJR6LUMgH++WGqUCJWq5Jvv4+6J9ndDNX0tfYd2LSzh+M
         wz/g==
X-Gm-Message-State: AOJu0YwyUK/Uo4MxjjD60rD1AgFtRSWMqEnheSOqzzhW9HSvr12oTV3f
	CjPrCs+RFW1aTpQDPZcyobKlXs+wOFjT4xG1MvRjGbWT5E3Obc3eXiLZviVxL71vbvrXUE/LAWt
	c3+VVpc55bjoVVMvf3O8NoNrhtsvHUEHHZ3m9k8y9ZPtcwdePwDFpL+iYJu41HtZrQmT1j/oMIQ
	Uo39RHlWeDLDQPLHB0DhBJVDtzU+zU
X-Received: by 2002:a05:6358:15ca:b0:178:773a:d73 with SMTP id t10-20020a05635815ca00b00178773a0d73mr166992rwh.13.1706497682369;
        Sun, 28 Jan 2024 19:08:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGlP7jTLm147DEuL0Qol7tZHE3ofd4zvGyauSzjQEhwJo9bvyxAM6a5oPGgdSvMNWeBdIdK1Jh5SLGOP3v3Vbc=
X-Received: by 2002:a05:6358:15ca:b0:178:773a:d73 with SMTP id
 t10-20020a05635815ca00b00178773a0d73mr166981rwh.13.1706497681981; Sun, 28 Jan
 2024 19:08:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240116075924.42798-1-xuanzhuo@linux.alibaba.com>
 <20240116075924.42798-5-xuanzhuo@linux.alibaba.com> <CACGkMEtSnuo6yAsiFZkrv6bMaJtLXuLQtL-qvKn-Y_L_PLHdcw@mail.gmail.com>
 <1706162276.5311615-3-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1706162276.5311615-3-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 29 Jan 2024 11:07:50 +0800
Message-ID: <CACGkMEsfVQzb1jDXE=-LABot=3Cd1+kPX6oF+g8z_68s8zMWuQ@mail.gmail.com>
Subject: Re: [PATCH net-next 4/5] virtio_ring: introduce virtqueue_get_dma_premapped()
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, virtualization@lists.linux.dev, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 1:58=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> On Thu, 25 Jan 2024 11:39:03 +0800, Jason Wang <jasowang@redhat.com> wrot=
e:
> > On Tue, Jan 16, 2024 at 3:59=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.aliba=
ba.com> wrote:
> > >
> > > Introduce helper virtqueue_get_dma_premapped(), then the driver
> > > can know whether dma unmap is needed.
> > >
> > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > ---
> > >  drivers/net/virtio/main.c       | 22 +++++++++-------------
> > >  drivers/net/virtio/virtio_net.h |  3 ---
> > >  drivers/virtio/virtio_ring.c    | 22 ++++++++++++++++++++++
> > >  include/linux/virtio.h          |  1 +
> > >  4 files changed, 32 insertions(+), 16 deletions(-)
> > >
> > > diff --git a/drivers/net/virtio/main.c b/drivers/net/virtio/main.c
> > > index 186b2cf5d8fc..4fbf612da235 100644
> > > --- a/drivers/net/virtio/main.c
> > > +++ b/drivers/net/virtio/main.c
> > > @@ -483,7 +483,7 @@ static void *virtnet_rq_get_buf(struct virtnet_rq=
 *rq, u32 *len, void **ctx)
> > >         void *buf;
> > >
> > >         buf =3D virtqueue_get_buf_ctx(rq->vq, len, ctx);
> > > -       if (buf && rq->do_dma)
> > > +       if (buf && virtqueue_get_dma_premapped(rq->vq))
> > >                 virtnet_rq_unmap(rq, buf, *len);
> > >
> > >         return buf;
> > > @@ -496,7 +496,7 @@ static void virtnet_rq_init_one_sg(struct virtnet=
_rq *rq, void *buf, u32 len)
> > >         u32 offset;
> > >         void *head;
> > >
> > > -       if (!rq->do_dma) {
> > > +       if (!virtqueue_get_dma_premapped(rq->vq)) {
> > >                 sg_init_one(rq->sg, buf, len);
> > >                 return;
> > >         }
> > > @@ -526,7 +526,7 @@ static void *virtnet_rq_alloc(struct virtnet_rq *=
rq, u32 size, gfp_t gfp)
> > >
> > >         head =3D page_address(alloc_frag->page);
> > >
> > > -       if (rq->do_dma) {
> > > +       if (virtqueue_get_dma_premapped(rq->vq)) {
> > >                 dma =3D head;
> > >
> > >                 /* new pages */
> > > @@ -580,12 +580,8 @@ static void virtnet_rq_set_premapped(struct virt=
net_info *vi)
> > >         if (!vi->mergeable_rx_bufs && vi->big_packets)
> > >                 return;
> > >
> > > -       for (i =3D 0; i < vi->max_queue_pairs; i++) {
> > > -               if (virtqueue_set_dma_premapped(vi->rq[i].vq))
> > > -                       continue;
> > > -
> > > -               vi->rq[i].do_dma =3D true;
> > > -       }
> > > +       for (i =3D 0; i < vi->max_queue_pairs; i++)
> > > +               virtqueue_set_dma_premapped(vi->rq[i].vq);
> > >  }
> > >
> > >  static void free_old_xmit(struct virtnet_sq *sq, bool in_napi)
> > > @@ -1643,7 +1639,7 @@ static int add_recvbuf_small(struct virtnet_inf=
o *vi, struct virtnet_rq *rq,
> > >
> > >         err =3D virtqueue_add_inbuf_ctx(rq->vq, rq->sg, 1, buf, ctx, =
gfp);
> > >         if (err < 0) {
> > > -               if (rq->do_dma)
> > > +               if (virtqueue_get_dma_premapped(rq->vq))
> > >                         virtnet_rq_unmap(rq, buf, 0);
> > >                 put_page(virt_to_head_page(buf));
> > >         }
> > > @@ -1758,7 +1754,7 @@ static int add_recvbuf_mergeable(struct virtnet=
_info *vi,
> > >         ctx =3D mergeable_len_to_ctx(len + room, headroom);
> > >         err =3D virtqueue_add_inbuf_ctx(rq->vq, rq->sg, 1, buf, ctx, =
gfp);
> > >         if (err < 0) {
> > > -               if (rq->do_dma)
> > > +               if (virtqueue_get_dma_premapped(rq->vq))
> > >                         virtnet_rq_unmap(rq, buf, 0);
> > >                 put_page(virt_to_head_page(buf));
> > >         }
> > > @@ -4007,7 +4003,7 @@ static void free_receive_page_frags(struct virt=
net_info *vi)
> > >         int i;
> > >         for (i =3D 0; i < vi->max_queue_pairs; i++)
> > >                 if (vi->rq[i].alloc_frag.page) {
> > > -                       if (vi->rq[i].do_dma && vi->rq[i].last_dma)
> > > +                       if (virtqueue_get_dma_premapped(vi->rq[i].vq)=
 && vi->rq[i].last_dma)
> > >                                 virtnet_rq_unmap(&vi->rq[i], vi->rq[i=
].last_dma, 0);
> > >                         put_page(vi->rq[i].alloc_frag.page);
> > >                 }
> > > @@ -4035,7 +4031,7 @@ static void virtnet_rq_free_unused_bufs(struct =
virtqueue *vq)
> > >         rq =3D &vi->rq[i];
> > >
> > >         while ((buf =3D virtqueue_detach_unused_buf(vq)) !=3D NULL) {
> > > -               if (rq->do_dma)
> > > +               if (virtqueue_get_dma_premapped(rq->vq))
> > >                         virtnet_rq_unmap(rq, buf, 0);
> > >
> > >                 virtnet_rq_free_buf(vi, rq, buf);
> > > diff --git a/drivers/net/virtio/virtio_net.h b/drivers/net/virtio/vir=
tio_net.h
> > > index b28a4d0a3150..066a2b9d2b3c 100644
> > > --- a/drivers/net/virtio/virtio_net.h
> > > +++ b/drivers/net/virtio/virtio_net.h
> > > @@ -115,9 +115,6 @@ struct virtnet_rq {
> > >
> > >         /* Record the last dma info to free after new pages is alloca=
ted. */
> > >         struct virtnet_rq_dma *last_dma;
> > > -
> > > -       /* Do dma by self */
> > > -       bool do_dma;
> > >  };
> > >
> > >  struct virtnet_info {
> > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_rin=
g.c
> > > index 2c5089d3b510..9092bcdebb53 100644
> > > --- a/drivers/virtio/virtio_ring.c
> > > +++ b/drivers/virtio/virtio_ring.c
> > > @@ -2905,6 +2905,28 @@ int virtqueue_set_dma_premapped(struct virtque=
ue *_vq)
> > >  }
> > >  EXPORT_SYMBOL_GPL(virtqueue_set_dma_premapped);
> > >
> > > +/**
> > > + * virtqueue_get_dma_premapped - get the vring premapped mode
> > > + * @_vq: the struct virtqueue we're talking about.
> > > + *
> > > + * Get the premapped mode of the vq.
> > > + *
> > > + * Returns bool for the vq premapped mode.
> > > + */
> > > +bool virtqueue_get_dma_premapped(struct virtqueue *_vq)
> > > +{
> > > +       struct vring_virtqueue *vq =3D to_vvq(_vq);
> > > +       bool premapped;
> > > +
> > > +       START_USE(vq);
> > > +       premapped =3D vq->premapped;
> > > +       END_USE(vq);
> >
> > Why do we need to protect premapped like this? Is the user allowed to
> > change it on the fly?
>
>
> Just protect before accessing vq.

I meant how did that differ from other booleans? E.g use_dma_api, do_unmap =
etc.

Thanks

>
> Thanks.
> >
> > Thanks
> >
>


