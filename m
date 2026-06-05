Return-Path: <netdev+bounces-295801-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3CsJM1S8Imq+cwEAu9opvQ
	(envelope-from <netdev+bounces-295801-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 14:08:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE93647F5D
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 14:08:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b="K/Uz1CEW";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295801-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-295801-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BB386301A310
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 12:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6B413F7ABE;
	Fri,  5 Jun 2026 12:05:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5772253A1
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 12:05:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780661114; cv=none; b=ZpO3RM7xQI30IdAKVOfAv6ovkUAJJqjlbKQSHvr4pAilKyMLuJJF8li+NiLkYc3eMQK7uC5Y8nJFhcrP995kXWeJ/KUiER7C211Z4yI0S3VF482FNhZweW2PoHlE/pbFEiqLTAo8Rs0zmhclQxiw1U502jfGHmxtJbwSkrpOdNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780661114; c=relaxed/simple;
	bh=PspPcxZj4eK+HGP+IlvV4ikRRIBQqslU9MXOR2NDmWk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OW5yWvlSJNwj+jDQgnnWMj4eobmp8qLCZ+oiEFPVPgzyUwoZGGQ3Rt4D/Zckbgwe90UcCzkIz42CCqicSYQuUk+RQdtT+EPId3lpsyXAyN0G1Jzr2teMLMYmplt6zIKvXF5nG2ZEYNtxwEIyP93rE2VNGboS5RwKtQQYAznIAbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K/Uz1CEW; arc=none smtp.client-ip=192.198.163.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780661113; x=1812197113;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=PspPcxZj4eK+HGP+IlvV4ikRRIBQqslU9MXOR2NDmWk=;
  b=K/Uz1CEWn3ZcCfZqwErFgpCoKm64zDTnRBLN8hHfa9o4UlWlhHO9Avy6
   kHi7CvhNqQUufQTfS6WaKbsrIDUhR8eZkJvl0xGOf04EV4HGqQftg6gu/
   aTGXyM7bIk2EZfUWFLsbEVEiyr7gYylueJ02s2AXTOI1YQb8CrXDjrIhD
   bMymwPJ1f9W9KnFFFzbDutF4WQhfE8Ne5omgBR+qYugOGa0d9KU07qzG2
   Gbxgv8uWlVEWoQU1E3jmmfvdqxcCKxBtqZeXAg4RPv1p0zSOsujC70LI1
   9yETYwpCf3SrbkQ3Lgr7e7Qoy6Iyn+Bv20wQN269A9lLLaEO8T6OlybBG
   w==;
X-CSE-ConnectionGUID: 29mcunvRTdyS2Xb8ZJ5saA==
X-CSE-MsgGUID: ww8LgEqlSn2AR6yETFVrbw==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="92178247"
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; 
   d="scan'208";a="92178247"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2026 05:05:12 -0700
X-CSE-ConnectionGUID: HJyVO94lTFOQoQX/Ra6/bw==
X-CSE-MsgGUID: XL0Nxp4UQBKcuTttpnfLMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; 
   d="scan'208";a="268759073"
Received: from pae-d-dell-r7525-263.igk.intel.com ([172.28.191.240])
  by fmviesa001.fm.intel.com with ESMTP; 05 Jun 2026 05:05:11 -0700
From: Przemyslaw Korba <przemyslaw.korba@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	konstantin.ilichev@intel.com,
	aleksander.lobakin@intel.com,
	Przemyslaw Korba <przemyslaw.korba@intel.com>
Subject: [PATCH iwl-net v3] ice: fall back to SBQ when LL PHY timer interface times out
Date: Fri,  5 Jun 2026 14:06:26 +0200
Message-ID: <20260605120734.1462847-1-przemyslaw.korba@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:intel-wired-lan@lists.osuosl.org,m:netdev@vger.kernel.org,m:anthony.l.nguyen@intel.com,m:przemyslaw.kitszel@intel.com,m:konstantin.ilichev@intel.com,m:aleksander.lobakin@intel.com,m:przemyslaw.korba@intel.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-295801-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[przemyslaw.korba@intel.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[przemyslaw.korba@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6DE93647F5D

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
v3:
* actually add TIMEDOUT check in ice_prep_phy_adj_e810 (did do it)
v2:
* add TIMEDOUT check in ice_prep_phy_adj_e810 (did not do it)
https://lore.kernel.org/intel-wired-lan/20260603114904.1297713-1-przemyslaw.korba@intel.com/
v1:
https://lore.kernel.org/intel-wired-lan/20260511095830.1095984-1-przemyslaw.korba@intel.com/
---
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 38 +++++++++++----------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index d47d5baf3281..e77c7f2b5575 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -4789,15 +4789,12 @@ static int ice_ptp_prep_phy_adj_ll_e810(struct ice_hw *hw, s32 adj)
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
@@ -4818,8 +4815,12 @@ static int ice_ptp_prep_phy_adj_e810(struct ice_hw *hw, s32 adj)
 	u8 tmr_idx;
 	int err;
 
-	if (hw->dev_caps.ts_dev_info.ll_phy_tmr_update)
-		return ice_ptp_prep_phy_adj_ll_e810(hw, adj);
+	if (hw->dev_caps.ts_dev_info.ll_phy_tmr_update) {
+		err = ice_ptp_prep_phy_adj_ll_e810(hw, adj);
+		if (err != -ETIMEDOUT)
+			return err;
+		ice_debug(hw, ICE_DBG_PTP, "LL adj timed out, falling back to SBQ\n");
+	}
 
 	tmr_idx = hw->func_caps.ts_func_info.tmr_index_owned;
 
@@ -4882,15 +4883,12 @@ static int ice_ptp_prep_phy_incval_ll_e810(struct ice_hw *hw, u64 incval)
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
@@ -4908,8 +4906,12 @@ static int ice_ptp_prep_phy_incval_e810(struct ice_hw *hw, u64 incval)
 	u8 tmr_idx;
 	int err;
 
-	if (hw->dev_caps.ts_dev_info.ll_phy_tmr_update)
-		return ice_ptp_prep_phy_incval_ll_e810(hw, incval);
+	if (hw->dev_caps.ts_dev_info.ll_phy_tmr_update) {
+		err = ice_ptp_prep_phy_incval_ll_e810(hw, incval);
+		if (err != -ETIMEDOUT)
+			return err;
+		ice_debug(hw, ICE_DBG_PTP, "LL incval timed out, falling back to SBQ\n");
+	}
 
 	tmr_idx = hw->func_caps.ts_func_info.tmr_index_owned;
 	low = lower_32_bits(incval);

base-commit: 2d72c95ac8e2d1abccf671d95b94532a8b2abb24
-- 
2.43.0


