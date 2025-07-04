Return-Path: <netdev+bounces-204059-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A80AF8BE1
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 10:35:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AE141896850
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 08:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B423287504;
	Fri,  4 Jul 2025 08:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="B6dla3cF"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2AA1286D4E;
	Fri,  4 Jul 2025 08:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751617436; cv=none; b=EmtJH2m9zsqTK6p1ML+6bD66Nqei1z0dvmf4dZT7NNQNW2qekvWa+Vp0CKuWePnsykABcwrHtoBs2uRRai9NfJMmyPUwON8Dbc9Upl+7p9cGoIUhx49pguhtRaNe10zvjyNfkXrGkyIhgW8LRkwyPVqKNxc0u1a+Byf3g4Qhd6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751617436; c=relaxed/simple;
	bh=AhBOGZpyNBezbeMqyV9SBqUK8U1F3gnT/o7RaFg59yc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BMgiI3ahRyGpaLjxlceG6PTZDZP4NxD6XONyoYQLauECcFIOUSJ4x/dre+AAStcV9blgYHifdDMXQ3ke4xigH3CA7mjVd4WNH4n/B8eWisEhJBDusZpsHsVUo3pHeI35lYHSPvqUPpJMahh2FUeMSxULnTqvyw5mGWxTuKtEC/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=B6dla3cF; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=3e4OiwOx6hF5cHaw9Ub9LrjSFyxnJn7uIhK0AViVS5E=; b=B6dla3cFOsgwgvYRLDJondkW1c
	JxJQmMuivBXLN0c3RjZIEhsqjmUF8WZh6v+cye0WKqR25qrkCAnFf9kOtEhPxoFRVLyoOcEfY1bFz
	w+9tMhCRumhLrL3xaHkmbGJ5zrbBQVvl8K7eXF3ZA6O8hfnD4VlfBpfXHeVd9Etq1rZg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uXbhx-000BSJ-8R; Fri, 04 Jul 2025 10:23:45 +0200
Date: Fri, 4 Jul 2025 10:23:45 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andre Edich <andre.edich@microchip.com>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
	netdev@vger.kernel.org, Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH net v2 3/3] net: phy: smsc: Fix link failure in forced
 mode with Auto-MDIX
Message-ID: <4012e00f-2192-4cfb-9e29-a8d1855c9ff6@lunn.ch>
References: <20250703114941.3243890-1-o.rempel@pengutronix.de>
 <20250703114941.3243890-4-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250703114941.3243890-4-o.rempel@pengutronix.de>

On Thu, Jul 03, 2025 at 01:49:41PM +0200, Oleksij Rempel wrote:
> Force a fixed MDI-X mode when auto-negotiation is disabled to prevent
> link instability.
> 
> When forcing the link speed and duplex on a LAN9500 PHY (e.g., with
> `ethtool -s eth0 autoneg off ...`) while leaving MDI-X control in auto
> mode, the PHY fails to establish a stable link. This occurs because the
> PHY's Auto-MDIX algorithm is not designed to operate when
> auto-negotiation is disabled. In this state, the PHY continuously
> toggles the TX/RX signal pairs, which prevents the link partner from
> synchronizing.

That is not good. Somebody got that badly wrong. They should operate
independently.

> This patch resolves the issue by detecting when auto-negotiation is
> disabled. If the MDI-X control mode is set to 'auto', the driver now
> forces a specific, stable mode (ETH_TP_MDI) to prevent the pair
> toggling. This choice of a fixed MDI mode mirrors the behavior the
> hardware would exhibit if the AUTOMDIX_EN strap were configured for a
> fixed MDI connection.

The text implies it, rather than states it, but the code supports
setting a fixed mode before turning autoneg off. So user space does
have full control if needed.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

