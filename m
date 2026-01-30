Return-Path: <netdev+bounces-255015-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJp0C+gsfGk3LAIAu9opvQ
	(envelope-from <netdev+bounces-255015-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 05:00:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E2924B6F6E
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 05:00:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2B314301944F
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 04:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E21366DC7;
	Fri, 30 Jan 2026 04:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y9IK7izv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FE4366565;
	Fri, 30 Jan 2026 04:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769745618; cv=none; b=sB1P9vDoIq9si76IiA7rQoz67gyud4SgUWQg7F+8WPiyNRUDaSb/i4NGvlJDZy13maPemPRgds9A9gLfZkuhyNIyxpUj/vVc28KmecpbeI3cRfQqL/fy9D5qOCvO6EQtveYA/Qv5NRrh2+hS5jlMTflyoT2ytiN5jIXZUyQQ6RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769745618; c=relaxed/simple;
	bh=I7bre0Oy+P+gB8UF2lL4L2MjU4tkQEwcT3SYMz2fgLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LFs9BdIz2ICRRfZiHol8AKkfMClj1ilgSGD8A8nL82hNma6oF3B741TIKESqarS8JKtnsoWMajbFf0lQ08FP6/gaZqBc4QqFdBBr1k++0dP9OC3zfK4vgSkuhQ+5Om0j+FVue2FyQFhuv15Abg0b1U52+4zAO+LFIw9UjGbEK34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y9IK7izv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 502D3C4CEF7;
	Fri, 30 Jan 2026 04:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769745618;
	bh=I7bre0Oy+P+gB8UF2lL4L2MjU4tkQEwcT3SYMz2fgLU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y9IK7izvEYA+znAowwVBRaVxWezmGITXL3ZZQkoCGt5JIQNGE8FQtrg0pylwfDOp8
	 bsyMwzekdZoIeN3JVvvc1Rf09graMQaWHPGpWC9qFIHT340ZYNNp6DgDLVGE7G+z1N
	 D1x/KTwrHaYqH/pLgHSNubkpLuvX47Ozcew/WSvFweBApGFGtwHP2BJ2hNovxAoGsU
	 pYobbIEmabwQMM/SDKUyzTEyEXOvtgCCb5g2GeXOTZZuNfQTICrDzyH2ZPl8JzEIEM
	 C2M9jblvlOQhlLOSQW8rixNBarKRURqaw0mdVygqngPUYm9XfUUYSO4o6L9UgdSUaX
	 Kp2WHDRYiFx2A==
From: Jakub Kicinski <kuba@kernel.org>
To: maxime.chevallier@bootlin.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	daniel@makrotopia.org,
	christophe.leroy@csgroup.eu,
	kabel@kernel.org,
	kory.maincent@bootlin.com,
	f.fainelli@gmail.com,
	vladimir.oltean@nxp.com,
	netdev@vger.kernel.org,
	horms@kernel.org,
	mwojtas@chromium.org,
	o.rempel@pengutronix.de,
	romain.gantois@bootlin.com,
	herve.codina@bootlin.com,
	dimitri.fedrau@liebherr.com,
	hkallweit1@gmail.com,
	nicveronese@gmail.com,
	linux-kernel@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	thomas.petazzoni@bootlin.com,
	andrew@lunn.ch,
	davem@davemloft.net,
	linux@armlinux.org.uk
Subject: Re: [net-next,v2,09/12] net: phy: phy_port: Store information about a MII port's occupancy
Date: Thu, 29 Jan 2026 20:00:16 -0800
Message-ID: <20260130040016.707823-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128204526.170927-10-maxime.chevallier@bootlin.com>
References: <20260128204526.170927-10-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,makrotopia.org,csgroup.eu,bootlin.com,gmail.com,nxp.com,vger.kernel.org,chromium.org,pengutronix.de,liebherr.com,google.com,redhat.com,lunn.ch,davemloft.net,armlinux.org.uk];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[24];
	TAGGED_FROM(0.00)[bounces-255015-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E2924B6F6E
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: phy: phy_port: Store information about a MII port's occupancy

This patch adds an "occupied" bitfield to struct phy_port to track
whether an MII port has an SFP module inserted. The field is set in
connect_nophy callbacks and cleared in disconnect_nophy callbacks.

> diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
> index 21af1dffa837..bb257e91cdf6 100644
> --- a/drivers/net/phy/phylink.c
> +++ b/drivers/net/phy/phylink.c

[ ... ]

> @@ -4047,6 +4047,8 @@ static int phylink_sfp_connect_nophy(void *upstream)
>  		}
>  	}
>
> +	pl->sfp_bus_port->occupied = true;

Note that phylink_sfp_connect_nophy() has a NULL check for sfp_bus_port
at the start of the function that returns early if it is NULL.

> +
>  	pl->mod_port = port;
>
>  	return 0;
> @@ -4056,6 +4058,8 @@ static void phylink_sfp_disconnect_nophy(void *upstream)
>  {
>  	struct phylink *pl = upstream;
>
> +	pl->sfp_bus_port->occupied = false;

Can this dereference a NULL pointer? When phylink is created with
PHYLINK_DEV type (rather than PHYLINK_NETDEV), pl->netdev is NULL and
phylink_create_sfp_port() returns early without setting sfp_bus_port.
The callbacks are still registered via sfp_bus_add_upstream(), so when
a PHY-less SFP module is later inserted and removed, this function
would be called with sfp_bus_port being NULL.

The connect function checks for NULL sfp_bus_port, but the disconnect
function does not. Should this have a similar guard?

> +
>  	if (pl->netdev)
>  		phy_link_topo_del_port(pl->netdev, pl->mod_port);

