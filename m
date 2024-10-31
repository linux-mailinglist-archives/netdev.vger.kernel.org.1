Return-Path: <netdev+bounces-140698-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F9C9B7AD6
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 13:40:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDC6D1C20CEC
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 12:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA751A262D;
	Thu, 31 Oct 2024 12:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cnjKv6Br"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E66A1A257D;
	Thu, 31 Oct 2024 12:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730378336; cv=none; b=WgsyZgMtSzGMSyXyC41U4/KJPJQd3NYvMZDBZUvGmo+ESBi9C2to4x1NcCYhPfExdD0DKjNP9OM4by0/ZbyFUl6nHObhDuj5ONqhf9BY6A1RPOt+gOAes+dSdCJimjcCv5w6LoJZs2ePN6yuw69f4lSNdg3H3xMCp7X2S8+KSOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730378336; c=relaxed/simple;
	bh=rd78XK9KITWaeHJ37CwsKwOpCLVCYdO/RkXAMs+JQko=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=axJXR4Rat6nNEoTocDCu7R+w+utfix+OZpCO+y890+LdNg4SQ4VKq4/QD1Z2X3fuxQMuHdFS9O2hL3KEW9FKguj22BHSv4x8NqqSm7+bJ5BVIbHKd6ISqE2ZT7RDMXPmVpihFvXbZgadkJSprgM4UJEKh2BqG6fq/n6Z7iKZ3TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cnjKv6Br; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-71e5a1c9071so666058b3a.0;
        Thu, 31 Oct 2024 05:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730378333; x=1730983133; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FFGEbEEjLbbQpGlnwYzVMfTZ0wqqjjrWRQOLfRsrvcs=;
        b=cnjKv6BrNdV2rwTBMvV6aoY/Sfq8lstzdCLJXK4In73gW8AgWFM2khBMbn0fat5NCR
         Zw6VIqcNI4ZPFh2oYapZmG5yuMwzIpfTH7YIQ2pPFpN1xBZXMFyg+UL2gmycXThwxsvr
         ZWf9eSNHCByj1cCnefqTyVqVaZHBhFVuFfV7NjS/flC2TtMNGRXJyMkO9r7YvRS3YCeF
         iqkTYEFOBd9tqfayqVrAQT4SyqSv+4Sf5Uv6+ku+dJvMJFKhco+4rUCi2g5I309SGewl
         Tj+CX+STUMlmjlWIYlsfVZgcwM08OBBxetYGFCbauOHZEkzow8IOOS8+nAIygCLmAjVg
         HRIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730378333; x=1730983133;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FFGEbEEjLbbQpGlnwYzVMfTZ0wqqjjrWRQOLfRsrvcs=;
        b=uh0JpawV5PTICRyCsx7VlPf3WETRfadDnIZpZ5sPRlfLyMenyOfS9CfNBbSKa9HhPv
         LI/XlALfuHM77RrkWaovFYK8iu52c4EzKN+pM9eK8KgGFEd6Zi3xMb0vPe1nfZmRSd6n
         tdGZ9q2hR3DCU5sNRRsm90gsod+II85txdZpOyGkWpH9gJ9wTMCTIz9TX5gJQH4J4MEA
         dreT6ZIK58PygTF8Hl9eHtoue2T8r9Go9xB52HbltfseBKFyDayA1o5nTUmJ07ysIaOI
         zNxwyUTR4AfKi9A6eI+5L+umcWfQlBZxw0SnMP1fuy31yiETEnJelfOBabAtJV7FF6A3
         1tgA==
X-Forwarded-Encrypted: i=1; AJvYcCUgpaqCwatI4hO8tzzj5Jhoe5eTEvR1tncZN6x4UOv7yzm4f4nq89fYQPkobUMHkSsX8zguG4alvkQTrsQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXoB63KbZHMYmh40FGceEt1Njy/NPDBx9Fiz11LoCIviRSWntJ
	1afIAeQIkytoBvXVSRyH0DiEbo/DUNdaOgTxmSHzCcf3Mr3fFqP9wNACYQ==
X-Google-Smtp-Source: AGHT+IEZxQHxPYwUn+a4vwc02ndfamOj2UcHfNlIlB+PjdVN/65q2Qw46vrTi7Bee/Ggg5dJokSHdQ==
X-Received: by 2002:a05:6a20:2d29:b0:1d8:a1dc:b3b with SMTP id adf61e73a8af0-1d9eec4580fmr9881706637.20.1730378333058;
        Thu, 31 Oct 2024 05:38:53 -0700 (PDT)
Received: from localhost.localdomain ([129.146.253.192])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-720bc20f50esm1075931b3a.94.2024.10.31.05.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 05:38:51 -0700 (PDT)
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
Subject: [PATCH net-next v7 4/8] net: stmmac: Introduce stmmac_fpe_supported()
Date: Thu, 31 Oct 2024 20:37:58 +0800
Message-Id: <917f3868cdaf8ce1d45239117c3ea1c8c45ba56c.1730376866.git.0x1207@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1730376866.git.0x1207@gmail.com>
References: <cover.1730376866.git.0x1207@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Call stmmac_fpe_supported() to check both HW capability and
driver capability to keep FPE as an optional implementation
for current and new MAC cores.

Signed-off-by: Furong Xu <0x1207@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c |  2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c     | 10 ++++++++++
 drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.h     |  1 +
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c    | 10 +++++-----
 4 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
index f2783f7c46f3..1d77389ce953 100644
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
index 818741579904..fe0877ef5f4f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
@@ -42,6 +42,12 @@ struct stmmac_fpe_reg {
 	const u32 int_en_bit;		/* Frame Preemption Interrupt Enable */
 };
 
+bool stmmac_fpe_supported(struct stmmac_priv *priv)
+{
+	return priv->dma_cap.fpesel && priv->fpe_cfg.reg &&
+		priv->hw->mac->fpe_map_preemption_class;
+}
+
 void stmmac_fpe_link_state_handle(struct stmmac_priv *priv, bool is_up)
 {
 	struct stmmac_fpe_cfg *fpe_cfg = &priv->fpe_cfg;
@@ -173,6 +179,10 @@ void stmmac_fpe_init(struct stmmac_priv *priv)
 	priv->fpe_cfg.status = ETHTOOL_MM_VERIFY_STATUS_DISABLED;
 	timer_setup(&priv->fpe_cfg.verify_timer, stmmac_fpe_verify_timer, 0);
 	spin_lock_init(&priv->fpe_cfg.lock);
+
+	if ((!priv->fpe_cfg.reg || !priv->hw->mac->fpe_map_preemption_class) &&
+	    priv->dma_cap.fpesel)
+		dev_info(priv->device, "FPE on this MAC is not supported by driver.\n");
 }
 
 void stmmac_fpe_apply(struct stmmac_priv *priv)
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.h b/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.h
index 15fcb9ef1a97..2f8bceaf7a0a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.h
@@ -16,6 +16,7 @@ struct stmmac_priv;
 struct stmmac_fpe_cfg;
 
 void stmmac_fpe_link_state_handle(struct stmmac_priv *priv, bool is_up);
+bool stmmac_fpe_supported(struct stmmac_priv *priv);
 void stmmac_fpe_init(struct stmmac_priv *priv);
 void stmmac_fpe_apply(struct stmmac_priv *priv);
 void stmmac_fpe_configure(struct stmmac_priv *priv, bool tx_enable,
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 9fcf2df099ec..883b4b814125 100644
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
@@ -5943,7 +5943,7 @@ static void stmmac_common_interrupt(struct stmmac_priv *priv)
 		stmmac_est_irq_status(priv, priv, priv->dev,
 				      &priv->xstats, tx_cnt);
 
-	if (priv->dma_cap.fpesel)
+	if (stmmac_fpe_supported(priv))
 		stmmac_fpe_irq_status(priv);
 
 	/* To handle GMAC own interrupts */
@@ -7729,7 +7729,7 @@ int stmmac_suspend(struct device *dev)
 	}
 	rtnl_unlock();
 
-	if (priv->dma_cap.fpesel)
+	if (stmmac_fpe_supported(priv))
 		timer_shutdown_sync(&priv->fpe_cfg.verify_timer);
 
 	priv->speed = SPEED_UNKNOWN;
-- 
2.34.1


