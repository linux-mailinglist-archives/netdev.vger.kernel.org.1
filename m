Return-Path: <netdev+bounces-164685-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87201A2EB09
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 12:27:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3E0C1886172
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 11:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D9C61E04A9;
	Mon, 10 Feb 2025 11:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1fNWztZB"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BA61DE3CF
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 11:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739186842; cv=fail; b=iJwVnHMRWwIUxQQMyp1WkNts1HDCoYyCdOypHDdfzSqsDUlqiDrU905Eht3wOsdoW5jj4UgY9oeEzt8/UEcTb+7DMvsMtlQks2OngvQk3stYthELCq6XbJ64xjAQk7Y+Ovh2M0q8Tpd3ywXsNFqhpfrBXtDDLktv4Z/qh0QAB2U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739186842; c=relaxed/simple;
	bh=nEbaVXgdtZ15Ro9EVECZidnEQlUp8zZynraWpG0Akc0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XivY6IkslJtXf5CYD02Pfb10GAyfud2vE48OCULhx8w7SRNA2GRnxDvrejsJxGHBl/bM53+uWFRXI9WRvxr4FfKC0RNyDQYN2A9QW9MFNH0eB5E7bVw1opYXQ8/9h1Sx3MRueErPGoK806p28n/MgFn0xOklitYjbBuS2TqwK38=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1fNWztZB; arc=fail smtp.client-ip=40.107.244.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GBWj7LTVfwwxpkAW14x0cQDDLzEOYbI9B8/UcH87ZZAKhFlINWtAtUpBBNSpeJEB97ezda33jt3s99t4cbF3v3VepCvbHeukhMTS18QR25udyE4PU7MgOjkjnB5vGBJIfCt5/y04wy3er0P6255kPiRJTLrgojDvciXR9wboIn9jpsYivtjs3HrE33cf5nh0DdRlXfGlWdEb43IA3uX1Hsx5NOu9mI6eHGeuGdnj4d2kfEV8q1u9Ig7fYeLEeSgIQ4rPUm7D6J5xPjfRK5CsillxYisUNpkgxBPF75kpOn+RG6Uq25t4WsnW9TjLk0SapQPnkE1BmUFVS0NbEFcpqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wjcSpvnMU6z35UWAfx6k3CxGEki0N+deMYqSFlVArHw=;
 b=H4dhY+npsEaiwV2Q/sDLvcOaekZ+C5lX4e9Kohuxlh32NsMG5jGP8/BHOTF4a6N29OVYjVXzVpbKEJGlmFcr87is8PG9Nsv1P6bFbxVZgPQ+Zw/ELqsadqX6vplK/mnC1VXq1Xz8CQksZTA40+7Wx9JGvVBC/2MwpqvzHvDhwAGVXKCvla3AF7NXR1cz9UThV+4NAUmYUiZqXZO5SbTkklJO797rvxB4wSFRie92Lc4qtOwiXVNLKgh4XZ490GkR8+Rf7CtFn6JGwIDEje0onOrojRMoDg+ZE7nE/kZvopFmUzQchcXNVp3SsTKI7FqOvhbhe+YXc70V/irBVbs0kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wjcSpvnMU6z35UWAfx6k3CxGEki0N+deMYqSFlVArHw=;
 b=1fNWztZB/glgTlepNfnNMcnuNtNOUPGv0iFpEtkFgpxRte9zRVS3RHY9mABO/eblA0WSKQ0UHxVNYlmkBG4XLazHNZH8I57nAxKrerlfl6jBtdS8YtdxiQsEgX0LW+T7xsSJrhmTJ2lTodDxWZcT5V74HYUwmqf0pBd1KfToqRw=
Received: from MW4PR04CA0311.namprd04.prod.outlook.com (2603:10b6:303:82::16)
 by DM6PR12MB4370.namprd12.prod.outlook.com (2603:10b6:5:2aa::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Mon, 10 Feb
 2025 11:27:14 +0000
Received: from SJ1PEPF00002315.namprd03.prod.outlook.com
 (2603:10b6:303:82:cafe::e) by MW4PR04CA0311.outlook.office365.com
 (2603:10b6:303:82::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.31 via Frontend Transport; Mon,
 10 Feb 2025 11:27:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002315.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Mon, 10 Feb 2025 11:27:12 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Feb
 2025 05:27:11 -0600
Received: from xcbecree42x.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Mon, 10 Feb 2025 05:27:10 -0600
From: <edward.cree@amd.com>
To: <linux-net-drivers@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>, <horms@kernel.org>,
	<andrew+netdev@lunn.ch>
CC: Edward Cree <ecree.xilinx@gmail.com>, <habetsm.xilinx@gmail.com>,
	<jiri@resnulli.us>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 1/4] sfc: parse headers of devlink flash images
Date: Mon, 10 Feb 2025 11:25:42 +0000
Message-ID: <65318300f3f1b1462925f917f7c0d0ac833955ae.1739186253.git.ecree.xilinx@gmail.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002315:EE_|DM6PR12MB4370:EE_
X-MS-Office365-Filtering-Correlation-Id: efbbfa54-f80e-43fe-1da5-08dd49c5dd91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pKtT7a+aBJGjtoUUWwNWuxxu7xZloNBerp3a/07fqTD/ZV/Qi4srdN8tGg88?=
 =?us-ascii?Q?oirtTh0zXFnFMiJXIswi/k9Okqgjze6/sl4D0DkTR9BHWVJUAnD5J6Uuy9Iq?=
 =?us-ascii?Q?EdZZYTLM0FZYHjIalaLNHIMasl0ONjGOQSIrjJqj4Dvwqqrgw41q1es6sgn5?=
 =?us-ascii?Q?5vAYamSETFxgZwn4RnTd7tP4mMT0S/ury6136nffR7OizeeP7YQ2wbQMkMwn?=
 =?us-ascii?Q?XcvKm4/VcimYG/f+C3WFdN/v4h5l+uvdJebLl8DDf5ALTKGnXcTaxE0mIflN?=
 =?us-ascii?Q?c+rDWLtiJ4w1pfZss7sifU+tZwK3ezQkdfkJmkMORM2qTyPsziEb5M+Y4TB9?=
 =?us-ascii?Q?Co8nSvup11U6uS41eBP0ECMeoCEAADEtf7jHLDGKg8jLRs+pCEz4zQPPv+bl?=
 =?us-ascii?Q?oM0B6WV/mpb1ONky7IpJSUrJOugFDyIlMR560Zf+UKwyeUsdPZpvJyof7fsW?=
 =?us-ascii?Q?9gUujqPrL8qWdxqTcV+fhCXoDRKQoVk2AfZ60JrrN8fNCYA/feSy+kFIk2nD?=
 =?us-ascii?Q?vC9H21/XZjjEeGXCP1Cjk+eAGjiS6KuI3kRv3kdezguNjSmVFcV0dh+Rjjmm?=
 =?us-ascii?Q?ZZlM7haXbRsn/ZK8PlomtslLiqRddJ8/9lwCXxH1tAFzJAGL+mpITzWUg9+L?=
 =?us-ascii?Q?k7DepodpNW3z7la0WOWEDHIu9aI6+mgdLm016kaJ7jt39mP1JUJiAC65vXsK?=
 =?us-ascii?Q?rflfJQgssww48DwCbO2LGcGyb9ccaKGDCL6EXwxokpe9W3jGrgceDzjxUlfK?=
 =?us-ascii?Q?IY2YLKQhkOYTBRm/ltzgx/oTA4MyZpY+ZRksuwtQBCHFd74qC5tnEz52ikx6?=
 =?us-ascii?Q?JRQD/aOOh79mZNwZEipACptCAbTOzrNnbiAQpR8QUNHBJS2wyVxgmbFrYqYs?=
 =?us-ascii?Q?gJVOEoh9dcGe1w/22dKDR2T/Ca5DiTNjhXVmIjQPP9Ik/KuG7afBNxAiwc1+?=
 =?us-ascii?Q?L8i6tUbq5VT+rI5uoSSS3jstrQZnemmeULF7iCr50HAeXDnefrmB6v/iAU37?=
 =?us-ascii?Q?l67ICzCKlBEQSsEwR6lNq+fh2y7hjLEhoORfjdzslSSDHtUfQvWlYsk1JEDz?=
 =?us-ascii?Q?kNivkLwjcI4efnVxU/QxEAM32KXhTJ+hoh/z05lX+4YcZrigNHZCh3pDOl5s?=
 =?us-ascii?Q?h36B5YLnx3NJsRw5zptpFLNBUR8VvqIRbefaGZmTeloXX42NNNAU9FAPoE0c?=
 =?us-ascii?Q?u1AIOdCV0kbj8Bsd2PXHFmDxrHKOoK8Ri/AUhGtAKSDVzP/lTBh5SqSdrgd0?=
 =?us-ascii?Q?i1yzmt4VhfV82E3TCjCisTak42UpVVZIBiIjRh38L4ctIgCzTS60r2/Ok1dw?=
 =?us-ascii?Q?yBmPNNsvUJPS4e5HPQL6ooVnunPod+YidjzKKK7ZRYz6BPNK50FF6UXjkodl?=
 =?us-ascii?Q?n/2TbmysDBA6TukLhKleHPEgKSgB1wJ8PM3dGsLPXp+iyY1f/mC/APuNSK/m?=
 =?us-ascii?Q?vFnIUIiizti050LUBDZLOk6Qz70iEBy0g2+Ov9/oL/ObbaAiknXMS7FSUbJJ?=
 =?us-ascii?Q?7AnEBJnygJ0Uh2g=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 11:27:12.9576
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: efbbfa54-f80e-43fe-1da5-08dd49c5dd91
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002315.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4370

From: Edward Cree <ecree.xilinx@gmail.com>

This parsing is necessary to obtain the metadata which will be
 used in a subsequent patch to write the image to the device.

Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
---
 drivers/net/ethernet/sfc/Makefile      |   2 +-
 drivers/net/ethernet/sfc/efx_devlink.c |  13 ++
 drivers/net/ethernet/sfc/efx_reflash.c | 289 +++++++++++++++++++++++++
 drivers/net/ethernet/sfc/efx_reflash.h |  20 ++
 drivers/net/ethernet/sfc/fw_formats.h  | 114 ++++++++++
 5 files changed, 437 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/sfc/efx_reflash.c
 create mode 100644 drivers/net/ethernet/sfc/efx_reflash.h
 create mode 100644 drivers/net/ethernet/sfc/fw_formats.h

diff --git a/drivers/net/ethernet/sfc/Makefile b/drivers/net/ethernet/sfc/Makefile
index 8f446b9bd5ee..d99039ec468d 100644
--- a/drivers/net/ethernet/sfc/Makefile
+++ b/drivers/net/ethernet/sfc/Makefile
@@ -7,7 +7,7 @@ sfc-y			+= efx.o efx_common.o efx_channels.o nic.o \
 			   mcdi_functions.o mcdi_filters.o mcdi_mon.o \
 			   ef100.o ef100_nic.o ef100_netdev.o \
 			   ef100_ethtool.o ef100_rx.o ef100_tx.o \
-			   efx_devlink.o
+			   efx_devlink.o efx_reflash.o
 sfc-$(CONFIG_SFC_MTD)	+= mtd.o
 sfc-$(CONFIG_SFC_SRIOV)	+= sriov.o ef10_sriov.o ef100_sriov.o ef100_rep.o \
                            mae.o tc.o tc_bindings.o tc_counters.o \
diff --git a/drivers/net/ethernet/sfc/efx_devlink.c b/drivers/net/ethernet/sfc/efx_devlink.c
index 3cd750820fdd..d842c60dfc10 100644
--- a/drivers/net/ethernet/sfc/efx_devlink.c
+++ b/drivers/net/ethernet/sfc/efx_devlink.c
@@ -19,6 +19,7 @@
 #include "mae.h"
 #include "ef100_rep.h"
 #endif
+#include "efx_reflash.h"
 
 struct efx_devlink {
 	struct efx_nic *efx;
@@ -615,7 +616,19 @@ static int efx_devlink_info_get(struct devlink *devlink,
 	return 0;
 }
 
+static int efx_devlink_flash_update(struct devlink *devlink,
+				    struct devlink_flash_update_params *params,
+				    struct netlink_ext_ack *extack)
+{
+	struct efx_devlink *devlink_private = devlink_priv(devlink);
+	struct efx_nic *efx = devlink_private->efx;
+
+	return efx_reflash_flash_firmware(efx, params->fw, extack);
+}
+
 static const struct devlink_ops sfc_devlink_ops = {
+	.supported_flash_update_params	= 0,
+	.flash_update			= efx_devlink_flash_update,
 	.info_get			= efx_devlink_info_get,
 };
 
diff --git a/drivers/net/ethernet/sfc/efx_reflash.c b/drivers/net/ethernet/sfc/efx_reflash.c
new file mode 100644
index 000000000000..9a8d8211e18b
--- /dev/null
+++ b/drivers/net/ethernet/sfc/efx_reflash.c
@@ -0,0 +1,289 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/****************************************************************************
+ * Driver for AMD network controllers and boards
+ * Copyright (C) 2025, Advanced Micro Devices, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation, incorporated herein by reference.
+ */
+
+#include <linux/crc32.h>
+#include <net/devlink.h>
+#include "efx_reflash.h"
+#include "net_driver.h"
+#include "fw_formats.h"
+#include "mcdi_pcol.h"
+#include "mcdi.h"
+
+/* Try to parse a Reflash header at the specified offset */
+static bool efx_reflash_parse_reflash_header(const struct firmware *fw,
+					     size_t header_offset, u32 *type,
+					     u32 *subtype, const u8 **data,
+					     size_t *data_size)
+{
+	size_t header_end, trailer_offset, trailer_end;
+	u32 magic, version, payload_size, header_len;
+	const u8 *header, *trailer;
+	u32 expected_crc, crc;
+
+	if (check_add_overflow(header_offset, EFX_REFLASH_HEADER_LENGTH_OFST +
+					      EFX_REFLASH_HEADER_LENGTH_LEN,
+			       &header_end))
+		return false;
+	if (fw->size < header_end)
+		return false;
+
+	header = fw->data + header_offset;
+	magic = get_unaligned_le32(header + EFX_REFLASH_HEADER_MAGIC_OFST);
+	if (magic != EFX_REFLASH_HEADER_MAGIC_VALUE)
+		return false;
+
+	version = get_unaligned_le32(header + EFX_REFLASH_HEADER_VERSION_OFST);
+	if (version != EFX_REFLASH_HEADER_VERSION_VALUE)
+		return false;
+
+	payload_size = get_unaligned_le32(header + EFX_REFLASH_HEADER_PAYLOAD_SIZE_OFST);
+	header_len = get_unaligned_le32(header + EFX_REFLASH_HEADER_LENGTH_OFST);
+	if (check_add_overflow(header_offset, header_len, &trailer_offset) ||
+	    check_add_overflow(trailer_offset, payload_size, &trailer_offset) ||
+	    check_add_overflow(trailer_offset, EFX_REFLASH_TRAILER_LEN,
+			       &trailer_end))
+		return false;
+	if (fw->size < trailer_end)
+		return false;
+
+	trailer = fw->data + trailer_offset;
+	expected_crc = get_unaligned_le32(trailer + EFX_REFLASH_TRAILER_CRC_OFST);
+	/* Addition could overflow u32, but not size_t since we already
+	 * checked trailer_offset didn't overflow.  So cast to size_t first.
+	 */
+	crc = crc32_le(0, header, (size_t)header_len + payload_size);
+	if (crc != expected_crc)
+		return false;
+
+	*type = get_unaligned_le32(header + EFX_REFLASH_HEADER_FIRMWARE_TYPE_OFST);
+	*subtype = get_unaligned_le32(header + EFX_REFLASH_HEADER_FIRMWARE_SUBTYPE_OFST);
+	if (*type == EFX_REFLASH_FIRMWARE_TYPE_BUNDLE) {
+		/* All the bundle data is written verbatim to NVRAM */
+		*data = fw->data;
+		*data_size = fw->size;
+	} else {
+		/* Other payload types strip the reflash header and trailer
+		 * from the data written to NVRAM
+		 */
+		*data = header + header_len;
+		*data_size = payload_size;
+	}
+
+	return true;
+}
+
+/* Map from FIRMWARE_TYPE to NVRAM_PARTITION_TYPE */
+static int efx_reflash_partition_type(u32 type, u32 subtype,
+				      u32 *partition_type,
+				      u32 *partition_subtype)
+{
+	int rc = 0;
+
+	switch (type) {
+	case EFX_REFLASH_FIRMWARE_TYPE_BOOTROM:
+		*partition_type = NVRAM_PARTITION_TYPE_EXPANSION_ROM;
+		*partition_subtype = subtype;
+		break;
+	case EFX_REFLASH_FIRMWARE_TYPE_BUNDLE:
+		*partition_type = NVRAM_PARTITION_TYPE_BUNDLE;
+		*partition_subtype = subtype;
+		break;
+	default:
+		/* Not supported */
+		rc = -EINVAL;
+	}
+
+	return rc;
+}
+
+/* Try to parse a SmartNIC image header at the specified offset */
+static bool efx_reflash_parse_snic_header(const struct firmware *fw,
+					  size_t header_offset,
+					  u32 *partition_type,
+					  u32 *partition_subtype,
+					  const u8 **data, size_t *data_size)
+{
+	u32 magic, version, payload_size, header_len, expected_crc, crc;
+	size_t header_end, payload_end;
+	const u8 *header;
+
+	if (check_add_overflow(header_offset, EFX_SNICIMAGE_HEADER_MINLEN,
+			       &header_end) ||
+	    fw->size < header_end)
+		return false;
+
+	header = fw->data + header_offset;
+	magic = get_unaligned_le32(header + EFX_SNICIMAGE_HEADER_MAGIC_OFST);
+	if (magic != EFX_SNICIMAGE_HEADER_MAGIC_VALUE)
+		return false;
+
+	version = get_unaligned_le32(header + EFX_SNICIMAGE_HEADER_VERSION_OFST);
+	if (version != EFX_SNICIMAGE_HEADER_VERSION_VALUE)
+		return false;
+
+	header_len = get_unaligned_le32(header + EFX_SNICIMAGE_HEADER_LENGTH_OFST);
+	if (check_add_overflow(header_offset, header_len, &header_end))
+		return false;
+	payload_size = get_unaligned_le32(header + EFX_SNICIMAGE_HEADER_PAYLOAD_SIZE_OFST);
+	if (check_add_overflow(header_end, payload_size, &payload_end) ||
+	    fw->size < payload_end)
+		return false;
+
+	expected_crc = get_unaligned_le32(header + EFX_SNICIMAGE_HEADER_CRC_OFST);
+
+	/* Calculate CRC omitting the expected CRC field itself */
+	crc = crc32_le(~0, header, EFX_SNICIMAGE_HEADER_CRC_OFST);
+	crc = ~crc32_le(crc,
+			header + EFX_SNICIMAGE_HEADER_CRC_OFST +
+			EFX_SNICIMAGE_HEADER_CRC_LEN,
+			header_len + payload_size - EFX_SNICIMAGE_HEADER_CRC_OFST -
+			EFX_SNICIMAGE_HEADER_CRC_LEN);
+	if (crc != expected_crc)
+		return false;
+
+	*partition_type =
+		get_unaligned_le32(header + EFX_SNICIMAGE_HEADER_PARTITION_TYPE_OFST);
+	*partition_subtype =
+		get_unaligned_le32(header + EFX_SNICIMAGE_HEADER_PARTITION_SUBTYPE_OFST);
+	*data = fw->data;
+	*data_size = fw->size;
+	return true;
+}
+
+/* Try to parse a SmartNIC bundle header at the specified offset */
+static bool efx_reflash_parse_snic_bundle_header(const struct firmware *fw,
+						 size_t header_offset,
+						 u32 *partition_type,
+						 u32 *partition_subtype,
+						 const u8 **data,
+						 size_t *data_size)
+{
+	u32 magic, version, bundle_type, header_len, expected_crc, crc;
+	size_t header_end;
+	const u8 *header;
+
+	if (check_add_overflow(header_offset, EFX_SNICBUNDLE_HEADER_LEN,
+			       &header_end))
+		return false;
+	if (fw->size < header_end)
+		return false;
+
+	header = fw->data + header_offset;
+	magic = get_unaligned_le32(header + EFX_SNICBUNDLE_HEADER_MAGIC_OFST);
+	if (magic != EFX_SNICBUNDLE_HEADER_MAGIC_VALUE)
+		return false;
+
+	version = get_unaligned_le32(header + EFX_SNICBUNDLE_HEADER_VERSION_OFST);
+	if (version != EFX_SNICBUNDLE_HEADER_VERSION_VALUE)
+		return false;
+
+	bundle_type = get_unaligned_le32(header + EFX_SNICBUNDLE_HEADER_BUNDLE_TYPE_OFST);
+	if (bundle_type != NVRAM_PARTITION_TYPE_BUNDLE)
+		return false;
+
+	header_len = get_unaligned_le32(header + EFX_SNICBUNDLE_HEADER_LENGTH_OFST);
+	if (header_len != EFX_SNICBUNDLE_HEADER_LEN)
+		return false;
+
+	expected_crc = get_unaligned_le32(header + EFX_SNICBUNDLE_HEADER_CRC_OFST);
+	crc = ~crc32_le(~0, header, EFX_SNICBUNDLE_HEADER_CRC_OFST);
+	if (crc != expected_crc)
+		return false;
+
+	*partition_type = NVRAM_PARTITION_TYPE_BUNDLE;
+	*partition_subtype = get_unaligned_le32(header + EFX_SNICBUNDLE_HEADER_BUNDLE_SUBTYPE_OFST);
+	*data = fw->data;
+	*data_size = fw->size;
+	return true;
+}
+
+/* Try to find a valid firmware payload in the firmware data.
+ * When we recognise a valid header, we parse it for the partition type
+ * (so we know where to ask the MC to write it to) and the location of
+ * the data blob to write.
+ */
+static int efx_reflash_parse_firmware_data(const struct firmware *fw,
+					   u32 *partition_type,
+					   u32 *partition_subtype,
+					   const u8 **data, size_t *data_size)
+{
+	size_t header_offset;
+	u32 type, subtype;
+
+	/* Some packaging formats (such as CMS/PKCS#7 signed images)
+	 * prepend a header for which finding the size is a non-trivial
+	 * task, so step through the firmware data until we find a valid
+	 * header.
+	 *
+	 * The checks are intended to reject firmware data that is clearly not
+	 * in the expected format.  They do not need to be exhaustive as the
+	 * running firmware will perform its own comprehensive validity and
+	 * compatibility checks during the update procedure.
+	 *
+	 * Firmware packages may contain multiple reflash images, e.g. a
+	 * bundle containing one or more other images.  Only check the
+	 * outermost container by stopping after the first candidate image
+	 * found even it is for an unsupported partition type.
+	 */
+	for (header_offset = 0; header_offset < fw->size; header_offset++) {
+		if (efx_reflash_parse_snic_bundle_header(fw, header_offset,
+							 partition_type,
+							 partition_subtype,
+							 data, data_size))
+			return 0;
+
+		if (efx_reflash_parse_snic_header(fw, header_offset,
+						  partition_type,
+						  partition_subtype, data,
+						  data_size))
+			return 0;
+
+		if (efx_reflash_parse_reflash_header(fw, header_offset, &type,
+						     &subtype, data, data_size))
+			return efx_reflash_partition_type(type, subtype,
+							  partition_type,
+							  partition_subtype);
+	}
+
+	return -EINVAL;
+}
+
+int efx_reflash_flash_firmware(struct efx_nic *efx, const struct firmware *fw,
+			       struct netlink_ext_ack *extack)
+{
+	struct devlink *devlink = efx->devlink;
+	u32 type, data_subtype;
+	size_t data_size;
+	const u8 *data;
+	int rc;
+
+	if (!efx_has_cap(efx, BUNDLE_UPDATE)) {
+		NL_SET_ERR_MSG_MOD(extack, "NVRAM bundle updates are not supported by the firmware");
+		return -EOPNOTSUPP;
+	}
+
+	devlink_flash_update_status_notify(devlink, "Checking update", NULL, 0, 0);
+
+	rc = efx_reflash_parse_firmware_data(fw, &type, &data_subtype, &data,
+					     &data_size);
+	if (rc) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Firmware image validation check failed");
+		goto out;
+	}
+
+	rc = -EOPNOTSUPP;
+
+out:
+	devlink_flash_update_status_notify(devlink, rc ? "Update failed" :
+							 "Update complete",
+					   NULL, 0, 0);
+	return rc;
+}
diff --git a/drivers/net/ethernet/sfc/efx_reflash.h b/drivers/net/ethernet/sfc/efx_reflash.h
new file mode 100644
index 000000000000..3dffac565161
--- /dev/null
+++ b/drivers/net/ethernet/sfc/efx_reflash.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/****************************************************************************
+ * Driver for AMD network controllers and boards
+ * Copyright (C) 2025, Advanced Micro Devices, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation, incorporated herein by reference.
+ */
+
+#ifndef _EFX_REFLASH_H
+#define _EFX_REFLASH_H
+
+#include "net_driver.h"
+#include <linux/firmware.h>
+
+int efx_reflash_flash_firmware(struct efx_nic *efx, const struct firmware *fw,
+			       struct netlink_ext_ack *extack);
+
+#endif /* _EFX_REFLASH_H */
diff --git a/drivers/net/ethernet/sfc/fw_formats.h b/drivers/net/ethernet/sfc/fw_formats.h
new file mode 100644
index 000000000000..cbc350c96013
--- /dev/null
+++ b/drivers/net/ethernet/sfc/fw_formats.h
@@ -0,0 +1,114 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/****************************************************************************
+ * Driver for AMD network controllers and boards
+ * Copyright (C) 2025, Advanced Micro Devices, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation, incorporated herein by reference.
+ */
+
+#ifndef _EFX_FW_FORMATS_H
+#define _EFX_FW_FORMATS_H
+
+/* Header layouts of firmware update images recognised by Efx NICs.
+ * The sources-of-truth for these layouts are AMD internal documents
+ * and sfregistry headers, neither of which are available externally
+ * nor usable directly by the driver.
+ *
+ * While each format includes a 'magic number', these are at different
+ * offsets in the various formats, and a legal header for one format
+ * could have the right value in whichever field occupies that offset
+ * to match another format's magic.
+ * Besides, some packaging formats (such as CMS/PKCS#7 signed images)
+ * prepend a header for which finding the size is a non-trivial task;
+ * rather than trying to parse those headers, we search byte-by-byte
+ * through the provided firmware image looking for a valid header.
+ * Thus, format recognition has to include validation of the checksum
+ * field, even though the firmware will validate that itself before
+ * applying the image.
+ */
+
+/* EF10 (Medford2, X2) "reflash" header format.  Defined in SF-121352-AN */
+#define EFX_REFLASH_HEADER_MAGIC_OFST 0
+#define EFX_REFLASH_HEADER_MAGIC_LEN 4
+#define EFX_REFLASH_HEADER_MAGIC_VALUE 0x106F1A5
+
+#define EFX_REFLASH_HEADER_VERSION_OFST 4
+#define EFX_REFLASH_HEADER_VERSION_LEN 4
+#define EFX_REFLASH_HEADER_VERSION_VALUE 4
+
+#define EFX_REFLASH_HEADER_FIRMWARE_TYPE_OFST 8
+#define EFX_REFLASH_HEADER_FIRMWARE_TYPE_LEN 4
+#define EFX_REFLASH_FIRMWARE_TYPE_BOOTROM 0x2
+#define EFX_REFLASH_FIRMWARE_TYPE_BUNDLE 0xd
+
+#define EFX_REFLASH_HEADER_FIRMWARE_SUBTYPE_OFST 12
+#define EFX_REFLASH_HEADER_FIRMWARE_SUBTYPE_LEN 4
+
+#define EFX_REFLASH_HEADER_PAYLOAD_SIZE_OFST 16
+#define EFX_REFLASH_HEADER_PAYLOAD_SIZE_LEN 4
+
+#define EFX_REFLASH_HEADER_LENGTH_OFST 20
+#define EFX_REFLASH_HEADER_LENGTH_LEN 4
+
+/* Reflash trailer */
+#define EFX_REFLASH_TRAILER_CRC_OFST 0
+#define EFX_REFLASH_TRAILER_CRC_LEN 4
+
+#define EFX_REFLASH_TRAILER_LEN	\
+	(EFX_REFLASH_TRAILER_CRC_OFST + EFX_REFLASH_TRAILER_CRC_LEN)
+
+/* EF100 "SmartNIC image" header format.
+ * Defined in sfregistry "src/layout/snic_image_hdr.h".
+ */
+#define EFX_SNICIMAGE_HEADER_MAGIC_OFST 16
+#define EFX_SNICIMAGE_HEADER_MAGIC_LEN 4
+#define EFX_SNICIMAGE_HEADER_MAGIC_VALUE 0x541C057A
+
+#define EFX_SNICIMAGE_HEADER_VERSION_OFST 20
+#define EFX_SNICIMAGE_HEADER_VERSION_LEN 4
+#define EFX_SNICIMAGE_HEADER_VERSION_VALUE 1
+
+#define EFX_SNICIMAGE_HEADER_LENGTH_OFST 24
+#define EFX_SNICIMAGE_HEADER_LENGTH_LEN 4
+
+#define EFX_SNICIMAGE_HEADER_PARTITION_TYPE_OFST 36
+#define EFX_SNICIMAGE_HEADER_PARTITION_TYPE_LEN 4
+
+#define EFX_SNICIMAGE_HEADER_PARTITION_SUBTYPE_OFST 40
+#define EFX_SNICIMAGE_HEADER_PARTITION_SUBTYPE_LEN 4
+
+#define EFX_SNICIMAGE_HEADER_PAYLOAD_SIZE_OFST 60
+#define EFX_SNICIMAGE_HEADER_PAYLOAD_SIZE_LEN 4
+
+#define EFX_SNICIMAGE_HEADER_CRC_OFST 64
+#define EFX_SNICIMAGE_HEADER_CRC_LEN 4
+
+#define EFX_SNICIMAGE_HEADER_MINLEN 256
+
+/* EF100 "SmartNIC bundle" header format.  Defined in SF-122606-TC */
+#define EFX_SNICBUNDLE_HEADER_MAGIC_OFST 0
+#define EFX_SNICBUNDLE_HEADER_MAGIC_LEN 4
+#define EFX_SNICBUNDLE_HEADER_MAGIC_VALUE 0xB1001001
+
+#define EFX_SNICBUNDLE_HEADER_VERSION_OFST 4
+#define EFX_SNICBUNDLE_HEADER_VERSION_LEN 4
+#define EFX_SNICBUNDLE_HEADER_VERSION_VALUE 1
+
+#define EFX_SNICBUNDLE_HEADER_BUNDLE_TYPE_OFST 8
+#define EFX_SNICBUNDLE_HEADER_BUNDLE_TYPE_LEN 4
+
+#define EFX_SNICBUNDLE_HEADER_BUNDLE_SUBTYPE_OFST 12
+#define EFX_SNICBUNDLE_HEADER_BUNDLE_SUBTYPE_LEN 4
+
+#define EFX_SNICBUNDLE_HEADER_LENGTH_OFST 20
+#define EFX_SNICBUNDLE_HEADER_LENGTH_LEN 4
+
+#define EFX_SNICBUNDLE_HEADER_CRC_OFST 224
+#define EFX_SNICBUNDLE_HEADER_CRC_LEN 4
+
+#define EFX_SNICBUNDLE_HEADER_LEN	\
+	(EFX_SNICBUNDLE_HEADER_CRC_OFST + EFX_SNICBUNDLE_HEADER_CRC_LEN)
+
+#endif /* _EFX_FW_FORMATS_H */

