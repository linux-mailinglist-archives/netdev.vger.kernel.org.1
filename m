Return-Path: <netdev+bounces-56050-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 567F380DA15
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 19:59:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C32F281C0C
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 18:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D109524BB;
	Mon, 11 Dec 2023 18:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="w0fmxpoi"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2060.outbound.protection.outlook.com [40.107.237.60])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3E37D6
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 10:58:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nf0SRz6349KZ6mOAexKy9nxt3bvYkfSJ418vqMaa9KoSlLEGKW2kjvOSX9slEw1WQZllM2mxNoI/qK2M748NiPn9opLMgztfYBQdgC9EN3v8o9LtjPAHPkTxfIB6+KKlF7vzLWJEESOR5OEyuJleqiQDWlCBotA1WpeHH5hDEjk0jnzrRCr7Hc1Fal2mPbHABtWYN/KOhvs4iGX6bkTRrvcDNeGeG+QP0zdc21ddrB4Z8X5e2irCmY+yTlMvDnDvfMRee1CUvdTgCi6uYwRjz/elh84DXgCiXRPp0V8ad4Ty2CxEZTzVRsS8/I575/nmUGRDsl1n0lv1XuhTBr94TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3CB3HErWfGN4X4SRfWbhD6+51lQ1lgpcjRLjFMFWySA=;
 b=Q/nemKsshcRmJhIC0dgpYWfZVSSieSZzqhvq+58RFJ94oWjk+EzGZuUfREjvnofWvW5cARtdVa4WZ56cZdpHEMrigfJjrlSx2WPX3pAJWT/F1z2GBWz/1TQEGCx/CxTWsFX0kPsLwSLJ+4TIeaw64xnycwdMDeQcG3WRblHJKzur6OW/fUgf5BCWLCJ80aFDN2saIWLn6UIJwV8fQ9eKqFIr5GE8KG8ZSbqYxhdso95Fwp9rdixFM2NBXtxUAtnWL3TIldTCL7f5taVG08AAjl283QQ5fhbP+AgWGvNec81Yv1g/L/C/asQGxHfk5r++1n5CZKbh2aIJPEZZQV7Y8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3CB3HErWfGN4X4SRfWbhD6+51lQ1lgpcjRLjFMFWySA=;
 b=w0fmxpoiPfWBj9C/NLJSveCjpvamDmtnOx8nqzl9CmQYbLH98tYMc7ZEwbDJCn2aY6CW1UAMFiSwkKiXCfz5xdY1EWBPBiwpl+rh5+FR2M91TgrBT1y/RrxudKyeswQ55Pxv9b+ycicLWB7+8L/KBVxM4oj1AOmXJ7fIxOWixTs=
Received: from CH5P222CA0023.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::11)
 by SJ2PR12MB8009.namprd12.prod.outlook.com (2603:10b6:a03:4c7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 18:58:27 +0000
Received: from DS1PEPF00017093.namprd03.prod.outlook.com
 (2603:10b6:610:1ee:cafe::88) by CH5P222CA0023.outlook.office365.com
 (2603:10b6:610:1ee::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33 via Frontend
 Transport; Mon, 11 Dec 2023 18:58:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017093.mail.protection.outlook.com (10.167.17.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.18 via Frontend Transport; Mon, 11 Dec 2023 18:58:26 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 11 Dec
 2023 12:58:23 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH net-next 5/8] ionic: no fw read when PCI reset failed
Date: Mon, 11 Dec 2023 10:58:01 -0800
Message-ID: <20231211185804.18668-6-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017093:EE_|SJ2PR12MB8009:EE_
X-MS-Office365-Filtering-Correlation-Id: e1d08bde-a155-4d1c-28f0-08dbfa7b285b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hMQjHBWmadR0oT6/JOEbTOeV9CIVb/7jmnAvnIJr1I/yQxRN5rWpxw1PcRYNvuwaKRdBzLqXZRMNbuN025WEquIFf5Sycbrjlv3MpgDe/YekjcE8A1TmkR+lOudd3cImVHdswDImCN0m4HbO14yS+qAGPduVP+Z7VAH6KZymqIxY3VCKgU7MC/7npCDnUg1esfsmGq3ks2XuBGsq9OGSOL7su3vpHbwchrbenLJuDf/36X/IfB/n100eeuzx0Hu6qeS5XlRFQgBD8erJqdZcCSUmc7qdrC+o5Pyfa9+jmXOOLFG6BQYZVMr8K19KNLPTXO2mgrWiq9YAOVdeNyy4so+uXrtCsVMWqiS4TPfqS+pzJq7F6Xt+vY1Z3mYgwmYHTGqmAV5aQue02jl5LKkaD6BGsHVA7d/OqCrJ7W+v6wrFUR3phqEqu2wv4BnYJ5OtkaLpWrFpbNa9Po8WekwhiFjSCsAm242w/plNPr4hIo7k5InQ50BNyT6l9QdlBqtR978askZH6yEsH+XS0PUlYHoV0G+z13FJI4pYZWz6odVjaPA7oazedaM6sUhzS0dxUgI8dVlumj+lEBZ1e1CE9J+7TOfNiQSkzSONTlX2ZlHaoGYyx2+7hPWwDOcXBevobSjAE0AlDdWMKL0db5uAASx7NnsKCq3FVIF9/+7KSWbVhCwAebel/ZSPE4FL1CubLPUVP2rLC1SMhvZb0vne3o8uf+sLXCcLKxxluToOm66nuQmNsSjASi24vJv+vOZyYTh2MWKaYoZQiK5RDO4V5g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(39860400002)(396003)(376002)(230922051799003)(64100799003)(451199024)(82310400011)(186009)(1800799012)(40470700004)(46966006)(36840700001)(40480700001)(41300700001)(40460700003)(2906002)(5660300002)(44832011)(316002)(4326008)(8936002)(8676002)(54906003)(70586007)(70206006)(356005)(82740400003)(2616005)(36860700001)(110136005)(86362001)(36756003)(81166007)(47076005)(6666004)(16526019)(426003)(478600001)(26005)(1076003)(83380400001)(336012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 18:58:26.7103
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1d08bde-a155-4d1c-28f0-08dbfa7b285b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017093.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8009

If there was a failed attempt to reset the PCI connection,
don't later try to read from PCI as the space is unmapped
and will cause a paging request crash.  When clearing the PCI
setup we can clear the dev_info register pointer, and check
it before using it in the fw_running test.

Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
Reviewed-by: Brett Creeley <brett.creeley@amd.com>
---
 .../ethernet/pensando/ionic/ionic_bus_pci.c   |  5 ++++
 .../net/ethernet/pensando/ionic/ionic_dev.c   | 23 +++++++++++++++----
 2 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c b/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
index da951dc7becb..311d9f4ef0e2 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
@@ -215,6 +215,11 @@ static int ionic_sriov_configure(struct pci_dev *pdev, int num_vfs)
 
 static void ionic_clear_pci(struct ionic *ionic)
 {
+	ionic->idev.dev_info_regs = NULL;
+	ionic->idev.dev_cmd_regs = NULL;
+	ionic->idev.intr_status = NULL;
+	ionic->idev.intr_ctrl = NULL;
+
 	ionic_unmap_bars(ionic);
 	pci_release_regions(ionic->pdev);
 
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_dev.c b/drivers/net/ethernet/pensando/ionic/ionic_dev.c
index c0b347dd6bae..1e7c71f7f081 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_dev.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_dev.c
@@ -165,9 +165,19 @@ void ionic_dev_teardown(struct ionic *ionic)
 }
 
 /* Devcmd Interface */
-bool ionic_is_fw_running(struct ionic_dev *idev)
+static bool __ionic_is_fw_running(struct ionic_dev *idev, u8 *status_ptr)
 {
-	u8 fw_status = ioread8(&idev->dev_info_regs->fw_status);
+	u8 fw_status;
+
+	if (!idev->dev_info_regs) {
+		if (status_ptr)
+			*status_ptr = 0xff;
+		return false;
+	}
+
+	fw_status = ioread8(&idev->dev_info_regs->fw_status);
+	if (status_ptr)
+		*status_ptr = fw_status;
 
 	/* firmware is useful only if the running bit is set and
 	 * fw_status != 0xff (bad PCI read)
@@ -175,6 +185,11 @@ bool ionic_is_fw_running(struct ionic_dev *idev)
 	return (fw_status != 0xff) && (fw_status & IONIC_FW_STS_F_RUNNING);
 }
 
+bool ionic_is_fw_running(struct ionic_dev *idev)
+{
+	return __ionic_is_fw_running(idev, NULL);
+}
+
 int ionic_heartbeat_check(struct ionic *ionic)
 {
 	unsigned long check_time, last_check_time;
@@ -199,10 +214,8 @@ int ionic_heartbeat_check(struct ionic *ionic)
 		goto do_check_time;
 	}
 
-	fw_status = ioread8(&idev->dev_info_regs->fw_status);
-
 	/* If fw_status is not ready don't bother with the generation */
-	if (!ionic_is_fw_running(idev)) {
+	if (!__ionic_is_fw_running(idev, &fw_status)) {
 		fw_status_ready = false;
 	} else {
 		fw_generation = fw_status & IONIC_FW_STS_F_GENERATION;
-- 
2.17.1


