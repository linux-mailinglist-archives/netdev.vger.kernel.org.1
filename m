Return-Path: <netdev+bounces-264438-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0GkLM4KcqWnGAwEAu9opvQ
	(envelope-from <netdev+bounces-264438-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 16:08:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F233E21431E
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 16:08:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4C4533097D60
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 14:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19DED3A8FEA;
	Thu,  5 Mar 2026 14:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KS2eLqxX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4983A5E6B;
	Thu,  5 Mar 2026 14:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772722175; cv=none; b=uLeW0zc0ff+T62dQ/40NEIPVEo2vp8dvwukrGO/C3NYFs9e3e/rHIcS5vTYHXFrhYtf1NoP1Er6pTZnFurTsWqVfZeD8AYrVWsjpJk+2OwI9KCC+jlDQEs9ZOaiju2j/aAG8nWie2zDcgQ/2NEMvFSOiLekQ151t19J8clO6skc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772722175; c=relaxed/simple;
	bh=UfEb1q/l9qjlTMLq3/PTHwtJBl7Gqr49bdbx+RpR6VY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ipMXjmBfcQivrQHzo08DudSyrOWDDuF7oHKALkq4oW826ruHtsJBh/U6H2jFudgytXeMosgh3w2uN7/O7AZG8v/Bzy95+2VKc/C8tOEHV9zspK8tmWWnzkOJmAuxj+SAoqHtYXfCURulKWBXx93KEf8iGcb9jMW3SXscyrN5mFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KS2eLqxX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31AEDC116C6;
	Thu,  5 Mar 2026 14:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772722174;
	bh=UfEb1q/l9qjlTMLq3/PTHwtJBl7Gqr49bdbx+RpR6VY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KS2eLqxXOlPpKU+yB+wT49XqYD0qihxSkT2CzPsBqFM6Ff5GLyzH3cmUo24Y2F6p4
	 k1ns9J/ZLOM8ax8pXyhZ71DNryyLbJ5mz20qop6ptoOCd8GYZ3OFQq+g5vj4SWpizl
	 d854QFpQFq/RhJd0DJZHEaEAmB7juM3TlVbwWDb37hKqMwZTZVjy7z8X9jbpjuMLXp
	 pbsZzdsM+T5CTJ+oK+kH7PN8NC3EMapKnudUnuJfWMUuyBjddjCWxPnpJ2RRsymh1G
	 oNoo0zQOtW6PWLiTPthnPwlcYVblwetIdzQAfGl/iOhJtS2N1txM2ho7sHAfwukQQJ
	 j2em+bppVvH5g==
Date: Thu, 5 Mar 2026 14:49:30 +0000
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
Message-ID: <20260305-kooky-refurnish-3ebbc964a8c0@spud>
References: <20260224202854.112813-1-charles.perry@microchip.com>
 <20260224202854.112813-2-charles.perry@microchip.com>
 <20260304-nebulizer-rounding-40fbc81a2ba1@spud>
 <aahI1y0NO9ax/V8J@bby-cbu-swbuild03.eng.microchip.com>
 <20260304-unvented-crinkle-37f0bfd03541@spud>
 <aaht0/XpUCz+58bz@bby-cbu-swbuild03.eng.microchip.com>
 <20260305-backlit-epilogue-62139ae694a6@spud>
 <aamLf63OfJ5RH69v@bby-cbu-swbuild03.eng.microchip.com>
 <20260305-fantasy-useable-40ca04f0266e@spud>
 <aamS-LPZaOfamwQC@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dfSx/xhs5e31zFL1"
Content-Disposition: inline
In-Reply-To: <aamS-LPZaOfamwQC@shell.armlinux.org.uk>
X-Rspamd-Queue-Id: F233E21431E
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
	TAGGED_FROM(0.00)[bounces-264438-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action


--dfSx/xhs5e31zFL1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 05, 2026 at 02:28:08PM +0000, Russell King (Oracle) wrote:
> On Thu, Mar 05, 2026 at 02:13:24PM +0000, Conor Dooley wrote:
> > On Thu, Mar 05, 2026 at 05:56:15AM -0800, Charles Perry wrote:
> > > On Thu, Mar 05, 2026 at 09:42:19AM +0000, Conor Dooley wrote:
> > > > On Wed, Mar 04, 2026 at 09:37:23AM -0800, Charles Perry wrote:
> > > > > On Wed, Mar 04, 2026 at 04:23:30PM +0000, Conor Dooley wrote:
> > > > >=20
> > > > > Are you able to check register 23, bit 13 of your PHY by any chan=
ce? Maybe
> > > > > with the mdio/mii commands in U-Boot if you have that.
> > > >=20
> > > > "mii read addr 23" returns 0660 for both PHYs in U-Boot.
> > >=20
> > > Oh, I think you fell into a trap of U-Boot's mii command.
> > >=20
> > > The arguments are always in hex even if you dont prepend "0x".
> >=20
> > Eh no, actually I thought that you meant register 0x23. I'm not used to
> > register addresses being given in decimal.
> >=20
> > > What "mii read 8 23" did is most likely read register 0x23, masked wi=
th
> > > 0x1f because clause 22 has only 32 registers. So it read register 0x3=
 which
> > > is the device identifier 2 register: 0x0660.
> > >=20
> > > The exact command should be "mii read 8 0x17", "mii read 9 0x17".
> >=20
> > Both read back 2004
>=20
> It would would be good to see the content of 0x1b, specifically bit 13.
> The PHY supports AN bypass, and I suspect bit 13 is zero, which means
> in combination with bit 13 set in 0x17, the PHY must complete the SGMII
> exchange with the MAC.

They're both 0401, so yea. I'll give the vitesse driver change a go
later.

--dfSx/xhs5e31zFL1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaamX+QAKCRB4tDGHoIJi
0iVKAQDRUl3P6H2G7A6lkU7canECc7+AFn3uKOX0QtmkFjl21AEAlQC9heMF4J47
GoPaVEQM4GUOsJFTB+sVElZeuMzHAAs=
=AJGt
-----END PGP SIGNATURE-----

--dfSx/xhs5e31zFL1--

