Return-Path: <netdev+bounces-162398-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A091A26BF4
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 07:11:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED91A167CA6
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 06:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E846B201267;
	Tue,  4 Feb 2025 06:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TDavNKB0"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090D725A655;
	Tue,  4 Feb 2025 06:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738649490; cv=none; b=LQlMp6XRtVSEUd+LkzKbROFmEmVDq3J52yRw4mqzQ2/rZuOAtS6+NvRYFj97QmxSkQTySYfLMFW/qeSgQ6Zv6IZH5Akpw9xDYKMmm3D4Xlgp9UiLChrvNQaDQvbvvy/YaWYVJHPBPxf7TWJ8jvc4qrkJSWmCD3m7vEExYDoSWoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738649490; c=relaxed/simple;
	bh=5bkc6SzUBfdWPSB7gExlTFthIkT/D4tk+mfb1mANDSw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VlEHFs6Lbrb55bnE8jPK5yU0bSo3/pbmZUQTvB/ssN3vX7DcDMG+gtlF/mvP35giqWdw6Lfn1R2k213CKalzXNi+9hGxSJpFE/xTM4vPwI1UqgreOSVj5klxbuHWmhJUw2ThOguhha0mPeR+azNhcI/6XXvpX5zZiufgScS/Dxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TDavNKB0; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738649489; x=1770185489;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5bkc6SzUBfdWPSB7gExlTFthIkT/D4tk+mfb1mANDSw=;
  b=TDavNKB0rEbAy9dzaPq3nbZ3LB2bADvHGza0FXHSwIlxvkAAB1TYwVSn
   wD2lBbuikdnLu56HWH783N2y0CAYVbLfNIBDNZX0lclLqnmJ3t5k+9o7q
   vQ+6AzNrFdv7rFShfjxj3KwjoBKBG6HJs9vETw6EUt44ANIZBPKS7jRRH
   Q5K2THN04hXJzSRXsMs+kEpdrR8IooocBz7XDs/s1jTBaxh/x1+Mo8kgd
   /CE/t6zq+jlUA9+GTTF7WuOpiRJ7rQ4yebFAqjtllMJTdp7T3xz+FBi6S
   55hdRhCivx7HEvivD3IM6rlKLP8DeRGRolGYc89t16JRcz1juAV9XPC3A
   A==;
X-CSE-ConnectionGUID: l4iJNY5qQP6n7ZO3yZ25Ow==
X-CSE-MsgGUID: Omid1IApRHi5ev0UQ0y8xg==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="50579618"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="50579618"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2025 22:11:28 -0800
X-CSE-ConnectionGUID: E7pjPBh+SXql8izvLDPYnA==
X-CSE-MsgGUID: W0QC9zuwTHOMThr5y0eVlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; 
   d="scan'208";a="110279173"
Received: from yongliang-ubuntu20-ilbpg12.png.intel.com ([10.88.227.39])
  by orviesa009.jf.intel.com with ESMTP; 03 Feb 2025 22:11:20 -0800
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
Subject: [PATCH net-next v6 2/7] net: pcs: xpcs: re-initiate clause 37 Auto-negotiation
Date: Tue,  4 Feb 2025 14:10:15 +0800
Message-Id: <20250204061020.1199124-3-yong.liang.choong@linux.intel.com>
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

The xpcs_switch_interface_mode function was introduced to handle
interface switching.

According to the XPCS datasheet, a soft reset is required to initiate
Clause 37 auto-negotiation when the XPCS switches interface modes.

When the interface mode is set to 2500BASE-X, Clause 37 auto-negotiation
is turned off.

Subsequently, when the interface mode switches from 2500BASE-X to SGMII,
re-initiating Clause 37 auto-negotiation is required for the SGMII
interface mode to function properly.

Signed-off-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>
---
 drivers/net/pcs/pcs-xpcs-wx.c |  4 +--
 drivers/net/pcs/pcs-xpcs.c    | 60 ++++++++++++++++++++++++++++++++---
 2 files changed, 57 insertions(+), 7 deletions(-)

diff --git a/drivers/net/pcs/pcs-xpcs-wx.c b/drivers/net/pcs/pcs-xpcs-wx.c
index fc52f7aa5f59..f73ab04d09f0 100644
--- a/drivers/net/pcs/pcs-xpcs-wx.c
+++ b/drivers/net/pcs/pcs-xpcs-wx.c
@@ -172,11 +172,9 @@ int txgbe_xpcs_switch_mode(struct dw_xpcs *xpcs, phy_interface_t interface)
 		return 0;
 	}
 
-	if (xpcs->interface == interface && !txgbe_xpcs_mode_quirk(xpcs))
+	if (!txgbe_xpcs_mode_quirk(xpcs))
 		return 0;
 
-	xpcs->interface = interface;
-
 	ret = txgbe_pcs_poll_power_up(xpcs);
 	if (ret < 0)
 		return ret;
diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index 1faa37f0e7b9..fb3d1548a8e0 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -817,6 +817,58 @@ static int xpcs_config_2500basex(struct dw_xpcs *xpcs)
 			   BMCR_SPEED1000);
 }
 
+static int xpcs_switch_to_aneg_c37_sgmii(const struct dw_xpcs_compat *compat,
+					 struct dw_xpcs *xpcs,
+					 unsigned int neg_mode)
+{
+	bool an_c37_enabled;
+	int ret, mdio_ctrl;
+
+	if (neg_mode == PHYLINK_PCS_NEG_INBAND_ENABLED) {
+		mdio_ctrl = xpcs_read(xpcs, MDIO_MMD_VEND2, MII_BMCR);
+		if (mdio_ctrl < 0)
+			return mdio_ctrl;
+
+		an_c37_enabled = mdio_ctrl & BMCR_ANENABLE;
+		if (!an_c37_enabled) {
+			//Perform soft reset to initiate C37 auto-negotiation
+			ret = xpcs_soft_reset(xpcs, compat);
+			if (ret)
+				return ret;
+		}
+	}
+	return 0;
+}
+
+static int xpcs_switch_interface_mode(const struct dw_xpcs_compat *compat,
+				      struct dw_xpcs *xpcs,
+				      phy_interface_t interface,
+				      unsigned int neg_mode)
+{
+	int ret = 0;
+
+	if (xpcs->interface != interface) {
+		if (xpcs->info.pma == WX_TXGBE_XPCS_PMA_10G_ID) {
+			ret = txgbe_xpcs_switch_mode(xpcs, interface);
+		} else {
+			switch (compat->an_mode) {
+			case DW_AN_C37_SGMII:
+				ret = xpcs_switch_to_aneg_c37_sgmii(compat, xpcs, neg_mode);
+				break;
+			default:
+				break;
+			}
+		}
+
+		if (ret)
+			return ret;
+
+		xpcs->interface = interface;
+	}
+
+	return 0;
+}
+
 static int xpcs_do_config(struct dw_xpcs *xpcs, phy_interface_t interface,
 			  const unsigned long *advertising,
 			  unsigned int neg_mode)
@@ -828,11 +880,11 @@ static int xpcs_do_config(struct dw_xpcs *xpcs, phy_interface_t interface,
 	if (!compat)
 		return -ENODEV;
 
-	if (xpcs->info.pma == WX_TXGBE_XPCS_PMA_10G_ID) {
-		ret = txgbe_xpcs_switch_mode(xpcs, interface);
-		if (ret)
-			return ret;
+	ret = xpcs_switch_interface_mode(compat, xpcs, interface, neg_mode);
+	if (ret)
+		return ret;
 
+	if (xpcs->info.pma == WX_TXGBE_XPCS_PMA_10G_ID) {
 		/* Wangxun devices need backplane CL37 AN enabled for
 		 * SGMII and 1000base-X
 		 */
-- 
2.34.1


