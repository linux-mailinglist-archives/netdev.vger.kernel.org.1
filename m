Return-Path: <netdev+bounces-197085-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DCD8AD7799
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 18:09:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C30E163D91
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 16:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C119C299A93;
	Thu, 12 Jun 2025 16:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AcZaMQWY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6A529992E;
	Thu, 12 Jun 2025 16:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749744514; cv=none; b=LOpc/LtTn1H7zaUNeVQwp8k4DZ2Sc2lAlwtVYTQNx3I/Xoy7incamkJPZDWjdKFYhWGWrXPiD/43SMQuBJ0o9RYCpzQE5FA/Bz3RJWymNyn0o1X6FwpSDJ19T3sLJL8RlLRrB1RcJD8HJNUF1VuHV36vgmg1jJSDP7jWNCT/fa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749744514; c=relaxed/simple;
	bh=B03z8gxJK+nx661YS+WD6BW1buv5G9KGZfmtmKssNPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f1LaLTmniKIsqsU+0/jTmKHFpA6vAoluFY9BO8jA+WW0Lxll2F31dBlic+7Osxp8/D7GLbndZwxgALK5MPAZLd9OwSrQOA504tO/58kgEv/JNuwghySKCN5cxvWH9IOT4ANCvyPndbHH9qGUfiMfS460JwcTqU1J5RWxkpRREC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AcZaMQWY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6EB2C4CEEA;
	Thu, 12 Jun 2025 16:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749744514;
	bh=B03z8gxJK+nx661YS+WD6BW1buv5G9KGZfmtmKssNPc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AcZaMQWYYfcHZvJtoDAV5b9/0sFDY52tAweeM6mjMw3BnjKC6EQvBGMhvxRO5s7T+
	 ydFT6HVpInq0VQTLJQ3I7CnhHZwRYtAN9RStGLb0lmmrloAyYdU6WSCRmmEtV3L13F
	 gRRlW5dixUdTTMze1ujaTXh6TRGaLE0bXoesygVCne0TUXajO8aYJvuCIJlTif0uwa
	 nwOems3Jcsfa0XUfRSuUDYVqKUeYLehRdq7Y+arH+y+6ORaHG7Pzzr2jfU25Yka2HL
	 MXdfVoMwt7FBL5/wEFOS4B+nwXyhcfYR9RycsPhcpRgemPFfI7zlaomLXp3LETADE7
	 iWRI7dK/Bh+Ag==
Date: Thu, 12 Jun 2025 17:08:27 +0100
From: Conor Dooley <conor@kernel.org>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Richard Cochran <richardcochran@gmail.com>,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Yixun Lan <dlan@gentoo.org>,
	Thomas Bonnefille <thomas.bonnefille@bootlin.com>,
	Ze Huang <huangze@whut.edu.cn>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, sophgo@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH net-next RFC 1/3] dt-bindings: net: Add support for
 Sophgo CV1800 dwmac
Message-ID: <20250612-maturely-pony-a6fb8f9cb163@spud>
References: <20250611080709.1182183-1-inochiama@gmail.com>
 <20250611080709.1182183-2-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zSWjS4FDrlJ7AUsz"
Content-Disposition: inline
In-Reply-To: <20250611080709.1182183-2-inochiama@gmail.com>


--zSWjS4FDrlJ7AUsz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 11, 2025 at 04:07:06PM +0800, Inochi Amaoto wrote:
> The GMAC IP on CV1800 series SoC is a standard Synopsys
> DesignWare MAC (version 3.70a).
>=20
> Add necessary compatible string for this device.
>=20
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--zSWjS4FDrlJ7AUsz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaEr7ewAKCRB4tDGHoIJi
0geVAQDLc3KgdxScF0+JMYwJ7R+YQeW94eK+OREQoU5WmclyjgEArisbfSvY76Q6
pihw3ebbOH5q91hjm5goo6nl6L6UhwI=
=1G8F
-----END PGP SIGNATURE-----

--zSWjS4FDrlJ7AUsz--

