Return-Path: <netdev+bounces-119592-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F18E09564A3
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 09:26:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E7311F2533D
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 07:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DACCA158540;
	Mon, 19 Aug 2024 07:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hrEwiRoN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1667B158538;
	Mon, 19 Aug 2024 07:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724052378; cv=none; b=ZDymtR6cZFdWSo2JXdwPb5kCUChptxSPUJVKqi7qSJZ8k8VkP+PzgG+4PMsIn8684EYPuA2GyaeM2E47+Pjz21jxOwdeZXSga0vGIxG64hTMY45cy6THeFxSnoRSV4561/2ggv0+ljvtl5R1CIBHmqVuzZKFMMWogJsDfuoI0t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724052378; c=relaxed/simple;
	bh=dzxTJ42qFXiq2RXK88zxb0qpnkcdC0Dl2pKuHye80Xc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NFwSd6CZzm8DirqpVB4Q2qXOpBLbNCqPGkqMtIpDHYLPiR74YAmJWmffVa9mOjATWwKHOYVIWeDS90ko2tg/DWsraetc1GQe/kJadCm3cfdMqo967RZiLOvnc+pmtlMRNWwujm6BZ4rzjkBUvYFdzCMrzqKkkHLIljnSxL4iYJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hrEwiRoN; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-70d25b5b6b0so2868445b3a.2;
        Mon, 19 Aug 2024 00:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724052376; x=1724657176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0N5vwBKqbIN7xPHU1qNSNudtStxtkmdXM1naRfAzgX4=;
        b=hrEwiRoNhZZiRS6gGfwM6xlpWbnrLc8cN6J2XD/pd2d71ac1IgxTXfAWW3W80vXSNr
         Ifp0IoOJIJJKFmJyU+l8LliBGArzu1xzEqVGawNMXqk5UEq9emX1n1GVgUkxvPkOJFDK
         M23hspWhqF5BPmzG6BP56St/LRpC8+PFLSCcvxK4aJo6TCtaen78FYtcY1qkF+Um8lVN
         ecYhHxsZHFIiOlT1cWYnY8K888JMq1f8MPVrpi2Imvp9rMKWpbP9x7zNVgwnnGS1/UoF
         Dgn7M5Fn8a3HkBSzMdXWFOtSqAD1vBOY7U3v/0XjXb9cGTTsFmZRhhrHQLOMTs1cle2A
         jc8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724052376; x=1724657176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0N5vwBKqbIN7xPHU1qNSNudtStxtkmdXM1naRfAzgX4=;
        b=eafRK8k+PJtNY71r+99yVO+NY8yEVvZJ6LwIMY6eiiVd6JR3Vo0YYaN/P79ycildcF
         NuqntoV8HE4v1Dc8pcXFxVl5sK6JQ5eC/rEMe+X8SPFqgFA1BzRcgraa410ZkceWsNPr
         lGhII4aXfFjx+NygQIFG7s79yq+YgIDUxNWRViq0K9RenlFBU02OPgVLF4wYdG9Cs9t9
         EHK0ss+JfpfuChZd2za1UxSnTpFlnivLo3eXFWC26DAJZkiTiJF79bREfYDjKKDkBCoO
         +kkKtgmP8z1qPswwBKPP0RMXrUKlPOpLHQzqI+DbVXT1Ff2Shr9fw9eOtVqb+aeMOdVE
         PvIw==
X-Forwarded-Encrypted: i=1; AJvYcCXqGoPNFuqE6gc3289NXLDyWX+GtsFVE9ExuWUoL2cD5mnqS6kO89DZnSLCXND7V9lE5WSm3/i06AIRaT++3i/LS4Xc11R9gPDk/VNX
X-Gm-Message-State: AOJu0Ywjs245pcWfE97yAc1IYaOBWziny9MueI3vJZdXUdVlTzX/9/Wf
	r2b8V5h+RGnz/62oGucyikdu8fbWFqA1O24cnyMrXrUQCP4UxU12
X-Google-Smtp-Source: AGHT+IFT1XJFXayK04LdkjdWbJwhBOsnEwiFEZ0BwXiX9xZnT1O22tVMFxok4MnMhbM6qWeBQQnMYw==
X-Received: by 2002:a05:6a20:9e49:b0:1c8:d4d4:413d with SMTP id adf61e73a8af0-1c904f9136emr10036349637.17.1724052375963;
        Mon, 19 Aug 2024 00:26:15 -0700 (PDT)
Received: from localhost.localdomain ([129.146.253.192])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-201f02faa5dsm58340855ad.2.2024.08.19.00.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 00:26:15 -0700 (PDT)
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
Subject: [PATCH net-next v3 3/7] net: stmmac: refactor FPE verification processe
Date: Mon, 19 Aug 2024 15:25:16 +0800
Message-Id: <c9da02a6376f1e85a11631a5ccf47dbdf24c7618.1724051326.git.0x1207@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1724051326.git.0x1207@gmail.com>
References: <cover.1724051326.git.0x1207@gmail.com>
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
 drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  20 +--
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 169 +++++++++---------
 .../net/ethernet/stmicro/stmmac/stmmac_tc.c   |   6 -
 3 files changed, 97 insertions(+), 98 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index 2c2181febb39..cb54f65753b2 100644
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
@@ -166,10 +158,10 @@ enum stmmac_fpe_task_state_t {
 };
 
 struct stmmac_fpe_cfg {
-	bool enable;				/* FPE enable */
-	bool hs_enable;				/* FPE handshake enable */
-	enum stmmac_fpe_state lp_fpe_state;	/* Link Partner FPE state */
-	enum stmmac_fpe_state lo_fpe_state;	/* Local station FPE state */
+	bool pmac_enabled;			/* see ethtool_mm_state */
+	bool verify_enabled;			/* see ethtool_mm_state */
+	u32 verify_time;			/* see ethtool_mm_state */
+	enum ethtool_mm_verify_status status;
 	u32 fpe_csr;				/* MAC_FPE_CTRL_STS reg cache */
 };
 
@@ -366,6 +358,10 @@ struct stmmac_priv {
 	struct workqueue_struct *wq;
 	struct work_struct service_task;
 
+	/* Serialize access to MAC Merge state between ethtool requests
+	 * and link state updates.
+	 */
+	spinlock_t mm_lock;
 	struct stmmac_fpe_cfg fpe_cfg;
 
 	/* Workqueue for handling FPE hand-shaking */
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 3072ad33b105..628354f60c54 100644
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
+	spin_lock_irqsave(&priv->mm_lock, flags);
 
-	if (is_up && *hs_enable) {
+	if (!fpe_cfg->pmac_enabled)
+		goto __unlock_out;
+
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
+	spin_unlock_irqrestore(&priv->mm_lock, flags);
 }
 
 static void stmmac_mac_link_down(struct phylink_config *config,
@@ -3533,9 +3537,19 @@ static int stmmac_hw_setup(struct net_device *dev, bool ptp_register)
 
 	stmmac_set_hw_vlan_mode(priv, priv->hw);
 
-	if (priv->dma_cap.fpesel)
+	if (priv->dma_cap.fpesel) {
 		stmmac_fpe_start_wq(priv);
 
+		/* phylink and irq are not enabled yet,
+		 * mm_lock is unnecessary here.
+		 */
+		stmmac_fpe_configure(priv, priv->ioaddr,
+				     &priv->fpe_cfg,
+				     priv->plat->tx_queues_to_use,
+				     priv->plat->rx_queues_to_use,
+				     false);
+	}
+
 	return 0;
 }
 
@@ -3978,6 +3992,12 @@ static int __stmmac_open(struct net_device *dev,
 		}
 	}
 
+	/* phylink and irq are not enabled yet, mm_lock is unnecessary here */
+	priv->fpe_cfg.pmac_enabled = false;
+	priv->fpe_cfg.verify_time = 128; /* ethtool_mm_state.max_verify_time */
+	priv->fpe_cfg.verify_enabled = false;
+	priv->fpe_cfg.status = ETHTOOL_MM_VERIFY_STATUS_DISABLED;
+
 	ret = stmmac_hw_setup(dev, true);
 	if (ret < 0) {
 		netdev_err(priv->dev, "%s: Hw setup failed\n", __func__);
@@ -4091,11 +4111,19 @@ static int stmmac_release(struct net_device *dev)
 
 	stmmac_release_ptp(priv);
 
-	pm_runtime_put(priv->device);
-
-	if (priv->dma_cap.fpesel)
+	if (priv->dma_cap.fpesel) {
 		stmmac_fpe_stop_wq(priv);
 
+		/* phylink and irq have already disabled,
+		 * mm_lock is unnecessary here.
+		 */
+		priv->fpe_cfg.pmac_enabled = false;
+		priv->fpe_cfg.verify_enabled = false;
+		priv->fpe_cfg.status = ETHTOOL_MM_VERIFY_STATUS_DISABLED;
+	}
+
+	pm_runtime_put(priv->device);
+
 	return 0;
 }
 
@@ -5979,44 +6007,34 @@ static int stmmac_set_features(struct net_device *netdev,
 static void stmmac_fpe_event_status(struct stmmac_priv *priv, int status)
 {
 	struct stmmac_fpe_cfg *fpe_cfg = &priv->fpe_cfg;
-	enum stmmac_fpe_state *lo_state = &fpe_cfg->lo_fpe_state;
-	enum stmmac_fpe_state *lp_state = &fpe_cfg->lp_fpe_state;
-	bool *hs_enable = &fpe_cfg->hs_enable;
 
-	if (status == FPE_EVENT_UNKNOWN || !*hs_enable)
-		return;
+	spin_lock(&priv->mm_lock);
 
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
+	spin_unlock(&priv->mm_lock);
 }
 
 static void stmmac_common_interrupt(struct stmmac_priv *priv)
@@ -7372,50 +7390,47 @@ int stmmac_reinit_ringparam(struct net_device *dev, u32 rx_size, u32 tx_size)
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
+
+	while (1) {
+		msleep(fpe_cfg->verify_time);
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
+		spin_lock_irqsave(&priv->mm_lock, flags);
 
-			netdev_info(priv->dev, "configured FPE\n");
+		if (fpe_cfg->status == ETHTOOL_MM_VERIFY_STATUS_DISABLED ||
+		    fpe_cfg->status == ETHTOOL_MM_VERIFY_STATUS_SUCCEEDED ||
+		    !fpe_cfg->pmac_enabled || !fpe_cfg->verify_enabled) {
+			spin_unlock_irqrestore(&priv->mm_lock, flags);
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
+			spin_unlock_irqrestore(&priv->mm_lock, flags);
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
+		spin_unlock_irqrestore(&priv->mm_lock, flags);
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
@@ -7701,6 +7716,7 @@ int stmmac_dvr_probe(struct device *device,
 	stmmac_napi_add(ndev);
 
 	mutex_init(&priv->lock);
+	spin_lock_init(&priv->mm_lock);
 
 	/* If a specific clk_csr value is passed from the platform
 	 * this means that the CSR Clock Range selection cannot be
@@ -7875,15 +7891,8 @@ int stmmac_suspend(struct device *dev)
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


