Return-Path: <netdev+bounces-263984-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QHmvCqp1qGnTugAAu9opvQ
	(envelope-from <netdev+bounces-263984-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 19:10:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 87580205E2C
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 19:10:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 368F13025A4D
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 18:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE5E3CF684;
	Wed,  4 Mar 2026 18:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AKb8ToDZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9E713DDAE;
	Wed,  4 Mar 2026 18:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772647585; cv=none; b=H73SuKxo49EBW5AVUxLW2DjOoYAPG4cdC0oG3Qkn668M5tPt+KJYK7rHghSVtz9X08VONXAw9lz0pd5nm93VeVv8yNhKRtzT4OLm4KNAwrEilXfrdIh/Xw+36ArFiFoCAlMSMla7ZU+RGcBy6NmiOVSqbWanDlrdeSWg5hUwoIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772647585; c=relaxed/simple;
	bh=2SzA9rHsMS1fhSf7WgAUSRDZADC/19xNRmJwoXSsWeo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qHG/LcgF3FLWdq5XI94wngZTGgxRI+v15Tim0e3aGyHJEY2iqquQHj4Hn/1wnPHqRmjHjRe85/UAxzTvHcPO+zTLRz1aRZiGXwWbMincBI/QMy9Mwcvk+umiic/4CuLq846rSZDgMDplBJE6GXJ4LsOpuxLfDOVoL1XozB5jaRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AKb8ToDZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1B06C4CEF7;
	Wed,  4 Mar 2026 18:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772647585;
	bh=2SzA9rHsMS1fhSf7WgAUSRDZADC/19xNRmJwoXSsWeo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AKb8ToDZZmWhdyNA3MaURgK3ieS7vT2JqlOI6bcylw4UohFunCbktecoOdxYspCy+
	 UTE7pS1q3+aVxOtu+tQa3sYApf9tnzaNfhBIWJy+nap5+4ek1N8bmvndbg4xNmmEvZ
	 dukft2RTwA+/yZHM68NRbBPaYtht4KFa4kt3N08ueFV238yZuh4ya0E8PSeTmNebuI
	 bGcGhd3AkaT/FA4bmo6oeT8ltxbCHWDhhDieWtMhvsWiKgrafRcWynctjHduba4tsb
	 TtYCYBJqWeuo4UAQ2wfE1sNEpOhcaD76QPt/5i3eLy72qL6fZP5B6AlBnH7LEw/1TL
	 3lCauI9yld/yQ==
Date: Wed, 4 Mar 2026 18:06:20 +0000
From: Conor Dooley <conor@kernel.org>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Charles Perry <charles.perry@microchip.com>, netdev@vger.kernel.org,
	Sean Anderson <sean.anderson@linux.dev>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/3] net: macb: fix SGMII with inband aneg
 disabled
Message-ID: <20260304-mandarin-alumni-4b38a7743ee1@spud>
References: <20260224202854.112813-1-charles.perry@microchip.com>
 <20260224202854.112813-2-charles.perry@microchip.com>
 <20260304-nebulizer-rounding-40fbc81a2ba1@spud>
 <aahI1y0NO9ax/V8J@bby-cbu-swbuild03.eng.microchip.com>
 <20260304-unvented-crinkle-37f0bfd03541@spud>
 <aahkCah1pvuNIy03@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fA1uma34Luo5ezcs"
Content-Disposition: inline
In-Reply-To: <aahkCah1pvuNIy03@shell.armlinux.org.uk>
X-Rspamd-Queue-Id: 87580205E2C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263984-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,microchip.com:email]
X-Rspamd-Action: no action


--fA1uma34Luo5ezcs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 04, 2026 at 04:55:37PM +0000, Russell King (Oracle) wrote:
> On Wed, Mar 04, 2026 at 04:23:30PM +0000, Conor Dooley wrote:
> > On Wed, Mar 04, 2026 at 06:59:35AM -0800, Charles Perry wrote:
> > > On Wed, Mar 04, 2026 at 11:15:43AM +0000, Conor Dooley wrote:
> > > > On Tue, Feb 24, 2026 at 12:28:52PM -0800, Charles Perry wrote:
> > > > > Make it possible to connect a PHY which does not use inband
> > > > > autoneg to a gem MAC using phylink's information.
> > > > >=20
> > > > > The previous implementation relied on whether or not the link
> > > > > was a fixed-link to disable SGMII autoneg. This commit extend
> > > > > this to all link which are not configured for inband
> > > > > autonegotiation.
> > > > >=20
> > > > > Signed-off-by: Charles Perry <charles.perry@microchip.com>
> > > >=20
> > > > This breaks the macb on mpfs-icicle-kit, I get stuck with:
> > > >=20
> > > > [    7.189102] mpfs-sys-controller syscontroller: Registered MPFS s=
ystem controller
> > > > [    7.260946] macb 20110000.ethernet eth0: PHY [20112000.ethernet-=
ffffffff:08] driver [Vitesse VSC8662] (irq=3DPOLL)
> > > > [    7.273881] macb 20110000.ethernet eth0: configuring for phy/sgm=
ii link mode
> > > > [    7.296580] macb 20110000.ethernet: gem-ptp-timer ptp clock regi=
stered.
> > > > [    7.345782] macb 20112000.ethernet eth1: PHY [20112000.ethernet-=
ffffffff:09] driver [Vitesse VSC8662] (irq=3DPOLL)
> > > > [    7.358082] macb 20112000.ethernet eth1: configuring for phy/sgm=
ii link mode
> > > > [    7.380479] macb 20112000.ethernet: gem-ptp-timer ptp clock regi=
stered.
> > > > [   11.376763] macb 20110000.ethernet eth0: Link is Up - 1Gbps/Full=
 - flow control off
> > > > [   11.398403] Sending DHCP requests .
> > > > [   11.472699] macb 20112000.ethernet eth1: Link is Up - 1Gbps/Full=
 - flow control off
> > > > [   13.938425] ..... timed out!
> > > > [   93.598491] macb 20110000.ethernet eth0: Link is Down
> > > > [   93.641823] macb 20110000.ethernet: gem-ptp-timer ptp clock unre=
gistered.
> > > > [   93.659433] macb 20112000.ethernet eth1: Link is Down
> > > > [   93.691724] macb 20112000.ethernet: gem-ptp-timer ptp clock unre=
gistered.
> > > > [   93.703977] IP-Config: Retrying forever (NFS root)...
> > > > [   93.758382] macb 20110000.ethernet eth0: PHY [20112000.ethernet-=
ffffffff:08] driver [Vitesse VSC8662] (irq=3DPOLL)
> > > > [   93.770655] macb 20110000.ethernet eth0: configuring for phy/sgm=
ii link mode
> > > > [   93.786497] macb 20110000.ethernet eth0: Link is Up - 1Gbps/Full=
 - flow control off
> > > > [   93.795840] macb 20110000.ethernet: gem-ptp-timer ptp clock regi=
stered.
> > > > [   93.844481] macb 20112000.ethernet eth1: PHY [20112000.ethernet-=
ffffffff:09] driver [Vitesse VSC8662] (irq=3DPOLL)
> > > > [   93.856769] macb 20112000.ethernet eth1: configuring for phy/sgm=
ii link mode
> > > > [   93.870926] macb 20112000.ethernet eth1: Link is Up - 1Gbps/Full=
 - flow control off
> > > > [   93.880302] macb 20112000.ethernet: gem-ptp-timer ptp clock regi=
stered.
> > > >=20
> > >=20
> > > Hello Conor,
> > >=20
> > > I checked the driver for the VSC8662 and it doesn't have the
> > > ->inband_caps() and ->config_inband() callbacks so Linux leaves whate=
ver
> > > the bootloader puts or uses the defaults. Looking at the datasheet, t=
his
> > > should be register 23 (Extended PHY Control Set 1) bit 13 (MAC interf=
ace
> > > auto-negotiation)
> > >=20
> > > My guess is that this bit is set and since this patch disable inband
> > > autonegotiation (because phylink decides it), there is a mismatch.
> > >=20
> > > Can you add 'managed =3D "in-band-status"' in your device tree under =
the macb
> > > node? That's not necessarily the fix, I just want to confirm my theor=
y.
> >=20
> > No, it just produces a different error:
> > [    5.769864] mpfs-sys-controller syscontroller: Registered MPFS syste=
m controller
> > [    5.829146] macb 20110000.ethernet eth0: Could not attach PHY (-19)
> > [    5.854232] IP-Config: Failed to open eth0
> > [    5.897152] macb 20112000.ethernet eth1: Could not attach PHY (-19)
> > [    5.921061] IP-Config: Failed to open eth1
> > [    5.925592] IP-Config: No network devices available
> > [    5.938800] clk: Disabling unused clocks
> > [    5.944156] PM: genpd: Disabling unused power domains
> > [    5.961029] check access for rdinit=3D/usr/sbin/init failed: -2, ign=
oring
>=20
> -19 is -ENODEV (I wish everyone would use %pe so we get english
> error messages rather than having to look up errno codes in the
> header files.)
>=20
> macb uses either phylink_of_phy_connect() or phylink_connect_phy().
> I don't think phylink_connect_phy() would return -ENODEV, but
> phylink_of_phy_connect() would - but I can't see that adding
> 'managed =3D "in-band-status";' to DT would cause that. The only
> case I can see is that fwnode_phy_find_device() fails to find the
> phydev, but there is a PHY node specified in DT, but that would
> fail without in-band-status.

It's as you say, and fwnode_phy_find_device() is the source.
fwnode_mdio_find_device() is what fails, returning NULL.

> > > Also '#define DEBUG' in 'drivers/net/phy/phylink.c' can help if you c=
an
> > > recompile your kernel.
> >=20
> > Setting this provided no further logs, seemingly.
>=20
> It certainly would if you place it before the first #include - I
> routinely build kernels with it set as such. The messages are produced
> at debug level, so should appear via "dmesg". If you want to see them
> on the console, you need to add "debug" to the kernel command line.

Clearly I'm too stupid for this, because I did it again and still got no
more logs. I even disabled DYNAMIC_DEBUG since that has an interaction
in the file.

--fA1uma34Luo5ezcs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaah0nAAKCRB4tDGHoIJi
0qk+AP4olgzkBGPgBX0Ve2jFspxOn0cHhLhs5pYICgqnzKGBwgD/X8l1+iLa1END
De/Xz7ihP+bUN572Czsvf05aonLadgA=
=1309
-----END PGP SIGNATURE-----

--fA1uma34Luo5ezcs--

