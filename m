Return-Path: <netdev+bounces-283898-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4IsQGgmy+GkdzAIAu9opvQ
	(envelope-from <netdev+bounces-283898-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 16:49:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 055CB4C00E1
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 16:49:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EF52F301FA6D
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 14:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 275AB3E0246;
	Mon,  4 May 2026 14:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="GHQjL6MQ"
X-Original-To: netdev@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD163DF01B
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 14:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777905895; cv=none; b=GWn9bZfY4TA8cEK+jTA9hr/HokVahAfqdwxDJrThcROLdmtCP0eaokLQ06I3zmSBw9qn8lQoB4hbZzRRoVbTA5JIVrXRgFG8057YsgLzh683xi3kMQixe3fjAYTDKSRVo55s+FHxff9bdxpSes+xVRJ5M4DuymlWOglDLdv/DHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777905895; c=relaxed/simple;
	bh=UwTPKZ9U5RyltualaESj+H2pmoNh9LxQzFuLs2BgRKQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lTgh7dQrEBqR5oYZo0ulIl0X5pTNNGg67+J4IlvgWPSjGK2+ujP0/CvbVSxGFnnFmYtZIgfQN2wz6Q3YMI+vWBvvJScKt8WHrbap8ZGPfTIq5WXaSrq9kdApow4ojOPbrgjdnWoLKEFTGl+7kTD0GVVaVwHyfkWS9K7bz/pb0EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=GHQjL6MQ; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1777905888; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=OGtMc66oNLpkwIHuzu5GMG2cuWIFsSw8B7N2CBbI18c=;
	b=GHQjL6MQ3k1OZZMAneDx/Ry4yKZLNNSecLvl0U+KTHjS5ioctuFW9qyCeRD3ebtIcy6RObj9/urT1TqdPosgU4q8K/tF0Atot2rPz1BrKdDNS6QhQSH7FNa5MTyArXwN1+ImwdUMK3UwcTzuMvTNnFjItEoP41AM88OyLduDf7I=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0X2D2Wpt_1777905886;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0X2D2Wpt_1777905886 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 04 May 2026 22:44:47 +0800
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
	Mingyu Wang <25181214217@stu.xidian.edu.cn>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Dust Li <dust.li@linux.alibaba.com>
Subject: [PATCH net-next v42 8/8] eea: introduce callback for ndo_get_stats64 and register netdev
Date: Mon,  4 May 2026 22:44:39 +0800
Message-Id: <20260504144439.29570-9-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20260504144439.29570-1-xuanzhuo@linux.alibaba.com>
References: <20260504144439.29570-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: 9e749460a759
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 055CB4C00E1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-6.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-283898-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,linux.alibaba.com,linux.dev,mucse.com,stu.xidian.edu.cn,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xuanzhuo@linux.alibaba.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.996];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.alibaba.com:dkim,linux.alibaba.com:mid,alibaba.com:email]

This commit adds support for ndo_get_stats64 to provide accurate
interface statistics. With the TX and RX data paths now fully functional,
it is appropriate to register the netdevice and expose the interface to
userspace.

Reviewed-by: Dust Li <dust.li@linux.alibaba.com>
Reviewed-by: Philo Lu <lulie@linux.alibaba.com>
Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/ethernet/alibaba/eea/eea_net.c | 82 ++++++++++++++++++++--
 drivers/net/ethernet/alibaba/eea/eea_net.h |  5 ++
 2 files changed, 83 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/alibaba/eea/eea_net.c b/drivers/net/ethernet/alibaba/eea/eea_net.c
index c22fdf923130..ade079128b05 100644
--- a/drivers/net/ethernet/alibaba/eea/eea_net.c
+++ b/drivers/net/ethernet/alibaba/eea/eea_net.c
@@ -112,6 +112,11 @@ static void eea_bind_q_and_cfg(struct eea_net *enet,
 	struct eea_net_tx *tx;
 	int i;
 
+	/* Since 'ndo_get_stats64' is not called in softirq context, there is no
+	 * need to use 'spin_lock_bh'.
+	 */
+	spin_lock(&enet->stats_lock);
+
 	enet->cfg = ctx->cfg;
 	enet->rx = ctx->rx;
 	enet->tx = ctx->tx;
@@ -131,6 +136,8 @@ static void eea_bind_q_and_cfg(struct eea_net *enet,
 
 		blk->rx = rx;
 	}
+
+	spin_unlock(&enet->stats_lock);
 }
 
 static void eea_unbind_q_and_cfg(struct eea_net *enet,
@@ -140,6 +147,8 @@ static void eea_unbind_q_and_cfg(struct eea_net *enet,
 	struct eea_net_rx *rx;
 	int i;
 
+	spin_lock(&enet->stats_lock);
+
 	ctx->cfg = enet->cfg;
 	ctx->rx = enet->rx;
 	ctx->tx = enet->tx;
@@ -156,6 +165,8 @@ static void eea_unbind_q_and_cfg(struct eea_net *enet,
 
 		blk->rx = NULL;
 	}
+
+	spin_unlock(&enet->stats_lock);
 }
 
 static void eea_free_rxtx_q_mem(struct eea_net_init_ctx *ctx)
@@ -340,6 +351,59 @@ static int eea_netdev_open(struct net_device *netdev)
 	return err;
 }
 
+/* Statistics may be reset to zero upon device reset. This is expected behavior
+ * for now and will be addressed in the future.
+ */
+static void eea_stats(struct net_device *netdev, struct rtnl_link_stats64 *tot)
+{
+	struct eea_net *enet = netdev_priv(netdev);
+	u64 packets, bytes, drop, lerr;
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
+				drop = u64_stats_read(&rx->stats.drops);
+				lerr = u64_stats_read(&rx->stats.length_errors);
+			} while (u64_stats_fetch_retry(&rx->stats.syncp,
+						       start));
+
+			tot->rx_packets       += packets;
+			tot->rx_bytes         += bytes;
+			tot->rx_dropped       += drop;
+			tot->rx_length_errors += lerr;
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
+				drop = u64_stats_read(&tx->stats.drops);
+			} while (u64_stats_fetch_retry(&tx->stats.syncp,
+						       start));
+
+			tot->tx_packets += packets;
+			tot->tx_bytes   += bytes;
+			tot->tx_dropped += drop;
+		}
+	}
+
+	spin_unlock(&enet->stats_lock);
+}
+
 /* resources: ring, buffers, irq */
 int eea_reset_hw_resources(struct eea_net *enet, struct eea_net_init_ctx *ctx)
 {
@@ -347,7 +411,9 @@ int eea_reset_hw_resources(struct eea_net *enet, struct eea_net_init_ctx *ctx)
 	int err, error;
 
 	if (!netif_running(enet->netdev) || !enet->started) {
+		spin_lock(&enet->stats_lock);
 		enet->cfg = ctx->cfg;
+		spin_unlock(&enet->stats_lock);
 		return 0;
 	}
 
@@ -606,6 +672,7 @@ static const struct net_device_ops eea_netdev = {
 	.ndo_stop           = eea_netdev_stop,
 	.ndo_start_xmit     = eea_tx_xmit,
 	.ndo_validate_addr  = eth_validate_addr,
+	.ndo_get_stats64    = eea_stats,
 	.ndo_features_check = passthru_features_check,
 };
 
@@ -639,6 +706,8 @@ static struct eea_net *eea_netdev_alloc(struct eea_device *edev, u32 pairs)
 		return NULL;
 	}
 
+	spin_lock_init(&enet->stats_lock);
+
 	return enet;
 }
 
@@ -724,11 +793,13 @@ int eea_net_probe(struct eea_device *edev)
 
 	eea_update_ts_off(edev, enet);
 
-	netdev_dbg(enet->netdev, "eea probe success.\n");
+	netif_carrier_off(enet->netdev);
 
-	/* Queue TX/RX implementation is still in progress. register_netdev is
-	 * deferred until these are completed in subsequent commits.
-	 */
+	err = register_netdev(enet->netdev);
+	if (err)
+		goto err_reset_dev;
+
+	netdev_dbg(enet->netdev, "eea probe success.\n");
 
 	return 0;
 
@@ -780,6 +851,8 @@ void eea_net_remove(struct eea_device *edev, bool ha)
 		return;
 	}
 
+	unregister_netdev(netdev);
+
 	if (!enet->wait_pci_ready) {
 		eea_device_reset(edev);
 		eea_destroy_adminq(enet);
@@ -800,6 +873,7 @@ void eea_net_shutdown(struct eea_device *edev)
 	rtnl_lock();
 
 	netif_device_detach(netdev);
+	dev_close(netdev);
 
 	if (!enet->wait_pci_ready) {
 		eea_device_reset(edev);
diff --git a/drivers/net/ethernet/alibaba/eea/eea_net.h b/drivers/net/ethernet/alibaba/eea/eea_net.h
index 6a5b2f908c76..848bb90bccf8 100644
--- a/drivers/net/ethernet/alibaba/eea/eea_net.h
+++ b/drivers/net/ethernet/alibaba/eea/eea_net.h
@@ -165,6 +165,11 @@ struct eea_net {
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


