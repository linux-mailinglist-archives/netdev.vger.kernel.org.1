Return-Path: <netdev+bounces-221751-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6029AB51C36
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 17:46:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1865D7A38A6
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 15:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 617CE322C70;
	Wed, 10 Sep 2025 15:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zy2EXQLQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E252D6E5C;
	Wed, 10 Sep 2025 15:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757518993; cv=none; b=VWtM+brLTIZuNt7evtE8V5C69qpVC88Umi++sDG/l6e7XGgFk1GRTOTbSr2jPXAKTad5wB5tNjbj0XTY0rbwnpOys+oq3pUsHNhXBYZ3nISkhFb9TfmWFMeSulGSnxEvxMOUh19hiTZQtrexxGEntSUsY4VHW00wZUm13A9/I2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757518993; c=relaxed/simple;
	bh=1b/HZBCDSBjZnOsquRRI7/H8kIGM/UOD3l0APNCePus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dj9hAcEXZn1ApGX0eUrpwYoK9H3tpOURTY+EeKnBURf11CnN4gUSmT9XpTD70vUeSm58yJ9d5UfKPfyY0kPGAgGdTivdcaSeaH0au2rTkjtCq+DnnEZIfhoS3hK85HpA+QPBIJja+dImxQMk83nJUxUZXIJ2u13MaRuZLGqwfEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zy2EXQLQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A0A8C4CEEB;
	Wed, 10 Sep 2025 15:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757518992;
	bh=1b/HZBCDSBjZnOsquRRI7/H8kIGM/UOD3l0APNCePus=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zy2EXQLQpfYmmOEV6xbp8DMW+dbc+6Gj/MtHurit3ZbLJ9QHWEZbwAMKzf1WylQKg
	 dM/Dw8lHZ/nS/Sz7WpHj0WfhZcsQ+3cTfBzWI72o3iqcjAwuGlmiRnXgEhnixN8c78
	 qAaKdBAEHbJjJrskvpy3pKPKXFcR0tsUmK3D2HSWo1/GrXFh2+1WKzSF+3HAilOS8b
	 WGdhxIuiZV5ekKmKwVb3JkBxpzP1bwYJ7SHIGzot2MGCHh7EnTAlGyp1kUKbqCZMBE
	 PgVudAEWJeCge2KLcNhRlUUjTjhby7LsF4UaPVLKjE4+arfdp1RtjNC3fH3znCdkXy
	 bRVGCye4nX0/A==
Date: Wed, 10 Sep 2025 16:43:05 +0100
From: Mark Brown <broonie@kernel.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Marco Felsch <m.felsch@pengutronix.de>,
	Jonas Rebmann <jre@pengutronix.de>, Andrew Lunn <andrew@lunn.ch>,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>, linux-sound@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Vladimir Oltean <olteanv@gmail.com>,
	Shawn Guo <shawnguo@kernel.org>,
	"David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 1/4] dt-bindings: net: dsa: nxp,sja1105: Add reset-gpios
 property
Message-ID: <e5bb3ed5-be37-4bdd-ad42-c35d441a67a8@sirena.org.uk>
References: <20250910-imx8mp-prt8ml-v1-0-fd04aed15670@pengutronix.de>
 <20250910-imx8mp-prt8ml-v1-1-fd04aed15670@pengutronix.de>
 <20250910125611.wmyw2b4jjtxlhsqw@skbuf>
 <20250910143044.jfq5fsv2rlsrr5ku@pengutronix.de>
 <20250910144328.do6t5ilfeclm2xa4@skbuf>
 <693c3d1e-a65b-47ea-9b21-ce1d4a772066@sirena.org.uk>
 <20250910153454.ibh6w7ntxraqvftb@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="B4AlsieOXZl/QDeJ"
Content-Disposition: inline
In-Reply-To: <20250910153454.ibh6w7ntxraqvftb@skbuf>
X-Cookie: I think my career is ruined!


--B4AlsieOXZl/QDeJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 10, 2025 at 06:34:54PM +0300, Vladimir Oltean wrote:
> On Wed, Sep 10, 2025 at 04:09:05PM +0100, Mark Brown wrote:

> > after power on.  The above wording is pretty common in datasheets and I
> > know in a bunch of cases it was carried forward kind of blindly rather
> > than looking at the actual device requirements.

> No, it doesn't say that, and I had discussions with the application
> engineering team for this chip about this :-/

> I can't comment on anything extrapolated outside of the SJA1105/SJA1110.

Fair enough if this chip is unusually unstable, TBH I'm surprised to
see something currently available that's so fragile - internal POR
circuits aren't exactly new or exciting and do make things so much more
robust.

--B4AlsieOXZl/QDeJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmjBnIgACgkQJNaLcl1U
h9ArpQf/d28NFNL5lecDi1OX5w67IE7M+usOjz61mRz2Y53VAC79EU7VDXj0zn+P
BdWEf1RWecGZ60aHRhOd+nlLv5qp6GSu7zoQRWro1LehBeAViCfKXTkJOww4gXai
2hmEAn0iJXYfDtsNdEg7xhOM6eH+h2aR9OdbKM98mz70fHGJ1PF+g0JI2OaXT1t6
l2zW7l8cYRSRZFCwGKMpo3QRVXKVzZTbLuxtjMHOOFt1N456lcIBcxqjUlg5uOke
ycoER8pFDJUYh+PMVz1m0X4EvFN0VyG6EGw2e3OER7dWxkqlBoKzGQS5yEFoIC+q
t4PwZfOH4Q1znGetEzvF1HuZGpu+IQ==
=SMFl
-----END PGP SIGNATURE-----

--B4AlsieOXZl/QDeJ--

