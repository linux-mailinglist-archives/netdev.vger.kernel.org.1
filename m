Return-Path: <netdev+bounces-254665-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0PBXLUohe2mCBgIAu9opvQ
	(envelope-from <netdev+bounces-254665-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 09:58:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 31EEDADE4A
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 09:58:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F02243006B3A
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 08:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F24E37C114;
	Thu, 29 Jan 2026 08:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Cnh888Qr"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780163783C8;
	Thu, 29 Jan 2026 08:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769677128; cv=none; b=JZRqxjEqynPUqErKplTrpH9EIpbA8ci+L8IW2bpNbQmcdY1Yqsr4CQvHamrIETfoQWC+McyNuhi+3O+/LHg41urZ/aj7NnvnDHD4fgMzy51wDJEw+5TpVl0vyZNRo2AQh82JENGsvkKFKtB4cByQ7D6/Qk0yY7hsUGMDoYsLL1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769677128; c=relaxed/simple;
	bh=hKGl8BNV//myhgXnaqNi8zKPxu9dDO+zvI3HedxasPs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VmnraGDBlh1AyDD24RYcXO49Z3/tPdxOtbzmCNnZSiWHd2YdtrdYWBNON6uEE6xnss05Ff26q+K1Ox211QLoQ8pVPxm5XJag3fuccbMgmyhH+LwD8GQvfsp7B8GxslF6E8p5AS1sY3Wh8jBDx69C47qnj+C1YVAIUc3muXk9RoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Cnh888Qr; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id A8DF24E42312;
	Thu, 29 Jan 2026 08:58:43 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 75FC8606B6;
	Thu, 29 Jan 2026 08:58:43 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 643C9119A884D;
	Thu, 29 Jan 2026 09:58:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769677122; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=mcFgOD1kfIC7rbBgnlQFUqUb09pIHf37YOOno+6Zngk=;
	b=Cnh888QrgSKiWT7UbCMLrbBltfHq54hNUoOydYIdEJL5aPkJfoTvjzG77EOz3v81U2Smg0
	y5yN+jERxZHe2JqCj7WvHqv8eA8IxVB8VBFoL29mu5TZF7jNSgeImOObb3GNtjltzfGE9P
	1K6iX9vBuVrDzU1dqRCZB6Ph2v+vl9ZphLLPX3RG9RfSkcrlq8ye+fAcUHM469RzJzrPJc
	XffhaoUhyOeg1vP/uVvh7I2mJ+kx1Rja53nF47TXwWldWSR9g4QkAlM+fbDsvpkD5cGnpy
	s4oNcP3STpAmdKa7bjW4orV/bFuihTeK84bkLYQv1D1Os1OawLql2pBqn+f87A==
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
 Re: [PATCH net-next 10/13] net: phy: phy_link_topology: Add a helper to
 retrieve ports
Date: Wed, 28 Jan 2026 17:10:05 +0100
Message-ID: <7904208.EvYhyI6sBW@fw-rgant>
In-Reply-To: <20260127134202.8208-11-maxime.chevallier@bootlin.com>
References:
 <20260127134202.8208-1-maxime.chevallier@bootlin.com>
 <20260127134202.8208-11-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3927895.kQq0lBPeGt";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254665-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[davemloft.net,lunn.ch,kernel.org,google.com,redhat.com,armlinux.org.uk,gmail.com,bootlin.com];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FREEMAIL_CC(0.00)[bootlin.com,vger.kernel.org,csgroup.eu,gmail.com,nxp.com,kernel.org,pengutronix.de,chromium.org,makrotopia.org,liebherr.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[romain.gantois@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 31EEDADE4A
X-Rspamd-Action: no action

--nextPart3927895.kQq0lBPeGt
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Romain Gantois <romain.gantois@bootlin.com>
Date: Wed, 28 Jan 2026 17:10:05 +0100
Message-ID: <7904208.EvYhyI6sBW@fw-rgant>
In-Reply-To: <20260127134202.8208-11-maxime.chevallier@bootlin.com>
MIME-Version: 1.0

On Tuesday, 27 January 2026 14:41:58 CET Maxime Chevallier wrote:
> In order to allow netlink access to phy_ports, let's add a helper to
> retrieve them. When handling a port coming from phy_link_topology, the
> caller must hold rtnl until it's done with it.

Why not use rtnl-specific lockdep annotations to make this more explicit?

Thanks,

-- 
Romain Gantois, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--nextPart3927895.kQq0lBPeGt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEIcCsAScRrtr7W0x0KCYAIARzeA4FAml6NN0ACgkQKCYAIARz
eA4JMQ/+PllNFLC7hvnajenQErjxYN5z0L6DNGQFFtcwxYArjJuQSsGwvg8eHnI4
FV1Ixd/5W2Yp0WLSVlx2ne5fhvL4uUHUIrzZZ/rnj9+ekHVv4ZJyE1YCwisCjaKS
Z+dJjLnf1ATBOUzfPe7hMFpYgMEoJ8QLFERztoOYybx4v50ofZEj6XBZ1UPdiPk1
4RolvH9fT0RkNmVkV61opPU8WvHCBCXM1v60gZiv9kocmyZhcxmZAYAeINwkJLaU
szixethcWZgXSiL4G79nyo+Y78JOk2Rr75oUgiqcSXagA+Ke0NkcmuP0IlzjH0fV
jHCNfzlswLMQS66Mt8/uIRbU+D0gfDrPI4xaIGackhRd1GHmogxaAlNiZ4QJNPy1
1GpnEhtlVRecE161KzsrvKY9Kts29eHW9j+rGbmfhJifY7sFpT7x95ywifyhuoEy
2RDW4d9sIUtuRgpVAnP4aag+AxLKfuI0x8GxzGQILx5dhyeu37cxga2yGnaTHIxV
lDmr2aaoJ4m2GPPDSoUkiMED1BXcqI45A/ToqzWe5vb72Ie+wFq+weyJu9ahmpw/
H3iB7VzIDdzIqJ+Nz7sETvc/c3/7+Xahgtb0FyZDze5iBsRlPPgq6YQpop1X2FM8
5+19C0vyHesVCC/2tG3z8bftTYIQXV0Nf6Pz8ScDyRWD5FWXrCA=
=VHXS
-----END PGP SIGNATURE-----

--nextPart3927895.kQq0lBPeGt--




