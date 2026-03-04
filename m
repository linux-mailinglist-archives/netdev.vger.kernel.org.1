Return-Path: <netdev+bounces-263922-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6CKFJNVeqGmZtgAAu9opvQ
	(envelope-from <netdev+bounces-263922-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 17:33:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 98139204572
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 17:33:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 100FB300517F
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 16:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 299983644C0;
	Wed,  4 Mar 2026 16:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hXg30rks"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054B0364057;
	Wed,  4 Mar 2026 16:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772641416; cv=none; b=ISu7IUbuOTMnZH0HL4wW/ZBGq7660kBjVCBD2oRkrYTGrDkCaTkSoE3bH3wI+qsyRAcN4pI9KLaKddwCMZIlJQ424AtdxRVgeh0VyVqsDLGBhcT7vboOUAIA4nbAWBB/Dqivs/orfWA0eC0u80A0VtyvkpE3/rf2WKqPl587h9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772641416; c=relaxed/simple;
	bh=pplMQwlU/qk2kc7S0JatE+vPlZLnQrEDb4hZ3STRhak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eTWV9PV02d/6wOjoQljzzA+t/H+Oc0qcCMbsXOx4oVlGMwRsZjeCR4tEs/G429TImoW+SDbu2LLvS6mZJXTQQuKRbjl51wdTXaPdetfwmXS/qhpmvboYtThR2mHr0WcG1zNtRjstFpNrY0EbDG1gGfG2BYSxsg7TvcYTCnzBJfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hXg30rks; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 480FEC4CEF7;
	Wed,  4 Mar 2026 16:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772641415;
	bh=pplMQwlU/qk2kc7S0JatE+vPlZLnQrEDb4hZ3STRhak=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hXg30rksEHLGgzN/y8BGCq2UrzTehXMyVPYn7PyPz2dNqbq97RcS0vdukPZHd/5sC
	 dd2wFAjseQyAMXw25F/YW0+JEtbAxlxQVNsm2nCsEaFkULab44EcI0VHFjqSHUZbcY
	 whXtpla29jo8hc0PkFqx9OWqn/VgfK0pvzW9C8o516E1RFbomifXbh/q1IBmeiitWd
	 WmGzV3KbDRs40WvaeHuwkwQI2WceSI38h7y+7C0H3GVXkNu/jBe9gGd933s9APtR0H
	 lrZPVWhCSOeyu8xljD5U9nC+oEDKLyNf206XDkP+2g1Q7aZv0x16Y5Ywu+EL82i1Br
	 TvZjJKSPk3KHQ==
Date: Wed, 4 Mar 2026 16:23:30 +0000
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
Message-ID: <20260304-unvented-crinkle-37f0bfd03541@spud>
References: <20260224202854.112813-1-charles.perry@microchip.com>
 <20260224202854.112813-2-charles.perry@microchip.com>
 <20260304-nebulizer-rounding-40fbc81a2ba1@spud>
 <aahI1y0NO9ax/V8J@bby-cbu-swbuild03.eng.microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NmsvHff0AKgJhbpH"
Content-Disposition: inline
In-Reply-To: <aahI1y0NO9ax/V8J@bby-cbu-swbuild03.eng.microchip.com>
X-Rspamd-Queue-Id: 98139204572
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263922-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,microchip.com:email]
X-Rspamd-Action: no action


--NmsvHff0AKgJhbpH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 04, 2026 at 06:59:35AM -0800, Charles Perry wrote:
> On Wed, Mar 04, 2026 at 11:15:43AM +0000, Conor Dooley wrote:
> > On Tue, Feb 24, 2026 at 12:28:52PM -0800, Charles Perry wrote:
> > > Make it possible to connect a PHY which does not use inband
> > > autoneg to a gem MAC using phylink's information.
> > >=20
> > > The previous implementation relied on whether or not the link
> > > was a fixed-link to disable SGMII autoneg. This commit extend
> > > this to all link which are not configured for inband
> > > autonegotiation.
> > >=20
> > > Signed-off-by: Charles Perry <charles.perry@microchip.com>
> >=20
> > This breaks the macb on mpfs-icicle-kit, I get stuck with:
> >=20
> > [    7.189102] mpfs-sys-controller syscontroller: Registered MPFS syste=
m controller
> > [    7.260946] macb 20110000.ethernet eth0: PHY [20112000.ethernet-ffff=
ffff:08] driver [Vitesse VSC8662] (irq=3DPOLL)
> > [    7.273881] macb 20110000.ethernet eth0: configuring for phy/sgmii l=
ink mode
> > [    7.296580] macb 20110000.ethernet: gem-ptp-timer ptp clock register=
ed.
> > [    7.345782] macb 20112000.ethernet eth1: PHY [20112000.ethernet-ffff=
ffff:09] driver [Vitesse VSC8662] (irq=3DPOLL)
> > [    7.358082] macb 20112000.ethernet eth1: configuring for phy/sgmii l=
ink mode
> > [    7.380479] macb 20112000.ethernet: gem-ptp-timer ptp clock register=
ed.
> > [   11.376763] macb 20110000.ethernet eth0: Link is Up - 1Gbps/Full - f=
low control off
> > [   11.398403] Sending DHCP requests .
> > [   11.472699] macb 20112000.ethernet eth1: Link is Up - 1Gbps/Full - f=
low control off
> > [   13.938425] ..... timed out!
> > [   93.598491] macb 20110000.ethernet eth0: Link is Down
> > [   93.641823] macb 20110000.ethernet: gem-ptp-timer ptp clock unregist=
ered.
> > [   93.659433] macb 20112000.ethernet eth1: Link is Down
> > [   93.691724] macb 20112000.ethernet: gem-ptp-timer ptp clock unregist=
ered.
> > [   93.703977] IP-Config: Retrying forever (NFS root)...
> > [   93.758382] macb 20110000.ethernet eth0: PHY [20112000.ethernet-ffff=
ffff:08] driver [Vitesse VSC8662] (irq=3DPOLL)
> > [   93.770655] macb 20110000.ethernet eth0: configuring for phy/sgmii l=
ink mode
> > [   93.786497] macb 20110000.ethernet eth0: Link is Up - 1Gbps/Full - f=
low control off
> > [   93.795840] macb 20110000.ethernet: gem-ptp-timer ptp clock register=
ed.
> > [   93.844481] macb 20112000.ethernet eth1: PHY [20112000.ethernet-ffff=
ffff:09] driver [Vitesse VSC8662] (irq=3DPOLL)
> > [   93.856769] macb 20112000.ethernet eth1: configuring for phy/sgmii l=
ink mode
> > [   93.870926] macb 20112000.ethernet eth1: Link is Up - 1Gbps/Full - f=
low control off
> > [   93.880302] macb 20112000.ethernet: gem-ptp-timer ptp clock register=
ed.
> >=20
>=20
> Hello Conor,
>=20
> I checked the driver for the VSC8662 and it doesn't have the
> ->inband_caps() and ->config_inband() callbacks so Linux leaves whatever
> the bootloader puts or uses the defaults. Looking at the datasheet, this
> should be register 23 (Extended PHY Control Set 1) bit 13 (MAC interface
> auto-negotiation)
>=20
> My guess is that this bit is set and since this patch disable inband
> autonegotiation (because phylink decides it), there is a mismatch.
>=20
> Can you add 'managed =3D "in-band-status"' in your device tree under the =
macb
> node? That's not necessarily the fix, I just want to confirm my theory.

No, it just produces a different error:
[    5.769864] mpfs-sys-controller syscontroller: Registered MPFS system co=
ntroller
[    5.829146] macb 20110000.ethernet eth0: Could not attach PHY (-19)
[    5.854232] IP-Config: Failed to open eth0
[    5.897152] macb 20112000.ethernet eth1: Could not attach PHY (-19)
[    5.921061] IP-Config: Failed to open eth1
[    5.925592] IP-Config: No network devices available
[    5.938800] clk: Disabling unused clocks
[    5.944156] PM: genpd: Disabling unused power domains
[    5.961029] check access for rdinit=3D/usr/sbin/init failed: -2, ignoring

> Also '#define DEBUG' in 'drivers/net/phy/phylink.c' can help if you can
> recompile your kernel.

Setting this provided no further logs, seemingly.

Adding some basic prints shows that the driver changed the state of the
PCSCNTRL register from 0x1040 to 0x40, so it disabled auto neg. The
driver previously left it as it was, 0x1040 before and 0x1040 after.

> > and because I am NFS root, it breaks boot :)
> >=20
> > btw, I don't see an explanation in hte commit message for why the
> > macb_is_gem(bp) got dropped? Is this now done unconditionally when it
> > was conditional before?
> >=20
>=20
> Well if you get to the ->macb_pcs_config() callback, you most certainly
> have an SGMII PCS block. Does your IP have the PCS registers? (0x200 to
> 0x23c) Also I thought that macb doesn't do SGMII (only GEM does) so it
> can't reach ->macb_pcs_config().=20

When I said "macb on" I meant to say "macb driver on", but omitted the
word. Unfortunately, the idiot who added the original mpfs compatible,
because the platform was using the "cdns,macb" compatible rather than a
soc-specific one, did not check if the platform was actually a macb
before doing so, and trusted the original dts author. This is actually a
gem.

--NmsvHff0AKgJhbpH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaahcggAKCRB4tDGHoIJi
0jNvAP9F+T30MPLczKC1PjYWpoud+tNJ+2nn5/YGvA5EJsqCFAD+Ot/DFgczTyG2
QmUFOmdMRj8XoaKHOTOYTj/ukfCX1Qg=
=lSI9
-----END PGP SIGNATURE-----

--NmsvHff0AKgJhbpH--

