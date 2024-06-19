Return-Path: <netdev+bounces-104829-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E30590E8E6
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 13:03:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1309B1F2183F
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 11:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 946EA13664C;
	Wed, 19 Jun 2024 11:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iEb/nmFb"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E082413212D
	for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 11:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718794996; cv=none; b=pEhzvkuaW1Doi7ux/41QSP8PzdGS+DCkdIpKNjOjXtXSKo0isQ82lhQ/RZvFEkKbQvIvOzRL1y3IpoZwUeBGQumjbuPvbJMFJZCNIrzQarMOj+PVCJHVWV/nz0IKxOqcw+XnWgwFp969IEw3quEKLo05l2xsd0WISVML+20ixb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718794996; c=relaxed/simple;
	bh=1bdmFYChepEqjby6FGx8U06BldFaO0w3AEyYFVmPYEo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LCZ+4+YsX69CgsAlaEOx3xaA/+hvZscpehweYxkfgC8UkABh9eKe4nhDwX/5xy0uWBNeaGY2z7I1bAZh9ajWJlzOGPtjmxsBu0rvNWSX7ozd1OytTeSZfeTPR0KKu/eWpGOO9wrgVEfjXSbaiBVoN84ADNEoWH9x58eScTQ2Cj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iEb/nmFb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718794993;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V/M7MnGXwS8uLXvNZgVDSoX5YtxoFcpHgW7L/ahwWrY=;
	b=iEb/nmFbPREPlkwT2L1YiNacxIcuVFm8JaxaktXdjiCTQQJH2SFy1kY1lPoktCunhdUvTK
	huasTdPLxkGvrKKpTG6wHji93K6Veusix0Sp/xgL1vEX/f2zdCjOiA6LRl2oGym2UlG4eE
	ArWHbLMaAKINd+WznubSN88eZ6CqwnM=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-496-ekvkvAd6MO6U5UDe2rjR-A-1; Wed, 19 Jun 2024 07:03:11 -0400
X-MC-Unique: ekvkvAd6MO6U5UDe2rjR-A-1
Received: by mail-yb1-f200.google.com with SMTP id 3f1490d57ef6-e02b7adfb95so2887867276.2
        for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 04:03:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718794991; x=1719399791;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V/M7MnGXwS8uLXvNZgVDSoX5YtxoFcpHgW7L/ahwWrY=;
        b=wG6OWbiiSjlD20DB9q1amBvb8C6JuYpXQOUQlwyGqejOSq9L+Q44+4uvQ8Uma6jFY1
         V9KZ15lQKJ9pqvQqrr9hkj/uvQ1qotEoUkcYb+LKHiFa7sAVnubNoxN/Po8hbJmXkmkq
         aRDHXQMJAgGbdE1sBS3waGctwghSIcsy0WWe+4BIDmU33whSCugVmtPeDLH2GFFdb+OU
         0KEgtZuCFathGFFqKR/Cqd6bRLZDaGzt/N6Q8Juv/Z1uXitAOVgtH167At+xHvm3ywze
         /ydJquvgMm7y5SwH1KxB5yXpLVDaDVV9GsQenN3K+UtrDJXTYYiXcpiW/gup04pv0ddr
         GynA==
X-Forwarded-Encrypted: i=1; AJvYcCVAlqq2FrZZ9RJXnlrk8lIrUzkwfVBvxSsrR1nj5syzyBxEJh9EuvwmuHwTclF/YQcriRnKgrKvjfzsPq0u3QoYq5Ug/niv
X-Gm-Message-State: AOJu0YyWNlhPsKzRt3rdxgzzbPPSqp+XuQJ5M4v8FGIIPMlj5SNeLNjV
	Ovn87yYYcXDoURQSlLOPhZKh3AcjwqTc3UwQ5YQovVCRp7cCY8gmQ/rxfhLtyHSmnsxgp3SowR7
	Vt6ziQgWWpX2N2rgTW1zPzDLBMeMopgauitDmdLAVZabvoUKmCZgg7OmsdzfLQG3uWBmlrhBDHK
	utfgM4483rdjh00Zt1DxY+Wif2+Gms
X-Received: by 2002:a25:24b:0:b0:e02:c29d:7dc6 with SMTP id 3f1490d57ef6-e02c29d8011mr1449189276.43.1718794991115;
        Wed, 19 Jun 2024 04:03:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMuYoMspdK9W3dvJFbwMXu6A1vxVHrL7pJhY3Nas3Emxi4QlBjq10Z0XGEVO+7m9QoYNiiYNpMnoT3yoCdFRY=
X-Received: by 2002:a25:24b:0:b0:e02:c29d:7dc6 with SMTP id
 3f1490d57ef6-e02c29d8011mr1449158276.43.1718794990800; Wed, 19 Jun 2024
 04:03:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240617-stage-vdpa-vq-precreate-v1-0-8c0483f0ca2a@nvidia.com> <20240617-stage-vdpa-vq-precreate-v1-6-8c0483f0ca2a@nvidia.com>
In-Reply-To: <20240617-stage-vdpa-vq-precreate-v1-6-8c0483f0ca2a@nvidia.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 19 Jun 2024 13:02:34 +0200
Message-ID: <CAJaqyWdHgpbmjtEP-tGgCiMGwrvkicjxXV8NLRZyDpRk97nkJA@mail.gmail.com>
Subject: Re: [PATCH vhost 06/23] vdpa/mlx5: Remove duplicate suspend code
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
> Use the dedicated suspend_vqs() function instead.
>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>

Reviewed-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/ml=
x5_vnet.c
> index 51630b1935f4..eca6f68c2eda 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -3355,17 +3355,12 @@ static int mlx5_vdpa_suspend(struct vdpa_device *=
vdev)
>  {
>         struct mlx5_vdpa_dev *mvdev =3D to_mvdev(vdev);
>         struct mlx5_vdpa_net *ndev =3D to_mlx5_vdpa_ndev(mvdev);
> -       struct mlx5_vdpa_virtqueue *mvq;
> -       int i;
>
>         mlx5_vdpa_info(mvdev, "suspending device\n");
>
>         down_write(&ndev->reslock);
>         unregister_link_notifier(ndev);
> -       for (i =3D 0; i < ndev->cur_num_vqs; i++) {
> -               mvq =3D &ndev->vqs[i];
> -               suspend_vq(ndev, mvq);
> -       }
> +       suspend_vqs(ndev);
>         mlx5_vdpa_cvq_suspend(mvdev);
>         mvdev->suspended =3D true;
>         up_write(&ndev->reslock);
>
> --
> 2.45.1
>


