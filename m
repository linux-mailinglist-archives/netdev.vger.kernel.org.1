Return-Path: <netdev+bounces-142272-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E63B9BE19C
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 10:04:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 288A3284D0F
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 09:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C521D9587;
	Wed,  6 Nov 2024 09:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="TrIjxgdf"
X-Original-To: netdev@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12DC1D61A1;
	Wed,  6 Nov 2024 09:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730883821; cv=none; b=c1HO5AmdvDahkiBYVt1mIxy8brN+VfRTbjQuzhaT5vmEJcuXfZ1pAjpQO/Ngt3p72U/N+HpEBNEbCdiWZpNpW+OS8rFZ1TfDgxDD+1ptYc86HS+Jx8EI8B0ae6AVCDdw7wYiHhFJhiR5vC99ZOFyHIV46buqkBtI4wl0yTs1Fng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730883821; c=relaxed/simple;
	bh=GtHcLeBsn3O23uFyOkN7l0rYCQD8LcKmQjIeNqm63oI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=inxYNO+KheymtVVmiDpPgJcZqybfhh/bisSORwDx0vrwSOOyzbNpd9klFuYuCiRhMlTGDQG7kPRmhJWDJFZXGksFeoPA5feWFzSIzgPBj38POmCY6aCtbeiClp5JAGI/AHEW00aRHf4f7IC6JcNmCPZqm8R6BjwXAU4IO3e8Wnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=TrIjxgdf; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5B52EC000B;
	Wed,  6 Nov 2024 09:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1730883817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6X8ox1zyxVxHxIdKjT3dUrrJCv68QyJRIj6PRTEmhEM=;
	b=TrIjxgdflkgz3StI3vrBOiff2vsFdviG4J11hSA1syO5cxtBBdPsPnbEYfd5fhmx6vEe76
	ua27GaR13dBTfbZVknjlja1+LkexHmytS9EoCZQfQtU58gqBVOuDWeF3UszHBfh2Z34iuR
	YRKKXyx/1UP8Hyxep3RIvBcDmjMsIKkkCYVWSbW8HtVjHOGya/3c5KCeaA8p0yoPOa69K7
	WP3bQz/t7GTI5VmNf6WURiKVCgkWm4t2ECVtf/1rG4skCzsEmIonpbaT5HAzQprttQQnTl
	ilWJ4tPIuRkWP45VdMxWIJVEPZ43qh7BC4JQisbSpyUCXPCSMpAkqXG4hFJZZg==
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
Subject: [PATCH net-next v3 2/9] net: stmmac: Use per-hw ptp clock ops
Date: Wed,  6 Nov 2024 10:03:23 +0100
Message-ID: <20241106090331.56519-3-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241106090331.56519-1-maxime.chevallier@bootlin.com>
References: <20241106090331.56519-1-maxime.chevallier@bootlin.com>
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
index cfc50289aed6..47458cbcbc94 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.c
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.c
@@ -113,6 +113,7 @@ static const struct stmmac_hwif_entry {
 	const void *dma;
 	const void *mac;
 	const void *hwtimestamp;
+	const void *ptp;
 	const void *mode;
 	const void *tc;
 	const void *mmc;
@@ -134,6 +135,7 @@ static const struct stmmac_hwif_entry {
 		.dma = &dwmac100_dma_ops,
 		.mac = &dwmac100_ops,
 		.hwtimestamp = &stmmac_ptp,
+		.ptp = &stmmac_ptp_clock_ops,
 		.mode = NULL,
 		.tc = NULL,
 		.mmc = &dwmac_mmc_ops,
@@ -152,6 +154,7 @@ static const struct stmmac_hwif_entry {
 		.dma = &dwmac1000_dma_ops,
 		.mac = &dwmac1000_ops,
 		.hwtimestamp = &stmmac_ptp,
+		.ptp = &stmmac_ptp_clock_ops,
 		.mode = NULL,
 		.tc = NULL,
 		.mmc = &dwmac_mmc_ops,
@@ -171,6 +174,7 @@ static const struct stmmac_hwif_entry {
 		.dma = &dwmac4_dma_ops,
 		.mac = &dwmac4_ops,
 		.hwtimestamp = &stmmac_ptp,
+		.ptp = &stmmac_ptp_clock_ops,
 		.mode = NULL,
 		.tc = &dwmac4_tc_ops,
 		.mmc = &dwmac_mmc_ops,
@@ -192,6 +196,7 @@ static const struct stmmac_hwif_entry {
 		.dma = &dwmac4_dma_ops,
 		.mac = &dwmac410_ops,
 		.hwtimestamp = &stmmac_ptp,
+		.ptp = &stmmac_ptp_clock_ops,
 		.mode = &dwmac4_ring_mode_ops,
 		.tc = &dwmac510_tc_ops,
 		.mmc = &dwmac_mmc_ops,
@@ -213,6 +218,7 @@ static const struct stmmac_hwif_entry {
 		.dma = &dwmac410_dma_ops,
 		.mac = &dwmac410_ops,
 		.hwtimestamp = &stmmac_ptp,
+		.ptp = &stmmac_ptp_clock_ops,
 		.mode = &dwmac4_ring_mode_ops,
 		.tc = &dwmac510_tc_ops,
 		.mmc = &dwmac_mmc_ops,
@@ -234,6 +240,7 @@ static const struct stmmac_hwif_entry {
 		.dma = &dwmac410_dma_ops,
 		.mac = &dwmac510_ops,
 		.hwtimestamp = &stmmac_ptp,
+		.ptp = &stmmac_ptp_clock_ops,
 		.mode = &dwmac4_ring_mode_ops,
 		.tc = &dwmac510_tc_ops,
 		.mmc = &dwmac_mmc_ops,
@@ -256,6 +263,7 @@ static const struct stmmac_hwif_entry {
 		.dma = &dwxgmac210_dma_ops,
 		.mac = &dwxgmac210_ops,
 		.hwtimestamp = &stmmac_ptp,
+		.ptp = &stmmac_ptp_clock_ops,
 		.mode = NULL,
 		.tc = &dwxgmac_tc_ops,
 		.mmc = &dwxgmac_mmc_ops,
@@ -278,6 +286,7 @@ static const struct stmmac_hwif_entry {
 		.dma = &dwxgmac210_dma_ops,
 		.mac = &dwxlgmac2_ops,
 		.hwtimestamp = &stmmac_ptp,
+		.ptp = &stmmac_ptp_clock_ops,
 		.mode = NULL,
 		.tc = &dwxgmac_tc_ops,
 		.mmc = &dwxgmac_mmc_ops,
@@ -362,6 +371,8 @@ int stmmac_hwif_init(struct stmmac_priv *priv)
 		priv->fpe_cfg.reg = entry->regs.fpe_reg;
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


