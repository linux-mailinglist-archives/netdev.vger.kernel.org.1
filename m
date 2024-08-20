Return-Path: <netdev+bounces-120120-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 016189585AA
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 13:22:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 255681C24197
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 11:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D709B18E77C;
	Tue, 20 Aug 2024 11:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A/DZih0H"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A4B18E744;
	Tue, 20 Aug 2024 11:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724152899; cv=none; b=tEtKnTNrTIIVOIGnucMF+mSiNNlP/2PXLVyDkNhsukfm2c5QYtP0EXhrBgF+4jdRn2bNQ+RmOe2s0YF2P/cy0F0SZd12A2LAb2Us28agFQ+ydZJ3uyMq1euOVPlARbuLOm9zsm4H+RyY7z+KEP1AD5gD2NVIaWHpfLPdkJ8mLwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724152899; c=relaxed/simple;
	bh=itxg/M3lVuoRR78aOEGXiRnc0EI5fRs1aS+pe2oWA8g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i/+SbDJfeJDl0fBVxeUia1nQJ8L2emRt29LyNv/nc31XenA1kgv80ttyr2DTCP/4r+JHa6qE6cX77UOJACEGvo4Xf8HcDp94OpfJt7vm4gXMFtsH8FzDNsKwrsI9oekTvZ5lSYVA8J5irSmX5Q5uV18nxw7O/LVigvWUXLktZHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A/DZih0H; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20223b5c1c0so19070585ad.2;
        Tue, 20 Aug 2024 04:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724152897; x=1724757697; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YJl6m7/HvoZr28SwAJK1VeVNaeP/xxoxJA+ZuNmUMD8=;
        b=A/DZih0HeqwlD00Q7opuKMrVPQMTmNN1nqaeOk+RaZNraJGGInDmdR0IwOPnbIptgf
         03MwH94VHiJlf2X5VMO/WW23nPK20HBfVf7qsdiJ+sOD4QfisaauyfqlGpWubCsbWxc5
         uwq+XseBJMiaH0Y4tIa4dYHZ7cvHllZAwj7Fj/BP9selc4nMTPBI/TwubWs5lVWgaNUW
         BcYi83FkwXtNa851m7qjFvUuh4FODg0XkA3ePcvZMo7HY+wZKCavQr56nTjDsSPlIqpU
         WXE9/RZjcEtTiENv1KKoQtRSyGUis29i8Dts6zWIt2I0d3rN4JAkOEnYyNNHbTTc3RGK
         M1UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724152897; x=1724757697;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YJl6m7/HvoZr28SwAJK1VeVNaeP/xxoxJA+ZuNmUMD8=;
        b=N0j7h/kVvIjp3Ll8zGhX4hOe8Qt+YZ8j0+y1hP8BkY7XPcXt5jMV2SPm+lXHYNBD+7
         p8w9LEvCjeniZzAlkNBlSF0SfyffK5UfLnnanyBbTvDSNgdvMjOxfDmSXmvuggsx+yLM
         GIYQIBcB54o+j6sfG7vPfzOO6z5LEUtT9dzkMaWwd7G6/5z9c8/6FPUR/jvWVoPzDasL
         cBZorcppe2A4p7uwpF/fc1qdWdPl/aJ6g2ViiUJAXs8ZOYcuJwnck02dI614fzCBPG2R
         2hjgQ5doMsLe18KfC5YcLK/SCLXB/Hnc+e7LRc1Q/2M1yOx+h/R3vhbLEsuaA8gPccq/
         rdOw==
X-Forwarded-Encrypted: i=1; AJvYcCWdojJGdxM6tL0aYOA+TCZcetfk+RuV9EKVEpD/8ib8J9ws4yzIk95C+eBEWEcFoeGR7K/4ZYzd3xr3M+Y1N217B3oN7VbFcDWZqk1W
X-Gm-Message-State: AOJu0YxR0p+LdHiU5ynqnK7HxwN9w9kcnb9COtOoILSueeae+AUPDzz8
	Vb6CMJPsseiXrU9H2UqWzSuzdRGe4KEqZ0xMk4iPWtVIMw/gygIP
X-Google-Smtp-Source: AGHT+IGe5BFxs1AQfs90pXsGi5w0aye2mA4qHJ+p+gJsrCmYIFXiJU4W1X1G5ba0+PPEiMN3O++v+w==
X-Received: by 2002:a17:903:2303:b0:1fd:93d2:fba4 with SMTP id d9443c01a7336-20203f321efmr127668655ad.48.1724152897013;
        Tue, 20 Aug 2024 04:21:37 -0700 (PDT)
Received: from localhost.localdomain ([129.146.253.192])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-201f03756f6sm76465355ad.172.2024.08.20.04.21.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 04:21:36 -0700 (PDT)
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
Subject: [PATCH net-next v5 3/7] net: stmmac: refactor FPE verification process
Date: Tue, 20 Aug 2024 19:20:37 +0800
Message-Id: <23ec4bb2d86cb086b7d285f397411dc089a582b7.1724152528.git.0x1207@gmail.com>
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

Drop driver defined stmmac_fpe_state, and switch to common
ethtool_mm_verify_status for local TX verification status.

Local side and remote side verification processes are completely
independent. There is no reason at all to keep a local state and
a remote state.

Add a spinlock to avoid races among ISR, workqueue, link update
and register configuration.

Signed-off-by: Furong Xu <0x1207@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  21 +--
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 172 ++++++++++--------
 .../net/ethernet/stmicro/stmmac/stmmac_tc.c   |   6 -
 3 files changed, 102 insertions(+), 97 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index 458d6b16ce21..407b59f2783f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -146,14 +146,6 @@ struct stmmac_channel {
 	u32 index;
 };
 
-/* FPE link state */
-enum stmmac_fpe_state {
-	FPE_STATE_OFF = 0,
-	FPE_STATE_CAPABLE = 1,
-	FPE_STATE_ENTERING_ON = 2,
-	FPE_STATE_ON = 3,
-};
-
 /* FPE link-partner hand-shaking mPacket type */
 enum stmmac_mpacket_type {
 	MPACKET_VERIFY = 0,
@@ -166,11 +158,16 @@ enum stmmac_fpe_task_state_t {
 };
 
 struct stmmac_fpe_cfg {
-	bool enable;				/* FPE enable */
-	bool hs_enable;				/* FPE handshake enable */
-	enum stmmac_fpe_state lp_fpe_state;	/* Link Partner FPE state */
-	enum stmmac_fpe_state lo_fpe_state;	/* Local station FPE state */
+	/* Serialize access to MAC Merge state between ethtool requests
+	 * and link state updates.
+	 */
+	spinlock_t lock;
+
 	u32 fpe_csr;				/* MAC_FPE_CTRL_STS reg cache */
+	u32 verify_time;			/* see ethtool_mm_state */
+	bool pmac_enabled;			/* see ethtool_mm_state */
+	bool verify_enabled;			/* see ethtool_mm_state */
+	enum ethtool_mm_verify_status status;
 };
 
 struct stmmac_tc_entry {
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 3072ad33b105..6ae95f20b24f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -969,17 +969,21 @@ static void stmmac_mac_config(struct phylink_config *config, unsigned int mode,
 static void stmmac_fpe_link_state_handle(struct stmmac_priv *priv, bool is_up)
 {
 	struct stmmac_fpe_cfg *fpe_cfg = &priv->fpe_cfg;
-	enum stmmac_fpe_state *lo_state = &fpe_cfg->lo_fpe_state;
-	enum stmmac_fpe_state *lp_state = &fpe_cfg->lp_fpe_state;
-	bool *hs_enable = &fpe_cfg->hs_enable;
+	unsigned long flags;
+
+	spin_lock_irqsave(&priv->fpe_cfg.lock, flags);
+
+	if (!fpe_cfg->pmac_enabled)
+		goto __unlock_out;
 
-	if (is_up && *hs_enable) {
+	if (is_up && fpe_cfg->verify_enabled)
 		stmmac_fpe_send_mpacket(priv, priv->ioaddr, fpe_cfg,
 					MPACKET_VERIFY);
-	} else {
-		*lo_state = FPE_STATE_OFF;
-		*lp_state = FPE_STATE_OFF;
-	}
+	else
+		fpe_cfg->status = ETHTOOL_MM_VERIFY_STATUS_DISABLED;
+
+__unlock_out:
+	spin_unlock_irqrestore(&priv->fpe_cfg.lock, flags);
 }
 
 static void stmmac_mac_link_down(struct phylink_config *config,
@@ -4091,11 +4095,25 @@ static int stmmac_release(struct net_device *dev)
 
 	stmmac_release_ptp(priv);
 
-	pm_runtime_put(priv->device);
-
-	if (priv->dma_cap.fpesel)
+	if (priv->dma_cap.fpesel) {
 		stmmac_fpe_stop_wq(priv);
 
+		/* stmmac_ethtool_ops.begin() guarantees that all ethtool
+		 * requests to fail with EBUSY when !netif_running()
+		 *
+		 * Prepare some params here, then fpe_cfg can keep consistent
+		 * with the register states after a SW reset by __stmmac_open().
+		 */
+		priv->fpe_cfg.pmac_enabled = false;
+		priv->fpe_cfg.verify_enabled = false;
+		priv->fpe_cfg.status = ETHTOOL_MM_VERIFY_STATUS_DISABLED;
+
+		/* Reset MAC_FPE_CTRL_STS reg cache */
+		priv->fpe_cfg.fpe_csr = 0;
+	}
+
+	pm_runtime_put(priv->device);
+
 	return 0;
 }
 
@@ -5979,44 +5997,34 @@ static int stmmac_set_features(struct net_device *netdev,
 static void stmmac_fpe_event_status(struct stmmac_priv *priv, int status)
 {
 	struct stmmac_fpe_cfg *fpe_cfg = &priv->fpe_cfg;
-	enum stmmac_fpe_state *lo_state = &fpe_cfg->lo_fpe_state;
-	enum stmmac_fpe_state *lp_state = &fpe_cfg->lp_fpe_state;
-	bool *hs_enable = &fpe_cfg->hs_enable;
 
-	if (status == FPE_EVENT_UNKNOWN || !*hs_enable)
-		return;
+	spin_lock(&priv->fpe_cfg.lock);
 
-	/* If LP has sent verify mPacket, LP is FPE capable */
-	if ((status & FPE_EVENT_RVER) == FPE_EVENT_RVER) {
-		if (*lp_state < FPE_STATE_CAPABLE)
-			*lp_state = FPE_STATE_CAPABLE;
+	if (!fpe_cfg->pmac_enabled || status == FPE_EVENT_UNKNOWN)
+		goto __unlock_out;
 
-		/* If user has requested FPE enable, quickly response */
-		if (*hs_enable)
-			stmmac_fpe_send_mpacket(priv, priv->ioaddr,
-						fpe_cfg,
-						MPACKET_RESPONSE);
-	}
+	/* LP has sent verify mPacket */
+	if ((status & FPE_EVENT_RVER) == FPE_EVENT_RVER)
+		stmmac_fpe_send_mpacket(priv, priv->ioaddr, fpe_cfg,
+					MPACKET_RESPONSE);
 
-	/* If Local has sent verify mPacket, Local is FPE capable */
-	if ((status & FPE_EVENT_TVER) == FPE_EVENT_TVER) {
-		if (*lo_state < FPE_STATE_CAPABLE)
-			*lo_state = FPE_STATE_CAPABLE;
-	}
+	/* Local has sent verify mPacket */
+	if ((status & FPE_EVENT_TVER) == FPE_EVENT_TVER &&
+	    fpe_cfg->status != ETHTOOL_MM_VERIFY_STATUS_SUCCEEDED)
+		fpe_cfg->status = ETHTOOL_MM_VERIFY_STATUS_VERIFYING;
 
-	/* If LP has sent response mPacket, LP is entering FPE ON */
+	/* LP has sent response mPacket */
 	if ((status & FPE_EVENT_RRSP) == FPE_EVENT_RRSP)
-		*lp_state = FPE_STATE_ENTERING_ON;
-
-	/* If Local has sent response mPacket, Local is entering FPE ON */
-	if ((status & FPE_EVENT_TRSP) == FPE_EVENT_TRSP)
-		*lo_state = FPE_STATE_ENTERING_ON;
+		fpe_cfg->status = ETHTOOL_MM_VERIFY_STATUS_SUCCEEDED;
 
 	if (!test_bit(__FPE_REMOVING, &priv->fpe_task_state) &&
 	    !test_and_set_bit(__FPE_TASK_SCHED, &priv->fpe_task_state) &&
 	    priv->fpe_wq) {
 		queue_work(priv->fpe_wq, &priv->fpe_task);
 	}
+
+__unlock_out:
+	spin_unlock(&priv->fpe_cfg.lock);
 }
 
 static void stmmac_common_interrupt(struct stmmac_priv *priv)
@@ -7372,50 +7380,57 @@ int stmmac_reinit_ringparam(struct net_device *dev, u32 rx_size, u32 tx_size)
 	return ret;
 }
 
-#define SEND_VERIFY_MPAKCET_FMT "Send Verify mPacket lo_state=%d lp_state=%d\n"
-static void stmmac_fpe_lp_task(struct work_struct *work)
+static void stmmac_fpe_verify_task(struct work_struct *work)
 {
 	struct stmmac_priv *priv = container_of(work, struct stmmac_priv,
 						fpe_task);
 	struct stmmac_fpe_cfg *fpe_cfg = &priv->fpe_cfg;
-	enum stmmac_fpe_state *lo_state = &fpe_cfg->lo_fpe_state;
-	enum stmmac_fpe_state *lp_state = &fpe_cfg->lp_fpe_state;
-	bool *hs_enable = &fpe_cfg->hs_enable;
-	bool *enable = &fpe_cfg->enable;
-	int retries = 20;
-
-	while (retries-- > 0) {
-		/* Bail out immediately if FPE handshake is OFF */
-		if (*lo_state == FPE_STATE_OFF || !*hs_enable)
+	int verify_limit = 3; /* defined by 802.3 */
+	unsigned long flags;
+	u32 sleep_ms;
+
+	spin_lock(&priv->fpe_cfg.lock);
+	sleep_ms = fpe_cfg->verify_time;
+	spin_unlock(&priv->fpe_cfg.lock);
+
+	while (1) {
+		/* The initial VERIFY was triggered by linkup event or
+		 * stmmac_set_mm(), sleep then check MM_VERIFY_STATUS.
+		 */
+		msleep(sleep_ms);
+
+		if (!netif_running(priv->dev))
 			break;
 
-		if (*lo_state == FPE_STATE_ENTERING_ON &&
-		    *lp_state == FPE_STATE_ENTERING_ON) {
-			stmmac_fpe_configure(priv, priv->ioaddr,
-					     fpe_cfg,
-					     priv->plat->tx_queues_to_use,
-					     priv->plat->rx_queues_to_use,
-					     *enable);
+		spin_lock_irqsave(&priv->fpe_cfg.lock, flags);
 
-			netdev_info(priv->dev, "configured FPE\n");
+		if (fpe_cfg->status == ETHTOOL_MM_VERIFY_STATUS_DISABLED ||
+		    fpe_cfg->status == ETHTOOL_MM_VERIFY_STATUS_SUCCEEDED ||
+		    !fpe_cfg->pmac_enabled || !fpe_cfg->verify_enabled) {
+			spin_unlock_irqrestore(&priv->fpe_cfg.lock, flags);
+			break;
+		}
 
-			*lo_state = FPE_STATE_ON;
-			*lp_state = FPE_STATE_ON;
-			netdev_info(priv->dev, "!!! BOTH FPE stations ON\n");
+		if (verify_limit == 0) {
+			fpe_cfg->verify_enabled = false;
+			fpe_cfg->status = ETHTOOL_MM_VERIFY_STATUS_FAILED;
+			stmmac_fpe_configure(priv, priv->ioaddr, fpe_cfg,
+					     priv->plat->tx_queues_to_use,
+					     priv->plat->rx_queues_to_use,
+					     false);
+			spin_unlock_irqrestore(&priv->fpe_cfg.lock, flags);
 			break;
 		}
 
-		if ((*lo_state == FPE_STATE_CAPABLE ||
-		     *lo_state == FPE_STATE_ENTERING_ON) &&
-		     *lp_state != FPE_STATE_ON) {
-			netdev_info(priv->dev, SEND_VERIFY_MPAKCET_FMT,
-				    *lo_state, *lp_state);
-			stmmac_fpe_send_mpacket(priv, priv->ioaddr,
-						fpe_cfg,
+		if (fpe_cfg->status == ETHTOOL_MM_VERIFY_STATUS_VERIFYING)
+			stmmac_fpe_send_mpacket(priv, priv->ioaddr, fpe_cfg,
 						MPACKET_VERIFY);
-		}
-		/* Sleep then retry */
-		msleep(500);
+
+		sleep_ms = fpe_cfg->verify_time;
+
+		spin_unlock_irqrestore(&priv->fpe_cfg.lock, flags);
+
+		verify_limit--;
 	}
 
 	clear_bit(__FPE_TASK_SCHED, &priv->fpe_task_state);
@@ -7535,8 +7550,8 @@ int stmmac_dvr_probe(struct device *device,
 
 	INIT_WORK(&priv->service_task, stmmac_service_task);
 
-	/* Initialize Link Partner FPE workqueue */
-	INIT_WORK(&priv->fpe_task, stmmac_fpe_lp_task);
+	/* Initialize FPE verify workqueue */
+	INIT_WORK(&priv->fpe_task, stmmac_fpe_verify_task);
 
 	/* Override with kernel parameters if supplied XXX CRS XXX
 	 * this needs to have multiple instances
@@ -7702,6 +7717,12 @@ int stmmac_dvr_probe(struct device *device,
 
 	mutex_init(&priv->lock);
 
+	spin_lock_init(&priv->fpe_cfg.lock);
+	priv->fpe_cfg.pmac_enabled = false;
+	priv->fpe_cfg.verify_time = 128; /* ethtool_mm_state.max_verify_time */
+	priv->fpe_cfg.verify_enabled = false;
+	priv->fpe_cfg.status = ETHTOOL_MM_VERIFY_STATUS_DISABLED;
+
 	/* If a specific clk_csr value is passed from the platform
 	 * this means that the CSR Clock Range selection cannot be
 	 * changed at run-time and it is fixed. Viceversa the driver'll try to
@@ -7875,15 +7896,8 @@ int stmmac_suspend(struct device *dev)
 	}
 	rtnl_unlock();
 
-	if (priv->dma_cap.fpesel) {
-		/* Disable FPE */
-		stmmac_fpe_configure(priv, priv->ioaddr,
-				     &priv->fpe_cfg,
-				     priv->plat->tx_queues_to_use,
-				     priv->plat->rx_queues_to_use, false);
-
+	if (priv->dma_cap.fpesel)
 		stmmac_fpe_stop_wq(priv);
-	}
 
 	priv->speed = SPEED_UNKNOWN;
 	return 0;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
index b0cc45331ff7..783829a6479c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
@@ -1063,11 +1063,6 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
 		return -EOPNOTSUPP;
 	}
 
-	/* Actual FPE register configuration will be done after FPE handshake
-	 * is success.
-	 */
-	priv->fpe_cfg.enable = fpe;
-
 	ret = stmmac_est_configure(priv, priv, priv->est,
 				   priv->plat->clk_ptp_rate);
 	mutex_unlock(&priv->est_lock);
@@ -1094,7 +1089,6 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
 		mutex_unlock(&priv->est_lock);
 	}
 
-	priv->fpe_cfg.enable = false;
 	stmmac_fpe_configure(priv, priv->ioaddr,
 			     &priv->fpe_cfg,
 			     priv->plat->tx_queues_to_use,
-- 
2.34.1


