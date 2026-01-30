Return-Path: <netdev+bounces-255012-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uOoZB+ssfGk3LAIAu9opvQ
	(envelope-from <netdev+bounces-255012-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 05:00:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F0AB6F75
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 05:00:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 620F53011864
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 04:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7D0636680E;
	Fri, 30 Jan 2026 04:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fCM6VN+z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5680366565;
	Fri, 30 Jan 2026 04:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769745611; cv=none; b=lxvom2MZ+VFGlqIuySdJfTMdEkByxnMIvYlgARrf1MAvi/cP21Iwi3fnlphijqn2GjwxU+Fx8ZfLkJZqAYN15011t5fp0gfjnuKc5M9ugu42CjFwnijt+MT9RgS4E0rEpbsteywYLOQrCsRN72dNuXMoeobejEv6sarlNq4ObCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769745611; c=relaxed/simple;
	bh=2Hhh/mAqS97mYpWJZDuBrLuLsQrdkd3jfFyqjyxk7tI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CyZYJ7fOJdglJtr9nr919OtN9VY0pc15i84OGOd5Wb4ew2OIzikX9zDLWHqu/QjDQ+OdPpzsYuoX9PFXNJ3xQORQu+MMN1JCOX1YR0EuCE1fMRwZsYpr+T+fpFBj+qNpOVEa7XVlDl+SMkw0ihgis5s1AY8LNzFxxUKDtOrKdk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fCM6VN+z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C95AC4CEF7;
	Fri, 30 Jan 2026 04:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769745611;
	bh=2Hhh/mAqS97mYpWJZDuBrLuLsQrdkd3jfFyqjyxk7tI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fCM6VN+zpvoVnOSfLruZjvdS1oxzpxJTYC2dnhpsGdy0H/dKCYNqVi/prYsz3H8/S
	 YvmPKLqRHXa7kmWn9unpobB821s1OV/Qp0I0R7TjaHMwqMZI9ilMxBH+CKdz+Pa9vb
	 nUpLbZSQtXG2uXLYBvg89ExLEex4Z5+Wnuk+N6zxqIstzQZD8i85kHvBrcCF/n1F4g
	 hDROqD6U2FkCZGBpnfhwkLzF6yewHxUcGUOmzU1V7eSyuRi7kSiK7OX5NFYDNsDRL9
	 ybEBnzd6sVtZ98UfToohxcaK4fe2/n8tq85mE+xcYPd2vrh/lNZO03y870IB6B9xkg
	 aRreFk+prHM+w==
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
Subject: Re: [net-next,v2,01/12] net: phy: phy_port: Correctly recompute the port's linkmodes
Date: Thu, 29 Jan 2026 20:00:09 -0800
Message-ID: <20260130040009.707764-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128204526.170927-2-maxime.chevallier@bootlin.com>
References: <20260128204526.170927-2-maxime.chevallier@bootlin.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,makrotopia.org,csgroup.eu,bootlin.com,gmail.com,nxp.com,vger.kernel.org,chromium.org,pengutronix.de,liebherr.com,google.com,redhat.com,lunn.ch,davemloft.net,armlinux.org.uk];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[24];
	TAGGED_FROM(0.00)[bounces-255012-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: A0F0AB6F75
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: phy: phy_port: Correctly recompute the port's linkmodes

This patch changes phy_port_update_supported() from OR'ing medium-specific
modes into port->supported to AND'ing (filtering) port->supported against
the accumulated medium modes.

Fixes: 589e934d2735 ("net: phy: Introduce PHY ports representation")

> diff --git a/drivers/net/phy/phy_port.c b/drivers/net/phy/phy_port.c
> index ec93c8ca051e..68a0068220ed 100644
> --- a/drivers/net/phy/phy_port.c
> +++ b/drivers/net/phy/phy_port.c
> @@ -118,11 +118,14 @@ void phy_port_update_supported(struct phy_port *port)
>  	int i;
>
>  	for_each_set_bit(i, &port->mediums, __ETHTOOL_LINK_MEDIUM_LAST) {
> -		linkmode_zero(supported);
> -		phy_caps_medium_get_supported(supported, i, port->pairs);
> -		linkmode_or(port->supported, port->supported, supported);
> +		__ETHTOOL_DECLARE_LINK_MODE_MASK(med_supported) = {0};
> +
> +		phy_caps_medium_get_supported(med_supported, i, port->pairs);
> +		linkmode_or(supported, supported, med_supported);
>  	}
>
> +	linkmode_and(port->supported, port->supported, supported);

When port->supported starts empty (all zeros), this AND operation will
always produce an empty result regardless of what modes are in supported.

Tracing the call path of_phy_ports() -> phy_of_parse_port() -> phy_add_port()
-> phy_port_update_supported(): phy_of_parse_port() creates the port via
phy_port_alloc() which zeros port->supported, and phy_of_parse_port()
only sets port->mediums and port->pairs without populating port->supported.

The attach_mdi_port() callbacks for drivers like dp83822 and marvell10g
also do not set port->supported before phy_port_update_supported() runs.

Does this leave port->supported empty for ports described in device tree?

The docstring above this function at line 112 states "Any mode that was
manually set in the port's supported list remains set" - but for the DT
path where port->supported starts at zero, the AND with zero produces
zero regardless of what medium modes were computed.
-- 
pw-bot: cr

