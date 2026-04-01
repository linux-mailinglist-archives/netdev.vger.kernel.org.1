Return-Path: <netdev+bounces-274108-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YHIUAMghzWlZaQYAu9opvQ
	(envelope-from <netdev+bounces-274108-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 15:46:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF4F37B802
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 15:46:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C59E1317CFB1
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 13:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 436683D8121;
	Wed,  1 Apr 2026 13:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="qEyN2lO1"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE28338C2DF
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 13:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775049095; cv=none; b=nyMFTw7k88HHMUxQCIL8bzQRoZYvQ+If9e87jekIoDIpcdZY+RXuCV7h0V+c18TP8NmagE93lbS5BNgDAwrQvw2h18CwdgvaKte9zGppolO9McLYal/UK/QXyYe9s7PDandrYmqLNIQTBIUyYdKMiW+uJseTSnj1M+f9Doq1cx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775049095; c=relaxed/simple;
	bh=TmXuWhLBRhppl4oK9aaPfpWnyQFgU7qDqxwW5MSEBho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=udG7pmgPAAOZjAt5zetL8dC8EYaCW3dM4m1BvTVVn61HE9fkHSLANKgc2rcyiRjHv8At+9t0lmqTrRymnY0OSEHv5wOzzJoOyW9Te/weF6n/eRzSgi26GTNRwOya5wZKKdUvxUjPrpnayBAXgBQjZpXixNDsXZvuKXPnzmK6XLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=qEyN2lO1; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=TGsWuisMMtPheOsEqS56ym7J2ivZZmE/CfR/ItpZwAw=; b=qEyN2lO1PRiAY0CrHUGkewkL58
	AUq7P7Xpake4dGGeduRHe0i/1GlJQLSnQ8jBAEoMl6pEBjyWE8KhXBgOxJhfhDfBwVLpE1WD9M4DH
	bfxM/gTPUTMljPkZhl5OuOgSfk4p5WiUNGbiDj94+pysp+nU+nfRM92hY7LkaWydQrzc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1w7vLw-00EMFB-CD; Wed, 01 Apr 2026 15:11:24 +0200
Date: Wed, 1 Apr 2026 15:11:24 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, netdev@vger.kernel.org
Subject: Re: RFC: phylink: disable PHY autonomous EEE when MAC manages LPI
Message-ID: <48abd3e3-a3ee-4e85-a3d8-20c8ceedfb77@lunn.ch>
References: <d86c53213a6328b701b8aabbde5d1c83@tipi-net.de>
 <04ff15af-26be-4278-bc2a-889e7802d271@lunn.ch>
 <aczMqBNesQH-tHx0@shell.armlinux.org.uk>
 <ccb68eaaca5512d5d662326d0817bd50@tipi-net.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ccb68eaaca5512d5d662326d0817bd50@tipi-net.de>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	TAGGED_FROM(0.00)[bounces-274108-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 5DF4F37B802
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> Thanks Russell and Andrew. You're both heading in the same direction,
> so to make sure I understand correctly:
> 
> 1. Add a new phylib interface (separate from phy_ethtool_set_eee) to
>    control PHY-autonomous EEE, e.g. phy_set_autonomous_eee(phydev,
>    enable) and phy_get_autonomous_eee(phydev) to query the current
>    state.

In the end, we want the MAC driver using phylib to just call the
phylib methods for configuring EEE, and the MAC driver should not care
if EEE is actually implemented in the PHY or the MAC. The adjust_link
callback would simply not enable LPI if the PHY is doing EEE.

The phylink API should do the same, the MAC driver should not care, it
calls into phylink, but phylink never tells it to enable LPI.

So any API you add here should only be for phylink to phylib.

> 2. PHY drivers implement it where applicable. BCM54xx AutogrEEEn as
>    the first user, Realtek RTL8211F as a second - it already
>    unconditionally disables PHY-mode EEE in config_init with the same
>    intent.

We might want to think about this lower API, the driver
API. Historically EEE has been a mess because MAC drivers have been
left to implement the whole API, they each did it differently, and
many were wrong. There has been a push over the last few years to put
the core of EEE support onto phylib/phylink, so leaving the MAC
drivers to do a small amount.

We should learn from this, and try to think about what can the phylib
core should do for PHY level EEE, and what does the PHY driver need to
do?  Maybe passing the whole struct ethtool_keee to the PHY driver is
just asking for problems. We want a much simpler API to start with.
Just add an autonomous_eee_disable() call for the moment, leaving it
open to later add a autonomous_eee_enable() call with just the needed
parameters.

Sorry this is different to what i said yesterday. A night of thinking
about it made me refine my thoughts.

      Andrew

