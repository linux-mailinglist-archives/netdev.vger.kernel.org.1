Return-Path: <netdev+bounces-104822-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F9A90E874
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 12:38:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E7E4B2332F
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 10:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F8E212F5BE;
	Wed, 19 Jun 2024 10:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b5AOJY8t"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB416BB5B
	for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 10:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718793514; cv=none; b=sKMx3CBf6nj3f0bu5xTT5vYFWEZgWRRZ5tS9Dk7pxX9NJzsR/c903ozHMG1lsQXNf0+4fihillcod5HIsVvyxbrv3ChyhO+jSJkroygIEPOXdHdeFzrfmGRlGUpjqJSB0lkRJ/vUlAOw6wQ9XepClhzEnQGi0xjiz09ZAd4ZV0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718793514; c=relaxed/simple;
	bh=PS7tU6jZVP4LbinvvKWXnk1S71spD9IDGMpNJb3ZvhE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X8EU/vi0BjP2hvc661g9p/P/ln+60ZBJ3LfGROODxgl8L3hO209CvHNXGLw/e+8nn7KMSajhmSwY1gZsDtBNr0hwqJgim74cyfTUAHZJaJ+vnVFNjqierXycfq5UizKgFhWiNLrz76N6K/cyF+6kj7NPTGdzp7R9FqpUg++VplU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b5AOJY8t; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718793511;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FFr9xFq64BkKhpQnfsn6Q49bj2wjStk9VDMgy0oc5n0=;
	b=b5AOJY8tcPNXRqEnOeqrLZFrWOOf3oAYsbN7ThcghjlrBh8U1ac6tdHzuVKYxcC+7iEXPM
	2bJYZSrnZqwk0zxc81HSnWVUs+oqni7vzYD2sVWMldNFFJfWvzrLOco9eVHR8bPgF0moQ3
	eLvONRn2GC5a/d1MmMhPbhwrwirB84A=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-fzje53AQPj-i4C5ID6o3bg-1; Wed, 19 Jun 2024 06:38:30 -0400
X-MC-Unique: fzje53AQPj-i4C5ID6o3bg-1
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-632591a256bso105460117b3.1
        for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 03:38:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718793509; x=1719398309;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FFr9xFq64BkKhpQnfsn6Q49bj2wjStk9VDMgy0oc5n0=;
        b=LhR1RZazZTqeYP9RbNlK03oSelQ87H9xUCekUPh8ihy7embbbu9+JESEXlI30D+EEQ
         prpZXmuwEbnizGn0HNrYWJ+5LEVZTyPGoRfsCA3ME9NRhE3FRjrbBWbLHJK/VJXj66KA
         JdHQzAkaPNoQn+5g7qkYd0nMThm+gXJ4no0b95wkpJO7QY3pmCqAnpoAs215UZ6JPGnR
         72mzbDtlL3rD7yzVU/bwPx+8vCV4CHcb3h5z6MxzfsMKXGYHJJS483wYEuwui4XPcG6N
         SyCZuo17Ntch/6cVCMl0GOUVTD1SxxsDDGFpW6PAlb91VF4l+Q5f2XPEQUE1+QNpywAf
         mWgA==
X-Forwarded-Encrypted: i=1; AJvYcCUcpRvkkwT+aO1L4jmGSE8VsFgWXb4Xp0KkanqRJUkAhq3HuupUCTVOzmwV5ZxlJiJuS6Od/8monYsyHQON0HHVl8egzQFc
X-Gm-Message-State: AOJu0Yz3wEqViB/+5YDrxofJaQXPB0+ZAUXKJ9sBky4lF1+07xjegIHE
	ib3jnbtmYmqmuUL8b1/b0M8Es9tX7jzjbH5c0DSZ6HMEf3TTyklzmFeOwnnKZtJO178GfvDRMpJ
	67zv6mAdw9L86HaQSD2ozSZYbFleTSeK/qDoMZIGBcdPwTbMFe4pUW7doxh9m8lbiYCE5v8xkQU
	yeZ6Oor6iEatJZ0jOHcWBp2NaGyrjv
X-Received: by 2002:a81:b048:0:b0:632:587b:c970 with SMTP id 00721157ae682-63a900bebd9mr21335317b3.51.1718793509664;
        Wed, 19 Jun 2024 03:38:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5B5Ize3zl4/hDjuYJ+SiolBj12vgsVgj6dxiSrIi4vKCGZjz+/HKOtCxYIMf2/iiZn2sv3msEdL+1a5UWubM=
X-Received: by 2002:a81:b048:0:b0:632:587b:c970 with SMTP id
 00721157ae682-63a900bebd9mr21335127b3.51.1718793509247; Wed, 19 Jun 2024
 03:38:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240617-stage-vdpa-vq-precreate-v1-0-8c0483f0ca2a@nvidia.com> <20240617-stage-vdpa-vq-precreate-v1-1-8c0483f0ca2a@nvidia.com>
In-Reply-To: <20240617-stage-vdpa-vq-precreate-v1-1-8c0483f0ca2a@nvidia.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 19 Jun 2024 12:37:53 +0200
Message-ID: <CAJaqyWfGTcrb63=mya5tvxcrQttHqVL6GBc3JqXSkLMXcH-L5g@mail.gmail.com>
Subject: Re: [PATCH vhost 01/23] vdpa/mlx5: Clarify meaning thorough function rename
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
> setup_driver()/teardown_driver() are a bit vague. These functions are
> used for virtqueue resources.
>
> Same for alloc_resources()/teardown_resources(): they represent fixed
> resources that are meant to exist during the device lifetime.
>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/ml=
x5_vnet.c
> index ecfc16151d61..3422da0e344b 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -144,10 +144,10 @@ static bool is_index_valid(struct mlx5_vdpa_dev *mv=
dev, u16 idx)
>         return idx <=3D mvdev->max_idx;
>  }
>
> -static void free_resources(struct mlx5_vdpa_net *ndev);
> +static void free_fixed_resources(struct mlx5_vdpa_net *ndev);
>  static void init_mvqs(struct mlx5_vdpa_net *ndev);
> -static int setup_driver(struct mlx5_vdpa_dev *mvdev);
> -static void teardown_driver(struct mlx5_vdpa_net *ndev);
> +static int setup_vq_resources(struct mlx5_vdpa_dev *mvdev);
> +static void teardown_vq_resources(struct mlx5_vdpa_net *ndev);
>
>  static bool mlx5_vdpa_debug;
>
> @@ -2848,7 +2848,7 @@ static int mlx5_vdpa_change_map(struct mlx5_vdpa_de=
v *mvdev,
>                 if (err)
>                         return err;
>
> -               teardown_driver(ndev);
> +               teardown_vq_resources(ndev);
>         }
>
>         mlx5_vdpa_update_mr(mvdev, new_mr, asid);
> @@ -2862,7 +2862,7 @@ static int mlx5_vdpa_change_map(struct mlx5_vdpa_de=
v *mvdev,
>
>         if (teardown) {
>                 restore_channels_info(ndev);
> -               err =3D setup_driver(mvdev);
> +               err =3D setup_vq_resources(mvdev);
>                 if (err)
>                         return err;
>         }
> @@ -2873,7 +2873,7 @@ static int mlx5_vdpa_change_map(struct mlx5_vdpa_de=
v *mvdev,
>  }
>
>  /* reslock must be held for this function */
> -static int setup_driver(struct mlx5_vdpa_dev *mvdev)
> +static int setup_vq_resources(struct mlx5_vdpa_dev *mvdev)
>  {
>         struct mlx5_vdpa_net *ndev =3D to_mlx5_vdpa_ndev(mvdev);
>         int err;
> @@ -2931,7 +2931,7 @@ static int setup_driver(struct mlx5_vdpa_dev *mvdev=
)
>  }
>
>  /* reslock must be held for this function */
> -static void teardown_driver(struct mlx5_vdpa_net *ndev)
> +static void teardown_vq_resources(struct mlx5_vdpa_net *ndev)
>  {
>
>         WARN_ON(!rwsem_is_locked(&ndev->reslock));
> @@ -2997,7 +2997,7 @@ static void mlx5_vdpa_set_status(struct vdpa_device=
 *vdev, u8 status)
>                                 goto err_setup;
>                         }
>                         register_link_notifier(ndev);
> -                       err =3D setup_driver(mvdev);
> +                       err =3D setup_vq_resources(mvdev);
>                         if (err) {
>                                 mlx5_vdpa_warn(mvdev, "failed to setup dr=
iver\n");
>                                 goto err_driver;
> @@ -3040,7 +3040,7 @@ static int mlx5_vdpa_compat_reset(struct vdpa_devic=
e *vdev, u32 flags)
>
>         down_write(&ndev->reslock);
>         unregister_link_notifier(ndev);
> -       teardown_driver(ndev);
> +       teardown_vq_resources(ndev);
>         clear_vqs_ready(ndev);
>         if (flags & VDPA_RESET_F_CLEAN_MAP)
>                 mlx5_vdpa_destroy_mr_resources(&ndev->mvdev);
> @@ -3197,7 +3197,7 @@ static void mlx5_vdpa_free(struct vdpa_device *vdev=
)
>
>         ndev =3D to_mlx5_vdpa_ndev(mvdev);
>
> -       free_resources(ndev);
> +       free_fixed_resources(ndev);
>         mlx5_vdpa_destroy_mr_resources(mvdev);
>         if (!is_zero_ether_addr(ndev->config.mac)) {
>                 pfmdev =3D pci_get_drvdata(pci_physfn(mvdev->mdev->pdev))=
;
> @@ -3467,7 +3467,7 @@ static int query_mtu(struct mlx5_core_dev *mdev, u1=
6 *mtu)
>         return 0;
>  }
>
> -static int alloc_resources(struct mlx5_vdpa_net *ndev)
> +static int alloc_fixed_resources(struct mlx5_vdpa_net *ndev)
>  {
>         struct mlx5_vdpa_net_resources *res =3D &ndev->res;
>         int err;
> @@ -3494,7 +3494,7 @@ static int alloc_resources(struct mlx5_vdpa_net *nd=
ev)
>         return err;
>  }
>
> -static void free_resources(struct mlx5_vdpa_net *ndev)
> +static void free_fixed_resources(struct mlx5_vdpa_net *ndev)
>  {
>         struct mlx5_vdpa_net_resources *res =3D &ndev->res;
>
> @@ -3735,7 +3735,7 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *=
v_mdev, const char *name,
>                         goto err_res;
>         }
>
> -       err =3D alloc_resources(ndev);
> +       err =3D alloc_fixed_resources(ndev);
>         if (err)
>                 goto err_mr;
>
> @@ -3758,7 +3758,7 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *=
v_mdev, const char *name,
>  err_reg:
>         destroy_workqueue(mvdev->wq);
>  err_res2:
> -       free_resources(ndev);
> +       free_fixed_resources(ndev);
>  err_mr:
>         mlx5_vdpa_destroy_mr_resources(mvdev);
>  err_res:
>
> --
> 2.45.1
>


