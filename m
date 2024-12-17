Return-Path: <netdev+bounces-152523-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 209269F4742
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 10:21:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9719D1892470
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 09:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF24E1E3DC3;
	Tue, 17 Dec 2024 09:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dTB82IgN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0181DED72;
	Tue, 17 Dec 2024 09:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734427061; cv=none; b=XJrUeepQkc/X7Dm4UR/iLg29owEXONO2GT6m/+l35eXpMQvsY2CHNpslOPwS17wj+i2vvQGn6EURV0L+7GRkukguWO900hiMTzaBWPaAxo8oa/3nWtAM/0IgBdHFDQL+LnzTQY/JrafpTBAQ9ljDgGl5M9cKBXJm12hjzh00hoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734427061; c=relaxed/simple;
	bh=O2KIXg4uxtghksiCyE8Xf6ix27OoSAercp7ixIITozk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oYV5MfTo5McR1EMEXqn3CQVrTyYLJXvMmWl6PL4+BdJoihqTiVb0xwQOnYaEPwnBV0THNr1g3DXpEgooz1v6J2u8zhUsMe5dujKfWBux3VoCcW3t0q7O+J8DUzt0EAIDuTCzuzJOsqm+dF/JyMlbSK6WMYzndlcBZTv6vWR/94w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dTB82IgN; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-21661be2c2dso36780495ad.1;
        Tue, 17 Dec 2024 01:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734427059; x=1735031859; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RHB7BdWE+mdq4KW1atHm3QasLuffzsNyx3HPRXiGpvM=;
        b=dTB82IgNDhQMwa2fH+wN5d0GHfJIm+mXRupcBtkNKA0YhGLuBA/Dcgs2PjV//FHwZD
         oN6f9k5ExzKiW9bGBXbvrAZhYMFfCTYy36BxjIZ46JoVfBXaUTBUIHuAyP7qRFgGCnKg
         kBPM7Sx83e0Yd7Eg7oBEKSkeYeIiuJ3FaA57zv7Tu+x7rpI9BZZHHSrn9oVQPGZokXWs
         bvHX6aHqGw9aSPOvpjp0/VeAeYGOyvOlNESepjKezpfucS24GKuUYBdlDEblU2RFHwf/
         N1earM+8f0bcGBxaeylhydX+gpTub4YKZYaht7VDWC1OuD8CoC1G9Roy2QoBJQ3DaAHW
         lyBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734427059; x=1735031859;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RHB7BdWE+mdq4KW1atHm3QasLuffzsNyx3HPRXiGpvM=;
        b=d8GyN+AK2GcPqy0GWK8/hIO3pA1F4n/USKiJk5VJ0BxO9fF5R7CKYozGcTEvDJGKPH
         HWwaJYJl+taGkokqKlm3nheJ5SK5S0EROIZ3Q60ZtW3PyVGoBeXjT8K8uaG9jofLzZ0Q
         qwZhmaLcKU9wcU88gqUbmXSXkLNYtF6QC+PorUEoBJoy79fAYHgNTdWPur+hhgYUVXDp
         rVlxKZHqjT/0PZ5aRo/5dlxYoU4tqLFHgqdcZu37Be32ZZsCrT1XM3ApjBVca2Qi8SZO
         Yp771IG8bglNBS8gvpPbdYAewwpsZJI4cXl5V3y5bhr0YRfKEL5Imhv5x/rAvkj3ZF/3
         XI/A==
X-Forwarded-Encrypted: i=1; AJvYcCUYbesz5ypB9VxHaYRbgcIe8obi0J0gF/uQkxRI5gb8tyql9KT+b+hGgYjVev60V9xEDDXSyrsDNm384H0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjWepk6AE6gJy64lOSR3BRtbp8JrzIZbkRdOyYfjgfMJBH4sPT
	pBG6BjM7kLpKLVq6mwod3GUxZWJ6p0pAYGgW/ZRCCwoG2YDH9FZz9HbaXg==
X-Gm-Gg: ASbGnctEIhdZBDOcWbSCl/AulYp9J3v8q8Xmp3cHT6jTkkYG1gMdUYEnXlVIsOZUyok
	g/ksJ3Ziw/aVqDz47bBHsSxPIcsSsUhkC4R+OmM6XBAM2fd6HB/Al3lNGkiXXZjqrbVjLdbHsmn
	4GhAUecDgGptsKzJ44hunvQph198Ju7nB2KtQlEI+bdwOnhfmltILthr9sw2DH7sG3Xk05rynsS
	RxVYWyZw+tKcCnxGjfffkFpRd2qz12Z0jP+ILT+aDVF4c0iTRtfk37nAsz+RT9CHbTJfg==
X-Google-Smtp-Source: AGHT+IEpUUha2LoiankVqO1OxKO8y+rZTQ9zEw/8VBZ4PS0Jm8U+EJqmmiMzkJu6dtkcwNLxH8qP9g==
X-Received: by 2002:a17:903:41cd:b0:215:8ca3:3bac with SMTP id d9443c01a7336-218929a1f14mr212249005ad.16.1734427058537;
        Tue, 17 Dec 2024 01:17:38 -0800 (PST)
Received: from localhost.localdomain ([129.146.253.192])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-218a1db74e3sm55007165ad.30.2024.12.17.01.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 01:17:37 -0800 (PST)
From: Furong Xu <0x1207@gmail.com>
To: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	xfr@outlook.com,
	Furong Xu <0x1207@gmail.com>
Subject: [PATCH net v1] net: stmmac: Drop useless code related to ethtool rx-copybreak
Date: Tue, 17 Dec 2024 17:17:12 +0800
Message-Id: <20241217091712.383911-1-0x1207@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After commit 2af6106ae949 ("net: stmmac: Introducing support for Page
Pool"), these code turned to be useless and users of ethtool may get
confused about the unhandled rx-copybreak parameter.

This patch mostly reverts
commit 22ad38381547 ("stmmac: do not perform zero-copy for rx frames")

Fixes: 2af6106ae949 ("net: stmmac: Introducing support for Page Pool")
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


