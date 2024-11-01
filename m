Return-Path: <netdev+bounces-141051-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74FDA9B943D
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 16:20:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 981A91C21373
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 15:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA7621C3318;
	Fri,  1 Nov 2024 15:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Y6PuDibA"
X-Original-To: netdev@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57DFE1C0DD6;
	Fri,  1 Nov 2024 15:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730474454; cv=none; b=lF6IIPtg+eWhLby9Y2t179OGTlmOVsXIC0yLjNTISqeLboaK4rfnVhGVkdTDMrsPF+75+mjzXBrKxkm83Fo7IrhmtNR2HX3127poi7j8sTNfdbkMZr7I4qhZwquJ44DO4OQ1Y07bFjPPLEwV7yzg8zFBnY0kQvjWukeHmyZ6Juc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730474454; c=relaxed/simple;
	bh=mA2I+V0jmE17nosO27KRVAzP6b9TsoO1O+RYOl7x5tc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I3woWk4MdLpQy/7r7LVYKyFUJ3DQldOzEK/22yhwus6l/jS8tXmXUQkm8ZVdIBzwwwyd8PLYlxXSq7a+Ocgvz2R6grRkZQPx0eqV4v8twDPrD0o1UTsyJrlzfrd1e8axdfs72yEVHg7JPMvjUzB8neHhbC5wKy9kykLrLndo1JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Y6PuDibA; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1730474450;
	bh=mA2I+V0jmE17nosO27KRVAzP6b9TsoO1O+RYOl7x5tc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Y6PuDibA13Tiu/mFj6sgHUpKPAIZJdUJxCO/uPujAaU2EeIKxpEmwVP5d58+fpCdn
	 ay+DGk3S2NfTPu/cjgC82GD3HI9bzw8nOZsYKrMSdJaE5YdkJ6ODkw8jOFgKCEu5T5
	 qm9A2r7sVWlQOq4yxmMt0rk5H3RNVjCPElM9HlaBUQkajhLnvt409XRaTFoLSKHIIl
	 2xt5PXmZs0e33pxFNPOV+1/YRK9c7cFgxbt2x/G1xA1Tu+YqIlFHnukg0YvvDF0Nvz
	 Z+I3MgRVghYEe5k4Ph103d5ZjUpc68IgHSUVqR2ehSTyplxKgfE2oUW9j3obfSO7YX
	 ahIwVx8EyWEVA==
Received: from [192.168.1.214] (pool-100-2-116-133.nycmny.fios.verizon.net [100.2.116.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 5A6A017E0F80;
	Fri,  1 Nov 2024 16:20:48 +0100 (CET)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Fri, 01 Nov 2024 11:20:24 -0400
Subject: [PATCH 2/4] net: stmmac: dwmac-mediatek: Handle non-inverted
 mediatek,mac-wol
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241101-mediatek-mac-wol-noninverted-v1-2-75b81808717a@collabora.com>
References: <20241101-mediatek-mac-wol-noninverted-v1-0-75b81808717a@collabora.com>
In-Reply-To: <20241101-mediatek-mac-wol-noninverted-v1-0-75b81808717a@collabora.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Biao Huang <biao.huang@mediatek.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Jose Abreu <joabreu@synopsys.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: kernel@collabora.com, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
X-Mailer: b4 0.14.2

Parse the newly introduced mediatek,mac-wol-noninverted DT property and
use it to determine how the mediatek,mac-wol property should be
interpreted for enabling the MAC WOL or the PHY WOL.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
index f8ca81675407ade786f2b9a38c63511a0b7fb705..f3255b84195389d73c6f6542f51f962b87a5cb4e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
@@ -85,6 +85,7 @@ struct mediatek_dwmac_plat_data {
 	bool rmii_clk_from_mac;
 	bool rmii_rxc;
 	bool mac_wol;
+	bool mac_wol_noninverted;
 };
 
 struct mediatek_dwmac_variant {
@@ -493,6 +494,7 @@ static int mediatek_dwmac_config_dt(struct mediatek_dwmac_plat_data *plat)
 	plat->rmii_rxc = of_property_read_bool(plat->np, "mediatek,rmii-rxc");
 	plat->rmii_clk_from_mac = of_property_read_bool(plat->np, "mediatek,rmii-clk-from-mac");
 	plat->mac_wol = of_property_read_bool(plat->np, "mediatek,mac-wol");
+	plat->mac_wol_noninverted = of_property_read_bool(plat->np, "mediatek,mac-wol-noninverted");
 
 	return 0;
 }
@@ -588,10 +590,11 @@ static int mediatek_dwmac_common_data(struct platform_device *pdev,
 	int i;
 
 	plat->mac_interface = priv_plat->phy_mode;
-	if (priv_plat->mac_wol)
-		plat->flags |= STMMAC_FLAG_USE_PHY_WOL;
-	else
+	if ((priv_plat->mac_wol_noninverted && priv_plat->mac_wol) ||
+	    (!priv_plat->mac_wol_noninverted && !priv_plat->mac_wol))
 		plat->flags &= ~STMMAC_FLAG_USE_PHY_WOL;
+	else
+		plat->flags |= STMMAC_FLAG_USE_PHY_WOL;
 	plat->riwt_off = 1;
 	plat->maxmtu = ETH_DATA_LEN;
 	plat->host_dma_width = priv_plat->variant->dma_bit_mask;

-- 
2.47.0


