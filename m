Return-Path: <netdev+bounces-186896-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B75E4AA3CE8
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 01:48:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E12F1BC4C27
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 23:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8165E246794;
	Tue, 29 Apr 2025 23:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TCeC3SZN"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD90243964
	for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 23:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745970425; cv=none; b=fsqIabbyb+bkqDXlTO8SiELQmhsohGcMi0nSOCs2cqvnnZVPtvhEWcACWSDKu8wRLrXVFdsRCoOt5cpGGC+jY7mTFORc0hXiv5CmDu9wD9YUjKRxXN7xF9zJney4r5Fw8QzCyvz75aPJkopsnDcV2eVj+9eUoFUthV3UXGbtPVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745970425; c=relaxed/simple;
	bh=Qnrc0l3hIObnq4m+IOz5ecWzwLSay/KIP9S/9busqIs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qMKwIoXEpXsE7uVDqjQZieLdwDEhRs9ygpeMv73gUK++FCWuGVGyK4HjFkynE09nUF2VetI8lC+GSY+BY4wYPjCRxUW3S5g71JMBTGh75slp1Ht+LWwq895g4dAffbod5z1+9ccm0WJOND4kdcDVszMQynMxJ0A72D/KCH74i5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TCeC3SZN; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745970424; x=1777506424;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Qnrc0l3hIObnq4m+IOz5ecWzwLSay/KIP9S/9busqIs=;
  b=TCeC3SZNyZNPST1fmx7JbiSSaw/zzOI6f8hv+KW9uhS8Xw1X2UZvm84w
   gKoKV0UfjE/Vvd/41OK9/gR20nhPYtqbezTqI8XId2rhyUMyFpyy2a8ur
   Q9VqpHBIpTU2U48i1+WzqEMTpRGgonE6KhTthKEJYjfbxhR+EoMsP6ixP
   CXdr0F6R8ARAJEns4dy0gje+Qm1biQaG3EPkBZAj7Im6CbXYsHwUHP4Vu
   OiVW1pbEFmA744lbagvV6tZAB9daeoIiFU0YX9DoeYqfgwMNpJGWs3hta
   j7PB+xYzjVyGdj1s87CrX6+FwsBb4/QD5Np2KNdK+MbD9Kdm9q6SQE5oG
   Q==;
X-CSE-ConnectionGUID: P8ImqpLwSY+ZPSWF52G3rA==
X-CSE-MsgGUID: mR2gl4quS2WS6Al8UB/9qw==
X-IronPort-AV: E=McAfee;i="6700,10204,11418"; a="58990104"
X-IronPort-AV: E=Sophos;i="6.15,250,1739865600"; 
   d="scan'208";a="58990104"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2025 16:47:02 -0700
X-CSE-ConnectionGUID: r9g3lrCzR7SU3fNJmAu2QQ==
X-CSE-MsgGUID: tBrt36cYS8aATnu4n423Sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,250,1739865600"; 
   d="scan'208";a="137979627"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa003.fm.intel.com with ESMTP; 29 Apr 2025 16:47:01 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Kurt Kanzenbach <kurt@linutronix.de>,
	anthony.l.nguyen@intel.com,
	vitaly.lifshits@intel.com,
	dima.ruinskiy@intel.com,
	faizal.abdul.rahim@linux.intel.com,
	bigeasy@linutronix.de,
	horms@kernel.org,
	Mor Bar-Gabay <morx.bar.gabay@intel.com>
Subject: [PATCH net-next 06/13] igc: Change Tx mode for MQPRIO offloading
Date: Tue, 29 Apr 2025 16:46:41 -0700
Message-ID: <20250429234651.3982025-7-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250429234651.3982025-1-anthony.l.nguyen@intel.com>
References: <20250429234651.3982025-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kurt Kanzenbach <kurt@linutronix.de>

The current MQPRIO offload implementation uses the legacy TSN Tx mode. In
this mode the hardware uses four packet buffers and considers queue
priorities.

In order to harmonize the TAPRIO implementation with MQPRIO, switch to the
regular TSN Tx mode. This mode also uses four packet buffers and considers
queue priorities. In addition to the legacy mode, transmission is always
coupled to Qbv. The driver already has mechanisms to use a dummy schedule
of 1 second with all gates open for ETF. Simply use this for MQPRIO too.

This reduces code and makes it easier to add support for frame preemption
later.

Tested on i225 with real time application using high priority queue, iperf3
using low priority queue and network TAP device.

Acked-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Mor Bar-Gabay <morx.bar.gabay@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igc/igc.h     |  5 ++---
 drivers/net/ethernet/intel/igc/igc_tsn.c | 19 ++-----------------
 2 files changed, 4 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
index 9bd243f23b46..859a15e4ccba 100644
--- a/drivers/net/ethernet/intel/igc/igc.h
+++ b/drivers/net/ethernet/intel/igc/igc.h
@@ -394,12 +394,11 @@ extern char igc_driver_name[];
 #define IGC_FLAG_RX_LEGACY		BIT(16)
 #define IGC_FLAG_TSN_QBV_ENABLED	BIT(17)
 #define IGC_FLAG_TSN_QAV_ENABLED	BIT(18)
-#define IGC_FLAG_TSN_LEGACY_ENABLED	BIT(19)
-#define IGC_FLAG_TSN_PREEMPT_ENABLED	BIT(20)
+#define IGC_FLAG_TSN_PREEMPT_ENABLED	BIT(19)
 
 #define IGC_FLAG_TSN_ANY_ENABLED				\
 	(IGC_FLAG_TSN_QBV_ENABLED | IGC_FLAG_TSN_QAV_ENABLED |	\
-	 IGC_FLAG_TSN_LEGACY_ENABLED | IGC_FLAG_TSN_PREEMPT_ENABLED)
+	 IGC_FLAG_TSN_PREEMPT_ENABLED)
 
 #define IGC_FLAG_RSS_FIELD_IPV4_UDP	BIT(6)
 #define IGC_FLAG_RSS_FIELD_IPV6_UDP	BIT(7)
diff --git a/drivers/net/ethernet/intel/igc/igc_tsn.c b/drivers/net/ethernet/intel/igc/igc_tsn.c
index cbc49cdcaf6b..f22cc4d4f459 100644
--- a/drivers/net/ethernet/intel/igc/igc_tsn.c
+++ b/drivers/net/ethernet/intel/igc/igc_tsn.c
@@ -171,18 +171,14 @@ static unsigned int igc_tsn_new_flags(struct igc_adapter *adapter)
 {
 	unsigned int new_flags = adapter->flags & ~IGC_FLAG_TSN_ANY_ENABLED;
 
-	if (adapter->taprio_offload_enable)
-		new_flags |= IGC_FLAG_TSN_QBV_ENABLED;
 
-	if (is_any_launchtime(adapter))
+	if (adapter->taprio_offload_enable || is_any_launchtime(adapter) ||
+	    adapter->strict_priority_enable)
 		new_flags |= IGC_FLAG_TSN_QBV_ENABLED;
 
 	if (is_cbs_enabled(adapter))
 		new_flags |= IGC_FLAG_TSN_QAV_ENABLED;
 
-	if (adapter->strict_priority_enable)
-		new_flags |= IGC_FLAG_TSN_LEGACY_ENABLED;
-
 	if (adapter->fpe.mmsv.pmac_enabled)
 		new_flags |= IGC_FLAG_TSN_PREEMPT_ENABLED;
 
@@ -326,7 +322,6 @@ static int igc_tsn_disable_offload(struct igc_adapter *adapter)
 	igc_tsn_tx_arb(adapter, queue_per_tc);
 
 	adapter->flags &= ~IGC_FLAG_TSN_QBV_ENABLED;
-	adapter->flags &= ~IGC_FLAG_TSN_LEGACY_ENABLED;
 
 	return 0;
 }
@@ -395,16 +390,6 @@ static int igc_tsn_enable_offload(struct igc_adapter *adapter)
 		 * mapping.
 		 */
 		igc_tsn_tx_arb(adapter, adapter->queue_per_tc);
-
-		/* Enable legacy TSN mode which will do strict priority without
-		 * any other TSN features.
-		 */
-		tqavctrl = rd32(IGC_TQAVCTRL);
-		tqavctrl |= IGC_TQAVCTRL_TRANSMIT_MODE_TSN;
-		tqavctrl &= ~IGC_TQAVCTRL_ENHANCED_QAV;
-		wr32(IGC_TQAVCTRL, tqavctrl);
-
-		return 0;
 	}
 
 	for (i = 0; i < adapter->num_tx_queues; i++) {
-- 
2.47.1


