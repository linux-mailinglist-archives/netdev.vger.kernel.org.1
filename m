Return-Path: <netdev+bounces-118011-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C5D9950415
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 13:48:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C21CE1F2230C
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 11:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42BE31991A9;
	Tue, 13 Aug 2024 11:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fplwx3XU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C586E199239;
	Tue, 13 Aug 2024 11:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723549707; cv=none; b=ka8ZacmMo+TbyUcsaBscaJk2K8GSia2IjLVNH0ipMykhnQZmPTX3YnxDNspU/7UtzNqQSAs9gD9ALDKyCFmnaQLb4fPbG+aE9KqI9/KTXafqqmBLfdTFY7HULnmOkCez+2meyINN/pFHzrOrIO4qo9rLOdcYGWOMHKsujTpJMQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723549707; c=relaxed/simple;
	bh=V1B78nsPXwKtwYadG9TpwoAohUkSiZj7ncPcaNfxp9E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EVuO0HHg2Gl8KnH2eij5ACNxWQXmW7aV6FHcFD2z4Q5C3EN6xWqStUR1YwHOPqOR6FzdZVpIaUDHAYUfnAzC5Psx7hTi/HQ4LNNyHpRCIpjimUIepLChdGuRxF1KjMHnLnHRf++oPkLwYqr9M/YqVPvPABvB6vgPtTQWF9pdPx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fplwx3XU; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-710ffaf921fso1353019b3a.1;
        Tue, 13 Aug 2024 04:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723549705; x=1724154505; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e93oae2VnzqVNZVCAViMoa1uvgxDslJYuHwS+x1kihw=;
        b=Fplwx3XUIcZTiLBKxC0tCvLOYF49q0ZZY9foxMoxWtwBWf55wYqNlcqdq1vIijUyuR
         qE5BPfjz19kVhWgSbGhNwR6oDxp2z9SHaSUZzkCiph85ar4eH8QDoICTKj+73Yx1HTQb
         SgR11U5b1t2hHL8cRmsKKdUM8j5gm43TOk16UQY8BE6BhJIqbwFYSLg0EH4g7kw4QIGc
         LNluWaxWzlIZ2MpLcljp3dJYUkCe36Sk7drW+TrGKCw90LdA7Cr+/6W1tO1AMYMqTYLc
         vKjJU+pLKs3HtLZYZ5+hdvlB9QbYD8uK57LKvCFJRPK3Gb/lWP60/81vbLCBooL1aJuW
         cjKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723549705; x=1724154505;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e93oae2VnzqVNZVCAViMoa1uvgxDslJYuHwS+x1kihw=;
        b=HpKZjmjhBcN302Tn52XvGauG9/oavsGbWPDwzVqVAJwp4+t99/QQpuou8G9lVaxHJo
         ffDOhyTXV6qRTyWu1ETdan+2+dSXIV62xyM3SO/SJvny2VBUqB+w4RpCNPk3RWhngu+I
         wGmox7VYZlizh94kg8+7KVBWHEMaByS5kSnfTb1s+Wn2Sh5sL6f25lDffqM0nNsRqUVG
         n7Gl2FOX8xXSr5hB81sLjwk26UOjzY778QBydfM3tLcD97TVsY7ap9ENUVp8eHz7KsRj
         06HH8Je42+EwRi2LhYJFyZ0Os0M1vKEBr9pRRGpeVD5LGqGu+GO4I20tLUTamPtN2tTZ
         XVgw==
X-Forwarded-Encrypted: i=1; AJvYcCVWBWhnodkOgy5+R6zTk1kirBLSzqEnO+uNMbQG7gcIqn+SdBLrs0TOHsWscRhWMTnlWXKcgXRbTShPi7AXPi3b/Zy9A+Cvi+MNJ+SL
X-Gm-Message-State: AOJu0Yzf50YGrGz4eudeU/NY0fx9LD6mXGRLAFn7UNA1+pyLPKkpg4/G
	DlgPs8OeebsJgIcwdLidLOVPHXffG21O1Jgpp7Bz4GivHrnsZ4eo
X-Google-Smtp-Source: AGHT+IGxt8hPD8mJsm6gJter71iHAjEsFjuWECdz+VoqMfy71FcU+f7SGPt+SjXcXj2P7sGD0bgpJQ==
X-Received: by 2002:a05:6a20:c78f:b0:1c3:b148:690e with SMTP id adf61e73a8af0-1c8da1925c8mr4631707637.5.1723549704906;
        Tue, 13 Aug 2024 04:48:24 -0700 (PDT)
Received: from localhost.localdomain ([129.146.253.192])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-710e5a562bbsm5548755b3a.111.2024.08.13.04.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 04:48:24 -0700 (PDT)
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
	rock.xu@nio.com,
	Furong Xu <0x1207@gmail.com>
Subject: [PATCH net-next v2 2/7] net: stmmac: drop stmmac_fpe_handshake
Date: Tue, 13 Aug 2024 19:47:28 +0800
Message-Id: <02703a16d35eaa28ad513d56bc52427e0fcbbddd.1723548320.git.0x1207@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1723548320.git.0x1207@gmail.com>
References: <cover.1723548320.git.0x1207@gmail.com>
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


