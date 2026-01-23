Return-Path: <netdev+bounces-252714-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oKvwJ8E7c2kztgAAu9opvQ
	(envelope-from <netdev+bounces-252714-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 10:13:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 35903730F7
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 10:13:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E644D30CD6ED
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 09:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF6D33FE36;
	Fri, 23 Jan 2026 09:07:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12493559FA
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 09:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769159278; cv=none; b=XlbnkhS2Q3I3Wx2bh2JJoRLMoX8UXF1KUaJsL+oihjkKSopL1E8KSehg17aKi+UppzA7r/KsdyKOoa4WTj5IGh/8uRjAze6byaCSxH0SYRWBIHKwTsd/y7xHt3bSfOXjavgVzNHi8POzrEG2Lvz7jl8V/q+5+UGbK4gMJF6txdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769159278; c=relaxed/simple;
	bh=mCKUo3TPfcyOzZ8ABSgqCmFLcXF+ttKCZnIc/7ffrv8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dfoRpoQDKwf42Jx0GeaYur75ws3T6OiMgjEFL27QUOt8fl/kKoObtCV3C4i6EcFHMV1WKpaKMiKt91ro/MtU9FB8rLkQDQ3/Bd5vYNMhogOpNqyuGZXmnWPFTf1+4aHmpeEvEyt79H2GRg4Di3FRldXNFc2tilMaom5Bp1hn/AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1vjD8q-00027G-59; Fri, 23 Jan 2026 10:07:44 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac] helo=dude04)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vjD8p-00244x-0V;
	Fri, 23 Jan 2026 10:07:42 +0100
Received: from ore by dude04 with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1vjD8o-00000006ZWi-1hdQ;
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
Subject: [RFC PATCH 1/4] net: lan78xx: Add devlink health support for diagnostics
Date: Fri, 23 Jan 2026 10:07:37 +0100
Message-ID: <20260123090741.1566469-2-o.rempel@pengutronix.de>
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
	TAGGED_FROM(0.00)[bounces-252714-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 35903730F7
X-Rspamd-Action: no action

Add devlink health support for diagnostics

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/usb/lan78xx.c | 388 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 387 insertions(+), 1 deletion(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index ad620b56443b..221be42e06f4 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -27,6 +27,7 @@
 #include <linux/slab.h>
 #include <linux/uaccess.h>
 #include <linux/usb.h>
+#include <net/devlink.h>
 #include <net/ip6_checksum.h>
 #include <net/selftests.h>
 #include <net/vxlan.h>
@@ -41,6 +42,11 @@
 #define THROTTLE_JIFFIES		(HZ / 8)
 #define UNLINK_TIMEOUT_MS		3
 
+#define LAN78XX_STALL_PAUSE_THRESH	100
+#define LAN78XX_LIVELOCK_DROP_THRESH	10000
+#define LAN78XX_LIVELOCK_DROP_RATIO	10
+#define LAN78XX_TX_TIMEOUT_DROP_THRESH	1000
+
 #define RX_MAX_QUEUE_MEMORY		(60 * 1518)
 
 #define SS_USB_PKT_SIZE			(1024)
@@ -373,6 +379,10 @@ struct lan78xx_priv {
 	u32 wol;
 };
 
+struct lan78xx_devlink_priv {
+	struct lan78xx_net *dev;
+};
+
 enum skb_state {
 	illegal = 0,
 	tx_start,
@@ -411,6 +421,19 @@ struct statstage {
 	struct lan78xx_statstage64	curr_stat;
 };
 
+struct lan78xx_stat_snapshot {
+	ktime_t time;
+
+	u64 tx_pause_total;
+	u64 tx_unicast_total;
+	u64 rx_total_frames;
+	u64 rx_hw_drop_total;
+	u64 rx_sw_packets_total;
+
+	u32 last_delta_pause;
+	u32 last_delta_drops;
+};
+
 struct irq_domain_data {
 	struct irq_domain	*irqdomain;
 	unsigned int		phyirq;
@@ -477,6 +500,35 @@ struct lan78xx_net {
 
 	struct phylink		*phylink;
 	struct phylink_config	phylink_config;
+
+	struct devlink		*devlink;
+	struct devlink_health_reporter	*fifo_reporter;
+	struct devlink_health_reporter	*internal_err_reporter;
+	struct lan78xx_stat_snapshot	snapshot;
+};
+
+struct lan78xx_dump_ctx {
+	const char *msg;
+	ktime_t ts; /* Timestamp of detection */
+
+	union {
+		struct {
+			u64 delta_pause;
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
+/* Register Dump Map Structure */
+struct lan78xx_reg_map {
+	u32 reg;
+	const char *name;
 };
 
 /* use ethtool to change the level for any given device */
@@ -484,6 +536,87 @@ static int msg_level = -1;
 module_param(msg_level, int, 0);
 MODULE_PARM_DESC(msg_level, "Override default message level");
 
+/* Helper macro to map register to name string */
+#define LAN78XX_DUMP_REG(reg) { reg, #reg }
+
+static const struct lan78xx_reg_map lan78xx_fifo_regs[] = {
+	/* --- FIFO Control & Status ---
+	 * specific enable/reset bits.
+	 * used_bytes tells us if the bottleneck is USB (TX high) or MAC
+	 * (RX high).
+	 */
+	LAN78XX_DUMP_REG(FCT_TX_CTL),
+	LAN78XX_DUMP_REG(FCT_RX_CTL),
+
+	/* --- Data Path Usage ---
+	 * Capture total buffer usage including USB endpoint overhead.
+	 * If DP_STOR is high but FCT_USED is low, data is stuck in the USB
+	 * layer.
+	 */
+	LAN78XX_DUMP_REG(TX_DP_STOR),
+	LAN78XX_DUMP_REG(RX_DP_STOR),
+
+	/* --- FIFO Boundaries ---
+	 * verify if the FIFO partitioning has been corrupted or misconfigured.
+	 */
+	LAN78XX_DUMP_REG(FCT_TX_FIFO_END),
+	LAN78XX_DUMP_REG(FCT_RX_FIFO_END),
+
+	/* --- Flow Control ---
+	 * Critical for "Pause Storm" debugging.
+	 * Check if thresholds are set correctly and if Pause frames are enabled.
+	 */
+	LAN78XX_DUMP_REG(FCT_FLOW),
+	LAN78XX_DUMP_REG(FLOW),
+
+	/* --- Configuration & Speed ---
+	 * Mismatches between MAC speed (1G) and USB speed (HighSpeed)
+	 * are the #1 cause of buffer overflows.
+	 */
+	LAN78XX_DUMP_REG(MAC_CR),       /* MAC Speed/Duplex */
+	LAN78XX_DUMP_REG(USB_CFG0),     /* USB Speed/Burst Cap Enable */
+	LAN78XX_DUMP_REG(BURST_CAP),    /* USB Burst Size Limit */
+	LAN78XX_DUMP_REG(BULK_IN_DLY),  /* Inter-packet delay settings */
+
+	/* --- Debug Pointers ---
+	 * Internal read/write pointers for the FIFO RAM.
+	 * Helps detect if the hardware pointer logic has wrapped or frozen.
+	 */
+	LAN78XX_DUMP_REG(DP_SEL),
+	LAN78XX_DUMP_REG(DP_CMD),
+};
+
+static const struct lan78xx_reg_map lan78xx_err_regs[] = {
+	/* --- Interrupt Status ---
+	 * The "Smoking Gun". Reveals if the error was triggered by:
+	 * - MAC_ERR_INT: Internal logic overflow/underflow.
+	 * - PHY_INT: Link loss or signal degradation.
+	 * - TDFO/RDFO: FIFO Overflows (redundant but explicit).
+	 */
+	LAN78XX_DUMP_REG(INT_STS),
+	LAN78XX_DUMP_REG(INT_EP_CTL),
+
+	/* --- System Health ---
+	 * Check for invalid power states (D3 while active) or stuck resets.
+	 * HW_CFG also contains the "Soft Reset" status bit.
+	 */
+	LAN78XX_DUMP_REG(HW_CFG),
+	LAN78XX_DUMP_REG(PMT_CTL),
+
+	/* --- Bus Integrity ---
+	 * USB_CFG1 contains Low Power Mode (LPM) and Suspend guards.
+	 */
+	LAN78XX_DUMP_REG(USB_CFG0),
+	LAN78XX_DUMP_REG(USB_CFG1),
+
+	/* --- MAC Status ---
+	 * Verify if the receiver is actually enabled (RXEN) and if
+	 * filtering (Promiscuous/Multicast) is set as expected.
+	 */
+	LAN78XX_DUMP_REG(MAC_CR),
+	LAN78XX_DUMP_REG(MAC_RX),
+};
+
 static struct sk_buff *lan78xx_get_buf(struct sk_buff_head *buf_pool)
 {
 	if (skb_queue_empty(buf_pool))
@@ -831,12 +964,67 @@ static void lan78xx_check_stat_rollover(struct lan78xx_net *dev,
 	memcpy(&dev->stats.saved, stats, sizeof(struct lan78xx_statstage));
 }
 
+static void lan78xx_check_stat_anomalies(struct lan78xx_net *dev)
+{
+	u64 delta_pause, delta_rx, delta_hw_drop, delta_sw_rx;
+	struct lan78xx_dump_ctx ctx = {0};
+	struct lan78xx_stat_snapshot now;
+	const char *anomaly_msg = NULL;
+
+	/* 1. Capture "Now" (Atomic-ish collection) */
+	now.time = ktime_get_real();
+
+	mutex_lock(&dev->stats.access_lock);
+	now.tx_pause_total = dev->stats.curr_stat.tx_pause_frames;
+	now.rx_total_frames = dev->stats.curr_stat.rx_unicast_frames +
+			      dev->stats.curr_stat.rx_broadcast_frames +
+			      dev->stats.curr_stat.rx_multicast_frames;
+	now.rx_hw_drop_total = dev->stats.curr_stat.rx_dropped_frames;
+	now.tx_unicast_total = dev->stats.curr_stat.tx_unicast_frames;
+	mutex_unlock(&dev->stats.access_lock);
+
+	now.rx_sw_packets_total = dev->net->stats.rx_packets;
+
+	delta_pause = now.tx_pause_total - dev->snapshot.tx_pause_total;
+	delta_rx = now.rx_total_frames - dev->snapshot.rx_total_frames;
+	delta_hw_drop = now.rx_hw_drop_total - dev->snapshot.rx_hw_drop_total;
+	delta_sw_rx = now.rx_sw_packets_total - dev->snapshot.rx_sw_packets_total;
+
+	now.last_delta_pause = (u32)delta_pause;
+	now.last_delta_drops = (u32)delta_hw_drop;
+
+	dev->snapshot = now;
+
+	if (delta_pause > LAN78XX_STALL_PAUSE_THRESH && delta_rx == 0) {
+		anomaly_msg = "Stall: Pause Storm & No RX";
+	} else if (delta_hw_drop > LAN78XX_LIVELOCK_DROP_THRESH &&
+		   delta_hw_drop > (delta_sw_rx * LAN78XX_LIVELOCK_DROP_RATIO)) {
+		anomaly_msg = "Stall: RX Livelock Detected (Excessive Drop Ratio)";
+	}
+
+	if (!anomaly_msg)
+		return;
+
+	/* 5. Reporting */
+	ctx.msg = anomaly_msg;
+	ctx.ts = now.time;
+	ctx.fifo.delta_pause   = delta_pause;
+	ctx.fifo.delta_rx      = delta_rx;
+	ctx.fifo.delta_hw_drop = delta_hw_drop;
+	ctx.fifo.delta_sw_rx   = delta_sw_rx;
+
+	netdev_warn(dev->net, "%s (HW Drops: +%llu, SW RX: +%llu)\n",
+		    ctx.msg, delta_hw_drop, delta_sw_rx);
+
+	devlink_health_report(dev->fifo_reporter, ctx.msg, &ctx);
+}
+
 static void lan78xx_update_stats(struct lan78xx_net *dev)
 {
+	struct lan78xx_statstage lan78xx_stats;
 	u32 *p, *count, *max;
 	u64 *data;
 	int i;
-	struct lan78xx_statstage lan78xx_stats;
 
 	if (usb_autopm_get_interface(dev->intf) < 0)
 		return;
@@ -856,6 +1044,8 @@ static void lan78xx_update_stats(struct lan78xx_net *dev)
 
 	mutex_unlock(&dev->stats.access_lock);
 
+	lan78xx_check_stat_anomalies(dev);
+
 	usb_autopm_put_interface(dev->intf);
 }
 
@@ -1625,6 +1815,18 @@ static void lan78xx_status(struct lan78xx_net *dev, struct urb *urb)
 
 		if (dev->domain_data.phyirq > 0)
 			generic_handle_irq_safe(dev->domain_data.phyirq);
+	} else if (intdata & (INT_ENP_TDFO_INT | INT_ENP_TDFU_INT |
+			      INT_ENP_RDFO_INT | INT_ENP_MAC_ERR_INT)) {
+		struct lan78xx_dump_ctx ctx = {0};
+
+		ctx.msg = "HW Interrupt Error";
+		ctx.ts = ktime_get_real();
+		ctx.err.int_sts = intdata;
+
+		netdev_warn(dev->net, "HW Error detected: 0x%08x, triggering health report\n",
+			    intdata);
+
+		devlink_health_report(dev->internal_err_reporter, ctx.msg, &ctx);
 	} else {
 		netdev_warn(dev->net,
 			    "unexpected interrupt: 0x%08x\n", intdata);
@@ -4705,6 +4907,148 @@ static void intr_complete(struct urb *urb)
 	}
 }
 
+static int lan78xx_dump_regs(struct lan78xx_net *dev, struct devlink_fmsg *fmsg,
+			     const struct lan78xx_reg_map *map, size_t count)
+{
+	int ret, i;
+	u32 val;
+
+	for (i = 0; i < count; i++) {
+		ret = lan78xx_read_reg(dev, map[i].reg, &val);
+		if (ret)
+			return ret;
+		devlink_fmsg_u32_pair_put(fmsg, map[i].name, val);
+	}
+	return 0;
+}
+
+static int lan78xx_fifo_dump(struct devlink_health_reporter *reporter,
+			     struct devlink_fmsg *fmsg, void *priv_ctx,
+			     struct netlink_ext_ack *extack)
+{
+	struct lan78xx_net *dev = devlink_health_reporter_priv(reporter);
+	struct lan78xx_dump_ctx *ctx = priv_ctx;
+
+	/* 1. Context Snapshot:
+	 * Dump the specific counters that triggered the threshold.
+	 * Registers may have changed since the decision was made.
+	 */
+	if (ctx) {
+		devlink_fmsg_string_pair_put(fmsg, "trigger_reason", ctx->msg);
+		devlink_fmsg_u64_pair_put(fmsg, "timestamp_ns",
+					  ktime_to_ns(ctx->ts));
+
+		devlink_fmsg_obj_nest_start(fmsg);
+		devlink_fmsg_u64_pair_put(fmsg, "trigger_delta_pause",
+					  ctx->fifo.delta_pause);
+		devlink_fmsg_u64_pair_put(fmsg, "trigger_delta_rx",
+					  ctx->fifo.delta_rx);
+		devlink_fmsg_u64_pair_put(fmsg, "trigger_delta_hw_drop",
+					  ctx->fifo.delta_hw_drop);
+		devlink_fmsg_u64_pair_put(fmsg, "trigger_delta_sw_rx",
+					  ctx->fifo.delta_sw_rx);
+		devlink_fmsg_obj_nest_end(fmsg);
+	}
+
+	/* USB Speed is critical for interpreting throughput/stall issues */
+	devlink_fmsg_u8_pair_put(fmsg, "usb_speed_enum", dev->udev->speed);
+
+	/* 2. Live Register Dump */
+	return lan78xx_dump_regs(dev, fmsg, lan78xx_fifo_regs,
+				 ARRAY_SIZE(lan78xx_fifo_regs));
+}
+
+static int lan78xx_internal_err_dump(struct devlink_health_reporter *reporter,
+				     struct devlink_fmsg *fmsg, void *priv_ctx,
+				     struct netlink_ext_ack *extack)
+{
+	struct lan78xx_net *dev = devlink_health_reporter_priv(reporter);
+	struct lan78xx_dump_ctx *ctx = priv_ctx;
+
+	/* Interrupt status is "write-1-to-clear" or cleared on read.
+	 * We must dump the value seen by the ISR, not the current register
+	 * value.
+	 */
+	if (ctx) {
+		devlink_fmsg_string_pair_put(fmsg, "trigger_reason", ctx->msg);
+		devlink_fmsg_u64_pair_put(fmsg, "timestamp_ns",
+					  ktime_to_ns(ctx->ts));
+
+		devlink_fmsg_u32_pair_put(fmsg, "trigger_int_sts",
+					  ctx->err.int_sts);
+		devlink_fmsg_u32_pair_put(fmsg, "trigger_int_enp",
+					  ctx->err.int_enp);
+	}
+
+	return lan78xx_dump_regs(dev, fmsg, lan78xx_err_regs,
+				 ARRAY_SIZE(lan78xx_err_regs));
+}
+
+static const struct devlink_health_reporter_ops lan78xx_fifo_ops = {
+	.name = "fifo",
+	.dump = lan78xx_fifo_dump,
+};
+
+static const struct devlink_health_reporter_ops lan78xx_internal_err_ops = {
+	.name = "internal_err",
+	.dump = lan78xx_internal_err_dump,
+};
+
+static int lan78xx_health_init(struct lan78xx_net *dev)
+{
+	dev->fifo_reporter = devlink_health_reporter_create(dev->devlink,
+							    &lan78xx_fifo_ops,
+							    dev);
+	if (IS_ERR(dev->fifo_reporter)) {
+		netdev_warn(dev->net, "Failed to create fifo reporter\n");
+
+		return PTR_ERR(dev->fifo_reporter);
+	}
+
+	dev->internal_err_reporter =
+		devlink_health_reporter_create(dev->devlink,
+					       &lan78xx_internal_err_ops, dev);
+	if (IS_ERR(dev->internal_err_reporter)) {
+		netdev_warn(dev->net, "Failed to create internal_err reporter\n");
+		devlink_health_reporter_destroy(dev->fifo_reporter);
+
+		return PTR_ERR(dev->internal_err_reporter);
+	}
+
+	return 0;
+}
+
+static void lan78xx_health_cleanup(struct lan78xx_net *dev)
+{
+	devlink_health_reporter_destroy(dev->fifo_reporter);
+	devlink_health_reporter_destroy(dev->internal_err_reporter);
+}
+
+static int lan78xx_devlink_info_get(struct devlink *devlink,
+				    struct devlink_info_req *req,
+				    struct netlink_ext_ack *extack)
+{
+	struct lan78xx_devlink_priv *dl_priv = devlink_priv(devlink);
+	struct lan78xx_net *dev = dl_priv->dev;
+	char buf[16];
+
+	snprintf(buf, sizeof(buf), "0x%04X", dev->chipid);
+	devlink_info_version_fixed_put(req,
+				       DEVLINK_INFO_VERSION_GENERIC_ASIC_ID,
+				       buf);
+
+	snprintf(buf, sizeof(buf), "0x%04X", dev->chiprev);
+	devlink_info_version_fixed_put(req,
+				       DEVLINK_INFO_VERSION_GENERIC_ASIC_REV,
+				       buf);
+
+	return 0;
+}
+
+static const struct devlink_ops lan78xx_devlink_ops = {
+	.info_get = lan78xx_devlink_info_get,
+};
+
 static void lan78xx_disconnect(struct usb_interface *intf)
 {
 	struct lan78xx_net *dev;
@@ -4719,6 +5063,13 @@ static void lan78xx_disconnect(struct usb_interface *intf)
 	udev = interface_to_usbdev(intf);
 	net = dev->net;
 
+	lan78xx_health_cleanup(dev);
+	if (dev->devlink) {
+		devlink_unregister(dev->devlink);
+		devlink_free(dev->devlink);
+		dev->devlink = NULL;
+	}
+
 	rtnl_lock();
 	phylink_stop(dev->phylink);
 	phylink_disconnect_phy(dev->phylink);
@@ -4749,6 +5100,30 @@ static void lan78xx_disconnect(struct usb_interface *intf)
 static void lan78xx_tx_timeout(struct net_device *net, unsigned int txqueue)
 {
 	struct lan78xx_net *dev = netdev_priv(net);
+	struct lan78xx_dump_ctx ctx = {0};
+	s64 diff_ms;
+
+	/* Calculate time since last health check */
+	ctx.ts = ktime_get_real();
+	diff_ms = ktime_ms_delta(ctx.ts, dev->snapshot.time);
+
+	/* We rely on the trend data captured during the last valid stat update
+	 * to infer the system state before the crash.
+	 */
+	if (dev->snapshot.last_delta_pause > LAN78XX_STALL_PAUSE_THRESH)
+		ctx.msg = "TX Timeout (Flow Control Storm?)";
+	else if (dev->snapshot.last_delta_drops > LAN78XX_TX_TIMEOUT_DROP_THRESH)
+		ctx.msg = "TX Timeout (FIFO Drop Storm?)";
+	else
+		ctx.msg = "TX Timeout";
+
+	ctx.fifo.delta_pause = dev->snapshot.last_delta_pause;
+	ctx.fifo.delta_hw_drop = dev->snapshot.last_delta_drops;
+
+	netdev_warn(dev->net, "%s (Last stat update: %lld ms ago)\n",
+		    ctx.msg, diff_ms);
+
+	devlink_health_report(dev->fifo_reporter, ctx.msg, &ctx);
 
 	unlink_urbs(dev, &dev->txq);
 	napi_schedule(&dev->napi);
@@ -5157,6 +5532,17 @@ static int lan78xx_probe(struct usb_interface *intf,
 	pm_runtime_set_autosuspend_delay(&udev->dev,
 					 DEFAULT_AUTOSUSPEND_DELAY);
 
+	dev->devlink = devlink_alloc(&lan78xx_devlink_ops,
+				     sizeof(struct lan78xx_devlink_priv),
+				     &udev->dev);
+	if (dev->devlink) {
+		struct lan78xx_devlink_priv *dl_priv = devlink_priv(dev->devlink);
+
+		dl_priv->dev = dev;
+		devlink_register(dev->devlink);
+		lan78xx_health_init(dev);
+	}
+
 	return 0;
 
 phy_uninit:
-- 
2.47.3


