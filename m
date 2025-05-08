Return-Path: <netdev+bounces-189025-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 510C3AAFEDA
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 17:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAB0B188F4B6
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 15:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD36827A478;
	Thu,  8 May 2025 15:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jiLzLgnN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F71127A44C;
	Thu,  8 May 2025 15:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746717031; cv=none; b=DCygWe6eKAA5jL7JIDg5UXjxmo3dWDVPyUJ7+eCSX09Ce4P7Y9fSvLH1s4RCtl+aC57d8+4TJ8+orGW1Cvx9to5Pi+UZo7+8HO+Xgf1YMa1NkzY94E8n+BiU+A/P1m6V3w3Rur8pDeE8lkUR8hNy1qIXVdeSVgTuZ0HIznak8Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746717031; c=relaxed/simple;
	bh=dhECve019k+MAhaJXpnJX0vZpEJhKyOVtBrA+Jc60Gw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KKIKnS4rlhDv1km7tFA0zvNhEVSwvroycXF2naCYt3aSWnbvZ3eREKX5jyUiFXzh2/zuUzVtq9vGZJMawS4UiOOplzHM9iNmlp+dRXoHOTKleZ2n+hkKGqRZpOMqqwqKe6D9tW10ruLNLRtwzWzAGJm68A3S93KDZG7ebSBU/Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jiLzLgnN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A144EC4CEE7;
	Thu,  8 May 2025 15:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746717031;
	bh=dhECve019k+MAhaJXpnJX0vZpEJhKyOVtBrA+Jc60Gw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jiLzLgnNY0s2FTPN5+DxCy5Hc10iLZS6vuh/B+dVKZ6zKd/hSyVEe58/lA0bztS7m
	 ymneFlZ/yNcmS1JXeh8kTaRgTz5yCcTkIK/jUSo8TmuSSw6fO+vGl2Ws+UplUycPtP
	 lzWp5XeU8zpMwhowNEHlqbONMLjgB6e1qsLi2t6HE+UyGDvaVJNjNtlXqQcl3tQaj7
	 +0cLGZF/sUQS2BjI1onrqLymbKDVh94UUXp7Dk6Z0OK4CYFRP0j2z6tEjIqCGsOEjb
	 MmvOmdQFFn4kKRx6jCrBkW98MGqJmDnaMkgff4kBbIdgUaZBASIEA5NmQMfSdH3zOV
	 M5I/xYSK1H5Yw==
Date: Thu, 8 May 2025 17:10:28 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2 2/4] net: airoha: Fix an error handling path in
 airoha_probe()
Message-ID: <aBzJZCIvE9u_IAM-@lore-desk>
References: <5c94b9b3850f7f29ed653e2205325620df28c3ff.1746715755.git.christophe.jaillet@wanadoo.fr>
 <3791c95da3fa3c3bd2a942210e821d9301362128.1746715755.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="V+aLiTt/t6jXV4qn"
Content-Disposition: inline
In-Reply-To: <3791c95da3fa3c3bd2a942210e821d9301362128.1746715755.git.christophe.jaillet@wanadoo.fr>


--V+aLiTt/t6jXV4qn
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
> Changes in v2:
>   - Call airoha_ppe_init() at the right place in the error handling path
>     of the probe   [Lorenzo Bianconi]
>=20
> Compile tested only.
> ---
>  drivers/net/ethernet/airoha/airoha_eth.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ether=
net/airoha/airoha_eth.c
> index af8c4015938c..d435179875df 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.c
> +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> @@ -2967,6 +2967,7 @@ static int airoha_probe(struct platform_device *pde=
v)
>  error_napi_stop:
>  	for (i =3D 0; i < ARRAY_SIZE(eth->qdma); i++)
>  		airoha_qdma_stop_napi(&eth->qdma[i]);
> +	airoha_ppe_init(eth);

it was actually a typo in my previous email but this should be clearly
airoha_ppe_deinit().

Regards,
Lorenzo

>  error_hw_cleanup:
>  	for (i =3D 0; i < ARRAY_SIZE(eth->qdma); i++)
>  		airoha_hw_cleanup(&eth->qdma[i]);
> --=20
> 2.49.0
>=20

--V+aLiTt/t6jXV4qn
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaBzJZAAKCRA6cBh0uS2t
rOayAQCaglkROsypWbnoARe9kkq6RYdKaAl4rjlfjKCEB8HWQQEAgs12WF2PhlvU
iTcoAkcTJX4fuM85cyB9I8L+eeZi/wg=
=QUnf
-----END PGP SIGNATURE-----

--V+aLiTt/t6jXV4qn--

