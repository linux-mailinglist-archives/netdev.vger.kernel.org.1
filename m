Return-Path: <netdev+bounces-130641-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 474BA98AFF5
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 00:36:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6210F1C22542
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 22:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B551990C6;
	Mon, 30 Sep 2024 22:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BYgkBKb4"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343BB18C904
	for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 22:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727735771; cv=none; b=NVbzKN41YXPqKggTDRbI1HLZ+31Hm/BXLDg1LbmMrbwqqqBTN9FsllxmW7OZFzPgcSZtYDn7wsrvvCIMmdrukZfYSpkB0C3UGde+qb0b2Py7RN8KXGsavUAT8l8yYVbqoYSxDD81gLVXHgFUmDj+st1E5U0ay6MmD61sadbeLLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727735771; c=relaxed/simple;
	bh=H8axcbO/gVaUyc0pqgkplVS5bWiUTOAQ/YFAh27YP4k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cogmxV5op2GMGaTL+l2dhfhkUWKz+BRTGc9zstt38OFUFDoqV7/OOnCUn9Ob7SdFOHdM6FkWACPJX/aHtmNuo1ZkNlDHUaAJdCG5bcvyTQssakHXigsTG1zk8Fn/5VJedKt+d+UnEW/+YrnVarI9bpJVyBEBy15HhWP0QsJZW5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BYgkBKb4; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727735769; x=1759271769;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=H8axcbO/gVaUyc0pqgkplVS5bWiUTOAQ/YFAh27YP4k=;
  b=BYgkBKb4I+LN/7b841F1o9tEhIEX4XqAUAFuoEpgHPKaJopTyp0jS6gc
   g7UYZ1N5ni/emxjHecGltOTsgoivnbxbZBm1Vu0DObg6YrH/W/ElcnATd
   YPG8jVGW4vBYi/C4OAqqa/8ICeLIffvQCtwAKkaL77abIDWxdUaTkz/CX
   TW5IK08Qy+GtYCHdyMyEjeMD4ML2m58+VtB9aD4j8hAcqt3DsjxmzFLsm
   9Tm6zXe2IZibKwvkv2zMI7RO6gHNQmxzwjs2cmQSM1oki3HZMAK7QukT0
   AqdZDHZEt/Ksq0JtpSuXtLKFVkussapQFShCHAv8BMGs8cdNHjT90NT1H
   A==;
X-CSE-ConnectionGUID: wtn7+thvTkyuQlGqXAANGw==
X-CSE-MsgGUID: tjt2uPWDSxWDClHrlbUq6w==
X-IronPort-AV: E=McAfee;i="6700,10204,11211"; a="30734872"
X-IronPort-AV: E=Sophos;i="6.11,166,1725346800"; 
   d="scan'208";a="30734872"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 15:36:06 -0700
X-CSE-ConnectionGUID: f+cQDLHSRpOEQ9N0gX8Feg==
X-CSE-MsgGUID: ubYSEq+TQbuNDKaEnMMqTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,166,1725346800"; 
   d="scan'208";a="73496617"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa009.jf.intel.com with ESMTP; 30 Sep 2024 15:36:06 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	anthony.l.nguyen@intel.com,
	wojciech.drewek@intel.com,
	poros@redhat.com,
	Piotr Tyda <piotr.tyda@intel.com>
Subject: [PATCH net 04/10] ice: clear port vlan config during reset
Date: Mon, 30 Sep 2024 15:35:51 -0700
Message-ID: <20240930223601.3137464-5-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.46.0.522.gc50d79eeffbf
In-Reply-To: <20240930223601.3137464-1-anthony.l.nguyen@intel.com>
References: <20240930223601.3137464-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Since commit 2a2cb4c6c181 ("ice: replace ice_vf_recreate_vsi() with
ice_vf_reconfig_vsi()") VF VSI is only reconfigured instead of
recreated. The context configuration from previous setting is still the
same. If any of the config needs to be cleared it needs to be cleared
explicitly.

Previously there was assumption that port vlan will be cleared
automatically. Now, when VSI is only reconfigured we have to do it in the
code.

Not clearing port vlan configuration leads to situation when the driver
VSI config is different than the VSI config in HW. Traffic can't be
passed after setting and clearing port vlan, because of invalid VSI
config in HW.

Example reproduction:
> ip a a dev $(VF) $(VF_IP_ADDRESS)
> ip l s dev $(VF) up
> ping $(VF_IP_ADDRESS)
ping is working fine here
> ip link set eth5 vf 0 vlan 100
> ip link set eth5 vf 0 vlan 0
> ping $(VF_IP_ADDRESS)
ping isn't working

Fixes: 2a2cb4c6c181 ("ice: replace ice_vf_recreate_vsi() with ice_vf_reconfig_vsi()")
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Tested-by: Piotr Tyda <piotr.tyda@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_vf_lib.c   |  7 +++
 .../net/ethernet/intel/ice/ice_vsi_vlan_lib.c | 57 +++++++++++++++++++
 .../net/ethernet/intel/ice/ice_vsi_vlan_lib.h |  1 +
 3 files changed, 65 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib.c b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
index a69e91f88d81..749a08ccf267 100644
--- a/drivers/net/ethernet/intel/ice/ice_vf_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
@@ -335,6 +335,13 @@ static int ice_vf_rebuild_host_vlan_cfg(struct ice_vf *vf, struct ice_vsi *vsi)
 
 		err = vlan_ops->add_vlan(vsi, &vf->port_vlan_info);
 	} else {
+		/* clear possible previous port vlan config */
+		err = ice_vsi_clear_port_vlan(vsi);
+		if (err) {
+			dev_err(dev, "failed to clear port VLAN via VSI parameters for VF %u, error %d\n",
+				vf->vf_id, err);
+			return err;
+		}
 		err = ice_vsi_add_vlan_zero(vsi);
 	}
 
diff --git a/drivers/net/ethernet/intel/ice/ice_vsi_vlan_lib.c b/drivers/net/ethernet/intel/ice/ice_vsi_vlan_lib.c
index 6e8f2aab6080..5291f2888ef8 100644
--- a/drivers/net/ethernet/intel/ice/ice_vsi_vlan_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_vsi_vlan_lib.c
@@ -787,3 +787,60 @@ int ice_vsi_clear_outer_port_vlan(struct ice_vsi *vsi)
 	kfree(ctxt);
 	return err;
 }
+
+int ice_vsi_clear_port_vlan(struct ice_vsi *vsi)
+{
+	struct ice_hw *hw = &vsi->back->hw;
+	struct ice_vsi_ctx *ctxt;
+	int err;
+
+	ctxt = kzalloc(sizeof(*ctxt), GFP_KERNEL);
+	if (!ctxt)
+		return -ENOMEM;
+
+	ctxt->info = vsi->info;
+
+	ctxt->info.port_based_outer_vlan = 0;
+	ctxt->info.port_based_inner_vlan = 0;
+
+	ctxt->info.inner_vlan_flags =
+		FIELD_PREP(ICE_AQ_VSI_INNER_VLAN_TX_MODE_M,
+			   ICE_AQ_VSI_INNER_VLAN_TX_MODE_ALL);
+	if (ice_is_dvm_ena(hw)) {
+		ctxt->info.inner_vlan_flags |=
+			FIELD_PREP(ICE_AQ_VSI_INNER_VLAN_EMODE_M,
+				   ICE_AQ_VSI_INNER_VLAN_EMODE_NOTHING);
+		ctxt->info.outer_vlan_flags =
+			FIELD_PREP(ICE_AQ_VSI_OUTER_VLAN_TX_MODE_M,
+				   ICE_AQ_VSI_OUTER_VLAN_TX_MODE_ALL);
+		ctxt->info.outer_vlan_flags |=
+			FIELD_PREP(ICE_AQ_VSI_OUTER_TAG_TYPE_M,
+				   ICE_AQ_VSI_OUTER_TAG_VLAN_8100);
+		ctxt->info.outer_vlan_flags |=
+			ICE_AQ_VSI_OUTER_VLAN_EMODE_NOTHING <<
+			ICE_AQ_VSI_OUTER_VLAN_EMODE_S;
+	}
+
+	ctxt->info.sw_flags2 &= ~ICE_AQ_VSI_SW_FLAG_RX_VLAN_PRUNE_ENA;
+	ctxt->info.valid_sections =
+		cpu_to_le16(ICE_AQ_VSI_PROP_OUTER_TAG_VALID |
+			    ICE_AQ_VSI_PROP_VLAN_VALID |
+			    ICE_AQ_VSI_PROP_SW_VALID);
+
+	err = ice_update_vsi(hw, vsi->idx, ctxt, NULL);
+	if (err) {
+		dev_err(ice_pf_to_dev(vsi->back), "update VSI for clearing port based VLAN failed, err %d aq_err %s\n",
+			err, ice_aq_str(hw->adminq.sq_last_status));
+	} else {
+		vsi->info.port_based_outer_vlan =
+			ctxt->info.port_based_outer_vlan;
+		vsi->info.port_based_inner_vlan =
+			ctxt->info.port_based_inner_vlan;
+		vsi->info.outer_vlan_flags = ctxt->info.outer_vlan_flags;
+		vsi->info.inner_vlan_flags = ctxt->info.inner_vlan_flags;
+		vsi->info.sw_flags2 = ctxt->info.sw_flags2;
+	}
+
+	kfree(ctxt);
+	return err;
+}
diff --git a/drivers/net/ethernet/intel/ice/ice_vsi_vlan_lib.h b/drivers/net/ethernet/intel/ice/ice_vsi_vlan_lib.h
index f0d84d11bd5b..12b227621a7d 100644
--- a/drivers/net/ethernet/intel/ice/ice_vsi_vlan_lib.h
+++ b/drivers/net/ethernet/intel/ice/ice_vsi_vlan_lib.h
@@ -36,5 +36,6 @@ int ice_vsi_ena_outer_insertion(struct ice_vsi *vsi, u16 tpid);
 int ice_vsi_dis_outer_insertion(struct ice_vsi *vsi);
 int ice_vsi_set_outer_port_vlan(struct ice_vsi *vsi, struct ice_vlan *vlan);
 int ice_vsi_clear_outer_port_vlan(struct ice_vsi *vsi);
+int ice_vsi_clear_port_vlan(struct ice_vsi *vsi);
 
 #endif /* _ICE_VSI_VLAN_LIB_H_ */
-- 
2.42.0


