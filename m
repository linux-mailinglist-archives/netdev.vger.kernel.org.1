Return-Path: <netdev+bounces-229298-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 47AACBDA588
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 17:26:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AC2EC354893
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 15:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A923016FD;
	Tue, 14 Oct 2025 15:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="eOXbD9sD"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0C2301006
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 15:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760455551; cv=none; b=XEi+6pxjgRg2g6Whu1MCH+P3x01zlJftC0zziPyqAd2boeNeVapXo6efQVh4noGPH45pr2paRgyR/qjs/YMeOvQPIqn8OBQ9cxcxFh5UsClJWRbW1InM/hj+MvGhlW5UwFuvJJxeeS12oJdGJ/fyiZK7zKQOUEDJdAFMhHjdSOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760455551; c=relaxed/simple;
	bh=rUUnrH/sSuEDfrtW6ug/Kmv3e2YKbWh1q7RDvw2MkE0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZC8vVVMtlOTBOCCJHhfQXXR9K2RCqHDBcDXXrAjw2/KImJGbRJwOU1l/o20s3RdlT3dqtRHM6mAFu0uQui5g9+uPrQ1TaDOxYrLYcsAFvz0QCHFna9Qq8HJcO1Nt3Db3nXtcaPMDjbft0uSaOizV1Hca4YbPzTsXfZAqeaaDvJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=eOXbD9sD; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 4DCA41A1381;
	Tue, 14 Oct 2025 15:25:48 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 234B3606EC;
	Tue, 14 Oct 2025 15:25:48 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5E210102F22A4;
	Tue, 14 Oct 2025 17:25:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760455547; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=pc+arER1ZhOJQit1tkbjRVmQdT2HfO4hl2eG12FrhwE=;
	b=eOXbD9sDXQw31kaUI+I0rWwhN+0FcVJLuwMC7b2ke4y78MDx/bWgBaKMgz7RH6rbaZJWZ7
	FQc+qnq72IEAixUtJAf1Ciz1TxmYMimDhTTzeY1bZPNb8W44WQxILhrai91QwJSpEulyjg
	oC2pWRaj5onOLWOz0lh0hBIWTkOg2IbXStDRZ++xQnB9T5IvKK6Kat7QZe0D3j4FOeNPIw
	bdTd50yDNQVWJ8/6I6bjYXbnS5IeUCp2rgd0l0CRlMtQaKzagvrX7b7tl+cI6FhgVmc7bQ
	Ex469KkNPI0A2xSQT8f3i4hRYf4p08s3mhOIcnOiIOSUboh7NZsbzFN8zerwZw==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Tue, 14 Oct 2025 17:25:05 +0200
Subject: [PATCH net-next 04/15] net: macb: Remove local variables clk_init
 and init in macb_probe()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251014-macb-cleanup-v1-4-31cd266e22cd@bootlin.com>
References: <20251014-macb-cleanup-v1-0-31cd266e22cd@bootlin.com>
In-Reply-To: <20251014-macb-cleanup-v1-0-31cd266e22cd@bootlin.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, 
 =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 Sean Anderson <sean.anderson@linux.dev>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

Remove local variables clk_init and init. Those function pointers are
always equivalent to macb_config->clk_init and macb_config->init.

Reviewed-by: Sean Anderson <sean.anderson@linux.dev>
Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index ca2386b8347371810845290f6a7177a326fda4e7..dad1188ef9d87fc3846590032995223174177e89 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -5424,10 +5424,6 @@ static const struct macb_config default_gem_config = {
 static int macb_probe(struct platform_device *pdev)
 {
 	const struct macb_config *macb_config = &default_gem_config;
-	int (*clk_init)(struct platform_device *, struct clk **,
-			struct clk **, struct clk **,  struct clk **,
-			struct clk **) = macb_config->clk_init;
-	int (*init)(struct platform_device *) = macb_config->init;
 	struct device_node *np = pdev->dev.of_node;
 	struct clk *pclk, *hclk = NULL, *tx_clk = NULL, *rx_clk = NULL;
 	struct clk *tsu_clk = NULL;
@@ -5449,14 +5445,11 @@ static int macb_probe(struct platform_device *pdev)
 		const struct of_device_id *match;
 
 		match = of_match_node(macb_dt_ids, np);
-		if (match && match->data) {
+		if (match && match->data)
 			macb_config = match->data;
-			clk_init = macb_config->clk_init;
-			init = macb_config->init;
-		}
 	}
 
-	err = clk_init(pdev, &pclk, &hclk, &tx_clk, &rx_clk, &tsu_clk);
+	err = macb_config->clk_init(pdev, &pclk, &hclk, &tx_clk, &rx_clk, &tsu_clk);
 	if (err)
 		return err;
 
@@ -5594,7 +5587,7 @@ static int macb_probe(struct platform_device *pdev)
 		bp->phy_interface = interface;
 
 	/* IP specific init */
-	err = init(pdev);
+	err = macb_config->init(pdev);
 	if (err)
 		goto err_out_free_netdev;
 

-- 
2.51.0


