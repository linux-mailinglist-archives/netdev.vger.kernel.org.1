Return-Path: <netdev+bounces-140619-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE6E9B743F
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 07:00:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AF762858F8
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 06:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C69E13D518;
	Thu, 31 Oct 2024 06:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jEgqIpaP"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0564681E
	for <netdev@vger.kernel.org>; Thu, 31 Oct 2024 06:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730354415; cv=none; b=KNuWMizju+d7JblkHvMw8sBccc43GhFfRtOn/0USvjb2m4pL1QRQMWg57zMpYmU+TQquMJA0PLEEvw+ZKw15r60/FWMN8A0ybUNB2sZlYCup9x3st6c+h6nTw1NBCr3ooPN1mMgbD6KCurkudcqpbRQtywNQFeX4OZLuMVA5SLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730354415; c=relaxed/simple;
	bh=FUmduMo3n7mNXAayX+cLFGBWrO/DPfcJO69NELUXLtY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CBVEgXzdZipc3u1qkS5H6eZUaPdoMEeepYm0X1lhjwWdDZ20HYDrQ37mPrpQ1W/Oi7FKca+SKFYtReEp6aYobtMrDFGDvs9vzHZBO/5oLpcxGrdR5eEpYImenbHYfp6PnflzvKa9/u8+gyt+RDS4kWQ/L7S0oQxB1GgNR7wH9tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jEgqIpaP; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730354413; x=1761890413;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FUmduMo3n7mNXAayX+cLFGBWrO/DPfcJO69NELUXLtY=;
  b=jEgqIpaPUCthwxbT0L0pNca0ek1952Kf7o7ekazAyKfHDY2qIO76l0hL
   FxfbkyDsftF4M0jqswNoLVfWn1Oul/3UshxwaVZ4np+FJ0iptE6QJIDkb
   Sh7zVXOQK1SMThPcyRVelbb2y4ihBbZxAmMIYwVpjq6atoG7HAkaCqTKp
   YcXVpoEyJM554WMOp/S6WAQf9O/11z5i0BwHfAnvbA9skNSr/ncUZ8dmg
   pzZDrsXJ2wFGm+28ROebZUEpABYVg4/xjAgeRFrErNJ9VvRnttH2int+L
   pIzf6722wXbuDOSAxm/PISFgQ3vzbPrmUSIaFPx0jDTXdMYTSXH6/S9Ec
   g==;
X-CSE-ConnectionGUID: C6sw17+MQY6dukjoLokH0w==
X-CSE-MsgGUID: zz3HAyNyT3CB32hXn2fkyw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30272910"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30272910"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 23:00:13 -0700
X-CSE-ConnectionGUID: Kx70RdOuTJSYEHHQZzfr9A==
X-CSE-MsgGUID: 3dGhfWc3SBitFLWleMmBKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; 
   d="scan'208";a="82183633"
Received: from gk3153-dr2-r750-36946.igk.intel.com ([10.102.20.192])
  by fmviesa007.fm.intel.com with ESMTP; 30 Oct 2024 23:00:11 -0700
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	sridhar.samudrala@intel.com
Subject: [iwl-next v1 1/3] ice: support max_io_eqs for subfunction
Date: Thu, 31 Oct 2024 07:00:07 +0100
Message-ID: <20241031060009.38979-2-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20241031060009.38979-1-michal.swiatkowski@linux.intel.com>
References: <20241031060009.38979-1-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement get and set for the maximum IO event queues for SF.
It is used to derive the maximum number of Rx/Tx queues on subfunction
device.

If the value isn't set when activating set it to the low default value.

Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/intel/ice/devlink/port.c | 37 +++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice.h          |  2 +
 2 files changed, 39 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/devlink/port.c b/drivers/net/ethernet/intel/ice/devlink/port.c
index 767419a67fef..a723895e4dff 100644
--- a/drivers/net/ethernet/intel/ice/devlink/port.c
+++ b/drivers/net/ethernet/intel/ice/devlink/port.c
@@ -530,6 +530,33 @@ void ice_devlink_destroy_sf_dev_port(struct ice_sf_dev *sf_dev)
 	devl_port_unregister(&sf_dev->priv->devlink_port);
 }
 
+static int
+ice_devlink_port_fn_max_io_eqs_set(struct devlink_port *port, u32 max_io_eqs,
+				   struct netlink_ext_ack *extack)
+{
+	struct ice_dynamic_port *dyn_port = ice_devlink_port_to_dyn(port);
+
+	if (max_io_eqs > num_online_cpus()) {
+		NL_SET_ERR_MSG_MOD(extack, "Supplied value out of range");
+		return -EINVAL;
+	}
+
+	dyn_port->vsi->max_io_eqs = max_io_eqs;
+
+	return 0;
+}
+
+static int
+ice_devlink_port_fn_max_io_eqs_get(struct devlink_port *port, u32 *max_io_eqs,
+				   struct netlink_ext_ack *extack)
+{
+	struct ice_dynamic_port *dyn_port = ice_devlink_port_to_dyn(port);
+
+	*max_io_eqs = dyn_port->vsi->max_io_eqs;
+
+	return 0;
+}
+
 /**
  * ice_activate_dynamic_port - Activate a dynamic port
  * @dyn_port: dynamic port instance to activate
@@ -548,6 +575,14 @@ ice_activate_dynamic_port(struct ice_dynamic_port *dyn_port,
 	if (dyn_port->active)
 		return 0;
 
+	if (!dyn_port->vsi->max_io_eqs) {
+		err = ice_devlink_port_fn_max_io_eqs_set(&dyn_port->devlink_port,
+							 ICE_SF_DEFAULT_EQS,
+							 extack);
+		if (err)
+			return err;
+	}
+
 	err = ice_sf_eth_activate(dyn_port, extack);
 	if (err)
 		return err;
@@ -807,6 +842,8 @@ static const struct devlink_port_ops ice_devlink_port_sf_ops = {
 	.port_fn_hw_addr_set = ice_devlink_port_fn_hw_addr_set,
 	.port_fn_state_get = ice_devlink_port_fn_state_get,
 	.port_fn_state_set = ice_devlink_port_fn_state_set,
+	.port_fn_max_io_eqs_set = ice_devlink_port_fn_max_io_eqs_set,
+	.port_fn_max_io_eqs_get = ice_devlink_port_fn_max_io_eqs_get,
 };
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index 70d5294a558c..ca0739625d3b 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -109,6 +109,7 @@
 #define ICE_Q_WAIT_MAX_RETRY	(5 * ICE_Q_WAIT_RETRY_LIMIT)
 #define ICE_MAX_LG_RSS_QS	256
 #define ICE_INVAL_Q_INDEX	0xffff
+#define ICE_SF_DEFAULT_EQS	8
 
 #define ICE_MAX_RXQS_PER_TC		256	/* Used when setting VSI context per TC Rx queues */
 
@@ -443,6 +444,7 @@ struct ice_vsi {
 	u8 old_numtc;
 	u16 old_ena_tc;
 
+	u32 max_io_eqs;
 	/* setup back reference, to which aggregator node this VSI
 	 * corresponds to
 	 */
-- 
2.42.0


