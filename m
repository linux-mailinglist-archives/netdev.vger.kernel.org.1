Return-Path: <netdev+bounces-238703-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA04C5DEF8
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 16:40:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 7B4C520057
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 15:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5121133375D;
	Fri, 14 Nov 2025 15:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ETeuU1LU"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F20333445
	for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 15:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763134141; cv=none; b=YUdyjuqQaq5J1rpPPQFQNgs8OPyNkCTEilj7C3VdsadfdgI+NMPne6cY4nLGRCvPAsUXqmRHee0f/cAEvDI6jFHZiCWpjynJ3MleKPWPn6BrRJyo9OfMg2T+vzLh33Xwx+h6hi3Sgj1uTxJI5FzaiMzEtJCqXNF5DEuLVx0dbzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763134141; c=relaxed/simple;
	bh=2rvZWh3KmOhKWOY4RmRAOUuDD9FPZgWqsfin3hm5LmE=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=urDtID6bhmqX8QiA4AfLO5ofqQkDiJpbTrO+50haAoDv3kmIQB/7Pen8Ot1HUiaUpSbYGMzW5oYK6ZQcEvplEofe+UGMW2xa/hH2MH1Ckvgik7+kJsbOsUM0nyd+OIdgX9sRhSuxTy44ABem56NM4cQw/rfEfu/BiH56xt1TIFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=ETeuU1LU; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ExveLlApJJDAaJG7whbGiXTjmFQmrgENfuAuZGsWxuQ=; b=ETeuU1LUwtJzk6X3LTgfSrFXMd
	kS0Fuk/qklN9GauJXh/6CdkqV6Bz5xRMdME9ETjTqnwW71vJwNkIEb7jfOoL/RjM+X3FEomYE5iTe
	J70TcFNxTJcK3ErMuTfnch2RyXnDfM4u7/dmq9ENanXe5c2Gr2iEMNkU90/yPJWcUn5ZG79tWyRno
	CJFkg2eqsJq8pmv+4aM9+re2TKvxJEBhczkGacOkqlgnxdfiQHRyIT6gP/vBe68OSa3eekQ+H6bFJ
	8iS/LNTM61hPyc1XiQrnfF3T6oKHoTIGVdcjgelJlXqH/3EURsmvBBg4LgCvSuOI7NVPIwHuCPzow
	iKPsmXNg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:39546 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vJvjG-0000000077f-39KE;
	Fri, 14 Nov 2025 15:28:50 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vJvjF-0000000EVju-3LfS;
	Fri, 14 Nov 2025 15:28:49 +0000
In-Reply-To: <aRdKVMPHXlIn457m@shell.armlinux.org.uk>
References: <aRdKVMPHXlIn457m@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Chen Wang <unicorn_wang@outlook.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	sophgo@lists.linux.dev
Subject: [PATCH net-next 06/11] net: stmmac: move initialisation of
 unicast_filter_entries to stmmac_plat_dat_alloc()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vJvjF-0000000EVju-3LfS@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 14 Nov 2025 15:28:49 +0000

Move the default initialisation of plat_dat->unicast_filter_entries to
1 to stmmac_plat_dat_alloc(). This means platform glue only needs to
override this if different.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c     | 6 ------
 drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c  | 3 ---
 drivers/net/ethernet/stmicro/stmmac/dwmac-sophgo.c    | 1 -
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c     | 2 ++
 drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c      | 6 ------
 drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c | 3 ---
 6 files changed, 2 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
index a4ef3ec070e2..de07cca2e625 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
@@ -570,9 +570,6 @@ static void common_default_data(struct plat_stmmacenet_data *plat)
 
 	plat->mdio_bus_data->needs_reset = true;
 
-	/* Set default value for unicast filter entries */
-	plat->unicast_filter_entries = 1;
-
 	/* Set default number of RX and TX queues to use */
 	plat->tx_queues_to_use = 1;
 	plat->rx_queues_to_use = 1;
@@ -700,9 +697,6 @@ static int intel_mgbe_common_data(struct pci_dev *pdev,
 
 	plat->ptp_clk_freq_config = intel_mgbe_ptp_clk_freq_config;
 
-	/* Set default value for unicast filter entries */
-	plat->unicast_filter_entries = 1;
-
 	plat->flags |= STMMAC_FLAG_VLAN_FAIL_Q_EN;
 
 	/* Use the last Rx queue */
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
index cfdda9e82a19..99b2d2deaceb 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
@@ -98,9 +98,6 @@ static void loongson_default_data(struct pci_dev *pdev,
 	/* Increase the default value for multicast hash bins */
 	plat->multicast_filter_bins = 256;
 
-	/* Set default value for unicast filter entries */
-	plat->unicast_filter_entries = 1;
-
 	/* Disable Priority config by default */
 	plat->tx_queues_cfg[0].use_prio = false;
 	plat->rx_queues_cfg[0].use_prio = false;
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sophgo.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sophgo.c
index 3b7947a7a7ba..24ce17ea35c4 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sophgo.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sophgo.c
@@ -24,7 +24,6 @@ static int sophgo_sg2044_dwmac_init(struct platform_device *pdev,
 	plat_dat->flags |= STMMAC_FLAG_SPH_DISABLE;
 	plat_dat->set_clk_tx_rate = stmmac_set_clk_tx_rate;
 	plat_dat->multicast_filter_bins = 0;
-	plat_dat->unicast_filter_entries = 1;
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index a7393a3e792f..1d12835d14ce 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -7568,11 +7568,13 @@ struct plat_stmmacenet_data *stmmac_plat_dat_alloc(struct device *dev)
 	 * - determine GMII_Address CR field from CSR clock
 	 * - allow MTU up to JUMBO_LEN
 	 * - hash table size
+	 * - one unicast filter entry
 	 */
 	plat_dat->phy_addr = -1;
 	plat_dat->clk_csr = -1;
 	plat_dat->maxmtu = JUMBO_LEN;
 	plat_dat->multicast_filter_bins = HASH_TABLE_SIZE;
+	plat_dat->unicast_filter_entries = 1;
 
 	return plat_dat;
 }
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
index 0c65b24480ae..aea615e76dac 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
@@ -28,9 +28,6 @@ static void common_default_data(struct plat_stmmacenet_data *plat)
 
 	plat->mdio_bus_data->needs_reset = true;
 
-	/* Set default value for unicast filter entries */
-	plat->unicast_filter_entries = 1;
-
 	/* Set default number of RX and TX queues to use */
 	plat->tx_queues_to_use = 1;
 	plat->rx_queues_to_use = 1;
@@ -75,9 +72,6 @@ static int snps_gmac5_default_data(struct pci_dev *pdev,
 	plat->flags |= STMMAC_FLAG_TSO_EN;
 	plat->pmt = 1;
 
-	/* Set default value for unicast filter entries */
-	plat->unicast_filter_entries = 1;
-
 	/* Set default number of RX and TX queues to use */
 	plat->tx_queues_to_use = 4;
 	plat->rx_queues_to_use = 4;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index 9982aaa19519..314cb3e720fd 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -508,9 +508,6 @@ stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac)
 		plat->flags |= STMMAC_FLAG_EN_TX_LPI_CLOCKGATING;
 	}
 
-	/* Set default value for unicast filter entries */
-	plat->unicast_filter_entries = 1;
-
 	/*
 	 * Currently only the properties needed on SPEAr600
 	 * are provided. All other properties should be added
-- 
2.47.3


