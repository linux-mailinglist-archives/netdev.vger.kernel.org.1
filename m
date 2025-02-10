Return-Path: <netdev+bounces-164672-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31477A2EA78
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 12:04:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 634271883313
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 11:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7036E1E04AE;
	Mon, 10 Feb 2025 11:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="N73WP17z"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958ED1CAA89;
	Mon, 10 Feb 2025 11:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739185332; cv=none; b=DwCzEWRb3Rw7V8nvLnY61jlXSqGBSTdGirvIRViqDSPE2wAlt1o3ldJh1p28TqQYzdkxncY92ZvhgBRbMSN5R+RtncIGWB6RuV0n8nxYQvqFJ+Ve/x2/SOYKxKdvm6toAxi75kPbXd0x5m1b2pEDjOqHHdRDaK0x44rY7GyZwsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739185332; c=relaxed/simple;
	bh=cPwVpEPDZTLSJTVR83ceQc5S9hkJaly2lPhwNgX0AxI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AEghwELSlMJG5OlxT1+LsI6vDvH0GcwffdZ8R2ZcLB+qxFpok+RyUCQ8SiRe86o+fs1da2+GjUnGXu9P4wUCFU7R5mg1PPjrHHIs/vVcPnPSnm3aS+IGQDF2doNi6WWxSrNoIpc/P3B+sG0qV+aD+488zlZvDdm8StVD1FRJqPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=N73WP17z; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0E7C643158;
	Mon, 10 Feb 2025 11:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1739185326;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gmrlu3nc02d+jWxj8+i6q0M+l8i8yQBkmFLjW9PKKPQ=;
	b=N73WP17z6Ic2ftM721SqQ5LZBUU2XcrnIDnXt45t7Qsp64VKrWg5vBZdI/F7GnGLZaZgmy
	zePYcj8MDBlTyj9rSSTq9T/dbWeNFZ8HtdZnAHFA7OKAh9lFWDtdO7EoYdRXk/r5sPHcEN
	nIWeKshIl1699eaP//L+A8w9+XJBwQftxS9VpUCYtM6vRZTzxke6VsgyhU5iNaIFL16pkQ
	tvhMOBf8jNpYxUlNnMXltyOOk5X3l2zpBT+Amhm9Gyk0QtXNi2Lad2wfqQu+RHsDoXTbv1
	15Zf21A1IPMf5vptTCTxiN1Z+J7OOpQynMvh7/qvev4nJ570AswZ7z2LZ2PIew==
From: Romain Gantois <romain.gantois@bootlin.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen Wang <unicorn_wang@outlook.com>,
 Inochi Amaoto <inochiama@outlook.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Jisheng Zhang <jszhang@kernel.org>,
 "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>,
 =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>,
 Simon Horman <horms@kernel.org>, Furong Xu <0x1207@gmail.com>,
 Serge Semin <fancer.lancer@gmail.com>, Lothar Rubusch <l.rubusch@gmail.com>,
 Suraj Jaiswal <quic_jsuraj@quicinc.com>,
 Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 Giuseppe Cavallaro <peppe.cavallaro@st.com>,
 Jose Abreu <joabreu@synopsys.com>, Inochi Amaoto <inochiama@gmail.com>
Cc: Inochi Amaoto <inochiama@gmail.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org,
 Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>
Subject:
 Re: [PATCH net-next v4 3/3] net: stmmac: Add glue layer for Sophgo SG2044 SoC
Date: Mon, 10 Feb 2025 12:01:56 +0100
Message-ID: <2379380.ElGaqSPkdT@fw-rgant>
In-Reply-To: <20250209013054.816580-4-inochiama@gmail.com>
References:
 <20250209013054.816580-1-inochiama@gmail.com>
 <20250209013054.816580-4-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4980893.GXAFRqVoOG";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefjeeklecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfgggtsehgtderredttdejnecuhfhrohhmpeftohhmrghinhcuifgrnhhtohhishcuoehrohhmrghinhdrghgrnhhtohhishessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhephfdvleekvefgieejtdduieehfeffjefhleegudeuhfelteduiedukedtieehlefgnecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehffidqrhhgrghnthdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhomhgrihhnrdhgrghnthhoihhssegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeefkedprhgtphhtthhopegrnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghhpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggsvghnihesr
 hgvughhrghtrdgtohhmpdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhiikhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohhnohhrodgutheskhgvrhhnvghlrdhorhhg
X-GND-Sasl: romain.gantois@bootlin.com

--nextPart4980893.GXAFRqVoOG
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Romain Gantois <romain.gantois@bootlin.com>
Date: Mon, 10 Feb 2025 12:01:56 +0100
Message-ID: <2379380.ElGaqSPkdT@fw-rgant>
In-Reply-To: <20250209013054.816580-4-inochiama@gmail.com>
MIME-Version: 1.0

Hello Inochi,

On dimanche 9 f=C3=A9vrier 2025 02:30:52 heure normale d=E2=80=99Europe cen=
trale Inochi=20
Amaoto wrote:
> Adds Sophgo dwmac driver support on the Sophgo SG2044 SoC.
=2E..
> --- /dev/null
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sophgo.c
> @@ -0,0 +1,105 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Sophgo DWMAC platform driver
> + *
> + * Copyright (C) 2024 Inochi Amaoto <inochiama@gmail.com>
> + */
> +
> +#include <linux/bits.h>

It doesn't look like this include is used, could you please remove it?

> +#include <linux/mod_devicetable.h>
> +#include <linux/phy.h>
> +#include <linux/platform_device.h>
> +
> +#include "stmmac_platform.h"
> +
> +struct sophgo_dwmac {
> +	struct device *dev;
> +	struct clk *clk_tx;
> +};
> +
> +static void sophgo_dwmac_fix_mac_speed(void *priv, unsigned int speed,
> unsigned int mode) +{
> +	struct sophgo_dwmac *dwmac =3D priv;
> +	long rate;
> +	int ret;
> +
> +	rate =3D rgmii_clock(speed);
> +	if (rate < 0) {
> +		dev_err(dwmac->dev, "invalid speed %u\n", speed);
> +		return;
> +	}
> +
> +	ret =3D clk_set_rate(dwmac->clk_tx, rate);
> +	if (ret)
> +		dev_err(dwmac->dev, "failed to set tx rate %lu: %pe\n",

nit: shouldn't this be "%ld"?

> +			rate, ERR_PTR(ret));
> +}
> +
> +static int sophgo_sg2044_dwmac_init(struct platform_device *pdev,
> +				    struct plat_stmmacenet_data *plat_dat,
> +				    struct stmmac_resources *stmmac_res)
> +{
> +	struct sophgo_dwmac *dwmac;
> +
> +	dwmac =3D devm_kzalloc(&pdev->dev, sizeof(*dwmac), GFP_KERNEL);
> +	if (!dwmac)
> +		return -ENOMEM;
> +
> +	dwmac->clk_tx =3D devm_clk_get_enabled(&pdev->dev, "tx");
> +	if (IS_ERR(dwmac->clk_tx))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(dwmac->clk_tx),
> +				     "failed to get tx clock\n");
> +
> +	dwmac->dev =3D &pdev->dev;
> +	plat_dat->bsp_priv =3D dwmac;
> +	plat_dat->flags |=3D STMMAC_FLAG_SPH_DISABLE;
> +	plat_dat->fix_mac_speed =3D sophgo_dwmac_fix_mac_speed;
> +	plat_dat->multicast_filter_bins =3D 0;
> +	plat_dat->unicast_filter_entries =3D 1;
> +
> +	return 0;
> +}
> +
> +static int sophgo_dwmac_probe(struct platform_device *pdev)
> +{
> +	struct plat_stmmacenet_data *plat_dat;
> +	struct stmmac_resources stmmac_res;

nit: I think adding "struct device *dev =3D &pdev->dev;" here would
be better than repeating "&pdev->dev" later on.

> +	int ret;
> +
> +	ret =3D stmmac_get_platform_resources(pdev, &stmmac_res);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret,
> +				     "failed to get resources\n");

This error message is a bit too vague, maybe replace it with "failed to get=
=20
platform resources"?

> +
> +	plat_dat =3D devm_stmmac_probe_config_dt(pdev, stmmac_res.mac);
> +	if (IS_ERR(plat_dat))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(plat_dat),
> +				     "dt configuration failed\n");

This error message is a bit misleading IMO, I would replace it with
something like "failed to parse device-tree parameters".

> +
> +	ret =3D sophgo_sg2044_dwmac_init(pdev, plat_dat, &stmmac_res);
> +	if (ret)
> +		return ret;
> +
> +	return stmmac_dvr_probe(&pdev->dev, plat_dat, &stmmac_res);
> +}
> +
> +static const struct of_device_id sophgo_dwmac_match[] =3D {
> +	{ .compatible =3D "sophgo,sg2044-dwmac" },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, sophgo_dwmac_match);
> +
> +static struct platform_driver sophgo_dwmac_driver =3D {
> +	.probe  =3D sophgo_dwmac_probe,
> +	.remove =3D stmmac_pltfr_remove,
> +	.driver =3D {
> +		.name =3D "sophgo-dwmac",
> +		.pm =3D &stmmac_pltfr_pm_ops,
> +		.of_match_table =3D sophgo_dwmac_match,
> +	},
> +};
> +module_platform_driver(sophgo_dwmac_driver);
> +
> +MODULE_AUTHOR("Inochi Amaoto <inochiama@gmail.com>");
> +MODULE_DESCRIPTION("Sophgo DWMAC platform driver");
> +MODULE_LICENSE("GPL");

Thanks,

=2D-=20
Romain Gantois, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--nextPart4980893.GXAFRqVoOG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEYFZBShRwOvLlRRy+3R9U/FLj284FAmep3KQACgkQ3R9U/FLj
284HFg/+MKQUhhxOK5sTw8hghie4GbpkSvYhWBC7tuehA03Yc5WCIwmWrOG5wf1+
xz9SLOp7IGs6gDtwXnC57LgTzaRuXEXtc1ZiWgjsnj/xnFGcNV5WGGtCGiRApP+L
D3zxA/D+F7dTaFeGxmxk8T0aEd1sMHER4StQbPMxw3troHOBnVbNxbwXAgsxyTug
8JcGrzp9i5q6Mdir9hfPywTwObPLzEormthGiAF/qo9GkB2X1nM7Fo6gk3laKCk6
ukzNymMUp/XTAE3xRzpNG3qSH8G08YF7b5HqXXVXb7iV1EMnW63bP9t9XK32mS8z
J04i/CHgFF1CTepv7/a0ZqQlvq5JhgPVUDnS/NFEnZ0Wb1k6g2+jlt02Hgl7lLUQ
iCVbL3aFWaSuo9LL8EQfuQaqZS60v0a5ZIyZq1AtMh0KKT5xnIdmBA54bpIWq57y
LvxHSHTNASAJgS8uBeJSH1s/2MrBU85LAFLjy07nvYEpk0dtN3Uoa9Vtxm2C3iet
g4EFwNy7Uq9ok1c0GPX3cWhW6dQ+L77Hz/5m1jHhU4vnDCsrDjv/14b4mJ6CqvfF
8NL56IidEjAVzBx18wh0rZMkZzZtoylqMa7rcPS7Nmt4l4WVK86wDA4DJAAG5CXU
TXHuFqKW1rDwokkhRUYgHPBLuiYbjWTFQhGYA+weLW/8n4AecbE=
=7ZQB
-----END PGP SIGNATURE-----

--nextPart4980893.GXAFRqVoOG--




