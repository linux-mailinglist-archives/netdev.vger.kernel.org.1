Return-Path: <netdev+bounces-153437-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E199F7F4D
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 17:21:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBB0B1883AB5
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 16:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98B04225A3B;
	Thu, 19 Dec 2024 16:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="uFUwm9Rh"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C6813A41F;
	Thu, 19 Dec 2024 16:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734625304; cv=none; b=a02FfJFymKRw5oJfpV1k7T+GnIuthUfNrDyjyUOD29NwLsraRAeaXM4rwA4JBP0+v4Ss7byfKUQCf+/4KIn8pd56XlWvxTsjLG5tXZrYi35zkbYE/fIB0x1ujeyGg8mg29Og6TbyYAjSVenaGh64rPaj6ref9tiPwC9zX/dU/9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734625304; c=relaxed/simple;
	bh=21pw50cABSPIjkxYzrStjZ2zAXUQuSgGNU8WTWspeMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mRGT/jUFp4WxOmwCC/8cEnqjn3p5QfKkOAtEyrvnmD2YK0+/pSMjM5WCSRCb9iqMJlcglyai2hR3GpHdBHJmGWBJOYaRjG3z5pnhQlPyTQ6Nm2QwbqvzHGESFNcf0l9P4/X2RyZsZJowcBnN9jVcmieYfS9XFcZ4bS5c33wlo50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=uFUwm9Rh; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=prJWGWFgigpl0wvU6VIUlHan1ImAof94g3RTtBeB23o=; b=uFUwm9RhlFvZNe4fzUPnQ2wrPt
	pD4Edk5BradP/HvdBhpMgZmukaMxQ3Toc4V+J+8KDWZ5h5+KRGEBbuqiKUsvtQUVi2wnurQCjlXBM
	4RXzuapOkqFWd/O+4NkR/D05FCsQk/HafM5XlAMKj7rmcOJBqK4KaXMvORYaX3hMeWjs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tOJH5-001g3W-6G; Thu, 19 Dec 2024 17:21:19 +0100
Date: Thu, 19 Dec 2024 17:21:19 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Wei Fang <wei.fang@nxp.com>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	florian.fainelli@broadcom.com, heiko.stuebner@cherry.de,
	frank.li@nxp.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH v5 net] net: phy: micrel: Dynamically control external
 clock of KSZ PHY
Message-ID: <b201355c-0c0f-4146-8574-669e77aabec5@lunn.ch>
References: <20241217063500.1424011-1-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241217063500.1424011-1-wei.fang@nxp.com>

On Tue, Dec 17, 2024 at 02:35:00PM +0800, Wei Fang wrote:
> On the i.MX6ULL-14x14-EVK board, enet1_ref and enet2_ref are used as the
> clock sources for two external KSZ PHYs. However, after closing the two
> FEC ports, the clk_enable_count of the enet1_ref and enet2_ref clocks is
> not 0. The root cause is that since the commit 985329462723 ("net: phy:
> micrel: use devm_clk_get_optional_enabled for the rmii-ref clock"), the
> external clock of KSZ PHY has been enabled when the PHY driver probes,
> and it can only be disabled when the PHY driver is removed. This causes
> the clock to continue working when the system is suspended or the network
> port is down.
> 
> Although Heiko explained in the commit message that the patch was because
> some clock suppliers need to enable the clock to get the valid clock rate
> , it seems that the simple fix is to disable the clock after getting the
> clock rate to solve the current problem. This is indeed true, but we need
> to admit that Heiko's patch has been applied for more than a year, and we
> cannot guarantee whether there are platforms that only enable rmii-ref in
> the KSZ PHY driver during this period. If this is the case, disabling
> rmii-ref will cause RMII on these platforms to not work.
> 
> Secondly, commit 99ac4cbcc2a5 ("net: phy: micrel: allow usage of generic
> ethernet-phy clock") just simply enables the generic clock permanently,
> which seems like the generic clock may only be enabled in the PHY driver.
> If we simply disable the generic clock, RMII may not work. If we keep it
> as it is, the platform using the generic clock will have the same problem
> as the i.MX6ULL platform.
> 
> To solve this problem, the clock is enabled when phy_driver::resume() is
> called, and the clock is disabled when phy_driver::suspend() is called.
> Since phy_driver::resume() and phy_driver::suspend() are not called in
> pairs, an additional clk_enable flag is added. When phy_driver::suspend()
> is called, the clock is disabled only if clk_enable is true. Conversely,
> when phy_driver::resume() is called, the clock is enabled if clk_enable
> is false.
> 
> The changes that introduced the problem were only a few lines, while the
> current fix is about a hundred lines, which seems out of proportion, but
> it is necessary because kszphy_probe() is used by multiple KSZ PHYs and
> we need to fix all of them.
> 
> Fixes: 985329462723 ("net: phy: micrel: use devm_clk_get_optional_enabled for the rmii-ref clock")
> Fixes: 99ac4cbcc2a5 ("net: phy: micrel: allow usage of generic ethernet-phy clock")
> Signed-off-by: Wei Fang <wei.fang@nxp.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

