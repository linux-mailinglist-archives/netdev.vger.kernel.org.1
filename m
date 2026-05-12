Return-Path: <netdev+bounces-287192-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aIkmEF9BA2ro2AEAu9opvQ
	(envelope-from <netdev+bounces-287192-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 17:03:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 98D4A523383
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 17:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C3B2B33B4413
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 14:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 344F13AB5C8;
	Tue, 12 May 2026 14:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YvLOBgCE"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6663AB495
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 14:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778594954; cv=none; b=Uc5xnmVEK1MsBF9BT/VWbsAMbMq1Rl5bGxdvXDCpzyxQ84suKi8H5ooL2qlnvkQqL1ojpebxOMR3bM+zw6xfA7B4YkvlhbGxUaLtnicNdZePjFMK3i1UbRFFQLhzpAnwOgB7q5pjByswlrGUVgSI6c57bmSaA9D7klDgZeDbI9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778594954; c=relaxed/simple;
	bh=wr/w4ZwZyqisH4IfQKaB0ps16N2j7Gli5yKaPV1r+HY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E8jdNpCsQvVwHE2nqfVsf2dDQ1ZuZDIFhD1QBfOF20gnZLDcGxarDYTneLxfNzHbtlov33oBtyWtaohOPoozxhKdDGecYQAbJCzA/5D9avheatoTlgr1sjVP834LxK8HRQCtvvqpCUGfzYjJBCH2LLndKWbofr4dsPHZbXMThCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YvLOBgCE; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778594952; x=1810130952;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wr/w4ZwZyqisH4IfQKaB0ps16N2j7Gli5yKaPV1r+HY=;
  b=YvLOBgCEHiLVYcO4N7qboymemz6a9Da+8rWMUXu6PBqMDZBJgVY/xltm
   me/XX/M5GQNXDe1wgQUl97aw5SD/28ox8lRMJvwu0sgoDwQykzsGhfzEW
   2UHJLRyFMifyJplpAllwGjTpc3JggYs6MwL6Kc4/3yyT5Psf6Equ7GGJJ
   Wifpl3ydUd/DZg6a02mdHTSCJmb6wTaRecqZX6tCuVXR6xl2X6/kt+t+1
   93diLsiO/zlsrUEhLIncWIZMoOZMuS8074+5bl7rqHfGWCqE7IxfmtCtH
   h2zartWKjpKWveGWkqofB8ooO1FCJb6s69PdOO9JbR1XGOPQKwABxEgwc
   Q==;
X-CSE-ConnectionGUID: CrbylsChS4CEz05VijYm+w==
X-CSE-MsgGUID: 8c4MZ7exTFi9xJNvCte97g==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="96929663"
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="96929663"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 07:09:12 -0700
X-CSE-ConnectionGUID: PqbxbWiJTGSOpUsuUeNhIA==
X-CSE-MsgGUID: UQxMgbU2RpqNv6CIlqKoWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="275892477"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by orviesa001.jf.intel.com with ESMTP; 12 May 2026 07:09:11 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Piotr Skajewski <piotrx.skajewski@intel.com>
Subject: [PATCH iwl-next v2 3/8] ixgbe: prevent adding duplicate FDIR perfect filter rules
Date: Tue, 12 May 2026 16:08:59 +0200
Message-ID: <20260512140904.4105236-4-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260512140904.4105236-1-aleksandr.loktionov@intel.com>
References: <20260512140904.4105236-1-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 98D4A523383
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287192-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:mid,intel.com:dkim]
X-Rspamd-Action: no action

From: Piotr Skajewski <piotrx.skajewski@intel.com>

When the same flow specification is added twice (same 5-tuple with
different sw_idx values), ixgbe_add_ethtool_fdir_entry() silently
programs the duplicate into hardware using a second FDIR table slot.
This wastes a scarce FDIR entry and can cause confusing behaviour
when deleting rules.

Add a helper ixgbe_match_ethtool_fdir_entry() that walks the in-kernel
filter list before programming hardware.  If an entry with an
identical filter (excluding the sw_idx) already exists, the new add
request is rejected with -EEXIST.

Signed-off-by: Piotr Skajewski <piotrx.skajewski@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 .../net/ethernet/intel/ixgbe/ixgbe_ethtool.c  | 25 +++++++++++++++++++
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
index ba049b3..a2009df 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
@@ -2938,6 +2938,21 @@ static int ixgbe_flowspec_to_flow_type(struct ethtool_rx_flow_spec *fsp,
 	return 1;
 }
 
+static bool ixgbe_match_ethtool_fdir_entry(struct ixgbe_adapter *adapter,
+					   struct ixgbe_fdir_filter *input)
+{
+	struct ixgbe_fdir_filter *rule = NULL;
+
+	hlist_for_each_entry(rule, &adapter->fdir_filter_list, fdir_node) {
+		if (rule->sw_idx == input->sw_idx)
+			continue;
+		if (!memcmp(&rule->filter, &input->filter,
+			    sizeof(rule->filter)))
+			return true;
+	}
+	return false;
+}
+
 static int ixgbe_add_ethtool_fdir_entry(struct ixgbe_adapter *adapter,
 					struct ethtool_rxnfc *cmd)
 {
@@ -2947,7 +2964,7 @@ static int ixgbe_add_ethtool_fdir_entry(struct ixgbe_adapter *adapter,
 	struct ixgbe_fdir_filter *input;
 	union ixgbe_atr_input mask;
-	u8 queue;
-	int err;
+	int err = -EINVAL;
+	u8 queue;
 
 	if (!(adapter->flags & IXGBE_FLAG_FDIR_PERFECT_CAPABLE))
 		return -EOPNOTSUPP;
@@ -3050,6 +3067,12 @@ static int ixgbe_add_ethtool_fdir_entry(struct ixgbe_adapter *adapter,
 	/* apply mask and compute/store hash */
 	ixgbe_atr_compute_perfect_hash_82599(&input->filter, &mask);
 
+	/* check for a duplicate filter */
+	if (ixgbe_match_ethtool_fdir_entry(adapter, input)) {
+		err = -EEXIST;
+		goto err_out_w_lock;
+	}
+
 	/* program filters to filter memory */
 	err = ixgbe_fdir_write_perfect_filter_82599(hw,
 				&input->filter, input->sw_idx, queue);
@@ -3065,7 +3088,7 @@ static int ixgbe_add_ethtool_fdir_entry(struct ixgbe_adapter *adapter,
 	spin_unlock(&adapter->fdir_perfect_lock);
 err_out:
 	kfree(input);
-	return -EINVAL;
+	return err;
 }
 
 static int ixgbe_del_ethtool_fdir_entry(struct ixgbe_adapter *adapter,
-- 
2.52.0


