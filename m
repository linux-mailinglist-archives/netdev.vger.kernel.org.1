Return-Path: <netdev+bounces-108940-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B76D692645B
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 17:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FA6E28B99C
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 15:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9238817E46A;
	Wed,  3 Jul 2024 15:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eguKBmS2"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECEB17BB1F
	for <netdev@vger.kernel.org>; Wed,  3 Jul 2024 15:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720019346; cv=none; b=Y9FKeGfykA6WLAkwrvdGfSINPn1q/0IVF9ohSkTTqtDWc++S30lXpcOwZ6KokiSEE91jFHbdkoBuwCS3Lv9Tfq1R4iuaKs9AfcvuapKg400CJxOQp0ujOlqAs84/lxDbuQSO++Gg4vq6xk93ASyesiaa8YfJhTHMqZbTY1lX2CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720019346; c=relaxed/simple;
	bh=jr1zoQlesMQk4r7o3HlIip0zDDWr+3fEo4jdfJsQNtU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GNVW7I+WIFtXJiBoZJguSJX9XZRagD0cJBR6gLkjySE1mJBInd6gfwyyKRYwfZ5tjl9ru5+drCFz9v1B51SwBrsPViMR46STRl2/Ar7yzrtQA6DaHjw23LG7EyQWablYS39cBkgj3v3cJltIEwZOg9iwRap17OJMwBtuePonWnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eguKBmS2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720019344;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hJxP5plkEqtGT2+Fyxc7Jfw1c1Ky2bpGqcVIJ84Skao=;
	b=eguKBmS2LunH//1RcHYotI0m7k6TqnL3y+VoTgnl81FONt7J0kdcYgCLrKeFnL4ZDb+HIp
	r3XPiU/e8lYoJbha84Tbz8I2FZQqhSMi+kEtUd8EP1otS9gWHr/kmlaZfJIRvgMahG1Jfw
	3QQeqpmzk1qCtNJ5Fy3aYbndeQbnDlU=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-107-Pb_2dfP2MxaB3fY_317LCA-1; Wed, 03 Jul 2024 11:09:01 -0400
X-MC-Unique: Pb_2dfP2MxaB3fY_317LCA-1
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-700cd2139cfso6371240a34.3
        for <netdev@vger.kernel.org>; Wed, 03 Jul 2024 08:09:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720019341; x=1720624141;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hJxP5plkEqtGT2+Fyxc7Jfw1c1Ky2bpGqcVIJ84Skao=;
        b=GrfvTxv5SU9XqFeK5vOW9J8FcveEw35T9bU66FYmpZxCdnN4PGmrMN54Ln2sN8Bsbl
         T9ivtqb1Z1tkPLR81ZCkfIMOD4xD9XjKIgaUjbACDU4cQEW77xa5CpdYxQpOw/wHG1dd
         mPLpimUE0JqH+pdY+U0wk+pBu4aQcvi3Ip6zNtYw5pY48rN5ph2hUGLbyOlM+3Xml4+p
         qgXEAMSO+/m8vd5ogKwFPq8FyesS2lgtBOJ99x4c2tgp4Dn/1U4HkmEg0FSDaFjJBKCs
         qUmOA1dqvpFS4gmE0W6VE0tFGLYxae6icASBm3zW4QdW7Ok8CQUNSk/sirBuoyN1vRZE
         xq0w==
X-Forwarded-Encrypted: i=1; AJvYcCX1L8/WGG3q/DHlfkKQ4ClKvARxsB42q04Jp3aMVMPmdkmXJebUA6BfpOHKD6B0jn/avnU80Bptc9+upES4ay/4WziVYxGT
X-Gm-Message-State: AOJu0YzcLZzhxiIcb/tkWnamny4th1Hy2N8TE4HizU+WGpGFQk8g5E0V
	P9JuWY7X3QWTSWqoolXRGPC7OvJjFkIlwZkKrHYkGC+P4fuaHXtmdYXaOXzQQ9WHLYbRTpWnPTp
	uf1tChDSfvPW79YXw7VFtvH/fLWtJqba+qFcpSV4LAJSCCGl78O8ZzEqf2DkvNtbDVumGoSgqwp
	u6ayMsDsgGWjw+5GPdJ9U86lRERzHm
X-Received: by 2002:a9d:68d8:0:b0:702:2550:4e2c with SMTP id 46e09a7af769-702255051e8mr4714175a34.14.1720019340946;
        Wed, 03 Jul 2024 08:09:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZVFTIESQ8I8751zJPQrUjeFOeuFR0etgZWdHlMXhxuGEMPW7TYqK1PmAoORoUI/N+D8s9cfchZbSZ1h971QY=
X-Received: by 2002:a9d:68d8:0:b0:702:2550:4e2c with SMTP id
 46e09a7af769-702255051e8mr4714149a34.14.1720019340676; Wed, 03 Jul 2024
 08:09:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240626-stage-vdpa-vq-precreate-v2-0-560c491078df@nvidia.com> <20240626-stage-vdpa-vq-precreate-v2-9-560c491078df@nvidia.com>
In-Reply-To: <20240626-stage-vdpa-vq-precreate-v2-9-560c491078df@nvidia.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 3 Jul 2024 17:08:24 +0200
Message-ID: <CAJaqyWf-MRS9ahonzAvuHVQ4dfgm6FQPmqk_vKMiRag7XDB8Sw@mail.gmail.com>
Subject: Re: [PATCH vhost v2 09/24] vdpa/mlx5: Rename init_mvqs
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Si-Wei Liu <si-wei.liu@oracle.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2024 at 12:27=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia.co=
m> wrote:
>
> Function is used to set default values, so name it accordingly.
>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>

Reviewed-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/ml=
x5_vnet.c
> index de013b5a2815..739c2886fc33 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -155,7 +155,7 @@ static bool is_index_valid(struct mlx5_vdpa_dev *mvde=
v, u16 idx)
>  }
>
>  static void free_fixed_resources(struct mlx5_vdpa_net *ndev);
> -static void init_mvqs(struct mlx5_vdpa_net *ndev);
> +static void mvqs_set_defaults(struct mlx5_vdpa_net *ndev);
>  static int setup_vq_resources(struct mlx5_vdpa_net *ndev);
>  static void teardown_vq_resources(struct mlx5_vdpa_net *ndev);
>
> @@ -2810,7 +2810,7 @@ static void restore_channels_info(struct mlx5_vdpa_=
net *ndev)
>         int i;
>
>         mlx5_clear_vqs(ndev);
> -       init_mvqs(ndev);
> +       mvqs_set_defaults(ndev);
>         for (i =3D 0; i < ndev->mvdev.max_vqs; i++) {
>                 mvq =3D &ndev->vqs[i];
>                 ri =3D &mvq->ri;
> @@ -3023,7 +3023,7 @@ static int mlx5_vdpa_compat_reset(struct vdpa_devic=
e *vdev, u32 flags)
>         down_write(&ndev->reslock);
>         unregister_link_notifier(ndev);
>         teardown_vq_resources(ndev);
> -       init_mvqs(ndev);
> +       mvqs_set_defaults(ndev);
>
>         if (flags & VDPA_RESET_F_CLEAN_MAP)
>                 mlx5_vdpa_destroy_mr_resources(&ndev->mvdev);
> @@ -3485,7 +3485,7 @@ static void free_fixed_resources(struct mlx5_vdpa_n=
et *ndev)
>         res->valid =3D false;
>  }
>
> -static void init_mvqs(struct mlx5_vdpa_net *ndev)
> +static void mvqs_set_defaults(struct mlx5_vdpa_net *ndev)
>  {
>         struct mlx5_vdpa_virtqueue *mvq;
>         int i;
> @@ -3635,7 +3635,7 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *=
v_mdev, const char *name,
>         }
>         ndev->cur_num_vqs =3D MLX5V_DEFAULT_VQ_COUNT;
>
> -       init_mvqs(ndev);
> +       mvqs_set_defaults(ndev);
>         allocate_irqs(ndev);
>         init_rwsem(&ndev->reslock);
>         config =3D &ndev->config;
>
> --
> 2.45.1
>


