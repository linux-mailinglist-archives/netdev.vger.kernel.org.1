Return-Path: <netdev+bounces-164688-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C34C9A2EB0C
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 12:27:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 992803A1DB0
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 11:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66AF01E25FA;
	Mon, 10 Feb 2025 11:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sJ36CiDy"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA21288A2
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 11:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739186844; cv=fail; b=C83UezGrxhCYsktNi9pPdx03ydzoSeJwnYkG+etONqWHjrWnkfwDAu2HohTZvK/pH7DZyC8dtvLJRf1AslreKSxvFieQrzTruDdAuco8OEGNY5MAutXTLpPK4XXQCqjcaD0pGfQKG7E5oL0su+ef50I13HkQ438Pujsrsbl9SYA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739186844; c=relaxed/simple;
	bh=SEyvrpO57SzzQ8VOVnFTBf97m1FZ0E0HkbQnF3zcoJw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kgQXIJ9igACxxGWFAQs3u/og6fidPDRSusAWD+AYm9PDj4SCtAmCUrv7aa7KT/R/3iiEr7jrchh54HiqH+Xb64GoioD3WRNM8qwpkLN0tMC+fOlvs/7bU6gX0GzMB9a2CSYgtRJ1fp+BMbmodpGOPWdkUSWCxW6FufB8zS1Rpec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sJ36CiDy; arc=fail smtp.client-ip=40.107.243.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NzCJX37pBbGoUGiNyxKS9TRBhK+AcztREr1iCxK+cGV6Ox/zfrZecsRaQUQ0C3JF5txyHbKeqgv5hqihWQxQYBd/cQAdvCNogj3XsYQ1nebGMTX5lis0CeE9SiFMDe6m1r/4OBPoYNRpf1UET9pfsn5VY6mW0yFKw+B1bKLLRYOeDmPcs1v2E1rwldgPQXJk663HHAvUiOtb7LeGF5pW8p/TWUunnGby8Z1SXEq5WSHGUMlBEJgoEoxXulWo/534TadCNddSL25wjE55SYzJTzc+MuEySIK8Rxn1KZeZx0dttnxOVsPARyQSvIM70Cgukwj8pTTV3N7TXCzKrDPDlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zP8H0302QaIr5g7+b2SawzMqh1P+ltH3t3FtrN1il44=;
 b=Z04vI3i5Gws/iLWyzLRaEvfcoiv9rIYYBNFH1FBe6LzDnsRg+s+pcDTRx+n/K0302fUhoy/swiZgfdGe1teAXI9SEc34gMGcE6+PrJP4wyPPVKhdg2zvMGxo/eUp3kkCu8/gD/H2KAKCj8dRVV6hdwTHhwcVLZwE+8XQ9HMUVCAiqMEDpQQfUdL/XmGDIRGyDGQ23Pcif7+XdHPqTURapP9MUt3Oyrs4E3a2IA3Dwt8sALNETPxjSJ9p59XeOv37o1myMFQUaXlEm/mS8dX79+NFDzIVPX4sZtCbT65aS78AKeIfa4ExZvY353YDFGWFffHDUgnRJO/h6QJsIZoApQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zP8H0302QaIr5g7+b2SawzMqh1P+ltH3t3FtrN1il44=;
 b=sJ36CiDyKlRNq/GDVDRd/Hd4MmxBLIV3odZxcna11pJyT+zmUdKHAkPZaqZnqlTskAzkCXa2cvFzRC/BGwnr1e1WOicVmJ07yux4k/N5GzPac9ADtuRdOP6ZXIB5JcGF9G9ZaWYwzOEJNUeRXvwHvvcYLpj0wSWByUJhlqEyJl0=
Received: from SJ0PR03CA0142.namprd03.prod.outlook.com (2603:10b6:a03:33c::27)
 by MN2PR12MB4271.namprd12.prod.outlook.com (2603:10b6:208:1d7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Mon, 10 Feb
 2025 11:27:18 +0000
Received: from SJ5PEPF00000203.namprd05.prod.outlook.com
 (2603:10b6:a03:33c:cafe::a5) by SJ0PR03CA0142.outlook.office365.com
 (2603:10b6:a03:33c::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.31 via Frontend Transport; Mon,
 10 Feb 2025 11:27:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF00000203.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Mon, 10 Feb 2025 11:27:17 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Feb
 2025 05:27:15 -0600
Received: from xcbecree42x.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Mon, 10 Feb 2025 05:27:13 -0600
From: <edward.cree@amd.com>
To: <linux-net-drivers@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>, <horms@kernel.org>,
	<andrew+netdev@lunn.ch>
CC: Edward Cree <ecree.xilinx@gmail.com>, <habetsm.xilinx@gmail.com>,
	<jiri@resnulli.us>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 3/4] sfc: deploy devlink flash images to NIC over MCDI
Date: Mon, 10 Feb 2025 11:25:44 +0000
Message-ID: <a746335876b621b3e54cf4e49948148e349a1745.1739186253.git.ecree.xilinx@gmail.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000203:EE_|MN2PR12MB4271:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c065173-138f-4c67-21c4-08dd49c5e026
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4+F4DgHXucsJD+z0rvItlcmauz8Cd1zvBrdl1m9gqnD1woNknwur6o+Pbfa7?=
 =?us-ascii?Q?/qKZg74ereZ5JGwxwqOOgeA3pp6BFQmY4TkGzgh6/2DJ92GlbwhPK0ptj46E?=
 =?us-ascii?Q?BU9zjyxo5C61PdDxWqeQFltW7Fv308vTLXMM5/BRZ3l00Tl8J0gON6fM4VaC?=
 =?us-ascii?Q?jclBO2a0rV6CZ1j6U+YeZKCbDVJ5V6J6bExu1Rjvvnxh3mLTDq2JaLyCae1E?=
 =?us-ascii?Q?d7Dp3KDPnArjebYp9afPFNH2qnQ48iHwmjelGDOktkmEPwGa6Y66jM91oc0q?=
 =?us-ascii?Q?APByMTgntNLEw6TdMdDxoqTvdD8cG1ijZKYxQoXETLJu/FSI9ddHmXrfZeFa?=
 =?us-ascii?Q?rLmIkcPDoEeHj5FeCb9oN6pfjJaJfw3AOw3QvQm4mYFzRoD6OdrRawSrXbCQ?=
 =?us-ascii?Q?OmDHQ30kFBP7V49izrRpGJWa33+WCrPGAxhdfPavXc1lxPrqLg/hTLrocbvK?=
 =?us-ascii?Q?iLVgaBDiYtA8L/W2cHr675AvF51K0jB6sFe9tydyMJ9I3NS9k2kVuPMleKmF?=
 =?us-ascii?Q?tGZ2PvpvJRf3CwpqkuFTcrWT/ml3DqHzpGWHwMBIibWTOgM+xyFMhXmkJSVQ?=
 =?us-ascii?Q?emEnZ4O/R9LDiZ7D6eJIOwOMaTzpUXAtCybPKrjaQoxYE4nu+50SQ1IAY+73?=
 =?us-ascii?Q?rwAgJflFjuYleAIWhu/t1Ucznoiy1NeEiw8Cin4STNZH7+aUkcsrGJY8Lkpe?=
 =?us-ascii?Q?CT6N7elu+pqum3+vLgf7ReWio/f2uMg0e2Ss2vDCEw/pkxj3BKgkyezAyvRa?=
 =?us-ascii?Q?fPAJ3kG29IUCJOgv6iBzTLeK3ET8U4VswvHRtRI1IWB6f8+gp1akvn17KMOa?=
 =?us-ascii?Q?5FuA9a0Filny2D4fb1rCRgJOY6zbNHMCvp0FAdyupyZ9zpfDji/fCYxlZhak?=
 =?us-ascii?Q?m9LQvcfnYg+eIzjj5TG8N+sUKe4au2RH51F6GAf+Qsx+qu3g7B6tf4FK/eeW?=
 =?us-ascii?Q?9JS9CedEGHUt+7jP84tPLEUfK2EnHMHbPu/AqZx66hi0tJ4VjMuubtodZCKc?=
 =?us-ascii?Q?JJpzcmMSYj83ORyyLZAJE4wkO8lio6ukGhfces5BCjQ5oMXmJdLJCC6x2Fyi?=
 =?us-ascii?Q?oKnhqXjzzfr/KmX/PSqnxWtkxaxs/8HJQLlYjG0+mpgWqUMpXazvoJBC9SOt?=
 =?us-ascii?Q?lW0GWT/SEfk+syjzhMPikwZIOH5v6+ApHceA3kk7O4BEo2gd/OVQobLCb4aS?=
 =?us-ascii?Q?ePjKNrt+Zjvv/7LfmKnE/+rpTAVndcMnC5chTO/LZKg9j56juLPLNo2mHAVf?=
 =?us-ascii?Q?UJ0ertKzY92b2wsE73NRIDaVSpE1EBCIQqYBxgCkSeGafg6ZvjwbZfPm4gae?=
 =?us-ascii?Q?nwwH68TO0UeLTmwq0N0wiy5LUaGosi/bEYhdtthnzj1jfH872laoEpcLuEyN?=
 =?us-ascii?Q?L9RkvhkjaVTDmxmI9VF8vf9KiHX9sm/m0QIBG4rudijb80gUPHQA+WVbAcgu?=
 =?us-ascii?Q?3OlPwPwOlcFe0tSVcRXJdnZ8e1itxyMETSAmxH3EQXf7kDY8BvsP+N3Gn+ub?=
 =?us-ascii?Q?E9mGZLk6Z/mT+eE=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 11:27:17.2740
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c065173-138f-4c67-21c4-08dd49c5e026
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000203.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4271

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
 

