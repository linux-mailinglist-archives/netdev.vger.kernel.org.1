Return-Path: <netdev+bounces-108357-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EB7F92315A
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 10:38:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3EEDB2390B
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 08:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BAD214D716;
	Tue,  2 Jul 2024 08:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mykMeghq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E896684D39;
	Tue,  2 Jul 2024 08:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719909518; cv=none; b=PjUaanRyeufZO5TQJxBmXgDOsPUcOzQruZ9UGWXz2MQuRDoq3Oi8RJpKK/ceI4N9yxXxJr1FpLXGTvyqAuD7FQ5XoYPnevwcydxkHMmeE0GcKogk5U0lq1Uh46QZ054e7IX1qW0jcXcVK915pcPW4KVrTdNuoTjwwvm8VYkdaDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719909518; c=relaxed/simple;
	bh=6ex5N1zEIAEs63idwfr73LwMEBs+3apJd/gjlf5XJrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BzjU5Z+OYKVwhN+Ai1c92GLzRJYyqFjnvtAmYOFK/c7h+8QzTwDR27MvHghGIenEZEthkkJ8o0fqShLnTwN2L4pWUfz8HJcsZ1Gl0JzTuQdQ2W4WfXzJFmJaT6zA+5W/ipTvLn+cEjURI45H1Dqjpq41NmDPX0ADB1IUtbaVC3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mykMeghq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0362C116B1;
	Tue,  2 Jul 2024 08:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719909517;
	bh=6ex5N1zEIAEs63idwfr73LwMEBs+3apJd/gjlf5XJrE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mykMeghqFGQbFNXIlxFPo/TiU0Yzx2/afa0Lo7eLFNHCwaFt27ezXOlvZeXsexQ8r
	 T5mok9QNIE9c87aPsNLG4BDhCAM5Tx1NxNa0WOB03ltfUpwbAMqSsPMcnaMb+9Dsan
	 pdUr3D13KzNmmdgaJrNvg3Xau8+e/qAZEuyFEHLcbaG6Dy9Kxw/IWFt8MGtYW1mOag
	 EkU1XrFtLE2ZRR8vTAXL82h0abIRWPi4rIJoWeKwKEzUu/Fn3NYW3K0KFSF5UtlrSp
	 pBH06zAD5rsAbKsOoWDRxR/ywlRwhMzU0HnVYLa1LNdB2p06Jp0moOfR5UFZtTcUYG
	 QI2M49pbHyxGQ==
Date: Tue, 2 Jul 2024 10:38:33 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, nbd@nbd.name, lorenzo.bianconi83@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, conor@kernel.org,
	linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, catalin.marinas@arm.com,
	will@kernel.org, upstream@airoha.com,
	angelogioacchino.delregno@collabora.com,
	benjamin.larsson@genexis.eu, rkannoth@marvell.com,
	sgoutham@marvell.com, andrew@lunn.ch, arnd@arndb.de
Subject: Re: [PATCH v4 2/2] net: airoha: Introduce ethernet support for
 EN7581 SoC
Message-ID: <ZoO8iYz1lj8PoLcB@lore-rh-laptop>
References: <cover.1719672695.git.lorenzo@kernel.org>
 <56f57f37b80796e9706555503e5b4cf194f69479.1719672695.git.lorenzo@kernel.org>
 <20240702071739.GA606788@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3HhSX3N5oOHaTMh+"
Content-Disposition: inline
In-Reply-To: <20240702071739.GA606788@kernel.org>


--3HhSX3N5oOHaTMh+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Sat, Jun 29, 2024 at 05:01:38PM +0200, Lorenzo Bianconi wrote:
>=20
> ...
>=20
> > diff --git a/drivers/net/ethernet/mediatek/airoha_eth.c b/drivers/net/e=
thernet/mediatek/airoha_eth.c
>=20
> ...
>=20
> > +#define INT_IDX4_MASK						\
> > +	(TX8_COHERENT_INT_MASK | TX9_COHERENT_INT_MASK |	\
> > +	 TX10_COHERENT_INT_MASK | TX11_COHERENT_INT_MASK |	\
> > +	 TX12_COHERENT_INT_MASK | TX13_COHERENT_INT_MASK |	\
> > +	 TX14_COHERENT_INT_MASK | TX15_COHERENT_INT_MASK |	\
> > +	 TX16_COHERENT_INT_MASK | TX17_COHERENT_INT_MASK |	\
> > +	 TX18_COHERENT_INT_MASK | TX19_COHERENT_INT_MASK |	\
> > +	 TX20_COHERENT_INT_MASK | TX21_COHERENT_INT_MASK |	\
> > +	 TX20_COHERENT_INT_MASK | TX21_COHERENT_INT_MASK |	\
>=20
> Hi Lorenzo,
>=20
> One more thing that I forgot to note yesterday:
> the two lines above appear to be duplicates of each other.

ack, thx. I will fix it in v5.

Regards,
Lorenzo

>=20
> Flagged by Coccinelle.
>=20
> > +	 TX22_COHERENT_INT_MASK | TX23_COHERENT_INT_MASK |	\
> > +	 TX24_COHERENT_INT_MASK | TX25_COHERENT_INT_MASK |	\
> > +	 TX26_COHERENT_INT_MASK | TX27_COHERENT_INT_MASK |	\
> > +	 TX28_COHERENT_INT_MASK | TX29_COHERENT_INT_MASK |	\
> > +	 TX30_COHERENT_INT_MASK | TX31_COHERENT_INT_MASK)
>=20
> ...

--3HhSX3N5oOHaTMh+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZoO8hQAKCRA6cBh0uS2t
rNAtAP4u301c6Gkptn1unHEwV76FGyfr3xFSoG+tsbAG4DUr5wEAyxU1zDMZc0Yy
Eat+pMufGRj9HgtbwvVHnx2kQjNokQs=
=1pZr
-----END PGP SIGNATURE-----

--3HhSX3N5oOHaTMh+--

