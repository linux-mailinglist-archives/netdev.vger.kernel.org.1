Return-Path: <netdev+bounces-185854-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68190A9BE72
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 08:08:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E7153AF6E0
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 06:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B64A22B8B9;
	Fri, 25 Apr 2025 06:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k+iGL1ee"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA17122C34A
	for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 06:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745561311; cv=none; b=e0ec+WzGqYkRHwF9FSPRco70rIgOYQtxAHzuP+C9VFM99ccoijFFNC0mAiK1mtZirgZD5BK8qpp5+FYBwDtizdCVmxEnAaJTvtLvRrBk0rUtFCorBhf5buSgP26vInmy0e8Huegwm+DWNvGBSiLjW7WgB4e7t3MV3oY5dXtlNFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745561311; c=relaxed/simple;
	bh=ivqr/h7pnRe28nJQTWu+qhpH6A/QCdxCMJRiBxIoaEk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jby6vxosfoKwUuNw2ICs6WODlr7d6f/Eb2Bnn7Qlm6KfC5PCdCQpBVYaIpewc6mQC8pWPOj6UTZEtAaXn840YzwV6Q498hSHO/AKez6o9ZmlwRvuI4aB9jLZs1Cnh/1L92EXBHWifcQXHLSLj/sKRMqs9AMhPD4w+Xb74ODOtEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k+iGL1ee; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745561308; x=1777097308;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ivqr/h7pnRe28nJQTWu+qhpH6A/QCdxCMJRiBxIoaEk=;
  b=k+iGL1eeLHt9jCx0FHVTtphrzh422uRX+s3on2uLlqFaxCwEupTlOu+l
   TJSYgOwiBvGsuok9G8chpb4qlPXhsuTTy9DInX6+U1oAiitzPKxFuN0Hl
   qllFWiH/reXk669j2/msku+a7DiPcPSaVYikVhkrJcvW6WFysINmZ2pFP
   +yBDtDJqT3uYAOAq93tAJ/BVX9xX27D2zjtoSe7AmZf5mOX/HNTjcsPe+
   AXFnycHBN+s8Mp4SndX1vY8bt9y8jTCmrtSeiU//Uup6Myx0Lfita4Zd7
   FpvO+RNjap29/TWSOdG0q1ejUc1FTbEGcMF8MbD4gEva6yjyJZxcGQnQg
   w==;
X-CSE-ConnectionGUID: GvSIMtpyTvyKjoDwVBJrjQ==
X-CSE-MsgGUID: zrTY7g78Ro2i2KtiqLbRKg==
X-IronPort-AV: E=McAfee;i="6700,10204,11413"; a="58578915"
X-IronPort-AV: E=Sophos;i="6.15,238,1739865600"; 
   d="scan'208";a="58578915"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 23:08:27 -0700
X-CSE-ConnectionGUID: HGo+9RhaTF2IkobJr9RnuQ==
X-CSE-MsgGUID: ME/HMHgBS7mZ0QCPfWtKjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,238,1739865600"; 
   d="scan'208";a="132703186"
Received: from gk3153-dr2-r750-36946.igk.intel.com ([10.102.20.192])
  by orviesa010.jf.intel.com with ESMTP; 24 Apr 2025 23:08:26 -0700
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
Subject: [iwl-next v3 5/8] libie: add adminq helper for converting err to str
Date: Fri, 25 Apr 2025 08:08:06 +0200
Message-ID: <20250425060809.3966772-6-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20250425060809.3966772-1-michal.swiatkowski@linux.intel.com>
References: <20250425060809.3966772-1-michal.swiatkowski@linux.intel.com>
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
 drivers/net/ethernet/intel/libie/adminq.c | 52 +++++++++++++++++++++++
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
diff --git a/include/linux/net/intel/libie/adminq.h b/include/linux/net/intel/libie/adminq.h
index 989de2eb6d19..1dd5d5924aee 100644
--- a/include/linux/net/intel/libie/adminq.h
+++ b/include/linux/net/intel/libie/adminq.h
@@ -304,4 +304,6 @@ static inline void *libie_aq_raw(struct libie_aq_desc *desc)
 	return &desc->params.raw;
 }
 
+const char *libie_aq_str(enum libie_aq_err err);
+
 #endif /* __LIBIE_ADMINQ_H */
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
-- 
2.42.0


