Return-Path: <netdev+bounces-13135-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53DF173A6C6
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 18:58:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DAB52819E8
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 16:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90706200C0;
	Thu, 22 Jun 2023 16:58:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F9F200AC
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 16:58:05 +0000 (UTC)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 205C5198
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 09:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687453075; x=1718989075;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ya1PHo3AYhz5wApsF+svYqYSzhy17hiCoCkU3KsT20I=;
  b=f9bkvXJiqEmEsvHUccjSn7Z+uRZXz4GMr0WtdB0OVEOMaRozEsX/XjFn
   ahdnDe23BhhUVW+CrVHo82wVI0+xI1qtvEkvByR5taW6Sn1w7auQvDRbP
   SULxZpV7gGogJkV2gHwSItMx7kA1YqVrulmZT26KYRJf232sMF3Grele3
   AsukYHQ/nI/HPMIZaswTW+7zRSaG8f1H2gA3eyhQAUjChoE33Lv24TlFK
   84rL6vKgda+OqoHiG1TAZ2KBgcqJOBISerkzmYy2oU7DTXEtAP2QzWN/s
   TSWkV+dr5P77V1PaGkdvFd98mhirH0OH7XLsYEwiCn/BM2Z8U6FubqzHL
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="340887254"
X-IronPort-AV: E=Sophos;i="6.01,149,1684825200"; 
   d="scan'208";a="340887254"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 09:57:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="692358321"
X-IronPort-AV: E=Sophos;i="6.01,149,1684825200"; 
   d="scan'208";a="692358321"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga006.jf.intel.com with ESMTP; 22 Jun 2023 09:57:41 -0700
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
	Andre Guedes <andre.guedes@intel.com>,
	Kurt Kanzenbach <kurt@linutronix.de>,
	Naama Meir <naamax.meir@linux.intel.com>
Subject: [PATCH net v2 1/4] igc: Fix race condition in PTP tx code
Date: Thu, 22 Jun 2023 09:52:41 -0700
Message-Id: <20230622165244.2202786-2-anthony.l.nguyen@intel.com>
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

Currently, the igc driver supports timestamping only one tx packet at a
time. During the transmission flow, the skb that requires hardware
timestamping is saved in adapter->ptp_tx_skb. Once hardware has the
timestamp, an interrupt is delivered, and adapter->ptp_tx_work is
scheduled. In igc_ptp_tx_work(), we read the timestamp register, update
adapter->ptp_tx_skb, and notify the network stack.

While the thread executing the transmission flow (the user process
running in kernel mode) and the thread executing ptp_tx_work don't
access adapter->ptp_tx_skb concurrently, there are two other places
where adapter->ptp_tx_skb is accessed: igc_ptp_tx_hang() and
igc_ptp_suspend().

igc_ptp_tx_hang() is executed by the adapter->watchdog_task worker
thread which runs periodically so it is possible we have two threads
accessing ptp_tx_skb at the same time. Consider the following scenario:
right after __IGC_PTP_TX_IN_PROGRESS is set in igc_xmit_frame_ring(),
igc_ptp_tx_hang() is executed. Since adapter->ptp_tx_start hasn't been
written yet, this is considered a timeout and adapter->ptp_tx_skb is
cleaned up.

This patch fixes the issue described above by adding the ptp_tx_lock to
protect access to ptp_tx_skb and ptp_tx_start fields from igc_adapter.
Since igc_xmit_frame_ring() called in atomic context by the networking
stack, ptp_tx_lock is defined as a spinlock, and the irq safe variants
of lock/unlock are used.

With the introduction of the ptp_tx_lock, the __IGC_PTP_TX_IN_PROGRESS
flag doesn't provide much of a use anymore so this patch gets rid of it.

Fixes: 2c344ae24501 ("igc: Add support for TX timestamping")
Signed-off-by: Andre Guedes <andre.guedes@intel.com>
Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Reviewed-by: Kurt Kanzenbach <kurt@linutronix.de>
Tested-by: Naama Meir <naamax.meir@linux.intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igc/igc.h      |  5 +-
 drivers/net/ethernet/intel/igc/igc_main.c |  9 ++--
 drivers/net/ethernet/intel/igc/igc_ptp.c  | 57 ++++++++++++-----------
 3 files changed, 41 insertions(+), 30 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
index 34aebf00a512..7da0657ea48f 100644
--- a/drivers/net/ethernet/intel/igc/igc.h
+++ b/drivers/net/ethernet/intel/igc/igc.h
@@ -229,6 +229,10 @@ struct igc_adapter {
 	struct ptp_clock *ptp_clock;
 	struct ptp_clock_info ptp_caps;
 	struct work_struct ptp_tx_work;
+	/* Access to ptp_tx_skb and ptp_tx_start are protected by the
+	 * ptp_tx_lock.
+	 */
+	spinlock_t ptp_tx_lock;
 	struct sk_buff *ptp_tx_skb;
 	struct hwtstamp_config tstamp_config;
 	unsigned long ptp_tx_start;
@@ -401,7 +405,6 @@ enum igc_state_t {
 	__IGC_TESTING,
 	__IGC_RESETTING,
 	__IGC_DOWN,
-	__IGC_PTP_TX_IN_PROGRESS,
 };
 
 enum igc_tx_flags {
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index fa764190f270..9fcb263bd3a7 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -1590,9 +1590,10 @@ static netdev_tx_t igc_xmit_frame_ring(struct sk_buff *skb,
 		 * the other timer registers before skipping the
 		 * timestamping request.
 		 */
-		if (adapter->tstamp_config.tx_type == HWTSTAMP_TX_ON &&
-		    !test_and_set_bit_lock(__IGC_PTP_TX_IN_PROGRESS,
-					   &adapter->state)) {
+		unsigned long flags;
+
+		spin_lock_irqsave(&adapter->ptp_tx_lock, flags);
+		if (adapter->tstamp_config.tx_type == HWTSTAMP_TX_ON && !adapter->ptp_tx_skb) {
 			skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
 			tx_flags |= IGC_TX_FLAGS_TSTAMP;
 
@@ -1601,6 +1602,8 @@ static netdev_tx_t igc_xmit_frame_ring(struct sk_buff *skb,
 		} else {
 			adapter->tx_hwtstamp_skipped++;
 		}
+
+		spin_unlock_irqrestore(&adapter->ptp_tx_lock, flags);
 	}
 
 	if (skb_vlan_tag_present(skb)) {
diff --git a/drivers/net/ethernet/intel/igc/igc_ptp.c b/drivers/net/ethernet/intel/igc/igc_ptp.c
index 4e10ced736db..56128e55f5c0 100644
--- a/drivers/net/ethernet/intel/igc/igc_ptp.c
+++ b/drivers/net/ethernet/intel/igc/igc_ptp.c
@@ -603,6 +603,7 @@ static int igc_ptp_set_timestamp_mode(struct igc_adapter *adapter,
 	return 0;
 }
 
+/* Requires adapter->ptp_tx_lock held by caller. */
 static void igc_ptp_tx_timeout(struct igc_adapter *adapter)
 {
 	struct igc_hw *hw = &adapter->hw;
@@ -610,7 +611,6 @@ static void igc_ptp_tx_timeout(struct igc_adapter *adapter)
 	dev_kfree_skb_any(adapter->ptp_tx_skb);
 	adapter->ptp_tx_skb = NULL;
 	adapter->tx_hwtstamp_timeouts++;
-	clear_bit_unlock(__IGC_PTP_TX_IN_PROGRESS, &adapter->state);
 	/* Clear the tx valid bit in TSYNCTXCTL register to enable interrupt. */
 	rd32(IGC_TXSTMPH);
 	netdev_warn(adapter->netdev, "Tx timestamp timeout\n");
@@ -618,20 +618,20 @@ static void igc_ptp_tx_timeout(struct igc_adapter *adapter)
 
 void igc_ptp_tx_hang(struct igc_adapter *adapter)
 {
-	bool timeout = time_is_before_jiffies(adapter->ptp_tx_start +
-					      IGC_PTP_TX_TIMEOUT);
+	unsigned long flags;
 
-	if (!test_bit(__IGC_PTP_TX_IN_PROGRESS, &adapter->state))
-		return;
+	spin_lock_irqsave(&adapter->ptp_tx_lock, flags);
 
-	/* If we haven't received a timestamp within the timeout, it is
-	 * reasonable to assume that it will never occur, so we can unlock the
-	 * timestamp bit when this occurs.
-	 */
-	if (timeout) {
-		cancel_work_sync(&adapter->ptp_tx_work);
-		igc_ptp_tx_timeout(adapter);
-	}
+	if (!adapter->ptp_tx_skb)
+		goto unlock;
+
+	if (time_is_after_jiffies(adapter->ptp_tx_start + IGC_PTP_TX_TIMEOUT))
+		goto unlock;
+
+	igc_ptp_tx_timeout(adapter);
+
+unlock:
+	spin_unlock_irqrestore(&adapter->ptp_tx_lock, flags);
 }
 
 /**
@@ -641,6 +641,8 @@ void igc_ptp_tx_hang(struct igc_adapter *adapter)
  * If we were asked to do hardware stamping and such a time stamp is
  * available, then it must have been for this skb here because we only
  * allow only one such packet into the queue.
+ *
+ * Context: Expects adapter->ptp_tx_lock to be held by caller.
  */
 static void igc_ptp_tx_hwtstamp(struct igc_adapter *adapter)
 {
@@ -676,13 +678,7 @@ static void igc_ptp_tx_hwtstamp(struct igc_adapter *adapter)
 	shhwtstamps.hwtstamp =
 		ktime_add_ns(shhwtstamps.hwtstamp, adjust);
 
-	/* Clear the lock early before calling skb_tstamp_tx so that
-	 * applications are not woken up before the lock bit is clear. We use
-	 * a copy of the skb pointer to ensure other threads can't change it
-	 * while we're notifying the stack.
-	 */
 	adapter->ptp_tx_skb = NULL;
-	clear_bit_unlock(__IGC_PTP_TX_IN_PROGRESS, &adapter->state);
 
 	/* Notify the stack and free the skb after we've unlocked */
 	skb_tstamp_tx(skb, &shhwtstamps);
@@ -693,24 +689,33 @@ static void igc_ptp_tx_hwtstamp(struct igc_adapter *adapter)
  * igc_ptp_tx_work
  * @work: pointer to work struct
  *
- * This work function polls the TSYNCTXCTL valid bit to determine when a
- * timestamp has been taken for the current stored skb.
+ * This work function checks the TSYNCTXCTL valid bit to determine when
+ * a timestamp has been taken for the current stored skb.
  */
 static void igc_ptp_tx_work(struct work_struct *work)
 {
 	struct igc_adapter *adapter = container_of(work, struct igc_adapter,
 						   ptp_tx_work);
 	struct igc_hw *hw = &adapter->hw;
+	unsigned long flags;
 	u32 tsynctxctl;
 
-	if (!test_bit(__IGC_PTP_TX_IN_PROGRESS, &adapter->state))
-		return;
+	spin_lock_irqsave(&adapter->ptp_tx_lock, flags);
+
+	if (!adapter->ptp_tx_skb)
+		goto unlock;
 
 	tsynctxctl = rd32(IGC_TSYNCTXCTL);
-	if (WARN_ON_ONCE(!(tsynctxctl & IGC_TSYNCTXCTL_TXTT_0)))
-		return;
+	tsynctxctl &= IGC_TSYNCTXCTL_TXTT_0;
+	if (!tsynctxctl) {
+		WARN_ONCE(1, "Received a TSTAMP interrupt but no TSTAMP is ready.\n");
+		goto unlock;
+	}
 
 	igc_ptp_tx_hwtstamp(adapter);
+
+unlock:
+	spin_unlock_irqrestore(&adapter->ptp_tx_lock, flags);
 }
 
 /**
@@ -959,6 +964,7 @@ void igc_ptp_init(struct igc_adapter *adapter)
 		return;
 	}
 
+	spin_lock_init(&adapter->ptp_tx_lock);
 	spin_lock_init(&adapter->tmreg_lock);
 	INIT_WORK(&adapter->ptp_tx_work, igc_ptp_tx_work);
 
@@ -1023,7 +1029,6 @@ void igc_ptp_suspend(struct igc_adapter *adapter)
 	cancel_work_sync(&adapter->ptp_tx_work);
 	dev_kfree_skb_any(adapter->ptp_tx_skb);
 	adapter->ptp_tx_skb = NULL;
-	clear_bit_unlock(__IGC_PTP_TX_IN_PROGRESS, &adapter->state);
 
 	if (pci_device_is_present(adapter->pdev)) {
 		igc_ptp_time_save(adapter);
-- 
2.38.1


