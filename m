Return-Path: <netdev+bounces-264255-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mDimFVdSqWkj4wAAu9opvQ
	(envelope-from <netdev+bounces-264255-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 10:52:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6061F20EFD7
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 10:52:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 12D45304E73D
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 09:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7901245031;
	Thu,  5 Mar 2026 09:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aGReRi5e"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84429336885;
	Thu,  5 Mar 2026 09:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772703744; cv=none; b=T7ROzEiSsmHQ1kp9XJGC5BATrarFRJMf2hX9VTGnM79tAgcduz8BI+KqmOv/cRuVjeGqiyyU1tcnh/qZui+vSCzrg9kOvVTszN9CfCSpKobKRWTcTKlxFO5bQcDTvXMKwNoYa1X5+JlPb23n1qraAWesFZHeoojGkltBGn2GJ50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772703744; c=relaxed/simple;
	bh=6nMtekn6cDS8/3gsRfHLyG1lS2JDMzRmAHUr4/sNaCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MPV8uGaRWx86dQuRuvHBxzR89i3ovZSeizt2i/Icoamfs5a+ZmEf7EQ14UW+CqrS0WvNErTAEdQNmvENRVWkM5ZfpwiR4pai4p3aoq5CaHPoMFwZJiKJ/VUmuw3KVLTLMTjtiUBRVkExKpuyFxXf0hQbeCio5YSiAWJhcWn/+hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aGReRi5e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB74FC116C6;
	Thu,  5 Mar 2026 09:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772703744;
	bh=6nMtekn6cDS8/3gsRfHLyG1lS2JDMzRmAHUr4/sNaCY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aGReRi5ehY+g6wkFYKnSULGwTBrwNMMSoGe3LONnqNkBJ1j5la+s7JeweerB6ywsT
	 hKEg70FGAkhjFt+x9pIQvhb1WgpiHAiig1DIYF+V+v8FbxCDxycQeZFanQDDU43GOv
	 zQ1OFe+mPSFKxq6v0hs9EPmJehi15k5QmVTlAxgR0Sc0GX3QS72oxgcOZboqgeWwDG
	 wpiVvAvMfb/sWZfqOlbgVAOXDfW3WnipXQPx6GMVS9hAM1Xp+Ch/uSAfxjU0cgZ8SJ
	 HJ7SYONnSE+w78vhsHrYWjBxP7LyXfJddwHSl3hcwfut11y3/FFwmmKjLHOLc9sTpD
	 +KHU4Cy/6OAnw==
Date: Thu, 5 Mar 2026 09:42:19 +0000
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
Message-ID: <20260305-backlit-epilogue-62139ae694a6@spud>
References: <20260224202854.112813-1-charles.perry@microchip.com>
 <20260224202854.112813-2-charles.perry@microchip.com>
 <20260304-nebulizer-rounding-40fbc81a2ba1@spud>
 <aahI1y0NO9ax/V8J@bby-cbu-swbuild03.eng.microchip.com>
 <20260304-unvented-crinkle-37f0bfd03541@spud>
 <aaht0/XpUCz+58bz@bby-cbu-swbuild03.eng.microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MBwEv1bNkPnDVrP4"
Content-Disposition: inline
In-Reply-To: <aaht0/XpUCz+58bz@bby-cbu-swbuild03.eng.microchip.com>
X-Rspamd-Queue-Id: 6061F20EFD7
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
	TAGGED_FROM(0.00)[bounces-264255-lists,netdev=lfdr.de];
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


--MBwEv1bNkPnDVrP4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 04, 2026 at 09:37:23AM -0800, Charles Perry wrote:
> On Wed, Mar 04, 2026 at 04:23:30PM +0000, Conor Dooley wrote:
>=20
> Are you able to check register 23, bit 13 of your PHY by any chance? Maybe
> with the mdio/mii commands in U-Boot if you have that.

"mii read addr 23" returns 0660 for both PHYs in U-Boot.

--MBwEv1bNkPnDVrP4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaalP+wAKCRB4tDGHoIJi
0rvnAQCh2tlIYt2+GfA9dBCqmitWJE6fmJZX0wxuhjyvlHtc/wEAucEeKMzops28
UHeZAknYQ6c5LPDLP2iX6GlrpHsuxAM=
=S5Cu
-----END PGP SIGNATURE-----

--MBwEv1bNkPnDVrP4--

