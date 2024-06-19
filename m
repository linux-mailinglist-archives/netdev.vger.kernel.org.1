Return-Path: <netdev+bounces-104827-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B2690E8BF
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 12:56:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 059EE1C20D8A
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 10:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0000A132112;
	Wed, 19 Jun 2024 10:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kyq3RRzv"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8605F132100
	for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 10:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718794557; cv=none; b=V6/aJfh9HU+PRJw13nWygLifFrpw0UwOsGCpZw1HtOOROukpZuIXZFgBemyB4pDFxPGOaCNBMwUVaVATXtDMSpZThLwGtFi0iG4Zjbh2ysiISVB8xAMHAMErRa8FQmNntfGi8nG9B2ifGO4XFRZNBwV0fwli8Uj00zrwEmxoess=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718794557; c=relaxed/simple;
	bh=kGxMAaJvLmfXkBIK3NGXhSRM0AwoYHtsGbNLEE0bnpY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PQJ/Y5hlehdObWbk0n/3lD77GdcVFUkR5lLKWYR7qec9aGsvGC4RYNe6TFEbOcp8ktBGz7OKGOu7YYkd/PM4OAMlbeAnLFwnOPa+xiCHBqPZCJ2oNWponV4tAe7vWjPeBedbSDJ5bCWyFumJuSnChHV993qLBcrbw6Ovs5CvaPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kyq3RRzv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718794555;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mOO5ZSP3WLU9Q7oAH7CvSIrRzVR6QPgru4zl8xC0EsM=;
	b=Kyq3RRzvAQoiGk8i8GKOhLyFdurooJHfq+ALjKJSHAnTHSOccX/pWPVV3Mzw4hAfl4ylEL
	TbKnnerlslU1kLmW7WIkv8Iwda0WP2+vGjc5sV9mk5HIPcYX8ddAEHDqlzXPtuaZG4Od0/
	kNIr27EFQJvgT/ddhsdMMeeF50TCnvA=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-465-dPGjEiLMPSWfAzc0zt5-vg-1; Wed, 19 Jun 2024 06:55:54 -0400
X-MC-Unique: dPGjEiLMPSWfAzc0zt5-vg-1
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-627f43bec13so124441527b3.0
        for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 03:55:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718794553; x=1719399353;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mOO5ZSP3WLU9Q7oAH7CvSIrRzVR6QPgru4zl8xC0EsM=;
        b=DIgbTqBJypWul4NyENuNYAf8CJ1FahIeMaoYthqFU0D5kk+rW/Q9BDylr9QLPDel8j
         IBZIYHJTqJQP2Spd5aRHg0zoH7Zp6+yi23hiNR+x3Bzbci0C3Rhpf2nDpdpnMqTU/PoM
         i+8s8JvtF5NJ/1wKTDx6lN1kd/EMKbjyAxyeJRQr7JoVzPp00cNWltl6W5QJ3wzpwmZg
         f85QJQ3Prg2m+CIYpuBhnE7kmiMphDm0MFhklrM6kSTAdUf21qH9kq479tfKuraK8mMo
         TM/GKqcAdIMIOV0IrOhRJKLNmgpDLnx6Km3pUi4wwc9Lsf04NMNAIzZJZqhF/A7SKRxQ
         reJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVD9YE99nQfAEbjTH3odb+IjMr1OPQDqCTmR3O0074q3OCtXwPQjnl1Wphxyck66koqaNm1+LhAiirqSxwLh5WHqFvsi2y5
X-Gm-Message-State: AOJu0YzFPqAvwMlS57esKy2C5hDqyFak8cL79EoXdeFQN8KZMurTZ7VV
	WSfHPIB/GlTGpRs5zFbPyLD2FYSBzUYkdxBmt7vkYWUNVNMh2IIgft1TSDXSFRynG66XO/bOyJI
	rom9zXm9LDLotdn75tsYxB6R4s7f+OmtIi/tZQTj/RcyDuRQmb5l15Bq4vnkx+8qSayKr4htleo
	+Lo5zhsl86FbPF9C/b44Ps7FdqR16j
X-Received: by 2002:a81:9144:0:b0:627:a7d7:6d76 with SMTP id 00721157ae682-63a8f6196cfmr23423147b3.39.1718794553595;
        Wed, 19 Jun 2024 03:55:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvxPUUYPpg9QjOGGTil9Q0vxhLdibJM9rIX47lCpLHxV4IIFiJXXL5B/tBGDpyegeZIjHDn8kj0g1taUiWYss=
X-Received: by 2002:a81:9144:0:b0:627:a7d7:6d76 with SMTP id
 00721157ae682-63a8f6196cfmr23423047b3.39.1718794553297; Wed, 19 Jun 2024
 03:55:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240617-stage-vdpa-vq-precreate-v1-0-8c0483f0ca2a@nvidia.com> <20240617-stage-vdpa-vq-precreate-v1-3-8c0483f0ca2a@nvidia.com>
In-Reply-To: <20240617-stage-vdpa-vq-precreate-v1-3-8c0483f0ca2a@nvidia.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 19 Jun 2024 12:55:17 +0200
Message-ID: <CAJaqyWdWSbua3HJaAHP0vetugyy5-ryAD8d-z-Xi26VQXiRSiA@mail.gmail.com>
Subject: Re: [PATCH vhost 03/23] vdpa/mlx5: Drop redundant code
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Si-Wei Liu <si-wei.liu@oracle.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org, 
	Cosmin Ratiu <cratiu@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 5:08=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia.com=
> wrote:

Patch message suggestion:
Originally, the second loop initialized the CVQ. But (acde3929492b
("vdpa/mlx5: Use consistent RQT size") initialized all the queues in
the first loop, so the second iteration in ...

>
> The second iteration in init_mvqs() is never called because the first
> one will iterate up to max_vqs.
>

Either way,

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/ml=
x5_vnet.c
> index 1ad281cbc541..b4d9ef4f66c8 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -3519,12 +3519,6 @@ static void init_mvqs(struct mlx5_vdpa_net *ndev)
>                 mvq->fwqp.fw =3D true;
>                 mvq->fw_state =3D MLX5_VIRTIO_NET_Q_OBJECT_NONE;
>         }
> -       for (; i < ndev->mvdev.max_vqs; i++) {
> -               mvq =3D &ndev->vqs[i];
> -               memset(mvq, 0, offsetof(struct mlx5_vdpa_virtqueue, ri));
> -               mvq->index =3D i;
> -               mvq->ndev =3D ndev;
> -       }
>  }
>
>  struct mlx5_vdpa_mgmtdev {
>
> --
> 2.45.1
>


