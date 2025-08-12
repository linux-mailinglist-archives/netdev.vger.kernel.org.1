Return-Path: <netdev+bounces-212936-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F8DB2294D
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 15:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E16DB583F60
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 13:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED3EB2882BC;
	Tue, 12 Aug 2025 13:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xf9xBuh7"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8B82874E6
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 13:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755005957; cv=none; b=g7//sN/fUZ+MubJYQoRK41v4edvubADvu/p51JH1prnZDj6vszbx7dKahmngL8zfMggWHlk5ze2xGtyBHTg+YoS+gPJgVNGwTzPyDXrdsw7hpb4jjMBcqrrW+m0dIZss/38TwGScXZj0A7U//jc6/Ycrc4udkgLVXKtRHH9n+gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755005957; c=relaxed/simple;
	bh=f5V+h35fOmxSuofQ8rkyxWHyf5niUINuAoyLWS0X/u0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bmpPyakFQlilLqA/Fs/VdDSVZ22h5/RwEvkbJL9UUjMjZCGJ6DSsBg6pn8Wenfr9ENRfXBe0HKzMADPos70Mj7kEEKExwqBB+9l6acu0ggm3pZELeJZ02C5qn7UDWoxOb4aUsP7xrfIITrzkHjx3eHAURHaSGvz3SQG1YU5CpVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xf9xBuh7; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755005957; x=1786541957;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=f5V+h35fOmxSuofQ8rkyxWHyf5niUINuAoyLWS0X/u0=;
  b=Xf9xBuh7esw4XaK/jw5AWdLKCA0gUooILK3T5c9o9EW58lAZeLlfZb2G
   RShCRJnoxuGzoa1Lju7OjVWrLkuqHR4jkfM/EfF3l5udji4EgfHlJhGA1
   En6VO1WV3NEZpaGAmAOYv2KUE/eIvwgD1or/v5kX3XEGXS1FbCKFEZzFn
   dB2ouQlTj83dM25ld/3Wp139EmAt+LFktg5mvM0i2UyqWAZ+VPSokNVVv
   3Zohmr1vNNyTz6UpSJUooyAnave7DKFPaPB9Ij5pUxda1tcuKwmdJCdcy
   GRLy+T33kXmrMc/TMQxMLRTOUv4jxVtRC+VtbZ/Rzhr/q6loibRbApdta
   g==;
X-CSE-ConnectionGUID: C8wH9AiaTWatoKiHLhhqcA==
X-CSE-MsgGUID: 5hRA/E4kRTar/TkvBk8TKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="56994344"
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="56994344"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2025 06:39:12 -0700
X-CSE-ConnectionGUID: LpZLaE6lTj+JmmJo2fagRw==
X-CSE-MsgGUID: L9USNADAQSyQsUKBUWtCNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="170416118"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa005.fm.intel.com with ESMTP; 12 Aug 2025 06:39:09 -0700
Received: from vecna.igk.intel.com (vecna.igk.intel.com [10.123.220.17])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 5BE7E32CBF;
	Tue, 12 Aug 2025 14:39:08 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: netdev@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH 12/12] ice: add virt/ and move ice_virtchnl* files there
Date: Tue, 12 Aug 2025 15:29:10 +0200
Message-Id: <20250812132910.99626-13-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250812132910.99626-1-przemyslaw.kitszel@intel.com>
References: <20250812132910.99626-1-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce virt/ directory to collect virtchnl files.
We are going to implement a few sizable extensions soon, each of them
increasing virt/ size, so it looks sensible to introduce a new dir.

Suggested-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 drivers/net/ethernet/intel/ice/Makefile                | 10 +++++-----
 drivers/net/ethernet/intel/ice/ice_sriov.h             |  4 ++--
 drivers/net/ethernet/intel/ice/ice_vf_lib.h            |  2 +-
 .../net/ethernet/intel/ice/{ => virt}/ice_virtchnl.h   |  0
 .../intel/ice/{ => virt}/ice_virtchnl_allowlist.h      |  0
 .../ethernet/intel/ice/{ => virt}/ice_virtchnl_fdir.h  |  0
 .../intel/ice/{ => virt}/ice_virtchnl_queues.h         |  0
 .../ethernet/intel/ice/{ => virt}/ice_virtchnl_rss.h   |  0
 drivers/net/ethernet/intel/ice/ice_sriov.c             |  2 +-
 drivers/net/ethernet/intel/ice/ice_vf_lib.c            |  2 +-
 .../net/ethernet/intel/ice/{ => virt}/ice_virtchnl.c   |  0
 .../intel/ice/{ => virt}/ice_virtchnl_allowlist.c      |  0
 .../ethernet/intel/ice/{ => virt}/ice_virtchnl_fdir.c  |  0
 .../intel/ice/{ => virt}/ice_virtchnl_queues.c         |  0
 .../ethernet/intel/ice/{ => virt}/ice_virtchnl_rss.c   |  0
 15 files changed, 10 insertions(+), 10 deletions(-)
 rename drivers/net/ethernet/intel/ice/{ => virt}/ice_virtchnl.h (100%)
 rename drivers/net/ethernet/intel/ice/{ => virt}/ice_virtchnl_allowlist.h (100%)
 rename drivers/net/ethernet/intel/ice/{ => virt}/ice_virtchnl_fdir.h (100%)
 rename drivers/net/ethernet/intel/ice/{ => virt}/ice_virtchnl_queues.h (100%)
 rename drivers/net/ethernet/intel/ice/{ => virt}/ice_virtchnl_rss.h (100%)
 rename drivers/net/ethernet/intel/ice/{ => virt}/ice_virtchnl.c (100%)
 rename drivers/net/ethernet/intel/ice/{ => virt}/ice_virtchnl_allowlist.c (100%)
 rename drivers/net/ethernet/intel/ice/{ => virt}/ice_virtchnl_fdir.c (100%)
 rename drivers/net/ethernet/intel/ice/{ => virt}/ice_virtchnl_queues.c (100%)
 rename drivers/net/ethernet/intel/ice/{ => virt}/ice_virtchnl_rss.c (100%)

diff --git a/drivers/net/ethernet/intel/ice/Makefile b/drivers/net/ethernet/intel/ice/Makefile
index ccee078931f3..8b58bbbbd363 100644
--- a/drivers/net/ethernet/intel/ice/Makefile
+++ b/drivers/net/ethernet/intel/ice/Makefile
@@ -47,11 +47,11 @@ ice-y := ice_main.o	\
 	 ice_adapter.o
 ice-$(CONFIG_PCI_IOV) +=	\
 	ice_sriov.o		\
-	ice_virtchnl.o		\
-	ice_virtchnl_allowlist.o \
-	ice_virtchnl_fdir.o	\
-	ice_virtchnl_queues.o	\
-	ice_virtchnl_rss.o	\
+	virt/ice_virtchnl.o	\
+	virt/ice_virtchnl_allowlist.o	\
+	virt/ice_virtchnl_fdir.o	\
+	virt/ice_virtchnl_queues.o	\
+	virt/ice_virtchnl_rss.o	\
 	ice_vf_mbx.o		\
 	ice_vf_vsi_vlan_ops.o	\
 	ice_vf_lib.o
diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.h b/drivers/net/ethernet/intel/ice/ice_sriov.h
index d1a998a4bef6..10e5a79e98af 100644
--- a/drivers/net/ethernet/intel/ice/ice_sriov.h
+++ b/drivers/net/ethernet/intel/ice/ice_sriov.h
@@ -3,9 +3,9 @@
 
 #ifndef _ICE_SRIOV_H_
 #define _ICE_SRIOV_H_
-#include "ice_virtchnl_fdir.h"
+#include "virt/ice_virtchnl_fdir.h"
 #include "ice_vf_lib.h"
-#include "ice_virtchnl.h"
+#include "virt/ice_virtchnl.h"
 
 /* Static VF transaction/status register def */
 #define VF_DEVICE_STATUS		0xAA
diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib.h b/drivers/net/ethernet/intel/ice/ice_vf_lib.h
index ffe1f9f830ea..97e3e9ccdc1f 100644
--- a/drivers/net/ethernet/intel/ice/ice_vf_lib.h
+++ b/drivers/net/ethernet/intel/ice/ice_vf_lib.h
@@ -13,7 +13,7 @@
 #include <linux/avf/virtchnl.h>
 #include "ice_type.h"
 #include "ice_flow.h"
-#include "ice_virtchnl_fdir.h"
+#include "virt/ice_virtchnl_fdir.h"
 #include "ice_vsi_vlan_ops.h"
 
 #define ICE_MAX_SRIOV_VFS		256
diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl.h b/drivers/net/ethernet/intel/ice/virt/ice_virtchnl.h
similarity index 100%
rename from drivers/net/ethernet/intel/ice/ice_virtchnl.h
rename to drivers/net/ethernet/intel/ice/virt/ice_virtchnl.h
diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_allowlist.h b/drivers/net/ethernet/intel/ice/virt/ice_virtchnl_allowlist.h
similarity index 100%
rename from drivers/net/ethernet/intel/ice/ice_virtchnl_allowlist.h
rename to drivers/net/ethernet/intel/ice/virt/ice_virtchnl_allowlist.h
diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.h b/drivers/net/ethernet/intel/ice/virt/ice_virtchnl_fdir.h
similarity index 100%
rename from drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.h
rename to drivers/net/ethernet/intel/ice/virt/ice_virtchnl_fdir.h
diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_queues.h b/drivers/net/ethernet/intel/ice/virt/ice_virtchnl_queues.h
similarity index 100%
rename from drivers/net/ethernet/intel/ice/ice_virtchnl_queues.h
rename to drivers/net/ethernet/intel/ice/virt/ice_virtchnl_queues.h
diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_rss.h b/drivers/net/ethernet/intel/ice/virt/ice_virtchnl_rss.h
similarity index 100%
rename from drivers/net/ethernet/intel/ice/ice_virtchnl_rss.h
rename to drivers/net/ethernet/intel/ice/virt/ice_virtchnl_rss.h
diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/ethernet/intel/ice/ice_sriov.c
index 9ce4c4db400e..f53080984853 100644
--- a/drivers/net/ethernet/intel/ice/ice_sriov.c
+++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
@@ -9,7 +9,7 @@
 #include "ice_dcb_lib.h"
 #include "ice_flow.h"
 #include "ice_eswitch.h"
-#include "ice_virtchnl_allowlist.h"
+#include "virt/ice_virtchnl_allowlist.h"
 #include "ice_flex_pipe.h"
 #include "ice_vf_vsi_vlan_ops.h"
 #include "ice_vlan.h"
diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib.c b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
index 5ee74f3e82dc..abf69f4be72a 100644
--- a/drivers/net/ethernet/intel/ice/ice_vf_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
@@ -5,7 +5,7 @@
 #include "ice.h"
 #include "ice_lib.h"
 #include "ice_fltr.h"
-#include "ice_virtchnl_allowlist.h"
+#include "virt/ice_virtchnl_allowlist.h"
 
 /* Public functions which may be accessed by all driver files */
 
diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl.c b/drivers/net/ethernet/intel/ice/virt/ice_virtchnl.c
similarity index 100%
rename from drivers/net/ethernet/intel/ice/ice_virtchnl.c
rename to drivers/net/ethernet/intel/ice/virt/ice_virtchnl.c
diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_allowlist.c b/drivers/net/ethernet/intel/ice/virt/ice_virtchnl_allowlist.c
similarity index 100%
rename from drivers/net/ethernet/intel/ice/ice_virtchnl_allowlist.c
rename to drivers/net/ethernet/intel/ice/virt/ice_virtchnl_allowlist.c
diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c b/drivers/net/ethernet/intel/ice/virt/ice_virtchnl_fdir.c
similarity index 100%
rename from drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c
rename to drivers/net/ethernet/intel/ice/virt/ice_virtchnl_fdir.c
diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_queues.c b/drivers/net/ethernet/intel/ice/virt/ice_virtchnl_queues.c
similarity index 100%
rename from drivers/net/ethernet/intel/ice/ice_virtchnl_queues.c
rename to drivers/net/ethernet/intel/ice/virt/ice_virtchnl_queues.c
diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_rss.c b/drivers/net/ethernet/intel/ice/virt/ice_virtchnl_rss.c
similarity index 100%
rename from drivers/net/ethernet/intel/ice/ice_virtchnl_rss.c
rename to drivers/net/ethernet/intel/ice/virt/ice_virtchnl_rss.c
-- 
2.39.3


