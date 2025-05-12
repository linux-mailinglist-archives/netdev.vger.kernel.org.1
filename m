Return-Path: <netdev+bounces-189892-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A6780AB45E4
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 23:01:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1352A7A3D67
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 21:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0DF0255232;
	Mon, 12 May 2025 21:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TnnkW34r"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823C22AEE1;
	Mon, 12 May 2025 21:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747083678; cv=none; b=U6V7WPa8sewfiZyPHZX49OEvpO4Z8rEh3GqkrmW8ZMXhEmTdwQiwgeaS06tugPBtLxc1TNbxI3B+ZtFpcVe+4d3+1Buwbvhn2USnPOqV6xhiYSm6VRF3jfBuYD+ncS4QZ1kRft34IrbXOMjAYE2d5bbDv43OVZsCYjXE+7Zh0UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747083678; c=relaxed/simple;
	bh=LKLLONeCVjQVAaNx8UdwNrH4MsosiV3gnDGhpSa48kE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OmyXDFkthXPHBGAFP/e/ncxStW5ViGpZOosfv5g6oVVoyaExUvLAfId9u/A95Bgf9ShzCjgqBwLt8zEGUtA96bDI5G7EBKvAJez4wSiKGNr8YzARmT29KEwJ8awxGxv6V0mViYzFksjEL1GKt4CULHeBNfFgSKSgORW4hTHL8D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TnnkW34r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52D88C4CEE7;
	Mon, 12 May 2025 21:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747083676;
	bh=LKLLONeCVjQVAaNx8UdwNrH4MsosiV3gnDGhpSa48kE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TnnkW34rYr5Yyflxu0il8Q6hxkNKCrMwwjOkRS9FklhqXnePrp6HXUjGqvpL4XveL
	 0TQtB92rfaDcCOH9e1pk1D4ic/agrs6hwpXMPFHudeKeZfQv6yDSJqQ/pKThu+ODJl
	 +ZLPwdtj02aYTXg3oHIzEKxV4sVVl8qKceifsWcIwomKVeXCId61MWxQOtp6u4lRVv
	 CgKLLVTRCdXXttrvq7J0fBw19etyehXiK43NerTW3Pka1615TKQTSJ1dvAKD0XCPLK
	 Z5sSDHt4VOVGJ821FN9XRSa6rlwy8iN4fBlbq+MKhSamPyjSZ1KDZxsM+b72sDA1k6
	 U3GTEQA7oIZDA==
Date: Mon, 12 May 2025 22:01:10 +0100
From: Conor Dooley <conor@kernel.org>
To: Frank Wunderlich <linux@fw-web.de>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Frank Wunderlich <frank-w@public-files.de>,
	=?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
	Landen Chao <Landen.Chao@mediatek.com>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>, Felix Fietkau <nbd@nbd.name>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v1 01/14] dt-bindings: net: mediatek,net: update for
 mt7988
Message-ID: <20250512-spooky-overbuilt-abc946ba1f55@spud>
References: <20250511141942.10284-1-linux@fw-web.de>
 <20250511141942.10284-2-linux@fw-web.de>
 <20250512-nibble-freemason-69e0279f2f99@spud>
 <05760B5E-955E-4E0E-9B69-E762783CC37B@fw-web.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ihom2EqWEYhuIF8/"
Content-Disposition: inline
In-Reply-To: <05760B5E-955E-4E0E-9B69-E762783CC37B@fw-web.de>


--ihom2EqWEYhuIF8/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 12, 2025 at 07:33:22PM +0200, Frank Wunderlich wrote:
> Am 12. Mai 2025 18:21:45 MESZ schrieb Conor Dooley <conor@kernel.org>:
> >On Sun, May 11, 2025 at 04:19:17PM +0200, Frank Wunderlich wrote:
> >> From: Frank Wunderlich <frank-w@public-files.de>
> >>=20
> >> Update binding for mt7988 which has 3 gmac and 2 reg items.
> >>=20
> >> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> >> ---
> >>  Documentation/devicetree/bindings/net/mediatek,net.yaml | 9 +++++++--
> >>  1 file changed, 7 insertions(+), 2 deletions(-)
> >>=20
> >> diff --git a/Documentation/devicetree/bindings/net/mediatek,net.yaml b=
/Documentation/devicetree/bindings/net/mediatek,net.yaml
> >> index 9e02fd80af83..5d249da02c3a 100644
> >> --- a/Documentation/devicetree/bindings/net/mediatek,net.yaml
> >> +++ b/Documentation/devicetree/bindings/net/mediatek,net.yaml
> >> @@ -28,7 +28,8 @@ properties:
> >>        - ralink,rt5350-eth
> >> =20
> >>    reg:
> >> -    maxItems: 1
> >> +    minItems: 1
> >> +    maxItems: 2
> >
> >This should become an items list, with an explanation of what each of
> >the reg items represents.
>=20
> I would change to this
>=20
>   reg:
>     items:
>       - description: Register for accessing the MACs.
>       - description: SoC internal SRAM used for DMA operations.
>     minItems: 1
>=20
> Would this be OK this way?

Ye, that looks good.

>=20
> >> =20
> >>    clocks:
> >>      minItems: 2
> >> @@ -381,8 +382,12 @@ allOf:
> >>              - const: xgp2
> >>              - const: xgp3
> >> =20
> >> +        reg:
> >> +          minItems: 2
> >> +          maxItems: 2

You also shouldn't need to set maxItems here, since the list has 2 items
total.

> >> +
> >>  patternProperties:
> >> -  "^mac@[0-1]$":
> >> +  "^mac@[0-2]$":
> >>      type: object
> >>      unevaluatedProperties: false
> >>      allOf:
> >> --=20
> >> 2.43.0
> >>=20
>=20
> Hi Conor
>=20
> Thank you for review.
> regards Frank

--ihom2EqWEYhuIF8/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaCJhlgAKCRB4tDGHoIJi
0np2AP9tRdqvR8H53faGqXax224YS7YArSQXFuynwo25eICEhgEAntebUayynsz/
+miUO3kJllRjEAYIKIHnvI4YCHk0Wws=
=8MP/
-----END PGP SIGNATURE-----

--ihom2EqWEYhuIF8/--

