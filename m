Return-Path: <netdev+bounces-141600-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 712049BBAFE
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 18:03:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 317C2281053
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 17:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 048831CB312;
	Mon,  4 Nov 2024 17:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jY2BFzvL"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF01B1C243C;
	Mon,  4 Nov 2024 17:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730739781; cv=none; b=E7J46a9+lhH9LDQkc3NriEURf1phxAtfYltDGu4TWCBYOTNXyifG7+wF7OelMWujjja184dt42hZRTqOFvMfyVK0Znb2CEEBCvGzaGPff1Hf5zn4lduHRhFuvapu7v8biAubR4euCOdM5d8xNXnMOxyERJ9bS1naT4mszkdbKZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730739781; c=relaxed/simple;
	bh=MMFxpJZFvVilpm803AibMkyMpy76A7o8br/xaTlUSvs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BALuTxTJeuxqBNjQm4aAZhvkVyz/vxVpzahDWuzQee37/YGkeN+bVGugD139PghSAf0Bg4Qdl9pF8Q9HbA44rSvIB2UZgEwC7MNpBDz6gVC0ydsLNZlqFoK362Tso9oNYketRW3lo7dI3xmY/hZlegsiKB7cBPujwtkXDWBcyIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jY2BFzvL; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7A18160009;
	Mon,  4 Nov 2024 17:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1730739777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/Q0nQf1p3aEQdaIekpf69KA9b+oSlJsiJVdZh+xBY4k=;
	b=jY2BFzvLc1owNblIdY6rrlkicCZj0lfJRmf0oZZnrjAQuWDhfXHNumDYHtXAZtTxcK3sYH
	uuko9DYYI03drvyKUAWILR3Z93+fXKYxo6hsEwGFAD0/t5WpUUorPoEZujOrmuEDGhLbRE
	WCFww3F/ssEgoQUVW2aHHz6Co8Pvi1L0b9J8P+JNAz+DnIeFOWDbd37RL5U4WdjYZzcjZs
	yE2bpFG5Zy6j3r8sFaqccVjJqoKmtTCdDxhv3dule+U/jeMzWyHFAB5M9VqkL4JYjRMSWU
	wtv6DI4mdU0yOpPquKw1AHx2JrRee+SNJEWEYcwDhuqUIKoAV14cjb2YDS7fGQ==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 2/9] net: stmmac: Use per-hw ptp clock ops
Date: Mon,  4 Nov 2024 18:02:42 +0100
Message-ID: <20241104170251.2202270-3-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241104170251.2202270-1-maxime.chevallier@bootlin.com>
References: <20241104170251.2202270-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: maxime.chevallier@bootlin.com

The auxiliary snapshot configuration was found to differ depending on
the dwmac version. To prepare supporting this, allow specifying the
ptp_clock_info ops in the hwif array

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
V2: No changes

 drivers/net/ethernet/stmicro/stmmac/common.h     |  2 ++
 drivers/net/ethernet/stmicro/stmmac/hwif.c       | 11 +++++++++++
 drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c |  4 +---
 3 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/common.h b/drivers/net/ethernet/stmicro/stmmac/common.h
index 684489156dce..4a0a1708c391 100644
--- a/drivers/net/ethernet/stmicro/stmmac/common.h
+++ b/drivers/net/ethernet/stmicro/stmmac/common.h
@@ -551,6 +551,8 @@ struct mac_device_info;
 extern const struct stmmac_hwtimestamp stmmac_ptp;
 extern const struct stmmac_mode_ops dwmac4_ring_mode_ops;
 
+extern const struct ptp_clock_info stmmac_ptp_clock_ops;
+
 struct mac_link {
 	u32 caps;
 	u32 speed_mask;
diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.c b/drivers/net/ethernet/stmicro/stmmac/hwif.c
index 88cce28b2f98..9b6d817e8f1e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.c
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.c
@@ -112,6 +112,7 @@ static const struct stmmac_hwif_entry {
 	const void *dma;
 	const void *mac;
 	const void *hwtimestamp;
+	const void *ptp;
 	const void *mode;
 	const void *tc;
 	const void *mmc;
@@ -133,6 +134,7 @@ static const struct stmmac_hwif_entry {
 		.dma = &dwmac100_dma_ops,
 		.mac = &dwmac100_ops,
 		.hwtimestamp = &stmmac_ptp,
+		.ptp = &stmmac_ptp_clock_ops,
 		.mode = NULL,
 		.tc = NULL,
 		.mmc = &dwmac_mmc_ops,
@@ -151,6 +153,7 @@ static const struct stmmac_hwif_entry {
 		.dma = &dwmac1000_dma_ops,
 		.mac = &dwmac1000_ops,
 		.hwtimestamp = &stmmac_ptp,
+		.ptp = &stmmac_ptp_clock_ops,
 		.mode = NULL,
 		.tc = NULL,
 		.mmc = &dwmac_mmc_ops,
@@ -170,6 +173,7 @@ static const struct stmmac_hwif_entry {
 		.dma = &dwmac4_dma_ops,
 		.mac = &dwmac4_ops,
 		.hwtimestamp = &stmmac_ptp,
+		.ptp = &stmmac_ptp_clock_ops,
 		.mode = NULL,
 		.tc = &dwmac4_tc_ops,
 		.mmc = &dwmac_mmc_ops,
@@ -190,6 +194,7 @@ static const struct stmmac_hwif_entry {
 		.dma = &dwmac4_dma_ops,
 		.mac = &dwmac410_ops,
 		.hwtimestamp = &stmmac_ptp,
+		.ptp = &stmmac_ptp_clock_ops,
 		.mode = &dwmac4_ring_mode_ops,
 		.tc = &dwmac510_tc_ops,
 		.mmc = &dwmac_mmc_ops,
@@ -210,6 +215,7 @@ static const struct stmmac_hwif_entry {
 		.dma = &dwmac410_dma_ops,
 		.mac = &dwmac410_ops,
 		.hwtimestamp = &stmmac_ptp,
+		.ptp = &stmmac_ptp_clock_ops,
 		.mode = &dwmac4_ring_mode_ops,
 		.tc = &dwmac510_tc_ops,
 		.mmc = &dwmac_mmc_ops,
@@ -230,6 +236,7 @@ static const struct stmmac_hwif_entry {
 		.dma = &dwmac410_dma_ops,
 		.mac = &dwmac510_ops,
 		.hwtimestamp = &stmmac_ptp,
+		.ptp = &stmmac_ptp_clock_ops,
 		.mode = &dwmac4_ring_mode_ops,
 		.tc = &dwmac510_tc_ops,
 		.mmc = &dwmac_mmc_ops,
@@ -251,6 +258,7 @@ static const struct stmmac_hwif_entry {
 		.dma = &dwxgmac210_dma_ops,
 		.mac = &dwxgmac210_ops,
 		.hwtimestamp = &stmmac_ptp,
+		.ptp = &stmmac_ptp_clock_ops,
 		.mode = NULL,
 		.tc = &dwxgmac_tc_ops,
 		.mmc = &dwxgmac_mmc_ops,
@@ -272,6 +280,7 @@ static const struct stmmac_hwif_entry {
 		.dma = &dwxgmac210_dma_ops,
 		.mac = &dwxlgmac2_ops,
 		.hwtimestamp = &stmmac_ptp,
+		.ptp = &stmmac_ptp_clock_ops,
 		.mode = NULL,
 		.tc = &dwxgmac_tc_ops,
 		.mmc = &dwxgmac_mmc_ops,
@@ -355,6 +364,8 @@ int stmmac_hwif_init(struct stmmac_priv *priv)
 		priv->hw = mac;
 		priv->ptpaddr = priv->ioaddr + entry->regs.ptp_off;
 		priv->mmcaddr = priv->ioaddr + entry->regs.mmc_off;
+		memcpy(&priv->ptp_clock_ops, entry->ptp,
+		       sizeof(struct ptp_clock_info));
 		if (entry->est)
 			priv->estaddr = priv->ioaddr + entry->regs.est_off;
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
index 11ab1d6b916a..41581f516ea9 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
@@ -265,7 +265,7 @@ static int stmmac_getcrosststamp(struct ptp_clock_info *ptp,
 }
 
 /* structure describing a PTP hardware clock */
-static struct ptp_clock_info stmmac_ptp_clock_ops = {
+const struct ptp_clock_info stmmac_ptp_clock_ops = {
 	.owner = THIS_MODULE,
 	.name = "stmmac ptp",
 	.max_adj = 62500000,
@@ -303,8 +303,6 @@ void stmmac_ptp_register(struct stmmac_priv *priv)
 	if (priv->plat->has_gmac4 && priv->plat->clk_ptp_rate)
 		priv->plat->cdc_error_adj = (2 * NSEC_PER_SEC) / priv->plat->clk_ptp_rate;
 
-	priv->ptp_clock_ops = stmmac_ptp_clock_ops;
-
 	priv->ptp_clock_ops.n_per_out = priv->dma_cap.pps_out_num;
 	priv->ptp_clock_ops.n_ext_ts = priv->dma_cap.aux_snapshot_n;
 
-- 
2.47.0


