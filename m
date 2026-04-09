Return-Path: <netdev+bounces-277054-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cHNVEovH12n6SwgAu9opvQ
	(envelope-from <netdev+bounces-277054-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 17:36:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C68903CCCDD
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 17:36:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E186F3013D58
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 15:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26FE73D6470;
	Thu,  9 Apr 2026 15:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oFVh+w9B"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02254348453;
	Thu,  9 Apr 2026 15:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775748972; cv=none; b=Xqd6LxC2yJo8Jm7eCYHuuFPWVlBjZrG4UDrO674Fp7TtwxuceThkKVvcDzuoVRh0UxzhF7zaOqJ5tUIxnadC+37MuKo+L5TEI62xVxbYX5hKBtIBMmBKrqWrxTH/xHXGk/7X/u+UlAioEQea6lgShzTtah9n/u7036XOJA6CAL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775748972; c=relaxed/simple;
	bh=GaBsF253+7/0/7ERds0sHbzej0dAyfzmyKqbhi68H6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GmRvD4i09WjLZfI+93xNbET/5WVsNsPVX8cyqRdK1++E7ZV0CzbJ55SP2+oMrssuvxImSoFH45nvbb+gQxyEMArHP8R1qvxMn7KfDxXlmABiAqB5vQBOEN3CzZk9t9Fg8/lZ5Kh8EkHqb84yoLLGEFGsxQ0aB9kPSWPpYceU5HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oFVh+w9B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03943C4CEF7;
	Thu,  9 Apr 2026 15:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775748971;
	bh=GaBsF253+7/0/7ERds0sHbzej0dAyfzmyKqbhi68H6c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oFVh+w9B2ldMkOPGVl6bIKnn59TCHL0dytoqAX3A1iQs2ErGvYeLQmmpfm8lef8mq
	 VoExxPRoA8rQN0DeT+s+6uqcL7AXkMyTholVv57reE6JSRkV0P1YFJDvY/C/nJMt5b
	 VVnAXF9iLERirSIfpaoqcEcKGHJYoMrz5fz2hz17zxWlCEpWw2+yZMR5uQ5536BhpG
	 eTLofzn2Y+BROrNBOKopUwJ/n02Xrh5xBvCKFEyB+QQwRJRHMIcRpU2M/755+FVZMf
	 03FRvcgHnbYJU7CVHc1l5qU+cud+t4cFdzYiNLUPmY/ZMhNpFbNOiB3bDkUHaltkT1
	 LBuz7zpWpAlIA==
Date: Thu, 9 Apr 2026 16:36:04 +0100
From: Conor Dooley <conor@kernel.org>
To: Josua Mayer <josua@solid-run.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Yazan Shhady <yazan.shhady@solid-run.com>,
	Mikhail Anikin <mikhail.anikin@solid-run.com>,
	Alexander Dahl <ada@thorsis.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Krzysztof Kozlowski <krzk@kernel.org>, netdev@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: net: dsa: nxp,sja1105: make spi-cpol
 optional for sja1110
Message-ID: <20260409-afar-striving-d89022c8a2bc@spud>
References: <20260409-imx8dxl-sr-som-v2-0-83ff20629ba0@solid-run.com>
 <20260409-imx8dxl-sr-som-v2-1-83ff20629ba0@solid-run.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FfoVPBWIp5Jpffvt"
Content-Disposition: inline
In-Reply-To: <20260409-imx8dxl-sr-som-v2-1-83ff20629ba0@solid-run.com>
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277054-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	FREEMAIL_CC(0.00)[kernel.org,nxp.com,pengutronix.de,gmail.com,lunn.ch,davemloft.net,google.com,redhat.com,solid-run.com,thorsis.com,vger.kernel.org,lists.linux.dev,lists.infradead.org,microchip.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,solid-run.com:email]
X-Rspamd-Queue-Id: C68903CCCDD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--FfoVPBWIp5Jpffvt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 09, 2026 at 02:34:33PM +0200, Josua Mayer wrote:
> Currently, the binding requires 'spi-cpha' for SJA1105 and 'spi-cpol'
> for SJA1110.
>=20
> However, the SJA1110 supports both SPI modes 0 and 2. Mode 2
> (cpha=3D0, cpol=3D1) is used by the NXP LX2160 Bluebox 3.
>=20
> On the SolidRun i.MX8DXL HummingBoard Telematics, mode 0 is stable,
> while forcing mode 2 introduces CRC errors especially during bursts.
>=20
> Drop the requirement on spi-cpol for SJA1110.
>=20
> Fixes: af2eab1a8243 ("dt-bindings: net: nxp,sja1105: document spi-cpol/cp=
ha")
> Signed-off-by: Josua Mayer <josua@solid-run.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--FfoVPBWIp5Jpffvt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCadfHYQAKCRB4tDGHoIJi
0pHMAP4xcZs2F6zIRBAC+PvYt8NsWbZkNNOCtJhpauOF9O+jugD/dx95sKUe2Px2
XiwZrAPhK4i3PH2q0hqkv0eSMmaMNwY=
=I38d
-----END PGP SIGNATURE-----

--FfoVPBWIp5Jpffvt--

