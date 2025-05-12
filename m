Return-Path: <netdev+bounces-189837-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B63EAB3D5D
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 18:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D89CC1884D8D
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 16:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D1F24EABF;
	Mon, 12 May 2025 16:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qjWDW5ip"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF6F246782;
	Mon, 12 May 2025 16:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747066912; cv=none; b=JahNOFsvfkL4vuiiO2bOP4zTu3FkD0Li2wqeHqSRghqWPCcdh+Y2soNro/0o9+f7qXTgbASef7OddDkQLExlgiszXLcry20Ny5GF1y6Pfo8mLuEgTlnudv2D2d9AlzrkVrOxakO7m03kM9TRQoYxUIRy/tvbSvao22rdYutUHQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747066912; c=relaxed/simple;
	bh=Cw16mLp8GBEQCcOKwuFSOtn+PoZCJYu4QwEC/5THH6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pVUpAHFG6YqOcrUYKIKohocLM6I64QRWtlxg0Jc4pc/pZYHVMhosJNcNSDweJJVTFCYEO4NdmN/hjjjxKOzWr4FTTbg1adzku4NRgzxDMt/Mt0phtKZzh/8q9Titl5ehT/UdG48koBBBjE75BYNxDbrtR7i75LDRKDq/aBwE+2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qjWDW5ip; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E3D0C4CEE7;
	Mon, 12 May 2025 16:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747066912;
	bh=Cw16mLp8GBEQCcOKwuFSOtn+PoZCJYu4QwEC/5THH6Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qjWDW5ipMKXBnBTQnDL//oE57mzcvjgoU1Ton8qgojjwFyPxcD/zG/sLf/+qoX0WA
	 onl7eoXYzFz98ul7cCauOz3vwSqHsjTMNXxy4MHoHFByrilbQ4G9jTZ/dSzd5XRBlq
	 JoPfIQU7+w81uzvYu3dFmIRKPmCaTWTq9D31Lnn704gy42p4Ipyte1Djh82MKghM+d
	 lJri9FOcBdfu27jie/UdYAgPVIehCS1Pmqyq5mrNMpXxxVOcM8CBzesTbQcOolL+JT
	 /aI2JhND0tKPf20Mk8yLGONCN8t52y6fENYrsyoMvnIGT34Ki8SDew58BKGAfMIC7E
	 P+tql2ye6ipcQ==
Date: Mon, 12 May 2025 17:21:45 +0100
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
Message-ID: <20250512-nibble-freemason-69e0279f2f99@spud>
References: <20250511141942.10284-1-linux@fw-web.de>
 <20250511141942.10284-2-linux@fw-web.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="BeH6zc2zJClOlCJ9"
Content-Disposition: inline
In-Reply-To: <20250511141942.10284-2-linux@fw-web.de>


--BeH6zc2zJClOlCJ9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 11, 2025 at 04:19:17PM +0200, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
>=20
> Update binding for mt7988 which has 3 gmac and 2 reg items.
>=20
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
>  Documentation/devicetree/bindings/net/mediatek,net.yaml | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/net/mediatek,net.yaml b/Do=
cumentation/devicetree/bindings/net/mediatek,net.yaml
> index 9e02fd80af83..5d249da02c3a 100644
> --- a/Documentation/devicetree/bindings/net/mediatek,net.yaml
> +++ b/Documentation/devicetree/bindings/net/mediatek,net.yaml
> @@ -28,7 +28,8 @@ properties:
>        - ralink,rt5350-eth
> =20
>    reg:
> -    maxItems: 1
> +    minItems: 1
> +    maxItems: 2

This should become an items list, with an explanation of what each of
the reg items represents.

> =20
>    clocks:
>      minItems: 2
> @@ -381,8 +382,12 @@ allOf:
>              - const: xgp2
>              - const: xgp3
> =20
> +        reg:
> +          minItems: 2
> +          maxItems: 2
> +
>  patternProperties:
> -  "^mac@[0-1]$":
> +  "^mac@[0-2]$":
>      type: object
>      unevaluatedProperties: false
>      allOf:
> --=20
> 2.43.0
>=20

--BeH6zc2zJClOlCJ9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaCIgGQAKCRB4tDGHoIJi
0kdJAQD7lUldL2lyECoq6kz6Xgzpc9L4CU21TH0X3mhKWLc3KAEAkBFq4G5y02M6
M2qDeF8a2MAP3H9Vr3AIiT3T4ZG04gg=
=Vo8k
-----END PGP SIGNATURE-----

--BeH6zc2zJClOlCJ9--

