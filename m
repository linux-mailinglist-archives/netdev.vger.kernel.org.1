Return-Path: <netdev+bounces-189316-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF4FAB196C
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 17:54:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DE3E9E1B70
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 15:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF472356A9;
	Fri,  9 May 2025 15:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TMF7j1NG"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98752233D91;
	Fri,  9 May 2025 15:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746806056; cv=fail; b=UMcVqWqjsyUaDL3LqNxzW5WB7D1EXXhYbV37PKlj4Qf6i8eUd/tNDL8VFznkTn9MNpSRU/XcZas0B7a7jp4qIkpcBb5ao3JPFaqMhCri2uGgVJu+zemtoqOubHwXwwTkP05H05vSdu7Z+iOcQiDauig1c+PHiYj934A3m9TXLKg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746806056; c=relaxed/simple;
	bh=upH+YjrvKrzdqDULqC5qnxjElnbz5p7hgHEN9PMwycU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MMzdBbnfDcaqyJ35K+BVX4jobHPip4RJ+f9zMw5ZsIJK9JE7uCzVdLLeTn5C11+W5uThZpPLdDEuKHaWqDxtVSvr23uV8SNha5+mR5wXW1FQanpl0qH+FZQy/oCvWCSFSEvdfUJgUw8KIBEx9bkK+L0sKMyliMWD4hAAZRuUu44=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TMF7j1NG; arc=fail smtp.client-ip=40.107.244.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MPw9kQQS8GppgNb8rQfB/InmqOf50urU5G8cz/2sBYHGBRbguHFccGXUWMqrH1CalVQ9pFT3Icdc0hhXlWJ5s/+Eii1RUAh5bAZ2F1kbFElAaztq/1po1SWIEaA8ON7pHkVQSVvSEyvn8Wo15QqTy9RZ/PtqEKq5EM3Rb3RcGJJ8NeJqAg4fn8OnrBT4LB1YjGH3oTwaGjbP4oWD1e+EGvzwUnEuhnhs48nYxVeO1fZIyBovD1znwhPYNHxCPwu3FBVH8BFKcieJlySBt+3sQkt7/smd7GhHuE0XXtzAGpK4fix6wQdoOdwNLkfBlpxwTQe93C7m5zPUVGwiHde4/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QuFrFFrqcVu5xCFcZWV9+ZKUK6boYGiow5zl/yxS5aw=;
 b=SpO3YFLsuzrQU4mOE8oMjutq8a/2ZnxKheYT9kLIC15gIhes6cOTUO71ipjDoTsDIPIXd8hQUyBDuNMNW+ux+QsU/FLHhfpLM+P6Lr+H75Ex7hNh11n56w1dyPgw6E9Zd05t9+U9RXUiD/BXkJ5ggbgfIhokZ5SjqJoEef9FP0Qt62ivLmDcvAHAOPC80H6+i5EoxN+O74lp/aSfSq9BT+ZaHk5+ayYlFPKwI4tzi4e/rA9O8FT59dfL+ebeKP6KcsexI20L+YkYom5+VOKv8Y+v6WY9GymQPEkKv2/GoG8VKAkn+ZiMkvHAqRJMKVM9A5Qc3oQYU4syZQHIGDApSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QuFrFFrqcVu5xCFcZWV9+ZKUK6boYGiow5zl/yxS5aw=;
 b=TMF7j1NGBvxx3HnLGzLk3HeGvi4NAk3an6NdHcon4WgcuM14SWUtkoHsCB7YlWeVNshxIiP01KL/iJ+aWJ4ZPoLLH50yvsymHNDIGpfb1Lzm9LKjNCybwaqPFlf5ttxc4nR14iEePELKSSsznfLCqqVKweiF2BnwHSlMu6IMvpg=
Received: from SJ0PR05CA0169.namprd05.prod.outlook.com (2603:10b6:a03:339::24)
 by PH7PR12MB9224.namprd12.prod.outlook.com (2603:10b6:510:2e7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.22; Fri, 9 May
 2025 15:54:10 +0000
Received: from SJ5PEPF000001CD.namprd05.prod.outlook.com
 (2603:10b6:a03:339:cafe::3d) by SJ0PR05CA0169.outlook.office365.com
 (2603:10b6:a03:339::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.19 via Frontend Transport; Fri,
 9 May 2025 15:54:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001CD.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Fri, 9 May 2025 15:54:10 +0000
Received: from airavat.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 9 May
 2025 10:54:06 -0500
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <horms@kernel.org>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<Shyam-sundar.S-k@amd.com>, Raju Rangoju <Raju.Rangoju@amd.com>, "Sudheesh
 Mavila" <sudheesh.mavila@amd.com>
Subject: [PATCH net-next v3 3/5] amd-xgbe: add support for new XPCS routines
Date: Fri, 9 May 2025 21:23:23 +0530
Message-ID: <20250509155325.720499-4-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250509155325.720499-1-Raju.Rangoju@amd.com>
References: <20250509155325.720499-1-Raju.Rangoju@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CD:EE_|PH7PR12MB9224:EE_
X-MS-Office365-Filtering-Correlation-Id: ad3191d3-6f7d-4332-fd88-08dd8f11bcd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qrRwVIpalZY01uutcHTyCxScY+6HsQsAoBY3HtBvBL3pc7im5l58qGUK3TZg?=
 =?us-ascii?Q?cxV6TW8cAtdOsloLGclHdpzhuMnnc03+z2hyH0pQExWtv9m+ufuRaLzHQYaf?=
 =?us-ascii?Q?v5p2f9NyZcN8q9lGdYjFrtQH2qfLZhtwZlNqeTvw2algQb8n5MGfIwsbfDeX?=
 =?us-ascii?Q?s3ystVWdZrDvX8hafTCx2SN65Dt8nstUHckeMGq2lDrwT0xrSPRt7HF7xluD?=
 =?us-ascii?Q?AVuLBBGEMih3tb3iS6wI2yPGO7aANJvALmzJG60x/Nr+WHYDek8y4wRJ1GIr?=
 =?us-ascii?Q?/X+NOWNzl2w4CFB0ZAAC4olhPYbBPA+I0HCaXUvA5vbHzZDja3/rPbJeLo9G?=
 =?us-ascii?Q?/okNTKUJt77v9rmrmoiADLYJBelBRSd/oPd3e0+RhsokZ2xwCZNJ3mE0Z1ev?=
 =?us-ascii?Q?IAL0tq4BBXYf6l3oZBLc1xQ+/AwpS5PdV63l+izfhAgPW4oJGd3a/6HBA8hU?=
 =?us-ascii?Q?0OCH9cZdwjEDhvk8THBYPg3vkOIkWU9CoHE02jXF3eRv6HNK495gXDkRsi1R?=
 =?us-ascii?Q?n2Hu3tfCMG7J8OWCvHdK5tU+nSg7GWORunGUCcXxirXERGjfPRXGGm1Etm3h?=
 =?us-ascii?Q?+XzmumfrMW6aUxGUA4u5aNR5+TF1gYx5/M7HOOPoEZDx0KmOmWAM7fQD9GDZ?=
 =?us-ascii?Q?tRaCJD25nPu2hsXgpjvVNHl6aP6wtDUX5zbRQks4mez/K2fUJCdm/Qxo2mon?=
 =?us-ascii?Q?sJrPHAPrdLoHlWlbakD6b5O3xcgsU68CLVd15RTLu60uxpOm6xVfDYuwfp60?=
 =?us-ascii?Q?dA3tGTIKlnT6XbBn5OoBev3V5mC7YOLSnydhcUOhqJetBhgpqgjTISjPl4j4?=
 =?us-ascii?Q?uI+1WjfX7xzGeP7xf43pNQjzq/xMiMg1af/e8Xjrp9g5kHTIOsxSfr/6ZhuQ?=
 =?us-ascii?Q?P9aCi+128jQhKvAf20Fb4xoeQU+nOSftcVG8oYRXVwll4E2ucUfp3yygzX3S?=
 =?us-ascii?Q?f5t2Z4O2BXR2VB8y4qyvJsXmpTm8byBAYT1WGDOj8x59/7moO2hJ3iK7V969?=
 =?us-ascii?Q?3xj1xYw7gdn0DotxRAs5hnRhXedNvAdbxf8WzE6o+5LwGuq0Jzdw14cj8sFa?=
 =?us-ascii?Q?YWNkpmiv8U0N0tuYO0jlM8kAhvr7t6KlELCEGWo5g6dW95IS9oZeoAdXWWm4?=
 =?us-ascii?Q?t+mDIbg0ySRkOs/Ljji/HF9IA20MaOoMPjlq8hb95lnsracHNHyAtddoTLAp?=
 =?us-ascii?Q?0exDoA4IfdhYKn8BHiNrj5tQpXb8grmj817S2Ho0engG3c/0EMdoYv4fmmTk?=
 =?us-ascii?Q?3DZYSm4l2+CZFB2xJxT9mweorDJmc6e20Rj99p/m+0PwIJR3GP3rBr3OtC3t?=
 =?us-ascii?Q?f4oOIPUeCzJk319HOiNlyS+m5Xrbf5Huqi5gU2hR6QQ2d6qvTtb0pEiJAzOi?=
 =?us-ascii?Q?AvmuBGtI2cJhlkx3B2rpXKGfkn4vYWFLqJtsVLVlZ9g7rjPx5sxltr99oBGP?=
 =?us-ascii?Q?8GdDuLJcZzrWAsrQHwMCDDE+vEZnTEl/Oi7j6UjmKg6irfRKyfpxVsA8H32D?=
 =?us-ascii?Q?mSah/Ie3mlgyvdUceLuTLcBPYYQoZYSiK5vR?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 15:54:10.0070
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad3191d3-6f7d-4332-fd88-08dd8f11bcd0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9224

Add the necessary support to enable Renoir ethernet device. Since the
BAR1 address cannot be used to access the XPCS registers on Renoir, use
the smn functions.

Some of the ethernet add-in-cards have dual PHY but share a single MDIO
line (between the ports). In such cases, link inconsistencies are
noticed during the heavy traffic and during reboot stress tests. Using
smn calls helps avoid such race conditions.

Suggested-by: Sudheesh Mavila <sudheesh.mavila@amd.com>
Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
Changes since v2:
- include linux/pci.h in xgbe-dev.c to ensure pci_err() is defined
- address Checkpatch warning "Improper SPDX comment style"
- line wrap to 80 columns wide
- use the correct device name Renoir instead of Crater

 drivers/net/ethernet/amd/xgbe/xgbe-dev.c | 86 ++++++++++++++++++++++++
 drivers/net/ethernet/amd/xgbe/xgbe-smn.h | 30 +++++++++
 drivers/net/ethernet/amd/xgbe/xgbe.h     |  6 ++
 3 files changed, 122 insertions(+)
 create mode 100644 drivers/net/ethernet/amd/xgbe/xgbe-smn.h

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
index cdab1c24dd69..466b5f6e5578 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
@@ -11,9 +11,11 @@
 #include <linux/bitrev.h>
 #include <linux/crc32.h>
 #include <linux/crc32poly.h>
+#include <linux/pci.h>
 
 #include "xgbe.h"
 #include "xgbe-common.h"
+#include "xgbe-smn.h"
 
 static inline unsigned int xgbe_get_max_frame(struct xgbe_prv_data *pdata)
 {
@@ -1080,6 +1082,84 @@ static void xgbe_get_pcs_index_and_offset(struct xgbe_prv_data *pdata,
 	*offset = pdata->xpcs_window + (mmd_address & pdata->xpcs_window_mask);
 }
 
+static int xgbe_read_mmd_regs_v3(struct xgbe_prv_data *pdata, int prtad,
+				 int mmd_reg)
+{
+	unsigned int mmd_address, index, offset;
+	u32 smn_address;
+	int mmd_data;
+	int ret;
+
+	mmd_address = xgbe_get_mmd_address(pdata, mmd_reg);
+
+	xgbe_get_pcs_index_and_offset(pdata, mmd_address, &index, &offset);
+
+	smn_address = pdata->smn_base + pdata->xpcs_window_sel_reg;
+	ret = amd_smn_write(0, smn_address, index);
+	if (ret)
+		return ret;
+
+	ret = amd_smn_read(0, pdata->smn_base + offset, &mmd_data);
+	if (ret)
+		return ret;
+
+	mmd_data = (offset % 4) ? FIELD_GET(XGBE_GEN_HI_MASK, mmd_data) :
+				  FIELD_GET(XGBE_GEN_LO_MASK, mmd_data);
+
+	return mmd_data;
+}
+
+static void xgbe_write_mmd_regs_v3(struct xgbe_prv_data *pdata, int prtad,
+				   int mmd_reg, int mmd_data)
+{
+	unsigned int pci_mmd_data, hi_mask, lo_mask;
+	unsigned int mmd_address, index, offset;
+	struct pci_dev *dev;
+	u32 smn_address;
+	int ret;
+
+	dev = pdata->pcidev;
+	mmd_address = xgbe_get_mmd_address(pdata, mmd_reg);
+
+	xgbe_get_pcs_index_and_offset(pdata, mmd_address, &index, &offset);
+
+	smn_address = pdata->smn_base + pdata->xpcs_window_sel_reg;
+	ret = amd_smn_write(0, smn_address, index);
+	if (ret) {
+		pci_err(dev, "Failed to write data 0x%x\n", index);
+		return;
+	}
+
+	ret = amd_smn_read(0, pdata->smn_base + offset, &pci_mmd_data);
+	if (ret) {
+		pci_err(dev, "Failed to read data\n");
+		return;
+	}
+
+	if (offset % 4) {
+		hi_mask = FIELD_PREP(XGBE_GEN_HI_MASK, mmd_data);
+		lo_mask = FIELD_GET(XGBE_GEN_LO_MASK, pci_mmd_data);
+	} else {
+		hi_mask = FIELD_PREP(XGBE_GEN_HI_MASK,
+				     FIELD_GET(XGBE_GEN_HI_MASK, pci_mmd_data));
+		lo_mask = FIELD_GET(XGBE_GEN_LO_MASK, mmd_data);
+	}
+
+	pci_mmd_data = hi_mask | lo_mask;
+
+	ret = amd_smn_write(0, smn_address, index);
+	if (ret) {
+		pci_err(dev, "Failed to write data 0x%x\n", index);
+		return;
+	}
+
+	ret = amd_smn_write(0, (pdata->smn_base + offset), pci_mmd_data);
+	if (ret) {
+		pci_err(dev, "Failed to write data 0x%x\n", pci_mmd_data);
+		return;
+	}
+}
+
 static int xgbe_read_mmd_regs_v2(struct xgbe_prv_data *pdata, int prtad,
 				 int mmd_reg)
 {
@@ -1174,6 +1254,9 @@ static int xgbe_read_mmd_regs(struct xgbe_prv_data *pdata, int prtad,
 	case XGBE_XPCS_ACCESS_V2:
 	default:
 		return xgbe_read_mmd_regs_v2(pdata, prtad, mmd_reg);
+
+	case XGBE_XPCS_ACCESS_V3:
+		return xgbe_read_mmd_regs_v3(pdata, prtad, mmd_reg);
 	}
 }
 
@@ -1184,6 +1267,9 @@ static void xgbe_write_mmd_regs(struct xgbe_prv_data *pdata, int prtad,
 	case XGBE_XPCS_ACCESS_V1:
 		return xgbe_write_mmd_regs_v1(pdata, prtad, mmd_reg, mmd_data);
 
+	case XGBE_XPCS_ACCESS_V3:
+		return xgbe_write_mmd_regs_v3(pdata, prtad, mmd_reg, mmd_data);
+
 	case XGBE_XPCS_ACCESS_V2:
 	default:
 		return xgbe_write_mmd_regs_v2(pdata, prtad, mmd_reg, mmd_data);
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-smn.h b/drivers/net/ethernet/amd/xgbe/xgbe-smn.h
new file mode 100644
index 000000000000..3fd03d39c18a
--- /dev/null
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-smn.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-3-Clause) */
+/*
+ * Copyright (c) 2014-2025, Advanced Micro Devices, Inc.
+ * Copyright (c) 2014, Synopsys, Inc.
+ * All rights reserved
+ *
+ * Author: Raju Rangoju <Raju.Rangoju@amd.com>
+ */
+
+#ifndef __SMN_H__
+#define __SMN_H__
+
+#ifdef CONFIG_AMD_NB
+
+#include <asm/amd_nb.h>
+
+#else
+
+static inline int amd_smn_write(u16 node, u32 address, u32 value)
+{
+	return -ENODEV;
+}
+
+static inline int amd_smn_read(u16 node, u32 address, u32 *value)
+{
+	return -ENODEV;
+}
+
+#endif
+#endif
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe.h b/drivers/net/ethernet/amd/xgbe/xgbe.h
index 37e5f8fad6b2..44ba6b02cdeb 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe.h
+++ b/drivers/net/ethernet/amd/xgbe/xgbe.h
@@ -242,6 +242,10 @@
 #define XGBE_RV_PCI_DEVICE_ID	0x15d0
 #define XGBE_YC_PCI_DEVICE_ID	0x14b5
 
+ /* Generic low and high masks */
+#define XGBE_GEN_HI_MASK	GENMASK(31, 16)
+#define XGBE_GEN_LO_MASK	GENMASK(15, 0)
+
 struct xgbe_prv_data;
 
 struct xgbe_packet_data {
@@ -460,6 +464,7 @@ enum xgbe_speed {
 enum xgbe_xpcs_access {
 	XGBE_XPCS_ACCESS_V1 = 0,
 	XGBE_XPCS_ACCESS_V2,
+	XGBE_XPCS_ACCESS_V3,
 };
 
 enum xgbe_an_mode {
@@ -955,6 +960,7 @@ struct xgbe_prv_data {
 	struct device *dev;
 	struct platform_device *phy_platdev;
 	struct device *phy_dev;
+	unsigned int smn_base;
 
 	/* Version related data */
 	struct xgbe_version_data *vdata;
-- 
2.34.1


