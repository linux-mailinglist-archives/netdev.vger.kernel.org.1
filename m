Return-Path: <netdev+bounces-93797-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF1B8BD39E
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 19:08:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0D23281E8B
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 17:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A35615746B;
	Mon,  6 May 2024 17:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qjc1IlDC"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88EF81DA21
	for <netdev@vger.kernel.org>; Mon,  6 May 2024 17:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715015317; cv=none; b=TtsGvp5SEnHG4S9aqTMmSzePNFzm5/Ef/VoTLzAvooWpP4qHTZ0kKGGHF3LADCOMqR3+c1Cq09YGTYjdfV5F7HBblBDewzhy9V/pBTULtHvPWXP34dT4If2m8QKKGutqRGBCSi07ZMCiGWwCMK5+mu0cJP3L6dLgkraPxYq7wlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715015317; c=relaxed/simple;
	bh=0kiumT7yXuP7VLsa3C1ZUlww7oheHHePtpmbIlx12n8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HEUdVjRA6bC97OkAOVKQX9D/3Doc4jJAFWqSPTw+PovsLKBf05PAuhpwTlkYx47whoq8ZGDw81KQc6WfHjaJhhbPAWMBbJB41XsU+yU3NdSmemv6VUjkrCjemQCilnDezvXGINOCSP3Ep/Pc8xBaNHxD8cnDyRe/lPoKX4BZVzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qjc1IlDC; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715015316; x=1746551316;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0kiumT7yXuP7VLsa3C1ZUlww7oheHHePtpmbIlx12n8=;
  b=Qjc1IlDC4xp6lTw57jWieZGQ6TUVeaMBSA9VZppf52M30+CrDH+KIfOz
   d1RS43olfiznxDFIFp/vQzXDN8W09/elHDlgqvfPE2q/2eWPFvrXTxhWQ
   W4nrasUDtN3fkq2nzckwPbhTIgoN0LjW404FCnvJv2El0BjVi4fUZU+7V
   u5Ylgl/6igmoZgZGtNGFEclasAPI38AoJbDDtzG5rT4B/S8LrJ6lxylsB
   ixNjpFumD66ULpZLpgWjRDrkbZdx8pBtkWzDjrerYophY4Iy9ClY8U801
   g8bUn4Jyil/LUqGd/IqUlLDc4bWtLVF6jULj5ITbiFB7eqlIfWS5qXYic
   w==;
X-CSE-ConnectionGUID: FLz7oAxORhSxZoTRZMHXtg==
X-CSE-MsgGUID: /N1QTYR1Roi4d4FUc+iLAQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="10896787"
X-IronPort-AV: E=Sophos;i="6.07,259,1708416000"; 
   d="scan'208";a="10896787"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 10:08:35 -0700
X-CSE-ConnectionGUID: kWWxGK2eRoWLat+ywIaOKQ==
X-CSE-MsgGUID: suFnrGb2SnSbfNBn/uW+2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,259,1708416000"; 
   d="scan'208";a="33037426"
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
Subject: [PATCH net-next 1/4] ice: add additional E830 device ids
Date: Mon,  6 May 2024 10:08:22 -0700
Message-ID: <20240506170827.948682-2-anthony.l.nguyen@intel.com>
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

Add support for additional E830 device ids which are supported by the
driver:
- 0x12D5: Intel(R) Ethernet Controller E830-C for backplane
- 0x12D8: Intel(R) Ethernet Controller E830-C for QSFP
- 0x12DA: Intel(R) Ethernet Controller E830-C for SFP
- 0x12DC: Intel(R) Ethernet Controller E830-XXV for backplane
- 0x12DD: Intel(R) Ethernet Controller E830-XXV for QSFP
- 0x12DE: Intel(R) Ethernet Controller E830-XXV for SFP

Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_common.c |  6 ++++++
 drivers/net/ethernet/intel/ice/ice_devids.h | 12 ++++++++++++
 drivers/net/ethernet/intel/ice/ice_main.c   |  6 ++++++
 3 files changed, 24 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index f4bc8723ffa9..847d22f9fc6c 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -164,6 +164,12 @@ static int ice_set_mac_type(struct ice_hw *hw)
 	case ICE_DEV_ID_E830_QSFP56:
 	case ICE_DEV_ID_E830_SFP:
 	case ICE_DEV_ID_E830_SFP_DD:
+	case ICE_DEV_ID_E830C_BACKPLANE:
+	case ICE_DEV_ID_E830_XXV_BACKPLANE:
+	case ICE_DEV_ID_E830C_QSFP:
+	case ICE_DEV_ID_E830_XXV_QSFP:
+	case ICE_DEV_ID_E830C_SFP:
+	case ICE_DEV_ID_E830_XXV_SFP:
 		hw->mac_type = ICE_MAC_E830;
 		break;
 	default:
diff --git a/drivers/net/ethernet/intel/ice/ice_devids.h b/drivers/net/ethernet/intel/ice/ice_devids.h
index 9dfae9bce758..c37b2b450b02 100644
--- a/drivers/net/ethernet/intel/ice/ice_devids.h
+++ b/drivers/net/ethernet/intel/ice/ice_devids.h
@@ -24,6 +24,18 @@
 #define ICE_DEV_ID_E830_SFP		0x12D3
 /* Intel(R) Ethernet Controller E830-C for SFP-DD */
 #define ICE_DEV_ID_E830_SFP_DD		0x12D4
+/* Intel(R) Ethernet Controller E830-C for backplane */
+#define ICE_DEV_ID_E830C_BACKPLANE	0x12D5
+/* Intel(R) Ethernet Controller E830-C for QSFP */
+#define ICE_DEV_ID_E830C_QSFP		0x12D8
+/* Intel(R) Ethernet Controller E830-C for SFP */
+#define ICE_DEV_ID_E830C_SFP		0x12DA
+/* Intel(R) Ethernet Controller E830-XXV for backplane */
+#define ICE_DEV_ID_E830_XXV_BACKPLANE	0x12DC
+/* Intel(R) Ethernet Controller E830-XXV for QSFP */
+#define ICE_DEV_ID_E830_XXV_QSFP	0x12DD
+/* Intel(R) Ethernet Controller E830-XXV for SFP */
+#define ICE_DEV_ID_E830_XXV_SFP		0x12DE
 /* Intel(R) Ethernet Controller E810-C for backplane */
 #define ICE_DEV_ID_E810C_BACKPLANE	0x1591
 /* Intel(R) Ethernet Controller E810-C for QSFP */
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 06549dae4cca..4968331cb1d5 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -5809,6 +5809,12 @@ static const struct pci_device_id ice_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E830_QSFP56) },
 	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E830_SFP) },
 	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E830_SFP_DD) },
+	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E830C_BACKPLANE), },
+	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E830_XXV_BACKPLANE), },
+	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E830C_QSFP), },
+	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E830_XXV_QSFP), },
+	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E830C_SFP), },
+	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E830_XXV_SFP), },
 	/* required last entry */
 	{}
 };
-- 
2.41.0


