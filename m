Return-Path: <netdev+bounces-163665-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49EE5A2B369
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 21:32:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5946C7A2D23
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 20:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B03541D47B5;
	Thu,  6 Feb 2025 20:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nmG54vlz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C24A2D;
	Thu,  6 Feb 2025 20:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738873928; cv=none; b=C00oyjkMtJM/JAlQJoMeZzDYgKOuOMTQTl9UbB4pXrGWX13LMSJjDSOuB7YWCpi1O9nnu+meaRlUliVJxBtVeFNZ0CUdsCwy+m7YOQu/d1O9HAtUBzs6A11t3sPae2DFN6SK6Fr4weDt2oc3ZkO4qCuKlYNm2yOzHUgpKtjJnYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738873928; c=relaxed/simple;
	bh=8++XfkeoGTNTrOI9Lv+WUaBkvALFfxwEBpO7jocNRuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fm18m3FR+LA0agwoNeDhMAI7in+iYXkJtSOk/xH4ZjfhAoDwMO6DCKhDfLU0Ww8yg9DTPO4bdf9sT0/Uz663+aicLtgjvtWYKvjXW9mCsEITxjPdjDVtJvUgF9i1HyWjHPVHdaaAGToOGiiGkGOrzcEjPLjZAw6f3Hgj+aTLs0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nmG54vlz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4A34C4CEDD;
	Thu,  6 Feb 2025 20:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738873928;
	bh=8++XfkeoGTNTrOI9Lv+WUaBkvALFfxwEBpO7jocNRuI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nmG54vlzC1bt1aRdUOQzfumbyhGlfb21qRuMJhXeYPFF1oMw2+7jCmbrO2wyUHexJ
	 utnZ3E3MxKRRmhVaMXZqWRGM013iABImXjkuf+ZgJ1P2+rmPRHT7hmG67fCyI2nR9S
	 x4I3rm1jEseTWanEkQI+exbcLNZ7H9jbrvXB6/CQ6FEs2ZNe+tS6u0Vcdl4KbPfrBJ
	 zunfJ76KNiJlG6oErceWoE+qXLCYVGMYf0EIFFkWqcdRL4JOlq4BohxDsWWloBJoi1
	 WBXlvN4EwHH9Yp66eeAjRG9vCs9yGFCxEdAeYzImhvQMsDbAmvmx/3E75RdfVyTAq9
	 dwVxljhMlkVcA==
Date: Thu, 6 Feb 2025 21:32:05 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
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
Message-ID: <Z6UcRRaLmUSvWS9Y@lore-desk>
References: <20250205-airoha-en7581-flowtable-offload-v1-0-d362cfa97b01@kernel.org>
 <20250205-airoha-en7581-flowtable-offload-v1-9-d362cfa97b01@kernel.org>
 <20250205-cleaver-evaluator-648c8f0b99bb@spud>
 <Z6O8-dUrLNmvnW1u@lore-desk>
 <20250205-disagree-motive-517efca2b90c@spud>
 <20250205-patronage-finisher-bbfbdb5b7dbc@spud>
 <Z6PQEzvvCdDKQSnl@lore-desk>
 <20250206-sabbath-carded-2bd52c03440d@spud>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zvsYUP/vzkaeMiCQ"
Content-Disposition: inline
In-Reply-To: <20250206-sabbath-carded-2bd52c03440d@spud>


--zvsYUP/vzkaeMiCQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Wed, Feb 05, 2025 at 09:54:43PM +0100, Lorenzo Bianconi wrote:
> > > On Wed, Feb 05, 2025 at 08:01:26PM +0000, Conor Dooley wrote:
> > > > On Wed, Feb 05, 2025 at 08:33:13PM +0100, Lorenzo Bianconi wrote:
> > > > > > On Wed, Feb 05, 2025 at 07:21:28PM +0100, Lorenzo Bianconi wrot=
e:
> > > > > > > Introduce the airoha,npu property for the npu syscon node ava=
ilable on
> > > > > > > EN7581 SoC. The airoha Network Processor Unit (NPU) is used t=
o offload
> > > > > > > network traffic forwarded between Packet Switch Engine (PSE) =
ports.
> > > > > > >=20
> > > > > > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > > > > > > ---
> > > > > > >  Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml=
 | 8 ++++++++
> > > > > > >  1 file changed, 8 insertions(+)
> > > > > > >=20
> > > > > > > diff --git a/Documentation/devicetree/bindings/net/airoha,en7=
581-eth.yaml b/Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml
> > > > > > > index c578637c5826db4bf470a4d01ac6f3133976ae1a..6388afff64e99=
0a20230b0c4e58534aa61f984da 100644
> > > > > > > --- a/Documentation/devicetree/bindings/net/airoha,en7581-eth=
=2Eyaml
> > > > > > > +++ b/Documentation/devicetree/bindings/net/airoha,en7581-eth=
=2Eyaml
> > > > > > > @@ -63,6 +63,12 @@ properties:
> > > > > > >    "#size-cells":
> > > > > > >      const: 0
> > > > > > > =20
> > > > > > > +  airoha,npu:
> > > > > > > +    $ref: /schemas/types.yaml#/definitions/phandle
> > > > > > > +    description:
> > > > > > > +      Phandle to the syscon node used to configure the NPU m=
odule
> > > > > > > +      used for traffic offloading.
> > > > > >=20
> > > > > > Why do you need a phandle for this, instead of a lookup by comp=
atible?
> > > > > > Do you have multiple instances of this ethernet controller on t=
he
> > > > > > device, that each need to look up a different npu?
> > > > >=20
> > > > > actually not, but looking up via the compatible string has been n=
aked by
> > > > > Krzysztof on a different series [0].
> > > >=20
> > > > Hmm, I disagree with adding phandles that are not needed. I don't a=
gree
> > > > that there's no reuse, if you can treat the phandle identically on =
a new
> > > > device, in all likelihood, that node should have a fallback to the
> > > > existing one.
> > >=20
> > > Also, where is the binding for this npu? It looks like a brand-new
> > > module that you're adding a driver for in this series and a phandle to
> > > the node for here but I see no binding for it.
> >=20
> > The driver loads the NPU node just as syscon so I have not added the bi=
nding
> > for it to the series. I will add it in v2.
>=20
> I don't think it is "just as syscon", you've got an entire driver for it
> that you're loading via the phandle, it's not just some generic syscon th=
at
> you're looking up here - at least that's what it seemed like to me after
> my scan of the driver patches.

ack, fine. I will add binding for it in v2.

Regards,
Lorenzo

--zvsYUP/vzkaeMiCQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZ6UcRQAKCRA6cBh0uS2t
rCzfAQD0HAk5INsFs2L2kyrtH38gO74kQpiDIptn5lb5dfb+IgEAwlmjHSO5IZEc
WKie0fs9KqDUq4KwzBlYR3b1Ae7nDgw=
=AbnL
-----END PGP SIGNATURE-----

--zvsYUP/vzkaeMiCQ--

