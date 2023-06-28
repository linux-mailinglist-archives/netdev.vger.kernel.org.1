Return-Path: <netdev-owner@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF56B741190
	for <lists+netdev@lfdr.de>; Wed, 28 Jun 2023 14:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbjF1MqB (ORCPT <rfc822;lists+netdev@lfdr.de>);
        Wed, 28 Jun 2023 08:46:01 -0400
Received: from mail-mw2nam04on2063.outbound.protection.outlook.com ([40.107.101.63]:21728
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231616AbjF1Mn7 (ORCPT <rfc822;netdev@vger.kernel.org>);
        Wed, 28 Jun 2023 08:43:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G30VXFGBTyJTGHCw3sMWAykHY8IbpGxa7nxdjZAN01iFWnm+z3FyN4ESdaJlwcTa+AGyjr4SVq9ZzlMvh8OZ/XdpoZ9NmCef0ZABSb5hXsrwJfJ98W+MLuhnxV8Si5R4XDVYO305oVQmN1014CbDT/Tl7m6G+BwIoTaZmFMyR6k0h4AVXDP08PXiuHUoQxMP/iepOEFie7hQoj5sK5So85My4CcIhKHUGMNDI9dtz3WQNkfw0eRSRdsvslLxoRZ+uPPkNTw9TTq6xOT5FpCJcQAd8lFMJnZWG2ST2P6jrS23H8ur2DIypXYEXUDkuTKUDUKlew++LJK9SJcbxYObcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gpQF52FIH87iLfz/2nxsgBF9SSgbtD2QWF3su/sSFzk=;
 b=Ez0X5D8FnzFhIR3+uCs3BGhzsyT3DHxL7H9yBfB+V99D1+Y97D9348hOIY89SFcTsfMdwwg2x9iD76+hxXl8I8U7H3KYtyt9Ck+3T2u4OYKNjvRRDXqn9YBIy/1sBN1xKySe8eBSCuLjFXKRePG8XdcXOKRY55kWAAkbjRENLMRf36aitUwn9nDmVFwLBbh4UwZNIwmaoVwza9rMf2EM37j6qMsfl8KxfvDUcEpU5bm8IMXKlsmRI86SllUVsfunMHh8pWASTx2Swa9ZVpX2hzne3uUiGaGYU9rwhM/fVWlihuCqgibmH63+6dg4sIfTa+f6QrBpeMg2vtEahl9RLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=armlinux.org.uk smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gpQF52FIH87iLfz/2nxsgBF9SSgbtD2QWF3su/sSFzk=;
 b=qpYLP5S/3i7tRLXapnLA9JgObepR25rVV1VsjBAvAUQYbFMvETMIog/v0RUjMjGow9khIrtyAq8CfF4ZeuuOy+fY9zqNMrDln/j4/HCoI0THW8G8soOlz1Og1ggT+i+2DkDX6MMmXwBVIIRZGDNqURkAhAk+EGzPcvJSuTBWEJvUUtZnlUVOQ7gfxV77Kx/a4o0YuFs+Ztqh9dvQ5C8vKdhFsbB99gbGlZ20W1wQTziEW47FtKXktl6qgfSfnpe0o2mKD+tmFxrO7li0jfJhAp0nGaY4aKeCPRihGgj/LJL96oscNDjP5EBmj7aMSA0Rjq2mXKW4zbjGiNaLVmJkvg==
Received: from MW4PR04CA0082.namprd04.prod.outlook.com (2603:10b6:303:6b::27)
 by DS7PR12MB5766.namprd12.prod.outlook.com (2603:10b6:8:75::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 28 Jun
 2023 12:43:54 +0000
Received: from CO1NAM11FT074.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6b:cafe::27) by MW4PR04CA0082.outlook.office365.com
 (2603:10b6:303:6b::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.20 via Frontend
 Transport; Wed, 28 Jun 2023 12:43:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT074.mail.protection.outlook.com (10.13.174.254) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6500.48 via Frontend Transport; Wed, 28 Jun 2023 12:43:54 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 28 Jun 2023
 05:43:43 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 28 Jun
 2023 05:43:43 -0700
Received: from buildserver-hdc-comms.nvidia.com (10.127.8.12) by
 mail.nvidia.com (10.129.68.7) with Microsoft SMTP Server id 15.2.986.37 via
 Frontend Transport; Wed, 28 Jun 2023 05:43:41 -0700
From:   Revanth Kumar Uppala <ruppala@nvidia.com>
To:     <linux@armlinux.org.uk>, <andrew@lunn.ch>, <hkallweit1@gmail.com>,
        <netdev@vger.kernel.org>
CC:     <linux-tegra@vger.kernel.org>,
        Revanth Kumar Uppala <ruppala@nvidia.com>,
        Narayan Reddy <narayanr@nvidia.com>
Subject: [PATCH 2/4] net: phy: aquantia: Enable MAC Controlled EEE
Date:   Wed, 28 Jun 2023 18:13:24 +0530
Message-ID: <20230628124326.55732-2-ruppala@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230628124326.55732-1-ruppala@nvidia.com>
References: <20230628124326.55732-1-ruppala@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT074:EE_|DS7PR12MB5766:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ca8e5bd-a949-4d9d-45ca-08db77d55553
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yNRhfBpPBe3SJ1x4NFPaH3RlqKG9zRjKR+Xn6nM9DS6UgjLoD4CERP2mAHUWnKZhKT1Qsi1WzG7n3npl0Aj0jFapacEmv/9WS/lFb6c2bNV7sFH5XMCPTik4Icn6w9mGXDJR/TBiB+vXJRiRx6O5Cr/PIlxOY4ElAHz6iUJ6C2MDw4mTbqb5GD/J+1zOE9HE+Mjn01ycuj+tHlWtkE5wnCrUSB20TTTFnRzHBTIREzWnKO7JXei/IOMwvvew79gQcLu0GszKIFNyoDZAT6uZJV+MEGuVoZWB4kQETL/7aN5LBqApWZKRJZJBWH4tNAU7aF9f0lmX+e7yBHcM67dZ+eYjHuRMIsXrfX2GqF2Q9ip1ZCLHWcF6C5nQAyuaofcn28TIcixzk6S8MONbvA59VY/FMASBGGBPo2wIKjnDp5sgHhGmY571YktMoiUrYn/gSnd+3XyrHG9VP/MaXhkmbJ3IS1mBBi5//SMmWbzGLb8xr8kb9YaS3L8SLRH9wM2AqG00R35AMYEKkj7GFRj0WzysRmxEg6ul59aLzmiuiS1fhcefikVCkvkOthsvPZxHUFBN+XeKpX0/lnvh0fkm0YHKUmMtBp3ct/+WVsYL673jixY+3pJ2TwGWFHDyURJP7PdNYH15zektl7wz9DtMi4Jsg/7JzwyUPrunIFCQbzit5yX7ackVuB+WaAkAfsjKZPW2XEbL/8d+wQwdqap6nZVbcUPnNFqSmd50Uyz/xNomlL6MSffXcs5boJ7kJHtk
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(39860400002)(136003)(346002)(451199021)(36840700001)(40470700004)(46966006)(82740400003)(356005)(47076005)(426003)(36756003)(36860700001)(86362001)(7636003)(478600001)(54906003)(110136005)(40460700003)(7696005)(6666004)(2616005)(70586007)(70206006)(8936002)(316002)(8676002)(41300700001)(4326008)(107886003)(1076003)(336012)(26005)(186003)(82310400005)(40480700001)(5660300002)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 12:43:54.5379
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ca8e5bd-a949-4d9d-45ca-08db77d55553
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT074.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5766
Precedence: bulk
List-ID: <netdev.vger.kernel.org>
X-Mailing-List: netdev@vger.kernel.org

Enable MAC controlled energy efficient ethernet (EEE) so that MAC can
keep the PHY in EEE sleep mode when link utilization is low to reduce
energy consumption.

Signed-off-by: Narayan Reddy <narayanr@nvidia.com>
Signed-off-by: Revanth Kumar Uppala <ruppala@nvidia.com>
---
 drivers/net/phy/aquantia_main.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/phy/aquantia_main.c b/drivers/net/phy/aquantia_main.c
index c99b9d066463..faca2a0b1d49 100644
--- a/drivers/net/phy/aquantia_main.c
+++ b/drivers/net/phy/aquantia_main.c
@@ -28,6 +28,9 @@
 
 #define MDIO_AN_ADVT		0x0010
 
+#define VEND1_SEC_INGRESS_CNTRL_REG1    0x7001
+#define MAC_CNTRL_EEE		(BIT(8) | BIT(12))
+
 #define MDIO_PHYXS_VEND_IF_STATUS		0xe812
 #define MDIO_PHYXS_VEND_IF_STATUS_TYPE_MASK	GENMASK(7, 3)
 #define MDIO_PHYXS_VEND_IF_STATUS_TYPE_KR	0
@@ -596,6 +599,12 @@ static int aqr107_config_init(struct phy_device *phydev)
 	if (ret < 0)
 		return ret;
 
+	/* Enable MAC Controlled EEE */
+	ret = phy_write_mmd(phydev, MDIO_MMD_VEND1,
+			    VEND1_SEC_INGRESS_CNTRL_REG1, MAC_CNTRL_EEE);
+	if (ret < 0)
+		return ret;
+
 	return aqr107_set_downshift(phydev, MDIO_AN_VEND_PROV_DOWNSHIFT_DFLT);
 }
 
-- 
2.17.1

