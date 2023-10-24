Return-Path: <netdev+bounces-43823-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BAF07D4EE2
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 13:35:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00EFA281958
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 11:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD065262B6;
	Tue, 24 Oct 2023 11:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SzvM+1pX"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C140266B4
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 11:34:50 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 417C0128
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 04:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698147289; x=1729683289;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JQWkstSUlgGY3Gc/QGH2k/VG3fCYrtBoeCE/haNRHMo=;
  b=SzvM+1pXWcLSSuUpZ1itOnp2Y2ZkcVy15vk5PF3DF5FaiSFYJdGn5rBJ
   FpPXSxNKB4Lj8xZu9UMCkvqvLRMRf1XzZnPN8nLRWEKMjTYwnPESZeQwY
   v95Uo02kJkIPGehhQelSTZRTGviAwmWNb9AvU/qUz3WApPgQIV70dqWvy
   t4Wg2N8B3McEY4133Usxayp1oSOBAwROdpW6jiYILLPEGMQLDm3tO9gaf
   vpIeduz0R5kkWy8Nh2UlItYNxnMkgvevac97qJNrW8iS98ZPQIiT+S3kX
   z8qqorl0PXhBqdqUxtwFm6vXVM+onEq4XQ+OdD8cUD1rbfWPLao72DgRB
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="5660535"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="5660535"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 04:34:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="6146004"
Received: from wasp.igk.intel.com ([10.102.20.192])
  by orviesa001.jf.intel.com with ESMTP; 24 Oct 2023 04:33:29 -0700
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	piotr.raczynski@intel.com,
	wojciech.drewek@intel.com,
	marcin.szycik@intel.com,
	jacob.e.keller@intel.com,
	przemyslaw.kitszel@intel.com,
	jesse.brandeburg@intel.com,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: [PATCH iwl-next v1 04/15] ice: track q_id in representor
Date: Tue, 24 Oct 2023 13:09:18 +0200
Message-ID: <20231024110929.19423-5-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231024110929.19423-1-michal.swiatkowski@linux.intel.com>
References: <20231024110929.19423-1-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously queue index of control plane VSI used by port representor was
always id of VF. If we want to allow adding port representors for
different devices we have to track queue index in the port representor
structure.

Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Reviewed-by: Piotr Raczynski <piotr.raczynski@intel.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/intel/ice/ice_eswitch.c | 2 +-
 drivers/net/ethernet/intel/ice/ice_repr.c    | 1 +
 drivers/net/ethernet/intel/ice/ice_repr.h    | 1 +
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.c b/drivers/net/ethernet/intel/ice/ice_eswitch.c
index a862681c0f64..119185564450 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch.c
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch.c
@@ -38,7 +38,7 @@ ice_eswitch_add_vf_sp_rule(struct ice_pf *pf, struct ice_vf *vf)
 	rule_info.sw_act.vsi_handle = ctrl_vsi->idx;
 	rule_info.sw_act.fltr_act = ICE_FWD_TO_Q;
 	rule_info.sw_act.fwd_id.q_id = hw->func_caps.common_cap.rxq_first_id +
-				       ctrl_vsi->rxq_map[vf->vf_id];
+				       ctrl_vsi->rxq_map[vf->repr->q_id];
 	rule_info.flags_info.act |= ICE_SINGLE_ACT_LB_ENABLE;
 	rule_info.flags_info.act_valid = true;
 	rule_info.tun_type = ICE_SW_TUN_AND_NON_TUN;
diff --git a/drivers/net/ethernet/intel/ice/ice_repr.c b/drivers/net/ethernet/intel/ice/ice_repr.c
index c686ac0935eb..a2dc216c964f 100644
--- a/drivers/net/ethernet/intel/ice/ice_repr.c
+++ b/drivers/net/ethernet/intel/ice/ice_repr.c
@@ -306,6 +306,7 @@ static int ice_repr_add(struct ice_vf *vf)
 
 	repr->src_vsi = vsi;
 	repr->vf = vf;
+	repr->q_id = vf->vf_id;
 	vf->repr = repr;
 	np = netdev_priv(repr->netdev);
 	np->repr = repr;
diff --git a/drivers/net/ethernet/intel/ice/ice_repr.h b/drivers/net/ethernet/intel/ice/ice_repr.h
index e1ee2d2c1d2d..f350273b8874 100644
--- a/drivers/net/ethernet/intel/ice/ice_repr.h
+++ b/drivers/net/ethernet/intel/ice/ice_repr.h
@@ -13,6 +13,7 @@ struct ice_repr {
 	struct net_device *netdev;
 	struct metadata_dst *dst;
 	struct ice_esw_br_port *br_port;
+	int q_id;
 #ifdef CONFIG_ICE_SWITCHDEV
 	/* info about slow path rule */
 	struct ice_rule_query_data sp_rule;
-- 
2.41.0


