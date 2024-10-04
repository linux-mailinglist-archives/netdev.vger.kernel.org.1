Return-Path: <netdev+bounces-132126-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C06699085B
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 18:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8D841F20FA9
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 16:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C052C1DACAC;
	Fri,  4 Oct 2024 15:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fn1ikhRY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DEE91C727E;
	Fri,  4 Oct 2024 15:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728057423; cv=none; b=oH9many8WHMtuKBVDyH5doIyuIznLOizb1MsVS9ng4gSsWLSQv8KKuCtQgLp1CYf+P0HMDIsfEh0kw7Jtgz+trbPcVkUQvxYu/4rRDlzFGuJhLKWEtBwx8/5RrhmNtBg/fchDx1CjagNKYW12r5Sbq/YI6n3zaewZ/9NNk15do0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728057423; c=relaxed/simple;
	bh=JPtd9OTrFQ/NTQ4tNNCsAoJSiK8RIDxBRo0hG1VDX3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jl8a/A8UbqxfB0vws8v9rBQfly3mcl7jmXqmRxmaYvdm1dr14NlS6oh5pFNv+ma481vvADyDp9GZ/H61lve0T4xFYWSRiNEaFLwi7ApmduTxcaVHkwJrb2VzRR8IV9xzbnOW1Jogj2BI9zsvL13wAIxlOs5X8Jj+4NZ++utj6Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fn1ikhRY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1127C4CEC6;
	Fri,  4 Oct 2024 15:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728057423;
	bh=JPtd9OTrFQ/NTQ4tNNCsAoJSiK8RIDxBRo0hG1VDX3k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fn1ikhRYItcXP1tJ7MGJjbB9c/Ub80ivXQ9ezcDtjjPmweLju3ttw3VDbewhUu+R9
	 wKYXPOP7TLUPu7XyRqBYrGPTIkk6sdvYUI4Hmn9f/WuS2nTLkTEHvHN5vg9VGNql6I
	 vIroUmDHMDzuH7XImxiogS0evVj3gkXCcP1qHQXQzYl5z563E1kfztuMW9gYXP0BJR
	 kpIa1nWRiW+W9gPdxlom9TA8GRsI3jRuytT4qBzNewGJf9MHSB0Scv7lFI6j0qikQ6
	 Di3eC1WxI6kWhJEiMXcunLy+kjqp8Z90HIyEFhBS5NlWBh176XmgF4oqkoURcIh7ji
	 d/xw6wJMG0Kaw==
Date: Fri, 4 Oct 2024 16:56:56 +0100
From: Conor Dooley <conor@kernel.org>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Linux Team <linux-imx@nxp.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	imx@lists.linux.dev, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next v4 1/3] dt-bindings: net: fec: add pps channel
 property
Message-ID: <20241004-engraved-founding-89b8fe2ac38b@spud>
References: <20241004152419.79465-1-francesco@dolcini.it>
 <20241004152419.79465-2-francesco@dolcini.it>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6opbeSP1XEYEgk8P"
Content-Disposition: inline
In-Reply-To: <20241004152419.79465-2-francesco@dolcini.it>


--6opbeSP1XEYEgk8P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 04, 2024 at 05:24:17PM +0200, Francesco Dolcini wrote:
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
>=20
> Add fsl,pps-channel property to select where to connect the PPS signal.
> This depends on the internal SoC routing and on the board, for example
> on the i.MX8 SoC it can be connected to an external pin (using channel 1)
> or to internal eDMA as DMA request (channel 0).
>=20
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--6opbeSP1XEYEgk8P
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZwAQSAAKCRB4tDGHoIJi
0m5rAQCOr4EbyOnpEdVGrd4gx204KckfFCN/GDv3dStrHmoKBAD/YzZHrp7v/wzZ
fKWFhWfuYlUlpYmycAk4sAU0NH7qNAo=
=PX3v
-----END PGP SIGNATURE-----

--6opbeSP1XEYEgk8P--

