Return-Path: <netdev+bounces-112863-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04CCD93B89C
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 23:37:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3558E1C21380
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 21:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5146213BC31;
	Wed, 24 Jul 2024 21:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UR9X5uvd"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6C413AD1C
	for <netdev@vger.kernel.org>; Wed, 24 Jul 2024 21:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721857010; cv=none; b=MvCS79R1VElJrNiw5b1me8MeTQlN3YuApvnTaYjpjrg2fkN1r3ka0TCkz/YkXDO7+O6l7ytxhllj88oBERPMqv4HOCWNoBGf44vIFVMLTg2VFhTIeME4exfYJmOlF1qlQS2uj/JbYAN5W6OGUqAwPj4xyXt+FU1OOZbQWjv8hY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721857010; c=relaxed/simple;
	bh=5HTR/X/1lSpbqPeK6JkppMWhWLXNO76FZlDOQgbCH8I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cU3DKrUtMJjnnw3Fit3M1nUlmfG4zu6HizyMMKpD1CkjsFlDkZPk6+7o9nVXzQTXo5jfERPaEMHdhGwULBb1G1m+DvwhJaoSc9z0sVwqZN9q1Qm3H8jpFyG+s0GcEZursAUTahFcNwJJjXQlGB+zmfxiz4FGlUUuSzlvFnrTZS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UR9X5uvd; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721857008; x=1753393008;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5HTR/X/1lSpbqPeK6JkppMWhWLXNO76FZlDOQgbCH8I=;
  b=UR9X5uvdzyAKmi+HI+ZEydA6Pujz8RvIkTgQHgpnqnNSnEcAH0+VP4/F
   /VBRK1PaELsSbjaapKVxM+QP2S8OlKoq+ZhcqT7YpsNCNeAZnHwWtpYwJ
   SxYozwwHvZA0n6LPBG0ZRljaXtEWrCYnf9i209H08dJ2YRD69+tAaVhQr
   Bo3dZ/gBWkM+uYfc4czQtTVWV7UZ8k8ggwe8lZfy9umytuTC0IrIi4ERC
   3GhZcgN6656E8yMTAT2LOCpT1KLPJxG4mNlomz0MRYKcvI+oDZg6OYr1J
   4YskczmYCFNEMpsjBSDQnPenKbd/yxQ3jqCwLHTT2tN5jzjz3mHBPItfC
   Q==;
X-CSE-ConnectionGUID: /plPF1OeSxCg9Gx3U8DehA==
X-CSE-MsgGUID: TwGygspNRaenTP9BuJf5TA==
X-IronPort-AV: E=McAfee;i="6700,10204,11143"; a="19704082"
X-IronPort-AV: E=Sophos;i="6.09,233,1716274800"; 
   d="scan'208";a="19704082"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2024 14:36:48 -0700
X-CSE-ConnectionGUID: +zei5UrqSRyQb7phcSMN9g==
X-CSE-MsgGUID: H8POyxncSCKkEpLoTEHu+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,233,1716274800"; 
   d="scan'208";a="52579493"
Received: from bergbenj-mobl1.ger.corp.intel.com (HELO azaki-desk1.intel.com) ([10.245.246.206])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2024 14:36:42 -0700
From: Ahmed Zaki <ahmed.zaki@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	horms@kernel.org,
	przemyslaw.kitszel@intel.com,
	Junfeng Guo <junfeng.guo@intel.com>,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH iwl-next v4 01/13] ice: add parser create and destroy skeleton
Date: Wed, 24 Jul 2024 15:36:10 -0600
Message-ID: <20240724213623.324532-2-ahmed.zaki@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240724213623.324532-1-ahmed.zaki@intel.com>
References: <20240724213623.324532-1-ahmed.zaki@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Junfeng Guo <junfeng.guo@intel.com>

Add new parser module which can parse a packet in binary and generate
information like ptype, protocol/offset pairs and flags which can be later
used to feed the FXP profile creation directly.

Add skeleton of the create and destroy APIs:
ice_parser_create()
ice_parser_destroy()

Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Signed-off-by: Qi Zhang <qi.z.zhang@intel.com>
Signed-off-by: Junfeng Guo <junfeng.guo@intel.com>
Co-developed-by: Ahmed Zaki <ahmed.zaki@intel.com>
Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
---
 drivers/net/ethernet/intel/ice/Makefile     |  1 +
 drivers/net/ethernet/intel/ice/ice_common.h |  1 +
 drivers/net/ethernet/intel/ice/ice_parser.c | 32 +++++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_parser.h | 13 +++++++++
 4 files changed, 47 insertions(+)
 create mode 100644 drivers/net/ethernet/intel/ice/ice_parser.c
 create mode 100644 drivers/net/ethernet/intel/ice/ice_parser.h

diff --git a/drivers/net/ethernet/intel/ice/Makefile b/drivers/net/ethernet/intel/ice/Makefile
index 03500e28ac99..23fa3f7f36ef 100644
--- a/drivers/net/ethernet/intel/ice/Makefile
+++ b/drivers/net/ethernet/intel/ice/Makefile
@@ -28,6 +28,7 @@ ice-y := ice_main.o	\
 	 ice_vlan_mode.o \
 	 ice_flex_pipe.o \
 	 ice_flow.o	\
+	 ice_parser.o    \
 	 ice_idc.o	\
 	 devlink/devlink.o	\
 	 devlink/devlink_port.o \
diff --git a/drivers/net/ethernet/intel/ice/ice_common.h b/drivers/net/ethernet/intel/ice/ice_common.h
index 66f29bac783a..27208a60cece 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.h
+++ b/drivers/net/ethernet/intel/ice/ice_common.h
@@ -10,6 +10,7 @@
 #include "ice_type.h"
 #include "ice_nvm.h"
 #include "ice_flex_pipe.h"
+#include "ice_parser.h"
 #include <linux/avf/virtchnl.h>
 #include "ice_switch.h"
 #include "ice_fdir.h"
diff --git a/drivers/net/ethernet/intel/ice/ice_parser.c b/drivers/net/ethernet/intel/ice/ice_parser.c
new file mode 100644
index 000000000000..6c50164efae0
--- /dev/null
+++ b/drivers/net/ethernet/intel/ice/ice_parser.c
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2024 Intel Corporation */
+
+#include "ice_common.h"
+
+/**
+ * ice_parser_create - create a parser instance
+ * @hw: pointer to the hardware structure
+ *
+ * Return: a pointer to the allocated parser instance or ERR_PTR
+ * in case of error.
+ */
+struct ice_parser *ice_parser_create(struct ice_hw *hw)
+{
+	struct ice_parser *p;
+
+	p = kzalloc(sizeof(*p), GFP_KERNEL);
+	if (!p)
+		return ERR_PTR(-ENOMEM);
+
+	p->hw = hw;
+	return p;
+}
+
+/**
+ * ice_parser_destroy - destroy a parser instance
+ * @psr: pointer to a parser instance
+ */
+void ice_parser_destroy(struct ice_parser *psr)
+{
+	kfree(psr);
+}
diff --git a/drivers/net/ethernet/intel/ice/ice_parser.h b/drivers/net/ethernet/intel/ice/ice_parser.h
new file mode 100644
index 000000000000..09ed380eee32
--- /dev/null
+++ b/drivers/net/ethernet/intel/ice/ice_parser.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2024 Intel Corporation */
+
+#ifndef _ICE_PARSER_H_
+#define _ICE_PARSER_H_
+
+struct ice_parser {
+	struct ice_hw *hw; /* pointer to the hardware structure */
+};
+
+struct ice_parser *ice_parser_create(struct ice_hw *hw);
+void ice_parser_destroy(struct ice_parser *psr);
+#endif /* _ICE_PARSER_H_ */
-- 
2.43.0


