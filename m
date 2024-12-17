Return-Path: <netdev+bounces-152722-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46AD19F5873
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 22:10:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C87D7A2B8C
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 21:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4209F1FA175;
	Tue, 17 Dec 2024 21:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kcGovcaV"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC181F9AAC
	for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 21:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734469734; cv=none; b=SbrPA02laOHzZkICa8qyri/n4pvGZUaQJ15vrMQpYba6QNmL4dWY+sbS2Ocm10/MPUXZXbZv9blO+e0YK0Qt4UDg+Kp/KKT6vXB9HhNaX4jrvBznwnxUxTtfWshPNXRrSNK52MrSNDkiRb8IvMaSJXYZyRyIsjZdvbF1jlkxxHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734469734; c=relaxed/simple;
	bh=XW8piwVRvvLzZTxoL1Req3q4u+I6rbvTV8h0/eudJm4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GQrxEHQOkQ142K7CXeQE4g5bkPMSI/o/ApQwE4hp22km3Qx2kyY/KGGR9H6eB0aZTWLckBPO2CIe259V3P4YYazSjd5lh14lLETxaMAEflZlS2/Wd0bKHZnEaCHgvzVWDP62RF6c1ePp/L+Udl24CuN5PMXR1MG/Rx8nJHOdep4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kcGovcaV; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734469733; x=1766005733;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XW8piwVRvvLzZTxoL1Req3q4u+I6rbvTV8h0/eudJm4=;
  b=kcGovcaVKTbTmLrK7yneEF6Y4ufER4k661C/eQqqp9CxK5N/V+XQE5lr
   fIUUZMPTI29fSf/t9AWjgJ6Bbo/AQgi7unpx4QgvFY0u7ZcTcRVIhVXlL
   3NBmrfKRj420ah69uvyzVsEB4jFt7lnJTpPrKl/JroI0U/6E4DI/AbnsH
   B8M1FhOrRZIFq3efgUyPk7unAZnsO/VELyZt8ncPdpcfmEhWb31yR7qdx
   fGxhtkt5qsCJbEWjOdPuJGRSGY9e/VkAAEMP7JW5uWHXtYRSNsfrAOrFs
   8KFHMuI5DbRrsNqlBhYx+VUrEh9HAwHXfvFDUL8c22wuOGwRHVwmpa/XF
   w==;
X-CSE-ConnectionGUID: 3/yGN18oSBqImCoxRhOY0A==
X-CSE-MsgGUID: damk1oXQSNKXgiNT4o9TDA==
X-IronPort-AV: E=McAfee;i="6700,10204,11289"; a="34794854"
X-IronPort-AV: E=Sophos;i="6.12,242,1728975600"; 
   d="scan'208";a="34794854"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2024 13:08:51 -0800
X-CSE-ConnectionGUID: 98azbp7jTZa0RmFnNXYerg==
X-CSE-MsgGUID: aTR4LGYwT26SnMenqF8mlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,242,1728975600"; 
   d="scan'208";a="97436331"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa006.fm.intel.com with ESMTP; 17 Dec 2024 13:08:50 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	anthony.l.nguyen@intel.com,
	mateusz.polchlopek@intel.com,
	joe@perches.com,
	horms@kernel.org,
	jiri@resnulli.us,
	apw@canonical.com,
	lukas.bulwahn@gmail.com,
	dwaipayanray1@gmail.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH net-next v2 4/6] ice: rename devlink_port.[ch] to port.[ch]
Date: Tue, 17 Dec 2024 13:08:31 -0800
Message-ID: <20241217210835.3702003-5-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241217210835.3702003-1-anthony.l.nguyen@intel.com>
References: <20241217210835.3702003-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Przemek Kitszel <przemyslaw.kitszel@intel.com>

Drop "devlink_" prefix from files that sit in devlink/.
I'm going to add more files there, and repeating "devlink" does not feel
good. This is also the scheme used in most other places, most notably the
devlink core files are named like that.

devlink.[ch] stays as is.

Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/Makefile                         | 2 +-
 drivers/net/ethernet/intel/ice/devlink/devlink.c                | 2 +-
 .../net/ethernet/intel/ice/devlink/{devlink_port.c => port.c}   | 2 +-
 .../net/ethernet/intel/ice/devlink/{devlink_port.h => port.h}   | 0
 drivers/net/ethernet/intel/ice/ice_eswitch.h                    | 2 +-
 drivers/net/ethernet/intel/ice/ice_main.c                       | 2 +-
 drivers/net/ethernet/intel/ice/ice_repr.c                       | 2 +-
 drivers/net/ethernet/intel/ice/ice_sf_eth.c                     | 2 +-
 8 files changed, 7 insertions(+), 7 deletions(-)
 rename drivers/net/ethernet/intel/ice/devlink/{devlink_port.c => port.c} (99%)
 rename drivers/net/ethernet/intel/ice/devlink/{devlink_port.h => port.h} (100%)

diff --git a/drivers/net/ethernet/intel/ice/Makefile b/drivers/net/ethernet/intel/ice/Makefile
index 3307d551f431..56aa23aee472 100644
--- a/drivers/net/ethernet/intel/ice/Makefile
+++ b/drivers/net/ethernet/intel/ice/Makefile
@@ -32,7 +32,7 @@ ice-y := ice_main.o	\
 	 ice_parser_rt.o \
 	 ice_idc.o	\
 	 devlink/devlink.o	\
-	 devlink/devlink_port.o \
+	 devlink/port.o \
 	 ice_sf_eth.o	\
 	 ice_sf_vsi_vlan_ops.o \
 	 ice_ddp.o	\
diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink.c b/drivers/net/ethernet/intel/ice/devlink/devlink.c
index 415445cefdb2..1b10682c00b8 100644
--- a/drivers/net/ethernet/intel/ice/devlink/devlink.c
+++ b/drivers/net/ethernet/intel/ice/devlink/devlink.c
@@ -6,7 +6,7 @@
 #include "ice.h"
 #include "ice_lib.h"
 #include "devlink.h"
-#include "devlink_port.h"
+#include "port.h"
 #include "ice_eswitch.h"
 #include "ice_fw_update.h"
 #include "ice_dcb_lib.h"
diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink_port.c b/drivers/net/ethernet/intel/ice/devlink/port.c
similarity index 99%
rename from drivers/net/ethernet/intel/ice/devlink/devlink_port.c
rename to drivers/net/ethernet/intel/ice/devlink/port.c
index c6779d9dffff..767419a67fef 100644
--- a/drivers/net/ethernet/intel/ice/devlink/devlink_port.c
+++ b/drivers/net/ethernet/intel/ice/devlink/port.c
@@ -5,7 +5,7 @@
 
 #include "ice.h"
 #include "devlink.h"
-#include "devlink_port.h"
+#include "port.h"
 #include "ice_lib.h"
 #include "ice_fltr.h"
 
diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink_port.h b/drivers/net/ethernet/intel/ice/devlink/port.h
similarity index 100%
rename from drivers/net/ethernet/intel/ice/devlink/devlink_port.h
rename to drivers/net/ethernet/intel/ice/devlink/port.h
diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.h b/drivers/net/ethernet/intel/ice/ice_eswitch.h
index ac7db100e2cd..5c7dcf21b222 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch.h
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch.h
@@ -5,7 +5,7 @@
 #define _ICE_ESWITCH_H_
 
 #include <net/devlink.h>
-#include "devlink/devlink_port.h"
+#include "devlink/port.h"
 
 #ifdef CONFIG_ICE_SWITCHDEV
 void ice_eswitch_detach_vf(struct ice_pf *pf, struct ice_vf *vf);
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 0ab35607e5d5..d641dd8b8184 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -14,7 +14,7 @@
 #include "ice_dcb_lib.h"
 #include "ice_dcb_nl.h"
 #include "devlink/devlink.h"
-#include "devlink/devlink_port.h"
+#include "devlink/port.h"
 #include "ice_sf_eth.h"
 #include "ice_hwmon.h"
 /* Including ice_trace.h with CREATE_TRACE_POINTS defined will generate the
diff --git a/drivers/net/ethernet/intel/ice/ice_repr.c b/drivers/net/ethernet/intel/ice/ice_repr.c
index 970a99a52bf1..fb7a1b9a4313 100644
--- a/drivers/net/ethernet/intel/ice/ice_repr.c
+++ b/drivers/net/ethernet/intel/ice/ice_repr.c
@@ -4,7 +4,7 @@
 #include "ice.h"
 #include "ice_eswitch.h"
 #include "devlink/devlink.h"
-#include "devlink/devlink_port.h"
+#include "devlink/port.h"
 #include "ice_sriov.h"
 #include "ice_tc_lib.h"
 #include "ice_dcb_lib.h"
diff --git a/drivers/net/ethernet/intel/ice/ice_sf_eth.c b/drivers/net/ethernet/intel/ice/ice_sf_eth.c
index 75d7147e1c01..1a2c94375ca7 100644
--- a/drivers/net/ethernet/intel/ice/ice_sf_eth.c
+++ b/drivers/net/ethernet/intel/ice/ice_sf_eth.c
@@ -5,8 +5,8 @@
 #include "ice_txrx.h"
 #include "ice_fltr.h"
 #include "ice_sf_eth.h"
-#include "devlink/devlink_port.h"
 #include "devlink/devlink.h"
+#include "devlink/port.h"
 
 static const struct net_device_ops ice_sf_netdev_ops = {
 	.ndo_open = ice_open,
-- 
2.47.1


