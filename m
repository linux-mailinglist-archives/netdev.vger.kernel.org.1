Return-Path: <netdev+bounces-264876-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oKT6KSMAq2lxZQEAu9opvQ
	(envelope-from <netdev+bounces-264876-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 17:26:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B070224DE6
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 17:26:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0A2673157062
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 16:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E084D3ECBC6;
	Fri,  6 Mar 2026 16:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kNZmcCKG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB92E33BBC6;
	Fri,  6 Mar 2026 16:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772813950; cv=none; b=PbUskQjTps4hmorv/ByqhKmJuQBulJ+gscWufqvlOTTPa7CGHWoeBcgD+L7tnfkHx875+dla4FY6N6CL1JSs/0mRp0mRCK0/35JFSRY6Jzit4zLTbVhGnTwTRX+NHmicY2ihEGLFHzEnOfWRidiIlYgGPZDPtRhv973OFPklfgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772813950; c=relaxed/simple;
	bh=rxrgCRecUaFZScjivL6+/cfzYeOAP1zbrMrESw5g2ZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d0uVUje4r28Soe4nUZ2X6KqBcPA11//qCY2Wc/297phQU7SvgXgIH8XhI4u8ZMKtolXeTHhwpFq263a6crtWik5nNntcZVWgl349S7qi54Y3I9ulcuDS/Xqp3Jweqzy72LKg4BpSNYGgtp+4XcQKdZ6ZNbyiQmWEq4hOEjCjzx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kNZmcCKG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32066C2BC87;
	Fri,  6 Mar 2026 16:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772813950;
	bh=rxrgCRecUaFZScjivL6+/cfzYeOAP1zbrMrESw5g2ZQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kNZmcCKG1GYBnpKA/IZNULW/DGxNP21rLJzfCL+Y/QXHnZqs6e7UIz/Pbqtcj2NoF
	 yVxVrDZ9mnryi7eNy9KCrB7NXygEGefG2YWjDUg4pzhxJpyo/TEcAWu1KJC4ALnA8D
	 40XDQ5q9QeB1D4PGMq6P41sW/FlZc2WPsLjQIUJNGrC2vOPsqsA9LaaXJQUDCDZiJ7
	 9Dah0WDaC+DHQ65y15Rci4NXh8/LXgmJF08Mdwr7mQgwnb+USpT9O1lAczSE8buL/T
	 CEWv19Nb3aCVrlvd0av8brPJ/0ES8rK5R+6csoghBH8PAjBVQx995mx/DhBmoS5YyY
	 koYwNnqc45eMw==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id F10441AC52CE; Fri, 06 Mar 2026 16:19:03 +0000 (GMT)
Date: Fri, 6 Mar 2026 16:19:03 +0000
From: Mark Brown <broonie@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	Romain Gantois <romain.gantois@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] net: sfp: manage receiver and transmitter
 regulators
Message-ID: <aar-dwj23wNmnEa6@sirena.co.uk>
References: <20260303-sfp-regulators-v1-0-7101ae34cb84@bootlin.com>
 <20260303-sfp-regulators-v1-2-7101ae34cb84@bootlin.com>
 <e7a1ab5e-c34d-4ca5-93eb-4f5bcfacdb40@sirena.org.uk>
 <aab6Tqo1z-8YQ4j6@shell.armlinux.org.uk>
 <536e57fe-9738-4026-a9c9-fdb7135cbe2f@sirena.org.uk>
 <aab9bwKSubR6zxKG@shell.armlinux.org.uk>
 <1dbc679e-ad6d-49c5-86bd-3b319b899584@sirena.org.uk>
 <6b4bfb6a-d279-44bd-9110-6d2dc67d8020@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2tZNM3XFQNoH1bSr"
Content-Disposition: inline
In-Reply-To: <6b4bfb6a-d279-44bd-9110-6d2dc67d8020@lunn.ch>
X-Cookie: Think big.  Pollute the Mississippi.
X-Rspamd-Queue-Id: 2B070224DE6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264876-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[armlinux.org.uk,bootlin.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[broonie@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.990];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sirena.co.uk:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action


--2tZNM3XFQNoH1bSr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 04, 2026 at 10:38:54PM +0100, Andrew Lunn wrote:

> This is the first board since 2017, when support for SFPs was added,
> which can actually control the power supplies. We cannot make
> regulators mandatory without breaking backwards compatibility.

> So for me, the patch is good as it is now, the regulators are
> optional.

To be clear the actual effect of the regular API is that no regulator
has been specified by the firmware then we assume that there's something
we don't know about and substitute in a dummy regulator, otherwise
adding regulator support to anything would be excessively complex and
fragile.  We do currently warn when we do this since we're generally
very conservative about things like this as messing up power can crash
the system.

The issues Russell is seeing with AHCI are a combination of people just
bodging those warnings and the AHCI regulator bindings being very
confused, I'll follow up to his mail separately.

Optional regulators are for the case where the supply may be physically
absent and the driver needs to do something about it, for example the
original use case was for some of the MMC/SD specs where higher
performance modes add an additional supply which needs to be turned on
only after negotating with the device, if it's absent then the system
should handle this by not enabling those higher performance modes.

If a supply absolutely has to be there the driver should use a normal
regulator and write code on the basis that it will actually have power.

--2tZNM3XFQNoH1bSr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmmq/ncACgkQJNaLcl1U
h9DU6Qf/d78jVVLkV+pBZ4dS6NOrR8gbVRChpO+O3mb8xcZos+4Ff+9fKJYX7FwR
BSqn2yLhYwkdJl+NB3gB5CyaeXPpoYevEbH6jSmXFCxIlpMHgvJCB1YOunt5pDu9
/Qo9V++PzpcvCIfOffpjT+ApfvRw04W3hqRMvOf6ZvR5nWHwPP8e0pAVrwAUYfKi
xAHx/nakigFzE04NhUW7Jbrt2NOpwNRRqpD7+ioFkOpmQydgejPs/JBRPcqDtd4m
HyKERS+5LJqlvMK3CF+VO6KOLR2o81abaVKFmA3q4v0onQpKhHPhDH5vzK9AB3Aj
GlV5FQK5qIepaHClQLv7LCXyXkzjnA==
=jBB0
-----END PGP SIGNATURE-----

--2tZNM3XFQNoH1bSr--

