Return-Path: <netdev+bounces-236647-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D07D3C3E8C1
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 06:50:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0219188BA74
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 05:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA42298CDC;
	Fri,  7 Nov 2025 05:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="xKHy0IyR"
X-Original-To: netdev@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FA4287518
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 05:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762494605; cv=none; b=Xt9gqfgSTCQpA98iSyu4LcmGtKJieL7VSUwsjsUxCF+xt/WczVTpIeQQ02O6m9xm7Nl088VZT9vHmYyJqwiijS4Pa2YwdIEcPu0xgKzAgoB5JvOpdzrNdFhTCUpdSgxW6MhTzuqcAnHiqhw/9zEyxcv6vC7rj0+ztZDHFNBneoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762494605; c=relaxed/simple;
	bh=kCnivUl+d+qJNDiiJ2RxSLuY9t7v4uimNNjuvxk+Ue0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r/Lbd+hjgUL1UcVVeN0ItiemGE/cFYjXrcgYDPzq0PP95b5ddy88AAlsH9PQu7C1Xe7o7ExqnFn4tt4Sa7pb8RgR9FewIp8ddN7ydj3tyCAQduD8NPV8uu0OLn8B6BZJc48o9C0SE4UWsFAtvdBe9egG8FYpRkfVqxTCHYbHNLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=xKHy0IyR; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1762494600; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=z51+222yOfw3Bd2QRb2U83q199TU6O/pAa/HV7RWXs4=;
	b=xKHy0IyRfIr8rezkzFjIFhXf3DAd3qb+5s9e0QV+RBe3P3/6cJxmk/ES/0/ODvkZnV86WydQMN7gxFgxgyWxp3K2zeOIjDq6tB2gEp2bAnw382fgOFH1uxXxNdQhOEt1ksDI+6qMt2WSEkAfLWIti+V1rj7HeapmJUTnnNHV7kY=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WrrsOA8_1762494598 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 07 Nov 2025 13:49:59 +0800
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
	Lukas Bulwahn <lukas.bulwahn@redhat.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Vivian Wang <wangruikang@iscas.ac.cn>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	Dust Li <dust.li@linux.alibaba.com>,
	Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH net-next v11 5/5] eea: introduce ethtool support
Date: Fri,  7 Nov 2025 13:49:55 +0800
Message-Id: <20251107054955.16236-6-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20251107054955.16236-1-xuanzhuo@linux.alibaba.com>
References: <20251107054955.16236-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: 1f966a3f38ba
Content-Transfer-Encoding: 8bit

Add basic driver framework for the Alibaba Elastic Ethernet Adapter(EEA).

This commit introduces ethtool support.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Dust Li <dust.li@linux.alibaba.com>
Reviewed-by: Philo Lu <lulie@linux.alibaba.com>
Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/ethernet/alibaba/eea/Makefile     |   1 +
 .../net/ethernet/alibaba/eea/eea_ethtool.c    | 276 ++++++++++++++++++
 .../net/ethernet/alibaba/eea/eea_ethtool.h    |  50 ++++
 drivers/net/ethernet/alibaba/eea/eea_net.c    |   2 +
 drivers/net/ethernet/alibaba/eea/eea_net.h    |   5 +
 drivers/net/ethernet/alibaba/eea/eea_rx.c     |  29 +-
 drivers/net/ethernet/alibaba/eea/eea_tx.c     |  24 +-
 7 files changed, 383 insertions(+), 4 deletions(-)
 create mode 100644 drivers/net/ethernet/alibaba/eea/eea_ethtool.c
 create mode 100644 drivers/net/ethernet/alibaba/eea/eea_ethtool.h

diff --git a/drivers/net/ethernet/alibaba/eea/Makefile b/drivers/net/ethernet/alibaba/eea/Makefile
index fa34a005fa01..8f8fbb8d2d9a 100644
--- a/drivers/net/ethernet/alibaba/eea/Makefile
+++ b/drivers/net/ethernet/alibaba/eea/Makefile
@@ -4,5 +4,6 @@ eea-y := eea_ring.o \
 	eea_net.o \
 	eea_pci.o \
 	eea_adminq.o \
+	eea_ethtool.o \
 	eea_tx.o \
 	eea_rx.o
diff --git a/drivers/net/ethernet/alibaba/eea/eea_ethtool.c b/drivers/net/ethernet/alibaba/eea/eea_ethtool.c
new file mode 100644
index 000000000000..16621c1bec2d
--- /dev/null
+++ b/drivers/net/ethernet/alibaba/eea/eea_ethtool.c
@@ -0,0 +1,276 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Driver for Alibaba Elastic Ethernet Adapter.
+ *
+ * Copyright (C) 2025 Alibaba Inc.
+ */
+
+#include <linux/ethtool.h>
+#include <linux/ethtool_netlink.h>
+
+#include "eea_adminq.h"
+
+struct eea_stat_desc {
+	char desc[ETH_GSTRING_LEN];
+	size_t offset;
+};
+
+#define EEA_TX_STAT(m)	{#m, offsetof(struct eea_tx_stats, m)}
+#define EEA_RX_STAT(m)	{#m, offsetof(struct eea_rx_stats, m)}
+
+static const struct eea_stat_desc eea_rx_stats_desc[] = {
+	EEA_RX_STAT(descs),
+	EEA_RX_STAT(kicks),
+};
+
+static const struct eea_stat_desc eea_tx_stats_desc[] = {
+	EEA_TX_STAT(descs),
+	EEA_TX_STAT(kicks),
+};
+
+#define EEA_TX_STATS_LEN	ARRAY_SIZE(eea_tx_stats_desc)
+#define EEA_RX_STATS_LEN	ARRAY_SIZE(eea_rx_stats_desc)
+
+static void eea_get_drvinfo(struct net_device *netdev,
+			    struct ethtool_drvinfo *info)
+{
+	struct eea_net *enet = netdev_priv(netdev);
+	struct eea_device *edev = enet->edev;
+
+	strscpy(info->driver,   KBUILD_MODNAME,     sizeof(info->driver));
+	strscpy(info->bus_info, eea_pci_name(edev), sizeof(info->bus_info));
+}
+
+static void eea_get_ringparam(struct net_device *netdev,
+			      struct ethtool_ringparam *ring,
+			      struct kernel_ethtool_ringparam *kernel_ring,
+			      struct netlink_ext_ack *extack)
+{
+	struct eea_net *enet = netdev_priv(netdev);
+
+	ring->rx_max_pending = enet->cfg_hw.rx_ring_depth;
+	ring->tx_max_pending = enet->cfg_hw.tx_ring_depth;
+	ring->rx_pending = enet->cfg.rx_ring_depth;
+	ring->tx_pending = enet->cfg.tx_ring_depth;
+
+	kernel_ring->tcp_data_split = enet->cfg.split_hdr ?
+				      ETHTOOL_TCP_DATA_SPLIT_ENABLED :
+				      ETHTOOL_TCP_DATA_SPLIT_DISABLED;
+}
+
+static int eea_set_ringparam(struct net_device *netdev,
+			     struct ethtool_ringparam *ring,
+			     struct kernel_ethtool_ringparam *kernel_ring,
+			     struct netlink_ext_ack *extack)
+{
+	struct eea_net *enet = netdev_priv(netdev);
+	struct eea_net_init_ctx ctx;
+	bool need_update = false;
+	struct eea_net_cfg *cfg;
+	bool sh;
+
+	enet_init_ctx(enet, &ctx);
+
+	cfg = &ctx.cfg;
+
+	if (ring->rx_pending != cfg->rx_ring_depth)
+		need_update = true;
+
+	if (ring->tx_pending != cfg->tx_ring_depth)
+		need_update = true;
+
+	sh = kernel_ring->tcp_data_split == ETHTOOL_TCP_DATA_SPLIT_ENABLED;
+	if (sh != !!(cfg->split_hdr))
+		need_update = true;
+
+	if (!need_update)
+		return 0;
+
+	cfg->rx_ring_depth = ring->rx_pending;
+	cfg->tx_ring_depth = ring->tx_pending;
+
+	cfg->split_hdr = sh ? enet->cfg_hw.split_hdr : 0;
+
+	return eea_reset_hw_resources(enet, &ctx);
+}
+
+static int eea_set_channels(struct net_device *netdev,
+			    struct ethtool_channels *channels)
+{
+	struct eea_net *enet = netdev_priv(netdev);
+	u16 queue_pairs = channels->combined_count;
+	struct eea_net_init_ctx ctx;
+	struct eea_net_cfg *cfg;
+
+	enet_init_ctx(enet, &ctx);
+
+	cfg = &ctx.cfg;
+
+	cfg->rx_ring_num = queue_pairs;
+	cfg->tx_ring_num = queue_pairs;
+
+	return eea_reset_hw_resources(enet, &ctx);
+}
+
+static void eea_get_channels(struct net_device *netdev,
+			     struct ethtool_channels *channels)
+{
+	struct eea_net *enet = netdev_priv(netdev);
+
+	channels->combined_count = enet->cfg.rx_ring_num;
+	channels->max_combined   = enet->cfg_hw.rx_ring_num;
+}
+
+static void eea_get_strings(struct net_device *netdev, u32 stringset, u8 *data)
+{
+	struct eea_net *enet = netdev_priv(netdev);
+	u8 *p = data;
+	u32 i, j;
+
+	if (stringset != ETH_SS_STATS)
+		return;
+
+	for (i = 0; i < enet->cfg.rx_ring_num; i++) {
+		for (j = 0; j < EEA_RX_STATS_LEN; j++)
+			ethtool_sprintf(&p, "rx%u_%s", i,
+					eea_rx_stats_desc[j].desc);
+	}
+
+	for (i = 0; i < enet->cfg.tx_ring_num; i++) {
+		for (j = 0; j < EEA_TX_STATS_LEN; j++)
+			ethtool_sprintf(&p, "tx%u_%s", i,
+					eea_tx_stats_desc[j].desc);
+	}
+}
+
+static int eea_get_sset_count(struct net_device *netdev, int sset)
+{
+	struct eea_net *enet = netdev_priv(netdev);
+
+	if (sset != ETH_SS_STATS)
+		return -EOPNOTSUPP;
+
+	return enet->cfg.rx_ring_num * EEA_RX_STATS_LEN +
+		enet->cfg.tx_ring_num * EEA_TX_STATS_LEN;
+}
+
+static void eea_stats_fill_for_q(struct u64_stats_sync *syncp, u32 num,
+				 const struct eea_stat_desc *desc,
+				 u64 *data, u32 idx)
+{
+	void *stats_base = syncp;
+	u32 start, i;
+
+	do {
+		start = u64_stats_fetch_begin(syncp);
+		for (i = 0; i < num; i++)
+			data[idx + i] =
+				u64_stats_read(stats_base + desc[i].offset);
+
+	} while (u64_stats_fetch_retry(syncp, start));
+}
+
+static void eea_get_ethtool_stats(struct net_device *netdev,
+				  struct ethtool_stats *stats, u64 *data)
+{
+	struct eea_net *enet = netdev_priv(netdev);
+	u32 i, idx = 0;
+
+	for (i = 0; i < enet->cfg.rx_ring_num; i++) {
+		struct eea_net_rx *rx = enet->rx[i];
+
+		eea_stats_fill_for_q(&rx->stats.syncp, EEA_RX_STATS_LEN,
+				     eea_rx_stats_desc, data, idx);
+
+		idx += EEA_RX_STATS_LEN;
+	}
+
+	for (i = 0; i < enet->cfg.tx_ring_num; i++) {
+		struct eea_net_tx *tx = &enet->tx[i];
+
+		eea_stats_fill_for_q(&tx->stats.syncp, EEA_TX_STATS_LEN,
+				     eea_tx_stats_desc, data, idx);
+
+		idx += EEA_TX_STATS_LEN;
+	}
+}
+
+void eea_update_rx_stats(struct eea_rx_stats *rx_stats,
+			 struct eea_rx_ctx_stats *stats)
+{
+	u64_stats_update_begin(&rx_stats->syncp);
+	u64_stats_add(&rx_stats->descs,             stats->descs);
+	u64_stats_add(&rx_stats->packets,           stats->packets);
+	u64_stats_add(&rx_stats->bytes,             stats->bytes);
+	u64_stats_add(&rx_stats->drops,             stats->drops);
+	u64_stats_add(&rx_stats->split_hdr_bytes,   stats->split_hdr_bytes);
+	u64_stats_add(&rx_stats->split_hdr_packets, stats->split_hdr_packets);
+	u64_stats_add(&rx_stats->length_errors,     stats->length_errors);
+	u64_stats_update_end(&rx_stats->syncp);
+}
+
+void eea_stats(struct net_device *netdev, struct rtnl_link_stats64 *tot)
+{
+	struct eea_net *enet = netdev_priv(netdev);
+	u64 packets, bytes;
+	u32 start;
+	int i;
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
+static int eea_get_link_ksettings(struct net_device *netdev,
+				  struct ethtool_link_ksettings *cmd)
+{
+	struct eea_net *enet = netdev_priv(netdev);
+
+	cmd->base.speed  = enet->speed;
+	cmd->base.duplex = enet->duplex;
+	cmd->base.port   = PORT_OTHER;
+
+	return 0;
+}
+
+const struct ethtool_ops eea_ethtool_ops = {
+	.supported_ring_params = ETHTOOL_RING_USE_TCP_DATA_SPLIT,
+	.get_drvinfo        = eea_get_drvinfo,
+	.get_link           = ethtool_op_get_link,
+	.get_ringparam      = eea_get_ringparam,
+	.set_ringparam      = eea_set_ringparam,
+	.set_channels       = eea_set_channels,
+	.get_channels       = eea_get_channels,
+	.get_strings        = eea_get_strings,
+	.get_sset_count     = eea_get_sset_count,
+	.get_ethtool_stats  = eea_get_ethtool_stats,
+	.get_link_ksettings = eea_get_link_ksettings,
+};
diff --git a/drivers/net/ethernet/alibaba/eea/eea_ethtool.h b/drivers/net/ethernet/alibaba/eea/eea_ethtool.h
new file mode 100644
index 000000000000..1ee89b49addd
--- /dev/null
+++ b/drivers/net/ethernet/alibaba/eea/eea_ethtool.h
@@ -0,0 +1,50 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Driver for Alibaba Elastic Ethernet Adapter.
+ *
+ * Copyright (C) 2025 Alibaba Inc.
+ */
+
+#ifndef __EEA_ETHTOOL_H__
+#define __EEA_ETHTOOL_H__
+
+struct eea_tx_stats {
+	struct u64_stats_sync syncp;
+	u64_stats_t descs;
+	u64_stats_t packets;
+	u64_stats_t bytes;
+	u64_stats_t drops;
+	u64_stats_t kicks;
+};
+
+struct eea_rx_ctx_stats {
+	u64 descs;
+	u64 packets;
+	u64 bytes;
+	u64 drops;
+	u64 split_hdr_bytes;
+	u64 split_hdr_packets;
+
+	u64 length_errors;
+};
+
+struct eea_rx_stats {
+	struct u64_stats_sync syncp;
+	u64_stats_t descs;
+	u64_stats_t packets;
+	u64_stats_t bytes;
+	u64_stats_t drops;
+	u64_stats_t kicks;
+	u64_stats_t split_hdr_bytes;
+	u64_stats_t split_hdr_packets;
+
+	u64_stats_t length_errors;
+};
+
+void eea_update_rx_stats(struct eea_rx_stats *rx_stats,
+			 struct eea_rx_ctx_stats *stats);
+void eea_stats(struct net_device *netdev, struct rtnl_link_stats64 *tot);
+
+extern const struct ethtool_ops eea_ethtool_ops;
+
+#endif
diff --git a/drivers/net/ethernet/alibaba/eea/eea_net.c b/drivers/net/ethernet/alibaba/eea/eea_net.c
index 82271af0a13c..390d0b93ba31 100644
--- a/drivers/net/ethernet/alibaba/eea/eea_net.c
+++ b/drivers/net/ethernet/alibaba/eea/eea_net.c
@@ -438,6 +438,7 @@ static const struct net_device_ops eea_netdev = {
 	.ndo_stop           = eea_netdev_stop,
 	.ndo_start_xmit     = eea_tx_xmit,
 	.ndo_validate_addr  = eth_validate_addr,
+	.ndo_get_stats64    = eea_stats,
 	.ndo_features_check = passthru_features_check,
 	.ndo_tx_timeout     = eea_tx_timeout,
 };
@@ -455,6 +456,7 @@ static struct eea_net *eea_netdev_alloc(struct eea_device *edev, u32 pairs)
 	}
 
 	netdev->netdev_ops = &eea_netdev;
+	netdev->ethtool_ops = &eea_ethtool_ops;
 	SET_NETDEV_DEV(netdev, edev->dma_dev);
 
 	enet = netdev_priv(netdev);
diff --git a/drivers/net/ethernet/alibaba/eea/eea_net.h b/drivers/net/ethernet/alibaba/eea/eea_net.h
index b451f6765480..d98a1a94d86e 100644
--- a/drivers/net/ethernet/alibaba/eea/eea_net.h
+++ b/drivers/net/ethernet/alibaba/eea/eea_net.h
@@ -12,6 +12,7 @@
 #include <linux/netdevice.h>
 
 #include "eea_adminq.h"
+#include "eea_ethtool.h"
 #include "eea_ring.h"
 
 #define EEA_VER_MAJOR		1
@@ -38,6 +39,8 @@ struct eea_net_tx {
 	u32 index;
 
 	char name[16];
+
+	struct eea_tx_stats stats;
 };
 
 struct eea_rx_meta {
@@ -90,6 +93,8 @@ struct eea_net_rx {
 
 	struct napi_struct napi;
 
+	struct eea_rx_stats stats;
+
 	u16 irq_n;
 
 	char name[16];
diff --git a/drivers/net/ethernet/alibaba/eea/eea_rx.c b/drivers/net/ethernet/alibaba/eea/eea_rx.c
index 4a802cf87de0..e0a0a9e29e99 100644
--- a/drivers/net/ethernet/alibaba/eea/eea_rx.c
+++ b/drivers/net/ethernet/alibaba/eea/eea_rx.c
@@ -32,6 +32,8 @@ struct eea_rx_ctx {
 	u32 frame_sz;
 
 	struct eea_rx_meta *meta;
+
+	struct eea_rx_ctx_stats stats;
 };
 
 static struct eea_rx_meta *eea_rx_meta_get(struct eea_net_rx *rx)
@@ -199,6 +201,7 @@ static int eea_harden_check_overflow(struct eea_rx_ctx *ctx,
 		pr_debug("%s: rx error: len %u exceeds truesize %u\n",
 			 enet->netdev->name, ctx->len,
 			 ctx->meta->truesize - ctx->meta->room);
+		++ctx->stats.length_errors;
 		return -EINVAL;
 	}
 
@@ -215,6 +218,7 @@ static int eea_harden_check_size(struct eea_rx_ctx *ctx, struct eea_net *enet)
 
 	if (unlikely(ctx->hdr_len + ctx->len < ETH_HLEN)) {
 		pr_debug("%s: short packet %u\n", enet->netdev->name, ctx->len);
+		++ctx->stats.length_errors;
 		return -EINVAL;
 	}
 
@@ -356,6 +360,7 @@ static int process_remain_buf(struct eea_net_rx *rx, struct eea_rx_ctx *ctx)
 
 err:
 	dev_kfree_skb(rx->pkt.head_skb);
+	++ctx->stats.drops;
 	rx->pkt.do_drop = true;
 	rx->pkt.head_skb = NULL;
 	return 0;
@@ -384,6 +389,7 @@ static int process_first_buf(struct eea_net_rx *rx, struct eea_rx_ctx *ctx)
 	return 0;
 
 err:
+	++ctx->stats.drops;
 	rx->pkt.do_drop = true;
 	return 0;
 }
@@ -415,9 +421,12 @@ static void eea_rx_desc_to_ctx(struct eea_net_rx *rx,
 	ctx->flags = le16_to_cpu(desc->flags);
 
 	ctx->hdr_len = 0;
-	if (ctx->flags & EEA_DESC_F_SPLIT_HDR)
+	if (ctx->flags & EEA_DESC_F_SPLIT_HDR) {
 		ctx->hdr_len = le16_to_cpu(desc->len_ex) &
 			EEA_RX_CDESC_HDR_LEN_MASK;
+		ctx->stats.split_hdr_bytes += ctx->hdr_len;
+		++ctx->stats.split_hdr_packets;
+	}
 
 	ctx->more = ctx->flags & EEA_RING_DESC_F_MORE;
 }
@@ -445,6 +454,8 @@ static int eea_cleanrx(struct eea_net_rx *rx, int budget,
 
 		eea_rx_meta_dma_sync_for_cpu(rx, meta, ctx->len);
 
+		ctx->stats.bytes += ctx->len;
+
 		if (!rx->pkt.idx)
 			process_first_buf(rx, ctx);
 		else
@@ -462,17 +473,20 @@ static int eea_cleanrx(struct eea_net_rx *rx, int budget,
 skip:
 		eea_rx_meta_put(rx, meta);
 		ering_cq_ack_desc(rx->ering, 1);
+		++ctx->stats.descs;
 
 		if (!ctx->more)
 			memset(&rx->pkt, 0, sizeof(rx->pkt));
 	}
 
+	ctx->stats.packets = packets;
+
 	return packets;
 }
 
 static bool eea_rx_post(struct eea_net *enet, struct eea_net_rx *rx)
 {
-	u32 tailroom, headroom, room, len;
+	u32 tailroom, headroom, room, flags, len;
 	struct eea_rx_meta *meta;
 	struct eea_rx_desc *desc;
 	int err = 0, num = 0;
@@ -512,9 +526,14 @@ static bool eea_rx_post(struct eea_net *enet, struct eea_net_rx *rx)
 		++num;
 	}
 
-	if (num)
+	if (num) {
 		ering_kick(rx->ering);
 
+		flags = u64_stats_update_begin_irqsave(&rx->stats.syncp);
+		u64_stats_inc(&rx->stats.kicks);
+		u64_stats_update_end_irqrestore(&rx->stats.syncp, flags);
+	}
+
 	/* true means busy, napi should be called again. */
 	return !!err;
 }
@@ -535,6 +554,8 @@ int eea_poll(struct napi_struct *napi, int budget)
 	if (rx->ering->num_free > budget)
 		busy |= eea_rx_post(enet, rx);
 
+	eea_update_rx_stats(&rx->stats, &ctx.stats);
+
 	busy |= received >= budget;
 
 	if (!busy) {
@@ -720,6 +741,8 @@ struct eea_net_rx *eea_alloc_rx(struct eea_net_init_ctx *ctx, u32 idx)
 	rx->index = idx;
 	sprintf(rx->name, "rx.%u", idx);
 
+	u64_stats_init(&rx->stats.syncp);
+
 	/* ering */
 	ering = ering_alloc(idx * 2, ctx->cfg.rx_ring_depth, ctx->edev,
 			    ctx->cfg.rx_sq_desc_size,
diff --git a/drivers/net/ethernet/alibaba/eea/eea_tx.c b/drivers/net/ethernet/alibaba/eea/eea_tx.c
index a9c4cd0d75ff..acee33add96a 100644
--- a/drivers/net/ethernet/alibaba/eea/eea_tx.c
+++ b/drivers/net/ethernet/alibaba/eea/eea_tx.c
@@ -114,6 +114,13 @@ static u32 eea_clean_tx(struct eea_net_tx *tx)
 		eea_tx_meta_put_and_unmap(tx, meta);
 	}
 
+	if (stats.packets) {
+		u64_stats_update_begin(&tx->stats.syncp);
+		u64_stats_add(&tx->stats.bytes, stats.bytes);
+		u64_stats_add(&tx->stats.packets, stats.packets);
+		u64_stats_update_end(&tx->stats.syncp);
+	}
+
 	return stats.packets;
 }
 
@@ -247,6 +254,10 @@ static int eea_tx_post_skb(struct eea_net_tx *tx, struct sk_buff *skb)
 	meta->num = shinfo->nr_frags + 1;
 	ering_sq_commit_desc(tx->ering);
 
+	u64_stats_update_begin(&tx->stats.syncp);
+	u64_stats_add(&tx->stats.descs, meta->num);
+	u64_stats_update_end(&tx->stats.syncp);
+
 	return 0;
 
 err_cancel:
@@ -258,6 +269,10 @@ static int eea_tx_post_skb(struct eea_net_tx *tx, struct sk_buff *skb)
 static void eea_tx_kick(struct eea_net_tx *tx)
 {
 	ering_kick(tx->ering);
+
+	u64_stats_update_begin(&tx->stats.syncp);
+	u64_stats_inc(&tx->stats.kicks);
+	u64_stats_update_end(&tx->stats.syncp);
 }
 
 netdev_tx_t eea_tx_xmit(struct sk_buff *skb, struct net_device *netdev)
@@ -282,8 +297,13 @@ netdev_tx_t eea_tx_xmit(struct sk_buff *skb, struct net_device *netdev)
 	skb_tx_timestamp(skb);
 
 	err = eea_tx_post_skb(tx, skb);
-	if (unlikely(err))
+	if (unlikely(err)) {
+		u64_stats_update_begin(&tx->stats.syncp);
+		u64_stats_inc(&tx->stats.drops);
+		u64_stats_update_end(&tx->stats.syncp);
+
 		dev_kfree_skb_any(skb);
+	}
 
 	if (!netdev_xmit_more() || netif_xmit_stopped(txq))
 		eea_tx_kick(tx);
@@ -346,6 +366,8 @@ int eea_alloc_tx(struct eea_net_init_ctx *ctx, struct eea_net_tx *tx, u32 idx)
 	struct eea_ring *ering;
 	u32 i;
 
+	u64_stats_init(&tx->stats.syncp);
+
 	sprintf(tx->name, "tx.%u", idx);
 
 	ering = ering_alloc(idx * 2 + 1, ctx->cfg.tx_ring_depth, ctx->edev,
-- 
2.32.0.3.g01195cf9f


