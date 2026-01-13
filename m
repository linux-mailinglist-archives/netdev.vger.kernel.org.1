Return-Path: <netdev+bounces-249237-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 77AE8D1621A
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 02:19:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E8C1B30092B4
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 01:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1BD326738B;
	Tue, 13 Jan 2026 01:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="werrr3dn"
X-Original-To: netdev@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39367223DCE
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 01:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768267146; cv=none; b=baXK4HG4BHH8pEoLUVMK1aIBbx2EvUmVcy10f2RGL+5HvVQP5e0nM7toqNzlphIipsRcq4owVuzyxzJHunN1YocJAFF5MLAoizjHfbAz16C9l51LXpeu0bI9wwe9/bAuAmmiB49JfLMOwx7scoc1JHA7wriqL46oZ6TXQRAfCmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768267146; c=relaxed/simple;
	bh=EwqCWpKPOvcpHyea4AAjVFb1IglwzqC6vkJz8hzQNTg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BKVI26wioj1cE4jzTixg+vfK+c9sBUhyiMFnyM9905nLDoI9PSkwhcCiz5hwcdD6f/GHqGsGE/0C0TXfkeuqEATSSEmCU9uLN4sSMOYQ1zO4sYdJaDT9FBwPcmY8xuY/9Fa0qzxGUVAL7KlFuU3LM6aq8+nTFnp3U1BX4s136EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=werrr3dn; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1768267143; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=Bx+m3XY9rQ1jrcrBfutv3i2TymR8NvOz1xlwevtMKxA=;
	b=werrr3dnDTqKpKVM3SSCbWWAGFyglslHvbgNh9dYUqpy2yrblgeWYbuSu7FQbQLAo/qTfajTixioxsMnyKKi+WA6AyeR/l5CgfSMeRhfKPz1Uw8pHlSYuLjhTTFi/VmeEmd7IkThMXuQHwmYIobo2H5Wf8IYyOXdw8WnrIHUOOQ=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0Wwz-iO._1768267141 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 13 Jan 2026 09:19:01 +0800
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
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>,
	Dong Yibo <dong100@mucse.com>,
	Dust Li <dust.li@linux.alibaba.com>
Subject: [PATCH net-next v19 6/6] eea: introduce callback for ndo_get_stats64
Date: Tue, 13 Jan 2026 09:18:56 +0800
Message-Id: <20260113011856.65346-7-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20260113011856.65346-1-xuanzhuo@linux.alibaba.com>
References: <20260113011856.65346-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: 74bf171c0aa2
Content-Transfer-Encoding: 8bit

Add basic driver framework for the Alibaba Elastic Ethernet Adapter(EEA).

This commit introduces ndo_get_stats64 support.

Reviewed-by: Dust Li <dust.li@linux.alibaba.com>
Reviewed-by: Philo Lu <lulie@linux.alibaba.com>
Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/ethernet/alibaba/eea/eea_net.c | 47 ++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/net/ethernet/alibaba/eea/eea_net.c b/drivers/net/ethernet/alibaba/eea/eea_net.c
index 2eba43a82ebc..440f5f11e055 100644
--- a/drivers/net/ethernet/alibaba/eea/eea_net.c
+++ b/drivers/net/ethernet/alibaba/eea/eea_net.c
@@ -269,6 +269,52 @@ static int eea_netdev_open(struct net_device *netdev)
 	return err;
 }
 
+static void eea_stats(struct net_device *netdev, struct rtnl_link_stats64 *tot)
+{
+	struct eea_net *enet = netdev_priv(netdev);
+	u64 packets, bytes;
+	u32 start;
+	int i;
+
+	/* This function is protected by RCU. Here uses enet->tx and enet->rx
+	 * to check whether the TX and RX structures are safe to access. In
+	 * eea_free_rxtx_q_mem, before freeing the TX and RX resources, enet->rx
+	 * and enet->tx are set to NULL, and synchronize_net is called.
+	 */
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
+}
+
 /* resources: ring, buffers, irq */
 int eea_reset_hw_resources(struct eea_net *enet, struct eea_net_init_ctx *ctx)
 {
@@ -460,6 +506,7 @@ static const struct net_device_ops eea_netdev = {
 	.ndo_stop           = eea_netdev_stop,
 	.ndo_start_xmit     = eea_tx_xmit,
 	.ndo_validate_addr  = eth_validate_addr,
+	.ndo_get_stats64    = eea_stats,
 	.ndo_features_check = passthru_features_check,
 	.ndo_tx_timeout     = eea_tx_timeout,
 };
-- 
2.32.0.3.g01195cf9f


