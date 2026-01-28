Return-Path: <netdev+bounces-254668-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mBmjBdAhe2mZBgIAu9opvQ
	(envelope-from <netdev+bounces-254668-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 10:01:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A023AADE86
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 10:00:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E67583046EA3
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 08:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDBEC37D110;
	Thu, 29 Jan 2026 08:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="lnQCiIGf"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C86037F0ED;
	Thu, 29 Jan 2026 08:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769677135; cv=none; b=YRFuICrCJ3PhdkbG3TScgqJ/+rjNJC9xVZ71jPKGAsULrfAGzB2ZoutBOfmp7v9anYXjNBnIMTRlgjKJYVNBepAtyue+G+aXfE3DY0mq/trljRb5s0OQubDdOxvTIV+63+MBxFZWnZv8/JLUnLOjF31U+jkiPVjM6iFMzUkUP7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769677135; c=relaxed/simple;
	bh=XC/0IuX5F/xzqrGyca384WV3NKdUzfetZ+5Q4Dr4qv4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iDUwtY0SP1bVNrRgCWUydOu44WQuJcG8BU0JJPsTc3NYYaS7SCXnuIc8FbBhn5BsI/X5TP8m3Y/gQG6WuetDx2Xfiwj/+hQhe/f2tHdJWt0GQXFOFy95DqmOzAFt307GMEjlRiwYLHex6c1T5w4RC2PL1O0R2lYXBSGUhvaa4Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=lnQCiIGf; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id A7084C211FA;
	Thu, 29 Jan 2026 08:58:53 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C2792606B6;
	Thu, 29 Jan 2026 08:58:50 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D613F119A884D;
	Thu, 29 Jan 2026 09:58:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769677129; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=XDhKbWZAQ1kfrBnd+dkCxhzWAa4k8KYqwn6w8oJkK00=;
	b=lnQCiIGflG9Yo1kuINcM13U3yAGds02GIHi/2erF+zMV7mC6qhExC7UPLIvyajs8eadZqe
	QhH1EiqXeYTP3ITZ+SoaxXEuyxXvX1qKoApql9VajS7RtkYdhm6MtJJbBstnYjoA8ZYccf
	zaJ/VfHdwRagtHnBB6CANKDxZ8/VNXz1UM7QAopv8fycZ2DJvCzY2mcJzA0qEw0n/4o9Ci
	eYeWjZEaBCzYOGNsyBe0E/pPLazfLt7EwcwQ52BvaiLZV/9wHkOEhbmj8mT9AY0BwTRWyl
	FKCK50mIEuNSmu3auvZr23+80+vnCnLOkc1xrLpE+HJaFZ2+njPFxTuif6x9Lw==
From: Romain Gantois <romain.gantois@bootlin.com>
To: davem@davemloft.net, Andrew Lunn <andrew@lunn.ch>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>,
 Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 =?UTF-8?B?Tmljb2zDsg==?= Veronese <nicveronese@gmail.com>,
 Simon Horman <horms@kernel.org>, mwojtas@chromium.org,
 Daniel Golle <daniel@makrotopia.org>,
 Dimitri Fedrau <dimitri.fedrau@liebherr.com>
Subject:
 Re: [PATCH net-next 07/13] net: phy: Represent PHY-less SFP modules with
 phy_port
Date: Wed, 28 Jan 2026 16:54:43 +0100
Message-ID: <5045774.GXAFRqVoOG@fw-rgant>
In-Reply-To: <20260127134202.8208-8-maxime.chevallier@bootlin.com>
References:
 <20260127134202.8208-1-maxime.chevallier@bootlin.com>
 <20260127134202.8208-8-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1946632.tdWV9SEqCh";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[bootlin.com,vger.kernel.org,csgroup.eu,gmail.com,nxp.com,kernel.org,pengutronix.de,chromium.org,makrotopia.org,liebherr.com];
	TAGGED_FROM(0.00)[bounces-254668-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[davemloft.net,lunn.ch,kernel.org,google.com,redhat.com,armlinux.org.uk,gmail.com,bootlin.com];
	SEM_URIBL_UNKNOWN_FAIL(0.00)[bootlin.com:query timed out];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[romain.gantois@bootlin.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	SEM_URIBL_FRESH15_UNKNOWN_FAIL(0.00)[bootlin.com:query timed out];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:url,bootlin.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A023AADE86
X-Rspamd-Action: no action

--nextPart1946632.tdWV9SEqCh
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Romain Gantois <romain.gantois@bootlin.com>
Date: Wed, 28 Jan 2026 16:54:43 +0100
Message-ID: <5045774.GXAFRqVoOG@fw-rgant>
In-Reply-To: <20260127134202.8208-8-maxime.chevallier@bootlin.com>
MIME-Version: 1.0

On Tuesday, 27 January 2026 14:41:55 CET Maxime Chevallier wrote:
> Now that th SFP bus infrastructure notifies when PHY-less modules are

There's a typo here.

> connected, we can create a phy_port to represent it. Instead of letting
> the SFP subsystem handle that, the Bus' upstream is in charge of
> maintaining that phy_port and register it to the topology, as the
> upstream (in this case a phy device) is directly interacting with the
> underlying net_device.
> 
> Add a phy_caps helper alongside to get the achievable modes on this

Alongside what?

Thanks,

-- 
Romain Gantois, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--nextPart1946632.tdWV9SEqCh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEIcCsAScRrtr7W0x0KCYAIARzeA4FAml6MUMACgkQKCYAIARz
eA4NKw/+M6DFcb/i3M9/8NN4IN5Emym+F8H1V/riHo3bA7rraCVBr9Mka55gUqUb
FetS6K+kxHJOgdjBzsfg3qzdlJy75C4x2lkkwyk585uFerrNF6OY6U8yE+MrBZ9e
uW6BdAP0IhY6aLkbXkBMEQq2W50aZ9IMCTfrcA12DAEIUKzehH9TGSq5cuEZkizX
PCficEPaxpZxp+mZ0NOGAuGc4eiGiYC6gorFF10Usnwby2jErLUYoWDi0Qw5expy
//XKPuIuI9Ednjb4r0ybgcwjOY47uwuOIisrXAMFJIS1ZPYKl5iCll8m27j2MUOU
gLAk/SP/2jJxSR4YACf6jAO1JgcsHu0ImNrVuyN8iiA5uUpIr6iUjvONI4zGlCEQ
C6pD71F5Oww9AF2xDQrlXeeW4tfHYQXBC9i/JAS4y6M3fkmAWRESYNUzcdt6s4YP
RRJ47X83qXB1Rt5QOsJysBbdrClVX9FF9UaoKl73x1mG2Aof9e9DXsY1c/sKJLJt
f6R9+nVNnQPOZQXCxf7PmEPrqLRgGcHwamtQOJMJQu5TT0+fR6vMSzucUpJTCTW0
TN/1QfaqEznJEJcHBZt1+pNdq3+N4WeSr3WMakWna+llKxSwtYNSE9B0ofUKvKLu
jxqD4M6eWKsNiaTl4L+dOM1kuTGcX2u5nF7IUFglpOaq41Mqqc4=
=rED9
-----END PGP SIGNATURE-----

--nextPart1946632.tdWV9SEqCh--




