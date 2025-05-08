Return-Path: <netdev+bounces-189031-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43059AAFF42
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 17:32:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88ACF1BA01AF
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 15:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 431D32750FB;
	Thu,  8 May 2025 15:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ePVkyDPW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1397222422D;
	Thu,  8 May 2025 15:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746718319; cv=none; b=sTMg/mT07YbRelcuBfsLEU4v1GclvWo7c6/plEypa2U1rl9niJCwj3eQrfVjrohQY5QGYUsUd1Yk++/cW+ipp4mbOkLPay/fxfJvGO1MP3l9e8U+Xa++MglLi9ztror8Cw0fYElVo7LUh+SiTHfp9vhHSwsDHCv3Tcx/f/1eRNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746718319; c=relaxed/simple;
	bh=DF5Q0mSLcNjmiVluZaVYRFv1Km7OOZoaMMTU97Cg0Bk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U2d8fEoEjzz+PI+GU6OXkTai29wV5PfCQEKnJ9szugqoIpib0aOWMK3FKB/5tftVzIUiLK9nal1ABtLip5GGvmmxNIvM59vQekpN+7fwUH9inJnJJEcCFWfov+PAUwzLSlLdinzV6HemBOpGQ51so+TnT+jtodlHVtu7DDi3ttk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ePVkyDPW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE990C4CEE7;
	Thu,  8 May 2025 15:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746718318;
	bh=DF5Q0mSLcNjmiVluZaVYRFv1Km7OOZoaMMTU97Cg0Bk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ePVkyDPWnT4m8p1cRtcnkq3pqnotnwGRDABeR8nZG/nr53S6NWjGwyn6f5hRrDDW/
	 mvBMdpzELu47Lq87GPFYfr7hInAEWsprDveImhfhELeogTp6ONjX3iyIJgmnlV+UGY
	 YH3xdg/q8ykieiA7gC90FCCg4zKudHiQUt1c0zKOkctX3PFUHS6G/fA+16XRG8S0f5
	 Ec+kilcRE7nijEwy0TXDHUbRtp2adghQZkDeMrtpyglic9etIRQFR1cCoUJU04MZRq
	 bgXro+FSlRNyL0SeJeGps8QVaAPecqGSFvlIbLjuBRwQYrhTWvLlv1EIIRZ+qiDvwQ
	 94njGQrvM/sWQ==
Date: Thu, 8 May 2025 17:31:54 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2 1/4] net: airoha: Fix an error handling path in
 airoha_alloc_gdm_port()
Message-ID: <aBzOaiU6Ac3ZTU-4@lore-desk>
References: <5c94b9b3850f7f29ed653e2205325620df28c3ff.1746715755.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="52bjE/uxYDiQLQGk"
Content-Disposition: inline
In-Reply-To: <5c94b9b3850f7f29ed653e2205325620df28c3ff.1746715755.git.christophe.jaillet@wanadoo.fr>


--52bjE/uxYDiQLQGk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> If register_netdev() fails, the error handling path of the probe will not
> free the memory allocated by the previous airoha_metadata_dst_alloc() call
> because port->dev->reg_state will not be NETREG_REGISTERED.
>=20
> So, an explicit airoha_metadata_dst_free() call is needed in this case to
> avoid a memory leak.
>=20
> Fixes: af3cf757d5c9 ("net: airoha: Move DSA tag in DMA descriptor")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Changes in v2:
>   - New patch
>=20
> Compile tested only.
> ---
>  drivers/net/ethernet/airoha/airoha_eth.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ether=
net/airoha/airoha_eth.c
> index 16c7896f931f..af8c4015938c 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.c
> +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> @@ -2873,7 +2873,15 @@ static int airoha_alloc_gdm_port(struct airoha_eth=
 *eth,
>  	if (err)
>  		return err;
> =20
> -	return register_netdev(dev);
> +	err =3D register_netdev(dev);
> +	if (err)
> +		goto free_metadata_dst;
> +
> +	return 0;
> +
> +free_metadata_dst:
> +	airoha_metadata_dst_free(port);
> +	return err;
>  }
> =20
>  static int airoha_probe(struct platform_device *pdev)
> --=20
> 2.49.0
>=20

I have not tested it but I think the right fix here would be something like:

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/etherne=
t/airoha/airoha_eth.c
index b1ca8322d4eb..33f8926bba25 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -2996,10 +2996,12 @@ static int airoha_probe(struct platform_device *pde=
v)
 	for (i =3D 0; i < ARRAY_SIZE(eth->ports); i++) {
 		struct airoha_gdm_port *port =3D eth->ports[i];
=20
-		if (port && port->dev->reg_state =3D=3D NETREG_REGISTERED) {
+		if (!port)
+			continue;
+
+		if (port->dev->reg_state =3D=3D NETREG_REGISTERED)
 			unregister_netdev(port->dev);
-			airoha_metadata_dst_free(port);
-		}
+		airoha_metadata_dst_free(port);
 	}
 	free_netdev(eth->napi_dev);
 	platform_set_drvdata(pdev, NULL);

Regards,
Lorenzo

--52bjE/uxYDiQLQGk
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaBzOagAKCRA6cBh0uS2t
rPOJAQDJTb2xYCguiX/ivGfyWWdwij5dvd2KUapFuFCvVhjp2QD7BoT0xs5jz29J
d+A0RUW9SL63iUnc7PZVOIK/It8iRAg=
=OODZ
-----END PGP SIGNATURE-----

--52bjE/uxYDiQLQGk--

