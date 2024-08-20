Return-Path: <netdev+bounces-120118-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F195E9585A2
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 13:21:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 211DC1C23C7A
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 11:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C937F18DF93;
	Tue, 20 Aug 2024 11:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Az8Boz3d"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2790418E351;
	Tue, 20 Aug 2024 11:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724152888; cv=none; b=Q3VKkktYmLsHnL+9oIFEXtyR7QDgaDSI6wC1trMqDeb3ylKFLHB1cMhs9YteQPxOK8obkxHe2cpv5Nqir/jZwfearJNaVLIuUhpjeLsrqk2lzBijjycSRSdKBGkNhNDB424gPH4WPPBAtdGnTHVtsNafkOF5J5YUrnXVaCqUSEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724152888; c=relaxed/simple;
	bh=hVTY6QOwRVHPADme68EqF4od9AjpIfiTYMfVElz2td4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=irIyvCrkhDgPp/3bfgedWWbH1aMFFmdeMQ1tkD5o+rCQ5OgmmPB3x+t3UByRLYoLzhPgPuh8C0/cGMPFuJfyJlcpH7mWpJ1YRu9kXkd6TclCKDMPffdkIbUf06+/81nDTUre2AH0vVMJqcqdzXDz+caAKEoxXsDO1dxLEHYhmV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Az8Boz3d; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-714187df604so111666b3a.1;
        Tue, 20 Aug 2024 04:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724152886; x=1724757686; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g7SyoZHnYM2LI5K05hiBb+2ztbIHleQxiNZgpgIVXhw=;
        b=Az8Boz3dZzkzUlC5MF9T/8EQkv3SDTHnzTvSC6TqQMj5cINGoD/lP+ah9kNObQOSEW
         LYI5Z1yHLrWySaaCbnMmRF0Lv4QzhzfVYjqcPrrj+xTjFl6e2wv6gFo0gh8DptcJdyLF
         67ulnWyxdtFPOrGuMEInZQHSo85CcAFSOdrH6lkoe5j+clwZF7Zg+twEUpRDYobUBIhx
         8Yua4y/6PlSnKmsvXYM64EA4+R968Jeep4y/zlQWBVfH4isTUKZ9fDXYj244H56qExU/
         eKY3+xHIB8NWzviH3xoK41WF5U/PU5PRM9nniPoSTA3WsFSxM4DuAVIXnz+puSZrSMjo
         WaIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724152886; x=1724757686;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g7SyoZHnYM2LI5K05hiBb+2ztbIHleQxiNZgpgIVXhw=;
        b=lOyKvYMRYP8paEt3nwMVOIp9uY3VGvkqs3aLeinYH+VWrgg1b0Du800n5YEcbXpgrz
         f+5OjVBXJTsIsBNEaP+HwCgz5Q9+9EMZmZZfGCie9Sbce5EbKnWZWH0bChvU5ISGAxz9
         wovrAbfGYjbYpQgsDANLalu0PYngofbGjZCyd2cSZIDjtEU+jT3Tee26RQq0GZk4oewb
         IXHuC3ZruwN0Gp8aztYQr/vV1kyZAZaQLA/Gdr0RLBnjm8XyKkYwpFZ/7UCkjEaHh01v
         +GPyf9jhD/hOKIdy16K13DJMOcFivr7IO6MrUvmKRq9euSvzXyzWJZgwzJjN7qH4/pJj
         HUGA==
X-Forwarded-Encrypted: i=1; AJvYcCWLKOLc4k96Uo2m0z0qjtiXnldo49tX9TWUnUxSnL2zSSMyG/ameFQ9fZHhsSctlfUZXQ7KXUlyrb4pzgFD8BwcJt8BfMp4ttlYIALk
X-Gm-Message-State: AOJu0YzcievH787mnzIO6woKogL3M6k47QMp01W2TQ7sj6xBkG8V2E/g
	MuR2yxrCYH3C34lyzpXsLDRAldPD/T2tCgDfnVNb8YdgoooBqurO
X-Google-Smtp-Source: AGHT+IFuyw7nrLnv3O6ckoG5u7U3xQFtd3l/rn5w9Jo1yx2l1aOHO7p6V2AuYfz9IXurZteA0/GBJg==
X-Received: by 2002:a17:902:d4ca:b0:201:e2db:7be7 with SMTP id d9443c01a7336-2025f097e26mr31823355ad.13.1724152886040;
        Tue, 20 Aug 2024 04:21:26 -0700 (PDT)
Received: from localhost.localdomain ([129.146.253.192])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-201f03756f6sm76465355ad.172.2024.08.20.04.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 04:21:25 -0700 (PDT)
From: Furong Xu <0x1207@gmail.com>
To: Serge Semin <fancer.lancer@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
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
	xfr@outlook.com,
	Furong Xu <0x1207@gmail.com>
Subject: [PATCH net-next v5 1/7] net: stmmac: move stmmac_fpe_cfg to stmmac_priv data
Date: Tue, 20 Aug 2024 19:20:35 +0800
Message-Id: <0f2db940a153db056180d9a529c4af4d6e60feb8.1724152528.git.0x1207@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1724152528.git.0x1207@gmail.com>
References: <cover.1724152528.git.0x1207@gmail.com>
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
---
 drivers/net/ethernet/stmicro/stmmac/hwif.h    |  2 ++
 drivers/net/ethernet/stmicro/stmmac/stmmac.h  | 30 ++++++++++++++++++-
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 20 ++++++-------
 .../net/ethernet/stmicro/stmmac/stmmac_tc.c   | 16 ++--------
 include/linux/stmmac.h                        | 28 -----------------
 5 files changed, 44 insertions(+), 52 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/ethernet/stmicro/stmmac/hwif.h
index 7e90f34b8c88..d3da82982012 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
@@ -26,6 +26,8 @@
 })
 
 struct stmmac_extra_stats;
+struct stmmac_fpe_cfg;
+enum   stmmac_mpacket_type;
 struct stmmac_priv;
 struct stmmac_safety_stats;
 struct dma_desc;
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


