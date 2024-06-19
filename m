Return-Path: <netdev+bounces-104823-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C64190E87A
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 12:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 910521C219D5
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 10:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CE0C12FF63;
	Wed, 19 Jun 2024 10:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EW2keoCo"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5A412D1E7
	for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 10:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718793564; cv=none; b=BFc6C090z013TCkz+D5HWfPqBfes3GkZ5J9Kzw3/PbXj27ThAg8PUS6tUoVpMVHZocCbiy0wS3xCPVVWr3i8xAj8o4m9lXv62g92JLKV+fbPvxqWHgidPjhy3+OxiWUChg5gcOeZAMq1aUdxeZ5IexzCUCzWUBnh51K+gJBnl1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718793564; c=relaxed/simple;
	bh=NEALePxhkauIah69wkauRXHyvijSonZ/UaLFWa+B5DM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X6EbhE5EIId9nUWSV46cCCHd73BBq4xfN/TAkY4II8HwlMQNLfDVTc88mDQ7kDa1T3bYPUO2claad1vV014lNJXJWaSLECbx68gwMVGGRehF7/dwnB/XC1GrEhsMF6VCeVEbBhST/kZkIuqwr6GPER7gtaft/I/IA8tgqwKPVoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EW2keoCo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718793561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ntUKAapeHA785LXjMEANQKksPYzHK2y/PR5/y33x83o=;
	b=EW2keoCoTMbaf+RKzZB7T9hRi5+rGviPPOhI4WjeH+IK8pI6YSfPJDWSAPXEmNk+549S4G
	4Zd0y3MiEuMQEppFLKfu8TFhWGICZ6MRLjx6WRmLWeKFYuaTOAMrqhrub6cch63Q4XBKzf
	+DEIGbE3J+88ZKAFyFaNQcUWnvDHSgY=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-495-UNhC9QljNCqkD1cT1T61PA-1; Wed, 19 Jun 2024 06:39:20 -0400
X-MC-Unique: UNhC9QljNCqkD1cT1T61PA-1
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-6311e0f4db4so119834927b3.3
        for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 03:39:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718793560; x=1719398360;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ntUKAapeHA785LXjMEANQKksPYzHK2y/PR5/y33x83o=;
        b=GgoQNXFw19YkZLSAkmp9QcVu9OIj6ZTLzhv2u8XiKwVLObZ3OC/cckSeJ/pHYYrQt6
         YmHTvhgSeIA/CIZEO6kpkbk6ojzrrqN/f+d5mOpXl9s8TSXQvx4/mTYcvxS1zjSwgJDI
         fjr0vniBJ9m7MtULrQPCMyjbck59iKnPRRAxgqzvanxzDU8XOYdXH9iymBrn96CpZ3iV
         bykzOtfNpGdYG0UwG7uV8kgaAqGV/Ng1z5gRv59/3vF21j16m79ErfNgbo6jxsdT8SQr
         BXZGD61iOQ72XKUlBlBcOhrXnE0m+YnI+MaUmqE/QX8vJtt/fCEdyKASj2giZGpLnLip
         aOyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWk0qwNcnIVifQJNkeBJt4VghVGyfGli94lfJCAecek1eo0L4+xCRkgDp+/A7+cZ/uEhL+IB9qy69O0pYWODe1o4Mc/da6
X-Gm-Message-State: AOJu0YyfueCIOy3T8wblR8s2FpnTf43OC+h5GAQWjKt1kVMYxR+ulxno
	Vv2WFcmrrwwypH6/d3H0+QHrFEZYC7XOs/vb3Idt15pc4KMUCItZ0cVNB+ivCnz5RaWNnJNvHcC
	VFLq5iA0dY1QqgEARaSs9543iglIeXTCq20ygWTrpqsjCxsRpX1/LM42iFZIRhUp/unakf6KECL
	q+Y+Ybbrx1rTLYbs6rl2nkP+LxK8tV
X-Received: by 2002:a0d:ea55:0:b0:61a:cde6:6542 with SMTP id 00721157ae682-63a8db105efmr24056967b3.16.1718793559974;
        Wed, 19 Jun 2024 03:39:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEg7zWipQPmtNid7RqIL4gVepYj5ThwzkTg8DjTOCa3QWkSm+6Gd4MRh4PEdRTHoGg/L4a8+m/Orqicl0ajhyo=
X-Received: by 2002:a0d:ea55:0:b0:61a:cde6:6542 with SMTP id
 00721157ae682-63a8db105efmr24056837b3.16.1718793559741; Wed, 19 Jun 2024
 03:39:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240617-stage-vdpa-vq-precreate-v1-0-8c0483f0ca2a@nvidia.com> <20240617-stage-vdpa-vq-precreate-v1-2-8c0483f0ca2a@nvidia.com>
In-Reply-To: <20240617-stage-vdpa-vq-precreate-v1-2-8c0483f0ca2a@nvidia.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 19 Jun 2024 12:38:43 +0200
Message-ID: <CAJaqyWdwn+w51r8t5NO0OTQMXsjQXzB+eC8Cs8xX7Ut_sFKscg@mail.gmail.com>
Subject: Re: [PATCH vhost 02/23] vdpa/mlx5: Make setup/teardown_vq_resources() symmetrical
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
>
> ... by changing the setup_vq_resources() parameter.

s/parameter/parameter type/ ?

Either way,

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/ml=
x5_vnet.c
> index 3422da0e344b..1ad281cbc541 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -146,7 +146,7 @@ static bool is_index_valid(struct mlx5_vdpa_dev *mvde=
v, u16 idx)
>
>  static void free_fixed_resources(struct mlx5_vdpa_net *ndev);
>  static void init_mvqs(struct mlx5_vdpa_net *ndev);
> -static int setup_vq_resources(struct mlx5_vdpa_dev *mvdev);
> +static int setup_vq_resources(struct mlx5_vdpa_net *ndev);
>  static void teardown_vq_resources(struct mlx5_vdpa_net *ndev);
>
>  static bool mlx5_vdpa_debug;
> @@ -2862,7 +2862,7 @@ static int mlx5_vdpa_change_map(struct mlx5_vdpa_de=
v *mvdev,
>
>         if (teardown) {
>                 restore_channels_info(ndev);
> -               err =3D setup_vq_resources(mvdev);
> +               err =3D setup_vq_resources(ndev);
>                 if (err)
>                         return err;
>         }
> @@ -2873,9 +2873,9 @@ static int mlx5_vdpa_change_map(struct mlx5_vdpa_de=
v *mvdev,
>  }
>
>  /* reslock must be held for this function */
> -static int setup_vq_resources(struct mlx5_vdpa_dev *mvdev)
> +static int setup_vq_resources(struct mlx5_vdpa_net *ndev)
>  {
> -       struct mlx5_vdpa_net *ndev =3D to_mlx5_vdpa_ndev(mvdev);
> +       struct mlx5_vdpa_dev *mvdev =3D &ndev->mvdev;
>         int err;
>
>         WARN_ON(!rwsem_is_locked(&ndev->reslock));
> @@ -2997,7 +2997,7 @@ static void mlx5_vdpa_set_status(struct vdpa_device=
 *vdev, u8 status)
>                                 goto err_setup;
>                         }
>                         register_link_notifier(ndev);
> -                       err =3D setup_vq_resources(mvdev);
> +                       err =3D setup_vq_resources(ndev);
>                         if (err) {
>                                 mlx5_vdpa_warn(mvdev, "failed to setup dr=
iver\n");
>                                 goto err_driver;
>
> --
> 2.45.1
>


