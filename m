Return-Path: <netdev+bounces-16613-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B2574E012
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 23:13:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 754EE1C20C04
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 21:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFF10156F4;
	Mon, 10 Jul 2023 21:13:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DAAF156D7
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 21:13:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD4A4C433C7;
	Mon, 10 Jul 2023 21:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689023614;
	bh=WRBYobPoSiX9Bs9tPTqxJ6CgeX9ttbxvGsZ4Eo0kj2w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X2gHDp89fMENCKrtuZPoAtfzhJqofBFRw0Ja2rYcaHjyIzvUqJepLHftRWejhTCi7
	 7mYjL4x6/UKqtObX8vFne7UyeUsxwmH9kMiLaiytuLcU7SAD6A57bGjjRAnm/zkCYV
	 E5AiIDdcwHh9/neDAvVdKZRjWYv+bOyr5fzq2HnsrYfz53nBesSsTtOeppxEcP7I92
	 NEL/SmFm7I9lIC2pAqQHbLZLV1bpcxXBi9Me1fhbWTCzZ4Lg5gipR+H4hloN67vUFa
	 elazlXFWW9NRXMqfdunTtuoUv49POvb4WBCrslzIUAMM8IfyFf6XhPZFDERn3ZHBOK
	 kAZ7DFE7et2gA==
From: Dinh Nguyen <dinguyen@kernel.org>
To: netdev@vger.kernel.org
Cc: dinguyen@kernel.org,
	kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	joabreu@synopsys.com,
	pabeni@redhat.com,
	robh+dt@kernel.org,
	krzysztof.kozlowskii+dt@linaro.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH 2/2] net: dwmac_socfpga: use the standard "ahb" reset
Date: Mon, 10 Jul 2023 16:13:13 -0500
Message-Id: <20230710211313.567761-2-dinguyen@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230710211313.567761-1-dinguyen@kernel.org>
References: <20230710211313.567761-1-dinguyen@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "stmmaceth-ocp" reset line of stmmac controller on the SoCFPGA
platform is essentially the "ahb" reset on the standard stmmac controller.

Because of commit ("e67f325e9cd6 net: stmmac: explicitly deassert
GMAC_AHB_RESET") adds the support for getting the 'ahb' reset, the
SoCFPGA dwmac driver no longer need to get the stmmaceth-ocp reset.

Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
 .../ethernet/stmicro/stmmac/dwmac-socfpga.c   | 20 ++++++-------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
index 6267bcb60206..a4b8b86129f4 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
@@ -52,7 +52,7 @@ struct socfpga_dwmac {
 	struct	device *dev;
 	struct regmap *sys_mgr_base_addr;
 	struct reset_control *stmmac_rst;
-	struct reset_control *stmmac_ocp_rst;
+	struct reset_control *stmmac_ahb_rst;
 	void __iomem *splitter_base;
 	void __iomem *tse_pcs_base;
 	void __iomem *sgmii_adapter_base;
@@ -290,7 +290,7 @@ static int socfpga_gen5_set_phy_mode(struct socfpga_dwmac *dwmac)
 		val = SYSMGR_EMACGRP_CTRL_PHYSEL_ENUM_GMII_MII;
 
 	/* Assert reset to the enet controller before changing the phy mode */
-	reset_control_assert(dwmac->stmmac_ocp_rst);
+	reset_control_assert(dwmac->stmmac_ahb_rst);
 	reset_control_assert(dwmac->stmmac_rst);
 
 	regmap_read(sys_mgr_base_addr, reg_offset, &ctrl);
@@ -319,7 +319,7 @@ static int socfpga_gen5_set_phy_mode(struct socfpga_dwmac *dwmac)
 	/* Deassert reset for the phy configuration to be sampled by
 	 * the enet controller, and operation to start in requested mode
 	 */
-	reset_control_deassert(dwmac->stmmac_ocp_rst);
+	reset_control_deassert(dwmac->stmmac_ahb_rst);
 	reset_control_deassert(dwmac->stmmac_rst);
 	if (phymode == PHY_INTERFACE_MODE_SGMII)
 		socfpga_sgmii_config(dwmac, true);
@@ -346,7 +346,7 @@ static int socfpga_gen10_set_phy_mode(struct socfpga_dwmac *dwmac)
 		val = SYSMGR_EMACGRP_CTRL_PHYSEL_ENUM_GMII_MII;
 
 	/* Assert reset to the enet controller before changing the phy mode */
-	reset_control_assert(dwmac->stmmac_ocp_rst);
+	reset_control_assert(dwmac->stmmac_ahb_rst);
 	reset_control_assert(dwmac->stmmac_rst);
 
 	regmap_read(sys_mgr_base_addr, reg_offset, &ctrl);
@@ -372,7 +372,7 @@ static int socfpga_gen10_set_phy_mode(struct socfpga_dwmac *dwmac)
 	/* Deassert reset for the phy configuration to be sampled by
 	 * the enet controller, and operation to start in requested mode
 	 */
-	reset_control_deassert(dwmac->stmmac_ocp_rst);
+	reset_control_deassert(dwmac->stmmac_ahb_rst);
 	reset_control_deassert(dwmac->stmmac_rst);
 	if (phymode == PHY_INTERFACE_MODE_SGMII)
 		socfpga_sgmii_config(dwmac, true);
@@ -410,15 +410,6 @@ static int socfpga_dwmac_probe(struct platform_device *pdev)
 		goto err_remove_config_dt;
 	}
 
-	dwmac->stmmac_ocp_rst = devm_reset_control_get_optional(dev, "stmmaceth-ocp");
-	if (IS_ERR(dwmac->stmmac_ocp_rst)) {
-		ret = PTR_ERR(dwmac->stmmac_ocp_rst);
-		dev_err(dev, "error getting reset control of ocp %d\n", ret);
-		goto err_remove_config_dt;
-	}
-
-	reset_control_deassert(dwmac->stmmac_ocp_rst);
-
 	ret = socfpga_dwmac_parse_data(dwmac, dev);
 	if (ret) {
 		dev_err(dev, "Unable to parse OF data\n");
@@ -441,6 +432,7 @@ static int socfpga_dwmac_probe(struct platform_device *pdev)
 	 * the driver later.
 	 */
 	dwmac->stmmac_rst = stpriv->plat->stmmac_rst;
+	dwmac->stmmac_ahb_rst = stpriv->plat->stmmac_ahb_rst;
 
 	ret = ops->set_phy_mode(dwmac);
 	if (ret)
-- 
2.25.1


