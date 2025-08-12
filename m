Return-Path: <netdev+bounces-212766-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF3DDB21C3D
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 06:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6850A7B5A1B
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 04:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E6E2E4274;
	Tue, 12 Aug 2025 04:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VSKCGRUO"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40B62E424A
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 04:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754974043; cv=none; b=hTfW9SaeWV0mTweAQN1uUJQ87NHqxL2ik+oRcqtzJHIuPpZUw/j16INZmtJk7eUeSYnH+5bm+YOyI3oYtT0MJ4KB/uBO56CcEN71z+A0zA+P930YkQ3UqibAfsUZ9djYl02utZDYkux10XNgl/yoVBEejd/OFPFUd3FyuOAmKTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754974043; c=relaxed/simple;
	bh=w1saJZ9teRrvCj2qnOPyXDz8czIGDvTB2/wrmU2jX/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EbmybXOExiV4btimpfguhiEHOP1PNvhPJMPbCvmKvN/+aN4lVnTVIkafhBtVqaJwZh0/n6JWh6twdHfmVCUhISnDAHu55noY6CheYnMCS5AB1GkIOD6BSvfj+biiElDi/Eg8FdsYAeQYlB6aYEVKUc1RVzkdLpADoONeuGtH5E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VSKCGRUO; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754974042; x=1786510042;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=w1saJZ9teRrvCj2qnOPyXDz8czIGDvTB2/wrmU2jX/Q=;
  b=VSKCGRUOxHMTONquRq9SJ6HwFGlaAs1RLDVkjnf+hwNzM/HkCw4LBL6U
   c26h9Ep1v6u2Y1LCEUlgSR5MCjYUXbRzJa+UjbgpXIgU880u/jqFSDwdf
   aLydwLuxv+VD1HXiCNrcHO78vCcVxMDq6A3FRKx1GRtl+6cpaDcD9+pxt
   zAISCzcA+lINPd2TAq0lbknnUlQg4nZsBHZ7KkH0B2gpKaI4iRjw0dD99
   v0DYJIMML7996f1zF2z/OlD3R8Oq97q44fccsgZwUYBPp/pieIswJSz1e
   Uphq2CnMgkiGHOgwxfHMIwpVOHiUX5S96oOHyC3Gmd/MNRmLEkCsVs6xf
   g==;
X-CSE-ConnectionGUID: +b2GhAmyQeCTrHZa0JV43Q==
X-CSE-MsgGUID: x0ohhnToReqPZsNVUjvyVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="68612778"
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="68612778"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 21:47:22 -0700
X-CSE-ConnectionGUID: 7o/E3V7GTp2sk6wjM0IkLQ==
X-CSE-MsgGUID: QcGY2K/mS4Sc0J+r6cc3Sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="165327925"
Received: from unknown (HELO os-delivery.igk.intel.com) ([10.102.21.165])
  by orviesa010.jf.intel.com with ESMTP; 11 Aug 2025 21:47:20 -0700
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	przemyslaw.kitszel@intel.com,
	dawid.osuchowski@linux.intel.com,
	horms@kernel.org,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: [PATCH iwl-next v2 14/15] ice, libie: move fwlog code to libie
Date: Tue, 12 Aug 2025 06:23:35 +0200
Message-ID: <20250812042337.1356907-15-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250812042337.1356907-1-michal.swiatkowski@linux.intel.com>
References: <20250812042337.1356907-1-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move whole code from ice_fwlog.c/h to libie/fwlog.c/h.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/intel/Kconfig                |  1 +
 drivers/net/ethernet/intel/ice/Makefile           |  1 -
 drivers/net/ethernet/intel/ice/ice_main.c         |  1 +
 drivers/net/ethernet/intel/ice/ice_type.h         |  2 +-
 drivers/net/ethernet/intel/libie/Kconfig          |  9 +++++++++
 drivers/net/ethernet/intel/libie/Makefile         |  4 ++++
 .../intel/{ice/ice_fwlog.c => libie/fwlog.c}      | 15 ++++++++++++---
 include/linux/net/intel/libie/adminq.h            |  6 +++---
 .../linux/net/intel/libie/fwlog.h                 |  3 ++-
 9 files changed, 33 insertions(+), 9 deletions(-)
 rename drivers/net/ethernet/intel/{ice/ice_fwlog.c => libie/fwlog.c} (98%)
 rename drivers/net/ethernet/intel/ice/ice_fwlog.h => include/linux/net/intel/libie/fwlog.h (98%)

diff --git a/drivers/net/ethernet/intel/Kconfig b/drivers/net/ethernet/intel/Kconfig
index b05cc0d7a15d..09f0af386af1 100644
--- a/drivers/net/ethernet/intel/Kconfig
+++ b/drivers/net/ethernet/intel/Kconfig
@@ -297,6 +297,7 @@ config ICE
 	select DIMLIB
 	select LIBIE
 	select LIBIE_ADMINQ
+	select LIBIE_FWLOG
 	select NET_DEVLINK
 	select PACKING
 	select PLDMFW
diff --git a/drivers/net/ethernet/intel/ice/Makefile b/drivers/net/ethernet/intel/ice/Makefile
index d0f9c9492363..e8cd30da6d53 100644
--- a/drivers/net/ethernet/intel/ice/Makefile
+++ b/drivers/net/ethernet/intel/ice/Makefile
@@ -42,7 +42,6 @@ ice-y := ice_main.o	\
 	 ice_ethtool.o  \
 	 ice_repr.o	\
 	 ice_tc_lib.o	\
-	 ice_fwlog.o	\
 	 ice_debugfs.o  \
 	 ice_adapter.o
 ice-$(CONFIG_PCI_IOV) +=	\
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index c71540214396..533de50b6272 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -39,6 +39,7 @@ static const char ice_copyright[] = "Copyright (c) 2018, Intel Corporation.";
 MODULE_DESCRIPTION(DRV_SUMMARY);
 MODULE_IMPORT_NS("LIBIE");
 MODULE_IMPORT_NS("LIBIE_ADMINQ");
+MODULE_IMPORT_NS("LIBIE_FWLOG");
 MODULE_LICENSE("GPL v2");
 MODULE_FIRMWARE(ICE_DDP_PKG_FILE);
 
diff --git a/drivers/net/ethernet/intel/ice/ice_type.h b/drivers/net/ethernet/intel/ice/ice_type.h
index 14296bccc4c9..b0a1b67071c5 100644
--- a/drivers/net/ethernet/intel/ice/ice_type.h
+++ b/drivers/net/ethernet/intel/ice/ice_type.h
@@ -17,7 +17,7 @@
 #include "ice_protocol_type.h"
 #include "ice_sbq_cmd.h"
 #include "ice_vlan_mode.h"
-#include "ice_fwlog.h"
+#include <linux/net/intel/libie/fwlog.h>
 #include <linux/wait.h>
 #include <net/dscp.h>
 
diff --git a/drivers/net/ethernet/intel/libie/Kconfig b/drivers/net/ethernet/intel/libie/Kconfig
index e6072758e3d8..5dae7b40703b 100644
--- a/drivers/net/ethernet/intel/libie/Kconfig
+++ b/drivers/net/ethernet/intel/libie/Kconfig
@@ -14,3 +14,12 @@ config LIBIE_ADMINQ
 	help
 	  Helper functions used by Intel Ethernet drivers for administration
 	  queue command interface (aka adminq).
+
+config LIBIE_FWLOG
+	tristate "Intel firmware logging library (libie_fwlog)" if COMPILE_TEST
+	select LIBIE_ADMINQ
+	help
+	  Library to support firmware logging on device that have support
+	  for it. Firmware logging is using admin queue interface to communicate
+	  with the device. Debugfs is a user interface used to config logging
+	  and dump all collected logs.
diff --git a/drivers/net/ethernet/intel/libie/Makefile b/drivers/net/ethernet/intel/libie/Makefile
index e98f00b865d3..db57fc6780ea 100644
--- a/drivers/net/ethernet/intel/libie/Makefile
+++ b/drivers/net/ethernet/intel/libie/Makefile
@@ -8,3 +8,7 @@ libie-y			:= rx.o
 obj-$(CONFIG_LIBIE_ADMINQ) 	+= libie_adminq.o
 
 libie_adminq-y			:= adminq.o
+
+obj-$(CONFIG_LIBIE_FWLOG) 	+= libie_fwlog.o
+
+libie_fwlog-y			:= fwlog.o
diff --git a/drivers/net/ethernet/intel/ice/ice_fwlog.c b/drivers/net/ethernet/intel/libie/fwlog.c
similarity index 98%
rename from drivers/net/ethernet/intel/ice/ice_fwlog.c
rename to drivers/net/ethernet/intel/libie/fwlog.c
index e76397ade68b..dfc9a61d1565 100644
--- a/drivers/net/ethernet/intel/ice/ice_fwlog.c
+++ b/drivers/net/ethernet/intel/libie/fwlog.c
@@ -2,12 +2,14 @@
 /* Copyright (c) 2022, Intel Corporation. */
 
 #include <linux/debugfs.h>
+#include <linux/export.h>
 #include <linux/fs.h>
+#include <linux/net/intel/libie/fwlog.h>
+#include <linux/pci.h>
 #include <linux/random.h>
 #include <linux/vmalloc.h>
-#include "ice.h"
-#include "ice_common.h"
-#include "ice_fwlog.h"
+
+#define DEFAULT_SYMBOL_NAMESPACE	"LIBIE_FWLOG"
 
 /* create a define that has an extra module that doesn't really exist. this
  * is so we can add a module 'all' to easily enable/disable all the modules
@@ -1038,6 +1040,7 @@ int libie_fwlog_init(struct libie_fwlog *fwlog, struct libie_fwlog_api *api)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(libie_fwlog_init);
 
 /**
  * libie_fwlog_deinit - unroll FW logging configuration
@@ -1072,6 +1075,7 @@ void libie_fwlog_deinit(struct libie_fwlog *fwlog)
 		kfree(fwlog->ring.rings);
 	}
 }
+EXPORT_SYMBOL_GPL(libie_fwlog_deinit);
 
 /**
  * libie_get_fwlog_data - copy the FW log data from ARQ event
@@ -1096,6 +1100,7 @@ void libie_get_fwlog_data(struct libie_fwlog *fwlog, u8 *buf, u16 len)
 		libie_fwlog_ring_increment(&fwlog->ring.head, fwlog->ring.size);
 	}
 }
+EXPORT_SYMBOL_GPL(libie_get_fwlog_data);
 
 void libie_fwlog_reregister(struct libie_fwlog *fwlog)
 {
@@ -1105,3 +1110,7 @@ void libie_fwlog_reregister(struct libie_fwlog *fwlog)
 	if (libie_fwlog_register(fwlog))
 		fwlog->cfg.options &= ~LIBIE_FWLOG_OPTION_IS_REGISTERED;
 }
+EXPORT_SYMBOL_GPL(libie_fwlog_reregister);
+
+MODULE_DESCRIPTION("Intel(R) Ethernet common library");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/net/intel/libie/adminq.h b/include/linux/net/intel/libie/adminq.h
index 0df4c9326621..970b50fd898a 100644
--- a/include/linux/net/intel/libie/adminq.h
+++ b/include/linux/net/intel/libie/adminq.h
@@ -265,7 +265,7 @@ enum libie_aqc_fw_logging_mod {
 	LIBIE_AQC_FW_LOG_ID_TSDRV,
 	LIBIE_AQC_FW_LOG_ID_PFREG,
 	LIBIE_AQC_FW_LOG_ID_MDLVER,
-	LIBIE_AQC_FW_LOG_ID_MAX,
+	LIBIE_AQC_FW_LOG_ID_MAX
 };
 
 /* Set FW Logging configuration (indirect 0xFF30)
@@ -280,8 +280,8 @@ enum libie_aqc_fw_logging_mod {
 #define LIBIE_AQC_FW_LOG_AQ_REGISTER		BIT(0)
 #define LIBIE_AQC_FW_LOG_AQ_QUERY		BIT(2)
 
-#define LIBIE_AQC_FW_LOG_MIN_RESOLUTION		(1)
-#define LIBIE_AQC_FW_LOG_MAX_RESOLUTION		(128)
+#define LIBIE_AQC_FW_LOG_MIN_RESOLUTION		1
+#define LIBIE_AQC_FW_LOG_MAX_RESOLUTION		128
 
 struct libie_aqc_fw_log {
 	u8 cmd_flags;
diff --git a/drivers/net/ethernet/intel/ice/ice_fwlog.h b/include/linux/net/intel/libie/fwlog.h
similarity index 98%
rename from drivers/net/ethernet/intel/ice/ice_fwlog.h
rename to include/linux/net/intel/libie/fwlog.h
index e534205a2d04..36b13fabca9e 100644
--- a/drivers/net/ethernet/intel/ice/ice_fwlog.h
+++ b/include/linux/net/intel/libie/fwlog.h
@@ -3,7 +3,8 @@
 
 #ifndef _LIBIE_FWLOG_H_
 #define _LIBIE_FWLOG_H_
-#include "ice_adminq_cmd.h"
+
+#include <linux/net/intel/libie/adminq.h>
 
 /* Only a single log level should be set and all log levels under the set value
  * are enabled, e.g. if log level is set to LIBIE_FW_LOG_LEVEL_VERBOSE, then all
-- 
2.49.0


