Return-Path: <netdev+bounces-255791-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +B5PCONpgGlA7wIAu9opvQ
	(envelope-from <netdev+bounces-255791-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 10:09:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C915C9EE8
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 10:09:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 68E813027105
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 09:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45AD73559CF;
	Mon,  2 Feb 2026 09:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="AhBFKGq9"
X-Original-To: netdev@vger.kernel.org
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A5534D3AA
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 09:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770023216; cv=none; b=kLYdo1URmVgzXLCOykzkGKLF/vUC8LVqUf4LfIqmhdmQmOOVFyRwKXo3C2uIx7pXAB59xM4P6I/xmeunWb1AM9+NpKMo3s7I2iiQe8P2JNmDhyIdCbmo2xVdrT88TxaK64GLGgTywchPHO0mJ6pPGuOgrb83iG56uF3QrD3G7kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770023216; c=relaxed/simple;
	bh=zLTvr8O2d5Qz/b/+MVtDzVvLk51TgnrAoGuokKmWMz4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JXsm/YE9Bo33IYYoQGatRHMg8MAnoiUCpQgJXn+jd9Pg7Habn0DyLmWHZ6WmsFU6BUzt801OMwhh58Vzi3VNzPHOqaSERfbQZkvAVIF9hFqWARHkPigsXlGWFIhGlP3rOY/oZeduu0psSdiCUWf2+TUu+FqmAlVqlF+O4DN7km4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=AhBFKGq9; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1770023205; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=f0oqBlQP5HV65C6lCdYc2vIeDRyEyuFiIZ6SDj7SIjo=;
	b=AhBFKGq9iiK/l1XB/sfQWSxLt/nqRZZNT5DknCzasKz02wHCTRErsjCllkyy1MRgNgORP0PrFzLrpW3xK5X4egw17L0jxlqIjB4iXAVIV+zaDHHlfnaIiB5eBke1CdmNP53pxIEFBK7UPwxFCWSWPayFGceIl0Bdc8tGeB4Mkck=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WyLa081_1770023203 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 02 Feb 2026 17:06:44 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	Philo Lu <lulie@linux.alibaba.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Dong Yibo <dong100@mucse.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>,
	Dust Li <dust.li@linux.alibaba.com>
Subject: [PATCH net-next v25 6/6] eea: introduce callback for ndo_get_stats64
Date: Mon,  2 Feb 2026 17:06:38 +0800
Message-Id: <20260202090638.46836-7-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20260202090638.46836-1-xuanzhuo@linux.alibaba.com>
References: <20260202090638.46836-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: b640e40bbdf7
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-6.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-255791-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,linux.alibaba.com,linux.dev,mucse.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xuanzhuo@linux.alibaba.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.alibaba.com:mid,linux.alibaba.com:dkim,alibaba.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7C915C9EE8
X-Rspamd-Action: no action

This commit introduces ndo_get_stats64 support.

Reviewed-by: Dust Li <dust.li@linux.alibaba.com>
Reviewed-by: Philo Lu <lulie@linux.alibaba.com>
Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/ethernet/alibaba/eea/eea_net.c | 51 ++++++++++++++++++++++
 drivers/net/ethernet/alibaba/eea/eea_net.h |  5 +++
 2 files changed, 56 insertions(+)

diff --git a/drivers/net/ethernet/alibaba/eea/eea_net.c b/drivers/net/ethernet/alibaba/eea/eea_net.c
index e225ac24726f..8783de5e3682 100644
--- a/drivers/net/ethernet/alibaba/eea/eea_net.c
+++ b/drivers/net/ethernet/alibaba/eea/eea_net.c
@@ -27,8 +27,10 @@ static int enet_bind_new_q_and_cfg(struct eea_net *enet,
 
 	enet->cfg = ctx->cfg;
 
+	spin_lock(&enet->stats_lock);
 	enet->rx = ctx->rx;
 	enet->tx = ctx->tx;
+	spin_unlock(&enet->stats_lock);
 
 	for (i = 0; i < ctx->cfg.rx_ring_num; i++) {
 		rx = ctx->rx[i];
@@ -57,11 +59,13 @@ static void eea_free_rxtx_q_mem(struct eea_net *enet)
 	struct eea_net_tx *tx, *tx_array;
 	int i;
 
+	spin_lock(&enet->stats_lock);
 	rx_array = enet->rx;
 	tx_array = enet->tx;
 
 	enet->rx = NULL;
 	enet->tx = NULL;
+	spin_unlock(&enet->stats_lock);
 
 	for (i = 0; i < enet->cfg.rx_ring_num; i++) {
 		rx = rx_array[i];
@@ -260,6 +264,50 @@ static int eea_netdev_open(struct net_device *netdev)
 	return err;
 }
 
+static void eea_stats(struct net_device *netdev, struct rtnl_link_stats64 *tot)
+{
+	struct eea_net *enet = netdev_priv(netdev);
+	u64 packets, bytes;
+	u32 start;
+	int i;
+
+	spin_lock_bh(&enet->stats_lock);
+
+	if (enet->rx) {
+		for (i = 0; i < enet->cfg.rx_ring_num; i++) {
+			struct eea_net_rx *rx = enet->rx[i];
+
+			do {
+				start = u64_stats_fetch_begin(&rx->stats.syncp);
+				packets = u64_stats_read(&rx->stats.packets);
+				bytes = u64_stats_read(&rx->stats.bytes);
+			} while (u64_stats_fetch_retry(&rx->stats.syncp,
+						       start));
+
+			tot->rx_packets += packets;
+			tot->rx_bytes   += bytes;
+		}
+	}
+
+	if (enet->tx) {
+		for (i = 0; i < enet->cfg.tx_ring_num; i++) {
+			struct eea_net_tx *tx = &enet->tx[i];
+
+			do {
+				start = u64_stats_fetch_begin(&tx->stats.syncp);
+				packets = u64_stats_read(&tx->stats.packets);
+				bytes = u64_stats_read(&tx->stats.bytes);
+			} while (u64_stats_fetch_retry(&tx->stats.syncp,
+						       start));
+
+			tot->tx_packets += packets;
+			tot->tx_bytes   += bytes;
+		}
+	}
+
+	spin_unlock_bh(&enet->stats_lock);
+}
+
 /* resources: ring, buffers, irq */
 int eea_reset_hw_resources(struct eea_net *enet, struct eea_net_init_ctx *ctx)
 {
@@ -467,6 +515,7 @@ static const struct net_device_ops eea_netdev = {
 	.ndo_stop           = eea_netdev_stop,
 	.ndo_start_xmit     = eea_tx_xmit,
 	.ndo_validate_addr  = eth_validate_addr,
+	.ndo_get_stats64    = eea_stats,
 	.ndo_features_check = passthru_features_check,
 	.ndo_tx_timeout     = eea_tx_timeout,
 };
@@ -492,6 +541,8 @@ static struct eea_net *eea_netdev_alloc(struct eea_device *edev, u32 pairs)
 	enet->edev = edev;
 	edev->enet = enet;
 
+	spin_lock_init(&enet->stats_lock);
+
 	return enet;
 }
 
diff --git a/drivers/net/ethernet/alibaba/eea/eea_net.h b/drivers/net/ethernet/alibaba/eea/eea_net.h
index 77c8d24639b7..2839822bd2f6 100644
--- a/drivers/net/ethernet/alibaba/eea/eea_net.h
+++ b/drivers/net/ethernet/alibaba/eea/eea_net.h
@@ -156,6 +156,11 @@ struct eea_net {
 	u32 speed;
 
 	u64 hw_ts_offset;
+
+	/* Protect the tx and rx of struct eea_net, when eea_stats accesses the
+	 * stats from rx and tx queues.
+	 */
+	spinlock_t stats_lock;
 };
 
 int eea_tx_resize(struct eea_net *enet, struct eea_net_tx *tx, u32 ring_num);
-- 
2.32.0.3.g01195cf9f


