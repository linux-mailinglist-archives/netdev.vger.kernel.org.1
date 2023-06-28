Return-Path: <netdev-owner@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42FBA741191
	for <lists+netdev@lfdr.de>; Wed, 28 Jun 2023 14:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbjF1Mpy (ORCPT <rfc822;lists+netdev@lfdr.de>);
        Wed, 28 Jun 2023 08:45:54 -0400
Received: from mail-dm6nam10on2041.outbound.protection.outlook.com ([40.107.93.41]:13024
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231810AbjF1MoF (ORCPT <rfc822;netdev@vger.kernel.org>);
        Wed, 28 Jun 2023 08:44:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kddHHe4wrz8LCiZXlZ1bpBl4IkokWsNzQNDjqfaG6ARqkGk8qYp7hw7LFXcBgp4QauIyGL8EzzYNruE1EqkDO9WJgdIVB95QejuBQ+Gtryik5MVmR45syq+Ov0SjFLZQjcea9+X2xGF6yNs9640aGZjGH90Cp7T/lxcay8wqG0tiXNW73ww5kv6mPx4XzPV+GOVbIDsTxtS0mn3/pRc6HCmNDqo12CQfEZTnGVIe5HzuxbovZkP7DQF7rkzRngCDG5dc+m20qpklVZK98+aQ47GAaIBuVe2zUAsCtf3b4Y2ZEPYwxv4XOFlOLSvn2nTDSrIY8RrTVNUF6rFdGbGpCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yYyiRkKRU4tUCSzy5DryFP5efevm0E160OJVgbj+aNE=;
 b=h7CK2752bZsU6yGHNYRNB+i05O+8Fz7b86pEiiI7OTvRQjwMwmB2ZCznTueUoXYigP4BNcE0DfREAJ//BdZziJaPDf0p5MTRo27cMUjzfSXK8TDL1Lnwq09fwWB4DGz4oW9WFGKD5rflbF4KVetG0kOrfxfFMMfNxNMbgMGROjZII0yaDq+8dhcvPau4IiFKX4jLeHvNBe3tBILCGKVH8cZ6d10wWIGOSGrfVQbWLDfOSmN+0PEM3Hyp9mC6jVoPGoMNBwm9uZ4j+Eih5I6YVhweFPy0sXukgKroPj/Zts58oKbd+HqmAQ9tU0N26XYR5AqBP2n08OgKNjONt6LuXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=armlinux.org.uk smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yYyiRkKRU4tUCSzy5DryFP5efevm0E160OJVgbj+aNE=;
 b=HQIjxC6ai9WFiESD7BPhtlxJ2/xuDvNmHIZwUNxSch0PUkYo2t5h77GjucRiVdSFzdNg3/hJhern86kXg95U3H/tDN5cst3/uBzlV3W3gF2hgS10pFR/GhxwTnZobPq+SlHoW17wVwJECFisyuSGiqOgAj1u7hOTvEHXiuwCVNmU+2nCoR578zfQA3Pf+C+GErlmaUiZ5DpwVkBRWIoXXiN4FOWddjD87YcWiwPw3BHr1yKx6hl8LhdqEZ1O7oYQV5gtAX7RO2+/ZwqoOjX3hYc52xfbLEERhaFe3c9UG65QFolFjzwlvKjh8MNbyRj4QhsAP7Hb/gwS8VOhQFzqHA==
Received: from MW4PR03CA0092.namprd03.prod.outlook.com (2603:10b6:303:b7::7)
 by SJ0PR12MB5636.namprd12.prod.outlook.com (2603:10b6:a03:42b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Wed, 28 Jun
 2023 12:44:02 +0000
Received: from CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b7:cafe::5a) by MW4PR03CA0092.outlook.office365.com
 (2603:10b6:303:b7::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.34 via Frontend
 Transport; Wed, 28 Jun 2023 12:44:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT043.mail.protection.outlook.com (10.13.174.193) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6500.48 via Frontend Transport; Wed, 28 Jun 2023 12:44:01 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 28 Jun 2023
 05:43:51 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 28 Jun
 2023 05:43:50 -0700
Received: from buildserver-hdc-comms.nvidia.com (10.127.8.12) by
 mail.nvidia.com (10.129.68.7) with Microsoft SMTP Server id 15.2.986.37 via
 Frontend Transport; Wed, 28 Jun 2023 05:43:48 -0700
From:   Revanth Kumar Uppala <ruppala@nvidia.com>
To:     <linux@armlinux.org.uk>, <andrew@lunn.ch>, <hkallweit1@gmail.com>,
        <netdev@vger.kernel.org>
CC:     <linux-tegra@vger.kernel.org>,
        Revanth Kumar Uppala <ruppala@nvidia.com>,
        Narayan Reddy <narayanr@nvidia.com>
Subject: [PATCH 4/4] net: phy: aqr113c: Enable Wake-on-LAN (WOL)
Date:   Wed, 28 Jun 2023 18:13:26 +0530
Message-ID: <20230628124326.55732-4-ruppala@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230628124326.55732-1-ruppala@nvidia.com>
References: <20230628124326.55732-1-ruppala@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT043:EE_|SJ0PR12MB5636:EE_
X-MS-Office365-Filtering-Correlation-Id: d9b7dfcd-d6d7-4ee2-1e3c-08db77d5593f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PAYQSM9YUilMetbI9p06Tj7T+uc58ZiGORjzsuWdhPdmPRUEdvSGumzC+lI3i06tm15qvZewp7qjtcgRfKuaV2iL0YHerVl2cDhIo/fd6hZGdrAhZN3vmaMrOZxfLxWseTjTP4Fp8TK2DMjf0IyyCbS4VRoXJ5aC5Q7B65UjVpm8EKiJe9kuKmkOEtp61ZFft3pSUftwzVNi816Ws8DaPi7q7oxiIu0W1aWESPwvJ0r8hz41ThhJsdWH/AttJxQ7kWJQI7UO+bfuIDkjlj3i78G/n27Yy9VISwvV9eriZrKWjBWwrwTImjnSeJ+lMtWMILcZQy+Licv19ZwetdW3J24FhH1owz9LAPJCEIdzvzEd5a+MOaH0MIIj8K4salgffyZW7xINM1hsgDFnRU3R6eMnijY5dxLPpUOqWb9ePpIxIGTFQQYDfcsxPYpNgRDkXLePUGPWJOmpGAILrCjIrOkcsQyPuqUP36UCEnDMNVi42Lklgql1jmVqhXfRBz8YMMGFjMkyJnzMvsPSqYO2YevCHsbV7vAhHo0d0Q4r1NhakAELcrLn7P9ikDezPK3bLZPeJll32U0VtEszztsz5Q+X6Q75Dz7HhZP3xVYNpnVZl/cVbEm5SEXU/WwvuByhd+bL0UfmzzIDjNjifGmIO+NMVKU4g+nOH+X5VFsXFjta2szH7vV+FwYzJtxWyclJf0HpdEsjZd78nVuyeip9+7Bu8tGOISiaHGl9FKQnzdHUF/JOiXua6esocjdN759n
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(39860400002)(396003)(376002)(451199021)(36840700001)(46966006)(40470700004)(82310400005)(36860700001)(26005)(82740400003)(356005)(30864003)(5660300002)(70206006)(86362001)(40460700003)(8936002)(41300700001)(4326008)(316002)(8676002)(36756003)(7636003)(70586007)(40480700001)(110136005)(107886003)(47076005)(186003)(2906002)(83380400001)(1076003)(54906003)(7696005)(6666004)(426003)(336012)(2616005)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 12:44:01.1167
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9b7dfcd-d6d7-4ee2-1e3c-08db77d5593f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5636
Precedence: bulk
List-ID: <netdev.vger.kernel.org>
X-Mailing-List: netdev@vger.kernel.org

Configure the WOL settings in the PHY to allow the PHY to detect magic
packets and generate an interrupt to wake the device from suspend.

The PHY configuration is restored back to XFI once the PHY received the
WOL magic packet.

Note that it is not necessary to poll the PHY status when WOL is enabled
because the interface speed is not being re-configured

Signed-off-by: Narayan Reddy <narayanr@nvidia.com>
Signed-off-by: Revanth Kumar Uppala <ruppala@nvidia.com>
---
 drivers/net/phy/aquantia_main.c | 235 +++++++++++++++++++++++++++++++-
 include/uapi/linux/mdio.h       |   1 +
 2 files changed, 229 insertions(+), 7 deletions(-)

diff --git a/drivers/net/phy/aquantia_main.c b/drivers/net/phy/aquantia_main.c
index a27ff4733050..5c69ecd2cf9f 100644
--- a/drivers/net/phy/aquantia_main.c
+++ b/drivers/net/phy/aquantia_main.c
@@ -12,6 +12,7 @@
 #include <linux/delay.h>
 #include <linux/bitfield.h>
 #include <linux/phy.h>
+#include <linux/netdevice.h>
 
 #include "aquantia.h"
 
@@ -48,10 +49,13 @@
 #define MDIO_AN_VEND_PROV_1000BASET_HALF	BIT(14)
 #define MDIO_AN_VEND_PROV_5000BASET_FULL	BIT(11)
 #define MDIO_AN_VEND_PROV_2500BASET_FULL	BIT(10)
+#define MDIO_AN_VEND_PROV_AQRATE_DWN_SHFT_CAP	BIT(12)
 #define MDIO_AN_VEND_PROV_DOWNSHIFT_EN		BIT(4)
 #define MDIO_AN_VEND_PROV_DOWNSHIFT_MASK	GENMASK(3, 0)
 #define MDIO_AN_VEND_PROV_DOWNSHIFT_DFLT	4
+#define MDIO_AN_VEND_MASK			0xF0FF
 
+#define MDIO_AN_RSVD_VEND_PROV1			0xc410
 #define MDIO_AN_TX_VEND_STATUS1			0xc800
 #define MDIO_AN_TX_VEND_STATUS1_RATE_MASK	GENMASK(3, 1)
 #define MDIO_AN_TX_VEND_STATUS1_10BASET		0
@@ -61,6 +65,9 @@
 #define MDIO_AN_TX_VEND_STATUS1_2500BASET	4
 #define MDIO_AN_TX_VEND_STATUS1_5000BASET	5
 #define MDIO_AN_TX_VEND_STATUS1_FULL_DUPLEX	BIT(0)
+#define MDIO_MMD_AN_WOL_ENABLE			BIT(6)
+
+#define MDIO_AN_RSVD_VEND_STATUS3		0xc812
 
 #define MDIO_AN_TX_VEND_INT_STATUS1		0xcc00
 #define MDIO_AN_TX_VEND_INT_STATUS1_DOWNSHIFT	BIT(1)
@@ -86,6 +93,19 @@
 #define MDIO_AN_RX_VEND_STAT3_AFR		BIT(0)
 
 /* MDIO_MMD_C22EXT */
+#define MDIO_C22EXT_MAGIC_PKT_PATTERN_0_2_15		0xc339
+#define MDIO_C22EXT_MAGIC_PKT_PATTERN_16_2_31		0xc33a
+#define MDIO_C22EXT_MAGIC_PKT_PATTERN_32_2_47		0xc33b
+
+#define MDIO_C22EXT_GBE_PHY_RSI1_CTRL6			0xc355
+#define MDIO_C22EXT_RSI_WAKE_UP_FRAME_DETECTION         BIT(0)
+
+#define MDIO_C22EXT_GBE_PHY_RSI1_CTRL7			0xc356
+#define MDIO_C22EXT_RSI_MAGIC_PKT_FRAME_DETECTION	BIT(0)
+
+#define MDIO_C22EXT_GBE_PHY_RSI1_CTRL8			0xc357
+#define MDIO_C22EXT_RSI_WOL_FCS_MONITOR_MODE		BIT(15)
+
 #define MDIO_C22EXT_STAT_SGMII_RX_GOOD_FRAMES		0xd292
 #define MDIO_C22EXT_STAT_SGMII_RX_BAD_FRAMES		0xd294
 #define MDIO_C22EXT_STAT_SGMII_RX_FALSE_CARRIER		0xd297
@@ -96,6 +116,11 @@
 #define MDIO_C22EXT_STAT_SGMII_TX_LINE_COLLISIONS	0xd319
 #define MDIO_C22EXT_STAT_SGMII_TX_FRAME_ALIGN_ERR	0xd31a
 #define MDIO_C22EXT_STAT_SGMII_TX_RUNT_FRAMES		0xd31b
+#define MDIO_C22EXT_GBE_PHY_SGMII_TX_ALARM1		0xec20
+
+#define MDIO_C22EXT_GBE_PHY_SGMII_TX_INT_MASK1		0xf420
+#define MDIO_C22EXT_SGMII0_WAKE_UP_FRAME_MASK		BIT(4)
+#define MDIO_C22EXT_SGMII0_MAGIC_PKT_FRAME_MASK		BIT(5)
 
 /* Vendor specific 1, MDIO_MMD_VEND1 */
 #define VEND1_GLOBAL_FW_ID			0x0020
@@ -109,6 +134,10 @@
 #define VEND1_GLOBAL_CFG_10M			0x0310
 #define VEND1_GLOBAL_CFG_100M			0x031b
 #define VEND1_GLOBAL_CFG_1G			0x031c
+#define VEND1_GLOBAL_SYS_CONFIG_SGMII   (BIT(0) | BIT(1))
+#define VEND1_GLOBAL_SYS_CONFIG_AN      BIT(3)
+#define VEND1_GLOBAL_SYS_CONFIG_XFI     BIT(8)
+
 #define VEND1_GLOBAL_CFG_2_5G			0x031d
 #define VEND1_GLOBAL_CFG_5G			0x031e
 #define VEND1_GLOBAL_CFG_10G			0x031f
@@ -181,6 +210,7 @@ static const struct aqr107_hw_stat aqr107_hw_stats[] = {
 
 struct aqr107_priv {
 	u64 sgmii_stats[AQR107_SGMII_STAT_SZ];
+	int wol_status;
 };
 
 static int aqr107_get_sset_count(struct phy_device *phydev)
@@ -327,9 +357,139 @@ static int aqr_config_intr(struct phy_device *phydev)
 	return 0;
 }
 
+static int aqr113c_wol_enable(struct phy_device *phydev)
+{
+	struct aqr107_priv *priv = phydev->priv;
+	u16 val;
+	int ret;
+
+	/* Disables all advertised speeds except for the WoL
+	 * speed (100BASE-TX FD or 1000BASE-T)
+	 * This is set as per the APP note from Marvel
+	 */
+	ret = phy_set_bits_mmd(phydev, MDIO_MMD_AN, MDIO_AN_10GBT_CTRL,
+			       MDIO_AN_LD_LOOP_TIMING_ABILITY);
+	if (ret < 0)
+		return ret;
+
+	ret = phy_read_mmd(phydev, MDIO_MMD_AN, MDIO_AN_VEND_PROV);
+	if (ret < 0)
+		return ret;
+
+	val = (ret & MDIO_AN_VEND_MASK) |
+	      (MDIO_AN_VEND_PROV_AQRATE_DWN_SHFT_CAP | MDIO_AN_VEND_PROV_1000BASET_FULL);
+	ret = phy_write_mmd(phydev, MDIO_MMD_AN, MDIO_AN_VEND_PROV, val);
+	if (ret < 0)
+		return ret;
+
+	/* Enable the magic frame and wake up frame detection for the PHY */
+	ret = phy_set_bits_mmd(phydev, MDIO_MMD_C22EXT, MDIO_C22EXT_GBE_PHY_RSI1_CTRL6,
+			       MDIO_C22EXT_RSI_WAKE_UP_FRAME_DETECTION);
+	if (ret < 0)
+		return ret;
+
+	ret = phy_set_bits_mmd(phydev, MDIO_MMD_C22EXT, MDIO_C22EXT_GBE_PHY_RSI1_CTRL7,
+			       MDIO_C22EXT_RSI_MAGIC_PKT_FRAME_DETECTION);
+	if (ret < 0)
+		return ret;
+
+	/* Set the WoL enable bit */
+	ret = phy_set_bits_mmd(phydev, MDIO_MMD_AN, MDIO_AN_RSVD_VEND_PROV1,
+			       MDIO_MMD_AN_WOL_ENABLE);
+	if (ret < 0)
+		return ret;
+
+	/* Set the WoL INT_N trigger bit */
+	ret = phy_set_bits_mmd(phydev, MDIO_MMD_C22EXT, MDIO_C22EXT_GBE_PHY_RSI1_CTRL8,
+			       MDIO_C22EXT_RSI_WOL_FCS_MONITOR_MODE);
+	if (ret < 0)
+		return ret;
+
+	/* Enable Interrupt INT_N Generation at pin level */
+	ret = phy_set_bits_mmd(phydev, MDIO_MMD_C22EXT, MDIO_C22EXT_GBE_PHY_SGMII_TX_INT_MASK1,
+			       MDIO_C22EXT_SGMII0_WAKE_UP_FRAME_MASK |
+			       MDIO_C22EXT_SGMII0_MAGIC_PKT_FRAME_MASK);
+	if (ret < 0)
+		return ret;
+
+	ret = phy_set_bits_mmd(phydev, MDIO_MMD_VEND1, VEND1_GLOBAL_INT_STD_MASK,
+			       VEND1_GLOBAL_INT_STD_MASK_ALL);
+	if (ret < 0)
+		return ret;
+
+	ret = phy_set_bits_mmd(phydev, MDIO_MMD_VEND1, VEND1_GLOBAL_INT_VEND_MASK,
+			       VEND1_GLOBAL_INT_VEND_MASK_GBE);
+	if (ret < 0)
+		return ret;
+
+	/* Set the system interface to SGMII */
+	ret = phy_write_mmd(phydev, MDIO_MMD_VEND1,
+			    VEND1_GLOBAL_CFG_100M, VEND1_GLOBAL_SYS_CONFIG_SGMII |
+			    VEND1_GLOBAL_SYS_CONFIG_AN);
+	if (ret < 0)
+		return ret;
+
+	ret = phy_write_mmd(phydev, MDIO_MMD_VEND1,
+			    VEND1_GLOBAL_CFG_1G, VEND1_GLOBAL_SYS_CONFIG_SGMII |
+			    VEND1_GLOBAL_SYS_CONFIG_AN);
+	if (ret < 0)
+		return ret;
+
+	/* restart auto-negotiation */
+	genphy_c45_restart_aneg(phydev);
+	priv->wol_status = 1;
+
+	return 0;
+}
+
+static int aqr113c_wol_disable(struct phy_device *phydev)
+{
+	struct aqr107_priv *priv = phydev->priv;
+	int ret;
+
+	/* Disable the WoL enable bit */
+	ret = phy_clear_bits_mmd(phydev, MDIO_MMD_AN, MDIO_AN_RSVD_VEND_PROV1,
+				 MDIO_MMD_AN_WOL_ENABLE);
+	if (ret < 0)
+		return ret;
+
+	/* Restore the SERDES/System Interface back to the XFI mode */
+	ret = phy_write_mmd(phydev, MDIO_MMD_VEND1,
+			    VEND1_GLOBAL_CFG_100M, VEND1_GLOBAL_SYS_CONFIG_XFI);
+	if (ret < 0)
+		return ret;
+
+	ret = phy_write_mmd(phydev, MDIO_MMD_VEND1,
+			    VEND1_GLOBAL_CFG_1G, VEND1_GLOBAL_SYS_CONFIG_XFI);
+	if (ret < 0)
+		return ret;
+
+	/* restart auto-negotiation */
+	genphy_c45_restart_aneg(phydev);
+	priv->wol_status = 0;
+
+	return 0;
+}
+
 static irqreturn_t aqr_handle_interrupt(struct phy_device *phydev)
 {
+	struct aqr107_priv *priv = phydev->priv;
 	int irq_status;
+	int ret;
+
+	ret = phy_read_mmd(phydev, MDIO_MMD_C22EXT, MDIO_C22EXT_GBE_PHY_SGMII_TX_ALARM1);
+	if (ret < 0) {
+		phy_error(phydev);
+		return IRQ_NONE;
+	}
+
+	if ((ret & MDIO_C22EXT_SGMII0_MAGIC_PKT_FRAME_MASK) ==
+	    MDIO_C22EXT_SGMII0_MAGIC_PKT_FRAME_MASK) {
+		/* Disable the WoL */
+		ret = aqr113c_wol_disable(phydev);
+		if (ret < 0)
+			return IRQ_NONE;
+	}
 
 	irq_status = phy_read_mmd(phydev, MDIO_MMD_AN,
 				  MDIO_AN_TX_VEND_INT_STATUS2);
@@ -425,6 +585,7 @@ static int aqr107_read_rate(struct phy_device *phydev)
 
 static int aqr107_read_status(struct phy_device *phydev)
 {
+	struct aqr107_priv *priv = phydev->priv;
 	int val, ret;
 
 	ret = aqr_read_status(phydev);
@@ -471,14 +632,18 @@ static int aqr107_read_status(struct phy_device *phydev)
 	/* Lane bring-up failures are seen during interface up, as interface
 	 * speed settings are configured while the PHY is still initializing.
 	 * To resolve this, poll until PHY system side interface gets ready
-	 * and the interface speed settings are configured.
+	 * and the interface speed settings are configured.Polling is skipped
+	 * when WoL is enabled because interface speed settings are not
+	 * configured at that time.
 	 */
-	ret = phy_read_mmd_poll_timeout(phydev, MDIO_MMD_PHYXS, MDIO_PHYXS_VEND_IF_STATUS,
-					val, (val & MDIO_PHYXS_VEND_IF_STATUS_TX_READY),
-					20000, 2000000, false);
-	if (ret) {
-		phydev_err(phydev, "PHY system interface is not yet ready\n");
-		return ret;
+	if (!priv->wol_status) {
+		ret = phy_read_mmd_poll_timeout(phydev, MDIO_MMD_PHYXS, MDIO_PHYXS_VEND_IF_STATUS,
+						val, (val & MDIO_PHYXS_VEND_IF_STATUS_TX_READY),
+						20000, 2000000, false);
+		if (ret) {
+			phydev_err(phydev, "PHY system interface is not yet ready\n");
+			return ret;
+		}
 	}
 
 	/* Read possibly downshifted rate from vendor register */
@@ -619,6 +784,31 @@ static int aqr107_config_init(struct phy_device *phydev)
 	if (ret < 0)
 		return ret;
 
+	/* Configure Magic packet frame pattern (MAC address) */
+	ret = phy_write_mmd(phydev, MDIO_MMD_C22EXT, MDIO_C22EXT_MAGIC_PKT_PATTERN_0_2_15,
+			    phydev->attached_dev->dev_addr[0] |
+			    (phydev->attached_dev->dev_addr[1] << 8));
+	if (ret < 0) {
+		phydev_err(phydev, "Error setting magic packet frame of 0/1st byte\n");
+		return ret;
+	}
+
+	ret = phy_write_mmd(phydev, MDIO_MMD_C22EXT, MDIO_C22EXT_MAGIC_PKT_PATTERN_16_2_31,
+			    phydev->attached_dev->dev_addr[2] |
+			    (phydev->attached_dev->dev_addr[3] << 8));
+	if (ret < 0) {
+		phydev_err(phydev, "Error setting magic packet frame of 2/3rd byte\n");
+		return ret;
+	}
+
+	ret = phy_write_mmd(phydev, MDIO_MMD_C22EXT, MDIO_C22EXT_MAGIC_PKT_PATTERN_32_2_47,
+			    phydev->attached_dev->dev_addr[4] |
+			    (phydev->attached_dev->dev_addr[5] << 8));
+	if (ret < 0) {
+		phydev_err(phydev, "Error setting magic packet frame of 4/5th byte\n");
+		return ret;
+	}
+
 	return aqr107_set_downshift(phydev, MDIO_AN_VEND_PROV_DOWNSHIFT_DFLT);
 }
 
@@ -757,6 +947,35 @@ static int aqr107_probe(struct phy_device *phydev)
 	return aqr_hwmon_probe(phydev);
 }
 
+static void aqr113c_get_wol(struct phy_device *phydev, struct ethtool_wolinfo *wol)
+{
+	int val;
+
+	val = phy_read_mmd(phydev, MDIO_MMD_AN, MDIO_AN_RSVD_VEND_STATUS3);
+	if (val < 0)
+		return;
+
+	wol->supported = WAKE_MAGIC;
+	if (val & 0x1)
+		wol->wolopts = WAKE_MAGIC;
+}
+
+static int aqr113c_set_wol(struct phy_device *phydev, struct ethtool_wolinfo *wol)
+{
+	struct aqr107_priv *priv = phydev->priv;
+
+	/* Return success if WOL is already set. Don't entertain duplicate setting of WOL */
+	if (!(priv->wol_status ^ wol->wolopts))
+		return 0;
+
+	if (wol->wolopts & WAKE_MAGIC)
+		return aqr113c_wol_enable(phydev);
+	else
+		return aqr113c_wol_disable(phydev);
+
+	return 0;
+}
+
 static struct phy_driver aqr_driver[] = {
 {
 	PHY_ID_MATCH_MODEL(PHY_ID_AQ1202),
@@ -892,6 +1111,8 @@ static struct phy_driver aqr_driver[] = {
 	.get_strings    = aqr107_get_strings,
 	.get_stats      = aqr107_get_stats,
 	.link_change_notify = aqr107_link_change_notify,
+	.get_wol        = &aqr113c_get_wol,
+	.set_wol        = &aqr113c_set_wol,
 },
 };
 
diff --git a/include/uapi/linux/mdio.h b/include/uapi/linux/mdio.h
index b826598d1e94..07ca44891378 100644
--- a/include/uapi/linux/mdio.h
+++ b/include/uapi/linux/mdio.h
@@ -298,6 +298,7 @@
 #define MDIO_AN_10GBT_CTRL_ADV5G	0x0100	/* Advertise 5GBASE-T */
 #define MDIO_AN_10GBT_CTRL_ADV10G	0x1000	/* Advertise 10GBASE-T */
 
+#define MDIO_AN_LD_LOOP_TIMING_ABILITY	0x0001
 /* AN 10GBASE-T status register. */
 #define MDIO_AN_10GBT_STAT_LP2_5G	0x0020  /* LP is 2.5GBT capable */
 #define MDIO_AN_10GBT_STAT_LP5G		0x0040  /* LP is 5GBT capable */
-- 
2.17.1

