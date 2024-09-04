Return-Path: <netdev+bounces-124934-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C77A96B682
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 11:25:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78547B2A5B2
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 09:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8758E1CCEC4;
	Wed,  4 Sep 2024 09:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bz0Ihh+Q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D326F197A7B;
	Wed,  4 Sep 2024 09:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725441737; cv=none; b=idZDAxEtoAuRyG8DDZ4SwV40BwztBXzPs0Av4lUen9GBfXN7lqllJI4c85uAwXcFfO/EcIEua5upAh/f99riDlodHG2MihTVMTje9NyqK6VZVBWjwhOy1HO6vzSe+uFUJOiQNrEAAxk/cNsU1IsdWLtS9Y9N7kAF6I4mCsrTdqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725441737; c=relaxed/simple;
	bh=1HH/WFd0hn0wm0fwMNWgRsVhbBlMe7re2dPWXwHPpGI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tbBe++JTjRKneGNu7PoxTL1sXVknOmt6W4+CY4L0oezong+lkeINntb0m5IBbwk+L8z08NAZBaD1jkeeQI1wsbOskwebIJ7mdgxBUEUPb5rjiWQm20mf+ExjrvpVEuE1mZXq3MbOkCllbuBsTi/Ry+EFBz2Y9xUs9REdD+CyIp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bz0Ihh+Q; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7143165f23fso5048179b3a.1;
        Wed, 04 Sep 2024 02:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725441735; x=1726046535; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ys+dAZUSX7qkSyHoVS9H9w5gJ/q9VoC1vU6YNN+XK4o=;
        b=bz0Ihh+QS28wjBa+ZvY3gwBNvzTmtK1YKA6904tF9bNh9CaFKv3J10+wQgx1Ab/+bU
         cJBeDsNaYgDtJx0nDf8f8xhzEU3TbS1S/x+Ck42G8VDOIAYF3HGmW6xnzHkbt/XaIkjP
         +lWSYLEj4TWD/IDDp+0gyz2Isjq8T1cGG6RJ2lCgLiP3J6Tj+IW/auQLpaKisUxUjgjo
         KH/Tu5FV5yd1gVQ+JBaFBervxJZEKrDb0Bff60aAiTuJNl2RZiC7h3fCi5L8trTXA/6d
         7uTi0D9V+/f6/rVd64+UNHZ+8Kbae9ZCIF+wrVnT7lVbZfiRPQPeHzZuI4yKXFf4dNQB
         y9rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725441735; x=1726046535;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ys+dAZUSX7qkSyHoVS9H9w5gJ/q9VoC1vU6YNN+XK4o=;
        b=f1sbPtMkMxqlGdWJV5m7ev57RXkAnXe91ouPNl+EijrOQhoMPK3L1UnxkuE0QudNqy
         5aApqWPdBr6szQTW3dq0tKugURDPVfMrlv8huDf2W7IJVDgqsQYxSHtF8fuJEXBrjRb7
         kQmmBe1utp1X1MN4ZSSWnBpdBkenKq+uqiV3Mnoo0wdp+XT1Pk8Jom78JFnFHLTuX96v
         8VPFQ4QRyo8/8hS24R0RjEQikwR2qzm37bO5PJjOV4sQ2m84lcUp6oq/8cVrBs6UIsyA
         atBgzL7LArwuQ0FbIJB8u5hp+Jb8sfcMDNk+nM36M+kejuwOaD/IHYEn8EfWsrKT43JA
         /9Jw==
X-Forwarded-Encrypted: i=1; AJvYcCWxVgcXUhocShjXCr4iM5U55j5bjYhlNs3LYyztp2ELGJImhUdEeZZtlNX2kr2XcFhJHlAaOTGcuKHUnWM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5aX62di0QkcQTOvOU7Z7z8O0tNuFy7+uFk2rJImYAEOTNm4Wr
	HdwdUlkZfljlFwgJS+BxhNUZp7Fyxp+DLgzAVQ+V5WR1BWaReDPb
X-Google-Smtp-Source: AGHT+IEylbb9HaXs7QPShvvbJuC6Sobj/Bcua2WSPA2ESSQgAqhDNWdRBoLUHgTYgHcxukbazkoB6Q==
X-Received: by 2002:a05:6a00:1393:b0:710:5848:8ae1 with SMTP id d2e1a72fcca58-7173c1e0ed8mr13384773b3a.4.1725441735065;
        Wed, 04 Sep 2024 02:22:15 -0700 (PDT)
Received: from localhost.localdomain ([129.146.253.192])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7177859968csm1232048b3a.146.2024.09.04.02.22.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 02:22:14 -0700 (PDT)
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
Subject: [PATCH net-next v7 1/7] net: stmmac: move stmmac_fpe_cfg to stmmac_priv data
Date: Wed,  4 Sep 2024 17:21:16 +0800
Message-Id: <44138ce07c7ac66549d9e0631d5542175d7ffeef.1725441317.git.0x1207@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1725441317.git.0x1207@gmail.com>
References: <cover.1725441317.git.0x1207@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

By moving the fpe_cfg field to the stmmac_priv data, stmmac_fpe_cfg
becomes platform-data eventually, instead of a run-time config.

Suggested-by: Serge Semin <fancer.lancer@gmail.com>
Signed-off-by: Furong Xu <0x1207@gmail.com>
Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/hwif.h    |  2 ++
 drivers/net/ethernet/stmicro/stmmac/stmmac.h  | 30 ++++++++++++++++++-
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 20 ++++++-------
 .../net/ethernet/stmicro/stmmac/stmmac_tc.c   | 16 ++--------
 include/linux/stmmac.h                        | 28 -----------------
 5 files changed, 44 insertions(+), 52 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/ethernet/stmicro/stmmac/hwif.h
index 7e90f34b8c88..68574798c03f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
@@ -28,6 +28,8 @@
 struct stmmac_extra_stats;
 struct stmmac_priv;
 struct stmmac_safety_stats;
+struct stmmac_fpe_cfg;
+enum stmmac_mpacket_type;
 struct dma_desc;
 struct dma_extended_desc;
 struct dma_edesc;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index b23b920eedb1..458d6b16ce21 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -146,6 +146,33 @@ struct stmmac_channel {
 	u32 index;
 };
 
+/* FPE link state */
+enum stmmac_fpe_state {
+	FPE_STATE_OFF = 0,
+	FPE_STATE_CAPABLE = 1,
+	FPE_STATE_ENTERING_ON = 2,
+	FPE_STATE_ON = 3,
+};
+
+/* FPE link-partner hand-shaking mPacket type */
+enum stmmac_mpacket_type {
+	MPACKET_VERIFY = 0,
+	MPACKET_RESPONSE = 1,
+};
+
+enum stmmac_fpe_task_state_t {
+	__FPE_REMOVING,
+	__FPE_TASK_SCHED,
+};
+
+struct stmmac_fpe_cfg {
+	bool enable;				/* FPE enable */
+	bool hs_enable;				/* FPE handshake enable */
+	enum stmmac_fpe_state lp_fpe_state;	/* Link Partner FPE state */
+	enum stmmac_fpe_state lo_fpe_state;	/* Local station FPE state */
+	u32 fpe_csr;				/* MAC_FPE_CTRL_STS reg cache */
+};
+
 struct stmmac_tc_entry {
 	bool in_use;
 	bool in_hw;
@@ -339,11 +366,12 @@ struct stmmac_priv {
 	struct workqueue_struct *wq;
 	struct work_struct service_task;
 
-	/* Workqueue for handling FPE hand-shaking */
+	/* Frame Preemption feature (FPE) */
 	unsigned long fpe_task_state;
 	struct workqueue_struct *fpe_wq;
 	struct work_struct fpe_task;
 	char wq_name[IFNAMSIZ + 4];
+	struct stmmac_fpe_cfg fpe_cfg;
 
 	/* TC Handling */
 	unsigned int tc_entries_max;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index d9fca8d1227c..529fe31f8b04 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -968,7 +968,7 @@ static void stmmac_mac_config(struct phylink_config *config, unsigned int mode,
 
 static void stmmac_fpe_link_state_handle(struct stmmac_priv *priv, bool is_up)
 {
-	struct stmmac_fpe_cfg *fpe_cfg = priv->plat->fpe_cfg;
+	struct stmmac_fpe_cfg *fpe_cfg = &priv->fpe_cfg;
 	enum stmmac_fpe_state *lo_state = &fpe_cfg->lo_fpe_state;
 	enum stmmac_fpe_state *lp_state = &fpe_cfg->lp_fpe_state;
 	bool *hs_enable = &fpe_cfg->hs_enable;
@@ -3536,7 +3536,7 @@ static int stmmac_hw_setup(struct net_device *dev, bool ptp_register)
 	if (priv->dma_cap.fpesel) {
 		stmmac_fpe_start_wq(priv);
 
-		if (priv->plat->fpe_cfg->enable)
+		if (priv->fpe_cfg.enable)
 			stmmac_fpe_handshake(priv, true);
 	}
 
@@ -5982,7 +5982,7 @@ static int stmmac_set_features(struct net_device *netdev,
 
 static void stmmac_fpe_event_status(struct stmmac_priv *priv, int status)
 {
-	struct stmmac_fpe_cfg *fpe_cfg = priv->plat->fpe_cfg;
+	struct stmmac_fpe_cfg *fpe_cfg = &priv->fpe_cfg;
 	enum stmmac_fpe_state *lo_state = &fpe_cfg->lo_fpe_state;
 	enum stmmac_fpe_state *lp_state = &fpe_cfg->lp_fpe_state;
 	bool *hs_enable = &fpe_cfg->hs_enable;
@@ -7381,7 +7381,7 @@ static void stmmac_fpe_lp_task(struct work_struct *work)
 {
 	struct stmmac_priv *priv = container_of(work, struct stmmac_priv,
 						fpe_task);
-	struct stmmac_fpe_cfg *fpe_cfg = priv->plat->fpe_cfg;
+	struct stmmac_fpe_cfg *fpe_cfg = &priv->fpe_cfg;
 	enum stmmac_fpe_state *lo_state = &fpe_cfg->lo_fpe_state;
 	enum stmmac_fpe_state *lp_state = &fpe_cfg->lp_fpe_state;
 	bool *hs_enable = &fpe_cfg->hs_enable;
@@ -7427,17 +7427,17 @@ static void stmmac_fpe_lp_task(struct work_struct *work)
 
 void stmmac_fpe_handshake(struct stmmac_priv *priv, bool enable)
 {
-	if (priv->plat->fpe_cfg->hs_enable != enable) {
+	if (priv->fpe_cfg.hs_enable != enable) {
 		if (enable) {
 			stmmac_fpe_send_mpacket(priv, priv->ioaddr,
-						priv->plat->fpe_cfg,
+						&priv->fpe_cfg,
 						MPACKET_VERIFY);
 		} else {
-			priv->plat->fpe_cfg->lo_fpe_state = FPE_STATE_OFF;
-			priv->plat->fpe_cfg->lp_fpe_state = FPE_STATE_OFF;
+			priv->fpe_cfg.lo_fpe_state = FPE_STATE_OFF;
+			priv->fpe_cfg.lp_fpe_state = FPE_STATE_OFF;
 		}
 
-		priv->plat->fpe_cfg->hs_enable = enable;
+		priv->fpe_cfg.hs_enable = enable;
 	}
 }
 
@@ -7898,7 +7898,7 @@ int stmmac_suspend(struct device *dev)
 	if (priv->dma_cap.fpesel) {
 		/* Disable FPE */
 		stmmac_fpe_configure(priv, priv->ioaddr,
-				     priv->plat->fpe_cfg,
+				     &priv->fpe_cfg,
 				     priv->plat->tx_queues_to_use,
 				     priv->plat->rx_queues_to_use, false);
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
index 996f2bcd07a2..9cc41ed01882 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
@@ -282,16 +282,6 @@ static int tc_init(struct stmmac_priv *priv)
 	if (ret)
 		return -ENOMEM;
 
-	if (!priv->plat->fpe_cfg) {
-		priv->plat->fpe_cfg = devm_kzalloc(priv->device,
-						   sizeof(*priv->plat->fpe_cfg),
-						   GFP_KERNEL);
-		if (!priv->plat->fpe_cfg)
-			return -ENOMEM;
-	} else {
-		memset(priv->plat->fpe_cfg, 0, sizeof(*priv->plat->fpe_cfg));
-	}
-
 	/* Fail silently as we can still use remaining features, e.g. CBS */
 	if (!dma_cap->frpsel)
 		return 0;
@@ -1076,7 +1066,7 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
 	/* Actual FPE register configuration will be done after FPE handshake
 	 * is success.
 	 */
-	priv->plat->fpe_cfg->enable = fpe;
+	priv->fpe_cfg.enable = fpe;
 
 	ret = stmmac_est_configure(priv, priv, priv->est,
 				   priv->plat->clk_ptp_rate);
@@ -1109,9 +1099,9 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
 		mutex_unlock(&priv->est_lock);
 	}
 
-	priv->plat->fpe_cfg->enable = false;
+	priv->fpe_cfg.enable = false;
 	stmmac_fpe_configure(priv, priv->ioaddr,
-			     priv->plat->fpe_cfg,
+			     &priv->fpe_cfg,
 			     priv->plat->tx_queues_to_use,
 			     priv->plat->rx_queues_to_use,
 			     false);
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index 338991c08f00..d79ff252cfdc 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -138,33 +138,6 @@ struct stmmac_txq_cfg {
 	int tbs_en;
 };
 
-/* FPE link state */
-enum stmmac_fpe_state {
-	FPE_STATE_OFF = 0,
-	FPE_STATE_CAPABLE = 1,
-	FPE_STATE_ENTERING_ON = 2,
-	FPE_STATE_ON = 3,
-};
-
-/* FPE link-partner hand-shaking mPacket type */
-enum stmmac_mpacket_type {
-	MPACKET_VERIFY = 0,
-	MPACKET_RESPONSE = 1,
-};
-
-enum stmmac_fpe_task_state_t {
-	__FPE_REMOVING,
-	__FPE_TASK_SCHED,
-};
-
-struct stmmac_fpe_cfg {
-	bool enable;				/* FPE enable */
-	bool hs_enable;				/* FPE handshake enable */
-	enum stmmac_fpe_state lp_fpe_state;	/* Link Partner FPE state */
-	enum stmmac_fpe_state lo_fpe_state;	/* Local station FPE state */
-	u32 fpe_csr;				/* MAC_FPE_CTRL_STS reg cache */
-};
-
 struct stmmac_safety_feature_cfg {
 	u32 tsoee;
 	u32 mrxpee;
@@ -232,7 +205,6 @@ struct plat_stmmacenet_data {
 	struct fwnode_handle *port_node;
 	struct device_node *mdio_node;
 	struct stmmac_dma_cfg *dma_cfg;
-	struct stmmac_fpe_cfg *fpe_cfg;
 	struct stmmac_safety_feature_cfg *safety_feat_cfg;
 	int clk_csr;
 	int has_gmac;
-- 
2.34.1


