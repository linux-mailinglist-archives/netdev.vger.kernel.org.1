Return-Path: <netdev+bounces-169625-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3631A44DB3
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 21:38:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A0C63B0BD1
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 20:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E99D20F096;
	Tue, 25 Feb 2025 20:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jpMPezwo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A339420F07A
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 20:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740515515; cv=none; b=JAn2/kC7j2i1A27PX2gklk2aRoE0zhG0rBxGF6+eUFR98mikLiT20UwmVsOQ2uHA5xqDyHuQEtanWyIVV3X135nzjI6ef3Cxe1phdnuGYsijav2z+nYCBT+oIfRJ7P21xhc32FVAmRw7cX7P2CNsOX8zw/MuhO1GfGnZUSop8os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740515515; c=relaxed/simple;
	bh=AnV9E20w8fH87HjCFEs/ikMWlCvzcwL2df9gCfjDD9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pnCNb4w2sA39V5wi2ZpR0B/XzyXAwYcPr+GQ/VY93Mnq4obmppUeX1TCcXrmBx3aHwPFIrGDci3+A8rvwcsyS8V5DMyV44P3/SwuDgh/pm486fAYd9MSQ8q8UExpo4/j1nM0o+7KdiHCUo/binlPC3SXssl7Lp+vLqCq9l+xeNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jpMPezwo; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-abbec6a0bfeso945913766b.2
        for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 12:31:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740515512; x=1741120312; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LqTyJfrpmh9OoHhGhSLNFtCY+nJglgvLIHJFw60aWtk=;
        b=jpMPezwomPG49cX1RotaE0R4FRUiH89SVkVltPc1ap/b5mycc0ZzNc7eQMjBFVNPas
         eOAYAJ+kA8wlTP80C5/SAKdc+x83yAJ/ZVftPvuygTdcBR7bTDnozc+Zk/n4CcPYEmkB
         jf9E3dyx/Ypf6v94ZMZb3DRBczVDmewZIVRMJDGXaVfWJ9bToMyxCJQ5uNQ9nGcscNzf
         dKK9AKX7wEZ3WViM+FuiQOz6wzbG/vlz+sCV1nwi3TkBRASx1r7+Tnfx43bRp4aXjDmX
         2hyNghANwZX99VIEb6QVzq4qbxSq/fVzsP8E2MprSbqZAYKszo58ye4E+1NTUURXcmji
         OiGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740515512; x=1741120312;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LqTyJfrpmh9OoHhGhSLNFtCY+nJglgvLIHJFw60aWtk=;
        b=HkRusPatIZUlnmBh4EJB6Pez8xZ9Is0C6vdVShjrqZ2No+axwWUDHbjxRDCUntcTMg
         i29SnUcrBDruagadW3BMf8zEGwGbWYfS+LDf+E1hQPX90+4gtSsam7BZmN8GrnI/B8Mq
         OB0TEUtUjohsJ2I3rpJphQ42SbEyINNGy5Hc6VbgfD07iJWXM2uQAg+oSJw+FGMVUrI3
         dmY5KMAdkjx78cQTlbnxl1niw2nREM5rIKVde7z9W4927jm1g5FK+v4BazB2hzx35Owf
         gWXkk94ycYDEYeOW0mFyveLtubMpDaEaNj2p9KQuwkV/XjGRlzD+Lxga3N5Qux3wkl3+
         1hjg==
X-Forwarded-Encrypted: i=1; AJvYcCWpnqct67D3zxpObDu9jXGGUUmvkWmB4KxNQsBJ/OTmE8xVxbqjYa3F0X1/tXILvWIDsjHXLFk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0CKSvXiwdXum2DLDItu8Q82keRLIZ5xQEmjdg42yYC+8fXSUk
	mY9lfZeK7/WcH7fSkUmIBZhKh0aV2PQtYNlRpbE+vIJzQ7uW8LiV
X-Gm-Gg: ASbGnctbyPqPRVE+29tkxwyasNV4MJc/hDZZI+PX/2CfQFCksWlkwF8bwAQBSt199cd
	TJ25+1nOZELi7xatjUI7ff/yICyBei+xFF/X0WKbRW7ajaEY2LSC1DT6OcyWwBQR2WochihN2Jr
	Qag7Qu6Kjghc0Mzd9igp7ddxCp+pCjR/w3Bkyb5PdPokJ0IRu3EBGe4mvZ3dN+KAZgxFzNpUu8y
	/XcLj2w8py0/xUYt0RL/HLFAzQWilHsAek3+SAJHbNE2Wpcgk9vB55G3hyGYVyPqKtPGSBInW7z
	8BEfY6zbEUSXq3MZi7wo8TbM3RjVfOssB6CluI2NIU9iS+QbNGSFZysxCL1UzWTY9JjbWcGLB9e
	ua4NwL6HmFqhx
X-Google-Smtp-Source: AGHT+IEJuXnWIMGDBSBMqOav7bVwcobNvyp7gvPMLJMccBBO8pTepVY+1CQtODf0snXMlUdT+6giVQ==
X-Received: by 2002:a17:907:72d1:b0:abb:e7de:f2a6 with SMTP id a640c23a62f3a-abc09e35401mr2167544866b.53.1740515511788;
        Tue, 25 Feb 2025 12:31:51 -0800 (PST)
Received: from orome (p200300e41f187700f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f18:7700:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed1cdc46bsm197935666b.20.2025.02.25.12.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 12:31:50 -0800 (PST)
Date: Tue, 25 Feb 2025 21:31:48 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Emil Renner Berthing <kernel@esmil.dk>, 
	Eric Dumazet <edumazet@google.com>, Fabio Estevam <festevam@gmail.com>, imx@lists.linux.dev, 
	Inochi Amaoto <inochiama@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	Jan Petrous <jan.petrous@oss.nxp.com>, Jon Hunter <jonathanh@nvidia.com>, 
	linux-arm-kernel@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Minda Chen <minda.chen@starfivetech.com>, netdev@vger.kernel.org, 
	NXP S32 Linux Team <s32@nxp.com>, Paolo Abeni <pabeni@redhat.com>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Shawn Guo <shawnguo@kernel.org>, Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH RFC net-next 5/7] net: stmmac: s32: use generic
 stmmac_set_clk_tx_rate()
Message-ID: <o5ww56n7e5sfck737uwasx7o4zlhog47abfvfptcegikyheegu@6gapje5hr56b>
References: <Z7RrnyER5ewy0f3T@shell.armlinux.org.uk>
 <E1tkLZ6-004RZO-0H@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="o3ccr5lq2mt5twat"
Content-Disposition: inline
In-Reply-To: <E1tkLZ6-004RZO-0H@rmk-PC.armlinux.org.uk>


--o3ccr5lq2mt5twat
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH RFC net-next 5/7] net: stmmac: s32: use generic
 stmmac_set_clk_tx_rate()
MIME-Version: 1.0

On Tue, Feb 18, 2025 at 11:15:00AM +0000, Russell King (Oracle) wrote:
> Use the generic stmmac_set_clk_tx_rate() to configure the MAC transmit
> clock.
>=20
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>  .../net/ethernet/stmicro/stmmac/dwmac-s32.c   | 22 +++----------------
>  1 file changed, 3 insertions(+), 19 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c b/drivers/ne=
t/ethernet/stmicro/stmmac/dwmac-s32.c
> index 6a498833b8ed..b76bfa41af82 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c
> @@ -100,24 +100,6 @@ static void s32_gmac_exit(struct platform_device *pd=
ev, void *priv)
>  	clk_disable_unprepare(gmac->rx_clk);
>  }
> =20
> -static void s32_fix_mac_speed(void *priv, int speed, unsigned int mode)
> -{
> -	struct s32_priv_data *gmac =3D priv;
> -	long tx_clk_rate;
> -	int ret;
> -
> -	tx_clk_rate =3D rgmii_clock(speed);
> -	if (tx_clk_rate < 0) {
> -		dev_err(gmac->dev, "Unsupported/Invalid speed: %d\n", speed);
> -		return;
> -	}
> -
> -	dev_dbg(gmac->dev, "Set tx clock to %ld Hz\n", tx_clk_rate);
> -	ret =3D clk_set_rate(gmac->tx_clk, tx_clk_rate);
> -	if (ret)
> -		dev_err(gmac->dev, "Can't set tx clock\n");
> -}
> -
>  static int s32_dwmac_probe(struct platform_device *pdev)
>  {
>  	struct plat_stmmacenet_data *plat;
> @@ -172,7 +154,9 @@ static int s32_dwmac_probe(struct platform_device *pd=
ev)
> =20
>  	plat->init =3D s32_gmac_init;
>  	plat->exit =3D s32_gmac_exit;
> -	plat->fix_mac_speed =3D s32_fix_mac_speed;
> +
> +	plat->clk_tx_i =3D dmac->tx_clk;

I noticed this while building, the "dmac" above should be "gmac".

Thierry

--o3ccr5lq2mt5twat
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAme+KLQACgkQ3SOs138+
s6G2dg//XEAP/SNRmlbm/Whtc1ed1XDDGWzN1eqPHb22h85AkhBzo3dyiGlai3KM
acTcFFS5ngfi1FO+bSmjLeGRcAiGJimDRpNSomDWy7XFwDaA8oWg4bkWSk29PGom
kWOv51f5QlkqJYvK5iYCr37vIThe9KQwQXurR7TbcMZjXggL/paw0o8fbU23+I5A
KF0Y2OLjg4OGfAISzc3SN7B4DKa1uomft05iVkSWcougkQH7N6wmfLTQwfMvXG11
yfIZYOPVd99SiSYR7CT6HLO4JCFDdVYQdJS58v61VvRgyOZlPEG9hCPNNHT+uTeF
Ld4SXrtSywR5WuoJC+B5tJwZ28HNAleCf/5iBxCmxj6AMfftiTaA9LR9K1Myhn9P
4WEXnvBIhw44yyVy6lVbARgSycNXbXey1zdzsCHoOC7vDyxRAsY6eZqcU0Gsaxhp
ARAEdhyVHL8C22q1FsgLUa7pvqavet9mLUz/tKBhM1s7ryQdeS9qzqx3D7VhEY5o
kVJ0ivva6sHgzLK5DkXKN/Tr34R4iBclkR2GAIK4KCFJbnJBMPMf3zeMAJA7v3rD
u8KwPspfNZnP2P1+D26kVX+6oBTXpLFjtKc4vHs3fZcMQ4SrATeeBPD7hOxZOOfL
n20+ZxoKnMcnqlukoxG157V1kl9eNk4ROaDJ8dljbEctRWfbUJU=
=QnMs
-----END PGP SIGNATURE-----

--o3ccr5lq2mt5twat--

