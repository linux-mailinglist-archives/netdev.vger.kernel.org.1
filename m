Return-Path: <netdev+bounces-235419-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38089C303DB
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 10:24:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AAD1189D91B
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 09:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FDF931280A;
	Tue,  4 Nov 2025 09:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="1vOc/5SB"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960F72BCF41
	for <netdev@vger.kernel.org>; Tue,  4 Nov 2025 09:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762247843; cv=none; b=LydlXl1xO25octHWOVHBXWHHm6E0Rbka5T4Wyy38O2eIrexhpplQhNfZjvzdU1u0fHuJYmF1Dv36ooXPhVOy3IfXmfGOC4RBika2HncwXItAQ2DtEnNarnPVL+E3mFC5V15T9zWWvJf8A7FPi8oEy13Cm3YSBh4Hrg+EWwATl4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762247843; c=relaxed/simple;
	bh=7LhwKdynE4EzxVx33/qprxmtOT23EE+OCvjjg7efrOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sMyt2DoEvGEEXWWwcj95Q+/d61jFC8OnN5knYuvdESfcONwn6z/3/tPKwFpiQu4/FWMb/6OjUCRSIK6hJ3BX22D39rDP0Nwk8hUAyRCkseVsppuj+WCIJGIuP7dIcks62lM/HP2rmmz0cpMI00Fd0AbO+uum/82toosP3bp+FtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=1vOc/5SB; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 007FEC0E604;
	Tue,  4 Nov 2025 09:16:59 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D2251606EF;
	Tue,  4 Nov 2025 09:17:19 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2A97610B507AE;
	Tue,  4 Nov 2025 10:17:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1762247839; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=f6p2qczOAsk2xBhxzVdaFQqVrGOw0uNl+quFb7CJGCE=;
	b=1vOc/5SBU3HnNs8p+5ZxOjpnzSJ2BFHfO0Rs09DjkHf3URfV7wyjAXllFpAxT9Ln/YEw7G
	GIkm7kBJdfrTwrfk+bqQ5gXA8uuJYCbrdHJk9nqfSKRXxYPjheXdK+ejykBYxSyzKz0tO6
	N63H8AGNjuytV9Th0JYcNlbItgxK4lnhUZXJvaoETBHPzD2WK9RQKoK323ZMEGjBo5dnv1
	YJl6SHADa7MoZkFzrvJEzzrfXzprYmmpOm3835EqtzVqxrX+4gVligAdeeFDU9q7OuPlaH
	elgSwzIGyodDI5UrJ/GPRmf7U/VaAPbz1A8FZXHYtHJArWEk5yDtA6dTsv4mUQ==
From: Romain Gantois <romain.gantois@bootlin.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 3/3] net: phy: dp83869: Support 1000Base-X SFP
Date: Tue, 04 Nov 2025 10:17:16 +0100
Message-ID: <1937423.tdWV9SEqCh@fw-rgant>
In-Reply-To: <e2541569-bfee-4548-a399-af2e43c7a53a@bootlin.com>
References:
 <20251104-sfp-1000basex-v1-0-f461f170c74e@bootlin.com>
 <4689841.LvFx2qVVIh@fw-rgant>
 <e2541569-bfee-4548-a399-af2e43c7a53a@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2242209.irdbgypaU6";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
X-Last-TLS-Session-Version: TLSv1.3

--nextPart2242209.irdbgypaU6
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Romain Gantois <romain.gantois@bootlin.com>
Date: Tue, 04 Nov 2025 10:17:16 +0100
Message-ID: <1937423.tdWV9SEqCh@fw-rgant>
In-Reply-To: <e2541569-bfee-4548-a399-af2e43c7a53a@bootlin.com>
MIME-Version: 1.0

On Tuesday, 4 November 2025 10:15:45 CET Maxime Chevallier wrote:
> Hi,
> 
> On 04/11/2025 10:10, Romain Gantois wrote:
> > On Tuesday, 4 November 2025 10:01:36 CET Russell King (Oracle) wrote:
> >> On Tue, Nov 04, 2025 at 09:50:36AM +0100, Romain Gantois wrote:
> >>> +static void dp83869_module_remove(void *upstream)
> >>> +{
> >>> +	struct phy_device *phydev = upstream;
> >>> +
> >>> +	phydev_info(phydev, "SFP module removed\n");
> >>> +
> >>> +	/* Set speed and duplex to unknown to avoid downshifting warning. */
> >>> +	phydev->speed = SPEED_UNKNOWN;
> >>> +	phydev->duplex = DUPLEX_UNKNOWN;
> >> 
> >> Should this be done by core phylib code?
> > 
> > I guess that enough PHY drivers do this by hand that a new phylib helper
> > could be warranted. Maybe something like phy_clear_aneg_results(), which
> > would set speed, duplex, pause and asym_pause to default values.
> 
> Note that when phy_port eventually gets merged, we'll have a
> common .module_remove() for PHY SFP :
> 
> https://lore.kernel.org/netdev/20251013143146.364919-9-maxime.chevallier@boo
> tlin.com/
> 
> We could definitely do that here :)

That would be even better!

Thanks,

-- 
Romain Gantois, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--nextPart2242209.irdbgypaU6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEIcCsAScRrtr7W0x0KCYAIARzeA4FAmkJxJwACgkQKCYAIARz
eA4yDhAAgUfW/4Rfibr+BG/sDvQPk5XVPTOQcFIMp7pmUrqi9F4i4QzaBC75wWaI
bcjyK+clICQQ2E+moiEb864SHRXFVtyRu5egj97YA7LEeOJp6hSPggHLW1eL1idZ
R3VsHfJzj/ShLPSvZfjFw8fVfWEAGcOJyB/8U2OOJ/Vn5DOpUyINxzs2JYaAvJ2N
+Fj8e92YeBLtTzCS6YjhHEXOqvs0Ml9+QQDKvsNNLs5WsRZLLXsjTHr/u3Vx9C5d
AJc/7lKcJTJu02yoNrNPuZ0m3vFAF5RPKoJhAyPb2KU2ANqM5VqJj8F7xkF97Fuz
Djc2RaGAnIvQD4kF2zh/x6iqDVTQaetwXZmygA1HbsMG+WdUTBFHu8lIQzFYY2/9
i+i9I0ppk3SoV1Ehr9IaDRMu4NM8XLUeoPDrJXo2KVaK1iktPgguFLnbCXSaRDVX
EccL5JneNv0eWHIFpW3kYLreNPSqx+n+f8w46bWtCGqwJfenVqxQ7CBYry6cJkke
suPNescqDy1ISJ8E8dTRRxsF1w1F4j9OLnQx7xPn3B4AbEfsFEYVRY+RmJG4NgcO
3xBm6C3OI5jmwr0IMxl35cUJugOJc7s7QSaspdt6/YK6t/4TOUEOC8aZD5Z5f1rN
rupUGeL/y1FE5ufgPeBAclkw+vTzauh63oIde2P044eJeJTRv6Y=
=FETM
-----END PGP SIGNATURE-----

--nextPart2242209.irdbgypaU6--




