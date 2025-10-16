Return-Path: <netdev+bounces-229921-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A66BE211B
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 10:01:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03D8E1A60468
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 08:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50042284B2E;
	Thu, 16 Oct 2025 08:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BlLbutCj"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE83D1A2C11
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 08:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760601662; cv=none; b=aAiYSASXI2mGO+1Fg6jaLox92yIaQHI8Nwjaa43a96U43p5gIDXTCxo3uAkTu9o14zK87DzRPclnDw/noAUBs2jcagZDoyRBvxjVnCCo68TXJEQvI5bv8r5w+yqhHTJgWn2er8ZXuspJ8wI/+JkdDLp8JmSP+bm49lx1ZA7uU5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760601662; c=relaxed/simple;
	bh=h+tjwbov4toO89eFNGZs8DnejPpuFk+UUy6nIXggJB4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i3TtKZb5tpjUR/9oKTLQZka9PIEQz3te83514jYN5iR5xXFiiXE3/aycuYRzNwxOb2zxhUZA/hDzoKxMMINu4cKdrxCLfIBaNXIDRban3zGomFHia+xk/Vsc3NQoF7yG7Xsq1FW5mAg5D8ggGcQ0hhkTieS4rZ9zZTp1wyTQ9XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BlLbutCj; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760601660; x=1792137660;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=h+tjwbov4toO89eFNGZs8DnejPpuFk+UUy6nIXggJB4=;
  b=BlLbutCj26sEkkVAoXPKmDUV2yGek8KOUutK2HhZ92SFuK4JTaQYvTu2
   LG7Be4aqva9EOvvT/0BaFSo+GTpJeDSjgrSmupxgP4INYeh9OJlqNX76h
   B+7paQWi7uI0PDTPBvdqoN+DyC82rKS4Vdk7GXsgu9arB6eydMReXjCgV
   DGO0RN7m2Yeg9Ycyw0UJJrH1Vl8JVe/fry7rjbwbTU3o7zPRIMWRF+0gt
   cTuvxcyFBaULeU1KRws2WMPZL4XDVGSuU1YFKvgAOqgGJA5XbOEEhgGBV
   bHZ3b8YEe/Gl5UlHmfqbCqKFNfnaQ8PCUq92JwLC25EbXZwYhCTzQ2fwK
   g==;
X-CSE-ConnectionGUID: /6AyeFZmR5WGj3KM3NZ+aw==
X-CSE-MsgGUID: V3ccV/u5RwC8zZihXA47MA==
X-IronPort-AV: E=McAfee;i="6800,10657,11583"; a="73070701"
X-IronPort-AV: E=Sophos;i="6.19,233,1754982000"; 
   d="scan'208";a="73070701"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2025 01:00:59 -0700
X-CSE-ConnectionGUID: s3aezF74Q5urookK9cQ8Sw==
X-CSE-MsgGUID: 4LOPsJF4R0WMZS9Zy3qUwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,233,1754982000"; 
   d="scan'208";a="212986455"
Received: from os-delivery.igk.intel.com ([10.102.21.165])
  by orviesa002.jf.intel.com with ESMTP; 16 Oct 2025 01:00:55 -0700
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	jacob.e.keller@intel.com,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH iwl-net v2] libie: depend on DEBUG_FS when building LIBIE_FWLOG
Date: Thu, 16 Oct 2025 09:29:40 +0200
Message-ID: <20251016072940.1661485-1-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

LIBIE_FWLOG is unusable without DEBUG_FS. Mark it in Kconfig.

Fix build error on ixgbe when DEBUG_FS is not set. To not add another
layer of #if IS_ENABLED(LIBIE_FWLOG) in ixgbe fwlog code define debugfs
dentry even when DEBUG_FS isn't enabled. In this case the dummy
functions of LIBIE_FWLOG will be used, so not initialized dentry isn't a
problem.

Fixes: 641585bc978e ("ixgbe: fwlog support for e610")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Closes: https://lore.kernel.org/lkml/f594c621-f9e1-49f2-af31-23fbcb176058@roeck-us.net/
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
v1 --> v2 [1]:
 * add DEBUG_FS dependency in LIBIE_FWLOG

[1] https://lore.kernel.org/netdev/20251014141110.751104-1-michal.swiatkowski@linux.intel.com/
---
 drivers/net/ethernet/intel/Kconfig       |  4 ++--
 drivers/net/ethernet/intel/ixgbe/ixgbe.h |  2 --
 include/linux/net/intel/libie/fwlog.h    | 12 ++++++++++++
 3 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/Kconfig b/drivers/net/ethernet/intel/Kconfig
index a563a94e2780..122ee23497e6 100644
--- a/drivers/net/ethernet/intel/Kconfig
+++ b/drivers/net/ethernet/intel/Kconfig
@@ -146,7 +146,7 @@ config IXGBE
 	tristate "Intel(R) 10GbE PCI Express adapters support"
 	depends on PCI
 	depends on PTP_1588_CLOCK_OPTIONAL
-	select LIBIE_FWLOG
+	select LIBIE_FWLOG if DEBUG_FS
 	select MDIO
 	select NET_DEVLINK
 	select PLDMFW
@@ -298,7 +298,7 @@ config ICE
 	select DIMLIB
 	select LIBIE
 	select LIBIE_ADMINQ
-	select LIBIE_FWLOG
+	select LIBIE_FWLOG if DEBUG_FS
 	select NET_DEVLINK
 	select PACKING
 	select PLDMFW
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
index 14d275270123..dce4936708eb 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
@@ -821,9 +821,7 @@ struct ixgbe_adapter {
 #ifdef CONFIG_IXGBE_HWMON
 	struct hwmon_buff *ixgbe_hwmon_buff;
 #endif /* CONFIG_IXGBE_HWMON */
-#ifdef CONFIG_DEBUG_FS
 	struct dentry *ixgbe_dbg_adapter;
-#endif /*CONFIG_DEBUG_FS*/
 
 	u8 default_up;
 	/* Bitmask indicating in use pools */
diff --git a/include/linux/net/intel/libie/fwlog.h b/include/linux/net/intel/libie/fwlog.h
index 36b13fabca9e..7273c78c826b 100644
--- a/include/linux/net/intel/libie/fwlog.h
+++ b/include/linux/net/intel/libie/fwlog.h
@@ -78,8 +78,20 @@ struct libie_fwlog {
 	);
 };
 
+#if IS_ENABLED(CONFIG_LIBIE_FWLOG)
 int libie_fwlog_init(struct libie_fwlog *fwlog, struct libie_fwlog_api *api);
 void libie_fwlog_deinit(struct libie_fwlog *fwlog);
 void libie_fwlog_reregister(struct libie_fwlog *fwlog);
 void libie_get_fwlog_data(struct libie_fwlog *fwlog, u8 *buf, u16 len);
+#else
+static inline int libie_fwlog_init(struct libie_fwlog *fwlog,
+				   struct libie_fwlog_api *api)
+{
+	return -EOPNOTSUPP;
+}
+static inline void libie_fwlog_deinit(struct libie_fwlog *fwlog) { }
+static inline void libie_fwlog_reregister(struct libie_fwlog *fwlog) { }
+static inline void libie_get_fwlog_data(struct libie_fwlog *fwlog, u8 *buf,
+					u16 len) { }
+#endif /* CONFIG_LIBIE_FWLOG */
 #endif /* _LIBIE_FWLOG_H_ */
-- 
2.49.0


