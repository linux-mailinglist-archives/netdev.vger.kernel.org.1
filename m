Return-Path: <netdev+bounces-96602-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13AE38C69A5
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 17:28:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C21DE282FC3
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 15:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8C40156221;
	Wed, 15 May 2024 15:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xGP7GerI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144CF15575A
	for <netdev@vger.kernel.org>; Wed, 15 May 2024 15:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715786881; cv=none; b=NTHebm3P2f4nRAutETcw4Nj1UrU4Vg/d/hnfPTyNCbqD5+8tdBGQ36rNB+YTCBJyl8bs+0CLDBu0sWBEdKs1IuPPczdlFBhiiKPV7OMASMYeUZVUj60QwhGwmO4QbgzOofCBn0bB0gF3mUG38eo+/wjn8DChDYv7UONUUn+ngoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715786881; c=relaxed/simple;
	bh=uEvMKF3uwyKPakD5edexvI8ElbNThkFQyh0n33CBN3g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DFG0DisNG2njFQeURI9IK5M4hMzLEzBx92qz/+yC7Wq0lebuzFshgLA+WvUHVoyE6P8lZTEix5YTnA1qPttYwQJN6TJRaEmQ5fKQwUmGSkbrYxW0TVR5//i3HxMjb5n2FB07CKc5eZDDq1IJLsu2gis4Mu/dLuvj2X90bD0yHlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xGP7GerI; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-572aad902baso32898a12.0
        for <netdev@vger.kernel.org>; Wed, 15 May 2024 08:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715786878; x=1716391678; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TmH/Ugjxp31Mi4ohhV34lW02fEsBuZ04RNA7UDSOQrM=;
        b=xGP7GerIZPU9lXrExvw3bOrDS3+cT/2o+la5AjPMofWxUzwplZ3OTA93T58jAPBYCC
         67WljSSxatPWeE6CPWlxo+mb1XH0qVa9Nov9NUTnii6+NaGIw+hYSe58e1gL25gCyHPl
         kEH3mgXpIN1B4NhAMICH8BiqaD+cvvmGcLnzOfW1keMh6IuftIZjc+h4MQNmQ4VTmkJg
         PHKukDRkoVIYJ0LAWnpatdU/WiMFVZWMm+QNa/mPJ07xezFEW2hPxfdFnslVOdiFHKoy
         A9bMEL0AQ2iSfn4TGKGj2YWtuYdbbGzXtGb12/VDU/mQTMyvBRvGeHZtTYOtUTIq3sEP
         5bog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715786878; x=1716391678;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TmH/Ugjxp31Mi4ohhV34lW02fEsBuZ04RNA7UDSOQrM=;
        b=mmdpb4A1JaNiIoDXCF5D0o3/swVHUDqqtb74jJcOSO2vgXn+uTqyytUi73t6VllyKl
         Qw5JaBFccekKb4B+wJxsdlK/Rq1Z+eBTPGln8fy/JANgIFdvQ0b5Bzn3vkM9HY0EcKVA
         M27w5Zs7bfcCNGXL7uPNWFIVtsTp27Rbk6rNVLPp7Y9L2C4hlST+VfXfEJFrRr2A9+z0
         uTLB7WG3NU2BqF/uui3tzB0vKlMWdNTlP3BAyPx1QAOh1WRma+Z48OBHJ4UiKgc4Q0vN
         zb7dk+YX8KoVDSvCC/iyE/9/NiortXlNM5blV579LNDR3Cj5hU4Pox5NaWDCufz09GCb
         H5Ow==
X-Gm-Message-State: AOJu0Yw5mlKZs8UcPiE0AzChVLD1+VYIqItNtMtrLhVgQXEi8G/lSe9O
	vNyG2fr+uK8awZ8PZBiJwOdUv9+m63rXDJ/ai58PbPoFdx4q6MpjE5ojOMin+ffR5jBE/6y/XU5
	iD5GtE4/Y0Pum7SezMr2lP1x8sXFwPvmlnYRL
X-Google-Smtp-Source: AGHT+IHzpp6BZkotoofyDJ4SdL5oyEIvlY9OgIr2daPi3sRGR0q58ATvx4vc/z6ta2RnisKfIJytMRUBnfCNmphB9+8=
X-Received: by 2002:a05:6402:5248:b0:574:e7e1:35bf with SMTP id
 4fb4d7f45d1cf-574e7e13675mr480199a12.7.1715786878207; Wed, 15 May 2024
 08:27:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240515151152.564085-1-danielj@nvidia.com>
In-Reply-To: <20240515151152.564085-1-danielj@nvidia.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 15 May 2024 17:27:44 +0200
Message-ID: <CANn89iJmr9ZtfT0jp5kcLC9BKha_QM2U0CpgeuaztMEo4nX64A@mail.gmail.com>
Subject: Re: [PATCH v2] virtio_net: Fix missed rtnl_unlock
To: Daniel Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, mst@redhat.com, jasowang@redhat.com, 
	xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, jiri@nvidia.com, 
	Eric Dumazet <edumaset@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 15, 2024 at 5:12=E2=80=AFPM Daniel Jurgens <danielj@nvidia.com>=
 wrote:
>
> The rtnl_lock would stay locked if allocating promisc_allmulti failed.
>
> Fixes: ff7c7d9f5261 ("virtio_net: Remove command data from control_buf")
> Reported-by: Eric Dumazet <edumaset@google.com>
> Link: https://lore.kernel.org/netdev/CANn89iLazVaUCvhPm6RPJJ0owra_oFnx7Fh=
c8d60gV-65ad3WQ@mail.gmail.com/
> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
> ---
>  drivers/net/virtio_net.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 19a9b50646c7..e2b7488f375e 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -2902,14 +2902,14 @@ static void virtnet_rx_mode_work(struct work_stru=
ct *work)
>         if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_CTRL_RX))
>                 return;
>
> -       rtnl_lock();
> -
>         promisc_allmulti =3D kzalloc(sizeof(*promisc_allmulti), GFP_ATOMI=
C);

While we are at this, please change GFP_ATOMIC to GFP_KERNEL here.

>         if (!promisc_allmulti) {
>                 dev_warn(&dev->dev, "Failed to set RX mode, no memory.\n"=
);
>                 return;
>         }
>
> +       rtnl_lock();
> +
>         *promisc_allmulti =3D !!(dev->flags & IFF_PROMISC);
>         sg_init_one(sg, promisc_allmulti, sizeof(*promisc_allmulti));
>
> --
> 2.45.0
>

