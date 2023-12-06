Return-Path: <netdev+bounces-54207-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F11598063E6
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 02:02:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DFAE1C2119B
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 01:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DE3BA3F;
	Wed,  6 Dec 2023 01:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GWIosq7r"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4451122
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 17:01:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701824503; x=1733360503;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DAG53SlvXiEznWpH1OLe1Us5lOc1W2k2kq3sL4iCNd4=;
  b=GWIosq7rkfWa96vjmekQzKWj7IhnH04nGhdAqt/TU+lytGi0QufHHBAf
   Onko6q7/PUkcyWV7akzoyI43na1JEu5v8FoqmtrKZw0QuyDlu0QwK8kug
   B0k7ZfG/IZalv+5wfkhQ601KCfPwHCEnmiGvltoMNLywOcoF2Whqnfe5M
   Ti0eOXEG63PT5fAFCPouNiGqbntNlpAQSJJidwGvOj051Lgoq1/jegbYp
   kpczZM0eLIrkua/XvPhHjYkWmbrhOdv3hioQqq14Jck9VVCZfr/5qgywl
   waA8Ds8C/hKSitAfBoYQhlqcTyHRFks9YZNMJVzyUEnEqAvewnSZpSjJE
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="12700332"
X-IronPort-AV: E=Sophos;i="6.04,254,1695711600"; 
   d="scan'208";a="12700332"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 17:01:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="841655292"
X-IronPort-AV: E=Sophos;i="6.04,254,1695711600"; 
   d="scan'208";a="841655292"
Received: from jbrandeb-spr1.jf.intel.com ([10.166.28.233])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 17:01:35 -0800
From: Jesse Brandeburg <jesse.brandeburg@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	netdev@vger.kernel.org,
	aleksander.lobakin@intel.com,
	przemyslaw.kitszel@intel.com,
	horms@kernel.org,
	marcin.szycik@linux.intel.com
Subject: [PATCH iwl-next v2 14/15] ice: cleanup inconsistent code
Date: Tue,  5 Dec 2023 17:01:13 -0800
Message-Id: <20231206010114.2259388-15-jesse.brandeburg@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231206010114.2259388-1-jesse.brandeburg@intel.com>
References: <20231206010114.2259388-1-jesse.brandeburg@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It was found while doing further testing of the previous commit
fbf32a9bab91 ("ice: field get conversion") that one of the FIELD_GET
conversions should really be a FIELD_PREP. The previous code was styled
as a match to the FIELD_GET conversion, which always worked because the
shift value was 0.  The code makes way more sense as a FIELD_PREP and
was in fact the only FIELD_GET with two constant arguments in this
series.

Didn't squash this patch to make it easier to call out the
(non-impactful) bug.

Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_dcb.c | 2 +-
 drivers/net/ethernet/intel/ice/ice_lib.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_dcb.c b/drivers/net/ethernet/intel/ice/ice_dcb.c
index 7f3e00c187b4..74418c445cc4 100644
--- a/drivers/net/ethernet/intel/ice/ice_dcb.c
+++ b/drivers/net/ethernet/intel/ice/ice_dcb.c
@@ -967,7 +967,7 @@ void ice_get_dcb_cfg_from_mib_change(struct ice_port_info *pi,
 
 	mib = (struct ice_aqc_lldp_get_mib *)&event->desc.params.raw;
 
-	change_type = FIELD_GET(ICE_AQ_LLDP_MIB_TYPE_M,  mib->type);
+	change_type = FIELD_GET(ICE_AQ_LLDP_MIB_TYPE_M, mib->type);
 	if (change_type == ICE_AQ_LLDP_MIB_REMOTE)
 		dcbx_cfg = &pi->qos_cfg.remote_dcbx_cfg;
 
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 8cdd53412748..d1c1e53fe15c 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -974,8 +974,8 @@ static void ice_set_dflt_vsi_ctx(struct ice_hw *hw, struct ice_vsi_ctx *ctxt)
 	/* Traffic from VSI can be sent to LAN */
 	ctxt->info.sw_flags2 = ICE_AQ_VSI_SW_FLAG_LAN_ENA;
 	/* allow all untagged/tagged packets by default on Tx */
-	ctxt->info.inner_vlan_flags = FIELD_GET(ICE_AQ_VSI_INNER_VLAN_TX_MODE_M,
-						ICE_AQ_VSI_INNER_VLAN_TX_MODE_ALL);
+	ctxt->info.inner_vlan_flags = FIELD_PREP(ICE_AQ_VSI_INNER_VLAN_TX_MODE_M,
+						 ICE_AQ_VSI_INNER_VLAN_TX_MODE_ALL);
 	/* SVM - by default bits 3 and 4 in inner_vlan_flags are 0's which
 	 * results in legacy behavior (show VLAN, DEI, and UP) in descriptor.
 	 *
-- 
2.39.3


