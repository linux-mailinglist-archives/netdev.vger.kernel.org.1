Return-Path: <netdev+bounces-130467-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D487998A9CD
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 18:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 128031C22575
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 16:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C14E193070;
	Mon, 30 Sep 2024 16:33:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C107C192D66
	for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 16:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727713986; cv=none; b=dgYOTFrqb/+UcHbYgNIpvtNs/+n+wdp1RBw9d/VzNLpjwmaNFlPvAEZU+0aMaRa69rGG8O4VhqixiEWA06tO51avlP/QBsKhn7C6Yi9kawDhhNGmNqHvDepUXZUIvGqmSdxo0BLo0r7wh90ZyB28PK8aoXLPaT3kGjl0P6QI2L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727713986; c=relaxed/simple;
	bh=/nANQ7PZ6apyV+R9KmQJXjLpL5eSQxMjcZum4vxGWU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ieKJv3mWqQptFGs4udwZu7XwV5Q7j2iDqe0bS1EHJA0Alal67cfVweZujdz9aN4zXLpYqHgS3LwIV49wvbRvvWJRhhU6TarsK8vadXr7ONyf/6r6lIgqeKuMJgR7EQXxiJ6TYQTrqZy3qTCjxghD8vMBMTUS2rF+RUkZ0HaWAkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1svJK3-0004om-H1; Mon, 30 Sep 2024 18:32:31 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1svJK1-002fmI-S5; Mon, 30 Sep 2024 18:32:29 +0200
Received: from pengutronix.de (pd9e595f8.dip0.t-ipconnect.de [217.229.149.248])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 71A61346DF7;
	Mon, 30 Sep 2024 16:32:29 +0000 (UTC)
Date: Mon, 30 Sep 2024 18:32:29 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: pierre-henry.moussay@microchip.com
Cc: Linux4Microchip@microchip.com, 
	Conor Dooley <conor.dooley@microchip.com>, Daire McNamara <daire.mcnamara@microchip.com>, 
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-riscv@lists.infradead.org, linux-can@vger.kernel.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [linux][PATCH v2 01/20] dt-bindings: can: mpfs: add PIC64GX CAN
 compatibility
Message-ID: <20240930-voracious-hypersonic-sambar-72a1c5-mkl@pengutronix.de>
References: <20240930095449.1813195-1-pierre-henry.moussay@microchip.com>
 <20240930095449.1813195-2-pierre-henry.moussay@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="w3vfz4jn6utc6r4q"
Content-Disposition: inline
In-Reply-To: <20240930095449.1813195-2-pierre-henry.moussay@microchip.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org


--w3vfz4jn6utc6r4q
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 30.09.2024 10:54:30, pierre-henry.moussay@microchip.com wrote:
> From: Pierre-Henry Moussay <pierre-henry.moussay@microchip.com>
>=20
> PIC64GX CAN is compatible with the MPFS CAN, only add a fallback
>=20
> Signed-off-by: Pierre-Henry Moussay <pierre-henry.moussay@microchip.com>

Reviewed-by: Marc Kleine-Budde <mkl@pengutronix.de>

Who is going to take this patch/series?

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--w3vfz4jn6utc6r4q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmb60poACgkQKDiiPnot
vG8ztwf9FfTevY46BOb3reEY53hT0hxZT5Por2f2CeBT/2LT2pbj8Dv2by2HQJbW
KMbHzms1wdCP80EEDhLWa8KRKDNGb5uEP/OpGNMFw8G189KidS0XIRIF2CilHESh
muohcWHwDr5N1Te40j809WQRcGSnlporsoc+YHdOviE74d5TsW5fvsdL1TJa29nB
xoPG8nmdIPOs0b/fYK30kIIQxSItwQMyT5eO+MwBoUqHGpwcQYLMzDr+CyMaUtb/
dz0D/hcjEjqtUyFQCqZQ2wZs9OTyhxCMx6FpOVK/PIF9ZTZpSk8FZqdRij/m77hq
vKGe3xjy+6GirBkzeBuBn8Lj1+binA==
=RlVK
-----END PGP SIGNATURE-----

--w3vfz4jn6utc6r4q--

