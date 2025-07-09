Return-Path: <netdev+bounces-205533-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0382AAFF1D8
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 21:29:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AF0D58836C
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 19:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 926F81F956;
	Wed,  9 Jul 2025 19:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bdG5ROmx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026E220C494
	for <netdev@vger.kernel.org>; Wed,  9 Jul 2025 19:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752089377; cv=none; b=ZppP+WrjwuOjoVp2RVrCmnY5UF6nGAbatPCIc2ipz/9xQilFplzMil4q2lGhyCWenLDtAwcSntYUaQw4ATSg7G84dXUcMJlxpESD+L/vxidoTlV1NGL0LB815578hQ7+UuW0PkfFf8qaGaGVgmd+K7PhHIV248ACc3T5LH5kF5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752089377; c=relaxed/simple;
	bh=WvlEgU12AHqrPXUPdrsBsIxwXfKkI7IhlDmareXNoOw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mGozs3Iw4nsAsSvJdzDjiWYaLfIwmV5EP+rfcPQYcRwgOORi81372aVCdIqRVLji8JFKHBsaozKA7u13GqK+8jjYYdtA4YqXv3vxyTNbQnRujoodteSxhPirZdKZxCrwVq3P6N9TKMEqz18iGm1FPqvXGXn9YRpTf/MxINK+fog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bdG5ROmx; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-23dd9ae5aacso2215ad.1
        for <netdev@vger.kernel.org>; Wed, 09 Jul 2025 12:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752089375; x=1752694175; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ThbUPqHcHxCCAk0NfL8Mhvy/M6hXNg8NYsFZLUuUqM8=;
        b=bdG5ROmxHmJQuBAi56bVkOCDC/SIEa2KgP0yQK6d5IvKVYXkrZvsjQdcCiiVRPWFkH
         A+26fs+zxXWf8GXFYug9VxNtECohiH4mxZblCtns1LgatPofGfboc04q5DIEFNGHYRng
         +kwo5FnD14OiUxlm7Xe6LTMMsf9xk9Muu7TPQd8xdHjjZDeRqdvvPV8WhnfgfTUsqYDU
         sVuFcSym2AET6tIvuqamkf58vNyXkVMzq6ejKZH3I9N4iS1lxvUPx16ylxzXRYB0nTZ+
         bvDkZHpQ7GWa/O0StwPZ+LNwth9INqeqkjiXRobZiL3Mk4E8phD7fY2Zu0QxRDHSu7v5
         UuQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752089375; x=1752694175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ThbUPqHcHxCCAk0NfL8Mhvy/M6hXNg8NYsFZLUuUqM8=;
        b=BcUIR1HDbUNf2s/8auUlwFZkcbjPKGO01sAPioe383MmpnokV7DLP3pg0Y1BW9ucY+
         +0stASu4V1xyCybX4kBLbJXAXtio+VdyhuV2GgxpU2qa9mRBK0aMlhJn3m3TmAKu3oQX
         w597fc5aWe56PeJaGKnt13sAMVBQtUv3FTDJtIOJ1pHKmhbvvcRSj1ssY3XTcE2MrFks
         TpklxpPp+dZZfAYYsGvwB0T0hhnVZbxR+uI/4f912XBN2Xx5YBRur7HAYj+aIkJahoAj
         sXfsYtDluEPyTPY52wajm63ptMkltUw/IpT+4C6gMKylUiGpy6g5cT25CH9POFW+0rbq
         ankQ==
X-Forwarded-Encrypted: i=1; AJvYcCUm5/LUY1YoadCdrlH7WYYZLXUnbj48k9+vS/5nvmjGUcQD+OZYBth6dbtzDaiJKVmHfLI9mpI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf5U5b3LOZjIA2iLOJRxOfBfifXhaILJ5DOpV50pBG++viy5d8
	7TNev0j37QQNXLWHZOqWht+S/5eJ9j0Bd9roUwwg0UmdsnUn9YpVmuCj9Z9wzkAPm8CSAmld0Nt
	XqrzXhlYJOZ+opOyJjmdHB7Iz1p0vRBU0hLpJz5Rh
X-Gm-Gg: ASbGnctMqJaKC8LYECwP/eYQMgt8DYzYITOa4D0v3Cy3M4ggtzTWpQnnWExOeQ/bc0M
	KClvXbrHxvFNKrimIDk/mQT0uqGEDqbgCZwMrAv09Ak5z/Z4Dh5cF4EBJUJzQgLiN0juPnzeJfX
	Mc9jFyP/DZh0WDIJ/4Al2awB3eD3Yb7mcou1bL3gdAltcPmSKM4w+L/vUEz5M3aUE1mz9fX4MNC
	Q==
X-Google-Smtp-Source: AGHT+IFmGcieOsYc/49aPgN2RayxnQTzWH9dSjShYHF+MmJAGzB+cGQ4KLtM7r/G1atzMJ34MlkKuN6/eZhVHrr4DpM=
X-Received: by 2002:a17:902:cf4b:b0:235:e1d6:5343 with SMTP id
 d9443c01a7336-23de3814e8bmr461055ad.20.1752089374944; Wed, 09 Jul 2025
 12:29:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250709124059.516095-2-dtatulea@nvidia.com>
In-Reply-To: <20250709124059.516095-2-dtatulea@nvidia.com>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 9 Jul 2025 12:29:22 -0700
X-Gm-Features: Ac12FXzb8O6e_uyBN8jcy_9__JTqJo61P2Qu2LqNPnLDGOIUOsAO3EnKDZXDam0
Message-ID: <CAHS8izNHXvtXF+Xftocvi+1E2hZ0v9FiTWBxaY7NWhemhPy-hQ@mail.gmail.com>
Subject: Re: [PATCH net] net: Allow non parent devices to be used for ZC DMA
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: asml.silence@gmail.com, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jens Axboe <axboe@kernel.dk>, Simona Vetter <simona.vetter@ffwll.ch>, 
	Willem de Bruijn <willemb@google.com>, Kaiyuan Zhang <kaiyuanz@google.com>, cratiu@nvidia.com, 
	parav@nvidia.com, Tariq Toukan <tariqt@nvidia.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, io-uring@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 9, 2025 at 5:46=E2=80=AFAM Dragos Tatulea <dtatulea@nvidia.com>=
 wrote:
>
> For zerocopy (io_uring, devmem), there is an assumption that the
> parent device can do DMA. However that is not always the case:
> ScalableFunction devices have the DMA device in the grandparent.
>
> This patch adds a helper for getting the DMA device for a netdev from
> its parent or grandparent if necessary. The NULL case is handled in the
> callers.
>
> devmem and io_uring are updated accordingly to use this helper instead
> of directly using the parent.
>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> Fixes: 170aafe35cb9 ("netdev: support binding dma-buf to netdevice")

nit: This doesn't seem like a fix? The current code supports all
devices that are not SF well enough, right? And in the case of SF
devices, I expect net_devmem_bind_dmabuf() to fail gracefully as the
dma mapping of a device that doesn't support it, I think, would fail
gracefully. So to me this seems like an improvement rather than a bug
fix.

> Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
> ---
> Changes in v1:
> - Upgraded from RFC status.
> - Dropped driver specific bits for generic solution.
> - Implemented single patch as a fix as requested in RFC.
> - Handling of multi-PF netdevs will be handled in a subsequent patch
>   series.
>
> RFC: https://lore.kernel.org/all/20250702172433.1738947-2-dtatulea@nvidia=
.com/
> ---
>  include/linux/netdevice.h | 14 ++++++++++++++
>  io_uring/zcrx.c           |  2 +-
>  net/core/devmem.c         | 10 +++++++++-
>  3 files changed, 24 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 5847c20994d3..1cbde7193c4d 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -5560,4 +5560,18 @@ extern struct net_device *blackhole_netdev;
>                 atomic_long_add((VAL), &(DEV)->stats.__##FIELD)
>  #define DEV_STATS_READ(DEV, FIELD) atomic_long_read(&(DEV)->stats.__##FI=
ELD)
>
> +static inline struct device *netdev_get_dma_dev(const struct net_device =
*dev)
> +{
> +       struct device *dma_dev =3D dev->dev.parent;
> +
> +       if (!dma_dev)
> +               return NULL;
> +
> +       /* Some devices (e.g. SFs) have the dma device as a grandparent. =
*/
> +       if (!dma_dev->dma_mask)

I was able to confirm that !dev->dma_mask means "this device doesn't
support dma". Multiple existing places in the code seem to use this
check.

> +               dma_dev =3D dma_dev->parent;
> +
> +       return (dma_dev && dma_dev->dma_mask) ? dma_dev : NULL;

This may be a noob question, but are we sure that !dma_dev->dma_mask
&& dma_dev->parent->dma_mask !=3D NULL means that the parent is the
dma-device that we should use? I understand SF devices work that way
but it's not immediately obvious to me that this is generically true.

For example pavel came up with the case where for veth,
netdev->dev.parent =3D=3D NULL , I wonder if there are weird devices in
the wild where netdev->dev.parent->dma_mask =3D=3D NULL but that doesn't
necessarily mean that the grandparent is the dma-device that we should
use.

I guess to keep my long question short: what makes you think this is
generically safe to do? Or is it not, but we think most devices behave
this way and we're going to handle more edge cases in follow up
patches?

> +}
> +
>  #endif /* _LINUX_NETDEVICE_H */
> diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
> index 797247a34cb7..93462e5b2207 100644
> --- a/io_uring/zcrx.c
> +++ b/io_uring/zcrx.c
> @@ -584,7 +584,7 @@ int io_register_zcrx_ifq(struct io_ring_ctx *ctx,
>                 goto err;
>         }
>
> -       ifq->dev =3D ifq->netdev->dev.parent;
> +       ifq->dev =3D netdev_get_dma_dev(ifq->netdev);

nit: this hunk will not apply when backporting this to trees that only
have the Fixes commit... which makes it more weird that this is
considered a fix for that, but I'm fine either way.



--
Thanks,
Mina

