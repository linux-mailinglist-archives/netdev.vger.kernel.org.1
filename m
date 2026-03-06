Return-Path: <netdev+bounces-264812-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CBhcFXLiqmkTYAEAu9opvQ
	(envelope-from <netdev+bounces-264812-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 15:19:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C51062227D5
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 15:19:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2DE3C30E66C3
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 14:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26BA038228E;
	Fri,  6 Mar 2026 14:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rs0jLj8K"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D723659E5;
	Fri,  6 Mar 2026 14:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772806176; cv=none; b=ffhCLPP8UACzB+yXVCk2gD3pBmUUC3ov3/8f7Y9eqtYmqQFVjVvtkTH7xuCSkiMeIeacw3e3Z1OvMmR2QDXXVZ0QbLByn079eIgWVG3+p5tt97S2b+/57IORLh+gi5mmM8KyHGC5EZ6U9O+ioTbtAUV0w/BX4Tx3Gpr8gPof7Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772806176; c=relaxed/simple;
	bh=ETO1FKhVA9R+5FLPb5wIjf4q6G8Zcpki/NBrM1VjVOg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b0ve2sK4EBrvZrLwXeipihkq32BKa4vWKjD36lo+Wc+YBYZO47P0mpXX3nIRInDjaSI3/IhyFawROV8GPXNj2Kcd+ZOoNViLjJsPwUuZQIMY0HwH6tmmb9IKNQOB/F8qXvjFNsOTwfbRNjDR+els/RWkD3IwRr9L8deczXPssCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rs0jLj8K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24C05C4CEF7;
	Fri,  6 Mar 2026 14:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772806175;
	bh=ETO1FKhVA9R+5FLPb5wIjf4q6G8Zcpki/NBrM1VjVOg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rs0jLj8KM7xNoPDrms93MO/9tSDzJv3AEi/IAqEjZfHi/xpe+cWvrhJA0HB9VizAd
	 LtgFZ/wS6rST+KSnIAOjOiAewg0GQfXw8+AbyjLrEKGO8XPFWh9OATxsF/Xm7kTS7q
	 44wSEWA1eZRlhZgEGk2BTkO5vrxxEu1fqRfjBUTUTZeZIrt8XtdRJkAZdLo4vF4yc1
	 SlJqlVzAuap93vANGulnBS+28JsiVxrG+gygobTQjCdZDNI7vSGI6+XU3FrjUdYw+d
	 R7JJSVT4QH8KxZw+8jHXh7+W89FZHilLlTdDSrcvXIYb3S6WgOHpx05RgMopi9YptD
	 ebnYvnfWCw5uA==
From: Simon Horman <horms@kernel.org>
To: maxime.chevallier@bootlin.com
Cc: Simon Horman <horms@kernel.org>,
	vladimir.oltean@nxp.com,
	andrew@lunn.ch,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	hkallweit1@gmail.com,
	kory.maincent@bootlin.com,
	davem@davemloft.net,
	romain.gantois@bootlin.com,
	edumazet@google.com,
	daniel@makrotopia.org,
	herve.codina@bootlin.com,
	nicveronese@gmail.com,
	kuba@kernel.org,
	kabel@kernel.org,
	dimitri.fedrau@liebherr.com,
	christophe.leroy@csgroup.eu,
	f.fainelli@gmail.com,
	linux@armlinux.org.uk,
	netdev@vger.kernel.org,
	mwojtas@chromium.org,
	thomas.petazzoni@bootlin.com,
	o.rempel@pengutronix.de
Subject: Re: [net-next,v6,02/10] net: phy: phy_link_topology: Track ports in phy_link_topology
Date: Fri,  6 Mar 2026 14:09:11 +0000
Message-ID: <20260306140911.495181-1-horms@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260304145444.442334-3-maxime.chevallier@bootlin.com>
References: <20260304145444.442334-3-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C51062227D5
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
	FREEMAIL_CC(0.00)[kernel.org,nxp.com,lunn.ch,redhat.com,vger.kernel.org,gmail.com,bootlin.com,davemloft.net,google.com,makrotopia.org,liebherr.com,csgroup.eu,armlinux.org.uk,chromium.org,pengutronix.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[24];
	TAGGED_FROM(0.00)[bounces-264812-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: phy: phy_link_topology: Track ports in phy_link_topology

This commit adds port tracking to phy_link_topology by introducing a
ports xarray alongside the existing phys xarray. PHY-driven ports are
registered and tracked with unique IDs that can be reused.

> diff --git a/drivers/net/phy/phy_link_topology.c b/drivers/net/phy/phy_link_topology.c
> index fdfafd951905..f7946c73dc5f 100644
> --- a/drivers/net/phy/phy_link_topology.c
> +++ b/drivers/net/phy/phy_link_topology.c

[ ... ]

> @@ -89,8 +126,20 @@ int phy_link_topo_add_phy(struct net_device *dev,
>  	if (ret < 0)
>  		goto err;
>
> +	/* Add all the PHY's ports to the topology */
> +	list_for_each_entry(port, &phy->ports, head) {
> +		ret = phy_link_topo_add_port(dev, port);
> +		if (ret)
> +			goto del_ports;
> +	}
> +
>  	return 0;
>
> +del_ports:
> +	list_for_each_entry_from_reverse(port, &phy->ports, head)
> +		phy_link_topo_del_port(dev, port);

Does this rollback sequence incorrectly delete a port that was never added?
list_for_each_entry_from_reverse() starts at the current entry (the port
that FAILED to add) and iterates backward. This means phy_link_topo_del_port()
is called on the failed port that was never successfully added to the xarray.

Looking at phy_link_topo_del_port():

void phy_link_topo_del_port(struct net_device *dev, struct phy_port *port)
{
	struct phy_link_topology *topo = dev->link_topo;

	if (!topo)
		return;

	xa_erase(&topo->ports, port->id);
}

The spurious xa_erase() is likely harmless in the -ENOMEM case from
xa_alloc_cyclic with port->id == 0, because XA_FLAGS_ALLOC1 reserves index 0.

However, in the xa_insert -EBUSY failure case where port->id is non-zero
and the slot is occupied by a different port, the rollback incorrectly
erases the other port's xarray entry, causing silent data corruption in
the topology's port tracking.

Should this use list_for_each_entry_continue_reverse() instead? That macro
starts from the entry BEFORE the current position, skipping the failed port
and only rolling back successfully-added ports.

The existing xa_alloc_cyclic error handling in the same function uses
'if (ret < 0) goto err' which correctly skips the failed PHY in cleanup.

> +
> +	xa_erase(&topo->phys, phy->phyindex);
>  err:
>  	kfree(pdn);
>  	return ret;

[ ... ]

