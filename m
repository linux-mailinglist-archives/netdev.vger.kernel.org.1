Return-Path: <netdev+bounces-183532-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0241FA90EDD
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 00:48:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DE9216D503
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 22:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76E3D24A059;
	Wed, 16 Apr 2025 22:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="CsHqaOun"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5893724293C
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 22:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744843710; cv=none; b=E6jb843j5xIfEDTZ1/+cQWe7TVcjZW/NmBhry6+AiaIDN4xJlK0KPvbFcxNot/Eh1tto+3SLoPWzmTnbOBbM2hm82l8dUXhE8hYX5JmzY8SIWoX5SzLpmorPYiv6fKTqtwvlNWMNwfb9Fb9op4OzIynoDX6zHB9rEBP7JBLBPXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744843710; c=relaxed/simple;
	bh=v4B+3gljFsdKb6seh9cwpDyTfwv4LhXiFwB6otCTqyw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LSzF52GECKOql9H77rfaUnSuH7AfydhC6ovvO7Ic9jovQDDNbitjEpNxhLCFxoW5Nzo+vLsAodOMdNJZErjYcc1CyzxTI++xVtsR0Ik+PcSzd3tsPrJWswvHcpHR0+qaW//KMTMd1y9eoqYBzQNS5stWUEoTG4xys2lQIr7qiRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=CsHqaOun; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-72c1425fbfcso85059a34.3
        for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 15:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1744843707; x=1745448507; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iS/WOfJJLb6Ummx3VGxSWUSwRdAmBrC7CLQN6osbYlE=;
        b=CsHqaOuniuhDlurXOdHfMYN/r8AetgKRUC/jn1cp9aIPADh6XsexfVowFpJ7BBEhGl
         N0Uu63Ni8MNK5OP1Pvk1E6Rd53UFDdQxmSPjlUAQz9b6/NrkjXMmxdM1yQbYDm66VO1+
         KpdG4CTk7hQ3oxaultdpsN6eJY5GgB2ZiYEqM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744843707; x=1745448507;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iS/WOfJJLb6Ummx3VGxSWUSwRdAmBrC7CLQN6osbYlE=;
        b=xUMJsQyPRMDCdEm9fzYA2Sm0qon4cmqAGEP2aw8TK1bDAdWuRHHTneYyFy7TyGkGRg
         FaUuHBJy/+gIedYRS2a6gedGcMFwG2Vay/kEgQNo98/MGPHWftgz+h3MmtMJbW/dBurZ
         EMp2jpq5cC6e+BmdS9rak4Qz5KOhmpg0Myk3/ZPkaDwV5uYgQf2olLPvRIs6vtfr6irU
         S8EFMP9jJ1LVLBSNNpxqFEVWpyeYEkQVrYVRDZRUSxSJsP9GLQqf64YMhJDFaSkiWQtL
         1JekU0GdZeywLHeAO9Kbgd9zcnBnUvDUT2V4kUqxxF6CDlSuWgezWlk/uPkZzDIL2hzh
         PLRw==
X-Gm-Message-State: AOJu0YyG3QKZsDyG85zhl0P+F9Y3gXFna1FZEC0s4KNGI18yt4tcGVYp
	nBuKy8xfgwDqCV/BJRosg/BxvaflCtzzQpqrUetDadakg8BoKehzBDpeQ1etl7CaYSYnx9+fGRO
	ums2qgljqrZj33jReNkJeldOWL1RehY7CFvRRIshmxDmtPEnPOTRnLC5IfTO/SIja6XnziyE134
	DpO7gbVCeaACIFW9LtFQiRaGe9QxQRJ0uYTSuLl8c=
X-Gm-Gg: ASbGncvq5hEkT/R/xSVI+0UUvVOJ65VW5saMlptWyYZkpqWdI2zUaIfHtlDutaegRT6
	DgsW0WxIQ4mY763tG8L5KBC6K/8/MsE2xek+W+ZLre28pLydxeKACBqmkhgBpHEGFKNJNbAb7cq
	YP3pbeV+aBVqdBK5A42+hSSKLV+qGFEKaxpgbfPeFKO9+MUE2B4BRkH3E6UZOXTBKHx1wGn08iX
	77uzxLSTk7my9bOZhTJRQHN86XpIU8URiHuKLvRRQyw+dHfjrnl+pHmMz2q9awrCZGbaOWYUtna
	6KhWp5vstrXM0FiDi4KnPlGNAINFcpJ1fsFzKrMg99DLQuzRyCIFKBD+yC9kJxDEudoCvvAmNlK
	3NlKrZ4q6I6wEdWmR/Q==
X-Google-Smtp-Source: AGHT+IFXTQ7iDG6CKa6yOnQwPt42o8CUXLpux511COxNo8yqDrmrrHiIbxpS+nfftd/6PDdEf5KyPw==
X-Received: by 2002:a05:6830:270d:b0:72c:4032:76f with SMTP id 46e09a7af769-72ec6bf3cfbmr2887945a34.12.1744843707096;
        Wed, 16 Apr 2025 15:48:27 -0700 (PDT)
Received: from stbirv-lnx-1.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-72e73d71813sm3015956a34.26.2025.04.16.15.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 15:48:26 -0700 (PDT)
From: Justin Chen <justin.chen@broadcom.com>
To: netdev@vger.kernel.org,
	devicetree@vger.kernel.org
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
Subject: [PATCH net-next 4/5] net: bcmasp: Add support for asp-v3.0
Date: Wed, 16 Apr 2025 15:48:14 -0700
Message-Id: <20250416224815.2863862-5-justin.chen@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250416224815.2863862-1-justin.chen@broadcom.com>
References: <20250416224815.2863862-1-justin.chen@broadcom.com>
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
 drivers/net/ethernet/broadcom/asp2/bcmasp.c   | 82 +++++++++++++------
 drivers/net/ethernet/broadcom/asp2/bcmasp.h   | 33 ++++++--
 .../ethernet/broadcom/asp2/bcmasp_ethtool.c   | 15 +---
 .../net/ethernet/broadcom/asp2/bcmasp_intf.c  | 13 ++-
 4 files changed, 94 insertions(+), 49 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp.c b/drivers/net/ethernet/broadcom/asp2/bcmasp.c
index b00e24e871a2..66ec01eb599c 100644
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
@@ -1180,23 +1182,45 @@ static void bcmasp_eee_fixup(struct bcmasp_intf *intf, bool en)
 
 static const struct bcmasp_plat_data v21_plat_data = {
 	.core_clock_select = bcmasp_core_clock_select_one,
-	.eee_fixup = NULL;
+	.eee_fixup = NULL,
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
+	.eee_fixup = NULL,
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
@@ -1204,6 +1228,7 @@ MODULE_DEVICE_TABLE(of, bcmasp_of_match);
 static const struct of_device_id bcmasp_mdio_of_match[] = {
 	{ .compatible = "brcm,asp-v2.1-mdio", },
 	{ .compatible = "brcm,asp-v2.2-mdio", },
+	{ .compatible = "brcm,asp-v3.0-mdio", },
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, bcmasp_mdio_of_match);
@@ -1285,6 +1310,17 @@ static int bcmasp_probe(struct platform_device *pdev)
 	 * how many interfaces come up.
 	 */
 	bcmasp_core_init(priv);
+
+	priv->mda_filters = devm_kzalloc(dev, sizeof(*priv->mda_filters)
+					 * priv->num_mda_filters, GFP_KERNEL);
+	if (!priv->mda_filters)
+		return -ENOMEM;
+
+	priv->net_filters = devm_kzalloc(dev, sizeof(*priv->net_filters)
+					 * priv->num_net_filters, GFP_KERNEL);
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


