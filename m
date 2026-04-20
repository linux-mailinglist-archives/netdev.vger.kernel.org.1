Return-Path: <netdev+bounces-279880-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GHsnMV1y5mlgwgEAu9opvQ
	(envelope-from <netdev+bounces-279880-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 20:37:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C039432F26
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 20:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ABC953218A07
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 17:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8D73A1E70;
	Mon, 20 Apr 2026 17:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BTiSw9by"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDA037E2E4
	for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 17:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776705528; cv=none; b=J25lGzl0yCGOrYa7pYr72Itbscd9KLg5jMfZOV0i8c/MMafaLB6puM76aVCos2byQjr3ZWsGOp710wIYEh2vw0tX+Nvw/RTFJwyxjrHK1CwxpdpE3VM3+682SHRRSYkqQ55vhz3yOfP9EQ0zzAcJ8Fxfyuck3zAdAbrnGhR9v+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776705528; c=relaxed/simple;
	bh=mfLC8LTZIuyG6ptc24aCGPopepV3WDejBpAV0kIlZRA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eFR21tDAt52XLKhlaFLu0YkW4CJVz3LCvYhoIGeWCUvbB7KAuzc3qxUpxJmTyPpqrI4YmGmG6+fS5CBnb6Ib/karTA5+7eLzAak+Val/T9D8/QSw1S6UvRKMTSQm5o9azH5lyIehqFZAtNkW8Y9dgjMoDARGJHsIkwF1aXmi67E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BTiSw9by; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-35d9e67f6dcso6671200a91.1
        for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 10:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776705524; x=1777310324; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tLuGN9kj4clZ/u36KICID9IjU9wR4CZ3+lgYAeaav/4=;
        b=BTiSw9by33WiI5fqw6Uwc3cxEzhm4xNDya3CFASYBWg87tj56fmixTvCh67kM0Y4Lf
         kPUt/uxxnmj2yE6oLaPXWQO9xVvOrYX5Gabq3ywOcktzVNzN/VsHIMgMQ6hUK/q9Et0x
         LHe2BZQLNKPeOPBIAbzqsw2ZYP3ihoP4PDkGdxH1R5f06UgnFouL06d63DRvgsAh8rr+
         UoHxuxdiO6rO3cgWf+2KvbX8agSq15OyvtOrl4ih0+w/kI8l8BFnPJOUSud/yT5FMWaY
         QbqWZOW0Ej/rhVnecjKBsnSV/40cE3xYsceJ3otIfYyi6EzZ52tgjLvlL5eZg1NPmRiF
         PCBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776705524; x=1777310324;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tLuGN9kj4clZ/u36KICID9IjU9wR4CZ3+lgYAeaav/4=;
        b=OAPLcoJZbxbuFuISohriZJugD2sqbNuVhL0lInmPofKDSvhsIYZMZSAhRFz5ERGpfj
         Cve7OBwlMTABYASeGIjzyN8ESjxedqMQBwrH+umAeZfE6dc1d373XNoWW8kxU39Fn00e
         d3Xhd+SAzPRvXMrIGsRblecejbXY0WygwURts3QL+fPk7IFeyeqkJm8X6sybBd3v+mjk
         we6T6xmn7OvebCD3jlBVJ7VwrXF9I3tzij389XYfhN2Dv88zm2reiyNVVuKu+B3+PZx3
         +wWCySGcV921uqBhqklAFWp8JRGFVdnERyCTcsKtDmOQ09ecU0Ll4adwpTdYUcdC7hlf
         h6gQ==
X-Gm-Message-State: AOJu0YxHqjtsX+NQPAI/zzYy5kwu7+way0Yx2L81ivcKChhVLpqO1Rtl
	wURtK4rOt7JjMtBArHNSLljzHSseu5t8+eSfzGjk6LFTznym+0QPJhmUw48frq6iUkwtRNYynJJ
	uhmfXzXiO7PonW2zb4JYmitBdSW1XjlPWtnqOpQkb0beQm1XB2LGGF5nWqL6lHiXKpr4EwD3XST
	QmgHukn75Nu0eMqVK8hrEmqS5phTjrNWum+V4Si2pI9GYOmwoH4PgxSR6WK9Mir0E=
X-Received: from pjl8.prod.google.com ([2002:a17:90b:2f88:b0:35d:d5e0:fc1d])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4e85:b0:35f:b5df:450 with SMTP id 98e67ed59e1d1-3614048a226mr15714705a91.19.1776705523871;
 Mon, 20 Apr 2026 10:18:43 -0700 (PDT)
Date: Mon, 20 Apr 2026 17:18:35 +0000
In-Reply-To: <20260420171837.455487-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260420171837.455487-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.54.0.rc1.555.g9c883467ad-goog
Message-ID: <20260420171837.455487-3-hramamurthy@google.com>
Subject: [PATCH net 2/4] gve: Fix backward stats when interface goes down or
 configuration is adjusted
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: joshwash@google.com, hramamurthy@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	willemb@google.com, maolson@google.com, nktgrg@google.com, jfraker@google.com, 
	ziweixiao@google.com, jacob.e.keller@intel.com, pkaligineedi@google.com, 
	shailend@google.com, jordanrhee@google.com, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Debarghya Kundu <debarghyak@google.com>, 
	Pin-yen Lin <treapking@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-279880-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hramamurthy@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2C039432F26
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Debarghya Kundu <debarghyak@google.com>

gve_get_base_stats() sets all the stats to 0, so the stats go backwards
when interface goes down or configuration is adjusted.

Fix this by persisting baseline stats across interface down.

This was discovered by drivers/net/stats.py selftest.

Cc: stable@vger.kernel.org
Fixes: 2e5e0932dff5 ("gve: add support for basic queue stats")
Signed-off-by: Debarghya Kundu <debarghyak@google.com>
Signed-off-by: Pin-yen Lin <treapking@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
 drivers/net/ethernet/google/gve/gve.h      |  6 ++
 drivers/net/ethernet/google/gve/gve_main.c | 64 +++++++++++++++++++---
 2 files changed, 63 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index cbdf3a842cfe..ff7797043908 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -794,6 +794,10 @@ struct gve_ptp {
 	struct gve_priv *priv;
 };
 
+struct gve_ring_err_stats {
+	u64 rx_alloc_fails;
+};
+
 struct gve_priv {
 	struct net_device *dev;
 	struct gve_tx_ring *tx; /* array of tx_cfg.num_queues */
@@ -882,6 +886,8 @@ struct gve_priv {
 	unsigned long service_task_flags;
 	unsigned long state_flags;
 
+	struct gve_ring_err_stats base_ring_err_stats;
+	struct rtnl_link_stats64 base_net_stats;
 	struct gve_stats_report *stats_report;
 	u64 stats_report_len;
 	dma_addr_t stats_report_bus; /* dma address for the stats report */
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 675382e9756c..8617782791e0 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -105,9 +105,22 @@ static netdev_tx_t gve_start_xmit(struct sk_buff *skb, struct net_device *dev)
 		return gve_tx_dqo(skb, dev);
 }
 
-static void gve_get_stats(struct net_device *dev, struct rtnl_link_stats64 *s)
+static void gve_add_base_stats(struct gve_priv *priv,
+			       struct rtnl_link_stats64 *s)
+{
+	struct rtnl_link_stats64 *base_stats = &priv->base_net_stats;
+
+	s->rx_packets += base_stats->rx_packets;
+	s->rx_bytes += base_stats->rx_bytes;
+	s->rx_dropped += base_stats->rx_dropped;
+	s->tx_packets += base_stats->tx_packets;
+	s->tx_bytes += base_stats->tx_bytes;
+	s->tx_dropped += base_stats->tx_dropped;
+}
+
+static void gve_get_ring_stats(struct gve_priv *priv,
+			       struct rtnl_link_stats64 *s)
 {
-	struct gve_priv *priv = netdev_priv(dev);
 	unsigned int start;
 	u64 packets, bytes;
 	int num_tx_queues;
@@ -142,6 +155,14 @@ static void gve_get_stats(struct net_device *dev, struct rtnl_link_stats64 *s)
 	}
 }
 
+static void gve_get_stats(struct net_device *dev, struct rtnl_link_stats64 *s)
+{
+	struct gve_priv *priv = netdev_priv(dev);
+
+	gve_get_ring_stats(priv, s);
+	gve_add_base_stats(priv, s);
+}
+
 static int gve_alloc_flow_rule_caches(struct gve_priv *priv)
 {
 	struct gve_flow_rules_cache *flow_rules_cache = &priv->flow_rules_cache;
@@ -1493,6 +1514,23 @@ static int gve_queues_stop(struct gve_priv *priv)
 	return gve_reset_recovery(priv, false);
 }
 
+static void gve_get_ring_err_stats(struct gve_priv *priv,
+				   struct gve_ring_err_stats *err_stats)
+{
+	int ring;
+
+	for (ring = 0; ring < priv->rx_cfg.num_queues; ring++) {
+		unsigned int start;
+		struct gve_rx_ring *rx = &priv->rx[ring];
+
+		do {
+			start = u64_stats_fetch_begin(&rx->statss);
+			err_stats->rx_alloc_fails +=
+				rx->rx_skb_alloc_fail + rx->rx_buf_alloc_fail;
+		} while (u64_stats_fetch_retry(&rx->statss, start));
+	}
+}
+
 static int gve_close(struct net_device *dev)
 {
 	struct gve_priv *priv = netdev_priv(dev);
@@ -1502,6 +1540,10 @@ static int gve_close(struct net_device *dev)
 	if (err)
 		return err;
 
+	/* Save ring queue and err stats before closing the interface */
+	gve_get_ring_stats(priv, &priv->base_net_stats);
+	gve_get_ring_err_stats(priv, &priv->base_ring_err_stats);
+
 	gve_queues_mem_remove(priv);
 	return 0;
 }
@@ -2743,12 +2785,20 @@ static void gve_get_base_stats(struct net_device *dev,
 			       struct netdev_queue_stats_rx *rx,
 			       struct netdev_queue_stats_tx *tx)
 {
-	rx->packets = 0;
-	rx->bytes = 0;
-	rx->alloc_fail = 0;
+	const struct gve_ring_err_stats *base_err_stats;
+	const struct rtnl_link_stats64 *base_stats;
+	struct gve_priv *priv;
+
+	priv = netdev_priv(dev);
+	base_stats = &priv->base_net_stats;
+	base_err_stats = &priv->base_ring_err_stats;
+
+	rx->packets = base_stats->rx_packets;
+	rx->bytes = base_stats->rx_bytes;
+	rx->alloc_fail = base_err_stats->rx_alloc_fails;
 
-	tx->packets = 0;
-	tx->bytes = 0;
+	tx->packets = base_stats->tx_packets;
+	tx->bytes = base_stats->tx_bytes;
 }
 
 static const struct netdev_stat_ops gve_stat_ops = {
-- 
2.54.0.rc0.605.g598a273b03-goog


