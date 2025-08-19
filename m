Return-Path: <netdev+bounces-214888-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8AA6B2B9F5
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 08:56:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3D793A9BF0
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 06:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92EF6278146;
	Tue, 19 Aug 2025 06:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OM7sBsBD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5DC52F66;
	Tue, 19 Aug 2025 06:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755586595; cv=none; b=rrZJIVcRWhygIlKykzbxgSaBmFfxiLURF8hrJ3LtOY1cZCe4ydQHtaGiUyaWO0KRI8/CqrOwtcgkvLtOp3hAF8SsFwim1BGJHU2xz0t1v2b/3+TaVoK0iFDTjsfags4zbs2GH5l4umBxHw6m4aD31wv0PXenduhtnxizwqCcRyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755586595; c=relaxed/simple;
	bh=Zp8/D0QqwNUeSXX/OtnER595OeyW1wBAI56ORCb4OX4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ghZIOXX/AOrcwXyU+newlMdD4JziB8Tby194IdV2IAKa2+6NIWxawTn16cQ5//b3A15Zj5Bq4r92cYrpPb1x3iCbPsYSfEGXXyhKTHT8n1Z4IksUO/MN9p9ti/qOZDPNZJjqm7JUtHwxfIKBsx3ga8gtiA/caok6PX6QCnXmfBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OM7sBsBD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16E4FC116B1;
	Tue, 19 Aug 2025 06:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755586595;
	bh=Zp8/D0QqwNUeSXX/OtnER595OeyW1wBAI56ORCb4OX4=;
	h=From:To:Cc:Subject:Date:From;
	b=OM7sBsBDXlRp4StY81EhppkdOvvnuTp6LZHK9iXyBRsuAhUeuNWJfoew835h+3K3D
	 D1nTVyFQ5Nzw5OcGxCY1Ws38OJIBbiF0OULZAkqogww4M38N0XqJH8uVjvjO6193fk
	 sch6ocKvEpEo5770sYnqrGJ1AiK9K1+hRwTm0Nucmz4k+J4jQbgInHFHhE1+o5S0Am
	 nuKbzX6pxlIPgrRLK4zw9FiCcongp/y08vAb8nmiNewrhJmD2ZQJmiZK8OsZI+1Pj7
	 GsCxFG/Q7y9KkCs9w3YPxmZM9lfe3Ko7HzHzPvtTQOt8Nbx2iPBQzW7xD/SCTiNE+U
	 vwBk9BT+5nlmA==
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
Subject: [PATCH v3] phy: ti: gmii-sel: Always write the RGMII ID setting
Date: Tue, 19 Aug 2025 08:56:22 +0200
Message-Id: <20250819065622.1019537-1-mwalle@kernel.org>
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
fly assuming that the TX delay setting is fixed. In reality, the TX
delay is configurable and just skipped in the documentation. There are
bootloaders, which will disable the TX delay and this will lead to a
transmit path which doesn't add any delays at all.
Fix that by always writing the RGMII_ID setting and report an error for
unsupported RGMII delay modes.

This is safe to do and shouldn't break any boards in mainline because
the fixed delay is only introduced for gmii-sel compatibles which are
used together with the am65-cpsw-nuss driver and also contains the
commit above.

Fixes: ca13b249f291 ("net: ethernet: ti: am65-cpsw: fixup PHY mode for fixed RGMII TX delay")
Signed-off-by: Michael Walle <mwalle@kernel.org>
---
v3:
 - simplify the logic. Thanks Matthias.
 - reworded the commit message

v2:
 - reject invalid PHY modes. Thanks Matthias.
 - add a paragraph to the commit message that this patch shouldn't
   break any existing boards. Thanks Andrew.

 drivers/phy/ti/phy-gmii-sel.c | 47 +++++++++++++++++++++++++++++------
 1 file changed, 39 insertions(+), 8 deletions(-)

diff --git a/drivers/phy/ti/phy-gmii-sel.c b/drivers/phy/ti/phy-gmii-sel.c
index ff5d5e29629f..50adabb867cb 100644
--- a/drivers/phy/ti/phy-gmii-sel.c
+++ b/drivers/phy/ti/phy-gmii-sel.c
@@ -34,6 +34,7 @@ enum {
 	PHY_GMII_SEL_PORT_MODE = 0,
 	PHY_GMII_SEL_RGMII_ID_MODE,
 	PHY_GMII_SEL_RMII_IO_CLK_EN,
+	PHY_GMII_SEL_FIXED_TX_DELAY,
 	PHY_GMII_SEL_LAST,
 };
 
@@ -127,6 +128,11 @@ static int phy_gmii_sel_mode(struct phy *phy, enum phy_mode mode, int submode)
 		goto unsupported;
 	}
 
+	/* With a fixed delay, some modes are not supported at all. */
+	if (soc_data->features & BIT(PHY_GMII_SEL_FIXED_TX_DELAY) &&
+	    rgmii_id != 0)
+		return -EINVAL;
+
 	if_phy->phy_if_mode = submode;
 
 	dev_dbg(dev, "%s id:%u mode:%u rgmii_id:%d rmii_clk_ext:%d\n",
@@ -210,25 +216,46 @@ struct phy_gmii_sel_soc_data phy_gmii_sel_soc_dm814 = {
 
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
@@ -239,6 +266,8 @@ struct phy_gmii_sel_soc_data phy_gmii_sel_cpsw5g_soc_j7200 = {
 static const
 struct phy_gmii_sel_soc_data phy_gmii_sel_cpsw9g_soc_j721e = {
 	.use_of_data = true,
+	.features = BIT(PHY_GMII_SEL_RGMII_ID_MODE) |
+		    BIT(PHY_GMII_SEL_FIXED_TX_DELAY),
 	.regfields = phy_gmii_sel_fields_am654,
 	.extra_modes = BIT(PHY_INTERFACE_MODE_QSGMII) | BIT(PHY_INTERFACE_MODE_SGMII),
 	.num_ports = 8,
@@ -248,6 +277,8 @@ struct phy_gmii_sel_soc_data phy_gmii_sel_cpsw9g_soc_j721e = {
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


