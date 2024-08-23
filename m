Return-Path: <netdev+bounces-121310-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E681295CAF3
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 12:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69ECF1F2333C
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 10:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3D46187FE2;
	Fri, 23 Aug 2024 10:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YvUXJFp6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B32F187877;
	Fri, 23 Aug 2024 10:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724410237; cv=none; b=tmi4JlwyyPNiwuSa3TAIKRbeGpFzoarPdzcCsZv6tQSsDms/H/p/R07xg3nCD0MWBrvWHEZ6sbErrxOMHlfkH3t5/6J7qgS4ctRVK1OlP50VhsWKX1L6HXZiGhK1KdkGG7RFfCEB1nvC6wG6sTlTAM5FxiTPzU29Fg7PGqMthtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724410237; c=relaxed/simple;
	bh=Uf03NK+TcTTM3jFMPZZRi2Aq+HZ0s1AWpNTiYA/4EUU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K5g247T952rj/avx5jBV0FzLG1CfLzVau+IHYNUgjM2YIuegtjpaL2sjH72ZVvWUm2WDyQ1jgnMymq6XK5S5xEKHWRFIlWd/dOUtxdfU46EXhyEHefoxPOpLt314SjYONn6vzDc68bBih783QTST99h/NU7LCK84G0dTSBjH7AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YvUXJFp6; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2d3c0d587e4so1319698a91.2;
        Fri, 23 Aug 2024 03:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724410235; x=1725015035; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=awdxA94+EDwJxMaDIv2LrPwLHdX9C7ivLS6VUmJAIug=;
        b=YvUXJFp6FjoNsWTmM3S22ZT772PBaszLOKlj4U6vHahZlaHe2kjZcxWvYsEJW7ZYNU
         bNRHrixHkmqsZDHqroojqtWF92PUJFHhzNjl+Bs5W8R801AguVDdwZ4Dz99Eek1uR1Cu
         Vzwf7glnWpDZGco4LgOxXQww2qUK7WfHkHI8ZcppEYtkjcDzht5Wd1hMBdoLsBMgxdyv
         SozPgQpZuDvebQXWUI6Jg3wgkV0Ya9jY8VT/Cyze+R4teU9xmwT7LYkhvBAazugiIG3t
         pHiZYJlcztpDxKHjUCvCp6z1tR8C/IAVR26w8ijD9f+xw2eyaFFdSvvKPfReQYDpxMPu
         DH0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724410235; x=1725015035;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=awdxA94+EDwJxMaDIv2LrPwLHdX9C7ivLS6VUmJAIug=;
        b=HX9FZCzhPxxx5GTkvmksI1oAibDzTIN6QE115YIq0QOSCLtyIOrf8AsWWoZqjK4EwM
         4+07cTOS/mFyCjv4dxxw4IHBOSH+amrTldkpjmHMcL7L4wMnK00mAFOaasP935RziGm0
         gIbqVxzvmZayalTjbRZ2P87YhlBBP+DFPz1LCV1Cmdw7kOj67GjL5gmc52N1z/4RRkN8
         a/Ij5Wvdgyf9Wln/9Zfaut0m7nr/d8ssPgF0qCXjjUbszcvh8R7hdeKOmA2FtDSG7ELi
         p+4VIfJdlQEWKhEQ7uzJbcB/dSa/hazFZjpILcF4XeL+/5VgrZU9X0HKDnUOf6ep+7R7
         pAVA==
X-Forwarded-Encrypted: i=1; AJvYcCVTFegGkEVTxBR72ShXZtmT2QcGHMiZ5J/7V6/I4DC4uhSLETxeqxBKcxRFwtaw1Svrc5OE/xsgHCynVGs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNZCyhJ3qKuwrVBt/DNu7WOzrZve5x9VHbakhYV+A3m2CkY95K
	Z++5b8I3FS4L7bqpvvI5vQvxXF2lSISXG3XrxG3+DBJXl7zLAsGZ
X-Google-Smtp-Source: AGHT+IH4kxTuSKLf4y16h4uAuWw4Yl1Q/hYlaVuMkg66SCkTUsl9iUC6V/GkbMkYFKLSZZvu6nVf0A==
X-Received: by 2002:a17:90a:4611:b0:2d3:ce76:4af2 with SMTP id 98e67ed59e1d1-2d646bd8d39mr1735993a91.18.1724410235374;
        Fri, 23 Aug 2024 03:50:35 -0700 (PDT)
Received: from localhost.localdomain ([129.146.253.192])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2d5eb8d235esm6074344a91.6.2024.08.23.03.50.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 03:50:35 -0700 (PDT)
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
	xfr@outlook.com,
	Furong Xu <0x1207@gmail.com>
Subject: [PATCH net-next v6 2/7] net: stmmac: drop stmmac_fpe_handshake
Date: Fri, 23 Aug 2024 18:50:09 +0800
Message-Id: <9cd8ebf4b6c110b223219f15d024fe0be301a498.1724409007.git.0x1207@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1724409007.git.0x1207@gmail.com>
References: <cover.1724409007.git.0x1207@gmail.com>
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


