Return-Path: <netdev+bounces-181267-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE1EA8438A
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 14:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E634D1B85F66
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 12:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC8822853EA;
	Thu, 10 Apr 2025 12:43:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ABE1283CB8
	for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 12:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744288981; cv=none; b=COtzZSGR/ZETUqktTPEShgsO/Y+sNqOct0nIUS5AXq7uPHWLRBSVU17lE3C3xbU0uid/soU51HLaZ7Q1dl1H0LuZ+5uqPWCncX1SkBYpx2qRI51X5Vh21Z3UTgRlrAAfAmmZGebKpPL53K+Va0pLOlBCiiDOPH55tcBEYYKijOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744288981; c=relaxed/simple;
	bh=ZOFQluFBG0zSOKV/1pDE1DUCuPZB1OY8kz2hDAclls8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=AlfzZpbtJoUnCH4UOiN7nC8x52JqavFNOIzF4L+eQAD2VNjpA5FffFZggn5uMxYCAEIBUDa/aemX7c7clYxMAuUj5xEHhnqdE+Ks2rI12l/lcJkHTkG9w0uA1H1wq4inv9ZDusa8nG/4YvTeomOUb/wj3DO3w8qc0zYvWTHCBug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1u2rF5-0006jB-3x; Thu, 10 Apr 2025 14:42:51 +0200
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1u2rF4-004GuW-1V;
	Thu, 10 Apr 2025 14:42:50 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1u2rF4-00BRpe-1F;
	Thu, 10 Apr 2025 14:42:50 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com,
	=?UTF-8?q?S=C3=B8ren=20Andersen?= <san@skov.dk>
Subject: [PATCH net-next v1 1/1] net: dsa: microchip: add ETS scheduler support for KSZ88x3 switches
Date: Thu, 10 Apr 2025 14:42:49 +0200
Message-Id: <20250410124249.2728568-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Implement Enhanced Transmission Selection scheduler (ETS) support for
KSZ88x3 devices, which support two fixed egress scheduling modes:
Strict Priority and Weighted Fair Queuing (WFQ).

Since the switch does not allow remapping priorities to queues or
adjusting weights, this implementation only supports enabling
strict priority mode. If strict mode is not explicitly requested,
the switch falls back to its default WFQ mode.

This patch introduces KSZ88x3-specific handlers for ETS add and
delete operations and uses TXQ Split Control registers to toggle
the WFQ enable bit per queue. Corresponding macros are also added
for register access.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/dsa/microchip/ksz_common.c | 97 +++++++++++++++++++++++++-
 drivers/net/dsa/microchip/ksz_common.h | 19 +++++
 2 files changed, 113 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 89f0796894af..b45052497f8a 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -3999,6 +3999,89 @@ static int ksz_ets_band_to_queue(struct tc_ets_qopt_offload_replace_params *p,
 	return p->bands - 1 - band;
 }

+/**
+ * ksz88x3_tc_ets_add - Configure ETS (Enhanced Transmission Selection)
+ *                      for a port on KSZ88x3 switch
+ * @dev: Pointer to the KSZ switch device structure
+ * @port: Port number to configure
+ * @p: Pointer to offload replace parameters describing ETS bands and mapping
+ *
+ * The KSZ88x3 supports two scheduling modes: Strict Priority and
+ * Weighted Fair Queuing (WFQ). Both modes have fixed behavior:
+ *   - No configurable queue-to-priority mapping
+ *   - No weight adjustment in WFQ mode
+ *
+ * This function configures the switch to use strict priority mode by
+ * clearing the WFQ enable bit for all queues associated with ETS bands.
+ * If strict priority is not explicitly requested, the switch will default
+ * to WFQ mode.
+ *
+ * Return: 0 on success, or a negative error code on failure
+ */
+static int ksz88x3_tc_ets_add(struct ksz_device *dev, int port,
+			      struct tc_ets_qopt_offload_replace_params *p)
+{
+	int ret, band;
+
+	/* Only strict priority mode is supported for now.
+	 * WFQ is implicitly enabled when strict mode is disabled.
+	 */
+	for (band = 0; band < p->bands; band++) {
+		int queue = ksz_ets_band_to_queue(p, band);
+		u8 reg;
+
+		/* Calculate TXQ Split Control register address for this
+		 * port/queue
+		 */
+		reg = KSZ8873_TXQ_SPLIT_CTRL_REG(port, queue);
+
+		/* Clear WFQ enable bit to select strict priority scheduling */
+		ret = ksz_rmw8(dev, reg, KSZ8873_TXQ_WFQ_ENABLE, 0);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+/**
+ * ksz88x3_tc_ets_del - Reset ETS (Enhanced Transmission Selection) config
+ *                      for a port on KSZ88x3 switch
+ * @dev: Pointer to the KSZ switch device structure
+ * @port: Port number to reset
+ *
+ * The KSZ88x3 supports only fixed scheduling modes: Strict Priority or
+ * Weighted Fair Queuing (WFQ), with no reconfiguration of weights or
+ * queue mapping. This function resets the port’s scheduling mode to
+ * the default, which is WFQ, by enabling the WFQ bit for all queues.
+ *
+ * Return: 0 on success, or a negative error code on failure
+ */
+static int ksz88x3_tc_ets_del(struct ksz_device *dev, int port)
+{
+	int ret, queue;
+
+	/* Iterate over all transmit queues for this port */
+	for (queue = 0; queue < dev->info->num_tx_queues; queue++) {
+		u8 reg;
+
+		/* Calculate TXQ Split Control register address for this
+		 * port/queue
+		 */
+		reg = KSZ8873_TXQ_SPLIT_CTRL_REG(port, queue);
+
+		/* Set WFQ enable bit to revert back to default scheduling
+		 * mode
+		 */
+		ret = ksz_rmw8(dev, reg, KSZ8873_TXQ_WFQ_ENABLE,
+			       KSZ8873_TXQ_WFQ_ENABLE);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 static int ksz_queue_set_strict(struct ksz_device *dev, int port, int queue)
 {
 	int ret;
@@ -4080,6 +4163,7 @@ static int ksz_tc_ets_del(struct ksz_device *dev, int port)
 	for (queue = 0; queue < dev->info->num_tx_queues; queue++) {
 		ret = ksz_queue_set_wrr(dev, port, queue,
 					KSZ9477_DEFAULT_WRR_WEIGHT);
+
 		if (ret)
 			return ret;
 	}
@@ -4132,7 +4216,7 @@ static int ksz_tc_setup_qdisc_ets(struct dsa_switch *ds, int port,
 	struct ksz_device *dev = ds->priv;
 	int ret;

-	if (is_ksz8(dev))
+	if (is_ksz8(dev) && !ksz_is_ksz88x3(dev))
 		return -EOPNOTSUPP;

 	if (qopt->parent != TC_H_ROOT) {
@@ -4146,9 +4230,16 @@ static int ksz_tc_setup_qdisc_ets(struct dsa_switch *ds, int port,
 		if (ret)
 			return ret;

-		return ksz_tc_ets_add(dev, port, &qopt->replace_params);
+		if (ksz_is_ksz88x3(dev))
+			return ksz88x3_tc_ets_add(dev, port,
+						  &qopt->replace_params);
+		else
+			return ksz_tc_ets_add(dev, port, &qopt->replace_params);
 	case TC_ETS_DESTROY:
-		return ksz_tc_ets_del(dev, port);
+		if (ksz_is_ksz88x3(dev))
+			return ksz88x3_tc_ets_del(dev, port);
+		else
+			return ksz_tc_ets_del(dev, port);
 	case TC_ETS_STATS:
 	case TC_ETS_GRAFT:
 		return -EOPNOTSUPP;
diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index af17a9c030d4..dd5429ff16ee 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -836,6 +836,25 @@ static inline bool is_lan937x_tx_phy(struct ksz_device *dev, int port)
 #define SW_HI_SPEED_DRIVE_STRENGTH_S	4
 #define SW_LO_SPEED_DRIVE_STRENGTH_S	0

+/* TXQ Split Control Register for per-port, per-queue configuration.
+ * Register 0xAF is TXQ Split for Q3 on Port 1.
+ * Register offset formula: 0xAF + (port * 4) + (3 - queue)
+ *   where: port = 0..2, queue = 0..3
+ */
+#define KSZ8873_TXQ_SPLIT_CTRL_REG(port, queue) \
+	(0xAF + ((port) * 4) + (3 - (queue)))
+
+/* Bit 7 selects between:
+ *   0 = Strict priority mode (highest-priority queue first)
+ *   1 = Weighted Fair Queuing (WFQ) mode:
+ *       Queue weights: Q3:Q2:Q1:Q0 = 8:4:2:1
+ *       If any queues are empty, weight is redistributed.
+ *
+ * Note: This is referred to as "Weighted Fair Queuing" (WFQ) in KSZ8863/8873
+ * documentation, and as "Weighted Round Robin" (WRR) in KSZ9477 family docs.
+ */
+#define KSZ8873_TXQ_WFQ_ENABLE		BIT(7)
+
 #define KSZ9477_REG_PORT_OUT_RATE_0	0x0420
 #define KSZ9477_OUT_RATE_NO_LIMIT	0

--
2.39.5


