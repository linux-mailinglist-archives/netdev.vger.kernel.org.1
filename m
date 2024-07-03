Return-Path: <netdev+bounces-108962-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69EBA926614
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 18:25:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B7F81C22F0F
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 16:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38BCA1822DF;
	Wed,  3 Jul 2024 16:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZN1u5gD2"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF896185E4D
	for <netdev@vger.kernel.org>; Wed,  3 Jul 2024 16:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720023812; cv=none; b=UZF1wAQnlEA21EHWRj0cnBjsWUSWATwOW7H+24JJzcMul9x2Q0hKxg/JhC8QdHubn5DFgCBhfcYyrNYH7hfxr1Jk2Q+wDAY/0x7B8wD1ln9oz4wEhfxicTPYTL6WcJcnmFNELH9FSCAFAZ45nEj5ujgy+y63293FsVVK0x3nRiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720023812; c=relaxed/simple;
	bh=yAl9WkIF75Z5792jsKO6kzvCg4MDRUb7mflCnX2qKpE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JOUEYtMQ8jLjgelEdGHlrEuuC4hStSX3q2diX5wkS7tRJvYtKwbg0KayowndCvimZnSnk0AuILZpHb80E2BxK3Ts24aAS4c3yILHrE1Yk2tlBRQ+3AFD16s0YNsjVMCi90xj6dd3ofudGGwTjFbnQ5o7Cb7MYhIuEDaMpS8fBQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZN1u5gD2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720023809;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n91rt4myNGjgsOAzA53ROWPaLTAmQTcNbTctluHszT0=;
	b=ZN1u5gD2TtfSdfUDYeUg+Bu8Mwq57Z8mgZLKJRCBusxJZK0Y2WOZPmMQoH/wUIds1nePVI
	iCUTbmKVbBRmDH/un3YL3ZH6SmlRwleNATuol2xctjsURxUZl6okeJ7yoBIOSmOxJmMtUK
	6xh2iwfNNm1+mBfA2aJ3Zx09+gII8W0=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-215-F6G-vRJePQqkkZg4NIxkQg-1; Wed, 03 Jul 2024 12:23:27 -0400
X-MC-Unique: F6G-vRJePQqkkZg4NIxkQg-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-57851ae6090so2393859a12.3
        for <netdev@vger.kernel.org>; Wed, 03 Jul 2024 09:23:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720023806; x=1720628606;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n91rt4myNGjgsOAzA53ROWPaLTAmQTcNbTctluHszT0=;
        b=KCqJ7mIJztn89CAdDchGcsSE/VcpuCYLY5ZilCLAIF50BbUtscHj4HQxqaimX1E4Hg
         OCHJYMo8SbV7RI8w6iekfN8lEB971aktzrLatrnBTbMhx+tdCsMsP8VYHQvfVhEV7/EN
         CnTOaE7fcMmD+doiwCZDBgYWm1B23pXPM91MP2rnB3YI0zYZ5MvsWZ/wkm8RnmmiP8e7
         A6PwdwNuOlBXbaSCEjCLBXhfpEKhqu4Qx8rkGZcJqYK5u6VZx/pC2fQWxkgXoe2qBGM2
         WAz/2vj2z3iggohqPZKwIHuEcFmao83T090qnQVlUzrbwMTy9capAHepGZNo4CXJp+xN
         tRwA==
X-Forwarded-Encrypted: i=1; AJvYcCXQA/7kUNGTNwEYqLlBjhP/IJEgx5mEV9+HMcv/VdNV+g8KpMRIX3r4J3fggwzUgQSoym+DRhu0k5RzGJsw45c4QrpoXH04
X-Gm-Message-State: AOJu0Yxuwe4TjF9jrDh2Lyzwli0Um8ySsYYc+HlaZsy/W/aWFj6+V/yJ
	MjplTMNnrHFuPWk5YiPEvjCXjav+bpw2OHlvpG+EFrVdX76LNKs2zdgTgYXcd2xisZLLN8qKZV8
	pAAJIfn3BE8DrjkrPKO7BdXLxz33uQWqHv/oGg1id/IloNgX4CVW0Jiwa+yRJcHq/4gXNqPzNKs
	k79QyfyLI3GIHfPjS6++y0rlZfPqZF
X-Received: by 2002:a05:6402:1cc1:b0:57c:6188:875a with SMTP id 4fb4d7f45d1cf-587a0637437mr7847856a12.26.1720023806607;
        Wed, 03 Jul 2024 09:23:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDKcKhOUx+NmAMpJL8tgtpN3L8p4uaUWiZMnuqg99iVFuWIDVp5qSLrtsQb/GpER4ZLfVxi176Yy0Dko+cScU=
X-Received: by 2002:a05:6402:1cc1:b0:57c:6188:875a with SMTP id
 4fb4d7f45d1cf-587a0637437mr7847840a12.26.1720023806248; Wed, 03 Jul 2024
 09:23:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240626-stage-vdpa-vq-precreate-v2-0-560c491078df@nvidia.com> <20240626-stage-vdpa-vq-precreate-v2-19-560c491078df@nvidia.com>
In-Reply-To: <20240626-stage-vdpa-vq-precreate-v2-19-560c491078df@nvidia.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 3 Jul 2024 18:22:47 +0200
Message-ID: <CAJaqyWccNsTo16CzUmSwNLFw2CTinrQ47YQ2JjRndyHLeRVFNg@mail.gmail.com>
Subject: Re: [PATCH vhost v2 19/24] vdpa/mlx5: Forward error in suspend/resume device
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Si-Wei Liu <si-wei.liu@oracle.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org, 
	Cosmin Ratiu <cratiu@nvidia.com>, Zhu Yanjun <yanjun.zhu@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2024 at 12:28=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia.co=
m> wrote:
>
> Start using the suspend/resume_vq() error return codes previously added.
>
> Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
> Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>

Reviewed-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/ml=
x5_vnet.c
> index e65d488f7a08..ce1f6a1f36cd 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -3436,22 +3436,25 @@ static int mlx5_vdpa_suspend(struct vdpa_device *=
vdev)
>  {
>         struct mlx5_vdpa_dev *mvdev =3D to_mvdev(vdev);
>         struct mlx5_vdpa_net *ndev =3D to_mlx5_vdpa_ndev(mvdev);
> +       int err;
>
>         mlx5_vdpa_info(mvdev, "suspending device\n");
>
>         down_write(&ndev->reslock);
>         unregister_link_notifier(ndev);
> -       suspend_vqs(ndev);
> +       err =3D suspend_vqs(ndev);
>         mlx5_vdpa_cvq_suspend(mvdev);
>         mvdev->suspended =3D true;
>         up_write(&ndev->reslock);
> -       return 0;
> +
> +       return err;
>  }
>
>  static int mlx5_vdpa_resume(struct vdpa_device *vdev)
>  {
>         struct mlx5_vdpa_dev *mvdev =3D to_mvdev(vdev);
>         struct mlx5_vdpa_net *ndev;
> +       int err;
>
>         ndev =3D to_mlx5_vdpa_ndev(mvdev);
>
> @@ -3459,10 +3462,11 @@ static int mlx5_vdpa_resume(struct vdpa_device *v=
dev)
>
>         down_write(&ndev->reslock);
>         mvdev->suspended =3D false;
> -       resume_vqs(ndev);
> +       err =3D resume_vqs(ndev);
>         register_link_notifier(ndev);
>         up_write(&ndev->reslock);
> -       return 0;
> +
> +       return err;
>  }
>
>  static int mlx5_set_group_asid(struct vdpa_device *vdev, u32 group,
>
> --
> 2.45.1
>


