Return-Path: <netdev+bounces-93652-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD6D78BC9C9
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 10:42:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7506828320E
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 08:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 358371411C5;
	Mon,  6 May 2024 08:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hwFW/+JP"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC231420DE
	for <netdev@vger.kernel.org>; Mon,  6 May 2024 08:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714984932; cv=none; b=k4JA7pPwqmg5p7vp86e+yes2PJ5jplpFkQrZpC9wcPZ1fNnb03/iqjfiOLOfLF7pJRurNnR8b4qutYVWrkUjhYGojHPsavOQL+AY18Puk2DHb6yLVF80CB8GC/znMKr1ynsrAU6Zs++YLDO78pOOC3gJCOvMlj1VELhCYH0YXpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714984932; c=relaxed/simple;
	bh=PfM8XjXN6/WU18JZS9mknua1WPAgEF86RL/6y9HcEao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TcHgufvPbgNjuQ37a26NksBG6Bljuh1M0xocAXkHiMvHa+IFO3t/22C7lpB4qxWxWU/vBqqYP3cQc9+9Hww0v6rOrY1PtLyi3IIDXAKy+46xGlVKR7kJIBxKXtBh2K91Do1U+K4riuXgVyi0OjivMBdooqt34X2YcqVPYUQen8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hwFW/+JP; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714984931; x=1746520931;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PfM8XjXN6/WU18JZS9mknua1WPAgEF86RL/6y9HcEao=;
  b=hwFW/+JPiz+xn7ah/TyDIzQDorTrlHPc5EoyrmtbfTfEqsYbIuy3ITSx
   SZk+e+ECdJUF9VuHl9R96R1b8a8WVQaWZuj37vsJNkFlPonq4fTw1msbr
   WA3acAzs0NnnxEIrxsb5Gk6F6WoQWrYxQiE8q2Rpry0srwrS2+2Y50aTB
   1m0brXwQlTDorOISouaKD1DH9TMZhCUagjRXj8HXTtoBU3sjw5PfVPrjV
   VPmBuvsowLPVJoOxquZuOOdyL8yDKeJabjQStITTM3IyIXekm1hGKQxDv
   djVn7Ig1Q0c7QolbWaDuv1U4pC+Tu1mWGY7wpcAINhiFFB1/aBNaJxuYw
   Q==;
X-CSE-ConnectionGUID: ZA0Ec+VyQgC0IvQXPSALWw==
X-CSE-MsgGUID: hf4ONj30TKmIBpgBP0f06g==
X-IronPort-AV: E=McAfee;i="6600,9927,11064"; a="14505105"
X-IronPort-AV: E=Sophos;i="6.07,257,1708416000"; 
   d="scan'208";a="14505105"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 01:42:11 -0700
X-CSE-ConnectionGUID: eoiCBZEwTKK2z2mhekZY8A==
X-CSE-MsgGUID: LWG2MtAPR5KTjfrZNTiFmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,257,1708416000"; 
   d="scan'208";a="28050157"
Received: from wasp.igk.intel.com (HELO GK3153-DR2-R750-36946.localdomain.com) ([10.102.20.192])
  by fmviesa009.fm.intel.com with ESMTP; 06 May 2024 01:42:08 -0700
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
	shayd@nvidia.com
Subject: [iwl-next v2 3/4] ice: move VSI configuration outside repr setup
Date: Mon,  6 May 2024 10:46:52 +0200
Message-ID: <20240506084653.532111-4-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240506084653.532111-1-michal.swiatkowski@linux.intel.com>
References: <20240506084653.532111-1-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is needed because subfunction port representor shouldn't configure
the source VSI during representor creation.

Move the code to separate function and call it only in case the VF port
representor is being created.

Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/intel/ice/ice_eswitch.c | 55 ++++++++++++++------
 drivers/net/ethernet/intel/ice/ice_eswitch.h | 10 ++++
 drivers/net/ethernet/intel/ice/ice_repr.c    |  7 +++
 3 files changed, 57 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.c b/drivers/net/ethernet/intel/ice/ice_eswitch.c
index 7b57a6561a5a..3f73f46111fc 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch.c
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch.c
@@ -117,17 +117,10 @@ static int ice_eswitch_setup_repr(struct ice_pf *pf, struct ice_repr *repr)
 	struct ice_vsi *vsi = repr->src_vsi;
 	struct metadata_dst *dst;
 
-	ice_remove_vsi_fltr(&pf->hw, vsi->idx);
 	repr->dst = metadata_dst_alloc(0, METADATA_HW_PORT_MUX,
 				       GFP_KERNEL);
 	if (!repr->dst)
-		goto err_add_mac_fltr;
-
-	if (ice_vsi_update_security(vsi, ice_vsi_ctx_clear_antispoof))
-		goto err_dst_free;
-
-	if (ice_vsi_add_vlan_zero(vsi))
-		goto err_update_security;
+		return -ENOMEM;
 
 	netif_keep_dst(uplink_vsi->netdev);
 
@@ -136,16 +129,48 @@ static int ice_eswitch_setup_repr(struct ice_pf *pf, struct ice_repr *repr)
 	dst->u.port_info.lower_dev = uplink_vsi->netdev;
 
 	return 0;
+}
 
-err_update_security:
+/**
+ * ice_eswitch_cfg_vsi - configure VSI to work in slow-path
+ * @vsi: VSI structure of representee
+ * @mac: representee MAC
+ *
+ * Return: 0 on success, non-zero on error.
+ */
+int ice_eswitch_cfg_vsi(struct ice_vsi *vsi, const u8 *mac)
+{
+	int err;
+
+	ice_remove_vsi_fltr(&vsi->back->hw, vsi->idx);
+
+	err = ice_vsi_update_security(vsi, ice_vsi_ctx_clear_antispoof);
+	if (err)
+		goto err_update_security;
+
+	err = ice_vsi_add_vlan_zero(vsi);
+	if (err)
+		goto err_vlan_zero;
+
+	return 0;
+
+err_vlan_zero:
 	ice_vsi_update_security(vsi, ice_vsi_ctx_set_antispoof);
-err_dst_free:
-	metadata_dst_free(repr->dst);
-	repr->dst = NULL;
-err_add_mac_fltr:
-	ice_fltr_add_mac_and_broadcast(vsi, repr->parent_mac, ICE_FWD_TO_VSI);
+err_update_security:
+	ice_fltr_add_mac_and_broadcast(vsi, mac, ICE_FWD_TO_VSI);
 
-	return -ENODEV;
+	return err;
+}
+
+/**
+ * ice_eswitch_decfg_vsi - unroll changes done to VSI for switchdev
+ * @vsi: VSI structure of representee
+ * @mac: representee MAC
+ */
+void ice_eswitch_decfg_vsi(struct ice_vsi *vsi, const u8 *mac)
+{
+	ice_vsi_update_security(vsi, ice_vsi_ctx_set_antispoof);
+	ice_fltr_add_mac_and_broadcast(vsi, mac, ICE_FWD_TO_VSI);
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.h b/drivers/net/ethernet/intel/ice/ice_eswitch.h
index e2e5c0c75e7d..9a25606e9740 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch.h
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch.h
@@ -28,6 +28,9 @@ netdev_tx_t
 ice_eswitch_port_start_xmit(struct sk_buff *skb, struct net_device *netdev);
 struct net_device *ice_eswitch_get_target(struct ice_rx_ring *rx_ring,
 					  union ice_32b_rx_flex_desc *rx_desc);
+
+int ice_eswitch_cfg_vsi(struct ice_vsi *vsi, const u8 *mac);
+void ice_eswitch_decfg_vsi(struct ice_vsi *vsi, const u8 *mac);
 #else /* CONFIG_ICE_SWITCHDEV */
 static inline void ice_eswitch_detach(struct ice_pf *pf, struct ice_vf *vf) { }
 
@@ -85,5 +88,12 @@ ice_eswitch_get_target(struct ice_rx_ring *rx_ring,
 {
 	return rx_ring->netdev;
 }
+
+static inline int ice_eswitch_cfg_vsi(struct ice_vsi *vsi, const u8 *mac)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void ice_eswitch_decfg_vsi(struct ice_vsi *vsi, const u8 *mac) { }
 #endif /* CONFIG_ICE_SWITCHDEV */
 #endif /* _ICE_ESWITCH_H_ */
diff --git a/drivers/net/ethernet/intel/ice/ice_repr.c b/drivers/net/ethernet/intel/ice/ice_repr.c
index 35a6ac8c0466..bdda3401e343 100644
--- a/drivers/net/ethernet/intel/ice/ice_repr.c
+++ b/drivers/net/ethernet/intel/ice/ice_repr.c
@@ -306,6 +306,7 @@ static void ice_repr_rem(struct ice_repr *repr)
 void ice_repr_rem_vf(struct ice_repr *repr)
 {
 	ice_repr_remove_node(&repr->vf->devlink_port);
+	ice_eswitch_decfg_vsi(repr->src_vsi, repr->parent_mac);
 	unregister_netdev(repr->netdev);
 	ice_devlink_destroy_vf_port(repr->vf);
 	ice_virtchnl_set_dflt_ops(repr->vf);
@@ -401,11 +402,17 @@ struct ice_repr *ice_repr_add_vf(struct ice_vf *vf)
 	if (err)
 		goto err_netdev;
 
+	err = ice_eswitch_cfg_vsi(repr->src_vsi, repr->parent_mac);
+	if (err)
+		goto err_cfg_vsi;
+
 	ice_virtchnl_set_repr_ops(vf);
 	ice_repr_set_tx_topology(vf->pf);
 
 	return repr;
 
+err_cfg_vsi:
+	unregister_netdev(repr->netdev);
 err_netdev:
 	ice_repr_rem(repr);
 err_repr_add:
-- 
2.42.0


