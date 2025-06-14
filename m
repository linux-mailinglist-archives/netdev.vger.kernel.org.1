Return-Path: <netdev+bounces-197717-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 185FBAD9B0E
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 09:49:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6AB817EB4E
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 07:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 915D01DE2D8;
	Sat, 14 Jun 2025 07:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QXdUj6+i"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6672E17D7;
	Sat, 14 Jun 2025 07:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749887344; cv=none; b=Jz1+AXT2feIPOPgnMaVhl6RGalNDFnSQ6vzfy2UAjmORP+s9FAhn6HjMTFKNBZOR9/36qogq9F+WKzc2FJfp0j3iVGfPM60wXsX4aJwciPAfoRuDy7QMhP14I/dHYgoY9lzOCaLbS19NPFnfaIkZGz7EV1GkRvMRl1Gx7aadsB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749887344; c=relaxed/simple;
	bh=hK2ZgYosNGPjzPukbx6c+1KX8W5yyH+XoQKnOeQo9Do=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rOfl3qhit7T5N4pSA6wG/eV5OECl7uIFreYJ8+Hv0rzVOE5Wcf01O+ev3RcnX3kXqfmzSNidETtAQJ1qP0vGoL/rL5FMKPQmdy4EPLXQzfPPaf29+sCgJcERtvxP+b/LeXI7euYsdoPVngBu2QzM4z+6rhKNuwhxj8oG/ZAnx34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QXdUj6+i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13C05C4CEEB;
	Sat, 14 Jun 2025 07:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749887343;
	bh=hK2ZgYosNGPjzPukbx6c+1KX8W5yyH+XoQKnOeQo9Do=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QXdUj6+i9UKbIc+5lo/ULhNd6+o7TktQg34mJ3+Rx9WAN54m5sw1CIrOrsdip3Abs
	 eraOgjOZWna7CSn3lVQ2Pwe0+b6exjMDjsYCwnNcpGQcarWJJ2rZP0L4uCdbQTaLZ8
	 kFT/ZluD9iYBxSvWxKFe8s3m8UxeodalazPX4yDd1UoR3wMoJgrZlZ+0o9fqfjsjFr
	 udtFFunuoaGDzrYCEq6xNa4sGCI4zYqfxu9R/Luax37/6f51jxQdHnJW62d6gDQRsq
	 0fG8KoSz1HcUk3o9FpuBi1m9Y6PFXIY6kYnogtXQIrQG7eyCbwsA68rzI2ISme8TLF
	 NeLlNCm6A4kYw==
Date: Sat, 14 Jun 2025 09:48:58 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Frank Wunderlich <linux@fw-web.de>
Cc: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Frank Wunderlich <frank-w@public-files.de>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, daniel@makrotopia.org
Subject: Re: [net-next v1] net: ethernet: mtk_eth_soc: support named IRQs
Message-ID: <aE0pav5c8Ji1Q7br@lore-rh-laptop>
References: <20250613191813.61010-1-linux@fw-web.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BsiHWnyDui/cxXyo"
Content-Disposition: inline
In-Reply-To: <20250613191813.61010-1-linux@fw-web.de>


--BsiHWnyDui/cxXyo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Frank Wunderlich <frank-w@public-files.de>
>=20
> Add named interrupts and keep index based fallback for exiting devicetree=
s.
>=20
> Currently only rx and tx IRQs are defined to be used with mt7988, but
> later extended with RSS/LRO support.
>=20
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
>  drivers/net/ethernet/mediatek/mtk_eth_soc.c | 24 +++++++++++++--------
>  1 file changed, 15 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/et=
hernet/mediatek/mtk_eth_soc.c
> index b76d35069887..fcec5f95685e 100644
> --- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> +++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> @@ -5106,17 +5106,23 @@ static int mtk_probe(struct platform_device *pdev)
>  		}
>  	}
> =20
> -	for (i =3D 0; i < 3; i++) {
> -		if (MTK_HAS_CAPS(eth->soc->caps, MTK_SHARED_INT) && i > 0)
> -			eth->irq[i] =3D eth->irq[0];
> -		else
> -			eth->irq[i] =3D platform_get_irq(pdev, i);
> -		if (eth->irq[i] < 0) {
> -			dev_err(&pdev->dev, "no IRQ%d resource found\n", i);
> -			err =3D -ENXIO;
> -			goto err_wed_exit;
> +	eth->irq[1] =3D platform_get_irq_byname(pdev, "tx");
> +	eth->irq[2] =3D platform_get_irq_byname(pdev, "rx");

Hi Frank,

doing so you are not setting eth->irq[0] for MT7988 devices but it is actua=
lly
used in mtk_add_mac() even for non-MTK_SHARED_INT devices. I guess we can r=
educe
the eth->irq array size to 2 and start from 0 even for the MT7988 case.
What do you think?

Regards,
Lorenzo

> +	if (eth->irq[1] < 0 || eth->irq[2] < 0) {
> +		for (i =3D 0; i < 3; i++) {
> +			if (MTK_HAS_CAPS(eth->soc->caps, MTK_SHARED_INT) && i > 0)
> +				eth->irq[i] =3D eth->irq[0];
> +			else
> +				eth->irq[i] =3D platform_get_irq(pdev, i);
> +
> +			if (eth->irq[i] < 0) {
> +				dev_err(&pdev->dev, "no IRQ%d resource found\n", i);
> +				err =3D -ENXIO;
> +				goto err_wed_exit;
> +			}
>  		}
>  	}
> +
>  	for (i =3D 0; i < ARRAY_SIZE(eth->clks); i++) {
>  		eth->clks[i] =3D devm_clk_get(eth->dev,
>  					    mtk_clks_source_name[i]);
> --=20
> 2.43.0
>=20

--BsiHWnyDui/cxXyo
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaE0pZgAKCRA6cBh0uS2t
rEsYAQC/qq1Dy8AVNZxEa3E1iSwTgFoyhGkr9kvRgiXfnALDaAD/W5KJDTciKWY3
un1QrUhybLW5YPmxfQGgFZXWKUY1fw8=
=emYc
-----END PGP SIGNATURE-----

--BsiHWnyDui/cxXyo--

