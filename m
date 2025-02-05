Return-Path: <netdev+bounces-163228-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE45CA29A26
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 20:34:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 583DD167D06
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 19:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D83F620CCD8;
	Wed,  5 Feb 2025 19:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j0LatF6S"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8FB20C026;
	Wed,  5 Feb 2025 19:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738783996; cv=none; b=ThIw9/63pdPzXbr5PEPY8y6ZY8/DdoTpruGe1js9kxdjoCDdWzn6rXOQuDw7MZgdAZo9cHrM3yZwHoIEaYuXIrdBMOqeq9VV42vtPEWJ2tGj9BjsTPSWFUAp6cXf9PAzcUfhUBWUcQN90t0Bko6WEKLsaf4N3DXZ1mAh8jVvy34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738783996; c=relaxed/simple;
	bh=B/kqz7BMCRcXcNkULlXWbe8rQqpjmskiXpQUTOkxG2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MH4sbamfwb8Cej/sKJe5tA8z0uQokrLxstThqNB3w4N6/OPklrVZ80GHLkGW8ZEFPfxFthk6VRoEiyzcdaeNJzVU1Zrc7t33XaE8mFlf+oaMs7IIFAjAntMeo4CyUfqBloBm6ktIinDkXzhTxNid5ed43e9KnycVRhblcBb1vz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j0LatF6S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9931DC4CED1;
	Wed,  5 Feb 2025 19:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738783996;
	bh=B/kqz7BMCRcXcNkULlXWbe8rQqpjmskiXpQUTOkxG2A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j0LatF6SvEfeeYJE9BNmmmeizE1IeFzFC658QJrATwfK6HNFvVLtJrAkMQtMMNUTj
	 okszOcVt1KpVOzZieCzo1NLZRZflHzBEm2hCN4KoYXqhRSDywgacluxdY7BMG5db3x
	 EteR5UMxvyv3meUlTb+w/IxDbB+Dj/eO5qHxpvLYsEGTgLwsgYIa9O7r0ymes11/2r
	 /ceQUFUrMPdni1DrgeYEGvQQ/f9YSwBCaVz0r7y9OEwT7A5hWkASoGSzEAJcMXQ1PO
	 4E7IgS/cU0UERNM5gFeBk2mPdGvROfdLIox5FUZ76UkNhPj3qJTgYRFHAQbp2nadRb
	 vQmPlv5stGGBw==
Date: Wed, 5 Feb 2025 20:33:13 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
	upstream@airoha.com
Subject: Re: [PATCH net-next 09/13] dt-bindings: net: airoha: Add airoha,npu
 phandle property
Message-ID: <Z6O8-dUrLNmvnW1u@lore-desk>
References: <20250205-airoha-en7581-flowtable-offload-v1-0-d362cfa97b01@kernel.org>
 <20250205-airoha-en7581-flowtable-offload-v1-9-d362cfa97b01@kernel.org>
 <20250205-cleaver-evaluator-648c8f0b99bb@spud>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="OLRYiDtnqR+Ktbpf"
Content-Disposition: inline
In-Reply-To: <20250205-cleaver-evaluator-648c8f0b99bb@spud>


--OLRYiDtnqR+Ktbpf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Wed, Feb 05, 2025 at 07:21:28PM +0100, Lorenzo Bianconi wrote:
> > Introduce the airoha,npu property for the npu syscon node available on
> > EN7581 SoC. The airoha Network Processor Unit (NPU) is used to offload
> > network traffic forwarded between Packet Switch Engine (PSE) ports.
> >=20
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >  Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml | 8 +++++=
+++
> >  1 file changed, 8 insertions(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/net/airoha,en7581-eth.ya=
ml b/Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml
> > index c578637c5826db4bf470a4d01ac6f3133976ae1a..6388afff64e990a20230b0c=
4e58534aa61f984da 100644
> > --- a/Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml
> > +++ b/Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml
> > @@ -63,6 +63,12 @@ properties:
> >    "#size-cells":
> >      const: 0
> > =20
> > +  airoha,npu:
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +    description:
> > +      Phandle to the syscon node used to configure the NPU module
> > +      used for traffic offloading.
>=20
> Why do you need a phandle for this, instead of a lookup by compatible?
> Do you have multiple instances of this ethernet controller on the
> device, that each need to look up a different npu?

actually not, but looking up via the compatible string has been naked by
Krzysztof on a different series [0].

Regards,
Lorenzo

[0] https://patchwork.kernel.org/project/linux-pci/patch/20250115-en7581-pc=
ie-pbus-csr-v1-2-40d8fcb9360f@kernel.org/

>=20
> > +
> >  patternProperties:
> >    "^ethernet@[1-4]$":
> >      type: object
> > @@ -132,6 +138,8 @@ examples:
> >                       <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>,
> >                       <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
> > =20
> > +        airoha,npu =3D <&npu>;
> > +
> >          #address-cells =3D <1>;
> >          #size-cells =3D <0>;
> > =20
> >=20
> > --=20
> > 2.48.1
> >=20



--OLRYiDtnqR+Ktbpf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZ6O8+QAKCRA6cBh0uS2t
rBuDAQC8IfaonQoR+OsBNVLR3QqRP2V9u+fgOgmLkd8nLqxJXgD+LlNv2zJCpRM4
mPz3craYS9w8t05bFQju9tmeKJ0FSQ4=
=7CSn
-----END PGP SIGNATURE-----

--OLRYiDtnqR+Ktbpf--

