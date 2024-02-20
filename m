Return-Path: <netdev+bounces-73442-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9661385CA28
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 22:45:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2CC2283280
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 21:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC07D152DE3;
	Tue, 20 Feb 2024 21:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XbFpp+0A"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08957151CDC
	for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 21:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708465496; cv=none; b=qtZ+h89bDipHD3mhJiBVcEYrOKRApWJahIqg1pCKG1um0vC6hw104S1pjjjtkL4EfrUmgP1HGvxma0kTUo9+8DE906TTLhrPYnzREW3ZVJoRVAqhiHSycynkyo6VHNbaFPQBwoSJ63+QKTyTtz0P+oK/g9Vn8LGjulljXUmPsAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708465496; c=relaxed/simple;
	bh=QzkhvaUfSkVMM9Giq4huKXwZH0F7Bdlq/e8/ksV+7iY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HQ9v6boXt3N9+hZxMLktEzfxCeenYEMx16sb8WFuf+M/zMjjrpL5jsR9lUnpE261PYDXXNSy1ox2eQUx4kLEiz6hv/d+ecY1d7gAzCZp5x4YeiL3lRjMjex43LCNzds5quqsDFk5h1+C8qxYmtnnpEO7Sd+MUYHHdpjrzaQ4FEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XbFpp+0A; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708465496; x=1740001496;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QzkhvaUfSkVMM9Giq4huKXwZH0F7Bdlq/e8/ksV+7iY=;
  b=XbFpp+0A8lZYCXDyrpXWY60PvOHfY1aqCGTtMa6h8xwQWgAL8nygS9rE
   xttnzmSl1Gb8xGJJmkv3caOufbI0n0GjvrSZug0numLLBP/Ht8tx6oiUV
   nzbaMAY6WTF0Pgk0ecJlYknlM2bWf4M4LdPrv2p6hNmJYsVOFZwTxChlj
   ZpOKTsjyP493EJ5x9mzNAWRg+EsTmZh19pcbcpD60jTSsSTH/bS7qQm/3
   TXliEyLqa+eJFK0MoysEJByJa5ZOexy/zkHTmAFjE3xkMVRAtR97TZNHh
   lWOxVGVqonADCiSDavPb8WVrsrDprEReeN5yiZqFLoSp+/UuoO45VF3XN
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="2472714"
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="2472714"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 13:44:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="9614933"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa005.jf.intel.com with ESMTP; 20 Feb 2024 13:44:53 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Yochai Hagvi <yochai.hagvi@intel.com>,
	anthony.l.nguyen@intel.com,
	vadim.fedorenko@linux.dev,
	jiri@resnulli.us,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Sunitha Mekala <sunithax.d.mekala@intel.com>
Subject: [PATCH net 1/6] ice: fix connection state of DPLL and out pin
Date: Tue, 20 Feb 2024 13:44:37 -0800
Message-ID: <20240220214444.1039759-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240220214444.1039759-1-anthony.l.nguyen@intel.com>
References: <20240220214444.1039759-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yochai Hagvi <yochai.hagvi@intel.com>

Fix the connection state between source DPLL and output pin, updating the
attribute 'state' of 'parent_device'. Previously, the connection state
was broken, and didn't reflect the correct state.

When 'state_on_dpll_set' is called with the value
'DPLL_PIN_STATE_CONNECTED' (1), the output pin will switch to the given
DPLL, and the state of the given DPLL will be set to connected.
E.g.:
	--do pin-set --json '{"id":2, "parent-device":{"parent-id":1,
						       "state": 1 }}'
This command will connect DPLL device with id 1 to output pin with id 2.

When 'state_on_dpll_set' is called with the value
'DPLL_PIN_STATE_DISCONNECTED' (2) and the given DPLL is currently
connected, then the output pin will be disabled.
E.g:
	--do pin-set --json '{"id":2, "parent-device":{"parent-id":1,
						       "state": 2 }}'
This command will disable output pin with id 2 if DPLL device with ID 1 is
connected to it; otherwise, the command is ignored.

Fixes: d7999f5ea64b ("ice: implement dpll interface to control cgu")
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Signed-off-by: Yochai Hagvi <yochai.hagvi@intel.com>
Tested-by: Sunitha Mekala <sunithax.d.mekala@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_dpll.c | 43 +++++++++++++++++------
 1 file changed, 32 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
index b9c5eced6326..9c0d739be1e9 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.c
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
@@ -254,6 +254,7 @@ ice_dpll_output_frequency_get(const struct dpll_pin *pin, void *pin_priv,
  * ice_dpll_pin_enable - enable a pin on dplls
  * @hw: board private hw structure
  * @pin: pointer to a pin
+ * @dpll_idx: dpll index to connect to output pin
  * @pin_type: type of pin being enabled
  * @extack: error reporting
  *
@@ -266,7 +267,7 @@ ice_dpll_output_frequency_get(const struct dpll_pin *pin, void *pin_priv,
  */
 static int
 ice_dpll_pin_enable(struct ice_hw *hw, struct ice_dpll_pin *pin,
-		    enum ice_dpll_pin_type pin_type,
+		    u8 dpll_idx, enum ice_dpll_pin_type pin_type,
 		    struct netlink_ext_ack *extack)
 {
 	u8 flags = 0;
@@ -280,10 +281,12 @@ ice_dpll_pin_enable(struct ice_hw *hw, struct ice_dpll_pin *pin,
 		ret = ice_aq_set_input_pin_cfg(hw, pin->idx, 0, flags, 0, 0);
 		break;
 	case ICE_DPLL_PIN_TYPE_OUTPUT:
+		flags = ICE_AQC_SET_CGU_OUT_CFG_UPDATE_SRC_SEL;
 		if (pin->flags[0] & ICE_AQC_GET_CGU_OUT_CFG_ESYNC_EN)
 			flags |= ICE_AQC_SET_CGU_OUT_CFG_ESYNC_EN;
 		flags |= ICE_AQC_SET_CGU_OUT_CFG_OUT_EN;
-		ret = ice_aq_set_output_pin_cfg(hw, pin->idx, flags, 0, 0, 0);
+		ret = ice_aq_set_output_pin_cfg(hw, pin->idx, flags, dpll_idx,
+						0, 0);
 		break;
 	default:
 		return -EINVAL;
@@ -398,14 +401,27 @@ ice_dpll_pin_state_update(struct ice_pf *pf, struct ice_dpll_pin *pin,
 		break;
 	case ICE_DPLL_PIN_TYPE_OUTPUT:
 		ret = ice_aq_get_output_pin_cfg(&pf->hw, pin->idx,
-						&pin->flags[0], NULL,
+						&pin->flags[0], &parent,
 						&pin->freq, NULL);
 		if (ret)
 			goto err;
-		if (ICE_AQC_SET_CGU_OUT_CFG_OUT_EN & pin->flags[0])
-			pin->state[0] = DPLL_PIN_STATE_CONNECTED;
-		else
-			pin->state[0] = DPLL_PIN_STATE_DISCONNECTED;
+
+		parent &= ICE_AQC_GET_CGU_OUT_CFG_DPLL_SRC_SEL;
+		if (ICE_AQC_SET_CGU_OUT_CFG_OUT_EN & pin->flags[0]) {
+			pin->state[pf->dplls.eec.dpll_idx] =
+				parent == pf->dplls.eec.dpll_idx ?
+				DPLL_PIN_STATE_CONNECTED :
+				DPLL_PIN_STATE_DISCONNECTED;
+			pin->state[pf->dplls.pps.dpll_idx] =
+				parent == pf->dplls.pps.dpll_idx ?
+				DPLL_PIN_STATE_CONNECTED :
+				DPLL_PIN_STATE_DISCONNECTED;
+		} else {
+			pin->state[pf->dplls.eec.dpll_idx] =
+				DPLL_PIN_STATE_DISCONNECTED;
+			pin->state[pf->dplls.pps.dpll_idx] =
+				DPLL_PIN_STATE_DISCONNECTED;
+		}
 		break;
 	case ICE_DPLL_PIN_TYPE_RCLK_INPUT:
 		for (parent = 0; parent < pf->dplls.rclk.num_parents;
@@ -570,7 +586,8 @@ ice_dpll_pin_state_set(const struct dpll_pin *pin, void *pin_priv,
 
 	mutex_lock(&pf->dplls.lock);
 	if (enable)
-		ret = ice_dpll_pin_enable(&pf->hw, p, pin_type, extack);
+		ret = ice_dpll_pin_enable(&pf->hw, p, d->dpll_idx, pin_type,
+					  extack);
 	else
 		ret = ice_dpll_pin_disable(&pf->hw, p, pin_type, extack);
 	if (!ret)
@@ -603,6 +620,11 @@ ice_dpll_output_state_set(const struct dpll_pin *pin, void *pin_priv,
 			  struct netlink_ext_ack *extack)
 {
 	bool enable = state == DPLL_PIN_STATE_CONNECTED;
+	struct ice_dpll_pin *p = pin_priv;
+	struct ice_dpll *d = dpll_priv;
+
+	if (!enable && p->state[d->dpll_idx] == DPLL_PIN_STATE_DISCONNECTED)
+		return 0;
 
 	return ice_dpll_pin_state_set(pin, pin_priv, dpll, dpll_priv, enable,
 				      extack, ICE_DPLL_PIN_TYPE_OUTPUT);
@@ -669,10 +691,9 @@ ice_dpll_pin_state_get(const struct dpll_pin *pin, void *pin_priv,
 	ret = ice_dpll_pin_state_update(pf, p, pin_type, extack);
 	if (ret)
 		goto unlock;
-	if (pin_type == ICE_DPLL_PIN_TYPE_INPUT)
+	if (pin_type == ICE_DPLL_PIN_TYPE_INPUT ||
+	    pin_type == ICE_DPLL_PIN_TYPE_OUTPUT)
 		*state = p->state[d->dpll_idx];
-	else if (pin_type == ICE_DPLL_PIN_TYPE_OUTPUT)
-		*state = p->state[0];
 	ret = 0;
 unlock:
 	mutex_unlock(&pf->dplls.lock);
-- 
2.41.0


