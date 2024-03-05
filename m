Return-Path: <netdev+bounces-77467-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01FB1871E21
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 12:41:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6ED6F1F23876
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 11:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED5E857326;
	Tue,  5 Mar 2024 11:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b="Q2KWlfIT"
X-Original-To: netdev@vger.kernel.org
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3EE56B8A
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 11:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709638876; cv=none; b=CMFVKYLCk5oLQAYWB3ES9tcNyPYmU4aaLLtDgG+olOloozl4IX+kCBEimMPq1aehO7oK7hj4PLlcGuddSLUfKtJ+nObXZhqaUXzRbDHo5MJQ/Vi+uyUsYxNKhuJ/Qc/NsBBtKdnwQIKaLb33nU1vKIxWojH241MicmW7GIbh0nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709638876; c=relaxed/simple;
	bh=1diZ7UA7P5jrBsvj1HJ6cJ+DFow4h1zS/cUtZYbRDow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p3UrHpDKiQQXeI0YTXIoYHrp4bc/yfPVLga1HV4/SABioiFYQMkB0aU1ItEVj0PivYSs0Zgf/9TIDaSAmIBKZDAjbj+0V7PevdUQU4RJ92Zl0xZkEXBKJI75vGboBR2laD66xsU3I+DbCmzLgipqYpETupmsHq79WaIM9VJ3gi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b=Q2KWlfIT; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 202403051141129225768e253a46cc43
        for <netdev@vger.kernel.org>;
        Tue, 05 Mar 2024 12:41:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=diogo.ivo@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=UJHsqOpbeUHehtKCes8J4eWTU4aBHuvb5eX2JKiPyOg=;
 b=Q2KWlfITwXFMA+cUOlmKB6CsUmEfSN8Cv72z0CeicwaKLnnqsi3rTYoCmbYrt7AQJARkIV
 7+Lop2QggakXT7cKvvHWCQgxpBMHdjHVAeuT2zCunNJmO/LhQWm0l9e6Sq6dDeJ6YsZo8Uoq
 8EY5o5FmNi9rxAkxTX2hN7hHwCFg4=;
From: Diogo Ivo <diogo.ivo@siemens.com>
To: danishanwar@ti.com,
	rogerq@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew@lunn.ch,
	dan.carpenter@linaro.org,
	linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org
Cc: Diogo Ivo <diogo.ivo@siemens.com>,
	jan.kiszka@siemens.com
Subject: [PATCH net-next v4 08/10] net: ti: icssg-prueth: Add functions to configure SR1.0 packet classifier
Date: Tue,  5 Mar 2024 11:40:28 +0000
Message-ID: <20240305114045.388893-9-diogo.ivo@siemens.com>
In-Reply-To: <20240305114045.388893-1-diogo.ivo@siemens.com>
References: <20240305114045.388893-1-diogo.ivo@siemens.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1320519:519-21489:flowmailer

Add the functions to configure the SR1.0 packet classifier.

Based on the work of Roger Quadros in TI's 5.10 SDK [1].

[1]: https://git.ti.com/cgit/ti-linux-kernel/ti-linux-kernel/tree/?h=ti-linux-5.10.y

Co-developed-by: Jan Kiszka <jan.kiszka@siemens.com>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Signed-off-by: Diogo Ivo <diogo.ivo@siemens.com>
---
Changes in v4:
 - Fix reverse xmastree in icssg_class_ft1_add_mcast()

Changes in v3:
 - Replace local variables in icssg_class_add_mcast_sr1()
   with eth_reserved_addr_base and eth_ipv4_mcast_addr_base

 .../net/ethernet/ti/icssg/icssg_classifier.c  | 113 ++++++++++++++++--
 drivers/net/ethernet/ti/icssg/icssg_prueth.c  |   2 +-
 drivers/net/ethernet/ti/icssg/icssg_prueth.h  |   6 +-
 3 files changed, 110 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_classifier.c b/drivers/net/ethernet/ti/icssg/icssg_classifier.c
index 6df53ab17fbc..79ba47bb3602 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_classifier.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_classifier.c
@@ -274,6 +274,16 @@ static void rx_class_set_or(struct regmap *miig_rt, int slice, int n,
 	regmap_write(miig_rt, offset, data);
 }
 
+static u32 rx_class_get_or(struct regmap *miig_rt, int slice, int n)
+{
+	u32 offset, val;
+
+	offset = RX_CLASS_N_REG(slice, n, RX_CLASS_OR_EN);
+	regmap_read(miig_rt, offset, &val);
+
+	return val;
+}
+
 void icssg_class_set_host_mac_addr(struct regmap *miig_rt, const u8 *mac)
 {
 	regmap_write(miig_rt, MAC_INTERFACE_0, (u32)(mac[0] | mac[1] << 8 |
@@ -288,6 +298,26 @@ void icssg_class_set_mac_addr(struct regmap *miig_rt, int slice, u8 *mac)
 	regmap_write(miig_rt, offs[slice].mac1, (u32)(mac[4] | mac[5] << 8));
 }
 
+static void icssg_class_ft1_add_mcast(struct regmap *miig_rt, int slice,
+				      int slot, const u8 *addr, const u8 *mask)
+{
+	u32 val;
+	int i;
+
+	WARN(slot >= FT1_NUM_SLOTS, "invalid slot: %d\n", slot);
+
+	rx_class_ft1_set_da(miig_rt, slice, slot, addr);
+	rx_class_ft1_set_da_mask(miig_rt, slice, slot, mask);
+	rx_class_ft1_cfg_set_type(miig_rt, slice, slot, FT1_CFG_TYPE_EQ);
+
+	/* Enable the FT1 slot in OR enable for all classifiers */
+	for (i = 0; i < ICSSG_NUM_CLASSIFIERS_IN_USE; i++) {
+		val = rx_class_get_or(miig_rt, slice, i);
+		val |= RX_CLASS_FT_FT1_MATCH(slot);
+		rx_class_set_or(miig_rt, slice, i, val);
+	}
+}
+
 /* disable all RX traffic */
 void icssg_class_disable(struct regmap *miig_rt, int slice)
 {
@@ -331,30 +361,95 @@ void icssg_class_disable(struct regmap *miig_rt, int slice)
 	regmap_write(miig_rt, offs[slice].rx_class_cfg2, 0);
 }
 
-void icssg_class_default(struct regmap *miig_rt, int slice, bool allmulti)
+void icssg_class_default(struct regmap *miig_rt, int slice, bool allmulti,
+			 bool is_sr1)
 {
+	int num_classifiers = is_sr1 ? ICSSG_NUM_CLASSIFIERS_IN_USE : 1;
 	u32 data;
+	int n;
 
 	/* defaults */
 	icssg_class_disable(miig_rt, slice);
 
 	/* Setup Classifier */
-	/* match on Broadcast or MAC_PRU address */
-	data = RX_CLASS_FT_BC | RX_CLASS_FT_DA_P;
+	for (n = 0; n < num_classifiers; n++) {
+		/* match on Broadcast or MAC_PRU address */
+		data = RX_CLASS_FT_BC | RX_CLASS_FT_DA_P;
 
-	/* multicast */
-	if (allmulti)
-		data |= RX_CLASS_FT_MC;
+		/* multicast */
+		if (allmulti)
+			data |= RX_CLASS_FT_MC;
 
-	rx_class_set_or(miig_rt, slice, 0, data);
+		rx_class_set_or(miig_rt, slice, n, data);
 
-	/* set CFG1 for OR_OR_AND for classifier */
-	rx_class_sel_set_type(miig_rt, slice, 0, RX_CLASS_SEL_TYPE_OR_OR_AND);
+		/* set CFG1 for OR_OR_AND for classifier */
+		rx_class_sel_set_type(miig_rt, slice, n,
+				      RX_CLASS_SEL_TYPE_OR_OR_AND);
+	}
 
 	/* clear CFG2 */
 	regmap_write(miig_rt, offs[slice].rx_class_cfg2, 0);
 }
 
+void icssg_class_promiscuous_sr1(struct regmap *miig_rt, int slice)
+{
+	u32 data, offset;
+	int n;
+
+	/* defaults */
+	icssg_class_disable(miig_rt, slice);
+
+	/* Setup Classifier */
+	for (n = 0; n < ICSSG_NUM_CLASSIFIERS_IN_USE; n++) {
+		/* set RAW_MASK to bypass filters */
+		offset = RX_CLASS_GATES_N_REG(slice, n);
+		regmap_read(miig_rt, offset, &data);
+		data |= RX_CLASS_GATES_RAW_MASK;
+		regmap_write(miig_rt, offset, data);
+	}
+}
+
+void icssg_class_add_mcast_sr1(struct regmap *miig_rt, int slice,
+			       struct net_device *ndev)
+{
+	u8 mask_addr[6] = { 0, 0, 0, 0, 0, 0xff };
+	struct netdev_hw_addr *ha;
+	int slot = 2;
+
+	rx_class_ft1_set_start_len(miig_rt, slice, 0, 6);
+	/* reserve first 2 slots for
+	 *	1) 01-80-C2-00-00-XX Known Service Ethernet Multicast addresses
+	 *	2) 01-00-5e-00-00-XX Local Network Control Block
+	 *			      (224.0.0.0 - 224.0.0.255  (224.0.0/24))
+	 */
+	icssg_class_ft1_add_mcast(miig_rt, slice, 0,
+				  eth_reserved_addr_base, mask_addr);
+	icssg_class_ft1_add_mcast(miig_rt, slice, 1,
+				  eth_ipv4_mcast_addr_base, mask_addr);
+	mask_addr[5] = 0;
+	netdev_for_each_mc_addr(ha, ndev) {
+		/* skip addresses matching reserved slots */
+		if (!memcmp(eth_reserved_addr_base, ha->addr, 5) ||
+		    !memcmp(eth_ipv4_mcast_addr_base, ha->addr, 5)) {
+			netdev_dbg(ndev, "mcast skip %pM\n", ha->addr);
+			continue;
+		}
+
+		if (slot >= FT1_NUM_SLOTS) {
+			netdev_dbg(ndev,
+				   "can't add more than %d MC addresses, enabling allmulti\n",
+				   FT1_NUM_SLOTS);
+			icssg_class_default(miig_rt, slice, 1, true);
+			break;
+		}
+
+		netdev_dbg(ndev, "mcast add %pM\n", ha->addr);
+		icssg_class_ft1_add_mcast(miig_rt, slice, slot,
+					  ha->addr, mask_addr);
+		slot++;
+	}
+}
+
 /* required for SAV check */
 void icssg_ft1_set_mac_addr(struct regmap *miig_rt, int slice, u8 *mac_addr)
 {
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
index e6eac01f9f99..7d9db9683e18 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
@@ -437,7 +437,7 @@ static int emac_ndo_open(struct net_device *ndev)
 	icssg_class_set_mac_addr(prueth->miig_rt, slice, emac->mac_addr);
 	icssg_ft1_set_mac_addr(prueth->miig_rt, slice, emac->mac_addr);
 
-	icssg_class_default(prueth->miig_rt, slice, 0);
+	icssg_class_default(prueth->miig_rt, slice, 0, false);
 
 	/* Notify the stack of the actual queue counts. */
 	ret = netif_set_real_num_tx_queues(ndev, num_data_chn);
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
index c5632a2388a1..21bdb219736a 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
@@ -283,7 +283,11 @@ extern const struct dev_pm_ops prueth_dev_pm_ops;
 void icssg_class_set_mac_addr(struct regmap *miig_rt, int slice, u8 *mac);
 void icssg_class_set_host_mac_addr(struct regmap *miig_rt, const u8 *mac);
 void icssg_class_disable(struct regmap *miig_rt, int slice);
-void icssg_class_default(struct regmap *miig_rt, int slice, bool allmulti);
+void icssg_class_default(struct regmap *miig_rt, int slice, bool allmulti,
+			 bool is_sr1);
+void icssg_class_promiscuous_sr1(struct regmap *miig_rt, int slice);
+void icssg_class_add_mcast_sr1(struct regmap *miig_rt, int slice,
+			       struct net_device *ndev);
 void icssg_ft1_set_mac_addr(struct regmap *miig_rt, int slice, u8 *mac_addr);
 
 /* config helpers */
-- 
2.44.0


