Return-Path: <netdev+bounces-181179-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02995A83FF6
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 12:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABF001B82D6A
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 10:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86BCF27C14D;
	Thu, 10 Apr 2025 10:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kWqZFr/j"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B95279338
	for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 10:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744279300; cv=none; b=HogSWunXfDriqLBXIOXor8sxKUR5gFLDLvDKcS7niike925xR9OQcsFxE17Echw8FqjZPKQVNd/3wW0cT4XS9N4YD+QifiUUqORToFtPAZmR8Fwj+vxbirGT+51WiiJuo8Hnj3Ppuyokj4818hFQUgsLLMd4SQjxp+K02upTosU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744279300; c=relaxed/simple;
	bh=GNdUSs8oh/thvERmuTya+pDN15XjoQ+57AH97V3Yb+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dk8ygD0O/Xmqa4hlOu9K5TDNDppqJ0wABNP9n58ExFMrJsBPFW36kuIxRvBZmBzStl0HM/bzgg384EUqm4qZr2YTgZRBZcpndwmeVDhUjksECNjtsymyO1wkfyJ8XYPXBjKlBcCLL36w5qfmi+8LsfInk+Xqlu2KWgXi89onhas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kWqZFr/j; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744279298; x=1775815298;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GNdUSs8oh/thvERmuTya+pDN15XjoQ+57AH97V3Yb+0=;
  b=kWqZFr/jLHy/GZXbC/31mFqZ8oV7nscjoPiupsHO5WtQYDxw1oSlR+xc
   DfbLbUx0hUgWcQkT4G2+GF6MFdgaEnZb1u/cmz4tGRU4pBs2oYS5nDa1y
   V3B0B2qXSOelU0Uh1xyDBfhs7tOn+20GJqPBUnWdxQUYyx9kS+K511SJq
   N8vU1W17At/p9PdqKu77WCMv2P5eaS34tC6yv+sLrD8k22gW468eFtaQ6
   52VZHRjPajzTazpf08Mwa7yRsifqZ/mAKwrMjOJN61HRLpmBW4MD5s5ma
   SMamEA2A3YqMDfeG/ZclcUSTt//L1ZYD5d0pZ4ElPBxo1IojUw6ACrNKl
   A==;
X-CSE-ConnectionGUID: +kZqge4vTZyB8emD3GeDVg==
X-CSE-MsgGUID: ZNiMjI/NTKu6MeKIkHdGNQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11399"; a="63183910"
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; 
   d="scan'208";a="63183910"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 03:01:38 -0700
X-CSE-ConnectionGUID: 6UGYSyQdTD69AeclcCjX6w==
X-CSE-MsgGUID: pMuOyp1fTTa9U4tujiSrPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; 
   d="scan'208";a="159819751"
Received: from gk3153-dr2-r750-36946.igk.intel.com ([10.102.20.192])
  by fmviesa001.fm.intel.com with ESMTP; 10 Apr 2025 03:01:36 -0700
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	aleksander.lobakin@intel.com,
	przemyslaw.kitszel@intel.com,
	piotr.kwapulinski@intel.com,
	aleksandr.loktionov@intel.com,
	jedrzej.jagielski@intel.com,
	larysa.zaremba@intel.com,
	anthony.l.nguyen@intel.com
Subject: [iwl-next v2 5/8] libie: add adminq helper for converting err to str
Date: Thu, 10 Apr 2025 12:01:18 +0200
Message-ID: <20250410100121.2353754-6-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20250410100121.2353754-1-michal.swiatkowski@linux.intel.com>
References: <20250410100121.2353754-1-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new module for common handling of Admin Queue related logic.
Start by a helper for error to string conversion. This lives inside
libie/, but is a separate module what follows our logic of splitting
into topical modules, to avoid pulling in not needed stuff, and have
better organization in general.

Olek suggested how to better solve the error to string conversion.

It will be used in follow-up patches in ice, i40e and iavf.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Suggested-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/intel/libie/Kconfig  |  6 +++
 drivers/net/ethernet/intel/libie/Makefile |  4 ++
 include/linux/net/intel/libie/adminq.h    |  2 +
 drivers/net/ethernet/intel/libie/adminq.c | 50 +++++++++++++++++++++++
 4 files changed, 62 insertions(+)
 create mode 100644 drivers/net/ethernet/intel/libie/adminq.c

diff --git a/drivers/net/ethernet/intel/libie/Kconfig b/drivers/net/ethernet/intel/libie/Kconfig
index 33aff6bc8f81..e6072758e3d8 100644
--- a/drivers/net/ethernet/intel/libie/Kconfig
+++ b/drivers/net/ethernet/intel/libie/Kconfig
@@ -8,3 +8,9 @@ config LIBIE
 	  libie (Intel Ethernet library) is a common library built on top of
 	  libeth and containing vendor-specific routines shared between several
 	  Intel Ethernet drivers.
+
+config LIBIE_ADMINQ
+	tristate
+	help
+	  Helper functions used by Intel Ethernet drivers for administration
+	  queue command interface (aka adminq).
diff --git a/drivers/net/ethernet/intel/libie/Makefile b/drivers/net/ethernet/intel/libie/Makefile
index ffd27fab916a..e98f00b865d3 100644
--- a/drivers/net/ethernet/intel/libie/Makefile
+++ b/drivers/net/ethernet/intel/libie/Makefile
@@ -4,3 +4,7 @@
 obj-$(CONFIG_LIBIE)	+= libie.o
 
 libie-y			:= rx.o
+
+obj-$(CONFIG_LIBIE_ADMINQ) 	+= libie_adminq.o
+
+libie_adminq-y			:= adminq.o
diff --git a/include/linux/net/intel/libie/adminq.h b/include/linux/net/intel/libie/adminq.h
index f8b3194b0742..92ec15f308b2 100644
--- a/include/linux/net/intel/libie/adminq.h
+++ b/include/linux/net/intel/libie/adminq.h
@@ -301,4 +301,6 @@ static inline void *libie_aq_raw(struct libie_aq_desc *desc)
 	return &desc->params.raw;
 }
 
+const char *libie_aq_str(enum libie_aq_err err);
+
 #endif /* __LIBIE_ADMINQ_H */
diff --git a/drivers/net/ethernet/intel/libie/adminq.c b/drivers/net/ethernet/intel/libie/adminq.c
new file mode 100644
index 000000000000..6c95619d1f2b
--- /dev/null
+++ b/drivers/net/ethernet/intel/libie/adminq.c
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (C) 2025 Intel Corporation */
+
+#include <linux/module.h>
+#include <linux/net/intel/libie/adminq.h>
+
+static const char * const libie_aq_str_arr[] = {
+#define LIBIE_AQ_STR(x)					\
+	[LIBIE_AQ_RC_##x]	= "LIBIE_AQ_RC" #x
+	LIBIE_AQ_STR(OK),
+	LIBIE_AQ_STR(EPERM),
+	LIBIE_AQ_STR(ENOENT),
+	LIBIE_AQ_STR(ESRCH),
+	LIBIE_AQ_STR(EIO),
+	LIBIE_AQ_STR(EAGAIN),
+	LIBIE_AQ_STR(ENOMEM),
+	LIBIE_AQ_STR(EACCES),
+	LIBIE_AQ_STR(EBUSY),
+	LIBIE_AQ_STR(EEXIST),
+	LIBIE_AQ_STR(EINVAL),
+	LIBIE_AQ_STR(ENOSPC),
+	LIBIE_AQ_STR(ENOSYS),
+	LIBIE_AQ_STR(EMODE),
+	LIBIE_AQ_STR(ENOSEC),
+	LIBIE_AQ_STR(EBADSIG),
+	LIBIE_AQ_STR(ESVN),
+	LIBIE_AQ_STR(EBADMAN),
+	LIBIE_AQ_STR(EBADBUF),
+#undef LIBIE_AQ_STR
+	"LIBIE_AQ_RC_UNKNOWN",
+};
+
+#define __LIBIE_AQ_STR_NUM (ARRAY_SIZE(libie_aq_str_arr) - 1)
+
+/**
+ * libie_aq_str - get error string based on aq error
+ * @err: admin queue error type
+ */
+const char *libie_aq_str(enum libie_aq_err err)
+{
+	if (err >= ARRAY_SIZE(libie_aq_str_arr) ||
+	    !libie_aq_str_arr[err])
+		err = __LIBIE_AQ_STR_NUM;
+
+	return libie_aq_str_arr[err];
+}
+EXPORT_SYMBOL_NS_GPL(libie_aq_str, "LIBIE_ADMINQ");
+
+MODULE_DESCRIPTION("Intel(R) Ethernet common library - adminq helpers");
+MODULE_LICENSE("GPL");
-- 
2.42.0


