Return-Path: <netdev+bounces-184919-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C3F9A97B1D
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 01:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73C2F1705BC
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 23:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84DEC21C179;
	Tue, 22 Apr 2025 23:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="eoK+REO1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16AF7215168
	for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 23:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745365025; cv=none; b=BMFTMlZrDpO/9FCGLdxB20e50lmo2fslGhhha52GFeRlbHAsTMH7Umx6xPeEX2AbEI2GYkf52+aRxFr50pK4scXsII7INit4T3/nFTjlZNCbFqqCObtiOgZyRMD4z7dpKESqljRESHDefXYKyOKanF6CRAx2IFSklaZWeAwW0eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745365025; c=relaxed/simple;
	bh=1Lh9xQBxOuG17Bk2sp9jbHAVBtXGLSME0M3TKphRe6A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aLUFaZbFmtNU6G5kTxNjG5X8L3yb6rphM7joybgI5JK5hgLomysfPWWwFxKCYwnf01/rGGaJp34TvhYYpeEAf7iMfKtbK8ofC1BZjFAWT6EncWdv2yXynMi2RX7AroaOMpTDYa5M/ZokroM58+z6/N1LIcXK3eWPvzJktin5yCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=eoK+REO1; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-400fa6eafa9so3796258b6e.1
        for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 16:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1745365021; x=1745969821; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H9wcc49qlheslgZplthXl/gBf+v4tzdV/6zbeCfByZs=;
        b=eoK+REO1Z3wgfsDHN/OXJZINnU0lz2XTfvn/S+pZSY0QksOdmrI2bfoXTrxngCxXlO
         og9zouuJ8LTV++W9RiUzlQRIyry0a+BdYeYIxieTopbHgKs8gU/VNpsQo17OCBbpU8Fb
         v4Z9NXTB7ch9xG7XyhOBAQ5/3LKKjN+/7nQzM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745365021; x=1745969821;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H9wcc49qlheslgZplthXl/gBf+v4tzdV/6zbeCfByZs=;
        b=d2ryhVlTDI0bYlxciIHNrfrqV5K1HLAXyIG4d1wekqGRoEweV8g+lqEB72GvbdpWYk
         tjGrDOZjZvasQ/x00PfyazcYvWHIWWqMUf+TonnGq43o8a/VFmU6EnhITByPC5VY8RwC
         ho3A+bIiTh5Ui8wJxrQdRuYhjSIqGf9wbLOGVdcgRsPjNalXIsJTrLcOznCoCNZgOg6U
         ZjgeYnJUIhVYC51rSafsiWmri0kx+Cw1MbpXtFyzrPIldjcJXSjtRMfKMxPZgjScXiXe
         ivQ8XP/78D0d/64Y9oSle/1OaCUzoQTk3LPjw76JA6t4dx0vTISIg8Nzv265uZZNuq2n
         jBow==
X-Forwarded-Encrypted: i=1; AJvYcCWsMmXy/8ghTBPGNe/H0PYmG5RSNElTd9XutYGENdRCzSIgVuq+sUpBr9sd5cE/tA7+YXkddmI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtzaYUCta+7tNhYtu5wrFjtgsbRx0mA8P3Rfa0NvTk7hOOM1hz
	VEv5JKlkgq5x44KT/p1S2NA9ZieZCLNA/vPXP7GQKtmLTxC5mWqmet3Xvfcx2g==
X-Gm-Gg: ASbGnctSmgY1wznEj8DFFWlsOr8QVBMIy3590sYaZXOp+mlwWw6qRLaYRifN1ATQgPh
	FjC7GtGH+0l17HQ/OkbcfDrPDBA/3FD1PsG8mcNyXWF1Xl339kknpGmnYHFikb5zmhycL4vCVSr
	MCEY6trD5VlHRDZf0f3cVepJd0SGWTYA8xmHkq2aJUajeNrLd3cXmZzGuNISdcRyKIOAW0Cqkof
	M1aRZuprPCJy+XXuvyIcUTBiHphZCP1R7ieiGOUBmT5BLh5mnfosqPlOMzY7oK3/P+JFBwTOQn9
	TPjbo/RwEQ97xFMn/2YNykE/uUXpTIJmgDmwqeUWfU2MSX31FCwbplk4nS55Xhj19otkaeJ6KZT
	N7WuLSI3E8SnhjKavpA==
X-Google-Smtp-Source: AGHT+IGGN155M15pgqMXQU1DGuV2av65BYEP0XG1H4lwYZuE5bnWiyj4X1evFAWCcMThs9x/G6RCqA==
X-Received: by 2002:a05:6808:4d08:b0:3f6:7c2c:6d07 with SMTP id 5614622812f47-401c0a7b0e2mr10558149b6e.13.1745365021063;
        Tue, 22 Apr 2025 16:37:01 -0700 (PDT)
Received: from stbirv-lnx-1.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-401beeaf403sm2333582b6e.7.2025.04.22.16.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 16:37:00 -0700 (PDT)
From: Justin Chen <justin.chen@broadcom.com>
To: devicetree@vger.kernel.org,
	netdev@vger.kernel.org
Cc: rafal@milecki.pl,
	linux@armlinux.org.uk,
	hkallweit1@gmail.com,
	bcm-kernel-feedback-list@broadcom.com,
	opendmb@gmail.com,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	andrew+netdev@lunn.ch,
	florian.fainelli@broadcom.com,
	Justin Chen <justin.chen@broadcom.com>
Subject: [PATCH net-next v2 7/8] net: bcmasp: Add support for asp-v3.0
Date: Tue, 22 Apr 2025 16:36:44 -0700
Message-Id: <20250422233645.1931036-8-justin.chen@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250422233645.1931036-1-justin.chen@broadcom.com>
References: <20250422233645.1931036-1-justin.chen@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The asp-v3.0 is a major HW revision that reduced the number of
channels and filters. The goal was to save cost by reducing the
feature set.

Changes for asp-v3.0
- Number of network filters were reduced.
- Number of channels were reduced.
- EDPKT stats were removed.
- Fix a bug with csum offload.

Signed-off-by: Justin Chen <justin.chen@broadcom.com>
---
v2
        - Use kcalloc() instead of kzalloc().
	- Removed unneeded eee_fixup NULL init.

 drivers/net/ethernet/broadcom/asp2/bcmasp.c   | 79 +++++++++++++------
 drivers/net/ethernet/broadcom/asp2/bcmasp.h   | 33 ++++++--
 .../ethernet/broadcom/asp2/bcmasp_ethtool.c   | 15 +---
 .../net/ethernet/broadcom/asp2/bcmasp_intf.c  | 13 ++-
 4 files changed, 92 insertions(+), 48 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp.c b/drivers/net/ethernet/broadcom/asp2/bcmasp.c
index 1eab37296608..fd35f4b4dc50 100644
--- a/drivers/net/ethernet/broadcom/asp2/bcmasp.c
+++ b/drivers/net/ethernet/broadcom/asp2/bcmasp.c
@@ -518,7 +518,7 @@ void bcmasp_netfilt_suspend(struct bcmasp_intf *intf)
 	int ret, i;
 
 	/* Write all filters to HW */
-	for (i = 0; i < NUM_NET_FILTERS; i++) {
+	for (i = 0; i < priv->num_net_filters; i++) {
 		/* If the filter does not match the port, skip programming. */
 		if (!priv->net_filters[i].claimed ||
 		    priv->net_filters[i].port != intf->port)
@@ -551,7 +551,7 @@ int bcmasp_netfilt_get_all_active(struct bcmasp_intf *intf, u32 *rule_locs,
 	struct bcmasp_priv *priv = intf->parent;
 	int j = 0, i;
 
-	for (i = 0; i < NUM_NET_FILTERS; i++) {
+	for (i = 0; i < priv->num_net_filters; i++) {
 		if (!priv->net_filters[i].claimed ||
 		    priv->net_filters[i].port != intf->port)
 			continue;
@@ -577,7 +577,7 @@ int bcmasp_netfilt_get_active(struct bcmasp_intf *intf)
 	struct bcmasp_priv *priv = intf->parent;
 	int cnt = 0, i;
 
-	for (i = 0; i < NUM_NET_FILTERS; i++) {
+	for (i = 0; i < priv->num_net_filters; i++) {
 		if (!priv->net_filters[i].claimed ||
 		    priv->net_filters[i].port != intf->port)
 			continue;
@@ -602,7 +602,7 @@ bool bcmasp_netfilt_check_dup(struct bcmasp_intf *intf,
 	size_t fs_size = 0;
 	int i;
 
-	for (i = 0; i < NUM_NET_FILTERS; i++) {
+	for (i = 0; i < priv->num_net_filters; i++) {
 		if (!priv->net_filters[i].claimed ||
 		    priv->net_filters[i].port != intf->port)
 			continue;
@@ -670,7 +670,7 @@ struct bcmasp_net_filter *bcmasp_netfilt_get_init(struct bcmasp_intf *intf,
 	int i, open_index = -1;
 
 	/* Check whether we exceed the filter table capacity */
-	if (loc != RX_CLS_LOC_ANY && loc >= NUM_NET_FILTERS)
+	if (loc != RX_CLS_LOC_ANY && loc >= priv->num_net_filters)
 		return ERR_PTR(-EINVAL);
 
 	/* If the filter location is busy (already claimed) and we are initializing
@@ -686,7 +686,7 @@ struct bcmasp_net_filter *bcmasp_netfilt_get_init(struct bcmasp_intf *intf,
 	/* Initialize the loop index based on the desired location or from 0 */
 	i = loc == RX_CLS_LOC_ANY ? 0 : loc;
 
-	for ( ; i < NUM_NET_FILTERS; i++) {
+	for ( ; i < priv->num_net_filters; i++) {
 		/* Found matching network filter */
 		if (!init &&
 		    priv->net_filters[i].claimed &&
@@ -779,7 +779,7 @@ static void bcmasp_en_mda_filter(struct bcmasp_intf *intf, bool en,
 	priv->mda_filters[i].en = en;
 	priv->mda_filters[i].port = intf->port;
 
-	rx_filter_core_wl(priv, ((intf->channel + 8) |
+	rx_filter_core_wl(priv, ((intf->channel + priv->tx_chan_offset) |
 			  (en << ASP_RX_FILTER_MDA_CFG_EN_SHIFT) |
 			  ASP_RX_FILTER_MDA_CFG_UMC_SEL(intf->port)),
 			  ASP_RX_FILTER_MDA_CFG(i));
@@ -865,7 +865,7 @@ void bcmasp_disable_all_filters(struct bcmasp_intf *intf)
 	res_count = bcmasp_total_res_mda_cnt(intf->parent);
 
 	/* Disable all filters held by this port */
-	for (i = res_count; i < NUM_MDA_FILTERS; i++) {
+	for (i = res_count; i < priv->num_mda_filters; i++) {
 		if (priv->mda_filters[i].en &&
 		    priv->mda_filters[i].port == intf->port)
 			bcmasp_en_mda_filter(intf, 0, i);
@@ -909,7 +909,7 @@ int bcmasp_set_en_mda_filter(struct bcmasp_intf *intf, unsigned char *addr,
 
 	res_count = bcmasp_total_res_mda_cnt(intf->parent);
 
-	for (i = res_count; i < NUM_MDA_FILTERS; i++) {
+	for (i = res_count; i < priv->num_mda_filters; i++) {
 		/* If filter not enabled or belongs to another port skip */
 		if (!priv->mda_filters[i].en ||
 		    priv->mda_filters[i].port != intf->port)
@@ -924,7 +924,7 @@ int bcmasp_set_en_mda_filter(struct bcmasp_intf *intf, unsigned char *addr,
 	}
 
 	/* Create new filter if possible */
-	for (i = res_count; i < NUM_MDA_FILTERS; i++) {
+	for (i = res_count; i < priv->num_mda_filters; i++) {
 		if (priv->mda_filters[i].en)
 			continue;
 
@@ -944,12 +944,12 @@ static void bcmasp_core_init_filters(struct bcmasp_priv *priv)
 	/* Disable all filters and reset software view since the HW
 	 * can lose context while in deep sleep suspend states
 	 */
-	for (i = 0; i < NUM_MDA_FILTERS; i++) {
+	for (i = 0; i < priv->num_mda_filters; i++) {
 		rx_filter_core_wl(priv, 0x0, ASP_RX_FILTER_MDA_CFG(i));
 		priv->mda_filters[i].en = 0;
 	}
 
-	for (i = 0; i < NUM_NET_FILTERS; i++)
+	for (i = 0; i < priv->num_net_filters; i++)
 		rx_filter_core_wl(priv, 0x0, ASP_RX_FILTER_NET_CFG(i));
 
 	/* Top level filter enable bit should be enabled at all times, set
@@ -966,18 +966,8 @@ static void bcmasp_core_init_filters(struct bcmasp_priv *priv)
 /* ASP core initialization */
 static void bcmasp_core_init(struct bcmasp_priv *priv)
 {
-	tx_analytics_core_wl(priv, 0x0, ASP_TX_ANALYTICS_CTRL);
-	rx_analytics_core_wl(priv, 0x4, ASP_RX_ANALYTICS_CTRL);
-
-	rx_edpkt_core_wl(priv, (ASP_EDPKT_HDR_SZ_128 << ASP_EDPKT_HDR_SZ_SHIFT),
-			 ASP_EDPKT_HDR_CFG);
-	rx_edpkt_core_wl(priv,
-			 (ASP_EDPKT_ENDI_BT_SWP_WD << ASP_EDPKT_ENDI_DESC_SHIFT),
-			 ASP_EDPKT_ENDI);
-
 	rx_edpkt_core_wl(priv, 0x1b, ASP_EDPKT_BURST_BUF_PSCAL_TOUT);
 	rx_edpkt_core_wl(priv, 0x3e8, ASP_EDPKT_BURST_BUF_WRITE_TOUT);
-	rx_edpkt_core_wl(priv, 0x3e8, ASP_EDPKT_BURST_BUF_READ_TOUT);
 
 	rx_edpkt_core_wl(priv, ASP_EDPKT_ENABLE_EN, ASP_EDPKT_ENABLE);
 
@@ -1020,6 +1010,18 @@ static void bcmasp_core_clock_select_one(struct bcmasp_priv *priv, bool slow)
 	ctrl_core_wl(priv, reg, ASP_CTRL_CORE_CLOCK_SELECT);
 }
 
+static void bcmasp_core_clock_select_one_ctrl2(struct bcmasp_priv *priv, bool slow)
+{
+	u32 reg;
+
+	reg = ctrl2_core_rl(priv, ASP_CTRL2_CORE_CLOCK_SELECT);
+	if (slow)
+		reg &= ~ASP_CTRL2_CORE_CLOCK_SELECT_MAIN;
+	else
+		reg |= ASP_CTRL2_CORE_CLOCK_SELECT_MAIN;
+	ctrl2_core_wl(priv, reg, ASP_CTRL2_CORE_CLOCK_SELECT);
+}
+
 static void bcmasp_core_clock_set_ll(struct bcmasp_priv *priv, u32 clr, u32 set)
 {
 	u32 reg;
@@ -1180,22 +1182,43 @@ static void bcmasp_eee_fixup(struct bcmasp_intf *intf, bool en)
 
 static const struct bcmasp_plat_data v21_plat_data = {
 	.core_clock_select = bcmasp_core_clock_select_one,
+	.num_mda_filters = 32,
+	.num_net_filters = 32,
+	.tx_chan_offset = 8,
+	.rx_ctrl_offset = 0x0,
 };
 
 static const struct bcmasp_plat_data v22_plat_data = {
 	.core_clock_select = bcmasp_core_clock_select_many,
 	.eee_fixup = bcmasp_eee_fixup,
+	.num_mda_filters = 32,
+	.num_net_filters = 32,
+	.tx_chan_offset = 8,
+	.rx_ctrl_offset = 0x0,
+};
+
+static const struct bcmasp_plat_data v30_plat_data = {
+	.core_clock_select = bcmasp_core_clock_select_one_ctrl2,
+	.num_mda_filters = 20,
+	.num_net_filters = 16,
+	.tx_chan_offset = 0,
+	.rx_ctrl_offset = 0x10000,
 };
 
 static void bcmasp_set_pdata(struct bcmasp_priv *priv, const struct bcmasp_plat_data *pdata)
 {
 	priv->core_clock_select = pdata->core_clock_select;
 	priv->eee_fixup = pdata->eee_fixup;
+	priv->num_mda_filters = pdata->num_mda_filters;
+	priv->num_net_filters = pdata->num_net_filters;
+	priv->tx_chan_offset = pdata->tx_chan_offset;
+	priv->rx_ctrl_offset = pdata->rx_ctrl_offset;
 }
 
 static const struct of_device_id bcmasp_of_match[] = {
 	{ .compatible = "brcm,asp-v2.1", .data = &v21_plat_data },
 	{ .compatible = "brcm,asp-v2.2", .data = &v22_plat_data },
+	{ .compatible = "brcm,asp-v3.0", .data = &v30_plat_data },
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, bcmasp_of_match);
@@ -1203,6 +1226,7 @@ MODULE_DEVICE_TABLE(of, bcmasp_of_match);
 static const struct of_device_id bcmasp_mdio_of_match[] = {
 	{ .compatible = "brcm,asp-v2.1-mdio", },
 	{ .compatible = "brcm,asp-v2.2-mdio", },
+	{ .compatible = "brcm,asp-v3.0-mdio", },
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, bcmasp_mdio_of_match);
@@ -1284,6 +1308,17 @@ static int bcmasp_probe(struct platform_device *pdev)
 	 * how many interfaces come up.
 	 */
 	bcmasp_core_init(priv);
+
+	priv->mda_filters = devm_kcalloc(dev, priv->num_mda_filters,
+					 sizeof(*priv->mda_filters), GFP_KERNEL);
+	if (!priv->mda_filters)
+		return -ENOMEM;
+
+	priv->net_filters = devm_kcalloc(dev, priv->num_net_filters,
+					 sizeof(*priv->net_filters), GFP_KERNEL);
+	if (!priv->net_filters)
+		return -ENOMEM;
+
 	bcmasp_core_init_filters(priv);
 
 	ports_node = of_find_node_by_name(dev->of_node, "ethernet-ports");
diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp.h b/drivers/net/ethernet/broadcom/asp2/bcmasp.h
index 6f49ebad4e99..74adfdb50e11 100644
--- a/drivers/net/ethernet/broadcom/asp2/bcmasp.h
+++ b/drivers/net/ethernet/broadcom/asp2/bcmasp.h
@@ -363,6 +363,10 @@ struct bcmasp_mda_filter {
 struct bcmasp_plat_data {
 	void (*core_clock_select)(struct bcmasp_priv *priv, bool slow);
 	void (*eee_fixup)(struct bcmasp_intf *priv, bool en);
+	unsigned int num_mda_filters;
+	unsigned int num_net_filters;
+	unsigned int tx_chan_offset;
+	unsigned int rx_ctrl_offset;
 };
 
 struct bcmasp_priv {
@@ -379,12 +383,16 @@ struct bcmasp_priv {
 
 	void (*core_clock_select)(struct bcmasp_priv *priv, bool slow);
 	void (*eee_fixup)(struct bcmasp_intf *intf, bool en);
+	unsigned int			num_mda_filters;
+	unsigned int			num_net_filters;
+	unsigned int			tx_chan_offset;
+	unsigned int			rx_ctrl_offset;
 
 	void __iomem			*base;
 
 	struct list_head		intfs;
 
-	struct bcmasp_mda_filter	mda_filters[NUM_MDA_FILTERS];
+	struct bcmasp_mda_filter	*mda_filters;
 
 	/* MAC destination address filters lock */
 	spinlock_t			mda_lock;
@@ -392,7 +400,7 @@ struct bcmasp_priv {
 	/* Protects accesses to ASP_CTRL_CLOCK_CTRL */
 	spinlock_t			clk_lock;
 
-	struct bcmasp_net_filter	net_filters[NUM_NET_FILTERS];
+	struct bcmasp_net_filter	*net_filters;
 
 	/* Network filter lock */
 	struct mutex			net_lock;
@@ -482,8 +490,8 @@ BCMASP_FP_IO_MACRO_Q(rx_edpkt_cfg);
 #define  PKT_OFFLOAD_EPKT_IP(x)		((x) << 21)
 #define  PKT_OFFLOAD_EPKT_TP(x)		((x) << 19)
 #define  PKT_OFFLOAD_EPKT_LEN(x)	((x) << 16)
-#define  PKT_OFFLOAD_EPKT_CSUM_L3	BIT(15)
-#define  PKT_OFFLOAD_EPKT_CSUM_L2	BIT(14)
+#define  PKT_OFFLOAD_EPKT_CSUM_L4	BIT(15)
+#define  PKT_OFFLOAD_EPKT_CSUM_L3	BIT(14)
 #define  PKT_OFFLOAD_EPKT_ID(x)		((x) << 12)
 #define  PKT_OFFLOAD_EPKT_SEQ(x)	((x) << 10)
 #define  PKT_OFFLOAD_EPKT_TS(x)		((x) << 8)
@@ -515,12 +523,27 @@ BCMASP_CORE_IO_MACRO(intr2, ASP_INTR2_OFFSET);
 BCMASP_CORE_IO_MACRO(wakeup_intr2, ASP_WAKEUP_INTR2_OFFSET);
 BCMASP_CORE_IO_MACRO(tx_analytics, ASP_TX_ANALYTICS_OFFSET);
 BCMASP_CORE_IO_MACRO(rx_analytics, ASP_RX_ANALYTICS_OFFSET);
-BCMASP_CORE_IO_MACRO(rx_ctrl, ASP_RX_CTRL_OFFSET);
 BCMASP_CORE_IO_MACRO(rx_filter, ASP_RX_FILTER_OFFSET);
 BCMASP_CORE_IO_MACRO(rx_edpkt, ASP_EDPKT_OFFSET);
 BCMASP_CORE_IO_MACRO(ctrl, ASP_CTRL_OFFSET);
 BCMASP_CORE_IO_MACRO(ctrl2, ASP_CTRL2_OFFSET);
 
+#define BCMASP_CORE_IO_MACRO_OFFSET(name, offset)			\
+static inline u32 name##_core_rl(struct bcmasp_priv *priv,		\
+				 u32 off)				\
+{									\
+	u32 reg = readl_relaxed(priv->base + priv->name##_offset +	\
+				(offset) + off);			\
+	return reg;							\
+}									\
+static inline void name##_core_wl(struct bcmasp_priv *priv,		\
+				  u32 val, u32 off)			\
+{									\
+	writel_relaxed(val, priv->base + priv->name##_offset +		\
+		       (offset) + off);					\
+}
+BCMASP_CORE_IO_MACRO_OFFSET(rx_ctrl, ASP_RX_CTRL_OFFSET);
+
 struct bcmasp_intf *bcmasp_interface_create(struct bcmasp_priv *priv,
 					    struct device_node *ndev_dn, int i);
 
diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp_ethtool.c b/drivers/net/ethernet/broadcom/asp2/bcmasp_ethtool.c
index 991a87096e08..4381a4cfd8c6 100644
--- a/drivers/net/ethernet/broadcom/asp2/bcmasp_ethtool.c
+++ b/drivers/net/ethernet/broadcom/asp2/bcmasp_ethtool.c
@@ -10,7 +10,6 @@
 #include "bcmasp_intf_defs.h"
 
 enum bcmasp_stat_type {
-	BCMASP_STAT_RX_EDPKT,
 	BCMASP_STAT_RX_CTRL,
 	BCMASP_STAT_RX_CTRL_PER_INTF,
 	BCMASP_STAT_SOFT,
@@ -33,8 +32,6 @@ struct bcmasp_stats {
 	.reg_offset = offset, \
 }
 
-#define STAT_BCMASP_RX_EDPKT(str, offset) \
-	STAT_BCMASP_OFFSET(str, BCMASP_STAT_RX_EDPKT, offset)
 #define STAT_BCMASP_RX_CTRL(str, offset) \
 	STAT_BCMASP_OFFSET(str, BCMASP_STAT_RX_CTRL, offset)
 #define STAT_BCMASP_RX_CTRL_PER_INTF(str, offset) \
@@ -42,11 +39,6 @@ struct bcmasp_stats {
 
 /* Must match the order of struct bcmasp_mib_counters */
 static const struct bcmasp_stats bcmasp_gstrings_stats[] = {
-	/* EDPKT counters */
-	STAT_BCMASP_RX_EDPKT("RX Time Stamp", ASP_EDPKT_RX_TS_COUNTER),
-	STAT_BCMASP_RX_EDPKT("RX PKT Count", ASP_EDPKT_RX_PKT_CNT),
-	STAT_BCMASP_RX_EDPKT("RX PKT Buffered", ASP_EDPKT_HDR_EXTR_CNT),
-	STAT_BCMASP_RX_EDPKT("RX PKT Pushed to DRAM", ASP_EDPKT_HDR_OUT_CNT),
 	/* ASP RX control */
 	STAT_BCMASP_RX_CTRL_PER_INTF("Frames From Unimac",
 				     ASP_RX_CTRL_UMAC_0_FRAME_COUNT),
@@ -113,9 +105,6 @@ static void bcmasp_update_mib_counters(struct bcmasp_intf *intf)
 		switch (s->type) {
 		case BCMASP_STAT_SOFT:
 			continue;
-		case BCMASP_STAT_RX_EDPKT:
-			val = rx_edpkt_core_rl(intf->parent, offset);
-			break;
 		case BCMASP_STAT_RX_CTRL:
 			val = rx_ctrl_core_rl(intf->parent, offset);
 			break;
@@ -272,7 +261,7 @@ static int bcmasp_flow_get(struct bcmasp_intf *intf, struct ethtool_rxnfc *cmd)
 
 	memcpy(&cmd->fs, &nfilter->fs, sizeof(nfilter->fs));
 
-	cmd->data = NUM_NET_FILTERS;
+	cmd->data = intf->parent->num_net_filters;
 
 	return 0;
 }
@@ -319,7 +308,7 @@ static int bcmasp_get_rxnfc(struct net_device *dev, struct ethtool_rxnfc *cmd,
 		break;
 	case ETHTOOL_GRXCLSRLALL:
 		err = bcmasp_netfilt_get_all_active(intf, rule_locs, &cmd->rule_cnt);
-		cmd->data = NUM_NET_FILTERS;
+		cmd->data = intf->parent->num_net_filters;
 		break;
 	default:
 		err = -EOPNOTSUPP;
diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c b/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
index 01de05ec3ebc..0d61b8580d72 100644
--- a/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
+++ b/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
@@ -180,14 +180,14 @@ static struct sk_buff *bcmasp_csum_offload(struct net_device *dev,
 	case htons(ETH_P_IP):
 		header |= PKT_OFFLOAD_HDR_SIZE_2((ip_hdrlen(skb) >> 8) & 0xf);
 		header2 |= PKT_OFFLOAD_HDR2_SIZE_2(ip_hdrlen(skb) & 0xff);
-		epkt |= PKT_OFFLOAD_EPKT_IP(0) | PKT_OFFLOAD_EPKT_CSUM_L2;
+		epkt |= PKT_OFFLOAD_EPKT_IP(0);
 		ip_proto = ip_hdr(skb)->protocol;
 		header_cnt += 2;
 		break;
 	case htons(ETH_P_IPV6):
 		header |= PKT_OFFLOAD_HDR_SIZE_2((IP6_HLEN >> 8) & 0xf);
 		header2 |= PKT_OFFLOAD_HDR2_SIZE_2(IP6_HLEN & 0xff);
-		epkt |= PKT_OFFLOAD_EPKT_IP(1) | PKT_OFFLOAD_EPKT_CSUM_L2;
+		epkt |= PKT_OFFLOAD_EPKT_IP(1);
 		ip_proto = ipv6_hdr(skb)->nexthdr;
 		header_cnt += 2;
 		break;
@@ -198,12 +198,12 @@ static struct sk_buff *bcmasp_csum_offload(struct net_device *dev,
 	switch (ip_proto) {
 	case IPPROTO_TCP:
 		header2 |= PKT_OFFLOAD_HDR2_SIZE_3(tcp_hdrlen(skb));
-		epkt |= PKT_OFFLOAD_EPKT_TP(0) | PKT_OFFLOAD_EPKT_CSUM_L3;
+		epkt |= PKT_OFFLOAD_EPKT_TP(0) | PKT_OFFLOAD_EPKT_CSUM_L4;
 		header_cnt++;
 		break;
 	case IPPROTO_UDP:
 		header2 |= PKT_OFFLOAD_HDR2_SIZE_3(UDP_HLEN);
-		epkt |= PKT_OFFLOAD_EPKT_TP(1) | PKT_OFFLOAD_EPKT_CSUM_L3;
+		epkt |= PKT_OFFLOAD_EPKT_TP(1) | PKT_OFFLOAD_EPKT_CSUM_L4;
 		header_cnt++;
 		break;
 	default:
@@ -818,9 +818,7 @@ static void bcmasp_init_tx(struct bcmasp_intf *intf)
 	/* Tx SPB */
 	tx_spb_ctrl_wl(intf, ((intf->channel + 8) << TX_SPB_CTRL_XF_BID_SHIFT),
 		       TX_SPB_CTRL_XF_CTRL2);
-	tx_pause_ctrl_wl(intf, (1 << (intf->channel + 8)), TX_PAUSE_MAP_VECTOR);
 	tx_spb_top_wl(intf, 0x1e, TX_SPB_TOP_BLKOUT);
-	tx_spb_top_wl(intf, 0x0, TX_SPB_TOP_SPRE_BW_CTRL);
 
 	tx_spb_dma_wq(intf, intf->tx_spb_dma_addr, TX_SPB_DMA_READ);
 	tx_spb_dma_wq(intf, intf->tx_spb_dma_addr, TX_SPB_DMA_BASE);
@@ -1185,7 +1183,7 @@ static void bcmasp_map_res(struct bcmasp_priv *priv, struct bcmasp_intf *intf)
 {
 	/* Per port */
 	intf->res.umac = priv->base + UMC_OFFSET(intf);
-	intf->res.umac2fb = priv->base + (UMAC2FB_OFFSET +
+	intf->res.umac2fb = priv->base + (UMAC2FB_OFFSET + priv->rx_ctrl_offset +
 					  (intf->port * 0x4));
 	intf->res.rgmii = priv->base + RGMII_OFFSET(intf);
 
@@ -1200,7 +1198,6 @@ static void bcmasp_map_res(struct bcmasp_priv *priv, struct bcmasp_intf *intf)
 	intf->rx_edpkt_cfg = priv->base + RX_EDPKT_CFG_OFFSET(intf);
 }
 
-#define MAX_IRQ_STR_LEN		64
 struct bcmasp_intf *bcmasp_interface_create(struct bcmasp_priv *priv,
 					    struct device_node *ndev_dn, int i)
 {
-- 
2.34.1


