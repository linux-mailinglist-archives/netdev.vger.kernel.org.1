Return-Path: <netdev+bounces-139422-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A399C9B2370
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 04:09:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10514B21346
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 03:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 689DA189B91;
	Mon, 28 Oct 2024 03:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PZDI3U57"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5749A18801A;
	Mon, 28 Oct 2024 03:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730084897; cv=none; b=SBsrACSYl+17Ysis6bPpzBwW8kWfmrc/9JgVrHeNA1T3AUvGSraLZ75SJOZAItN8xoOJHZm0ZqsN5iTYfXzq6QckPvJIP8rnwewL9z4VqREZFLIqJxK/qxH5CrkXyu9/XQ68Nfwuk4lBdRAWUf6pbga1nR+y3q8NeU4ixSzP8wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730084897; c=relaxed/simple;
	bh=RfgT38CL6eHGwS7VJQtfvK/CHnRaILysqwErw0w3nZE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bdw9RJ6e2nhbIEFpRX1DGY+ixr4BQY1sTTCfUTQzq92mdYD+0QQr7wVLStaSSb3U0fTELEWIzcwHoopkZuYq/DsjUc+CMhSCCFveqH75lnggWzjXz+3QoaDMer0wEx4XnRSiQDRgKa7tk2HKXfZmrPANq79LU17BJw3OpJTB3vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PZDI3U57; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20c805a0753so35856315ad.0;
        Sun, 27 Oct 2024 20:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730084894; x=1730689694; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3IK0+tz6UgrWkk3eQKtuPkyttD+TXu0biBXSgNcL1KU=;
        b=PZDI3U57GFo2qCagCqHQDwp0FoZGghyMWVQKn2yM8DBhHjwkzkfXs3GdfMItmmVBbU
         OuxX/ZQlWNodaOM0VCEz1YW3zEh7dYioXyLnkMgwyNqoILSkAICCqiaEqd3OdB8d2y2W
         vuauNvyggO6ee+ITz1Vgx5Pd4sbtCgBgifVJAzXQPSfDGnP/kAvMQwM7AH/MdeWkXS9W
         BXysNcI681gSuUyKPCjZoMRZNlQF6uzZFEJ/Jm+RMzZzczq8+WnXVYcDMUS+6y9aCGpC
         illL+6aiZIwFJ4nRutM273lNKQQ0l/h4m8BtpLn2JIZ3cL17ZrDdpdlq9Yw4l6JaSbbp
         cW9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730084894; x=1730689694;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3IK0+tz6UgrWkk3eQKtuPkyttD+TXu0biBXSgNcL1KU=;
        b=N9YFUev0AD3DcEyGrOvJ1WW97buJqIDnY9F36PkjKaHNTvcj8tIkUrcRYW0dSW4rRJ
         3dTVxQFojt8IKdWG9LyO56Z2OEt6PZeC9viDP61D5MM3BZZVW0WA66ee6pXG2MIb2BPc
         I/OXt6KdKVqpV8n/8qgYkqOr6u+2vqcufcIC8btgIeluTd/0Z0UdunU75dnG5de4GSW7
         C0NB5GaklVLnTY+WCD0nN0+bwiBsxBKk+Q9FV5tzeR5OrqEllfYDEI7AbuJhMviUkict
         clk8fC4uN/HxLKG+cYVSWK3BkGN7VS4fhWgJgKfSir0hAU83gsZWJUh3LQZ/nv2+MW4p
         zmXg==
X-Forwarded-Encrypted: i=1; AJvYcCUqpBINhadnEhzsVAYp4L1eUKRwggMJfIi1sMZ9AYtjHoE44fqKvj0nKKfZrDsdl4FBBS+qUCpnH6u6GcI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwotTDEZfQiktjR98DqhjGX4BXminALWi7mQcSsSm3S4LGrcCvb
	wALbloBfoCbiMTr8Rg+N/T0YdTgY+LegW23Cr80u3Xo1xeeEcvzLKM7XYA==
X-Google-Smtp-Source: AGHT+IE1LfTy77L+XgqKFk08IJORYTgfKR/xYxHxwpKcRnPD2X0/L4nVVPTJb2xMm9Vl7axWq/7AFQ==
X-Received: by 2002:a17:902:cf0a:b0:20c:9d79:cf85 with SMTP id d9443c01a7336-210c6c932ecmr92308935ad.54.1730084894044;
        Sun, 27 Oct 2024 20:08:14 -0700 (PDT)
Received: from localhost.localdomain ([129.146.253.192])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-210bbf6d327sm41414155ad.67.2024.10.27.20.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2024 20:08:13 -0700 (PDT)
From: Furong Xu <0x1207@gmail.com>
To: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Vladimir Oltean <olteanv@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	andrew+netdev@lunn.ch,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	xfr@outlook.com,
	Furong Xu <0x1207@gmail.com>
Subject: [PATCH net-next v5 5/6] net: stmmac: xgmac: Complete FPE support
Date: Mon, 28 Oct 2024 11:07:28 +0800
Message-Id: <3126dce1a85138a7760096fc15c580a5c6bbf5c9.1730084449.git.0x1207@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1730084449.git.0x1207@gmail.com>
References: <cover.1730084449.git.0x1207@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement the necessary fpe_map_preemption_class callback for xgmac.

Signed-off-by: Furong Xu <0x1207@gmail.com>
---
 .../ethernet/stmicro/stmmac/dwxgmac2_core.c   |  2 +
 .../net/ethernet/stmicro/stmmac/stmmac_fpe.c  | 43 +++++++++++++++++++
 .../net/ethernet/stmicro/stmmac/stmmac_fpe.h  |  3 ++
 3 files changed, 48 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
index de6ffda31a80..9a60a6e8f633 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
@@ -1545,6 +1545,7 @@ const struct stmmac_ops dwxgmac210_ops = {
 	.config_l3_filter = dwxgmac2_config_l3_filter,
 	.config_l4_filter = dwxgmac2_config_l4_filter,
 	.set_arp_offload = dwxgmac2_set_arp_offload,
+	.fpe_map_preemption_class = dwxgmac3_fpe_map_preemption_class,
 };
 
 static void dwxlgmac2_rx_queue_enable(struct mac_device_info *hw, u8 mode,
@@ -1601,6 +1602,7 @@ const struct stmmac_ops dwxlgmac2_ops = {
 	.config_l3_filter = dwxgmac2_config_l3_filter,
 	.config_l4_filter = dwxgmac2_config_l4_filter,
 	.set_arp_offload = dwxgmac2_set_arp_offload,
+	.fpe_map_preemption_class = dwxgmac3_fpe_map_preemption_class,
 };
 
 int dwxgmac2_setup(struct stmmac_priv *priv)
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
index ce5dc896f9d8..541fe6ce87f7 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
@@ -350,6 +350,49 @@ int dwmac5_fpe_map_preemption_class(struct net_device *ndev,
 	return 0;
 }
 
+int dwxgmac3_fpe_map_preemption_class(struct net_device *ndev,
+				      struct netlink_ext_ack *extack, u32 pclass)
+{
+	u32 val, offset, count, preemptible_txqs = 0;
+	struct stmmac_priv *priv = netdev_priv(ndev);
+	u32 num_tc = ndev->num_tc;
+
+	if (!num_tc) {
+		/* Restore default TC:Queue mapping */
+		for (u32 i = 0; i < priv->plat->tx_queues_to_use; i++) {
+			val = readl(priv->ioaddr + XGMAC_MTL_TXQ_OPMODE(i));
+			writel(u32_replace_bits(val, i, XGMAC_Q2TCMAP),
+			       priv->ioaddr + XGMAC_MTL_TXQ_OPMODE(i));
+		}
+	}
+
+	/* Synopsys Databook:
+	 * "All Queues within a traffic class are selected in a round robin
+	 * fashion (when packets are available) when the traffic class is
+	 * selected by the scheduler for packet transmission. This is true for
+	 * any of the scheduling algorithms."
+	 */
+	for (u32 tc = 0; tc < num_tc; tc++) {
+		count = ndev->tc_to_txq[tc].count;
+		offset = ndev->tc_to_txq[tc].offset;
+
+		if (pclass & BIT(tc))
+			preemptible_txqs |= GENMASK(offset + count - 1, offset);
+
+		for (u32 i = 0; i < count; i++) {
+			val = readl(priv->ioaddr + XGMAC_MTL_TXQ_OPMODE(offset + i));
+			writel(u32_replace_bits(val, tc, XGMAC_Q2TCMAP),
+			       priv->ioaddr + XGMAC_MTL_TXQ_OPMODE(offset + i));
+		}
+	}
+
+	val = readl(priv->ioaddr + XGMAC_MTL_FPE_CTRL_STS);
+	writel(u32_replace_bits(val, preemptible_txqs, FPE_MTL_PREEMPTION_CLASS),
+	       priv->ioaddr + XGMAC_MTL_FPE_CTRL_STS);
+
+	return 0;
+}
+
 const struct stmmac_fpe_reg dwmac5_fpe_reg = {
 	.mac_fpe_reg = GMAC5_MAC_FPE_CTRL_STS,
 	.mtl_fpe_reg = GMAC5_MTL_FPE_CTRL_STS,
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.h b/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.h
index 0b601a9fd805..ea18ea738da6 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.h
@@ -34,6 +34,9 @@ void stmmac_fpe_set_add_frag_size(struct stmmac_priv *priv, u32 add_frag_size);
 
 int dwmac5_fpe_map_preemption_class(struct net_device *ndev,
 				    struct netlink_ext_ack *extack, u32 pclass);
+int dwxgmac3_fpe_map_preemption_class(struct net_device *ndev,
+				      struct netlink_ext_ack *extack,
+				      u32 pclass);
 
 extern const struct stmmac_fpe_reg dwmac5_fpe_reg;
 extern const struct stmmac_fpe_reg dwxgmac3_fpe_reg;
-- 
2.34.1


