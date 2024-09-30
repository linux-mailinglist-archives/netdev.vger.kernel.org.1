Return-Path: <netdev+bounces-130547-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D421D98AC38
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 20:38:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8416A281BAE
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 18:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF54197A87;
	Mon, 30 Sep 2024 18:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="QhSgQAuT"
X-Original-To: netdev@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22CF7192D7F;
	Mon, 30 Sep 2024 18:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727721478; cv=none; b=NF+kglt0v1IR50aD8JprawwYMzpsqZ/wD2ZD/LS97ojAzs4IoZ9kl+ujDKWI3Jb1HE8IcfiZ/ejhyv/D3GWu+TCCdM5Sv22TVAZ/vePcdNjpiGVrbTImdnThMOzCq/rmXKpV3rIhhNEwNLFCcxWbwYiZFeHubNFzUuEsm4dQiWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727721478; c=relaxed/simple;
	bh=5sf0cAwYL7BiwCpqTmTnyTCr2q/9nn/KjsTOnaPlDxU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LYBUOKslbDhs7NzhS69y8SB9fsnlm+xbHd/GGPildyKazxHV6VJmMK6bX03GJ0IKbEQHFlRZLlcT2DF+gJaSbhgrv52hq061LSMwmL91DCOqZ7ocG+5Le7dWn685DvMAMAi4U6SW3Cqm8tbCOO6ljDr3cuWIXKGIsnUZg3rKpcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=QhSgQAuT; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from ldvnode.intra.ispras.ru (unknown [10.10.2.153])
	by mail.ispras.ru (Postfix) with ESMTPSA id CF9794078508;
	Mon, 30 Sep 2024 18:37:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru CF9794078508
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1727721466;
	bh=mFfxXskUNOkMcuFNoMs7CmGfIHXEVZQaBXOXIvDQD7o=;
	h=From:To:Cc:Subject:Date:From;
	b=QhSgQAuTXS3z2/OchOLEPLD7Z04x66ss1OZjTFlpfV62MFFDXgMhxOEWNUL3r92uE
	 CsiUCwi6XwzImPrf+IohtNMew5hZqFLfA1WayRNYGXrakQDxz7CjxXkbefjxXTlLqz
	 CG0RupwDzbPjsM706YzxPDZBvbHQj8zs/Qp61Wk8=
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
Subject: [PATCH net] stmmac: dwmac-intel-plat: fix call balance of tx_clk handling routines
Date: Mon, 30 Sep 2024 21:37:15 +0300
Message-Id: <20240930183715.2112075-1-mordan@ispras.ru>
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
 .../ethernet/stmicro/stmmac/dwmac-intel-plat.c   | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel-plat.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel-plat.c
index d68f0c4e7835..2a2893f2f2a8 100644
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
@@ -117,6 +122,7 @@ static int intel_eth_plat_probe(struct platform_device *pdev)
 				rate = dwmac->data->tx_clk_rate;
 				ret = clk_set_rate(dwmac->tx_clk, rate);
 				if (ret) {
+					clk_disable_unprepare(dwmac->tx_clk);
 					dev_err(&pdev->dev,
 						"Failed to set tx_clk\n");
 					return ret;
@@ -131,6 +137,8 @@ static int intel_eth_plat_probe(struct platform_device *pdev)
 			rate = dwmac->data->ptp_ref_clk_rate;
 			ret = clk_set_rate(plat_dat->clk_ptp_ref, rate);
 			if (ret) {
+				if (dwmac->data->tx_clk_en)
+					clk_disable_unprepare(dwmac->tx_clk);
 				dev_err(&pdev->dev,
 					"Failed to set clk_ptp_ref\n");
 				return ret;
@@ -150,7 +158,8 @@ static int intel_eth_plat_probe(struct platform_device *pdev)
 
 	ret = stmmac_dvr_probe(&pdev->dev, plat_dat, &stmmac_res);
 	if (ret) {
-		clk_disable_unprepare(dwmac->tx_clk);
+		if (dwmac->data->tx_clk_en)
+			clk_disable_unprepare(dwmac->tx_clk);
 		return ret;
 	}
 
@@ -162,7 +171,8 @@ static void intel_eth_plat_remove(struct platform_device *pdev)
 	struct intel_dwmac *dwmac = get_stmmac_bsp_priv(&pdev->dev);
 
 	stmmac_pltfr_remove(pdev);
-	clk_disable_unprepare(dwmac->tx_clk);
+	if (dwmac->data->tx_clk_en)
+		clk_disable_unprepare(dwmac->tx_clk);
 }
 
 static struct platform_driver intel_eth_plat_driver = {
-- 
2.25.1


