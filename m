Return-Path: <netdev+bounces-238261-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A6AC6C569E3
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 10:35:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E64494EC3A3
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 09:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A7D32D0C99;
	Thu, 13 Nov 2025 09:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dkwjFz3S"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA081531F9;
	Thu, 13 Nov 2025 09:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763026069; cv=none; b=LlmQpD8eACWLSNto9opOkxp7I4fOFE4hfr5OR0HbpGc87PyYk9biExDdtQXaaZOZMgChX3q9z57YOgQBS6IfnLE49Ey9e9QwG2sdqD8Y7SYD79XI3q+xBCFg02nF1Yf5F8RsNqioBasueqPYubxnz5phIq0TeEDNz6jmvpMOwsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763026069; c=relaxed/simple;
	bh=fljBpF7iFGdonycP/S1o1Q8eOIRN2uMoEwTrqRJEdcc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BeKZsRzZCQbLhhC/LAe3rOltgpThTekEm9rJiCEVfugLB43qJrRIHNGaFnZ+8kb5/OiPsEuC4BSvZq8ahpdOkN+mSWCCpEMS2lnRg5VWwvbokKF6kmlBKadEQVMLH7KGdPXsgo5S21A9zuAapekJj2rtkTArwu1fuux+qaWcCGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dkwjFz3S; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id B443CC0F57C;
	Thu, 13 Nov 2025 09:27:22 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 49E6B6068C;
	Thu, 13 Nov 2025 09:27:44 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5F833102F21A5;
	Thu, 13 Nov 2025 10:27:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1763026063; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=vbkQXEu7w8lfId/GAbvVnvVBMO7rGQpsi1raOuHe1YY=;
	b=dkwjFz3SfbHAqDqzb02mCIUmRdgYHrR0dSD2zbwWuudHTk7dHCEkuGyqZbjz2MG9uXPMfW
	YHxBBfI6hbQIPXQoHrQ71PP262mUOv9HpBwYlTup9hQTj7fqbYbBtOxi/iwYo5mA/KeS3S
	E1lsWwCErhFCFZ/d5TGEeqOpGJRnrP06DoMy9vkh26e3qR/Euy5IC/+2vtokMJJR9AFTev
	SG14of/lzSYDZPLLQ2Bt05p4HaJMahHBgSJnVh/OWq1F6yCI7Wo8Ut0dxbVMuShVdQWgow
	lXo+lKXqTxBYCDNbHiYt+EZkBVzWpJGkDTBxzqFvKP1lrR4WE8BMjOIw4bu9gQ==
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
Date: Thu, 13 Nov 2025 10:27:34 +0100
Message-ID: <10753836.nUPlyArG6x@fw-rgant>
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
Content-Type: multipart/signed; boundary="nextPart2329569.iZASKD2KPV";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
X-Last-TLS-Session-Version: TLSv1.3

--nextPart2329569.iZASKD2KPV
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Romain Gantois <romain.gantois@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>
Date: Thu, 13 Nov 2025 10:27:34 +0100
Message-ID: <10753836.nUPlyArG6x@fw-rgant>
In-Reply-To: <924891c9-fd34-4e7a-bca9-007c80bc327f@lunn.ch>
MIME-Version: 1.0

Hello Andrew,

On Tuesday, 11 November 2025 02:08:05 CET Andrew Lunn wrote:
...
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

Yeah the idea here is that if the LP changes, then the autoneg should be 
restarted afterwards. But doing it in the module_insert() callback of the PHY 
driver is quite complex as far as locking goes...

Maxime's phy_port series will make quite a bit of SFP code generic and will 
conflict with my series, so maybe it's better that I wait for Maxime's series 
to be merged before sending v3. Then I can try tackling this in a generic 
manner.

Thanks,

-- 
Romain Gantois, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--nextPart2329569.iZASKD2KPV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEIcCsAScRrtr7W0x0KCYAIARzeA4FAmkVpIYACgkQKCYAIARz
eA5eSQ//WtpMLLhBsgL99RREAmHJaMI6ZEJjl8x736YHyaG/7dE1U50SqzAmh8H8
FijaFWVHiP2XMVOCCjmDLWrj7hISU62VA6V1qCr38DJ1nDeKPkfEcz2B9nwQBvAE
RBOINiW9VOlYwJaZGnnsXz9pdYLHUrOfkx35uLvKN/tyOA3AbGECApi/v5kkrPxi
KJvbLUThyP1LvIXqS/Fx7bQG1wYO+HuRxEEsJEyE3T8yy2fvN3PoNLDdS/QDmt6V
VRl07jjP6m0XQ//6n6FfBATMGtdnlyxyMwvGdjwYUbbckMJypi/ZTYTATMocEZE3
+I4OrOaEIPpLg6rZt79usAzgAku7/SHsUY91n1Wa7Rt5DbKM1Kq706nX74bg6OCb
JVmCWFafPkUVUxN2x0Zl/PLFnfGp+mpnYPz5GL4xHT2MKafZCCin+wmvxmfTV+1Z
6WP7PflyrDk3ybg8a+5wq0576j7+KyL6Yf0rKqLGBAcDi/F/SITmmY2NqyuXgNu8
W7MTrJ2Fih46Op+aIYI0iBa4x/22NTuAbVVfmZgHxkxn5uvr6qFYFqZHrFCRThrc
TR9XEarKt7Eg4ikWo0OjvjvHJfhWk8fXD5qLWDNl+tEZMPXCqZ/7AA5he2M891sM
7ZNwdgJZ+WeJP5V/BXVG0MyuBLvGMkTOisCVb3fxG8pmxfPynzA=
=k9e2
-----END PGP SIGNATURE-----

--nextPart2329569.iZASKD2KPV--




