Return-Path: <netdev+bounces-297725-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SX6fL9uBKWrAYAMAu9opvQ
	(envelope-from <netdev+bounces-297725-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 17:25:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B0566AB22
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 17:25:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=tUzt42Mf;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297725-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-297725-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=bootlin.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 92A0230EEF72
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 15:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D09540B364;
	Wed, 10 Jun 2026 15:12:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554723264EF
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 15:12:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781104330; cv=none; b=H8PYVJIikkblwQ1G0YC9TajmBZUm1p66ZEKzPGryQ2UFYfRi86FszoZL5sw2LFCY3xOehnWume82gfVV8oiaI8IzjqlYSYpas0tiP6xAaVyWXUfEESqX2twiLT5+ei0S+9zMTG/K+6hyanMi/yxTNk1JPMWVgIMpXAbGMQ0Fk+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781104330; c=relaxed/simple;
	bh=QeZUpnZf7rk/cbA5VgTP2YGcRr1cPs58PGXiwOVF3b0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d765QcTthZlXFsmKboyDjDf0OJ76CRuu+MJ98Deovj1A04XhDXpOobT/BiA5iZlH4y40tfacZWWGcLRMet0+h1eTajJCkR/5m53t0CgM4X0GkvPFq/wJhbWeVQIm2DAJYQOfmIwCGVBUdEbNl0hsw83RlA859deJ3idCAlVeXi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=tUzt42Mf; arc=none smtp.client-ip=185.171.202.116
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 7BE35C4FEDD
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 15:12:07 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7D8745FFC9;
	Wed, 10 Jun 2026 15:12:05 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 49FBB106B99E0;
	Wed, 10 Jun 2026 17:12:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1781104324; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=o6l+rnoA+kXGuxELDWVmdXFoNjpxTaMvFyhPA/rKqEQ=;
	b=tUzt42MfMSjGBfoyCkp7rBWugD/UntyIVo7oIW81h3OmOA49ndpVT3TluuCtv87znJZmC7
	JBY2Y778oH+qnPd10t/r6KLRRt9MBVznxjbLZJr5kCl+DJzqk/5S5piTRdwIVggQr/W4nn
	C9DFNj/Gn9C6M6v/m/+2Y9LdJT384kFXzhtFUP9cyQusbaJO/N2Eg0IsBZnrs8spWWOQm6
	QyJyjiHJw0breUbLeMIZfEzz0Nb5ZjByeYm78wSfXgJQia+Wllhc75lTPwonaszuP4jfxC
	oM6Llsq5usiTgmwJ19n8N37qjI/cbysv4EeEArjM0WqvbFHPwA1wXF/ir00r8A==
From: Romain Gantois <romain.gantois@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 3/3] net: phy: dp83869: Support 1000Base-X SFP
Date: Wed, 10 Jun 2026 17:11:54 +0200
Message-ID: <a5OAN5n1TlqpbApOWnEEjQ@bootlin.com>
In-Reply-To: <924891c9-fd34-4e7a-bca9-007c80bc327f@lunn.ch>
References:
 <20251110-sfp-1000basex-v2-0-dd5e8c1f5652@bootlin.com>
 <20251110-sfp-1000basex-v2-3-dd5e8c1f5652@bootlin.com>
 <924891c9-fd34-4e7a-bca9-007c80bc327f@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPartElc4E6qgS0aaEan5cvSc3g";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,bootlin.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-297725-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:maxime.chevallier@bootlin.com,m:thomas.petazzoni@bootlin.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[romain.gantois@bootlin.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[romain.gantois@bootlin.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 19B0566AB22

--nextPartElc4E6qgS0aaEan5cvSc3g
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Romain Gantois <romain.gantois@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH net-next v2 3/3] net: phy: dp83869: Support 1000Base-X SFP
Date: Wed, 10 Jun 2026 17:11:54 +0200
Message-ID: <a5OAN5n1TlqpbApOWnEEjQ@bootlin.com>
In-Reply-To: <924891c9-fd34-4e7a-bca9-007c80bc327f@lunn.ch>
MIME-Version: 1.0

Hi Andrew,

On Tuesday, 11 November 2025 02:08:05 CEST Andrew Lunn wrote:
...
> > +static int dp83869_module_insert(void *upstream, const struct
> > sfp_eeprom_id *id) +{
> > +	struct phy_device *phydev = upstream;
> > +	const struct sfp_module_caps *caps;
> > +	struct dp83869_private *dp83869;
> > +	int ret;
> > +
> > +	caps = sfp_get_module_caps(phydev->sfp_bus);
> > +
> > +	if (!linkmode_test_bit(ETHTOOL_LINK_MODE_1000baseX_Full_BIT,
> > +			       caps->link_modes)) {
> > +		phydev_err(phydev, "incompatible SFP module inserted\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	dp83869 = phydev->priv;
> > +
> > +	dp83869->mode = DP83869_RGMII_1000_BASE;
> > +	phydev->port = PORT_FIBRE;
> > +
> > +	ret = dp83869_configure_mode(phydev, dp83869);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* Reconfigure advertisement */
> > +	if (mutex_trylock(&phydev->lock)) {
> > +		ret = dp83869_config_aneg(phydev);
> > +		mutex_unlock(&phydev->lock);
> 
> Why is it safe to call dp83869_configure_mode() without the lock, but
> dp83869_config_aneg() does need the lock? And what are the
> consequences of not being able to get the lock and so aneg is not
> configured?
> 
> Some comments would be good here.

Since phy_port has been merged, I'm currently preparing a v3 for this but I'm 
in need of some general guidance regarding this `mutex_trylock(&phydev->lock)` 
which has (rightfully) sparked some concerns.

What data is supposed to be protected by the `phydev->lock` mutex? Is it every 
field of the phydev struct + standard hardware registers + vendor registers? Or 
only a subset of these?

Thanks,

-- 
Romain Gantois, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--nextPartElc4E6qgS0aaEan5cvSc3g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEIcCsAScRrtr7W0x0KCYAIARzeA4FAmopfroACgkQKCYAIARz
eA428g//YXSHZAdvZtVkL2fLjSjQHsUNM8lPF5ChyyQk7Xxo5IvdqypLPhY5u7DG
gxGbTrcwG/Q5RDCZrEacxl41JfpncEOmuU0HvgziWBW0ZUcjWhA4XmYZ1ELzKx3K
2g4pd1/VRTvrjs1sLht31SmuPe6N6YiYGgXUnUVOIaqKRRrYMAJEyGoH/QrJSOHs
iu4ZC6wHl8UK/A8WMI8c74vamYrkacF9U+x2gVMFrfdVy1b63DJbju1NeMp5iM6B
LilZRuENNx1rtKkkynif8eHpyFjFlJdi/ZRXB75Dp7MVU4S28CVamzJA9tRhY3wE
DokwO0fD9rZsNJjzVYVxi3vHjVyRJPzrSQ6mGgo22j2nRqTHU/rxnzzTj5p9jrtf
6e/YuplirAmdrxDnFNCh0v1cr+HVgaev7U3xcVsPKx/QF7PppfBKAQVCLhYsDW1v
eXJ8LL6LNy4/2QfnanHsLX6sRtbP7HevfQV5Xu0skeqL84nV8y8DIy6tJKTBFvwR
I2CrQvM9EwDYSezWfBT2hMlrftmPgm0/5350VkR0dG2mqSvIZK4XPMqLXTgJc2Tu
8zttB6by6mJ7nOiUdcg1n05k1jQtG7Y5sjYSHR5KVPx+w7QHMox+tbF+W3bZScsN
IkDp4a36THVAftAJFslay0VZkQZqPvY9AnCJhJZvWBsNMxfUa3s=
=NtVi
-----END PGP SIGNATURE-----

--nextPartElc4E6qgS0aaEan5cvSc3g--




