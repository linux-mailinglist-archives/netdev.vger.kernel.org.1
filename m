Return-Path: <netdev+bounces-242985-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B85EDC97E7D
	for <lists+netdev@lfdr.de>; Mon, 01 Dec 2025 15:50:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 807E84E1559
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 14:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C109E319847;
	Mon,  1 Dec 2025 14:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="eJa7casI"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4613101A7
	for <netdev@vger.kernel.org>; Mon,  1 Dec 2025 14:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764600617; cv=none; b=RveS1RJvob6lxfoGudTyxUrG3PxzMi7KUvUXyUa5S/YEy9x2dd5e7r7FJniMFz8alpi8tilNwiORWVgrQNSn9dpbd5C7kO38O0d0ntY8qLM+OS9x1LPleiOTsR905huI/g0iUp75VbN8UITWYenFDrytFMyTk+qoCuVBLM8lc8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764600617; c=relaxed/simple;
	bh=gSYzWZL1Dpec+PTYtMmXF0XeGHAbVii+yHESa0jqOX0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=A7ldjhxt75BdE1QiAblSTY5n9Tpl8570V8JzceNwX6fWxrlXECNqEojB5nPmLtSUKKewNi6QRZW3CT0zrSzofLtMjuXIrjFGlaHraEzOsXVopLnsSrU/rzOCsStcqraZiuTtAh3jdSctGl7++DXq46w9PxiDluSjsdD/FpR9Y3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=eJa7casI; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=eU9psOUffFFLH8iXGGNckKFSi0N1lnrRVekGn56l2Oo=; b=eJa7casIJQrMJzBa++zmER07wC
	E2rt0q800czairfx7haxMsd4cNy3BmusqoGQGNs/B5xhYVipNpJvAM+c/FyGH2TMmd6O93JSb+n0C
	VqTmHZoMboC5yxCti8kfhAmm7+Pah6vqDwTvD0zxb+WgBpZHU7su1aOYSmjmbYw+IT+gEDCMAGYWB
	qc3wGqo2wNKSQYMT4mFqsYDTEfmMLOtPeyC7BVx0zmgefyyuzSTSWu9c139/ngksUpnrfwsaJM2NA
	718tAVPDRrh9rNP5/sHAhW/UvK5SEKE+GK9sTmCqwoEyXELA1ceGyPga/roDkXku/hssrxgA5j22T
	ExlEcVZQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:59362)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vQ5E1-000000000ei-0iY7;
	Mon, 01 Dec 2025 14:50:01 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vQ5Dw-000000006Y9-3GUO;
	Mon, 01 Dec 2025 14:49:56 +0000
Date: Mon, 1 Dec 2025 14:49:56 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Heiko Stuebner <heiko@sntech.de>, Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH RFC net-next 00/15] net: stmmac: rk: cleanups galore
Message-ID: <aS2rFBlz1jdwXaS8@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

This is work in progress, cleaning up the excessively large Rockchip
glue driver somewhat. This series as it currently stands removes
approximately 200 lines from this file, while adding slightly to its
flexibility.

A brief overview of the changes:

- similar to previous commits, it seems the RGMII clock field follows
  a common pattern irrespective of the SoC.
- update rk3328 to use the ->id mechanism rather than guessing from
  the PHY interface mode and whether the PHY is integrated.
- switch to wm16 based masking, providing the lower-16 bits of the
  mask to indicate appropriate fields, and use this to construct the
  values to write to the registers.
- convert px30 to these methods.
- since many set_to_rmii() methods are now empty, add flags to indicate
  whether RMII / RGMII are supported.
- clear RGMII where the specific SoC's GMAC instance doesn't support
  this.

I've spent quite a while mulling over how to deal with these "wm16"
registers, none of the kernel bitfield macros (not even the
hw_bitfield.h macros) allow for what I present here, because the
masks are not constant.

One of the interesting things is that this appears to deal with RGMII
delays at the MAC end of the link, but there's no way to tell phylib
that's the case. I've not looked deeply into what is going on there,
but it is surprising that the driver insists that the delays (in
register values?) are provided, but then ignores them depending on the
exact RGMII mode selected.

One outstanding issue with these patches: RK3528_GMAC0_CLK_RMII_DIV2
remains, although I deleted its definition, so there's build errors
in this series. Before I do anything about that, I would like to hear
from the Rockchip guys whether it is necessary for rk3528_set_to_rmii()
to set the clock rate, given that rk_set_clk_tx_rate() will do this
when the link comes up. Does it matter whether it was set to 2.5MHz
(/ 20) or 25MHz (/ 2) when we switch to RMII mode?

 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c | 968 ++++++++++---------------
 1 file changed, 382 insertions(+), 586 deletions(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

