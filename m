Return-Path: <netdev+bounces-150346-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF799E9E97
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 19:59:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6512E1883FDA
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 18:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 289111A01D4;
	Mon,  9 Dec 2024 18:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aUF5F5C9"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2086.outbound.protection.outlook.com [40.107.95.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAF519CC0E;
	Mon,  9 Dec 2024 18:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733770505; cv=fail; b=RNdY6W3qwWbJAxu6/p6DWoZjw3OQnXsc3U2+WkhYsffl/tvC0zB8ew8tVhsW5udiL1TFVx9V4O9HU9jnDDx5xSAPSzD24dGkEaI1CdkIQOhSHb/P97r1Ln/4u7rTAmOzKUlHeqdw2Zg0bWmFFaqU4TGyPKogei61ixo5G93+NS8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733770505; c=relaxed/simple;
	bh=ji3cWJ766K+AG3IFlMGAGD0SQpgUbnReOJI4VaAxNew=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZEEXIe0/dU5VpJ0ZCSmpGZlN5nUzhRVsBYoG7Yd1L93ygkxu+SbZR0X2I7VQD3qPAuVoPD9C4ROua7iymsvYzPduNTN5eclZGP/Nfg71ZBje47fdOHciHdOPaHk32lqFDrrh+5UHnst7DTv28R2uRzOqx2/DIxfIqPvozJDCtCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aUF5F5C9; arc=fail smtp.client-ip=40.107.95.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s4uBiWLT8lUZHYW8/aOfGAC9Ar05o1dLcK0OsKsp4+bUmi8PTrRXrZGkGbMGXHIVnFwjjYKjWHCugm/UFlK/IGCJpqXCfZ30rl/08f6ZFlyZZ3zi2yQwGGb2N13peUDYvS3PUJyVoqWb3xkKh7dHRay4JsK0F8WTySdA5cT+N8JLdBtfMiQkWvRJcRpE9G8z0sTmmfcFMYiQzeixWo0nrXR2loM1XA7SlHYlxdY1Z/UT82OQsqspV/TWel9QvkO6vgrT2Lf2nfy0tW66OS6+oDaLVnyJ9RNDT9EP23I6fEtmYsp4IduXBDQlXwRURIarAUfnyiAGZEMlDTfwWxq5Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ukwWIjOTTDtfTOL7qLdoVwOXOislCPWX7MtE/VkurXg=;
 b=W3bez372n8ID+Z6adhEu8GBiGPocxZlVoAyjnT+RBtyDL1IMNR9Gop6FjyjlpeZ0jQq5nhvA0XrGaFVbkWk9P+4ImkK8wuSVS9dUkeUy1Wloe0mJJLmkY77n/bo1CYmPxgrAmZdmXhqUrGa1//GKVYnI95DgTMV3dqCacRZd1HKNId3XQqABdsgp9nCv9ES5IKgybKgdrQK2LlUijCOS/IJDGKAatJ0WGu5UeXIpWWkshX4rTT9xGszCE/k83EKaAzjR9mzyXRaC3UTa1PznDYr+Dgrq7qs5CZf3noxVWvcExSiJaPMyfNf/eiTLv9lpqQ0tHc5bjgZCCLzuv0SU5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ukwWIjOTTDtfTOL7qLdoVwOXOislCPWX7MtE/VkurXg=;
 b=aUF5F5C9fi6w3OHTWNLNziu3sQah1EYVIEZSLXEjXd/qMI1dBFPhWrorl5YSS6hXxmIjPURAV64pPj0yHFsYc+d+OfOCgca7ouPqSdLd4zX8igOyo+tCpw3JP8CUdw+xOcWvW6gb+xQppJlLqxx2SGaBqyCO/+odKcqG+rge+lA=
Received: from BN9PR03CA0950.namprd03.prod.outlook.com (2603:10b6:408:108::25)
 by PH0PR12MB7888.namprd12.prod.outlook.com (2603:10b6:510:28b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Mon, 9 Dec
 2024 18:55:00 +0000
Received: from BN2PEPF00004FBC.namprd04.prod.outlook.com
 (2603:10b6:408:108:cafe::ea) by BN9PR03CA0950.outlook.office365.com
 (2603:10b6:408:108::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.12 via Frontend Transport; Mon,
 9 Dec 2024 18:54:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF00004FBC.mail.protection.outlook.com (10.167.243.182) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Mon, 9 Dec 2024 18:54:59 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Dec
 2024 12:54:59 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Dec
 2024 12:54:58 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 9 Dec 2024 12:54:57 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v7 14/28] sfc: create type2 cxl memdev
Date: Mon, 9 Dec 2024 18:54:15 +0000
Message-ID: <20241209185429.54054-15-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241209185429.54054-1-alejandro.lucero-palau@amd.com>
References: <20241209185429.54054-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBC:EE_|PH0PR12MB7888:EE_
X-MS-Office365-Filtering-Correlation-Id: df46ffe6-fb49-4dec-82ee-08dd1882fb2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1ktjrNk4/k4AxE7Ifizwz+Dm++SJDdr3UaMv6PeUZ4TKohLGtNez5l0Gu9LD?=
 =?us-ascii?Q?6IAD41fhUBndhTx4cudb6aGt5/+rjdiisP0waatvXDxlAXZFZ+cAR3yS3sX6?=
 =?us-ascii?Q?8MZ0dctlgm4TpdoQor0dX4+XmoKFUxeYpyCgeIZK1UWPKLzwDGNESmX/479Y?=
 =?us-ascii?Q?bk9uR8mlnvGSIeyj4gaqA/hyc6GlhN9YHSrdPTqIOe9y+jw5B+RrOgQLHbaR?=
 =?us-ascii?Q?Su4evXfwlb8nsvsF9mAtUZUSQlT2PgsO5brREpoTpoWWCk44uWAxti6WJV8Z?=
 =?us-ascii?Q?t/7TOHM3pN8E/YmGrGvEPlrPti9/JBHqFvlCzfapHA8ddsmix60dAEPRvU08?=
 =?us-ascii?Q?u7Z4uDPvEc1iZQVnhxtQnujwFckqoIzZL1q33e0pwtEaMdfQetlN3hZ9o7LU?=
 =?us-ascii?Q?QA0EMOhOCMjyASsCWnKtwBwnXCx7ysqtfQK5k2WWXZ4uJRnE9uM5FBUtbmaL?=
 =?us-ascii?Q?2mgrSYkSyO3fJkfrTi4h8Cycz5iIjfh3FR6Yv1bxCMBWu2GW4dX3Uk6Ihdco?=
 =?us-ascii?Q?HbLoQCltltMkaJ/9Y9M0jAxDItw8WuCpbWQda2k9saZAtce9ejVvz3x9clTG?=
 =?us-ascii?Q?7BaxtDHrvtSIZw1EeFaleT4WPDDKeI4uqceX3UItecvZp3OJeP+sns4+czTK?=
 =?us-ascii?Q?IBvkAO2apf1pLerEdzSFM+CpJnyRvX8JRB1uWSBzdstjgRrz4UtDI5Y58Uku?=
 =?us-ascii?Q?LREbn/J2W8+JBsRew8E8Ysn0v0imieBAoC1p3Mj+MujwjLDSe2myVyGjuoJw?=
 =?us-ascii?Q?39nJRBp9PY4CTjQJp5LJ90gssVpzjGW/ZJQyEOTQNHBzw4DlxMVAszFLiwIT?=
 =?us-ascii?Q?y+KS5OkE4da5oktfp9qyy2MLZTkZ+Mb3OWanIA7zqEBnT+5UeN+gcbZi4NqK?=
 =?us-ascii?Q?V2e54HlkML0/+QfM0QFTK6R2pWY7WObweoKG1vzBEwx1EFPaJGqFfYwXP/u6?=
 =?us-ascii?Q?cbef2fi4aDdrn+KkeQzSuL3JkqD51aC1O/i8KP1V04fYtcoSdZWfS0EiC+f2?=
 =?us-ascii?Q?a5SahfHPM9VrTbRdrUjpeJuAMjDu9WZtfaYBtqBoXRVQ3p7hKDCA0Uf26gBb?=
 =?us-ascii?Q?Z/kQTQPXocYTVaIaIgKPpTFffYm+gsaTsWnPV4jM1qpqsGUEsoBHGz5LnOrc?=
 =?us-ascii?Q?TEYrTzul+n8EpM/DL92waESqWcd2DEIsCXyuOyQd3CUm0yEi+rB7u4B/E+kv?=
 =?us-ascii?Q?Ba4k4SGF08R0xFPxxV7b6j7KXXOLKzgxFyGuOwmjNsMkwG0xHPpV7iQynint?=
 =?us-ascii?Q?1ptMv30C2ANsdE2L43jMtMczbxBbBcmL82ICfbC953J9tlE9g4geb+Md98Wf?=
 =?us-ascii?Q?SpRlIE4TTippCJHiYmCR3fpuU7PJYwHkT0hDMepw94QQpQRDoYaqwr3cvHbd?=
 =?us-ascii?Q?vQ/GqZQoFKS3vzJOB9FHA7kZ1Nzrt2IImd13tnwqE4G+1uCNS8dHlHEMC9L8?=
 =?us-ascii?Q?53joCJ/LX94BJ1W14Vd4ud4UcyoAQ9VIER+fW4+k/HC96GtB4JZskg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 18:54:59.4445
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df46ffe6-fb49-4dec-82ee-08dd1882fb2b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7888

From: Alejandro Lucero <alucerop@amd.com>

Use cxl API for creating a cxl memory device using the type2
cxl_dev_state struct.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
---
 drivers/net/ethernet/sfc/efx_cxl.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index bc1f14690b1c..8db5cf5d9ab0 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -95,10 +95,19 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 	 */
 	cxl_set_media_ready(cxl->cxlds);
 
+	cxl->cxlmd = devm_cxl_add_memdev(&pci_dev->dev, cxl->cxlds);
+	if (IS_ERR(cxl->cxlmd)) {
+		pci_err(pci_dev, "CXL accel memdev creation failed");
+		rc = PTR_ERR(cxl->cxlmd);
+		goto err3;
+	}
+
 	probe_data->cxl = cxl;
 
 	return 0;
 
+err3:
+	cxl_release_resource(cxl->cxlds, CXL_RES_RAM);
 err2:
 	kfree(cxl->cxlds);
 err1:
-- 
2.17.1


