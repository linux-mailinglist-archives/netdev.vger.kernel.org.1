Return-Path: <netdev+bounces-231141-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9B8BF5A75
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 11:55:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08EF21883C43
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 09:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3756D2D5C97;
	Tue, 21 Oct 2025 09:55:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892C21DED4C
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 09:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761040516; cv=none; b=BoBLT4SO9EdLRSdZ8WZvfknSFO+O+ClZY7Y3VL4DmH+O4soWJfrASiW/xCj/JdvyuMokP9WFoUcRD8oB41+hkfe6YV9QHGJwmTQca5oLMn0gMg0VXOOqm5AlVs4P/kMtDh3M9l9BZBpAYjJ17ZMCkSUdB2HN83kWyS7PjbS5TS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761040516; c=relaxed/simple;
	bh=kocGB7v2cvblvznO/e05vjQjJOYKCGasKn9a9iHXLSw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Q2cl8Kk+04ZPRJBJ7OqsFCuaNKlQWLSIO590cQ3PpwPtBbjLGBf7exUnS4XZwEwBg9n9prMI5cePNXnOz0HBs8Z/rNzjTrDzsCJZ70bcVP4u/fqscZhmtRLNQTlvTzyV08YBdmofr6TX11/YforYsiIJX4aW6Zi6w1ag7EbwfqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=none smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bamaicloud.com
X-QQ-mid: esmtpgz10t1761040430t568f1b3b
X-QQ-Originating-IP: dOXkMTjlpCBTxKFM+Rf37EHkXm80imBLEYQWq8FF9aE=
Received: from localhost.localdomain ( [111.204.182.100])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 21 Oct 2025 17:53:48 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4410683970554246087
EX-QQ-RecipientCnt: 10
From: Tonghao Zhang <tonghao@bamaicloud.com>
To: netdev@vger.kernel.org
Cc: Tonghao Zhang <tonghao@bamaicloud.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next] net: sched: readjust the execution conditions for dev_watchdog()
Date: Tue, 21 Oct 2025 17:53:36 +0800
Message-Id: <20251021095336.65626-1-tonghao@bamaicloud.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:bamaicloud.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: OE2SNMSfMbmOQXlpAZNky8M49xAORnlNr8Y6GYhynEcQBjoz7RG1NYfb
	lWz7a/ejSZPYt3bYp3vOlyI+vYhzKIkTXS7I6nHh+lQMTkwhX81pYRB6xfT1uz9mDx+hlVy
	YZ7K5helQxq2lCJ7zHMXQMlL7BKxwJ4TJJ6v7mSzq1mBIujgVAxXeiMtGjmzRaFVMM00VrH
	ogEce6dIvD82rpSBVpAh8C02vzI0Lu4J9Tohp+a52huvkNKLUF5vg5mQ04840EylQDZ9tYb
	16+Mcnr/++ydGFB0XwPlymlS4tOBL+bxd32YEpJ5CIO6/t9pxHRFlM2PrMJ+CADh3Kaaup3
	QbMxVgGg6HaAvevKx9pFhAiKdjWIf+pl0jBaBQs2/uov5WKAdDezF8d/TQvzBQHSMkINux7
	dLlvxlJhqS+9841NM2XcSQANsFMokHjOWRX2ZhEB3hGsNUyY9X8Adn/iM6K6VIJjgxz1/7f
	k8+BtcBn05xl05qk1NPtWyNG1rNHZGEgwyt8I2gROYUiCUNrWRnHjFtp5YZYxFwv7NFa9iH
	WnRX1hMgFvs0HHtzovOMq2zSJe07al9okWr/+29IyC1ZuWQ4ZmZgbuZmhMhJ0xyrEx7Zbuq
	hSuNxy9KUFILGtqkNYjbffbSbvzJGH8E1Vzkw/VEOR3zBq2XZ/LqU96mOJ2y5LjhsyM4UG3
	7AfL+koWfAZroPf731LmZHO4fDGxeSpF37dMRTpskPGmG7vLIzBCNeq2/uCBOp4CZwZooQz
	YMqWCin5fx597T3js2zmIutce9easn0g7cYoi5FXlE71+ir13hryOBpMvXtJIDqylr3Tfv6
	kQ7otHwwOChjFagHu6ECz1Fx/TVB0cT5p3QEDiA8OT9XC4ULZhCOZZX4+BxbqwRUGZGwoyu
	UIHoQMVe6xS7OrgRboX7pRcBXNH9aylDl3MFH3q1Vfhv5yzt+HdO+mhAwVqrKfvdSmzfOO8
	dwE3BVMpR6dsQezrX1wUYMw1HRp/6X+s1XhAaaFnSWV3Aei7dQJ/CyEDG4L2vZ8MSW/Q=
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0

readjust the execution conditions for dev_watchdog() and reduce
the tab indentation of the code.

Cc: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>
Cc: Jiri Pirko <jiri@resnulli.us>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>
Signed-off-by: Tonghao Zhang <tonghao@bamaicloud.com>
---
 net/sched/sch_generic.c | 82 ++++++++++++++++++++---------------------
 1 file changed, 40 insertions(+), 42 deletions(-)

diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
index 16afb834fe4a..1b905cc05520 100644
--- a/net/sched/sch_generic.c
+++ b/net/sched/sch_generic.c
@@ -500,51 +500,49 @@ static void dev_watchdog(struct timer_list *t)
 	bool release = true;
 
 	spin_lock(&dev->tx_global_lock);
-	if (!qdisc_tx_is_noop(dev)) {
-		if (netif_device_present(dev) &&
-		    netif_running(dev) &&
-		    netif_carrier_ok(dev)) {
-			unsigned int timedout_ms = 0;
-			unsigned int i;
-			unsigned long trans_start;
-			unsigned long oldest_start = jiffies;
-
-			for (i = 0; i < dev->num_tx_queues; i++) {
-				struct netdev_queue *txq;
-
-				txq = netdev_get_tx_queue(dev, i);
-				if (!netif_xmit_stopped(txq))
-					continue;
-
-				/* Paired with WRITE_ONCE() + smp_mb...() in
-				 * netdev_tx_sent_queue() and netif_tx_stop_queue().
-				 */
-				smp_mb();
-				trans_start = READ_ONCE(txq->trans_start);
-
-				if (time_after(jiffies, trans_start + dev->watchdog_timeo)) {
-					timedout_ms = jiffies_to_msecs(jiffies - trans_start);
-					atomic_long_inc(&txq->trans_timeout);
-					break;
-				}
-				if (time_after(oldest_start, trans_start))
-					oldest_start = trans_start;
-			}
+	if (!qdisc_tx_is_noop(dev) &&
+	    netif_device_present(dev) &&
+	    netif_running(dev) && netif_carrier_ok(dev)) {
+		unsigned int timedout_ms = 0;
+		unsigned int i;
+		unsigned long trans_start;
+		unsigned long oldest_start = jiffies;
+
+		for (i = 0; i < dev->num_tx_queues; i++) {
+			struct netdev_queue *txq;
+
+			txq = netdev_get_tx_queue(dev, i);
+			if (!netif_xmit_stopped(txq))
+				continue;
+
+			/* Paired with WRITE_ONCE() + smp_mb...() in
+			 * netdev_tx_sent_queue() and netif_tx_stop_queue().
+			 */
+			smp_mb();
+			trans_start = READ_ONCE(txq->trans_start);
 
-			if (unlikely(timedout_ms)) {
-				trace_net_dev_xmit_timeout(dev, i);
-				netdev_crit(dev, "NETDEV WATCHDOG: CPU: %d: transmit queue %u timed out %u ms\n",
-					    raw_smp_processor_id(),
-					    i, timedout_ms);
-				netif_freeze_queues(dev);
-				dev->netdev_ops->ndo_tx_timeout(dev, i);
-				netif_unfreeze_queues(dev);
+			if (time_after(jiffies, trans_start + dev->watchdog_timeo)) {
+				timedout_ms = jiffies_to_msecs(jiffies - trans_start);
+				atomic_long_inc(&txq->trans_timeout);
+				break;
 			}
-			if (!mod_timer(&dev->watchdog_timer,
-				       round_jiffies(oldest_start +
-						     dev->watchdog_timeo)))
-				release = false;
+			if (time_after(oldest_start, trans_start))
+				oldest_start = trans_start;
+		}
+
+		if (unlikely(timedout_ms)) {
+			trace_net_dev_xmit_timeout(dev, i);
+			netdev_crit(dev, "NETDEV WATCHDOG: CPU: %d: transmit queue %u timed out %u ms\n",
+				    raw_smp_processor_id(),
+				    i, timedout_ms);
+			netif_freeze_queues(dev);
+			dev->netdev_ops->ndo_tx_timeout(dev, i);
+			netif_unfreeze_queues(dev);
 		}
+		if (!mod_timer(&dev->watchdog_timer,
+			       round_jiffies(oldest_start +
+					     dev->watchdog_timeo)))
+			release = false;
 	}
 	spin_unlock(&dev->tx_global_lock);
 
-- 
2.34.1


