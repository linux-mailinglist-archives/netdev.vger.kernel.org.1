Return-Path: <netdev+bounces-163721-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 350BDA2B6EF
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 01:07:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 622881677E5
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 00:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95E3128EB;
	Fri,  7 Feb 2025 00:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jiq/fN0m"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2069.outbound.protection.outlook.com [40.107.94.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A829210F9
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 00:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738886813; cv=fail; b=gF8g/yY2QeGrlh3GBplGSMl5PsXMvPriDC+CMuGoPTfIWAeQMd3fHY7YPHAXcb3kwq0rg/Vgk3bFJAOTvkjLHSy8zhepa5ebODVcMYpwltPAVTid42wKL2+Z8yc5YGFxM0ffwLEzosP9yJIheuva/sGXgiUx4KiC4TFd0/vAneY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738886813; c=relaxed/simple;
	bh=SEyvrpO57SzzQ8VOVnFTBf97m1FZ0E0HkbQnF3zcoJw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pNVZfjK5Xo0jdJtMVsSWSs7LtDxvXGmcsQfIt225sjo2mIsq59oji/dWX6edc/Ei7duvnqQoZB2uNjFFyPWToyp1Q0sbgyBY1NQBparEJa+vaCRk0yQ1F0lbu6/uJEsN90YZaChiTgBr+bgYFdNmnj3SuQDw+46bp6ltO+CDcCY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jiq/fN0m; arc=fail smtp.client-ip=40.107.94.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k5sMlOWuzoCwTHfrnh4wqiHYSl/ImqeucUnV5L4rFVxHjkEDzNf4pyJg9/4v2tCF7yS9VH+xyb0S1aqvvhbjlyp6wqGSCri0CcfWI7HIof9him5jR2j4jz1UwXMbq44vhzsEbIkalTN3aMd101hI00tvda/v4iZ1JDzDOy/3tdR9WAZ3qGmvcmN+kqMebfdffl39Eitn+Ck+O/lnd8zIVfCg+ASz6RDItnnm/Uchzny7tuicf0RE2i925yvr5sJwsWJTthyr3uKsqS1ISsoRHPuC2/0bsWBLKFiIjDwhLCFrhweI4mcPLZwJur1KRn1jIuziN1wbdPT94aovLdE9rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zP8H0302QaIr5g7+b2SawzMqh1P+ltH3t3FtrN1il44=;
 b=uOm09lz1OISge6E8Y1bmkJEiVb4aRMT3BPttEa3bD7GiDvjJXZBLoQ/VZp5lwW6amHtJWfKKD+l56jIrnD/pYn2xfNj3WIFnpMpiGi0GHE4BuPeXCfY3THlFCz44A0/FQk4AgzVNTPgU6005QMlVbZd2YMI3DvsZ6HoeYssjL4InrVtAsuec9gDiRRpEaZmlbSpfBmkZBKHTPu2dPic0hz8RtnZHVBrUISsiW73soG1kOD8AGNHIO295HoWp8vJ0ipZ/hKhqpyhe+m1jYQnCH+1QrKZz+DhobMMsxzO2agjNxcUJNXhymK4QH1XxLBx2BRkhSGca/we+MWIAujzbAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zP8H0302QaIr5g7+b2SawzMqh1P+ltH3t3FtrN1il44=;
 b=jiq/fN0mhSrUxvg627IBEWuYODTGdsB2Rl2VPIxxTNh7TmXap6E+RhgwjBKRzIZHad4/2lGdX3nAbVn8bwtBx8tVqZNFJ9BlQcQyeToF9aGiAiH15F937dq9orgMlGkusWbext+7wkA2Mkb8O5GgcuP0Jq2CmsZGOHJkEU3xRvY=
Received: from MW4PR04CA0169.namprd04.prod.outlook.com (2603:10b6:303:85::24)
 by DS7PR12MB5813.namprd12.prod.outlook.com (2603:10b6:8:75::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Fri, 7 Feb
 2025 00:06:49 +0000
Received: from SJ1PEPF00002312.namprd03.prod.outlook.com
 (2603:10b6:303:85:cafe::ea) by MW4PR04CA0169.outlook.office365.com
 (2603:10b6:303:85::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.21 via Frontend Transport; Fri,
 7 Feb 2025 00:06:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF00002312.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Fri, 7 Feb 2025 00:06:48 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 6 Feb
 2025 18:06:47 -0600
Received: from xcbecree42x.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Thu, 6 Feb 2025 18:06:45 -0600
From: <edward.cree@amd.com>
To: <linux-net-drivers@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>, <horms@kernel.org>,
	<andrew+netdev@lunn.ch>
CC: Edward Cree <ecree.xilinx@gmail.com>, <habetsm.xilinx@gmail.com>,
	<jiri@resnulli.us>, <netdev@vger.kernel.org>
Subject: [PATCH net-next 3/4] sfc: deploy devlink flash images to NIC over MCDI
Date: Fri, 7 Feb 2025 00:06:03 +0000
Message-ID: <77b9f119c7939c12de18cbe1cfcebd82239e4bef.1738881614.git.ecree.xilinx@gmail.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002312:EE_|DS7PR12MB5813:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b36afec-59c3-4f1d-3349-08dd470b50e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LQXyuOGj36el6hsGqBEgoIUKqXlyCl8LoVGpzk1HHidUtAddsP1Dxg/N45Am?=
 =?us-ascii?Q?k6w1R87D2rIG6lVCiHba0BCfyJqeghWh/4g6ZtQGy07KdTUMFkGfGiVK9d95?=
 =?us-ascii?Q?fOoJOe9dJuNca035k+rNVzTIbrQkak8KQS2dmJ+sFPS/B3KrHmrlOgR9A5n3?=
 =?us-ascii?Q?Lb+l7Q8n/x0kT9C0XQ2JPf57nQ/SJDmVliQ6GrHVHKt1kYidW3UQ16FY5EOy?=
 =?us-ascii?Q?1Z8qUKeVWewK3GVn69Q3Y4Ptd91uUNL/0ppWarEVV0wiRezKrcexa7aFGf9P?=
 =?us-ascii?Q?RGG8bJqk2b5EUVlz/cQQFJT9MwD6XdPtgZV0wgcdvXF7ffr9dY6MSd6E6Ktv?=
 =?us-ascii?Q?MwzThafuRIz6t/S8wIUcxS5YUOhs8ABsIPgnonMqwpgOXbTnmFmQIsJnEg6Q?=
 =?us-ascii?Q?OEQnHI3ThFV/z1lSYG6oXfP7mmiHBsa3af6jssJfxWI6WbGkjerIuRZyA3pv?=
 =?us-ascii?Q?WHVG+LSCOk4G7LipPyuCreh+3W5UWBVsUyFizO8vgY4KH6xl1e+gJWE4lnKu?=
 =?us-ascii?Q?2ey/r9dSHKB6Iy/5BjAOeDRpdVTLeZ7tI5EZ+zFLCti2EiiQorDAFQOy14K8?=
 =?us-ascii?Q?pStQ+a5GvvY32k6XzlDyf9fgvFE+YzWKOkMoOOF1Yo8O1WJCI86YBrZ2OGxB?=
 =?us-ascii?Q?bAl74N0IZC0D2bXisM0IqK1XavrsdFDH8/F1tLnhGmN5QCLWNQZLLHaA4zeV?=
 =?us-ascii?Q?VGljg8tvGdSdJAJcmXhGAbD3iy+8U5ae06mveMmPAiNnTxFc0ClTbQQXxISx?=
 =?us-ascii?Q?+u8PrjK+N1uJ/9coiD69QhTo2XHijnFs2rTjInsfUnekBKFtMLNczbIDPMdt?=
 =?us-ascii?Q?AnyxcLdpk2GfoUjPMbf2DprQcDXDOH8Tdjq6gcmxoiWo6TGd4K3P4KTymOVO?=
 =?us-ascii?Q?tXrSw3L3hnxTTzPEWXJq9ScanjfWZKO50TIjMFYJrRnBwZgs1FTKcSxy5F/3?=
 =?us-ascii?Q?1X2Aziak+NiLG7K3ASteho4ZeXjFD0rTLZfzNwOSJ474meX10JE5T+IQHkUB?=
 =?us-ascii?Q?aX0BdBQlN8Xfg5bf1EdkVnwTTn8qYR9mzPY6cZqruFjPCGBY1434kcb6m/4h?=
 =?us-ascii?Q?qIyIx7yat+onUJDG0VmWaO3yMeS/PjB5uD2yWqLwQJrGX53ho1L4UG6lb241?=
 =?us-ascii?Q?B4CrSNcfe/xNUdhm3DPXxx9ka/4qgO6CIlZ97eJyC7xu2o9u99ft+Sc5jL42?=
 =?us-ascii?Q?24WQum8Xa5cdfDvDBgYCvcuJb+/WIUx+Lr/CJbQsp1BLX0pbaSRdB+N/VQw0?=
 =?us-ascii?Q?89B3hE6Zkgw8UVXux0yGW5Tu4RVdvCvT8B8asJv+PfGlaFX9qybjCM2bu1uL?=
 =?us-ascii?Q?h1GZuTYBOcA7EvwnHSIr4Ik1CSoyhcfh1cq2Hq8wGpqAB9UQ47CJY/fhjOVx?=
 =?us-ascii?Q?wRqcCidPHC0X3ruCAOkUTlymnAFb0nSjaHj2za3eEQPUiBxEbCRrXqyacE/Q?=
 =?us-ascii?Q?CNoNWsT0gAxt+CIvx9U0oNeatZy2RATOy6KbgtGG9XPq9WGa0YUVNk5rg80J?=
 =?us-ascii?Q?4tYUFiRfbNlL8A8=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 00:06:48.1998
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b36afec-59c3-4f1d-3349-08dd470b50e0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002312.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5813

From: Edward Cree <ecree.xilinx@gmail.com>

Use MC_CMD_NVRAM_* wrappers to write the firmware to the partition
 identified from the image header.

Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
---
 drivers/net/ethernet/sfc/efx_common.c  |   1 +
 drivers/net/ethernet/sfc/efx_reflash.c | 231 ++++++++++++++++++++++++-
 drivers/net/ethernet/sfc/net_driver.h  |   2 +
 3 files changed, 231 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/sfc/efx_common.c b/drivers/net/ethernet/sfc/efx_common.c
index c88ec3e24836..5a14d94163b1 100644
--- a/drivers/net/ethernet/sfc/efx_common.c
+++ b/drivers/net/ethernet/sfc/efx_common.c
@@ -1003,6 +1003,7 @@ int efx_init_struct(struct efx_nic *efx, struct pci_dev *pci_dev)
 	INIT_LIST_HEAD(&efx->vf_reps);
 	INIT_WORK(&efx->mac_work, efx_mac_work);
 	init_waitqueue_head(&efx->flush_wq);
+	mutex_init(&efx->reflash_mutex);
 
 	efx->tx_queues_per_channel = 1;
 	efx->rxq_entries = EFX_DEFAULT_DMAQ_SIZE;
diff --git a/drivers/net/ethernet/sfc/efx_reflash.c b/drivers/net/ethernet/sfc/efx_reflash.c
index 9a8d8211e18b..ddc53740f098 100644
--- a/drivers/net/ethernet/sfc/efx_reflash.c
+++ b/drivers/net/ethernet/sfc/efx_reflash.c
@@ -255,13 +255,151 @@ static int efx_reflash_parse_firmware_data(const struct firmware *fw,
 	return -EINVAL;
 }
 
+/* Limit the number of status updates during the erase or write phases */
+#define EFX_DEVLINK_STATUS_UPDATE_COUNT		50
+
+/* Expected timeout for the efx_mcdi_nvram_update_finish_polled() */
+#define EFX_DEVLINK_UPDATE_FINISH_TIMEOUT	900
+
+/* Ideal erase chunk size.  This is a balance between minimising the number of
+ * MCDI requests to erase an entire partition whilst avoiding tripping the MCDI
+ * RPC timeout.
+ */
+#define EFX_NVRAM_ERASE_IDEAL_CHUNK_SIZE	(64 * 1024)
+
+static int efx_reflash_erase_partition(struct efx_nic *efx,
+				       struct netlink_ext_ack *extack,
+				       struct devlink *devlink, u32 type,
+				       size_t partition_size,
+				       size_t align)
+{
+	size_t chunk, offset, next_update;
+	int rc;
+
+	/* Partitions that cannot be erased or do not require erase before
+	 * write are advertised with a erase alignment/sector size of zero.
+	 */
+	if (align == 0)
+		/* Nothing to do */
+		return 0;
+
+	if (partition_size % align)
+		return -EINVAL;
+
+	/* Erase the entire NVRAM partition a chunk at a time to avoid
+	 * potentially tripping the MCDI RPC timeout.
+	 */
+	if (align >= EFX_NVRAM_ERASE_IDEAL_CHUNK_SIZE)
+		chunk = align;
+	else
+		chunk = rounddown(EFX_NVRAM_ERASE_IDEAL_CHUNK_SIZE, align);
+
+	for (offset = 0, next_update = 0; offset < partition_size; offset += chunk) {
+		if (offset >= next_update) {
+			devlink_flash_update_status_notify(devlink, "Erasing",
+							   NULL, offset,
+							   partition_size);
+			next_update += partition_size / EFX_DEVLINK_STATUS_UPDATE_COUNT;
+		}
+
+		chunk = min_t(size_t, partition_size - offset, chunk);
+		rc = efx_mcdi_nvram_erase(efx, type, offset, chunk);
+		if (rc) {
+			NL_SET_ERR_MSG_FMT_MOD(extack,
+					       "Erase failed for NVRAM partition %#x at %#zx-%#zx",
+					       type, offset, offset + chunk - 1);
+			return rc;
+		}
+	}
+
+	devlink_flash_update_status_notify(devlink, "Erasing", NULL,
+					   partition_size, partition_size);
+
+	return 0;
+}
+
+static int efx_reflash_write_partition(struct efx_nic *efx,
+				       struct netlink_ext_ack *extack,
+				       struct devlink *devlink, u32 type,
+				       const u8 *data, size_t data_size,
+				       size_t align)
+{
+	size_t write_max, chunk, offset, next_update;
+	int rc;
+
+	if (align == 0)
+		return -EINVAL;
+
+	/* Write the NVRAM partition in chunks that are the largest multiple
+	 * of the partition's required write alignment that will fit into the
+	 * MCDI NVRAM_WRITE RPC payload.
+	 */
+	if (efx->type->mcdi_max_ver < 2)
+		write_max = MC_CMD_NVRAM_WRITE_IN_WRITE_BUFFER_LEN *
+			    MC_CMD_NVRAM_WRITE_IN_WRITE_BUFFER_MAXNUM;
+	else
+		write_max = MC_CMD_NVRAM_WRITE_IN_WRITE_BUFFER_LEN *
+			    MC_CMD_NVRAM_WRITE_IN_WRITE_BUFFER_MAXNUM_MCDI2;
+	chunk = rounddown(write_max, align);
+
+	for (offset = 0, next_update = 0; offset + chunk <= data_size; offset += chunk) {
+		if (offset >= next_update) {
+			devlink_flash_update_status_notify(devlink, "Writing",
+							   NULL, offset,
+							   data_size);
+			next_update += data_size / EFX_DEVLINK_STATUS_UPDATE_COUNT;
+		}
+
+		rc = efx_mcdi_nvram_write(efx, type, offset, data + offset, chunk);
+		if (rc) {
+			NL_SET_ERR_MSG_FMT_MOD(extack,
+					       "Write failed for NVRAM partition %#x at %#zx-%#zx",
+					       type, offset, offset + chunk - 1);
+			return rc;
+		}
+	}
+
+	/* Round up left over data to satisfy write alignment */
+	if (offset < data_size) {
+		size_t remaining = data_size - offset;
+		u8 *buf;
+
+		if (offset >= next_update)
+			devlink_flash_update_status_notify(devlink, "Writing",
+							   NULL, offset,
+							   data_size);
+
+		chunk = roundup(remaining, align);
+		buf = kmalloc(chunk, GFP_KERNEL);
+		if (!buf)
+			return -ENOMEM;
+
+		memcpy(buf, data + offset, remaining);
+		memset(buf + remaining, 0xFF, chunk - remaining);
+		rc = efx_mcdi_nvram_write(efx, type, offset, buf, chunk);
+		kfree(buf);
+		if (rc) {
+			NL_SET_ERR_MSG_FMT_MOD(extack,
+					       "Write failed for NVRAM partition %#x at %#zx-%#zx",
+					       type, offset, offset + chunk - 1);
+			return rc;
+		}
+	}
+
+	devlink_flash_update_status_notify(devlink, "Writing", NULL, data_size,
+					   data_size);
+
+	return 0;
+}
+
 int efx_reflash_flash_firmware(struct efx_nic *efx, const struct firmware *fw,
 			       struct netlink_ext_ack *extack)
 {
+	size_t data_size, size, erase_align, write_align;
 	struct devlink *devlink = efx->devlink;
-	u32 type, data_subtype;
-	size_t data_size;
+	u32 type, data_subtype, subtype;
 	const u8 *data;
+	bool protected;
 	int rc;
 
 	if (!efx_has_cap(efx, BUNDLE_UPDATE)) {
@@ -279,8 +417,95 @@ int efx_reflash_flash_firmware(struct efx_nic *efx, const struct firmware *fw,
 		goto out;
 	}
 
-	rc = -EOPNOTSUPP;
+	mutex_lock(&efx->reflash_mutex);
+
+	rc = efx_mcdi_nvram_metadata(efx, type, &subtype, NULL, NULL, 0);
+	if (rc) {
+		NL_SET_ERR_MSG_FMT_MOD(extack,
+				       "Metadata query for NVRAM partition %#x failed",
+				       type);
+		goto out_unlock;
+	}
+
+	if (subtype != data_subtype) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Firmware image is not appropriate for this adapter");
+		rc = -EINVAL;
+		goto out_unlock;
+	}
+
+	rc = efx_mcdi_nvram_info(efx, type, &size, &erase_align, &write_align,
+				 &protected);
+	if (rc) {
+		NL_SET_ERR_MSG_FMT_MOD(extack,
+				       "Info query for NVRAM partition %#x failed",
+				       type);
+		goto out_unlock;
+	}
+
+	if (protected) {
+		NL_SET_ERR_MSG_FMT_MOD(extack,
+				       "NVRAM partition %#x is protected",
+				       type);
+		rc = -EPERM;
+		goto out_unlock;
+	}
+
+	if (write_align == 0) {
+		NL_SET_ERR_MSG_FMT_MOD(extack,
+				       "NVRAM partition %#x is not writable",
+				       type);
+		rc = -EACCES;
+		goto out_unlock;
+	}
+
+	if (erase_align != 0 && size % erase_align) {
+		NL_SET_ERR_MSG_FMT_MOD(extack,
+				       "NVRAM partition %#x has a bad partition table entry, can't erase it",
+				       type);
+		rc = -EACCES;
+		goto out_unlock;
+	}
+
+	if (data_size > size) {
+		NL_SET_ERR_MSG_FMT_MOD(extack,
+				       "Firmware image is too big for NVRAM partition %#x",
+				       type);
+		rc = -EFBIG;
+		goto out_unlock;
+	}
+
+	devlink_flash_update_status_notify(devlink, "Starting update", NULL, 0, 0);
+
+	rc = efx_mcdi_nvram_update_start(efx, type);
+	if (rc) {
+		NL_SET_ERR_MSG_FMT_MOD(extack,
+				       "Update start request for NVRAM partition %#x failed",
+				       type);
+		goto out_unlock;
+	}
 
+	rc = efx_reflash_erase_partition(efx, extack, devlink, type, size,
+					 erase_align);
+	if (rc)
+		goto out_update_finish;
+
+	rc = efx_reflash_write_partition(efx, extack, devlink, type, data,
+					 data_size, write_align);
+	if (rc)
+		goto out_update_finish;
+
+	devlink_flash_update_timeout_notify(devlink, "Finishing update", NULL,
+					    EFX_DEVLINK_UPDATE_FINISH_TIMEOUT);
+
+out_update_finish:
+	if (rc)
+		/* Don't obscure the return code from an earlier failure */
+		efx_mcdi_nvram_update_finish(efx, type, EFX_UPDATE_FINISH_ABORT);
+	else
+		rc = efx_mcdi_nvram_update_finish_polled(efx, type);
+out_unlock:
+	mutex_unlock(&efx->reflash_mutex);
 out:
 	devlink_flash_update_status_notify(devlink, rc ? "Update failed" :
 							 "Update complete",
diff --git a/drivers/net/ethernet/sfc/net_driver.h b/drivers/net/ethernet/sfc/net_driver.h
index f70a7b7d6345..8b0689f749b5 100644
--- a/drivers/net/ethernet/sfc/net_driver.h
+++ b/drivers/net/ethernet/sfc/net_driver.h
@@ -1006,6 +1006,7 @@ struct efx_mae;
  * @dl_port: devlink port associated with the PF
  * @mem_bar: The BAR that is mapped into membase.
  * @reg_base: Offset from the start of the bar to the function control window.
+ * @reflash_mutex: Mutex for serialising firmware reflash operations.
  * @monitor_work: Hardware monitor workitem
  * @biu_lock: BIU (bus interface unit) lock
  * @last_irq_cpu: Last CPU to handle a possible test interrupt.  This
@@ -1191,6 +1192,7 @@ struct efx_nic {
 	struct devlink_port *dl_port;
 	unsigned int mem_bar;
 	u32 reg_base;
+	struct mutex reflash_mutex;
 
 	/* The following fields may be written more often */
 

