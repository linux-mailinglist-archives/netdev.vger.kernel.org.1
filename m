Return-Path: <netdev+bounces-51589-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2046F7FB4C4
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 09:50:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B1141C210C7
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 08:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E76301D54E;
	Tue, 28 Nov 2023 08:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Biez3ElI"
X-Original-To: netdev@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91230E7;
	Tue, 28 Nov 2023 00:50:09 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2A138C0011;
	Tue, 28 Nov 2023 08:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1701161408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qYJnE4Z1r7jKRPOrGAwXhHc797bbl+1US3cszB9aa9E=;
	b=Biez3ElIDFQtKoAoSEC77AQXzKbt7Ch1XeZiVYhh0NXtG9v9GlfxXJMHUGbOSfb77LUOcn
	3R+0msBidXWkzyP/oA03LjO59JoGEB8nwVxWQhzryO7/3lBgdfOGe+ccmpFTRzo+6Hyh/S
	GD+Y3ayQHKYfSpqkoEeBAFW7jASzaG7FBLQy3BcrLGsrxmfREYLffgYMaUk3magZpde8IY
	Jpkm3fVUL0fUT7BMlooYuZIqQDCRhLrK/p3fM+xSrJ+AkeIXExE94qMn2452ctDbzk7VWP
	2n/LDss+hsxqQFoi5sfx/ccHyQ5hgvuoH436OaEzpLi2b4pI+5FaKvrDAG795Q==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Simon Horman <horms@kernel.org>,
	linux-stm32@st-md-mailman.stormreply.com,
	alexis.lothore@bootlin.com
Subject: [PATCH net] net: stmmac: dwmac-socfpga: Don't access SGMII adapter when not available
Date: Tue, 28 Nov 2023 10:45:37 +0100
Message-ID: <20231128094538.228039-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: maxime.chevallier@bootlin.com

The SGMII adapter isn't present on all dwmac-socfpga implementations.
Make sure we don't try to configure it if we don't have this adapter.

Fixes: 5d1f3fe7d2d5 ("net: stmmac: dwmac-sogfpga: use the lynx pcs driver")
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
index ba2ce776bd4d..ae120792e1b6 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
@@ -243,7 +243,8 @@ static void socfpga_sgmii_config(struct socfpga_dwmac *dwmac, bool enable)
 {
 	u16 val = enable ? SGMII_ADAPTER_ENABLE : SGMII_ADAPTER_DISABLE;
 
-	writew(val, dwmac->sgmii_adapter_base + SGMII_ADAPTER_CTRL_REG);
+	if (dwmac->sgmii_adapter_base)
+		writew(val, dwmac->sgmii_adapter_base + SGMII_ADAPTER_CTRL_REG);
 }
 
 static int socfpga_set_phy_mode_common(int phymode, u32 *val)
-- 
2.42.0


