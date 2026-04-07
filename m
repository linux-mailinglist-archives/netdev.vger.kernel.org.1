Return-Path: <netdev+bounces-275989-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AIrLBJf21GkjywcAu9opvQ
	(envelope-from <netdev+bounces-275989-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 14:20:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B3673AE3B7
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 14:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D2E35302D97A
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 12:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07CF53B3BE1;
	Tue,  7 Apr 2026 12:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="VEswEJmR"
X-Original-To: netdev@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FC33B38BF
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 12:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775564416; cv=none; b=SKh7xj/JauB5H+h+8SB7XC9B0wUglJ/gfnmkNZKclPhdAttE6/OXgW5QJ4qxfbfhtQ5YL0LXZoc0qs9twfnGkm+s7dgDRaQ0UrBI0W2Y4iaM80fVT59VdkuoifBg5e+ZR1LgvV74SKYl/3w8PHmF8aG7kqvnFACoHWLIc+tDw1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775564416; c=relaxed/simple;
	bh=I44q96qJ31cRLw+JWSlTCN1akzlFTHwbqBpYTq+GFp8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y/XKFCB4qJmVtPf5GVtt1wjNiP+4258FhNK4Fw2OKMexL4VgxMZZUTOZR7u3gmj4AG41nzSEi7FXxh2JkzFLOXGfqzUVAJ1PbVxFUzrgIlT2PxuocEPKI7r/Pm95Edbzu/Plo6VZ7/2MGw3MNCsFlGBiSFE6+6F5l7qsgefGXeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=VEswEJmR; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1775564408; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=ChXf+IxUaOKGabRJn/DuFrX6kQpxG7wPlYN3CJHrL0U=;
	b=VEswEJmRXDGWJKeHImb9UCNrzy2ctSpA+z83i2JI35rukIx+H4IC4ykztRA8gtlhN668O3B4QQowOTbtvEp0vbIsX8cdktsOnVSdsNfdd4lt0aycyjvVLhvkAphXsE63NnyHA2p5RO4Dj3Ab6aXaJ4RIrhjjVVvww4ToBuaHTPM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0X0boCxx_1775564406;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0X0boCxx_1775564406 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 07 Apr 2026 20:20:07 +0800
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
	Jes Sorensen <jes@trained-monkey.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Dust Li <dust.li@linux.alibaba.com>,
	Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH net-next v38 7/8] eea: introduce ethtool support
Date: Tue,  7 Apr 2026 20:20:00 +0800
Message-Id: <20260407122001.22265-8-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20260407122001.22265-1-xuanzhuo@linux.alibaba.com>
References: <20260407122001.22265-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: 814f2b4a232c
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-6.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275989-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xuanzhuo@linux.alibaba.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,linux.alibaba.com,linux.dev,mucse.com,trained-monkey.org,gmail.com];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 7B3673AE3B7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add basic driver framework for the Alibaba Elastic Ethernet Adapter(EEA).

This commit introduces ethtool support.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Dust Li <dust.li@linux.alibaba.com>
Reviewed-by: Philo Lu <lulie@linux.alibaba.com>
Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/ethernet/alibaba/eea/Makefile     |   1 +
 .../net/ethernet/alibaba/eea/eea_ethtool.c    | 252 ++++++++++++++++++
 .../net/ethernet/alibaba/eea/eea_ethtool.h    |  49 ++++
 drivers/net/ethernet/alibaba/eea/eea_net.c    |   1 +
 drivers/net/ethernet/alibaba/eea/eea_net.h    |   5 +
 drivers/net/ethernet/alibaba/eea/eea_rx.c     |  32 ++-
 drivers/net/ethernet/alibaba/eea/eea_tx.c     |  27 +-
 7 files changed, 362 insertions(+), 5 deletions(-)
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
index 000000000000..91255a72ddc6
--- /dev/null
+++ b/drivers/net/ethernet/alibaba/eea/eea_ethtool.c
@@ -0,0 +1,252 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Driver for Alibaba Elastic Ethernet Adapter.
+ *
+ * Copyright (C) 2025 Alibaba Inc.
+ */
+
+#include <linux/ethtool.h>
+#include <linux/ethtool_netlink.h>
+#include <linux/rtnetlink.h>
+
+#include "eea_adminq.h"
+#include "eea_net.h"
+#include "eea_pci.h"
+
+#define EEA_NET_MIN_DEPTH 64
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
+	if (ring->rx_pending < EEA_NET_MIN_DEPTH ||
+	    ring->tx_pending < EEA_NET_MIN_DEPTH)
+		return -EINVAL;
+
+	eea_init_ctx(enet, &ctx);
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
+	/* By default, enet->cfg_hw.split_hdr is 128. */
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
+	eea_init_ctx(enet, &ctx);
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
+	ASSERT_RTNL();
+
+	if (enet->rx) {
+		for (i = 0; i < enet->cfg.rx_ring_num; i++) {
+			struct eea_net_rx *rx = enet->rx[i];
+
+			eea_stats_fill_for_q(&rx->stats.syncp, EEA_RX_STATS_LEN,
+					     eea_rx_stats_desc, data, idx);
+
+			idx += EEA_RX_STATS_LEN;
+		}
+	}
+
+	if (enet->tx) {
+		for (i = 0; i < enet->cfg.tx_ring_num; i++) {
+			struct eea_net_tx *tx = &enet->tx[i];
+
+			eea_stats_fill_for_q(&tx->stats.syncp, EEA_TX_STATS_LEN,
+					     eea_tx_stats_desc, data, idx);
+
+			idx += EEA_TX_STATS_LEN;
+		}
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
index 000000000000..a437065d1cab
--- /dev/null
+++ b/drivers/net/ethernet/alibaba/eea/eea_ethtool.h
@@ -0,0 +1,49 @@
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
+
+extern const struct ethtool_ops eea_ethtool_ops;
+
+#endif
diff --git a/drivers/net/ethernet/alibaba/eea/eea_net.c b/drivers/net/ethernet/alibaba/eea/eea_net.c
index c84b2d9297a0..bc319c4c2983 100644
--- a/drivers/net/ethernet/alibaba/eea/eea_net.c
+++ b/drivers/net/ethernet/alibaba/eea/eea_net.c
@@ -614,6 +614,7 @@ static struct eea_net *eea_netdev_alloc(struct eea_device *edev, u32 pairs)
 	}
 
 	netdev->netdev_ops = &eea_netdev;
+	netdev->ethtool_ops = &eea_ethtool_ops;
 	SET_NETDEV_DEV(netdev, edev->dma_dev);
 
 	enet = netdev_priv(netdev);
diff --git a/drivers/net/ethernet/alibaba/eea/eea_net.h b/drivers/net/ethernet/alibaba/eea/eea_net.h
index 4b10246d1a6f..84d26df79e59 100644
--- a/drivers/net/ethernet/alibaba/eea/eea_net.h
+++ b/drivers/net/ethernet/alibaba/eea/eea_net.h
@@ -12,6 +12,7 @@
 #include <linux/netdevice.h>
 
 #include "eea_adminq.h"
+#include "eea_ethtool.h"
 #include "eea_ring.h"
 
 #define EEA_VER_MAJOR		1
@@ -33,6 +34,8 @@ struct eea_net_tx {
 	u32 index;
 
 	char name[16];
+
+	struct eea_tx_stats stats;
 };
 
 struct eea_rx_meta {
@@ -85,6 +88,8 @@ struct eea_net_rx {
 
 	struct napi_struct *napi;
 
+	struct eea_rx_stats stats;
+
 	char name[16];
 
 	struct eea_net_rx_pkt_ctx pkt;
diff --git a/drivers/net/ethernet/alibaba/eea/eea_rx.c b/drivers/net/ethernet/alibaba/eea/eea_rx.c
index ada89bd9f177..9f63e5d8c1f3 100644
--- a/drivers/net/ethernet/alibaba/eea/eea_rx.c
+++ b/drivers/net/ethernet/alibaba/eea/eea_rx.c
@@ -29,6 +29,8 @@ struct eea_rx_ctx {
 	bool more;
 
 	struct eea_rx_meta *meta;
+
+	struct eea_rx_ctx_stats stats;
 };
 
 static struct eea_rx_meta *eea_rx_meta_get(struct eea_net_rx *rx)
@@ -232,6 +234,7 @@ static int eea_harden_check_overflow(struct eea_rx_ctx *ctx,
 	if (unlikely(ctx->len > max_len)) {
 		pr_debug("%s: rx error: len %u exceeds truesize %u\n",
 			 enet->netdev->name, ctx->len, max_len);
+		++ctx->stats.length_errors;
 		return -EINVAL;
 	}
 
@@ -250,6 +253,7 @@ static int eea_harden_check_size(struct eea_rx_ctx *ctx, struct eea_net *enet)
 		if (unlikely(ctx->hdr_len < ETH_HLEN)) {
 			pr_debug("%s: short hdr %u\n", enet->netdev->name,
 				 ctx->hdr_len);
+			++ctx->stats.length_errors;
 			return -EINVAL;
 		}
 
@@ -257,6 +261,7 @@ static int eea_harden_check_size(struct eea_rx_ctx *ctx, struct eea_net *enet)
 			pr_debug("%s: rx error: hdr len %u exceeds hdr buffer size %u\n",
 				 enet->netdev->name, ctx->hdr_len,
 				 enet->cfg.split_hdr);
+			++ctx->stats.length_errors;
 			return -EINVAL;
 		}
 
@@ -265,6 +270,7 @@ static int eea_harden_check_size(struct eea_rx_ctx *ctx, struct eea_net *enet)
 
 	if (unlikely(ctx->len < ETH_HLEN)) {
 		pr_debug("%s: short packet %u\n", enet->netdev->name, ctx->len);
+		++ctx->stats.length_errors;
 		return -EINVAL;
 	}
 
@@ -373,6 +379,7 @@ static void process_remain_buf(struct eea_net_rx *rx, struct eea_rx_ctx *ctx)
 
 err:
 	dev_kfree_skb(rx->pkt.head_skb);
+	++ctx->stats.drops;
 	rx->pkt.do_drop = true;
 	rx->pkt.head_skb = NULL;
 }
@@ -400,6 +407,7 @@ static void process_first_buf(struct eea_net_rx *rx, struct eea_rx_ctx *ctx)
 	return;
 
 err:
+	++ctx->stats.drops;
 	rx->pkt.do_drop = true;
 }
 
@@ -449,6 +457,8 @@ static int eea_rx_desc_to_ctx(struct eea_net_rx *rx,
 	if (ctx->flags & EEA_DESC_F_SPLIT_HDR) {
 		ctx->hdr_len = le16_to_cpu(desc->len_ex) &
 			EEA_RX_CDESC_HDR_LEN_MASK;
+		ctx->stats.split_hdr_bytes += ctx->hdr_len;
+		++ctx->stats.split_hdr_packets;
 	}
 
 	ctx->more = ctx->flags & EEA_RING_DESC_F_MORE;
@@ -473,8 +483,10 @@ static int eea_cleanrx(struct eea_net_rx *rx, int budget,
 			if (ctx->meta)
 				eea_rx_meta_put(rx, ctx->meta);
 
-			if (rx->pkt.idx)
+			if (rx->pkt.head_skb) {
 				dev_kfree_skb(rx->pkt.head_skb);
+				++ctx->stats.drops;
+			}
 
 			ctx->more = false;
 			goto ack;
@@ -497,13 +509,17 @@ static int eea_cleanrx(struct eea_net_rx *rx, int budget,
 
 		++rx->pkt.idx;
 
-		if (!ctx->more && rx->pkt.head_skb)
+		if (!ctx->more && rx->pkt.head_skb) {
 			eea_submit_skb(rx, rx->pkt.head_skb, desc);
+			ctx->stats.bytes += rx->pkt.recv_len;
+			++ctx->stats.packets;
+		}
 
 skip:
 		eea_rx_meta_put(rx, meta);
 ack:
 		ering_cq_ack_desc(rx->ering, 1);
+		++ctx->stats.descs;
 
 		if (!ctx->more) {
 			memset(&rx->pkt, 0, sizeof(rx->pkt));
@@ -528,6 +544,7 @@ static bool eea_rx_post(struct eea_net_rx *rx)
 	struct eea_rx_meta *meta;
 	struct eea_rx_desc *desc;
 	int err = 0, num = 0;
+	unsigned long flags;
 	dma_addr_t addr;
 
 	tailroom = SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
@@ -568,9 +585,14 @@ static bool eea_rx_post(struct eea_net_rx *rx)
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
@@ -591,6 +613,8 @@ static int eea_poll(struct napi_struct *napi, int budget)
 	if (rx->ering->num_free > budget)
 		busy |= eea_rx_post(rx);
 
+	eea_update_rx_stats(&rx->stats, &ctx.stats);
+
 	busy |= received >= budget;
 
 	if (busy)
@@ -728,6 +752,8 @@ struct eea_net_rx *eea_alloc_rx(struct eea_net_init_ctx *ctx, u32 idx)
 	rx->index = idx;
 	snprintf(rx->name, sizeof(rx->name), "rx.%u", idx);
 
+	u64_stats_init(&rx->stats.syncp);
+
 	/* ering */
 	ering = ering_alloc(idx * 2, ctx->cfg.rx_ring_depth, ctx->edev,
 			    ctx->cfg.rx_sq_desc_size,
diff --git a/drivers/net/ethernet/alibaba/eea/eea_tx.c b/drivers/net/ethernet/alibaba/eea/eea_tx.c
index acfe4c8ae59e..d7670650db15 100644
--- a/drivers/net/ethernet/alibaba/eea/eea_tx.c
+++ b/drivers/net/ethernet/alibaba/eea/eea_tx.c
@@ -89,6 +89,7 @@ static void eea_meta_free_xmit(struct eea_net_tx *tx,
 	}
 
 	++stats->packets;
+	stats->bytes += meta->skb->len;
 	napi_consume_skb(meta->skb, budget);
 
 	meta->data = NULL;
@@ -130,6 +131,13 @@ static bool eea_clean_tx(struct eea_net_tx *tx, int budget)
 		ering_cq_ack_desc(tx->ering, desc_n);
 	}
 
+	if (stats.packets) {
+		u64_stats_update_begin(&tx->stats.syncp);
+		u64_stats_add(&tx->stats.bytes, stats.bytes);
+		u64_stats_add(&tx->stats.packets, stats.packets);
+		u64_stats_update_end(&tx->stats.syncp);
+	}
+
 	return stats.packets == budget;
 }
 
@@ -301,6 +309,10 @@ static int eea_tx_post_skb(struct eea_net_tx *tx, struct sk_buff *skb)
 	meta->num = shinfo->nr_frags + 1;
 	ering_sq_commit_desc(tx->ering);
 
+	u64_stats_update_begin(&tx->stats.syncp);
+	u64_stats_add(&tx->stats.descs, meta->num);
+	u64_stats_update_end(&tx->stats.syncp);
+
 	return 0;
 
 err_cancel:
@@ -313,6 +325,10 @@ static int eea_tx_post_skb(struct eea_net_tx *tx, struct sk_buff *skb)
 static void eea_tx_kick(struct eea_net_tx *tx)
 {
 	ering_kick(tx->ering);
+
+	u64_stats_update_begin(&tx->stats.syncp);
+	u64_stats_inc(&tx->stats.kicks);
+	u64_stats_update_end(&tx->stats.syncp);
 }
 
 netdev_tx_t eea_tx_xmit(struct sk_buff *skb, struct net_device *netdev)
@@ -326,10 +342,15 @@ netdev_tx_t eea_tx_xmit(struct sk_buff *skb, struct net_device *netdev)
 	txq = netdev_get_tx_queue(netdev, qnum);
 
 	err = eea_tx_post_skb(tx, skb);
-	if (unlikely(err))
+	if (unlikely(err)) {
+		u64_stats_update_begin(&tx->stats.syncp);
+		u64_stats_inc(&tx->stats.drops);
+		u64_stats_update_end(&tx->stats.syncp);
+
 		dev_kfree_skb_any(skb);
-	else
+	} else {
 		skb_tx_timestamp(skb);
+	}
 
 	/* NETDEV_TX_BUSY is expensive. So stop advancing the TX queue.
 	 * MAX_SKB_FRAGS + 1: Covers the skb linear head and all paged fragments
@@ -389,6 +410,8 @@ int eea_alloc_tx(struct eea_net_init_ctx *ctx, struct eea_net_tx *tx, u32 idx)
 	struct eea_ring *ering;
 	u32 i;
 
+	u64_stats_init(&tx->stats.syncp);
+
 	snprintf(tx->name, sizeof(tx->name), "tx.%u", idx);
 
 	ering = ering_alloc(idx * 2 + 1, ctx->cfg.tx_ring_depth, ctx->edev,
-- 
2.32.0.3.g01195cf9f


