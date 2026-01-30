Return-Path: <netdev+bounces-255014-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aOkuDDgtfGk3LAIAu9opvQ
	(envelope-from <netdev+bounces-255014-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 05:02:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 873B4B6FA1
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 05:01:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A828303F055
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 04:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA371366DCE;
	Fri, 30 Jan 2026 04:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BCNV/Lyy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8590636683E;
	Fri, 30 Jan 2026 04:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769745616; cv=none; b=u9FM6QLGHQqQIUz5UYyGQRELGegzLUaxqiopOMGtlF6ffSDSPfNLhgtc2A6kdRfQJhJjsHG2nomrJN6nrXwY5S851LfWFAxJTeRpRccMg6MzfSkdbSsVSa0BavuVxPdgsQ8i3z4kWbuSwXQwMtXGgg3L+tX8Jg8SYaHcj/a7azQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769745616; c=relaxed/simple;
	bh=1nrmfqQYcCPl4Ony3qTkCiZvzg4TqNaiyn1DLeEtSCU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nF15cWy0+3mqfdeMrTA+AAoUlN01jEPzC5ffKjCtDEfQ/r5w9IWQjRxEJ0dLyHEAmaIMINCDn/2iOTXNYTP/OheWLHrjI8KKI6PAyidevLfVpoHTj0kPJfecJZEkIJOzflMZSeGmsWdB/k5+ZR+1Vu0E7WzyvZYKdcmQmMLrCxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BCNV/Lyy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22317C116C6;
	Fri, 30 Jan 2026 04:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769745616;
	bh=1nrmfqQYcCPl4Ony3qTkCiZvzg4TqNaiyn1DLeEtSCU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BCNV/LyyTUG167WAZkqWDdDiKjmdkTCjbSBt+Bg5FlcoiuTv5dJA1rXHG3CCR+LaA
	 X0ZhKLLHEb4i3o/9E+/3s5wJUrScpj5sxmGbdeWi1EZUK6SiOuDqczKL9ubQ8c3T+P
	 BahT98otiMYcCIY/l8vApz9c+LdtMDEG7UzFj1Mr0lmeRzMyuj8g3CffUtAviDnp8z
	 d7pIkVd8j/w+WwzUXh2WvRqxH+AScfJNPUN8mP8XYjYCLkI4b9TNmcx7OOBXXGH8bN
	 fpRiKbDCuFJU2yDm+Nt/9lignmySc19v8hyj2EzwaBKstVZD8cu2Z1CNk5sB7dSLf/
	 FwAulpgyIfFuA==
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
Subject: Re: [net-next,v2,08/12] net: phylink: Represent PHY-less SFP modules with phy_port
Date: Thu, 29 Jan 2026 20:00:13 -0800
Message-ID: <20260130040014.707804-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128204526.170927-9-maxime.chevallier@bootlin.com>
References: <20260128204526.170927-9-maxime.chevallier@bootlin.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,makrotopia.org,csgroup.eu,bootlin.com,gmail.com,nxp.com,vger.kernel.org,chromium.org,pengutronix.de,liebherr.com,google.com,redhat.com,lunn.ch,davemloft.net,armlinux.org.uk];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[24];
	TAGGED_FROM(0.00)[bounces-255014-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 873B4B6FA1
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: phylink: Represent PHY-less SFP modules with phy_port

This patch adds support for representing PHY-less SFP modules using
phy_port by implementing connect_nophy and disconnect_nophy callbacks
for phylink.

> diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
> index 310af33d49a0..21af1dffa837 100644

[ ... ]

> +static int phylink_sfp_connect_nophy(void *upstream)
> +{
> +	const struct sfp_module_caps *caps;
> +	struct phylink *pl = upstream;
> +	struct phy_port *port;
> +	int ret = 0;
> +
> +	if (!pl->sfp_bus_port)
> +		return 0;

This early return guards against sfp_bus_port being NULL, which prevents
mod_port from being allocated in that case.

> +
> +	/* Create mod port */
> +	port = phy_port_alloc();

[ ... ]

> +	pl->mod_port = port;
> +
> +	return 0;
> +}
> +
> +static void phylink_sfp_disconnect_nophy(void *upstream)
> +{
> +	struct phylink *pl = upstream;
> +
> +	if (pl->netdev)
> +		phy_link_topo_del_port(pl->netdev, pl->mod_port);
                                                     ^^^^^^^^^

Can pl->mod_port be NULL here? Looking at the SFP state machine in
sfp.c, sfp_module_disconnect_nophy() is called from the global cleanup
block when !sfp->mod_phy. This cleanup runs whenever the state machine
is not in SFP_S_DOWN and the module state changes.

If the module is removed while the state machine is in an early state
like SFP_S_WAIT or SFP_S_INIT (before PHY probing completes),
sfp_module_disconnect_nophy() will be called even though
phylink_sfp_connect_nophy() was never invoked. In that case, pl->mod_port
is still NULL.

The phy_link_topo_del_port() function dereferences port->id without a
NULL check, which would cause a NULL pointer dereference.

Should this check for pl->mod_port before calling phy_link_topo_del_port,
similar to how phylink_destroy_sfp_port() does?

> +
> +	phy_port_destroy(pl->mod_port);
> +	pl->mod_port = NULL;
> +}

