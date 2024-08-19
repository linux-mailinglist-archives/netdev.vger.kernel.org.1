Return-Path: <netdev+bounces-119591-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 23290956499
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 09:26:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B251B2327B
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 07:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2654A158214;
	Mon, 19 Aug 2024 07:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ubhwbv59"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43B1156F5E;
	Mon, 19 Aug 2024 07:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724052372; cv=none; b=pRooSY/CGI50WmLEv8D87Tlbk/878z+1DyFXlOSzZFyXZR6Nvg8TevKZcuqJF6UA3hc1zZqsdqk+By+v6wn0yPbdlVESxewROHit2zcCpgS5iArKUuiKNPe8kkLNCZxad+xEPzzRdfCz98E9rWW0iiI/aoCALzMG4OgYVfaFbOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724052372; c=relaxed/simple;
	bh=V1B78nsPXwKtwYadG9TpwoAohUkSiZj7ncPcaNfxp9E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rPciVo/I9l32c1mOQ4uQ7rjyjXguhjY1j8qH8SpW4C9e8e8nWMmMkTmIGXUEUyjwUVMHSlz3hHOzwL8shr52GFJP0r4Beb9jOcBiEC7UXh3VwlKw2KfDgVcllseb0hNqRaNFJLZUKIegdBuonoKaiEN6ib8tPh/3HW3HA2G4tA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ubhwbv59; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2021c08b95cso10066075ad.0;
        Mon, 19 Aug 2024 00:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724052370; x=1724657170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e93oae2VnzqVNZVCAViMoa1uvgxDslJYuHwS+x1kihw=;
        b=Ubhwbv59D4q87sV+MMRXcTTmPXfL/PqTtQfKyVkPa9LMCsSqNpF9O+vn22MnEFWW9u
         sFRGMlOoI0VoszsuIDMifHIymTzszf7zq78V3XE86LfumBJ4I+xVaZTyWlEW7c1WsQ11
         6Hf9lP7IBYakmsQ9aMPKSGI5Mu6SnTNiLQINAkrRy6SsB4Kt+emNhRBxNqYU8pyyzBqh
         rIKZwBCmo+tWnIlveBt4BKNGS9pDnDNPiaooEe7Wo1j1vt7Df9k9s5TGp3SdSDNdRNyQ
         Sjff1XlWMSGNrEfy9GgwBKLzMuLzYA/9UJYsAays9SlsYY8uWb4AgI31UmVLmMawfv7N
         9CUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724052370; x=1724657170;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e93oae2VnzqVNZVCAViMoa1uvgxDslJYuHwS+x1kihw=;
        b=a+VvYe6JfIoQ58AIuLumMflOt8pZwygu8VRISEmCWMBy7VeBgmCkcgrrAkOZwxQ8Yq
         xsb4RhNlLgCA1B+n/FG+TVzJf08eQoXiFL8ZMfC6dpHdUx3SZAP5FN1RchhnEj0N49fJ
         kLWqx3s29T+vz1QaoJhK/I49GuYS3hHBaOz66K1iCDJF3yHvlH3jxukXWgf4iuImmMAm
         uHISmTq1mXR+oRO3ZeIKqmKvVWhl9amPq+NZRlUuCcj+2VNempGDFdo3xinyaCaXctjX
         cx9Pacjf0Jf55d4VNCuauG/xKjMNrScvvt1tB+nYV3lg2y9UPv9YJo16eHOBJK0oWRs6
         AegA==
X-Forwarded-Encrypted: i=1; AJvYcCUQjM56CUDKCq/CXYLVN5LSDuGjNS9FMcCUqPZt1dRSpuP2Wm9D7ovcWEGqY0Zc39YyyGgLi94NNDlWLxcD7snLfSWseP4CNX51vyPx
X-Gm-Message-State: AOJu0Yzn+h1YAPg3cdni1QN/SEHhxeqwk7VDlUer1LTX8idqStrlvy3a
	u1VW/SLWZGK7KECld+2OzNr+wCHnwPYf2xidC1aZBKThfpm4eKbH
X-Google-Smtp-Source: AGHT+IGso1hgFDQM2RtHO9bYMoQKU4sDJZP80zUHXwvevdEA2krPBWan9i05+Zt07fQeZ1SzCfuwBA==
X-Received: by 2002:a17:902:e549:b0:1fd:8b77:998e with SMTP id d9443c01a7336-202062baefamr138939585ad.29.1724052369603;
        Mon, 19 Aug 2024 00:26:09 -0700 (PDT)
Received: from localhost.localdomain ([129.146.253.192])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-201f02faa5dsm58340855ad.2.2024.08.19.00.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 00:26:09 -0700 (PDT)
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
Subject: [PATCH net-next v3 2/7] net: stmmac: drop stmmac_fpe_handshake
Date: Mon, 19 Aug 2024 15:25:15 +0800
Message-Id: <f646d17db237743554d4ba0fc65ce9807cec90d2.1724051326.git.0x1207@gmail.com>
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

ethtool --set-mm can trigger FPE verification processe by calling
stmmac_fpe_send_mpacket, stmmac_fpe_handshake should be gone.

Signed-off-by: Furong Xu <0x1207@gmail.com>
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


