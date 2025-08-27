Return-Path: <netdev+bounces-217496-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A5F6B38EA2
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 00:46:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22BC57C3400
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 22:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9880C30F920;
	Wed, 27 Aug 2025 22:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E5y/uJSB"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6332594B4
	for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 22:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756334812; cv=none; b=MI4cJa2zPPuVv3rvNGKkV4F+BkjHYK2TuYr7Wce+8XbgljQxM39NysApIEesHpA07LoccN2WWL/GDiQJ6dhD+AkuN2a4m1zmai0DYlBqzH7hB4y+Ph1bOcSAZ00l84mHWtHJhogBj3efinsxRz555yywMnfd2NI+KAdvkWS1vwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756334812; c=relaxed/simple;
	bh=uvnr14s2GeHFqkj+7sg+q16Wrvjs/Z8Y1G/lQMR2TYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XjMnZ83x30iMYy+NiWP7i6H1y4BNijCA19hvJcI7QynJeEdON32aoGWZZCgiVhfzeGXqGKWn/dcALLXLuNRW6qxWXe1Qbn0kJ4joBIw4pKi7csI0FYtLMGATnWXr3lGdCvBusoKDFDGo/bzyXXsBv497+CfjjGH5RRtZxaiSBqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E5y/uJSB; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756334811; x=1787870811;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uvnr14s2GeHFqkj+7sg+q16Wrvjs/Z8Y1G/lQMR2TYU=;
  b=E5y/uJSBugj9z0OcQ9vP2XWcF46nRkZ7uBan5ofT8w4iGn07ySLkrtU/
   00D5XXIbZD0+UQMte/8xyBrmYCglej6XyMwTSHKbJqSNP4P3c4MRu/1ji
   VCw0cqolCs9ee+n2NRB3MIXItAOBDa7Dl2ivZknLZnMb0BR4/sRLQDbdA
   +NIBfJVf0l00WYUgV7RSGZ+P2SDSwDUhbo4D3uoeYTMjhuqOL96yOdGp8
   tfRNJ0xLOqvxkMOf8TU5qtkrD7g4Fq7lm2YXNjFcchuuYGfBx6tmBsCDy
   wtFO68vCFdysyzA5iV2cPRbigaQasHQ9Iz/B/mfXaMfO//s3FZDRmveM9
   g==;
X-CSE-ConnectionGUID: CMIqLe+cTdW1wEZc3jq5eg==
X-CSE-MsgGUID: MO6X3pO3QSC7UvucZYvZKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11535"; a="70037215"
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="70037215"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2025 15:46:49 -0700
X-CSE-ConnectionGUID: chah3btBRC6+RXgYy5GucA==
X-CSE-MsgGUID: 1PSzIgUYSYaCILCbhYRCMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="169554999"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa009.jf.intel.com with ESMTP; 27 Aug 2025 15:46:49 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	anthony.l.nguyen@intel.com,
	gregkh@linuxfoundation.org,
	sashal@kernel.org,
	kuniyu@google.com,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH net-next 01/12] ice: add virt/ and move ice_virtchnl* files there
Date: Wed, 27 Aug 2025 15:46:16 -0700
Message-ID: <20250827224641.415806-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250827224641.415806-1-anthony.l.nguyen@intel.com>
References: <20250827224641.415806-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Przemek Kitszel <przemyslaw.kitszel@intel.com>

Introduce virt/ directory to collect virtchnl files.
We are going to implement a few sizable extensions soon, each of them
increasing virt/ size, so it looks sensible to introduce a new dir.

Suggested-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/Makefile                     | 6 +++---
 drivers/net/ethernet/intel/ice/ice_sriov.c                  | 2 +-
 drivers/net/ethernet/intel/ice/ice_sriov.h                  | 4 ++--
 drivers/net/ethernet/intel/ice/ice_vf_lib.c                 | 2 +-
 drivers/net/ethernet/intel/ice/ice_vf_lib.h                 | 2 +-
 .../ice/{ice_virtchnl_allowlist.c => virt/allowlist.c}      | 2 +-
 .../ice/{ice_virtchnl_allowlist.h => virt/allowlist.h}      | 0
 .../ethernet/intel/ice/{ice_virtchnl_fdir.c => virt/fdir.c} | 0
 .../ethernet/intel/ice/{ice_virtchnl_fdir.h => virt/fdir.h} | 0
 .../ethernet/intel/ice/{ice_virtchnl.c => virt/virtchnl.c}  | 4 ++--
 .../ethernet/intel/ice/{ice_virtchnl.h => virt/virtchnl.h}  | 0
 11 files changed, 11 insertions(+), 11 deletions(-)
 rename drivers/net/ethernet/intel/ice/{ice_virtchnl_allowlist.c => virt/allowlist.c} (99%)
 rename drivers/net/ethernet/intel/ice/{ice_virtchnl_allowlist.h => virt/allowlist.h} (100%)
 rename drivers/net/ethernet/intel/ice/{ice_virtchnl_fdir.c => virt/fdir.c} (100%)
 rename drivers/net/ethernet/intel/ice/{ice_virtchnl_fdir.h => virt/fdir.h} (100%)
 rename drivers/net/ethernet/intel/ice/{ice_virtchnl.c => virt/virtchnl.c} (99%)
 rename drivers/net/ethernet/intel/ice/{ice_virtchnl.h => virt/virtchnl.h} (100%)

diff --git a/drivers/net/ethernet/intel/ice/Makefile b/drivers/net/ethernet/intel/ice/Makefile
index d0f9c9492363..f1395282a893 100644
--- a/drivers/net/ethernet/intel/ice/Makefile
+++ b/drivers/net/ethernet/intel/ice/Makefile
@@ -47,9 +47,9 @@ ice-y := ice_main.o	\
 	 ice_adapter.o
 ice-$(CONFIG_PCI_IOV) +=	\
 	ice_sriov.o		\
-	ice_virtchnl.o		\
-	ice_virtchnl_allowlist.o \
-	ice_virtchnl_fdir.o	\
+	virt/virtchnl.o		\
+	virt/allowlist.o	\
+	virt/fdir.o		\
 	ice_vf_mbx.o		\
 	ice_vf_vsi_vlan_ops.o	\
 	ice_vf_lib.o
diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/ethernet/intel/ice/ice_sriov.c
index 9ce4c4db400e..843e82fd3bf9 100644
--- a/drivers/net/ethernet/intel/ice/ice_sriov.c
+++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
@@ -9,7 +9,7 @@
 #include "ice_dcb_lib.h"
 #include "ice_flow.h"
 #include "ice_eswitch.h"
-#include "ice_virtchnl_allowlist.h"
+#include "virt/allowlist.h"
 #include "ice_flex_pipe.h"
 #include "ice_vf_vsi_vlan_ops.h"
 #include "ice_vlan.h"
diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.h b/drivers/net/ethernet/intel/ice/ice_sriov.h
index d1a998a4bef6..6c4fad09a527 100644
--- a/drivers/net/ethernet/intel/ice/ice_sriov.h
+++ b/drivers/net/ethernet/intel/ice/ice_sriov.h
@@ -3,9 +3,9 @@
 
 #ifndef _ICE_SRIOV_H_
 #define _ICE_SRIOV_H_
-#include "ice_virtchnl_fdir.h"
+#include "virt/fdir.h"
 #include "ice_vf_lib.h"
-#include "ice_virtchnl.h"
+#include "virt/virtchnl.h"
 
 /* Static VF transaction/status register def */
 #define VF_DEVICE_STATUS		0xAA
diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib.c b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
index 5ee74f3e82dc..de9e81ccee66 100644
--- a/drivers/net/ethernet/intel/ice/ice_vf_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
@@ -5,7 +5,7 @@
 #include "ice.h"
 #include "ice_lib.h"
 #include "ice_fltr.h"
-#include "ice_virtchnl_allowlist.h"
+#include "virt/allowlist.h"
 
 /* Public functions which may be accessed by all driver files */
 
diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib.h b/drivers/net/ethernet/intel/ice/ice_vf_lib.h
index ffe1f9f830ea..b00708907176 100644
--- a/drivers/net/ethernet/intel/ice/ice_vf_lib.h
+++ b/drivers/net/ethernet/intel/ice/ice_vf_lib.h
@@ -13,7 +13,7 @@
 #include <linux/avf/virtchnl.h>
 #include "ice_type.h"
 #include "ice_flow.h"
-#include "ice_virtchnl_fdir.h"
+#include "virt/fdir.h"
 #include "ice_vsi_vlan_ops.h"
 
 #define ICE_MAX_SRIOV_VFS		256
diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_allowlist.c b/drivers/net/ethernet/intel/ice/virt/allowlist.c
similarity index 99%
rename from drivers/net/ethernet/intel/ice/ice_virtchnl_allowlist.c
rename to drivers/net/ethernet/intel/ice/virt/allowlist.c
index 4c2ec2337b38..a07efec19c45 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_allowlist.c
+++ b/drivers/net/ethernet/intel/ice/virt/allowlist.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) 2021, Intel Corporation. */
 
-#include "ice_virtchnl_allowlist.h"
+#include "allowlist.h"
 
 /* Purpose of this file is to share functionality to allowlist or denylist
  * opcodes used in PF <-> VF communication. Group of opcodes:
diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_allowlist.h b/drivers/net/ethernet/intel/ice/virt/allowlist.h
similarity index 100%
rename from drivers/net/ethernet/intel/ice/ice_virtchnl_allowlist.h
rename to drivers/net/ethernet/intel/ice/virt/allowlist.h
diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c b/drivers/net/ethernet/intel/ice/virt/fdir.c
similarity index 100%
rename from drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c
rename to drivers/net/ethernet/intel/ice/virt/fdir.c
diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.h b/drivers/net/ethernet/intel/ice/virt/fdir.h
similarity index 100%
rename from drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.h
rename to drivers/net/ethernet/intel/ice/virt/fdir.h
diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl.c b/drivers/net/ethernet/intel/ice/virt/virtchnl.c
similarity index 99%
rename from drivers/net/ethernet/intel/ice/ice_virtchnl.c
rename to drivers/net/ethernet/intel/ice/virt/virtchnl.c
index 257967273079..a6d0a9c98d54 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl.c
+++ b/drivers/net/ethernet/intel/ice/virt/virtchnl.c
@@ -1,13 +1,13 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) 2022, Intel Corporation. */
 
-#include "ice_virtchnl.h"
+#include "virtchnl.h"
 #include "ice_vf_lib_private.h"
 #include "ice.h"
 #include "ice_base.h"
 #include "ice_lib.h"
 #include "ice_fltr.h"
-#include "ice_virtchnl_allowlist.h"
+#include "allowlist.h"
 #include "ice_vf_vsi_vlan_ops.h"
 #include "ice_vlan.h"
 #include "ice_flex_pipe.h"
diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl.h b/drivers/net/ethernet/intel/ice/virt/virtchnl.h
similarity index 100%
rename from drivers/net/ethernet/intel/ice/ice_virtchnl.h
rename to drivers/net/ethernet/intel/ice/virt/virtchnl.h
-- 
2.47.1


