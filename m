Return-Path: <netdev+bounces-81166-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 139F58865F0
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 06:17:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE6AA2861E8
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 05:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A8979EF;
	Fri, 22 Mar 2024 05:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XNAsu1Tc"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E8DC121
	for <netdev@vger.kernel.org>; Fri, 22 Mar 2024 05:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711084640; cv=none; b=p0Oj5d7PHQv3RwIyptZXF92TZDZ457OOA6uNY7U5xXcjXEer5M482HwsxwD/aPkOe790C07o0AnpP5KVKmMq5hTogMhIXymEKirXLYj2C0fGo/Fujdv3JG+3faVjqq89ZXJYal/TIU1YPk7Ru7zvop/V8fwjgxoIWIIIW3v42fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711084640; c=relaxed/simple;
	bh=ksMsQriJy7IRL4y9XLhiW/MCK41EFERCpVJtkISGp+Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IwvCSrpgeJd4+nRjanqmq/PUaVx5iIQ3juzMPRRYTmx2v0flBlj+cy7cN/wZYEOJZCPrHzqMqPph4JLj1+PEYVGtcAariBpk95+nKUwE9r7XNZGPG53SrtvGf55cfyLZdK9QYuqNLnilkntaSdBcvQqOyXoFPYfvxiLgqOQ2Tnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XNAsu1Tc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711084637;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QfFoQH7hrDbd5mNJAnaiOz3NuJpDmTaZeZCQSI5NayU=;
	b=XNAsu1TclyHFWgrq1rqDwHRG4ov+M6J5l5wlr6JKdpC3RoicwVz6KhlAu9v05BqwP033xh
	cmPpVGyEH5ZTxxX1/L191aWOzP+I/nHWKyrtCzzCQGBQp16BHq5EmklNbCLn0CnzFx9w/a
	9fJ/BNMgQoTyzlw8wSopLLGiTeZnja8=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-64-QJWJOz2WOsGLWdGcW6wEzg-1; Fri, 22 Mar 2024 01:17:15 -0400
X-MC-Unique: QJWJOz2WOsGLWdGcW6wEzg-1
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-20494b09021so1879080fac.2
        for <netdev@vger.kernel.org>; Thu, 21 Mar 2024 22:17:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711084634; x=1711689434;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QfFoQH7hrDbd5mNJAnaiOz3NuJpDmTaZeZCQSI5NayU=;
        b=WXNSW2WC/uFcuFrBgWyWKc8OqQbac/fYyZE0uMabOYlYalSRtLk3AOe6KZWCrmIacP
         bRtzs8xhx8S9bGCIR0T63wOWi4Y88vDGzfnwCZpCQgPe0MgNsv9mbPto0o+hSomB4WjR
         dhJ6iNyvQGC0zxCj4HnSeWML+WsAQTYs4OAFfUXSzYHCmyW5vmdIhU8axg2iv8eCjYfZ
         Lq3qXCGHEop6I8+YWy+qVzq9o+osDvaOYpNwOho8ywV0Nu+AscL2/QJ6c17Y2WB9ZriW
         PkacBCklGxJgluBdxr6YI++kM4jCrTWxQGKajRtTvb8hMpScdVEjk4/fBW7tZWSfzinL
         lmag==
X-Forwarded-Encrypted: i=1; AJvYcCVyRwS0hapZvo7J6x3uZWRB+q5VvR07mshiue7g7TGsg67Nx6ymO+eC/OO69JxTGHAMfXslbVCqK9ZLLKeTLhso5LZiH5SM
X-Gm-Message-State: AOJu0YzHkg//TJEUY+IvDXeDAuOvZKlOO9hILCgphDjSSUodHeEI8H4G
	HWO4fEjE/KfpkeQRaqF6Gdx97mz1G7Q1ub3FlPTTGmK+VxiwPTEyCQPttO0QoRRcr/UKIiFSu/U
	lu7ZUioWnbRa14Z4o+JmEW0mFAQb6N1QGdvZ1KrLN1jbyyxb4SVY1BwWMp8jDXoU1suqXnbGRZ6
	tRI2YtjMJJOF3RBUsmicb1lVHvYXKfYkllFReg4kY=
X-Received: by 2002:a05:6871:409c:b0:221:3bb8:3e26 with SMTP id kz28-20020a056871409c00b002213bb83e26mr1353370oab.15.1711084634634;
        Thu, 21 Mar 2024 22:17:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGv0OEvxBJ8D6/aJnvQndb7n1SmvUR3pk7DseZxnLXMhr8CYLuvVc8aoMzVPtkp1FA9lfULVj+RXJJZLn6nfdo=
X-Received: by 2002:a05:6a20:430c:b0:1a3:6fb1:a350 with SMTP id
 h12-20020a056a20430c00b001a36fb1a350mr1917601pzk.29.1711084248368; Thu, 21
 Mar 2024 22:10:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240312033557.6351-1-xuanzhuo@linux.alibaba.com>
 <20240312033557.6351-3-xuanzhuo@linux.alibaba.com> <CACGkMEtd1L=Cm0DWLZbfSazxxHr+iPP77B1kM=PmjdqeYoAz4w@mail.gmail.com>
 <1711009209.0488706-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1711009209.0488706-2-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 22 Mar 2024 13:10:37 +0800
Message-ID: <CACGkMEvba5LmPj3CNTjOaXXOtXHu6iZKA4Xv=VhmUBBVUYerpQ@mail.gmail.com>
Subject: Re: [PATCH vhost v4 02/10] virtio_ring: packed: remove double check
 of the unmap ops
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 21, 2024 at 4:21=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> On Thu, 21 Mar 2024 13:57:06 +0800, Jason Wang <jasowang@redhat.com> wrot=
e:
> > On Tue, Mar 12, 2024 at 11:36=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alib=
aba.com> wrote:
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
> > > 1. only one desc of the desc table is used, we do not need the loop
> > > 2. the called unmap api is difference from the other desc
> > > 3. the vq->premapped is not needed to check
> > > 4. the vq->indirect is not needed to check
> > > 5. the state->indir_desc must not be null
> > >
> > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > ---
> > >  drivers/virtio/virtio_ring.c | 78 ++++++++++++++++++----------------=
--
> > >  1 file changed, 40 insertions(+), 38 deletions(-)
> > >
> > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_rin=
g.c
> > > index c2779e34aac7..0dfbd17e5a87 100644
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
> > >         state =3D &vq->packed.desc_state[id];
> > >
> > >         /* Clear data ptr. */
> > > @@ -1609,22 +1603,32 @@ static void detach_buf_packed(struct vring_vi=
rtqueue *vq,
> > >         vq->free_head =3D id;
> > >         vq->vq.num_free +=3D state->num;
> > >
> > > -       if (unlikely(vq->use_dma_api)) {
> > > -               curr =3D id;
> > > -               for (i =3D 0; i < state->num; i++) {
> > > -                       vring_unmap_extra_packed(vq,
> > > -                                                &vq->packed.desc_ext=
ra[curr]);
> > > -                       curr =3D vq->packed.desc_extra[curr].next;
> > > +       if (!(flags & VRING_DESC_F_INDIRECT)) {
> > > +               if (vring_need_unmap_buffer(vq)) {
> > > +                       curr =3D id;
> > > +                       for (i =3D 0; i < state->num; i++) {
> > > +                               vring_unmap_extra_packed(vq,
> > > +                                                        &vq->packed.=
desc_extra[curr]);
> > > +                               curr =3D vq->packed.desc_extra[curr].=
next;
> > > +                       }
> > >                 }
> > > -       }
> > >
> > > -       if (vq->indirect) {
> > > +               if (ctx)
> > > +                       *ctx =3D state->indir_desc;
> > > +       } else {
> > > +               const struct vring_desc_extra *extra;
> > >                 u32 len;
> > >
> > > +               if (vq->use_dma_api) {
> > > +                       extra =3D &vq->packed.desc_extra[id];
> > > +                       dma_unmap_single(vring_dma_dev(vq),
> > > +                                        extra->addr, extra->len,
> > > +                                        (flags & VRING_DESC_F_WRITE)=
 ?
> > > +                                        DMA_FROM_DEVICE : DMA_TO_DEV=
ICE);
> > > +               }
> >
> > Theoretically, indirect descriptors could be chained. It is supported
> > without this patch but not here.
>
>
> YES. But now, that is not supported by "add", so I think we
> do not need to think about it.
>
> Thanks.

Well, you need to at least document this somewhere (probably in the changlo=
g).

Thanks


