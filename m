Return-Path: <netdev+bounces-52735-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 740A67FFFDD
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 01:06:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A59292819EA
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 00:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 482351FB6;
	Fri,  1 Dec 2023 00:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BE/zW+pb"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2044.outbound.protection.outlook.com [40.107.94.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E3BF10E4
	for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 16:05:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GkIBjTV9SWfIR7sFWJfNCF7r0XWhiil7O26WHBu4PIKQEAFF2bTsH3BYaNcJaMIWhnm2ntJL0wDc8poALzq5ZswkjgaMM3douU87eRayhqixfKfhuTXydW8Xn6TggNUOnqdWfyYDqSSKjYRyBkGDrtnz6uq2XygUMoaCv/9c+d3PTj4KWoYbAzWgvegtF8nnRY5xnzSvfmA4VpHt7oRLRc17dSMYDXL11XYrlCJarABrSFftXQtNoSUbOrBnEUeJMc1+Pgl1ixjEf2jA2AzcVUZWFRQrpWmJsarCuUi2jMVNV2UmWynD5lNLzDn9PypdltCGhCQEaVaxgNFgMT6uEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QNS9njptn7+eQjqYAl1nQVRKVYDNSQGSkf+AAWDA6uk=;
 b=R6noYs7N3lmOaoPUpL1jvc1mqR7HzbGB1prV7iN1X2kScSS22nIF4dOhwgPB4Dz1T7vjQdb5ONuQvTA3VugqjfAaMfXFCYm0hecvtz6/5pUIklaiY3hQTkiheHN4syVEqA35EtJtf4CuVAnFRYcM1No4v3Tu1hX2R6d3EHUk+tlM5r22jGh15ZpY5yw7fg01pWFUbD1WWiLhxRNLgTNzq1AqkmpfaudTJes9Jr2JamogemRM5w6LB+2QmWvqvYvZpANS3QFbLh1tnKG6W3t8DF7i9ddqmUyIqiZTh6d54w2ZS4sHKAYElu7q+DsYZFGGMM3LsFvQ04S8l6auVYkK9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QNS9njptn7+eQjqYAl1nQVRKVYDNSQGSkf+AAWDA6uk=;
 b=BE/zW+pbeR27PjVcpQRCL+jKcUbQKfxIHwkQaHkD7zxPw95ngqWdOBM0rO6diwLCw0sYTpoFpc+zc4cnqt/tSzfeI4db/Jvxy+smPEn/VNgUTuUNLhC2B/+4sAtUlpdbhhQiSwdpOW685ZDaf3zJC/WNPREB24hW4WJlG8VcgAE=
Received: from CY5P221CA0086.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:9::23) by
 PH0PR12MB8150.namprd12.prod.outlook.com (2603:10b6:510:293::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.23; Fri, 1 Dec
 2023 00:05:44 +0000
Received: from CY4PEPF0000EE33.namprd05.prod.outlook.com
 (2603:10b6:930:9:cafe::84) by CY5P221CA0086.outlook.office365.com
 (2603:10b6:930:9::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.23 via Frontend
 Transport; Fri, 1 Dec 2023 00:05:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE33.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Fri, 1 Dec 2023 00:05:43 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 30 Nov
 2023 18:05:41 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH net 4/7] ionic: Don't check null when calling vfree()
Date: Thu, 30 Nov 2023 16:05:16 -0800
Message-ID: <20231201000519.13363-5-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231201000519.13363-1-shannon.nelson@amd.com>
References: <20231201000519.13363-1-shannon.nelson@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE33:EE_|PH0PR12MB8150:EE_
X-MS-Office365-Filtering-Correlation-Id: 055fe152-4457-43c2-6519-08dbf2014347
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VoYFBxgOzw1oEYEMK5hZNwzY3xCv5qyXAKBZU7Ipj8zCxGFm/w2WCsQzzdO/D+HBiCrAyw1zQyAT5TbCY8CU5KDm2wBvTfbHtXC8qB9+NCUO3F1UfsCl8YSiyHEZNaulVa3v5KytM61Mr6GZqO5D3Ky6LC2v3nJ5uEjGWEsqFjli1v/SIRHUMyJsZATta0ZvUNKxVTUT+v2gxkzWra43d4KOkLVf2kaDPeZnl0w34YZ6bdKpsTjN1Zr9aWWfH9MboLRwg6z7lEUult7hN/pkVOGsQrKHoIqAlMspV9y2KoryKMaEA+PFEwf/we/W+lMdxPRo8gS5eKXm8fqud/3mq7sJ3dwobUG+lXxerraNzPbz+e054iaW2Q+dZMosmiC1FBi7KFHhj1JYXiG+q2ZCMzX9BMhcJ36eYeaVPzOQM+spcg/m1GCXoCDWJSQ4utZH7/4fwvYcm+qbX20Ea+jQ4LYmoupLGD0UtU4s4vL3XafrYuhk1MNFleCc0TtIMFDUdeYMmlqK5h8LjCez0EntfMamEXQXbKB9J6ItshZNGqhXfafVrRj+Nb0PsnTWUbPyNzaAjaJjVLE/H0aOx9f0aGQxitxaDjd7NNM3UFZWCrn1qw46l2jspQ6CY1lRDravPH+LM2ilV8TwZrscfKtG7oFMIT28G7/W9RsQ8nPePAJCUgXKQBeZL2H066zPx0SBBck8Jddjgcx8A5nXJ1cPXmREAxwUxO6ESEco45GasFzkvPNJ+XN4UFbAhiG27M1WlI1QY2kSesl7GivX55fg6g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(376002)(136003)(346002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(82310400011)(36840700001)(46966006)(40470700004)(83380400001)(47076005)(81166007)(40460700003)(356005)(16526019)(26005)(2616005)(1076003)(316002)(70586007)(54906003)(70206006)(41300700001)(86362001)(110136005)(44832011)(2906002)(8936002)(8676002)(4326008)(5660300002)(478600001)(6666004)(82740400003)(336012)(426003)(36756003)(40480700001)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 00:05:43.9604
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 055fe152-4457-43c2-6519-08dbf2014347
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE33.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8150

From: Brett Creeley <brett.creeley@amd.com>

vfree() checks for null internally, so there's no need to
check in the caller. So, always vfree() on variables
allocated with valloc(). If the variables are never
alloc'd vfree() is still safe.

Fixes: 116dce0ff047 ("ionic: Use vzalloc for large per-queue related buffers")
Signed-off-by: Brett Creeley <brett.creeley@amd.com>
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 drivers/net/ethernet/pensando/ionic/ionic_lif.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
index a5e6b1e2f5ee..6842a31fc04b 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
@@ -424,14 +424,10 @@ static void ionic_qcq_free(struct ionic_lif *lif, struct ionic_qcq *qcq)
 
 	ionic_qcq_intr_free(lif, qcq);
 
-	if (qcq->cq.info) {
-		vfree(qcq->cq.info);
-		qcq->cq.info = NULL;
-	}
-	if (qcq->q.info) {
-		vfree(qcq->q.info);
-		qcq->q.info = NULL;
-	}
+	vfree(qcq->cq.info);
+	qcq->cq.info = NULL;
+	vfree(qcq->q.info);
+	qcq->q.info = NULL;
 }
 
 void ionic_qcqs_free(struct ionic_lif *lif)
-- 
2.17.1


