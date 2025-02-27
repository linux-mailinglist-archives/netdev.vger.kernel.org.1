Return-Path: <netdev+bounces-170438-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26277A48B8C
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 23:28:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E221B7A4052
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 22:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 004CE2777E7;
	Thu, 27 Feb 2025 22:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="VpEv/xRo"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5649C2777E0
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 22:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740695287; cv=none; b=c65wAlH8Ig5f/6lEJWOKxrxZHfP1AniHiMqgwEb0dG1EziZUlnp/k25J92SEh3MglD3h57IKtPbt04BRe8igr8ykJBk0ae5XCmJXSiuOMB+DMGBcOY/L02r007yiXRIjoyLjj3pB9/KKdze8iOSNHOjbWDzk1GfSco73Nw1/cJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740695287; c=relaxed/simple;
	bh=XwNeeD0hitmCyJjinlUo1z4dJouHptA3k99kn0S+SSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M7EUL0DcUXHixdwRgJ5tRzjCWlvmsvjquwTnVCVNWuOdHRuPsrIATDhmSrQ2xMnjkmg7G648ZYhopJbrb4PxOfhG9m7r5Y/XzXMLmVkHnC40oWdYdE2pAo2cUgbSLwxXGBF6q3bFC+X0iNRtkbCOLxcMi9yn4mMKyuWo01Z43q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=VpEv/xRo; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=SHOEZHu/+tii/WYRiY6/uQoRwGdb261OsJSFtvsTK3A=; b=VpEv/xRoCufejRZ7XLrUfeeTRj
	wm9DCyNUBIe+2f1wR69e6f6gEyiAWArsnbN5nyylqdzs+pbhKYUokYYEDRbyaBGmWYszG7bBK6aLz
	kdfphHaWibb8WWXtvvp13bFFKSZEqbZHTTtMnGaGL5ZE9iGDtHi+vt0m32cEQSGLE7wU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tnmMH-000jvl-IG; Thu, 27 Feb 2025 23:27:57 +0100
Date: Thu, 27 Feb 2025 23:27:57 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Jon Hunter <jonathanh@nvidia.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH RFC net-next 1/5] net: stmmac: call phylink_start() and
 phylink_stop() in XDP functions
Message-ID: <92442281-9896-4271-a040-0c14331cb1d3@lunn.ch>
References: <Z8B-DPGhuibIjiA7@shell.armlinux.org.uk>
 <E1tnfRe-0057S9-6W@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1tnfRe-0057S9-6W@rmk-PC.armlinux.org.uk>

On Thu, Feb 27, 2025 at 03:05:02PM +0000, Russell King (Oracle) wrote:
> Phylink does not permit drivers to mess with the netif carrier, as
> this will de-synchronise phylink with the MAC driver. Moreover,
> setting and clearing the TE and RE bits via stmmac_mac_set() in this
> path is also wrong as the link may not be up.
> 
> Replace the netif_carrier_on(), netif_carrier_off() and
> stmmac_mac_set() calls with the appropriate phylink_start() and
> phylink_stop() calls, thereby allowing phylink to manage the netif
> carrier and TE/RE bits through the .mac_link_up() and .mac_link_down()
> methods.
> 
> Note that RE should only be set after the DMA is ready to avoid the
> receive FIFO between the MAC and DMA blocks overflowing, so
> phylink_start() needs to be placed after DMA has been started.

Sorry, i don't know enough about XDP to review this :-(

	Andrew

