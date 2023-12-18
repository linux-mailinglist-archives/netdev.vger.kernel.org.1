Return-Path: <netdev+bounces-58653-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B0FF817B67
	for <lists+netdev@lfdr.de>; Mon, 18 Dec 2023 20:52:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACE5F284E93
	for <lists+netdev@lfdr.de>; Mon, 18 Dec 2023 19:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFDA37BEFB;
	Mon, 18 Dec 2023 19:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c1jB74Pm"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6507AE99
	for <netdev@vger.kernel.org>; Mon, 18 Dec 2023 19:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702928929; x=1734464929;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=V9K8sjjNbosvNJfKqVfd6bqinvNcMZM9RKf5gPcX42M=;
  b=c1jB74Pm4VK0lfdZCsFqaZ+vKVDC4HP57rflORnI6TuTVuW1TxS4Bj3a
   hyj8IMs+hOedOGaenajE/6zQahfXnHiCTxfiDpJreYqrR3aFUDoPIbYfq
   USmC7KK36BbhX5/UNUQ7vhhwT3/4pA2fxgckIfEyrLr0XE+X6KCNzrujR
   aZTZqkVDNVFMJ2q33DZieIOaG6XF6iHlNz3uLxqKzCBneG6sTztrKT3lR
   vuR5IO/My/nlY//n9rxfdB4bPgF26YjmLeNsBBZZGdt9+QFhKw5Xq25KK
   mqBFBWvesg/9J4ho4aPGt/IfqXPK8V9BgBes5X5dmpD1nTnMtcj99TSP+
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="394436860"
X-IronPort-AV: E=Sophos;i="6.04,286,1695711600"; 
   d="scan'208";a="394436860"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 11:48:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,286,1695711600"; 
   d="scan'208";a="23902136"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa001.jf.intel.com with ESMTP; 18 Dec 2023 11:48:39 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	anthony.l.nguyen@intel.com,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net-next 14/15] ice: cleanup inconsistent code
Date: Mon, 18 Dec 2023 11:48:29 -0800
Message-ID: <20231218194833.3397815-15-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231218194833.3397815-1-anthony.l.nguyen@intel.com>
References: <20231218194833.3397815-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jesse Brandeburg <jesse.brandeburg@intel.com>

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
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
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
index 673830b77bfd..9b4fe8ce3d3b 100644
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
2.41.0


