Return-Path: <netdev+bounces-244649-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 266EDCBC0FF
	for <lists+netdev@lfdr.de>; Sun, 14 Dec 2025 23:16:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5983C3011186
	for <lists+netdev@lfdr.de>; Sun, 14 Dec 2025 22:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE517316192;
	Sun, 14 Dec 2025 22:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ob7FlLVW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C6328B4E2;
	Sun, 14 Dec 2025 22:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765750553; cv=none; b=l4UQCEeg+gpiuqo7aznsab+eMTK6haYSCczfLO/WuOtmzkHgtsl5Wxxwbh1vIcpGGccXmFKyR+QQ1eHnXPsVTZnAmEtZf/Jyl0sY6TVyEaCgZwzUIG/TGz4zjH1liebO2vp3HzYvD4zNd+cL01wXxw9X9K4DG3/S/g3HKJ9jeeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765750553; c=relaxed/simple;
	bh=P9Q41cO8YGpX3BgJ7Y8X3jIUqm2KQRT2kYjQtm3/tOc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IWPZBwPWsqm7UyOvnV+CEfPg6+HgD/v/nQcJMiqLdnGPEav7yfxNsUOoEbCm3IRh9miDfBExmiC9bFk3oBEA0/wohisGhlre5mTrXoswvzupvvFDrdAg1sfs66MXHTq9tVaG/KigAG7yvyNgeTvzYUZrqosfOTxkNNn/ZP/YQwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ob7FlLVW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0C82FC19421;
	Sun, 14 Dec 2025 22:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765750553;
	bh=P9Q41cO8YGpX3BgJ7Y8X3jIUqm2KQRT2kYjQtm3/tOc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ob7FlLVW42lzAs7XE5EMKcM7Hr8tK4HNdfHb0+bfaNNZOKxSeKGoE81NeQBiaTdkO
	 puyF6c8JK6gB+Nonw2Y8913Rav1P+ktIMQIBD48tvaH/1OntCcS5i1jc+wQR+36HDB
	 L+xAV3gBAb/lnp7JhtXV6pF3EMUbr3JfLCYqORavCZw00t6q8hGNZe7Edpr39xXJbq
	 F8KEu7pLOSu9aRO0JAfSph3NZOfgd3bc60TZ/A7NSKM5CSYGkXuWWVacE4ZjaQ5rZW
	 gr1Y86sbduprjMEBJv1eDSpcH3r3zM0b9My/ejhmHcQC027IN4jZ6Yv6tnr6H2EtML
	 OlE01NOa2NYOw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC7A3D59D99;
	Sun, 14 Dec 2025 22:15:52 +0000 (UTC)
From: Jan Petrous via B4 Relay <devnull+jan.petrous.oss.nxp.com@kernel.org>
Date: Sun, 14 Dec 2025 23:15:37 +0100
Subject: [PATCH RFC 1/4] net: stmmac: platform: read channels irq
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251214-dwmac_multi_irq-v1-1-36562ab0e9f7@oss.nxp.com>
References: <20251214-dwmac_multi_irq-v1-0-36562ab0e9f7@oss.nxp.com>
In-Reply-To: <20251214-dwmac_multi_irq-v1-0-36562ab0e9f7@oss.nxp.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Chester Lin <chester62515@gmail.com>, Matthias Brugger <mbrugger@suse.com>, 
 Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>, 
 NXP S32 Linux Team <s32@nxp.com>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, devicetree@vger.kernel.org, 
 "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1765750551; l=2187;
 i=jan.petrous@oss.nxp.com; s=20240922; h=from:subject:message-id;
 bh=Oc39mDasSDPGKH+yBMl8WiteW86TeFvrmazDY9RdtwU=;
 b=KSth4uonWM5nPcyW2B4cGYpap63loliV1langCG9n8+Pu+jcPnyVcj+IPhvWWbmVyVyc+jnad
 HY9aaNu+LwtCygDPmmVEIjPyzxgYbviB16ccutG5CbNJY7A9GrLGEko
X-Developer-Key: i=jan.petrous@oss.nxp.com; a=ed25519;
 pk=Ke3wwK7rb2Me9UQRf6vR8AsfJZfhTyoDaxkUCqmSWYY=
X-Endpoint-Received: by B4 Relay for jan.petrous@oss.nxp.com/20240922 with
 auth_id=217
X-Original-From: "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>
Reply-To: jan.petrous@oss.nxp.com

From: "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>

Read IRQ resources for all channels, to allow multi IRQ mode
for platform glue drivers.

Signed-off-by: Jan Petrous (OSS) <jan.petrous@oss.nxp.com>
---
 .../net/ethernet/stmicro/stmmac/stmmac_platform.c  | 38 +++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index 8979a50b5507..29e40253bdfe 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -700,6 +700,9 @@ EXPORT_SYMBOL_GPL(stmmac_pltfr_find_clk);
 int stmmac_get_platform_resources(struct platform_device *pdev,
 				  struct stmmac_resources *stmmac_res)
 {
+	int i;
+	char name[8];
+
 	memset(stmmac_res, 0, sizeof(*stmmac_res));
 
 	/* Get IRQ information early to have an ability to ask for deferred
@@ -743,7 +746,40 @@ int stmmac_get_platform_resources(struct platform_device *pdev,
 
 	stmmac_res->addr = devm_platform_ioremap_resource(pdev, 0);
 
-	return PTR_ERR_OR_ZERO(stmmac_res->addr);
+	if (IS_ERR(stmmac_res->addr))
+		return PTR_ERR(stmmac_res->addr);
+
+	/* RX channels irq */
+	for (i = 0; i < MTL_MAX_RX_QUEUES; i++) {
+		scnprintf(name, 8, "rx-queue-%d", i);
+		stmmac_res->rx_irq[i] = platform_get_irq_byname_optional(pdev,
+									 name);
+		if (stmmac_res->rx_irq[i] < 0) {
+			if (stmmac_res->rx_irq[i] == -EPROBE_DEFER)
+				return -EPROBE_DEFER;
+			dev_dbg(&pdev->dev, "IRQ rx-queue-%d not found\n", i);
+
+			/* Stop on first unset rx-queue-%i property member */
+			break;
+		}
+	}
+
+	/* TX channels irq */
+	for (i = 0; i < MTL_MAX_TX_QUEUES; i++) {
+		scnprintf(name, 8, "tx-queue-%d", i);
+		stmmac_res->tx_irq[i] = platform_get_irq_byname_optional(pdev,
+									 name);
+		if (stmmac_res->tx_irq[i] < 0) {
+			if (stmmac_res->tx_irq[i] == -EPROBE_DEFER)
+				return -EPROBE_DEFER;
+			dev_dbg(&pdev->dev, "IRQ tx-queue-%d not found\n", i);
+
+			/* Stop on first unset tx-queue-%i property member */
+			break;
+		}
+	}
+
+	return 0;
 }
 EXPORT_SYMBOL_GPL(stmmac_get_platform_resources);
 

-- 
2.47.0



