Return-Path: <netdev+bounces-125960-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D2D96F6BE
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 16:31:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7D781F24A74
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 14:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE0EA1D0DE4;
	Fri,  6 Sep 2024 14:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FIF6AqgG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A661D0DDF;
	Fri,  6 Sep 2024 14:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725633052; cv=none; b=Mgn1glPsP8S+S7/0bi+r4ATB3NMd1v8/juDAEnqrr3rvVywxz0XD0oN/dOi0MpEGFM6J6jZqW2hvciTQ2im7vdr1rtfikLn4Igk4ezYc/4VaojaYY/WylS/qIs3FXFpcIr441Fpa+jIGxsZeCuObwyQiWBv3ZHEERmE+/853yyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725633052; c=relaxed/simple;
	bh=Uf03NK+TcTTM3jFMPZZRi2Aq+HZ0s1AWpNTiYA/4EUU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tTVecoeM+z9h/Po8/1MbcFctNWmKGr24BAfaJNSPB8lwqncJRi9UC7NMMAiVtLtf4STSBtweSddfSPm7RZd3a/k2N8jpT8k4ko/G8Pab+3R8w6/TTxdNUzL7K8FRXmjKHv0Jb5aPyvl8kFGEOt8V8WOKKmDDhfjsdhxmh1hkJgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FIF6AqgG; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2068bee21d8so22211665ad.2;
        Fri, 06 Sep 2024 07:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725633051; x=1726237851; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=awdxA94+EDwJxMaDIv2LrPwLHdX9C7ivLS6VUmJAIug=;
        b=FIF6AqgG4czY4Zgb/lNpopDn52XuNsCClAav9ZIJ7KCgKj/Zacz08eA3nw9++vWvap
         KRaK7kjGhg7zsfujH5A7QjnzxUFZHkjAKNbDkudhiVcYJP0WcjfSwBO8onGLxUYVMeWo
         OUKgT5kszX1wYCqq58CiB7GQ5BoAuTBTkRh69FrSHeZ7yGFSQ+4Slr6KOZW+jklz7Uxs
         chr602CPEN19njG828CkJvhgDTYMgL2BspfYjI9QIxadvHwR+TM+rpAY2esxoI+ZakQ4
         ZiATzevvWdd4lx5+Je0ojj0RIoQa6O4sGZaUP/azKeJRxYaLVVCyJ7IZ7UDzobpujW7i
         TEUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725633051; x=1726237851;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=awdxA94+EDwJxMaDIv2LrPwLHdX9C7ivLS6VUmJAIug=;
        b=A/AXe3QT/fg7Vun1+fZj+mLc3cWe4hLKYCV66vP4AuWqloflJ3GDQwuGzdim1HRPEm
         Qp+z8pOjOzJ/Fo8MOTy/L1S2+tBm7fUKJ8CJAP5gG0MBs/CYNU+NZKNRkqBi8Z+D0u+I
         2a8tEqTFQm0tH86UQXOwO0KLVIH8uuS5MidjASRk2y0kEpfD922Yty/WAsPnLYR6dP+g
         hcpzcI6D2mvX41DaifFPImD2G9afV+7ItFjTIoLlfcLCJtvapA1pKTztGTBX0dDbtzWB
         vCV4X/yZ6cc5GEf5E+tDBFUCd5p/0YBXkyvU69VHloLS72AbyKlhZMPnEbZR2UBmMKwk
         Df2g==
X-Forwarded-Encrypted: i=1; AJvYcCUsoKRSR0UsOf5ZOyQ5bLi1yvZXVbiVagi3YCkvWV57KBLW4/2A3fpBiD8Wh05ku2H9I3XcMq54NuQYdow=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoF7GQzJ7UK2Oc4uK2YJ+BzOXeoilRqimxAWAhWKOreH/Ce7SQ
	ZzquxjjwUYqOFfkuPFzoD/rgUS2hLcnkHZqyATRG9MYH7X+h0Iyc
X-Google-Smtp-Source: AGHT+IFzZCrAUEVZJhp3/dgNTm/ePgkDAtbdtsSkmJiBTbfLT842CI3EEnlRgDIcXOZLkIzHl5TKsw==
X-Received: by 2002:a17:902:d4c1:b0:205:913b:d9ad with SMTP id d9443c01a7336-205913bdac2mr142716705ad.0.1725633050435;
        Fri, 06 Sep 2024 07:30:50 -0700 (PDT)
Received: from localhost.localdomain ([129.146.253.192])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-206ae94dcf3sm43951975ad.80.2024.09.06.07.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 07:30:50 -0700 (PDT)
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
Subject: [PATCH net-next v10 2/7] net: stmmac: drop stmmac_fpe_handshake
Date: Fri,  6 Sep 2024 22:30:07 +0800
Message-Id: <42018b1a15eb3ced567fd6a73798c7cd4e08799a.1725631883.git.0x1207@gmail.com>
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

ethtool --set-mm can trigger FPE verification process by calling
stmmac_fpe_send_mpacket, stmmac_fpe_handshake should be gone.

Signed-off-by: Furong Xu <0x1207@gmail.com>
Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  1 -
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 23 +------------------
 .../net/ethernet/stmicro/stmmac/stmmac_tc.c   |  8 -------
 3 files changed, 1 insertion(+), 31 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index 458d6b16ce21..3ad182ef8e97 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -425,7 +425,6 @@ bool stmmac_eee_init(struct stmmac_priv *priv);
 int stmmac_reinit_queues(struct net_device *dev, u32 rx_cnt, u32 tx_cnt);
 int stmmac_reinit_ringparam(struct net_device *dev, u32 rx_size, u32 tx_size);
 int stmmac_bus_clks_config(struct stmmac_priv *priv, bool enabled);
-void stmmac_fpe_handshake(struct stmmac_priv *priv, bool enable);
 
 static inline bool stmmac_xdp_is_enabled(struct stmmac_priv *priv)
 {
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 529fe31f8b04..3072ad33b105 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -3533,13 +3533,9 @@ static int stmmac_hw_setup(struct net_device *dev, bool ptp_register)
 
 	stmmac_set_hw_vlan_mode(priv, priv->hw);
 
-	if (priv->dma_cap.fpesel) {
+	if (priv->dma_cap.fpesel)
 		stmmac_fpe_start_wq(priv);
 
-		if (priv->fpe_cfg.enable)
-			stmmac_fpe_handshake(priv, true);
-	}
-
 	return 0;
 }
 
@@ -7425,22 +7421,6 @@ static void stmmac_fpe_lp_task(struct work_struct *work)
 	clear_bit(__FPE_TASK_SCHED, &priv->fpe_task_state);
 }
 
-void stmmac_fpe_handshake(struct stmmac_priv *priv, bool enable)
-{
-	if (priv->fpe_cfg.hs_enable != enable) {
-		if (enable) {
-			stmmac_fpe_send_mpacket(priv, priv->ioaddr,
-						&priv->fpe_cfg,
-						MPACKET_VERIFY);
-		} else {
-			priv->fpe_cfg.lo_fpe_state = FPE_STATE_OFF;
-			priv->fpe_cfg.lp_fpe_state = FPE_STATE_OFF;
-		}
-
-		priv->fpe_cfg.hs_enable = enable;
-	}
-}
-
 static int stmmac_xdp_rx_timestamp(const struct xdp_md *_ctx, u64 *timestamp)
 {
 	const struct stmmac_xdp_buff *ctx = (void *)_ctx;
@@ -7902,7 +7882,6 @@ int stmmac_suspend(struct device *dev)
 				     priv->plat->tx_queues_to_use,
 				     priv->plat->rx_queues_to_use, false);
 
-		stmmac_fpe_handshake(priv, false);
 		stmmac_fpe_stop_wq(priv);
 	}
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
index 9cc41ed01882..b0cc45331ff7 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
@@ -1078,11 +1078,6 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
 
 	netdev_info(priv->dev, "configured EST\n");
 
-	if (fpe) {
-		stmmac_fpe_handshake(priv, true);
-		netdev_info(priv->dev, "start FPE handshake\n");
-	}
-
 	return 0;
 
 disable:
@@ -1107,9 +1102,6 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
 			     false);
 	netdev_info(priv->dev, "disabled FPE\n");
 
-	stmmac_fpe_handshake(priv, false);
-	netdev_info(priv->dev, "stop FPE handshake\n");
-
 	return ret;
 }
 
-- 
2.34.1


