Return-Path: <netdev+bounces-95692-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A1B8C3142
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 14:28:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B39361F2164E
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 12:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC21955E6A;
	Sat, 11 May 2024 12:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QFKWtarb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FF9610B;
	Sat, 11 May 2024 12:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715430485; cv=none; b=t6zi2IOsqLRVhArRPRy8jCLv17NkwJtVo74uNlZqSRt8inrhFx6/B0LAnHM2Fic1kaiGkZopw/M9cu6J2wKGTGCtVgu83C2vmT+C7OR8k8ICDZ74fWSeBe1DEBM++xbUnMFHaPpknC8W+CQXMzADpxHxZcU5wJSH261Q5Q2Wb48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715430485; c=relaxed/simple;
	bh=0u2Unn3jXxKrqiFNJbIYSFpbybWl1QM+ACMETBrfguU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aVgarXoL/CpCFrxUOsPJraVGA/YFBtwGnRS9mKhMVRYCIzkVbBwghjDv0SWFsLLCLipNVR870GP7TQbdcKcQladL5RTxWsdkjyePz9DZckBm3/XLS5mIrCLGBbjFGR1iHHp5vXFMfQuy0lq1PuBvaQ4CXeDxEYqS38dFFZhOPmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QFKWtarb; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2df83058d48so36417701fa.1;
        Sat, 11 May 2024 05:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715430482; x=1716035282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/Br5ON5k/eBGe2xri5kvHWbHVRPWa+st4CjR9EmcjvI=;
        b=QFKWtarb2d5gzVbSf4jSU9hIm3msyE+vvRBh7MXqV6TP0+HgrkIiTxtmtc6IhMpMSZ
         0NQtyqxJ6PzxX0EvHD86yicLEHpKvBQNx0pdNahD/HtJi2xvm0e/2v0waxVfzxpjNbpS
         5Tb+8bSsIGg9PemHRBo57fhkVilzVPIbPVMR/rWTYeywPV0eA99QmMRvPSxG3np9MA+b
         cc8tcFhg/FfceFlKvH26V4CSoAVJLT2+7LFO15eO4gfJwqOzjsz1Io3QIpjGD3Gl3HkZ
         6Znohq1H/nUFxRiwCbUhBZDRcut3CqirLQU8YDzn714erQC2fjKv33bYXcxfcA1CSOvu
         XzkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715430482; x=1716035282;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/Br5ON5k/eBGe2xri5kvHWbHVRPWa+st4CjR9EmcjvI=;
        b=NVUgQR5mQQ7chfv0fWUa49hT8xfRMNZVfCfJoATKGvhK2tQPnJcodG0zxDiDOIiIu8
         r0RPilQW8j72AkGygWeHwQj9CuvaTDPwu7K2PcChsqeYDvLe1pP13365EKcTkkOGNk+D
         8qmNGCsypyE7qC/WqrvX7XvqqDKKGJWFo0vbnjP87x4KQoUgt+9MaUHU9BgoLEILAcQP
         yvxi43KT2oCUGXqA01AUUpQMM1SAJb2hQc9Y1IXY7xqU7v4IeQqyoRwawtJ5oMR2sQ/s
         ErRoVdjnxYq0c62yYLnBEbv1GWZEGLMb2vARpwkeX/a+Rcj7uh0eygm2OfvXC1/jy9Dl
         bf3w==
X-Forwarded-Encrypted: i=1; AJvYcCWS5jRuCdNNeKifpgW921KAFRzUVcwqlBqjBi+Yyuc30yAgJnv/IhyzE1cDw5KrmdH7TAVtDdCWftA5PN08VZ948uGy9WlXOPmm72JUtbWJT9QTq5RvzWQ0nSnMDtyGseICfF9M
X-Gm-Message-State: AOJu0YzYP10/PZJ+XTBKOXvQPVqw97cPixEar7x4GVur7vkCXTCxVBgi
	lw2KwDdSt5nbNqmVtNNel6hFkHfbCDaA+6NsAzzB85G4zrinOXrE
X-Google-Smtp-Source: AGHT+IHfg47ULkF/LEewjDpD8qjG6HLlf9y7YNx5o1FNimdDJv0pwm9hBHZbOdLMAX+Zmus6zlqWsg==
X-Received: by 2002:a2e:b0db:0:b0:2de:7cc5:7a27 with SMTP id 38308e7fff4ca-2e51fc369a0mr34047921fa.5.1715430481376;
        Sat, 11 May 2024 05:28:01 -0700 (PDT)
Received: from localhost.localdomain (IGLD-84-229-253-184.inter.net.il. [84.229.253.184])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41f87b26610sm133333335e9.8.2024.05.11.05.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 May 2024 05:28:01 -0700 (PDT)
From: Elad Yifee <eladwf@gmail.com>
To: 
Cc: eladwf@gmail.com,
	Felix Fietkau <nbd@nbd.name>,
	Sean Wang <sean.wang@mediatek.com>,
	Mark Lee <Mark-MC.Lee@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Russell King <linux@armlinux.org.uk>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH net-next v4] net: ethernet: mtk_eth_soc: ppe: add support for multiple PPEs
Date: Sat, 11 May 2024 15:26:53 +0300
Message-ID: <20240511122659.13838-1-eladwf@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the missing pieces to allow multiple PPEs units, one for each GMAC.
mtk_gdm_config has been modified to work on targted mac ID,
the inner loop moved outside of the function to allow unrelated
operations like setting the MAC's PPE index.

Signed-off-by: Elad Yifee <eladwf@gmail.com>
---
v4: 
	- applied changes suggested by Jakub Kicinski
	- modified flow_offload_replace to get the correct PPE index from flow
	- add gdma_to_ppe[x] registers to mtk_reg_map instead of using defines
v3: applied changes suggested by Daniel Golle
v2: fixed CI warnings
---
 drivers/net/ethernet/mediatek/mtk_eth_soc.c   | 106 +++++++++++-------
 drivers/net/ethernet/mediatek/mtk_eth_soc.h   |  15 ++-
 .../net/ethernet/mediatek/mtk_ppe_offload.c   |  16 ++-
 3 files changed, 91 insertions(+), 46 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index 179c0230655a..67e19bd25f7a 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -80,7 +80,9 @@ static const struct mtk_reg_map mtk_reg_map = {
 		.fq_blen	= 0x1b2c,
 	},
 	.gdm1_cnt		= 0x2400,
-	.gdma_to_ppe		= 0x4444,
+	.gdma_to_ppe	= {
+		[0]		= 0x4444,
+	},
 	.ppe_base		= 0x0c00,
 	.wdma_base = {
 		[0]		= 0x2800,
@@ -144,7 +146,10 @@ static const struct mtk_reg_map mt7986_reg_map = {
 		.tx_sch_rate	= 0x4798,
 	},
 	.gdm1_cnt		= 0x1c00,
-	.gdma_to_ppe		= 0x3333,
+	.gdma_to_ppe	= {
+		[0]		= 0x3333,
+		[1]		= 0x4444,
+	},
 	.ppe_base		= 0x2000,
 	.wdma_base = {
 		[0]		= 0x4800,
@@ -192,7 +197,11 @@ static const struct mtk_reg_map mt7988_reg_map = {
 		.tx_sch_rate	= 0x4798,
 	},
 	.gdm1_cnt		= 0x1c00,
-	.gdma_to_ppe		= 0x3333,
+	.gdma_to_ppe	= {
+		[0]		= 0x3333,
+		[1]		= 0x4444,
+		[2]		= 0xcccc,
+	},
 	.ppe_base		= 0x2000,
 	.wdma_base = {
 		[0]		= 0x4800,
@@ -2009,6 +2018,7 @@ static int mtk_poll_rx(struct napi_struct *napi, int budget,
 	struct mtk_rx_dma_v2 *rxd, trxd;
 	int done = 0, bytes = 0;
 	dma_addr_t dma_addr = DMA_MAPPING_ERROR;
+	int ppe_idx = 0;
 
 	while (done < budget) {
 		unsigned int pktlen, *rxdcsum;
@@ -2052,6 +2062,7 @@ static int mtk_poll_rx(struct napi_struct *napi, int budget,
 			goto release_desc;
 
 		netdev = eth->netdev[mac];
+		ppe_idx = eth->mac[mac]->ppe_idx;
 
 		if (unlikely(test_bit(MTK_RESETTING, &eth->state)))
 			goto release_desc;
@@ -2175,7 +2186,7 @@ static int mtk_poll_rx(struct napi_struct *napi, int budget,
 		}
 
 		if (reason == MTK_PPE_CPU_REASON_HIT_UNBIND_RATE_REACHED)
-			mtk_ppe_check_skb(eth->ppe[0], skb, hash);
+			mtk_ppe_check_skb(eth->ppe[ppe_idx], skb, hash);
 
 		skb_record_rx_queue(skb, 0);
 		napi_gro_receive(napi, skb);
@@ -3266,37 +3277,27 @@ static int mtk_start_dma(struct mtk_eth *eth)
 	return 0;
 }
 
-static void mtk_gdm_config(struct mtk_eth *eth, u32 config)
+static void mtk_gdm_config(struct mtk_eth *eth, u32 id, u32 config)
 {
-	int i;
+	u32 val;
 
 	if (MTK_HAS_CAPS(eth->soc->caps, MTK_SOC_MT7628))
 		return;
 
-	for (i = 0; i < MTK_MAX_DEVS; i++) {
-		u32 val;
-
-		if (!eth->netdev[i])
-			continue;
+	val = mtk_r32(eth, MTK_GDMA_FWD_CFG(id));
 
-		val = mtk_r32(eth, MTK_GDMA_FWD_CFG(i));
+	/* default setup the forward port to send frame to PDMA */
+	val &= ~0xffff;
 
-		/* default setup the forward port to send frame to PDMA */
-		val &= ~0xffff;
+	/* Enable RX checksum */
+	val |= MTK_GDMA_ICS_EN | MTK_GDMA_TCS_EN | MTK_GDMA_UCS_EN;
 
-		/* Enable RX checksum */
-		val |= MTK_GDMA_ICS_EN | MTK_GDMA_TCS_EN | MTK_GDMA_UCS_EN;
+	val |= config;
 
-		val |= config;
+	if (eth->netdev[id] && netdev_uses_dsa(eth->netdev[id]))
+		val |= MTK_GDMA_SPECIAL_TAG;
 
-		if (netdev_uses_dsa(eth->netdev[i]))
-			val |= MTK_GDMA_SPECIAL_TAG;
-
-		mtk_w32(eth, val, MTK_GDMA_FWD_CFG(i));
-	}
-	/* Reset and enable PSE */
-	mtk_w32(eth, RST_GL_PSE, MTK_RST_GL);
-	mtk_w32(eth, 0, MTK_RST_GL);
+	mtk_w32(eth, val, MTK_GDMA_FWD_CFG(id));
 }
 
 
@@ -3356,7 +3357,10 @@ static int mtk_open(struct net_device *dev)
 {
 	struct mtk_mac *mac = netdev_priv(dev);
 	struct mtk_eth *eth = mac->hw;
-	int i, err;
+	struct mtk_mac *target_mac;
+	int i, err, ppe_num;
+
+	ppe_num = mtk_get_ppe_num(eth);
 
 	err = phylink_of_phy_connect(mac->phylink, mac->of_node, 0);
 	if (err) {
@@ -3380,18 +3384,38 @@ static int mtk_open(struct net_device *dev)
 		for (i = 0; i < ARRAY_SIZE(eth->ppe); i++)
 			mtk_ppe_start(eth->ppe[i]);
 
-		gdm_config = soc->offload_version ? soc->reg_map->gdma_to_ppe
-						  : MTK_GDMA_TO_PDMA;
-		mtk_gdm_config(eth, gdm_config);
+		for (i = 0; i < MTK_MAX_DEVS; i++) {
+			if (!eth->netdev[i])
+				break;
+
+			target_mac = netdev_priv(eth->netdev[i]);
+			if (!soc->offload_version) {
+				target_mac->ppe_idx = 0;
+				gdm_config = MTK_GDMA_TO_PDMA;
+			} else if (ppe_num >= 3 && target_mac->id == 2) {
+				target_mac->ppe_idx = 2;
+				gdm_config = soc->reg_map->gdma_to_ppe[2];
+			} else if (ppe_num >= 2 && target_mac->id == 1) {
+				target_mac->ppe_idx = 1;
+				gdm_config = soc->reg_map->gdma_to_ppe[1];
+			} else {
+				target_mac->ppe_idx = 0;
+				gdm_config = soc->reg_map->gdma_to_ppe[0];
+			}
+			mtk_gdm_config(eth, target_mac->id, gdm_config);
+		}
+		/* Reset and enable PSE */
+		mtk_w32(eth, RST_GL_PSE, MTK_RST_GL);
+		mtk_w32(eth, 0, MTK_RST_GL);
 
 		napi_enable(&eth->tx_napi);
 		napi_enable(&eth->rx_napi);
 		mtk_tx_irq_enable(eth, MTK_TX_DONE_INT);
 		mtk_rx_irq_enable(eth, soc->txrx.rx_irq_done_mask);
 		refcount_set(&eth->dma_refcnt, 1);
-	}
-	else
+	} else {
 		refcount_inc(&eth->dma_refcnt);
+	}
 
 	phylink_start(mac->phylink);
 	netif_tx_start_all_queues(dev);
@@ -3468,7 +3492,8 @@ static int mtk_stop(struct net_device *dev)
 	if (!refcount_dec_and_test(&eth->dma_refcnt))
 		return 0;
 
-	mtk_gdm_config(eth, MTK_GDMA_DROP_ALL);
+	for (i = 0; i < MTK_MAX_DEVS; i++)
+		mtk_gdm_config(eth, i, MTK_GDMA_DROP_ALL);
 
 	mtk_tx_irq_disable(eth, MTK_TX_DONE_INT);
 	mtk_rx_irq_disable(eth, eth->soc->txrx.rx_irq_done_mask);
@@ -4949,23 +4974,24 @@ static int mtk_probe(struct platform_device *pdev)
 	}
 
 	if (eth->soc->offload_version) {
-		u32 num_ppe = mtk_is_netsys_v2_or_greater(eth) ? 2 : 1;
+		u8 ppe_num = mtk_get_ppe_num(eth);
 
-		num_ppe = min_t(u32, ARRAY_SIZE(eth->ppe), num_ppe);
-		for (i = 0; i < num_ppe; i++) {
-			u32 ppe_addr = eth->soc->reg_map->ppe_base + i * 0x400;
+		ppe_num = min_t(u8, ARRAY_SIZE(eth->ppe), ppe_num);
+		for (i = 0; i < ppe_num; i++) {
+			u32 ppe_addr = eth->soc->reg_map->ppe_base;
 
+			ppe_addr += (i == 2 ? 0xc00 : i * 0x400);
 			eth->ppe[i] = mtk_ppe_init(eth, eth->base + ppe_addr, i);
 
 			if (!eth->ppe[i]) {
 				err = -ENOMEM;
 				goto err_deinit_ppe;
 			}
-		}
+			err = mtk_eth_offload_init(eth, i);
 
-		err = mtk_eth_offload_init(eth);
-		if (err)
-			goto err_deinit_ppe;
+			if (err)
+				goto err_deinit_ppe;
+		}
 	}
 
 	for (i = 0; i < MTK_MAX_DEVS; i++) {
diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.h b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
index 723fc637027c..e4c8c8bc7e7b 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.h
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
@@ -1130,7 +1130,7 @@ struct mtk_reg_map {
 		u32	tx_sch_rate;	/* tx scheduler rate control registers */
 	} qdma;
 	u32	gdm1_cnt;
-	u32	gdma_to_ppe;
+	u32	gdma_to_ppe[3];
 	u32	ppe_base;
 	u32	wdma_base[3];
 	u32	pse_iq_sta;
@@ -1286,7 +1286,7 @@ struct mtk_eth {
 
 	struct metadata_dst		*dsa_meta[MTK_MAX_DSA_PORTS];
 
-	struct mtk_ppe			*ppe[2];
+	struct mtk_ppe			*ppe[3];
 	struct rhashtable		flow_table;
 
 	struct bpf_prog			__rcu *prog;
@@ -1311,6 +1311,7 @@ struct mtk_eth {
 struct mtk_mac {
 	int				id;
 	phy_interface_t			interface;
+	u8						ppe_idx;
 	int				speed;
 	struct device_node		*of_node;
 	struct phylink			*phylink;
@@ -1421,6 +1422,14 @@ static inline u32 mtk_get_ib2_multicast_mask(struct mtk_eth *eth)
 	return MTK_FOE_IB2_MULTICAST;
 }
 
+static inline u8 mtk_get_ppe_num(struct mtk_eth *eth)
+{
+	if (!eth->soc->offload_version)
+		return 0;
+
+	return eth->soc->version;
+}
+
 /* read the hardware status register */
 void mtk_stats_update_mac(struct mtk_mac *mac);
 
@@ -1432,7 +1441,7 @@ int mtk_gmac_sgmii_path_setup(struct mtk_eth *eth, int mac_id);
 int mtk_gmac_gephy_path_setup(struct mtk_eth *eth, int mac_id);
 int mtk_gmac_rgmii_path_setup(struct mtk_eth *eth, int mac_id);
 
-int mtk_eth_offload_init(struct mtk_eth *eth);
+int mtk_eth_offload_init(struct mtk_eth *eth, u8 id);
 int mtk_eth_setup_tc(struct net_device *dev, enum tc_setup_type type,
 		     void *type_data);
 int mtk_flow_offload_cmd(struct mtk_eth *eth, struct flow_cls_offload *cls,
diff --git a/drivers/net/ethernet/mediatek/mtk_ppe_offload.c b/drivers/net/ethernet/mediatek/mtk_ppe_offload.c
index aa262e6f4b85..fdad16c16193 100644
--- a/drivers/net/ethernet/mediatek/mtk_ppe_offload.c
+++ b/drivers/net/ethernet/mediatek/mtk_ppe_offload.c
@@ -245,10 +245,10 @@ mtk_flow_offload_replace(struct mtk_eth *eth, struct flow_cls_offload *f,
 			 int ppe_index)
 {
 	struct flow_rule *rule = flow_cls_offload_flow_rule(f);
+	struct net_device *idev = NULL, *odev = NULL;
 	struct flow_action_entry *act;
 	struct mtk_flow_data data = {};
 	struct mtk_foe_entry foe;
-	struct net_device *odev = NULL;
 	struct mtk_flow_entry *entry;
 	int offload_type = 0;
 	int wed_index = -1;
@@ -264,6 +264,14 @@ mtk_flow_offload_replace(struct mtk_eth *eth, struct flow_cls_offload *f,
 		struct flow_match_meta match;
 
 		flow_rule_match_meta(rule, &match);
+		if (mtk_is_netsys_v2_or_greater(eth)) {
+			idev = __dev_get_by_index(&init_net, match.key->ingress_ifindex);
+			if (idev) {
+				struct mtk_mac *mac = netdev_priv(idev);
+
+				ppe_index = mac->ppe_idx;
+			}
+		}
 	} else {
 		return -EOPNOTSUPP;
 	}
@@ -574,7 +582,7 @@ mtk_eth_setup_tc_block_cb(enum tc_setup_type type, void *type_data, void *cb_pri
 	if (type != TC_SETUP_CLSFLOWER)
 		return -EOPNOTSUPP;
 
-	return mtk_flow_offload_cmd(eth, cls, 0);
+	return mtk_flow_offload_cmd(eth, cls, mac->ppe_idx);
 }
 
 static int
@@ -637,7 +645,9 @@ int mtk_eth_setup_tc(struct net_device *dev, enum tc_setup_type type,
 	}
 }
 
-int mtk_eth_offload_init(struct mtk_eth *eth)
+int mtk_eth_offload_init(struct mtk_eth *eth, u8 id)
 {
+	if (!eth->ppe[id] || !eth->ppe[id]->foe_table)
+		return 0;
 	return rhashtable_init(&eth->flow_table, &mtk_flow_ht_params);
 }
-- 
2.44.0


