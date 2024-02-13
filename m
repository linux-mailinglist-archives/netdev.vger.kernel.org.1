Return-Path: <netdev+bounces-71210-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F6F8529D0
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 08:24:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B6C81C22393
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 07:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16B1917564;
	Tue, 13 Feb 2024 07:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VsepFZzU"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8C717995
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 07:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707809036; cv=none; b=khYGP/KUTB2GDnM2IgdDgOQjpgSaTMFHeobXVCfWtOLGVGLS0LhGeynwqFXjet01kIdvcT6xMuDNB7Rh/Q0Mea5H1J63kNYbVL4ZBl6eecgDdHXLhA5bB5Syq+83QEdl2c1+nbqEV5j5OZCIgZF3t5J8/GBgVwbANQCvFRV/uc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707809036; c=relaxed/simple;
	bh=aB/Tl50P5lqWpAy1hYl1ouA6J/Ma41ODTxAJ/YnOLc8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e0r4YMcMRnCPm4bA4z/mo7Isy4Eh042JOzEmYnA+5DkZdBJpTH9U9vCPuQrweIilU6w41VJC/k+udHw4Xc7UzlU/TTd8RkgrnW+OpLLH1kRFE8ZpJX7Msbr63H7Q7uvjNVQICZ2Erw7GJc+8WA/98ojZ0i8dADPlfvm1u8KdqnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VsepFZzU; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707809034; x=1739345034;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aB/Tl50P5lqWpAy1hYl1ouA6J/Ma41ODTxAJ/YnOLc8=;
  b=VsepFZzUe2xgCMg0PBeTl2Wh0iV8lHLe0m43AqvFKsXIDdK8SOkVVRsX
   kU9V/G62PViuqo1ZYJQ5hi63kKCEn/vCqFVrrmjFm/bXNRmFgzEXvP9DA
   dISnWOifyEMUtgl0c5qq2n8VUjNvBhL31TxPCNUm3aSg3RgF3YUnECMd+
   nddNuzCXycHcbRm7OqLyX08EsDsQu/o6Jd8yqo7p8Q/slReDWgNoMoq+R
   S3PJTVltVA+R7EYmk84HHw9DVhC4YIx4wE4gUqHTN7F24th1z9tR3gc1R
   6fw7Cj+GCgGzyYkKlHpLAAEYuvO1WxmsLJgePpRh0maErx96J5yezKXJk
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="27248088"
X-IronPort-AV: E=Sophos;i="6.06,156,1705392000"; 
   d="scan'208";a="27248088"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 23:23:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,156,1705392000"; 
   d="scan'208";a="7385552"
Received: from wasp.igk.intel.com (HELO GK3153-DR2-R750-36946.localdomain.com) ([10.102.20.192])
  by fmviesa003.fm.intel.com with ESMTP; 12 Feb 2024 23:23:47 -0800
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	jacob.e.keller@intel.com,
	michal.kubiak@intel.com,
	maciej.fijalkowski@intel.com,
	sridhar.samudrala@intel.com,
	przemyslaw.kitszel@intel.com,
	wojciech.drewek@intel.com,
	pio.raczynski@gmail.com,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: [iwl-next v1 15/15] ice: move ice_devlink.[ch] to devlink folder
Date: Tue, 13 Feb 2024 08:27:24 +0100
Message-ID: <20240213072724.77275-16-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240213072724.77275-1-michal.swiatkowski@linux.intel.com>
References: <20240213072724.77275-1-michal.swiatkowski@linux.intel.com>
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

Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/intel/ice/Makefile                    | 2 +-
 drivers/net/ethernet/intel/ice/{ => devlink}/ice_devlink.c | 0
 drivers/net/ethernet/intel/ice/{ => devlink}/ice_devlink.h | 0
 drivers/net/ethernet/intel/ice/ice_dcb_lib.c               | 2 +-
 drivers/net/ethernet/intel/ice/ice_eswitch.c               | 2 +-
 drivers/net/ethernet/intel/ice/ice_main.c                  | 2 +-
 drivers/net/ethernet/intel/ice/ice_repr.c                  | 2 +-
 drivers/net/ethernet/intel/ice/ice_sf_eth.c                | 2 +-
 8 files changed, 6 insertions(+), 6 deletions(-)
 rename drivers/net/ethernet/intel/ice/{ => devlink}/ice_devlink.c (100%)
 rename drivers/net/ethernet/intel/ice/{ => devlink}/ice_devlink.h (100%)

diff --git a/drivers/net/ethernet/intel/ice/Makefile b/drivers/net/ethernet/intel/ice/Makefile
index 6f350d8624d7..895cec763637 100644
--- a/drivers/net/ethernet/intel/ice/Makefile
+++ b/drivers/net/ethernet/intel/ice/Makefile
@@ -29,7 +29,7 @@ ice-y := ice_main.o	\
 	 ice_flex_pipe.o \
 	 ice_flow.o	\
 	 ice_idc.o	\
-	 ice_devlink.o	\
+	 devlink/ice_devlink.o	\
 	 devlink/ice_devlink_port.o	\
 	 ice_sf_eth.o	\
 	 ice_sf_vsi_vlan_ops.o \
diff --git a/drivers/net/ethernet/intel/ice/ice_devlink.c b/drivers/net/ethernet/intel/ice/devlink/ice_devlink.c
similarity index 100%
rename from drivers/net/ethernet/intel/ice/ice_devlink.c
rename to drivers/net/ethernet/intel/ice/devlink/ice_devlink.c
diff --git a/drivers/net/ethernet/intel/ice/ice_devlink.h b/drivers/net/ethernet/intel/ice/devlink/ice_devlink.h
similarity index 100%
rename from drivers/net/ethernet/intel/ice/ice_devlink.h
rename to drivers/net/ethernet/intel/ice/devlink/ice_devlink.h
diff --git a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
index 63ce4920de4e..3f6661390151 100644
--- a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
@@ -3,7 +3,7 @@
 
 #include "ice_dcb_lib.h"
 #include "ice_dcb_nl.h"
-#include "ice_devlink.h"
+#include "devlink/ice_devlink.h"
 
 /**
  * ice_dcb_get_ena_tc - return bitmap of enabled TCs
diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.c b/drivers/net/ethernet/intel/ice/ice_eswitch.c
index 50985a3732c0..416728d0674f 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch.c
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch.c
@@ -7,7 +7,7 @@
 #include "ice_eswitch_br.h"
 #include "ice_fltr.h"
 #include "ice_repr.h"
-#include "ice_devlink.h"
+#include "devlink/ice_devlink.h"
 #include "ice_tc_lib.h"
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 7ff96da33e8d..5129bce8538a 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -13,7 +13,7 @@
 #include "ice_fltr.h"
 #include "ice_dcb_lib.h"
 #include "ice_dcb_nl.h"
-#include "ice_devlink.h"
+#include "devlink/ice_devlink.h"
 #include "ice_hwmon.h"
 #include "devlink/ice_devlink_port.h"
 #include "ice_sf_eth.h"
diff --git a/drivers/net/ethernet/intel/ice/ice_repr.c b/drivers/net/ethernet/intel/ice/ice_repr.c
index fb0171afa43e..11ead0a0365d 100644
--- a/drivers/net/ethernet/intel/ice/ice_repr.c
+++ b/drivers/net/ethernet/intel/ice/ice_repr.c
@@ -3,7 +3,7 @@
 
 #include "ice.h"
 #include "ice_eswitch.h"
-#include "ice_devlink.h"
+#include "devlink/ice_devlink.h"
 #include "devlink/ice_devlink_port.h"
 #include "ice_sriov.h"
 #include "ice_tc_lib.h"
diff --git a/drivers/net/ethernet/intel/ice/ice_sf_eth.c b/drivers/net/ethernet/intel/ice/ice_sf_eth.c
index 3d30dfaed7d7..f00aabb68f0f 100644
--- a/drivers/net/ethernet/intel/ice/ice_sf_eth.c
+++ b/drivers/net/ethernet/intel/ice/ice_sf_eth.c
@@ -6,7 +6,7 @@
 #include "ice_txrx.h"
 #include "ice_fltr.h"
 #include "ice_sf_eth.h"
-#include "ice_devlink.h"
+#include "devlink/ice_devlink.h"
 #include "devlink/ice_devlink_port.h"
 
 static const struct net_device_ops ice_sf_netdev_ops = {
-- 
2.42.0


