Return-Path: <netdev-owner@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64C3E741198
	for <lists+netdev@lfdr.de>; Wed, 28 Jun 2023 14:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231279AbjF1Mp5 (ORCPT <rfc822;lists+netdev@lfdr.de>);
        Wed, 28 Jun 2023 08:45:57 -0400
Received: from mail-bn8nam04on2083.outbound.protection.outlook.com ([40.107.100.83]:31188
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231493AbjF1Mnz (ORCPT <rfc822;netdev@vger.kernel.org>);
        Wed, 28 Jun 2023 08:43:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FAObojWfNSsjQL6d79bCHEoOcOu36Nva+H/m5eVqZpiHZLx9JIUN+0mDLtOIRh+7UGXIyf6wMXNn02ifqG1Lv+Pc4LOXzTlnW418dLofxAjz1jXaMnpwdEUyUgbrXYQNsTtzqwOQKn1ET31LvOTSIeQhuxetiaW5667LqUNS3O3FSgOBxWjhaJA4emWQfmj0rF7/vqH2lenR9Yq3DV8jJFs7SHqDxTi4o5H4lq5UsFeWCMy9x56I5fP+vvdJzjNYlIooKs8tcTIVRqn8TNpRJoeqPUVTNu+jiERULYbCrS9bthRAiT6faWUSXDS747xm3UtCd6Nt1rx59EcNx9wu5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bFIn256jEZx1Tjky2KpHs0PtYbexN4GeLestHksYmEQ=;
 b=ZSnuW0MYgXkG1whs4ZznuwuXI/KYU9bxcp9NtnCOsl8ji24lNLZOt0lXg1GkL/bGrFI209o7RR45vxPUVcaiJtKvxGMtKx92lniYhDwqrZ7uS3nQ5zzTOltSukPDZ7OGAuUqQl2/6+AS1OAuZLnY0JY/Krbz7OAHQrsIzSMHghcJXxhQucSXhnuQEElwSIwGgo71RNGgmFF3MB9FM1HFJImPxnnIRM7E8V+k0zhlzxXL81tS0pqa727vYea8jG9LTxYXWsc9Cm976x9CceHHYHqiYAnuzqPq4R0Kpumj2HhYW7/JsiTStiXCC636ktNOo2gw5GkKCB26A5QidFQvUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=armlinux.org.uk smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bFIn256jEZx1Tjky2KpHs0PtYbexN4GeLestHksYmEQ=;
 b=b3erUZs+9D0WXqo8pZOGVhJp099N++kkNvEKbYa6G9g1A+m91M6PMO0UJWJMHH2UCzdAzah1GfcHDsMMzLy+/jrJnm15xmUwwBONHOvomvTfEe/7EwPVzfiWiYNiavJ2wyrgncXvuUtcflgt5fjM8UTK/Kj/qXi/UpU27YqnrvvX8nirwOszr3rK6K02I77Hmt8wE04z3FJOox6QckbmkUwiSGPQ4q+AKz67pjXPopdaAFK7p+AvhbeYrGoBPv3OCpoLDfPUmPAyduZSro5ZIPazNvJZJaYxY9XHzX8/JSKsA2NjLq1FhLciNR/t0/4SYpccj2CNUo5OvQufhv44lw==
Received: from MW4PR04CA0090.namprd04.prod.outlook.com (2603:10b6:303:6b::35)
 by PH0PR12MB8176.namprd12.prod.outlook.com (2603:10b6:510:290::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Wed, 28 Jun
 2023 12:43:52 +0000
Received: from CO1NAM11FT074.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6b:cafe::4f) by MW4PR04CA0090.outlook.office365.com
 (2603:10b6:303:6b::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.20 via Frontend
 Transport; Wed, 28 Jun 2023 12:43:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT074.mail.protection.outlook.com (10.13.174.254) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6500.48 via Frontend Transport; Wed, 28 Jun 2023 12:43:51 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 28 Jun 2023
 05:43:39 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 28 Jun
 2023 05:43:39 -0700
Received: from buildserver-hdc-comms.nvidia.com (10.127.8.12) by
 mail.nvidia.com (10.129.68.7) with Microsoft SMTP Server id 15.2.986.37 via
 Frontend Transport; Wed, 28 Jun 2023 05:43:37 -0700
From:   Revanth Kumar Uppala <ruppala@nvidia.com>
To:     <linux@armlinux.org.uk>, <andrew@lunn.ch>, <hkallweit1@gmail.com>,
        <netdev@vger.kernel.org>
CC:     <linux-tegra@vger.kernel.org>, Narayan Reddy <narayanr@nvidia.com>,
        Revanth Kumar Uppala <ruppala@nvidia.com>
Subject: [PATCH 1/4] net: phy: aquantia: Enable Tx/Rx pause frame support in aquantia PHY
Date:   Wed, 28 Jun 2023 18:13:23 +0530
Message-ID: <20230628124326.55732-1-ruppala@nvidia.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT074:EE_|PH0PR12MB8176:EE_
X-MS-Office365-Filtering-Correlation-Id: 9dcb87d3-6877-46c9-23f9-08db77d553c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ij/s081wObAuZj1WYPQRqPHN6AB4A971QVpES6IXSflSQY9zZFrKCUqGmbbKMjmdH3TvwDX84S9ewUFMYlFPDGA+WrufYvnDmz80iLHKQ71yeY4P/m9jOx6F5il7nti/1HB2EbE98kW7Uw7PbTCj9n8al9HCzSNO04R5JKWkeTsE8GkIZlCZC9ipbmKH6L3+Wpc3wUATXpJ690Kd6B0i+tZeuoFGiJazaTwfOR8wfUbfZdGwa9HV7Qn1jgHbNnWrDRUsLVdHabXyQouhHTmqf1b888qE/cIDRy3szdPDcU0Gxy+FAsGH+TH0Ya1i3AeXKwdk0uSFf8zj56BiQ8j9ZMBUMj2TvJBw75YW/IyoyZ10BnGpD14ABq9Amqr/l3J5f5ediRujDLetXiTZ6wopZVY/0lj082Y8Hx23Y9QkuPZ/hqp0ijZhOY5TTTSfnFHHyCA/hejZroo/4VpwXo0KXV8E90TESrsSRU5R1uEMt+bHkND63kVDUHOh8BOuZhqDzidqpj4Lb4cf5fiBbrM2UnWyxhz4JbFje02uOAK6e5Mwzk29yL3ap+ppgdt8DcBm3/7oNwu0zuT4zcP4OvGrWU9FgiYam27ZAXQDh03C06NPPIazIrJ8DlQ6QMoVPYOm4OXU4lXtqgFZ7Rqfa8TK79dGAK+t6n2SVW5yFrc4LrR+VfdICxtARiWN0INqLlZ1jDw1jL0kc5KZYxkPxHSuG81QWPcwYZXMPEk6WWC87nLfzYWvhb8c5m9zmbNCz/vZ
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(39860400002)(396003)(376002)(451199021)(40470700004)(46966006)(36840700001)(82310400005)(7696005)(186003)(2906002)(26005)(5660300002)(41300700001)(82740400003)(8676002)(6666004)(36756003)(316002)(7636003)(54906003)(2616005)(478600001)(110136005)(336012)(86362001)(4326008)(426003)(107886003)(1076003)(47076005)(70586007)(8936002)(356005)(40460700003)(40480700001)(70206006)(36860700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 12:43:51.9287
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dcb87d3-6877-46c9-23f9-08db77d553c5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT074.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8176
Precedence: bulk
List-ID: <netdev.vger.kernel.org>
X-Mailing-List: netdev@vger.kernel.org

From: Narayan Reddy <narayanr@nvidia.com>

Enable flow control support using pause frames in aquantia phy driver.

Signed-off-by: Narayan Reddy <narayanr@nvidia.com>
Signed-off-by: Revanth Kumar Uppala <ruppala@nvidia.com>
---
 drivers/net/phy/aquantia_main.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/net/phy/aquantia_main.c b/drivers/net/phy/aquantia_main.c
index 334a6904ca5a..c99b9d066463 100644
--- a/drivers/net/phy/aquantia_main.c
+++ b/drivers/net/phy/aquantia_main.c
@@ -26,6 +26,8 @@
 #define PHY_ID_AQR412	0x03a1b712
 #define PHY_ID_AQR113C	0x31c31c12
 
+#define MDIO_AN_ADVT		0x0010
+
 #define MDIO_PHYXS_VEND_IF_STATUS		0xe812
 #define MDIO_PHYXS_VEND_IF_STATUS_TYPE_MASK	GENMASK(7, 3)
 #define MDIO_PHYXS_VEND_IF_STATUS_TYPE_KR	0
@@ -583,6 +585,17 @@ static int aqr107_config_init(struct phy_device *phydev)
 	if (!ret)
 		aqr107_chip_info(phydev);
 
+	/* Advertize flow control */
+	linkmode_set_bit(ETHTOOL_LINK_MODE_Pause_BIT, phydev->supported);
+	linkmode_set_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT, phydev->supported);
+	linkmode_copy(phydev->advertising, phydev->supported);
+
+	/* Configure flow control */
+	ret = phy_set_bits_mmd(phydev, MDIO_MMD_AN, MDIO_AN_ADVT, ADVERTISE_PAUSE_CAP |
+			       ADVERTISE_PAUSE_ASYM);
+	if (ret < 0)
+		return ret;
+
 	return aqr107_set_downshift(phydev, MDIO_AN_VEND_PROV_DOWNSHIFT_DFLT);
 }
 
-- 
2.17.1

