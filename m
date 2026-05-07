Return-Path: <netdev+bounces-285519-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +PAIDpEH/WlLWwAAu9opvQ
	(envelope-from <netdev+bounces-285519-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 23:43:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE644EF703
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 23:43:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC4973037884
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 21:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2255B346E70;
	Thu,  7 May 2026 21:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="eaatdxi3"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EAE3311C01;
	Thu,  7 May 2026 21:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778190215; cv=none; b=lEpNvFtibXW9n/C/C2X19aG4bThhNTg+Xzjrkv+cufU6f/GUjWyQn1MM1gKhBm7ATDQBVambulrMjx0z/I+tXolANUxoMOZEgpqvdxdfp2O6uxo9U2M/HYR3rWC9XPbxdo1TaARL5cOYxorZl7Wfhxr6Gd9STOXY2+yVLMabUNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778190215; c=relaxed/simple;
	bh=KHrf8YgswpY3hORqbxfvT8V0brsmocrfLNLz1JNUyTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q0GwlwuHO5oeWGhiGeFrdLasIfwljG0+7kLsZOqHWbHiIedhEXfjOnWg5f3w3jz6+d0/CgfQ8OMP78w8gKfhMV+2EUMxt+z/Tus337naShob9irgo179I/haa+gpsE1kspvrQG9uB8dECdYIXdg5VisR+det0CJD7wM/kupEpGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=eaatdxi3; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=aX36hdB/vSHiUML6vh4mSgGpvQJsS+iDpluEkRtR6aE=; b=ea
	atdxi3jr/eOn1JZiw5IZVBQjFj2PpSS0+PANzy7hG8LX3Cof1djFbbSkIoFJKTsaNiESIybpaHIIe
	buaeR2RXDSAyOuFwT5gM/AM+ocltCTsm9NhZjsJHbKdR5+QZuKl6QS5yDCxRxujASK7zvvB9tHBCI
	S7vBzmszdEb7zrQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wL6V6-001s5C-G8; Thu, 07 May 2026 23:43:20 +0200
Date: Thu, 7 May 2026 23:43:20 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, kevin-kw.huang@airoha.com,
	macpaul.lin@mediatek.com, matthias.bgg@gmail.com,
	kernel@collabora.com, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 4/4] net: phy: Introduce Airoha AN8801/R
 Gigabit Ethernet PHY driver
Message-ID: <27ca6b71-18df-4e47-9117-0e503f7e7d5f@lunn.ch>
References: <20260326-add-airoha-an8801-support-v2-0-1a42d6b6050f@collabora.com>
 <20260326-add-airoha-an8801-support-v2-4-1a42d6b6050f@collabora.com>
 <3688a285-7f98-4afa-80ad-697094cd7b97@lunn.ch>
 <2c441d51f6a865ddb6e67b63cd26a651ed3ff058.camel@collabora.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2c441d51f6a865ddb6e67b63cd26a651ed3ff058.camel@collabora.com>
X-Rspamd-Queue-Id: 8EE644EF703
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285519-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,collabora.com,gmail.com,armlinux.org.uk,airoha.com,mediatek.com,vger.kernel.org,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lunn.ch:mid,lunn.ch:dkim]
X-Rspamd-Action: no action

> > > +static int an8801r_of_init_leds(struct phy_device *phydev, u8
> > > *led_cfg)
> > > +{
> > > +	struct device *dev = &phydev->mdio.dev;
> > > +	struct device_node *np = dev->of_node;
> > > +	struct device_node *leds;
> > > +	u32 function_enum_idx;
> > > +	int ret;
> > > +
> > > +	if (!np)
> > > +		return 0;
> > > +
> > > +	/* If devicetree is present, leds configuration is
> > > required */
> > > +	leds = of_get_child_by_name(np, "leds");
> > > +	if (!leds)
> > > +		return 0;
> > > +
> > > +	for_each_available_child_of_node_scoped(leds, led) {
> > > +		u32 led_idx;
> > > +
> > > +		ret = of_property_read_u32(led, "reg", &led_idx);
> > > +		if (ret)
> > > +			goto out;
> > > +
> > > +		if (led_idx >= AN8801R_NUM_LEDS) {
> > > +			ret = -EINVAL;
> > > +			goto out;
> > > +		}
> > > +
> > > +		ret = of_property_read_u32(led, "function-
> > > enumerator",
> > > +					   &function_enum_idx);
> > > +		if (ret)
> > > +			function_enum_idx = AN8801R_LED_FN_NONE;
> > > +
> > 
> > What is this doing? Is this documented in the binding?
> The `function-enumerator` property is only documented in the led common
> dt-binding file. The an8801 dt-bindings inherits this property from the
> ethernet-phy dt-bindings.
> 
> We aimed to have this PHY have its led behaviour (how many to enable
> and what their role shall be) configurable using devicetree and not to
> rely on a default configuration, hard-coded in the driver (like the
> air_en8811h driver did) and also make use of the led hardware
> offloading (for functions like 100/1000, activity blinking, and others)
> that this PHY is capable of.

What other drivers do is leave the configuration with its reset
default. They are often sensible. When the netdev trigger loads, it
should ask the LED how it is configured, and the values in sysfs will
reflect it. After that you can change it, via udev rules, etc.

You have to be careful about what you put in DT. DT describes
hardware, not configuration or policy. How the LED blinks is probably
configuration, so it does not belong in DT.

> > > +static int an8801r_read_status(struct phy_device *phydev)
> > > +{
> > > +	int prev_speed, ret;
> > > +	u32 val;
> > > +
> > > +	prev_speed = phydev->speed;
> > > +
> > > +	ret = genphy_read_status(phydev);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	if (phydev->link && prev_speed != phydev->speed) {
> > > +		val = phydev->speed == SPEED_1000 ?
> > > +		      AN8801_BPBUS_LINK_MODE_1000 : 0;
> > > +
> > > +		return an8801_buckpbus_reg_rmw(phydev,
> > > +					      
> > > AN8801_BPBUS_REG_LINK_MODE,
> > > +					      
> > > AN8801_BPBUS_LINK_MODE_1000,
> > > +					       val);
> > > +	};
> > 
> > This is unusual. What is it doing? Please add a comment.
> This call is to ensure that the PHY switches to the expected 1Gbps 
> speed when available. 

So this is an errata workaround? Please add this in a patch of its
own, described the problem in the commit message, list the errata etc.

     Andrew

