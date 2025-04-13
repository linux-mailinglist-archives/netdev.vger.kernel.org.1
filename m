Return-Path: <netdev+bounces-181988-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9567AA87400
	for <lists+netdev@lfdr.de>; Sun, 13 Apr 2025 23:11:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B96B3ABF9E
	for <lists+netdev@lfdr.de>; Sun, 13 Apr 2025 21:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A8CC1F3FC8;
	Sun, 13 Apr 2025 21:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="HtE2hq4w"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC70C12B94;
	Sun, 13 Apr 2025 21:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744578662; cv=none; b=t8qQ53MALKKTqHwHp0xzT5EbPi/HZyOzWGsmrOGuE/wVaJU3WVSjV/7tN0Fz54vVZKCkg0TzhsopNCFwPOJbw7KOYNsT0415+4PQucTPNlIBmqBAqtyhuX5e8bGFBg7/4JaESI/HZrVDfFBg10LeMwb970ZCvBqrApCb/WKHwro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744578662; c=relaxed/simple;
	bh=s71rSJTh6/fuLKrk6Z86CCnI8BfIN3Ohn2A0M9DWY7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p5jpGriNQaXSZdErc/u9tSNbFgjIG0OPN/folgPtbWQ9ti1GgOv3lyaLYuBBL41Aky3W6S5IFRXufyK0Af9WFNHmNU10jQ6N3wPp5uJQ2XkYfQuzupr0660dw0VKvqXPf9rUYWo+wa95cLYTi5OwC6NI1/GWc6Rb181HPp/xZFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=HtE2hq4w; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=4kXxKWG4xnX5hbgFzNzMCOzAiI2t1KSHm3OrucboMKI=; b=HtE2hq4wUD8Cedqn/0watg9XD0
	m1hv00N5hhgIS9i6yL0CBPklVuO7PalWSplRcwQflKmyTsRm51/IWjXFHx+YhDumsFwuhtbVNuK5a
	o7ixMxuvACbi9qMjLyjJ3GAWjj+GfLUzU8j5ZfPjDFdORhK87cRfxpZhMJqKrYvHwoFE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u44bP-0096PC-M0; Sun, 13 Apr 2025 23:10:55 +0200
Date: Sun, 13 Apr 2025 23:10:55 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Fabio Estevam <festevam@gmail.com>, imx@lists.linux.dev,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH net-next] net: stmmac: imx: use stmmac_pltfr_probe()
Message-ID: <e4688664-7ebe-41a8-937b-5a308123fb39@lunn.ch>
References: <E1u3bfm-000Enq-MC@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1u3bfm-000Enq-MC@rmk-PC.armlinux.org.uk>

On Sat, Apr 12, 2025 at 03:17:30PM +0100, Russell King (Oracle) wrote:
> Using stmmac_pltfr_probe() simplifies the probe function. This will not
> only call plat_dat->init (imx_dwmac_init), but also plat_dat->exit
> (imx_dwmac_exit) appropriately if stmmac_dvr_probe() fails. This
> results in an overall simplification of the glue driver.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

