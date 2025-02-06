Return-Path: <netdev+bounces-163628-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E1DBA2B11B
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 19:32:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16EEA1886FCB
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 18:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A41DB1AAA11;
	Thu,  6 Feb 2025 18:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EchApnR6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A63819E7F7;
	Thu,  6 Feb 2025 18:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738866286; cv=none; b=R8d/YIeJaJwK5ogkfqWMsehZx25VxN2FpoMuikyEj0718vhmfd8Ef0cSfb3tT9fP1uvigbmcdwON5/7mzjEKZgIlfaWM2mTJB//JVH/rb69e7ImuTIlItIBN0mntyOE32ediBmhPoplXmG2o+Ug4tc8m5tKbeyGWBpeZHg4lVwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738866286; c=relaxed/simple;
	bh=53zJkpFR18b9Ggt/TwIC2xs8XPYRRBAHjr15GY57Wrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lRtUJUjEig+JxDSnyvzyPjUxCSHD4cPLCr7F18Kzo9RF/2KTkIiAyPuu2VYjbezEdMIp5TtvrQdsMK/VUJygxlDxsOFPfPtg+bVsPXQ/escSt+bXmXIVUR4KREG1UJwfKQgRecQ+7TrMWCj4DNyvy70L6clpn5OzRFkwYjqd+Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EchApnR6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A9C7C4CEDD;
	Thu,  6 Feb 2025 18:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738866286;
	bh=53zJkpFR18b9Ggt/TwIC2xs8XPYRRBAHjr15GY57Wrw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EchApnR6LI/AE9zaSEU0xrSO5CJrAIwdYiOYs3nEpROrfkzXVB23aqPS6Tiurf2bl
	 g9FM3C3yDhm8aRh825IAWU+FFnqD90dBqy6sjjWjYWL7BQW6LttgflCdt+oKxa8F1d
	 iSwrD5Z/uxSNpyTw2xFkoLESoir/Z8KjKUeFmriKF7Hqm/63Hwx60SnBoNfMoMnO+3
	 deCndpmR70QViPcvDbgf2IwGciFQ1GcNeHv7mOYXfQZ9D8zWzeew1Pw3cL9OzlGS8V
	 F6wbqCbigrDRVxLTWsZp/x4swPMvR6NOIdWT3lyblAK2/a1uWB3baigFDYYfa2TEsv
	 e3l5RDUubNQjA==
Date: Thu, 6 Feb 2025 18:24:40 +0000
From: Conor Dooley <conor@kernel.org>
To: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
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
Message-ID: <20250206-charbroil-armhole-078069994058@spud>
References: <20250205-airoha-en7581-flowtable-offload-v1-0-d362cfa97b01@kernel.org>
 <20250205-airoha-en7581-flowtable-offload-v1-9-d362cfa97b01@kernel.org>
 <20250205-cleaver-evaluator-648c8f0b99bb@spud>
 <Z6O8-dUrLNmvnW1u@lore-desk>
 <20250205-disagree-motive-517efca2b90c@spud>
 <Z6PPfnYV57NmWV6N@lore-desk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2K4ihKtAKq5vhnGT"
Content-Disposition: inline
In-Reply-To: <Z6PPfnYV57NmWV6N@lore-desk>


--2K4ihKtAKq5vhnGT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 05, 2025 at 09:52:14PM +0100, Lorenzo Bianconi wrote:
> > On Wed, Feb 05, 2025 at 08:33:13PM +0100, Lorenzo Bianconi wrote:
> > > > On Wed, Feb 05, 2025 at 07:21:28PM +0100, Lorenzo Bianconi wrote:
> > > > > Introduce the airoha,npu property for the npu syscon node availab=
le on
> > > > > EN7581 SoC. The airoha Network Processor Unit (NPU) is used to of=
fload
> > > > > network traffic forwarded between Packet Switch Engine (PSE) port=
s.
> > > > >=20
> > > > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > > > > ---
> > > > >  Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml | 8=
 ++++++++
> > > > >  1 file changed, 8 insertions(+)
> > > > >=20
> > > > > diff --git a/Documentation/devicetree/bindings/net/airoha,en7581-=
eth.yaml b/Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml
> > > > > index c578637c5826db4bf470a4d01ac6f3133976ae1a..6388afff64e990a20=
230b0c4e58534aa61f984da 100644
> > > > > --- a/Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml
> > > > > +++ b/Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml
> > > > > @@ -63,6 +63,12 @@ properties:
> > > > >    "#size-cells":
> > > > >      const: 0
> > > > > =20
> > > > > +  airoha,npu:
> > > > > +    $ref: /schemas/types.yaml#/definitions/phandle
> > > > > +    description:
> > > > > +      Phandle to the syscon node used to configure the NPU module
> > > > > +      used for traffic offloading.
> > > >=20
> > > > Why do you need a phandle for this, instead of a lookup by compatib=
le?
> > > > Do you have multiple instances of this ethernet controller on the
> > > > device, that each need to look up a different npu?
> > >=20
> > > actually not, but looking up via the compatible string has been naked=
 by
> > > Krzysztof on a different series [0].
> >=20
> > Hmm, I disagree with adding phandles that are not needed. I don't agree
> > that there's no reuse, if you can treat the phandle identically on a new
> > device, in all likelihood, that node should have a fallback to the
> > existing one.
>=20
> honestly I do not have a strong opinion about it, I am fine both ways.
>=20
> >=20
> > That said, the bigger problem in what you link is the ABI break caused =
by
> > requiring the presence of a new node. I'd NAK that patch too.
>=20
> there is no PCIe support in dts for this device upstream yet, so I guess =
there
> is no ABI break, right?

The binding and driver are upstream and therefore there could be users.
Whether or not the dts is upstream isn't what determines ABI break or not!
If the thing worked before adding the syscon in the PCIe patch you'd linked,
the syscon should remain optional - unless there really are no users
that will be impacted. If it didn't work without the syscon, then I
wonder why it was upstreamed like that at all.

--2K4ihKtAKq5vhnGT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ6T+aAAKCRB4tDGHoIJi
0q4aAQDZ7TcfNn+m4kHVpqE+dO6WwwXPFBYx5ZPAIVaG70FGqwD+L/yuigkFs46b
+PUbXOf0VcC8ooyHGLrQiOQ+p3oOSgA=
=l89c
-----END PGP SIGNATURE-----

--2K4ihKtAKq5vhnGT--

