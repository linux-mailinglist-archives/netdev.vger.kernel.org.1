Return-Path: <netdev+bounces-196679-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 197F1AD5DC0
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 20:04:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8246A7A6849
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 18:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21F6129ACDA;
	Wed, 11 Jun 2025 18:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lkCUHZK6"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7040F283CA2
	for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 18:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749665012; cv=none; b=ln2KmmWu56G9NVXr9Ljky1Fhdb+Gnyd5mTb0/Pna43CsZr/XJcsZv95QFWdE7m+Va/mS1AlBZCS7pM2+TaPuRdkjLHXgO23KXr3uubghVjoec0lULwOTlCSZM5WoGlBF4wimb9Tm7SU+3+uz88iWnJFUoBJHE82o988l3+wuJoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749665012; c=relaxed/simple;
	bh=kyDLIuNcHKvOIVGDGePSs4TZqK/62E5JtECFITJh7Ic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BbsxRvOFlYiJA5Tq2y/o9/YRi4tTAwOntjSPgEOb5jJQ7f8PdwSzJLrIbZVHZSVZHehvZ+ELSq5UXxwCPbqWUKIWhIG94mTXxVO++zeoTa2tMqFop2m/4gsqVbiJA0+FfMWeifCDp2VeK17olIJ/eAIhCL48uTvH3oGTZb2YPuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lkCUHZK6; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749665010; x=1781201010;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kyDLIuNcHKvOIVGDGePSs4TZqK/62E5JtECFITJh7Ic=;
  b=lkCUHZK6jyGccmC7GGipR6vbeEPF0ZO7eTYMHEGWraVPBeoiW+Iu9J0L
   BHAH7pj5hknnh5KZjCOWg5P7Sp3hX3id+bvVd3uZlRbQgS7Sy2W3bMvnO
   D79R6HJkMYafpmutTJfbasgHyTtMwGiwLZWMU4ofwFf61A7nDq6czy0BO
   wIfrL8mynIe7KKngk0/ZZJyQlM6zOJaM/XXVmfpsSy9jEIJGaRU7HQoC9
   ctKYTjHBClotbJKjieXXU0yPBhDUpvrYY/YwsL6zFB5HKsCLzpF341qXh
   wm9uaAcZuUacaG9xyZ9Da0tunAxYmI1rBtILgi9VayTvfpQR5saalzOoX
   Q==;
X-CSE-ConnectionGUID: 5JYw9ByhRG2Va1wxTw9eeA==
X-CSE-MsgGUID: MceGX3LQTd+VfwyUNtiQcQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11461"; a="51042584"
X-IronPort-AV: E=Sophos;i="6.16,228,1744095600"; 
   d="scan'208";a="51042584"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 11:03:29 -0700
X-CSE-ConnectionGUID: rmE2plnbSSuZCMJ70DzOjw==
X-CSE-MsgGUID: jXOaktiQQxiA2Ll75nMciw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,228,1744095600"; 
   d="scan'208";a="152418312"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa004.fm.intel.com with ESMTP; 11 Jun 2025 11:03:29 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>,
	anthony.l.nguyen@intel.com,
	faizal.abdul.rahim@intel.com,
	chwee.lin.choong@intel.com,
	vladimir.oltean@nxp.com,
	horms@kernel.org,
	vitaly.lifshits@intel.com,
	dima.ruinskiy@intel.com,
	Mor Bar-Gabay <morx.bar.gabay@intel.com>
Subject: [PATCH net-next 7/7] igc: add preemptible queue support in mqprio
Date: Wed, 11 Jun 2025 11:03:09 -0700
Message-ID: <20250611180314.2059166-8-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250611180314.2059166-1-anthony.l.nguyen@intel.com>
References: <20250611180314.2059166-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>

igc already supports enabling MAC Merge for FPE. This patch adds
support for preemptible queues in mqprio.

Tested preemption with mqprio by:
1. Enable FPE:
   ethtool --set-mm enp1s0 pmac-enabled on tx-enabled on verify-enabled on
2. Enable preemptible queue in mqprio:
   mqprio num_tc 4 map 0 1 2 3 0 0 0 0 0 0 0 0 0 0 0 0 \
   queues 1@0 1@1 1@2 1@3 \
   fp P P P E

Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Mor Bar-Gabay <morx.bar.gabay@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 9 ++-------
 drivers/net/ethernet/intel/igc/igc_tsn.c  | 9 +++++++++
 drivers/net/ethernet/intel/igc/igc_tsn.h  | 1 +
 3 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 23cbe02ee238..515b9610b907 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -6765,6 +6765,7 @@ static int igc_tsn_enable_mqprio(struct igc_adapter *adapter,
 
 	if (!mqprio->qopt.num_tc) {
 		adapter->strict_priority_enable = false;
+		igc_fpe_clear_preempt_queue(adapter);
 		netdev_reset_tc(adapter->netdev);
 		goto apply;
 	}
@@ -6792,13 +6793,6 @@ static int igc_tsn_enable_mqprio(struct igc_adapter *adapter,
 		return -EOPNOTSUPP;
 	}
 
-	/* Preemption is not supported yet. */
-	if (mqprio->preemptible_tcs) {
-		NL_SET_ERR_MSG_MOD(mqprio->extack,
-				   "Preemption is not supported yet");
-		return -EOPNOTSUPP;
-	}
-
 	igc_save_mqprio_params(adapter, mqprio->qopt.num_tc,
 			       mqprio->qopt.offset);
 
@@ -6818,6 +6812,7 @@ static int igc_tsn_enable_mqprio(struct igc_adapter *adapter,
 		adapter->queue_per_tc[i] = i;
 
 	mqprio->qopt.hw = TC_MQPRIO_HW_OFFLOAD_TCS;
+	igc_fpe_save_preempt_queue(adapter, mqprio);
 
 apply:
 	return igc_tsn_offload_apply(adapter);
diff --git a/drivers/net/ethernet/intel/igc/igc_tsn.c b/drivers/net/ethernet/intel/igc/igc_tsn.c
index 811856d66571..b23b9ca451a7 100644
--- a/drivers/net/ethernet/intel/igc/igc_tsn.c
+++ b/drivers/net/ethernet/intel/igc/igc_tsn.c
@@ -160,6 +160,15 @@ void igc_fpe_init(struct igc_adapter *adapter)
 	ethtool_mmsv_init(&adapter->fpe.mmsv, adapter->netdev, &igc_mmsv_ops);
 }
 
+void igc_fpe_clear_preempt_queue(struct igc_adapter *adapter)
+{
+	for (int i = 0; i < adapter->num_tx_queues; i++) {
+		struct igc_ring *tx_ring = adapter->tx_ring[i];
+
+		tx_ring->preemptible = false;
+	}
+}
+
 static u32 igc_fpe_map_preempt_tc_to_queue(const struct igc_adapter *adapter,
 					   unsigned long preemptible_tcs)
 {
diff --git a/drivers/net/ethernet/intel/igc/igc_tsn.h b/drivers/net/ethernet/intel/igc/igc_tsn.h
index f2e8bfef4871..a95b893459d7 100644
--- a/drivers/net/ethernet/intel/igc/igc_tsn.h
+++ b/drivers/net/ethernet/intel/igc/igc_tsn.h
@@ -17,6 +17,7 @@ enum igc_txd_popts_type {
 DECLARE_STATIC_KEY_FALSE(igc_fpe_enabled);
 
 void igc_fpe_init(struct igc_adapter *adapter);
+void igc_fpe_clear_preempt_queue(struct igc_adapter *adapter);
 void igc_fpe_save_preempt_queue(struct igc_adapter *adapter,
 				const struct tc_mqprio_qopt_offload *mqprio);
 u32 igc_fpe_get_supported_frag_size(u32 frag_size);
-- 
2.47.1


