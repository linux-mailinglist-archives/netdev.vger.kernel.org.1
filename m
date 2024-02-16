Return-Path: <netdev+bounces-72566-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB980858881
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 23:30:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06CDC1C218C5
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 22:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D62422061;
	Fri, 16 Feb 2024 22:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sR2WMwma"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042431350DE
	for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 22:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708122624; cv=fail; b=rw0X8KWSjmKPk9pU07JPy2RPUnjFwKJ7WJ3qXtZh5MPU3Ok/hYP2SURiRrAji23rFpxCCyUrVy+BCOlT/siXde6hWE5u6XACcNnXRxfXqE2MYV83ZUloO1INj3HcEmFL/FIMRZC8Oe/60k1UHhcI7UmFZW3EPQibi3fWA4AOi5k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708122624; c=relaxed/simple;
	bh=ZagyV56IyWcYUBYM7ijbU24BxDzLeeZ93MQX5+cUcQA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mEbS3oUP+x4YDQi1QHBgzWd6Gw1YBdz4FhKLUL92wE8Z124spvKM18RX1U8iIak4lLJi5+N1j1B6YYpv8eqeYJXRNQ42fBa5GpCctaENNbQfp0ORQp5h2lSAD73EDoNIZR8hcSFrbVUKyMUCpiENy17qqKP3FxlaiTPZtrKLh4w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sR2WMwma; arc=fail smtp.client-ip=40.107.223.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nz1wSnbDXilvDv1d4KKDERFlPZZJB4cqcNfXeqavQe6CWAuO8hnooln1RmX7SzKHyjVHyUU8PuD54eFssdpGUUak9dQDLyDwubMbPUkhcCERCUD7l8B5SgFvJgv64os1BJmn7ATBthH+3ACDaaKPtQhFqwhP6FOsR315FvueDeUK5kP+fLZXmJqvzGO8ndGHT1l3RppYCYeovfLJE0YHOUk6UBu/5R11SC+Wda+ChmiueIn8oEiItRxBPjv79sh6cv8fzbF1hH5F/A1/u0Vn/IFps7svanVU7KpY52GF/NBNMIT15Y2TnoD9z+oQVn6UII+3quER0FY3VKx3GMYicA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gaglgujZSrnk3ke92+qUdVg84+kkb6zBrshQ63jquTs=;
 b=RkdK0l5McDS7PjJX8/3E4WOHS0CDwFI/W1xCsYiWKBpIPJIMMsAWPgokHUlccgBtKaK3czEwe+3Nidw8yjy7CkfvTHmlXa9puSzFNgG2fC+gVvdRb2JWqS9vF9fcnHRx+QtJdwW1xIv7kK8lUOf+btzI2r/hYIBDca+oF2qAqMAK1TM2xc6Jbs5oplzj1lN4rN2cTV4fpuKfQSyyTUMDvV8u6MOGGrdr7E+LRBBGc91VlAig05Rrv4Wuk1aJQ1cN7oYu4kY3gdFoh30yVCw80gDcbapaEqXyAi9vGPINeCwDHZ/ZEcaKYHJsff2qX11eNAw5VBCN/zJAY5BkGTn6aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gaglgujZSrnk3ke92+qUdVg84+kkb6zBrshQ63jquTs=;
 b=sR2WMwmayCgrrMfEV/aa555l9J2zztE2pKaUU28M3UXXtzk/gtVRC95U71N2mGnrweaRWQzbDnCyhHAAgodtuejY0e9IugwutSPWzX8FeoZMT2XEzxpgjH7KNYLyClAof39YYb8Z3aM+OMTdfkWfzNWWs+QpgXp+KkXV7jNxyx8=
Received: from DM6PR03CA0075.namprd03.prod.outlook.com (2603:10b6:5:333::8) by
 PH8PR12MB7326.namprd12.prod.outlook.com (2603:10b6:510:216::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7316.12; Fri, 16 Feb 2024 22:30:16 +0000
Received: from DS2PEPF00003444.namprd04.prod.outlook.com
 (2603:10b6:5:333:cafe::7c) by DM6PR03CA0075.outlook.office365.com
 (2603:10b6:5:333::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39 via Frontend
 Transport; Fri, 16 Feb 2024 22:30:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003444.mail.protection.outlook.com (10.167.17.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Fri, 16 Feb 2024 22:30:16 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 16 Feb
 2024 16:30:15 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH net-next 3/3] pds_core: use pci_reset_function for health reset
Date: Fri, 16 Feb 2024 14:29:52 -0800
Message-ID: <20240216222952.72400-4-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240216222952.72400-1-shannon.nelson@amd.com>
References: <20240216222952.72400-1-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003444:EE_|PH8PR12MB7326:EE_
X-MS-Office365-Filtering-Correlation-Id: a38bfd23-85a2-4606-05c6-08dc2f3ed9bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kJAiDns1GMNfzFMtWqWRgzFFdUgAZAVM8dU0IEwItD/wI7LydvDHejIXtzEfnD0nm5pL+fhJ4rgXtxj98UfprLfg2Fn/Ybk5+gUHcPl+e3KYwUuiai9nfTrA5E8vsMPb5xFLbgGIzF9uQGnvt2qE3sAG8hmzLBGqVNYN3940E9NUOf7KuQTHtqkevscfmkLscSaxNJT+BJk75+kGCTgJ9PNK+S55k69tLhJfN+9QAXPXbNhcOaJwuvpN8yySoMDhQxgDRePQzVRu6BPm/W4CuAPBym2l0kpPvLWrbVzJZ1sm6j9wbbXLq9ba/q0KLHgHT5G8uTrZ5bbYpEIlSjlx5LjdJPepgO3S0mPsj4FHPSh77Vfy5RuOV+LpqslArynAwxrvjFLutEutCviZf5RjCQtAKGtbLKDUo4HS2oZb2TVFMHotCkW6DPlVHEvl4kgg3BP9McLASxtLZ8BNHY9NhhdzZpS6mqYWwcLdS0lvHjQwmcTduAoorZMq1auenoLM/+VQeA/tiwoRNCtB1CdR6fJtIfbKRtuex+llUNzrhHdMnXpPx3kRA3UWJB12sx3sb4VMqZn4nzkEFm4jK8NTJrYNFJuHyAv+Gbe6HiuTl38fZaQkkptPLtHbU+mulXZg6kg3hpFy+enH/DCbeu8qMw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(39860400002)(136003)(396003)(230922051799003)(82310400011)(36860700004)(451199024)(186009)(64100799003)(1800799012)(46966006)(40470700004)(2616005)(478600001)(110136005)(8936002)(6666004)(2906002)(70206006)(70586007)(5660300002)(4326008)(8676002)(44832011)(316002)(83380400001)(54906003)(41300700001)(16526019)(86362001)(1076003)(81166007)(36756003)(336012)(26005)(82740400003)(356005)(426003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 22:30:16.6195
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a38bfd23-85a2-4606-05c6-08dc2f3ed9bd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003444.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7326

We get the benefit of all the PCI reset locking and recovery if
we use the existing pci_reset_function() that will call our
local reset handlers.

Reviewed-by: Brett Creeley <brett.creeley@amd.com>
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 drivers/net/ethernet/amd/pds_core/core.c | 3 +--
 drivers/net/ethernet/amd/pds_core/core.h | 3 ---
 drivers/net/ethernet/amd/pds_core/main.c | 7 ++++---
 3 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/amd/pds_core/core.c b/drivers/net/ethernet/amd/pds_core/core.c
index 1234a4a8a4ae..9662ee72814c 100644
--- a/drivers/net/ethernet/amd/pds_core/core.c
+++ b/drivers/net/ethernet/amd/pds_core/core.c
@@ -607,8 +607,7 @@ static void pdsc_check_pci_health(struct pdsc *pdsc)
 	if (fw_status != PDS_RC_BAD_PCI)
 		return;
 
-	pdsc_reset_prepare(pdsc->pdev);
-	pdsc_reset_done(pdsc->pdev);
+	pci_reset_function(pdsc->pdev);
 }
 
 void pdsc_health_thread(struct work_struct *work)
diff --git a/drivers/net/ethernet/amd/pds_core/core.h b/drivers/net/ethernet/amd/pds_core/core.h
index 3468a63f5ae9..92d7657dd614 100644
--- a/drivers/net/ethernet/amd/pds_core/core.h
+++ b/drivers/net/ethernet/amd/pds_core/core.h
@@ -284,9 +284,6 @@ int pdsc_devcmd_reset(struct pdsc *pdsc);
 int pdsc_dev_init(struct pdsc *pdsc);
 void pdsc_dev_uninit(struct pdsc *pdsc);
 
-void pdsc_reset_prepare(struct pci_dev *pdev);
-void pdsc_reset_done(struct pci_dev *pdev);
-
 int pdsc_intr_alloc(struct pdsc *pdsc, char *name,
 		    irq_handler_t handler, void *data);
 void pdsc_intr_free(struct pdsc *pdsc, int index);
diff --git a/drivers/net/ethernet/amd/pds_core/main.c b/drivers/net/ethernet/amd/pds_core/main.c
index 82901a847306..ab6133e7db42 100644
--- a/drivers/net/ethernet/amd/pds_core/main.c
+++ b/drivers/net/ethernet/amd/pds_core/main.c
@@ -469,7 +469,7 @@ static void pdsc_restart_health_thread(struct pdsc *pdsc)
 	mod_timer(&pdsc->wdtimer, jiffies + 1);
 }
 
-void pdsc_reset_prepare(struct pci_dev *pdev)
+static void pdsc_reset_prepare(struct pci_dev *pdev)
 {
 	struct pdsc *pdsc = pci_get_drvdata(pdev);
 
@@ -486,10 +486,11 @@ void pdsc_reset_prepare(struct pci_dev *pdev)
 
 	pdsc_unmap_bars(pdsc);
 	pci_release_regions(pdev);
-	pci_disable_device(pdev);
+	if (pci_is_enabled(pdev))
+		pci_disable_device(pdev);
 }
 
-void pdsc_reset_done(struct pci_dev *pdev)
+static void pdsc_reset_done(struct pci_dev *pdev)
 {
 	struct pdsc *pdsc = pci_get_drvdata(pdev);
 	struct device *dev = pdsc->dev;
-- 
2.17.1


