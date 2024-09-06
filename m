Return-Path: <netdev+bounces-125959-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC6A96F6B9
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 16:31:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 847291F251D0
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 14:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E30B91D1F53;
	Fri,  6 Sep 2024 14:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lrWSwLTw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3719C1D1740;
	Fri,  6 Sep 2024 14:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725633046; cv=none; b=WiIyJlYfNvtm62juG2l/YulTqGgfkqQaQ5ynJg63iYYA6NxWVMi5nqcdRv6Rfw8Ghh1X5KVd0zeQUpPbKHg6/3ByL1DUznU4WLIjjrZq6zLBQk/os1cl6vqBopBcetzWC04Eb4zHOgVc7VdgM0uMFtMF06dYBl4UGAsm8AIEVTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725633046; c=relaxed/simple;
	bh=1HH/WFd0hn0wm0fwMNWgRsVhbBlMe7re2dPWXwHPpGI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A4EmmPCymjEHKR1DQgFK5wmLpT1j8DyFTeYBcYA/S8QvB88qtW4G0FXdLB4LXZUSMgFa9iMl6/vYe/ilW5G63esfCtUDGqoZpet9Pz9sQap9gAYDxxSgZkW/HD5F43MmSVtcI053v7nKJ+GRU6fNbnV2hVZt2XMW4zd0YwL86UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lrWSwLTw; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1fee6435a34so19197985ad.0;
        Fri, 06 Sep 2024 07:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725633044; x=1726237844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ys+dAZUSX7qkSyHoVS9H9w5gJ/q9VoC1vU6YNN+XK4o=;
        b=lrWSwLTwl8UxCZW5WtlFbrXnY3Zt8WK18kXAUmCqioQWUhH6KL15ZdvxEoyo5GI4hX
         rm195Ybi6PPY6eHoylluL/xcW/99ccU7LTn1YGgcPMAdxHhmx+gIKb4PR9iqI9z7/GJi
         9wWe7U81ifAE3Mh3W8aQLCnL1Icfz5t2KTTyZP5JV2AovnhuXaaeoskRkznKBYnQVFN/
         PTEk96QVz1grcm0TcVbKiExF9gDRVDW+Fg1j8Z8ywZkelEzLCy45qojcoSRttabkd1Lj
         yKNZntsDksoAray1sw27Z6SS8Uumsk/bWrbIdk7TqsaAv9VpnqqzM6U15IqIbLdp+yR5
         xMGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725633044; x=1726237844;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ys+dAZUSX7qkSyHoVS9H9w5gJ/q9VoC1vU6YNN+XK4o=;
        b=r3ky3KTlX/lDUebqzZj/axT9imGRJlSfcHtWm4HyMtI4pI8vKj4lMVS6Ttlt/pr1bz
         XrshTG23YDayXqrVHX1CahH/Qk57D2JE2v5K6Sr/EoOrEHrfYC0elc8zzA7cXFiobB/I
         QsiwEVm+u+zJma7Bgn713LgpXhgBZRW0kdTqZMGa0YPiSUuk0rPj1yjvl/J68YhV6WOT
         65R2G/mI1dhg/arsfR9gVNWE6jqiu6ZCF8RUsQApFTJtJf3X3IY9UatVnElVJUG4A0LR
         +mJ9wTa5PqfO8CBooKkSizpxeOhnFLiQWSi8RUUXxGO5jWXO0CzgcD/dDzpQsMLIWemZ
         IrPw==
X-Forwarded-Encrypted: i=1; AJvYcCVfaSLMo+MXbzmc5RlvvuKJ3SPdhIHLrNe6M2fMmGEt6qkoUn5jTZP2UzkXY7et+UDZagO3KIMWjTPMEEM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEBDKRdWIPVhM2KDuzMPaASaxcCU1V6vBE4WTJLz0db3oZzEj8
	45k1KrR7iuedpa4hVGm/l0N1XO2VJRhCL7+UPtNuuOrsJns2ozmx
X-Google-Smtp-Source: AGHT+IHYwxamwbKB3orjjmWpsnw/JGLV2FeNCxrlhRGEhoZBNCTBAL8DADufrdaMeB3kvPNnVAjobA==
X-Received: by 2002:a17:902:ec8a:b0:206:91e7:ba98 with SMTP id d9443c01a7336-206f0622a02mr27810025ad.50.1725633043977;
        Fri, 06 Sep 2024 07:30:43 -0700 (PDT)
Received: from localhost.localdomain ([129.146.253.192])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-206ae94dcf3sm43951975ad.80.2024.09.06.07.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 07:30:43 -0700 (PDT)
From: Furong Xu <0x1207@gmail.com>
To: Vladimir Oltean <olteanv@gmail.com>,
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
Subject: [PATCH net-next v10 1/7] net: stmmac: move stmmac_fpe_cfg to stmmac_priv data
Date: Fri,  6 Sep 2024 22:30:06 +0800
Message-Id: <d9b3d7ecb308c5e39778a4c8ae9df288a2754379.1725631883.git.0x1207@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1725631883.git.0x1207@gmail.com>
References: <cover.1725631883.git.0x1207@gmail.com>
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


