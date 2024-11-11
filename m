Return-Path: <netdev+bounces-143747-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D799C3F1B
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 14:03:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4542F1C215D9
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 13:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C311719ADBF;
	Mon, 11 Nov 2024 13:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="QTFaz9NF"
X-Original-To: netdev@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5D619CC29;
	Mon, 11 Nov 2024 13:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731330067; cv=none; b=iSuk5SihirfoHWQ67Mo08lH5nYShv8BaXoqmw8bxg1/fg1xUkmvjXadrltWUCJcLCZ0es5q+qkX5ZoUJvVjQ9jM9toDVh4W/WFNBs/8MhG+c6dGFiWVjwOHOQOso3+mWc7yXV1LrSLNHNhhZSjie2q1wbVzH4eJ3h1pfg/i8Osg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731330067; c=relaxed/simple;
	bh=+9pyBbAd9XVZulKfecaIB64FBMPOg1uiqLEt55AJBjk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=DFedXlNZnFuov58r2S+QA9JUFAoG5rmFHt+UWrcsOGHLUC4NFbp1Y/02UyY84VXf0WiKMLdy5/SFjR65yf2aP5JKUiFWhuPwbO3+6xkvpE5tfgAuZjvwPuyzB+jjddkqryCyGNLDed2ZnVkdenetGX4hcKa2H5V2urxzgyNvZXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=QTFaz9NF; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from ldvnode.intra.ispras.ru (unknown [10.10.2.153])
	by mail.ispras.ru (Postfix) with ESMTPSA id 712E140B2287;
	Mon, 11 Nov 2024 13:01:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 712E140B2287
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1731330060;
	bh=LoDFg+BU0HIQ1tlmc6quFrKIJzeXNVPGLXuX0Js0k1k=;
	h=From:To:Cc:Subject:Date:From;
	b=QTFaz9NF4hXmf7LBTvZ2meQdmeUgnJSFQZnoC8H+TJWclm7XXWDHNULJOHOU2CDy8
	 nS7sJP616ASKWNrnaJJxK+DbG9tgkeS92JDplwxw9ZFRqMxhbnzxclMaNoeidIZGs2
	 O5tjBQ8h0Spg4ZADdEIGWX4gPM8Ck4QBGLovEfrw=
From: Vitalii Mordan <mordan@ispras.ru>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: Vitalii Mordan <mordan@ispras.ru>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Fedor Pchelkin <pchelkin@ispras.ru>,
	Alexey Khoroshilov <khoroshilov@ispras.ru>,
	Vadim Mutilin <mutilin@ispras.ru>
Subject: [PATCH net-next v2] stmmac: dwmac-intel-plat: remove redundant dwmac->data check in probe
Date: Mon, 11 Nov 2024 16:00:47 +0300
Message-Id: <20241111130047.3679099-1-mordan@ispras.ru>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The driver’s compatibility with devices is confirmed earlier in
platform_match(). Since reaching probe means the device is valid,
the extra check can be removed to simplify the code.

Signed-off-by: Vitalii Mordan <mordan@ispras.ru>
---
v2: Add a comment explaining why dwmac->data cannot be NULL, as per
Andrew Lunn's request.
Link to another patch touching this code and targeted at net tree:
https://lore.kernel.org/netdev/20241108173334.2973603-1-mordan@ispras.ru
 .../stmicro/stmmac/dwmac-intel-plat.c         | 69 ++++++++++---------
 1 file changed, 36 insertions(+), 33 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel-plat.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel-plat.c
index 230e79658c54..377c98801319 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel-plat.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel-plat.c
@@ -97,47 +97,50 @@ static int intel_eth_plat_probe(struct platform_device *pdev)
 	dwmac->dev = &pdev->dev;
 	dwmac->tx_clk = NULL;
 
+	/*
+	 * This cannot return NULL at this point because the driver’s
+	 * compatibility with the device has already been validated in
+	 * platform_match().
+	 */
 	dwmac->data = device_get_match_data(&pdev->dev);
-	if (dwmac->data) {
-		if (dwmac->data->fix_mac_speed)
-			plat_dat->fix_mac_speed = dwmac->data->fix_mac_speed;
-
-		/* Enable TX clock */
-		if (dwmac->data->tx_clk_en) {
-			dwmac->tx_clk = devm_clk_get(&pdev->dev, "tx_clk");
-			if (IS_ERR(dwmac->tx_clk))
-				return PTR_ERR(dwmac->tx_clk);
-
-			clk_prepare_enable(dwmac->tx_clk);
-
-			/* Check and configure TX clock rate */
-			rate = clk_get_rate(dwmac->tx_clk);
-			if (dwmac->data->tx_clk_rate &&
-			    rate != dwmac->data->tx_clk_rate) {
-				rate = dwmac->data->tx_clk_rate;
-				ret = clk_set_rate(dwmac->tx_clk, rate);
-				if (ret) {
-					dev_err(&pdev->dev,
-						"Failed to set tx_clk\n");
-					return ret;
-				}
-			}
-		}
-
-		/* Check and configure PTP ref clock rate */
-		rate = clk_get_rate(plat_dat->clk_ptp_ref);
-		if (dwmac->data->ptp_ref_clk_rate &&
-		    rate != dwmac->data->ptp_ref_clk_rate) {
-			rate = dwmac->data->ptp_ref_clk_rate;
-			ret = clk_set_rate(plat_dat->clk_ptp_ref, rate);
+	if (dwmac->data->fix_mac_speed)
+		plat_dat->fix_mac_speed = dwmac->data->fix_mac_speed;
+
+	/* Enable TX clock */
+	if (dwmac->data->tx_clk_en) {
+		dwmac->tx_clk = devm_clk_get(&pdev->dev, "tx_clk");
+		if (IS_ERR(dwmac->tx_clk))
+			return PTR_ERR(dwmac->tx_clk);
+
+		clk_prepare_enable(dwmac->tx_clk);
+
+		/* Check and configure TX clock rate */
+		rate = clk_get_rate(dwmac->tx_clk);
+		if (dwmac->data->tx_clk_rate &&
+		    rate != dwmac->data->tx_clk_rate) {
+			rate = dwmac->data->tx_clk_rate;
+			ret = clk_set_rate(dwmac->tx_clk, rate);
 			if (ret) {
 				dev_err(&pdev->dev,
-					"Failed to set clk_ptp_ref\n");
+					"Failed to set tx_clk\n");
 				return ret;
 			}
 		}
 	}
 
+	/* Check and configure PTP ref clock rate */
+	rate = clk_get_rate(plat_dat->clk_ptp_ref);
+	if (dwmac->data->ptp_ref_clk_rate &&
+	    rate != dwmac->data->ptp_ref_clk_rate) {
+		rate = dwmac->data->ptp_ref_clk_rate;
+		ret = clk_set_rate(plat_dat->clk_ptp_ref, rate);
+		if (ret) {
+			dev_err(&pdev->dev,
+				"Failed to set clk_ptp_ref\n");
+			return ret;
+		}
+	}
+
 	plat_dat->bsp_priv = dwmac;
 	plat_dat->eee_usecs_rate = plat_dat->clk_ptp_rate;
 
-- 
2.25.1


