Return-Path: <netdev+bounces-210858-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A361EB1524A
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 19:45:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D690E3AE725
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 17:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FF97299937;
	Tue, 29 Jul 2025 17:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dR+CXQy2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3683D2253A4;
	Tue, 29 Jul 2025 17:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753811030; cv=none; b=QiyRqtCxjioBld+UNf7YUgbmfhIH7zfNMZPDJ/RdYPDwimgHopUUmfUZCA8ncyPp+/P65mv7bvjVgZ6yE6CDZj5PkOcl0WxOhA47bJ0GMPd1NerDZpZspE0JG8UzuWDCzi35s+1vsGZcPYDbBn6wVAXABPHJVszfHG7SRhv9MjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753811030; c=relaxed/simple;
	bh=/l0RfM32IYqNTyOacg15yW0ba6BjISJEK6fBJdD4dNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B0EQhYOMY1BRandk31oTXzQyd5JcuPG1mrJVl/57AzmpWnWSRt+/ElgZ5jAAK4+TukRpNt9fkc06Gmv7tTnVxze8625FESlHidz77rd9N67xQUkL3rkZVBF9CWFEJtR9qhEXsDFE8ycJNSn7Wxblzp8HbbVDgx/DSIYcRV7zHXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dR+CXQy2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67A72C4CEF4;
	Tue, 29 Jul 2025 17:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753811029;
	bh=/l0RfM32IYqNTyOacg15yW0ba6BjISJEK6fBJdD4dNc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dR+CXQy2bNMOjZG/aIMfPdIyqxlqxyxLczcZUheXTXI4zDTc0Mlqui7Hwcwd1MyRK
	 pEsSNLS20jY6cX0FN8x7YkwRHq1UIaE9P7+nDNJ0qS7PaPlRiCmyfTjfVFa6XrQQco
	 UIfJBNyFj9O+A4G1CWum4EgSNyJ70zz2PtbSNxjoWnap8EZ3yaDo9p7lyxcTil50rP
	 /cizQHxnZKkeMDHyTXwZWWfMFxavaKd0Xc/lEpfYsYCCbpNcNiDx3XpykDv8d+matB
	 F/iGay/UesKo9Mlysa6vMtCme2trqgLR4Zp5MIyeX40XZ9xca1KZeBtq1UxyLut+VX
	 ElELx7L/IDPlg==
Date: Tue, 29 Jul 2025 18:43:42 +0100
From: Conor Dooley <conor@kernel.org>
To: Yao Zi <ziyao@disroot.org>
Cc: Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Jisheng Zhang <jszhang@kernel.org>, linux-riscv@lists.infradead.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 1/3] dt-bindings: net: thead,th1520-gmac: Describe
 APB interface clock
Message-ID: <20250729-canal-stimuli-492b4550108c@spud>
References: <20250729093734.40132-1-ziyao@disroot.org>
 <20250729093734.40132-2-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8Ed6Kl6zSmD8JUqy"
Content-Disposition: inline
In-Reply-To: <20250729093734.40132-2-ziyao@disroot.org>


--8Ed6Kl6zSmD8JUqy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 29, 2025 at 09:37:32AM +0000, Yao Zi wrote:
> Besides ones for GMAC core and peripheral registers, the TH1520 GMAC
> requires one more clock for configuring APB glue registers. Describe
> it in the binding.
>=20
> Though the clock is essential for operation, it's not marked as required
> for now to avoid introducing new dt-binding warnings to existing dts.

Nah, introduce the warnings. If the clock is required for operation, it
should be marked as such. You've made it optional in the driver, which
is the important part (backwards compatible) and you've got the dts
patch in the series.

>=20
> Fixes: f920ce04c399 ("dt-bindings: net: Add T-HEAD dwmac support")
> Signed-off-by: Yao Zi <ziyao@disroot.org>
> ---
>  .../devicetree/bindings/net/thead,th1520-gmac.yaml        | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/net/thead,th1520-gmac.yaml=
 b/Documentation/devicetree/bindings/net/thead,th1520-gmac.yaml
> index 6d9de3303762..fea9fbc1d006 100644
> --- a/Documentation/devicetree/bindings/net/thead,th1520-gmac.yaml
> +++ b/Documentation/devicetree/bindings/net/thead,th1520-gmac.yaml
> @@ -59,14 +59,18 @@ properties:
>        - const: apb
> =20
>    clocks:
> +    minItems: 2
>      items:
>        - description: GMAC main clock
>        - description: Peripheral registers interface clock
> +      - description: APB glue registers interface clock
> =20
>    clock-names:
> +    minItems: 2
>      items:
>        - const: stmmaceth
>        - const: pclk
> +      - const: apb
> =20
>    interrupts:
>      items:
> @@ -88,8 +92,8 @@ examples:
>          compatible =3D "thead,th1520-gmac", "snps,dwmac-3.70a";
>          reg =3D <0xe7070000 0x2000>, <0xec003000 0x1000>;
>          reg-names =3D "dwmac", "apb";
> -        clocks =3D <&clk 1>, <&clk 2>;
> -        clock-names =3D "stmmaceth", "pclk";
> +        clocks =3D <&clk 1>, <&clk 2>, <&clk 3>;
> +        clock-names =3D "stmmaceth", "pclk", "apb";
>          interrupts =3D <66>;
>          interrupt-names =3D "macirq";
>          phy-mode =3D "rgmii-id";
> --=20
> 2.50.1
>=20

--8Ed6Kl6zSmD8JUqy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaIkITgAKCRB4tDGHoIJi
0s21AQDDnogQVz1heV93wFEUee+EeHPjK4d6lAcPQOYd21HVkAD+M13qwek9DiWx
oGRpnMWXsj9s2GrbkbTgiGGiHXOYWQk=
=EOvL
-----END PGP SIGNATURE-----

--8Ed6Kl6zSmD8JUqy--

