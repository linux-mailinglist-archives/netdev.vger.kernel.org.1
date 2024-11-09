Return-Path: <netdev+bounces-143532-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12AF19C2E25
	for <lists+netdev@lfdr.de>; Sat,  9 Nov 2024 16:18:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90E201F21EE8
	for <lists+netdev@lfdr.de>; Sat,  9 Nov 2024 15:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E36B19D074;
	Sat,  9 Nov 2024 15:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="qJ8ZKYZx"
X-Original-To: netdev@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6742F19C540;
	Sat,  9 Nov 2024 15:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731165488; cv=none; b=gfAnilmFMnKwusN9wcjif+EvByEP75uTfMFBS7wDbPhsEiSaQVNyQECdS4UwkDnk7gZWuFePz18PHeLDgvn+/ZBowFsAsynytLLVqsMlKvxiAxZL9e852+OFghXg5dQzkhH0GmhpQgYJcOhTBVxBZSDOoAMqaSMbRSMjIO7NIsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731165488; c=relaxed/simple;
	bh=eLx0mv3l0t8dDseyOxotcA8WePZEOhSvmmm8Mnw0iNE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=askBVXYyXA0KJ9YSVYC6qSeYz+YJ/P2qG4mZH/O5t5NkxQfr4UjI09RcHjCuo6Svj9jbc4jQRWotFpmvcbJhUz+cz/C5403UerJxuE5aZ+/mygJdKkCexbK7/aiAHgev6tkmQdXX3RpkLroY0G29sZP+dcqhyiwrA0J+Aw2ziDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=qJ8ZKYZx; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1731165479;
	bh=eLx0mv3l0t8dDseyOxotcA8WePZEOhSvmmm8Mnw0iNE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qJ8ZKYZxmmnZiHe56sAIWXftljzD5x88KjNm1b6nES+TogWK5noUiQlOYrahcvqXq
	 Gau64MLdkhHL72g393CjhbW7MNNS92Orb+VVOqCCqQWloVsvOELuLE5nBzkoPzr2qj
	 PyD7ocZ2CGbkiulK2TKgw7Ny3xwBcwW47DcXGpECHdri+0CJPMl7LCjlljMmhFvNEo
	 zP58izllyVEQnKXl0mf4eKqCPAlhC/ROIvJJy2LkhHLfhHlGjR1VTmgioKQnW8y++W
	 YQwPCNTOoN9yxWoMNipCtzM7nFDnBTCdUl1DDaqGBeAa/cK9fN2KMjXGsA/lWWRwHP
	 8y4/ir22ssN5g==
Received: from [192.168.1.63] (pool-100-2-116-133.nycmny.fios.verizon.net [100.2.116.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 6C05117E3696;
	Sat,  9 Nov 2024 16:17:56 +0100 (CET)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Sat, 09 Nov 2024 10:16:32 -0500
Subject: [PATCH v2 1/2] net: stmmac: dwmac-mediatek: Fix inverted handling
 of mediatek,mac-wol
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241109-mediatek-mac-wol-noninverted-v2-1-0e264e213878@collabora.com>
References: <20241109-mediatek-mac-wol-noninverted-v2-0-0e264e213878@collabora.com>
In-Reply-To: <20241109-mediatek-mac-wol-noninverted-v2-0-0e264e213878@collabora.com>
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
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
 Andrew Halaney <ahalaney@redhat.com>, Simon Horman <horms@kernel.org>
Cc: kernel@collabora.com, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
X-Mailer: b4 0.14.2

The mediatek,mac-wol property is being handled backwards to what is
described in the binding: it currently enables PHY WOL when the property
is present and vice versa. Invert the driver logic so it matches the
binding description.

Fixes: fd1d62d80ebc ("net: stmmac: replace the use_phy_wol field with a flag")
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
index f8ca81675407ade786f2b9a38c63511a0b7fb705..c9636832a570a211a53f9480b0a8aec56509199f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
@@ -589,9 +589,9 @@ static int mediatek_dwmac_common_data(struct platform_device *pdev,
 
 	plat->mac_interface = priv_plat->phy_mode;
 	if (priv_plat->mac_wol)
-		plat->flags |= STMMAC_FLAG_USE_PHY_WOL;
-	else
 		plat->flags &= ~STMMAC_FLAG_USE_PHY_WOL;
+	else
+		plat->flags |= STMMAC_FLAG_USE_PHY_WOL;
 	plat->riwt_off = 1;
 	plat->maxmtu = ETH_DATA_LEN;
 	plat->host_dma_width = priv_plat->variant->dma_bit_mask;

-- 
2.47.0


