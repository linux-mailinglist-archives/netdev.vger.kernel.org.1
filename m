Return-Path: <netdev+bounces-117848-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E71294F8C0
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 23:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07BAD1F21E68
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 21:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D3116DEA9;
	Mon, 12 Aug 2024 21:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gYpDFOyF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A671581EB;
	Mon, 12 Aug 2024 21:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723496904; cv=none; b=h/lMS2Tlq+3cJTcHIQ6JPzn7VciY/CGMp+exr89kRoWlzbHjip/mNpKK07DGSjkNV3O6WHn+OwfVMBRFX48/171l3u8Q3rm+5DxUKmsFIKtTPkKi/tD7rWt0EjYIKDMrCycSNLtnmlOm9OkavE+8A2Ks7hX3CQXuUZBVu52Jhck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723496904; c=relaxed/simple;
	bh=TTMb9LEyN7g/Xv9eOcfbpWjri5fcu4h/8eQvO7ZyqH8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ssqAP2yLo8tilEHoQNjrqwNIalYKOK44kgX460b9jSp5LLtwr7MczrbIgqcV6807KGONB+wcCD35/2LzatwMgJorL+CF4q01O/Zqe/PMDfBNWrmnbq6iIet1HQPHy/BkvQHizChHrTrj8OOfpiyAoZOlMlnhkrfxYGIiRTv6pPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gYpDFOyF; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-69df49d92b8so34476947b3.3;
        Mon, 12 Aug 2024 14:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723496902; x=1724101702; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ozHPNPADeOeDy1v2q5lPuwLxMRVupqF4qM3cF1jX79Q=;
        b=gYpDFOyFyFfXgsOAUKnLDgJ4Ju3YzV86qSYg5R291eB7cfv4jcdN0FtLynlq4gGuSI
         YsaSAaGCACpkTxSeQq6n5JoRqwCgncQ4uYXXQ5Jo6YvRRtugIGg8lNFbWnhLRzDFGK+W
         OKE3V68uEryt7sTHTZoPikwHnGAObMqbErrVzWDThE//15GjMfo/UJ6QnZ/phsa1VrRx
         ry9wBaULuPJcdMUvh9jygakY4lyH1iH5nVCT1YLByYQoNH2Paezk57/XByPnYnIvMeW6
         YuEI8WeM3dlz/WF3DUJ03ho8J3fEwOPXOF6YlOjOzw92hNUDXkYz8rgZC6zqvl8xWKoh
         gGDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723496902; x=1724101702;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ozHPNPADeOeDy1v2q5lPuwLxMRVupqF4qM3cF1jX79Q=;
        b=VwT6Q4WhHzfLmWEGX/NgizppNNkCM2552RI8MKUvPBkgEtgS7503UGsjEi/SKn7MZN
         Y2RYoTcUalOL0CsgddtniN54r4a/kQc4vejKtQWv22t9wvRJAbt3JOmdU86zK+nWr0Zd
         58xCl3U65ZPgb0mpSsqcVa4rpcOmyuPOm631fHVVaP7pPIsGqY93ITrAmTRxsDus229e
         GtaHAqla02LvZdzSWCBrmcNstNOYuXJuwL3rkvsQ6SZsrvzBYg5r/i1lcAN8CijBwprZ
         1B3A6vZ2QM0ob8iI825irbhrWTJXAMndICibIfz+BorfAv0CogiaUt3n7iBQF/lB/I6Z
         8Xdg==
X-Forwarded-Encrypted: i=1; AJvYcCX/jNFiyB+/uihOG2/ft3qGMWAIy2vdnodrrk8DYlc1jZImXldHFvYMZYSgwZjews7H3Mpk9auHQFvs1lvRQ/lLDADreWxJawUKx3Ca
X-Gm-Message-State: AOJu0YxnUM4CGxQaMIPTRKjs3A7LiAVLWMqOy95ht3I9L/rNvXSKGrIa
	WN3YOwJG+LB31UaeBdgjuWvenTn4cSsa2nzKrYOBq1ZeM8xdj5u9E1O6G99WQ7d2YcPM87AiLpt
	PP1TnXLdMfvJewFZc66McfPzAJMbHZTLn
X-Google-Smtp-Source: AGHT+IFn+cJikIJ4Nrk1LCrt6QexENyZbb3TKxFyeGJ+ELoZ+Uj9Kz1ZQ+YePorKSgiydhpbKplkuGKb3GRuT7OCF4M=
X-Received: by 2002:a05:690c:4291:b0:643:93dc:731c with SMTP id
 00721157ae682-6a971eb6dbbmr18657337b3.17.1723496902023; Mon, 12 Aug 2024
 14:08:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812190700.14270-1-rosenp@gmail.com> <20240812190700.14270-2-rosenp@gmail.com>
In-Reply-To: <20240812190700.14270-2-rosenp@gmail.com>
From: Rosen Penev <rosenp@gmail.com>
Date: Mon, 12 Aug 2024 14:08:11 -0700
Message-ID: <CAKxU2N_nk_H9bHnofqYquSzVfQboayM3ELbPZy4=C=RNvM7Kkg@mail.gmail.com>
Subject: Re: [PATCH net-next 1/3] net: ag71xx: use devm_clk_get_enabled
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, linux@armlinux.org.uk, linux-kernel@vger.kernel.org, 
	o.rempel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2024 at 12:07=E2=80=AFPM Rosen Penev <rosenp@gmail.com> wro=
te:
>
> Allows removal of clk_prepare_enable to simplify the code slightly.
>
> Tested on a TP-LINK Archer C7v2.
>
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/net/ethernet/atheros/ag71xx.c | 31 ++++++---------------------
>  1 file changed, 7 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/net/ethernet/atheros/ag71xx.c b/drivers/net/ethernet=
/atheros/ag71xx.c
> index 6fc4996c8131..c22ebd3c1f46 100644
> --- a/drivers/net/ethernet/atheros/ag71xx.c
> +++ b/drivers/net/ethernet/atheros/ag71xx.c
> @@ -691,7 +691,7 @@ static int ag71xx_mdio_probe(struct ag71xx *ag)
>         np =3D dev->of_node;
>         ag->mii_bus =3D NULL;
>
> -       ag->clk_mdio =3D devm_clk_get(dev, "mdio");
> +       ag->clk_mdio =3D devm_clk_get_enabled(dev, "mdio");
I forgot to remove the following section. Will do this in v2. I'll
send tomorrow as rules seem to be no new patches for 24 hours.
>         if (IS_ERR(ag->clk_mdio)) {
>                 netif_err(ag, probe, ndev, "Failed to get mdio clk.\n");
>                 return PTR_ERR(ag->clk_mdio);
> @@ -704,16 +704,13 @@ static int ag71xx_mdio_probe(struct ag71xx *ag)
>         }
>
>         mii_bus =3D devm_mdiobus_alloc(dev);
> -       if (!mii_bus) {
> -               err =3D -ENOMEM;
> -               goto mdio_err_put_clk;
> -       }
> +       if (!mii_bus)
> +               return -ENOMEM;
>
>         ag->mdio_reset =3D of_reset_control_get_exclusive(np, "mdio");
>         if (IS_ERR(ag->mdio_reset)) {
>                 netif_err(ag, probe, ndev, "Failed to get reset mdio.\n")=
;
> -               err =3D PTR_ERR(ag->mdio_reset);
> -               goto mdio_err_put_clk;
> +               return PTR_ERR(ag->mdio_reset);
>         }
>
>         mii_bus->name =3D "ag71xx_mdio";
> @@ -735,22 +732,17 @@ static int ag71xx_mdio_probe(struct ag71xx *ag)
>         err =3D of_mdiobus_register(mii_bus, mnp);
>         of_node_put(mnp);
>         if (err)
> -               goto mdio_err_put_clk;
> +               return err;
>
>         ag->mii_bus =3D mii_bus;
>
>         return 0;
> -
> -mdio_err_put_clk:
> -       clk_disable_unprepare(ag->clk_mdio);
> -       return err;
>  }
>
>  static void ag71xx_mdio_remove(struct ag71xx *ag)
>  {
>         if (ag->mii_bus)
>                 mdiobus_unregister(ag->mii_bus);
> -       clk_disable_unprepare(ag->clk_mdio);
>  }
>
>  static void ag71xx_hw_stop(struct ag71xx *ag)
> @@ -1845,7 +1837,7 @@ static int ag71xx_probe(struct platform_device *pde=
v)
>                 return -EINVAL;
>         }
>
> -       ag->clk_eth =3D devm_clk_get(&pdev->dev, "eth");
> +       ag->clk_eth =3D devm_clk_get_enabled(&pdev->dev, "eth");
>         if (IS_ERR(ag->clk_eth)) {
>                 netif_err(ag, probe, ndev, "Failed to get eth clk.\n");
>                 return PTR_ERR(ag->clk_eth);
> @@ -1925,19 +1917,13 @@ static int ag71xx_probe(struct platform_device *p=
dev)
>         netif_napi_add_weight(ndev, &ag->napi, ag71xx_poll,
>                               AG71XX_NAPI_WEIGHT);
>
> -       err =3D clk_prepare_enable(ag->clk_eth);
> -       if (err) {
> -               netif_err(ag, probe, ndev, "Failed to enable eth clk.\n")=
;
> -               return err;
> -       }
> -
>         ag71xx_wr(ag, AG71XX_REG_MAC_CFG1, 0);
>
>         ag71xx_hw_init(ag);
>
>         err =3D ag71xx_mdio_probe(ag);
>         if (err)
> -               goto err_put_clk;
> +               return err;
>
>         platform_set_drvdata(pdev, ndev);
>
> @@ -1962,8 +1948,6 @@ static int ag71xx_probe(struct platform_device *pde=
v)
>
>  err_mdio_remove:
>         ag71xx_mdio_remove(ag);
> -err_put_clk:
> -       clk_disable_unprepare(ag->clk_eth);
>         return err;
>  }
>
> @@ -1978,7 +1962,6 @@ static void ag71xx_remove(struct platform_device *p=
dev)
>         ag =3D netdev_priv(ndev);
>         unregister_netdev(ndev);
>         ag71xx_mdio_remove(ag);
> -       clk_disable_unprepare(ag->clk_eth);
>         platform_set_drvdata(pdev, NULL);
>  }
>
> --
> 2.46.0
>

