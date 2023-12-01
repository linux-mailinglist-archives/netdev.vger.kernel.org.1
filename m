Return-Path: <netdev+bounces-52732-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48BB67FFFD9
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 01:05:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA6B3281619
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 00:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6B4763A;
	Fri,  1 Dec 2023 00:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TWpWCpKs"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55D30139
	for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 16:05:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IRd1Ztozjfl/XGDjEAYla8No8cXLgY2HKnPHbmiyqZ7NffBj8UstVvG+9Q9XEAC2JfDXAlpooPYDN6sGgkhomU9IenjerPRTf/0N/Pu1q4vvE+eN2pYTbT6worSYU2zplRqk63d4ZkF6ltc3m9sKFhKamOK9/hiMUHqQA5vO9WEY1X29L2NczEdjTzA3s9K9kanUwosVMWPTyAI8+YYMCau39Pw0cx8LenH9jAe19S1oYQM77wWL3aJEUu/PcTejBDqsHlKe9yqalhKYBzSDGn8oAlsohzCr2V4+vPBPtERKat/rjCasxzm6cnhIclXpvWEKBEBKD1LCMDxJnyziUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lMzruAiRrDPpybeoTmb9CKTfXeMZ5d5ZGX9yrstYDVM=;
 b=kZZ4yhqn77Xr+fdU11VPnWBO8hzRdjFVKChDHTPRefEeDovKkm+PGHUmPhXp49EN2d8WRmyv0NLB2PTi9IyAuhZUoCERimOyAkjE33dNVctRUi2yfA6qRVBPsm9g5vFuWj5t58vFbOBKRKHz8zoOJGSYB29BPGO/fKPsuiG0nLAIptBZGx84NCPE+N+Fx/JAc7ernVFwnMEFSuCMDXAqUXoEn2enGR34IzExfEgNnahtXq9e3cf1aH+/iAF5XNaXqbNC8nIp0BuHYT7TjSllK/CKzmTiCNLNv3Qij56z7Bpc7QTqa1FWCxYfWh0ol8NERiiy0T1d6EOYAlfziE1vfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lMzruAiRrDPpybeoTmb9CKTfXeMZ5d5ZGX9yrstYDVM=;
 b=TWpWCpKsyTiUCs6+o3k3G10WubeC9mXoniKmuaCLxptQ09JiqbYDIR7i2FxZP4b7URpBsFjiL0vda/mcuWg49ioSLT5AHMEt1weszFQLKbaqPq2aurERXVUvIoXiPiggNH4L+h2KO1bFkAva/hlZqB0GtK4fJZpjgwHScmzeC1o=
Received: from CY5PR18CA0045.namprd18.prod.outlook.com (2603:10b6:930:13::26)
 by CH2PR12MB5002.namprd12.prod.outlook.com (2603:10b6:610:6d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.23; Fri, 1 Dec
 2023 00:05:42 +0000
Received: from CY4PEPF0000EE34.namprd05.prod.outlook.com
 (2603:10b6:930:13:cafe::b7) by CY5PR18CA0045.outlook.office365.com
 (2603:10b6:930:13::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.23 via Frontend
 Transport; Fri, 1 Dec 2023 00:05:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE34.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Fri, 1 Dec 2023 00:05:41 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 30 Nov
 2023 18:05:40 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH net 3/7] ionic: set ionic ptr before setting up ethtool ops
Date: Thu, 30 Nov 2023 16:05:15 -0800
Message-ID: <20231201000519.13363-4-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE34:EE_|CH2PR12MB5002:EE_
X-MS-Office365-Filtering-Correlation-Id: e54e7671-b12a-4560-d3a0-08dbf2014203
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Z6230Hy7jgxNlq7Wo52h27BXGdxoqBP2QVYST/WcCnoN+zlSf7jJBlcA0IRDJR20CBrxt5UM/dYCJVI7wtDWfGu6peGFEHeuz5fxCSRzuRku0+4p92nogRCmA7/axayXArhwZvto6uI1nnYmIcwCUGfpV4MxE/hhQ+aNXLjEYf9ngKvJ5n4VdL0RKiY2DyCpTKo/r6c9a4dcJH67VLpmD7KXM1vEmCd1Kc/90H6NkkmYHf0x0zHtStN4FmkKM6nsuUZloELXyOO7mcKSGTYnZHI1zrg4kHohQpnETckiKEge4sVHrvWz6x0R7W5ktDxJZdwARX72Tj6jnxPf/P4M7u6Gu/W5y/H4EtwHEeTWKDKfw3OjaBnFAOL+UyQdI1NOogx6y10DH1PvrjG7B8q/28+qGv1iui+KcpvWI+IWJyT3T1GyuGOlXl1eEMzI9LLJfShZDn8ZJ1nCI7PFQ1roWOVVqkamicVApF+PPQCSlS2/NoIswQzm5tBjaQyWzg7ohA4CKrqR3ZxX/58TXj7q93MLtOilakub4TMmf7T2MhDgWhbci6MEX4Qz0G4vRT4uX4VxeHnQsMYrBCOTXhFH4laJ/UL4IDR+YEWGi9H2AhwBf4wRVqLoATGKQgOADwwt4hm+ys+iOrKAibvBoAI3ksvDqoAomFNAn/8I36GsyBRPHBaNqJhiaiAD6vqO1k4Zy8xM7Toig3xccUF1tKdh3sEsnZsNMkAy1WealEe7xGPC0Z5AEzUeppbpxAOuEloGG30DHOliDLz/tletGECChQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(376002)(396003)(346002)(230922051799003)(186009)(64100799003)(451199024)(82310400011)(1800799012)(46966006)(36840700001)(40470700004)(86362001)(316002)(26005)(16526019)(54906003)(1076003)(110136005)(70206006)(2616005)(70586007)(40460700003)(426003)(336012)(2906002)(83380400001)(44832011)(40480700001)(36860700001)(6666004)(8936002)(41300700001)(82740400003)(8676002)(47076005)(356005)(478600001)(36756003)(4326008)(5660300002)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 00:05:41.8399
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e54e7671-b12a-4560-d3a0-08dbf2014203
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE34.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5002

To be sure there are no race conditions in startup, make sure
that the lif->ionic value used in some ethtool callbacks is
defined before setting ethtool ops.

Fixes: 1a58e196467f ("ionic: Add basic lif support")
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
Reviewed-by: Brett Creeley <brett.creeley@amd.com>
---
 drivers/net/ethernet/pensando/ionic/ionic_lif.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
index afb77e2d04c5..a5e6b1e2f5ee 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
@@ -3054,6 +3054,7 @@ int ionic_lif_alloc(struct ionic *ionic)
 	lif = netdev_priv(netdev);
 	lif->netdev = netdev;
 	ionic->lif = lif;
+	lif->ionic = ionic;
 	netdev->netdev_ops = &ionic_netdev_ops;
 	ionic_ethtool_set_ops(netdev);
 
@@ -3076,7 +3077,6 @@ int ionic_lif_alloc(struct ionic *ionic)
 	lif->neqs = ionic->neqs_per_lif;
 	lif->nxqs = ionic->ntxqs_per_lif;
 
-	lif->ionic = ionic;
 	lif->index = 0;
 
 	if (is_kdump_kernel()) {
-- 
2.17.1


