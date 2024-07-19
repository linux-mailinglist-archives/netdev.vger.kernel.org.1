Return-Path: <netdev+bounces-112240-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A5F2937963
	for <lists+netdev@lfdr.de>; Fri, 19 Jul 2024 16:56:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44F58282D6D
	for <lists+netdev@lfdr.de>; Fri, 19 Jul 2024 14:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C8813D63B;
	Fri, 19 Jul 2024 14:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b3vnIZ8m"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDBD286A8;
	Fri, 19 Jul 2024 14:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721400957; cv=none; b=WqA8PqXe8Ol5+xD05WbBfhEVY81rrW0vYsJMsAfpb+G8tZliacyFkqSVow6JWIxF07hGnrG/uG1O6VKWCxgHZBm6V4vLmsBA50p2OYheKph4nFlnrcomsMTU9ge/Oq18V2MJS4XQY912Z024TJi04LRBub4u63otSWbXCWVOUSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721400957; c=relaxed/simple;
	bh=lu59uYU0WnGy1qbfbU5Y7HhfciugVzMFGwazTtthuG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OQNRANucasTcEowXnyBM7LWjun+L6NO7j7a3he0eTsfjUG3v/00ZJTOSJmOsC1Xwov8bpCuhtd+c62smFcMixl6k9yOZxDD67Zjw32ZKOHFQNbMMhD12RRCEzU3vio0+OoC3ebMPRUtk3c0R9zZEd9F1n6/gdkaJWLaELR75Vp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b3vnIZ8m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7259C32782;
	Fri, 19 Jul 2024 14:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721400956;
	bh=lu59uYU0WnGy1qbfbU5Y7HhfciugVzMFGwazTtthuG0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b3vnIZ8md2riZL4osy/8UIw3DsJmyGnM2np2usW2hiUWasZcYLG/82gGHNpHo/oRt
	 wTCW9+NuJVhNQh5131NeAPKjoIJLQOeXLEw8vPfdiCGWXXpf4xqXm+uz5HLjU1RSGC
	 QctOByYGuZdlTbsCtuq4AIbwUMHejW60vK3kMInVPZp9Q3QdCXTj6rJriTIUC9enR9
	 4ich4P54IucgLtiQT/L09Xk7aN/PiP5s3o7v/5Mi9iKPKRNsshlvNQ30g1AoVpipBH
	 HQMHhTYpE+j4sbmBQtrLUSu9SFR166ln3GOgvVCFDqj/34N655JZNhkJf1t0FIQziG
	 4aT4dJWneA4GA==
Date: Fri, 19 Jul 2024 15:55:50 +0100
From: Conor Dooley <conor@kernel.org>
To: Ayush Singh <ayush@beagleboard.org>
Cc: jkridner@beagleboard.org, robertcnelson@beagleboard.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>, Johan Hovold <johan@kernel.org>,
	Alex Elder <elder@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	greybus-dev@lists.linaro.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/3] dt-bindings: net: ti,cc1352p7: Add boot-gpio
Message-ID: <20240719-scuttle-strongbox-e573441c45e6@spud>
References: <20240719-beagleplay_fw_upgrade-v1-0-8664d4513252@beagleboard.org>
 <20240719-beagleplay_fw_upgrade-v1-1-8664d4513252@beagleboard.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tlfsPXEPQCAYZx+O"
Content-Disposition: inline
In-Reply-To: <20240719-beagleplay_fw_upgrade-v1-1-8664d4513252@beagleboard.org>


--tlfsPXEPQCAYZx+O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 19, 2024 at 03:15:10PM +0530, Ayush Singh wrote:
> boot-gpio (along with reset-gpio) is used to enable bootloader backdoor
> for flashing new firmware.
>=20
> The pin and pin level to enabel bootloader backdoor is configed using
> the following CCFG variables in cc1352p7:
> - SET_CCFG_BL_CONFIG_BL_PIN_NO
> - SET_CCFG_BL_CONFIG_BL_LEVEL
>=20
> Signed-off-by: Ayush Singh <ayush@beagleboard.org>
> ---
>  Documentation/devicetree/bindings/net/ti,cc1352p7.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/net/ti,cc1352p7.yaml b/Doc=
umentation/devicetree/bindings/net/ti,cc1352p7.yaml
> index 3dde10de4630..a3511bb59b05 100644
> --- a/Documentation/devicetree/bindings/net/ti,cc1352p7.yaml
> +++ b/Documentation/devicetree/bindings/net/ti,cc1352p7.yaml
> @@ -29,6 +29,9 @@ properties:
>    reset-gpios:
>      maxItems: 1
> =20
> +  boot-gpios:
> +    maxItems: 1

I think this needs a description that explains what this is actually
for, and "boot-gpios" is not really an accurate name for what it is used
for IMO.

> +
>    vdds-supply: true
> =20
>  required:
> @@ -46,6 +49,7 @@ examples:
>          clocks =3D <&sclk_hf 0>, <&sclk_lf 25>;
>          clock-names =3D "sclk_hf", "sclk_lf";
>          reset-gpios =3D <&pio 35 GPIO_ACTIVE_LOW>;
> +        boot-gpios =3D <&pio 36 GPIO_ACTIVE_LOW>;
>          vdds-supply =3D <&vdds>;
>        };
>      };
>=20
> --=20
> 2.45.2
>=20

--tlfsPXEPQCAYZx+O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZpp+dgAKCRB4tDGHoIJi
0ufpAP0f3kcaznt6hfqRUwiDVHor4R4fAC6j0mhDnFjYlGqewwEAq4wwM2CjagGN
SdeYmNNys2KCWxRyuranV+JMANipHgk=
=O52J
-----END PGP SIGNATURE-----

--tlfsPXEPQCAYZx+O--

