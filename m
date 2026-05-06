Return-Path: <netdev+bounces-284950-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IJ7kOQJv+2lmbAMAu9opvQ
	(envelope-from <netdev+bounces-284950-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 18:40:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C86E4DE375
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 18:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C0960300CFC8
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 16:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A263EE1CB;
	Wed,  6 May 2026 16:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ypSka1l4"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C476B43E4A1
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 16:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778085624; cv=none; b=lG4UdZp51Qh7VOEGQxAz0+5XUbWCH2Cs5JMXElEI1kWeYgwYVdD8581GPsESHPu4n+SVV+bBUjjcEbVocHM9FqM/IoLb7xinC9FADlF/3wwZbFjhokgDvTRkP90r9mfeYGgKqzqeGxo+M18pwfRQDnFtiUuDlNOMm37GNtstTAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778085624; c=relaxed/simple;
	bh=Cnzp6LjzGgiKVX44j7GjuNUFqCIQ0MGvUDnihNtbTUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eaYulU7hpqHypPscGH9LrCL9gqNbsAxuBn/R0pto2k3VQ0fjttPnm5N+DA7AbTeDYLe804H3UzVBeo6DCTsJmvzSwMYkY8BbUoEG+U9iT+q6F1BLjOXNor+e1pzz1m/E0F20od/TtyM7tJkGIrJIR51O98ywFbCJl9bAeNgedj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ypSka1l4; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Nq7IRFpblbQGD6howaqPIFcyNa3cYlYv9exZuL5nCeM=; b=ypSka1l4N/0T15vLv3/EE/svv2
	G6oVBg0ucb8qpbnkK1rhdoD51fKIKhJF7OIF0d6jMZ7YDvvWk8dC/6vzNiJIIfrBIESeltOq16g9X
	DCljF/OEeIGdDY7OzvNl3jwWZIR6bSVhG/kBVgZMwzSfYveVvrwD8aqi7/trHLtJXWO8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wKfIK-001fzs-C5; Wed, 06 May 2026 18:40:20 +0200
Date: Wed, 6 May 2026 18:40:20 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Sven Schuchmann <schuchmann@schleissheimer.de>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: assert in phylink.c with lan7801 and dp83tc811 since kernel 6.18
Message-ID: <24815161-68ff-4f3e-b0e1-286871b9686a@lunn.ch>
References: <BEZP281MB224533D524B27CFC6E47B447D93E2@BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM>
 <57fb63c2-7a05-4bbe-ba2d-fc61ce1e3ba1@lunn.ch>
 <BEZP281MB22458F571CC8251C141D933CD93F2@BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM>
 <7778cd41-cf36-4524-a347-408a8fb0bde0@lunn.ch>
 <f9b8840d-94ba-4bde-9ace-fb81eb733ff9@bootlin.com>
 <eba96f21-78e6-42bf-938a-6d4037d0a305@lunn.ch>
 <BEZP281MB22457317618130F28E84E3B4D93F2@BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BEZP281MB22457317618130F28E84E3B4D93F2@BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM>
X-Rspamd-Queue-Id: 6C86E4DE375
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284950-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,bootlin.com:url,lunn.ch:dkim,lunn.ch:mid]

> 	phylink_dbg(pl, "phy: --3.4 supported    0x%x\n", supported);

supported is a pointer, so you cannot get anything useful from
printing its value.

> [    2.771616] lan78xx 1-1.4:1.0 (unnamed net_device) (uninitialized): validation of rgmii-id with support 00000000,00000000,00000000,00006280 and advertisement 00000000,00000000,00000000,00006280 failed: -EINVAL
 
> But I do not get what phylink_is_empty_linkmode() is doing...

The supported value is a combination of a few things. It indicates if
the PHY supports auto negotiation, pause, asym pause, if the link is
using twisted pair, fibre etc. It also lists the speeds the PHY
supports. There is a list here:

https://elixir.bootlin.com/linux/v7.0.1/source/include/uapi/linux/ethtool.h#L1963

Decoding 00006280 we get:

ETHTOOL_LINK_MODE_TP_BIT,
ETHTOOL_LINK_MODE_MII_BIT,
ETHTOOL_LINK_MODE_Pause_BIT,
ETHTOOL_LINK_MODE_Asym_Pause_BIT

So Maxime was correct, it is not listing any link speeds. From what i
understand, it is a 100BaseT1? So you would expect to see:

ETHTOOL_LINK_MODE_100baseT1_Full_BIT

which is bit 67.

phylib asks the PHY what it can do. For BaseT1 that would be
genphy_c45_pma_baset1_read_abilities()

https://elixir.bootlin.com/linux/v7.0.1/source/drivers/net/phy/phy-c45.c#L971

either the PHY has the wrong value in its register, or the function is
not getting called.

The PHY is an dp83tc811?

https://elixir.bootlin.com/linux/v7.0.1/source/drivers/net/phy/dp83tc811.c#L387

It does not set .get_features. However, dp83tg720.c does:

https://elixir.bootlin.com/linux/v7.0.1/source/drivers/net/phy/dp83tg720.c#L654

So try adding:

	.get_features	= genphy_c45_pma_read_ext_abilities,

	Andrew

