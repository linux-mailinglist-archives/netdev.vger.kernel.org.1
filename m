Return-Path: <netdev+bounces-139892-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 661FF9B48B8
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 12:54:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF049B22845
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 11:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A84205AC1;
	Tue, 29 Oct 2024 11:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Uj/zZ6Rl"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D441E0DF4;
	Tue, 29 Oct 2024 11:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730202874; cv=none; b=BGSSEBacANCw5NTLba9lKO6Lnp0BiRdE6Y2tHCjFJMlXbnI6cImJwVxiP7ZMgO6UBxjjFQQMO/gQu2taRmRMLNj67/wM0KmMAf+9mCUf0vASjuyxMaqKsfy9QPw3FT0NbZknOwAjIfbE9kMo+1PU741S5CuvRsejCsTTY6iGLNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730202874; c=relaxed/simple;
	bh=RFedb7d1yVzyHiGwdyMHJM8bG3GO/6BXjfejl8KlpAg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LGhv5K59i3vnAF9hMug7ZiL+GDVlMEDLN8QGRkcTjvIE/+kzQUtSUEFhJ9REfry1t0E+qxVaPuXTbI1N38E2kw9e97wNpzy2W5663M6Ev5aUpnnCILiWJLE/KiERWOdLtyGCcQ02NqAg6VkmkoZNgoBtLFmGhMcvTHVVa7yfcdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Uj/zZ6Rl; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D65541C000A;
	Tue, 29 Oct 2024 11:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1730202863;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eGCWRSOQMmjS9ZFY7AhKJ0VNqkvKkp9FxTzYgROnlPc=;
	b=Uj/zZ6Rl3V4q/IJ6WB/HHZutLTeFS1axCbwn50wEuAeNuxJNuViSCjiCNRUu6k+FY3XAM6
	BvVqKw1NqcEjRtLhEUaaV17nma4xx26/wvwFuDzOuc8W5VaiOImCbY9xxuM1Q1h2dAvxCD
	4bqyKXDedHQG67rVYSFgnxrtERGXWXUeI3aWYIBRxHdNUP9wIaWgdS5vN9MHmhv4g2H7vv
	hnLM66SRFtFVFkoAOnmLsSEnCe6qWzFisCQfO2we6xv9mptZidTcCAUh5KvpoiSVQh6Dwd
	TcVyF3pkhh/FRFNxY3OfkTPoZSGfSXcm+jklgGIhtUVglZG5rQFMOmJ0lIeQAQ==
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
Subject: [PATCH net-next 1/7] net: stmmac: Don't modify the global ptp ops directly
Date: Tue, 29 Oct 2024 12:54:09 +0100
Message-ID: <20241029115419.1160201-2-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241029115419.1160201-1-maxime.chevallier@bootlin.com>
References: <20241029115419.1160201-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: maxime.chevallier@bootlin.com

The stmmac_ptp_clock_ops are copied into the stmmac_priv structure
before being registered to the PTP core. Some adjustments are made prior
to that, such as the number of snapshots or max adjustment parameters.

Instead of modifying the global definition, then copying into the local
private data, let's first copy then modify the local parameters.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
index a6b1de9a251d..11ab1d6b916a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
@@ -298,20 +298,21 @@ void stmmac_ptp_register(struct stmmac_priv *priv)
 		priv->pps[i].available = true;
 	}
 
-	if (priv->plat->ptp_max_adj)
-		stmmac_ptp_clock_ops.max_adj = priv->plat->ptp_max_adj;
-
 	/* Calculate the clock domain crossing (CDC) error if necessary */
 	priv->plat->cdc_error_adj = 0;
 	if (priv->plat->has_gmac4 && priv->plat->clk_ptp_rate)
 		priv->plat->cdc_error_adj = (2 * NSEC_PER_SEC) / priv->plat->clk_ptp_rate;
 
-	stmmac_ptp_clock_ops.n_per_out = priv->dma_cap.pps_out_num;
-	stmmac_ptp_clock_ops.n_ext_ts = priv->dma_cap.aux_snapshot_n;
+	priv->ptp_clock_ops = stmmac_ptp_clock_ops;
+
+	priv->ptp_clock_ops.n_per_out = priv->dma_cap.pps_out_num;
+	priv->ptp_clock_ops.n_ext_ts = priv->dma_cap.aux_snapshot_n;
+
+	if (priv->plat->ptp_max_adj)
+		priv->ptp_clock_ops.max_adj = priv->plat->ptp_max_adj;
 
 	rwlock_init(&priv->ptp_lock);
 	mutex_init(&priv->aux_ts_lock);
-	priv->ptp_clock_ops = stmmac_ptp_clock_ops;
 
 	priv->ptp_clock = ptp_clock_register(&priv->ptp_clock_ops,
 					     priv->device);
-- 
2.47.0


