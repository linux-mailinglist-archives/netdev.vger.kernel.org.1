Return-Path: <netdev+bounces-82760-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA7E88F9E6
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 09:16:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D0591C22380
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 08:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CED15466E;
	Thu, 28 Mar 2024 08:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="UJGwkUqY"
X-Original-To: netdev@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CDC42052
	for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 08:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711613808; cv=none; b=r87gLmXv41hxDijoKwWJlG4HNfrfGk+i/o+wF0XZ1yRTIH+P1Ytsl+kR2IS/Xm5B7jw3mBT/Jv2L/I285ofNbwztCxc1oK9oZu8rRfJBob/azr88JGdd2X83ZR79+mUXrHgmoM1dHISE1L/lvpN2QIUlMrNoFmom9wD2YpfDlWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711613808; c=relaxed/simple;
	bh=nvYYi5wNBGAUgcbH6S3gm5JW5OWj8XS8CK4/d96tc0I=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=LGh1M4MoWWD9TzXWSvPXupX1mLkYyvKps91UgWcr900oSsydS/XexvxwvlddElEkh8LQETsD05cF7LQ7+CQgLf8pr0jJ0UJrrPvfDu7u/NMfUzrJRX+Cjrqx2f7PLCX89mkcLJatGYFS4kgcrs26FQp1AXs/DResYGZUaMGNxMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=UJGwkUqY; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711613803; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=1kYLxrTIw36r9RmFYxuLhuGlrdaqNu0Ho96DUKmbYE0=;
	b=UJGwkUqYfxNHryc0z+U37kGayDoWpiqRBlNIgUk4oCKUbKyMClfiJHZYgTJSJQbUPBaZyfP+8/IlyXMso8OUGn/tU6fw5IJBxEPwvD9vcI9zHj88f/AUY5Ak+BV7DFbgtprkTnd6fNJ7m3m6eF1vrphWU/fqv2ZJDauW4akkeNc=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R581e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0W3SeJwS_1711613802;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W3SeJwS_1711613802)
          by smtp.aliyun-inc.com;
          Thu, 28 Mar 2024 16:16:43 +0800
Message-ID: <1711613734.5560663-5-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v6 02/10] virtio_ring: packed: remove double check of the unmap ops
Date: Thu, 28 Mar 2024 16:15:34 +0800
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
 <20240327111430.108787-3-xuanzhuo@linux.alibaba.com>
 <CACGkMEsG7+mNx4WqhAuhrpk1bhLEwrTzngT5q=CZ_aHkzRasVg@mail.gmail.com>
 <1711610846.0120149-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEstpEfrnsuLwE2AaceXDzE97kOCu9ukMAeX0O80k9xTUw@mail.gmail.com>
In-Reply-To: <CACGkMEstpEfrnsuLwE2AaceXDzE97kOCu9ukMAeX0O80k9xTUw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Thu, 28 Mar 2024 16:07:14 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Thu, Mar 28, 2024 at 3:32=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba=
.com> wrote:
> >
> > On Thu, 28 Mar 2024 14:56:47 +0800, Jason Wang <jasowang@redhat.com> wr=
ote:
> > > On Wed, Mar 27, 2024 at 7:14=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.ali=
baba.com> wrote:
> > > >
> > > > In the functions vring_unmap_extra_packed and vring_unmap_desc_pack=
ed,
> > > > multiple checks are made whether unmap is performed and whether it =
is
> > > > INDIRECT.
> > > >
> > > > These two functions are usually called in a loop, and we should put=
 the
> > > > check outside the loop.
> > > >
> > > > And we unmap the descs with VRING_DESC_F_INDIRECT on the same path =
with
> > > > other descs, that make the thing more complex. If we distinguish the
> > > > descs with VRING_DESC_F_INDIRECT before unmap, thing will be cleare=
r.
> > > >
> > > > For desc with VRING_DESC_F_INDIRECT flag:
> > > > 1. only one desc of the desc table is used, we do not need the loop
> > > >     Theoretically, indirect descriptors could be chained.
> > > >     But now, that is not supported by "add", so we ignore this case.
> > > > 2. the called unmap api is difference from the other desc
> > > > 3. the vq->premapped is not needed to check
> > > > 4. the vq->indirect is not needed to check
> > > > 5. the state->indir_desc must not be null
> > >
> > > It doesn't explain the connection to the goal of this series. If it's
> > > not a must I'd suggest moving it to a separate patch.
> >
> >
> > The "no store dma ..." depends this.
> >
> > I will add this message in next version.
> >
> >
> > >
> > > >
> > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > >
> > > Rethink this, it looks to me it would complicate the codes furtherly.
> > >
> > > For example, vring_map_xxx() helpers will check premappred and
> > > use_dma_api by itself. But in the case of vring_unmap() you want to
> > > move those checks to the caller. This will result in tricky codes that
> > > are hard to understand.
> > >
> > > We need to be consistent here.
> > >
> > > If we try to optimize unmap we need to optimize map as well. But
> > > generally it would complicate the logic of the caller if we want to
> > > let the caller to differ. Ideally, the caller of those function should
> > > know nothing about use_dma_api, premapped and other.
> >
> >
> > The key is that we can check "use_dma_api, premapped" to skip the loop.
> > If the vring_unmap_xxx is called, the "use_dma_api, premapped" is check=
ed in
> > advance, so that is a waste to check thest again.
>
> Right, but we have the same logic for map.

But we can not skip the loop for map.


>
> >
> >
> > >
> > > > ---
> > > >  drivers/virtio/virtio_ring.c | 78 ++++++++++++++++++--------------=
----
> > > >  1 file changed, 40 insertions(+), 38 deletions(-)
> > > >
> > > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_r=
ing.c
> > > > index 03360073bd4a..a2838fe1cc08 100644
> > > > --- a/drivers/virtio/virtio_ring.c
> > > > +++ b/drivers/virtio/virtio_ring.c
> > > > @@ -1214,6 +1214,7 @@ static u16 packed_last_used(u16 last_used_idx)
> > > >         return last_used_idx & ~(-(1 << VRING_PACKED_EVENT_F_WRAP_C=
TR));
> > > >  }
> > > >
> > > > +/* caller must check vring_need_unmap_buffer() */
> > > >  static void vring_unmap_extra_packed(const struct vring_virtqueue =
*vq,
> > > >                                      const struct vring_desc_extra =
*extra)
> > > >  {
> > > > @@ -1221,33 +1222,18 @@ static void vring_unmap_extra_packed(const =
struct vring_virtqueue *vq,
> > > >
> > > >         flags =3D extra->flags;
> > > >
> > > > -       if (flags & VRING_DESC_F_INDIRECT) {
> > > > -               if (!vq->use_dma_api)
> > > > -                       return;
> > > > -
> > > > -               dma_unmap_single(vring_dma_dev(vq),
> > > > -                                extra->addr, extra->len,
> > > > -                                (flags & VRING_DESC_F_WRITE) ?
> > > > -                                DMA_FROM_DEVICE : DMA_TO_DEVICE);
> > > > -       } else {
> > > > -               if (!vring_need_unmap_buffer(vq))
> > > > -                       return;
> > > > -
> > > > -               dma_unmap_page(vring_dma_dev(vq),
> > > > -                              extra->addr, extra->len,
> > > > -                              (flags & VRING_DESC_F_WRITE) ?
> > > > -                              DMA_FROM_DEVICE : DMA_TO_DEVICE);
> > > > -       }
> > > > +       dma_unmap_page(vring_dma_dev(vq),
> > > > +                      extra->addr, extra->len,
> > > > +                      (flags & VRING_DESC_F_WRITE) ?
> > > > +                      DMA_FROM_DEVICE : DMA_TO_DEVICE);
> > > >  }
> > > >
> > > > +/* caller must check vring_need_unmap_buffer() */
> > > >  static void vring_unmap_desc_packed(const struct vring_virtqueue *=
vq,
> > > >                                     const struct vring_packed_desc =
*desc)
> > > >  {
> > > >         u16 flags;
> > > >
> > > > -       if (!vring_need_unmap_buffer(vq))
> > > > -               return;
> > > > -
> > > >         flags =3D le16_to_cpu(desc->flags);
> > > >
> > > >         dma_unmap_page(vring_dma_dev(vq),
> > > > @@ -1323,7 +1309,7 @@ static int virtqueue_add_indirect_packed(stru=
ct vring_virtqueue *vq,
> > > >                         total_sg * sizeof(struct vring_packed_desc),
> > > >                         DMA_TO_DEVICE);
> > > >         if (vring_mapping_error(vq, addr)) {
> > > > -               if (vq->premapped)
> > > > +               if (!vring_need_unmap_buffer(vq))
> > > >                         goto free_desc;
> > >
> > > I would do this to make it much more easier to be read and avoid the =
warn:
> > >
> > > if (vring_mapping_error(vq, addr))
> > >         goto unmap_release;
> > >
> > > unmap_release:
> > >         if (vring_need_unmap_buffer(vq))
> > >                 for (i =3D 0, xxx)
> > > free_desc:
> > >         kfree(desc);
> > >
> > > or it could be
> > >
> > > unmap_release:
> > >       if (!vring_need_unmap_buffer(vq))
> > >             goto free_desc;
> > >
> > > Still tricky but better.
> >
> > I am ok.
> >
> >
> > >
> > > >
> > > >                 goto unmap_release;
> > > > @@ -1338,10 +1324,11 @@ static int virtqueue_add_indirect_packed(st=
ruct vring_virtqueue *vq,
> > > >                 vq->packed.desc_extra[id].addr =3D addr;
> > > >                 vq->packed.desc_extra[id].len =3D total_sg *
> > > >                                 sizeof(struct vring_packed_desc);
> > > > -               vq->packed.desc_extra[id].flags =3D VRING_DESC_F_IN=
DIRECT |
> > > > -                                                 vq->packed.avail_=
used_flags;
> > > >         }
> > > >
> > > > +       vq->packed.desc_extra[id].flags =3D VRING_DESC_F_INDIRECT |
> > > > +               vq->packed.avail_used_flags;
> > >
> > > An example of the tricky code, I think you do this because you want to
> > > differ indirect in detach_buf_packed():
> > >
> > > flags =3D vq->packed.desc_extra[id].flags;
> > >
> > >
> > > > +
> > > >         /*
> > > >          * A driver MUST NOT make the first descriptor in the list
> > > >          * available before all subsequent descriptors comprising
> > > > @@ -1382,6 +1369,8 @@ static int virtqueue_add_indirect_packed(stru=
ct vring_virtqueue *vq,
> > > >  unmap_release:
> > > >         err_idx =3D i;
> > > >
> > > > +       WARN_ON(!vring_need_unmap_buffer(vq));
> > > > +
> > > >         for (i =3D 0; i < err_idx; i++)
> > > >                 vring_unmap_desc_packed(vq, &desc[i]);
> > > >
> > > > @@ -1475,12 +1464,13 @@ static inline int virtqueue_add_packed(stru=
ct virtqueue *_vq,
> > > >                         desc[i].len =3D cpu_to_le32(sg->length);
> > > >                         desc[i].id =3D cpu_to_le16(id);
> > > >
> > > > -                       if (unlikely(vq->use_dma_api)) {
> > > > +                       if (vring_need_unmap_buffer(vq)) {
> > > >                                 vq->packed.desc_extra[curr].addr =
=3D addr;
> > > >                                 vq->packed.desc_extra[curr].len =3D=
 sg->length;
> > > > -                               vq->packed.desc_extra[curr].flags =
=3D
> > > > -                                       le16_to_cpu(flags);
> > > >                         }
> > > > +
> > > > +                       vq->packed.desc_extra[curr].flags =3D le16_=
to_cpu(flags);
> > > > +
> > > >                         prev =3D curr;
> > > >                         curr =3D vq->packed.desc_extra[curr].next;
> > > >
> > > > @@ -1530,6 +1520,8 @@ static inline int virtqueue_add_packed(struct=
 virtqueue *_vq,
> > > >
> > > >         vq->packed.avail_used_flags =3D avail_used_flags;
> > > >
> > > > +       WARN_ON(!vring_need_unmap_buffer(vq));
> > > > +
> > > >         for (n =3D 0; n < total_sg; n++) {
> > > >                 if (i =3D=3D err_idx)
> > > >                         break;
> > > > @@ -1599,7 +1591,9 @@ static void detach_buf_packed(struct vring_vi=
rtqueue *vq,
> > > >         struct vring_desc_state_packed *state =3D NULL;
> > > >         struct vring_packed_desc *desc;
> > > >         unsigned int i, curr;
> > > > +       u16 flags;
> > > >
> > > > +       flags =3D vq->packed.desc_extra[id].flags;
> > >
> > > Can we check vq->indirect && indir_desc here? Then we don't need
> > > special care to store flags in desc_extra.
> >
> >
> > No.
> >
> > When vq->indirect is true, but the desc may has not indirect flag.
>
> But we check indir_desc as well?
>
>         vq->indirect =3D virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_=
DESC) &&
>                 !cfg_vq_get(cfg, vq, ctx);

I think you are right.

I will fix in next version.

Thanks.


>
> Thanks
>

