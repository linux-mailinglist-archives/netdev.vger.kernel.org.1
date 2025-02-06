Return-Path: <netdev+bounces-163532-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A6CDA2A9BD
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 14:24:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 112CB3A825E
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 13:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 254C91EA7D2;
	Thu,  6 Feb 2025 13:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hXwaJD83"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71AAA1EA7CC;
	Thu,  6 Feb 2025 13:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738848050; cv=none; b=EkbGrQH+xXAVpQmz1IY512vFtPLePiC0DfmC4Y1nPvqsDdH+PFuj8GmZaHG9kjWPr81y1Aa9EE7TOdsQnOAI/D2fTCol0einoLTNirHj/CgtIH7nU1XiH7XKGVgfuIui2D8Rc8mxFrkjDHnmEHjl8gcCd20jBH1NnXjIOhM8/es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738848050; c=relaxed/simple;
	bh=hZNfIh1pCnyRAcsQliEJA+pncaWJenewXe2nIQHuIhA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kB61h9f+fyeXBwRtwL2SRUZwSmWT641rDx++dXv0yIQalA1XdipqBveFopKQktXvO0JcbJxb3TxkcqsFBi+iks3i4WT+1CcJ8OLhmODI5oMunb5v6YdIKzzQpbdTSG2GSx2QpLGDgtUIvQ9uKABK2k86kcaSSF07bTIUHwdaVKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hXwaJD83; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738848048; x=1770384048;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hZNfIh1pCnyRAcsQliEJA+pncaWJenewXe2nIQHuIhA=;
  b=hXwaJD83tQmZqF6bHfqlAwAAbOMW3PORFsr1zSsEq7DsVRpwex3U/dgN
   joQersN0cmvGarRQbQxrEw+rqkcoyU4DsLthi/6b1I1fg0F6B1PKO8hse
   Gh3N60tvq5wH1yox+CVj7YkeTb9aaMbheOJA1V3hNtfijOmMKLk9iXcRt
   tNAJxlKa/knP4iBPqiv0ThnVN0U3TYH3oHDr3ymsFu9/wV6IccbOCfi9z
   k66xmvJH1vkj3qHpJZqGGG2fquf6L460NbymOhc9YSirMnqXKrbboJDsg
   w10S1sGDUpYAMmCwj0BeItXq6nVFMfqLd6bSTCiFFC3rXLzgXx0Cppuvq
   Q==;
X-CSE-ConnectionGUID: p/64J+iCSASRQOtRAAldVg==
X-CSE-MsgGUID: uOJJWl3URHGnKxlzxHB9OQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="43203801"
X-IronPort-AV: E=Sophos;i="6.13,264,1732608000"; 
   d="scan'208";a="43203801"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2025 05:20:48 -0800
X-CSE-ConnectionGUID: iKQkWD4GSdOJb3TBeX4iYQ==
X-CSE-MsgGUID: VBNz5kJIToiPyiPMfyZJmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="116397371"
Received: from yongliang-ubuntu20-ilbpg12.png.intel.com ([10.88.227.39])
  by orviesa005.jf.intel.com with ESMTP; 06 Feb 2025 05:20:40 -0800
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
	Serge Semin <fancer.lancer@gmail.com>
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH net-next v7 6/7] stmmac: intel: interface switching support for EHL platform
Date: Thu,  6 Feb 2025 21:18:58 +0800
Message-Id: <20250206131859.2960543-7-yong.liang.choong@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250206131859.2960543-1-yong.liang.choong@linux.intel.com>
References: <20250206131859.2960543-1-yong.liang.choong@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The intel_config_serdes function was provided to handle interface mode
changes for the EHL platform.

The Modphy register lane was provided to configure the serdes when
changing interface modes.

Signed-off-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>
---
 .../net/ethernet/stmicro/stmmac/dwmac-intel.c | 31 ++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
index 837fd3fbaedb..e7f5d023eaf2 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
@@ -86,6 +86,8 @@ static const struct pmc_serdes_regs pid_modphy1_2p5g_regs[] = {
 	{}
 };
 
+static const int ehl_tsn_lane_regs[] = {7, 8, 9, 10, 11};
+
 static int stmmac_pci_find_phy_addr(struct pci_dev *pdev,
 				    const struct dmi_system_id *dmi_list)
 {
@@ -764,6 +766,8 @@ static int intel_mgbe_common_data(struct pci_dev *pdev,
 static int ehl_common_data(struct pci_dev *pdev,
 			   struct plat_stmmacenet_data *plat)
 {
+	struct intel_priv_data *intel_priv = plat->bsp_priv;
+
 	plat->rx_queues_to_use = 8;
 	plat->tx_queues_to_use = 8;
 	plat->flags |= STMMAC_FLAG_USE_PHY_WOL;
@@ -779,12 +783,17 @@ static int ehl_common_data(struct pci_dev *pdev,
 	plat->safety_feat_cfg->prtyen = 0;
 	plat->safety_feat_cfg->tmouten = 0;
 
+	intel_priv->tsn_lane_regs = ehl_tsn_lane_regs;
+	intel_priv->max_tsn_lane_regs = ARRAY_SIZE(ehl_tsn_lane_regs);
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
 	plat->speed_mode_2500 = intel_speed_mode_2500;
@@ -793,6 +802,11 @@ static int ehl_sgmii_data(struct pci_dev *pdev,
 	plat->mac_finish = intel_mac_finish;
 	plat->clk_ptp_rate = 204800000;
 
+	intel_priv->pid_1g.regs = pid_modphy3_1g_regs;
+	intel_priv->pid_1g.num_regs = ARRAY_SIZE(pid_modphy3_1g_regs);
+	intel_priv->pid_2p5g.regs = pid_modphy3_2p5g_regs;
+	intel_priv->pid_2p5g.num_regs = ARRAY_SIZE(pid_modphy3_2p5g_regs);
+
 	return ehl_common_data(pdev, plat);
 }
 
@@ -845,11 +859,18 @@ static struct stmmac_pci_info ehl_pse0_rgmii1g_info = {
 static int ehl_pse0_sgmii1g_data(struct pci_dev *pdev,
 				 struct plat_stmmacenet_data *plat)
 {
+	struct intel_priv_data *intel_priv = plat->bsp_priv;
+
 	plat->phy_interface = PHY_INTERFACE_MODE_SGMII;
-	plat->speed_mode_2500 = intel_speed_mode_2500;
 	plat->serdes_powerup = intel_serdes_powerup;
 	plat->serdes_powerdown = intel_serdes_powerdown;
 	plat->mac_finish = intel_mac_finish;
+
+	intel_priv->pid_1g.regs = pid_modphy1_1g_regs;
+	intel_priv->pid_1g.num_regs = ARRAY_SIZE(pid_modphy1_1g_regs);
+	intel_priv->pid_2p5g.regs = pid_modphy1_2p5g_regs;
+	intel_priv->pid_2p5g.num_regs = ARRAY_SIZE(pid_modphy1_2p5g_regs);
+
 	return ehl_pse0_common_data(pdev, plat);
 }
 
@@ -887,11 +908,19 @@ static struct stmmac_pci_info ehl_pse1_rgmii1g_info = {
 static int ehl_pse1_sgmii1g_data(struct pci_dev *pdev,
 				 struct plat_stmmacenet_data *plat)
 {
+	struct intel_priv_data *intel_priv = plat->bsp_priv;
+
 	plat->phy_interface = PHY_INTERFACE_MODE_SGMII;
 	plat->speed_mode_2500 = intel_speed_mode_2500;
 	plat->serdes_powerup = intel_serdes_powerup;
 	plat->serdes_powerdown = intel_serdes_powerdown;
 	plat->mac_finish = intel_mac_finish;
+
+	intel_priv->pid_1g.regs = pid_modphy1_1g_regs;
+	intel_priv->pid_1g.num_regs = ARRAY_SIZE(pid_modphy1_1g_regs);
+	intel_priv->pid_2p5g.regs = pid_modphy1_2p5g_regs;
+	intel_priv->pid_2p5g.num_regs = ARRAY_SIZE(pid_modphy1_2p5g_regs);
+
 	return ehl_pse1_common_data(pdev, plat);
 }
 
-- 
2.34.1


