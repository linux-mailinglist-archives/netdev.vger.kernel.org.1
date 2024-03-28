Return-Path: <netdev+bounces-82737-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 017F588F835
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 07:57:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 523C7B21AC1
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 06:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB1D4E1C9;
	Thu, 28 Mar 2024 06:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PI6JPjUP"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD6C23768
	for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 06:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711609026; cv=none; b=M3lFAe9bBH0r8z1cC33LfEbka9FsqZJheb10N7mQZI0HbXWEa4nwoFA07HgJQQNioQsX2luUbY/9/O2OFaC1Y9TlPySYnaMzDx1/xMLgUQYajPW8WKHPuQvLyLGYX9onczc/SgVvfRpRHBe8pb6x1l8nqg5gZnv2EpnU1+G0iZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711609026; c=relaxed/simple;
	bh=iXkcM/kbPxaG7Dl6XHZroMQUMorZdH4sUWDFUR+CYd8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ooc4SgKRYaXT52VYBf99aD+N+VDUBcSTj0ifqNFNTgf383roZuPYLNjVvo9jEym37BK7BvGVdB0G2ELUWed0LnOiHn18BiTBRiKfwxDHSzuRAz970gjojiHXy0Mi6kFOkgYzRjNPFhI9Dmv5Q3co6rrJ/PkDSMLJBoouNYFBq7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PI6JPjUP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711609022;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nsK18a2ILjQix0qPhtSFbid27rM+BJi4PiLxBjwl3pQ=;
	b=PI6JPjUPKj2WqtqnbFi0ksfmfIp3aBWJoAbe+B1PuVwi6IPV+cY2eVAz+2w6c4Vx3X6r9m
	lUCHqG5FUkL6vJ3AHsGs+8tma1tZhAbh8z2x3cNNNSRAnszBIW0IG2M1yKSfKBB+R50svS
	Wtxj8Cctgye6Xs4eNHq9PiNWhFQJvJg=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-5z-l55KiMq-ttB6bj71aRA-1; Thu, 28 Mar 2024 02:57:00 -0400
X-MC-Unique: 5z-l55KiMq-ttB6bj71aRA-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-6ea7dfa61d8so563897b3a.0
        for <netdev@vger.kernel.org>; Wed, 27 Mar 2024 23:57:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711609019; x=1712213819;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nsK18a2ILjQix0qPhtSFbid27rM+BJi4PiLxBjwl3pQ=;
        b=VylpXtcmR4/lBBiVmCPF5zU9UeWF4YCqlpHZnDb72slmPJ9ywXPp2mxp7O6vj2kICR
         G7QCaN6ktYVLI2IEgYi3/4/0tQKn0CitQ/2gh0tHFi/MPBM0SykT+6DLVpSZDdUxg6Vl
         qi1IUA+eX5pdpSCaicxLK1l2a3ZdJFrNrU0aWC80vpjafOPnjNtErt95XtPD0BOJWp0Y
         +91kEy9z9bvgQv3sGCxiPSdpaUIoXnmV4d3vGUgOUA2zhj8VmQeZzv2GYRi99cXw/pji
         GQwVPPy7z1dVlK6gdKspIvK2qxsTPS5ZihaUB6YzxdwqL1s+e7Dko86Nq9EBSOpsdyCN
         k9Sw==
X-Forwarded-Encrypted: i=1; AJvYcCW0XWhB1O14b1YL06Du8HjDvga2sQUCfUBfiUGxmrmoa0bwOXErYD8WvVQ85r+FKbvU+GKZuiJsJoZIstNZVcukjB+xgai4
X-Gm-Message-State: AOJu0Yz3GbZMiLcyjpTKI+JfGBlDjP2GclE3bjw6Et61i1d3BVX2adam
	MhMmchtIPxwsObdAUstvK+Y5OvYQW+6vAy6TkzAD0if6yzIQQyQO4MslJlYoZFn0gaukBHycTjk
	aSW9MUMopnjhKoSgm+gMFjcltOzJmUklPEVuhOUT3UIHXYTTqeNo1tkK2HYoiT7LtknRM2RzONH
	Xn47csges5lDZQyC87QN0/cPO6Nj8B
X-Received: by 2002:a05:6a20:841b:b0:1a3:a89b:a70a with SMTP id c27-20020a056a20841b00b001a3a89ba70amr2186888pzd.37.1711609019270;
        Wed, 27 Mar 2024 23:56:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEddMUjn8tC2lHIpEO3qvN67cxCYRi/vADbnxsX/QgXJYkiSLSMf4a+H2E0/VdbN6DSIYhQ1sbi4bTpiV3OlWY=
X-Received: by 2002:a05:6a20:841b:b0:1a3:a89b:a70a with SMTP id
 c27-20020a056a20841b00b001a3a89ba70amr2186874pzd.37.1711609018938; Wed, 27
 Mar 2024 23:56:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327111430.108787-1-xuanzhuo@linux.alibaba.com> <20240327111430.108787-3-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240327111430.108787-3-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 28 Mar 2024 14:56:47 +0800
Message-ID: <CACGkMEsG7+mNx4WqhAuhrpk1bhLEwrTzngT5q=CZ_aHkzRasVg@mail.gmail.com>
Subject: Re: [PATCH vhost v6 02/10] virtio_ring: packed: remove double check
 of the unmap ops
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2024 at 7:14=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
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
> For desc with VRING_DESC_F_INDIRECT flag:
> 1. only one desc of the desc table is used, we do not need the loop
>     Theoretically, indirect descriptors could be chained.
>     But now, that is not supported by "add", so we ignore this case.
> 2. the called unmap api is difference from the other desc
> 3. the vq->premapped is not needed to check
> 4. the vq->indirect is not needed to check
> 5. the state->indir_desc must not be null

It doesn't explain the connection to the goal of this series. If it's
not a must I'd suggest moving it to a separate patch.

>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

Rethink this, it looks to me it would complicate the codes furtherly.

For example, vring_map_xxx() helpers will check premappred and
use_dma_api by itself. But in the case of vring_unmap() you want to
move those checks to the caller. This will result in tricky codes that
are hard to understand.

We need to be consistent here.

If we try to optimize unmap we need to optimize map as well. But
generally it would complicate the logic of the caller if we want to
let the caller to differ. Ideally, the caller of those function should
know nothing about use_dma_api, premapped and other.

> ---
>  drivers/virtio/virtio_ring.c | 78 ++++++++++++++++++------------------
>  1 file changed, 40 insertions(+), 38 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 03360073bd4a..a2838fe1cc08 100644
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

I would do this to make it much more easier to be read and avoid the warn:

if (vring_mapping_error(vq, addr))
        goto unmap_release;

unmap_release:
        if (vring_need_unmap_buffer(vq))
                for (i =3D 0, xxx)
free_desc:
        kfree(desc);

or it could be

unmap_release:
      if (!vring_need_unmap_buffer(vq))
            goto free_desc;

Still tricky but better.

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

An example of the tricky code, I think you do this because you want to
differ indirect in detach_buf_packed():

flags =3D vq->packed.desc_extra[id].flags;


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

Can we check vq->indirect && indir_desc here? Then we don't need
special care to store flags in desc_extra.

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

Thanks


