Return-Path: <netdev+bounces-256410-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4PnUGXI4gmmVQgMAu9opvQ
	(envelope-from <netdev+bounces-256410-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 19:03:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C5936DD447
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 19:03:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 95280305BABA
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 17:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C80E31B100;
	Tue,  3 Feb 2026 17:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nvwRMtTs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1E1313540;
	Tue,  3 Feb 2026 17:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770141504; cv=none; b=PeGM4+3jk19JUupE/G7Cea0yx1nIktnmaHajWnk7gETxP5fSiVWaaQ4LtH2I7WkdOgR+e7GcxIifJjNbLDEOH/hGPphx3gtDUPFxBovtLFwKST1zxpFw5bLOj929MBCI90a4HVzjPkhB6CLUmSq14X+sjZO7cRF574/hSZqgVA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770141504; c=relaxed/simple;
	bh=i7ngsVOgyWYRqBRdhKIF8AWr2oLdPqek9ILKClmDibA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DogkW610WlQ7zMH2hLjcF8mkcD1VOSzlsQpLKUraqPsQJoSzBRfmETXc4jVUcv4QlNOy08NcqLF13ymRf2HH77T8NnR4tO4bZvN/YQPEmBajVKPIvvrCzB9r0V75yruHbD7cTMaUa6J5sLi43CPMxZ2BMYlUO4Q1uCyVKIhEayg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nvwRMtTs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15412C116D0;
	Tue,  3 Feb 2026 17:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770141504;
	bh=i7ngsVOgyWYRqBRdhKIF8AWr2oLdPqek9ILKClmDibA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nvwRMtTstBHUFZgjT7G2QrdPRGDlP5FwZ/U4KXAOBpMtxCdbQTAz5z2I2Zbbl5Fzz
	 Rmp1hc5zwgiUxyheE2ok2PPhIoHoOkz/hWRarJGJBRgH8fGdz5uAS7Tpnp/51sO8dQ
	 ynVkVps9dv0J/R0i1xFryILZeYHQQVlIG9FIArMEmpUfFcV8nD82tHkOHFZKoJ89+N
	 QGiG5wkPYALVUbVKsAHJh6wJsRstWpIJ+SH8x6OTqVZPqrza0uTTYNyqgvE0bw9+kw
	 2TOMGlTW8yG7+Qr/FlWmgnUSkAC7zEgD+S+jmpaB/o6kuL4S6HH3dMUd9Xg2aSgC3p
	 eD9EK9D2Vp0ig==
From: Simon Horman <horms@kernel.org>
To: maxime.chevallier@bootlin.com
Cc: Simon Horman <horms@kernel.org>,
	christophe.leroy@csgroup.eu,
	thomas.petazzoni@bootlin.com,
	andrew@lunn.ch,
	kuba@kernel.org,
	mwojtas@chromium.org,
	kabel@kernel.org,
	linux-kernel@vger.kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	nicveronese@gmail.com,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	edumazet@google.com,
	dimitri.fedrau@liebherr.com,
	herve.codina@bootlin.com,
	o.rempel@pengutronix.de,
	romain.gantois@bootlin.com,
	netdev@vger.kernel.org,
	daniel@makrotopia.org,
	vladimir.oltean@nxp.com,
	f.fainelli@gmail.com,
	kory.maincent@bootlin.com
Subject: Re: [net-next,v3,01/11] net: phy: phy_port: Correctly recompute the port's linkmodes
Date: Tue,  3 Feb 2026 17:58:13 +0000
Message-ID: <20260203175813.2175230-1-horms@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260201151249.642015-2-maxime.chevallier@bootlin.com>
References: <20260201151249.642015-2-maxime.chevallier@bootlin.com>
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
	FREEMAIL_CC(0.00)[kernel.org,csgroup.eu,bootlin.com,lunn.ch,chromium.org,vger.kernel.org,redhat.com,davemloft.net,gmail.com,armlinux.org.uk,google.com,liebherr.com,pengutronix.de,makrotopia.org,nxp.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[24];
	TAGGED_FROM(0.00)[bounces-256410-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C5936DD447
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: phy: phy_port: Correctly recompute the port's linkmodes

This commit fixes phy_port_update_supported() to properly filter linkmodes
instead of incorrectly or'ing medium-specific modes to the existing support.
It moves the medium iteration inside a check for empty port->supported.

Fixes: 589e934d2735 ("net: phy: Introduce PHY ports representation")

> diff --git a/drivers/net/phy/phy_port.c b/drivers/net/phy/phy_port.c
> --- a/drivers/net/phy/phy_port.c
> +++ b/drivers/net/phy/phy_port.c

[ ... ]

> @@ -132,6 +126,19 @@ void phy_port_update_supported(struct phy_port *port)
>  			port->pairs = max_t(int, port->pairs,
>  					    ethtool_linkmode_n_pairs(mode));
>
> +	if (linkmode_empty(port->supported)) {
> +		for_each_set_bit(i, &port->mediums,
> +				 __ETHTOOL_LINK_MEDIUM_LAST) {
> +			__ETHTOOL_DECLARE_LINK_MODE_MASK(med_supported) = {0};
> +
> +			phy_caps_medium_get_supported(med_supported, i,
> +						      port->pairs);
> +			linkmode_or(supported, supported, med_supported);
> +		}
> +
> +		linkmode_and(port->supported, port->supported, supported);
> +	}

Jakub Kicinski raised a concern in v2 about the AND operation when
port->supported starts empty. The v3 fix adds the
'if (linkmode_empty(port->supported))' check, but then still performs:

    linkmode_and(port->supported, port->supported, supported);

inside that block. Since we just confirmed port->supported is empty,
ANDing it with anything will always produce an empty result.

Should this be linkmode_copy() or linkmode_or() instead of linkmode_and()
when port->supported starts empty?

Reference: https://lore.kernel.org/all/20260130040009.707764-1-kuba@kernel.org/

