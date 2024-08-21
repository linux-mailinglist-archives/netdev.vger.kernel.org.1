Return-Path: <netdev+bounces-120662-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D420795A216
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 17:57:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 899821F222CA
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 15:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA44414F131;
	Wed, 21 Aug 2024 15:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XUVpGx0P"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8DF364D6;
	Wed, 21 Aug 2024 15:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724255496; cv=none; b=T68qlpp5LuEJLk6qAykbFDJZjV0iG7M63NkZiQivXGY1ki7UUEcrnWa1TAUIgzsL5XHmQja+UjG1rupfUSMb9AwyfRzmegfr4tiB+r6nW/SPr8Z0JHJotZ+14ewzIHQkyYy0NAXLzdB60nom1QaTsoYEbny/QGsyGfMM4+vNaQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724255496; c=relaxed/simple;
	bh=LvfsOPV5WTTE/9i+sY57uXAFjDrQxLeMEwlGd8FRtwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CyRgzcZAjQdALBRLs2mybbwi0twUsTl1FmQff1YwAVOaNwDXibhU6teI/EyCeRcskpwRrszgnZww3aAd+T5mgtLcUXkvncsQto/QObCcNN4GrruvPeQowxybR7VYc4VP0vAmEOK50QZyu6TqSXWXsSyidngOKGwiqCxwpKK20dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XUVpGx0P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52C9AC32781;
	Wed, 21 Aug 2024 15:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724255496;
	bh=LvfsOPV5WTTE/9i+sY57uXAFjDrQxLeMEwlGd8FRtwo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XUVpGx0PTpZcfj0k8iP4WRODu2/t5/Trj774++85nyLg4eTeATNjQ9YDXKssM5c6K
	 ZlACrP2GJsUDbzsg1uATXVdmBZ3bcMg5TS8EFNEn4iM3RbywM0Xb4+9WI5y0LQsZTF
	 P2m0cSrzlxDKd4NyixaRIlHKC9dmG2UsvG2KeHaKjyEBD3EyUzG2E17nQNGu5qmiwI
	 zV+M8ILlEb/p9l9EEFz8eeNEnwKVpQcxAPZY7HghxqVdECTA0/viEgxpykZsIJZJQc
	 9gW61ho5pJl8nJnGgN60j1fGXTRqaM1Dvly05uQIcTf3oTPhKcKaLAe0vg73bvQwI/
	 a5QaZcZ/02+YA==
Date: Wed, 21 Aug 2024 16:51:30 +0100
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
	Russell King <rmk+kernel@armlinux.org.uk>,
	Chad Monroe <chad.monroe@adtran.com>,
	John Crispin <john@phrozen.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] dt-bindings: net: marvell,aquantia: add
 properties to override MDI_CFG
Message-ID: <20240821-unbalance-postage-8d232da0ed18@spud>
References: <5173302f9f1a52d7487e1fb54966673c448d6928.1724244281.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="XauK46RmXEaQfOa2"
Content-Disposition: inline
In-Reply-To: <5173302f9f1a52d7487e1fb54966673c448d6928.1724244281.git.daniel@makrotopia.org>


--XauK46RmXEaQfOa2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2024 at 01:46:30PM +0100, Daniel Golle wrote:
> Usually the MDI pair order reversal configuration is defined by
> bootstrap pin MDI_CFG. Some designs, however, require overriding the MDI
> pair order and force either normal or reverse order.

Is that a PC way of saying that someone messed up and wired the pins
incorrectly? A concrete example of why this is required would be good ;)

>=20
> Add properties 'marvell,force-mdi-order-normal' and
> 'marvell,force-mdi-order-reverse' for that purpose.
>=20
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>  .../devicetree/bindings/net/marvell,aquantia.yaml      | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/net/marvell,aquantia.yaml =
b/Documentation/devicetree/bindings/net/marvell,aquantia.yaml
> index 9854fab4c4db0..c82d0be48741d 100644
> --- a/Documentation/devicetree/bindings/net/marvell,aquantia.yaml
> +++ b/Documentation/devicetree/bindings/net/marvell,aquantia.yaml
> @@ -48,6 +48,16 @@ properties:
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

These properties are mutually exclusive, right? If so, the binding
should enforce that.

Thanks,
Conor.

> +
>    nvmem-cells:
>      description: phandle to the firmware nvmem cell
>      maxItems: 1
> --=20
> 2.46.0

--XauK46RmXEaQfOa2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZsYNAgAKCRB4tDGHoIJi
0uv4AP4sDFx+0OHGsYIGxFsOqVNv+LbfrlrzN534UARau8+OvwEA8P7JcMGBXVXP
EWBoanCGKqZLwKAWVd/rnpU+b5c7WAk=
=rFet
-----END PGP SIGNATURE-----

--XauK46RmXEaQfOa2--

