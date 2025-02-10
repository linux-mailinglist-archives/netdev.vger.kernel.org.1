Return-Path: <netdev+bounces-164687-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 883D6A2EB0B
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 12:27:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F59118864DB
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 11:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7D261E0DD8;
	Mon, 10 Feb 2025 11:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lXWF0wu7"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24AB1DF98B
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 11:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739186843; cv=fail; b=YPH5/KMKH6+UZgriIfXBw2iWeyyhmBYnv/x8fMAqWP+CAX+0JpJ/B87+lmUmbbL2nwGDu+69vFcrn8j+kfirNiG0dWz9vQYZFW4QTHkGPpziPxfVadcPVomdvbjmVs5ZH/6+r3UtcinKGFj9jmhQsBOsd2txTAhX4Pvs66ri/cI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739186843; c=relaxed/simple;
	bh=0JISrvIxM/0beebrdZsdzuOpCepI1eRfl5glsoCfeMQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OcJdjatbE2OWTY+76zUwycGY1DwEuVkVxdL6omAoJoao8WqGTigZBzSoReD+skBI7Eum8oOJXmm10TJLdAEGyw62v9K0HVDq6QdvpxDvFWSHYdkBsIaK+rKM/flkYbaC7RlicTUqjZ3h4ePrMoU/ZbOfNYLbXrrzCmeVuA12L4w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lXWF0wu7; arc=fail smtp.client-ip=40.107.94.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bp8YhlCKi5hkCUCJswkokORFhONcLJA0e8ZxSUevz089oblqId5fNFxzbRuGKkRUnTdI+1s9+c0WHrUyDx8pf7PjQFcnzJDhzm3GA4cR6MvGetBBUE6x/9PjN4a9e6gWeihqK3NqowGyIWKehuA7DevFwX4DLCzibh1EZwZTTulkOqJtk8VBaNZVveZdG4wgyzG1SCmiOlO4GMM4UJKi8Ut57I6bJQHVgr2+1dBWpYYGYdsfUIadAXoSzIS+Zi1LjLGT9JcAg7fQyShMY4FI6DaXqWlTevcbQuBTe328NUagSjx4W0AyVmtaYeB/xJ35ASFzt1BBs2qSAhTqjaNW7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pArcr3orpsoDmoUr8YoNsJw7h6C+Cgv/Ot9QI2AVorE=;
 b=vEgUE9oTYiLsbr0u1g9uRcvRHnR45JVF1XgFcaKff2xVTvnA9KSeGzCKQ60KKkThAg+WyUGIlAQUv+wbsN24H+UqFGUUHVAf+ffrxHWhvNhLYMYRWHF5i8z+Z9wRUegytF0UAVjuCesCz2uOT1+HW3QH9/wM+S0W+ul8OBhXNamEcKYPNq8j/QuJYJRs15db84pxwPpq8nJGdW0TwjaXMAsM5xJV//ggQvIHVmwK/lbJoWh4jiIN0MbPz2MZCMY8SCJhnhvSlaBUzeOCrgMSAf8XPhk+DRjtFzvPWu2KoEpo5nk5eLW5NaBBjkZh0MiWh/LENEy/aB715LjXH/9NrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pArcr3orpsoDmoUr8YoNsJw7h6C+Cgv/Ot9QI2AVorE=;
 b=lXWF0wu7V2iwPFGgjkow0Ba3/9IHMKHGXf8awieDlYB3HPmTenXShIFZhIWwFfgG4lLvoCiuVOFyN29pl5aauYmGe/ztYuwv8jXa1ygFlNH0CQbmhNN0ilRt2IYrDKMRnSVLSM/DEWn4p4wdpl/BzRBkdQPyWUJ0faZlLUBnXdA=
Received: from SJ0PR13CA0186.namprd13.prod.outlook.com (2603:10b6:a03:2c3::11)
 by DS0PR12MB6536.namprd12.prod.outlook.com (2603:10b6:8:d3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.16; Mon, 10 Feb
 2025 11:27:17 +0000
Received: from SJ1PEPF00002314.namprd03.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::ca) by SJ0PR13CA0186.outlook.office365.com
 (2603:10b6:a03:2c3::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.10 via Frontend Transport; Mon,
 10 Feb 2025 11:27:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002314.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Mon, 10 Feb 2025 11:27:16 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Feb
 2025 05:27:13 -0600
Received: from xcbecree42x.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Mon, 10 Feb 2025 05:27:12 -0600
From: <edward.cree@amd.com>
To: <linux-net-drivers@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>, <horms@kernel.org>,
	<andrew+netdev@lunn.ch>
CC: Edward Cree <ecree.xilinx@gmail.com>, <habetsm.xilinx@gmail.com>,
	<jiri@resnulli.us>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 2/4] sfc: extend NVRAM MCDI handlers
Date: Mon, 10 Feb 2025 11:25:43 +0000
Message-ID: <de3d9e14fee69e15d95b46258401a93b75659f78.1739186253.git.ecree.xilinx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1739186252.git.ecree.xilinx@gmail.com>
References: <cover.1739186252.git.ecree.xilinx@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: edward.cree@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002314:EE_|DS0PR12MB6536:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ffd5486-687e-425f-5033-08dd49c5dfa5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?taoTRIsMKxISqgtyQcUkD5/TvnCYMpftGFBgod1RKkKzV0khr9RlJ1DT2xby?=
 =?us-ascii?Q?03CttrxUjiWO3A4e7jkKPeuwqaRojXg0rt5I0znX7mbjufR2aBWdoEeC70Gf?=
 =?us-ascii?Q?qoT+fv/UFzU0qF2XGDsSzdxNs7DMonm6CtfhrMhBnp7zjHCwO/QiGfiRFJdV?=
 =?us-ascii?Q?t++8U1ANrQMsSEsXdPDPxfSN3IfG++TscLV4kN5zrXCF/o2CgShVPa3w67mD?=
 =?us-ascii?Q?eNLoISUo8MN6NjJyOIs3aICe2YvUzOTqlcWv5UHl9fE0+/rk3xm/iilgc8oG?=
 =?us-ascii?Q?m/xN0u6yQouWnKVN4kN6d1497VE+e4IX10WxP/Jk2mdc5cai2gRqK/BRoWA6?=
 =?us-ascii?Q?BeIwx8TkaOth1nIWEEC3Vm/2ck0vJzJGBctMP25sgwA4nly8ARKQvCgYueIo?=
 =?us-ascii?Q?yactMsrrnwMtwrKiXvW1NXdNciyvN7C8WMMcrMl8ZWsanr8Y6RkcsbOdajGM?=
 =?us-ascii?Q?KjBC7h2/xkUPJ1la+M4reYHXMc2uQRbi+MWquYtgq6mYIHUX7wLgc2xIOQyW?=
 =?us-ascii?Q?4de0+weznAgf+pvqlNr2uv2FHK3qkAXY+l4t5ZFuY25pbQsebbH+fuETG2Rv?=
 =?us-ascii?Q?R/CAkeINfNznm7O1pKUsPiBO2rsAG45roAOf5KmrOBYMy2jsIylzKytmdejd?=
 =?us-ascii?Q?aMWFvDHtmDAepHAjvMzfvOl1bf1gC3jR1uf5YZhZvaUZJKmNpii4WO5tNn0r?=
 =?us-ascii?Q?NILimw4rnageZ707HxpNcErgEasHe2SVvy7bagFwrB0UVNLq9mJPievo5/d3?=
 =?us-ascii?Q?aOtCqSeWlq7HU4PPxl2nSeYdPnjuVMbQBUamO8G4dAZmN5MH7uh20DD0rIEP?=
 =?us-ascii?Q?XT69wtQHTsheuzosrUscEl0Kg2zJs1lSkLPlPcApcRxG23GVluh9a7uaoKUq?=
 =?us-ascii?Q?C4vVxvWmqYJMmrAuL1s+Jnvq2uELMiAoYfyW8i9Cs35ysp5+LkwuI6mdkAQL?=
 =?us-ascii?Q?MYau8ZkrLsz3nSPuigRqPBvCTKkFDfgeBmhoGJ8fqVy0pEsXoinAb4pR+vi1?=
 =?us-ascii?Q?Sd95afuNso5Shw9KwDsYr5dKSLdyKmOlWd31N1w/I+CvQoIpzrff+njC2eJS?=
 =?us-ascii?Q?Sw4JEAtCRtCNIH6GfRQ2RpQMcnNTG75JGniJL5ywTFWu9912sPe7j8Lnn/WU?=
 =?us-ascii?Q?n9N+EC88nnv+4O1ZVrpPubyQxCVU4M/mrzd0AnJlpG3o6BuaLg5pCokIYNIW?=
 =?us-ascii?Q?NbUXk5xXrMOfjEmta5egyjtY4wYAjG8GPDJUP1QHiPC40Ddg5C38ZHmiKsbr?=
 =?us-ascii?Q?4+3K9cD6y4lfIoBhzw5K0+0zBBGjLJECl+wfZGvJvfgAelX/jvbPigpM4REc?=
 =?us-ascii?Q?Mb16KMjFq+7RKNxt+G4rrST4sQkkly3/cZhzydEGs0hVQa3NIsRMpeGHIWq8?=
 =?us-ascii?Q?kjWQ5E/Truk3p6JxwO5xu11EqPM1KhBNO7XdUZHWoSGSA3RWpg1IwQzYmyft?=
 =?us-ascii?Q?SDWzssLAcVu78vhydwgYWN6LMeUlXT3XBZMrICkbcAfmNu5uEyQsu4ZHBmJ8?=
 =?us-ascii?Q?HlJFziJPYJa8WEE=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 11:27:16.4454
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ffd5486-687e-425f-5033-08dd49c5dfa5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002314.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6536

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
 drivers/net/ethernet/sfc/mcdi.c | 115 ++++++++++++++++++++++++++------
 drivers/net/ethernet/sfc/mcdi.h |  22 +++++-
 3 files changed, 121 insertions(+), 23 deletions(-)

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
index d461b1a6ce81..dbd2ee915838 100644
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
@@ -2185,6 +2192,8 @@ static int efx_mcdi_nvram_update_start(struct efx_nic *efx, unsigned int type)
 	return rc;
 }
 
+#ifdef CONFIG_SFC_MTD
+
 static int efx_mcdi_nvram_read(struct efx_nic *efx, unsigned int type,
 			       loff_t offset, u8 *buffer, size_t length)
 {
@@ -2209,13 +2218,20 @@ static int efx_mcdi_nvram_read(struct efx_nic *efx, unsigned int type,
 	return 0;
 }
 
-static int efx_mcdi_nvram_write(struct efx_nic *efx, unsigned int type,
-				loff_t offset, const u8 *buffer, size_t length)
+#endif /* CONFIG_SFC_MTD */
+
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
@@ -2223,14 +2239,14 @@ static int efx_mcdi_nvram_write(struct efx_nic *efx, unsigned int type,
 
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
@@ -2246,7 +2262,8 @@ static int efx_mcdi_nvram_erase(struct efx_nic *efx, unsigned int type,
 	return rc;
 }
 
-static int efx_mcdi_nvram_update_finish(struct efx_nic *efx, unsigned int type)
+int efx_mcdi_nvram_update_finish(struct efx_nic *efx, unsigned int type,
+				 enum efx_update_finish_mode mode)
 {
 	MCDI_DECLARE_BUF(inbuf, MC_CMD_NVRAM_UPDATE_FINISH_V2_IN_LEN);
 	MCDI_DECLARE_BUF(outbuf, MC_CMD_NVRAM_UPDATE_FINISH_V2_OUT_LEN);
@@ -2254,22 +2271,41 @@ static int efx_mcdi_nvram_update_finish(struct efx_nic *efx, unsigned int type)
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
@@ -2284,6 +2320,8 @@ static int efx_mcdi_nvram_update_finish(struct efx_nic *efx, unsigned int type)
 		case MC_CMD_NVRAM_VERIFY_RC_NO_VALID_SIGNATURES:
 		case MC_CMD_NVRAM_VERIFY_RC_NO_TRUSTED_APPROVERS:
 		case MC_CMD_NVRAM_VERIFY_RC_NO_SIGNATURE_MATCH:
+		case MC_CMD_NVRAM_VERIFY_RC_REJECT_TEST_SIGNED:
+		case MC_CMD_NVRAM_VERIFY_RC_SECURITY_LEVEL_DOWNGRADE:
 			rc = -EPERM;
 			break;
 		default:
@@ -2296,6 +2334,42 @@ static int efx_mcdi_nvram_update_finish(struct efx_nic *efx, unsigned int type)
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
@@ -2389,7 +2463,8 @@ int efx_mcdi_mtd_sync(struct mtd_info *mtd)
 
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

