Return-Path: <netdev+bounces-142273-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF6619BE19F
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 10:04:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77CBF2825D0
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 09:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9B1C1D9688;
	Wed,  6 Nov 2024 09:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="CD8znPWu"
X-Original-To: netdev@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92541D6DB4;
	Wed,  6 Nov 2024 09:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730883821; cv=none; b=YUyVlHqNLi8UDikYu6rUTa7JHXr/9gtx8wNpIVAtgnx2+KA6Ikw0xtr+XGviqXP3Z90ThZKKFiMgRV3M6eDFhzP6vh5rm/m0mLTMGs3j73WreQn1vn2R8RHf8heBNacxL3rlm5d/OiQElmRyrpqNNWKUv+QWOH4jAx/a3Yfknlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730883821; c=relaxed/simple;
	bh=Rb/YdaGhYsLS2sFxamiAfxpvrN+cLnkLpEBed7xX1ac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fpSV8PzYOzD2RMxlczgCZiCPCHZC+Q53/R5ufEjHCZJpy4hUBSrIrrgrfmlc3xAS26OAehVX0ItPaAU0iEqpz/kIEcooHfhGpUh/HoHmw5D9CyBrge0/PGEaT5R6GguiNnHVDnHdmAnXxKvqiLyL0coRKwwYrci0vJchg0KeiQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=CD8znPWu; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3F107C000F;
	Wed,  6 Nov 2024 09:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1730883818;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NkGxMlPDNP8jSIw5T0tZvfBvg6tLoLPlBAwO+v2kSjk=;
	b=CD8znPWuyklEx5hX2MW1sCNG4NJxsDPL3l3qOm2dfkRMd2qpyAKOZncIzrCt/sIcl1kwNf
	vQXtWNilwUZkDeO20MqK1dGat5MCvm83zpOeKUGP/vDVZ8PyydviSjZBix3WxcMhQQ1bW3
	v6ua8iNs5TH+vIoUEFJvUAzJRkRR2OY/NtoZ/hP7e22Xv5rm6pdwXJVSEAoXHOV9C+Rrl8
	FVC4Eo4WRs92PK6bf9M668BcCa91mpQeHnxpiQiKbrQnL3OYNQLvUF9SV9vXOy4zkDsUXg
	v0DP9L5GtWOPYYyXNmwe1HiXnijcM4oiXmRUG3bXV1uFiACkoByiS3pP6yvPEA==
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
Subject: [PATCH net-next v3 3/9] net: stmmac: Only update the auto-discovered PTP clock features
Date: Wed,  6 Nov 2024 10:03:24 +0100
Message-ID: <20241106090331.56519-4-maxime.chevallier@bootlin.com>
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

Some DWMAC variants such as dwmac1000 don't support discovering the
number of output pps and auxiliary snapshots. Allow these parameters to
be defined in default ptp_clock_info, and let them be updated only when
the feature discovery yielded a result.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
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


