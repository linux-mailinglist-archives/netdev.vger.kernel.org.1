Return-Path: <netdev+bounces-252712-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uP4DGGs7c2kztgAAu9opvQ
	(envelope-from <netdev+bounces-252712-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 10:12:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D4DD1730C1
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 10:12:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D2610307E598
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 09:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED2E334FF49;
	Fri, 23 Jan 2026 09:07:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6D133A712
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 09:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769159274; cv=none; b=VXRMJTA9Nirs9N8JetmpmgRJloOV4eSoRD8TWYS8vrHXfq3cHnmKzZF7Ti7RwpdkQTD2hzb7cgzRH+nMNtsW4FJiACUGn7qIxqa5MhyznyMXhh0V9ogxiU4CcZKrE3VLI3AonYU/NcOEdMvr9sVGEg7W/hUfS83JuZa4t84yLMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769159274; c=relaxed/simple;
	bh=r5XEHOJhn1h9gr3DcBd/TQpuCeRA/qz6bGYE0Gsm3I0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X01B/zu+Dnjz/aEhB0bBVp9U1JvCuwCjvtBMgeHgET5YaNFu3bxGGyNLxY7YUUU8GVtOftVbMq8ESpHcwcuBtgS6owCaoatlFByijvPPPCY9n1oyRXx+HDilGiO5jSy20VrrGdCimjHc2D94+3P9ho5HHMyIHlM3p1DpJy0iWj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1vjD8q-00027J-59; Fri, 23 Jan 2026 10:07:44 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac] helo=dude04)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vjD8p-00244z-0l;
	Fri, 23 Jan 2026 10:07:42 +0100
Received: from ore by dude04 with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1vjD8o-00000006ZX2-1uae;
	Fri, 23 Jan 2026 10:07:42 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Thangaraj Samynathan <Thangaraj.S@microchip.com>,
	Rengarajan Sundararajan <Rengarajan.S@microchip.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com
Subject: [RFC PATCH 3/4] net: lan78xx: Enhance health reporting with workqueue and detailed flow control stats
Date: Fri, 23 Jan 2026 10:07:39 +0100
Message-ID: <20260123090741.1566469-4-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260123090741.1566469-1-o.rempel@pengutronix.de>
References: <20260123090741.1566469-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[pengutronix.de];
	RCVD_COUNT_FIVE(0.00)[6];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-252712-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	FROM_NEQ_ENVFROM(0.00)[o.rempel@pengutronix.de,netdev@vger.kernel.org];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pengutronix.de:mid,pengutronix.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D4DD1730C1
X-Rspamd-Action: no action

Refactor the health reporting to:

1. Introduce a dedicated workqueue for TX timeouts. This prevents
   calling devlink_health_report (which may sleep) from an atomic
   context (netdev tx_timeout).

2. Update statistics tracking and reporting context to separate TX Pause
   and RX Pause frames, allowing finer-grained stall analysis (local vs.
   link partner induced flow control storm).

3. Change the devlink recovery function to call
   phylink_mac_change(false). This leverages the newly robust link_down
   path which performs the necessary locking and conditional Lite Reset.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/usb/lan78xx.c | 133 +++++++++++++++++++++++++-------------
 1 file changed, 87 insertions(+), 46 deletions(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index 9dadca4101bc..316a3a8d0534 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -425,15 +425,36 @@ struct lan78xx_stat_snapshot {
 	ktime_t time;
 
 	u64 tx_pause_total;
+	u64 rx_pause_total;
 	u64 tx_unicast_total;
 	u64 rx_total_frames;
 	u64 rx_hw_drop_total;
 	u64 rx_sw_packets_total;
 
-	u32 last_delta_pause;
+	u32 last_delta_rx_pause;
+	u32 last_delta_tx_pause;
 	u32 last_delta_drops;
 };
 
+struct lan78xx_dump_ctx {
+	const char *msg;
+	ktime_t ts; /* Timestamp of detection */
+
+	union {
+		struct {
+			u64 delta_tx_pause;
+			u64 delta_rx_pause;
+			u64 delta_rx;
+			u64 delta_hw_drop;
+			u64 delta_sw_rx;
+		} fifo;
+		struct {
+			u32 int_sts; /* The ISR's view of INT_STS */
+			u32 int_enp; /* The ISR's view of INT_ENP_CTL */
+		} err;
+	};
+};
+
 struct irq_domain_data {
 	struct irq_domain	*irqdomain;
 	unsigned int		phyirq;
@@ -505,27 +526,10 @@ struct lan78xx_net {
 	struct devlink_health_reporter	*fifo_reporter;
 	struct devlink_health_reporter	*internal_err_reporter;
 	struct lan78xx_stat_snapshot	snapshot;
+	struct work_struct		tx_timeout_work;
+	struct lan78xx_dump_ctx		timeout_ctx;
 };
 
-struct lan78xx_dump_ctx {
-	const char *msg;
-	ktime_t ts; /* Timestamp of detection */
-
-	union {
-		struct {
-			u64 delta_pause;
-			u64 delta_rx;
-			u64 delta_hw_drop;
-			u64 delta_sw_rx;
-		} fifo;
-		struct {
-			u32 int_sts; /* The ISR's view of INT_STS */
-			u32 int_enp; /* The ISR's view of INT_ENP_CTL */
-		} err;
-	};
-};
-
-/* Register Dump Map Structure */
 struct lan78xx_reg_map {
 	u32 reg;
 	const char *name;
@@ -966,7 +970,7 @@ static void lan78xx_check_stat_rollover(struct lan78xx_net *dev,
 
 static void lan78xx_check_stat_anomalies(struct lan78xx_net *dev)
 {
-	u64 delta_pause, delta_rx, delta_hw_drop, delta_sw_rx;
+	u64 delta_tx_pause, delta_rx_pause, delta_rx, delta_hw_drop, delta_sw_rx;
 	struct lan78xx_dump_ctx ctx = {0};
 	struct lan78xx_stat_snapshot now;
 	const char *anomaly_msg = NULL;
@@ -976,6 +980,7 @@ static void lan78xx_check_stat_anomalies(struct lan78xx_net *dev)
 
 	mutex_lock(&dev->stats.access_lock);
 	now.tx_pause_total = dev->stats.curr_stat.tx_pause_frames;
+	now.rx_pause_total = dev->stats.curr_stat.rx_pause_frames;
 	now.rx_total_frames = dev->stats.curr_stat.rx_unicast_frames +
 			      dev->stats.curr_stat.rx_broadcast_frames +
 			      dev->stats.curr_stat.rx_multicast_frames;
@@ -985,17 +990,19 @@ static void lan78xx_check_stat_anomalies(struct lan78xx_net *dev)
 
 	now.rx_sw_packets_total = dev->net->stats.rx_packets;
 
-	delta_pause = now.tx_pause_total - dev->snapshot.tx_pause_total;
+	delta_tx_pause = now.tx_pause_total - dev->snapshot.tx_pause_total;
+	delta_rx_pause = now.rx_pause_total - dev->snapshot.rx_pause_total;
 	delta_rx = now.rx_total_frames - dev->snapshot.rx_total_frames;
 	delta_hw_drop = now.rx_hw_drop_total - dev->snapshot.rx_hw_drop_total;
 	delta_sw_rx = now.rx_sw_packets_total - dev->snapshot.rx_sw_packets_total;
 
-	now.last_delta_pause = (u32)delta_pause;
+	now.last_delta_tx_pause = (u32)delta_tx_pause;
+	now.last_delta_rx_pause = (u32)delta_rx_pause;
 	now.last_delta_drops = (u32)delta_hw_drop;
 
 	dev->snapshot = now;
 
-	if (delta_pause > LAN78XX_STALL_PAUSE_THRESH && delta_rx == 0) {
+	if (delta_tx_pause > LAN78XX_STALL_PAUSE_THRESH && delta_rx == 0) {
 		anomaly_msg = "Stall: Pause Storm & No RX";
 	} else if (delta_hw_drop > LAN78XX_LIVELOCK_DROP_THRESH &&
 		   delta_hw_drop > (delta_sw_rx * LAN78XX_LIVELOCK_DROP_RATIO)) {
@@ -1008,10 +1015,11 @@ static void lan78xx_check_stat_anomalies(struct lan78xx_net *dev)
 	/* 5. Reporting */
 	ctx.msg = anomaly_msg;
 	ctx.ts = now.time;
-	ctx.fifo.delta_pause   = delta_pause;
-	ctx.fifo.delta_rx      = delta_rx;
+	ctx.fifo.delta_tx_pause = delta_tx_pause;
+	ctx.fifo.delta_rx_pause = delta_rx_pause;
+	ctx.fifo.delta_rx = delta_rx;
 	ctx.fifo.delta_hw_drop = delta_hw_drop;
-	ctx.fifo.delta_sw_rx   = delta_sw_rx;
+	ctx.fifo.delta_sw_rx = delta_sw_rx;
 
 	netdev_warn(dev->net, "%s (HW Drops: +%llu, SW RX: +%llu)\n",
 		    ctx.msg, delta_hw_drop, delta_sw_rx);
@@ -2495,6 +2503,24 @@ static void lan78xx_mac_config(struct phylink_config *config, unsigned int mode,
 			   ERR_PTR(ret));
 }
 
+static int lan78xx_configure_flowcontrol(struct lan78xx_net *dev,
+					 bool tx_pause, bool rx_pause);
+static int lan78xx_reset(struct lan78xx_net *dev);
+
+static void lan78xx_dump_status(struct lan78xx_net *dev, const char *msg)
+{
+	u32 int_sts, mac_tx, fct_tx_ctl, mac_rx, fct_rx_ctl;
+
+	lan78xx_read_reg(dev, INT_STS, &int_sts);
+	lan78xx_read_reg(dev, MAC_TX, &mac_tx);
+	lan78xx_read_reg(dev, FCT_TX_CTL, &fct_tx_ctl);
+	lan78xx_read_reg(dev, MAC_RX, &mac_rx);
+	lan78xx_read_reg(dev, FCT_RX_CTL, &fct_rx_ctl);
+
+	netdev_info(dev->net, "[%s] INT_STS: 0x%08x, MAC_TX: 0x%08x, FCT_TX: 0x%08x, MAC_RX: 0x%08x, FCT_RX: 0x%08x\n",
+		    msg, int_sts, mac_tx, fct_tx_ctl, mac_rx, fct_rx_ctl);
+}
+
 static void lan78xx_mac_link_down(struct phylink_config *config,
 				  unsigned int mode, phy_interface_t interface)
 {
@@ -4939,8 +4965,10 @@ static int lan78xx_fifo_dump(struct devlink_health_reporter *reporter,
 					  ktime_to_ns(ctx->ts));
 
 		devlink_fmsg_obj_nest_start(fmsg);
-		devlink_fmsg_u64_pair_put(fmsg, "trigger_delta_pause",
-					  ctx->fifo.delta_pause);
+		devlink_fmsg_u64_pair_put(fmsg, "trigger_delta_tx_pause",
+					  ctx->fifo.delta_tx_pause);
+		devlink_fmsg_u64_pair_put(fmsg, "trigger_delta_rx_pause",
+					  ctx->fifo.delta_rx_pause);
 		devlink_fmsg_u64_pair_put(fmsg, "trigger_delta_rx",
 					  ctx->fifo.delta_rx);
 		devlink_fmsg_u64_pair_put(fmsg, "trigger_delta_hw_drop",
@@ -4989,8 +5017,9 @@ static int lan78xx_fifo_recover(struct devlink_health_reporter *reporter,
 {
 	struct lan78xx_net *dev = devlink_health_reporter_priv(reporter);
 
-	netdev_warn(dev->net, "Recovering from FIFO stall via Lite Reset\n");
-	return lan78xx_reset(dev);
+	netdev_warn(dev->net, "Recovering via Lite Reset\n");
+	phylink_mac_change(dev->phylink, false);
+	return 0;
 }
 
 static const struct devlink_health_reporter_ops lan78xx_fifo_ops = {
@@ -5075,6 +5104,7 @@ static void lan78xx_disconnect(struct usb_interface *intf)
 
 	lan78xx_health_cleanup(dev);
 	if (dev->devlink) {
+		cancel_work_sync(&dev->tx_timeout_work);
 		devlink_unregister(dev->devlink);
 		devlink_free(dev->devlink);
 		dev->devlink = NULL;
@@ -5107,36 +5137,45 @@ static void lan78xx_disconnect(struct usb_interface *intf)
 	usb_put_dev(udev);
 }
 
+static void lan78xx_tx_timeout_work(struct work_struct *work)
+{
+	struct lan78xx_net *dev = container_of(work, struct lan78xx_net,
+					       tx_timeout_work);
+
+	devlink_health_report(dev->fifo_reporter, dev->timeout_ctx.msg,
+			      &dev->timeout_ctx);
+}
+
 static void lan78xx_tx_timeout(struct net_device *net, unsigned int txqueue)
 {
 	struct lan78xx_net *dev = netdev_priv(net);
-	struct lan78xx_dump_ctx ctx = {0};
-	s64 diff_ms;
+	s64 diff_ms = 0;
 
 	/* Calculate time since last health check */
-	ctx.ts = ktime_get_real();
-	diff_ms = ktime_ms_delta(ctx.ts, dev->snapshot.time);
+	dev->timeout_ctx.ts = ktime_get_real();
+	diff_ms = ktime_ms_delta(dev->timeout_ctx.ts, dev->snapshot.time);
 
 	/* We rely on the trend data captured during the last valid stat update
 	 * to infer the system state before the crash.
 	 */
-	if (dev->snapshot.last_delta_pause > LAN78XX_STALL_PAUSE_THRESH)
-		ctx.msg = "TX Timeout (Flow Control Storm?)";
+	if (dev->snapshot.last_delta_rx_pause > LAN78XX_STALL_PAUSE_THRESH)
+		dev->timeout_ctx.msg = "TX Timeout (Link Partner Pause Storm?)";
+	else if (dev->snapshot.last_delta_tx_pause > LAN78XX_STALL_PAUSE_THRESH)
+		dev->timeout_ctx.msg = "TX Timeout (Local Flow Control Storm?)";
 	else if (dev->snapshot.last_delta_drops > LAN78XX_TX_TIMEOUT_DROP_THRESH)
-		ctx.msg = "TX Timeout (FIFO Drop Storm?)";
+		dev->timeout_ctx.msg = "TX Timeout (FIFO Drop Storm?)";
 	else
-		ctx.msg = "TX Timeout";
+		dev->timeout_ctx.msg = "TX Timeout";
 
-	ctx.fifo.delta_pause = dev->snapshot.last_delta_pause;
-	ctx.fifo.delta_hw_drop = dev->snapshot.last_delta_drops;
+	dev->timeout_ctx.fifo.delta_rx_pause = dev->snapshot.last_delta_rx_pause;
+	dev->timeout_ctx.fifo.delta_tx_pause = dev->snapshot.last_delta_tx_pause;
+	dev->timeout_ctx.fifo.delta_hw_drop = dev->snapshot.last_delta_drops;
 
 	netdev_warn(dev->net, "%s (Last stat update: %lld ms ago)\n",
-		    ctx.msg, diff_ms);
+		    dev->timeout_ctx.msg, diff_ms);
 
-	devlink_health_report(dev->fifo_reporter, ctx.msg, &ctx);
-
-	unlink_urbs(dev, &dev->txq);
-	napi_schedule(&dev->napi);
+	/* Defer report to worker to avoid sleeping in atomic context */
+	schedule_work(&dev->tx_timeout_work);
 }
 
 static netdev_features_t lan78xx_features_check(struct sk_buff *skb,
@@ -5542,6 +5581,8 @@ static int lan78xx_probe(struct usb_interface *intf,
 	pm_runtime_set_autosuspend_delay(&udev->dev,
 					 DEFAULT_AUTOSUSPEND_DELAY);
 
+	INIT_WORK(&dev->tx_timeout_work, lan78xx_tx_timeout_work);
+
 	dev->devlink = devlink_alloc(&lan78xx_devlink_ops,
 				     sizeof(struct lan78xx_devlink_priv),
 				     &udev->dev);
-- 
2.47.3


