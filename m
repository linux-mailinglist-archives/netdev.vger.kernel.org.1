Return-Path: <netdev+bounces-104919-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D622190F1BC
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 17:09:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D34131C2345D
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 15:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9CB713E043;
	Wed, 19 Jun 2024 15:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VLaTq1EI"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CD03FB8B
	for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 15:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718809758; cv=none; b=DN8u0TW8WWdS3DD5XZ2sjPq4MoGnHqW6f6b3bmd0nMXsffEwILIwpjEq+pvzfHY91fRF/9iZtCknU8WGzBIV56XkNnDYR6APIrqZ9GL2zjk1a/Hl4nQmEqZI6lvNBsRn0fqbwrfVQPwF2OPW6eQKUHjd7gJbjzceSRYzLrcy4C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718809758; c=relaxed/simple;
	bh=512ZCaEEz4eWfZutUiztkEEEXYz1p7svVNn8c4qwTrU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DyRUGVLDBmtWPb5Iq5XRZsufm6MeShTI0LgQp9i++orcOcEuazLcVdnFpjt5RtKhQ31oTwVZ5IDepNvsayICg+sT/xsTFyaUA+uAo34urQhBJHsrQLc+lCNQrvCXquTSoCDK8c1IMr/NtcOJJL+gIP0mG5vEZm63u8qyxBY91ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VLaTq1EI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718809754;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BMIw7ds/nWlexouYyFojHRj11oBl9QxmnevyQlA8My8=;
	b=VLaTq1EIGO85WUpN8V20/jFBwEfDCDF986XX0MV7hxuCfcj6M4oVxE7kGCUQUoUMVPyN9N
	HGlEpjUWSpPwGITZ1EntGIzhEaqlRT6xo/BkCIeHdZaZy0s0h6BZ5EUjpvfA1CdAWV5SbX
	VOq9B+j0sAlXLTqkJFwMZZIZoYox8QI=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-8uoSFFDLMH6JXqaWOuc0rA-1; Wed, 19 Jun 2024 11:09:13 -0400
X-MC-Unique: 8uoSFFDLMH6JXqaWOuc0rA-1
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-62fb4a1f7bfso150324297b3.3
        for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 08:09:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718809752; x=1719414552;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BMIw7ds/nWlexouYyFojHRj11oBl9QxmnevyQlA8My8=;
        b=H3FJOJ1aOxt65MFIyZvgzOMskIHKEHFCFdqrXOEXhJ763Moa1lR9GPLlr5JGJ+8fGW
         IsrHwq23TkdiB9MWaA4oMRC9ssXomjaVTozH+FhHVKeAjdm34EEGT9ILp0Q48OOF1xBV
         KAOSvUYdokMMFIuqPImrX4UaDVkF8nWC2IHQT0o3S1Tkq9FMjR/0d7ZrnItgBI6Ce3Mq
         BS6LiZdSgJ2YO+b9tRhrClQHLk6fZBYQC/IN9bGzLAIruqNbdneay6fvZJSK8skGGJMr
         T1GY1lX3tc6BAYsIP9uLyvXGQ9rbo7Y4oUm1mhyn4maB7ZT5WySOtcWmVibxNgex1q7/
         fNrg==
X-Forwarded-Encrypted: i=1; AJvYcCUmceqR60BR9/zT713aSDnEfsRvzAPWTgUYD6tLgKBkr1IY4cnDyVDn9bUXFHI805bKKoL5J5nN82/LQkvpU/hvYGMgp9Os
X-Gm-Message-State: AOJu0YxYB34B8omzZ0pEWTxg8v2iZnh1VaMRgYqN1bg674F9cWuFa7U/
	S/67q7V/whGgb98Fe94288xJrB7v8Ak8R55pelyArzIqKsTtqrp4hY2JRi9SsDfrxuenVJtkY+o
	GNcsMr/P2tpHccF3sZ8y9Ka2ya9k2yED1PSGxoQl+s/oALmwoHbVKKHM4voUE0+b1AEefmgG4YB
	YsCxOX5TTJq4PwCYOO5uASh9DV18+h
X-Received: by 2002:a25:8004:0:b0:dff:3058:e30f with SMTP id 3f1490d57ef6-e02be13ba98mr3072450276.21.1718809752484;
        Wed, 19 Jun 2024 08:09:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH3OygO+UAqhsmU2eYtM9cFyW9UsJ4Ba910yO3Z4ITLZ68HjjdISuMgaXJBXkGYQ6BkgCtmeVGylZ1w88hx65c=
X-Received: by 2002:a25:8004:0:b0:dff:3058:e30f with SMTP id
 3f1490d57ef6-e02be13ba98mr3072423276.21.1718809752187; Wed, 19 Jun 2024
 08:09:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240617-stage-vdpa-vq-precreate-v1-0-8c0483f0ca2a@nvidia.com> <20240617-stage-vdpa-vq-precreate-v1-11-8c0483f0ca2a@nvidia.com>
In-Reply-To: <20240617-stage-vdpa-vq-precreate-v1-11-8c0483f0ca2a@nvidia.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 19 Jun 2024 17:08:36 +0200
Message-ID: <CAJaqyWedSQdAiFoQuqdzwdZ4KNNPD7wyX4=QTMMG4aYt7US7PQ@mail.gmail.com>
Subject: Re: [PATCH vhost 11/23] vdpa/mlx5: Set an initial size on the VQ
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Si-Wei Liu <si-wei.liu@oracle.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org, 
	Cosmin Ratiu <cratiu@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 5:09=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia.com=
> wrote:
>
> The virtqueue size is a pre-requisite for setting up any virtqueue
> resources. For the upcoming optimization of creating virtqueues at
> device add, the virtqueue size has to be configured.
>
> Store the default queue size in struct mlx5_vdpa_net to make it easy in
> the future to pre-configure this default value via vdpa tool.
>
> The queue size check in setup_vq() will always be false. So remove it.
>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 7 ++++---
>  drivers/vdpa/mlx5/net/mlx5_vnet.h | 1 +
>  2 files changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/ml=
x5_vnet.c
> index 245b5dac98d3..1181e0ac3671 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -58,6 +58,8 @@ MODULE_LICENSE("Dual BSD/GPL");
>   */
>  #define MLX5V_DEFAULT_VQ_COUNT 2
>
> +#define MLX5V_DEFAULT_VQ_SIZE 256
> +
>  struct mlx5_vdpa_cq_buf {
>         struct mlx5_frag_buf_ctrl fbc;
>         struct mlx5_frag_buf frag_buf;
> @@ -1445,9 +1447,6 @@ static int setup_vq(struct mlx5_vdpa_net *ndev, str=
uct mlx5_vdpa_virtqueue *mvq)
>         u16 idx =3D mvq->index;
>         int err;
>
> -       if (!mvq->num_ent)
> -               return 0;
> -
>         if (mvq->initialized)
>                 return 0;
>
> @@ -3523,6 +3522,7 @@ static void init_mvqs(struct mlx5_vdpa_net *ndev)
>                 mvq->ndev =3D ndev;
>                 mvq->fwqp.fw =3D true;
>                 mvq->fw_state =3D MLX5_VIRTIO_NET_Q_OBJECT_NONE;
> +               mvq->num_ent =3D ndev->default_queue_size;
>         }
>  }
>
> @@ -3660,6 +3660,7 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *=
v_mdev, const char *name,
>                 goto err_alloc;
>         }
>         ndev->cur_num_vqs =3D MLX5V_DEFAULT_VQ_COUNT;
> +       ndev->default_queue_size =3D MLX5V_DEFAULT_VQ_SIZE;
>
>         init_mvqs(ndev);
>         allocate_irqs(ndev);
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.h b/drivers/vdpa/mlx5/net/ml=
x5_vnet.h
> index 90b556a57971..2ada29767cc5 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.h
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.h
> @@ -58,6 +58,7 @@ struct mlx5_vdpa_net {
>         bool setup;
>         u32 cur_num_vqs;
>         u32 rqt_size;
> +       u16 default_queue_size;

It seems to me this is only assigned here and not used in the rest of
the series, why allocate a member here instead of using macro
directly?

>         bool nb_registered;
>         struct notifier_block nb;
>         struct vdpa_callback config_cb;
>
> --
> 2.45.1
>


