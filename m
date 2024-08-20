Return-Path: <netdev+bounces-120065-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 507379582E6
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 11:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66D451C2117D
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 09:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 655D718E055;
	Tue, 20 Aug 2024 09:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mPykrjTw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3D418C93E;
	Tue, 20 Aug 2024 09:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724146751; cv=none; b=Gcbj/dmzVKadAjZJpmWujkP9Y8QbVYzpd87R6C704xx/YqxSveSHz/DhZcAit+7q30EQhQqAomk2etOJEYnAPCSfDPCSXTWI9K9rykk6GtPKpIu0+UT719u+XVSsRAOSA8sPtto2faF17K/LZTpqqHkXBQRzi2Jdm3ScaIYIs78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724146751; c=relaxed/simple;
	bh=itxg/M3lVuoRR78aOEGXiRnc0EI5fRs1aS+pe2oWA8g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rc7zl4VrEuU205my4CXjpdox0oDzesUlIkG6tRmqXRdq4b6qgp/OkGzuYlnEmP8lnJeukNzMKp2nUJt4tg3p7oilv5lUqrTkQZN6NVDDva6L09TVgFY160gMBjg0sJb5G7mERXKPi8e909y7TRoLEykzrZDKe1rJhRMzsXY9dU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mPykrjTw; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2d3c396787cso4044435a91.1;
        Tue, 20 Aug 2024 02:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724146749; x=1724751549; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YJl6m7/HvoZr28SwAJK1VeVNaeP/xxoxJA+ZuNmUMD8=;
        b=mPykrjTwYjSglpI+Ilq8UXKuuqL9pBR3EOiHcAHWSExewsJkLdKFfEGbNxplhEpYTy
         54dJgmnLNUVoe3W8PXCTBRcHHd67KPk4sXAxrOyJr0c/HloVJA36fjDFsbHNb8B8e8Sh
         JHboMtTus4/bjnFjE26d0fKHz5muqxz2X1hjiAe/aOLVJja38/NrN/uVFFfMNHtMLFOF
         VQncMiHc+F0G+lSQV6deQtZ2o13aB15Op7UDbJhm/4ApMEM/H0kSuOYblKzqxMUuPbQc
         GArI6Emdp8AZoAHnuDe9w3QpXeuPWsOmS2i2Bwn3Id9PhiguvcGjQ/eYONetWNtru5jM
         H2GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724146749; x=1724751549;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YJl6m7/HvoZr28SwAJK1VeVNaeP/xxoxJA+ZuNmUMD8=;
        b=SyYRaPfUcZdIMS7mf09Em2kt/Ousi5Ac6023DLKShcnYM0UwNjLWcAA+vX7O02dtG1
         0jlGiO7H2ukZg2b/M8anHKrRpjLurvx8GccEslnQNlYF2FaOVEUVLv7Rwuf+NH+c+N45
         kBfFAsxhGmo0310cOcKOIuuT6jtHWWbmslF6HigEF0wUeaiGjEh/5pqHdnLsB1feTSlF
         3lw/qNKvJQ8xONXjFAY3jhWcgd8BoPSFmwKYqbB4QMZHJUyoj3K/Zxse1lDGT4iI0OLF
         HZT0bGycAZbHHfe0y7IXOHyOstK5fTZhKRVXJa52zkJ7XEXonoussFEUSgbVy95HlUev
         rXPA==
X-Forwarded-Encrypted: i=1; AJvYcCV8tZTD3/f6fZ1qaVuYO/mlfbFTedkHwNoCQFk32Z2+djcb5VA53A1OIEGeQWM7FgQAdBt12vXeiLLo3QM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBxbrLl/zUYDSZkpbBTVn+52OUPjp6O/6D/oEZFJkGxQ5hv9Sp
	WixE8eX64hkQyBbVSutluP1e+NZdAVClA0Q+RuVpR+rF9XIO2Zaj
X-Google-Smtp-Source: AGHT+IEWvJvyPCpenUFu/CX0YxxvoGQ5X9ndvVt1LC/JpcJaRw96JuDl6cRLq2eoBHrgSnwodk7d8Q==
X-Received: by 2002:a17:90a:c58f:b0:2c9:6a2d:b116 with SMTP id 98e67ed59e1d1-2d3dfc2a9dfmr14721226a91.7.1724146748502;
        Tue, 20 Aug 2024 02:39:08 -0700 (PDT)
Received: from localhost.localdomain ([129.146.253.192])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2d45246061dsm3230608a91.8.2024.08.20.02.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 02:39:08 -0700 (PDT)
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
Subject: [PATCH net-next v4 3/7] net: stmmac: refactor FPE verification process
Date: Tue, 20 Aug 2024 17:38:31 +0800
Message-Id: <bc4940c244c7e261bb00c2f93e216e9d7a925ba6.1724145786.git.0x1207@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1724145786.git.0x1207@gmail.com>
References: <cover.1724145786.git.0x1207@gmail.com>
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


