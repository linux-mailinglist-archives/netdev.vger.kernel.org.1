Return-Path: <netdev+bounces-189032-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 598B2AAFF6D
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 17:44:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FC0F7A2672
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 15:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 620BB2797A0;
	Thu,  8 May 2025 15:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ebQTAwBC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A49279791;
	Thu,  8 May 2025 15:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746719036; cv=none; b=s4HbGnZmnvRZYY948JKMuyLKzsCRDEOLBYJtuguderdZWOW/OhrDfEPe4Eqrc7y2dNBUbsJTs7V6vC5qrBNpM5q8aRHygI29QKAqyAMK5ZfkAW8VMq+vH9N5aA0FzpVXn4PN9DnF6L88UKlNryEjNP6w81rqZyHXXNhtybWEEQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746719036; c=relaxed/simple;
	bh=T6p70PtHkjOvSfKheTE9RIe/1B7E/b+kxUGvqGGghc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=izxSEIEgehbUkZu1tJNKWh++aITU2t7W3f++a/vOZY4/5OLEaQvFXQN5PpkZmhNoIo9I33K1uyCuXWoBZI2metdXvqqHI5yvXKBfMpBQeLTwcWxPgQsgzhPZRndF0SHHnjYpjdR0RU5YPME1HxLUpjrDEOsHmRkCox07KTSP+h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ebQTAwBC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B382C4CEE7;
	Thu,  8 May 2025 15:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746719035;
	bh=T6p70PtHkjOvSfKheTE9RIe/1B7E/b+kxUGvqGGghc4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ebQTAwBCFZt7fGX2PkSuWO3qgF32hEtffzoI4TppSq3DEI8Minyy7ijI/389xE1E3
	 95j8+WBZ6awF0Md43Vfk/2gNY7LG/uCiueeLWmv5CC0jJDnM/NgHGSfz31D/W18UCq
	 pnwHxx29Gppo/eEutif8PGanh7fmJteJFplJd8tAKshf/L6pWK5SlV++TMdIAC1SXe
	 /YLakK8aREkwqjzmzAK2ACSB61xID0PTyFXBBw4C1K8jFeBqNm/WJTzHkcOYWrwbtA
	 oROnW51xBB/gKvv1GtqwhMSEZ4jYyeiqxR8bRsJvJJOhOgB8d0tNU+vyeKTem60MVs
	 0dsXxwOXAl1TQ==
Date: Thu, 8 May 2025 17:43:53 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2 4/4] net: airoha: Use dev_err_probe()
Message-ID: <aBzROQyQ_5oHmYr3@lore-desk>
References: <5c94b9b3850f7f29ed653e2205325620df28c3ff.1746715755.git.christophe.jaillet@wanadoo.fr>
 <1b67aa9ea0245325c3779d32dde46cdf5c232db9.1746715755.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cyhlDYaZG9bgrtv1"
Content-Disposition: inline
In-Reply-To: <1b67aa9ea0245325c3779d32dde46cdf5c232db9.1746715755.git.christophe.jaillet@wanadoo.fr>


--cyhlDYaZG9bgrtv1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On May 08, Christophe JAILLET wrote:
> Use dev_err_probe() to slightly simplify the code.
> It is less verbose, more informational and makes error logging more
> consistent in the probe.
>=20
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Changes in v2:
>   - New patch
>=20
> Compile tested only.
> ---
>  drivers/net/ethernet/airoha/airoha_eth.c | 21 +++++++++------------
>  1 file changed, 9 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ether=
net/airoha/airoha_eth.c
> index 2335aa59b06f..7404ee894467 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.c
> +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> @@ -2896,10 +2896,9 @@ static int airoha_probe(struct platform_device *pd=
ev)
>  	eth->dev =3D &pdev->dev;
> =20
>  	err =3D dma_set_mask_and_coherent(eth->dev, DMA_BIT_MASK(32));
> -	if (err) {
> -		dev_err(eth->dev, "failed configuring DMA mask\n");
> -		return err;
> -	}
> +	if (err)
> +		return dev_err_probe(eth->dev, err,
> +				     "failed configuring DMA mask\n");

Can dma_set_mask_and_coherent() return -EPROBE_DEFER? The other parts are f=
ine.

Regards,
Lorenzo

> =20
>  	eth->fe_regs =3D devm_platform_ioremap_resource_byname(pdev, "fe");
>  	if (IS_ERR(eth->fe_regs))
> @@ -2912,10 +2911,9 @@ static int airoha_probe(struct platform_device *pd=
ev)
>  	err =3D devm_reset_control_bulk_get_exclusive(eth->dev,
>  						    ARRAY_SIZE(eth->rsts),
>  						    eth->rsts);
> -	if (err) {
> -		dev_err(eth->dev, "failed to get bulk reset lines\n");
> -		return err;
> -	}
> +	if (err)
> +		return dev_err_probe(eth->dev, err,
> +				     "failed to get bulk reset lines\n");
> =20
>  	eth->xsi_rsts[0].id =3D "xsi-mac";
>  	eth->xsi_rsts[1].id =3D "hsi0-mac";
> @@ -2925,10 +2923,9 @@ static int airoha_probe(struct platform_device *pd=
ev)
>  	err =3D devm_reset_control_bulk_get_exclusive(eth->dev,
>  						    ARRAY_SIZE(eth->xsi_rsts),
>  						    eth->xsi_rsts);
> -	if (err) {
> -		dev_err(eth->dev, "failed to get bulk xsi reset lines\n");
> -		return err;
> -	}
> +	if (err)
> +		return dev_err_probe(eth->dev, err,
> +				     "failed to get bulk xsi reset lines\n");
> =20
>  	eth->napi_dev =3D alloc_netdev_dummy(0);
>  	if (!eth->napi_dev)
> --=20
> 2.49.0
>=20

--cyhlDYaZG9bgrtv1
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaBzROAAKCRA6cBh0uS2t
rFUMAQDpd0Xn+koxS18cJkCYXHZdZTj2Iyhx4nRlRK9NFE7f9QD/W6UmXacIPR+Y
bxz9OGSYFknzz3Tw588fLCsHr2Ur7QU=
=7evt
-----END PGP SIGNATURE-----

--cyhlDYaZG9bgrtv1--

