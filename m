Return-Path: <netdev+bounces-205945-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B8DEB00E0B
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 23:45:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 953464E719B
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 21:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7936F28FAB7;
	Thu, 10 Jul 2025 21:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kitaQ+h0"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB00E22FDFA
	for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 21:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752183929; cv=none; b=a36zmeBghy3PO0DaSEaCgR7k1Cqyqc7C5GgtGW8Xe+QX8UTpdKx6J/GjnJWDmiMCPi3nA1cu1MMNadruHQkz2DWH6nDbqEw081b75DXgQEPBltOvjGMF+h8Z/pmOGTArabyIxtSOZ9AMefjO5nBxryyurSE3xCgKRp9cdjs7+hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752183929; c=relaxed/simple;
	bh=bLaf9UVzOghw4iSyfk+pnY9V0m2wosunJvHNbTdSOj0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UbYSLFGqOgrMQoCFOgfk6gVpKCrR+AK8LB656L8S409jVa0gFgajaHh4AYBrMdPWFIurp15mxeXWnYjibnfSK+NrpeIhk0Z6PRVsf5ZQ5x5wsqUmW4B5NFR2hZyVzcXLbpVsieJdbclvnup3SHG+cogtQKt3AYGyEK9SxJl7iT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kitaQ+h0; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752183928; x=1783719928;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bLaf9UVzOghw4iSyfk+pnY9V0m2wosunJvHNbTdSOj0=;
  b=kitaQ+h0niEXuCnKT1c8wbXA0lbNFACC/44ST47IN7nZy0iK/jyjGjkp
   VGOfgCa+Vr2Kce47RxS+mbH5qKFnfrUyTWwCrqSvnb+QlLO+EtAGhLPv/
   /ZIv47W5YKbiYbsmj1rgTwA40R+q5jsewjx6Fyc7RH+3xM+lNLwKaipe6
   Kfmf/zoxUS0QOc2VIlz2bIgt2eMIc++fp2nSKPoa/eOWwn5D5GS5E7uDR
   5O3bNqLZoTdAyyDOalFg3CH7NiT7123pmnHXSSi4D+EHnoGR7xPSgRA8u
   Phba9VVzpPmZRsfh2cLtQhA76MRkUfqGVJyRIFCBvzJdfN2yd45myKGhF
   A==;
X-CSE-ConnectionGUID: zb2Mp4qHQ2qFEu16DcuveA==
X-CSE-MsgGUID: c4TxBVXRQJeN15q6BgqiGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="54192360"
X-IronPort-AV: E=Sophos;i="6.16,301,1744095600"; 
   d="scan'208";a="54192360"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 14:45:27 -0700
X-CSE-ConnectionGUID: J3YBNq/ITLKVuC4qiyhPTQ==
X-CSE-MsgGUID: AeLsBThmQhm/ehaF6VNMbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,301,1744095600"; 
   d="scan'208";a="161764942"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa004.fm.intel.com with ESMTP; 10 Jul 2025 14:45:25 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	anthony.l.nguyen@intel.com,
	madhu.chittim@intel.com,
	yahui.cao@intel.com,
	przemyslaw.kitszel@intel.com
Subject: [PATCH net-next 3/8] ice: save RSS hash configuration for migration
Date: Thu, 10 Jul 2025 14:45:12 -0700
Message-ID: <20250710214518.1824208-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250710214518.1824208-1-anthony.l.nguyen@intel.com>
References: <20250710214518.1824208-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jacob Keller <jacob.e.keller@intel.com>

The VF can program the RSS hash configuration over virtchnl. It does this
by sending a u64 bitmask which represents the current hash configuration.

It is not trivial to reverse the hardware configuration back to this hash
set for migration. Instead, save the value to the ice_vf structure when its
modified by the VF.

The rss_hashcfg value is an 8-byte field. Make room for it in ice_vf by
re-arranging some of the existing fields. There is a 4-byte gap after the
first_vector_idx, and a 4-byte gap between max_tx_rate and vf_states. Move
first_vector_idx into the later 4-byte gap, creating an 8 byte area where
rss_hashcfg can be placed. Also move the num_msix field near min_tx_rate,
filling 2 bytes of a 3 byte hole.

The end result of these changes enables placing the rss_hashcfg field into
the structure while also saving 8 bytes in size. It looks like there are a
handful of more possible cleanups to reduce the size even further, but
those have been left as a future cleanup.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_vf_lib.c   | 3 +++
 drivers/net/ethernet/intel/ice/ice_vf_lib.h   | 8 +++++---
 drivers/net/ethernet/intel/ice/ice_virtchnl.c | 4 ++++
 3 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib.c b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
index 48cd533e93b7..c639ce716d32 100644
--- a/drivers/net/ethernet/intel/ice/ice_vf_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
@@ -1022,6 +1022,9 @@ void ice_initialize_vf_entry(struct ice_vf *vf)
 	vf->num_msix = vfs->num_msix_per;
 	vf->num_vf_qs = vfs->num_qps_per;
 
+	/* set default RSS hash configuration */
+	vf->rss_hashcfg = ICE_DEFAULT_RSS_HASHCFG;
+
 	/* ctrl_vsi_idx will be set to a valid value only when iAVF
 	 * creates its first fdir rule.
 	 */
diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib.h b/drivers/net/ethernet/intel/ice/ice_vf_lib.h
index 482f4285fd35..a5ee380f8c9e 100644
--- a/drivers/net/ethernet/intel/ice/ice_vf_lib.h
+++ b/drivers/net/ethernet/intel/ice/ice_vf_lib.h
@@ -106,8 +106,7 @@ struct ice_vf {
 	u16 ctrl_vsi_idx;
 	struct ice_vf_fdir fdir;
 	struct ice_fdir_prof_info fdir_prof_info[ICE_MAX_PTGS];
-	/* first vector index of this VF in the PF space */
-	int first_vector_idx;
+	u64 rss_hashcfg;		/* RSS hash configuration */
 	struct ice_sw *vf_sw_id;	/* switch ID the VF VSIs connect to */
 	struct virtchnl_version_info vf_ver;
 	u32 driver_caps;		/* reported by VF driver */
@@ -126,10 +125,14 @@ struct ice_vf {
 	u8 link_up:1;			/* only valid if VF link is forced */
 	u8 lldp_tx_ena:1;
 
+	u16 num_msix;			/* num of MSI-X configured on this VF */
+
 	u32 ptp_caps;
 
 	unsigned int min_tx_rate;	/* Minimum Tx bandwidth limit in Mbps */
 	unsigned int max_tx_rate;	/* Maximum Tx bandwidth limit in Mbps */
+	/* first vector index of this VF in the PF space */
+	int first_vector_idx;
 	DECLARE_BITMAP(vf_states, ICE_VF_STATES_NBITS);	/* VF runtime states */
 
 	unsigned long vf_caps;		/* VF's adv. capabilities */
@@ -154,7 +157,6 @@ struct ice_vf {
 	u16 lldp_recipe_id;
 	u16 lldp_rule_id;
 
-	u16 num_msix;			/* num of MSI-X configured on this VF */
 	struct ice_vf_qs_bw qs_bw[ICE_MAX_RSS_QS_PER_VF];
 };
 
diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl.c b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
index 24426dcd8aa2..0a8f15ecac1f 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
@@ -3094,6 +3094,10 @@ static int ice_vc_set_rss_hashcfg(struct ice_vf *vf, u8 *msg)
 		v_ret = ice_err_to_virt_err(status);
 	}
 
+	/* save the requested VF configuration */
+	if (!v_ret)
+		vf->rss_hashcfg = vrh->hashcfg;
+
 	/* send the response to the VF */
 err:
 	return ice_vc_send_msg_to_vf(vf, VIRTCHNL_OP_SET_RSS_HASHCFG, v_ret,
-- 
2.47.1


