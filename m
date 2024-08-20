Return-Path: <netdev+bounces-120067-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ACCF9582ED
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 11:41:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54E1E1C22B91
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 09:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63BB318EFD2;
	Tue, 20 Aug 2024 09:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TwmJgLyJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8132918EFDA;
	Tue, 20 Aug 2024 09:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724146764; cv=none; b=WH0ko85M1ZrXUQICzXPRqIe6OuKZ1v/HKTlIn0kUZCXFbBZ+dmA9Dk52mIrXBGL8QcBCJPgogOYmdyiVtVawuWN9uwbia2sBZIQEvImhu4MqpMpukpiKt/+BAhpdOscPYrhBJJYNf7GO5avIjNxvo8EW4byQcLP6Txx5nf7nFt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724146764; c=relaxed/simple;
	bh=go6EvIB3irC6d4TtKK1wFafcFq0TOIdE0WWhOoeWzCs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PoEqAxldI0BjvHXjo/PuAJh5BRlyiZ5cXLsQWL+WbxsldvYEmFyuPxSuK0M8k6IwNOa4fRhcf25zB1UX5DR2dfVAUZ3NWbUV7IgORJfMPpulGV9JRs7TOG+AzVLIjJzEiL8Gy4Hvs0AuZVw9R8lcncmTzPCXUcGcGlxMy4kaC94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TwmJgLyJ; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2d3e46ba5bcso2769058a91.0;
        Tue, 20 Aug 2024 02:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724146762; x=1724751562; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dVXB8epwEjzVkWbfqgqRBxkneLzbIU2CAdCCzSl8n9M=;
        b=TwmJgLyJPtRAhnC2r+SJFBOEzfuOFlwSep2lijsP6hp69i0+dQtkV5xqs65vhphg58
         mXFeBK6DcIsfEzEFXHQ00CYiOL4hS4Ba7Y9TtWpwlH/1roRMlQlWlYsnZmJFxSSRx25D
         SZYxANpWgMAuPrOFYD61UkCERrdIH1evgjpxgxOZTWAVI1XnLVm3GyBA6L45KTD4QD0s
         kLb+o6IAQ4DLe9yxLq3CvwyES1wiO2pKvKBvwrDNLlugxYbVZS3KW0xCym5jpBWsqe2F
         v/8I/LIhoYN+5tHTcSOBh3i2uE1ySuBoB0CpZ5ankZN5GIE/wlIeZD+g4hfFo/0w5YMo
         hosQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724146762; x=1724751562;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dVXB8epwEjzVkWbfqgqRBxkneLzbIU2CAdCCzSl8n9M=;
        b=kPKlsP/v1Bs7gp4VU61f7EmTcFCRtHezW6BYCP5qVD25zvjZkz9aI8gYy95DJKPXo0
         4qSGhGsK/+yW1fOg90Qh7NA3spEVupViuLvy6IQ+JSREM/CTl0H4bu8c2hM27ONKpqXa
         UqT/goawQlpiSRp8S12crXXegqv7nQhiNp64FpI6RdLQU8w1WwEUu3jMjrJI79xqDFvp
         vg/Zyn4VTSvKr05n7kxMv92a2wy0FjWBFfwy95/Z/M7BwMRgJRm42prCqOnAGhxkED29
         NaeJRSdeSCz/SermGCKQMB1e+dNvg5iiw4JLuCaq21+ar6fCUwQFXzE2x/ZCtscK2G6V
         v4RQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5qTl1eTFPkVx0WKWsLndXIXq5G6Sd/wMb86QoUhD57G1QoWIalYvQPziy/WmYBq80xR9dIpic7Y03w2TrP5RqbS5Bp6IIUj8lfY3O
X-Gm-Message-State: AOJu0Yy9aASY2AHxQCXMtaJtKkJz16LGNrsQ0sjfZ9X0BPIZ7ptG1Bba
	J1MCTR0IT+MTka2k3JYOgIrk3Ldq0eCWgvp2JTywTBKi3X9Ue+8P
X-Google-Smtp-Source: AGHT+IFAgU0lb/emR5+Mzegc5qF8kgk92zedg/rinAojCtgJNslwopRWjRVI9bbKPOqB4pHduz977Q==
X-Received: by 2002:a17:90b:1887:b0:2d3:d066:f58b with SMTP id 98e67ed59e1d1-2d3dfc66beemr12325593a91.12.1724146761535;
        Tue, 20 Aug 2024 02:39:21 -0700 (PDT)
Received: from localhost.localdomain ([129.146.253.192])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2d45246061dsm3230608a91.8.2024.08.20.02.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 02:39:21 -0700 (PDT)
From: Furong Xu <0x1207@gmail.com>
To: Serge Semin <fancer.lancer@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Joao Pinto <jpinto@synopsys.com>
Cc: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	xfr@outlook.com,
	Furong Xu <0x1207@gmail.com>
Subject: [PATCH net-next v4 5/7] net: stmmac: support fp parameter of tc-mqprio
Date: Tue, 20 Aug 2024 17:38:33 +0800
Message-Id: <413a36781a9b215c857bd8ec3c9ee03462e861d7.1724145786.git.0x1207@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1724145786.git.0x1207@gmail.com>
References: <cover.1724145786.git.0x1207@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tc-mqprio can select whether traffic classes are express or preemptible.

After some traffic tests, MAC merge layer statistics are all good.

Local device:
ethtool --include-statistics --json --show-mm eth1
[ {
        "ifname": "eth1",
        "pmac-enabled": true,
        "tx-enabled": true,
        "tx-active": true,
        "tx-min-frag-size": 60,
        "rx-min-frag-size": 60,
        "verify-enabled": true,
        "verify-time": 100,
        "max-verify-time": 128,
        "verify-status": "SUCCEEDED",
        "statistics": {
            "MACMergeFrameAssErrorCount": 0,
            "MACMergeFrameSmdErrorCount": 0,
            "MACMergeFrameAssOkCount": 0,
            "MACMergeFragCountRx": 0,
            "MACMergeFragCountTx": 35105,
            "MACMergeHoldCount": 0
        }
    } ]

Remote device:
ethtool --include-statistics --json --show-mm end1
[ {
        "ifname": "end1",
        "pmac-enabled": true,
        "tx-enabled": true,
        "tx-active": true,
        "tx-min-frag-size": 60,
        "rx-min-frag-size": 60,
        "verify-enabled": true,
        "verify-time": 100,
        "max-verify-time": 128,
        "verify-status": "SUCCEEDED",
        "statistics": {
            "MACMergeFrameAssErrorCount": 0,
            "MACMergeFrameSmdErrorCount": 0,
            "MACMergeFrameAssOkCount": 35105,
            "MACMergeFragCountRx": 35105,
            "MACMergeFragCountTx": 0,
            "MACMergeHoldCount": 0
        }
    } ]

Tested on DWMAC CORE 5.10a

Signed-off-by: Furong Xu <0x1207@gmail.com>
---
 .../net/ethernet/stmicro/stmmac/dwmac4_core.c |  2 +
 drivers/net/ethernet/stmicro/stmmac/dwmac5.c  | 52 ++++++++++++
 drivers/net/ethernet/stmicro/stmmac/dwmac5.h  |  4 +
 drivers/net/ethernet/stmicro/stmmac/hwif.h    | 10 +++
 .../net/ethernet/stmicro/stmmac/stmmac_main.c |  2 +
 .../net/ethernet/stmicro/stmmac/stmmac_tc.c   | 81 +++++++++++++++++++
 6 files changed, 151 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
index 679efcc631f1..4722bac7e3d4 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
@@ -1266,6 +1266,7 @@ const struct stmmac_ops dwmac410_ops = {
 	.fpe_irq_status = dwmac5_fpe_irq_status,
 	.fpe_get_add_frag_size = dwmac5_fpe_get_add_frag_size,
 	.fpe_set_add_frag_size = dwmac5_fpe_set_add_frag_size,
+	.fpe_set_preemptible_tcs = dwmac5_fpe_set_preemptible_tcs,
 	.add_hw_vlan_rx_fltr = dwmac4_add_hw_vlan_rx_fltr,
 	.del_hw_vlan_rx_fltr = dwmac4_del_hw_vlan_rx_fltr,
 	.restore_hw_vlan_rx_fltr = dwmac4_restore_hw_vlan_rx_fltr,
@@ -1320,6 +1321,7 @@ const struct stmmac_ops dwmac510_ops = {
 	.fpe_irq_status = dwmac5_fpe_irq_status,
 	.fpe_get_add_frag_size = dwmac5_fpe_get_add_frag_size,
 	.fpe_set_add_frag_size = dwmac5_fpe_set_add_frag_size,
+	.fpe_set_preemptible_tcs = dwmac5_fpe_set_preemptible_tcs,
 	.add_hw_vlan_rx_fltr = dwmac4_add_hw_vlan_rx_fltr,
 	.del_hw_vlan_rx_fltr = dwmac4_del_hw_vlan_rx_fltr,
 	.restore_hw_vlan_rx_fltr = dwmac4_restore_hw_vlan_rx_fltr,
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac5.c b/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
index 4c91fa766b13..1e87dbc9a406 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
@@ -670,3 +670,55 @@ void dwmac5_fpe_set_add_frag_size(void __iomem *ioaddr, u32 add_frag_size)
 
 	writel(value, ioaddr + MTL_FPE_CTRL_STS);
 }
+
+int dwmac5_fpe_set_preemptible_tcs(struct net_device *ndev,
+				   struct netlink_ext_ack *extack,
+				   unsigned long tcs)
+{
+	struct stmmac_priv *priv = netdev_priv(ndev);
+	void __iomem *ioaddr = priv->ioaddr;
+	unsigned long queue_tcs = 0;
+	int num_tc = ndev->num_tc;
+	u32 value, queue_weight;
+	u16 offset, count;
+	int tc, i;
+
+	if (!tcs)
+		goto __update_queue_tcs;
+
+	for (tc = 0; tc < num_tc; tc++) {
+		count = ndev->tc_to_txq[tc].count;
+		offset = ndev->tc_to_txq[tc].offset;
+
+		if (tcs & BIT(tc))
+			queue_tcs |= GENMASK(offset + count - 1, offset);
+
+		/* This is 1:1 mapping, go to next TC */
+		if (count == 1)
+			continue;
+
+		if (priv->plat->tx_sched_algorithm == MTL_TX_ALGORITHM_SP) {
+			NL_SET_ERR_MSG_MOD(extack, "TX algorithm SP is not suitable for one TC to multiple TXQs mapping");
+			return -EINVAL;
+		}
+
+		queue_weight = priv->plat->tx_queues_cfg[offset].weight;
+		for (i = 1; i < count; i++) {
+			if (queue_weight != priv->plat->tx_queues_cfg[offset + i].weight) {
+				NL_SET_ERR_MSG_FMT_MOD(extack, "TXQ weight [%u] differs across other TXQs in TC: [%u]",
+						       queue_weight, tc);
+				return -EINVAL;
+			}
+		}
+	}
+
+__update_queue_tcs:
+	value = readl(ioaddr + MTL_FPE_CTRL_STS);
+
+	value &= ~PEC;
+	value |= FIELD_PREP(PEC, queue_tcs);
+
+	writel(value, ioaddr + MTL_FPE_CTRL_STS);
+
+	return 0;
+}
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac5.h b/drivers/net/ethernet/stmicro/stmmac/dwmac5.h
index e369e65920fc..d3191c48354d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac5.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac5.h
@@ -40,6 +40,7 @@
 #define MAC_PPSx_WIDTH(x)		(0x00000b8c + ((x) * 0x10))
 
 #define MTL_FPE_CTRL_STS		0x00000c90
+#define PEC				GENMASK(15, 8)
 #define AFSZ				GENMASK(1, 0)
 
 #define MTL_RXP_CONTROL_STATUS		0x00000ca0
@@ -114,5 +115,8 @@ void dwmac5_fpe_send_mpacket(void __iomem *ioaddr,
 int dwmac5_fpe_irq_status(void __iomem *ioaddr, struct net_device *dev);
 int dwmac5_fpe_get_add_frag_size(void __iomem *ioaddr);
 void dwmac5_fpe_set_add_frag_size(void __iomem *ioaddr, u32 add_frag_size);
+int dwmac5_fpe_set_preemptible_tcs(struct net_device *ndev,
+				   struct netlink_ext_ack *extack,
+				   unsigned long tcs);
 
 #endif /* __DWMAC5_H__ */
diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/ethernet/stmicro/stmmac/hwif.h
index ba4418eaa8ba..37e8fecaf042 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
@@ -7,6 +7,7 @@
 
 #include <linux/netdevice.h>
 #include <linux/stmmac.h>
+#include <net/pkt_cls.h>
 
 #define stmmac_do_void_callback(__priv, __module, __cname,  __arg0, __args...) \
 ({ \
@@ -428,6 +429,9 @@ struct stmmac_ops {
 	int (*fpe_irq_status)(void __iomem *ioaddr, struct net_device *dev);
 	int (*fpe_get_add_frag_size)(void __iomem *ioaddr);
 	void (*fpe_set_add_frag_size)(void __iomem *ioaddr, u32 add_frag_size);
+	int (*fpe_set_preemptible_tcs)(struct net_device *ndev,
+				       struct netlink_ext_ack *extack,
+				       unsigned long tcs);
 };
 
 #define stmmac_core_init(__priv, __args...) \
@@ -536,6 +540,8 @@ struct stmmac_ops {
 	stmmac_do_callback(__priv, mac, fpe_get_add_frag_size, __args)
 #define stmmac_fpe_set_add_frag_size(__priv, __args...) \
 	stmmac_do_void_callback(__priv, mac, fpe_set_add_frag_size, __args)
+#define stmmac_fpe_set_preemptible_tcs(__priv, __args...) \
+	stmmac_do_callback(__priv, mac, fpe_set_preemptible_tcs, __args)
 
 /* PTP and HW Timer helpers */
 struct stmmac_hwtimestamp {
@@ -623,6 +629,8 @@ struct stmmac_tc_ops {
 			 struct tc_etf_qopt_offload *qopt);
 	int (*query_caps)(struct stmmac_priv *priv,
 			  struct tc_query_caps_base *base);
+	int (*setup_mqprio)(struct stmmac_priv *priv,
+			    struct tc_mqprio_qopt_offload *qopt);
 };
 
 #define stmmac_tc_init(__priv, __args...) \
@@ -639,6 +647,8 @@ struct stmmac_tc_ops {
 	stmmac_do_callback(__priv, tc, setup_etf, __args)
 #define stmmac_tc_query_caps(__priv, __args...) \
 	stmmac_do_callback(__priv, tc, query_caps, __args)
+#define stmmac_tc_setup_mqprio(__priv, __args...) \
+	stmmac_do_callback(__priv, tc, setup_mqprio, __args)
 
 struct stmmac_counters;
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 00ed0543f5cf..6d7aca411af7 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -6274,6 +6274,8 @@ static int stmmac_setup_tc(struct net_device *ndev, enum tc_setup_type type,
 	switch (type) {
 	case TC_QUERY_CAPS:
 		return stmmac_tc_query_caps(priv, priv, type_data);
+	case TC_SETUP_QDISC_MQPRIO:
+		return stmmac_tc_setup_mqprio(priv, priv, type_data);
 	case TC_SETUP_BLOCK:
 		return flow_block_cb_setup_simple(type_data,
 						  &stmmac_block_cb_list,
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
index a58282d6458c..f8f09ef2d447 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
@@ -4,6 +4,7 @@
  * stmmac TC Handling (HW only)
  */
 
+#include <linux/ethtool_netlink.h>
 #include <net/pkt_cls.h>
 #include <net/tc_act/tc_gact.h>
 #include "common.h"
@@ -1174,6 +1175,13 @@ static int tc_query_caps(struct stmmac_priv *priv,
 			 struct tc_query_caps_base *base)
 {
 	switch (base->type) {
+	case TC_SETUP_QDISC_MQPRIO: {
+		struct tc_mqprio_caps *caps = base->caps;
+
+		caps->validate_queue_counts = true;
+
+		return 0;
+	}
 	case TC_SETUP_QDISC_TAPRIO: {
 		struct tc_taprio_caps *caps = base->caps;
 
@@ -1190,6 +1198,78 @@ static int tc_query_caps(struct stmmac_priv *priv,
 	}
 }
 
+static void stmmac_reset_tc_mqprio(struct net_device *ndev,
+				   struct netlink_ext_ack *extack)
+{
+	struct stmmac_priv *priv = netdev_priv(ndev);
+
+	netdev_reset_tc(ndev);
+	netif_set_real_num_tx_queues(ndev, priv->plat->tx_queues_to_use);
+
+	stmmac_fpe_set_preemptible_tcs(priv, ndev, extack, 0);
+}
+
+static int tc_setup_mqprio(struct stmmac_priv *priv,
+			   struct tc_mqprio_qopt_offload *mqprio)
+{
+	struct netlink_ext_ack *extack = mqprio->extack;
+	struct tc_mqprio_qopt *qopt = &mqprio->qopt;
+	struct net_device *ndev = priv->dev;
+	int num_stack_tx_queues = 0;
+	int num_tc = qopt->num_tc;
+	u16 offset, count;
+	int tc, err;
+
+	if (!num_tc) {
+		stmmac_reset_tc_mqprio(ndev, extack);
+		return 0;
+	}
+
+	if (mqprio->preemptible_tcs && !ethtool_dev_mm_supported(ndev)) {
+		NL_SET_ERR_MSG_MOD(extack, "Device does not support preemption");
+		return -EOPNOTSUPP;
+	}
+
+	err = netdev_set_num_tc(ndev, num_tc);
+	if (err)
+		return err;
+
+	/* DWMAC CORE4+ can not programming TC:TXQ mapping to hardware.
+	 * Synopsys Databook:
+	 * "The number of Tx DMA channels is equal to the number of Tx queues,
+	 * and is direct one-to-one mapping."
+	 *
+	 * Luckily, DWXGMAC CORE can.
+	 *
+	 * Thus preemptible_tcs should be handled in a per core manner.
+	 */
+	for (tc = 0; tc < num_tc; tc++) {
+		offset = qopt->offset[tc];
+		count = qopt->count[tc];
+		num_stack_tx_queues += count;
+
+		err = netdev_set_tc_queue(ndev, tc, count, offset);
+		if (err)
+			goto err_reset_tc;
+	}
+
+	err = netif_set_real_num_tx_queues(ndev, num_stack_tx_queues);
+	if (err)
+		goto err_reset_tc;
+
+	err = stmmac_fpe_set_preemptible_tcs(priv, ndev, extack,
+					     mqprio->preemptible_tcs);
+	if (err)
+		goto err_reset_tc;
+
+	return 0;
+
+err_reset_tc:
+	stmmac_reset_tc_mqprio(ndev, extack);
+
+	return err;
+}
+
 const struct stmmac_tc_ops dwmac510_tc_ops = {
 	.init = tc_init,
 	.setup_cls_u32 = tc_setup_cls_u32,
@@ -1198,4 +1278,5 @@ const struct stmmac_tc_ops dwmac510_tc_ops = {
 	.setup_taprio = tc_setup_taprio,
 	.setup_etf = tc_setup_etf,
 	.query_caps = tc_query_caps,
+	.setup_mqprio = tc_setup_mqprio,
 };
-- 
2.34.1


