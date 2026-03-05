Return-Path: <netdev+bounces-264404-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qMXpB46PqWni/gAAu9opvQ
	(envelope-from <netdev+bounces-264404-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 15:13:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E10213143
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 15:13:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 633CE303E1F2
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 14:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF02A396584;
	Thu,  5 Mar 2026 14:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FN28CvnS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AEAC21E091;
	Thu,  5 Mar 2026 14:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772720009; cv=none; b=PFfyUqWSy3rb1Lio5Ilk5hXwXoeHGVAiLZiX9VUgIrB2126+AoszimhLYjjPZv6smYuccmaY4h7VE6Nn6BLxLfsDw991bHlJJd+ZLZBOJ+XyrQIsyM21z6+VOI4VPLy9kDybEfH2UXvq3qYmKiYRm3umuTvswwSNEMH3VB8gk94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772720009; c=relaxed/simple;
	bh=hZ+X8qLg4axbIiOpc1uXmjGz4Hg14Ab5XGG1GpcjocI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=htXrrRfbNZUdUHm/ARvwdBVMFwxL+P9DTg6i1/teoKKOOTnkjPwNtRdGrHZ77by8NYnKobsy5pci96oOmmGzbWirv9em7VkCHRIPe65476OWiR/ZIjCyCz2XbRH0+4dBtsmepqz2BeDVJJDttmN1+7HUMoy11pzmQLr87VtmrGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FN28CvnS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A553DC19423;
	Thu,  5 Mar 2026 14:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772720009;
	bh=hZ+X8qLg4axbIiOpc1uXmjGz4Hg14Ab5XGG1GpcjocI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FN28CvnSIWhDj5S6Li88TvvHlBpsIjO+SNNBI6iQXlN5r7qBS2qTD5Pgo5p0bJoM1
	 98Yaq0JYW9nCi07i/J4jeaK6CWwzOzvkAcT1H/TNs/CdhfcVAdqOxz7p1TyHwIxVOx
	 h+9GpAbpH5kiGs5UjWxqJKqZ4pGfeGPuNvhZSQlnrGvaoryjoTNIkM8Ee+ZVPprgxM
	 GGbO046qC9Gcu102mi4z4PveCiLVOUPdl8z2vwuDlgCncWblpCYvtxkHS7nIYb7r/0
	 +yYDuaOUsfsq8aZ3HTsoUqXdjwoRACSjAVWqyNcR0/UV/xpHcMGtm9ZjO6sno+o/ve
	 r6LuA6xlr166Q==
Date: Thu, 5 Mar 2026 14:13:24 +0000
From: Conor Dooley <conor@kernel.org>
To: Charles Perry <charles.perry@microchip.com>
Cc: netdev@vger.kernel.org, Sean Anderson <sean.anderson@linux.dev>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/3] net: macb: fix SGMII with inband aneg
 disabled
Message-ID: <20260305-fantasy-useable-40ca04f0266e@spud>
References: <20260224202854.112813-1-charles.perry@microchip.com>
 <20260224202854.112813-2-charles.perry@microchip.com>
 <20260304-nebulizer-rounding-40fbc81a2ba1@spud>
 <aahI1y0NO9ax/V8J@bby-cbu-swbuild03.eng.microchip.com>
 <20260304-unvented-crinkle-37f0bfd03541@spud>
 <aaht0/XpUCz+58bz@bby-cbu-swbuild03.eng.microchip.com>
 <20260305-backlit-epilogue-62139ae694a6@spud>
 <aamLf63OfJ5RH69v@bby-cbu-swbuild03.eng.microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3mJLoCPC69+0EIB0"
Content-Disposition: inline
In-Reply-To: <aamLf63OfJ5RH69v@bby-cbu-swbuild03.eng.microchip.com>
X-Rspamd-Queue-Id: E5E10213143
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264404-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action


--3mJLoCPC69+0EIB0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 05, 2026 at 05:56:15AM -0800, Charles Perry wrote:
> On Thu, Mar 05, 2026 at 09:42:19AM +0000, Conor Dooley wrote:
> > On Wed, Mar 04, 2026 at 09:37:23AM -0800, Charles Perry wrote:
> > > On Wed, Mar 04, 2026 at 04:23:30PM +0000, Conor Dooley wrote:
> > >=20
> > > Are you able to check register 23, bit 13 of your PHY by any chance? =
Maybe
> > > with the mdio/mii commands in U-Boot if you have that.
> >=20
> > "mii read addr 23" returns 0660 for both PHYs in U-Boot.
>=20
> Oh, I think you fell into a trap of U-Boot's mii command.
>=20
> The arguments are always in hex even if you dont prepend "0x".

Eh no, actually I thought that you meant register 0x23. I'm not used to
register addresses being given in decimal.

> What "mii read 8 23" did is most likely read register 0x23, masked with
> 0x1f because clause 22 has only 32 registers. So it read register 0x3 whi=
ch
> is the device identifier 2 register: 0x0660.
>=20
> The exact command should be "mii read 8 0x17", "mii read 9 0x17".

Both read back 2004

--3mJLoCPC69+0EIB0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaamPXAAKCRB4tDGHoIJi
0jb/AQCeRpW2KT3Wp3+xcto0jiZJO5FmUGKtLa/3mdwlHM+NtgD8Cx3Qe5BTOX6j
AoQ+ShwA/ZI4VfUN3cPgbOz+lS4RpAg=
=/1em
-----END PGP SIGNATURE-----

--3mJLoCPC69+0EIB0--

