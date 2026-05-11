Return-Path: <netdev+bounces-286582-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KDI2AWOqAWoMhwEAu9opvQ
	(envelope-from <netdev+bounces-286582-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 12:07:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E70550B8FF
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 12:07:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C6AE03007ADC
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 09:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34AFF3BED7A;
	Mon, 11 May 2026 09:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ePc7xIln"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B58332ED0
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 09:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778493385; cv=none; b=G3tD3Xot8YesnD6ro+e3zIMm5oSG/2I303QDuY5RPIADmyK+7QxfuCeqqgVp4ceNH9G4L8F4upOjRiedIUDWAQ4JuC8io1ImobyP+SiQV203Qv2RmMbab6+nPQjsGZwEQc8+HjEIL9pfelgNcK3YESAjEr8+2GRfLOkmPtHtYE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778493385; c=relaxed/simple;
	bh=XIp0oeIsJQzf78d0AX8YdcZ+PHRQLFo3DIaxS7vAY0k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WKXpwuYsb5IDEhLEhAzFG6nQkjdopzGQDVF676f/EP95+SVlcbBfbWz0fuYHeg+WcNZWW3S/zr8Uegnpb2QsbWFqe3KVvsdjLgeqoAm+F5U/SsmgRAYBsDTsrUd2ztM0Ti79sa4K1DVHla68TGw3HjsyAeIP/RY9A28qRK6+ORc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ePc7xIln; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778493382; x=1810029382;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XIp0oeIsJQzf78d0AX8YdcZ+PHRQLFo3DIaxS7vAY0k=;
  b=ePc7xIln5EKFso1rP3kCpLRu1plHxDgrYRZr+HBQksOJ0abd2zS+yVfM
   Z4jA0z/bpAYLsgTlmSX1qhR0m/GXJy/2rltd55//3Iw1T4LtJfmCAMpri
   Of81FQUQSSZG7F2MF8zfJFONa3G4Yy9fBAENzvHU03ctRhA59WsRjIlpj
   NXgYmBeskWJyQTuttlR7F4Q3M27DPPThqAvp4uPZvyDfKp324/yaj6ef7
   IjCHpF0ypeH6RvybfmI9tAS3wP+97rDKffAh3myxXlzwlrKFR39+EV2m/
   apwrVATnPdWfpLhIfRFTU/l7yvuMU09NJns/ccKlbHRzHFE6iOpyOU/QQ
   A==;
X-CSE-ConnectionGUID: OPsWixsBTnyU9bne+QxyOQ==
X-CSE-MsgGUID: E9OxXE7LTsqhP7iM+4xonQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11782"; a="78520428"
X-IronPort-AV: E=Sophos;i="6.23,228,1770624000"; 
   d="scan'208";a="78520428"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 02:56:22 -0700
X-CSE-ConnectionGUID: W+NugB6ETQOVk1RYp6og2w==
X-CSE-MsgGUID: UbpLoN8YRr6RMJb78Ra4HA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,228,1770624000"; 
   d="scan'208";a="242377610"
Received: from pae-d-dell-r7525-263.igk.intel.com ([172.28.191.240])
  by fmviesa005.fm.intel.com with ESMTP; 11 May 2026 02:56:20 -0700
From: Przemyslaw Korba <przemyslaw.korba@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	aleksandr.loktionov@intel.com,
	arkadiusz.kubalewski@intel.com,
	Przemyslaw Korba <przemyslaw.korba@intel.com>
Subject: [PATCH iwl-net] ice: fall back to SBQ when LL PHY timer interface times out
Date: Mon, 11 May 2026 11:58:03 +0200
Message-ID: <20260511095830.1095984-1-przemyslaw.korba@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0E70550B8FF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286582-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[przemyslaw.korba@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:mid,intel.com:dkim]
X-Rspamd-Action: no action

The low-latency (LL) PHY timer interface relies on a tight, atomic poll
of the PF_SB_ATQBAL register with a 2ms timeout. After an NVM update /
EMPR, FW may need significantly longer than 2ms to start responding to
ATQBAL commands. The first PHY adjust or incval write issued by
ice_ptp_rebuild_owner() fails with -ETIMEDOUT.

Fix this by falling back to the existing SBQ-based PHY register write
path when LL times out. This makes sure PTP is initialized when FW takes
longer than expected to come back online.

Steps to reproduce:
./nvmupdate64e -if devlink -f
Update E810 card with nvmupdate64e, and observe dmesg errors:
  Failed to write PHC increment value, status -110
  PTP reset failed, error: -110 (-ETIMEDOUT)

Fixes: ef9a64c07294 ("ice: implement low latency PHY timer updates")
Signed-off-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 40 +++++++++++----------
 1 file changed, 22 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index 2c18e16fe053..9cd323bd9739 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -4771,15 +4771,12 @@ static int ice_ptp_prep_phy_adj_ll_e810(struct ice_hw *hw, s32 adj)
 				       !FIELD_GET(REG_LL_PROXY_H_EXEC, val),
 				       10, REG_LL_PROXY_H_TIMEOUT_US, false, hw,
 				       REG_LL_PROXY_H);
-	if (err) {
-		ice_debug(hw, ICE_DBG_PTP, "Failed to prepare PHY timer adjustment using low latency interface\n");
-		spin_unlock_irq(&params->atqbal_wq.lock);
-		return err;
-	}
-
 	spin_unlock_irq(&params->atqbal_wq.lock);
 
-	return 0;
+	if (err)
+		ice_debug(hw, ICE_DBG_PTP, "Failed to prepare PHY timer adjustment using low latency interface\n");
+
+	return err;
 }
 
 /**
@@ -4800,8 +4797,13 @@ static int ice_ptp_prep_phy_adj_e810(struct ice_hw *hw, s32 adj)
 	u8 tmr_idx;
 	int err;
 
-	if (hw->dev_caps.ts_dev_info.ll_phy_tmr_update)
-		return ice_ptp_prep_phy_adj_ll_e810(hw, adj);
+	if (hw->dev_caps.ts_dev_info.ll_phy_tmr_update) {
+		err = ice_ptp_prep_phy_adj_ll_e810(hw, adj);
+		if (!err)
+			return 0;
+		ice_debug(hw, ICE_DBG_PTP, "LL adj failed (%d), falling back to SBQ\n",
+			  err);
+	}
 
 	tmr_idx = hw->func_caps.ts_func_info.tmr_index_owned;
 
@@ -4864,15 +4866,12 @@ static int ice_ptp_prep_phy_incval_ll_e810(struct ice_hw *hw, u64 incval)
 				       !FIELD_GET(REG_LL_PROXY_H_EXEC, val),
 				       10, REG_LL_PROXY_H_TIMEOUT_US, false, hw,
 				       REG_LL_PROXY_H);
-	if (err) {
-		ice_debug(hw, ICE_DBG_PTP, "Failed to prepare PHY timer increment using low latency interface\n");
-		spin_unlock_irq(&params->atqbal_wq.lock);
-		return err;
-	}
-
 	spin_unlock_irq(&params->atqbal_wq.lock);
 
-	return 0;
+	if (err)
+		ice_debug(hw, ICE_DBG_PTP, "Failed to prepare PHY timer increment using low latency interface\n");
+
+	return err;
 }
 
 /**
@@ -4890,8 +4889,13 @@ static int ice_ptp_prep_phy_incval_e810(struct ice_hw *hw, u64 incval)
 	u8 tmr_idx;
 	int err;
 
-	if (hw->dev_caps.ts_dev_info.ll_phy_tmr_update)
-		return ice_ptp_prep_phy_incval_ll_e810(hw, incval);
+	if (hw->dev_caps.ts_dev_info.ll_phy_tmr_update) {
+		err = ice_ptp_prep_phy_incval_ll_e810(hw, incval);
+		if (!err)
+			return 0;
+		ice_debug(hw, ICE_DBG_PTP, "LL incval failed (%d), falling back to SBQ\n",
+			  err);
+	}
 
 	tmr_idx = hw->func_caps.ts_func_info.tmr_index_owned;
 	low = lower_32_bits(incval);

base-commit: 80b47e88f7ead00b0795e9f2833f1d0cafe11d90
-- 
2.43.0


