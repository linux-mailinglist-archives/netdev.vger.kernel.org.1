Return-Path: <netdev+bounces-291343-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QP2lCDtdFGqgMwcAu9opvQ
	(envelope-from <netdev+bounces-291343-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 16:31:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 20EAB5CBC1F
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 16:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 20F3E3007A70
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 14:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F23F23F166E;
	Mon, 25 May 2026 14:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eq47HiLI"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF363F0A9B
	for <netdev@vger.kernel.org>; Mon, 25 May 2026 14:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779719466; cv=none; b=ZNB2S6rgMHuBdNps7fDqhuzIvwS4wyUTzbYcJOArAtCi86gLlmTd9SuTbBWk4Pc/syNYa32mC4+ca6GgNyNkofrMbwxalcZRbkr1ZzCP/34buAGUQfoDc+EJw7+u/tkXjwsj29KJ+JUPxPyUQT8w7qUo4RZUv06lWddLkclkNvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779719466; c=relaxed/simple;
	bh=Xa1s0agnNmenvv1ynBTH8x+Twf9QnOHXvqBbQZuJOAo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cXbWhxQ2Xrw1pU6DshaBKsiZ6fmsvpN8E3XPwixfjS4x8xi0PZThYW6a4HxQ9uBJrKZFS6XFJ4+Uo+Rb3SpalbqmTzcJelYUOGUrun/uaJceXqcfoeKhrApCD+c77XShNoOzt7Ce8i0CoCBUezU/aEzsA0i7NYje01wiJ/zVQzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eq47HiLI; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779719465; x=1811255465;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Xa1s0agnNmenvv1ynBTH8x+Twf9QnOHXvqBbQZuJOAo=;
  b=eq47HiLIgffp3wbwvImrdrYjXcuzNi1iYIacvgRiRZZcgTMkb+LYpcBQ
   nuosM05QvYAXmMp39tGnzATQuAVB2vOzRrD2JBhWG+NSF5ei6lnCfJNfG
   HLIuSgTcBtt9JN8ddtPoF04ju/HxYAfFT6o62zty2WuXejJOxE30UNhKU
   fGaU8hksDIhbJtrABxzNshP4h+o3CcpaeUEslHZaL/YO3qdG5+V4ZnUKB
   Esfi58lMHTT/GhQeqqBiNXC3cLNJF6zDynLkWaTXItfD9Rk+BbxIuVPg/
   ImfOgxEdRTVTkWHNX4G7lwvY32DkWnPWXdmiBPzTxtK4gXN6L9WZW/k/g
   A==;
X-CSE-ConnectionGUID: xTDYMjttQz2dzSn8Nwa5Mg==
X-CSE-MsgGUID: b3SdcHPzTMSoabmUlvUaCg==
X-IronPort-AV: E=McAfee;i="6800,10657,11797"; a="80596727"
X-IronPort-AV: E=Sophos;i="6.24,168,1774335600"; 
   d="scan'208";a="80596727"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2026 07:31:05 -0700
X-CSE-ConnectionGUID: hHs5wAhXRv+p9/mPvm0EBw==
X-CSE-MsgGUID: CKSAPFK2TKabet8uwMF9aQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,168,1774335600"; 
   d="scan'208";a="237189241"
Received: from gnrd8.igk.intel.com (HELO GNRD8) ([10.123.232.137])
  by fmviesa006.fm.intel.com with ESMTP; 25 May 2026 07:31:04 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
Subject: [RESEND PATCH iwl-net v2 3/3] ice: Cache struct ice_hw pointer for split register reads
Date: Mon, 25 May 2026 14:31:00 +0000
Message-ID: <20260525143100.2758251-4-sergey.temerkhanov@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260525143100.2758251-1-sergey.temerkhanov@intel.com>
References: <20260525143100.2758251-1-sergey.temerkhanov@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-291343-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sergey.temerkhanov@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,cloudflare.com:email]
X-Rspamd-Queue-Id: 20EAB5CBC1F
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
index 3cb05879cb3f..2755e33f9203 100644
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
@@ -1943,10 +1944,14 @@ static int ice_read_phy_and_phc_time_eth56g(struct ice_hw *hw, u8 port,
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
 
@@ -2114,10 +2119,14 @@ int ice_start_phy_timer_eth56g(struct ice_hw *hw, u8 port)
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


