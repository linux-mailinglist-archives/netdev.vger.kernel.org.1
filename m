Return-Path: <netdev+bounces-104932-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EFB790F2D3
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 17:48:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14D5D28599C
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 15:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECC94152796;
	Wed, 19 Jun 2024 15:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I1hCtMbX"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E17152524
	for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 15:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718811840; cv=none; b=gyCKM3WXTOMR1n7yDns6v42eGt0sZqYBZwxn/VXxoE8+TLzu6aTBdYZXmriX/eFVq1mLXb4aBRJx0hlHWVDFhOoSvQLd+pJ3C7LjS3Mw2VpO8b3a7zeTRR6BsMHqbcJQ6ULsRMFMWBLMxviFaG7Y1SEIZ75Zco0QnAfkwQ2HUfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718811840; c=relaxed/simple;
	bh=gjIlVC0Qv56i7mNLzpX6QNyDh2wQBd29Qq8BecOvO84=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V0jl80xlrwZd+AZdf494TNIM3Z8ytKQHoQhpX23QQQwQatQoWvm0FiPvADPmypi+hq1WGdKttXjhdgvRSNIHiqV7I6siPi8WWQcyloejZlf20uJXV1IRsr3OPUJcq0sIC2LB3ZON/+oVBYVr31bsPnXB0MOSrFeCOkJ6WjsEF3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I1hCtMbX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718811838;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3fKPssBEwyag1A5CHcVe8reEUsaYqb5YQavo355OrZo=;
	b=I1hCtMbXNHdeXpNSZ9TcW6wQ4oF4/GLnR4mh/44GiC7pQ/6Ed1joM2Ahy/tqrepP8QO9Gu
	Py/Gd4mTWTpZzoh0WEw2s3/LtK46TQL9JYoPTtc8tUNzzEGs701TekhKQAC1dDJ5JWy6W4
	zAz6Jv4xz+X8pR6vjwsP2Ec3Ko9Fld0=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-SQPF_29fPyurEbXODOUOwA-1; Wed, 19 Jun 2024 11:43:57 -0400
X-MC-Unique: SQPF_29fPyurEbXODOUOwA-1
Received: by mail-yb1-f200.google.com with SMTP id 3f1490d57ef6-dfe44496da9so11886558276.0
        for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 08:43:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718811836; x=1719416636;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3fKPssBEwyag1A5CHcVe8reEUsaYqb5YQavo355OrZo=;
        b=rOS2CwTA/YPQxm1exo8haTeps30AmTmI0GPPYjGWvPV8GAuWsI2S6vzVlQXTRoMxLl
         lu5R6jIiCN8SFzt8N2D5b0jWTz8nP1bWZXR/ljN+WS5tWePxCQdFGyr3Npcgiknh8Gku
         GWjM4MB+mIjcgUruJbSq0LzB6O0Y0Ke5y/1vonPc/MgcP5Mgsncg0Z8bSdBsRxZovi15
         WhVbyawjDTdwFuAiYIlncr+hNxhLAYVm/KgCcD/YONZ+yl5u2CFLjTVgdHSFNxy8Cume
         mqT9dMYLIw5EuMNioXT/C/MYspH1qzy0lww5iueZaMV2spqHhNo1B3wTjl6lmaJ063qz
         E9tQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIKNQPwgObYIAGqUrzrE1KYR+YI7d23GAwYmkwA7vGsWlznMTrh+tmasmuorlywSxGYW9JjtJQ/UnJfGit6U0dcb01gfuC
X-Gm-Message-State: AOJu0Yz3pNd+UWTCUJnXgdqAYJAiZF6+2OoG+YVfjFuKWgF38exRVrzq
	l+lLJviwVhOh9aali5wMJbAOr57G3jea0GMmF/EGPKn9ombOwcD4DV69XtogMIDQEUl0uJ5iCKu
	KRNrBOPXqHkgROAJxcUydoBbZ6wRkEnGeyz4JDRK1piU33WF+z5K28Nev4YMWJQ1cM6//KyU64Y
	K//P5TXd78yHYL+iehVDMw1WrM8gr7
X-Received: by 2002:a25:ab90:0:b0:dff:3055:3c26 with SMTP id 3f1490d57ef6-e02be20b4b0mr3347989276.40.1718811836567;
        Wed, 19 Jun 2024 08:43:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHuq/mg3ERM9FqZxfhIbhFa52BBDZJDga9awTj9rzgPpjCM8aGAm1pB6AklaTDW2TTBksgypWtCPQxl0ge9AZY=
X-Received: by 2002:a25:ab90:0:b0:dff:3055:3c26 with SMTP id
 3f1490d57ef6-e02be20b4b0mr3347976276.40.1718811836245; Wed, 19 Jun 2024
 08:43:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240617-stage-vdpa-vq-precreate-v1-0-8c0483f0ca2a@nvidia.com> <20240617-stage-vdpa-vq-precreate-v1-17-8c0483f0ca2a@nvidia.com>
In-Reply-To: <20240617-stage-vdpa-vq-precreate-v1-17-8c0483f0ca2a@nvidia.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 19 Jun 2024 17:43:20 +0200
Message-ID: <CAJaqyWc3HZpyMj_LVq5nmDaDSijxcXiHAXtjSQMSuS2bZQV-aQ@mail.gmail.com>
Subject: Re: [PATCH vhost 17/23] vdpa/mlx5: Consolidate all VQ modify to Ready
 to use resume_vq()
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
> There are a few more places modifying the VQ to Ready directly. Let's
> consolidate them into resume_vq().
>
> The redundant warnings for resume_vq() errors can also be dropped.
>
> There is one special case that needs to be handled for virtio-vdpa:
> the initialized flag must be set to true earlier in setup_vq() so that
> resume_vq() doesn't return early.
>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 18 ++++++------------
>  1 file changed, 6 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/ml=
x5_vnet.c
> index e3a82c43b44e..f5d5b25cdb01 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -160,6 +160,7 @@ static void free_fixed_resources(struct mlx5_vdpa_net=
 *ndev);
>  static void init_mvqs(struct mlx5_vdpa_net *ndev);
>  static int setup_vq_resources(struct mlx5_vdpa_net *ndev, bool filled);
>  static void teardown_vq_resources(struct mlx5_vdpa_net *ndev);
> +static int resume_vq(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqu=
eue *mvq);
>
>  static bool mlx5_vdpa_debug;
>
> @@ -1500,16 +1501,14 @@ static int setup_vq(struct mlx5_vdpa_net *ndev,
>         if (err)
>                 goto err_vq;
>
> +       mvq->initialized =3D true;
> +
>         if (mvq->ready) {
> -               err =3D modify_virtqueue_state(ndev, mvq, MLX5_VIRTIO_NET=
_Q_OBJECT_STATE_RDY);
> -               if (err) {
> -                       mlx5_vdpa_warn(&ndev->mvdev, "failed to modify to=
 ready vq idx %d(%d)\n",
> -                                      idx, err);
> +               err =3D resume_vq(ndev, mvq);
> +               if (err)
>                         goto err_modify;
> -               }
>         }
>
> -       mvq->initialized =3D true;
>         return 0;
>
>  err_modify:
> @@ -2422,7 +2421,6 @@ static void mlx5_vdpa_set_vq_ready(struct vdpa_devi=
ce *vdev, u16 idx, bool ready
>         struct mlx5_vdpa_dev *mvdev =3D to_mvdev(vdev);
>         struct mlx5_vdpa_net *ndev =3D to_mlx5_vdpa_ndev(mvdev);
>         struct mlx5_vdpa_virtqueue *mvq;
> -       int err;
>
>         if (!mvdev->actual_features)
>                 return;
> @@ -2439,14 +2437,10 @@ static void mlx5_vdpa_set_vq_ready(struct vdpa_de=
vice *vdev, u16 idx, bool ready
>         if (!ready) {
>                 suspend_vq(ndev, mvq);
>         } else {
> -               err =3D modify_virtqueue_state(ndev, mvq, MLX5_VIRTIO_NET=
_Q_OBJECT_STATE_RDY);
> -               if (err) {
> -                       mlx5_vdpa_warn(mvdev, "modify VQ %d to ready fail=
ed (%d)\n", idx, err);
> +               if (resume_vq(ndev, mvq))
>                         ready =3D false;
> -               }
>         }
>
> -
>         mvq->ready =3D ready;
>  }
>
>
> --
> 2.45.1
>


