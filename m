Return-Path: <netdev+bounces-236162-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 217EAC390EA
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 05:08:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7991B4EF5DF
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 04:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4898D1FC8;
	Thu,  6 Nov 2025 04:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zp3KM2kt";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="KMzsAObW"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDFB18EAB
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 04:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762402094; cv=none; b=MOvJbWHlculhfjIP++O4A1WgM8s6bEBtrdGOIhbk62PpKzMNskJ2m4NJG4wdqOOY/H6i0JvzR1qMB+71eZMs/kRPdvDFQDPENX7lOZIOvx23wHFb/DCwsW0ftP0MGEChXY7Ikhn+5bmCcfT2/naDwL8oCzogMdw7hBoew+62ba8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762402094; c=relaxed/simple;
	bh=/clFG5PxzG9CFjAwwukXLsQUq87vBTuWgGXa+2pm7nA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zh5pLIIuLZIYLtPsUz6QQwW03TS4fD3msb0nEO8/XBa74VEMY9okjyihO14D1r0ArkmdXErcB6+BrzBlSwx2HT36uaNJl9B+Z9F6N5f3A2HWKPb1qXt+3x/8uzo8KN1TP7JyyISXjsLcz7Yb8EsjXwimuhC4XYCy846gGZ4xvPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zp3KM2kt; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=KMzsAObW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762402091;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4ErEHllqGXQa1rX1HuSUsA/o+LeE0c0+S+I56A0yD3w=;
	b=Zp3KM2ktUbUJ3hKNTqu256D4N8G2OO4JpcNKiOGQN9xqL/on2fWCj5cl3CksnGkcZgzpLE
	rWpj71Xmjusur9nOT9VaOk8oe4j94XCb5jtIb/t5pjLU601h77nQB67aXk6SBKNqlmWiag
	SiUia33ZrxvBHJSYVnLkecHygMw68uY=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-9-XlyjL-M8PIO42sqRAsxKeg-1; Wed, 05 Nov 2025 23:08:10 -0500
X-MC-Unique: XlyjL-M8PIO42sqRAsxKeg-1
X-Mimecast-MFC-AGG-ID: XlyjL-M8PIO42sqRAsxKeg_1762402089
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-5dd89f3557bso272704137.2
        for <netdev@vger.kernel.org>; Wed, 05 Nov 2025 20:08:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762402089; x=1763006889; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ErEHllqGXQa1rX1HuSUsA/o+LeE0c0+S+I56A0yD3w=;
        b=KMzsAObWQud9G/XsYwNv47KrnUbUPlLJMo1nHm+NI+f+cLImuclMnL5ZLGSqyckc9A
         8XKbZWz1gKgiyuS16XDibbwpAD5GLZhyUIS9P1VQtVNocx8uIYv+AE2ed8wIJZCmGkLI
         p2zRb2KihZYpJtS2jByiYNuBuS/ZzYCKeMcyPzlIYwe8aMlATKa5UKrs+rC5wEhJx401
         gQSiZZN3gBKMvLmnj/5Z44AoJAURPkvdsp5ebJk8nfE/DXFRfdn4GQFidLSJRXXR+Ko/
         lNOBzq6604bbfj6XdfQs/C4Ki0q7V/SYms/+FnJyOr5K8ESz8I/XNYY90jftjyrhA35A
         Q3qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762402089; x=1763006889;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4ErEHllqGXQa1rX1HuSUsA/o+LeE0c0+S+I56A0yD3w=;
        b=AR5BvNmL2RAMxVOErSKMM+cyJNJpPxfhiXZs+94Iow3D8LGhtIv6S8uH6Ihk7+HIRB
         Ce7elWbNF0zXOwWyZYenKr5rkZk2NCX2NMAuvEVjLd2M9jpJHPxDTgAHYAjKwFjMrK0X
         9TtXyAQLCRPiekvbQ+TVEt6PZiOGQaOr0zGUjJR9nKJzZ2g7BB7SrCrPndW6ZEyT4qSU
         vMWIjYUFWJuHuMRvUIdGJ/spXIDbuPzrbhbiBy9uJqrUYd4tdp2cQo+KmVrzHgmFuTp8
         d7rd5NKme2j6OmqZvJ1Jtz+7ZgK320DodRZnPCSVQzSPQcWFP2lpAwgwbN+/qGZns8rn
         D+LQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwYwTYI7cQw2DOwFgbxPNM1qXTXesFQwGaXRpZvh98VCQFiVNFIXMtRQs/1L2lnx3sJZtUMYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YztXk5RlzOMNF/E5+2o+u/LSoAOs6PWD/EZcVh0tKOKQsKVA/pa
	Tgn/5XpZpGL+uqQGYvEZh+qFk2QcxbKg9/yrf3KM5B9zxGPsdWWrnvSl6Hjv7oAbEunjS3rrtlo
	aa2xRV9drLgwYodJdPLnkIcl/v3svDt3JpUx0Gwe0j+blQcAp6n3J+uZpxYtM2LLyj/XBDyPQm6
	xaFKOPC0c9BpwLS4RxpzUZe9tEHOv0M/Ag
X-Gm-Gg: ASbGncvuT5JmsQdb9cqsCSRgM6XvdKchbtUM50j6SWA6epY4BIy1U66E8jwiGYihBJ+
	p7C89zdiJtAWi01Jg8w4xOD/sNIYXa0VPpm+Vjj8Fn5u6C5223lkCNHmASCjuzDgsO2/4EpCR2V
	TnKaxIY95FcSbro1OxV9YcZP564pMkh/R0Ka5Wx6fvctfA3H2sEJ5ihPJY
X-Received: by 2002:a05:6102:2ac2:b0:5db:ca19:f02f with SMTP id ada2fe7eead31-5dd88ef0787mr2077863137.9.1762402089471;
        Wed, 05 Nov 2025 20:08:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGsGQZaJVQOEVAkyZ4GeLriyj8SNnSrORtKtMKUrl76u33NNLwRG6BIbywMULZtgOZQKt+9Amf1gB0m2UWnG7g=
X-Received: by 2002:a05:6102:2ac2:b0:5db:ca19:f02f with SMTP id
 ada2fe7eead31-5dd88ef0787mr2077859137.9.1762402089047; Wed, 05 Nov 2025
 20:08:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105080151.1115698-1-lulu@redhat.com>
In-Reply-To: <20251105080151.1115698-1-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 6 Nov 2025 12:07:55 +0800
X-Gm-Features: AWmQ_blkjcF91oRQFm8CV6EBB0pbTNMJW4V9b4A10CbddPExXzNM8-bAP5bZeBQ
Message-ID: <CACGkMEvriYoN2XZLmB0KcJmH4hVT3iYj3QV_ypfgHSQNwv296w@mail.gmail.com>
Subject: Re: [PATCH 1/2] vdpa/mlx5: update mlx_features with driver state check
To: Cindy Lu <lulu@redhat.com>
Cc: dtatulea@nvidia.com, mst@redhat.com, netdev@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 4:02=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> Add logic in mlx5_vdpa_set_attr() to ensure the VIRTIO_NET_F_MAC
> feature bit is properly set only when the device is not yet in
> the DRIVER_OK (running) state.
>
> This makes the MAC address visible in the output of:
>
>  vdpa dev config show -jp
>
> when the device is created without an initial MAC address.
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/ml=
x5_vnet.c
> index 82034efb74fc..e38aa3a335fc 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -4057,6 +4057,12 @@ static int mlx5_vdpa_set_attr(struct vdpa_mgmt_dev=
 *v_mdev, struct vdpa_device *
>         ndev =3D to_mlx5_vdpa_ndev(mvdev);
>         mdev =3D mvdev->mdev;
>         config =3D &ndev->config;
> +       if (!(ndev->mvdev.status & VIRTIO_CONFIG_S_DRIVER_OK)) {
> +               ndev->mvdev.mlx_features |=3D BIT_ULL(VIRTIO_NET_F_MAC);
> +       } else {
> +               mlx5_vdpa_warn(mvdev, "device running, skip updating MAC\=
n");
> +               return err;
> +       }

I don't get the logic here, mgmt risk themselve for such races or what
would happen if we don't do this?

Thanks

>
>         down_write(&ndev->reslock);
>         if (add_config->mask & (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR)) {
> --
> 2.45.0
>


