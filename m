Return-Path: <netdev+bounces-125777-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E4DE96E8D9
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 06:57:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B828E284F82
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 04:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F67112DD95;
	Fri,  6 Sep 2024 04:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NyAXQ4M9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC3C12B176;
	Fri,  6 Sep 2024 04:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725598613; cv=none; b=DrXHTTFY0zDjZGqIOuj3dRbCfXqLuTnpnn0QAxo2q3JZnGUOQ5pZ8Xuyn0QiuEG8v4rvksCVswEjIMoSdAGm9M5qxSTFUFDx8bCxLjjRHSFY8cH7S1eGtFvef7C4sSnALV+hTduDgpaYvTHWlaNGESqbPnetJRah55TftXmmQpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725598613; c=relaxed/simple;
	bh=Uf03NK+TcTTM3jFMPZZRi2Aq+HZ0s1AWpNTiYA/4EUU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hGK2S+xoSfgzoxn6LLtA8GD7AiWVNPn+LEBMDLL2XZHjOxyB2QtSNsCsBdC+LIbSCe37BJnuuAtSTM3q14GmrHiVdJ4MdBZpGytf9eoPwCMfnJnhKG2KpTZXjtp2vG/iESqlahQqRtNAM1zXI6qE/XiuPfrObAp6ewNGng5G420=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NyAXQ4M9; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-71798a15ce5so727194b3a.0;
        Thu, 05 Sep 2024 21:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725598611; x=1726203411; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=awdxA94+EDwJxMaDIv2LrPwLHdX9C7ivLS6VUmJAIug=;
        b=NyAXQ4M9Bo9f2zVXvJKnxzA1mVAfKF9lDMYWe+YBTidMxtfSdpKVLeMxkLGMa/5VrO
         Jqocb6XF1DopLcd7Sh5Itd7GndtzLKnTyeWNnkNSyuflj+Qz+KiZrIWS73ltnUPoji+Z
         sfg7KJGLDpBCjugOVfBpms/NW5Zvt5a5o6/IczNc4VtLqTNjgXOtkzESsi3MhwqNGdBD
         wtdxNSN+CR3iXX6RGA/BeH2gHkzY6yaf/aq9xrFk+MtKBO/wfDZr1B3QccK9oNagVeed
         tByzqLLE9SPOC5ecQkqhga4RWqVTCt3Z+1w8Vg5MmYcI0TrM56go5iGQwW39wPqCyBew
         6OOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725598611; x=1726203411;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=awdxA94+EDwJxMaDIv2LrPwLHdX9C7ivLS6VUmJAIug=;
        b=YF5BPkYKRDmu5oZ/QpPN7n3ikzhiiA8tW3eMJVPxCt2mFscYagpTyfc/pe2XheqiL5
         1s3hOxqaKEZaIWpC9kPmghw3MXeTOkzPjB5xw0sgpbXbgFaQiwkF6jA+tC/ERHRhMiXp
         1tlChMdjgPzbYcnRTL8rKmT73Em+EUTMD4WCAj1HHhzEW9yNIMNmBnu3gmUqLxgWviPO
         31xC5I72XZGAHlbQnqClZizOLaz1EuKoUW4Z0B7eFpHe2UNbMR0qEBY5RVyPisl7KS4B
         r7uVNM9jTijWh7i/tLn67ukqQFPYYCmRn1rz1O3GRPsCZA/fafzUXY3CF1UtKs7oRKeX
         LzKg==
X-Forwarded-Encrypted: i=1; AJvYcCWJByudwYycTDugzXrQv003TM1T9y+x8ll/l9jUXeJIZUH8GpwD4VmkYgUJaSWUqkU2OfgWZ27MfsBPnDo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7eKTRvNOoSPUuu6pfQlfSfOqgRqdhojJex1Osdqp8NV2+J9mr
	yFSNxt4Hj1iW5XDleVmox6dlpQ/6LacXHhjKdpbdVMAb9trVPjxm
X-Google-Smtp-Source: AGHT+IHhLryr0A8pwiJ/WABHRdfza5mcvYUq9KAqWs1D4gDvA0WovWkUgZpTbm906++5urOriKthfg==
X-Received: by 2002:a05:6a20:43a9:b0:1bd:1d5f:35be with SMTP id adf61e73a8af0-1cf1bfbb548mr2884149637.11.1725598610767;
        Thu, 05 Sep 2024 21:56:50 -0700 (PDT)
Received: from localhost.localdomain ([129.146.253.192])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-71791e54585sm1704002b3a.182.2024.09.05.21.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 21:56:50 -0700 (PDT)
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
Subject: [PATCH net-next v9 2/7] net: stmmac: drop stmmac_fpe_handshake
Date: Fri,  6 Sep 2024 12:55:57 +0800
Message-Id: <d8c2e22e3b21589286249c35a53f5b9fe831129c.1725597121.git.0x1207@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1725597121.git.0x1207@gmail.com>
References: <cover.1725597121.git.0x1207@gmail.com>
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


