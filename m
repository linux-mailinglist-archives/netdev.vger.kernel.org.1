Return-Path: <netdev+bounces-145237-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C5E9CDD4E
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 12:12:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36BD5B25BD7
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 11:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1448B1B81DC;
	Fri, 15 Nov 2024 11:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dyut0DGY"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430001B6D17;
	Fri, 15 Nov 2024 11:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731669155; cv=none; b=W9LIx36j+pfAGVY4hU6313wUYAnsDVEwffjwlnpnRAEvWyE0CGh8dN3faRjQ91lv3I0rajTgERjSOjQ7+CKLKCw7kacLQQosj/D7TmTwpaSjKA0jl8IM+JUGAbV7Hn90Z378/MIHPd1HcNnFv8aWD8+AjQik4qfNMcf2m1w8HSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731669155; c=relaxed/simple;
	bh=B5LeEIlYNpdmfHj8eX/PzUHRSW/wGsPyx6FjWG0dlLA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aLpxzh1EGbi5Mw91va8kmgNtswhGqIy0GPjYmmOfHOLiq2lqpPD8Ga72qRDn2w8NMR0hA8nbrDFznc9XlXwNAHXCrACR2NqpHxEff8Vk2Xai5kgzeKiQITkNMVLX2emAyEIzyHlKspoNUi4qAtWXWs6BGE4ZDpUR2VWhZrdQY78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dyut0DGY; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731669154; x=1763205154;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=B5LeEIlYNpdmfHj8eX/PzUHRSW/wGsPyx6FjWG0dlLA=;
  b=Dyut0DGYn/oYftv2XyetI8zl/zy224igJQgSX7oK7d4yTWwHdMxW03yO
   rD2cRxKt1VyeknuWAbD3q1fHDJk94Eo1X6iPVR5yHGytdi1IYR1cPEn2e
   754t3gyFIuIg54zAdIy7XJfFAJq2cSH410MAs8rj9YIQls/vq2DNpZ0lC
   4O+1FTNfD9MFkqJBdwdGOIHgBg6QgFL63CxX3lcQwD96EXb5dXeb445Sj
   z6gEyO59e0BK5VMiG1/5DaaberM1ur+qrEQkxgXfem+Kvs4dCm9EzoYry
   k3546MbXdDDwi2vJmXnKiUizQSoxqJfyrGTiRkM7Qp7lCPAt5rzGrhHtd
   w==;
X-CSE-ConnectionGUID: wKGEDnMLRTK/4f0AOzkHew==
X-CSE-MsgGUID: Oq7z2068QSetagh+AlJNSw==
X-IronPort-AV: E=McAfee;i="6700,10204,11256"; a="34543465"
X-IronPort-AV: E=Sophos;i="6.12,156,1728975600"; 
   d="scan'208";a="34543465"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2024 03:12:33 -0800
X-CSE-ConnectionGUID: UCFsvvZmToeJ5JHd+tMD9g==
X-CSE-MsgGUID: 6N7EzlmcSfO4vtFCaDZ+Cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,156,1728975600"; 
   d="scan'208";a="88112372"
Received: from unknown (HELO YongLiang-Ubuntu20-iLBPG12.png.intel.com) ([10.88.229.33])
  by fmviesa006.fm.intel.com with ESMTP; 15 Nov 2024 03:12:29 -0800
From: Choong Yong Liang <yong.liang.choong@linux.intel.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH net v2 1/2] net: phy: replace phydev->eee_enabled with eee_cfg.eee_enabled
Date: Fri, 15 Nov 2024 19:11:50 +0800
Message-Id: <20241115111151.183108-2-yong.liang.choong@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241115111151.183108-1-yong.liang.choong@linux.intel.com>
References: <20241115111151.183108-1-yong.liang.choong@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Not all PHYs have EEE enabled by default. For example, Marvell PHYs are
designed to have EEE hardware disabled during the initial state.

In the initial stage, phy_probe() sets phydev->eee_enabled to be disabled.
Then, the MAC calls phy_support_eee() to set eee_cfg.eee_enabled to be
enabled. However, when phy_start_aneg() is called,
genphy_c45_an_config_eee_aneg() still refers to phydev->eee_enabled.
This causes the 'ethtool --show-eee' command to show that EEE is enabled,
but in actuality, the driver side is disabled.

This patch will remove phydev->eee_enabled and replace it with
eee_cfg.eee_enabled. When performing genphy_c45_an_config_eee_aneg(),
it will follow the master configuration to have software and hardware
in sync.

Fixes: 3eeca4e199ce ("net: phy: do not force EEE support")
Cc: stable@vger.kernel.org
Signed-off-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>
Suggested-by: Russell King <linux@armlinux.org.uk>
---
 drivers/net/phy/phy-c45.c    | 11 +++++------
 drivers/net/phy/phy_device.c |  6 +++---
 include/linux/phy.h          |  5 ++---
 3 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/net/phy/phy-c45.c b/drivers/net/phy/phy-c45.c
index 5695935fdce9..fa42158eff83 100644
--- a/drivers/net/phy/phy-c45.c
+++ b/drivers/net/phy/phy-c45.c
@@ -272,7 +272,7 @@ int genphy_c45_an_config_aneg(struct phy_device *phydev)
 	linkmode_and(phydev->advertising, phydev->advertising,
 		     phydev->supported);
 
-	ret = genphy_c45_an_config_eee_aneg(phydev);
+	ret = genphy_c45_an_config_eee_aneg(phydev, phydev->eee_cfg.eee_enabled);
 	if (ret < 0)
 		return ret;
 	else if (ret)
@@ -940,9 +940,10 @@ EXPORT_SYMBOL_GPL(genphy_c45_read_eee_abilities);
  * genphy_c45_an_config_eee_aneg - configure EEE advertisement
  * @phydev: target phy_device struct
  */
-int genphy_c45_an_config_eee_aneg(struct phy_device *phydev)
+int genphy_c45_an_config_eee_aneg(struct phy_device *phydev,
+				  bool is_eee_enabled)
 {
-	if (!phydev->eee_enabled) {
+	if (!is_eee_enabled) {
 		__ETHTOOL_DECLARE_LINK_MODE_MASK(adv) = {};
 
 		return genphy_c45_write_eee_adv(phydev, adv);
@@ -1575,9 +1576,7 @@ int genphy_c45_ethtool_set_eee(struct phy_device *phydev,
 		linkmode_copy(phydev->advertising_eee, adv);
 	}
 
-	phydev->eee_enabled = data->eee_enabled;
-
-	ret = genphy_c45_an_config_eee_aneg(phydev);
+	ret = genphy_c45_an_config_eee_aneg(phydev, data->eee_enabled);
 	if (ret > 0) {
 		ret = phy_restart_aneg(phydev);
 		if (ret < 0)
diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 499797646580..97e835ad4544 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -2421,7 +2421,7 @@ int __genphy_config_aneg(struct phy_device *phydev, bool changed)
 	unsigned long *advert;
 	int err;
 
-	err = genphy_c45_an_config_eee_aneg(phydev);
+	err = genphy_c45_an_config_eee_aneg(phydev, phydev->eee_cfg.eee_enabled);
 	if (err < 0)
 		return err;
 	else if (err)
@@ -3595,12 +3595,12 @@ static int phy_probe(struct device *dev)
 	/* There is no "enabled" flag. If PHY is advertising, assume it is
 	 * kind of enabled.
 	 */
-	phydev->eee_enabled = !linkmode_empty(phydev->advertising_eee);
+	phydev->eee_cfg.eee_enabled = !linkmode_empty(phydev->advertising_eee);
 
 	/* Some PHYs may advertise, by default, not support EEE modes. So,
 	 * we need to clean them.
 	 */
-	if (phydev->eee_enabled)
+	if (phydev->eee_cfg.eee_enabled)
 		linkmode_and(phydev->advertising_eee, phydev->supported_eee,
 			     phydev->advertising_eee);
 
diff --git a/include/linux/phy.h b/include/linux/phy.h
index a98bc91a0cde..fde9f1f868bb 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -601,7 +601,6 @@ struct macsec_ops;
  * @adv_old: Saved advertised while power saving for WoL
  * @supported_eee: supported PHY EEE linkmodes
  * @advertising_eee: Currently advertised EEE linkmodes
- * @eee_enabled: Flag indicating whether the EEE feature is enabled
  * @enable_tx_lpi: When True, MAC should transmit LPI to PHY
  * @eee_cfg: User configuration of EEE
  * @lp_advertising: Current link partner advertised linkmodes
@@ -721,7 +720,6 @@ struct phy_device {
 	/* used for eee validation and configuration*/
 	__ETHTOOL_DECLARE_LINK_MODE_MASK(supported_eee);
 	__ETHTOOL_DECLARE_LINK_MODE_MASK(advertising_eee);
-	bool eee_enabled;
 
 	/* Host supported PHY interface types. Should be ignored if empty. */
 	DECLARE_PHY_INTERFACE_MASK(host_interfaces);
@@ -1952,7 +1950,8 @@ int genphy_c45_ethtool_get_eee(struct phy_device *phydev,
 int genphy_c45_ethtool_set_eee(struct phy_device *phydev,
 			       struct ethtool_keee *data);
 int genphy_c45_write_eee_adv(struct phy_device *phydev, unsigned long *adv);
-int genphy_c45_an_config_eee_aneg(struct phy_device *phydev);
+int genphy_c45_an_config_eee_aneg(struct phy_device *phydev,
+				  bool is_eee_enabled);
 int genphy_c45_read_eee_adv(struct phy_device *phydev, unsigned long *adv);
 
 /* Generic C45 PHY driver */
-- 
2.34.1


