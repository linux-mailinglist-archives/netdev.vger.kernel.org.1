Return-Path: <netdev+bounces-142194-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9389BDBAF
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 02:57:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBD1E1C22C76
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 01:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E0E018C922;
	Wed,  6 Nov 2024 01:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MUsIgnHc"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC6218C335
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 01:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730858233; cv=none; b=CsBlMlEfyrJ821QaIhttbvvB4PRGAAx1Pn9IPHVijlerdk8Vr+BVsgnXQ0kFem3VCJrC2CcMKcedXnglRTeEmv+eqm3oxgditN+/sDR0IbrUvXYPr410WQvJvAG5+9Y3PqhSn65ssIeEdzgE795ea/dX41p2tA7ZTgJuvrod+Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730858233; c=relaxed/simple;
	bh=9JZwaZ7zkHSJiSW9v+UoIvfOxvxshGswHvo2Gf62gGQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L+n1eiiiy3BCSlsaV2KMsq6y7PAvtTZKMM5AvfR1NbU22YGbn/Brgeu5TSws25ZDugWWw/KhDpqCZPQxOHYw+iu+fzQ+JqKwr6NgvC6WHRIitFMILTvBn3VI5Q1mBc1XIrs0JIxhrbXdUyG3gzyYcXDx6l2bB7NSSYjICtSkG3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MUsIgnHc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730858230;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vuUpBAQVSxZIog/ODTCDmE9tfS9Da4cYUZvnpvpzVCU=;
	b=MUsIgnHcKlaNvn+8PUQdoQ9IgB55Yl7ZrJq8loKdp3NjvZH0HuJsyF+7EYsGNZQk4De9rV
	WmIkUcq0HIJBGm0fJg9RncLD1D4JS2H7KBoDi8amqq6bLWvKA2pW8OPHMMqYHugiuvLfJd
	EGmTYgM+qQfm28Hz0BS9To3e+eGtgwk=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-gZGbgHriO3aJB7oBMJrWGg-1; Tue, 05 Nov 2024 20:57:08 -0500
X-MC-Unique: gZGbgHriO3aJB7oBMJrWGg-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-20cb3d9f5eeso3546175ad.1
        for <netdev@vger.kernel.org>; Tue, 05 Nov 2024 17:57:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730858228; x=1731463028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vuUpBAQVSxZIog/ODTCDmE9tfS9Da4cYUZvnpvpzVCU=;
        b=NZsH2DukKi3U4GiRujDu/d8PNG2XS1NWtCOItfHengOwUpMZfAR1IrxcThzGE+xnC8
         qxwSsdc5bN7PSQtNvNb2y9nEVTrXue5PRZikGtVSZ1FZ2JFSvXpknMlKt/gcJb9vUZ8N
         97YunXKoJPqjZfdCumvp1SyT1mUlOjUscDBtm0gF1DtE1NJa01TlHfu7CJE5ARLLZxmL
         EppPvquZ75yoZEPWS1bfznnJijYT+Klo0EFaVcLNg+itKYNphVHKaq9cWlx/Gpt1XoRT
         ZmuCBb4tfWWLgyZgproU1jDuwNn9ZdsPKSrs/9mPMinZyJGmlIbQVg9pPmoWMvrs1Woa
         /5pg==
X-Gm-Message-State: AOJu0YyX4kS/8+9FBAwpeLBLhk5olKjBm5lPmoV223bGvWDrbG8IfOKj
	K0f0lrZt2EuhIFObKAMduza+fgyNgefk76P2B0j2L6zy5nZnJ4E65X4AxvYcB2b6U+mknm3I/jA
	aXKh0qAW7p87epVURml6xrP7h8gxz3OnszIqzfHkEMLwtWEpIiGiYlDN4WgO2racbHT48wiY+4J
	c7d/4d76PoACbVenMKvD9XygcKL/2J
X-Received: by 2002:a17:902:cf0d:b0:20e:df57:db50 with SMTP id d9443c01a7336-2116c569f3bmr13581045ad.18.1730858227640;
        Tue, 05 Nov 2024 17:57:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH/SxOv0GXjuaKPQB9a3NffmjYrbL2lrFoa/apw3iJzmURj0s3MgL9FUe/jZvPU3vfi7GHkYy4w3VytQKE1ua8=
X-Received: by 2002:a17:902:cf0d:b0:20e:df57:db50 with SMTP id
 d9443c01a7336-2116c569f3bmr13580525ad.18.1730858227049; Tue, 05 Nov 2024
 17:57:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241030082453.97310-1-xuanzhuo@linux.alibaba.com>
 <20241030082453.97310-7-xuanzhuo@linux.alibaba.com> <CACGkMEviCSEo4thkFo8gYnv+FCm-v65umJ65fdOwtxbAF_F2Ag@mail.gmail.com>
 <1730790584.4657414-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1730790584.4657414-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 6 Nov 2024 09:56:55 +0800
Message-ID: <CACGkMEuqXWznXVR+e_gBuhybTSnEePxXqrmDYFsFGOcuWXbzRg@mail.gmail.com>
Subject: Re: [PATCH net-next v2 06/13] virtio-net: rq submits premapped per-buffer
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	virtualization@lists.linux.dev, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 5, 2024 at 3:23=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.co=
m> wrote:
>
> On Tue, 5 Nov 2024 11:23:50 +0800, Jason Wang <jasowang@redhat.com> wrote=
:
> > On Wed, Oct 30, 2024 at 4:25=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.aliba=
ba.com> wrote:
> > >
> > > virtio-net rq submits premapped per-buffer by setting sg page to NULL=
;
> > >
> > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > ---
> > >  drivers/net/virtio_net.c | 24 +++++++++++++-----------
> > >  1 file changed, 13 insertions(+), 11 deletions(-)
> > >
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index 792e9eadbfc3..09757fa408bd 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -542,6 +542,12 @@ static struct sk_buff *ptr_to_skb(void *ptr)
> > >         return (struct sk_buff *)((unsigned long)ptr & ~VIRTIO_ORPHAN=
_FLAG);
> > >  }
> > >
> > > +static void sg_fill_dma(struct scatterlist *sg, dma_addr_t addr, u32=
 len)
> > > +{
> > > +       sg->dma_address =3D addr;
> > > +       sg->length =3D len;
> >
> > This may work but I think it's better to reuse existing dma sg helpers =
like:
> >
> > sg_dma_address(sg) =3D addr;
> > sg_dma_length(sg) =3D len;
> >
> > And we probably need to fix the virtio core which only uses
> > sg_dma_address() but not sg_dma_length().
> >
> > This helps us to avoid future issues when CONFIG_NEED_SG_DMA_LENGTH is =
set.
>
>
> I don't think so.
>
> For no-premapped mode, we pass the sg as no-dma sg to virtio core,
> so the virtio core uses the sg->length directly.

This is fine.

> If virtio core do dma map for sg, we do not use the dma_mag_sg_attrs(),
> so we must use sg->length directly.

I meant it's a hack. It may work now but will be a bug in the future.

For example, I'm playing a prototype to do pre mapping for virtio-blk,
the idea is to move the expensive DMA mappings in the case of swiotlb
etc to be done outside the pre virtqueue lock. In that case, the
driver may want to use dma_map_sg() instead of dma_map_page().

I'd suppose we will finally go with the way where DMA mappings needs
to be handled by the driver, and dma_map_sg() is faster than per sg
dma_map_page() anyhow.

>
> In this case, for the driver, we can not use sg_dma_length(),
> if CONFIG_NEED_SG_DMA_LENGTH is set, sg_dma_length() will set sg->dma_len=
gth,
> but virtio core use sg->length.

Well, we just need a minor tweak to get the length from
vring_map_one_sg(), then everything should be fine?

if (sg_is_premapped) {
      *addr =3D sg_dma_address(sg);
      *len =3D sg_dma_len(sg);
}

>
> For sg->dma_address, it is ok for me to use sg_dma_address or not.
> But for consistency to sg->length, I use the sg->dma_address directly.
>
> I noticed this is special, so I put them into an independent function.
>
> Thanks.

Actually, the code like sg_fill_dma() calls for a virtqueue dma
mapping helper, I think we've agreed that core needs to hide DMA
details from the driver.  That is something like
virtqueue_dma_map_sg() etc.

Thanks

>
> >
> > Others look good.
> >
> > Thanks
> >
> > > +}
> > > +
> > >  static void __free_old_xmit(struct send_queue *sq, struct netdev_que=
ue *txq,
> > >                             bool in_napi, struct virtnet_sq_free_stat=
s *stats)
> > >  {
> > > @@ -915,8 +921,7 @@ static void virtnet_rq_init_one_sg(struct receive=
_queue *rq, void *buf, u32 len)
> > >         addr =3D dma->addr - sizeof(*dma) + offset;
> > >
> > >         sg_init_table(rq->sg, 1);
> > > -       rq->sg[0].dma_address =3D addr;
> > > -       rq->sg[0].length =3D len;
> > > +       sg_fill_dma(rq->sg, addr, len);
> > >  }
> > >
> > >  static void *virtnet_rq_alloc(struct receive_queue *rq, u32 size, gf=
p_t gfp)
> > > @@ -1068,12 +1073,6 @@ static void check_sq_full_and_disable(struct v=
irtnet_info *vi,
> > >         }
> > >  }
> > >
> > > -static void sg_fill_dma(struct scatterlist *sg, dma_addr_t addr, u32=
 len)
> > > -{
> > > -       sg->dma_address =3D addr;
> > > -       sg->length =3D len;
> > > -}
> > > -
> > >  static struct xdp_buff *buf_to_xdp(struct virtnet_info *vi,
> > >                                    struct receive_queue *rq, void *bu=
f, u32 len)
> > >  {
> > > @@ -1354,7 +1353,8 @@ static int virtnet_add_recvbuf_xsk(struct virtn=
et_info *vi, struct receive_queue
> > >                 sg_init_table(rq->sg, 1);
> > >                 sg_fill_dma(rq->sg, addr, len);
> > >
> > > -               err =3D virtqueue_add_inbuf(rq->vq, rq->sg, 1, xsk_bu=
ffs[i], gfp);
> > > +               err =3D virtqueue_add_inbuf_premapped(rq->vq, rq->sg,=
 1, xsk_buffs[i],
> > > +                                                   NULL, true, gfp);
> > >                 if (err)
> > >                         goto err;
> > >         }
> > > @@ -2431,7 +2431,8 @@ static int add_recvbuf_small(struct virtnet_inf=
o *vi, struct receive_queue *rq,
> > >
> > >         virtnet_rq_init_one_sg(rq, buf, vi->hdr_len + GOOD_PACKET_LEN=
);
> > >
> > > -       err =3D virtqueue_add_inbuf_ctx(rq->vq, rq->sg, 1, buf, ctx, =
gfp);
> > > +       err =3D virtqueue_add_inbuf_premapped(rq->vq, rq->sg, 1, buf,=
 ctx,
> > > +                                           rq->do_dma, gfp);
> > >         if (err < 0) {
> > >                 if (rq->do_dma)
> > >                         virtnet_rq_unmap(rq, buf, 0);
> > > @@ -2546,7 +2547,8 @@ static int add_recvbuf_mergeable(struct virtnet=
_info *vi,
> > >         virtnet_rq_init_one_sg(rq, buf, len);
> > >
> > >         ctx =3D mergeable_len_to_ctx(len + room, headroom);
> > > -       err =3D virtqueue_add_inbuf_ctx(rq->vq, rq->sg, 1, buf, ctx, =
gfp);
> > > +       err =3D virtqueue_add_inbuf_premapped(rq->vq, rq->sg, 1, buf,=
 ctx,
> > > +                                           rq->do_dma, gfp);
> > >         if (err < 0) {
> > >                 if (rq->do_dma)
> > >                         virtnet_rq_unmap(rq, buf, 0);
> > > --
> > > 2.32.0.3.g01195cf9f
> > >
> >
>


