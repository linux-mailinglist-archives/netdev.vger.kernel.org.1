Return-Path: <netdev+bounces-87273-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 036568A2683
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 08:26:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 121D51C20FAB
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 06:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3F73716D;
	Fri, 12 Apr 2024 06:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IWGLIs6q"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9DA37144
	for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 06:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712903184; cv=none; b=uAtTomODAgTTbl9XnRG2mi3UmATSV0BrEhQr32OmpVmMiXhWvCWsE59dJ8KyZVuvthcHzV5arukL7pZjOebp1BU+aUgENy0ezBJ6EyZpV6f5CAeZ2CmuDWKejvUN46ZFmSd86+/6aH4mxhNbgxGJH7dkjLng45PLQGFCKFP+K70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712903184; c=relaxed/simple;
	bh=CAdSWJrlo/jH+hRCBU8OGqVR1JVvOByjY5/JPAG89xE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ctI7s5W1RfVZ0bdQxDc5atzsg8MZbSwrNlNF29ewpVnomUX5ewqzRo7SFH0RGWniu22Dp03BrHbFf3BLerwM5AqmcDvoRMvS7ABR67aXQGDLPNEvLD/fFhCjn2FsQK57DhVyP2J/nF9IVQiOde97ewnmgmCGvg4jJ8lF7fUgf6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IWGLIs6q; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712903182; x=1744439182;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CAdSWJrlo/jH+hRCBU8OGqVR1JVvOByjY5/JPAG89xE=;
  b=IWGLIs6q4ftSvUNMP4XMyBFWeHtMEXwEInczQMUL1onNdDdcjbJRK1sQ
   qPlNp2Dl2un7Znh4ne0naGXkoEWKTmx39bSMUhShWj16rJVdDJqp3oaPM
   C7/WgNDTqo+ltCJF5taikUvWcs36KRJrII6iPSIfLeXIpHWMQ7ZQO04qG
   0Cn5sLcEbFYxosshUW4UrO6JoGTy2XN/gi3clMvG+3m3HVvjDb2FpuQeD
   EEaLShNPjifroznyB0bdgUpGZkANSGD/WsXIJ4FEZEDDgCtxhruPEEMH/
   Qvs+VvOjKhYYlUILvBxhWPoP5d52wVe4AURDmiXEtvpBpBhr/GsImXYF0
   w==;
X-CSE-ConnectionGUID: yP+byN4bTc2NmfGvfPfWMw==
X-CSE-MsgGUID: SWKcIc0SQhSMc9PN9lJUfA==
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="18952951"
X-IronPort-AV: E=Sophos;i="6.07,195,1708416000"; 
   d="scan'208";a="18952951"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 23:26:22 -0700
X-CSE-ConnectionGUID: 1MaSQLnWQhypkY0QP4LQMw==
X-CSE-MsgGUID: fngFjdfERE+9fsLkIW3DKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,195,1708416000"; 
   d="scan'208";a="21105121"
Received: from wasp.igk.intel.com (HELO GK3153-DR2-R750-36946.localdomain.com) ([10.102.20.192])
  by orviesa009.jf.intel.com with ESMTP; 11 Apr 2024 23:26:19 -0700
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
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	mateusz.polchlopek@intel.com,
	Piotr Raczynski <piotr.raczynski@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: [iwl-next v3 4/7] ice: allocate devlink for subfunction
Date: Fri, 12 Apr 2024 08:30:50 +0200
Message-ID: <20240412063053.339795-5-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240412063053.339795-1-michal.swiatkowski@linux.intel.com>
References: <20240412063053.339795-1-michal.swiatkowski@linux.intel.com>
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

Signed-off-by: Piotr Raczynski <piotr.raczynski@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 .../net/ethernet/intel/ice/devlink/devlink.c  | 47 ++++++++++++++---
 .../net/ethernet/intel/ice/devlink/devlink.h  |  1 +
 .../ethernet/intel/ice/devlink/devlink_port.c | 51 +++++++++++++++++++
 .../ethernet/intel/ice/devlink/devlink_port.h |  3 ++
 drivers/net/ethernet/intel/ice/ice_sf_eth.h   | 21 ++++++++
 5 files changed, 117 insertions(+), 6 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/ice/ice_sf_eth.h

diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink.c b/drivers/net/ethernet/intel/ice/devlink/devlink.c
index 661af04c8eef..5a78bf08e731 100644
--- a/drivers/net/ethernet/intel/ice/devlink/devlink.c
+++ b/drivers/net/ethernet/intel/ice/devlink/devlink.c
@@ -10,6 +10,7 @@
 #include "ice_eswitch.h"
 #include "ice_fw_update.h"
 #include "ice_dcb_lib.h"
+#include "ice_sf_eth.h"
 
 /* context for devlink info version reporting */
 struct ice_info_ctx {
@@ -1286,6 +1287,8 @@ static const struct devlink_ops ice_devlink_ops = {
 	.port_new = ice_devlink_port_new,
 };
 
+static const struct devlink_ops ice_sf_devlink_ops;
+
 static int
 ice_devlink_enable_roce_get(struct devlink *devlink, u32 id,
 			    struct devlink_param_gset_ctx *ctx)
@@ -1417,18 +1420,23 @@ static void ice_devlink_free(void *devlink_ptr)
 }
 
 /**
- * ice_allocate_pf - Allocate devlink and return PF structure pointer
+ * ice_devlink_alloc - Allocate devlink and return devlink priv pointer
  * @dev: the device to allocate for
+ * @priv_size: size of the priv memory
+ * @ops: pointer to devlink ops for this device
+ *
+ * Allocate a devlink instance for this device and return the private pointer
+ * The devlink memory is kept track of through devres by adding an action to
+ * remove it when unwinding.
  *
- * Allocate a devlink instance for this device and return the private area as
- * the PF structure. The devlink memory is kept track of through devres by
- * adding an action to remove it when unwinding.
+ * Return: void pointer to allocated memory
  */
-struct ice_pf *ice_allocate_pf(struct device *dev)
+static void *ice_devlink_alloc(struct device *dev, size_t priv_size,
+			       const struct devlink_ops *ops)
 {
 	struct devlink *devlink;
 
-	devlink = devlink_alloc(&ice_devlink_ops, sizeof(struct ice_pf), dev);
+	devlink = devlink_alloc(ops, priv_size, dev);
 	if (!devlink)
 		return NULL;
 
@@ -1439,6 +1447,33 @@ struct ice_pf *ice_allocate_pf(struct device *dev)
 	return devlink_priv(devlink);
 }
 
+/**
+ * ice_allocate_pf - Allocate devlink and return PF structure pointer
+ * @dev: the device to allocate for
+ *
+ * Allocate a devlink instance for PF.
+ *
+ * Return: void pointer to allocated memory
+ */
+struct ice_pf *ice_allocate_pf(struct device *dev)
+{
+	return ice_devlink_alloc(dev, sizeof(struct ice_pf), &ice_devlink_ops);
+}
+
+/**
+ * ice_allocate_sf - Allocate devlink and return SF structure pointer
+ * @dev: the device to allocate for
+ *
+ * Allocate a devlink instance for SF.
+ *
+ * Return: void pointer to allocated memory
+ */
+struct ice_sf_priv *ice_allocate_sf(struct device *dev)
+{
+	return ice_devlink_alloc(dev, sizeof(struct ice_sf_priv),
+				 &ice_sf_devlink_ops);
+}
+
 /**
  * ice_devlink_register - Register devlink interface for this PF
  * @pf: the PF to register the devlink for.
diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink.h b/drivers/net/ethernet/intel/ice/devlink/devlink.h
index d291c0e2e17b..1b2a5980d5e8 100644
--- a/drivers/net/ethernet/intel/ice/devlink/devlink.h
+++ b/drivers/net/ethernet/intel/ice/devlink/devlink.h
@@ -5,6 +5,7 @@
 #define _ICE_DEVLINK_H_
 
 struct ice_pf *ice_allocate_pf(struct device *dev);
+struct ice_sf_priv *ice_allocate_sf(struct device *dev);
 
 void ice_devlink_register(struct ice_pf *pf);
 void ice_devlink_unregister(struct ice_pf *pf);
diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink_port.c b/drivers/net/ethernet/intel/ice/devlink/devlink_port.c
index f5e305a71bd0..1b933083f551 100644
--- a/drivers/net/ethernet/intel/ice/devlink/devlink_port.c
+++ b/drivers/net/ethernet/intel/ice/devlink/devlink_port.c
@@ -432,6 +432,57 @@ void ice_devlink_destroy_vf_port(struct ice_vf *vf)
 	devlink_port_unregister(&vf->devlink_port);
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
+	struct devlink_port *devlink_port;
+	struct ice_dynamic_port *dyn_port;
+	struct devlink *devlink;
+	struct ice_vsi *vsi;
+	struct device *dev;
+	struct ice_pf *pf;
+	int err;
+
+	dyn_port = sf_dev->dyn_port;
+	vsi = dyn_port->vsi;
+	pf = dyn_port->pf;
+	dev = ice_pf_to_dev(pf);
+
+	devlink_port = &sf_dev->priv->devlink_port;
+
+	attrs.flavour = DEVLINK_PORT_FLAVOUR_VIRTUAL;
+
+	devlink_port_attrs_set(devlink_port, &attrs);
+	devlink = priv_to_devlink(sf_dev->priv);
+
+	err = devl_port_register(devlink, devlink_port, vsi->idx);
+	if (err)
+		dev_err(dev, "Failed to create virtual devlink port for auxiliary subfunction device %d",
+			vsi->idx);
+
+	return err;
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
  * ice_activate_dynamic_port - Activate a dynamic port
  * @dyn_port: dynamic port instance to activate
diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink_port.h b/drivers/net/ethernet/intel/ice/devlink/devlink_port.h
index 30146fef64b9..1f66705e0261 100644
--- a/drivers/net/ethernet/intel/ice/devlink/devlink_port.h
+++ b/drivers/net/ethernet/intel/ice/devlink/devlink_port.h
@@ -5,6 +5,7 @@
 #define _DEVLINK_PORT_H_
 
 #include "../ice.h"
+#include "ice_sf_eth.h"
 
 /**
  * struct ice_dynamic_port - Track dynamically added devlink port instance
@@ -30,6 +31,8 @@ int ice_devlink_create_pf_port(struct ice_pf *pf);
 void ice_devlink_destroy_pf_port(struct ice_pf *pf);
 int ice_devlink_create_vf_port(struct ice_vf *vf);
 void ice_devlink_destroy_vf_port(struct ice_vf *vf);
+int ice_devlink_create_sf_dev_port(struct ice_sf_dev *sf_dev);
+void ice_devlink_destroy_sf_dev_port(struct ice_sf_dev *sf_dev);
 
 #define ice_devlink_port_to_dyn(p) \
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


