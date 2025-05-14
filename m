Return-Path: <netdev+bounces-190373-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 803E4AB6917
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 12:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACCF43B0BE2
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 10:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 274D220D505;
	Wed, 14 May 2025 10:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZYxFkxro"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FF34315F
	for <netdev@vger.kernel.org>; Wed, 14 May 2025 10:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747219600; cv=none; b=bWQ0jNICVDJFU84xkAdVeWI60eLI1/x3G31Fdq9DQoDheW+zfI6GCVxMKOQCthJlQVnoHc+C2X7gk6CTbNtMQwXyt9u4GLk4vQ2GfOGtQ2rCBMO3QMj/+cNWyhy2sbAN+Fh3YV7CF6a++mtf7tohz+n8LrR5Qp6u4ipH6w82TZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747219600; c=relaxed/simple;
	bh=WKJKCZ05Tlu7Vl3oWAyEJ61hqFIgoEFEDZkj7PeTUxI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iiw2Kymb+zcMxpffFhpHxNLchXkBFWJrTmTLM5H+S+GYCJV+T4Jb0eKRODThXF+feruppbAREfe0+r5v0guuMH8ynuksywYk60SIBSsc5fGHBfGVrH3IwSAvJHy31ywMDvRxsIFAhF/W/N2tmjz9J4q7bNH+sOmMEkIHaTjgkmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZYxFkxro; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747219598; x=1778755598;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WKJKCZ05Tlu7Vl3oWAyEJ61hqFIgoEFEDZkj7PeTUxI=;
  b=ZYxFkxroRYurykGNoyYNfmwbDfj8Dsnc40fZ0RCgPVEAQmGK/1lzaPDJ
   5MDSbKY3v6wBBUrlXHLiIC17wVbV3qLBby+6IiJI2BDnuzDLF3vywIpM6
   UUtBVXjsAgQ1QpJLzOmGN4va5cSl2Kav63C7cle/eqZPUwqRzrKS2rBd7
   Y+Z7Gg6HW5sd2fUemuI5Mjrxn1FqAW1aXkpu59a2D1AZWVWkrPLJZMjVY
   Qlv0tHno1b+ovZB85b/H747Fdaxwn6U4O8/a9WjyMBidYrezbKbkf1P4p
   Gd/mHA+3wkb6nQoFYGf6HzGUKqGqJ3FxobK+7bpI2GsD2jcdq6XYWtnzW
   Q==;
X-CSE-ConnectionGUID: Q4Rzfc1eT0+uX/rpFpNlCQ==
X-CSE-MsgGUID: HjBOPICQS+C3qCNgKX/hVw==
X-IronPort-AV: E=McAfee;i="6700,10204,11432"; a="48997030"
X-IronPort-AV: E=Sophos;i="6.15,288,1739865600"; 
   d="scan'208";a="48997030"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 03:46:37 -0700
X-CSE-ConnectionGUID: 4DGcdgobTqSqMfJK1tqyjw==
X-CSE-MsgGUID: p5gPFPN4Tsm+oTkvttxnwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,288,1739865600"; 
   d="scan'208";a="175134616"
Received: from pae-dbg-x10sri-f_n1_f_263.igk.intel.com (HELO localhost.igk.intel.com) ([172.28.191.222])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 03:46:36 -0700
From: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Dawid Osuchowski <dawid.osuchowski@linux.intel.com>,
	Konrad Knitter <konrad.knitter@intel.com>
Subject: [PATCH iwl-next] ice: add E835 device IDs
Date: Wed, 14 May 2025 12:46:32 +0200
Message-ID: <20250514104632.331559-1-dawid.osuchowski@linux.intel.com>
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
Signed-off-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
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
index 34fd604132f5..7761c3501174 100644
--- a/drivers/net/ethernet/intel/ice/ice_devids.h
+++ b/drivers/net/ethernet/intel/ice/ice_devids.h
@@ -36,6 +36,24 @@
 #define ICE_DEV_ID_E830_XXV_QSFP	0x12DD
 /* Intel(R) Ethernet Controller E830-XXV for SFP */
 #define ICE_DEV_ID_E830_XXV_SFP		0x12DE
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
 /* Intel(R) Ethernet Controller E810-C for backplane */
 #define ICE_DEV_ID_E810C_BACKPLANE	0x1591
 /* Intel(R) Ethernet Controller E810-C for QSFP */
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


