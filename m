Return-Path: <netdev+bounces-240485-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 622FCC75722
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 17:44:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 90FBA365199
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 16:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE133368286;
	Thu, 20 Nov 2025 16:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SHG3OFeL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A021528FFE7;
	Thu, 20 Nov 2025 16:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763656279; cv=none; b=UQpEVMz3is58Wh9XjUae87EUE+nHzXkEdlGyTB3+7IdYGo8kaA5L78KMj6i5uVZp+wtRI+5MnzjC4+nEP0tPbe+PmGiq6RrQK4hXKvghhriaeZ/QCqvB12jD4rSC4if4tf8GE8qY+yj2NYCN8B5yU5zSkW8mbRYDpJ63hkhwMiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763656279; c=relaxed/simple;
	bh=+t2RxpZYsc6EBAkiIiAw8xa7Z0l4LUgdt6k1NQShhzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZK/0izaqeNAxrFY7bU+XByMypCeF9Lj0N8280iHzdQYQNJcf74PMrK7kOignuAuDXTe8EHdy50PQ5ZzEP9Qy50qRWQVrH7DDeBVdRdlhGPwB8FqBMhZlqcA8pooyUaFRCglN+Y0DkiY/hn3+lOg3uZ4JvC4APqCvMj/Sluht7eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SHG3OFeL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1E5BC4CEF1;
	Thu, 20 Nov 2025 16:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763656279;
	bh=+t2RxpZYsc6EBAkiIiAw8xa7Z0l4LUgdt6k1NQShhzY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SHG3OFeLTB4Hj/eETcebnotdZAETCyejYgNdFRTUA1Z8nSG3U05azdEclaOz6Ssh6
	 WGlSzcJDRR7HjLoc9RiM/s7WxrbV8ZQmTzPP/nI5nW0RvCvF2imrMqN2t2TMNV//AA
	 xhrUrqjY0CvoJkHJtTnNGJbtTmWBKSzsKc7fKM1PyLGKqzfyPd/ilqJayxqLipxuec
	 RuHVValyQL2PlUbpDYtZrf9TALOC2xKsSS22gKw0fu7ud0tTUVY16Q6a784OjhOnTQ
	 PQuzF8U11sO5gvcfKfX0jI7PpswnY9Grv0V8owCsIPlf5WO9hQzRre8hbwwJU/Srvp
	 SmNMctiO7Ywrw==
Date: Thu, 20 Nov 2025 16:31:11 +0000
From: Conor Dooley <conor@kernel.org>
To: netdev@vger.kernel.org
Cc: Conor Dooley <conor.dooley@microchip.com>,
	Valentina.FernandezAlanis@microchip.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Richard Cochran <richardcochran@gmail.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Sean Anderson <sean.anderson@linux.dev>,
	Vineeth Karumanchi <vineeth.karumanchi@amd.com>,
	Abin Joseph <abin.joseph@amd.com>, neil.armstrong@linaro.org
Subject: Re: [RFC net-next v1 0/7] highly rfc macb usrio/tsu patches
Message-ID: <20251120-unreal-antitrust-e32900cf893b@spud>
References: <20251120-jubilant-purposely-67ec45ce4e2f@spud>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="TId/bCOlj9KNVAAR"
Content-Disposition: inline
In-Reply-To: <20251120-jubilant-purposely-67ec45ce4e2f@spud>


--TId/bCOlj9KNVAAR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 20, 2025 at 04:26:02PM +0000, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
>=20
> Hey folks,
>=20
> After doing some debugging of broken tsu/ptp support on mpfs, I've come
> up with some very rfc patches that I'd like opinions on - particularly
> because they impact a bunch of platforms that I have no access to at all
> and have no idea how they work. The at91 platforms I can just ask
> Nicolas about (and he already provided some info directly, so I'm not
> super worried at least about the usrio portion there) but the others
> my gut says are likely incorrect in the driver at the moment.
>=20
> These patches *are* fairly opinionated and not necessarily technically
> correct or w/e. The only thing I am confident in saying that they are is
> more deliberate than what's being done at the moment.
>=20
> At the very least, it'd be good of the soc vendor folks could check
> their platforms and see if their usrio stuff actually lines up with what
> the driver currently calls "macb_default_usrio". Ours didn't and it was
> a nasty surprise.
>=20
> Cheers,
> Conor.
>=20
> CC: Valentina.FernandezAlanis@microchip.com
> CC: Andrew Lunn <andrew+netdev@lunn.ch>
> CC: David S. Miller <davem@davemloft.net>
> CC: Eric Dumazet <edumazet@google.com>
> CC: Jakub Kicinski <kuba@kernel.org>
> CC: Paolo Abeni <pabeni@redhat.com>
> CC: Rob Herring <robh@kernel.org>
> CC: Krzysztof Kozlowski <krzk+dt@kernel.org>
> CC: Conor Dooley <conor+dt@kernel.org>
> CC: Daire McNamara <daire.mcnamara@microchip.com>
> CC: Paul Walmsley <pjw@kernel.org>
> CC: Palmer Dabbelt <palmer@dabbelt.com>
> CC: Albert Ou <aou@eecs.berkeley.edu>
> CC: Alexandre Ghiti <alex@ghiti.fr>
> CC: Nicolas Ferre <nicolas.ferre@microchip.com>
> CC: Claudiu Beznea <claudiu.beznea@tuxon.dev>
> CC: Richard Cochran <richardcochran@gmail.com>
> CC: Samuel Holland <samuel.holland@sifive.com>
> CC: netdev@vger.kernel.org
> CC: devicetree@vger.kernel.org
> CC: linux-kernel@vger.kernel.org
> CC: linux-riscv@lists.infradead.org
> CC: Neil Armstrong <narmstrong@baylibre.com>

The perils of grabbing addresses from git blame..
+CC Neil @ linaro.

> CC: Dave Stevenson <dave.stevenson@raspberrypi.com>
> CC: Sean Anderson <sean.anderson@linux.dev>
> CC: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
> CC: Abin Joseph <abin.joseph@amd.com>
>=20
> Conor Dooley (7):
>   riscv: dts: microchip: add tsu clock to macb on mpfs
>   net: macb: warn on pclk use as a tsu_clk fallback
>   net: macb: rename macb_default_usrio to at91_default_usrio as not all
>     platforms have mii mode control in usrio
>   net: macb: np4 doesn't need a usrio pointer
>   dt-bindings: net: macb: add property indicating timer adjust mode
>   net: macb: afaict, the driver doesn't support tsu timer adjust mode
>   net: macb: add mpfs specific usrio configuration
>=20
>  .../devicetree/bindings/net/cdns,macb.yaml    |  15 +++
>  arch/riscv/boot/dts/microchip/Makefile.orig   |  26 ++++
>  arch/riscv/boot/dts/microchip/mpfs.dtsi       |   8 +-
>  drivers/net/ethernet/cadence/macb.h           |   3 +
>  drivers/net/ethernet/cadence/macb_main.c      | 123 +++++++++++-------
>  5 files changed, 125 insertions(+), 50 deletions(-)
>  create mode 100644 arch/riscv/boot/dts/microchip/Makefile.orig
>=20
> --=20
> 2.51.0
>=20

--TId/bCOlj9KNVAAR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaR9CTwAKCRB4tDGHoIJi
0l9+AQCAjXs4acBGojRkX7id4pZPjNPBVHlGllV6ND5awkZO7AD/fgnp3TeWWyfS
eZPQo7qlyaefIwAK1U7ee9plirXEHQw=
=Lpsd
-----END PGP SIGNATURE-----

--TId/bCOlj9KNVAAR--

