Return-Path: <netdev+bounces-101148-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E7328FD7AC
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 22:40:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9739B1F23D89
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 20:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D29E115F31D;
	Wed,  5 Jun 2024 20:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c4Pd/zcM"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC9415EFA3
	for <netdev@vger.kernel.org>; Wed,  5 Jun 2024 20:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717620047; cv=none; b=XZ1pljgydAoejSq2Uh4Bg96fR3yA7/EpT1ChL3emKK43mPDHGtJ4uBqnf69wuuvCfqgv5ZCqO6gpYQbZhNAhDmrBxx5W0vOeegzlR4S852uoG6xXgvxKcrp8doGIbhtG86WF2P+URwquwy60SORzUA1JrSYsJlL8SZh2+xLyJ1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717620047; c=relaxed/simple;
	bh=pwd/MVtitZ8Ps76FwPkFB4/aX/Fn6oW06hDofOADNXc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Fh1Bz8GXl6+ERc5zUJB9TCgZ/LGfNT0MX2bN+OHzfrGFnNeQCX03VF8ZHPVaOkqOtp28WPuzCnWJhMmj5anMutOmd63FUlebeZWIeVMoYJIZLXFVSDFK2OPTo452cpRusignRJrhDVA/DQtMkcF2AWHglQ+iBcwHb419ueG09WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c4Pd/zcM; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717620046; x=1749156046;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=pwd/MVtitZ8Ps76FwPkFB4/aX/Fn6oW06hDofOADNXc=;
  b=c4Pd/zcMVec4LhkEBU9dgKIOLS6rqMZMXJ4+MlcewQyiMUMdUTI3a1dy
   Z14wKIfk4u8uSCImToCKAXbe9pZgaXa8xZhpXm59wc77LdjC14AB8Itey
   bvJgBOTiVsKkR6+UicC16Jbi9ZZXPOlmIwQxhKcM2tEdhC+FsxWj4v2Y/
   GDmjIPNWGToiHC06KAS1/FkScGRPro0/ydLvxjN8Cpb0yzuQx0GsU2UD+
   CbiDFMGCmvoZDOkLF6IGdTpHMIa98DIQL0EeKBOJy6JPouTxy5nUH5ZHt
   VhnVoU1T+T7L5v9J3ig9aemZDMJQW0yRqzlgaZZXY1m1lf2g0aQoBHeR7
   w==;
X-CSE-ConnectionGUID: SXLLvKOaShKecGPrEqUPhQ==
X-CSE-MsgGUID: t7hw0WvIQ2Sk+JQiX9/C/Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11094"; a="18103036"
X-IronPort-AV: E=Sophos;i="6.08,217,1712646000"; 
   d="scan'208";a="18103036"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 13:40:45 -0700
X-CSE-ConnectionGUID: Ux6ICL7DQPG+PFkfjXjRew==
X-CSE-MsgGUID: JzYGIdZlT/2hsH3RRYEI6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,217,1712646000"; 
   d="scan'208";a="37824307"
Received: from jekeller-desk.amr.corp.intel.com ([10.166.241.1])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 13:40:45 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 05 Jun 2024 13:40:41 -0700
Subject: [PATCH v2 1/7] net: intel: Use *-y instead of *-objs in Makefile
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240605-next-2024-06-03-intel-next-batch-v2-1-39c23963fa78@intel.com>
References: <20240605-next-2024-06-03-intel-next-batch-v2-0-39c23963fa78@intel.com>
In-Reply-To: <20240605-next-2024-06-03-intel-next-batch-v2-0-39c23963fa78@intel.com>
To: netdev <netdev@vger.kernel.org>, David Miller <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>
Cc: Jacob Keller <jacob.e.keller@intel.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>, 
 Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
X-Mailer: b4 0.13.0

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

*-objs suffix is reserved rather for (user-space) host programs while
usually *-y suffix is used for kernel drivers (although *-objs works
for that purpose for now).

Let's correct the old usages of *-objs in Makefiles.

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/e1000/Makefile   | 2 +-
 drivers/net/ethernet/intel/e1000e/Makefile  | 7 +++----
 drivers/net/ethernet/intel/i40e/Makefile    | 2 +-
 drivers/net/ethernet/intel/iavf/Makefile    | 5 ++---
 drivers/net/ethernet/intel/igb/Makefile     | 6 +++---
 drivers/net/ethernet/intel/igbvf/Makefile   | 6 +-----
 drivers/net/ethernet/intel/igc/Makefile     | 6 +++---
 drivers/net/ethernet/intel/ixgbe/Makefile   | 8 ++++----
 drivers/net/ethernet/intel/ixgbevf/Makefile | 6 +-----
 drivers/net/ethernet/intel/libeth/Makefile  | 2 +-
 drivers/net/ethernet/intel/libie/Makefile   | 2 +-
 11 files changed, 21 insertions(+), 31 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000/Makefile b/drivers/net/ethernet/intel/e1000/Makefile
index 314c52d44b7c..79491dec47e1 100644
--- a/drivers/net/ethernet/intel/e1000/Makefile
+++ b/drivers/net/ethernet/intel/e1000/Makefile
@@ -7,4 +7,4 @@
 
 obj-$(CONFIG_E1000) += e1000.o
 
-e1000-objs := e1000_main.o e1000_hw.o e1000_ethtool.o e1000_param.o
+e1000-y := e1000_main.o e1000_hw.o e1000_ethtool.o e1000_param.o
diff --git a/drivers/net/ethernet/intel/e1000e/Makefile b/drivers/net/ethernet/intel/e1000e/Makefile
index 0baa15503c38..18f22b6374d5 100644
--- a/drivers/net/ethernet/intel/e1000e/Makefile
+++ b/drivers/net/ethernet/intel/e1000e/Makefile
@@ -10,7 +10,6 @@ subdir-ccflags-y += -I$(src)
 
 obj-$(CONFIG_E1000E) += e1000e.o
 
-e1000e-objs := 82571.o ich8lan.o 80003es2lan.o \
-	       mac.o manage.o nvm.o phy.o \
-	       param.o ethtool.o netdev.o ptp.o
-
+e1000e-y := 82571.o ich8lan.o 80003es2lan.o \
+	    mac.o manage.o nvm.o phy.o \
+	    param.o ethtool.o netdev.o ptp.o
diff --git a/drivers/net/ethernet/intel/i40e/Makefile b/drivers/net/ethernet/intel/i40e/Makefile
index cad93f323bd5..9faa4339a76c 100644
--- a/drivers/net/ethernet/intel/i40e/Makefile
+++ b/drivers/net/ethernet/intel/i40e/Makefile
@@ -10,7 +10,7 @@ subdir-ccflags-y += -I$(src)
 
 obj-$(CONFIG_I40E) += i40e.o
 
-i40e-objs := i40e_main.o \
+i40e-y := i40e_main.o \
 	i40e_ethtool.o	\
 	i40e_adminq.o	\
 	i40e_common.o	\
diff --git a/drivers/net/ethernet/intel/iavf/Makefile b/drivers/net/ethernet/intel/iavf/Makefile
index 2d154a4e2fd7..356ac9faa5bf 100644
--- a/drivers/net/ethernet/intel/iavf/Makefile
+++ b/drivers/net/ethernet/intel/iavf/Makefile
@@ -11,6 +11,5 @@ subdir-ccflags-y += -I$(src)
 
 obj-$(CONFIG_IAVF) += iavf.o
 
-iavf-objs := iavf_main.o iavf_ethtool.o iavf_virtchnl.o iavf_fdir.o \
-	     iavf_adv_rss.o \
-	     iavf_txrx.o iavf_common.o iavf_adminq.o
+iavf-y := iavf_main.o iavf_ethtool.o iavf_virtchnl.o iavf_fdir.o \
+	  iavf_adv_rss.o iavf_txrx.o iavf_common.o iavf_adminq.o
diff --git a/drivers/net/ethernet/intel/igb/Makefile b/drivers/net/ethernet/intel/igb/Makefile
index 394c1e0656b9..463c0d26b9d4 100644
--- a/drivers/net/ethernet/intel/igb/Makefile
+++ b/drivers/net/ethernet/intel/igb/Makefile
@@ -6,6 +6,6 @@
 
 obj-$(CONFIG_IGB) += igb.o
 
-igb-objs := igb_main.o igb_ethtool.o e1000_82575.o \
-	    e1000_mac.o e1000_nvm.o e1000_phy.o e1000_mbx.o \
-	    e1000_i210.o igb_ptp.o igb_hwmon.o
+igb-y := igb_main.o igb_ethtool.o e1000_82575.o \
+	 e1000_mac.o e1000_nvm.o e1000_phy.o e1000_mbx.o \
+	 e1000_i210.o igb_ptp.o igb_hwmon.o
diff --git a/drivers/net/ethernet/intel/igbvf/Makefile b/drivers/net/ethernet/intel/igbvf/Makefile
index afd3e36eae75..902711d5e691 100644
--- a/drivers/net/ethernet/intel/igbvf/Makefile
+++ b/drivers/net/ethernet/intel/igbvf/Makefile
@@ -6,8 +6,4 @@
 
 obj-$(CONFIG_IGBVF) += igbvf.o
 
-igbvf-objs := vf.o \
-              mbx.o \
-              ethtool.o \
-              netdev.o
-
+igbvf-y := vf.o mbx.o ethtool.o netdev.o
diff --git a/drivers/net/ethernet/intel/igc/Makefile b/drivers/net/ethernet/intel/igc/Makefile
index ebffd3054285..efc5e7983dad 100644
--- a/drivers/net/ethernet/intel/igc/Makefile
+++ b/drivers/net/ethernet/intel/igc/Makefile
@@ -6,7 +6,7 @@
 #
 
 obj-$(CONFIG_IGC) += igc.o
-igc-$(CONFIG_IGC_LEDS) += igc_leds.o
 
-igc-objs := igc_main.o igc_mac.o igc_i225.o igc_base.o igc_nvm.o igc_phy.o \
-igc_diag.o igc_ethtool.o igc_ptp.o igc_dump.o igc_tsn.o igc_xdp.o
+igc-y := igc_main.o igc_mac.o igc_i225.o igc_base.o igc_nvm.o igc_phy.o \
+	 igc_diag.o igc_ethtool.o igc_ptp.o igc_dump.o igc_tsn.o igc_xdp.o
+igc-$(CONFIG_IGC_LEDS) += igc_leds.o
diff --git a/drivers/net/ethernet/intel/ixgbe/Makefile b/drivers/net/ethernet/intel/ixgbe/Makefile
index 4fb0d9e3f2da..965e5ce1b326 100644
--- a/drivers/net/ethernet/intel/ixgbe/Makefile
+++ b/drivers/net/ethernet/intel/ixgbe/Makefile
@@ -6,10 +6,10 @@
 
 obj-$(CONFIG_IXGBE) += ixgbe.o
 
-ixgbe-objs := ixgbe_main.o ixgbe_common.o ixgbe_ethtool.o \
-              ixgbe_82599.o ixgbe_82598.o ixgbe_phy.o ixgbe_sriov.o \
-              ixgbe_mbx.o ixgbe_x540.o ixgbe_x550.o ixgbe_lib.o ixgbe_ptp.o \
-              ixgbe_xsk.o
+ixgbe-y := ixgbe_main.o ixgbe_common.o ixgbe_ethtool.o \
+           ixgbe_82599.o ixgbe_82598.o ixgbe_phy.o ixgbe_sriov.o \
+           ixgbe_mbx.o ixgbe_x540.o ixgbe_x550.o ixgbe_lib.o ixgbe_ptp.o \
+           ixgbe_xsk.o
 
 ixgbe-$(CONFIG_IXGBE_DCB) +=  ixgbe_dcb.o ixgbe_dcb_82598.o \
                               ixgbe_dcb_82599.o ixgbe_dcb_nl.o
diff --git a/drivers/net/ethernet/intel/ixgbevf/Makefile b/drivers/net/ethernet/intel/ixgbevf/Makefile
index 186a4bb24fde..01d3e892f3fa 100644
--- a/drivers/net/ethernet/intel/ixgbevf/Makefile
+++ b/drivers/net/ethernet/intel/ixgbevf/Makefile
@@ -6,9 +6,5 @@
 
 obj-$(CONFIG_IXGBEVF) += ixgbevf.o
 
-ixgbevf-objs := vf.o \
-                mbx.o \
-                ethtool.o \
-                ixgbevf_main.o
+ixgbevf-y := vf.o mbx.o ethtool.o ixgbevf_main.o
 ixgbevf-$(CONFIG_IXGBEVF_IPSEC) += ipsec.o
-
diff --git a/drivers/net/ethernet/intel/libeth/Makefile b/drivers/net/ethernet/intel/libeth/Makefile
index cb99203d1dd2..52492b081132 100644
--- a/drivers/net/ethernet/intel/libeth/Makefile
+++ b/drivers/net/ethernet/intel/libeth/Makefile
@@ -3,4 +3,4 @@
 
 obj-$(CONFIG_LIBETH)		+= libeth.o
 
-libeth-objs			+= rx.o
+libeth-y			:= rx.o
diff --git a/drivers/net/ethernet/intel/libie/Makefile b/drivers/net/ethernet/intel/libie/Makefile
index bf42c5aeeedd..ffd27fab916a 100644
--- a/drivers/net/ethernet/intel/libie/Makefile
+++ b/drivers/net/ethernet/intel/libie/Makefile
@@ -3,4 +3,4 @@
 
 obj-$(CONFIG_LIBIE)	+= libie.o
 
-libie-objs		+= rx.o
+libie-y			:= rx.o

-- 
2.44.0.53.g0f9d4d28b7e6


