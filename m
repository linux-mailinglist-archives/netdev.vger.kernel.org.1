Return-Path: <netdev+bounces-163719-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF3BAA2B6ED
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 01:06:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59971167816
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 00:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98B85139D;
	Fri,  7 Feb 2025 00:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="z1abNKCh"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2052.outbound.protection.outlook.com [40.107.96.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B05310E9
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 00:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738886812; cv=fail; b=trysHrx/zPJPPeGGLgChDW7ShDoQWL/3p2Aver+91CGci5TCooYcgrlLotRDg7DSU8hbtSSHID8bNAp4VQXoM+bgzR8x/eC4+2Je8DmoZnlaT1Q0dxM8rS8nrMgIBY5aqy2fiM/bpRTOV75SKir8RNlehFoqEFZlAWkWbDphHrs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738886812; c=relaxed/simple;
	bh=nEbaVXgdtZ15Ro9EVECZidnEQlUp8zZynraWpG0Akc0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nNp+iA+Ir/JNRtH+Y+Cfl0cO1KE1TDXHytzDFnKLpTI4C4XIulOdvuYCJmVUotkDtDbEoR9GaUoX4YCn3o/1ixNzZbq1p+l0lVxbIz4FjJhw0KRyzz2eQda/qIOUO4iRdYfWWnpkdc41JYs8ziz4nxPFv67+kirA71Em00mr8Tw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=z1abNKCh; arc=fail smtp.client-ip=40.107.96.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s/jc/sxQO1CZZZ7M8EilbzskcAAJGOfWs5seKPEOZ2WtAKlfk63rr5cfD6JmphAvL/23IU2qd83qGZVjzmdKEVtn5tebRdqiyCNDAvISQNG+7xZKFZDQW8FdfvXCl0b9VbTF/Z1nCYiuojAowoTQm6eu5+diwF7zn1taao2elJc5/kLUE3deWQm4KUghNwUPh11Cz0aQXjJfw7VeWzVzTP+jRt9ZIIgmNbYpihN0PAEBxqr+kbiEo8BbZ8H2NdcBi/4DYdbQXBgqALJxEokK+qxDc8v6F0h8q3J+DcDLZKfZcXNG5koQIi2M+Pd/fTZPVELTSYUaDFJ3b0Y4eBQfWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wjcSpvnMU6z35UWAfx6k3CxGEki0N+deMYqSFlVArHw=;
 b=dncO8dDQY17I15yAoQU7RBb5I9+WQ/iZ7wpSRdDwVWN/AKFlOvoelZG+zCARU9UKxlrNmRvi+76qAnM68cyrxm81JHkLKiD5I5fs+Kg6yyVvoq66AdK4FXjLEgvysa1BZSuqax6YOJrjlf0LBXcE/e2AN5Yk0YPIRFsSDgmF91EeJrZDiG+0xeEGJFKhyAtW87M7Bzdu4Wn5rp42tsfoYHSBtJaAbonH6zOmfebQvaMzjhCI3al6V7lqvynUTe37WI7ZaRZU1yvpAkOnI7psa4jdQldrkGsWfACjxITl0JXsKUUBLkLbIQ8gZQA/H41blvj+swLlnv8BB9Z0Jj7AYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wjcSpvnMU6z35UWAfx6k3CxGEki0N+deMYqSFlVArHw=;
 b=z1abNKChQV+Q5YFBSGzI/C1pWz6rl0E+2FvDcsxcWxnx+qOc0tLt51INl5PRNVpddMwWF2VVqEcNGpO2a3QNzn5v1Jo0D0qT0Q4Ob2dfCbfKPG+yvnNnWbncwvH555k75wk2AutRxun18WD9s2C4L0OstIOazbeWZ5NoY0WyBTM=
Received: from BY5PR17CA0032.namprd17.prod.outlook.com (2603:10b6:a03:1b8::45)
 by SJ2PR12MB8158.namprd12.prod.outlook.com (2603:10b6:a03:4f7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Fri, 7 Feb
 2025 00:06:45 +0000
Received: from SJ5PEPF000001ED.namprd05.prod.outlook.com
 (2603:10b6:a03:1b8:cafe::d2) by BY5PR17CA0032.outlook.office365.com
 (2603:10b6:a03:1b8::45) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.22 via Frontend Transport; Fri,
 7 Feb 2025 00:06:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001ED.mail.protection.outlook.com (10.167.242.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Fri, 7 Feb 2025 00:06:45 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 6 Feb
 2025 18:06:44 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 6 Feb
 2025 18:06:43 -0600
Received: from xcbecree42x.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Thu, 6 Feb 2025 18:06:42 -0600
From: <edward.cree@amd.com>
To: <linux-net-drivers@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>, <horms@kernel.org>,
	<andrew+netdev@lunn.ch>
CC: Edward Cree <ecree.xilinx@gmail.com>, <habetsm.xilinx@gmail.com>,
	<jiri@resnulli.us>, <netdev@vger.kernel.org>
Subject: [PATCH net-next 1/4] sfc: parse headers of devlink flash images
Date: Fri, 7 Feb 2025 00:06:01 +0000
Message-ID: <65318300f3f1b1462925f917f7c0d0ac833955ae.1738881614.git.ecree.xilinx@gmail.com>
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
Received-SPF: None (SATLEXMB05.amd.com: edward.cree@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001ED:EE_|SJ2PR12MB8158:EE_
X-MS-Office365-Filtering-Correlation-Id: 40918102-f7a0-4636-6bc3-08dd470b4f09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ASuX4UK7PJSUZJIFRf1iFHrBp+lnrs5sQEfqAf+f2BprZk4Sf+Xd4rAvwbsM?=
 =?us-ascii?Q?GtGEKTqgaoCcgHzvTbyqhr2mUH5hJzxTbCYTVqQeYbGlBWDSoBBt2cn+0liM?=
 =?us-ascii?Q?xZIv12H4JjfgFwUwk9BrpCFUfUFT2vm2yFxMUhoBo+CuMpCgaEc6UPBwLQZ5?=
 =?us-ascii?Q?5dZYIVGa1GQBU5w0kBHh3TXZLuusE6vBl9P/v5LWVn8H9V280Sisz0esveB3?=
 =?us-ascii?Q?gSdeymh1Uol6CEdlVsXOwYX16RvoU7Jlt+uU6n6ak3TOFN2S8QAuGtyXoYG0?=
 =?us-ascii?Q?HcGXQjQesAlYWWk9scoSrcX5y8Dhx7pLpeRBRBDBT1D3RPFekvBT/6KkVCt1?=
 =?us-ascii?Q?enTdFRd3UMaQwtHXnluWoxu6HRI+Gys9DUV9VO6W574/DsaP51rwz3NWvc3G?=
 =?us-ascii?Q?swjM16EPb3aE0fflB3rHIOpc5gV/jxOpuUowQLs3ZjTmHNBvCuX/EgKqUPJ3?=
 =?us-ascii?Q?aXvBtN8iQkoFMXObufHZuzXHNSuRa279rnsPmqLbptljPSvjDvKcys+3h16y?=
 =?us-ascii?Q?7lEn4nxlcyxNhmuxxpMa6D8zevqorqUvcYogwtMZnIOpxc+nHqpTMoJbvP1q?=
 =?us-ascii?Q?cXJ/nvGqy40VAUVnN+8e7i2VWD/5oCE+AFdUXNF8uwaT9Nvs27UzgLBt5UiY?=
 =?us-ascii?Q?//34Y5qg5wYzXLMxitecBDfKENaxl3s926SxvvXh7TOrhG73D5zud7+ugMpn?=
 =?us-ascii?Q?qusjVdoX9ylLHad5RIbyX8tBrvaJnCjur0ADSeCnNNKhzxVVPs+8nEju07hk?=
 =?us-ascii?Q?bnb8EYK8WGGRUkONcxfnI5FvZO+miNdfsYbehsNbo6NUjpIbpb97bPd4Sq9k?=
 =?us-ascii?Q?D4sLTEgHqZiWkqpyZ09x0d6QPQTQI2PUvLJbLAZ2w85EBtnxmk9ICAOhVmOJ?=
 =?us-ascii?Q?Ls3Z0BHeQVb5/S1W2pt5ImA90nTcAgeI7GlcOb7hjh6KO+d/zROV3zo5R5Sy?=
 =?us-ascii?Q?mrgyheubrCW509bTPc3Cdsgl9V71A8LlEtBruzbTZVbQrF8LDZlQpKsh/u2N?=
 =?us-ascii?Q?KQ4sFaMA4Wpb3TbRSOy0pabqcUn/Yc1VV+JgrC4CwAFByYaU658gXpOFVQ7b?=
 =?us-ascii?Q?i9pv+AC4YkePmUu43EJGP6i7VIelS9yPbXbsUFQw1+ao3EMGxSjNYyDz0u30?=
 =?us-ascii?Q?fvL8nRA6eq5xbSvDUFuiWyu/4sWoQgWZrjgw3VpphyqQU/CBwmuaKZHnz3Ms?=
 =?us-ascii?Q?DpZmXdfWynNUgNs1kd7r71P2vRdKLZGRbPqXowfE9qCVaNZC+fQ2+zWObhSC?=
 =?us-ascii?Q?wmvCVSAwTmkW1KsFrAeNLX67jUpPmTKVO3ave1QpDWzt7OQOWCDbFqdsKF7D?=
 =?us-ascii?Q?N2Ush7zSNeRx7dUCdzIp9OPIRvbZ00zHkgPRQhBcSsFxxzYlMkswdRxQ9JO8?=
 =?us-ascii?Q?lmU30xs2nVv2k3zZF6m7M6VwsVZXqCmYZajF9oeiqABalmkYa4Gux1e8zfdB?=
 =?us-ascii?Q?bPjLZyr4z0cAHj0DcSqKRI4ciTJzhwjO9Yt0bux7vaFRifC/Pky8i3loGE+F?=
 =?us-ascii?Q?LlYR91WGPpjfy8Y=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 00:06:45.1145
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40918102-f7a0-4636-6bc3-08dd470b4f09
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8158

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

