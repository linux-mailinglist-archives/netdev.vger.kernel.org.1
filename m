Return-Path: <netdev+bounces-154353-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE5AA9FD2EA
	for <lists+netdev@lfdr.de>; Fri, 27 Dec 2024 11:01:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80F1E1881521
	for <lists+netdev@lfdr.de>; Fri, 27 Dec 2024 10:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1679614C59C;
	Fri, 27 Dec 2024 10:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gnu.org header.i=@gnu.org header.b="GCZTIsl+"
X-Original-To: netdev@vger.kernel.org
Received: from eggs.gnu.org (eggs.gnu.org [209.51.188.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327FC1482F5;
	Fri, 27 Dec 2024 10:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.51.188.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735293697; cv=none; b=qWU6F6VKHdo5OKlQ3tlZgl/t4bHK0vFoxySeLeelVmqDHpC22K9HhSgrKP1kXZPpGEuPG3ORZoP1z0nhksjv+KhpjhecQyEzABAmIBv8qH/N4fJhtpZyoHYZUOEWXECN8COZYBPDTBhrkmP7nC3uGUw9fou5GRNSjBynNRz9GXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735293697; c=relaxed/simple;
	bh=WcWF+12kV1uySm5w0srYjFsY9GMysQQXdW5PghXjOXc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RXplGmF1H/5gKxYYdEMbVqmksNAoqkubE6SdnS1dL0VwLxvKdXjep9YL6oyv4T7Bk/g+z5sWg9Q2/JQNvBovDo+A1mRMg4h3jTvAHkJQ5BP6car//+82pWXLaeolCH6GvwBu2XoS6IK4h5RWMnqQU5aEUYM/W629RsTWL61vZI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gnu.org; spf=pass smtp.mailfrom=gnu.org; dkim=pass (2048-bit key) header.d=gnu.org header.i=@gnu.org header.b=GCZTIsl+; arc=none smtp.client-ip=209.51.188.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnu.org
Received: from fencepost.gnu.org ([2001:470:142:3::e])
	by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.90_1)
	(envelope-from <othacehe@gnu.org>)
	id 1tR79r-0006cy-Oc; Fri, 27 Dec 2024 05:01:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
	s=fencepost-gnu-org; h=MIME-Version:Date:Subject:To:From:in-reply-to:
	references; bh=9DEKZGF8SvaLlJuIGDJ5lSPb68oHIixULPaNolYeeXA=; b=GCZTIsl+LbYSO8
	l4bY+WiXSIvY+GOdNZ7kNjRFrd5IDSoEOBtn8Z1QJ/KVKNdw/sUbElI/rLIhbFR7nNgC/4G+uieqH
	ISDF6pivvf//dZdEQoRAkOy/F4u0BWdWAvwSWGqdu1pCS8Qr+zjMsvDh3XYJHgg3DESvw4b0834ga
	MshwfVQYSw+gaVRYDgANpfSg9mM+MXy3I3oywgu1gtKSNB2WBiRJThs2GG+plt2TwtMNh+G36qSU5
	0cVmnzAqwFP4DUsM18eVMVCByD5JmEqwfHv7ToGDrK9FL6wWv7HmCDtjJo33je5m1UFDgrzz4B8kE
	ApzkKa7Msu8NNwQS0kCg==;
From: Mathieu Othacehe <othacehe@gnu.org>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Mathieu Othacehe <othacehe@gnu.org>
Subject: [PATCH v2] net: dwmac-imx: add imx93 clock input support in RMII mode
Date: Fri, 27 Dec 2024 10:59:22 +0100
Message-ID: <20241227095923.4414-1-othacehe@gnu.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the rmii_refclk_ext boolean is set, configure the ENET QOS TX_CLK pin
direction to input. Otherwise, it defaults to output.

That mirrors what is already happening for the imx8mp in the
imx8mp_set_intf_mode function.

Signed-off-by: Mathieu Othacehe <othacehe@gnu.org>
---
Changelog:
v2: regmap_update_bits -> regmap_clear_bits

 drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
index 43e0fbba4f77b..4ac7a78f4b14b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
@@ -36,6 +36,8 @@
 #define MX93_GPR_ENET_QOS_INTF_SEL_RMII		(0x4 << 1)
 #define MX93_GPR_ENET_QOS_INTF_SEL_RGMII	(0x1 << 1)
 #define MX93_GPR_ENET_QOS_CLK_GEN_EN		(0x1 << 0)
+#define MX93_GPR_ENET_QOS_CLK_SEL_MASK		BIT_MASK(0)
+#define MX93_GPR_CLK_SEL_OFFSET			(4)
 
 #define DMA_BUS_MODE			0x00001000
 #define DMA_BUS_MODE_SFT_RESET		(0x1 << 0)
@@ -108,13 +110,21 @@ imx8dxl_set_intf_mode(struct plat_stmmacenet_data *plat_dat)
 static int imx93_set_intf_mode(struct plat_stmmacenet_data *plat_dat)
 {
 	struct imx_priv_data *dwmac = plat_dat->bsp_priv;
-	int val;
+	int val, ret;
 
 	switch (plat_dat->mac_interface) {
 	case PHY_INTERFACE_MODE_MII:
 		val = MX93_GPR_ENET_QOS_INTF_SEL_MII;
 		break;
 	case PHY_INTERFACE_MODE_RMII:
+		if (dwmac->rmii_refclk_ext) {
+			ret = regmap_clear_bits(dwmac->intf_regmap,
+						dwmac->intf_reg_off +
+						MX93_GPR_CLK_SEL_OFFSET,
+						MX93_GPR_ENET_QOS_CLK_SEL_MASK);
+			if (ret)
+				return ret;
+		}
 		val = MX93_GPR_ENET_QOS_INTF_SEL_RMII;
 		break;
 	case PHY_INTERFACE_MODE_RGMII:
-- 
2.47.1


