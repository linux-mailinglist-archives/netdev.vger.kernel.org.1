Return-Path: <netdev+bounces-148170-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3907E9E0990
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 18:14:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 425E516275E
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 17:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F2C1DE2DE;
	Mon,  2 Dec 2024 17:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NAdi8fhw"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2084.outbound.protection.outlook.com [40.107.243.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148DF1DBB0C;
	Mon,  2 Dec 2024 17:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733159578; cv=fail; b=LSOV3YGhm7Dmmiijtr9fQr2fljulq3P07n/1dQ55nj3KVci/mEw/azNf6KG9mlDv9KGHoV+arz7uv3AzeLjtSJ6dqcV7KuT8vPGTljNv+EY9vnkqxoT49J6d8eNETnF9NGxRB5S/YO1lOUUeewROpYqZwO8l8lhjqJXbwkMCVz8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733159578; c=relaxed/simple;
	bh=GqUasVhqe0/jdsC4/0n/awOsmLRqTmUZf/7uDQmqwyI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dhwLbCRpOXPAZ16s9TB0sgcyKjdnV4Wb4KqkAqjOdbzgb1LoefZHvtT3Q89nFpVt2FaB3M4r2tWPpf3MY5yJffROa1c9kUoik7a4GT6PngtsmG8kPY96xXlUQsrv6Zcwgjm5sPKO9CjMoEHzCRY32gdXrtblISVdmJ8f6uHGKBY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NAdi8fhw; arc=fail smtp.client-ip=40.107.243.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZfuejAWZ7URx5f2sZHZS0ebIdoyjf0SQ65tND9sZ3s58GrzGvuCPdoaffcMC6HFKoTX3SIOfFTsfeL2n/zTY6EarQ9sxZx9eZ0zI5JWC+BLb2WB8MBcozzoZJ7AwDh2U75+A8sIxC5822fAPSUujEz7In+ygBLD0eNdnnNTmhIpAwxFMFHSLDBVdOdXPmVGjDUwXofc22cjtIBv+SdvFRwVbX6vggC8lP/82o/ecx+mOtIknHBPR9DXG4SGduifXsd4zJort6XcRzLXIad6Gn7QMOfaZwR0XXal1dXRRivHBhlE1wbXZAj++vae91eDzTaF/P8nmdH8xZiGv4GsAUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BMJ8SdtubSFAX4GA/G+X1qm897YmAC1L5ybGcHpXWlU=;
 b=R5dBNSvINdhZjP2U9qqHthXFcbBQ0aSfKx4MK5H9K5GXp4gySiF8k6ILvD1KkDODDXElX387Qhzq/ZC3p3CFjt+m3953etwQBHR1T/9XBfjsEoXLQlo0HTFpYk3sy3YSs1es8tglC7gHxV7g9DhRMbeNrel2c0NzzNjOlgsMsSr/QS/9h3nmgYt2v2ITQtpiWfoCV121guGRzWH5GHTged137XQE3ui9oIy1imDh/Wh3veimtjFzfrXd5xed8pzqbS7pT+u4EwQ80YilY+3YGgI1Ft1S8AyQ8XqyyfYYxtVJBDgl9RkVhIckk/TBep4mHGbt36k7Ng7OgqwZL3kCKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BMJ8SdtubSFAX4GA/G+X1qm897YmAC1L5ybGcHpXWlU=;
 b=NAdi8fhw42LHut0zfTXZ24vGaKvHF1BgSahFK1Xqua9PvbUm/2AnYsoZWzCB+VgsVXy5foSg9CQgZCjyKUzMtkztZaz/vjmfRrx2bNXU99b/11NUuVNe21/2iynKJm6I5XU5R5Am0U/Yy97KOyb2K9MPZESxw0pCSKaeyPqB6Dw=
Received: from BN8PR07CA0005.namprd07.prod.outlook.com (2603:10b6:408:ac::18)
 by CY5PR12MB6274.namprd12.prod.outlook.com (2603:10b6:930:21::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Mon, 2 Dec
 2024 17:12:48 +0000
Received: from BN2PEPF000044A9.namprd04.prod.outlook.com
 (2603:10b6:408:ac:cafe::31) by BN8PR07CA0005.outlook.office365.com
 (2603:10b6:408:ac::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.15 via Frontend Transport; Mon,
 2 Dec 2024 17:12:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF000044A9.mail.protection.outlook.com (10.167.243.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Mon, 2 Dec 2024 17:12:47 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 2 Dec
 2024 11:12:46 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 2 Dec
 2024 11:12:45 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 2 Dec 2024 11:12:44 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v6 09/28] sfc: request cxl ram resource
Date: Mon, 2 Dec 2024 17:12:03 +0000
Message-ID: <20241202171222.62595-10-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241202171222.62595-1-alejandro.lucero-palau@amd.com>
References: <20241202171222.62595-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A9:EE_|CY5PR12MB6274:EE_
X-MS-Office365-Filtering-Correlation-Id: b2d61886-880c-4c09-776d-08dd12f48ba6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?k4N2evL7NalPwdswBH74aWKchVhLwa3F+DB3Wh7Cjkd78DgQdFfnlQL6Nbxi?=
 =?us-ascii?Q?Kcm3QUKbjcluMkAXjlCEsWTJp0TYwJwDo7Tk+H1kKhsKSGQod/rVlW3lOTfE?=
 =?us-ascii?Q?1effs9fdC8GhXiFqE6OoUS/stgmiL09fdjDwOexmbsVmceq1y/NLUrL4rnYy?=
 =?us-ascii?Q?fEf5eh4XYafc2IHU2gnRGVXORubd4tOXH20vas06a9+GzeIuw7r0ABzm+WLf?=
 =?us-ascii?Q?JFt041vxq+0ekB3XMiiK2+fn9LTx4NBqJKrJ9WVD+MrFXal+Ip+evkaeyaKi?=
 =?us-ascii?Q?aPtqDW7aPKKcMfJdVLCOFYJdo8V/grWCwW/+vVnIYMuZP5zNkJLBtFNHyN4T?=
 =?us-ascii?Q?yS70ssjEouWBLVzQTjMpeANhPNOmzj7kxqVZ8Dxj0pSOF2qB04uWLX9YQDq7?=
 =?us-ascii?Q?vGSRW/eyf4TgiliXjdvb9VcV/15UYJ6medhFjHJjUDkPNJSwEmeXyW9NcOFr?=
 =?us-ascii?Q?oYIBamv3aOmeNPKrhVcNsNrxZ+f3gIDqClQp/ztBqwe97oZ1OCULxpujsbKO?=
 =?us-ascii?Q?GgAhocum5uqj0eFRQUCUPoAhK+wxcInXJGz4lstT7NFr4dbvgFtD9TqUc+wH?=
 =?us-ascii?Q?0CsEdmKz0q1BasEhM7HLANFCUZ7VPjy1e7khEfg9F0LzreHC6cNtT3dbJWvJ?=
 =?us-ascii?Q?awtY1MHX48WUOysZL/Rgtrl8U5DgQkRiQMuoeVcBn+h+5QvDZEQh8zZ5TFid?=
 =?us-ascii?Q?5WBixLwJ3sje9nT77OswM/tzAZ4UE5XpoL3E8s0rxRpp2TRG3MPndPVqHY5D?=
 =?us-ascii?Q?4CUcDrjUnLztB5womtKAKMH7KMOGmeM1pug7HkluFLoU3UKzjO6Aj9aqfplS?=
 =?us-ascii?Q?CNsXkrCPFJyIw4ItOyaNFhSY3WDQhj/gBYGlcGQXsSFroruqaEHyEvLt3Axb?=
 =?us-ascii?Q?CXOLoJhCO2gxHXc7dzxnb+OpgvqQ7rOtF4cz9sYBpg185wUr80WqWK4dYDZd?=
 =?us-ascii?Q?pUL5AQpcJaw13gOUMsl63f/hq9EygOhyj2ZkqCM10Y5qj1+OTVaS6c7+9iFh?=
 =?us-ascii?Q?+SnKVf6Z2iGtUEmjB+0gP6tEKuBQb3l/IiKM/LDK1dUz0lRHNhP5WRLCzb5+?=
 =?us-ascii?Q?ZiBqTL2J+2mT8bgND8z4Qgq9MJy+MxqrZmgwcnuoN7B3gOQslupxqxPjipuq?=
 =?us-ascii?Q?nr+e+B0Px9eyVagJE6lOlnuwAq0o5/bEx7Eob/eD8+GWwnQ/G/P0/PoWH7Gf?=
 =?us-ascii?Q?7yqnBVGN5F10/GXt0q1fsqQb5b8eKzwIcekVnEnUUQS3UvXhRp8niQGK/qmD?=
 =?us-ascii?Q?oElcw9TCbt3NqANGVHPI2I84XOt8p9FyNUmLuPYgiH3KZCth98roXE9CowuA?=
 =?us-ascii?Q?rn8GEfeJIWrDNJavwTUME+pqu5vLDQA7nLAFG5Lg8vwYUfuFnuj6uc9WHyRg?=
 =?us-ascii?Q?DWXyPLDswg9bopQKH3ONSsH/B08p9ZzyFzq2YRwzQy9jkm5hu7FzQYf7glCb?=
 =?us-ascii?Q?IUARBDEHraEDwspFqfblZKwMYzJVx7rR4u9JMhnEPmI0H8F/mawMNg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 17:12:47.9334
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2d61886-880c-4c09-776d-08dd12f48ba6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6274

From: Alejandro Lucero <alucerop@amd.com>

Use cxl accessor for obtaining the ram resource the device advertises.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/net/ethernet/sfc/efx_cxl.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index 44e1061feba1..76ce4c2e587b 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -84,6 +84,12 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 		goto err2;
 	}
 
+	rc = cxl_request_resource(cxl->cxlds, CXL_RES_RAM);
+	if (rc) {
+		pci_err(pci_dev, "CXL request resource failed");
+		goto err2;
+	}
+
 	probe_data->cxl = cxl;
 
 	return 0;
@@ -98,6 +104,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 void efx_cxl_exit(struct efx_probe_data *probe_data)
 {
 	if (probe_data->cxl) {
+		cxl_release_resource(probe_data->cxl->cxlds, CXL_RES_RAM);
 		kfree(probe_data->cxl->cxlds);
 		kfree(probe_data->cxl);
 	}
-- 
2.17.1


