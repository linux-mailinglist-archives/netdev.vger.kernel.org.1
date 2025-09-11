Return-Path: <netdev+bounces-222312-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46299B53D72
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 23:05:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 607D25A3050
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 21:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF2962DA765;
	Thu, 11 Sep 2025 21:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mghYd2yd"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489AD27F006
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 21:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757624740; cv=none; b=M/Y9Tzw69QsPic2Hyv4PNfifaKUirNbhsHtyvXXSspfbSnqpZMZJr47gXpy4/WtmHeLm1vuY9VPz95ARa9gEHQ2mSEwrG9NpOCvf96MzjgtbtMW2hpfG/o0huECkTPqSjRZmUx/lMMj01FBb3ctyq3OgDA2eky5g7rlpSpRwQMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757624740; c=relaxed/simple;
	bh=dc4hILu1D06owgdcaUrFbNv/ripyYrTQ+WIRtasgYL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sK58WHGxM43JNjzpZywZ+ZiUxJRtLJyDnoPdPWQdC9vo4Lq2vFf3/p2cug2YSem8VjGfNInrPqoLP3+thQgdfD/N5s4y78h6BBoQ52/lYnXsg2l9fPjjEuxDmHs4TbrDDb4S5Xkpi94bLo5AT11TAzBTbnNBcgg9CHoqQ5cKK6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mghYd2yd; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757624740; x=1789160740;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dc4hILu1D06owgdcaUrFbNv/ripyYrTQ+WIRtasgYL8=;
  b=mghYd2ydxixOuXPmcudjYJvSDNC+YdgDL5W5jLshrjPPr7Z/XLUgRGH4
   8YMoAqAghdjqKBhjuTSj0nHSR8MtSZnydcqxR+9U1JHy8WI5/jcnM+FmS
   QIW4mUJOZh5JX6gRrt3kuNtwNCcywa3aNy4kEgLP4QldWI7usv66axaYD
   SU8RgvgbCM5Zu2I905JUjVNDY42UiyyNLGVEQKoL/2daR28QH2umASNsk
   HJ+JbH/dzop5N3Y/yg6EyOqk4B4jp/e833GpxER98NgcGvAhV6tPlqP4A
   St2BgK9Nbm6h3zA7/oo7Wt2Wsqd5rV5BKOEahfW7QcIWO5qOk5u3f/xuz
   A==;
X-CSE-ConnectionGUID: RHcID/nRTfWURHdbDP/gBg==
X-CSE-MsgGUID: eMWqnvSaSZmLaZeyv1XTtA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="82558850"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="82558850"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2025 14:05:37 -0700
X-CSE-ConnectionGUID: cGD4DeOHRl+3VgaTlCS9yQ==
X-CSE-MsgGUID: rEIO6szgQ2GSJH1rAkN2Pw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,258,1751266800"; 
   d="scan'208";a="174583336"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa010.fm.intel.com with ESMTP; 11 Sep 2025 14:05:36 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	anthony.l.nguyen@intel.com,
	aleksander.lobakin@intel.com,
	przemyslaw.kitszel@intel.com,
	dawid.osuchowski@linux.intel.com,
	horms@kernel.org
Subject: [PATCH net-next 02/15] ice: move get_fwlog_data() to fwlog file
Date: Thu, 11 Sep 2025 14:05:01 -0700
Message-ID: <20250911210525.345110-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250911210525.345110-1-anthony.l.nguyen@intel.com>
References: <20250911210525.345110-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Change the function prototype to receive hw structure instead of pf to
simplify the call. Instead of passing whole event pass only msg_buf
pointer and length.

Make ice_fwlog_ring_full() static as it isn't  called from any other
context.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
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
index 92b95d92d599..dcb8e7520471 100644
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
2.47.1


