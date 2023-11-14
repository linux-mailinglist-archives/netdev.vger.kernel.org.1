Return-Path: <netdev+bounces-47783-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 481F17EB632
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 19:15:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 767A91C20B53
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 18:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDADE26ACD;
	Tue, 14 Nov 2023 18:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="azFAF62m"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F5F3FB20
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 18:15:23 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B327B12A
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 10:15:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699985721; x=1731521721;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QjN6zDZS7UhtQOi6LZzbycGF8J6yn5RFqxE0s1DLUC0=;
  b=azFAF62mcBta0DTBM4v85/1WP3FBAiFnWstjMFXzSjLUgZb1G5Y7N94F
   gO2cnpxKhYqXWlZK6tBIFJZ5QWbosXK83wHJtWzKYYERcDjqhbKX47qfA
   LZVD1lPRvPSkG9eobrBQB1TMDT585SWKOMQLy41OxA2KGXSaKVoVX035m
   rOpbOhinBNEnf6vhcPPB3Bi/+SldAlck8AR2+f7uuuq6CEG83eHFlo3zu
   dNRGZpTi77miO4O2yQlloFfS2DQuCirHwzzpzTcPFtTe9FpiLnccPEy4S
   PJTBxghuYo2cUPtXQStxiLvcxNxMO2AmnycyCu9kb0/FeqLJDAORl0MS1
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="390514465"
X-IronPort-AV: E=Sophos;i="6.03,302,1694761200"; 
   d="scan'208";a="390514465"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 10:15:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="741160935"
X-IronPort-AV: E=Sophos;i="6.03,302,1694761200"; 
   d="scan'208";a="741160935"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga006.jf.intel.com with ESMTP; 14 Nov 2023 10:15:01 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	anthony.l.nguyen@intel.com,
	wojciech.drewek@intel.com,
	marcin.szycik@intel.com,
	piotr.raczynski@intel.com,
	Jacob Keller <jacob.e.keller@intel.com>,
	Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Subject: [PATCH net-next 04/15] ice: track q_id in representor
Date: Tue, 14 Nov 2023 10:14:24 -0800
Message-ID: <20231114181449.1290117-5-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231114181449.1290117-1-anthony.l.nguyen@intel.com>
References: <20231114181449.1290117-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Previously queue index of control plane VSI used by port representor was
always id of VF. If we want to allow adding port representors for
different devices we have to track queue index in the port representor
structure.

Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Reviewed-by: Piotr Raczynski <piotr.raczynski@intel.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
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


