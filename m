Return-Path: <netdev+bounces-224830-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D50B8AD5C
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 19:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43F307B6EFD
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 17:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3139323400;
	Fri, 19 Sep 2025 17:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bE+iWNLK"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12139322DA7
	for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 17:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758304466; cv=none; b=dRLqXt9prnV+3/N71LBtHdFuAbiW4EJucqkZw5psHIV8qgEEjwXFpjLK4iCRCa3xSSwYw5wxEUz9Ustp6PJRqUSRheDXqqVMlqlGNbivobq0fOfjth6RlhhYjZ4IoM83/vivVA3dkQ2RFau6Ut0tpU0CDJCB1DVLldpISt3sdIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758304466; c=relaxed/simple;
	bh=2vtuV5io0Ekp+g31gG37Ume5llfD1JOkQF3MSMqkeGo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T2aQ/qhRrwjAaZ66dwq6WVssJ+rJ5Ljq/1hCy62+nH9r0cfi7Nun4wgZtyHN2mUxtDE1BKXiP0P+ySzGwaixE8PbkpT3XY5j5H2RamVJw06g60S4e1YbOyZEHWyW0zxaIixyIJtvHimpSHuVYyIK5hpQ/o5nzMaLzwzqsEISC4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bE+iWNLK; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758304466; x=1789840466;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2vtuV5io0Ekp+g31gG37Ume5llfD1JOkQF3MSMqkeGo=;
  b=bE+iWNLKA0j3r/nmh8QeDaO5e+lBYcpGyMI492c46q+UzJbte08twI0y
   9UfxxV0vw+eCSsP4OWzoyeVjyeq0FrIgwtYBnPDQZtsE+VsNcj+D6uB5R
   139nTp1yY5frQmWrLqC2EwtPGJjJz4X6b5B+lgL03B7SSZGMxtLEX0Yci
   4zBwmo+MmY6+GL7oM9DIT9eigmaaiDbzd5OUperWmBHPjtYMYlp21h8m4
   jnn5K+rGtfPRPvez39b24xAwBejQ/yBymJ6+S2BPYuINIXQf8ATbofrOi
   Pgi7B0s76a5IVhfliHfRAH8VliDktu2Um2l0/cowv9NTPqQ+8WT7ehSDj
   Q==;
X-CSE-ConnectionGUID: HmFq43G2SjiI28Saut3reQ==
X-CSE-MsgGUID: X1faZPgtSwKAzvdu8KFJYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11558"; a="78097105"
X-IronPort-AV: E=Sophos;i="6.18,278,1751266800"; 
   d="scan'208";a="78097105"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2025 10:54:22 -0700
X-CSE-ConnectionGUID: hxqE+BIpQ5qpWqCcNjrsuA==
X-CSE-MsgGUID: tHhI2HCXS6Gs7UdAGHwSaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,278,1751266800"; 
   d="scan'208";a="176709501"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa010.fm.intel.com with ESMTP; 19 Sep 2025 10:54:21 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Brahmajit Das <listout@listout.xyz>,
	anthony.l.nguyen@intel.com,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH net-next 7/7] net: intel: fm10k: Fix parameter idx set but not used
Date: Fri, 19 Sep 2025 10:54:10 -0700
Message-ID: <20250919175412.653707-8-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250919175412.653707-1-anthony.l.nguyen@intel.com>
References: <20250919175412.653707-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Brahmajit Das <listout@listout.xyz>

Variable idx is set in the loop, but is never used resulting in dead
code. Building with GCC 16, which enables
-Werror=unused-but-set-parameter= by default results in build error.
This patch removes the idx parameter, since all the callers of the
fm10k_unbind_hw_stats_q as 0 as idx anyways.

Suggested-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Signed-off-by: Brahmajit Das <listout@listout.xyz>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_common.c | 5 ++---
 drivers/net/ethernet/intel/fm10k/fm10k_common.h | 2 +-
 drivers/net/ethernet/intel/fm10k/fm10k_pf.c     | 2 +-
 drivers/net/ethernet/intel/fm10k/fm10k_vf.c     | 2 +-
 4 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_common.c b/drivers/net/ethernet/intel/fm10k/fm10k_common.c
index f51a63fca513..1f919a50c765 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_common.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_common.c
@@ -447,17 +447,16 @@ void fm10k_update_hw_stats_q(struct fm10k_hw *hw, struct fm10k_hw_stats_q *q,
 /**
  *  fm10k_unbind_hw_stats_q - Unbind the queue counters from their queues
  *  @q: pointer to the ring of hardware statistics queue
- *  @idx: index pointing to the start of the ring iteration
  *  @count: number of queues to iterate over
  *
  *  Function invalidates the index values for the queues so any updates that
  *  may have happened are ignored and the base for the queue stats is reset.
  **/
-void fm10k_unbind_hw_stats_q(struct fm10k_hw_stats_q *q, u32 idx, u32 count)
+void fm10k_unbind_hw_stats_q(struct fm10k_hw_stats_q *q, u32 count)
 {
 	u32 i;
 
-	for (i = 0; i < count; i++, idx++, q++) {
+	for (i = 0; i < count; i++, q++) {
 		q->rx_stats_idx = 0;
 		q->tx_stats_idx = 0;
 	}
diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_common.h b/drivers/net/ethernet/intel/fm10k/fm10k_common.h
index 4c48fb73b3e7..13fca6a91a01 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_common.h
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_common.h
@@ -43,6 +43,6 @@ u32 fm10k_read_hw_stats_32b(struct fm10k_hw *hw, u32 addr,
 void fm10k_update_hw_stats_q(struct fm10k_hw *hw, struct fm10k_hw_stats_q *q,
 			     u32 idx, u32 count);
 #define fm10k_unbind_hw_stats_32b(s) ((s)->base_h = 0)
-void fm10k_unbind_hw_stats_q(struct fm10k_hw_stats_q *q, u32 idx, u32 count);
+void fm10k_unbind_hw_stats_q(struct fm10k_hw_stats_q *q, u32 count);
 s32 fm10k_get_host_state_generic(struct fm10k_hw *hw, bool *host_ready);
 #endif /* _FM10K_COMMON_H_ */
diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pf.c b/drivers/net/ethernet/intel/fm10k/fm10k_pf.c
index b9dd7b719832..3394645a18fe 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_pf.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_pf.c
@@ -1389,7 +1389,7 @@ static void fm10k_rebind_hw_stats_pf(struct fm10k_hw *hw,
 	fm10k_unbind_hw_stats_32b(&stats->nodesc_drop);
 
 	/* Unbind Queue Statistics */
-	fm10k_unbind_hw_stats_q(stats->q, 0, hw->mac.max_queues);
+	fm10k_unbind_hw_stats_q(stats->q, hw->mac.max_queues);
 
 	/* Reinitialize bases for all stats */
 	fm10k_update_hw_stats_pf(hw, stats);
diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_vf.c b/drivers/net/ethernet/intel/fm10k/fm10k_vf.c
index 7fb1961f2921..6861a0bdc14e 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_vf.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_vf.c
@@ -465,7 +465,7 @@ static void fm10k_rebind_hw_stats_vf(struct fm10k_hw *hw,
 				     struct fm10k_hw_stats *stats)
 {
 	/* Unbind Queue Statistics */
-	fm10k_unbind_hw_stats_q(stats->q, 0, hw->mac.max_queues);
+	fm10k_unbind_hw_stats_q(stats->q, hw->mac.max_queues);
 
 	/* Reinitialize bases for all stats */
 	fm10k_update_hw_stats_vf(hw, stats);
-- 
2.47.1


