Return-Path: <netdev+bounces-264253-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WDC3Fe5QqWkj4wAAu9opvQ
	(envelope-from <netdev+bounces-264253-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 10:46:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FAD820ED7C
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 10:46:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 962AD30625AA
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 09:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0BF37B01A;
	Thu,  5 Mar 2026 09:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YYJjXJwF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BBEE55A;
	Thu,  5 Mar 2026 09:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772703479; cv=none; b=p5Pc2w7AiOAmwqkwdhHdztILKUIfVBLkwA1OJwceNXNPfAsntVmfY6LblX+Jsp3aha67HTF5xzsvdIyPkepjj+ludTBbf6XpoKG2l9t30I5kXFekuu2tpe/YF2Pb8Jo1eWCHle8f45wnJ+0m65DDyKTH+6zGfO2EDRqPlyr1V64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772703479; c=relaxed/simple;
	bh=J5RmHB+GeJFt+jWtZQ9AJiesNu4umZshjbXch9Pc1gg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q6sKIyYeQDlj74Qq7lw/25r7R592kw5J6SOHJRkyKguat1viM8XvkNUiaGbVsUpjh0NFnb9DwnKxXP9ffTPqilYzgmP9K+Sh+x6SHE8lsJDSROEBUzkMaNuHsC8ypLZLXa2emfQgs4SD6m1wHy1S5hPTTAcVjULl8VFzPuEyHP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YYJjXJwF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5338C116C6;
	Thu,  5 Mar 2026 09:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772703479;
	bh=J5RmHB+GeJFt+jWtZQ9AJiesNu4umZshjbXch9Pc1gg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YYJjXJwFJm1G6g8pDd9cVZgYlOrgsjn/Xq8mnEY18nrs2/MBkQA/clWmg7VQ/iWf5
	 POz52huKwZSmIEPzDaZx0KKZ/pAKz1JdultvkRYw7BSM5/0Yv9kCoQwunc9hfj4Wxr
	 X8D++GDw/uHbB2NHbqISmjnF165Iikh7OvFjvwaAT/JKM6U4BLzL1O9e4pvPMYelxM
	 4f+MAdGWSmW8h3Oj5eqWH6EavY7sowJp+XT197BKv6bl0zuaL+/BsyBvueEiKmCj94
	 +4dP11D8pdCuUH25Bacuhp6oPdmWWcHuFC3IetkHGkXyFnnd3fNdeOhn/MoLJig6qf
	 bzHvSGS24dWTg==
Date: Thu, 5 Mar 2026 09:37:54 +0000
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
Message-ID: <20260305-utensil-senorita-72c8c144b923@spud>
References: <20260224202854.112813-1-charles.perry@microchip.com>
 <20260224202854.112813-2-charles.perry@microchip.com>
 <20260304-nebulizer-rounding-40fbc81a2ba1@spud>
 <aahI1y0NO9ax/V8J@bby-cbu-swbuild03.eng.microchip.com>
 <20260304-unvented-crinkle-37f0bfd03541@spud>
 <aahkCah1pvuNIy03@shell.armlinux.org.uk>
 <20260304-mandarin-alumni-4b38a7743ee1@spud>
 <aah8akCJPTNkBrxs@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Pdi8VmtM7vzP52QM"
Content-Disposition: inline
In-Reply-To: <aah8akCJPTNkBrxs@shell.armlinux.org.uk>
X-Rspamd-Queue-Id: 5FAD820ED7C
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
	TAGGED_FROM(0.00)[bounces-264253-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,armlinux.org.uk:url]
X-Rspamd-Action: no action


--Pdi8VmtM7vzP52QM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 04, 2026 at 06:39:38PM +0000, Russell King (Oracle) wrote:
> > > > > Also '#define DEBUG' in 'drivers/net/phy/phylink.c' can help if y=
ou can
> > > > > recompile your kernel.
> > > >=20
> > > > Setting this provided no further logs, seemingly.
> > >=20
> > > It certainly would if you place it before the first #include - I
> > > routinely build kernels with it set as such. The messages are produced
> > > at debug level, so should appear via "dmesg". If you want to see them
> > > on the console, you need to add "debug" to the kernel command line.
> >=20
> > Clearly I'm too stupid for this, because I did it again and still got no
> > more logs. I even disabled DYNAMIC_DEBUG since that has an interaction
> > in the file.
>=20
> I'm sorry, I don't know what's going on there. As I say, it works for
> me. E.g. from two days ago:

Thinking about it now, it's just because the codepaths that I took in the
phy subsystem in the error case just didn't produce any logs.
Adding it does produce more logs in a working system.

>=20
> [  101.279224] mvneta f1034000.ethernet eno2: configuring for inband/2500=
base-x link mode
> [  101.287194] mvneta f1034000.ethernet eno2: major config, requested inb=
and/2500base-x
> [  101.294986] mvneta f1034000.ethernet eno2: interface 2500base-x inband=
 modes: pcs=3D02 phy=3D00
> [  101.303423] mvneta f1034000.ethernet eno2: major config, active inband=
/inband,an-enabled/2500base-x
> [  101.312541] mvneta f1034000.ethernet eno2: phylink_mac_config: mode=3D=
inband/2500base-x/none adv=3D00000000,00000000,00008000,0000a240 pause=3D04
> [  101.325123] mvneta f1034000.ethernet eno2: pcs link down
> ...
> [  101.447124] mvneta f1034000.ethernet eno2: phylink_sfp_connect_phy()
> [  101.453541] mvneta f1034000.ethernet eno2: copper SFP: interfaces=3D[m=
ac=3D4,9-12,19,22-23, sfp=3D4,23,27]
> [  101.462789] mvneta f1034000.ethernet eno2: copper SFP: chosen 2500base=
-x interface
> [  101.470563] mvneta f1034000.ethernet eno2: PHY i2c:sfp:16 uses interfa=
ces 4,23,27, validating 4,23
> [  101.479636] mvneta f1034000.ethernet eno2:  interface 4 (sgmii) rate m=
atch none supports 2-3,5-6,13
> [  101.488730] mvneta f1034000.ethernet eno2:  interface 23 (2500base-x) =
rate match none supports 6,13,47
> [  101.498079] mvneta f1034000.ethernet eno2: PHY [i2c:sfp:16] driver [Br=
oadcom BCM84881] (irq=3DPOLL)
> [  101.507043] mvneta f1034000.ethernet eno2: phy: 2500base-x setting sup=
ported 00000000,00000000,00008000,0000206c advertising 00000000,00000000,00=
008000,0000206c
> [  101.522979] mvneta f1034000.ethernet eno2: major config, requested inb=
and/2500base-x
> [  101.530778] mvneta f1034000.ethernet eno2: interface 2500base-x inband=
 modes: pcs=3D02 phy=3D01
> [  101.539213] mvneta f1034000.ethernet eno2: 2500base-x: incompatible in=
-band capabilities, trying in-band
> [  101.548732] mvneta f1034000.ethernet eno2: major config, active inband=
/inband,an-enabled/2500base-x
> [  101.557842] mvneta f1034000.ethernet eno2: phylink_mac_config: mode=3D=
inband/2500base-x/none adv=3D00000000,00000000,00008000,0000206c pause=3D04
> [  101.570425] mvneta f1034000.ethernet eno2: phylink_sfp_module_start()
> [  101.576903] mvneta f1034000.ethernet eno2: phylink_sfp_link_up()
> [  101.692254] mvneta f1034000.ethernet eno2: phy link down 2500base-x/Un=
known/Unknown/none/off/nolpi
>=20
> with the following at the top of phylink.c:
>=20
> // SPDX-License-Identifier: GPL-2.0
> /*
>  * phylink models the MAC to optional PHY connection, supporting
>  * technologies such as SFP cages where the PHY is hot-pluggable.
>  *
>  * Copyright (C) 2015 Russell King
>  */
> #define DEBUG
> #include <linux/acpi.h>
> ...
>=20
> --=20
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

--Pdi8VmtM7vzP52QM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaalO8gAKCRB4tDGHoIJi
0mMbAQDXOYsFss+g3rcCOxt30q4bcopopQiwgH+uxRHJUqxKvQEAmEF5UGzb90ua
qRslulKvODavZIQLPEdXWeOirV1btgQ=
=wn1y
-----END PGP SIGNATURE-----

--Pdi8VmtM7vzP52QM--

