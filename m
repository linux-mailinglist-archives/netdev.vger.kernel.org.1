Return-Path: <netdev+bounces-152852-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE4C9F602A
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 09:34:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6708416379E
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 08:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E067170822;
	Wed, 18 Dec 2024 08:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hbTX3UDw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32A2161311;
	Wed, 18 Dec 2024 08:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734510871; cv=none; b=TvBSp0rpTLfwwppOAk4pJrNbigTOeth7Wf2TQ0clBxAeM5PDo7SCSpdKMmntUcD5QnOE/HsZbSF6rrsNyGdcIZZnAvTUF1yeO0+aI2+b3/ALcKxXDWjmDZVePUM6ONqGozXNiL9PRKD8wcyZ66oIIv8HHvm1lwhq2PREkNVEDCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734510871; c=relaxed/simple;
	bh=Qu0uZyK682xdyJWpnr3mmS78jFfQRA2058YbSyAr648=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=R40FpgRITLJd/WG9O3FhC0IhHV49zsz5UX9xJx5QmWUDzttOE2zGpEMJhOT/yp2A5S6YcmUigDxYcf8MlokjTu059M94iT1viCS1/7uGyu2oI8NPy968CgLxejqmgkAqNroEUfioOctSDLqdzw6ufCYXtJjeGkMXLYKv2j43+xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hbTX3UDw; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-21628b3fe7dso47895375ad.3;
        Wed, 18 Dec 2024 00:34:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734510868; x=1735115668; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TDrHezrIz5cTXpjA6dJ5uIqtYCcnxWcs7DL1g5f/WEU=;
        b=hbTX3UDwrkR8Z1RvWDjQdWZ/Wl/5r0sbqUfSc+tpV+bXgVatTwHEgxbtLSq+c0iaS7
         pNPnGxWVWBAN5qIi9Nsk7FAKTMIM8J3IKeL5B4MNNhMRE48OZwJ9i6qdA+HYp6BY8XFs
         y03hbu+e3CY2ZYN14NANpINImYJUGTGRnrmKcs8aNKq6Cva9LxM1epm+mS8Egc/KKK0m
         2/W8CQLAKwAWGrc0T7ZGnSSM4dwK44HKsYk8WDy5085wnpu7gEuGysZ7YDjDYcbSzlHt
         UtPK8QGWYT+UwzPgzmtow6MhAuTaca4nmYLSS0brVu9FudW1XdxFxJ1hCYLvF/krlxbl
         964w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734510868; x=1735115668;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TDrHezrIz5cTXpjA6dJ5uIqtYCcnxWcs7DL1g5f/WEU=;
        b=nuKAtjVd5d0dcH7Ity6076T7HOuiX8wSEOMo3FhVkqNlWLiOwq3+jMl3L9SlEhcbNF
         z3VssnR2Sgs4A5sJDjBfmWQotR3Kh9L03wp60h3cjungGe8YtdhCY0nQytM5RE0AQW20
         KyGiepa7vWmrZZtIvPLGwsDbsrRkGW68ImS0PKZ4j+B9E3NVGduz+CSunUzqZdA9RO5b
         Qkh3J8XF9js87NviULNhfNT16Qq2qMEOjr5bDkNf8t2uWqYztg1KhPiw9PGD3VrNAMF3
         gBM9vx5GazROP4NZDFndH57HiDnKrxYdTVEhZtkVQf1pD4V+bmqPdVzx6uQpIEwYZR2+
         HC8A==
X-Forwarded-Encrypted: i=1; AJvYcCXHW7EE9qcD9YH7I5SHvTtFOYUpTzhOazDV4SHQI540o7rLod6z3RdC9kCXSlKXCAiVWwlWgklH1Ssprxg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLkIhQcoydUV5+BJbZr2nl6Qb2sCT1PxFSaC6KgTQIObDWA/C8
	wftygeYekXBUWkmxzbQdjTLBLG7ANPZZvnoXvEZmgVKccpqffN8GPbIcyQ==
X-Gm-Gg: ASbGncvtAo+A/VTpT11YJfT8HrDdFAEytX1WygPBTQMc/VV5P4iuQiHzb3FNujowAMQ
	F1XCnTLO5GEtqw0cosrhPTq3KOU1foV1xRlxF2eeVUYKSDxsyTTzkadFG4qAeiIDbToKrYu37Co
	hL3nQIpfjhLasyLozxjq1pSqwtD5XEX7AKE1JiNVLKFg60s1Bi7AqxTdz+39FBO9YBjcUfCkhGo
	JbFC1oLODbXvqjY1sdjrQFXSaG0UAI8AAxMAs+GjlxC/16z9CQCrLu/eIkXd6f2gja6OA==
X-Google-Smtp-Source: AGHT+IGtJJCUk3iuXtE8y8mYuVun1NG2Fd8lbXIzpgpbU7+72x9qCy3AunOkM68r/azCHGKP3Ipq1g==
X-Received: by 2002:a17:902:ccd2:b0:216:7cef:99b3 with SMTP id d9443c01a7336-218d7280492mr30713875ad.52.1734510868506;
        Wed, 18 Dec 2024 00:34:28 -0800 (PST)
Received: from localhost.localdomain ([129.146.253.192])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-218a206a098sm70772485ad.270.2024.12.18.00.34.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 00:34:28 -0800 (PST)
From: Furong Xu <0x1207@gmail.com>
To: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	xfr@outlook.com,
	Furong Xu <0x1207@gmail.com>
Subject: [PATCH net-next v1] net: stmmac: Drop useless code related to ethtool rx-copybreak
Date: Wed, 18 Dec 2024 16:34:07 +0800
Message-Id: <20241218083407.390509-1-0x1207@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After commit 2af6106ae949 ("net: stmmac: Introducing support for Page
Pool"), the driver always copies frames to get a better performance,
zero-copy for RX frames is no more, then these code turned to be
useless and users of ethtool may get confused about the unhandled
rx-copybreak parameter.

This patch mostly reverts
commit 22ad38381547 ("stmmac: do not perform zero-copy for rx frames")

Signed-off-by: Furong Xu <0x1207@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  2 -
 .../ethernet/stmicro/stmmac/stmmac_ethtool.c  | 39 -------------------
 .../net/ethernet/stmicro/stmmac/stmmac_main.c |  5 ---
 3 files changed, 46 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index 1d86439b8a14..b8d631e559c0 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -126,7 +126,6 @@ struct stmmac_rx_queue {
 	unsigned int cur_rx;
 	unsigned int dirty_rx;
 	unsigned int buf_alloc_num;
-	u32 rx_zeroc_thresh;
 	dma_addr_t dma_rx_phy;
 	u32 rx_tail_addr;
 	unsigned int state_saved;
@@ -266,7 +265,6 @@ struct stmmac_priv {
 	int sph_cap;
 	u32 sarc_type;
 
-	unsigned int rx_copybreak;
 	u32 rx_riwt[MTL_MAX_TX_QUEUES];
 	int hwts_rx_en;
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
index 1d77389ce953..16b4d8c21c90 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
@@ -1227,43 +1227,6 @@ static int stmmac_get_ts_info(struct net_device *dev,
 		return ethtool_op_get_ts_info(dev, info);
 }
 
-static int stmmac_get_tunable(struct net_device *dev,
-			      const struct ethtool_tunable *tuna, void *data)
-{
-	struct stmmac_priv *priv = netdev_priv(dev);
-	int ret = 0;
-
-	switch (tuna->id) {
-	case ETHTOOL_RX_COPYBREAK:
-		*(u32 *)data = priv->rx_copybreak;
-		break;
-	default:
-		ret = -EINVAL;
-		break;
-	}
-
-	return ret;
-}
-
-static int stmmac_set_tunable(struct net_device *dev,
-			      const struct ethtool_tunable *tuna,
-			      const void *data)
-{
-	struct stmmac_priv *priv = netdev_priv(dev);
-	int ret = 0;
-
-	switch (tuna->id) {
-	case ETHTOOL_RX_COPYBREAK:
-		priv->rx_copybreak = *(u32 *)data;
-		break;
-	default:
-		ret = -EINVAL;
-		break;
-	}
-
-	return ret;
-}
-
 static int stmmac_get_mm(struct net_device *ndev,
 			 struct ethtool_mm_state *state)
 {
@@ -1390,8 +1353,6 @@ static const struct ethtool_ops stmmac_ethtool_ops = {
 	.set_per_queue_coalesce = stmmac_set_per_queue_coalesce,
 	.get_channels = stmmac_get_channels,
 	.set_channels = stmmac_set_channels,
-	.get_tunable = stmmac_get_tunable,
-	.set_tunable = stmmac_set_tunable,
 	.get_link_ksettings = stmmac_ethtool_get_link_ksettings,
 	.set_link_ksettings = stmmac_ethtool_set_link_ksettings,
 	.get_mm = stmmac_get_mm,
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 16b8bcfa8b11..6bc10ffe7a2b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -77,7 +77,6 @@ module_param(phyaddr, int, 0444);
 MODULE_PARM_DESC(phyaddr, "Physical device address");
 
 #define STMMAC_TX_THRESH(x)	((x)->dma_conf.dma_tx_size / 4)
-#define STMMAC_RX_THRESH(x)	((x)->dma_conf.dma_rx_size / 4)
 
 /* Limit to make sure XDP TX and slow path can coexist */
 #define STMMAC_XSK_TX_BUDGET_MAX	256
@@ -107,8 +106,6 @@ static int buf_sz = DEFAULT_BUFSIZE;
 module_param(buf_sz, int, 0644);
 MODULE_PARM_DESC(buf_sz, "DMA buffer size");
 
-#define	STMMAC_RX_COPYBREAK	256
-
 static const u32 default_msg_level = (NETIF_MSG_DRV | NETIF_MSG_PROBE |
 				      NETIF_MSG_LINK | NETIF_MSG_IFUP |
 				      NETIF_MSG_IFDOWN | NETIF_MSG_TIMER);
@@ -3927,8 +3924,6 @@ static int __stmmac_open(struct net_device *dev,
 		}
 	}
 
-	priv->rx_copybreak = STMMAC_RX_COPYBREAK;
-
 	buf_sz = dma_conf->dma_buf_sz;
 	for (int i = 0; i < MTL_MAX_TX_QUEUES; i++)
 		if (priv->dma_conf.tx_queue[i].tbs & STMMAC_TBS_EN)
-- 
2.34.1


