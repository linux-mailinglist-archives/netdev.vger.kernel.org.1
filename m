Return-Path: <netdev+bounces-207375-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E69E0B06EBE
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 09:17:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F4F27B2398
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 07:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA582459E5;
	Wed, 16 Jul 2025 07:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mNTOOGp1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625C2533D6;
	Wed, 16 Jul 2025 07:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752650237; cv=none; b=IAfLQXRcIu7+ZJrCyDK/KBrXqhp/NrCgwb+BoZakxnb58TvNcftTUfsSUoGiQu/8+sGmqjhXd4oaYwrDdw3XGKddT1V3wu1yM+PSGPqhczXm6GP4dBRkksM8+QHjTphGAIRlv7435vlda9MCurKSXpiwlzaYrGGiOPH0bZe6ZrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752650237; c=relaxed/simple;
	bh=cd5eTFGt2ZH0e4S6bPNCBDG2UvP/pounWuUyklto8IM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iO20FyhemeQIfIasXL03Nvag1GoJlSozpEl91H8PDSTMw2CJF+R2ltfYn4F+itv6nzT3hCZ+Z6MkJSlfSUjECUPl3L+9QlZwGSnF/ObIWA3JmeJT3Pew8DZlFyC8dJLHZnGDlt062Sn37R6P9kfaEkQgXjNItniym0qjc49hYl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mNTOOGp1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D59DC4CEF0;
	Wed, 16 Jul 2025 07:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752650236;
	bh=cd5eTFGt2ZH0e4S6bPNCBDG2UvP/pounWuUyklto8IM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mNTOOGp1fisiEOjXIcRrpXEGRABig1maftTzhlm6DsuFz2zAL0jvsZQ4s/PSppxiR
	 vhpiqIZhoSS4CV1uJhzSev6asAFYFkZ8yvaF0cbqSeZIvVnoyvise+WObys4lLHI7h
	 t6OSZ0X8PWQlmweR7qtcjyEXzfy13gXwfxQcYjYiQ9ZsxPLmy5EtfNJ0RSwUWbMNEW
	 h1i4SngYPocQHPZMv0nQvm6cUYv9KHqYSnuT04DgM+odJXPVhbEim9+k5CEIkxmZEU
	 gCL7Imzf25DMANhDaBM/Pw4RPRLj/patX0dViwLjZVonEfImUg44BH9FbXXsW0z6Qz
	 43cOnJYF+99kw==
Date: Wed, 16 Jul 2025 09:17:14 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net-next] net: airoha: Fix a NULL vs IS_ERR() bug in
 airoha_npu_run_firmware()
Message-ID: <aHdR-j2aZ-7wMg2A@lore-desk>
References: <fc6d194e-6bf5-49ca-bc77-3fdfda62c434@sabinyo.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hNQ6m2oLBFgFtFKp"
Content-Disposition: inline
In-Reply-To: <fc6d194e-6bf5-49ca-bc77-3fdfda62c434@sabinyo.mountain>


--hNQ6m2oLBFgFtFKp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> The devm_ioremap_resource() function returns error pointers.  It never
> returns NULL.  Update the check to match.

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

>=20
> Fixes: e27dba1951ce ("net: Use of_reserved_mem_region_to_resource{_byname=
}() for "memory-region"")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/net/ethernet/airoha/airoha_npu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/airoha/airoha_npu.c b/drivers/net/ether=
net/airoha/airoha_npu.c
> index 4e8deb87f751..5b0f66e9cdae 100644
> --- a/drivers/net/ethernet/airoha/airoha_npu.c
> +++ b/drivers/net/ethernet/airoha/airoha_npu.c
> @@ -179,8 +179,8 @@ static int airoha_npu_run_firmware(struct device *dev=
, void __iomem *base,
>  	}
> =20
>  	addr =3D devm_ioremap_resource(dev, res);
> -	if (!addr) {
> -		ret =3D -ENOMEM;
> +	if (IS_ERR(addr)) {
> +		ret =3D PTR_ERR(addr);
>  		goto out;
>  	}
> =20
> --=20
> 2.47.2
>=20

--hNQ6m2oLBFgFtFKp
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaHdR+QAKCRA6cBh0uS2t
rGscAQDafezCTx6Tg7NHRZzwrIG+WrX3UsI4bzfWa7dBHTaBEQEA4NLY1nMESskq
JR4WxA/oO+Ge5Va28kqhvA6sUqCvzg0=
=PR8p
-----END PGP SIGNATURE-----

--hNQ6m2oLBFgFtFKp--

