Return-Path: <netdev+bounces-80944-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B851881C3B
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 06:57:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9A5C1F213F1
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 05:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965FE381AA;
	Thu, 21 Mar 2024 05:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CcGYtGBq"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BDE125CB
	for <netdev@vger.kernel.org>; Thu, 21 Mar 2024 05:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711000642; cv=none; b=ZU7i9yMbtY2jcoXbNUjtxt2bxtA6Ep1SXmteCFOqgHOtqSTHvcv4Kac5yWJrqqQmholuq9qot03+Mpf1/bbVDLs80To/p/v0bbgoM+5gUxDjvWhuH/hAZCjDaG6wGd/FOvAsAd/jiGURwwv0LMPzPC+srwTVXsVuOnzS+OQha18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711000642; c=relaxed/simple;
	bh=ZkCXtl7Wyj/Ulyi97an5B0f6ez4cfoPYlK87QSV8OSM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cGHkhEwbTU6LXRbAp7mDF0HuedPQsWofj0oZksZPfiVVE3jlz/a/neyyUUck5KBRXCFvk0arqogeGWZDP+Mgk6hUfUPV2PcCJr4sb/WS2f1TdLSFnmbmoBZpbMFgiV0YOQ1bsCz++MOcG5PNsaN2h+5C/46r7JknYGlsZgNxP5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CcGYtGBq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711000639;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x8/Y+EQ9Lzkt9PPoByxYvT4F7ruhVkbKSru1lDPTO3E=;
	b=CcGYtGBq7pdjkLfSh1J4PE56asb1bhHGHcAGAhFxtI1iIVRrxpNnY94kJJZE1MbGqsC+t0
	9TWmtcTiMBXj8AuZe6YcH9l+KfeiygZeGsQoeEYGt9YlMNq5qNyYM07Q0LA4a+rfFeNEeJ
	XEgJsTkUdFfjEaNDrYAXbjgykHP+xqk=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-8g5unjiwNymalegaju_1Jw-1; Thu, 21 Mar 2024 01:57:17 -0400
X-MC-Unique: 8g5unjiwNymalegaju_1Jw-1
Received: by mail-yb1-f198.google.com with SMTP id 3f1490d57ef6-dc743cc50a6so783124276.2
        for <netdev@vger.kernel.org>; Wed, 20 Mar 2024 22:57:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711000637; x=1711605437;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x8/Y+EQ9Lzkt9PPoByxYvT4F7ruhVkbKSru1lDPTO3E=;
        b=EXJa/QVhlp+evJRMG6EJZgDNASgnwOx69ggTO0fRGVqkUJ8RWIx/gKrbRpeN63gHg0
         AWeVJJRjPRQy4yLCOPp2sdlcXHeC0MnQs2mJeFAPIFZx1d8MucdHoos9v5787irz2Wdq
         atkXY/xF1yl64W6NFbHUl5oSwIXN63Gqq9GvJgFBl/JY2yl4VL94AUDcYRCXBadZkYuc
         L2rPfmRbvnWmfe/epynPRff4y15eOFiAHGykhIYgQt8rvwzYHYa1R2Jg4hewKBSUS0Yg
         hfMdriWmYQdEg+2RIYYbRQte2xVtVzf8AAAFz6iPYqNIzPFwdQEQAwOwp6qHr5n+HL/c
         Szjg==
X-Forwarded-Encrypted: i=1; AJvYcCUIBW5C7sr4z1XEwckIDDfaYBG7eXrHE0XqLOZC2f5VuJ6ezmunB5k/AKUk7E92beoGaOEPqVfZ0lXMMZZe9BhGErkx00Lg
X-Gm-Message-State: AOJu0Yx3K2w3y/FQScgcWqAvjAKriVTIGvwgBNR7wufGZvU8vQRCI1RI
	3EaGdO/d8y6aNXHJxGNCVSLLjDkcnKAgRPns7JiIKqIMzM0d0w3nnGB3cEK1FDNdlqTeQS8i3ft
	YdpUg6zsJZB43/Zukaj+M7AyMAJe81RIupqsJ5FnNjRkNzausz1LjQmTEfDzDntT/0qMKABFtbp
	32qcN5IRIad0shYDW7NKFqgagZ84yV
X-Received: by 2002:a25:ce41:0:b0:dcb:f5f9:c062 with SMTP id x62-20020a25ce41000000b00dcbf5f9c062mr19303849ybe.14.1711000637358;
        Wed, 20 Mar 2024 22:57:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHAgeWX+uvAxexiH0TkGZEbcAN/ujoS4BSpT2aF4lMWLqfRbJEPxRSjvTXMgygwxwjhqLi47bvGr/FXa6HBEsI=
X-Received: by 2002:a25:ce41:0:b0:dcb:f5f9:c062 with SMTP id
 x62-20020a25ce41000000b00dcbf5f9c062mr19303835ybe.14.1711000636921; Wed, 20
 Mar 2024 22:57:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240312033557.6351-1-xuanzhuo@linux.alibaba.com> <20240312033557.6351-3-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240312033557.6351-3-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 21 Mar 2024 13:57:06 +0800
Message-ID: <CACGkMEtd1L=Cm0DWLZbfSazxxHr+iPP77B1kM=PmjdqeYoAz4w@mail.gmail.com>
Subject: Re: [PATCH vhost v4 02/10] virtio_ring: packed: remove double check
 of the unmap ops
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2024 at 11:36=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibaba.=
com> wrote:
>
> In the functions vring_unmap_extra_packed and vring_unmap_desc_packed,
> multiple checks are made whether unmap is performed and whether it is
> INDIRECT.
>
> These two functions are usually called in a loop, and we should put the
> check outside the loop.
>
> And we unmap the descs with VRING_DESC_F_INDIRECT on the same path with
> other descs, that make the thing more complex. If we distinguish the
> descs with VRING_DESC_F_INDIRECT before unmap, thing will be clearer.
>
> 1. only one desc of the desc table is used, we do not need the loop
> 2. the called unmap api is difference from the other desc
> 3. the vq->premapped is not needed to check
> 4. the vq->indirect is not needed to check
> 5. the state->indir_desc must not be null
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/virtio/virtio_ring.c | 78 ++++++++++++++++++------------------
>  1 file changed, 40 insertions(+), 38 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index c2779e34aac7..0dfbd17e5a87 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -1214,6 +1214,7 @@ static u16 packed_last_used(u16 last_used_idx)
>         return last_used_idx & ~(-(1 << VRING_PACKED_EVENT_F_WRAP_CTR));
>  }
>
> +/* caller must check vring_need_unmap_buffer() */
>  static void vring_unmap_extra_packed(const struct vring_virtqueue *vq,
>                                      const struct vring_desc_extra *extra=
)
>  {
> @@ -1221,33 +1222,18 @@ static void vring_unmap_extra_packed(const struct=
 vring_virtqueue *vq,
>
>         flags =3D extra->flags;
>
> -       if (flags & VRING_DESC_F_INDIRECT) {
> -               if (!vq->use_dma_api)
> -                       return;
> -
> -               dma_unmap_single(vring_dma_dev(vq),
> -                                extra->addr, extra->len,
> -                                (flags & VRING_DESC_F_WRITE) ?
> -                                DMA_FROM_DEVICE : DMA_TO_DEVICE);
> -       } else {
> -               if (!vring_need_unmap_buffer(vq))
> -                       return;
> -
> -               dma_unmap_page(vring_dma_dev(vq),
> -                              extra->addr, extra->len,
> -                              (flags & VRING_DESC_F_WRITE) ?
> -                              DMA_FROM_DEVICE : DMA_TO_DEVICE);
> -       }
> +       dma_unmap_page(vring_dma_dev(vq),
> +                      extra->addr, extra->len,
> +                      (flags & VRING_DESC_F_WRITE) ?
> +                      DMA_FROM_DEVICE : DMA_TO_DEVICE);
>  }
>
> +/* caller must check vring_need_unmap_buffer() */
>  static void vring_unmap_desc_packed(const struct vring_virtqueue *vq,
>                                     const struct vring_packed_desc *desc)
>  {
>         u16 flags;
>
> -       if (!vring_need_unmap_buffer(vq))
> -               return;
> -
>         flags =3D le16_to_cpu(desc->flags);
>
>         dma_unmap_page(vring_dma_dev(vq),
> @@ -1323,7 +1309,7 @@ static int virtqueue_add_indirect_packed(struct vri=
ng_virtqueue *vq,
>                         total_sg * sizeof(struct vring_packed_desc),
>                         DMA_TO_DEVICE);
>         if (vring_mapping_error(vq, addr)) {
> -               if (vq->premapped)
> +               if (!vring_need_unmap_buffer(vq))
>                         goto free_desc;
>
>                 goto unmap_release;
> @@ -1338,10 +1324,11 @@ static int virtqueue_add_indirect_packed(struct v=
ring_virtqueue *vq,
>                 vq->packed.desc_extra[id].addr =3D addr;
>                 vq->packed.desc_extra[id].len =3D total_sg *
>                                 sizeof(struct vring_packed_desc);
> -               vq->packed.desc_extra[id].flags =3D VRING_DESC_F_INDIRECT=
 |
> -                                                 vq->packed.avail_used_f=
lags;
>         }
>
> +       vq->packed.desc_extra[id].flags =3D VRING_DESC_F_INDIRECT |
> +               vq->packed.avail_used_flags;
> +
>         /*
>          * A driver MUST NOT make the first descriptor in the list
>          * available before all subsequent descriptors comprising
> @@ -1382,6 +1369,8 @@ static int virtqueue_add_indirect_packed(struct vri=
ng_virtqueue *vq,
>  unmap_release:
>         err_idx =3D i;
>
> +       WARN_ON(!vring_need_unmap_buffer(vq));
> +
>         for (i =3D 0; i < err_idx; i++)
>                 vring_unmap_desc_packed(vq, &desc[i]);
>
> @@ -1475,12 +1464,13 @@ static inline int virtqueue_add_packed(struct vir=
tqueue *_vq,
>                         desc[i].len =3D cpu_to_le32(sg->length);
>                         desc[i].id =3D cpu_to_le16(id);
>
> -                       if (unlikely(vq->use_dma_api)) {
> +                       if (vring_need_unmap_buffer(vq)) {
>                                 vq->packed.desc_extra[curr].addr =3D addr=
;
>                                 vq->packed.desc_extra[curr].len =3D sg->l=
ength;
> -                               vq->packed.desc_extra[curr].flags =3D
> -                                       le16_to_cpu(flags);
>                         }
> +
> +                       vq->packed.desc_extra[curr].flags =3D le16_to_cpu=
(flags);
> +
>                         prev =3D curr;
>                         curr =3D vq->packed.desc_extra[curr].next;
>
> @@ -1530,6 +1520,8 @@ static inline int virtqueue_add_packed(struct virtq=
ueue *_vq,
>
>         vq->packed.avail_used_flags =3D avail_used_flags;
>
> +       WARN_ON(!vring_need_unmap_buffer(vq));
> +
>         for (n =3D 0; n < total_sg; n++) {
>                 if (i =3D=3D err_idx)
>                         break;
> @@ -1599,7 +1591,9 @@ static void detach_buf_packed(struct vring_virtqueu=
e *vq,
>         struct vring_desc_state_packed *state =3D NULL;
>         struct vring_packed_desc *desc;
>         unsigned int i, curr;
> +       u16 flags;
>
> +       flags =3D vq->packed.desc_extra[id].flags;
>         state =3D &vq->packed.desc_state[id];
>
>         /* Clear data ptr. */
> @@ -1609,22 +1603,32 @@ static void detach_buf_packed(struct vring_virtqu=
eue *vq,
>         vq->free_head =3D id;
>         vq->vq.num_free +=3D state->num;
>
> -       if (unlikely(vq->use_dma_api)) {
> -               curr =3D id;
> -               for (i =3D 0; i < state->num; i++) {
> -                       vring_unmap_extra_packed(vq,
> -                                                &vq->packed.desc_extra[c=
urr]);
> -                       curr =3D vq->packed.desc_extra[curr].next;
> +       if (!(flags & VRING_DESC_F_INDIRECT)) {
> +               if (vring_need_unmap_buffer(vq)) {
> +                       curr =3D id;
> +                       for (i =3D 0; i < state->num; i++) {
> +                               vring_unmap_extra_packed(vq,
> +                                                        &vq->packed.desc=
_extra[curr]);
> +                               curr =3D vq->packed.desc_extra[curr].next=
;
> +                       }
>                 }
> -       }
>
> -       if (vq->indirect) {
> +               if (ctx)
> +                       *ctx =3D state->indir_desc;
> +       } else {
> +               const struct vring_desc_extra *extra;
>                 u32 len;
>
> +               if (vq->use_dma_api) {
> +                       extra =3D &vq->packed.desc_extra[id];
> +                       dma_unmap_single(vring_dma_dev(vq),
> +                                        extra->addr, extra->len,
> +                                        (flags & VRING_DESC_F_WRITE) ?
> +                                        DMA_FROM_DEVICE : DMA_TO_DEVICE)=
;
> +               }

Theoretically, indirect descriptors could be chained. It is supported
without this patch but not here.

Thanks

> +
>                 /* Free the indirect table, if any, now that it's unmappe=
d. */
>                 desc =3D state->indir_desc;
> -               if (!desc)
> -                       return;
>
>                 if (vring_need_unmap_buffer(vq)) {
>                         len =3D vq->packed.desc_extra[id].len;
> @@ -1634,8 +1638,6 @@ static void detach_buf_packed(struct vring_virtqueu=
e *vq,
>                 }
>                 kfree(desc);
>                 state->indir_desc =3D NULL;
> -       } else if (ctx) {
> -               *ctx =3D state->indir_desc;
>         }
>  }
>
> --
> 2.32.0.3.g01195cf9f
>


