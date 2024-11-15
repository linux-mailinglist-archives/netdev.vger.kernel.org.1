Return-Path: <netdev+bounces-145263-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2752E9CDFED
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 14:29:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7F021F23AE5
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 13:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 385B31BF804;
	Fri, 15 Nov 2024 13:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="omP7zZoL"
X-Original-To: netdev@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97BD1BF7FC;
	Fri, 15 Nov 2024 13:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731677223; cv=none; b=NwfsIeXnfee8bN0Lk3sefEApxHPtUni09vLINj815Z1flsEp/Zbs82Ssnz0xfuBHvCj3mMLSMHvgvBG3J7qskdUBApRqsCXTVB7hKI7gKCY7PBOcuXjYVbq6U3YaQmv+3m3rkl5xLoSVW/lnkts6yXtrtiEjHly71ozTKk7cKBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731677223; c=relaxed/simple;
	bh=xmb6AeeJzlrkGrfBGxdwUoyxLn2DL5/bv17R11jozjA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=S8JGfEcdV5voaCw8jD9NIJpo6p4XhnmKlAk6LhxuMOabHJLLwJRK96Oz+hpa/w6F065SC+BnKEuoGJzpPLabsIQ2Wal6ot51fj4f6zyy3xRr/f8Ytr1tYgHoGUDxggsGKgXvIu63QEndLhKZWjQbt5H6PqoGUWNHHVH8Izx1alQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=omP7zZoL; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from ldvnode.intra.ispras.ru (unknown [10.10.2.153])
	by mail.ispras.ru (Postfix) with ESMTPSA id BDDCA40777D2;
	Fri, 15 Nov 2024 13:26:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru BDDCA40777D2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1731677215;
	bh=1e1LOUtI0Astf/a7ioL+raSU9vL4XmV0G94gVl8ZTzA=;
	h=From:To:Cc:Subject:Date:From;
	b=omP7zZoLTS3qTb2wHMaUKEYSdvj2aRwzUayVpDedz18JlYgjCW/T1J77VZLAhifpF
	 tWkxPCmDCuE+bKNCgd61u5jWKhkHmQEk8LPHnSWRZ2dEno85iLZCNS08rRLC1rp4cH
	 GO32E5lDSfPXhciACWi1DWaBIbaHF5xpLGgP+vKE=
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
	Vadim Mutilin <mutilin@ispras.ru>,
	Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH net-next v3] stmmac: dwmac-intel-plat: remove redundant dwmac->data check in probe
Date: Fri, 15 Nov 2024 16:26:32 +0300
Message-Id: <20241115132632.599188-1-mordan@ispras.ru>
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
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
v2: Add a comment explaining why dwmac->data cannot be NULL, as per
Andrew Lunn's request.
v3: Resolve merge conflicts.
 .../stmicro/stmmac/dwmac-intel-plat.c         | 53 ++++++++++---------
 1 file changed, 28 insertions(+), 25 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel-plat.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel-plat.c
index a433526dcbe8..d94f0a150e93 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel-plat.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel-plat.c
@@ -97,35 +97,38 @@ static int intel_eth_plat_probe(struct platform_device *pdev)
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
+	if (dwmac->data->fix_mac_speed)
+		plat_dat->fix_mac_speed = dwmac->data->fix_mac_speed;
+
+	/* Enable TX clock */
+	if (dwmac->data->tx_clk_en) {
+		dwmac->tx_clk = devm_clk_get(&pdev->dev, "tx_clk");
+		if (IS_ERR(dwmac->tx_clk))
+			return PTR_ERR(dwmac->tx_clk);
+
+		ret = clk_prepare_enable(dwmac->tx_clk);
+		if (ret) {
+			dev_err(&pdev->dev,
+				"Failed to enable tx_clk\n");
+			return ret;
+		}
 
-			ret = clk_prepare_enable(dwmac->tx_clk);
+		/* Check and configure TX clock rate */
+		rate = clk_get_rate(dwmac->tx_clk);
+		if (dwmac->data->tx_clk_rate &&
+		    rate != dwmac->data->tx_clk_rate) {
+			rate = dwmac->data->tx_clk_rate;
+			ret = clk_set_rate(dwmac->tx_clk, rate);
 			if (ret) {
 				dev_err(&pdev->dev,
-					"Failed to enable tx_clk\n");
-				return ret;
-			}
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
-					goto err_tx_clk_disable;
-				}
+					"Failed to set tx_clk\n");
+				goto err_tx_clk_disable;
 			}
 		}
 
-- 
2.25.1


