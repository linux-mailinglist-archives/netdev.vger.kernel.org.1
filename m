Return-Path: <netdev+bounces-161373-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C23EA20D86
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 16:48:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C36CE188A6A0
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 15:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B0B51D61A4;
	Tue, 28 Jan 2025 15:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="PveBDKny"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609301D63CC
	for <netdev@vger.kernel.org>; Tue, 28 Jan 2025 15:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738079290; cv=none; b=Y7gZO+U1SEDOY+KQsCHNyltwAGvFVrY/IDffYjwa74hSohxeE0qAJO5Ur03TQgD5a4T39Ekzy4GpiIdzIYkmd9hlVwRt8W43IslZRtEjG3vdiqdK9Ozqj8QfE4kQNVg5nTBx7oDCGn2RcpVo2lhMRN2IV4I9BQohFWKtlq82Qp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738079290; c=relaxed/simple;
	bh=YV5l/XFy8YdmRfdAARdyuGsLA+oCwXvTW+hHMjbJa0I=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=bqle1HF0prgxLHRD5z3aFQ8gv3HVbEZzdqYmRwV3AhMwuVjln1+vg086JJ4zvjWuMmbD8SmxqeoIVYCPyuhqXdX8Txp/FgMjJ0vYpMJq1I6Qdya6jTgjNF6RqY/8mJUEOkN04uc6dimDO2G6hZUcz9/eFAQ2k7weHltUuPVUyN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=PveBDKny; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=1YBzEe/H5RKJuBk5a2TLtgHkf+Agl63gaQLV5BGeS+8=; b=PveBDKnyRgwX82zNa1Bm9Sze2y
	xgdOTr4+AFMJIhlSAFxuiYTFflxSOqZ0o0SEq9qj+oW2SgTxfyTOwgS+RMGuXJlFYUHaqI8fXJfpT
	d6eU163c4v8CI4rDV6Yt0j/20vsavHjv93m82LVAjKyJiKlDtFhiAzZYARAO0lZp8oACcvQh+tJbU
	djCIh3Q7eH/9gFMlp8fwxnEbDu3C6F1NlNJj0bELkPexYOuMw9Qnyj0wu9KIFWeMuKqPwhDj6FLCL
	I/Zk9oAiyWmdWRdm/NN+kjEMTFx1p0+swRroBPLHvfO+QuQaia2uUQCLF6qfeVNjeii6tMN+gyFDJ
	Be9Lnk8w==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:42478 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tcnom-0007Vc-1f;
	Tue, 28 Jan 2025 15:48:00 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tcnoT-0037H8-5s; Tue, 28 Jan 2025 15:47:41 +0000
In-Reply-To: <Z5j7yCYSsQ7beznD@shell.armlinux.org.uk>
References: <Z5j7yCYSsQ7beznD@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	 Vladimir Oltean <olteanv@gmail.com>,
	 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH RFC net-next 11/22] net: stmmac: add new MAC method
 set_lpi_mode()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tcnoT-0037H8-5s@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 28 Jan 2025 15:47:41 +0000

Add a new method to control LPI mode configuration. This is architected
to have three configuration states: LPI disabled, LPI forced (active),
or LPI under hardware timer control. This reflects the three modes
which the main body of the driver wishes to deal with.

We pass in whether transmit clock gating should be used, and the
hardware timer value in microseconds to be set when using hardware
timer control.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../ethernet/stmicro/stmmac/dwmac1000_core.c  | 33 ++++----
 .../net/ethernet/stmicro/stmmac/dwmac4_core.c | 83 +++++++++++--------
 .../ethernet/stmicro/stmmac/dwxgmac2_core.c   | 36 +++++---
 drivers/net/ethernet/stmicro/stmmac/hwif.h    | 11 +++
 4 files changed, 102 insertions(+), 61 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
index 96bcda0856ec..622f5ef241d4 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
@@ -342,31 +342,35 @@ static int dwmac1000_irq_status(struct mac_device_info *hw,
 	return ret;
 }
 
-static void dwmac1000_set_eee_mode(struct mac_device_info *hw,
-				   bool en_tx_lpi_clockgating)
+static int dwmac1000_set_lpi_mode(struct mac_device_info *hw,
+				  enum stmmac_lpi_mode mode,
+				  bool en_tx_lpi_clockgating, u32 et)
 {
 	void __iomem *ioaddr = hw->pcsr;
 	u32 value;
 
-	/*TODO - en_tx_lpi_clockgating treatment */
+	if (mode == STMMAC_LPI_TIMER)
+		return -EOPNOTSUPP;
 
-	/* Enable the link status receive on RGMII, SGMII ore SMII
-	 * receive path and instruct the transmit to enter in LPI
-	 * state.
-	 */
 	value = readl(ioaddr + LPI_CTRL_STATUS);
-	value |= LPI_CTRL_STATUS_LPIEN | LPI_CTRL_STATUS_LPITXA;
+	if (mode == STMMAC_LPI_FORCED)
+		value |= LPI_CTRL_STATUS_LPIEN | LPI_CTRL_STATUS_LPITXA;
+	else
+		value &= ~(LPI_CTRL_STATUS_LPIEN | LPI_CTRL_STATUS_LPITXA);
 	writel(value, ioaddr + LPI_CTRL_STATUS);
+
+	return 0;
 }
 
-static void dwmac1000_reset_eee_mode(struct mac_device_info *hw)
+static void dwmac1000_set_eee_mode(struct mac_device_info *hw,
+				   bool en_tx_lpi_clockgating)
 {
-	void __iomem *ioaddr = hw->pcsr;
-	u32 value;
+	dwmac1000_set_lpi_mode(hw, STMMAC_LPI_FORCED, en_tx_lpi_clockgating, 0);
+}
 
-	value = readl(ioaddr + LPI_CTRL_STATUS);
-	value &= ~(LPI_CTRL_STATUS_LPIEN | LPI_CTRL_STATUS_LPITXA);
-	writel(value, ioaddr + LPI_CTRL_STATUS);
+static void dwmac1000_reset_eee_mode(struct mac_device_info *hw)
+{
+	dwmac1000_set_lpi_mode(hw, STMMAC_LPI_DISABLE, false, 0);
 }
 
 static void dwmac1000_set_eee_pls(struct mac_device_info *hw, int link)
@@ -509,6 +513,7 @@ const struct stmmac_ops dwmac1000_ops = {
 	.pmt = dwmac1000_pmt,
 	.set_umac_addr = dwmac1000_set_umac_addr,
 	.get_umac_addr = dwmac1000_get_umac_addr,
+	.set_lpi_mode = dwmac1000_set_lpi_mode,
 	.set_eee_mode = dwmac1000_set_eee_mode,
 	.reset_eee_mode = dwmac1000_reset_eee_mode,
 	.set_eee_timer = dwmac1000_set_eee_timer,
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
index c324aaf691e0..dc2d8c096fa3 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
@@ -376,35 +376,61 @@ static void dwmac4_get_umac_addr(struct mac_device_info *hw,
 				   GMAC_ADDR_LOW(reg_n));
 }
 
-static void dwmac4_set_eee_mode(struct mac_device_info *hw,
-				bool en_tx_lpi_clockgating)
+static int dwmac4_set_lpi_mode(struct mac_device_info *hw,
+			       enum stmmac_lpi_mode mode,
+			       bool en_tx_lpi_clockgating, u32 et)
 {
 	void __iomem *ioaddr = hw->pcsr;
-	u32 value;
+	u32 value, mask;
+
+	if (mode == STMMAC_LPI_DISABLE) {
+		value = 0;
+	} else {
+		value = LPI_CTRL_STATUS_LPIEN | LPI_CTRL_STATUS_LPITXA;
+
+		if (mode == STMMAC_LPI_TIMER) {
+			/* Return ERANGE if the timer is larger than the
+			 * register field.
+			 */
+			if (et > STMMAC_ET_MAX)
+				return -ERANGE;
+
+			/* Set the hardware LPI entry timer */
+			writel(et, ioaddr + GMAC4_LPI_ENTRY_TIMER);
+
+			/* Interpret a zero LPI entry timer to mean
+			 * immediate entry into LPI mode.
+			 */
+			if (et)
+				value |= LPI_CTRL_STATUS_LPIATE;
+		}
+
+		if (en_tx_lpi_clockgating)
+			value |= LPI_CTRL_STATUS_LPITCSE;
+	}
+
+	mask = LPI_CTRL_STATUS_LPIATE | LPI_CTRL_STATUS_LPIEN |
+	       LPI_CTRL_STATUS_LPITXA;
+
+	value |= readl(ioaddr + GMAC4_LPI_CTRL_STATUS) & ~mask;
+	writel(value, ioaddr + GMAC4_LPI_CTRL_STATUS);
+
+	return 0;
+}
 
+static void dwmac4_set_eee_mode(struct mac_device_info *hw,
+				bool en_tx_lpi_clockgating)
+{
 	/* Enable the link status receive on RGMII, SGMII ore SMII
 	 * receive path and instruct the transmit to enter in LPI
 	 * state.
 	 */
-	value = readl(ioaddr + GMAC4_LPI_CTRL_STATUS);
-	value &= ~LPI_CTRL_STATUS_LPIATE;
-	value |= LPI_CTRL_STATUS_LPIEN | LPI_CTRL_STATUS_LPITXA;
-
-	if (en_tx_lpi_clockgating)
-		value |= LPI_CTRL_STATUS_LPITCSE;
-
-	writel(value, ioaddr + GMAC4_LPI_CTRL_STATUS);
+	dwmac4_set_lpi_mode(hw, STMMAC_LPI_FORCED, en_tx_lpi_clockgating, 0);
 }
 
 static void dwmac4_reset_eee_mode(struct mac_device_info *hw)
 {
-	void __iomem *ioaddr = hw->pcsr;
-	u32 value;
-
-	value = readl(ioaddr + GMAC4_LPI_CTRL_STATUS);
-	value &= ~(LPI_CTRL_STATUS_LPIATE | LPI_CTRL_STATUS_LPIEN |
-		   LPI_CTRL_STATUS_LPITXA);
-	writel(value, ioaddr + GMAC4_LPI_CTRL_STATUS);
+	dwmac4_set_lpi_mode(hw, STMMAC_LPI_DISABLE, false, 0);
 }
 
 static void dwmac4_set_eee_pls(struct mac_device_info *hw, int link)
@@ -424,23 +450,7 @@ static void dwmac4_set_eee_pls(struct mac_device_info *hw, int link)
 
 static void dwmac4_set_eee_lpi_entry_timer(struct mac_device_info *hw, u32 et)
 {
-	void __iomem *ioaddr = hw->pcsr;
-	u32 value = et & STMMAC_ET_MAX;
-	int regval;
-
-	/* Program LPI entry timer value into register */
-	writel(value, ioaddr + GMAC4_LPI_ENTRY_TIMER);
-
-	/* Enable/disable LPI entry timer */
-	regval = readl(ioaddr + GMAC4_LPI_CTRL_STATUS);
-	regval |= LPI_CTRL_STATUS_LPIEN | LPI_CTRL_STATUS_LPITXA;
-
-	if (et)
-		regval |= LPI_CTRL_STATUS_LPIATE;
-	else
-		regval &= ~LPI_CTRL_STATUS_LPIATE;
-
-	writel(regval, ioaddr + GMAC4_LPI_CTRL_STATUS);
+	dwmac4_set_lpi_mode(hw, STMMAC_LPI_TIMER, false, et & STMMAC_ET_MAX);
 }
 
 static void dwmac4_set_eee_timer(struct mac_device_info *hw, int ls, int tw)
@@ -1203,6 +1213,7 @@ const struct stmmac_ops dwmac4_ops = {
 	.pmt = dwmac4_pmt,
 	.set_umac_addr = dwmac4_set_umac_addr,
 	.get_umac_addr = dwmac4_get_umac_addr,
+	.set_lpi_mode = dwmac4_set_lpi_mode,
 	.set_eee_mode = dwmac4_set_eee_mode,
 	.reset_eee_mode = dwmac4_reset_eee_mode,
 	.set_eee_lpi_entry_timer = dwmac4_set_eee_lpi_entry_timer,
@@ -1247,6 +1258,7 @@ const struct stmmac_ops dwmac410_ops = {
 	.pmt = dwmac4_pmt,
 	.set_umac_addr = dwmac4_set_umac_addr,
 	.get_umac_addr = dwmac4_get_umac_addr,
+	.set_lpi_mode = dwmac4_set_lpi_mode,
 	.set_eee_mode = dwmac4_set_eee_mode,
 	.reset_eee_mode = dwmac4_reset_eee_mode,
 	.set_eee_lpi_entry_timer = dwmac4_set_eee_lpi_entry_timer,
@@ -1293,6 +1305,7 @@ const struct stmmac_ops dwmac510_ops = {
 	.pmt = dwmac4_pmt,
 	.set_umac_addr = dwmac4_set_umac_addr,
 	.get_umac_addr = dwmac4_get_umac_addr,
+	.set_lpi_mode = dwmac4_set_lpi_mode,
 	.set_eee_mode = dwmac4_set_eee_mode,
 	.reset_eee_mode = dwmac4_reset_eee_mode,
 	.set_eee_lpi_entry_timer = dwmac4_set_eee_lpi_entry_timer,
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
index 19cfb1dcb332..51c37a1180ac 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
@@ -425,29 +425,39 @@ static void dwxgmac2_get_umac_addr(struct mac_device_info *hw,
 	addr[5] = (hi_addr >> 8) & 0xff;
 }
 
-static void dwxgmac2_set_eee_mode(struct mac_device_info *hw,
-				  bool en_tx_lpi_clockgating)
+static int dwxgmac2_set_lpi_mode(struct mac_device_info *hw,
+				 enum stmmac_lpi_mode mode,
+				 bool en_tx_lpi_clockgating, u32 et)
 {
 	void __iomem *ioaddr = hw->pcsr;
 	u32 value;
 
+	if (mode == STMMAC_LPI_TIMER)
+		return -EOPNOTSUPP;
+
 	value = readl(ioaddr + XGMAC_LPI_CTRL);
+	if (mode == STMMAC_LPI_FORCED) {
+		value |= LPI_CTRL_STATUS_LPIEN | LPI_CTRL_STATUS_LPITXA;
+		if (en_tx_lpi_clockgating)
+			value |= LPI_CTRL_STATUS_LPITCSE;
+	} else {
+		value &= ~(LPI_CTRL_STATUS_LPIEN | LPI_CTRL_STATUS_LPITXA |
+			   LPI_CTRL_STATUS_LPITCSE);
+	}
+	writel(value, ioaddr + XGMAC_LPI_CTRL);
 
-	value |= LPI_CTRL_STATUS_LPIEN | LPI_CTRL_STATUS_LPITXA;
-	if (en_tx_lpi_clockgating)
-		value |= LPI_CTRL_STATUS_LPITCSE;
+	return 0;
+}
 
-	writel(value, ioaddr + XGMAC_LPI_CTRL);
+static void dwxgmac2_set_eee_mode(struct mac_device_info *hw,
+				  bool en_tx_lpi_clockgating)
+{
+	dwxgmac2_set_lpi_mode(hw, STMMAC_LPI_FORCED, en_tx_lpi_clockgating, 0);
 }
 
 static void dwxgmac2_reset_eee_mode(struct mac_device_info *hw)
 {
-	void __iomem *ioaddr = hw->pcsr;
-	u32 value;
-
-	value = readl(ioaddr + XGMAC_LPI_CTRL);
-	value &= ~(LPI_CTRL_STATUS_LPIEN | LPI_CTRL_STATUS_LPITXA | LPI_CTRL_STATUS_LPITCSE);
-	writel(value, ioaddr + XGMAC_LPI_CTRL);
+	dwxgmac2_set_lpi_mode(hw, STMMAC_LPI_DISABLE, false, 0);
 }
 
 static void dwxgmac2_set_eee_pls(struct mac_device_info *hw, int link)
@@ -1525,6 +1535,7 @@ const struct stmmac_ops dwxgmac210_ops = {
 	.pmt = dwxgmac2_pmt,
 	.set_umac_addr = dwxgmac2_set_umac_addr,
 	.get_umac_addr = dwxgmac2_get_umac_addr,
+	.set_lpi_mode = dwxgmac2_set_lpi_mode,
 	.set_eee_mode = dwxgmac2_set_eee_mode,
 	.reset_eee_mode = dwxgmac2_reset_eee_mode,
 	.set_eee_timer = dwxgmac2_set_eee_timer,
@@ -1582,6 +1593,7 @@ const struct stmmac_ops dwxlgmac2_ops = {
 	.pmt = dwxgmac2_pmt,
 	.set_umac_addr = dwxgmac2_set_umac_addr,
 	.get_umac_addr = dwxgmac2_get_umac_addr,
+	.set_lpi_mode = dwxgmac2_set_lpi_mode,
 	.set_eee_mode = dwxgmac2_set_eee_mode,
 	.reset_eee_mode = dwxgmac2_reset_eee_mode,
 	.set_eee_timer = dwxgmac2_set_eee_timer,
diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/ethernet/stmicro/stmmac/hwif.h
index 0f200b72c225..7279d30d6a8b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
@@ -306,6 +306,12 @@ struct stmmac_pps_cfg;
 struct stmmac_rss;
 struct stmmac_est;
 
+enum stmmac_lpi_mode {
+	STMMAC_LPI_DISABLE,
+	STMMAC_LPI_FORCED,
+	STMMAC_LPI_TIMER,
+};
+
 /* Helpers to program the MAC core */
 struct stmmac_ops {
 	/* MAC core initialization */
@@ -360,6 +366,9 @@ struct stmmac_ops {
 			      unsigned int reg_n);
 	void (*get_umac_addr)(struct mac_device_info *hw, unsigned char *addr,
 			      unsigned int reg_n);
+	int (*set_lpi_mode)(struct mac_device_info *hw,
+			    enum stmmac_lpi_mode mode,
+			    bool en_tx_lpi_clockgating, u32 et);
 	void (*set_eee_mode)(struct mac_device_info *hw,
 			     bool en_tx_lpi_clockgating);
 	void (*reset_eee_mode)(struct mac_device_info *hw);
@@ -467,6 +476,8 @@ struct stmmac_ops {
 	stmmac_do_void_callback(__priv, mac, set_umac_addr, __args)
 #define stmmac_get_umac_addr(__priv, __args...) \
 	stmmac_do_void_callback(__priv, mac, get_umac_addr, __args)
+#define stmmac_set_lpi_mode(__priv, __args...) \
+	stmmac_do_callback(__priv, mac, set_lpi_mode, __args)
 #define stmmac_set_eee_mode(__priv, __args...) \
 	stmmac_do_void_callback(__priv, mac, set_eee_mode, __args)
 #define stmmac_reset_eee_mode(__priv, __args...) \
-- 
2.30.2


