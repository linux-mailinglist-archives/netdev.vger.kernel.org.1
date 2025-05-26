Return-Path: <netdev+bounces-193467-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 906E5AC427F
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 17:42:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB7897AD76F
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 15:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 751EE21422B;
	Mon, 26 May 2025 15:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JxwMzAve"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4336121421C;
	Mon, 26 May 2025 15:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748273965; cv=none; b=aHPzCEoRqCSMwjGp8edX90JKGIX1vZtdWwnU51PrW/Wf6ZJGTDxa4cFppJEPH6L2EwrW/Dzfx1CdIMIraqTf1tSPyxBhEWl8yZQrtRyaubH6+c/Kaqdd6feyoFt82iV993//hnUcM1mhAIzBF0VQxIJ9Te9x8xBxPoJoFAAdwLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748273965; c=relaxed/simple;
	bh=ch4UlhSRcLszMAM+USq4g6GagJ4v1ZQSXAIVyxnYpP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pN+BY/l+UmxRIpgvtxVnbl+9p0c7sHO/B36y6dwwjJOy2wwsEgPPztzlJtIzYZAO6yK6hsBWhAz1wdpYjIpNaaJTBbk+pbvXs2bK5AFScEM3efMifF5wqaK/R9zaJcn5Ayjj2Lh5uaIZ5Fj/iTH4MYAEcNjZPqbY0OZf8DH0OfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JxwMzAve; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BE02C4CEE7;
	Mon, 26 May 2025 15:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748273964;
	bh=ch4UlhSRcLszMAM+USq4g6GagJ4v1ZQSXAIVyxnYpP4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JxwMzAve0DnXzhNrTgDy2B7VSabV9Vr1C04z2hpBcDGcKwxFjzrAWYbCMlXVsJspD
	 8JOSehSedd7mLgP760iizCeeU6/POxykJBQu9lGounJK9c0UdaNTmSHHNvbLP0j6Oi
	 JmaZowh5N6bKqZAoJVoji7RVu7+jBdBWiXrwyU/CFUyU17yvKozEjFZx6Ape8wNXnx
	 kQdKZuJy2VozzXV9ZT23mMyXoMFhE8K0M3D3A0EF/JorevESI5x2RE4bQKmgNI/CVG
	 Nz+VZ/MfsEQJv5wlU9XHR9O2eGL244MGAFXl/5sZ87iKA+Ff7XcTA0lpPeZbpxjcfx
	 Ue6nRwhqoApyQ==
Date: Mon, 26 May 2025 16:39:19 +0100
From: Conor Dooley <conor@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	"open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"moderated list:ARM/Microchip (AT91) SoC support" <linux-arm-kernel@lists.infradead.org>,
	imx@lists.linux.dev
Subject: Re: [PATCH 1/1] dt-bindings: ieee802154: Convert at86rf230.txt yaml
 format
Message-ID: <20250526-laborer-repackage-0dd6f7730b2c@spud>
References: <20250523154743.545245-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="AX1uLCkW5kwIJMO8"
Content-Disposition: inline
In-Reply-To: <20250523154743.545245-1-Frank.Li@nxp.com>


--AX1uLCkW5kwIJMO8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 23, 2025 at 11:47:39AM -0400, Frank Li wrote:
> Convert at86rf230.txt yaml format.
>=20
> Additional changes:
> - Add ref to spi-peripheral-props.yaml.
> - Add parent spi node in examples.
>=20
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  .../bindings/net/ieee802154/at86rf230.txt     | 27 --------
>  .../net/ieee802154/atmel,at86rf233.yaml       | 65 +++++++++++++++++++
>  2 files changed, 65 insertions(+), 27 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/net/ieee802154/at86=
rf230.txt
>  create mode 100644 Documentation/devicetree/bindings/net/ieee802154/atme=
l,at86rf233.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/net/ieee802154/at86rf230.t=
xt b/Documentation/devicetree/bindings/net/ieee802154/at86rf230.txt
> deleted file mode 100644
> index 168f1be509126..0000000000000
> --- a/Documentation/devicetree/bindings/net/ieee802154/at86rf230.txt
> +++ /dev/null
> @@ -1,27 +0,0 @@
> -* AT86RF230 IEEE 802.15.4 *
> -
> -Required properties:
> -  - compatible:		should be "atmel,at86rf230", "atmel,at86rf231",
> -			"atmel,at86rf233" or "atmel,at86rf212"
> -  - spi-max-frequency:	maximal bus speed, should be set to 7500000 depen=
ds
> -			sync or async operation mode
> -  - reg:		the chipselect index
> -  - interrupts:		the interrupt generated by the device. Non high-level
> -			can occur deadlocks while handling isr.
> -
> -Optional properties:
> -  - reset-gpio:		GPIO spec for the rstn pin
> -  - sleep-gpio:		GPIO spec for the slp_tr pin
> -  - xtal-trim:		u8 value for fine tuning the internal capacitance
> -			arrays of xtal pins: 0 =3D +0 pF, 0xf =3D +4.5 pF
> -
> -Example:
> -
> -	at86rf231@0 {
> -		compatible =3D "atmel,at86rf231";
> -		spi-max-frequency =3D <7500000>;
> -		reg =3D <0>;
> -		interrupts =3D <19 4>;
> -		interrupt-parent =3D <&gpio3>;
> -		xtal-trim =3D /bits/ 8 <0x06>;
> -	};
> diff --git a/Documentation/devicetree/bindings/net/ieee802154/atmel,at86r=
f233.yaml b/Documentation/devicetree/bindings/net/ieee802154/atmel,at86rf23=
3.yaml
> new file mode 100644
> index 0000000000000..275e5e4677a46
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/ieee802154/atmel,at86rf233.ya=
ml
> @@ -0,0 +1,65 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/ieee802154/atmel,at86rf233.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: AT86RF230 IEEE 802.15.4
> +
> +maintainers:
> +  - Frank Li <Frank.Li@nxp.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - atmel,at86rf212
> +      - atmel,at86rf230
> +      - atmel,at86rf231
> +      - atmel,at86rf233
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  reset-gpio:
> +    maxItems: 1
> +
> +  sleep-gpio:
> +    maxItems: 1
> +
> +  spi-max-frequency:
> +    maximum: 7500000
> +
> +  xtal-trim:
> +    $ref: /schemas/types.yaml#/definitions/uint8-array

I think this is just uint8, not an array of uint8s (in which case you'd
be missing constraints on how many?)

> +    description: |
> +      u8 value for fine tuning the internal capacitance
> +      arrays of xtal pins: 0 =3D +0 pF, 0xf =3D +4.5 pF
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    spi {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        zigbee@0 {
> +            compatible =3D "atmel,at86rf231";
> +            reg =3D <0>;
> +            spi-max-frequency =3D <7500000>;
> +            interrupts =3D <19 4>;
> +            interrupt-parent =3D <&gpio3>;
> +            xtal-trim =3D /bits/ 8 <0x06>;
> +        };
> +    };
> --=20
> 2.34.1
>=20

--AX1uLCkW5kwIJMO8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaDSLJwAKCRB4tDGHoIJi
0qV3AQDwD/JHyyrPfgpUbSBTgf1HnrVPkzCoveSe40iVlVWiuQEAhXl0mGpT4VHu
F9AtcPvAsCTjG2v1kpvXN1AAKaU/bAw=
=siVm
-----END PGP SIGNATURE-----

--AX1uLCkW5kwIJMO8--

