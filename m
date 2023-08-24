Return-Path: <netdev+bounces-30444-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2806E78751E
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 18:20:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1B4A28159D
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 16:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E5D014287;
	Thu, 24 Aug 2023 16:19:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71728156E3
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 16:19:37 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2078.outbound.protection.outlook.com [40.107.237.78])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A001BD2
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 09:19:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YGgGrzztuL+ISS+kuXuhDdusF2FxnOBVRNUGkw+PiLb7Yri90K0nu0NP/DmQwLA+AwWgd/F3+Iq+nB8DyORBI50hBf5Bxme6uB9ck9m3ei14Ft44z0B7rOdm5M0XYfuGgbP57cakB122Mk+K6P9Rnbpy/t2T1NdWvS9egPCJ8z2RAuTXTxfgZMh+HdP7+1hNlxNMq0cs473Druydfa5MLS7INQ7G/jm/hYxOi8VK/OPwapmZserUkmPaw6Qm1HIdu+thZpNIRUy1WiO5/1qgPSdBtpTDnZfFUl/COKh75Laufryj6vnIeMS616HAOp2meWFnIMNlkfNqlPGsVvht+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q6+ROe/03hW8drri50sCjF7YkNtwxwBRSet++U/hQtY=;
 b=dqyrGx0KIBlo+46nqO6HVh90O0rzaDEtt7++YzPQV+97BzcjuhhQtU4Ht7UjoZSPstBOj6xTDP6U9P/e5RcimeiHyY7/Cq7nxpN8ZMt4Na6s4BzPK2I/QBo7UuuwdbE6cq72B1NLXSxvr3BEqCBnWfYecaN/BWFXoAkdfvvX2fAFDJ3yMjszIWI4iyxZGtbghnuY9X+sVnL6gpBjUiHepQCUfEo2UlysMrQwt+lzjLE8No2kES6o28ZYyiQjh8fx27ozajX8XeoQwzoV2EOWfl3mmZCmOBUXRbrixzoGiRSc4zLJct00dTCV3rgvVoAc+kN6MubbwSlbnKhegDse5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q6+ROe/03hW8drri50sCjF7YkNtwxwBRSet++U/hQtY=;
 b=Y9pBAgrxq5SHlIqyWyIUZktmDYItlUEpdZsX8P0pzxTlpPSWrwKPqwWx+GtRgy9h2gDbSVOZnrLsdSMjX8ZRwRI+t8sT2lBPjJmGdQNzqjrT/VhKhffw3Er4vogjAM3qf+I/mFG5ZiXzot3YJJjbUuzHUmaFPMKJmebogjHJ0wU=
Received: from SA9PR13CA0035.namprd13.prod.outlook.com (2603:10b6:806:22::10)
 by IA0PR12MB8088.namprd12.prod.outlook.com (2603:10b6:208:409::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 16:18:44 +0000
Received: from SN1PEPF0002529F.namprd05.prod.outlook.com
 (2603:10b6:806:22:cafe::b0) by SA9PR13CA0035.outlook.office365.com
 (2603:10b6:806:22::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.15 via Frontend
 Transport; Thu, 24 Aug 2023 16:18:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529F.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Thu, 24 Aug 2023 16:18:44 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 24 Aug
 2023 11:18:23 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <shannon.nelson@amd.com>, <brett.creeley@amd.com>, <davem@davemloft.net>,
	<netdev@vger.kernel.org>, <kuba@kernel.org>
CC: <drivers@pensando.io>
Subject: [PATCH net 4/5] pds_core: check for work queue before use
Date: Thu, 24 Aug 2023 09:17:53 -0700
Message-ID: <20230824161754.34264-5-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529F:EE_|IA0PR12MB8088:EE_
X-MS-Office365-Filtering-Correlation-Id: d70a5e91-c447-434f-2279-08dba4bdc9a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CQz1Vu6PNPta8UKe7B42CqhUm7c5x9jwvlp6kOSsTZF1Xctb4ZiGy2QcHxWE8QY9jETqXBpdpnjrTg+Zy7EPa6nIOXDWGUqsYjm2Gya8pr5iSyu/ZUZCHdWwQn8Xeh9ziHKxRoyifM01xbMRdaKSWa5L6kSzA2NWhikywBbq8sYor1HogeBp1Ww3Gplp4QHuQsamlXhn9u29eJh3GGKJv5VtmXWnXiadpeiHH4C2iTW2enR7A1qjsTE+y/PVQprksyI9IYgGKHth2cjfdCGmsfc1ozkpzkLLtkwkPiajrmkb0HmNQeTZvtf0H6YMHi2K/VmG6/OrnVeJBPadcddHu5zwWBDVTpRG+KS0tLssijqsBkNjOeWUFnZb+mX7rxarEZmfj64G7ib1LcLB2jABbgjOuY8Ldns7/UbfIOgumdcH+N0CjGSMfYzvqbDAV0DQi8zZmvRlynUkwwo1GHXB9vumnfUVFAQ4ZfkjOYID2ezY4tYXQZk9UkAojglq+68tg4Hpvi0NExDTO2gM/SZCV5KZyNqf/NpJ6363vkZagOQDCt6yXk0lk2DemNXUynj4gT5ww7aYFYMlq/cm7GT1CrcuhXN9bvC1Zt+Of2phnZZUliHQgn95NR3G8/Quzb0Jtg5eAtgZZch9y3MGWLHH1Q1fIRQfoE+iwj5wnhPFD6AD1q/ybI+vbktpdFupkk6mMjGnE76OBPBBPm+78vPSOO2K3th2EnfPy2NyCGPpf5KODVEek97wcEMQ1jSTdWRe1nzvESCj3SgNGCdzQaLzhA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(346002)(396003)(136003)(186009)(1800799009)(82310400011)(451199024)(36840700001)(40470700004)(46966006)(70206006)(70586007)(316002)(81166007)(478600001)(110136005)(40480700001)(16526019)(26005)(6666004)(82740400003)(41300700001)(86362001)(2906002)(356005)(4744005)(4326008)(8676002)(8936002)(83380400001)(2616005)(40460700003)(5660300002)(47076005)(44832011)(1076003)(426003)(336012)(36756003)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 16:18:44.0089
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d70a5e91-c447-434f-2279-08dba4bdc9a4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002529F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8088
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add a check that the wq exists before queuing up work for a
failed devcmd, as the PF is responsible for health and the VF
doesn't have a wq.

Fixes: c2dbb0904310 ("pds_core: health timer and workqueue")
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
Reviewed-by: Brett Creeley <brett.creeley@amd.com>
---
 drivers/net/ethernet/amd/pds_core/dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/amd/pds_core/dev.c b/drivers/net/ethernet/amd/pds_core/dev.c
index debe5216fe29..524f422ee7ac 100644
--- a/drivers/net/ethernet/amd/pds_core/dev.c
+++ b/drivers/net/ethernet/amd/pds_core/dev.c
@@ -183,7 +183,7 @@ int pdsc_devcmd_locked(struct pdsc *pdsc, union pds_core_dev_cmd *cmd,
 	err = pdsc_devcmd_wait(pdsc, max_seconds);
 	memcpy_fromio(comp, &pdsc->cmd_regs->comp, sizeof(*comp));
 
-	if (err == -ENXIO || err == -ETIMEDOUT)
+	if ((err == -ENXIO || err == -ETIMEDOUT) && pdsc->wq)
 		queue_work(pdsc->wq, &pdsc->health_work);
 
 	return err;
-- 
2.17.1


