Return-Path: <netdev+bounces-19309-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1DA975A3C0
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 03:06:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D27641C208B5
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 01:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30526621;
	Thu, 20 Jul 2023 01:05:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4A4631
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 01:05:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C703BC433CB;
	Thu, 20 Jul 2023 01:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689815108;
	bh=j8N9VX9HLxrV+w0wWbqFPi0iFjyeRLuEfwNbiLrnA6w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JBQZ04pyEJ0qJpYCbCyX0+RBrcournn82xjLS7ZaG5juCNfgyBogyMDQt1/7wSxCo
	 cYhGkrYNFErAxNa5HiHcC5rFX7yHR+diX30Z36hwHbospD+ZTlDgwHr+x1RK1mDbUy
	 NOY7lQMBvrI3Ey3hVmexI0nVKtC1RqL9wqDtMj7qqBAELMafDCm8UuwPWFjxTyz6bV
	 vAeGvN4tOodw3LQ4bPH4Zk6p7v7m/DTjj788nrYg43As/QlPktdWFIYiuKioF0j1IZ
	 O1EyUp6F6ZaxRwPnq68qFZGmqEINmDY0ybGKADCWQmcWTGaQaixPnX7i1ySuR4SsNb
	 SkqmtpiGPCXWw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	michael.chan@broadcom.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 2/3] eth: bnxt: take the bit to set as argument of bnxt_queue_sp_work()
Date: Wed, 19 Jul 2023 18:04:39 -0700
Message-ID: <20230720010440.1967136-3-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230720010440.1967136-1-kuba@kernel.org>
References: <20230720010440.1967136-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Most callers of bnxt_queue_sp_work() set a bit to indicate what work
to perform right before calling it. Pass it to the function instead.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 61 ++++++++++-------------
 1 file changed, 26 insertions(+), 35 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 417554a4c837..7b545d2a98b4 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -304,7 +304,7 @@ static void bnxt_queue_fw_reset_work(struct bnxt *bp, unsigned long delay)
 		schedule_delayed_work(&bp->fw_reset_task, delay);
 }
 
-static void bnxt_queue_sp_work(struct bnxt *bp)
+static void __bnxt_queue_sp_work(struct bnxt *bp)
 {
 	if (BNXT_PF(bp))
 		queue_work(bnxt_pf_wq, &bp->sp_task);
@@ -312,6 +312,12 @@ static void bnxt_queue_sp_work(struct bnxt *bp)
 		schedule_work(&bp->sp_task);
 }
 
+static void bnxt_queue_sp_work(struct bnxt *bp, unsigned int event)
+{
+	set_bit(event, &bp->sp_event);
+	__bnxt_queue_sp_work(bp);
+}
+
 static void bnxt_sched_reset_rxr(struct bnxt *bp, struct bnxt_rx_ring_info *rxr)
 {
 	if (!rxr->bnapi->in_reset) {
@@ -320,7 +326,7 @@ static void bnxt_sched_reset_rxr(struct bnxt *bp, struct bnxt_rx_ring_info *rxr)
 			set_bit(BNXT_RESET_TASK_SP_EVENT, &bp->sp_event);
 		else
 			set_bit(BNXT_RST_RING_SP_EVENT, &bp->sp_event);
-		bnxt_queue_sp_work(bp);
+		__bnxt_queue_sp_work(bp);
 	}
 	rxr->rx_next_cons = 0xffff;
 }
@@ -2384,7 +2390,7 @@ static int bnxt_async_event_process(struct bnxt *bp,
 	default:
 		goto async_event_process_exit;
 	}
-	bnxt_queue_sp_work(bp);
+	__bnxt_queue_sp_work(bp);
 async_event_process_exit:
 	return 0;
 }
@@ -2413,8 +2419,7 @@ static int bnxt_hwrm_handler(struct bnxt *bp, struct tx_cmp *txcmp)
 		}
 
 		set_bit(vf_id - bp->pf.first_vf_id, bp->pf.vf_event_bmap);
-		set_bit(BNXT_HWRM_EXEC_FWD_REQ_SP_EVENT, &bp->sp_event);
-		bnxt_queue_sp_work(bp);
+		bnxt_queue_sp_work(bp, BNXT_HWRM_EXEC_FWD_REQ_SP_EVENT);
 		break;
 
 	case CMPL_BASE_TYPE_HWRM_ASYNC_EVENT:
@@ -11031,8 +11036,7 @@ static void bnxt_set_rx_mode(struct net_device *dev)
 	if (mask != vnic->rx_mask || uc_update || mc_update) {
 		vnic->rx_mask = mask;
 
-		set_bit(BNXT_RX_MASK_SP_EVENT, &bp->sp_event);
-		bnxt_queue_sp_work(bp);
+		bnxt_queue_sp_work(bp, BNXT_RX_MASK_SP_EVENT);
 	}
 }
 
@@ -11597,8 +11601,7 @@ static void bnxt_tx_timeout(struct net_device *dev, unsigned int txqueue)
 	struct bnxt *bp = netdev_priv(dev);
 
 	netdev_err(bp->dev,  "TX timeout detected, starting reset task!\n");
-	set_bit(BNXT_RESET_TASK_SP_EVENT, &bp->sp_event);
-	bnxt_queue_sp_work(bp);
+	bnxt_queue_sp_work(bp, BNXT_RESET_TASK_SP_EVENT);
 }
 
 static void bnxt_fw_health_check(struct bnxt *bp)
@@ -11635,8 +11638,7 @@ static void bnxt_fw_health_check(struct bnxt *bp)
 	return;
 
 fw_reset:
-	set_bit(BNXT_FW_EXCEPTION_SP_EVENT, &bp->sp_event);
-	bnxt_queue_sp_work(bp);
+	bnxt_queue_sp_work(bp, BNXT_FW_EXCEPTION_SP_EVENT);
 }
 
 static void bnxt_timer(struct timer_list *t)
@@ -11653,21 +11655,15 @@ static void bnxt_timer(struct timer_list *t)
 	if (bp->fw_cap & BNXT_FW_CAP_ERROR_RECOVERY)
 		bnxt_fw_health_check(bp);
 
-	if (BNXT_LINK_IS_UP(bp) && bp->stats_coal_ticks) {
-		set_bit(BNXT_PERIODIC_STATS_SP_EVENT, &bp->sp_event);
-		bnxt_queue_sp_work(bp);
-	}
+	if (BNXT_LINK_IS_UP(bp) && bp->stats_coal_ticks)
+		bnxt_queue_sp_work(bp, BNXT_PERIODIC_STATS_SP_EVENT);
 
-	if (bnxt_tc_flower_enabled(bp)) {
-		set_bit(BNXT_FLOW_STATS_SP_EVENT, &bp->sp_event);
-		bnxt_queue_sp_work(bp);
-	}
+	if (bnxt_tc_flower_enabled(bp))
+		bnxt_queue_sp_work(bp, BNXT_FLOW_STATS_SP_EVENT);
 
 #ifdef CONFIG_RFS_ACCEL
-	if ((bp->flags & BNXT_FLAG_RFS) && bp->ntp_fltr_count) {
-		set_bit(BNXT_RX_NTP_FLTR_SP_EVENT, &bp->sp_event);
-		bnxt_queue_sp_work(bp);
-	}
+	if ((bp->flags & BNXT_FLAG_RFS) && bp->ntp_fltr_count)
+		bnxt_queue_sp_work(bp, BNXT_RX_NTP_FLTR_SP_EVENT);
 #endif /*CONFIG_RFS_ACCEL*/
 
 	if (bp->link_info.phy_retry) {
@@ -11675,21 +11671,17 @@ static void bnxt_timer(struct timer_list *t)
 			bp->link_info.phy_retry = false;
 			netdev_warn(bp->dev, "failed to update phy settings after maximum retries.\n");
 		} else {
-			set_bit(BNXT_UPDATE_PHY_SP_EVENT, &bp->sp_event);
-			bnxt_queue_sp_work(bp);
+			bnxt_queue_sp_work(bp, BNXT_UPDATE_PHY_SP_EVENT);
 		}
 	}
 
-	if (test_bit(BNXT_STATE_L2_FILTER_RETRY, &bp->state)) {
-		set_bit(BNXT_RX_MASK_SP_EVENT, &bp->sp_event);
-		bnxt_queue_sp_work(bp);
-	}
+	if (test_bit(BNXT_STATE_L2_FILTER_RETRY, &bp->state))
+		bnxt_queue_sp_work(bp, BNXT_RX_MASK_SP_EVENT);
 
 	if ((bp->flags & BNXT_FLAG_CHIP_P5) && !bp->chip_rev &&
-	    netif_carrier_ok(dev)) {
-		set_bit(BNXT_RING_COAL_NOW_SP_EVENT, &bp->sp_event);
-		bnxt_queue_sp_work(bp);
-	}
+	    netif_carrier_ok(dev))
+		bnxt_queue_sp_work(bp, BNXT_RING_COAL_NOW_SP_EVENT);
+
 bnxt_restart_timer:
 	mod_timer(&bp->timer, jiffies + bp->current_interval);
 }
@@ -12968,8 +12960,7 @@ static int bnxt_rx_flow_steer(struct net_device *dev, const struct sk_buff *skb,
 	bp->ntp_fltr_count++;
 	spin_unlock_bh(&bp->ntp_fltr_lock);
 
-	set_bit(BNXT_RX_NTP_FLTR_SP_EVENT, &bp->sp_event);
-	bnxt_queue_sp_work(bp);
+	bnxt_queue_sp_work(bp, BNXT_RX_NTP_FLTR_SP_EVENT);
 
 	return new_fltr->sw_id;
 
-- 
2.41.0


