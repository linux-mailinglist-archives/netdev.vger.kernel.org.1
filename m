Return-Path: <netdev+bounces-56047-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE2E880DA0D
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 19:58:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78FA6281F4C
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 18:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8155852F60;
	Mon, 11 Dec 2023 18:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0900gbdP"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2056.outbound.protection.outlook.com [40.107.244.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A778CAC
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 10:58:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zoer3h7iyqo3pD5/Qj6AVoiDMEE9QVKWrjB5jSpyxfXndIvQPRAMCLh4Ja3OfVmcCFSjjLIWCfG7zHQdhHvU60ZNmndTlgpNX0lWu31YOYLrGPXMdgjcb9Ziwpx+F5zXak6mobBYeWSQW1HGlj6QqZ3iGhYxMFC1ZpMVKyTWkb7WJGPg0k1b6zEcYsWeOZUBxqOr2drhPklpK+Zer9wCVt5/w7eXR8PqqXxKJoV4sTmEF2FDh7zyO5sS44gI4asi7bcoAmsN6dGZHSkogg3To8gUEcZ4/dXhW+MC/HAF/74XpbsW+yYI4JW3uXjTTsJ5sHrcoxp9cy+ojuHdwMoMFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7gY90yrWgDeX3eyMyREMqeBITZc4jEIjFzYZYQRoAyw=;
 b=Z0phZlpne8KX8KZOprVjpzrmea4cxiyPjEqYhHsrjHxHCkR/aHvqN63xOVRr6xBG2DGgKnYc1kCUZIl90pC5GdbwK2HWTHq8Htqrgb/W2/xFqQ7u4xTkwiCMgtgDqV6UcdQioV/7WQzHFXK9oqCgJaxzVwEdk7KWzl6rZPZCWr8X3AcryRzBwUVeig5FoHK+41W1kXQNnSloY5lsey+UqDhXxrElZtWG6XkkBLLKDQWuh2+w9J4Mmb+J+m1Th3mK41ABGUEzum/wMM4arcT09vG8xrs5Fyk/qGqfssc9m0BGk74OwVy/6y15GhaHzGrr9PNsAmmKKg3gtR0QynUE+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7gY90yrWgDeX3eyMyREMqeBITZc4jEIjFzYZYQRoAyw=;
 b=0900gbdPInb+S2LiNgndM+wkZ5SzUTs/MeJdIPoInrhw35ml7rgmNBnxHnxB94vtFqvMBbHNMEByUoCaEMFIvYURDz48YD8zsAWZKtSrz7VyMeoFBaOtb/rAH3SAuqdF406TB4hCYrHXnUck6XZIX2d45qR/2EcucDxS6buO7mM=
Received: from CH5P222CA0011.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::26)
 by SJ2PR12MB8808.namprd12.prod.outlook.com (2603:10b6:a03:4d0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 18:58:26 +0000
Received: from DS1PEPF00017093.namprd03.prod.outlook.com
 (2603:10b6:610:1ee:cafe::59) by CH5P222CA0011.outlook.office365.com
 (2603:10b6:610:1ee::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33 via Frontend
 Transport; Mon, 11 Dec 2023 18:58:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017093.mail.protection.outlook.com (10.167.17.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.18 via Frontend Transport; Mon, 11 Dec 2023 18:58:25 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 11 Dec
 2023 12:58:22 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH net-next 4/8] ionic: prevent pci disable of already disabled device
Date: Mon, 11 Dec 2023 10:58:00 -0800
Message-ID: <20231211185804.18668-5-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231211185804.18668-1-shannon.nelson@amd.com>
References: <20231211185804.18668-1-shannon.nelson@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017093:EE_|SJ2PR12MB8808:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f503c48-d84a-49de-4313-08dbfa7b27d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KZ/CeH/uQR79QCQUJ+95JUgB0upG4MgLx+ggv4IBtlSsEatsrUk5gqc/e6lUXOqCaejODPF2wbw5qMNwOMWczWW80A1XlG/KHkCA9AqfzMx7CqAJax8JupilS9ICi14ku5/fxa1qhQR4Hzfs61DA9KZWYyeKFNixkkX2XAtErbfCEzDICKt6aO0KtDETXUokv5qeP/qbv89duB9wapbD07zgE5aUxABVsIDyaULqqq1B1OjEW4Fi9tnfyUm8+gH/hNdwBk7P9egNpiIt0jSvwONWEcdMJdzO/8vDdQwcM6Gq3N3pqPjTzPMGMyq3J85YdkmHamwNNBXytJtmqtxDPVQtYIOT39LEwO+00JuC3/t1RJ5lDB/qb/Zw9908E6GyZYpRaV+QIdEOt5HHU5K759APJuL9IaR2kjBBtxWoglc60Xny7fMS6axNZRHdS+1iL/gzRb6En32lquqfPEmTlt96pP5PC3P9yYfT5aWJbOZ2w0DhnjFHvzD9EZ4Nd2SrluYbzmyYApJXelTKicrys0HIjq1LLzqd/k4ygtMT30qB832eWWJyeJBnizx+MEmpq3kYda9gcC+LlnVgOHjw4EXaCefXLtQagEogrO/ptnX2xuNXYhMR2zmusNO+4bM4VaOfMOLHVXlA6kWvhw0GD9qooMHi5dG7Tf26vFJTjdhKwLHW/WHrhmWvCl2tqo3wC5k2SAj++RdhPldMROGzNPjYjmR8zWikvEu9vWJMYFRff7LxCfzAL4uKRU6yR0Cf/Rx8SRjqn/OJF/Od1sqD6g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(376002)(136003)(396003)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(82310400011)(46966006)(40470700004)(36840700001)(40480700001)(36756003)(40460700003)(2616005)(1076003)(6666004)(478600001)(26005)(8676002)(2906002)(8936002)(70206006)(4326008)(16526019)(110136005)(316002)(70586007)(54906003)(36860700001)(47076005)(426003)(336012)(41300700001)(5660300002)(44832011)(83380400001)(81166007)(356005)(86362001)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 18:58:25.8353
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f503c48-d84a-49de-4313-08dbfa7b27d3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017093.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8808

If a reset fails, the PCI device is left in a disabled
state, so don't try to disable it again on driver remove.
This prevents a scary looking WARN trace in the kernel log.

    ionic 0000:2b:00.0: disabling already-disabled device

Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
Reviewed-by: Brett Creeley <brett.creeley@amd.com>
---
 drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c b/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
index f69178b9636f..da951dc7becb 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
@@ -217,7 +217,9 @@ static void ionic_clear_pci(struct ionic *ionic)
 {
 	ionic_unmap_bars(ionic);
 	pci_release_regions(ionic->pdev);
-	pci_disable_device(ionic->pdev);
+
+	if (atomic_read(&ionic->pdev->enable_cnt) > 0)
+		pci_disable_device(ionic->pdev);
 }
 
 static int ionic_setup_one(struct ionic *ionic)
-- 
2.17.1


