Return-Path: <netdev+bounces-190857-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AEB90AB917C
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 23:17:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15F0817E171
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 21:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF7B225A50;
	Thu, 15 May 2025 21:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kjF51K1E"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C047B19CCEA;
	Thu, 15 May 2025 21:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747343819; cv=none; b=l6GDut99oyQ7AM3R4mIKWlYo995hXW8NZ5klf7tSOWWBr+jl6cIbtvaHWtDIaCiXkj2MnZGQSOENjbnVynbCKQUul7XMS216SEpk0d7rG1tO8DmugMCsCUZAsRaJhz1ul26UOlE2ac90HU2F0R3TyrzAaSSnO69kzxoas9Li2H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747343819; c=relaxed/simple;
	bh=0fDHksalYNZrl+B7FMp5wCiwKEDzwGLwVf4fzJoGC28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OAOdungsDGsVFwTE1LQiC1HQqjq6bVpyAmucikJE2o/4qUjVWbpVMdJjOLDLPKU7QanS/CcCy1FPg0ILJEGCQcigBDeboG71FMj5MtMvH8Pg89NW835JOwFYaxTgPmxIn+m94lWmPLS1hgOp4DLrzHWRn00h3ukTVoETtt2ef5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kjF51K1E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8C4DC4CEE7;
	Thu, 15 May 2025 21:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747343819;
	bh=0fDHksalYNZrl+B7FMp5wCiwKEDzwGLwVf4fzJoGC28=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kjF51K1EgtuYR8HJm9urywpBzMwwkQvuEdKPydwn1A4Y7b7jzktOUJ+jCqIAC4MAc
	 gNh78FbUVk0RcH4PFxVMc/LvzUIrDjxoGLa1Z8rU8xH0Sr6S7eFJnsTdNlgd2a+CWo
	 tHo2pLoSxCpWwOutmKQLVKJpMK5efRZasD+ymKgAkLIC0VxRRBnY372MZ6oXt1kxKU
	 IUXzWxQ4p1QKxXUNOsMqjsweKBVNYC+6qSJEK2R7pTaoKOff7btzUUTnriec44DK5c
	 bGh/sgQoRn+ZgZ8Ebf1bau5dRq1Gi+Z29B0/rxd8AdD1lvfM6nLqtmnMV9YZoQwNIL
	 +3hZnBiYjlikw==
Date: Thu, 15 May 2025 23:16:56 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH v3 1/4] net: airoha: Fix an error handling path in
 airoha_alloc_gdm_port()
Message-ID: <aCZZyDvp-TZ7AFwS@lore-desk>
References: <5c94b9b345017f29ed653e2f05d25620d128c3f0.1746715755.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Y6AU6u8oigfJDbdP"
Content-Disposition: inline
In-Reply-To: <5c94b9b345017f29ed653e2f05d25620d128c3f0.1746715755.git.christophe.jaillet@wanadoo.fr>


--Y6AU6u8oigfJDbdP
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

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

> ---
> Changes in v3:
>   - None
>=20
> Changes in v2:
>   - New patch
> v2: https://lore.kernel.org/all/5c94b9b3850f7f29ed653e2205325620df28c3ff.=
1746715755.git.christophe.jaillet@wanadoo.fr/
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

--Y6AU6u8oigfJDbdP
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaCZZyAAKCRA6cBh0uS2t
rBnoAP9FaVPF2CbBdrO+fj0pthqLp8g0i6A/AjxSkyZWruuaHwEA5btpiFBZ5imz
5SRZgTQ7PDqOijkGIb8OCvuDLpbXWQo=
=XFmd
-----END PGP SIGNATURE-----

--Y6AU6u8oigfJDbdP--

