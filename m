Return-Path: <netdev+bounces-182286-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55EF6A88729
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 17:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 207D0189F98D
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 15:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E37C274FC4;
	Mon, 14 Apr 2025 15:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="K8BRvgF9"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9152749C2;
	Mon, 14 Apr 2025 15:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744643639; cv=fail; b=iS1pJTCrhgM/ieriOsmOpP85nxtmf0s12e3B7Z8MI5VVjuMtvNmObnDYq3vonSW8p/Ljen7PBPivTbNsEm8RKpoNoqPCKqr821TD1q1oENR2MNRjhimX0jNxiRWJY3liHAxxPepGIGnj4dHkdkLMatdIoTBDwrNUyYz0b7028WQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744643639; c=relaxed/simple;
	bh=LKCC4953ySnkSQg+hAJ89i/5F9z8d4vt0m3b8W1HEhE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b8EgA/uIhNF9hH/kdvyHYMAVDINpM/0sdqMcl2KWddRINim4HL3tOZLKzueDXLvNWrRrttLl32eaOmejYX1Uq9PkqLAtw5fw80QyjwPL+/AJRlVfNvSB4TGEs2UveKSr8t+5NMrk2i3nWgZGpw9eoIO++4jxfevCFntnkY/L7Po=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=K8BRvgF9; arc=fail smtp.client-ip=40.107.94.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u7oXUwc7ylmvXHpORO3TzoGe/1UdngmADpij7MHBTbPT2bxNdmYDthEiWmpj7XDJ+Vgpy9linsyb2CWtbGFzGH1k03sqhbbDpVka5N/+tjH6RoPEFY7nQC9G0peuzTqIvw66tkahrLeuGm1VLB8H5ixLAtaCtp44aX2JjKsyBnh1cpm5Nhvt21abVM17ebC5paso6Jdv79ZkxbkUMJoqrwZBkklrQjHmEN9ZcgOiiThRrYioRdU9O4ofbCWghLrfaGJwrqWtYjwn+LS2Ext8sfCPUggU5CkGMeZM1KCuIrhUhqUiseVV6rfr+/chKZi8jHo2I0BGaxRWPlZSvZmxVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FXpL8jVpLpBxHL1KK8UgFiS70vciIQEroqGRqsTKCiA=;
 b=uEetQfZEp2ZpL6Go67PmgjFdXXUGBE5or+O6C/tSDZHLwSv9kCFVwToj7p41g8zE1xO0LHrbf/iOagLNU4zY50nRF18Uqa8FcO5RF+W1AZGZm1hLiVkLq3LsjGkTW4pp6PsCvceb8XvvtfsimwzqDuvOWBjPgtF400ROOzJIbgwf7Ohr39j0M+s8CvVHow7YefhZsGm4MM7U+57U1Lr7OVBRQyx3BBjhEDI0XQZtUPFEbbrcQYieB5praiROjCF1R97wrDl9Y5wwlQpEMfJZ+g8lAACR12uX3fk1zb/MrT8a0a4MQj+clJ6vwJuGJf3tHBt7tXP6Ank5pHzM4cMB/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FXpL8jVpLpBxHL1KK8UgFiS70vciIQEroqGRqsTKCiA=;
 b=K8BRvgF9LMFDG7+MnkasM0A0GC8pc/J9VIy/W5u1yAi4VJDyJPVGcY3MUkhlN2CcqKVwvE+vxQPJOurpAlfG5T/56i61E1sEfiyGh1y8Hp5IvIDnY2NHkc3L422Dq4vKc/sfOe7BvUYXHzVzCd+VqZN9KBEZP3QWMa2ZcPFschw=
Received: from BN0PR04CA0056.namprd04.prod.outlook.com (2603:10b6:408:e8::31)
 by BL1PR12MB5852.namprd12.prod.outlook.com (2603:10b6:208:397::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Mon, 14 Apr
 2025 15:13:53 +0000
Received: from BL02EPF0001A108.namprd05.prod.outlook.com
 (2603:10b6:408:e8:cafe::62) by BN0PR04CA0056.outlook.office365.com
 (2603:10b6:408:e8::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.34 via Frontend Transport; Mon,
 14 Apr 2025 15:13:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF0001A108.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Mon, 14 Apr 2025 15:13:53 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 14 Apr
 2025 10:13:53 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 14 Apr
 2025 10:13:52 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 14 Apr 2025 10:13:51 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Ben Cheatham
	<benjamin.cheatham@amd.com>
Subject: [PATCH v13 05/22] cxl: add function for type2 cxl regs setup
Date: Mon, 14 Apr 2025 16:13:19 +0100
Message-ID: <20250414151336.3852990-6-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250414151336.3852990-1-alejandro.lucero-palau@amd.com>
References: <20250414151336.3852990-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A108:EE_|BL1PR12MB5852:EE_
X-MS-Office365-Filtering-Correlation-Id: a318b73c-857c-418c-fe19-08dd7b66f812
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mSzmPt2x89EMv4Cj29PaSxOAtAtWNdIlpMLqFqiFQNDqnhEDRs5QQA8bSK/4?=
 =?us-ascii?Q?eYr7Q5FmtP0NNL7Pq5oVJLpOCAHOYJCwruSEw6t6G+xKiBcLLpRes+dmcKAQ?=
 =?us-ascii?Q?L3FPDCX/hXrGh2pAEks/6NtcVA9jGykja7fe7husAcyNh3eEeu3bm1y8wX2P?=
 =?us-ascii?Q?/cNyzFzo6Wre74U74/IRLTH2YYb5SAjP9AwARUc4lxpjRhXVRLSdzxX+4v4q?=
 =?us-ascii?Q?udvcOnPcFPDkSBLawO17bGbteClbrtp2C3HH3FbGWdgSPwCotJMEmC51auRA?=
 =?us-ascii?Q?rVtFpMnB9RrPeiqcdY/ZF7+Rdhjz5GkNfzE83KP1B7PFSJGltvzoZBtttVtC?=
 =?us-ascii?Q?UeAzXb9sXgQGL1ieBE6EFYDcd+ZH4p/zOnipMajxevOyIN82CMx0aJ4UL8S4?=
 =?us-ascii?Q?GvUBW0qJdBA0Sc/YTnX2C26U78Tw0yXMY8HgWkqvv2cjiKsvEG7tdjC98TaI?=
 =?us-ascii?Q?vIO0+bzsCT7h+XmoDt5n22DojLCrYvqDTIVx2yaI1WfZklMMzi1b4twBaU4J?=
 =?us-ascii?Q?h9B0OmiYlunsAD9/YbF6GKtmr5nNYYliEwINjdhJsWj0gvMNlqosKb4BXMTg?=
 =?us-ascii?Q?SMfoYnv2w17pKal34QF0GFHIhNhc3IDaBl93iuQ+ZDeBeGDhTDkYHj70GCj0?=
 =?us-ascii?Q?hzdH7+nnEmCWIkVQ2E3T0DAgYeX5MyE/hysJgjcwu6EvIF0WVHWvSUwCKUwl?=
 =?us-ascii?Q?VgB6fp3/ukRiqevfZUSTzSu3bdQpxo5utUDFvrJCcCiK9sw5tm8m223ANNSQ?=
 =?us-ascii?Q?TqA1mhvz2eX14PGOcvkthVqbqiJ7tNaJrw4p+gRUHde/2OrpoDfruS7TUJqL?=
 =?us-ascii?Q?vHOAg3KZyKo28PuTIYURHkqjT0S52Hcr9XzxkOWnSZ7HQZ270s/UIRyAdc+F?=
 =?us-ascii?Q?d4/krEeruEqvLJyiTV/QM5dwtQwzzGfjtC7wWe79z13D3GtOWAk/X7bYsBOp?=
 =?us-ascii?Q?mCkD4dTfXOhppAYdRNxJDaCpvXjmJKlA52q0S8kVq/roWZv27tGEmxaTtzoM?=
 =?us-ascii?Q?dhww+nNZ7KNaXYYsPGH0oTiro3hnyP3WAUcigu2wNXv1LiJ2DqF+fGEGeaYy?=
 =?us-ascii?Q?ZCae6eRtIGclZ4zPqvMdOgpFtvbkh6nDtNGZrDAH4rnDVJIeaVmuGQtq6jL1?=
 =?us-ascii?Q?hBBtOVbwqIvyQfuTpFsnmbOYl8SHOXC2FDyrEaseo3SfnMkJ2DQ0paGUfLom?=
 =?us-ascii?Q?ZjLvod1fAK3F/S6Nn/wnPTAgOUvfRT29i7cqU9QMoDquK2vwL0pPhnfbi9eL?=
 =?us-ascii?Q?J3F2pExXtfz9227H7CjMtr1l2RK598btR9+JgRYXxOWRy2Uqbi5QBWlzJjhF?=
 =?us-ascii?Q?5goh28oOncCnLYK23POyznZ+jFibe3SP+I+GI2vieJBD4GOkodxYSyzGMmbO?=
 =?us-ascii?Q?ASlZdu0ZrzMNlHvWVGyjayOKIOl2XdyoGV5IAR/nh/DhyuwWHhLqLpYQXv8x?=
 =?us-ascii?Q?z27KxMhhIjMlyBAKpgBkJTvsWuG+8KvET3iDbugiRJhPISQAj5qQG85qJu/X?=
 =?us-ascii?Q?rnsOjf760655dP7kvjRhmZvBAqwqac3VMIqg?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 15:13:53.5040
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a318b73c-857c-418c-fe19-08dd7b66f812
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A108.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5852

From: Alejandro Lucero <alucerop@amd.com>

Create a new function for a type2 device initialising
cxl_dev_state struct regarding cxl regs setup and mapping.

Export the capabilities found for checking them against the
expected ones by the driver.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
---
 drivers/cxl/core/pci.c | 52 ++++++++++++++++++++++++++++++++++++++++++
 include/cxl/cxl.h      |  4 ++++
 2 files changed, 56 insertions(+)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index ed18260ff1c9..309d1e2a6798 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -1095,6 +1095,58 @@ int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
 }
 EXPORT_SYMBOL_NS_GPL(cxl_pci_setup_regs, "CXL");
 
+static int cxl_pci_accel_setup_memdev_regs(struct pci_dev *pdev,
+					   struct cxl_dev_state *cxlds,
+					   unsigned long *caps)
+{
+	struct cxl_register_map map;
+	int rc;
+
+	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map, caps);
+	/*
+	 * This call can return -ENODEV if regs not found. This is not an error
+	 * for Type2 since these regs are not mandatory. If they do exist then
+	 * mapping them should not fail. If they should exist, it is with driver
+	 * calling cxl_pci_check_caps() where the problem should be found.
+	 */
+	if (rc == -ENODEV)
+		return 0;
+
+	if (rc)
+		return rc;
+
+	return cxl_map_device_regs(&map, &cxlds->regs.device_regs);
+}
+
+int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlds,
+			     unsigned long *caps)
+{
+	int rc;
+
+	rc = cxl_pci_accel_setup_memdev_regs(pdev, cxlds, caps);
+	if (rc)
+		return rc;
+
+	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_COMPONENT,
+				&cxlds->reg_map, caps);
+	if (rc) {
+		dev_warn(&pdev->dev, "No component registers (%d)\n", rc);
+		return rc;
+	}
+
+	if (!caps || !test_bit(CXL_CM_CAP_CAP_ID_RAS, caps))
+		return 0;
+
+	rc = cxl_map_component_regs(&cxlds->reg_map,
+				    &cxlds->regs.component,
+				    BIT(CXL_CM_CAP_CAP_ID_RAS));
+	if (rc)
+		dev_dbg(&pdev->dev, "Failed to map RAS capability.\n");
+
+	return rc;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_pci_accel_setup_regs, "CXL");
+
 int cxl_pci_get_bandwidth(struct pci_dev *pdev, struct access_coordinate *c)
 {
 	int speed, bw;
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index afad8a86c2bc..729544538673 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -231,4 +231,8 @@ struct cxl_dev_state *_cxl_dev_state_create(struct device *dev,
 struct pci_dev;
 int cxl_check_caps(struct pci_dev *pdev, unsigned long *expected,
 		   unsigned long *found);
+
+struct cxl_memdev_state;
+int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlmds,
+			     unsigned long *caps);
 #endif /* __CXL_CXL_H__ */
-- 
2.34.1


