Return-Path: <netdev+bounces-30440-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DCA6787517
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 18:19:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D79B31C20E42
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 16:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF03914282;
	Thu, 24 Aug 2023 16:19:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E15A14263
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 16:19:28 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01A291FF1
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 09:19:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DfPaXY1QAhO8xC9mAkV7LvdzmCq3ng6qu/r8BzQPU0H4oTUtYjZjZc5unvJWbiXqxgwwkfFL9Wk2K9jAJFdo5mFn96K8xfZMkCmoMNyqybQqG7Z4xvgdJKZONfmUNJW6+YseQB7TJvJKEcXpSnIGOrogYd8KyuZyEv5T4l0s5yTli2OFgUFfyYSOvY21jPcKxA0EY7P9rH3Oyq526JARih/Ov6AcQnpqZZ7ri3Z2jhU5POGXjqq3dhHZRPnouGRpfNUsJ1KGWjQBddcsJAB6dz9FfDGjlslrYrGD/lM/CDAN69TTyrBhLPAYva30J28wRVoybI6Ev7kxNsO7pbbl8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EZ3KK8tgnsFHl3oDf1XaSW9ntjihzz9jxrRCgZn+zdg=;
 b=EDdldyMAGeJi0v4whcGiuLfGBIiV7RoQT/hwbl6t+V0WFywIaR4/3729VSy8VZ+4aS9A6yDnU9zJ+tktcRaDX4Ft2db77C57EM4mPmnYn9PlPvfVxGS8dXBsIN2OAB0ygZI6iAFyqUGQHjDfx8U4CPU2qyBs0Xu8HRxWx4rbZBlFgG0Ifm5ODJ11sZ5Fz0loDoSVtCVcLR8sEj00BbKCiHOScaaJ0DQHS7MuhrtzzhfglZF1rvftGLj2E74tn3DHHRvU+ODq+Cu38KAOSqZfRBhy5tkPQ6IyZPgxclxpQOM7Y/7iuLObbxjzOEcoMT2pPQcagKw6IZuxTzwHG51Dsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EZ3KK8tgnsFHl3oDf1XaSW9ntjihzz9jxrRCgZn+zdg=;
 b=r0nEpD+PuG0aSJSTbK1xjmhSHQj0CXU3k3EwghCmECCKh+Ws8dZ5Oq8XpKb3xWX2C3kfQMAlqBBaL4TD4x5Uw41sEHM/ZKyFnnAL0ajckXZSfLUqO7p8Ejk/5L+HcIO5vHOHm3xqiuBPM0ZU74kF49Ab9RBEuKvcrf41IdCSG/Y=
Received: from SA9PR13CA0046.namprd13.prod.outlook.com (2603:10b6:806:22::21)
 by CYXPR12MB9428.namprd12.prod.outlook.com (2603:10b6:930:d5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 16:18:24 +0000
Received: from SN1PEPF0002529F.namprd05.prod.outlook.com
 (2603:10b6:806:22:cafe::9d) by SA9PR13CA0046.outlook.office365.com
 (2603:10b6:806:22::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6723.15 via Frontend
 Transport; Thu, 24 Aug 2023 16:18:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529F.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Thu, 24 Aug 2023 16:18:23 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 24 Aug
 2023 11:18:23 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <shannon.nelson@amd.com>, <brett.creeley@amd.com>, <davem@davemloft.net>,
	<netdev@vger.kernel.org>, <kuba@kernel.org>
CC: <drivers@pensando.io>
Subject: [PATCH net 3/5] pds_core: no reset command for VF
Date: Thu, 24 Aug 2023 09:17:52 -0700
Message-ID: <20230824161754.34264-4-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529F:EE_|CYXPR12MB9428:EE_
X-MS-Office365-Filtering-Correlation-Id: 78509a27-f32c-4738-521d-08dba4bdbd99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	EKfTS735GCZZuljQ6VS2owcILzehJsPdV3DYrhGsvqwLB+bxn1l/PD+JhgigVaqsgGMOgyuOmlqvf1AfZgofvcswks4yvF/ulJYcFtDJI9v6Qt/MIXi7aEEmRRGqAakE6QeDGomKusUrwy9slckXnRHW4oVai83uOU7OZOJ+tXdE1nRUXjoXTzTMqFzWx/dFkwXRLDjJvT2CnwgiAIX8sEnlFcyhEW1ewHKMcNWI99ePb7rYnUFeLshzb6EB5adPg9Zj0NdQgvNC+fNGY6QwXI3lJ30zJmaFSBsKYHMXfpWNSlA2W6jcoIanxfc0hYVO/v32M9hhpohUC4JLUCNci1Eq9+VIJ7g0vdGxRMA2Ic4qFUfdroW74um+i3CuRyyR98FVZjbX4CqpMHKvzwmd90pQ8Pr43I2pzu9jIcYe50LnvZLBc21q7xOuz4vSF7i5nor0r2Wk31FGtfrScMi/nKClmI7KNtzS0oVBaSkNYVFCAkN0sEyfees+ryapDoEYpuZoNMgTpuU9t1KUseacFbTrVHLDnx1VPiUoqYvEyjbKIIWm3XYfJBDXHKt37duiqdoBfsWJNYsewdU5vPYJmmMglEkwvJ8/WnuvOrsFi4R2fCSc2oxt7Ar3IrI3eU7II+v+r3UwF81EalkiXQRNgZFAnqNbxW2yxmafkIDMDFx6zSyhHGARDsb62z2K0EralipKrbMZHw1qWuiRcsviAc+NlTcLGB78nSAcQSrZClOcEi41jgV7BC/T3CruevqVTxRhnofCAjDP4rjf2DtKfw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(396003)(136003)(346002)(82310400011)(186009)(1800799009)(451199024)(36840700001)(40470700004)(46966006)(1076003)(40460700003)(2616005)(5660300002)(4326008)(8676002)(8936002)(336012)(47076005)(426003)(36756003)(4744005)(83380400001)(44832011)(36860700001)(26005)(40480700001)(16526019)(82740400003)(356005)(6666004)(81166007)(70586007)(70206006)(316002)(110136005)(478600001)(41300700001)(2906002)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 16:18:23.8835
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78509a27-f32c-4738-521d-08dba4bdbd99
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002529F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9428
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The VF doesn't need to send a reset command, and in a PCI reset
scenario it might not have a valid IO space to write to anyway.

Fixes: 523847df1b37 ("pds_core: add devcmd device interfaces")
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
Reviewed-by: Brett Creeley <brett.creeley@amd.com>
---
 drivers/net/ethernet/amd/pds_core/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/amd/pds_core/core.c b/drivers/net/ethernet/amd/pds_core/core.c
index 383e3311a52c..36f9b932b9e2 100644
--- a/drivers/net/ethernet/amd/pds_core/core.c
+++ b/drivers/net/ethernet/amd/pds_core/core.c
@@ -464,7 +464,8 @@ void pdsc_teardown(struct pdsc *pdsc, bool removing)
 {
 	int i;
 
-	pdsc_devcmd_reset(pdsc);
+	if (!pdsc->pdev->is_virtfn)
+		pdsc_devcmd_reset(pdsc);
 	pdsc_qcq_free(pdsc, &pdsc->notifyqcq);
 	pdsc_qcq_free(pdsc, &pdsc->adminqcq);
 
-- 
2.17.1


