Return-Path: <netdev+bounces-104933-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7856D90F355
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 17:59:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2EC9B259A6
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 15:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08168155A5B;
	Wed, 19 Jun 2024 15:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="avO952vx"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F395A1514ED
	for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 15:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718812060; cv=none; b=DLzCvHZV03ueIOaucNQ0GpwsK04BSYptBInHPVEXw9WigNZL8YT8FDG84fQuWd7Nw9dFQ6y0JUNrjXh/5FEtKsOk1z2FlXaGUX+doK6QRjt37jiXqT1M9m5hNxSXxeC3tTogjvfqp8ox82s+sxKeOJOoDNxc7yNBfcuZJDDgQsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718812060; c=relaxed/simple;
	bh=JYrn5yh+hnO7LhELR0hV0l6YRXobPrRRbY9BLOUoMfk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Oz/uerkcepL7e/XQXcdEuxV/TpPSghmRCtVENKjL4sSfdGS6HfvX00sQoKWBpUkPQB2mMF1s7BbO3Ky3l6fOSMcGF6z6E02XbSYh/6+n0WiGvVDQwUWXjGCqQ82e+MQA57uvh0DpW9rarXG7UP49qa3mfPrIkv8xTnulBuOQOE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=avO952vx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718812057;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bdE1JwX4XUPlHCUNEa7GPYLNmBeA++RuMxTVFfl0GYk=;
	b=avO952vxPUbG5LB6hSkjqaCT3bKLetsueqFr9mhOkZYee8FnQHVC2mb8ICACNEssihdnsY
	XMtwpTtr1vxpmt+CFiPZ4UjChi7FB2ugnzS8qjCTb8J+SgcigtHkMdIgSUIWqTXzZvaRsp
	TvzcBQjujm84BN8iyNryXYejlsfpY3o=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-442-1k4won79PXyfkSmkg8kcIA-1; Wed, 19 Jun 2024 11:47:35 -0400
X-MC-Unique: 1k4won79PXyfkSmkg8kcIA-1
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-6344d164c35so83178107b3.1
        for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 08:47:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718812055; x=1719416855;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bdE1JwX4XUPlHCUNEa7GPYLNmBeA++RuMxTVFfl0GYk=;
        b=ZWuLiSZ2PA5TWwBpaVsoGacZjXyCkRMRtFcGQjvRq1dYgHZChpGyw09oj2vgX4K7xe
         m8q0Zli6ZxfID6QSubF91SY9onuGaNFdAuyUD8oWNmqhsSOUikc0d5lQa7SpuW/f8ny4
         6RaJrgBimIYsNmAvBVCRqQqoLStkj8uYeT4fSpjk4p0VuFLm+u1CpT250Lrqu4suhoLr
         RB9ZjjZVExT0+S0ui1uDQhdwyreFl1jXSjy00Pkk2ZUEx4AHfXuOdr9td3fGyYzA/OH8
         rf1DCWRxU4OnBwvUYvZTCeRl7HFlFQHg8qoRK763Z2gw8rqds0C+hTHMfziCkTdAg78a
         C/ZA==
X-Forwarded-Encrypted: i=1; AJvYcCV+ZrRN+KShxWBU/kneSBzCO7ry0o41WEoHLRzjkLJm2hOsonqX5FtLVGTOgtnbYLJ5lmXibEiCNN3J5tw7k/MjEG51xW5n
X-Gm-Message-State: AOJu0YwC3TS+uRp+y9XO7ELhxwarlcpSfzMWf+Hzyd4upEo9xb308U9X
	qwgTj6b2flkxWGvh8Wk36t2d7bn7AQDggHrk4RC28OHHKo3ZbxUYeqYLguvuQZsrt1wrbIq/3+a
	9VB1dI8dG28hPZAwX4GxkjI6+Md1Je+cK/RRNk59qBXGkmXCu2uwHmbd1+mJS5o8RzT1wu2BN+X
	ZID4QINCAcCbtY0xwpNz7vhObHUJCu
X-Received: by 2002:a81:87c6:0:b0:622:c964:7e24 with SMTP id 00721157ae682-63a8e89bed9mr28085737b3.27.1718812054980;
        Wed, 19 Jun 2024 08:47:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGARc89i/ByokkRmsf8KW6yRGKzxLntpgug1yeSYVGWvi8wS+8L3zugBKbhE/rnCTMx3tu5/cQQG/VU5SbeX3c=
X-Received: by 2002:a81:87c6:0:b0:622:c964:7e24 with SMTP id
 00721157ae682-63a8e89bed9mr28085337b3.27.1718812053908; Wed, 19 Jun 2024
 08:47:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240617-stage-vdpa-vq-precreate-v1-0-8c0483f0ca2a@nvidia.com> <20240617-stage-vdpa-vq-precreate-v1-19-8c0483f0ca2a@nvidia.com>
In-Reply-To: <20240617-stage-vdpa-vq-precreate-v1-19-8c0483f0ca2a@nvidia.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 19 Jun 2024 17:46:57 +0200
Message-ID: <CAJaqyWc5rJT666R672f2RQZvAHxy1QdoUKRfCH_wV1F61pQ2Gg@mail.gmail.com>
Subject: Re: [PATCH vhost 19/23] vdpa/mlx5: Use suspend/resume during VQP change
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
> Resume a VQ if it is already created when the number of VQ pairs
> increases. This is done in preparation for VQ pre-creation which is
> coming in a later patch. It is necessary because calling setup_vq() on
> an already created VQ will return early and will not enable the queue.
>
> For symmetry, suspend a VQ instead of tearing it down when the number of
> VQ pairs decreases. But only if the resume operation is supported.
>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/ml=
x5_vnet.c
> index 0e1c1b7ff297..249b5afbe34a 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -2130,14 +2130,22 @@ static int change_num_qps(struct mlx5_vdpa_dev *m=
vdev, int newqps)
>                 if (err)
>                         return err;
>
> -               for (i =3D ndev->cur_num_vqs - 1; i >=3D 2 * newqps; i--)
> -                       teardown_vq(ndev, &ndev->vqs[i]);
> +               for (i =3D ndev->cur_num_vqs - 1; i >=3D 2 * newqps; i--)=
 {
> +                       struct mlx5_vdpa_virtqueue *mvq =3D &ndev->vqs[i]=
;
> +
> +                       if (is_resumable(ndev))
> +                               suspend_vq(ndev, mvq);
> +                       else
> +                               teardown_vq(ndev, mvq);
> +               }
>
>                 ndev->cur_num_vqs =3D 2 * newqps;
>         } else {
>                 ndev->cur_num_vqs =3D 2 * newqps;
>                 for (i =3D cur_qps * 2; i < 2 * newqps; i++) {
> -                       err =3D setup_vq(ndev, &ndev->vqs[i], true);
> +                       struct mlx5_vdpa_virtqueue *mvq =3D &ndev->vqs[i]=
;
> +
> +                       err =3D mvq->initialized ? resume_vq(ndev, mvq) :=
 setup_vq(ndev, mvq, true);
>                         if (err)
>                                 goto clean_added;
>                 }
>
> --
> 2.45.1
>


