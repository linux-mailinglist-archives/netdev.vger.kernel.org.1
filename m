Return-Path: <netdev+bounces-108937-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8270992644D
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 17:07:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6B721C22160
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 15:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B007E17D892;
	Wed,  3 Jul 2024 15:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HsEE91TI"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020901DFEA
	for <netdev@vger.kernel.org>; Wed,  3 Jul 2024 15:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720019262; cv=none; b=dkIDAHHzrq3fDry554IBKR2CdVEu9tW5m4hOA8T+wtvSC/9159XrbxpHKhmrbARMxcwAaonhk5D7mv+8wsJV7sgNF+ILafLobp1QS5TBDjCGzUI4KiOuBlSTk7XrJtVGCC9KzaePKxqZg799XpYTF66xOLmvkc8hetn5Dk2BevM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720019262; c=relaxed/simple;
	bh=htiNVKCUYbXGPavreykediMApatRGcFz26KpoJTonIc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vd+fhK/0mwJr77S4FHp1QJvso52HauSgJi8e/kghlibJRm/NxthwLK2wXwjJUCCSJny/X+HQ7rLLhi//mJXORYpF80zi6K5yULBWuA/DFIornAuTejPqtFyBEJFh6sT8uQakhDN0bAx8xktvdghAy1HTFKijtVzvUTVlCklwxrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HsEE91TI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720019259;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NBe9D4bWmY0rHimyhkz7e567bCh9VnKwjShWa1gkoYc=;
	b=HsEE91TI42vfvzmWwVUcEPDKeKmYPQ63ToSTgXdYEg5wlWLeHeRdbWjnBRvZnzr6rB401E
	MHqO5+b+yve3PNCK1PCnlJsHGc+c2jL9c/e6y5L3SHzPwl3purebfOrf5ehdqSqWmShedS
	yaQVXkRo3l7QuasVqX2XKnHDHZzFmQc=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-318-VBPInMLXNXqoWz-ZlTm5Ug-1; Wed, 03 Jul 2024 11:07:39 -0400
X-MC-Unique: VBPInMLXNXqoWz-ZlTm5Ug-1
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-650ab31aabdso26213547b3.3
        for <netdev@vger.kernel.org>; Wed, 03 Jul 2024 08:07:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720019257; x=1720624057;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NBe9D4bWmY0rHimyhkz7e567bCh9VnKwjShWa1gkoYc=;
        b=OuJTwJnMP1LHK73AqwDevuxMZsVC9ZSndqU8GLyQxjNulOMlAmSXfnkLGCJOZK8fiz
         TO2yIfTLEln0CWa3l6ESmkwi+nlVxZwk0FNKSWWMzYFJheBXN9gEtqDnYZpPocBlPv+v
         TTW+jEHiA/WAzzqqAOjtaCmksZ//Ld1w3CJzL5f78pXeD0O7QKZo3kuwDT4cSP+IcFuZ
         398BOEiS0l2sFwUT1JeDbhD0YX++7XzoxCkPR0z5E+cIFQaURdlcUy560Z4fgNAvN8c9
         za4dzr+k9ufTb3TbGqUr2Z6X/lbdBdmt48sLiZuxmT1PXyNprHOJLtmIQLoDHVezqddH
         ZLIw==
X-Forwarded-Encrypted: i=1; AJvYcCWF+6u2aZSZ0SZ9MONymSwgymtf9tJdvzJjuvY0xxz5UrigGIOFNC3+/XNrVjBXDUBVXedURA6Ywg5IwMEUCN7fRcg1c8eG
X-Gm-Message-State: AOJu0YxsGSxuTkEO98Mbjv7v/nSndxbGxvrRvC2TAtV+MGXVOGyzyUZl
	bt6BeoKN/EO8OFcrChceUFOvAWV32Gfo+fDGGzBQCrb42tK87fFzWBJ510PJ+Bcy/s3/EtslWzV
	zPbyEJSpdtsDK36qqM0khW7e0kGR536wZQ6b/jhpvaRKBQXx0PC2oSxl7VsO1kct74sG5FC31RW
	URcvAAXVCWpxbKmFO5qAHgyr8XqrHB
X-Received: by 2002:a05:690c:f11:b0:64b:8086:5805 with SMTP id 00721157ae682-64c718039a1mr148168787b3.15.1720019257362;
        Wed, 03 Jul 2024 08:07:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxpUeuUPTttPcddF+w9Z2HF+ZkSI3kZ1UScOasay/ojm8JxPbrzG2VpLXNh580qpjYBy40hIVvMVQf+q2TP1A=
X-Received: by 2002:a05:690c:f11:b0:64b:8086:5805 with SMTP id
 00721157ae682-64c718039a1mr148168507b3.15.1720019257119; Wed, 03 Jul 2024
 08:07:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240626-stage-vdpa-vq-precreate-v2-0-560c491078df@nvidia.com> <20240626-stage-vdpa-vq-precreate-v2-7-560c491078df@nvidia.com>
In-Reply-To: <20240626-stage-vdpa-vq-precreate-v2-7-560c491078df@nvidia.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 3 Jul 2024 17:07:01 +0200
Message-ID: <CAJaqyWeDwkTbi1ti0z+FsrxViubuxVe+mNtJ2zxbHmTteyR0XQ@mail.gmail.com>
Subject: Re: [PATCH vhost v2 07/24] vdpa/mlx5: Initialize and reset device
 with one queue pair
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Si-Wei Liu <si-wei.liu@oracle.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org, 
	Cosmin Ratiu <cratiu@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2024 at 12:27=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia.co=
m> wrote:
>
> The virtio spec says that a vdpa device should start off with one queue
> pair. The driver is already compliant.
>
> This patch moves the initialization to device add and reset times. This
> is done in preparation for the pre-creation of hardware virtqueues at
> device add time.
>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 23 ++++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/ml=
x5_vnet.c
> index eca6f68c2eda..c8b5c87f001d 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -48,6 +48,16 @@ MODULE_LICENSE("Dual BSD/GPL");
>
>  #define MLX5V_UNTAGGED 0x1000
>
> +/* Device must start with 1 queue pair, as per VIRTIO v1.2 spec, section
> + * 5.1.6.5.5 "Device operation in multiqueue mode":
> + *
> + * Multiqueue is disabled by default.
> + * The driver enables multiqueue by sending a command using class
> + * VIRTIO_NET_CTRL_MQ. The command selects the mode of multiqueue
> + * operation, as follows: ...
> + */
> +#define MLX5V_DEFAULT_VQ_COUNT 2
> +
>  struct mlx5_vdpa_cq_buf {
>         struct mlx5_frag_buf_ctrl fbc;
>         struct mlx5_frag_buf frag_buf;
> @@ -2713,16 +2723,6 @@ static int mlx5_vdpa_set_driver_features(struct vd=
pa_device *vdev, u64 features)
>         else
>                 ndev->rqt_size =3D 1;
>
> -       /* Device must start with 1 queue pair, as per VIRTIO v1.2 spec, =
section
> -        * 5.1.6.5.5 "Device operation in multiqueue mode":
> -        *
> -        * Multiqueue is disabled by default.
> -        * The driver enables multiqueue by sending a command using class
> -        * VIRTIO_NET_CTRL_MQ. The command selects the mode of multiqueue
> -        * operation, as follows: ...
> -        */
> -       ndev->cur_num_vqs =3D 2;
> -
>         update_cvq_info(mvdev);
>         return err;
>  }
> @@ -3040,7 +3040,7 @@ static int mlx5_vdpa_compat_reset(struct vdpa_devic=
e *vdev, u32 flags)
>                 mlx5_vdpa_destroy_mr_resources(&ndev->mvdev);
>         ndev->mvdev.status =3D 0;
>         ndev->mvdev.suspended =3D false;
> -       ndev->cur_num_vqs =3D 0;
> +       ndev->cur_num_vqs =3D MLX5V_DEFAULT_VQ_COUNT;
>         ndev->mvdev.cvq.received_desc =3D 0;
>         ndev->mvdev.cvq.completed_desc =3D 0;
>         memset(ndev->event_cbs, 0, sizeof(*ndev->event_cbs) * (mvdev->max=
_vqs + 1));
> @@ -3643,6 +3643,7 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *=
v_mdev, const char *name,
>                 err =3D -ENOMEM;
>                 goto err_alloc;
>         }
> +       ndev->cur_num_vqs =3D MLX5V_DEFAULT_VQ_COUNT;
>
>         init_mvqs(ndev);
>         allocate_irqs(ndev);
>
> --
> 2.45.1
>


