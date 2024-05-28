Return-Path: <netdev+bounces-98384-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 365F98D1363
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 06:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 263241C2156D
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 04:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD0518E25;
	Tue, 28 May 2024 04:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wsq/rMC5"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFA2179A7
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 04:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716870812; cv=none; b=LeelS5GWCBIN5XKcoeLGZWxQJwLWivw1NJutN9++j+dEayhMEbVgLbr64i+CkbZqWPq9N+LFWZ2kseBQtv+0R+35nbP+jEAf3UFYNgt+XrE1xe8SAez4zHjawtonLrehqbDIDS8UDPr4j1oHok76aJnQnORCXVMAp3sgCd+qeUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716870812; c=relaxed/simple;
	bh=wTiie1WC0v0OwejiEl33D0ZP6bZoFdlvg+u6AavqK7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AxCtNb8kl2UtoHBDjCOMlSzoyQX14PpNB26JHK23vxJ/9eQ77bkiASNT13ZFB3HNifyKfXzWcmhyp4g5f5a8DUdrMvZZhBxUHKOkKT+Sf0AcJnfIuJjN3JRdMQ+SwJ2R3jM3G/0oQahNrsn+VfgbhPqf6eW8MGgyHqrdHtxLWw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wsq/rMC5; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716870811; x=1748406811;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wTiie1WC0v0OwejiEl33D0ZP6bZoFdlvg+u6AavqK7A=;
  b=Wsq/rMC5AP2rh/2fdf75yj263Ct97EfwzSTpVRie/w1pasNLIGtzm5nv
   6f+UNKQ4xhVrpQahNmXjtfAqAyGFX/jUuIqbBbNXBn5oKfzjVOGDCq76h
   c/UJuAsJVqSYiOkWMfXM92KKfx57AYEVsPOq66fX+WfstpqgybIMFWdSR
   x9lA+MTv7SYfy2HLER1VS7m72EunG/mRXZ3RzjLVc6QKJr3nfA+cHjc1d
   cxYs6cVl9cXblSgD/Lg/l/HH1mTUp2U9P9cS2JevqKqq3pkHmEYNVJIqA
   AdAUJbET4xUDb0wvuYnR7aTcMcN3Qa4GcU0/0bO1p+hbj942CymfIVgtR
   w==;
X-CSE-ConnectionGUID: 5Ry3zPq6Q5aGJf5dWdSJLw==
X-CSE-MsgGUID: g87n6TkWTyOL8Mbk6zFEwA==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13020118"
X-IronPort-AV: E=Sophos;i="6.08,194,1712646000"; 
   d="scan'208";a="13020118"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 21:33:30 -0700
X-CSE-ConnectionGUID: FziZuXqrT0es9V5Fo2baDA==
X-CSE-MsgGUID: MmamSi3OTmepC8V5NymTyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,194,1712646000"; 
   d="scan'208";a="66152419"
Received: from wasp.igk.intel.com (HELO GK3153-DR2-R750-36946.localdomain.com) ([10.102.20.192])
  by fmviesa001.fm.intel.com with ESMTP; 27 May 2024 21:33:27 -0700
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
Subject: [iwl-next v3 07/15] ice: implement netdev for subfunction
Date: Tue, 28 May 2024 06:38:05 +0200
Message-ID: <20240528043813.1342483-8-michal.swiatkowski@linux.intel.com>
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

From: Piotr Raczynski <piotr.raczynski@intel.com>

Configure netdevice for subfunction usecase. Mostly it is reusing ops
from the PF netdevice.

SF netdev is linked to devlink port registered after SF activation.

Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Piotr Raczynski <piotr.raczynski@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/intel/ice/ice_sf_eth.c | 85 ++++++++++++++++++++-
 1 file changed, 84 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_sf_eth.c b/drivers/net/ethernet/intel/ice/ice_sf_eth.c
index abe495c2d033..3a540a2638d1 100644
--- a/drivers/net/ethernet/intel/ice/ice_sf_eth.c
+++ b/drivers/net/ethernet/intel/ice/ice_sf_eth.c
@@ -2,11 +2,85 @@
 /* Copyright (c) 2024, Intel Corporation. */
 #include "ice.h"
 #include "ice_lib.h"
+#include "ice_txrx.h"
 #include "ice_fltr.h"
 #include "ice_sf_eth.h"
 #include "devlink/devlink_port.h"
 #include "devlink/devlink.h"
 
+static const struct net_device_ops ice_sf_netdev_ops = {
+	.ndo_open = ice_open,
+	.ndo_stop = ice_stop,
+	.ndo_start_xmit = ice_start_xmit,
+	.ndo_vlan_rx_add_vid = ice_vlan_rx_add_vid,
+	.ndo_vlan_rx_kill_vid = ice_vlan_rx_kill_vid,
+	.ndo_change_mtu = ice_change_mtu,
+	.ndo_get_stats64 = ice_get_stats64,
+	.ndo_tx_timeout = ice_tx_timeout,
+	.ndo_bpf = ice_xdp,
+	.ndo_xdp_xmit = ice_xdp_xmit,
+	.ndo_xsk_wakeup = ice_xsk_wakeup,
+};
+
+/**
+ * ice_sf_cfg_netdev - Allocate, configure and register a netdev
+ * @dyn_port: subfunction associated with configured netdev
+ * @devlink_port: subfunction devlink port to be linked with netdev
+ *
+ * Return: 0 on success, negative value on failure
+ */
+static int ice_sf_cfg_netdev(struct ice_dynamic_port *dyn_port,
+			     struct devlink_port *devlink_port)
+{
+	struct ice_vsi *vsi = dyn_port->vsi;
+	struct ice_netdev_priv *np;
+	struct net_device *netdev;
+	int err;
+
+	netdev = alloc_etherdev_mqs(sizeof(*np), vsi->alloc_txq,
+				    vsi->alloc_rxq);
+	if (!netdev)
+		return -ENOMEM;
+
+	SET_NETDEV_DEV(netdev, &vsi->back->pdev->dev);
+	set_bit(ICE_VSI_NETDEV_ALLOCD, vsi->state);
+	vsi->netdev = netdev;
+	np = netdev_priv(netdev);
+	np->vsi = vsi;
+
+	ice_set_netdev_features(netdev);
+
+	netdev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
+			       NETDEV_XDP_ACT_XSK_ZEROCOPY |
+			       NETDEV_XDP_ACT_RX_SG;
+
+	eth_hw_addr_set(netdev, dyn_port->hw_addr);
+	ether_addr_copy(netdev->perm_addr, dyn_port->hw_addr);
+	netdev->netdev_ops = &ice_sf_netdev_ops;
+	SET_NETDEV_DEVLINK_PORT(netdev, devlink_port);
+
+	err = register_netdev(netdev);
+	if (err) {
+		free_netdev(netdev);
+		vsi->netdev = NULL;
+		return -ENOMEM;
+	}
+	set_bit(ICE_VSI_NETDEV_REGISTERED, vsi->state);
+	netif_carrier_off(netdev);
+	netif_tx_stop_all_queues(netdev);
+
+	return 0;
+}
+
+static void ice_sf_decfg_netdev(struct ice_vsi *vsi)
+{
+	unregister_netdev(vsi->netdev);
+	clear_bit(ICE_VSI_NETDEV_REGISTERED, vsi->state);
+	free_netdev(vsi->netdev);
+	vsi->netdev = NULL;
+	clear_bit(ICE_VSI_NETDEV_ALLOCD, vsi->state);
+}
+
 /**
  * ice_sf_dev_probe - subfunction driver probe function
  * @adev: pointer to the auxiliary device
@@ -57,10 +131,16 @@ static int ice_sf_dev_probe(struct auxiliary_device *adev,
 		goto err_vsi_decfg;
 	}
 
+	err = ice_sf_cfg_netdev(dyn_port, &sf_dev->priv->devlink_port);
+	if (err) {
+		dev_err(dev, "Subfunction netdev config failed");
+		goto err_devlink_destroy;
+	}
+
 	err = devl_port_fn_devlink_set(&dyn_port->devlink_port, devlink);
 	if (err) {
 		dev_err(dev, "Can't link devlink instance to SF devlink port");
-		goto err_devlink_destroy;
+		goto err_netdev_decfg;
 	}
 
 	ice_napi_add(vsi);
@@ -70,6 +150,8 @@ static int ice_sf_dev_probe(struct auxiliary_device *adev,
 
 	return 0;
 
+err_netdev_decfg:
+	ice_sf_decfg_netdev(vsi);
 err_devlink_destroy:
 	ice_devlink_destroy_sf_dev_port(sf_dev);
 err_vsi_decfg:
@@ -98,6 +180,7 @@ static void ice_sf_dev_remove(struct auxiliary_device *adev)
 
 	ice_vsi_close(vsi);
 
+	ice_sf_decfg_netdev(vsi);
 	ice_devlink_destroy_sf_dev_port(sf_dev);
 	devl_unregister(devlink);
 	devl_unlock(devlink);
-- 
2.42.0


