Return-Path: <netdev+bounces-93798-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8948BD39F
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 19:08:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 025CA1F22763
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 17:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4CA515747B;
	Mon,  6 May 2024 17:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TDOk9Pmb"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329E41553BC
	for <netdev@vger.kernel.org>; Mon,  6 May 2024 17:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715015317; cv=none; b=BzUDB9I1b2gdqeRGKDmb3c7x34oFfafqfLJ0K4uDA5WBM9AnZ0yPuCORPvrGY0BhmI/KFmqAwIi+ENDuz/Mx5Wddimm8VIMg7vEW2jYjGvtbVOZwpgivTvWE/QcjKKbmT0ya8QiyIIZbLQpqY0fjensLpk2HDKCdupos+xZ8SD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715015317; c=relaxed/simple;
	bh=GC5GVRkbF27QqR9O39LecTaBuHuDFho/KW3Gg9nOCOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YdSV072AEozbkLeP/yc4OAhXy5CosCCxJSNktr01ZniQwZQYVAB4h58I4VEoxeLR3cxKnJbraTmA6zwg2lHuZRV7HjRTFlxyNX4YgdbPMcq7LlU4KdBBse+fLU4BR59UeeNW+3CGn2rw0M7wgsKXD1FH/JKd41cB09JhZzq/TQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TDOk9Pmb; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715015317; x=1746551317;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GC5GVRkbF27QqR9O39LecTaBuHuDFho/KW3Gg9nOCOU=;
  b=TDOk9Pmba48dKGFuGJ7N4IFZOguFE5FSa0VOVFabZjJ3SbGZdWgKurcv
   r6ujip3J/q8beD/ztmbUuIQhvOmbZqef6R9L114mZnZpZnuDSwJDhrS22
   kccXJNNReLLhAF+i8iedjZaqgRmPvKlLmFrM9zISuWJCgrWrM2Kcvgwla
   EPVuG7B0m1T0xBSYpMTz7ue37RR8xjfponMePOwNodrDr/BhcvZJhfLy2
   vXAAzc5annAZZiOYYAU3xWxKEHzSxWkUb1UiJnoSPhkfIw7eNU0IIya2x
   Z9pJjwY+hPlEMgFqWcFT39Ut2Wn8JvliYE9J/7FzsjyBKuQsQlWJX5rYZ
   g==;
X-CSE-ConnectionGUID: BCCsBFp4T06mvi0boYSrpA==
X-CSE-MsgGUID: Ekg95e8/QG+7ucWLokceag==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="10896793"
X-IronPort-AV: E=Sophos;i="6.07,259,1708416000"; 
   d="scan'208";a="10896793"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 10:08:35 -0700
X-CSE-ConnectionGUID: l4wRQ0nYT5yCNCYXuLE+5A==
X-CSE-MsgGUID: 4Rysxnm4SN2+D5NElyHBKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,259,1708416000"; 
   d="scan'208";a="33037429"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa004.jf.intel.com with ESMTP; 06 May 2024 10:08:34 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Paul Greenwalt <paul.greenwalt@intel.com>,
	anthony.l.nguyen@intel.com,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net-next 2/4] ice: update E830 device ids and comments
Date: Mon,  6 May 2024 10:08:23 -0700
Message-ID: <20240506170827.948682-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240506170827.948682-1-anthony.l.nguyen@intel.com>
References: <20240506170827.948682-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paul Greenwalt <paul.greenwalt@intel.com>

Update existing E830 device ids and comments to align with new naming 'C'
for 100G and 'CC' for 200G.

Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_common.c |  8 ++++----
 drivers/net/ethernet/intel/ice/ice_devids.h | 16 ++++++++--------
 drivers/net/ethernet/intel/ice/ice_main.c   |  8 ++++----
 3 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 847d22f9fc6c..5649b257e631 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -160,10 +160,10 @@ static int ice_set_mac_type(struct ice_hw *hw)
 	case ICE_DEV_ID_E825C_SGMII:
 		hw->mac_type = ICE_MAC_GENERIC_3K_E825;
 		break;
-	case ICE_DEV_ID_E830_BACKPLANE:
-	case ICE_DEV_ID_E830_QSFP56:
-	case ICE_DEV_ID_E830_SFP:
-	case ICE_DEV_ID_E830_SFP_DD:
+	case ICE_DEV_ID_E830CC_BACKPLANE:
+	case ICE_DEV_ID_E830CC_QSFP56:
+	case ICE_DEV_ID_E830CC_SFP:
+	case ICE_DEV_ID_E830CC_SFP_DD:
 	case ICE_DEV_ID_E830C_BACKPLANE:
 	case ICE_DEV_ID_E830_XXV_BACKPLANE:
 	case ICE_DEV_ID_E830C_QSFP:
diff --git a/drivers/net/ethernet/intel/ice/ice_devids.h b/drivers/net/ethernet/intel/ice/ice_devids.h
index c37b2b450b02..34fd604132f5 100644
--- a/drivers/net/ethernet/intel/ice/ice_devids.h
+++ b/drivers/net/ethernet/intel/ice/ice_devids.h
@@ -16,14 +16,14 @@
 #define ICE_DEV_ID_E823L_1GBE		0x124F
 /* Intel(R) Ethernet Connection E823-L for QSFP */
 #define ICE_DEV_ID_E823L_QSFP		0x151D
-/* Intel(R) Ethernet Controller E830-C for backplane */
-#define ICE_DEV_ID_E830_BACKPLANE	0x12D1
-/* Intel(R) Ethernet Controller E830-C for QSFP */
-#define ICE_DEV_ID_E830_QSFP56		0x12D2
-/* Intel(R) Ethernet Controller E830-C for SFP */
-#define ICE_DEV_ID_E830_SFP		0x12D3
-/* Intel(R) Ethernet Controller E830-C for SFP-DD */
-#define ICE_DEV_ID_E830_SFP_DD		0x12D4
+/* Intel(R) Ethernet Controller E830-CC for backplane */
+#define ICE_DEV_ID_E830CC_BACKPLANE	0x12D1
+/* Intel(R) Ethernet Controller E830-CC for QSFP */
+#define ICE_DEV_ID_E830CC_QSFP56	0x12D2
+/* Intel(R) Ethernet Controller E830-CC for SFP */
+#define ICE_DEV_ID_E830CC_SFP		0x12D3
+/* Intel(R) Ethernet Controller E830-CC for SFP-DD */
+#define ICE_DEV_ID_E830CC_SFP_DD	0x12D4
 /* Intel(R) Ethernet Controller E830-C for backplane */
 #define ICE_DEV_ID_E830C_BACKPLANE	0x12D5
 /* Intel(R) Ethernet Controller E830-C for QSFP */
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 4968331cb1d5..8513deb266eb 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -5805,10 +5805,10 @@ static const struct pci_device_id ice_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E825C_QSFP), },
 	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E825C_SFP), },
 	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E825C_SGMII), },
-	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E830_BACKPLANE) },
-	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E830_QSFP56) },
-	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E830_SFP) },
-	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E830_SFP_DD) },
+	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E830CC_BACKPLANE) },
+	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E830CC_QSFP56) },
+	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E830CC_SFP) },
+	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E830CC_SFP_DD) },
 	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E830C_BACKPLANE), },
 	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E830_XXV_BACKPLANE), },
 	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E830C_QSFP), },
-- 
2.41.0


