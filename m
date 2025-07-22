Return-Path: <netdev+bounces-208897-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F002B0D7D3
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 13:09:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49423162B94
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 11:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FC492E498A;
	Tue, 22 Jul 2025 11:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hCgla07V"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86EB2E499D
	for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 11:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753182443; cv=none; b=EnSNylfDKnYfH6GX0tBH87QaQc5K900NrLO4bUfLCJGEq3RFHY8H0stg8DuAmWmTsWrImbJ7byHaaflFaEQEPEVtSACq6U7ZhbAoUXjjk0GsfLTvwxQUut2jctbf4jgqTajhsBJRXEHQfklZdfRuKREimnHcovCu/J2zYDgYQKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753182443; c=relaxed/simple;
	bh=rB/eUY56LJ6E1rjL1ukt+AIPsUp9C4JymH8zTl2WJsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JoKbDJZRXrCiceVZYP4I3CPRNVfH6H7Gqt08WTD77pC7UQFwCGlz4wbwLZqGrnCNyNbIYNkmVm3xMjpoVf5qtToN3/QdlQLLGXbReG9bvJyTnHzNAOmiVK9yiuoTvk0SQR38Z5Q5FpR0PaTkjC2FHxz5N9IZAiX+lDXws7whLSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hCgla07V; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753182442; x=1784718442;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rB/eUY56LJ6E1rjL1ukt+AIPsUp9C4JymH8zTl2WJsQ=;
  b=hCgla07VlNawNBqf2AhXiJlQdnoDCW6PIxjfXDipVXKl/6zke8tXz2U7
   ujwLs1A2ptOig3Ma94t/0yKquLT4IzLAZAznlFsldBzAXqGGzR1Q+mH3X
   uD1Jll7bT84acQ2Wbb31CYonoeCayAbQgGZ4Uuv9DvHm2OrtMw3arBR+l
   fk05l6ZVSjDWU3zkrt48Y4N76xpi1rR1phR/yHsUyjGIq2AEUlX8+SprZ
   1I3OojXEYWS8YjHdLbpq5sNZqizz7D/VMReHA/uFHz71+KWw6pYbslKAt
   FyqtjYzGe9kSF5x683YYVY15YIm6kyGtKh1V47CvT1bDzZfPLw7af3KJr
   w==;
X-CSE-ConnectionGUID: ZaHuPTypRMeqYQNCKi4hfA==
X-CSE-MsgGUID: Bhe/n13sS2enSsJ24ESaAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11499"; a="59083629"
X-IronPort-AV: E=Sophos;i="6.16,331,1744095600"; 
   d="scan'208";a="59083629"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 04:07:22 -0700
X-CSE-ConnectionGUID: 6SkRrNvYS1eoAarIHrkVMg==
X-CSE-MsgGUID: 2hlEQh9ZTSSDAY5J/Pw7aQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,331,1744095600"; 
   d="scan'208";a="163154014"
Received: from os-delivery.igk.intel.com ([10.102.21.165])
  by fmviesa003.fm.intel.com with ESMTP; 22 Jul 2025 04:07:20 -0700
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	przemyslaw.kitszel@intel.com,
	dawid.osuchowski@linux.intel.com,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: [PATCH iwl-next v1 14/15] ice, libie: move fwlog code to libie
Date: Tue, 22 Jul 2025 12:45:59 +0200
Message-ID: <20250722104600.10141-15-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250722104600.10141-1-michal.swiatkowski@linux.intel.com>
References: <20250722104600.10141-1-michal.swiatkowski@linux.intel.com>
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
 drivers/net/ethernet/intel/Kconfig                   |  1 +
 drivers/net/ethernet/intel/ice/Makefile              |  1 -
 drivers/net/ethernet/intel/ice/ice_main.c            |  1 +
 drivers/net/ethernet/intel/ice/ice_type.h            |  2 +-
 drivers/net/ethernet/intel/libie/Kconfig             |  7 +++++++
 drivers/net/ethernet/intel/libie/Makefile            |  4 ++++
 .../intel/{ice/ice_fwlog.c => libie/fwlog.c}         | 12 +++++++++---
 include/linux/net/intel/libie/adminq.h               |  6 +++---
 .../linux/net/intel/libie/fwlog.h                    |  3 ++-
 9 files changed, 28 insertions(+), 9 deletions(-)
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
index e307d72f05d3..d501e45eae62 100644
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
index 288415e48c05..4213a2b9fa9d 100644
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
index e6072758e3d8..679974797dcb 100644
--- a/drivers/net/ethernet/intel/libie/Kconfig
+++ b/drivers/net/ethernet/intel/libie/Kconfig
@@ -14,3 +14,10 @@ config LIBIE_ADMINQ
 	help
 	  Helper functions used by Intel Ethernet drivers for administration
 	  queue command interface (aka adminq).
+
+config LIBIE_FWLOG
+	tristate
+	select LIBIE_ADMINQ
+	help
+	  Library to support firmware logging on device that have support
+	  for it.
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
index e76397ade68b..2cc41bbcbead 100644
--- a/drivers/net/ethernet/intel/ice/ice_fwlog.c
+++ b/drivers/net/ethernet/intel/libie/fwlog.c
@@ -3,11 +3,10 @@
 
 #include <linux/debugfs.h>
 #include <linux/fs.h>
+#include <linux/net/intel/libie/fwlog.h>
+#include <linux/pci.h>
 #include <linux/random.h>
 #include <linux/vmalloc.h>
-#include "ice.h"
-#include "ice_common.h"
-#include "ice_fwlog.h"
 
 /* create a define that has an extra module that doesn't really exist. this
  * is so we can add a module 'all' to easily enable/disable all the modules
@@ -1038,6 +1037,7 @@ int libie_fwlog_init(struct libie_fwlog *fwlog, struct libie_fwlog_api *api)
 
 	return 0;
 }
+EXPORT_SYMBOL_NS_GPL(libie_fwlog_init, "LIBIE_FWLOG");
 
 /**
  * libie_fwlog_deinit - unroll FW logging configuration
@@ -1072,6 +1072,7 @@ void libie_fwlog_deinit(struct libie_fwlog *fwlog)
 		kfree(fwlog->ring.rings);
 	}
 }
+EXPORT_SYMBOL_NS_GPL(libie_fwlog_deinit, "LIBIE_FWLOG");
 
 /**
  * libie_get_fwlog_data - copy the FW log data from ARQ event
@@ -1096,6 +1097,7 @@ void libie_get_fwlog_data(struct libie_fwlog *fwlog, u8 *buf, u16 len)
 		libie_fwlog_ring_increment(&fwlog->ring.head, fwlog->ring.size);
 	}
 }
+EXPORT_SYMBOL_NS_GPL(libie_get_fwlog_data, "LIBIE_FWLOG");
 
 void libie_fwlog_reregister(struct libie_fwlog *fwlog)
 {
@@ -1105,3 +1107,7 @@ void libie_fwlog_reregister(struct libie_fwlog *fwlog)
 	if (libie_fwlog_register(fwlog))
 		fwlog->cfg.options &= ~LIBIE_FWLOG_OPTION_IS_REGISTERED;
 }
+EXPORT_SYMBOL_NS_GPL(libie_fwlog_reregister, "LIBIE_FWLOG");
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


