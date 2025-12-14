Return-Path: <netdev+bounces-244650-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE46CBC102
	for <lists+netdev@lfdr.de>; Sun, 14 Dec 2025 23:16:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C663730173BC
	for <lists+netdev@lfdr.de>; Sun, 14 Dec 2025 22:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D54123161B9;
	Sun, 14 Dec 2025 22:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EJwZiL8/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D06E31578F;
	Sun, 14 Dec 2025 22:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765750553; cv=none; b=YIEaATG2AXRWe2ggxEI4oqPRe8YWC0s+CvF0H9N4uoioMBUaniY9KdkpjAsxAqIFEREdyZi5603lgyRNITjIoH1eGBqjK6J3McsEcCj1MSvgZt27f6B2NGITHaIPVikGsa+dIxsUhJn5aAma4njKYy4BTNnzJJlPhJSOk1CCXr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765750553; c=relaxed/simple;
	bh=+dB1ubbQUZbbOBra3vCG6KF5yaKYR81O/ni3EMy7Nb8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SKy2xOqboFduy6ainlzamUZ3nEn4y4ZtRP0x87Smgdig2Xf8gGTDGvRTf/ns06Ih4utINUbDNSM7ncr99oplgFgPxvwe2xHF3zT1HP/zqNu49tdaln4env25zqHEbrcIO/udNChwx5vtfXcddk5N1ud9WE+dCKVp+VfpEmvekXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EJwZiL8/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 56912C2BCB3;
	Sun, 14 Dec 2025 22:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765750553;
	bh=+dB1ubbQUZbbOBra3vCG6KF5yaKYR81O/ni3EMy7Nb8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=EJwZiL8/o8OAqNHR8DmIpjMQJmZS6GarMS4Dh7gOfFm84cO8ExZqijdqRoTaxFQ+N
	 zUkS8m0lWsuZ6MoMnByvAHLj3smihk0bdyZscRIKvklUQot/Ig9SSdHHiqP9UQsAYQ
	 fs4AMbK83DrtyqxpTsQ8ZOF1BirIzZnmaBt1u4JCMrqua5086jLVJCGo2WSzJj6meG
	 8d3gYkLQIdnHKz7MfXT5a14XDp8DEFPFjpLBd+RN/qziaJuWQpTazfaF+9iAPiykeW
	 cuZTT0EvzgXMlnAeN15MX85386AIAZtZNY2Nb+8oqqNJxzORlvf2Ka7arrTkLJNcCS
	 xGXIgwScvgxqQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4810AD5B16F;
	Sun, 14 Dec 2025 22:15:53 +0000 (UTC)
From: Jan Petrous via B4 Relay <devnull+jan.petrous.oss.nxp.com@kernel.org>
Date: Sun, 14 Dec 2025 23:15:40 +0100
Subject: [PATCH RFC 4/4] stmmac: s32: enable multi irqs mode
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251214-dwmac_multi_irq-v1-4-36562ab0e9f7@oss.nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1765750551; l=1135;
 i=jan.petrous@oss.nxp.com; s=20240922; h=from:subject:message-id;
 bh=uKYPU0Ih9OcJADxPjnsSZTg/aiN/NSWTJ7b+174uNp0=;
 b=ccktjokTsHbY0A8sCrOp0tvellHMrF7o/nyJheYG8kgkcnDKKoYdHjDKtsJCQl7WUSZQnL3hC
 etvrjrpdbBbDMgbIUC/YcKNTWUWoFvuM3l4eTc66bLQcMfsxAg2TFRv
X-Developer-Key: i=jan.petrous@oss.nxp.com; a=ed25519;
 pk=Ke3wwK7rb2Me9UQRf6vR8AsfJZfhTyoDaxkUCqmSWYY=
X-Endpoint-Received: by B4 Relay for jan.petrous@oss.nxp.com/20240922 with
 auth_id=217
X-Original-From: "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>
Reply-To: jan.petrous@oss.nxp.com

From: "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>

Signalize support for multi irq mode.

From now, if yoused old DT node, without channel IRQs set,
the driver fails to init with the following error:

[4.925420] s32-dwmac 4033c000.ethernet eth0: stmmac_request_irq_multi_msi: alloc rx-0  MSI -6 (error: -22)

Signed-off-by: Jan Petrous (OSS) <jan.petrous@oss.nxp.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c
index 5a485ee98fa7..284e2067a00b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c
@@ -2,7 +2,7 @@
 /*
  * NXP S32G/R GMAC glue layer
  *
- * Copyright 2019-2024 NXP
+ * Copyright 2019-2025 NXP
  *
  */
 
@@ -149,6 +149,7 @@ static int s32_dwmac_probe(struct platform_device *pdev)
 	plat->core_type = DWMAC_CORE_GMAC4;
 	plat->pmt = 1;
 	plat->flags |= STMMAC_FLAG_SPH_DISABLE;
+	plat->flags |= STMMAC_FLAG_MULTI_MSI_EN;
 	plat->rx_fifo_size = 20480;
 	plat->tx_fifo_size = 20480;
 

-- 
2.47.0



