Return-Path: <netdev+bounces-294939-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ObJzG6qmIGo76QAAu9opvQ
	(envelope-from <netdev+bounces-294939-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 00:11:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BABD663B831
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 00:11:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=Xs+tCG2e;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294939-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294939-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A00D8305A27F
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 22:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D4B943C057;
	Wed,  3 Jun 2026 22:08:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0109140910D
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 22:08:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780524528; cv=none; b=XWBqb5qoTOdZo9disvzOTLyMNEw8XqxJEHDlT7iyXSRvsCJbeMRkzIDcaaljaQbaVxjjSPM3kHglGQugQxqynVLF0oTXukWtgvgrXEBPQZpLISXHGPBoBkiqpbQFO3iR/y3RGcxHgv20isNp6mRseWGn7zJH68ELH2RAoGhrUeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780524528; c=relaxed/simple;
	bh=KK6SZ20YZ/h91/ZET/JUvG0QG9yCE+AXKsFYm+WOoc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UabY5mgAG+O7uy3ixYWaYOsc9MGqxroyCazlxJkButbtgiM/SgBIvyMoYYLt8DysVSpTMl4QX2K4lgSNl4pufwfwOyAmrsFeVwoli1iKZ4glGWeGei/bIb2oxIYf7gI+sniau/VHOy+PauJimtSwW0oOnPhP2ch2Xw9KO+vaWOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xs+tCG2e; arc=none smtp.client-ip=192.198.163.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780524527; x=1812060527;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KK6SZ20YZ/h91/ZET/JUvG0QG9yCE+AXKsFYm+WOoc4=;
  b=Xs+tCG2eBgH7hh7igVzulyRv2y5H7Z3UInGFbPZ8YLprh+NUbtx0Cizr
   +IjICIP2X7YnkoayWeT20LMSyh7TjTCDMSmxTFH/aH5WT3Yg8xpjS9/5j
   9PGo8xoAjWYwJ9sKBvQBTHhccLyB0g7Fan4M8lv0eMNj/ZypT0wFiqvvG
   S0Dmla8dhJG8yXi+8LvqyRhW6YIlUbXL/wu0pbQ3cRXBCpZnpyxizSDS9
   Jcl73g+TuKjEluoRf8e3sXlQM1SV6BW6zyjh/YMMPF5APcSCpc84vrHRA
   OnZQOdwDrWz/vVrmBAtl87nsBtTySv4LOHe1nKR73MxZLaN/iAK1DuInG
   A==;
X-CSE-ConnectionGUID: 8rfmDocsQyykK6mMoV11sg==
X-CSE-MsgGUID: MCpvYxFRS+avUd7Ap2wkJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11806"; a="98920957"
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="98920957"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 15:08:37 -0700
X-CSE-ConnectionGUID: v5PKAXc2ShCa0iLFOLyeAg==
X-CSE-MsgGUID: kx8hRBwfRh2XOhOY4w7/KQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="282458912"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa001.jf.intel.com with ESMTP; 03 Jun 2026 15:08:37 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Lukasz Czapnik <lukasz.czapnik@intel.com>,
	anthony.l.nguyen@intel.com,
	marcin.szycik@linux.intel.com,
	aleksandr.loktionov@intel.com,
	sandeep.penigalapati@intel.com,
	ananth.s@intel.com,
	alexander.duyck@gmail.com,
	Alexander Nowlin <alexander.nowlin@intel.com>
Subject: [PATCH net-next 10/10] ice: use ACL for ntuple rules that conflict with FDir
Date: Wed,  3 Jun 2026 15:08:26 -0700
Message-ID: <20260603220828.829969-11-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260603220828.829969-1-anthony.l.nguyen@intel.com>
References: <20260603220828.829969-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294939-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[intel.com,linux.intel.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:netdev@vger.kernel.org,m:lukasz.czapnik@intel.com,m:anthony.l.nguyen@intel.com,m:marcin.szycik@linux.intel.com,m:aleksandr.loktionov@intel.com,m:sandeep.penigalapati@intel.com,m:ananth.s@intel.com,m:alexander.duyck@gmail.com,m:alexander.nowlin@intel.com,m:andrew@lunn.ch,m:alexanderduyck@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,intel.com:mid,intel.com:dkim,intel.com:from_mime,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BABD663B831

From: Lukasz Czapnik <lukasz.czapnik@intel.com>

Flow Director can keep only one input set per flow type. After ACL support
was added for ethtool ntuple rules, the driver still only selected ACL for
rules with partial masks.

That leaves a gap for rules with full masks that still require a different
input set than the one already programmed for Flow Director. Such rules go
through the FDir path, build a different extraction sequence and then fail
because the existing FDir profile cannot be reused.

Detect this case before programming the rule. Build the candidate IP flow
segment, compare it with the active non-tunneled FDir profile and, when the
input sets differ, offload the rule through ACL if ACL is available.

Refactor the IP flow segment setup into a helper so the same logic can be
used both by the extraction-sequence configuration path and by the conflict
check.

Signed-off-by: Lukasz Czapnik <lukasz.czapnik@intel.com>
Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 .../ethernet/intel/ice/ice_ethtool_ntuple.c   | 168 +++++++++++++-----
 1 file changed, 121 insertions(+), 47 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool_ntuple.c b/drivers/net/ethernet/intel/ice/ice_ethtool_ntuple.c
index de9f4fe51aa5..ad0732f15405 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool_ntuple.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool_ntuple.c
@@ -1453,6 +1453,115 @@ ice_set_fdir_vlan_seg(struct ice_flow_seg_info *seg,
 	return 0;
 }
 
+/**
+ * ice_set_fdir_ip_flow_seg - set IP flow segment based on ethtool flow type
+ * @fsp: pointer to ethtool Rx flow specification
+ * @seg: flow segment for programming
+ * @perfect_fltr: valid on success; returns true if perfect fltr, false if not
+ *
+ * Return: 0 on success and errno in case of error.
+ */
+static int ice_set_fdir_ip_flow_seg(struct ethtool_rx_flow_spec *fsp,
+				    struct ice_flow_seg_info *seg,
+				    bool *perfect_fltr)
+{
+	switch (fsp->flow_type & ~FLOW_EXT) {
+	case TCP_V4_FLOW:
+		return ice_set_fdir_ip4_seg(seg, &fsp->m_u.tcp_ip4_spec,
+					    ICE_FLOW_SEG_HDR_TCP, perfect_fltr);
+	case UDP_V4_FLOW:
+		return ice_set_fdir_ip4_seg(seg, &fsp->m_u.tcp_ip4_spec,
+					    ICE_FLOW_SEG_HDR_UDP, perfect_fltr);
+	case SCTP_V4_FLOW:
+		return ice_set_fdir_ip4_seg(seg, &fsp->m_u.tcp_ip4_spec,
+					    ICE_FLOW_SEG_HDR_SCTP,
+					    perfect_fltr);
+	case IPV4_USER_FLOW:
+		return ice_set_fdir_ip4_usr_seg(seg, &fsp->m_u.usr_ip4_spec,
+						perfect_fltr);
+	case TCP_V6_FLOW:
+		return ice_set_fdir_ip6_seg(seg, &fsp->m_u.tcp_ip6_spec,
+					    ICE_FLOW_SEG_HDR_TCP, perfect_fltr);
+	case UDP_V6_FLOW:
+		return ice_set_fdir_ip6_seg(seg, &fsp->m_u.tcp_ip6_spec,
+					    ICE_FLOW_SEG_HDR_UDP, perfect_fltr);
+	case SCTP_V6_FLOW:
+		return ice_set_fdir_ip6_seg(seg, &fsp->m_u.tcp_ip6_spec,
+					    ICE_FLOW_SEG_HDR_SCTP,
+					    perfect_fltr);
+	case IPV6_USER_FLOW:
+		return ice_set_fdir_ip6_usr_seg(seg, &fsp->m_u.usr_ip6_spec,
+						perfect_fltr);
+	default:
+		return -EINVAL;
+	}
+}
+
+/**
+ * ice_fdir_has_input_set_conflict - Check conflict with existing FD filters
+ * @pf: PF structure
+ * @fsp: pointer to ethtool Rx flow specification
+ * @user: user-defined data parsed from flow specification
+ *
+ * Checks if adding this filter to Flow Director would cause an input set
+ * mismatch with existing filters for the same flow type by building
+ * the segment and comparing with existing profiles.
+ *
+ * Return: true if there's a conflict (use ACL), false otherwise (can use FD)
+ */
+static bool
+ice_fdir_has_input_set_conflict(struct ice_pf *pf,
+				struct ethtool_rx_flow_spec *fsp,
+				const struct ice_rx_flow_userdef *user)
+{
+	struct ice_flow_seg_info *test_seg, *old_seg;
+	bool perfect_fltr = false, conflict = false;
+	struct ice_fd_hw_prof *hw_prof;
+	struct ice_hw *hw = &pf->hw;
+	enum ice_fltr_ptype flow;
+	int err;
+
+	if ((fsp->flow_type & ~FLOW_EXT) == ETHER_FLOW)
+		return false;
+
+	flow = ice_ethtool_flow_to_fltr(fsp->flow_type & ~FLOW_EXT);
+	if (flow >= ICE_FLTR_PTYPE_MAX || !hw->fdir_prof ||
+	    !hw->fdir_prof[flow]) {
+		return false;
+	}
+
+	hw_prof = hw->fdir_prof[flow];
+	old_seg = hw_prof->fdir_seg[ICE_FD_HW_SEG_NON_TUN];
+
+	if (!old_seg || hw->fdir_fltr_cnt[flow] == 0)
+		return false;
+
+	test_seg = kzalloc_obj(*test_seg);
+	if (!test_seg)
+		return false;
+
+	err = ice_set_fdir_ip_flow_seg(fsp, test_seg, &perfect_fltr);
+
+	if (err) {
+		kfree(test_seg);
+		return false;
+	}
+
+	if (user && user->flex_fltr)
+		ice_flow_add_fld_raw(test_seg, user->flex_offset,
+				     ICE_FLTR_PRGM_FLEX_WORD_SIZE,
+				     ICE_FLOW_FLD_OFF_INVAL,
+				     ICE_FLOW_FLD_OFF_INVAL);
+
+	/* Compare the test segment with the existing segment */
+	if (memcmp(old_seg, test_seg, sizeof(*test_seg)) != 0)
+		conflict = true;
+
+	kfree(test_seg);
+
+	return conflict;
+}
+
 /**
  * ice_cfg_fdir_xtrct_seq - Configure extraction sequence for the given filter
  * @pf: PF structure
@@ -1483,57 +1592,16 @@ ice_cfg_fdir_xtrct_seq(struct ice_pf *pf, struct ethtool_rx_flow_spec *fsp,
 		return -ENOMEM;
 	}
 
-	switch (fsp->flow_type & ~FLOW_EXT) {
-	case TCP_V4_FLOW:
-		ret = ice_set_fdir_ip4_seg(seg, &fsp->m_u.tcp_ip4_spec,
-					   ICE_FLOW_SEG_HDR_TCP,
-					   &perfect_filter);
-		break;
-	case UDP_V4_FLOW:
-		ret = ice_set_fdir_ip4_seg(seg, &fsp->m_u.tcp_ip4_spec,
-					   ICE_FLOW_SEG_HDR_UDP,
-					   &perfect_filter);
-		break;
-	case SCTP_V4_FLOW:
-		ret = ice_set_fdir_ip4_seg(seg, &fsp->m_u.tcp_ip4_spec,
-					   ICE_FLOW_SEG_HDR_SCTP,
-					   &perfect_filter);
-		break;
-	case IPV4_USER_FLOW:
-		ret = ice_set_fdir_ip4_usr_seg(seg, &fsp->m_u.usr_ip4_spec,
-					       &perfect_filter);
-		break;
-	case TCP_V6_FLOW:
-		ret = ice_set_fdir_ip6_seg(seg, &fsp->m_u.tcp_ip6_spec,
-					   ICE_FLOW_SEG_HDR_TCP,
-					   &perfect_filter);
-		break;
-	case UDP_V6_FLOW:
-		ret = ice_set_fdir_ip6_seg(seg, &fsp->m_u.tcp_ip6_spec,
-					   ICE_FLOW_SEG_HDR_UDP,
-					   &perfect_filter);
-		break;
-	case SCTP_V6_FLOW:
-		ret = ice_set_fdir_ip6_seg(seg, &fsp->m_u.tcp_ip6_spec,
-					   ICE_FLOW_SEG_HDR_SCTP,
-					   &perfect_filter);
-		break;
-	case IPV6_USER_FLOW:
-		ret = ice_set_fdir_ip6_usr_seg(seg, &fsp->m_u.usr_ip6_spec,
-					       &perfect_filter);
-		break;
-	case ETHER_FLOW:
+	if ((fsp->flow_type & ~FLOW_EXT) == ETHER_FLOW) {
 		ret = ice_set_ether_flow_seg(dev, seg, &fsp->m_u.ether_spec);
 		if (!ret && (fsp->m_ext.vlan_etype || fsp->m_ext.vlan_tci)) {
-			if (!ice_fdir_vlan_valid(dev, fsp)) {
+			if (!ice_fdir_vlan_valid(dev, fsp))
 				ret = -EINVAL;
-				break;
-			}
-			ret = ice_set_fdir_vlan_seg(seg, &fsp->m_ext);
+			else
+				ret = ice_set_fdir_vlan_seg(seg, &fsp->m_ext);
 		}
-		break;
-	default:
-		ret = -EINVAL;
+	} else {
+		ret = ice_set_fdir_ip_flow_seg(fsp, seg, &perfect_filter);
 	}
 	if (ret)
 		goto err_exit;
@@ -2264,6 +2332,12 @@ int ice_add_ntuple_ethtool(struct ice_vsi *vsi, struct ethtool_rxnfc *cmd)
 	if (pf->hw.acl_tbl && ice_is_acl_filter(fsp))
 		return ice_acl_add_rule_ethtool(vsi, cmd);
 
+	/* Check if this would cause input set conflict with existing FD filters
+	 */
+	if (pf->hw.acl_tbl && ice_fdir_has_input_set_conflict(pf, fsp,
+							      &userdata))
+		return ice_acl_add_rule_ethtool(vsi, cmd);
+
 	ret = ice_cfg_fdir_xtrct_seq(pf, fsp, &userdata);
 	if (ret)
 		return ret;
-- 
2.47.1


