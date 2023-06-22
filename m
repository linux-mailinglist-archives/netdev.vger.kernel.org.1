Return-Path: <netdev+bounces-13133-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AFE273A6C0
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 18:58:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62782281A05
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 16:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38670200B5;
	Thu, 22 Jun 2023 16:57:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3851EA98
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 16:57:58 +0000 (UTC)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83F1B2116
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 09:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687453067; x=1718989067;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+kuJ0lLF36r4YB5cQZiTmkFX4ikAvmpnOhNX/1gif24=;
  b=CnXi1iXhB35b2kJD1wc2WhGEiYB8A1bmFY9bV1V1ogq/O91+7wmLEt5U
   +HfM2RhPxqCcUlpWOVCoxyki55mLca5/N+tlInprCFKxSE9JsJhNmQYA2
   WN5jtQMhdKx6v/ULcNz3WSKrUP+1bXTzxZ5BZKFkvPkzovF0SJpa7Ztne
   jYRL0jJfs+O+1mHZT2XU9cvnUzdD08hcYsVEMFJtQzQRDxea7sRTHCc3X
   Y3Wc+zOt+sDQZ21ohlyajrGDFlQCSkHlXhCUAw/6dAxAUZPid5kDmHzYt
   Q+DQjCZx8YeAKjNqggkLgApIhmuTCd9MbmvsoEjGh5cWyBmAfuaIVZccJ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="340887266"
X-IronPort-AV: E=Sophos;i="6.01,149,1684825200"; 
   d="scan'208";a="340887266"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 09:57:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="692358325"
X-IronPort-AV: E=Sophos;i="6.01,149,1684825200"; 
   d="scan'208";a="692358325"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga006.jf.intel.com with ESMTP; 22 Jun 2023 09:57:42 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	anthony.l.nguyen@intel.com,
	sasha.neftin@intel.com,
	richardcochran@gmail.com,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Naama Meir <naamax.meir@linux.intel.com>
Subject: [PATCH net v2 2/4] igc: Check if hardware TX timestamping is enabled earlier
Date: Thu, 22 Jun 2023 09:52:42 -0700
Message-Id: <20230622165244.2202786-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230622165244.2202786-1-anthony.l.nguyen@intel.com>
References: <20230622165244.2202786-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Vinicius Costa Gomes <vinicius.gomes@intel.com>

Before requesting a packet transmission to be hardware timestamped,
check if the user has TX timestamping enabled. Fixes an issue that if
a packet was internally forwarded to the NIC, and it had the
SKBTX_HW_TSTAMP flag set, the driver would mark that timestamp as
skipped.

In reality, that timestamp was "not for us", as TX timestamp could
never be enabled in the NIC.

Checking if the TX timestamping is enabled earlier has a secondary
effect that when TX timestamping is disabled, there's no need to check
for timestamp timeouts.

We should only take care to free any pending timestamp when TX
timestamping is disabled, as that skb would never be released
otherwise.

Fixes: 2c344ae24501 ("igc: Add support for TX timestamping")
Suggested-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Tested-by: Naama Meir <naamax.meir@linux.intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igc/igc.h      |  1 +
 drivers/net/ethernet/intel/igc/igc_main.c |  5 +--
 drivers/net/ethernet/intel/igc/igc_ptp.c  | 42 +++++++++++++++++++++--
 3 files changed, 43 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
index 7da0657ea48f..66fb67c17e4f 100644
--- a/drivers/net/ethernet/intel/igc/igc.h
+++ b/drivers/net/ethernet/intel/igc/igc.h
@@ -581,6 +581,7 @@ enum igc_ring_flags_t {
 	IGC_RING_FLAG_TX_CTX_IDX,
 	IGC_RING_FLAG_TX_DETECT_HANG,
 	IGC_RING_FLAG_AF_XDP_ZC,
+	IGC_RING_FLAG_TX_HWTSTAMP,
 };
 
 #define ring_uses_large_buffer(ring) \
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 9fcb263bd3a7..eb50bfd5b867 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -1585,7 +1585,8 @@ static netdev_tx_t igc_xmit_frame_ring(struct sk_buff *skb,
 		}
 	}
 
-	if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP)) {
+	if (unlikely(test_bit(IGC_RING_FLAG_TX_HWTSTAMP, &tx_ring->flags) &&
+		     skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP)) {
 		/* FIXME: add support for retrieving timestamps from
 		 * the other timer registers before skipping the
 		 * timestamping request.
@@ -1593,7 +1594,7 @@ static netdev_tx_t igc_xmit_frame_ring(struct sk_buff *skb,
 		unsigned long flags;
 
 		spin_lock_irqsave(&adapter->ptp_tx_lock, flags);
-		if (adapter->tstamp_config.tx_type == HWTSTAMP_TX_ON && !adapter->ptp_tx_skb) {
+		if (!adapter->ptp_tx_skb) {
 			skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
 			tx_flags |= IGC_TX_FLAGS_TSTAMP;
 
diff --git a/drivers/net/ethernet/intel/igc/igc_ptp.c b/drivers/net/ethernet/intel/igc/igc_ptp.c
index 56128e55f5c0..42f622ceb64b 100644
--- a/drivers/net/ethernet/intel/igc/igc_ptp.c
+++ b/drivers/net/ethernet/intel/igc/igc_ptp.c
@@ -536,9 +536,36 @@ static void igc_ptp_enable_rx_timestamp(struct igc_adapter *adapter)
 	wr32(IGC_TSYNCRXCTL, val);
 }
 
+static void igc_ptp_clear_tx_tstamp(struct igc_adapter *adapter)
+{
+	unsigned long flags;
+
+	cancel_work_sync(&adapter->ptp_tx_work);
+
+	spin_lock_irqsave(&adapter->ptp_tx_lock, flags);
+
+	dev_kfree_skb_any(adapter->ptp_tx_skb);
+	adapter->ptp_tx_skb = NULL;
+
+	spin_unlock_irqrestore(&adapter->ptp_tx_lock, flags);
+}
+
 static void igc_ptp_disable_tx_timestamp(struct igc_adapter *adapter)
 {
 	struct igc_hw *hw = &adapter->hw;
+	int i;
+
+	/* Clear the flags first to avoid new packets to be enqueued
+	 * for TX timestamping.
+	 */
+	for (i = 0; i < adapter->num_tx_queues; i++) {
+		struct igc_ring *tx_ring = adapter->tx_ring[i];
+
+		clear_bit(IGC_RING_FLAG_TX_HWTSTAMP, &tx_ring->flags);
+	}
+
+	/* Now we can clean the pending TX timestamp requests. */
+	igc_ptp_clear_tx_tstamp(adapter);
 
 	wr32(IGC_TSYNCTXCTL, 0);
 }
@@ -546,12 +573,23 @@ static void igc_ptp_disable_tx_timestamp(struct igc_adapter *adapter)
 static void igc_ptp_enable_tx_timestamp(struct igc_adapter *adapter)
 {
 	struct igc_hw *hw = &adapter->hw;
+	int i;
 
 	wr32(IGC_TSYNCTXCTL, IGC_TSYNCTXCTL_ENABLED | IGC_TSYNCTXCTL_TXSYNSIG);
 
 	/* Read TXSTMP registers to discard any timestamp previously stored. */
 	rd32(IGC_TXSTMPL);
 	rd32(IGC_TXSTMPH);
+
+	/* The hardware is ready to accept TX timestamp requests,
+	 * notify the transmit path.
+	 */
+	for (i = 0; i < adapter->num_tx_queues; i++) {
+		struct igc_ring *tx_ring = adapter->tx_ring[i];
+
+		set_bit(IGC_RING_FLAG_TX_HWTSTAMP, &tx_ring->flags);
+	}
+
 }
 
 /**
@@ -1026,9 +1064,7 @@ void igc_ptp_suspend(struct igc_adapter *adapter)
 	if (!(adapter->ptp_flags & IGC_PTP_ENABLED))
 		return;
 
-	cancel_work_sync(&adapter->ptp_tx_work);
-	dev_kfree_skb_any(adapter->ptp_tx_skb);
-	adapter->ptp_tx_skb = NULL;
+	igc_ptp_clear_tx_tstamp(adapter);
 
 	if (pci_device_is_present(adapter->pdev)) {
 		igc_ptp_time_save(adapter);
-- 
2.38.1


