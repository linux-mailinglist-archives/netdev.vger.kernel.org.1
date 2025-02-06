Return-Path: <netdev+bounces-163530-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01275A2A9B5
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 14:23:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D43243AA23F
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 13:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0901E1A315B;
	Thu,  6 Feb 2025 13:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dgF4BqNO"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16ECB1624D4;
	Thu,  6 Feb 2025 13:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738848039; cv=none; b=Vo+AvUHmlvPi3xdwLIxBnjhXvDAycvbdryfOiKn22gZP/3O4+SqAeJdoq/6AFwMuUlkewOePsI5KKZoBxtA2gNVDhOOEuekLW7hwwGaaHBe+vcLYnS0xGmVzedWjyXXt6QjX6n6vyBWgfkeKl/0wN01SE1q4vCxEh7Syi2el9PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738848039; c=relaxed/simple;
	bh=lOxPWBQ/UPAGy6nREPmx7d08BAoMjZkLK0OTKYz+EjQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=StzEUJlqpe/yNIksX2adZyRBaFVxNrIvb8gUJDvm1n7OguwyYUOEJaORxBPhXNjmbUCNz2mf5aevOqwpVTuYCQq3oQo3tJ7AVUxsNbBjYU9vBSacu2ZiVGfK8XLOih0B7eHnixRMzuWG5YmOIogMrjz7letokjKclxD770Ajpow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dgF4BqNO; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738848038; x=1770384038;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lOxPWBQ/UPAGy6nREPmx7d08BAoMjZkLK0OTKYz+EjQ=;
  b=dgF4BqNOV3MD9Hxq/E09RUpBYGsrS5mis8wiuZUMi4Rha/BAAHUW1Q2L
   KS8A47aJYAFuQteTzT3xYpxJaGvNDdLVAdzldKwEa22fGt7XyTzKiuVTZ
   hY7K22r0fn/T/Lh6j763BUJis9e3NCBAq8a8O60RKtTo9ihjUXnFSofE9
   kE0zRTCROD/Gj5yYvzNEet0eNeulbnEseX4LE2rfkXP0a6rCSbRvhfdRI
   SjvbwV7JGnjXnhQEXChKWMR7JHX82LN9FK40M5hfT+gxG6gNUGsXblMBr
   +SlLaL1D5+D3rBGy/8OsJWf+H0rs8XGxDDVfMfFueN0Y0R9NMwAaBQAOO
   g==;
X-CSE-ConnectionGUID: 0TD9eAMeQgGIehEfHZW/FA==
X-CSE-MsgGUID: 2P9bMzsJRhuOrVIK9+wpAQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="43203757"
X-IronPort-AV: E=Sophos;i="6.13,264,1732608000"; 
   d="scan'208";a="43203757"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2025 05:20:29 -0800
X-CSE-ConnectionGUID: 36xqX2d9QOqYVEy7T8O28g==
X-CSE-MsgGUID: puTWITCMSxaQNpTZ6t8aag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="116397326"
Received: from yongliang-ubuntu20-ilbpg12.png.intel.com ([10.88.227.39])
  by orviesa005.jf.intel.com with ESMTP; 06 Feb 2025 05:20:22 -0800
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
Subject: [PATCH net-next v7 4/7] stmmac: intel: configure SerDes according to the interface mode
Date: Thu,  6 Feb 2025 21:18:56 +0800
Message-Id: <20250206131859.2960543-5-yong.liang.choong@linux.intel.com>
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

Intel platform will configure the SerDes through PMC API based on the
provided interface mode.

This patch adds several new functions below:-
- intel_tsn_lane_is_available(): This new function reads FIA lane
  ownership registers and common lane registers through IPC commands
  to know which lane the mGbE port is assigned to.
- intel_mac_finish(): To configure the SerDes based on the assigned
  lane and latest interface mode, it sends IPC command to the PMC through
  PMC driver/API. The PMC acts as a proxy for R/W on behalf of the driver.
- intel_set_reg_access(): Set the register access to the available TSN
  interface.

Signed-off-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>
---
 drivers/net/ethernet/stmicro/stmmac/Kconfig   |   2 +
 .../net/ethernet/stmicro/stmmac/dwmac-intel.c | 146 +++++++++++++++++-
 .../net/ethernet/stmicro/stmmac/dwmac-intel.h |  29 ++++
 include/linux/stmmac.h                        |   4 +
 4 files changed, 179 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/Kconfig b/drivers/net/ethernet/stmicro/stmmac/Kconfig
index 4cc85a36a1ab..25154b915b02 100644
--- a/drivers/net/ethernet/stmicro/stmmac/Kconfig
+++ b/drivers/net/ethernet/stmicro/stmmac/Kconfig
@@ -307,6 +307,8 @@ config DWMAC_INTEL
 	default X86
 	depends on X86 && STMMAC_ETH && PCI
 	depends on COMMON_CLK
+	depends on ACPI
+	select INTEL_PMC_IPC
 	help
 	  This selects the Intel platform specific bus support for the
 	  stmmac driver. This driver is used for Intel Quark/EHL/TGL.
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
index 48acba5eb178..837fd3fbaedb 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
@@ -5,15 +5,30 @@
 #include <linux/clk-provider.h>
 #include <linux/pci.h>
 #include <linux/dmi.h>
+#include <linux/platform_data/x86/intel_pmc_ipc.h>
 #include "dwmac-intel.h"
 #include "dwmac4.h"
 #include "stmmac.h"
 #include "stmmac_ptp.h"
 
+struct pmc_serdes_regs {
+	u8 index;
+	u32 val;
+};
+
+struct pmc_serdes_reg_info {
+	const struct pmc_serdes_regs *regs;
+	u8 num_regs;
+};
+
 struct intel_priv_data {
 	int mdio_adhoc_addr;	/* mdio address for serdes & etc */
 	unsigned long crossts_adj;
 	bool is_pse;
+	const int *tsn_lane_regs;
+	int max_tsn_lane_regs;
+	struct pmc_serdes_reg_info pid_1g;
+	struct pmc_serdes_reg_info pid_2p5g;
 };
 
 /* This struct is used to associate PCI Function of MAC controller on a board,
@@ -35,6 +50,42 @@ struct stmmac_pci_info {
 	int (*setup)(struct pci_dev *pdev, struct plat_stmmacenet_data *plat);
 };
 
+static const struct pmc_serdes_regs pid_modphy3_1g_regs[] = {
+	{ PID_MODPHY3_B_MODPHY_PCR_LCPLL_DWORD0,	B_MODPHY_PCR_LCPLL_DWORD0_1G },
+	{ PID_MODPHY3_N_MODPHY_PCR_LCPLL_DWORD2,	N_MODPHY_PCR_LCPLL_DWORD2_1G },
+	{ PID_MODPHY3_N_MODPHY_PCR_LCPLL_DWORD7,	N_MODPHY_PCR_LCPLL_DWORD7_1G },
+	{ PID_MODPHY3_N_MODPHY_PCR_LPPLL_DWORD10,	N_MODPHY_PCR_LPPLL_DWORD10_1G },
+	{ PID_MODPHY3_N_MODPHY_PCR_CMN_ANA_DWORD30,	N_MODPHY_PCR_CMN_ANA_DWORD30_1G },
+	{}
+};
+
+static const struct pmc_serdes_regs pid_modphy3_2p5g_regs[] = {
+	{ PID_MODPHY3_B_MODPHY_PCR_LCPLL_DWORD0,	B_MODPHY_PCR_LCPLL_DWORD0_2P5G },
+	{ PID_MODPHY3_N_MODPHY_PCR_LCPLL_DWORD2,	N_MODPHY_PCR_LCPLL_DWORD2_2P5G },
+	{ PID_MODPHY3_N_MODPHY_PCR_LCPLL_DWORD7,	N_MODPHY_PCR_LCPLL_DWORD7_2P5G },
+	{ PID_MODPHY3_N_MODPHY_PCR_LPPLL_DWORD10,	N_MODPHY_PCR_LPPLL_DWORD10_2P5G },
+	{ PID_MODPHY3_N_MODPHY_PCR_CMN_ANA_DWORD30,	N_MODPHY_PCR_CMN_ANA_DWORD30_2P5G },
+	{}
+};
+
+static const struct pmc_serdes_regs pid_modphy1_1g_regs[] = {
+	{ PID_MODPHY1_B_MODPHY_PCR_LCPLL_DWORD0,	B_MODPHY_PCR_LCPLL_DWORD0_1G },
+	{ PID_MODPHY1_N_MODPHY_PCR_LCPLL_DWORD2,	N_MODPHY_PCR_LCPLL_DWORD2_1G },
+	{ PID_MODPHY1_N_MODPHY_PCR_LCPLL_DWORD7,	N_MODPHY_PCR_LCPLL_DWORD7_1G },
+	{ PID_MODPHY1_N_MODPHY_PCR_LPPLL_DWORD10,	N_MODPHY_PCR_LPPLL_DWORD10_1G },
+	{ PID_MODPHY1_N_MODPHY_PCR_CMN_ANA_DWORD30,	N_MODPHY_PCR_CMN_ANA_DWORD30_1G },
+	{}
+};
+
+static const struct pmc_serdes_regs pid_modphy1_2p5g_regs[] = {
+	{ PID_MODPHY1_B_MODPHY_PCR_LCPLL_DWORD0,	B_MODPHY_PCR_LCPLL_DWORD0_2P5G },
+	{ PID_MODPHY1_N_MODPHY_PCR_LCPLL_DWORD2,	N_MODPHY_PCR_LCPLL_DWORD2_2P5G },
+	{ PID_MODPHY1_N_MODPHY_PCR_LCPLL_DWORD7,	N_MODPHY_PCR_LCPLL_DWORD7_2P5G },
+	{ PID_MODPHY1_N_MODPHY_PCR_LPPLL_DWORD10,	N_MODPHY_PCR_LPPLL_DWORD10_2P5G },
+	{ PID_MODPHY1_N_MODPHY_PCR_CMN_ANA_DWORD30,	N_MODPHY_PCR_CMN_ANA_DWORD30_2P5G },
+	{}
+};
+
 static int stmmac_pci_find_phy_addr(struct pci_dev *pdev,
 				    const struct dmi_system_id *dmi_list)
 {
@@ -93,7 +144,7 @@ static int intel_serdes_powerup(struct net_device *ndev, void *priv_data)
 	data &= ~SERDES_RATE_MASK;
 	data &= ~SERDES_PCLK_MASK;
 
-	if (priv->plat->max_speed == 2500)
+	if (priv->plat->phy_interface == PHY_INTERFACE_MODE_2500BASEX)
 		data |= SERDES_RATE_PCIE_GEN2 << SERDES_RATE_PCIE_SHIFT |
 			SERDES_PCLK_37p5MHZ << SERDES_PCLK_SHIFT;
 	else
@@ -415,6 +466,95 @@ static void intel_mgbe_pse_crossts_adj(struct intel_priv_data *intel_priv,
 	}
 }
 
+static int intel_tsn_lane_is_available(struct net_device *ndev,
+				       struct intel_priv_data *intel_priv)
+{
+	struct stmmac_priv *priv = netdev_priv(ndev);
+	struct pmc_ipc_cmd tmp = {};
+	u32 rbuf[4] = {};
+	int ret = 0, i, j;
+	const int max_fia_regs = 5;
+
+	tmp.cmd = IPC_SOC_REGISTER_ACCESS;
+	tmp.sub_cmd = IPC_SOC_SUB_CMD_READ;
+
+	for (i = 0; i < max_fia_regs; i++) {
+		tmp.wbuf[0] = R_PCH_FIA_15_PCR_LOS1_REG_BASE + i;
+
+		ret = intel_pmc_ipc(&tmp, rbuf);
+		if (ret < 0) {
+			netdev_info(priv->dev, "Failed to read from PMC.\n");
+			return ret;
+		}
+
+		for (j = 0; j <= intel_priv->max_tsn_lane_regs; j++)
+			if ((rbuf[0] >>
+				(4 * (intel_priv->tsn_lane_regs[j] % 8)) &
+					B_PCH_FIA_PCR_L0O) == 0xB)
+				return ret;
+	}
+
+	return ret;
+}
+
+static int intel_set_reg_access(const struct pmc_serdes_regs *regs, int max_regs)
+{
+	int ret = 0, i;
+
+	for (i = 0; i < max_regs; i++) {
+		struct pmc_ipc_cmd tmp = {};
+		u32 buf[4] = {};
+
+		tmp.cmd = IPC_SOC_REGISTER_ACCESS;
+		tmp.sub_cmd = IPC_SOC_SUB_CMD_WRITE;
+		tmp.wbuf[0] = (u32)regs[i].index;
+		tmp.wbuf[1] = regs[i].val;
+
+		ret = intel_pmc_ipc(&tmp, buf);
+		if (ret < 0)
+			return ret;
+	}
+
+	return ret;
+}
+
+static int intel_mac_finish(struct net_device *ndev,
+			    void *intel_data,
+			    unsigned int mode,
+			    phy_interface_t interface)
+{
+	struct intel_priv_data *intel_priv = intel_data;
+	struct stmmac_priv *priv = netdev_priv(ndev);
+	const struct pmc_serdes_regs *regs;
+	int max_regs = 0;
+	int ret = 0;
+
+	ret = intel_tsn_lane_is_available(ndev, intel_priv);
+	if (ret < 0) {
+		netdev_info(priv->dev, "No TSN lane available to set the registers.\n");
+		return ret;
+	}
+
+	if (interface == PHY_INTERFACE_MODE_2500BASEX) {
+		regs = intel_priv->pid_2p5g.regs;
+		max_regs = intel_priv->pid_2p5g.num_regs;
+	} else {
+		regs = intel_priv->pid_1g.regs;
+		max_regs = intel_priv->pid_1g.num_regs;
+	}
+
+	ret = intel_set_reg_access(regs, max_regs);
+	if (ret < 0)
+		return ret;
+
+	priv->plat->phy_interface = interface;
+
+	intel_serdes_powerdown(ndev, intel_priv);
+	intel_serdes_powerup(ndev, intel_priv);
+
+	return ret;
+}
+
 static void common_default_data(struct plat_stmmacenet_data *plat)
 {
 	plat->clk_csr = 2;	/* clk_csr_i = 20-35MHz & MDC = clk_csr_i/16 */
@@ -650,7 +790,7 @@ static int ehl_sgmii_data(struct pci_dev *pdev,
 	plat->speed_mode_2500 = intel_speed_mode_2500;
 	plat->serdes_powerup = intel_serdes_powerup;
 	plat->serdes_powerdown = intel_serdes_powerdown;
-
+	plat->mac_finish = intel_mac_finish;
 	plat->clk_ptp_rate = 204800000;
 
 	return ehl_common_data(pdev, plat);
@@ -709,6 +849,7 @@ static int ehl_pse0_sgmii1g_data(struct pci_dev *pdev,
 	plat->speed_mode_2500 = intel_speed_mode_2500;
 	plat->serdes_powerup = intel_serdes_powerup;
 	plat->serdes_powerdown = intel_serdes_powerdown;
+	plat->mac_finish = intel_mac_finish;
 	return ehl_pse0_common_data(pdev, plat);
 }
 
@@ -750,6 +891,7 @@ static int ehl_pse1_sgmii1g_data(struct pci_dev *pdev,
 	plat->speed_mode_2500 = intel_speed_mode_2500;
 	plat->serdes_powerup = intel_serdes_powerup;
 	plat->serdes_powerdown = intel_serdes_powerdown;
+	plat->mac_finish = intel_mac_finish;
 	return ehl_pse1_common_data(pdev, plat);
 }
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.h b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.h
index 0a37987478c1..a12f8e65f89f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.h
@@ -50,4 +50,33 @@
 #define PCH_PTP_CLK_FREQ_19_2MHZ	(GMAC_GPO0)
 #define PCH_PTP_CLK_FREQ_200MHZ		(0)
 
+/* Modphy Register index */
+#define R_PCH_FIA_15_PCR_LOS1_REG_BASE			8
+#define R_PCH_FIA_15_PCR_LOS2_REG_BASE			9
+#define R_PCH_FIA_15_PCR_LOS3_REG_BASE			10
+#define R_PCH_FIA_15_PCR_LOS4_REG_BASE			11
+#define R_PCH_FIA_15_PCR_LOS5_REG_BASE			12
+#define B_PCH_FIA_PCR_L0O				GENMASK(3, 0)
+#define PID_MODPHY1_B_MODPHY_PCR_LCPLL_DWORD0		13
+#define PID_MODPHY1_N_MODPHY_PCR_LCPLL_DWORD2		14
+#define PID_MODPHY1_N_MODPHY_PCR_LCPLL_DWORD7		15
+#define PID_MODPHY1_N_MODPHY_PCR_LPPLL_DWORD10		16
+#define PID_MODPHY1_N_MODPHY_PCR_CMN_ANA_DWORD30	17
+#define PID_MODPHY3_B_MODPHY_PCR_LCPLL_DWORD0		18
+#define PID_MODPHY3_N_MODPHY_PCR_LCPLL_DWORD2		19
+#define PID_MODPHY3_N_MODPHY_PCR_LCPLL_DWORD7		20
+#define PID_MODPHY3_N_MODPHY_PCR_LPPLL_DWORD10		21
+#define PID_MODPHY3_N_MODPHY_PCR_CMN_ANA_DWORD30	22
+
+#define B_MODPHY_PCR_LCPLL_DWORD0_1G		0x46AAAA41
+#define N_MODPHY_PCR_LCPLL_DWORD2_1G		0x00000139
+#define N_MODPHY_PCR_LCPLL_DWORD7_1G		0x002A0003
+#define N_MODPHY_PCR_LPPLL_DWORD10_1G		0x00170008
+#define N_MODPHY_PCR_CMN_ANA_DWORD30_1G		0x0000D4AC
+#define B_MODPHY_PCR_LCPLL_DWORD0_2P5G		0x58555551
+#define N_MODPHY_PCR_LCPLL_DWORD2_2P5G		0x0000012D
+#define N_MODPHY_PCR_LCPLL_DWORD7_2P5G		0x001F0003
+#define N_MODPHY_PCR_LPPLL_DWORD10_2P5G		0x00170008
+#define N_MODPHY_PCR_CMN_ANA_DWORD30_2P5G	0x8200ACAC
+
 #endif /* __DWMAC_INTEL_H__ */
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index c9878a612e53..83131bf7a5ef 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -236,6 +236,10 @@ struct plat_stmmacenet_data {
 	int (*serdes_powerup)(struct net_device *ndev, void *priv);
 	void (*serdes_powerdown)(struct net_device *ndev, void *priv);
 	void (*speed_mode_2500)(struct net_device *ndev, void *priv);
+	int (*mac_finish)(struct net_device *ndev,
+			  void *priv,
+			  unsigned int mode,
+			  phy_interface_t interface);
 	void (*ptp_clk_freq_config)(struct stmmac_priv *priv);
 	int (*init)(struct platform_device *pdev, void *priv);
 	void (*exit)(struct platform_device *pdev, void *priv);
-- 
2.34.1


