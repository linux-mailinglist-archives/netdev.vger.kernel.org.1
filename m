Return-Path: <netdev+bounces-82738-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C687388F837
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 07:57:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 776902955C9
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 06:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 062264F8AB;
	Thu, 28 Mar 2024 06:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OicLNWfC"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F64023768
	for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 06:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711609035; cv=none; b=fbjJpLG92feYGGRo0SlqCrtjtu8BXhPJNLS+5Doou1STe81jGOqaWkVOBpBJ0KH38OCuEs0ibxKf4KfRX4i25M8kxRUFo+/+sj/7zhY/XdrCg1unvj187Ozj7LiMT3SpcwJZriEmvtHTu5N6waJD5EJfPwKiM3N8THevyh3EUcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711609035; c=relaxed/simple;
	bh=N4cxrIOodXFQsySnYSPbqwTqKx+K6fmyBks90JBXXcU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=avcbsFo5ywJssNecdjkKqIj5Hc7RGVXXjtl2o8T6YUvx+lFGnqLOjyxvZrT4+Zgj5IPNqeUGm73jZzxfJ0haS+kOfF+P8AbzeDtCRJWKT2tMNi5gdt9BcdF12S7TQQc+7kqvuinEM3WsdZ8hMcHaSmJBV/EIwP0efSreAV4Ja5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OicLNWfC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711609033;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aAF5BWLYLUl1WtsxmRNfOE7/6Pm25dxLAI5kYse1bsE=;
	b=OicLNWfC54QA5pVj2UaUVJHbsoThQGWlBR/N7Esq3JsTzh5J+gtbzeE3ZKPsUqIDwE/bip
	PbbTOZinsYsopAH9fqluhVmyu0uGG69XxCyS6MMkeQ7TLxwCXduVMatMWmOBf+4LlHKtEY
	91obbs12di8ozEF7HBli6YOzgSPLSxU=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-393-f4mBf7RHMuKCHyMJUrtLAw-1; Thu, 28 Mar 2024 02:57:07 -0400
X-MC-Unique: f4mBf7RHMuKCHyMJUrtLAw-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2a0862ca1b3so530197a91.3
        for <netdev@vger.kernel.org>; Wed, 27 Mar 2024 23:57:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711609026; x=1712213826;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aAF5BWLYLUl1WtsxmRNfOE7/6Pm25dxLAI5kYse1bsE=;
        b=Kf6di7crTzAXe1h+FdKzOyLGxZdYVJMu7kqRu5V9lqGovcryDih798T4J4Qn0mhc0Q
         W3/eEGa3CMW4IksL9r8cV/xSxmfKimo4cP0XCvJTQHXWMxCivjPm/fbn/p8nhNj6f9W0
         +tFFrwYJqdKHZp5lvUC4lN0m4fruUlujsjMdZE60FUYExXgnUvgvXlVNGXIEf8zbCGdu
         2/JBaTZunTMIE6c2c5Eev6OFdzots81bS8U1kGu+KprLQmcrKYGFSdLC24e63eHmxrL0
         k6FFAR3ZprziJmYEKwXhF/xIzcQ/atGL3qvHRd6Sj2H/ucOjZLTG1A2hrvDFO5/IBWSr
         GRuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXyOVCzbUnLvULvYJtgewrrf+QvHeWZN7TraokqW/OTDy6oLI66qYVpEJzBMiUkO35fP6FMXEoShFdBleaonp+JA9Ppr6E
X-Gm-Message-State: AOJu0YyWZn/mhXw5Cio9S1YJ0qZaeTEVeOyPuvSsHFWIbCf2Y0pHlane
	fq8bda27nYbMP6a0Jq2NAb1yz0RMX9ldbq21BKcjO9/g45wAFyqH8iUFV0VSKwiYoZGCsXQ8uek
	/xnZEAsbFLNIvOnb8/5asvIa7XgNaBK2s0QIYH8IjMRlqiD+aQpTxcUX8uOLczZViIo+qQeUSIi
	NRihJ+mTDfJecjVD6UjAajJUHRUPev
X-Received: by 2002:a17:90a:d70b:b0:2a1:ff27:3fa3 with SMTP id y11-20020a17090ad70b00b002a1ff273fa3mr1207804pju.28.1711609026464;
        Wed, 27 Mar 2024 23:57:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHIyK8ML46kX2gNZLuSos+Fqv11Z6R20m/msywDP7iCSCvzFu9xr33X4VxBwH7mChXBdbw3VjSXgUw7MDUHr8A=
X-Received: by 2002:a17:90a:d70b:b0:2a1:ff27:3fa3 with SMTP id
 y11-20020a17090ad70b00b002a1ff273fa3mr1207789pju.28.1711609026146; Wed, 27
 Mar 2024 23:57:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327111430.108787-1-xuanzhuo@linux.alibaba.com> <20240327111430.108787-4-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240327111430.108787-4-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 28 Mar 2024 14:56:55 +0800
Message-ID: <CACGkMEvGTiZUepzRL9dMNaxZUenKzrqPnnd9594aWjF-KcXCrw@mail.gmail.com>
Subject: Re: [PATCH vhost v6 03/10] virtio_ring: packed: structure the
 indirect desc table
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2024 at 7:14=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> This commit structure the indirect desc table.
> Then we can get the desc num directly when doing unmap.
>
> And save the dma info to the struct, then the indirect
> will not use the dma fields of the desc_extra. The subsequent
> commits will make the dma fields are optional.

Nit: It's better to add something like "so we can't reuse the
desc_extra[] array"

> But for
> the indirect case, we must record the dma info.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/virtio/virtio_ring.c | 61 +++++++++++++++++++-----------------
>  1 file changed, 33 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index a2838fe1cc08..e3343cf55774 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -74,7 +74,7 @@ struct vring_desc_state_split {
>
>  struct vring_desc_state_packed {
>         void *data;                     /* Data for callback. */
> -       struct vring_packed_desc *indir_desc; /* Indirect descriptor, if =
any. */
> +       struct vring_desc_extra *indir_desc; /* Indirect descriptor, if a=
ny. */

Should be "DMA info with indirect descriptor, if any" ?

>         u16 num;                        /* Descriptor list length. */
>         u16 last;                       /* The last desc state in a list.=
 */
>  };
> @@ -1243,10 +1243,13 @@ static void vring_unmap_desc_packed(const struct =
vring_virtqueue *vq,
>                        DMA_FROM_DEVICE : DMA_TO_DEVICE);
>  }
>
> -static struct vring_packed_desc *alloc_indirect_packed(unsigned int tota=
l_sg,
> -                                                      gfp_t gfp)
> +static struct vring_desc_extra *alloc_indirect_packed(unsigned int total=
_sg,
> +                                                     gfp_t gfp)
>  {
> -       struct vring_packed_desc *desc;
> +       struct vring_desc_extra *in_extra;
> +       u32 size;
> +
> +       size =3D sizeof(*in_extra) + sizeof(struct vring_packed_desc) * t=
otal_sg;
>
>         /*
>          * We require lowmem mappings for the descriptors because
> @@ -1255,9 +1258,10 @@ static struct vring_packed_desc *alloc_indirect_pa=
cked(unsigned int total_sg,
>          */
>         gfp &=3D ~__GFP_HIGHMEM;
>
> -       desc =3D kmalloc_array(total_sg, sizeof(struct vring_packed_desc)=
, gfp);
>
> -       return desc;
> +       in_extra =3D kmalloc(size, gfp);
> +
> +       return in_extra;
>  }
>
>  static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
> @@ -1268,6 +1272,7 @@ static int virtqueue_add_indirect_packed(struct vri=
ng_virtqueue *vq,
>                                          void *data,
>                                          gfp_t gfp)
>  {
> +       struct vring_desc_extra *in_extra;
>         struct vring_packed_desc *desc;
>         struct scatterlist *sg;
>         unsigned int i, n, err_idx;
> @@ -1275,10 +1280,12 @@ static int virtqueue_add_indirect_packed(struct v=
ring_virtqueue *vq,
>         dma_addr_t addr;
>
>         head =3D vq->packed.next_avail_idx;
> -       desc =3D alloc_indirect_packed(total_sg, gfp);
> -       if (!desc)
> +       in_extra =3D alloc_indirect_packed(total_sg, gfp);
> +       if (!in_extra)
>                 return -ENOMEM;
>
> +       desc =3D (struct vring_packed_desc *)(in_extra + 1);
> +
>         if (unlikely(vq->vq.num_free < 1)) {
>                 pr_debug("Can't add buf len 1 - avail =3D 0\n");
>                 kfree(desc);
> @@ -1315,17 +1322,16 @@ static int virtqueue_add_indirect_packed(struct v=
ring_virtqueue *vq,
>                 goto unmap_release;
>         }
>
> +       if (vq->use_dma_api) {
> +               in_extra->addr =3D addr;
> +               in_extra->len =3D total_sg * sizeof(struct vring_packed_d=
esc);
> +       }

Any reason why we don't do it after the below assignment of descriptor fiel=
ds?

> +
>         vq->packed.vring.desc[head].addr =3D cpu_to_le64(addr);
>         vq->packed.vring.desc[head].len =3D cpu_to_le32(total_sg *
>                                 sizeof(struct vring_packed_desc));
>         vq->packed.vring.desc[head].id =3D cpu_to_le16(id);
>
> -       if (vq->use_dma_api) {
> -               vq->packed.desc_extra[id].addr =3D addr;
> -               vq->packed.desc_extra[id].len =3D total_sg *
> -                               sizeof(struct vring_packed_desc);
> -       }
> -
>         vq->packed.desc_extra[id].flags =3D VRING_DESC_F_INDIRECT |
>                 vq->packed.avail_used_flags;
>
> @@ -1356,7 +1362,7 @@ static int virtqueue_add_indirect_packed(struct vri=
ng_virtqueue *vq,
>         /* Store token and indirect buffer state. */
>         vq->packed.desc_state[id].num =3D 1;
>         vq->packed.desc_state[id].data =3D data;
> -       vq->packed.desc_state[id].indir_desc =3D desc;
> +       vq->packed.desc_state[id].indir_desc =3D in_extra;
>         vq->packed.desc_state[id].last =3D id;
>
>         vq->num_added +=3D 1;
> @@ -1375,7 +1381,7 @@ static int virtqueue_add_indirect_packed(struct vri=
ng_virtqueue *vq,
>                 vring_unmap_desc_packed(vq, &desc[i]);
>
>  free_desc:
> -       kfree(desc);
> +       kfree(in_extra);
>
>         END_USE(vq);
>         return -ENOMEM;
> @@ -1589,7 +1595,6 @@ static void detach_buf_packed(struct vring_virtqueu=
e *vq,
>                               unsigned int id, void **ctx)
>  {
>         struct vring_desc_state_packed *state =3D NULL;
> -       struct vring_packed_desc *desc;
>         unsigned int i, curr;
>         u16 flags;
>
> @@ -1616,27 +1621,27 @@ static void detach_buf_packed(struct vring_virtqu=
eue *vq,
>                 if (ctx)
>                         *ctx =3D state->indir_desc;
>         } else {
> -               const struct vring_desc_extra *extra;
> -               u32 len;
> +               struct vring_desc_extra *in_extra;
> +               struct vring_packed_desc *desc;
> +               u32 num;
> +
> +               in_extra =3D state->indir_desc;
>
>                 if (vq->use_dma_api) {
> -                       extra =3D &vq->packed.desc_extra[id];
>                         dma_unmap_single(vring_dma_dev(vq),
> -                                        extra->addr, extra->len,
> +                                        in_extra->addr, in_extra->len,
>                                          (flags & VRING_DESC_F_WRITE) ?
>                                          DMA_FROM_DEVICE : DMA_TO_DEVICE)=
;

Can't we just reuse vring_unmap_extra_packed() here?

Thanks


>                 }
>
> -               /* Free the indirect table, if any, now that it's unmappe=
d. */
> -               desc =3D state->indir_desc;
> -
>                 if (vring_need_unmap_buffer(vq)) {
> -                       len =3D vq->packed.desc_extra[id].len;
> -                       for (i =3D 0; i < len / sizeof(struct vring_packe=
d_desc);
> -                                       i++)
> +                       num =3D in_extra->len / sizeof(struct vring_packe=
d_desc);
> +                       desc =3D (struct vring_packed_desc *)(in_extra + =
1);
> +
> +                       for (i =3D 0; i < num; i++)
>                                 vring_unmap_desc_packed(vq, &desc[i]);
>                 }
> -               kfree(desc);
> +               kfree(in_extra);
>                 state->indir_desc =3D NULL;
>         }
>  }
> --
> 2.32.0.3.g01195cf9f
>


