Return-Path: <netdev+bounces-291452-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2AsGFkmwFGrRPQcAu9opvQ
	(envelope-from <netdev+bounces-291452-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 22:25:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F0E5CE568
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 22:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2F36C3011C45
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 20:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81AC838D40F;
	Mon, 25 May 2026 20:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i+idlWXs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75DB83793C3;
	Mon, 25 May 2026 20:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779740740; cv=none; b=XXmLfR6g5+WUt4WqZ/Nb1a0CGJFlylwAyW1pExCJg4QiTPbB+7HPBFueDh2OBmAshOsJacKlkSv0+Kg7oTBIrk4hrkap4/scxpx/fLicVJNdqdfsKcNoBimyjnzHCy13cWmmgj0L3Dyjb95jqCUvV5Dxnnman5lbcp8PoOrgrNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779740740; c=relaxed/simple;
	bh=cyR7XR9efj0wVuOXyEcCaG3QfjQzuye3+Mk/NdcXQyo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cotQfUNCpBjcPKvdj6eHcdgBgm+MhRZG/OuougndMXsIkYRs9BlnRgLIV3LgU6UnhESIHzYi9UgK8qckq4gLQZi7qm3c8RVphCIgc9MlHfWXb2EG9xqIE7w5T86nPtSlAv0KafAuK5LqbW75HdvLW4hWqKIGTDyLJiT4DsuLf3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i+idlWXs; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CB591F000E9;
	Mon, 25 May 2026 20:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779740739;
	bh=E9hCj9P6Nl7KaPfWogvpMcVeT052t5HjZs7D0oXM8Jo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=i+idlWXs9XVSNH3Mips1ue+AupcBlt6rlpd696A3YRhS6b5mUJ+MN0obnCgkMcV5j
	 Exi7xC9WMq+11BKotMk928gXvxOPTEJHtaWvOnZ02krqW2/IvYjeuJBgH95j2oFhdo
	 ZUN4KWaxP9WIZmNAdcMbly4bIrmL+IYyrIWXOUyvBTNqKHbP3i3uhANuFeFuIpIoAD
	 8zzgzA2kBaxdzbDoEtwoiBca1qKvDzDBNzEX4P3Rmpls8VHBFtueZ7n9c4b0Puc8kS
	 b0XIFR61ENOZVP9fFvc0adJC+qnW63rjyfbic/IcYTMG/iBBeSCwY8VPh1QSV/iKBr
	 DC8Mx9y7NvMHw==
Date: Mon, 25 May 2026 13:25:37 -0700
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
 Golle <daniel@makrotopia.org>, Dimitri Fedrau
 <dimitri.fedrau@liebherr.com>, Frank Wunderlich
 <frank.wunderlich@linux.dev>
Subject: Re: [PATCH net-next v11 06/10] net: phy: phy_port: Store
 information about a port's upstream
Message-ID: <20260525132537.7fa42301@kernel.org>
In-Reply-To: <20260521121040.1199622-7-maxime.chevallier@bootlin.com>
References: <20260521121040.1199622-1-maxime.chevallier@bootlin.com>
	<20260521121040.1199622-7-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-291452-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,lunn.ch,google.com,redhat.com,armlinux.org.uk,gmail.com,vger.kernel.org,bootlin.com,csgroup.eu,nxp.com,kernel.org,pengutronix.de,chromium.org,makrotopia.org,liebherr.com,linux.dev];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: C3F0E5CE568
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 21 May 2026 14:10:34 +0200 Maxime Chevallier wrote:
> --- a/include/linux/phy.h
> +++ b/include/linux/phy.h
> @@ -791,6 +791,7 @@ struct phy_device {
>  	struct sfp_bus *sfp_bus;
>  	struct phy_port *sfp_cage_port;
>  	struct phy_port *mod_port;
> +	struct phy_port *upstream_port;
>  	struct phylink *phylink;
>  	struct net_device *attached_dev;
>  	struct mii_timestamper *mii_ts;

nit: missing kdoc here

Are all the sashiko reports false positive at this stage?
-- 
pw-bot: cr

