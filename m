Return-Path: <netdev+bounces-114711-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4434A9438AB
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 00:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 018E6282E6D
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 22:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE6B16E88C;
	Wed, 31 Jul 2024 22:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nhe9oQ6D"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CFC16DECD
	for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 22:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722463857; cv=none; b=Yaxg4HUGCOhHxS5LHSjvFJcW5B92Loc28epRO6nD1LCOuhbWGLVlvsMVYcFl9pprsIiBUDpV6nrAmPTAFwsLRiKyFL/CKXQxQfbY9gC2KvptAD0ctK3V82TWfp/f0APF9sCOkhmTuMfL+2P+KAkxhGcjiQ0KiHcjfoovfO4HgAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722463857; c=relaxed/simple;
	bh=V5fLRBHU6L9TVPTzFtu8U45lNYZhaSfQGxIENGDS9K0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qoRMOnvEMOv6bS/UsEHNrdnNkcMBc1bYZdPfbpAWyo7NiWW4Bmoczaem1QEyx0w9Ao7r79+IaMwZkJZO4XmoW1KypRO3IQNl7GJu7cpKv0hSs0OkKyBy4/R7F/ANREmJHkUAnUjBHw41QTsDFdUfwZPYZz5hW231Ym1rCWhgkYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nhe9oQ6D; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722463856; x=1753999856;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=V5fLRBHU6L9TVPTzFtu8U45lNYZhaSfQGxIENGDS9K0=;
  b=nhe9oQ6DjaZagjGJT9Yzi9bZ0zVm1TnYa4QaDAfZg1OVpKXSO/1+Xl66
   7UiYyG/46QstWbbhAuJTAlDUPibid9DvPIU4Tp4vgaP4l/DMXfdyvpqP7
   d6UkHqCTbou2ZQzrorzp3MvyJRQwX+yp35n5/q65SPKP4L6kZd1zlLtSJ
   boA5hkxhfjjQuoE4GOp0+4VFUP5yxk7co0TLJkBtKrfrtN1C8cwzCeK1u
   NgdFHenmA00yvHrLRVX5VTUZuerCe9hl3eApOzGmUeM4A8bdmHdyKsT8s
   TeU3M5lDoAxYUlDpdWbcSZsKh7hXt15iKOldgN5FWrIxIc2UcbIVoxmha
   Q==;
X-CSE-ConnectionGUID: XwlcqEKxQ8OZiyuFCZGZ1w==
X-CSE-MsgGUID: E1PH004oRlmggoBEXS96eg==
X-IronPort-AV: E=McAfee;i="6700,10204,11150"; a="31765583"
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; 
   d="scan'208";a="31765583"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2024 15:10:47 -0700
X-CSE-ConnectionGUID: fsfMmBXoQ/mYeGWsmYSflA==
X-CSE-MsgGUID: 73uFpZ4qQ5mMYai+E8v8eQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; 
   d="scan'208";a="54734179"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa010.jf.intel.com with ESMTP; 31 Jul 2024 15:10:47 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	anthony.l.nguyen@intel.com,
	jiri@nvidia.com,
	shayd@nvidia.com,
	wojciech.drewek@intel.com,
	horms@kernel.org,
	sridhar.samudrala@intel.com,
	mateusz.polchlopek@intel.com,
	kalesh-anakkur.purayil@broadcom.com,
	michal.kubiak@intel.com,
	pio.raczynski@gmail.com,
	przemyslaw.kitszel@intel.com,
	jacob.e.keller@intel.com,
	maciej.fijalkowski@intel.com,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net-next v2 14/15] ice: basic support for VLAN in subfunctions
Date: Wed, 31 Jul 2024 15:10:25 -0700
Message-ID: <20240731221028.965449-15-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240731221028.965449-1-anthony.l.nguyen@intel.com>
References: <20240731221028.965449-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Implement add / delete vlan for subfunction type VSI.

Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
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


