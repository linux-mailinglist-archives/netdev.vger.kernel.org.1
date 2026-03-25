Return-Path: <netdev+bounces-271478-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oKynBtauw2nAtAQAu9opvQ
	(envelope-from <netdev+bounces-271478-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 10:45:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B988322694
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 10:45:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 16781303CD14
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 09:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 453BB39A7F8;
	Wed, 25 Mar 2026 09:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="SHoPhh5o"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B3738D6A4;
	Wed, 25 Mar 2026 09:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774431626; cv=none; b=cbRLZJaImoKoSZv1Z+ISDJqA59PhF3nnAigCQ6NuPTXUY+tR3aaWlH60Klsn9Ba6UlOLgqEXc9baPfp8qCTzje6E84xj7YdcF+b9u9ou90aIwWEu9xRgJuyXmlSbdKc2xKwLhbgoFUnk4jSlfjUwbbH1wI4gB0Q7c7F5DYsQLDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774431626; c=relaxed/simple;
	bh=ic4ovVVbngDbHXUn1s4sSFh/sIJ+WuTucWOFyOVbcJc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ETyBSi1e13h+Y2QndeLg5lMMCDc56zVajmXbJmyBeWHRa+aqcmT5FgkLedN0T1a8Te+nQrYvrf6lB0GhTE6CWZSkzZNOxxu0zu9IUtg5YFC1MlBBUK/Q7lsmjIlebTKbTMFnD9y85TFhALFpp0Iq9bTNvweAIl0nWrJjQja6JQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=SHoPhh5o; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 858994E427E9;
	Wed, 25 Mar 2026 09:40:20 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4CCBE601A1;
	Wed, 25 Mar 2026 09:40:20 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E950A104513B2;
	Wed, 25 Mar 2026 10:40:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1774431619; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=0ixsUbiwjr2cUCJBEr3rNQHAH9XP6hNBHzk2pZT9agY=;
	b=SHoPhh5ohLqKRFyhAtzIElxDGJCK3uhMK5h3vKQRUgiXWVtAGX9DX1SGCIhFfzM/klpmUP
	UIoSjK8c9VkbQPtoW23LBM1zpaaXPmf6+N581B0om6GuzHgoPiOEG+PQ3ANksPIHYjItTr
	qNBrbyfpFXhyplGPqXH2nDVBu2LvgMiP3zhsMpDAhivvpo88LfxODZWSgI1jNHzQaxp3pB
	p56CA3fy7Fe8YsXPpQfJrB6RdoulJwAVHjeoqKyo2RV/hjbCc7YgkiB5Q7DqNwhWUjaLQB
	3mHB+g7ENoPmJSdYBJf5uvFk6eGrOcCEwWYwVI2ZqFvKEY8PDpZerf3nmlVV9Q==
From: Romain Gantois <romain.gantois@bootlin.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Mark Brown <broonie@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH net-next 2/2] net: sfp: manage receiver and transmitter regulators
Date: Wed, 25 Mar 2026 10:40:09 +0100
Message-ID: <5088970.31r3eYUQgx@fw-rgant>
In-Reply-To: <ab1diwlayiWMsBIx@shell.armlinux.org.uk>
References:
 <20260303-sfp-regulators-v1-0-7101ae34cb84@bootlin.com>
 <6022954.DvuYhMxLoT@fw-rgant> <ab1diwlayiWMsBIx@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4723872.LvFx2qVVIh";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271478-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,bootlin.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[romain.gantois@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:dkim,bootlin.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7B988322694
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--nextPart4723872.LvFx2qVVIh
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Romain Gantois <romain.gantois@bootlin.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Date: Wed, 25 Mar 2026 10:40:09 +0100
Message-ID: <5088970.31r3eYUQgx@fw-rgant>
In-Reply-To: <ab1diwlayiWMsBIx@shell.armlinux.org.uk>
MIME-Version: 1.0

On Friday, 20 March 2026 15:45:31 CET Russell King (Oracle) wrote:
> On Fri, Mar 20, 2026 at 10:39:10AM +0100, Romain Gantois wrote:
> > Originally, I implemented a runtime PM support in the SFP core. This
> > allowed to cut power to the cages when the attached network interface was
> > down, thereby saving power.
> 
> Have you measured how much power is saved by this?

Sure, here are a few measures of saved power with several different modules 
I've tested. The measures were done with a shunt resistor on the regulator 
line feeding all power pins on both SFP cages. Only one SFP cage was occupied 
during each measure and the upper network interface was down.

Module           | Power saved (uW)
SFP-10G-T-I    | 80
SFP-10G-T-30 | 359
SFP-GB-GE-T  | 191
CHAMPION ONE 1000SFPT | 188
SFP-H10GB-CU1M | 0
ES8512-3LCD05 | 248
SFP100BFXST | 351

So with both SFP cages occupied, we could see about 0.7mW of saved power by 
cutting the regulators to the cages.

Thanks,

-- 
Romain Gantois, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--nextPart4723872.LvFx2qVVIh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEIcCsAScRrtr7W0x0KCYAIARzeA4FAmnDrXkACgkQKCYAIARz
eA6+Ow//bX4geV5K72UhtlUIxoYgnv1tWC40NCjRX+2zNNJKc2eWRMakvQEc0IZy
chaHitXDIGm8ePOd2GYuSfjz9lCID2XJZ1hV0tfLI79roWbj32wSipFzZ0bNhoP9
n4HunjB/fw4zthihRlXObsfNOPJ18LAnfGgvlbxnIGj7pVkOkxXfJyNaFcUZA8Pu
jfGuq+bUsvZ5qO/24aBjHT4Hmtnl4BQno7ubaJHfiBa9JoMMU7JPIVKHIatCw/oK
3V/PzrUrRbwCtik4bY/quJqdXMnsI0xM5CBOSYT3oObzTCBec+ANJwBEtY1b/ZtW
HCgWA7hRHh1FD5CHJC1WBj7gRi6bIWn4vw4rafvTvw49KV7UKND1jg4ma6sESwg/
sfAc3QLCU+TujUJ0zMWrdGyRc/KlgPLTZCuSP0esGlRuzY/pb+nhdYNusmgKJURE
LQVzyokDVZHnbWROvdwxokMMdE0Z3JHUyhO8IK0GZdDfTJk/GVPUwyzD2glsLfBP
CqccXVB+n8wDoHfJgYKt67BoYH21ZR5mvwyEq2gxGDxLHlnIGxoVnFhCUmENRY+3
N2uotbdEYqi9uZ+kOXMDU+uPcLXPTQkbuDWlRyD0cC9HmnQIFJOTqZ1VMPwxcgW8
V8E6f0JcrX4+XZfg7C97sOYjdrJ7t87bJsHCZ6BjOwEfp7ZVBj8=
=EX2l
-----END PGP SIGNATURE-----

--nextPart4723872.LvFx2qVVIh--




