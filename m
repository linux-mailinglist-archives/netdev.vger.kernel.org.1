Return-Path: <netdev+bounces-60303-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 135CE81E7D2
	for <lists+netdev@lfdr.de>; Tue, 26 Dec 2023 15:19:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25DC51C20FB6
	for <lists+netdev@lfdr.de>; Tue, 26 Dec 2023 14:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D7344EB5A;
	Tue, 26 Dec 2023 14:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RSrrIy9x"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2089.outbound.protection.outlook.com [40.107.244.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38624EB42
	for <netdev@vger.kernel.org>; Tue, 26 Dec 2023 14:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O9hjCsunSuwKA4/KzBsaSukI7pfBhZNCbMXB78VWlUX32dwEXyMjjqphANP2LjndNqhkeWTKXVK/45ufGgK26gsay01Y/shHF+M2X+7bYRAuhR7CTtrrxwMOi+5f4nhScOd9I0rmjdxmIYBnswA/YAxgm6zH7q4ov49LWaa4wLGerF5APXikDIoxh7hzlXrcNSTV/+tqBTGxpWdVC3lxjU2910Fu04sK/vf7/7X/cylZEb2lnainc9G3PoRF6bbtxPZ1dYxT320ysI7gOpmBqx54Tc4iYmfvqYVC557YphKDhMOKrS2yccGsZdOJbfNL4rD6SznlZRLxSW8wR1Oewg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=knLvw67xFFGDThGy09ujAZXpOwVwrej1/BYC4VsY8MI=;
 b=MidGJLkR75usr+yUiNc0IMm15HKlkVo01pADKjL9aEPhUAZAwHdWmfl6ULo8MOligkpA1XqUXqVEMtDE2c98qnMITijFc6QuW/HANVlNyjM7JPAJjKA+3zDAVMYKznR6Zf2GB2hQFbWMXlSGCGTKXg3HUI6P0Obz1PcFWrOhE0lPZVT7PZdCYUzk+Piv48itNvOY3C/Ol29yjvaykvky4Q4YArTXoJLJ8w/7aI+59KRap0HFF+SWOoDDGF47zoK3QXyNxbDUtEXC4W4e36LxIKrj2WiGtFK62QM4wQCoVmMNsIh6Nf2ezmWhYx1lGLNkIUO2mSfgpS30jHtAB4zddg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=knLvw67xFFGDThGy09ujAZXpOwVwrej1/BYC4VsY8MI=;
 b=RSrrIy9xibGTQwiXJ6MQThuiC1qfrEsoWOAD8Pc7jNXahUZ5RZ1mtAEC2ahrL9nJnhFBiXgiS7RlwT+DPeK5daByRzc63IasFu/gUf5DIQGKY6xcPXLg6lSUv148fa3/qEiMkizb2GEudC2CaXhvYITGnjDlOkSOXv8Z1RQze6EUZymZG5viu095p9hGqmKqaxe4lJZe5VwXnztGy4lvW76RDu6MWl0sQ7mocD5UfbyL5rb/KVRFEPtKtImkzJ/EJSbm59PFW+LJL0an96LkBbw4yceRbt+6lY1LiycXnMzz4dFWBcpxi/gbsPlj4rzNiJyYYjmjKhlg/J+bpOSq5A==
Received: from SJ0PR05CA0098.namprd05.prod.outlook.com (2603:10b6:a03:334::13)
 by DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.27; Tue, 26 Dec
 2023 14:19:18 +0000
Received: from SJ5PEPF000001D6.namprd05.prod.outlook.com
 (2603:10b6:a03:334:cafe::7e) by SJ0PR05CA0098.outlook.office365.com
 (2603:10b6:a03:334::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.17 via Frontend
 Transport; Tue, 26 Dec 2023 14:19:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001D6.mail.protection.outlook.com (10.167.242.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7135.14 via Frontend Transport; Tue, 26 Dec 2023 14:19:17 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 26 Dec
 2023 06:19:07 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 26 Dec
 2023 06:19:07 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.986.41 via Frontend Transport; Tue, 26 Dec
 2023 06:19:06 -0800
From: Asmaa Mnebhi <asmaa@nvidia.com>
To: <davem@davemloft.net>, <linux@armlinux.org.uk>, <netdev@vger.kernel.org>
CC: Asmaa Mnebhi <asmaa@nvidia.com>, <davthompson@nvidia.com>
Subject: [PATCH v1 1/1] net: phy: micrel: Add workaround for incomplete autonegotiation
Date: Tue, 26 Dec 2023 09:19:03 -0500
Message-ID: <20231226141903.12040-1-asmaa@nvidia.com>
X-Mailer: git-send-email 2.30.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D6:EE_|DM4PR12MB5040:EE_
X-MS-Office365-Filtering-Correlation-Id: aea906f7-f2f9-43a2-19cc-08dc061da568
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZTDpkOcBMqxNbHV+uk3ywSpvESAq06xiweqHFhNOmNLWU6TPioymgcszChPJBPsYbCeQRWtQZIsP6xjvTXuEPGqhf4tCSJFEkPnHZx4ggmNQvKV1gTCcxeqLcjWhfuddoec8aAhF7MiXYC35vOe/dzybIYH/e1JT4TNTuBHv+POxJOeoAmA3etmx1AuU7VbH4X0sKXnUrQiTbMBvnYLa9T8YQDnuBICkow6Vuj0+Pz823IV98XLgklczYASDKiy3ZqD5cxKWW+0lm7NAostltrOaYGoyikoTqCCy+SeTzpOliLghwMNAbMviy6ymYZSjCzwziedA6NljWnBbP1s+Nnn+2wwGsjiCd61LXdWHg+RLt/iIZB+Id334u/xhudDOra2xS2iVgXXQSTeqCFTnEakWATCOafiQPyI5GlVPFIBT4qwYkNaAlNDDtyFfsRuhVnH+bX/CaNSWABqPnJH5hGgd9A8yUDCbpaQMBR3nxXKETXPSkzEinE4DRjbEXxXwmdPjKqnlhvMhQgU2v4zwPm5jeNs2FYAFKAJgihZ1gEP8CzlUnixBI7UsMaykFIEoj80wlUiUYe3df1dS5phE1rSJpXsNUYn2yR4/QB/REAVyMi5lrfHJu/1Le6tXKOKjoe34S54Qh2siYCRlJq3am/l9jb3eL9HedGiItl+KKFevL3GryM34CNwNgRhtpGd64OjXeQQCgU4n5eiCG2ej3Ee08MZE8sW+uV6BZhWfDvu3F4JULFggU1t7TrLoEV8s
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(39860400002)(346002)(396003)(230922051799003)(64100799003)(82310400011)(1800799012)(451199024)(186009)(40470700004)(46966006)(36840700001)(2906002)(5660300002)(110136005)(54906003)(70206006)(316002)(478600001)(6666004)(7696005)(36860700001)(7636003)(356005)(8676002)(8936002)(4326008)(40460700003)(40480700001)(70586007)(41300700001)(47076005)(82740400003)(1076003)(2616005)(107886003)(26005)(336012)(426003)(86362001)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Dec 2023 14:19:17.7399
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aea906f7-f2f9-43a2-19cc-08dc061da568
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5040

Very rarely, the KSZ9031 fails to complete autonegotiation although it was
initiated via phy_start(). As a result, the link stays down. Restarting
autonegotiation when in this state solves the issue.

Signed-off-by: Asmaa Mnebhi <asmaa@nvidia.com>
---
 drivers/net/phy/micrel.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index 08e3915001c3..de8140c5907f 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -1475,6 +1475,7 @@ static int ksz9031_get_features(struct phy_device *phydev)
 
 static int ksz9031_read_status(struct phy_device *phydev)
 {
+	u8 timeout = 10;
 	int err;
 	int regval;
 
@@ -1494,6 +1495,22 @@ static int ksz9031_read_status(struct phy_device *phydev)
 		return genphy_config_aneg(phydev);
 	}
 
+	/* KSZ9031's autonegotiation takes normally 4-5 seconds to complete.
+	 * Occasionally it fails to complete autonegotiation. The workaround is
+	 * to restart it.
+	 */
+        if (phydev->autoneg == AUTONEG_ENABLE) {
+		while (timeout) {
+			if (phy_aneg_done(phydev))
+				break;
+			mdelay(1000);
+			timeout--;
+		};
+
+		if (timeout == 0)
+			phy_restart_aneg(phydev);
+	}
+
 	return 0;
 }
 
-- 
2.30.1


