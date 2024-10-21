Return-Path: <netdev+bounces-137531-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E09339A6CB9
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 16:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BE7A280DA4
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 14:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88CD11E9074;
	Mon, 21 Oct 2024 14:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IAop/KfH"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB8B1DE88C
	for <netdev@vger.kernel.org>; Mon, 21 Oct 2024 14:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729522259; cv=none; b=OXXdCwtI1CS5fiZ33TkVSO+qYA380qdw7CvIMq3bH8MXkiZjCtJorHgokcrhPvq7y56xzATQseA7ANkMPl/TllUYYffQZqMw7UMKOtHSwilld6TARVf3m51Uq4vvPZBX3OIzPqnFSQbF9RpqQ8ZPmKEo5einU303u7mVeK5R9Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729522259; c=relaxed/simple;
	bh=m4KNzbG/ZQpZhCQ3XsQ/I1ca3IyouIoCTbBeLkhGQng=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KIzcwAC/ZYq47XPyWN3hzWj4AMg/go4qb8WcQpLp3GaJtBzOXgUZ7SlfSngNO9+cSnc9whT3xck8SBBo2h2vZ0WscujI/mALcVIuCulBwOOdU/VfDcuf56Aqq9+nu4ImSGB8c1Yqygpl2C7084IsQ3/ObcpegRib7gMO4WssZFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IAop/KfH; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729522257; x=1761058257;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=m4KNzbG/ZQpZhCQ3XsQ/I1ca3IyouIoCTbBeLkhGQng=;
  b=IAop/KfHO1n4bWpZr5Jy3dPfR8a1TQLUQSaoZTUO7u2j9T4BwU6qZcsH
   WOa7CrTlIWg9C+s7o59MAK9hm+U2U2QPQZ23hZLL0uBmd6p63RemAQrwW
   pZNe5asMBoqOenh+KtR9e38U24cgz6RGexll8kVuh1mqy5VNcGiox1puy
   VUMAVvzNtwlj2kQaEoWzBXoiXcgLzgC9unxJus6EnIv8EZMqSC2qx82HI
   TZtKRc1YAtjXseXJu/gvEvaoDPTHVFCxnAPhUPVLg4/YQ7a9tzzN1Imt8
   YkVLqY/RfzShmvC8+zLnSDLE0Ds+cmkLEi1egF31gscpUgroGopCigWiF
   A==;
X-CSE-ConnectionGUID: POvdNrV+SM+qofxJ0YC/BQ==
X-CSE-MsgGUID: 2IpK71qPTmuaQoMY9B/4gA==
X-IronPort-AV: E=McAfee;i="6700,10204,11232"; a="39598572"
X-IronPort-AV: E=Sophos;i="6.11,221,1725346800"; 
   d="scan'208";a="39598572"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 07:50:57 -0700
X-CSE-ConnectionGUID: PdJin0YbQ7KAxJYGJdt/ow==
X-CSE-MsgGUID: 457wREENTJO+6Rx4RwgtJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,221,1725346800"; 
   d="scan'208";a="110305906"
Received: from pkwapuli-mobl1.ger.corp.intel.com (HELO vbox-pkwap.ger.corp.intel.com) ([10.246.19.66])
  by fmviesa001.fm.intel.com with ESMTP; 21 Oct 2024 07:50:55 -0700
From: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Piotr Kwapulinski <piotr.kwapulinski@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH iwl-next v2 2/2] ixgbevf: Add support for Intel(R) E610 device
Date: Mon, 21 Oct 2024 16:48:41 +0200
Message-ID: <20241021144841.5476-1-piotr.kwapulinski@intel.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for Intel(R) E610 Series of network devices. The E610
is based on X550 but adds firmware managed link, enhanced security
capabilities and support for updated server manageability

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
---
 drivers/net/ethernet/intel/ixgbevf/defines.h      |  5 ++++-
 drivers/net/ethernet/intel/ixgbevf/ixgbevf.h      |  6 +++++-
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 12 ++++++++++--
 drivers/net/ethernet/intel/ixgbevf/vf.c           | 12 +++++++++++-
 drivers/net/ethernet/intel/ixgbevf/vf.h           |  4 +++-
 5 files changed, 33 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbevf/defines.h b/drivers/net/ethernet/intel/ixgbevf/defines.h
index 5f08779..368d514 100644
--- a/drivers/net/ethernet/intel/ixgbevf/defines.h
+++ b/drivers/net/ethernet/intel/ixgbevf/defines.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright(c) 1999 - 2018 Intel Corporation. */
+/* Copyright(c) 1999 - 2024 Intel Corporation. */
 
 #ifndef _IXGBEVF_DEFINES_H_
 #define _IXGBEVF_DEFINES_H_
@@ -16,6 +16,9 @@
 #define IXGBE_DEV_ID_X550_VF_HV		0x1564
 #define IXGBE_DEV_ID_X550EM_X_VF_HV	0x15A9
 
+#define IXGBE_DEV_ID_E610_VF		0x57AD
+#define IXGBE_SUBDEV_ID_E610_VF_HV	0x0001
+
 #define IXGBE_VF_IRQ_CLEAR_MASK		7
 #define IXGBE_VF_MAX_TX_QUEUES		8
 #define IXGBE_VF_MAX_RX_QUEUES		8
diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h b/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
index 130cb86..9b37f35 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright(c) 1999 - 2018 Intel Corporation. */
+/* Copyright(c) 1999 - 2024 Intel Corporation. */
 
 #ifndef _IXGBEVF_H_
 #define _IXGBEVF_H_
@@ -418,6 +418,8 @@ enum ixgbevf_boards {
 	board_X550EM_x_vf,
 	board_X550EM_x_vf_hv,
 	board_x550em_a_vf,
+	board_e610_vf,
+	board_e610_vf_hv,
 };
 
 enum ixgbevf_xcast_modes {
@@ -434,11 +436,13 @@ extern const struct ixgbevf_info ixgbevf_X550EM_x_vf_info;
 extern const struct ixgbe_mbx_operations ixgbevf_mbx_ops;
 extern const struct ixgbe_mbx_operations ixgbevf_mbx_ops_legacy;
 extern const struct ixgbevf_info ixgbevf_x550em_a_vf_info;
+extern const struct ixgbevf_info ixgbevf_e610_vf_info;
 
 extern const struct ixgbevf_info ixgbevf_82599_vf_hv_info;
 extern const struct ixgbevf_info ixgbevf_X540_vf_hv_info;
 extern const struct ixgbevf_info ixgbevf_X550_vf_hv_info;
 extern const struct ixgbevf_info ixgbevf_X550EM_x_vf_hv_info;
+extern const struct ixgbevf_info ixgbevf_e610_vf_hv_info;
 extern const struct ixgbe_mbx_operations ixgbevf_hv_mbx_ops;
 
 /* needed by ethtool.c */
diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index 149911e..2829bac 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright(c) 1999 - 2018 Intel Corporation. */
+/* Copyright(c) 1999 - 2024 Intel Corporation. */
 
 /******************************************************************************
  Copyright (c)2006 - 2007 Myricom, Inc. for some LRO specific code
@@ -39,7 +39,7 @@ static const char ixgbevf_driver_string[] =
 	"Intel(R) 10 Gigabit PCI Express Virtual Function Network Driver";
 
 static char ixgbevf_copyright[] =
-	"Copyright (c) 2009 - 2018 Intel Corporation.";
+	"Copyright (c) 2009 - 2024 Intel Corporation.";
 
 static const struct ixgbevf_info *ixgbevf_info_tbl[] = {
 	[board_82599_vf]	= &ixgbevf_82599_vf_info,
@@ -51,6 +51,8 @@ static const struct ixgbevf_info *ixgbevf_info_tbl[] = {
 	[board_X550EM_x_vf]	= &ixgbevf_X550EM_x_vf_info,
 	[board_X550EM_x_vf_hv]	= &ixgbevf_X550EM_x_vf_hv_info,
 	[board_x550em_a_vf]	= &ixgbevf_x550em_a_vf_info,
+	[board_e610_vf]         = &ixgbevf_e610_vf_info,
+	[board_e610_vf_hv]      = &ixgbevf_e610_vf_hv_info,
 };
 
 /* ixgbevf_pci_tbl - PCI Device ID Table
@@ -71,6 +73,9 @@ static const struct pci_device_id ixgbevf_pci_tbl[] = {
 	{PCI_VDEVICE(INTEL, IXGBE_DEV_ID_X550EM_X_VF), board_X550EM_x_vf },
 	{PCI_VDEVICE(INTEL, IXGBE_DEV_ID_X550EM_X_VF_HV), board_X550EM_x_vf_hv},
 	{PCI_VDEVICE(INTEL, IXGBE_DEV_ID_X550EM_A_VF), board_x550em_a_vf },
+	{PCI_VDEVICE_SUB(INTEL, IXGBE_DEV_ID_E610_VF, PCI_ANY_ID,
+			 IXGBE_SUBDEV_ID_E610_VF_HV), board_e610_vf_hv},
+	{PCI_VDEVICE(INTEL, IXGBE_DEV_ID_E610_VF), board_e610_vf},
 	/* required last entry */
 	{0, }
 };
@@ -4693,6 +4698,9 @@ static int ixgbevf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	case ixgbe_mac_X540_vf:
 		dev_info(&pdev->dev, "Intel(R) X540 Virtual Function\n");
 		break;
+	case ixgbe_mac_e610_vf:
+		dev_info(&pdev->dev, "Intel(R) E610 Virtual Function\n");
+		break;
 	case ixgbe_mac_82599_vf:
 	default:
 		dev_info(&pdev->dev, "Intel(R) 82599 Virtual Function\n");
diff --git a/drivers/net/ethernet/intel/ixgbevf/vf.c b/drivers/net/ethernet/intel/ixgbevf/vf.c
index 1641d00..da7a72e 100644
--- a/drivers/net/ethernet/intel/ixgbevf/vf.c
+++ b/drivers/net/ethernet/intel/ixgbevf/vf.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright(c) 1999 - 2018 Intel Corporation. */
+/* Copyright(c) 1999 - 2024 Intel Corporation. */
 
 #include "vf.h"
 #include "ixgbevf.h"
@@ -1076,3 +1076,13 @@ const struct ixgbevf_info ixgbevf_x550em_a_vf_info = {
 	.mac = ixgbe_mac_x550em_a_vf,
 	.mac_ops = &ixgbevf_mac_ops,
 };
+
+const struct ixgbevf_info ixgbevf_e610_vf_info = {
+	.mac                    = ixgbe_mac_e610_vf,
+	.mac_ops                = &ixgbevf_mac_ops,
+};
+
+const struct ixgbevf_info ixgbevf_e610_vf_hv_info = {
+	.mac            = ixgbe_mac_e610_vf,
+	.mac_ops        = &ixgbevf_hv_mac_ops,
+};
diff --git a/drivers/net/ethernet/intel/ixgbevf/vf.h b/drivers/net/ethernet/intel/ixgbevf/vf.h
index b4eef5b..2d791bc 100644
--- a/drivers/net/ethernet/intel/ixgbevf/vf.h
+++ b/drivers/net/ethernet/intel/ixgbevf/vf.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright(c) 1999 - 2018 Intel Corporation. */
+/* Copyright(c) 1999 - 2024 Intel Corporation. */
 
 #ifndef __IXGBE_VF_H__
 #define __IXGBE_VF_H__
@@ -54,6 +54,8 @@ enum ixgbe_mac_type {
 	ixgbe_mac_X550_vf,
 	ixgbe_mac_X550EM_x_vf,
 	ixgbe_mac_x550em_a_vf,
+	ixgbe_mac_e610,
+	ixgbe_mac_e610_vf,
 	ixgbe_num_macs
 };
 
-- 
2.43.0


