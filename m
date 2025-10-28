Return-Path: <netdev+bounces-233631-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A56C1697D
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 20:22:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF58F3A7F5C
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 19:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC0B434E750;
	Tue, 28 Oct 2025 19:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KyOsWYwk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A89A18C31;
	Tue, 28 Oct 2025 19:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761679365; cv=none; b=qF+VO946leiJyb6Rvjj8a0WnhPArfXytOAcCkYoVnGQUC6c/np3VxxeAIcBC9rv1qjYL9f2+wHOBHpiqeD9YWL3e4eXJ0VtBBvMjXGMY84Y9qui0BrByIASc79pGPpD0/j5UfNV7y49XVPlaA8Snt+Q4o07lB1T+UGVUWbGyGYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761679365; c=relaxed/simple;
	bh=ul+M2CYqBXyeu0QhZfiqDxRQGUWEmL/wId6aCQowrfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FToRnbP5MSWXjuaQRdwDQiYfBZbYrdHIEs2KrH4zantVHGG4zq1nh+xXsr7DXWd6+8auZdO34eDcE4xxaYgbi67TV/S5RQuur7mBNzofVNqVkMI4JTvxBaXxG2GcicZsJ+w88Nc23ZpJcy7qnzUblGygyIoqN3kFwQr6tkGdjzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KyOsWYwk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BBEFC4CEE7;
	Tue, 28 Oct 2025 19:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761679365;
	bh=ul+M2CYqBXyeu0QhZfiqDxRQGUWEmL/wId6aCQowrfU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KyOsWYwk9QfYOsdLD4kfsDn8KLPhLhQT5F0pbHoyrM6O2YT5RKXThX6pU60tvWO7F
	 N9xWe/dDRm9bgR3vwKdwHPPVB5Bdut+wFqUxZv0dj4ClJM9j0Qo77dczGTZIBlw+DX
	 RsztmnW0IVxYLiUUYEo9S9XM1KS/UrafUZwonNP6rsp0BScGUpBpByo9IrBpnDRoez
	 ycW1o5oWd4H1Um4MDVYf5qW3oANlwHXFdE2yGmVRDF3OJld3FRxcj3r3qIpqQG+muf
	 Hc+wwVPqngl2Fy+QFSQux7LNMiRWap9rBCB6oVrEwveU3QOncxxP8HCw9blB1uX7S9
	 b7Gvd2+xnq/mA==
Date: Tue, 28 Oct 2025 19:22:37 +0000
From: Conor Dooley <conor@kernel.org>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Han Gao <rabenda.cn@gmail.com>, Icenowy Zheng <uwu@icenowy.me>,
	Vivian Wang <wangruikang@iscas.ac.cn>, Yao Zi <ziyao@disroot.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	sophgo@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH v4 1/3] dt-bindings: net: sophgo,sg2044-dwmac: add phy
 mode restriction
Message-ID: <20251028-parka-proud-265e5b342b8e@spud>
References: <20251028003858.267040-1-inochiama@gmail.com>
 <20251028003858.267040-2-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="96h0QxX1n7q2W7DY"
Content-Disposition: inline
In-Reply-To: <20251028003858.267040-2-inochiama@gmail.com>


--96h0QxX1n7q2W7DY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 08:38:56AM +0800, Inochi Amaoto wrote:
> As the ethernet controller of SG2044 and SG2042 only supports
> RGMII phy. Add phy-mode property to restrict the value.
>=20
> Also, since SG2042 has internal rx delay in its mac, make
> only "rgmii-txid" and "rgmii-id" valid for phy-mode.

Should this have a fixes tag?
Acked-by: Conor Dooley <conor.dooley@microchip.com>

>=20
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> ---
>  .../bindings/net/sophgo,sg2044-dwmac.yaml     | 20 +++++++++++++++++++
>  1 file changed, 20 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/net/sophgo,sg2044-dwmac.ya=
ml b/Documentation/devicetree/bindings/net/sophgo,sg2044-dwmac.yaml
> index ce21979a2d9a..916ef8f4838a 100644
> --- a/Documentation/devicetree/bindings/net/sophgo,sg2044-dwmac.yaml
> +++ b/Documentation/devicetree/bindings/net/sophgo,sg2044-dwmac.yaml
> @@ -70,6 +70,26 @@ required:
> =20
>  allOf:
>    - $ref: snps,dwmac.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: sophgo,sg2042-dwmac
> +    then:
> +      properties:
> +        phy-mode:
> +          enum:
> +            - rgmii-txid
> +            - rgmii-id
> +    else:
> +      properties:
> +        phy-mode:
> +          enum:
> +            - rgmii
> +            - rgmii-rxid
> +            - rgmii-txid
> +            - rgmii-id
> +
> =20
>  unevaluatedProperties: false
> =20
> --=20
> 2.51.1
>=20

--96h0QxX1n7q2W7DY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaQEX/QAKCRB4tDGHoIJi
0j2LAP9HvD5s5HhSulkZQfpKk77nSCLRHuUpAGScnvLLJbI5JAD7Bc580Q4YP2oc
NbiZmgJg4mN/5vfDxejV7+SeFM+7xgM=
=uLPY
-----END PGP SIGNATURE-----

--96h0QxX1n7q2W7DY--

