Return-Path: <netdev+bounces-13136-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A9873A6CE
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 18:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00B081C2115C
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 16:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FF4F200D7;
	Thu, 22 Jun 2023 16:58:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4378F200AC
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 16:58:06 +0000 (UTC)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3502910DB
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 09:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687453078; x=1718989078;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OW85Tu60Mfv4Bh5lA/AaJu2Lqy7bX6iIuhP0sDHRRIQ=;
  b=eEqSOtIY1zdIpZdvSZsZ1JPrF8Ce0Xs8fb4t/teLrWa01NQLJBNSXLbm
   gtNBen9aLwd2H4SMJTJcuPvgMTrtiCUCtx0HkMfPHBZ9QC5f17ACj6m0F
   9qo+g/TJ/FncmyRKOfwwhjKPp58gJspGlSOOzh1ynQVAOLSxsA3qQVWQz
   iGuH50rcGhX2kfFOMhRz+Y1TGssqbiTC8zU/k/nsPFQSq5YDLIUIdz0jh
   VOAus30tLa45CcLTgs6OulNnAm/KsoiW7JyyuyElQbVjI/1FrHLofUPQV
   Jb+DasQn9xbjLkuIDHnghi7wrgJld3hNIkkjhX2MyKz0NnYkMf+VqyCYT
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="340887280"
X-IronPort-AV: E=Sophos;i="6.01,149,1684825200"; 
   d="scan'208";a="340887280"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 09:57:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="692358333"
X-IronPort-AV: E=Sophos;i="6.01,149,1684825200"; 
   d="scan'208";a="692358333"
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
	Naama Meir <naamax.meir@linux.intel.com>
Subject: [PATCH net v2 4/4] igc: Work around HW bug causing missing timestamps
Date: Thu, 22 Jun 2023 09:52:44 -0700
Message-Id: <20230622165244.2202786-5-anthony.l.nguyen@intel.com>
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

There's an hardware issue that can cause missing timestamps. The bug
is that the interrupt is only cleared if the IGC_TXSTMPH_0 register is
read.

The bug can cause a race condition if a timestamp is captured at the
wrong time, and we will miss that timestamp. To reduce the time window
that the problem is able to happen, in case no timestamp was ready, we
read the "previous" value of the timestamp registers, and we compare
with the "current" one, if it didn't change we can be reasonably sure
that no timestamp was captured. If they are different, we use the new
value as the captured timestamp.

The HW bug is not easy to reproduce, got to reproduce it when smashing
the NIC with timestamping requests from multiple applications (e.g.
multiple ntpperf instances + ptp4l), after 10s of minutes.

This workaround has more impact when multiple timestamp registers are
used, and the IGC_TXSTMPH_0 register always need to be read, so the
interrupt is cleared.

Fixes: 2c344ae24501 ("igc: Add support for TX timestamping")
Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Tested-by: Naama Meir <naamax.meir@linux.intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_ptp.c | 48 ++++++++++++++++++------
 1 file changed, 37 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_ptp.c b/drivers/net/ethernet/intel/igc/igc_ptp.c
index cf963a12a92f..32ef112f8291 100644
--- a/drivers/net/ethernet/intel/igc/igc_ptp.c
+++ b/drivers/net/ethernet/intel/igc/igc_ptp.c
@@ -685,14 +685,49 @@ static void igc_ptp_tx_hwtstamp(struct igc_adapter *adapter)
 	struct sk_buff *skb = adapter->ptp_tx_skb;
 	struct skb_shared_hwtstamps shhwtstamps;
 	struct igc_hw *hw = &adapter->hw;
+	u32 tsynctxctl;
 	int adjust = 0;
 	u64 regval;
 
 	if (WARN_ON_ONCE(!skb))
 		return;
 
-	regval = rd32(IGC_TXSTMPL);
-	regval |= (u64)rd32(IGC_TXSTMPH) << 32;
+	tsynctxctl = rd32(IGC_TSYNCTXCTL);
+	tsynctxctl &= IGC_TSYNCTXCTL_TXTT_0;
+	if (tsynctxctl) {
+		regval = rd32(IGC_TXSTMPL);
+		regval |= (u64)rd32(IGC_TXSTMPH) << 32;
+	} else {
+		/* There's a bug in the hardware that could cause
+		 * missing interrupts for TX timestamping. The issue
+		 * is that for new interrupts to be triggered, the
+		 * IGC_TXSTMPH_0 register must be read.
+		 *
+		 * To avoid discarding a valid timestamp that just
+		 * happened at the "wrong" time, we need to confirm
+		 * that there was no timestamp captured, we do that by
+		 * assuming that no two timestamps in sequence have
+		 * the same nanosecond value.
+		 *
+		 * So, we read the "low" register, read the "high"
+		 * register (to latch a new timestamp) and read the
+		 * "low" register again, if "old" and "new" versions
+		 * of the "low" register are different, a valid
+		 * timestamp was captured, we can read the "high"
+		 * register again.
+		 */
+		u32 txstmpl_old, txstmpl_new;
+
+		txstmpl_old = rd32(IGC_TXSTMPL);
+		rd32(IGC_TXSTMPH);
+		txstmpl_new = rd32(IGC_TXSTMPL);
+
+		if (txstmpl_old == txstmpl_new)
+			return;
+
+		regval = txstmpl_new;
+		regval |= (u64)rd32(IGC_TXSTMPH) << 32;
+	}
 	if (igc_ptp_systim_to_hwtstamp(adapter, &shhwtstamps, regval))
 		return;
 
@@ -730,22 +765,13 @@ static void igc_ptp_tx_hwtstamp(struct igc_adapter *adapter)
  */
 void igc_ptp_tx_tstamp_event(struct igc_adapter *adapter)
 {
-	struct igc_hw *hw = &adapter->hw;
 	unsigned long flags;
-	u32 tsynctxctl;
 
 	spin_lock_irqsave(&adapter->ptp_tx_lock, flags);
 
 	if (!adapter->ptp_tx_skb)
 		goto unlock;
 
-	tsynctxctl = rd32(IGC_TSYNCTXCTL);
-	tsynctxctl &= IGC_TSYNCTXCTL_TXTT_0;
-	if (!tsynctxctl) {
-		WARN_ONCE(1, "Received a TSTAMP interrupt but no TSTAMP is ready.\n");
-		goto unlock;
-	}
-
 	igc_ptp_tx_hwtstamp(adapter);
 
 unlock:
-- 
2.38.1


