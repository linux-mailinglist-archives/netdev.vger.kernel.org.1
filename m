Return-Path: <netdev+bounces-66953-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA4BF8419AC
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 03:54:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA49EB252B1
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 02:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A771A37157;
	Tue, 30 Jan 2024 02:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OEvYFO0y"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598AF36AF6
	for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 02:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706583282; cv=none; b=r54LPqzdQJet0zZ+LlyAztvX5qEq9F2gV3epF/ae9t5PF68xOLU0RPxqvAjLxbIIpO/e2U5loqf+qZlU1V5vuuaeYkjQSCBA8DuTPej5fFHvcI7fauMeBWQ7mtWQq1fAqmTr90641NdccW4LpKVkJoqCOhsict80jcg1HJKMQOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706583282; c=relaxed/simple;
	bh=YhMZoaQZlskTA6K39O44SNzMAkpa8V4trRsJrRH/oaA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ms4q0vtmWzHuqg7Wv31ZEXv8NyJpUPYVC3yJCLuBgKYrliy3PKIKw5CImyrHcPpf+hG9hMWQwP5aYSNraMdV+tlj1XIJDVdBDa4+xLp8hkVAkxqF9quisgL5FKy36TCujpDVndue7YOnVacagXa7KcNZxAw1ZR/KQfz9W2A+9W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OEvYFO0y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706583279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8MLWCGvd9n4DYu7+/iUlBs9DHHAkFBdVPv/6wkSctr8=;
	b=OEvYFO0ysJB/WMu8jH7Cw9v9AvxsweTvSyFPcHJRQ14hfWZlFEqyOGIYQCNIC57sUDvne6
	Ei2GX4j8SkH291D2GKQjoKtX1Jl5McCrypjeYcZ8RwSNSDjcYB49FbevZE3jBFoRtBU6X7
	OY1ybdXeG3wAaKTahq7YyiRQaI3cehI=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-nf_U5djJOLSJr3De2iJMzg-1; Mon, 29 Jan 2024 21:54:37 -0500
X-MC-Unique: nf_U5djJOLSJr3De2iJMzg-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-6ddddbf239aso1955197b3a.3
        for <netdev@vger.kernel.org>; Mon, 29 Jan 2024 18:54:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706583276; x=1707188076;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8MLWCGvd9n4DYu7+/iUlBs9DHHAkFBdVPv/6wkSctr8=;
        b=fAc28QpTegSG8+EuL8ILtbfzafiB0PfPzFH/SiqxyLV9tVxMD0fkULwPfak0Lt+tSA
         FcKjUVnFNsXsJyqBOF3ljnEYTMZWwoD6sbuLmVvbcWVARrTo9b9TmtZRt7D1gv4BirVe
         1CoeB62XS2YiFA8MQnJkQSyoY121NHwyrzRCGLsOTCl684pawcFdbn07v8wmLNqECVnf
         AM+HxdWr3C9++K0vdBanAzQ67v4RF5aZoxW28HfaagGmtv7BAfVkfBmq5jFiD8D7Ms3b
         jLzJQ7AQhpD/F5l3eRU0FbPKAJrw6I7zSgm0x4oo6+GgA3XC3+EdowSAOjtkk5dFj63R
         PDFw==
X-Gm-Message-State: AOJu0YzDaAM8OMRDIdGoEKIqkFgkVutwH92MkUSirc67V2OjfR6AtCrM
	xE9uKWR65Q900DzE00QGzNdqgYtjsm8ivZg+jYAB04dDl4LXfoRLTLvm66NnRx+NMzR4bLd+cR5
	uTC7pfxgBdm6zhrX/t7oYVMS3UHcVWotZcuqgpGCODgromZ33KIoOAszGH9Ywoie43y2RSSAkXK
	XCFqydnSYw20XmeUdF29sJzsat0RWc
X-Received: by 2002:a05:6a00:2f16:b0:6d9:a565:9be6 with SMTP id fe22-20020a056a002f1600b006d9a5659be6mr3369043pfb.9.1706583276664;
        Mon, 29 Jan 2024 18:54:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH7agE4CQEisgsF9xxzacogGRN6EuRWs2S5RE6fOUNtpcbvW1pzD+h5+hWsvfhGzSWlLwbaTLAYHnCJW+eS4wA=
X-Received: by 2002:a05:6a00:2f16:b0:6d9:a565:9be6 with SMTP id
 fe22-20020a056a002f1600b006d9a5659be6mr3369026pfb.9.1706583276246; Mon, 29
 Jan 2024 18:54:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240116075924.42798-1-xuanzhuo@linux.alibaba.com>
 <20240116075924.42798-5-xuanzhuo@linux.alibaba.com> <CACGkMEtSnuo6yAsiFZkrv6bMaJtLXuLQtL-qvKn-Y_L_PLHdcw@mail.gmail.com>
 <1706162276.5311615-3-xuanzhuo@linux.alibaba.com> <CACGkMEsfVQzb1jDXE=-LABot=3Cd1+kPX6oF+g8z_68s8zMWuQ@mail.gmail.com>
 <1706499019.7011588-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1706499019.7011588-2-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 30 Jan 2024 10:54:25 +0800
Message-ID: <CACGkMEsueyFnFBCBm_8TkBW+rhRzkjJmAw6X-7R2dC1po2BMaQ@mail.gmail.com>
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

On Mon, Jan 29, 2024 at 11:33=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibaba.=
com> wrote:
>
> On Mon, 29 Jan 2024 11:07:50 +0800, Jason Wang <jasowang@redhat.com> wrot=
e:
> > On Thu, Jan 25, 2024 at 1:58=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.aliba=
ba.com> wrote:
> > >
> > > On Thu, 25 Jan 2024 11:39:03 +0800, Jason Wang <jasowang@redhat.com> =
wrote:
> > > > On Tue, Jan 16, 2024 at 3:59=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.a=
libaba.com> wrote:
> > > > >
> > > > > Introduce helper virtqueue_get_dma_premapped(), then the driver
> > > > > can know whether dma unmap is needed.
> > > > >
> > > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > ---
> > > > >  drivers/net/virtio/main.c       | 22 +++++++++-------------
> > > > >  drivers/net/virtio/virtio_net.h |  3 ---
> > > > >  drivers/virtio/virtio_ring.c    | 22 ++++++++++++++++++++++
> > > > >  include/linux/virtio.h          |  1 +
> > > > >  4 files changed, 32 insertions(+), 16 deletions(-)
> > > > >
> > > > > diff --git a/drivers/net/virtio/main.c b/drivers/net/virtio/main.=
c
> > > > > index 186b2cf5d8fc..4fbf612da235 100644
> > > > > --- a/drivers/net/virtio/main.c
> > > > > +++ b/drivers/net/virtio/main.c
> > > > > @@ -483,7 +483,7 @@ static void *virtnet_rq_get_buf(struct virtne=
t_rq *rq, u32 *len, void **ctx)
> > > > >         void *buf;
> > > > >
> > > > >         buf =3D virtqueue_get_buf_ctx(rq->vq, len, ctx);
> > > > > -       if (buf && rq->do_dma)
> > > > > +       if (buf && virtqueue_get_dma_premapped(rq->vq))
> > > > >                 virtnet_rq_unmap(rq, buf, *len);
> > > > >
> > > > >         return buf;
> > > > > @@ -496,7 +496,7 @@ static void virtnet_rq_init_one_sg(struct vir=
tnet_rq *rq, void *buf, u32 len)
> > > > >         u32 offset;
> > > > >         void *head;
> > > > >
> > > > > -       if (!rq->do_dma) {
> > > > > +       if (!virtqueue_get_dma_premapped(rq->vq)) {
> > > > >                 sg_init_one(rq->sg, buf, len);
> > > > >                 return;
> > > > >         }
> > > > > @@ -526,7 +526,7 @@ static void *virtnet_rq_alloc(struct virtnet_=
rq *rq, u32 size, gfp_t gfp)
> > > > >
> > > > >         head =3D page_address(alloc_frag->page);
> > > > >
> > > > > -       if (rq->do_dma) {
> > > > > +       if (virtqueue_get_dma_premapped(rq->vq)) {
> > > > >                 dma =3D head;
> > > > >
> > > > >                 /* new pages */
> > > > > @@ -580,12 +580,8 @@ static void virtnet_rq_set_premapped(struct =
virtnet_info *vi)
> > > > >         if (!vi->mergeable_rx_bufs && vi->big_packets)
> > > > >                 return;
> > > > >
> > > > > -       for (i =3D 0; i < vi->max_queue_pairs; i++) {
> > > > > -               if (virtqueue_set_dma_premapped(vi->rq[i].vq))
> > > > > -                       continue;
> > > > > -
> > > > > -               vi->rq[i].do_dma =3D true;
> > > > > -       }
> > > > > +       for (i =3D 0; i < vi->max_queue_pairs; i++)
> > > > > +               virtqueue_set_dma_premapped(vi->rq[i].vq);
> > > > >  }
> > > > >
> > > > >  static void free_old_xmit(struct virtnet_sq *sq, bool in_napi)
> > > > > @@ -1643,7 +1639,7 @@ static int add_recvbuf_small(struct virtnet=
_info *vi, struct virtnet_rq *rq,
> > > > >
> > > > >         err =3D virtqueue_add_inbuf_ctx(rq->vq, rq->sg, 1, buf, c=
tx, gfp);
> > > > >         if (err < 0) {
> > > > > -               if (rq->do_dma)
> > > > > +               if (virtqueue_get_dma_premapped(rq->vq))
> > > > >                         virtnet_rq_unmap(rq, buf, 0);
> > > > >                 put_page(virt_to_head_page(buf));
> > > > >         }
> > > > > @@ -1758,7 +1754,7 @@ static int add_recvbuf_mergeable(struct vir=
tnet_info *vi,
> > > > >         ctx =3D mergeable_len_to_ctx(len + room, headroom);
> > > > >         err =3D virtqueue_add_inbuf_ctx(rq->vq, rq->sg, 1, buf, c=
tx, gfp);
> > > > >         if (err < 0) {
> > > > > -               if (rq->do_dma)
> > > > > +               if (virtqueue_get_dma_premapped(rq->vq))
> > > > >                         virtnet_rq_unmap(rq, buf, 0);
> > > > >                 put_page(virt_to_head_page(buf));
> > > > >         }
> > > > > @@ -4007,7 +4003,7 @@ static void free_receive_page_frags(struct =
virtnet_info *vi)
> > > > >         int i;
> > > > >         for (i =3D 0; i < vi->max_queue_pairs; i++)
> > > > >                 if (vi->rq[i].alloc_frag.page) {
> > > > > -                       if (vi->rq[i].do_dma && vi->rq[i].last_dm=
a)
> > > > > +                       if (virtqueue_get_dma_premapped(vi->rq[i]=
.vq) && vi->rq[i].last_dma)
> > > > >                                 virtnet_rq_unmap(&vi->rq[i], vi->=
rq[i].last_dma, 0);
> > > > >                         put_page(vi->rq[i].alloc_frag.page);
> > > > >                 }
> > > > > @@ -4035,7 +4031,7 @@ static void virtnet_rq_free_unused_bufs(str=
uct virtqueue *vq)
> > > > >         rq =3D &vi->rq[i];
> > > > >
> > > > >         while ((buf =3D virtqueue_detach_unused_buf(vq)) !=3D NUL=
L) {
> > > > > -               if (rq->do_dma)
> > > > > +               if (virtqueue_get_dma_premapped(rq->vq))
> > > > >                         virtnet_rq_unmap(rq, buf, 0);
> > > > >
> > > > >                 virtnet_rq_free_buf(vi, rq, buf);
> > > > > diff --git a/drivers/net/virtio/virtio_net.h b/drivers/net/virtio=
/virtio_net.h
> > > > > index b28a4d0a3150..066a2b9d2b3c 100644
> > > > > --- a/drivers/net/virtio/virtio_net.h
> > > > > +++ b/drivers/net/virtio/virtio_net.h
> > > > > @@ -115,9 +115,6 @@ struct virtnet_rq {
> > > > >
> > > > >         /* Record the last dma info to free after new pages is al=
located. */
> > > > >         struct virtnet_rq_dma *last_dma;
> > > > > -
> > > > > -       /* Do dma by self */
> > > > > -       bool do_dma;
> > > > >  };
> > > > >
> > > > >  struct virtnet_info {
> > > > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio=
_ring.c
> > > > > index 2c5089d3b510..9092bcdebb53 100644
> > > > > --- a/drivers/virtio/virtio_ring.c
> > > > > +++ b/drivers/virtio/virtio_ring.c
> > > > > @@ -2905,6 +2905,28 @@ int virtqueue_set_dma_premapped(struct vir=
tqueue *_vq)
> > > > >  }
> > > > >  EXPORT_SYMBOL_GPL(virtqueue_set_dma_premapped);
> > > > >
> > > > > +/**
> > > > > + * virtqueue_get_dma_premapped - get the vring premapped mode
> > > > > + * @_vq: the struct virtqueue we're talking about.
> > > > > + *
> > > > > + * Get the premapped mode of the vq.
> > > > > + *
> > > > > + * Returns bool for the vq premapped mode.
> > > > > + */
> > > > > +bool virtqueue_get_dma_premapped(struct virtqueue *_vq)
> > > > > +{
> > > > > +       struct vring_virtqueue *vq =3D to_vvq(_vq);
> > > > > +       bool premapped;
> > > > > +
> > > > > +       START_USE(vq);
> > > > > +       premapped =3D vq->premapped;
> > > > > +       END_USE(vq);
> > > >
> > > > Why do we need to protect premapped like this? Is the user allowed =
to
> > > > change it on the fly?
> > >
> > >
> > > Just protect before accessing vq.
> >
> > I meant how did that differ from other booleans? E.g use_dma_api, do_un=
map etc.
>
> Sorry, maybe I misunderstanded you.
>
> Do you mean, should we put "premapped" to the struct virtqueue?
> Then the user can read/write by the struct virtqueue directly?
>
> If that, the reason is that when set premapped, we must check
> use_dma_api.

I may not be very clear.

I meant why we should protect premapped with START_USE()/END_USER() here.

If it is set once during init_vqs we should not need that.

Thanks


