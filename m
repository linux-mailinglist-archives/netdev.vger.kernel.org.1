Return-Path: <netdev+bounces-235416-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C74BC302E7
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 10:10:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EAE3234D287
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 09:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA3730BF58;
	Tue,  4 Nov 2025 09:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="SETdWZYD"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECC329B8FE;
	Tue,  4 Nov 2025 09:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762247451; cv=none; b=HDTPOo16ouzOsRZD3RIzcl6BUbS7jKJQfAWTKpub0jHeiKy48SmDX+yglV453hswJP1oezH+l/hfnQ7PPhLwucspk8mruROk6ZhdEJTYZ8MwHxqM9RDLbJlmOaHXNVhki3Pk7eXokULukvOwdZ3uSihEyQp+Xsg2ajLMUg1x2dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762247451; c=relaxed/simple;
	bh=LMpQCdO4DpvAzMy+0oVJL+k1kGwvMBsIaCidJwajyks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AmJkHrvn6QgfeLZTi8HyD9WFZW5J2/XjUrJi/AH7Xu3i55wxZuQHfR3n6w/4Mgm4OYRMnZsRofh9RUgn3ArjxyFFdCK9VnUsLyMgrBiHE56Mm/P/yqhp95OZ0yduKumZFnJn3Dwt3v+jvqQscc9uS456PHktKasG2AEDX3hI8f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=SETdWZYD; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 64F224E414F0;
	Tue,  4 Nov 2025 09:10:46 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 33A79606EF;
	Tue,  4 Nov 2025 09:10:46 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A4FB410B5069D;
	Tue,  4 Nov 2025 10:10:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1762247445; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=YLPevIWNzxiE5TizcrRb1gViSqpYMR7gcBGkGD5xEPw=;
	b=SETdWZYDwG79HdPDQOgaK4ZpKVa7hYoJHZd/Nwx6oW++IuWO9MmQlogCN7P/w/vpow0mnF
	mHcNu+LBfLIKvWh9xJaP1U1SFNtciG4xcPMSnVulmks8W3lRKUqm6tu2Q7WSeIjl1fJR2P
	jbEtl8qOYVThT6eOJLTlmcDkwuu/1a7JhK6U1Or1wQ7GZjNnP2hyuU2gn5LPyGV77kBk9Y
	aMzf0V2xLRE6jB3z7Bl5owg81DjU7sJu1VGMpWYyNUBHsqYkkHzkVQyRV9Ig6oWXD0VDdB
	fXGQt87aoI6xDvuH0UjuFseT8Pn9V6Pl76/KxcGSR7pUroYd3FhUpOcXHV1eDA==
From: Romain Gantois <romain.gantois@bootlin.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 3/3] net: phy: dp83869: Support 1000Base-X SFP
Date: Tue, 04 Nov 2025 10:10:42 +0100
Message-ID: <4689841.LvFx2qVVIh@fw-rgant>
In-Reply-To: <aQnA8HZjKKgibOz-@shell.armlinux.org.uk>
References:
 <20251104-sfp-1000basex-v1-0-f461f170c74e@bootlin.com>
 <20251104-sfp-1000basex-v1-3-f461f170c74e@bootlin.com>
 <aQnA8HZjKKgibOz-@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2387650.ElGaqSPkdT";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
X-Last-TLS-Session-Version: TLSv1.3

--nextPart2387650.ElGaqSPkdT
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Romain Gantois <romain.gantois@bootlin.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Date: Tue, 04 Nov 2025 10:10:42 +0100
Message-ID: <4689841.LvFx2qVVIh@fw-rgant>
In-Reply-To: <aQnA8HZjKKgibOz-@shell.armlinux.org.uk>
MIME-Version: 1.0

On Tuesday, 4 November 2025 10:01:36 CET Russell King (Oracle) wrote:
> On Tue, Nov 04, 2025 at 09:50:36AM +0100, Romain Gantois wrote:
> > +static void dp83869_module_remove(void *upstream)
> > +{
> > +	struct phy_device *phydev = upstream;
> > +
> > +	phydev_info(phydev, "SFP module removed\n");
> > +
> > +	/* Set speed and duplex to unknown to avoid downshifting warning. */
> > +	phydev->speed = SPEED_UNKNOWN;
> > +	phydev->duplex = DUPLEX_UNKNOWN;
> 
> Should this be done by core phylib code?

I guess that enough PHY drivers do this by hand that a new phylib helper could 
be warranted. Maybe something like phy_clear_aneg_results(), which would set 
speed, duplex, pause and asym_pause to default values.

Thanks,

-- 
Romain Gantois, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--nextPart2387650.ElGaqSPkdT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEIcCsAScRrtr7W0x0KCYAIARzeA4FAmkJwxIACgkQKCYAIARz
eA4Lgg//ZkSNIz8w17WdBe/2GkkDoBqglESJBCzjpe+Pheqlcw+QL4RECY0JIfUy
Lz6bNYx412qsAN2LEcSbwrOBzbwLM5KXEP5jBC7jM1nn/8+Z5iILA9ccFTNbbMce
2IQO3Ne1zZRkf4xRECPLU7rFh/kzMKOiarXTp+90dwebYEJ0s4SN/ODRXMw4T6OP
ZeK93PZ3QKVLSyt7m8m4h/Na7NHnLcIZhefl8aRnX3j36AeHdv2WWh4+io5L7DMl
nIch/GVH3++ah0W8RZmj6Cagd0MFzO3M0QKawHbTPsLF3U2CHY0dFJxSY0fKERrT
MvzL3CzPKyaqQtg6mG+WnS0sFWqvQ6DiVb5gmIldwwBCJr1KIzLTxDq3UDQJize7
nZgEHqbcdnEwQlKM3KnipbyOVodDlKjOJKEC9vMk/OjeUNVAqg8bT0RH1OdH5c7d
aHvOxTqfY6GXeNM2xz3Sy0VYTEaedGAtfF1jdwna78ArsNj+eXFuPnAKWRwjKYI0
D6Yxe4ZZSjAse6ujm4Yn0C34SRCYFW6jPa6GoQbfRQUhoJZgXGpRR+OapIQkjfJG
Gyl+SWP0Scr4O3sJ/GUIh50ZRvkB2evoLeVQyhaKO2DOgh57A1Vlqg7xhZgsDWvh
rGg0fYENiRiBlBs2inSmgd1FhhjwNlGU/FSbEsf4oZ4kQzLDMQc=
=o8N2
-----END PGP SIGNATURE-----

--nextPart2387650.ElGaqSPkdT--




