Return-Path: <netdev+bounces-199071-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 181CAADED3B
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 15:01:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1EFC3BD598
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 13:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE61154652;
	Wed, 18 Jun 2025 13:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="be1ll927"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B21D19F135;
	Wed, 18 Jun 2025 13:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750251629; cv=none; b=Auiv/hE5JmAQ9cuaOUawjfoTIMC2qdfySDx1rGf8fi9ZG6xGo1b3js8AKGRS0xFulKNJ1aNNMP4S9y23k42GqFwCEtL3yWn2Cq9R7mKY/wJYyzmudKI9aaq15614vM5V7TTRLxdv885CCEZyGUyelpfXLshVPI1TEDnMZWxgo5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750251629; c=relaxed/simple;
	bh=zieR1xov6DswfGQ8i4P9FqWVL6bS74Ya5eDChfERUA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dr4PDLqTnz9ZQ82az2EgXPK94HofyNaRf9SMtluUfTE5QnsHJtKxDjJyANmamSZogcUZz3C9Kvd0DzH2q+qCi2Ej6/eEqbPCElIr7zOYCOlHUw4q79Ov68e0T+Ba+o9GsU0g/Exd93odEHbFamLRBKKeSqYMtqB0hq26S/BdBY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=be1ll927; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=mO1gu+DBwrNJJY+3oX8kNrc8SemWyEG0jMx3n9KGm4c=; b=be1ll92793WCsVrK3SFBkXdREB
	iCwR1b2tkI27rZEM/jNmrIAsrubM6PioxoNKdFEJQ8gv+UY0gnhlHKBP4j/53YuhM0fxUatcx9Tce
	Hr/hVxzR48u/jo/7UjPopxV9XVl59WDHTsxqx3WcDnHrCC8cZPCZZ/LVaefB5G/eQb4aUcfvfwpCG
	ZGLMNlXjnQ+Tk7QJqRSyvAB9L6qX9nFCspA+mbTl0xNuZnnSQXbK+NDYk3SBd6MSI/jEUWfMm6yw0
	n/K2a8idFVlU3TqPoJRM9qkB+g/2x912o1FAiLPLzc31Z+hIH/pe2aJFz6qcuAPH2PyarXjOpqxw5
	N/BiH4Qg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:37618)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uRsOq-0006TW-04;
	Wed, 18 Jun 2025 14:00:20 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uRsOo-0006qZ-25;
	Wed, 18 Jun 2025 14:00:18 +0100
Date: Wed, 18 Jun 2025 14:00:18 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Thangaraj Samynathan <Thangaraj.S@microchip.com>,
	Rengarajan Sundararajan <Rengarajan.S@microchip.com>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, UNGLinuxDriver@microchip.com,
	Phil Elwell <phil@raspberrypi.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next v8 2/6] net: usb: lan78xx: Rename
 EVENT_LINK_RESET to EVENT_PHY_INT_ACK
Message-ID: <aFK4YvppdVCd4xoU@shell.armlinux.org.uk>
References: <20250618122602.3156678-1-o.rempel@pengutronix.de>
 <20250618122602.3156678-3-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250618122602.3156678-3-o.rempel@pengutronix.de>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Jun 18, 2025 at 02:25:58PM +0200, Oleksij Rempel wrote:
> The EVENT_LINK_RESET macro currently triggers deferred work after a PHY
> interrupt. Prior to PHYLINK conversion, this work included reconfiguring
> the MAC and PHY, effectively performing a 'link reset'.
> 
> However, after porting the driver to the PHYLINK framework, the logic
> associated with this event now solely handles the acknowledgment of
> the PHY interrupt. The MAC and PHY reconfiguration is now managed by
> PHYLINK's dedicated callbacks.
> 
> To accurately reflect its current, narrowed functionality, rename
> EVENT_LINK_RESET to EVENT_PHY_INT_ACK.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

