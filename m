Return-Path: <netdev+bounces-293636-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aJWaJqtQHWooYwkAu9opvQ
	(envelope-from <netdev+bounces-293636-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 11:28:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F11D861C6B0
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 11:28:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DBE0730A9207
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 09:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 414E13909A7;
	Mon,  1 Jun 2026 09:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YLE9ZQqB"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9222B38F935
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 09:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780305598; cv=none; b=VpdPn9sdZC7jDrpxIw121dulEnqD44d28L+LGMpwMKizlzpMJmzrRotdgqjIy3fPhTxQoas187QFToITKxGCmNMxNzf3uVD2XdLMyzajbonD8vYFzIwoffrhUvRqxOGwLd4AD7UbbrLJJXc7tRMmv0Ie0+P6ay1/T7ENqg05MGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780305598; c=relaxed/simple;
	bh=IypKpr6nD7CZwdCbgblFS0Y8fXDRMq1O9xnmaFG2Fl4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ju8Org+I7e5jNnaKgb0vkNHodIsD9qO2OwpxTTTW66o/L0T/W5dlNavhu4wzm4N6+dzYhL96zIgEzX//ovUiut+7I8kT7qVNfVnu7qcdDWdjhCMl5GDaBBKD1ww58/96cO8459Hd/EOlPRRUMkQ9WMXktDQvf0JZO8JiJsiyQTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YLE9ZQqB; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780305596; x=1811841596;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IypKpr6nD7CZwdCbgblFS0Y8fXDRMq1O9xnmaFG2Fl4=;
  b=YLE9ZQqBJllG1xs7NsQqAdPTV1KUDLAK0U1lLJg9vpEFdBH463sVWipc
   P+mBLtnBU9IeeUG7llYf953mgQgKmPs8DaVKdpz8Bnl6XSPxV6/8MBgiV
   AmJPjXL3U/QV1iktpwsaFBkeyd2tWp0Q2ELcs8NfMeZ0mgmh+08Bt8hMt
   q8z9STCA3nMfJWx/DOGWW6JT03XS3F9YI8tJ7p0kBnSQx6V0Q013vAuuD
   87b5LlthYm3Je8j+cXtadFaQVIJ7oAnzK2dIX7w08377CFqFcVefPWpYD
   iYdSscsH1ZzfOGM+qQMx/BFTk0cFJsfTROA2mOcCHgY+wiYtVFwq3Sa6m
   Q==;
X-CSE-ConnectionGUID: l/cwHZiyQnW4dgkB4xyHEA==
X-CSE-MsgGUID: ZUEjs7LxT/m/RIbPtBWQdA==
X-IronPort-AV: E=McAfee;i="6800,10657,11803"; a="80791631"
X-IronPort-AV: E=Sophos;i="6.24,181,1774335600"; 
   d="scan'208";a="80791631"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 02:19:56 -0700
X-CSE-ConnectionGUID: NZFAIRKCSNqh9RlcUX0s5Q==
X-CSE-MsgGUID: FKGEbHG3R1qJI0RK9wtZHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,181,1774335600"; 
   d="scan'208";a="247802574"
Received: from gnrd8.igk.intel.com (HELO GNRD8) ([10.123.232.137])
  by orviesa004.jf.intel.com with ESMTP; 01 Jun 2026 02:19:56 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-net v3 3/3] ice: Cache struct ice_hw pointer for split register reads
Date: Mon,  1 Jun 2026 09:19:51 +0000
Message-ID: <20260601091951.3017848-4-sergey.temerkhanov@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260601091951.3017848-1-sergey.temerkhanov@intel.com>
References: <20260601091951.3017848-1-sergey.temerkhanov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293636-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sergey.temerkhanov@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:mid,intel.com:dkim,cloudflare.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: F11D861C6B0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Cache the primary ice_hw pointer to ensure consistency between
calls (both parts of a value will be read from the same NAC).
ice_get_primary_hw() will never return NULL, but during the
ctrl_pf cleanup there may be a case when one call will return
the pointer to the ctrl_pf->hw and the subsequent one - to the
pf->hw which generally are not the same.
Struct ice_hw is embedded in the struct ice_pf so it is protected
by the same critical section - no additional synchronization is
needed.

Fixes: e2193f9f9ec9 ("ice: enable timesync operation on 2xNAC E825 devices")
Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Tested-by: Frederick Lawler <fred@cloudflare.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index 9ea72d5f59cc..a2b7f709f3c0 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -4,6 +4,7 @@
 #include <linux/cleanup.h>
 #include <linux/delay.h>
 #include <linux/iopoll.h>
+#include "ice.h"
 #include "ice_common.h"
 #include "ice_ptp_hw.h"
 #include "ice_ptp_consts.h"
@@ -1957,10 +1958,14 @@ static int ice_read_phy_and_phc_time_eth56g(struct ice_hw *hw, u8 port,
 		zo = rd32(hw, GLTSYN_SHTIME_0(tmr_idx));
 		lo = rd32(hw, GLTSYN_SHTIME_L(tmr_idx));
 	} else {
+		struct ice_hw *pri_hw;
+
 		guard(rcu)();
 
-		zo = rd32(ice_get_primary_hw(pf), GLTSYN_SHTIME_0(tmr_idx));
-		lo = rd32(ice_get_primary_hw(pf), GLTSYN_SHTIME_L(tmr_idx));
+		pri_hw = ice_get_primary_hw(pf);
+
+		zo = rd32(pri_hw, GLTSYN_SHTIME_0(tmr_idx));
+		lo = rd32(pri_hw, GLTSYN_SHTIME_L(tmr_idx));
 	}
 	*phc_time = (u64)lo << 32 | zo;
 
@@ -2128,10 +2133,14 @@ int ice_start_phy_timer_eth56g(struct ice_hw *hw, u8 port)
 		lo = rd32(hw, GLTSYN_INCVAL_L(tmr_idx));
 		hi = rd32(hw, GLTSYN_INCVAL_H(tmr_idx));
 	} else {
+		struct ice_hw *pri_hw;
+
 		guard(rcu)();
 
-		lo = rd32(ice_get_primary_hw(pf), GLTSYN_INCVAL_L(tmr_idx));
-		hi = rd32(ice_get_primary_hw(pf), GLTSYN_INCVAL_H(tmr_idx));
+		pri_hw = ice_get_primary_hw(pf);
+
+		lo = rd32(pri_hw, GLTSYN_INCVAL_L(tmr_idx));
+		hi = rd32(pri_hw, GLTSYN_INCVAL_H(tmr_idx));
 	}
 	incval = (u64)hi << 32 | lo;
 
-- 
2.53.0


