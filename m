Return-Path: <netdev+bounces-129008-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C54597CEA2
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 23:01:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EDAD284B99
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 21:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD3D14A4D2;
	Thu, 19 Sep 2024 21:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="rZyLU8DO"
X-Original-To: netdev@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940451428FA
	for <netdev@vger.kernel.org>; Thu, 19 Sep 2024 21:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726779706; cv=none; b=qoFS3JlKCTUfs6fncMOPikZMpDntNoN5qSyqfL8/+CgLHGdjyjBoqvnkQzqrncb9j+fFUxv4dKpzc0REaOQ3OAoe2Ak8ZQ9pG4GcElu1BFQiiKA/6s8SgJlasvp7Ptemq+AF24rpsuRBxnBKfz1ffvVHX0Nr3iKg2JVLKsw29i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726779706; c=relaxed/simple;
	bh=7n3q8FyUSTjBIqV2TIkh0EY9yJu4YCt94AZ0u6gmM3o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N9gdMSe8BDEcLVJqK1lb95n/0sn1bVTx8r0w194p6siluJ8AscruxOXHIMG5ppOQ0ZanH/klre2FRFzQCmrUN9SnMA+3QhygC4HW8AwZrwwTrfg6HWz4nFbpYXdd8VrfRIautRcRYhOJ0L0H86hpOvPlJiew7C0wHcO3UWdTIdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=rZyLU8DO; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 48JL1Yn3000591;
	Thu, 19 Sep 2024 16:01:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1726779694;
	bh=r3qz/A9j1DhsT6fGRSjAmVB+5Fl637C59pftBlZJYg4=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=rZyLU8DOauN3wqXb9IV/gmmhHXEYVj+s8Nh/mAoM0SNqwW0gk5YNozl2PVA3awU4F
	 lPZ12kFrA+ASN5S9AioVfeq8TtUQrL/Lj+UgwVXEcOWYwEuJhMdawZPWHhbTTPdBFw
	 g7ptevumdnots+sINha9AR/MmaqTiyEwJyrZC5U8=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 48JL1YOR071112
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 19 Sep 2024 16:01:34 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 19
 Sep 2024 16:01:33 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 19 Sep 2024 16:01:34 -0500
Received: from Linux-002.dhcp.ti.com (linux-002.dhcp.ti.com [10.188.34.182])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 48JL1OC8098001;
	Thu, 19 Sep 2024 16:01:33 -0500
From: "Alvaro (Al-vuh-roe) Reyes" <a-reyes1@ti.com>
To: <netdev@vger.kernel.org>
CC: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
        <maxime.chevallier@bootlin.com>, <o.rempel@pengutronix.de>,
        <spatton@ti.com>, <r-kommineni@ti.com>, <e-mayhew@ti.com>,
        <praneeth@ti.com>, <p-varis@ti.com>, <d-qiu@ti.com>,
        "Alvaro (Al-vuh-roe) Reyes" <a-reyes1@ti.com>
Subject: [PATCH 4/5] net: phy: dp83tg720: Added OA script
Date: Thu, 19 Sep 2024 14:01:18 -0700
Message-ID: <c41bc533471bab570be58bca3eae057554a56389.1726263095.git.a-reyes1@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1726263095.git.a-reyes1@ti.com>
References: <cover.1726263095.git.a-reyes1@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

For the DP83TG720 & DP83TG721 to function properly, both need an
initialization script to be run at boot up. The init script and a chip_init
function have been added to handle this condition. 

Signed-off-by: Alvaro (Al-vuh-roe) Reyes <a-reyes1@ti.com>
---
 drivers/net/phy/dp83tg720.c | 355 ++++++++++++++++++++++++++++++++----
 1 file changed, 324 insertions(+), 31 deletions(-)

diff --git a/drivers/net/phy/dp83tg720.c b/drivers/net/phy/dp83tg720.c
index b70802818f3c..4df6713c51e3 100644
--- a/drivers/net/phy/dp83tg720.c
+++ b/drivers/net/phy/dp83tg720.c
@@ -31,8 +31,9 @@
 /* 1b = TDR fail, 0b = TDR success */
 #define DP83TG720_TDR_FAIL				BIT(0)
 
-#define DP83TG720_PHY_RESET				0x1f
-#define DP83TG720_HW_RESET				BIT(15)
+#define DP83TG720_PHY_RESET_CTRL		0x1f
+#define DP83TG720_HW_RESET			    BIT(15)
+#define DP83TG720_SW_RESET              BIT(14)
 
 #define DP83TG720_LPS_CFG3				0x18c
 /* Power modes are documented as bit fields but used as values */
@@ -100,6 +101,221 @@ struct DP83TG720_private {
 	bool tx_shift;
 };
 
+struct DP83TG720_init_reg {
+	int MMD;
+	int reg;
+	int val;
+};
+
+/*Refer to SNLA371 for more information*/
+static const struct DP83TG720_init_reg DP83TG720_cs1_1_master_init[] = {
+	{0x1F, 0x001F, 0X8000},
+	{0x1F, 0x0573, 0x0101},
+	{0x1, 0x0834, 0xC001},
+	{0x1F, 0x0405, 0x5800},
+	{0x1F, 0x08AD, 0x3C51},
+	{0x1F, 0x0894, 0x5DF7},
+	{0x1F, 0x08A0, 0x09E7},
+	{0x1F, 0x08C0, 0x4000},
+	{0x1F, 0x0814, 0x4800},
+	{0x1F, 0x080D, 0x2EBF},
+	{0x1F, 0x08C1, 0x0B00},
+	{0x1F, 0x087D, 0x0001},
+	{0x1F, 0x082E, 0x0000},
+	{0x1F, 0x0837, 0x00F4},
+	{0x1F, 0x08BE, 0x0200},
+	{0x1F, 0x08C5, 0x4000},
+	{0x1F, 0x08C7, 0x2000},
+	{0x1F, 0x08B3, 0x005A},
+	{0x1F, 0x08B4, 0x005A},
+	{0x1F, 0x08B0, 0x0202},
+	{0x1F, 0x08B5, 0x00EA},
+	{0x1F, 0x08BA, 0x2828},
+	{0x1F, 0x08BB, 0x6828},
+	{0x1F, 0x08BC, 0x0028},
+	{0x1F, 0x08BF, 0x0000},
+	{0x1F, 0x08B1, 0x0014},
+	{0x1F, 0x08B2, 0x0008},
+	{0x1F, 0x08EC, 0x0000},
+	{0x1F, 0x08C8, 0x0003},
+	{0x1F, 0x08BE, 0x0201},
+	{0x1F, 0x018C, 0x0001},
+	{0x1F, 0x001F, 0x4000},
+	{0x1F, 0x0573, 0x0001},
+	{0x1F, 0x056A, 0x5F41},
+};
+
+/*Refer to SNLA371 for more information*/
+static const struct DP83TG720_init_reg DP83TG720_cs1_1_slave_init[] = {
+	{0x1F, 0x001F, 0x8000},
+	{0x1F, 0x0573, 0x0101},
+	{0x1, 0x0834, 0x8001},
+	{0x1F, 0x0894, 0x5DF7},
+	{0x1F, 0x056a, 0x5F40},
+	{0x1F, 0x0405, 0x5800},
+	{0x1F, 0x08AD, 0x3C51},
+	{0x1F, 0x0894, 0x5DF7},
+	{0x1F, 0x08A0, 0x09E7},
+	{0x1F, 0x08C0, 0x4000},
+	{0x1F, 0x0814, 0x4800},
+	{0x1F, 0x080D, 0x2EBF},
+	{0x1F, 0x08C1, 0x0B00},
+	{0x1F, 0x087d, 0x0001},
+	{0x1F, 0x082E, 0x0000},
+	{0x1F, 0x0837, 0x00f4},
+	{0x1F, 0x08BE, 0x0200},
+	{0x1F, 0x08C5, 0x4000},
+	{0x1F, 0x08C7, 0x2000},
+	{0x1F, 0x08B3, 0x005A},
+	{0x1F, 0x08B4, 0x005A},
+	{0x1F, 0x08B0, 0x0202},
+	{0x1F, 0x08B5, 0x00EA},
+	{0x1F, 0x08BA, 0x2828},
+	{0x1F, 0x08BB, 0x6828},
+	{0x1F, 0x08BC, 0x0028},
+	{0x1F, 0x08BF, 0x0000},
+	{0x1F, 0x08B1, 0x0014},
+	{0x1F, 0x08B2, 0x0008},
+	{0x1F, 0x08EC, 0x0000},
+	{0x1F, 0x08C8, 0x0003},
+	{0x1F, 0x08BE, 0x0201},
+	{0x1F, 0x056A, 0x5F40},
+	{0x1F, 0x018C, 0x0001},
+	{0x1F, 0x001F, 0x4000},
+	{0x1F, 0x0573, 0x0001},
+	{0x1F, 0x056A, 0X5F41},
+};
+
+/*Refer to SNLA371 for more information*/
+static const struct DP83TG720_init_reg DP83TG721_cs1_master_init[] = {
+	{0x1F, 0x001F, 0x8000},
+	{0x1F, 0x0573, 0x0801},
+	{0x1, 0x0834, 0xC001},
+	{0x1F, 0x0405, 0x6C00},
+	{0x1F, 0x08AD, 0x3C51},
+	{0x1F, 0x0894, 0x5DF7},
+	{0x1F, 0x08A0, 0x09E7},
+	{0x1F, 0x08C0, 0x4000},
+	{0x1F, 0x0814, 0x4800},
+	{0x1F, 0x080D, 0x2EBF},
+	{0x1F, 0x08C1, 0x0B00},
+	{0x1F, 0x087D, 0x0001},
+	{0x1F, 0x082E, 0x0000},
+	{0x1F, 0x0837, 0x00F8},
+	{0x1F, 0x08BE, 0x0200},
+	{0x1F, 0x08C5, 0x4000},
+	{0x1F, 0x08C7, 0x2000},
+	{0x1F, 0x08B3, 0x005A},
+	{0x1F, 0x08B4, 0x005A},
+	{0x1F, 0x08B0, 0x0202},
+	{0x1F, 0x08B5, 0x00EA},
+	{0x1F, 0x08BA, 0x2828},
+	{0x1F, 0x08BB, 0x6828},
+	{0x1F, 0x08BC, 0x0028},
+	{0x1F, 0x08BF, 0x0000},
+	{0x1F, 0x08B1, 0x0014},
+	{0x1F, 0x08B2, 0x0008},
+	{0x1F, 0x08EC, 0x0000},
+	{0x1F, 0x08FC, 0x0091},
+	{0x1F, 0x08BE, 0x0201},
+	{0x1F, 0x0335, 0x0010},
+	{0x1F, 0x0336, 0x0009},
+	{0x1F, 0x0337, 0x0208},
+	{0x1F, 0x0338, 0x0208},
+	{0x1F, 0x0339, 0x02CB},
+	{0x1F, 0x033A, 0x0208},
+	{0x1F, 0x033B, 0x0109},
+	{0x1F, 0x0418, 0x0380},
+	{0x1F, 0x0420, 0xFF10},
+	{0x1F, 0x0421, 0x4033},
+	{0x1F, 0x0422, 0x0800},
+	{0x1F, 0x0423, 0x0002},
+	{0x1F, 0x0484, 0x0003},
+	{0x1F, 0x055D, 0x0008},
+	{0x1F, 0x042B, 0x0018},
+	{0x1F, 0x087C, 0x0080},
+	{0x1F, 0x08C1, 0x0900},
+	{0x1F, 0x08fc, 0x4091},
+	{0x1F, 0x0881, 0x5146},
+	{0x1F, 0x08be, 0x02a1},
+	{0x1F, 0x0867, 0x9999},
+	{0x1F, 0x0869, 0x9666},
+	{0x1F, 0x086a, 0x0009},
+	{0x1F, 0x0822, 0x11e1},
+	{0x1F, 0x08f9, 0x1f11},
+	{0x1F, 0x08a3, 0x24e8},
+	{0x1F, 0x018C, 0x0001},
+	{0x1F, 0x001F, 0x4000},
+	{0x1F, 0x0573, 0x0001},
+	{0x1F, 0x056A, 0x5F41},
+};
+
+/*Refer to SNLA371 for more information*/
+static const struct DP83TG720_init_reg DP83TG721_cs1_slave_init[] = {
+	{0x1F, 0x001F, 0x8000},
+	{0x1F, 0x0573, 0x0801},
+	{0x1, 0x0834, 0x8001},
+	{0x1F, 0x0405, 0X6C00},
+	{0x1F, 0x08AD, 0x3C51},
+	{0x1F, 0x0894, 0x5DF7},
+	{0x1F, 0x08A0, 0x09E7},
+	{0x1F, 0x08C0, 0x4000},
+	{0x1F, 0x0814, 0x4800},
+	{0x1F, 0x080D, 0x2EBF},
+	{0x1F, 0x08C1, 0x0B00},
+	{0x1F, 0x087D, 0x0001},
+	{0x1F, 0x082E, 0x0000},
+	{0x1F, 0x0837, 0x00F8},
+	{0x1F, 0x08BE, 0x0200},
+	{0x1F, 0x08C5, 0x4000},
+	{0x1F, 0x08C7, 0x2000},
+	{0x1F, 0x08B3, 0x005A},
+	{0x1F, 0x08B4, 0x005A},
+	{0x1F, 0x08B0, 0x0202},
+	{0x1F, 0x08B5, 0x00EA},
+	{0x1F, 0x08BA, 0x2828},
+	{0x1F, 0x08BB, 0x6828},
+	{0x1F, 0x08BC, 0x0028},
+	{0x1F, 0x08BF, 0x0000},
+	{0x1F, 0x08B1, 0x0014},
+	{0x1F, 0x08B2, 0x0008},
+	{0x1F, 0x08EC, 0x0000},
+	{0x1F, 0x08FC, 0x0091},
+	{0x1F, 0x08BE, 0x0201},
+	{0x1F, 0x0456, 0x0160},
+	{0x1F, 0x0335, 0x0010},
+	{0x1F, 0x0336, 0x0009},
+	{0x1F, 0x0337, 0x0208},
+	{0x1F, 0x0338, 0x0208},
+	{0x1F, 0x0339, 0x02CB},
+	{0x1F, 0x033A, 0x0208},
+	{0x1F, 0x033B, 0x0109},
+	{0x1F, 0x0418, 0x0380},
+	{0x1F, 0x0420, 0xFF10},
+	{0x1F, 0x0421, 0x4033},
+	{0x1F, 0x0422, 0x0800},
+	{0x1F, 0x0423, 0x0002},
+	{0x1F, 0x0484, 0x0003},
+	{0x1F, 0x055D, 0x0008},
+	{0x1F, 0x042B, 0x0018},
+	{0x1F, 0x082D, 0x120F},
+	{0x1F, 0x0888, 0x0438},
+	{0x1F, 0x0824, 0x09E0},
+	{0x1F, 0x0883, 0x5146},
+	{0x1F, 0x08BE, 0x02A1},
+	{0x1F, 0x0822, 0x11E1},
+	{0x1F, 0x056A, 0x5F40},
+	{0x1F, 0x08C1, 0x0900},
+	{0x1F, 0x08FC, 0x4091},
+	{0x1F, 0x08F9, 0x1F11},
+	{0x1F, 0x084F, 0x290C},
+	{0x1F, 0x0850, 0x3D33},
+	{0x1F, 0x018C, 0x0001},
+	{0x1F, 0x001F, 0x4000},
+	{0x1F, 0x0573, 0x0001},
+	{0x1F, 0x056A, 0x5F41},
+};
+
 static int dp83tg720_read_straps(struct phy_device *phydev)
 {
 	struct DP83TG720_private *DP83TG720 = phydev->priv;
@@ -127,6 +343,55 @@ static int dp83tg720_read_straps(struct phy_device *phydev)
 	return 0;
 };
 
+static int dp83tg720_reset(struct phy_device *phydev, bool hw_reset)
+{
+	int ret;
+
+	if (hw_reset)
+		ret = phy_write_mmd(phydev, MMD1F, DP83TG720_PHY_RESET_CTRL,
+				DP83TG720_HW_RESET);
+	else
+		ret = phy_write_mmd(phydev, MMD1F, DP83TG720_PHY_RESET_CTRL,
+				DP83TG720_SW_RESET);
+	if (ret)
+		return ret;
+
+	mdelay(100);
+
+	return 0;
+}
+
+static int dp83tg720_phy_reset(struct phy_device *phydev)
+{
+	int ret;
+
+	ret = dp83tg720_reset(phydev, false);
+	if (ret)
+		return ret;
+
+	ret = dp83tg720_read_straps(phydev);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int DP83TG720_write_seq(struct phy_device *phydev,
+			     const struct DP83TG720_init_reg *init_data, int size)
+{
+	int ret;
+	int i;
+
+	for (i = 0; i < size; i++) {
+			ret = phy_write_mmd(phydev, init_data[i].MMD, init_data[i].reg,
+				init_data[i].val);
+			if (ret)
+					return ret;
+	}
+
+	return 0;
+}
+
 /**
  * dp83tg720_cable_test_start - Start the cable test for the DP83TG720 PHY.
  * @phydev: Pointer to the phy_device structure.
@@ -362,6 +627,61 @@ static int dp83tg720_config_rgmii_delay(struct phy_device *phydev)
 			      rgmii_delay);
 }
 
+static int dp83tg720_chip_init(struct phy_device *phydev)
+{
+	struct DP83TG720_private *DP83TG720 = phydev->priv;
+	int ret;
+
+	ret = dp83tg720_reset(phydev, true);
+	if (ret)
+		return ret;
+	
+	phydev->autoneg = AUTONEG_DISABLE;
+    phydev->speed = SPEED_1000;
+	phydev->duplex = DUPLEX_FULL;
+    linkmode_set_bit(ETHTOOL_LINK_MODE_1000baseT_Full_BIT, phydev->supported);
+
+	switch (DP83TG720->chip) {
+	case DP83TG720_CS1_1:
+		if (DP83TG720->is_master)
+			ret = DP83TG720_write_seq(phydev, DP83TG720_cs1_1_master_init,
+						ARRAY_SIZE(DP83TG720_cs1_1_master_init));
+		else
+			ret = DP83TG720_write_seq(phydev, DP83TG720_cs1_1_slave_init,
+						ARRAY_SIZE(DP83TG720_cs1_1_slave_init));
+
+		ret = dp83tg720_reset(phydev, false);
+
+		return 1;
+	case DP83TG721_CS1:
+		if (DP83TG720->is_master)
+			ret = DP83TG720_write_seq(phydev, DP83TG721_cs1_master_init,
+						ARRAY_SIZE(DP83TG721_cs1_master_init));
+		else
+			ret = DP83TG720_write_seq(phydev, DP83TG721_cs1_slave_init,
+						ARRAY_SIZE(DP83TG721_cs1_slave_init));
+
+		ret = dp83tg720_reset(phydev, false);
+
+		return 1;
+	default:
+		return -EINVAL;
+	};
+
+	if (ret)
+		return ret;
+
+	/* Enable the PHY */
+	ret = phy_write_mmd(phydev, MMD1F, DP83TG720_LPS_CFG3, DP83TG720_LPS_CFG3_PWR_MODE_0);
+	if (ret)
+		return ret;
+
+	mdelay(10);
+
+	/* Do a software reset to restart the PHY with the updated values */
+	return dp83tg720_reset(phydev, false);
+}
+
 static int dp83tg720_config_init(struct phy_device *phydev)
 {
 	int value, ret;
@@ -369,9 +689,7 @@ static int dp83tg720_config_init(struct phy_device *phydev)
 	/* Software Restart is not enough to recover from a link failure.
 	 * Using Hardware Reset instead.
 	 */
-	ret = phy_write(phydev, DP83TG720_PHY_RESET, DP83TG720_HW_RESET);
-	if (ret)
-		return ret;
+	ret = dp83tg720_chip_init(phydev);
 
 	/* Wait until MDC can be used again.
 	 * The wait value of one 1ms is documented in "DP83TG720-Q1 1000BASE-T1
@@ -447,6 +765,7 @@ static int dp83tg720_probe(struct phy_device *phydev)
     PHY_ID_MATCH_EXACT(_id),                                            \
     .name                   = (_name),                                  \
     .probe                  = dp83tg720_probe,                          \
+	.soft_reset				= dp83tg720_phy_reset,						\
     .flags                  = PHY_POLL_CABLE_TEST,                      \
     .config_aneg            = dp83tg720_config_aneg,                    \
     .read_status            = dp83tg720_read_status,                    \
@@ -473,32 +792,6 @@ static struct mdio_device_id __maybe_unused dp83tg720_tbl[] = {
 };
 MODULE_DEVICE_TABLE(mdio, dp83tg720_tbl);
 
-// static struct phy_driver dp83tg720_driver[] = {
-// {
-// 	PHY_ID_MATCH_MODEL(DP83TG720_PHY_ID),
-// 	.name		= "TI DP83TG720",
-
-// 	.flags          = PHY_POLL_CABLE_TEST,
-// 	.config_aneg	= dp83tg720_config_aneg,
-// 	.read_status	= dp83tg720_read_status,
-// 	.get_features	= genphy_c45_pma_read_ext_abilities,
-// 	.config_init	= dp83tg720_config_init,
-// 	.get_sqi	= dp83tg720_get_sqi,
-// 	.get_sqi_max	= dp83tg720_get_sqi_max,
-// 	.cable_test_start = dp83tg720_cable_test_start,
-// 	.cable_test_get_status = dp83tg720_cable_test_get_status,
-
-// 	.suspend	= genphy_suspend,
-// 	.resume		= genphy_resume,
-// } };
-// module_phy_driver(dp83tg720_driver);
-
-// static struct mdio_device_id __maybe_unused dp83tg720_tbl[] = {
-// 	{ PHY_ID_MATCH_MODEL(DP83TG720_PHY_ID) },
-// 	{ }
-// };
-// MODULE_DEVICE_TABLE(mdio, dp83tg720_tbl);
-
 MODULE_DESCRIPTION("Texas Instruments DP83TG720 PHY driver");
 MODULE_AUTHOR("Oleksij Rempel <kernel@pengutronix.de>");
 MODULE_LICENSE("GPL");
-- 
2.17.1


