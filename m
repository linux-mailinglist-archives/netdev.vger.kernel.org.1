Return-Path: <netdev+bounces-155940-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44760A04635
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 17:29:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77C6B165EB2
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 16:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F65C1F427B;
	Tue,  7 Jan 2025 16:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Sionutgc"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20771F543B
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 16:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736267272; cv=none; b=Agy79/aRwK73VFFb3dI3JF3NXTw0urXASULlDe3/vl0Rd/7yyw90QDyJULRMTDEyNwEM79Ie7AwfcRyiPYlXEwVT9EddF2dwkWgdJsYIt4sugrrLx96S0r7QD6r5PYdzuiJBL8ojqpayplfvph64xTVemBgilxt6hp++0g2Wym8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736267272; c=relaxed/simple;
	bh=YoYXD02YX4yWFNJajkmzkgjL7Jy+F0+0VvGdXsxg7Ug=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZiHjZ6Dsro4XfhK9EAyx8nAj+rQPbOzpYZyejteWqyCl+nMO+79HuZhJFm9lu8p7oHppL2jsHV+z8ebYr/4sRhzNhydtmjXRpE7cx8OvKcXmUgsAE+4qTyNZ4HCgM5ehtgoKf6zWADcHs6wHCFkg3TlbbZcdV7zhfXdssxbH6jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Sionutgc; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=LCQNSFiJK1wVazMzeWrjqKUTHSmNi8tCis8dxNj946c=; b=SionutgcYLBpSakb3Cg5cRHkim
	XWOzzJ1X3g+pMun4svccxMgbPUUkorGKVwtWDx62uhyEMGseNEgrbmkTtbBYXo5uxqnLGanB33K3Q
	hgEmFJRIsqoIB3iXFpAviFuVJjABuwKqEqAAV+z6yIS7/VovlKMaIUaqoM7pZLq51pAwKaUsv0MBk
	dAo7uosD1hzkLoHkazEkENKbbGWxgkJyAazi2pZ5EFE+aOc96t4SRZPZM806USn7Cz/TW4nKIxamj
	Xpq2R2tA2yDHAPs35ro+jzkbz9XqhCVtLM7LtKNRcapunTPEAyh/30oTzidagYKHMspgNPYgiZMH7
	uEcBsfVw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:48338)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tVCQa-0007kS-1Y;
	Tue, 07 Jan 2025 16:27:36 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tVCQW-0005Qn-19;
	Tue, 07 Jan 2025 16:27:32 +0000
Date: Tue, 7 Jan 2025 16:27:32 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Jose Abreu <joabreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v3 00/18] net: stmmac: clean up and fix EEE
 implementation
Message-ID: <Z31V9O8SATRbu2L3@shell.armlinux.org.uk>
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

This is a rework of stmmac's EEE support in light of the addition of EEE
management to phylib. It's slightly more than 15 patches, but I think it
makes sense to be so.

Patch 1 adds configuration of the receive clock phy_eee_rx_clock_stop()
(which was part of another series, but is necessary for this patch set.)

Patch 2 converts stmmac to use phylib's tracking of tx_lpi_timer.

Patch 3 corrects the data type used for things involving the LPI
timer. The user API uses u32, so stmmac should do too, rather than
blindly converting it to "int". eee_timer is left for patch 4.

Patch 4 (new) uses an unsigned int for eee_timer.

Patch 5 makes stmmac EEE state depend on phylib's enable_tx_lpi flag,
thus using phylib's resolution of EEE state.

Patch 6 removes redundant code from the ethtool EEE operations.

Patch 7 removes some redundant code in stmmac_disable_eee_mode()
and renames it to stmmac_disable_sw_eee_mode() to better reflect its
purpose.

Patch 8 removes the driver private tx_lpi_enabled, which is managed by
phylib since patch 4.

Patch 9 removes the dependence of EEE error statistics on the EEE
enable state, instead depending on whether EEE is supported by the
hardware.

Patch 10 removes phy_init_eee(), instead using phy_eee_rx_clock_stop()
to configure whether the PHY may stop the receive clock.

Patch 11 removes priv->eee_tw_timer, which is only ever set to one
value at probe time, effectively it is a constant. Hence this is
unnecessary complexity.

Patch 12 moves priv->eee_enabled into stmmac_eee_init(), and placing
it under the protection of priv->lock, except when EEE is not
supported (where it becomes constant-false.)

Patch 13 moves priv->eee_active also into stmmac_eee_init(), so
the indication whether EEE should be enabled or not is passed in
to this function.

Since both priv->eee_enabled and priv->eee_active are assigned
true/false values, they should be typed "bool". Make it sew in
patch 14. No Singer machine required.

Patch 15 moves the initialisation of priv->eee_ctrl_timer to the
probe function - it makes no sense to re-initialise the timer each
time we want to start using it.

Patch 16 removes the unnecessary EEE handling in the driver tear-down
method. The core net code will have brought the interface down
already, meaning EEE has already been disabled.

Patch 17 reorganises the code to split the hardware LPI timer
control paths from the software LPI timer paths.

Patch 18 works on this further by eliminating
stmmac_lpi_entry_timer_config() and making direct calls to the new
functions. This reveals a potential bug where priv->eee_sw_timer_en
is set true when EEE is disabled. This is not addressed in this
series, but will be in a future separate patch - so that if fixing
that causes a regression, it can be handled separately.

 drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c  |   4 +-
 drivers/net/ethernet/stmicro/stmmac/hwif.h         |   2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac.h       |  10 +-
 .../net/ethernet/stmicro/stmmac/stmmac_ethtool.c   |  25 +----
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  | 103 +++++++++++----------
 drivers/net/phy/phy.c                              |  27 +++++-
 include/linux/phy.h                                |   1 +
 7 files changed, 85 insertions(+), 87 deletions(-)

Changes in v3:
- fix kerneldoc issue in old patch 12.
- add Andrew's r-bs.
- split eee_timer from other u32 conversions, remove check for
  negative eee_timer.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

