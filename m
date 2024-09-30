Return-Path: <netdev+bounces-130549-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1815398AC3D
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 20:39:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0EA7281D51
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 18:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C69B8198831;
	Mon, 30 Sep 2024 18:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="WWW7kbfJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92320192D7F;
	Mon, 30 Sep 2024 18:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727721578; cv=none; b=t15/xqVqzuMBKNHsG+xLi2T7H5WJkOR5drjASJ4L+ULpsFtxB3FGhEEB3QnNrlaPaeG/TNEChiFHYEhRq27q4wxyGowqhLxdnEQ8GTqr0//ZuoE/tSnm2Lx94MK3wLH5lcpZZUedc3psJz65Akp+DGaYH7+KMEArhNfND3aWIAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727721578; c=relaxed/simple;
	bh=r7/wwWZYZPRMKv5JCNGOt1L38U3jyMhWQ++w9lwtEZs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=ACthLWnAcpba2bM9/4sfKQbT4W5TC4oRDzSa6m48bsA2WVh8PG4KvGrBvgyAlZBX5MtHjwqOGbTbt3DlBebOEwmAgdtX1bJKFj4OCfazstn2NCnxHEoyWlTCGQ9djMGlZsUrhR36urzeo9lr27VwBzEaO4VgdksHWX7lxwbpC7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=WWW7kbfJ; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from ldvnode.intra.ispras.ru (unknown [10.10.2.153])
	by mail.ispras.ru (Postfix) with ESMTPSA id 61DBA40B2780;
	Mon, 30 Sep 2024 18:39:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 61DBA40B2780
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1727721573;
	bh=EkePz0QZBHDVlWdj7UJdZqKYGef/fDfv5u3pL2M96dw=;
	h=From:To:Cc:Subject:Date:From;
	b=WWW7kbfJvA13JblxvXd6D0igUgcj+J2GCFl3FxMhnURTiaQnK4YYGASkODxuNEkGl
	 +50R+k2UEEUAY9Ob110lGtKH5La9W/RvjibsXyMAFBwp/v9JneDPqOGpJhTtZTHZVl
	 IHNDJQr8DsgQJTeEGBHzRD1LrY5moNq2ZFyT1Oak=
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
Subject: [PATCH net-next] stmmac: dwmac-intel-plat: remove redundant check dwmac->data in probe
Date: Mon, 30 Sep 2024 21:39:26 +0300
Message-Id: <20240930183926.2112546-1-mordan@ispras.ru>
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
 .../stmicro/stmmac/dwmac-intel-plat.c         | 64 +++++++++----------
 1 file changed, 31 insertions(+), 33 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel-plat.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel-plat.c
index d68f0c4e7835..9139b2b1bf0b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel-plat.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel-plat.c
@@ -98,46 +98,44 @@ static int intel_eth_plat_probe(struct platform_device *pdev)
 	dwmac->tx_clk = NULL;
 
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


