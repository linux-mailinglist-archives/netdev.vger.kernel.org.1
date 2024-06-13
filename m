Return-Path: <netdev+bounces-103164-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9536906A22
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 12:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 980D51F21279
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 10:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7880142635;
	Thu, 13 Jun 2024 10:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="sz32prVv"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8D125632
	for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 10:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718274983; cv=none; b=uFdEOg5H9Kh5dumoTSg4jEYUF5HkUgGN8jukjGVBf3D8gBtPSpxt06tSrAXx0tmw/NaTJyQiLXkFfezkkqZGk6tnl5kCswHUtdTklICpUiOV7xPImS7hXTfLPv/FYeLeOURmiyJ7S6nIzgZzzvkNDmfxSyLoboFbNVqcDmgXjfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718274983; c=relaxed/simple;
	bh=j9qr73swBf2H2oNQiorKm7dQB5c2CSnfNCVdb8FPPe4=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=p9uSu52OuTQTGt8RvNKqXfoC9XuH98kF3sl0NKwDjp1CnyqTksIXeZyojzlBVVB+U4UWky5f0q4QHvyPPGkzHQubILBU47fr5+G1p4rMoGAxqau+GIiwiB8KRJ+4cgVub+hVmxohno3E2YWW93z+/SBMWqBbl6Zk7y/0Q2QbWnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=sz32prVv; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=8L8QyfpuiZFMdW6OsHVgqikLpYCiyZtYL1ehm4gdEmI=; b=sz32prVvSD34cRh7bwcK2e9SyK
	0i766/63Hfr7jJgSYIQzI44lC3zynCAVQA0rg9UKTcel7wjjoyxpD2BVjV/2YglvZYvcEnmuk+nAp
	FUmc+hsx4FKIkzBQ+DMTGcpj9ryEIzwZAY+L0X96Vx8XiymzFBsA1GDF24daP0WaQnATglkz21CFI
	VoNJdgTJwQC0qqbRQ358Z9kVS6l4A9OJ91VNR4OvBkThrBiVUvSzBdKUb76u6U127+YoBJB6Ttuwt
	Z6h3/DoEeB/6mnoL66BonPkRFZK8S+iZSPOVN2GMYhzAUzyBwjutVaJ0apuKPAo1caR8T9vWXdHX7
	aFKq6YJw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:39576 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1sHhoO-00065R-0y;
	Thu, 13 Jun 2024 11:36:08 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1sHhoR-00FetB-CP; Thu, 13 Jun 2024 11:36:11 +0100
In-Reply-To: <ZmrLbdwv6ALoy+gs@shell.armlinux.org.uk>
References: <ZmrLbdwv6ALoy+gs@shell.armlinux.org.uk>
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
Subject: [PATCH net-next v2 2/5] net: stmmac: dwmac-intel: provide a
 select_pcs() implementation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1sHhoR-00FetB-CP@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 13 Jun 2024 11:36:11 +0100

Move the code returning the XPCS into dwmac-intel, which is the only
user of XPCS. Fill in the select_pcs() implementation only when we are
going to setup the XPCS, thus when it should be present.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c | 11 +++++++++++
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c |  3 ---
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
index 56649edb18cd..094d34c4193c 100644
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
+		plat->select_pcs = intel_mgbe_select_pcs;
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


