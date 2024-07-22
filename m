Return-Path: <netdev+bounces-112379-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B58D0938BAE
	for <lists+netdev@lfdr.de>; Mon, 22 Jul 2024 11:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7DF11C211EF
	for <lists+netdev@lfdr.de>; Mon, 22 Jul 2024 09:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F3118AE4;
	Mon, 22 Jul 2024 09:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VqI5usS6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC509523A;
	Mon, 22 Jul 2024 09:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721638835; cv=none; b=Jn+aHlxsVXtoQpvvZe/e5lWvtUX6nc7m60E76rBITyfwgODRxHjLjgjuKS+l9vA0RFOG+I3V3fovzQVCbIpa77PCceYDbBpH45AfyqcCwCk5QMcPCUVtkKgzZBdc/oNfSkZLX7N9Vzjo9I/707KythWQEM+iILIDJXbnLu25j00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721638835; c=relaxed/simple;
	bh=e0cxkfUfv3pilNjZXjP1tP2K/9ZSiMjDQ9EsFQlgV7c=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=CcVm5FCl+nq6q0f4zthRLSItdJVFHQgQ4T9m2i2YGHoYGxh/M5uU26lkkGO5uO/0s3zlqQ7eqETXpaD6WdpmatKPTNR0OlLNUp1JMOALlpyQZDKhGvkcG1ojPy2UCERqB6IEBJ2qJciAbFbPjM//J+bH1RXtfSm7W3GMISOsAdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VqI5usS6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9FF6C32782;
	Mon, 22 Jul 2024 09:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721638835;
	bh=e0cxkfUfv3pilNjZXjP1tP2K/9ZSiMjDQ9EsFQlgV7c=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=VqI5usS676WzWHELnlHyAqGgI4xGLSESNRM4pZGFwzdB51kgDBJlWA+T+E5YcOJa4
	 GxZF7ZEEecY32uPrxRdlFj3YDvO5UEJ2jj8xqAIhq6XJ2b1+FRK1ZFW4NXlgpepSqE
	 sNlMBzcKmAwiF8+Nr7Vg0WVk/pWsvC7tSVryucRX2Tg0/nHNfimHMhNLnwgeM/TBge
	 9ULXvGpS9hrwikycgW3P89YR3GeiKUWhrZIbizMVE+Q3dQw2hAFZjNI4Dbiwpv/vsZ
	 z2Qahpi3K/H0BznZ6EYeLcFUAqL9G1l0w8ExV1eNIeeMz/GknPsX6EC3iNij5TfY2a
	 9WEyRud/xwZEA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240718145747.131318-1-brgl@bgdev.pl>
References: <20240718145747.131318-1-brgl@bgdev.pl>
Subject: Re: [RFT PATCH net] net: phy: aquantia: only poll GLOBAL_CFG registers on aqr113c and aqr115c
From: Antoine Tenart <atenart@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Jon Hunter <jonathanh@nvidia.com>
To: Andrew Lunn <andrew@lunn.ch>, Bartosz Golaszewski <brgl@bgdev.pl>, David S . Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Heiner Kallweit <hkallweit1@gmail.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>
Date: Mon, 22 Jul 2024 11:00:31 +0200
Message-ID: <172163883154.3798.5139161262655916040@kwain.local>

Quoting Bartosz Golaszewski (2024-07-18 16:57:47)
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>=20
> Commit 708405f3e56e ("net: phy: aquantia: wait for the GLOBAL_CFG to
> start returning real values") introduced a workaround for an issue
> observed on aqr115c. However there were never any reports of it
> happening on other models and the workaround has been reported to cause
> and issue on aqr113c (and it may cause the same on any other model not
> supporting 10M mode).
>=20
> Let's limit the impact of the workaround to aqr113c and aqr115c and poll
> the 100M GLOBAL_CFG register instead as both models are known to support
> it correctly.
>=20
> Reported-by: Jon Hunter <jonathanh@nvidia.com>
> Closes: https://lore.kernel.org/lkml/7c0140be-4325-4005-9068-7e0fc5ff344d=
@nvidia.com/
> Fixes: 708405f3e56e ("net: phy: aquantia: wait for the GLOBAL_CFG to star=
t returning real values")
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  drivers/net/phy/aquantia/aquantia_main.c | 29 +++++++++++++++++-------
>  1 file changed, 21 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/phy/a=
quantia/aquantia_main.c
> index d12e35374231..6e3e0fc6ea27 100644
> --- a/drivers/net/phy/aquantia/aquantia_main.c
> +++ b/drivers/net/phy/aquantia/aquantia_main.c
> @@ -653,13 +653,7 @@ static int aqr107_fill_interface_modes(struct phy_de=
vice *phydev)
>         unsigned long *possible =3D phydev->possible_interfaces;
>         unsigned int serdes_mode, rate_adapt;
>         phy_interface_t interface;
> -       int i, val, ret;
> -
> -       ret =3D phy_read_mmd_poll_timeout(phydev, MDIO_MMD_VEND1,
> -                                       VEND1_GLOBAL_CFG_10M, val, val !=
=3D 0,
> -                                       1000, 100000, false);
> -       if (ret)
> -               return ret;
> +       int i, val;
> =20
>         /* Walk the media-speed configuration registers to determine which
>          * host-side serdes modes may be used by the PHY depending on the
> @@ -708,6 +702,25 @@ static int aqr107_fill_interface_modes(struct phy_de=
vice *phydev)
>         return 0;
>  }
> =20
> +static int aqr113c_fill_interface_modes(struct phy_device *phydev)
> +{
> +       int val, ret;
> +
> +       /* It's been observed on some models that - when coming out of su=
spend
> +        * - the FW signals that the PHY is ready but the GLOBAL_CFG regi=
sters
> +        * continue on returning zeroes for some time. Let's poll the 10M

nit: 100M?

> +        * register until it returns a real value as both 113c and 115c s=
upport
> +        * this mode.
> +        */
> +       ret =3D phy_read_mmd_poll_timeout(phydev, MDIO_MMD_VEND1,
> +                                       VEND1_GLOBAL_CFG_100M, val, val !=
=3D 0,
> +                                       1000, 100000, false);
> +       if (ret)
> +               return ret;
> +
> +       return aqr107_fill_interface_modes(phydev);
> +}
> +
>  static int aqr113c_config_init(struct phy_device *phydev)
>  {
>         int ret;
> @@ -725,7 +738,7 @@ static int aqr113c_config_init(struct phy_device *phy=
dev)
>         if (ret)
>                 return ret;
> =20
> -       return aqr107_fill_interface_modes(phydev);
> +       return aqr113c_fill_interface_modes(phydev);
>  }
> =20
>  static int aqr107_probe(struct phy_device *phydev)
> --=20
> 2.43.0
>=20
>

