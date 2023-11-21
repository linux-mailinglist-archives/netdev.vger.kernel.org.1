Return-Path: <netdev+bounces-49773-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB91B7F36B7
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 20:15:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7105428216E
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 19:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 286A85A113;
	Tue, 21 Nov 2023 19:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KLX49tQ8"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11F9810C
	for <netdev@vger.kernel.org>; Tue, 21 Nov 2023 11:15:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zf4jvmN6RP2MQfHUwf1VaPERW/9EI/zejUTv3dkCsMDOwhYvxhRvFAmFqT+bJrNcWcE/OY/HRzI6rWSGUzXX/NNHnD+v/i5MgVw+J2747HkBa2l9jS7YkM7jaHjGx1qW8OHnYircKnOWUguPLVo/gXJc+2d0oA3c8IMGL1zJBipvHlA2x2Kry59JAnq4NWd6THGfEpAl2hJLJBGreSn6opbN/i3SfSxc4QSLGywxCWr+PemBsEpJlYAPBxhI2hRmxjSQYw6T/4q8E34RDGTR/VV3Xs3fVclh/58d/fWfqp2yrJX2+8dqes80qtKA+Z1boHp1nIkk7YJcd5T0X9fu9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fMuAftdx4n6oDKPwx620CU3c1sJAOKWsTvTW1DZmPvc=;
 b=GA9vbbA1vW4IMPHxMo+JWgb/hBXm+l84XvES7djLl4rfT6VkeShXF0RnlmeTv/I2xLudoZG+M6Fdo6YV7h/tP1+aL1b+M3+w/x3jALY7cswGC+c85kdCXdOWgp4Ah1Tc6B1IgE7NYx/qsBgeHpiNIexXaobe+bZRU12ec1TvhYQmlIwl1U64v4RdyLhkMQc0bvYPo1UqTOpUbkRwehdsHsrhde94q7EfT+dq1svpwTDr0OVTe5YqG0Ghjayj4HefPSvE7H2vJiZ4dGXanneKZKNlvVflGrpnjdwMau05f/JDi6w4mYQUf76YxzLTdGr6k9q852HuyiizXiCyuS0BwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fMuAftdx4n6oDKPwx620CU3c1sJAOKWsTvTW1DZmPvc=;
 b=KLX49tQ8qg9RjqZvuIiCTmRY8ent0qHfacdhn0xlQEdGD2mq//xlHEMsOI1NZXN8oBPDQtOyFgVbzusoWRE31lUojEH/pJW/qDq8zPlRVnBvtnuSVj1bzQMjlwetPTCCm7LETwQat84pHAVnKvfIw5aQsV1MDsr9OeFmC26C47o=
Received: from CY8P220CA0006.NAMP220.PROD.OUTLOOK.COM (2603:10b6:930:46::24)
 by DS0PR12MB8786.namprd12.prod.outlook.com (2603:10b6:8:149::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.26; Tue, 21 Nov
 2023 19:15:20 +0000
Received: from CY4PEPF0000EE34.namprd05.prod.outlook.com
 (2603:10b6:930:46:cafe::81) by CY8P220CA0006.outlook.office365.com
 (2603:10b6:930:46::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18 via Frontend
 Transport; Tue, 21 Nov 2023 19:15:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE34.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.13 via Frontend Transport; Tue, 21 Nov 2023 19:15:20 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 21 Nov
 2023 13:15:16 -0600
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <Thomas.Lendacky@amd.com>, <Shyam-sundar.S-k@amd.com>,
	Raju Rangoju <Raju.Rangoju@amd.com>
Subject: [PATCH net 1/3] amd-xgbe: handle corner-case during sfp hotplug
Date: Wed, 22 Nov 2023 00:44:33 +0530
Message-ID: <20231121191435.4049995-2-Raju.Rangoju@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE34:EE_|DS0PR12MB8786:EE_
X-MS-Office365-Filtering-Correlation-Id: e17d6d0f-382b-4166-167a-08dbeac63424
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ULoxwqW7flHs8sUYaYs68K1u9rFnjaK8869/P9Gyy33V8d782A+1xKhzZBHRq9iPZwu1H+5IE44WdNsGYRAUmPoiyeE+Dp/fpSDTf8/44HXY25Os71hi0Ae+c9ME8k9QqKmZ9QvbiL1kVhpE1CYQaz6ccB8HXoIPVOm8Td1+H5ROb3aVhUP5rDYq79nKBjEIRlrxzaPYjTRC+09MWbEQa5HXOB6P/p5mqD6wahhfq6KqaMq0lSRuLGbdo7EsdjTrmxR+cBtU1lTo+WEoJSkj5Z9Aj3FRcY58deLrYMeLKMjx0cxlUZ02yS6szJ5i4oPMYrwo66q/tC1We3iBqYlhb9umQNVEk4q9Y30dP0LKJAIzBJ3/H8gOuxidPuZf0nAGzF7lgKOkDsQW+bI0TLQ8cpJ37MhO4lLU0RODQwHDazP3Y/qJIxWzQPfdjJYJQUhP9LczyyUZ0M0b+1rrlzoya8CdyO+FPP3H5sNqZYUcE53ZLaUMbPgMjAlHS0m07Ft4ya56WhAV6XgqiRKx5pF5Lrg8BtTcvQy0y/o1B/FpdhK4c9GY2GJ7wB7Jo7oxGeyzU0H617rqRF+w8voMRRGGf8R8U1Fj7PYCbIqWMVnwOpiB5K4JKv+0xx18QNmN+XnLoE1KX+9tMXRt0ExC3dJgb+pEbQmWeV57iirQbg0TIYseQfaO8FfEDN6kAeUg0cepDgQcLyXJoCwhjbY8KRtFuBbfE24H3zBHvUeK4XABXpqDExQTVImNdAq/kGB7CoO3iRY+o9kpzCQwiHzPnMvSVg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(346002)(136003)(396003)(230922051799003)(186009)(82310400011)(64100799003)(1800799012)(451199024)(36840700001)(40470700004)(46966006)(41300700001)(47076005)(2906002)(70586007)(54906003)(70206006)(36860700001)(81166007)(316002)(356005)(6916009)(6666004)(7696005)(478600001)(336012)(26005)(83380400001)(16526019)(1076003)(426003)(2616005)(5660300002)(82740400003)(36756003)(86362001)(8936002)(8676002)(4326008)(40480700001)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 19:15:20.1167
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e17d6d0f-382b-4166-167a-08dbeac63424
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE34.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8786

Force the mode change for SFI in Fixed PHY configurations. Fixed PHY
configurations needs PLL to be enabled while doing mode set. When the
SFP module isn't connected during boot, driver assumes AN is ON and
attempts auto-negotiation. However, if the connected SFP comes up in
Fixed PHY configuration the link will not come up as PLL isn't enabled
while the initial mode set command is issued. So, force the mode change
for SFI in Fixed PHY configuration to fix link issues.

Fixes: e57f7a3feaef ("amd-xgbe: Prepare for working with more than one type of phy")
Acked-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
 drivers/net/ethernet/amd/xgbe/xgbe-mdio.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c b/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c
index 32d2c6fac652..4a2dc705b528 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c
@@ -1193,7 +1193,19 @@ static int xgbe_phy_config_fixed(struct xgbe_prv_data *pdata)
 	if (pdata->phy.duplex != DUPLEX_FULL)
 		return -EINVAL;
 
-	xgbe_set_mode(pdata, mode);
+	/* Force the mode change for SFI in Fixed PHY config.
+	 * Fixed PHY configs needs PLL to be enabled while doing mode set.
+	 * When the SFP module isn't connected during boot, driver assumes
+	 * AN is ON and attempts autonegotiation. However, if the connected
+	 * SFP comes up in Fixed PHY config, the link will not come up as
+	 * PLL isn't enabled while the initial mode set command is issued.
+	 * So, force the mode change for SFI in Fixed PHY configuration to
+	 * fix link issues.
+	 */
+	if (mode == XGBE_MODE_SFI)
+		xgbe_change_mode(pdata, mode);
+	else
+		xgbe_set_mode(pdata, mode);
 
 	return 0;
 }
-- 
2.25.1


