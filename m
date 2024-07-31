Return-Path: <netdev+bounces-114702-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C33BC9438A2
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 00:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E4571F22728
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 22:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D681816D9D9;
	Wed, 31 Jul 2024 22:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KRCOI9E4"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050AC16D4E5
	for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 22:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722463851; cv=none; b=lfpxnRzTLOxGFqUsMKDZ75tvv0XLzo+MdUxaCABjuKttUg1q2qSXRynN175ZCqfszWQeH1WEbYAb64xqtE3zZRswyNJX+aMGLzDZ5ceSn/024nlE14UNJ+2CE18deZHg0PXxfa9GolTwSmMfbHDeuLCKvLi56lgKK8HwebX+DtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722463851; c=relaxed/simple;
	bh=T8oR2LLAl77KZNA3xYDuAtKnZ+9fZCjaV/ZCX+4FIC4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q91WNsFVFegTIluyaoLW0FKk56GjBhhjlLtY96aNmg8CB0/ELUey6SiRkAnXjAxyeBP9am5WXGnsqssTCqsCogdVJ85kOZtQiwhBOKeg3PPr59lycKTDG2a4l5wRUsPqi2MZelK/bdhVuGwuO38iDQwcZO9/WxTxwuX6HH4JfOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KRCOI9E4; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722463850; x=1753999850;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=T8oR2LLAl77KZNA3xYDuAtKnZ+9fZCjaV/ZCX+4FIC4=;
  b=KRCOI9E4cPJrHQoWXwzAhl7+57C8dhgFmhcDNSK2Hb7gJ2shVr+ZXHsZ
   gq6AAeAQKqTgx2Tn5i9I/ZBVjwKsBzN4qaY2X5SuO65mmmPssTinDfcmD
   rCaIjYFQ+KraIhpfx03H9QqGEdBmBpcddtG5Q/NX4BZPAwUKHtI72L9Bo
   gQRciIK7zgJfemufXL1tBzXwfuUwRru++g/azGoKC1ycf0Jy7kkx2tfod
   adHRjqDS2AZPSQb/Bd9RbVMDiBi3EoAtOm+p3xvBj+dWFeTHyjelBQ4j7
   2FkImC/exMfaBCdR8z9u8T8Q5Bc/6JBBAgGY+B9iAbD8KhoiEbwlVi1RH
   g==;
X-CSE-ConnectionGUID: H53cU/uJSmiCv3kHnPsvzQ==
X-CSE-MsgGUID: JU4oP/qvQI6Q4crJ/243CA==
X-IronPort-AV: E=McAfee;i="6700,10204,11150"; a="31765506"
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; 
   d="scan'208";a="31765506"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2024 15:10:46 -0700
X-CSE-ConnectionGUID: YTPw+Tq4Qrio7Ws9OdMfgw==
X-CSE-MsgGUID: xCnBRw2wSr2NJdmKHZKQdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; 
   d="scan'208";a="54734137"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa010.jf.intel.com with ESMTP; 31 Jul 2024 15:10:46 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Piotr Raczynski <piotr.raczynski@intel.com>,
	anthony.l.nguyen@intel.com,
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
Subject: [PATCH net-next v2 05/15] ice: allocate devlink for subfunction
Date: Wed, 31 Jul 2024 15:10:16 -0700
Message-ID: <20240731221028.965449-6-anthony.l.nguyen@intel.com>
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

From: Piotr Raczynski <piotr.raczynski@intel.com>

Make devlink allocation function generic to use it for PF and for SF.

Add function for SF devlink port creation. It will be used in next
patch.

Create header file for subfunction device. Define subfunction device
structure there as it is needed for devlink allocation and port
creation.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Piotr Raczynski <piotr.raczynski@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 .../net/ethernet/intel/ice/devlink/devlink.c  | 32 +++++++++++++++
 .../net/ethernet/intel/ice/devlink/devlink.h  |  1 +
 .../ethernet/intel/ice/devlink/devlink_port.c | 41 +++++++++++++++++++
 .../ethernet/intel/ice/devlink/devlink_port.h |  3 ++
 drivers/net/ethernet/intel/ice/ice_sf_eth.h   | 21 ++++++++++
 5 files changed, 98 insertions(+)
 create mode 100644 drivers/net/ethernet/intel/ice/ice_sf_eth.h

diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink.c b/drivers/net/ethernet/intel/ice/devlink/devlink.c
index b7eb1b56f2c6..4bd7baebeb92 100644
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
@@ -1548,6 +1551,7 @@ static void ice_devlink_free(void *devlink_ptr)
  * Allocate a devlink instance for this device and return the private area as
  * the PF structure. The devlink memory is kept track of through devres by
  * adding an action to remove it when unwinding.
+ *
  */
 struct ice_pf *ice_allocate_pf(struct device *dev)
 {
@@ -1564,6 +1568,34 @@ struct ice_pf *ice_allocate_pf(struct device *dev)
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
diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink_port.c b/drivers/net/ethernet/intel/ice/devlink/devlink_port.c
index 5d1fe08e4bab..f06baabd0112 100644
--- a/drivers/net/ethernet/intel/ice/devlink/devlink_port.c
+++ b/drivers/net/ethernet/intel/ice/devlink/devlink_port.c
@@ -489,6 +489,47 @@ void ice_devlink_destroy_vf_port(struct ice_vf *vf)
 	devl_port_unregister(&vf->devlink_port);
 }
 
+/**
+ * ice_devlink_create_sf_dev_port - Register virtual port for a subfunction
+ * @sf_dev: the subfunction device to create a devlink port for
+ *
+ * Register virtual flavour devlink port for the subfunction auxiliary device
+ * created after activating a dynamically added devlink port.
+ *
+ * Return: zero on success or an error code on failure.
+ */
+int ice_devlink_create_sf_dev_port(struct ice_sf_dev *sf_dev)
+{
+	struct devlink_port_attrs attrs = {};
+	struct ice_dynamic_port *dyn_port;
+	struct devlink_port *devlink_port;
+	struct devlink *devlink;
+	struct ice_vsi *vsi;
+
+	dyn_port = sf_dev->dyn_port;
+	vsi = dyn_port->vsi;
+
+	devlink_port = &sf_dev->priv->devlink_port;
+
+	attrs.flavour = DEVLINK_PORT_FLAVOUR_VIRTUAL;
+
+	devlink_port_attrs_set(devlink_port, &attrs);
+	devlink = priv_to_devlink(sf_dev->priv);
+
+	return devl_port_register(devlink, devlink_port, vsi->idx);
+}
+
+/**
+ * ice_devlink_destroy_sf_dev_port - Destroy virtual port for a subfunction
+ * @sf_dev: the subfunction device to create a devlink port for
+ *
+ * Unregisters the virtual port associated with this subfunction.
+ */
+void ice_devlink_destroy_sf_dev_port(struct ice_sf_dev *sf_dev)
+{
+	devl_port_unregister(&sf_dev->priv->devlink_port);
+}
+
 /**
  * ice_dealloc_dynamic_port - Deallocate and remove a dynamic port
  * @dyn_port: dynamic port instance to deallocate
diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink_port.h b/drivers/net/ethernet/intel/ice/devlink/devlink_port.h
index 08ebf56664a5..97b21b58c300 100644
--- a/drivers/net/ethernet/intel/ice/devlink/devlink_port.h
+++ b/drivers/net/ethernet/intel/ice/devlink/devlink_port.h
@@ -5,6 +5,7 @@
 #define _DEVLINK_PORT_H_
 
 #include "../ice.h"
+#include "../ice_sf_eth.h"
 
 /**
  * struct ice_dynamic_port - Track dynamically added devlink port instance
@@ -34,6 +35,8 @@ int ice_devlink_create_vf_port(struct ice_vf *vf);
 void ice_devlink_destroy_vf_port(struct ice_vf *vf);
 int ice_devlink_create_sf_port(struct ice_dynamic_port *dyn_port);
 void ice_devlink_destroy_sf_port(struct ice_dynamic_port *dyn_port);
+int ice_devlink_create_sf_dev_port(struct ice_sf_dev *sf_dev);
+void ice_devlink_destroy_sf_dev_port(struct ice_sf_dev *sf_dev);
 
 #define ice_devlink_port_to_dyn(port) \
 	container_of(port, struct ice_dynamic_port, devlink_port)
diff --git a/drivers/net/ethernet/intel/ice/ice_sf_eth.h b/drivers/net/ethernet/intel/ice/ice_sf_eth.h
new file mode 100644
index 000000000000..a08f8b2bceef
--- /dev/null
+++ b/drivers/net/ethernet/intel/ice/ice_sf_eth.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2024, Intel Corporation. */
+
+#ifndef _ICE_SF_ETH_H_
+#define _ICE_SF_ETH_H_
+
+#include <linux/auxiliary_bus.h>
+#include "ice.h"
+
+struct ice_sf_dev {
+	struct auxiliary_device adev;
+	struct ice_dynamic_port *dyn_port;
+	struct ice_sf_priv *priv;
+};
+
+struct ice_sf_priv {
+	struct ice_sf_dev *dev;
+	struct devlink_port devlink_port;
+};
+
+#endif /* _ICE_SF_ETH_H_ */
-- 
2.42.0


