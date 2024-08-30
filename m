Return-Path: <netdev+bounces-123859-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B919966B17
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 23:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0EBE1C2206A
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 21:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FDAC1C1724;
	Fri, 30 Aug 2024 21:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eI6w7Q8e"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655DC1BF7E4
	for <netdev@vger.kernel.org>; Fri, 30 Aug 2024 21:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725051903; cv=none; b=Msn7RTCS5yEzFqqPxy6oHsorleXCVFYoh1bjeAEo7BAyiBYLto8DoT7vjbPO11E2RCXDdT+AUA1Iu9baopupel9wecLXeCHURG0nFFMx6WRiQXP2fzabRMNfTVZ2iRof9y+CNu/90M9+ZCT+T1U7SwniXqeJlhLrPN9SsOOywHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725051903; c=relaxed/simple;
	bh=qD2e2RX/cvX6Ofct2HRzDNigB3SGiwMdw0Lq1/D9QSI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OYvX9GW0gUFBrQzfeaQ9pJ0MU6TCPWTDF2VPTIbZIHLm4L7YSPICE7zIVtWXjPayE0fvExrc04IJQFpMSZOn1wJHuRfY5/tg3VLHjgAu/c7A9LAAvDiukkliP73DoDHuzAsF54EK797y7Fu0zu8GHM48h26HF+R9PbRrX2E2IGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eI6w7Q8e; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725051902; x=1756587902;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qD2e2RX/cvX6Ofct2HRzDNigB3SGiwMdw0Lq1/D9QSI=;
  b=eI6w7Q8epTkcbgUmfQtEqaNqAOwubk37HFtThCEr4tuesDKeQKr1kyl8
   /SRMuuXvlobrXWv7XsNooMRrjcCUiHraDg7g+zUTrI5WzahHulrNu4Emi
   hGDjdmn4CXzyH+MbweWkH/8Z/k4hNhKd/VYrD1ZMh2TMky5JESmW7+MpS
   wR0Smi8fsetRFblk8zkKC/HDzUeJMRIPHCNMnMb9ZbCRb1kPcPhZRXm4n
   f3RxfU3EFyZmgyfRqcv8jzZxQuE2w9UpuN3PmIhSu+NXYUpIO/Oy4zeya
   y7st7x4ASH2o24pPoRZ9Cq5DNJ5gzOP+NW72OLSvcnBFCBJ6ozWJPrjq/
   w==;
X-CSE-ConnectionGUID: z00tRtNQTDO47oxVNfA9vQ==
X-CSE-MsgGUID: EWvhWz1fRrO7aa1UuXXKvg==
X-IronPort-AV: E=McAfee;i="6700,10204,11180"; a="13304274"
X-IronPort-AV: E=Sophos;i="6.10,189,1719903600"; 
   d="scan'208";a="13304274"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2024 14:05:00 -0700
X-CSE-ConnectionGUID: pY1TOepESsy6jYdTMYX/cw==
X-CSE-MsgGUID: t8mQxdvNSA2pDZbA21hLPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,189,1719903600"; 
   d="scan'208";a="63625250"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa006.fm.intel.com with ESMTP; 30 Aug 2024 14:04:59 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Sasha Neftin <sasha.neftin@intel.com>,
	anthony.l.nguyen@intel.com,
	vitaly.lifshits@intel.com,
	dima.ruinskiy@intel.com,
	Avigail Dahan <avigailx.dahan@intel.com>
Subject: [PATCH net-next 3/6] igc: Add Energy Efficient Ethernet ability
Date: Fri, 30 Aug 2024 14:04:45 -0700
Message-ID: <20240830210451.2375215-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240830210451.2375215-1-anthony.l.nguyen@intel.com>
References: <20240830210451.2375215-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sasha Neftin <sasha.neftin@intel.com>

According to the IEEE standard report the EEE ability (registers 7.60 and
7.62) and the EEE Link Partner ability (registers 7.61 and 7.63). Use the
kernel's 'ethtool_keee' structure and report EEE link modes.

Example:
ethtool --show-eee <device>

Before:
Advertised EEE link modes:  Not reported
Link partner advertised EEE link modes:  Not reported

After:
	Advertised EEE link modes:  100baseT/Full
	                            1000baseT/Full
	                            2500baseT/Full
	Link partner advertised EEE link modes:  100baseT/Full
	                                         1000baseT/Full
	                                         2500baseT/Full

Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
Tested-by: Avigail Dahan <avigailx.dahan@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_defines.h | 10 +++
 drivers/net/ethernet/intel/igc/igc_ethtool.c | 73 +++++++++++++++++++-
 drivers/net/ethernet/intel/igc/igc_regs.h    |  7 ++
 3 files changed, 89 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_defines.h b/drivers/net/ethernet/intel/igc/igc_defines.h
index 52fe10b44b35..6d6717ba4ffd 100644
--- a/drivers/net/ethernet/intel/igc/igc_defines.h
+++ b/drivers/net/ethernet/intel/igc/igc_defines.h
@@ -652,6 +652,16 @@
 #define IGC_MDIC_READY		0x10000000
 #define IGC_MDIC_ERROR		0x40000000
 
+/* EEE Link Ability */
+#define IGC_EEE_2500BT_MASK	BIT(0)
+#define IGC_EEE_1000BT_MASK	BIT(2)
+#define IGC_EEE_100BT_MASK	BIT(1)
+
+/* EEE Link-Partner Ability */
+#define IGC_LP_EEE_2500BT_MASK	BIT(0)
+#define IGC_LP_EEE_1000BT_MASK	BIT(2)
+#define IGC_LP_EEE_100BT_MASK	BIT(1)
+
 #define IGC_N0_QUEUE		-1
 
 #define IGC_MAX_MAC_HDR_LEN	127
diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
index 9ecb2cbbe8e5..457b5d7f1610 100644
--- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
+++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
@@ -1631,8 +1631,11 @@ static int igc_ethtool_get_eee(struct net_device *netdev,
 {
 	struct igc_adapter *adapter = netdev_priv(netdev);
 	struct igc_hw *hw = &adapter->hw;
-	u32 eeer;
+	struct igc_phy_info *phy = &hw->phy;
+	u16 eee_advert, eee_lp_advert;
+	u32 eeer, ret_val;
 
+	/* EEE supported */
 	linkmode_set_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
 			 edata->supported);
 	linkmode_set_bit(ETHTOOL_LINK_MODE_1000baseT_Full_BIT,
@@ -1640,6 +1643,74 @@ static int igc_ethtool_get_eee(struct net_device *netdev,
 	linkmode_set_bit(ETHTOOL_LINK_MODE_100baseT_Full_BIT,
 			 edata->supported);
 
+	/* EEE Advertisement 1 - reg 7.60 */
+	ret_val = phy->ops.read_reg(hw, (STANDARD_AN_REG_MASK <<
+				    MMD_DEVADDR_SHIFT) |
+				    IGC_ANEG_EEE_AB1,
+				    &eee_advert);
+	if (ret_val) {
+		netdev_err(adapter->netdev,
+			   "Failed to read IEEE 7.60 register\n");
+		return -EINVAL;
+	}
+
+	if (eee_advert & IGC_EEE_1000BT_MASK)
+		linkmode_set_bit(ETHTOOL_LINK_MODE_1000baseT_Full_BIT,
+				 edata->advertised);
+
+	if (eee_advert & IGC_EEE_100BT_MASK)
+		linkmode_set_bit(ETHTOOL_LINK_MODE_100baseT_Full_BIT,
+				 edata->advertised);
+
+	/* EEE Advertisement 2 - reg 7.62 */
+	ret_val = phy->ops.read_reg(hw, (STANDARD_AN_REG_MASK <<
+				    MMD_DEVADDR_SHIFT) |
+				    IGC_ANEG_EEE_AB2,
+				    &eee_advert);
+	if (ret_val) {
+		netdev_err(adapter->netdev,
+			   "Failed to read IEEE 7.62 register\n");
+		return -EINVAL;
+	}
+
+	if (eee_advert & IGC_EEE_2500BT_MASK)
+		linkmode_set_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
+				 edata->advertised);
+
+	/* EEE Link-Partner Ability 1 - reg 7.61 */
+	ret_val = phy->ops.read_reg(hw, (STANDARD_AN_REG_MASK <<
+				    MMD_DEVADDR_SHIFT) |
+				    IGC_ANEG_EEE_LP_AB1,
+				    &eee_lp_advert);
+	if (ret_val) {
+		netdev_err(adapter->netdev,
+			   "Failed to read IEEE 7.61 register\n");
+		return -EINVAL;
+	}
+
+	if (eee_lp_advert & IGC_LP_EEE_1000BT_MASK)
+		linkmode_set_bit(ETHTOOL_LINK_MODE_1000baseT_Full_BIT,
+				 edata->lp_advertised);
+
+	if (eee_lp_advert & IGC_LP_EEE_100BT_MASK)
+		linkmode_set_bit(ETHTOOL_LINK_MODE_100baseT_Full_BIT,
+				 edata->lp_advertised);
+
+	/* EEE Link-Partner Ability 2 - reg 7.63 */
+	ret_val = phy->ops.read_reg(hw, (STANDARD_AN_REG_MASK <<
+				    MMD_DEVADDR_SHIFT) |
+				    IGC_ANEG_EEE_LP_AB2,
+				    &eee_lp_advert);
+	if (ret_val) {
+		netdev_err(adapter->netdev,
+			   "Failed to read IEEE 7.63 register\n");
+		return -EINVAL;
+	}
+
+	if (eee_lp_advert & IGC_LP_EEE_2500BT_MASK)
+		linkmode_set_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
+				 edata->lp_advertised);
+
 	eeer = rd32(IGC_EEER);
 
 	/* EEE status on negotiated link */
diff --git a/drivers/net/ethernet/intel/igc/igc_regs.h b/drivers/net/ethernet/intel/igc/igc_regs.h
index c83c723f7c7e..bb6f37f5d3a5 100644
--- a/drivers/net/ethernet/intel/igc/igc_regs.h
+++ b/drivers/net/ethernet/intel/igc/igc_regs.h
@@ -310,6 +310,13 @@
 #define IGC_IPCNFG	0x0E38 /* Internal PHY Configuration */
 #define IGC_EEE_SU	0x0E34 /* EEE Setup */
 
+/* EEE ANeg Advertisement Register - reg 7.60 and reg 7.62 */
+#define IGC_ANEG_EEE_AB1	0x003c
+#define IGC_ANEG_EEE_AB2	0x003e
+/* EEE ANeg Link-Partner Advertisement Register - reg 7.61 and reg 7.63 */
+#define IGC_ANEG_EEE_LP_AB1	0x003d
+#define IGC_ANEG_EEE_LP_AB2	0x003f
+
 /* LTR registers */
 #define IGC_LTRC	0x01A0 /* Latency Tolerance Reporting Control */
 #define IGC_LTRMINV	0x5BB0 /* LTR Minimum Value */
-- 
2.42.0


