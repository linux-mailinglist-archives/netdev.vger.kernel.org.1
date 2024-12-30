Return-Path: <netdev+bounces-154580-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DDAA9FEB1C
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 22:46:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2F4B1882C9E
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 21:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B3E91AAA23;
	Mon, 30 Dec 2024 21:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="U2fJWwjb"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52C819C540;
	Mon, 30 Dec 2024 21:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735595120; cv=fail; b=tNj3KXkgsSCudJcilkQuWS7n/nd3R7/KI4xSmtCffQMbu8SPWijDWAzQTDxrDyDhtXmaamDuxCkRayEzQwiOI0OFrAPYjQTHI3IZTmJIKK1/mFd+w0QOYU795Alx3HLEzQgQtw9K+qeDOort8tm7awGw0+4DyNjKG6XaaJOIo1Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735595120; c=relaxed/simple;
	bh=sDGnD9Nd3XA6j30LCROxzjeC6wDeN9s5fiL8X4XITTo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ulXjUzhYwcaxQ5wAWaIPqj0SlDG512KQHZxqqj22aUAOikXFENVHAQ/gkXMdTu6R5+jkTQtA0gGZve5BXi6DI37hUJtGm+l2M3YgbTN/5oW7L952YnFWYL07A2+AZRxM3xKa3yBJTXUik8gteIzdyMBTgtOyGPFGsxicFi7nxRc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=U2fJWwjb; arc=fail smtp.client-ip=40.107.223.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ud65vI2OfGkcOxkwM7mJg/Umx9v9YKR00QrbBoZLy27A9dLsG3HkhMTCXjegcOzZFOW321c3fuCdmKscFSGwLIGNBlJYbEob+K64GJRGtDO1GK6aHswHpJwkKoe70eP/5qY6vI6wUKnnvFp81C6ID4Us8gSUdSl8DCEUEnLmqGRRXwhtZL43zT2YJ7k5qu5uVTc0H7TD6I0yYE1dGFoZVUhgyDhhaBqQ5pffvWo4XU4+CHzwpvaI1zDyuAD1HLE70eR2dfkAg3x+X9yvR7E5k22d7NGn59NSPnULVrCVrmNR7Y/zMgZeW+sIVRbgHGxzE7TO9khgD5l+RtC35VkRqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mnBDbOuSGiSQotCnP5EqvhgGY5uTEoiCWiiPWqXtB2I=;
 b=YdRexz06pkpRezE6zun/wJl4UEFI1lIfNGCbk7OVajtvJ5osWNMCIl8xzNk49668ewwMTR6Jg82pmEmJqvJ0g0a+10TPRXqUJQUCHeTonaNIgbctqOt2F/Phn9sP424T0RCguN5b3a5IVgb/7N1ef20kTv27alQm2W31+vejUsj5qy7gdpDzBq/9emDmdvMUkJ2UWFjGklMGxnSvZQ9CwS2Qr4rZKMMOATzoskvkcMc0Aukc3lL5a8DmxVBMKi1cKYb8DYaAYE78eVO7cc1iALO8R84x1zwRplISHXanvFo+HAJY+M5WtXL3HK1RtZgmYbdNu0xz4WDL33cUZ7ecLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mnBDbOuSGiSQotCnP5EqvhgGY5uTEoiCWiiPWqXtB2I=;
 b=U2fJWwjbXbg0D/0FqRZCi/vqYxAHwXYfu+NkW0c8ha2DJhowd0TY4do5c9VgWbSJo+ze3ieN/9VIDQKaXC9dRShMZlUou+/YWunTWTqjXcuEjT3WZuhCiNpUzQ4RylF9dLV9VxQhmkv/RZRSq+ltOpx/PFmg9AT9x6yYhfy0TVs=
Received: from SJ0PR05CA0113.namprd05.prod.outlook.com (2603:10b6:a03:334::28)
 by LV2PR12MB5775.namprd12.prod.outlook.com (2603:10b6:408:179::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.20; Mon, 30 Dec
 2024 21:45:11 +0000
Received: from SJ5PEPF000001EB.namprd05.prod.outlook.com
 (2603:10b6:a03:334:cafe::a6) by SJ0PR05CA0113.outlook.office365.com
 (2603:10b6:a03:334::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.7 via Frontend Transport; Mon,
 30 Dec 2024 21:45:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF000001EB.mail.protection.outlook.com (10.167.242.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8314.11 via Frontend Transport; Mon, 30 Dec 2024 21:45:10 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 30 Dec
 2024 15:45:10 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 30 Dec
 2024 15:45:09 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 30 Dec 2024 15:45:08 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v9 11/27] cxl: add function for setting media ready by a driver
Date: Mon, 30 Dec 2024 21:44:29 +0000
Message-ID: <20241230214445.27602-12-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241230214445.27602-1-alejandro.lucero-palau@amd.com>
References: <20241230214445.27602-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EB:EE_|LV2PR12MB5775:EE_
X-MS-Office365-Filtering-Correlation-Id: 0db7cac0-bad7-4d84-8563-08dd291b3c5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XsZTwSJagc5+UlTvoXcP8tT3f0mnFyrCI5znbk6i2bSTBmWIj7m9azZHt/mC?=
 =?us-ascii?Q?0nE8tFh1JQugqbjmCtpSd6QYhVoizThyeSC+WREViI8k9yV7TnDJyJIWz1Ud?=
 =?us-ascii?Q?Jvra4nuaZZsjD/YtzqQSRVlfYrK1jKYgcXu4olQrLxhBIgzCW5t4rMdzdMP9?=
 =?us-ascii?Q?/9L0rc5tnbvKrtPoejIjXpCe85GOIqLYBcO2T0lxFsoLqop+eueJNgoMo1sb?=
 =?us-ascii?Q?m6tBL4XlWyf4wBq5NS7RwaJsfPA1fwFFI2ZkMWKj7v9I+bVoiXp77UqY2m/v?=
 =?us-ascii?Q?A1NBcIE7FBGUFZaoPkTRoCjL8I7r6SB74MOmrvlTXKhwzBXJArpRp7kEBllj?=
 =?us-ascii?Q?C14wYJcYudx2rQB4mMb4fyDoqizPrNLB7tDsGlMmA+5C05sHKcXtUW93/Edk?=
 =?us-ascii?Q?G/xPtIGpvq+0Wmdan84pFE34dAEft/vmfphF6sq9OLPEoCERECzSdXMDFLvW?=
 =?us-ascii?Q?0wt5Pq55407KGMBcYBuz66Dy/O/5X/gv/0sU/wGYZyr17+H+ktOSLKk3VhZF?=
 =?us-ascii?Q?Fslqp25E5IAnvXpXRYepGkU1hm3YsLvXTjsllGyTyCaKmYOmQTXN0rCFLF39?=
 =?us-ascii?Q?N8SM9DEX6shVue+CtOgNsBK0UtthazXGuh8/aqvXD2Sf0sXSfmYVeEVcxWKX?=
 =?us-ascii?Q?soTjIPv5Fe7Q+WZd0WusTUsvs3mLfMtvq9BzZDCt5Pt+6mDKISiNehjisXe4?=
 =?us-ascii?Q?sTXsk6pTmu9J4FX8qXxpLNwYqc7jpSGxDv4eKN3dETN7/w3rjKlpCZPe+z8e?=
 =?us-ascii?Q?OXMxD6tjkUU+xBR76HguoDa0dLdMea5H1TMzUYfUBlfwry0VwD5iiebCxzDz?=
 =?us-ascii?Q?UbMj1bhYE+iKzJqmyIvSYcsXXN2MzTMIpY0vvWdXGfSPJTMx3QAZMl89KtF6?=
 =?us-ascii?Q?438pU9TPpXSXYTx+OMbYjNgb4bm8PW5yVu3eviSl6JylHdUpDPB17DPBMhrW?=
 =?us-ascii?Q?BnKe7SapCd/MYulQpyBYq0m4liZ6pglmsRF+qsVf4xxLx7eI1Dl6ZdVu0jW0?=
 =?us-ascii?Q?inDqc9S6lqCwA1VCmRmu9QtXiGjpHdQFWhN1/XNMTwu9yGgPhAo0kZ0V8rE7?=
 =?us-ascii?Q?NRQjibIOihD1nPF53bggdSuxGUhMi7q1+yKc/iHrzwcNvIzYrpeE7vAVg22c?=
 =?us-ascii?Q?6Vs1Spog78ai6GyC8jmUgnHGvsDuWLu8HXUNsaXQnZOLT98nqH1FwsIZ5Bg0?=
 =?us-ascii?Q?8Wcb4kiCDliL9r0sLGtidBln8GTltfLQ3FK2mXN9p9vuKKk2O4k8nq3cqCS8?=
 =?us-ascii?Q?lLrELjodHnE3yRA6B+I032yxeYOLwCBQk0BSFdExkdBAt3FxY6l4GYZsSXHQ?=
 =?us-ascii?Q?JJw9+U8zlnBj54TvRKTmqDEu/lQp5XgsW4HtLNnRrDkCrVUeUXyLyjZxwjRS?=
 =?us-ascii?Q?UrLmvWeaqu6bVa3uektDg2cXth9o7I/uK9gDx79FbODj8+GoMrYE8cMd3gQt?=
 =?us-ascii?Q?gpF3YQxsIhfsksB7xBXLE8kJkUyzFHSj3QhJ6tUeFjfEdryaTwe3gQZnDk5r?=
 =?us-ascii?Q?KvwPw33do8M2Ls8=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2024 21:45:10.9158
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0db7cac0-bad7-4d84-8563-08dd291b3c5d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5775

From: Alejandro Lucero <alucerop@amd.com>

A Type-2 driver may be required to set the memory availability explicitly,
for example because there is not a mailbox for doing so through a specific
command.

Add a function to the exported CXL API for accelerator drivers having this
possibility.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/cxl/core/memdev.c | 6 ++++++
 include/cxl/cxl.h         | 1 +
 2 files changed, 7 insertions(+)

diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index b104af6761cf..836db4a462b3 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -783,6 +783,12 @@ int cxl_release_resource(struct cxl_dev_state *cxlds, enum cxl_resource type)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_release_resource, "CXL");
 
+void cxl_set_media_ready(struct cxl_dev_state *cxlds)
+{
+	cxlds->media_ready = true;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_set_media_ready, "CXL");
+
 static int cxl_memdev_release_file(struct inode *inode, struct file *file)
 {
 	struct cxl_memdev *cxlmd =
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 87b192095fe3..f67ee745d942 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -47,4 +47,5 @@ struct pci_dev;
 int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlds);
 int cxl_request_resource(struct cxl_dev_state *cxlds, enum cxl_resource type);
 int cxl_release_resource(struct cxl_dev_state *cxlds, enum cxl_resource type);
+void cxl_set_media_ready(struct cxl_dev_state *cxlds);
 #endif
-- 
2.17.1


