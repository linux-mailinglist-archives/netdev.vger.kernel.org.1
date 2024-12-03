Return-Path: <netdev+bounces-148588-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49E549E2720
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 17:21:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A34D289211
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 16:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE391F131A;
	Tue,  3 Dec 2024 16:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4m6GfBLM"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2049.outbound.protection.outlook.com [40.107.100.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9731F76A4;
	Tue,  3 Dec 2024 16:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733242892; cv=fail; b=r3icLmU254P8dmaJIaUMGJ5HGdprciZFBxbOb6JZJfRyMGqJh0mzyE3EGJtvt0JRsEnfoytZiWJboHVmxM9M9QgFgD9PEyVSpB8+7XWgoPu1ojXox81RE+Im+u5tRm1oh0a43aCEMwTSQXZuSv8UwzcP3Nwf7kaHhFo3jChbz+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733242892; c=relaxed/simple;
	bh=jE90JTDp1RQwYKAV35EBQ/INBSHOiS4Ykm5L8YyEcMs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CVTrDXOyAjmTssHsNBxl5MKG6D13bIIytwd45hTwyEOHhWUXaKFuqhewWC+u1p17c4oi1uv4pusL9gV5cQf/5MnHg+R8k3PnBsrXHV5vNwdHIbCnZo5EtL3maIlDcTwhbXNTYvgYNmockZAVqwyERv1b1qcjk+0hyvQjGt8jWyQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4m6GfBLM; arc=fail smtp.client-ip=40.107.100.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eeAPzHSrvzVDbLyyIlEMA5Bnk+VZ0UpXN9xdxKc4bunTIV6r06lTuDFhZYiE5TA1foxmNRznGN+gRhb1KjhdDstDaL5Mols/FSPiNv0RjDg5qaRzTikLHcJp9wQe9p4gGNQ7xVCYP2uVN3e04SdflSJjQj96RpDYCf6q8DRcDs0PPFxIBefkmpbZGOcY4iwoGwHi0951EyZJDjS5hkZf/l2PMdz4ZuY6Ijk49/RfDMnFNh4BHFJxu1Eadql0/XYdm83WhMViozkRem9cp/nEkVab5JTJVj9T9bnJBLAsMGZ3RJaLyiVlG9YjLfiHvjo58ccd7oYg1lF16DWK6OMQww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WrOKQ1ZZj2o2UZ7suwJ34+8gsRfOW84ceSP6faxyrWg=;
 b=AF/5Y6MYfMqytx0smKsZjXt3rH0pGsbWZzqyhMt+UW7kSZY7zmcZdq/+M8a4gYPiVakOv8xVkT/tEI3M1UiHM7uO6iIfMxQ/rZh9R3vuKXHnod8XQ+qF6mCMnppVzUJ5e63MbJTeHQEbrBjfoOet311kx572JKFWvsX5ITGfuOpZ/mQ2KrvMu/ZrFl5bPLgdAaTszDteSV6IaAcO0REKzeQ8Y0D6uutMjwQPLpoztQDYjGoy9dasOn6YEu0ELSy4rcPJVz9W3+8J2jq7ebBZuDV4YWkabHFSv0FIgqcnNx0vmJ6EqMZvCRORK3GDKHlmw1HUyH7MGMVP23V4ULA36Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WrOKQ1ZZj2o2UZ7suwJ34+8gsRfOW84ceSP6faxyrWg=;
 b=4m6GfBLML29j9sgcCWP/jzlR0vYY3JWMLOOw3qYqxzYYFspDwaONPG3NDE+pfuOjphxgsaYY/44yt4ZSLBN6wFSQatJNTUigtl2U470qkWq81EjqNt4pAYyW+pUJruSEM+qf31NDOlMDzpply91RImtwxHtRl8nkRBnioI3X2Jc=
Received: from SJ0PR03CA0021.namprd03.prod.outlook.com (2603:10b6:a03:33a::26)
 by SA1PR12MB8920.namprd12.prod.outlook.com (2603:10b6:806:38e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Tue, 3 Dec
 2024 16:21:27 +0000
Received: from CO1PEPF000042A9.namprd03.prod.outlook.com
 (2603:10b6:a03:33a:cafe::42) by SJ0PR03CA0021.outlook.office365.com
 (2603:10b6:a03:33a::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.18 via Frontend Transport; Tue,
 3 Dec 2024 16:21:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042A9.mail.protection.outlook.com (10.167.243.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Tue, 3 Dec 2024 16:21:26 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 3 Dec
 2024 10:21:25 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 3 Dec 2024 10:21:24 -0600
From: <alucerop@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <Jonathan.Cameron@huawei.com>,
	<nifan.cxl@gmail.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCHv4] cxl: avoid driver data for obtaining cxl_dev_state reference
Date: Tue, 3 Dec 2024 16:21:12 +0000
Message-ID: <20241203162112.5088-1-alucerop@amd.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: alucerop@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A9:EE_|SA1PR12MB8920:EE_
X-MS-Office365-Filtering-Correlation-Id: 3355378e-0f18-442f-b040-08dd13b68980
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AWwOU0PU6XwG0KAARHlQkphEkYH4lrG1yQdAPYMSfY5O9INbRKYOiz+V2Bz2?=
 =?us-ascii?Q?sj3qPSdXtXDu3pXlGDRv9BnT9UbFCQ5KZ+ch9WaBnK49PwPK2GyvEmLYOjZ0?=
 =?us-ascii?Q?2MZyuRNvYFMme/1LcRfgIzQVs1Lhxf9opjcZm1kdgZRGOOaWNCz0oui9/F96?=
 =?us-ascii?Q?Ybf+VophowxGn2a8oQFHgQ08JEeTVYyzswXTmli9liH7J22nc/TxG2UWiVqo?=
 =?us-ascii?Q?KI/mWDyGnb28YJmjCMzZYQqto6cjVLmF8yFez5rwvSlOlxZKA7Bd74x4PXBU?=
 =?us-ascii?Q?sKKs2FmJywHZybfi7nd1FsZeBwFCCaZ9g/HPC6Nr4vC0ni0rbiFU4HB0atgt?=
 =?us-ascii?Q?7WPZpU1iZn6hAmGBtWN+UERb0gOnefTkkO4oirETz1/h83vt6jIbt5iohGZ3?=
 =?us-ascii?Q?WcRL22dd670b/ivv4vd3VFzf1cz6pM9Ekf6c0SHhrw0sbv2kvLrA7vm65akH?=
 =?us-ascii?Q?eC+D6xJGrFhrLuTxirz7o+Z1aiolK0wMC03Sye1Qr98fb3Hc3aMvmAFTPK73?=
 =?us-ascii?Q?P3hsE8El27j6ZhWMbaWGhDULhMDipK1LOojXGNebhKD9kL9v1g37hdh77pqh?=
 =?us-ascii?Q?mlro4KNTKp/uLp27UKnC/437b1ibgfgQ18ksvWraBd/lSRF+6VtJzF6VQnl6?=
 =?us-ascii?Q?vJX/lQtVlMhrm4wxvhFyaboRijznRPUw/lAmVoz/Wr2anaHR6VwXyZf1w/mB?=
 =?us-ascii?Q?lvSMAm39wVhv74XBKnnrA93nkYR3Gc9fRM0qA9wkjm6gLBh7WFS12//K1Ybf?=
 =?us-ascii?Q?aZXRjvlDIECddglUTuqdscwJnogITC44yiWsjSJhORrDiONnddh3uVwv83Aj?=
 =?us-ascii?Q?pcO2NfossYRCKHgLpSx97dWeHJM0rlzhkn1YQcHt3vPRdO1dMTNF3mvUOEVw?=
 =?us-ascii?Q?OPJdrfN6oeJPpKpg9rqQ2zwwuuNejSyP5AQCG2Zhfx/wq2fd4c8O287EYldM?=
 =?us-ascii?Q?I5Ir6hEEaWS59M13m6XPuVn1l/votw9s3SbHeeg6AWf4RHA5M5yr8zJ+Mb30?=
 =?us-ascii?Q?o0dKCjZarRDLVqMYdxwMvQD0B36xz7FoLNEp6EztZ+f//bDYyriZ7jYQtypg?=
 =?us-ascii?Q?jXoTGe8iLTBH649HNWQiHZu6LG7VfK4rHr2r7T+POQohNZZcYec/nt3AuDXJ?=
 =?us-ascii?Q?fz4AcNkWxWXYVY5mYBARksutq7BDi11c9Y5epnjRKunA1ihwLe14Eupev5qr?=
 =?us-ascii?Q?gAOomsCaMf1sJvZe5tmcWhK53DmWDWb5fyHtY+WzwcjjWmhDX0mNUDYb7prD?=
 =?us-ascii?Q?7V3rX0v1OHNh/a2xAwfSENbtmwYfi5zyTOBoV+btGXtrLhZvG0Y2pTrGUfK2?=
 =?us-ascii?Q?w+oZyR40EwVOkE5a51rArvXrjnjj3ChSQs2PTQkGPATyhN8T/5NVtyykzOuQ?=
 =?us-ascii?Q?fFlRGxHwDEm/hSkS8+6n7htFkLovH+uM+gfPfx+5EABbAKZYaZZ6X6pN3qEQ?=
 =?us-ascii?Q?dl6cBn07HWdzC2VoBwwtC58Z+2P6RqPS?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 16:21:26.6803
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3355378e-0f18-442f-b040-08dd13b68980
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042A9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8920

From: Alejandro Lucero <alucerop@amd.com>

CXL Type3 pci driver uses struct device driver_data for keeping
cxl_dev_state reference. Type1/2 drivers are not only about CXL so this
field should not be used when code requires cxl_dev_state to work with
and such a code used for Type2 support.

Change cxl_dvsec_rr_decode for passing cxl_dev_state as a parameter.

Seize the change for removing the unused cxl_port param.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/cxl/core/pci.c        | 6 +++---
 drivers/cxl/cxl.h             | 3 ++-
 drivers/cxl/port.c            | 2 +-
 tools/testing/cxl/test/mock.c | 6 +++---
 4 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 5b46bc46aaa9..420e4be85a1f 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -291,11 +291,11 @@ static int devm_cxl_enable_hdm(struct device *host, struct cxl_hdm *cxlhdm)
 	return devm_add_action_or_reset(host, disable_hdm, cxlhdm);
 }
 
-int cxl_dvsec_rr_decode(struct device *dev, struct cxl_port *port,
+int cxl_dvsec_rr_decode(struct cxl_dev_state *cxlds,
 			struct cxl_endpoint_dvsec_info *info)
 {
-	struct pci_dev *pdev = to_pci_dev(dev);
-	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
+	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
+	struct device *dev = cxlds->dev;
 	int hdm_count, rc, i, ranges = 0;
 	int d = cxlds->cxl_dvsec;
 	u16 cap, ctrl;
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index f6015f24ad38..fdac3ddb8635 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -821,7 +821,8 @@ struct cxl_hdm *devm_cxl_setup_hdm(struct cxl_port *port,
 int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
 				struct cxl_endpoint_dvsec_info *info);
 int devm_cxl_add_passthrough_decoder(struct cxl_port *port);
-int cxl_dvsec_rr_decode(struct device *dev, struct cxl_port *port,
+struct cxl_dev_state;
+int cxl_dvsec_rr_decode(struct cxl_dev_state *cxlds,
 			struct cxl_endpoint_dvsec_info *info);
 
 bool is_cxl_region(struct device *dev);
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index 24041cf85cfb..66e18fe55826 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -98,7 +98,7 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
 	struct cxl_port *root;
 	int rc;
 
-	rc = cxl_dvsec_rr_decode(cxlds->dev, port, &info);
+	rc = cxl_dvsec_rr_decode(cxlds, &info);
 	if (rc < 0)
 		return rc;
 
diff --git a/tools/testing/cxl/test/mock.c b/tools/testing/cxl/test/mock.c
index f4ce96cc11d4..4f82716cfc16 100644
--- a/tools/testing/cxl/test/mock.c
+++ b/tools/testing/cxl/test/mock.c
@@ -228,16 +228,16 @@ int __wrap_cxl_hdm_decode_init(struct cxl_dev_state *cxlds,
 }
 EXPORT_SYMBOL_NS_GPL(__wrap_cxl_hdm_decode_init, CXL);
 
-int __wrap_cxl_dvsec_rr_decode(struct device *dev, struct cxl_port *port,
+int __wrap_cxl_dvsec_rr_decode(struct cxl_dev_state *cxlds,
 			       struct cxl_endpoint_dvsec_info *info)
 {
 	int rc = 0, index;
 	struct cxl_mock_ops *ops = get_cxl_mock_ops(&index);
 
-	if (ops && ops->is_mock_dev(dev))
+	if (ops && ops->is_mock_dev(cxlds->dev))
 		rc = 0;
 	else
-		rc = cxl_dvsec_rr_decode(dev, port, info);
+		rc = cxl_dvsec_rr_decode(cxlds, info);
 	put_cxl_mock_ops(index);
 
 	return rc;
-- 
2.17.1


