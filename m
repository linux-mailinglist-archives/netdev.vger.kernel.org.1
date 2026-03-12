Return-Path: <netdev+bounces-266860-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sPV2KRslsmnlIwAAu9opvQ
	(envelope-from <netdev+bounces-266860-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 03:29:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 09DA026C391
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 03:29:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8935F31238EF
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 02:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F9A337701E;
	Thu, 12 Mar 2026 02:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="XM7umyfr"
X-Original-To: netdev@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C97375AA5
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 02:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773282494; cv=none; b=o1Gd5ZTrIbD5WxNmOSVMhWM8fmbPI3iEGodN1r14KJDOWt9rLo7XyhNrUH8tEfMgNIfCMNG53GFXJksm1FBPexmuFz2ABbL9C6mgrGj/fk5HRSlCiGjyyOQThH8nx+mQENex17cjbjn7R0HWvVRQ5tRZd4KiRl7BTKv+hytVkAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773282494; c=relaxed/simple;
	bh=qTyqTBP+gvygfdQNgsh1ww2R6LJe7xIZ1nDXBHXcbKk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CkuKietke5UjLCubJvWIzI13JPZYtvz5HXxYukryqlUp/8DdyqKvZmYhp8k3aSSD2Px4sGxIZpzPe0AZBau+AWYiz9dNSo3/WKpe88UuBystn+hWM1eNHpHKNMWsx6kP9XUuW+ur6OIkvCigi848/H8Y5DRId/G58K0wzd2m+og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=XM7umyfr; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1773282489; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=VVL+ZPkoznEvi//ah+R+tFkqZ7uDngtapdTDsxOlacQ=;
	b=XM7umyfrjdeh7LhNIg/Ullyw3PtK3T3PzQejRWy9HVlj2cHkKvhzEmOuHe34kiATie50CWSNfmuG6ZSuEngxKurmwJ98shsqgmX6OsfF7AsZhhpsRB0mgS6w9+22+a5G///YpYhFgk1Z4HoqSwbwfbxIrxGB+3thABN+be02m7U=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0X-mnpfg_1773282487 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 12 Mar 2026 10:28:07 +0800
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
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Dong Yibo <dong100@mucse.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Dust Li <dust.li@linux.alibaba.com>
Subject: [PATCH net-next v29 8/8] eea: introduce callback for ndo_get_stats64
Date: Thu, 12 Mar 2026 10:28:01 +0800
Message-Id: <20260312022801.90699-9-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20260312022801.90699-1-xuanzhuo@linux.alibaba.com>
References: <20260312022801.90699-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: 2825a2ca1173
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-6.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-266860-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.alibaba.com:dkim,linux.alibaba.com:mid,alibaba.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 09DA026C391
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This commit introduces ndo_get_stats64 support.

Reviewed-by: Dust Li <dust.li@linux.alibaba.com>
Reviewed-by: Philo Lu <lulie@linux.alibaba.com>
Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/ethernet/alibaba/eea/eea_net.c | 57 ++++++++++++++++++++++
 drivers/net/ethernet/alibaba/eea/eea_net.h |  5 ++
 2 files changed, 62 insertions(+)

diff --git a/drivers/net/ethernet/alibaba/eea/eea_net.c b/drivers/net/ethernet/alibaba/eea/eea_net.c
index 9d4ac6729d46..9c810275cfff 100644
--- a/drivers/net/ethernet/alibaba/eea/eea_net.c
+++ b/drivers/net/ethernet/alibaba/eea/eea_net.c
@@ -112,6 +112,8 @@ static void eea_bind_q_and_cfg(struct eea_net *enet,
 	struct eea_net_tx *tx;
 	int i;
 
+	spin_lock(&enet->stats_lock);
+
 	enet->cfg = ctx->cfg;
 	enet->rx = ctx->rx;
 	enet->tx = ctx->tx;
@@ -131,6 +133,8 @@ static void eea_bind_q_and_cfg(struct eea_net *enet,
 
 		blk->rx = rx;
 	}
+
+	spin_unlock(&enet->stats_lock);
 }
 
 static void eea_unbind_q_and_cfg(struct eea_net *enet,
@@ -140,6 +144,8 @@ static void eea_unbind_q_and_cfg(struct eea_net *enet,
 	struct eea_net_rx *rx;
 	int i;
 
+	spin_lock(&enet->stats_lock);
+
 	ctx->cfg = enet->cfg;
 	ctx->rx = enet->rx;
 	ctx->tx = enet->tx;
@@ -156,6 +162,8 @@ static void eea_unbind_q_and_cfg(struct eea_net *enet,
 
 		blk->rx = NULL;
 	}
+
+	spin_unlock(&enet->stats_lock);
 }
 
 static void eea_free_rxtx_q_mem(struct eea_net_init_ctx *ctx)
@@ -342,6 +350,50 @@ static int eea_netdev_open(struct net_device *netdev)
 	return err;
 }
 
+static void eea_stats(struct net_device *netdev, struct rtnl_link_stats64 *tot)
+{
+	struct eea_net *enet = netdev_priv(netdev);
+	u64 packets, bytes;
+	u32 start;
+	int i;
+
+	spin_lock(&enet->stats_lock);
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
+	spin_unlock(&enet->stats_lock);
+}
+
 /* resources: ring, buffers, irq */
 int eea_reset_hw_resources(struct eea_net *enet, struct eea_net_init_ctx *ctx)
 {
@@ -349,7 +401,9 @@ int eea_reset_hw_resources(struct eea_net *enet, struct eea_net_init_ctx *ctx)
 	int err, error;
 
 	if (!netif_running(enet->netdev) || !enet->started) {
+		spin_lock(&enet->stats_lock);
 		enet->cfg = ctx->cfg;
+		spin_unlock(&enet->stats_lock);
 		return 0;
 	}
 
@@ -570,6 +624,7 @@ static const struct net_device_ops eea_netdev = {
 	.ndo_stop           = eea_netdev_stop,
 	.ndo_start_xmit     = eea_tx_xmit,
 	.ndo_validate_addr  = eth_validate_addr,
+	.ndo_get_stats64    = eea_stats,
 	.ndo_features_check = passthru_features_check,
 };
 
@@ -603,6 +658,8 @@ static struct eea_net *eea_netdev_alloc(struct eea_device *edev, u32 pairs)
 		return NULL;
 	}
 
+	spin_lock_init(&enet->stats_lock);
+
 	return enet;
 }
 
diff --git a/drivers/net/ethernet/alibaba/eea/eea_net.h b/drivers/net/ethernet/alibaba/eea/eea_net.h
index fa14976aa335..cbfba365ad2a 100644
--- a/drivers/net/ethernet/alibaba/eea/eea_net.h
+++ b/drivers/net/ethernet/alibaba/eea/eea_net.h
@@ -162,6 +162,11 @@ struct eea_net {
 	u32 speed;
 
 	u64 hw_ts_offset;
+
+	/* Protect the tx and rx of struct eea_net, when eea_stats accesses the
+	 * stats from rx and tx queues.
+	 */
+	spinlock_t stats_lock;
 };
 
 int eea_net_probe(struct eea_device *edev);
-- 
2.32.0.3.g01195cf9f


