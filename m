Return-Path: <netdev+bounces-163240-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B52A29A87
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 21:01:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1E561883345
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 20:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6069E1DE89E;
	Wed,  5 Feb 2025 20:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JPLkhPCg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375551519AD;
	Wed,  5 Feb 2025 20:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738785692; cv=none; b=QrJuHdnidwpi9GgbJGSaE2Jbmewl21fK/qZIgaE0PRkDAtDrTlky3nrPZt4L8Gs5Dp42bqbS6JXbs9VnapJoLYKabqWwhHOjBwXXZySytDlUX1UADmL/vJ77aOXkakaP8TWtZz28pjgs+ugE0csaFROhKNNtHN0n7ccxcnwnRr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738785692; c=relaxed/simple;
	bh=zOnN62hnfOYzsZsZ1yqWDdh3AcKyO5WluPvt8FnYicU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l5O3H6WrKZGP2Ys63xvdOgklOf5AfT8IS3yZbTFOpaU3dv6HeEiJfHCKfN2BmzpZQrEFOAvgf1Z7szrfVwdUA0JYMOYE5+GqZcF4R+Y/tuOFDSWGS6mBXepwUrVtsr2SQH08C14qDi2VE+mUJs3MYxVt2PKGYrYOgjxowXbm+qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JPLkhPCg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA7F6C4CED1;
	Wed,  5 Feb 2025 20:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738785692;
	bh=zOnN62hnfOYzsZsZ1yqWDdh3AcKyO5WluPvt8FnYicU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JPLkhPCgFcstIW6OHk4zmyDv9D3tzA3HND/6+cSNek0HdfolFYop5s6BZUn3En3bZ
	 rem8N/fPzYbxFU63P8N9r1N5yZF3W7f54JomMGeQyiaWmckAQumkuQeWjE1vcn1nWB
	 ixjmLoMJoX6RMCFqmzIYcBay0qaH/iAtijhb04QthI+dscnlheIuypco1Q3UunkUaO
	 dXU6yuL+NHiUNlgraYHUOtZMXZ2TIliSSkalEWTgvY9GDEqynPmZVIXFXhYgYtoRV9
	 0hyG7Jd2+cmR4J+IaOWnjaguuk4MhaI6p2w5o8aCU572qhwPg4iXc9bTLIY/O0jDbE
	 teYhHL8fNV74Q==
Date: Wed, 5 Feb 2025 20:01:26 +0000
From: Conor Dooley <conor@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
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
Message-ID: <20250205-disagree-motive-517efca2b90c@spud>
References: <20250205-airoha-en7581-flowtable-offload-v1-0-d362cfa97b01@kernel.org>
 <20250205-airoha-en7581-flowtable-offload-v1-9-d362cfa97b01@kernel.org>
 <20250205-cleaver-evaluator-648c8f0b99bb@spud>
 <Z6O8-dUrLNmvnW1u@lore-desk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6JLUwNNYYeOqsh0O"
Content-Disposition: inline
In-Reply-To: <Z6O8-dUrLNmvnW1u@lore-desk>


--6JLUwNNYYeOqsh0O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 05, 2025 at 08:33:13PM +0100, Lorenzo Bianconi wrote:
> > On Wed, Feb 05, 2025 at 07:21:28PM +0100, Lorenzo Bianconi wrote:
> > > Introduce the airoha,npu property for the npu syscon node available on
> > > EN7581 SoC. The airoha Network Processor Unit (NPU) is used to offload
> > > network traffic forwarded between Packet Switch Engine (PSE) ports.
> > >=20
> > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > > ---
> > >  Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml | 8 +++=
+++++
> > >  1 file changed, 8 insertions(+)
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/net/airoha,en7581-eth.=
yaml b/Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml
> > > index c578637c5826db4bf470a4d01ac6f3133976ae1a..6388afff64e990a20230b=
0c4e58534aa61f984da 100644
> > > --- a/Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml
> > > +++ b/Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml
> > > @@ -63,6 +63,12 @@ properties:
> > >    "#size-cells":
> > >      const: 0
> > > =20
> > > +  airoha,npu:
> > > +    $ref: /schemas/types.yaml#/definitions/phandle
> > > +    description:
> > > +      Phandle to the syscon node used to configure the NPU module
> > > +      used for traffic offloading.
> >=20
> > Why do you need a phandle for this, instead of a lookup by compatible?
> > Do you have multiple instances of this ethernet controller on the
> > device, that each need to look up a different npu?
>=20
> actually not, but looking up via the compatible string has been naked by
> Krzysztof on a different series [0].

Hmm, I disagree with adding phandles that are not needed. I don't agree
that there's no reuse, if you can treat the phandle identically on a new
device, in all likelihood, that node should have a fallback to the
existing one.

That said, the bigger problem in what you link is the ABI break caused by
requiring the presence of a new node. I'd NAK that patch too.

>=20
> Regards,
> Lorenzo
>=20
> [0] https://patchwork.kernel.org/project/linux-pci/patch/20250115-en7581-=
pcie-pbus-csr-v1-2-40d8fcb9360f@kernel.org/
>=20
> >=20
> > > +
> > >  patternProperties:
> > >    "^ethernet@[1-4]$":
> > >      type: object
> > > @@ -132,6 +138,8 @@ examples:
> > >                       <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>,
> > >                       <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
> > > =20
> > > +        airoha,npu =3D <&npu>;
> > > +
> > >          #address-cells =3D <1>;
> > >          #size-cells =3D <0>;
> > > =20
> > >=20
> > > --=20
> > > 2.48.1
> > >=20
>=20
>=20



--6JLUwNNYYeOqsh0O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ6PDlgAKCRB4tDGHoIJi
0sRCAP9d6SH8K30LUrgTiCNUSGDr2F3QfyW4PrcGQhOC7aQb0gD9GmCcJdrSa90i
ABDTHH6uK3n8fQsIKfLUMyZLM/drUAY=
=pu0V
-----END PGP SIGNATURE-----

--6JLUwNNYYeOqsh0O--

