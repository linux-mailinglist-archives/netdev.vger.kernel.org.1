Return-Path: <netdev+bounces-290050-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UGpNB6EADmo95QUAu9opvQ
	(envelope-from <netdev+bounces-290050-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 20:42:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BA2985970CA
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 20:42:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E12D53064DE4
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 18:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 018913FCB0C;
	Wed, 20 May 2026 18:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FgeV3ETg"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B3A3FC5B7
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 18:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779302113; cv=none; b=iSw9NfjuiXtPGO7WPUx/Vi+eM7XIFvb6f5Zw1bEdlKC8Y19slPhwAdnKxBsWw6Zrkcom8H/zVqtpE9exdXGtO1PQm+b8fdKKuuZxCFOBTSVBkUlPTq5QTRLX3F0QwMi6ryupXpRDDoPU0CdXxTjtfGETUl17ZK0L7gS5M22BBuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779302113; c=relaxed/simple;
	bh=ag9hXI9YgrcO409l5VeoPVUQmFY5eFPk0WLx0YKMmZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B2NQnIEXQR/MDAEbj9FHaxAwAy8WfkYL+9oMCm3EWlnoKI2zgpvgym3ZauSU1xpm2akVZBnsL2jmJ6aK+vaQW7fSV+trpn4Qva/XzDHLjLRip166JWnAz1mdvIYWdMLLvcu5ZsKeCOTPr3idZMeNXIfMXB8hVKG7jEwC/z8KUqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FgeV3ETg; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779302113; x=1810838113;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ag9hXI9YgrcO409l5VeoPVUQmFY5eFPk0WLx0YKMmZE=;
  b=FgeV3ETg4tiTNbJBXRrydHu90COerInnb1ymddx/A/J7N0BErhjSmzH+
   416I6N1u9qSrvMl8MtV99o78L1U7n3o8OohZYsqsxbHovjeJJPwxsLIoy
   6ueW3mD3a42WF1SArsPuwli+RdEDKchWi11BVhWrvMnNDknwFLYqFkzK2
   lv0Rys09t71LcdgnzioXhjPbkpuu+ef6iUkkV6A0F/7M2hiwSW2sN4d+d
   GD7yVmiOevhZyfe9MXM8UgsqhmjTLSKMnu9MuJGkN9prY5FtNhg06cgiF
   fZ9PQeeqadqa62dkAd3tVYMyuIuiBNfXYgR3eDqmP5vnwKSN78Xnir7l9
   A==;
X-CSE-ConnectionGUID: dRSObtfeTjm5RQu+ZoZQ3A==
X-CSE-MsgGUID: 15eQutdPRceVhpH+siZg2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11792"; a="80391778"
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; 
   d="scan'208";a="80391778"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 11:35:08 -0700
X-CSE-ConnectionGUID: hT2ZpgjWRYir5QQokGpgAg==
X-CSE-MsgGUID: JkDxHMnMTuuhGc/xlWtf2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; 
   d="scan'208";a="239423903"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa010.jf.intel.com with ESMTP; 20 May 2026 11:35:08 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	jacob.e.keller@intel.com,
	horms@kernel.org,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net 6/8] ice: skip unnecessary VF reset when setting trust
Date: Wed, 20 May 2026 11:34:54 -0700
Message-ID: <20260520183501.3360810-7-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260520183501.3360810-1-anthony.l.nguyen@intel.com>
References: <20260520183501.3360810-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290050-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:mid,intel.com:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: BA2985970CA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>

Similar to the i40e fix, ice_set_vf_trust() unconditionally calls
ice_reset_vf() when the trust setting changes. While the delay is smaller
than i40e this reset is still unnecessary in most cases.

Additionally, the original code has a race condition: it deletes MAC LLDP
filters BEFORE resetting the VF. During this deletion, the VF is still
ACTIVE and can add new MAC LLDP filters concurrently, potentially
corrupting the filter list.

When granting trust, no reset is needed - we can just set the capability
flag to allow privileged operations.

When revoking trust, we only need to reset (conservative approach) if
the VF has actually configured advanced features that require cleanup
(MAC LLDP filters, promiscuous mode). For VFs in a clean state, we can
safely change the trust setting without the disruptive reset.

When we do reset (MAC LLDP case), we fix the race condition by resetting
first to clear VF state (which blocks new MAC LLDP filter additions), then
delete existing filters safely. During cleanup, vf->trusted remains true so
ice_vf_is_lldp_ena() works properly. Only after cleanup do we set
vf->trusted = false.

When we don't reset, we manually handle capability flag via helper
function, eliminating the delay.

Fixes: 2296345416b0 ("ice: receive LLDP on trusted VFs")
Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_sriov.c | 33 +++++++++++++++++++---
 1 file changed, 29 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/ethernet/intel/ice/ice_sriov.c
index 7e00e091756d..3c64ed1b41a8 100644
--- a/drivers/net/ethernet/intel/ice/ice_sriov.c
+++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
@@ -1364,6 +1364,23 @@ int ice_set_vf_mac(struct net_device *netdev, int vf_id, u8 *mac)
 	return __ice_set_vf_mac(ice_netdev_to_pf(netdev), vf_id, mac);
 }
 
+/**
+ * ice_setup_vf_trust - Enable/disable VF trust mode without reset
+ * @vf: VF to configure
+ * @setting: trust setting
+ *
+ * Update VF flags when changing trust without performing a VF reset.
+ * This is only called when it's safe to skip the reset (VF has no advanced
+ * features configured that need cleanup).
+ */
+static void ice_setup_vf_trust(struct ice_vf *vf, bool setting)
+{
+	if (setting)
+		set_bit(ICE_VIRTCHNL_VF_CAP_PRIVILEGE, &vf->vf_caps);
+	else
+		clear_bit(ICE_VIRTCHNL_VF_CAP_PRIVILEGE, &vf->vf_caps);
+}
+
 /**
  * ice_set_vf_trust
  * @netdev: network interface device structure
@@ -1399,11 +1416,19 @@ int ice_set_vf_trust(struct net_device *netdev, int vf_id, bool trusted)
 
 	mutex_lock(&vf->cfg_lock);
 
-	while (!trusted && vf->num_mac_lldp)
-		ice_vf_update_mac_lldp_num(vf, ice_get_vf_vsi(vf), false);
-
+	/* Reset only if revoking trust and VF has advanced features configured */
+	if (!trusted &&
+	    (vf->num_mac_lldp > 0 ||
+	     test_bit(ICE_VF_STATE_UC_PROMISC, vf->vf_states) ||
+	     test_bit(ICE_VF_STATE_MC_PROMISC, vf->vf_states))) {
+		ice_reset_vf(vf, ICE_VF_RESET_NOTIFY);
+		while (vf->num_mac_lldp)
+			ice_vf_update_mac_lldp_num(vf, ice_get_vf_vsi(vf), false);
+	} else {
+		ice_setup_vf_trust(vf, trusted);
+	}
 	vf->trusted = trusted;
-	ice_reset_vf(vf, ICE_VF_RESET_NOTIFY);
+
 	dev_info(ice_pf_to_dev(pf), "VF %u is now %strusted\n",
 		 vf_id, trusted ? "" : "un");
 
-- 
2.47.1


