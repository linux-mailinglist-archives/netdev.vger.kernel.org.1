Return-Path: <netdev+bounces-82747-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E003588F8E4
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 08:38:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FF4EB24E16
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 07:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BA0C4086A;
	Thu, 28 Mar 2024 07:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="w6H+RVsK"
X-Original-To: netdev@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8155C39FC6
	for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 07:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711611483; cv=none; b=jFNaeQWlC5zBpMHdVvuwAgIJv5vA/soJodhAsd2ZiZDXMYvBDd2Tku+96xpp/AYqN+rg1v9vz0Gmnuz0PpaL4zDUWrvlKThZHjUbXRhLnFdKvQXqn0X31omPvEV0cbHsGE6LaRiOUkRGoSIdb97gmUxtdEZp/fUjd6aCgepWhCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711611483; c=relaxed/simple;
	bh=Jla3slRc4P8od91/pZc3s+BBoI4ESENWZ5tYTQkyJBU=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=UzF8OsG9awjp3onJblwAjUw/Oqc1EH8EVaK/cv04VdkgbuARuyR/F+jem81pqRRTZRdo7qzdcrQG/RFFdzAcuObGGAcFWYWclYmNYLXbv6oCfetpVemRNJl55GMVXqZT/x54LAesQcORv3YcsK1vfU9RgSigFJtx37b7JSs8QlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=w6H+RVsK; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711611478; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=VwXafepT0aMMhy5NzW7ic7Zg72Wm47lRCmVfEeNBsxA=;
	b=w6H+RVsKqC8FiR2yEuk+9xhIKys1rOd5IMU5yxI+fsQTgEhF9FhPLMBOk49JwHjTI4M7pHsD/GxopbiLAu6QIjFH2LGTSAU7U0n7+Zhc4Q4cPL0aQ4WvrQdysbHR50H8gbclLLKdHDms4448u+i9zd/74kyN8lhZ3SKYhNAwTR0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0W3SbyNm_1711611476;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W3SbyNm_1711611476)
          by smtp.aliyun-inc.com;
          Thu, 28 Mar 2024 15:37:57 +0800
Message-ID: <1711611393.0808053-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v6 03/10] virtio_ring: packed: structure the indirect desc table
Date: Thu, 28 Mar 2024 15:36:33 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
Cc: virtualization@lists.linux.dev,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org
References: <20240327111430.108787-1-xuanzhuo@linux.alibaba.com>
 <20240327111430.108787-4-xuanzhuo@linux.alibaba.com>
 <CACGkMEvGTiZUepzRL9dMNaxZUenKzrqPnnd9594aWjF-KcXCrw@mail.gmail.com>
In-Reply-To: <CACGkMEvGTiZUepzRL9dMNaxZUenKzrqPnnd9594aWjF-KcXCrw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Thu, 28 Mar 2024 14:56:55 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Wed, Mar 27, 2024 at 7:14=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba=
.com> wrote:
> >
> > This commit structure the indirect desc table.
> > Then we can get the desc num directly when doing unmap.
> >
> > And save the dma info to the struct, then the indirect
> > will not use the dma fields of the desc_extra. The subsequent
> > commits will make the dma fields are optional.
>
> Nit: It's better to add something like "so we can't reuse the
> desc_extra[] array"
>
> > But for
> > the indirect case, we must record the dma info.
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >  drivers/virtio/virtio_ring.c | 61 +++++++++++++++++++-----------------
> >  1 file changed, 33 insertions(+), 28 deletions(-)
> >
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index a2838fe1cc08..e3343cf55774 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -74,7 +74,7 @@ struct vring_desc_state_split {
> >
> >  struct vring_desc_state_packed {
> >         void *data;                     /* Data for callback. */
> > -       struct vring_packed_desc *indir_desc; /* Indirect descriptor, i=
f any. */
> > +       struct vring_desc_extra *indir_desc; /* Indirect descriptor, if=
 any. */
>
> Should be "DMA info with indirect descriptor, if any" ?
>
> >         u16 num;                        /* Descriptor list length. */
> >         u16 last;                       /* The last desc state in a lis=
t. */
> >  };
> > @@ -1243,10 +1243,13 @@ static void vring_unmap_desc_packed(const struc=
t vring_virtqueue *vq,
> >                        DMA_FROM_DEVICE : DMA_TO_DEVICE);
> >  }
> >
> > -static struct vring_packed_desc *alloc_indirect_packed(unsigned int to=
tal_sg,
> > -                                                      gfp_t gfp)
> > +static struct vring_desc_extra *alloc_indirect_packed(unsigned int tot=
al_sg,
> > +                                                     gfp_t gfp)
> >  {
> > -       struct vring_packed_desc *desc;
> > +       struct vring_desc_extra *in_extra;
> > +       u32 size;
> > +
> > +       size =3D sizeof(*in_extra) + sizeof(struct vring_packed_desc) *=
 total_sg;
> >
> >         /*
> >          * We require lowmem mappings for the descriptors because
> > @@ -1255,9 +1258,10 @@ static struct vring_packed_desc *alloc_indirect_=
packed(unsigned int total_sg,
> >          */
> >         gfp &=3D ~__GFP_HIGHMEM;
> >
> > -       desc =3D kmalloc_array(total_sg, sizeof(struct vring_packed_des=
c), gfp);
> >
> > -       return desc;
> > +       in_extra =3D kmalloc(size, gfp);
> > +
> > +       return in_extra;
> >  }
> >
> >  static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
> > @@ -1268,6 +1272,7 @@ static int virtqueue_add_indirect_packed(struct v=
ring_virtqueue *vq,
> >                                          void *data,
> >                                          gfp_t gfp)
> >  {
> > +       struct vring_desc_extra *in_extra;
> >         struct vring_packed_desc *desc;
> >         struct scatterlist *sg;
> >         unsigned int i, n, err_idx;
> > @@ -1275,10 +1280,12 @@ static int virtqueue_add_indirect_packed(struct=
 vring_virtqueue *vq,
> >         dma_addr_t addr;
> >
> >         head =3D vq->packed.next_avail_idx;
> > -       desc =3D alloc_indirect_packed(total_sg, gfp);
> > -       if (!desc)
> > +       in_extra =3D alloc_indirect_packed(total_sg, gfp);
> > +       if (!in_extra)
> >                 return -ENOMEM;
> >
> > +       desc =3D (struct vring_packed_desc *)(in_extra + 1);
> > +
> >         if (unlikely(vq->vq.num_free < 1)) {
> >                 pr_debug("Can't add buf len 1 - avail =3D 0\n");
> >                 kfree(desc);
> > @@ -1315,17 +1322,16 @@ static int virtqueue_add_indirect_packed(struct=
 vring_virtqueue *vq,
> >                 goto unmap_release;
> >         }
> >
> > +       if (vq->use_dma_api) {
> > +               in_extra->addr =3D addr;
> > +               in_extra->len =3D total_sg * sizeof(struct vring_packed=
_desc);
> > +       }
>
> Any reason why we don't do it after the below assignment of descriptor fi=
elds?
>
> > +
> >         vq->packed.vring.desc[head].addr =3D cpu_to_le64(addr);
> >         vq->packed.vring.desc[head].len =3D cpu_to_le32(total_sg *
> >                                 sizeof(struct vring_packed_desc));
> >         vq->packed.vring.desc[head].id =3D cpu_to_le16(id);
> >
> > -       if (vq->use_dma_api) {
> > -               vq->packed.desc_extra[id].addr =3D addr;
> > -               vq->packed.desc_extra[id].len =3D total_sg *
> > -                               sizeof(struct vring_packed_desc);
> > -       }
> > -
> >         vq->packed.desc_extra[id].flags =3D VRING_DESC_F_INDIRECT |
> >                 vq->packed.avail_used_flags;
> >
> > @@ -1356,7 +1362,7 @@ static int virtqueue_add_indirect_packed(struct v=
ring_virtqueue *vq,
> >         /* Store token and indirect buffer state. */
> >         vq->packed.desc_state[id].num =3D 1;
> >         vq->packed.desc_state[id].data =3D data;
> > -       vq->packed.desc_state[id].indir_desc =3D desc;
> > +       vq->packed.desc_state[id].indir_desc =3D in_extra;
> >         vq->packed.desc_state[id].last =3D id;
> >
> >         vq->num_added +=3D 1;
> > @@ -1375,7 +1381,7 @@ static int virtqueue_add_indirect_packed(struct v=
ring_virtqueue *vq,
> >                 vring_unmap_desc_packed(vq, &desc[i]);
> >
> >  free_desc:
> > -       kfree(desc);
> > +       kfree(in_extra);
> >
> >         END_USE(vq);
> >         return -ENOMEM;
> > @@ -1589,7 +1595,6 @@ static void detach_buf_packed(struct vring_virtqu=
eue *vq,
> >                               unsigned int id, void **ctx)
> >  {
> >         struct vring_desc_state_packed *state =3D NULL;
> > -       struct vring_packed_desc *desc;
> >         unsigned int i, curr;
> >         u16 flags;
> >
> > @@ -1616,27 +1621,27 @@ static void detach_buf_packed(struct vring_virt=
queue *vq,
> >                 if (ctx)
> >                         *ctx =3D state->indir_desc;
> >         } else {
> > -               const struct vring_desc_extra *extra;
> > -               u32 len;
> > +               struct vring_desc_extra *in_extra;
> > +               struct vring_packed_desc *desc;
> > +               u32 num;
> > +
> > +               in_extra =3D state->indir_desc;
> >
> >                 if (vq->use_dma_api) {
> > -                       extra =3D &vq->packed.desc_extra[id];
> >                         dma_unmap_single(vring_dma_dev(vq),
> > -                                        extra->addr, extra->len,
> > +                                        in_extra->addr, in_extra->len,
> >                                          (flags & VRING_DESC_F_WRITE) ?
> >                                          DMA_FROM_DEVICE : DMA_TO_DEVIC=
E);
>
> Can't we just reuse vring_unmap_extra_packed() here?

vring_unmap_extra_packed calls dma_unmap_page.
Here needs dma_unmap_single.

You mean we call dma_unmap_page directly.

Thanks.

>
> Thanks
>
>
> >                 }
> >
> > -               /* Free the indirect table, if any, now that it's unmap=
ped. */
> > -               desc =3D state->indir_desc;
> > -
> >                 if (vring_need_unmap_buffer(vq)) {
> > -                       len =3D vq->packed.desc_extra[id].len;
> > -                       for (i =3D 0; i < len / sizeof(struct vring_pac=
ked_desc);
> > -                                       i++)
> > +                       num =3D in_extra->len / sizeof(struct vring_pac=
ked_desc);
> > +                       desc =3D (struct vring_packed_desc *)(in_extra =
+ 1);
> > +
> > +                       for (i =3D 0; i < num; i++)
> >                                 vring_unmap_desc_packed(vq, &desc[i]);
> >                 }
> > -               kfree(desc);
> > +               kfree(in_extra);
> >                 state->indir_desc =3D NULL;
> >         }
> >  }
> > --
> > 2.32.0.3.g01195cf9f
> >
>

