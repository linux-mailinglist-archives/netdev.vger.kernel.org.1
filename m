Return-Path: <netdev+bounces-197515-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0DD5AD8FE6
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 16:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B7093B34C6
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 14:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C92D31A01C6;
	Fri, 13 Jun 2025 14:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gU3VhMCv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B2119C558;
	Fri, 13 Jun 2025 14:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749825807; cv=none; b=fxMW2gkdzmUTGe2JK+MCpDLl3YzqW7O9MmETx/lesFITIB8XjMiitBGZZcu2L2sTFk56eQrmVpdfyjkC3d5NwPTOPro+IpyvU7+W2tCyYoqmVTQKFM0ZAz6cad3ZvefH+uKxEn02hNBC3HdVCQLIReOuNGrhoAMrl6iq8ekQoOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749825807; c=relaxed/simple;
	bh=FhXXXGmaRCUAiRGRLmZdTk6rfR0K44mNdX06Z2gh+Dg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gKibdeTfSvs/+uvh82jgdreqLcoImVry47q/xrjUOVDoI6eDGHbfCTkEWrqhGzAI1abWeMj6aSSfndjgYon5XrKxpGADcP4ra7ISsvrWbxrcKj+i6PJThvLmv5WoWbbyOFE9L9wJ2D4r+avItw2JjmHmK+bG5ZIXwbUGZyR8Pt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gU3VhMCv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07C1EC4CEE3;
	Fri, 13 Jun 2025 14:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749825807;
	bh=FhXXXGmaRCUAiRGRLmZdTk6rfR0K44mNdX06Z2gh+Dg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gU3VhMCvbEUpkeYtCm1sdiEbZCDtGB0/CaVg498QB4KCpsaQjBatRuDSK6B3/TBq5
	 LSrgWYiWAwWHVtD6pvP6Py13HIq+0odrKGJrw82l7KmXE9n+C2oLTOepY6ratFP9ep
	 YPat9WUK1PGkA83Y+YmS9m5Lt2c/OqN1Q8NqiZh3GWRnM/JEpWRgnN2jQN/u+5I77z
	 FH4YUNHjEfcJNrRFfsYO1VRmfGO+eEayCERolh84NFhe5IMYVAm7yZwe703o7UiFp5
	 lqAuKH45uxbeysx065G8tS23ws7+G3LN5HbQoPDXKhmOwRoCkQzOzcXgFrwWklKnvM
	 uZ63XxBS2i8/Q==
Date: Fri, 13 Jun 2025 15:43:20 +0100
From: Conor Dooley <conor@kernel.org>
To: Vivian Wang <wangruikang@iscas.ac.cn>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Richard Cochran <richardcochran@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Russell King <linux@armlinux.org.uk>, Vivian Wang <uwu@dram.page>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/4] dt-bindings: net: Add support for SpacemiT
 K1
Message-ID: <20250613-charbroil-backlands-7cf485ac7f59@spud>
References: <20250613-net-k1-emac-v1-0-cc6f9e510667@iscas.ac.cn>
 <20250613-net-k1-emac-v1-1-cc6f9e510667@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="DrcNRgrkpAYQRveH"
Content-Disposition: inline
In-Reply-To: <20250613-net-k1-emac-v1-1-cc6f9e510667@iscas.ac.cn>


--DrcNRgrkpAYQRveH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 13, 2025 at 10:15:07AM +0800, Vivian Wang wrote:
> The Ethernet MACs on SpacemiT K1 appears to be a custom design. SpacemiT
> refers to them as "EMAC", so let's just call them "spacemit,k1-emac".
>=20
> Signed-off-by: Vivian Wang <wangruikang@iscas.ac.cn>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

--DrcNRgrkpAYQRveH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaEw5CAAKCRB4tDGHoIJi
0mUZAQDOqutaHQTNkzdtMom2o9B3nbuwKSuSLIduFjJKalvmiwD/YsHTvrRH0WFf
qgTLhLoSPa5oUwkptRwAi4wYwCtGHA8=
=4VR+
-----END PGP SIGNATURE-----

--DrcNRgrkpAYQRveH--

