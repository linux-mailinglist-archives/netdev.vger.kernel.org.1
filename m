Return-Path: <netdev+bounces-86396-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C4389E963
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 07:04:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7499E1F24EA7
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 05:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44C710A3E;
	Wed, 10 Apr 2024 05:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nxyDkvL3"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A7319BA6
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 05:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712725437; cv=none; b=hBRtHXTYmdPX2zF6oxD3rriJeleIlRSfcSyXXp1/07Tw+7UOkGihJy9fYZfSz2GEYaQjjwGsAdZQEdQOdfh7+LslkOSlHIkt6dwwZfDM1BKBOac+QsU+xrYtIkfjslY5cd0seD2EspARuG9RFq6QGaWdtzdnDhufdDBSEeuKYtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712725437; c=relaxed/simple;
	bh=sheLAuU3pdUMsZHYA2FAswF8HKOzIDQQaZwBbRLbHI8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bawoCRuFHyKdbPg5HnIMHJafFI5TXViB3seS1mrOWux6NWkyrVMFS8PHVNobIEZjc0NqjY7do+n/uQDrK2k2gHSGDQ+Sj58jZmoVdl1nMMHmgsE7squt24yzQPEpiQHsEZmdePgvpm6ER9mHjvCtY3bQmT0Q6MA2Lq5JhAKsS5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nxyDkvL3; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712725436; x=1744261436;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sheLAuU3pdUMsZHYA2FAswF8HKOzIDQQaZwBbRLbHI8=;
  b=nxyDkvL3E/YhoMlC8gD3x7aHeUZpkdA2MBl/yK/608Bl78RdAFes3iRu
   l3NoOp0ZrVRmPZnGh0BNxyLd/bGxvFYRTEDJ72vnm2VmbGpyW1kTpLhHL
   NU2AqCnfmksYqj0nlnKOqCiP499ihUp62R8JNSK1iuNLGUSg9TBgS2LR/
   /x7niKT8ONVJsR1JE3Qa0Iox3gqWq7SxG5eyFtRArwfUBlxwJCQxdi6DI
   fIvWiyu4Nc9q+jbSkYLKNvjY0DyWhOB9bpTRfE0q+RC7jCF5sFsOSqB04
   HdAAiRrtwS79VxzR0a+Ki6DPRVyODuBYnMt2OKmGwA+cavg8/f0SxuF8+
   A==;
X-CSE-ConnectionGUID: 3aSd4+J9RlO36bMVgQt+6g==
X-CSE-MsgGUID: OKe680sFTk++gN8YW8Kohg==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="19456230"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="19456230"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 22:03:56 -0700
X-CSE-ConnectionGUID: jzW94PEvTuuhm3J/lA8FMg==
X-CSE-MsgGUID: I7obaiJqTkuR0b8hFX/wcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="57876026"
Received: from wasp.igk.intel.com (HELO GK3153-DR2-R750-36946.localdomain.com) ([10.102.20.192])
  by orviesa001.jf.intel.com with ESMTP; 09 Apr 2024 22:03:53 -0700
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
Subject: [iwl-next v2 6/7] ice: implement netdev for subfunction
Date: Wed, 10 Apr 2024 07:08:08 +0200
Message-ID: <20240410050809.125043-7-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240410050809.125043-1-michal.swiatkowski@linux.intel.com>
References: <20240410050809.125043-1-michal.swiatkowski@linux.intel.com>
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

Signed-off-by: Piotr Raczynski <piotr.raczynski@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/intel/ice/ice_sf_eth.c | 85 ++++++++++++++++++++-
 1 file changed, 84 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_sf_eth.c b/drivers/net/ethernet/intel/ice/ice_sf_eth.c
index 70f7cbe6c609..8f0e3c5f3ea4 100644
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
+ * Returns 0 on success, negative value on failure
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
@@ -55,18 +129,26 @@ static int ice_sf_dev_probe(struct auxiliary_device *adev,
 		goto err_vsi_decfg;
 	}
 
+	err = ice_sf_cfg_netdev(dyn_port, &sf_dev->priv->devlink_port);
+	if (err) {
+		dev_err(dev, "Subfunction netdev config failed");
+		goto err_devlink_destroy;
+	}
+
 	err = ice_fltr_add_mac_and_broadcast(vsi, vsi->netdev->dev_addr,
 					     ICE_FWD_TO_VSI);
 	if (err) {
 		dev_err(dev, "can't add MAC filters %pM for VSI %d\n",
 			vsi->netdev->dev_addr, vsi->idx);
-		goto err_devlink_destroy;
+		goto err_netdev_decfg;
 	}
 
 	ice_napi_add(vsi);
 
 	return err;
 
+err_netdev_decfg:
+	ice_sf_decfg_netdev(vsi);
 err_devlink_destroy:
 	ice_devlink_destroy_sf_dev_port(sf_dev);
 err_vsi_decfg:
@@ -89,6 +171,7 @@ static void ice_sf_dev_remove(struct auxiliary_device *adev)
 
 	ice_vsi_close(vsi);
 
+	ice_sf_decfg_netdev(vsi);
 	ice_devlink_destroy_sf_dev_port(sf_dev);
 	devlink_unregister(devlink);
 	devlink_free(devlink);
-- 
2.42.0


