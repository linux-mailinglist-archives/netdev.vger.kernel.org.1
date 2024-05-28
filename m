Return-Path: <netdev+bounces-98391-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E1A08D136F
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 06:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC4D428344E
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 04:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E5C1C68D;
	Tue, 28 May 2024 04:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MR1fGO6n"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC83224D5
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 04:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716870832; cv=none; b=YdMqzqakHOp2rhgkAQkxIWKFiG6DIirJ8PaQkKAJxX5MOg4I4rMzsPVcO2vZBW0dFvqrGiizAQq6H5xQHfcCi83YFFYBWkgm4r1iWsiHvH4RTEPG3yDR4wFj5JmEBIQHYfcvjdAxk+TfIBhB8w+kP1ljg8OPCPai2bAL+y/G/hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716870832; c=relaxed/simple;
	bh=eltzYPXEe6DjzwURvU/HaK1+yLcnmQPP8HVFJtBJ5LI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WUmNcAyu5NG1C1yj/rxPl7P+kP7DCyEVbatMwLz6cfxBd8gkXLIEb9NsbuuYlnaTAJk8HBrdHq74JOK6wmui/be23AKuecSzrQfP3mFPGOQ+b7jY4mzKknyFJ3zQbClmyaD6NYu+NuzD5U8q3ZRJyzycZd0ShtSJJ93KycLYYUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MR1fGO6n; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716870831; x=1748406831;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eltzYPXEe6DjzwURvU/HaK1+yLcnmQPP8HVFJtBJ5LI=;
  b=MR1fGO6nZPM9ytq+BjPJehm2aeu0cG9FPUHNR2Y2WECUKW1Y3cZvZ3t8
   X99Wz1X0LTw+rK53ZuJqx5BUuLXJooAjx6ljRM2KxTrWB+ZKdC6zimpBK
   2jOdzFkWNib7nAxJyck3JVCsgJ2l5VxKaFr48+/efJ/8gqKT4yjZGArOU
   evXxykUJGn2B8pp5nvnjh0FUbEKUdcKeCKID6a+9vdqTcL9p8H+fyu1dP
   SznCgt5q+IVCFlrv8O3JF3m4XHNBVfdG3I2R6V5E+gVj+tl1nnQCjY8cC
   NLa4USvkbKHXH8xz8Lo2bAeX0aNcEKFJ3SikOzpr4sXb0FpiCrqMswgYf
   A==;
X-CSE-ConnectionGUID: TrbYotADSASOCjCRwmY5lw==
X-CSE-MsgGUID: Pv3fvdj+Qqe6MZrbVbFj0Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13020155"
X-IronPort-AV: E=Sophos;i="6.08,194,1712646000"; 
   d="scan'208";a="13020155"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 21:33:50 -0700
X-CSE-ConnectionGUID: c0YM2r2LR+KTPpEir2dItQ==
X-CSE-MsgGUID: TGOMJh0iRUiZFVskra47xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,194,1712646000"; 
   d="scan'208";a="66152444"
Received: from wasp.igk.intel.com (HELO GK3153-DR2-R750-36946.localdomain.com) ([10.102.20.192])
  by fmviesa001.fm.intel.com with ESMTP; 27 May 2024 21:33:48 -0700
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
	jiri@nvidia.com,
	mateusz.polchlopek@intel.com,
	shayd@nvidia.com,
	kalesh-anakkur.purayil@broadcom.com
Subject: [iwl-next v3 14/15] ice: basic support for VLAN in subfunctions
Date: Tue, 28 May 2024 06:38:12 +0200
Message-ID: <20240528043813.1342483-15-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240528043813.1342483-1-michal.swiatkowski@linux.intel.com>
References: <20240528043813.1342483-1-michal.swiatkowski@linux.intel.com>
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
index 4d987f5dcdc1..f5ff5fba0c3a 100644
--- a/drivers/net/ethernet/intel/ice/Makefile
+++ b/drivers/net/ethernet/intel/ice/Makefile
@@ -32,6 +32,7 @@ ice-y := ice_main.o	\
 	 devlink/devlink.o	\
 	 devlink/devlink_port.o \
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


