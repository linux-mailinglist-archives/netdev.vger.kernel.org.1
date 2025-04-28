Return-Path: <netdev+bounces-186342-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84EAFA9E7FC
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 08:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4B7D17ADFE
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 06:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10BE1DF980;
	Mon, 28 Apr 2025 06:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mUj8jtOV"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E8C1DF247;
	Mon, 28 Apr 2025 06:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745820230; cv=none; b=QdwSBbMPn49JevLjMY+b9/Meh4gbomDS3eEsmkccNgipqsaFQr8dofzcl1AG4LQNbys3db/0GmRN5X6yb6DtQLJKGfiGiZa7m1xuzjXJyxTA+BPajl4UQZJgMeOrfJGTGTjdH+ttHM4naKstgRXhSTI8vhSfI8iCQ0jMjj21vfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745820230; c=relaxed/simple;
	bh=MOwqhJoT14poSfgYv5P8L6wv7hHxXBT7mgCaHursR+w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mUo/yckm8DeRTTE1kkqoECeaNwDlpAp8WHnE1KfIgS/dj8HOwyeyga17gfoN35htnIcKoI/+CcMDVX210nZBAS53V9KDpWSSmDEGp2+SeLCdHaHdpe1KyixOgngvIZ7Hr5szAE4huhCy0P/Rev1F3LFVyWw6RnpT4C0s5dsLiKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mUj8jtOV; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745820230; x=1777356230;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MOwqhJoT14poSfgYv5P8L6wv7hHxXBT7mgCaHursR+w=;
  b=mUj8jtOVBCI7Qru/7j2+YsGXHQyKEorsHDnL80aanqlu2oZIAYNUxi2E
   I28osuwa+y3fYhRw9H4rq6Cft+/yzGQAofO7cVitYhOJci6P5mM2OW3TE
   0F57Gm7WZ/4LaC6yL9pRPyil694x+DZppaTsQR6Sdc6hiWP5Nkm2sLY0+
   7S5jlX80BymwIDzwFiRSeZaDgYxDINu1Pz3bVLA0gFD3eEU5HUYV0Zra/
   TGyX2crd8gSicJ1Xmkui5pbOWhMUOIP74UaewrKPcdnbutJvfzOf+JU2Q
   QN6UeZY7Boup2NQ9oUsX8kinw0vNbLYpKWM+Til7P5qsIm/+2D+jr1zNL
   g==;
X-CSE-ConnectionGUID: mPQrC9usT4GNTjiWUvpEeA==
X-CSE-MsgGUID: 0ybPELGTSaG14HsOvKCRkw==
X-IronPort-AV: E=McAfee;i="6700,10204,11416"; a="51064657"
X-IronPort-AV: E=Sophos;i="6.15,245,1739865600"; 
   d="scan'208";a="51064657"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2025 23:03:49 -0700
X-CSE-ConnectionGUID: F7tjRAGxQDiikAtPK2RcmA==
X-CSE-MsgGUID: y568pPn3TvKc3yU2DWeY7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,245,1739865600"; 
   d="scan'208";a="133340843"
Received: from mohdfai2-ilbpg12-1.png.intel.com ([10.88.227.73])
  by orviesa006.jf.intel.com with ESMTP; 27 Apr 2025 23:03:45 -0700
From: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Faizal Rahim <faizal.abdul.rahim@linux.intel.com>,
	Chwee-Lin Choong <chwee.lin.choong@intel.com>
Subject: [PATCH iwl-next v1 7/8] igc: add preemptible queue support in mqprio
Date: Mon, 28 Apr 2025 02:02:24 -0400
Message-Id: <20250428060225.1306986-8-faizal.abdul.rahim@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250428060225.1306986-1-faizal.abdul.rahim@linux.intel.com>
References: <20250428060225.1306986-1-faizal.abdul.rahim@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
 drivers/net/ethernet/intel/igc/igc_main.c | 9 ++-------
 drivers/net/ethernet/intel/igc/igc_tsn.c  | 9 +++++++++
 drivers/net/ethernet/intel/igc/igc_tsn.h  | 1 +
 3 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index c6e2cfd630df..6b14b0d165f0 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -6755,6 +6755,7 @@ static int igc_tsn_enable_mqprio(struct igc_adapter *adapter,
 
 	if (!mqprio->qopt.num_tc) {
 		adapter->strict_priority_enable = false;
+		igc_fpe_clear_preempt_queue(adapter);
 		netdev_reset_tc(adapter->netdev);
 		goto apply;
 	}
@@ -6782,13 +6783,6 @@ static int igc_tsn_enable_mqprio(struct igc_adapter *adapter,
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
 
@@ -6808,6 +6802,7 @@ static int igc_tsn_enable_mqprio(struct igc_adapter *adapter,
 		adapter->queue_per_tc[i] = i;
 
 	mqprio->qopt.hw = TC_MQPRIO_HW_OFFLOAD_TCS;
+	igc_fpe_save_preempt_queue(adapter, mqprio);
 
 apply:
 	return igc_tsn_offload_apply(adapter);
diff --git a/drivers/net/ethernet/intel/igc/igc_tsn.c b/drivers/net/ethernet/intel/igc/igc_tsn.c
index 897813eb2175..9dd45c6252bf 100644
--- a/drivers/net/ethernet/intel/igc/igc_tsn.c
+++ b/drivers/net/ethernet/intel/igc/igc_tsn.c
@@ -159,6 +159,15 @@ void igc_fpe_init(struct igc_adapter *adapter)
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
2.34.1


