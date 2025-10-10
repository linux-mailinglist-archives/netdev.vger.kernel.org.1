Return-Path: <netdev+bounces-228542-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B07FBCDC2B
	for <lists+netdev@lfdr.de>; Fri, 10 Oct 2025 17:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95FAD4084E9
	for <lists+netdev@lfdr.de>; Fri, 10 Oct 2025 15:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 085722F7ADC;
	Fri, 10 Oct 2025 15:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="stNCN4im"
X-Original-To: netdev@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCEF2F8BC4;
	Fri, 10 Oct 2025 15:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760109136; cv=none; b=pRDUPIudt/km68XbXCXxDUvZ7e71sWDBHy8R+9F9qh/c5m6A+a/WJYjuAiE/dV7e3AgdjvoclNpzPPDsEmpsXZzY90NEJ6udLMYlCkF6jhP/lf1zk+pL5YEkIE/dJCN+ykPdW0/Cob7HPJZPg2q0OGSa8Iuf5AfOKhk830CI4G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760109136; c=relaxed/simple;
	bh=UWj2LSG9OR8fFHYaxWPSONArCEnqQWA+MByPC7l9Oec=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DBOxRhNTQydqE2BwGl+qCOYdbyRDb+8onuamhZA38sd74JsTzK6bwqh0uoEQvgMO9dPa/Imog+HTS1oosqS4fz/87mntVWzy6aF2Dk+oci0Xzycc8QThfJEJmSIBrJ69UAmElO0/0Imit6G5FeqeFTiSLiwIhnTnSM8jyuQFASA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=stNCN4im; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59AFBvvP341675;
	Fri, 10 Oct 2025 10:11:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1760109117;
	bh=Z2J0NEK3lvDAZRDVx98UECEwl66Tg5VwoX+Yt/KcKk8=;
	h=From:To:CC:Subject:Date;
	b=stNCN4imhmJhMq+9+zy9hkX1j6/yWQFNLcWz1VTJE3SfTm519EJRsHcizhiTA1cxc
	 U1w3DL4P/8oD6IA8AlmcrWVHObcW08ZYW4gSHbEOyJ6Vdpg3/hG9Ak9jyMNAnBJqVc
	 BDNoKYlmE8KsEvH3p1yYsirorReYvFXpZ9RwJZrE=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59AFBvFj1136866
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Fri, 10 Oct 2025 10:11:57 -0500
Received: from DLEE209.ent.ti.com (157.170.170.98) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 10
 Oct 2025 10:11:57 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 10 Oct 2025 10:11:57 -0500
Received: from a0507033-hp.dhcp.ti.com (a0507033-hp.dhcp.ti.com [172.24.231.225])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59AFBrGr2062686;
	Fri, 10 Oct 2025 10:11:53 -0500
From: Aksh Garg <a-garg7@ti.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <edumazet@google.com>
CC: <linux-kernel@vger.kernel.org>, <c-vankar@ti.com>, <s-vadapalli@ti.com>,
        <danishanwar@ti.com>, Aksh Garg <a-garg7@ti.com>
Subject: [PATCH net] net: ethernet: ti: am65-cpts: fix timestamp loss due to race conditions
Date: Fri, 10 Oct 2025 20:38:21 +0530
Message-ID: <20251010150821.838902-1-a-garg7@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Resolve race conditions in timestamp events list handling between TX
and RX paths causing missed timestamps.

The current implementation uses a single events list for both TX and RX
timestamps. The am65_cpts_find_ts() function acquires the lock,
splices all events (TX as well as RX events) to a temporary list,
and releases the lock. This function performs matching of timestamps
for TX packets only. Before it acquires the lock again to put the
non-TX events back to the main events list, a concurrent RX
processing thread could acquire the lock, find an empty events list,
and fail to attach timestamp to it, even though a relevant event exists
in the spliced list which is yet to be restored to the main list.

Fix this by splitting the events list to handle TX and RX timestamps
independently.

Fixes: c459f606f66df ("net: ethernet: ti: am65-cpts: Enable RX HW timestamp for PTP packets using CPTS FIFO")
Signed-off-by: Aksh Garg <a-garg7@ti.com>
---
 drivers/net/ethernet/ti/am65-cpts.c | 57 +++++++++++++++++++++++------
 1 file changed, 46 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/ti/am65-cpts.c b/drivers/net/ethernet/ti/am65-cpts.c
index 59d6ab989c55..2e9719264ba5 100644
--- a/drivers/net/ethernet/ti/am65-cpts.c
+++ b/drivers/net/ethernet/ti/am65-cpts.c
@@ -163,7 +163,9 @@ struct am65_cpts {
 	struct device_node *clk_mux_np;
 	struct clk *refclk;
 	u32 refclk_freq;
-	struct list_head events;
+	/* separate lists to handle TX and RX timestamp independently */
+	struct list_head events_tx;
+	struct list_head events_rx;
 	struct list_head pool;
 	struct am65_cpts_event pool_data[AM65_CPTS_MAX_EVENTS];
 	spinlock_t lock; /* protects events lists*/
@@ -172,6 +174,7 @@ struct am65_cpts {
 	u32 ts_add_val;
 	int irq;
 	struct mutex ptp_clk_lock; /* PHC access sync */
+	struct mutex rx_ts_lock; /* serialize RX timestamp match */
 	u64 timestamp;
 	u32 genf_enable;
 	u32 hw_ts_enable;
@@ -245,7 +248,16 @@ static int am65_cpts_cpts_purge_events(struct am65_cpts *cpts)
 	struct am65_cpts_event *event;
 	int removed = 0;
 
-	list_for_each_safe(this, next, &cpts->events) {
+	list_for_each_safe(this, next, &cpts->events_tx) {
+		event = list_entry(this, struct am65_cpts_event, list);
+		if (time_after(jiffies, event->tmo)) {
+			list_del_init(&event->list);
+			list_add(&event->list, &cpts->pool);
+			++removed;
+		}
+	}
+
+	list_for_each_safe(this, next, &cpts->events_rx) {
 		event = list_entry(this, struct am65_cpts_event, list);
 		if (time_after(jiffies, event->tmo)) {
 			list_del_init(&event->list);
@@ -306,11 +318,21 @@ static int __am65_cpts_fifo_read(struct am65_cpts *cpts)
 				cpts->timestamp);
 			break;
 		case AM65_CPTS_EV_RX:
+			event->tmo = jiffies +
+				msecs_to_jiffies(AM65_CPTS_EVENT_RX_TX_TIMEOUT);
+
+			list_move_tail(&event->list, &cpts->events_rx);
+
+			dev_dbg(cpts->dev,
+				"AM65_CPTS_EV_RX e1:%08x e2:%08x t:%lld\n",
+				event->event1, event->event2,
+				event->timestamp);
+			break;
 		case AM65_CPTS_EV_TX:
 			event->tmo = jiffies +
 				msecs_to_jiffies(AM65_CPTS_EVENT_RX_TX_TIMEOUT);
 
-			list_move_tail(&event->list, &cpts->events);
+			list_move_tail(&event->list, &cpts->events_tx);
 
 			dev_dbg(cpts->dev,
 				"AM65_CPTS_EV_TX e1:%08x e2:%08x t:%lld\n",
@@ -828,7 +850,7 @@ static bool am65_cpts_match_tx_ts(struct am65_cpts *cpts,
 	return found;
 }
 
-static void am65_cpts_find_ts(struct am65_cpts *cpts)
+static void am65_cpts_find_tx_ts(struct am65_cpts *cpts)
 {
 	struct am65_cpts_event *event;
 	struct list_head *this, *next;
@@ -837,7 +859,7 @@ static void am65_cpts_find_ts(struct am65_cpts *cpts)
 	LIST_HEAD(events);
 
 	spin_lock_irqsave(&cpts->lock, flags);
-	list_splice_init(&cpts->events, &events);
+	list_splice_init(&cpts->events_tx, &events);
 	spin_unlock_irqrestore(&cpts->lock, flags);
 
 	list_for_each_safe(this, next, &events) {
@@ -850,7 +872,7 @@ static void am65_cpts_find_ts(struct am65_cpts *cpts)
 	}
 
 	spin_lock_irqsave(&cpts->lock, flags);
-	list_splice_tail(&events, &cpts->events);
+	list_splice_tail(&events, &cpts->events_tx);
 	list_splice_tail(&events_free, &cpts->pool);
 	spin_unlock_irqrestore(&cpts->lock, flags);
 }
@@ -861,7 +883,7 @@ static long am65_cpts_ts_work(struct ptp_clock_info *ptp)
 	unsigned long flags;
 	long delay = -1;
 
-	am65_cpts_find_ts(cpts);
+	am65_cpts_find_tx_ts(cpts);
 
 	spin_lock_irqsave(&cpts->txq.lock, flags);
 	if (!skb_queue_empty(&cpts->txq))
@@ -899,16 +921,21 @@ static u64 am65_cpts_find_rx_ts(struct am65_cpts *cpts, u32 skb_mtype_seqid)
 {
 	struct list_head *this, *next;
 	struct am65_cpts_event *event;
+	LIST_HEAD(events_free);
 	unsigned long flags;
+	LIST_HEAD(events);
 	u32 mtype_seqid;
 	u64 ns = 0;
 
 	spin_lock_irqsave(&cpts->lock, flags);
 	__am65_cpts_fifo_read(cpts);
-	list_for_each_safe(this, next, &cpts->events) {
+	list_splice_init(&cpts->events_rx, &events);
+	spin_unlock_irqrestore(&cpts->lock, flags);
+
+	list_for_each_safe(this, next, &events) {
 		event = list_entry(this, struct am65_cpts_event, list);
 		if (time_after(jiffies, event->tmo)) {
-			list_move(&event->list, &cpts->pool);
+			list_move(&event->list, &events_free);
 			continue;
 		}
 
@@ -919,10 +946,14 @@ static u64 am65_cpts_find_rx_ts(struct am65_cpts *cpts, u32 skb_mtype_seqid)
 
 		if (mtype_seqid == skb_mtype_seqid) {
 			ns = event->timestamp;
-			list_move(&event->list, &cpts->pool);
+			list_move(&event->list, &events_free);
 			break;
 		}
 	}
+
+	spin_lock_irqsave(&cpts->lock, flags);
+	list_splice_tail(&events, &cpts->events_rx);
+	list_splice_tail(&events_free, &cpts->pool);
 	spin_unlock_irqrestore(&cpts->lock, flags);
 
 	return ns;
@@ -948,7 +979,9 @@ void am65_cpts_rx_timestamp(struct am65_cpts *cpts, struct sk_buff *skb)
 
 	dev_dbg(cpts->dev, "%s mtype seqid %08x\n", __func__, skb_cb->skb_mtype_seqid);
 
+	mutex_lock(&cpts->rx_ts_lock);
 	ns = am65_cpts_find_rx_ts(cpts, skb_cb->skb_mtype_seqid);
+	mutex_unlock(&cpts->rx_ts_lock);
 	if (!ns)
 		return;
 
@@ -1155,7 +1188,9 @@ struct am65_cpts *am65_cpts_create(struct device *dev, void __iomem *regs,
 		return ERR_PTR(ret);
 
 	mutex_init(&cpts->ptp_clk_lock);
-	INIT_LIST_HEAD(&cpts->events);
+	mutex_init(&cpts->rx_ts_lock);
+	INIT_LIST_HEAD(&cpts->events_tx);
+	INIT_LIST_HEAD(&cpts->events_rx);
 	INIT_LIST_HEAD(&cpts->pool);
 	spin_lock_init(&cpts->lock);
 	skb_queue_head_init(&cpts->txq);
-- 
2.34.1


