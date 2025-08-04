Return-Path: <netdev+bounces-211587-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8A26B1A413
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 16:07:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2FB87A7AFC
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 14:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A436E26E146;
	Mon,  4 Aug 2025 14:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HVsKZFNL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC688F58;
	Mon,  4 Aug 2025 14:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754316423; cv=none; b=Gq0RFUlEZmsnvbh/xEZZaLx5EVXzZJEV8BPAkbSOny7Ia+FWtYEU6w92MIoJgmuouwpdTU56/wqgxE027GW9b/D6UPE0oRSTG0sEuzhs2xRFH+hiQd/eBScbXNa/rvzlFg9PHxaIynEtgd86k6R8Ksv0pAGEqrdaIuYXhPTRibU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754316423; c=relaxed/simple;
	bh=g4R8Y73hb4BzJAzzDJSVFxqOj3sFPPyhtqJp7GLNKqA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=j2070AtisfgZyu3SPrAtkL4arykInPVgFm3rDI37GIyir+AcmPR1LdCHKuCmJjtTzIlGx2Ld8FGrEAHP16xK8nF2ckANjh9O6hGypTU5h0Q0psDuwBkvg/lfBBzXFMLVBzylidFLD4fep4BCRSw3I0jUPeu5rOp3JZ0Lt9Aaatk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HVsKZFNL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1D70C4CEE7;
	Mon,  4 Aug 2025 14:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754316423;
	bh=g4R8Y73hb4BzJAzzDJSVFxqOj3sFPPyhtqJp7GLNKqA=;
	h=From:To:Cc:Subject:Date:From;
	b=HVsKZFNL8augUOA5FqoPeyp2uE6lxeZwLHClECoWoBhbq9F+yveLuSe4YauCVUVPZ
	 kiMkC1vWPVzu2USw8EfOBAl+Xr+L6PLxq5JQpXsLgtbW83Z2Y6Cny4uOPdmJhQ5GH5
	 PVSBL9Ol4R6NJR9AFbdc/pQr1HlEsU9azz26yJWqldNWPGdOq8ba2VFg5VUehzrnlm
	 +BH922GbqJBAWjymt7ypwqVf4yyWiS88ENQOX7iD62k9KQPKJ66Zz5CX3irxPl6yTP
	 fBrbAmkV6obtx7OyP2Ep/Zzt9ZhKjE4gTMxcagUcIoxN5HNEaWcaOPkknGEhM4cmNC
	 wTp79soAE95fA==
From: Michael Walle <mwalle@kernel.org>
To: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>,
	Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
	Andrew Lunn <andrew@lunn.ch>,
	linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	nm@ti.com,
	vigneshr@ti.com,
	Michael Walle <mwalle@kernel.org>
Subject: [PATCH] phy: ti: gmii-sel: Force RGMII TX delay
Date: Mon,  4 Aug 2025 16:06:52 +0200
Message-Id: <20250804140652.539589-1-mwalle@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some SoCs are just validated with the TX delay enabled. With commit
ca13b249f291 ("net: ethernet: ti: am65-cpsw: fixup PHY mode for fixed
RGMII TX delay"), the network driver will patch the delay setting on the
fly assuming that the TX delay is fixed. In reality, the TX delay is
configurable and just skipped in the documentation. There are
bootloaders, which will disable the TX delay and this will lead to a
transmit path which doesn't add any delays at all. Fix that by always
forcing the TX delay to be enabled.

Fixes: ca13b249f291 ("net: ethernet: ti: am65-cpsw: fixup PHY mode for fixed RGMII TX delay")
Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 drivers/phy/ti/phy-gmii-sel.c | 52 +++++++++++++++++++++++++++++------
 1 file changed, 44 insertions(+), 8 deletions(-)

diff --git a/drivers/phy/ti/phy-gmii-sel.c b/drivers/phy/ti/phy-gmii-sel.c
index ff5d5e29629f..a0c19d00ff3a 100644
--- a/drivers/phy/ti/phy-gmii-sel.c
+++ b/drivers/phy/ti/phy-gmii-sel.c
@@ -34,6 +34,7 @@ enum {
 	PHY_GMII_SEL_PORT_MODE = 0,
 	PHY_GMII_SEL_RGMII_ID_MODE,
 	PHY_GMII_SEL_RMII_IO_CLK_EN,
+	PHY_GMII_SEL_FIXED_TX_DELAY,
 	PHY_GMII_SEL_LAST,
 };
 
@@ -127,6 +128,16 @@ static int phy_gmii_sel_mode(struct phy *phy, enum phy_mode mode, int submode)
 		goto unsupported;
 	}
 
+	/*
+	 * Some SoCs only support fixed MAC side TX delays. According to the
+	 * datasheet, they are always enabled, but that turns out not to be the
+	 * case and the delay is configurable. But according to the vendor that
+	 * mode is not validated and might not work. Some bootloaders disable
+	 * that bit. To work around that enable it again.
+	 */
+	if (soc_data->features & BIT(PHY_GMII_SEL_FIXED_TX_DELAY))
+		rgmii_id = 0;
+
 	if_phy->phy_if_mode = submode;
 
 	dev_dbg(dev, "%s id:%u mode:%u rgmii_id:%d rmii_clk_ext:%d\n",
@@ -210,25 +221,46 @@ struct phy_gmii_sel_soc_data phy_gmii_sel_soc_dm814 = {
 
 static const
 struct reg_field phy_gmii_sel_fields_am654[][PHY_GMII_SEL_LAST] = {
-	{ [PHY_GMII_SEL_PORT_MODE] = REG_FIELD(0x0, 0, 2), },
-	{ [PHY_GMII_SEL_PORT_MODE] = REG_FIELD(0x4, 0, 2), },
-	{ [PHY_GMII_SEL_PORT_MODE] = REG_FIELD(0x8, 0, 2), },
-	{ [PHY_GMII_SEL_PORT_MODE] = REG_FIELD(0xC, 0, 2), },
-	{ [PHY_GMII_SEL_PORT_MODE] = REG_FIELD(0x10, 0, 2), },
-	{ [PHY_GMII_SEL_PORT_MODE] = REG_FIELD(0x14, 0, 2), },
-	{ [PHY_GMII_SEL_PORT_MODE] = REG_FIELD(0x18, 0, 2), },
-	{ [PHY_GMII_SEL_PORT_MODE] = REG_FIELD(0x1C, 0, 2), },
+	{
+		[PHY_GMII_SEL_PORT_MODE] = REG_FIELD(0x0, 0, 2),
+		[PHY_GMII_SEL_RGMII_ID_MODE] = REG_FIELD(0x0, 4, 4),
+	}, {
+		[PHY_GMII_SEL_PORT_MODE] = REG_FIELD(0x4, 0, 2),
+		[PHY_GMII_SEL_RGMII_ID_MODE] = REG_FIELD(0x4, 4, 4),
+	}, {
+		[PHY_GMII_SEL_PORT_MODE] = REG_FIELD(0x8, 0, 2),
+		[PHY_GMII_SEL_RGMII_ID_MODE] = REG_FIELD(0x8, 4, 4),
+	}, {
+		[PHY_GMII_SEL_PORT_MODE] = REG_FIELD(0xC, 0, 2),
+		[PHY_GMII_SEL_RGMII_ID_MODE] = REG_FIELD(0xC, 4, 4),
+	}, {
+		[PHY_GMII_SEL_PORT_MODE] = REG_FIELD(0x10, 0, 2),
+		[PHY_GMII_SEL_RGMII_ID_MODE] = REG_FIELD(0x10, 4, 4),
+	}, {
+		[PHY_GMII_SEL_PORT_MODE] = REG_FIELD(0x14, 0, 2),
+		[PHY_GMII_SEL_RGMII_ID_MODE] = REG_FIELD(0x14, 4, 4),
+	}, {
+		[PHY_GMII_SEL_PORT_MODE] = REG_FIELD(0x18, 0, 2),
+		[PHY_GMII_SEL_RGMII_ID_MODE] = REG_FIELD(0x18, 4, 4),
+	}, {
+		[PHY_GMII_SEL_PORT_MODE] = REG_FIELD(0x1C, 0, 2),
+		[PHY_GMII_SEL_RGMII_ID_MODE] = REG_FIELD(0x1C, 4, 4),
+	},
 };
 
 static const
 struct phy_gmii_sel_soc_data phy_gmii_sel_soc_am654 = {
 	.use_of_data = true,
+	.features = BIT(PHY_GMII_SEL_RGMII_ID_MODE) |
+		    BIT(PHY_GMII_SEL_FIXED_TX_DELAY),
 	.regfields = phy_gmii_sel_fields_am654,
 };
 
 static const
 struct phy_gmii_sel_soc_data phy_gmii_sel_cpsw5g_soc_j7200 = {
 	.use_of_data = true,
+	.features = BIT(PHY_GMII_SEL_RGMII_ID_MODE) |
+		    BIT(PHY_GMII_SEL_FIXED_TX_DELAY),
 	.regfields = phy_gmii_sel_fields_am654,
 	.extra_modes = BIT(PHY_INTERFACE_MODE_QSGMII) | BIT(PHY_INTERFACE_MODE_SGMII) |
 		       BIT(PHY_INTERFACE_MODE_USXGMII),
@@ -239,6 +271,8 @@ struct phy_gmii_sel_soc_data phy_gmii_sel_cpsw5g_soc_j7200 = {
 static const
 struct phy_gmii_sel_soc_data phy_gmii_sel_cpsw9g_soc_j721e = {
 	.use_of_data = true,
+	.features = BIT(PHY_GMII_SEL_RGMII_ID_MODE) |
+		    BIT(PHY_GMII_SEL_FIXED_TX_DELAY),
 	.regfields = phy_gmii_sel_fields_am654,
 	.extra_modes = BIT(PHY_INTERFACE_MODE_QSGMII) | BIT(PHY_INTERFACE_MODE_SGMII),
 	.num_ports = 8,
@@ -248,6 +282,8 @@ struct phy_gmii_sel_soc_data phy_gmii_sel_cpsw9g_soc_j721e = {
 static const
 struct phy_gmii_sel_soc_data phy_gmii_sel_cpsw9g_soc_j784s4 = {
 	.use_of_data = true,
+	.features = BIT(PHY_GMII_SEL_RGMII_ID_MODE) |
+		    BIT(PHY_GMII_SEL_FIXED_TX_DELAY),
 	.regfields = phy_gmii_sel_fields_am654,
 	.extra_modes = BIT(PHY_INTERFACE_MODE_QSGMII) | BIT(PHY_INTERFACE_MODE_SGMII) |
 		       BIT(PHY_INTERFACE_MODE_USXGMII),
-- 
2.39.5


