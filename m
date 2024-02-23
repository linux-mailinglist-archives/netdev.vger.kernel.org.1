Return-Path: <netdev+bounces-74621-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3573C861FC3
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 23:28:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59C151C23BD1
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 22:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B3FC14DFE5;
	Fri, 23 Feb 2024 22:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AMzzU6/X"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957DF14DFE7
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 22:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708727283; cv=fail; b=AcHRqAE3YgSqUJr3ACE0aTX1lT3SQpuyVVUPXPlVxFVgCpAQ2nmGDqaW1CocYyGYo/pvUJ452rxWg45yl8XyhKgc1I32scAbfM3dTEZAVp6E2R6MPLvrEJiQSpA3UeLMfgEi+ZM8n1SITi81ni7jwff9ESwgRThJtt96hbaEKBo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708727283; c=relaxed/simple;
	bh=CVrEHhx3lSmqv1ZfHJeabiIH1L+kRqrzAhjXKBVyc9Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xxog63OhnqRXRXiJvJgE9w3pBsND9TPWnag5aBcazd6ewGmA7JzK9G4WgmyPsOvXPYI/AEjvT5opSOralu03pQyg9KmxWREeVdpVpxpFnz0iiIYOPE5um4ro6bYUfMR3TbTk7xjVprghlmcG8Is94iuh5Y7HCkuPTnslAiWtyy8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AMzzU6/X; arc=fail smtp.client-ip=40.107.94.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PNa0tZWqoK8ehSEKgnlGeNTSyFpLpeh3pKKzeqSI6oZctlJ8ZSNbeD80vF2QX0g0au3x23jC+2Bc2M2JRZeNMWZLpWA20EgM8g6sQbd697QK+Vvra0zVmd+YaZ0JTUr065UDsYrGe5Vg44ZeUIglo1eX5ilbDLQ2gO1pM6Fsp9DrsSReObrhEOtBEJZhYZpizB26Y5MY0oBCngAVO0tw2/+QfXghmJnX8xtMH9FsT3QAzzgbwoepTeLdlUcpT4K2HIm1RF1LnG4lA0GJSPVhkmOz1PKSVN/pk3I2BSQpYwCPZPLc10fWKfRCjwcw93ggnJFnnjru5BbV7N1CilsDRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bll4aW+fBw2Ym0KIqazHROb8fQGghRxO1IwY3xgFi+s=;
 b=ia2k3ZK0MlAgYJmPyLA8MMPkqUteP8G7Zey3XhTDRWlqgzewZTT/P6+oylcuTDn0lik31hGupXNbhIS1VZkV69i08wHMKS91nWwKye5Srj1P/7Osgl/V2NeEAU7gHZKFX51UeJoXFA+BSg//xKiaGKqTKMU248U9zznZkM7oya7py2FhOm5VOaiwAJFSk5bQbaEFVz2C4erXy0B5SjqUOf2jAaIDmqrylrTlEU6isGPttzPWsfXJambfxqZCvO5gteZkZJaKLZaxagDUBWsNP7VuryV+PadF5mMX4SSX9NHIf1uiiHsAB97kyut/fDvRV4sCh6QhsdmbB32FhB29sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bll4aW+fBw2Ym0KIqazHROb8fQGghRxO1IwY3xgFi+s=;
 b=AMzzU6/Xmb4G6/J7uPERlRJO+8INwut7emXWHp/lpsK0e4ZsrVVx5N0yENsu2iS8/EjEh9AJkmBUObY0W5L2f2MDoXwqEjM+ER1rMTIPO2+x8RnarNlp8bWZSCFwPQvw10qOyTU3zAuEFuo4amgimXBZ5+dNWZ0NEIpyUpe63hI=
Received: from SA9PR03CA0017.namprd03.prod.outlook.com (2603:10b6:806:20::22)
 by SA0PR12MB4510.namprd12.prod.outlook.com (2603:10b6:806:94::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.24; Fri, 23 Feb
 2024 22:27:59 +0000
Received: from SA2PEPF000015C8.namprd03.prod.outlook.com
 (2603:10b6:806:20:cafe::73) by SA9PR03CA0017.outlook.office365.com
 (2603:10b6:806:20::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.45 via Frontend
 Transport; Fri, 23 Feb 2024 22:27:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Fri, 23 Feb 2024 22:27:58 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 23 Feb
 2024 16:27:57 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH net 1/3] ionic: check before releasing pci regions
Date: Fri, 23 Feb 2024 14:27:40 -0800
Message-ID: <20240223222742.13923-2-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240223222742.13923-1-shannon.nelson@amd.com>
References: <20240223222742.13923-1-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C8:EE_|SA0PR12MB4510:EE_
X-MS-Office365-Filtering-Correlation-Id: c1728060-0973-48f4-26a4-08dc34beb052
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9cUG/QtmJqT98XA61fK6xr5BnHspll1Fr/UhPm/b4wOjdPD9MBkXfI6ZMRD+Atf4WpUYnjAY2l89NH4HKuizQ/rU50YS5fJ4aJv8K5E4OCsd1TM+f4goKWVrAgyklPo3f9ZoGilPoeuGtwqtkjVhFUNhAYxyeuwTOf2+RqCcCppIZlZBD8UEQGUtje3l5LVwtLaIGkplB8UbB4GA9/l2AYAev87Egy219ng84gATVwlxSQbb+RKPBHb/olEJjPVtE/woOBXDQPuysx3QEm9Mrbj0D0SpFXfcK48RSOpT4ISxBdxmAtdhQ8k9Y0c008lT+UA6n+KfG05XnmibZFyLP+bcXfj1ivvfckLhkXuWVG74tu7Yv0hJnaIOVzQDVQiuEK3B2PijdfmfQOAOr55og4xCoS4AVpvdToXbRpVpkTj/q9mU9NU97ziXoTk2xrag5Wg+DpEBh1TsuLGT4TO2YCb3ES/s/Ft/hEuVV3P9rcG5m6W6sw6yk37zlIlmpzqybw2PAjshZ6+cxK2H6dJq44LurgyWshf/lrhSPIr72N4+21myhCsNnpCfyLTXhJ12O6hHzLyCgGSq9cnaKFzJPfvKdsmVCPiyFGC4VoZuj3DYCGI+0UTsQcuuKGkRXOYfcSykzbCFbMNVOn8HgYTwgA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(230273577357003)(36860700004)(46966006)(40470700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 22:27:58.5903
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1728060-0973-48f4-26a4-08dc34beb052
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4510

AER recovery handler can trigger a PCI Reset after tearing
down the device setup in the error detection handler.  The PCI
Reset handler will also attempt to tear down the device setup,
and this second tear down needs to know that it doesn't need
to call pci_release_regions() a second time.  We can clear
num_bars on tear down and use that to decide later if we need
to clear the resources.  This prevents a harmless but disturbing
warning message
    resource: Trying to free nonexistent resource <0xXXXXXXXXXX-0xXXXXXXXXXX>

Fixes: c3a910e1c47a ("ionic: fill out pci error handlers")
Reviewed-by: Brett Creeley <brett.creeley@amd.com>
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 .../net/ethernet/pensando/ionic/ionic_bus_pci.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c b/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
index 10a9d80db32c..6ba8d4aca0a0 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
@@ -93,6 +93,7 @@ static void ionic_unmap_bars(struct ionic *ionic)
 			bars[i].len = 0;
 		}
 	}
+	ionic->num_bars = 0;
 }
 
 void __iomem *ionic_bus_map_dbpage(struct ionic *ionic, int page_num)
@@ -215,13 +216,15 @@ static int ionic_sriov_configure(struct pci_dev *pdev, int num_vfs)
 
 static void ionic_clear_pci(struct ionic *ionic)
 {
-	ionic->idev.dev_info_regs = NULL;
-	ionic->idev.dev_cmd_regs = NULL;
-	ionic->idev.intr_status = NULL;
-	ionic->idev.intr_ctrl = NULL;
-
-	ionic_unmap_bars(ionic);
-	pci_release_regions(ionic->pdev);
+	if (ionic->num_bars) {
+		ionic->idev.dev_info_regs = NULL;
+		ionic->idev.dev_cmd_regs = NULL;
+		ionic->idev.intr_status = NULL;
+		ionic->idev.intr_ctrl = NULL;
+
+		ionic_unmap_bars(ionic);
+		pci_release_regions(ionic->pdev);
+	}
 
 	if (pci_is_enabled(ionic->pdev))
 		pci_disable_device(ionic->pdev);
-- 
2.17.1


