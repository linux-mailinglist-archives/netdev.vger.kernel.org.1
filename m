Return-Path: <netdev+bounces-107238-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B19CA91A5EC
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 13:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 689CE1F228CE
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 11:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 761A714EC64;
	Thu, 27 Jun 2024 11:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FdG5USaa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE0513E41F;
	Thu, 27 Jun 2024 11:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719489495; cv=none; b=SRWCJEwnk0Zp/lPO0AvJpG7N9nZPNZpCUMxfZgr8XL68HFmZvAO98BxBQ8v1C/6Tl/PDcbS1kw91mngBbdHqc2gd36qomXc98sY+K6oQCc2n5IzXoo/FYzmfGF5Oi54a3A+ysh6FWym4yyRrFzriBmjVN4pSc/8gZT2A3xyNH7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719489495; c=relaxed/simple;
	bh=bsdKZ7FH+cF7ZRJHnYvsPuep+j4/x6xeM+rw6kh7mwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n7dErV4HC/b0MmayYnIbGa4R96APhKH2OBJ9umWYh1pbN3MJbS+LtjJkLE84F9RnAJ8WZssP6A1wTfUIxyH6QqJCr5TtiKkYt++UD1xQIVVtHP9Cm7kyHllOdjyKIt8aFgd+N7r7RCHqkaP4eNuval0tnzZrdAugICFT7fMSjX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FdG5USaa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA5A7C2BBFC;
	Thu, 27 Jun 2024 11:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719489494;
	bh=bsdKZ7FH+cF7ZRJHnYvsPuep+j4/x6xeM+rw6kh7mwQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FdG5USaawH1QsUeF2Sr4FzLiX0rqAx4tDdwlTk9AzK6jloq7xqptYqhrGjxRElDlT
	 3XOk1flWQWt+enajVvssDn+HSznBFmPSU1HB5JmFIehpe39aXkjFcqMUUbTHj5UmZo
	 z2KLAoZhhsSjsYVfH26Gn+G0ENYU5h1ayy5BStqW+wvqHR1GZR8Pf/cE+q7Xs5o24q
	 RXveEK68AfpH/RNHL1GEFagzD3tmwiVz0nQqGWbKNLM/Vt+gv4MDxeBFMcpoELc1uZ
	 Zx7GN9a1c7bplTCeN0k/cRNIav7QEhZipytDw7gMK3N0/eb4wFp0bpVY1BbPBuPwUK
	 t3ycuu0wcWzMA==
Date: Thu, 27 Jun 2024 12:58:07 +0100
From: Mark Brown <broonie@kernel.org>
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
	Liam Girdwood <lgirdwood@gmail.com>, Marek Vasut <marex@denx.de>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next,PATCH 0/2] Fixes for stm32-dwmac driver fails to probe
Message-ID: <3b262c42-30ef-4221-aeba-e6fc5d9549b9@sirena.org.uk>
References: <20240627084917.327592-1-christophe.roullier@foss.st.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uyMFrReHwMXWhVba"
Content-Disposition: inline
In-Reply-To: <20240627084917.327592-1-christophe.roullier@foss.st.com>
X-Cookie: I just had a NOSE JOB!!


--uyMFrReHwMXWhVba
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 10:49:15AM +0200, Christophe Roullier wrote:
> Mark Brown found issue during stm32-dwmac probe:
>=20
> For the past few days networking has been broken on the Avenger 96, a
> stm32mp157a based platform.  The stm32-dwmac driver fails to probe:

These patches resolve the boot issue I'm seeing on this platform:

Tested-by: Mark Brown <broonie@kernel.org>

--uyMFrReHwMXWhVba
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZ9U88ACgkQJNaLcl1U
h9DnYAf+MRtkI/wgcbZL/MOrZDaxdLzL+NYaZF8qlPgsW2i1ddZHbLEce94FVywY
8JdeXXr6OLRprSR8iGoL+3AZ5IFD01V6LAI/s4q3S260J5TkrUcVOjI9nWrBA7+Q
63wPVnM/EA1qu7hvTyrgICtF26O/NypA+dQYCS0FBryEMYE4wL8DGP7PjexzkDTV
V3AbcEPa5meIo6livs5Sb4mryq9e7fWMKGv0qCNo3nrPdhylbzIhKd0qHdbVo3sF
tPQdTIc76WPvY1RJ1sLNw+fyoNeZ5elLRGMzRFF0VhdnhUjMY6TFoVQ1/P5pSbUw
8Kpx6Ap1305I4Do8kQf38/r9OvNEpg==
=OIp5
-----END PGP SIGNATURE-----

--uyMFrReHwMXWhVba--

