Return-Path: <netdev+bounces-151244-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F4DB9EDA06
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 23:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 636E52810DD
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 22:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 114351F2C40;
	Wed, 11 Dec 2024 22:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f9WrK7ml"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BCA1F2C3B
	for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 22:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733956364; cv=none; b=AGPDs0CwWBQdWKF2y7IQAUX1q/kuiQP4kcZMTQ4FFnsFTyBAMfHXaG1+8U08RMf7JzVvaYZUq+0e55UoIFT6RQniVTMKEQ7EihQMdKQZ+WrqunB6Id/B8tc3xC5VCFRBk2Zp5ra1aOP3G3Ls2PfwiInmvIM2D6bcp3omjI+sEpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733956364; c=relaxed/simple;
	bh=nDhiEm6ADZ2KjN6W6XXgdg7PeX6vb/cbAyLvMwp9qZk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FSR8UTxWdp5xnUFxi+C7/bJZWxJdbQj/iJFTS08VouP2SneNhy6ieLXEvlVTRfRiRne7NwvMrpECVahsyyh7hIw4YaZnBnH85HpWBeCxnR5KetnKcxspmB8J72f4k/0tA0eLLvkCKjoE6y0bRGdfiK75vwmYTwTAzDlimMewoVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f9WrK7ml; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733956362; x=1765492362;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nDhiEm6ADZ2KjN6W6XXgdg7PeX6vb/cbAyLvMwp9qZk=;
  b=f9WrK7ml8JvOUWYiG5gVtm3/fRTTQQC/8fBjCPAeimWURP7fd4Dn+uLK
   xTA79BAKOvdAtInmkRTezcqceBMo85MtKCTAT5OmrKPnrH52/Q+HuKcmK
   Ah5Ta2BT1/+pFJkUC2UF4YGpWL90whxemdypcKiSIcyc7nddaG4WzcdK/
   tBIg/j69OOl/GAHt9aW/isedps7jk4YdNE8oxHCWOUVxi8r1+ZV0QlqrO
   OEE+G3t8x9bQwIQ9JpSbEUImYit8o/lgemCdX7adWVls0cps3bOs/Hukv
   yiBjwym7mzyw5htnN8+9AQdkG53t1yMnx8rmd1cGOysigvyihlmodIp6k
   w==;
X-CSE-ConnectionGUID: mEiAwXW+Q8G0PohLAqsPlw==
X-CSE-MsgGUID: eJzUiafqQHuF4KIAjU+SBg==
X-IronPort-AV: E=McAfee;i="6700,10204,11283"; a="34599631"
X-IronPort-AV: E=Sophos;i="6.12,226,1728975600"; 
   d="scan'208";a="34599631"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 14:32:40 -0800
X-CSE-ConnectionGUID: Begdxwe4SYWzdZVnwSesIg==
X-CSE-MsgGUID: IN8OC1k4SUCnI3VAfND5VQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,226,1728975600"; 
   d="scan'208";a="96192937"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa008.fm.intel.com with ESMTP; 11 Dec 2024 14:32:39 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	anthony.l.nguyen@intel.com,
	wojciech.drewek@intel.com,
	mateusz.polchlopek@intel.com,
	joe@perches.com,
	horms@kernel.org,
	jiri@resnulli.us,
	apw@canonical.com,
	lukas.bulwahn@gmail.com,
	dwaipayanray1@gmail.com
Subject: [PATCH net-next 4/7] ice: rename devlink_port.[ch] to port.[ch]
Date: Wed, 11 Dec 2024 14:32:12 -0800
Message-ID: <20241211223231.397203-5-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20241211223231.397203-1-anthony.l.nguyen@intel.com>
References: <20241211223231.397203-1-anthony.l.nguyen@intel.com>
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
2.42.0


