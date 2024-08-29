Return-Path: <netdev+bounces-123406-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DCBE8964BA0
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 18:25:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 941841F219BA
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 16:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC6D1B1519;
	Thu, 29 Aug 2024 16:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NtBxUhC0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8741B143B;
	Thu, 29 Aug 2024 16:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724948704; cv=none; b=etu6JywDWsztMLp2yOvFCy2zNL/mM3lU1J8y4FOrunRD4uc0fLRxVc+r0rQRRsCKSMGzD5wKzL2SSAdlxP1D2nWqxlMVbpfGEIUWuqnaPFMY5dyinZxiYDU9MhkBEmW9u5HatiL5XZEnv7QVcc+k2aP6AkoCPRD4EFFp9Oz+ucg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724948704; c=relaxed/simple;
	bh=aIRMgxzY9VHypLBoBhrhOUcrNQ0EeIWs2yI9DRC/ANs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uWPHoTPAnldfONR80Rn+GnPniOkaqI7nzYoFkxIG0qPQ+CgFuKABsRJT9F5IimUcM8lYpmrEfirPoVkLUPMvFVzV540VCUEy4XKD5M+QBiMyMvcRkHotbsCXXpNbRyx/1WzNWIV9W3tH4P81a3S8SSl6NIVZJK8B1xzcWNoq0nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NtBxUhC0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8EBFC4CEC1;
	Thu, 29 Aug 2024 16:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724948704;
	bh=aIRMgxzY9VHypLBoBhrhOUcrNQ0EeIWs2yI9DRC/ANs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NtBxUhC0Ppo4OIgaJyKp95Z3pSCFKfWD4JbRHlPulBv/E3I8b7UuamuCHDbbhziIz
	 Vrtm82pn4dFOh1V3jxUsh8LybIGOwvSPahmM+MBjoRzt+dXtuXWl1dEbVef5oiM61N
	 D+u13Gz+eRYIIJ+Eys8mCwzXUu8TqUjB3FH/tuyCxTLMKa9FqaLab3YuNY3iK4u7AJ
	 eo4fguoIPqKtseZRtdwruROD/tMpVTUWQyiDXcgXsTDRHstLeo93IXGMLEAt9NQQcU
	 tDLU6c5loqM6bAMsgBHxJ1uvyXbHtwYJc+s9jExAaYR0TKbEXP2hyHJpcppLs+bgSd
	 eXCP4N2Fd/row==
Date: Thu, 29 Aug 2024 17:24:58 +0100
From: Conor Dooley <conor@kernel.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Robert Marko <robimarko@gmail.com>,
	Russell King <rmk+kernel@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/2] dt-bindings: net: marvell,aquantia: add
 properties to override MDI_CFG
Message-ID: <20240829-karate-fidgeting-1cff7773e213@spud>
References: <1cdfd174d3ac541f3968dfe9bd14d5b6b28e4ac6.1724885333.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="VC6WfCv/B70e6pcU"
Content-Disposition: inline
In-Reply-To: <1cdfd174d3ac541f3968dfe9bd14d5b6b28e4ac6.1724885333.git.daniel@makrotopia.org>


--VC6WfCv/B70e6pcU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2024 at 11:51:49PM +0100, Daniel Golle wrote:
> Usually the MDI pair order reversal configuration is defined by
> bootstrap pin MDI_CFG. Some designs, however, require overriding the MDI
> pair order and force either normal or reverse order.
>=20
> Add mutually exclusive properties 'marvell,force-mdi-order-normal' and
> 'marvell,force-mdi-order-reverse' for that purpose.
>=20
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
> v2: enforce mutually exclusive relationship of the two new properties in
>     dt-schema.
>=20
>  .../bindings/net/marvell,aquantia.yaml           | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/net/marvell,aquantia.yaml =
b/Documentation/devicetree/bindings/net/marvell,aquantia.yaml
> index 9854fab4c4db0..03b0cff239f70 100644
> --- a/Documentation/devicetree/bindings/net/marvell,aquantia.yaml
> +++ b/Documentation/devicetree/bindings/net/marvell,aquantia.yaml
> @@ -22,6 +22,12 @@ description: |
> =20
>  allOf:
>    - $ref: ethernet-phy.yaml#
> +  - if:
> +      required:
> +        - marvell,force-mdi-order-normal
> +    then:
> +      properties:
> +        marvell,force-mdi-order-reverse: false

Ordinarily, when there are property related constraints in here, the
allOf is moved after the property definitions, since it is odd to talk
about rules for properties prior to defining them. If you resend, please
move these down. Otherwise,
Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> =20
>  select:
>    properties:
> @@ -48,6 +54,16 @@ properties:
>    firmware-name:
>      description: specify the name of PHY firmware to load
> =20
> +  marvell,force-mdi-order-normal:
> +    type: boolean
> +    description:
> +      force normal order of MDI pairs, overriding MDI_CFG bootstrap pin.
> +
> +  marvell,force-mdi-order-reverse:
> +    type: boolean
> +    description:
> +      force reverse order of MDI pairs, overriding MDI_CFG bootstrap pin.
> +
>    nvmem-cells:
>      description: phandle to the firmware nvmem cell
>      maxItems: 1
> --=20
> 2.46.0

--VC6WfCv/B70e6pcU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZtCg2gAKCRB4tDGHoIJi
0tnvAQCDBKHcbN/YG2e1cKXa0oPfS+icXiqepZZXx+QJBrrJGQD9EOsgRZ4KAYzH
3PWvuEgEZuNBrh8pVJ3APVi1azlqsAA=
=oi4j
-----END PGP SIGNATURE-----

--VC6WfCv/B70e6pcU--

