Return-Path: <netdev+bounces-269866-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mAe+AVoWvWnG6QIAu9opvQ
	(envelope-from <netdev+bounces-269866-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 10:41:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CFDC2D82A9
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 10:41:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1672F30AB8EA
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 09:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77EC5382F25;
	Fri, 20 Mar 2026 09:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="bnoEx+VR"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5579B375F96;
	Fri, 20 Mar 2026 09:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773999612; cv=none; b=StCwJX/j/LPfW0nwsfSEg4hlQHt/aG/chpspgPKq3G+A/2r5jckS56Avo/OKWL1fvqZCL34JO7FwkC7n+lp44E2OAJTTnxdIfZ6I8nx0LKR/Kc9DruvUyXNosK/Bjc0PdNkFuWQvdy4MODuGWQPzKfd4iylZMmwvE6k6vc8lSoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773999612; c=relaxed/simple;
	bh=azSiGaSSxlTDuQCny00ji++6MuquKojsYdW19YTW/1A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F/GSgMMIerGztgsws8xL9/B2w7S1E7b0URbnsE34IoNTBAnapLloMMPDzv3FPwS51SQDVB8r/c5tZCl1VuFJ3PzQdrWdw1tIF8QX6UrjfEBpFlR8ZDDHPfE2WGgSUDKWAM3/T9JZ6QQN9ZwZHZRjTL3K4vgiPmpy6BBKMhgN3p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=bnoEx+VR; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 132A8C415A4;
	Fri, 20 Mar 2026 09:40:34 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id ABACB600E0;
	Fri, 20 Mar 2026 09:40:08 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 14D5710450B5E;
	Fri, 20 Mar 2026 10:40:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1773999607; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=qI1QX1Pvfy/14Qd8e/7scqtIpDkafI6tjAKrp8F3d1w=;
	b=bnoEx+VR+uXmYPQTrhnA+Cn8SXQekQrAIPi5w+sB7ftOWRhnHg9yWThlxdRxUiW6hSLuN+
	cLbUYn24K0qpkPctbdGTSsBAQq78Dz6hRA+cVic+TTXo236RM0Or+R+3+cw/RS6qzlfhQh
	zJn2Gv1sloLx1f3pxtwNCQ2i6KU6r4wuA2jlaaFZ5pCZyHm1fT/yKB8qW//PeHf4qc5NDK
	kfAEdDQcLWKuai1We2OG16gLk7Jv+KPlYX78fUHKpNBCJWt7L2wRZg6Y6dQoly2I2BroRM
	YdyMKbMUUsKOdq4MJkqS3n9DmHDIMWAU94isUGqhmAGFN0McydxWRGH8p32Z7g==
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
Date: Fri, 20 Mar 2026 10:39:10 +0100
Message-ID: <6022954.DvuYhMxLoT@fw-rgant>
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
Content-Type: multipart/signed; boundary="nextPart6296369.lOV4Wx5bFT";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269866-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,bootlin.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[romain.gantois@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	NEURAL_HAM(-0.00)[-0.979];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCPT_COUNT_TWELVE(0.00)[18];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 5CFDC2D82A9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--nextPart6296369.lOV4Wx5bFT
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Romain Gantois <romain.gantois@bootlin.com>
Date: Fri, 20 Mar 2026 10:39:10 +0100
Message-ID: <6022954.DvuYhMxLoT@fw-rgant>
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

--nextPart6296369.lOV4Wx5bFT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEIcCsAScRrtr7W0x0KCYAIARzeA4FAmm9Fb4ACgkQKCYAIARz
eA6U8hAAmaKuJRvVRCLsakTmqj521w8k7ueuC0H3tuNH6bhQ2grt1arXAJ9At9UJ
jlgjlecqDosz10ORSIKTxDHcb+Vvy9yWhp+CVYr6bMCsp7YpFBz5vGZWVM9+GYiq
njAC44bgcNgQ9qQdUDszfx+A7tQB6nxav+jkcfXf++c8yaOH0T4SUuz1H9WR1yHQ
A/Tf4ppvSAN9pjGxsbVjMyv6mb0VFxfT3UgU52qECqgpAet3fdvQ+xQLavzZjddG
9zrjbuXTykR00Hkxcn4m+jdlXOP13DsqqkAe31QoLvNGyroUVlEBv/yR0BcmngdN
SIM6NNKY1EiTabvfqsshGt1kqW9FDFn0qe+AWkF/vxZPZTqAyxtGc2KFcGUZguW7
W20PACrkYFNwDW8cp3kjKLP4jpLeUQ2CgM3Eix7Tg7uTvBat9ROlzdj69kSodzs9
HjK35igIvg57um0rnTq+R2cevprOI7n+b/h08qgyWL6IB9CBPvA2yLdp2YXxzZa2
Un1J+bADDD8d1VsCVM/LMZRSmisphJzzRoN4VdQNwnIy7NDqIPjZbvBj0JgdSPdR
UA15BVPznAARtugBYGefqdGzHpBBlUwt1icrFsPnPyoquZSRx/eFV2usna2CfEZq
F+0TFlRrQAfQtmZxupOwzz6bbhOLsgjw0nlLz+RohnXZuzJ2zcI=
=JdXL
-----END PGP SIGNATURE-----

--nextPart6296369.lOV4Wx5bFT--




