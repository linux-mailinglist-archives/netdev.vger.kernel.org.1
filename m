Return-Path: <netdev+bounces-82757-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3AA088F9BD
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 09:07:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8A5629694C
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 08:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2779B53E38;
	Thu, 28 Mar 2024 08:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ej4wLBnx"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A0142A91
	for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 08:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711613252; cv=none; b=cQkAq1hM5Xp0ddauksyS1S198KiBmiVfUzo3Bt2Upl5TjWW6mPSI5ikDUP/GlSn/REKNLArV0XDQT5X4o7iIGwV0XlitFRVoWd2mItKRWanquNgYt8Q9rwtcAx5v7fwrKSZYKb0qeIsMDtl38hN4jjwypHgHyKPqlW7rStLZR18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711613252; c=relaxed/simple;
	bh=jfBJjlxoImfYC5NQEMtRLXxCTKPHK3fIzkbLFVSZV1E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S02ijJnCZxdBIObQ2X0ebzyycQt4y62o1m3SB6/01oFKgP2UeKXms1UBhPHLPcgVDwgJxd94tvBOseaZUvnzO70Mfsts+Zzp2aKG3OSZx+yA1ud00GSKUFkNh2AvgQLBegap1DyFD0npX24+lQqVi6Z1OXtJHgPrxJeYNmm1484=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ej4wLBnx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711613249;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DyOU6klI23x/Thnn0Wgm0BDrMfkf6wwkH2HTMn9ZCXQ=;
	b=Ej4wLBnxvO7Xu+nFGBAiZga6HCVgbsXtGSLom0rELrOyEdgeEU+wXcDW+tWERXQGSBLs5f
	MdvRRsNxaEWtpxhFeVJ4QpIxPHZFgZ62DB2/rl1o1y/wIxFM6xSvs78g+SoUomBOAR0Kkm
	YxVZx5M4mT6oUCiP0GZPq0GVz1MCXj8=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-E2xrstSlNBqHoId3FW8g2w-1; Thu, 28 Mar 2024 04:07:27 -0400
X-MC-Unique: E2xrstSlNBqHoId3FW8g2w-1
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-6e6a7798bfdso416808b3a.3
        for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 01:07:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711613246; x=1712218046;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DyOU6klI23x/Thnn0Wgm0BDrMfkf6wwkH2HTMn9ZCXQ=;
        b=FmSQuemBOSQ130Ed6488kfOApgWAxQvPCe8GwYzyUxPIJodH/ydbJi1Zbc/keYxgiz
         Wu5ulJk1EM5dv15FM3dj+dCGRJjHr90MCrrd+s/sY+CvIf64Ous2fhc4ndtRy7kYdZNg
         k/z7dpwRTL+l9J4FFZKLWV0mcVXsQfgJbUalVMpg3sRlGBwAZhlVj4TtFQ0vbOhDhddH
         zeaaT9mKA2pdU8wsAoZ/dTZ8t2Db4NPkzQzB2xYqT/KMe2REjbrhNDPA/ecPI0MSc78v
         rBPg5cHSJpxvOFN6OCkbQ28VuQdmd4l5vVzjMX4JsMl7EMSv0eT7iRnEpDtYP3uulIgE
         wwoA==
X-Forwarded-Encrypted: i=1; AJvYcCWi9Uikw+7R/XF2XmmzUu11xYP3KkAABa6f52cZ7zzcFAQZpRZ0b7UjhIn5hJuCzhDkNljuwRfdgb0/UYUjGDhFANFBSLfv
X-Gm-Message-State: AOJu0YzvgOrcJ5Ug+fANdGnBdMuLpw4I0TtXWevO3ndmK1TTy+OWwl4c
	8693YLfGy9p1zvDtnDYZx9wBg7kHqxP4dJRyCpVysU+wKztIXSQQ1Slav0CzC5BqMv/SjExbc1X
	KlClqDLiWMQMg1YSYmfeyc3SHpMQsktJdKFzUw0ZLMDeIox8Df1I5keLvmE42HyAuOJM5ITCw4G
	2Fw1SIAK1Uv4MMz0+xcZU9xAYydNls
X-Received: by 2002:a05:6a20:9f96:b0:1a3:f40:6d32 with SMTP id mm22-20020a056a209f9600b001a30f406d32mr2447049pzb.58.1711613246331;
        Thu, 28 Mar 2024 01:07:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGugk+tv3TGzI8RpZ6xoyGHDCLKInwiTL6qHEHvfJySfWLCGAkMH5aNUq7vVvso+PEstS6QoNDsBlL8XdweU+Y=
X-Received: by 2002:a05:6a20:9f96:b0:1a3:f40:6d32 with SMTP id
 mm22-20020a056a209f9600b001a30f406d32mr2447022pzb.58.1711613245967; Thu, 28
 Mar 2024 01:07:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327111430.108787-1-xuanzhuo@linux.alibaba.com>
 <20240327111430.108787-3-xuanzhuo@linux.alibaba.com> <CACGkMEsG7+mNx4WqhAuhrpk1bhLEwrTzngT5q=CZ_aHkzRasVg@mail.gmail.com>
 <1711610846.0120149-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1711610846.0120149-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 28 Mar 2024 16:07:14 +0800
Message-ID: <CACGkMEstpEfrnsuLwE2AaceXDzE97kOCu9ukMAeX0O80k9xTUw@mail.gmail.com>
Subject: Re: [PATCH vhost v6 02/10] virtio_ring: packed: remove double check
 of the unmap ops
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 3:32=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> On Thu, 28 Mar 2024 14:56:47 +0800, Jason Wang <jasowang@redhat.com> wrot=
e:
> > On Wed, Mar 27, 2024 at 7:14=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.aliba=
ba.com> wrote:
> > >
> > > In the functions vring_unmap_extra_packed and vring_unmap_desc_packed=
,
> > > multiple checks are made whether unmap is performed and whether it is
> > > INDIRECT.
> > >
> > > These two functions are usually called in a loop, and we should put t=
he
> > > check outside the loop.
> > >
> > > And we unmap the descs with VRING_DESC_F_INDIRECT on the same path wi=
th
> > > other descs, that make the thing more complex. If we distinguish the
> > > descs with VRING_DESC_F_INDIRECT before unmap, thing will be clearer.
> > >
> > > For desc with VRING_DESC_F_INDIRECT flag:
> > > 1. only one desc of the desc table is used, we do not need the loop
> > >     Theoretically, indirect descriptors could be chained.
> > >     But now, that is not supported by "add", so we ignore this case.
> > > 2. the called unmap api is difference from the other desc
> > > 3. the vq->premapped is not needed to check
> > > 4. the vq->indirect is not needed to check
> > > 5. the state->indir_desc must not be null
> >
> > It doesn't explain the connection to the goal of this series. If it's
> > not a must I'd suggest moving it to a separate patch.
>
>
> The "no store dma ..." depends this.
>
> I will add this message in next version.
>
>
> >
> > >
> > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> >
> > Rethink this, it looks to me it would complicate the codes furtherly.
> >
> > For example, vring_map_xxx() helpers will check premappred and
> > use_dma_api by itself. But in the case of vring_unmap() you want to
> > move those checks to the caller. This will result in tricky codes that
> > are hard to understand.
> >
> > We need to be consistent here.
> >
> > If we try to optimize unmap we need to optimize map as well. But
> > generally it would complicate the logic of the caller if we want to
> > let the caller to differ. Ideally, the caller of those function should
> > know nothing about use_dma_api, premapped and other.
>
>
> The key is that we can check "use_dma_api, premapped" to skip the loop.
> If the vring_unmap_xxx is called, the "use_dma_api, premapped" is checked=
 in
> advance, so that is a waste to check thest again.

Right, but we have the same logic for map.

>
>
> >
> > > ---
> > >  drivers/virtio/virtio_ring.c | 78 ++++++++++++++++++----------------=
--
> > >  1 file changed, 40 insertions(+), 38 deletions(-)
> > >
> > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_rin=
g.c
> > > index 03360073bd4a..a2838fe1cc08 100644
> > > --- a/drivers/virtio/virtio_ring.c
> > > +++ b/drivers/virtio/virtio_ring.c
> > > @@ -1214,6 +1214,7 @@ static u16 packed_last_used(u16 last_used_idx)
> > >         return last_used_idx & ~(-(1 << VRING_PACKED_EVENT_F_WRAP_CTR=
));
> > >  }
> > >
> > > +/* caller must check vring_need_unmap_buffer() */
> > >  static void vring_unmap_extra_packed(const struct vring_virtqueue *v=
q,
> > >                                      const struct vring_desc_extra *e=
xtra)
> > >  {
> > > @@ -1221,33 +1222,18 @@ static void vring_unmap_extra_packed(const st=
ruct vring_virtqueue *vq,
> > >
> > >         flags =3D extra->flags;
> > >
> > > -       if (flags & VRING_DESC_F_INDIRECT) {
> > > -               if (!vq->use_dma_api)
> > > -                       return;
> > > -
> > > -               dma_unmap_single(vring_dma_dev(vq),
> > > -                                extra->addr, extra->len,
> > > -                                (flags & VRING_DESC_F_WRITE) ?
> > > -                                DMA_FROM_DEVICE : DMA_TO_DEVICE);
> > > -       } else {
> > > -               if (!vring_need_unmap_buffer(vq))
> > > -                       return;
> > > -
> > > -               dma_unmap_page(vring_dma_dev(vq),
> > > -                              extra->addr, extra->len,
> > > -                              (flags & VRING_DESC_F_WRITE) ?
> > > -                              DMA_FROM_DEVICE : DMA_TO_DEVICE);
> > > -       }
> > > +       dma_unmap_page(vring_dma_dev(vq),
> > > +                      extra->addr, extra->len,
> > > +                      (flags & VRING_DESC_F_WRITE) ?
> > > +                      DMA_FROM_DEVICE : DMA_TO_DEVICE);
> > >  }
> > >
> > > +/* caller must check vring_need_unmap_buffer() */
> > >  static void vring_unmap_desc_packed(const struct vring_virtqueue *vq=
,
> > >                                     const struct vring_packed_desc *d=
esc)
> > >  {
> > >         u16 flags;
> > >
> > > -       if (!vring_need_unmap_buffer(vq))
> > > -               return;
> > > -
> > >         flags =3D le16_to_cpu(desc->flags);
> > >
> > >         dma_unmap_page(vring_dma_dev(vq),
> > > @@ -1323,7 +1309,7 @@ static int virtqueue_add_indirect_packed(struct=
 vring_virtqueue *vq,
> > >                         total_sg * sizeof(struct vring_packed_desc),
> > >                         DMA_TO_DEVICE);
> > >         if (vring_mapping_error(vq, addr)) {
> > > -               if (vq->premapped)
> > > +               if (!vring_need_unmap_buffer(vq))
> > >                         goto free_desc;
> >
> > I would do this to make it much more easier to be read and avoid the wa=
rn:
> >
> > if (vring_mapping_error(vq, addr))
> >         goto unmap_release;
> >
> > unmap_release:
> >         if (vring_need_unmap_buffer(vq))
> >                 for (i =3D 0, xxx)
> > free_desc:
> >         kfree(desc);
> >
> > or it could be
> >
> > unmap_release:
> >       if (!vring_need_unmap_buffer(vq))
> >             goto free_desc;
> >
> > Still tricky but better.
>
> I am ok.
>
>
> >
> > >
> > >                 goto unmap_release;
> > > @@ -1338,10 +1324,11 @@ static int virtqueue_add_indirect_packed(stru=
ct vring_virtqueue *vq,
> > >                 vq->packed.desc_extra[id].addr =3D addr;
> > >                 vq->packed.desc_extra[id].len =3D total_sg *
> > >                                 sizeof(struct vring_packed_desc);
> > > -               vq->packed.desc_extra[id].flags =3D VRING_DESC_F_INDI=
RECT |
> > > -                                                 vq->packed.avail_us=
ed_flags;
> > >         }
> > >
> > > +       vq->packed.desc_extra[id].flags =3D VRING_DESC_F_INDIRECT |
> > > +               vq->packed.avail_used_flags;
> >
> > An example of the tricky code, I think you do this because you want to
> > differ indirect in detach_buf_packed():
> >
> > flags =3D vq->packed.desc_extra[id].flags;
> >
> >
> > > +
> > >         /*
> > >          * A driver MUST NOT make the first descriptor in the list
> > >          * available before all subsequent descriptors comprising
> > > @@ -1382,6 +1369,8 @@ static int virtqueue_add_indirect_packed(struct=
 vring_virtqueue *vq,
> > >  unmap_release:
> > >         err_idx =3D i;
> > >
> > > +       WARN_ON(!vring_need_unmap_buffer(vq));
> > > +
> > >         for (i =3D 0; i < err_idx; i++)
> > >                 vring_unmap_desc_packed(vq, &desc[i]);
> > >
> > > @@ -1475,12 +1464,13 @@ static inline int virtqueue_add_packed(struct=
 virtqueue *_vq,
> > >                         desc[i].len =3D cpu_to_le32(sg->length);
> > >                         desc[i].id =3D cpu_to_le16(id);
> > >
> > > -                       if (unlikely(vq->use_dma_api)) {
> > > +                       if (vring_need_unmap_buffer(vq)) {
> > >                                 vq->packed.desc_extra[curr].addr =3D =
addr;
> > >                                 vq->packed.desc_extra[curr].len =3D s=
g->length;
> > > -                               vq->packed.desc_extra[curr].flags =3D
> > > -                                       le16_to_cpu(flags);
> > >                         }
> > > +
> > > +                       vq->packed.desc_extra[curr].flags =3D le16_to=
_cpu(flags);
> > > +
> > >                         prev =3D curr;
> > >                         curr =3D vq->packed.desc_extra[curr].next;
> > >
> > > @@ -1530,6 +1520,8 @@ static inline int virtqueue_add_packed(struct v=
irtqueue *_vq,
> > >
> > >         vq->packed.avail_used_flags =3D avail_used_flags;
> > >
> > > +       WARN_ON(!vring_need_unmap_buffer(vq));
> > > +
> > >         for (n =3D 0; n < total_sg; n++) {
> > >                 if (i =3D=3D err_idx)
> > >                         break;
> > > @@ -1599,7 +1591,9 @@ static void detach_buf_packed(struct vring_virt=
queue *vq,
> > >         struct vring_desc_state_packed *state =3D NULL;
> > >         struct vring_packed_desc *desc;
> > >         unsigned int i, curr;
> > > +       u16 flags;
> > >
> > > +       flags =3D vq->packed.desc_extra[id].flags;
> >
> > Can we check vq->indirect && indir_desc here? Then we don't need
> > special care to store flags in desc_extra.
>
>
> No.
>
> When vq->indirect is true, but the desc may has not indirect flag.

But we check indir_desc as well?

        vq->indirect =3D virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DE=
SC) &&
                !cfg_vq_get(cfg, vq, ctx);

Thanks


