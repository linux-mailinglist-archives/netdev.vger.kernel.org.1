Return-Path: <netdev+bounces-82754-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7FC88F94B
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 08:58:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FFDFB2385F
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 07:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 887E151C21;
	Thu, 28 Mar 2024 07:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ddl8Djyq"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF8942A8E
	for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 07:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711612705; cv=none; b=MeUI1XnZrlEncS+mShTduLkQn2wozScE3g0VAthOBMugLqsY6a/Tv3RR0YQHjLyGU0+Rn50+VQpZlYdHQCBIVyLoMT2KA0/2B2sMrp4iF6h5VhrAs0In1EIfJfoqFh1E86rey3P764UdAg9iP+zULPbQjEDj9M+1Pw2TpxLaDRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711612705; c=relaxed/simple;
	bh=wgar9MFt+ebTKBR0AhWjQsDpdIJDQJ/4kaniC1csFIk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MGqG6ZYmASyhhhGBFd2I3ju3ydgQnIUYvhhcIsTP9Yh/okIr9xhlelofdlYfel9A16/C6ZmfXj/tDyjhspzreg+ulFGYpRkVTNnnMN4+aYuyfcCZ9+KP4xbNI4S7/OSDXP2IlAtpkCzCXNJiejN6Yb+JQYasLJJTa8dWvnoQf/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ddl8Djyq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711612702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a/6Ik9J8vGv/Si18wlwWefqXsxMxZ3gle8zHK3RoExc=;
	b=Ddl8DjyqSgjQ/yTN12ubNCZErQGiuGGwWtWea766+qUNXItBbmLpUUwhbTm1GO7zLEAjrn
	+YFc8ZnYu/rhAS26dQTEmW2VR9HZm/0aDgKDSYaxP90BvWOF85tA2FZA2BHPRM1fz0dXF7
	ZXpOEujGHlhHNGb69ETGdiKogrOfI9c=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-491-A75CnSPHNDmd-TEXNEKtxg-1; Thu, 28 Mar 2024 03:58:20 -0400
X-MC-Unique: A75CnSPHNDmd-TEXNEKtxg-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-29df9eab3d4so600824a91.0
        for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 00:58:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711612699; x=1712217499;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a/6Ik9J8vGv/Si18wlwWefqXsxMxZ3gle8zHK3RoExc=;
        b=QoYRhg8v4zMeXTPweG9RSM+zHDqIwoaNfBW0zGkGcUfAHgkk66grfaPLDowTX14Ops
         GPYx9T0ZFYbICzwXTYHvhKEgFI/7uTke7fpdLdBqiuX0ULbq8esOkh8sDobMthnR2L4o
         910xZEfOaNS8SQnsWJbLjnzjq9aqb8qZHSYupzBQ7IEb9wUGorbedHTNAdyuIJmGAcvc
         vd87+je0Hw0lGLMrMRouQBeI59vlide6pJiFgepIx5PsXA4unA/8WR9aNm+v4b0mmxJ9
         y0K6lk84t9od354m09l9Nswk/6Eu8LfLooJPtJ9A/TKfRTzANX7aAynxVP6+DAGOi5YC
         r+Pw==
X-Forwarded-Encrypted: i=1; AJvYcCXZYJINXsay4/NinoQ4NvXAdogiQPegCYwbWbuCYZ6sXkazv9IGTnuPxrMbbV7VS1inV6XT+dRmeOemiTxIeCOfoxYd2hFb
X-Gm-Message-State: AOJu0YzS1ohMZ3l/iFZ8gsQC1/7hLsG9zGFKWDZef4t5id+WE36Q7nqg
	SzgTfwMU1mSu+GoR2frykWn7CZs67szw5ZdYrhacXP/hlajWrLcX/2qofnHZ/mqPEI0kSEkLOpZ
	cu3xCVVtoidAWOY52pHc0BZj43yoQHueInO0klHsTcBPYpj+4GhJuLUfUlBHbrEqkTrRrLeNlzH
	3zYjfdy7UXWdye1W/usX3S+JmV4ey7
X-Received: by 2002:a17:90a:4586:b0:29c:7592:febf with SMTP id v6-20020a17090a458600b0029c7592febfmr1690143pjg.16.1711612699597;
        Thu, 28 Mar 2024 00:58:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFblJp9w0pny5TjOhPfMS/kOyIQGBRDXwLRHifvEJFIeWVGOgBsTHymmXZIkSJ83ttYn4rXXzxGFePsKH9/fyA=
X-Received: by 2002:a17:90a:4586:b0:29c:7592:febf with SMTP id
 v6-20020a17090a458600b0029c7592febfmr1690136pjg.16.1711612699330; Thu, 28 Mar
 2024 00:58:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327111430.108787-1-xuanzhuo@linux.alibaba.com> <20240327111430.108787-9-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240327111430.108787-9-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 28 Mar 2024 15:58:08 +0800
Message-ID: <CACGkMEv9YCaWAPhcFcLkHaHMz-A6mHyM3pqHjYKooEpNkFn0CQ@mail.gmail.com>
Subject: Re: [PATCH vhost v6 08/10] virtio_ring: export premapped to driver by
 struct virtqueue
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2024 at 7:14=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> Export the premapped to drivers, then drivers can check
> the vq premapped mode after the find_vqs().
> Because the find_vqs() just try to enable the vq premapped mode,
> the driver must check that after find_vqs().

What's the reason for this? For example, we never export use_dma_api.

Thanks

>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/virtio/virtio_ring.c | 13 +++++--------
>  include/linux/virtio.h       |  1 +
>  2 files changed, 6 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index bbdeab3a9648..543204e26c5a 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -177,9 +177,6 @@ struct vring_virtqueue {
>         /* Host publishes avail event idx */
>         bool event;
>
> -       /* Do DMA mapping by driver */
> -       bool premapped;
> -
>         /* Head of free buffer list. */
>         unsigned int free_head;
>         /* Number we've added since last sync. */
> @@ -297,7 +294,7 @@ static bool vring_use_dma_api(const struct virtio_dev=
ice *vdev)
>
>  static bool vring_need_unmap_buffer(const struct vring_virtqueue *vring)
>  {
> -       return vring->use_dma_api && !vring->premapped;
> +       return vring->use_dma_api && !vring->vq.premapped;
>  }
>
>  size_t virtio_max_dma_size(const struct virtio_device *vdev)
> @@ -369,7 +366,7 @@ static struct device *vring_dma_dev(const struct vrin=
g_virtqueue *vq)
>  static int vring_map_one_sg(const struct vring_virtqueue *vq, struct sca=
tterlist *sg,
>                             enum dma_data_direction direction, dma_addr_t=
 *addr)
>  {
> -       if (vq->premapped) {
> +       if (vq->vq.premapped) {
>                 *addr =3D sg_dma_address(sg);
>                 return 0;
>         }
> @@ -2148,7 +2145,7 @@ static struct virtqueue *vring_create_virtqueue_pac=
ked(struct virtio_device *vde
>         vq->packed_ring =3D true;
>         vq->dma_dev =3D dma_dev;
>         vq->use_dma_api =3D vring_use_dma_api(vdev);
> -       vq->premapped =3D vq->use_dma_api && cfg_vq_get(cfg, vq, premappe=
d);
> +       vq->vq.premapped =3D vq->use_dma_api && cfg_vq_get(cfg, vq, prema=
pped);
>
>         vq->indirect =3D virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_=
DESC) &&
>                 !cfg_vq_get(cfg, vq, ctx);
> @@ -2696,7 +2693,7 @@ static struct virtqueue *__vring_new_virtqueue(stru=
ct virtio_device *vdev,
>  #endif
>         vq->dma_dev =3D tp_cfg->dma_dev;
>         vq->use_dma_api =3D vring_use_dma_api(vdev);
> -       vq->premapped =3D vq->use_dma_api && cfg_vq_get(cfg, vq, premappe=
d);
> +       vq->vq.premapped =3D vq->use_dma_api && cfg_vq_get(cfg, vq, prema=
pped);
>
>         vq->indirect =3D virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_=
DESC) &&
>                 !cfg_vq_get(cfg, vq, ctx);
> @@ -2832,7 +2829,7 @@ int virtqueue_set_dma_premapped(struct virtqueue *_=
vq)
>                 return -EINVAL;
>         }
>
> -       vq->premapped =3D true;
> +       vq->vq.premapped =3D true;
>
>         if (vq->packed_ring) {
>                 kfree(vq->packed.desc_dma);
> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> index b0201747a263..407277d5a16b 100644
> --- a/include/linux/virtio.h
> +++ b/include/linux/virtio.h
> @@ -36,6 +36,7 @@ struct virtqueue {
>         unsigned int num_free;
>         unsigned int num_max;
>         bool reset;
> +       bool premapped;
>         void *priv;
>  };
>
> --
> 2.32.0.3.g01195cf9f
>


