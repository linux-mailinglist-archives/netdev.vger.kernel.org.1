Return-Path: <netdev+bounces-125961-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7967B96F6C2
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 16:31:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 097FE1F2506C
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 14:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 753871D174E;
	Fri,  6 Sep 2024 14:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="beAx+fQg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714001D0DDF;
	Fri,  6 Sep 2024 14:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725633060; cv=none; b=JWFjYoHiBt923Nx5/6Wi6r4pbC2eEnC5M2xlB/aM15PiRQPrmR3e7ti5dgq2mL2NiCd3PprkAULwvszDheYJhCf3h2LvgpfZpR8eFgt/4ptzqY0xKDepizQqRLsDJKnit7VCPJWGOCjD9/v2oBRAYx3qtR5PLRZ1qSkoqNCeDAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725633060; c=relaxed/simple;
	bh=GR8aTJHBpSz3DbtZxc2MVS6iny3YdSrVtYr5JL3Rkc8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UxJgAZhcfGtbzac2zR9UNOKQHMKf4ruVnGsKk8iT9nMwbu28VC01w8PTDRJhn4q38bc4TU2k2RqIYzBvPXPZW0A6Chimz093sQLCCcq9lCZi8FVcvdjdB5h0kCQ9DIjN6gbKbCAAXkObKL5TyGyf9eTCW192MrtekNoFHu2b8kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=beAx+fQg; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2053a0bd0a6so22400705ad.3;
        Fri, 06 Sep 2024 07:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725633058; x=1726237858; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WAdMmhVzsyYBhRG9uC60/tGYIEdQ2ugkrE3cBlkKIvg=;
        b=beAx+fQgcWxGXOGNboi2ZAwM4lLIaOrPHZrw5lEHhQM+q5c7l0pTEW5zWl/sWjgC75
         G/yy583Ce8GYULoN3bi85UbAjb7O56gYMOuNU2xK3gxaYXYZAgls6g4NONelnyUDaeIr
         4WRjS1xHrMaA9I+uJwSxBCvNSLNt1+fXAvul74vLB19zzcoKmIfsJx5iAOYQ3KwwrQBY
         8aEbVC+PHH6hdRTrhBx0M9VXK084x190YEtbxvIWTSrtVUPmgVRe2pngNnjSj+vxX9fF
         GGB92WulisICw+iK9j2zH8BoTNs81QSEZVM+MSe6V1ZEKibTPRALiAyyUV8YE2R9Qjea
         IAtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725633058; x=1726237858;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WAdMmhVzsyYBhRG9uC60/tGYIEdQ2ugkrE3cBlkKIvg=;
        b=iAtKJtDfSlTjX7U6LhbjPlIRINfIVBmbG8k17Lw801lGPpelzUkDH+MBLuiLuW58wt
         H5KDRMfVdTjxMHUK4uzKRZYRGlpf6ItvDeLx7CNFzGx0hZgWYYartvZjPF7r9isxgEdJ
         gUyeqrQQKTTV6h64yHAvJ+63nveltDn5hVcEk9X8VqVuUw40reoderORx1BUARrC5bhm
         1FFKWGk7he/aLd9rNqb4nDt5E9AtcO6HRVE+BeCdWVP89k70RRBhbb5iYsBOjxm29uoN
         SxgQNenF/tuVs9+mwaBMk+ZsQUbr1FtSMBMuvtmzWP/5H3d/7e1AF1a4LZXdGx7jCtlj
         009A==
X-Forwarded-Encrypted: i=1; AJvYcCUvo68B0WUTWcZSCtEE4TTAz2M+iMH0MGmI+SGGpZxt1FaTJq0DdX2eb+KDJcrz/V7mduzNO/3mml7RGSQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDMNLFzBUas/NKLWxtwQ/QeIOw0vnZPHsLYiELLr0l2d9RwCVt
	Pw3GEK+UEQ5ekBnOQ5kS/XEhKT6jS5tMN1t+UA0P4zYtqSlW8J4S
X-Google-Smtp-Source: AGHT+IHYLF3IvtP6nmK4HW4U2fGPU4j8F6eveJc2CYUfNerRI2T6sB8bADU33TdreHkNZ4vCQRO7Tw==
X-Received: by 2002:a17:902:ea07:b0:202:49e:6a35 with SMTP id d9443c01a7336-206f04f9c6bmr29636405ad.19.1725633057401;
        Fri, 06 Sep 2024 07:30:57 -0700 (PDT)
Received: from localhost.localdomain ([129.146.253.192])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-206ae94dcf3sm43951975ad.80.2024.09.06.07.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 07:30:56 -0700 (PDT)
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
	Furong Xu <0x1207@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: [PATCH net-next v10 3/7] net: stmmac: refactor FPE verification process
Date: Fri,  6 Sep 2024 22:30:08 +0800
Message-Id: <151f86c8428eba967039718c6bf90a7d841e703b.1725631883.git.0x1207@gmail.com>
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

Drop driver defined stmmac_fpe_state, and switch to common
ethtool_mm_verify_status for local TX verification status.

Local side and remote side verification processes are completely
independent. There is no reason at all to keep a local state and
a remote state.

Add a spinlock to avoid races among ISR, timer, link update
and register configuration.

This patch is based on Vladimir Oltean's proposal.

Vladimir Oltean says:

  ====================
  In the INITIAL state, the timer sends MPACKET_VERIFY. Eventually the
  stmmac_fpe_event_status() IRQ fires and advances the state to VERIFYING,
  then rearms the timer after verify_time ms. If a subsequent IRQ comes in
  and modifies the state to SUCCEEDED after getting MPACKET_RESPONSE, the
  timer sees this. It must enable the EFPE bit now. Otherwise, it
  decrements the verify_limit counter and tries again. Eventually it
  moves the status to FAILED, from which the IRQ cannot move it anywhere
  else, except for another stmmac_fpe_apply() call.
  ====================

Co-developed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Furong Xu <0x1207@gmail.com>
Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
---
 .../net/ethernet/stmicro/stmmac/dwmac4_core.c |   4 -
 drivers/net/ethernet/stmicro/stmmac/dwmac5.c  |  19 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac5.h  |   2 +-
 .../ethernet/stmicro/stmmac/dwxgmac2_core.c   |   9 +-
 drivers/net/ethernet/stmicro/stmmac/hwif.h    |   2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  36 ++-
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 256 +++++++++---------
 .../net/ethernet/stmicro/stmmac/stmmac_tc.c   |   8 +-
 8 files changed, 166 insertions(+), 170 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
index 31c387cc5f26..7947b1212a2d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
@@ -58,10 +58,6 @@ static void dwmac4_core_init(struct mac_device_info *hw,
 	if (hw->pcs)
 		value |= GMAC_PCS_IRQ_DEFAULT;
 
-	/* Enable FPE interrupt */
-	if ((GMAC_HW_FEAT_FPESEL & readl(ioaddr + GMAC_HW_FEATURE3)) >> 26)
-		value |= GMAC_INT_FPE_EN;
-
 	writel(value, ioaddr + GMAC_INT_EN);
 
 	if (GMAC_INT_DEFAULT_ENABLE & GMAC_INT_TSIE)
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac5.c b/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
index e02cebc3f1b7..850cfc4df6eb 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
@@ -575,11 +575,11 @@ int dwmac5_flex_pps_config(void __iomem *ioaddr, int index,
 
 void dwmac5_fpe_configure(void __iomem *ioaddr, struct stmmac_fpe_cfg *cfg,
 			  u32 num_txq, u32 num_rxq,
-			  bool enable)
+			  bool tx_enable, bool pmac_enable)
 {
 	u32 value;
 
-	if (enable) {
+	if (tx_enable) {
 		cfg->fpe_csr = EFPE;
 		value = readl(ioaddr + GMAC_RXQ_CTRL1);
 		value &= ~GMAC_RXQCTRL_FPRQ;
@@ -589,6 +589,21 @@ void dwmac5_fpe_configure(void __iomem *ioaddr, struct stmmac_fpe_cfg *cfg,
 		cfg->fpe_csr = 0;
 	}
 	writel(cfg->fpe_csr, ioaddr + MAC_FPE_CTRL_STS);
+
+	value = readl(ioaddr + GMAC_INT_EN);
+
+	if (pmac_enable) {
+		if (!(value & GMAC_INT_FPE_EN)) {
+			/* Dummy read to clear any pending masked interrupts */
+			readl(ioaddr + MAC_FPE_CTRL_STS);
+
+			value |= GMAC_INT_FPE_EN;
+		}
+	} else {
+		value &= ~GMAC_INT_FPE_EN;
+	}
+
+	writel(value, ioaddr + GMAC_INT_EN);
 }
 
 int dwmac5_fpe_irq_status(void __iomem *ioaddr, struct net_device *dev)
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac5.h b/drivers/net/ethernet/stmicro/stmmac/dwmac5.h
index bf33a51d229e..c3031c1357d0 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac5.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac5.h
@@ -104,7 +104,7 @@ int dwmac5_flex_pps_config(void __iomem *ioaddr, int index,
 			   u32 sub_second_inc, u32 systime_flags);
 void dwmac5_fpe_configure(void __iomem *ioaddr, struct stmmac_fpe_cfg *cfg,
 			  u32 num_txq, u32 num_rxq,
-			  bool enable);
+			  bool tx_enable, bool pmac_enable);
 void dwmac5_fpe_send_mpacket(void __iomem *ioaddr,
 			     struct stmmac_fpe_cfg *cfg,
 			     enum stmmac_mpacket_type type);
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
index cbf2dd976ab1..f519d43738b0 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
@@ -1504,13 +1504,14 @@ static void dwxgmac2_set_arp_offload(struct mac_device_info *hw, bool en,
 	writel(value, ioaddr + XGMAC_RX_CONFIG);
 }
 
-static void dwxgmac3_fpe_configure(void __iomem *ioaddr, struct stmmac_fpe_cfg *cfg,
-				   u32 num_txq,
-				   u32 num_rxq, bool enable)
+static void dwxgmac3_fpe_configure(void __iomem *ioaddr,
+				   struct stmmac_fpe_cfg *cfg,
+				   u32 num_txq, u32 num_rxq,
+				   bool tx_enable, bool pmac_enable)
 {
 	u32 value;
 
-	if (!enable) {
+	if (!tx_enable) {
 		value = readl(ioaddr + XGMAC_FPE_CTRL_STS);
 
 		value &= ~XGMAC_EFPE;
diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/ethernet/stmicro/stmmac/hwif.h
index 68574798c03f..4942fc398ea6 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
@@ -421,7 +421,7 @@ struct stmmac_ops {
 	void (*set_arp_offload)(struct mac_device_info *hw, bool en, u32 addr);
 	void (*fpe_configure)(void __iomem *ioaddr, struct stmmac_fpe_cfg *cfg,
 			      u32 num_txq, u32 num_rxq,
-			      bool enable);
+			      bool tx_enable, bool pmac_enable);
 	void (*fpe_send_mpacket)(void __iomem *ioaddr,
 				 struct stmmac_fpe_cfg *cfg,
 				 enum stmmac_mpacket_type type);
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index 3ad182ef8e97..ea135203ff2e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -146,31 +146,30 @@ struct stmmac_channel {
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
 	MPACKET_RESPONSE = 1,
 };
 
-enum stmmac_fpe_task_state_t {
-	__FPE_REMOVING,
-	__FPE_TASK_SCHED,
-};
+#define STMMAC_FPE_MM_MAX_VERIFY_RETRIES	3
+#define STMMAC_FPE_MM_MAX_VERIFY_TIME_MS	128
 
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
+
+	enum ethtool_mm_verify_status status;
+	struct timer_list verify_timer;
+	bool verify_enabled;
+	int verify_retries;
+	bool pmac_enabled;
+	u32 verify_time;
+	bool tx_enabled;
 };
 
 struct stmmac_tc_entry {
@@ -367,10 +366,6 @@ struct stmmac_priv {
 	struct work_struct service_task;
 
 	/* Frame Preemption feature (FPE) */
-	unsigned long fpe_task_state;
-	struct workqueue_struct *fpe_wq;
-	struct work_struct fpe_task;
-	char wq_name[IFNAMSIZ + 4];
 	struct stmmac_fpe_cfg fpe_cfg;
 
 	/* TC Handling */
@@ -425,6 +420,7 @@ bool stmmac_eee_init(struct stmmac_priv *priv);
 int stmmac_reinit_queues(struct net_device *dev, u32 rx_cnt, u32 tx_cnt);
 int stmmac_reinit_ringparam(struct net_device *dev, u32 rx_size, u32 tx_size);
 int stmmac_bus_clks_config(struct stmmac_priv *priv, bool enabled);
+void stmmac_fpe_apply(struct stmmac_priv *priv);
 
 static inline bool stmmac_xdp_is_enabled(struct stmmac_priv *priv)
 {
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 3072ad33b105..5a38bdb3f535 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -969,17 +969,30 @@ static void stmmac_mac_config(struct phylink_config *config, unsigned int mode,
 static void stmmac_fpe_link_state_handle(struct stmmac_priv *priv, bool is_up)
 {
 	struct stmmac_fpe_cfg *fpe_cfg = &priv->fpe_cfg;
-	enum stmmac_fpe_state *lo_state = &fpe_cfg->lo_fpe_state;
-	enum stmmac_fpe_state *lp_state = &fpe_cfg->lp_fpe_state;
-	bool *hs_enable = &fpe_cfg->hs_enable;
+	unsigned long flags;
 
-	if (is_up && *hs_enable) {
-		stmmac_fpe_send_mpacket(priv, priv->ioaddr, fpe_cfg,
-					MPACKET_VERIFY);
+	timer_shutdown_sync(&fpe_cfg->verify_timer);
+
+	spin_lock_irqsave(&fpe_cfg->lock, flags);
+
+	if (is_up && fpe_cfg->pmac_enabled) {
+		/* VERIFY process requires pmac enabled when NIC comes up */
+		stmmac_fpe_configure(priv, priv->ioaddr, fpe_cfg,
+				     priv->plat->tx_queues_to_use,
+				     priv->plat->rx_queues_to_use,
+				     false, true);
+
+		/* New link => maybe new partner => new verification process */
+		stmmac_fpe_apply(priv);
 	} else {
-		*lo_state = FPE_STATE_OFF;
-		*lp_state = FPE_STATE_OFF;
+		/* No link => turn off EFPE */
+		stmmac_fpe_configure(priv, priv->ioaddr, fpe_cfg,
+				     priv->plat->tx_queues_to_use,
+				     priv->plat->rx_queues_to_use,
+				     false, false);
 	}
+
+	spin_unlock_irqrestore(&fpe_cfg->lock, flags);
 }
 
 static void stmmac_mac_link_down(struct phylink_config *config,
@@ -3358,27 +3371,6 @@ static void stmmac_safety_feat_configuration(struct stmmac_priv *priv)
 	}
 }
 
-static int stmmac_fpe_start_wq(struct stmmac_priv *priv)
-{
-	char *name;
-
-	clear_bit(__FPE_TASK_SCHED, &priv->fpe_task_state);
-	clear_bit(__FPE_REMOVING,  &priv->fpe_task_state);
-
-	name = priv->wq_name;
-	sprintf(name, "%s-fpe", priv->dev->name);
-
-	priv->fpe_wq = create_singlethread_workqueue(name);
-	if (!priv->fpe_wq) {
-		netdev_err(priv->dev, "%s: Failed to create workqueue\n", name);
-
-		return -ENOMEM;
-	}
-	netdev_info(priv->dev, "FPE workqueue start");
-
-	return 0;
-}
-
 /**
  * stmmac_hw_setup - setup mac in a usable state.
  *  @dev : pointer to the device structure.
@@ -3533,9 +3525,6 @@ static int stmmac_hw_setup(struct net_device *dev, bool ptp_register)
 
 	stmmac_set_hw_vlan_mode(priv, priv->hw);
 
-	if (priv->dma_cap.fpesel)
-		stmmac_fpe_start_wq(priv);
-
 	return 0;
 }
 
@@ -4032,18 +4021,6 @@ static int stmmac_open(struct net_device *dev)
 	return ret;
 }
 
-static void stmmac_fpe_stop_wq(struct stmmac_priv *priv)
-{
-	set_bit(__FPE_REMOVING, &priv->fpe_task_state);
-
-	if (priv->fpe_wq) {
-		destroy_workqueue(priv->fpe_wq);
-		priv->fpe_wq = NULL;
-	}
-
-	netdev_info(priv->dev, "FPE workqueue stop");
-}
-
 /**
  *  stmmac_release - close entry point of the driver
  *  @dev : device pointer.
@@ -4091,10 +4068,10 @@ static int stmmac_release(struct net_device *dev)
 
 	stmmac_release_ptp(priv);
 
-	pm_runtime_put(priv->device);
-
 	if (priv->dma_cap.fpesel)
-		stmmac_fpe_stop_wq(priv);
+		timer_shutdown_sync(&priv->fpe_cfg.verify_timer);
+
+	pm_runtime_put(priv->device);
 
 	return 0;
 }
@@ -5979,44 +5956,30 @@ static int stmmac_set_features(struct net_device *netdev,
 static void stmmac_fpe_event_status(struct stmmac_priv *priv, int status)
 {
 	struct stmmac_fpe_cfg *fpe_cfg = &priv->fpe_cfg;
-	enum stmmac_fpe_state *lo_state = &fpe_cfg->lo_fpe_state;
-	enum stmmac_fpe_state *lp_state = &fpe_cfg->lp_fpe_state;
-	bool *hs_enable = &fpe_cfg->hs_enable;
 
-	if (status == FPE_EVENT_UNKNOWN || !*hs_enable)
-		return;
+	/* This is interrupt context, just spin_lock() */
+	spin_lock(&fpe_cfg->lock);
 
-	/* If LP has sent verify mPacket, LP is FPE capable */
-	if ((status & FPE_EVENT_RVER) == FPE_EVENT_RVER) {
-		if (*lp_state < FPE_STATE_CAPABLE)
-			*lp_state = FPE_STATE_CAPABLE;
+	if (!fpe_cfg->pmac_enabled || status == FPE_EVENT_UNKNOWN)
+		goto unlock_out;
 
-		/* If user has requested FPE enable, quickly response */
-		if (*hs_enable)
-			stmmac_fpe_send_mpacket(priv, priv->ioaddr,
-						fpe_cfg,
-						MPACKET_RESPONSE);
-	}
-
-	/* If Local has sent verify mPacket, Local is FPE capable */
-	if ((status & FPE_EVENT_TVER) == FPE_EVENT_TVER) {
-		if (*lo_state < FPE_STATE_CAPABLE)
-			*lo_state = FPE_STATE_CAPABLE;
-	}
+	/* LP has sent verify mPacket */
+	if ((status & FPE_EVENT_RVER) == FPE_EVENT_RVER)
+		stmmac_fpe_send_mpacket(priv, priv->ioaddr, fpe_cfg,
+					MPACKET_RESPONSE);
 
-	/* If LP has sent response mPacket, LP is entering FPE ON */
-	if ((status & FPE_EVENT_RRSP) == FPE_EVENT_RRSP)
-		*lp_state = FPE_STATE_ENTERING_ON;
+	/* Local has sent verify mPacket */
+	if ((status & FPE_EVENT_TVER) == FPE_EVENT_TVER &&
+	    fpe_cfg->status != ETHTOOL_MM_VERIFY_STATUS_SUCCEEDED)
+		fpe_cfg->status = ETHTOOL_MM_VERIFY_STATUS_VERIFYING;
 
-	/* If Local has sent response mPacket, Local is entering FPE ON */
-	if ((status & FPE_EVENT_TRSP) == FPE_EVENT_TRSP)
-		*lo_state = FPE_STATE_ENTERING_ON;
+	/* LP has sent response mPacket */
+	if ((status & FPE_EVENT_RRSP) == FPE_EVENT_RRSP &&
+	    fpe_cfg->status == ETHTOOL_MM_VERIFY_STATUS_VERIFYING)
+		fpe_cfg->status = ETHTOOL_MM_VERIFY_STATUS_SUCCEEDED;
 
-	if (!test_bit(__FPE_REMOVING, &priv->fpe_task_state) &&
-	    !test_and_set_bit(__FPE_TASK_SCHED, &priv->fpe_task_state) &&
-	    priv->fpe_wq) {
-		queue_work(priv->fpe_wq, &priv->fpe_task);
-	}
+unlock_out:
+	spin_unlock(&fpe_cfg->lock);
 }
 
 static void stmmac_common_interrupt(struct stmmac_priv *priv)
@@ -7372,53 +7335,88 @@ int stmmac_reinit_ringparam(struct net_device *dev, u32 rx_size, u32 tx_size)
 	return ret;
 }
 
-#define SEND_VERIFY_MPAKCET_FMT "Send Verify mPacket lo_state=%d lp_state=%d\n"
-static void stmmac_fpe_lp_task(struct work_struct *work)
+/**
+ * stmmac_fpe_verify_timer - Timer for MAC Merge verification
+ * @t:  timer_list struct containing private info
+ *
+ * Verify the MAC Merge capability in the local TX direction, by
+ * transmitting Verify mPackets up to 3 times. Wait until link
+ * partner responds with a Response mPacket, otherwise fail.
+ */
+static void stmmac_fpe_verify_timer(struct timer_list *t)
 {
-	struct stmmac_priv *priv = container_of(work, struct stmmac_priv,
-						fpe_task);
-	struct stmmac_fpe_cfg *fpe_cfg = &priv->fpe_cfg;
-	enum stmmac_fpe_state *lo_state = &fpe_cfg->lo_fpe_state;
-	enum stmmac_fpe_state *lp_state = &fpe_cfg->lp_fpe_state;
-	bool *hs_enable = &fpe_cfg->hs_enable;
-	bool *enable = &fpe_cfg->enable;
-	int retries = 20;
-
-	while (retries-- > 0) {
-		/* Bail out immediately if FPE handshake is OFF */
-		if (*lo_state == FPE_STATE_OFF || !*hs_enable)
-			break;
-
-		if (*lo_state == FPE_STATE_ENTERING_ON &&
-		    *lp_state == FPE_STATE_ENTERING_ON) {
-			stmmac_fpe_configure(priv, priv->ioaddr,
-					     fpe_cfg,
-					     priv->plat->tx_queues_to_use,
-					     priv->plat->rx_queues_to_use,
-					     *enable);
-
-			netdev_info(priv->dev, "configured FPE\n");
+	struct stmmac_fpe_cfg *fpe_cfg = from_timer(fpe_cfg, t, verify_timer);
+	struct stmmac_priv *priv = container_of(fpe_cfg, struct stmmac_priv,
+						fpe_cfg);
+	unsigned long flags;
+	bool rearm = false;
 
-			*lo_state = FPE_STATE_ON;
-			*lp_state = FPE_STATE_ON;
-			netdev_info(priv->dev, "!!! BOTH FPE stations ON\n");
-			break;
-		}
+	spin_lock_irqsave(&fpe_cfg->lock, flags);
 
-		if ((*lo_state == FPE_STATE_CAPABLE ||
-		     *lo_state == FPE_STATE_ENTERING_ON) &&
-		     *lp_state != FPE_STATE_ON) {
-			netdev_info(priv->dev, SEND_VERIFY_MPAKCET_FMT,
-				    *lo_state, *lp_state);
+	switch (fpe_cfg->status) {
+	case ETHTOOL_MM_VERIFY_STATUS_INITIAL:
+	case ETHTOOL_MM_VERIFY_STATUS_VERIFYING:
+		if (fpe_cfg->verify_retries != 0) {
 			stmmac_fpe_send_mpacket(priv, priv->ioaddr,
-						fpe_cfg,
-						MPACKET_VERIFY);
+						fpe_cfg, MPACKET_VERIFY);
+			rearm = true;
+		} else {
+			fpe_cfg->status = ETHTOOL_MM_VERIFY_STATUS_FAILED;
 		}
-		/* Sleep then retry */
-		msleep(500);
+
+		fpe_cfg->verify_retries--;
+		break;
+
+	case ETHTOOL_MM_VERIFY_STATUS_SUCCEEDED:
+		stmmac_fpe_configure(priv, priv->ioaddr, fpe_cfg,
+				     priv->plat->tx_queues_to_use,
+				     priv->plat->rx_queues_to_use,
+				     true, true);
+		break;
+
+	default:
+		break;
 	}
 
-	clear_bit(__FPE_TASK_SCHED, &priv->fpe_task_state);
+	if (rearm) {
+		mod_timer(&fpe_cfg->verify_timer,
+			  jiffies + msecs_to_jiffies(fpe_cfg->verify_time));
+	}
+
+	spin_unlock_irqrestore(&fpe_cfg->lock, flags);
+}
+
+static void stmmac_fpe_verify_timer_arm(struct stmmac_fpe_cfg *fpe_cfg)
+{
+	if (fpe_cfg->pmac_enabled && fpe_cfg->tx_enabled &&
+	    fpe_cfg->verify_enabled &&
+	    fpe_cfg->status != ETHTOOL_MM_VERIFY_STATUS_FAILED &&
+	    fpe_cfg->status != ETHTOOL_MM_VERIFY_STATUS_SUCCEEDED) {
+		timer_setup(&fpe_cfg->verify_timer, stmmac_fpe_verify_timer, 0);
+		mod_timer(&fpe_cfg->verify_timer, jiffies);
+	}
+}
+
+void stmmac_fpe_apply(struct stmmac_priv *priv)
+{
+	struct stmmac_fpe_cfg *fpe_cfg = &priv->fpe_cfg;
+
+	/* If verification is disabled, configure FPE right away.
+	 * Otherwise let the timer code do it.
+	 */
+	if (!fpe_cfg->verify_enabled) {
+		stmmac_fpe_configure(priv, priv->ioaddr, fpe_cfg,
+				     priv->plat->tx_queues_to_use,
+				     priv->plat->rx_queues_to_use,
+				     fpe_cfg->tx_enabled,
+				     fpe_cfg->pmac_enabled);
+	} else {
+		fpe_cfg->status = ETHTOOL_MM_VERIFY_STATUS_INITIAL;
+		fpe_cfg->verify_retries = STMMAC_FPE_MM_MAX_VERIFY_RETRIES;
+
+		if (netif_running(priv->dev))
+			stmmac_fpe_verify_timer_arm(fpe_cfg);
+	}
 }
 
 static int stmmac_xdp_rx_timestamp(const struct xdp_md *_ctx, u64 *timestamp)
@@ -7535,9 +7533,6 @@ int stmmac_dvr_probe(struct device *device,
 
 	INIT_WORK(&priv->service_task, stmmac_service_task);
 
-	/* Initialize Link Partner FPE workqueue */
-	INIT_WORK(&priv->fpe_task, stmmac_fpe_lp_task);
-
 	/* Override with kernel parameters if supplied XXX CRS XXX
 	 * this needs to have multiple instances
 	 */
@@ -7702,6 +7697,12 @@ int stmmac_dvr_probe(struct device *device,
 
 	mutex_init(&priv->lock);
 
+	priv->fpe_cfg.verify_retries = STMMAC_FPE_MM_MAX_VERIFY_RETRIES;
+	priv->fpe_cfg.verify_time = STMMAC_FPE_MM_MAX_VERIFY_TIME_MS;
+	priv->fpe_cfg.status = ETHTOOL_MM_VERIFY_STATUS_DISABLED;
+	timer_setup(&priv->fpe_cfg.verify_timer, stmmac_fpe_verify_timer, 0);
+	spin_lock_init(&priv->fpe_cfg.lock);
+
 	/* If a specific clk_csr value is passed from the platform
 	 * this means that the CSR Clock Range selection cannot be
 	 * changed at run-time and it is fixed. Viceversa the driver'll try to
@@ -7875,15 +7876,8 @@ int stmmac_suspend(struct device *dev)
 	}
 	rtnl_unlock();
 
-	if (priv->dma_cap.fpesel) {
-		/* Disable FPE */
-		stmmac_fpe_configure(priv, priv->ioaddr,
-				     &priv->fpe_cfg,
-				     priv->plat->tx_queues_to_use,
-				     priv->plat->rx_queues_to_use, false);
-
-		stmmac_fpe_stop_wq(priv);
-	}
+	if (priv->dma_cap.fpesel)
+		timer_shutdown_sync(&priv->fpe_cfg.verify_timer);
 
 	priv->speed = SPEED_UNKNOWN;
 	return 0;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
index b0cc45331ff7..a58282d6458c 100644
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
@@ -1094,12 +1089,11 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
 		mutex_unlock(&priv->est_lock);
 	}
 
-	priv->fpe_cfg.enable = false;
 	stmmac_fpe_configure(priv, priv->ioaddr,
 			     &priv->fpe_cfg,
 			     priv->plat->tx_queues_to_use,
 			     priv->plat->rx_queues_to_use,
-			     false);
+			     false, false);
 	netdev_info(priv->dev, "disabled FPE\n");
 
 	return ret;
-- 
2.34.1


