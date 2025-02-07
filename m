Return-Path: <netdev+bounces-163720-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EEDDA2B6EE
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 01:07:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEA34167779
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 00:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 652F82417F9;
	Fri,  7 Feb 2025 00:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Uqi+k21F"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613D510F1
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 00:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738886813; cv=fail; b=hg4bxVLqI9P2aVl3p/rSa5L/qBqeBmr1y/k7YBO5p7sH34igiXZy9dQ56ZEPDEa++NOVFPB0pTe3r+LR4gvWUbzrMuFSCNV+Qg0WAHNK6WzoEmG3xy7wF1g8rJz/B/4p9JnjyIZ4NiAYLRlKqggA2jsae+1iZrxHReLfuaVlBA4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738886813; c=relaxed/simple;
	bh=sL3AbW5JQhXlBnwx+Uty7K2OS4zFcBQGAxrM9+cH1ck=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mNit27eOwMIK6xIV0YnfS177QM4J6ccWXMMMfLjvZYj4vh4MvzJHHm/VqhWYkVI8rxQcyVrezKFOmIPlfZDvxFX+9Qh1Iuma9acQRNe7Z1sjeiFV4+9Kfrfq3h9ONEVDlvSpzLlqfgJ+F8D4eiaMxBT4YdrS46sDFEXC2v8GwCk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Uqi+k21F; arc=fail smtp.client-ip=40.107.243.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NzqD6nQi1EfSZoUCmyL1x6vfjC+5OGpiQ1bTftZnle+fzXyK+KYubmFQjBFdH/TwZh90dKz7oyy1on1a/FvntBwpuWxPcT/uDGp+kml/pwCleU6MR6kz09uOYVZGtMWd8URuJ/Gqz59F6um+R+xBj3TFKit+6kEayYutDoaYR3y0LAufeDXjWlER5XauSe7qzoGO/3TLhHUJ7PQJv3gNoUvqo7SSOepVgj1z7D6piTMoNomsZd4O4PYLlYpkUgVNDjTh8qgoDGjKGO1CF7OzFpK09u26o7PevfbJ1Q+vuT9Cf7nW94XrlTzsbo/y4rAnz42ADP0Lb2FrfOnszHxSHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jORApRVEh+foc5CQ72mBtpKId824jRhFiBiQ0KQ8QRw=;
 b=Ftm1X68WpqIPzAv70a0PxWQudVX8DoBzwm5K9AmDJ9I8nc9yfuk6qHuZQUDkk6XrV83yZF6aeszSDPb1blPYkF0QvO2rcUfi38lh/hW/jJeK8Y7oqCT1AnjGTsRY4A234pZyctEyVl10gql6HZSf0R4svegsmetHvJymyerT0dpqJvraI07maWzPQ6uO/PfOBZR8kC3Avb7AcxbihnP7sSgPys8hmuDuzuHvw4fg3dtTEo5jmHn7PajQwDHfLTpVi2V/vtnrUOzeVgzogEcZ6fVMntLV+J8D9dpMbRYWCnAir1tw9GOMg2fewwPQrOe8Y9vrun2lzLbmb3S8Gqu12Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jORApRVEh+foc5CQ72mBtpKId824jRhFiBiQ0KQ8QRw=;
 b=Uqi+k21FqFm+7FcFLDscCJ1X0hFSIcJBUfrQasmUIWJ4Obe4wkiOKjPf1m6MVzvk6Nec9/HPoA8A+1T+f5xL0IoG1C8ZNhUdp4ZOFtHu/u4FGmk4fR/GepxM0veWAS7DGZ5mn+jvIM4mr2maMiQ3P+SAY/p4X2wzphMVUBsr3C8=
Received: from SJ0PR13CA0059.namprd13.prod.outlook.com (2603:10b6:a03:2c2::34)
 by CY8PR12MB7540.namprd12.prod.outlook.com (2603:10b6:930:97::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Fri, 7 Feb
 2025 00:06:46 +0000
Received: from SJ1PEPF00002310.namprd03.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::e5) by SJ0PR13CA0059.outlook.office365.com
 (2603:10b6:a03:2c2::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.6 via Frontend Transport; Fri, 7
 Feb 2025 00:06:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF00002310.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Fri, 7 Feb 2025 00:06:46 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 6 Feb
 2025 18:06:45 -0600
Received: from xcbecree42x.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Thu, 6 Feb 2025 18:06:44 -0600
From: <edward.cree@amd.com>
To: <linux-net-drivers@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>, <horms@kernel.org>,
	<andrew+netdev@lunn.ch>
CC: Edward Cree <ecree.xilinx@gmail.com>, <habetsm.xilinx@gmail.com>,
	<jiri@resnulli.us>, <netdev@vger.kernel.org>
Subject: [PATCH net-next 2/4] sfc: extend NVRAM MCDI handlers
Date: Fri, 7 Feb 2025 00:06:02 +0000
Message-ID: <6ad7f4af17c2566ddc53fd247a0d0a790eff02ae.1738881614.git.ecree.xilinx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1738881614.git.ecree.xilinx@gmail.com>
References: <cover.1738881614.git.ecree.xilinx@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: edward.cree@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002310:EE_|CY8PR12MB7540:EE_
X-MS-Office365-Filtering-Correlation-Id: f894c844-909a-404e-04d3-08dd470b4fe7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/3yGyJU45mpMsvmuZpUsRO9HA4RGEa23F0vVEqPXk2VF5VcvXRJKst9F9uAt?=
 =?us-ascii?Q?DrInynYHUQ+OU7OGXvnPAnPJunfk49eGmWj1ZXlfJ2IpIYdQg4dbWEQfPedo?=
 =?us-ascii?Q?BmU1RkgjgokswAGZtW6HCsjRd7UIF++35dacILz6fCoztje/GyGpXXKD1E0x?=
 =?us-ascii?Q?YHZhjubgujd6D0IMj7KMVwWoEG0tAQoL8hZRabPqNJepAhSZ1JKoG/2JHWFe?=
 =?us-ascii?Q?yln+oUqDvsiFgeMgxM/Qg6lXo+XFSXI+B6XNnGJ3D6j6l4VDeS/eojZDFjbf?=
 =?us-ascii?Q?zlhJ9BujLTSbgO0IFq/Fr+QruZMPk9zT1GbAi9iwyuD7+C+eoq1bFe0Vhu8N?=
 =?us-ascii?Q?EhRXAbkd776O0KKDWtxClAHRFPhHwAnCwuJG0u+MLv3cCLFGwd3l7U3SSqVx?=
 =?us-ascii?Q?WrqB7iGPl5UpCfuHQfOJCaPRvEinFNwZhpBRn+J9EremMtTSrG1+N+rYQrzU?=
 =?us-ascii?Q?/+/OzCPgBBE1RWOsqvdU0Xq8eVfHjyC26IO467R/+ifWvF2P3DRbAe/iwW6a?=
 =?us-ascii?Q?SOcyG/1ri2ciZeG6eJd0tnHuCcexdeSrYqW6/J3rh7kJNoAEh+1dwPwof+0t?=
 =?us-ascii?Q?PE8uKgXgt0xwxKZUHkQzUqR4HbjpYKnPEU5wLZl42QUgxBOmNX0tyUx2rMGr?=
 =?us-ascii?Q?kzaTZVJXK6x57SIBsiWf3m/kRe967UthgC0yiQ2qLNzx+x0t/UxsQU/uKxWz?=
 =?us-ascii?Q?IFMsLaXuBYM5Y9c3t+JW65SyJtnDsfp39RvL5hGafBqKuM2mrSmf1IKwtX2a?=
 =?us-ascii?Q?YriZSvEpCo7DYDZpSrONoMGN8Nff+YvMhBUyjJyv4xkqiKqbsFceUhHUcuNq?=
 =?us-ascii?Q?mjJubkuzpcWvsIMxAyzty+aSFVQ1NPdwC8fgZRWMQXe0wKD0+wqLWr0NuvN2?=
 =?us-ascii?Q?egamNtHmEa0vpuAe0GkmHUdr8urep1rBT+I0ZyTU6U8YaBE0nbTvpz66C/AY?=
 =?us-ascii?Q?vkcSeHGHvKf2NAMPoVhlcIFh0Aq7TSooPVZTSeJHjrqyUa4wqum/kRztWFmJ?=
 =?us-ascii?Q?9VYf9Xfg1K5qmWhAHWJvgyU5IL+TJrGdz9Swsybxn98Vn3U9nOgryV3WhvQm?=
 =?us-ascii?Q?wzFadPRzHJTC4qKwdGC93yolHBZfZB3sA4nkyGwxsFIW7ae/DTbYajl+g75y?=
 =?us-ascii?Q?NTSy6TeGebmGuXbbs00iIO89wz8ildNvX9lv2VrbhKcy3wjh8riKfK0IO2+o?=
 =?us-ascii?Q?NV5BtjzXjXw3nQuS1E5QCqIntnRuY8OLmkUdhp4SHicPLJZTQYvM2dJhVjSp?=
 =?us-ascii?Q?d38GKmx33FO1oTsUy9iS4gF85G0QYoDQv95l84g9iLj+09RS4eNLpZtjPCF/?=
 =?us-ascii?Q?llGcYNWlxco73i3iYiUTcbgrNzeoF63CrRjhZDDBeVDkuHGQ5CKBA7Fr875j?=
 =?us-ascii?Q?sMMY7QTQgcLRmhHTPxPB2b3FG+8VIlyP9VMoR8TxVCsmf9VHLwpbNBNS7sB+?=
 =?us-ascii?Q?/cn1rSrGMgYHlHfiEFeBTj8NljkEBNNCIek8T9xDlsRFeSHZX+BGjpYgE1yb?=
 =?us-ascii?Q?7rFZstg7zDdO4oE=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 00:06:46.5668
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f894c844-909a-404e-04d3-08dd470b4fe7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002310.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7540

From: Edward Cree <ecree.xilinx@gmail.com>

Support variable write-alignment, and background updates.  The latter
 allows other MCDI to continue while the device is processing an
 MC_CMD_NVRAM_UPDATE_FINISH, since this can take a long time owing to
 e.g. cryptographic signature verification.
Expose these handlers in mcdi.h, and build them even when
 CONFIG_SFC_MTD=n, so they can be used for devlink flash in a
 subsequent patch.

Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
---
 drivers/net/ethernet/sfc/ef10.c |   7 +-
 drivers/net/ethernet/sfc/mcdi.c | 111 ++++++++++++++++++++++++++------
 drivers/net/ethernet/sfc/mcdi.h |  22 ++++++-
 3 files changed, 117 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/sfc/ef10.c b/drivers/net/ethernet/sfc/ef10.c
index 452009ed7a43..47d78abecf30 100644
--- a/drivers/net/ethernet/sfc/ef10.c
+++ b/drivers/net/ethernet/sfc/ef10.c
@@ -3501,7 +3501,7 @@ static int efx_ef10_mtd_probe_partition(struct efx_nic *efx,
 	MCDI_DECLARE_BUF(inbuf, MC_CMD_NVRAM_METADATA_IN_LEN);
 	MCDI_DECLARE_BUF(outbuf, MC_CMD_NVRAM_METADATA_OUT_LENMAX);
 	const struct efx_ef10_nvram_type_info *info;
-	size_t size, erase_size, outlen;
+	size_t size, erase_size, write_size, outlen;
 	int type_idx = 0;
 	bool protected;
 	int rc;
@@ -3516,7 +3516,8 @@ static int efx_ef10_mtd_probe_partition(struct efx_nic *efx,
 	if (info->port != efx_port_num(efx))
 		return -ENODEV;
 
-	rc = efx_mcdi_nvram_info(efx, type, &size, &erase_size, &protected);
+	rc = efx_mcdi_nvram_info(efx, type, &size, &erase_size, &write_size,
+				 &protected);
 	if (rc)
 		return rc;
 	if (protected &&
@@ -3561,6 +3562,8 @@ static int efx_ef10_mtd_probe_partition(struct efx_nic *efx,
 	if (!erase_size)
 		part->common.mtd.flags |= MTD_NO_ERASE;
 
+	part->common.mtd.writesize = write_size;
+
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/sfc/mcdi.c b/drivers/net/ethernet/sfc/mcdi.c
index d461b1a6ce81..b047765811dd 100644
--- a/drivers/net/ethernet/sfc/mcdi.c
+++ b/drivers/net/ethernet/sfc/mcdi.c
@@ -1625,12 +1625,15 @@ static int efx_new_mcdi_nvram_types(struct efx_nic *efx, u32 *number,
 	return rc;
 }
 
+#define EFX_MCDI_NVRAM_DEFAULT_WRITE_LEN 128
+
 int efx_mcdi_nvram_info(struct efx_nic *efx, unsigned int type,
 			size_t *size_out, size_t *erase_size_out,
-			bool *protected_out)
+			size_t *write_size_out, bool *protected_out)
 {
 	MCDI_DECLARE_BUF(inbuf, MC_CMD_NVRAM_INFO_IN_LEN);
-	MCDI_DECLARE_BUF(outbuf, MC_CMD_NVRAM_INFO_OUT_LEN);
+	MCDI_DECLARE_BUF(outbuf, MC_CMD_NVRAM_INFO_V2_OUT_LEN);
+	size_t write_size = 0;
 	size_t outlen;
 	int rc;
 
@@ -1645,6 +1648,12 @@ int efx_mcdi_nvram_info(struct efx_nic *efx, unsigned int type,
 		goto fail;
 	}
 
+	if (outlen >= MC_CMD_NVRAM_INFO_V2_OUT_LEN)
+		write_size = MCDI_DWORD(outbuf, NVRAM_INFO_V2_OUT_WRITESIZE);
+	else
+		write_size = EFX_MCDI_NVRAM_DEFAULT_WRITE_LEN;
+
+	*write_size_out = write_size;
 	*size_out = MCDI_DWORD(outbuf, NVRAM_INFO_OUT_SIZE);
 	*erase_size_out = MCDI_DWORD(outbuf, NVRAM_INFO_OUT_ERASESIZE);
 	*protected_out = !!(MCDI_DWORD(outbuf, NVRAM_INFO_OUT_FLAGS) &
@@ -2163,11 +2172,9 @@ int efx_mcdi_nvram_metadata(struct efx_nic *efx, unsigned int type,
 	return rc;
 }
 
-#ifdef CONFIG_SFC_MTD
-
 #define EFX_MCDI_NVRAM_LEN_MAX 128
 
-static int efx_mcdi_nvram_update_start(struct efx_nic *efx, unsigned int type)
+int efx_mcdi_nvram_update_start(struct efx_nic *efx, unsigned int type)
 {
 	MCDI_DECLARE_BUF(inbuf, MC_CMD_NVRAM_UPDATE_START_V2_IN_LEN);
 	int rc;
@@ -2209,13 +2216,18 @@ static int efx_mcdi_nvram_read(struct efx_nic *efx, unsigned int type,
 	return 0;
 }
 
-static int efx_mcdi_nvram_write(struct efx_nic *efx, unsigned int type,
-				loff_t offset, const u8 *buffer, size_t length)
+int efx_mcdi_nvram_write(struct efx_nic *efx, unsigned int type,
+			 loff_t offset, const u8 *buffer, size_t length)
 {
-	MCDI_DECLARE_BUF(inbuf,
-			 MC_CMD_NVRAM_WRITE_IN_LEN(EFX_MCDI_NVRAM_LEN_MAX));
+	efx_dword_t *inbuf;
+	size_t inlen;
 	int rc;
 
+	inlen = ALIGN(MC_CMD_NVRAM_WRITE_IN_LEN(length), 4);
+	inbuf = kzalloc(inlen, GFP_KERNEL);
+	if (!inbuf)
+		return -ENOMEM;
+
 	MCDI_SET_DWORD(inbuf, NVRAM_WRITE_IN_TYPE, type);
 	MCDI_SET_DWORD(inbuf, NVRAM_WRITE_IN_OFFSET, offset);
 	MCDI_SET_DWORD(inbuf, NVRAM_WRITE_IN_LENGTH, length);
@@ -2223,14 +2235,14 @@ static int efx_mcdi_nvram_write(struct efx_nic *efx, unsigned int type,
 
 	BUILD_BUG_ON(MC_CMD_NVRAM_WRITE_OUT_LEN != 0);
 
-	rc = efx_mcdi_rpc(efx, MC_CMD_NVRAM_WRITE, inbuf,
-			  ALIGN(MC_CMD_NVRAM_WRITE_IN_LEN(length), 4),
-			  NULL, 0, NULL);
+	rc = efx_mcdi_rpc(efx, MC_CMD_NVRAM_WRITE, inbuf, inlen, NULL, 0, NULL);
+	kfree(inbuf);
+
 	return rc;
 }
 
-static int efx_mcdi_nvram_erase(struct efx_nic *efx, unsigned int type,
-				loff_t offset, size_t length)
+int efx_mcdi_nvram_erase(struct efx_nic *efx, unsigned int type, loff_t offset,
+			 size_t length)
 {
 	MCDI_DECLARE_BUF(inbuf, MC_CMD_NVRAM_ERASE_IN_LEN);
 	int rc;
@@ -2246,7 +2258,8 @@ static int efx_mcdi_nvram_erase(struct efx_nic *efx, unsigned int type,
 	return rc;
 }
 
-static int efx_mcdi_nvram_update_finish(struct efx_nic *efx, unsigned int type)
+int efx_mcdi_nvram_update_finish(struct efx_nic *efx, unsigned int type,
+				 enum efx_update_finish_mode mode)
 {
 	MCDI_DECLARE_BUF(inbuf, MC_CMD_NVRAM_UPDATE_FINISH_V2_IN_LEN);
 	MCDI_DECLARE_BUF(outbuf, MC_CMD_NVRAM_UPDATE_FINISH_V2_OUT_LEN);
@@ -2254,22 +2267,41 @@ static int efx_mcdi_nvram_update_finish(struct efx_nic *efx, unsigned int type)
 	int rc, rc2;
 
 	MCDI_SET_DWORD(inbuf, NVRAM_UPDATE_FINISH_IN_TYPE, type);
-	/* Always set this flag. Old firmware ignores it */
-	MCDI_POPULATE_DWORD_1(inbuf, NVRAM_UPDATE_FINISH_V2_IN_FLAGS,
+
+	/* Old firmware doesn't support background update finish and abort
+	 * operations. Fallback to waiting if the requested mode is not
+	 * supported.
+	 */
+	if (!efx_has_cap(efx, NVRAM_UPDATE_POLL_VERIFY_RESULT) ||
+	    (!efx_has_cap(efx, NVRAM_UPDATE_ABORT_SUPPORTED) &&
+	     mode == EFX_UPDATE_FINISH_ABORT))
+		mode = EFX_UPDATE_FINISH_WAIT;
+
+	MCDI_POPULATE_DWORD_4(inbuf, NVRAM_UPDATE_FINISH_V2_IN_FLAGS,
 			      NVRAM_UPDATE_FINISH_V2_IN_FLAG_REPORT_VERIFY_RESULT,
-			      1);
+			      (mode != EFX_UPDATE_FINISH_ABORT),
+			      NVRAM_UPDATE_FINISH_V2_IN_FLAG_RUN_IN_BACKGROUND,
+			      (mode == EFX_UPDATE_FINISH_BACKGROUND),
+			      NVRAM_UPDATE_FINISH_V2_IN_FLAG_POLL_VERIFY_RESULT,
+			      (mode == EFX_UPDATE_FINISH_POLL),
+			      NVRAM_UPDATE_FINISH_V2_IN_FLAG_ABORT,
+			      (mode == EFX_UPDATE_FINISH_ABORT));
 
 	rc = efx_mcdi_rpc(efx, MC_CMD_NVRAM_UPDATE_FINISH, inbuf, sizeof(inbuf),
 			  outbuf, sizeof(outbuf), &outlen);
 	if (!rc && outlen >= MC_CMD_NVRAM_UPDATE_FINISH_V2_OUT_LEN) {
 		rc2 = MCDI_DWORD(outbuf, NVRAM_UPDATE_FINISH_V2_OUT_RESULT_CODE);
-		if (rc2 != MC_CMD_NVRAM_VERIFY_RC_SUCCESS)
+		if (rc2 != MC_CMD_NVRAM_VERIFY_RC_SUCCESS &&
+		    rc2 != MC_CMD_NVRAM_VERIFY_RC_PENDING)
 			netif_err(efx, drv, efx->net_dev,
 				  "NVRAM update failed verification with code 0x%x\n",
 				  rc2);
 		switch (rc2) {
 		case MC_CMD_NVRAM_VERIFY_RC_SUCCESS:
 			break;
+		case MC_CMD_NVRAM_VERIFY_RC_PENDING:
+			rc = -EAGAIN;
+			break;
 		case MC_CMD_NVRAM_VERIFY_RC_CMS_CHECK_FAILED:
 		case MC_CMD_NVRAM_VERIFY_RC_MESSAGE_DIGEST_CHECK_FAILED:
 		case MC_CMD_NVRAM_VERIFY_RC_SIGNATURE_CHECK_FAILED:
@@ -2284,6 +2316,8 @@ static int efx_mcdi_nvram_update_finish(struct efx_nic *efx, unsigned int type)
 		case MC_CMD_NVRAM_VERIFY_RC_NO_VALID_SIGNATURES:
 		case MC_CMD_NVRAM_VERIFY_RC_NO_TRUSTED_APPROVERS:
 		case MC_CMD_NVRAM_VERIFY_RC_NO_SIGNATURE_MATCH:
+		case MC_CMD_NVRAM_VERIFY_RC_REJECT_TEST_SIGNED:
+		case MC_CMD_NVRAM_VERIFY_RC_SECURITY_LEVEL_DOWNGRADE:
 			rc = -EPERM;
 			break;
 		default:
@@ -2296,6 +2330,42 @@ static int efx_mcdi_nvram_update_finish(struct efx_nic *efx, unsigned int type)
 	return rc;
 }
 
+#define	EFX_MCDI_NVRAM_UPDATE_FINISH_INITIAL_POLL_DELAY_MS 5
+#define	EFX_MCDI_NVRAM_UPDATE_FINISH_MAX_POLL_DELAY_MS 5000
+#define	EFX_MCDI_NVRAM_UPDATE_FINISH_RETRIES 185
+
+int efx_mcdi_nvram_update_finish_polled(struct efx_nic *efx, unsigned int type)
+{
+	unsigned int delay = EFX_MCDI_NVRAM_UPDATE_FINISH_INITIAL_POLL_DELAY_MS;
+	unsigned int retry = 0;
+	int rc;
+
+	/* NVRAM updates can take a long time (e.g. up to 1 minute for bundle
+	 * images). Polling for NVRAM update completion ensures that other MCDI
+	 * commands can be issued before the background NVRAM update completes.
+	 *
+	 * The initial call either completes the update synchronously, or
+	 * returns -EAGAIN to indicate processing is continuing. In the latter
+	 * case, we poll for at least 900 seconds, at increasing intervals
+	 * (5ms, 50ms, 500ms, 5s).
+	 */
+	rc = efx_mcdi_nvram_update_finish(efx, type, EFX_UPDATE_FINISH_BACKGROUND);
+	while (rc == -EAGAIN) {
+		if (retry > EFX_MCDI_NVRAM_UPDATE_FINISH_RETRIES)
+			return -ETIMEDOUT;
+		retry++;
+
+		msleep(delay);
+		if (delay < EFX_MCDI_NVRAM_UPDATE_FINISH_MAX_POLL_DELAY_MS)
+			delay *= 10;
+
+		rc = efx_mcdi_nvram_update_finish(efx, type, EFX_UPDATE_FINISH_POLL);
+	}
+	return rc;
+}
+
+#ifdef CONFIG_SFC_MTD
+
 int efx_mcdi_mtd_read(struct mtd_info *mtd, loff_t start,
 		      size_t len, size_t *retlen, u8 *buffer)
 {
@@ -2389,7 +2459,8 @@ int efx_mcdi_mtd_sync(struct mtd_info *mtd)
 
 	if (part->updating) {
 		part->updating = false;
-		rc = efx_mcdi_nvram_update_finish(efx, part->nvram_type);
+		rc = efx_mcdi_nvram_update_finish(efx, part->nvram_type,
+						  EFX_UPDATE_FINISH_WAIT);
 	}
 
 	return rc;
diff --git a/drivers/net/ethernet/sfc/mcdi.h b/drivers/net/ethernet/sfc/mcdi.h
index cdb17d7c147f..3755cd3fe1e6 100644
--- a/drivers/net/ethernet/sfc/mcdi.h
+++ b/drivers/net/ethernet/sfc/mcdi.h
@@ -392,7 +392,7 @@ int efx_mcdi_log_ctrl(struct efx_nic *efx, bool evq, bool uart, u32 dest_evq);
 int efx_mcdi_nvram_types(struct efx_nic *efx, u32 *nvram_types_out);
 int efx_mcdi_nvram_info(struct efx_nic *efx, unsigned int type,
 			size_t *size_out, size_t *erase_size_out,
-			bool *protected_out);
+			size_t *write_size_out, bool *protected_out);
 int efx_new_mcdi_nvram_test_all(struct efx_nic *efx);
 int efx_mcdi_nvram_metadata(struct efx_nic *efx, unsigned int type,
 			    u32 *subtype, u16 version[4], char *desc,
@@ -424,6 +424,26 @@ static inline int efx_mcdi_mon_probe(struct efx_nic *efx) { return 0; }
 static inline void efx_mcdi_mon_remove(struct efx_nic *efx) {}
 #endif
 
+int efx_mcdi_nvram_update_start(struct efx_nic *efx, unsigned int type);
+int efx_mcdi_nvram_write(struct efx_nic *efx, unsigned int type,
+			 loff_t offset, const u8 *buffer, size_t length);
+int efx_mcdi_nvram_erase(struct efx_nic *efx, unsigned int type,
+			 loff_t offset, size_t length);
+int efx_mcdi_nvram_metadata(struct efx_nic *efx, unsigned int type,
+			    u32 *subtype, u16 version[4], char *desc,
+			    size_t descsize);
+
+enum efx_update_finish_mode {
+	EFX_UPDATE_FINISH_WAIT,
+	EFX_UPDATE_FINISH_BACKGROUND,
+	EFX_UPDATE_FINISH_POLL,
+	EFX_UPDATE_FINISH_ABORT,
+};
+
+int efx_mcdi_nvram_update_finish(struct efx_nic *efx, unsigned int type,
+				 enum efx_update_finish_mode mode);
+int efx_mcdi_nvram_update_finish_polled(struct efx_nic *efx, unsigned int type);
+
 #ifdef CONFIG_SFC_MTD
 int efx_mcdi_mtd_read(struct mtd_info *mtd, loff_t start, size_t len,
 		      size_t *retlen, u8 *buffer);

