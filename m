Return-Path: <netdev+bounces-258184-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MKe0LVoBjGlgegAAu9opvQ
	(envelope-from <netdev+bounces-258184-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 05:11:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1719E121221
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 05:11:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C7FAF302DA37
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 04:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE67B353EC0;
	Wed, 11 Feb 2026 04:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tSrB8dGd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B941E352FAB;
	Wed, 11 Feb 2026 04:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770783063; cv=none; b=otDVWmXM1g2GoPiDY8EqyE43ofCP7tqtV1qpoM2uFZQGUXrpi+Ma7Z6Ppk+uvia3GfRT7yvsP5JJKU+Np4n3ufFZ7j1RMzCY+YVH9f0UjbmzRnM3bZethQSvmx29LRcaOuwIGxltbyISLSrLSeQkCKfIU59LtOlI2SlODhTmiDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770783063; c=relaxed/simple;
	bh=F2/MDZ8jYYPQbrL59oO2vgd1eGHQ87CkIq3UzY+c4/c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pqd8sfru9ahlqIQhrumkxGA48WNgNheNOWhM6uj8gXZkLmNcC4b0V+7c5Hr04C9/2w1NZonDSbRv+zJJ/DNNoVIymcn4l+0NkcmgjP7SYvClsWXpjHDT7lM1zKABUbDgt7IDruwuB+uTpBOIsK1IXxiXe1T40LNEjSnhUnjcMLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tSrB8dGd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DE11C4CEF7;
	Wed, 11 Feb 2026 04:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770783063;
	bh=F2/MDZ8jYYPQbrL59oO2vgd1eGHQ87CkIq3UzY+c4/c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tSrB8dGdYMCRi4hI3c96OaNfiYXloVVnrbn/4r3Q75REcYtj4jE9KiZM9sjNPNK0j
	 yq7Qnsa1UdC3SO2pSw+7jy+jIIGDFcISiPwtPhOx6psfEnbreEzcaFnYuyYdU0GLpu
	 Ui1f35AnN4NV5dJAiveGoxGPNBcsLCgqrr43vIZp8kY7HAYrfpo2yFs58oumO7PZtP
	 BUea293eZZUiw3VskxR3p8ohkkktiUqnJylHMzDNxSOBrSIdYphRkt4xhCFBnSfBtq
	 zTiZ/Ijl4JUkg0s9wAvaIWXpgL2NEVJuxYuxckJ09j7hMeKWmPzfvgXQk5OG4pSjZ3
	 +8vbLycmRShWA==
Date: Tue, 10 Feb 2026 20:11:01 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, Andrew Lunn <andrew@lunn.ch>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Russell King
 <linux@armlinux.org.uk>, Heiner Kallweit <hkallweit1@gmail.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean
 <vladimir.oltean@nxp.com>, =?UTF-8?B?S8O2cnk=?= Maincent
 <kory.maincent@bootlin.com>, Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>,
 Oleksij Rempel <o.rempel@pengutronix.de>, =?UTF-8?B?Tmljb2zDsg==?= Veronese
 <nicveronese@gmail.com>, Simon Horman <horms@kernel.org>,
 mwojtas@chromium.org, Romain Gantois <romain.gantois@bootlin.com>, Daniel
 Golle <daniel@makrotopia.org>, Dimitri Fedrau <dimitri.fedrau@liebherr.com>
Subject: Re: [PATCH net-next v5 00/13] net: phy_port: SFP modules
 representation and phy_port listing
Message-ID: <20260210201101.5df36a41@kernel.org>
In-Reply-To: <20260205092317.755906-1-maxime.chevallier@bootlin.com>
References: <20260205092317.755906-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258184-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,lunn.ch,google.com,redhat.com,armlinux.org.uk,gmail.com,vger.kernel.org,bootlin.com,csgroup.eu,nxp.com,kernel.org,pengutronix.de,chromium.org,makrotopia.org,liebherr.com];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1719E121221
X-Rspamd-Action: no action

On Thu,  5 Feb 2026 10:23:03 +0100 Maxime Chevallier wrote:
> Here's V5 of the second phy_port series, this time bringing support for
> more phy_port use especially for SFP, as well as the begining of a
> ethnl uAPI.
> 
> V5 doesn't contain a lot of changes, only a doc formatting fix as well
> as a fix for a potentially un-initialized pointer.

Any idea why this is set to Changes Requested in PW? :S
The 3rd patch carries a Fixes tag, makes me want to apply the first
3 changes for 7.0..

