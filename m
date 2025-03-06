Return-Path: <netdev+bounces-172569-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DECC3A556B6
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 20:31:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 153191762CC
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 19:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED65427F4C8;
	Thu,  6 Mar 2025 19:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a0GodrnQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CCA27EC6F;
	Thu,  6 Mar 2025 19:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741289278; cv=none; b=W6FZtuztv3gQrHjvI4svs9ex6g8GL4w/Ax8Tf/zq4zc4aYDNPzFmLA5i8YzI3xWwupsgCwC1NaL3Fc7UJUfvnuWifH3mVPaOnH5Gkf7g3ikvoKyB8xfe8W2mMir+uVRygRA/c7gt4baIwqQB+buPp9xX+QtAEA7ILyLgVy6XYzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741289278; c=relaxed/simple;
	bh=UwUiJTjD8Gk4hPFTq+6lGnY8RHO8A+gFVxZXVZvvk2M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WxPOD3rJysNAqu2jtSCerA7nsUxJ/AZYwLfumQIc3ti85zz02yyz0GRDrL28oRXVIqPeUACo96+9fHPGWwIQLORzUxzKR8sWN8HvBaj90d4AQyW22RBXyQxbYXrp7ldlHQU2AShe8Zit0dARQ+WV8GFGf7a5Y18EALFMlUiHKcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a0GodrnQ; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-71fbb0d035dso494287a34.2;
        Thu, 06 Mar 2025 11:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741289276; x=1741894076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kc7jX9qtPYDjRxcz+4Coy64UTqRzxhOB9wDk1hO9HmQ=;
        b=a0GodrnQPDfdpdw7aiMARSstLQmCto8OuJZNQCzeXzakrEB2N5Hae+AzF06+JRj9Mq
         FeSo1Gdy2MxxSl74U84gPozAgzA97SqbzyozMooR7CtzCdvYRmE3ydfN7j9HxnQUrgYj
         HBverOOWyxZ0T/4Umm1ykdQzY4lljvif9BQLaxIH4AJ6LxdfVLXLvgLHm8PcLQg00xzm
         kRqA2FXigKo0cr7uTR35RGAWyWnzR45hZeFimuy0m2hv6mdw5afIL6axY1BbbMbtrFOf
         jztubrN3yRPe3P1C1R5nHEJt479/217avyc5yR1toxHSAIG5rGZMeuCNgbGTthOVyOa+
         xSbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741289276; x=1741894076;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kc7jX9qtPYDjRxcz+4Coy64UTqRzxhOB9wDk1hO9HmQ=;
        b=LBoTBIf19TOpJdHy+Ao2+LmBaCfQGp0bmPUZWjkNk3Llo743IPdBpLTG2TJgmwPgFF
         19Pgzpn/u7F1w0x4kDOv6fsWjOnGTmaJpR8J7FdMUCUT6lSxmVyrpfM7/paeZ9lhIFZG
         6lFLm7sEfAFipO8qObdLgT/jeqfoeddS+C5we3m/0D4PkLD9N55sE0dgY2e5Xgs442pS
         o3YhkQPaDFocviwfXEBcPtKXknMFMWKbA73ncIY6nD5IPTYzIw8LLre5OcjMYNf9hPyD
         QiD7nCcHeo1espf8mAcryUYf8QftnTKUayjL1dtrBw2LLKccSpk6+6cRhnAvKXnO09l8
         trRw==
X-Forwarded-Encrypted: i=1; AJvYcCUzCsO6Ow6YeltPTSwxKIVDgHD/mBQCXxr1Tla0eHy5jfz05QvNqvWRRDzuVVPVPcb/TraDuoG7poG1Yl8=@vger.kernel.org, AJvYcCWj84/hZe13j8ZO1XySg9hLLEzMRSjh6p+yI8rnGwm4a5bVWdiawtF9T78eksEpTvQ3YkU528Si@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6ZA/1/VzEHwJqKWcU75J+1ootIErrlnkiM305sfH3kbaPvvIK
	hNjKNoR2QpLVICGrvY09k2sGU2sqtmJBigx4geCFviiTlLZ4v9it
X-Gm-Gg: ASbGncuD5Pr+fb7s/c57nzcZWLv3QoX3cNBqnKQPatg8oG8cNWnAwQIysGZHKbr0NCf
	7e4NTYlRw4Csnk6iGVjJnZ67AQB3+DqoNsxjWDNEp2gPjR95CWtURMLGl7LVpbGiXa43kLhBDa/
	LwqXV3Hc1bNWhoBb1Npkh2EOeyhYiF62i2jE9ZJ+BVEA4JGFf/XOhXQPjbBJ4gvRRFTQJ9Jve9i
	iztoopaUid8TDAJctEnIzKWqS0YoEteg6VcHxNg23kXlMUHSVAUzB6ykCTO0KlbZcsqpdo5Rel1
	THhWhFqVyyvRX0vdUj/9XSSdHaqCtY3NN6P7GiauMXk1loPbKTdLF55BgC/NZB2zia7+tN0k8hO
	rjVQn/bNfs7fC
X-Google-Smtp-Source: AGHT+IHFCm8xw5wiFGK5E7Ccz6cZHMm5SzXYU2T1YwRgRbtfma6K9g+rAw2inSQq5rXkIeHBIM8aSA==
X-Received: by 2002:a05:6830:3490:b0:72a:1a9f:7dde with SMTP id 46e09a7af769-72a37b978d4mr323332a34.9.1741289276076;
        Thu, 06 Mar 2025 11:27:56 -0800 (PST)
Received: from stbirv-lnx-1.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-72a2dac3887sm366338a34.7.2025.03.06.11.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 11:27:55 -0800 (PST)
From: Doug Berger <opendmb@gmail.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Doug Berger <opendmb@gmail.com>
Subject: [PATCH net-next 14/14] net: bcmgenet: revise suspend/resume
Date: Thu,  6 Mar 2025 11:26:42 -0800
Message-Id: <20250306192643.2383632-15-opendmb@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250306192643.2383632-1-opendmb@gmail.com>
References: <20250306192643.2383632-1-opendmb@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the network interface is configured for Wake-on-LAN we should
avoid bringing the interface down and up since it slows the time
to reestablish network traffic on resume.

Redundant calls to phy_suspend() and phy_resume() are removed
since they are already invoked from within phy_stop() and
phy_start() called from bcmgenet_netif_stop() and
bcmgenet_netif_start().

Signed-off-by: Doug Berger <opendmb@gmail.com>
---
 .../net/ethernet/broadcom/genet/bcmgenet.c    | 100 +++++++++++++++---
 .../net/ethernet/broadcom/genet/bcmgenet.h    |   2 +
 .../ethernet/broadcom/genet/bcmgenet_wol.c    |  69 ++++++------
 3 files changed, 119 insertions(+), 52 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index 8aa575b93e56..73d78dcb774d 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -2584,7 +2584,7 @@ static void init_umac(struct bcmgenet_priv *priv)
 
 	/* Enable MDIO interrupts on GENET v3+ */
 	if (bcmgenet_has_mdio_intr(priv))
-		int0_enable |= (UMAC_IRQ_MDIO_DONE | UMAC_IRQ_MDIO_ERROR);
+		int0_enable |= UMAC_IRQ_MDIO_EVENT;
 
 	bcmgenet_intrl2_0_writel(priv, int0_enable, INTRL2_CPU_MASK_CLEAR);
 
@@ -3150,10 +3150,8 @@ static irqreturn_t bcmgenet_isr0(int irq, void *dev_id)
 	netif_dbg(priv, intr, priv->dev,
 		  "IRQ=0x%x\n", status);
 
-	if (bcmgenet_has_mdio_intr(priv) &&
-		status & (UMAC_IRQ_MDIO_DONE | UMAC_IRQ_MDIO_ERROR)) {
+	if (bcmgenet_has_mdio_intr(priv) && status & UMAC_IRQ_MDIO_EVENT)
 		wake_up(&priv->wq);
-	}
 
 	/* all other interested interrupts handled in bottom half */
 	status &= (UMAC_IRQ_LINK_EVENT | UMAC_IRQ_PHY_DET_R);
@@ -3311,19 +3309,21 @@ static void bcmgenet_netif_stop(struct net_device *dev, bool stop_phy)
 {
 	struct bcmgenet_priv *priv = netdev_priv(dev);
 
-	bcmgenet_disable_tx_napi(priv);
 	netif_tx_disable(dev);
 
 	/* Disable MAC receive */
+	bcmgenet_hfb_reg_writel(priv, 0, HFB_CTRL);
 	umac_enable_set(priv, CMD_RX_EN, false);
 
+	if (stop_phy)
+		phy_stop(dev->phydev);
+
 	bcmgenet_dma_teardown(priv);
 
 	/* Disable MAC transmit. TX DMA disabled must be done before this */
 	umac_enable_set(priv, CMD_TX_EN, false);
 
-	if (stop_phy)
-		phy_stop(dev->phydev);
+	bcmgenet_disable_tx_napi(priv);
 	bcmgenet_disable_rx_napi(priv);
 	bcmgenet_intr_disable(priv);
 
@@ -4043,7 +4043,10 @@ static int bcmgenet_resume_noirq(struct device *d)
 			pm_wakeup_event(&priv->pdev->dev, 0);
 
 		/* From WOL-enabled suspend, switch to regular clock */
-		bcmgenet_power_up(priv, GENET_POWER_WOL_MAGIC);
+		if (!bcmgenet_power_up(priv, GENET_POWER_WOL_MAGIC))
+			return 0;
+
+		/* Failed so fall through to reset MAC */
 	}
 
 	/* If this is an internal GPHY, power it back on now, before UniMAC is
@@ -4055,8 +4058,6 @@ static int bcmgenet_resume_noirq(struct device *d)
 	/* take MAC out of reset */
 	bcmgenet_umac_reset(priv);
 
-	bcmgenet_intrl2_0_writel(priv, UMAC_IRQ_WAKE_EVENT, INTRL2_CPU_CLEAR);
-
 	return 0;
 }
 
@@ -4066,10 +4067,46 @@ static int bcmgenet_resume(struct device *d)
 	struct bcmgenet_priv *priv = netdev_priv(dev);
 	struct bcmgenet_rxnfc_rule *rule;
 	int ret;
+	u32 reg;
 
 	if (!netif_running(dev))
 		return 0;
 
+	if (device_may_wakeup(d) && priv->wolopts) {
+		reg = bcmgenet_umac_readl(priv, UMAC_CMD);
+		if (reg & CMD_RX_EN) {
+			/* Successfully exited WoL, just resume data flows */
+			list_for_each_entry(rule, &priv->rxnfc_list, list)
+				if (rule->state == BCMGENET_RXNFC_STATE_ENABLED)
+					bcmgenet_hfb_enable_filter(priv,
+							rule->fs.location + 1);
+			bcmgenet_hfb_enable_filter(priv, 0);
+			bcmgenet_set_rx_mode(dev);
+			bcmgenet_enable_rx_napi(priv);
+
+			/* Reinitialize Tx flows */
+			bcmgenet_tdma_disable(priv);
+			bcmgenet_init_tx_queues(priv->dev);
+			reg = bcmgenet_tdma_readl(priv, DMA_CTRL);
+			reg |= DMA_EN;
+			bcmgenet_tdma_writel(priv, reg, DMA_CTRL);
+			bcmgenet_enable_tx_napi(priv);
+
+			bcmgenet_link_intr_enable(priv);
+			phy_start_machine(dev->phydev);
+
+			netif_device_attach(dev);
+			enable_irq(priv->irq1);
+			return 0;
+		}
+		/* MAC was reset so complete bcmgenet_netif_stop() */
+		umac_enable_set(priv, CMD_RX_EN | CMD_TX_EN, false);
+		bcmgenet_rdma_disable(priv);
+		bcmgenet_intr_disable(priv);
+		bcmgenet_fini_dma(priv);
+		enable_irq(priv->irq1);
+	}
+
 	init_umac(priv);
 
 	phy_init_hw(dev->phydev);
@@ -4116,19 +4153,52 @@ static int bcmgenet_suspend(struct device *d)
 {
 	struct net_device *dev = dev_get_drvdata(d);
 	struct bcmgenet_priv *priv = netdev_priv(dev);
+	struct bcmgenet_rxnfc_rule *rule;
+	u32 reg, hfb_enable = 0;
 
 	if (!netif_running(dev))
 		return 0;
 
 	netif_device_detach(dev);
 
-	bcmgenet_netif_stop(dev, true);
+	if (device_may_wakeup(d) && priv->wolopts) {
+		netif_tx_disable(dev);
+
+		/* Suspend non-wake Rx data flows */
+		if (priv->wolopts & WAKE_FILTER)
+			list_for_each_entry(rule, &priv->rxnfc_list, list)
+				if (rule->fs.ring_cookie == RX_CLS_FLOW_WAKE &&
+				    rule->state == BCMGENET_RXNFC_STATE_ENABLED)
+					hfb_enable |= 1 << rule->fs.location;
+		reg = bcmgenet_hfb_reg_readl(priv, HFB_CTRL);
+		if (GENET_IS_V1(priv) || GENET_IS_V2(priv)) {
+			reg &= ~RBUF_HFB_FILTER_EN_MASK;
+			reg |= hfb_enable << (RBUF_HFB_FILTER_EN_SHIFT + 1);
+		} else {
+			bcmgenet_hfb_reg_writel(priv, hfb_enable << 1,
+						HFB_FLT_ENABLE_V3PLUS + 4);
+		}
+		if (!hfb_enable)
+			reg &= ~RBUF_HFB_EN;
+		bcmgenet_hfb_reg_writel(priv, reg, HFB_CTRL);
 
-	if (!device_may_wakeup(d))
-		phy_suspend(dev->phydev);
+		/* Clear any old filter matches so only new matches wake */
+		bcmgenet_intrl2_0_writel(priv, 0xFFFFFFFF, INTRL2_CPU_MASK_SET);
+		bcmgenet_intrl2_0_writel(priv, 0xFFFFFFFF, INTRL2_CPU_CLEAR);
 
-	/* Disable filtering */
-	bcmgenet_hfb_reg_writel(priv, 0, HFB_CTRL);
+		if (-ETIMEDOUT == bcmgenet_tdma_disable(priv))
+			netdev_warn(priv->dev,
+				    "Timed out while disabling TX DMA\n");
+
+		bcmgenet_disable_tx_napi(priv);
+		bcmgenet_disable_rx_napi(priv);
+		disable_irq(priv->irq1);
+		bcmgenet_tx_reclaim_all(dev);
+		bcmgenet_fini_tx_napi(priv);
+	} else {
+		/* Teardown the interface */
+		bcmgenet_netif_stop(dev, true);
+	}
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.h b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
index c95601898bd4..10c631bbe964 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.h
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
@@ -274,6 +274,8 @@ struct bcmgenet_mib_counters {
 /* Only valid for GENETv3+ */
 #define UMAC_IRQ_MDIO_DONE		(1 << 23)
 #define UMAC_IRQ_MDIO_ERROR		(1 << 24)
+#define UMAC_IRQ_MDIO_EVENT		(UMAC_IRQ_MDIO_DONE | \
+					 UMAC_IRQ_MDIO_ERROR)
 
 /* INTRL2 instance 1 definitions */
 #define UMAC_IRQ1_TX_INTR_MASK		0xFFFF
diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c b/drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c
index d0f1fa702917..8fb551288298 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c
@@ -145,8 +145,7 @@ int bcmgenet_wol_power_down_cfg(struct bcmgenet_priv *priv,
 				enum bcmgenet_power_mode mode)
 {
 	struct net_device *dev = priv->dev;
-	struct bcmgenet_rxnfc_rule *rule;
-	u32 reg, hfb_ctrl_reg, hfb_enable = 0;
+	u32 reg, hfb_ctrl_reg;
 	int retries = 0;
 
 	if (mode != GENET_POWER_WOL_MAGIC) {
@@ -154,18 +153,6 @@ int bcmgenet_wol_power_down_cfg(struct bcmgenet_priv *priv,
 		return -EINVAL;
 	}
 
-	/* Can't suspend with WoL if MAC is still in reset */
-	spin_lock_bh(&priv->reg_lock);
-	reg = bcmgenet_umac_readl(priv, UMAC_CMD);
-	if (reg & CMD_SW_RESET)
-		reg &= ~CMD_SW_RESET;
-
-	/* disable RX */
-	reg &= ~CMD_RX_EN;
-	bcmgenet_umac_writel(priv, reg, UMAC_CMD);
-	spin_unlock_bh(&priv->reg_lock);
-	mdelay(10);
-
 	if (priv->wolopts & (WAKE_MAGIC | WAKE_MAGICSECURE)) {
 		reg = bcmgenet_umac_readl(priv, UMAC_MPD_CTRL);
 		reg |= MPD_EN;
@@ -177,13 +164,8 @@ int bcmgenet_wol_power_down_cfg(struct bcmgenet_priv *priv,
 	}
 
 	hfb_ctrl_reg = bcmgenet_hfb_reg_readl(priv, HFB_CTRL);
-	if (priv->wolopts & WAKE_FILTER) {
-		list_for_each_entry(rule, &priv->rxnfc_list, list)
-			if (rule->fs.ring_cookie == RX_CLS_FLOW_WAKE)
-				hfb_enable |= (1 << (rule->fs.location + 1));
-		reg = (hfb_ctrl_reg & ~RBUF_HFB_EN) | RBUF_ACPI_EN;
-		bcmgenet_hfb_reg_writel(priv, reg, HFB_CTRL);
-	}
+	reg = hfb_ctrl_reg | RBUF_ACPI_EN;
+	bcmgenet_hfb_reg_writel(priv, reg, HFB_CTRL);
 
 	/* Do not leave UniMAC in MPD mode only */
 	retries = bcmgenet_poll_wol_status(priv);
@@ -198,14 +180,12 @@ int bcmgenet_wol_power_down_cfg(struct bcmgenet_priv *priv,
 	netif_dbg(priv, wol, dev, "MPD WOL-ready status set after %d msec\n",
 		  retries);
 
-	clk_prepare_enable(priv->clk_wol);
+	/* Disable phy status updates while suspending */
+	mutex_lock(&dev->phydev->lock);
+	dev->phydev->state = PHY_READY;
+	mutex_unlock(&dev->phydev->lock);
 
-	if (hfb_enable) {
-		bcmgenet_hfb_reg_writel(priv, hfb_enable,
-					HFB_FLT_ENABLE_V3PLUS + 4);
-		hfb_ctrl_reg = RBUF_HFB_EN | RBUF_ACPI_EN;
-		bcmgenet_hfb_reg_writel(priv, hfb_ctrl_reg, HFB_CTRL);
-	}
+	clk_prepare_enable(priv->clk_wol);
 
 	/* Enable CRC forward */
 	spin_lock_bh(&priv->reg_lock);
@@ -213,13 +193,17 @@ int bcmgenet_wol_power_down_cfg(struct bcmgenet_priv *priv,
 	priv->crc_fwd_en = 1;
 	reg |= CMD_CRC_FWD;
 
+	/* Can't suspend with WoL if MAC is still in reset */
+	if (reg & CMD_SW_RESET)
+		reg &= ~CMD_SW_RESET;
+
 	/* Receiver must be enabled for WOL MP detection */
 	reg |= CMD_RX_EN;
 	bcmgenet_umac_writel(priv, reg, UMAC_CMD);
 	spin_unlock_bh(&priv->reg_lock);
 
 	reg = UMAC_IRQ_MPD_R;
-	if (hfb_enable)
+	if (hfb_ctrl_reg & RBUF_HFB_EN)
 		reg |=  UMAC_IRQ_HFB_SM | UMAC_IRQ_HFB_MM;
 
 	bcmgenet_intrl2_0_writel(priv, reg, INTRL2_CPU_MASK_CLEAR);
@@ -230,6 +214,7 @@ int bcmgenet_wol_power_down_cfg(struct bcmgenet_priv *priv,
 int bcmgenet_wol_power_up_cfg(struct bcmgenet_priv *priv,
 			      enum bcmgenet_power_mode mode)
 {
+	struct net_device *dev = priv->dev;
 	u32 reg;
 
 	if (mode != GENET_POWER_WOL_MAGIC) {
@@ -242,6 +227,10 @@ int bcmgenet_wol_power_up_cfg(struct bcmgenet_priv *priv,
 
 	bcmgenet_intrl2_0_writel(priv, UMAC_IRQ_WAKE_EVENT,
 				 INTRL2_CPU_MASK_SET);
+	if (bcmgenet_has_mdio_intr(priv))
+		bcmgenet_intrl2_0_writel(priv,
+					 UMAC_IRQ_MDIO_EVENT,
+					 INTRL2_CPU_MASK_CLEAR);
 
 	/* Disable Magic Packet Detection */
 	if (priv->wolopts & (WAKE_MAGIC | WAKE_MAGICSECURE)) {
@@ -252,14 +241,12 @@ int bcmgenet_wol_power_up_cfg(struct bcmgenet_priv *priv,
 		bcmgenet_umac_writel(priv, reg, UMAC_MPD_CTRL);
 	}
 
-	/* Disable WAKE_FILTER Detection */
-	if (priv->wolopts & WAKE_FILTER) {
-		reg = bcmgenet_hfb_reg_readl(priv, HFB_CTRL);
-		if (!(reg & RBUF_ACPI_EN))
-			return -EPERM;	/* already reset so skip the rest */
-		reg &= ~(RBUF_HFB_EN | RBUF_ACPI_EN);
-		bcmgenet_hfb_reg_writel(priv, reg, HFB_CTRL);
-	}
+	/* Disable ACPI mode */
+	reg = bcmgenet_hfb_reg_readl(priv, HFB_CTRL);
+	if (!(reg & RBUF_ACPI_EN))
+		return -EPERM;	/* already reset so skip the rest */
+	reg &= ~RBUF_ACPI_EN;
+	bcmgenet_hfb_reg_writel(priv, reg, HFB_CTRL);
 
 	/* Disable CRC Forward */
 	spin_lock_bh(&priv->reg_lock);
@@ -268,5 +255,13 @@ int bcmgenet_wol_power_up_cfg(struct bcmgenet_priv *priv,
 	bcmgenet_umac_writel(priv, reg, UMAC_CMD);
 	spin_unlock_bh(&priv->reg_lock);
 
+	/* Resume link status tracking */
+	mutex_lock(&dev->phydev->lock);
+	if (dev->phydev->link)
+		dev->phydev->state = PHY_RUNNING;
+	else
+		dev->phydev->state = PHY_NOLINK;
+	mutex_unlock(&dev->phydev->lock);
+
 	return 0;
 }
-- 
2.34.1


