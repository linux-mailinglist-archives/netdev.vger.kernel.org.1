Return-Path: <netdev+bounces-259654-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6CONNJsNmGlF/gIAu9opvQ
	(envelope-from <netdev+bounces-259654-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 08:30:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D65716549B
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 08:30:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7142A30078A2
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 07:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F2B331A6E;
	Fri, 20 Feb 2026 07:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AdVjssof"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B932C21D3
	for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 07:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771572633; cv=none; b=tc2Y/qDAuexHZ9GouZ8G0jL17drIKmnm3MZ+REwqi1JoGDXktMt5XBuyzw+JyNO/359y0lABWeMOWre0KGORQJ+RM4wbibaE3ypQcqwTPOVrV8R2hVH3xQPMlVTCM+qLrsppZdCN9ICNrbtBIHS6gMYzINhDyoidFqsux+gjV8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771572633; c=relaxed/simple;
	bh=g1qHp+yqHAVOy50TeCw8QDVYn25BJEsO7uM3HkTDNiU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QZN4MLhIupCZz+0EPp50xzxzCqBr9AosRhJ9EbngQT6QPmBwgo+eGHzNJglG7uIIxXnhbZGp5+DtnUNhZ1EeDcbexY2zWFaBal0z3yZBV3EO8d/56xs26iuIUWIW5RcWITORzIJLdb7L/lD1tLAEa3kbmdZPApNtRKhiTDUD9qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AdVjssof; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771572632; x=1803108632;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=g1qHp+yqHAVOy50TeCw8QDVYn25BJEsO7uM3HkTDNiU=;
  b=AdVjssofc0IqVeVJjsBlp35G9HIxPfKhkcBXSuwEoVKr3zyaGNfSDsQK
   oo6O1DWvyHj2LPOLoeEM0aYGJo3BavpTwqhji6tuR5cqmt5xivee7Y4E0
   x7QIplxUTPLcWmkPTFKA0L8Xenp/QXt3jcXLChuvDb6MfIRP+N5IiBs7d
   kghniFtTCkF0TRZED6LWbtQGhYCx4E9wKOo/JG5xBPDsW8c+LcRCqDSnP
   ICd8Nmta5RR11HTvFjphzfL021trXaRtFyVtojKhjxHhovvuSuZGCMppy
   r7kfCj2WQzBf3GfimoOFaEZk0B+1RBf/SKRSDmp/cmseXf+7ZbDKmQtnT
   Q==;
X-CSE-ConnectionGUID: aWp8q+16QY2R9DiZT9euIw==
X-CSE-MsgGUID: C9Xl21VOT2SNBVt8JCZXTA==
X-IronPort-AV: E=McAfee;i="6800,10657,11706"; a="95286646"
X-IronPort-AV: E=Sophos;i="6.21,301,1763452800"; 
   d="scan'208";a="95286646"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2026 23:30:32 -0800
X-CSE-ConnectionGUID: pSRZAVG3T1WwhWaAH6MmeA==
X-CSE-MsgGUID: btf2oE5nSi2eRwOMYeFZWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,301,1763452800"; 
   d="scan'208";a="219289858"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by orviesa004.jf.intel.com with ESMTP; 19 Feb 2026 23:30:30 -0800
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	horms@kernel.org,
	marcin.szycik@linux.intel.com
Subject: [PATCH iwl-next v3 2/2] ice: implement symmetric RSS hash configuration
Date: Fri, 20 Feb 2026 08:30:25 +0100
Message-ID: <20260220073025.654391-3-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260220073025.654391-1-aleksandr.loktionov@intel.com>
References: <20260220073025.654391-1-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259654-lists,netdev=lfdr.de];
	URIBL_MULTI_FAIL(0.00)[intel.com:server fail,sto.lore.kernel.org:server fail];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:mid,intel.com:dkim,intel.com:email]
X-Rspamd-Queue-Id: 7D65716549B
X-Rspamd-Action: no action

The driver advertises symmetric RSS support via supported_input_xfrm
but ice_set_rxfh() always programmed plain Toeplitz regardless of the
requested input_xfrm, making it impossible to actually enable symmetric
hashing.

Fix ice_set_rxfh() to honour rxfh->input_xfrm: program symmetric
Toeplitz (ICE_AQ_VSI_Q_OPT_RSS_HASH_SYM_TPLZ) when RXH_XFRM_SYM_XOR
is requested, revert to plain Toeplitz when the transform is cleared,
and skip the hardware write when the function has not changed.

Make ice_set_rss_vsi_ctx() non-static and export it so ice_set_rxfh()
can reprogram the VSI context directly.  Change it to preserve
vsi->rss_hfunc across VSI reinitialisation instead of always resetting
to plain Toeplitz, which would silently undo any previously configured
symmetric hash function.

Fix ice_get_rxfh_fields() to report the hash fields actually programmed
in hardware.  When the hardware hashes on only one half of an L3 or L4
pair, complete the pair in the reported bitmap to satisfy the kernel's
symmetry validator.  For GTP flow types, report RXH_GTP_TEID honestly;
ethtool_rxfh_config_is_sym() now accepts TEID as an intrinsically
symmetric field (see preceding patch).

Tested with tools/testing/selftests/drivers/net/hw/rss_input_xfrm.py

Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 48 ++++++++++++++++----
 drivers/net/ethernet/intel/ice/ice_lib.c     |  7 +--
 drivers/net/ethernet/intel/ice/ice_lib.h     |  1 +
 3 files changed, 44 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index c6bc29c..8d00892 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -3008,14 +3008,17 @@ ice_set_rxfh_fields(struct net_device *netdev,
 	return 0;
 }
 
+#define ICE_RSS_L3_PAIR		(RXH_IP_SRC | RXH_IP_DST)
+#define ICE_RSS_L4_PAIR		(RXH_L4_B_0_1 | RXH_L4_B_2_3)
+
 static int
 ice_get_rxfh_fields(struct net_device *netdev, struct ethtool_rxfh_fields *nfc)
 {
 	struct ice_netdev_priv *np = netdev_priv(netdev);
 	struct ice_vsi *vsi = np->vsi;
 	struct ice_pf *pf = vsi->back;
+	u64 l3, l4, hash_flds;
 	struct device *dev;
-	u64 hash_flds;
 	bool symm;
 	u32 hdrs;
 
@@ -3037,8 +3040,10 @@ ice_get_rxfh_fields(struct net_device *netdev, struct ethtool_rxfh_fields *nfc)
 
 	hash_flds = ice_get_rss_cfg(&pf->hw, vsi->idx, hdrs, &symm);
 	if (hash_flds == ICE_HASH_INVALID) {
-		dev_dbg(dev, "No hash fields found for the given header type, vsi num = %d\n",
+		/* Provide default symmetric hash fields when no config exists */
+		dev_dbg(dev, "No RSS config for this flow, using symmetric defaults, vsi num = %d\n",
 			vsi->vsi_num);
+		nfc->data = RXH_IP_SRC | RXH_IP_DST | RXH_L4_B_0_1 | RXH_L4_B_2_3;
 		return 0;
 	}
 
@@ -3067,6 +3072,17 @@ ice_get_rxfh_fields(struct net_device *netdev, struct ethtool_rxfh_fields *nfc)
 	    hash_flds & ICE_FLOW_HASH_FLD_GTPU_DWN_TEID)
 		nfc->data |= (u64)RXH_GTP_TEID;
 
+	l3 = nfc->data & ICE_RSS_L3_PAIR;
+	l4 = nfc->data & ICE_RSS_L4_PAIR;
+	if (!l3 && !l4) {
+		nfc->data |= ICE_RSS_L3_PAIR | ICE_RSS_L4_PAIR;
+		return 0;
+	}
+	if (l3 && l3 != ICE_RSS_L3_PAIR)
+		nfc->data |= ICE_RSS_L3_PAIR;
+	if (l4 && l4 != ICE_RSS_L4_PAIR)
+		nfc->data |= ICE_RSS_L4_PAIR;
+
 	return 0;
 }
 
@@ -3667,7 +3683,6 @@ ice_set_rxfh(struct net_device *netdev, struct ethtool_rxfh_param *rxfh,
 	     struct netlink_ext_ack *extack)
 {
 	struct ice_netdev_priv *np = netdev_priv(netdev);
-	u8 hfunc = ICE_AQ_VSI_Q_OPT_RSS_HASH_TPLZ;
 	struct ice_vsi *vsi = np->vsi;
 	struct ice_pf *pf = vsi->back;
 	struct device *dev;
@@ -3689,13 +3704,28 @@ ice_set_rxfh(struct net_device *netdev, struct ethtool_rxfh_param *rxfh,
 		return -EOPNOTSUPP;
 	}
 
-	/* Update the VSI's hash function */
-	if (rxfh->input_xfrm & RXH_XFRM_SYM_XOR)
-		hfunc = ICE_AQ_VSI_Q_OPT_RSS_HASH_SYM_TPLZ;
+	/* Handle RSS symmetric hash transformation */
+	if (rxfh->input_xfrm != RXH_XFRM_NO_CHANGE) {
+		u8 new_hfunc;
 
-	err = ice_set_rss_hfunc(vsi, hfunc);
-	if (err)
-		return err;
+		if (rxfh->input_xfrm == RXH_XFRM_SYM_XOR)
+			new_hfunc = ICE_AQ_VSI_Q_OPT_RSS_HASH_SYM_TPLZ;
+		else if (!rxfh->input_xfrm)
+			new_hfunc = ICE_AQ_VSI_Q_OPT_RSS_HASH_TPLZ;
+		else
+			return -EOPNOTSUPP;
+
+		if (new_hfunc != vsi->rss_hfunc) {
+			err = ice_set_rss_hfunc(vsi, new_hfunc);
+			if (err) {
+				netdev_err(netdev, "Failed to set RSS hash function\n");
+				return err;
+			}
+			netdev_dbg(netdev, "RSS hash function: %sToeplitz\n",
+				    new_hfunc == ICE_AQ_VSI_Q_OPT_RSS_HASH_SYM_TPLZ ?
+				    "Symmetric " : "");
+		}
+	}
 
 	if (rxfh->key) {
 		if (!vsi->rss_hkey_user) {
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index d921269..5b1934b 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -1155,7 +1155,7 @@ static void ice_set_fd_vsi_ctx(struct ice_vsi_ctx *ctxt, struct ice_vsi *vsi)
  * @ctxt: the VSI context being set
  * @vsi: the VSI being configured
  */
-static void ice_set_rss_vsi_ctx(struct ice_vsi_ctx *ctxt, struct ice_vsi *vsi)
+void ice_set_rss_vsi_ctx(struct ice_vsi_ctx *ctxt, struct ice_vsi *vsi)
 {
 	u8 lut_type, hash_type;
 	struct device *dev;
@@ -1181,8 +1181,9 @@ static void ice_set_rss_vsi_ctx(struct ice_vsi_ctx *ctxt, struct ice_vsi *vsi)
 		return;
 	}
 
-	hash_type = ICE_AQ_VSI_Q_OPT_RSS_HASH_TPLZ;
-	vsi->rss_hfunc = hash_type;
+	if (!vsi->rss_hfunc)
+		vsi->rss_hfunc = ICE_AQ_VSI_Q_OPT_RSS_HASH_TPLZ;
+	hash_type = vsi->rss_hfunc;
 
 	ctxt->info.q_opt_rss =
 		FIELD_PREP(ICE_AQ_VSI_Q_OPT_RSS_LUT_M, lut_type) |
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.h b/drivers/net/ethernet/intel/ice/ice_lib.h
index 49454d98..29ba335 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.h
+++ b/drivers/net/ethernet/intel/ice/ice_lib.h
@@ -46,6 +46,7 @@ void ice_vsi_delete(struct ice_vsi *vsi);
 int ice_vsi_cfg_tc(struct ice_vsi *vsi, u8 ena_tc);
 
 int ice_vsi_cfg_rss_lut_key(struct ice_vsi *vsi);
+void ice_set_rss_vsi_ctx(struct ice_vsi_ctx *ctxt, struct ice_vsi *vsi);
 
 void ice_vsi_cfg_netdev_tc(struct ice_vsi *vsi, u8 ena_tc);
 
-- 
2.52.0


