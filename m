Return-Path: <netdev+bounces-71209-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA6FB8529CF
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 08:24:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08C1A1C22904
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 07:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F27A1756D;
	Tue, 13 Feb 2024 07:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lNUXfkA9"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5BFD171D8
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 07:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707809034; cv=none; b=cuy8pnDgbl+kNup1AGp+J9wILLmXRYQ2JZOgWwrGPksM8MvN3CEoGvO/H+iGHyCvQ5dTSLZnsMK7m6evBG27czekRDnVoZid8Cq7PYbcUPXLEOP0AglED2PBLqAeUtiX9b69FugXf1x97IaL6VqfO1SoJE1uQrObLsWEiww8Ma8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707809034; c=relaxed/simple;
	bh=IKRDd4c9n0D05np4WJ9MCwT9oT2BcvovW06HjCsW9Yg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VFnBJ5bpwVMVpOxfobBUt/Q2LzxZ5H2o7D9910wsOFkh1vh/GHb+slug/PLaf2i42TchCuCyJKh24xl2hbi4MrovdMwnWaGst3nFeLL6gGgnoiYcOZzRx+lYFMSxQvleGB9V/1LA51Csb9tnktn4jqoUKD2Eo0dv6pPCDXwy/zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lNUXfkA9; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707809033; x=1739345033;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IKRDd4c9n0D05np4WJ9MCwT9oT2BcvovW06HjCsW9Yg=;
  b=lNUXfkA9XbgL69X7wvwXnU+sDXv2AJySQ2OoRRKQzPXoXXyOwYzTob58
   xE1gOJVYU0mAZ11X5z3Eb0NoQ0q4FkZyr1R1HzfSgbXabJrQAAHd2wbTa
   zAcqvFQw0x3C2NIAvzvFx/+FT0vSknHwnxGvndMtDaW4Pk8m9HiOP3JsO
   uKX1PufUbayaquWUdtnNf1TQSrjMi5eFGCZ8XOYaolMgkbCfRua+2oUFv
   APypFOX0tQIp+KrIgID3IFzW/r+cSKYMRFHGOCj4uiFi0CSvHD+0A6gpb
   npsngsV5vbolnRzYK10ZDP8URImJ9akghECL3tlrAjG1QZO4D+nBbcrjj
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="27248084"
X-IronPort-AV: E=Sophos;i="6.06,156,1705392000"; 
   d="scan'208";a="27248084"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 23:23:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,156,1705392000"; 
   d="scan'208";a="7385518"
Received: from wasp.igk.intel.com (HELO GK3153-DR2-R750-36946.localdomain.com) ([10.102.20.192])
  by fmviesa003.fm.intel.com with ESMTP; 12 Feb 2024 23:23:43 -0800
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
Subject: [iwl-next v1 14/15] ice: basic support for VLAN in subfunctions
Date: Tue, 13 Feb 2024 08:27:23 +0100
Message-ID: <20240213072724.77275-15-michal.swiatkowski@linux.intel.com>
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

Implement add / delete vlan for subfunction type VSI.

Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/intel/ice/Makefile       |  1 +
 .../ethernet/intel/ice/ice_sf_vsi_vlan_ops.c  | 21 +++++++++++++++++++
 .../ethernet/intel/ice/ice_sf_vsi_vlan_ops.h  | 13 ++++++++++++
 .../net/ethernet/intel/ice/ice_vsi_vlan_ops.c |  4 ++++
 4 files changed, 39 insertions(+)
 create mode 100644 drivers/net/ethernet/intel/ice/ice_sf_vsi_vlan_ops.c
 create mode 100644 drivers/net/ethernet/intel/ice/ice_sf_vsi_vlan_ops.h

diff --git a/drivers/net/ethernet/intel/ice/Makefile b/drivers/net/ethernet/intel/ice/Makefile
index d56a7165df95..6f350d8624d7 100644
--- a/drivers/net/ethernet/intel/ice/Makefile
+++ b/drivers/net/ethernet/intel/ice/Makefile
@@ -32,6 +32,7 @@ ice-y := ice_main.o	\
 	 ice_devlink.o	\
 	 devlink/ice_devlink_port.o	\
 	 ice_sf_eth.o	\
+	 ice_sf_vsi_vlan_ops.o \
 	 ice_ddp.o	\
 	 ice_fw_update.o \
 	 ice_lag.o	\
diff --git a/drivers/net/ethernet/intel/ice/ice_sf_vsi_vlan_ops.c b/drivers/net/ethernet/intel/ice/ice_sf_vsi_vlan_ops.c
new file mode 100644
index 000000000000..3d7e96721cf9
--- /dev/null
+++ b/drivers/net/ethernet/intel/ice/ice_sf_vsi_vlan_ops.c
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023, Intel Corporation. */
+
+#include "ice_vsi_vlan_ops.h"
+#include "ice_vsi_vlan_lib.h"
+#include "ice_vlan_mode.h"
+#include "ice.h"
+#include "ice_sf_vsi_vlan_ops.h"
+
+void ice_sf_vsi_init_vlan_ops(struct ice_vsi *vsi)
+{
+	struct ice_vsi_vlan_ops *vlan_ops;
+
+	if (ice_is_dvm_ena(&vsi->back->hw))
+		vlan_ops = &vsi->outer_vlan_ops;
+	else
+		vlan_ops = &vsi->inner_vlan_ops;
+
+	vlan_ops->add_vlan = ice_vsi_add_vlan;
+	vlan_ops->del_vlan = ice_vsi_del_vlan;
+}
diff --git a/drivers/net/ethernet/intel/ice/ice_sf_vsi_vlan_ops.h b/drivers/net/ethernet/intel/ice/ice_sf_vsi_vlan_ops.h
new file mode 100644
index 000000000000..8c44eafceea0
--- /dev/null
+++ b/drivers/net/ethernet/intel/ice/ice_sf_vsi_vlan_ops.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2023, Intel Corporation. */
+
+#ifndef _ICE_SF_VSI_VLAN_OPS_H_
+#define _ICE_SF_VSI_VLAN_OPS_H_
+
+#include "ice_vsi_vlan_ops.h"
+
+struct ice_vsi;
+
+void ice_sf_vsi_init_vlan_ops(struct ice_vsi *vsi);
+
+#endif /* _ICE_SF_VSI_VLAN_OPS_H_ */
diff --git a/drivers/net/ethernet/intel/ice/ice_vsi_vlan_ops.c b/drivers/net/ethernet/intel/ice/ice_vsi_vlan_ops.c
index 7aae7fdcfcdb..8c7a9b41fb63 100644
--- a/drivers/net/ethernet/intel/ice/ice_vsi_vlan_ops.c
+++ b/drivers/net/ethernet/intel/ice/ice_vsi_vlan_ops.c
@@ -3,6 +3,7 @@
 
 #include "ice_pf_vsi_vlan_ops.h"
 #include "ice_vf_vsi_vlan_ops.h"
+#include "ice_sf_vsi_vlan_ops.h"
 #include "ice_lib.h"
 #include "ice.h"
 
@@ -77,6 +78,9 @@ void ice_vsi_init_vlan_ops(struct ice_vsi *vsi)
 	case ICE_VSI_VF:
 		ice_vf_vsi_init_vlan_ops(vsi);
 		break;
+	case ICE_VSI_SF:
+		ice_sf_vsi_init_vlan_ops(vsi);
+		break;
 	default:
 		dev_dbg(ice_pf_to_dev(vsi->back), "%s does not support VLAN operations\n",
 			ice_vsi_type_str(vsi->type));
-- 
2.42.0


