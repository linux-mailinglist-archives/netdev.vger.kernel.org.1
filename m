Return-Path: <netdev+bounces-104951-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A296190F453
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 18:42:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C42CB22021
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 16:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF22C154C0F;
	Wed, 19 Jun 2024 16:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FM/6aQCr"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F4103153BF0
	for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 16:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718815201; cv=none; b=oVJS6s3KCoBpBNR3Nv6hPMTirPL+bVGJO0PKBsGq1nmJmgfwkMtM/Br0cG3tsadJ68IZPpup5P9L5GoKWUIW3Me92gfzgF4JGRmLQuLKlttSU728puZIE96gyMymMS0LJmtuI0QIAYRPUafstpxPe3i2LrgezzhXk7w8KTvoUI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718815201; c=relaxed/simple;
	bh=TLxDuDULv7mvnSpOlUw3zxuVhjTlDVDDw8EewhZA5MU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=McFryQqKKnxXMleQbxKBy+b81I49zUYTQuvMu0VGeFIwV/ns5SERRhpTEXIQvQ5p6Oq+qWi47kMh7gm5wTGzCfG4qy8bR+Bb1D4ivKsVno519sBmkydtx+s5GOgePAQJpgngbkbAOy885qMsji8MuOMffmoRMQVyZpfme5xxR+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FM/6aQCr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718815199;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P60Z+qqKP/gxhy1fal8KOowFEF1s+YzH3edKw1gHlyU=;
	b=FM/6aQCrgoL8qshur8rleJ3Qhz5i3MmMhcg1Rv7t2D4p8wear3fyrMXeAjOW9KjwdrnWew
	Iz9LCpkgCFJdNdaBsyx7sh265A9WFZEJ0bjuMBUb8+nzzRn1wYcEXvWkV8a+9yjOn80gU6
	6WakzzfrrFDAW+mNrYosX99OuAN/xrw=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-150-ru5skUhvPjykTA3oDMQ6yQ-1; Wed, 19 Jun 2024 12:39:58 -0400
X-MC-Unique: ru5skUhvPjykTA3oDMQ6yQ-1
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-63bf1d3fb2dso1964957b3.1
        for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 09:39:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718815197; x=1719419997;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P60Z+qqKP/gxhy1fal8KOowFEF1s+YzH3edKw1gHlyU=;
        b=kmiyev2TNoiQIYD1LdbJYGGJmodB4tlAGhP7FZleH6z5wJ/c3WNXcCklhKUDOd85q6
         oFArXv8pE/UsfJ0+HV4q3S3aNuzZ/CNV4tdb8C2o4XsARPkR0TT/kt+2Exf7f0Kg1sxh
         NwR4VtC5OcNb0AqiJr1XTP3N+6PwNa1vW4VKYPaJGUyP8ntVIyPJoy9bo1z8UVZZEt85
         obSLbPdi7J3x2WwXvilToUi5QevelWYTK2o0d9wFLqSi7m0gGbuVDvcygk5RVH0Bqp/m
         CaENZribCbD/5NAJTnD9wkm/g/uWFo/lFLM/OwPIvWFiNebK+craMi3bHVEFE9oYAtrD
         IU+A==
X-Forwarded-Encrypted: i=1; AJvYcCWNln5sThmmVH91HDib5B0e9nK8pxLhZWlvsdjVJH4rj/mhYEeNaa/t8UL7UFINUNNjRb7+TNInWKrr1P295jnAl+CAcQ73
X-Gm-Message-State: AOJu0YzXUW0446SkasF0Jd/ikm371wF9DI2k2hB/+4VGX1w1i85wK77n
	87B/z7bMBRugcO7PiUrVKH+ZEpOnpf/XfwpmjqCs2kEWApCigSXw8Cgefri506esL+dGylxuW9S
	uafNdIuGyLkND4G+5p8YmKJ+UvMnHHaGERZ1HO7/fE1OJIRcMyfIRnR0wM08AafOOOTELuN5fqV
	simE/8IFVGuE5QRkxJJGb7i69ajZsJNVaY9dxfZVM=
X-Received: by 2002:a05:690c:94d:b0:61a:b038:6d34 with SMTP id 00721157ae682-63a8e4bb5a1mr33219897b3.24.1718815197196;
        Wed, 19 Jun 2024 09:39:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOXaEuiFH0ecGWxfyNYKYA47piELvowHtDpjSC86sl6JvY/gqFtoIQ2677PkimEVq0gbLNOWpWdslhce2oYP0=
X-Received: by 2002:a05:690c:94d:b0:61a:b038:6d34 with SMTP id
 00721157ae682-63a8e4bb5a1mr33219687b3.24.1718815196917; Wed, 19 Jun 2024
 09:39:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240617-stage-vdpa-vq-precreate-v1-0-8c0483f0ca2a@nvidia.com> <20240617-stage-vdpa-vq-precreate-v1-23-8c0483f0ca2a@nvidia.com>
In-Reply-To: <20240617-stage-vdpa-vq-precreate-v1-23-8c0483f0ca2a@nvidia.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 19 Jun 2024 18:39:20 +0200
Message-ID: <CAJaqyWc+bmWVU8Lu40bhxEatJ5y1f3n=AD2_UborSRa+Bf495g@mail.gmail.com>
Subject: Re: [PATCH vhost 23/23] vdpa/mlx5: Don't enable non-active VQs in .set_vq_ready()
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
> VQ indices in the range [cur_num_qps, max_vqs) represent queues that
> have not yet been activated. .set_vq_ready should not activate these
> VQs.
>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/ml=
x5_vnet.c
> index 1a5ee0d2b47f..a969a7f105a6 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -1575,6 +1575,9 @@ static int resume_vq(struct mlx5_vdpa_net *ndev, st=
ruct mlx5_vdpa_virtqueue *mvq
>         if (!mvq->initialized)
>                 return 0;
>
> +       if (mvq->index >=3D ndev->cur_num_vqs)
> +               return 0;
> +
>         switch (mvq->fw_state) {
>         case MLX5_VIRTIO_NET_Q_OBJECT_STATE_INIT:
>                 /* Due to a FW quirk we need to modify the VQ fields firs=
t then change state.
>
> --
> 2.45.1
>


