Return-Path: <netdev+bounces-184139-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AB65A9370D
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 14:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 603578A7422
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 12:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC5B3274FF8;
	Fri, 18 Apr 2025 12:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CnDyTiNl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0581A3168;
	Fri, 18 Apr 2025 12:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744979333; cv=none; b=NS559o9O6/0r/S6Vhys/Ytp8WrlSh0cwT3i0KegjVAu18GalSgUeaRmdC5XCOzGn3qEIFCBYd83qvK9Kf92uzLc80TfSS8bPB7e4Avl6heSYu141nGkba0U0B8P3J32aBTCvu8cv5a70/x6XvzeDZ9qtXaBUfLzNfCpayEnHd6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744979333; c=relaxed/simple;
	bh=ilxE+AXvg/NkPCparHHXLro/i6ZYsW2R0eQyBLPfXW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T5CEeWwvKpqpdyNusQoWvBNn1N8wa0AE0GqjlMbbhyZQhANqA962nPAd+nFIRSot1oG5lS2H6uprAL/BRQSo4gM5MRBWzYNsKsT2vliHqfQY3igj+Rl0Y9dMgtqWlR9rak6RGEShpWOdkTMAFpDe3wCB9fIFsHxBFm3I01wTI1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CnDyTiNl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A13CC4CEE2;
	Fri, 18 Apr 2025 12:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744979333;
	bh=ilxE+AXvg/NkPCparHHXLro/i6ZYsW2R0eQyBLPfXW4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CnDyTiNlnqdqB+YYUT48Fr1Qp0GnOVNXI3DoY3NZIXDNc8WbtLm+ZzimWGBEwldnW
	 fI7Hs6NV6dgz9iey/D8j0ygJwboEOSavL77Nbm0tyY+cZlH5E1CplRnyDP08sePYKU
	 GQHsmzDWam4S0tHJD2sYU7GJs9weHq/viQwuFrD3dLz/L2x9OYZdFSTTt2+IbafwfP
	 otzZHeAV+mvQWkElFaW1d+MWar1i2D7f+9z4n7KvyzKmDjx+7F9igF1di2icH0rZPH
	 J0AXweDYfShtEiL0tCOHd4wHg+4734MErZ8P4Nk8fYPC+J8/8SFF/JsTSZcn1pczMG
	 Q3WBgaUiFkEow==
Date: Fri, 18 Apr 2025 14:28:50 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH] net: airoha: Fix an error handling path in airoha_probe()
Message-ID: <aAJFgqrOFL_xAqtW@lore-desk>
References: <f4a420f3a8b4a6fe72798f9774ec9aff2291522d.1744977434.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Y0SBIVyEi97tYwoG"
Content-Disposition: inline
In-Reply-To: <f4a420f3a8b4a6fe72798f9774ec9aff2291522d.1744977434.git.christophe.jaillet@wanadoo.fr>


--Y0SBIVyEi97tYwoG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> If an error occurs after a successful airoha_hw_init() call,
> airoha_ppe_deinit() needs to be called as already done in the remove
> function.
>=20
> Fixes: 00a7678310fe ("net: airoha: Introduce flowtable offload support")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Compile tested-only
> ---
>  drivers/net/ethernet/airoha/airoha_eth.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ether=
net/airoha/airoha_eth.c
> index 69e523dd4186..252b32ceb064 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.c
> +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> @@ -2631,6 +2631,8 @@ static int airoha_probe(struct platform_device *pde=
v)
>  		}
>  	}
>  	free_netdev(eth->napi_dev);
> +
> +	airoha_ppe_deinit(eth);
>  	platform_set_drvdata(pdev, NULL);
> =20
>  	return err;
> --=20
> 2.49.0
>=20

Hi Christophe,

I agree we are missing a airoha_ppe_deinit() call in the probe error path,
but we should move it above after stopping the NAPI since if airoha_hw_init=
()
fails we will undo the work done by airoha_ppe_init(). Something like:

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/etherne=
t/airoha/airoha_eth.c
index 16c7896f931f..37d9678798d1 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -2959,6 +2959,7 @@ static int airoha_probe(struct platform_device *pdev)
 error_napi_stop:
 	for (i =3D 0; i < ARRAY_SIZE(eth->qdma); i++)
 		airoha_qdma_stop_napi(&eth->qdma[i]);
+	airoha_ppe_init(eth);
 error_hw_cleanup:
 	for (i =3D 0; i < ARRAY_SIZE(eth->qdma); i++)
 		airoha_hw_cleanup(&eth->qdma[i]);


Agree?

Regards,
Lorenzo

--Y0SBIVyEi97tYwoG
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaAJFggAKCRA6cBh0uS2t
rKOIAQCwH4/D7rA5prRIS5BaxnLlZVf6GSFzAusPqDttCUbOqAD+KQkQkPThXEuJ
VlYdxSyCO8mR3H/2/EGw9Cw368w4iws=
=5A8k
-----END PGP SIGNATURE-----

--Y0SBIVyEi97tYwoG--

