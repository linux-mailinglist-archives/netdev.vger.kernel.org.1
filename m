Return-Path: <netdev+bounces-239918-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 70CFAC6DF75
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 11:25:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C37B5384771
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 10:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24EA434C988;
	Wed, 19 Nov 2025 10:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="a4hoDT8d"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FFA134BA57
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 10:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763547834; cv=none; b=maOZRNV5bBSEmR3Q1XzvwfOAPhz/yCszS0sSiNasPkcy2z8SBj9dgZwnOeMDlEAweWNWQXwljlrdFxrjGGymoOv+cdco8C1/M4yqqktZo4Fiv7PiCmGNWnUt0fBybXBv8rOQ97cnPxNEhqr5TmXsV44pRNkXeU16mwKp2yRLLZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763547834; c=relaxed/simple;
	bh=OxfdXb9amwxV+ke8YIRtx5R2KNrfQDZJ8P5XztMhif4=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=AhqdbD2hhxhbvtF6Xw5C0wbIifSvfkMdiBeT7tys/qE8NaAaMyyGyLhYqc6MGLJaWwrLVzPfsXBP4t9yf/eNM+31g8tFaBigkBa3laaRwnAROGpxU4yXHqfJt9wilrMCpk5k8p0ulHyCHJyR8czubUvoHJsQkyjC87KVx4sfxhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=a4hoDT8d; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Oc+BTgkWw06Qe/U/Krb8/5WErjmRQg/o4qCGvVNYK7A=; b=a4hoDT8dRM4AfR/LBhnIZEl8qk
	vRiWKtEtNgWJYLhgtXoaCo2X/WymyyJg1w2ryKE0weBsDj455cz4rWeze3xa6z5xJ70meHIocgTrK
	MTJu1F/1nEytjwNBa+rK5nK9Ow+GfcuLHkV7Id6aWotrAP/QndqWVUyALw/13OBCd3OUjdJzZfePW
	Sct2mKF7uJpho2BWd5zyvUhkNXrBcNMUn6bJ8wfXWLOg2GLC7x7wDj7jNXLfYBNl0caDkjQvkRgGy
	aTL86/aUWyqPJPU2Ly9ZDpnR3t5nkcc0Iw5tXOjcgECtM+PQgQNvbEpzPlNWbGW/s4G+ytPafonIa
	IUMhiIMg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:41866 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vLfLi-000000004Vy-0x0m;
	Wed, 19 Nov 2025 10:23:42 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vLfLg-0000000FMbD-1vmh;
	Wed, 19 Nov 2025 10:23:40 +0000
In-Reply-To: <aR2aaDs6rqfu32B-@shell.armlinux.org.uk>
References: <aR2aaDs6rqfu32B-@shell.armlinux.org.uk>
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
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 6/6] net: stmmac: remove axi_blen array
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vLfLg-0000000FMbD-1vmh@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 19 Nov 2025 10:23:40 +0000

Remove the axi_blen array from struct stmmac_axi as we set this array,
and then immediately convert it ot the register value, never looking at
the array again. Thus, the array can be function local rather than part
of a run-time allocated long-lived struct.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c   | 11 ++---------
 drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c     |  3 ---
 drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c      |  4 ----
 drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c |  5 +++--
 include/linux/stmmac.h                                |  1 -
 5 files changed, 5 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
index bd06f26a27b4..d043bad4a862 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
@@ -38,8 +38,6 @@ static int dwc_eth_dwmac_config_dt(struct platform_device *pdev,
 {
 	struct device *dev = &pdev->dev;
 	u32 burst_map = 0;
-	u32 bit_index = 0;
-	u32 a_index = 0;
 
 	if (!plat_dat->axi) {
 		plat_dat->axi = devm_kzalloc(&pdev->dev,
@@ -83,13 +81,8 @@ static int dwc_eth_dwmac_config_dt(struct platform_device *pdev,
 	}
 	device_property_read_u32(dev, "snps,burst-map", &burst_map);
 
-	/* converts burst-map bitmask to burst array */
-	for (bit_index = 0; bit_index < 7; bit_index++)
-		if (burst_map & (1 << bit_index))
-			plat_dat->axi->axi_blen[a_index++] = 4 << bit_index;
-
-	stmmac_axi_blen_to_mask(&plat_dat->axi->axi_blen_regval,
-				plat_dat->axi->axi_blen, a_index);
+	plat_dat->axi->axi_blen_regval = FIELD_PREP(DMA_AXI_BLEN_MASK,
+						    burst_map);
 
 	/* dwc-qos needs GMAC4, AAL, TSO and PMT */
 	plat_dat->core_type = DWMAC_CORE_GMAC4;
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
index e94605d3d185..aad1be1ec4c1 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
@@ -652,9 +652,6 @@ static int intel_mgbe_common_data(struct pci_dev *pdev,
 	plat->axi->axi_rd_osr_lmt = 1;
 	plat->axi->axi_blen_regval = DMA_AXI_BLEN4 | DMA_AXI_BLEN8 |
 				     DMA_AXI_BLEN16;
-	plat->axi->axi_blen[0] = 4;
-	plat->axi->axi_blen[1] = 8;
-	plat->axi->axi_blen[2] = 16;
 
 	plat->ptp_max_adj = plat->clk_ptp_rate;
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
index e1036150fae2..afb1c53ca6f8 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
@@ -94,10 +94,6 @@ static int snps_gmac5_default_data(struct pci_dev *pdev,
 	plat->axi->axi_fb = false;
 	plat->axi->axi_blen_regval = DMA_AXI_BLEN4 | DMA_AXI_BLEN8 |
 				     DMA_AXI_BLEN16 | DMA_AXI_BLEN32;
-	plat->axi->axi_blen[0] = 4;
-	plat->axi->axi_blen[1] = 8;
-	plat->axi->axi_blen[2] = 16;
-	plat->axi->axi_blen[3] = 32;
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index 656d4adedabe..8979a50b5507 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -95,6 +95,7 @@ static struct stmmac_axi *stmmac_axi_setup(struct platform_device *pdev)
 {
 	struct device_node *np;
 	struct stmmac_axi *axi;
+	u32 axi_blen[AXI_BLEN];
 
 	np = of_parse_phandle(pdev->dev.of_node, "snps,axi-config", 0);
 	if (!np)
@@ -117,8 +118,8 @@ static struct stmmac_axi *stmmac_axi_setup(struct platform_device *pdev)
 		axi->axi_wr_osr_lmt = 1;
 	if (of_property_read_u32(np, "snps,rd_osr_lmt", &axi->axi_rd_osr_lmt))
 		axi->axi_rd_osr_lmt = 1;
-	of_property_read_u32_array(np, "snps,blen", axi->axi_blen, AXI_BLEN);
-	stmmac_axi_blen_to_mask(&axi->axi_blen_regval, axi->axi_blen, AXI_BLEN);
+	of_property_read_u32_array(np, "snps,blen", axi_blen, AXI_BLEN);
+	stmmac_axi_blen_to_mask(&axi->axi_blen_regval, axi_blen, AXI_BLEN);
 	of_node_put(np);
 
 	return axi;
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index d1a41fe0825f..f1054b9c2d8a 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -114,7 +114,6 @@ struct stmmac_axi {
 	u32 axi_rd_osr_lmt;
 	bool axi_kbbe;
 	u32 axi_blen_regval;
-	u32 axi_blen[AXI_BLEN];
 	bool axi_fb;
 	bool axi_mb;
 	bool axi_rb;
-- 
2.47.3


