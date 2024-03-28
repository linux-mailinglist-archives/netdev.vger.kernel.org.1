Return-Path: <netdev+bounces-82750-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C2DB688F8FD
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 08:43:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27E5DB25CFF
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 07:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC7F839FC6;
	Thu, 28 Mar 2024 07:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ISQEQucp"
X-Original-To: netdev@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190DF4EB29
	for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 07:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711611742; cv=none; b=otVBeWHOCH5bbb2mg48jXBrEMDF2J6OcCQQgFWyZigKB1CAV+76LUNMwNITSmzxQ6YD5oVeoxgnSVgU4VB2ZWL9Pz7dQXtUqXU9mDvusrYE95bJ7yGNa1eRmb2cUEGil/7VWCaf4GkpYMJTac2ByUvr6rEW8/O/4eeql1Qktm0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711611742; c=relaxed/simple;
	bh=wv04Vl94EPm4VF0IfcPkgdyWx6jpG4Tk+hPC00aE880=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=NaD5/WABWiCnqfBCmZ37YTN1k1f804hgErWboSJneH9sqILSGriM5S4ZtkxfAFW1nBzQgk5F6DsIljkVwfQhYdgyQ0Qjud1v4ZwmqWFKdTerNGs+5pZimzuFNf8efNI/62zniL7WE6D3uvTwlLvKRZy58m5hogo/Tgwto8e6NA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ISQEQucp; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711611736; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=ED5mP/oEyD5dROoSWJxyTKtT8vGKbpeBWTTFErjFtYo=;
	b=ISQEQucpmfUSuuQheBSa/zrUTPxmrZOEuoUOQKn6TF5ljlK7wRs8JComCh1q4no7WsiI9bKteCuvpczmLm2sNTUdEPRQZQeByogjZRcZdsdccMjbaeNSayxqeM+E1RoBNUO3XtLvStCy3FBgWdcQA3BR+r9X36wRudXONgpqUzw=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0W3S7z0b_1711611735;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W3S7z0b_1711611735)
          by smtp.aliyun-inc.com;
          Thu, 28 Mar 2024 15:42:16 +0800
Message-ID: <1711611723.1223743-4-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v6 05/10] virtio_ring: split: structure the indirect desc table
Date: Thu, 28 Mar 2024 15:42:03 +0800
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
 <20240327111430.108787-6-xuanzhuo@linux.alibaba.com>
 <CACGkMEvKXrw5SPD7YudE4ecsK2Fo5x0n_ROFAp+J8xz=dLvBzQ@mail.gmail.com>
In-Reply-To: <CACGkMEvKXrw5SPD7YudE4ecsK2Fo5x0n_ROFAp+J8xz=dLvBzQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Thu, 28 Mar 2024 15:01:02 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Wed, Mar 27, 2024 at 7:14=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba=
.com> wrote:
> >
> > This commit structure the indirect desc table.
> > Then we can get the desc num directly when doing unmap.
> >
> > And save the dma info to the struct, then the indirect
> > will not use the dma fields of the desc_extra. The subsequent
> > commits will make the dma fields are optional. But for
> > the indirect case, we must record the dma info.
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >  drivers/virtio/virtio_ring.c | 87 +++++++++++++++++++++---------------
> >  1 file changed, 51 insertions(+), 36 deletions(-)
> >
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index 8170761ab25e..1f7c96543d58 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -69,7 +69,7 @@
> >
> >  struct vring_desc_state_split {
> >         void *data;                     /* Data for callback. */
> > -       struct vring_desc *indir_desc;  /* Indirect descriptor, if any.=
 */
> > +       struct vring_desc_extra *indir_desc;    /* Indirect descriptor,=
 if any. */
> >  };
> >
> >  struct vring_desc_state_packed {
> > @@ -469,12 +469,16 @@ static unsigned int vring_unmap_one_split(const s=
truct vring_virtqueue *vq,
> >         return extra[i].next;
> >  }
> >
> > -static struct vring_desc *alloc_indirect_split(struct virtqueue *_vq,
> > -                                              unsigned int total_sg,
> > -                                              gfp_t gfp)
> > +static struct vring_desc_extra *alloc_indirect_split(struct virtqueue =
*_vq,
> > +                                                    unsigned int total=
_sg,
> > +                                                    gfp_t gfp)
> >  {
> > +       struct vring_desc_extra *in_extra;
> >         struct vring_desc *desc;
> >         unsigned int i;
> > +       u32 size;
> > +
> > +       size =3D sizeof(*in_extra) + sizeof(struct vring_desc) * total_=
sg;
> >
> >         /*
> >          * We require lowmem mappings for the descriptors because
> > @@ -483,13 +487,16 @@ static struct vring_desc *alloc_indirect_split(st=
ruct virtqueue *_vq,
> >          */
> >         gfp &=3D ~__GFP_HIGHMEM;
> >
> > -       desc =3D kmalloc_array(total_sg, sizeof(struct vring_desc), gfp=
);
> > -       if (!desc)
> > +       in_extra =3D kmalloc(size, gfp);
> > +       if (!in_extra)
> >                 return NULL;
> >
> > +       desc =3D (struct vring_desc *)(in_extra + 1);
> > +
> >         for (i =3D 0; i < total_sg; i++)
> >                 desc[i].next =3D cpu_to_virtio16(_vq->vdev, i + 1);
> > -       return desc;
> > +
> > +       return in_extra;
> >  }
> >
> >  static inline unsigned int virtqueue_add_desc_split(struct virtqueue *=
vq,
> > @@ -531,6 +538,7 @@ static inline int virtqueue_add_split(struct virtqu=
eue *_vq,
> >                                       gfp_t gfp)
> >  {
> >         struct vring_virtqueue *vq =3D to_vvq(_vq);
> > +       struct vring_desc_extra *in_extra;
> >         struct scatterlist *sg;
> >         struct vring_desc *desc;
> >         unsigned int i, n, avail, descs_used, prev, err_idx;
> > @@ -553,9 +561,13 @@ static inline int virtqueue_add_split(struct virtq=
ueue *_vq,
> >
> >         head =3D vq->free_head;
> >
> > -       if (virtqueue_use_indirect(vq, total_sg))
> > -               desc =3D alloc_indirect_split(_vq, total_sg, gfp);
> > -       else {
> > +       if (virtqueue_use_indirect(vq, total_sg)) {
> > +               in_extra =3D alloc_indirect_split(_vq, total_sg, gfp);
> > +               if (!in_extra)
> > +                       desc =3D NULL;
> > +               else
> > +                       desc =3D (struct vring_desc *)(in_extra + 1);
> > +       } else {
> >                 desc =3D NULL;
> >                 WARN_ON_ONCE(total_sg > vq->split.vring.num && !vq->ind=
irect);
> >         }
> > @@ -628,10 +640,10 @@ static inline int virtqueue_add_split(struct virt=
queue *_vq,
> >                         ~VRING_DESC_F_NEXT;
> >
> >         if (indirect) {
> > +               u32 size =3D total_sg * sizeof(struct vring_desc);
> > +
> >                 /* Now that the indirect table is filled in, map it. */
> > -               dma_addr_t addr =3D vring_map_single(
> > -                       vq, desc, total_sg * sizeof(struct vring_desc),
> > -                       DMA_TO_DEVICE);
> > +               dma_addr_t addr =3D vring_map_single(vq, desc, size, DM=
A_TO_DEVICE);
> >                 if (vring_mapping_error(vq, addr)) {
> >                         if (!vring_need_unmap_buffer(vq))
> >                                 goto free_indirect;
> > @@ -639,11 +651,18 @@ static inline int virtqueue_add_split(struct virt=
queue *_vq,
> >                         goto unmap_release;
> >                 }
> >
> > -               virtqueue_add_desc_split(_vq, vq->split.vring.desc,
> > -                                        head, addr,
> > -                                        total_sg * sizeof(struct vring=
_desc),
> > -                                        VRING_DESC_F_INDIRECT,
> > -                                        false);
> > +               desc =3D &vq->split.vring.desc[head];
> > +
> > +               desc->flags =3D cpu_to_virtio16(_vq->vdev, VRING_DESC_F=
_INDIRECT);
> > +               desc->addr =3D cpu_to_virtio64(_vq->vdev, addr);
> > +               desc->len =3D cpu_to_virtio32(_vq->vdev, size);
> > +
> > +               vq->split.desc_extra[head].flags =3D VRING_DESC_F_INDIR=
ECT;
> > +
> > +               if (vq->use_dma_api) {
> > +                       in_extra->addr =3D addr;
> > +                       in_extra->len =3D size;
> > +               }
>
> I would find ways to reuse virtqueue_add_desc_split instead of open codin=
g here.


I will try.

Thanks.


>
> Thanks
>

