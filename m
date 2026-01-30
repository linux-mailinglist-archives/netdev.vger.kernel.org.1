Return-Path: <netdev+bounces-255013-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WKBzORMtfGk3LAIAu9opvQ
	(envelope-from <netdev+bounces-255013-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 05:01:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE8FB6F92
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 05:01:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 78BCD3033FAE
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 04:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F0CD368278;
	Fri, 30 Jan 2026 04:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LnKo6Ctz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3F6366567;
	Fri, 30 Jan 2026 04:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769745614; cv=none; b=PRsYXJqxIuc70hkxP0yAgbWlunvEZL8u5givWFXCPFrQe3i5FmE7Ir2vMzN9usKhVKHqKFb5zkLHt3qxhj3zwzo2minJTPxUB0Jfmi9HsEZiN4yhQ2x/5rG8mJiD8hRYStJesfi/m1tRWk1udysI+a5cFfrsq374JU4GlkoRa0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769745614; c=relaxed/simple;
	bh=0vf74shMUMiXJiT/+u/jpr0rxVx2gUk+K5gyfpjc8vw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hx417it7REis2Gzo6pmrYZdR0QOTD8RaTZyryR7OeGyUb49AFhFSSjF+dAdc2qJL3gXRYyJQnyvwPhflmYJBdwEGSU5izFWHhH/A9T8fqKZji9xf9+EFjKCq4rM7GS7ylLciYTQw1AaAYkZfwDY74YxMqMQHPzEGjTo1gV/RtxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LnKo6Ctz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B20D8C116C6;
	Fri, 30 Jan 2026 04:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769745613;
	bh=0vf74shMUMiXJiT/+u/jpr0rxVx2gUk+K5gyfpjc8vw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LnKo6CtzksvJ2Ce0mSDB7irPqa933p8WFpJNX1I2JrYKrGrD1aAlAf4KxvItbLp6/
	 qg5tscu+TQS4RVDGTeZB7GPncA45/j0ImKnFccUp9LsxjXwqyHPILwZjGGstnCIbgk
	 dcBPvQAYXUS8AUJ3rMxX08Cx2beagIjBzaLp1tlTVIZfhQTyWob8van9BnMET96gn7
	 RskNm26ddmNnhMql2EhJ0WOkoFtFf/AW1kF4e9eIiwM8brrHJCwTI7hNp41hDAgDxg
	 AvCOhlbfktNQQUX4yj5Tt2MNADnm3+xs4U35RPhieoemATIKVb21pYWngkhQmcPdtJ
	 fmMb/YDVGYs4g==
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
Subject: Re: [net-next,v2,03/12] net: phy: phy_link_topology: Track ports in phy_link_topology
Date: Thu, 29 Jan 2026 20:00:11 -0800
Message-ID: <20260130040011.707782-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128204526.170927-4-maxime.chevallier@bootlin.com>
References: <20260128204526.170927-4-maxime.chevallier@bootlin.com>
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
	TAGGED_FROM(0.00)[bounces-255013-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: 4EE8FB6F92
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
    net: phy: phy_link_topology: Track ports in phy_link_topology

This commit adds a new ports xarray to phy_link_topology to track
phy_port structures alongside PHY devices. The ports are added when
a PHY is added and removed when a PHY is removed.

> diff --git a/drivers/net/phy/phy_link_topology.c b/drivers/net/phy/phy_link_topology.c
> index 7dc2ff10c74a..456f1144e83e 100644
> --- a/drivers/net/phy/phy_link_topology.c
> +++ b/drivers/net/phy/phy_link_topology.c

[ ... ]

> @@ -22,6 +23,9 @@ static int netdev_alloc_phy_link_topology(struct net_device *dev)
> 	xa_init_flags(&topo->phys, XA_FLAGS_ALLOC1);
> 	topo->next_phy_index = 1;
>
> +	xa_init_flags(&topo->ports, XA_FLAGS_ALLOC1);
> +	topo->next_port_index = 1;
> +
> 	dev->link_topo = topo;
>
> 	return 0;

The ports xarray is initialized here, but netdev_free_phy_link_topology()
in net/core/dev.c only calls xa_destroy() on topo->phys:

    static void netdev_free_phy_link_topology(struct net_device *dev)
    {
        struct phy_link_topology *topo = dev->link_topo;

        if (IS_ENABLED(CONFIG_PHYLIB) && topo) {
            xa_destroy(&topo->phys);
            kfree(topo);
            dev->link_topo = NULL;
        }
    }

Should xa_destroy(&topo->ports) be added before the kfree(topo) to avoid
leaking memory allocated by the ports xarray?

