Return-Path: <netdev+bounces-163629-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 920D9A2B124
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 19:33:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22C7718813A9
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 18:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BC341B21B7;
	Thu,  6 Feb 2025 18:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NLCjgvCB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A5119AD90;
	Thu,  6 Feb 2025 18:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738866384; cv=none; b=qg4YwvcQhgWHHtU1CnwssuXJEU2xJchQnvCjmTA7HLGH1axNsaY/LDkN2oCmdw7XP3957dMn8SkDwFeUloscCwH6VdyNhf1gat9ignlOlTJ8aA8C5TMpfe+BpcfwOAR/mV//MLOXGZvG3PgvBT9Z/jb0a7WlaTyZNJwkMB02Szs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738866384; c=relaxed/simple;
	bh=zEiLpGTnN6szvqIO03zj6Wy4GsFDV17QfFRszwprihM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=otFNj+9bBjaY+yoExfaoeH6Kx2/wwFWaBi5HKRtXYecjcrhL1+jdb58vKnZIYAYSase2iTREBGxFgfuxg/CyadwO4YsWNhVnTxNGPw6fvkCG//lFSFiLrNnKJ9qFK2S+Zpd8IK+y6Oy6W9I6VqsP2GWXE7ap7UAx/SXh+Pq9c64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NLCjgvCB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37F9AC4CEDD;
	Thu,  6 Feb 2025 18:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738866383;
	bh=zEiLpGTnN6szvqIO03zj6Wy4GsFDV17QfFRszwprihM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NLCjgvCBU5utmTUv/A0sJ4Bl1ywl3snuOUZcQxXnbeZlEky0i3YfrYdMH/uCFxK7T
	 duh+T0WjlAsIjICFUOImtv4h8H5a/O1GC4OFsUSEe6Fs8kOl25ivhH10br5dV2pmrl
	 Sec5GPwylbbHAqOI11XEzRGf0rSI/Quu4pg2gSlUBpEHDCrOvIosc//bmuHT/86oV2
	 GqXlpyQPGmuoPZli7X/WH74lndy5JJexe2qohaFmx63Bm0JnN7PsS7Q0rQwDKvs1WI
	 DxVIdlSYfSzj+1qZY+kz3UlHqr5rvnRXq/nYv196JIW9CiTbvTEpL7cSi9NQ4o1Mfc
	 Q67ALrU4H2owA==
Date: Thu, 6 Feb 2025 18:26:18 +0000
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
Message-ID: <20250206-sabbath-carded-2bd52c03440d@spud>
References: <20250205-airoha-en7581-flowtable-offload-v1-0-d362cfa97b01@kernel.org>
 <20250205-airoha-en7581-flowtable-offload-v1-9-d362cfa97b01@kernel.org>
 <20250205-cleaver-evaluator-648c8f0b99bb@spud>
 <Z6O8-dUrLNmvnW1u@lore-desk>
 <20250205-disagree-motive-517efca2b90c@spud>
 <20250205-patronage-finisher-bbfbdb5b7dbc@spud>
 <Z6PQEzvvCdDKQSnl@lore-desk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/oPBRXOgxxcoZEVI"
Content-Disposition: inline
In-Reply-To: <Z6PQEzvvCdDKQSnl@lore-desk>


--/oPBRXOgxxcoZEVI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 05, 2025 at 09:54:43PM +0100, Lorenzo Bianconi wrote:
> > On Wed, Feb 05, 2025 at 08:01:26PM +0000, Conor Dooley wrote:
> > > On Wed, Feb 05, 2025 at 08:33:13PM +0100, Lorenzo Bianconi wrote:
> > > > > On Wed, Feb 05, 2025 at 07:21:28PM +0100, Lorenzo Bianconi wrote:
> > > > > > Introduce the airoha,npu property for the npu syscon node avail=
able on
> > > > > > EN7581 SoC. The airoha Network Processor Unit (NPU) is used to =
offload
> > > > > > network traffic forwarded between Packet Switch Engine (PSE) po=
rts.
> > > > > >=20
> > > > > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > > > > > ---
> > > > > >  Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml |=
 8 ++++++++
> > > > > >  1 file changed, 8 insertions(+)
> > > > > >=20
> > > > > > diff --git a/Documentation/devicetree/bindings/net/airoha,en758=
1-eth.yaml b/Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml
> > > > > > index c578637c5826db4bf470a4d01ac6f3133976ae1a..6388afff64e990a=
20230b0c4e58534aa61f984da 100644
> > > > > > --- a/Documentation/devicetree/bindings/net/airoha,en7581-eth.y=
aml
> > > > > > +++ b/Documentation/devicetree/bindings/net/airoha,en7581-eth.y=
aml
> > > > > > @@ -63,6 +63,12 @@ properties:
> > > > > >    "#size-cells":
> > > > > >      const: 0
> > > > > > =20
> > > > > > +  airoha,npu:
> > > > > > +    $ref: /schemas/types.yaml#/definitions/phandle
> > > > > > +    description:
> > > > > > +      Phandle to the syscon node used to configure the NPU mod=
ule
> > > > > > +      used for traffic offloading.
> > > > >=20
> > > > > Why do you need a phandle for this, instead of a lookup by compat=
ible?
> > > > > Do you have multiple instances of this ethernet controller on the
> > > > > device, that each need to look up a different npu?
> > > >=20
> > > > actually not, but looking up via the compatible string has been nak=
ed by
> > > > Krzysztof on a different series [0].
> > >=20
> > > Hmm, I disagree with adding phandles that are not needed. I don't agr=
ee
> > > that there's no reuse, if you can treat the phandle identically on a =
new
> > > device, in all likelihood, that node should have a fallback to the
> > > existing one.
> >=20
> > Also, where is the binding for this npu? It looks like a brand-new
> > module that you're adding a driver for in this series and a phandle to
> > the node for here but I see no binding for it.
>=20
> The driver loads the NPU node just as syscon so I have not added the bind=
ing
> for it to the series. I will add it in v2.

I don't think it is "just as syscon", you've got an entire driver for it
that you're loading via the phandle, it's not just some generic syscon that
you're looking up here - at least that's what it seemed like to me after
my scan of the driver patches.

--/oPBRXOgxxcoZEVI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ6T+ygAKCRB4tDGHoIJi
0lDVAP99szIZe8LIhGzbAEpswbE479dnuYBrXx+O1D4nO3LFswEAzPfV05o49+gc
Cw7wCHXzFPQRZM3PDwkaaW819kcBPAw=
=t8sA
-----END PGP SIGNATURE-----

--/oPBRXOgxxcoZEVI--

