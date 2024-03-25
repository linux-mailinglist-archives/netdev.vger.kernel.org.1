Return-Path: <netdev+bounces-81815-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D86788B2D0
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 22:30:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 151EA1FA4FDF
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 21:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513B06E61F;
	Mon, 25 Mar 2024 21:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WCWlFKur"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B4C73164
	for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 21:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711402206; cv=none; b=LNcSQQ60yeEDMvBZ5xa373pK/GP9VbeiVj3xbFfjh5dkJmOmVVomcd2IGwQX9cExkEOkmgH1egKhvi5UqPbhcs8cms9/K7BD87CSF3vaRUGaI3PM9Mhcs7/LMrIBiEqof2KP5DERlMylD/RXSN4Dr8dUcYymfn8LSayvKeUuMes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711402206; c=relaxed/simple;
	bh=AUpmNmysBzG1tSFAGWm7XFVFw8guyJsqdKGSo4+2cQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V2yN2/g11jLuoqgdOpr7dbYFO1uAk1ILPqUkO2Q0ULdnmwHb9RfymOl2kVSz2BBwgVN7b/Y65dZoxuXudCzGPMr4ePTGKG8F062CQFZeRsZgjPYEdWlCgZop/5v8PMVSSerc/5BMV0MRNnT8hRU0r36NhupsNWCUH7cDXKLky1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WCWlFKur; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711402204; x=1742938204;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AUpmNmysBzG1tSFAGWm7XFVFw8guyJsqdKGSo4+2cQ4=;
  b=WCWlFKurGfV3A6awKwQdSrpln3HwlcRqJBFUsv3KfuFCe3MGmhiRV306
   vqIGLvYKWVvCnI2P7DXK7KbICUgvaynhEG4YLx0yDorAuY7MUzwIZxwxM
   0W0DZS5CXjviXUR2HTCDTeINaMIPlnzh7drrvOs4q32N3cye61DfiGuTN
   IUuAQekYfc2CqJrgAqOxL0x2Kgj8dJBJz3osQ9SzzxTiHyA0CfwG1qlkm
   SEA2oyyffxOyyytrT1V4Qf+TkK5lrZPSd3HXzkNjJkhXwWvRId2G2Lwp5
   RlVmgZPARzTd4PQdS0R6fEAZiuDiT61Y6cKLSBiTIK/RAqqHkz1Jywgy9
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="17064534"
X-IronPort-AV: E=Sophos;i="6.07,154,1708416000"; 
   d="scan'208";a="17064534"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 14:30:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,154,1708416000"; 
   d="scan'208";a="15713496"
Received: from wasp.igk.intel.com (HELO GK3153-DR2-R750-36946.localdomain.com) ([10.102.20.192])
  by orviesa009.jf.intel.com with ESMTP; 25 Mar 2024 14:30:02 -0700
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [iwl-next v1 1/3] ice: move ice_devlink.[ch] to devlink folder
Date: Mon, 25 Mar 2024 22:34:31 +0100
Message-ID: <20240325213433.829161-2-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240325213433.829161-1-michal.swiatkowski@linux.intel.com>
References: <20240325213433.829161-1-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Only moving whole files, fixing Makefile and bunch of includes.

Some changes to ice_devlink file was done even in representor part (Tx
topology), so keep it as final patch to not mess up with rebasing.

After moving to devlink folder there is no need to have such long name
for these files. Rename them to simple devlink.

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/intel/ice/Makefile                        | 3 ++-
 .../ethernet/intel/ice/{ice_devlink.c => devlink/devlink.c}    | 2 +-
 .../ethernet/intel/ice/{ice_devlink.h => devlink/devlink.h}    | 0
 drivers/net/ethernet/intel/ice/ice_dcb_lib.c                   | 2 +-
 drivers/net/ethernet/intel/ice/ice_eswitch.c                   | 2 +-
 drivers/net/ethernet/intel/ice/ice_lib.c                       | 2 +-
 drivers/net/ethernet/intel/ice/ice_main.c                      | 2 +-
 drivers/net/ethernet/intel/ice/ice_repr.c                      | 2 +-
 8 files changed, 8 insertions(+), 7 deletions(-)
 rename drivers/net/ethernet/intel/ice/{ice_devlink.c => devlink/devlink.c} (99%)
 rename drivers/net/ethernet/intel/ice/{ice_devlink.h => devlink/devlink.h} (100%)

diff --git a/drivers/net/ethernet/intel/ice/Makefile b/drivers/net/ethernet/intel/ice/Makefile
index cddd82d4ca0f..97edd0dfba26 100644
--- a/drivers/net/ethernet/intel/ice/Makefile
+++ b/drivers/net/ethernet/intel/ice/Makefile
@@ -5,6 +5,7 @@
 # Makefile for the Intel(R) Ethernet Connection E800 Series Linux Driver
 #
 
+subdir-ccflags-y += -I$(src)
 obj-$(CONFIG_ICE) += ice.o
 
 ice-y := ice_main.o	\
@@ -28,7 +29,7 @@ ice-y := ice_main.o	\
 	 ice_flex_pipe.o \
 	 ice_flow.o	\
 	 ice_idc.o	\
-	 ice_devlink.o	\
+	 devlink/devlink.o	\
 	 ice_ddp.o	\
 	 ice_fw_update.o \
 	 ice_lag.o	\
diff --git a/drivers/net/ethernet/intel/ice/ice_devlink.c b/drivers/net/ethernet/intel/ice/devlink/devlink.c
similarity index 99%
rename from drivers/net/ethernet/intel/ice/ice_devlink.c
rename to drivers/net/ethernet/intel/ice/devlink/devlink.c
index b516e42b41f0..d61bc8340326 100644
--- a/drivers/net/ethernet/intel/ice/ice_devlink.c
+++ b/drivers/net/ethernet/intel/ice/devlink/devlink.c
@@ -5,7 +5,7 @@
 
 #include "ice.h"
 #include "ice_lib.h"
-#include "ice_devlink.h"
+#include "devlink.h"
 #include "ice_eswitch.h"
 #include "ice_fw_update.h"
 #include "ice_dcb_lib.h"
diff --git a/drivers/net/ethernet/intel/ice/ice_devlink.h b/drivers/net/ethernet/intel/ice/devlink/devlink.h
similarity index 100%
rename from drivers/net/ethernet/intel/ice/ice_devlink.h
rename to drivers/net/ethernet/intel/ice/devlink/devlink.h
diff --git a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
index 6e20ee610022..0a90f472de3c 100644
--- a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
@@ -3,7 +3,7 @@
 
 #include "ice_dcb_lib.h"
 #include "ice_dcb_nl.h"
-#include "ice_devlink.h"
+#include "devlink/devlink.h"
 
 /**
  * ice_dcb_get_ena_tc - return bitmap of enabled TCs
diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.c b/drivers/net/ethernet/intel/ice/ice_eswitch.c
index 9069725c71b4..cc20e17c0bec 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch.c
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch.c
@@ -7,7 +7,7 @@
 #include "ice_eswitch_br.h"
 #include "ice_fltr.h"
 #include "ice_repr.h"
-#include "ice_devlink.h"
+#include "devlink/devlink.h"
 #include "ice_tc_lib.h"
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index be32ace96da9..be10a88d00e9 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -7,7 +7,7 @@
 #include "ice_lib.h"
 #include "ice_fltr.h"
 #include "ice_dcb_lib.h"
-#include "ice_devlink.h"
+#include "devlink/devlink.h"
 #include "ice_vsi_vlan_ops.h"
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index cc1957c592b2..3184fac8804d 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -13,7 +13,7 @@
 #include "ice_fltr.h"
 #include "ice_dcb_lib.h"
 #include "ice_dcb_nl.h"
-#include "ice_devlink.h"
+#include "devlink/devlink.h"
 #include "ice_hwmon.h"
 /* Including ice_trace.h with CREATE_TRACE_POINTS defined will generate the
  * ice tracepoint functions. This must be done exactly once across the
diff --git a/drivers/net/ethernet/intel/ice/ice_repr.c b/drivers/net/ethernet/intel/ice/ice_repr.c
index 5f30fb131f74..116cb56aa962 100644
--- a/drivers/net/ethernet/intel/ice/ice_repr.c
+++ b/drivers/net/ethernet/intel/ice/ice_repr.c
@@ -3,7 +3,7 @@
 
 #include "ice.h"
 #include "ice_eswitch.h"
-#include "ice_devlink.h"
+#include "devlink/devlink.h"
 #include "ice_sriov.h"
 #include "ice_tc_lib.h"
 #include "ice_dcb_lib.h"
-- 
2.42.0


