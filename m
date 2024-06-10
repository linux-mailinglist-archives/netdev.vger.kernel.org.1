Return-Path: <netdev+bounces-102300-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6126B90243E
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 16:41:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6E06B26ACB
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 14:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF16D135A65;
	Mon, 10 Jun 2024 14:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="hQj8F7Qp"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DBF132136
	for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 14:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718030451; cv=none; b=emRAMqR+DlfN57Ed1OgwaDEGQ/LeuFQ3KRirZ6+P97RCyO+VVuVU4T/M5WpSSJEQstBxePPX14pKUwLgeIjIKCr1mY21fKGcDeC/3G4jJ2j0lP6XRUDu5oORaGti4Su8yP5VxABTA9QlZqcetOhbPbn4bEgs5wczn8pNdIIjaMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718030451; c=relaxed/simple;
	bh=MernDuDmeDfVXfB8vnQSsWF4P09hNAa8mhbeF8sVQ6Y=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=Bfkc2J7Pb6BmYWs9QEg5QT44tXsenQ5TKOtIGu3PzmBFFFO9tmgfZguJ7yhwD/lXShJ/hcDO4rbUqwQvV8OQdQB0Ym/mNRmGiid14ldUEHlTJP6wavMLA5OlIVfILJ4BfUmuW3wuMA8M8F7nvr7UU76kHIjwW7vsurD8KImFyM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=hQj8F7Qp; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=xeRq82mHAjHz+TfgCyzTrq/v7wA6gPE37LHDzOTm04M=; b=hQj8F7QpXlIC2hk2SZwWlzMQHb
	1trLiljt8U+ZDeqjV0PGQAXE6c1s71qGHhYmWDBlipgeUCXpdxJWlg1Lsi8lUEhHjPR4pMqxAwQOE
	Bi4ALOGFP2P3X3Ef3plVKkyuXLQzD1hVRSL6TgUBIMOm/PNZ5PtJplGKJI/6T8+oMtiVzHnvA7W92
	GX+5J5WvN5/QNwRhzRmKs0c2qyXy3vGWKnangp6G8Tx4e+lEi4q7SBIT/j//5hJ6tN6y0FGcZF0Mx
	ehHLrhzS2M90VaimU1nSxqMlzdMczJz/slXC8DhdOW9h9VkPgkS8GDp8f6GJtRw+WMvb+AixfnTaK
	XZ8Hvomw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:46484 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1sGgCJ-0001ev-36;
	Mon, 10 Jun 2024 15:40:36 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1sGgCN-00Fact-0x; Mon, 10 Jun 2024 15:40:39 +0100
In-Reply-To: <ZmcQTuR5IKRp0pgy@shell.armlinux.org.uk>
References: <ZmcQTuR5IKRp0pgy@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Halaney <ahalaney@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jose Abreu <joabreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Romain Gantois <romain.gantois@bootlin.com>
Subject: [PATCH net-next 2/5] net: stmmac: dwmac-intel: provide a select_pcs()
 implementation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1sGgCN-00Fact-0x@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 10 Jun 2024 15:40:39 +0100

Move the code returning the XPCS into dwmac-intel, which is the only
user of XPCS. Fill in the select_pcs() implementation only when we are
going to setup the XPCS, thus when it should be present.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c | 11 +++++++++++
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c |  3 ---
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
index 56649edb18cd..227e1f6490f8 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
@@ -443,6 +443,16 @@ static void common_default_data(struct plat_stmmacenet_data *plat)
 	plat->rx_queues_cfg[0].pkt_route = 0x0;
 }
 
+static struct phylink_pcs *intel_mgbe_select_pcs(struct stmmac_priv *priv,
+						 phy_interface_t interface)
+{
+	/* plat->mdio_bus_data->has_xpcs has been set true, so there
+	 * should always be an XPCS. The original code would always
+	 * return this if present.
+	 */
+	return &priv->hw->xpcs->pcs;
+}
+
 static int intel_mgbe_common_data(struct pci_dev *pdev,
 				  struct plat_stmmacenet_data *plat)
 {
@@ -587,6 +597,7 @@ static int intel_mgbe_common_data(struct pci_dev *pdev,
 	    plat->phy_interface == PHY_INTERFACE_MODE_1000BASEX) {
 		plat->mdio_bus_data->has_xpcs = true;
 		plat->mdio_bus_data->default_an_inband = true;
+		plat->select_pcs = intel_mgbe_select_pcs,
 	}
 
 	/* Ensure mdio bus scan skips intel serdes and pcs-xpcs */
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 302aa4080de3..e9e2a95c91a3 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -957,9 +957,6 @@ static struct phylink_pcs *stmmac_mac_select_pcs(struct phylink_config *config,
 			return pcs;
 	}
 
-	if (priv->hw->xpcs)
-		return &priv->hw->xpcs->pcs;
-
 	return priv->hw->phylink_pcs;
 }
 
-- 
2.30.2


