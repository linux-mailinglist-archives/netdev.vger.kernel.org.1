Return-Path: <netdev+bounces-241143-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB59C80331
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 12:27:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9239A4E20F7
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 11:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11D8F2F9DA7;
	Mon, 24 Nov 2025 11:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="se+EkqTU"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFCA12F9DA0
	for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 11:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763983668; cv=none; b=JOyceQONvgzHJhbrj06N5wa5j+ib4W+0fm1hpGOdzX4IWSmhEdZXQbGWVXgCxYTsAdvx0cH0OlBh4anTvWhrRpcyRBkkUOA5zYYnS86toAFLyxjqqckLxEzbbCGHN82Uq54dllPbKoO4HUOP3bOhWaov/vFxUIWlpd2LlnEO374=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763983668; c=relaxed/simple;
	bh=DOGoTL1GWbqb7cy43yrCL9GDM8CgOTQxhsCGJpCbjqo=;
	h=From:To:Cc:Subject:MIME-Version:Content-Disposition:Content-Type:
	 Message-Id:Date; b=dbOaA8tOKcRDCb/hjMPKaHsFC4ULi4w8fjpbgoDIWFW27qLC4JwSmnqJk1ylGBGZPYwvZNLJo/detdE75Y/hz3IblYgqYYeoROFFx2zFwMXxcBIcBuFFotDW8EAkYVgAiejRklI239E9I7mBMAJBy8zJWq+vxFTHJ+BuMgCrgKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=se+EkqTU; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=+2VNKYVSBcrc1VyyHdGwlpo/7zwStLekQ2MuxGIm91M=; b=se+EkqTUZ2JsHHqRGkjGWssdU5
	RaNhntOk1D2FYeNNJYJcZ2J5/zJNwCXPgTVT+4AvGdrACkeEyyn0d7AS+9dT5zPRpnaRrwu0WKOSH
	3Meo8EXRvuq+GbE/jIZ7qCWnrf37fK4EhwaKHuX3Kfmv56bYqc/WrTV7sDy/PJELMNQpewOpxZe8s
	CisBjdG07xBhNasTRs3sg/Kv9rfjSNrf9pZtTaXufHx04ERkFjts+BBMp3GZzEFCY2JX1x/N2SsV1
	DP2UvVKlAlCB7SD0BA0fYxYrcUuA9AUGTxdAAxU13Y9BVrHvSn/0GikJfM0lj1zvGjhleXKbVdseI
	I5asktsg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:49258 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vNUjD-000000001e9-0FhO;
	Mon, 24 Nov 2025 11:27:31 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vNUjC-0000000FhjR-0h6P;
	Mon, 24 Nov 2025 11:27:30 +0000
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Daniel Scally <dan.scally@ideasonboard.com>,
	"David S. Miller" <davem@davemloft.net>,
	Emanuele Ghidoli <ghidoliemanuele@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Fabio Estevam <festevam@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	<imx@lists.linux.dev>,
	Jakub Kicinski <kuba@kernel.org>,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	<linux-arm-kernel@lists.infradead.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Paolo Abeni <pabeni@redhat.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Stefan Klug <stefan.klug@ideasonboard.com>,
	Wei Fang <wei.fang@nxp.com>
Subject: [PATCH RFC net-next] net: stmmac: provide flag to disable EEE
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vNUjC-0000000FhjR-0h6P@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 24 Nov 2025 11:27:30 +0000

Some platforms have problems when EEE is enabled, and thus need a way
to disable stmmac EEE support. Add a flag before the other LPI related
flags which tells stmmac to avoid populating the phylink LPI
capabilities, which causes phylink to call phy_disable_eee() for any
PHY that is attached to the affected phylink instance.

iMX8MP is an example - the lpi_intr_o signal is wired to an OR gate
along with the main dwmac interrupts. Since lpi_intr_o is synchronous
to the receive clock domain, and takes four clock cycles to clear, this
leads to interrupt storms as the interrupt remains asserted for some
time after the LPI control and status register is read.

This problem becomes worse when the receive clock from the PHY stops
when the receive path enters LPI state - which means that lpi_intr_o
can not deassert until the clock restarts. Since the LPI state of the
receive path depends on the link partner, this is out of our control.
We could disable RX clock stop at the PHY, but that doesn't get around
the slow-to-deassert lpi_intr_o mentioned in the above paragraph.

Previously, iMX8MP worked around this by disabling gigabit EEE, but
this is insufficient - the problem is also visible at 100M speeds,
where the receive clock is slower.

There is extensive discussion and investigation in the thread linked
below, the result of which is summarised in this commit message.

Reported-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Link: https://lore.kernel.org/r/20251026122905.29028-1-laurent.pinchart@ideasonboard.com
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
For Laurent to add to a patch series appropriately adding
STMMAC_FLAG_EEE_DISABLE to dwmac-imx.c

 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 7 ++++++-
 include/linux/stmmac.h                            | 9 +++++----
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 6cacedb2c9b3..ca0eee58a8a8 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -1324,7 +1324,12 @@ static int stmmac_phylink_setup(struct stmmac_priv *priv)
 				 config->supported_interfaces,
 				 pcs->supported_interfaces);
 
-	if (priv->dma_cap.eee) {
+	/* Some platforms, e.g. iMX8MP, wire lpi_intr_o to the same interrupt
+	 * used for stmmac's main interrupts, which leads to interrupt storms.
+	 * STMMAC_FLAG_EEE_DISABLE allows EEE to be disabled on such platforms.
+	 */
+	if (priv->dma_cap.eee &&
+	    !(priv->plat->flags & STMMAC_FLAG_EEE_DISABLE)) {
 		/* Assume all supported interfaces also support LPI */
 		memcpy(config->lpi_interfaces, config->supported_interfaces,
 		       sizeof(config->lpi_interfaces));
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index f1054b9c2d8a..5ed49d5363ee 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -187,10 +187,11 @@ enum dwmac_core_type {
 #define STMMAC_FLAG_MULTI_MSI_EN		BIT(7)
 #define STMMAC_FLAG_EXT_SNAPSHOT_EN		BIT(8)
 #define STMMAC_FLAG_INT_SNAPSHOT_EN		BIT(9)
-#define STMMAC_FLAG_RX_CLK_RUNS_IN_LPI		BIT(10)
-#define STMMAC_FLAG_EN_TX_LPI_CLOCKGATING	BIT(11)
-#define STMMAC_FLAG_EN_TX_LPI_CLK_PHY_CAP	BIT(12)
-#define STMMAC_FLAG_HWTSTAMP_CORRECT_LATENCY	BIT(13)
+#define STMMAC_FLAG_EEE_DISABLE			BIT(10)
+#define STMMAC_FLAG_RX_CLK_RUNS_IN_LPI		BIT(11)
+#define STMMAC_FLAG_EN_TX_LPI_CLOCKGATING	BIT(12)
+#define STMMAC_FLAG_EN_TX_LPI_CLK_PHY_CAP	BIT(13)
+#define STMMAC_FLAG_HWTSTAMP_CORRECT_LATENCY	BIT(14)
 
 struct mac_device_info;
 
-- 
2.47.3


