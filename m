Return-Path: <netdev+bounces-199269-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D8AEAADF965
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 00:25:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 876FD7A9A32
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 22:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3288D280A27;
	Wed, 18 Jun 2025 22:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j682H6St"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926D627F01B
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 22:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750285511; cv=none; b=K/XJukV6MnX8wScEB2bmU2GEG6ysuAWiiEBZa+j8BtyJhysD638DExNxVz091IpBG3Uk6rozhAShmOSMHPSTuAzuawVx3RXzR/ceCcFotGMMjlbeIWRxg8SD4tVETC9aOaYJXHX8hpJqaxgLfhJJV+86P7iGI0TsLnm0reFJzVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750285511; c=relaxed/simple;
	bh=2YPm4seTn/ZIa1SCJgczQ+gO+/iymLICfCYsu7Zgb8I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rfiVB1/riFnAT8rsROmWt2vohf+feEpGddTCgX36ZaXOUOOm3Mg58xYx5AJTYV8ewOuJgAbEBEWOb0L/4jNHxi+RcJLcD2M83PwtuBvKd75HizmhlI65cvQAzdemyDoj/vBqx6YAyYSRhsCHFvF5D/4S1O1iAJWnY6+Z2OGQO7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j682H6St; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750285509; x=1781821509;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=2YPm4seTn/ZIa1SCJgczQ+gO+/iymLICfCYsu7Zgb8I=;
  b=j682H6StBEUNaAeZZN++3WPv1te56F677Mt175Np3mARC42cYO1npBQA
   ymvrYjnCF6q/m0WNa/1AE4jlld74yb7PvNeUq76cXL7En2NlzVamqSKPH
   pycp9ILtA1iS6uTzD0soHaM95mYJxBHckUyEztzBckQxf7LXPVF4s4kRm
   z93WDpSMzzBkJnam19accbCTmCl4YG0A2R06dtbPr2hIR/Pz3IydpEWCR
   pznxaDz9vvylYE4aC/XolsBsXK7ilFEBlCzjmNqn1HluU5Ua43jCsZ29l
   f3Jn5tMak+RMfXhYIoJb27blF2PbszaVi0KCQBvYXiyTCEAjKuxpIxPn1
   w==;
X-CSE-ConnectionGUID: 2DOyTrVYT3y0qX0wYBOoNw==
X-CSE-MsgGUID: GUCVgOkkQ8ex9RwCRuQUrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11468"; a="52447738"
X-IronPort-AV: E=Sophos;i="6.16,246,1744095600"; 
   d="scan'208";a="52447738"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 15:25:05 -0700
X-CSE-ConnectionGUID: HJe5biCPRT6mbTbc7MJzvg==
X-CSE-MsgGUID: qx6IYD7wQ5Sek0DoqN0AXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,246,1744095600"; 
   d="scan'208";a="149870010"
Received: from jekeller-desk.jf.intel.com ([10.166.241.15])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 15:25:04 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 18 Jun 2025 15:24:38 -0700
Subject: [PATCH iwl-next 3/8] ice: save RSS hash configuration for
 migration
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250618-e810-live-migration-jk-migration-prep-v1-3-72a37485453e@intel.com>
References: <20250618-e810-live-migration-jk-migration-prep-v1-0-72a37485453e@intel.com>
In-Reply-To: <20250618-e810-live-migration-jk-migration-prep-v1-0-72a37485453e@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Cc: Jacob Keller <jacob.e.keller@intel.com>, netdev@vger.kernel.org, 
 Madhu Chittim <madhu.chittim@intel.com>, Yahui Cao <yahui.cao@intel.com>, 
 Anthony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
X-Mailer: b4 0.14.2

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
---
 drivers/net/ethernet/intel/ice/ice_vf_lib.h   | 8 +++++---
 drivers/net/ethernet/intel/ice/ice_vf_lib.c   | 3 +++
 drivers/net/ethernet/intel/ice/ice_virtchnl.c | 4 ++++
 3 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib.h b/drivers/net/ethernet/intel/ice/ice_vf_lib.h
index 482f4285fd350f3e1410b3c34eb8fdda43842fcf..a5ee380f8c9e53d6e5ac029b9942db380829a84f 100644
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
 
diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib.c b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
index dac7a04d73e270f0e4f70a693f0a1b0e08873a41..5ee74f3e82dc77ba400fe4aa6d1cb6a183f85785 100644
--- a/drivers/net/ethernet/intel/ice/ice_vf_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
@@ -1009,6 +1009,9 @@ void ice_initialize_vf_entry(struct ice_vf *vf)
 	vf->num_msix = vfs->num_msix_per;
 	vf->num_vf_qs = vfs->num_qps_per;
 
+	/* set default RSS hash configuration */
+	vf->rss_hashcfg = ICE_DEFAULT_RSS_HASHCFG;
+
 	/* ctrl_vsi_idx will be set to a valid value only when iAVF
 	 * creates its first fdir rule.
 	 */
diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl.c b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
index a6743f6874bad26b1cffe0a11d3cd98c12ea9443..65eb6757a02143f3765716dedcd090dff2d84d2c 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
@@ -3079,6 +3079,10 @@ static int ice_vc_set_rss_hashcfg(struct ice_vf *vf, u8 *msg)
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
2.48.1.397.gec9d649cc640


