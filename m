Return-Path: <netdev+bounces-102327-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88A239026A8
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 18:26:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31F081F26C59
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 16:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3DA414372C;
	Mon, 10 Jun 2024 16:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IiMbKDcM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A661422C5;
	Mon, 10 Jun 2024 16:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718036779; cv=none; b=llHMkgC+kliTwR+ZJJmrIf0lLg4NTS8sIfn3VX4cfBlRPJeGUZIIZUoJR+8NNnaIt8wZ2pFtalYCjUnQE3jy/9QX4jxbpYKMtnHdcCNTB+LizA9piOPrV/Yrv/VSed31N88yWm/qAfPva+nplHAWT9XyxpxOPT7s4JL6cgmiwV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718036779; c=relaxed/simple;
	bh=3UIaTShxInkjQ1pe5ZJloG0WAaJI7u1kBfrsEMbDQZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P5PmWWUG2UyuKO/dpzYqcyQApB6XCwrfTlD+3Q+c8vMA7XhB3Hdb/FrNsve2iZu/RiyFLkhgFUTxLrkuxREw/i/mhIh+FlOBsR2zG0F5SdIoS5UYM0NLVHLXGjYQAgzR38PO+gp147lVtNt/+0t76D3hUe9JrdPIynON40FNCXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IiMbKDcM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A21EC2BBFC;
	Mon, 10 Jun 2024 16:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718036779;
	bh=3UIaTShxInkjQ1pe5ZJloG0WAaJI7u1kBfrsEMbDQZs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IiMbKDcMuesDyvDpScf+uzY9N15WDFL2TEbbvcXbuaDQi4quSO4LZSZgDoHDo+vJf
	 XLXvRyXSb9tKLQwwjW3fO/1ZhK2sixRt88ZKibbFE/keLp9nCivgZRs3+MGJawIKnF
	 RbwW2JEWe1kgbgqp0POECn9HZdpCNM2jQGJv/cBkXYipGs9libJJ50+AHvwyS41xtg
	 qFA3JOqi4msxRDtdliZz+mpChRqxWMC4evZs5SjYuuThDaF6riZJ3UbNDHDpaHsTTw
	 ygnhdXrDTKTOiDIM+OSTyUSNaVjdgZaogn5nJhxzMag6c9P08frv9sf8m6Mk8KA2V3
	 oh2PYNQ5V3Mlw==
Date: Mon, 10 Jun 2024 17:26:13 +0100
From: Conor Dooley <conor@kernel.org>
To: Christophe Roullier <christophe.roullier@foss.st.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Marek Vasut <marex@denx.de>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next,PATCH v6 1/8] dt-bindings: net: add STM32MP13
 compatible in documentation for stm32
Message-ID: <20240610-relay-vanquish-b939690775dc@spud>
References: <20240610071459.287500-1-christophe.roullier@foss.st.com>
 <20240610071459.287500-2-christophe.roullier@foss.st.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="chgm6HB084fcCxg1"
Content-Disposition: inline
In-Reply-To: <20240610071459.287500-2-christophe.roullier@foss.st.com>


--chgm6HB084fcCxg1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 10, 2024 at 09:14:52AM +0200, Christophe Roullier wrote:
> New STM32 SOC have 2 GMACs instances.
> GMAC IP version is SNPS 4.20.
>=20
> Signed-off-by: Christophe Roullier <christophe.roullier@foss.st.com>
> ---
>  .../devicetree/bindings/net/stm32-dwmac.yaml  | 43 ++++++++++++++++---
>  1 file changed, 36 insertions(+), 7 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/net/stm32-dwmac.yaml b/Doc=
umentation/devicetree/bindings/net/stm32-dwmac.yaml
> index 7ccf75676b6d5..f6e5e0626a3fb 100644
> --- a/Documentation/devicetree/bindings/net/stm32-dwmac.yaml
> +++ b/Documentation/devicetree/bindings/net/stm32-dwmac.yaml
> @@ -22,18 +22,17 @@ select:
>          enum:
>            - st,stm32-dwmac
>            - st,stm32mp1-dwmac
> +          - st,stm32mp13-dwmac
>    required:
>      - compatible
> =20
> -allOf:
> -  - $ref: snps,dwmac.yaml#
> -
>  properties:
>    compatible:
>      oneOf:
>        - items:
>            - enum:
>                - st,stm32mp1-dwmac
> +              - st,stm32mp13-dwmac
>            - const: snps,dwmac-4.20a
>        - items:
>            - enum:
> @@ -75,12 +74,15 @@ properties:
>    st,syscon:
>      $ref: /schemas/types.yaml#/definitions/phandle-array
>      items:
> -      - items:
> +      - minItems: 2
> +        items:
>            - description: phandle to the syscon node which encompases the=
 glue register
>            - description: offset of the control register
> +          - description: field to set mask in register
>      description:
>        Should be phandle/offset pair. The phandle to the syscon node which
> -      encompases the glue register, and the offset of the control regist=
er
> +      encompases the glue register, the offset of the control register a=
nd
> +      the mask to set bitfield in control register
> =20
>    st,ext-phyclk:
>      description:
> @@ -112,12 +114,39 @@ required:
> =20
>  unevaluatedProperties: false
> =20
> +allOf:
> +  - $ref: snps,dwmac.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - st,stm32mp1-dwmac
> +              - st,stm32-dwmac
> +    then:
> +      properties:
> +        st,syscon:
> +          items:
> +            minItems: 2
> +            maxItems: 2
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - st,stm32mp13-dwmac
> +    then:
> +      properties:
> +        st,syscon:
> +          items:
> +            minItems: 3
> +            maxItems: 3
> +
>  examples:
>    - |
>      #include <dt-bindings/interrupt-controller/arm-gic.h>
>      #include <dt-bindings/clock/stm32mp1-clks.h>
> -    #include <dt-bindings/reset/stm32mp1-resets.h>
> -    #include <dt-bindings/mfd/stm32h7-rcc.h>

Unrelated change. Otherwise,
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

>      //Example 1
>       ethernet0: ethernet@5800a000 {
>             compatible =3D "st,stm32mp1-dwmac", "snps,dwmac-4.20a";
> --=20
> 2.25.1
>=20

--chgm6HB084fcCxg1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZmcpJQAKCRB4tDGHoIJi
0tffAQDMCZd4Y8qJBiuAkUt0ppGvuLVuiB+9OHGL+/fRrxrGNQD/XXHMOtOGzn7O
9e8VAL9hwogjnLKXF/R6ClOO4Hj/ZgI=
=LIXm
-----END PGP SIGNATURE-----

--chgm6HB084fcCxg1--

