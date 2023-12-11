Return-Path: <netdev+bounces-56048-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C776980DA12
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 19:59:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2552B21964
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 18:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1390852F95;
	Mon, 11 Dec 2023 18:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SaDQNZgr"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2045.outbound.protection.outlook.com [40.107.102.45])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 868A7B8
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 10:58:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sd0lB0hkdYhrDuwN6qZ2ezjnCfzT9glgWIvnzHRF7ANAuUGluHgFU1RJo6O+b61vOZNQWz3x8X+LFJMqnkOL2MBC0FBzYwbb5aA5oceTaMGDVZTn3d9ug0vnFLm0lZclpn94m2Q5OHfDs4tczwu6jpmkZqxg3RkCyXQEObHLmGbLJr24GVNxh2/Aemegx0R67FPWfcd49D32hEG1qur1LZQkFXuXdM9c51gFuQT1Ttf0rf16JkGe5G/DjbkOZNYFfMyPVzUDQORwYgAcR2036lmMQ3gTCd+9uk+SOimXIIziXJD4+RtNSmuL3TUgdMEDj82gnG7TjFyXhqVmVc5mFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=56o2xy4n3eLax01mQcl9NYsM0i8dyviYyKIXun9ROmA=;
 b=DJ7Zo3f45NTqvUWtStJNEN/7hOozhaOzrGuyazW/TcRv06DFT+qIoo6Q3ArkN75eA5DrcC8+xthI7PqxhwevEQPesG0y8Y3QolH3FycUyTM9MpBTrW+v6ik0nhZ7X88OGlYmJeL4AdLTkLRKDVdWuNuDJ+Q9PByr4UGsSc4UGjNTNgOnRf8h5WoPfo9yx+oicTUQ61oFF/23vIoiOixu1ZAHLEHeWapvI4/wWVhhOU7E/BBLPipXw/Lw6gVmrqQaliqFQ3Twdd0fFym/8UJ2BaGkjOjzFc5rYLUgrBUq4jw9GCuy5qvGkQEH3Fl8qGNgFZ033IUltC1nrzecxS4B5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=56o2xy4n3eLax01mQcl9NYsM0i8dyviYyKIXun9ROmA=;
 b=SaDQNZgrDNFlsXNhPl1vOPNFQcJtUQctOsPQQWsaEVr9N4vDJKKdVBHqenfBx909CLAsYbS7XDVvOqxlodPtPZSJB8dpuSRhMY3jGj6VtW6hkmxbdbhnCFpTMFpkMQEoX5xdNMqX4grIDidR+qzAq3cckmAL22hCzGp7oV5kU0E=
Received: from CH5P222CA0010.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::28)
 by CH3PR12MB8186.namprd12.prod.outlook.com (2603:10b6:610:129::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Mon, 11 Dec
 2023 18:58:28 +0000
Received: from DS1PEPF00017093.namprd03.prod.outlook.com
 (2603:10b6:610:1ee:cafe::5a) by CH5P222CA0010.outlook.office365.com
 (2603:10b6:610:1ee::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32 via Frontend
 Transport; Mon, 11 Dec 2023 18:58:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017093.mail.protection.outlook.com (10.167.17.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.18 via Frontend Transport; Mon, 11 Dec 2023 18:58:28 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 11 Dec
 2023 12:58:25 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH net-next 7/8] ionic: lif debugfs refresh on reset
Date: Mon, 11 Dec 2023 10:58:03 -0800
Message-ID: <20231211185804.18668-8-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017093:EE_|CH3PR12MB8186:EE_
X-MS-Office365-Filtering-Correlation-Id: 660d85e1-6119-44db-e1ed-08dbfa7b2957
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zNYBzkdTk0slG4oZ7+asWkEY+Swdfte9PEAmspYMdGoptBdfCAY3mTa3BQ9s2ohko4D37MuUnQEmuHWaHNx5rrWtX1LAq/52XOpt/YX0N7XIqUXRN+HDQn6kIivl/I8xjgLMNMlEX7OK+QnA+tNg5bG4SS2/aMAsU9WQEOvRGlxps3iP8p8C8NNYrndIoQhlDQGiEeuGmMBak+tKzUk5wsCc/ERqae6fWSlmBTrQg2V/MpLTvRAFPmvkSXfrryfzF7PO+rtAmbq4j0lC2FSKcfmQb/oRDZL3iAz6Wh8CKB+epE38M7TJ43reOG88Sup9jjgv+hJEo5/KBdjNV5S/XxYU6CcrUPN/7Mmt71xGL1ytrEd4X0SdEKJEeh7wMIF2Ds+xIbAMJOk3E1brANpaPeWk6mFkqaTQ5rkc52ml9G5oe5IqcmoNiaBpe9ubpLjEhWXdRZWNDKXoixGUb0a25AGsm2S92z6P4xp//CmKN2yJyJCPDxLLfZ5NAz8Zegomxq3Yigfp6A5ybTXTNwke0x+OxgZRX4wFvfvh4sE8mbWdwQ5uDpGDdq+Y5eIm8BLlx4/KsuEm63Y3WvGXcI5AN9tvQnjVJWqs2KUMGSXzUOOEgu+3Qta+47Ipnzk3Ly0b162GAlTFWlwXKXUoFMKMKZ01fXmAeroB+rZ3JNqvPsnmRhT1+qAj3p++YsB+kxoOh2bTfkU18REXwhTyHTr/a4UTn/Co6Ubgm0a3qXktQlDeEuFkC14XpxLKe7QtBIklzBxKzKe/nOu8PCTz6JJPIw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(396003)(136003)(39860400002)(230922051799003)(1800799012)(451199024)(186009)(82310400011)(64100799003)(40470700004)(36840700001)(46966006)(83380400001)(2906002)(82740400003)(41300700001)(86362001)(478600001)(356005)(81166007)(40480700001)(70206006)(70586007)(54906003)(426003)(110136005)(316002)(6666004)(8676002)(4326008)(8936002)(40460700003)(44832011)(36756003)(1076003)(5660300002)(47076005)(36860700001)(26005)(16526019)(2616005)(336012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 18:58:28.3666
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 660d85e1-6119-44db-e1ed-08dbfa7b2957
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017093.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8186

Remove and restore the lif's debugfs pointers on a reset,
and make sure to check for the dentry before removing it
in case an earlier reset failed to rebuild the lif.

Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
Reviewed-by: Brett Creeley <brett.creeley@amd.com>
---
 drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c | 1 +
 drivers/net/ethernet/pensando/ionic/ionic_debugfs.c | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c b/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
index fd2135c23862..60e64ef043af 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
@@ -437,6 +437,7 @@ static void ionic_reset_prepare(struct pci_dev *pdev)
 	ionic_txrx_free(lif);
 	ionic_lif_deinit(lif);
 	ionic_qcqs_free(lif);
+	ionic_debugfs_del_lif(lif);
 	mutex_unlock(&lif->queue_lock);
 
 	ionic_dev_teardown(ionic);
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_debugfs.c b/drivers/net/ethernet/pensando/ionic/ionic_debugfs.c
index c58217027564..91327ef670c7 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_debugfs.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_debugfs.c
@@ -287,6 +287,9 @@ void ionic_debugfs_add_lif(struct ionic_lif *lif)
 
 void ionic_debugfs_del_lif(struct ionic_lif *lif)
 {
+	if (!lif->dentry)
+		return;
+
 	debugfs_remove_recursive(lif->dentry);
 	lif->dentry = NULL;
 }
-- 
2.17.1


