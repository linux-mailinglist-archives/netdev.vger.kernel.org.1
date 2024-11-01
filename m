Return-Path: <netdev+bounces-141026-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D719B9215
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 14:32:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70B2F2851D2
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 13:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C45F01A3BD5;
	Fri,  1 Nov 2024 13:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jgedjw5I"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A961F1A3A9A;
	Fri,  1 Nov 2024 13:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730467932; cv=none; b=tgEoGHXX5TWKKD5slLPuJMOYYBtsH6K9OvXvSuX+7xoVaGMJ2+Dfyoy1axgfnxSabjgK4tNQW4Ef71XxDMvrCTBB3J/vKg+kghd6oH+bJbrJsuAOqntViZiPLQqTAv+NLn3J7xAOReYdRbTZ+4+KX4wyX+C/NDPf5oGODg0jfF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730467932; c=relaxed/simple;
	bh=JULa1Zgyv7yMfuU/6zX2x282wCnFOazQWJCRw4XSUpo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FNbV0SFEBXJDon4D6AhqFYdwVNb+9wLABcPmEbl6NRHLNtnj/zPTPBYCSuY7ogt2PBfvalaLH80nv7anCD5M45jAdgUPzz6zIJK3qWKaSsEEjtWplvlwzjN0dVwz+iTJSeWw2+/3XIREI6d4vh3Q7k4EhWFRMy5MeTtH1V3jEdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jgedjw5I; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-71ec997ad06so1620933b3a.3;
        Fri, 01 Nov 2024 06:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730467929; x=1731072729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EzBHJrheRbAs9ESwUVActksrcefHG2ISlco4X5/KYT0=;
        b=Jgedjw5IaLZp/oBNRWn+jKh4QlfQfhFTvnYMRKH5vz8m5kK4Y4YEEc5+0Hokxfbh6L
         ojK8YmLnxKSmBqnuz/0Loqb3jrTACGfUgMLrQUTdJQzw4QN6OmD6CVqvAVAxh5jCYpuM
         QdQr88bEuadRWJElNjS70bSUyRGSLzEEPy9Pdhr2mdmkIVGV7r33XHf8VA3J88TPTHst
         1njKuQ7sduFCAwVyU5/6Ok1fUtHFaMS1+Gwpzdtp96PNrHRjE9UwjNSpDdJJtmfD9JHJ
         GXxSyt9Bj7NeLdsfYCAjzgS8+oX5X+hsFTQ/mOFbey00bhC0klntftxqdAV1XKm/MVNm
         EWTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730467929; x=1731072729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EzBHJrheRbAs9ESwUVActksrcefHG2ISlco4X5/KYT0=;
        b=WMpnJh1OBN0PRWg/aAd78hFjPrsT/B9/Tihl+8zEZURGXGcjknjIhoRAfAR9LyLrbW
         lZuRrzh+WqoxoYcPPvR+Sha1CHeGJhSxMduqVjUIDCh48iSOZxM7u+hr7l8WiGQZkBav
         wtwJY/3lv59+l7AZDVw2NeBD74PTjdBfC1IxmmzeNTj4EraVXjxyOsdTm07NT4Xijohr
         HT2XBoyxV1rNC0tVzI+VLt0rt7c5wrGZaRnGno6AgMHv35UYCajI5PzXVlCcc5Yd20R3
         ZCcSNfKFdr4yFKcjHoD5j5nbN2BXfFjRG6pB19NV9Desig2/u1DgycnFgzjkbF0l4v1o
         j23w==
X-Forwarded-Encrypted: i=1; AJvYcCXoxAf3QPLJ1ko2v3czjwpuqFCcBumws9y/HmEWM9h55vAzS+NE1nYoyYYRT/fDT8I3Snd48rHf3dSxWqU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwguqvLDbjkHnbq/6DG7p5yQQ9g6enbjMEnuHC4H1WiCjO4wKQ
	GuPxSQELMvMUWpqExGFmCF6VVmL2sCwG4jx902xqsFN1GhZGauPu3u7P3Q==
X-Google-Smtp-Source: AGHT+IEU3hlJ/JMUnrwPhP3mIJwmRERMQKQSquNIAWr9P7V8Y6tRLbHl11iI7I2jGvPtZs7xGGcABw==
X-Received: by 2002:a05:6a20:2d29:b0:1d8:a1dc:b3b with SMTP id adf61e73a8af0-1d9eec4580fmr16171427637.20.1730467929332;
        Fri, 01 Nov 2024 06:32:09 -0700 (PDT)
Received: from localhost.localdomain ([129.146.253.192])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-7ee452ac4ffsm2425552a12.25.2024.11.01.06.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 06:32:08 -0700 (PDT)
From: Furong Xu <0x1207@gmail.com>
To: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Vladimir Oltean <olteanv@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	andrew+netdev@lunn.ch,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	xfr@outlook.com,
	Furong Xu <0x1207@gmail.com>
Subject: [PATCH net-next v8 3/8] net: stmmac: Introduce stmmac_fpe_supported()
Date: Fri,  1 Nov 2024 21:31:30 +0800
Message-Id: <01e9cd13aedd38cb0e9a5d9875c475ce35250188.1730449003.git.0x1207@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1730449003.git.0x1207@gmail.com>
References: <cover.1730449003.git.0x1207@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A single "priv->dma_cap.fpesel" checks HW capability only,
while both HW capability and driver capability shall be
checked by later refactoring to prevent unexpected behavior
for FPE on unsupported MAC cores and keep FPE as an optional
implementation for current and new MAC cores.

Signed-off-by: Furong Xu <0x1207@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c |  2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c     |  5 +++++
 drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.h     |  1 +
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c    | 10 +++++-----
 4 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
index 2792a4c6cbcd..704019e2755b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
@@ -1271,7 +1271,7 @@ static int stmmac_get_mm(struct net_device *ndev,
 	unsigned long flags;
 	u32 frag_size;
 
-	if (!priv->dma_cap.fpesel)
+	if (!stmmac_fpe_supported(priv))
 		return -EOPNOTSUPP;
 
 	spin_lock_irqsave(&priv->fpe_cfg.lock, flags);
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
index 41c9cccfb5de..2b99033f9425 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
@@ -27,6 +27,11 @@
 #define STMMAC_MAC_FPE_CTRL_STS_SVER	BIT(1)
 #define STMMAC_MAC_FPE_CTRL_STS_EFPE	BIT(0)
 
+bool stmmac_fpe_supported(struct stmmac_priv *priv)
+{
+	return priv->dma_cap.fpesel;
+}
+
 void dwmac5_fpe_configure(void __iomem *ioaddr, struct stmmac_fpe_cfg *cfg,
 			  u32 num_txq, u32 num_rxq,
 			  bool tx_enable, bool pmac_enable)
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.h b/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.h
index 25725fd5182f..fc9d869f9b6a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.h
@@ -23,6 +23,7 @@ struct stmmac_fpe_cfg;
 
 void stmmac_fpe_link_state_handle(struct stmmac_priv *priv, bool is_up);
 void stmmac_fpe_event_status(struct stmmac_priv *priv, int status);
+bool stmmac_fpe_supported(struct stmmac_priv *priv);
 void stmmac_fpe_init(struct stmmac_priv *priv);
 void stmmac_fpe_apply(struct stmmac_priv *priv);
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 20bd5440abca..342edec8b507 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -978,7 +978,7 @@ static void stmmac_mac_link_down(struct phylink_config *config,
 	priv->eee_enabled = stmmac_eee_init(priv);
 	stmmac_set_eee_pls(priv, priv->hw, false);
 
-	if (priv->dma_cap.fpesel)
+	if (stmmac_fpe_supported(priv))
 		stmmac_fpe_link_state_handle(priv, false);
 }
 
@@ -1092,7 +1092,7 @@ static void stmmac_mac_link_up(struct phylink_config *config,
 		stmmac_set_eee_pls(priv, priv->hw, true);
 	}
 
-	if (priv->dma_cap.fpesel)
+	if (stmmac_fpe_supported(priv))
 		stmmac_fpe_link_state_handle(priv, true);
 
 	if (priv->plat->flags & STMMAC_FLAG_HWTSTAMP_CORRECT_LATENCY)
@@ -4040,7 +4040,7 @@ static int stmmac_release(struct net_device *dev)
 
 	stmmac_release_ptp(priv);
 
-	if (priv->dma_cap.fpesel)
+	if (stmmac_fpe_supported(priv))
 		timer_shutdown_sync(&priv->fpe_cfg.verify_timer);
 
 	pm_runtime_put(priv->device);
@@ -5955,7 +5955,7 @@ static void stmmac_common_interrupt(struct stmmac_priv *priv)
 		stmmac_est_irq_status(priv, priv, priv->dev,
 				      &priv->xstats, tx_cnt);
 
-	if (priv->dma_cap.fpesel) {
+	if (stmmac_fpe_supported(priv)) {
 		int status = stmmac_fpe_irq_status(priv, priv->ioaddr,
 						   priv->dev);
 
@@ -7745,7 +7745,7 @@ int stmmac_suspend(struct device *dev)
 	}
 	rtnl_unlock();
 
-	if (priv->dma_cap.fpesel)
+	if (stmmac_fpe_supported(priv))
 		timer_shutdown_sync(&priv->fpe_cfg.verify_timer);
 
 	priv->speed = SPEED_UNKNOWN;
-- 
2.34.1


