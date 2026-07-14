Return-Path: <netdev+bounces-307597-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TVJ+J3apVmqB/wAAu9opvQ
	(envelope-from <netdev+bounces-307597-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 23:26:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 36468758F9B
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 23:26:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b=N469ay99;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307597-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307597-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=lunn.ch;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 24864302E926
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 21:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D80429CDA;
	Tue, 14 Jul 2026 21:26:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF9540D590;
	Tue, 14 Jul 2026 21:26:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784064366; cv=none; b=uXRTmXQXIcXEXJSPgNzeFudWl3uzJKN1EN5XPuZ+3rS8QQkqh4VPWqgFNQBNw8DRcpu29W+XOs76n0geIb+jl5vBHTOOkOJua5gAHLfDLLD9tUwNUeu50L/xxR8GrqLvChdxusijKWL0TzJOBitX3mY2EFZgY7Pztc2OPZ4vgUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784064366; c=relaxed/simple;
	bh=K8J6oPxjgmTJ7fyU1h6chiS+KMrCFolhxacoMa2oN3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZR39h12Y4OGQ5zyK1FxImdYZReEOmWrfTQdDO9GIdx4aVz9lYlKg/dCJMUvwIB97/nB2aCcB+YBpNknwt7PsxM6gevagPJKE12X7VHgGPDSLpjtaXMPZMrteuYbSrNcvSX/wic17b4cRlT394svskd1xMHIgpvWl190XHWTuC/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=N469ay99; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=MsR2KbYLSyQF72+KA6xaRaH75h8QqeIfFLr6MHB+Zc8=; b=N469ay99+/ZaIlavpJcpDuFsPQ
	S2Y8q9ICABsWs87hzWYvv3ghxupOpluKi4Yxa/iLGWU8QFI04WTi0I4+l27mg0YTpr5inqR0WNktL
	CBnXc79CPLO68HgK4pX8fraanE3FHPekZyYod7i/y2N0o7OVd4HCsR5dhZr1YocBB9JY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wjkdY-00CFhF-1j; Tue, 14 Jul 2026 23:25:56 +0200
Date: Tue, 14 Jul 2026 23:25:56 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Artem Shimko <a.shimko.dev@gmail.com>
Cc: netdev@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] net: phy: add DAPU Telecom DAP8210R(I)
 Gigabit Ethernet PHY driver
Message-ID: <5c95a7cd-d5d7-4998-8641-7dee1e34078b@lunn.ch>
References: <20260713131223.279555-1-a.shimko.dev@gmail.com>
 <20260713131223.279555-3-a.shimko.dev@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260713131223.279555-3-a.shimko.dev@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:a.shimko.dev@gmail.com,m:netdev@vger.kernel.org,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:linux-kernel@vger.kernel.org,m:devicetree@vger.kernel.org,m:ashimkodev@gmail.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-307597-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 36468758F9B

> The driver also exports a debugfs interface for diagnostics,
> exposing PHY status registers and providing runtime control over the
> internal packet generator, CRC corruption, and loopback functionality.

Please drop all this. Many PHYs have this sort of facility. We want
one generic API, probably via ethtool, which all PHYs can follow, not
N different incompatible APIs.

> +static u32 dap8211r_get_rgmii_delay(struct phy_device *phydev, const char *prop_name)
> +{
> +	struct device_node *np = phydev->mdio.dev.of_node;
> +	int ret;
> +	u32 ps = 0;
> +
> +	ret = of_property_read_u32(np, prop_name, &ps);
> +	if (ret) {
> +		phydev_dbg(phydev, "Using default delay (%ups)\n", DAP8211R_DEFAULT_DELAY_PS);
> +		ps = DAP8211R_DEFAULT_DELAY_PS;
> +	}

This can be simplified.

First off, there probably too many phydev_dbg() messages, specially
for normal case things, using defaults, etc. 

of_property_read_u32_array() is documented as not touching the results
value, if it does not find the property. So you can do:

	u32 ps = DAP8211R_DEFAULT_DELAY_PS;
	of_property_read_u32(np, prop_name, &ps);
  
	return dap8211r_delay_ps_to_sel(phydev, ps);

> +static int dap8211r_config_init(struct phy_device *phydev)
> +{
> +	struct device_node *phydev_node = phydev->mdio.dev.of_node;
> +	u16 mask = 0, set = 0;
> +	int ret;
> +
> +	switch (phydev->interface) {
> +	case PHY_INTERFACE_MODE_RGMII:
> +		break;

This is one of the less well defined areas. PHY_INTERFACE_MODE_RGMII
would mean either the PCB is adding the delay, or the MAC. There is no
reason however why the PHY cannot perform fine tuning, adding a small
delay, say 150ps. So you should respect the rx-internal-delay-ps and
tx-internal-delay-ps delays here. 

	Andrew

