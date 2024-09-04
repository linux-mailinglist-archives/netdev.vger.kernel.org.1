Return-Path: <netdev+bounces-124936-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B4A996B674
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 11:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FF811C21AA2
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 09:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD9781CEEA0;
	Wed,  4 Sep 2024 09:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sap3KcHz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D991CDFC8;
	Wed,  4 Sep 2024 09:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725441749; cv=none; b=a+tGVTldPxEWhPKzd9GMmPmiY3E/pGovylVhrE9erszE3yAPdokXoI2JCRbYtDQoe6Fo/PNd8roo/RHJhuzQicjKa5INi++7LrK1Dwfvc9YE3Th6B5U7nyOavosCIe+5/jGS7aBHIw/hA59kNwgFTT5N66EjylozsYqp2leKKgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725441749; c=relaxed/simple;
	bh=TyaQZiB0slqb0p7hjGFKXumMXT8aWecNCPslpimHjPs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LazBJNYU4I0jfzL8k4Mj3PIop99fLW4wBCjw+0md70GHE2nKqTl+jAK0W5x6GPEtTPEQLfLNZUzt8wRxJJX37l0PGDS3M5pTRhbxz4eHV7q79fpWdp55l60hdafbeGkYNCbCzWGmBWgi7LP/EGs2hu5eZXqKsTx+aQNpKP3Q3H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sap3KcHz; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7142a30e3bdso438626b3a.0;
        Wed, 04 Sep 2024 02:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725441747; x=1726046547; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YHu5Ot0Q0YDUdnHi1oi7J0VsNZH4VP/tJKBziIinXNQ=;
        b=Sap3KcHzpq8EaO3KZPXCrhafD+nwcCkRRch9jQJo2+98990gRtKzXt07mWjRxl2Bip
         WcwUmboV30QGI07+Vgk0reOFWH0vC0WJAPiTCgOlBy48Bm6VPxtkqZzWMpp79uCojr7d
         ynpKuK4i0BeU0EFRsEr9AZKhoZSaRsn4100NcSdGEl/987hPXUr1X+sXAOgOzkh6pi/K
         A8sI+xGgXZfIDWE3lSC6teGVBKbCKxi0bUKSUhCqM8wPfb1W6+aGuiClQOFF7wecvPWT
         IYGwdep9ym6Yry2SDoFNfVkbz58VUhC53sBwF4xuiQ6SHWd1qFyh+Fz9LgaoMHcc9fm+
         baBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725441747; x=1726046547;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YHu5Ot0Q0YDUdnHi1oi7J0VsNZH4VP/tJKBziIinXNQ=;
        b=rNUndBa1cLHYb4lHWbC1LBDeXzoqn5V+szRSZtWC08gh8ykt2Cy2W48J43awZWrkA0
         cB/8AVzY/gCP7hX81oRNpfYKG2Wim//oMPZNsptdnPp6N1FgtLdJoZw1cx4EmRtJuNl4
         MF1Et4urBu151bwh1ZfBqU+cKU4bj7g1kQTQ9rqhI60AfC/2qWJRkvlDfD1RIs3/0eHi
         s9QWvAfmQTnysrkvO6A/hqSA8QtOyK3tgxD+tpFZkOtQF9FyLBpFY70M17YNEHab+qQg
         aJD+h+vUeWGaEnX5BY/IuJQxM8PmnZnwSEfyl3Q/jqYcdHFyMAydKaedEI/JUMSjDxsz
         g73g==
X-Forwarded-Encrypted: i=1; AJvYcCWwJF1DFPD3I0jn0v+Z9li5W7IIzh/FBErSGASLokzkVllrMyFlW1TfntikXhZ/WZapBOBraj05Ti3JDG4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ0wPe6nquaR2PwvEHDdV9Kekwz7Vl8D+6FoUtrvUg4Tqs4gf8
	eck4AUR+TwhdfoFl6wEVha1J7DSy+1eZdrAmMV2sYmTZUZR9lIBM
X-Google-Smtp-Source: AGHT+IEP7fLkV+aovauMQ1sGPYMM/v4Uc7HXJXQPEDXVX4qASIPu0Qzd6Ptee6HYJU6r6AubgSy72w==
X-Received: by 2002:a05:6a00:3e0d:b0:70d:36ad:3f67 with SMTP id d2e1a72fcca58-7177a9589dfmr2312169b3a.11.1725441746806;
        Wed, 04 Sep 2024 02:22:26 -0700 (PDT)
Received: from localhost.localdomain ([129.146.253.192])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7177859968csm1232048b3a.146.2024.09.04.02.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 02:22:26 -0700 (PDT)
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
	Furong Xu <0x1207@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: [PATCH net-next v7 3/7] net: stmmac: refactor FPE verification process
Date: Wed,  4 Sep 2024 17:21:18 +0800
Message-Id: <1e452525e496b28c0b1ea43afbdc3533c92930c6.1725441317.git.0x1207@gmail.com>
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
---
 .../net/ethernet/stmicro/stmmac/dwmac4_core.c |   4 -
 drivers/net/ethernet/stmicro/stmmac/dwmac5.c  |  19 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac5.h  |   2 +-
 .../ethernet/stmicro/stmmac/dwxgmac2_core.c   |   9 +-
 drivers/net/ethernet/stmicro/stmmac/hwif.h    |   2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  31 +--
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 258 +++++++++---------
 .../net/ethernet/stmicro/stmmac/stmmac_tc.c   |   8 +-
 8 files changed, 164 insertions(+), 169 deletions(-)

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
index 3ad182ef8e97..535d1b0c4bbf 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -146,31 +146,25 @@ struct stmmac_channel {
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
+	struct timer_list verify_timer;
+	struct ethtool_mm_state state;
+	int verify_retries;
 };
 
 struct stmmac_tc_entry {
@@ -367,10 +361,6 @@ struct stmmac_priv {
 	struct work_struct service_task;
 
 	/* Frame Preemption feature (FPE) */
-	unsigned long fpe_task_state;
-	struct workqueue_struct *fpe_wq;
-	struct work_struct fpe_task;
-	char wq_name[IFNAMSIZ + 4];
 	struct stmmac_fpe_cfg fpe_cfg;
 
 	/* TC Handling */
@@ -425,6 +415,7 @@ bool stmmac_eee_init(struct stmmac_priv *priv);
 int stmmac_reinit_queues(struct net_device *dev, u32 rx_cnt, u32 tx_cnt);
 int stmmac_reinit_ringparam(struct net_device *dev, u32 rx_size, u32 tx_size);
 int stmmac_bus_clks_config(struct stmmac_priv *priv, bool enabled);
+void stmmac_fpe_apply(struct stmmac_priv *priv);
 
 static inline bool stmmac_xdp_is_enabled(struct stmmac_priv *priv)
 {
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 3072ad33b105..e2f933353f40 100644
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
+	del_timer_sync(&fpe_cfg->verify_timer);
+
+	spin_lock_irqsave(&fpe_cfg->lock, flags);
+
+	if (is_up && fpe_cfg->state.pmac_enabled) {
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
+		del_timer_sync(&priv->fpe_cfg.verify_timer);
+
+	pm_runtime_put(priv->device);
 
 	return 0;
 }
@@ -5978,45 +5955,31 @@ static int stmmac_set_features(struct net_device *netdev,
 
 static void stmmac_fpe_event_status(struct stmmac_priv *priv, int status)
 {
+	struct ethtool_mm_state *state = &priv->fpe_cfg.state;
 	struct stmmac_fpe_cfg *fpe_cfg = &priv->fpe_cfg;
-	enum stmmac_fpe_state *lo_state = &fpe_cfg->lo_fpe_state;
-	enum stmmac_fpe_state *lp_state = &fpe_cfg->lp_fpe_state;
-	bool *hs_enable = &fpe_cfg->hs_enable;
 
-	if (status == FPE_EVENT_UNKNOWN || !*hs_enable)
-		return;
+	/* this is interrupt context, just spin_lock */
+	spin_lock(&fpe_cfg->lock);
 
-	/* If LP has sent verify mPacket, LP is FPE capable */
-	if ((status & FPE_EVENT_RVER) == FPE_EVENT_RVER) {
-		if (*lp_state < FPE_STATE_CAPABLE)
-			*lp_state = FPE_STATE_CAPABLE;
+	if (!state->pmac_enabled || status == FPE_EVENT_UNKNOWN)
+		goto unlock_out;
 
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
+	    state->verify_status != ETHTOOL_MM_VERIFY_STATUS_SUCCEEDED)
+		state->verify_status = ETHTOOL_MM_VERIFY_STATUS_VERIFYING;
 
-	/* If LP has sent response mPacket, LP is entering FPE ON */
+	/* LP has sent response mPacket */
 	if ((status & FPE_EVENT_RRSP) == FPE_EVENT_RRSP)
-		*lp_state = FPE_STATE_ENTERING_ON;
-
-	/* If Local has sent response mPacket, Local is entering FPE ON */
-	if ((status & FPE_EVENT_TRSP) == FPE_EVENT_TRSP)
-		*lo_state = FPE_STATE_ENTERING_ON;
+		state->verify_status = ETHTOOL_MM_VERIFY_STATUS_SUCCEEDED;
 
-	if (!test_bit(__FPE_REMOVING, &priv->fpe_task_state) &&
-	    !test_and_set_bit(__FPE_TASK_SCHED, &priv->fpe_task_state) &&
-	    priv->fpe_wq) {
-		queue_work(priv->fpe_wq, &priv->fpe_task);
-	}
+unlock_out:
+	spin_unlock(&fpe_cfg->lock);
 }
 
 static void stmmac_common_interrupt(struct stmmac_priv *priv)
@@ -7372,53 +7335,90 @@ int stmmac_reinit_ringparam(struct net_device *dev, u32 rx_size, u32 tx_size)
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
+	struct ethtool_mm_state *state = &fpe_cfg->state;
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
+	switch (state->verify_status) {
+	case ETHTOOL_MM_VERIFY_STATUS_INITIAL:
+	case ETHTOOL_MM_VERIFY_STATUS_VERIFYING:
+		if (fpe_cfg->verify_retries != 0) {
 			stmmac_fpe_send_mpacket(priv, priv->ioaddr,
-						fpe_cfg,
-						MPACKET_VERIFY);
+						fpe_cfg, MPACKET_VERIFY);
+			rearm = true;
+		} else {
+			state->verify_status = ETHTOOL_MM_VERIFY_STATUS_FAILED;
 		}
-		/* Sleep then retry */
-		msleep(500);
+
+		fpe_cfg->verify_retries--;
+	break;
+
+	case ETHTOOL_MM_VERIFY_STATUS_SUCCEEDED:
+		stmmac_fpe_configure(priv, priv->ioaddr, fpe_cfg,
+				     priv->plat->tx_queues_to_use,
+				     priv->plat->rx_queues_to_use,
+				     true, true);
+	break;
+
+	default:
+	break;
+	}
+
+	if (rearm) {
+		mod_timer(&fpe_cfg->verify_timer,
+			  jiffies + msecs_to_jiffies(state->verify_time));
 	}
 
-	clear_bit(__FPE_TASK_SCHED, &priv->fpe_task_state);
+	spin_unlock_irqrestore(&fpe_cfg->lock, flags);
+}
+
+static void stmmac_fpe_verify_timer_arm(struct stmmac_fpe_cfg *fpe_cfg)
+{
+	struct ethtool_mm_state *state = &fpe_cfg->state;
+
+	if (state->pmac_enabled && state->tx_enabled &&
+	    state->verify_enabled &&
+	    state->verify_status != ETHTOOL_MM_VERIFY_STATUS_FAILED &&
+	    state->verify_status != ETHTOOL_MM_VERIFY_STATUS_SUCCEEDED) {
+		/* give caller a chance to release the spinlock */
+		mod_timer(&fpe_cfg->verify_timer, jiffies + 1);
+	}
+}
+
+void stmmac_fpe_apply(struct stmmac_priv *priv)
+{
+	struct ethtool_mm_state *state = &priv->fpe_cfg.state;
+	struct stmmac_fpe_cfg *fpe_cfg = &priv->fpe_cfg;
+
+	/* If verification is disabled, configure FPE right away.
+	 * Otherwise let the timer code do it.
+	 */
+	if (!state->verify_enabled) {
+		stmmac_fpe_configure(priv, priv->ioaddr, fpe_cfg,
+				     priv->plat->tx_queues_to_use,
+				     priv->plat->rx_queues_to_use,
+				     state->tx_enabled,
+				     state->pmac_enabled);
+	} else {
+		state->verify_status = ETHTOOL_MM_VERIFY_STATUS_INITIAL;
+		fpe_cfg->verify_retries = STMMAC_FPE_MM_MAX_VERIFY_RETRIES;
+		stmmac_fpe_verify_timer_arm(fpe_cfg);
+	}
 }
 
 static int stmmac_xdp_rx_timestamp(const struct xdp_md *_ctx, u64 *timestamp)
@@ -7535,9 +7535,6 @@ int stmmac_dvr_probe(struct device *device,
 
 	INIT_WORK(&priv->service_task, stmmac_service_task);
 
-	/* Initialize Link Partner FPE workqueue */
-	INIT_WORK(&priv->fpe_task, stmmac_fpe_lp_task);
-
 	/* Override with kernel parameters if supplied XXX CRS XXX
 	 * this needs to have multiple instances
 	 */
@@ -7702,6 +7699,14 @@ int stmmac_dvr_probe(struct device *device,
 
 	mutex_init(&priv->lock);
 
+	spin_lock_init(&priv->fpe_cfg.lock);
+	timer_setup(&priv->fpe_cfg.verify_timer, stmmac_fpe_verify_timer, 0);
+	priv->fpe_cfg.state.verify_time = STMMAC_FPE_MM_MAX_VERIFY_TIME_MS;
+	priv->fpe_cfg.state.max_verify_time = STMMAC_FPE_MM_MAX_VERIFY_TIME_MS;
+	priv->fpe_cfg.state.verify_status = ETHTOOL_MM_VERIFY_STATUS_DISABLED;
+	priv->fpe_cfg.state.rx_min_frag_size = ETH_ZLEN;
+	priv->fpe_cfg.verify_retries = STMMAC_FPE_MM_MAX_VERIFY_RETRIES;
+
 	/* If a specific clk_csr value is passed from the platform
 	 * this means that the CSR Clock Range selection cannot be
 	 * changed at run-time and it is fixed. Viceversa the driver'll try to
@@ -7875,15 +7880,8 @@ int stmmac_suspend(struct device *dev)
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
+		del_timer_sync(&priv->fpe_cfg.verify_timer);
 
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


