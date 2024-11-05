Return-Path: <netdev+bounces-142115-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ECED9BD879
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 23:24:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D062284445
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 22:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41AAC216A36;
	Tue,  5 Nov 2024 22:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MCFvVoBS"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608EC216A06
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 22:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730845446; cv=none; b=JDFbhraHJxfklYfrd3uVwcTm2U7cpAE84NMJke10IR84df7LNSLvpXTQ4HyiU6HJLooUNugFFuNRmu0cEtOSeFmWdkxjIrQJqNGMiFZW3bfBlDMp1PbGs27+MCrUCQ4v3SOEHF7KHFce9Iq1FpSwa5axgym/DmUhBbEt5DworEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730845446; c=relaxed/simple;
	bh=ThtlHQN1luKHq6EgjWnKTRenP6Rh2gMCL+wwfWuQu5c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PGxL/GSX3ckonnTa089y4IFq0FOAixHg/kDDOVObkF1L5iDYQrHYDATZaTaQvfxOywqGSwNr4qlkLbIWRmBVJSUeq1wW03Kmf4X+gew626zuoCnNy2Gm4D9augUqxucPrN2sLUFhixglEQS6Mh84wNBBfQGe8E0jpeZ51xUuE6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MCFvVoBS; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730845444; x=1762381444;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ThtlHQN1luKHq6EgjWnKTRenP6Rh2gMCL+wwfWuQu5c=;
  b=MCFvVoBShozpFJ08CaCcMEmBOwnif2GyGwnZdgz3NG7fgRHAH5rC2CpB
   YbHZ0xim+N6N1TWOOZeF2CAaeSv5IIpAb6cGixRGPB/tSdfH2SjNNYSFK
   u+ay6Cwetp1LxP6KPNrGWU4UcYTEO43pnx4RlWmJReuCuAlD7JFwyXlzl
   PQXjrL/ZfmObdyK5q5in8Uf5+Phg1A5Dk88eEphtyS/89OgnkAo5x+dBr
   5UYnPBoIsz5PaOWEHorDEdSAb2qHe0azpiILf9eOO4RE1pGyIDYEJvwJx
   DUkisrd4gMEOPfMWOT33ElZw51/KYwH4INEJT3sLTW8ILNcblbDZ/O8DX
   Q==;
X-CSE-ConnectionGUID: 5U3u1twfQx+K/oSqZyZjkA==
X-CSE-MsgGUID: JcHP8aCOTX+DareELGPJkA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="34314292"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="34314292"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 14:24:01 -0800
X-CSE-ConnectionGUID: gnl157D5QSO0qbcLdk2y/g==
X-CSE-MsgGUID: t9T3V0gLTxK33bchyQT5Kg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,261,1725346800"; 
   d="scan'208";a="84322452"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa009.fm.intel.com with ESMTP; 05 Nov 2024 14:24:00 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Brett Creeley <brett.creeley@intel.com>,
	anthony.l.nguyen@intel.com,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Simon Horman <horms@kernel.org>,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net-next 07/15] ice: only allow Tx promiscuous for multicast
Date: Tue,  5 Nov 2024 14:23:41 -0800
Message-ID: <20241105222351.3320587-8-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.46.0.522.gc50d79eeffbf
In-Reply-To: <20241105222351.3320587-1-anthony.l.nguyen@intel.com>
References: <20241105222351.3320587-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Brett Creeley <brett.creeley@intel.com>

Currently when any VF is trusted and true promiscuous mode is enabled on
the PF, the VF will receive all unicast traffic directed to the device's
internal switch. This includes traffic external to the NIC and also from
other VSI (i.e. VFs). This does not match the expected behavior as
unicast traffic should only be visible from external sources in this
case. Disable the Tx promiscuous mode bits for unicast promiscuous mode.

Reviewed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Signed-off-by: Brett Creeley <brett.creeley@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h          |  6 ++---
 drivers/net/ethernet/intel/ice/ice_virtchnl.c | 23 ++++++++++++++-----
 2 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index 1f30274624b2..0d2c80578633 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -181,11 +181,9 @@
 #define ice_for_each_chnl_tc(i)	\
 	for ((i) = ICE_CHNL_START_TC; (i) < ICE_CHNL_MAX_TC; (i)++)
 
-#define ICE_UCAST_PROMISC_BITS (ICE_PROMISC_UCAST_TX | ICE_PROMISC_UCAST_RX)
+#define ICE_UCAST_PROMISC_BITS ICE_PROMISC_UCAST_RX
 
-#define ICE_UCAST_VLAN_PROMISC_BITS (ICE_PROMISC_UCAST_TX | \
-				     ICE_PROMISC_UCAST_RX | \
-				     ICE_PROMISC_VLAN_TX  | \
+#define ICE_UCAST_VLAN_PROMISC_BITS (ICE_PROMISC_UCAST_RX | \
 				     ICE_PROMISC_VLAN_RX)
 
 #define ICE_MCAST_PROMISC_BITS (ICE_PROMISC_MCAST_TX | ICE_PROMISC_MCAST_RX)
diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl.c b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
index aa2080747714..cc070c467fdd 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
@@ -2554,17 +2554,27 @@ static bool ice_is_vlan_promisc_allowed(struct ice_vf *vf)
 
 /**
  * ice_vf_ena_vlan_promisc - Enable Tx/Rx VLAN promiscuous for the VLAN
+ * @vf: VF to enable VLAN promisc on
  * @vsi: VF's VSI used to enable VLAN promiscuous mode
  * @vlan: VLAN used to enable VLAN promiscuous
  *
  * This function should only be called if VLAN promiscuous mode is allowed,
  * which can be determined via ice_is_vlan_promisc_allowed().
  */
-static int ice_vf_ena_vlan_promisc(struct ice_vsi *vsi, struct ice_vlan *vlan)
+static int ice_vf_ena_vlan_promisc(struct ice_vf *vf, struct ice_vsi *vsi,
+				   struct ice_vlan *vlan)
 {
-	u8 promisc_m = ICE_PROMISC_VLAN_TX | ICE_PROMISC_VLAN_RX;
+	u8 promisc_m = 0;
 	int status;
 
+	if (test_bit(ICE_VF_STATE_UC_PROMISC, vf->vf_states))
+		promisc_m |= ICE_UCAST_VLAN_PROMISC_BITS;
+	if (test_bit(ICE_VF_STATE_MC_PROMISC, vf->vf_states))
+		promisc_m |= ICE_MCAST_VLAN_PROMISC_BITS;
+
+	if (!promisc_m)
+		return 0;
+
 	status = ice_fltr_set_vsi_promisc(&vsi->back->hw, vsi->idx, promisc_m,
 					  vlan->vid);
 	if (status && status != -EEXIST)
@@ -2583,7 +2593,7 @@ static int ice_vf_ena_vlan_promisc(struct ice_vsi *vsi, struct ice_vlan *vlan)
  */
 static int ice_vf_dis_vlan_promisc(struct ice_vsi *vsi, struct ice_vlan *vlan)
 {
-	u8 promisc_m = ICE_PROMISC_VLAN_TX | ICE_PROMISC_VLAN_RX;
+	u8 promisc_m = ICE_UCAST_VLAN_PROMISC_BITS | ICE_MCAST_VLAN_PROMISC_BITS;
 	int status;
 
 	status = ice_fltr_clear_vsi_promisc(&vsi->back->hw, vsi->idx, promisc_m,
@@ -2738,7 +2748,7 @@ static int ice_vc_process_vlan_msg(struct ice_vf *vf, u8 *msg, bool add_v)
 					goto error_param;
 				}
 			} else if (vlan_promisc) {
-				status = ice_vf_ena_vlan_promisc(vsi, &vlan);
+				status = ice_vf_ena_vlan_promisc(vf, vsi, &vlan);
 				if (status) {
 					v_ret = VIRTCHNL_STATUS_ERR_PARAM;
 					dev_err(dev, "Enable Unicast/multicast promiscuous mode on VLAN ID:%d failed error-%d\n",
@@ -3575,7 +3585,7 @@ ice_vc_add_vlans(struct ice_vf *vf, struct ice_vsi *vsi,
 				return err;
 
 			if (vlan_promisc) {
-				err = ice_vf_ena_vlan_promisc(vsi, &vlan);
+				err = ice_vf_ena_vlan_promisc(vf, vsi, &vlan);
 				if (err)
 					return err;
 			}
@@ -3603,7 +3613,8 @@ ice_vc_add_vlans(struct ice_vf *vf, struct ice_vsi *vsi,
 			 */
 			if (!ice_is_dvm_ena(&vsi->back->hw)) {
 				if (vlan_promisc) {
-					err = ice_vf_ena_vlan_promisc(vsi, &vlan);
+					err = ice_vf_ena_vlan_promisc(vf, vsi,
+								      &vlan);
 					if (err)
 						return err;
 				}
-- 
2.42.0


