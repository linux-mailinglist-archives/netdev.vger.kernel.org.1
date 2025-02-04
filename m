Return-Path: <netdev+bounces-162402-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC6D3A26C07
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 07:13:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 754163A99B0
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 06:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E99EE20370C;
	Tue,  4 Feb 2025 06:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SYDottw4"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C941FC118;
	Tue,  4 Feb 2025 06:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738649526; cv=none; b=TGIWVoc4pq6H0DE0rr562hO11Paj/CQPfmOo5Ig1BXSrFI2vG31U7zJbYPQW8D6BCx3hgGOnodGxx15V1JAlyNktGnDnoNEccmgNtrYOfiZ8tUqfYTjinPCzz35nmH24ce0AAMQhi8ZdpR1W17pet7YXvLbiEack0Q+jyk/GaKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738649526; c=relaxed/simple;
	bh=82UEmrGcqIRTD9c+4ZQMVIZ2fp+t3hC55QdfOJWinGY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HRbQxifIgoyuPP5YxEMX2DYvr2coFC/ubDuXdkVZ0XLY93XPKci+k375uIaky18/5M8QEsJW8DgdZKW/B2k3a94UHCzAAwk5/xfFMX9Hod5Ms0DOCgkaMK1WsKNdBfWMhE/R1TR6vbsR63ke/w9z6ZTqBH/SJI6JlCeKBzc6w/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SYDottw4; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738649525; x=1770185525;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=82UEmrGcqIRTD9c+4ZQMVIZ2fp+t3hC55QdfOJWinGY=;
  b=SYDottw4S+SsHIDYbVEXD24y8RPOJNXZrCZLy6jkBUJ10q0IBAnjtnxY
   1SGMrJ3D2wkqnCrdqR7EJ57tlKyfmduGJRBdh46bxQDaHmoE26Y9V3S7f
   HYNkoeULsE6GWdFVrhHBTUqhSu6V0CV7FVkAHPvI5O2X+vWdZRQUidXMu
   lI1ZWXW2G7qrVAiXuULX3sCOkKRXrC83GuN7cnSNXZMuP0fJIZsIhGf8b
   Sg2mTmTU772hj18JvS6xhJwGcaaDUn/FSpG0psGCiojgvvZbqVmHRE8Ki
   v0tpGTo/KhaU5qlCriIsLATpWe99SCL1FikwIQVYM8sUWua1RDNoKYdOV
   w==;
X-CSE-ConnectionGUID: Z1/10hnzSr6ix+p4A2Oj2w==
X-CSE-MsgGUID: 6S3MDnFcSEGTJqX69pT9cA==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="50579728"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="50579728"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2025 22:12:04 -0800
X-CSE-ConnectionGUID: J0CzH2+rTdKGCS3vuxO4GQ==
X-CSE-MsgGUID: 0KWbPcpmSpSgk9rDWTyr/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; 
   d="scan'208";a="110279224"
Received: from yongliang-ubuntu20-ilbpg12.png.intel.com ([10.88.227.39])
  by orviesa009.jf.intel.com with ESMTP; 03 Feb 2025 22:11:57 -0800
From: Choong Yong Liang <yong.liang.choong@linux.intel.com>
To: Simon Horman <horms@kernel.org>,
	Jose Abreu <joabreu@synopsys.com>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	David E Box <david.e.box@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
	David E Box <david.e.box@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	Mengyuan Lou <mengyuanlou@net-swift.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Andrew Halaney <ahalaney@redhat.com>,
	Serge Semin <fancer.lancer@gmail.com>
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH net-next v6 6/7] stmmac: intel: interface switching support for EHL platform
Date: Tue,  4 Feb 2025 14:10:19 +0800
Message-Id: <20250204061020.1199124-7-yong.liang.choong@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250204061020.1199124-1-yong.liang.choong@linux.intel.com>
References: <20250204061020.1199124-1-yong.liang.choong@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The intel_config_serdes function was provided to handle interface mode
changes for the ADL-N platform.

The Modphy register lane was provided to configure the serdes when
changing interface modes.

Signed-off-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>
---
 .../net/ethernet/stmicro/stmmac/dwmac-intel.c | 19 ++++++++++++++++---
 .../net/ethernet/stmicro/stmmac/dwmac-intel.h |  4 ++++
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
index 347dd75bcdcd..de561a00f902 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
@@ -725,6 +725,8 @@ static int intel_mgbe_common_data(struct pci_dev *pdev,
 static int ehl_common_data(struct pci_dev *pdev,
 			   struct plat_stmmacenet_data *plat)
 {
+	struct intel_priv_data *intel_priv = plat->bsp_priv;
+
 	plat->rx_queues_to_use = 8;
 	plat->tx_queues_to_use = 8;
 	plat->flags |= STMMAC_FLAG_USE_PHY_WOL;
@@ -740,19 +742,24 @@ static int ehl_common_data(struct pci_dev *pdev,
 	plat->safety_feat_cfg->prtyen = 0;
 	plat->safety_feat_cfg->tmouten = 0;
 
+	intel_priv->tsn_lane_registers = ehl_tsn_lane_registers;
+	intel_priv->max_tsn_lane_registers = ARRAY_SIZE(ehl_tsn_lane_registers);
+
 	return intel_mgbe_common_data(pdev, plat);
 }
 
 static int ehl_sgmii_data(struct pci_dev *pdev,
 			  struct plat_stmmacenet_data *plat)
 {
+	struct intel_priv_data *intel_priv = plat->bsp_priv;
+
 	plat->bus_id = 1;
 	plat->phy_interface = PHY_INTERFACE_MODE_SGMII;
-	plat->speed_mode_2500 = intel_speed_mode_2500;
 	plat->serdes_powerup = intel_serdes_powerup;
 	plat->serdes_powerdown = intel_serdes_powerdown;
 	plat->config_serdes = intel_config_serdes;
 	plat->clk_ptp_rate = 204800000;
+	intel_priv->pid_modphy = PID_MODPHY3;
 
 	return ehl_common_data(pdev, plat);
 }
@@ -806,11 +813,14 @@ static struct stmmac_pci_info ehl_pse0_rgmii1g_info = {
 static int ehl_pse0_sgmii1g_data(struct pci_dev *pdev,
 				 struct plat_stmmacenet_data *plat)
 {
+	struct intel_priv_data *intel_priv = plat->bsp_priv;
+
 	plat->phy_interface = PHY_INTERFACE_MODE_SGMII;
-	plat->speed_mode_2500 = intel_speed_mode_2500;
 	plat->serdes_powerup = intel_serdes_powerup;
 	plat->serdes_powerdown = intel_serdes_powerdown;
 	plat->config_serdes = intel_config_serdes;
+	intel_priv->pid_modphy = PID_MODPHY1;
+
 	return ehl_pse0_common_data(pdev, plat);
 }
 
@@ -848,11 +858,14 @@ static struct stmmac_pci_info ehl_pse1_rgmii1g_info = {
 static int ehl_pse1_sgmii1g_data(struct pci_dev *pdev,
 				 struct plat_stmmacenet_data *plat)
 {
+	struct intel_priv_data *intel_priv = plat->bsp_priv;
+
 	plat->phy_interface = PHY_INTERFACE_MODE_SGMII;
-	plat->speed_mode_2500 = intel_speed_mode_2500;
 	plat->serdes_powerup = intel_serdes_powerup;
 	plat->serdes_powerdown = intel_serdes_powerdown;
 	plat->config_serdes = intel_config_serdes;
+	intel_priv->pid_modphy = PID_MODPHY1;
+
 	return ehl_pse1_common_data(pdev, plat);
 }
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.h b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.h
index 79c35ba969ea..093eed977ab0 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.h
@@ -123,6 +123,10 @@ static const struct pmc_serdes_regs pid_modphy1_2p5g_regs[] = {
 	{ PID_MODPHY1_N_MODPHY_PCR_CMN_ANA_DWORD30,	N_MODPHY_PCR_CMN_ANA_DWORD30_2P5G },
 	{}
 };
+
+static const int ehl_tsn_lane_registers[] = {7, 8, 9, 10, 11};
+#else
+static const int ehl_tsn_lane_registers[] = {};
 #endif /* CONFIG_INTEL_PMC_IPC */
 
 #endif /* __DWMAC_INTEL_H__ */
-- 
2.34.1


