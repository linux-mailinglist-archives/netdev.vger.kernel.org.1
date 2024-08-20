Return-Path: <netdev+bounces-120064-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 245C19582E4
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 11:40:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7D971F23CA4
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 09:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F4218DF9B;
	Tue, 20 Aug 2024 09:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bi7A+epq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF0718E027;
	Tue, 20 Aug 2024 09:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724146744; cv=none; b=YCv4R4fvpDlFBHqqwfEVkItEn0H1/+2fIv9OfIV6KkSgTgvsH2V2c4MazDdtVTzVcrOIxtUOvi4H8syEcPStEc2zWyyqikFZendxnljXYBPDjOhVBeGA8kBeC22CjA6dL6E99GEEqm5FEN34hifut3hSYfZEW/MYBOJrRaFEHNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724146744; c=relaxed/simple;
	bh=V1B78nsPXwKtwYadG9TpwoAohUkSiZj7ncPcaNfxp9E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qTtuyTf4UNu0nSKT7cFFbIN4Pxh7kW9hhDv5BB91HKOJPqJV7ABmNEQDGArCcnvD7Jx4JVKByj/gmEKzdCaSffWwSiq4E7DAlfouWdxhb2a56l/sHfW16VLWMwEzyBBcTv7x8uQ5uJWBl+PbOY7ZPS2DSUkDapXKyiegaihRdPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bi7A+epq; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7afd1aeac83so4155878a12.0;
        Tue, 20 Aug 2024 02:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724146742; x=1724751542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e93oae2VnzqVNZVCAViMoa1uvgxDslJYuHwS+x1kihw=;
        b=bi7A+epqjRi+FrSRrtpmBEo5D0WjpMdVIjX6EwlGk4US/Dvz9FLL1khcCmGuB+nGYk
         mDwbqS/USc/doogr44TfIOOzA7LGSiHmR8ywrhaU1uqtzThQBhhMKMI5JD82ZqMUD2ZK
         k0xHUjVsn9SuStGq5hKp6pdd+bh+kQJSjSjg1hGF9jtmhMWU6Wtq0zlCB3F+LZ8kapOr
         Mwybf8GWJs5kUAtJnvefBKBojQtyv8Q1YtdAeNojBmpZtsyBiwvqi9hOcKGzRK15pSzj
         ODth9fmkKi3QsPQCM+qPwBohQWzmE7ZNZ4S5PRbDj7GSBX6f3ZLwEli3P4Ytrt27tM5N
         WynQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724146742; x=1724751542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e93oae2VnzqVNZVCAViMoa1uvgxDslJYuHwS+x1kihw=;
        b=IOsezS9VqU07ZLrC40sytjbGSqcfEH8CtikZaH6f3fFZskX1/wlGN2n+b6/Zk0p4He
         UgOi9oZD1NFjrrVymokacKOp3PCaT+PZlpblc/nr1dn5fx7MyhYE5LbD8jBpKhd2w4zR
         KsVZoEjDrQBwPea8EtOzZJ5AHbr3KTmmKQrrFwT2cwL+Jv9wWNmjMwyh+fLLEAVU4ItH
         9KookTA34lgi89uFFXuPUnhvMj/NwLcZt9t0JPzH/4jXMZVUqrKSAIQBX1QGNF3MfYgY
         Ydo+Cu5xOuFSL1w5Dht3N09tyQKo/dALSohQCJruAfaW9fp6nGc5aud+CMJSQbm7yQTZ
         Hhaw==
X-Forwarded-Encrypted: i=1; AJvYcCWQWuGAnRPf8sGgV42zBprQ4L1Z9M/ZR2Z8nRmfSsVAcahvfLuOuyQcG6yaETFzyne6WVzFLa8kl1Hx/oE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxS1TAh+E6M44xh1EiXCls26z1M7d18mmiGsOIWI73fV4bZJx8l
	IS4GDJWXZfExFvmtMoinBrvPIuSgki6ncNMKgXU6HsmBA9vuR7Ie
X-Google-Smtp-Source: AGHT+IH9IHp5PU/VYkc4YktJk5Ok0SiYyDX8GtYRZy3g1/c5AvOIGPY1vcvblQDjo+zjtJkaJDp13w==
X-Received: by 2002:a17:90a:8d03:b0:2c2:4109:9466 with SMTP id 98e67ed59e1d1-2d47321b181mr3652350a91.8.1724146741853;
        Tue, 20 Aug 2024 02:39:01 -0700 (PDT)
Received: from localhost.localdomain ([129.146.253.192])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2d45246061dsm3230608a91.8.2024.08.20.02.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 02:39:01 -0700 (PDT)
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
Subject: [PATCH net-next v4 2/7] net: stmmac: drop stmmac_fpe_handshake
Date: Tue, 20 Aug 2024 17:38:30 +0800
Message-Id: <4358074eebdfedf4d129ccce40434af5f6e2b3f9.1724145786.git.0x1207@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1724145786.git.0x1207@gmail.com>
References: <cover.1724145786.git.0x1207@gmail.com>
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


