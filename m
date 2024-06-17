Return-Path: <netdev+bounces-104165-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F10B90B621
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 18:19:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 014CA283C38
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 16:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65EC814D29D;
	Mon, 17 Jun 2024 16:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KSt0rxFs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3476E14BFBC;
	Mon, 17 Jun 2024 16:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718641187; cv=none; b=owe5HOxNvqwfR9MIHY67iGKd4ldoKKKw3TEvRW16OUVIVFIF7d1953jqP/rfPXtqUwWlqkvhfCiV4SPH3W893fL5xZChsyaU6HvOZnlTKLhthLcll80+yAXebIA4wjLAOMxr3Dj3tCFfSlSzzLFV+XHq4BA7ThefslOcUmjJOOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718641187; c=relaxed/simple;
	bh=kq0sP/MpDIUvWkzVHv03Hs2cqjHxapUk5etdJnS5N3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BDH8MDT+L4cMTk7zwTi99Hij6ZCW1etlfFAkanpaPh3J54vAzVT/f8s+ooddrg6izW/ph0+4Zsxa1G5nfD86VUIhvbaoK7iaZvSP9WBQzZX6eRYpvWKO5C8QmV/oJLcTF4k/oJHKj9d+fCcFMp3vpPoFCh6CbCoeyo1kU+GduP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KSt0rxFs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D95CC2BD10;
	Mon, 17 Jun 2024 16:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718641186;
	bh=kq0sP/MpDIUvWkzVHv03Hs2cqjHxapUk5etdJnS5N3M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KSt0rxFsTWZkZE0C9KPZLORhT7pm/Bf7yNzXY2hHC/mKYgEl0Qiehc3Mrwtkbtb0T
	 MrZD/EJYhcm0qB5Z+kFTBoTnI9MLE0XHEGZH8N6rvmwjunDem1zNfzKY9U868NV/5h
	 FBCrhYilKel0BqqOp2vNrahbi1oItZlfX8DwK/r+doyQH7rFiE3iHft6ydPG0b0y9O
	 Bvl3Nl1aT1/2d0YPbNN9Sp9tU7qXCz12XrQoSI5KcuC2h8EFO1CusDylFIUqXX6alW
	 dWvViMyveZVqgLuMkyPn+RYR3QV/7M83oiEs49bUnTQpn1Qr3311ipBWkicb1FnYax
	 lyQX2iB5i7+Eg==
Date: Mon, 17 Jun 2024 17:19:40 +0100
From: Conor Dooley <conor@kernel.org>
To: Christophe Roullier <christophe.roullier@foss.st.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Marek Vasut <marex@denx.de>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next,PATCH v2 1/2] dt-bindings: net: add STM32MP25
 compatible in documentation for stm32
Message-ID: <20240617-spoils-trailside-99adaea88604@spud>
References: <20240617154516.277205-1-christophe.roullier@foss.st.com>
 <20240617154516.277205-2-christophe.roullier@foss.st.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="CPXMyFh3qeMMXI35"
Content-Disposition: inline
In-Reply-To: <20240617154516.277205-2-christophe.roullier@foss.st.com>


--CPXMyFh3qeMMXI35
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 05:45:15PM +0200, Christophe Roullier wrote:
> New STM32 SOC have 2 GMACs instances.
> GMAC IP version is SNPS 5.30
>=20
> Signed-off-by: Christophe Roullier <christophe.roullier@foss.st.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

--CPXMyFh3qeMMXI35
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZnBiHAAKCRB4tDGHoIJi
0jsuAP9lhc+oKhgHut5k2kN1bwEeV4Ln+08RJ/mFc3/VkuvCtwEAjRVAXhN2+8Ju
mmIlzsAaCHubydzbWNH3FOCXsRH2KQ0=
=RElg
-----END PGP SIGNATURE-----

--CPXMyFh3qeMMXI35--

