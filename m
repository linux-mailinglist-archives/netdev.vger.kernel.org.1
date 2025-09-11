Return-Path: <netdev+bounces-222325-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77FC0B53D7F
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 23:07:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64502566B41
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 21:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21EE92E06E6;
	Thu, 11 Sep 2025 21:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fIsGlyAm"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB4D2DFA2E
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 21:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757624750; cv=none; b=hgrLjtcYy4gPo5B3LkvN7+GdHyZFtPd++Y3MgXAjiBi2Lc0qqwHUh2PJ1VxYhJRyDugCA+0eE+q1zm9QgPgpu01Gk5cuy+nqituA/KebusSo5YMk9OqyP+ml4+dnr9lhrnoTWFulX8sQvgRH/hetuocLMZr0k74PoEWbYL2+06w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757624750; c=relaxed/simple;
	bh=cymlQmtsE5tyorvuRHSlLODK/3S7iRInXjdsmXVfSko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HkJ0e5OVJ0c7mrCraxXG+Igs0WSsrBDAyGrEG3cngbwqzoGFJkxYiDi3YLhhyblh4flw1vOvhsPEanVVfVXRdtQbHXvykahRerHFZc7XKXw0MkTxHRtgr5qrzr5v0euhsCE+Yk9YzkgeXSFfaOWpeJgzlv7cb6wswALCfSu2Fro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fIsGlyAm; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757624749; x=1789160749;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cymlQmtsE5tyorvuRHSlLODK/3S7iRInXjdsmXVfSko=;
  b=fIsGlyAmgq5w+MLPJKMz8Lx7bIKbrlrecew2Lbzqg0Y4pfE1Y3hSsgUG
   8p2sqv2PLgzU2Xkwyb4P7+Zc968QCNh121ZoU3hWtFIRHYfgRZ90kcIfh
   /3E1mBb5n4zUzfYp4SRtrendwDHxR1yq0yuaF5AohG1BhlgB5MlvGyEq0
   LN2g/5d9NLlJwyy6imhIVrpEEDIyRWDN3GGqCgPZInGgMxCO2wcdhNvX8
   y+z1ZM5fykFnL0OpOrDapOnKcEE7nFW9hs/key6ViiOz7bHfZX8eVv182
   Zi8Iq9UTg7u1o5iR9/LJfcrzi1/ttrOiHlC6xJxpO8A0qzx21xelPhcsF
   A==;
X-CSE-ConnectionGUID: kmFCOUq8TUWe6GvuvkCseQ==
X-CSE-MsgGUID: TiYVv+GhTkaNpNpTjZlHiQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="82558969"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="82558969"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2025 14:05:48 -0700
X-CSE-ConnectionGUID: L639Q1YvSr6Rr2GYEDsXAA==
X-CSE-MsgGUID: J+sMbEVJTQi79pap+SxVwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,258,1751266800"; 
   d="scan'208";a="174583470"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa010.fm.intel.com with ESMTP; 11 Sep 2025 14:05:47 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	anthony.l.nguyen@intel.com,
	aleksander.lobakin@intel.com,
	przemyslaw.kitszel@intel.com,
	dawid.osuchowski@linux.intel.com,
	horms@kernel.org,
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH net-next 14/15] ice, libie: move fwlog code to libie
Date: Thu, 11 Sep 2025 14:05:13 -0700
Message-ID: <20250911210525.345110-15-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250911210525.345110-1-anthony.l.nguyen@intel.com>
References: <20250911210525.345110-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Move whole code from ice_fwlog.c/h to libie/fwlog.c/h.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
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
index eac45d7c0cf1..5b2c666496e7 100644
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
index 44e184c6c416..f0d3aee24a93 100644
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
index e6072758e3d8..70831c7e336e 100644
--- a/drivers/net/ethernet/intel/libie/Kconfig
+++ b/drivers/net/ethernet/intel/libie/Kconfig
@@ -14,3 +14,12 @@ config LIBIE_ADMINQ
 	help
 	  Helper functions used by Intel Ethernet drivers for administration
 	  queue command interface (aka adminq).
+
+config LIBIE_FWLOG
+	tristate
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
index 8e7086191030..f39cc11cb7c5 100644
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
@@ -1037,6 +1039,7 @@ int libie_fwlog_init(struct libie_fwlog *fwlog, struct libie_fwlog_api *api)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(libie_fwlog_init);
 
 /**
  * libie_fwlog_deinit - unroll FW logging configuration
@@ -1071,6 +1074,7 @@ void libie_fwlog_deinit(struct libie_fwlog *fwlog)
 		kfree(fwlog->ring.rings);
 	}
 }
+EXPORT_SYMBOL_GPL(libie_fwlog_deinit);
 
 /**
  * libie_get_fwlog_data - copy the FW log data from ARQ event
@@ -1095,6 +1099,7 @@ void libie_get_fwlog_data(struct libie_fwlog *fwlog, u8 *buf, u16 len)
 		libie_fwlog_ring_increment(&fwlog->ring.head, fwlog->ring.size);
 	}
 }
+EXPORT_SYMBOL_GPL(libie_get_fwlog_data);
 
 void libie_fwlog_reregister(struct libie_fwlog *fwlog)
 {
@@ -1104,3 +1109,7 @@ void libie_fwlog_reregister(struct libie_fwlog *fwlog)
 	if (libie_fwlog_register(fwlog))
 		fwlog->cfg.options &= ~LIBIE_FWLOG_OPTION_IS_REGISTERED;
 }
+EXPORT_SYMBOL_GPL(libie_fwlog_reregister);
+
+MODULE_DESCRIPTION("Intel(R) Ethernet common library");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/net/intel/libie/adminq.h b/include/linux/net/intel/libie/adminq.h
index 29420193889a..ab13bd777a28 100644
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
2.47.1


