Return-Path: <netdev+bounces-212754-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6064B21C3F
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 06:48:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44D62422486
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 04:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CA472D6E4D;
	Tue, 12 Aug 2025 04:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j3ElIV7Y"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0CE12DECD2
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 04:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754974018; cv=none; b=Osx4je74WGo/jsWkpeUUW4ERRaA3Z6ihXEX+SJFlioOetwCEcbzBYqQsBmy13l1Q0+MQ3RI87KYTDUjXuufX2kLERvCu0pOOk1+Mi/QzefXSS2I7nE3tTi+36IFH/LnVjbgKyCTRGfFYejn1+8Po5KD1Lcvwf22Yn0VzqlCZPHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754974018; c=relaxed/simple;
	bh=vB/Do1r7J0DoSOADdBcH7Ab5053tPiIwINFxr5Ka8j8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s5WbqXvuI2njLvOkv5T5/9VfWno07Uh9eQTzFWs1etIEuY3s2RVhcdIS1E1gd6hL5UteVQM4ICicIlcbMg5vTeEFa4OiiLpvgIRTd5Xb9TKqYqP4BvvXK6ZKeTagEsmvPONZKTxgaRV3M5OrEbvYtO1UuPNp+jY0R9aohWBa8Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j3ElIV7Y; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754974017; x=1786510017;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vB/Do1r7J0DoSOADdBcH7Ab5053tPiIwINFxr5Ka8j8=;
  b=j3ElIV7YPD9TPHdKQ5/ZwT8pvJ1tSoD5xh7ziUQtqMC4lXHgX6VwgCLt
   AjYmKFlmZYl07kfDUG9iS8If+IWnpncMq8Q+7VTSLlj62tlpAmCjrxLmO
   6puWhY/v2Vdy7n5xL49fmqnibATLUJvxh8ZqbvDmPqWMGMwdmOn05IzPP
   MZQEBywnrTdh1DKxOoMtTyDscBgq/ddDJar6fcEUJASYasDHl13MKrIY4
   1XXYi6Vrp+R+j2sJ6GD5rsw++dtbZVsu22CyYw2MtryRa4fw0dMEPh2S5
   n54Gm2aJaoHY99QgYj77i6tjicJlr7zlDHmus0hbytUawoRJLaDXGReMa
   Q==;
X-CSE-ConnectionGUID: uaWTCJJnSBu6Bzig5KKliw==
X-CSE-MsgGUID: 1m3JQTI0R6mJp5WXIGSn4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="68612727"
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="68612727"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 21:46:56 -0700
X-CSE-ConnectionGUID: 3gOTvJLnSWq9CI1yGvx/rQ==
X-CSE-MsgGUID: Dgm6G1zMTtK12tub5NeEIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="165327872"
Received: from unknown (HELO os-delivery.igk.intel.com) ([10.102.21.165])
  by orviesa010.jf.intel.com with ESMTP; 11 Aug 2025 21:46:55 -0700
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	przemyslaw.kitszel@intel.com,
	dawid.osuchowski@linux.intel.com,
	horms@kernel.org,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: [PATCH iwl-next v2 02/15] ice: move get_fwlog_data() to fwlog file
Date: Tue, 12 Aug 2025 06:23:23 +0200
Message-ID: <20250812042337.1356907-3-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250812042337.1356907-1-michal.swiatkowski@linux.intel.com>
References: <20250812042337.1356907-1-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change the function prototype to receive hw structure instead of pf to
simplify the call. Instead of passing whole event pass only msg_buf
pointer and length.

Make ice_fwlog_ring_full() static as it isn't  called from any other
context.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/intel/ice/ice_fwlog.c | 27 +++++++++++++++++++-
 drivers/net/ethernet/intel/ice/ice_fwlog.h |  2 +-
 drivers/net/ethernet/intel/ice/ice_main.c  | 29 ++--------------------
 3 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_fwlog.c b/drivers/net/ethernet/intel/ice/ice_fwlog.c
index e48856206648..ea5d6d2d3f30 100644
--- a/drivers/net/ethernet/intel/ice/ice_fwlog.c
+++ b/drivers/net/ethernet/intel/ice/ice_fwlog.c
@@ -6,7 +6,7 @@
 #include "ice_common.h"
 #include "ice_fwlog.h"
 
-bool ice_fwlog_ring_full(struct ice_fwlog_ring *rings)
+static bool ice_fwlog_ring_full(struct ice_fwlog_ring *rings)
 {
 	u16 head, tail;
 
@@ -456,3 +456,28 @@ int ice_fwlog_unregister(struct ice_hw *hw)
 
 	return status;
 }
+
+/**
+ * ice_get_fwlog_data - copy the FW log data from ARQ event
+ * @hw: HW that the FW log event is associated with
+ * @buf: event buffer pointer
+ * @len: len of event descriptor
+ */
+void ice_get_fwlog_data(struct ice_hw *hw, u8 *buf, u16 len)
+{
+	struct ice_fwlog_data *fwlog;
+
+	fwlog = &hw->fwlog_ring.rings[hw->fwlog_ring.tail];
+
+	memset(fwlog->data, 0, PAGE_SIZE);
+	fwlog->data_size = len;
+
+	memcpy(fwlog->data, buf, fwlog->data_size);
+	ice_fwlog_ring_increment(&hw->fwlog_ring.tail, hw->fwlog_ring.size);
+
+	if (ice_fwlog_ring_full(&hw->fwlog_ring)) {
+		/* the rings are full so bump the head to create room */
+		ice_fwlog_ring_increment(&hw->fwlog_ring.head,
+					 hw->fwlog_ring.size);
+	}
+}
diff --git a/drivers/net/ethernet/intel/ice/ice_fwlog.h b/drivers/net/ethernet/intel/ice/ice_fwlog.h
index 7d95d11b6ef9..5b9244f4f0f1 100644
--- a/drivers/net/ethernet/intel/ice/ice_fwlog.h
+++ b/drivers/net/ethernet/intel/ice/ice_fwlog.h
@@ -64,7 +64,6 @@ struct ice_fwlog_ring {
 #define ICE_FWLOG_RING_SIZE_DFLT 256
 #define ICE_FWLOG_RING_SIZE_MAX 512
 
-bool ice_fwlog_ring_full(struct ice_fwlog_ring *rings);
 bool ice_fwlog_ring_empty(struct ice_fwlog_ring *rings);
 void ice_fwlog_ring_increment(u16 *item, u16 size);
 int ice_fwlog_init(struct ice_hw *hw);
@@ -73,4 +72,5 @@ int ice_fwlog_set(struct ice_hw *hw, struct ice_fwlog_cfg *cfg);
 int ice_fwlog_register(struct ice_hw *hw);
 int ice_fwlog_unregister(struct ice_hw *hw);
 void ice_fwlog_realloc_rings(struct ice_hw *hw, int index);
+void ice_get_fwlog_data(struct ice_hw *hw, u8 *buf, u16 len);
 #endif /* _ICE_FWLOG_H_ */
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index a1528edeae24..6b8eedc86b69 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -1250,32 +1250,6 @@ ice_handle_link_event(struct ice_pf *pf, struct ice_rq_event_info *event)
 	return status;
 }
 
-/**
- * ice_get_fwlog_data - copy the FW log data from ARQ event
- * @pf: PF that the FW log event is associated with
- * @event: event structure containing FW log data
- */
-static void
-ice_get_fwlog_data(struct ice_pf *pf, struct ice_rq_event_info *event)
-{
-	struct ice_fwlog_data *fwlog;
-	struct ice_hw *hw = &pf->hw;
-
-	fwlog = &hw->fwlog_ring.rings[hw->fwlog_ring.tail];
-
-	memset(fwlog->data, 0, PAGE_SIZE);
-	fwlog->data_size = le16_to_cpu(event->desc.datalen);
-
-	memcpy(fwlog->data, event->msg_buf, fwlog->data_size);
-	ice_fwlog_ring_increment(&hw->fwlog_ring.tail, hw->fwlog_ring.size);
-
-	if (ice_fwlog_ring_full(&hw->fwlog_ring)) {
-		/* the rings are full so bump the head to create room */
-		ice_fwlog_ring_increment(&hw->fwlog_ring.head,
-					 hw->fwlog_ring.size);
-	}
-}
-
 /**
  * ice_aq_prep_for_event - Prepare to wait for an AdminQ event from firmware
  * @pf: pointer to the PF private structure
@@ -1566,7 +1540,8 @@ static int __ice_clean_ctrlq(struct ice_pf *pf, enum ice_ctl_q q_type)
 			}
 			break;
 		case ice_aqc_opc_fw_logs_event:
-			ice_get_fwlog_data(pf, &event);
+			ice_get_fwlog_data(hw, event.msg_buf,
+					   le16_to_cpu(event.desc.datalen));
 			break;
 		case ice_aqc_opc_lldp_set_mib_change:
 			ice_dcb_process_lldp_set_mib_change(pf, &event);
-- 
2.49.0


