Return-Path: <netdev+bounces-188403-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 128F0AACA80
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 18:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A8473BD66B
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 16:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1504284678;
	Tue,  6 May 2025 16:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YL0jVWeO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC1728466B;
	Tue,  6 May 2025 16:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746547786; cv=none; b=PS881b8zGqavwhf13U85OnZsOWc1ouy/eV8dRxFFVrgk3I9KhFqrvP/9RYa686jLmj38mBubLSm8Hw8AypHhrWy35tSBgjnOtG+UnLlkgSyNg0kUJkFImtrP07xO7aByNXzs8QFzrdB9/Mp65fIG01OzidXfBDy7c2cTK0jOXNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746547786; c=relaxed/simple;
	bh=1AqPf7T899io12qypJ/mms7Lr5Nr9wni8SyAes9z2vI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dXRIZHcwy0PKVL4dC/wbU4d6kaKsKfuW7godWSBWSyUnvMSHfLpk+LtsP5yvOeZ9SwYc7nz2zPZpJsPZBJnF29tHSSaoP12i2Lg44ugs0r38IL7DS6Z9+1FVzm7TWxHYdSe3NfhytI/1b1QXI0M4QbS8AVwMPC+iVI1xqZNqmBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YL0jVWeO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93E07C4CEE4;
	Tue,  6 May 2025 16:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746547786;
	bh=1AqPf7T899io12qypJ/mms7Lr5Nr9wni8SyAes9z2vI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YL0jVWeOd2s74qnpkynu5XmWmK16ssceH5qmopx7m7dxOJjOXSGUQtCPBNOg/Oz49
	 37dOweLLtPGvzHFhP+6u+7eHmpivki9joZPtkhirZHDMeNjuQyhQbr+e/jkn8GnpHL
	 TLHcsZHUT3aRldmvNpMFP0hs5lL7lANiKIWvORQxCMJtTPM0s+xwtlsl6VxPr8NmA1
	 LAG7B1VWtaDuWebv5PobKgCo/GNw6wioQ88wuRnMyF03mX7nPj67mGqA3YEio7dSxv
	 8AhnvEk/ymk50+DUDPBY4alQGcZgnHxsOM8xy8plh/m8ZOhsf1cMSiydJsWprsfanM
	 Bp/pw8/P9aN2A==
Date: Tue, 6 May 2025 17:09:37 +0100
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
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Guo Ren <guoren@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Romain Gantois <romain.gantois@bootlin.com>,
	Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>,
	Lothar Rubusch <l.rubusch@gmail.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Jose Abreu <joabreu@synopsys.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	sophgo@lists.linux.dev, linux-riscv@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>, Han Gao <rabenda.cn@gmail.com>
Subject: Re: [PATCH net-next 1/4] dt-bindings: net: sophgo,sg2044-dwmac: Add
 support for Sophgo SG2042 dwmac
Message-ID: <20250506-tidings-backless-99cfc65a2ab4@spud>
References: <20250506093256.1107770-1-inochiama@gmail.com>
 <20250506093256.1107770-2-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xnhOoqcIxXVoDYDg"
Content-Disposition: inline
In-Reply-To: <20250506093256.1107770-2-inochiama@gmail.com>


--xnhOoqcIxXVoDYDg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 06, 2025 at 05:32:51PM +0800, Inochi Amaoto wrote:
> The GMAC IP on SG2042 is a standard Synopsys DesignWare MAC
> (version 5.00a) with tx clock.
>=20
> Add necessary compatible string for this device.
>=20
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> Tested-by: Han Gao <rabenda.cn@gmail.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--xnhOoqcIxXVoDYDg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaBo0QQAKCRB4tDGHoIJi
0uzcAP9AXEpRJB9kYjvwkSr1RxOOhB6kQeDj6R9Xa2LcbHBQOAD9FXI/OFWlXOrQ
PME/DZ4B5w9p7Kbs85bcMHB0v6+2zAI=
=rLmY
-----END PGP SIGNATURE-----

--xnhOoqcIxXVoDYDg--

