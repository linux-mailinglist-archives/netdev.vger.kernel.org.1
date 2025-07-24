Return-Path: <netdev+bounces-209839-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20956B110E2
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 20:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03A33AC7C8C
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 18:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 787472ED14B;
	Thu, 24 Jul 2025 18:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RjlQ0Yxj"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7762ECE98
	for <netdev@vger.kernel.org>; Thu, 24 Jul 2025 18:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753381724; cv=none; b=tirHbOfyB1hViSlbWMl/erZm2Jc2SH3kj98jsVC6jv+9e/YR6LEwuR8QZgIYOvBO8+vmgh9Skm8pXLp8UkAYDQAp/hFvnzK00/koP3WlYlM8PFZOVWHxKED28YuHR9qeS59UC9djMJaPgngm+8g8Es3XAT95UL1ffJBU6DU3SNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753381724; c=relaxed/simple;
	bh=f5GNzPfscaBdPd/EtZMSNAhM0TCUoYAlpF+MIfh7kmc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vARw18ZlrenYb5n9kvLQpKvnwDuILIh3iOd2IEI1ZqmRgRx7VB5Xl35iPWTzAbJx0QipER5UwkizJExrKW7AZO1t6STuaCGOFQevvWyCbg4sOtd358cu7cOAMuMuKCCQFV+bhERW14HS83KvPlXf/sakgZIiyp1JVNS4y5Ka2gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RjlQ0Yxj; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753381723; x=1784917723;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=f5GNzPfscaBdPd/EtZMSNAhM0TCUoYAlpF+MIfh7kmc=;
  b=RjlQ0YxjCHMlE1nqXD7xdplC2i1TA9GZifECxY8Nl7ukM7fSCsYwBSrN
   QKX6rjn+R5u/casWnOVAz4d8Atqmz6Hf6Za/7aHKUPzusduH8p+uyOlhu
   cpb96ZNZUan9EcI3GZpKHGJuXCgOFEJdfQ9AD87ujpUI3sP2wO5XbYMmL
   R8bbdrkptkq661JFrFd424TGCP+F31jW+g4img0TcONYsVtDvYrlKl0ZH
   oGNI1qCxttHuXD/qnvouYXqOQX/YNMDYnqnfEHZioxekwOIFu450+ZnF4
   2uyWp0VHTTM2Bt7LPYbDR4xvEjCFI41tCioixjPDGUETPKls1I71aOabF
   A==;
X-CSE-ConnectionGUID: bSGEhvkVThKY/a1Vqs5OfQ==
X-CSE-MsgGUID: tmBtGzUaRneD5vmxm3VDaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="55861386"
X-IronPort-AV: E=Sophos;i="6.16,337,1744095600"; 
   d="scan'208";a="55861386"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2025 11:28:38 -0700
X-CSE-ConnectionGUID: +8CcKvxESJ6aIqjJsRbLFQ==
X-CSE-MsgGUID: EZXBDbTLQaa4vxD/Rrl4oA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,337,1744095600"; 
   d="scan'208";a="161096504"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa010.fm.intel.com with ESMTP; 24 Jul 2025 11:28:37 -0700
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
	piotr.kwapulinski@intel.com,
	aleksandr.loktionov@intel.com,
	jedrzej.jagielski@intel.com,
	larysa.zaremba@intel.com
Subject: [PATCH net-next 5/8] libie: add adminq helper for converting err to str
Date: Thu, 24 Jul 2025 11:28:21 -0700
Message-ID: <20250724182826.3758850-6-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250724182826.3758850-1-anthony.l.nguyen@intel.com>
References: <20250724182826.3758850-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

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
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/libie/Kconfig  |  6 +++
 drivers/net/ethernet/intel/libie/Makefile |  4 ++
 drivers/net/ethernet/intel/libie/adminq.c | 52 +++++++++++++++++++++++
 include/linux/net/intel/libie/adminq.h    |  2 +
 4 files changed, 64 insertions(+)
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
diff --git a/drivers/net/ethernet/intel/libie/adminq.c b/drivers/net/ethernet/intel/libie/adminq.c
new file mode 100644
index 000000000000..55356548e3f0
--- /dev/null
+++ b/drivers/net/ethernet/intel/libie/adminq.c
@@ -0,0 +1,52 @@
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
+ *
+ * Return: error string for passed error code
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
diff --git a/include/linux/net/intel/libie/adminq.h b/include/linux/net/intel/libie/adminq.h
index bab7cecc657f..012b5d499c1a 100644
--- a/include/linux/net/intel/libie/adminq.h
+++ b/include/linux/net/intel/libie/adminq.h
@@ -303,4 +303,6 @@ static inline void *libie_aq_raw(struct libie_aq_desc *desc)
 	return &desc->params.raw;
 }
 
+const char *libie_aq_str(enum libie_aq_err err);
+
 #endif /* __LIBIE_ADMINQ_H */
-- 
2.47.1


