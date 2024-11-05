Return-Path: <netdev+bounces-141799-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 345DB9BC44E
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 05:25:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C11D1C21285
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 04:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD86718E023;
	Tue,  5 Nov 2024 04:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jtlz5lzj"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45DA376E0
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 04:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730780726; cv=none; b=ceNwyeLI5W2JHsyP2v5Z1Xy5NszgQps75ALIpmQjhsux/9q6j6D/xeBmufd7yMlQQFNUz/2YqxGMqy1JAUVv5i77hkNxpfqg3ZDBiSqlXfP5wiW7C6VOa6y3VegveBrsPmm3uNIncEiXpPjsEpGAv7pBUqNHZ+GFpH+C9lzSNrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730780726; c=relaxed/simple;
	bh=CS2GfzSA1JcY5j+wxnuKIbhT+wXBZrCfStyjG8HjGL4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mah9MKufOniMQnX23Vc7/X2TrKbJbhzsTP61TJGSg36Ic3rUOQUMjLMCU6j3SN6x34AxiESp/X51S/2rSbnF7NhBeFeo0xLARh4hzlW04qYjkxagWPyRi9io+J6mx8778avrFC4CjdW9+eH09cbzwaKTIT9IfiXIK2iv3q8kRak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jtlz5lzj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730780723;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4CCOot3ufdE2YqEs9xebqHSiJOdFlIQhECY/5pN1KI8=;
	b=Jtlz5lzj5J/U7TFVyiP7rPMcbRLH6fNJyAyN2OKySLMDp9AxfNORtjMz87wp8KeebSInWS
	b0gjbci4a1gVQMIbX6OmsgtkmR1KpT8yaPbHwg+/k2DeJoMq7YGwqy16qfVNqC/vOIbLGK
	aTg8JKiBN3Dhec3q+Mo/hKKkJs0xFQ8=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-496-dFlW7ZNgO9mN5hnv9x62ZA-1; Mon, 04 Nov 2024 23:25:22 -0500
X-MC-Unique: dFlW7ZNgO9mN5hnv9x62ZA-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-7ee07d0f395so5921613a12.3
        for <netdev@vger.kernel.org>; Mon, 04 Nov 2024 20:25:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730780721; x=1731385521;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4CCOot3ufdE2YqEs9xebqHSiJOdFlIQhECY/5pN1KI8=;
        b=E0vw5jb0aXygLDJ8kt7BOkni4lNOX2PT9ac1UsO/Nj0AHQLxlxI9n4LwGkaN2PxUH4
         no/lI7uvZQvp2+KhCZ3Z5Fuc9T3w0VAif0TuQ99mxdsGzA9UqbEJ0o6yLwvIdusPLugZ
         uJWruFH/GBhp7SdDntcgtZjAYG5PurkWWgO7HbQ3B6Acf/yO8dnyGdlyxNaE8fkyUUMq
         oaEje9SaYKpHTRM+W9AU6hZllMHwvl+oxJ0Q2X1y+rnjKtvUiehyL5C8bMoJQ/aSmLki
         cUF2uy1YFuef3s9Rd2+Al/tJ6cOl+aeyVT4xFUJwFbuuf0hTFLZqj44rVwhlyGq9uw9w
         W3vg==
X-Gm-Message-State: AOJu0Yz6ziM+N3zKx/fQw/N05/Tj//RORx6Z9dwv3iynu8ZwnadBaIMu
	wZiR2rRWAMJ6lJ9hBjAL4AZaHqV6VcarLpwt0TAF0suQjMrJRpt63dWNRcW/JUudJoGEpb2vPyh
	7Uhcwtq545vLw8SehuRDofXydXSa5LhqFqiAE2JrMmpsyw9NOfmUeZRPKcxoJHeUvQ0Xtdz0oTQ
	4i+v55M4ZZGHc5wyKTdoMvVO5+ySEY
X-Received: by 2002:a05:6a20:d80c:b0:1d9:261c:5943 with SMTP id adf61e73a8af0-1db91d51513mr26249502637.10.1730780721222;
        Mon, 04 Nov 2024 20:25:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGGIiawh4nOPxgtGfheigO3w6ndNJ8vLkDOZ+trEI282rg1LwxO3aVz0cjFdSCNW8Z6F0geCbNdqYiofzWhxnw=
X-Received: by 2002:a05:6a20:d80c:b0:1d9:261c:5943 with SMTP id
 adf61e73a8af0-1db91d51513mr26249473637.10.1730780720674; Mon, 04 Nov 2024
 20:25:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241030082453.97310-1-xuanzhuo@linux.alibaba.com> <20241030082453.97310-5-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20241030082453.97310-5-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 5 Nov 2024 12:25:09 +0800
Message-ID: <CACGkMEs07CZneSg3nD41ebz8AkMJCvOikU-RmrxusVWs7B8=eg@mail.gmail.com>
Subject: Re: [PATCH net-next v2 04/13] virtio_ring: perform premapped
 operations based on per-buffer
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

On Wed, Oct 30, 2024 at 4:25=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> The current configuration sets the virtqueue (vq) to premapped mode,
> implying that all buffers submitted to this queue must be mapped ahead
> of time. This presents a challenge for the virtnet send queue (sq): the
> virtnet driver would be required to keep track of dma information for vq
> size * 17,

Even worse as MAX_SKB_FRAGS could be even larger.

> which can be substantial. However, if the premapped mode were
> applied on a per-buffer basis, the complexity would be greatly reduced.
> With AF_XDP enabled, AF_XDP buffers would become premapped, while kernel
> skb buffers could remain unmapped.
>
> And consider that some sgs are not generated by the virtio driver,
> that may be passed from the block stack. So we can not change the
> sgs, new APIs are the better way.

I had some new thoughts on this.

Pre-mapping makes a lot of sense as it allows the us to move the
expensive DMA mapping operations (swiotlb, IOMMU or VDUSE) out of the
per-vq lock. I wonder what would we do if someday we want to convert
the skb TX to be premapped (or even all virtio drivers).

Considering we've already used skb_to_sgvec() in start_xmit() it looks
like we need to allocate sg[queue_num][MAX_SKB_FRAGS + 2] and store
the dma mapping there. Then we probably don't even need to duplicate
the dma mapping information in the core.

It means it's the driver's charge to store the dma information via sg,
so we can simply use dma_map_sg() in add_sgs() which allows various
optimizations in IOMMU layers.

>
> So we pass the new argument 'premapped' to indicate the buffers
> submitted to virtio are premapped in advance. Additionally,
> DMA unmap operations for these buffers will be bypassed.
>
> Suggested-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

Anyhow

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>  drivers/virtio/virtio_ring.c | 79 ++++++++++++++++++------------------
>  1 file changed, 40 insertions(+), 39 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 628e01af1c9a..a89295b79e66 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -300,9 +300,10 @@ static bool vring_use_dma_api(const struct virtio_de=
vice *vdev)
>         return false;
>  }
>
> -static bool vring_need_unmap_buffer(const struct vring_virtqueue *vring)
> +static bool vring_need_unmap_buffer(const struct vring_virtqueue *vring,
> +                                   const struct vring_desc_extra *extra)
>  {
> -       return vring->use_dma_api && !vring->premapped;
> +       return vring->use_dma_api && (extra->addr !=3D DMA_MAPPING_ERROR)=
;
>  }
>
>  size_t virtio_max_dma_size(const struct virtio_device *vdev)
> @@ -372,9 +373,10 @@ static struct device *vring_dma_dev(const struct vri=
ng_virtqueue *vq)
>
>  /* Map one sg entry. */
>  static int vring_map_one_sg(const struct vring_virtqueue *vq, struct sca=
tterlist *sg,
> -                           enum dma_data_direction direction, dma_addr_t=
 *addr)
> +                           enum dma_data_direction direction, dma_addr_t=
 *addr,
> +                           bool premapped)
>  {
> -       if (vq->premapped) {
> +       if (premapped) {
>                 *addr =3D sg_dma_address(sg);
>                 return 0;
>         }
> @@ -465,7 +467,7 @@ static unsigned int vring_unmap_one_split(const struc=
t vring_virtqueue *vq,
>                                  (flags & VRING_DESC_F_WRITE) ?
>                                  DMA_FROM_DEVICE : DMA_TO_DEVICE);
>         } else {
> -               if (!vring_need_unmap_buffer(vq))
> +               if (!vring_need_unmap_buffer(vq, extra))
>                         goto out;
>
>                 dma_unmap_page(vring_dma_dev(vq),
> @@ -514,7 +516,7 @@ static inline unsigned int virtqueue_add_desc_split(s=
truct virtqueue *vq,
>                                                     unsigned int i,
>                                                     dma_addr_t addr,
>                                                     unsigned int len,
> -                                                   u16 flags)
> +                                                   u16 flags, bool prema=
pped)
>  {
>         u16 next;
>
> @@ -522,7 +524,7 @@ static inline unsigned int virtqueue_add_desc_split(s=
truct virtqueue *vq,
>         desc[i].addr =3D cpu_to_virtio64(vq->vdev, addr);
>         desc[i].len =3D cpu_to_virtio32(vq->vdev, len);
>
> -       extra[i].addr =3D addr;
> +       extra[i].addr =3D premapped ? DMA_MAPPING_ERROR : addr;
>         extra[i].len =3D len;
>         extra[i].flags =3D flags;
>
> @@ -540,6 +542,7 @@ static inline int virtqueue_add_split(struct virtqueu=
e *_vq,
>                                       unsigned int in_sgs,
>                                       void *data,
>                                       void *ctx,
> +                                     bool premapped,
>                                       gfp_t gfp)
>  {
>         struct vring_virtqueue *vq =3D to_vvq(_vq);
> @@ -606,7 +609,7 @@ static inline int virtqueue_add_split(struct virtqueu=
e *_vq,
>                 for (sg =3D sgs[n]; sg; sg =3D sg_next(sg)) {
>                         dma_addr_t addr;
>
> -                       if (vring_map_one_sg(vq, sg, DMA_TO_DEVICE, &addr=
))
> +                       if (vring_map_one_sg(vq, sg, DMA_TO_DEVICE, &addr=
, premapped))
>                                 goto unmap_release;
>
>                         prev =3D i;
> @@ -614,14 +617,15 @@ static inline int virtqueue_add_split(struct virtqu=
eue *_vq,
>                          * table since it use stream DMA mapping.
>                          */
>                         i =3D virtqueue_add_desc_split(_vq, desc, extra, =
i, addr, sg->length,
> -                                                    VRING_DESC_F_NEXT);
> +                                                    VRING_DESC_F_NEXT,
> +                                                    premapped);
>                 }
>         }
>         for (; n < (out_sgs + in_sgs); n++) {
>                 for (sg =3D sgs[n]; sg; sg =3D sg_next(sg)) {
>                         dma_addr_t addr;
>
> -                       if (vring_map_one_sg(vq, sg, DMA_FROM_DEVICE, &ad=
dr))
> +                       if (vring_map_one_sg(vq, sg, DMA_FROM_DEVICE, &ad=
dr, premapped))
>                                 goto unmap_release;
>
>                         prev =3D i;
> @@ -631,12 +635,13 @@ static inline int virtqueue_add_split(struct virtqu=
eue *_vq,
>                         i =3D virtqueue_add_desc_split(_vq, desc, extra, =
i, addr,
>                                                      sg->length,
>                                                      VRING_DESC_F_NEXT |
> -                                                    VRING_DESC_F_WRITE);
> +                                                    VRING_DESC_F_WRITE,
> +                                                    premapped);
>                 }
>         }
>         /* Last one doesn't continue. */
>         desc[prev].flags &=3D cpu_to_virtio16(_vq->vdev, ~VRING_DESC_F_NE=
XT);
> -       if (!indirect && vring_need_unmap_buffer(vq))
> +       if (!indirect && vring_need_unmap_buffer(vq, &extra[prev]))
>                 vq->split.desc_extra[prev & (vq->split.vring.num - 1)].fl=
ags &=3D
>                         ~VRING_DESC_F_NEXT;
>
> @@ -645,18 +650,14 @@ static inline int virtqueue_add_split(struct virtqu=
eue *_vq,
>                 dma_addr_t addr =3D vring_map_single(
>                         vq, desc, total_sg * sizeof(struct vring_desc),
>                         DMA_TO_DEVICE);
> -               if (vring_mapping_error(vq, addr)) {
> -                       if (vq->premapped)
> -                               goto free_indirect;
> -
> +               if (vring_mapping_error(vq, addr))
>                         goto unmap_release;
> -               }
>
>                 virtqueue_add_desc_split(_vq, vq->split.vring.desc,
>                                          vq->split.desc_extra,
>                                          head, addr,
>                                          total_sg * sizeof(struct vring_d=
esc),
> -                                        VRING_DESC_F_INDIRECT);
> +                                        VRING_DESC_F_INDIRECT, false);
>         }
>
>         /* We're using some buffers from the free list. */
> @@ -713,7 +714,6 @@ static inline int virtqueue_add_split(struct virtqueu=
e *_vq,
>                 i =3D vring_unmap_one_split(vq, &extra[i]);
>         }
>
> -free_indirect:
>         if (indirect)
>                 kfree(desc);
>
> @@ -798,7 +798,7 @@ static void detach_buf_split(struct vring_virtqueue *=
vq, unsigned int head,
>
>                 extra =3D (struct vring_desc_extra *)&indir_desc[num];
>
> -               if (vring_need_unmap_buffer(vq)) {
> +               if (vq->use_dma_api) {
>                         for (j =3D 0; j < num; j++)
>                                 vring_unmap_one_split(vq, &extra[j]);
>                 }
> @@ -1232,7 +1232,7 @@ static void vring_unmap_extra_packed(const struct v=
ring_virtqueue *vq,
>                                  (flags & VRING_DESC_F_WRITE) ?
>                                  DMA_FROM_DEVICE : DMA_TO_DEVICE);
>         } else {
> -               if (!vring_need_unmap_buffer(vq))
> +               if (!vring_need_unmap_buffer(vq, extra))
>                         return;
>
>                 dma_unmap_page(vring_dma_dev(vq),
> @@ -1276,6 +1276,7 @@ static int virtqueue_add_indirect_packed(struct vri=
ng_virtqueue *vq,
>                                          unsigned int out_sgs,
>                                          unsigned int in_sgs,
>                                          void *data,
> +                                        bool premapped,
>                                          gfp_t gfp)
>  {
>         struct vring_desc_extra *extra;
> @@ -1306,7 +1307,8 @@ static int virtqueue_add_indirect_packed(struct vri=
ng_virtqueue *vq,
>         for (n =3D 0; n < out_sgs + in_sgs; n++) {
>                 for (sg =3D sgs[n]; sg; sg =3D sg_next(sg)) {
>                         if (vring_map_one_sg(vq, sg, n < out_sgs ?
> -                                            DMA_TO_DEVICE : DMA_FROM_DEV=
ICE, &addr))
> +                                            DMA_TO_DEVICE : DMA_FROM_DEV=
ICE,
> +                                            &addr, premapped))
>                                 goto unmap_release;
>
>                         desc[i].flags =3D cpu_to_le16(n < out_sgs ?
> @@ -1315,7 +1317,7 @@ static int virtqueue_add_indirect_packed(struct vri=
ng_virtqueue *vq,
>                         desc[i].len =3D cpu_to_le32(sg->length);
>
>                         if (unlikely(vq->use_dma_api)) {
> -                               extra[i].addr =3D addr;
> +                               extra[i].addr =3D premapped ? DMA_MAPPING=
_ERROR : addr;
>                                 extra[i].len =3D sg->length;
>                                 extra[i].flags =3D n < out_sgs ?  0 : VRI=
NG_DESC_F_WRITE;
>                         }
> @@ -1328,12 +1330,8 @@ static int virtqueue_add_indirect_packed(struct vr=
ing_virtqueue *vq,
>         addr =3D vring_map_single(vq, desc,
>                         total_sg * sizeof(struct vring_packed_desc),
>                         DMA_TO_DEVICE);
> -       if (vring_mapping_error(vq, addr)) {
> -               if (vq->premapped)
> -                       goto free_desc;
> -
> +       if (vring_mapping_error(vq, addr))
>                 goto unmap_release;
> -       }
>
>         vq->packed.vring.desc[head].addr =3D cpu_to_le64(addr);
>         vq->packed.vring.desc[head].len =3D cpu_to_le32(total_sg *
> @@ -1391,7 +1389,6 @@ static int virtqueue_add_indirect_packed(struct vri=
ng_virtqueue *vq,
>         for (i =3D 0; i < err_idx; i++)
>                 vring_unmap_extra_packed(vq, &extra[i]);
>
> -free_desc:
>         kfree(desc);
>
>         END_USE(vq);
> @@ -1405,6 +1402,7 @@ static inline int virtqueue_add_packed(struct virtq=
ueue *_vq,
>                                        unsigned int in_sgs,
>                                        void *data,
>                                        void *ctx,
> +                                      bool premapped,
>                                        gfp_t gfp)
>  {
>         struct vring_virtqueue *vq =3D to_vvq(_vq);
> @@ -1431,7 +1429,7 @@ static inline int virtqueue_add_packed(struct virtq=
ueue *_vq,
>
>         if (virtqueue_use_indirect(vq, total_sg)) {
>                 err =3D virtqueue_add_indirect_packed(vq, sgs, total_sg, =
out_sgs,
> -                                                   in_sgs, data, gfp);
> +                                                   in_sgs, data, premapp=
ed, gfp);
>                 if (err !=3D -ENOMEM) {
>                         END_USE(vq);
>                         return err;
> @@ -1466,7 +1464,8 @@ static inline int virtqueue_add_packed(struct virtq=
ueue *_vq,
>                         dma_addr_t addr;
>
>                         if (vring_map_one_sg(vq, sg, n < out_sgs ?
> -                                            DMA_TO_DEVICE : DMA_FROM_DEV=
ICE, &addr))
> +                                            DMA_TO_DEVICE : DMA_FROM_DEV=
ICE,
> +                                            &addr, premapped))
>                                 goto unmap_release;
>
>                         flags =3D cpu_to_le16(vq->packed.avail_used_flags=
 |
> @@ -1482,7 +1481,8 @@ static inline int virtqueue_add_packed(struct virtq=
ueue *_vq,
>                         desc[i].id =3D cpu_to_le16(id);
>
>                         if (unlikely(vq->use_dma_api)) {
> -                               vq->packed.desc_extra[curr].addr =3D addr=
;
> +                               vq->packed.desc_extra[curr].addr =3D prem=
apped ?
> +                                       DMA_MAPPING_ERROR : addr;
>                                 vq->packed.desc_extra[curr].len =3D sg->l=
ength;
>                                 vq->packed.desc_extra[curr].flags =3D
>                                         le16_to_cpu(flags);
> @@ -1633,7 +1633,7 @@ static void detach_buf_packed(struct vring_virtqueu=
e *vq,
>                 if (!desc)
>                         return;
>
> -               if (vring_need_unmap_buffer(vq)) {
> +               if (vq->use_dma_api) {
>                         len =3D vq->packed.desc_extra[id].len;
>                         num =3D len / sizeof(struct vring_packed_desc);
>
> @@ -2204,14 +2204,15 @@ static inline int virtqueue_add(struct virtqueue =
*_vq,
>                                 unsigned int in_sgs,
>                                 void *data,
>                                 void *ctx,
> +                               bool premapped,
>                                 gfp_t gfp)
>  {
>         struct vring_virtqueue *vq =3D to_vvq(_vq);
>
>         return vq->packed_ring ? virtqueue_add_packed(_vq, sgs, total_sg,
> -                                       out_sgs, in_sgs, data, ctx, gfp) =
:
> +                                       out_sgs, in_sgs, data, ctx, prema=
pped, gfp) :
>                                  virtqueue_add_split(_vq, sgs, total_sg,
> -                                       out_sgs, in_sgs, data, ctx, gfp);
> +                                       out_sgs, in_sgs, data, ctx, prema=
pped, gfp);
>  }
>
>  /**
> @@ -2245,7 +2246,7 @@ int virtqueue_add_sgs(struct virtqueue *_vq,
>                         total_sg++;
>         }
>         return virtqueue_add(_vq, sgs, total_sg, out_sgs, in_sgs,
> -                            data, NULL, gfp);
> +                            data, NULL, false, gfp);
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_add_sgs);
>
> @@ -2267,7 +2268,7 @@ int virtqueue_add_outbuf(struct virtqueue *vq,
>                          void *data,
>                          gfp_t gfp)
>  {
> -       return virtqueue_add(vq, &sg, num, 1, 0, data, NULL, gfp);
> +       return virtqueue_add(vq, &sg, num, 1, 0, data, NULL, false, gfp);
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_add_outbuf);
>
> @@ -2289,7 +2290,7 @@ int virtqueue_add_inbuf(struct virtqueue *vq,
>                         void *data,
>                         gfp_t gfp)
>  {
> -       return virtqueue_add(vq, &sg, num, 0, 1, data, NULL, gfp);
> +       return virtqueue_add(vq, &sg, num, 0, 1, data, NULL, false, gfp);
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_add_inbuf);
>
> @@ -2313,7 +2314,7 @@ int virtqueue_add_inbuf_ctx(struct virtqueue *vq,
>                         void *ctx,
>                         gfp_t gfp)
>  {
> -       return virtqueue_add(vq, &sg, num, 0, 1, data, ctx, gfp);
> +       return virtqueue_add(vq, &sg, num, 0, 1, data, ctx, false, gfp);
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_add_inbuf_ctx);
>
> --
> 2.32.0.3.g01195cf9f
>


