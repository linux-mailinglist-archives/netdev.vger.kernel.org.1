Return-Path: <netdev+bounces-232362-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 678CEC049ED
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 09:08:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C3AB3BB2B3
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 07:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 962BF29D26E;
	Fri, 24 Oct 2025 07:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="xpORE1kS"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B1529B8D3
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 07:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761289664; cv=none; b=cW0b17c65aFpF+wAMoX7EOpDVjGY1Urfhoc/+0AsLL2+h6fa4pXXXleHFbbJMSrGWO/s3f9g5K/5AMz2uRskgq9HGJuaMchc4cY8DwKlAMbByOY2AV3E4J6ylR8XHDuEj2/uZYtze+rq23GHT5bXLF34tDcntN7HvEVWqXm2qtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761289664; c=relaxed/simple;
	bh=EnqhMQ3YabXb6qnZJYvlItzMZDILVJy7UpyAZo1VIXo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MQqyUgagZ5KbDpdLv6LgRuhG9bdUBL6hOSvibET1Q6lV0Vgg4Gavov161O3VyzbangKeaJQsv9f/CcYdBVP082ILOVTbZGPoM/b+q3LW27a70b+JrGVKy1PrzWWfEKG4PBxwjl2H+zhxpibXw/U4uKB3xah9tN64uGFkKhukej4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=xpORE1kS; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 9F8AC1A163A;
	Fri, 24 Oct 2025 07:07:40 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6AB7D60703;
	Fri, 24 Oct 2025 07:07:40 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B8A48102F244A;
	Fri, 24 Oct 2025 09:07:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761289659; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=0YlOsdwhlsQqRvD5FlSOf1VoJU/ilXKcwWly87pRk0g=;
	b=xpORE1kSOYrISctR2B47Fii+8K6j4xEcwXAlsloKZH+zRiQ78d+AA4I2E0T4uAU8qKpsew
	/H4aHE5/IUEghR8BFrwF2LGmymv2ajke/uDFJHff2XXal3TTojsqffWeQABzmfbtiHcUkI
	lVMqOaal3xfGXAU68mvBkeB6mVpS5upmnl9Kz2aDpZMf8Z2+OoSW63sBeHGXHP3+DE9ypz
	xKKT2gMeADz2IQjhPme9EuQ7g2NRqqJxTMVhAg6Ekif8VftVVm+8b4edwJ97oaBh00TKRB
	HboE/z5mc0/WYk8KcfmbXeI6TTRbtYFVZOfuH2JtEvwcL9mjQTfY0COMSDe4rQ==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	=?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 1/2] net: stmmac: Move subsecond increment configuration in dedicated helper
Date: Fri, 24 Oct 2025 09:07:17 +0200
Message-ID: <20251024070720.71174-2-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251024070720.71174-1-maxime.chevallier@bootlin.com>
References: <20251024070720.71174-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

In preparation for fine/coarse support, let's move the subsecond increment
and addend configuration in a dedicated helper.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 48 +++++++++++--------
 1 file changed, 28 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 9fa3c221a0c3..8922c660cefa 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -464,6 +464,33 @@ static void stmmac_get_rx_hwtstamp(struct stmmac_priv *priv, struct dma_desc *p,
 	}
 }
 
+static void stmmac_update_subsecond_increment(struct stmmac_priv *priv)
+{
+	bool xmac = dwmac_is_xmac(priv->plat->core_type);
+	u32 sec_inc = 0;
+	u64 temp = 0;
+
+	stmmac_config_hw_tstamping(priv, priv->ptpaddr, priv->systime_flags);
+
+	/* program Sub Second Increment reg */
+	stmmac_config_sub_second_increment(priv, priv->ptpaddr,
+					   priv->plat->clk_ptp_rate,
+					   xmac, &sec_inc);
+	temp = div_u64(1000000000ULL, sec_inc);
+
+	/* Store sub second increment for later use */
+	priv->sub_second_inc = sec_inc;
+
+	/* calculate default added value:
+	 * formula is :
+	 * addend = (2^32)/freq_div_ratio;
+	 * where, freq_div_ratio = 1e9ns/sec_inc
+	 */
+	temp = (u64)(temp << 32);
+	priv->default_addend = div_u64(temp, priv->plat->clk_ptp_rate);
+	stmmac_config_addend(priv, priv->ptpaddr, priv->default_addend);
+}
+
 /**
  *  stmmac_hwtstamp_set - control hardware timestamping.
  *  @dev: device pointer.
@@ -697,10 +724,7 @@ static int stmmac_hwtstamp_get(struct net_device *dev,
 static int stmmac_init_tstamp_counter(struct stmmac_priv *priv,
 				      u32 systime_flags)
 {
-	bool xmac = dwmac_is_xmac(priv->plat->core_type);
 	struct timespec64 now;
-	u32 sec_inc = 0;
-	u64 temp = 0;
 
 	if (!priv->plat->clk_ptp_rate) {
 		netdev_err(priv->dev, "Invalid PTP clock rate");
@@ -710,23 +734,7 @@ static int stmmac_init_tstamp_counter(struct stmmac_priv *priv,
 	stmmac_config_hw_tstamping(priv, priv->ptpaddr, systime_flags);
 	priv->systime_flags = systime_flags;
 
-	/* program Sub Second Increment reg */
-	stmmac_config_sub_second_increment(priv, priv->ptpaddr,
-					   priv->plat->clk_ptp_rate,
-					   xmac, &sec_inc);
-	temp = div_u64(1000000000ULL, sec_inc);
-
-	/* Store sub second increment for later use */
-	priv->sub_second_inc = sec_inc;
-
-	/* calculate default added value:
-	 * formula is :
-	 * addend = (2^32)/freq_div_ratio;
-	 * where, freq_div_ratio = 1e9ns/sec_inc
-	 */
-	temp = (u64)(temp << 32);
-	priv->default_addend = div_u64(temp, priv->plat->clk_ptp_rate);
-	stmmac_config_addend(priv, priv->ptpaddr, priv->default_addend);
+	stmmac_update_subsecond_increment(priv);
 
 	/* initialize system time */
 	ktime_get_real_ts64(&now);
-- 
2.49.0


