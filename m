Return-Path: <netdev+bounces-104828-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 013DE90E8C9
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 12:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BB56287635
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 10:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C1713212C;
	Wed, 19 Jun 2024 10:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VGmNlQfd"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77367132112
	for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 10:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718794620; cv=none; b=oyw2Nd3rFf/0aNqbRVq+EpF/LVARjUnL0adYE1uxR1LZeGpoyce1XCNaNMMUsakRO3HWJ3vbABsjKerr8uN0stwiHui7wthwCGdBoK8nd82uJrWRbSALrPGbXXi9seo180RI/BI+qeeRu5kOcZX44VwhGMLrmgzTeBuU1RX5+wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718794620; c=relaxed/simple;
	bh=4smyqk//gciZ2tfr+0FYpp38iYLlwv1szyuA5ggeH4A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rb2GRwSh+OIOmObddm10fQHnp859FlQfu8BmXjDY//oJujkhS+1QyPrGsj1fqR4j26ZV1waKheppiy9eChByasr+jmenHMsNMdhioOOFAjiRPyFa0R+7T01y+bn2Bd83qTb1dFj7QDVUxKkTvZ/6bFLWUwg+frQ5nDv7r8WnjdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VGmNlQfd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718794617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VjZbrAKeWPPaFJmvloNszCVxus289ALpCaWtq/6RLHQ=;
	b=VGmNlQfdae3s1lXGKpNCfo6UR5Nf3II/2ttFvRyQE20xyRK+7tBPPLLF8HPqt+QjoC8OUQ
	wLqAd5s39apk14u81N7bwIFR3IJe1fGDuhGTtVcM5185F4kyI5bWL2Ggu4sJrT6H3OsbuI
	5bF+o3KCSKhkLWaAzANeVR48LQPprfg=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-136-YvRcA3IwOveoCxTNzB618A-1; Wed, 19 Jun 2024 06:56:56 -0400
X-MC-Unique: YvRcA3IwOveoCxTNzB618A-1
Received: by mail-yb1-f199.google.com with SMTP id 3f1490d57ef6-e023e936ac4so3500776276.0
        for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 03:56:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718794615; x=1719399415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VjZbrAKeWPPaFJmvloNszCVxus289ALpCaWtq/6RLHQ=;
        b=XRI1lewPDMruogSNkB6p6Xz0tjXRb6lc3BDpIVW7KDW/nAYUp2cdKuHFG8Go6xC7Qt
         naiyjHs3avjfaLq8iQVt1B3AvHy5yOcRVbFTtlWLLWZrbMoMXDOsmKshC9PaDI4NLjyM
         00qJCH/FEn4zL+Gq8dXqr9ahBV9SRI4Yrv94vr/nhbIFxu0g2x3ppWNeg9jhlrXiReo1
         awTInbBo/020PVGitSBUe93BP4aVtmSsYsrrh8zqstYM0WR18BxjQ9tsAQI6JqVeiL7n
         jyTnL+VXcRsHltJVDCyWLQVdmWmbCeS3uBO21uVowh0RvefbzwdvM3KP2gBMQuWDQ501
         UZcg==
X-Forwarded-Encrypted: i=1; AJvYcCXYndft64yr0GXm5hXjAqJA2Zf+GPTThy4dg3bHQXzJnPHntXFZLKgfS8/8ay8pBRKygpZoKeYcc823aVxGZbeCGfmO7lzU
X-Gm-Message-State: AOJu0Yy0Vz56PaqzipTjet0Z+8TvapLjs0euIg4teDUGB4z5ptKYjZdQ
	v0LLuznfQWg+MNEogMtDttSmg4KH/sD8u4YrxKZNslbgcD0Kh5Iqhu0t0XKclfvOVaC2gVY/gnW
	L6preFEaTkbdNUJS+DJ8Meh65HX2fFvqCwBoJPzxIIsQuVSl3q7quiB7yZnQKt1Ccnkc9ZqhHNe
	xj7oLWXYtKZ7P0/UOvEl1bCxzGfsaN
X-Received: by 2002:a05:6902:18c8:b0:dff:2f78:a5e2 with SMTP id 3f1490d57ef6-e02be20b9fbmr3077305276.48.1718794615596;
        Wed, 19 Jun 2024 03:56:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBUNHSRsqjjtkqh3anCM1rUWgihsBSlpbQwcOBllw4ugAGeY3IlZgXoYdaWC9Vjxq0GasRjZJb7rLeAgR/w+0=
X-Received: by 2002:a05:6902:18c8:b0:dff:2f78:a5e2 with SMTP id
 3f1490d57ef6-e02be20b9fbmr3077292276.48.1718794615243; Wed, 19 Jun 2024
 03:56:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240617-stage-vdpa-vq-precreate-v1-0-8c0483f0ca2a@nvidia.com> <20240617-stage-vdpa-vq-precreate-v1-4-8c0483f0ca2a@nvidia.com>
In-Reply-To: <20240617-stage-vdpa-vq-precreate-v1-4-8c0483f0ca2a@nvidia.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 19 Jun 2024 12:56:19 +0200
Message-ID: <CAJaqyWe_ShF4HkhxsdHjgaBAMwCvw10_t9Wk_-A0QyPT+zFEbQ@mail.gmail.com>
Subject: Re: [PATCH vhost 04/23] vdpa/mlx5: Drop redundant check in teardown_virtqueues()
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
> The check is done inside teardown_vq().
>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>

Reviewed-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/ml=
x5_vnet.c
> index b4d9ef4f66c8..96782b34e2b2 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -2559,16 +2559,10 @@ static int setup_virtqueues(struct mlx5_vdpa_dev =
*mvdev)
>
>  static void teardown_virtqueues(struct mlx5_vdpa_net *ndev)
>  {
> -       struct mlx5_vdpa_virtqueue *mvq;
>         int i;
>
> -       for (i =3D ndev->mvdev.max_vqs - 1; i >=3D 0; i--) {
> -               mvq =3D &ndev->vqs[i];
> -               if (!mvq->initialized)
> -                       continue;
> -
> -               teardown_vq(ndev, mvq);
> -       }
> +       for (i =3D ndev->mvdev.max_vqs - 1; i >=3D 0; i--)
> +               teardown_vq(ndev, &ndev->vqs[i]);
>  }
>
>  static void update_cvq_info(struct mlx5_vdpa_dev *mvdev)
>
> --
> 2.45.1
>


