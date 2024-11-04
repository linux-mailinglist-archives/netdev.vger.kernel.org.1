Return-Path: <netdev+bounces-141599-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F4A29BBAFD
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 18:03:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8DEF280639
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 17:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E07071CACFA;
	Mon,  4 Nov 2024 17:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="P/ylVa50"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFC11CD15;
	Mon,  4 Nov 2024 17:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730739781; cv=none; b=bFIONHQQmLOu9knSC5UgFlq6OpbNPjUWI2tn+WpsLt/dY/i7OwIBjcScnZdSe5WqPfQ13RyDD4IpJ3oyP8YNJvy8pwblzqw9drtqUPU7y6dHXAkEn3BKJKjMDE+qeYBQn3ZCUikBUWk0ybE+H5IppzuBgoBmfHMxFr8UnBXCPHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730739781; c=relaxed/simple;
	bh=h0ET1UOrL/Rv2bl967sK/TaJGPwryi3uBWVbrLf1dGo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nswOHJyDO2S3ek4/YTOVqUIbVARUzugsEjmwJ6ztBilr5uh6wvTZoEHquFGRGYcjCrM8yvLYu+2FR6OVY6Oha6hNqhHF5piz+8mlqvOuohobWGbps//kQJSvQzreCS2w1N9XoPy/DYdC1kgGs3jhl0etqDl7qN5QfWBLAnNJC0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=P/ylVa50; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 67A0260003;
	Mon,  4 Nov 2024 17:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1730739778;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/SPSBRQipSII7hd35ejo1FRCOBIsfi2Df67vBJxKStA=;
	b=P/ylVa50a+BLdkHAgE7RjPYnPZ2RVCr9fPAnphAuuCYjYTKraswaYmWf0aDEbPzaYSLzrm
	XsFpX1Fl0SPyWabDsuWUXldUhR8/MIbP3DTaB9Q1cabYNyxOLeKeOwLUmsbcIGXWH1xCwn
	ZhK9tofPBP/dFq5TX9mBsdbyYNAdxVBZ6UczkW6HnnlFmRa56RJZeCPmZHH8qtUtt5RMLI
	2/8BcVWO0ERuUpFB4OHm6NKrj+xIKToRjV5E1IVg2o4b46eFNHSDj6FzsHRoxBjsMI2EnA
	SBX2dSDqxbVKNqRgRnDrd1L9+QB3y5PvPqI2tYPADfiNX8B1Qqsr5P8GHvc9+g==
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
Subject: [PATCH net-next v2 3/9] net: stmmac: Only update the auto-discovered PTP clock features
Date: Mon,  4 Nov 2024 18:02:43 +0100
Message-ID: <20241104170251.2202270-4-maxime.chevallier@bootlin.com>
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

Some DWMAC variants such as dwmac1000 don't support discovering the
number of output pps and auxiliary snapshots. Allow these parameters to
be defined in default ptp_clock_info, and let them be updated only when
the feature discovery yielded a result.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
V2: No changes

 drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
index 41581f516ea9..8ea2b4226234 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
@@ -303,8 +303,14 @@ void stmmac_ptp_register(struct stmmac_priv *priv)
 	if (priv->plat->has_gmac4 && priv->plat->clk_ptp_rate)
 		priv->plat->cdc_error_adj = (2 * NSEC_PER_SEC) / priv->plat->clk_ptp_rate;
 
-	priv->ptp_clock_ops.n_per_out = priv->dma_cap.pps_out_num;
-	priv->ptp_clock_ops.n_ext_ts = priv->dma_cap.aux_snapshot_n;
+	/* Update the ptp clock parameters based on feature discovery, when
+	 * available
+	 */
+	if (priv->dma_cap.pps_out_num)
+		priv->ptp_clock_ops.n_per_out = priv->dma_cap.pps_out_num;
+
+	if (priv->dma_cap.aux_snapshot_n)
+		priv->ptp_clock_ops.n_ext_ts = priv->dma_cap.aux_snapshot_n;
 
 	if (priv->plat->ptp_max_adj)
 		priv->ptp_clock_ops.max_adj = priv->plat->ptp_max_adj;
-- 
2.47.0


