Return-Path: <netdev+bounces-149779-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE4EA9E767B
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 17:54:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95D9B188289F
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 16:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 394A01F3D5D;
	Fri,  6 Dec 2024 16:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VyJ8LGjg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA9C206271;
	Fri,  6 Dec 2024 16:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733504045; cv=none; b=b3aHeIc15qGniI94SX37PzVbK+ks0MUlkqyhIVcPYMlw86/yOF5qLRxJkLuuhBDkbpvmc2L6WfwiPNx7CtcyBc08VSkukZC8eEXT25qJOs7U6pFa/nF2hOCUq1LNgKrewjlHWTvnmszYDlHZ0eVYtuBKaowKFXgnAPpJqEXg9Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733504045; c=relaxed/simple;
	bh=YDomNLDNajdoJ1pBaUnkgQgWUUdvwDEczy/rTy2dTbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vGfYKsC6gncvvSZ+I7JXY/7P4oVVEgnZ4P67IPV22CykNzlM8DTtLTLdMeXOkkYfzRYLPRNPpPt0b40eGk6SGEmfBivTQThxKS2tDMbbzlYxGrf4VPwgrPIk4TMsXpyAeNGXd6wNfkvZ4tHLmWdSfuXWb0d8RrgSXgXzC7X0zbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VyJ8LGjg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EEB6C4CED1;
	Fri,  6 Dec 2024 16:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733504044;
	bh=YDomNLDNajdoJ1pBaUnkgQgWUUdvwDEczy/rTy2dTbU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VyJ8LGjgKsTP180BTd2aZsogaMbr5GsUU5SD/4TEZb0FoWaezrs6XOcxMKOA5ig/5
	 Hpcx+1bUEu3JiDO12HHydxvzvQtj8gSVNKtCPhsH/UY2gnyjLswYuoXLCyHGrj0qwk
	 n7iIi1BAOOPZta+iWiKCJzYH2KARp1qZqUOgKPhPEU2fKuxGCdEjsX9oG7GIIuLok+
	 RDlXQphub6Cj6UvMvjzhQ+bvMw2daLcMOEmxN+gLXs8bGcK/34UHzgyuihOrkvU6YD
	 FKQEDPDqKKBCNuL8al67YQ1tltwI1ro/vVjGxxqzoMpIxZqkOajSKXRa1yPO7aoJn0
	 GWt0pDvpx0dCw==
Date: Fri, 6 Dec 2024 16:53:59 +0000
From: Conor Dooley <conor@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Woojung Huh <woojung.huh@microchip.com>, Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, kernel@pengutronix.de,
	devicetree@vger.kernel.org, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-kernel@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH v1 2/5] dt-bindings: vendor-prefixes: Add prefix for Priva
Message-ID: <20241206-juncture-copier-97c30459c041@spud>
References: <20241205125640.1253996-1-o.rempel@pengutronix.de>
 <20241205125640.1253996-3-o.rempel@pengutronix.de>
 <20241205-hamstring-mantis-b8b3a25210ef@spud>
 <Z1KV9bCW0iafJ2hF@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="d/WfSM3/k/7/bMv1"
Content-Disposition: inline
In-Reply-To: <Z1KV9bCW0iafJ2hF@pengutronix.de>


--d/WfSM3/k/7/bMv1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 06, 2024 at 07:13:09AM +0100, Oleksij Rempel wrote:
> On Thu, Dec 05, 2024 at 05:16:14PM +0000, Conor Dooley wrote:
> > On Thu, Dec 05, 2024 at 01:56:37PM +0100, Oleksij Rempel wrote:
> > > Introduce the 'pri' vendor prefix for Priva, a company specializing in
> > > sustainable solutions for building automation, energy, and climate
> > > control.  More information about Priva can be found at
> > > https://www.priva.com
> > >=20
> > > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > > ---
> > >  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b=
/Documentation/devicetree/bindings/vendor-prefixes.yaml
> > > index da01616802c7..9a9ac3adc5ef 100644
> > > --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> > > +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> > > @@ -1198,6 +1198,8 @@ patternProperties:
> > >      description: Primux Trading, S.L.
> > >    "^probox2,.*":
> > >      description: PROBOX2 (by W2COMP Co., Ltd.)
> > > +  "^pri,.*":
> > > +    description: Priva
> >=20
> > Why not "priva"? Saving two chars doesn't seem worth less info.
>=20
> This is typical prefix which is used by this vendor, if it is possible
> i would prefer not to change it. But, last decision is on your side :)

I dunno, think if I was being unreasonable like that people would tell
me where to go.
Acked-by: Conor Dooley <conor.dooley@microchip.com>

--d/WfSM3/k/7/bMv1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ1MsJwAKCRB4tDGHoIJi
0q7+AP0WgVVYCgxQgsALCbzKmK4HISYQEtJkGhxbcC8rwUd3TAEAwBQ/eBKPr4RW
KuUnP3OeYJ7cqKeQXBHhBYkRbSC5gg4=
=wzoa
-----END PGP SIGNATURE-----

--d/WfSM3/k/7/bMv1--

