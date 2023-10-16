Return-Path: <netdev+bounces-41338-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77CB57CA986
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 15:33:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7A1FB20E9B
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 13:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD4727EEC;
	Mon, 16 Oct 2023 13:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fWcW/Fj6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81EC926E16
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 13:33:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0144FC433CA
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 13:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697463205;
	bh=53c0if5gtlyK/H3uqm3FGi3l9NCjxsvEiVZyLNyWIdg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fWcW/Fj6MrlDY45J0xOH9DfhVxK1NDcWLzj7BLeSwpQJUlLC1J/REOTL/sgmTp72A
	 2ynPZciFIoOD8tlwWq+jLPcC+bFEchLwZarAyf1WuW7OK9FJfI61KCBbrKG+LQBu5c
	 EGAxvSGaQsjrQxJVHcqgRRusXiiODRISejCOzZQqj/cf6yzGDWoLP02kcEvNZrodEi
	 VBaRaf5qhMkqJccvmzpOFnxJmFHGhmmPKDZns2lz2hjbehS0JO4Eg2Zfmuji1XUJ+R
	 tMcyPP0YJgCAGpCbsmFaJDyCX8fNOyF7zmZWBKt53BKIekys6aA2xW+DRn5ZHH/1BT
	 Yk6YVTBM0Br0g==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-507b18cf2e1so1076875e87.3
        for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 06:33:24 -0700 (PDT)
X-Gm-Message-State: AOJu0YxQHz7cmjz9hvMEBtbWT8SPb6g/tppoSaFAvY3nkHXe6hzA7ReY
	2HVP0bB3JB+O5uILKEFVFK3oDYqvIH48dXSVdQ==
X-Google-Smtp-Source: AGHT+IGOu53QmlzEtm1OexJcqnwAESHNz83QU3yBo51Qy3sxnciUsFcS7BrEJ6/IJfJcaMUPMnUcv/t2zLCHUWC602o=
X-Received: by 2002:a05:6512:3582:b0:500:99a9:bc40 with SMTP id
 m2-20020a056512358200b0050099a9bc40mr25423017lfr.69.1697463203207; Mon, 16
 Oct 2023 06:33:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231016122446.807703-1-alexander.stein@ew.tq-group.com>
In-Reply-To: <20231016122446.807703-1-alexander.stein@ew.tq-group.com>
From: Rob Herring <robh@kernel.org>
Date: Mon, 16 Oct 2023 08:33:10 -0500
X-Gmail-Original-Message-ID: <CAL_JsqL0v+a5rijNdEqD7A=DbLeWWSHA2vOmYMv4hVN6nL97fA@mail.gmail.com>
Message-ID: <CAL_JsqL0v+a5rijNdEqD7A=DbLeWWSHA2vOmYMv4hVN6nL97fA@mail.gmail.com>
Subject: Re: [PATCH 1/1] net: fec: Fix device_get_match_data usage
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, 
	Clark Wang <xiaoning.wang@nxp.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	NXP Linux Team <linux-imx@nxp.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 16, 2023 at 7:24=E2=80=AFAM Alexander Stein
<alexander.stein@ew.tq-group.com> wrote:
>
> device_get_match_data() returns an entry of fec_devtype, an array of
> struct platform_device_id. But the desired struct fec_devinfo information
> is stored in platform_device_id.driver_data. Thus directly storing
> device_get_match_data() result in dev_info is wrong.
> Instead, similar to before the change, update the pdev->id_entry if
> device_get_match_data() returned non-NULL.
>
> Fixes: b0377116decd ("net: ethernet: Use device_get_match_data()")
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
> Admittedly I am not a fan of adding a additional struct platform_device_i=
d
> pointer. But as long a this driver supports non-DT probes it can be non-N=
ULL.

Besides Coldfire, none of the non-DT platform id's are still needed.
I'm not sure we need an entry for Coldfire if it's the only one and
there is no driver data. Maybe for module autoloading? I don't
remember offhand.

Regardless, fec_dt_ids should be updated to use fec_foo_info structs
directly instead of the indirection with the platform_device_id
structs.

>  drivers/net/ethernet/freescale/fec_main.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethe=
rnet/freescale/fec_main.c
> index 5eb756871a963..dc7c3ef5ba9de 100644
> --- a/drivers/net/ethernet/freescale/fec_main.c
> +++ b/drivers/net/ethernet/freescale/fec_main.c
> @@ -4297,6 +4297,7 @@ fec_probe(struct platform_device *pdev)
>         char irq_name[8];
>         int irq_cnt;
>         const struct fec_devinfo *dev_info;
> +       const struct platform_device_id *plat_dev_id;
>
>         fec_enet_get_queue_num(pdev, &num_tx_qs, &num_rx_qs);
>
> @@ -4311,9 +4312,10 @@ fec_probe(struct platform_device *pdev)
>         /* setup board info structure */
>         fep =3D netdev_priv(ndev);
>
> -       dev_info =3D device_get_match_data(&pdev->dev);
> -       if (!dev_info)
> -               dev_info =3D (const struct fec_devinfo *)pdev->id_entry->=
driver_data;

I don't know why I kept this line. Probably because I originally used
of_device_get_match_data instead. It's redundant because
device_get_match_data() will do platform id matching too.

> +       plat_dev_id =3D device_get_match_data(&pdev->dev);
> +       if (plat_dev_id)
> +               pdev->id_entry =3D plat_dev_id;
> +       dev_info =3D (const struct fec_devinfo *)pdev->id_entry->driver_d=
ata;
>         if (dev_info)
>                 fep->quirks =3D dev_info->quirks;
>
> --
> 2.34.1
>

