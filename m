Return-Path: <netdev+bounces-191295-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A21BABAA97
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 16:09:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEAC31738AF
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 14:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54346202C31;
	Sat, 17 May 2025 14:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iVfKb6TT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24EA31F3D20;
	Sat, 17 May 2025 14:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747490985; cv=none; b=ufv4ZRSRCM+SQux8hJVet/tva8N+1LO2vhIUnu1Et6WjnFRq1K9w32XImvOZ1CmT8fPYB1VznNfursg4fhABJN/XJcIFqrM19x2TBfpxH6+T//OSbpBsYsZsChCBpJv0GtNgaBjiuXpVaL7tjj+2AfgbRrcBTEdry2g5Na5Flm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747490985; c=relaxed/simple;
	bh=48gpje1b4BnG1wIFcMvNafwZBZ8ZTqpMU6S+ktxIe3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LCZCAjPx3pUy4chXn0tRs6oG27JMdrMFxB0Q1RCOuzeHtfPJSP+eahPAgDDzn5AE2nNaEnfSfP7ZWr3RP0GgzFE70Qoh88zfWZQXnTAYXrdIujDzCzUXWHzmWtn/RQ9pN+HKCvCHXMOAxEvm0o212sBBsYIyYzGqYZu1Q1kobxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iVfKb6TT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C03BC4CEE3;
	Sat, 17 May 2025 14:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747490983;
	bh=48gpje1b4BnG1wIFcMvNafwZBZ8ZTqpMU6S+ktxIe3Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iVfKb6TTJXwXCBaJQew8+KCAAimhuUfQw7JNoQO9Bk+k7dDWbZQN94GgbazuugqiW
	 8sd7KLXJfWVQN2J2XJ//t5lWXyg+O83qjik8j9Vgu3UcloRxslI/rEaC/bqXhXODWC
	 jFPinrwCebjOKVnTN4MqWD2y4h18bysTXIJ2mng2XGH4On/IWpxeeBF6noMTnuwXPb
	 p+TLNq3OadfvhX7Tiy9EQDRUj5wktcX3KHYd8k1ZQSRn3LwhYnBpG1uQiW71INvAc1
	 5ToHOdq/A0Nah9mMOkHo17ZBUS3BUnieYmRBwQjKHmQ+4O+QlVaeUycD5MXda2UTcg
	 PJ4TvZ5BZjPJg==
Date: Sat, 17 May 2025 16:09:40 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH v3 4/4] net: airoha: Use dev_err_probe()
Message-ID: <aCiYpEVR6LqimFR9@lore-desk>
References: <5c94b9b345017f29ed653e2f05d25620d128c3f0.1746715755.git.christophe.jaillet@wanadoo.fr>
 <bb64aa1ea0205329c377ad32dde46cdf5c232db9.1746715755.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dvb0gdBYaE0sLUSj"
Content-Disposition: inline
In-Reply-To: <bb64aa1ea0205329c377ad32dde46cdf5c232db9.1746715755.git.christophe.jaillet@wanadoo.fr>


--dvb0gdBYaE0sLUSj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Use dev_err_probe() to slightly simplify the code.
> It is less verbose, more informational and makes error logging more
> consistent in the probe.
>=20
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Lorenzo Bianconi <lorenzo@kernel.org>

> ---
> Changes in v3:
>   - None
>=20
> Changes in v2:
>   - New patch
> v2: https://lore.kernel.org/all/1b67aa9ea0245325c3779d32dde46cdf5c232db9.=
1746715755.git.christophe.jaillet@wanadoo.fr/
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

--dvb0gdBYaE0sLUSj
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaCiYpAAKCRA6cBh0uS2t
rI58AQDtv8x2UkvBiCpjWp7KbOaBbU0fBMA3I7qsMReEFiMcwQEA13VkZJcrcOcB
DbnQXe3XN7duYfNTHnes7v8XvY/uTQg=
=jhMB
-----END PGP SIGNATURE-----

--dvb0gdBYaE0sLUSj--

