Return-Path: <netdev+bounces-163222-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A46A299CD
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 20:10:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A948188121C
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 19:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 258421FF1BA;
	Wed,  5 Feb 2025 19:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IW9+39AI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F421FECD4;
	Wed,  5 Feb 2025 19:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738782635; cv=none; b=LSZUKBEDb4hfNPSSq7Mc6EZNxH3ALq2Tbb4BS2FQLR8ODXZgdEYlinT1R8oHOxoYCnlCVj7YNXhsIsQ4CPl5cDER1IlTVi2ojqQJhjuHrKiPegVh+Y0q1EGMFa9LKQiCpQrsTyPbnO8Bjp+hePa2wRlnubXG6VxinHatxodieqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738782635; c=relaxed/simple;
	bh=ETdqFpdQWKnBh+I298fz06UxdSXFr90lIy6URSg4kaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FC4Pxiyw5DkyypyqsKULrC+m4btDmTjQdMvSLsU5kaJ2VfcSP+FZAEk1WpJmxFQYZmTzRZ8UiOZAY3jnK9kEGB1GyJ0XxKaoxHZBdVSjHkMbHsCBNil8QqKOoUH1tgej32MA556udqWyrhkcq0EGg0PQPlLKtGX5s00lCmDAegE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IW9+39AI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19032C4CED1;
	Wed,  5 Feb 2025 19:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738782634;
	bh=ETdqFpdQWKnBh+I298fz06UxdSXFr90lIy6URSg4kaA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IW9+39AID1lcEbXaiCKZIk7Cm+9fGecb98BRFaRHhP9a1Iyi3q9gmTF0VE+8Gqdz6
	 6Gn3MD174LfUMy2NeBzeXsMH66CTU4yWmleh54TGTdYvywqkeSWFULL3UeTmJ4UmpO
	 EhrA66XdJDnwXnJCUSt/+6KbgSDUsy97XJflygurMKjb6jH27FBAJR2IcqHGqzBuQ0
	 rXCqaRMa4d8QxePE6ZYQl2vTvHym5SKVhHHeF/vFQsAe8f+2rML9WgboYcBcubtXzq
	 9gyiIdc5MukId3ZAjg6yjOEwoXCW92eam1wc3FM9/L0LUxgr//JEP52TxjR7MzWPtu
	 IzvlMlC6Gb90g==
Date: Wed, 5 Feb 2025 19:10:28 +0000
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
Message-ID: <20250205-cleaver-evaluator-648c8f0b99bb@spud>
References: <20250205-airoha-en7581-flowtable-offload-v1-0-d362cfa97b01@kernel.org>
 <20250205-airoha-en7581-flowtable-offload-v1-9-d362cfa97b01@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="JnOj/fdaK/Kw9pqY"
Content-Disposition: inline
In-Reply-To: <20250205-airoha-en7581-flowtable-offload-v1-9-d362cfa97b01@kernel.org>


--JnOj/fdaK/Kw9pqY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 05, 2025 at 07:21:28PM +0100, Lorenzo Bianconi wrote:
> Introduce the airoha,npu property for the npu syscon node available on
> EN7581 SoC. The airoha Network Processor Unit (NPU) is used to offload
> network traffic forwarded between Packet Switch Engine (PSE) ports.
>=20
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml=
 b/Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml
> index c578637c5826db4bf470a4d01ac6f3133976ae1a..6388afff64e990a20230b0c4e=
58534aa61f984da 100644
> --- a/Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml
> +++ b/Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml
> @@ -63,6 +63,12 @@ properties:
>    "#size-cells":
>      const: 0
> =20
> +  airoha,npu:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      Phandle to the syscon node used to configure the NPU module
> +      used for traffic offloading.

Why do you need a phandle for this, instead of a lookup by compatible?
Do you have multiple instances of this ethernet controller on the
device, that each need to look up a different npu?

> +
>  patternProperties:
>    "^ethernet@[1-4]$":
>      type: object
> @@ -132,6 +138,8 @@ examples:
>                       <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>,
>                       <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
> =20
> +        airoha,npu =3D <&npu>;
> +
>          #address-cells =3D <1>;
>          #size-cells =3D <0>;
> =20
>=20
> --=20
> 2.48.1
>=20

--JnOj/fdaK/Kw9pqY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ6O3pAAKCRB4tDGHoIJi
0r90AQCPFWieY3rJFPgYre/U5p5JhiHPBES11cYsO6z7cPd7JgD+LbhWNBtMLabp
sVw4Vk5SnTfpxAWmdYRThF4q2n8QHAU=
=ee/X
-----END PGP SIGNATURE-----

--JnOj/fdaK/Kw9pqY--

