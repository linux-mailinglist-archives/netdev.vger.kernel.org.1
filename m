Return-Path: <netdev+bounces-120119-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC3D9585A7
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 13:22:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F9711F25557
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 11:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060A618EFC2;
	Tue, 20 Aug 2024 11:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f7bRPZLj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADF218E77C;
	Tue, 20 Aug 2024 11:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724152893; cv=none; b=gThXJTclBL0KA5InKA01BjIUZ+p7Tclmx6CB+WKLFtZwsDtlYHP+gUIQGoQzfn60zK4sbpPSdIO2C4rtD/M8aMLtun5tpRT8c/97zO8VyU7xVFqT59I4wDEBsx/wOkVFOhEVgd27qcCw/Pe3dKLj/cwwTX8e30tG1i2T7ZQMAh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724152893; c=relaxed/simple;
	bh=bKZn8uAFLNGF4sLyhMhyQT/sxSz/uz5o4dwplVIwm6A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gXlPXf5/UAUIT/ildFceN07wG5EhnjeSKmL1xmIung8lG8bR8br+ZhbwQ0TTDU7nvAq7UQHS3nV3L/qwBvrzUBwhpcpiHacw7V6ie1Jbkq2nKe71JXnALkU4FVgdpMaDgtwmQgWKqWKBKF147lMpDbNMXLH4Vncwm3t1n3juJYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f7bRPZLj; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-201fae21398so31382475ad.1;
        Tue, 20 Aug 2024 04:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724152892; x=1724757692; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LVDwdCzbnOeidXl/hDBd3l3mbR23PEP/JczHyoisLlw=;
        b=f7bRPZLj8oQxX1+7HJjhJOlS6mysjFqf0dusDzMY0M0PGddPMsml64sZk1Gz65ka4o
         swGvVfK4VVZsR2mHi7y8AQXXuoyLa9r7t+wkhCKbg+pL8xq3Jj1ylejfiff2Etb6yeWL
         i4dnRO0EDCYEA+xZTCa1EF3oe4GvSPto3GnUaPLSf+E9/IgwRHl7dI5N2HCD4LaD2q4l
         z2A12332A3hcG4JnFLv5yi1aJy7Nug+IdNy20t8i7TQn4lWrUsj52NhNmbPMgoEt3gbY
         793LGhYQXHu2L3gG9c0a6J8KQrAedHy/N1K4IIAXLEA4ORtEchTa7nAbJVg3PdXP/Y5+
         xd3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724152892; x=1724757692;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LVDwdCzbnOeidXl/hDBd3l3mbR23PEP/JczHyoisLlw=;
        b=i6j6LYz/8k9i4sC2ewSgIWBVfagLp55+gPPfpC/bHge/aLn9belx89bAsTkvN/Vz4q
         UTBZLTM9yxtb6W5UVM1nfx+pT21oVxhBlTDleJLZtAVcUGwBQBUGr0LWPN8gVkrk3wPV
         nfaZVzsnQLrEXj7fEqwAuYLtsuZsU6HJ+Ll6hsKM8qB78EjnFaZkHBwbyayj73A67X1q
         i2VQX5zEsQm/w7x7jf7HhF5P/w6BruSM+dW8eOnZfGS8pmsKQLy8eHEuXRUzc5aBmHqS
         NpBR66IvBlx/WrEsjJAJLQFlOpXIVViDXtaiCVPfq9yENqKMbhAwBPyL/rcKPBOoV11f
         7VAw==
X-Forwarded-Encrypted: i=1; AJvYcCWcmTd3+d+cCWJr5WOEuuivxgg1SMiH7swlk6FvVMv5wPyxWUHfJS4HGRbQ5cYaDW+gn4AGFU2yH5C4+ksP5P9iYTxZLmPlf7Le7SPc
X-Gm-Message-State: AOJu0YwVCpYKJxcXn3noNI54GmeZiRiZZlcy+lrYSF6Qq8vlopVBZfu+
	mW5gSzqbl2UsQ9p+MpLaZNih46ooGOmSxaRAEGZn0WKU307LfR9cAZh4JA==
X-Google-Smtp-Source: AGHT+IFudCQbVwdrFeCFCkW6U4cd9Z6nyRYFjjSO2yta7woZbYAqM+UwO/W6VYoUoKZuIjA8vY3X+Q==
X-Received: by 2002:a17:902:c942:b0:201:ffef:4652 with SMTP id d9443c01a7336-20203e4f49fmr155363785ad.2.1724152891473;
        Tue, 20 Aug 2024 04:21:31 -0700 (PDT)
Received: from localhost.localdomain ([129.146.253.192])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-201f03756f6sm76465355ad.172.2024.08.20.04.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 04:21:30 -0700 (PDT)
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
Subject: [PATCH net-next v5 2/7] net: stmmac: drop stmmac_fpe_handshake
Date: Tue, 20 Aug 2024 19:20:36 +0800
Message-Id: <eb604f2d1eba6924387c17a627523e0de02ec642.1724152528.git.0x1207@gmail.com>
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

ethtool --set-mm can trigger FPE verification process by calling
stmmac_fpe_send_mpacket, stmmac_fpe_handshake should be gone.

Signed-off-by: Furong Xu <0x1207@gmail.com>
Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 23 +------------------
 .../net/ethernet/stmicro/stmmac/stmmac_tc.c   |  8 -------
 2 files changed, 1 insertion(+), 30 deletions(-)

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


