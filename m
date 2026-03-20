Return-Path: <netdev+bounces-269871-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YI5yNcAZvWnG6QIAu9opvQ
	(envelope-from <netdev+bounces-269871-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 10:56:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 77EBB2D8576
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 10:56:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0605D3039EEE
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 09:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE6D38AC88;
	Fri, 20 Mar 2026 09:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="zM1zNc1l"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C68B3876B8;
	Fri, 20 Mar 2026 09:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774000545; cv=none; b=ksXTTskOSpFWh0kLRwkRXIw9UzgbrSsP45EhELMtv5edktC0w2t4DmMsBS3a7eIR9pPxut/p8ASoT8vqIunP0M2jhSNetl8Ul/atJjpjg6jDkNV8SoB4OzZYyLTtdWrh9VOenjYqmGTM5KTrqAhodx0xDRSljc7UD5vPiG5FyGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774000545; c=relaxed/simple;
	bh=P1LaCrDKF5mAQkFpO57G8wLOnUQBabpmktP3SW4QsDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uMzLAVBOZvNnS0bEhokh0K7XIJO0N62qyhuL9RK5QTEKTeB5F5VUHuN45kb5AHGbI8nDFYW1Gl+ZzEJQ3um/OulFmVG4Ql065lMELCbt+DRFhBqg3ih4LDpiwDy0tKWs+CuDOM0T+zQhVK5YIFshxbIuemN/H1DyZx3eGJUywDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=zM1zNc1l; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id E7C0F4E42706;
	Fri, 20 Mar 2026 09:55:37 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9CBE3600E0;
	Fri, 20 Mar 2026 09:55:37 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C5FDA104509C7;
	Fri, 20 Mar 2026 10:55:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1774000536; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=FKggk34JAwVkoWj/rOgIcb9X6jIPbe5HuMQWES8/RXg=;
	b=zM1zNc1l4MGxsg7TSv0b0CpkviG5wVVKdpkPwbi6nQx/RR32wPebq07IA4Ec1S5F1xsRyH
	xQ3UY16AzGu8jirkDz/Y2tl8yb1QbOa8M5Bm9lXUvlQTjJ8ZAMW/HibntBZdyTc055e9mk
	5RRCAeu78oh8fChJTW4TmSiZnJTJ9bOGADiSTW16SRmMr3iedP0wIY2VlXGO/OeS/rQFqr
	Kl5mfWKWoZdNZ0m71HRd3AnmtHwBPXWFSauWy+/jbUKv/F3suW71KuxJsqEPV/5pBP9TO2
	NNvDUeQLnN57f0/sE4HP5fsF0l/1AvsZBBKWFa4EOHTp0UYmHbZnAY2i/X53ug==
From: Romain Gantois <romain.gantois@bootlin.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>,
 Mark Brown <broonie@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
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
Date: Fri, 20 Mar 2026 10:55:27 +0100
Message-ID: <2824900.mvXUDI8C0e@fw-rgant>
In-Reply-To: <aaspCUWel9k_ls4i@sirena.co.uk>
References:
 <20260303-sfp-regulators-v1-0-7101ae34cb84@bootlin.com>
 <aacpVFhH8eV7dxHV@shell.armlinux.org.uk> <aaspCUWel9k_ls4i@sirena.co.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart12859626.O9o76ZdvQC";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269871-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,bootlin.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[romain.gantois@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	NEURAL_HAM(-0.00)[-0.976];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:dkim,bootlin.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 77EBB2D8576
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--nextPart12859626.O9o76ZdvQC
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Romain Gantois <romain.gantois@bootlin.com>
Date: Fri, 20 Mar 2026 10:55:27 +0100
Message-ID: <2824900.mvXUDI8C0e@fw-rgant>
In-Reply-To: <aaspCUWel9k_ls4i@sirena.co.uk>
MIME-Version: 1.0

Hello Mark,

On Friday, 6 March 2026 20:20:41 CET Mark Brown wrote:
> On Tue, Mar 03, 2026 at 06:32:52PM +0000, Russell King (Oracle) wrote:
> > On Tue, Mar 03, 2026 at 05:31:36PM +0000, Mark Brown wrote:
...
> 
> > Now, if you're going to say "ah, so it has power pins, you need to
> > describe them using a regulator" then I would say to you, when are
> > we introducing regulators for every device we describe in DT such
> > as LEDs, switches, GPIO pins, RAM, etc? Every device needs to have a
> > source of power after all.
> 
> It sounds from the cover letter for this series like there's some demand
> for power control of SFP cages, the cover letter isn't terribly specific
> about what circumstances though.  Possibly there's some UI for this on
> the system, or the hardware has some mechanism for detecting physical
> insertion to the SFP cage (hopefully well in advance of the electrical
> contacts being made)?  Romain, are you able to share more specifics on
> the use case here?

It seems like my upstreaming strategy was incorrect. The series that I sent is 
a subset of my original use case, but in hindsight I should've just presented 
the original one in the first place, that would've been clearer, sorry about 
that.

Originally, I implemented a runtime PM support in the SFP core. This allowed 
to cut power to the cages when the attached network interface was down, 
thereby saving power. This is interesting since I'm dealing with a battery-
powered system which has SFP cages. However, an upstream version of this would 
require some kind of new userspace interface to signal indifference to module 
detection when the upstream network interface is down. Otherwise it could 
break existing userspace applications which expect to detect and interact with 
SFP modules (e.g. read EEPROMs, read temperature sensors) even when their 
upper network interfaces are down.

Aside from this, what Russell told me in this message:

https://lore.kernel.org/all/aacYGTBobbfJgZpp@shell.armlinux.org.uk/

suggests that cutting power to SFP cages could lead to unspecified behavior 
with some modules, so for example unloading the SFP core kernel module while 
an SFP module was inserted could have unintended consequences... This problem 
requires some more investigation on my side before I can submit a proper 
runtime PM solution.

Thanks,

-- 
Romain Gantois, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--nextPart12859626.O9o76ZdvQC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEIcCsAScRrtr7W0x0KCYAIARzeA4FAmm9GY8ACgkQKCYAIARz
eA7Mbg/9FpHtkwjk65/eUWGbZFGAd2T2L4+u12D1dKOUlzXib59yk6oOSamw0OTx
SlK8/m3KbtdxkDVe2OUe3fpYhaHJFNEekURDg4WhBGiHkcqMuHa4cm1g3jsxdmFm
6Xqxo9WQAdRemLWdKSHxBM94Kkvp3iBUOly5+BkWlfyHqxt1oA9mkmkiL0iSJv47
+LAX4Xdmu6cOs4bgxuWJAnnS01mjOOP7oBJ6/gabjPN5oD3vwADbc6la/jvIED/8
Hn4wwX6GRLNaXr0wkRYon9W7Nor485+sl2DPdn/KtEdw/G8AsiWCK/d+BUpWjYW0
2x5K9oc/pYLf21rofr0ldRkvuvh9Lj3LSMt+F8E9sm5j79Bg9QNI1c0BrQ04TasK
1aJ3shvOPHWnLBGqAxOfG+xJg2JBr4PZAVmiHHibPVN26jwUHo7/IIYv2K/o0ga8
9SibuOo9wCFVp+0EvHtxJnyCY0+nkbqH7fbY2VSMYEPzDdPZceHebvrBgsfCvQ/Z
cqvx1SoqKDlSUtX0Bh8TrJG2L+r88dId3th18hFUSEuwsfIjE5NxClmRpZN+9p4E
loL1m3ggJUgPjqV6IPoS+wNnkI1HSbcEwL+Ak46ANaeqFPQpa6iDJO3jpF8bsAm6
bB2oeZlJ9vp+7tOUXPmzT+AQ1ruty/rtnIXwbNzaeNegjjR2NHM=
=6Xda
-----END PGP SIGNATURE-----

--nextPart12859626.O9o76ZdvQC--




