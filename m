Return-Path: <netdev+bounces-233554-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C0BC155CE
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 16:15:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82B5C420572
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 15:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4820D33A014;
	Tue, 28 Oct 2025 15:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hwa51bTi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD8916DC28;
	Tue, 28 Oct 2025 15:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761664230; cv=none; b=QrHjR7omd09b14jZ6AwBdK1axx5k3j5b817RBvXAw07M/U/z4Wxrf5zQxF/xpY03Vk0L3ZisyU6rQuU4g4ShbWe3DtOpKmG0jRWafkAk8m8RMWPPY43dXFkx69nX9sAzD9BcHg0gvT/p5Y4xAmOQfhrI/B1yzLww8NDGJirezzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761664230; c=relaxed/simple;
	bh=8YthI3p1g8E4fGp4lN5pfwCWiXSbbb5wGc582EqpCjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HGLCo9QRVzxX50duvnKhSdzCrRv2n6TbrR+aN9H6GYyjeFE6xV+hOH4SToY3WFCoXuWdg5f0UQ/Cn6nXmo6zzQ6A1gwngzu7UeCs2E716nHoRzPBAKIhC0FdmNH4qR9sfhV+RtQSb6QC4MgOxSYJcxDi47/MqkxtsUL9vpTHlbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hwa51bTi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95680C4CEF7;
	Tue, 28 Oct 2025 15:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761664229;
	bh=8YthI3p1g8E4fGp4lN5pfwCWiXSbbb5wGc582EqpCjA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hwa51bTiOrIpGOHkNIBEiX7kP/09KzLNe5W5S31eEiwfmD2aXj75b3LAjIsTM0km0
	 DcNx0qiQjL/f+WQKgxpCe7o7vUEwhfFzm/VmSL9vHOduWKVbbKx196ZU4usyr4qWXe
	 xRdTnTG3OgrQvQ/gHi3TYi3dR6SHMMkcYnsfmD7X0RH2+9pPwJi9mLJqMAf0Hy/chI
	 5tAvjKN0PWaI2XbqcCCu81H4SEO1H4kLVbciU2uzCDOlKsiwwGzbGDCaOb5t7PXhHK
	 AlCLB6etAT13QKtzysET120YKJ03bOuDWj+rYOSi/GO5FzHWwfpxB0zCDtn3hN63tc
	 lRi485x8qeYRQ==
Date: Tue, 28 Oct 2025 15:10:22 +0000
From: Mark Brown <broonie@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Guenter Roeck <linux@roeck-us.net>,
	Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-i3c@lists.infradead.org
Subject: Re: [PATCH 3/4] regmap: i3c: switch to use i3c_xfer from
 i3c_priv_xfer
Message-ID: <718f4e83-48e9-408b-9569-42769f76d302@sirena.org.uk>
References: <20251028-lm75-v1-0-9bf88989c49c@nxp.com>
 <20251028-lm75-v1-3-9bf88989c49c@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dGU0FRXfnJSl6dVk"
Content-Disposition: inline
In-Reply-To: <20251028-lm75-v1-3-9bf88989c49c@nxp.com>
X-Cookie: Your canceled check is your receipt.


--dGU0FRXfnJSl6dVk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 10:57:54AM -0400, Frank Li wrote:
> Switch to use i3c_xfer instead of i3c_priv_xfer because framework will
> update to support HDR mode. i3c_priv_xfer is now an alias of i3c_xfer.
>=20
> Replace i3c_device_do_priv_xfers() with i3c_device_do_xfers(..., I3C_SDR)
> to align with the new API.
>=20
> Prepare for removal of i3c_priv_xfer and i3c_device_do_priv_xfers().

Acked-by: Mark Brown <broonie@kernel.org>

--dGU0FRXfnJSl6dVk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmkA3N4ACgkQJNaLcl1U
h9Axzwf+Nts9b0hUZDWoyFrOrpdSY1gklGWScN2Fks55EWfvF3VaTQcAxgCJVAAg
9r7n+t6WaZ8GP3AoLKQiVkfWG7sIidWAblqi3STK4L/hIGB5mHHm6Ifo9lva0fWW
tbVehX6/hVX1GgVpKXkMnAKAv3blhYSr8hck7snQRQhpMPLlZRWZAg0uThD/8dNv
+54oSPGCVLLFsu4XM9QKpMJdE/wrEW62iycsbBNcf4zFnHJM8AkYm9uGxi057nas
hOTiEK0i+MRUNGtow58ju9OxAuWwbwi6DPmc+5aCA9zLFStjufAPf16hx47db44F
yYvT882Zu53UH2SRvFrgCpHfojWzvA==
=3M3t
-----END PGP SIGNATURE-----

--dGU0FRXfnJSl6dVk--

