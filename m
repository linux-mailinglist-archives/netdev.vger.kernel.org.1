Return-Path: <netdev+bounces-89000-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C868A92D5
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 08:14:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C945B2120F
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 06:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40EC5612F6;
	Thu, 18 Apr 2024 06:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DYaVT3Az"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C143399B
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 06:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713420841; cv=none; b=WfaGZ+sdpxFxTurNdziFpigF8Yq9cuk5KGi8FNfsUTk8Qs/IdfIg7Xr1lLXSnKEFfaRF8JjulEOSFXaOPgLNb+FMZkZnZrwS+hr2Ke9ZBB5IrmiNHZZH3CY8oceQ3Eup9Iy8bAxQwPtPZAWdCPaCZiSSzUaQ7Dj/glxd6fZ4ar4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713420841; c=relaxed/simple;
	bh=DzHtYet7xw33U75FxEw5lUmOXI3xG0fMjLZjCs81rD0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nXPdfT/wL0dPa2nD6v0OsaeNxWx82lLjmfCx1KA9gtddfnjiuY1hUCfJzElnY7do9XDytsJQb1lMkk76wojL6aDXxJG/1LRUaRI2qB/Hw9MYnYMVAx+pg1et/bDkqFvtpyKSEzDX9CyKhFGNDiKfCSUzsq53jXnAN+HsMX5H8qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DYaVT3Az; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713420838;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cyAsixzg/C7NuM2YrjqrwtUhaKllzlyI1uPLxkOcmsM=;
	b=DYaVT3AzM3eLdPQRYMhQIDOIAtwT/u/WrgoBaD1TMJDIiUBYe9eKNmxT0Go9Irwas14gL6
	O0guuClzcWtQhjGPQ6MrzJTy/6hlWqGIJIiTSdVcU9fg0+NpBlGS7NktEoFn/SCybY42lK
	xGYYWJdvO2cXsHQAu8TRIfy55qJIX3E=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-361-Et5IMmRGMt2SHCQaKS3pIQ-1; Thu, 18 Apr 2024 02:13:56 -0400
X-MC-Unique: Et5IMmRGMt2SHCQaKS3pIQ-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2a2bc796cf4so724259a91.0
        for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 23:13:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713420836; x=1714025636;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cyAsixzg/C7NuM2YrjqrwtUhaKllzlyI1uPLxkOcmsM=;
        b=Yhw/k/eNMz8USWS9eO0Z0F6WCGvqtwp6FiRo/dhyJGkvFwUGB+ek6JwnU2TOb9bJSJ
         7bHOq5Vgnc6jfV8ooTm+0M6IuTMBx0I/g+eYssuu0JkR7PMeEXQmmwIFQDOuMtjcp/+w
         YqJ/BaNGlmhoaOV4rgioNUbc9dgUJbJfNqwklSIQbV1UyTG5UicOwZX8ArEYzoQEgfAR
         Q/1p9WdklLv0A9iC/WLDGimpYcC3tH8zbXZeLojK5M2qeKVSMJMIq98ONzMwXMn72rVL
         bMnPavIHeYh/1qQ3sl4/QhQB76JV02EPQeJhClpKNHSthHZ9AtVUxATCcR9uOBMVnNKM
         Xeog==
X-Forwarded-Encrypted: i=1; AJvYcCVecileGFc9sa8FJDUIbH7emz1Hpdf0psMjqHmL6464risC32sU/rKx05rDozVBc5eCiwkCeLIj4d8IUU1eXkPz5OJyqEGP
X-Gm-Message-State: AOJu0YwSQJ+itbl8xVhnYbDkHsZk+UbsDrao5v8o9h/EuN/Fq1ZXNhHk
	01vGulfYFM7r788x0+0FNOeOWj5vxigY6C9jICAUhCSkUqTJdKKzf4gnaTOGnZqvyaO7XyAyHpj
	XX9O/X1N7CcIKDisT/AREI4mfvpJLE54iad6B3l6fsMekQQ/Ob0KM2EDmeq3S/1sVd+oZE/HQKP
	CaQxctr6lMerI+woOJeiDpFUwKoMlL
X-Received: by 2002:a17:90b:253:b0:29b:b3fa:b7a5 with SMTP id fz19-20020a17090b025300b0029bb3fab7a5mr1690935pjb.7.1713420835846;
        Wed, 17 Apr 2024 23:13:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHVdzu9+TyIRaPXKFdcEi9FoNx1ow6iyhMtDgpvTH0oQRz2sSRKXwXqslukumyf5i3Aw/86PTvEgHH+60ZGtgs=
X-Received: by 2002:a17:90b:253:b0:29b:b3fa:b7a5 with SMTP id
 fz19-20020a17090b025300b0029bb3fab7a5mr1690925pjb.7.1713420835550; Wed, 17
 Apr 2024 23:13:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411025127.51945-1-xuanzhuo@linux.alibaba.com> <20240411025127.51945-3-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240411025127.51945-3-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 18 Apr 2024 14:13:44 +0800
Message-ID: <CACGkMEt8hZ3UdMwuANu2KwMFAeZ3DvD9n5UcqJTbZE+eQtM=ow@mail.gmail.com>
Subject: Re: [PATCH vhost 2/6] virtio_ring: enable premapped mode whatever use_dma_api
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 10:51=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibaba.=
com> wrote:
>
> Now, we have virtio DMA APIs, the driver can be the premapped
> mode whatever the virtio core uses dma api or not.
>
> So remove the limit of checking use_dma_api from
> virtqueue_set_dma_premapped().
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/virtio/virtio_ring.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 1b9fb680cff3..72c438c5f7d7 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -2730,7 +2730,7 @@ EXPORT_SYMBOL_GPL(virtqueue_resize);
>   *
>   * Returns zero or a negative error.
>   * 0: success.
> - * -EINVAL: vring does not use the dma api, so we can not enable premapp=
ed mode.
> + * -EINVAL: NOT called immediately.

Let's tweak the comment here, for example, we can say the vq is in use.

Thanks

>   */
>  int virtqueue_set_dma_premapped(struct virtqueue *_vq)
>  {
> @@ -2746,11 +2746,6 @@ int virtqueue_set_dma_premapped(struct virtqueue *=
_vq)
>                 return -EINVAL;
>         }
>
> -       if (!vq->use_dma_api) {
> -               END_USE(vq);
> -               return -EINVAL;
> -       }
> -
>         vq->premapped =3D true;
>         vq->do_unmap =3D false;
>
> --
> 2.32.0.3.g01195cf9f
>


