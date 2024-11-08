Return-Path: <netdev+bounces-143371-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 217AC9C2349
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 18:36:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F8CE1C2392C
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 17:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D28B3DABEA;
	Fri,  8 Nov 2024 17:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="F5kOF/Oa"
X-Original-To: netdev@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899E53DABE4;
	Fri,  8 Nov 2024 17:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731087228; cv=none; b=sIYZq7QARBdWcsH556cUYo223dKrlajZ4/HDqIywdl9COOxEFwQ8j/D2u8Pxl8aczg+B3VJGslsVZ/PI9o7jKegqRMXdMcoiODoKlejG6NNsJAGrG1BJdgQ6RJNwq5ycf+vvYzu6ZCmZfWbMlclfIJbH2rsbUwHtxPNG/VFVG8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731087228; c=relaxed/simple;
	bh=uRcRjz02RjtoR9Frpy86rs9dJ32/WD+uzrhERUyBgzM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IJCknYDWI8STkNPpBhNc8DWB7duZ0m4GO6E8b1Ut3T++RmXg4NDl+P+nG0b15yyIQnW/1Zz1bDfokJL2cjpmuYqhxJoIYctb5Sb+GBW5sSMw5UT/vfUGK1WIeq53IhN9Nxs8yFYC8O7z2maNUln2cBKx+A1YiHznA2TR88GZtG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=F5kOF/Oa; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from ldvnode.intra.ispras.ru (unknown [10.10.2.153])
	by mail.ispras.ru (Postfix) with ESMTPSA id E969740B2274;
	Fri,  8 Nov 2024 17:33:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru E969740B2274
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1731087221;
	bh=3QYrsrBPYW43jQDvfadZZ/SbvlgS981KQOnirhhBRvU=;
	h=From:To:Cc:Subject:Date:From;
	b=F5kOF/OaGdZSfFauj5TVSIstfJVU3lTPNTDHweGefjpPXpJ0XtnIpVTv1ULCVKRov
	 PD1zkrsBF3jPlQfslBxcFO3SizMaSk+ggashI9VbDmg/EmGK1EJbDK9lz0pdeW5tyC
	 jdFv4KDgaz8GCIsg5WJfS3SLQjxa0Lw0gdMSRuwE=
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
Subject: [PATCH net v2]: stmmac: dwmac-intel-plat: fix call balance of tx_clk handling routines
Date: Fri,  8 Nov 2024 20:33:34 +0300
Message-Id: <20241108173334.2973603-1-mordan@ispras.ru>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the clock dwmac->tx_clk was not enabled in intel_eth_plat_probe,
it should not be disabled in any path.

Conversely, if it was enabled in intel_eth_plat_probe, it must be disabled
in all error paths to ensure proper cleanup.

Found by Linux Verification Center (linuxtesting.org) with Klever.

Fixes: 9efc9b2b04c7 ("net: stmmac: Add dwmac-intel-plat for GBE driver")
Signed-off-by: Vitalii Mordan <mordan@ispras.ru>
---
v2: Unwind using a goto label, as per Simon Horman's request.

 .../stmicro/stmmac/dwmac-intel-plat.c         | 25 +++++++++++++------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel-plat.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel-plat.c
index d68f0c4e7835..9739bc9867c5 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel-plat.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel-plat.c
@@ -108,7 +108,12 @@ static int intel_eth_plat_probe(struct platform_device *pdev)
 			if (IS_ERR(dwmac->tx_clk))
 				return PTR_ERR(dwmac->tx_clk);
 
-			clk_prepare_enable(dwmac->tx_clk);
+			ret = clk_prepare_enable(dwmac->tx_clk);
+			if (ret) {
+				dev_err(&pdev->dev,
+					"Failed to enable tx_clk\n");
+				return ret;
+			}
 
 			/* Check and configure TX clock rate */
 			rate = clk_get_rate(dwmac->tx_clk);
@@ -119,7 +124,7 @@ static int intel_eth_plat_probe(struct platform_device *pdev)
 				if (ret) {
 					dev_err(&pdev->dev,
 						"Failed to set tx_clk\n");
-					return ret;
+					goto err_tx_clk_disable;
 				}
 			}
 		}
@@ -133,7 +138,7 @@ static int intel_eth_plat_probe(struct platform_device *pdev)
 			if (ret) {
 				dev_err(&pdev->dev,
 					"Failed to set clk_ptp_ref\n");
-				return ret;
+				goto err_tx_clk_disable;
 			}
 		}
 	}
@@ -149,12 +154,15 @@ static int intel_eth_plat_probe(struct platform_device *pdev)
 	}
 
 	ret = stmmac_dvr_probe(&pdev->dev, plat_dat, &stmmac_res);
-	if (ret) {
-		clk_disable_unprepare(dwmac->tx_clk);
-		return ret;
-	}
+	if (ret)
+		goto err_tx_clk_disable;
 
 	return 0;
+
+err_tx_clk_disable:
+	if (dwmac->data->tx_clk_en)
+		clk_disable_unprepare(dwmac->tx_clk);
+	return ret;
 }
 
 static void intel_eth_plat_remove(struct platform_device *pdev)
@@ -162,7 +170,8 @@ static void intel_eth_plat_remove(struct platform_device *pdev)
 	struct intel_dwmac *dwmac = get_stmmac_bsp_priv(&pdev->dev);
 
 	stmmac_pltfr_remove(pdev);
-	clk_disable_unprepare(dwmac->tx_clk);
+	if (dwmac->data->tx_clk_en)
+		clk_disable_unprepare(dwmac->tx_clk);
 }
 
 static struct platform_driver intel_eth_plat_driver = {
-- 
2.25.1


