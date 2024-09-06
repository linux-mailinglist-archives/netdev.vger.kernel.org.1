Return-Path: <netdev+bounces-126096-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DD9F96FDFA
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 00:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E29261F21F28
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 22:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6210815B125;
	Fri,  6 Sep 2024 22:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g9bfM22M"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6F115B0E3
	for <netdev@vger.kernel.org>; Fri,  6 Sep 2024 22:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725661817; cv=none; b=A48pVQ7pQ1UtDT5jRQGA5EeUVUMpl2t9yXo/neav5slkOQ36xADD3LX1xzWC28wO090CUsFUnnsNQ8+So3GGTzOW1wST568V2KYh2Wy8ECZ8HjdHxxxHJjfajtfFC0iEst4tn04L+wjMo/MDhjO7g4Cbpr5UPQwFW5IpXkP0IKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725661817; c=relaxed/simple;
	bh=DQqBarLBElNpAaNz7Pfa9YV4LLfoABN9pv3m4nVpmik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RbDTQfVAjl5WMP0wK2wgsPM3DP93Oqixw9XRju70Rcxt3Yz85gduHFXy8OeAttUVUbsoyBlqhSuJHc3oceP/x5zoM9zpPIYBV70ZXmFpixVqYmGPueTVvevqReIMAqys36XlFFqbSNJXYZb/Pihs7UihHAIQvo4yAYyIH7rY/h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g9bfM22M; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725661816; x=1757197816;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DQqBarLBElNpAaNz7Pfa9YV4LLfoABN9pv3m4nVpmik=;
  b=g9bfM22McKzeNKKHYhV+KX2d5wgZySo3eC+F5F748fSij5yC+kFu7rr1
   JyP7wpon3Zlz4hpPRphbJX8MdqwFI4JRwilj1Gsa1BdEn09Cci2s3iFVw
   TKGYBF2bAMVDGZey3+bhnVE6CpflI8z2NFkevSbWKyrl39Uh8Gr7PZJZl
   H4NyCZdMnzvN7Wv6Q7WJsNJDDzY5xe/P3regVMb6UTctYaqd7EysZbQB8
   yQxek4BAvSKt3gODxTkdySTMq1OhHzfdQmMrxEL+ARyBW5xTcMeAFSX4f
   iA8cib+lSoHps/4b5g1anftE72TxZe3ABPGHaez+koQxcstciZMjAfGAV
   Q==;
X-CSE-ConnectionGUID: kwO8RExBS+CKdVvmsTa+SQ==
X-CSE-MsgGUID: 3NFYlEzLT3mvis0mnkDp0g==
X-IronPort-AV: E=McAfee;i="6700,10204,11187"; a="35030705"
X-IronPort-AV: E=Sophos;i="6.10,209,1719903600"; 
   d="scan'208";a="35030705"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2024 15:30:15 -0700
X-CSE-ConnectionGUID: BXKn3Jc0RNSx7W9I3pWT8Q==
X-CSE-MsgGUID: +suRTBkLTJCV//ce0Ok48g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,209,1719903600"; 
   d="scan'208";a="70490413"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa005.fm.intel.com with ESMTP; 06 Sep 2024 15:30:14 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: anthony.l.nguyen@intel.com,
	michal.swiatkowski@linux.intel.com,
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
Subject: [PATCH net-next v5 05/15] ice: allocate devlink for subfunction
Date: Fri,  6 Sep 2024 15:29:56 -0700
Message-ID: <20240906223010.2194591-6-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240906223010.2194591-1-anthony.l.nguyen@intel.com>
References: <20240906223010.2194591-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Piotr Raczynski <piotr.raczynski@intel.com>

Allocate devlink for subfunction instance.

Create header file for subfunction device. Define subfunction device
structure there as it is needed for devlink allocation.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Piotr Raczynski <piotr.raczynski@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 .../net/ethernet/intel/ice/devlink/devlink.c  | 31 +++++++++++++++++++
 .../net/ethernet/intel/ice/devlink/devlink.h  |  1 +
 drivers/net/ethernet/intel/ice/ice_sf_eth.h   | 15 +++++++++
 3 files changed, 47 insertions(+)
 create mode 100644 drivers/net/ethernet/intel/ice/ice_sf_eth.h

diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink.c b/drivers/net/ethernet/intel/ice/devlink/devlink.c
index b7eb1b56f2c6..445538959459 100644
--- a/drivers/net/ethernet/intel/ice/devlink/devlink.c
+++ b/drivers/net/ethernet/intel/ice/devlink/devlink.c
@@ -10,6 +10,7 @@
 #include "ice_eswitch.h"
 #include "ice_fw_update.h"
 #include "ice_dcb_lib.h"
+#include "ice_sf_eth.h"
 
 /* context for devlink info version reporting */
 struct ice_info_ctx {
@@ -1282,6 +1283,8 @@ static const struct devlink_ops ice_devlink_ops = {
 	.port_new = ice_devlink_port_new,
 };
 
+static const struct devlink_ops ice_sf_devlink_ops;
+
 static int
 ice_devlink_enable_roce_get(struct devlink *devlink, u32 id,
 			    struct devlink_param_gset_ctx *ctx)
@@ -1564,6 +1567,34 @@ struct ice_pf *ice_allocate_pf(struct device *dev)
 	return devlink_priv(devlink);
 }
 
+/**
+ * ice_allocate_sf - Allocate devlink and return SF structure pointer
+ * @dev: the device to allocate for
+ * @pf: pointer to the PF structure
+ *
+ * Allocate a devlink instance for SF.
+ *
+ * Return: ice_sf_priv pointer to allocated memory or ERR_PTR in case of error
+ */
+struct ice_sf_priv *ice_allocate_sf(struct device *dev, struct ice_pf *pf)
+{
+	struct devlink *devlink;
+	int err;
+
+	devlink = devlink_alloc(&ice_sf_devlink_ops, sizeof(struct ice_sf_priv),
+				dev);
+	if (!devlink)
+		return ERR_PTR(-ENOMEM);
+
+	err = devl_nested_devlink_set(priv_to_devlink(pf), devlink);
+	if (err) {
+		devlink_free(devlink);
+		return ERR_PTR(err);
+	}
+
+	return devlink_priv(devlink);
+}
+
 /**
  * ice_devlink_register - Register devlink interface for this PF
  * @pf: the PF to register the devlink for.
diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink.h b/drivers/net/ethernet/intel/ice/devlink/devlink.h
index d291c0e2e17b..1af3b0763fbb 100644
--- a/drivers/net/ethernet/intel/ice/devlink/devlink.h
+++ b/drivers/net/ethernet/intel/ice/devlink/devlink.h
@@ -5,6 +5,7 @@
 #define _ICE_DEVLINK_H_
 
 struct ice_pf *ice_allocate_pf(struct device *dev);
+struct ice_sf_priv *ice_allocate_sf(struct device *dev, struct ice_pf *pf);
 
 void ice_devlink_register(struct ice_pf *pf);
 void ice_devlink_unregister(struct ice_pf *pf);
diff --git a/drivers/net/ethernet/intel/ice/ice_sf_eth.h b/drivers/net/ethernet/intel/ice/ice_sf_eth.h
new file mode 100644
index 000000000000..267da33a0135
--- /dev/null
+++ b/drivers/net/ethernet/intel/ice/ice_sf_eth.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2024, Intel Corporation. */
+
+#ifndef _ICE_SF_ETH_H_
+#define _ICE_SF_ETH_H_
+
+#include <linux/auxiliary_bus.h>
+#include "ice.h"
+
+struct ice_sf_priv {
+	struct ice_sf_dev *dev;
+	struct devlink_port devlink_port;
+};
+
+#endif /* _ICE_SF_ETH_H_ */
-- 
2.42.0


