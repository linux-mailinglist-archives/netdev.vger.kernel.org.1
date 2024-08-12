Return-Path: <netdev+bounces-117785-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF30C94F522
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 18:45:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CD842816B8
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 16:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE261187328;
	Mon, 12 Aug 2024 16:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lGn2GEoG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB8F183CCC;
	Mon, 12 Aug 2024 16:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723481096; cv=none; b=iwivcKSaJiy5n/11d/EBZTI0D9gglP6xv43qdQXQ4ktOiwyG6jt31FzVPxvYethQuWON8NAGHXrOBCpE5GqhRhEtDC01g9MiOgMxSnj+a3KganayPYg0S6Kny6nMv2MEciaaCvVRDV+dkA9N4JyHSBK5GD/ItrJi6QRuzdXmQf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723481096; c=relaxed/simple;
	bh=2KKDirWRCLyFGNIflIjMwFeB3i+VBV6GbkGbJa2X+XU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pVpkWNtO3oJMqZtkHdHlkTQf6MzE6AhmWnoGuF+KdDmzb0WaWHyuzXsceAGoiWzDhyQmcrileYXFkTImyshAb3T4Dxq/TZU6otq0foqlWzKsKvRCpZtS3wBOY5ZLbzwiwL/3YRa0nXjdwYLeVZtKzpIOtG3YqSHT3M+P0G5c4hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lGn2GEoG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2668C32782;
	Mon, 12 Aug 2024 16:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723481096;
	bh=2KKDirWRCLyFGNIflIjMwFeB3i+VBV6GbkGbJa2X+XU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lGn2GEoG5+mMZA6QMhnL2IR7dBH0NUBSZi3bg+1jeuINBMa6I86ttRzuUWko8B+Ll
	 mIBTWIBpP1GxeiRHtRa8MqbcdmJQJrJD5Y1CCfYNl5sS/6Q4EZy2lHrzjUZDbSTyhz
	 arzrSO/R0NDL2spChAAeh9tgWu2C9E5sgzkCgKBLrBESuJ4CZ0MMKvP8pqvVpuezYV
	 pfxrNcR45pOCKjpHlRxEIfURxNTEpKsAYNIFMgtf8RS9sGndg4q01D+j3Qex/8B2zY
	 j7Poiq8lGTJ4kAMQmB6WAq7glpxS4JErniRdU5pGrb6CqLcT7XoFuMmm1M0YWa2fSP
	 iAXbQTOf1PZqw==
Date: Mon, 12 Aug 2024 17:44:50 +0100
From: Conor Dooley <conor@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"open list:ETHERNET PHY LIBRARY" <netdev@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH 1/1] dt-bindings: net: mdio: Add negative patten match
 for child node
Message-ID: <20240812-unmoving-viscosity-5f03dfd87f1f@spud>
References: <20240812031114.3798487-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="kH+ai/ND89N9wHWS"
Content-Disposition: inline
In-Reply-To: <20240812031114.3798487-1-Frank.Li@nxp.com>


--kH+ai/ND89N9wHWS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 11, 2024 at 11:11:14PM -0400, Frank Li wrote:
> mdio.yaml wrong parser mdio controller's address instead phy's address wh=
en
> mdio-mux exist.
>=20
> For example:
> mdio-mux-emi1@54 {
> 	compatible =3D "mdio-mux-mmioreg", "mdio-mux";
>=20
>         mdio@20 {
> 		reg =3D <0x20>;
> 		       ^^^ This is mdio controller register
>=20
> 		ethernet-phy@2 {
> 			reg =3D <0x2>;
>                               ^^^ This phy's address
> 		};
> 	};
> };

I don't understand MDIO well enough to know the answer - does this
actually solve the problem? It seems to me that the problem is that
mdio.yaml is applied to the mdio-mux node because it matches the pattern
"^mdio(@.*)?" that applies the binding based on node-names. If the
properties in mdio.yaml do not apply to mdio muxes, then the binding
should not be applied and the patch here is only treating a symptom
rather than the actual problem.

=46rom a quick check, I don't see any of the mdio-mux-mmioreg nodes using
the properties from mdio.yaml, so should the binding be applied to them
at all?

Cheers,
Conor.


FWIW, adding a $ after the ? in the pattern I linked would stop the
binding being applied to the mdio-mux nodes, but if something like that
were done, all mdio nodes would need to be checked to ensure they match
the new pattern...


>=20
> Only phy's address is limited to 31 because MDIO bus defination.
>=20
> But CHECK_DTBS report below warning:
>=20
> arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dtb: mdio-mux-emi1@54:
> 	mdio@20:reg:0:0: 32 is greater than the maximum of 31
>=20
> The reason is that "mdio@20" match "patternProperties: '@[0-9a-f]+$'" in
> mdio.yaml.
>=20
> Change to '^(?!mdio@).*@[0-9a-f]+$' to avoid match parent's mdio
> controller's address.
>=20
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  Documentation/devicetree/bindings/net/mdio.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/net/mdio.yaml b/Documentat=
ion/devicetree/bindings/net/mdio.yaml
> index a266ade918ca7..a7def3eb4674d 100644
> --- a/Documentation/devicetree/bindings/net/mdio.yaml
> +++ b/Documentation/devicetree/bindings/net/mdio.yaml
> @@ -59,7 +59,7 @@ properties:
>      type: boolean
> =20
>  patternProperties:
> -  '@[0-9a-f]+$':
> +  '^(?!mdio@).*@[0-9a-f]+$':
>      type: object
> =20
>      properties:
> --=20
> 2.34.1
>=20

--kH+ai/ND89N9wHWS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZro8AgAKCRB4tDGHoIJi
0mPgAP901yLmgljlIK02ytzDSbo3W7Tr4fIWkLT+81cA1NMr3QD+KIz3cHhvDZ3I
JllrKy8z3fObL8klZ02PBpDvChhibQI=
=nO2U
-----END PGP SIGNATURE-----

--kH+ai/ND89N9wHWS--

