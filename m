Return-Path: <netdev+bounces-49775-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 706877F36B9
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 20:15:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F3F91C20D80
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 19:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69AEC5A117;
	Tue, 21 Nov 2023 19:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2M7w5ruy"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0813A91
	for <netdev@vger.kernel.org>; Tue, 21 Nov 2023 11:15:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YYVismvyb3kRtjwO03c66L7iJkWvOgJHlh7GktQ4Vwbyi4gIR6ecqIrmj6aL2ATiCPKJwUAeFDbrtawpvj6VXOKiF6EXeGNnYLEdZpLhHuJ04WhmyaUsRTp2xGi5o89LzOeryQsRAK+2TU1589Pnswedcu0t98w9l+/Di1VlVrFDbgVHi7etTN2QXn8YnaMM/PmNqfDUHN2ygPwrNMzP4sLZ/99reqzycSfRQ074Ev8RFFn5aPt+l5KMvLSxfjc3HhVzw6OyiD1fxwUnvkI5rd+n3cwErGNnC03CV7qe9bJ/rLbP+9wNa5O1/9Xrj6H6wQQ0KV1vYHVw0y+zOKwx5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LSr6chTPZdniVg0vUtv8tpRaiYlDoWKtSi4SFaG/AZg=;
 b=oXZUje4339VTSgwRjQg8JslVkFR5uJYepRqxqQsAPpA5dFc4sfXuboNX+2q4s1BO7x0ck+q5RNGDIfpM/FkrFz92bbQFACV59t2Z11lE5ph7osHJ+0pQ9Io7aXASJ9eHNW7SPfqkcUdiLjuRHvvdqa44KB9TAx63BHCDVuKjg4W/mSmco2741C5c78nAFW0nfvXv8Xj9PaROIGLiSpbyA4IyrUbR+QWXmc7Ht6onfMgYZQnSCuvYJjbCGZ/+hMGUCKr68ZxsWp1M45rW0gW8qjy5ykd1HWBO76qtTlJqbEcIBIWCRvxl/2OlMgGsvSUAWYWdHjOPQXzi64tKv5Uv7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LSr6chTPZdniVg0vUtv8tpRaiYlDoWKtSi4SFaG/AZg=;
 b=2M7w5ruyFjhrwvab6oZUuBLv2PAmFNo4IJbuOIb6fL83CuaLQ4kD8DmrYQs6g/bYP8Oj6RnVRo0nfmLKmvEY0vBHp2M+Q3PFj0rDN3kc3ZdJGVGlNq4M7xBmpjz9xeMj5rgwfsKlS4W1Y979WluW5i9YNPAcK9LSExGW4rECgug=
Received: from CYZPR11CA0005.namprd11.prod.outlook.com (2603:10b6:930:8d::13)
 by BY5PR12MB4999.namprd12.prod.outlook.com (2603:10b6:a03:1da::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Tue, 21 Nov
 2023 19:15:27 +0000
Received: from CY4PEPF0000EE31.namprd05.prod.outlook.com
 (2603:10b6:930:8d:cafe::72) by CYZPR11CA0005.outlook.office365.com
 (2603:10b6:930:8d::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.28 via Frontend
 Transport; Tue, 21 Nov 2023 19:15:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE31.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.12 via Frontend Transport; Tue, 21 Nov 2023 19:15:27 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 21 Nov
 2023 13:15:24 -0600
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <Thomas.Lendacky@amd.com>, <Shyam-sundar.S-k@amd.com>,
	Raju Rangoju <Raju.Rangoju@amd.com>
Subject: [PATCH net 3/3] amd-xgbe: propagate the correct speed and duplex status
Date: Wed, 22 Nov 2023 00:44:35 +0530
Message-ID: <20231121191435.4049995-4-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231121191435.4049995-1-Raju.Rangoju@amd.com>
References: <20231121191435.4049995-1-Raju.Rangoju@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE31:EE_|BY5PR12MB4999:EE_
X-MS-Office365-Filtering-Correlation-Id: ff7b0712-0560-47b2-7b2f-08dbeac6388a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TMSe2Unl5L3lDIJrGkxDcJns1v5Xf1w3NUcHn6rBiSgA52MmKGHs9yeZWG0Crw8PVRF8vq6V8iLcqA+UKNwJ86LnuYCyO6XUxRwObHl/2vGNaEUJI9DtEU32PU6nmzQ3jAvgU3/rYM+JiQZFNWQMjMQwYxJM1dxzveEZIJmfAIXdhvCHWiKr3Zjfph49hk7wsIzZRgHK80XaUCHJYKVYoZOZ1cfTTHZZ/J9wvm2X8nNQdfZq49Zjwx7guq8Zg6TQeg8reyjDFU8gUi+dCUtrbgh8LLVonUEgaUSxEnDlNg7hMSTw0PKwpN0wZ/Lz72mqAlP3Ek3xSKg9/PAcvmMIOd+2gkjsVo1TG4OrGG4Y/jt7J66+Qe2FIKhq1Hs45fNDJmfwzFQmWjzFCEfmUVUja6pbjz4XJYQmZJdo84a1nDwZqAIB6eW8Xk5nR07pihbmRkvNyxC8Q1vi/05WbhE8NuB+UMfDQCH+B1dgC6Ma7TDHu9Dpm4Muubjlzfv81u/UHSp1wmGhBwwo2mbHFBT3xqZQfzL9A0K0cGoL549cRCjORBJLC3GXayIMVNAYK058PtJB4YE9KVOTbt/HXbB4MGIrw3cqd76ik2v0JcYtNcXsp8LM3j8GKuLgSSQIRkFuMamRFvK8/PE9o5MwuRVgnAXnKXyNHlafj5nxz+WDdWDe5dWY4vhQCdQ2ZSDXLTHtjHOkt3SHLZDPiyY5jch9hsMXyLpqFMHXIFB7H0oSW7GWsLeSk+ZbSlIr31aoV8ftKi1Uk5C+m7rHidT4XLIYmA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(396003)(136003)(346002)(39860400002)(230922051799003)(451199024)(186009)(82310400011)(64100799003)(1800799012)(46966006)(40470700004)(36840700001)(40460700003)(83380400001)(426003)(336012)(26005)(16526019)(1076003)(47076005)(36860700001)(4326008)(8676002)(8936002)(2906002)(41300700001)(5660300002)(478600001)(70586007)(7696005)(6666004)(70206006)(54906003)(6916009)(316002)(36756003)(2616005)(81166007)(86362001)(356005)(82740400003)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 19:15:27.5143
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff7b0712-0560-47b2-7b2f-08dbeac6388a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE31.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4999

xgbe_get_link_ksettings() does not propagate correct speed and duplex
information to ethtool during cable unplug. Due to which ethtool reports
incorrect values for speed and duplex.

Address this by propagating correct information.

Fixes: 7c12aa08779c ("amd-xgbe: Move the PHY support into amd-xgbe")
Acked-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
 drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c b/drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c
index 6e83ff59172a..32fab5e77246 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c
@@ -314,10 +314,15 @@ static int xgbe_get_link_ksettings(struct net_device *netdev,
 
 	cmd->base.phy_address = pdata->phy.address;
 
-	cmd->base.autoneg = pdata->phy.autoneg;
-	cmd->base.speed = pdata->phy.speed;
-	cmd->base.duplex = pdata->phy.duplex;
+	if (netif_carrier_ok(netdev)) {
+		cmd->base.speed = pdata->phy.speed;
+		cmd->base.duplex = pdata->phy.duplex;
+	} else {
+		cmd->base.speed = SPEED_UNKNOWN;
+		cmd->base.duplex = DUPLEX_UNKNOWN;
+	}
 
+	cmd->base.autoneg = pdata->phy.autoneg;
 	cmd->base.port = PORT_NONE;
 
 	XGBE_LM_COPY(cmd, supported, lks, supported);
-- 
2.25.1


