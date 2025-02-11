Return-Path: <netdev+bounces-165225-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE9CA31192
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 17:33:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1405164F25
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 16:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E4B5256C71;
	Tue, 11 Feb 2025 16:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q1ru+DTz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F7C256C6A;
	Tue, 11 Feb 2025 16:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739291574; cv=none; b=mUcdwYTcbxY68DnvtrNSWYcS++hyew79dRdDEbvd1a8KCN2omyYi1jYm07rYb3c3uvmuInKVui59DePMrXKaPrQ3zYqrpnadYIjOPCnfgLzh2f5cNkAbnnQ/0scWVyWYVmyYggb2BpuHY9IBJ1a2n5lmd+d1FjeN1JFqRLSzTVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739291574; c=relaxed/simple;
	bh=gVBL4F8jU3SJlilexW8hvt6+wtNPSAz34HLk7+XFdww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g++3/eja2TeSN5/6dmw76IXj6NmfZo/U6wkxjt38gBiKGSSkZqePcF2S5GqAIU9zuzv/F5FHebHmb3CoDOosPt+JyXTrA+sJv7y9Ge1yTCVU83LSlgAcTXsRPmKkO7URrLXorKnWBySHpfoUbZJLo8Vs+1EUNVFZaDZy0x99Qfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q1ru+DTz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A5EDC4CEDD;
	Tue, 11 Feb 2025 16:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739291573;
	bh=gVBL4F8jU3SJlilexW8hvt6+wtNPSAz34HLk7+XFdww=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q1ru+DTzVqEPsgCq+7MeCU7Y9eGN/HEfpggxdgyY7Vh0GNULJRF5QK2xI3f0PtPGa
	 56oYv4BgfXoTc1jYeUIcAeLQwRhrf8+T/C7gdBzJJv2XT0u3UbkMxAwi3BOhm4/pPB
	 m9hBfO3Jq0PAlMszXLj1nwei618R6cyJ6w+OuSlpFImcCUaH5MEe7U8lwF21rqT5dx
	 o4sdaDxGAgm6ySmKMfsetSPkHReQhzFTJT/Fka+gbk/OuLt90VA5rm/8er2m5+WeZJ
	 MgOmnKAN9ga7ITrXzQlHTrQIBKDp4BD0cop1Tb56el/oTKWFiXJ1aAxEgRR6yYLKMj
	 55946rlOWNVhg==
Date: Tue, 11 Feb 2025 17:32:51 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
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
	Conor Dooley <conor+dt@kernel.org>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	DENG Qingfang <dqfext@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
	upstream@airoha.com
Subject: Re: [PATCH net-next v3 11/16] dt-bindings: arm: airoha: Add the NPU
 node for EN7581 SoC
Message-ID: <Z6t7s0m1xzsnjAsV@lore-desk>
References: <20250209-airoha-en7581-flowtable-offload-v3-0-dba60e755563@kernel.org>
 <20250209-airoha-en7581-flowtable-offload-v3-11-dba60e755563@kernel.org>
 <20250211-judicious-polite-capuchin-ff8cdf@krzk-bin>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5YUTzFhuFvIYeyt1"
Content-Disposition: inline
In-Reply-To: <20250211-judicious-polite-capuchin-ff8cdf@krzk-bin>


--5YUTzFhuFvIYeyt1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Feb 11, Krzysztof Kozlowski wrote:
> On Sun, Feb 09, 2025 at 01:09:04PM +0100, Lorenzo Bianconi wrote:
> > This patch adds the NPU document binding for EN7581 SoC.
> > The Airoha Network Processor Unit (NPU) provides a configuration interf=
ace
> > to implement wired and wireless hardware flow offloading programming Pa=
cket
> > Processor Engine (PPE) flow table.
> >=20
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >  .../devicetree/bindings/arm/airoha,en7581-npu.yaml | 71 ++++++++++++++=
++++++++
> >  1 file changed, 71 insertions(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/arm/airoha,en7581-npu.ya=
ml b/Documentation/devicetree/bindings/arm/airoha,en7581-npu.yaml
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..a5bcfa299e7cd54f51e70f7=
ded113f1efcd3e8b7
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/arm/airoha,en7581-npu.yaml
>=20
> arm is for top-level nodes, this has to go to proper directory or as
> last-resort to the soc.
>=20
> > @@ -0,0 +1,71 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/arm/airoha,en7581-npu.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Airoha Network Processor Unit for EN7581 SoC
> > +
> > +maintainers:
> > +  - Lorenzo Bianconi <lorenzo@kernel.org>
> > +
> > +description:
> > +  The Airoha Network Processor Unit (NPU) provides a configuration int=
erface
> > +  to implement wired and wireless hardware flow offloading programming=
 Packet
> > +  Processor Engine (PPE) flow table.
>=20
> Sounds like network device, so maybe net?

yes. Do you mean to move it in Documentation/devicetree/bindings/net/ ?

>=20
> > +
> > +properties:
> > +  compatible:
> > +    items:
> > +      - enum:
> > +          - airoha,en7581-npu
> > +      - const: syscon
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 15
>=20
> You need to list the items.

ack, I will fix it.

>=20
> > +
> > +  memory-region:
> > +    maxItems: 1
> > +    description:
> > +      Phandle to the node describing memory used to store NPU firmware=
 binary.
>=20
> s/Phandle to the node describing//

ack, I will fix it.

Regards,
Lorenzo

>=20
> Best regards,
> Krzysztof
>=20

--5YUTzFhuFvIYeyt1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZ6t7sgAKCRA6cBh0uS2t
rEcNAP9MlnGQ2GW0xvg4g0/eolQXH1kOd7wal6bxIySJIMBQNgEAqs/5Z011yWwQ
5DcNR5bUJWyr9AmldMOhCQ88BjX9Vwg=
=rkEw
-----END PGP SIGNATURE-----

--5YUTzFhuFvIYeyt1--

