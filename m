Return-Path: <netdev+bounces-264006-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Pr/Ktt9qGmHuwAAu9opvQ
	(envelope-from <netdev+bounces-264006-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 19:45:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B231720692A
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 19:45:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D4B89303D4C5
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 18:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FBF03AE19D;
	Wed,  4 Mar 2026 18:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VeqXevb9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B322378815;
	Wed,  4 Mar 2026 18:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772649490; cv=none; b=WznlywT+of57rEGvljY/EIECCTrUoppT9fJjCJ0OxPzCO41RnFZyFLMztigdiLe7iY2XSMB8ztpiilQbnFz0gTlx7KgwovdEXGF6WXN6tuYmuJvwYz7bBWigZ1V34R+Izb420rt/b7Hx7YBm87n74zOo3g76XPkosU4itxJP1DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772649490; c=relaxed/simple;
	bh=UY8LzZxuR8yb+VfmKaHMStRNDAWO7VGjzBgFjylO/Rc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IKnCKuc8D8dDYwsnSUDX7udSOr2DhZlfK7mbE3TRB3RAb6OzqYu1pGEtifBVZj3m6qpsAfXNtzrV+ZNKb7bqmeleGismWaeJQbwmbTKnoc25T90b/Z/aOmodNpb331LHbO4NMAQFm8LnpxmoLezianXTQfh0ZzVXeVe2S9lJYJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VeqXevb9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 892F4C4CEF7;
	Wed,  4 Mar 2026 18:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772649489;
	bh=UY8LzZxuR8yb+VfmKaHMStRNDAWO7VGjzBgFjylO/Rc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VeqXevb94+2duXeOB996KmEA73kn23n6BiOAw7MdMuAAwDa0rq/qrpKSMg3GjtYj0
	 TwfzBLEVAf6oqCtUu+7Lrl7huBykmYow6OivxgY34heUNlvP73llk4ioxJZipT8WOF
	 OD0RMmQj8EXwDDJNk4XQupWEFcW7ISKXKQJ+2bfWnk4KXfdnd9gNPfdj6NR8+5CBwr
	 CQxE06XgQW7Lc86ey9OPRNQAK68zifW4M0TB1iecL6CJfSiGuhm+Md7SnlVgDxcnrx
	 0NYeTsLE0ZpVOyXBjZUYPqf4/qQEn7GuRdgPLB4B5dcWUXlzJCVYMHhwJ/dSqyVRdG
	 LosnazQhzR59A==
Date: Wed, 4 Mar 2026 18:38:05 +0000
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
Message-ID: <20260304-gumball-boggle-a585d1a69b65@spud>
References: <20260224202854.112813-1-charles.perry@microchip.com>
 <20260224202854.112813-2-charles.perry@microchip.com>
 <20260304-nebulizer-rounding-40fbc81a2ba1@spud>
 <aahI1y0NO9ax/V8J@bby-cbu-swbuild03.eng.microchip.com>
 <20260304-unvented-crinkle-37f0bfd03541@spud>
 <aahkCah1pvuNIy03@shell.armlinux.org.uk>
 <20260304-mandarin-alumni-4b38a7743ee1@spud>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VDl6KyGoe/ygaDZ0"
Content-Disposition: inline
In-Reply-To: <20260304-mandarin-alumni-4b38a7743ee1@spud>
X-Rspamd-Queue-Id: B231720692A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264006-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[microchip.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action


--VDl6KyGoe/ygaDZ0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 04, 2026 at 06:06:20PM +0000, Conor Dooley wrote:
> On Wed, Mar 04, 2026 at 04:55:37PM +0000, Russell King (Oracle) wrote:
> > On Wed, Mar 04, 2026 at 04:23:30PM +0000, Conor Dooley wrote:
> > > On Wed, Mar 04, 2026 at 06:59:35AM -0800, Charles Perry wrote:
> > > > On Wed, Mar 04, 2026 at 11:15:43AM +0000, Conor Dooley wrote:
> > > > > On Tue, Feb 24, 2026 at 12:28:52PM -0800, Charles Perry wrote:
> > > > > > Make it possible to connect a PHY which does not use inband
> > > > > > autoneg to a gem MAC using phylink's information.
> > > > > >=20
> > > > > > The previous implementation relied on whether or not the link
> > > > > > was a fixed-link to disable SGMII autoneg. This commit extend
> > > > > > this to all link which are not configured for inband
> > > > > > autonegotiation.
> > > > > >=20
> > > > > > Signed-off-by: Charles Perry <charles.perry@microchip.com>
> > > > >=20
> > > > > This breaks the macb on mpfs-icicle-kit, I get stuck with:
> > > > >=20
> > > > > [    7.189102] mpfs-sys-controller syscontroller: Registered MPFS=
 system controller
> > > > > [    7.260946] macb 20110000.ethernet eth0: PHY [20112000.etherne=
t-ffffffff:08] driver [Vitesse VSC8662] (irq=3DPOLL)
> > > > > [    7.273881] macb 20110000.ethernet eth0: configuring for phy/s=
gmii link mode
> > > > > [    7.296580] macb 20110000.ethernet: gem-ptp-timer ptp clock re=
gistered.
> > > > > [    7.345782] macb 20112000.ethernet eth1: PHY [20112000.etherne=
t-ffffffff:09] driver [Vitesse VSC8662] (irq=3DPOLL)
> > > > > [    7.358082] macb 20112000.ethernet eth1: configuring for phy/s=
gmii link mode
> > > > > [    7.380479] macb 20112000.ethernet: gem-ptp-timer ptp clock re=
gistered.
> > > > > [   11.376763] macb 20110000.ethernet eth0: Link is Up - 1Gbps/Fu=
ll - flow control off
> > > > > [   11.398403] Sending DHCP requests .
> > > > > [   11.472699] macb 20112000.ethernet eth1: Link is Up - 1Gbps/Fu=
ll - flow control off
> > > > > [   13.938425] ..... timed out!
> > > > > [   93.598491] macb 20110000.ethernet eth0: Link is Down
> > > > > [   93.641823] macb 20110000.ethernet: gem-ptp-timer ptp clock un=
registered.
> > > > > [   93.659433] macb 20112000.ethernet eth1: Link is Down
> > > > > [   93.691724] macb 20112000.ethernet: gem-ptp-timer ptp clock un=
registered.
> > > > > [   93.703977] IP-Config: Retrying forever (NFS root)...
> > > > > [   93.758382] macb 20110000.ethernet eth0: PHY [20112000.etherne=
t-ffffffff:08] driver [Vitesse VSC8662] (irq=3DPOLL)
> > > > > [   93.770655] macb 20110000.ethernet eth0: configuring for phy/s=
gmii link mode
> > > > > [   93.786497] macb 20110000.ethernet eth0: Link is Up - 1Gbps/Fu=
ll - flow control off
> > > > > [   93.795840] macb 20110000.ethernet: gem-ptp-timer ptp clock re=
gistered.
> > > > > [   93.844481] macb 20112000.ethernet eth1: PHY [20112000.etherne=
t-ffffffff:09] driver [Vitesse VSC8662] (irq=3DPOLL)
> > > > > [   93.856769] macb 20112000.ethernet eth1: configuring for phy/s=
gmii link mode
> > > > > [   93.870926] macb 20112000.ethernet eth1: Link is Up - 1Gbps/Fu=
ll - flow control off
> > > > > [   93.880302] macb 20112000.ethernet: gem-ptp-timer ptp clock re=
gistered.
> > > > >=20
> > > >=20
> > > > Hello Conor,
> > > >=20
> > > > I checked the driver for the VSC8662 and it doesn't have the
> > > > ->inband_caps() and ->config_inband() callbacks so Linux leaves wha=
tever
> > > > the bootloader puts or uses the defaults. Looking at the datasheet,=
 this
> > > > should be register 23 (Extended PHY Control Set 1) bit 13 (MAC inte=
rface
> > > > auto-negotiation)
> > > >=20
> > > > My guess is that this bit is set and since this patch disable inband
> > > > autonegotiation (because phylink decides it), there is a mismatch.
> > > >=20
> > > > Can you add 'managed =3D "in-band-status"' in your device tree unde=
r the macb
> > > > node? That's not necessarily the fix, I just want to confirm my the=
ory.
> > >=20
> > > No, it just produces a different error:
> > > [    5.769864] mpfs-sys-controller syscontroller: Registered MPFS sys=
tem controller
> > > [    5.829146] macb 20110000.ethernet eth0: Could not attach PHY (-19)
> > > [    5.854232] IP-Config: Failed to open eth0
> > > [    5.897152] macb 20112000.ethernet eth1: Could not attach PHY (-19)
> > > [    5.921061] IP-Config: Failed to open eth1
> > > [    5.925592] IP-Config: No network devices available
> > > [    5.938800] clk: Disabling unused clocks
> > > [    5.944156] PM: genpd: Disabling unused power domains
> > > [    5.961029] check access for rdinit=3D/usr/sbin/init failed: -2, i=
gnoring
> >=20
> > -19 is -ENODEV (I wish everyone would use %pe so we get english
> > error messages rather than having to look up errno codes in the
> > header files.)
> >=20
> > macb uses either phylink_of_phy_connect() or phylink_connect_phy().
> > I don't think phylink_connect_phy() would return -ENODEV, but
> > phylink_of_phy_connect() would - but I can't see that adding
> > 'managed =3D "in-band-status";' to DT would cause that. The only
> > case I can see is that fwnode_phy_find_device() fails to find the
> > phydev, but there is a PHY node specified in DT, but that would
> > fail without in-band-status.
>=20
> It's as you say, and fwnode_phy_find_device() is the source.
> fwnode_mdio_find_device() is what fails, returning NULL.

Probably the last thing for today, since it's already getting late,
bus_find_device_by_fwnode() is failing in that function.

>=20
> > > > Also '#define DEBUG' in 'drivers/net/phy/phylink.c' can help if you=
 can
> > > > recompile your kernel.
> > >=20
> > > Setting this provided no further logs, seemingly.
> >=20
> > It certainly would if you place it before the first #include - I
> > routinely build kernels with it set as such. The messages are produced
> > at debug level, so should appear via "dmesg". If you want to see them
> > on the console, you need to add "debug" to the kernel command line.
>=20
> Clearly I'm too stupid for this, because I did it again and still got no
> more logs. I even disabled DYNAMIC_DEBUG since that has an interaction
> in the file.



--VDl6KyGoe/ygaDZ0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaah8DQAKCRB4tDGHoIJi
0ijJAP0TU6TG+6zEx+1cyY/fUol3AEaZFssNZIyJZXNDKXL7DQD+P/o0CjzK0s2x
HX/85tGo8SulsEG5f4YrXKSHu4yQ1Qw=
=x2if
-----END PGP SIGNATURE-----

--VDl6KyGoe/ygaDZ0--

