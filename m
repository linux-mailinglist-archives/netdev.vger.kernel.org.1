Return-Path: <netdev+bounces-191293-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F7AABAA92
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 16:07:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A03A23BFD19
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 14:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D84EC20110B;
	Sat, 17 May 2025 14:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ew5pYssa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5965680;
	Sat, 17 May 2025 14:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747490858; cv=none; b=qgUWwAmZ9StDWyrGbGJeV61SeHdCSUa0KuzPyv1JvA8UxyOJozqswg0PCKec848VyPyLwD9LclqDjhihPzuuO5Baqfu4M/pOeC0LeqEMi4x8KMAphTggglB2NMCKSSivDCs0J6bDtUCqPBwDYj3u0wNkHs7XygCq7XQ9O4+tnoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747490858; c=relaxed/simple;
	bh=PeIoRJcyHR4S55FKA1UWzyjZnGdb8RK10FAMdjCcHwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y9YwLHbhA03ZvRVe2cxtnHaDjsEpkY/6XbgYr0ThbUFX6mxQ5Q0LQg9R1l4f32jynsx2rHq9TVQtYj2D5PMET0P6ZkQ9IEmaoIkFAkajRFeVJEW+pzrJGRVCDKixlNUeMogZm4+1L1MZ+NBH5ViFfqeOBkecOWzDUADboJqF6bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ew5pYssa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F81BC4CEE3;
	Sat, 17 May 2025 14:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747490858;
	bh=PeIoRJcyHR4S55FKA1UWzyjZnGdb8RK10FAMdjCcHwU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ew5pYssabtoP6JFJWQiM3hIMrCoHzKcPSiZtxfJKLMvc31pLIzMeGbmxv51S2MUEU
	 ZuEH0lwwmawqgWClCCuVTT3qbDD9u0PW5qPF/aCSMGkbDk/x67n1FfbhXfBB3kpO/t
	 q11jgitBNBIzjrWsI+3/az4WC6RfWQlIVZ2mfLmh1UAvZwjlqVirO2Crk5LSgL7c2K
	 Mrvd1m8Wr8qM5uZqndpePdEnIkGgJIK4zXxj7YW2CMnx7z50Hm7dpDuywMl6/7VK5S
	 th9weo7XZVBzbv4C2jTohVLzeBdAdQFc6c3fNH3JrENmcaW65Gp9W6O8Ija7nq+Ar/
	 v32yrkf1PxFDQ==
Date: Sat, 17 May 2025 16:07:35 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH v3 2/4] net: airoha: Fix an error handling path in
 airoha_probe()
Message-ID: <aCiYJ98sE0FCcKql@lore-desk>
References: <5c94b9b345017f29ed653e2f05d25620d128c3f0.1746715755.git.christophe.jaillet@wanadoo.fr>
 <47910951a3fa3c3bd2a942210e821d9301362128.1746715755.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dSuy9aXH7PkbQe/T"
Content-Disposition: inline
In-Reply-To: <47910951a3fa3c3bd2a942210e821d9301362128.1746715755.git.christophe.jaillet@wanadoo.fr>


--dSuy9aXH7PkbQe/T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> If an error occurs after a successful airoha_hw_init() call,
> airoha_ppe_deinit() needs to be called as already done in the remove
> function.
>=20
> Fixes: 00a7678310fe ("net: airoha: Introduce flowtable offload support")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

> ---
> Changes in v3:
>   - call airoha_ppe_deinit() and not airoha_ppe_init()   [Lorenzo Biancon=
i]
>=20
> Changes in v2:
>   - Call airoha_ppe_init() at the right place in the error handling path
>     of the probe   [Lorenzo Bianconi]
> v2: https://lore.kernel.org/all/3791c95da3fa3c3bd2a942210e821d9301362128.=
1746715755.git.christophe.jaillet@wanadoo.fr/
>=20
> v1: https://lore.kernel.org/all/f4a420f3a8b4a6fe72798f9774ec9aff2291522d.=
1744977434.git.christophe.jaillet@wanadoo.fr/
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
> +	airoha_ppe_deinit(eth);
>  error_hw_cleanup:
>  	for (i =3D 0; i < ARRAY_SIZE(eth->qdma); i++)
>  		airoha_hw_cleanup(&eth->qdma[i]);
> --=20
> 2.49.0
>=20

--dSuy9aXH7PkbQe/T
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaCiYJgAKCRA6cBh0uS2t
rLZLAP9yQ+AJh1B7emNBad3Bow3uvaKtJ69qO/Dqb1e2GqapMgEAzNPhgqXKXtU+
3KEBK8c3JI8g9p/oCZRY9lninB+MjA8=
=Ji36
-----END PGP SIGNATURE-----

--dSuy9aXH7PkbQe/T--

