Return-Path: <netdev+bounces-191782-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6E5ABD369
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 11:31:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBC0E4A1098
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 09:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F1A2267713;
	Tue, 20 May 2025 09:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="biuwZ3Ba"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FACF21C9EE
	for <netdev@vger.kernel.org>; Tue, 20 May 2025 09:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747733482; cv=none; b=nUb6oNkfVcdWpWHy6DMdII1bNleNc1HI6IFJzbTwPstrAMfTLUWA3kPCIYbCtMnNpT3lUkf9soIHzeRCLMh4IAZZdV3ahCEq4pT8IYsfgz4Qel98O+4/HFmJjk5Pa7euSLSSDHcIF9MwdIY267K9X3jaaOrSchfVv8qoWTeXgCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747733482; c=relaxed/simple;
	bh=hzed/was5BSPNPuo+5oc2fFmRq2hhcmIQe6CaBgRkFw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WLC6Qn63O+CEE/aY+jHxSwJNsFm78dNbXeCLy8WhKXnob6gO6508OmZNC2T+78IlHZ1SAn0uqVaCOlj12HRImvboXcG0pDe4djwlRCcHg1Dh1M7bu85fEvcoAHtQAJmlFjyiXT4BgjeZ8dNbyOoytIhn+WS7b6pdh6JjRubjTlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=biuwZ3Ba; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747733480; x=1779269480;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=hzed/was5BSPNPuo+5oc2fFmRq2hhcmIQe6CaBgRkFw=;
  b=biuwZ3Ba11fttNp6MxbHf5dqm4xpBI3PIwTj6+vsRp0DKmwn9sZxBtYS
   2R56pWXx43Ct+WjAfkPy530AT3+tAYGxBITtV6WEZvlNolY37sKlk7l6A
   UzduyBwmrrEcWPFomzjSFNXDn9Ru5Mbe/MesqCn9ReOkbqI7czEmp5VLC
   /OAxAQyBb8X3THcxQ/eQiXj1292LTLet08pa1np3oLUMVO1zP43kUBRNX
   15w8qAeJR17H21Aem3tiaSDFf3KZaRGh5CMZwaGElox+MLZjru8R0UNQt
   w3ViyGGRLspREPyKMwIQIim+Je2sDuGavp1CT9kavPPOJ01XphLeP+oAd
   Q==;
X-CSE-ConnectionGUID: tGLMW6/hRI6ldKfVwviNFA==
X-CSE-MsgGUID: JIMiwl55Ra2SV3TweodcWw==
X-IronPort-AV: E=McAfee;i="6700,10204,11438"; a="49812154"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="49812154"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 02:31:20 -0700
X-CSE-ConnectionGUID: RKN0lHAARXeSopzNn8z2iQ==
X-CSE-MsgGUID: beYmwyjWRtqx6tvJJ8Ov0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="162942265"
Received: from pae-dbg-x10sri-f_n1_f_263.igk.intel.com (HELO localhost.igk.intel.com) ([172.28.191.222])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 02:31:18 -0700
From: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Dawid Osuchowski <dawid.osuchowski@linux.intel.com>,
	Konrad Knitter <konrad.knitter@intel.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH iwl-next v2] ice: add E835 device IDs
Date: Tue, 20 May 2025 11:30:59 +0200
Message-ID: <20250520093059.387511-1-dawid.osuchowski@linux.intel.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

E835 is an enhanced version of the E830.
It continues to use the same set of commands, registers and interfaces
as other devices in the 800 Series.

Following device IDs are added:
- 0x1248: Intel(R) Ethernet Controller E835-CC for backplane
- 0x1249: Intel(R) Ethernet Controller E835-CC for QSFP
- 0x124A: Intel(R) Ethernet Controller E835-CC for SFP
- 0x1261: Intel(R) Ethernet Controller E835-C for backplane
- 0x1262: Intel(R) Ethernet Controller E835-C for QSFP
- 0x1263: Intel(R) Ethernet Controller E835-C for SFP
- 0x1265: Intel(R) Ethernet Controller E835-L for backplane
- 0x1266: Intel(R) Ethernet Controller E835-L for QSFP
- 0x1267: Intel(R) Ethernet Controller E835-L for SFP

Reviewed-by: Konrad Knitter <konrad.knitter@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
---
v2 changes:
- v1: https://lore.kernel.org/netdev/20250514104632.331559-1-dawid.osuchowski@linux.intel.com/
- Move device IDs to corresponding spot in the file (Tony)
- Add Reviewed-by tag from Simon
---
 drivers/net/ethernet/intel/ice/ice_common.c |  9 +++++++++
 drivers/net/ethernet/intel/ice/ice_devids.h | 18 ++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_main.c   |  9 +++++++++
 3 files changed, 36 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 6e38d46c2c51..010ad09b3200 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -171,6 +171,15 @@ static int ice_set_mac_type(struct ice_hw *hw)
 	case ICE_DEV_ID_E830_XXV_QSFP:
 	case ICE_DEV_ID_E830C_SFP:
 	case ICE_DEV_ID_E830_XXV_SFP:
+	case ICE_DEV_ID_E835CC_BACKPLANE:
+	case ICE_DEV_ID_E835CC_QSFP56:
+	case ICE_DEV_ID_E835CC_SFP:
+	case ICE_DEV_ID_E835C_BACKPLANE:
+	case ICE_DEV_ID_E835C_QSFP:
+	case ICE_DEV_ID_E835C_SFP:
+	case ICE_DEV_ID_E835_L_BACKPLANE:
+	case ICE_DEV_ID_E835_L_QSFP:
+	case ICE_DEV_ID_E835_L_SFP:
 		hw->mac_type = ICE_MAC_E830;
 		break;
 	default:
diff --git a/drivers/net/ethernet/intel/ice/ice_devids.h b/drivers/net/ethernet/intel/ice/ice_devids.h
index 34fd604132f5..bd4e66df0372 100644
--- a/drivers/net/ethernet/intel/ice/ice_devids.h
+++ b/drivers/net/ethernet/intel/ice/ice_devids.h
@@ -6,6 +6,24 @@
 
 /* Device IDs */
 #define ICE_DEV_ID_E822_SI_DFLT         0x1888
+/* Intel(R) Ethernet Controller E835-CC for backplane */
+#define ICE_DEV_ID_E835CC_BACKPLANE	0x1248
+/* Intel(R) Ethernet Controller E835-CC for QSFP */
+#define ICE_DEV_ID_E835CC_QSFP56	0x1249
+/* Intel(R) Ethernet Controller E835-CC for SFP */
+#define ICE_DEV_ID_E835CC_SFP		0x124A
+/* Intel(R) Ethernet Controller E835-C for backplane */
+#define ICE_DEV_ID_E835C_BACKPLANE	0x1261
+/* Intel(R) Ethernet Controller E835-C for QSFP */
+#define ICE_DEV_ID_E835C_QSFP		0x1262
+/* Intel(R) Ethernet Controller E835-C for SFP */
+#define ICE_DEV_ID_E835C_SFP		0x1263
+/* Intel(R) Ethernet Controller E835-L for backplane */
+#define ICE_DEV_ID_E835_L_BACKPLANE	0x1265
+/* Intel(R) Ethernet Controller E835-L for QSFP */
+#define ICE_DEV_ID_E835_L_QSFP		0x1266
+/* Intel(R) Ethernet Controller E835-L for SFP */
+#define ICE_DEV_ID_E835_L_SFP		0x1267
 /* Intel(R) Ethernet Connection E823-L for backplane */
 #define ICE_DEV_ID_E823L_BACKPLANE	0x124C
 /* Intel(R) Ethernet Connection E823-L for SFP */
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index c4264984cfcb..5c941f4426d1 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -5906,6 +5906,15 @@ static const struct pci_device_id ice_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E830_XXV_QSFP), },
 	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E830C_SFP), },
 	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E830_XXV_SFP), },
+	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E835CC_BACKPLANE), },
+	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E835CC_QSFP56), },
+	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E835CC_SFP), },
+	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E835C_BACKPLANE), },
+	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E835C_QSFP), },
+	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E835C_SFP), },
+	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E835_L_BACKPLANE), },
+	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E835_L_QSFP), },
+	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E835_L_SFP), },
 	/* required last entry */
 	{}
 };
-- 
2.47.0


