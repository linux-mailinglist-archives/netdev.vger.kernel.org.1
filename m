Return-Path: <netdev+bounces-114204-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98DB294155A
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 17:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2A531C2332A
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 15:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3981A38D1;
	Tue, 30 Jul 2024 15:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dfSvVS7/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27231A38CE;
	Tue, 30 Jul 2024 15:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722352776; cv=none; b=fPCDLJqO3sHibvZ6e6uYBTnQrMEz1gzdWwu3aaHjxELN7P4IlAjpnzdefOv5DonNUIZjCNRhxt41rKcTSaBa5Nrj6CxGn2a1UQDXwMfELs5+lR/PaafxY1eDiSAUKB1eClFeHXfbsejTMRjVp68tvBpwFBR2/02kD9SRAaGuHnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722352776; c=relaxed/simple;
	bh=HQyeNatBMcZUiljeFYyRppT2tTjxGc2zpD8FbNK5N5I=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=sBc0Gw4hIyDX5OuqkBejFxNNx2/nbnHjD4IWEqiJH7kggM3nJYvZpAFcjNI1MntMvwRUNgOfAoPCAgl6h0cfGIYxu9OeCfq1aavEsA6HrjzDFz9wofbm/aldEcWPjaM9+39SEpCLKRNf6puGdlskifQx2cQ8gX9P7gocS+phTVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dfSvVS7/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD582C32782;
	Tue, 30 Jul 2024 15:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722352776;
	bh=HQyeNatBMcZUiljeFYyRppT2tTjxGc2zpD8FbNK5N5I=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=dfSvVS7/d8KPZPKUkfVhR1IPwbfw2H/bM4HKjfeI4pFExH9EyeitXFLhMJI5LVV7n
	 Naf9ekfBgSReMsRCoE+OSbtCMwGQVbDrH1xuPqo8UNQWK7DuWsRyJQuRIUhc0337YS
	 BOCe0gGaaTMrDTSv5rBJJxhP/lyex1GrCjOxj3P9VwQce0exE8aNijpr63cFLNHzhn
	 LN/6XQepQLusNJ+ue1byLNOHiCv6XMqiutiyclTsx6SOYoBHwdzR/QeNYaz1GxTKhF
	 l8LGPWMAocdB5V+QJzhDXGVAnhSJnuxBLaTJDk8dTQBUnOdsdIxFtDLurK8OkRrmND
	 KuoyZ4O52oQcw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240729150315.65798-1-brgl@bgdev.pl>
References: <20240729150315.65798-1-brgl@bgdev.pl>
Subject: Re: [PATCH net v2] net: phy: aquantia: only poll GLOBAL_CFG regs on aqr113, aqr113c and aqr115c
From: Antoine Tenart <atenart@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Jon Hunter <jonathanh@nvidia.com>
To: Andrew Lunn <andrew@lunn.ch>, Bartosz Golaszewski <brgl@bgdev.pl>, David S . Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Heiner Kallweit <hkallweit1@gmail.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>
Date: Tue, 30 Jul 2024 17:19:32 +0200
Message-ID: <172235277231.5002.4869673206653529793@kwain.local>

Quoting Bartosz Golaszewski (2024-07-29 17:03:14)
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>=20
> Commit 708405f3e56e ("net: phy: aquantia: wait for the GLOBAL_CFG to
> start returning real values") introduced a workaround for an issue
> observed on aqr115c. However there were never any reports of it
> happening on other models and the workaround has been reported to cause
> and issue on aqr113c (and it may cause the same on any other model not
> supporting 10M mode).
>=20
> Let's limit the impact of the workaround to aqr113, aqr113c and aqr115c
> and poll the 100M GLOBAL_CFG register instead as both models are known
> to support it correctly.
>=20
> Reported-by: Jon Hunter <jonathanh@nvidia.com>
> Closes: https://lore.kernel.org/lkml/7c0140be-4325-4005-9068-7e0fc5ff344d=
@nvidia.com/
> Fixes: 708405f3e56e ("net: phy: aquantia: wait for the GLOBAL_CFG to star=
t returning real values")
> Tested-by: Jon Hunter <jonathanh@nvidia.com>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Reviewed-by: Antoine Tenart <atenart@kernel.org>

Thanks!

> ---
> v1 -> v2:
> - update the commit message to mention aqr113 too
> - fix the comment in the source file: 10M -> 100M
>=20
>  drivers/net/phy/aquantia/aquantia_main.c | 29 +++++++++++++++++-------
>  1 file changed, 21 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/phy/a=
quantia/aquantia_main.c
> index d12e35374231..e982e9ce44a5 100644
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
> +        * continue on returning zeroes for some time. Let's poll the 100M
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

