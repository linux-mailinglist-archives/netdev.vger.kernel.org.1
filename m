Return-Path: <netdev+bounces-152515-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6205F9F467F
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 09:51:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 224711889229
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 08:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3AD518B46E;
	Tue, 17 Dec 2024 08:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gnu.org header.i=@gnu.org header.b="phi9YE3T"
X-Original-To: netdev@vger.kernel.org
Received: from eggs.gnu.org (eggs.gnu.org [209.51.188.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B250C15624D;
	Tue, 17 Dec 2024 08:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.51.188.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734425453; cv=none; b=nqKhdHfT/fxeD7PClAERX4ms/h253W5JYP70Kv3hmXrmX+qK3/VaW1iE8L9inibweQOyFqzipRLUREOle3D7RrAfK6m5fwn9h+Q3eZ4v8ou+WMJoUtQ450mVHi7+uxFBBs73qGTMrG1gFZZqxG1yjQ2UmtOOzeWgApYaU/4t2Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734425453; c=relaxed/simple;
	bh=jOuFNeVw3A40UFZgLB0L0ZIblUFbAVxIM0y3XDCCmrA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=erQBJu+unuK4AHWflCpWpbM9EmZI6B0cuFLbEA2hxEwHxk3NNQ6mZD5njBNgPrUbGuNwi6RlzeeEiT/b3cgU6/wL2fjjEqjuNe9vrFlHYLN0DPylFXZyOVT+c0e/ob1N1PpWoWzaVTa8x9Sav/BImTfKKoE85DPieq0FcuV1yVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gnu.org; spf=pass smtp.mailfrom=gnu.org; dkim=pass (2048-bit key) header.d=gnu.org header.i=@gnu.org header.b=phi9YE3T; arc=none smtp.client-ip=209.51.188.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnu.org
Received: from fencepost.gnu.org ([2001:470:142:3::e])
	by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.90_1)
	(envelope-from <othacehe@gnu.org>)
	id 1tNTHw-0007Zi-9o; Tue, 17 Dec 2024 03:50:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
	s=fencepost-gnu-org; h=MIME-Version:Date:Subject:To:From:in-reply-to:
	references; bh=QjMbBnqLU89/PImNcF7KgMNjpyfzwSWuA4nnZnxVqhk=; b=phi9YE3T+V6j9j
	9hQPxaVQMHJKwucDjzYY8Nn21/0XWqarbZLPezkVrTsbOpXejP5eg7JsbBuYC+D8rjYTqVYMqEedM
	7KDX3yuNGltkaA7Zh/zguvFPyQILytIaKQpXNSY23cozFQciYZF8Rh1VOYoos2lDeX7H6pVSHb0+N
	nGhK4DzqrEe+qys2t19dLN7Cb+IDquTF4TcRwy7WUc6X7fdyyuW5hJDjQcZ5hTbkBRbyOlwWHJLvO
	YDIKmlppgPlnulJm5CiSo69JaPdPwLA/2hCsay90Ov+TlZVLoHkjrwSSOku2hkMP9TLVO8sdTz/nf
	7EvzkqY+WtO8LiflvPDQ==;
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
Subject: [PATCH] net: dwmac-imx: add imx93 clock input support in RMII mode
Date: Tue, 17 Dec 2024 09:49:42 +0100
Message-ID: <20241217084942.4071-1-othacehe@gnu.org>
X-Mailer: git-send-email 2.46.0
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
 drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
index 43e0fbba4f77b..68b3fbdd46647 100644
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
@@ -108,13 +110,22 @@ imx8dxl_set_intf_mode(struct plat_stmmacenet_data *plat_dat)
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
+			ret = regmap_update_bits(dwmac->intf_regmap,
+						 dwmac->intf_reg_off +
+						 MX93_GPR_CLK_SEL_OFFSET,
+						 MX93_GPR_ENET_QOS_CLK_SEL_MASK,
+						 0);
+			if (ret)
+				return ret;
+		}
 		val = MX93_GPR_ENET_QOS_INTF_SEL_RMII;
 		break;
 	case PHY_INTERFACE_MODE_RGMII:
-- 
2.46.0


