Return-Path: <netdev+bounces-304516-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3xssB4yeR2qScQAAu9opvQ
	(envelope-from <netdev+bounces-304516-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 13:35:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 73DD5701E68
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 13:35:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=O1SLrBLn;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304516-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304516-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CAA393007E3E
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 11:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36FD8371860;
	Fri,  3 Jul 2026 11:29:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679E032FA2C;
	Fri,  3 Jul 2026 11:29:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783078168; cv=none; b=P68ciJ6YWxE2CUb34jy6ZCPEeN1Q0KBRUBgZtx3gG1Bn8mssOkcUiA9sXhNwMXtqPZkW1vlN5wwhSL2jX5Y7NUhCY5Ll5pU5a7dFdksbNDCydtP8oP0A0EfDxWUQt+RUsw2mKRfUdAK09GLzgEMFV7q9zbdyG7fHrmHApGMMSfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783078168; c=relaxed/simple;
	bh=jlk6O5BjCPJSnRVl18eI7ybdbR77bdupSyj+B8T+peg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h/NIKS79ryO9glgRaKZNU+LmlRWVsW//chVIypyOtZmxVEfujOIXvIkLz+Xh9/x4cKvoh8tD11oqzCt7VsEtewVvHaxeF1nKCXu2vqAziGsRoHXgybDCZxxh/i0J8rO+Ffc74PohKEZTzvt0FkWIxsipLcjNv+LRYaRdSah0JOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O1SLrBLn; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6C2B1F000E9;
	Fri,  3 Jul 2026 11:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783078159;
	bh=nhYEhzI2zrGJ5BQVU/pw8kBzQBK5diB7Er9NsAUP/sc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=O1SLrBLnC0X962dpqHKSAPzFFfTqEOTns59EWY6pbU7a6SatJYz+gLa0D13Uuk9e5
	 4IVxYQOuP8uwkWJV1Fy/DzbHngt8EfoSQqK7og2akwTNSflt1zDjAiZJYgYVlp3RU2
	 AxWhDFBcu7ganwPZuaokZ5eWjigNpXuEszJoPNsf4rD2NAffZjXl8V7hPjuhkwzaqh
	 Lbno0wzXFAXPQRtwIvvMkxazATzzt3pX97srzjG2LrmUFqkWWtOa+LEO7QJlQiYck5
	 LvVss85IvE/7tMZ9gRbfNBDvrIqAe4eO8VxdIGjr11LblforyJ5O8D7eH8SZ3niPql
	 2LF+W+pYuBUPQ==
Date: Fri, 3 Jul 2026 12:29:13 +0100
From: Conor Dooley <conor@kernel.org>
To: =?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>
Cc: Conor Dooley <conor.dooley@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Paolo Valerio <pvalerio@redhat.com>,
	Nicolai Buchwitz <nb@tipi-net.de>,
	Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	=?iso-8859-1?Q?Beno=EEt?= Monin <benoit.monin@bootlin.com>,
	Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v3 02/15] net: macb: unify device pointer naming
 convention
Message-ID: <20260703-plant-remark-e6e2e7cf8a12@spud>
References: <20260701-macb-context-v3-0-00268d5b1502@bootlin.com>
 <20260701-macb-context-v3-2-00268d5b1502@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/8cqNE0dp0l3TZIn"
Content-Disposition: inline
In-Reply-To: <20260701-macb-context-v3-2-00268d5b1502@bootlin.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.26 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCPT_COUNT_TWELVE(0.00)[21];
	FORGED_RECIPIENTS(0.00)[m:theo.lebrun@bootlin.com,m:conor.dooley@microchip.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:richardcochran@gmail.com,m:linux@armlinux.org.uk,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:nicolas.ferre@microchip.com,m:claudiu.beznea@tuxon.dev,m:pvalerio@redhat.com,m:nb@tipi-net.de,m:vladimir.kondratiev@mobileye.com,m:gregory.clement@bootlin.com,m:benoit.monin@bootlin.com,m:tawfik.bayouk@mobileye.com,m:thomas.petazzoni@bootlin.com,m:maxime.chevallier@bootlin.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304516-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[conor@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk,vger.kernel.org,tuxon.dev,tipi-net.de,mobileye.com,bootlin.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[microchip.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,spud:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 73DD5701E68

--/8cqNE0dp0l3TZIn
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 01, 2026 at 05:59:05PM +0200, Th=E9o Lebrun wrote:
> Here are all device pointer variable permutations inside MACB:
>=20
>    struct device *dev;
>    struct net_device *dev;
>    struct net_device *ndev;
>    struct net_device *netdev;
>    struct pci_dev *pdev;              // inside macb_pci.c
>    struct phy_device *phy;
>    struct phy_device *phydev;
>    struct platform_device *pdev;
>    struct platform_device *plat_dev;  // inside macb_pci.c
>=20
> Unify to this convention:
>=20
>    struct device *dev;
>    struct net_device *netdev;
>    struct pci_dev *pci;
>    struct phy_device *phydev;
>    struct platform_device *pdev;

Oh lovely, OCD approved.
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

--/8cqNE0dp0l3TZIn
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCakedCQAKCRB4tDGHoIJi
0iHXAQCIrhUS2y3KjGpoKQZoWWwT6ila9E1u8Zd419pgu3Lg6wEA62Iqqppd/AkZ
sg0RekYDVFleJj2vfE8vjKIYmAV+dgk=
=RSd3
-----END PGP SIGNATURE-----

--/8cqNE0dp0l3TZIn--

