Return-Path: <netdev+bounces-82756-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0349D88F9BC
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 09:07:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A99382967B6
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 08:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EB4453E38;
	Thu, 28 Mar 2024 08:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EktZUZL5"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2CC2CCA0
	for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 08:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711613240; cv=none; b=uRdDtU+TcYLQB38njks07CYU4u0ABOGIpztZ7+UVYL7FtnscdgRM0vnb+FLECobebAZN6cGBxEZu2b7+RDEI920DM8wJb04WcaO1zNBSxdCZEuzlb206Zyol1ffrn5oZQ/CHAFTwjPmq2/1gX/JHOaSNcxsBkRQppEUuDnZ4B2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711613240; c=relaxed/simple;
	bh=SnQYyITY82g+iVsBt9rXx++DZFrHftku9eTiBvPnoOA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tcv2eSUq9FJE6ay0MisYBW+wvwlFJR9wAsoP0DYHrtDVbv8gniBZfBj0evrd8JBlroczxQj3+4hvDzPRExYOxaFD/yO1NGr6uEdb2INSVGVqVqZUgwS9xWWdE1QhA1Ro0c68Ea6Jg7HMLVOXojca9crACtv8/m/H2McOdK8UM2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EktZUZL5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711613237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qEZHJ4y5J1Lpz/eFC52k2ZqFoqQVRd3CejOyVl3Nxf8=;
	b=EktZUZL5Vxw+P2r3dpfpOJjTzm2XUYwoG5EFU2anW+zeeVSjU9rurZqeAyF7Wtd8lsT22C
	DzV3Lv/KABMU5zmAbVZ3B9UcpHYpS+/1Bfso/jq+ogOsOc6bOOgTdrW546Ht5eInXrJ2N6
	marF82sXRAQGNl9w20cSLues4fMAZbQ=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-PMRfRKs0O8KeVV4sORWwSw-1; Thu, 28 Mar 2024 04:07:16 -0400
X-MC-Unique: PMRfRKs0O8KeVV4sORWwSw-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-5d8dbe37d56so624697a12.0
        for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 01:07:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711613235; x=1712218035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qEZHJ4y5J1Lpz/eFC52k2ZqFoqQVRd3CejOyVl3Nxf8=;
        b=ho2sIw+02PbsQ1BvGe3vHtd05pufEqAPd6pqGieWbVN9itaj8dU8RbMYOsopJa/ZZN
         8SJ8CkoPfnsa2DxXy03cBJZmQCBlJ+rml6pIlwck3+d/k9vdZp9KcaJHSwNPMkyu8FMO
         5bkXWWCFJJ61/NjCC00oudZg28eErkhdPANjd6jswCYgO/mhh3suCwUTiHe3miHP7BM9
         dUtcBmr9hq1KGaY11kDnuNmAsuNebwrZyZVUGnHVV0vgx38+kLFkqdDbtf6fzFhtQ0uh
         x7DvJqpGHIeU1tpYwLVUzO5caqsgz5pzhVTuoNZpDBbkGmH89Y1w9wHw4jYtCCQLGq8U
         Yr/A==
X-Forwarded-Encrypted: i=1; AJvYcCU2EMF+BDfuogRAFlOGAnZar+OgVrgOol3Z0UjE/PYFZFFIkQQ/nsyZH+MJnoM16RlmInRWza0KbFytviGOPIcAt8Vjr0X2
X-Gm-Message-State: AOJu0Yw7/l/4AOTXZgPbwcfrIglVRy620ImFSZtYXafDakKVt7dgn0Ep
	w4FQ3jXR4N8PavXvu1EESLWjVZMPoR9X7mLXwOMswxlNis4o/H4hPj0MXTEN+dsnE4/hdadwUPz
	8wS8rkinxVxYbx/xfaPUp4wRehG4iziejnIjCxgl53OeBjjTFq0nyWsgFCRr9QK+UIirNvGYS/7
	J8tTQ4zZ5LJWp647owN7Mjsr/JWVPN
X-Received: by 2002:a05:6a20:158a:b0:1a3:afdc:fe5 with SMTP id h10-20020a056a20158a00b001a3afdc0fe5mr2402271pzj.42.1711613235157;
        Thu, 28 Mar 2024 01:07:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE65xmPdQZrPt7HyVfKxMGdjrymi0yAViFJIPE8Iy1Yfs5BYd/b/nkJ4EPbCQluBx/+LYEo8wdxh9da6yjU7tA=
X-Received: by 2002:a05:6a20:158a:b0:1a3:afdc:fe5 with SMTP id
 h10-20020a056a20158a00b001a3afdc0fe5mr2402252pzj.42.1711613234823; Thu, 28
 Mar 2024 01:07:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327111430.108787-1-xuanzhuo@linux.alibaba.com>
 <20240327111430.108787-4-xuanzhuo@linux.alibaba.com> <CACGkMEvGTiZUepzRL9dMNaxZUenKzrqPnnd9594aWjF-KcXCrw@mail.gmail.com>
 <1711611393.0808053-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1711611393.0808053-2-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 28 Mar 2024 16:07:03 +0800
Message-ID: <CACGkMEsrB_vjUqMXvAZyLxGz4QtMky5wn8ozf-+w9eXn7agTSQ@mail.gmail.com>
Subject: Re: [PATCH vhost v6 03/10] virtio_ring: packed: structure the
 indirect desc table
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 3:38=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> On Thu, 28 Mar 2024 14:56:55 +0800, Jason Wang <jasowang@redhat.com> wrot=
e:
> > On Wed, Mar 27, 2024 at 7:14=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.aliba=
ba.com> wrote:
> > >
> > > This commit structure the indirect desc table.
> > > Then we can get the desc num directly when doing unmap.
> > >
> > > And save the dma info to the struct, then the indirect
> > > will not use the dma fields of the desc_extra. The subsequent
> > > commits will make the dma fields are optional.
> >
> > Nit: It's better to add something like "so we can't reuse the
> > desc_extra[] array"
> >
> > > But for
> > > the indirect case, we must record the dma info.
> > >
> > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > ---
> > >  drivers/virtio/virtio_ring.c | 61 +++++++++++++++++++---------------=
--
> > >  1 file changed, 33 insertions(+), 28 deletions(-)
> > >
> > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_rin=
g.c
> > > index a2838fe1cc08..e3343cf55774 100644
> > > --- a/drivers/virtio/virtio_ring.c
> > > +++ b/drivers/virtio/virtio_ring.c
> > > @@ -74,7 +74,7 @@ struct vring_desc_state_split {
> > >
> > >  struct vring_desc_state_packed {
> > >         void *data;                     /* Data for callback. */
> > > -       struct vring_packed_desc *indir_desc; /* Indirect descriptor,=
 if any. */
> > > +       struct vring_desc_extra *indir_desc; /* Indirect descriptor, =
if any. */
> >
> > Should be "DMA info with indirect descriptor, if any" ?
> >
> > >         u16 num;                        /* Descriptor list length. */
> > >         u16 last;                       /* The last desc state in a l=
ist. */
> > >  };
> > > @@ -1243,10 +1243,13 @@ static void vring_unmap_desc_packed(const str=
uct vring_virtqueue *vq,
> > >                        DMA_FROM_DEVICE : DMA_TO_DEVICE);
> > >  }
> > >
> > > -static struct vring_packed_desc *alloc_indirect_packed(unsigned int =
total_sg,
> > > -                                                      gfp_t gfp)
> > > +static struct vring_desc_extra *alloc_indirect_packed(unsigned int t=
otal_sg,
> > > +                                                     gfp_t gfp)
> > >  {
> > > -       struct vring_packed_desc *desc;
> > > +       struct vring_desc_extra *in_extra;
> > > +       u32 size;
> > > +
> > > +       size =3D sizeof(*in_extra) + sizeof(struct vring_packed_desc)=
 * total_sg;
> > >
> > >         /*
> > >          * We require lowmem mappings for the descriptors because
> > > @@ -1255,9 +1258,10 @@ static struct vring_packed_desc *alloc_indirec=
t_packed(unsigned int total_sg,
> > >          */
> > >         gfp &=3D ~__GFP_HIGHMEM;
> > >
> > > -       desc =3D kmalloc_array(total_sg, sizeof(struct vring_packed_d=
esc), gfp);
> > >
> > > -       return desc;
> > > +       in_extra =3D kmalloc(size, gfp);
> > > +
> > > +       return in_extra;
> > >  }
> > >
> > >  static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
> > > @@ -1268,6 +1272,7 @@ static int virtqueue_add_indirect_packed(struct=
 vring_virtqueue *vq,
> > >                                          void *data,
> > >                                          gfp_t gfp)
> > >  {
> > > +       struct vring_desc_extra *in_extra;
> > >         struct vring_packed_desc *desc;
> > >         struct scatterlist *sg;
> > >         unsigned int i, n, err_idx;
> > > @@ -1275,10 +1280,12 @@ static int virtqueue_add_indirect_packed(stru=
ct vring_virtqueue *vq,
> > >         dma_addr_t addr;
> > >
> > >         head =3D vq->packed.next_avail_idx;
> > > -       desc =3D alloc_indirect_packed(total_sg, gfp);
> > > -       if (!desc)
> > > +       in_extra =3D alloc_indirect_packed(total_sg, gfp);
> > > +       if (!in_extra)
> > >                 return -ENOMEM;
> > >
> > > +       desc =3D (struct vring_packed_desc *)(in_extra + 1);
> > > +
> > >         if (unlikely(vq->vq.num_free < 1)) {
> > >                 pr_debug("Can't add buf len 1 - avail =3D 0\n");
> > >                 kfree(desc);
> > > @@ -1315,17 +1322,16 @@ static int virtqueue_add_indirect_packed(stru=
ct vring_virtqueue *vq,
> > >                 goto unmap_release;
> > >         }
> > >
> > > +       if (vq->use_dma_api) {
> > > +               in_extra->addr =3D addr;
> > > +               in_extra->len =3D total_sg * sizeof(struct vring_pack=
ed_desc);
> > > +       }
> >
> > Any reason why we don't do it after the below assignment of descriptor =
fields?
> >
> > > +
> > >         vq->packed.vring.desc[head].addr =3D cpu_to_le64(addr);
> > >         vq->packed.vring.desc[head].len =3D cpu_to_le32(total_sg *
> > >                                 sizeof(struct vring_packed_desc));
> > >         vq->packed.vring.desc[head].id =3D cpu_to_le16(id);
> > >
> > > -       if (vq->use_dma_api) {
> > > -               vq->packed.desc_extra[id].addr =3D addr;
> > > -               vq->packed.desc_extra[id].len =3D total_sg *
> > > -                               sizeof(struct vring_packed_desc);
> > > -       }
> > > -
> > >         vq->packed.desc_extra[id].flags =3D VRING_DESC_F_INDIRECT |
> > >                 vq->packed.avail_used_flags;
> > >
> > > @@ -1356,7 +1362,7 @@ static int virtqueue_add_indirect_packed(struct=
 vring_virtqueue *vq,
> > >         /* Store token and indirect buffer state. */
> > >         vq->packed.desc_state[id].num =3D 1;
> > >         vq->packed.desc_state[id].data =3D data;
> > > -       vq->packed.desc_state[id].indir_desc =3D desc;
> > > +       vq->packed.desc_state[id].indir_desc =3D in_extra;
> > >         vq->packed.desc_state[id].last =3D id;
> > >
> > >         vq->num_added +=3D 1;
> > > @@ -1375,7 +1381,7 @@ static int virtqueue_add_indirect_packed(struct=
 vring_virtqueue *vq,
> > >                 vring_unmap_desc_packed(vq, &desc[i]);
> > >
> > >  free_desc:
> > > -       kfree(desc);
> > > +       kfree(in_extra);
> > >
> > >         END_USE(vq);
> > >         return -ENOMEM;
> > > @@ -1589,7 +1595,6 @@ static void detach_buf_packed(struct vring_virt=
queue *vq,
> > >                               unsigned int id, void **ctx)
> > >  {
> > >         struct vring_desc_state_packed *state =3D NULL;
> > > -       struct vring_packed_desc *desc;
> > >         unsigned int i, curr;
> > >         u16 flags;
> > >
> > > @@ -1616,27 +1621,27 @@ static void detach_buf_packed(struct vring_vi=
rtqueue *vq,
> > >                 if (ctx)
> > >                         *ctx =3D state->indir_desc;
> > >         } else {
> > > -               const struct vring_desc_extra *extra;
> > > -               u32 len;
> > > +               struct vring_desc_extra *in_extra;
> > > +               struct vring_packed_desc *desc;
> > > +               u32 num;
> > > +
> > > +               in_extra =3D state->indir_desc;
> > >
> > >                 if (vq->use_dma_api) {
> > > -                       extra =3D &vq->packed.desc_extra[id];
> > >                         dma_unmap_single(vring_dma_dev(vq),
> > > -                                        extra->addr, extra->len,
> > > +                                        in_extra->addr, in_extra->le=
n,
> > >                                          (flags & VRING_DESC_F_WRITE)=
 ?
> > >                                          DMA_FROM_DEVICE : DMA_TO_DEV=
ICE);
> >
> > Can't we just reuse vring_unmap_extra_packed() here?
>
> vring_unmap_extra_packed calls dma_unmap_page.
> Here needs dma_unmap_single.
>
> You mean we call dma_unmap_page directly.

Nope, I meant having a helper for this.

Thanks


>
> Thanks.
>
> >
> > Thanks
> >
> >
> > >                 }
> > >
> > > -               /* Free the indirect table, if any, now that it's unm=
apped. */
> > > -               desc =3D state->indir_desc;
> > > -
> > >                 if (vring_need_unmap_buffer(vq)) {
> > > -                       len =3D vq->packed.desc_extra[id].len;
> > > -                       for (i =3D 0; i < len / sizeof(struct vring_p=
acked_desc);
> > > -                                       i++)
> > > +                       num =3D in_extra->len / sizeof(struct vring_p=
acked_desc);
> > > +                       desc =3D (struct vring_packed_desc *)(in_extr=
a + 1);
> > > +
> > > +                       for (i =3D 0; i < num; i++)
> > >                                 vring_unmap_desc_packed(vq, &desc[i])=
;
> > >                 }
> > > -               kfree(desc);
> > > +               kfree(in_extra);
> > >                 state->indir_desc =3D NULL;
> > >         }
> > >  }
> > > --
> > > 2.32.0.3.g01195cf9f
> > >
> >
>


