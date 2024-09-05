Return-Path: <netdev+bounces-125402-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E6E996D00C
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 09:04:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52ACD1C218C7
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 07:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F081C193062;
	Thu,  5 Sep 2024 07:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b+iFrwQd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011BE1946B1;
	Thu,  5 Sep 2024 07:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725519809; cv=none; b=QTbbVABz9Cu/xqoTcBYWDtkxZrTXUwPtt9Ee2U+JNBh72mnqVtR9OFjmIyWGSL8wI3X2MfTqM17i36VyRL+vXIxaglx09tatQDL2QdOP2F+u6gfg4CEEZI99VyAQ5U0xOFyIruce1WgPWpFu/m7wOa2AvhdT5fJERtvLofPaN6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725519809; c=relaxed/simple;
	bh=crCDTN6YkvFN1Q3kL0t6By6TFAYKEy3kdnt2QpbcYgI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NdFDKADr5qT1ivIsPOO/MjkeL9YAWroUYaGLO20E9XEDMaMbVV3znYm3NpBYvzDw9d01altT8yp8c/L0ZQdmi+xl8naHXKVDHw+m20T96Xjn5v3TyGbE0B1Cgh2RjmVu+4x4VhvPid0DRm2uOANjv8b7lMpyqoLTMZTi01g171I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b+iFrwQd; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-277f19ee2a2so266220fac.1;
        Thu, 05 Sep 2024 00:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725519807; x=1726124607; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ItEfbdMenWzjYDGl9vd0UY8GzzLGbjfOA8CfmjL2lMk=;
        b=b+iFrwQdtt3ODRHEtsPournqZchJt2zs9SHq06dodl96MfnIIfSiEaN+DIyARufs9z
         g1XT/EyDO0Tf0C5dGJqfKdPlhkAPkIwfqAbYq74T53QTZaFSaNwosSi+daxe3Jt7/mCc
         l/kEMw7pABkcx0c26kRIu1iQ0G+0zQ9x/dtuK7+/umRJG6+dZGh6vEvKN5/xeVEMUTdf
         pb0JtJSOc1U1VgLekY2ZqCqfk2P25iFUc5bbfOI3HJIxHVNoOcMhppxoUjndj3VAd8q4
         D/ZRoCKb21JQ7rAxnJ/7l4D4agzo6inPFBbkQQ8jM0M3Vkr7ZSJw2pFNMap3XsfEEcZ/
         81mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725519807; x=1726124607;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ItEfbdMenWzjYDGl9vd0UY8GzzLGbjfOA8CfmjL2lMk=;
        b=NUkika3OIRO6N0U2Of4GB9UxFlIXzv7KojLL2esWq06FxjE+fEgFgNR+AjWO2hpupC
         q6iZD54LNn1FOPi7cDnUANvzcyrG3JV0Mrvn28T/Xjs1qXp9dbSPWy/EPfTRjRai75Xw
         CSzWTMmGIknZ0jdoBkJ7sgJQtOxnyt742Dmu9At2OKxWyK6Y1P9d75rwzFn8KaZko8fp
         I9UE2/g7OGmziuwPfkS7FwUAfHGtC8/e7hHKvHQ3jczuCvKU0cIisraoTgDr+BIuSIf4
         +SlwE2oKXVR7NkQ2siQtdsId67hIjCrnvO/hcwmm7168tvpfth7spOJIfRznxscBbRka
         Zwag==
X-Forwarded-Encrypted: i=1; AJvYcCWH7YkB8OKiIXcj7TI3ZV6ZHjXRGf+JN9nutaw2LHtavwskKUow63cuB+XlXI92v+M2h9NmeEpdeN5bj+c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtDSKb7HwCr8KgXx9pgAv9q1s7/JRjJw27pMjmeWwgO+exxvwU
	zhEMEFw7mPS/9IBDZTKdM7BdRE9/7TQomUEI7bbvdrJLZrUMYejD
X-Google-Smtp-Source: AGHT+IEF0KH7ccPFf1eEb9mWo/xoD00IkCl5NtguWEb7Tk8vMWiEobhuTn13dHeaFh1kp/XFJBrI0g==
X-Received: by 2002:a05:6870:c186:b0:260:71c4:f33a with SMTP id 586e51a60fabf-277902b2663mr24588898fac.39.1725519806918;
        Thu, 05 Sep 2024 00:03:26 -0700 (PDT)
Received: from localhost.localdomain ([129.146.253.192])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-71778595107sm2604897b3a.150.2024.09.05.00.03.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 00:03:26 -0700 (PDT)
From: Furong Xu <0x1207@gmail.com>
To: Vladimir Oltean <olteanv@gmail.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Serge Semin <fancer.lancer@gmail.com>,
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
	rmk+kernel@armlinux.org.uk,
	linux@armlinux.org.uk,
	xfr@outlook.com,
	Furong Xu <0x1207@gmail.com>
Subject: [PATCH net-next v8 5/7] net: stmmac: support fp parameter of tc-mqprio
Date: Thu,  5 Sep 2024 15:02:26 +0800
Message-Id: <b12e36639ee0cd77f3238fe418af70f975988fc8.1725518136.git.0x1207@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1725518135.git.0x1207@gmail.com>
References: <cover.1725518135.git.0x1207@gmail.com>
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
 drivers/net/ethernet/stmicro/stmmac/dwmac5.c  | 55 +++++++++++
 drivers/net/ethernet/stmicro/stmmac/dwmac5.h  |  4 +
 drivers/net/ethernet/stmicro/stmmac/hwif.c    |  6 +-
 drivers/net/ethernet/stmicro/stmmac/hwif.h    | 12 +++
 .../net/ethernet/stmicro/stmmac/stmmac_main.c |  2 +
 .../net/ethernet/stmicro/stmmac/stmmac_tc.c   | 94 +++++++++++++++++++
 7 files changed, 172 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
index 679efcc631f1..a1858f083eef 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
@@ -1266,6 +1266,7 @@ const struct stmmac_ops dwmac410_ops = {
 	.fpe_irq_status = dwmac5_fpe_irq_status,
 	.fpe_get_add_frag_size = dwmac5_fpe_get_add_frag_size,
 	.fpe_set_add_frag_size = dwmac5_fpe_set_add_frag_size,
+	.fpe_map_preemption_class = dwmac5_fpe_map_preemption_class,
 	.add_hw_vlan_rx_fltr = dwmac4_add_hw_vlan_rx_fltr,
 	.del_hw_vlan_rx_fltr = dwmac4_del_hw_vlan_rx_fltr,
 	.restore_hw_vlan_rx_fltr = dwmac4_restore_hw_vlan_rx_fltr,
@@ -1320,6 +1321,7 @@ const struct stmmac_ops dwmac510_ops = {
 	.fpe_irq_status = dwmac5_fpe_irq_status,
 	.fpe_get_add_frag_size = dwmac5_fpe_get_add_frag_size,
 	.fpe_set_add_frag_size = dwmac5_fpe_set_add_frag_size,
+	.fpe_map_preemption_class = dwmac5_fpe_map_preemption_class,
 	.add_hw_vlan_rx_fltr = dwmac4_add_hw_vlan_rx_fltr,
 	.del_hw_vlan_rx_fltr = dwmac4_del_hw_vlan_rx_fltr,
 	.restore_hw_vlan_rx_fltr = dwmac4_restore_hw_vlan_rx_fltr,
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac5.c b/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
index db7bbc50cfae..dd9583968962 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
@@ -667,3 +667,58 @@ void dwmac5_fpe_set_add_frag_size(void __iomem *ioaddr, u32 add_frag_size)
 	writel(u32_replace_bits(value, add_frag_size, DWMAC5_ADD_FRAG_SZ),
 	       ioaddr + MTL_FPE_CTRL_STS);
 }
+
+#define ALG_ERR_MSG "TX algorithm SP is not suitable for one-to-many mapping"
+#define WEIGHT_ERR_MSG "TXQ weight %u differs across other TXQs in TC: [%u]"
+
+int dwmac5_fpe_map_preemption_class(struct net_device *ndev,
+				    struct netlink_ext_ack *extack, u32 pclass)
+{
+	u32 offset, count, val, preemptible_txqs = 0;
+	struct stmmac_priv *priv = netdev_priv(ndev);
+	u32 num_tc = ndev->num_tc;
+
+	if (!pclass)
+		goto update_mapping;
+
+	/* DWMAC CORE4+ can not program TC:TXQ mapping to hardware.
+	 *
+	 * Synopsys Databook:
+	 * "The number of Tx DMA channels is equal to the number of Tx queues,
+	 * and is direct one-to-one mapping."
+	 */
+	for (u32 tc = 0; tc < num_tc; tc++) {
+		count = ndev->tc_to_txq[tc].count;
+		offset = ndev->tc_to_txq[tc].offset;
+
+		if (pclass & BIT(tc))
+			preemptible_txqs |= GENMASK(offset + count - 1, offset);
+
+		/* This is 1:1 mapping, go to next TC */
+		if (count == 1)
+			continue;
+
+		if (priv->plat->tx_sched_algorithm == MTL_TX_ALGORITHM_SP) {
+			NL_SET_ERR_MSG_MOD(extack, ALG_ERR_MSG);
+			return -EINVAL;
+		}
+
+		u32 queue_weight = priv->plat->tx_queues_cfg[offset].weight;
+
+		for (u32 i = 1; i < count; i++) {
+			if (priv->plat->tx_queues_cfg[offset + i].weight !=
+			    queue_weight) {
+				NL_SET_ERR_MSG_FMT_MOD(extack, WEIGHT_ERR_MSG,
+						       queue_weight, tc);
+				return -EINVAL;
+			}
+		}
+	}
+
+update_mapping:
+	val = readl(priv->ioaddr + MTL_FPE_CTRL_STS);
+	writel(u32_replace_bits(val, preemptible_txqs, DWMAC5_PREEMPTION_CLASS),
+	       priv->ioaddr + MTL_FPE_CTRL_STS);
+
+	return 0;
+}
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac5.h b/drivers/net/ethernet/stmicro/stmmac/dwmac5.h
index 58704c15f320..6c6eb6790e83 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac5.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac5.h
@@ -40,6 +40,8 @@
 #define MAC_PPSx_WIDTH(x)		(0x00000b8c + ((x) * 0x10))
 
 #define MTL_FPE_CTRL_STS		0x00000c90
+/* Preemption Classification */
+#define DWMAC5_PREEMPTION_CLASS		GENMASK(15, 8)
 /* Additional Fragment Size of preempted frames */
 #define DWMAC5_ADD_FRAG_SZ		GENMASK(1, 0)
 
@@ -115,5 +117,7 @@ void dwmac5_fpe_send_mpacket(void __iomem *ioaddr,
 int dwmac5_fpe_irq_status(void __iomem *ioaddr, struct net_device *dev);
 int dwmac5_fpe_get_add_frag_size(const void __iomem *ioaddr);
 void dwmac5_fpe_set_add_frag_size(void __iomem *ioaddr, u32 add_frag_size);
+int dwmac5_fpe_map_preemption_class(struct net_device *ndev,
+				    struct netlink_ext_ack *extack, u32 pclass);
 
 #endif /* __DWMAC5_H__ */
diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.c b/drivers/net/ethernet/stmicro/stmmac/hwif.c
index 29367105df54..88cce28b2f98 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.c
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.c
@@ -171,7 +171,7 @@ static const struct stmmac_hwif_entry {
 		.mac = &dwmac4_ops,
 		.hwtimestamp = &stmmac_ptp,
 		.mode = NULL,
-		.tc = &dwmac510_tc_ops,
+		.tc = &dwmac4_tc_ops,
 		.mmc = &dwmac_mmc_ops,
 		.est = &dwmac510_est_ops,
 		.setup = dwmac4_setup,
@@ -252,7 +252,7 @@ static const struct stmmac_hwif_entry {
 		.mac = &dwxgmac210_ops,
 		.hwtimestamp = &stmmac_ptp,
 		.mode = NULL,
-		.tc = &dwmac510_tc_ops,
+		.tc = &dwxgmac_tc_ops,
 		.mmc = &dwxgmac_mmc_ops,
 		.est = &dwmac510_est_ops,
 		.setup = dwxgmac2_setup,
@@ -273,7 +273,7 @@ static const struct stmmac_hwif_entry {
 		.mac = &dwxlgmac2_ops,
 		.hwtimestamp = &stmmac_ptp,
 		.mode = NULL,
-		.tc = &dwmac510_tc_ops,
+		.tc = &dwxgmac_tc_ops,
 		.mmc = &dwxgmac_mmc_ops,
 		.est = &dwmac510_est_ops,
 		.setup = dwxlgmac2_setup,
diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/ethernet/stmicro/stmmac/hwif.h
index f080e271f7af..d5a9f01ecac5 100644
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
 	int (*fpe_get_add_frag_size)(const void __iomem *ioaddr);
 	void (*fpe_set_add_frag_size)(void __iomem *ioaddr, u32 add_frag_size);
+	int (*fpe_map_preemption_class)(struct net_device *ndev,
+					struct netlink_ext_ack *extack,
+					u32 pclass);
 };
 
 #define stmmac_core_init(__priv, __args...) \
@@ -536,6 +540,8 @@ struct stmmac_ops {
 	stmmac_do_callback(__priv, mac, fpe_get_add_frag_size, __args)
 #define stmmac_fpe_set_add_frag_size(__priv, __args...) \
 	stmmac_do_void_callback(__priv, mac, fpe_set_add_frag_size, __args)
+#define stmmac_fpe_map_preemption_class(__priv, __args...) \
+	stmmac_do_void_callback(__priv, mac, fpe_map_preemption_class, __args)
 
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
 
@@ -682,7 +692,9 @@ extern const struct stmmac_dma_ops dwmac4_dma_ops;
 extern const struct stmmac_ops dwmac410_ops;
 extern const struct stmmac_dma_ops dwmac410_dma_ops;
 extern const struct stmmac_ops dwmac510_ops;
+extern const struct stmmac_tc_ops dwmac4_tc_ops;
 extern const struct stmmac_tc_ops dwmac510_tc_ops;
+extern const struct stmmac_tc_ops dwxgmac_tc_ops;
 extern const struct stmmac_ops dwxgmac210_ops;
 extern const struct stmmac_ops dwxlgmac2_ops;
 extern const struct stmmac_dma_ops dwxgmac210_dma_ops;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 05451df9e117..eaa21503ad5b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -6216,6 +6216,8 @@ static int stmmac_setup_tc(struct net_device *ndev, enum tc_setup_type type,
 	switch (type) {
 	case TC_QUERY_CAPS:
 		return stmmac_tc_query_caps(priv, priv, type_data);
+	case TC_SETUP_QDISC_MQPRIO:
+		return stmmac_tc_setup_mqprio(priv, priv, type_data);
 	case TC_SETUP_BLOCK:
 		return flow_block_cb_setup_simple(type_data,
 						  &stmmac_block_cb_list,
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
index a58282d6458c..cfdb9ab1fa2a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
@@ -1174,6 +1174,13 @@ static int tc_query_caps(struct stmmac_priv *priv,
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
 
@@ -1190,6 +1197,81 @@ static int tc_query_caps(struct stmmac_priv *priv,
 	}
 }
 
+static void stmmac_reset_tc_mqprio(struct net_device *ndev,
+				   struct netlink_ext_ack *extack)
+{
+	struct stmmac_priv *priv = netdev_priv(ndev);
+
+	netdev_reset_tc(ndev);
+	netif_set_real_num_tx_queues(ndev, priv->plat->tx_queues_to_use);
+	stmmac_fpe_map_preemption_class(priv, ndev, extack, 0);
+}
+
+static int tc_setup_dwmac510_mqprio(struct stmmac_priv *priv,
+				    struct tc_mqprio_qopt_offload *mqprio)
+{
+	struct netlink_ext_ack *extack = mqprio->extack;
+	struct tc_mqprio_qopt *qopt = &mqprio->qopt;
+	u32 offset, count, num_stack_tx_queues = 0;
+	struct net_device *ndev = priv->dev;
+	u32 num_tc = qopt->num_tc;
+	int err;
+
+	if (!num_tc) {
+		stmmac_reset_tc_mqprio(ndev, extack);
+		return 0;
+	}
+
+	err = netdev_set_num_tc(ndev, num_tc);
+	if (err)
+		return err;
+
+	for (u32 tc = 0; tc < num_tc; tc++) {
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
+	err = stmmac_fpe_map_preemption_class(priv, ndev, extack,
+					      mqprio->preemptible_tcs);
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
+static int tc_setup_mqprio_unimplemented(struct stmmac_priv *priv,
+					 struct tc_mqprio_qopt_offload *mqprio)
+{
+	NL_SET_ERR_MSG_MOD(mqprio->extack,
+			   "mqprio HW offload is not implemented for this MAC");
+	return -EOPNOTSUPP;
+}
+
+const struct stmmac_tc_ops dwmac4_tc_ops = {
+	.init = tc_init,
+	.setup_cls_u32 = tc_setup_cls_u32,
+	.setup_cbs = tc_setup_cbs,
+	.setup_cls = tc_setup_cls,
+	.setup_taprio = tc_setup_taprio,
+	.setup_etf = tc_setup_etf,
+	.query_caps = tc_query_caps,
+	.setup_mqprio = tc_setup_mqprio_unimplemented,
+};
+
 const struct stmmac_tc_ops dwmac510_tc_ops = {
 	.init = tc_init,
 	.setup_cls_u32 = tc_setup_cls_u32,
@@ -1198,4 +1280,16 @@ const struct stmmac_tc_ops dwmac510_tc_ops = {
 	.setup_taprio = tc_setup_taprio,
 	.setup_etf = tc_setup_etf,
 	.query_caps = tc_query_caps,
+	.setup_mqprio = tc_setup_dwmac510_mqprio,
+};
+
+const struct stmmac_tc_ops dwxgmac_tc_ops = {
+	.init = tc_init,
+	.setup_cls_u32 = tc_setup_cls_u32,
+	.setup_cbs = tc_setup_cbs,
+	.setup_cls = tc_setup_cls,
+	.setup_taprio = tc_setup_taprio,
+	.setup_etf = tc_setup_etf,
+	.query_caps = tc_query_caps,
+	.setup_mqprio = tc_setup_mqprio_unimplemented,
 };
-- 
2.34.1


