Return-Path: <netdev+bounces-183848-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F2A0A92393
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 19:13:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE4B85A0B04
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 17:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D31F2550C1;
	Thu, 17 Apr 2025 17:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="izM0g8vS"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A632550BE
	for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 17:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744910023; cv=none; b=E29WlqvSFgLjK7Wamu1XrCJ/N4M/GfyEu0dzOoLZrZk11oprqkW4224AX/o4SkoyUct7u8bFJSZ7TYaqsvFZ6YdGxj04G0FIMpLRFLZC98gc3yj829czNlIliqm3NzG3U3HALl8HnO35I1NQazR+dvrWc9nIhYWFJFI9y+s9xyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744910023; c=relaxed/simple;
	bh=lLuzZX/CR56JP6azMX5v/fvk9GImkrBN4Ppj+Ro31OY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=SZtZt6lAV7knoF4e7SvUfhMug19cy60rgYIFxAhQkrNWyHqo1aIFcCT2r5aLM2+bsgXeM1e/J6jMlkHQDbb70hvWBqsmwlQSkdtNhb7B0Ln8lIqnWsQZ+vNvxb3GuLRXQB3umNPyGVqqoJjvIXYEBH0FdyseggYZ6ykumIsK7ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=izM0g8vS; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ZomCEYUh4rjq0ptDxJtUhMsfqwCF7A2KJ07pH99EdY0=; b=izM0g8vSWwufEyG5SWarbIebxk
	I/OVmx9UlBhZSqaYFVpr75u5SHUBGxBLliZuDD9PrCmsxFG92vJdIGxm1lAqnGQk17FSvtb9VuZBt
	bSZgaTA66Zy8ctTAP6x/PJnquXVznkP1t38RN5Uz9HeE/llCGzoPoNU5O7+Ns0ysHJO2Ts/+biYRc
	C2E9D5w0+SwC507xnfCM77aSmPnDTAZu4ZBWL16XCAfQ2ME1kANgnBr2/ok+BMX8XLA22dzP9rFwy
	iQiKW8o6MM7Lr+SX0WQ+UVwg+cCn2jV+zNmtvs4JNwkGhTlNRiUQKdm35K7h33Q40xPyEyvK+cW1K
	K1KabXbw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:48948)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1u5Sno-0007g2-2q;
	Thu, 17 Apr 2025 18:13:28 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1u5Snk-0002cd-1C;
	Thu, 17 Apr 2025 18:13:24 +0100
Date: Thu, 17 Apr 2025 18:13:24 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: [PATCH net-next v3 0/5] net: stmmac: socfpga: fix init ordering and
 cleanups
Message-ID: <aAE2tKlImhwKySq_@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

Hi,

This series fixes the init ordering of the socfpga probe function.
The standard rule is to do all setup before publishing any device,
and socfpga violates that. I can see no reason for this, but these
patches have not been tested on hardware.

Address this by moving the initialisation of dwmac->stmmac_rst
along with all the other dwmac initialisers - there's no reason
for this to be late as plat_dat->stmmac_rst has already been
populated.

Next, replace the call to ops->set_phy_mode() with an init function
socfpga_dwmac_init() which will then be linked in to plat_dat->init.

Then, add this to plat_dat->init, and switch to stmmac_pltfr_pm_ops
from the private ops. The runtime suspend/resume socfpga implementations
are identical to the platform ones, but misses the noirq versions
which this will add.

Before we swap the order of socfpga_dwmac_init() and
stmmac_dvr_probe(), we need to change the way the interface is
obtained, as that uses driver data and the struct net_device which
haven't been initialised. Save a pointer to plat_dat in the socfpga
private data, and use that to get the interface mode. We can then swap
the order of the init and probe functions.

Finally, convert to devm_stmmac_pltfr_probe() by moving the call
to ops->set_phy_mode() into an init function appropriately populating
plat_dat->init.

v2: fix oops when calling set_phy_mode() early.
v3: fix unused variable warnings in patch 2, add Maxime's r-b and t-b
    to all but patch 2.

 .../net/ethernet/stmicro/stmmac/dwmac-socfpga.c    | 79 +++++-----------------
 1 file changed, 16 insertions(+), 63 deletions(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

