Return-Path: <netdev+bounces-101721-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D3E8FFDF1
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 10:23:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05E121C22841
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 08:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C3E15A878;
	Fri,  7 Jun 2024 08:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zci7aiSL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C93D14AA9;
	Fri,  7 Jun 2024 08:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717748593; cv=none; b=CW0gIt8g3mTk+gwrjf5C9WK5ArWtEVucMyIdYHeflPbHzlHf/ngopWUysQSDgQa6TDc5II29ZV5XKKtbj+r9zDiUY3hBvYtrVUA1dtWYT1QNWoiMn+GBDCIeoFA7OKT0iazhKo8U1VZ0q/e2PKwAjH4GGmP1yWkKEUvYVvjTGlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717748593; c=relaxed/simple;
	bh=nOA+nIhN6svhcX4J/AET+f0Jp25TmNTAoJD8P/jDMnA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LEj0gEKBNo7SgDFoMfMGyoEnqZ8BbdGzN/jrQbTOsNrJPbP50ZswSv4rKrvKgsc4kRqHX6y/L+arTbesALZjVuR0hWAETVtsPK6BwI6OHLsD2vRGAm1ZBCzxiuLHCmhKXUmzJUFt1AwMqhx+v7iM/ffy+VGqcAAEj9PNDTyBzsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zci7aiSL; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52b8b7b8698so2365154e87.1;
        Fri, 07 Jun 2024 01:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717748590; x=1718353390; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Xki4DNxYH3tFmPh5FhgKcaBCEtbRud3Q1n3Xe5OAwZw=;
        b=Zci7aiSL8wfPinx4eHscujW3TwDDVwEuyvpeDKes7t9iZROdRk/R4lxb75raXypfNa
         Pyqke3BmQUJH+v8jKxIoOXn2iyv1ZDgEM2dagkR3e7U2+fIOdGrfp7gbaMDjCSWqHPUJ
         SvwbcfbcVgSfrmdAO81uFuM4uCFXJjVodjtsGaV3ZFvBbzoMwFIKgb6Ss4TlZ3sjM9Tz
         mf7AINdeaSIW5MphTaNAGv6kWsnfuUsvxXmwvU9KrfXWDo/cCB6EXd9SP12mNdWPJD52
         hOGomCf0CnUDTsOe5NhkW769g90PDdB9+csjFCDwjoIpXXj/djP9XMsTVDnmmGASAf+Z
         4RJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717748590; x=1718353390;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xki4DNxYH3tFmPh5FhgKcaBCEtbRud3Q1n3Xe5OAwZw=;
        b=KHf5Y+N+E6MMb388Ga9lB5fcGDo6Uv2R5U2lY40Wp5xyB9ifODbCdujjut/z9emo0r
         mGW585i7EQYg0GXVk7m0oqjcshBCArnnUPn94DKojfhoq+X789Kmt0LVsn/Y9R7y2WOY
         oFbf7s0zb+is1CA2di/zswnGp0zn/YdMpjVo6dtmE+uqooHPjALL+m4lI8uiw4REVpH+
         37iopYOtIBgMzG6k/PcrPPzuKd/DZMsvvEAmJvtOe8Aq6FXmKDFDdkHZF0lEoncOLuBy
         iCkfuQk3OwDdNxtbdDCRSsM3LbulpgCl+ilASa1blKRGxIogG2SewPqeFYnruSLyHaA/
         knWw==
X-Forwarded-Encrypted: i=1; AJvYcCVsfTqwf+Ai/fs6X0BpRm7S+tK80EIvXZYcmUahqM2j0QHRn1QxTZveXGBOLXl5sO5PwqqBUPFbJlB9lZmxu6qNmHhXcNarVQhO4DSfLINIyG9zXgXWU0vALwgDQBL7fjyDxGss
X-Gm-Message-State: AOJu0YwKNkC/wp1NzhvXeoOo/eon835dULowuiTnlrpMIJRalp1ibmpO
	8kgfsOsjbbqrf8W+bA3JWxs1WJd4qk/XsygSenPe1j34UenJie84
X-Google-Smtp-Source: AGHT+IEb5i7LgkRXilX6yzFtiexWCseYnkhJBgkeCkc3DE0BW8NzvG9Xotg/hYhdnb5Fl7/6hPa3Gg==
X-Received: by 2002:a05:6512:1042:b0:52b:bdf9:d10e with SMTP id 2adb3069b0e04-52bbdf9d44cmr575079e87.19.1717748589175;
        Fri, 07 Jun 2024 01:23:09 -0700 (PDT)
Received: from localhost.localdomain (IGLD-84-229-253-184.inter.net.il. [84.229.253.184])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4215809fcbesm80592335e9.0.2024.06.07.01.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 01:23:08 -0700 (PDT)
From: Elad Yifee <eladwf@gmail.com>
To: 
Cc: eladwf@gmail.com,
	daniel@makrotopia.org,
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
Subject: [PATCH net-next v6] net: ethernet: mtk_eth_soc: ppe: add support for multiple PPEs
Date: Fri,  7 Jun 2024 11:21:50 +0300
Message-ID: <20240607082155.20021-1-eladwf@gmail.com>
X-Mailer: git-send-email 2.45.1
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
Introduce a sanity check in flow_offload_replace to account for
non-MTK ingress devices.
Additional field 'ppe_idx' was added to struct mtk_mac in order
to keep track on the assigned PPE unit.

Signed-off-by: Elad Yifee <eladwf@gmail.com>
---
v6:
	- updated commit message
v5:	
	- add sanity check for ppe index on flow_offload_replace
	- moved ppe_num to mtk_soc_data
v4: 
	- applied changes suggested by Jakub Kicinski
	- modified flow_offload_replace to get the correct PPE index from flow
	- add gdma_to_ppe[x] registers to mtk_reg_map instead of using defines
v3: applied changes suggested by Daniel Golle
v2: fixed CI warnings
---
 drivers/net/ethernet/mediatek/mtk_eth_soc.c   | 112 +++++++++++-------
 drivers/net/ethernet/mediatek/mtk_eth_soc.h   |   8 +-
 .../net/ethernet/mediatek/mtk_ppe_offload.c   |  17 ++-
 3 files changed, 92 insertions(+), 45 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index cae46290a7ae..ef0c1cca03d1 100644
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
+	ppe_num = eth->soc->ppe_num;
 
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
 		mtk_rx_irq_enable(eth, soc->rx.irq_done_mask);
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
 	mtk_rx_irq_disable(eth, eth->soc->rx.irq_done_mask);
@@ -4949,23 +4974,24 @@ static int mtk_probe(struct platform_device *pdev)
 	}
 
 	if (eth->soc->offload_version) {
-		u32 num_ppe = mtk_is_netsys_v2_or_greater(eth) ? 2 : 1;
+		u8 ppe_num = eth->soc->ppe_num;
 
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
@@ -5070,6 +5096,7 @@ static const struct mtk_soc_data mt7621_data = {
 	.required_pctl = false,
 	.version = 1,
 	.offload_version = 1,
+	.ppe_num = 1,
 	.hash_offset = 2,
 	.foe_entry_size = MTK_FOE_ENTRY_V1_SIZE,
 	.tx = {
@@ -5095,6 +5122,7 @@ static const struct mtk_soc_data mt7622_data = {
 	.required_pctl = false,
 	.version = 1,
 	.offload_version = 2,
+	.ppe_num = 1,
 	.hash_offset = 2,
 	.has_accounting = true,
 	.foe_entry_size = MTK_FOE_ENTRY_V1_SIZE,
@@ -5120,6 +5148,7 @@ static const struct mtk_soc_data mt7623_data = {
 	.required_pctl = true,
 	.version = 1,
 	.offload_version = 1,
+	.ppe_num = 1,
 	.hash_offset = 2,
 	.foe_entry_size = MTK_FOE_ENTRY_V1_SIZE,
 	.disable_pll_modes = true,
@@ -5169,6 +5198,7 @@ static const struct mtk_soc_data mt7981_data = {
 	.required_pctl = false,
 	.version = 2,
 	.offload_version = 2,
+	.ppe_num = 2,
 	.hash_offset = 4,
 	.has_accounting = true,
 	.foe_entry_size = MTK_FOE_ENTRY_V2_SIZE,
@@ -5195,6 +5225,7 @@ static const struct mtk_soc_data mt7986_data = {
 	.required_pctl = false,
 	.version = 2,
 	.offload_version = 2,
+	.ppe_num = 2,
 	.hash_offset = 4,
 	.has_accounting = true,
 	.foe_entry_size = MTK_FOE_ENTRY_V2_SIZE,
@@ -5221,6 +5252,7 @@ static const struct mtk_soc_data mt7988_data = {
 	.required_pctl = false,
 	.version = 3,
 	.offload_version = 2,
+	.ppe_num = 3,
 	.hash_offset = 4,
 	.has_accounting = true,
 	.foe_entry_size = MTK_FOE_ENTRY_V3_SIZE,
diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.h b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
index 4eab30b44070..4b5863b68822 100644
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
@@ -1168,6 +1168,7 @@ struct mtk_soc_data {
 	u8		offload_version;
 	u8		hash_offset;
 	u8		version;
+	u8		ppe_num;
 	u16		foe_entry_size;
 	netdev_features_t hw_features;
 	bool		has_accounting;
@@ -1289,7 +1290,7 @@ struct mtk_eth {
 
 	struct metadata_dst		*dsa_meta[MTK_MAX_DSA_PORTS];
 
-	struct mtk_ppe			*ppe[2];
+	struct mtk_ppe			*ppe[3];
 	struct rhashtable		flow_table;
 
 	struct bpf_prog			__rcu *prog;
@@ -1314,6 +1315,7 @@ struct mtk_eth {
 struct mtk_mac {
 	int				id;
 	phy_interface_t			interface;
+	u8				ppe_idx;
 	int				speed;
 	struct device_node		*of_node;
 	struct phylink			*phylink;
@@ -1435,7 +1437,7 @@ int mtk_gmac_sgmii_path_setup(struct mtk_eth *eth, int mac_id);
 int mtk_gmac_gephy_path_setup(struct mtk_eth *eth, int mac_id);
 int mtk_gmac_rgmii_path_setup(struct mtk_eth *eth, int mac_id);
 
-int mtk_eth_offload_init(struct mtk_eth *eth);
+int mtk_eth_offload_init(struct mtk_eth *eth, u8 id);
 int mtk_eth_setup_tc(struct net_device *dev, enum tc_setup_type type,
 		     void *type_data);
 int mtk_flow_offload_cmd(struct mtk_eth *eth, struct flow_cls_offload *cls,
diff --git a/drivers/net/ethernet/mediatek/mtk_ppe_offload.c b/drivers/net/ethernet/mediatek/mtk_ppe_offload.c
index aa262e6f4b85..f80af73d0a1b 100644
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
@@ -264,6 +264,17 @@ mtk_flow_offload_replace(struct mtk_eth *eth, struct flow_cls_offload *f,
 		struct flow_match_meta match;
 
 		flow_rule_match_meta(rule, &match);
+		if (mtk_is_netsys_v2_or_greater(eth)) {
+			idev = __dev_get_by_index(&init_net, match.key->ingress_ifindex);
+			if (idev) {
+				struct mtk_mac *mac = netdev_priv(idev);
+
+				if (WARN_ON(mac->ppe_idx >= eth->soc->ppe_num))
+					return -EINVAL;
+
+				ppe_index = mac->ppe_idx;
+			}
+		}
 	} else {
 		return -EOPNOTSUPP;
 	}
@@ -637,7 +648,9 @@ int mtk_eth_setup_tc(struct net_device *dev, enum tc_setup_type type,
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
2.45.1


