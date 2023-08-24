Return-Path: <netdev+bounces-30445-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65550787520
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 18:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17F15280352
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 16:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 118DA156F9;
	Thu, 24 Aug 2023 16:19:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E02156E3
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 16:19:37 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 515D81BDA
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 09:19:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EH9AYvq4NNHsWULvT8egbWTYlSmljY5wU/1MyeVK7SidB98i6r6xHrtQ8oKw71SS6+gdRS0CdHEQNd5KLRiXRcVbSb8XXbC1nJ51EI2FtJLVuKvDxtVmQrztVurrr5xVwbOj0rDK4gfml+3f3ADdOIo3ZdVX8WEPxOItbQTwulGXpROpQIcHaj047YvOUhMrNSGFRew6pTe0YG/88Y2m1yLVlL9lh0JiGeOQSS1pGd89ndEQCAyXe/a3oGp6xFTdceO46x8uHZw52s3F8XYIfmlv2yKgU/Xj+T2hjtuemz6j4z33HBaRa1Vz2UFxwqqFMcEB058qTUSRixdA5Slu7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gZDajan21dnAuF/3GCLg4TYztKgVRAADAFGa7eIBgFQ=;
 b=Ho5w1lsK3R6KAHXinhmDiOEy1w3gcRNI1TvC7kcmCXl4L8+W69nQJN4lzrZQMVJrxqVnfzjRMrbTLCefm8JBzdX8E3Iuhlm4RIFBodr/Z8EymD7gR8JS0b8BGLV5mr2DRvbgGS0RIsNwx8OrXqFSfvXM9sGg/LvMXqwsxee1wInYWqlA2U7A6O6KrNcork4uOYtoNs0dFevm4uC36gHWqG5Ebi+AQr0dcd5w3rCdx5bRd4GHsH8itMJpfCrCCylYFjO//9pvIjaWHoQgb57Wtr0gN7pQ5q9bKvzJKyW2ThZZ5waon5zBYGrtH8hB93p5Png/3XNG9/nre+hMxgLRpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gZDajan21dnAuF/3GCLg4TYztKgVRAADAFGa7eIBgFQ=;
 b=RqP/4n7Q10rhxsAGe404/omY24RhrM6CmeiFhSTn5EZPWCWDcPH+yDQ72QIMrix7/IXEmbKnQ5msuHebNHSJL2Eed4ukl+Vfwb/vndC3MtS9DKn4q5Xp9EdzWY/GNkj9R8xLt7IMThY8HZMY16ZIK0JBUBAqMK/GTp+W1DyvKO0=
Received: from SA9PR13CA0122.namprd13.prod.outlook.com (2603:10b6:806:27::7)
 by CO6PR12MB5428.namprd12.prod.outlook.com (2603:10b6:5:35c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 16:18:45 +0000
Received: from SN1PEPF000252A0.namprd05.prod.outlook.com
 (2603:10b6:806:27:cafe::a9) by SA9PR13CA0122.outlook.office365.com
 (2603:10b6:806:27::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6723.17 via Frontend
 Transport; Thu, 24 Aug 2023 16:18:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A0.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Thu, 24 Aug 2023 16:18:44 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 24 Aug
 2023 11:18:43 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <shannon.nelson@amd.com>, <brett.creeley@amd.com>, <davem@davemloft.net>,
	<netdev@vger.kernel.org>, <kuba@kernel.org>
CC: <drivers@pensando.io>
Subject: [PATCH net 5/5] pds_core: pass opcode to devcmd_wait
Date: Thu, 24 Aug 2023 09:17:54 -0700
Message-ID: <20230824161754.34264-6-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230824161754.34264-1-shannon.nelson@amd.com>
References: <20230824161754.34264-1-shannon.nelson@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A0:EE_|CO6PR12MB5428:EE_
X-MS-Office365-Filtering-Correlation-Id: 35db1d52-4cdd-4029-ca3a-08dba4bdc9ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	enKvNTMNqhGhtpISB87CO5ei2rdB4eaMB71g1x+s/GmBp4HZK9D84/k6b2M7ZDm9TJ7cuIFYESxZDX8xlI6dB3D/WFxxHysg1jdgL0RCo9jLEBZtDM/wymFkvXjp1Lh8ego/fsUQ83yb0H0QcbNcwkyrdcrn2bienxTeCY0esmitaSqYOY0+kecgpjyaXwvXlc3ujn58NUvJYACC0/IhsGpkPfgcrJMlLfFXSNZS4SL8saTCV3Fb0My8ws26Eb+Z/r7SxQmYc/M2vHRgSid+re0bDjrGUNsrWV2Jsfma1h7u6SWalxZsKCx3roLUox9B/LWK0BykNI1N6AN8qrG8X2xKdjAvfNvR/pWC5XmkwSP3dXgcagsGjk5D/6AF/kTl5IROWf6v8Ey6cByW+DK5H5t//it3tJjRQEIKBPcSpzFY0ViR5ymlf5t2Ra1WQyR1fvI63myq/rEtrh1t786iMZbD0vWnerIoPkUQfH+2AhMvCUHTlNvV3pP7V0/MTT3khay7g0E8avzGeGo/q+bGsmpseNrHYhRI8GJU6lvrjMK+LBeLQwuatK9lwbKxRIYnqJfEAXyUaD4k+3S4ZnarfzFMlwCHqKnkWWtSjGA9SqZ4gGCC3NLg/1HgjXVjABYslznvwu9vkkw+lvBihsXaBq9mBRnWztxzfz+bwkGzK0t6QHqaGhMdd+r29fEenoaTdlyxmzWZKB+2k4TchrqZlnd9X3OFlEDJwnqyST0n6R3aDldpKjoWw2h73B0hIk1pOymvulVypQtT4KlPOtNxjA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(396003)(39860400002)(376002)(451199024)(82310400011)(186009)(1800799009)(40470700004)(36840700001)(46966006)(70206006)(70586007)(316002)(478600001)(110136005)(26005)(36860700001)(44832011)(356005)(6666004)(16526019)(40480700001)(82740400003)(81166007)(41300700001)(86362001)(2906002)(8936002)(8676002)(4326008)(1076003)(40460700003)(2616005)(5660300002)(83380400001)(36756003)(336012)(47076005)(426003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 16:18:44.5814
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35db1d52-4cdd-4029-ca3a-08dba4bdc9ea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5428
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Don't rely on the PCI memory for the devcmd opcode because we
read a 0xff value if the PCI bus is broken, which can cause us
to report a bogus dev_cmd opcode later.

Fixes: 523847df1b37 ("pds_core: add devcmd device interfaces")
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
Reviewed-by: Brett Creeley <brett.creeley@amd.com>
---
 drivers/net/ethernet/amd/pds_core/dev.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/amd/pds_core/dev.c b/drivers/net/ethernet/amd/pds_core/dev.c
index 524f422ee7ac..f77cd9f5a2fd 100644
--- a/drivers/net/ethernet/amd/pds_core/dev.c
+++ b/drivers/net/ethernet/amd/pds_core/dev.c
@@ -121,7 +121,7 @@ static const char *pdsc_devcmd_str(int opcode)
 	}
 }
 
-static int pdsc_devcmd_wait(struct pdsc *pdsc, int max_seconds)
+static int pdsc_devcmd_wait(struct pdsc *pdsc, u8 opcode, int max_seconds)
 {
 	struct device *dev = pdsc->dev;
 	unsigned long start_time;
@@ -131,9 +131,6 @@ static int pdsc_devcmd_wait(struct pdsc *pdsc, int max_seconds)
 	int done = 0;
 	int err = 0;
 	int status;
-	int opcode;
-
-	opcode = ioread8(&pdsc->cmd_regs->cmd.opcode);
 
 	start_time = jiffies;
 	max_wait = start_time + (max_seconds * HZ);
@@ -180,7 +177,7 @@ int pdsc_devcmd_locked(struct pdsc *pdsc, union pds_core_dev_cmd *cmd,
 
 	memcpy_toio(&pdsc->cmd_regs->cmd, cmd, sizeof(*cmd));
 	pdsc_devcmd_dbell(pdsc);
-	err = pdsc_devcmd_wait(pdsc, max_seconds);
+	err = pdsc_devcmd_wait(pdsc, cmd->opcode, max_seconds);
 	memcpy_fromio(comp, &pdsc->cmd_regs->comp, sizeof(*comp));
 
 	if ((err == -ENXIO || err == -ETIMEDOUT) && pdsc->wq)
-- 
2.17.1


