Return-Path: <netdev+bounces-155543-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 487B5A02E98
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 18:07:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39B12164958
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 17:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F14D1D934B;
	Mon,  6 Jan 2025 17:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="zI8O9EZg"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2AA4155391
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 17:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736183232; cv=none; b=nYBQ/RVhODATqhiq6CyqRfDraC5zaYMQUQb9AwuhMTOAV2cftNFUEXqKNK+3m5OJIz7s1eh/BCrkLqSlaKvusGq4a8Qx5iH6pxHAsbk2L4ZdzeWrqbkbQvzwlNkDadYuN6ZnIuRcSJpBCrOUXKAPPM/RfclNCOUaimH30ns0D/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736183232; c=relaxed/simple;
	bh=YTrm6BK57SeTI4Zp0TVKB9QLlvm97rld6HH02OxDC5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uJYA4B7zbBaSeffQdfLpETpcgwZp39qCWOM/hZ2QQg9JMOyvzG3CmAHA8teItrkmD1P0fScMV4QLQ3gUHptMFfgRubw6Ub42zo8vehfBUEmmNUizE3HiqCGds/agcKoch2XjWm/jdZwM4Qd+MXjXtBm+jv9npuO9zq6CmCVPhZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=zI8O9EZg; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=DVztrZbTuyhMG1+k+QfVhFy7XwvC5jeioCzcRqo9VYw=; b=zI8O9EZgn8eeFij/+UY2jYDOM5
	YkZQGXp1LCljcJ1jRnMMsv+oN2PUndPSGKt6pGEHLwoifFj7PyWXlVbn7/j19ziXTf4kKirOST7aY
	OuxEFuZMTPwsc4yzHe9db3YS/tuho8AC74cFoMDFRwKv/rX/sNH3uCjm4FWsWzFTrROs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tUqZ9-001wQR-7S; Mon, 06 Jan 2025 18:06:59 +0100
Date: Mon, 6 Jan 2025 18:06:59 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Jose Abreu <joabreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v2 15/17] net: stmmac: remove unnecessary EEE
 handling in stmmac_release()
Message-ID: <fbfb1179-7362-490f-80a0-e7fc7f43a39b@lunn.ch>
References: <Z3vLbRQ9Ctl-Rpdg@shell.armlinux.org.uk>
 <E1tUmBE-007VY5-DJ@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1tUmBE-007VY5-DJ@rmk-PC.armlinux.org.uk>

On Mon, Jan 06, 2025 at 12:26:00PM +0000, Russell King (Oracle) wrote:
> phylink_stop() will cause phylink to call the mac_link_down() operation
> before phylink_stop() returns. As mac_link_down() will call
> stmmac_eee_init(false), this will set both priv->eee_active and
> priv->eee_enabled to be false, deleting the eee_ctrl_timer if
> priv->eee_enabled was previously set.
> 
> As stmmac_release() calls phylink_stop() before checking whether
> priv->eee_enabled is true, this is a condition that can never be
> satisfied, and thus the code within this if() block will never be
> executed. Remove it.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

