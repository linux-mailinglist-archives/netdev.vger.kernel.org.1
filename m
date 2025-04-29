Return-Path: <netdev+bounces-186895-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 208D2AA3CE4
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 01:48:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CA6F5A29B7
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 23:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2069B24678A;
	Tue, 29 Apr 2025 23:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JRb7bk7U"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69700280323
	for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 23:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745970425; cv=none; b=vD840IfKuTnHOQfowUsAJr6HobUjf699Apn8AxLoj+qN+5SFaZrfZzoQ+Hm8p1WEOhnZiXVkyphyagpncPUomi8Qi9GNUBm9z9WSgKrLVFb+TWnIomM7CtNqtyQOvMtXHbXTfJGsQBeCoyb20hXzKjqC+CG/8Q1oT51NOesZucU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745970425; c=relaxed/simple;
	bh=rebgx1FTCbPOYnpZ8i1AS9g66Gi1YUP7mMn8N0fo1tc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gkU+3Uiq7Sc1RNtzv3oWgkOifpW3PKCGnh5DTennPf2uilKX8RAiwqOauuVJhmZWByN4IjmZw2YeZQujoqZEG578qnU/EfKIlerM3LcvIPIULpd+SVYYAYpOr+kkYgqMSMtZapZWmDF30sr9VjmL7YKHZXX1g9SqPXCG5bNGhYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JRb7bk7U; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745970424; x=1777506424;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rebgx1FTCbPOYnpZ8i1AS9g66Gi1YUP7mMn8N0fo1tc=;
  b=JRb7bk7UKErXU68dcGEfkgDMja087Dtl87SNZpNJyGXc/4a1OnDAZ/mb
   vLkUrGL8/kLJb+K0G/W0Gcv10NVSekgX9kqmWn8vcVS3Tn/LEmWz4c/k6
   dRtf6rzIIo0wO9aAxh3KY3+EIrblL1780Dhj944FwhsG1PJ+baUmiH//f
   5flSSLR3X4Cs+PrVkOT0ZAyelO5DNbCeBdN8QjmYfoVcGAG84Un0MN5ij
   Zrf+Wx241zeGrkQ2MatmAeL/XIMHBU4u9ZFM7gSsRWhZgBgpm0I8oaSlj
   7/mjTx2I2kpzFCxtNexefliO7M01L6kkIJJi0m2o3fI2KWMlgd+wkgWi0
   w==;
X-CSE-ConnectionGUID: QjhZm0oSSuynS7qaIkadFA==
X-CSE-MsgGUID: oYPQ63dQRBOJj8d5AZVf9A==
X-IronPort-AV: E=McAfee;i="6700,10204,11418"; a="58990097"
X-IronPort-AV: E=Sophos;i="6.15,250,1739865600"; 
   d="scan'208";a="58990097"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2025 16:47:02 -0700
X-CSE-ConnectionGUID: Dh9jjmeSSsSrrgJgEw1ENw==
X-CSE-MsgGUID: Rmru3NO8Qi6DXOLR83sBoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,250,1739865600"; 
   d="scan'208";a="137979624"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa003.fm.intel.com with ESMTP; 29 Apr 2025 16:47:00 -0700
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
Subject: [PATCH net-next 05/13] igc: Limit netdev_tc calls to MQPRIO
Date: Tue, 29 Apr 2025 16:46:40 -0700
Message-ID: <20250429234651.3982025-6-anthony.l.nguyen@intel.com>
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

Limit netdev_tc calls to MQPRIO. Currently these calls are made in
igc_tsn_enable_offload() and igc_tsn_disable_offload() which are used by
TAPRIO and ETF as well. However, these are only required for MQPRIO.

Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Mor Bar-Gabay <morx.bar.gabay@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 18 +++++++++++++++++-
 drivers/net/ethernet/intel/igc/igc_tsn.c  | 20 --------------------
 2 files changed, 17 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 5b06765a35e9..27575a1e1777 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -6730,13 +6730,14 @@ static int igc_tsn_enable_mqprio(struct igc_adapter *adapter,
 				 struct tc_mqprio_qopt_offload *mqprio)
 {
 	struct igc_hw *hw = &adapter->hw;
-	int i;
+	int err, i;
 
 	if (hw->mac.type != igc_i225)
 		return -EOPNOTSUPP;
 
 	if (!mqprio->qopt.num_tc) {
 		adapter->strict_priority_enable = false;
+		netdev_reset_tc(adapter->netdev);
 		goto apply;
 	}
 
@@ -6767,6 +6768,21 @@ static int igc_tsn_enable_mqprio(struct igc_adapter *adapter,
 	igc_save_mqprio_params(adapter, mqprio->qopt.num_tc,
 			       mqprio->qopt.offset);
 
+	err = netdev_set_num_tc(adapter->netdev, adapter->num_tc);
+	if (err)
+		return err;
+
+	for (i = 0; i < adapter->num_tc; i++) {
+		err = netdev_set_tc_queue(adapter->netdev, i, 1,
+					  adapter->queue_per_tc[i]);
+		if (err)
+			return err;
+	}
+
+	/* In case the card is configured with less than four queues. */
+	for (; i < IGC_MAX_TX_QUEUES; i++)
+		adapter->queue_per_tc[i] = i;
+
 	mqprio->qopt.hw = TC_MQPRIO_HW_OFFLOAD_TCS;
 
 apply:
diff --git a/drivers/net/ethernet/intel/igc/igc_tsn.c b/drivers/net/ethernet/intel/igc/igc_tsn.c
index b23bf0be007d..cbc49cdcaf6b 100644
--- a/drivers/net/ethernet/intel/igc/igc_tsn.c
+++ b/drivers/net/ethernet/intel/igc/igc_tsn.c
@@ -320,9 +320,6 @@ static int igc_tsn_disable_offload(struct igc_adapter *adapter)
 	wr32(IGC_QBVCYCLET_S, 0);
 	wr32(IGC_QBVCYCLET, NSEC_PER_SEC);
 
-	/* Reset mqprio TC configuration. */
-	netdev_reset_tc(adapter->netdev);
-
 	/* Restore the default Tx arbitration: Priority 0 has the highest
 	 * priority and is assigned to queue 0 and so on and so forth.
 	 */
@@ -394,23 +391,6 @@ static int igc_tsn_enable_offload(struct igc_adapter *adapter)
 		igc_tsn_set_retx_qbvfullthreshold(adapter);
 
 	if (adapter->strict_priority_enable) {
-		int err;
-
-		err = netdev_set_num_tc(adapter->netdev, adapter->num_tc);
-		if (err)
-			return err;
-
-		for (i = 0; i < adapter->num_tc; i++) {
-			err = netdev_set_tc_queue(adapter->netdev, i, 1,
-						  adapter->queue_per_tc[i]);
-			if (err)
-				return err;
-		}
-
-		/* In case the card is configured with less than four queues. */
-		for (; i < IGC_MAX_TX_QUEUES; i++)
-			adapter->queue_per_tc[i] = i;
-
 		/* Configure queue priorities according to the user provided
 		 * mapping.
 		 */
-- 
2.47.1


