Return-Path: <netdev+bounces-230047-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 374AEBE3350
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 13:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D5841A63B75
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 11:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A10F3203BB;
	Thu, 16 Oct 2025 11:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="JpG5GbkM"
X-Original-To: netdev@vger.kernel.org
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74D331D72B;
	Thu, 16 Oct 2025 11:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760615915; cv=none; b=nP4KCXMAp6STg/0AwxYrDrGEQxphaTUW7/nkO/Xpxnkgb7eoXTsRGN4ylrVYPsw0Qky8lIMexYMPL/7A6WY0LP4D0lQewjxcssy8kHHufJOZ8zvwlOvt/6Hf4eozYtNqHPyfsLVGTt6J2w/wdNBUx1zsuF6YtVDZH4O8BWqNc4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760615915; c=relaxed/simple;
	bh=DuW8w7k/kNUsz/qxspANJF3eYHBuS7xZa52I2Nf8Imw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qvFVI2+wnSwZBulb8sWDLFLUmyItzFl7A+vzJMQpLUb4txbFBAdVuP1nWh99PxJMpyIAmpyvk/VSXpLyf7+JehgJWK8/pKi6sVF+bfEb5jzrajnr5gFCnQk5znZdSnn0GYKzlTFa/+Do7m+QZHZtKqdH+uQ5n8KP0H3B7Voi60E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=JpG5GbkM; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59GBw9Sx2096123;
	Thu, 16 Oct 2025 06:58:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1760615889;
	bh=oYiIQfJSMnvcu1gvYLs6ctehN3GwYeqCZVi/RcPmH7Y=;
	h=From:To:CC:Subject:Date;
	b=JpG5GbkMstuW5m/J5a773+CLZmyxOcoK53INy2RqaB5LY6ksXqf7a+X4iuG+G18Rw
	 uMZCyFCDorz+lRhDXCEMMNJJ0z7/mZEpivVrjyAvCVzjXizO5Mldlqp52RHA68rTfo
	 LXkuE/jsDLQIH4G6liGvlu/Bign2O1xVSoPu+78E=
Received: from DFLE203.ent.ti.com (dfle203.ent.ti.com [10.64.6.61])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59GBw8I81589584
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 16 Oct 2025 06:58:09 -0500
Received: from DFLE215.ent.ti.com (10.64.6.73) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 16 Oct
 2025 06:58:08 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 16 Oct 2025 06:58:08 -0500
Received: from a0507033-hp.dhcp.ti.com (a0507033-hp.dhcp.ti.com [172.24.231.225])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59GBw4cQ3684544;
	Thu, 16 Oct 2025 06:58:05 -0500
From: Aksh Garg <a-garg7@ti.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <edumazet@google.com>
CC: <linux-kernel@vger.kernel.org>, <c-vankar@ti.com>, <s-vadapalli@ti.com>,
        <danishanwar@ti.com>, Aksh Garg <a-garg7@ti.com>
Subject: [PATCH net v2] net: ethernet: ti: am65-cpts: fix timestamp loss due to race conditions
Date: Thu, 16 Oct 2025 17:27:55 +0530
Message-ID: <20251016115755.1123646-1-a-garg7@ti.com>
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
processing thread could acquire the lock (as observed in practice),
find an empty events list, and fail to attach timestamp to it, 
even though a relevant event exists in the spliced list which is yet to
be restored to the main list.

Fix this by creating separate events lists to handle TX and RX
timestamps independently.

Fixes: c459f606f66df ("net: ethernet: ti: am65-cpts: Enable RX HW timestamp for PTP packets using CPTS FIFO")
Signed-off-by: Aksh Garg <a-garg7@ti.com>
---

Link to v1:
https://lore.kernel.org/all/20251010150821.838902-1-a-garg7@ti.com/

Changes from v1 to v2:
- Created a helper function am65_cpts_purge_event_list() to avoid
  code duplication
- Removed RX timestamp lookup optimization from am65_cpts_find_rx_ts(), 
  which will be handled in a separate patch series
- Fixed function name: am65_cpts_cpts_purge_events() to 
  am65_cpts_purge_events()
  
 drivers/net/ethernet/ti/am65-cpts.c | 63 ++++++++++++++++++++---------
 1 file changed, 43 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/ti/am65-cpts.c b/drivers/net/ethernet/ti/am65-cpts.c
index 59d6ab989c55..8ffbfaa3ab18 100644
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
@@ -227,6 +229,24 @@ static void am65_cpts_disable(struct am65_cpts *cpts)
 	am65_cpts_write32(cpts, 0, int_enable);
 }
 
+static int am65_cpts_purge_event_list(struct am65_cpts *cpts,
+				      struct list_head *events)
+{
+	struct list_head *this, *next;
+	struct am65_cpts_event *event;
+	int removed = 0;
+
+	list_for_each_safe(this, next, events) {
+		event = list_entry(this, struct am65_cpts_event, list);
+		if (time_after(jiffies, event->tmo)) {
+			list_del_init(&event->list);
+			list_add(&event->list, &cpts->pool);
+			++removed;
+		}
+	}
+	return removed;
+}
+
 static int am65_cpts_event_get_port(struct am65_cpts_event *event)
 {
 	return (event->event1 & AM65_CPTS_EVENT_1_PORT_NUMBER_MASK) >>
@@ -239,20 +259,12 @@ static int am65_cpts_event_get_type(struct am65_cpts_event *event)
 		AM65_CPTS_EVENT_1_EVENT_TYPE_SHIFT;
 }
 
-static int am65_cpts_cpts_purge_events(struct am65_cpts *cpts)
+static int am65_cpts_purge_events(struct am65_cpts *cpts)
 {
-	struct list_head *this, *next;
-	struct am65_cpts_event *event;
 	int removed = 0;
 
-	list_for_each_safe(this, next, &cpts->events) {
-		event = list_entry(this, struct am65_cpts_event, list);
-		if (time_after(jiffies, event->tmo)) {
-			list_del_init(&event->list);
-			list_add(&event->list, &cpts->pool);
-			++removed;
-		}
-	}
+	removed += am65_cpts_purge_event_list(cpts, &cpts->events_tx);
+	removed += am65_cpts_purge_event_list(cpts, &cpts->events_rx);
 
 	if (removed)
 		dev_dbg(cpts->dev, "event pool cleaned up %d\n", removed);
@@ -287,7 +299,7 @@ static int __am65_cpts_fifo_read(struct am65_cpts *cpts)
 						 struct am65_cpts_event, list);
 
 		if (!event) {
-			if (am65_cpts_cpts_purge_events(cpts)) {
+			if (am65_cpts_purge_events(cpts)) {
 				dev_err(cpts->dev, "cpts: event pool empty\n");
 				ret = -1;
 				goto out;
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
@@ -905,7 +927,7 @@ static u64 am65_cpts_find_rx_ts(struct am65_cpts *cpts, u32 skb_mtype_seqid)
 
 	spin_lock_irqsave(&cpts->lock, flags);
 	__am65_cpts_fifo_read(cpts);
-	list_for_each_safe(this, next, &cpts->events) {
+	list_for_each_safe(this, next, &cpts->events_rx) {
 		event = list_entry(this, struct am65_cpts_event, list);
 		if (time_after(jiffies, event->tmo)) {
 			list_move(&event->list, &cpts->pool);
@@ -1155,7 +1177,8 @@ struct am65_cpts *am65_cpts_create(struct device *dev, void __iomem *regs,
 		return ERR_PTR(ret);
 
 	mutex_init(&cpts->ptp_clk_lock);
-	INIT_LIST_HEAD(&cpts->events);
+	INIT_LIST_HEAD(&cpts->events_tx);
+	INIT_LIST_HEAD(&cpts->events_rx);
 	INIT_LIST_HEAD(&cpts->pool);
 	spin_lock_init(&cpts->lock);
 	skb_queue_head_init(&cpts->txq);
-- 
2.34.1


