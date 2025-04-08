Return-Path: <netdev+bounces-180423-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04424A8147E
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 20:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1FAD1BA54B1
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 18:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 307D524501F;
	Tue,  8 Apr 2025 18:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OpK2DfAk"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBBE245027;
	Tue,  8 Apr 2025 18:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744136460; cv=fail; b=YZNM8BGS0CZKWUrdo/sPfqMOf9YmFyMynN2KVmSdmP8VcJXWTQMwJS4gmYo5eMnux5kupB8BMNvCLov2E69ERQfjQh6U6k5cvuXHSISHu9538iQNwac0aw4YEh7znwrDRHAX//1065F+uOnkeW9YNRCfXCBbjPg68YxjiSvly4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744136460; c=relaxed/simple;
	bh=27VtPvNCkeQDrNlDen5FFYM3PGXz6V+n5WZfnqUWnk8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kp4Wg4eOn7pK8xAiDRVF9CAOe8MRxEna8Ag0KvR4f5K+K5V9uWjSVzZRfWA4TE0CBHxs6XVIWIPVfhEgYTnq62zGLo/tOzKSqQJQ9Pk01U+jv329q6vDLne+KU8gpIRiKdMBC33vMWIcdt8RUrAGlVeUD5Rx96e3ubCJpiU7EvQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OpK2DfAk; arc=fail smtp.client-ip=40.107.93.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sW89WDe+s8zcYNsk2bL13jIWMHoYuAYIrCLhkoTUZ4fb2qpYW+R9ZPYHMyvUTCzuW/eDalCosh740U+fZX9z229KQ7FRI5lxX6HKr+rwXRAPDRYQ+BukN77M8Cy5TlwNeLr5K0fbsdi6HEHRhx11Pt5mk4LhB2k6A8clIth6X379D45eU1KXzNbvQeu9UZpQYzRq97BoqSoE/R84ocdXebJua9B022OHw92CMvADsQInFePdbY29ksa6ujUKjCGpc2qJadT55fUvtSWC/IhKzCgw3wx4T0KZMJRV/tZN60FdGG/cA6mSFcSP3Xtw+qSJCbosEt3kQqCpcx30B3diBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Q57uMkc6U049FD9XLMsJV6LbX/l61H9NLmHLU96VmU=;
 b=B27GAxGBbYHhsaKtEYa1kJLdVsGkwAFOijNGATu2qgx+8TsK7tQ9thqUNUSvJHpGYBLEyPPjhuB0KIBsDHgYzTCpmcZtRhPyskVfOoSxmXl3fMxu+pZC3n62KQ9JnisxEw/Ba6mhABWmjpnBSQfBpWGQ796XGJRKvBekhrffaLp0iEwxdKB3eugICiKFlQ4Z8buzAWb22tfZFL+FtN4gtFTaloocEDst9E4KzsOk4tOq5nPNO3OuyE+teNJ7g6EwTSjxWAPgktJgMg8SiDZaJaspOb5omDLQcFtc/woUm/d7ntKuJEQc2DpIE9KS6HS+0rG2a2/BOVSLYIMIT1a7Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Q57uMkc6U049FD9XLMsJV6LbX/l61H9NLmHLU96VmU=;
 b=OpK2DfAkR4+PWzOc0XIOdvubwvq3LasGJ9wCWql0H9MumSEERYXJLnzOxJQk3B/Vy3UVk30+FagLB6fucTRa+wr+2ffIJl4By+SOFltA8QQEkm1YWggMayBZjwtepr8Ofe7YXDRcXKQLzS+/nVUndRjXlu2XOyKr7aqXWNey0WE=
Received: from MW4PR04CA0304.namprd04.prod.outlook.com (2603:10b6:303:82::9)
 by SJ1PR12MB6220.namprd12.prod.outlook.com (2603:10b6:a03:455::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.35; Tue, 8 Apr
 2025 18:20:54 +0000
Received: from MWH0EPF000989EC.namprd02.prod.outlook.com
 (2603:10b6:303:82:cafe::bb) by MW4PR04CA0304.outlook.office365.com
 (2603:10b6:303:82::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.36 via Frontend Transport; Tue,
 8 Apr 2025 18:20:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EC.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.22 via Frontend Transport; Tue, 8 Apr 2025 18:20:53 +0000
Received: from airavat.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 8 Apr
 2025 13:20:49 -0500
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<Shyam-sundar.S-k@amd.com>, Raju Rangoju <Raju.Rangoju@amd.com>
Subject: [PATCH net-next 5/5] amd-xgbe: add support for new pci device id 0x1641
Date: Tue, 8 Apr 2025 23:50:01 +0530
Message-ID: <20250408182001.4072954-6-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250408182001.4072954-1-Raju.Rangoju@amd.com>
References: <20250408182001.4072954-1-Raju.Rangoju@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EC:EE_|SJ1PR12MB6220:EE_
X-MS-Office365-Filtering-Correlation-Id: 00162291-50d3-4cdd-546f-08dd76ca194a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QhBlj8RJWdb4m8ospuWSsnwu3AdiLnAH1uVy9qSzvW+qmhWKkwlg+u3VXVDo?=
 =?us-ascii?Q?Ei0H8FSEVSP0n8qZpCr0qtaJByPSOIwlk25Emosm4xPyJNeCRf8v1LL0ZWWs?=
 =?us-ascii?Q?q8J55eNYtyuF2FBhsc396dnqXj8zTEmuELGD/2uP/DUysubrjPlqc2K15l3f?=
 =?us-ascii?Q?+1hfZvdgpEkbMUQarA1AG/UGo14JMgnvuTAYyGgS3Tqw64wv3TgMaqeX/UFr?=
 =?us-ascii?Q?1hYSV+thH8uFc0PtXSaf53JIGH3dtGMfYAP6bs1XJWMq5TJ091mOH+NyXfzU?=
 =?us-ascii?Q?LVaeKd9zV4pnUQw+Vz0Xf7ARpDFqLwobDhiI7lcNCM26HQw+TIRFliiwVdMc?=
 =?us-ascii?Q?Khd5w6qC8Ox1Zg8FKjtNMctYVvkeSmHKYs7/vhrHVTArtSGC8DQq3szoHKjP?=
 =?us-ascii?Q?nXCkxpvkjf777eVwflfmb01CNHv1uC1aE5vvDxdA+C1xHam8HwLbl0tmtVOU?=
 =?us-ascii?Q?d6ZQ6VpoCC+HrSZ6hO1DmsL+HfE8ELX8CwPtuMJX6TBcMA0X+q+YENmtG6Nb?=
 =?us-ascii?Q?a8Ko2PSgk8t2VIVABysxxmqK8Lq9I2RmKwX1/Qw9UMh1KEVjlpTHD0ecK2Q6?=
 =?us-ascii?Q?nX6mmKASv5ud1+xqUsOdhyQLJdmLuwSzo65dGd3UWK6iR+ZltxE3V8RDUNmR?=
 =?us-ascii?Q?79d8oaNcWQyoxAGvo8eSlpVSfj2nb/G7Mwrb93eUI+1U1gESBQTnla0XxjFy?=
 =?us-ascii?Q?G1u9UforfP7I0WO5WZM7U54uU8odAV/LR63v+u1XP+6RHZB7P7WKVVGfkqZ3?=
 =?us-ascii?Q?o6tckvyieKZRxWjKVgEYB/0uFe3MD+n6dfLC0ZW04rVvVDwA0gvt4FyrLF9p?=
 =?us-ascii?Q?vUapAtTauoEsSlduzkZ8Ycl97KGRNGVM+17Xx4FG+C3n9wgoKJ6+HSNeeBz8?=
 =?us-ascii?Q?U4VKb9RotX5YHnMvjahhjvF3KhGqWxqhM12YsztIxHIM6EDdJDQuWPqMU57z?=
 =?us-ascii?Q?mcniHHAavNFjTl3VTC+SLIST4TZB0ZsPYszXfio2R08vz5waAYiTRU2KDn+c?=
 =?us-ascii?Q?ntjiWU4Zl4w5b1S+tLkSuoRvl/6u6PALrdLZAilCqORN7U5Dr3ZHTzU3NQRy?=
 =?us-ascii?Q?rJT5eRHyym7I14vD/RbyEWbcCI58miwsj7ymfbUBtZll9n7YgiQbchAYhEZ1?=
 =?us-ascii?Q?7UUW5bwtU/T028cKAsh1uCvUy87abdq9wdNrJAhnqmkLRfkjpEweg3h5UC5L?=
 =?us-ascii?Q?XM46R2F19D1Ne9R7zGc6WvVK4EFiFusBMGlffz8LsozWVWJD64J6cczwFYiM?=
 =?us-ascii?Q?2UddidwGL6d443mymHgJSF5oPvkTju3ExBmB+c/3e3bzA0lmOTJFB7ERe4pI?=
 =?us-ascii?Q?2OZO0ycf78L8fcGdQubyq/o+YCKjwOuVK+cTPYl7DboiAkKtnDQARrK56z6F?=
 =?us-ascii?Q?K/zPY0zRSNIVfRrQRWHSniVma0j3HwVcI/wkIDjIP+3wnwUePE5bpRFREUjR?=
 =?us-ascii?Q?eRh0Q4lUKsBnIifGybq67QOf2Na3Qgxb7RhyN/iT3vOQzg/ZNJWKsQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 18:20:53.4845
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 00162291-50d3-4cdd-546f-08dd76ca194a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989EC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6220

Add support for new pci device id 0x1641 to register
Crater device with PCIe.

Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
 drivers/net/ethernet/amd/xgbe/xgbe-pci.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-pci.c b/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
index d692f99aa231..c6662dc1a25d 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
@@ -387,6 +387,22 @@ static int __maybe_unused xgbe_pci_resume(struct device *dev)
 	return ret;
 }
 
+static struct xgbe_version_data xgbe_v3 = {
+	.init_function_ptrs_phy_impl	= xgbe_init_function_ptrs_phy_v2,
+	.xpcs_access			= XGBE_XPCS_ACCESS_V3,
+	.mmc_64bit			= 1,
+	.tx_max_fifo_size		= 65536,
+	.rx_max_fifo_size		= 65536,
+	.tx_tstamp_workaround		= 1,
+	.ecc_support			= 1,
+	.i2c_support			= 1,
+	.irq_reissue_support		= 1,
+	.tx_desc_prefetch		= 5,
+	.rx_desc_prefetch		= 5,
+	.an_cdr_workaround		= 0,
+	.enable_rrc			= 0,
+};
+
 static struct xgbe_version_data xgbe_v2a = {
 	.init_function_ptrs_phy_impl	= xgbe_init_function_ptrs_phy_v2,
 	.xpcs_access			= XGBE_XPCS_ACCESS_V2,
@@ -424,6 +440,8 @@ static const struct pci_device_id xgbe_pci_table[] = {
 	  .driver_data = (kernel_ulong_t)&xgbe_v2a },
 	{ PCI_VDEVICE(AMD, 0x1459),
 	  .driver_data = (kernel_ulong_t)&xgbe_v2b },
+	{ PCI_VDEVICE(AMD, 0x1641),
+	  .driver_data = (kernel_ulong_t)&xgbe_v3 },
 	/* Last entry must be zero */
 	{ 0, }
 };
-- 
2.34.1


